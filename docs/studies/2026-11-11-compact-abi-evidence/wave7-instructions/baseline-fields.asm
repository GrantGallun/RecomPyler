# baseline fields: [0x180003d2a, 0x180003e44)
# Source/call-target inferred range, possibly including padding; static evidence, not cycles.
180003d2a:     	movq	0x10(%r14,%r13,8), %r10
180003d2f:     	movsd	(%rdi,%r10,8), %xmm1
180003d35:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003d3b:     	setne	%r11b
180003d3f:     	movq	0x10(%r14,%r12,8), %rdx
180003d44:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d4a:     	setne	%al
180003d4d:     	subsd	(%rdi,%rdx,8), %xmm1
180003d52:     	andb	%r11b, %al
180003d55:     	cmpb	$0x1, %al
180003d57:     	jne	0x180003d7b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1bb>
180003d59:     	movapd	0x965f(%rip), %xmm2     # 0x18000d3c0
180003d61:     	andpd	%xmm1, %xmm2
180003d65:     	ucomisd	0x9663(%rip), %xmm2     # 0x18000d3d0
180003d6d:     	jae	0x180003e21 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x261>
180003d73:     	xorpd	%xmm2, %xmm2
180003d77:     	addsd	%xmm2, %xmm1
180003d7b:     	movsd	0x10(%rdi,%r10,8), %xmm2
180003d82:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d88:     	subsd	0x10(%rdi,%rdx,8), %xmm2
180003d8e:     	je	0x180003df8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x238>
180003d90:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d96:     	je	0x180003df8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x238>
180003d98:     	movapd	0x9620(%rip), %xmm3     # 0x18000d3c0
180003da0:     	andpd	%xmm2, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	jae	0x180003e65 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2a5>
180003db2:     	movapd	%xmm1, %xmm3
180003db6:     	mulsd	%xmm1, %xmm3
180003dba:     	ucomisd	0x960e(%rip), %xmm3     # 0x18000d3d0
180003dc2:     	setae	%dl
180003dc5:     	testb	%dl, %al
180003dc7:     	jne	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003dc9:     	xorpd	%xmm4, %xmm4
180003dcd:     	addsd	%xmm4, %xmm2
180003dd1:     	movapd	%xmm2, %xmm4
180003dd5:     	mulsd	%xmm2, %xmm4
180003dd9:     	ucomisd	0x95ef(%rip), %xmm4     # 0x18000d3d0
180003de1:     	jae	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003de3:     	addsd	%xmm4, %xmm3
180003de7:     	ucomisd	0x95e1(%rip), %xmm3     # 0x18000d3d0
180003def:     	setae	%dl
180003df2:     	testb	%dl, %al
180003df4:     	jne	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003df6:     	jmp	0x180003e3d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x27d>
180003df8:     	movapd	%xmm1, %xmm3
180003dfc:     	mulsd	%xmm1, %xmm3
180003e00:     	ucomisd	0x95c8(%rip), %xmm3     # 0x18000d3d0
180003e08:     	setae	%dl
180003e0b:     	andb	%dl, %al
180003e0d:     	cmpb	$0x1, %al
180003e0f:     	jne	0x180003e31 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x271>
180003e11:     	movb	$0x1, (%rbx)
180003e14:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003e1c:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e21:     	movb	$0x1, (%rbx)
180003e24:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003e2c:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e31:     	movapd	%xmm2, %xmm4
180003e35:     	mulsd	%xmm2, %xmm4
180003e39:     	addsd	%xmm4, %xmm3
180003e3d:     	xorps	%xmm4, %xmm4
180003e40:     	sqrtsd	%xmm3, %xmm4
