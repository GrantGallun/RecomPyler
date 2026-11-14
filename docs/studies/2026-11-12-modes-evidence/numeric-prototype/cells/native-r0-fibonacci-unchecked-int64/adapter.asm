	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.p2align	4
	.type	_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@function
_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx:
	.cfi_startproc
	movq	56(%rsp), %r9
	testq	%r9, %r9
	jle	.LBB0_1
	movl	%r9d, %eax
	andl	$7, %eax
	cmpq	$8, %r9
	jae	.LBB0_5
	movl	$1, %r8d
	xorl	%edx, %edx
	jmp	.LBB0_12
.LBB0_1:
	xorl	%edx, %edx
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	retq
.LBB0_5:
	addq	$-8, %r9
	shrq	$3, %r9
	je	.LBB0_6
	incq	%r9
	movq	%r9, %r10
	andq	$-2, %r10
	negq	%r10
	movl	$1, %r8d
	xorl	%edx, %edx
	.p2align	4
.LBB0_8:
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	$2, %r10
	jne	.LBB0_8
	testb	$1, %r9b
	jne	.LBB0_10
	testq	%rax, %rax
	jne	.LBB0_12
.LBB0_2:
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	retq
.LBB0_6:
	movl	$1, %r8d
	xorl	%edx, %edx
.LBB0_10:
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	addq	%r8, %rdx
	addq	%rdx, %r8
	testq	%rax, %rax
	je	.LBB0_2
.LBB0_12:
	movq	%rdx, %r9
	.p2align	4
.LBB0_13:
	movq	%r8, %rdx
	addq	%r8, %r9
	movq	%r9, %r8
	movq	%rdx, %r9
	decq	%rax
	jne	.LBB0_13
	jmp	.LBB0_2
.Lfunc_end0:
	.size	_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, .Lfunc_end0-_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.cfi_endproc

	.globl	cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.p2align	4
	.type	cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@function
cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	subq	$104, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	160(%rsp), %rax
	movq	$0, 96(%rsp)
	movq	%rax, 48(%rsp)
	movabsq	$_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, %rax
	leaq	96(%rsp), %rcx
	callq	*%rax
	movq	96(%rsp), %rcx
	movl	$0, 92(%rsp)
	testl	%eax, %eax
	jne	.LBB1_1
.LBB1_5:
	movq	%rcx, %rax
	addq	$104, %rsp
	popq	%rdi
	popq	%rsi
	retq
.LBB1_1:
	movq	%rcx, %rdi
	movabsq	$numba_gil_ensure, %rdx
	leaq	92(%rsp), %rcx
	movl	%eax, %esi
	callq	*%rdx
	testl	%esi, %esi
	jg	.LBB1_2
	movl	%esi, %eax
	cmpl	$-1, %esi
	je	.LBB1_4
	cmpl	$-3, %eax
	jne	.LBB1_3
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	callq	*%rax
	jmp	.LBB1_4
.LBB1_3:
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_4:
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
	leaq	92(%rsp), %rcx
	callq	*%rax
	movq	%rdi, %rcx
	jmp	.LBB1_5
.LBB1_2:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end1:
	.size	cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, .Lfunc_end1-cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.cfi_endproc

	.weak	NRT_decref
	.p2align	4
	.type	NRT_decref,@function
NRT_decref:
	.cfi_startproc
	testq	%rcx, %rcx
	je	.LBB2_2
	#MEMBARRIER
	lock		decq	(%rcx)
	je	.LBB2_3
.LBB2_2:
	retq
.LBB2_3:
	#MEMBARRIER
	movabsq	$NRT_MemInfo_call_dtor, %rax
	rex64 jmpq	*%rax
.Lfunc_end2:
	.size	NRT_decref, .Lfunc_end2-NRT_decref
	.cfi_endproc

	.type	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@object
	.comm	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,8,8
	.type	".const.unknown error when calling native function",@object
	.section	.lrodata,"al",@progbits
	.p2align	4, 0x0
".const.unknown error when calling native function":
	.asciz	"unknown error when calling native function"
	.size	".const.unknown error when calling native function", 43

	.type	".const.<numba.core.cpu.CPUContext>",@object
	.p2align	4, 0x0
".const.<numba.core.cpu.CPUContext>":
	.asciz	"<numba.core.cpu.CPUContext>"
	.size	".const.<numba.core.cpu.CPUContext>", 28

	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@object
	.comm	_ZN08NumbaEnv32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,8,8
	.section	".note.GNU-stack","",@progbits
