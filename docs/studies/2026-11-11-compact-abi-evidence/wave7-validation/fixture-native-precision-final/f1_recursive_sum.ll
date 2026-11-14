; ModuleID = 'f1_recursive_sum_borrowed'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f1_recursive_sum_borrowed = internal constant [26 x i8] c"f1_recursive_sum_borrowed\00"
@_ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd" = internal constant [185 x i8] c"missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd\00"
@".const.can't unbox float64* type" = internal constant [26 x i8] c"can't unbox float64* type\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE10float64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8int64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8uint8_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v16B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_281_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v18B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_282_29 = common local_unnamed_addr global ptr null
@PyExc_TypeError = external global i8
@PyExc_RuntimeError = external global i8

define noundef range(i32 -1, -2) i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr.2, ptr noalias readnone captures(none) %excinfo.9, ptr %arg._heap_F.2, ptr %arg._heap_I.2, ptr %arg._heap_top.2, ptr %arg._heap_st.2, i64 %arg._heap_len.2, i64 %arg.v_depth.2, double %arg.v_value.2) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.534 = alloca double, align 8
  %.999 = alloca double, align 8
  %.192 = icmp slt i64 %arg.v_depth.2, 1
  br i1 %.192, label %common.ret, label %B114.endif

common.ret:                                       ; preds = %B632.endif, %B424, %B280.endif, %B114.endif, %B0.endif.endif.endif.endif, %B776, %B606, %B254
  %.1152.sink = phi double [ %.1152, %B776 ], [ 0.000000e+00, %B424 ], [ 0.000000e+00, %B606 ], [ 0.000000e+00, %B280.endif ], [ 0.000000e+00, %B114.endif ], [ 0.000000e+00, %B254 ], [ %arg.v_value.2, %B0.endif.endif.endif.endif ], [ 0.000000e+00, %B632.endif ]
  store double %.1152.sink, ptr %retptr.2, align 8
  ret i32 0

B172:                                             ; preds = %B114.endif
  %.341 = getelementptr i8, ptr %arg._heap_top.2, i64 8
  %.342 = load i64, ptr %.341, align 8
  %.343 = add nsw i64 %.342, 1
  store i64 %.343, ptr %.341, align 8
  %.432 = getelementptr i8, ptr %arg._heap_top.2, i64 16
  %.433 = load i64, ptr %.432, align 8
  %.434.not = icmp slt i64 %.342, %.433
  br i1 %.434.not, label %B280.endif, label %B254

B254:                                             ; preds = %B172
  store i8 1, ptr %arg._heap_st.2, align 1
  %.516 = getelementptr i8, ptr %arg._heap_top.2, i64 24
  store i64 1000004, ptr %.516, align 8
  br label %common.ret

B424:                                             ; preds = %B280.endif
  %sunkaddr = getelementptr i8, ptr %arg._heap_top.2, i64 8
  %.650 = load i64, ptr %sunkaddr, align 8
  %.651 = add nsw i64 %.650, -1
  store i64 %.651, ptr %sunkaddr, align 8
  %.745.pr = load i8, ptr %arg._heap_st.2, align 1
  %.20.i2 = add nsw i64 %arg.v_depth.2, -2
  %.746.not = icmp eq i8 %.745.pr, 0
  br i1 %.746.not, label %B524, label %common.ret

B524:                                             ; preds = %B424
  %sunkaddr37 = getelementptr i8, ptr %arg._heap_top.2, i64 8
  store i64 %.650, ptr %sunkaddr37, align 8
  %sunkaddr38 = getelementptr i8, ptr %arg._heap_top.2, i64 16
  %.896 = load i64, ptr %sunkaddr38, align 8
  %.897.not.not = icmp sgt i64 %.650, %.896
  br i1 %.897.not.not, label %B606, label %B632.endif

B606:                                             ; preds = %B524
  store i8 1, ptr %arg._heap_st.2, align 1
  %.979 = getelementptr i8, ptr %arg._heap_top.2, i64 24
  store i64 1000004, ptr %.979, align 8
  br label %common.ret

B776:                                             ; preds = %B632.endif
  %sunkaddr39 = getelementptr i8, ptr %arg._heap_top.2, i64 8
  %.1113 = load i64, ptr %sunkaddr39, align 8
  %.1114 = add nsw i64 %.1113, -1
  store i64 %.1114, ptr %sunkaddr39, align 8
  %.1152 = fadd double %.548, %.1013
  br label %common.ret

B114.endif:                                       ; preds = %B0.endif.endif.endif.endif
  %.20.i = add nsw i64 %arg.v_depth.2, -1
  %.282 = load i8, ptr %arg._heap_st.2, align 1
  %.283.not = icmp eq i8 %.282, 0
  br i1 %.283.not, label %B172, label %common.ret

B280.endif:                                       ; preds = %B172
  store double 0.000000e+00, ptr %.534, align 8
  %.538 = call i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr nonnull %.534, ptr nonnull poison, ptr %arg._heap_F.2, ptr %arg._heap_I.2, ptr nonnull %arg._heap_top.2, ptr nonnull %arg._heap_st.2, i64 %arg._heap_len.2, i64 %.20.i, double %arg.v_value.2)
  %.548 = load double, ptr %.534, align 8
  %.590 = load i8, ptr %arg._heap_st.2, align 1
  %.591.not = icmp eq i8 %.590, 0
  br i1 %.591.not, label %B424, label %common.ret

B632.endif:                                       ; preds = %B524
  store double 0.000000e+00, ptr %.999, align 8
  %.1003 = call i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr nonnull %.999, ptr nonnull poison, ptr %arg._heap_F.2, ptr %arg._heap_I.2, ptr nonnull %arg._heap_top.2, ptr nonnull %arg._heap_st.2, i64 %arg._heap_len.2, i64 %.20.i2, double %arg.v_value.2)
  %.1013 = load double, ptr %.999, align 8
  %.1065 = load i8, ptr %arg._heap_st.2, align 1
  %.1071.not = icmp eq i8 %.1065, 0
  br i1 %.1071.not, label %B776, label %common.ret
}

define noalias noundef ptr @_ZN7cpython26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = alloca ptr, align 8
  %.11 = alloca ptr, align 8
  %.12 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.f1_recursive_sum_borrowed, i64 7, i64 7, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9, ptr nonnull %.10, ptr nonnull %.11)
  %.13 = icmp eq i32 %.12, 0
  br i1 %.13, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry, %entry.endif.if, %entry.endif.endif.if
  ret ptr null

entry.endif:                                      ; preds = %entry
  %.17 = load ptr, ptr @_ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, align 8
  %.20 = icmp eq ptr %.17, null
  br i1 %.20, label %entry.endif.if, label %entry.endif.endif.if, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd")
  br label %common.ret

entry.endif.endif.if:                             ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox float64* type")
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

define double @cfunc._ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr %.1, ptr %.2, ptr %.3, ptr %.4, i64 %.5, i64 %.6, double %.7) local_unnamed_addr {
entry:
  %.9 = alloca double, align 8
  %.13 = call i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr nonnull %.9, ptr nonnull poison, ptr %.1, ptr %.2, ptr %.3, ptr %.4, i64 %.5, i64 %.6, double %.7) #0
  %.23 = load double, ptr %.9, align 8
  %.25 = alloca i32, align 4
  store i32 0, ptr %.25, align 4
  %cond = icmp eq i32 %.13, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !1

entry.if:                                         ; preds = %entry
  %.21 = icmp sgt i32 %.13, 0
  call void @numba_gil_ensure(ptr nonnull %.25)
  br i1 %.21, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.28
  ret double %.23

.28:                                              ; preds = %entry.if.endif, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.76 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.76)
  call void @Py_DecRef(ptr %.76)
  call void @numba_gil_release(ptr nonnull %.25)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  unreachable

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.13, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.28
  ]

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.28

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %.28
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare void @PyErr_SetNone(ptr) local_unnamed_addr

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #0 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret, label %.3.endif, !prof !0

common.ret:                                       ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret, !prof !0

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

!0 = !{!"branch_weights", i32 1, i32 99}
!1 = !{!"branch_weights", i32 49, i32 1}
