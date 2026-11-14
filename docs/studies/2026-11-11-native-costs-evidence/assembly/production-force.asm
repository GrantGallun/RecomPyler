# production force: [0x180003c20, 0x180004870)
# Source/call-target inferred range; padding may be included. Static evidence, not cycles.
180003c20:     	pushq	%r15
180003c22:     	pushq	%r14
180003c24:     	pushq	%r13
180003c26:     	pushq	%r12
180003c28:     	pushq	%rsi
180003c29:     	pushq	%rdi
180003c2a:     	pushq	%rbp
180003c2b:     	pushq	%rbx
180003c2c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180003c33:     	movapd	%xmm8, 0x1d0(%rsp)
180003c3d:     	movapd	%xmm7, 0x1c0(%rsp)
180003c46:     	movapd	%xmm6, 0x1b0(%rsp)
180003c4f:     	movq	0x320(%rsp), %r13
180003c57:     	movq	0x260(%rsp), %rdi
180003c5f:     	movq	$0x0, 0x150(%rsp)
180003c6b:     	movb	$0x0, 0x158(%rsp)
180003c73:     	movq	$0x0, 0x160(%rsp)
180003c7f:     	movq	$0x0, 0x130(%rsp)
180003c8b:     	movb	$0x0, 0x138(%rsp)
180003c93:     	movq	$0x0, 0x140(%rsp)
180003c9f:     	movsd	0x48(%rdi,%r13,8), %xmm0
180003ca6:     	xorpd	%xmm1, %xmm1
180003caa:     	ucomisd	%xmm1, %xmm0
180003cae:     	jne	0x180003cc7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x107>
180003cb0:     	jp	0x180003cc7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x107>
180003cb2:     	movb	$0x1, 0x18(%rcx)
180003cb6:     	movq	$0x0, 0x10(%rcx)
180003cbe:     	movb	$0x1, 0x8(%rcx)
180003cc2:     	jmp	0x180003eda <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x31a>
180003cc7:     	movq	0x328(%rsp), %r12
180003ccf:     	movq	0x2a0(%rsp), %r15
180003cd7:     	movq	0x298(%rsp), %r14
180003cdf:     	movq	0x30(%r14,%r13,8), %rax
180003ce4:     	movq	%rax, %r10
180003ce7:     	sarq	$0x3f, %r10
180003ceb:     	andq	%r15, %r10
180003cee:     	leaq	(%r14,%rax,8), %rdx
180003cf2:     	cmpq	$0x1, (%rdx,%r10,8)
180003cf7:     	jne	0x180003d1a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x15a>
180003cf9:     	xorl	%r10d, %r10d
180003cfc:     	cmpq	$-0x2, %rax
180003d00:     	cmovlq	%r15, %r10
180003d04:     	movq	0x10(%rdx,%r10,8), %rax
180003d09:     	leaq	(%r14,%rax,8), %rdx
180003d0d:     	sarq	$0x3f, %rax
180003d11:     	andq	%r15, %rax
180003d14:     	cmpq	%r12, (%rdx,%rax,8)
180003d18:     	je	0x180003cb2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xf2>
180003d1a:     	movq	0x308(%rsp), %rbx
180003d22:     	movq	0x2d0(%rsp), %rsi
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
180003e44:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e4a:     	je	0x180003e97 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d7>
180003e4c:     	xorpd	%xmm5, %xmm5
180003e50:     	ucomisd	%xmm5, %xmm3
180003e54:     	jne	0x180003e72 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2b2>
180003e56:     	jp	0x180003e72 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2b2>
180003e58:     	movb	$0x1, (%rbx)
180003e5b:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e63:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e65:     	movb	$0x1, (%rbx)
180003e68:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e70:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e72:     	movsd	0x330(%rsp), %xmm6
180003e7b:     	movq	(%r14,%r13,8), %rax
180003e7f:     	movsd	0x8(%rdi,%rax,8), %xmm3
180003e85:     	addsd	%xmm3, %xmm3
180003e89:     	divsd	%xmm4, %xmm3
180003e8d:     	ucomisd	%xmm3, %xmm6
180003e91:     	jbe	0x180003f4a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38a>
180003e97:     	movsd	0x9539(%rip), %xmm3     # 0x18000d3d8
180003e9f:     	maxsd	%xmm4, %xmm3
180003ea3:     	movapd	%xmm3, %xmm4
180003ea7:     	mulsd	%xmm3, %xmm4
180003eab:     	xorpd	%xmm5, %xmm5
180003eaf:     	ucomisd	%xmm5, %xmm4
180003eb3:     	jne	0x180003f10 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x350>
180003eb5:     	jp	0x180003f10 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x350>
180003eb7:     	movb	$0x1, (%rbx)
180003eba:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180003ec2:     	movq	$0x0, 0x18(%rcx)
180003eca:     	movq	$0x0, 0x10(%rcx)
180003ed2:     	movq	$0x0, 0x8(%rcx)
180003eda:     	movq	$0x0, (%rcx)
180003ee1:     	xorl	%eax, %eax
180003ee3:     	movaps	0x1b0(%rsp), %xmm6
180003eeb:     	movaps	0x1c0(%rsp), %xmm7
180003ef3:     	movaps	0x1d0(%rsp), %xmm8
180003efc:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180003f03:     	popq	%rbx
180003f04:     	popq	%rbp
180003f05:     	popq	%rdi
180003f06:     	popq	%rsi
180003f07:     	popq	%r12
180003f09:     	popq	%r13
180003f0b:     	popq	%r14
180003f0d:     	popq	%r15
180003f0f:     	retq
180003f10:     	movsd	0x8(%rdi,%r12,8), %xmm5
180003f17:     	mulsd	0x94c1(%rip), %xmm5     # 0x18000d3e0
180003f1f:     	mulsd	%xmm5, %xmm0
180003f23:     	divsd	%xmm4, %xmm0
180003f27:     	mulsd	%xmm0, %xmm1
180003f2b:     	divsd	%xmm3, %xmm1
180003f2f:     	mulsd	%xmm0, %xmm2
180003f33:     	divsd	%xmm3, %xmm2
180003f37:     	movsd	%xmm2, 0x10(%rcx)
180003f3c:     	movsd	%xmm1, (%rcx)
180003f40:     	movb	$0x0, 0x18(%rcx)
180003f44:     	movb	$0x0, 0x8(%rcx)
180003f48:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180003f4a:     	movq	0x318(%rsp), %rdx
180003f52:     	movq	0x2e0(%rsp), %rbp
180003f5a:     	movq	0x2c8(%rsp), %r11
180003f62:     	movq	0x20(%r14,%r13,8), %rax
180003f67:     	testq	%rax, %rax
180003f6a:     	js	0x180004176 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b6>
180003f70:     	movq	0x8(%rsi), %rdx
180003f74:     	leaq	0x1(%rdx), %r10
180003f78:     	movq	%r10, 0x8(%rsi)
180003f7c:     	cmpq	0x10(%rsi), %rdx
180003f80:     	jge	0x180004588 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9c8>
180003f86:     	movq	%rcx, 0x118(%rsp)
180003f8e:     	movsd	%xmm6, 0x100(%rsp)
180003f97:     	movq	%r12, 0xf8(%rsp)
180003f9f:     	movq	%rax, 0xf0(%rsp)
180003fa7:     	movq	0x318(%rsp), %rax
180003faf:     	movq	%rax, 0xe8(%rsp)
180003fb7:     	movq	0x310(%rsp), %rax
180003fbf:     	movq	%rax, 0xe0(%rsp)
180003fc7:     	movq	%rbx, 0xd8(%rsp)
180003fcf:     	movq	0x300(%rsp), %rax
180003fd7:     	movq	%rax, 0xd0(%rsp)
180003fdf:     	movq	0x2f8(%rsp), %rax
180003fe7:     	movq	%rax, 0xc8(%rsp)
180003fef:     	movq	0x2f0(%rsp), %rax
180003ff7:     	movq	%rax, 0xc0(%rsp)
180003fff:     	movq	0x2e8(%rsp), %rax
180004007:     	movq	%rax, 0xb8(%rsp)
18000400f:     	movq	%rbp, 0xb0(%rsp)
180004017:     	movq	0x2d8(%rsp), %rax
18000401f:     	movq	%rax, 0xa8(%rsp)
180004027:     	movq	%rsi, 0xa0(%rsp)
18000402f:     	movq	%r11, 0x98(%rsp)
180004037:     	movq	0x2c0(%rsp), %rax
18000403f:     	movq	%rax, 0x90(%rsp)
180004047:     	movq	0x2b8(%rsp), %rax
18000404f:     	movq	%rax, 0x88(%rsp)
180004057:     	movq	0x2b0(%rsp), %rax
18000405f:     	movq	%rax, 0x80(%rsp)
180004067:     	movq	0x2a8(%rsp), %rax
18000406f:     	movq	%rax, 0x78(%rsp)
180004074:     	movq	%r15, 0x70(%rsp)
180004079:     	movq	%r14, 0x68(%rsp)
18000407e:     	movq	0x290(%rsp), %rax
180004086:     	movq	%rax, 0x60(%rsp)
18000408b:     	movq	0x288(%rsp), %rax
180004093:     	movq	%rax, 0x58(%rsp)
180004098:     	movq	0x280(%rsp), %rax
1800040a0:     	movq	%rax, 0x50(%rsp)
1800040a5:     	movq	0x278(%rsp), %rax
1800040ad:     	movq	%rax, 0x48(%rsp)
1800040b2:     	movq	0x270(%rsp), %rax
1800040ba:     	movq	%rax, 0x40(%rsp)
1800040bf:     	movq	0x268(%rsp), %rax
1800040c7:     	movq	%rax, 0x38(%rsp)
1800040cc:     	movq	%rdi, 0x30(%rsp)
1800040d1:     	movq	0x258(%rsp), %rax
1800040d9:     	movq	%rax, 0x28(%rsp)
1800040de:     	movq	0x250(%rsp), %rax
1800040e6:     	movq	%rax, 0x20(%rsp)
1800040eb:     	leaq	0x190(%rsp), %rcx
1800040f3:     	movq	%r8, 0x120(%rsp)
1800040fb:     	movq	%r9, %rbp
1800040fe:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004103:     	cmpb	$0x0, (%rbx)
180004106:     	jne	0x18000455c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x99c>
18000410c:     	cmpb	$0x0, 0x1a8(%rsp)
180004114:     	setne	0x117(%rsp)
18000411c:     	cmpb	$0x0, 0x198(%rsp)
180004124:     	setne	%r10b
180004128:     	xorpd	%xmm8, %xmm8
18000412d:     	movsd	0x190(%rsp), %xmm7
180004136:     	addsd	%xmm8, %xmm7
18000413b:     	addsd	0x1a0(%rsp), %xmm8
180004145:     	decq	0x8(%rsi)
180004149:     	movq	0x118(%rsp), %rcx
180004151:     	movq	%rbp, %r9
180004154:     	movq	0x120(%rsp), %r8
18000415c:     	movq	0x2c8(%rsp), %r11
180004164:     	movq	0x2e0(%rsp), %rbp
18000416c:     	movq	0x318(%rsp), %rdx
180004174:     	jmp	0x18000418a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ca>
180004176:     	movb	$0x1, %r10b
180004179:     	xorpd	%xmm7, %xmm7
18000417d:     	xorpd	%xmm8, %xmm8
180004182:     	movb	$0x1, 0x117(%rsp)
18000418a:     	movq	0x28(%r14,%r13,8), %rax
18000418f:     	testq	%rax, %rax
180004192:     	js	0x1800043a9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7e9>
180004198:     	movb	%r10b, 0x116(%rsp)
1800041a0:     	movq	0x8(%rsi), %rdx
1800041a4:     	leaq	0x1(%rdx), %r10
1800041a8:     	movq	%r10, 0x8(%rsi)
1800041ac:     	cmpq	0x10(%rsi), %rdx
1800041b0:     	jge	0x180004598 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9d8>
1800041b6:     	movq	%rcx, 0x118(%rsp)
1800041be:     	movsd	%xmm6, 0x100(%rsp)
1800041c7:     	movq	%r12, 0xf8(%rsp)
1800041cf:     	movq	%rax, 0xf0(%rsp)
1800041d7:     	movq	0x318(%rsp), %rax
1800041df:     	movq	%rax, 0xe8(%rsp)
1800041e7:     	movq	0x310(%rsp), %rax
1800041ef:     	movq	%rax, 0xe0(%rsp)
1800041f7:     	movq	%rbx, 0xd8(%rsp)
1800041ff:     	movq	0x300(%rsp), %rax
180004207:     	movq	%rax, 0xd0(%rsp)
18000420f:     	movq	0x2f8(%rsp), %rax
180004217:     	movq	%rax, 0xc8(%rsp)
18000421f:     	movq	0x2f0(%rsp), %rax
180004227:     	movq	%rax, 0xc0(%rsp)
18000422f:     	movq	0x2e8(%rsp), %rax
180004237:     	movq	%rax, 0xb8(%rsp)
18000423f:     	movq	%rbp, 0xb0(%rsp)
180004247:     	movq	0x2d8(%rsp), %rax
18000424f:     	movq	%rax, 0xa8(%rsp)
180004257:     	movq	%rsi, 0xa0(%rsp)
18000425f:     	movq	%r11, 0x98(%rsp)
180004267:     	movq	0x2c0(%rsp), %rax
18000426f:     	movq	%rax, 0x90(%rsp)
180004277:     	movq	0x2b8(%rsp), %rax
18000427f:     	movq	%rax, 0x88(%rsp)
180004287:     	movq	0x2b0(%rsp), %rax
18000428f:     	movq	%rax, 0x80(%rsp)
180004297:     	movq	0x2a8(%rsp), %rax
18000429f:     	movq	%rax, 0x78(%rsp)
1800042a4:     	movq	%r15, 0x70(%rsp)
1800042a9:     	movq	%r14, 0x68(%rsp)
1800042ae:     	movq	0x290(%rsp), %rax
1800042b6:     	movq	%rax, 0x60(%rsp)
1800042bb:     	movq	0x288(%rsp), %rax
1800042c3:     	movq	%rax, 0x58(%rsp)
1800042c8:     	movq	0x280(%rsp), %rax
1800042d0:     	movq	%rax, 0x50(%rsp)
1800042d5:     	movq	0x278(%rsp), %rax
1800042dd:     	movq	%rax, 0x48(%rsp)
1800042e2:     	movq	0x270(%rsp), %rax
1800042ea:     	movq	%rax, 0x40(%rsp)
1800042ef:     	movq	0x268(%rsp), %rax
1800042f7:     	movq	%rax, 0x38(%rsp)
1800042fc:     	movq	%rdi, 0x30(%rsp)
180004301:     	movq	0x258(%rsp), %rax
180004309:     	movq	%rax, 0x28(%rsp)
18000430e:     	movq	0x250(%rsp), %rax
180004316:     	movq	%rax, 0x20(%rsp)
18000431b:     	leaq	0x170(%rsp), %rcx
180004323:     	movq	%r8, 0x120(%rsp)
18000432b:     	movq	%r9, 0x128(%rsp)
180004333:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004338:     	cmpb	$0x0, (%rbx)
18000433b:     	jne	0x18000455c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x99c>
180004341:     	cmpb	$0x0, 0x188(%rsp)
180004349:     	setne	%al
18000434c:     	cmpb	$0x0, 0x178(%rsp)
180004354:     	setne	%cl
180004357:     	addsd	0x170(%rsp), %xmm7
180004360:     	addsd	0x180(%rsp), %xmm8
18000436a:     	decq	0x8(%rsi)
18000436e:     	movzbl	0x116(%rsp), %r10d
180004377:     	andb	%cl, %r10b
18000437a:     	andb	%al, 0x117(%rsp)
180004381:     	movq	0x118(%rsp), %rcx
180004389:     	movq	0x128(%rsp), %r9
180004391:     	movq	0x120(%rsp), %r8
180004399:     	movq	0x2c8(%rsp), %r11
1800043a1:     	movq	0x318(%rsp), %rdx
1800043a9:     	movq	0x38(%r14,%r13,8), %rax
1800043ae:     	testq	%rax, %rax
1800043b1:     	js	0x180004620 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xa60>
1800043b7:     	movb	%r10b, 0x116(%rsp)
1800043bf:     	movq	0x8(%rsi), %rdx
1800043c3:     	leaq	0x1(%rdx), %r10
1800043c7:     	movq	%r10, 0x8(%rsi)
1800043cb:     	cmpq	0x10(%rsi), %rdx
1800043cf:     	jge	0x1800045a8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9e8>
1800043d5:     	movq	%rcx, 0x118(%rsp)
1800043dd:     	movsd	%xmm6, 0x100(%rsp)
1800043e6:     	movq	%r12, 0xf8(%rsp)
1800043ee:     	movq	%rax, 0xf0(%rsp)
1800043f6:     	movq	0x318(%rsp), %rax
1800043fe:     	movq	%rax, 0xe8(%rsp)
180004406:     	movq	0x310(%rsp), %rax
18000440e:     	movq	%rax, 0xe0(%rsp)
180004416:     	movq	%rbx, 0xd8(%rsp)
18000441e:     	movq	0x300(%rsp), %rax
180004426:     	movq	%rax, 0xd0(%rsp)
18000442e:     	movq	0x2f8(%rsp), %rax
180004436:     	movq	%rax, 0xc8(%rsp)
18000443e:     	movq	0x2f0(%rsp), %rax
180004446:     	movq	%rax, 0xc0(%rsp)
18000444e:     	movq	0x2e8(%rsp), %rax
180004456:     	movq	%rax, 0xb8(%rsp)
18000445e:     	movq	%rbp, 0xb0(%rsp)
180004466:     	movq	0x2d8(%rsp), %rax
18000446e:     	movq	%rax, 0xa8(%rsp)
180004476:     	movq	%rsi, 0xa0(%rsp)
18000447e:     	movq	%r11, 0x98(%rsp)
180004486:     	movq	0x2c0(%rsp), %rax
18000448e:     	movq	%rax, 0x90(%rsp)
180004496:     	movq	0x2b8(%rsp), %rax
18000449e:     	movq	%rax, 0x88(%rsp)
1800044a6:     	movq	0x2b0(%rsp), %rax
1800044ae:     	movq	%rax, 0x80(%rsp)
1800044b6:     	movq	0x2a8(%rsp), %rax
1800044be:     	movq	%rax, 0x78(%rsp)
1800044c3:     	movq	%r15, 0x70(%rsp)
1800044c8:     	movq	%r14, 0x68(%rsp)
1800044cd:     	movq	0x290(%rsp), %rax
1800044d5:     	movq	%rax, 0x60(%rsp)
1800044da:     	movq	0x288(%rsp), %rax
1800044e2:     	movq	%rax, 0x58(%rsp)
1800044e7:     	movq	0x280(%rsp), %rax
1800044ef:     	movq	%rax, 0x50(%rsp)
1800044f4:     	movq	0x278(%rsp), %rax
1800044fc:     	movq	%rax, 0x48(%rsp)
180004501:     	movq	0x270(%rsp), %rax
180004509:     	movq	%rax, 0x40(%rsp)
18000450e:     	movq	0x268(%rsp), %rax
180004516:     	movq	%rax, 0x38(%rsp)
18000451b:     	movq	%rdi, 0x30(%rsp)
180004520:     	movq	0x258(%rsp), %rax
180004528:     	movq	%rax, 0x28(%rsp)
18000452d:     	movq	0x250(%rsp), %rax
180004535:     	movq	%rax, 0x20(%rsp)
18000453a:     	leaq	0x150(%rsp), %rcx
180004542:     	movq	%r8, 0x120(%rsp)
18000454a:     	movq	%r9, 0x128(%rsp)
180004552:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004557:     	cmpb	$0x0, (%rbx)
18000455a:     	je	0x1800045b8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9f8>
18000455c:     	movq	0x118(%rsp), %rax
180004564:     	movq	$0x0, 0x18(%rax)
18000456c:     	movq	$0x0, 0x10(%rax)
180004574:     	movq	$0x0, 0x8(%rax)
18000457c:     	movq	$0x0, (%rax)
180004583:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180004588:     	movb	$0x1, (%rbx)
18000458b:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004593:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180004598:     	movb	$0x1, (%rbx)
18000459b:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
1800045a3:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
1800045a8:     	movb	$0x1, (%rbx)
1800045ab:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800045b3:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
1800045b8:     	cmpb	$0x0, 0x168(%rsp)
1800045c0:     	setne	%al
1800045c3:     	cmpb	$0x0, 0x158(%rsp)
1800045cb:     	setne	%cl
1800045ce:     	addsd	0x150(%rsp), %xmm7
1800045d7:     	addsd	0x160(%rsp), %xmm8
1800045e1:     	decq	0x8(%rsi)
1800045e5:     	movzbl	0x116(%rsp), %r10d
1800045ee:     	andb	%cl, %r10b
1800045f1:     	andb	%al, 0x117(%rsp)
1800045f8:     	movq	0x118(%rsp), %rcx
180004600:     	movq	0x128(%rsp), %r9
180004608:     	movq	0x120(%rsp), %r8
180004610:     	movq	0x2c8(%rsp), %r11
180004618:     	movq	0x318(%rsp), %rdx
180004620:     	movq	0x40(%r14,%r13,8), %rax
180004625:     	testq	%rax, %rax
180004628:     	js	0x1800047eb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc2b>
18000462e:     	movb	%r10b, 0x116(%rsp)
180004636:     	movq	%rdx, %r13
180004639:     	movq	0x8(%rsi), %rdx
18000463d:     	leaq	0x1(%rdx), %r10
180004641:     	movq	%r10, 0x8(%rsi)
180004645:     	cmpq	0x10(%rsi), %rdx
180004649:     	jge	0x1800047f5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc35>
18000464f:     	movq	%rcx, 0x118(%rsp)
180004657:     	movq	%r12, 0xf8(%rsp)
18000465f:     	movq	%rax, 0xf0(%rsp)
180004667:     	movq	%r13, 0xe8(%rsp)
18000466f:     	movq	0x310(%rsp), %rax
180004677:     	movq	%rax, 0xe0(%rsp)
18000467f:     	movq	0x300(%rsp), %rax
180004687:     	movq	%rax, 0xd0(%rsp)
18000468f:     	movq	0x2f8(%rsp), %rax
180004697:     	movq	%rax, 0xc8(%rsp)
18000469f:     	movq	0x2f0(%rsp), %rax
1800046a7:     	movq	%rax, 0xc0(%rsp)
1800046af:     	movq	0x2e8(%rsp), %rax
1800046b7:     	movq	%rax, 0xb8(%rsp)
1800046bf:     	movq	%rbp, 0xb0(%rsp)
1800046c7:     	movq	0x2d8(%rsp), %rax
1800046cf:     	movq	%rax, 0xa8(%rsp)
1800046d7:     	movq	%r11, 0x98(%rsp)
1800046df:     	movq	0x2c0(%rsp), %rax
1800046e7:     	movq	%rax, 0x90(%rsp)
1800046ef:     	movq	0x2b8(%rsp), %rax
1800046f7:     	movq	%rax, 0x88(%rsp)
1800046ff:     	movq	0x2b0(%rsp), %rax
180004707:     	movq	%rax, 0x80(%rsp)
18000470f:     	movq	0x2a8(%rsp), %rax
180004717:     	movq	%rax, 0x78(%rsp)
18000471c:     	movq	%r15, 0x70(%rsp)
180004721:     	movq	%r14, 0x68(%rsp)
180004726:     	movq	0x290(%rsp), %rax
18000472e:     	movq	%rax, 0x60(%rsp)
180004733:     	movq	0x288(%rsp), %rax
18000473b:     	movq	%rax, 0x58(%rsp)
180004740:     	movq	0x280(%rsp), %rax
180004748:     	movq	%rax, 0x50(%rsp)
18000474d:     	movq	0x278(%rsp), %rax
180004755:     	movq	%rax, 0x48(%rsp)
18000475a:     	movq	0x270(%rsp), %rax
180004762:     	movq	%rax, 0x40(%rsp)
180004767:     	movq	0x268(%rsp), %rax
18000476f:     	movq	%rax, 0x38(%rsp)
180004774:     	movq	%rdi, 0x30(%rsp)
180004779:     	movq	0x258(%rsp), %rax
180004781:     	movq	%rax, 0x28(%rsp)
180004786:     	movsd	%xmm6, 0x100(%rsp)
18000478f:     	movq	%rbx, 0xd8(%rsp)
180004797:     	movq	%rsi, 0xa0(%rsp)
18000479f:     	movq	0x250(%rsp), %rax
1800047a7:     	movq	%rax, 0x20(%rsp)
1800047ac:     	leaq	0x130(%rsp), %rcx
1800047b4:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
1800047b9:     	cmpb	$0x0, (%rbx)
1800047bc:     	je	0x180004805 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc45>
1800047be:     	movq	0x118(%rsp), %r13
1800047c6:     	movq	$0x0, 0x18(%r13)
1800047ce:     	movq	$0x0, 0x10(%r13)
1800047d6:     	movq	$0x0, 0x8(%r13)
1800047de:     	movq	$0x0, (%r13)
1800047e6:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
1800047eb:     	movzbl	0x117(%rsp), %eax
1800047f3:     	jmp	0x180004852 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc92>
1800047f5:     	movb	$0x1, (%rbx)
1800047f8:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
180004800:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180004805:     	cmpb	$0x0, 0x148(%rsp)
18000480d:     	setne	%al
180004810:     	cmpb	$0x0, 0x138(%rsp)
180004818:     	setne	%cl
18000481b:     	addsd	0x130(%rsp), %xmm7
180004824:     	addsd	0x140(%rsp), %xmm8
18000482e:     	decq	0x8(%rsi)
180004832:     	movzbl	0x116(%rsp), %r10d
18000483b:     	andb	%cl, %r10b
18000483e:     	movzbl	0x117(%rsp), %ecx
180004846:     	andb	%al, %cl
180004848:     	movl	%ecx, %eax
18000484a:     	movq	0x118(%rsp), %rcx
180004852:     	movb	%al, 0x18(%rcx)
180004855:     	movsd	%xmm8, 0x10(%rcx)
18000485b:     	movb	%r10b, 0x8(%rcx)
18000485f:     	movsd	%xmm7, (%rcx)
180004863:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180004868:     	nopl	(%rax,%rax)
