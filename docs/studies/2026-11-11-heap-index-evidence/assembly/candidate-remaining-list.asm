# Existing measured PE, candidate remaining-list: [0x180003cdf, 0x180003d1a)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
180003cdf:     	movq	0x30(%r14,%r13,8), %rax
180003ce4:     	movq	%rax, %r10
180003ce7:     	sarq	$0x3f, %r10
180003ceb:     	andq	%r15, %r10
180003cee:     	leaq	(%r14,%rax,8), %rdx
180003cf2:     	cmpq	$0x1, (%rdx,%r10,8)
180003cf7:     	jne	0x180003d1a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x15a>
180003cf9:     	xorl	%r10d, %r10d
180003cfc:     	cmpq	$-0x2, %rax
180003d00:     	cmovlq	%r15, %r10
180003d04:     	movq	0x10(%rdx,%r10,8), %rax
180003d09:     	leaq	(%r14,%rax,8), %rdx
180003d0d:     	sarq	$0x3f, %rax
180003d11:     	andq	%r15, %rax
180003d14:     	cmpq	%r12, (%rdx,%rax,8)
180003d18:     	je	0x180003cb2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xf2>
