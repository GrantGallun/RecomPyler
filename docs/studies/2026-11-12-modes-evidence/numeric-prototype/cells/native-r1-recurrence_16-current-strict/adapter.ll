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
@_ZN08NumbaEnv32rc_heap_2b6ae51a3c827ac03ab1c7cf16f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx = common local_unnamed_addr global ptr null
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@_ZN08NumbaEnv32rc_heap_2b6ae51a3c827ac03ab1c7cf5mul_iB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_2b6ae51a3c827ac03ab1c7cf5add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8

define noundef range(i32 -1, -2) i32 @_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr readnone captures(none) %arg.fp, ptr readnone captures(none) %arg.ip, ptr readnone captures(none) %arg.tp, ptr captures(none) %arg.sp, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.155 = alloca i64, align 8
  %excinfo.5 = alloca ptr, align 8
  %.167 = call i32 @_ZN32rc_heap_2b6ae51a3c827ac03ab1c7cf16f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.155, ptr nonnull %excinfo.5, ptr null, ptr null, i64 65536, i64 8, ptr %arg.fp, i64 65536, i64 8, ptr null, ptr null, i64 65536, i64 8, ptr %arg.ip, i64 65536, i64 8, ptr null, ptr null, i64 4, i64 8, ptr %arg.tp, i64 4, i64 8, ptr null, ptr null, i64 1, i64 1, ptr %arg.sp, i64 1, i64 1, i64 %arg.x, i64 %arg.y, i64 %arg.z)
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
  %.14 = call i32 @_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr nonnull %.10, ptr nonnull %excinfo, ptr %.1, ptr %.2, ptr %.3, ptr %.4, i64 %.5, i64 %.6, i64 %.7, i64 poison) #2
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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define linkonce_odr noundef range(i32 -1, -2) i32 @_ZN32rc_heap_2b6ae51a3c827ac03ab1c7cf16f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z) local_unnamed_addr #0 {
B0:
  %.25.i = sitofp i64 %arg.v_x to double
  %.27.i = sitofp i64 %arg.v_y to double
  %.28.i = fmul double %.25.i, %.27.i
  %0 = tail call double @llvm.fabs.f64(double %.28.i)
  %or.cond.i = fcmp ult double %0, 9.200000e+18
  br i1 %or.cond.i, label %B0.endif, label %common.ret.sink.split

common.ret.sink.split:                            ; preds = %B1888, %B1826, %B1766, %B1704, %B1644, %B1582, %B1522, %B1460, %B1400, %B1338, %B1278, %B1216, %B1156, %B1094, %B1034, %B972, %B912, %B850, %B790, %B728, %B668, %B606, %B546, %B484, %B426, %B364, %B306, %B244, %B186, %B124, %B66, %B0
  store i8 1, ptr %arg.st.4, align 1, !noalias !2
  br label %common.ret

common.ret:                                       ; preds = %B0.endif, %B1888, %common.ret.sink.split
  %.20.i237.sink = phi i64 [ 0, %B0.endif ], [ %.20.i237, %B1888 ], [ 0, %common.ret.sink.split ]
  store i64 %.20.i237.sink, ptr %retptr, align 8
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
  br i1 %.29.i241, label %common.ret.sink.split, label %common.ret

B0.endif:                                         ; preds = %B0
  %.133.pr = load i8, ptr %arg.st.4, align 1
  %.134.not = icmp eq i8 %.133.pr, 0
  br i1 %.134.not, label %B66, label %common.ret
}

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

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { noinline }
attributes #3 = { nounwind }

!0 = !{!"branch_weights", i32 49, i32 1}
!1 = !{!"branch_weights", i32 1, i32 99}
!2 = !{}
