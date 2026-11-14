# C RGB clamp/store context; different layout/bounds contract, not a matched-count block.
1400019ca:     	vmulsd	0xa8(%rsp), %xmm9, %xmm0
1400019d3:     	vmulsd	0xb0(%rsp), %xmm9, %xmm2
1400019dc:     	vmulsd	0xb8(%rsp), %xmm9, %xmm1
1400019e5:     	vmovapd	%xmm7, %xmm22
1400019eb:     	vcvttsd2si	%xmm0, %eax
1400019ef:     	movl	%eax, %ecx
1400019f1:     	sarl	$0x1f, %ecx
1400019f4:     	andnl	%eax, %ecx, %eax
1400019f9:     	cmpl	$0xff, %eax
1400019fe:     	cmovgel	%r13d, %eax
140001a02:     	movb	%al, -0x2(%rdi)
140001a05:     	vcvttsd2si	%xmm2, %eax
140001a09:     	movl	%eax, %ecx
140001a0b:     	sarl	$0x1f, %ecx
140001a0e:     	andnl	%eax, %ecx, %eax
140001a13:     	cmpl	$0xff, %eax
140001a18:     	cmovgel	%r13d, %eax
140001a1c:     	movb	%al, -0x1(%rdi)
140001a1f:     	vcvttsd2si	%xmm1, %eax
140001a23:     	movl	%eax, %ecx
140001a25:     	sarl	$0x1f, %ecx
140001a28:     	andnl	%eax, %ecx, %eax
140001a2d:     	cmpl	$0xff, %eax
140001a32:     	cmovgel	%r13d, %eax
140001a36:     	incq	%rsi
140001a39:     	movb	%al, (%rdi)
