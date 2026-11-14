; ModuleID = 'f0_loop_recurrence16'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_loop_recurrence16 = internal constant [21 x i8] c"f0_loop_recurrence16\00"
@_ZN08NumbaEnv32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx" = internal constant [272 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx\00"
@PyExc_TypeError = external global i8
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@PyExc_RuntimeError = external global i8

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: write)
define noundef i32 @_ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr readnone captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z, i64 %arg.v_n) local_unnamed_addr #0 {
B0.endif:
  %.15675.not = icmp slt i64 %arg.v_n, 1
  br i1 %.15675.not, label %B848, label %B40.preheader

B40.preheader:                                    ; preds = %B0.endif
  %0 = add i64 %arg.v_n, 1
  br label %B40

B40:                                              ; preds = %B40.preheader, %B40
  %lsr.iv = phi i64 [ %0, %B40.preheader ], [ %lsr.iv.next, %B40 ]
  %v_t.17.078 = phi i64 [ %.258, %B40 ], [ %arg.v_x, %B40.preheader ]
  %.196 = mul i64 %v_t.17.078, %arg.v_y
  %.198 = add i64 %.196, %arg.v_z
  %.200 = mul i64 %.198, %arg.v_y
  %.202 = add i64 %.200, %arg.v_z
  %.204 = mul i64 %.202, %arg.v_y
  %.206 = add i64 %.204, %arg.v_z
  %.208 = mul i64 %.206, %arg.v_y
  %.210 = add i64 %.208, %arg.v_z
  %.212 = mul i64 %.210, %arg.v_y
  %.214 = add i64 %.212, %arg.v_z
  %.216 = mul i64 %.214, %arg.v_y
  %.218 = add i64 %.216, %arg.v_z
  %.220 = mul i64 %.218, %arg.v_y
  %.222 = add i64 %.220, %arg.v_z
  %.224 = mul i64 %.222, %arg.v_y
  %.226 = add i64 %.224, %arg.v_z
  %.228 = mul i64 %.226, %arg.v_y
  %.230 = add i64 %.228, %arg.v_z
  %.232 = mul i64 %.230, %arg.v_y
  %.234 = add i64 %.232, %arg.v_z
  %.236 = mul i64 %.234, %arg.v_y
  %.238 = add i64 %.236, %arg.v_z
  %.240 = mul i64 %.238, %arg.v_y
  %.242 = add i64 %.240, %arg.v_z
  %.244 = mul i64 %.242, %arg.v_y
  %.246 = add i64 %.244, %arg.v_z
  %.248 = mul i64 %.246, %arg.v_y
  %.250 = add i64 %.248, %arg.v_z
  %.252 = mul i64 %.250, %arg.v_y
  %.254 = add i64 %.252, %arg.v_z
  %.256 = mul i64 %.254, %arg.v_y
  %.258 = add i64 %.256, %arg.v_z
  %lsr.iv.next = add i64 %lsr.iv, -1
  %.156 = icmp samesign ugt i64 %lsr.iv.next, 1
  br i1 %.156, label %B40, label %B848

B848:                                             ; preds = %B40, %B0.endif
  %v_t.17.0.lcssa = phi i64 [ %arg.v_x, %B0.endif ], [ %.258, %B40 ]
  store i64 %v_t.17.0.lcssa, ptr %retptr, align 8
  ret i32 0
}

define ptr @_ZN7cpython32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = alloca ptr, align 8
  %.11 = alloca ptr, align 8
  %.12 = alloca ptr, align 8
  %.13 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.f0_loop_recurrence16, i64 8, i64 8, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9, ptr nonnull %.10, ptr nonnull %.11, ptr nonnull %.12)
  %.14 = icmp eq i32 %.13, 0
  %.26 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.49 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.72 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.95 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.181 = alloca i64, align 8
  store i64 0, ptr %.181, align 8
  br i1 %.14, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %arg0.err, %entry, %entry.endif.endif.endif.e...endif.2.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %arg0.err ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.thread ], [ %.222, %entry.endif.endif.endif.e...endif.2.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.18 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, align 8
  %.21 = icmp eq ptr %.18, null
  br i1 %.21, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx")
  br label %common.ret

entry.endif.endif:                                ; preds = %entry.endif
  %.25 = load ptr, ptr %.5, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.26, i8 0, i64 56, i1 false)
  %.30 = call i32 @NRT_adapt_ndarray_from_python(ptr %.25, ptr nonnull %.26)
  %sunkaddr = getelementptr inbounds i8, ptr %.26, i64 24
  %.34 = load i64, ptr %sunkaddr, align 8
  %.35 = icmp ne i64 %.34, 8
  %.36 = icmp ne i32 %.30, 0
  %.37 = or i1 %.36, %.35
  br i1 %.37, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !0

entry.endif.endif.endif.thread:                   ; preds = %entry.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif.endif
  %.41.fca.0.load = load ptr, ptr %.26, align 8
  %.48 = load ptr, ptr %.6, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.49, i8 0, i64 56, i1 false)
  %.53 = call i32 @NRT_adapt_ndarray_from_python(ptr %.48, ptr nonnull %.49)
  %sunkaddr1 = getelementptr inbounds i8, ptr %.49, i64 24
  %.57 = load i64, ptr %sunkaddr1, align 8
  %.58 = icmp ne i64 %.57, 8
  %.59 = icmp ne i32 %.53, 0
  %.60 = or i1 %.59, %.58
  br i1 %.60, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !0

arg0.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.thread, %arg1.err
  call void @NRT_decref(ptr %.41.fca.0.load)
  br label %common.ret

entry.endif.endif.endif.endif.endif.thread:       ; preds = %entry.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif
  %.64.fca.0.load = load ptr, ptr %.49, align 8
  %.71 = load ptr, ptr %.7, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.72, i8 0, i64 56, i1 false)
  %.76 = call i32 @NRT_adapt_ndarray_from_python(ptr %.71, ptr nonnull %.72)
  %sunkaddr2 = getelementptr inbounds i8, ptr %.72, i64 24
  %.80 = load i64, ptr %sunkaddr2, align 8
  %.81 = icmp ne i64 %.80, 8
  %.82 = icmp ne i32 %.76, 0
  %.83 = or i1 %.82, %.81
  br i1 %.83, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

arg1.err:                                         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.thread, %arg2.err
  call void @NRT_decref(ptr %.64.fca.0.load)
  br label %arg0.err

entry.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg1.err

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  %.87.fca.0.load = load ptr, ptr %.72, align 8
  %.94 = load ptr, ptr %.8, align 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(56) %.95, i8 0, i64 56, i1 false)
  %.99 = call i32 @NRT_adapt_ndarray_from_python(ptr %.94, ptr nonnull %.95)
  %sunkaddr3 = getelementptr inbounds i8, ptr %.95, i64 24
  %.103 = load i64, ptr %sunkaddr3, align 8
  %.104 = icmp ne i64 %.103, 1
  %.105 = icmp ne i32 %.99, 0
  %.106 = or i1 %.105, %.104
  br i1 %.106, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !0

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.87.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.110.fca.0.load = load ptr, ptr %.95, align 8
  %.117 = load ptr, ptr %.9, align 8
  %.120 = call ptr @PyNumber_Long(ptr %.117)
  %.121.not = icmp eq ptr %.120, null
  br i1 %.121.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !0

arg3.err:                                         ; preds = %entry.endif.endif.endif.e...endif.2, %entry.endif.endif.endif.e...endif.1.endif.endif, %entry.endif.endif.endif.e...endif.1, %entry.endif.endif.endif.e...endif.endif.endif
  call void @NRT_decref(ptr %.110.fca.0.load)
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif.if:       ; preds = %entry.endif.endif.endif.e...endif.endif
  %.123 = call i64 @PyLong_AsLongLong(ptr nonnull %.120)
  call void @Py_DecRef(ptr nonnull %.120)
  br label %entry.endif.endif.endif.e...endif.endif.endif

entry.endif.endif.endif.e...endif.endif.endif:    ; preds = %entry.endif.endif.endif.e...endif.endif.if, %entry.endif.endif.endif.e...endif.endif
  %.118.0 = phi i64 [ %.123, %entry.endif.endif.endif.e...endif.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.endif ]
  %.128 = call ptr @PyErr_Occurred()
  %.129.not = icmp eq ptr %.128, null
  br i1 %.129.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  %.133 = load ptr, ptr %.10, align 8
  %.136 = call ptr @PyNumber_Long(ptr %.133)
  %.137.not = icmp eq ptr %.136, null
  br i1 %.137.not, label %entry.endif.endif.endif.e...endif.1, label %entry.endif.endif.endif.e...if.1, !prof !0

entry.endif.endif.endif.e...if.1:                 ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.139 = call i64 @PyLong_AsLongLong(ptr nonnull %.136)
  call void @Py_DecRef(ptr nonnull %.136)
  br label %entry.endif.endif.endif.e...endif.1

entry.endif.endif.endif.e...endif.1:              ; preds = %entry.endif.endif.endif.e...if.1, %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.134.0 = phi i64 [ %.139, %entry.endif.endif.endif.e...if.1 ], [ 0, %entry.endif.endif.endif.e...endif.endif.endif.endif ]
  %.144 = call ptr @PyErr_Occurred()
  %.145.not = icmp eq ptr %.144, null
  br i1 %.145.not, label %entry.endif.endif.endif.e...endif.1.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.1
  %.149 = load ptr, ptr %.11, align 8
  %.152 = call ptr @PyNumber_Long(ptr %.149)
  %.153.not = icmp eq ptr %.152, null
  br i1 %.153.not, label %entry.endif.endif.endif.e...endif.1.endif.endif, label %entry.endif.endif.endif.e...endif.1.endif.if, !prof !0

entry.endif.endif.endif.e...endif.1.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.1.endif
  %.155 = call i64 @PyLong_AsLongLong(ptr nonnull %.152)
  call void @Py_DecRef(ptr nonnull %.152)
  br label %entry.endif.endif.endif.e...endif.1.endif.endif

entry.endif.endif.endif.e...endif.1.endif.endif:  ; preds = %entry.endif.endif.endif.e...endif.1.endif.if, %entry.endif.endif.endif.e...endif.1.endif
  %.150.0 = phi i64 [ %.155, %entry.endif.endif.endif.e...endif.1.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.1.endif ]
  %.160 = call ptr @PyErr_Occurred()
  %.161.not = icmp eq ptr %.160, null
  br i1 %.161.not, label %entry.endif.endif.endif.e...endif.1.endif.endif.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.1.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif
  %.165 = load ptr, ptr %.12, align 8
  %.168 = call ptr @PyNumber_Long(ptr %.165)
  %.169.not = icmp eq ptr %.168, null
  br i1 %.169.not, label %entry.endif.endif.endif.e...endif.2, label %entry.endif.endif.endif.e...if.2, !prof !0

entry.endif.endif.endif.e...if.2:                 ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.171 = call i64 @PyLong_AsLongLong(ptr nonnull %.168)
  call void @Py_DecRef(ptr nonnull %.168)
  br label %entry.endif.endif.endif.e...endif.2

entry.endif.endif.endif.e...endif.2:              ; preds = %entry.endif.endif.endif.e...if.2, %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.166.0 = phi i64 [ %.171, %entry.endif.endif.endif.e...if.2 ], [ 0, %entry.endif.endif.endif.e...endif.1.endif.endif.endif ]
  %.176 = call ptr @PyErr_Occurred()
  %.177.not = icmp eq ptr %.176, null
  br i1 %.177.not, label %entry.endif.endif.endif.e...endif.2.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.2.endif:        ; preds = %entry.endif.endif.endif.e...endif.2
  store i64 0, ptr %.181, align 8
  %.193 = call i32 @_ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr nonnull %.181, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.118.0, i64 %.134.0, i64 %.150.0, i64 %.166.0) #3
  %.203 = load i64, ptr %.181, align 8
  call void @NRT_decref(ptr %.41.fca.0.load)
  call void @NRT_decref(ptr %.64.fca.0.load)
  call void @NRT_decref(ptr %.87.fca.0.load)
  call void @NRT_decref(ptr %.110.fca.0.load)
  %.222 = call ptr @PyLong_FromLongLong(i64 %.203)
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
define i64 @cfunc._ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr #2 {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %.22 = call i32 @_ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr nonnull %.10, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.5, i64 %.6, i64 %.7, i64 %.8) #3
  %.32 = load i64, ptr %.10, align 8
  ret i64 %.32
}

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #3 {
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
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #4

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: write) }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nofree norecurse nosync nounwind memory(write, inaccessiblemem: none, target_mem0: none, target_mem1: none) }
attributes #3 = { noinline }
attributes #4 = { nounwind }

!0 = !{!"branch_weights", i32 1, i32 99}
!1 = !{!"branch_weights", i32 99, i32 1}
