; ModuleID = 'f0_recurrence_64'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.f0_recurrence_64 = internal constant [17 x i8] c"f0_recurrence_64\00"
@_ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx = common local_unnamed_addr global ptr null
@".const.missing Environment: _ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx" = internal constant [267 x i8] c"missing Environment: _ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx\00"
@".const.can't unbox array from PyObject into native value.  The object maybe of a different type" = internal constant [89 x i8] c"can't unbox array from PyObject into native value.  The object maybe of a different type\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function.2" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e5mul_iB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e5add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_TypeError = external global i8
@PyExc_RuntimeError = external global i8

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define noundef range(i32 -1, -2) i32 @_ZN32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z) local_unnamed_addr #0 {
B0:
  %.25.i = sitofp i64 %arg.v_x to double
  %.27.i = sitofp i64 %arg.v_y to double
  %.28.i = fmul double %.25.i, %.27.i
  %0 = tail call double @llvm.fabs.f64(double %.28.i)
  %or.cond.i = fcmp ult double %0, 9.200000e+18
  br i1 %or.cond.i, label %B0.endif, label %common.ret.sink.split

common.ret.sink.split:                            ; preds = %B0, %B7744, %B7682, %B7622, %B7560, %B7500, %B7438, %B7378, %B7316, %B7256, %B7194, %B7134, %B7072, %B7012, %B6950, %B6890, %B6828, %B6768, %B6706, %B6646, %B6584, %B6524, %B6462, %B6402, %B6340, %B6280, %B6218, %B6158, %B6096, %B6036, %B5974, %B5914, %B5852, %B5792, %B5730, %B5670, %B5608, %B5548, %B5486, %B5426, %B5364, %B5304, %B5242, %B5182, %B5120, %B5060, %B4998, %B4938, %B4876, %B4816, %B4754, %B4694, %B4632, %B4572, %B4510, %B4450, %B4388, %B4328, %B4266, %B4206, %B4144, %B4084, %B4022, %B3962, %B3900, %B3840, %B3778, %B3718, %B3656, %B3596, %B3534, %B3474, %B3412, %B3352, %B3290, %B3230, %B3168, %B3108, %B3046, %B2986, %B2924, %B2864, %B2802, %B2742, %B2680, %B2620, %B2558, %B2498, %B2436, %B2376, %B2314, %B2254, %B2192, %B2132, %B2070, %B2010, %B1948, %B1888, %B1826, %B1766, %B1704, %B1644, %B1582, %B1522, %B1460, %B1400, %B1338, %B1278, %B1216, %B1156, %B1094, %B1034, %B972, %B912, %B850, %B790, %B728, %B668, %B606, %B546, %B484, %B426, %B364, %B306, %B244, %B186, %B124, %B66
  store i8 1, ptr %arg.st.4, align 1, !noalias !0
  br label %common.ret

common.ret:                                       ; preds = %common.ret.sink.split, %B7744, %B6158.endif, %B0.endif
  %.20.i1005.sink = phi i64 [ 0, %B6158.endif ], [ 0, %B0.endif ], [ %.20.i1005, %B7744 ], [ 0, %common.ret.sink.split ]
  store i64 %.20.i1005.sink, ptr %retptr, align 8
  ret i32 0

B66:                                              ; preds = %B0.endif
  %.96.i = mul nsw i64 %arg.v_y, %arg.v_x
  %.20.i = add nsw i64 %arg.v_z, %.96.i
  %.25.i1 = xor i64 %.20.i, %.96.i
  %.27.i2 = xor i64 %.20.i, %arg.v_z
  %.28.i3 = and i64 %.25.i1, %.27.i2
  %.29.i = icmp slt i64 %.28.i3, 0
  br i1 %.29.i, label %common.ret.sink.split, label %B124

B124:                                             ; preds = %B66
  %.25.i4 = sitofp i64 %.20.i to double
  %.28.i6 = fmul double %.27.i, %.25.i4
  %1 = tail call double @llvm.fabs.f64(double %.28.i6)
  %or.cond.i7 = fcmp ult double %1, 9.200000e+18
  br i1 %or.cond.i7, label %B186, label %common.ret.sink.split

B186:                                             ; preds = %B124
  %.96.i11 = mul nsw i64 %.20.i, %arg.v_y
  %.20.i13 = add nsw i64 %.96.i11, %arg.v_z
  %.25.i14 = xor i64 %.20.i13, %.96.i11
  %.27.i15 = xor i64 %.20.i13, %arg.v_z
  %.28.i16 = and i64 %.25.i14, %.27.i15
  %.29.i17 = icmp slt i64 %.28.i16, 0
  br i1 %.29.i17, label %common.ret.sink.split, label %B244

B244:                                             ; preds = %B186
  %.25.i20 = sitofp i64 %.20.i13 to double
  %.28.i22 = fmul double %.27.i, %.25.i20
  %2 = tail call double @llvm.fabs.f64(double %.28.i22)
  %or.cond.i23 = fcmp ult double %2, 9.200000e+18
  br i1 %or.cond.i23, label %B306, label %common.ret.sink.split

B306:                                             ; preds = %B244
  %.96.i27 = mul nsw i64 %.20.i13, %arg.v_y
  %.20.i29 = add nsw i64 %.96.i27, %arg.v_z
  %.25.i30 = xor i64 %.20.i29, %.96.i27
  %.27.i31 = xor i64 %.20.i29, %arg.v_z
  %.28.i32 = and i64 %.25.i30, %.27.i31
  %.29.i33 = icmp slt i64 %.28.i32, 0
  br i1 %.29.i33, label %common.ret.sink.split, label %B364

B364:                                             ; preds = %B306
  %.25.i36 = sitofp i64 %.20.i29 to double
  %.28.i38 = fmul double %.27.i, %.25.i36
  %3 = tail call double @llvm.fabs.f64(double %.28.i38)
  %or.cond.i39 = fcmp ult double %3, 9.200000e+18
  br i1 %or.cond.i39, label %B426, label %common.ret.sink.split

B426:                                             ; preds = %B364
  %.96.i43 = mul nsw i64 %.20.i29, %arg.v_y
  %.20.i45 = add nsw i64 %.96.i43, %arg.v_z
  %.25.i46 = xor i64 %.20.i45, %.96.i43
  %.27.i47 = xor i64 %.20.i45, %arg.v_z
  %.28.i48 = and i64 %.25.i46, %.27.i47
  %.29.i49 = icmp slt i64 %.28.i48, 0
  br i1 %.29.i49, label %common.ret.sink.split, label %B484

B484:                                             ; preds = %B426
  %.25.i52 = sitofp i64 %.20.i45 to double
  %.28.i54 = fmul double %.27.i, %.25.i52
  %4 = tail call double @llvm.fabs.f64(double %.28.i54)
  %or.cond.i55 = fcmp ult double %4, 9.200000e+18
  br i1 %or.cond.i55, label %B546, label %common.ret.sink.split

B546:                                             ; preds = %B484
  %.96.i59 = mul nsw i64 %.20.i45, %arg.v_y
  %.20.i61 = add nsw i64 %.96.i59, %arg.v_z
  %.25.i62 = xor i64 %.20.i61, %.96.i59
  %.27.i63 = xor i64 %.20.i61, %arg.v_z
  %.28.i64 = and i64 %.25.i62, %.27.i63
  %.29.i65 = icmp slt i64 %.28.i64, 0
  br i1 %.29.i65, label %common.ret.sink.split, label %B606

B606:                                             ; preds = %B546
  %.25.i68 = sitofp i64 %.20.i61 to double
  %.28.i70 = fmul double %.27.i, %.25.i68
  %5 = tail call double @llvm.fabs.f64(double %.28.i70)
  %or.cond.i71 = fcmp ult double %5, 9.200000e+18
  br i1 %or.cond.i71, label %B668, label %common.ret.sink.split

B668:                                             ; preds = %B606
  %.96.i75 = mul nsw i64 %.20.i61, %arg.v_y
  %.20.i77 = add nsw i64 %.96.i75, %arg.v_z
  %.25.i78 = xor i64 %.20.i77, %.96.i75
  %.27.i79 = xor i64 %.20.i77, %arg.v_z
  %.28.i80 = and i64 %.25.i78, %.27.i79
  %.29.i81 = icmp slt i64 %.28.i80, 0
  br i1 %.29.i81, label %common.ret.sink.split, label %B728

B728:                                             ; preds = %B668
  %.25.i84 = sitofp i64 %.20.i77 to double
  %.28.i86 = fmul double %.27.i, %.25.i84
  %6 = tail call double @llvm.fabs.f64(double %.28.i86)
  %or.cond.i87 = fcmp ult double %6, 9.200000e+18
  br i1 %or.cond.i87, label %B790, label %common.ret.sink.split

B790:                                             ; preds = %B728
  %.96.i91 = mul nsw i64 %.20.i77, %arg.v_y
  %.20.i93 = add nsw i64 %.96.i91, %arg.v_z
  %.25.i94 = xor i64 %.20.i93, %.96.i91
  %.27.i95 = xor i64 %.20.i93, %arg.v_z
  %.28.i96 = and i64 %.25.i94, %.27.i95
  %.29.i97 = icmp slt i64 %.28.i96, 0
  br i1 %.29.i97, label %common.ret.sink.split, label %B850

B850:                                             ; preds = %B790
  %.25.i100 = sitofp i64 %.20.i93 to double
  %.28.i102 = fmul double %.27.i, %.25.i100
  %7 = tail call double @llvm.fabs.f64(double %.28.i102)
  %or.cond.i103 = fcmp ult double %7, 9.200000e+18
  br i1 %or.cond.i103, label %B912, label %common.ret.sink.split

B912:                                             ; preds = %B850
  %.96.i107 = mul nsw i64 %.20.i93, %arg.v_y
  %.20.i109 = add nsw i64 %.96.i107, %arg.v_z
  %.25.i110 = xor i64 %.20.i109, %.96.i107
  %.27.i111 = xor i64 %.20.i109, %arg.v_z
  %.28.i112 = and i64 %.25.i110, %.27.i111
  %.29.i113 = icmp slt i64 %.28.i112, 0
  br i1 %.29.i113, label %common.ret.sink.split, label %B972

B972:                                             ; preds = %B912
  %.25.i116 = sitofp i64 %.20.i109 to double
  %.28.i118 = fmul double %.27.i, %.25.i116
  %8 = tail call double @llvm.fabs.f64(double %.28.i118)
  %or.cond.i119 = fcmp ult double %8, 9.200000e+18
  br i1 %or.cond.i119, label %B1034, label %common.ret.sink.split

B1034:                                            ; preds = %B972
  %.96.i123 = mul nsw i64 %.20.i109, %arg.v_y
  %.20.i125 = add nsw i64 %.96.i123, %arg.v_z
  %.25.i126 = xor i64 %.20.i125, %.96.i123
  %.27.i127 = xor i64 %.20.i125, %arg.v_z
  %.28.i128 = and i64 %.25.i126, %.27.i127
  %.29.i129 = icmp slt i64 %.28.i128, 0
  br i1 %.29.i129, label %common.ret.sink.split, label %B1094

B1094:                                            ; preds = %B1034
  %.25.i132 = sitofp i64 %.20.i125 to double
  %.28.i134 = fmul double %.27.i, %.25.i132
  %9 = tail call double @llvm.fabs.f64(double %.28.i134)
  %or.cond.i135 = fcmp ult double %9, 9.200000e+18
  br i1 %or.cond.i135, label %B1156, label %common.ret.sink.split

B1156:                                            ; preds = %B1094
  %.96.i139 = mul nsw i64 %.20.i125, %arg.v_y
  %.20.i141 = add nsw i64 %.96.i139, %arg.v_z
  %.25.i142 = xor i64 %.20.i141, %.96.i139
  %.27.i143 = xor i64 %.20.i141, %arg.v_z
  %.28.i144 = and i64 %.25.i142, %.27.i143
  %.29.i145 = icmp slt i64 %.28.i144, 0
  br i1 %.29.i145, label %common.ret.sink.split, label %B1216

B1216:                                            ; preds = %B1156
  %.25.i148 = sitofp i64 %.20.i141 to double
  %.28.i150 = fmul double %.27.i, %.25.i148
  %10 = tail call double @llvm.fabs.f64(double %.28.i150)
  %or.cond.i151 = fcmp ult double %10, 9.200000e+18
  br i1 %or.cond.i151, label %B1278, label %common.ret.sink.split

B1278:                                            ; preds = %B1216
  %.96.i155 = mul nsw i64 %.20.i141, %arg.v_y
  %.20.i157 = add nsw i64 %.96.i155, %arg.v_z
  %.25.i158 = xor i64 %.20.i157, %.96.i155
  %.27.i159 = xor i64 %.20.i157, %arg.v_z
  %.28.i160 = and i64 %.25.i158, %.27.i159
  %.29.i161 = icmp slt i64 %.28.i160, 0
  br i1 %.29.i161, label %common.ret.sink.split, label %B1338

B1338:                                            ; preds = %B1278
  %.25.i164 = sitofp i64 %.20.i157 to double
  %.28.i166 = fmul double %.27.i, %.25.i164
  %11 = tail call double @llvm.fabs.f64(double %.28.i166)
  %or.cond.i167 = fcmp ult double %11, 9.200000e+18
  br i1 %or.cond.i167, label %B1400, label %common.ret.sink.split

B1400:                                            ; preds = %B1338
  %.96.i171 = mul nsw i64 %.20.i157, %arg.v_y
  %.20.i173 = add nsw i64 %.96.i171, %arg.v_z
  %.25.i174 = xor i64 %.20.i173, %.96.i171
  %.27.i175 = xor i64 %.20.i173, %arg.v_z
  %.28.i176 = and i64 %.25.i174, %.27.i175
  %.29.i177 = icmp slt i64 %.28.i176, 0
  br i1 %.29.i177, label %common.ret.sink.split, label %B1460

B1460:                                            ; preds = %B1400
  %.25.i180 = sitofp i64 %.20.i173 to double
  %.28.i182 = fmul double %.27.i, %.25.i180
  %12 = tail call double @llvm.fabs.f64(double %.28.i182)
  %or.cond.i183 = fcmp ult double %12, 9.200000e+18
  br i1 %or.cond.i183, label %B1522, label %common.ret.sink.split

B1522:                                            ; preds = %B1460
  %.96.i187 = mul nsw i64 %.20.i173, %arg.v_y
  %.20.i189 = add nsw i64 %.96.i187, %arg.v_z
  %.25.i190 = xor i64 %.20.i189, %.96.i187
  %.27.i191 = xor i64 %.20.i189, %arg.v_z
  %.28.i192 = and i64 %.25.i190, %.27.i191
  %.29.i193 = icmp slt i64 %.28.i192, 0
  br i1 %.29.i193, label %common.ret.sink.split, label %B1582

B1582:                                            ; preds = %B1522
  %.25.i196 = sitofp i64 %.20.i189 to double
  %.28.i198 = fmul double %.27.i, %.25.i196
  %13 = tail call double @llvm.fabs.f64(double %.28.i198)
  %or.cond.i199 = fcmp ult double %13, 9.200000e+18
  br i1 %or.cond.i199, label %B1644, label %common.ret.sink.split

B1644:                                            ; preds = %B1582
  %.96.i203 = mul nsw i64 %.20.i189, %arg.v_y
  %.20.i205 = add nsw i64 %.96.i203, %arg.v_z
  %.25.i206 = xor i64 %.20.i205, %.96.i203
  %.27.i207 = xor i64 %.20.i205, %arg.v_z
  %.28.i208 = and i64 %.25.i206, %.27.i207
  %.29.i209 = icmp slt i64 %.28.i208, 0
  br i1 %.29.i209, label %common.ret.sink.split, label %B1704

B1704:                                            ; preds = %B1644
  %.25.i212 = sitofp i64 %.20.i205 to double
  %.28.i214 = fmul double %.27.i, %.25.i212
  %14 = tail call double @llvm.fabs.f64(double %.28.i214)
  %or.cond.i215 = fcmp ult double %14, 9.200000e+18
  br i1 %or.cond.i215, label %B1766, label %common.ret.sink.split

B1766:                                            ; preds = %B1704
  %.96.i219 = mul nsw i64 %.20.i205, %arg.v_y
  %.20.i221 = add nsw i64 %.96.i219, %arg.v_z
  %.25.i222 = xor i64 %.20.i221, %.96.i219
  %.27.i223 = xor i64 %.20.i221, %arg.v_z
  %.28.i224 = and i64 %.25.i222, %.27.i223
  %.29.i225 = icmp slt i64 %.28.i224, 0
  br i1 %.29.i225, label %common.ret.sink.split, label %B1826

B1826:                                            ; preds = %B1766
  %.25.i228 = sitofp i64 %.20.i221 to double
  %.28.i230 = fmul double %.27.i, %.25.i228
  %15 = tail call double @llvm.fabs.f64(double %.28.i230)
  %or.cond.i231 = fcmp ult double %15, 9.200000e+18
  br i1 %or.cond.i231, label %B1888, label %common.ret.sink.split

B1888:                                            ; preds = %B1826
  %.96.i235 = mul nsw i64 %.20.i221, %arg.v_y
  %.20.i237 = add nsw i64 %.96.i235, %arg.v_z
  %.25.i238 = xor i64 %.20.i237, %.96.i235
  %.27.i239 = xor i64 %.20.i237, %arg.v_z
  %.28.i240 = and i64 %.25.i238, %.27.i239
  %.29.i241 = icmp slt i64 %.28.i240, 0
  br i1 %.29.i241, label %common.ret.sink.split, label %B1948

B1948:                                            ; preds = %B1888
  %.25.i244 = sitofp i64 %.20.i237 to double
  %.28.i246 = fmul double %.27.i, %.25.i244
  %16 = tail call double @llvm.fabs.f64(double %.28.i246)
  %or.cond.i247 = fcmp ult double %16, 9.200000e+18
  br i1 %or.cond.i247, label %B2010, label %common.ret.sink.split

B2010:                                            ; preds = %B1948
  %.96.i251 = mul nsw i64 %.20.i237, %arg.v_y
  %.20.i253 = add nsw i64 %.96.i251, %arg.v_z
  %.25.i254 = xor i64 %.20.i253, %.96.i251
  %.27.i255 = xor i64 %.20.i253, %arg.v_z
  %.28.i256 = and i64 %.25.i254, %.27.i255
  %.29.i257 = icmp slt i64 %.28.i256, 0
  br i1 %.29.i257, label %common.ret.sink.split, label %B2070

B2070:                                            ; preds = %B2010
  %.25.i260 = sitofp i64 %.20.i253 to double
  %.28.i262 = fmul double %.27.i, %.25.i260
  %17 = tail call double @llvm.fabs.f64(double %.28.i262)
  %or.cond.i263 = fcmp ult double %17, 9.200000e+18
  br i1 %or.cond.i263, label %B2132, label %common.ret.sink.split

B2132:                                            ; preds = %B2070
  %.96.i267 = mul nsw i64 %.20.i253, %arg.v_y
  %.20.i269 = add nsw i64 %.96.i267, %arg.v_z
  %.25.i270 = xor i64 %.20.i269, %.96.i267
  %.27.i271 = xor i64 %.20.i269, %arg.v_z
  %.28.i272 = and i64 %.25.i270, %.27.i271
  %.29.i273 = icmp slt i64 %.28.i272, 0
  br i1 %.29.i273, label %common.ret.sink.split, label %B2192

B2192:                                            ; preds = %B2132
  %.25.i276 = sitofp i64 %.20.i269 to double
  %.28.i278 = fmul double %.27.i, %.25.i276
  %18 = tail call double @llvm.fabs.f64(double %.28.i278)
  %or.cond.i279 = fcmp ult double %18, 9.200000e+18
  br i1 %or.cond.i279, label %B2254, label %common.ret.sink.split

B2254:                                            ; preds = %B2192
  %.96.i283 = mul nsw i64 %.20.i269, %arg.v_y
  %.20.i285 = add nsw i64 %.96.i283, %arg.v_z
  %.25.i286 = xor i64 %.20.i285, %.96.i283
  %.27.i287 = xor i64 %.20.i285, %arg.v_z
  %.28.i288 = and i64 %.25.i286, %.27.i287
  %.29.i289 = icmp slt i64 %.28.i288, 0
  br i1 %.29.i289, label %common.ret.sink.split, label %B2314

B2314:                                            ; preds = %B2254
  %.25.i292 = sitofp i64 %.20.i285 to double
  %.28.i294 = fmul double %.27.i, %.25.i292
  %19 = tail call double @llvm.fabs.f64(double %.28.i294)
  %or.cond.i295 = fcmp ult double %19, 9.200000e+18
  br i1 %or.cond.i295, label %B2376, label %common.ret.sink.split

B2376:                                            ; preds = %B2314
  %.96.i299 = mul nsw i64 %.20.i285, %arg.v_y
  %.20.i301 = add nsw i64 %.96.i299, %arg.v_z
  %.25.i302 = xor i64 %.20.i301, %.96.i299
  %.27.i303 = xor i64 %.20.i301, %arg.v_z
  %.28.i304 = and i64 %.25.i302, %.27.i303
  %.29.i305 = icmp slt i64 %.28.i304, 0
  br i1 %.29.i305, label %common.ret.sink.split, label %B2436

B2436:                                            ; preds = %B2376
  %.25.i308 = sitofp i64 %.20.i301 to double
  %.28.i310 = fmul double %.27.i, %.25.i308
  %20 = tail call double @llvm.fabs.f64(double %.28.i310)
  %or.cond.i311 = fcmp ult double %20, 9.200000e+18
  br i1 %or.cond.i311, label %B2498, label %common.ret.sink.split

B2498:                                            ; preds = %B2436
  %.96.i315 = mul nsw i64 %.20.i301, %arg.v_y
  %.20.i317 = add nsw i64 %.96.i315, %arg.v_z
  %.25.i318 = xor i64 %.20.i317, %.96.i315
  %.27.i319 = xor i64 %.20.i317, %arg.v_z
  %.28.i320 = and i64 %.25.i318, %.27.i319
  %.29.i321 = icmp slt i64 %.28.i320, 0
  br i1 %.29.i321, label %common.ret.sink.split, label %B2558

B2558:                                            ; preds = %B2498
  %.25.i324 = sitofp i64 %.20.i317 to double
  %.28.i326 = fmul double %.27.i, %.25.i324
  %21 = tail call double @llvm.fabs.f64(double %.28.i326)
  %or.cond.i327 = fcmp ult double %21, 9.200000e+18
  br i1 %or.cond.i327, label %B2620, label %common.ret.sink.split

B2620:                                            ; preds = %B2558
  %.96.i331 = mul nsw i64 %.20.i317, %arg.v_y
  %.20.i333 = add nsw i64 %.96.i331, %arg.v_z
  %.25.i334 = xor i64 %.20.i333, %.96.i331
  %.27.i335 = xor i64 %.20.i333, %arg.v_z
  %.28.i336 = and i64 %.25.i334, %.27.i335
  %.29.i337 = icmp slt i64 %.28.i336, 0
  br i1 %.29.i337, label %common.ret.sink.split, label %B2680

B2680:                                            ; preds = %B2620
  %.25.i340 = sitofp i64 %.20.i333 to double
  %.28.i342 = fmul double %.27.i, %.25.i340
  %22 = tail call double @llvm.fabs.f64(double %.28.i342)
  %or.cond.i343 = fcmp ult double %22, 9.200000e+18
  br i1 %or.cond.i343, label %B2742, label %common.ret.sink.split

B2742:                                            ; preds = %B2680
  %.96.i347 = mul nsw i64 %.20.i333, %arg.v_y
  %.20.i349 = add nsw i64 %.96.i347, %arg.v_z
  %.25.i350 = xor i64 %.20.i349, %.96.i347
  %.27.i351 = xor i64 %.20.i349, %arg.v_z
  %.28.i352 = and i64 %.25.i350, %.27.i351
  %.29.i353 = icmp slt i64 %.28.i352, 0
  br i1 %.29.i353, label %common.ret.sink.split, label %B2802

B2802:                                            ; preds = %B2742
  %.25.i356 = sitofp i64 %.20.i349 to double
  %.28.i358 = fmul double %.27.i, %.25.i356
  %23 = tail call double @llvm.fabs.f64(double %.28.i358)
  %or.cond.i359 = fcmp ult double %23, 9.200000e+18
  br i1 %or.cond.i359, label %B2864, label %common.ret.sink.split

B2864:                                            ; preds = %B2802
  %.96.i363 = mul nsw i64 %.20.i349, %arg.v_y
  %.20.i365 = add nsw i64 %.96.i363, %arg.v_z
  %.25.i366 = xor i64 %.20.i365, %.96.i363
  %.27.i367 = xor i64 %.20.i365, %arg.v_z
  %.28.i368 = and i64 %.25.i366, %.27.i367
  %.29.i369 = icmp slt i64 %.28.i368, 0
  br i1 %.29.i369, label %common.ret.sink.split, label %B2924

B2924:                                            ; preds = %B2864
  %.25.i372 = sitofp i64 %.20.i365 to double
  %.28.i374 = fmul double %.27.i, %.25.i372
  %24 = tail call double @llvm.fabs.f64(double %.28.i374)
  %or.cond.i375 = fcmp ult double %24, 9.200000e+18
  br i1 %or.cond.i375, label %B2986, label %common.ret.sink.split

B2986:                                            ; preds = %B2924
  %.96.i379 = mul nsw i64 %.20.i365, %arg.v_y
  %.20.i381 = add nsw i64 %.96.i379, %arg.v_z
  %.25.i382 = xor i64 %.20.i381, %.96.i379
  %.27.i383 = xor i64 %.20.i381, %arg.v_z
  %.28.i384 = and i64 %.25.i382, %.27.i383
  %.29.i385 = icmp slt i64 %.28.i384, 0
  br i1 %.29.i385, label %common.ret.sink.split, label %B3046

B3046:                                            ; preds = %B2986
  %.25.i388 = sitofp i64 %.20.i381 to double
  %.28.i390 = fmul double %.27.i, %.25.i388
  %25 = tail call double @llvm.fabs.f64(double %.28.i390)
  %or.cond.i391 = fcmp ult double %25, 9.200000e+18
  br i1 %or.cond.i391, label %B3108, label %common.ret.sink.split

B3108:                                            ; preds = %B3046
  %.96.i395 = mul nsw i64 %.20.i381, %arg.v_y
  %.20.i397 = add nsw i64 %.96.i395, %arg.v_z
  %.25.i398 = xor i64 %.20.i397, %.96.i395
  %.27.i399 = xor i64 %.20.i397, %arg.v_z
  %.28.i400 = and i64 %.25.i398, %.27.i399
  %.29.i401 = icmp slt i64 %.28.i400, 0
  br i1 %.29.i401, label %common.ret.sink.split, label %B3168

B3168:                                            ; preds = %B3108
  %.25.i404 = sitofp i64 %.20.i397 to double
  %.28.i406 = fmul double %.27.i, %.25.i404
  %26 = tail call double @llvm.fabs.f64(double %.28.i406)
  %or.cond.i407 = fcmp ult double %26, 9.200000e+18
  br i1 %or.cond.i407, label %B3230, label %common.ret.sink.split

B3230:                                            ; preds = %B3168
  %.96.i411 = mul nsw i64 %.20.i397, %arg.v_y
  %.20.i413 = add nsw i64 %.96.i411, %arg.v_z
  %.25.i414 = xor i64 %.20.i413, %.96.i411
  %.27.i415 = xor i64 %.20.i413, %arg.v_z
  %.28.i416 = and i64 %.25.i414, %.27.i415
  %.29.i417 = icmp slt i64 %.28.i416, 0
  br i1 %.29.i417, label %common.ret.sink.split, label %B3290

B3290:                                            ; preds = %B3230
  %.25.i420 = sitofp i64 %.20.i413 to double
  %.28.i422 = fmul double %.27.i, %.25.i420
  %27 = tail call double @llvm.fabs.f64(double %.28.i422)
  %or.cond.i423 = fcmp ult double %27, 9.200000e+18
  br i1 %or.cond.i423, label %B3352, label %common.ret.sink.split

B3352:                                            ; preds = %B3290
  %.96.i427 = mul nsw i64 %.20.i413, %arg.v_y
  %.20.i429 = add nsw i64 %.96.i427, %arg.v_z
  %.25.i430 = xor i64 %.20.i429, %.96.i427
  %.27.i431 = xor i64 %.20.i429, %arg.v_z
  %.28.i432 = and i64 %.25.i430, %.27.i431
  %.29.i433 = icmp slt i64 %.28.i432, 0
  br i1 %.29.i433, label %common.ret.sink.split, label %B3412

B3412:                                            ; preds = %B3352
  %.25.i436 = sitofp i64 %.20.i429 to double
  %.28.i438 = fmul double %.27.i, %.25.i436
  %28 = tail call double @llvm.fabs.f64(double %.28.i438)
  %or.cond.i439 = fcmp ult double %28, 9.200000e+18
  br i1 %or.cond.i439, label %B3474, label %common.ret.sink.split

B3474:                                            ; preds = %B3412
  %.96.i443 = mul nsw i64 %.20.i429, %arg.v_y
  %.20.i445 = add nsw i64 %.96.i443, %arg.v_z
  %.25.i446 = xor i64 %.20.i445, %.96.i443
  %.27.i447 = xor i64 %.20.i445, %arg.v_z
  %.28.i448 = and i64 %.25.i446, %.27.i447
  %.29.i449 = icmp slt i64 %.28.i448, 0
  br i1 %.29.i449, label %common.ret.sink.split, label %B3534

B3534:                                            ; preds = %B3474
  %.25.i452 = sitofp i64 %.20.i445 to double
  %.28.i454 = fmul double %.27.i, %.25.i452
  %29 = tail call double @llvm.fabs.f64(double %.28.i454)
  %or.cond.i455 = fcmp ult double %29, 9.200000e+18
  br i1 %or.cond.i455, label %B3596, label %common.ret.sink.split

B3596:                                            ; preds = %B3534
  %.96.i459 = mul nsw i64 %.20.i445, %arg.v_y
  %.20.i461 = add nsw i64 %.96.i459, %arg.v_z
  %.25.i462 = xor i64 %.20.i461, %.96.i459
  %.27.i463 = xor i64 %.20.i461, %arg.v_z
  %.28.i464 = and i64 %.25.i462, %.27.i463
  %.29.i465 = icmp slt i64 %.28.i464, 0
  br i1 %.29.i465, label %common.ret.sink.split, label %B3656

B3656:                                            ; preds = %B3596
  %.25.i468 = sitofp i64 %.20.i461 to double
  %.28.i470 = fmul double %.27.i, %.25.i468
  %30 = tail call double @llvm.fabs.f64(double %.28.i470)
  %or.cond.i471 = fcmp ult double %30, 9.200000e+18
  br i1 %or.cond.i471, label %B3718, label %common.ret.sink.split

B3718:                                            ; preds = %B3656
  %.96.i475 = mul nsw i64 %.20.i461, %arg.v_y
  %.20.i477 = add nsw i64 %.96.i475, %arg.v_z
  %.25.i478 = xor i64 %.20.i477, %.96.i475
  %.27.i479 = xor i64 %.20.i477, %arg.v_z
  %.28.i480 = and i64 %.25.i478, %.27.i479
  %.29.i481 = icmp slt i64 %.28.i480, 0
  br i1 %.29.i481, label %common.ret.sink.split, label %B3778

B3778:                                            ; preds = %B3718
  %.25.i484 = sitofp i64 %.20.i477 to double
  %.28.i486 = fmul double %.27.i, %.25.i484
  %31 = tail call double @llvm.fabs.f64(double %.28.i486)
  %or.cond.i487 = fcmp ult double %31, 9.200000e+18
  br i1 %or.cond.i487, label %B3840, label %common.ret.sink.split

B3840:                                            ; preds = %B3778
  %.96.i491 = mul nsw i64 %.20.i477, %arg.v_y
  %.20.i493 = add nsw i64 %.96.i491, %arg.v_z
  %.25.i494 = xor i64 %.20.i493, %.96.i491
  %.27.i495 = xor i64 %.20.i493, %arg.v_z
  %.28.i496 = and i64 %.25.i494, %.27.i495
  %.29.i497 = icmp slt i64 %.28.i496, 0
  br i1 %.29.i497, label %common.ret.sink.split, label %B3900

B3900:                                            ; preds = %B3840
  %.25.i500 = sitofp i64 %.20.i493 to double
  %.28.i502 = fmul double %.27.i, %.25.i500
  %32 = tail call double @llvm.fabs.f64(double %.28.i502)
  %or.cond.i503 = fcmp ult double %32, 9.200000e+18
  br i1 %or.cond.i503, label %B3962, label %common.ret.sink.split

B3962:                                            ; preds = %B3900
  %.96.i507 = mul nsw i64 %.20.i493, %arg.v_y
  %.20.i509 = add nsw i64 %.96.i507, %arg.v_z
  %.25.i510 = xor i64 %.20.i509, %.96.i507
  %.27.i511 = xor i64 %.20.i509, %arg.v_z
  %.28.i512 = and i64 %.25.i510, %.27.i511
  %.29.i513 = icmp slt i64 %.28.i512, 0
  br i1 %.29.i513, label %common.ret.sink.split, label %B4022

B4022:                                            ; preds = %B3962
  %.25.i516 = sitofp i64 %.20.i509 to double
  %.28.i518 = fmul double %.27.i, %.25.i516
  %33 = tail call double @llvm.fabs.f64(double %.28.i518)
  %or.cond.i519 = fcmp ult double %33, 9.200000e+18
  br i1 %or.cond.i519, label %B4084, label %common.ret.sink.split

B4084:                                            ; preds = %B4022
  %.96.i523 = mul nsw i64 %.20.i509, %arg.v_y
  %.20.i525 = add nsw i64 %.96.i523, %arg.v_z
  %.25.i526 = xor i64 %.20.i525, %.96.i523
  %.27.i527 = xor i64 %.20.i525, %arg.v_z
  %.28.i528 = and i64 %.25.i526, %.27.i527
  %.29.i529 = icmp slt i64 %.28.i528, 0
  br i1 %.29.i529, label %common.ret.sink.split, label %B4144

B4144:                                            ; preds = %B4084
  %.25.i532 = sitofp i64 %.20.i525 to double
  %.28.i534 = fmul double %.27.i, %.25.i532
  %34 = tail call double @llvm.fabs.f64(double %.28.i534)
  %or.cond.i535 = fcmp ult double %34, 9.200000e+18
  br i1 %or.cond.i535, label %B4206, label %common.ret.sink.split

B4206:                                            ; preds = %B4144
  %.96.i539 = mul nsw i64 %.20.i525, %arg.v_y
  %.20.i541 = add nsw i64 %.96.i539, %arg.v_z
  %.25.i542 = xor i64 %.20.i541, %.96.i539
  %.27.i543 = xor i64 %.20.i541, %arg.v_z
  %.28.i544 = and i64 %.25.i542, %.27.i543
  %.29.i545 = icmp slt i64 %.28.i544, 0
  br i1 %.29.i545, label %common.ret.sink.split, label %B4266

B4266:                                            ; preds = %B4206
  %.25.i548 = sitofp i64 %.20.i541 to double
  %.28.i550 = fmul double %.27.i, %.25.i548
  %35 = tail call double @llvm.fabs.f64(double %.28.i550)
  %or.cond.i551 = fcmp ult double %35, 9.200000e+18
  br i1 %or.cond.i551, label %B4328, label %common.ret.sink.split

B4328:                                            ; preds = %B4266
  %.96.i555 = mul nsw i64 %.20.i541, %arg.v_y
  %.20.i557 = add nsw i64 %.96.i555, %arg.v_z
  %.25.i558 = xor i64 %.20.i557, %.96.i555
  %.27.i559 = xor i64 %.20.i557, %arg.v_z
  %.28.i560 = and i64 %.25.i558, %.27.i559
  %.29.i561 = icmp slt i64 %.28.i560, 0
  br i1 %.29.i561, label %common.ret.sink.split, label %B4388

B4388:                                            ; preds = %B4328
  %.25.i564 = sitofp i64 %.20.i557 to double
  %.28.i566 = fmul double %.27.i, %.25.i564
  %36 = tail call double @llvm.fabs.f64(double %.28.i566)
  %or.cond.i567 = fcmp ult double %36, 9.200000e+18
  br i1 %or.cond.i567, label %B4450, label %common.ret.sink.split

B4450:                                            ; preds = %B4388
  %.96.i571 = mul nsw i64 %.20.i557, %arg.v_y
  %.20.i573 = add nsw i64 %.96.i571, %arg.v_z
  %.25.i574 = xor i64 %.20.i573, %.96.i571
  %.27.i575 = xor i64 %.20.i573, %arg.v_z
  %.28.i576 = and i64 %.25.i574, %.27.i575
  %.29.i577 = icmp slt i64 %.28.i576, 0
  br i1 %.29.i577, label %common.ret.sink.split, label %B4510

B4510:                                            ; preds = %B4450
  %.25.i580 = sitofp i64 %.20.i573 to double
  %.28.i582 = fmul double %.27.i, %.25.i580
  %37 = tail call double @llvm.fabs.f64(double %.28.i582)
  %or.cond.i583 = fcmp ult double %37, 9.200000e+18
  br i1 %or.cond.i583, label %B4572, label %common.ret.sink.split

B4572:                                            ; preds = %B4510
  %.96.i587 = mul nsw i64 %.20.i573, %arg.v_y
  %.20.i589 = add nsw i64 %.96.i587, %arg.v_z
  %.25.i590 = xor i64 %.20.i589, %.96.i587
  %.27.i591 = xor i64 %.20.i589, %arg.v_z
  %.28.i592 = and i64 %.25.i590, %.27.i591
  %.29.i593 = icmp slt i64 %.28.i592, 0
  br i1 %.29.i593, label %common.ret.sink.split, label %B4632

B4632:                                            ; preds = %B4572
  %.25.i596 = sitofp i64 %.20.i589 to double
  %.28.i598 = fmul double %.27.i, %.25.i596
  %38 = tail call double @llvm.fabs.f64(double %.28.i598)
  %or.cond.i599 = fcmp ult double %38, 9.200000e+18
  br i1 %or.cond.i599, label %B4694, label %common.ret.sink.split

B4694:                                            ; preds = %B4632
  %.96.i603 = mul nsw i64 %.20.i589, %arg.v_y
  %.20.i605 = add nsw i64 %.96.i603, %arg.v_z
  %.25.i606 = xor i64 %.20.i605, %.96.i603
  %.27.i607 = xor i64 %.20.i605, %arg.v_z
  %.28.i608 = and i64 %.25.i606, %.27.i607
  %.29.i609 = icmp slt i64 %.28.i608, 0
  br i1 %.29.i609, label %common.ret.sink.split, label %B4754

B4754:                                            ; preds = %B4694
  %.25.i612 = sitofp i64 %.20.i605 to double
  %.28.i614 = fmul double %.27.i, %.25.i612
  %39 = tail call double @llvm.fabs.f64(double %.28.i614)
  %or.cond.i615 = fcmp ult double %39, 9.200000e+18
  br i1 %or.cond.i615, label %B4816, label %common.ret.sink.split

B4816:                                            ; preds = %B4754
  %.96.i619 = mul nsw i64 %.20.i605, %arg.v_y
  %.20.i621 = add nsw i64 %.96.i619, %arg.v_z
  %.25.i622 = xor i64 %.20.i621, %.96.i619
  %.27.i623 = xor i64 %.20.i621, %arg.v_z
  %.28.i624 = and i64 %.25.i622, %.27.i623
  %.29.i625 = icmp slt i64 %.28.i624, 0
  br i1 %.29.i625, label %common.ret.sink.split, label %B4876

B4876:                                            ; preds = %B4816
  %.25.i628 = sitofp i64 %.20.i621 to double
  %.28.i630 = fmul double %.27.i, %.25.i628
  %40 = tail call double @llvm.fabs.f64(double %.28.i630)
  %or.cond.i631 = fcmp ult double %40, 9.200000e+18
  br i1 %or.cond.i631, label %B4938, label %common.ret.sink.split

B4938:                                            ; preds = %B4876
  %.96.i635 = mul nsw i64 %.20.i621, %arg.v_y
  %.20.i637 = add nsw i64 %.96.i635, %arg.v_z
  %.25.i638 = xor i64 %.20.i637, %.96.i635
  %.27.i639 = xor i64 %.20.i637, %arg.v_z
  %.28.i640 = and i64 %.25.i638, %.27.i639
  %.29.i641 = icmp slt i64 %.28.i640, 0
  br i1 %.29.i641, label %common.ret.sink.split, label %B4998

B4998:                                            ; preds = %B4938
  %.25.i644 = sitofp i64 %.20.i637 to double
  %.28.i646 = fmul double %.27.i, %.25.i644
  %41 = tail call double @llvm.fabs.f64(double %.28.i646)
  %or.cond.i647 = fcmp ult double %41, 9.200000e+18
  br i1 %or.cond.i647, label %B5060, label %common.ret.sink.split

B5060:                                            ; preds = %B4998
  %.96.i651 = mul nsw i64 %.20.i637, %arg.v_y
  %.20.i653 = add nsw i64 %.96.i651, %arg.v_z
  %.25.i654 = xor i64 %.20.i653, %.96.i651
  %.27.i655 = xor i64 %.20.i653, %arg.v_z
  %.28.i656 = and i64 %.25.i654, %.27.i655
  %.29.i657 = icmp slt i64 %.28.i656, 0
  br i1 %.29.i657, label %common.ret.sink.split, label %B5120

B5120:                                            ; preds = %B5060
  %.25.i660 = sitofp i64 %.20.i653 to double
  %.28.i662 = fmul double %.27.i, %.25.i660
  %42 = tail call double @llvm.fabs.f64(double %.28.i662)
  %or.cond.i663 = fcmp ult double %42, 9.200000e+18
  br i1 %or.cond.i663, label %B5182, label %common.ret.sink.split

B5182:                                            ; preds = %B5120
  %.96.i667 = mul nsw i64 %.20.i653, %arg.v_y
  %.20.i669 = add nsw i64 %.96.i667, %arg.v_z
  %.25.i670 = xor i64 %.20.i669, %.96.i667
  %.27.i671 = xor i64 %.20.i669, %arg.v_z
  %.28.i672 = and i64 %.25.i670, %.27.i671
  %.29.i673 = icmp slt i64 %.28.i672, 0
  br i1 %.29.i673, label %common.ret.sink.split, label %B5242

B5242:                                            ; preds = %B5182
  %.25.i676 = sitofp i64 %.20.i669 to double
  %.28.i678 = fmul double %.27.i, %.25.i676
  %43 = tail call double @llvm.fabs.f64(double %.28.i678)
  %or.cond.i679 = fcmp ult double %43, 9.200000e+18
  br i1 %or.cond.i679, label %B5304, label %common.ret.sink.split

B5304:                                            ; preds = %B5242
  %.96.i683 = mul nsw i64 %.20.i669, %arg.v_y
  %.20.i685 = add nsw i64 %.96.i683, %arg.v_z
  %.25.i686 = xor i64 %.20.i685, %.96.i683
  %.27.i687 = xor i64 %.20.i685, %arg.v_z
  %.28.i688 = and i64 %.25.i686, %.27.i687
  %.29.i689 = icmp slt i64 %.28.i688, 0
  br i1 %.29.i689, label %common.ret.sink.split, label %B5364

B5364:                                            ; preds = %B5304
  %.25.i692 = sitofp i64 %.20.i685 to double
  %.28.i694 = fmul double %.27.i, %.25.i692
  %44 = tail call double @llvm.fabs.f64(double %.28.i694)
  %or.cond.i695 = fcmp ult double %44, 9.200000e+18
  br i1 %or.cond.i695, label %B5426, label %common.ret.sink.split

B5426:                                            ; preds = %B5364
  %.96.i699 = mul nsw i64 %.20.i685, %arg.v_y
  %.20.i701 = add nsw i64 %.96.i699, %arg.v_z
  %.25.i702 = xor i64 %.20.i701, %.96.i699
  %.27.i703 = xor i64 %.20.i701, %arg.v_z
  %.28.i704 = and i64 %.25.i702, %.27.i703
  %.29.i705 = icmp slt i64 %.28.i704, 0
  br i1 %.29.i705, label %common.ret.sink.split, label %B5486

B5486:                                            ; preds = %B5426
  %.25.i708 = sitofp i64 %.20.i701 to double
  %.28.i710 = fmul double %.27.i, %.25.i708
  %45 = tail call double @llvm.fabs.f64(double %.28.i710)
  %or.cond.i711 = fcmp ult double %45, 9.200000e+18
  br i1 %or.cond.i711, label %B5548, label %common.ret.sink.split

B5548:                                            ; preds = %B5486
  %.96.i715 = mul nsw i64 %.20.i701, %arg.v_y
  %.20.i717 = add nsw i64 %.96.i715, %arg.v_z
  %.25.i718 = xor i64 %.20.i717, %.96.i715
  %.27.i719 = xor i64 %.20.i717, %arg.v_z
  %.28.i720 = and i64 %.25.i718, %.27.i719
  %.29.i721 = icmp slt i64 %.28.i720, 0
  br i1 %.29.i721, label %common.ret.sink.split, label %B5608

B5608:                                            ; preds = %B5548
  %.25.i724 = sitofp i64 %.20.i717 to double
  %.28.i726 = fmul double %.27.i, %.25.i724
  %46 = tail call double @llvm.fabs.f64(double %.28.i726)
  %or.cond.i727 = fcmp ult double %46, 9.200000e+18
  br i1 %or.cond.i727, label %B5670, label %common.ret.sink.split

B5670:                                            ; preds = %B5608
  %.96.i731 = mul nsw i64 %.20.i717, %arg.v_y
  %.20.i733 = add nsw i64 %.96.i731, %arg.v_z
  %.25.i734 = xor i64 %.20.i733, %.96.i731
  %.27.i735 = xor i64 %.20.i733, %arg.v_z
  %.28.i736 = and i64 %.25.i734, %.27.i735
  %.29.i737 = icmp slt i64 %.28.i736, 0
  br i1 %.29.i737, label %common.ret.sink.split, label %B5730

B5730:                                            ; preds = %B5670
  %.25.i740 = sitofp i64 %.20.i733 to double
  %.28.i742 = fmul double %.27.i, %.25.i740
  %47 = tail call double @llvm.fabs.f64(double %.28.i742)
  %or.cond.i743 = fcmp ult double %47, 9.200000e+18
  br i1 %or.cond.i743, label %B5792, label %common.ret.sink.split

B5792:                                            ; preds = %B5730
  %.96.i747 = mul nsw i64 %.20.i733, %arg.v_y
  %.20.i749 = add nsw i64 %.96.i747, %arg.v_z
  %.25.i750 = xor i64 %.20.i749, %.96.i747
  %.27.i751 = xor i64 %.20.i749, %arg.v_z
  %.28.i752 = and i64 %.25.i750, %.27.i751
  %.29.i753 = icmp slt i64 %.28.i752, 0
  br i1 %.29.i753, label %common.ret.sink.split, label %B5852

B5852:                                            ; preds = %B5792
  %.25.i756 = sitofp i64 %.20.i749 to double
  %.28.i758 = fmul double %.27.i, %.25.i756
  %48 = tail call double @llvm.fabs.f64(double %.28.i758)
  %or.cond.i759 = fcmp ult double %48, 9.200000e+18
  br i1 %or.cond.i759, label %B5914, label %common.ret.sink.split

B5914:                                            ; preds = %B5852
  %.96.i763 = mul nsw i64 %.20.i749, %arg.v_y
  %.20.i765 = add nsw i64 %.96.i763, %arg.v_z
  %.25.i766 = xor i64 %.20.i765, %.96.i763
  %.27.i767 = xor i64 %.20.i765, %arg.v_z
  %.28.i768 = and i64 %.25.i766, %.27.i767
  %.29.i769 = icmp slt i64 %.28.i768, 0
  br i1 %.29.i769, label %common.ret.sink.split, label %B5974

B5974:                                            ; preds = %B5914
  %.25.i772 = sitofp i64 %.20.i765 to double
  %.28.i774 = fmul double %.27.i, %.25.i772
  %49 = tail call double @llvm.fabs.f64(double %.28.i774)
  %or.cond.i775 = fcmp ult double %49, 9.200000e+18
  br i1 %or.cond.i775, label %B6036, label %common.ret.sink.split

B6036:                                            ; preds = %B5974
  %.96.i779 = mul nsw i64 %.20.i765, %arg.v_y
  %.20.i781 = add nsw i64 %.96.i779, %arg.v_z
  %.25.i782 = xor i64 %.20.i781, %.96.i779
  %.27.i783 = xor i64 %.20.i781, %arg.v_z
  %.28.i784 = and i64 %.25.i782, %.27.i783
  %.29.i785 = icmp slt i64 %.28.i784, 0
  br i1 %.29.i785, label %common.ret.sink.split, label %B6096

B6096:                                            ; preds = %B6036
  %.25.i788 = sitofp i64 %.20.i781 to double
  %.28.i790 = fmul double %.27.i, %.25.i788
  %50 = tail call double @llvm.fabs.f64(double %.28.i790)
  %or.cond.i791 = fcmp ult double %50, 9.200000e+18
  br i1 %or.cond.i791, label %B6158, label %common.ret.sink.split

B6158:                                            ; preds = %B6096
  %.96.i795 = mul nsw i64 %.20.i781, %arg.v_y
  %.20.i797 = add nsw i64 %.96.i795, %arg.v_z
  %.25.i798 = xor i64 %.20.i797, %.96.i795
  %.27.i799 = xor i64 %.20.i797, %arg.v_z
  %.28.i800 = and i64 %.25.i798, %.27.i799
  %.29.i801 = icmp slt i64 %.28.i800, 0
  br i1 %.29.i801, label %common.ret.sink.split, label %B6158.endif

B6218:                                            ; preds = %B6158.endif
  %.25.i804 = sitofp i64 %.20.i797 to double
  %.28.i806 = fmul double %.27.i, %.25.i804
  %51 = tail call double @llvm.fabs.f64(double %.28.i806)
  %or.cond.i807 = fcmp ult double %51, 9.200000e+18
  br i1 %or.cond.i807, label %B6280, label %common.ret.sink.split

B6280:                                            ; preds = %B6218
  %.96.i811 = mul nsw i64 %.20.i797, %arg.v_y
  %.20.i813 = add nsw i64 %.96.i811, %arg.v_z
  %.25.i814 = xor i64 %.20.i813, %.96.i811
  %.27.i815 = xor i64 %.20.i813, %arg.v_z
  %.28.i816 = and i64 %.25.i814, %.27.i815
  %.29.i817 = icmp slt i64 %.28.i816, 0
  br i1 %.29.i817, label %common.ret.sink.split, label %B6340

B6340:                                            ; preds = %B6280
  %.25.i820 = sitofp i64 %.20.i813 to double
  %.28.i822 = fmul double %.27.i, %.25.i820
  %52 = tail call double @llvm.fabs.f64(double %.28.i822)
  %or.cond.i823 = fcmp ult double %52, 9.200000e+18
  br i1 %or.cond.i823, label %B6402, label %common.ret.sink.split

B6402:                                            ; preds = %B6340
  %.96.i827 = mul nsw i64 %.20.i813, %arg.v_y
  %.20.i829 = add nsw i64 %.96.i827, %arg.v_z
  %.25.i830 = xor i64 %.20.i829, %.96.i827
  %.27.i831 = xor i64 %.20.i829, %arg.v_z
  %.28.i832 = and i64 %.25.i830, %.27.i831
  %.29.i833 = icmp slt i64 %.28.i832, 0
  br i1 %.29.i833, label %common.ret.sink.split, label %B6462

B6462:                                            ; preds = %B6402
  %.25.i836 = sitofp i64 %.20.i829 to double
  %.28.i838 = fmul double %.27.i, %.25.i836
  %53 = tail call double @llvm.fabs.f64(double %.28.i838)
  %or.cond.i839 = fcmp ult double %53, 9.200000e+18
  br i1 %or.cond.i839, label %B6524, label %common.ret.sink.split

B6524:                                            ; preds = %B6462
  %.96.i843 = mul nsw i64 %.20.i829, %arg.v_y
  %.20.i845 = add nsw i64 %.96.i843, %arg.v_z
  %.25.i846 = xor i64 %.20.i845, %.96.i843
  %.27.i847 = xor i64 %.20.i845, %arg.v_z
  %.28.i848 = and i64 %.25.i846, %.27.i847
  %.29.i849 = icmp slt i64 %.28.i848, 0
  br i1 %.29.i849, label %common.ret.sink.split, label %B6584

B6584:                                            ; preds = %B6524
  %.25.i852 = sitofp i64 %.20.i845 to double
  %.28.i854 = fmul double %.27.i, %.25.i852
  %54 = tail call double @llvm.fabs.f64(double %.28.i854)
  %or.cond.i855 = fcmp ult double %54, 9.200000e+18
  br i1 %or.cond.i855, label %B6646, label %common.ret.sink.split

B6646:                                            ; preds = %B6584
  %.96.i859 = mul nsw i64 %.20.i845, %arg.v_y
  %.20.i861 = add nsw i64 %.96.i859, %arg.v_z
  %.25.i862 = xor i64 %.20.i861, %.96.i859
  %.27.i863 = xor i64 %.20.i861, %arg.v_z
  %.28.i864 = and i64 %.25.i862, %.27.i863
  %.29.i865 = icmp slt i64 %.28.i864, 0
  br i1 %.29.i865, label %common.ret.sink.split, label %B6706

B6706:                                            ; preds = %B6646
  %.25.i868 = sitofp i64 %.20.i861 to double
  %.28.i870 = fmul double %.27.i, %.25.i868
  %55 = tail call double @llvm.fabs.f64(double %.28.i870)
  %or.cond.i871 = fcmp ult double %55, 9.200000e+18
  br i1 %or.cond.i871, label %B6768, label %common.ret.sink.split

B6768:                                            ; preds = %B6706
  %.96.i875 = mul nsw i64 %.20.i861, %arg.v_y
  %.20.i877 = add nsw i64 %.96.i875, %arg.v_z
  %.25.i878 = xor i64 %.20.i877, %.96.i875
  %.27.i879 = xor i64 %.20.i877, %arg.v_z
  %.28.i880 = and i64 %.25.i878, %.27.i879
  %.29.i881 = icmp slt i64 %.28.i880, 0
  br i1 %.29.i881, label %common.ret.sink.split, label %B6828

B6828:                                            ; preds = %B6768
  %.25.i884 = sitofp i64 %.20.i877 to double
  %.28.i886 = fmul double %.27.i, %.25.i884
  %56 = tail call double @llvm.fabs.f64(double %.28.i886)
  %or.cond.i887 = fcmp ult double %56, 9.200000e+18
  br i1 %or.cond.i887, label %B6890, label %common.ret.sink.split

B6890:                                            ; preds = %B6828
  %.96.i891 = mul nsw i64 %.20.i877, %arg.v_y
  %.20.i893 = add nsw i64 %.96.i891, %arg.v_z
  %.25.i894 = xor i64 %.20.i893, %.96.i891
  %.27.i895 = xor i64 %.20.i893, %arg.v_z
  %.28.i896 = and i64 %.25.i894, %.27.i895
  %.29.i897 = icmp slt i64 %.28.i896, 0
  br i1 %.29.i897, label %common.ret.sink.split, label %B6950

B6950:                                            ; preds = %B6890
  %.25.i900 = sitofp i64 %.20.i893 to double
  %.28.i902 = fmul double %.27.i, %.25.i900
  %57 = tail call double @llvm.fabs.f64(double %.28.i902)
  %or.cond.i903 = fcmp ult double %57, 9.200000e+18
  br i1 %or.cond.i903, label %B7012, label %common.ret.sink.split

B7012:                                            ; preds = %B6950
  %.96.i907 = mul nsw i64 %.20.i893, %arg.v_y
  %.20.i909 = add nsw i64 %.96.i907, %arg.v_z
  %.25.i910 = xor i64 %.20.i909, %.96.i907
  %.27.i911 = xor i64 %.20.i909, %arg.v_z
  %.28.i912 = and i64 %.25.i910, %.27.i911
  %.29.i913 = icmp slt i64 %.28.i912, 0
  br i1 %.29.i913, label %common.ret.sink.split, label %B7072

B7072:                                            ; preds = %B7012
  %.25.i916 = sitofp i64 %.20.i909 to double
  %.28.i918 = fmul double %.27.i, %.25.i916
  %58 = tail call double @llvm.fabs.f64(double %.28.i918)
  %or.cond.i919 = fcmp ult double %58, 9.200000e+18
  br i1 %or.cond.i919, label %B7134, label %common.ret.sink.split

B7134:                                            ; preds = %B7072
  %.96.i923 = mul nsw i64 %.20.i909, %arg.v_y
  %.20.i925 = add nsw i64 %.96.i923, %arg.v_z
  %.25.i926 = xor i64 %.20.i925, %.96.i923
  %.27.i927 = xor i64 %.20.i925, %arg.v_z
  %.28.i928 = and i64 %.25.i926, %.27.i927
  %.29.i929 = icmp slt i64 %.28.i928, 0
  br i1 %.29.i929, label %common.ret.sink.split, label %B7194

B7194:                                            ; preds = %B7134
  %.25.i932 = sitofp i64 %.20.i925 to double
  %.28.i934 = fmul double %.27.i, %.25.i932
  %59 = tail call double @llvm.fabs.f64(double %.28.i934)
  %or.cond.i935 = fcmp ult double %59, 9.200000e+18
  br i1 %or.cond.i935, label %B7256, label %common.ret.sink.split

B7256:                                            ; preds = %B7194
  %.96.i939 = mul nsw i64 %.20.i925, %arg.v_y
  %.20.i941 = add nsw i64 %.96.i939, %arg.v_z
  %.25.i942 = xor i64 %.20.i941, %.96.i939
  %.27.i943 = xor i64 %.20.i941, %arg.v_z
  %.28.i944 = and i64 %.25.i942, %.27.i943
  %.29.i945 = icmp slt i64 %.28.i944, 0
  br i1 %.29.i945, label %common.ret.sink.split, label %B7316

B7316:                                            ; preds = %B7256
  %.25.i948 = sitofp i64 %.20.i941 to double
  %.28.i950 = fmul double %.27.i, %.25.i948
  %60 = tail call double @llvm.fabs.f64(double %.28.i950)
  %or.cond.i951 = fcmp ult double %60, 9.200000e+18
  br i1 %or.cond.i951, label %B7378, label %common.ret.sink.split

B7378:                                            ; preds = %B7316
  %.96.i955 = mul nsw i64 %.20.i941, %arg.v_y
  %.20.i957 = add nsw i64 %.96.i955, %arg.v_z
  %.25.i958 = xor i64 %.20.i957, %.96.i955
  %.27.i959 = xor i64 %.20.i957, %arg.v_z
  %.28.i960 = and i64 %.25.i958, %.27.i959
  %.29.i961 = icmp slt i64 %.28.i960, 0
  br i1 %.29.i961, label %common.ret.sink.split, label %B7438

B7438:                                            ; preds = %B7378
  %.25.i964 = sitofp i64 %.20.i957 to double
  %.28.i966 = fmul double %.27.i, %.25.i964
  %61 = tail call double @llvm.fabs.f64(double %.28.i966)
  %or.cond.i967 = fcmp ult double %61, 9.200000e+18
  br i1 %or.cond.i967, label %B7500, label %common.ret.sink.split

B7500:                                            ; preds = %B7438
  %.96.i971 = mul nsw i64 %.20.i957, %arg.v_y
  %.20.i973 = add nsw i64 %.96.i971, %arg.v_z
  %.25.i974 = xor i64 %.20.i973, %.96.i971
  %.27.i975 = xor i64 %.20.i973, %arg.v_z
  %.28.i976 = and i64 %.25.i974, %.27.i975
  %.29.i977 = icmp slt i64 %.28.i976, 0
  br i1 %.29.i977, label %common.ret.sink.split, label %B7560

B7560:                                            ; preds = %B7500
  %.25.i980 = sitofp i64 %.20.i973 to double
  %.28.i982 = fmul double %.27.i, %.25.i980
  %62 = tail call double @llvm.fabs.f64(double %.28.i982)
  %or.cond.i983 = fcmp ult double %62, 9.200000e+18
  br i1 %or.cond.i983, label %B7622, label %common.ret.sink.split

B7622:                                            ; preds = %B7560
  %.96.i987 = mul nsw i64 %.20.i973, %arg.v_y
  %.20.i989 = add nsw i64 %.96.i987, %arg.v_z
  %.25.i990 = xor i64 %.20.i989, %.96.i987
  %.27.i991 = xor i64 %.20.i989, %arg.v_z
  %.28.i992 = and i64 %.25.i990, %.27.i991
  %.29.i993 = icmp slt i64 %.28.i992, 0
  br i1 %.29.i993, label %common.ret.sink.split, label %B7682

B7682:                                            ; preds = %B7622
  %.25.i996 = sitofp i64 %.20.i989 to double
  %.28.i998 = fmul double %.27.i, %.25.i996
  %63 = tail call double @llvm.fabs.f64(double %.28.i998)
  %or.cond.i999 = fcmp ult double %63, 9.200000e+18
  br i1 %or.cond.i999, label %B7744, label %common.ret.sink.split

B7744:                                            ; preds = %B7682
  %.96.i1003 = mul nsw i64 %.20.i989, %arg.v_y
  %.20.i1005 = add nsw i64 %.96.i1003, %arg.v_z
  %.25.i1006 = xor i64 %.20.i1005, %.96.i1003
  %.27.i1007 = xor i64 %.20.i1005, %arg.v_z
  %.28.i1008 = and i64 %.25.i1006, %.27.i1007
  %.29.i1009 = icmp slt i64 %.28.i1008, 0
  br i1 %.29.i1009, label %common.ret.sink.split, label %common.ret

B0.endif:                                         ; preds = %B0
  %.133.pr = load i8, ptr %arg.st.4, align 1
  %.134.not = icmp eq i8 %.133.pr, 0
  br i1 %.134.not, label %B66, label %common.ret

B6158.endif:                                      ; preds = %B6158
  %.8213.pr = load i8, ptr %arg.st.4, align 1
  %.8214.not = icmp eq i8 %.8213.pr, 0
  br i1 %.8214.not, label %B6218, label %common.ret
}

define ptr @_ZN7cpython32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
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
  br i1 %.13, label %common.ret, label %entry.endif, !prof !1

common.ret:                                       ; preds = %entry.endif.endif.endif.thread, %entry.endif.endif.endif.e...endif.2.endif, %entry.endif.endif.endif.e...endif.2.endif.if, %entry.endif.endif.endif.e...endif.2.endif.endif.endif, %arg0.err, %entry, %entry.endif.endif.endif.e...if.2.endif, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.e...endif.2.endif.endif.endif ], [ null, %entry ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.e...endif.2.endif.if ], [ %.205, %entry.endif.endif.endif.e...if.2.endif ], [ null, %arg0.err ], [ null, %entry.endif.endif.endif.thread ], [ null, %entry.endif.endif.endif.e...endif.2.endif ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.17 = load ptr, ptr @_ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, align 8
  %.20 = icmp eq ptr %.17, null
  br i1 %.20, label %entry.endif.if, label %entry.endif.endif, !prof !1

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx")
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
  %.176 = call i32 @_ZN32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.164, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %.109.fca.4.load, i64 poison, i64 poison, i64 %.117.0, i64 %.133.0, i64 %.149.0) #3
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

define i64 @cfunc._ZN32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx({ ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.1, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.2, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.3, { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, i64 %.5, i64 %.6, i64 %.7) local_unnamed_addr {
entry:
  %.9 = alloca i64, align 8
  %extracted.data.3 = extractvalue { ptr, ptr, i64, i64, ptr, [1 x i64], [1 x i64] } %.4, 4
  %.21 = call i32 @_ZN32rc_heap_8bf7a2f1e77f8b23d8bdfb8e16f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.9, ptr nonnull poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr poison, i64 poison, i64 poison, ptr poison, ptr poison, i64 poison, i64 poison, ptr %extracted.data.3, i64 poison, i64 poison, i64 %.5, i64 %.6, i64 %.7) #3
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
