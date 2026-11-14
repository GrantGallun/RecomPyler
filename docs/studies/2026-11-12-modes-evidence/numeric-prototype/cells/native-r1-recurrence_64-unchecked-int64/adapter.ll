; ModuleID = 'adapter'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx = common local_unnamed_addr global ptr null
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@PyExc_StopIteration = external global i8
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"
@".const.<numba.core.cpu.CPUContext>" = internal constant [28 x i8] c"<numba.core.cpu.CPUContext>\00"
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29 = common local_unnamed_addr global ptr null
@_ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8

define range(i32 -1, -2) i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr readnone captures(none) %arg.fp, ptr readnone captures(none) %arg.ip, ptr readnone captures(none) %arg.tp, ptr readnone captures(none) %arg.sp, i64 %arg.x, i64 %arg.y, i64 %arg.z, i64 %arg.n) local_unnamed_addr {
B0.endif.endif.endif.endif:
  %.155 = alloca i64, align 8
  %excinfo.5 = alloca ptr, align 8
  %.167 = call i32 @_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr nonnull %.155, ptr nonnull %excinfo.5, ptr null, ptr null, i64 65536, i64 8, ptr %arg.fp, i64 65536, i64 8, ptr null, ptr null, i64 65536, i64 8, ptr %arg.ip, i64 65536, i64 8, ptr null, ptr null, i64 4, i64 8, ptr %arg.tp, i64 4, i64 8, ptr null, ptr null, i64 1, i64 1, ptr %arg.sp, i64 1, i64 1, i64 %arg.x, i64 %arg.y, i64 %arg.z)
  switch i32 %.167, label %B0.endif.endif.endif.endif.if.if [
    i32 -2, label %B0.endif.endif.endif.endif.endif
    i32 0, label %B0.endif.endif.endif.endif.endif
  ], !prof !0

common.ret:                                       ; preds = %B0.endif.endif.endif.endif.if.if, %B0.endif.endif.endif.endif.endif
  %common.ret.op = phi i32 [ %.167, %B0.endif.endif.endif.endif.if.if ], [ 0, %B0.endif.endif.endif.endif.endif ]
  ret i32 %common.ret.op

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif, %B0.endif.endif.endif.endif
  %.177 = load i64, ptr %.155, align 8
  store i64 %.177, ptr %retptr, align 8
  br label %common.ret

B0.endif.endif.endif.endif.if.if:                 ; preds = %B0.endif.endif.endif.endif
  store ptr null, ptr %excinfo, align 8
  br label %common.ret
}

define i64 @cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr readnone captures(none) %.1, ptr readnone captures(none) %.2, ptr readnone captures(none) %.3, ptr readnone captures(none) %.4, i64 %.5, i64 %.6, i64 %.7, i64 %.8) local_unnamed_addr {
entry:
  %.10 = alloca i64, align 8
  store i64 0, ptr %.10, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  %.14 = call i32 @_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx(ptr nonnull %.10, ptr nonnull %excinfo, ptr %.1, ptr %.2, ptr %.3, ptr %.4, i64 %.5, i64 %.6, i64 %.7, i64 poison) #1
  %.15 = load ptr, ptr %excinfo, align 8
  %.24 = load i64, ptr %.10, align 8
  %.26 = alloca i32, align 4
  store i32 0, ptr %.26, align 4
  %cond = icmp eq i32 %.14, 0
  br i1 %cond, label %common.ret, label %entry.if, !prof !1

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
  br i1 %.48, label %entry.if.if.if.if, label %entry.if.if.if.endif, !prof !2

entry.if.if.else:                                 ; preds = %entry.if.if
  %.61 = extractvalue { ptr, i32, ptr, ptr, i32 } %.32, 2
  %.62 = call ptr @numba_unpickle(ptr %.37, i32 %.39, ptr %.61)
  br label %entry.if.if.endif

entry.if.if.endif:                                ; preds = %entry.if.if.if.endif, %entry.if.if.else
  %.64 = phi ptr [ %.52, %entry.if.if.if.endif ], [ %.62, %entry.if.if.else ]
  %.65.not = icmp eq ptr %.64, null
  br i1 %.65.not, label %.29, label %entry.if.if.endif.if, !prof !2

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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define linkonce_odr noundef i32 @_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx(ptr noalias writeonly captures(none) initializes((0, 8)) %retptr, ptr noalias readnone captures(none) %excinfo, ptr readnone captures(none) %arg.F.0, ptr readnone captures(none) %arg.F.1, i64 %arg.F.2, i64 %arg.F.3, ptr readnone captures(none) %arg.F.4, i64 %arg.F.5.0, i64 %arg.F.6.0, ptr readnone captures(none) %arg.I.0, ptr readnone captures(none) %arg.I.1, i64 %arg.I.2, i64 %arg.I.3, ptr readnone captures(none) %arg.I.4, i64 %arg.I.5.0, i64 %arg.I.6.0, ptr readnone captures(none) %arg.top.0, ptr readnone captures(none) %arg.top.1, i64 %arg.top.2, i64 %arg.top.3, ptr readnone captures(none) %arg.top.4, i64 %arg.top.5.0, i64 %arg.top.6.0, ptr readnone captures(none) %arg.st.0, ptr readnone captures(none) %arg.st.1, i64 %arg.st.2, i64 %arg.st.3, ptr readnone captures(none) %arg.st.4, i64 %arg.st.5.0, i64 %arg.st.6.0, i64 %arg.v_x, i64 %arg.v_y, i64 %arg.v_z) local_unnamed_addr #0 {
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

; Function Attrs: noinline
define linkonce_odr void @NRT_decref(ptr %.1) local_unnamed_addr #1 {
.3:
  %.4 = icmp eq ptr %.1, null
  br i1 %.4, label %common.ret, label %.3.endif, !prof !2

common.ret:                                       ; preds = %.3, %.3.endif
  ret void

.3.endif:                                         ; preds = %.3
  fence release
  %0 = tail call i8 @llvm.x86.atomic.sub.cc.i64(ptr nonnull %.1, i64 1, i32 4)
  %1 = trunc i8 %0 to i1
  br i1 %1, label %.3.endif.if, label %common.ret, !prof !2

.3.endif.if:                                      ; preds = %.3.endif
  fence acquire
  tail call void @NRT_MemInfo_call_dtor(ptr nonnull %.1)
  ret void
}

; Function Attrs: nounwind
declare i8 @llvm.x86.atomic.sub.cc.i64(ptr, i64, i32 immarg) #2

declare void @NRT_MemInfo_call_dtor(ptr) local_unnamed_addr

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) }
attributes #1 = { noinline }
attributes #2 = { nounwind }

!0 = !{!"branch_weights", i32 1, i32 49, i32 49}
!1 = !{!"branch_weights", i32 49, i32 1}
!2 = !{!"branch_weights", i32 1, i32 99}
