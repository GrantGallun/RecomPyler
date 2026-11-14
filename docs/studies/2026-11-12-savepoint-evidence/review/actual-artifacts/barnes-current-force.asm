# barnes-current force: [0x180002c30, 0x180003260)
# Source/call-target-bound static range; counts include padding, never cycles.
180002c30:     	pushq	%r15
180002c32:     	pushq	%r14
180002c34:     	pushq	%r13
180002c36:     	pushq	%r12
180002c38:     	pushq	%rsi
180002c39:     	pushq	%rdi
180002c3a:     	pushq	%rbp
180002c3b:     	pushq	%rbx
180002c3c:     	subq	$0x118, %rsp            # imm = 0x118
180002c43:     	movapd	%xmm8, 0x100(%rsp)
180002c4d:     	movapd	%xmm7, 0xf0(%rsp)
180002c56:     	movapd	%xmm6, 0xe0(%rsp)
180002c5f:     	movq	0x198(%rsp), %r15
180002c67:     	movq	$0x0, 0x60(%rsp)
180002c70:     	movb	$0x0, 0x68(%rsp)
180002c75:     	movq	$0x0, 0x70(%rsp)
180002c7e:     	movsd	0x48(%r8,%r15,8), %xmm0
180002c85:     	xorpd	%xmm1, %xmm1
180002c89:     	ucomisd	%xmm1, %xmm0
180002c8d:     	jne	0x180002ca6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x736>
180002c8f:     	jp	0x180002ca6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x736>
180002c91:     	movb	$0x1, 0x18(%rcx)
180002c95:     	movq	$0x0, 0x10(%rcx)
180002c9d:     	movb	$0x1, 0x8(%rcx)
180002ca1:     	jmp	0x180002eb4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x944>
180002ca6:     	movq	0x1a0(%rsp), %rdi
180002cae:     	movq	0x190(%rsp), %r14
180002cb6:     	movq	0x30(%r9,%r15,8), %rax
180002cbb:     	movq	%rax, %r10
180002cbe:     	sarq	$0x3f, %r10
180002cc2:     	andq	%r14, %r10
180002cc5:     	leaq	(%r9,%rax,8), %rdx
180002cc9:     	cmpq	$0x1, (%rdx,%r10,8)
180002cce:     	jne	0x180002cf1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x781>
180002cd0:     	xorl	%r10d, %r10d
180002cd3:     	cmpq	$-0x2, %rax
180002cd7:     	cmovlq	%r14, %r10
180002cdb:     	movq	0x10(%rdx,%r10,8), %rax
180002ce0:     	leaq	(%r9,%rax,8), %rdx
180002ce4:     	sarq	$0x3f, %rax
180002ce8:     	andq	%r14, %rax
180002ceb:     	cmpq	%rdi, (%rdx,%rax,8)
180002cef:     	je	0x180002c91 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x721>
180002cf1:     	movq	0x188(%rsp), %rbx
180002cf9:     	movq	0x180(%rsp), %rsi
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
180002e1d:     	cmpq	$0x0, 0x18(%r9,%r15,8)
180002e23:     	je	0x180002e71 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x901>
180002e25:     	xorpd	%xmm5, %xmm5
180002e29:     	ucomisd	%xmm5, %xmm3
180002e2d:     	jne	0x180002e4b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8db>
180002e2f:     	jp	0x180002e4b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8db>
180002e31:     	movb	$0x1, (%rbx)
180002e34:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180002e3c:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e3e:     	movb	$0x1, (%rbx)
180002e41:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180002e49:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e4b:     	movsd	0x1a8(%rsp), %xmm6
180002e54:     	movq	(%r9,%r15,8), %rax
180002e58:     	movsd	0x8(%r8,%rax,8), %xmm3
180002e5f:     	addsd	%xmm3, %xmm3
180002e63:     	divsd	%xmm4, %xmm3
180002e67:     	ucomisd	%xmm3, %xmm6
180002e6b:     	jbe	0x180002f24 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x9b4>
180002e71:     	movsd	0x755f(%rip), %xmm3     # 0x18000a3d8
180002e79:     	maxsd	%xmm4, %xmm3
180002e7d:     	movapd	%xmm3, %xmm4
180002e81:     	mulsd	%xmm3, %xmm4
180002e85:     	xorpd	%xmm5, %xmm5
180002e89:     	ucomisd	%xmm5, %xmm4
180002e8d:     	jne	0x180002eea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x97a>
180002e8f:     	jp	0x180002eea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x97a>
180002e91:     	movb	$0x1, (%rbx)
180002e94:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180002e9c:     	movq	$0x0, 0x18(%rcx)
180002ea4:     	movq	$0x0, 0x10(%rcx)
180002eac:     	movq	$0x0, 0x8(%rcx)
180002eb4:     	movq	$0x0, (%rcx)
180002ebb:     	xorl	%eax, %eax
180002ebd:     	movaps	0xe0(%rsp), %xmm6
180002ec5:     	movaps	0xf0(%rsp), %xmm7
180002ecd:     	movaps	0x100(%rsp), %xmm8
180002ed6:     	addq	$0x118, %rsp            # imm = 0x118
180002edd:     	popq	%rbx
180002ede:     	popq	%rbp
180002edf:     	popq	%rdi
180002ee0:     	popq	%rsi
180002ee1:     	popq	%r12
180002ee3:     	popq	%r13
180002ee5:     	popq	%r14
180002ee7:     	popq	%r15
180002ee9:     	retq
180002eea:     	movsd	0x8(%r8,%rdi,8), %xmm5
180002ef1:     	mulsd	0x74e7(%rip), %xmm5     # 0x18000a3e0
180002ef9:     	mulsd	%xmm5, %xmm0
180002efd:     	divsd	%xmm4, %xmm0
180002f01:     	mulsd	%xmm0, %xmm1
180002f05:     	divsd	%xmm3, %xmm1
180002f09:     	mulsd	%xmm0, %xmm2
180002f0d:     	divsd	%xmm3, %xmm2
180002f11:     	movsd	%xmm2, 0x10(%rcx)
180002f16:     	movsd	%xmm1, (%rcx)
180002f1a:     	movb	$0x0, 0x18(%rcx)
180002f1e:     	movb	$0x0, 0x8(%rcx)
180002f22:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180002f24:     	movq	0x20(%r9,%r15,8), %rax
180002f29:     	testq	%rax, %rax
180002f2c:     	js	0x180002fc9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xa59>
180002f32:     	movq	0x8(%rsi), %rdx
180002f36:     	leaq	0x1(%rdx), %r10
180002f3a:     	movq	%r10, 0x8(%rsi)
180002f3e:     	cmpq	0x10(%rsi), %rdx
180002f42:     	jge	0x180003113 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xba3>
180002f48:     	movq	%rcx, %r13
180002f4b:     	movsd	%xmm6, 0x48(%rsp)
180002f51:     	movq	%rdi, 0x40(%rsp)
180002f56:     	movq	%rax, 0x38(%rsp)
180002f5b:     	movq	%r14, 0x30(%rsp)
180002f60:     	movq	%rbx, 0x28(%rsp)
180002f65:     	movq	%rsi, 0x20(%rsp)
180002f6a:     	leaq	0xc0(%rsp), %rcx
180002f72:     	movq	%r8, %r12
180002f75:     	movq	%r9, %rbp
180002f78:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
180002f7d:     	cmpb	$0x0, (%rbx)
180002f80:     	jne	0x1800030ee <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb7e>
180002f86:     	cmpb	$0x0, 0xd8(%rsp)
180002f8e:     	setne	%dl
180002f91:     	cmpb	$0x0, 0xc8(%rsp)
180002f99:     	setne	%r11b
180002f9d:     	xorpd	%xmm8, %xmm8
180002fa2:     	movsd	0xc0(%rsp), %xmm7
180002fab:     	addsd	%xmm8, %xmm7
180002fb0:     	addsd	0xd0(%rsp), %xmm8
180002fba:     	decq	0x8(%rsi)
180002fbe:     	movq	%r13, %rcx
180002fc1:     	movq	%r12, %r8
180002fc4:     	movq	%rbp, %r9
180002fc7:     	jmp	0x180002fd7 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xa67>
180002fc9:     	movb	$0x1, %r11b
180002fcc:     	xorpd	%xmm7, %xmm7
180002fd0:     	xorpd	%xmm8, %xmm8
180002fd5:     	movb	$0x1, %dl
180002fd7:     	movq	0x28(%r9,%r15,8), %rax
180002fdc:     	testq	%rax, %rax
180002fdf:     	js	0x180003087 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb17>
180002fe5:     	movl	%edx, %ebp
180002fe7:     	movq	0x8(%rsi), %rdx
180002feb:     	leaq	0x1(%rdx), %r10
180002fef:     	movq	%r10, 0x8(%rsi)
180002ff3:     	cmpq	0x10(%rsi), %rdx
180002ff7:     	jge	0x180003123 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbb3>
180002ffd:     	movb	%r11b, 0x57(%rsp)
180003002:     	movq	%rcx, %r13
180003005:     	movsd	%xmm6, 0x48(%rsp)
18000300b:     	movq	%rdi, 0x40(%rsp)
180003010:     	movq	%rax, 0x38(%rsp)
180003015:     	movq	%r14, 0x30(%rsp)
18000301a:     	movq	%rbx, 0x28(%rsp)
18000301f:     	movq	%rsi, 0x20(%rsp)
180003024:     	leaq	0xa0(%rsp), %rcx
18000302c:     	movq	%r8, 0x58(%rsp)
180003031:     	movq	%r9, %r12
180003034:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
180003039:     	cmpb	$0x0, (%rbx)
18000303c:     	jne	0x1800030ee <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb7e>
180003042:     	cmpb	$0x0, 0xb8(%rsp)
18000304a:     	setne	%al
18000304d:     	cmpb	$0x0, 0xa8(%rsp)
180003055:     	setne	%cl
180003058:     	addsd	0xa0(%rsp), %xmm7
180003061:     	addsd	0xb0(%rsp), %xmm8
18000306b:     	decq	0x8(%rsi)
18000306f:     	movzbl	0x57(%rsp), %r11d
180003075:     	andb	%cl, %r11b
180003078:     	movl	%ebp, %edx
18000307a:     	andb	%al, %dl
18000307c:     	movq	%r13, %rcx
18000307f:     	movq	0x58(%rsp), %r8
180003084:     	movq	%r12, %r9
180003087:     	movq	0x38(%r9,%r15,8), %rax
18000308c:     	testq	%rax, %rax
18000308f:     	js	0x180003188 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xc18>
180003095:     	movl	%edx, %ebp
180003097:     	movq	0x8(%rsi), %rdx
18000309b:     	leaq	0x1(%rdx), %r10
18000309f:     	movq	%r10, 0x8(%rsi)
1800030a3:     	cmpq	0x10(%rsi), %rdx
1800030a7:     	jge	0x180003133 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbc3>
1800030ad:     	movb	%r11b, 0x57(%rsp)
1800030b2:     	movq	%rcx, %r13
1800030b5:     	movsd	%xmm6, 0x48(%rsp)
1800030bb:     	movq	%rdi, 0x40(%rsp)
1800030c0:     	movq	%rax, 0x38(%rsp)
1800030c5:     	movq	%r14, 0x30(%rsp)
1800030ca:     	movq	%rbx, 0x28(%rsp)
1800030cf:     	movq	%rsi, 0x20(%rsp)
1800030d4:     	leaq	0x80(%rsp), %rcx
1800030dc:     	movq	%r8, 0x58(%rsp)
1800030e1:     	movq	%r9, %r12
1800030e4:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
1800030e9:     	cmpb	$0x0, (%rbx)
1800030ec:     	je	0x180003143 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbd3>
1800030ee:     	movq	$0x0, 0x18(%r13)
1800030f6:     	movq	$0x0, 0x10(%r13)
1800030fe:     	movq	$0x0, 0x8(%r13)
180003106:     	movq	$0x0, (%r13)
18000310e:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180003113:     	movb	$0x1, (%rbx)
180003116:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
18000311e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003123:     	movb	$0x1, (%rbx)
180003126:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
18000312e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003133:     	movb	$0x1, (%rbx)
180003136:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
18000313e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003143:     	cmpb	$0x0, 0x98(%rsp)
18000314b:     	setne	%al
18000314e:     	cmpb	$0x0, 0x88(%rsp)
180003156:     	setne	%cl
180003159:     	addsd	0x80(%rsp), %xmm7
180003162:     	addsd	0x90(%rsp), %xmm8
18000316c:     	decq	0x8(%rsi)
180003170:     	movzbl	0x57(%rsp), %r11d
180003176:     	andb	%cl, %r11b
180003179:     	movl	%ebp, %edx
18000317b:     	andb	%al, %dl
18000317d:     	movq	%r13, %rcx
180003180:     	movq	0x58(%rsp), %r8
180003185:     	movq	%r12, %r9
180003188:     	movq	0x40(%r9,%r15,8), %rax
18000318d:     	testq	%rax, %rax
180003190:     	js	0x180003242 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcd2>
180003196:     	movl	%edx, %r12d
180003199:     	movq	0x8(%rsi), %rdx
18000319d:     	leaq	0x1(%rdx), %r10
1800031a1:     	movq	%r10, 0x8(%rsi)
1800031a5:     	cmpq	0x10(%rsi), %rdx
1800031a9:     	jge	0x180003203 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xc93>
1800031ab:     	movl	%r11d, %ebp
1800031ae:     	movq	%rcx, %r15
1800031b1:     	movsd	%xmm6, 0x48(%rsp)
1800031b7:     	movq	%rdi, 0x40(%rsp)
1800031bc:     	movq	%rax, 0x38(%rsp)
1800031c1:     	movq	%r14, 0x30(%rsp)
1800031c6:     	movq	%rbx, 0x28(%rsp)
1800031cb:     	movq	%rsi, 0x20(%rsp)
1800031d0:     	leaq	0x60(%rsp), %rcx
1800031d5:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
1800031da:     	cmpb	$0x0, (%rbx)
1800031dd:     	je	0x180003213 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xca3>
1800031df:     	movq	$0x0, 0x18(%r15)
1800031e7:     	movq	$0x0, 0x10(%r15)
1800031ef:     	movq	$0x0, 0x8(%r15)
1800031f7:     	movq	$0x0, (%r15)
1800031fe:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180003203:     	movb	$0x1, (%rbx)
180003206:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
18000320e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003213:     	cmpb	$0x0, 0x78(%rsp)
180003218:     	setne	%al
18000321b:     	cmpb	$0x0, 0x68(%rsp)
180003220:     	setne	%cl
180003223:     	addsd	0x60(%rsp), %xmm7
180003229:     	addsd	0x70(%rsp), %xmm8
180003230:     	decq	0x8(%rsi)
180003234:     	movl	%ebp, %r11d
180003237:     	andb	%cl, %r11b
18000323a:     	movl	%r12d, %edx
18000323d:     	andb	%al, %dl
18000323f:     	movq	%r15, %rcx
180003242:     	movb	%dl, 0x18(%rcx)
180003245:     	movsd	%xmm8, 0x10(%rcx)
18000324b:     	movb	%r11b, 0x8(%rcx)
18000324f:     	movsd	%xmm7, (%rcx)
180003253:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180003258:     	nopl	(%rax,%rax)
