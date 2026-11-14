; ModuleID = 'f0_recurrence_64'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_recurrence_64 = internal constant [17 x i8] c"f0_recurrence_64\00"
@_ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx" = internal constant [267 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx\00"
@PyExc_TypeError = external global i8
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@PyExc_RuntimeError = external global i8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define noundef i32 @_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr readnone captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z) local_unnamed_addr #0 {
B0:
  %.67 = mul i64 %arg.v_y, %arg.v_x
  %.68 = add i64 %.67, %arg.v_z
  %.69 = mul i64 %.68, %arg.v_y
  %.70 = add i64 %.69, %arg.v_z
  %.71 = mul i64 %.70, %arg.v_y
  %.72 = add i64 %.71, %arg.v_z
  %.73 = mul i64 %.72, %arg.v_y
  %.74 = add i64 %.73, %arg.v_z
  %.75 = mul i64 %.74, %arg.v_y
  %.76 = add i64 %.75, %arg.v_z
  %.77 = mul i64 %.76, %arg.v_y
  %.78 = add i64 %.77, %arg.v_z
  %.79 = mul i64 %.78, %arg.v_y
  %.80 = add i64 %.79, %arg.v_z
  %.81 = mul i64 %.80, %arg.v_y
  %.82 = add i64 %.81, %arg.v_z
  %.83 = mul i64 %.82, %arg.v_y
  %.84 = add i64 %.83, %arg.v_z
  %.85 = mul i64 %.84, %arg.v_y
  %.86 = add i64 %.85, %arg.v_z
  %.87 = mul i64 %.86, %arg.v_y
  %.88 = add i64 %.87, %arg.v_z
  %.89 = mul i64 %.88, %arg.v_y
  %.90 = add i64 %.89, %arg.v_z
  %.91 = mul i64 %.90, %arg.v_y
  %.92 = add i64 %.91, %arg.v_z
  %.93 = mul i64 %.92, %arg.v_y
  %.94 = add i64 %.93, %arg.v_z
  %.95 = mul i64 %.94, %arg.v_y
  %.96 = add i64 %.95, %arg.v_z
  %.97 = mul i64 %.96, %arg.v_y
  %.98 = add i64 %.97, %arg.v_z
  %.99 = mul i64 %.98, %arg.v_y
  %.100 = add i64 %.99, %arg.v_z
  %.101 = mul i64 %.100, %arg.v_y
  %.102 = add i64 %.101, %arg.v_z
  %.103 = mul i64 %.102, %arg.v_y
  %.104 = add i64 %.103, %arg.v_z
  %.105 = mul i64 %.104, %arg.v_y
  %.106 = add i64 %.105, %arg.v_z
  %.107 = mul i64 %.106, %arg.v_y
  %.108 = add i64 %.107, %arg.v_z
  %.109 = mul i64 %.108, %arg.v_y
  %.110 = add i64 %.109, %arg.v_z
  %.111 = mul i64 %.110, %arg.v_y
  %.112 = add i64 %.111, %arg.v_z
  %.113 = mul i64 %.112, %arg.v_y
  %.114 = add i64 %.113, %arg.v_z
  %.115 = mul i64 %.114, %arg.v_y
  %.116 = add i64 %.115, %arg.v_z
  %.117 = mul i64 %.116, %arg.v_y
  %.118 = add i64 %.117, %arg.v_z
  %.119 = mul i64 %.118, %arg.v_y
  %.120 = add i64 %.119, %arg.v_z
  %.121 = mul i64 %.120, %arg.v_y
  %.122 = add i64 %.121, %arg.v_z
  %.123 = mul i64 %.122, %arg.v_y
  %.124 = add i64 %.123, %arg.v_z
  %.125 = mul i64 %.124, %arg.v_y
  %.126 = add i64 %.125, %arg.v_z
  %.127 = mul i64 %.126, %arg.v_y
  %.128 = add i64 %.127, %arg.v_z
  %.129 = mul i64 %.128, %arg.v_y
  %.130 = add i64 %.129, %arg.v_z
  %.131 = mul i64 %.130, %arg.v_y
  %.132 = add i64 %.131, %arg.v_z
  %.133 = mul i64 %.132, %arg.v_y
  %.134 = add i64 %.133, %arg.v_z
  %.135 = mul i64 %.134, %arg.v_y
  %.136 = add i64 %.135, %arg.v_z
  %.137 = mul i64 %.136, %arg.v_y
  %.138 = add i64 %.137, %arg.v_z
  %.139 = mul i64 %.138, %arg.v_y
  %.140 = add i64 %.139, %arg.v_z
  %.141 = mul i64 %.140, %arg.v_y
  %.142 = add i64 %.141, %arg.v_z
  %.143 = mul i64 %.142, %arg.v_y
  %.144 = add i64 %.143, %arg.v_z
  %.145 = mul i64 %.144, %arg.v_y
  %.146 = add i64 %.145, %arg.v_z
  %.147 = mul i64 %.146, %arg.v_y
  %.148 = add i64 %.147, %arg.v_z
  %.149 = mul i64 %.148, %arg.v_y
  %.150 = add i64 %.149, %arg.v_z
  %.151 = mul i64 %.150, %arg.v_y
  %.152 = add i64 %.151, %arg.v_z
  %.153 = mul i64 %.152, %arg.v_y
  %.154 = add i64 %.153, %arg.v_z
  %.155 = mul i64 %.154, %arg.v_y
  %.156 = add i64 %.155, %arg.v_z
  %.157 = mul i64 %.156, %arg.v_y
  %.158 = add i64 %.157, %arg.v_z
  %.159 = mul i64 %.158, %arg.v_y
  %.160 = add i64 %.159, %arg.v_z
  %.161 = mul i64 %.160, %arg.v_y
  %.162 = add i64 %.161, %arg.v_z
  %.163 = mul i64 %.162, %arg.v_y
  %.164 = add i64 %.163, %arg.v_z
  %.165 = mul i64 %.164, %arg.v_y
  %.166 = add i64 %.165, %arg.v_z
  %.167 = mul i64 %.166, %arg.v_y
  %.168 = add i64 %.167, %arg.v_z
  %.169 = mul i64 %.168, %arg.v_y
  %.170 = add i64 %.169, %arg.v_z
  %.171 = mul i64 %.170, %arg.v_y
  %.172 = add i64 %.171, %arg.v_z
  %.173 = mul i64 %.172, %arg.v_y
  %.174 = add i64 %.173, %arg.v_z
  %.175 = mul i64 %.174, %arg.v_y
  %.176 = add i64 %.175, %arg.v_z
  %.177 = mul i64 %.176, %arg.v_y
  %.178 = add i64 %.177, %arg.v_z
  %.179 = mul i64 %.178, %arg.v_y
  %.180 = add i64 %.179, %arg.v_z
  %.181 = mul i64 %.180, %arg.v_y
  %.182 = add i64 %.181, %arg.v_z
  %.183 = mul i64 %.182, %arg.v_y
  %.184 = add i64 %.183, %arg.v_z
  %.185 = mul i64 %.184, %arg.v_y
  %.186 = add i64 %.185, %arg.v_z
  %.187 = mul i64 %.186, %arg.v_y
  %.188 = add i64 %.187, %arg.v_z
  %.189 = mul i64 %.188, %arg.v_y
  %.190 = add i64 %.189, %arg.v_z
  %.191 = mul i64 %.190, %arg.v_y
  %.192 = add i64 %.191, %arg.v_z
  %.193 = mul i64 %.192, %arg.v_y
  %.194 = add i64 %.193, %arg.v_z
  store i64 %.194, ptr %retptr, align 8
  ret i32 0
}

define ptr @_ZN7cpython32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = alloca ptr, align 8
  %.8 = alloca ptr, align 8
  %.9 = alloca ptr, align 8
  %.10 = alloca ptr, align 8
  %.11 = alloca ptr, align 8
  %.12 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.f0_recurrence_64, i64 7, i64 7, ptr nonnull %.5, ptr nonnull %.6, ptr nonnull %.7, ptr nonnull %.8, ptr nonnull %.9, ptr nonnull %.10, ptr nonnull %.11)
  %.13 = icmp eq i32 %.12, 0
  %.25 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.48 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.71 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.94 = alloca { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] }, align 8
  %.164 = alloca i64, align 8
  store i64 0, ptr %.164, align 8
  br i1 %.13, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %arg0.err, %entry, %entry.endif.endif.endif.e...endif.1.endif.endif.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %arg0.err ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.thread ], [ %.205, %entry.endif.endif.endif.e...endif.1.endif.endif.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.17 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, align 8
  %.20 = icmp eq ptr %.17, null
  br i1 %.20, label %entry.endif.if, label %entry.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx")
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
  br i1 %.36, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !0

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
  br i1 %.59, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !0

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
  br i1 %.82, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

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
  br i1 %.105, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !0

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.86.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.109.fca.0.load = load ptr, ptr %.94, align 8
  %.116 = load ptr, ptr %.9, align 8
  %.119 = call ptr @PyNumber_Long(ptr %.116)
  %.120.not = icmp eq ptr %.119, null
  br i1 %.120.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !0

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
  br i1 %.128.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  %.132 = load ptr, ptr %.10, align 8
  %.135 = call ptr @PyNumber_Long(ptr %.132)
  %.136.not = icmp eq ptr %.135, null
  br i1 %.136.not, label %entry.endif.endif.endif.e...endif.1, label %entry.endif.endif.endif.e...if.1, !prof !0

entry.endif.endif.endif.e...if.1:                 ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.138 = call i64 @PyLong_AsLongLong(ptr nonnull %.135)
  call void @Py_DecRef(ptr nonnull %.135)
  br label %entry.endif.endif.endif.e...endif.1

entry.endif.endif.endif.e...endif.1:              ; preds = %entry.endif.endif.endif.e...if.1, %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.133.0 = phi i64 [ %.138, %entry.endif.endif.endif.e...if.1 ], [ 0, %entry.endif.endif.endif.e...endif.endif.endif.endif ]
  %.143 = call ptr @PyErr_Occurred()
  %.144.not = icmp eq ptr %.143, null
  br i1 %.144.not, label %entry.endif.endif.endif.e...endif.1.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.1
  %.148 = load ptr, ptr %.11, align 8
  %.151 = call ptr @PyNumber_Long(ptr %.148)
  %.152.not = icmp eq ptr %.151, null
  br i1 %.152.not, label %entry.endif.endif.endif.e...endif.1.endif.endif, label %entry.endif.endif.endif.e...endif.1.endif.if, !prof !0

entry.endif.endif.endif.e...endif.1.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.1.endif
  %.154 = call i64 @PyLong_AsLongLong(ptr nonnull %.151)
  call void @Py_DecRef(ptr nonnull %.151)
  br label %entry.endif.endif.endif.e...endif.1.endif.endif

entry.endif.endif.endif.e...endif.1.endif.endif:  ; preds = %entry.endif.endif.endif.e...endif.1.endif.if, %entry.endif.endif.endif.e...endif.1.endif
  %.149.0 = phi i64 [ %.154, %entry.endif.endif.endif.e...endif.1.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.1.endif ]
  %.159 = call ptr @PyErr_Occurred()
  %.160.not = icmp eq ptr %.159, null
  br i1 %.160.not, label %entry.endif.endif.endif.e...endif.1.endif.endif.endif, label %arg3.err, !prof !1

entry.endif.endif.endif.e...endif.1.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif
  %.176 = call i32 @_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.164, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.117.0, i64 %.133.0, i64 %.149.0) #3
  %.186 = load i64, ptr %.164, align 8
  call void @NRT_decref(ptr %.40.fca.0.load)
  call void @NRT_decref(ptr %.63.fca.0.load)
  call void @NRT_decref(ptr %.86.fca.0.load)
  call void @NRT_decref(ptr %.109.fca.0.load)
  %.205 = call ptr @PyLong_FromLongLong(i64 %.186)
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, inaccessiblemem: none, target_mem0: none, target_mem1: none)
define i64 @cfunc._ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5, i64 %.6, i64 %.7) local_unnamed_addr #2 {
entry:
  %.9 = alloca i64, align 8
  %.21 = call i32 @_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.9, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, i64 %.5, i64 %.6, i64 %.7) #3
  %.31 = load i64, ptr %.9, align 8
  ret i64 %.31
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

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(write, inaccessiblemem: none, target_mem0: none, target_mem1: none) }
attributes #3 = { noinline }
attributes #4 = { nounwind }

!0 = !{!"branch_weights", i32 1, i32 99}
!1 = !{!"branch_weights", i32 99, i32 1}
