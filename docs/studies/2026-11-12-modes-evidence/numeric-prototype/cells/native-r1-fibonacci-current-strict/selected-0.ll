; ModuleID = 'f0_fibonacci'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_fibonacci = internal constant [13 x i8] c"f0_fibonacci\00"
@_ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx" = internal constant [261 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx\00"
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function.2" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe195add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_TypeError = external global i8
@PyExc_RuntimeError = external global i8

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite)
define noundef range(i32 -1, -2) i32 @_ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_n) local_unnamed_addr #0 {
B0.endif:
  %.arg.v_n = tail call i64 @llvm.smax.i64(i64 %arg.v_n, i64 0)
  %0 = add nuw i64 %.arg.v_n, 1
  br label %B46

B46:                                              ; preds = %B50.endif, %B0.endif
  %lsr.iv = phi i64 [ %lsr.iv.next, %B50.endif ], [ %0, %B0.endif ]
  %v_a.2.0 = phi i64 [ 0, %B0.endif ], [ %v_b.2.0, %B50.endif ]
  %v_b.2.0 = phi i64 [ 1, %B0.endif ], [ %.20.i, %B50.endif ]
  %lsr.iv.next = add i64 %lsr.iv, -1
  %.151 = icmp sgt i64 %lsr.iv.next, 0
  br i1 %.151, label %B50, label %common.ret

B50:                                              ; preds = %B46
  %.20.i = add nsw i64 %v_b.2.0, %v_a.2.0
  %.25.i = xor i64 %.20.i, %v_a.2.0
  %.27.i = xor i64 %.20.i, %v_b.2.0
  %.28.i = and i64 %.25.i, %.27.i
  %.29.i = icmp slt i64 %.28.i, 0
  br i1 %.29.i, label %B50.endif.thread, label %B50.endif

B50.endif.thread:                                 ; preds = %B50
  store i8 1, ptr %arg.st.4, align 1, !noalias !0
  br label %common.ret

common.ret:                                       ; preds = %B46, %B50.endif, %B50.endif.thread
  %storemerge = phi i64 [ 0, %B50.endif.thread ], [ 0, %B50.endif ], [ %v_a.2.0, %B46 ]
  store i64 %storemerge, ptr %retptr, align 8
  ret i32 0

B50.endif:                                        ; preds = %B50
  %.253.pr = load i8, ptr %arg.st.4, align 1
  %.254.not = icmp eq i8 %.253.pr, 0
  br i1 %.254.not, label %B46, label %common.ret
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #1

define ptr @_ZN7cpython32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
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
  br i1 %.11, label %common.ret, label %entry.endif, !prof !3

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %entry.endif.endif.endif.e...endif.1.endif, %entry.endif.endif.endif.e...endif.1.endif.if, %entry.endif.endif.endif.e...endif.1.endif.endif.endif, %arg0.err, %entry, %entry.endif.endif.endif.e...if.1.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.e...endif.1.endif.endif.endif ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.e...endif.1.endif.if ], [ %.171, %entry.endif.endif.endif.e...if.1.endif ], [ null, %arg0.err ], [ null, %entry.endif.endif.endif.thread ], [ null, %entry.endif.endif.endif.e...endif.1.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.15 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, align 8
  %.18 = icmp eq ptr %.15, null
  br i1 %.18, label %entry.endif.if, label %entry.endif.endif, !prof !3

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx")
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
  br i1 %.34, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !3

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
  br i1 %.57, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !3

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
  br i1 %.80, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !3

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
  br i1 %.103, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !3

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.84.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.107.fca.0.load = load ptr, ptr %.92, align 8
  %sunkaddr4 = getelementptr inbounds i8, ptr %.92, i64 32
  %.107.fca.4.load = load ptr, ptr %sunkaddr4, align 8
  %.114 = load ptr, ptr %.9, align 8
  %.117 = call ptr @PyNumber_Long(ptr %.114)
  %.118.not = icmp eq ptr %.117, null
  br i1 %.118.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !3

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
  br i1 %.126.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !4

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  store i64 0, ptr %.130, align 8
  %.142 = call i32 @_ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr nonnull %.130, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %.107.fca.4.load, i64 poison, i64 poison, i64 %.115.0) #3
  %.152 = load i64, ptr %.130, align 8
  call void @NRT_decref(ptr %.38.fca.0.load)
  call void @NRT_decref(ptr %.61.fca.0.load)
  call void @NRT_decref(ptr %.84.fca.0.load)
  call void @NRT_decref(ptr %.107.fca.0.load)
  %cond = icmp eq i32 %.142, 0
  br i1 %cond, label %entry.endif.endif.endif.e...if.1.endif, label %entry.endif.endif.endif.e...endif.1, !prof !5

entry.endif.endif.endif.e...endif.1:              ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.150 = icmp sgt i32 %.142, 0
  br i1 %.150, label %entry.endif.endif.endif.e...endif.1.if, label %entry.endif.endif.endif.e...endif.1.endif

entry.endif.endif.endif.e...if.1.endif:           ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.171 = call ptr @PyLong_FromLongLong(i64 %.152)
  br label %common.ret

entry.endif.endif.endif.e...endif.1.if:           ; preds = %entry.endif.endif.endif.e...endif.1
  call void @PyErr_Clear()
  unreachable

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.1
  switch i32 %.142, label %entry.endif.endif.endif.e...endif.1.endif.endif.endif [
    i32 -3, label %entry.endif.endif.endif.e...endif.1.endif.if
    i32 -1, label %common.ret
  ]

entry.endif.endif.endif.e...endif.1.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.1.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %common.ret

entry.endif.endif.endif.e...endif.1.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #2

declare i32 @NRT_adapt_ndarray_from_python(ptr captures(none), ptr captures(none)) local_unnamed_addr

declare ptr @PyNumber_Long(ptr) local_unnamed_addr

declare i64 @PyLong_AsLongLong(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyErr_Occurred() local_unnamed_addr

declare ptr @PyLong_FromLongLong(i64) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare void @PyErr_SetNone(ptr) local_unnamed_addr

define i64 @cfunc._ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5) local_unnamed_addr {
entry:
  %.7 = alloca i64, align 8
  store i64 0, ptr %.7, align 8
  %extracted.data.3 = extractvalue { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, 4
  %.19 = call i32 @_ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx(ptr nonnull %.7, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %extracted.data.3, i64 poison, i64 poison, i64 %.5) #3
  %.29 = load i64, ptr %.7, align 8
  %.31 = alloca i32, align 4
  store i32 0, ptr %.31, align 4
  %cond = icmp eq i32 %.19, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !5

entry.if:                                         ; preds = %entry
  %.27 = icmp sgt i32 %.19, 0
  call void @numba_gil_ensure(ptr nonnull %.31)
  br i1 %.27, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.34
  ret i64 %.29

.34:                                              ; preds = %entry.if.endif, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.82 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.82)
  call void @Py_DecRef(ptr %.82)
  call void @numba_gil_release(ptr nonnull %.31)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  unreachable

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.19, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.34
  ]

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.34

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function.2")
  br label %.34
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #3 {
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
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #4

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { noinline }
attributes #4 = { nounwind }

!0 = !{!1}
!1 = distinct !{!1, !2, !"_ZN32rc_heap_16371f099018d0a4b008fe195add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx: %retptr"}
!2 = distinct !{!2, !"_ZN32rc_heap_16371f099018d0a4b008fe195add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx"}
!3 = !{!"branch_weights", i32 1, i32 99}
!4 = !{!"branch_weights", i32 99, i32 1}
!5 = !{!"branch_weights", i32 49, i32 1}
