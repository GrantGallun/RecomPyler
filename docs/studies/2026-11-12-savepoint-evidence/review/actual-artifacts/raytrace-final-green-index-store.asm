# raytrace-final green-index-store: [0x180002d37, 0x180002d63)
# Source/call-target-bound static range; counts include padding, never cycles.
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
