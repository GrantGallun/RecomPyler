# baseline first-return: [0x1800040fe, 0x180004176)
# Source/call-target inferred range, possibly including padding; static evidence, not cycles.
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
