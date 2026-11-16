; ModuleID = 'mixed_calls'
source_filename = "<string>"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

@.const.pickledata.139f67d5de86be05fe0cddb987e10981a96b3959 = internal constant [128 x i8] c"\80\04\95u\00\00\00\00\00\00\00\8C\08builtins\94\8C\0CRuntimeError\94\93\94\8CPmissing Environment: _ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject\94\85\94N\87\94."
@.const.pickledata.139f67d5de86be05fe0cddb987e10981a96b3959.sha1 = internal constant [20 x i8] c"\13\9Fg\D5\DE\86\BE\05\FE\0C\DD\B9\87\E1\09\81\A9k9Y"
@.const.picklebuf.139f67d5de86be05fe0cddb987e10981a96b3959 = internal constant { ptr, i32, ptr, ptr, i32 } { ptr @.const.pickledata.139f67d5de86be05fe0cddb987e10981a96b3959, i32 128, ptr @.const.pickledata.139f67d5de86be05fe0cddb987e10981a96b3959.sha1, ptr null, i32 0 }
@".const.`env.consts` is NULL in `read_const`" = internal constant [37 x i8] c"`env.consts` is NULL in `read_const`\00"
@".const.global name 'min' is not defined" = internal constant [33 x i8] c"global name 'min' is not defined\00"
@PyExc_NameError = external global i8
@".const.name 'hstate' is not defined" = internal constant [29 x i8] c"name 'hstate' is not defined\00"
@".const.global name 'max' is not defined" = internal constant [33 x i8] c"global name 'max' is not defined\00"
@".const.name 'change' is not defined" = internal constant [29 x i8] c"name 'change' is not defined\00"
@.const.hp = internal constant [3 x i8] c"hp\00"
@.const.mixed_calls = internal constant [12 x i8] c"mixed_calls\00"
@_ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject = common local_unnamed_addr global ptr null
@PyExc_RuntimeError = external global i8
@".const.missing Environment: _ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject" = internal constant [81 x i8] c"missing Environment: _ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject\00"
@".const.Error creating Python tuple from runtime exception arguments" = internal constant [61 x i8] c"Error creating Python tuple from runtime exception arguments\00"
@PyExc_SystemError = external global i8
@".const.unknown error when calling native function" = internal constant [43 x i8] c"unknown error when calling native function\00"

define range(i32 -1, 2) i32 @_ZN9prototype11mixed_callsB2v8E8pyobject8pyobject(ptr noalias writeonly captures(none) %retptr, ptr noalias writeonly captures(none) %excinfo, ptr %arg.hstate, ptr %arg.change) local_unnamed_addr {
entry:
  %.6 = load ptr, ptr @_ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject, align 8
  %.7 = icmp eq ptr %.6, null
  br i1 %.7, label %entry.if, label %B0, !prof !0

B0:                                               ; preds = %entry
  %.16 = getelementptr i8, ptr %.6, i64 16
  tail call void @Py_IncRef(ptr %arg.hstate)
  tail call void @Py_IncRef(ptr %arg.change)
  %.35 = load ptr, ptr %.16, align 8
  %.36 = getelementptr i8, ptr %.6, i64 24
  %.37 = load ptr, ptr %.36, align 8
  %.41.not = icmp eq ptr %.37, null
  br i1 %.41.not, label %B0.endif.thread, label %B0.endif

common.ret:                                       ; preds = %B0.endif.endif.endif.endi...endif.9, %B0.endif.endif.endif.endi...endif.9.endif.endif.endif, %B0.endif.endif.endif.endi...endif.8.if, %B0.endif.endif.endif.endi...endif.7.endif.endif.if, %B0.endif.endif.endif.endi...endif.7.if, %B0.endif.endif.endif.endi...if.7, %B0.endif.endif.endif.endi...endif.6.if, %B0.endif.endif.endif.endi...endif.5.if, %B0.endif.endif.endif.endi...endif.4.if, %B0.endif.endif.endif.endi...if.4, %B0.endif.endif.endif.endi...endif.3.endif.if, %B0.endif.endif.endif.endi...endif.3.if, %B0.endif.endif.endif.endi...endif.1.endif.if, %B0.endif.endif.endif.endi...if.2.endif.endif.if, %B0.endif.endif.endif.endi...if.2.endif.if, %B0.endif.endif.endif.endi...if.1.endif.endif.endif.if, %B0.endif.endif.endif.endi...if.1.endif.if, %B0.endif.endif.endif.endi...endif.endif.endif.if, %B0.endif.endif.endif.endi...endif.if, %B0.endif.endif.endif.endi...if, %B0.endif.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.endif.endif.if, %B0.endif.endif.endif.if, %B0.endif.endif.if.endif.e...if, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if, %B0.endif.endif.if.endif.endif.endif.if, %B0.endif.endif.if.endif.if, %B0.endif.if, %entry.if
  %common.ret.op = phi i32 [ 1, %entry.if ], [ -1, %B0.endif.if ], [ -1, %B0.endif.endif.if.endif.if ], [ -1, %B0.endif.endif.if.endif.endif.endif.if ], [ -1, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if ], [ -1, %B0.endif.endif.if.endif.e...if ], [ -1, %B0.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if ], [ -1, %B0.endif.endif.endif.endi...endif.if ], [ -1, %B0.endif.endif.endif.endi...endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.1.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.1.endif.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.2.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.2.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...endif.1.endif.if ], [ -1, %B0.endif.endif.endif.endi...endif.3.if ], [ -1, %B0.endif.endif.endif.endi...endif.3.endif.if ], [ -1, %B0.endif.endif.endif.endi...if.4 ], [ -1, %B0.endif.endif.endif.endi...endif.4.if ], [ -1, %B0.endif.endif.endif.endi...endif.5.if ], [ -1, %B0.endif.endif.endif.endi...endif.6.if ], [ -1, %B0.endif.endif.endif.endi...if.7 ], [ -1, %B0.endif.endif.endif.endi...endif.7.if ], [ -1, %B0.endif.endif.endif.endi...endif.7.endif.endif.if ], [ -1, %B0.endif.endif.endif.endi...endif.8.if ], [ 0, %B0.endif.endif.endif.endi...endif.9.endif.endif.endif ], [ -1, %B0.endif.endif.endif.endi...endif.9 ]
  ret i32 %common.ret.op

entry.if:                                         ; preds = %entry
  store ptr @.const.picklebuf.139f67d5de86be05fe0cddb987e10981a96b3959, ptr %excinfo, align 8, !numba_exception_output !1
  br label %common.ret

B0.endif.thread:                                  ; preds = %B0
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.if

B0.endif:                                         ; preds = %B0
  %.43 = tail call ptr @PyList_GetItem(ptr nonnull %.37, i64 0)
  %.49 = icmp eq ptr %.43, null
  br i1 %.49, label %B0.endif.if, label %B0.endif.endif, !prof !2

B0.endif.if:                                      ; preds = %B0.endif.thread, %B0.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr %arg.hstate)
  br label %common.ret

B0.endif.endif:                                   ; preds = %B0.endif
  tail call void @Py_IncRef(ptr nonnull %.43)
  %.57 = tail call ptr @PyDict_GetItem(ptr %.35, ptr nonnull %.43)
  tail call void @Py_IncRef(ptr %.57)
  %.59 = icmp eq ptr %.57, null
  br i1 %.59, label %B0.endif.endif.if, label %B0.endif.endif.endif

B0.endif.endif.if:                                ; preds = %B0.endif.endif
  %sunkaddr = getelementptr i8, ptr %.6, i64 24
  %.62 = load ptr, ptr %sunkaddr, align 8
  %.66.not = icmp eq ptr %.62, null
  br i1 %.66.not, label %B0.endif.endif.if.endif.thread, label %B0.endif.endif.if.endif

B0.endif.endif.endif:                             ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif, %B0.endif.endif.if.endif.endif.endif.endif, %B0.endif.endif
  %.141 = phi ptr [ %.57, %B0.endif.endif ], [ %.104, %B0.endif.endif.if.endif.endif.endif.endif ], [ %.129, %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif ]
  %.145 = icmp eq ptr %arg.hstate, null
  br i1 %.145, label %B0.endif.endif.endif.if, label %B0.endif.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.thread:                   ; preds = %B0.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.if

B0.endif.endif.if.endif:                          ; preds = %B0.endif.endif.if
  %.68 = tail call ptr @PyList_GetItem(ptr nonnull %.62, i64 1)
  %.74 = icmp eq ptr %.68, null
  br i1 %.74, label %B0.endif.endif.if.endif.if, label %B0.endif.endif.if.endif.endif, !prof !2

B0.endif.endif.if.endif.if:                       ; preds = %B0.endif.endif.if.endif.thread, %B0.endif.endif.if.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr %arg.hstate)
  br label %common.ret

B0.endif.endif.if.endif.endif:                    ; preds = %B0.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.68)
  %.82 = tail call ptr @PyDict_GetItem(ptr %.35, ptr nonnull %.68)
  %sunkaddr1 = getelementptr i8, ptr %.6, i64 24
  %.84 = load ptr, ptr %sunkaddr1, align 8
  %.88.not = icmp eq ptr %.84, null
  br i1 %.88.not, label %B0.endif.endif.if.endif.endif.endif.thread, label %B0.endif.endif.if.endif.endif.endif

B0.endif.endif.if.endif.endif.endif.thread:       ; preds = %B0.endif.endif.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.endif.endif.if

B0.endif.endif.if.endif.endif.endif:              ; preds = %B0.endif.endif.if.endif.endif
  %.90 = tail call ptr @PyList_GetItem(ptr nonnull %.84, i64 0)
  %.96 = icmp eq ptr %.90, null
  br i1 %.96, label %B0.endif.endif.if.endif.endif.endif.if, label %B0.endif.endif.if.endif.endif.endif.endif, !prof !2

B0.endif.endif.if.endif.endif.endif.if:           ; preds = %B0.endif.endif.if.endif.endif.endif.thread, %B0.endif.endif.if.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr %arg.hstate)
  br label %common.ret

B0.endif.endif.if.endif.endif.endif.endif:        ; preds = %B0.endif.endif.if.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.90)
  %.104 = tail call ptr @PyDict_GetItem(ptr %.82, ptr nonnull %.90)
  tail call void @Py_IncRef(ptr %.104)
  %.106 = icmp eq ptr %.104, null
  br i1 %.106, label %B0.endif.endif.if.endif.endif.endif.endif.if, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.endif.endif.endif.if:     ; preds = %B0.endif.endif.if.endif.endif.endif.endif
  %sunkaddr2 = getelementptr i8, ptr %.6, i64 24
  %.109 = load ptr, ptr %sunkaddr2, align 8
  %.113.not = icmp eq ptr %.109, null
  br i1 %.113.not, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif

B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if

B0.endif.endif.if.endif.endif.endif.endif.if.endif: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if
  %.115 = tail call ptr @PyList_GetItem(ptr nonnull %.109, i64 0)
  %.121 = icmp eq ptr %.115, null
  br i1 %.121, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.if, label %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif, !prof !2

B0.endif.endif.if.endif.endif.endif.endif.if.endif.if: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.thread, %B0.endif.endif.if.endif.endif.endif.endif.if.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr %arg.hstate)
  br label %common.ret

B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif: ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif
  tail call void @Py_IncRef(ptr nonnull %.115)
  %.129 = tail call ptr @PyObject_GetAttr(ptr %.82, ptr nonnull %.115)
  %.130 = icmp eq ptr %.129, null
  br i1 %.130, label %B0.endif.endif.if.endif.e...if, label %B0.endif.endif.endif, !prof !0

B0.endif.endif.if.endif.e...if:                   ; preds = %B0.endif.endif.if.endif.endif.endif.endif.if.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'min' is not defined")
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr %arg.hstate)
  br label %common.ret

B0.endif.endif.endif.if:                          ; preds = %B0.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name 'hstate' is not defined")
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endif:                       ; preds = %B0.endif.endif.endif
  %sunkaddr3 = getelementptr i8, ptr %.6, i64 24
  %.156 = load ptr, ptr %sunkaddr3, align 8
  %.160.not = icmp eq ptr %.156, null
  br i1 %.160.not, label %B0.endif.endif.endif.endif.endif.thread, label %B0.endif.endif.endif.endif.endif

B0.endif.endif.endif.endif.endif.thread:          ; preds = %B0.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endif.endif.if

B0.endif.endif.endif.endif.endif:                 ; preds = %B0.endif.endif.endif.endif
  %.162 = tail call ptr @PyList_GetItem(ptr nonnull %.156, i64 2)
  %.168 = icmp eq ptr %.162, null
  br i1 %.168, label %B0.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endif.endif.if:              ; preds = %B0.endif.endif.endif.endif.endif.thread, %B0.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif:           ; preds = %B0.endif.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.162)
  %.178 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.hstate, ptr nonnull %.162)
  %.179 = icmp eq ptr %.178, null
  br i1 %.179, label %B0.endif.endif.endif.endif.endif.endif.if, label %B0.endif.endif.endif.endif.endif.endif.endif.endif, !prof !0

B0.endif.endif.endif.endif.endif.endif.if:        ; preds = %B0.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif
  %sunkaddr4 = getelementptr i8, ptr %.6, i64 24
  %.204 = load ptr, ptr %sunkaddr4, align 8
  %.208.not = icmp eq ptr %.204, null
  br i1 %.208.not, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif.thread, label %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif

B0.endif.endif.endif.endif.endif.endif.endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...if

B0.endif.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif
  %.210 = tail call ptr @PyList_GetItem(ptr nonnull %.204, i64 3)
  %.216 = icmp eq ptr %.210, null
  br i1 %.216, label %B0.endif.endif.endif.endi...if, label %B0.endif.endif.endif.endi...endif, !prof !2

B0.endif.endif.endif.endi...if:                   ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif.thread, %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.178)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif:                ; preds = %B0.endif.endif.endif.endif.endif.endif.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.210)
  %.228 = tail call ptr @PyObject_GetAttr(ptr nonnull %.178, ptr nonnull %.210)
  %.229 = icmp eq ptr %.228, null
  br i1 %.229, label %B0.endif.endif.endif.endi...endif.if, label %B0.endif.endif.endif.endi...endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.if:             ; preds = %B0.endif.endif.endif.endi...endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.178)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.endif:          ; preds = %B0.endif.endif.endif.endi...endif
  tail call void @Py_DecRef(ptr nonnull %.178)
  %sunkaddr5 = getelementptr i8, ptr %.6, i64 16
  %.246 = load ptr, ptr %sunkaddr5, align 8
  %sunkaddr6 = getelementptr i8, ptr %.6, i64 24
  %.248 = load ptr, ptr %sunkaddr6, align 8
  %.252.not = icmp eq ptr %.248, null
  br i1 %.252.not, label %B0.endif.endif.endif.endi...endif.endif.endif.thread, label %B0.endif.endif.endif.endi...endif.endif.endif

B0.endif.endif.endif.endi...endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endi...endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...endif.endif.endif.if

B0.endif.endif.endif.endi...endif.endif.endif:    ; preds = %B0.endif.endif.endif.endi...endif.endif
  %.254 = tail call ptr @PyList_GetItem(ptr nonnull %.248, i64 4)
  %.260 = icmp eq ptr %.254, null
  br i1 %.260, label %B0.endif.endif.endif.endi...endif.endif.endif.if, label %B0.endif.endif.endif.endi...endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endi...endif.endif.endif.if: ; preds = %B0.endif.endif.endif.endi...endif.endif.endif.thread, %B0.endif.endif.endif.endi...endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.254)
  %.272 = tail call ptr @PyDict_GetItem(ptr %.246, ptr nonnull %.254)
  tail call void @Py_IncRef(ptr %.272)
  %.274 = icmp eq ptr %.272, null
  br i1 %.274, label %B0.endif.endif.endif.endi...if.1, label %B0.endif.endif.endif.endi...endif.1

B0.endif.endif.endif.endi...if.1:                 ; preds = %B0.endif.endif.endif.endi...endif.endif.endif.endif
  %sunkaddr7 = getelementptr i8, ptr %.6, i64 24
  %.277 = load ptr, ptr %sunkaddr7, align 8
  %.281.not = icmp eq ptr %.277, null
  br i1 %.281.not, label %B0.endif.endif.endif.endi...if.1.endif.thread, label %B0.endif.endif.endif.endi...if.1.endif

B0.endif.endif.endif.endi...endif.1:              ; preds = %B0.endif.endif.endif.endi...if.2.endif.endif, %B0.endif.endif.endif.endi...if.1.endif.endif.endif.endif, %B0.endif.endif.endif.endi...endif.endif.endif.endif
  %.372 = phi ptr [ %.272, %B0.endif.endif.endif.endi...endif.endif.endif.endif ], [ %.327, %B0.endif.endif.endif.endi...if.1.endif.endif.endif.endif ], [ %.356, %B0.endif.endif.endif.endi...if.2.endif.endif ]
  %sunkaddr8 = getelementptr i8, ptr %.6, i64 24
  %.376 = load ptr, ptr %sunkaddr8, align 8
  %.380.not = icmp eq ptr %.376, null
  br i1 %.380.not, label %B0.endif.endif.endif.endi...endif.1.endif.thread, label %B0.endif.endif.endif.endi...endif.1.endif

B0.endif.endif.endif.endi...if.1.endif.thread:    ; preds = %B0.endif.endif.endif.endi...if.1
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...if.1.endif.if

B0.endif.endif.endif.endi...if.1.endif:           ; preds = %B0.endif.endif.endif.endi...if.1
  %.283 = tail call ptr @PyList_GetItem(ptr nonnull %.277, i64 1)
  %.289 = icmp eq ptr %.283, null
  br i1 %.289, label %B0.endif.endif.endif.endi...if.1.endif.if, label %B0.endif.endif.endif.endi...if.1.endif.endif, !prof !2

B0.endif.endif.endif.endi...if.1.endif.if:        ; preds = %B0.endif.endif.endif.endi...if.1.endif.thread, %B0.endif.endif.endif.endi...if.1.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...if.1.endif.endif:     ; preds = %B0.endif.endif.endif.endi...if.1.endif
  tail call void @Py_IncRef(ptr nonnull %.283)
  %.301 = tail call ptr @PyDict_GetItem(ptr %.246, ptr nonnull %.283)
  %sunkaddr9 = getelementptr i8, ptr %.6, i64 24
  %.303 = load ptr, ptr %sunkaddr9, align 8
  %.307.not = icmp eq ptr %.303, null
  br i1 %.307.not, label %B0.endif.endif.endif.endi...if.1.endif.endif.endif.thread, label %B0.endif.endif.endif.endi...if.1.endif.endif.endif

B0.endif.endif.endif.endi...if.1.endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endi...if.1.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...if.1.endif.endif.endif.if

B0.endif.endif.endif.endi...if.1.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...if.1.endif.endif
  %.309 = tail call ptr @PyList_GetItem(ptr nonnull %.303, i64 4)
  %.315 = icmp eq ptr %.309, null
  br i1 %.315, label %B0.endif.endif.endif.endi...if.1.endif.endif.endif.if, label %B0.endif.endif.endif.endi...if.1.endif.endif.endif.endif, !prof !2

B0.endif.endif.endif.endi...if.1.endif.endif.endif.if: ; preds = %B0.endif.endif.endif.endi...if.1.endif.endif.endif.thread, %B0.endif.endif.endif.endi...if.1.endif.endif.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...if.1.endif.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...if.1.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.309)
  %.327 = tail call ptr @PyDict_GetItem(ptr %.301, ptr nonnull %.309)
  tail call void @Py_IncRef(ptr %.327)
  %.329 = icmp eq ptr %.327, null
  br i1 %.329, label %B0.endif.endif.endif.endi...if.2, label %B0.endif.endif.endif.endi...endif.1, !prof !0

B0.endif.endif.endif.endi...if.2:                 ; preds = %B0.endif.endif.endif.endi...if.1.endif.endif.endif.endif
  %sunkaddr10 = getelementptr i8, ptr %.6, i64 24
  %.332 = load ptr, ptr %sunkaddr10, align 8
  %.336.not = icmp eq ptr %.332, null
  br i1 %.336.not, label %B0.endif.endif.endif.endi...if.2.endif.thread, label %B0.endif.endif.endif.endi...if.2.endif

B0.endif.endif.endif.endi...if.2.endif.thread:    ; preds = %B0.endif.endif.endif.endi...if.2
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...if.2.endif.if

B0.endif.endif.endif.endi...if.2.endif:           ; preds = %B0.endif.endif.endif.endi...if.2
  %.338 = tail call ptr @PyList_GetItem(ptr nonnull %.332, i64 4)
  %.344 = icmp eq ptr %.338, null
  br i1 %.344, label %B0.endif.endif.endif.endi...if.2.endif.if, label %B0.endif.endif.endif.endi...if.2.endif.endif, !prof !2

B0.endif.endif.endif.endi...if.2.endif.if:        ; preds = %B0.endif.endif.endif.endi...if.2.endif.thread, %B0.endif.endif.endif.endi...if.2.endif
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...if.2.endif.endif:     ; preds = %B0.endif.endif.endif.endi...if.2.endif
  tail call void @Py_IncRef(ptr nonnull %.338)
  %.356 = tail call ptr @PyObject_GetAttr(ptr %.301, ptr nonnull %.338)
  %.357 = icmp eq ptr %.356, null
  br i1 %.357, label %B0.endif.endif.endif.endi...if.2.endif.endif.if, label %B0.endif.endif.endif.endi...endif.1, !prof !0

B0.endif.endif.endif.endi...if.2.endif.endif.if:  ; preds = %B0.endif.endif.endif.endi...if.2.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.global name 'max' is not defined")
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.1.endif.thread: ; preds = %B0.endif.endif.endif.endi...endif.1
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...endif.1.endif.if

B0.endif.endif.endif.endi...endif.1.endif:        ; preds = %B0.endif.endif.endif.endi...endif.1
  %.382 = tail call ptr @PyList_GetItem(ptr nonnull %.376, i64 5)
  %.388 = icmp eq ptr %.382, null
  br i1 %.388, label %B0.endif.endif.endif.endi...endif.1.endif.if, label %B0.endif.endif.endif.endi...endif.1.endif.endif.endif, !prof !2

B0.endif.endif.endif.endi...endif.1.endif.if:     ; preds = %B0.endif.endif.endif.endi...endif.1.endif.thread, %B0.endif.endif.endif.endi...endif.1.endif
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.1.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.1.endif
  tail call void @Py_IncRef(ptr nonnull %.382)
  %sunkaddr11 = getelementptr i8, ptr %.6, i64 24
  %.422 = load ptr, ptr %sunkaddr11, align 8
  %.426.not = icmp eq ptr %.422, null
  br i1 %.426.not, label %B0.endif.endif.endif.endi...endif.3.thread, label %B0.endif.endif.endif.endi...endif.3

B0.endif.endif.endif.endi...endif.3.thread:       ; preds = %B0.endif.endif.endif.endi...endif.1.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...endif.3.if

B0.endif.endif.endif.endi...endif.3:              ; preds = %B0.endif.endif.endif.endi...endif.1.endif.endif.endif
  %.428 = tail call ptr @PyList_GetItem(ptr nonnull %.422, i64 6)
  %.434 = icmp eq ptr %.428, null
  br i1 %.434, label %B0.endif.endif.endif.endi...endif.3.if, label %B0.endif.endif.endif.endi...endif.3.endif, !prof !2

B0.endif.endif.endif.endi...endif.3.if:           ; preds = %B0.endif.endif.endif.endi...endif.3.thread, %B0.endif.endif.endif.endi...endif.3
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.3.endif:        ; preds = %B0.endif.endif.endif.endi...endif.3
  tail call void @Py_IncRef(ptr nonnull %.428)
  %.450 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.hstate, ptr nonnull %.428)
  %.451 = icmp eq ptr %.450, null
  br i1 %.451, label %B0.endif.endif.endif.endi...endif.3.endif.if, label %B0.endif.endif.endif.endi...endif.3.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.3.endif.if:     ; preds = %B0.endif.endif.endif.endi...endif.3.endif
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.3.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.3.endif
  %.488 = icmp eq ptr %arg.change, null
  br i1 %.488, label %B0.endif.endif.endif.endi...if.4, label %B0.endif.endif.endif.endi...endif.4, !prof !0

B0.endif.endif.endif.endi...if.4:                 ; preds = %B0.endif.endif.endif.endi...endif.3.endif.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_NameError, ptr nonnull @".const.name 'change' is not defined")
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr null)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.450)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.4:              ; preds = %B0.endif.endif.endif.endi...endif.3.endif.endif.endif
  %.506 = tail call ptr @PyNumber_Add(ptr nonnull %.450, ptr nonnull %arg.change)
  %.507 = icmp eq ptr %.506, null
  br i1 %.507, label %B0.endif.endif.endif.endi...endif.4.if, label %B0.endif.endif.endif.endi...endif.4.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.4.if:           ; preds = %B0.endif.endif.endif.endi...endif.4
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr nonnull %arg.change)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.450)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.4.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.4
  tail call void @Py_DecRef(ptr nonnull %arg.change)
  tail call void @Py_DecRef(ptr nonnull %.450)
  %.583 = tail call ptr (i64, ...) @PyTuple_Pack(i64 2, ptr nonnull %.382, ptr nonnull %.506)
  %.584 = tail call ptr @PyObject_Call(ptr nonnull %.372, ptr %.583, ptr null)
  tail call void @Py_DecRef(ptr %.583)
  %.586 = icmp eq ptr %.584, null
  br i1 %.586, label %B0.endif.endif.endif.endi...endif.5.if, label %B0.endif.endif.endif.endi...endif.5.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.5.if:           ; preds = %B0.endif.endif.endif.endi...endif.4.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.372)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.506)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.5.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.4.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.382)
  tail call void @Py_DecRef(ptr nonnull %.506)
  tail call void @Py_DecRef(ptr nonnull %.372)
  %.651 = tail call ptr (i64, ...) @PyTuple_Pack(i64 2, ptr nonnull %.228, ptr nonnull %.584)
  %.652 = tail call ptr @PyObject_Call(ptr nonnull %.141, ptr %.651, ptr null)
  tail call void @Py_DecRef(ptr %.651)
  %.654 = icmp eq ptr %.652, null
  br i1 %.654, label %B0.endif.endif.endif.endi...endif.6.if, label %B0.endif.endif.endif.endi...endif.6.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.6.if:           ; preds = %B0.endif.endif.endif.endi...endif.5.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.584)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.141)
  br label %common.ret

B0.endif.endif.endif.endi...endif.6.endif.endif:  ; preds = %B0.endif.endif.endif.endi...endif.5.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.141)
  tail call void @Py_DecRef(ptr nonnull %.228)
  tail call void @Py_DecRef(ptr nonnull %.584)
  %sunkaddr12 = getelementptr i8, ptr %.6, i64 24
  %.686 = load ptr, ptr %sunkaddr12, align 8
  %.690.not = icmp eq ptr %.686, null
  br i1 %.690.not, label %B0.endif.endif.endif.endi...endif.6.endif.endif.endif.thread, label %B0.endif.endif.endif.endi...endif.6.endif.endif.endif

B0.endif.endif.endif.endi...endif.6.endif.endif.endif.thread: ; preds = %B0.endif.endif.endif.endi...endif.6.endif.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...if.7

B0.endif.endif.endif.endi...endif.6.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.6.endif.endif
  %.692 = tail call ptr @PyList_GetItem(ptr nonnull %.686, i64 7)
  %.698 = icmp eq ptr %.692, null
  br i1 %.698, label %B0.endif.endif.endif.endi...if.7, label %B0.endif.endif.endif.endi...endif.7, !prof !2

B0.endif.endif.endif.endi...if.7:                 ; preds = %B0.endif.endif.endif.endi...endif.6.endif.endif.endif.thread, %B0.endif.endif.endif.endi...endif.6.endif.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.652)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  br label %common.ret

B0.endif.endif.endif.endi...endif.7:              ; preds = %B0.endif.endif.endif.endi...endif.6.endif.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.692)
  %.706 = tail call ptr @PyObject_GetAttr(ptr nonnull %arg.hstate, ptr nonnull %.692)
  %.707 = icmp eq ptr %.706, null
  br i1 %.707, label %B0.endif.endif.endif.endi...endif.7.if, label %B0.endif.endif.endif.endi...endif.7.endif, !prof !0

B0.endif.endif.endif.endi...endif.7.if:           ; preds = %B0.endif.endif.endif.endi...endif.7
  tail call void @Py_DecRef(ptr nonnull %.652)
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  br label %common.ret

B0.endif.endif.endif.endi...endif.7.endif:        ; preds = %B0.endif.endif.endif.endi...endif.7
  tail call void @Py_DecRef(ptr nonnull %arg.hstate)
  %sunkaddr13 = getelementptr i8, ptr %.6, i64 24
  %.720 = load ptr, ptr %sunkaddr13, align 8
  %.724.not = icmp eq ptr %.720, null
  br i1 %.724.not, label %B0.endif.endif.endif.endi...endif.7.endif.endif.thread, label %B0.endif.endif.endif.endi...endif.7.endif.endif

B0.endif.endif.endif.endi...endif.7.endif.endif.thread: ; preds = %B0.endif.endif.endif.endi...endif.7.endif
  tail call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.`env.consts` is NULL in `read_const`")
  br label %B0.endif.endif.endif.endi...endif.7.endif.endif.if

B0.endif.endif.endif.endi...endif.7.endif.endif:  ; preds = %B0.endif.endif.endif.endi...endif.7.endif
  %.726 = tail call ptr @PyList_GetItem(ptr nonnull %.720, i64 6)
  %.732 = icmp eq ptr %.726, null
  br i1 %.732, label %B0.endif.endif.endif.endi...endif.7.endif.endif.if, label %B0.endif.endif.endif.endi...endif.8, !prof !2

B0.endif.endif.endif.endi...endif.7.endif.endif.if: ; preds = %B0.endif.endif.endif.endi...endif.7.endif.endif.thread, %B0.endif.endif.endif.endi...endif.7.endif.endif
  tail call void @Py_DecRef(ptr nonnull %.652)
  tail call void @Py_DecRef(ptr nonnull %.706)
  br label %common.ret

B0.endif.endif.endif.endi...endif.8:              ; preds = %B0.endif.endif.endif.endi...endif.7.endif.endif
  tail call void @Py_IncRef(ptr nonnull %.726)
  %.753 = tail call ptr (i64, ...) @PyTuple_Pack(i64 1, ptr nonnull %.726)
  %.754 = icmp eq ptr %.753, null
  br i1 %.754, label %B0.endif.endif.endif.endi...endif.8.if, label %B0.endif.endif.endif.endi...endif.8.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.8.if:           ; preds = %B0.endif.endif.endif.endi...endif.8
  tail call void @Py_DecRef(ptr nonnull %.652)
  tail call void @Py_DecRef(ptr nonnull %.726)
  tail call void @Py_DecRef(ptr nonnull %.706)
  br label %common.ret

B0.endif.endif.endif.endi...endif.8.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.8
  tail call void @Py_DecRef(ptr nonnull %.726)
  tail call void @Py_DecRef(ptr nonnull %.753)
  %.780 = tail call ptr (i64, ...) @PyTuple_Pack(i64 0)
  %.790 = tail call ptr @PyDict_New()
  %.791.not = icmp eq ptr %.790, null
  br i1 %.791.not, label %B0.endif.endif.endif.endi...endif.9, label %B0.endif.endif.endif.endi...if.9, !prof !0

B0.endif.endif.endif.endi...if.9:                 ; preds = %B0.endif.endif.endif.endi...endif.8.endif.endif.endif
  %.793 = tail call i32 @PyDict_SetItemString(ptr nonnull %.790, ptr nonnull @.const.hp, ptr nonnull %.652)
  br label %B0.endif.endif.endif.endi...endif.9

B0.endif.endif.endif.endi...endif.9:              ; preds = %B0.endif.endif.endif.endi...if.9, %B0.endif.endif.endif.endi...endif.8.endif.endif.endif
  %.795 = tail call ptr @PyObject_Call(ptr nonnull %.706, ptr %.780, ptr %.790)
  tail call void @Py_DecRef(ptr %.790)
  tail call void @Py_DecRef(ptr %.780)
  %.798 = icmp eq ptr %.795, null
  tail call void @Py_DecRef(ptr nonnull %.652)
  tail call void @Py_DecRef(ptr nonnull %.706)
  br i1 %.798, label %common.ret, label %B0.endif.endif.endif.endi...endif.9.endif.endif.endif, !prof !0

B0.endif.endif.endif.endi...endif.9.endif.endif.endif: ; preds = %B0.endif.endif.endif.endi...endif.9
  tail call void @Py_IncRef(ptr nonnull %.795)
  tail call void @Py_DecRef(ptr nonnull %.795)
  store ptr %.795, ptr %retptr, align 8
  br label %common.ret
}

declare void @Py_IncRef(ptr) local_unnamed_addr

declare void @PyErr_SetString(ptr, ptr) local_unnamed_addr

declare ptr @PyList_GetItem(ptr, i64) local_unnamed_addr

declare void @Py_DecRef(ptr) local_unnamed_addr

declare ptr @PyDict_GetItem(ptr, ptr) local_unnamed_addr

declare ptr @PyObject_GetAttr(ptr, ptr) local_unnamed_addr

declare ptr @PyNumber_Add(ptr, ptr) local_unnamed_addr

declare ptr @PyTuple_Pack(i64, ...) local_unnamed_addr

declare ptr @PyObject_Call(ptr, ptr, ptr) local_unnamed_addr

declare ptr @PyDict_New() local_unnamed_addr

declare i32 @PyDict_SetItemString(ptr, ptr, ptr) local_unnamed_addr

define ptr @_ZN7cpython9prototype11mixed_callsB2v8E8pyobject8pyobject(ptr readnone captures(none) %py_closure, ptr %py_args, ptr readnone captures(none) %py_kws) local_unnamed_addr {
entry:
  %.5 = alloca ptr, align 8
  %.6 = alloca ptr, align 8
  %.7 = call i32 (ptr, ptr, i64, i64, ...) @PyArg_UnpackTuple(ptr %py_args, ptr nonnull @.const.mixed_calls, i64 2, i64 2, ptr nonnull %.5, ptr nonnull %.6)
  %.8 = icmp eq i32 %.7, 0
  %.27 = alloca ptr, align 8
  %excinfo = alloca ptr, align 8
  store ptr null, ptr %excinfo, align 8
  br i1 %.8, label %common.ret, label %entry.endif, !prof !0

common.ret:                                       ; preds = %entry.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.endif.endif.endif, %entry.endif.endif.endif.endif.endif.if.endif.if, %entry.endif.endif.endif.endif.endif.if.endif, %entry, %entry.endif.endif.endif.endif.endif.if.if.if, %entry.endif.if
  %common.ret.op = phi ptr [ null, %entry.endif.endif.endif.endif.endif.if.if.if ], [ null, %entry.endif.if ], [ null, %entry.endif.endif.endif.endif.endif.endif.endif.endif ], [ null, %entry ], [ %.41, %entry.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif ], [ null, %entry.endif.endif.endif.endif.endif.if.endif.if ]
  ret ptr %common.ret.op

entry.endif:                                      ; preds = %entry
  %.12 = load ptr, ptr @_ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject, align 8
  %.15 = icmp eq ptr %.12, null
  br i1 %.15, label %entry.endif.if, label %entry.endif.endif.endif.endif, !prof !0

entry.endif.if:                                   ; preds = %entry.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.missing Environment: _ZN08NumbaEnv9prototype11mixed_callsB2v8E8pyobject8pyobject")
  br label %common.ret

entry.endif.endif.endif.endif:                    ; preds = %entry.endif
  %.19 = load ptr, ptr %.5, align 8
  %.23 = load ptr, ptr %.6, align 8
  store ptr null, ptr %.27, align 8
  %.31 = call i32 @_ZN9prototype11mixed_callsB2v8E8pyobject8pyobject(ptr nonnull %.27, ptr nonnull %excinfo, ptr %.19, ptr %.23) #0
  %.32 = load ptr, ptr %excinfo, align 8
  %.41 = load ptr, ptr %.27, align 8
  %cond = icmp eq i32 %.31, 0
  br i1 %cond, label %common.ret, label %entry.endif.endif.endif.endif.endif, !prof !3

entry.endif.endif.endif.endif.endif:              ; preds = %entry.endif.endif.endif.endif
  %.39 = icmp sgt i32 %.31, 0
  br i1 %.39, label %entry.endif.endif.endif.endif.endif.if, label %entry.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.endif.if:           ; preds = %entry.endif.endif.endif.endif.endif
  call void @PyErr_Clear()
  %.50 = load { ptr, i32, ptr, ptr, i32 }, ptr %.32, align 8
  %.51 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 4
  %.52 = icmp sgt i32 %.51, 0
  %.55 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 0
  %.57 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 1
  br i1 %.52, label %entry.endif.endif.endif.endif.endif.if.if, label %entry.endif.endif.endif.endif.endif.if.else

entry.endif.endif.endif.endif.endif.endif:        ; preds = %entry.endif.endif.endif.endif.endif
  %cond1 = icmp eq i32 %.31, -1
  br i1 %cond1, label %common.ret, label %entry.endif.endif.endif.endif.endif.endif.endif.endif

entry.endif.endif.endif.endif.endif.if.if:        ; preds = %entry.endif.endif.endif.endif.endif.if
  %.58 = sext i32 %.57 to i64
  %.59 = call ptr @PyBytes_FromStringAndSize(ptr %.55, i64 %.58)
  %.60 = load { ptr, i32, ptr, ptr, i32 }, ptr %.32, align 8
  %.61 = extractvalue { ptr, i32, ptr, ptr, i32 } %.60, 2
  %.63 = extractvalue { ptr, i32, ptr, ptr, i32 } %.60, 3
  %.65 = call ptr %.63(ptr %.61)
  %.66 = icmp eq ptr %.65, null
  br i1 %.66, label %entry.endif.endif.endif.endif.endif.if.if.if, label %entry.endif.endif.endif.endif.endif.if.if.endif, !prof !0

entry.endif.endif.endif.endif.endif.if.else:      ; preds = %entry.endif.endif.endif.endif.endif.if
  %.79 = extractvalue { ptr, i32, ptr, ptr, i32 } %.50, 2
  %.80 = call ptr @numba_unpickle(ptr %.55, i32 %.57, ptr %.79)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif:     ; preds = %entry.endif.endif.endif.endif.endif.if.if.endif, %entry.endif.endif.endif.endif.endif.if.else
  %.82 = phi ptr [ %.70, %entry.endif.endif.endif.endif.endif.if.if.endif ], [ %.80, %entry.endif.endif.endif.endif.endif.if.else ]
  %.83.not = icmp eq ptr %.82, null
  br i1 %.83.not, label %common.ret, label %entry.endif.endif.endif.endif.endif.if.endif.if, !prof !0

entry.endif.endif.endif.endif.endif.if.if.if:     ; preds = %entry.endif.endif.endif.endif.endif.if.if
  call void @PyErr_SetString(ptr nonnull @PyExc_RuntimeError, ptr nonnull @".const.Error creating Python tuple from runtime exception arguments")
  br label %common.ret

entry.endif.endif.endif.endif.endif.if.if.endif:  ; preds = %entry.endif.endif.endif.endif.endif.if.if
  %.70 = call ptr @numba_runtime_build_excinfo_struct(ptr %.59, ptr nonnull %.65)
  call void @NRT_Free(ptr nonnull %.32)
  br label %entry.endif.endif.endif.endif.endif.if.endif

entry.endif.endif.endif.endif.endif.if.endif.if:  ; preds = %entry.endif.endif.endif.endif.endif.if.endif
  call void @numba_do_raise(ptr nonnull %.82)
  br label %common.ret

entry.endif.endif.endif.endif.endif.endif.endif.endif: ; preds = %entry.endif.endif.endif.endif.endif.endif
  call void @PyErr_SetString(ptr nonnull @PyExc_SystemError, ptr nonnull @".const.unknown error when calling native function")
  br label %common.ret
}

declare i32 @PyArg_UnpackTuple(ptr, ptr, i64, i64, ...) local_unnamed_addr

declare void @PyErr_Clear() local_unnamed_addr

declare ptr @PyBytes_FromStringAndSize(ptr, i64) local_unnamed_addr

declare ptr @numba_unpickle(ptr, i32, ptr) local_unnamed_addr

declare ptr @numba_runtime_build_excinfo_struct(ptr, ptr) local_unnamed_addr

declare void @NRT_Free(ptr) local_unnamed_addr

declare void @numba_do_raise(ptr) local_unnamed_addr

attributes #0 = { noinline }

!0 = !{!"branch_weights", i32 1, i32 99}
!1 = !{i1 true}
!2 = !{!"branch_weights", i32 0, i32 -2147483648}
!3 = !{!"branch_weights", i32 49, i32 1}
