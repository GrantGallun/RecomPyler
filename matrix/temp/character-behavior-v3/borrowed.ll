; ModuleID = 'borrowed'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.9df615d5e016065374b39ea024db4432eed0bfc4 = internal constant [170 x i8] c"\80\04\95\9F\00\00\00\00\00\00\00\8C\08builtins\94\8C\0CRuntimeError\94\93\94\8Czmissing Environment: _ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE\94\85\94N\87\94."
@.const.pickledata.9df615d5e016065374b39ea024db4432eed0bfc4.sha1 = internal constant [20 x i8] c"\9D\F6\15\D5\E0\16\06St\B3\9E\A0$\DBD2\EE\D0\BF\C4"
@.const.picklebuf.9df615d5e016065374b39ea024db4432eed0bfc4 = internal constant { ptr, i32, ptr, ptr, i32 } { ptr @.const.pickledata.9df615d5e016065374b39ea024db4432eed0bfc4, i32 170, ptr @.const.pickledata.9df615d5e016065374b39ea024db4432eed0bfc4.sha1, ptr null, i32 0 }
@".const.`env.consts` is NULL in `read_const`" = internal constant [37 x i8] c"`env.consts` is NULL in `read_const`\00"
@".const.managed bridge allocation failed" = internal constant [33 x i8] c"managed bridge allocation failed\00"
@.const.borrowed = internal constant [9 x i8] c"borrowed\00"
@_ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE" = internal constant [123 x i8] c"missing Environment: _ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE\00"
@PyExc_MemoryError = external global i8
@".const.managed object allocation failed" = internal constant [33 x i8] c"managed object allocation failed\00"
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@PyExc_RuntimeError = external global i8
@".const.Error creating Python tuple from runtime exception arguments.1" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function.2" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"

define range(i32 -1, 2) i32 @_ZN6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr readonly captures(none) %arg.a0.0) local_unnamed_addr {
B0:
  %.27 = load ptr, ptr @_ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE, align 8
  %.28 = icmp eq ptr %.27, null
  br i1 %.28, label %B0.if, label %B0.endif, !prof !0

common.ret.critedge:                              ; preds = %B0.endif.endif.endif.endif.endif.if, %B0.endif.endif.thread, %B0.endif.endif.endif, %B0.endif.endif, %B0.endif.endif.endif.endif
  %.41.07.ph = phi ptr [ %.46, %B0.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.thread ], [ %.46, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ %.46, %B0.endif.endif.endif.endif ]
  %.9.0.ph = phi ptr [ %.64, %B0.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.thread ], [ null, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ %.64, %B0.endif.endif.endif.endif ]
  %.12.0.ph = phi ptr [ %.69, %B0.endif.endif.endif.endif.endif.if ], [ null, %B0.endif.endif.thread ], [ null, %B0.endif.endif.endif ], [ null, %B0.endif.endif ], [ null, %B0.endif.endif.endif.endif ]
  tail call void @Py_DecRef(ptr %.12.0.ph)
  tail call void @Py_DecRef(ptr %.9.0.ph)
  tail call void @Py_DecRef(ptr %.41.07.ph)
  br label %common.ret

common.ret:                                       ; preds = %common.ret.critedge, %B0.if, %bridge.cleanup
  %common.ret.op = phi i32 [ 0, %bridge.cleanup ], [ 1, %B0.if ], [ -1, %common.ret.critedge ]
  ret i32 %common.ret.op

bridge.cleanup:                                   ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.64)
  tail call void @Py_DecRef(ptr nonnull %.46)
  store ptr %.74, ptr %retptr, align 8
  br label %common.ret

B0.if:                                            ; preds = %B0
  store ptr @.const.picklebuf.9df615d5e016065374b39ea024db4432eed0bfc4, ptr %excinfo, align 8, !numba_exception_output !1
  br label %common.ret

B0.endif:                                         ; preds = %B0
  %.39 = getelementptr i8, ptr %.27, i64 24
  %.40 = load ptr, ptr %.39, align 8
  %.44.not = icmp eq ptr %.40, null
  br i1 %.44.not, label %B0.endif.endif.thread, label %B0.endif.endif

B0.endif.endif.thread:                            ; preds = %B0.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  tail call void @Py_IncRef(ptr null)
  br label %common.ret.critedge

B0.endif.endif:                                   ; preds = %B0.endif
  %.46 = tail call ptr @PyList_GetItem(ptr nonnull %.40, i64 0)
  tail call void @Py_IncRef(ptr %.46)
  %.54 = icmp eq ptr %.46, null
  br i1 %.54, label %common.ret.critedge, label %B0.endif.endif.endif, !prof !2

B0.endif.endif.endif:                             ; preds = %B0.endif.endif
  %.5.i = getelementptr i8, ptr %arg.a0.0, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  %.64 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr %.6.i)
  %.66 = icmp eq ptr %.64, null
  br i1 %.66, label %common.ret.critedge, label %B0.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif:                       ; preds = %B0.endif.endif.endif
  %.69 = tail call ptr @PyObject_Call(ptr nonnull %.46, ptr nonnull %.64, ptr null)
  %.71 = icmp eq ptr %.69, null
  br i1 %.71, label %common.ret.critedge, label %B0.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif
  %.74 = tail call ptr @NRT_meminfo_new_from_pyobject(ptr nonnull %.69, ptr nonnull %.69)
  %.75 = icmp eq ptr %.74, null
  tail call void @Py_DecRef(ptr nonnull %.69)
  br i1 %.75, label %B0.endif.endif.endif.endif.endif.if, label %bridge.cleanup, !prof !0

B0.endif.endif.endif.endif.endif.if:              ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_MemoryError, ptr nonnull @".const.managed bridge allocation failed")
  br label %common.ret.critedge
}

declare void @Py_DecRef(ptr) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare void @Py_IncRef(ptr) local_unnamed_addr

declare ptr @PyList_GetItem(ptr, i64) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyObject_Call(ptr, ptr, ptr) local_unnamed_addr

declare noalias ptr @NRT_meminfo_new_from_pyobject(ptr captures(none), ptr captures(none)) local_unnamed_addr

define ptr @_ZN7cpython6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.borrowed, i64 1, i64 1, ptr nonnull %.5)
  %.7 = icmp eq i32 %.6, 0
  %.37 = alloca { ptr }, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  br i1 %.7, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.if.endif.if, %entry.endif.endif.endif.endif.endif.if.endif, %entry, %entry.endif.endif.endif.endif.endif.if.if.if, %entry.endif.endif.endif.endif.if.endif, %entry.endif.if, %entry.endif.endif.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif.endif.if.if.if ], [ null, %entry.endif.endif.endif.if ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.endif.endif.endif.endif.endif ], [ %.6.i, %entry.endif.endif.endif.endif.if.endif ], [ null, %entry ], [ null, %entry.endif.endif.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif.if ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.11 = load ptr, ptr @_ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE, align 8
  %.14 = icmp eq ptr %.11, null
  br i1 %.14, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE")
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
  %.41 = call i32 @_ZN6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.37, ptr nonnull %excinfo, ptr nonnull %.22) #0
  %.42 = load ptr, ptr %excinfo, align 8
  %.51.fca.0.load = load ptr, ptr %.37, align 8
  call void @NRT_decref(ptr nonnull %.22)
  %cond = icmp eq i32 %.41, 0
  br i1 %cond, label %entry.endif.endif.endif.endif.if.endif, label %entry.endif.endif.endif.endif.endif, !prof !3

entry.endif.endif.endif.endif.endif:              ; preds = %entry.endif.endif.endif.endif
  %.49 = icmp sgt i32 %.41, 0
  br i1 %.49, label %entry.endif.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.if.endif:           ; preds = %entry.endif.endif.endif.endif
  %.5.i = getelementptr i8, ptr %.51.fca.0.load, i64 24
  %.6.i = load ptr, ptr %.5.i, align 8
  call void @Py_IncRef(ptr %.6.i)
  call void @NRT_decref(ptr %.51.fca.0.load)
  br label %common.ret

entry.endif.endif.endif.endif.endif.if:           ; preds = %entry.endif.endif.endif.endif.endif
  call void @PyErr_Clear()
  %.71 = load { ptr, i32, ptr, ptr, i32 }, ptr %.42, align 8
  %.72 = extractvalue { ptr, i32, ptr, ptr, i32 } %.71, 4
  %.73 = icmp sgt i32 %.72, 0
  %.76 = extractvalue { ptr, i32, ptr, ptr, i32 } %.71, 0
  %.78 = extractvalue { ptr, i32, ptr, ptr, i32 } %.71, 1
  br i1 %.73, label %entry.endif.endif.endif.endif.endif.if.if, label %entry.endif.endif.endif.endif.endif.if.else

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif.endif
  %cond1 = icmp eq i32 %.41, -1
  br i1 %cond1, label %common.ret, label %entry.endif.endif.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.endif.if.if:        ; preds = %entry.endif.endif.endif.endif.endif.if
  %.79 = sext i32 %.78 to i64
  %.80 = call ptr @PyBytes_FromStringAndSize(ptr %.76, i64 %.79)
  %.81 = load { ptr, i32, ptr, ptr, i32 }, ptr %.42, align 8
  %.82 = extractvalue { ptr, i32, ptr, ptr, i32 } %.81, 2
  %.84 = extractvalue { ptr, i32, ptr, ptr, i32 } %.81, 3
  %.86 = call ptr %.84(ptr %.82)
  %.87 = icmp eq ptr %.86, null
  br i1 %.87, label %entry.endif.endif.endif.endif.endif.if.if.if, label %entry.endif.endif.endif.endif.endif.if.if.endif, !prof !0

entry.endif.endif.endif.endif.endif.if.else:      ; preds = %entry.endif.endif.endif.endif.endif.if
  %.100 = extractvalue { ptr, i32, ptr, ptr, i32 } %.71, 2
  %.101 = call ptr @numba_unpickle(ptr %.76, i32 %.78, ptr %.100)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif:     ; preds = %entry.endif.endif.endif.endif.endif.if.if.endif, %entry.endif.endif.endif.endif.endif.if.else
  %.103 = phi ptr [ %.91, %entry.endif.endif.endif.endif.endif.if.if.endif ], [ %.101, %entry.endif.endif.endif.endif.endif.if.else ]
  %.104.not = icmp eq ptr %.103, null
  br i1 %.104.not, label %common.ret, label %entry.endif.endif.endif.endif.endif.if.endif.if, !prof !0

entry.endif.endif.endif.endif.endif.if.if.if:     ; preds = %entry.endif.endif.endif.endif.endif.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments")
  br label %common.ret

entry.endif.endif.endif.endif.endif.if.if.endif:  ; preds = %entry.endif.endif.endif.endif.endif.if.if
  %.91 = call ptr @numba_runtime_build_excinfo_struct(ptr %.80, ptr nonnull %.86)
  call void @NRT_Free(ptr nonnull %.42)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif.if:  ; preds = %entry.endif.endif.endif.endif.endif.if.endif
  call void @numba_do_raise(ptr nonnull %.103)
  br label %common.ret

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare ptr @PyBytes_FromStringAndSize(ptr, i64) local_unnamed_addr

declare ptr @numba_unpickle(ptr, i32, ptr) local_unnamed_addr

declare ptr @numba_runtime_build_excinfo_struct(ptr, ptr) local_unnamed_addr

declare void @NRT_Free(ptr) local_unnamed_addr

declare void @numba_do_raise(ptr) local_unnamed_addr

define { ptr } @cfunc._ZN6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE({ ptr } %.1) local_unnamed_addr {
entry:
  %.3 = alloca { ptr }, align 8
  store ptr null, ptr %.3, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  %extracted.meminfo = extractvalue { ptr } %.1, 0
  %.7 = call i32 @_ZN6bridge8borrowedB2v2B38c8tJTIeFIjxB2IKSgI4CrvQClQZ6FczSBAA_3dEN6wave1715ManagedPyObjectE(ptr nonnull %.3, ptr nonnull %excinfo, ptr %extracted.meminfo) #0
  %.8 = load ptr, ptr %excinfo, align 8
  %.17.fca.0.load = load ptr, ptr %.3, align 8
  %inserted.meminfo = insertvalue { ptr } undef, ptr %.17.fca.0.load, 0
  %.20 = alloca i32, align 4
  store i32 0, ptr %.20, align 4
  %cond1 = icmp eq i32 %.7, 0
  br i1 %cond1, label %common.ret, label %entry.if, !prof !3

entry.if:                                         ; preds = %entry
  %.15 = icmp sgt i32 %.7, 0
  call void @numba_gil_ensure(ptr nonnull %.20)
  br i1 %.15, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.23, %entry.if.if.if.if
  %common.ret.op = phi { ptr } [ zeroinitializer, %entry.if.if.if.if ], [ %inserted.meminfo, %.23 ], [ %inserted.meminfo, %entry ]
  ret { ptr } %common.ret.op

.23:                                              ; preds = %entry.if.endif, %entry.if.if.endif, %entry.if.if.endif.if, %entry.if.endif.endif.endif
  %.71 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.71)
  call void @Py_DecRef(ptr %.71)
  call void @numba_gil_release(ptr nonnull %.20)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  %.26 = load { ptr, i32, ptr, ptr, i32 }, ptr %.8, align 8
  %.27 = extractvalue { ptr, i32, ptr, ptr, i32 } %.26, 4
  %.28 = icmp sgt i32 %.27, 0
  %.31 = extractvalue { ptr, i32, ptr, ptr, i32 } %.26, 0
  %.33 = extractvalue { ptr, i32, ptr, ptr, i32 } %.26, 1
  br i1 %.28, label %entry.if.if.if, label %entry.if.if.else

entry.if.endif:                                   ; preds = %entry.if
  %cond = icmp eq i32 %.7, -1
  br i1 %cond, label %.23, label %entry.if.endif.endif.endif

entry.if.if.if:                                   ; preds = %entry.if.if
  %.34 = sext i32 %.33 to i64
  %.35 = call ptr @PyBytes_FromStringAndSize(ptr %.31, i64 %.34)
  %.36 = load { ptr, i32, ptr, ptr, i32 }, ptr %.8, align 8
  %.37 = extractvalue { ptr, i32, ptr, ptr, i32 } %.36, 2
  %.39 = extractvalue { ptr, i32, ptr, ptr, i32 } %.36, 3
  %.41 = call ptr %.39(ptr %.37)
  %.42 = icmp eq ptr %.41, null
  br i1 %.42, label %entry.if.if.if.if, label %entry.if.if.if.endif, !prof !0

entry.if.if.else:                                 ; preds = %entry.if.if
  %.55 = extractvalue { ptr, i32, ptr, ptr, i32 } %.26, 2
  %.56 = call ptr @numba_unpickle(ptr %.31, i32 %.33, ptr %.55)
  br label %entry.if.if.endif

entry.if.if.endif:                                ; preds = %entry.if.if.if.endif, %entry.if.if.else
  %.58 = phi ptr [ %.46, %entry.if.if.if.endif ], [ %.56, %entry.if.if.else ]
  %.59.not = icmp eq ptr %.58, null
  br i1 %.59.not, label %.23, label %entry.if.if.endif.if, !prof !0

entry.if.if.if.if:                                ; preds = %entry.if.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments.1")
  br label %common.ret

entry.if.if.if.endif:                             ; preds = %entry.if.if.if
  %.46 = call ptr @numba_runtime_build_excinfo_struct(ptr %.35, ptr nonnull %.41)
  call void @NRT_Free(ptr nonnull %.8)
  br label %entry.if.if.endif

entry.if.if.endif.if:                             ; preds = %entry.if.if.endif
  call void @numba_do_raise(ptr nonnull %.58)
  br label %.23

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function.2")
  br label %.23
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
!1 = !{i1 true}
!2 = !{!"branch_weights", i32 0, i32 -2147483648}
!3 = !{!"branch_weights", i32 49, i32 1}
