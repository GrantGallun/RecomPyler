# fullfloat-direct fields: [0x180003c37, 0x180003c72)
# Source/call-target inferred range; padding may be included. Static evidence, not cycles.
180003c37:     	movq	0x10(%r14,%r13,8), %rax
180003c3c:     	movq	0x10(%r14,%r12,8), %rdx
180003c41:     	movsd	(%rsi,%rax,8), %xmm1
180003c46:     	movsd	0x8(%rsi,%rax,8), %xmm2
180003c4c:     	subsd	(%rsi,%rdx,8), %xmm1
180003c51:     	subsd	0x8(%rsi,%rdx,8), %xmm2
180003c57:     	movapd	%xmm1, %xmm4
180003c5b:     	mulsd	%xmm1, %xmm4
180003c5f:     	movapd	%xmm2, %xmm3
180003c63:     	mulsd	%xmm2, %xmm3
180003c67:     	addsd	%xmm4, %xmm3
180003c6b:     	xorps	%xmm4, %xmm4
180003c6e:     	sqrtsd	%xmm3, %xmm4
