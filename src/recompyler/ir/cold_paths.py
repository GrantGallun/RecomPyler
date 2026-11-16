"""Shared frame publication and cold exits for one generated LLVM module.

Words are borrowed integers carrying the existing stackref bits. Publishing
never changes references; callers retain the canonical close/callback order.
"""
from llvmlite import ir


class FramePaths:
    def __init__(self,module,symbols,layout,nlocalsplus,*,frame_entry):
        self.module=module;self.symbols=symbols;self.layout=layout
        self.nlocalsplus=nlocalsplus;self.frame_entry=frame_entry
        self.syncs={};self.exit_function=None
        self.pointer=ir.IntType(8).as_pointer();self.word=ir.IntType(64)

    def _number(self,value):return ir.Constant(self.word,value)

    def _stack(self,builder,frame):
        locals_at=builder.gep(frame,[self._number(self.layout['locals_offset'])])
        return builder.gep(builder.bitcast(locals_at,self.word.as_pointer()),
                           [self._number(self.nlocalsplus)])

    def _sync(self,count):
        if count in self.syncs:return self.syncs[count]
        fn=ir.Function(self.module,ir.FunctionType(ir.VoidType(),
            [self.pointer]+[self.word]*count),'rc_ir_sync_'+str(count))
        fn.linkage='internal';fn.attributes.add('noinline');fn.attributes.add('nounwind')
        builder=ir.IRBuilder(fn.append_basic_block('entry'));frame=fn.args[0]
        stack=self._stack(builder,frame)
        for index,value in enumerate(fn.args[1:]):
            builder.store(value,builder.gep(stack,[self._number(index)]))
        position=builder.gep(frame,[self._number(self.layout['stackpointer_offset'])])
        builder.store(builder.gep(stack,[self._number(count)]),
                      builder.bitcast(position,self.word.as_pointer().as_pointer()))
        builder.ret_void();self.syncs[count]=fn
        return fn

    def publish(self,builder,frame,stack):
        return builder.call(self._sync(len(stack)),[frame]+list(stack))

    def bind(self,builder,frame,thread):
        """Allocate scalar exit state before the source CFG, not in its loops."""
        self.frame=frame;self.thread=thread
        self.state=[builder.alloca(kind,name='exit_'+name) for kind,name in
                    ((self.pointer,'destination'),(self.word,'pc'),
                     (self.word,'action'),(self.word,'argument'))]
        self.return_block=builder.function.append_basic_block('shared_side_exit')
        cold=ir.IRBuilder(self.return_block)
        prefix=[frame,thread] if self.frame_entry else [frame]
        result=cold.call(self._exit(),prefix+[cold.load(slot) for slot in self.state])
        cold.ret(result)

    def _exit(self):
        if self.exit_function is not None:return self.exit_function
        prefix=[self.pointer,self.pointer] if self.frame_entry else [self.pointer]
        fn=ir.Function(self.module,ir.FunctionType(self.pointer,
            prefix+[self.pointer,self.word,self.word,self.word]),'rc_ir_cold_exit')
        fn.linkage='internal';fn.attributes.add('noinline');fn.attributes.add('cold')
        builder=ir.IRBuilder(fn.append_basic_block('entry'));frame=fn.args[0]
        destination,pc,action,argument=fn.args[len(prefix):]
        with builder.if_then(builder.icmp_unsigned('==',action,self._number(1))):
            unbound=self.symbols.declare(self.module,'rc_ir_frame_unbound',ir.VoidType(),
                                         [self.pointer,self.word])
            builder.call(unbound,[frame,argument])
        if self.frame_entry:
            executor=builder.gep(fn.args[1],[self._number(self.layout['thread_executor_offset'])])
            builder.store(ir.Constant(self.pointer,None),builder.bitcast(executor,self.pointer.as_pointer()))
            builder.ret(destination)
        else:
            with builder.if_then(builder.icmp_unsigned('!=',destination,ir.Constant(self.pointer,None))):
                resume=self.symbols.declare(self.module,'rc_ir_frame_resume_python',self.pointer,[self.pointer])
                builder.ret(builder.call(resume,[frame]))
            status=ir.IntType(32)
            leave=self.symbols.declare(self.module,'rc_ir_frame_leave_raw',status,
                                       [self.pointer,status,self.word])
            builder.call(leave,[frame,ir.Constant(status,0),pc])
            builder.ret(ir.Constant(self.pointer,None))
        self.exit_function=fn
        return fn

    def _prepare(self,builder,stack,destination,pc,action,argument):
        # Consume stack SSA BEFORE the exit branch, while still in the loop.
        # Publishing only inside a per-guard cold block makes LCSSA quadratic.
        if stack is not None:self.publish(builder,self.frame,stack)
        for slot,value in zip(self.state,(destination,self._number(pc),
                                         self._number(action),self._number(argument))):
            builder.store(value,slot)

    def conditional(self,builder,condition,stack,destination,pc,*,action=0,argument=0):
        self._prepare(builder,stack,destination,pc,action,argument)
        continuation=builder.function.append_basic_block('side_exit_continue')
        builder.cbranch(condition,self.return_block,continuation)
        builder.position_at_end(continuation)

    def leave(self,builder,frame,thread,stack,destination,pc):
        assert frame is self.frame and thread is self.thread
        self._prepare(builder,stack,destination,pc,0,0)
        builder.branch(self.return_block)
