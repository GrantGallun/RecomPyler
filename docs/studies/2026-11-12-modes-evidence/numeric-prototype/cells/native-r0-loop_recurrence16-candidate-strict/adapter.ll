; ModuleID = 'adapter'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx = common local_unnamed_addr global ptr null
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v16B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v17B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx = common local_unnamed_addr global ptr null
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e95mul_iB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_73547edce78f3bbe0466b8e95add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8

define noundef range(i32 -1, -2) i32 @_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr readnone captures(none) %arg.fp, ptr readnone captures(none) %arg.ip, ptr readnone captures(none) %arg.tp, ptr captures(none) %arg.sp, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.155 = alloca i64, align 8
  %excinfo.5 = alloca ptr, align 8
  store i64 0, ptr %.155, align 8
  %.167 = call i32 @_ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr nonnull %.155, ptr nonnull %excinfo.5, ptr null, ptr null, i64 65536, i64 8, ptr %arg.fp, i64 65536, i64 8, ptr null, ptr null, i64 65536, i64 8, ptr %arg.ip, i64 65536, i64 8, ptr null, ptr null, i64 4, i64 8, ptr %arg.tp, i64 4, i64 8, ptr null, ptr null, i64 1, i64 1, ptr %arg.sp, i64 1, i64 1, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n)
  %cond = icmp eq i32 %.167, 0
  br i1 %cond, label %B0.endif.endif.endif.endif.endif, label %B0.endif.endif.endif.endif.if.if, !prof !0

common.ret:                                       ; preds = %B0.endif.endif.endif.endif.if.if, %B0.endif.endif.endif.endif.endif
  ret i32 %.167

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif
  %.177 = load i64, ptr %.155, align 8
  store i64 %.177, ptr %retptr, align 8
  br label %common.ret

B0.endif.endif.endif.endif.if.if:                 ; preds = %B0.endif.endif.endif.endif
  store ptr null, ptr %excinfo, align 8
  br label %common.ret
}

define i64 @cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr readnone captures(none) %.1, ptr readnone captures(none) %.2, ptr readnone captures(none) %.3, ptr captures(none) %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  %.14 = call i32 @_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr nonnull %.10, ptr nonnull %excinfo, ptr %.1, ptr %.2, ptr %.3, ptr %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) #2
  %.15 = load ptr, ptr %excinfo, align 8
  %.24 = load i64, ptr %.10, align 8
  %.26 = alloca i32, align 4
  store i32 0, ptr %.26, align 4
  %cond = icmp eq i32 %.14, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !0

entry.if:                                         ; preds = %entry
  %.22 = icmp sgt i32 %.14, 0
  call void @numba_gil_ensure(ptr nonnull %.26)
  br i1 %.22, label %entry.if.if, label %entry.if.endif

common.ret:                                       ; preds = %entry, %.29, %entry.if.if.if.if
  %common.ret.op = phi i64 [ 0, %entry.if.if.if.if ], [ %.24, %.29 ], [ %.24, %entry ]
  ret i64 %common.ret.op

.29:                                              ; preds = %entry.if.endif, %entry.if.if.endif, %entry.if.if.endif.if, %entry.if.endif.endif.endif, %entry.if.endif.if
  %.77 = call ptr @PyUnicode_FromString(ptr nonnull @".const.<numba.core.cpu.CPUContext>")
  call void @PyErr_WriteUnraisable(ptr %.77)
  call void @Py_DecRef(ptr %.77)
  call void @numba_gil_release(ptr nonnull %.26)
  br label %common.ret

entry.if.if:                                      ; preds = %entry.if
  call void @PyErr_Clear()
  %.32 = load { ptr, i32, ptr, ptr, i32 }, ptr %.15, align 8
  %.33 = extractvalue { ptr, i32, ptr, ptr, i32 } %.32, 4
  %.34 = icmp sgt i32 %.33, 0
  %.37 = extractvalue { ptr, i32, ptr, ptr, i32 } %.32, 0
  %.39 = extractvalue { ptr, i32, ptr, ptr, i32 } %.32, 1
  br i1 %.34, label %entry.if.if.if, label %entry.if.if.else

entry.if.endif:                                   ; preds = %entry.if
  switch i32 %.14, label %entry.if.endif.endif.endif [
    i32 -3, label %entry.if.endif.if
    i32 -1, label %.29
  ]

entry.if.if.if:                                   ; preds = %entry.if.if
  %.40 = sext i32 %.39 to i64
  %.41 = call ptr @PyBytes_FromStringAndSize(ptr %.37, i64 %.40)
  %.42 = load { ptr, i32, ptr, ptr, i32 }, ptr %.15, align 8
  %.43 = extractvalue { ptr, i32, ptr, ptr, i32 } %.42, 2
  %.45 = extractvalue { ptr, i32, ptr, ptr, i32 } %.42, 3
  %.47 = call ptr %.45(ptr %.43)
  %.48 = icmp eq ptr %.47, null
  br i1 %.48, label %entry.if.if.if.if, label %entry.if.if.if.endif, !prof !1

entry.if.if.else:                                 ; preds = %entry.if.if
  %.61 = extractvalue { ptr, i32, ptr, ptr, i32 } %.32, 2
  %.62 = call ptr @numba_unpickle(ptr %.37, i32 %.39, ptr %.61)
  br label %entry.if.if.endif

entry.if.if.endif:                                ; preds = %entry.if.if.if.endif, %entry.if.if.else
  %.64 = phi ptr [ %.52, %entry.if.if.if.endif ], [ %.62, %entry.if.if.else ]
  %.65.not = icmp eq ptr %.64, null
  br i1 %.65.not, label %.29, label %entry.if.if.endif.if, !prof !1

entry.if.if.if.if:                                ; preds = %entry.if.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments")
  br label %common.ret

entry.if.if.if.endif:                             ; preds = %entry.if.if.if
  %.52 = call ptr @numba_runtime_build_excinfo_struct(ptr %.41, ptr nonnull %.47)
  call void @NRT_Free(ptr nonnull %.15)
  br label %entry.if.if.endif

entry.if.if.endif.if:                             ; preds = %entry.if.if.endif
  call void @numba_do_raise(ptr nonnull %.64)
  br label %.29

entry.if.endif.if:                                ; preds = %entry.if.endif
  call void @PyErr_SetNone(ptr nonnull @PyExc_StopIteration)
  br label %.29

entry.if.endif.endif.endif:                       ; preds = %entry.if.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %.29
}

declare void @numba_gil_ensure(ptr) local_unnamed_addr

declare ptr @PyUnicode_FromString(ptr) local_unnamed_addr

declare void @PyErr_WriteUnraisable(ptr) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare void @numba_gil_release(ptr) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare ptr @PyBytes_FromStringAndSize(ptr, i64) local_unnamed_addr

declare ptr @numba_unpickle(ptr, i32, ptr) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare ptr @numba_runtime_build_excinfo_struct(ptr, ptr) local_unnamed_addr

declare void @NRT_Free(ptr) local_unnamed_addr

declare void @numba_do_raise(ptr) local_unnamed_addr

declare void @PyErr_SetNone(ptr) local_unnamed_addr

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite)
define linkonce_odr noundef range(i32 -1, -2) i32 @_ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z, i64 %arg.v_n) local_unnamed_addr #0 {
B0.endif:
  %.arg.v_n = tail call i64 @llvm.smax.i64(i64 %arg.v_n, i64 0)
  %.27.i = sitofp i64 %arg.v_y to double
  %0 = add nuw i64 %.arg.v_n, 1
  br label %B34

B34:                                              ; preds = %B1992, %B0.endif
  %lsr.iv = phi i64 [ %lsr.iv.next, %B1992 ], [ %0, %B0.endif ]
  %v_t.17.0 = phi i64 [ %.20.i1325, %B1992 ], [ %arg.v_x, %B0.endif ]
  %lsr.iv.next = add i64 %lsr.iv, -1
  %.155 = icmp sgt i64 %lsr.iv.next, 0
  br i1 %.155, label %B40, label %common.ret

B40:                                              ; preds = %B34
  %.25.i = sitofp i64 %v_t.17.0 to double
  %.28.i = fmul double %.27.i, %.25.i
  %1 = tail call double @llvm.fabs.f64(double %.28.i)
  %or.cond.i = fcmp ult double %1, 9.200000e+18
  br i1 %or.cond.i, label %B40.endif, label %common.ret.sink.split

common.ret.sink.split:                            ; preds = %B1992, %B1928, %B1866, %B1802, %B1740, %B1676, %B1614, %B1550, %B1488, %B1424, %B1362, %B1298, %B1236, %B1172, %B1110, %B1046, %B984, %B920, %B858, %B794, %B732, %B668, %B606, %B542, %B480, %B416, %B354, %B290, %B230, %B166, %B106, %B40
  store i8 1, ptr %arg.st.4, align 1, !noalias !2
  br label %common.ret

common.ret:                                       ; preds = %B40.endif, %B34, %common.ret.sink.split
  %v_t.17.0.lcssa.sink = phi i64 [ 0, %common.ret.sink.split ], [ 0, %B40.endif ], [ %v_t.17.0, %B34 ]
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

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #1

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #2 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret1, label %.3.endif, !prof !1

common.ret1:                                      ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret1, !prof !1

.3.endif.if:                                      ; preds = %.3.endif
  fence acquire
  tail call void @NRT_MemInfo_call_dtor(ptr nonnull %.1)
  ret void
}

; Function Attrs: nounwind
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #3

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { noinline }
attributes #3 = { nounwind }

!0 = !{!"branch_weights", i32 49, i32 1}
!1 = !{!"branch_weights", i32 1, i32 99}
!2 = !{}
