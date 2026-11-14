# fullfloat-direct first-return: [0x180003ed0, 0x180003f2c)
# Source/call-target inferred range; padding may be included. Static evidence, not cycles.
180003ed0:     	callq	0x180003b40 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x60>
180003ed5:     	cmpb	$0x0, (%rbx)
180003ed8:     	jne	0x1800042ce <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x7ee>
180003ede:     	xorpd	%xmm8, %xmm8
180003ee3:     	movsd	0x150(%rsp), %xmm7
180003eec:     	addsd	%xmm8, %xmm7
180003ef1:     	addsd	0x158(%rsp), %xmm8
180003efb:     	decq	0x8(%rdi)
180003eff:     	movq	0x108(%rsp), %rcx
180003f07:     	movq	%rbp, %r9
180003f0a:     	movq	0x110(%rsp), %r8
180003f12:     	movq	0x290(%rsp), %r11
180003f1a:     	movq	0x298(%rsp), %rbp
180003f22:     	movq	0x2c8(%rsp), %rdx
180003f2a:     	jmp	0x180003f35 <PyInit_rcaotr_9593466dcbd0d86cb0e5e730+0x455>
