# Existing measured PE, baseline force-fields: [0x180004160, 0x180004229)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
180004160:     	movq	%r9, 0x128(%rsp)
180004168:     	xorl	%eax, %eax
18000416a:     	cmpq	$-0x2, %rsi
18000416e:     	movl	$0x0, %edx
180004173:     	cmovlq	%r13, %rdx
180004177:     	movq	%r11, 0x120(%rsp)
18000417f:     	movq	0x10(%r11,%rdx,8), %rdx
180004184:     	movq	%rdx, %r10
180004187:     	sarq	$0x3f, %r10
18000418b:     	andq	%rdi, %r10
18000418e:     	leaq	(%r12,%rdx,8), %r11
180004192:     	movsd	(%r11,%r10,8), %xmm1
180004198:     	cmpq	$-0x1, %rdx
18000419c:     	movl	$0x0, %esi
1800041a1:     	cmovlq	%r13, %rsi
1800041a5:     	leaq	(%rbp,%rdx,8), %r10
1800041aa:     	cmpq	$0x0, 0x8(%r10,%rsi,8)
1800041b0:     	setne	%sil
1800041b4:     	cmpq	$-0x2, %r14
1800041b8:     	movl	$0x0, %ebx
1800041bd:     	cmovlq	%r13, %rbx
1800041c1:     	leaq	(%rbp,%r14,8), %r15
1800041c6:     	movq	0x10(%r15,%rbx,8), %r14
1800041cb:     	movq	%r14, %rbx
1800041ce:     	sarq	$0x3f, %rbx
1800041d2:     	andq	%rdi, %rbx
1800041d5:     	cmpq	$-0x1, %r14
1800041d9:     	cmovlq	%r13, %rax
1800041dd:     	leaq	(%rbp,%r14,8), %r13
1800041e2:     	cmpq	$0x0, 0x8(%r13,%rax,8)
1800041e8:     	leaq	(%r12,%r14,8), %r15
1800041ec:     	subsd	(%r15,%rbx,8), %xmm1
1800041f2:     	setne	%al
1800041f5:     	andb	%sil, %al
1800041f8:     	movq	0x2d0(%rsp), %rdi
180004200:     	cmpb	$0x1, %al
180004202:     	jne	0x18000422b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24b>
180004204:     	movapd	0xb1b4(%rip), %xmm2     # 0x18000f3c0
18000420c:     	andpd	%xmm1, %xmm2
180004210:     	ucomisd	0xb1b8(%rip), %xmm2     # 0x18000f3d0
180004218:     	jae	0x180004325 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x345>
18000421e:     	movq	%r12, %r9
180004221:     	xorpd	%xmm2, %xmm2
180004225:     	addsd	%xmm2, %xmm1
