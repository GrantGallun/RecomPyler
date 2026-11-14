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
