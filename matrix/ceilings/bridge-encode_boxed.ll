; ModuleID = 'encode_boxed'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.1ce49e980560e622b917d0bf3d7785871e6753bf = internal constant [52 x i8] c"\80\04\95)\00\00\00\00\00\00\00\8C\14wave17_ceiling_bytes\94\8C\0Cencode_boxed\94\93\94."
@.const.pickledata.1ce49e980560e622b917d0bf3d7785871e6753bf.sha1 = internal constant [20 x i8] c"\1C\E4\9E\98\05`\E6\22\B9\17\D0\BF=w\85\87\1EgS\BF"
@".const.managed bridge allocation failed" = internal constant [33 x i8] c"managed bridge allocation failed\00"
@.const.encode_boxed = internal constant [13 x i8] c"encode_boxed\00"
@_ZN08NumbaEnv6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE" = internal constant [258 x i8] c"missing Environment: _ZN08NumbaEnv6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE\00"
@PyExc_MemoryError = external global i8
@".const.managed object allocation failed" = internal constant [33 x i8] c"managed object allocation failed\00"
@PyExc_RuntimeError = external global i8
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"

define range(i32 -1, 1) i32 @_ZN6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readonly captures(none) %arg.a0.0, ptr readonly captures(none) %arg.a1.0, ptr readonly captures(none) %arg.a2.0, ptr readonly captures(none) %arg.a3.0, ptr readonly captures(none) %arg.a4.0, ptr readonly captures(none) %arg.a5.0) local_unnamed_addr {
B0:
  %.43 = tail call ptr @numba_unpickle(ptr nonnull @.const.pickledata.1ce49e980560e622b917d0bf3d7785871e6753bf, i32 52, ptr nonnull @.const.pickledata.1ce49e980560e622b917d0bf3d7785871e6753bf.sha1)
  %.45 = icmp eq ptr %.43, null
  br i1 %.45, label %common.ret.critedge, label %B0.endif, !prof !0

common.ret.critedge:                              ; preds = %B0.endif.endif.endif.if, %B0.endif, %B0, %B0.endif.endif
  %.19.0.ph = phi ptr [ %.90, %B0.endif.endif.endif.if ], [ null, %B0.endif ], [ null, %B0 ], [ %.90, %B0.endif.endif ]
  %.22.0.ph = phi ptr [ %.95, %B0.endif.endif.endif.if ], [ null, %B0.endif ], [ null, %B0 ], [ null, %B0.endif.endif ]
  tail call void @Py_DecRef(ptr %.22.0.ph)
  tail call void @Py_DecRef(ptr %.19.0.ph)
  tail call void @Py_DecRef(ptr %.43)
  br label %common.ret

common.ret:                                       ; preds = %common.ret.critedge, %bridge.cleanup
  %common.ret.op = phi i32 [ 0, %bridge.cleanup ], [ -1, %common.ret.critedge ]
  ret i32 %common.ret.op

bridge.cleanup:                                   ; preds = %B0.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.90)
  tail call void @Py_DecRef(ptr nonnull %.43)
  store ptr %.100, ptr %retptr, align 8
  br label %common.ret

B0.endif:                                         ; preds = %B0
  %.5.i = getelementptr i8, ptr %arg.a0.0, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  %.5.i1 = getelementptr i8, ptr %arg.a1.0, i64 24
  %.6.i2 = load ptr, ptr %.5.i1, align 8
  %.5.i3 = getelementptr i8, ptr %arg.a2.0, i64 24
  %.6.i4 = load ptr, ptr %.5.i3, align 8
  %.5.i5 = getelementptr i8, ptr %arg.a3.0, i64 24
  %.6.i6 = load ptr, ptr %.5.i5, align 8
  %.5.i7 = getelementptr i8, ptr %arg.a4.0, i64 24
  %.6.i8 = load ptr, ptr %.5.i7, align 8
  %.5.i9 = getelementptr i8, ptr %arg.a5.0, i64 24
  %.6.i10 = load ptr, ptr %.5.i9, align 8
  %.90 = tail call ptr (i64, ...) @PyTuple_Pack(i64 6, ptr %.6.i, ptr %.6.i2, ptr %.6.i4, ptr %.6.i6, ptr %.6.i8, ptr %.6.i10)
  %.92 = icmp eq ptr %.90, null
  br i1 %.92, label %common.ret.critedge, label %B0.endif.endif, !prof !0

B0.endif.endif:                                   ; preds = %B0.endif
  %.95 = tail call ptr @PyObject_Call(ptr nonnull %.43, ptr nonnull %.90, ptr null)
  %.97 = icmp eq ptr %.95, null
  br i1 %.97, label %common.ret.critedge, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.endif:                             ; preds = %B0.endif.endif
  %.100 = tail call ptr @NRT_meminfo_new_from_pyobject(ptr nonnull %.95, ptr nonnull %.95)
  %.101 = icmp eq ptr %.100, null
  tail call void @Py_DecRef(ptr nonnull %.95)
  br i1 %.101, label %B0.endif.endif.endif.if, label %bridge.cleanup, !prof !0

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

define ptr @_ZN7cpython6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = alloca ptr, align 8
  %.11 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.encode_boxed, i64 6, i64 6, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9, ptr nonnull %.10)
  %.12 = icmp eq i32 %.11, 0
  %.137 = alloca { ptr }, align 8
  br i1 %.12, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.e...endif.1.endif, %entry.endif.endif.endif.if, %arg0.err, %entry, %entry.endif.endif.endif.e...endif.1.endif.if.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.e...endif.1.endif ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %arg0.err ], [ %.6.i, %entry.endif.endif.endif.e...endif.1.endif.if.endif ], [ null, %entry.endif.endif.endif.if ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.16 = load ptr, ptr @_ZN08NumbaEnv6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE, align 8
  %.19 = icmp eq ptr %.16, null
  br i1 %.19, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE")
  br label %common.ret

entry.endif.endif:                                ; preds = %entry.endif
  %.23 = load ptr, ptr %.5, align 8
  %.27 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.23, ptr %.23)
  %.32 = icmp eq ptr %.27, null
  br i1 %.32, label %entry.endif.endif.endif.if, label %entry.endif.endif.endif.endif, !prof !0

entry.endif.endif.endif.if:                       ; preds = %entry.endif.endif
  call void @Py_DecRef(ptr %.23)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif
  %.42 = load ptr, ptr %.6, align 8
  %.46 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.42, ptr %.42)
  %.51 = icmp eq ptr %.46, null
  br i1 %.51, label %entry.endif.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif.endif, !prof !0

arg0.err:                                         ; preds = %arg1.err, %entry.endif.endif.endif.endif.endif.if
  call void @NRT_decref(ptr nonnull %.27)
  br label %common.ret

entry.endif.endif.endif.endif.endif.if:           ; preds = %entry.endif.endif.endif.endif
  call void @Py_DecRef(ptr %.42)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif
  %.61 = load ptr, ptr %.7, align 8
  %.65 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.61, ptr %.61)
  %.70 = icmp eq ptr %.65, null
  br i1 %.70, label %entry.endif.endif.endif.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

arg1.err:                                         ; preds = %arg2.err, %entry.endif.endif.endif.endif.endif.endif.endif.if
  call void @NRT_decref(ptr nonnull %.46)
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif.endif.if: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @Py_DecRef(ptr %.61)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %arg1.err

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  %.80 = load ptr, ptr %.8, align 8
  %.84 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.80, ptr %.80)
  %.89 = icmp eq ptr %.84, null
  br i1 %.89, label %entry.endif.endif.endif.e...endif.if, label %entry.endif.endif.endif.e...endif.endif, !prof !0

arg2.err:                                         ; preds = %arg3.err, %entry.endif.endif.endif.e...endif.if
  call void @NRT_decref(ptr nonnull %.65)
  br label %arg1.err

entry.endif.endif.endif.e...endif.if:             ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @Py_DecRef(ptr %.80)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.99 = load ptr, ptr %.9, align 8
  %.103 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.99, ptr %.99)
  %.108 = icmp eq ptr %.103, null
  br i1 %.108, label %entry.endif.endif.endif.e...endif.endif.endif.if, label %entry.endif.endif.endif.e...endif.endif.endif.endif, !prof !0

arg3.err:                                         ; preds = %entry.endif.endif.endif.e...endif.1.if, %entry.endif.endif.endif.e...endif.endif.endif.if
  call void @NRT_decref(ptr nonnull %.84)
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif.endif.if: ; preds = %entry.endif.endif.endif.e...endif.endif
  call void @Py_DecRef(ptr %.99)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  br label %arg3.err

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif
  %.118 = load ptr, ptr %.10, align 8
  %.122 = call ptr @NRT_meminfo_new_from_pyobject(ptr %.118, ptr %.118)
  %.127 = icmp eq ptr %.122, null
  br i1 %.127, label %entry.endif.endif.endif.e...endif.1.if, label %entry.endif.endif.endif.e...endif.1.endif, !prof !0

entry.endif.endif.endif.e...endif.1.if:           ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  call void @Py_DecRef(ptr %.118)
  call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed object allocation failed")
  call void @NRT_decref(ptr nonnull %.103)
  br label %arg3.err

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  store ptr null, ptr %.137, align 8
  %.141 = call i32 @_ZN6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE(ptr nonnull %.137, ptr nonnull poison, ptr nonnull %.27, ptr nonnull %.46, ptr nonnull %.65, ptr nonnull %.84, ptr nonnull %.103, ptr nonnull %.122) #0
  %.151.fca.0.load = load ptr, ptr %.137, align 8
  call void @NRT_decref(ptr nonnull %.27)
  call void @NRT_decref(ptr nonnull %.46)
  call void @NRT_decref(ptr nonnull %.65)
  call void @NRT_decref(ptr nonnull %.84)
  call void @NRT_decref(ptr nonnull %.103)
  call void @NRT_decref(ptr nonnull %.122)
  %cond = icmp eq i32 %.141, 0
  br i1 %cond, label %entry.endif.endif.endif.e...endif.1.endif.if.endif, label %common.ret, !prof !1

entry.endif.endif.endif.e...endif.1.endif.if.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif
  %.5.i = getelementptr i8, ptr %.151.fca.0.load, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  call void @Py_IncRef(ptr %.6.i)
  call void @NRT_decref(ptr %.151.fca.0.load)
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @Py_IncRef(ptr) local_unnamed_addr

define { ptr } @cfunc._ZN6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE({ ptr } %.1, { ptr } %.2, { ptr } %.3, { ptr } %.4, { ptr } %.5, { ptr } %.6) local_unnamed_addr {
entry:
  %.8 = alloca { ptr }, align 8
  store ptr null, ptr %.8, align 8
  %extracted.meminfo = extractvalue { ptr } %.1, 0
  %extracted.meminfo.1 = extractvalue { ptr } %.2, 0
  %extracted.meminfo.2 = extractvalue { ptr } %.3, 0
  %extracted.meminfo.3 = extractvalue { ptr } %.4, 0
  %extracted.meminfo.4 = extractvalue { ptr } %.5, 0
  %extracted.meminfo.5 = extractvalue { ptr } %.6, 0
  %.12 = call i32 @_ZN6bridge12encode_boxedB2v5B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectEN6wave1715ManagedPyObjectE(ptr nonnull %.8, ptr nonnull poison, ptr %extracted.meminfo, ptr %extracted.meminfo.1, ptr %extracted.meminfo.2, ptr %extracted.meminfo.3, ptr %extracted.meminfo.4, ptr %extracted.meminfo.5) #0
  %.22.fca.0.load = load ptr, ptr %.8, align 8
  %.25 = alloca i32, align 4
  store i32 0, ptr %.25, align 4
  %cond = icmp eq i32 %.12, 0
  br i1 %cond, label %common.ret, label %.28, !prof !1

common.ret:                                       ; preds = %entry, %.28
  %inserted.meminfo = insertvalue { ptr } undef, ptr %.22.fca.0.load, 0
  ret { ptr } %inserted.meminfo

.28:                                              ; preds = %entry
  call void @numba_gil_ensure(ptr nonnull %.25)
  %.76 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.76)
  call void @Py_DecRef(ptr %.76)
  call void @numba_gil_release(ptr nonnull %.25)
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
