"""Diagnostic native counters. Never use instrumented timings for admission.

Call counts are helper invocations, not refcount mutations or heap allocations
inside a helper. Branch outcomes are observations, not semantic proofs.
"""
from contextlib import contextmanager
import ctypes
import dis
import hashlib
import marshal
import sys


class Counters:
    def __init__(self,code):
        self.file=code.co_filename;self.function=code.co_qualname;self.sites=[]
        try:self.code_sha256=hashlib.sha256(marshal.dumps(code)).hexdigest()
        except (ValueError,TypeError):self.code_sha256=None

    def emit(self,builder,kind,line,condition=None,detail='',*,original_pc=None):
        from llvmlite import ir
        counts=(ctypes.c_uint64*2)();word=ir.IntType(64)
        pointer=ir.Constant(word,ctypes.addressof(counts)).inttoptr(word.as_pointer())
        builder.store(builder.add(builder.load(pointer),ir.Constant(word,1)),pointer)
        if condition is not None:
            taken=builder.gep(pointer,[ir.Constant(word,1)])
            builder.store(builder.add(builder.load(taken),builder.zext(condition,word)),taken)
        self.sites.append((kind,line,detail,counts,condition is not None,original_pc,
                           str(condition) if condition is not None else None))

    def rows(self):
        return [dict(file=self.file,function=self.function,line=line,kind=kind,detail=detail,
                     code_sha256=self.code_sha256,graph_sha256=None,original_pc=pc,
                     site_index=index,predicate_llvm=predicate,
                     executed=counts[0],taken=counts[1] if conditional else None,
                     never_failed=counts[0]>0 and counts[1]==0 if kind=='guard' else None,
                     never_mattered=counts[0]>0 and counts[1]==counts[0] if kind=='refcount' and conditional else None,proof_required=True)
                for index,(kind,line,detail,counts,conditional,pc,predicate) in enumerate(self.sites)]


@contextmanager
def instrument(code):
    """Instrument only this code's lower() in one isolated diagnostic process."""
    from llvmlite import ir
    counters=Counters(code);old_call=ir.IRBuilder.call;old_branch=ir.IRBuilder.cbranch
    from recompyler import _source_frames_native
    layout=_source_frames_native.layout()
    lines={i.offset:i.positions.lineno for i in dis.get_instructions(code)}
    def location():
        frame=sys._getframe(2);guard=False
        while frame:
            if frame.f_code.co_name=='fail_if': guard=True
            if frame.f_code.co_name=='lower' and frame.f_globals.get('__name__')=='recompyler.ir.lower_llvm':
                if frame.f_locals.get('code') is code:
                    offset=frame.f_locals.get('pc')
                    return lines.get(offset,code.co_firstlineno),guard,offset
                return None
            frame=frame.f_back
        return None
    def call(builder,fn,args,*pos,**kw):
        where=location()
        if where:
            name=getattr(fn,'name','indirect');line=where[0]
            counters.emit(builder,'c_call',line,detail=name,original_pc=where[2])
            if name in ('Py_IncRef','Py_DecRef') or any(x in name for x in ('word_close','word_dup','word_newref','word_xclose')):
                noop=None
                if name in ('rc_ir_frame_word_close','rc_ir_frame_word_dup'):
                    tag=ir.Constant(args[0].type,layout['tag_refcnt'])
                    noop=builder.icmp_unsigned('!=',builder.and_(args[0],tag),ir.Constant(args[0].type,0))
                counters.emit(builder,'refcount',line,noop,detail=name,original_pc=where[2])
            if any(x in name for x in ('_New','_From','build_list','build_tuple','build_map','build_set','make_function')):
                counters.emit(builder,'allocation_call',line,detail=name,original_pc=where[2])
        return old_call(builder,fn,args,*pos,**kw)
    def branch(builder,condition,true,false):
        where=location()
        if where: counters.emit(builder,'guard' if where[1] else 'branch',where[0],condition,original_pc=where[2])
        return old_branch(builder,condition,true,false)
    ir.IRBuilder.call=call;ir.IRBuilder.cbranch=branch
    try: yield counters
    finally: ir.IRBuilder.call=old_call;ir.IRBuilder.cbranch=old_branch
