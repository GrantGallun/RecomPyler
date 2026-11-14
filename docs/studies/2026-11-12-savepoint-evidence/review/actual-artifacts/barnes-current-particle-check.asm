# barnes-current particle-check: [0x180002cb6, 0x180002cf1)
# Source/call-target-bound static range; counts include padding, never cycles.
180002cb6:     	movq	0x30(%r9,%r15,8), %rax
180002cbb:     	movq	%rax, %r10
180002cbe:     	sarq	$0x3f, %r10
180002cc2:     	andq	%r14, %r10
180002cc5:     	leaq	(%r9,%rax,8), %rdx
180002cc9:     	cmpq	$0x1, (%rdx,%r10,8)
180002cce:     	jne	0x180002cf1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x781>
180002cd0:     	xorl	%r10d, %r10d
180002cd3:     	cmpq	$-0x2, %rax
180002cd7:     	cmovlq	%r14, %r10
180002cdb:     	movq	0x10(%rdx,%r10,8), %rax
180002ce0:     	leaq	(%r9,%rax,8), %rdx
180002ce4:     	sarq	$0x3f, %rax
180002ce8:     	andq	%r14, %rax
180002ceb:     	cmpq	%rdi, (%rdx,%rax,8)
180002cef:     	je	0x180002c91 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x721>
