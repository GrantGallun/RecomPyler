; ModuleID = 'f0_fibonacci'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_fibonacci = internal constant [13 x i8] c"f0_fibonacci\00"
@_ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx" = internal constant [260 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx\00"
@PyExc_TypeError = external global i8
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@PyExc_RuntimeError = external global i8

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: write)
define noundef i32 @_ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr readnone captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_n) local_unnamed_addr #0 {
B0.endif:
  %.15246.not = icmp slt i64 %arg.v_n, 1
  br i1 %.15246.not, label %B98, label %B50.preheader

B50.preheader:                                    ; preds = %B0.endif
  %xtraiter = and i64 %arg.v_n, 7
  %0 = icmp ult i64 %arg.v_n, 8
  br i1 %0, label %B50.epil.preheader, label %B50.preheader.new

B50.preheader.new:                                ; preds = %B50.preheader
  %unroll_iter = and i64 %arg.v_n, 9223372036854775800
  br label %B50

B50:                                              ; preds = %B50, %B50.preheader.new
  %lsr.iv3 = phi i64 [ %lsr.iv.next4, %B50 ], [ %unroll_iter, %B50.preheader.new ]
  %v_b.2.050 = phi i64 [ 1, %B50.preheader.new ], [ %.192.7, %B50 ]
  %v_a.2.049 = phi i64 [ 0, %B50.preheader.new ], [ %.192.6, %B50 ]
  %.192 = add i64 %v_a.2.049, %v_b.2.050
  %.192.1 = add i64 %v_b.2.050, %.192
  %.192.2 = add i64 %.192, %.192.1
  %.192.3 = add i64 %.192.1, %.192.2
  %.192.4 = add i64 %.192.2, %.192.3
  %.192.5 = add i64 %.192.3, %.192.4
  %.192.6 = add i64 %.192.4, %.192.5
  %.192.7 = add i64 %.192.5, %.192.6
  %lsr.iv.next4 = add nsw i64 %lsr.iv3, -8
  %niter.ncmp.7.not = icmp eq i64 %lsr.iv.next4, 0
  br i1 %niter.ncmp.7.not, label %B98.loopexit.unr-lcssa, label %B50

B98.loopexit.unr-lcssa:                           ; preds = %B50
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %B98, label %B50.epil.preheader

B50.epil.preheader:                               ; preds = %B98.loopexit.unr-lcssa, %B50.preheader
  %v_b.2.050.epil.init = phi i64 [ 1, %B50.preheader ], [ %.192.7, %B98.loopexit.unr-lcssa ]
  %v_a.2.049.epil.init = phi i64 [ 0, %B50.preheader ], [ %.192.6, %B98.loopexit.unr-lcssa ]
  br label %B50.epil

B50.epil:                                         ; preds = %B50.epil, %B50.epil.preheader
  %lsr.iv = phi i64 [ %lsr.iv.next, %B50.epil ], [ %xtraiter, %B50.epil.preheader ]
  %v_b.2.050.epil = phi i64 [ %.192.epil, %B50.epil ], [ %v_b.2.050.epil.init, %B50.epil.preheader ]
  %v_a.2.049.epil = phi i64 [ %v_b.2.050.epil, %B50.epil ], [ %v_a.2.049.epil.init, %B50.epil.preheader ]
  %.192.epil = add i64 %v_a.2.049.epil, %v_b.2.050.epil
  %lsr.iv.next = add nsw i64 %lsr.iv, -1
  %epil.iter.cmp.not = icmp eq i64 %lsr.iv.next, 0
  br i1 %epil.iter.cmp.not, label %B98, label %B50.epil, !llvm.loop !0

B98:                                              ; preds = %B50.epil, %B98.loopexit.unr-lcssa, %B0.endif
  %v_a.2.0.lcssa = phi i64 [ 0, %B0.endif ], [ %.192.6, %B98.loopexit.unr-lcssa ], [ %v_b.2.050.epil, %B50.epil ]
  store i64 %v_a.2.0.lcssa, ptr %retptr, align 8
  ret i32 0
}

define ptr @_ZN7cpython32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.f0_fibonacci, i64 5, i64 5, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9)
  %.11 = icmp eq i32 %.10, 0
  %.23 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.46 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.69 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.92 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.130 = alloca i64, align 8
  br i1 %.11, label %common.ret, label %entry.endif, !prof !2

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %arg0.err, %entry, %entry.endif.endif.endif.e...endif.endif.endif.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %arg0.err ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.thread ], [ %.171, %entry.endif.endif.endif.e...endif.endif.endif.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.15 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, align 8
  %.18 = icmp eq ptr %.15, null
  br i1 %.18, label %entry.endif.if, label %entry.endif.endif, !prof !2

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx")
  br label %common.ret

entry.endif.endif:                                ; preds = %entry.endif
  %.22 = load ptr, ptr %.5, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.23, i8 0, i64 56, i1 false)
  %.27 = call i32 @NRT_adapt_ndarray_from_python(ptr %.22, ptr nonnull %.23)
  %sunkaddr = getelementptr inbounds i8, ptr %.23, i64 24
  %.31 = load i64, ptr %sunkaddr, align 8
  %.32 = icmp ne i64 %.31, 8
  %.33 = icmp ne i32 %.27, 0
  %.34 = or i1 %.33, %.32
  br i1 %.34, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !2

entry.endif.endif.endif.thread:                   ; preds = %entry.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif
  %.38.fca.0.load = load ptr, ptr %.23, align 8
  %.45 = load ptr, ptr %.6, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.46, i8 0, i64 56, i1 false)
  %.50 = call i32 @NRT_adapt_ndarray_from_python(ptr %.45, ptr nonnull %.46)
  %sunkaddr1 = getelementptr inbounds i8, ptr %.46, i64 24
  %.54 = load i64, ptr %sunkaddr1, align 8
  %.55 = icmp ne i64 %.54, 8
  %.56 = icmp ne i32 %.50, 0
  %.57 = or i1 %.56, %.55
  br i1 %.57, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !2

arg0.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.thread, %arg1.err
  call void @NRT_decref(ptr %.38.fca.0.load)
  br label %common.ret

entry.endif.endif.endif.endif.endif.thread:       ; preds = %entry.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif
  %.61.fca.0.load = load ptr, ptr %.46, align 8
  %.68 = load ptr, ptr %.7, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.69, i8 0, i64 56, i1 false)
  %.73 = call i32 @NRT_adapt_ndarray_from_python(ptr %.68, ptr nonnull %.69)
  %sunkaddr2 = getelementptr inbounds i8, ptr %.69, i64 24
  %.77 = load i64, ptr %sunkaddr2, align 8
  %.78 = icmp ne i64 %.77, 8
  %.79 = icmp ne i32 %.73, 0
  %.80 = or i1 %.79, %.78
  br i1 %.80, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !2

arg1.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.thread, %arg2.err
  call void @NRT_decref(ptr %.61.fca.0.load)
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg1.err

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  %.84.fca.0.load = load ptr, ptr %.69, align 8
  %.91 = load ptr, ptr %.8, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.92, i8 0, i64 56, i1 false)
  %.96 = call i32 @NRT_adapt_ndarray_from_python(ptr %.91, ptr nonnull %.92)
  %sunkaddr3 = getelementptr inbounds i8, ptr %.92, i64 24
  %.100 = load i64, ptr %sunkaddr3, align 8
  %.101 = icmp ne i64 %.100, 1
  %.102 = icmp ne i32 %.96, 0
  %.103 = or i1 %.102, %.101
  br i1 %.103, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !2

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.84.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.107.fca.0.load = load ptr, ptr %.92, align 8
  %.114 = load ptr, ptr %.9, align 8
  %.117 = call ptr @PyNumber_Long(ptr %.114)
  %.118.not = icmp eq ptr %.117, null
  br i1 %.118.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !2

arg3.err:                                         ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  call void @NRT_decref(ptr %.107.fca.0.load)
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif.if:       ; preds = %entry.endif.endif.endif.e...endif.endif
  %.120 = call i64 @PyLong_AsLongLong(ptr nonnull %.117)
  call void @Py_DecRef(ptr nonnull %.117)
  br label %entry.endif.endif.endif.e...endif.endif.endif

entry.endif.endif.endif.e...endif.endif.endif:    ; preds = %entry.endif.endif.endif.e...endif.endif.if, %entry.endif.endif.endif.e...endif.endif
  %.115.0 = phi i64 [ %.120, %entry.endif.endif.endif.e...endif.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.endif ]
  %.125 = call ptr @PyErr_Occurred()
  %.126.not = icmp eq ptr %.125, null
  br i1 %.126.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !3

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  store i64 0, ptr %.130, align 8
  %.142 = call i32 @_ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr nonnull %.130, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.115.0) #3
  %.152 = load i64, ptr %.130, align 8
  call void @NRT_decref(ptr %.38.fca.0.load)
  call void @NRT_decref(ptr %.61.fca.0.load)
  call void @NRT_decref(ptr %.84.fca.0.load)
  call void @NRT_decref(ptr %.107.fca.0.load)
  %.171 = call ptr @PyLong_FromLongLong(i64 %.152)
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #1

declare i32 @NRT_adapt_ndarray_from_python(ptr captures(none), ptr captures(none)) local_unnamed_addr

declare ptr @PyNumber_Long(ptr) local_unnamed_addr

declare i64 @PyLong_AsLongLong(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyErr_Occurred() local_unnamed_addr

declare ptr @PyLong_FromLongLong(i64) local_unnamed_addr

; Function Attrs: nofree norecurse nosync nounwind memory(write, inaccessiblemem: none, target_mem0: none, target_mem1: none)
define i64 @cfunc._ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5) local_unnamed_addr #2 {
entry:
  %.7 = alloca i64, align 8
  store i64 0, ptr %.7, align 8
  %.19 = call i32 @_ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr nonnull %.7, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.5) #3
  %.29 = load i64, ptr %.7, align 8
  ret i64 %.29
}

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #3 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret1, label %.3.endif, !prof !2

common.ret1:                                      ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret1, !prof !2

.3.endif.if:                                      ; preds = %.3.endif
  fence acquire
  tail call void @NRT_MemInfo_call_dtor(ptr nonnull %.1)
  ret void
}

; Function Attrs: nounwind
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #4

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #5

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nofree norecurse nosync nounwind memory(write, inaccessiblemem: none, target_mem0: none, target_mem1: none) }
attributes #3 = { noinline }
attributes #4 = { nounwind }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable"}
!2 = !{!"branch_weights", i32 1, i32 99}
!3 = !{!"branch_weights", i32 99, i32 1}
