# candidate fields: [0x180002d01, 0x180002e1d)
# Source/call-target inferred range, possibly including padding; static evidence, not cycles.
180002d01:     	movq	0x10(%r9,%r15,8), %r10
180002d06:     	movsd	(%r8,%r10,8), %xmm1
180002d0c:     	cmpq	$0x0, 0x8(%r9,%r10,8)
180002d12:     	setne	%r11b
180002d16:     	movq	0x10(%r9,%rdi,8), %rdx
180002d1b:     	cmpq	$0x0, 0x8(%r9,%rdx,8)
180002d21:     	setne	%al
180002d24:     	subsd	(%r8,%rdx,8), %xmm1
180002d2a:     	andb	%r11b, %al
180002d2d:     	cmpb	$0x1, %al
180002d2f:     	jne	0x180002d53 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x7e3>
180002d31:     	movapd	0x7687(%rip), %xmm2     # 0x18000a3c0
180002d39:     	andpd	%xmm1, %xmm2
180002d3d:     	ucomisd	0x768b(%rip), %xmm2     # 0x18000a3d0
180002d45:     	jae	0x180002dfa <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x88a>
180002d4b:     	xorpd	%xmm2, %xmm2
180002d4f:     	addsd	%xmm2, %xmm1
180002d53:     	movsd	0x10(%r8,%r10,8), %xmm2
180002d5a:     	cmpq	$0x0, 0x18(%r9,%r10,8)
180002d60:     	subsd	0x10(%r8,%rdx,8), %xmm2
180002d67:     	je	0x180002dd1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x861>
180002d69:     	cmpq	$0x0, 0x18(%r9,%rdx,8)
180002d6f:     	je	0x180002dd1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x861>
180002d71:     	movapd	0x7647(%rip), %xmm3     # 0x18000a3c0
180002d79:     	andpd	%xmm2, %xmm3
180002d7d:     	ucomisd	0x764b(%rip), %xmm3     # 0x18000a3d0
180002d85:     	jae	0x180002e3e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8ce>
180002d8b:     	movapd	%xmm1, %xmm3
180002d8f:     	mulsd	%xmm1, %xmm3
180002d93:     	ucomisd	0x7635(%rip), %xmm3     # 0x18000a3d0
180002d9b:     	setae	%dl
180002d9e:     	testb	%dl, %al
180002da0:     	jne	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002da2:     	xorpd	%xmm4, %xmm4
180002da6:     	addsd	%xmm4, %xmm2
180002daa:     	movapd	%xmm2, %xmm4
180002dae:     	mulsd	%xmm2, %xmm4
180002db2:     	ucomisd	0x7616(%rip), %xmm4     # 0x18000a3d0
180002dba:     	jae	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002dbc:     	addsd	%xmm4, %xmm3
180002dc0:     	ucomisd	0x7608(%rip), %xmm3     # 0x18000a3d0
180002dc8:     	setae	%dl
180002dcb:     	testb	%dl, %al
180002dcd:     	jne	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002dcf:     	jmp	0x180002e16 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8a6>
180002dd1:     	movapd	%xmm1, %xmm3
180002dd5:     	mulsd	%xmm1, %xmm3
180002dd9:     	ucomisd	0x75ef(%rip), %xmm3     # 0x18000a3d0
180002de1:     	setae	%dl
180002de4:     	andb	%dl, %al
180002de6:     	cmpb	$0x1, %al
180002de8:     	jne	0x180002e0a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x89a>
180002dea:     	movb	$0x1, (%rbx)
180002ded:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180002df5:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002dfa:     	movb	$0x1, (%rbx)
180002dfd:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180002e05:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e0a:     	movapd	%xmm2, %xmm4
180002e0e:     	mulsd	%xmm2, %xmm4
180002e12:     	addsd	%xmm4, %xmm3
180002e16:     	xorps	%xmm4, %xmm4
180002e19:     	sqrtsd	%xmm3, %xmm4
