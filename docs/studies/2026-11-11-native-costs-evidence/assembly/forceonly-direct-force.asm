# forceonly-direct force: [0x180003bf0, 0x1800046f0)
# Source/call-target inferred range; padding may be included. Static evidence, not cycles.
180003bf0:     	pushq	%r15
180003bf2:     	pushq	%r14
180003bf4:     	pushq	%r13
180003bf6:     	pushq	%r12
180003bf8:     	pushq	%rsi
180003bf9:     	pushq	%rdi
180003bfa:     	pushq	%rbp
180003bfb:     	pushq	%rbx
180003bfc:     	subq	$0x198, %rsp            # imm = 0x198
180003c03:     	movapd	%xmm8, 0x180(%rsp)
180003c0d:     	movapd	%xmm7, 0x170(%rsp)
180003c16:     	movapd	%xmm6, 0x160(%rsp)
180003c1f:     	movq	0x2d0(%rsp), %r13
180003c27:     	movq	0x210(%rsp), %rdi
180003c2f:     	movsd	0x48(%rdi,%r13,8), %xmm0
180003c36:     	xorpd	%xmm1, %xmm1
180003c3a:     	ucomisd	%xmm1, %xmm0
180003c3e:     	jne	0x180003c80 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xf0>
180003c40:     	jp	0x180003c80 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xf0>
180003c42:     	movq	$0x0, 0x8(%rcx)
180003c4a:     	movq	$0x0, (%rcx)
180003c51:     	xorl	%eax, %eax
180003c53:     	movaps	0x160(%rsp), %xmm6
180003c5b:     	movaps	0x170(%rsp), %xmm7
180003c63:     	movaps	0x180(%rsp), %xmm8
180003c6c:     	addq	$0x198, %rsp            # imm = 0x198
180003c73:     	popq	%rbx
180003c74:     	popq	%rbp
180003c75:     	popq	%rdi
180003c76:     	popq	%rsi
180003c77:     	popq	%r12
180003c79:     	popq	%r13
180003c7b:     	popq	%r14
180003c7d:     	popq	%r15
180003c7f:     	retq
180003c80:     	movq	0x2d8(%rsp), %r12
180003c88:     	movq	0x250(%rsp), %r15
180003c90:     	movq	0x248(%rsp), %r14
180003c98:     	movq	0x30(%r14,%r13,8), %rax
180003c9d:     	movq	%rax, %r10
180003ca0:     	sarq	$0x3f, %r10
180003ca4:     	andq	%r15, %r10
180003ca7:     	leaq	(%r14,%rax,8), %rdx
180003cab:     	cmpq	$0x1, (%rdx,%r10,8)
180003cb0:     	jne	0x180003cd7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x147>
180003cb2:     	xorl	%r10d, %r10d
180003cb5:     	cmpq	$-0x2, %rax
180003cb9:     	cmovlq	%r15, %r10
180003cbd:     	movq	0x10(%rdx,%r10,8), %rax
180003cc2:     	leaq	(%r14,%rax,8), %rdx
180003cc6:     	sarq	$0x3f, %rax
180003cca:     	andq	%r15, %rax
180003ccd:     	cmpq	%r12, (%rdx,%rax,8)
180003cd1:     	je	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003cd7:     	movq	0x2b8(%rsp), %rbx
180003cdf:     	movq	0x280(%rsp), %rsi
180003ce7:     	movq	0x10(%r14,%r13,8), %r10
180003cec:     	movsd	(%rdi,%r10,8), %xmm1
180003cf2:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003cf8:     	setne	%r11b
180003cfc:     	movq	0x10(%r14,%r12,8), %rdx
180003d01:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d07:     	setne	%al
180003d0a:     	subsd	(%rdi,%rdx,8), %xmm1
180003d0f:     	andb	%r11b, %al
180003d12:     	cmpb	$0x1, %al
180003d14:     	jne	0x180003d38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1a8>
180003d16:     	movapd	0x96a2(%rip), %xmm2     # 0x18000d3c0
180003d1e:     	andpd	%xmm1, %xmm2
180003d22:     	ucomisd	0x96a6(%rip), %xmm2     # 0x18000d3d0
180003d2a:     	jae	0x180003dde <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x24e>
180003d30:     	xorpd	%xmm2, %xmm2
180003d34:     	addsd	%xmm2, %xmm1
180003d38:     	movsd	0x10(%rdi,%r10,8), %xmm2
180003d3f:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d45:     	subsd	0x10(%rdi,%rdx,8), %xmm2
180003d4b:     	je	0x180003db5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x225>
180003d4d:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d53:     	je	0x180003db5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x225>
180003d55:     	movapd	0x9663(%rip), %xmm3     # 0x18000d3c0
180003d5d:     	andpd	%xmm2, %xmm3
180003d61:     	ucomisd	0x9667(%rip), %xmm3     # 0x18000d3d0
180003d69:     	jae	0x180003e25 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x295>
180003d6f:     	movapd	%xmm1, %xmm3
180003d73:     	mulsd	%xmm1, %xmm3
180003d77:     	ucomisd	0x9651(%rip), %xmm3     # 0x18000d3d0
180003d7f:     	setae	%dl
180003d82:     	testb	%dl, %al
180003d84:     	jne	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003d86:     	xorpd	%xmm4, %xmm4
180003d8a:     	addsd	%xmm4, %xmm2
180003d8e:     	movapd	%xmm2, %xmm4
180003d92:     	mulsd	%xmm2, %xmm4
180003d96:     	ucomisd	0x9632(%rip), %xmm4     # 0x18000d3d0
180003d9e:     	jae	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003da0:     	addsd	%xmm4, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	setae	%dl
180003daf:     	testb	%dl, %al
180003db1:     	jne	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003db3:     	jmp	0x180003dfa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x26a>
180003db5:     	movapd	%xmm1, %xmm3
180003db9:     	mulsd	%xmm1, %xmm3
180003dbd:     	ucomisd	0x960b(%rip), %xmm3     # 0x18000d3d0
180003dc5:     	setae	%dl
180003dc8:     	andb	%dl, %al
180003dca:     	cmpb	$0x1, %al
180003dcc:     	jne	0x180003dee <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x25e>
180003dce:     	movb	$0x1, (%rbx)
180003dd1:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003dd9:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003dde:     	movb	$0x1, (%rbx)
180003de1:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003de9:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003dee:     	movapd	%xmm2, %xmm4
180003df2:     	mulsd	%xmm2, %xmm4
180003df6:     	addsd	%xmm4, %xmm3
180003dfa:     	xorps	%xmm4, %xmm4
180003dfd:     	sqrtsd	%xmm3, %xmm4
180003e01:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e07:     	je	0x180003e56 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2c6>
180003e09:     	xorpd	%xmm5, %xmm5
180003e0d:     	ucomisd	%xmm5, %xmm3
180003e11:     	jne	0x180003e35 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2a5>
180003e13:     	jp	0x180003e35 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2a5>
180003e15:     	movb	$0x1, (%rbx)
180003e18:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e20:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e25:     	movb	$0x1, (%rbx)
180003e28:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e30:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e35:     	movsd	0x2e0(%rsp), %xmm6
180003e3e:     	movq	(%r14,%r13,8), %rax
180003e42:     	movsd	0x8(%rdi,%rax,8), %xmm3
180003e48:     	addsd	%xmm3, %xmm3
180003e4c:     	divsd	%xmm4, %xmm3
180003e50:     	ucomisd	%xmm3, %xmm6
180003e54:     	jbe	0x180003ebb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x32b>
180003e56:     	movsd	0x957a(%rip), %xmm3     # 0x18000d3d8
180003e5e:     	maxsd	%xmm4, %xmm3
180003e62:     	movapd	%xmm3, %xmm4
180003e66:     	mulsd	%xmm3, %xmm4
180003e6a:     	xorpd	%xmm5, %xmm5
180003e6e:     	ucomisd	%xmm5, %xmm4
180003e72:     	jne	0x180003e86 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2f6>
180003e74:     	jp	0x180003e86 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2f6>
180003e76:     	movb	$0x1, (%rbx)
180003e79:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180003e81:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e86:     	movsd	0x8(%rdi,%r12,8), %xmm5
180003e8d:     	mulsd	0x954b(%rip), %xmm5     # 0x18000d3e0
180003e95:     	mulsd	%xmm5, %xmm0
180003e99:     	divsd	%xmm4, %xmm0
180003e9d:     	mulsd	%xmm0, %xmm1
180003ea1:     	divsd	%xmm3, %xmm1
180003ea5:     	mulsd	%xmm0, %xmm2
180003ea9:     	divsd	%xmm3, %xmm2
180003ead:     	movsd	%xmm1, (%rcx)
180003eb1:     	movsd	%xmm2, 0x8(%rcx)
180003eb6:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
180003ebb:     	movq	0x2c8(%rsp), %rdx
180003ec3:     	movq	0x298(%rsp), %rbp
180003ecb:     	movq	0x290(%rsp), %r11
180003ed3:     	movq	0x20(%r14,%r13,8), %rax
180003ed8:     	testq	%rax, %rax
180003edb:     	js	0x1800040cb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x53b>
180003ee1:     	movq	0x8(%rsi), %rdx
180003ee5:     	leaq	0x1(%rdx), %r10
180003ee9:     	movq	%r10, 0x8(%rsi)
180003eed:     	cmpq	0x10(%rsi), %rdx
180003ef1:     	jge	0x180004489 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8f9>
180003ef7:     	movq	%rcx, 0x108(%rsp)
180003eff:     	movsd	%xmm6, 0x100(%rsp)
180003f08:     	movq	%r12, 0xf8(%rsp)
180003f10:     	movq	%rax, 0xf0(%rsp)
180003f18:     	movq	0x2c8(%rsp), %rax
180003f20:     	movq	%rax, 0xe8(%rsp)
180003f28:     	movq	0x2c0(%rsp), %rax
180003f30:     	movq	%rax, 0xe0(%rsp)
180003f38:     	movq	%rbx, 0xd8(%rsp)
180003f40:     	movq	0x2b0(%rsp), %rax
180003f48:     	movq	%rax, 0xd0(%rsp)
180003f50:     	movq	0x2a8(%rsp), %rax
180003f58:     	movq	%rax, 0xc8(%rsp)
180003f60:     	movq	0x2a0(%rsp), %rax
180003f68:     	movq	%rax, 0xc0(%rsp)
180003f70:     	movq	%rbp, 0xb8(%rsp)
180003f78:     	movq	%r11, 0xb0(%rsp)
180003f80:     	movq	0x288(%rsp), %rax
180003f88:     	movq	%rax, 0xa8(%rsp)
180003f90:     	movq	%rsi, 0xa0(%rsp)
180003f98:     	movq	0x278(%rsp), %rax
180003fa0:     	movq	%rax, 0x98(%rsp)
180003fa8:     	movq	0x270(%rsp), %rax
180003fb0:     	movq	%rax, 0x90(%rsp)
180003fb8:     	movq	0x268(%rsp), %rax
180003fc0:     	movq	%rax, 0x88(%rsp)
180003fc8:     	movq	0x260(%rsp), %rax
180003fd0:     	movq	%rax, 0x80(%rsp)
180003fd8:     	movq	0x258(%rsp), %rax
180003fe0:     	movq	%rax, 0x78(%rsp)
180003fe5:     	movq	%r15, 0x70(%rsp)
180003fea:     	movq	%r14, 0x68(%rsp)
180003fef:     	movq	0x240(%rsp), %rax
180003ff7:     	movq	%rax, 0x60(%rsp)
180003ffc:     	movq	0x238(%rsp), %rax
180004004:     	movq	%rax, 0x58(%rsp)
180004009:     	movq	0x230(%rsp), %rax
180004011:     	movq	%rax, 0x50(%rsp)
180004016:     	movq	0x228(%rsp), %rax
18000401e:     	movq	%rax, 0x48(%rsp)
180004023:     	movq	0x220(%rsp), %rax
18000402b:     	movq	%rax, 0x40(%rsp)
180004030:     	movq	0x218(%rsp), %rax
180004038:     	movq	%rax, 0x38(%rsp)
18000403d:     	movq	%rdi, 0x30(%rsp)
180004042:     	movq	0x208(%rsp), %rax
18000404a:     	movq	%rax, 0x28(%rsp)
18000404f:     	movq	0x200(%rsp), %rax
180004057:     	movq	%rax, 0x20(%rsp)
18000405c:     	leaq	0x150(%rsp), %rcx
180004064:     	movq	%r8, 0x110(%rsp)
18000406c:     	movq	%r9, %rbp
18000406f:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004074:     	cmpb	$0x0, (%rbx)
180004077:     	jne	0x18000446d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8dd>
18000407d:     	xorpd	%xmm8, %xmm8
180004082:     	movsd	0x150(%rsp), %xmm7
18000408b:     	addsd	%xmm8, %xmm7
180004090:     	addsd	0x158(%rsp), %xmm8
18000409a:     	decq	0x8(%rsi)
18000409e:     	movq	0x108(%rsp), %rcx
1800040a6:     	movq	%rbp, %r9
1800040a9:     	movq	0x110(%rsp), %r8
1800040b1:     	movq	0x290(%rsp), %r11
1800040b9:     	movq	0x298(%rsp), %rbp
1800040c1:     	movq	0x2c8(%rsp), %rdx
1800040c9:     	jmp	0x1800040d4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x544>
1800040cb:     	xorpd	%xmm7, %xmm7
1800040cf:     	xorpd	%xmm8, %xmm8
1800040d4:     	movq	0x28(%r14,%r13,8), %rax
1800040d9:     	testq	%rax, %rax
1800040dc:     	js	0x1800042c2 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x732>
1800040e2:     	movq	0x8(%rsi), %rdx
1800040e6:     	leaq	0x1(%rdx), %r10
1800040ea:     	movq	%r10, 0x8(%rsi)
1800040ee:     	cmpq	0x10(%rsi), %rdx
1800040f2:     	jge	0x180004499 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x909>
1800040f8:     	movq	%rcx, 0x108(%rsp)
180004100:     	movsd	%xmm6, 0x100(%rsp)
180004109:     	movq	%r12, 0xf8(%rsp)
180004111:     	movq	%rax, 0xf0(%rsp)
180004119:     	movq	0x2c8(%rsp), %rax
180004121:     	movq	%rax, 0xe8(%rsp)
180004129:     	movq	0x2c0(%rsp), %rax
180004131:     	movq	%rax, 0xe0(%rsp)
180004139:     	movq	%rbx, 0xd8(%rsp)
180004141:     	movq	0x2b0(%rsp), %rax
180004149:     	movq	%rax, 0xd0(%rsp)
180004151:     	movq	0x2a8(%rsp), %rax
180004159:     	movq	%rax, 0xc8(%rsp)
180004161:     	movq	0x2a0(%rsp), %rax
180004169:     	movq	%rax, 0xc0(%rsp)
180004171:     	movq	%rbp, 0xb8(%rsp)
180004179:     	movq	%r11, 0xb0(%rsp)
180004181:     	movq	0x288(%rsp), %rax
180004189:     	movq	%rax, 0xa8(%rsp)
180004191:     	movq	%rsi, 0xa0(%rsp)
180004199:     	movq	0x278(%rsp), %rax
1800041a1:     	movq	%rax, 0x98(%rsp)
1800041a9:     	movq	0x270(%rsp), %rax
1800041b1:     	movq	%rax, 0x90(%rsp)
1800041b9:     	movq	0x268(%rsp), %rax
1800041c1:     	movq	%rax, 0x88(%rsp)
1800041c9:     	movq	0x260(%rsp), %rax
1800041d1:     	movq	%rax, 0x80(%rsp)
1800041d9:     	movq	0x258(%rsp), %rax
1800041e1:     	movq	%rax, 0x78(%rsp)
1800041e6:     	movq	%r15, 0x70(%rsp)
1800041eb:     	movq	%r14, 0x68(%rsp)
1800041f0:     	movq	0x240(%rsp), %rax
1800041f8:     	movq	%rax, 0x60(%rsp)
1800041fd:     	movq	0x238(%rsp), %rax
180004205:     	movq	%rax, 0x58(%rsp)
18000420a:     	movq	0x230(%rsp), %rax
180004212:     	movq	%rax, 0x50(%rsp)
180004217:     	movq	0x228(%rsp), %rax
18000421f:     	movq	%rax, 0x48(%rsp)
180004224:     	movq	0x220(%rsp), %rax
18000422c:     	movq	%rax, 0x40(%rsp)
180004231:     	movq	0x218(%rsp), %rax
180004239:     	movq	%rax, 0x38(%rsp)
18000423e:     	movq	%rdi, 0x30(%rsp)
180004243:     	movq	0x208(%rsp), %rax
18000424b:     	movq	%rax, 0x28(%rsp)
180004250:     	movq	0x200(%rsp), %rax
180004258:     	movq	%rax, 0x20(%rsp)
18000425d:     	leaq	0x140(%rsp), %rcx
180004265:     	movq	%r8, 0x110(%rsp)
18000426d:     	movq	%r9, 0x118(%rsp)
180004275:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
18000427a:     	cmpb	$0x0, (%rbx)
18000427d:     	jne	0x18000446d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8dd>
180004283:     	addsd	0x140(%rsp), %xmm7
18000428c:     	addsd	0x148(%rsp), %xmm8
180004296:     	decq	0x8(%rsi)
18000429a:     	movq	0x108(%rsp), %rcx
1800042a2:     	movq	0x118(%rsp), %r9
1800042aa:     	movq	0x110(%rsp), %r8
1800042b2:     	movq	0x290(%rsp), %r11
1800042ba:     	movq	0x2c8(%rsp), %rdx
1800042c2:     	movq	0x38(%r14,%r13,8), %rax
1800042c7:     	testq	%rax, %rax
1800042ca:     	js	0x1800044f8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x968>
1800042d0:     	movq	0x8(%rsi), %rdx
1800042d4:     	leaq	0x1(%rdx), %r10
1800042d8:     	movq	%r10, 0x8(%rsi)
1800042dc:     	cmpq	0x10(%rsi), %rdx
1800042e0:     	jge	0x1800044a9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x919>
1800042e6:     	movq	%rcx, 0x108(%rsp)
1800042ee:     	movsd	%xmm6, 0x100(%rsp)
1800042f7:     	movq	%r12, 0xf8(%rsp)
1800042ff:     	movq	%rax, 0xf0(%rsp)
180004307:     	movq	0x2c8(%rsp), %rax
18000430f:     	movq	%rax, 0xe8(%rsp)
180004317:     	movq	0x2c0(%rsp), %rax
18000431f:     	movq	%rax, 0xe0(%rsp)
180004327:     	movq	%rbx, 0xd8(%rsp)
18000432f:     	movq	0x2b0(%rsp), %rax
180004337:     	movq	%rax, 0xd0(%rsp)
18000433f:     	movq	0x2a8(%rsp), %rax
180004347:     	movq	%rax, 0xc8(%rsp)
18000434f:     	movq	0x2a0(%rsp), %rax
180004357:     	movq	%rax, 0xc0(%rsp)
18000435f:     	movq	%rbp, 0xb8(%rsp)
180004367:     	movq	%r11, 0xb0(%rsp)
18000436f:     	movq	0x288(%rsp), %rax
180004377:     	movq	%rax, 0xa8(%rsp)
18000437f:     	movq	%rsi, 0xa0(%rsp)
180004387:     	movq	0x278(%rsp), %rax
18000438f:     	movq	%rax, 0x98(%rsp)
180004397:     	movq	0x270(%rsp), %rax
18000439f:     	movq	%rax, 0x90(%rsp)
1800043a7:     	movq	0x268(%rsp), %rax
1800043af:     	movq	%rax, 0x88(%rsp)
1800043b7:     	movq	0x260(%rsp), %rax
1800043bf:     	movq	%rax, 0x80(%rsp)
1800043c7:     	movq	0x258(%rsp), %rax
1800043cf:     	movq	%rax, 0x78(%rsp)
1800043d4:     	movq	%r15, 0x70(%rsp)
1800043d9:     	movq	%r14, 0x68(%rsp)
1800043de:     	movq	0x240(%rsp), %rax
1800043e6:     	movq	%rax, 0x60(%rsp)
1800043eb:     	movq	0x238(%rsp), %rax
1800043f3:     	movq	%rax, 0x58(%rsp)
1800043f8:     	movq	0x230(%rsp), %rax
180004400:     	movq	%rax, 0x50(%rsp)
180004405:     	movq	0x228(%rsp), %rax
18000440d:     	movq	%rax, 0x48(%rsp)
180004412:     	movq	0x220(%rsp), %rax
18000441a:     	movq	%rax, 0x40(%rsp)
18000441f:     	movq	0x218(%rsp), %rax
180004427:     	movq	%rax, 0x38(%rsp)
18000442c:     	movq	%rdi, 0x30(%rsp)
180004431:     	movq	0x208(%rsp), %rax
180004439:     	movq	%rax, 0x28(%rsp)
18000443e:     	movq	0x200(%rsp), %rax
180004446:     	movq	%rax, 0x20(%rsp)
18000444b:     	leaq	0x130(%rsp), %rcx
180004453:     	movq	%r8, 0x110(%rsp)
18000445b:     	movq	%r9, 0x118(%rsp)
180004463:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004468:     	cmpb	$0x0, (%rbx)
18000446b:     	je	0x1800044b9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x929>
18000446d:     	movq	0x108(%rsp), %rax
180004475:     	movq	$0x0, 0x8(%rax)
18000447d:     	movq	$0x0, (%rax)
180004484:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
180004489:     	movb	$0x1, (%rbx)
18000448c:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004494:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180004499:     	movb	$0x1, (%rbx)
18000449c:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
1800044a4:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800044a9:     	movb	$0x1, (%rbx)
1800044ac:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800044b4:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800044b9:     	addsd	0x130(%rsp), %xmm7
1800044c2:     	addsd	0x138(%rsp), %xmm8
1800044cc:     	decq	0x8(%rsi)
1800044d0:     	movq	0x108(%rsp), %rcx
1800044d8:     	movq	0x118(%rsp), %r9
1800044e0:     	movq	0x110(%rsp), %r8
1800044e8:     	movq	0x290(%rsp), %r11
1800044f0:     	movq	0x2c8(%rsp), %rdx
1800044f8:     	movq	0x40(%r14,%r13,8), %rax
1800044fd:     	testq	%rax, %rax
180004500:     	js	0x1800046da <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb4a>
180004506:     	movq	%rdx, %r13
180004509:     	movq	0x8(%rsi), %rdx
18000450d:     	leaq	0x1(%rdx), %r10
180004511:     	movq	%r10, 0x8(%rsi)
180004515:     	cmpq	0x10(%rsi), %rdx
180004519:     	jge	0x1800046ab <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb1b>
18000451f:     	movq	%rcx, 0x108(%rsp)
180004527:     	movq	%r12, 0xf8(%rsp)
18000452f:     	movq	%rax, 0xf0(%rsp)
180004537:     	movq	%r13, 0xe8(%rsp)
18000453f:     	movq	0x2c0(%rsp), %rax
180004547:     	movq	%rax, 0xe0(%rsp)
18000454f:     	movq	0x2b0(%rsp), %rax
180004557:     	movq	%rax, 0xd0(%rsp)
18000455f:     	movq	0x2a8(%rsp), %rax
180004567:     	movq	%rax, 0xc8(%rsp)
18000456f:     	movq	0x2a0(%rsp), %rax
180004577:     	movq	%rax, 0xc0(%rsp)
18000457f:     	movq	%rbp, 0xb8(%rsp)
180004587:     	movq	%r11, 0xb0(%rsp)
18000458f:     	movq	0x288(%rsp), %rax
180004597:     	movq	%rax, 0xa8(%rsp)
18000459f:     	movq	0x278(%rsp), %rax
1800045a7:     	movq	%rax, 0x98(%rsp)
1800045af:     	movq	0x270(%rsp), %rax
1800045b7:     	movq	%rax, 0x90(%rsp)
1800045bf:     	movq	0x268(%rsp), %rax
1800045c7:     	movq	%rax, 0x88(%rsp)
1800045cf:     	movq	0x260(%rsp), %rax
1800045d7:     	movq	%rax, 0x80(%rsp)
1800045df:     	movq	0x258(%rsp), %rax
1800045e7:     	movq	%rax, 0x78(%rsp)
1800045ec:     	movq	%r15, 0x70(%rsp)
1800045f1:     	movq	%r14, 0x68(%rsp)
1800045f6:     	movq	0x240(%rsp), %rax
1800045fe:     	movq	%rax, 0x60(%rsp)
180004603:     	movq	0x238(%rsp), %rax
18000460b:     	movq	%rax, 0x58(%rsp)
180004610:     	movq	0x230(%rsp), %rax
180004618:     	movq	%rax, 0x50(%rsp)
18000461d:     	movq	0x228(%rsp), %rax
180004625:     	movq	%rax, 0x48(%rsp)
18000462a:     	movq	0x220(%rsp), %rax
180004632:     	movq	%rax, 0x40(%rsp)
180004637:     	movq	0x218(%rsp), %rax
18000463f:     	movq	%rax, 0x38(%rsp)
180004644:     	movq	%rdi, 0x30(%rsp)
180004649:     	movq	0x208(%rsp), %rax
180004651:     	movq	%rax, 0x28(%rsp)
180004656:     	movsd	%xmm6, 0x100(%rsp)
18000465f:     	movq	%rbx, 0xd8(%rsp)
180004667:     	movq	%rsi, 0xa0(%rsp)
18000466f:     	movq	0x200(%rsp), %rax
180004677:     	movq	%rax, 0x20(%rsp)
18000467c:     	leaq	0x120(%rsp), %rcx
180004684:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004689:     	cmpb	$0x0, (%rbx)
18000468c:     	je	0x1800046bb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2b>
18000468e:     	movq	0x108(%rsp), %r13
180004696:     	movq	$0x0, 0x8(%r13)
18000469e:     	movq	$0x0, (%r13)
1800046a6:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
1800046ab:     	movb	$0x1, (%rbx)
1800046ae:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
1800046b6:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800046bb:     	addsd	0x120(%rsp), %xmm7
1800046c4:     	addsd	0x128(%rsp), %xmm8
1800046ce:     	decq	0x8(%rsi)
1800046d2:     	movq	0x108(%rsp), %rcx
1800046da:     	movsd	%xmm7, (%rcx)
1800046de:     	movsd	%xmm8, 0x8(%rcx)
1800046e4:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
1800046e9:     	nopl	(%rax)
