# raytrace-final render: [0x1800019d0, 0x180002f10)
# Source/call-target-bound static range; counts include padding, never cycles.
1800019d0:     	pushq	%r15
1800019d2:     	pushq	%r14
1800019d4:     	pushq	%r13
1800019d6:     	pushq	%r12
1800019d8:     	pushq	%rsi
1800019d9:     	pushq	%rdi
1800019da:     	pushq	%rbp
1800019db:     	pushq	%rbx
1800019dc:     	subq	$0x1d8, %rsp            # imm = 0x1D8
1800019e3:     	movapd	%xmm15, 0x1c0(%rsp)
1800019ed:     	movapd	%xmm14, 0x1b0(%rsp)
1800019f7:     	movapd	%xmm13, 0x1a0(%rsp)
180001a01:     	movapd	%xmm12, 0x190(%rsp)
180001a0b:     	movapd	%xmm11, 0x180(%rsp)
180001a15:     	movapd	%xmm10, 0x170(%rsp)
180001a1f:     	movapd	%xmm9, 0x160(%rsp)
180001a29:     	movapd	%xmm8, 0x150(%rsp)
180001a33:     	movapd	%xmm7, 0x140(%rsp)
180001a3c:     	movaps	%xmm6, 0x130(%rsp)
180001a44:     	movq	%r9, %rbx
180001a47:     	movq	%r8, %r14
180001a4a:     	movq	%rdx, %rdi
180001a4d:     	movq	%rcx, %rsi
180001a50:     	movq	0x258(%rsp), %r15
180001a58:     	movq	0x248(%rsp), %r13
180001a60:     	movq	0x240(%rsp), %rbp
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
180001ae0:     	movq	$0x0, 0x128(%rsp)
180001aec:     	xorps	%xmm6, %xmm6
180001aef:     	cvtsi2sdq	(%r9,%r15,8), %xmm6
180001af5:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b0
180001afd:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b8
180001b05:     	divsd	0x78b3(%rip), %xmm6     # 0x1800093c0
180001b0d:     	movapd	%xmm6, %xmm0
180001b11:     	callq	0x180008d8c <numba_list_iter_next+0xe7c>
180001b16:     	ucomisd	%xmm0, %xmm0
180001b1a:     	jp	0x180001b70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x200>
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
180001b4e:     	je	0x180001b70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x200>
180001b50:     	movq	0x260(%rsp), %r12
180001b58:     	movq	0x10(%rbx,%r12,8), %rcx
180001b5d:     	movq	%rcx, %rax
180001b60:     	negq	%rax
180001b63:     	jno	0x180001bf2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x282>
180001b69:     	movb	$0x1, (%r13)
180001b6e:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001b70:     	movb	$0x1, (%r13)
180001b75:     	movq	$0x3, 0x18(%rbp)
180001b7d:     	xorl	%eax, %eax
180001b7f:     	movq	$0x0, (%rsi)
180001b86:     	movaps	0x130(%rsp), %xmm6
180001b8e:     	movaps	0x140(%rsp), %xmm7
180001b96:     	movaps	0x150(%rsp), %xmm8
180001b9f:     	movaps	0x160(%rsp), %xmm9
180001ba8:     	movaps	0x170(%rsp), %xmm10
180001bb1:     	movaps	0x180(%rsp), %xmm11
180001bba:     	movaps	0x190(%rsp), %xmm12
180001bc3:     	movaps	0x1a0(%rsp), %xmm13
180001bcc:     	movaps	0x1b0(%rsp), %xmm14
180001bd5:     	movaps	0x1c0(%rsp), %xmm15
180001bde:     	addq	$0x1d8, %rsp            # imm = 0x1D8
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
180001bf9:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001bfb:     	decq	%rcx
180001bfe:     	je	0x180001c1e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2ae>
180001c00:     	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
180001c0a:     	movq	0x8(%rbx,%r12,8), %rdx
180001c0f:     	cmpq	%r8, %rdx
180001c12:     	jne	0x180001c30 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c0>
180001c14:     	movb	$0x1, (%r13)
180001c19:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001c1e:     	movb	$0x1, (%r13)
180001c23:     	movq	$0x7, 0x18(%rbp)
180001c2b:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001c30:     	decq	%rdx
180001c33:     	je	0x180001d6e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3fe>
180001c39:     	movq	0x250(%rsp), %r11
180001c41:     	movq	0x10(%rbx,%r15,8), %r8
180001c46:     	movq	0x20(%rbx,%r15,8), %r9
180001c4b:     	movsd	(%r14,%r8,8), %xmm1
180001c51:     	subsd	(%r14,%r9,8), %xmm1
180001c57:     	movapd	0x7771(%rip), %xmm2     # 0x1800093d0
180001c5f:     	andpd	%xmm1, %xmm2
180001c63:     	ucomisd	0x7775(%rip), %xmm2     # 0x1800093e0
180001c6b:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001c71:     	movsd	0x10(%r14,%r8,8), %xmm2
180001c78:     	subsd	0x10(%r14,%r9,8), %xmm2
180001c7f:     	movapd	0x7749(%rip), %xmm3     # 0x1800093d0
180001c87:     	andpd	%xmm2, %xmm3
180001c8b:     	ucomisd	0x774d(%rip), %xmm3     # 0x1800093e0
180001c93:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001c99:     	movsd	0x20(%r14,%r8,8), %xmm3
180001ca0:     	subsd	0x20(%r14,%r9,8), %xmm3
180001ca7:     	movapd	0x7721(%rip), %xmm4     # 0x1800093d0
180001caf:     	andpd	%xmm3, %xmm4
180001cb3:     	ucomisd	0x7725(%rip), %xmm4     # 0x1800093e0
180001cbb:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001cbd:     	movq	(%rbp), %r10
180001cc1:     	leaq	0x6(%r10), %r8
180001cc5:     	cmpq	%r11, %r8
180001cc8:     	jg	0x180001d64 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f4>
180001cce:     	movq	%r8, (%rbp)
180001cd2:     	cmpb	$0x0, (%r13)
180001cd7:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001cdd:     	movsd	%xmm1, (%r14,%r10,8)
180001ce3:     	movsd	%xmm2, 0x10(%r14,%r10,8)
180001cea:     	movsd	%xmm3, 0x20(%r14,%r10,8)
180001cf1:     	movq	%r10, 0x80(%rsp)
180001cf9:     	movzbl	(%r13), %r10d
180001cfe:     	xorl	%r8d, %r8d
180001d01:     	movl	%r10d, %r11d
180001d04:     	negb	%r11b
180001d07:     	movq	0x250(%rsp), %r11
180001d0f:     	sbbq	%r8, %r8
180001d12:     	orq	0x80(%rsp), %r8
180001d1a:     	testb	%r10b, %r10b
180001d1d:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d23:     	jmp	0x180001d47 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d7>
180001d25:     	movb	$0x1, (%r13)
180001d2a:     	movq	$0xf4243, 0x18(%rbp)    # imm = 0xF4243
180001d32:     	movzbl	(%r13), %r10d
180001d37:     	movq	$-0x1, %r8
180001d3e:     	testb	%r10b, %r10b
180001d41:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d47:     	movq	%r8, 0x80(%rsp)
180001d4f:     	movq	(%rbp), %r8
180001d53:     	movq	%r8, 0x88(%rsp)
180001d5b:     	leaq	0x2(%r8), %r10
180001d5f:     	cmpq	%r11, %r10
180001d62:     	jle	0x180001d80 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x410>
180001d64:     	movb	$0x2, (%r13)
180001d69:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d6e:     	movb	$0x1, (%r13)
180001d73:     	movq	$0x8, 0x18(%rbp)
180001d7b:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d80:     	movq	%r10, (%rbp)
180001d84:     	cmpb	$0x0, (%r13)
180001d89:     	movq	0x80(%rsp), %r8
180001d91:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d97:     	movq	0x88(%rsp), %r10
180001d9f:     	movq	%r9, (%rbx,%r10,8)
180001da3:     	cmpb	$0x0, (%r13)
180001da8:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001dae:     	movsd	(%r14,%r8,8), %xmm1
180001db4:     	mulsd	%xmm1, %xmm1
180001db8:     	movapd	0x7610(%rip), %xmm2     # 0x1800093d0
180001dc0:     	andpd	%xmm1, %xmm2
180001dc4:     	ucomisd	0x7614(%rip), %xmm2     # 0x1800093e0
180001dcc:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001dce:     	movsd	0x10(%r14,%r8,8), %xmm2
180001dd5:     	mulsd	%xmm2, %xmm2
180001dd9:     	movapd	0x75ef(%rip), %xmm3     # 0x1800093d0
180001de1:     	andpd	%xmm2, %xmm3
180001de5:     	ucomisd	0x75f3(%rip), %xmm3     # 0x1800093e0
180001ded:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001def:     	addsd	%xmm2, %xmm1
180001df3:     	movapd	0x75d5(%rip), %xmm2     # 0x1800093d0
180001dfb:     	andpd	%xmm1, %xmm2
180001dff:     	ucomisd	0x75d9(%rip), %xmm2     # 0x1800093e0
180001e07:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001e09:     	movsd	0x20(%r14,%r8,8), %xmm2
180001e10:     	mulsd	%xmm2, %xmm2
180001e14:     	movapd	0x75b4(%rip), %xmm3     # 0x1800093d0
180001e1c:     	andpd	%xmm2, %xmm3
180001e20:     	ucomisd	0x75b8(%rip), %xmm3     # 0x1800093e0
180001e28:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001e2a:     	addsd	%xmm2, %xmm1
180001e2e:     	movapd	0x759a(%rip), %xmm2     # 0x1800093d0
180001e36:     	andpd	%xmm1, %xmm2
180001e3a:     	ucomisd	0x759e(%rip), %xmm2     # 0x1800093e0
180001e42:     	jb	0x180001e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e5>
180001e44:     	movb	$0x1, (%r13)
180001e49:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001e51:     	xorpd	%xmm1, %xmm1
180001e55:     	cmpb	$0x0, (%r13)
180001e5a:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001e60:     	sqrtsd	%xmm1, %xmm1
180001e64:     	xorpd	%xmm2, %xmm2
180001e68:     	ucomisd	%xmm2, %xmm1
180001e6c:     	jne	0x180002050 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6e0>
180001e72:     	jp	0x180002050 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6e0>
180001e78:     	movb	$0x1, (%r13)
180001e7d:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001e85:     	movzbl	(%r13), %r8d
180001e8a:     	movq	$-0x1, %r9
180001e91:     	testb	%r8b, %r8b
180001e94:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001e9a:     	movq	0x88(%rsp), %rax
180001ea2:     	movq	%r9, 0x8(%rbx,%rax,8)
180001ea7:     	cmpb	$0x0, (%r13)
180001eac:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001eb2:     	movq	0x88(%rsp), %rax
180001eba:     	movq	0x8(%rbx,%rax,8), %rax
180001ebf:     	movq	(%rbx), %r8
180001ec2:     	movsd	0x10(%r14,%rax,8), %xmm4
180001ec9:     	movsd	0x20(%r14,%r8,8), %xmm5
180001ed0:     	movapd	%xmm4, %xmm1
180001ed4:     	mulsd	%xmm5, %xmm1
180001ed8:     	movapd	0x74f0(%rip), %xmm2     # 0x1800093d0
180001ee0:     	andpd	%xmm1, %xmm2
180001ee4:     	ucomisd	0x74f4(%rip), %xmm2     # 0x1800093e0
180001eec:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001ef2:     	movsd	0x20(%r14,%rax,8), %xmm2
180001ef9:     	movsd	0x10(%r14,%r8,8), %xmm3
180001f00:     	movapd	%xmm2, %xmm6
180001f04:     	mulsd	%xmm3, %xmm6
180001f08:     	movapd	0x74c0(%rip), %xmm7     # 0x1800093d0
180001f10:     	andpd	%xmm6, %xmm7
180001f14:     	ucomisd	0x74c4(%rip), %xmm7     # 0x1800093e0
180001f1c:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f22:     	subsd	%xmm6, %xmm1
180001f26:     	movapd	0x74a2(%rip), %xmm6     # 0x1800093d0
180001f2e:     	andpd	%xmm1, %xmm6
180001f32:     	ucomisd	0x74a6(%rip), %xmm6     # 0x1800093e0
180001f3a:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f40:     	movsd	(%r14,%r8,8), %xmm6
180001f46:     	mulsd	%xmm6, %xmm2
180001f4a:     	movapd	0x747e(%rip), %xmm7     # 0x1800093d0
180001f52:     	andpd	%xmm2, %xmm7
180001f56:     	ucomisd	0x7482(%rip), %xmm7     # 0x1800093e0
180001f5e:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f64:     	movsd	(%r14,%rax,8), %xmm7
180001f6a:     	mulsd	%xmm7, %xmm5
180001f6e:     	movapd	0x7459(%rip), %xmm8     # 0x1800093d0
180001f77:     	andpd	%xmm5, %xmm8
180001f7c:     	ucomisd	0x745b(%rip), %xmm8     # 0x1800093e0
180001f85:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f8b:     	subsd	%xmm5, %xmm2
180001f8f:     	movapd	0x7439(%rip), %xmm5     # 0x1800093d0
180001f97:     	andpd	%xmm2, %xmm5
180001f9b:     	ucomisd	0x743d(%rip), %xmm5     # 0x1800093e0
180001fa3:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fa9:     	mulsd	%xmm7, %xmm3
180001fad:     	movapd	0x741b(%rip), %xmm5     # 0x1800093d0
180001fb5:     	andpd	%xmm3, %xmm5
180001fb9:     	ucomisd	0x741f(%rip), %xmm5     # 0x1800093e0
180001fc1:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fc7:     	mulsd	%xmm6, %xmm4
180001fcb:     	movapd	0x73fd(%rip), %xmm5     # 0x1800093d0
180001fd3:     	andpd	%xmm4, %xmm5
180001fd7:     	ucomisd	0x7401(%rip), %xmm5     # 0x1800093e0
180001fdf:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fe5:     	subsd	%xmm4, %xmm3
180001fe9:     	movapd	0x73df(%rip), %xmm4     # 0x1800093d0
180001ff1:     	andpd	%xmm3, %xmm4
180001ff5:     	ucomisd	0x73e3(%rip), %xmm4     # 0x1800093e0
180001ffd:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180002003:     	movq	(%rbp), %r8
180002007:     	leaq	0x6(%r8), %rax
18000200b:     	cmpq	0x250(%rsp), %rax
180002013:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002015:     	movq	%rax, (%rbp)
180002019:     	cmpb	$0x0, (%r13)
18000201e:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002024:     	movsd	%xmm1, (%r14,%r8,8)
18000202a:     	movsd	%xmm2, 0x10(%r14,%r8,8)
180002031:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002038:     	movzbl	(%r13), %r9d
18000203d:     	xorl	%eax, %eax
18000203f:     	movl	%r9d, %r10d
180002042:     	negb	%r10b
180002045:     	sbbq	%rax, %rax
180002048:     	orq	%r8, %rax
18000204b:     	jmp	0x1800020f9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x789>
180002050:     	movq	(%rbp), %rax
180002054:     	leaq	0x6(%rax), %r9
180002058:     	cmpq	%r11, %r9
18000205b:     	jle	0x180002067 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6f7>
18000205d:     	movb	$0x2, (%r13)
180002062:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002067:     	movq	0x80(%rsp), %r8
18000206f:     	movsd	(%r14,%r8,8), %xmm2
180002075:     	movsd	0x10(%r14,%r8,8), %xmm3
18000207c:     	movsd	0x20(%r14,%r8,8), %xmm4
180002083:     	movq	%r9, (%rbp)
180002087:     	cmpb	$0x0, (%r13)
18000208c:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002092:     	movsd	0x734e(%rip), %xmm5     # 0x1800093e8
18000209a:     	divsd	%xmm1, %xmm5
18000209e:     	mulsd	%xmm5, %xmm2
1800020a2:     	mulsd	%xmm5, %xmm3
1800020a6:     	mulsd	%xmm4, %xmm5
1800020aa:     	movsd	%xmm2, (%r14,%rax,8)
1800020b0:     	movsd	%xmm3, 0x10(%r14,%rax,8)
1800020b7:     	movsd	%xmm5, 0x20(%r14,%rax,8)
1800020be:     	movzbl	(%r13), %r8d
1800020c3:     	xorl	%r9d, %r9d
1800020c6:     	movl	%r8d, %r10d
1800020c9:     	negb	%r10b
1800020cc:     	sbbq	%r9, %r9
1800020cf:     	orq	%rax, %r9
1800020d2:     	testb	%r8b, %r8b
1800020d5:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800020db:     	jmp	0x180001e9a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52a>
1800020e0:     	movb	$0x1, (%r13)
1800020e5:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
1800020ed:     	movzbl	(%r13), %r9d
1800020f2:     	movq	$-0x1, %rax
1800020f9:     	testb	%r9b, %r9b
1800020fc:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002102:     	movsd	(%r14,%rax,8), %xmm1
180002108:     	mulsd	%xmm1, %xmm1
18000210c:     	movapd	0x72bc(%rip), %xmm2     # 0x1800093d0
180002114:     	andpd	%xmm1, %xmm2
180002118:     	ucomisd	0x72c0(%rip), %xmm2     # 0x1800093e0
180002120:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
180002122:     	movsd	0x10(%r14,%rax,8), %xmm2
180002129:     	mulsd	%xmm2, %xmm2
18000212d:     	movapd	0x729b(%rip), %xmm3     # 0x1800093d0
180002135:     	andpd	%xmm2, %xmm3
180002139:     	ucomisd	0x729f(%rip), %xmm3     # 0x1800093e0
180002141:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
180002143:     	addsd	%xmm2, %xmm1
180002147:     	movapd	0x7281(%rip), %xmm2     # 0x1800093d0
18000214f:     	andpd	%xmm1, %xmm2
180002153:     	ucomisd	0x7285(%rip), %xmm2     # 0x1800093e0
18000215b:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
18000215d:     	movsd	0x20(%r14,%rax,8), %xmm2
180002164:     	mulsd	%xmm2, %xmm2
180002168:     	movapd	0x7260(%rip), %xmm3     # 0x1800093d0
180002170:     	andpd	%xmm2, %xmm3
180002174:     	ucomisd	0x7264(%rip), %xmm3     # 0x1800093e0
18000217c:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
18000217e:     	addsd	%xmm2, %xmm1
180002182:     	movapd	0x7246(%rip), %xmm2     # 0x1800093d0
18000218a:     	andpd	%xmm1, %xmm2
18000218e:     	ucomisd	0x724a(%rip), %xmm2     # 0x1800093e0
180002196:     	jb	0x1800021a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x839>
180002198:     	movb	$0x1, (%r13)
18000219d:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800021a5:     	xorpd	%xmm1, %xmm1
1800021a9:     	cmpb	$0x0, (%r13)
1800021ae:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800021b4:     	sqrtsd	%xmm1, %xmm1
1800021b8:     	xorpd	%xmm2, %xmm2
1800021bc:     	ucomisd	%xmm2, %xmm1
1800021c0:     	jne	0x1800023a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xa39>
1800021c6:     	jp	0x1800023a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xa39>
1800021cc:     	movb	$0x1, (%r13)
1800021d1:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800021d9:     	movzbl	(%r13), %eax
1800021de:     	movq	$-0x1, 0x80(%rsp)
1800021ea:     	testb	%al, %al
1800021ec:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800021f2:     	movq	0x88(%rsp), %rax
1800021fa:     	movq	0x8(%rbx,%rax,8), %rax
1800021ff:     	movq	0x80(%rsp), %r8
180002207:     	movsd	0x10(%r14,%r8,8), %xmm4
18000220e:     	movsd	0x20(%r14,%rax,8), %xmm5
180002215:     	movapd	%xmm4, %xmm1
180002219:     	mulsd	%xmm5, %xmm1
18000221d:     	movapd	0x71ab(%rip), %xmm2     # 0x1800093d0
180002225:     	andpd	%xmm1, %xmm2
180002229:     	ucomisd	0x71af(%rip), %xmm2     # 0x1800093e0
180002231:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
180002237:     	movq	0x80(%rsp), %r8
18000223f:     	movsd	0x20(%r14,%r8,8), %xmm2
180002246:     	movsd	0x10(%r14,%rax,8), %xmm3
18000224d:     	movapd	%xmm2, %xmm6
180002251:     	mulsd	%xmm3, %xmm6
180002255:     	movapd	0x7173(%rip), %xmm7     # 0x1800093d0
18000225d:     	andpd	%xmm6, %xmm7
180002261:     	ucomisd	0x7177(%rip), %xmm7     # 0x1800093e0
180002269:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000226f:     	subsd	%xmm6, %xmm1
180002273:     	movapd	0x7155(%rip), %xmm6     # 0x1800093d0
18000227b:     	andpd	%xmm1, %xmm6
18000227f:     	ucomisd	0x7159(%rip), %xmm6     # 0x1800093e0
180002287:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000228d:     	movsd	(%r14,%rax,8), %xmm6
180002293:     	mulsd	%xmm6, %xmm2
180002297:     	movapd	0x7131(%rip), %xmm7     # 0x1800093d0
18000229f:     	andpd	%xmm2, %xmm7
1800022a3:     	ucomisd	0x7135(%rip), %xmm7     # 0x1800093e0
1800022ab:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022b1:     	movq	0x80(%rsp), %rax
1800022b9:     	movsd	(%r14,%rax,8), %xmm7
1800022bf:     	mulsd	%xmm7, %xmm5
1800022c3:     	movapd	0x7104(%rip), %xmm8     # 0x1800093d0
1800022cc:     	andpd	%xmm5, %xmm8
1800022d1:     	ucomisd	0x7106(%rip), %xmm8     # 0x1800093e0
1800022da:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022e0:     	subsd	%xmm5, %xmm2
1800022e4:     	movapd	0x70e4(%rip), %xmm5     # 0x1800093d0
1800022ec:     	andpd	%xmm2, %xmm5
1800022f0:     	ucomisd	0x70e8(%rip), %xmm5     # 0x1800093e0
1800022f8:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022fe:     	mulsd	%xmm7, %xmm3
180002302:     	movapd	0x70c6(%rip), %xmm5     # 0x1800093d0
18000230a:     	andpd	%xmm3, %xmm5
18000230e:     	ucomisd	0x70ca(%rip), %xmm5     # 0x1800093e0
180002316:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000231c:     	mulsd	%xmm6, %xmm4
180002320:     	movapd	0x70a8(%rip), %xmm5     # 0x1800093d0
180002328:     	andpd	%xmm4, %xmm5
18000232c:     	ucomisd	0x70ac(%rip), %xmm5     # 0x1800093e0
180002334:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000233a:     	subsd	%xmm4, %xmm3
18000233e:     	movapd	0x708a(%rip), %xmm4     # 0x1800093d0
180002346:     	andpd	%xmm3, %xmm4
18000234a:     	ucomisd	0x708e(%rip), %xmm4     # 0x1800093e0
180002352:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
180002358:     	movq	(%rbp), %r8
18000235c:     	leaq	0x6(%r8), %rax
180002360:     	cmpq	0x250(%rsp), %rax
180002368:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
18000236e:     	movq	%rax, (%rbp)
180002372:     	cmpb	$0x0, (%r13)
180002377:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000237d:     	movsd	%xmm1, (%r14,%r8,8)
180002383:     	movsd	%xmm2, 0x10(%r14,%r8,8)
18000238a:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002391:     	movzbl	(%r13), %r9d
180002396:     	xorl	%eax, %eax
180002398:     	movl	%r9d, %r10d
18000239b:     	negb	%r10b
18000239e:     	sbbq	%rax, %rax
1800023a1:     	orq	%r8, %rax
1800023a4:     	jmp	0x180002450 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xae0>
1800023a9:     	movq	(%rbp), %r8
1800023ad:     	leaq	0x6(%r8), %r9
1800023b1:     	cmpq	0x250(%rsp), %r9
1800023b9:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800023bf:     	movsd	(%r14,%rax,8), %xmm2
1800023c5:     	movsd	0x10(%r14,%rax,8), %xmm3
1800023cc:     	movsd	0x20(%r14,%rax,8), %xmm4
1800023d3:     	movq	%r9, (%rbp)
1800023d7:     	cmpb	$0x0, (%r13)
1800023dc:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800023e2:     	movsd	0x6ffe(%rip), %xmm5     # 0x1800093e8
1800023ea:     	divsd	%xmm1, %xmm5
1800023ee:     	mulsd	%xmm5, %xmm2
1800023f2:     	mulsd	%xmm5, %xmm3
1800023f6:     	mulsd	%xmm4, %xmm5
1800023fa:     	movsd	%xmm2, (%r14,%r8,8)
180002400:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002407:     	movsd	%xmm5, 0x20(%r14,%r8,8)
18000240e:     	movzbl	(%r13), %eax
180002413:     	xorl	%r10d, %r10d
180002416:     	movl	%eax, %r9d
180002419:     	negb	%r9b
18000241c:     	sbbq	%r10, %r10
18000241f:     	orq	%r8, %r10
180002422:     	movq	%r10, 0x80(%rsp)
18000242a:     	testb	%al, %al
18000242c:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002432:     	jmp	0x1800021f2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x882>
180002437:     	movb	$0x1, (%r13)
18000243c:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
180002444:     	movzbl	(%r13), %r9d
180002449:     	movq	$-0x1, %rax
180002450:     	testb	%r9b, %r9b
180002453:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002459:     	movsd	(%r14,%rax,8), %xmm1
18000245f:     	mulsd	%xmm1, %xmm1
180002463:     	movapd	0x6f65(%rip), %xmm2     # 0x1800093d0
18000246b:     	andpd	%xmm1, %xmm2
18000246f:     	ucomisd	0x6f69(%rip), %xmm2     # 0x1800093e0
180002477:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
180002479:     	movsd	0x10(%r14,%rax,8), %xmm2
180002480:     	mulsd	%xmm2, %xmm2
180002484:     	movapd	0x6f44(%rip), %xmm3     # 0x1800093d0
18000248c:     	andpd	%xmm2, %xmm3
180002490:     	ucomisd	0x6f48(%rip), %xmm3     # 0x1800093e0
180002498:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
18000249a:     	addsd	%xmm2, %xmm1
18000249e:     	movapd	0x6f2a(%rip), %xmm2     # 0x1800093d0
1800024a6:     	andpd	%xmm1, %xmm2
1800024aa:     	ucomisd	0x6f2e(%rip), %xmm2     # 0x1800093e0
1800024b2:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
1800024b4:     	movsd	0x20(%r14,%rax,8), %xmm2
1800024bb:     	mulsd	%xmm2, %xmm2
1800024bf:     	movapd	0x6f09(%rip), %xmm3     # 0x1800093d0
1800024c7:     	andpd	%xmm2, %xmm3
1800024cb:     	ucomisd	0x6f0d(%rip), %xmm3     # 0x1800093e0
1800024d3:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
1800024d5:     	addsd	%xmm2, %xmm1
1800024d9:     	movapd	0x6eef(%rip), %xmm2     # 0x1800093d0
1800024e1:     	andpd	%xmm1, %xmm2
1800024e5:     	ucomisd	0x6ef3(%rip), %xmm2     # 0x1800093e0
1800024ed:     	jb	0x180002500 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb90>
1800024ef:     	movb	$0x1, (%r13)
1800024f4:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800024fc:     	xorpd	%xmm1, %xmm1
180002500:     	cmpb	$0x0, (%r13)
180002505:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000250b:     	sqrtsd	%xmm1, %xmm1
18000250f:     	xorpd	%xmm2, %xmm2
180002513:     	ucomisd	%xmm2, %xmm1
180002517:     	jne	0x180002e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14e5>
18000251d:     	jp	0x180002e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14e5>
180002523:     	movb	$0x1, (%r13)
180002528:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180002530:     	movzbl	(%r13), %eax
180002535:     	movq	$-0x8, 0xa8(%rsp)
180002541:     	testb	%al, %al
180002543:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002549:     	movq	0x8(%rbx,%r12,8), %rax
18000254e:     	movq	%rax, 0x110(%rsp)
180002556:     	testq	%rax, %rax
180002559:     	jle	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000255f:     	movsd	0x6e61(%rip), %xmm6     # 0x1800093c8
180002567:     	movapd	%xmm0, %xmm8
18000256c:     	mulsd	%xmm0, %xmm6
180002570:     	movapd	%xmm0, %xmm7
180002574:     	addsd	%xmm0, %xmm8
180002579:     	cvtsi2sd	%rcx, %xmm0
18000257e:     	divsd	%xmm0, %xmm8
180002583:     	movapd	%xmm6, %xmm9
180002588:     	addsd	%xmm6, %xmm9
18000258d:     	xorps	%xmm0, %xmm0
180002590:     	cvtsi2sd	%rdx, %xmm0
180002595:     	divsd	%xmm0, %xmm9
18000259a:     	movq	$-0x1, 0xa0(%rsp)
1800025a6:     	movapd	0x6e21(%rip), %xmm10    # 0x1800093d0
1800025af:     	movsd	0x6e28(%rip), %xmm11    # 0x1800093e0
1800025b8:     	xorpd	%xmm12, %xmm12
1800025bd:     	movsd	0x6e2a(%rip), %xmm13    # 0x1800093f0
1800025c6:     	movsd	0x6e31(%rip), %xmm15    # 0x180009400
1800025cf:     	movq	$0x0, 0x98(%rsp)
1800025db:     	movq	0x98(%rsp), %rcx
1800025e3:     	leaq	0x1(%rcx), %rax
1800025e7:     	movq	%rax, 0x98(%rsp)
1800025ef:     	movq	0x10(%rbx,%r12,8), %rdx
1800025f4:     	testq	%rdx, %rdx
1800025f7:     	movl	$0x0, %eax
1800025fc:     	cmovleq	%rax, %rdx
180002600:     	movq	%rdx, 0x120(%rsp)
180002608:     	movq	%rcx, 0x118(%rsp)
180002610:     	xorps	%xmm14, %xmm14
180002614:     	cvtsi2sd	%rcx, %xmm14
180002619:     	mulsd	%xmm9, %xmm14
18000261e:     	subsd	%xmm6, %xmm14
180002623:     	movq	$0x0, 0x90(%rsp)
18000262f:     	movq	0x90(%rsp), %rax
180002637:     	cmpq	%rax, 0x120(%rsp)
18000263f:     	je	0x180002e32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14c2>
180002645:     	movq	(%rbp), %rdx
180002649:     	leaq	0x6(%rdx), %rax
18000264d:     	cmpq	0x250(%rsp), %rax
180002655:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
18000265b:     	movq	0x80(%rsp), %rcx
180002663:     	movsd	(%r14,%rcx,8), %xmm0
180002669:     	movsd	0x10(%r14,%rcx,8), %xmm1
180002670:     	movsd	0x20(%r14,%rcx,8), %xmm2
180002677:     	movq	%rax, (%rbp)
18000267b:     	cmpb	$0x0, (%r13)
180002680:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002686:     	xorps	%xmm3, %xmm3
180002689:     	cvtsi2sdq	0x90(%rsp), %xmm3
180002693:     	mulsd	%xmm8, %xmm3
180002698:     	subsd	%xmm7, %xmm3
18000269c:     	mulsd	%xmm3, %xmm0
1800026a0:     	mulsd	%xmm3, %xmm1
1800026a4:     	mulsd	%xmm2, %xmm3
1800026a8:     	movsd	%xmm0, (%r14,%rdx,8)
1800026ae:     	movsd	%xmm1, 0x10(%r14,%rdx,8)
1800026b5:     	movsd	%xmm3, 0x20(%r14,%rdx,8)
1800026bc:     	cmpb	$0x0, (%r13)
1800026c1:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800026c7:     	movq	(%rbp), %rax
1800026cb:     	leaq	0x6(%rax), %rcx
1800026cf:     	cmpq	0x250(%rsp), %rcx
1800026d7:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800026dd:     	movq	0xa8(%rsp), %r8
1800026e5:     	movsd	(%r14,%r8), %xmm0
1800026eb:     	movsd	0x10(%r14,%r8), %xmm1
1800026f2:     	movsd	0x20(%r14,%r8), %xmm2
1800026f9:     	movq	%rcx, (%rbp)
1800026fd:     	cmpb	$0x0, (%r13)
180002702:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002708:     	mulsd	%xmm14, %xmm0
18000270d:     	mulsd	%xmm14, %xmm1
180002712:     	mulsd	%xmm14, %xmm2
180002717:     	movsd	%xmm0, (%r14,%rax,8)
18000271d:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002724:     	movsd	%xmm2, 0x20(%r14,%rax,8)
18000272b:     	cmpb	$0x0, (%r13)
180002730:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002736:     	movq	0x88(%rsp), %r8
18000273e:     	movq	(%rbx,%r8,8), %rcx
180002742:     	movq	0x8(%rbx,%r8,8), %r8
180002747:     	movsd	(%r14,%r8,8), %xmm0
18000274d:     	addsd	(%r14,%rdx,8), %xmm0
180002753:     	movapd	%xmm0, %xmm1
180002757:     	andpd	%xmm10, %xmm1
18000275c:     	ucomisd	%xmm11, %xmm1
180002761:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
180002767:     	movsd	0x10(%r14,%r8,8), %xmm1
18000276e:     	addsd	0x10(%r14,%rdx,8), %xmm1
180002775:     	movapd	%xmm1, %xmm2
180002779:     	andpd	%xmm10, %xmm2
18000277e:     	ucomisd	%xmm11, %xmm2
180002783:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
180002785:     	movsd	0x20(%r14,%r8,8), %xmm2
18000278c:     	addsd	0x20(%r14,%rdx,8), %xmm2
180002793:     	movapd	%xmm2, %xmm3
180002797:     	andpd	%xmm10, %xmm3
18000279c:     	ucomisd	%xmm11, %xmm3
1800027a1:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
1800027a3:     	movq	(%rbp), %r8
1800027a7:     	leaq	0x6(%r8), %rdx
1800027ab:     	cmpq	0x250(%rsp), %rdx
1800027b3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800027b9:     	movq	%rdx, (%rbp)
1800027bd:     	cmpb	$0x0, (%r13)
1800027c2:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800027c8:     	movsd	%xmm0, (%r14,%r8,8)
1800027ce:     	movsd	%xmm1, 0x10(%r14,%r8,8)
1800027d5:     	movsd	%xmm2, 0x20(%r14,%r8,8)
1800027dc:     	movzbl	(%r13), %r9d
1800027e1:     	movl	%r9d, %edx
1800027e4:     	negb	%dl
1800027e6:     	movl	$0x0, %edx
1800027eb:     	sbbq	%rdx, %rdx
1800027ee:     	orq	%r8, %rdx
1800027f1:     	jmp	0x18000280c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe9c>
1800027f3:     	movb	$0x1, (%r13)
1800027f8:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
180002800:     	movzbl	(%r13), %r9d
180002805:     	movq	$-0x1, %rdx
18000280c:     	testb	%r9b, %r9b
18000280f:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002815:     	movsd	(%r14,%rdx,8), %xmm0
18000281b:     	addsd	(%r14,%rax,8), %xmm0
180002821:     	movapd	%xmm0, %xmm1
180002825:     	andpd	%xmm10, %xmm1
18000282a:     	ucomisd	%xmm11, %xmm1
18000282f:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002835:     	movsd	0x10(%r14,%rdx,8), %xmm1
18000283c:     	addsd	0x10(%r14,%rax,8), %xmm1
180002843:     	movapd	%xmm1, %xmm2
180002847:     	andpd	%xmm10, %xmm2
18000284c:     	ucomisd	%xmm11, %xmm2
180002851:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002853:     	movsd	0x20(%r14,%rdx,8), %xmm2
18000285a:     	addsd	0x20(%r14,%rax,8), %xmm2
180002861:     	movapd	%xmm2, %xmm3
180002865:     	andpd	%xmm10, %xmm3
18000286a:     	ucomisd	%xmm11, %xmm3
18000286f:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002871:     	movq	(%rbp), %rax
180002875:     	leaq	0x6(%rax), %rdx
180002879:     	cmpq	0x250(%rsp), %rdx
180002881:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002887:     	movq	%rdx, (%rbp)
18000288b:     	cmpb	$0x0, (%r13)
180002890:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002896:     	movsd	%xmm0, (%r14,%rax,8)
18000289c:     	movsd	%xmm1, 0x10(%r14,%rax,8)
1800028a3:     	movsd	%xmm2, 0x20(%r14,%rax,8)
1800028aa:     	movzbl	(%r13), %r8d
1800028af:     	movl	%r8d, %edx
1800028b2:     	negb	%dl
1800028b4:     	movl	$0x0, %edx
1800028b9:     	sbbq	%rdx, %rdx
1800028bc:     	orq	%rax, %rdx
1800028bf:     	jmp	0x1800028da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf6a>
1800028c1:     	movb	$0x1, (%r13)
1800028c6:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800028ce:     	movzbl	(%r13), %r8d
1800028d3:     	movq	$-0x1, %rdx
1800028da:     	testb	%r8b, %r8b
1800028dd:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800028e3:     	movq	(%rbp), %rax
1800028e7:     	leaq	0x2(%rax), %r8
1800028eb:     	cmpq	0x250(%rsp), %r8
1800028f3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800028f9:     	movq	%r8, (%rbp)
1800028fd:     	cmpb	$0x0, (%r13)
180002902:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002908:     	movq	%rcx, (%rbx,%rax,8)
18000290c:     	cmpb	$0x0, (%r13)
180002911:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002917:     	movsd	(%r14,%rdx,8), %xmm0
18000291d:     	mulsd	%xmm0, %xmm0
180002921:     	movapd	%xmm0, %xmm1
180002925:     	andpd	%xmm10, %xmm1
18000292a:     	ucomisd	%xmm11, %xmm1
18000292f:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
180002931:     	movsd	0x10(%r14,%rdx,8), %xmm1
180002938:     	mulsd	%xmm1, %xmm1
18000293c:     	movapd	%xmm1, %xmm2
180002940:     	andpd	%xmm10, %xmm2
180002945:     	ucomisd	%xmm11, %xmm2
18000294a:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
18000294c:     	addsd	%xmm1, %xmm0
180002950:     	movapd	%xmm0, %xmm1
180002954:     	andpd	%xmm10, %xmm1
180002959:     	ucomisd	%xmm11, %xmm1
18000295e:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
180002960:     	movsd	0x20(%r14,%rdx,8), %xmm1
180002967:     	mulsd	%xmm1, %xmm1
18000296b:     	movapd	%xmm1, %xmm2
18000296f:     	andpd	%xmm10, %xmm2
180002974:     	ucomisd	%xmm11, %xmm2
180002979:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
18000297b:     	addsd	%xmm1, %xmm0
18000297f:     	movapd	%xmm0, %xmm1
180002983:     	andpd	%xmm10, %xmm1
180002988:     	ucomisd	%xmm11, %xmm1
18000298d:     	jb	0x1800029a0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1030>
18000298f:     	movb	$0x1, (%r13)
180002994:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
18000299c:     	xorpd	%xmm0, %xmm0
1800029a0:     	cmpb	$0x0, (%r13)
1800029a5:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800029ab:     	sqrtsd	%xmm0, %xmm0
1800029af:     	ucomisd	%xmm12, %xmm0
1800029b4:     	jne	0x1800029d3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1063>
1800029b6:     	jp	0x1800029d3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1063>
1800029b8:     	movb	$0x1, (%r13)
1800029bd:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800029c5:     	movzbl	(%r13), %edx
1800029ca:     	movq	$-0x1, %r8
1800029d1:     	jmp	0x180002a4f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x10df>
1800029d3:     	movq	(%rbp), %rcx
1800029d7:     	leaq	0x6(%rcx), %r8
1800029db:     	cmpq	0x250(%rsp), %r8
1800029e3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800029e9:     	movsd	(%r14,%rdx,8), %xmm1
1800029ef:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800029f6:     	movsd	0x20(%r14,%rdx,8), %xmm3
1800029fd:     	movq	%r8, (%rbp)
180002a01:     	cmpb	$0x0, (%r13)
180002a06:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a0c:     	movsd	0x69d4(%rip), %xmm4     # 0x1800093e8
180002a14:     	divsd	%xmm0, %xmm4
180002a18:     	mulsd	%xmm4, %xmm1
180002a1c:     	mulsd	%xmm4, %xmm2
180002a20:     	mulsd	%xmm3, %xmm4
180002a24:     	movsd	%xmm1, (%r14,%rcx,8)
180002a2a:     	movsd	%xmm2, 0x10(%r14,%rcx,8)
180002a31:     	movsd	%xmm4, 0x20(%r14,%rcx,8)
180002a38:     	movzbl	(%r13), %edx
180002a3d:     	movl	%edx, %r8d
180002a40:     	negb	%r8b
180002a43:     	movl	$0x0, %r8d
180002a49:     	sbbq	%r8, %r8
180002a4c:     	orq	%rcx, %r8
180002a4f:     	testb	%dl, %dl
180002a51:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a57:     	movq	%r8, 0x8(%rbx,%rax,8)
180002a5c:     	cmpb	$0x0, (%r13)
180002a61:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a67:     	movq	0x8(%rbp), %rcx
180002a6b:     	leaq	0x1(%rcx), %rdx
180002a6f:     	movq	%rdx, 0x8(%rbp)
180002a73:     	cmpq	0x10(%rbp), %rcx
180002a77:     	jge	0x180002ee9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1579>
180002a7d:     	movq	$0x0, 0xb0(%rsp)
180002a89:     	movb	$0x0, 0xb8(%rsp)
180002a91:     	movq	$0x0, 0xc0(%rsp)
180002a9d:     	movb	$0x0, 0xc8(%rsp)
180002aa5:     	movq	$0x0, 0xd0(%rsp)
180002ab1:     	movb	$0x0, 0xd8(%rsp)
180002ab9:     	movq	$0x0, 0xe0(%rsp)
180002ac5:     	movb	$0x0, 0xe8(%rsp)
180002acd:     	movq	$0x0, 0xf0(%rsp)
180002ad9:     	movb	$0x0, 0xf8(%rsp)
180002ae1:     	movq	$0x0, 0x100(%rsp)
180002aed:     	movb	$0x0, 0x108(%rsp)
180002af5:     	movq	%rax, 0x48(%rsp)
180002afa:     	movq	%r15, 0x40(%rsp)
180002aff:     	movq	0x250(%rsp), %rax
180002b07:     	movq	%rax, 0x30(%rsp)
180002b0c:     	movq	%r13, 0x28(%rsp)
180002b11:     	movq	%rbp, 0x20(%rsp)
180002b16:     	movq	$-0x1, 0x70(%rsp)
180002b1f:     	movq	$-0x1, 0x68(%rsp)
180002b28:     	movq	$-0x1, 0x60(%rsp)
180002b31:     	movq	$-0x1, 0x58(%rsp)
180002b3a:     	movq	$-0x1, 0x50(%rsp)
180002b43:     	movq	$0x0, 0x38(%rsp)
180002b4c:     	leaq	0xb0(%rsp), %rcx
180002b54:     	leaq	0x128(%rsp), %rdx
180002b5c:     	movq	%r14, %r8
180002b5f:     	movq	%rbx, %r9
180002b62:     	callq	0x180002f10 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x15a0>
180002b67:     	testl	%eax, %eax
180002b69:     	jne	0x180002efb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x158b>
180002b6f:     	cmpb	$0x0, (%r13)
180002b74:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002b7a:     	movsd	0xb0(%rsp), %xmm2
180002b83:     	movsd	0xc0(%rsp), %xmm1
180002b8c:     	movsd	0xd0(%rsp), %xmm0
180002b95:     	decq	0x8(%rbp)
180002b99:     	movq	0x8(%rbx,%r12,8), %rax
180002b9e:     	movq	%rax, %rcx
180002ba1:     	subq	0x118(%rsp), %rcx
180002ba9:     	movq	%rcx, %rdx
180002bac:     	notq	%rdx
180002baf:     	testq	%rdx, %rax
180002bb2:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bb8:     	cmpb	$0x0, (%r13)
180002bbd:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002bc3:     	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
180002bcd:     	cmpq	%rdx, %rcx
180002bd0:     	je	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bd6:     	decq	%rcx
180002bd9:     	movq	0x10(%rbx,%r12,8), %rdx
180002bde:     	cvtsi2sd	%rcx, %xmm3
180002be3:     	cvtsi2sd	%rdx, %xmm4
180002be8:     	mulsd	%xmm3, %xmm4
180002bec:     	andpd	%xmm10, %xmm4
180002bf1:     	ucomisd	%xmm13, %xmm4
180002bf6:     	jae	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bfc:     	imulq	%rdx, %rcx
180002c00:     	addq	0xa0(%rsp), %rax
180002c08:     	imulq	%rdx, %rax
180002c0c:     	movq	0x90(%rsp), %r8
180002c14:     	addq	%r8, %rax
180002c17:     	xorq	%rax, %rcx
180002c1a:     	movq	%rax, %rdx
180002c1d:     	xorq	%r8, %rdx
180002c20:     	testq	%rdx, %rcx
180002c23:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002c29:     	xorps	%xmm3, %xmm3
180002c2c:     	cvtsi2sd	%rax, %xmm3
180002c31:     	mulsd	0x67bf(%rip), %xmm3     # 0x1800093f8
180002c39:     	andpd	%xmm10, %xmm3
180002c3e:     	ucomisd	%xmm13, %xmm3
180002c43:     	jae	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002c49:     	mulsd	%xmm15, %xmm2
180002c4e:     	movapd	%xmm2, %xmm3
180002c52:     	andpd	%xmm10, %xmm3
180002c57:     	ucomisd	%xmm11, %xmm3
180002c5c:     	jae	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002c62:     	movsd	0x679e(%rip), %xmm4     # 0x180009408
180002c6a:     	ucomisd	%xmm3, %xmm4
180002c6e:     	jbe	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002c74:     	leaq	(%rax,%rax,2), %rcx
180002c78:     	cvttsd2si	%xmm2, %rdx
180002c7d:     	testq	%rdx, %rdx
180002c80:     	movl	$0x0, %r8d
180002c86:     	cmovleq	%r8, %rdx
180002c8a:     	cmpq	$0xff, %rdx
180002c91:     	movl	$0xff, %r8d
180002c97:     	cmovgeq	%r8, %rdx
180002c9b:     	movq	(%rbx,%r12,8), %r8
180002c9f:     	movq	(%rbx,%r8,8), %r10
180002ca3:     	testq	%rax, %rax
180002ca6:     	movq	%rcx, %r9
180002ca9:     	jns	0x180002cb7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1347>
180002cab:     	movq	%r10, %r9
180002cae:     	addq	%rcx, %r9
180002cb1:     	js	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002cb7:     	cmpq	%r10, %r9
180002cba:     	jge	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002cc0:     	movq	0x10(%rbx,%r8,8), %r8
180002cc5:     	leaq	(%rbx,%r8,8), %r8
180002cc9:     	movq	%rdx, (%r8,%r9,8)
180002ccd:     	mulsd	%xmm15, %xmm1
180002cd2:     	movapd	%xmm1, %xmm2
180002cd6:     	andpd	%xmm10, %xmm2
180002cdb:     	ucomisd	%xmm11, %xmm2
180002ce0:     	jae	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002ce6:     	movsd	0x671a(%rip), %xmm3     # 0x180009408
180002cee:     	ucomisd	%xmm2, %xmm3
180002cf2:     	jbe	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002cf8:     	cvttsd2si	%xmm1, %r8
180002cfd:     	testq	%r8, %r8
180002d00:     	movl	$0x0, %edx
180002d05:     	cmovleq	%rdx, %r8
180002d09:     	cmpq	$0xff, %r8
180002d10:     	movl	$0xff, %edx
180002d15:     	cmovgeq	%rdx, %r8
180002d19:     	leaq	0x1(%rcx), %r9
180002d1d:     	movq	%rcx, %rdx
180002d20:     	notq	%rdx
180002d23:     	testq	%rdx, %r9
180002d26:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002d2c:     	cmpb	$0x0, (%r13)
180002d31:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002d37:     	movq	(%rbx,%r12,8), %r10
180002d3b:     	testq	%rax, %rax
180002d3e:     	movq	(%rbx,%r10,8), %r11
180002d42:     	jns	0x180002d4d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x13dd>
180002d44:     	addq	%r11, %r9
180002d47:     	js	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002d4d:     	cmpq	%r11, %r9
180002d50:     	jge	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002d56:     	movq	0x10(%rbx,%r10,8), %r10
180002d5b:     	leaq	(%rbx,%r10,8), %r10
180002d5f:     	movq	%r8, (%r10,%r9,8)
180002d63:     	mulsd	%xmm15, %xmm0
180002d68:     	movapd	%xmm0, %xmm1
180002d6c:     	andpd	%xmm10, %xmm1
180002d71:     	ucomisd	%xmm11, %xmm1
180002d76:     	jae	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002d7c:     	movsd	0x6684(%rip), %xmm2     # 0x180009408
180002d84:     	ucomisd	%xmm1, %xmm2
180002d88:     	jbe	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002d8e:     	cvttsd2si	%xmm0, %r8
180002d93:     	testq	%r8, %r8
180002d96:     	movl	$0x0, %r9d
180002d9c:     	cmovleq	%r9, %r8
180002da0:     	cmpq	$0xff, %r8
180002da7:     	movl	$0xff, %r9d
180002dad:     	cmovgeq	%r9, %r8
180002db1:     	addq	$0x2, %rcx
180002db5:     	testq	%rdx, %rcx
180002db8:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002dbe:     	cmpb	$0x0, (%r13)
180002dc3:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002dc9:     	movq	(%rbx,%r12,8), %rdx
180002dcd:     	testq	%rax, %rax
180002dd0:     	movq	(%rbx,%rdx,8), %rax
180002dd4:     	jns	0x180002ddb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x146b>
180002dd6:     	addq	%rax, %rcx
180002dd9:     	js	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002ddb:     	cmpq	%rax, %rcx
180002dde:     	jge	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002de0:     	movq	0x10(%rbx,%rdx,8), %rax
180002de5:     	leaq	(%rbx,%rax,8), %rax
180002de9:     	movq	%r8, (%rax,%rcx,8)
180002ded:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002def:     	movb	$0x1, (%r13)
180002df4:     	movq	$0x7a1203, 0x18(%rbp)   # imm = 0x7A1203
180002dfc:     	incq	0x90(%rsp)
180002e04:     	cmpb	$0x0, (%r13)
180002e09:     	je	0x18000262f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xcbf>
180002e0f:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e14:     	movb	$0x1, (%r13)
180002e19:     	movq	$0x7a1204, 0x18(%rbp)   # imm = 0x7A1204
180002e21:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002e23:     	movb	$0x1, (%r13)
180002e28:     	movq	$0x7a1205, 0x18(%rbp)   # imm = 0x7A1205
180002e30:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002e32:     	decq	0xa0(%rsp)
180002e3a:     	movq	0x98(%rsp), %rax
180002e42:     	cmpq	0x110(%rsp), %rax
180002e4a:     	jne	0x1800025db <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xc6b>
180002e50:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e55:     	movq	(%rbp), %r8
180002e59:     	leaq	0x6(%r8), %r9
180002e5d:     	cmpq	0x250(%rsp), %r9
180002e65:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002e6b:     	movsd	(%r14,%rax,8), %xmm2
180002e71:     	movsd	0x10(%r14,%rax,8), %xmm3
180002e78:     	movsd	0x20(%r14,%rax,8), %xmm4
180002e7f:     	movq	%r9, (%rbp)
180002e83:     	cmpb	$0x0, (%r13)
180002e88:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e8e:     	movsd	0x6552(%rip), %xmm5     # 0x1800093e8
180002e96:     	divsd	%xmm1, %xmm5
180002e9a:     	mulsd	%xmm5, %xmm2
180002e9e:     	mulsd	%xmm5, %xmm3
180002ea2:     	mulsd	%xmm4, %xmm5
180002ea6:     	leaq	(,%r8,8), %r9
180002eae:     	movsd	%xmm2, (%r14,%r8,8)
180002eb4:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002ebb:     	movsd	%xmm5, 0x20(%r14,%r8,8)
180002ec2:     	movzbl	(%r13), %eax
180002ec7:     	testb	%al, %al
180002ec9:     	movq	$-0x8, %r8
180002ed0:     	cmoveq	%r9, %r8
180002ed4:     	movq	%r8, 0xa8(%rsp)
180002edc:     	testb	%al, %al
180002ede:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002ee4:     	jmp	0x180002549 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xbd9>
180002ee9:     	movb	$0x1, (%r13)
180002eee:     	movq	$0x13, 0x18(%rbp)
180002ef6:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002efb:     	movq	%rdi, %rsi
180002efe:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180002f03:     	nopw	%cs:(%rax,%rax)
180002f0d:     	nopl	(%rax)
