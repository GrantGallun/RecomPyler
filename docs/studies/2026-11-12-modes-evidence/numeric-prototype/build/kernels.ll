; ModuleID = 'D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-formal-v1\inputs\kernels.c'
source_filename = "D:\\Code\\Datathon\\recompyler-codex-20261111\\wave10-measurements\\results-formal-v1\\inputs\\kernels.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-windows-msvc19.50.35730"

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport i64 @recurrence_1_exact(i64 noundef %x, i64 noundef %y, i64 noundef %z, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i64 %y, %x
  %add = add nsw i64 %mul, %z
  ret i64 %add
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport noundef i64 @recurrence_1_wrap(i64 noundef %x_in, i64 noundef %y_in, i64 noundef %z_in, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul i64 %y_in, %x_in
  %add = add i64 %mul, %z_in
  ret i64 %add
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport i64 @recurrence_16_exact(i64 noundef %x, i64 noundef %y, i64 noundef %z, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i64 %y, %x
  %add = add nsw i64 %mul, %z
  %mul1 = mul nsw i64 %add, %y
  %add2 = add nsw i64 %mul1, %z
  %mul3 = mul nsw i64 %add2, %y
  %add4 = add nsw i64 %mul3, %z
  %mul5 = mul nsw i64 %add4, %y
  %add6 = add nsw i64 %mul5, %z
  %mul7 = mul nsw i64 %add6, %y
  %add8 = add nsw i64 %mul7, %z
  %mul9 = mul nsw i64 %add8, %y
  %add10 = add nsw i64 %mul9, %z
  %mul11 = mul nsw i64 %add10, %y
  %add12 = add nsw i64 %mul11, %z
  %mul13 = mul nsw i64 %add12, %y
  %add14 = add nsw i64 %mul13, %z
  %mul15 = mul nsw i64 %add14, %y
  %add16 = add nsw i64 %mul15, %z
  %mul17 = mul nsw i64 %add16, %y
  %add18 = add nsw i64 %mul17, %z
  %mul19 = mul nsw i64 %add18, %y
  %add20 = add nsw i64 %mul19, %z
  %mul21 = mul nsw i64 %add20, %y
  %add22 = add nsw i64 %mul21, %z
  %mul23 = mul nsw i64 %add22, %y
  %add24 = add nsw i64 %mul23, %z
  %mul25 = mul nsw i64 %add24, %y
  %add26 = add nsw i64 %mul25, %z
  %mul27 = mul nsw i64 %add26, %y
  %add28 = add nsw i64 %mul27, %z
  %mul29 = mul nsw i64 %add28, %y
  %add30 = add nsw i64 %mul29, %z
  ret i64 %add30
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport i64 @recurrence_16_wrap(i64 noundef %x_in, i64 noundef %y_in, i64 noundef %z_in, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul i64 %y_in, %x_in
  %add = add i64 %mul, %z_in
  %mul1 = mul i64 %add, %y_in
  %add2 = add i64 %mul1, %z_in
  %mul3 = mul i64 %add2, %y_in
  %add4 = add i64 %mul3, %z_in
  %mul5 = mul i64 %add4, %y_in
  %add6 = add i64 %mul5, %z_in
  %mul7 = mul i64 %add6, %y_in
  %add8 = add i64 %mul7, %z_in
  %mul9 = mul i64 %add8, %y_in
  %add10 = add i64 %mul9, %z_in
  %mul11 = mul i64 %add10, %y_in
  %add12 = add i64 %mul11, %z_in
  %mul13 = mul i64 %add12, %y_in
  %add14 = add i64 %mul13, %z_in
  %mul15 = mul i64 %add14, %y_in
  %add16 = add i64 %mul15, %z_in
  %mul17 = mul i64 %add16, %y_in
  %add18 = add i64 %mul17, %z_in
  %mul19 = mul i64 %add18, %y_in
  %add20 = add i64 %mul19, %z_in
  %mul21 = mul i64 %add20, %y_in
  %add22 = add i64 %mul21, %z_in
  %mul23 = mul i64 %add22, %y_in
  %add24 = add i64 %mul23, %z_in
  %mul25 = mul i64 %add24, %y_in
  %add26 = add i64 %mul25, %z_in
  %mul27 = mul i64 %add26, %y_in
  %add28 = add i64 %mul27, %z_in
  %mul29 = mul i64 %add28, %y_in
  %add30 = add i64 %mul29, %z_in
  ret i64 %add30
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport i64 @recurrence_64_exact(i64 noundef %x, i64 noundef %y, i64 noundef %z, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i64 %y, %x
  %add = add nsw i64 %mul, %z
  %mul1 = mul nsw i64 %add, %y
  %add2 = add nsw i64 %mul1, %z
  %mul3 = mul nsw i64 %add2, %y
  %add4 = add nsw i64 %mul3, %z
  %mul5 = mul nsw i64 %add4, %y
  %add6 = add nsw i64 %mul5, %z
  %mul7 = mul nsw i64 %add6, %y
  %add8 = add nsw i64 %mul7, %z
  %mul9 = mul nsw i64 %add8, %y
  %add10 = add nsw i64 %mul9, %z
  %mul11 = mul nsw i64 %add10, %y
  %add12 = add nsw i64 %mul11, %z
  %mul13 = mul nsw i64 %add12, %y
  %add14 = add nsw i64 %mul13, %z
  %mul15 = mul nsw i64 %add14, %y
  %add16 = add nsw i64 %mul15, %z
  %mul17 = mul nsw i64 %add16, %y
  %add18 = add nsw i64 %mul17, %z
  %mul19 = mul nsw i64 %add18, %y
  %add20 = add nsw i64 %mul19, %z
  %mul21 = mul nsw i64 %add20, %y
  %add22 = add nsw i64 %mul21, %z
  %mul23 = mul nsw i64 %add22, %y
  %add24 = add nsw i64 %mul23, %z
  %mul25 = mul nsw i64 %add24, %y
  %add26 = add nsw i64 %mul25, %z
  %mul27 = mul nsw i64 %add26, %y
  %add28 = add nsw i64 %mul27, %z
  %mul29 = mul nsw i64 %add28, %y
  %add30 = add nsw i64 %mul29, %z
  %mul31 = mul nsw i64 %add30, %y
  %add32 = add nsw i64 %mul31, %z
  %mul33 = mul nsw i64 %add32, %y
  %add34 = add nsw i64 %mul33, %z
  %mul35 = mul nsw i64 %add34, %y
  %add36 = add nsw i64 %mul35, %z
  %mul37 = mul nsw i64 %add36, %y
  %add38 = add nsw i64 %mul37, %z
  %mul39 = mul nsw i64 %add38, %y
  %add40 = add nsw i64 %mul39, %z
  %mul41 = mul nsw i64 %add40, %y
  %add42 = add nsw i64 %mul41, %z
  %mul43 = mul nsw i64 %add42, %y
  %add44 = add nsw i64 %mul43, %z
  %mul45 = mul nsw i64 %add44, %y
  %add46 = add nsw i64 %mul45, %z
  %mul47 = mul nsw i64 %add46, %y
  %add48 = add nsw i64 %mul47, %z
  %mul49 = mul nsw i64 %add48, %y
  %add50 = add nsw i64 %mul49, %z
  %mul51 = mul nsw i64 %add50, %y
  %add52 = add nsw i64 %mul51, %z
  %mul53 = mul nsw i64 %add52, %y
  %add54 = add nsw i64 %mul53, %z
  %mul55 = mul nsw i64 %add54, %y
  %add56 = add nsw i64 %mul55, %z
  %mul57 = mul nsw i64 %add56, %y
  %add58 = add nsw i64 %mul57, %z
  %mul59 = mul nsw i64 %add58, %y
  %add60 = add nsw i64 %mul59, %z
  %mul61 = mul nsw i64 %add60, %y
  %add62 = add nsw i64 %mul61, %z
  %mul63 = mul nsw i64 %add62, %y
  %add64 = add nsw i64 %mul63, %z
  %mul65 = mul nsw i64 %add64, %y
  %add66 = add nsw i64 %mul65, %z
  %mul67 = mul nsw i64 %add66, %y
  %add68 = add nsw i64 %mul67, %z
  %mul69 = mul nsw i64 %add68, %y
  %add70 = add nsw i64 %mul69, %z
  %mul71 = mul nsw i64 %add70, %y
  %add72 = add nsw i64 %mul71, %z
  %mul73 = mul nsw i64 %add72, %y
  %add74 = add nsw i64 %mul73, %z
  %mul75 = mul nsw i64 %add74, %y
  %add76 = add nsw i64 %mul75, %z
  %mul77 = mul nsw i64 %add76, %y
  %add78 = add nsw i64 %mul77, %z
  %mul79 = mul nsw i64 %add78, %y
  %add80 = add nsw i64 %mul79, %z
  %mul81 = mul nsw i64 %add80, %y
  %add82 = add nsw i64 %mul81, %z
  %mul83 = mul nsw i64 %add82, %y
  %add84 = add nsw i64 %mul83, %z
  %mul85 = mul nsw i64 %add84, %y
  %add86 = add nsw i64 %mul85, %z
  %mul87 = mul nsw i64 %add86, %y
  %add88 = add nsw i64 %mul87, %z
  %mul89 = mul nsw i64 %add88, %y
  %add90 = add nsw i64 %mul89, %z
  %mul91 = mul nsw i64 %add90, %y
  %add92 = add nsw i64 %mul91, %z
  %mul93 = mul nsw i64 %add92, %y
  %add94 = add nsw i64 %mul93, %z
  %mul95 = mul nsw i64 %add94, %y
  %add96 = add nsw i64 %mul95, %z
  %mul97 = mul nsw i64 %add96, %y
  %add98 = add nsw i64 %mul97, %z
  %mul99 = mul nsw i64 %add98, %y
  %add100 = add nsw i64 %mul99, %z
  %mul101 = mul nsw i64 %add100, %y
  %add102 = add nsw i64 %mul101, %z
  %mul103 = mul nsw i64 %add102, %y
  %add104 = add nsw i64 %mul103, %z
  %mul105 = mul nsw i64 %add104, %y
  %add106 = add nsw i64 %mul105, %z
  %mul107 = mul nsw i64 %add106, %y
  %add108 = add nsw i64 %mul107, %z
  %mul109 = mul nsw i64 %add108, %y
  %add110 = add nsw i64 %mul109, %z
  %mul111 = mul nsw i64 %add110, %y
  %add112 = add nsw i64 %mul111, %z
  %mul113 = mul nsw i64 %add112, %y
  %add114 = add nsw i64 %mul113, %z
  %mul115 = mul nsw i64 %add114, %y
  %add116 = add nsw i64 %mul115, %z
  %mul117 = mul nsw i64 %add116, %y
  %add118 = add nsw i64 %mul117, %z
  %mul119 = mul nsw i64 %add118, %y
  %add120 = add nsw i64 %mul119, %z
  %mul121 = mul nsw i64 %add120, %y
  %add122 = add nsw i64 %mul121, %z
  %mul123 = mul nsw i64 %add122, %y
  %add124 = add nsw i64 %mul123, %z
  %mul125 = mul nsw i64 %add124, %y
  %add126 = add nsw i64 %mul125, %z
  ret i64 %add126
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local dllexport i64 @recurrence_64_wrap(i64 noundef %x_in, i64 noundef %y_in, i64 noundef %z_in, i64 noundef %unused_n) local_unnamed_addr #0 {
entry:
  %mul = mul i64 %y_in, %x_in
  %add = add i64 %mul, %z_in
  %mul1 = mul i64 %add, %y_in
  %add2 = add i64 %mul1, %z_in
  %mul3 = mul i64 %add2, %y_in
  %add4 = add i64 %mul3, %z_in
  %mul5 = mul i64 %add4, %y_in
  %add6 = add i64 %mul5, %z_in
  %mul7 = mul i64 %add6, %y_in
  %add8 = add i64 %mul7, %z_in
  %mul9 = mul i64 %add8, %y_in
  %add10 = add i64 %mul9, %z_in
  %mul11 = mul i64 %add10, %y_in
  %add12 = add i64 %mul11, %z_in
  %mul13 = mul i64 %add12, %y_in
  %add14 = add i64 %mul13, %z_in
  %mul15 = mul i64 %add14, %y_in
  %add16 = add i64 %mul15, %z_in
  %mul17 = mul i64 %add16, %y_in
  %add18 = add i64 %mul17, %z_in
  %mul19 = mul i64 %add18, %y_in
  %add20 = add i64 %mul19, %z_in
  %mul21 = mul i64 %add20, %y_in
  %add22 = add i64 %mul21, %z_in
  %mul23 = mul i64 %add22, %y_in
  %add24 = add i64 %mul23, %z_in
  %mul25 = mul i64 %add24, %y_in
  %add26 = add i64 %mul25, %z_in
  %mul27 = mul i64 %add26, %y_in
  %add28 = add i64 %mul27, %z_in
  %mul29 = mul i64 %add28, %y_in
  %add30 = add i64 %mul29, %z_in
  %mul31 = mul i64 %add30, %y_in
  %add32 = add i64 %mul31, %z_in
  %mul33 = mul i64 %add32, %y_in
  %add34 = add i64 %mul33, %z_in
  %mul35 = mul i64 %add34, %y_in
  %add36 = add i64 %mul35, %z_in
  %mul37 = mul i64 %add36, %y_in
  %add38 = add i64 %mul37, %z_in
  %mul39 = mul i64 %add38, %y_in
  %add40 = add i64 %mul39, %z_in
  %mul41 = mul i64 %add40, %y_in
  %add42 = add i64 %mul41, %z_in
  %mul43 = mul i64 %add42, %y_in
  %add44 = add i64 %mul43, %z_in
  %mul45 = mul i64 %add44, %y_in
  %add46 = add i64 %mul45, %z_in
  %mul47 = mul i64 %add46, %y_in
  %add48 = add i64 %mul47, %z_in
  %mul49 = mul i64 %add48, %y_in
  %add50 = add i64 %mul49, %z_in
  %mul51 = mul i64 %add50, %y_in
  %add52 = add i64 %mul51, %z_in
  %mul53 = mul i64 %add52, %y_in
  %add54 = add i64 %mul53, %z_in
  %mul55 = mul i64 %add54, %y_in
  %add56 = add i64 %mul55, %z_in
  %mul57 = mul i64 %add56, %y_in
  %add58 = add i64 %mul57, %z_in
  %mul59 = mul i64 %add58, %y_in
  %add60 = add i64 %mul59, %z_in
  %mul61 = mul i64 %add60, %y_in
  %add62 = add i64 %mul61, %z_in
  %mul63 = mul i64 %add62, %y_in
  %add64 = add i64 %mul63, %z_in
  %mul65 = mul i64 %add64, %y_in
  %add66 = add i64 %mul65, %z_in
  %mul67 = mul i64 %add66, %y_in
  %add68 = add i64 %mul67, %z_in
  %mul69 = mul i64 %add68, %y_in
  %add70 = add i64 %mul69, %z_in
  %mul71 = mul i64 %add70, %y_in
  %add72 = add i64 %mul71, %z_in
  %mul73 = mul i64 %add72, %y_in
  %add74 = add i64 %mul73, %z_in
  %mul75 = mul i64 %add74, %y_in
  %add76 = add i64 %mul75, %z_in
  %mul77 = mul i64 %add76, %y_in
  %add78 = add i64 %mul77, %z_in
  %mul79 = mul i64 %add78, %y_in
  %add80 = add i64 %mul79, %z_in
  %mul81 = mul i64 %add80, %y_in
  %add82 = add i64 %mul81, %z_in
  %mul83 = mul i64 %add82, %y_in
  %add84 = add i64 %mul83, %z_in
  %mul85 = mul i64 %add84, %y_in
  %add86 = add i64 %mul85, %z_in
  %mul87 = mul i64 %add86, %y_in
  %add88 = add i64 %mul87, %z_in
  %mul89 = mul i64 %add88, %y_in
  %add90 = add i64 %mul89, %z_in
  %mul91 = mul i64 %add90, %y_in
  %add92 = add i64 %mul91, %z_in
  %mul93 = mul i64 %add92, %y_in
  %add94 = add i64 %mul93, %z_in
  %mul95 = mul i64 %add94, %y_in
  %add96 = add i64 %mul95, %z_in
  %mul97 = mul i64 %add96, %y_in
  %add98 = add i64 %mul97, %z_in
  %mul99 = mul i64 %add98, %y_in
  %add100 = add i64 %mul99, %z_in
  %mul101 = mul i64 %add100, %y_in
  %add102 = add i64 %mul101, %z_in
  %mul103 = mul i64 %add102, %y_in
  %add104 = add i64 %mul103, %z_in
  %mul105 = mul i64 %add104, %y_in
  %add106 = add i64 %mul105, %z_in
  %mul107 = mul i64 %add106, %y_in
  %add108 = add i64 %mul107, %z_in
  %mul109 = mul i64 %add108, %y_in
  %add110 = add i64 %mul109, %z_in
  %mul111 = mul i64 %add110, %y_in
  %add112 = add i64 %mul111, %z_in
  %mul113 = mul i64 %add112, %y_in
  %add114 = add i64 %mul113, %z_in
  %mul115 = mul i64 %add114, %y_in
  %add116 = add i64 %mul115, %z_in
  %mul117 = mul i64 %add116, %y_in
  %add118 = add i64 %mul117, %z_in
  %mul119 = mul i64 %add118, %y_in
  %add120 = add i64 %mul119, %z_in
  %mul121 = mul i64 %add120, %y_in
  %add122 = add i64 %mul121, %z_in
  %mul123 = mul i64 %add122, %y_in
  %add124 = add i64 %mul123, %z_in
  %mul125 = mul i64 %add124, %y_in
  %add126 = add i64 %mul125, %z_in
  ret i64 %add126
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(none) uwtable
define dso_local dllexport i64 @loop_recurrence16_exact(i64 noundef %x_in, i64 noundef %y_in, i64 noundef %z_in, i64 noundef %n) local_unnamed_addr #1 {
entry:
  %cmp78 = icmp sgt i64 %n, 0
  br i1 %cmp78, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %t.0.lcssa = phi i64 [ %x_in, %entry ], [ %add30, %for.body ]
  ret i64 %t.0.lcssa

for.body:                                         ; preds = %entry, %for.body
  %i.080 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %t.079 = phi i64 [ %add30, %for.body ], [ %x_in, %entry ]
  %mul = mul nsw i64 %t.079, %y_in
  %add = add nsw i64 %mul, %z_in
  %mul1 = mul nsw i64 %add, %y_in
  %add2 = add nsw i64 %mul1, %z_in
  %mul3 = mul nsw i64 %add2, %y_in
  %add4 = add nsw i64 %mul3, %z_in
  %mul5 = mul nsw i64 %add4, %y_in
  %add6 = add nsw i64 %mul5, %z_in
  %mul7 = mul nsw i64 %add6, %y_in
  %add8 = add nsw i64 %mul7, %z_in
  %mul9 = mul nsw i64 %add8, %y_in
  %add10 = add nsw i64 %mul9, %z_in
  %mul11 = mul nsw i64 %add10, %y_in
  %add12 = add nsw i64 %mul11, %z_in
  %mul13 = mul nsw i64 %add12, %y_in
  %add14 = add nsw i64 %mul13, %z_in
  %mul15 = mul nsw i64 %add14, %y_in
  %add16 = add nsw i64 %mul15, %z_in
  %mul17 = mul nsw i64 %add16, %y_in
  %add18 = add nsw i64 %mul17, %z_in
  %mul19 = mul nsw i64 %add18, %y_in
  %add20 = add nsw i64 %mul19, %z_in
  %mul21 = mul nsw i64 %add20, %y_in
  %add22 = add nsw i64 %mul21, %z_in
  %mul23 = mul nsw i64 %add22, %y_in
  %add24 = add nsw i64 %mul23, %z_in
  %mul25 = mul nsw i64 %add24, %y_in
  %add26 = add nsw i64 %mul25, %z_in
  %mul27 = mul nsw i64 %add26, %y_in
  %add28 = add nsw i64 %mul27, %z_in
  %mul29 = mul nsw i64 %add28, %y_in
  %add30 = add nsw i64 %mul29, %z_in
  %inc = add nuw nsw i64 %i.080, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !10
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(none) uwtable
define dso_local dllexport i64 @loop_recurrence16_wrap(i64 noundef %x_in, i64 noundef %y_in, i64 noundef %z_in, i64 noundef %n) local_unnamed_addr #1 {
entry:
  %cmp78 = icmp sgt i64 %n, 0
  br i1 %cmp78, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %t.0.lcssa = phi i64 [ %x_in, %entry ], [ %add30, %for.body ]
  ret i64 %t.0.lcssa

for.body:                                         ; preds = %entry, %for.body
  %i.080 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %t.079 = phi i64 [ %add30, %for.body ], [ %x_in, %entry ]
  %mul = mul i64 %t.079, %y_in
  %add = add i64 %mul, %z_in
  %mul1 = mul i64 %add, %y_in
  %add2 = add i64 %mul1, %z_in
  %mul3 = mul i64 %add2, %y_in
  %add4 = add i64 %mul3, %z_in
  %mul5 = mul i64 %add4, %y_in
  %add6 = add i64 %mul5, %z_in
  %mul7 = mul i64 %add6, %y_in
  %add8 = add i64 %mul7, %z_in
  %mul9 = mul i64 %add8, %y_in
  %add10 = add i64 %mul9, %z_in
  %mul11 = mul i64 %add10, %y_in
  %add12 = add i64 %mul11, %z_in
  %mul13 = mul i64 %add12, %y_in
  %add14 = add i64 %mul13, %z_in
  %mul15 = mul i64 %add14, %y_in
  %add16 = add i64 %mul15, %z_in
  %mul17 = mul i64 %add16, %y_in
  %add18 = add i64 %mul17, %z_in
  %mul19 = mul i64 %add18, %y_in
  %add20 = add i64 %mul19, %z_in
  %mul21 = mul i64 %add20, %y_in
  %add22 = add i64 %mul21, %z_in
  %mul23 = mul i64 %add22, %y_in
  %add24 = add i64 %mul23, %z_in
  %mul25 = mul i64 %add24, %y_in
  %add26 = add i64 %mul25, %z_in
  %mul27 = mul i64 %add26, %y_in
  %add28 = add i64 %mul27, %z_in
  %mul29 = mul i64 %add28, %y_in
  %add30 = add i64 %mul29, %z_in
  %inc = add nuw nsw i64 %i.080, 1
  %exitcond.not = icmp eq i64 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !12
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(none) uwtable
define dso_local dllexport i64 @fibonacci_exact(i64 noundef %n, i64 noundef %unused_y, i64 noundef %unused_z, i64 noundef %unused_n) local_unnamed_addr #1 {
entry:
  %cmp4 = icmp sgt i64 %n, 0
  br i1 %cmp4, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %xtraiter = and i64 %n, 7
  %0 = icmp ult i64 %n, 8
  br i1 %0, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = and i64 %n, 9223372036854775800
  br label %for.body

for.cond.cleanup.loopexit.unr-lcssa:              ; preds = %for.body, %for.body.preheader
  %b.05.lcssa.ph = phi i64 [ poison, %for.body.preheader ], [ %add.6, %for.body ]
  %a.07.unr = phi i64 [ 0, %for.body.preheader ], [ %add.6, %for.body ]
  %b.05.unr = phi i64 [ 1, %for.body.preheader ], [ %add.7, %for.body ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.cond.cleanup, label %for.body.epil

for.body.epil:                                    ; preds = %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil
  %a.07.epil = phi i64 [ %b.05.epil, %for.body.epil ], [ %a.07.unr, %for.cond.cleanup.loopexit.unr-lcssa ]
  %b.05.epil = phi i64 [ %add.epil, %for.body.epil ], [ %b.05.unr, %for.cond.cleanup.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.next, %for.body.epil ], [ 0, %for.cond.cleanup.loopexit.unr-lcssa ]
  %add.epil = add nsw i64 %a.07.epil, %b.05.epil
  %epil.iter.next = add i64 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %for.cond.cleanup, label %for.body.epil, !llvm.loop !13

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil, %entry
  %a.0.lcssa = phi i64 [ 0, %entry ], [ %b.05.lcssa.ph, %for.cond.cleanup.loopexit.unr-lcssa ], [ %b.05.epil, %for.body.epil ]
  ret i64 %a.0.lcssa

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %a.07 = phi i64 [ 0, %for.body.preheader.new ], [ %add.6, %for.body ]
  %b.05 = phi i64 [ 1, %for.body.preheader.new ], [ %add.7, %for.body ]
  %niter = phi i64 [ 0, %for.body.preheader.new ], [ %niter.next.7, %for.body ]
  %add = add nsw i64 %a.07, %b.05
  %add.1 = add nsw i64 %b.05, %add
  %add.2 = add nsw i64 %add, %add.1
  %add.3 = add nsw i64 %add.1, %add.2
  %add.4 = add nsw i64 %add.2, %add.3
  %add.5 = add nsw i64 %add.3, %add.4
  %add.6 = add nsw i64 %add.4, %add.5
  %add.7 = add nsw i64 %add.5, %add.6
  %niter.next.7 = add i64 %niter, 8
  %niter.ncmp.7 = icmp eq i64 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body, !llvm.loop !15
}

; Function Attrs: nofree noinline norecurse nosync nounwind memory(none) uwtable
define dso_local dllexport i64 @fibonacci_wrap(i64 noundef %n, i64 noundef %unused_y, i64 noundef %unused_z, i64 noundef %unused_n) local_unnamed_addr #1 {
entry:
  %cmp4 = icmp sgt i64 %n, 0
  br i1 %cmp4, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %xtraiter = and i64 %n, 7
  %0 = icmp ult i64 %n, 8
  br i1 %0, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = and i64 %n, 9223372036854775800
  br label %for.body

for.cond.cleanup.loopexit.unr-lcssa:              ; preds = %for.body, %for.body.preheader
  %b.05.lcssa.ph = phi i64 [ poison, %for.body.preheader ], [ %add.6, %for.body ]
  %a.07.unr = phi i64 [ 0, %for.body.preheader ], [ %add.6, %for.body ]
  %b.05.unr = phi i64 [ 1, %for.body.preheader ], [ %add.7, %for.body ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.cond.cleanup, label %for.body.epil

for.body.epil:                                    ; preds = %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil
  %a.07.epil = phi i64 [ %b.05.epil, %for.body.epil ], [ %a.07.unr, %for.cond.cleanup.loopexit.unr-lcssa ]
  %b.05.epil = phi i64 [ %add.epil, %for.body.epil ], [ %b.05.unr, %for.cond.cleanup.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.next, %for.body.epil ], [ 0, %for.cond.cleanup.loopexit.unr-lcssa ]
  %add.epil = add i64 %a.07.epil, %b.05.epil
  %epil.iter.next = add i64 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %for.cond.cleanup, label %for.body.epil, !llvm.loop !16

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil, %entry
  %a.0.lcssa = phi i64 [ 0, %entry ], [ %b.05.lcssa.ph, %for.cond.cleanup.loopexit.unr-lcssa ], [ %b.05.epil, %for.body.epil ]
  ret i64 %a.0.lcssa

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %a.07 = phi i64 [ 0, %for.body.preheader.new ], [ %add.6, %for.body ]
  %b.05 = phi i64 [ 1, %for.body.preheader.new ], [ %add.7, %for.body ]
  %niter = phi i64 [ 0, %for.body.preheader.new ], [ %niter.next.7, %for.body ]
  %add = add i64 %a.07, %b.05
  %add.1 = add i64 %b.05, %add
  %add.2 = add i64 %add, %add.1
  %add.3 = add i64 %add.1, %add.2
  %add.4 = add i64 %add.2, %add.3
  %add.5 = add i64 %add.3, %add.4
  %add.6 = add i64 %add.4, %add.5
  %add.7 = add i64 %add.5, %add.6
  %niter.next.7 = add i64 %niter, 8
  %niter.ncmp.7 = icmp eq i64 %niter.next.7, %unroll_iter
  br i1 %niter.ncmp.7, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body, !llvm.loop !17
}

attributes #0 = { mustprogress nofree noinline norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #1 = { nofree noinline norecurse nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" }

!llvm.dbg.cu = !{!0}
!llvm.linker.options = !{!2, !3}
!llvm.module.flags = !{!4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 21.1.6", isOptimized: true, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "D:\\Code\\Datathon\\recompyler-codex-20261111\\wave10-measurements\\results-formal-v1\\inputs\\kernels.c", directory: "D:\\Code\\Datathon\\recompyler-codex-20261111\\wave10-measurements\\results-formal-v1")
!2 = !{!"/DEFAULTLIB:msvcrt.lib"}
!3 = !{!"/DEFAULTLIB:oldnames.lib"}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 2}
!6 = !{i32 8, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 1, !"MaxTLSAlign", i32 65536}
!9 = !{!"clang version 21.1.6"}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.unroll.disable"}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !14}
!17 = distinct !{!17, !11}
