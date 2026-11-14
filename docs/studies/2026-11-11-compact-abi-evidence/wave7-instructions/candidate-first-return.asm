# candidate first-return: [0x180002f78, 0x180002fc9)
# Source/call-target inferred range, possibly including padding; static evidence, not cycles.
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
