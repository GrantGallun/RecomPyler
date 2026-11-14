; ModuleID = 'adapter'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx = common local_unnamed_addr global ptr null
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_85f07cc79ec7251995a7229812f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx = common local_unnamed_addr global ptr null

define noundef range(i32 -1, -2) i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.fp, ptr readnone captures(none) %arg.ip, ptr readnone captures(none) %arg.tp, ptr readnone captures(none) %arg.sp, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.15246.not.i = icmp slt i64 %arg.x, 1
  br i1 %.15246.not.i, label %common.ret, label %B50.preheader.i

common.ret:                                       ; preds = %B50.epil.i, %B0.endif.endif.endif.endif, %B98.loopexit.unr-lcssa.i
  %v_a.2.0.lcssa.i = phi i64 [ 0, %B0.endif.endif.endif.endif ], [ %.192.6.i.lcssa, %B98.loopexit.unr-lcssa.i ], [ %v_b.2.050.epil.i, %B50.epil.i ]
  store i64 %v_a.2.0.lcssa.i, ptr %retptr, align 8
  ret i32 0

B50.preheader.i:                                  ; preds = %B0.endif.endif.endif.endif
  %xtraiter.i = and i64 %arg.x, 7
  %0 = icmp samesign ult i64 %arg.x, 8
  br i1 %0, label %B50.epil.i.preheader, label %B50.preheader.new.i

B50.preheader.new.i:                              ; preds = %B50.preheader.i
  %1 = add nsw i64 %arg.x, -8
  %2 = lshr i64 %1, 3
  %3 = add nuw nsw i64 %2, 1
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %B50.i.epil.preheader, label %B50.preheader.new.i.new

B50.preheader.new.i.new:                          ; preds = %B50.preheader.new.i
  %unroll_iter = and i64 %3, 4611686018427387902
  br label %B50.i

B50.i:                                            ; preds = %B50.i, %B50.preheader.new.i.new
  %lsr.iv = phi i64 [ %lsr.iv.next, %B50.i ], [ %unroll_iter, %B50.preheader.new.i.new ]
  %v_b.2.050.i = phi i64 [ 1, %B50.preheader.new.i.new ], [ %.192.7.i.1, %B50.i ]
  %v_a.2.049.i = phi i64 [ 0, %B50.preheader.new.i.new ], [ %.192.6.i.1, %B50.i ]
  %.192.i = add i64 %v_a.2.049.i, %v_b.2.050.i
  %.192.1.i = add i64 %.192.i, %v_b.2.050.i
  %.192.2.i = add i64 %.192.1.i, %.192.i
  %.192.3.i = add i64 %.192.2.i, %.192.1.i
  %.192.4.i = add i64 %.192.3.i, %.192.2.i
  %.192.5.i = add i64 %.192.4.i, %.192.3.i
  %.192.6.i = add i64 %.192.5.i, %.192.4.i
  %.192.7.i = add i64 %.192.6.i, %.192.5.i
  %.192.i.1 = add i64 %.192.6.i, %.192.7.i
  %.192.1.i.1 = add i64 %.192.i.1, %.192.7.i
  %.192.2.i.1 = add i64 %.192.1.i.1, %.192.i.1
  %.192.3.i.1 = add i64 %.192.2.i.1, %.192.1.i.1
  %.192.4.i.1 = add i64 %.192.3.i.1, %.192.2.i.1
  %.192.5.i.1 = add i64 %.192.4.i.1, %.192.3.i.1
  %.192.6.i.1 = add i64 %.192.5.i.1, %.192.4.i.1
  %.192.7.i.1 = add i64 %.192.6.i.1, %.192.5.i.1
  %lsr.iv.next = add i64 %lsr.iv, -2
  %niter.ncmp.1 = icmp eq i64 %lsr.iv.next, 0
  br i1 %niter.ncmp.1, label %B98.loopexit.unr-lcssa.i.unr-lcssa, label %B50.i

B98.loopexit.unr-lcssa.i.unr-lcssa:               ; preds = %B50.i
  %5 = and i64 %3, 1
  %lcmp.mod.not = icmp eq i64 %5, 0
  br i1 %lcmp.mod.not, label %B98.loopexit.unr-lcssa.i, label %B50.i.epil.preheader

B50.i.epil.preheader:                             ; preds = %B98.loopexit.unr-lcssa.i.unr-lcssa, %B50.preheader.new.i
  %v_b.2.050.i.epil.init = phi i64 [ 1, %B50.preheader.new.i ], [ %.192.7.i.1, %B98.loopexit.unr-lcssa.i.unr-lcssa ]
  %v_a.2.049.i.epil.init = phi i64 [ 0, %B50.preheader.new.i ], [ %.192.6.i.1, %B98.loopexit.unr-lcssa.i.unr-lcssa ]
  %.192.i.epil = add i64 %v_a.2.049.i.epil.init, %v_b.2.050.i.epil.init
  %.192.1.i.epil = add i64 %.192.i.epil, %v_b.2.050.i.epil.init
  %.192.2.i.epil = add i64 %.192.1.i.epil, %.192.i.epil
  %.192.3.i.epil = add i64 %.192.2.i.epil, %.192.1.i.epil
  %.192.4.i.epil = add i64 %.192.3.i.epil, %.192.2.i.epil
  %.192.5.i.epil = add i64 %.192.4.i.epil, %.192.3.i.epil
  %.192.6.i.epil = add i64 %.192.5.i.epil, %.192.4.i.epil
  %.192.7.i.epil = add i64 %.192.6.i.epil, %.192.5.i.epil
  br label %B98.loopexit.unr-lcssa.i

B98.loopexit.unr-lcssa.i:                         ; preds = %B98.loopexit.unr-lcssa.i.unr-lcssa, %B50.i.epil.preheader
  %.192.6.i.lcssa = phi i64 [ %.192.6.i.1, %B98.loopexit.unr-lcssa.i.unr-lcssa ], [ %.192.6.i.epil, %B50.i.epil.preheader ]
  %.192.7.i.lcssa = phi i64 [ %.192.7.i.1, %B98.loopexit.unr-lcssa.i.unr-lcssa ], [ %.192.7.i.epil, %B50.i.epil.preheader ]
  %lcmp.mod.not.i = icmp eq i64 %xtraiter.i, 0
  br i1 %lcmp.mod.not.i, label %common.ret, label %B50.epil.i.preheader

B50.epil.i.preheader:                             ; preds = %B98.loopexit.unr-lcssa.i, %B50.preheader.i
  %v_b.2.050.epil.i.ph = phi i64 [ 1, %B50.preheader.i ], [ %.192.7.i.lcssa, %B98.loopexit.unr-lcssa.i ]
  %v_a.2.049.epil.i.ph = phi i64 [ 0, %B50.preheader.i ], [ %.192.6.i.lcssa, %B98.loopexit.unr-lcssa.i ]
  br label %B50.epil.i

B50.epil.i:                                       ; preds = %B50.epil.i.preheader, %B50.epil.i
  %lsr.iv.i = phi i64 [ %lsr.iv.next.i, %B50.epil.i ], [ %xtraiter.i, %B50.epil.i.preheader ]
  %v_b.2.050.epil.i = phi i64 [ %.192.epil.i, %B50.epil.i ], [ %v_b.2.050.epil.i.ph, %B50.epil.i.preheader ]
  %v_a.2.049.epil.i = phi i64 [ %v_b.2.050.epil.i, %B50.epil.i ], [ %v_a.2.049.epil.i.ph, %B50.epil.i.preheader ]
  %.192.epil.i = add i64 %v_a.2.049.epil.i, %v_b.2.050.epil.i
  %lsr.iv.next.i = add nsw i64 %lsr.iv.i, -1
  %epil.iter.cmp.not.i = icmp eq i64 %lsr.iv.next.i, 0
  br i1 %epil.iter.cmp.not.i, label %common.ret, label %B50.epil.i, !llvm.loop !0
}

define i64 @cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr readnone captures(none) %.1, ptr readnone captures(none) %.2, ptr readnone captures(none) %.3, ptr readnone captures(none) %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %.14 = call i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr nonnull %.10, ptr nonnull poison, ptr poison, ptr poison, ptr poison, ptr poison, i64 %.5, i64 poison, i64 poison, i64 poison) #0
  %.24 = load i64, ptr %.10, align 8
  %.26 = alloca i32, align 4
  store i32 0, ptr %.26, align 4
  %cond = icmp eq i32 %.14, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !2

entry.if:                                         ; preds = %entry
  %.22 = icmp sgt i32 %.14, 0
  call void @numba_gil_ensure(ptr nonnull %.26)
  br i1 %.22, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.29
  ret i64 %.24

.29:                                              ; preds = %entry.if.endif, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.77 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.77)
  call void @Py_DecRef(ptr %.77)
  call void @numba_gil_release(ptr nonnull %.26)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  unreachable

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.14, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.29
  ]

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.29

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %.29
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare void @PyErr_SetNone(ptr) local_unnamed_addr

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #0 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret, label %.3.endif, !prof !3

common.ret:                                       ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret, !prof !3

.3.endif.if:                                      ; preds = %.3.endif
  fence acquire
  tail call void @NRT_MemInfo_call_dtor(ptr nonnull %.1)
  ret void
}

; Function Attrs: nounwind
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #1

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #2

attributes #0 = { noinline }
attributes #1 = { nounwind }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable"}
!2 = !{!"branch_weights", i32 49, i32 1}
!3 = !{!"branch_weights", i32 1, i32 99}
