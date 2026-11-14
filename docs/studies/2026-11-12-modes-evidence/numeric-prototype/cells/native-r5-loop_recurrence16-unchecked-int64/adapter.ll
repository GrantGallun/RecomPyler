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
@_ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx = common local_unnamed_addr global ptr null

define noundef range(i32 -1, -2) i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.fp, ptr readnone captures(none) %arg.ip, ptr readnone captures(none) %arg.tp, ptr readnone captures(none) %arg.sp, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.15675.not.i = icmp slt i64 %arg.n, 1
  br i1 %.15675.not.i, label %common.ret, label %B40.preheader.i

common.ret:                                       ; preds = %B40.i, %B0.endif.endif.endif.endif
  %v_t.17.0.lcssa.i = phi i64 [ %arg.x, %B0.endif.endif.endif.endif ], [ %.258.i, %B40.i ]
  store i64 %v_t.17.0.lcssa.i, ptr %retptr, align 8
  ret i32 0

B40.preheader.i:                                  ; preds = %B0.endif.endif.endif.endif
  %0 = add nuw i64 %arg.n, 1
  br label %B40.i

B40.i:                                            ; preds = %B40.i, %B40.preheader.i
  %lsr.iv.i = phi i64 [ %0, %B40.preheader.i ], [ %lsr.iv.next.i, %B40.i ]
  %v_t.17.078.i = phi i64 [ %arg.x, %B40.preheader.i ], [ %.258.i, %B40.i ]
  %.196.i = mul i64 %v_t.17.078.i, %arg.y
  %.198.i = add i64 %.196.i, %arg.z
  %.200.i = mul i64 %.198.i, %arg.y
  %.202.i = add i64 %.200.i, %arg.z
  %.204.i = mul i64 %.202.i, %arg.y
  %.206.i = add i64 %.204.i, %arg.z
  %.208.i = mul i64 %.206.i, %arg.y
  %.210.i = add i64 %.208.i, %arg.z
  %.212.i = mul i64 %.210.i, %arg.y
  %.214.i = add i64 %.212.i, %arg.z
  %.216.i = mul i64 %.214.i, %arg.y
  %.218.i = add i64 %.216.i, %arg.z
  %.220.i = mul i64 %.218.i, %arg.y
  %.222.i = add i64 %.220.i, %arg.z
  %.224.i = mul i64 %.222.i, %arg.y
  %.226.i = add i64 %.224.i, %arg.z
  %.228.i = mul i64 %.226.i, %arg.y
  %.230.i = add i64 %.228.i, %arg.z
  %.232.i = mul i64 %.230.i, %arg.y
  %.234.i = add i64 %.232.i, %arg.z
  %.236.i = mul i64 %.234.i, %arg.y
  %.238.i = add i64 %.236.i, %arg.z
  %.240.i = mul i64 %.238.i, %arg.y
  %.242.i = add i64 %.240.i, %arg.z
  %.244.i = mul i64 %.242.i, %arg.y
  %.246.i = add i64 %.244.i, %arg.z
  %.248.i = mul i64 %.246.i, %arg.y
  %.250.i = add i64 %.248.i, %arg.z
  %.252.i = mul i64 %.250.i, %arg.y
  %.254.i = add i64 %.252.i, %arg.z
  %.256.i = mul i64 %.254.i, %arg.y
  %.258.i = add i64 %.256.i, %arg.z
  %lsr.iv.next.i = add i64 %lsr.iv.i, -1
  %.156.i = icmp samesign ugt i64 %lsr.iv.next.i, 1
  br i1 %.156.i, label %B40.i, label %common.ret
}

define i64 @cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr readnone captures(none) %.1, ptr readnone captures(none) %.2, ptr readnone captures(none) %.3, ptr readnone captures(none) %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %.14 = call i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr nonnull %.10, ptr nonnull poison, ptr poison, ptr poison, ptr poison, ptr poison, i64 %.5, i64 %.6, i64 %.7, i64 %.8) #0
  %.24 = load i64, ptr %.10, align 8
  %.26 = alloca i32, align 4
  store i32 0, ptr %.26, align 4
  %cond = icmp eq i32 %.14, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !0

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
  br i1 %.4, label %common.ret, label %.3.endif, !prof !1

common.ret:                                       ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret, !prof !1

.3.endif.if:                                      ; preds = %.3.endif
  fence acquire
  tail call void @NRT_MemInfo_call_dtor(ptr nonnull %.1)
  ret void
}

; Function Attrs: nounwind
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #1

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { noinline }
attributes #1 = { nounwind }

!0 = !{!"branch_weights", i32 49, i32 1}
!1 = !{!"branch_weights", i32 1, i32 99}
