	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
	movq	224(%rsp), %rdx
	movq	248(%rsp), %r8
	xorl	%eax, %eax
	testq	%r8, %r8
	cmovleq	%rax, %r8
	incq	%r8
	movl	$1, %r9d
	.p2align	4
.LBB0_1:
	decq	%r8
	testq	%r8, %r8
	jle	.LBB0_5
	leaq	(%r9,%rax), %r10
	xorq	%r10, %rax
	movq	%r10, %r11
	xorq	%r9, %r11
	testq	%r11, %rax
	js	.LBB0_3
	cmpb	$0, (%rdx)
	movq	%r9, %rax
	movq	%r10, %r9
	je	.LBB0_1
	jmp	.LBB0_4
.LBB0_3:
	movb	$1, (%rdx)
.LBB0_4:
	xorl	%eax, %eax
.LBB0_5:
	movq	%rax, (%rcx)
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end0-_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

	.globl	_ZN7cpython32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	_ZN7cpython32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
_ZN7cpython32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
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
	subq	$552, %rsp
	.cfi_def_cfa_offset 624
	.cfi_offset %rbx, -72
	.cfi_offset %rbp, -64
	.cfi_offset %rdi, -56
	.cfi_offset %rsi, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rcx
	leaq	264(%rsp), %rax
	movq	%rax, 64(%rsp)
	leaq	272(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	280(%rsp), %rax
	movq	%rax, 48(%rsp)
	leaq	288(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	296(%rsp), %rax
	movq	%rax, 32(%rsp)
	movabsq	$.const.f0_fibonacci, %rdx
	movabsq	$PyArg_UnpackTuple, %rax
	movl	$5, %r8d
	movl	$5, %r9d
	callq	*%rax
	testl	%eax, %eax
	je	.LBB1_1
	movabsq	$_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
	cmpq	$0, (%rax)
	je	.LBB1_4
	movq	296(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 496(%rsp)
	movaps	%xmm0, 512(%rsp)
	movaps	%xmm0, 528(%rsp)
	movq	$0, 544(%rsp)
	movabsq	$NRT_adapt_ndarray_from_python, %r14
	leaq	496(%rsp), %rdx
	callq	*%r14
	testl	%eax, %eax
	jne	.LBB1_8
	cmpq	$8, 520(%rsp)
	jne	.LBB1_8
	movq	496(%rsp), %rsi
	movq	288(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 432(%rsp)
	movaps	%xmm0, 448(%rsp)
	movaps	%xmm0, 464(%rsp)
	movq	$0, 480(%rsp)
	leaq	432(%rsp), %rdx
	callq	*%r14
	testl	%eax, %eax
	jne	.LBB1_11
	cmpq	$8, 456(%rsp)
	jne	.LBB1_11
	movq	432(%rsp), %rdi
	movq	280(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 368(%rsp)
	movaps	%xmm0, 384(%rsp)
	movaps	%xmm0, 400(%rsp)
	movq	$0, 416(%rsp)
	leaq	368(%rsp), %rdx
	callq	*%r14
	testl	%eax, %eax
	jne	.LBB1_16
	cmpq	$8, 392(%rsp)
	jne	.LBB1_16
	movq	368(%rsp), %rbx
	movq	272(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 304(%rsp)
	movaps	%xmm0, 320(%rsp)
	movaps	%xmm0, 336(%rsp)
	movq	$0, 352(%rsp)
	leaq	304(%rsp), %rdx
	callq	*%r14
	testl	%eax, %eax
	jne	.LBB1_19
	cmpq	$1, 328(%rsp)
	jne	.LBB1_19
	movq	304(%rsp), %r14
	movq	336(%rsp), %r13
	movq	264(%rsp), %rcx
	movabsq	$PyNumber_Long, %rax
	callq	*%rax
	testq	%rax, %rax
	je	.LBB1_23
	movq	%rax, %r12
	movabsq	$PyLong_AsLongLong, %rax
	movq	%r12, %rcx
	callq	*%rax
	movq	%rax, %r15
	movabsq	$Py_DecRef, %rax
	movq	%r12, %rcx
	callq	*%rax
	movabsq	$PyErr_Occurred, %rax
	callq	*%rax
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_27:
	movq	$0, 256(%rsp)
	movq	%r15, 240(%rsp)
	movq	%r13, 216(%rsp)
	movabsq	$_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
	leaq	256(%rsp), %rcx
	callq	*%rax
	movl	%eax, %ebp
	movq	256(%rsp), %r15
	movabsq	$NRT_decref, %r12
	movq	%rsi, %rcx
	callq	*%r12
	movq	%rdi, %rcx
	callq	*%r12
	movq	%rbx, %rcx
	callq	*%r12
	movq	%r14, %rcx
	callq	*%r12
	testl	%ebp, %ebp
	jne	.LBB1_28
	movabsq	$PyLong_FromLongLong, %rax
	movq	%r15, %rcx
	callq	*%rax
.LBB1_2:
	addq	$552, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB1_28:
	jg	.LBB1_34
	cmpl	$-1, %ebp
	je	.LBB1_1
	cmpl	$-3, %ebp
	jne	.LBB1_32
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	callq	*%rax
	jmp	.LBB1_1
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx", %rdx
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
	movabsq	$PyErr_Occurred, %rax
	callq	*%rax
	testq	%rax, %rax
	je	.LBB1_27
.LBB1_24:
	movabsq	$NRT_decref, %rax
	movq	%r14, %rcx
	callq	*%rax
.LBB1_20:
	movabsq	$NRT_decref, %rax
	movq	%rbx, %rcx
	callq	*%rax
.LBB1_21:
	movabsq	$NRT_decref, %rax
	movq	%rdi, %rcx
	callq	*%rax
.LBB1_12:
	movabsq	$NRT_decref, %rax
	movq	%rsi, %rcx
	callq	*%rax
	jmp	.LBB1_1
.LBB1_32:
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
.LBB1_5:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_1:
	xorl	%eax, %eax
	jmp	.LBB1_2
.LBB1_34:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end1:
	.size	_ZN7cpython32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end1-_ZN7cpython32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.cfi_endproc

	.globl	cfunc._ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	cfunc._ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
cfunc._ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	subq	$264, %rsp
	.cfi_def_cfa_offset 288
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	488(%rsp), %rax
	movq	512(%rsp), %rcx
	movq	$0, 256(%rsp)
	movq	%rcx, 240(%rsp)
	movq	%rax, 216(%rsp)
	movabsq	$_ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
	leaq	256(%rsp), %rcx
	callq	*%rax
	movq	256(%rsp), %rcx
	movl	$0, 252(%rsp)
	testl	%eax, %eax
	jne	.LBB2_1
.LBB2_5:
	movq	%rcx, %rax
	addq	$264, %rsp
	popq	%rdi
	popq	%rsi
	retq
.LBB2_1:
	movq	%rcx, %rdi
	movabsq	$numba_gil_ensure, %rdx
	leaq	252(%rsp), %rcx
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
	leaq	252(%rsp), %rcx
	callq	*%rax
	movq	%rdi, %rcx
	jmp	.LBB2_5
.LBB2_2:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end2:
	.size	cfunc._ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end2-cfunc._ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
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

	.type	.const.f0_fibonacci,@object
	.section	.lrodata,"al",@progbits
.const.f0_fibonacci:
	.asciz	"f0_fibonacci"
	.size	.const.f0_fibonacci, 13

	.type	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@object
	.comm	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx":
	.asciz	"missing Environment: _ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx"
	.size	".const.missing Environment: _ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx", 260

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

	.type	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd5add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd5add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.section	".note.GNU-stack","",@progbits
