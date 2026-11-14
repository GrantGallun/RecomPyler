# candidate array-adapter: [0x180001090, 0x1800011d0)
# Source/call-target inferred range, possibly including padding; static evidence, not cycles.
180001090:     	pushq	%r14
180001092:     	pushq	%rsi
180001093:     	pushq	%rdi
180001094:     	pushq	%rbx
180001095:     	subq	$0x78, %rsp
180001099:     	movq	%rcx, %rsi
18000109c:     	movq	0x108(%rsp), %rax
1800010a4:     	movq	0xf0(%rsp), %rcx
1800010ac:     	movq	0xd8(%rsp), %r10
1800010b4:     	movq	0xc0(%rsp), %r11
1800010bc:     	movq	0x100(%rsp), %rdi
1800010c4:     	movq	0xe8(%rsp), %rbx
1800010cc:     	movq	$0x0, 0x68(%rsp)
1800010d5:     	movq	0xd0(%rsp), %r14
1800010dd:     	xorq	%r9, %r14
1800010e0:     	xorq	$0x4, %rbx
1800010e4:     	orq	%r14, %rbx
1800010e7:     	xorq	$0x1, %rdi
1800010eb:     	xorq	$0x8, %r11
1800010ef:     	orq	%rdi, %r11
1800010f2:     	orq	%rbx, %r11
1800010f5:     	xorq	$0x8, %r10
1800010f9:     	xorq	$0x8, %rcx
1800010fd:     	orq	%r10, %rcx
180001100:     	orq	%r11, %rcx
180001103:     	xorq	$0x1, %rax
180001107:     	orq	%rcx, %rax
18000110a:     	jne	0x1800011aa <.text+0x1aa>
180001110:     	movq	%rdx, %rdi
180001113:     	movq	0x130(%rsp), %rcx
18000111b:     	movq	0x128(%rsp), %rdx
180001123:     	movsd	0x120(%rsp), %xmm0
18000112c:     	movsd	0x118(%rsp), %xmm1
180001135:     	movq	0x110(%rsp), %r10
18000113d:     	movq	0xf8(%rsp), %r11
180001145:     	movq	0xe0(%rsp), %rbx
18000114d:     	movq	0xc8(%rsp), %rax
180001155:     	movq	$0x0, 0x70(%rsp)
18000115e:     	movq	%rcx, 0x58(%rsp)
180001163:     	movq	%rdx, 0x50(%rsp)
180001168:     	movsd	%xmm0, 0x48(%rsp)
18000116e:     	movsd	%xmm1, 0x40(%rsp)
180001174:     	movq	%r10, 0x38(%rsp)
180001179:     	movq	%r9, 0x30(%rsp)
18000117e:     	movq	%r11, 0x28(%rsp)
180001183:     	movq	%rbx, 0x20(%rsp)
180001188:     	leaq	0x70(%rsp), %rcx
18000118d:     	leaq	0x68(%rsp), %rdx
180001192:     	movq	%rax, %r9
180001195:     	callq	0x1800025d0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x60>
18000119a:     	testl	%eax, %eax
18000119c:     	jne	0x1800011c3 <.text+0x1c3>
18000119e:     	movq	0x70(%rsp), %rax
1800011a3:     	movq	%rax, (%rsi)
1800011a6:     	xorl	%eax, %eax
1800011a8:     	jmp	0x1800011b9 <.text+0x1b9>
1800011aa:     	leaq	0x939f(%rip), %rax      # 0x18000a550
1800011b1:     	movq	%rax, (%rdx)
1800011b4:     	movl	$0x1, %eax
1800011b9:     	addq	$0x78, %rsp
1800011bd:     	popq	%rbx
1800011be:     	popq	%rdi
1800011bf:     	popq	%rsi
1800011c0:     	popq	%r14
1800011c2:     	retq
1800011c3:     	movq	0x68(%rsp), %rcx
1800011c8:     	movq	%rcx, (%rdi)
1800011cb:     	jmp	0x1800011b9 <.text+0x1b9>
1800011cd:     	nopl	(%rax)
