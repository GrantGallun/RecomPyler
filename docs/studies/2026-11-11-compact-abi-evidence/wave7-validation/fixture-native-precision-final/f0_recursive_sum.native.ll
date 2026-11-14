define range(i32 -1, -2) i32 @_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr %arg._heap_F, ptr %arg._heap_I, ptr %arg._heap_top, ptr %arg._heap_st, i64 %arg._heap_len, i64 %arg.v_depth, double %arg.v_value) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.535 = alloca double, align 8
  %excinfo.6 = alloca ptr, align 8
  %.1001 = alloca double, align 8
  %excinfo.8 = alloca ptr, align 8
  %.192 = icmp slt i64 %arg.v_depth, 1
  br i1 %.192, label %B108, label %B114.endif

common.ret:                                       ; preds = %B632.if.if, %B280.if.if, %B776, %B770, %B606, %B518, %B418, %B254, %B166, %B108
  %common.ret.op = phi i32 [ 0, %B108 ], [ 0, %B166 ], [ 0, %B254 ], [ 0, %B418 ], [ 0, %B518 ], [ 0, %B606 ], [ 0, %B770 ], [ 0, %B776 ], [ %.1005, %B632.if.if ], [ %.539, %B280.if.if ]
  ret i32 %common.ret.op

B108:                                             ; preds = %B0.endif.endif.endif.endif
  store double %arg.v_value, ptr %retptr, align 8
  br label %common.ret

B166:                                             ; preds = %B114.endif
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B172:                                             ; preds = %B114.endif
  %.341 = getelementptr i8, ptr %arg._heap_top, i64 8
  %.342 = load i64, ptr %.341, align 8
  %.343 = add nsw i64 %.342, 1
  store i64 %.343, ptr %.341, align 8
  %.432 = getelementptr i8, ptr %arg._heap_top, i64 16
  %.433 = load i64, ptr %.432, align 8
  %.434.not = icmp slt i64 %.342, %.433
  br i1 %.434.not, label %B280, label %B254

B254:                                             ; preds = %B172
  store i8 1, ptr %arg._heap_st, align 1
  %.516 = getelementptr i8, ptr %arg._heap_top, i64 24
  store i64 4, ptr %.516, align 8
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B280:                                             ; preds = %B172
  %.539 = call i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr nonnull %.535, ptr nonnull %excinfo.6, ptr %arg._heap_F, ptr %arg._heap_I, ptr nonnull %arg._heap_top, ptr nonnull %arg._heap_st, i64 %arg._heap_len, i64 %.20.i, double %arg.v_value)
  %.549 = load double, ptr %.535, align 8
  %cond = icmp eq i32 %.539, 0
  br i1 %cond, label %B280.endif, label %B280.if.if, !prof !0

B418:                                             ; preds = %B280.endif
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B424:                                             ; preds = %B280.endif
  %sunkaddr = getelementptr i8, ptr %arg._heap_top, i64 8
  %.651 = load i64, ptr %sunkaddr, align 8
  %.652 = add nsw i64 %.651, -1
  store i64 %.652, ptr %sunkaddr, align 8
  %.746.pr = load i8, ptr %arg._heap_st, align 1
  %.20.i2 = add nsw i64 %arg.v_depth, -2
  %.747.not = icmp eq i8 %.746.pr, 0
  br i1 %.747.not, label %B524, label %B518

B518:                                             ; preds = %B424
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B524:                                             ; preds = %B424
  %sunkaddr38 = getelementptr i8, ptr %arg._heap_top, i64 8
  store i64 %.651, ptr %sunkaddr38, align 8
  %sunkaddr39 = getelementptr i8, ptr %arg._heap_top, i64 16
  %.897 = load i64, ptr %sunkaddr39, align 8
  %.898.not.not = icmp sgt i64 %.651, %.897
  br i1 %.898.not.not, label %B606, label %B632

B606:                                             ; preds = %B524
  store i8 1, ptr %arg._heap_st, align 1
  %.980 = getelementptr i8, ptr %arg._heap_top, i64 24
  store i64 4, ptr %.980, align 8
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B632:                                             ; preds = %B524
  %.1005 = call i32 @_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd(ptr nonnull %.1001, ptr nonnull %excinfo.8, ptr %arg._heap_F, ptr %arg._heap_I, ptr nonnull %arg._heap_top, ptr nonnull %arg._heap_st, i64 %arg._heap_len, i64 %.20.i2, double %arg.v_value)
  %.1015 = load double, ptr %.1001, align 8
  %cond37 = icmp eq i32 %.1005, 0
  br i1 %cond37, label %B632.endif, label %B632.if.if, !prof !0

B770:                                             ; preds = %B632.endif
  store double 0.000000e+00, ptr %retptr, align 8
  br label %common.ret

B776:                                             ; preds = %B632.endif
  %sunkaddr40 = getelementptr i8, ptr %arg._heap_top, i64 8
  %.1115 = load i64, ptr %sunkaddr40, align 8
  %.1116 = add nsw i64 %.1115, -1
  store i64 %.1116, ptr %sunkaddr40, align 8
  %.1154 = fadd double %.549, %.1015
  store double %.1154, ptr %retptr, align 8
  br label %common.ret

B114.endif:                                       ; preds = %B0.endif.endif.endif.endif
  %.20.i = add nsw i64 %arg.v_depth, -1
  %.282 = load i8, ptr %arg._heap_st, align 1
  %.283.not = icmp eq i8 %.282, 0
  br i1 %.283.not, label %B172, label %B166

B280.endif:                                       ; preds = %B280
  %.591 = load i8, ptr %arg._heap_st, align 1
  %.592.not = icmp eq i8 %.591, 0
  br i1 %.592.not, label %B424, label %B418

B280.if.if:                                       ; preds = %B280
  store ptr null, ptr %excinfo, align 8
  br label %common.ret

B632.endif:                                       ; preds = %B632
  %.1067 = load i8, ptr %arg._heap_st, align 1
  %.1073.not = icmp eq i8 %.1067, 0
  br i1 %.1073.not, label %B776, label %B770

B632.if.if:                                       ; preds = %B632
  store ptr null, ptr %excinfo, align 8
  br label %common.ret
}
