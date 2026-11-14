	.file	"<string>"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI0_0:
	.quad	0x7fffffffffffffff
	.quad	0x7fffffffffffffff
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI0_1:
	.quad	0x43dfeb3dd0676600
	.section	.ltext,"axl",@progbits
	.globl	_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
	pushq	%rsi
	movq	272(%rsp), %rax
	movq	264(%rsp), %rdx
	movq	256(%rsp), %r10
	movq	280(%rsp), %r8
	xorl	%r9d, %r9d
	testq	%r8, %r8
	cmovleq	%r9, %r8
	movq	232(%rsp), %r9
	cvtsi2sd	%rdx, %xmm0
	incq	%r8
	movabsq	$.LCPI0_0, %r11
	movapd	(%r11), %xmm1
	movabsq	$.LCPI0_1, %r11
	movsd	(%r11), %xmm2
.LBB0_1:
	decq	%r8
	testq	%r8, %r8
	jle	.LBB0_5
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	cmpb	$0, (%r9)
	jne	.LBB0_4
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r10, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r10
	leaq	(%r10,%rax), %r11
	xorq	%r11, %r10
	movq	%r11, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r10
	js	.LBB0_3
	xorps	%xmm3, %xmm3
	cvtsi2sd	%r11, %xmm3
	mulsd	%xmm0, %xmm3
	andpd	%xmm1, %xmm3
	ucomisd	%xmm2, %xmm3
	jae	.LBB0_3
	imulq	%rdx, %r11
	leaq	(%r11,%rax), %r10
	xorq	%r10, %r11
	movq	%r10, %rsi
	xorq	%rax, %rsi
	testq	%rsi, %r11
	jns	.LBB0_1
.LBB0_3:
	movb	$1, (%r9)
.LBB0_4:
	xorl	%r10d, %r10d
.LBB0_5:
	movq	%r10, (%rcx)
	xorl	%eax, %eax
	popq	%rsi
	retq
.Lfunc_end0:
	.size	_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end0-_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

	.globl	_ZN7cpython32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	_ZN7cpython32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
_ZN7cpython32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
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
	movq	$0, 272(%rsp)
	testl	%eax, %eax
	je	.LBB1_1
	movabsq	$_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
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
	movq	576(%rsp), %rdi
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
	jne	.LBB1_16
	cmpq	$8, 472(%rsp)
	jne	.LBB1_16
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
	movq	416(%rsp), %rax
	movq	%rax, 312(%rsp)
	movq	344(%rsp), %rcx
	movabsq	$PyNumber_Long, %rsi
	callq	*%rsi
	movabsq	$PyLong_AsLongLong, %r14
	movabsq	$Py_DecRef, %rbx
	testq	%rax, %rax
	movq	%rdi, 304(%rsp)
	movq	%r15, 296(%rsp)
	movq	%r13, 288(%rsp)
	movq	%rbp, 280(%rsp)
	je	.LBB1_23
	movq	%rax, %r12
	movq	%rax, %rcx
	callq	*%r14
	movq	%rax, %r15
	movq	%r12, %rcx
	callq	*%rbx
	movabsq	$PyErr_Occurred, %rdi
	callq	*%rdi
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_27:
	movq	336(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_28
	movq	%rax, %r13
	movq	%rax, %rcx
	callq	*%r14
	movq	%rax, %r12
	movq	%r13, %rcx
	callq	*%rbx
	callq	*%rdi
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_31:
	movq	328(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_32
	movq	%rax, %rbp
	movq	%rax, %rcx
	callq	*%r14
	movq	%rax, %r13
	movq	%rbp, %rcx
	callq	*%rbx
	callq	*%rdi
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_35:
	movq	320(%rsp), %rcx
	callq	*%rsi
	testq	%rax, %rax
	je	.LBB1_36
	movq	%rax, %rsi
	movq	%rax, %rcx
	callq	*%r14
	movq	%rax, %rbp
	movq	%rsi, %rcx
	callq	*%rbx
	callq	*%rdi
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_39:
	movq	$0, 272(%rsp)
	movq	%rbp, 264(%rsp)
	movq	%r13, 256(%rsp)
	movq	%r12, 248(%rsp)
	movq	%r15, 240(%rsp)
	movq	312(%rsp), %rax
	movq	%rax, 216(%rsp)
	movabsq	$_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
	leaq	272(%rsp), %rcx
	callq	*%rax
	movl	%eax, %ebp
	movq	272(%rsp), %r15
	movabsq	$NRT_decref, %rsi
	movq	304(%rsp), %rcx
	callq	*%rsi
	movq	296(%rsp), %rcx
	callq	*%rsi
	movq	288(%rsp), %rcx
	callq	*%rsi
	movq	280(%rsp), %rcx
	callq	*%rsi
	testl	%ebp, %ebp
	jne	.LBB1_40
	movabsq	$PyLong_FromLongLong, %rax
	movq	%r15, %rcx
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
.LBB1_40:
	jg	.LBB1_46
	cmpl	$-1, %ebp
	je	.LBB1_1
	cmpl	$-3, %ebp
	jne	.LBB1_44
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	callq	*%rax
	jmp	.LBB1_1
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx", %rdx
	jmp	.LBB1_5
.LBB1_8:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	jmp	.LBB1_5
.LBB1_11:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_12
.LBB1_16:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_21
.LBB1_19:
	movabsq	$PyExc_TypeError, %rcx
	movabsq	$".const.can't unbox array from PyObject into native value.  The object maybe of a different type", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_20
.LBB1_23:
	xorl	%r15d, %r15d
	movabsq	$PyErr_Occurred, %rdi
	callq	*%rdi
	testq	%rax, %rax
	je	.LBB1_27
	jmp	.LBB1_24
.LBB1_28:
	xorl	%r12d, %r12d
	callq	*%rdi
	testq	%rax, %rax
	je	.LBB1_31
	jmp	.LBB1_24
.LBB1_32:
	xorl	%r13d, %r13d
	callq	*%rdi
	testq	%rax, %rax
	je	.LBB1_35
	jmp	.LBB1_24
.LBB1_36:
	xorl	%ebp, %ebp
	callq	*%rdi
	testq	%rax, %rax
	je	.LBB1_39
.LBB1_24:
	movabsq	$NRT_decref, %rax
	movq	280(%rsp), %rcx
	callq	*%rax
	movq	304(%rsp), %rdi
	movq	296(%rsp), %r15
	movq	288(%rsp), %r13
.LBB1_20:
	movabsq	$NRT_decref, %rax
	movq	%r13, %rcx
	callq	*%rax
.LBB1_21:
	movabsq	$NRT_decref, %rax
	movq	%r15, %rcx
	callq	*%rax
.LBB1_12:
	movabsq	$NRT_decref, %rax
	movq	%rdi, %rcx
	callq	*%rax
	jmp	.LBB1_1
.LBB1_44:
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
.LBB1_5:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_1:
	xorl	%eax, %eax
	jmp	.LBB1_2
.LBB1_46:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end1:
	.size	_ZN7cpython32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end1-_ZN7cpython32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.cfi_endproc

	.globl	cfunc._ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
	.p2align	4
	.type	cfunc._ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@function
cfunc._ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	subq	$296, %rsp
	.cfi_def_cfa_offset 320
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	520(%rsp), %rax
	movaps	544(%rsp), %xmm0
	movaps	560(%rsp), %xmm1
	movq	$0, 288(%rsp)
	movups	%xmm1, 256(%rsp)
	movups	%xmm0, 240(%rsp)
	movq	%rax, 216(%rsp)
	movabsq	$_ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, %rax
	leaq	288(%rsp), %rcx
	callq	*%rax
	movq	288(%rsp), %rcx
	movl	$0, 284(%rsp)
	testl	%eax, %eax
	jne	.LBB2_1
.LBB2_5:
	movq	%rcx, %rax
	addq	$296, %rsp
	popq	%rdi
	popq	%rsi
	retq
.LBB2_1:
	movq	%rcx, %rdi
	movabsq	$numba_gil_ensure, %rdx
	leaq	284(%rsp), %rcx
	movl	%eax, %esi
	callq	*%rdx
	testl	%esi, %esi
	jg	.LBB2_2
	movl	%esi, %eax
	cmpl	$-1, %esi
	je	.LBB2_4
	cmpl	$-3, %eax
	jne	.LBB2_3
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	callq	*%rax
	jmp	.LBB2_4
.LBB2_3:
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function.2", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB2_4:
	movabsq	$".const.<numba.core.cpu.CPUContext>", %rcx
	movabsq	$PyUnicode_FromString, %rax
	callq	*%rax
	movq	%rax, %rsi
	movabsq	$PyErr_WriteUnraisable, %rax
	movq	%rsi, %rcx
	callq	*%rax
	movabsq	$Py_DecRef, %rax
	movq	%rsi, %rcx
	callq	*%rax
	movabsq	$numba_gil_release, %rax
	leaq	284(%rsp), %rcx
	callq	*%rax
	movq	%rdi, %rcx
	jmp	.LBB2_5
.LBB2_2:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end2:
	.size	cfunc._ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx, .Lfunc_end2-cfunc._ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
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

	.type	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,@object
	.comm	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx":
	.asciz	"missing Environment: _ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx"
	.size	".const.missing Environment: _ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx", 271

	.type	".const.can't unbox array from PyObject into native value.  The object maybe of a different type",@object
	.p2align	4, 0x0
".const.can't unbox array from PyObject into native value.  The object maybe of a different type":
	.asciz	"can't unbox array from PyObject into native value.  The object maybe of a different type"
	.size	".const.can't unbox array from PyObject into native value.  The object maybe of a different type", 89

	.type	".const.unknown error when calling native function",@object
	.p2align	4, 0x0
".const.unknown error when calling native function":
	.asciz	"unknown error when calling native function"
	.size	".const.unknown error when calling native function", 43

	.type	".const.unknown error when calling native function.2",@object
	.p2align	4, 0x0
".const.unknown error when calling native function.2":
	.asciz	"unknown error when calling native function"
	.size	".const.unknown error when calling native function.2", 43

	.type	".const.<numba.core.cpu.CPUContext>",@object
	.p2align	4, 0x0
".const.<numba.core.cpu.CPUContext>":
	.asciz	"<numba.core.cpu.CPUContext>"
	.size	".const.<numba.core.cpu.CPUContext>", 28

	.type	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e45mul_iB2v2B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e45mul_iB2v2B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.type	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e45add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_a840a9a92cd3a10be28522e45add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.section	".note.GNU-stack","",@progbits
