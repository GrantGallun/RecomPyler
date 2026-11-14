	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.p2align	4
	.type	_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@function
_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd:
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
	subq	$152, %rsp
	vmovapd	%xmm7, 128(%rsp)
	vmovaps	%xmm6, 112(%rsp)
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -72
	.cfi_offset %rbp, -64
	.cfi_offset %rdi, -56
	.cfi_offset %rsi, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	.cfi_offset %xmm6, -112
	.cfi_offset %xmm7, -96
	vmovsd	288(%rsp), %xmm6
	movq	280(%rsp), %r13
	testq	%r13, %r13
	jle	.LBB0_1
	movq	264(%rsp), %r14
	cmpb	$0, (%r14)
	jne	.LBB0_3
	movq	256(%rsp), %rbx
	movq	8(%rbx), %rax
	leaq	1(%rax), %r10
	movq	%r10, 8(%rbx)
	cmpq	16(%rbx), %rax
	jge	.LBB0_7
	movq	272(%rsp), %rbp
	movq	%rdx, 72(%rsp)
	movq	%rcx, %r15
	leaq	-1(%r13), %rax
	movabsq	$_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, %r12
	leaq	88(%rsp), %rcx
	leaq	104(%rsp), %rdx
	vmovsd	%xmm6, 64(%rsp)
	movq	%r14, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%r8, %rdi
	movq	%r9, %rsi
	movq	%rax, 56(%rsp)
	movq	%rbp, 48(%rsp)
	callq	*%r12
	testl	%eax, %eax
	jne	.LBB0_15
	cmpb	$0, (%r14)
	je	.LBB0_8
.LBB0_13:
	movq	$0, (%r15)
	jmp	.LBB0_4
.LBB0_1:
	vmovsd	%xmm6, (%rcx)
	jmp	.LBB0_4
.LBB0_7:
	movb	$1, (%r14)
	movq	$4, 24(%rbx)
.LBB0_3:
	movq	$0, (%rcx)
.LBB0_4:
	xorl	%eax, %eax
.LBB0_5:
	vmovaps	112(%rsp), %xmm6
	vmovaps	128(%rsp), %xmm7
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB0_8:
	movq	8(%rbx), %rcx
	vmovsd	88(%rsp), %xmm7
	leaq	-1(%rcx), %rax
	movq	%rax, 8(%rbx)
	movq	%r15, %rax
	cmpb	$0, (%r14)
	je	.LBB0_10
	movq	$0, (%rax)
	jmp	.LBB0_4
.LBB0_10:
	movq	%rcx, 8(%rbx)
	cmpq	16(%rbx), %rcx
	jle	.LBB0_16
	movb	$1, (%r14)
	movq	$4, 24(%rbx)
	movq	$0, (%rax)
	jmp	.LBB0_4
.LBB0_16:
	addq	$-2, %r13
	leaq	80(%rsp), %rcx
	leaq	96(%rsp), %rdx
	vmovsd	%xmm6, 64(%rsp)
	movq	%rbp, 48(%rsp)
	movq	%r14, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%rdi, %r8
	movq	%rsi, %r9
	movq	%r13, 56(%rsp)
	callq	*%r12
	testl	%eax, %eax
	jne	.LBB0_15
	cmpb	$0, (%r14)
	jne	.LBB0_13
	vmovsd	80(%rsp), %xmm0
	decq	8(%rbx)
	vaddsd	%xmm0, %xmm7, %xmm0
	vmovsd	%xmm0, (%r15)
	jmp	.LBB0_4
.LBB0_15:
	movq	72(%rsp), %rcx
	movq	$0, (%rcx)
	jmp	.LBB0_5
.Lfunc_end0:
	.size	_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, .Lfunc_end0-_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.cfi_endproc

	.globl	_ZN7cpython26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.p2align	4
	.type	_ZN7cpython26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@function
_ZN7cpython26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd:
	.cfi_startproc
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	%rdx, %rcx
	leaq	104(%rsp), %r8
	leaq	112(%rsp), %rdx
	leaq	96(%rsp), %rax
	movl	$7, %r9d
	movq	%r8, 72(%rsp)
	movq	%rdx, 64(%rsp)
	leaq	120(%rsp), %r8
	leaq	128(%rsp), %rdx
	movq	%rax, 80(%rsp)
	movabsq	$PyArg_UnpackTuple, %rax
	movq	%r8, 56(%rsp)
	movq	%rdx, 48(%rsp)
	leaq	136(%rsp), %r8
	leaq	144(%rsp), %rdx
	movq	%r8, 40(%rsp)
	movq	%rdx, 32(%rsp)
	movabsq	$.const.f0_recursive_sum_borrowed, %rdx
	movl	$7, %r8d
	callq	*%rax
	testl	%eax, %eax
	je	.LBB1_4
	movabsq	$_ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, %rax
	cmpq	$0, (%rax)
	je	.LBB1_2
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox float64* type", %rdx
.LBB1_3:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_4:
	xorl	%eax, %eax
	addq	$152, %rsp
	retq
.LBB1_2:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd", %rdx
	jmp	.LBB1_3
.Lfunc_end1:
	.size	_ZN7cpython26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, .Lfunc_end1-_ZN7cpython26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.cfi_endproc

	.globl	cfunc._ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.p2align	4
	.type	cfunc._ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@function
cfunc._ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	subq	$120, %rsp
	vmovaps	%xmm6, 96(%rsp)
	.cfi_def_cfa_offset 144
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	.cfi_offset %xmm6, -48
	vmovsd	192(%rsp), %xmm1
	vmovaps	176(%rsp), %xmm0
	movq	%rdx, %rax
	movq	%rcx, %r10
	movabsq	$_ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, %r11
	leaq	88(%rsp), %rcx
	leaq	80(%rsp), %rdx
	movq	$0, 88(%rsp)
	movq	$0, 80(%rsp)
	vmovsd	%xmm1, 64(%rsp)
	vmovups	%xmm0, 48(%rsp)
	movq	%r9, 40(%rsp)
	movq	%r8, 32(%rsp)
	movq	%r10, %r8
	movq	%rax, %r9
	callq	*%r11
	vmovsd	88(%rsp), %xmm0
	movq	80(%rsp), %rsi
	movl	$0, 76(%rsp)
	testl	%eax, %eax
	jne	.LBB2_1
.LBB2_8:
	vmovaps	96(%rsp), %xmm6
	addq	$120, %rsp
	popq	%rdi
	popq	%rsi
	retq
.LBB2_1:
	movabsq	$numba_gil_ensure, %rdx
	leaq	76(%rsp), %rcx
	vmovaps	%xmm0, %xmm6
	movl	%eax, %edi
	callq	*%rdx
	testl	%edi, %edi
	jle	.LBB2_9
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
	movl	8(%rsi), %edx
	movq	(%rsi), %rcx
	cmpl	$0, 32(%rsi)
	jle	.LBB2_12
	movslq	%edx, %rdx
	movabsq	$PyBytes_FromStringAndSize, %rax
	callq	*%rax
	movq	16(%rsi), %rcx
	movq	%rax, %rdi
	callq	*24(%rsi)
	testq	%rax, %rax
	je	.LBB2_4
	movabsq	$numba_runtime_build_excinfo_struct, %r8
	movq	%rdi, %rcx
	movq	%rax, %rdx
	callq	*%r8
	movq	%rax, %rdi
	movabsq	$NRT_Free, %rax
	movq	%rsi, %rcx
	callq	*%rax
	jmp	.LBB2_13
.LBB2_9:
	movl	%edi, %eax
	cmpl	$-3, %edi
	je	.LBB2_5
	cmpl	$-1, %eax
	je	.LBB2_7
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB2_7
.LBB2_12:
	movq	16(%rsi), %r8
	movabsq	$numba_unpickle, %rax
	callq	*%rax
	movq	%rax, %rdi
.LBB2_13:
	testq	%rdi, %rdi
	je	.LBB2_7
	movabsq	$numba_do_raise, %rax
	movq	%rdi, %rcx
.LBB2_6:
	callq	*%rax
.LBB2_7:
	movabsq	$".const.<numba.core.cpu.CPUContext>", %rcx
	movabsq	$PyUnicode_FromString, %rax
	callq	*%rax
	movabsq	$PyErr_WriteUnraisable, %rdi
	movq	%rax, %rsi
	movq	%rsi, %rcx
	callq	*%rdi
	movabsq	$Py_DecRef, %rax
	movq	%rsi, %rcx
	callq	*%rax
	movabsq	$numba_gil_release, %rax
	leaq	76(%rsp), %rcx
	callq	*%rax
	vmovaps	%xmm6, %xmm0
	jmp	.LBB2_8
.LBB2_5:
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	jmp	.LBB2_6
.LBB2_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.Error creating Python tuple from runtime exception arguments", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	vxorps	%xmm0, %xmm0, %xmm0
	jmp	.LBB2_8
.Lfunc_end2:
	.size	cfunc._ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, .Lfunc_end2-cfunc._ZN26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.cfi_endproc

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
	movabsq	$NRT_MemInfo_call_dtor, %rax
	#MEMBARRIER
	rex64 jmpq	*%rax
.Lfunc_end3:
	.size	NRT_decref, .Lfunc_end3-NRT_decref
	.cfi_endproc

	.weak	_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.p2align	4
	.type	_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@function
_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd:
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
	subq	$152, %rsp
	vmovapd	%xmm8, 128(%rsp)
	vmovaps	%xmm7, 112(%rsp)
	vmovapd	%xmm6, 96(%rsp)
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -72
	.cfi_offset %rbp, -64
	.cfi_offset %rdi, -56
	.cfi_offset %rsi, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	.cfi_offset %xmm6, -128
	.cfi_offset %xmm7, -112
	.cfi_offset %xmm8, -96
	vmovsd	288(%rsp), %xmm7
	movq	280(%rsp), %r15
	testq	%r15, %r15
	jle	.LBB4_1
	movq	264(%rsp), %r14
	vxorpd	%xmm6, %xmm6, %xmm6
	cmpb	$0, (%r14)
	jne	.LBB4_2
	movq	256(%rsp), %rbx
	movq	8(%rbx), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, 8(%rbx)
	cmpq	16(%rbx), %rax
	jge	.LBB4_5
	movq	272(%rsp), %r13
	movq	%rcx, %r12
	leaq	-1(%r15), %rax
	movabsq	$_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, %rbp
	leaq	88(%rsp), %rcx
	vmovsd	%xmm7, 64(%rsp)
	movq	%r14, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%r8, %rdi
	movq	%r9, %rsi
	movq	%rax, 56(%rsp)
	movq	%r13, 48(%rsp)
	callq	*%rbp
	cmpb	$0, (%r14)
	je	.LBB4_6
	movq	%r12, %rcx
	jmp	.LBB4_2
.LBB4_1:
	vmovapd	%xmm7, %xmm6
	jmp	.LBB4_2
.LBB4_6:
	movq	8(%rbx), %rax
	vmovsd	88(%rsp), %xmm8
	leaq	-1(%rax), %rcx
	movq	%rcx, 8(%rbx)
	movq	%r12, %rcx
	cmpb	$0, (%r14)
	jne	.LBB4_2
	movq	%rax, 8(%rbx)
	cmpq	16(%rbx), %rax
	jle	.LBB4_8
.LBB4_5:
	movb	$1, (%r14)
	movq	$1000004, 24(%rbx)
.LBB4_2:
	vmovsd	%xmm6, (%rcx)
	vmovaps	96(%rsp), %xmm6
	vmovaps	112(%rsp), %xmm7
	vmovaps	128(%rsp), %xmm8
	xorl	%eax, %eax
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB4_8:
	addq	$-2, %r15
	leaq	80(%rsp), %rcx
	vmovsd	%xmm7, 64(%rsp)
	movq	%r13, 48(%rsp)
	movq	%r14, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%rdi, %r8
	movq	%rsi, %r9
	movq	%r15, 56(%rsp)
	callq	*%rbp
	cmpb	$0, (%r14)
	movq	%r12, %rcx
	jne	.LBB4_2
	vaddsd	80(%rsp), %xmm8, %xmm6
	decq	8(%rbx)
	jmp	.LBB4_2
.Lfunc_end4:
	.size	_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd, .Lfunc_end4-_ZN26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd
	.cfi_endproc

	.type	.const.f0_recursive_sum_borrowed,@object
	.section	.lrodata,"al",@progbits
	.p2align	4, 0x0
.const.f0_recursive_sum_borrowed:
	.asciz	"f0_recursive_sum_borrowed"
	.size	.const.f0_recursive_sum_borrowed, 26

	.type	_ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@object
	.comm	_ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd":
	.asciz	"missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd"
	.size	".const.missing Environment: _ZN08NumbaEnv26recompyler_generated_heap025f0_recursive_sum_borrowedB3v12B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd", 185

	.type	".const.can't unbox float64* type",@object
	.p2align	4, 0x0
".const.can't unbox float64* type":
	.asciz	"can't unbox float64* type"
	.size	".const.can't unbox float64* type", 26

	.type	".const.Error creating Python tuple from runtime exception arguments",@object
	.p2align	4, 0x0
".const.Error creating Python tuple from runtime exception arguments":
	.asciz	"Error creating Python tuple from runtime exception arguments"
	.size	".const.Error creating Python tuple from runtime exception arguments", 61

	.type	".const.unknown error when calling native function",@object
	.p2align	4, 0x0
".const.unknown error when calling native function":
	.asciz	"unknown error when calling native function"
	.size	".const.unknown error when calling native function", 43

	.type	".const.<numba.core.cpu.CPUContext>",@object
	.p2align	4, 0x0
".const.<numba.core.cpu.CPUContext>":
	.asciz	"<numba.core.cpu.CPUContext>"
	.size	".const.<numba.core.cpu.CPUContext>", 28

	.type	_ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,@object
	.comm	_ZN08NumbaEnv26recompyler_generated_heap025f1_recursive_sum_borrowedB3v17B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE10float64_2a8int64_2a8int64_2a8uint8_2axxd,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE10float64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE10float64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8int64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8int64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8uint8_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B54c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAw4hWqFpgsIBZmgA_3dE8uint8_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v16B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_281_29,@object
	.comm	_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v16B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_281_29,8,8
	.type	_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v18B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_282_29,@object
	.comm	_ZN08NumbaEnv26recompyler_generated_heap05sub_iB3v18B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedEx23Literal_5bint_5d_282_29,8,8
	.section	".note.GNU-stack","",@progbits
