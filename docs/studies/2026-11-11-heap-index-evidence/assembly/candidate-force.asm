# Existing measured PE, candidate force: [0x180003c20, 0x180004a80)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
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
180003c57:     	movq	0x260(%rsp), %rbx
180003c5f:     	movq	$0x0, 0x150(%rsp)
180003c6b:     	movb	$0x0, 0x158(%rsp)
180003c73:     	movq	$0x0, 0x160(%rsp)
180003c7f:     	movq	$0x0, 0x130(%rsp)
180003c8b:     	movb	$0x0, 0x138(%rsp)
180003c93:     	movq	$0x0, 0x140(%rsp)
180003c9f:     	movsd	0x48(%rbx,%r13,8), %xmm0
180003ca6:     	xorpd	%xmm1, %xmm1
180003caa:     	ucomisd	%xmm1, %xmm0
180003cae:     	jne	0x180003cc7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x107>
180003cb0:     	jp	0x180003cc7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x107>
180003cb2:     	movb	$0x1, 0x18(%rcx)
180003cb6:     	movq	$0x0, 0x10(%rcx)
180003cbe:     	movb	$0x1, 0x8(%rcx)
180003cc2:     	jmp	0x180003eda <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31a>
180003cc7:     	movq	0x328(%rsp), %r12
180003ccf:     	movq	0x2a0(%rsp), %r15
180003cd7:     	movq	0x298(%rsp), %r14
180003cdf:     	movq	0x30(%r14,%r13,8), %rax
180003ce4:     	movq	%rax, %r10
180003ce7:     	sarq	$0x3f, %r10
180003ceb:     	andq	%r15, %r10
180003cee:     	leaq	(%r14,%rax,8), %rdx
180003cf2:     	cmpq	$0x1, (%rdx,%r10,8)
180003cf7:     	jne	0x180003d1a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x15a>
180003cf9:     	xorl	%r10d, %r10d
180003cfc:     	cmpq	$-0x2, %rax
180003d00:     	cmovlq	%r15, %r10
180003d04:     	movq	0x10(%rdx,%r10,8), %rax
180003d09:     	leaq	(%r14,%rax,8), %rdx
180003d0d:     	sarq	$0x3f, %rax
180003d11:     	andq	%r15, %rax
180003d14:     	cmpq	%r12, (%rdx,%rax,8)
180003d18:     	je	0x180003cb2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xf2>
180003d1a:     	movq	0x308(%rsp), %rdi
180003d22:     	movq	0x2d0(%rsp), %rsi
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
180003d7b:     	movsd	0x10(%rbx,%r10,8), %xmm2
180003d82:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d88:     	subsd	0x10(%rbx,%rdx,8), %xmm2
180003d8e:     	je	0x180003df8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x238>
180003d90:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d96:     	je	0x180003df8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x238>
180003d98:     	movapd	0x9620(%rip), %xmm3     # 0x18000d3c0
180003da0:     	andpd	%xmm2, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	jae	0x180003e65 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2a5>
180003db2:     	movapd	%xmm1, %xmm3
180003db6:     	mulsd	%xmm1, %xmm3
180003dba:     	ucomisd	0x960e(%rip), %xmm3     # 0x18000d3d0
180003dc2:     	setae	%dl
180003dc5:     	testb	%dl, %al
180003dc7:     	jne	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003dc9:     	xorpd	%xmm4, %xmm4
180003dcd:     	addsd	%xmm4, %xmm2
180003dd1:     	movapd	%xmm2, %xmm4
180003dd5:     	mulsd	%xmm2, %xmm4
180003dd9:     	ucomisd	0x95ef(%rip), %xmm4     # 0x18000d3d0
180003de1:     	jae	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003de3:     	addsd	%xmm4, %xmm3
180003de7:     	ucomisd	0x95e1(%rip), %xmm3     # 0x18000d3d0
180003def:     	setae	%dl
180003df2:     	testb	%dl, %al
180003df4:     	jne	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003df6:     	jmp	0x180003e3d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x27d>
180003df8:     	movapd	%xmm1, %xmm3
180003dfc:     	mulsd	%xmm1, %xmm3
180003e00:     	ucomisd	0x95c8(%rip), %xmm3     # 0x18000d3d0
180003e08:     	setae	%dl
180003e0b:     	andb	%dl, %al
180003e0d:     	cmpb	$0x1, %al
180003e0f:     	jne	0x180003e31 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x271>
180003e11:     	movb	$0x1, (%rdi)
180003e14:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003e1c:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e21:     	movb	$0x1, (%rdi)
180003e24:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003e2c:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e31:     	movapd	%xmm2, %xmm4
180003e35:     	mulsd	%xmm2, %xmm4
180003e39:     	addsd	%xmm4, %xmm3
180003e3d:     	xorps	%xmm4, %xmm4
180003e40:     	sqrtsd	%xmm3, %xmm4
180003e44:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e4a:     	je	0x180003e97 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2d7>
180003e4c:     	xorpd	%xmm5, %xmm5
180003e50:     	ucomisd	%xmm5, %xmm3
180003e54:     	jne	0x180003e72 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2b2>
180003e56:     	jp	0x180003e72 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2b2>
180003e58:     	movb	$0x1, (%rdi)
180003e5b:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e63:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e65:     	movb	$0x1, (%rdi)
180003e68:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e70:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e72:     	movsd	0x330(%rsp), %xmm6
180003e7b:     	movq	(%r14,%r13,8), %rax
180003e7f:     	movsd	0x8(%rbx,%rax,8), %xmm3
180003e85:     	addsd	%xmm3, %xmm3
180003e89:     	divsd	%xmm4, %xmm3
180003e8d:     	ucomisd	%xmm3, %xmm6
180003e91:     	jbe	0x180003f4a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x38a>
180003e97:     	movsd	0x9539(%rip), %xmm3     # 0x18000d3d8
180003e9f:     	maxsd	%xmm4, %xmm3
180003ea3:     	movapd	%xmm3, %xmm4
180003ea7:     	mulsd	%xmm3, %xmm4
180003eab:     	xorpd	%xmm5, %xmm5
180003eaf:     	ucomisd	%xmm5, %xmm4
180003eb3:     	jne	0x180003f10 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x350>
180003eb5:     	jp	0x180003f10 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x350>
180003eb7:     	movb	$0x1, (%rdi)
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
180003f10:     	movsd	0x8(%rbx,%r12,8), %xmm5
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
180003f48:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
180003f4a:     	movq	0x318(%rsp), %rdx
180003f52:     	movq	0x290(%rsp), %r11
180003f5a:     	movq	0x20(%r14,%r13,8), %rax
180003f5f:     	testq	%rax, %rax
180003f62:     	movb	$0x1, %bpl
180003f65:     	js	0x180004170 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5b0>
180003f6b:     	movq	0x8(%rsi), %rdx
180003f6f:     	leaq	0x1(%rdx), %r10
180003f73:     	movq	%r10, 0x8(%rsi)
180003f77:     	cmpq	0x10(%rsi), %rdx
180003f7b:     	jge	0x18000436a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7aa>
180003f81:     	movq	%rcx, %rbp
180003f84:     	movsd	%xmm6, 0x100(%rsp)
180003f8d:     	movq	%r12, 0xf8(%rsp)
180003f95:     	movq	%rax, 0xf0(%rsp)
180003f9d:     	movq	0x318(%rsp), %rax
180003fa5:     	movq	%rax, 0xe8(%rsp)
180003fad:     	movq	0x310(%rsp), %rax
180003fb5:     	movq	%rax, 0xe0(%rsp)
180003fbd:     	movq	%rdi, 0xd8(%rsp)
180003fc5:     	movq	0x300(%rsp), %rax
180003fcd:     	movq	%rax, 0xd0(%rsp)
180003fd5:     	movq	0x2f8(%rsp), %rax
180003fdd:     	movq	%rax, 0xc8(%rsp)
180003fe5:     	movq	0x2f0(%rsp), %rax
180003fed:     	movq	%rax, 0xc0(%rsp)
180003ff5:     	movq	0x2e8(%rsp), %rax
180003ffd:     	movq	%rax, 0xb8(%rsp)
180004005:     	movq	0x2e0(%rsp), %rax
18000400d:     	movq	%rax, 0xb0(%rsp)
180004015:     	movq	0x2d8(%rsp), %rax
18000401d:     	movq	%rax, 0xa8(%rsp)
180004025:     	movq	%rsi, 0xa0(%rsp)
18000402d:     	movq	0x2c8(%rsp), %rax
180004035:     	movq	%rax, 0x98(%rsp)
18000403d:     	movq	0x2c0(%rsp), %rax
180004045:     	movq	%rax, 0x90(%rsp)
18000404d:     	movq	0x2b8(%rsp), %rax
180004055:     	movq	%rax, 0x88(%rsp)
18000405d:     	movq	0x2b0(%rsp), %rax
180004065:     	movq	%rax, 0x80(%rsp)
18000406d:     	movq	0x2a8(%rsp), %rax
180004075:     	movq	%rax, 0x78(%rsp)
18000407a:     	movq	%r15, 0x70(%rsp)
18000407f:     	movq	%r14, 0x68(%rsp)
180004084:     	movq	%r11, 0x60(%rsp)
180004089:     	movq	0x288(%rsp), %rax
180004091:     	movq	%rax, 0x58(%rsp)
180004096:     	movq	0x280(%rsp), %rax
18000409e:     	movq	%rax, 0x50(%rsp)
1800040a3:     	movq	0x278(%rsp), %rax
1800040ab:     	movq	%rax, 0x48(%rsp)
1800040b0:     	movq	0x270(%rsp), %rax
1800040b8:     	movq	%rax, 0x40(%rsp)
1800040bd:     	movq	0x268(%rsp), %rax
1800040c5:     	movq	%rax, 0x38(%rsp)
1800040ca:     	movq	%rbx, 0x30(%rsp)
1800040cf:     	movq	0x258(%rsp), %rax
1800040d7:     	movq	%rax, 0x28(%rsp)
1800040dc:     	movq	0x250(%rsp), %rax
1800040e4:     	movq	%rax, 0x20(%rsp)
1800040e9:     	leaq	0x190(%rsp), %rcx
1800040f1:     	movq	%r8, 0x128(%rsp)
1800040f9:     	movq	%r9, 0x120(%rsp)
180004101:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
180004106:     	movzbl	0x198(%rsp), %ecx
18000410e:     	testb	%cl, %cl
180004110:     	setne	%r11b
180004114:     	cmpb	$0x0, (%rdi)
180004117:     	jne	0x180004345 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x785>
18000411d:     	movsd	0x1a0(%rsp), %xmm0
180004126:     	movzbl	0x1a8(%rsp), %eax
18000412e:     	movsd	0x190(%rsp), %xmm7
180004137:     	decq	0x8(%rsi)
18000413b:     	testb	%cl, %cl
18000413d:     	movq	%rbp, %rcx
180004140:     	je	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004146:     	movapd	0x9272(%rip), %xmm1     # 0x18000d3c0
18000414e:     	andpd	%xmm7, %xmm1
180004152:     	ucomisd	0x9276(%rip), %xmm1     # 0x18000d3d0
18000415a:     	jb	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004160:     	movb	$0x1, (%rdi)
180004163:     	movq	$0x3d0922, 0x18(%rsi)   # imm = 0x3D0922
18000416b:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180004170:     	xorpd	%xmm7, %xmm7
180004174:     	movb	$0x1, %r11b
180004177:     	xorpd	%xmm8, %xmm8
18000417c:     	movq	0x28(%r14,%r13,8), %rax
180004181:     	testq	%rax, %rax
180004184:     	js	0x1800044d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x919>
18000418a:     	movq	0x8(%rsi), %rdx
18000418e:     	leaq	0x1(%rdx), %r10
180004192:     	movq	%r10, 0x8(%rsi)
180004196:     	cmpq	0x10(%rsi), %rdx
18000419a:     	jge	0x18000437a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ba>
1800041a0:     	movb	%r11b, 0x117(%rsp)
1800041a8:     	movl	%ebp, 0x118(%rsp)
1800041af:     	movq	%rcx, %rbp
1800041b2:     	movsd	%xmm6, 0x100(%rsp)
1800041bb:     	movq	%r12, 0xf8(%rsp)
1800041c3:     	movq	%rax, 0xf0(%rsp)
1800041cb:     	movq	0x318(%rsp), %rax
1800041d3:     	movq	%rax, 0xe8(%rsp)
1800041db:     	movq	0x310(%rsp), %rax
1800041e3:     	movq	%rax, 0xe0(%rsp)
1800041eb:     	movq	%rdi, 0xd8(%rsp)
1800041f3:     	movq	0x300(%rsp), %rax
1800041fb:     	movq	%rax, 0xd0(%rsp)
180004203:     	movq	0x2f8(%rsp), %rax
18000420b:     	movq	%rax, 0xc8(%rsp)
180004213:     	movq	0x2f0(%rsp), %rax
18000421b:     	movq	%rax, 0xc0(%rsp)
180004223:     	movq	0x2e8(%rsp), %rax
18000422b:     	movq	%rax, 0xb8(%rsp)
180004233:     	movq	0x2e0(%rsp), %rax
18000423b:     	movq	%rax, 0xb0(%rsp)
180004243:     	movq	0x2d8(%rsp), %rax
18000424b:     	movq	%rax, 0xa8(%rsp)
180004253:     	movq	%rsi, 0xa0(%rsp)
18000425b:     	movq	0x2c8(%rsp), %rax
180004263:     	movq	%rax, 0x98(%rsp)
18000426b:     	movq	0x2c0(%rsp), %rax
180004273:     	movq	%rax, 0x90(%rsp)
18000427b:     	movq	0x2b8(%rsp), %rax
180004283:     	movq	%rax, 0x88(%rsp)
18000428b:     	movq	0x2b0(%rsp), %rax
180004293:     	movq	%rax, 0x80(%rsp)
18000429b:     	movq	0x2a8(%rsp), %rax
1800042a3:     	movq	%rax, 0x78(%rsp)
1800042a8:     	movq	%r15, 0x70(%rsp)
1800042ad:     	movq	%r14, 0x68(%rsp)
1800042b2:     	movq	0x290(%rsp), %rax
1800042ba:     	movq	%rax, 0x60(%rsp)
1800042bf:     	movq	0x288(%rsp), %rax
1800042c7:     	movq	%rax, 0x58(%rsp)
1800042cc:     	movq	0x280(%rsp), %rax
1800042d4:     	movq	%rax, 0x50(%rsp)
1800042d9:     	movq	0x278(%rsp), %rax
1800042e1:     	movq	%rax, 0x48(%rsp)
1800042e6:     	movq	0x270(%rsp), %rax
1800042ee:     	movq	%rax, 0x40(%rsp)
1800042f3:     	movq	0x268(%rsp), %rax
1800042fb:     	movq	%rax, 0x38(%rsp)
180004300:     	movq	%rbx, 0x30(%rsp)
180004305:     	movq	0x258(%rsp), %rax
18000430d:     	movq	%rax, 0x28(%rsp)
180004312:     	movq	0x250(%rsp), %rax
18000431a:     	movq	%rax, 0x20(%rsp)
18000431f:     	leaq	0x170(%rsp), %rcx
180004327:     	movq	%r8, 0x128(%rsp)
18000432f:     	movq	%r9, 0x120(%rsp)
180004337:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
18000433c:     	cmpb	$0x0, (%rdi)
18000433f:     	je	0x1800043e2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x822>
180004345:     	movq	$0x0, 0x18(%rbp)
18000434d:     	movq	$0x0, 0x10(%rbp)
180004355:     	movq	$0x0, 0x8(%rbp)
18000435d:     	movq	$0x0, (%rbp)
180004365:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
18000436a:     	movb	$0x1, (%rdi)
18000436d:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004375:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000437a:     	movb	$0x1, (%rdi)
18000437d:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
180004385:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000438a:     	xorpd	%xmm8, %xmm8
18000438f:     	addsd	%xmm8, %xmm7
180004394:     	testb	%al, %al
180004396:     	addsd	%xmm0, %xmm8
18000439b:     	je	0x1800044a0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x8e0>
1800043a1:     	andpd	0x9017(%rip), %xmm0     # 0x18000d3c0
1800043a9:     	ucomisd	0x901f(%rip), %xmm0     # 0x18000d3d0
1800043b1:     	movq	0x120(%rsp), %r9
1800043b9:     	movq	0x128(%rsp), %r8
1800043c1:     	movb	$0x1, %bpl
1800043c4:     	movq	0x318(%rsp), %rdx
1800043cc:     	jb	0x18000417c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5bc>
1800043d2:     	movb	$0x1, (%rdi)
1800043d5:     	movq	$0x3d0923, 0x18(%rsi)   # imm = 0x3D0923
1800043dd:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800043e2:     	movsd	0x180(%rsp), %xmm0
1800043eb:     	movzbl	0x188(%rsp), %eax
1800043f3:     	cmpb	$0x0, 0x178(%rsp)
1800043fb:     	setne	%cl
1800043fe:     	addsd	0x170(%rsp), %xmm7
180004407:     	decq	0x8(%rsi)
18000440b:     	movzbl	0x117(%rsp), %r11d
180004414:     	andb	%cl, %r11b
180004417:     	cmpb	$0x1, %r11b
18000441b:     	movq	%rbp, %rcx
18000441e:     	jne	0x180004446 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x886>
180004420:     	movapd	0x8f98(%rip), %xmm1     # 0x18000d3c0
180004428:     	andpd	%xmm7, %xmm1
18000442c:     	ucomisd	0x8f9c(%rip), %xmm1     # 0x18000d3d0
180004434:     	jb	0x180004446 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x886>
180004436:     	movb	$0x1, (%rdi)
180004439:     	movq	$0x3d0927, 0x18(%rsi)   # imm = 0x3D0927
180004441:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180004446:     	addsd	%xmm0, %xmm8
18000444b:     	testb	%al, %al
18000444d:     	setne	%al
180004450:     	movl	0x118(%rsp), %edx
180004457:     	andb	%al, %dl
180004459:     	cmpb	$0x1, %dl
18000445c:     	jne	0x1800044bf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x8ff>
18000445e:     	movapd	0x8f5a(%rip), %xmm0     # 0x18000d3c0
180004466:     	andpd	%xmm8, %xmm0
18000446b:     	movb	$0x1, %bpl
18000446e:     	ucomisd	0x8f5a(%rip), %xmm0     # 0x18000d3d0
180004476:     	movq	0x120(%rsp), %r9
18000447e:     	movq	0x128(%rsp), %r8
180004486:     	movq	0x318(%rsp), %rdx
18000448e:     	jb	0x1800044d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x919>
180004490:     	movb	$0x1, (%rdi)
180004493:     	movq	$0x3d0928, 0x18(%rsi)   # imm = 0x3D0928
18000449b:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800044a0:     	xorl	%ebp, %ebp
1800044a2:     	movq	0x120(%rsp), %r9
1800044aa:     	movq	0x128(%rsp), %r8
1800044b2:     	movq	0x318(%rsp), %rdx
1800044ba:     	jmp	0x18000417c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5bc>
1800044bf:     	xorl	%ebp, %ebp
1800044c1:     	movq	0x120(%rsp), %r9
1800044c9:     	movq	0x128(%rsp), %r8
1800044d1:     	movq	0x318(%rsp), %rdx
1800044d9:     	movq	0x38(%r14,%r13,8), %rax
1800044de:     	testq	%rax, %rax
1800044e1:     	js	0x180004793 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbd3>
1800044e7:     	movq	0x8(%rsi), %rdx
1800044eb:     	leaq	0x1(%rdx), %r10
1800044ef:     	movq	%r10, 0x8(%rsi)
1800044f3:     	cmpq	0x10(%rsi), %rdx
1800044f7:     	jge	0x1800046c8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb08>
1800044fd:     	movb	%r11b, 0x117(%rsp)
180004505:     	movq	%rcx, 0x118(%rsp)
18000450d:     	movsd	%xmm6, 0x100(%rsp)
180004516:     	movq	%r12, 0xf8(%rsp)
18000451e:     	movq	%rax, 0xf0(%rsp)
180004526:     	movq	0x318(%rsp), %rax
18000452e:     	movq	%rax, 0xe8(%rsp)
180004536:     	movq	0x310(%rsp), %rax
18000453e:     	movq	%rax, 0xe0(%rsp)
180004546:     	movq	%rdi, 0xd8(%rsp)
18000454e:     	movq	0x300(%rsp), %rax
180004556:     	movq	%rax, 0xd0(%rsp)
18000455e:     	movq	0x2f8(%rsp), %rax
180004566:     	movq	%rax, 0xc8(%rsp)
18000456e:     	movq	0x2f0(%rsp), %rax
180004576:     	movq	%rax, 0xc0(%rsp)
18000457e:     	movq	0x2e8(%rsp), %rax
180004586:     	movq	%rax, 0xb8(%rsp)
18000458e:     	movq	0x2e0(%rsp), %rax
180004596:     	movq	%rax, 0xb0(%rsp)
18000459e:     	movq	0x2d8(%rsp), %rax
1800045a6:     	movq	%rax, 0xa8(%rsp)
1800045ae:     	movq	%rsi, 0xa0(%rsp)
1800045b6:     	movq	0x2c8(%rsp), %rax
1800045be:     	movq	%rax, 0x98(%rsp)
1800045c6:     	movq	0x2c0(%rsp), %rax
1800045ce:     	movq	%rax, 0x90(%rsp)
1800045d6:     	movq	0x2b8(%rsp), %rax
1800045de:     	movq	%rax, 0x88(%rsp)
1800045e6:     	movq	0x2b0(%rsp), %rax
1800045ee:     	movq	%rax, 0x80(%rsp)
1800045f6:     	movq	0x2a8(%rsp), %rax
1800045fe:     	movq	%rax, 0x78(%rsp)
180004603:     	movq	%r15, 0x70(%rsp)
180004608:     	movq	%r14, 0x68(%rsp)
18000460d:     	movq	0x290(%rsp), %rax
180004615:     	movq	%rax, 0x60(%rsp)
18000461a:     	movq	0x288(%rsp), %rax
180004622:     	movq	%rax, 0x58(%rsp)
180004627:     	movq	0x280(%rsp), %rax
18000462f:     	movq	%rax, 0x50(%rsp)
180004634:     	movq	0x278(%rsp), %rax
18000463c:     	movq	%rax, 0x48(%rsp)
180004641:     	movq	0x270(%rsp), %rax
180004649:     	movq	%rax, 0x40(%rsp)
18000464e:     	movq	0x268(%rsp), %rax
180004656:     	movq	%rax, 0x38(%rsp)
18000465b:     	movq	%rbx, 0x30(%rsp)
180004660:     	movq	0x258(%rsp), %rax
180004668:     	movq	%rax, 0x28(%rsp)
18000466d:     	movq	0x250(%rsp), %rax
180004675:     	movq	%rax, 0x20(%rsp)
18000467a:     	leaq	0x150(%rsp), %rcx
180004682:     	movq	%r8, 0x128(%rsp)
18000468a:     	movq	%r9, 0x120(%rsp)
180004692:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
180004697:     	cmpb	$0x0, (%rdi)
18000469a:     	je	0x1800046d8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb18>
18000469c:     	movq	0x118(%rsp), %rax
1800046a4:     	movq	$0x0, 0x18(%rax)
1800046ac:     	movq	$0x0, 0x10(%rax)
1800046b4:     	movq	$0x0, 0x8(%rax)
1800046bc:     	movq	$0x0, (%rax)
1800046c3:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
1800046c8:     	movb	$0x1, (%rdi)
1800046cb:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800046d3:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800046d8:     	movsd	0x160(%rsp), %xmm0
1800046e1:     	movzbl	0x168(%rsp), %eax
1800046e9:     	cmpb	$0x0, 0x158(%rsp)
1800046f1:     	setne	%cl
1800046f4:     	addsd	0x150(%rsp), %xmm7
1800046fd:     	decq	0x8(%rsi)
180004701:     	movzbl	0x117(%rsp), %r11d
18000470a:     	andb	%cl, %r11b
18000470d:     	cmpb	$0x1, %r11b
180004711:     	jne	0x180004735 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb75>
180004713:     	movapd	0x8ca5(%rip), %xmm1     # 0x18000d3c0
18000471b:     	andpd	%xmm7, %xmm1
18000471f:     	ucomisd	0x8ca9(%rip), %xmm1     # 0x18000d3d0
180004727:     	jae	0x180004a16 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe56>
18000472d:     	xorpd	%xmm1, %xmm1
180004731:     	addsd	%xmm1, %xmm7
180004735:     	addsd	%xmm0, %xmm8
18000473a:     	testb	%al, %al
18000473c:     	setne	%al
18000473f:     	andb	%al, %bpl
180004742:     	cmpb	$0x1, %bpl
180004746:     	jne	0x180004771 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbb1>
180004748:     	movapd	0x8c70(%rip), %xmm0     # 0x18000d3c0
180004750:     	andpd	%xmm8, %xmm0
180004755:     	ucomisd	0x8c73(%rip), %xmm0     # 0x18000d3d0
18000475d:     	jae	0x180004a26 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe66>
180004763:     	xorpd	%xmm0, %xmm0
180004767:     	addsd	%xmm0, %xmm8
18000476c:     	movb	$0x1, %bpl
18000476f:     	jmp	0x180004773 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbb3>
180004771:     	xorl	%ebp, %ebp
180004773:     	movq	0x118(%rsp), %rcx
18000477b:     	movq	0x120(%rsp), %r9
180004783:     	movq	0x128(%rsp), %r8
18000478b:     	movq	0x318(%rsp), %rdx
180004793:     	movq	0x40(%r14,%r13,8), %rax
180004798:     	testq	%rax, %rax
18000479b:     	js	0x180004a40 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe80>
1800047a1:     	movq	%rdx, %r13
1800047a4:     	movq	0x8(%rsi), %rdx
1800047a8:     	leaq	0x1(%rdx), %r10
1800047ac:     	movq	%r10, 0x8(%rsi)
1800047b0:     	cmpq	0x10(%rsi), %rdx
1800047b4:     	jge	0x18000496e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xdae>
1800047ba:     	movb	%r11b, 0x117(%rsp)
1800047c2:     	movq	%rcx, 0x118(%rsp)
1800047ca:     	movq	%r12, 0xf8(%rsp)
1800047d2:     	movq	%rax, 0xf0(%rsp)
1800047da:     	movq	%r13, 0xe8(%rsp)
1800047e2:     	movq	0x310(%rsp), %rax
1800047ea:     	movq	%rax, 0xe0(%rsp)
1800047f2:     	movq	0x300(%rsp), %rax
1800047fa:     	movq	%rax, 0xd0(%rsp)
180004802:     	movq	0x2f8(%rsp), %rax
18000480a:     	movq	%rax, 0xc8(%rsp)
180004812:     	movq	0x2f0(%rsp), %rax
18000481a:     	movq	%rax, 0xc0(%rsp)
180004822:     	movq	0x2e8(%rsp), %rax
18000482a:     	movq	%rax, 0xb8(%rsp)
180004832:     	movq	0x2e0(%rsp), %rax
18000483a:     	movq	%rax, 0xb0(%rsp)
180004842:     	movq	0x2d8(%rsp), %rax
18000484a:     	movq	%rax, 0xa8(%rsp)
180004852:     	movq	0x2c8(%rsp), %rax
18000485a:     	movq	%rax, 0x98(%rsp)
180004862:     	movq	0x2c0(%rsp), %rax
18000486a:     	movq	%rax, 0x90(%rsp)
180004872:     	movq	0x2b8(%rsp), %rax
18000487a:     	movq	%rax, 0x88(%rsp)
180004882:     	movq	0x2b0(%rsp), %rax
18000488a:     	movq	%rax, 0x80(%rsp)
180004892:     	movq	0x2a8(%rsp), %rax
18000489a:     	movq	%rax, 0x78(%rsp)
18000489f:     	movq	%r15, 0x70(%rsp)
1800048a4:     	movq	%r14, 0x68(%rsp)
1800048a9:     	movq	0x290(%rsp), %rax
1800048b1:     	movq	%rax, 0x60(%rsp)
1800048b6:     	movq	0x288(%rsp), %rax
1800048be:     	movq	%rax, 0x58(%rsp)
1800048c3:     	movq	0x280(%rsp), %rax
1800048cb:     	movq	%rax, 0x50(%rsp)
1800048d0:     	movq	0x278(%rsp), %rax
1800048d8:     	movq	%rax, 0x48(%rsp)
1800048dd:     	movq	0x270(%rsp), %rax
1800048e5:     	movq	%rax, 0x40(%rsp)
1800048ea:     	movq	0x268(%rsp), %rax
1800048f2:     	movq	%rax, 0x38(%rsp)
1800048f7:     	movq	%rbx, 0x30(%rsp)
1800048fc:     	movq	0x258(%rsp), %rax
180004904:     	movq	%rax, 0x28(%rsp)
180004909:     	movsd	%xmm6, 0x100(%rsp)
180004912:     	movq	%rdi, 0xd8(%rsp)
18000491a:     	movq	%rsi, 0xa0(%rsp)
180004922:     	movq	0x250(%rsp), %rax
18000492a:     	movq	%rax, 0x20(%rsp)
18000492f:     	leaq	0x130(%rsp), %rcx
180004937:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
18000493c:     	cmpb	$0x0, (%rdi)
18000493f:     	je	0x18000497e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xdbe>
180004941:     	movq	0x118(%rsp), %r13
180004949:     	movq	$0x0, 0x18(%r13)
180004951:     	movq	$0x0, 0x10(%r13)
180004959:     	movq	$0x0, 0x8(%r13)
180004961:     	movq	$0x0, (%r13)
180004969:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
18000496e:     	movb	$0x1, (%rdi)
180004971:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
180004979:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000497e:     	movsd	0x140(%rsp), %xmm0
180004987:     	movzbl	0x148(%rsp), %eax
18000498f:     	cmpb	$0x0, 0x138(%rsp)
180004997:     	setne	%cl
18000499a:     	addsd	0x130(%rsp), %xmm7
1800049a3:     	decq	0x8(%rsi)
1800049a7:     	movzbl	0x117(%rsp), %r13d
1800049b0:     	andb	%cl, %r13b
1800049b3:     	movl	%r13d, %r11d
1800049b6:     	cmpb	$0x1, %r13b
1800049ba:     	jne	0x1800049de <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe1e>
1800049bc:     	movapd	0x89fc(%rip), %xmm1     # 0x18000d3c0
1800049c4:     	andpd	%xmm7, %xmm1
1800049c8:     	ucomisd	0x8a00(%rip), %xmm1     # 0x18000d3d0
1800049d0:     	jae	0x180004a57 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe97>
1800049d6:     	xorpd	%xmm1, %xmm1
1800049da:     	addsd	%xmm1, %xmm7
1800049de:     	testb	%al, %al
1800049e0:     	setne	%al
1800049e3:     	addsd	%xmm0, %xmm8
1800049e8:     	andb	%al, %bpl
1800049eb:     	cmpb	$0x1, %bpl
1800049ef:     	jne	0x180004a36 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe76>
1800049f1:     	movapd	0x89c7(%rip), %xmm0     # 0x18000d3c0
1800049f9:     	andpd	%xmm8, %xmm0
1800049fe:     	ucomisd	0x89ca(%rip), %xmm0     # 0x18000d3d0
180004a06:     	jae	0x180004a67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xea7>
180004a08:     	xorpd	%xmm0, %xmm0
180004a0c:     	addsd	%xmm0, %xmm8
180004a11:     	movb	$0x1, %bpl
180004a14:     	jmp	0x180004a38 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe78>
180004a16:     	movb	$0x1, (%rdi)
180004a19:     	movq	$0x3d092c, 0x18(%rsi)   # imm = 0x3D092C
180004a21:     	jmp	0x18000469c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xadc>
180004a26:     	movb	$0x1, (%rdi)
180004a29:     	movq	$0x3d092d, 0x18(%rsi)   # imm = 0x3D092D
180004a31:     	jmp	0x18000469c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xadc>
180004a36:     	xorl	%ebp, %ebp
180004a38:     	movq	0x118(%rsp), %rcx
180004a40:     	movb	%bpl, 0x18(%rcx)
180004a44:     	movsd	%xmm8, 0x10(%rcx)
180004a4a:     	movb	%r11b, 0x8(%rcx)
180004a4e:     	movsd	%xmm7, (%rcx)
180004a52:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
180004a57:     	movb	$0x1, (%rdi)
180004a5a:     	movq	$0x3d0931, 0x18(%rsi)   # imm = 0x3D0931
180004a62:     	jmp	0x180004941 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xd81>
180004a67:     	movb	$0x1, (%rdi)
180004a6a:     	movq	$0x3d0932, 0x18(%rsi)   # imm = 0x3D0932
180004a72:     	jmp	0x180004941 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xd81>
180004a77:     	nopw	(%rax,%rax)
