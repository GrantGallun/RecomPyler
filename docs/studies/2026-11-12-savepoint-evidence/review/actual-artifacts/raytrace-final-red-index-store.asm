# raytrace-final red-index-store: [0x180002c9b, 0x180002ccd)
# Source/call-target-bound static range; counts include padding, never cycles.
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
