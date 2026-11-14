# Existing measured PE, candidate force-fields: [0x180003d2a, 0x180003d7b)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
180003d2a:     	movq	0x10(%r14,%r13,8), %r10
180003d2f:     	movsd	(%rbx,%r10,8), %xmm1
180003d35:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003d3b:     	setne	%r11b
180003d3f:     	movq	0x10(%r14,%r12,8), %rdx
180003d44:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d4a:     	setne	%al
180003d4d:     	subsd	(%rbx,%rdx,8), %xmm1
180003d52:     	andb	%r11b, %al
180003d55:     	cmpb	$0x1, %al
180003d57:     	jne	0x180003d7b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1bb>
180003d59:     	movapd	0x965f(%rip), %xmm2     # 0x18000d3c0
180003d61:     	andpd	%xmm1, %xmm2
180003d65:     	ucomisd	0x9663(%rip), %xmm2     # 0x18000d3d0
180003d6d:     	jae	0x180003e21 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x261>
180003d73:     	xorpd	%xmm2, %xmm2
180003d77:     	addsd	%xmm2, %xmm1
