# raytrace-current render: [0x1800019d0, 0x180002fc0)
# Source/call-target-bound static range; counts include padding, never cycles.
1800019d0:     	pushq	%r15
1800019d2:     	pushq	%r14
1800019d4:     	pushq	%r13
1800019d6:     	pushq	%r12
1800019d8:     	pushq	%rsi
1800019d9:     	pushq	%rdi
1800019da:     	pushq	%rbp
1800019db:     	pushq	%rbx
1800019dc:     	subq	$0x1e8, %rsp            # imm = 0x1E8
1800019e3:     	movapd	%xmm15, 0x1d0(%rsp)
1800019ed:     	movapd	%xmm14, 0x1c0(%rsp)
1800019f7:     	movapd	%xmm13, 0x1b0(%rsp)
180001a01:     	movapd	%xmm12, 0x1a0(%rsp)
180001a0b:     	movapd	%xmm11, 0x190(%rsp)
180001a15:     	movapd	%xmm10, 0x180(%rsp)
180001a1f:     	movapd	%xmm9, 0x170(%rsp)
180001a29:     	movapd	%xmm8, 0x160(%rsp)
180001a33:     	movapd	%xmm7, 0x150(%rsp)
180001a3c:     	movaps	%xmm6, 0x140(%rsp)
180001a44:     	movq	%r9, %rbx
180001a47:     	movq	%r8, %r14
180001a4a:     	movq	%rdx, %rdi
180001a4d:     	movq	%rcx, %rsi
180001a50:     	movq	0x268(%rsp), %r15
180001a58:     	movq	0x258(%rsp), %r13
180001a60:     	movq	0x250(%rsp), %rbp
180001a68:     	movq	$0x0, 0xb0(%rsp)
180001a74:     	movb	$0x0, 0xb8(%rsp)
180001a7c:     	movq	$0x0, 0xc0(%rsp)
180001a88:     	movb	$0x0, 0xc8(%rsp)
180001a90:     	movq	$0x0, 0xd0(%rsp)
180001a9c:     	movb	$0x0, 0xd8(%rsp)
180001aa4:     	movq	$0x0, 0xe0(%rsp)
180001ab0:     	movb	$0x0, 0xe8(%rsp)
180001ab8:     	movq	$0x0, 0xf0(%rsp)
180001ac4:     	movb	$0x0, 0xf8(%rsp)
180001acc:     	movq	$0x0, 0x100(%rsp)
180001ad8:     	movb	$0x0, 0x108(%rsp)
180001ae0:     	movq	$0x0, 0x138(%rsp)
180001aec:     	xorps	%xmm6, %xmm6
180001aef:     	cvtsi2sdq	(%r9,%r15,8), %xmm6
180001af5:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b0
180001afd:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b8
180001b05:     	divsd	0x78b3(%rip), %xmm6     # 0x1800093c0
180001b0d:     	movapd	%xmm6, %xmm0
180001b11:     	callq	0x180008e3c <numba_list_iter_next+0xe7c>
180001b16:     	ucomisd	%xmm0, %xmm0
180001b1a:     	jp	0x180001b70 <PyInit_rcaotr_61fae00d4878711302f71448+0x200>
180001b1c:     	movq	%xmm0, %rax
180001b21:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
180001b2b:     	andq	%rcx, %rax
180001b2e:     	movabsq	$0x7ff0000000000000, %rdx # imm = 0x7FF0000000000000
180001b38:     	cmpq	%rdx, %rax
180001b3b:     	setne	%al
180001b3e:     	movq	%xmm6, %r8
180001b43:     	andq	%rcx, %r8
180001b46:     	cmpq	%rdx, %r8
180001b49:     	sete	%cl
180001b4c:     	orb	%al, %cl
180001b4e:     	je	0x180001b70 <PyInit_rcaotr_61fae00d4878711302f71448+0x200>
180001b50:     	movq	0x270(%rsp), %r12
180001b58:     	movq	0x10(%rbx,%r12,8), %rcx
180001b5d:     	movq	%rcx, %rax
180001b60:     	negq	%rax
180001b63:     	jno	0x180001bf2 <PyInit_rcaotr_61fae00d4878711302f71448+0x282>
180001b69:     	movb	$0x1, (%r13)
180001b6e:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001b70:     	movb	$0x1, (%r13)
180001b75:     	movq	$0x3, 0x18(%rbp)
180001b7d:     	xorl	%eax, %eax
180001b7f:     	movq	$0x0, (%rsi)
180001b86:     	movaps	0x140(%rsp), %xmm6
180001b8e:     	movaps	0x150(%rsp), %xmm7
180001b96:     	movaps	0x160(%rsp), %xmm8
180001b9f:     	movaps	0x170(%rsp), %xmm9
180001ba8:     	movaps	0x180(%rsp), %xmm10
180001bb1:     	movaps	0x190(%rsp), %xmm11
180001bba:     	movaps	0x1a0(%rsp), %xmm12
180001bc3:     	movaps	0x1b0(%rsp), %xmm13
180001bcc:     	movaps	0x1c0(%rsp), %xmm14
180001bd5:     	movaps	0x1d0(%rsp), %xmm15
180001bde:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180001be5:     	popq	%rbx
180001be6:     	popq	%rbp
180001be7:     	popq	%rdi
180001be8:     	popq	%rsi
180001be9:     	popq	%r12
180001beb:     	popq	%r13
180001bed:     	popq	%r14
180001bef:     	popq	%r15
180001bf1:     	retq
180001bf2:     	xorl	%eax, %eax
180001bf4:     	cmpb	$0x0, (%r13)
180001bf9:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001bfb:     	decq	%rcx
180001bfe:     	je	0x180001c1e <PyInit_rcaotr_61fae00d4878711302f71448+0x2ae>
180001c00:     	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
180001c0a:     	movq	0x8(%rbx,%r12,8), %rdx
180001c0f:     	cmpq	%r8, %rdx
180001c12:     	jne	0x180001c30 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c0>
180001c14:     	movb	$0x1, (%r13)
180001c19:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001c1e:     	movb	$0x1, (%r13)
180001c23:     	movq	$0x7, 0x18(%rbp)
180001c2b:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001c30:     	decq	%rdx
180001c33:     	je	0x180001d65 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f5>
180001c39:     	movq	0x260(%rsp), %r11
180001c41:     	movq	0x10(%rbx,%r15,8), %r8
180001c46:     	movq	0x20(%rbx,%r15,8), %r9
180001c4b:     	movsd	(%r14,%r8,8), %xmm1
180001c51:     	subsd	(%r14,%r9,8), %xmm1
180001c57:     	movapd	0x7771(%rip), %xmm2     # 0x1800093d0
180001c5f:     	andpd	%xmm1, %xmm2
180001c63:     	ucomisd	0x7775(%rip), %xmm2     # 0x1800093e0
180001c6b:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001c71:     	movsd	0x10(%r14,%r8,8), %xmm2
180001c78:     	subsd	0x10(%r14,%r9,8), %xmm2
180001c7f:     	movapd	0x7749(%rip), %xmm3     # 0x1800093d0
180001c87:     	andpd	%xmm2, %xmm3
180001c8b:     	ucomisd	0x774d(%rip), %xmm3     # 0x1800093e0
180001c93:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001c99:     	movsd	0x20(%r14,%r8,8), %xmm3
180001ca0:     	subsd	0x20(%r14,%r9,8), %xmm3
180001ca7:     	movapd	0x7721(%rip), %xmm4     # 0x1800093d0
180001caf:     	andpd	%xmm3, %xmm4
180001cb3:     	ucomisd	0x7725(%rip), %xmm4     # 0x1800093e0
180001cbb:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001cbd:     	movq	(%rbp), %r10
180001cc1:     	leaq	0x6(%r10), %r8
180001cc5:     	cmpq	%r11, %r8
180001cc8:     	jg	0x180001d5b <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb>
180001cce:     	movq	%r8, (%rbp)
180001cd2:     	cmpb	$0x0, (%r13)
180001cd7:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001cdd:     	movsd	%xmm1, (%r14,%r10,8)
180001ce3:     	movsd	%xmm2, 0x10(%r14,%r10,8)
180001cea:     	movsd	%xmm3, 0x20(%r14,%r10,8)
180001cf1:     	movq	%r10, 0x78(%rsp)
180001cf6:     	movzbl	(%r13), %r10d
180001cfb:     	xorl	%r8d, %r8d
180001cfe:     	movl	%r10d, %r11d
180001d01:     	negb	%r11b
180001d04:     	movq	0x260(%rsp), %r11
180001d0c:     	sbbq	%r8, %r8
180001d0f:     	orq	0x78(%rsp), %r8
180001d14:     	testb	%r10b, %r10b
180001d17:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d1d:     	jmp	0x180001d41 <PyInit_rcaotr_61fae00d4878711302f71448+0x3d1>
180001d1f:     	movb	$0x1, (%r13)
180001d24:     	movq	$0xf4243, 0x18(%rbp)    # imm = 0xF4243
180001d2c:     	movzbl	(%r13), %r10d
180001d31:     	movq	$-0x1, %r8
180001d38:     	testb	%r10b, %r10b
180001d3b:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d41:     	movq	%r8, 0x78(%rsp)
180001d46:     	movq	(%rbp), %r8
180001d4a:     	movq	%r8, 0x80(%rsp)
180001d52:     	leaq	0x2(%r8), %r10
180001d56:     	cmpq	%r11, %r10
180001d59:     	jle	0x180001d77 <PyInit_rcaotr_61fae00d4878711302f71448+0x407>
180001d5b:     	movb	$0x2, (%r13)
180001d60:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d65:     	movb	$0x1, (%r13)
180001d6a:     	movq	$0x8, 0x18(%rbp)
180001d72:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d77:     	movq	%r10, (%rbp)
180001d7b:     	cmpb	$0x0, (%r13)
180001d80:     	movq	0x78(%rsp), %r8
180001d85:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d8b:     	movq	0x80(%rsp), %r10
180001d93:     	movq	%r9, (%rbx,%r10,8)
180001d97:     	cmpb	$0x0, (%r13)
180001d9c:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001da2:     	movsd	(%r14,%r8,8), %xmm1
180001da8:     	mulsd	%xmm1, %xmm1
180001dac:     	movapd	0x761c(%rip), %xmm2     # 0x1800093d0
180001db4:     	andpd	%xmm1, %xmm2
180001db8:     	ucomisd	0x7620(%rip), %xmm2     # 0x1800093e0
180001dc0:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001dc2:     	movsd	0x10(%r14,%r8,8), %xmm2
180001dc9:     	mulsd	%xmm2, %xmm2
180001dcd:     	movapd	0x75fb(%rip), %xmm3     # 0x1800093d0
180001dd5:     	andpd	%xmm2, %xmm3
180001dd9:     	ucomisd	0x75ff(%rip), %xmm3     # 0x1800093e0
180001de1:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001de3:     	addsd	%xmm2, %xmm1
180001de7:     	movapd	0x75e1(%rip), %xmm2     # 0x1800093d0
180001def:     	andpd	%xmm1, %xmm2
180001df3:     	ucomisd	0x75e5(%rip), %xmm2     # 0x1800093e0
180001dfb:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001dfd:     	movsd	0x20(%r14,%r8,8), %xmm2
180001e04:     	mulsd	%xmm2, %xmm2
180001e08:     	movapd	0x75c0(%rip), %xmm3     # 0x1800093d0
180001e10:     	andpd	%xmm2, %xmm3
180001e14:     	ucomisd	0x75c4(%rip), %xmm3     # 0x1800093e0
180001e1c:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001e1e:     	addsd	%xmm2, %xmm1
180001e22:     	movapd	0x75a6(%rip), %xmm2     # 0x1800093d0
180001e2a:     	andpd	%xmm1, %xmm2
180001e2e:     	ucomisd	0x75aa(%rip), %xmm2     # 0x1800093e0
180001e36:     	jb	0x180001e49 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d9>
180001e38:     	movb	$0x1, (%r13)
180001e3d:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001e45:     	xorpd	%xmm1, %xmm1
180001e49:     	cmpb	$0x0, (%r13)
180001e4e:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001e54:     	sqrtsd	%xmm1, %xmm1
180001e58:     	xorpd	%xmm2, %xmm2
180001e5c:     	ucomisd	%xmm2, %xmm1
180001e60:     	jne	0x180002044 <PyInit_rcaotr_61fae00d4878711302f71448+0x6d4>
180001e66:     	jp	0x180002044 <PyInit_rcaotr_61fae00d4878711302f71448+0x6d4>
180001e6c:     	movb	$0x1, (%r13)
180001e71:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001e79:     	movzbl	(%r13), %r8d
180001e7e:     	movq	$-0x1, %r9
180001e85:     	testb	%r8b, %r8b
180001e88:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001e8e:     	movq	0x80(%rsp), %rax
180001e96:     	movq	%r9, 0x8(%rbx,%rax,8)
180001e9b:     	cmpb	$0x0, (%r13)
180001ea0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001ea6:     	movq	0x80(%rsp), %rax
180001eae:     	movq	0x8(%rbx,%rax,8), %rax
180001eb3:     	movq	(%rbx), %r8
180001eb6:     	movsd	0x10(%r14,%rax,8), %xmm4
180001ebd:     	movsd	0x20(%r14,%r8,8), %xmm5
180001ec4:     	movapd	%xmm4, %xmm1
180001ec8:     	mulsd	%xmm5, %xmm1
180001ecc:     	movapd	0x74fc(%rip), %xmm2     # 0x1800093d0
180001ed4:     	andpd	%xmm1, %xmm2
180001ed8:     	ucomisd	0x7500(%rip), %xmm2     # 0x1800093e0
180001ee0:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001ee6:     	movsd	0x20(%r14,%rax,8), %xmm2
180001eed:     	movsd	0x10(%r14,%r8,8), %xmm3
180001ef4:     	movapd	%xmm2, %xmm6
180001ef8:     	mulsd	%xmm3, %xmm6
180001efc:     	movapd	0x74cc(%rip), %xmm7     # 0x1800093d0
180001f04:     	andpd	%xmm6, %xmm7
180001f08:     	ucomisd	0x74d0(%rip), %xmm7     # 0x1800093e0
180001f10:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f16:     	subsd	%xmm6, %xmm1
180001f1a:     	movapd	0x74ae(%rip), %xmm6     # 0x1800093d0
180001f22:     	andpd	%xmm1, %xmm6
180001f26:     	ucomisd	0x74b2(%rip), %xmm6     # 0x1800093e0
180001f2e:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f34:     	movsd	(%r14,%r8,8), %xmm6
180001f3a:     	mulsd	%xmm6, %xmm2
180001f3e:     	movapd	0x748a(%rip), %xmm7     # 0x1800093d0
180001f46:     	andpd	%xmm2, %xmm7
180001f4a:     	ucomisd	0x748e(%rip), %xmm7     # 0x1800093e0
180001f52:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f58:     	movsd	(%r14,%rax,8), %xmm7
180001f5e:     	mulsd	%xmm7, %xmm5
180001f62:     	movapd	0x7465(%rip), %xmm8     # 0x1800093d0
180001f6b:     	andpd	%xmm5, %xmm8
180001f70:     	ucomisd	0x7467(%rip), %xmm8     # 0x1800093e0
180001f79:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f7f:     	subsd	%xmm5, %xmm2
180001f83:     	movapd	0x7445(%rip), %xmm5     # 0x1800093d0
180001f8b:     	andpd	%xmm2, %xmm5
180001f8f:     	ucomisd	0x7449(%rip), %xmm5     # 0x1800093e0
180001f97:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f9d:     	mulsd	%xmm7, %xmm3
180001fa1:     	movapd	0x7427(%rip), %xmm5     # 0x1800093d0
180001fa9:     	andpd	%xmm3, %xmm5
180001fad:     	ucomisd	0x742b(%rip), %xmm5     # 0x1800093e0
180001fb5:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001fbb:     	mulsd	%xmm6, %xmm4
180001fbf:     	movapd	0x7409(%rip), %xmm5     # 0x1800093d0
180001fc7:     	andpd	%xmm4, %xmm5
180001fcb:     	ucomisd	0x740d(%rip), %xmm5     # 0x1800093e0
180001fd3:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001fd9:     	subsd	%xmm4, %xmm3
180001fdd:     	movapd	0x73eb(%rip), %xmm4     # 0x1800093d0
180001fe5:     	andpd	%xmm3, %xmm4
180001fe9:     	ucomisd	0x73ef(%rip), %xmm4     # 0x1800093e0
180001ff1:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001ff7:     	movq	(%rbp), %r8
180001ffb:     	leaq	0x6(%r8), %rax
180001fff:     	cmpq	0x260(%rsp), %rax
180002007:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002009:     	movq	%rax, (%rbp)
18000200d:     	cmpb	$0x0, (%r13)
180002012:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002018:     	movsd	%xmm1, (%r14,%r8,8)
18000201e:     	movsd	%xmm2, 0x10(%r14,%r8,8)
180002025:     	movsd	%xmm3, 0x20(%r14,%r8,8)
18000202c:     	movzbl	(%r13), %r9d
180002031:     	xorl	%eax, %eax
180002033:     	movl	%r9d, %r10d
180002036:     	negb	%r10b
180002039:     	sbbq	%rax, %rax
18000203c:     	orq	%r8, %rax
18000203f:     	jmp	0x1800020ea <PyInit_rcaotr_61fae00d4878711302f71448+0x77a>
180002044:     	movq	(%rbp), %rax
180002048:     	leaq	0x6(%rax), %r9
18000204c:     	cmpq	%r11, %r9
18000204f:     	jle	0x18000205b <PyInit_rcaotr_61fae00d4878711302f71448+0x6eb>
180002051:     	movb	$0x2, (%r13)
180002056:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000205b:     	movq	0x78(%rsp), %r8
180002060:     	movsd	(%r14,%r8,8), %xmm2
180002066:     	movsd	0x10(%r14,%r8,8), %xmm3
18000206d:     	movsd	0x20(%r14,%r8,8), %xmm4
180002074:     	movq	%r9, (%rbp)
180002078:     	cmpb	$0x0, (%r13)
18000207d:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002083:     	movsd	0x735d(%rip), %xmm5     # 0x1800093e8
18000208b:     	divsd	%xmm1, %xmm5
18000208f:     	mulsd	%xmm5, %xmm2
180002093:     	mulsd	%xmm5, %xmm3
180002097:     	mulsd	%xmm4, %xmm5
18000209b:     	movsd	%xmm2, (%r14,%rax,8)
1800020a1:     	movsd	%xmm3, 0x10(%r14,%rax,8)
1800020a8:     	movsd	%xmm5, 0x20(%r14,%rax,8)
1800020af:     	movzbl	(%r13), %r8d
1800020b4:     	xorl	%r9d, %r9d
1800020b7:     	movl	%r8d, %r10d
1800020ba:     	negb	%r10b
1800020bd:     	sbbq	%r9, %r9
1800020c0:     	orq	%rax, %r9
1800020c3:     	testb	%r8b, %r8b
1800020c6:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800020cc:     	jmp	0x180001e8e <PyInit_rcaotr_61fae00d4878711302f71448+0x51e>
1800020d1:     	movb	$0x1, (%r13)
1800020d6:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
1800020de:     	movzbl	(%r13), %r9d
1800020e3:     	movq	$-0x1, %rax
1800020ea:     	testb	%r9b, %r9b
1800020ed:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800020f3:     	movsd	(%r14,%rax,8), %xmm1
1800020f9:     	mulsd	%xmm1, %xmm1
1800020fd:     	movapd	0x72cb(%rip), %xmm2     # 0x1800093d0
180002105:     	andpd	%xmm1, %xmm2
180002109:     	ucomisd	0x72cf(%rip), %xmm2     # 0x1800093e0
180002111:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
180002113:     	movsd	0x10(%r14,%rax,8), %xmm2
18000211a:     	mulsd	%xmm2, %xmm2
18000211e:     	movapd	0x72aa(%rip), %xmm3     # 0x1800093d0
180002126:     	andpd	%xmm2, %xmm3
18000212a:     	ucomisd	0x72ae(%rip), %xmm3     # 0x1800093e0
180002132:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
180002134:     	addsd	%xmm2, %xmm1
180002138:     	movapd	0x7290(%rip), %xmm2     # 0x1800093d0
180002140:     	andpd	%xmm1, %xmm2
180002144:     	ucomisd	0x7294(%rip), %xmm2     # 0x1800093e0
18000214c:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
18000214e:     	movsd	0x20(%r14,%rax,8), %xmm2
180002155:     	mulsd	%xmm2, %xmm2
180002159:     	movapd	0x726f(%rip), %xmm3     # 0x1800093d0
180002161:     	andpd	%xmm2, %xmm3
180002165:     	ucomisd	0x7273(%rip), %xmm3     # 0x1800093e0
18000216d:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
18000216f:     	addsd	%xmm2, %xmm1
180002173:     	movapd	0x7255(%rip), %xmm2     # 0x1800093d0
18000217b:     	andpd	%xmm1, %xmm2
18000217f:     	ucomisd	0x7259(%rip), %xmm2     # 0x1800093e0
180002187:     	jb	0x18000219a <PyInit_rcaotr_61fae00d4878711302f71448+0x82a>
180002189:     	movb	$0x1, (%r13)
18000218e:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180002196:     	xorpd	%xmm1, %xmm1
18000219a:     	cmpb	$0x0, (%r13)
18000219f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800021a5:     	sqrtsd	%xmm1, %xmm1
1800021a9:     	xorpd	%xmm2, %xmm2
1800021ad:     	ucomisd	%xmm2, %xmm1
1800021b1:     	jne	0x18000238e <PyInit_rcaotr_61fae00d4878711302f71448+0xa1e>
1800021b7:     	jp	0x18000238e <PyInit_rcaotr_61fae00d4878711302f71448+0xa1e>
1800021bd:     	movb	$0x1, (%r13)
1800021c2:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800021ca:     	movzbl	(%r13), %eax
1800021cf:     	movq	$-0x1, 0x78(%rsp)
1800021d8:     	testb	%al, %al
1800021da:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800021e0:     	movq	0x80(%rsp), %rax
1800021e8:     	movq	0x8(%rbx,%rax,8), %rax
1800021ed:     	movq	0x78(%rsp), %r8
1800021f2:     	movsd	0x10(%r14,%r8,8), %xmm4
1800021f9:     	movsd	0x20(%r14,%rax,8), %xmm5
180002200:     	movapd	%xmm4, %xmm1
180002204:     	mulsd	%xmm5, %xmm1
180002208:     	movapd	0x71c0(%rip), %xmm2     # 0x1800093d0
180002210:     	andpd	%xmm1, %xmm2
180002214:     	ucomisd	0x71c4(%rip), %xmm2     # 0x1800093e0
18000221c:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002222:     	movq	0x78(%rsp), %r8
180002227:     	movsd	0x20(%r14,%r8,8), %xmm2
18000222e:     	movsd	0x10(%r14,%rax,8), %xmm3
180002235:     	movapd	%xmm2, %xmm6
180002239:     	mulsd	%xmm3, %xmm6
18000223d:     	movapd	0x718b(%rip), %xmm7     # 0x1800093d0
180002245:     	andpd	%xmm6, %xmm7
180002249:     	ucomisd	0x718f(%rip), %xmm7     # 0x1800093e0
180002251:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002257:     	subsd	%xmm6, %xmm1
18000225b:     	movapd	0x716d(%rip), %xmm6     # 0x1800093d0
180002263:     	andpd	%xmm1, %xmm6
180002267:     	ucomisd	0x7171(%rip), %xmm6     # 0x1800093e0
18000226f:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002275:     	movsd	(%r14,%rax,8), %xmm6
18000227b:     	mulsd	%xmm6, %xmm2
18000227f:     	movapd	0x7149(%rip), %xmm7     # 0x1800093d0
180002287:     	andpd	%xmm2, %xmm7
18000228b:     	ucomisd	0x714d(%rip), %xmm7     # 0x1800093e0
180002293:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002299:     	movq	0x78(%rsp), %rax
18000229e:     	movsd	(%r14,%rax,8), %xmm7
1800022a4:     	mulsd	%xmm7, %xmm5
1800022a8:     	movapd	0x711f(%rip), %xmm8     # 0x1800093d0
1800022b1:     	andpd	%xmm5, %xmm8
1800022b6:     	ucomisd	0x7121(%rip), %xmm8     # 0x1800093e0
1800022bf:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
1800022c5:     	subsd	%xmm5, %xmm2
1800022c9:     	movapd	0x70ff(%rip), %xmm5     # 0x1800093d0
1800022d1:     	andpd	%xmm2, %xmm5
1800022d5:     	ucomisd	0x7103(%rip), %xmm5     # 0x1800093e0
1800022dd:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
1800022e3:     	mulsd	%xmm7, %xmm3
1800022e7:     	movapd	0x70e1(%rip), %xmm5     # 0x1800093d0
1800022ef:     	andpd	%xmm3, %xmm5
1800022f3:     	ucomisd	0x70e5(%rip), %xmm5     # 0x1800093e0
1800022fb:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002301:     	mulsd	%xmm6, %xmm4
180002305:     	movapd	0x70c3(%rip), %xmm5     # 0x1800093d0
18000230d:     	andpd	%xmm4, %xmm5
180002311:     	ucomisd	0x70c7(%rip), %xmm5     # 0x1800093e0
180002319:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
18000231f:     	subsd	%xmm4, %xmm3
180002323:     	movapd	0x70a5(%rip), %xmm4     # 0x1800093d0
18000232b:     	andpd	%xmm3, %xmm4
18000232f:     	ucomisd	0x70a9(%rip), %xmm4     # 0x1800093e0
180002337:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
18000233d:     	movq	(%rbp), %r8
180002341:     	leaq	0x6(%r8), %rax
180002345:     	cmpq	0x260(%rsp), %rax
18000234d:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002353:     	movq	%rax, (%rbp)
180002357:     	cmpb	$0x0, (%r13)
18000235c:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002362:     	movsd	%xmm1, (%r14,%r8,8)
180002368:     	movsd	%xmm2, 0x10(%r14,%r8,8)
18000236f:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002376:     	movzbl	(%r13), %r9d
18000237b:     	xorl	%eax, %eax
18000237d:     	movl	%r9d, %r10d
180002380:     	negb	%r10b
180002383:     	sbbq	%rax, %rax
180002386:     	orq	%r8, %rax
180002389:     	jmp	0x180002432 <PyInit_rcaotr_61fae00d4878711302f71448+0xac2>
18000238e:     	movq	(%rbp), %r8
180002392:     	leaq	0x6(%r8), %r9
180002396:     	cmpq	0x260(%rsp), %r9
18000239e:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800023a4:     	movsd	(%r14,%rax,8), %xmm2
1800023aa:     	movsd	0x10(%r14,%rax,8), %xmm3
1800023b1:     	movsd	0x20(%r14,%rax,8), %xmm4
1800023b8:     	movq	%r9, (%rbp)
1800023bc:     	cmpb	$0x0, (%r13)
1800023c1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800023c7:     	movsd	0x7019(%rip), %xmm5     # 0x1800093e8
1800023cf:     	divsd	%xmm1, %xmm5
1800023d3:     	mulsd	%xmm5, %xmm2
1800023d7:     	mulsd	%xmm5, %xmm3
1800023db:     	mulsd	%xmm4, %xmm5
1800023df:     	movsd	%xmm2, (%r14,%r8,8)
1800023e5:     	movsd	%xmm3, 0x10(%r14,%r8,8)
1800023ec:     	movsd	%xmm5, 0x20(%r14,%r8,8)
1800023f3:     	movzbl	(%r13), %eax
1800023f8:     	xorl	%r10d, %r10d
1800023fb:     	movl	%eax, %r9d
1800023fe:     	negb	%r9b
180002401:     	sbbq	%r10, %r10
180002404:     	orq	%r8, %r10
180002407:     	movq	%r10, 0x78(%rsp)
18000240c:     	testb	%al, %al
18000240e:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002414:     	jmp	0x1800021e0 <PyInit_rcaotr_61fae00d4878711302f71448+0x870>
180002419:     	movb	$0x1, (%r13)
18000241e:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
180002426:     	movzbl	(%r13), %r9d
18000242b:     	movq	$-0x1, %rax
180002432:     	testb	%r9b, %r9b
180002435:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000243b:     	movsd	(%r14,%rax,8), %xmm1
180002441:     	mulsd	%xmm1, %xmm1
180002445:     	movapd	0x6f83(%rip), %xmm2     # 0x1800093d0
18000244d:     	andpd	%xmm1, %xmm2
180002451:     	ucomisd	0x6f87(%rip), %xmm2     # 0x1800093e0
180002459:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
18000245b:     	movsd	0x10(%r14,%rax,8), %xmm2
180002462:     	mulsd	%xmm2, %xmm2
180002466:     	movapd	0x6f62(%rip), %xmm3     # 0x1800093d0
18000246e:     	andpd	%xmm2, %xmm3
180002472:     	ucomisd	0x6f66(%rip), %xmm3     # 0x1800093e0
18000247a:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
18000247c:     	addsd	%xmm2, %xmm1
180002480:     	movapd	0x6f48(%rip), %xmm2     # 0x1800093d0
180002488:     	andpd	%xmm1, %xmm2
18000248c:     	ucomisd	0x6f4c(%rip), %xmm2     # 0x1800093e0
180002494:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
180002496:     	movsd	0x20(%r14,%rax,8), %xmm2
18000249d:     	mulsd	%xmm2, %xmm2
1800024a1:     	movapd	0x6f27(%rip), %xmm3     # 0x1800093d0
1800024a9:     	andpd	%xmm2, %xmm3
1800024ad:     	ucomisd	0x6f2b(%rip), %xmm3     # 0x1800093e0
1800024b5:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
1800024b7:     	addsd	%xmm2, %xmm1
1800024bb:     	movapd	0x6f0d(%rip), %xmm2     # 0x1800093d0
1800024c3:     	andpd	%xmm1, %xmm2
1800024c7:     	ucomisd	0x6f11(%rip), %xmm2     # 0x1800093e0
1800024cf:     	jb	0x1800024e2 <PyInit_rcaotr_61fae00d4878711302f71448+0xb72>
1800024d1:     	movb	$0x1, (%r13)
1800024d6:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800024de:     	xorpd	%xmm1, %xmm1
1800024e2:     	cmpb	$0x0, (%r13)
1800024e7:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800024ed:     	sqrtsd	%xmm1, %xmm1
1800024f1:     	xorpd	%xmm2, %xmm2
1800024f5:     	ucomisd	%xmm2, %xmm1
1800024f9:     	jne	0x180002f0c <PyInit_rcaotr_61fae00d4878711302f71448+0x159c>
1800024ff:     	jp	0x180002f0c <PyInit_rcaotr_61fae00d4878711302f71448+0x159c>
180002505:     	movb	$0x1, (%r13)
18000250a:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180002512:     	movzbl	(%r13), %eax
180002517:     	movq	$-0x8, 0xa8(%rsp)
180002523:     	testb	%al, %al
180002525:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000252b:     	movq	0x8(%rbx,%r12,8), %rax
180002530:     	movq	%rax, 0x120(%rsp)
180002538:     	testq	%rax, %rax
18000253b:     	jle	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002541:     	movsd	0x6e7f(%rip), %xmm6     # 0x1800093c8
180002549:     	movapd	%xmm0, %xmm8
18000254e:     	mulsd	%xmm0, %xmm6
180002552:     	movapd	%xmm0, %xmm7
180002556:     	addsd	%xmm0, %xmm8
18000255b:     	cvtsi2sd	%rcx, %xmm0
180002560:     	divsd	%xmm0, %xmm8
180002565:     	movapd	%xmm6, %xmm9
18000256a:     	addsd	%xmm6, %xmm9
18000256f:     	xorps	%xmm0, %xmm0
180002572:     	cvtsi2sd	%rdx, %xmm0
180002577:     	divsd	%xmm0, %xmm9
18000257c:     	movq	$-0x1, 0xa0(%rsp)
180002588:     	movapd	0x6e3f(%rip), %xmm10    # 0x1800093d0
180002591:     	movsd	0x6e46(%rip), %xmm11    # 0x1800093e0
18000259a:     	xorpd	%xmm12, %xmm12
18000259f:     	movsd	0x6e48(%rip), %xmm13    # 0x1800093f0
1800025a8:     	movsd	0x6e4f(%rip), %xmm15    # 0x180009400
1800025b1:     	movq	$0x0, 0x98(%rsp)
1800025bd:     	movq	0x98(%rsp), %rcx
1800025c5:     	leaq	0x1(%rcx), %rax
1800025c9:     	movq	%rax, 0x98(%rsp)
1800025d1:     	movq	0x10(%rbx,%r12,8), %rdx
1800025d6:     	testq	%rdx, %rdx
1800025d9:     	movl	$0x0, %eax
1800025de:     	cmovleq	%rax, %rdx
1800025e2:     	movq	%rdx, 0x130(%rsp)
1800025ea:     	movq	%rcx, 0x128(%rsp)
1800025f2:     	xorps	%xmm14, %xmm14
1800025f6:     	cvtsi2sd	%rcx, %xmm14
1800025fb:     	mulsd	%xmm9, %xmm14
180002600:     	subsd	%xmm6, %xmm14
180002605:     	movq	$0x0, 0x88(%rsp)
180002611:     	movq	0x88(%rsp), %rax
180002619:     	cmpq	%rax, 0x130(%rsp)
180002621:     	je	0x180002ee9 <PyInit_rcaotr_61fae00d4878711302f71448+0x1579>
180002627:     	movq	(%rbp), %rdx
18000262b:     	leaq	0x6(%rdx), %rax
18000262f:     	cmpq	0x260(%rsp), %rax
180002637:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
18000263d:     	movq	0x78(%rsp), %rcx
180002642:     	movsd	(%r14,%rcx,8), %xmm0
180002648:     	movsd	0x10(%r14,%rcx,8), %xmm1
18000264f:     	movsd	0x20(%r14,%rcx,8), %xmm2
180002656:     	movq	%rax, (%rbp)
18000265a:     	cmpb	$0x0, (%r13)
18000265f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002665:     	xorps	%xmm3, %xmm3
180002668:     	cvtsi2sdq	0x88(%rsp), %xmm3
180002672:     	mulsd	%xmm8, %xmm3
180002677:     	subsd	%xmm7, %xmm3
18000267b:     	mulsd	%xmm3, %xmm0
18000267f:     	mulsd	%xmm3, %xmm1
180002683:     	mulsd	%xmm2, %xmm3
180002687:     	movsd	%xmm0, (%r14,%rdx,8)
18000268d:     	movsd	%xmm1, 0x10(%r14,%rdx,8)
180002694:     	movsd	%xmm3, 0x20(%r14,%rdx,8)
18000269b:     	cmpb	$0x0, (%r13)
1800026a0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800026a6:     	movq	(%rbp), %rax
1800026aa:     	leaq	0x6(%rax), %rcx
1800026ae:     	cmpq	0x260(%rsp), %rcx
1800026b6:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800026bc:     	movq	0xa8(%rsp), %r8
1800026c4:     	movsd	(%r14,%r8), %xmm0
1800026ca:     	movsd	0x10(%r14,%r8), %xmm1
1800026d1:     	movsd	0x20(%r14,%r8), %xmm2
1800026d8:     	movq	%rcx, (%rbp)
1800026dc:     	cmpb	$0x0, (%r13)
1800026e1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800026e7:     	mulsd	%xmm14, %xmm0
1800026ec:     	mulsd	%xmm14, %xmm1
1800026f1:     	mulsd	%xmm14, %xmm2
1800026f6:     	movsd	%xmm0, (%r14,%rax,8)
1800026fc:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002703:     	movsd	%xmm2, 0x20(%r14,%rax,8)
18000270a:     	cmpb	$0x0, (%r13)
18000270f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002715:     	movq	0x80(%rsp), %r8
18000271d:     	movq	(%rbx,%r8,8), %rcx
180002721:     	movq	0x8(%rbx,%r8,8), %r8
180002726:     	movsd	(%r14,%r8,8), %xmm0
18000272c:     	addsd	(%r14,%rdx,8), %xmm0
180002732:     	movapd	%xmm0, %xmm1
180002736:     	andpd	%xmm10, %xmm1
18000273b:     	ucomisd	%xmm11, %xmm1
180002740:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002746:     	movsd	0x10(%r14,%r8,8), %xmm1
18000274d:     	addsd	0x10(%r14,%rdx,8), %xmm1
180002754:     	movapd	%xmm1, %xmm2
180002758:     	andpd	%xmm10, %xmm2
18000275d:     	ucomisd	%xmm11, %xmm2
180002762:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002764:     	movsd	0x20(%r14,%r8,8), %xmm2
18000276b:     	addsd	0x20(%r14,%rdx,8), %xmm2
180002772:     	movapd	%xmm2, %xmm3
180002776:     	andpd	%xmm10, %xmm3
18000277b:     	ucomisd	%xmm11, %xmm3
180002780:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002782:     	movq	(%rbp), %r8
180002786:     	leaq	0x6(%r8), %rdx
18000278a:     	cmpq	0x260(%rsp), %rdx
180002792:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002798:     	movq	%rdx, (%rbp)
18000279c:     	cmpb	$0x0, (%r13)
1800027a1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800027a7:     	movsd	%xmm0, (%r14,%r8,8)
1800027ad:     	movsd	%xmm1, 0x10(%r14,%r8,8)
1800027b4:     	movsd	%xmm2, 0x20(%r14,%r8,8)
1800027bb:     	movzbl	(%r13), %r9d
1800027c0:     	movl	%r9d, %edx
1800027c3:     	negb	%dl
1800027c5:     	movl	$0x0, %edx
1800027ca:     	sbbq	%rdx, %rdx
1800027cd:     	orq	%r8, %rdx
1800027d0:     	jmp	0x1800027eb <PyInit_rcaotr_61fae00d4878711302f71448+0xe7b>
1800027d2:     	movb	$0x1, (%r13)
1800027d7:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800027df:     	movzbl	(%r13), %r9d
1800027e4:     	movq	$-0x1, %rdx
1800027eb:     	testb	%r9b, %r9b
1800027ee:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800027f4:     	movsd	(%r14,%rdx,8), %xmm0
1800027fa:     	addsd	(%r14,%rax,8), %xmm0
180002800:     	movapd	%xmm0, %xmm1
180002804:     	andpd	%xmm10, %xmm1
180002809:     	ucomisd	%xmm11, %xmm1
18000280e:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002814:     	movsd	0x10(%r14,%rdx,8), %xmm1
18000281b:     	addsd	0x10(%r14,%rax,8), %xmm1
180002822:     	movapd	%xmm1, %xmm2
180002826:     	andpd	%xmm10, %xmm2
18000282b:     	ucomisd	%xmm11, %xmm2
180002830:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002832:     	movsd	0x20(%r14,%rdx,8), %xmm2
180002839:     	addsd	0x20(%r14,%rax,8), %xmm2
180002840:     	movapd	%xmm2, %xmm3
180002844:     	andpd	%xmm10, %xmm3
180002849:     	ucomisd	%xmm11, %xmm3
18000284e:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002850:     	movq	(%rbp), %rax
180002854:     	leaq	0x6(%rax), %rdx
180002858:     	cmpq	0x260(%rsp), %rdx
180002860:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002866:     	movq	%rdx, (%rbp)
18000286a:     	cmpb	$0x0, (%r13)
18000286f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002875:     	movsd	%xmm0, (%r14,%rax,8)
18000287b:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002882:     	movsd	%xmm2, 0x20(%r14,%rax,8)
180002889:     	movzbl	(%r13), %r8d
18000288e:     	movl	%r8d, %edx
180002891:     	negb	%dl
180002893:     	movl	$0x0, %edx
180002898:     	sbbq	%rdx, %rdx
18000289b:     	orq	%rax, %rdx
18000289e:     	jmp	0x1800028b9 <PyInit_rcaotr_61fae00d4878711302f71448+0xf49>
1800028a0:     	movb	$0x1, (%r13)
1800028a5:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800028ad:     	movzbl	(%r13), %r8d
1800028b2:     	movq	$-0x1, %rdx
1800028b9:     	testb	%r8b, %r8b
1800028bc:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028c2:     	movq	(%rbp), %rax
1800028c6:     	leaq	0x2(%rax), %r8
1800028ca:     	cmpq	0x260(%rsp), %r8
1800028d2:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800028d8:     	movq	%r8, (%rbp)
1800028dc:     	cmpb	$0x0, (%r13)
1800028e1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028e7:     	movq	%rcx, (%rbx,%rax,8)
1800028eb:     	cmpb	$0x0, (%r13)
1800028f0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028f6:     	movsd	(%r14,%rdx,8), %xmm0
1800028fc:     	mulsd	%xmm0, %xmm0
180002900:     	movapd	%xmm0, %xmm1
180002904:     	andpd	%xmm10, %xmm1
180002909:     	ucomisd	%xmm11, %xmm1
18000290e:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
180002910:     	movsd	0x10(%r14,%rdx,8), %xmm1
180002917:     	mulsd	%xmm1, %xmm1
18000291b:     	movapd	%xmm1, %xmm2
18000291f:     	andpd	%xmm10, %xmm2
180002924:     	ucomisd	%xmm11, %xmm2
180002929:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000292b:     	addsd	%xmm1, %xmm0
18000292f:     	movapd	%xmm0, %xmm1
180002933:     	andpd	%xmm10, %xmm1
180002938:     	ucomisd	%xmm11, %xmm1
18000293d:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000293f:     	movsd	0x20(%r14,%rdx,8), %xmm1
180002946:     	mulsd	%xmm1, %xmm1
18000294a:     	movapd	%xmm1, %xmm2
18000294e:     	andpd	%xmm10, %xmm2
180002953:     	ucomisd	%xmm11, %xmm2
180002958:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000295a:     	addsd	%xmm1, %xmm0
18000295e:     	movapd	%xmm0, %xmm1
180002962:     	andpd	%xmm10, %xmm1
180002967:     	ucomisd	%xmm11, %xmm1
18000296c:     	jb	0x18000297f <PyInit_rcaotr_61fae00d4878711302f71448+0x100f>
18000296e:     	movb	$0x1, (%r13)
180002973:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
18000297b:     	xorpd	%xmm0, %xmm0
18000297f:     	cmpb	$0x0, (%r13)
180002984:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000298a:     	sqrtsd	%xmm0, %xmm0
18000298e:     	ucomisd	%xmm12, %xmm0
180002993:     	jne	0x1800029b2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1042>
180002995:     	jp	0x1800029b2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1042>
180002997:     	movb	$0x1, (%r13)
18000299c:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800029a4:     	movzbl	(%r13), %edx
1800029a9:     	movq	$-0x1, %r8
1800029b0:     	jmp	0x180002a2e <PyInit_rcaotr_61fae00d4878711302f71448+0x10be>
1800029b2:     	movq	(%rbp), %rcx
1800029b6:     	leaq	0x6(%rcx), %r8
1800029ba:     	cmpq	0x260(%rsp), %r8
1800029c2:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800029c8:     	movsd	(%r14,%rdx,8), %xmm1
1800029ce:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800029d5:     	movsd	0x20(%r14,%rdx,8), %xmm3
1800029dc:     	movq	%r8, (%rbp)
1800029e0:     	cmpb	$0x0, (%r13)
1800029e5:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800029eb:     	movsd	0x69f5(%rip), %xmm4     # 0x1800093e8
1800029f3:     	divsd	%xmm0, %xmm4
1800029f7:     	mulsd	%xmm4, %xmm1
1800029fb:     	mulsd	%xmm4, %xmm2
1800029ff:     	mulsd	%xmm3, %xmm4
180002a03:     	movsd	%xmm1, (%r14,%rcx,8)
180002a09:     	movsd	%xmm2, 0x10(%r14,%rcx,8)
180002a10:     	movsd	%xmm4, 0x20(%r14,%rcx,8)
180002a17:     	movzbl	(%r13), %edx
180002a1c:     	movl	%edx, %r8d
180002a1f:     	negb	%r8b
180002a22:     	movl	$0x0, %r8d
180002a28:     	sbbq	%r8, %r8
180002a2b:     	orq	%rcx, %r8
180002a2e:     	testb	%dl, %dl
180002a30:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002a36:     	movq	%r8, 0x8(%rbx,%rax,8)
180002a3b:     	cmpb	$0x0, (%r13)
180002a40:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002a46:     	movq	0x8(%rbp), %rcx
180002a4a:     	leaq	0x1(%rcx), %rdx
180002a4e:     	movq	%rdx, 0x8(%rbp)
180002a52:     	cmpq	0x10(%rbp), %rcx
180002a56:     	jge	0x180002fa0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1630>
180002a5c:     	movq	$0x0, 0xb0(%rsp)
180002a68:     	movb	$0x0, 0xb8(%rsp)
180002a70:     	movq	$0x0, 0xc0(%rsp)
180002a7c:     	movb	$0x0, 0xc8(%rsp)
180002a84:     	movq	$0x0, 0xd0(%rsp)
180002a90:     	movb	$0x0, 0xd8(%rsp)
180002a98:     	movq	$0x0, 0xe0(%rsp)
180002aa4:     	movb	$0x0, 0xe8(%rsp)
180002aac:     	movq	$0x0, 0xf0(%rsp)
180002ab8:     	movb	$0x0, 0xf8(%rsp)
180002ac0:     	movq	$0x0, 0x100(%rsp)
180002acc:     	movb	$0x0, 0x108(%rsp)
180002ad4:     	movq	%rax, 0x48(%rsp)
180002ad9:     	movq	%r15, 0x40(%rsp)
180002ade:     	movq	0x260(%rsp), %rax
180002ae6:     	movq	%rax, 0x30(%rsp)
180002aeb:     	movq	%r13, 0x28(%rsp)
180002af0:     	movq	%rbp, 0x20(%rsp)
180002af5:     	movq	$-0x1, 0x70(%rsp)
180002afe:     	movq	$-0x1, 0x68(%rsp)
180002b07:     	movq	$-0x1, 0x60(%rsp)
180002b10:     	movq	$-0x1, 0x58(%rsp)
180002b19:     	movq	$-0x1, 0x50(%rsp)
180002b22:     	movq	$0x0, 0x38(%rsp)
180002b2b:     	leaq	0xb0(%rsp), %rcx
180002b33:     	leaq	0x138(%rsp), %rdx
180002b3b:     	movq	%r14, %r8
180002b3e:     	movq	%rbx, %r9
180002b41:     	callq	0x180002fc0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1650>
180002b46:     	testl	%eax, %eax
180002b48:     	jne	0x180002fb2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1642>
180002b4e:     	cmpb	$0x0, (%r13)
180002b53:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002b59:     	movsd	0xb0(%rsp), %xmm2
180002b62:     	movsd	0xc0(%rsp), %xmm1
180002b6b:     	movsd	0xd0(%rsp), %xmm0
180002b74:     	decq	0x8(%rbp)
180002b78:     	movq	0x8(%rbx,%r12,8), %rax
180002b7d:     	movq	%rax, %rcx
180002b80:     	subq	0x128(%rsp), %rcx
180002b88:     	movq	%rcx, %rdx
180002b8b:     	notq	%rdx
180002b8e:     	testq	%rdx, %rax
180002b91:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002b97:     	cmpb	$0x0, (%r13)
180002b9c:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002ba2:     	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
180002bac:     	cmpq	%rdx, %rcx
180002baf:     	je	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002bb5:     	decq	%rcx
180002bb8:     	movq	0x10(%rbx,%r12,8), %rdx
180002bbd:     	cvtsi2sd	%rcx, %xmm3
180002bc2:     	cvtsi2sd	%rdx, %xmm4
180002bc7:     	mulsd	%xmm3, %xmm4
180002bcb:     	andpd	%xmm10, %xmm4
180002bd0:     	ucomisd	%xmm13, %xmm4
180002bd5:     	jae	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002bdb:     	imulq	%rdx, %rcx
180002bdf:     	addq	0xa0(%rsp), %rax
180002be7:     	imulq	%rdx, %rax
180002beb:     	movq	0x88(%rsp), %r8
180002bf3:     	addq	%r8, %rax
180002bf6:     	xorq	%rax, %rcx
180002bf9:     	movq	%rax, %rdx
180002bfc:     	xorq	%r8, %rdx
180002bff:     	testq	%rdx, %rcx
180002c02:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002c08:     	xorps	%xmm3, %xmm3
180002c0b:     	cvtsi2sd	%rax, %xmm3
180002c10:     	mulsd	0x67e0(%rip), %xmm3     # 0x1800093f8
180002c18:     	andpd	%xmm10, %xmm3
180002c1d:     	ucomisd	%xmm13, %xmm3
180002c22:     	jae	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002c28:     	mulsd	%xmm15, %xmm2
180002c2d:     	movapd	%xmm2, %xmm3
180002c31:     	andpd	%xmm10, %xmm3
180002c36:     	ucomisd	%xmm11, %xmm3
180002c3b:     	jae	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002c41:     	movsd	0x67bf(%rip), %xmm4     # 0x180009408
180002c49:     	ucomisd	%xmm3, %xmm4
180002c4d:     	jbe	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002c53:     	leaq	(%rax,%rax,2), %rcx
180002c57:     	cvttsd2si	%xmm2, %rdx
180002c5c:     	testq	%rdx, %rdx
180002c5f:     	movl	$0x0, %r8d
180002c65:     	cmovleq	%r8, %rdx
180002c69:     	cmpq	$0xff, %rdx
180002c70:     	movl	$0xff, %r8d
180002c76:     	cmovgeq	%r8, %rdx
180002c7a:     	movq	(%rbx,%r12,8), %r9
180002c7e:     	movq	%r9, %r8
180002c81:     	sarq	$0x3f, %r8
180002c85:     	andq	0x260(%rsp), %r8
180002c8d:     	leaq	(%rbx,%r9,8), %r10
180002c91:     	movq	(%r10,%r8,8), %r11
180002c95:     	testq	%rax, %rax
180002c98:     	movq	%rcx, %r8
180002c9b:     	jns	0x180002ca9 <PyInit_rcaotr_61fae00d4878711302f71448+0x1339>
180002c9d:     	movq	%r11, %r8
180002ca0:     	addq	%rcx, %r8
180002ca3:     	js	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002ca9:     	cmpq	%r11, %r8
180002cac:     	jge	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002cb2:     	cmpq	$-0x2, %r9
180002cb6:     	movl	$0x0, %r9d
180002cbc:     	movq	0x260(%rsp), %r11
180002cc4:     	cmovlq	%r11, %r9
180002cc8:     	addq	0x10(%r10,%r9,8), %r8
180002ccd:     	movq	%r8, %r9
180002cd0:     	sarq	$0x3f, %r9
180002cd4:     	andq	%r11, %r9
180002cd7:     	leaq	(%rbx,%r8,8), %r8
180002cdb:     	movq	%rdx, (%r8,%r9,8)
180002cdf:     	mulsd	%xmm15, %xmm1
180002ce4:     	movapd	%xmm1, %xmm2
180002ce8:     	andpd	%xmm10, %xmm2
180002ced:     	ucomisd	%xmm11, %xmm2
180002cf2:     	jae	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002cf8:     	movsd	0x6708(%rip), %xmm3     # 0x180009408
180002d00:     	ucomisd	%xmm2, %xmm3
180002d04:     	jbe	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002d0a:     	cvttsd2si	%xmm1, %r8
180002d0f:     	testq	%r8, %r8
180002d12:     	movl	$0x0, %edx
180002d17:     	cmovleq	%rdx, %r8
180002d1b:     	cmpq	$0xff, %r8
180002d22:     	movl	$0xff, %edx
180002d27:     	cmovgeq	%rdx, %r8
180002d2b:     	leaq	0x1(%rcx), %r9
180002d2f:     	movq	%rcx, %rdx
180002d32:     	notq	%rdx
180002d35:     	movq	%r9, 0x90(%rsp)
180002d3d:     	testq	%rdx, %r9
180002d40:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002d46:     	cmpb	$0x0, (%r13)
180002d4b:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002d51:     	movq	(%rbx,%r12,8), %r9
180002d55:     	movq	%r9, %r11
180002d58:     	sarq	$0x3f, %r11
180002d5c:     	andq	0x260(%rsp), %r11
180002d64:     	testq	%rax, %rax
180002d67:     	leaq	(%rbx,%r9,8), %r10
180002d6b:     	movq	%r10, 0x118(%rsp)
180002d73:     	movq	%r9, 0x110(%rsp)
180002d7b:     	leaq	(%rbx,%r9,8), %r10
180002d7f:     	movq	(%r10,%r11,8), %r11
180002d83:     	jns	0x180002d93 <PyInit_rcaotr_61fae00d4878711302f71448+0x1423>
180002d85:     	addq	%r11, 0x90(%rsp)
180002d8d:     	js	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002d93:     	cmpq	%r11, 0x90(%rsp)
180002d9b:     	jge	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002da1:     	cmpq	$-0x2, 0x110(%rsp)
180002daa:     	movl	$0x0, %r10d
180002db0:     	movq	0x260(%rsp), %r11
180002db8:     	cmovlq	%r11, %r10
180002dbc:     	movq	0x118(%rsp), %r11
180002dc4:     	movq	0x90(%rsp), %r9
180002dcc:     	addq	0x10(%r11,%r10,8), %r9
180002dd1:     	movq	%r9, %r10
180002dd4:     	sarq	$0x3f, %r10
180002dd8:     	andq	0x260(%rsp), %r10
180002de0:     	leaq	(%rbx,%r9,8), %r9
180002de4:     	movq	%r8, (%r9,%r10,8)
180002de8:     	mulsd	%xmm15, %xmm0
180002ded:     	movapd	%xmm0, %xmm1
180002df1:     	andpd	%xmm10, %xmm1
180002df6:     	ucomisd	%xmm11, %xmm1
180002dfb:     	jae	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e01:     	movsd	0x65ff(%rip), %xmm2     # 0x180009408
180002e09:     	ucomisd	%xmm1, %xmm2
180002e0d:     	jbe	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e13:     	cvttsd2si	%xmm0, %r8
180002e18:     	testq	%r8, %r8
180002e1b:     	movl	$0x0, %r9d
180002e21:     	cmovleq	%r9, %r8
180002e25:     	cmpq	$0xff, %r8
180002e2c:     	movl	$0xff, %r9d
180002e32:     	cmovgeq	%r9, %r8
180002e36:     	addq	$0x2, %rcx
180002e3a:     	testq	%rdx, %rcx
180002e3d:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002e43:     	cmpb	$0x0, (%r13)
180002e48:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002e4e:     	movq	(%rbx,%r12,8), %rdx
180002e52:     	movq	%rdx, %r9
180002e55:     	sarq	$0x3f, %r9
180002e59:     	andq	0x260(%rsp), %r9
180002e61:     	testq	%rax, %rax
180002e64:     	leaq	(%rbx,%rdx,8), %rax
180002e68:     	movq	(%rax,%r9,8), %r9
180002e6c:     	jns	0x180002e73 <PyInit_rcaotr_61fae00d4878711302f71448+0x1503>
180002e6e:     	addq	%r9, %rcx
180002e71:     	js	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e73:     	cmpq	%r9, %rcx
180002e76:     	jge	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e78:     	cmpq	$-0x2, %rdx
180002e7c:     	movl	$0x0, %edx
180002e81:     	movq	0x260(%rsp), %r9
180002e89:     	cmovlq	%r9, %rdx
180002e8d:     	addq	0x10(%rax,%rdx,8), %rcx
180002e92:     	movq	%rcx, %rax
180002e95:     	sarq	$0x3f, %rax
180002e99:     	andq	%r9, %rax
180002e9c:     	leaq	(%rbx,%rcx,8), %rcx
180002ea0:     	movq	%r8, (%rcx,%rax,8)
180002ea4:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002ea6:     	movb	$0x1, (%r13)
180002eab:     	movq	$0x7a1203, 0x18(%rbp)   # imm = 0x7A1203
180002eb3:     	incq	0x88(%rsp)
180002ebb:     	cmpb	$0x0, (%r13)
180002ec0:     	je	0x180002611 <PyInit_rcaotr_61fae00d4878711302f71448+0xca1>
180002ec6:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002ecb:     	movb	$0x1, (%r13)
180002ed0:     	movq	$0x7a1204, 0x18(%rbp)   # imm = 0x7A1204
180002ed8:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002eda:     	movb	$0x1, (%r13)
180002edf:     	movq	$0x7a1205, 0x18(%rbp)   # imm = 0x7A1205
180002ee7:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002ee9:     	decq	0xa0(%rsp)
180002ef1:     	movq	0x98(%rsp), %rax
180002ef9:     	cmpq	0x120(%rsp), %rax
180002f01:     	jne	0x1800025bd <PyInit_rcaotr_61fae00d4878711302f71448+0xc4d>
180002f07:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f0c:     	movq	(%rbp), %r8
180002f10:     	leaq	0x6(%r8), %r9
180002f14:     	cmpq	0x260(%rsp), %r9
180002f1c:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002f22:     	movsd	(%r14,%rax,8), %xmm2
180002f28:     	movsd	0x10(%r14,%rax,8), %xmm3
180002f2f:     	movsd	0x20(%r14,%rax,8), %xmm4
180002f36:     	movq	%r9, (%rbp)
180002f3a:     	cmpb	$0x0, (%r13)
180002f3f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f45:     	movsd	0x649b(%rip), %xmm5     # 0x1800093e8
180002f4d:     	divsd	%xmm1, %xmm5
180002f51:     	mulsd	%xmm5, %xmm2
180002f55:     	mulsd	%xmm5, %xmm3
180002f59:     	mulsd	%xmm4, %xmm5
180002f5d:     	leaq	(,%r8,8), %r9
180002f65:     	movsd	%xmm2, (%r14,%r8,8)
180002f6b:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002f72:     	movsd	%xmm5, 0x20(%r14,%r8,8)
180002f79:     	movzbl	(%r13), %eax
180002f7e:     	testb	%al, %al
180002f80:     	movq	$-0x8, %r8
180002f87:     	cmoveq	%r9, %r8
180002f8b:     	movq	%r8, 0xa8(%rsp)
180002f93:     	testb	%al, %al
180002f95:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f9b:     	jmp	0x18000252b <PyInit_rcaotr_61fae00d4878711302f71448+0xbbb>
180002fa0:     	movb	$0x1, (%r13)
180002fa5:     	movq	$0x13, 0x18(%rbp)
180002fad:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002fb2:     	movq	%rdi, %rsi
180002fb5:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180002fba:     	nopw	(%rax,%rax)
