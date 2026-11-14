# Existing measured PE, c force: [0x140002710, 0x1400028f0)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
140002710:     	pushq	%r14
140002712:     	pushq	%rsi
140002713:     	pushq	%rdi
140002714:     	pushq	%rbx
140002715:     	subq	$0x58, %rsp
140002719:     	vmovapd	%xmm7, 0x40(%rsp)
14000271f:     	vmovapd	%xmm6, 0x30(%rsp)
140002725:     	movq	$0x0, (%r8)
14000272c:     	movq	$0x0, (%r9)
140002733:     	vxorpd	%xmm1, %xmm1, %xmm1
140002737:     	vmovsd	0x48(%rcx), %xmm0
14000273c:     	vucomisd	%xmm1, %xmm0
140002740:     	jne	0x140002748 <.text+0x1748>
140002742:     	jnp	0x1400028b6 <.text+0x18b6>
140002748:     	cmpl	$0x1, 0x20(%rcx)
14000274c:     	jne	0x140002757 <.text+0x1757>
14000274e:     	cmpl	%edx, 0x24(%rcx)
140002751:     	je	0x1400028b6 <.text+0x18b6>
140002757:     	movq	0x2942(%rip), %rax      # 0x1400050a0
14000275e:     	movslq	%edx, %r10
140002761:     	vmovsd	0x38(%rcx), %xmm1
140002766:     	vmovsd	0x40(%rcx), %xmm3
14000276b:     	imulq	$0x38, %r10, %r10
14000276f:     	cmpl	$0x0, 0x34(%rcx)
140002773:     	vsubsd	(%rax,%r10), %xmm1, %xmm2
140002779:     	vsubsd	0x8(%rax,%r10), %xmm3, %xmm1
140002780:     	vmulsd	%xmm2, %xmm2, %xmm3
140002784:     	vmulsd	%xmm1, %xmm1, %xmm4
140002788:     	vaddsd	%xmm4, %xmm3, %xmm3
14000278c:     	vsqrtsd	%xmm3, %xmm3, %xmm3
140002790:     	je	0x1400027ad <.text+0x17ad>
140002792:     	vmovsd	0x10(%rcx), %xmm4
140002797:     	vmovsd	0x1b59(%rip), %xmm5     # 0x1400042f8
14000279f:     	vaddsd	%xmm4, %xmm4, %xmm4
1400027a3:     	vdivsd	%xmm3, %xmm4, %xmm4
1400027a7:     	vucomisd	%xmm4, %xmm5
1400027ab:     	jbe	0x1400027ef <.text+0x17ef>
1400027ad:     	vmovsd	0x1b3b(%rip), %xmm4     # 0x1400042f0
1400027b5:     	addq	%r10, %rax
1400027b8:     	vmaxsd	%xmm3, %xmm4, %xmm3
1400027bc:     	vmovsd	0x30(%rax), %xmm4
1400027c1:     	vmulsd	0x1b1f(%rip), %xmm4, %xmm4 # 0x1400042e8
1400027c9:     	vmulsd	%xmm3, %xmm3, %xmm5
1400027cd:     	vmulsd	%xmm0, %xmm4, %xmm0
1400027d1:     	vdivsd	%xmm5, %xmm0, %xmm0
1400027d5:     	vmulsd	%xmm0, %xmm2, %xmm2
1400027d9:     	vmulsd	%xmm0, %xmm1, %xmm0
1400027dd:     	vdivsd	%xmm3, %xmm2, %xmm2
1400027e1:     	vdivsd	%xmm3, %xmm0, %xmm6
1400027e5:     	vmovsd	%xmm2, (%r8)
1400027ea:     	jmp	0x1400028b1 <.text+0x18b1>
1400027ef:     	movq	0x50(%rcx), %rax
1400027f3:     	movq	%r8, %rdi
1400027f6:     	movq	%r9, %rbx
1400027f9:     	movq	%rcx, %r14
1400027fc:     	testq	%rax, %rax
1400027ff:     	je	0x1400028cc <.text+0x18cc>
140002805:     	leaq	0x28(%rsp), %r8
14000280a:     	leaq	0x20(%rsp), %r9
14000280f:     	movq	%rax, %rcx
140002812:     	movl	%edx, %esi
140002814:     	callq	0x140002710 <.text+0x1710>
140002819:     	vxorpd	%xmm0, %xmm0, %xmm0
14000281d:     	vaddsd	0x28(%rsp), %xmm0, %xmm7
140002823:     	vaddsd	0x20(%rsp), %xmm0, %xmm6
140002829:     	movq	%r14, %rcx
14000282c:     	movq	0x58(%rcx), %rax
140002830:     	testq	%rax, %rax
140002833:     	je	0x140002858 <.text+0x1858>
140002835:     	leaq	0x28(%rsp), %r8
14000283a:     	leaq	0x20(%rsp), %r9
14000283f:     	movq	%rax, %rcx
140002842:     	movl	%esi, %edx
140002844:     	callq	0x140002710 <.text+0x1710>
140002849:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
14000284f:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
140002855:     	movq	%r14, %rcx
140002858:     	movq	0x60(%rcx), %rax
14000285c:     	testq	%rax, %rax
14000285f:     	je	0x140002884 <.text+0x1884>
140002861:     	leaq	0x28(%rsp), %r8
140002866:     	leaq	0x20(%rsp), %r9
14000286b:     	movq	%rax, %rcx
14000286e:     	movl	%esi, %edx
140002870:     	callq	0x140002710 <.text+0x1710>
140002875:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
14000287b:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
140002881:     	movq	%r14, %rcx
140002884:     	movq	0x68(%rcx), %rcx
140002888:     	testq	%rcx, %rcx
14000288b:     	je	0x1400028aa <.text+0x18aa>
14000288d:     	leaq	0x28(%rsp), %r8
140002892:     	leaq	0x20(%rsp), %r9
140002897:     	movl	%esi, %edx
140002899:     	callq	0x140002710 <.text+0x1710>
14000289e:     	vaddsd	0x28(%rsp), %xmm7, %xmm7
1400028a4:     	vaddsd	0x20(%rsp), %xmm6, %xmm6
1400028aa:     	movq	%rbx, %r9
1400028ad:     	vmovsd	%xmm7, (%rdi)
1400028b1:     	vmovsd	%xmm6, (%r9)
1400028b6:     	vmovaps	0x30(%rsp), %xmm6
1400028bc:     	vmovaps	0x40(%rsp), %xmm7
1400028c2:     	addq	$0x58, %rsp
1400028c6:     	popq	%rbx
1400028c7:     	popq	%rdi
1400028c8:     	popq	%rsi
1400028c9:     	popq	%r14
1400028cb:     	retq
1400028cc:     	movl	%edx, %esi
1400028ce:     	vxorpd	%xmm7, %xmm7, %xmm7
1400028d2:     	vxorpd	%xmm6, %xmm6, %xmm6
1400028d6:     	movq	0x58(%rcx), %rax
1400028da:     	testq	%rax, %rax
1400028dd:     	jne	0x140002835 <.text+0x1835>
1400028e3:     	jmp	0x140002858 <.text+0x1858>
1400028e8:     	nopl	(%rax,%rax)
