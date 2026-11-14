	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
	movq	272(%rsp), %rdx
	movq	248(%rsp), %rax
	testq	%rdx, %rdx
	jle	.LBB0_3
	movq	264(%rsp), %r8
	movq	256(%rsp), %r9
	incq	%rdx
	.p2align	4
.LBB0_2:
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	imulq	%r9, %rax
	addq	%r8, %rax
	decq	%rdx
	cmpq	$1, %rdx
	ja	.LBB0_2
.LBB0_3:
	movq	%rax, (%rcx)
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end0-_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

	.globl	_ZN7cpython32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	_ZN7cpython32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
_ZN7cpython32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rsi
	.cfi_def_cfa_offset 48
	pushq	%rdi
	.cfi_def_cfa_offset 56
	pushq	%rbp
	.cfi_def_cfa_offset 64
	pushq	%rbx
	.cfi_def_cfa_offset 72
	subq	$632, %rsp
	.cfi_def_cfa_offset 704
	.cfi_offset %rbx, -72
	.cfi_offset %rbp, -64
	.cfi_offset %rdi, -56
	.cfi_offset %rsi, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rcx
	leaq	320(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	328(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	336(%rsp), %rax
	movq	%rax, 72(%rsp)
	leaq	344(%rsp), %rax
	movq	%rax, 64(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	360(%rsp), %rax
	movq	%rax, 48(%rsp)
	leaq	368(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	376(%rsp), %rax
	movq	%rax, 32(%rsp)
	movabsq	$.const.f0_loop_recurrence16, %rdx
	movabsq	$PyArg_UnpackTuple, %rax
	movl	$8, %r8d
	movl	$8, %r9d
	callq	*%rax
	movq	$0, 280(%rsp)
	testl	%eax, %eax
	je	.LBB1_1
	movabsq	$_ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
	cmpq	$0, (%rax)
	je	.LBB1_4
	movq	376(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 576(%rsp)
	movaps	%xmm0, 592(%rsp)
	movaps	%xmm0, 608(%rsp)
	movq	$0, 624(%rsp)
	movabsq	$NRT_adapt_ndarray_from_python, %rsi
	leaq	576(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_8
	cmpq	$8, 600(%rsp)
	jne	.LBB1_8
	movq	576(%rsp), %r14
	movq	368(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 512(%rsp)
	movaps	%xmm0, 528(%rsp)
	movaps	%xmm0, 544(%rsp)
	movq	$0, 560(%rsp)
	leaq	512(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_11
	cmpq	$8, 536(%rsp)
	jne	.LBB1_11
	movq	512(%rsp), %r15
	movq	360(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 448(%rsp)
	movaps	%xmm0, 464(%rsp)
	movaps	%xmm0, 480(%rsp)
	movq	$0, 496(%rsp)
	leaq	448(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_14
	cmpq	$8, 472(%rsp)
	jne	.LBB1_14
	movq	448(%rsp), %r13
	movq	352(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 384(%rsp)
	movaps	%xmm0, 400(%rsp)
	movaps	%xmm0, 416(%rsp)
	movq	$0, 432(%rsp)
	leaq	384(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_19
	cmpq	$1, 408(%rsp)
	jne	.LBB1_19
	movq	384(%rsp), %rbp
	movq	344(%rsp), %rcx
	movabsq	$PyNumber_Long, %rsi
	callq	*%rsi
	movabsq	$PyLong_AsLongLong, %rbx
	movabsq	$Py_DecRef, %rdi
	testq	%rax, %rax
	movq	%r14, 312(%rsp)
	movq	%r15, 304(%rsp)
	movq	%r13, 296(%rsp)
	movq	%rbp, 288(%rsp)
	je	.LBB1_21
	movq	%rax, %r12
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r15
	movq	%r12, %rcx
	callq	*%rdi
	movabsq	$PyErr_Occurred, %r14
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_26:
	movq	336(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_27
	movq	%rax, %r13
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r12
	movq	%r13, %rcx
	callq	*%rdi
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_30:
	movq	328(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_31
	movq	%rax, %rbp
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r13
	movq	%rbp, %rcx
	callq	*%rdi
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_34:
	movq	320(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_35
	movq	%rax, %rsi
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %rbp
	movq	%rsi, %rcx
	callq	*%rdi
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_22
.LBB1_38:
	movq	$0, 280(%rsp)
	movq	%rbp, 264(%rsp)
	movq	%r13, 256(%rsp)
	movq	%r12, 248(%rsp)
	movq	%r15, 240(%rsp)
	movabsq	$_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
	leaq	280(%rsp), %rcx
	callq	*%rax
	movq	280(%rsp), %rsi
	movabsq	$NRT_decref, %rdi
	movq	312(%rsp), %rcx
	callq	*%rdi
	movq	304(%rsp), %rcx
	callq	*%rdi
	movq	296(%rsp), %rcx
	callq	*%rdi
	movq	288(%rsp), %rcx
	callq	*%rdi
	movabsq	$PyLong_FromLongLong, %rax
	movq	%rsi, %rcx
	callq	*%rax
.LBB1_2:
	addq	$632, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx", %rdx
	jmp	.LBB1_5
.LBB1_8:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
.LBB1_5:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_1
.LBB1_11:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_16
.LBB1_14:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_15
.LBB1_19:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_23
.LBB1_21:
	xorl	%r15d, %r15d
	movabsq	$PyErr_Occurred, %r14
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_26
	jmp	.LBB1_22
.LBB1_27:
	xorl	%r12d, %r12d
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_30
	jmp	.LBB1_22
.LBB1_31:
	xorl	%r13d, %r13d
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_34
	jmp	.LBB1_22
.LBB1_35:
	xorl	%ebp, %ebp
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_38
.LBB1_22:
	movabsq	$NRT_decref, %rax
	movq	288(%rsp), %rcx
	callq	*%rax
	movq	312(%rsp), %r14
	movq	304(%rsp), %r15
	movq	296(%rsp), %r13
.LBB1_23:
	movabsq	$NRT_decref, %rax
	movq	%r13, %rcx
	callq	*%rax
.LBB1_15:
	movabsq	$NRT_decref, %rax
	movq	%r15, %rcx
	callq	*%rax
.LBB1_16:
	movabsq	$NRT_decref, %rax
	movq	%r14, %rcx
	callq	*%rax
.LBB1_1:
	xorl	%eax, %eax
	jmp	.LBB1_2
.Lfunc_end1:
	.size	_ZN7cpython32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end1-_ZN7cpython32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.cfi_endproc

	.globl	cfunc._ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	cfunc._ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
cfunc._ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
	subq	$280, %rsp
	movaps	512(%rsp), %xmm0
	movaps	528(%rsp), %xmm1
	movq	$0, 272(%rsp)
	movups	%xmm1, 256(%rsp)
	movups	%xmm0, 240(%rsp)
	movabsq	$_ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
	leaq	272(%rsp), %rcx
	callq	*%rax
	movq	272(%rsp), %rax
	addq	$280, %rsp
	retq
.Lfunc_end2:
	.size	cfunc._ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end2-cfunc._ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

	.weak	NRT_decref
	.p2align	4
	.type	NRT_decref,@function
NRT_decref:
	.cfi_startproc
	testq	%rcx, %rcx
	je	.LBB3_2
	#MEMBARRIER
	lock		decq	(%rcx)
	je	.LBB3_3
.LBB3_2:
	retq
.LBB3_3:
	#MEMBARRIER
	movabsq	$NRT_MemInfo_call_dtor, %rax
	rex64 jmpq	*%rax
.Lfunc_end3:
	.size	NRT_decref, .Lfunc_end3-NRT_decref
	.cfi_endproc

	.type	.const.f0_loop_recurrence16,@object
	.section	.lrodata,"al",@progbits
	.p2align	4, 0x0
.const.f0_loop_recurrence16:
	.asciz	"f0_loop_recurrence16"
	.size	.const.f0_loop_recurrence16, 21

	.type	_ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@object
	.comm	_ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx":
	.asciz	"missing Environment: _ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx"
	.size	".const.missing Environment: _ZN08NumbaEnv32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx", 271

	.type	".const.can't unbox array from PyObject into native value.  The object maybe of a different type",@object
	.p2align	4, 0x0
".const.can't unbox array from PyObject into native value.  The object maybe of a different type":
	.asciz	"can't unbox array from PyObject into native value.  The object maybe of a different type"
	.size	".const.can't unbox array from PyObject into native value.  The object maybe of a different type", 89

	.section	".note.GNU-stack","",@progbits
