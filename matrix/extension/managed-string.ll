; ModuleID = 'string_build'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.x = internal constant [2 x i8] c"x\00"
@.const.y = internal constant [2 x i8] c"y\00"
@.const.z = internal constant [2 x i8] c"z\00"
@".const.<%f, %f, %f>" = internal constant [13 x i8] c"<%f, %f, %f>\00"
@".const.managed result allocation failed" = internal constant [33 x i8] c"managed result allocation failed\00"
@.const.string_build = internal constant [13 x i8] c"string_build\00"
@_ZN08NumbaEnv7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE" = internal constant [129 x i8] c"missing Environment: _ZN08NumbaEnv7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE\00"
@PyExc_MemoryError = external global i8
@".const.managed object allocation failed" = internal constant [33 x i8] c"managed object allocation failed\00"
@PyExc_RuntimeError = external global i8
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"

define range(i32 -1, 1) i32 @_ZN7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readonly captures(none) %arg.a.0) local_unnamed_addr {
B0:
  %.5.i = getelementptr i8, ptr %arg.a.0, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  %.43 = tail call ptr @PyObject_GetAttrString(ptr %.6.i, ptr nonnull @.const.x)
  %.45 = icmp eq ptr %.43, null
  br i1 %.45, label %common.ret.critedge, label %B0.endif, !prof !0

common.ret.critedge:                              ; preds = %B0.endif.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.endif, %B0.endif.endif.endif, %B0.endif.endif, %B0.endif, %B0, %B0.endif.endif.endif.endif.endif
  %.13.0.ph = phi ptr [ null, %B0.endif.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.endif.endif ], [ %.43, %B0.endif.endif.endif ], [ %.43, %B0.endif.endif ], [ %.43, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif.endif.endif.endif ]
  %.16.0.ph = phi ptr [ null, %B0.endif.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.endif.endif ], [ %.48, %B0.endif.endif.endif ], [ %.48, %B0.endif.endif ], [ null, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif.endif.endif.endif ]
  %.19.0.ph = phi ptr [ null, %B0.endif.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.endif.endif ], [ %.53, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ null, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif.endif.endif.endif ]
  %.22.0.ph = phi ptr [ %.58, %B0.endif.endif.endif.endif.endif.endif.if ], [ %.58, %B0.endif.endif.endif.endif ], [ null, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ null, %B0.endif ], [ null, %B0 ], [ %.58, %B0.endif.endif.endif.endif.endif ]
  %.25.0.ph = phi ptr [ %.72, %B0.endif.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.endif.endif ], [ null, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ null, %B0.endif ], [ null, %B0 ], [ %.72, %B0.endif.endif.endif.endif.endif ]
  %.28.0.ph = phi ptr [ %.77, %B0.endif.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.endif.endif ], [ null, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ null, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif.endif.endif.endif ]
  tail call void @Py_DecRef(ptr %.28.0.ph)
  tail call void @Py_DecRef(ptr %.25.0.ph)
  tail call void @Py_DecRef(ptr %.22.0.ph)
  tail call void @Py_DecRef(ptr %.19.0.ph)
  tail call void @Py_DecRef(ptr %.16.0.ph)
  tail call void @Py_DecRef(ptr %.13.0.ph)
  br label %common.ret

common.ret:                                       ; preds = %common.ret.critedge, %string.cleanup
  %common.ret.op = phi i32 [ 0, %string.cleanup ], [ -1, %common.ret.critedge ]
  ret i32 %common.ret.op

string.cleanup:                                   ; preds = %B0.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.72)
  tail call void @Py_DecRef(ptr nonnull %.58)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr null)
  store ptr %.82, ptr %retptr, align 8
  br label %common.ret

B0.endif:                                         ; preds = %B0
  %.48 = tail call ptr @PyObject_GetAttrString(ptr %.6.i, ptr nonnull @.const.y)
  %.50 = icmp eq ptr %.48, null
  br i1 %.50, label %common.ret.critedge, label %B0.endif.endif, !prof !0

B0.endif.endif:                                   ; preds = %B0.endif
  %.53 = tail call ptr @PyObject_GetAttrString(ptr %.6.i, ptr nonnull @.const.z)
  %.55 = icmp eq ptr %.53, null
  br i1 %.55, label %common.ret.critedge, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.endif:                             ; preds = %B0.endif.endif
  %.58 = tail call ptr (i64, ...) @PyTuple_Pack(i64 3, ptr nonnull %.43, ptr nonnull %.48, ptr nonnull %.53)
  %.60 = icmp eq ptr %.58, null
  br i1 %.60, label %common.ret.critedge, label %B0.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif:                       ; preds = %B0.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.43)
  tail call void @Py_DecRef(ptr nonnull %.48)
  tail call void @Py_DecRef(ptr nonnull %.53)
  %.72 = tail call ptr @PyUnicode_FromString(ptr nonnull @".const.<%f, %f, %f>")
  %.74 = icmp eq ptr %.72, null
  br i1 %.74, label %common.ret.critedge, label %B0.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif
  %.77 = tail call ptr @PyNumber_Remainder(ptr nonnull %.72, ptr nonnull %.58)
  %.79 = icmp eq ptr %.77, null
  br i1 %.79, label %common.ret.critedge, label %B0.endif.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif.endif:           ; preds = %B0.endif.endif.endif.endif.endif
  %.82 = tail call ptr @NRT_meminfo_new_from_pyobject(ptr nonnull %.77, ptr nonnull %.77)
  %.83 = icmp eq ptr %.82, null
  tail call void @Py_DecRef(ptr nonnull %.77)
  br i1 %.83, label %B0.endif.endif.endif.endif.endif.endif.if, label %string.cleanup, !prof !0

B0.endif.endif.endif.endif.endif.endif.if:        ; preds = %B0.endif.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed result allocation failed")
  br label %common.ret.critedge
}

declare ptr @PyObject_GetAttrString(ptr, ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare ptr @PyNumber_Remainder(ptr, ptr) local_unnamed_addr

declare noalias ptr @NRT_meminfo_new_from_pyobject(ptr captures(none), ptr captures(none)) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

define ptr @_ZN7cpython7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.string_build, i64 1, i64 1, ptr nonnull %.5)
  %.7 = icmp eq i32 %.6, 0
  %.37 = alloca { ptr }, align 8
  br i1 %.7, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif, %entry, %entry.endif.endif.endif.endif.if.endif, %entry.endif.if, %entry.endif.endif.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.if ], [ null, %entry.endif.if ], [ null, %entry ], [ %.6.i, %entry.endif.endif.endif.endif.if.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.11 = load ptr, ptr @_ZN08NumbaEnv7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE, align 8
  %.14 = icmp eq ptr %.11, null
  br i1 %.14, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE")
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
  %.41 = call i32 @_ZN7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.37, ptr nonnull poison, ptr nonnull %.22) #0
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

define { ptr } @cfunc._ZN7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE({ ptr } %.1) local_unnamed_addr {
entry:
  %.3 = alloca { ptr }, align 8
  store ptr null, ptr %.3, align 8
  %extracted.meminfo = extractvalue { ptr } %.1, 0
  %.7 = call i32 @_ZN7managed12string_buildB2v1B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.3, ptr nonnull poison, ptr %extracted.meminfo) #0
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
