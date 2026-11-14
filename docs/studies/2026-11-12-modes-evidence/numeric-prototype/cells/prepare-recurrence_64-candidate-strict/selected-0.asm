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
	.globl	_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
	.p2align	4
	.type	_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@function
_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx:
	pushq	%rsi
	pushq	%rdi
	movq	272(%rsp), %rdx
	movq	264(%rsp), %r11
	movq	240(%rsp), %rax
	cvtsi2sd	%r11, %xmm1
	cvtsi2sd	%rdx, %xmm0
	mulsd	%xmm0, %xmm1
	movabsq	$.LCPI0_0, %r9
	andpd	(%r9), %xmm1
	movabsq	$.LCPI0_1, %r10
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	cmpb	$0, (%rax)
	jne	.LBB0_2
	movq	280(%rsp), %r8
	imulq	%rdx, %r11
	leaq	(%r8,%r11), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %rdi
	xorq	%rdi, %rsi
	movq	%rdi, %r11
	xorq	%r8, %r11
	testq	%r11, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rdi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rdi
	leaq	(%rdi,%r8), %r11
	xorq	%r11, %rdi
	movq	%r11, %rsi
	xorq	%r8, %rsi
	testq	%rsi, %rdi
	js	.LBB0_1
	cmpb	$0, (%rax)
	jne	.LBB0_2
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rsi
	xorq	%rsi, %r11
	movq	%rsi, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %r11
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%rsi, %xmm1
	mulsd	%xmm0, %xmm1
	andpd	(%r9), %xmm1
	ucomisd	(%r10), %xmm1
	jae	.LBB0_1
	imulq	%rdx, %rsi
	leaq	(%rsi,%r8), %r11
	xorq	%r11, %rsi
	movq	%r11, %rdi
	xorq	%r8, %rdi
	testq	%rdi, %rsi
	js	.LBB0_1
	xorps	%xmm1, %xmm1
	cvtsi2sd	%r11, %xmm1
	mulsd	%xmm1, %xmm0
	andpd	(%r9), %xmm0
	ucomisd	(%r10), %xmm0
	jae	.LBB0_1
	imulq	%rdx, %r11
	leaq	(%r11,%r8), %rdx
	xorq	%rdx, %r11
	xorq	%rdx, %r8
	testq	%r8, %r11
	jns	.LBB0_3
.LBB0_1:
	movb	$1, (%rax)
.LBB0_2:
	xorl	%edx, %edx
.LBB0_3:
	movq	%rdx, (%rcx)
	xorl	%eax, %eax
	popq	%rdi
	popq	%rsi
	retq
.Lfunc_end0:
	.size	_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, .Lfunc_end0-_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

	.globl	_ZN7cpython32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
	.p2align	4
	.type	_ZN7cpython32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@function
_ZN7cpython32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx:
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
	subq	$616, %rsp
	.cfi_def_cfa_offset 688
	.cfi_offset %rbx, -72
	.cfi_offset %rbp, -64
	.cfi_offset %rdi, -56
	.cfi_offset %rsi, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rcx
	leaq	312(%rsp), %rax
	movq	%rax, 80(%rsp)
	leaq	320(%rsp), %rax
	movq	%rax, 72(%rsp)
	leaq	328(%rsp), %rax
	movq	%rax, 64(%rsp)
	leaq	336(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	344(%rsp), %rax
	movq	%rax, 48(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	360(%rsp), %rax
	movq	%rax, 32(%rsp)
	movabsq	$.const.f0_recurrence_64, %rdx
	movabsq	$PyArg_UnpackTuple, %rax
	movl	$7, %r8d
	movl	$7, %r9d
	callq	*%rax
	movq	$0, 304(%rsp)
	testl	%eax, %eax
	je	.LBB1_1
	movabsq	$_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, %rax
	cmpq	$0, (%rax)
	je	.LBB1_4
	movq	360(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 560(%rsp)
	movaps	%xmm0, 576(%rsp)
	movaps	%xmm0, 592(%rsp)
	movq	$0, 608(%rsp)
	movabsq	$NRT_adapt_ndarray_from_python, %rsi
	leaq	560(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_8
	cmpq	$8, 584(%rsp)
	jne	.LBB1_8
	movq	560(%rsp), %r14
	movq	352(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 496(%rsp)
	movaps	%xmm0, 512(%rsp)
	movaps	%xmm0, 528(%rsp)
	movq	$0, 544(%rsp)
	leaq	496(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_11
	cmpq	$8, 520(%rsp)
	jne	.LBB1_11
	movq	496(%rsp), %r15
	movq	344(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 432(%rsp)
	movaps	%xmm0, 448(%rsp)
	movaps	%xmm0, 464(%rsp)
	movq	$0, 480(%rsp)
	leaq	432(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_16
	cmpq	$8, 456(%rsp)
	jne	.LBB1_16
	movq	432(%rsp), %r13
	movq	336(%rsp), %rcx
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 368(%rsp)
	movaps	%xmm0, 384(%rsp)
	movaps	%xmm0, 400(%rsp)
	movq	$0, 416(%rsp)
	leaq	368(%rsp), %rdx
	callq	*%rsi
	testl	%eax, %eax
	jne	.LBB1_19
	cmpq	$1, 392(%rsp)
	jne	.LBB1_19
	movq	368(%rsp), %rax
	movq	%rax, 272(%rsp)
	movq	400(%rsp), %rsi
	movq	328(%rsp), %rcx
	movabsq	$PyNumber_Long, %rbp
	callq	*%rbp
	movabsq	$PyLong_AsLongLong, %rbx
	movabsq	$Py_DecRef, %rdi
	testq	%rax, %rax
	movq	%r14, 296(%rsp)
	movq	%r15, 288(%rsp)
	movq	%r13, 280(%rsp)
	je	.LBB1_23
	movq	%rax, %r12
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r15
	movq	%r12, %rcx
	callq	*%rdi
	movabsq	$PyErr_Occurred, %r14
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_27:
	movq	320(%rsp), %rcx
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB1_28
	movq	%rax, %r13
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r12
	movq	%r13, %rcx
	callq	*%rdi
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_31:
	movq	312(%rsp), %rcx
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB1_32
	movq	%rax, %rbp
	movq	%rax, %rcx
	callq	*%rbx
	movq	%rax, %r13
	movq	%rbp, %rcx
	callq	*%rdi
	callq	*%r14
	testq	%rax, %rax
	jne	.LBB1_24
.LBB1_35:
	movq	%r13, 256(%rsp)
	movq	%r12, 248(%rsp)
	movq	%r15, 240(%rsp)
	movq	%rsi, 216(%rsp)
	movabsq	$_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, %rax
	leaq	304(%rsp), %rcx
	callq	*%rax
	movl	%eax, %ebp
	movq	304(%rsp), %r15
	movabsq	$NRT_decref, %rsi
	movq	296(%rsp), %rcx
	callq	*%rsi
	movq	288(%rsp), %rcx
	callq	*%rsi
	movq	280(%rsp), %rcx
	callq	*%rsi
	movq	272(%rsp), %rcx
	callq	*%rsi
	testl	%ebp, %ebp
	jne	.LBB1_36
	movabsq	$PyLong_FromLongLong, %rax
	movq	%r15, %rcx
	callq	*%rax
.LBB1_2:
	addq	$616, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB1_36:
	jg	.LBB1_42
	cmpl	$-1, %ebp
	je	.LBB1_1
	cmpl	$-3, %ebp
	jne	.LBB1_40
	movabsq	$PyExc_StopIteration, %rcx
	movabsq	$PyErr_SetNone, %rax
	callq	*%rax
	jmp	.LBB1_1
.LBB1_4:
	movabsq	$PyExc_RuntimeError, %rcx
	movabsq	$".const.missing Environment: _ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx", %rdx
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
	movabsq	$PyErr_Occurred, %r14
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_27
	jmp	.LBB1_24
.LBB1_28:
	xorl	%r12d, %r12d
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_31
	jmp	.LBB1_24
.LBB1_32:
	xorl	%r13d, %r13d
	callq	*%r14
	testq	%rax, %rax
	je	.LBB1_35
.LBB1_24:
	movabsq	$NRT_decref, %rax
	movq	272(%rsp), %rcx
	callq	*%rax
	movq	296(%rsp), %r14
	movq	288(%rsp), %r15
	movq	280(%rsp), %r13
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
	movq	%r14, %rcx
	callq	*%rax
	jmp	.LBB1_1
.LBB1_40:
	movabsq	$PyExc_SystemError, %rcx
	movabsq	$".const.unknown error when calling native function", %rdx
.LBB1_5:
	movabsq	$PyErr_SetString, %rax
	callq	*%rax
.LBB1_1:
	xorl	%eax, %eax
	jmp	.LBB1_2
.LBB1_42:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end1:
	.size	_ZN7cpython32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, .Lfunc_end1-_ZN7cpython32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
	.cfi_endproc

	.globl	cfunc._ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
	.p2align	4
	.type	cfunc._ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@function
cfunc._ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx:
	.cfi_startproc
	pushq	%rsi
	.cfi_def_cfa_offset 16
	pushq	%rdi
	.cfi_def_cfa_offset 24
	subq	$280, %rsp
	.cfi_def_cfa_offset 304
	.cfi_offset %rdi, -24
	.cfi_offset %rsi, -16
	movq	504(%rsp), %rax
	movaps	528(%rsp), %xmm0
	movq	544(%rsp), %rcx
	movq	%rcx, 256(%rsp)
	movups	%xmm0, 240(%rsp)
	movq	%rax, 216(%rsp)
	movabsq	$_ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, %rax
	leaq	272(%rsp), %rcx
	callq	*%rax
	movq	272(%rsp), %rcx
	movl	$0, 268(%rsp)
	testl	%eax, %eax
	jne	.LBB2_1
.LBB2_5:
	movq	%rcx, %rax
	addq	$280, %rsp
	popq	%rdi
	popq	%rsi
	retq
.LBB2_1:
	movq	%rcx, %rdi
	movabsq	$numba_gil_ensure, %rdx
	leaq	268(%rsp), %rcx
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
	leaq	268(%rsp), %rcx
	callq	*%rax
	movq	%rdi, %rcx
	jmp	.LBB2_5
.LBB2_2:
	movabsq	$PyErr_Clear, %rax
	callq	*%rax
.Lfunc_end2:
	.size	cfunc._ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx, .Lfunc_end2-cfunc._ZN32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
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

	.type	.const.f0_recurrence_64,@object
	.section	.lrodata,"al",@progbits
	.p2align	4, 0x0
.const.f0_recurrence_64:
	.asciz	"f0_recurrence_64"
	.size	.const.f0_recurrence_64, 17

	.type	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,@object
	.comm	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx,8,8
	.type	".const.missing Environment: _ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx",@object
	.p2align	4, 0x0
".const.missing Environment: _ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx":
	.asciz	"missing Environment: _ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx"
	.size	".const.missing Environment: _ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f79621016f0_recurrence_64B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx", 266

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

	.type	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f7962105mul_iB2v2B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f7962105mul_iB2v2B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.type	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f7962105add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,@object
	.comm	_ZN08NumbaEnv32rc_heap_5b5b61a3bf0b3ec88f7962105add_iB2v3B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIhLi1E1C7mutable7alignedExx,8,8
	.section	".note.GNU-stack","",@progbits
