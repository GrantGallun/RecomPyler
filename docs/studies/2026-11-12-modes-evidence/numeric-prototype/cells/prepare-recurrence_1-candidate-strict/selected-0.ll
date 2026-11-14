; ModuleID = 'f0_recurrence_1'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_recurrence_1 = internal constant [16 x i8] c"f0_recurrence_1\00"
@_ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx" = internal constant [266 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx\00"
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function.2" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d5mul_iB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d5add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_TypeError = external global i8
@PyExc_RuntimeError = external global i8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define noundef range(i32 -1, -2) i32 @_ZN32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z) local_unnamed_addr #0 {
B0:
  %.25.i = sitofp i64 %arg.v_x to double
  %.27.i = sitofp i64 %arg.v_y to double
  %.28.i = fmul double %.25.i, %.27.i
  %0 = tail call double @llvm.fabs.f64(double %.28.i)
  %or.cond.i = fcmp ult double %0, 9.200000e+18
  br i1 %or.cond.i, label %B0.endif, label %common.ret.sink.split

common.ret.sink.split:                            ; preds = %B0, %B66
  store i8 1, ptr %arg.st.4, align 1, !noalias !0
  br label %common.ret

common.ret:                                       ; preds = %common.ret.sink.split, %B66, %B0.endif
  %.20.i.sink = phi i64 [ 0, %B0.endif ], [ %.20.i, %B66 ], [ 0, %common.ret.sink.split ]
  store i64 %.20.i.sink, ptr %retptr, align 8
  ret i32 0

B66:                                              ; preds = %B0.endif
  %.96.i = mul nsw i64 %arg.v_y, %arg.v_x
  %.20.i = add nsw i64 %arg.v_z, %.96.i
  %.25.i1 = xor i64 %.20.i, %.96.i
  %.27.i2 = xor i64 %.20.i, %arg.v_z
  %.28.i3 = and i64 %.25.i1, %.27.i2
  %.29.i = icmp slt i64 %.28.i3, 0
  br i1 %.29.i, label %common.ret.sink.split, label %common.ret

B0.endif:                                         ; preds = %B0
  %.130.pr = load i8, ptr %arg.st.4, align 1
  %.131.not = icmp eq i8 %.130.pr, 0
  br i1 %.131.not, label %B66, label %common.ret
}

define ptr @_ZN7cpython32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = alloca ptr, align 8
  %.11 = alloca ptr, align 8
  %.12 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.f0_recurrence_1, i64 7, i64 7, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9, ptr nonnull %.10, ptr nonnull %.11)
  %.13 = icmp eq i32 %.12, 0
  %.25 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.48 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.71 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.94 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.164 = alloca i64, align 8
  store i64 0, ptr %.164, align 8
  br i1 %.13, label %common.ret, label %entry.endif, !prof !1

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %entry.endif.endif.endif.e...endif.2.endif, %entry.endif.endif.endif.e...endif.2.endif.if, %entry.endif.endif.endif.e...endif.2.endif.endif.endif, %arg0.err, %entry, %entry.endif.endif.endif.e...if.2.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.e...endif.2.endif.endif.endif ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.e...endif.2.endif.if ], [ %.205, %entry.endif.endif.endif.e...if.2.endif ], [ null, %arg0.err ], [ null, %entry.endif.endif.endif.thread ], [ null, %entry.endif.endif.endif.e...endif.2.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.17 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, align 8
  %.20 = icmp eq ptr %.17, null
  br i1 %.20, label %entry.endif.if, label %entry.endif.endif, !prof !1

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx")
  br label %common.ret

entry.endif.endif:                                ; preds = %entry.endif
  %.24 = load ptr, ptr %.5, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.25, i8 0, i64 56, i1 false)
  %.29 = call i32 @NRT_adapt_ndarray_from_python(ptr %.24, ptr nonnull %.25)
  %sunkaddr = getelementptr inbounds i8, ptr %.25, i64 24
  %.33 = load i64, ptr %sunkaddr, align 8
  %.34 = icmp ne i64 %.33, 8
  %.35 = icmp ne i32 %.29, 0
  %.36 = or i1 %.35, %.34
  br i1 %.36, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !1

entry.endif.endif.endif.thread:                   ; preds = %entry.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif
  %.40.fca.0.load = load ptr, ptr %.25, align 8
  %.47 = load ptr, ptr %.6, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.48, i8 0, i64 56, i1 false)
  %.52 = call i32 @NRT_adapt_ndarray_from_python(ptr %.47, ptr nonnull %.48)
  %sunkaddr1 = getelementptr inbounds i8, ptr %.48, i64 24
  %.56 = load i64, ptr %sunkaddr1, align 8
  %.57 = icmp ne i64 %.56, 8
  %.58 = icmp ne i32 %.52, 0
  %.59 = or i1 %.58, %.57
  br i1 %.59, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !1

arg0.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.thread, %arg1.err
  call void @NRT_decref(ptr %.40.fca.0.load)
  br label %common.ret

entry.endif.endif.endif.endif.endif.thread:       ; preds = %entry.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif
  %.63.fca.0.load = load ptr, ptr %.48, align 8
  %.70 = load ptr, ptr %.7, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.71, i8 0, i64 56, i1 false)
  %.75 = call i32 @NRT_adapt_ndarray_from_python(ptr %.70, ptr nonnull %.71)
  %sunkaddr2 = getelementptr inbounds i8, ptr %.71, i64 24
  %.79 = load i64, ptr %sunkaddr2, align 8
  %.80 = icmp ne i64 %.79, 8
  %.81 = icmp ne i32 %.75, 0
  %.82 = or i1 %.81, %.80
  br i1 %.82, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !1

arg1.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.thread, %arg2.err
  call void @NRT_decref(ptr %.63.fca.0.load)
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg1.err

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  %.86.fca.0.load = load ptr, ptr %.71, align 8
  %.93 = load ptr, ptr %.8, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.94, i8 0, i64 56, i1 false)
  %.98 = call i32 @NRT_adapt_ndarray_from_python(ptr %.93, ptr nonnull %.94)
  %sunkaddr3 = getelementptr inbounds i8, ptr %.94, i64 24
  %.102 = load i64, ptr %sunkaddr3, align 8
  %.103 = icmp ne i64 %.102, 1
  %.104 = icmp ne i32 %.98, 0
  %.105 = or i1 %.104, %.103
  br i1 %.105, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !1

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.86.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.109.fca.0.load = load ptr, ptr %.94, align 8
  %sunkaddr4 = getelementptr inbounds i8, ptr %.94, i64 32
  %.109.fca.4.load = load ptr, ptr %sunkaddr4, align 8
  %.116 = load ptr, ptr %.9, align 8
  %.119 = call ptr @PyNumber_Long(ptr %.116)
  %.120.not = icmp eq ptr %.119, null
  br i1 %.120.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !1

arg3.err:                                         ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif, %entry.endif.endif.endif.e...endif.1, %entry.endif.endif.endif.e...endif.endif.endif
  call void @NRT_decref(ptr %.109.fca.0.load)
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif.if:       ; preds = %entry.endif.endif.endif.e...endif.endif
  %.122 = call i64 @PyLong_AsLongLong(ptr nonnull %.119)
  call void @Py_DecRef(ptr nonnull %.119)
  br label %entry.endif.endif.endif.e...endif.endif.endif

entry.endif.endif.endif.e...endif.endif.endif:    ; preds = %entry.endif.endif.endif.e...endif.endif.if, %entry.endif.endif.endif.e...endif.endif
  %.117.0 = phi i64 [ %.122, %entry.endif.endif.endif.e...endif.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.endif ]
  %.127 = call ptr @PyErr_Occurred()
  %.128.not = icmp eq ptr %.127, null
  br i1 %.128.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  %.132 = load ptr, ptr %.10, align 8
  %.135 = call ptr @PyNumber_Long(ptr %.132)
  %.136.not = icmp eq ptr %.135, null
  br i1 %.136.not, label %entry.endif.endif.endif.e...endif.1, label %entry.endif.endif.endif.e...if.1, !prof !1

entry.endif.endif.endif.e...if.1:                 ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.138 = call i64 @PyLong_AsLongLong(ptr nonnull %.135)
  call void @Py_DecRef(ptr nonnull %.135)
  br label %entry.endif.endif.endif.e...endif.1

entry.endif.endif.endif.e...endif.1:              ; preds = %entry.endif.endif.endif.e...if.1, %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.133.0 = phi i64 [ %.138, %entry.endif.endif.endif.e...if.1 ], [ 0, %entry.endif.endif.endif.e...endif.endif.endif.endif ]
  %.143 = call ptr @PyErr_Occurred()
  %.144.not = icmp eq ptr %.143, null
  br i1 %.144.not, label %entry.endif.endif.endif.e...endif.1.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.1
  %.148 = load ptr, ptr %.11, align 8
  %.151 = call ptr @PyNumber_Long(ptr %.148)
  %.152.not = icmp eq ptr %.151, null
  br i1 %.152.not, label %entry.endif.endif.endif.e...endif.1.endif.endif, label %entry.endif.endif.endif.e...endif.1.endif.if, !prof !1

entry.endif.endif.endif.e...endif.1.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.1.endif
  %.154 = call i64 @PyLong_AsLongLong(ptr nonnull %.151)
  call void @Py_DecRef(ptr nonnull %.151)
  br label %entry.endif.endif.endif.e...endif.1.endif.endif

entry.endif.endif.endif.e...endif.1.endif.endif:  ; preds = %entry.endif.endif.endif.e...endif.1.endif.if, %entry.endif.endif.endif.e...endif.1.endif
  %.149.0 = phi i64 [ %.154, %entry.endif.endif.endif.e...endif.1.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.1.endif ]
  %.159 = call ptr @PyErr_Occurred()
  %.160.not = icmp eq ptr %.159, null
  br i1 %.160.not, label %entry.endif.endif.endif.e...endif.1.endif.endif.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.1.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif
  %.176 = call i32 @_ZN32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.164, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %.109.fca.4.load, i64 poison, i64 poison, i64 %.117.0, i64 %.133.0, i64 %.149.0) #3
  %.186 = load i64, ptr %.164, align 8
  call void @NRT_decref(ptr %.40.fca.0.load)
  call void @NRT_decref(ptr %.63.fca.0.load)
  call void @NRT_decref(ptr %.86.fca.0.load)
  call void @NRT_decref(ptr %.109.fca.0.load)
  %cond = icmp eq i32 %.176, 0
  br i1 %cond, label %entry.endif.endif.endif.e...if.2.endif, label %entry.endif.endif.endif.e...endif.2, !prof !3

entry.endif.endif.endif.e...endif.2:              ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.184 = icmp sgt i32 %.176, 0
  br i1 %.184, label %entry.endif.endif.endif.e...endif.2.if, label %entry.endif.endif.endif.e...endif.2.endif

entry.endif.endif.endif.e...if.2.endif:           ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.205 = call ptr @PyLong_FromLongLong(i64 %.186)
  br label %common.ret

entry.endif.endif.endif.e...endif.2.if:           ; preds = %entry.endif.endif.endif.e...endif.2
  call void @PyErr_Clear()
  unreachable

entry.endif.endif.endif.e...endif.2.endif:        ; preds = %entry.endif.endif.endif.e...endif.2
  switch i32 %.176, label %entry.endif.endif.endif.e...endif.2.endif.endif.endif [
    i32 -3, label %entry.endif.endif.endif.e...endif.2.endif.if
    i32 -1, label %common.ret
  ]

entry.endif.endif.endif.e...endif.2.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.2.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %common.ret

entry.endif.endif.endif.e...endif.2.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.2.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
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

declare void @PyErr_Clear() local_unnamed_addr

declare void @PyErr_SetNone(ptr) local_unnamed_addr

define i64 @cfunc._ZN32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5, i64 %.6, i64 %.7) local_unnamed_addr {
entry:
  %.9 = alloca i64, align 8
  %extracted.data.3 = extractvalue { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, 4
  %.21 = call i32 @_ZN32rc_heap_e1608e92092c158d0062c70d15f0_recurrence_1B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.9, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %extracted.data.3, i64 poison, i64 poison, i64 %.5, i64 %.6, i64 %.7) #3
  %.31 = load i64, ptr %.9, align 8
  %.33 = alloca i32, align 4
  store i32 0, ptr %.33, align 4
  %cond = icmp eq i32 %.21, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !3

entry.if:                                         ; preds = %entry
  %.29 = icmp sgt i32 %.21, 0
  call void @numba_gil_ensure(ptr nonnull %.33)
  br i1 %.29, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.36
  ret i64 %.31

.36:                                              ; preds = %entry.if.endif, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.84 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.84)
  call void @Py_DecRef(ptr %.84)
  call void @numba_gil_release(ptr nonnull %.33)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  unreachable

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.21, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.36
  ]

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.36

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function.2")
  br label %.36
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #2

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #3 {
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
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #4

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { noinline }
attributes #4 = { nounwind }

!0 = !{}
!1 = !{!"branch_weights", i32 1, i32 99}
!2 = !{!"branch_weights", i32 99, i32 1}
!3 = !{!"branch_weights", i32 49, i32 1}
