# raytrace-final blue-index-store: [0x180002dc9, 0x180002ded)
# Source/call-target-bound static range; counts include padding, never cycles.
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
