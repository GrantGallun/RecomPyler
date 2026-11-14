# Existing measured PE, c force-fields: [0x140002750, 0x140002790)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
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
