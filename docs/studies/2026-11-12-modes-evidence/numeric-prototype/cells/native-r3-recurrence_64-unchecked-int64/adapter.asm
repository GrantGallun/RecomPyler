	.file	"<string>"
	.section	.ltext,"axl",@progbits
	.globl	_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.p2align	4
	.type	_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@function
_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$288, %rsp
	.cfi_def_cfa_offset 320
	.cfi_offset %rbx, -32
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	%rdx, %rsi
	movq	%rcx, %rdi
	movq	352(%rsp), %rax
	movq	360(%rsp), %rcx
	movaps	368(%rsp), %xmm0
	movq	384(%rsp), %rdx
	movq	%rdx, 256(%rsp)
	movups	%xmm0, 240(%rsp)
	movq	%rcx, 216(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 184(%rsp)
	movq	%rax, 160(%rsp)
	movups	%xmm0, 128(%rsp)
	movq	%r9, 104(%rsp)
	movups	%xmm0, 72(%rsp)
	movq	%r8, 48(%rsp)
	movq	$1, 232(%rsp)
	movq	$1, 224(%rsp)
	movq	$1, 208(%rsp)
	movq	$1, 200(%rsp)
	movq	$8, 176(%rsp)
	movq	$4, 168(%rsp)
	movq	$8, 152(%rsp)
	movq	$4, 144(%rsp)
	movq	$8, 120(%rsp)
	movq	$65536, 112(%rsp)
	movq	$8, 96(%rsp)
	movq	$65536, 88(%rsp)
	movq	$8, 64(%rsp)
	movq	$65536, 56(%rsp)
	movq	$8, 40(%rsp)
	movq	$65536, 32(%rsp)
	movabsq	$_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, %rax
	xorl	%ebx, %ebx
	leaq	272(%rsp), %rcx
	leaq	280(%rsp), %rdx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	*%rax
	cmpl	$-2, %eax
	je	.LBB0_2
	testl	%eax, %eax
	jne	.LBB0_4
.LBB0_2:
	movq	272(%rsp), %rax
	movq	%rax, (%rdi)
.LBB0_3:
	movl	%ebx, %eax
	addq	$288, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	retq
.LBB0_4:
	movq	$0, (%rsi)
	movl	%eax, %ebx
	jmp	.LBB0_3
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
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$112, %rsp
	.cfi_def_cfa_offset 144
	.cfi_offset %rbx, -32
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	%rdx, %rax
	movq	%rcx, %r10
	movaps	176(%rsp), %xmm0
	movq	192(%rsp), %rcx
	movq	$0, 104(%rsp)
	movq	$0, 96(%rsp)
	movq	%rcx, 64(%rsp)
	movups	%xmm0, 48(%rsp)
	movq	%r9, 40(%rsp)
	movq	%r8, 32(%rsp)
	movabsq	$_ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, %r11
	leaq	104(%rsp), %rcx
	leaq	96(%rsp), %rdx
	movq	%r10, %r8
	movq	%rax, %r9
	callq	*%r11
	movl	%eax, %edx
	movq	96(%rsp), %rsi
	movq	104(%rsp), %rax
	movl	$0, 92(%rsp)
	testl	%edx, %edx
	jne	.LBB1_1
.LBB1_8:
	addq	$112, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	retq
.LBB1_1:
	movq	%rax, %rbx
	movabsq	$numba_gil_ensure, %rax
	leaq	92(%rsp), %rcx
	movl	%edx, %edi
	callq	*%rax
	testl	%edi, %edi
	jle	.LBB1_9
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
	movl	8(%rsi), %edx
	movq	(%rsi), %rcx
	cmpl	$0, 32(%rsi)
	jle	.LBB1_12
	movslq	%edx, %rdx
	movabsq	$PyBytes_FromStringAndSize, %rax
	callq	*%rax
	movq	%rax, %rdi
	movq	16(%rsi), %rcx
	callq	*24(%rsi)
	testq	%rax, %rax
	je	.LBB1_4
	movabsq	$numba_runtime_build_excinfo_struct, %r8
	movq	%rdi, %rcx
	movq	%rax, %rdx
	callq	*%r8
	movq	%rax, %rdi
	movabsq	$NRT_Free, %rax
	movq	%rsi, %rcx
	callq	*%rax
	jmp	.LBB1_13
.LBB1_9:
	movl	%edi, %eax
	cmpl	$-3, %edi
	je	.LBB1_5
	cmpl	$-1, %eax
	je	.LBB1_7
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	jmp	.LBB1_7
.LBB1_12:
	movq	16(%rsi), %r8
	movabsq	$numba_unpickle, %rax
	callq	*%rax
	movq	%rax, %rdi
.LBB1_13:
	testq	%rdi, %rdi
	je	.LBB1_7
	movabsq	$numba_do_raise, %rax
	movq	%rdi, %rcx
.LBB1_6:
	callq	*%rax
.LBB1_7:
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
	movq	%rbx, %rax
	jmp	.LBB1_8
.LBB1_5:
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	jmp	.LBB1_6
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.Error creating Python tuple from runtime exception arguments", %rdx
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
	xorl	%eax, %eax
	jmp	.LBB1_8
.Lfunc_end1:
	.size	cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx, .Lfunc_end1-cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
	.cfi_endproc

	.weak	_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
	.p2align	4
	.type	_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@function
_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx:
	movq	264(%rsp), %rax
	movq	256(%rsp), %r8
	movq	248(%rsp), %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%rax, %rdx
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	retq
.Lfunc_end2:
	.size	_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, .Lfunc_end2-_ZN32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

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

	.type	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,@object
	.comm	_ZN08NumbaEnv13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx,8,8
	.type	".const.Error creating Python tuple from runtime exception arguments",@object
	.section	.lrodata,"al",@progbits
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

	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v13B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE10float64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v14B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8int64_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,@object
	.comm	_ZN08NumbaEnv5numba2np8arrayobj11impl_carray12_3clocals_3e4implB3v15B42c8tJTIeFIjxB2IKSgI4CrvQClcaMQ5hEEUSJJgA_3dE8uint8_2ax27omitted_28default_3dNone_29,8,8
	.type	_ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@object
	.comm	_ZN08NumbaEnv32rc_heap_dc0a616c86c4f17f273ddd8216f0_recurrence_64B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,8,8
	.section	".note.GNU-stack","",@progbits
