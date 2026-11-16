; ModuleID = 'boxed'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.6749f8805a0c4078753d0f5a201b628313bd4646 = internal constant [40 x i8] c"\80\04\95\1D\00\00\00\00\00\00\00\8C\0Fwave17_charloop\94\8C\05boxed\94\93\94."
@.const.pickledata.6749f8805a0c4078753d0f5a201b628313bd4646.sha1 = internal constant [20 x i8] c"gI\F8\80Z\0C@xu=\0FZ \1Bb\83\13\BDFF"
@".const.managed bridge allocation failed" = internal constant [33 x i8] c"managed bridge allocation failed\00"
@.const.boxed = internal constant [6 x i8] c"boxed\00"
@_ZN08NumbaEnv6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE" = internal constant [120 x i8] c"missing Environment: _ZN08NumbaEnv6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE\00"
@PyExc_MemoryError = external global i8
@".const.managed object allocation failed" = internal constant [33 x i8] c"managed object allocation failed\00"
@PyExc_RuntimeError = external global i8
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"

define range(i32 -1, 1) i32 @_ZN6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readonly captures(none) %arg.a0.0) local_unnamed_addr {
B0:
  %.33 = tail call ptr @numba_unpickle(ptr nonnull @.const.pickledata.6749f8805a0c4078753d0f5a201b628313bd4646, i32 40, ptr nonnull @.const.pickledata.6749f8805a0c4078753d0f5a201b628313bd4646.sha1)
  %.35 = icmp eq ptr %.33, null
  br i1 %.35, label %common.ret.critedge, label %B0.endif, !prof !0

common.ret.critedge:                              ; preds = %B0.endif.endif.endif.if, %B0.endif, %B0, %B0.endif.endif
  %.9.0.ph = phi ptr [ %.45, %B0.endif.endif.endif.if ], [ null, %B0.endif ], [ null, %B0 ], [ %.45, %B0.endif.endif ]
  %.12.0.ph = phi ptr [ %.50, %B0.endif.endif.endif.if ], [ null, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif ]
  tail call void @Py_DecRef(ptr %.12.0.ph)
  tail call void @Py_DecRef(ptr %.9.0.ph)
  tail call void @Py_DecRef(ptr %.33)
  br label %common.ret

common.ret:                                       ; preds = %common.ret.critedge, %bridge.cleanup
  %common.ret.op = phi i32 [ 0, %bridge.cleanup ], [ -1, %common.ret.critedge ]
  ret i32 %common.ret.op

bridge.cleanup:                                   ; preds = %B0.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.45)
  tail call void @Py_DecRef(ptr nonnull %.33)
  store ptr %.55, ptr %retptr, align 8
  br label %common.ret

B0.endif:                                         ; preds = %B0
  %.5.i = getelementptr i8, ptr %arg.a0.0, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  %.45 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr %.6.i)
  %.47 = icmp eq ptr %.45, null
  br i1 %.47, label %common.ret.critedge, label %B0.endif.endif, !prof !0

B0.endif.endif:                                   ; preds = %B0.endif
  %.50 = tail call ptr @PyObject_Call(ptr nonnull %.33, ptr nonnull %.45, ptr null)
  %.52 = icmp eq ptr %.50, null
  br i1 %.52, label %common.ret.critedge, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.endif:                             ; preds = %B0.endif.endif
  %.55 = tail call ptr @NRT_meminfo_new_from_pyobject(ptr nonnull %.50, ptr nonnull %.50)
  %.56 = icmp eq ptr %.55, null
  tail call void @Py_DecRef(ptr nonnull %.50)
  br i1 %.56, label %B0.endif.endif.endif.if, label %bridge.cleanup, !prof !0

B0.endif.endif.endif.if:                          ; preds = %B0.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed bridge allocation failed")
  br label %common.ret.critedge
}

declare ptr @numba_unpickle(ptr, i32, ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyObject_Call(ptr, ptr, ptr) local_unnamed_addr

declare noalias ptr @NRT_meminfo_new_from_pyobject(ptr captures(none), ptr captures(none)) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

define ptr @_ZN7cpython6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.boxed, i64 1, i64 1, ptr nonnull %.5)
  %.7 = icmp eq i32 %.6, 0
  %.37 = alloca { ptr }, align 8
  br i1 %.7, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif, %entry, %entry.endif.endif.endif.endif.if.endif, %entry.endif.if, %entry.endif.endif.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.if ], [ null, %entry.endif.if ], [ null, %entry ], [ %.6.i, %entry.endif.endif.endif.endif.if.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.11 = load ptr, ptr @_ZN08NumbaEnv6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE, align 8
  %.14 = icmp eq ptr %.11, null
  br i1 %.14, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE")
  br label %common.ret

entry.endif.endif:                                ; preds = %entry.endif
  %.18 = load ptr, ptr %.5, align 8
  %.22 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.18, ptr %.18)
  %.27 = icmp eq ptr %.22, null
  br i1 %.27, label %entry.endif.endif.endif.if, label %entry.endif.endif.endif.endif, !prof !0

entry.endif.endif.endif.if:                       ; preds = %entry.endif.endif
  call void @Py_DecRef(ptr %.18)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif
  store ptr null, ptr %.37, align 8
  %.41 = call i32 @_ZN6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.37, ptr nonnull poison, ptr nonnull %.22) #0
  %.51.fca.0.load = load ptr, ptr %.37, align 8
  call void @NRT_decref(ptr nonnull %.22)
  %cond = icmp eq i32 %.41, 0
  br i1 %cond, label %entry.endif.endif.endif.endif.if.endif, label %common.ret, !prof !1

entry.endif.endif.endif.endif.if.endif:           ; preds = %entry.endif.endif.endif.endif
  %.5.i = getelementptr i8, ptr %.51.fca.0.load, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  call void @Py_IncRef(ptr %.6.i)
  call void @NRT_decref(ptr %.51.fca.0.load)
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @Py_IncRef(ptr) local_unnamed_addr

define { ptr } @cfunc._ZN6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE({ ptr } %.1) local_unnamed_addr {
entry:
  %.3 = alloca { ptr }, align 8
  store ptr null, ptr %.3, align 8
  %extracted.meminfo = extractvalue { ptr } %.1, 0
  %.7 = call i32 @_ZN6bridge5boxedB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.3, ptr nonnull poison, ptr %extracted.meminfo) #0
  %.17.fca.0.load = load ptr, ptr %.3, align 8
  %.20 = alloca i32, align 4
  store i32 0, ptr %.20, align 4
  %cond = icmp eq i32 %.7, 0
  br i1 %cond, label %common.ret, label %.23, !prof !1

common.ret:                                       ; preds = %entry, %.23
  %inserted.meminfo = insertvalue { ptr } undef, ptr %.17.fca.0.load, 0
  ret { ptr } %inserted.meminfo

.23:                                              ; preds = %entry
  call void @numba_gil_ensure(ptr nonnull %.20)
  %.71 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.71)
  call void @Py_DecRef(ptr %.71)
  call void @numba_gil_release(ptr nonnull %.20)
  br label %common.ret
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #0 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret1, label %.3.endif, !prof !0

common.ret1:                                      ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret1, !prof !0

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
