	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
	movq	248(%rsp), %r9
	testq	%r9, %r9
	jle	.LBB0_1
	movl	%r9d, %eax
	andl	$7, %eax
	cmpq	$8, %r9
	jae	.LBB0_4
	movl	$1, %r8d
	xorl	%edx, %edx
	jmp	.LBB0_7
.LBB0_1:
	xorl	%edx, %edx
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	retq
.LBB0_4:
	movabsq	$9223372036854775800, %rdx
	andq	%rdx, %r9
	negq	%r9
	movl	$1, %r8d
	xorl	%edx, %edx
	.p2align	4
.LBB0_5:
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	$8, %r9
	jne	.LBB0_5
	testq	%rax, %rax
	je	.LBB0_9
.LBB0_7:
	movq	%rdx, %r9
	.p2align	4
.LBB0_8:
	movq	%r8, %rdx
	addq	%r8, %r9
	movq	%r9, %r8
	movq	%rdx, %r9
	decq	%rax
	jne	.LBB0_8
.LBB0_9:
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end0-_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

	.globl	_ZN7cpython32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	_ZN7cpython32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
_ZN7cpython32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rsi
	.cfi_def_cfa_offset 40
	pushq	%rdi
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$552, %rsp
	.cfi_def_cfa_offset 608
	.cfi_offset %rbx, -56
	.cfi_offset %rdi, -48
	.cfi_offset %rsi, -40
	.cfi_offset %r12, -32
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
	movabsq	$_ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
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
	jne	.LBB1_14
	cmpq	$8, 392(%rsp)
	jne	.LBB1_14
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
	movq	264(%rsp), %rcx
	movabsq	$PyNumber_Long, %rax
	callq	*%rax
	testq	%rax, %rax
	je	.LBB1_21
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
	jne	.LBB1_22
.LBB1_26:
	movq	$0, 256(%rsp)
	movq	%r15, 240(%rsp)
	movabsq	$_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
	leaq	256(%rsp), %rcx
	callq	*%rax
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
	movabsq	$PyLong_FromLongLong, %rax
	movq	%r15, %rcx
	callq	*%rax
.LBB1_2:
	addq	$552, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx", %rdx
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
	movabsq	$PyErr_Occurred, %rax
	callq	*%rax
	testq	%rax, %rax
	je	.LBB1_26
.LBB1_22:
	movabsq	$NRT_decref, %rax
	movq	%r14, %rcx
	callq	*%rax
.LBB1_23:
	movabsq	$NRT_decref, %rax
	movq	%rbx, %rcx
	callq	*%rax
.LBB1_15:
	movabsq	$NRT_decref, %rax
	movq	%rdi, %rcx
	callq	*%rax
.LBB1_16:
	movabsq	$NRT_decref, %rax
	movq	%rsi, %rcx
	callq	*%rax
.LBB1_1:
	xorl	%eax, %eax
	jmp	.LBB1_2
.Lfunc_end1:
	.size	_ZN7cpython32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end1-_ZN7cpython32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.cfi_endproc

	.globl	cfunc._ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx
	.p2align	4
	.type	cfunc._ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@function
cfunc._ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx:
	subq	$264, %rsp
	movq	496(%rsp), %rax
	movq	$0, 256(%rsp)
	movq	%rax, 240(%rsp)
	movabsq	$_ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, %rax
	leaq	256(%rsp), %rcx
	callq	*%rax
	movq	256(%rsp), %rax
	addq	$264, %rsp
	retq
.Lfunc_end2:
	.size	cfunc._ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx, .Lfunc_end2-cfunc._ZN32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

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

	.type	_ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@object
	.comm	_ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx":
	.asciz	"missing Environment: _ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx"
	.size	".const.missing Environment: _ZN08NumbaEnv32rc_heap_ccbac43f29e8e3fbd19174ad12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx", 260

	.type	".const.can't unbox array from PyObject into native value.  The object maybe of a different type",@object
	.p2align	4, 0x0
".const.can't unbox array from PyObject into native value.  The object maybe of a different type":
	.asciz	"can't unbox array from PyObject into native value.  The object maybe of a different type"
	.size	".const.can't unbox array from PyObject into native value.  The object maybe of a different type", 89

	.section	".note.GNU-stack","",@progbits
