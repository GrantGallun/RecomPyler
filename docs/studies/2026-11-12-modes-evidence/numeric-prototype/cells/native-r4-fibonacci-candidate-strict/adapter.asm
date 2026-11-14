	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.p2align	4
	.type	_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@function
_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx:
	.cfi_startproc
	movq	48(%rsp), %rdx
	movq	56(%rsp), %r8
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
	.size	_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, .Lfunc_end0-_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.cfi_endproc

	.globl	cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.p2align	4
	.type	cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@function
cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx:
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
	movq	%r9, 40(%rsp)
	movabsq	$_ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, %rax
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
	.size	cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, .Lfunc_end1-cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
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

	.type	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@object
	.comm	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,8,8
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

	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v16B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v16B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v17B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v17B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,@object
	.comm	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx,8,8
	.type	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd5add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_76885d8ba89d2be1fa3724cd5add_iB3v13B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.section	".note.GNU-stack","",@progbits
