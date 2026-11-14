# Existing measured PE, baseline force-mass: [0x1800040c7, 0x1800040db)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
1800040c7:     	xorl	%eax, %eax
1800040c9:     	cmpq	$-0x9, %rsi
1800040cd:     	cmovlq	%rdi, %rax
1800040d1:     	leaq	(%r12,%rsi,8), %rdx
1800040d5:     	movsd	0x48(%rdx,%rax,8), %xmm0
