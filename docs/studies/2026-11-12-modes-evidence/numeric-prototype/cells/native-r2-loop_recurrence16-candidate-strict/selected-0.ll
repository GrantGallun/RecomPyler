; ModuleID = 'f0_loop_recurrence16'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_loop_recurrence16 = internal constant [21 x i8] c"f0_loop_recurrence16\00"
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx" = internal constant [272 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx\00"
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function.2" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e95mul_iB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e95add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_TypeError = external global i8
@PyExc_RuntimeError = external global i8

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite)
define noundef range(i32 -1, -2) i32 @_ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z, i64 %arg.v_n) local_unnamed_addr #0 {
B0.endif:
  %.arg.v_n = tail call i64 @llvm.smax.i64(i64 %arg.v_n, i64 0)
  %.27.i = sitofp i64 %arg.v_y to double
  %0 = add nuw i64 %.arg.v_n, 1
  br label %B34

B34:                                              ; preds = %B1992, %B0.endif
  %lsr.iv = phi i64 [ %lsr.iv.next, %B1992 ], [ %0, %B0.endif ]
  %v_t.17.0 = phi i64 [ %arg.v_x, %B0.endif ], [ %.20.i1325, %B1992 ]
  %lsr.iv.next = add i64 %lsr.iv, -1
  %.155 = icmp sgt i64 %lsr.iv.next, 0
  br i1 %.155, label %B40, label %common.ret

B40:                                              ; preds = %B34
  %.25.i = sitofp i64 %v_t.17.0 to double
  %.28.i = fmul double %.27.i, %.25.i
  %1 = tail call double @llvm.fabs.f64(double %.28.i)
  %or.cond.i = fcmp ult double %1, 9.200000e+18
  br i1 %or.cond.i, label %B40.endif, label %common.ret.sink.split

common.ret.sink.split:                            ; preds = %B40, %B1992, %B1928, %B1866, %B1802, %B1740, %B1676, %B1614, %B1550, %B1488, %B1424, %B1362, %B1298, %B1236, %B1172, %B1110, %B1046, %B984, %B920, %B858, %B794, %B732, %B668, %B606, %B542, %B480, %B416, %B354, %B290, %B230, %B166, %B106
  store i8 1, ptr %arg.st.4, align 1, !noalias !0
  br label %common.ret

common.ret:                                       ; preds = %B34, %B40.endif, %common.ret.sink.split
  %v_t.17.0.lcssa.sink = phi i64 [ 0, %common.ret.sink.split ], [ %v_t.17.0, %B34 ], [ 0, %B40.endif ]
  store i64 %v_t.17.0.lcssa.sink, ptr %retptr, align 8
  ret i32 0

B106:                                             ; preds = %B40.endif
  %.96.i = mul nsw i64 %v_t.17.0, %arg.v_y
  %.20.i = add nsw i64 %.96.i, %arg.v_z
  %.25.i1089 = xor i64 %.20.i, %.96.i
  %.27.i1090 = xor i64 %.20.i, %arg.v_z
  %.28.i1091 = and i64 %.25.i1089, %.27.i1090
  %.29.i = icmp slt i64 %.28.i1091, 0
  br i1 %.29.i, label %common.ret.sink.split, label %B166

B166:                                             ; preds = %B106
  %.25.i1092 = sitofp i64 %.20.i to double
  %.28.i1094 = fmul double %.27.i, %.25.i1092
  %2 = tail call double @llvm.fabs.f64(double %.28.i1094)
  %or.cond.i1095 = fcmp ult double %2, 9.200000e+18
  br i1 %or.cond.i1095, label %B230, label %common.ret.sink.split

B230:                                             ; preds = %B166
  %.96.i1099 = mul nsw i64 %.20.i, %arg.v_y
  %.20.i1101 = add nsw i64 %.96.i1099, %arg.v_z
  %.25.i1102 = xor i64 %.20.i1101, %.96.i1099
  %.27.i1103 = xor i64 %.20.i1101, %arg.v_z
  %.28.i1104 = and i64 %.25.i1102, %.27.i1103
  %.29.i1105 = icmp slt i64 %.28.i1104, 0
  br i1 %.29.i1105, label %common.ret.sink.split, label %B290

B290:                                             ; preds = %B230
  %.25.i1108 = sitofp i64 %.20.i1101 to double
  %.28.i1110 = fmul double %.27.i, %.25.i1108
  %3 = tail call double @llvm.fabs.f64(double %.28.i1110)
  %or.cond.i1111 = fcmp ult double %3, 9.200000e+18
  br i1 %or.cond.i1111, label %B354, label %common.ret.sink.split

B354:                                             ; preds = %B290
  %.96.i1115 = mul nsw i64 %.20.i1101, %arg.v_y
  %.20.i1117 = add nsw i64 %.96.i1115, %arg.v_z
  %.25.i1118 = xor i64 %.20.i1117, %.96.i1115
  %.27.i1119 = xor i64 %.20.i1117, %arg.v_z
  %.28.i1120 = and i64 %.25.i1118, %.27.i1119
  %.29.i1121 = icmp slt i64 %.28.i1120, 0
  br i1 %.29.i1121, label %common.ret.sink.split, label %B416

B416:                                             ; preds = %B354
  %.25.i1124 = sitofp i64 %.20.i1117 to double
  %.28.i1126 = fmul double %.27.i, %.25.i1124
  %4 = tail call double @llvm.fabs.f64(double %.28.i1126)
  %or.cond.i1127 = fcmp ult double %4, 9.200000e+18
  br i1 %or.cond.i1127, label %B480, label %common.ret.sink.split

B480:                                             ; preds = %B416
  %.96.i1131 = mul nsw i64 %.20.i1117, %arg.v_y
  %.20.i1133 = add nsw i64 %.96.i1131, %arg.v_z
  %.25.i1134 = xor i64 %.20.i1133, %.96.i1131
  %.27.i1135 = xor i64 %.20.i1133, %arg.v_z
  %.28.i1136 = and i64 %.25.i1134, %.27.i1135
  %.29.i1137 = icmp slt i64 %.28.i1136, 0
  br i1 %.29.i1137, label %common.ret.sink.split, label %B542

B542:                                             ; preds = %B480
  %.25.i1140 = sitofp i64 %.20.i1133 to double
  %.28.i1142 = fmul double %.27.i, %.25.i1140
  %5 = tail call double @llvm.fabs.f64(double %.28.i1142)
  %or.cond.i1143 = fcmp ult double %5, 9.200000e+18
  br i1 %or.cond.i1143, label %B606, label %common.ret.sink.split

B606:                                             ; preds = %B542
  %.96.i1147 = mul nsw i64 %.20.i1133, %arg.v_y
  %.20.i1149 = add nsw i64 %.96.i1147, %arg.v_z
  %.25.i1150 = xor i64 %.20.i1149, %.96.i1147
  %.27.i1151 = xor i64 %.20.i1149, %arg.v_z
  %.28.i1152 = and i64 %.25.i1150, %.27.i1151
  %.29.i1153 = icmp slt i64 %.28.i1152, 0
  br i1 %.29.i1153, label %common.ret.sink.split, label %B668

B668:                                             ; preds = %B606
  %.25.i1156 = sitofp i64 %.20.i1149 to double
  %.28.i1158 = fmul double %.27.i, %.25.i1156
  %6 = tail call double @llvm.fabs.f64(double %.28.i1158)
  %or.cond.i1159 = fcmp ult double %6, 9.200000e+18
  br i1 %or.cond.i1159, label %B732, label %common.ret.sink.split

B732:                                             ; preds = %B668
  %.96.i1163 = mul nsw i64 %.20.i1149, %arg.v_y
  %.20.i1165 = add nsw i64 %.96.i1163, %arg.v_z
  %.25.i1166 = xor i64 %.20.i1165, %.96.i1163
  %.27.i1167 = xor i64 %.20.i1165, %arg.v_z
  %.28.i1168 = and i64 %.25.i1166, %.27.i1167
  %.29.i1169 = icmp slt i64 %.28.i1168, 0
  br i1 %.29.i1169, label %common.ret.sink.split, label %B794

B794:                                             ; preds = %B732
  %.25.i1172 = sitofp i64 %.20.i1165 to double
  %.28.i1174 = fmul double %.27.i, %.25.i1172
  %7 = tail call double @llvm.fabs.f64(double %.28.i1174)
  %or.cond.i1175 = fcmp ult double %7, 9.200000e+18
  br i1 %or.cond.i1175, label %B858, label %common.ret.sink.split

B858:                                             ; preds = %B794
  %.96.i1179 = mul nsw i64 %.20.i1165, %arg.v_y
  %.20.i1181 = add nsw i64 %.96.i1179, %arg.v_z
  %.25.i1182 = xor i64 %.20.i1181, %.96.i1179
  %.27.i1183 = xor i64 %.20.i1181, %arg.v_z
  %.28.i1184 = and i64 %.25.i1182, %.27.i1183
  %.29.i1185 = icmp slt i64 %.28.i1184, 0
  br i1 %.29.i1185, label %common.ret.sink.split, label %B920

B920:                                             ; preds = %B858
  %.25.i1188 = sitofp i64 %.20.i1181 to double
  %.28.i1190 = fmul double %.27.i, %.25.i1188
  %8 = tail call double @llvm.fabs.f64(double %.28.i1190)
  %or.cond.i1191 = fcmp ult double %8, 9.200000e+18
  br i1 %or.cond.i1191, label %B984, label %common.ret.sink.split

B984:                                             ; preds = %B920
  %.96.i1195 = mul nsw i64 %.20.i1181, %arg.v_y
  %.20.i1197 = add nsw i64 %.96.i1195, %arg.v_z
  %.25.i1198 = xor i64 %.20.i1197, %.96.i1195
  %.27.i1199 = xor i64 %.20.i1197, %arg.v_z
  %.28.i1200 = and i64 %.25.i1198, %.27.i1199
  %.29.i1201 = icmp slt i64 %.28.i1200, 0
  br i1 %.29.i1201, label %common.ret.sink.split, label %B1046

B1046:                                            ; preds = %B984
  %.25.i1204 = sitofp i64 %.20.i1197 to double
  %.28.i1206 = fmul double %.27.i, %.25.i1204
  %9 = tail call double @llvm.fabs.f64(double %.28.i1206)
  %or.cond.i1207 = fcmp ult double %9, 9.200000e+18
  br i1 %or.cond.i1207, label %B1110, label %common.ret.sink.split

B1110:                                            ; preds = %B1046
  %.96.i1211 = mul nsw i64 %.20.i1197, %arg.v_y
  %.20.i1213 = add nsw i64 %.96.i1211, %arg.v_z
  %.25.i1214 = xor i64 %.20.i1213, %.96.i1211
  %.27.i1215 = xor i64 %.20.i1213, %arg.v_z
  %.28.i1216 = and i64 %.25.i1214, %.27.i1215
  %.29.i1217 = icmp slt i64 %.28.i1216, 0
  br i1 %.29.i1217, label %common.ret.sink.split, label %B1172

B1172:                                            ; preds = %B1110
  %.25.i1220 = sitofp i64 %.20.i1213 to double
  %.28.i1222 = fmul double %.27.i, %.25.i1220
  %10 = tail call double @llvm.fabs.f64(double %.28.i1222)
  %or.cond.i1223 = fcmp ult double %10, 9.200000e+18
  br i1 %or.cond.i1223, label %B1236, label %common.ret.sink.split

B1236:                                            ; preds = %B1172
  %.96.i1227 = mul nsw i64 %.20.i1213, %arg.v_y
  %.20.i1229 = add nsw i64 %.96.i1227, %arg.v_z
  %.25.i1230 = xor i64 %.20.i1229, %.96.i1227
  %.27.i1231 = xor i64 %.20.i1229, %arg.v_z
  %.28.i1232 = and i64 %.25.i1230, %.27.i1231
  %.29.i1233 = icmp slt i64 %.28.i1232, 0
  br i1 %.29.i1233, label %common.ret.sink.split, label %B1298

B1298:                                            ; preds = %B1236
  %.25.i1236 = sitofp i64 %.20.i1229 to double
  %.28.i1238 = fmul double %.27.i, %.25.i1236
  %11 = tail call double @llvm.fabs.f64(double %.28.i1238)
  %or.cond.i1239 = fcmp ult double %11, 9.200000e+18
  br i1 %or.cond.i1239, label %B1362, label %common.ret.sink.split

B1362:                                            ; preds = %B1298
  %.96.i1243 = mul nsw i64 %.20.i1229, %arg.v_y
  %.20.i1245 = add nsw i64 %.96.i1243, %arg.v_z
  %.25.i1246 = xor i64 %.20.i1245, %.96.i1243
  %.27.i1247 = xor i64 %.20.i1245, %arg.v_z
  %.28.i1248 = and i64 %.25.i1246, %.27.i1247
  %.29.i1249 = icmp slt i64 %.28.i1248, 0
  br i1 %.29.i1249, label %common.ret.sink.split, label %B1424

B1424:                                            ; preds = %B1362
  %.25.i1252 = sitofp i64 %.20.i1245 to double
  %.28.i1254 = fmul double %.27.i, %.25.i1252
  %12 = tail call double @llvm.fabs.f64(double %.28.i1254)
  %or.cond.i1255 = fcmp ult double %12, 9.200000e+18
  br i1 %or.cond.i1255, label %B1488, label %common.ret.sink.split

B1488:                                            ; preds = %B1424
  %.96.i1259 = mul nsw i64 %.20.i1245, %arg.v_y
  %.20.i1261 = add nsw i64 %.96.i1259, %arg.v_z
  %.25.i1262 = xor i64 %.20.i1261, %.96.i1259
  %.27.i1263 = xor i64 %.20.i1261, %arg.v_z
  %.28.i1264 = and i64 %.25.i1262, %.27.i1263
  %.29.i1265 = icmp slt i64 %.28.i1264, 0
  br i1 %.29.i1265, label %common.ret.sink.split, label %B1550

B1550:                                            ; preds = %B1488
  %.25.i1268 = sitofp i64 %.20.i1261 to double
  %.28.i1270 = fmul double %.27.i, %.25.i1268
  %13 = tail call double @llvm.fabs.f64(double %.28.i1270)
  %or.cond.i1271 = fcmp ult double %13, 9.200000e+18
  br i1 %or.cond.i1271, label %B1614, label %common.ret.sink.split

B1614:                                            ; preds = %B1550
  %.96.i1275 = mul nsw i64 %.20.i1261, %arg.v_y
  %.20.i1277 = add nsw i64 %.96.i1275, %arg.v_z
  %.25.i1278 = xor i64 %.20.i1277, %.96.i1275
  %.27.i1279 = xor i64 %.20.i1277, %arg.v_z
  %.28.i1280 = and i64 %.25.i1278, %.27.i1279
  %.29.i1281 = icmp slt i64 %.28.i1280, 0
  br i1 %.29.i1281, label %common.ret.sink.split, label %B1676

B1676:                                            ; preds = %B1614
  %.25.i1284 = sitofp i64 %.20.i1277 to double
  %.28.i1286 = fmul double %.27.i, %.25.i1284
  %14 = tail call double @llvm.fabs.f64(double %.28.i1286)
  %or.cond.i1287 = fcmp ult double %14, 9.200000e+18
  br i1 %or.cond.i1287, label %B1740, label %common.ret.sink.split

B1740:                                            ; preds = %B1676
  %.96.i1291 = mul nsw i64 %.20.i1277, %arg.v_y
  %.20.i1293 = add nsw i64 %.96.i1291, %arg.v_z
  %.25.i1294 = xor i64 %.20.i1293, %.96.i1291
  %.27.i1295 = xor i64 %.20.i1293, %arg.v_z
  %.28.i1296 = and i64 %.25.i1294, %.27.i1295
  %.29.i1297 = icmp slt i64 %.28.i1296, 0
  br i1 %.29.i1297, label %common.ret.sink.split, label %B1802

B1802:                                            ; preds = %B1740
  %.25.i1300 = sitofp i64 %.20.i1293 to double
  %.28.i1302 = fmul double %.27.i, %.25.i1300
  %15 = tail call double @llvm.fabs.f64(double %.28.i1302)
  %or.cond.i1303 = fcmp ult double %15, 9.200000e+18
  br i1 %or.cond.i1303, label %B1866, label %common.ret.sink.split

B1866:                                            ; preds = %B1802
  %.96.i1307 = mul nsw i64 %.20.i1293, %arg.v_y
  %.20.i1309 = add nsw i64 %.96.i1307, %arg.v_z
  %.25.i1310 = xor i64 %.20.i1309, %.96.i1307
  %.27.i1311 = xor i64 %.20.i1309, %arg.v_z
  %.28.i1312 = and i64 %.25.i1310, %.27.i1311
  %.29.i1313 = icmp slt i64 %.28.i1312, 0
  br i1 %.29.i1313, label %common.ret.sink.split, label %B1928

B1928:                                            ; preds = %B1866
  %.25.i1316 = sitofp i64 %.20.i1309 to double
  %.28.i1318 = fmul double %.27.i, %.25.i1316
  %16 = tail call double @llvm.fabs.f64(double %.28.i1318)
  %or.cond.i1319 = fcmp ult double %16, 9.200000e+18
  br i1 %or.cond.i1319, label %B1992, label %common.ret.sink.split

B1992:                                            ; preds = %B1928
  %.96.i1323 = mul nsw i64 %.20.i1309, %arg.v_y
  %.20.i1325 = add nsw i64 %.96.i1323, %arg.v_z
  %.25.i1326 = xor i64 %.20.i1325, %.96.i1323
  %.27.i1327 = xor i64 %.20.i1325, %arg.v_z
  %.28.i1328 = and i64 %.25.i1326, %.27.i1327
  %.29.i1329 = icmp slt i64 %.28.i1328, 0
  br i1 %.29.i1329, label %common.ret.sink.split, label %B34

B40.endif:                                        ; preds = %B40
  %.257.pr = load i8, ptr %arg.st.4, align 1
  %.258.not = icmp eq i8 %.257.pr, 0
  br i1 %.258.not, label %B106, label %common.ret
}

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #1

define ptr @_ZN7cpython32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
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
  br i1 %.14, label %common.ret, label %entry.endif, !prof !1

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %entry.endif.endif.endif.e...endif.2.endif.endif.endif, %entry.endif.endif.endif.e...if.5, %entry.endif.endif.endif.e...endif.5.endif, %arg0.err, %entry, %entry.endif.endif.endif.e...endif.2.endif.if.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.e...endif.5.endif ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.e...if.5 ], [ %.222, %entry.endif.endif.endif.e...endif.2.endif.if.endif ], [ null, %arg0.err ], [ null, %entry.endif.endif.endif.thread ], [ null, %entry.endif.endif.endif.e...endif.2.endif.endif.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.18 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, align 8
  %.21 = icmp eq ptr %.18, null
  br i1 %.21, label %entry.endif.if, label %entry.endif.endif, !prof !1

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx")
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
  br i1 %.37, label %entry.endif.endif.endif.thread, label %entry.endif.endif.endif.endif, !prof !1

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
  br i1 %.60, label %entry.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif, !prof !1

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
  br i1 %.83, label %entry.endif.endif.endif.endif.endif.endif.endif.thread, label %entry.endif.endif.endif.endif.endif.endif.endif.endif, !prof !1

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
  br i1 %.106, label %entry.endif.endif.endif.e...endif.thread, label %entry.endif.endif.endif.e...endif.endif, !prof !1

arg2.err:                                         ; preds = %entry.endif.endif.endif.e...endif.thread, %arg3.err
  call void @NRT_decref(ptr %.87.fca.0.load)
  br label %arg1.err

entry.endif.endif.endif.e...endif.thread:         ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_TypeError, ptr nonnull @".const.can't unbox array from PyObject into native value.  The object maybe of a different type")
  br label %arg2.err

entry.endif.endif.endif.e...endif.endif:          ; preds = %entry.endif.endif.endif.endif.endif.endif.endif.endif
  %.110.fca.0.load = load ptr, ptr %.95, align 8
  %sunkaddr4 = getelementptr inbounds i8, ptr %.95, i64 32
  %.110.fca.4.load = load ptr, ptr %sunkaddr4, align 8
  %.117 = load ptr, ptr %.9, align 8
  %.120 = call ptr @PyNumber_Long(ptr %.117)
  %.121.not = icmp eq ptr %.120, null
  br i1 %.121.not, label %entry.endif.endif.endif.e...endif.endif.endif, label %entry.endif.endif.endif.e...endif.endif.if, !prof !1

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
  br i1 %.129.not, label %entry.endif.endif.endif.e...endif.endif.endif.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.endif.endif
  %.133 = load ptr, ptr %.10, align 8
  %.136 = call ptr @PyNumber_Long(ptr %.133)
  %.137.not = icmp eq ptr %.136, null
  br i1 %.137.not, label %entry.endif.endif.endif.e...endif.1, label %entry.endif.endif.endif.e...if.1, !prof !1

entry.endif.endif.endif.e...if.1:                 ; preds = %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.139 = call i64 @PyLong_AsLongLong(ptr nonnull %.136)
  call void @Py_DecRef(ptr nonnull %.136)
  br label %entry.endif.endif.endif.e...endif.1

entry.endif.endif.endif.e...endif.1:              ; preds = %entry.endif.endif.endif.e...if.1, %entry.endif.endif.endif.e...endif.endif.endif.endif
  %.134.0 = phi i64 [ %.139, %entry.endif.endif.endif.e...if.1 ], [ 0, %entry.endif.endif.endif.e...endif.endif.endif.endif ]
  %.144 = call ptr @PyErr_Occurred()
  %.145.not = icmp eq ptr %.144, null
  br i1 %.145.not, label %entry.endif.endif.endif.e...endif.1.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.1.endif:        ; preds = %entry.endif.endif.endif.e...endif.1
  %.149 = load ptr, ptr %.11, align 8
  %.152 = call ptr @PyNumber_Long(ptr %.149)
  %.153.not = icmp eq ptr %.152, null
  br i1 %.153.not, label %entry.endif.endif.endif.e...endif.1.endif.endif, label %entry.endif.endif.endif.e...endif.1.endif.if, !prof !1

entry.endif.endif.endif.e...endif.1.endif.if:     ; preds = %entry.endif.endif.endif.e...endif.1.endif
  %.155 = call i64 @PyLong_AsLongLong(ptr nonnull %.152)
  call void @Py_DecRef(ptr nonnull %.152)
  br label %entry.endif.endif.endif.e...endif.1.endif.endif

entry.endif.endif.endif.e...endif.1.endif.endif:  ; preds = %entry.endif.endif.endif.e...endif.1.endif.if, %entry.endif.endif.endif.e...endif.1.endif
  %.150.0 = phi i64 [ %.155, %entry.endif.endif.endif.e...endif.1.endif.if ], [ 0, %entry.endif.endif.endif.e...endif.1.endif ]
  %.160 = call ptr @PyErr_Occurred()
  %.161.not = icmp eq ptr %.160, null
  br i1 %.161.not, label %entry.endif.endif.endif.e...endif.1.endif.endif.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.1.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif
  %.165 = load ptr, ptr %.12, align 8
  %.168 = call ptr @PyNumber_Long(ptr %.165)
  %.169.not = icmp eq ptr %.168, null
  br i1 %.169.not, label %entry.endif.endif.endif.e...endif.2, label %entry.endif.endif.endif.e...if.2, !prof !1

entry.endif.endif.endif.e...if.2:                 ; preds = %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.171 = call i64 @PyLong_AsLongLong(ptr nonnull %.168)
  call void @Py_DecRef(ptr nonnull %.168)
  br label %entry.endif.endif.endif.e...endif.2

entry.endif.endif.endif.e...endif.2:              ; preds = %entry.endif.endif.endif.e...if.2, %entry.endif.endif.endif.e...endif.1.endif.endif.endif
  %.166.0 = phi i64 [ %.171, %entry.endif.endif.endif.e...if.2 ], [ 0, %entry.endif.endif.endif.e...endif.1.endif.endif.endif ]
  %.176 = call ptr @PyErr_Occurred()
  %.177.not = icmp eq ptr %.176, null
  br i1 %.177.not, label %entry.endif.endif.endif.e...endif.2.endif, label %arg3.err, !prof !2

entry.endif.endif.endif.e...endif.2.endif:        ; preds = %entry.endif.endif.endif.e...endif.2
  store i64 0, ptr %.181, align 8
  %.193 = call i32 @_ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr nonnull %.181, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %.110.fca.4.load, i64 poison, i64 poison, i64 %.118.0, i64 %.134.0, i64 %.150.0, i64 %.166.0) #3
  %.203 = load i64, ptr %.181, align 8
  call void @NRT_decref(ptr %.41.fca.0.load)
  call void @NRT_decref(ptr %.64.fca.0.load)
  call void @NRT_decref(ptr %.87.fca.0.load)
  call void @NRT_decref(ptr %.110.fca.0.load)
  %cond = icmp eq i32 %.193, 0
  br i1 %cond, label %entry.endif.endif.endif.e...endif.2.endif.if.endif, label %entry.endif.endif.endif.e...endif.2.endif.endif, !prof !3

entry.endif.endif.endif.e...endif.2.endif.endif:  ; preds = %entry.endif.endif.endif.e...endif.2.endif
  %.201 = icmp sgt i32 %.193, 0
  br i1 %.201, label %entry.endif.endif.endif.e...endif.2.endif.endif.if, label %entry.endif.endif.endif.e...endif.2.endif.endif.endif

entry.endif.endif.endif.e...endif.2.endif.if.endif: ; preds = %entry.endif.endif.endif.e...endif.2.endif
  %.222 = call ptr @PyLong_FromLongLong(i64 %.203)
  br label %common.ret

entry.endif.endif.endif.e...endif.2.endif.endif.if: ; preds = %entry.endif.endif.endif.e...endif.2.endif.endif
  call void @PyErr_Clear()
  unreachable

entry.endif.endif.endif.e...endif.2.endif.endif.endif: ; preds = %entry.endif.endif.endif.e...endif.2.endif.endif
  switch i32 %.193, label %entry.endif.endif.endif.e...endif.5.endif [
    i32 -3, label %entry.endif.endif.endif.e...if.5
    i32 -1, label %common.ret
  ]

entry.endif.endif.endif.e...if.5:                 ; preds = %entry.endif.endif.endif.e...endif.2.endif.endif.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %common.ret

entry.endif.endif.endif.e...endif.5.endif:        ; preds = %entry.endif.endif.endif.e...endif.2.endif.endif.endif
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

define i64 @cfunc._ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %extracted.data.3 = extractvalue { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, 4
  %.22 = call i32 @_ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr nonnull %.10, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %extracted.data.3, i64 poison, i64 poison, i64 %.5, i64 %.6, i64 %.7, i64 %.8) #3
  %.32 = load i64, ptr %.10, align 8
  %.34 = alloca i32, align 4
  store i32 0, ptr %.34, align 4
  %cond = icmp eq i32 %.22, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !3

entry.if:                                         ; preds = %entry
  %.30 = icmp sgt i32 %.22, 0
  call void @numba_gil_ensure(ptr nonnull %.34)
  br i1 %.30, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.37
  ret i64 %.32

.37:                                              ; preds = %entry.if.endif, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.85 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.85)
  call void @Py_DecRef(ptr %.85)
  call void @numba_gil_release(ptr nonnull %.34)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  unreachable

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.22, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.37
  ]

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.37

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function.2")
  br label %.37
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #1

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

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { noinline }
attributes #4 = { nounwind }

!0 = !{}
!1 = !{!"branch_weights", i32 1, i32 99}
!2 = !{!"branch_weights", i32 99, i32 1}
!3 = !{!"branch_weights", i32 49, i32 1}
