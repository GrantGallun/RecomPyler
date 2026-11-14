# Existing measured PE, baseline force: [0x180004040, 0x180005180)
# Source/call-site inferred range; nearest-export labels are not helper symbols.
180004040:     	pushq	%r15
180004042:     	pushq	%r14
180004044:     	pushq	%r13
180004046:     	pushq	%r12
180004048:     	pushq	%rsi
180004049:     	pushq	%rdi
18000404a:     	pushq	%rbp
18000404b:     	pushq	%rbx
18000404c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180004053:     	movapd	%xmm8, 0x1d0(%rsp)
18000405d:     	movapd	%xmm7, 0x1c0(%rsp)
180004066:     	movapd	%xmm6, 0x1b0(%rsp)
18000406f:     	movq	0x320(%rsp), %rsi
180004077:     	movq	0x268(%rsp), %rdi
18000407f:     	movq	0x260(%rsp), %r12
180004087:     	movq	$0x0, 0x150(%rsp)
180004093:     	movb	$0x0, 0x158(%rsp)
18000409b:     	movq	$0x0, 0x160(%rsp)
1800040a7:     	movq	$0x0, 0x130(%rsp)
1800040b3:     	movb	$0x0, 0x138(%rsp)
1800040bb:     	movq	$0x0, 0x140(%rsp)
1800040c7:     	xorl	%eax, %eax
1800040c9:     	cmpq	$-0x9, %rsi
1800040cd:     	cmovlq	%rdi, %rax
1800040d1:     	leaq	(%r12,%rsi,8), %rdx
1800040d5:     	movsd	0x48(%rdx,%rax,8), %xmm0
1800040db:     	xorpd	%xmm1, %xmm1
1800040df:     	ucomisd	%xmm1, %xmm0
1800040e3:     	jne	0x1800040fc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11c>
1800040e5:     	jp	0x1800040fc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x11c>
1800040e7:     	movb	$0x1, 0x18(%rcx)
1800040eb:     	movq	$0x0, 0x10(%rcx)
1800040f3:     	movb	$0x1, 0x8(%rcx)
1800040f7:     	jmp	0x180004448 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x468>
1800040fc:     	movq	0x328(%rsp), %r14
180004104:     	movq	0x2a0(%rsp), %r13
18000410c:     	movq	0x298(%rsp), %rbp
180004114:     	xorl	%eax, %eax
180004116:     	cmpq	$-0x6, %rsi
18000411a:     	cmovlq	%r13, %rax
18000411e:     	leaq	(%rbp,%rsi,8), %r11
180004123:     	movq	0x30(%r11,%rax,8), %rax
180004128:     	movq	%rax, %r10
18000412b:     	sarq	$0x3f, %r10
18000412f:     	andq	%r13, %r10
180004132:     	leaq	(%rbp,%rax,8), %rdx
180004137:     	cmpq	$0x1, (%rdx,%r10,8)
18000413c:     	jne	0x180004160 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x180>
18000413e:     	xorl	%r10d, %r10d
180004141:     	cmpq	$-0x2, %rax
180004145:     	cmovlq	%r13, %r10
180004149:     	movq	0x10(%rdx,%r10,8), %rax
18000414e:     	leaq	(%rbp,%rax,8), %rdx
180004153:     	sarq	$0x3f, %rax
180004157:     	andq	%r13, %rax
18000415a:     	cmpq	%r14, (%rdx,%rax,8)
18000415e:     	je	0x1800040e7 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x107>
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
180004229:     	jmp	0x18000422e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x24e>
18000422b:     	movq	%r12, %r9
18000422e:     	xorl	%esi, %esi
180004230:     	cmpq	$-0x2, %rdx
180004234:     	movl	$0x0, %ebx
180004239:     	movq	0x268(%rsp), %r12
180004241:     	cmovlq	%r12, %rbx
180004245:     	movsd	0x10(%r11,%rbx,8), %xmm2
18000424c:     	cmpq	$-0x3, %rdx
180004250:     	movl	$0x0, %edx
180004255:     	movq	0x2a0(%rsp), %rbx
18000425d:     	cmovlq	%rbx, %rdx
180004261:     	cmpq	$-0x2, %r14
180004265:     	movl	$0x0, %r11d
18000426b:     	cmovlq	%r12, %r11
18000426f:     	cmpq	$-0x3, %r14
180004273:     	cmovlq	%rbx, %rsi
180004277:     	cmpq	$0x0, 0x18(%r10,%rdx,8)
18000427d:     	subsd	0x10(%r15,%r11,8), %xmm2
180004284:     	je	0x1800042f1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x311>
180004286:     	cmpq	$0x0, 0x18(%r13,%rsi,8)
18000428c:     	je	0x1800042f1 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x311>
18000428e:     	movapd	0xb12a(%rip), %xmm3     # 0x18000f3c0
180004296:     	andpd	%xmm2, %xmm3
18000429a:     	ucomisd	0xb12e(%rip), %xmm3     # 0x18000f3d0
1800042a2:     	movq	%rdi, %rbx
1800042a5:     	jae	0x1800043a9 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3c9>
1800042ab:     	movapd	%xmm1, %xmm3
1800042af:     	mulsd	%xmm1, %xmm3
1800042b3:     	ucomisd	0xb115(%rip), %xmm3     # 0x18000f3d0
1800042bb:     	setae	%dl
1800042be:     	testb	%dl, %al
1800042c0:     	jne	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042c2:     	xorpd	%xmm4, %xmm4
1800042c6:     	addsd	%xmm4, %xmm2
1800042ca:     	movapd	%xmm2, %xmm4
1800042ce:     	mulsd	%xmm2, %xmm4
1800042d2:     	ucomisd	0xb0f6(%rip), %xmm4     # 0x18000f3d0
1800042da:     	jae	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042dc:     	addsd	%xmm4, %xmm3
1800042e0:     	ucomisd	0xb0e8(%rip), %xmm3     # 0x18000f3d0
1800042e8:     	setae	%dl
1800042eb:     	testb	%dl, %al
1800042ed:     	jne	0x18000430d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x32d>
1800042ef:     	jmp	0x180004349 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x369>
1800042f1:     	movapd	%xmm1, %xmm3
1800042f5:     	mulsd	%xmm1, %xmm3
1800042f9:     	ucomisd	0xb0cf(%rip), %xmm3     # 0x18000f3d0
180004301:     	setae	%dl
180004304:     	andb	%dl, %al
180004306:     	cmpb	$0x1, %al
180004308:     	movq	%rdi, %rbx
18000430b:     	jne	0x18000433d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x35d>
18000430d:     	movq	0x308(%rsp), %rax
180004315:     	movb	$0x1, (%rax)
180004318:     	movq	$0x3d090c, 0x18(%rbx)   # imm = 0x3D090C
180004320:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004325:     	movq	0x308(%rsp), %rax
18000432d:     	movb	$0x1, (%rax)
180004330:     	movq	$0x3d090a, 0x18(%rdi)   # imm = 0x3D090A
180004338:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000433d:     	movapd	%xmm2, %xmm4
180004341:     	mulsd	%xmm2, %xmm4
180004345:     	addsd	%xmm4, %xmm3
180004349:     	xorps	%xmm4, %xmm4
18000434c:     	sqrtsd	%xmm3, %xmm4
180004350:     	xorl	%eax, %eax
180004352:     	movq	0x320(%rsp), %rsi
18000435a:     	cmpq	$-0x3, %rsi
18000435e:     	movq	0x2a0(%rsp), %r12
180004366:     	cmovlq	%r12, %rax
18000436a:     	movq	0x120(%rsp), %r11
180004372:     	cmpq	$0x0, 0x18(%r11,%rax,8)
180004378:     	movq	0x268(%rsp), %rdi
180004380:     	movq	%r9, %r15
180004383:     	je	0x1800043fd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x41d>
180004385:     	xorpd	%xmm5, %xmm5
180004389:     	ucomisd	%xmm5, %xmm3
18000438d:     	jne	0x1800043be <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3de>
18000438f:     	jp	0x1800043be <PyInit_rcaotr_2c76336ff39711e0671e54df+0x3de>
180004391:     	movq	0x308(%rsp), %rax
180004399:     	movb	$0x1, (%rax)
18000439c:     	movq	$0x3d090f, 0x18(%rbx)   # imm = 0x3D090F
1800043a4:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800043a9:     	movq	0x308(%rsp), %rax
1800043b1:     	movb	$0x1, (%rax)
1800043b4:     	movq	$0x3d090b, 0x18(%rbx)   # imm = 0x3D090B
1800043bc:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800043be:     	movsd	0x330(%rsp), %xmm6
1800043c7:     	movq	%rsi, %rax
1800043ca:     	sarq	$0x3f, %rax
1800043ce:     	andq	%r12, %rax
1800043d1:     	movq	(%r11,%rax,8), %rax
1800043d5:     	leaq	(%r15,%rax,8), %rdx
1800043d9:     	xorl	%r10d, %r10d
1800043dc:     	cmpq	$-0x1, %rax
1800043e0:     	cmovlq	%rdi, %r10
1800043e4:     	movsd	0x8(%rdx,%r10,8), %xmm3
1800043eb:     	addsd	%xmm3, %xmm3
1800043ef:     	divsd	%xmm4, %xmm3
1800043f3:     	ucomisd	%xmm3, %xmm6
1800043f7:     	jbe	0x1800044cd <PyInit_rcaotr_2c76336ff39711e0671e54df+0x4ed>
1800043fd:     	movsd	0xafd3(%rip), %xmm3     # 0x18000f3d8
180004405:     	maxsd	%xmm4, %xmm3
180004409:     	movapd	%xmm3, %xmm4
18000440d:     	mulsd	%xmm3, %xmm4
180004411:     	xorpd	%xmm5, %xmm5
180004415:     	ucomisd	%xmm5, %xmm4
180004419:     	jne	0x18000447e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49e>
18000441b:     	jp	0x18000447e <PyInit_rcaotr_2c76336ff39711e0671e54df+0x49e>
18000441d:     	movq	0x308(%rsp), %rax
180004425:     	movb	$0x1, (%rax)
180004428:     	movq	$0x3d0915, 0x18(%rbx)   # imm = 0x3D0915
180004430:     	movq	$0x0, 0x18(%rcx)
180004438:     	movq	$0x0, 0x10(%rcx)
180004440:     	movq	$0x0, 0x8(%rcx)
180004448:     	movq	$0x0, (%rcx)
18000444f:     	xorl	%eax, %eax
180004451:     	movaps	0x1b0(%rsp), %xmm6
180004459:     	movaps	0x1c0(%rsp), %xmm7
180004461:     	movaps	0x1d0(%rsp), %xmm8
18000446a:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180004471:     	popq	%rbx
180004472:     	popq	%rbp
180004473:     	popq	%rdi
180004474:     	popq	%rsi
180004475:     	popq	%r12
180004477:     	popq	%r13
180004479:     	popq	%r14
18000447b:     	popq	%r15
18000447d:     	retq
18000447e:     	movq	0x328(%rsp), %r8
180004486:     	leaq	(%r15,%r8,8), %rax
18000448a:     	xorl	%edx, %edx
18000448c:     	cmpq	$-0x1, %r8
180004490:     	cmovlq	%rdi, %rdx
180004494:     	movsd	0x8(%rax,%rdx,8), %xmm5
18000449a:     	mulsd	0xaf3e(%rip), %xmm5     # 0x18000f3e0
1800044a2:     	mulsd	%xmm5, %xmm0
1800044a6:     	divsd	%xmm4, %xmm0
1800044aa:     	mulsd	%xmm0, %xmm1
1800044ae:     	divsd	%xmm3, %xmm1
1800044b2:     	mulsd	%xmm0, %xmm2
1800044b6:     	divsd	%xmm3, %xmm2
1800044ba:     	movsd	%xmm2, 0x10(%rcx)
1800044bf:     	movsd	%xmm1, (%rcx)
1800044c3:     	movb	$0x0, 0x18(%rcx)
1800044c7:     	movb	$0x0, 0x8(%rcx)
1800044cb:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
1800044cd:     	movq	0x2c0(%rsp), %rdx
1800044d5:     	movq	0x2b8(%rsp), %rbp
1800044dd:     	movq	0x2b0(%rsp), %r14
1800044e5:     	movq	0x2a8(%rsp), %r9
1800044ed:     	movq	0x290(%rsp), %r13
1800044f5:     	xorl	%eax, %eax
1800044f7:     	cmpq	$-0x4, %rsi
1800044fb:     	cmovlq	%r12, %rax
1800044ff:     	movq	0x20(%r11,%rax,8), %rax
180004504:     	testq	%rax, %rax
180004507:     	movb	$0x1, %r10b
18000450a:     	movl	%r10d, 0x10c(%rsp)
180004512:     	js	0x1800046f2 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x712>
180004518:     	movq	0x8(%rbx), %rdx
18000451c:     	leaq	0x1(%rdx), %r10
180004520:     	movq	%r10, 0x8(%rbx)
180004524:     	cmpq	0x10(%rbx), %rdx
180004528:     	movq	0x298(%rsp), %rdx
180004530:     	jge	0x180004943 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x963>
180004536:     	movq	%r14, %r10
180004539:     	movq	%rbx, %r14
18000453c:     	movq	%rcx, %rbx
18000453f:     	movsd	%xmm6, 0x100(%rsp)
180004548:     	movq	0x328(%rsp), %rcx
180004550:     	movq	%rcx, 0xf8(%rsp)
180004558:     	movq	%rax, 0xf0(%rsp)
180004560:     	movq	0x318(%rsp), %rax
180004568:     	movq	%rax, 0xe8(%rsp)
180004570:     	movq	0x310(%rsp), %rax
180004578:     	movq	%rax, 0xe0(%rsp)
180004580:     	movq	0x308(%rsp), %rsi
180004588:     	movq	%rsi, 0xd8(%rsp)
180004590:     	movq	0x300(%rsp), %rax
180004598:     	movq	%rax, 0xd0(%rsp)
1800045a0:     	movq	0x2f8(%rsp), %rax
1800045a8:     	movq	%rax, 0xc8(%rsp)
1800045b0:     	movq	0x2f0(%rsp), %rax
1800045b8:     	movq	%rax, 0xc0(%rsp)
1800045c0:     	movq	0x2e8(%rsp), %rax
1800045c8:     	movq	%rax, 0xb8(%rsp)
1800045d0:     	movq	0x2e0(%rsp), %rax
1800045d8:     	movq	%rax, 0xb0(%rsp)
1800045e0:     	movq	0x2d8(%rsp), %rax
1800045e8:     	movq	%rax, 0xa8(%rsp)
1800045f0:     	movq	%r14, 0xa0(%rsp)
1800045f8:     	movq	0x2c8(%rsp), %rax
180004600:     	movq	%rax, 0x98(%rsp)
180004608:     	movq	0x2c0(%rsp), %rax
180004610:     	movq	%rax, 0x90(%rsp)
180004618:     	movq	%rbp, 0x88(%rsp)
180004620:     	movq	%r10, %rbp
180004623:     	movq	%r10, 0x80(%rsp)
18000462b:     	movq	%r9, 0x78(%rsp)
180004630:     	movq	%r12, 0x70(%rsp)
180004635:     	movq	%rdx, 0x68(%rsp)
18000463a:     	movq	%r13, 0x60(%rsp)
18000463f:     	movq	0x288(%rsp), %rax
180004647:     	movq	%rax, 0x58(%rsp)
18000464c:     	movq	0x280(%rsp), %rax
180004654:     	movq	%rax, 0x50(%rsp)
180004659:     	movq	0x278(%rsp), %rax
180004661:     	movq	%rax, 0x48(%rsp)
180004666:     	movq	0x270(%rsp), %rax
18000466e:     	movq	%rax, 0x40(%rsp)
180004673:     	movq	%rdi, 0x38(%rsp)
180004678:     	movq	%r15, 0x30(%rsp)
18000467d:     	movq	0x258(%rsp), %rax
180004685:     	movq	%rax, 0x28(%rsp)
18000468a:     	movq	0x250(%rsp), %rax
180004692:     	movq	%rax, 0x20(%rsp)
180004697:     	leaq	0x190(%rsp), %rcx
18000469f:     	movq	%r8, 0x118(%rsp)
1800046a7:     	movq	0x128(%rsp), %r9
1800046af:     	movq	%rdx, %r12
1800046b2:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
1800046b7:     	movzbl	0x198(%rsp), %ecx
1800046bf:     	testb	%cl, %cl
1800046c1:     	setne	%r10b
1800046c5:     	cmpb	$0x0, (%rsi)
1800046c8:     	je	0x180004973 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x993>
1800046ce:     	movq	$0x0, 0x18(%rbx)
1800046d6:     	movq	$0x0, 0x10(%rbx)
1800046de:     	movq	$0x0, 0x8(%rbx)
1800046e6:     	movq	$0x0, (%rbx)
1800046ed:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
1800046f2:     	xorpd	%xmm7, %xmm7
1800046f6:     	movb	$0x1, %r10b
1800046f9:     	xorpd	%xmm8, %xmm8
1800046fe:     	movq	0x298(%rsp), %r9
180004706:     	xorl	%eax, %eax
180004708:     	cmpq	$-0x5, %rsi
18000470c:     	cmovlq	%r12, %rax
180004710:     	movq	0x28(%r11,%rax,8), %rax
180004715:     	testq	%rax, %rax
180004718:     	js	0x180004b50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb70>
18000471e:     	movl	%r10d, %ebp
180004721:     	movq	0x8(%rbx), %rdx
180004725:     	leaq	0x1(%rdx), %r10
180004729:     	movq	%r10, 0x8(%rbx)
18000472d:     	cmpq	0x10(%rbx), %rdx
180004731:     	jge	0x18000495b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x97b>
180004737:     	movq	%rcx, 0x110(%rsp)
18000473f:     	movsd	%xmm6, 0x100(%rsp)
180004748:     	movq	0x328(%rsp), %rcx
180004750:     	movq	%rcx, 0xf8(%rsp)
180004758:     	movq	%rax, 0xf0(%rsp)
180004760:     	movq	0x318(%rsp), %rax
180004768:     	movq	%rax, 0xe8(%rsp)
180004770:     	movq	0x310(%rsp), %rax
180004778:     	movq	%rax, 0xe0(%rsp)
180004780:     	movq	0x308(%rsp), %rsi
180004788:     	movq	%rsi, 0xd8(%rsp)
180004790:     	movq	0x300(%rsp), %rax
180004798:     	movq	%rax, 0xd0(%rsp)
1800047a0:     	movq	0x2f8(%rsp), %rax
1800047a8:     	movq	%rax, 0xc8(%rsp)
1800047b0:     	movq	0x2f0(%rsp), %rax
1800047b8:     	movq	%rax, 0xc0(%rsp)
1800047c0:     	movq	0x2e8(%rsp), %rax
1800047c8:     	movq	%rax, 0xb8(%rsp)
1800047d0:     	movq	0x2e0(%rsp), %rax
1800047d8:     	movq	%rax, 0xb0(%rsp)
1800047e0:     	movq	0x2d8(%rsp), %rax
1800047e8:     	movq	%rax, 0xa8(%rsp)
1800047f0:     	movq	%rbx, 0xa0(%rsp)
1800047f8:     	movq	0x2c8(%rsp), %rax
180004800:     	movq	%rax, 0x98(%rsp)
180004808:     	movq	0x2c0(%rsp), %rax
180004810:     	movq	%rax, 0x90(%rsp)
180004818:     	movq	0x2b8(%rsp), %rax
180004820:     	movq	%rax, 0x88(%rsp)
180004828:     	movq	%r14, 0x80(%rsp)
180004830:     	movq	0x2a8(%rsp), %rax
180004838:     	movq	%rax, 0x78(%rsp)
18000483d:     	movq	%r12, 0x70(%rsp)
180004842:     	movq	%r9, 0x68(%rsp)
180004847:     	movq	%r13, 0x60(%rsp)
18000484c:     	movq	0x288(%rsp), %rax
180004854:     	movq	%rax, 0x58(%rsp)
180004859:     	movq	0x280(%rsp), %rax
180004861:     	movq	%rax, 0x50(%rsp)
180004866:     	movq	0x278(%rsp), %rax
18000486e:     	movq	%rax, 0x48(%rsp)
180004873:     	movq	0x270(%rsp), %rax
18000487b:     	movq	%rax, 0x40(%rsp)
180004880:     	movq	%rdi, 0x38(%rsp)
180004885:     	movq	%r15, 0x30(%rsp)
18000488a:     	movq	0x258(%rsp), %rax
180004892:     	movq	%rax, 0x28(%rsp)
180004897:     	movq	0x250(%rsp), %rax
18000489f:     	movq	%rax, 0x20(%rsp)
1800048a4:     	leaq	0x170(%rsp), %rcx
1800048ac:     	movq	%r8, 0x118(%rsp)
1800048b4:     	movq	%r9, %r14
1800048b7:     	movq	0x128(%rsp), %r9
1800048bf:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
1800048c4:     	cmpb	$0x0, (%rsi)
1800048c7:     	jne	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
1800048cd:     	movq	%r14, %r9
1800048d0:     	movsd	0x180(%rsp), %xmm0
1800048d9:     	movzbl	0x188(%rsp), %eax
1800048e1:     	cmpb	$0x0, 0x178(%rsp)
1800048e9:     	setne	%cl
1800048ec:     	addsd	0x170(%rsp), %xmm7
1800048f5:     	decq	0x8(%rbx)
1800048f9:     	movl	%ebp, %r10d
1800048fc:     	andb	%cl, %r10b
1800048ff:     	cmpb	$0x1, %r10b
180004903:     	movq	0x110(%rsp), %rcx
18000490b:     	jne	0x180004a47 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xa67>
180004911:     	movapd	0xaaa7(%rip), %xmm1     # 0x18000f3c0
180004919:     	andpd	%xmm7, %xmm1
18000491d:     	ucomisd	0xaaab(%rip), %xmm1     # 0x18000f3d0
180004925:     	jb	0x180004a47 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xa67>
18000492b:     	movq	0x308(%rsp), %rax
180004933:     	movb	$0x1, (%rax)
180004936:     	movq	$0x3d0927, 0x18(%rbx)   # imm = 0x3D0927
18000493e:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004943:     	movq	0x308(%rsp), %rax
18000494b:     	movb	$0x1, (%rax)
18000494e:     	movq	$0x3d0921, 0x18(%rbx)   # imm = 0x3D0921
180004956:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000495b:     	movq	0x308(%rsp), %rax
180004963:     	movb	$0x1, (%rax)
180004966:     	movq	$0x3d0926, 0x18(%rbx)   # imm = 0x3D0926
18000496e:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004973:     	movq	%r12, %r9
180004976:     	movsd	0x1a0(%rsp), %xmm0
18000497f:     	movzbl	0x1a8(%rsp), %eax
180004987:     	movsd	0x190(%rsp), %xmm7
180004990:     	movq	%r14, %rdx
180004993:     	decq	0x8(%r14)
180004997:     	testb	%cl, %cl
180004999:     	movq	%rbx, %rcx
18000499c:     	je	0x1800049cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x9ec>
18000499e:     	movapd	0xaa1a(%rip), %xmm1     # 0x18000f3c0
1800049a6:     	andpd	%xmm7, %xmm1
1800049aa:     	ucomisd	0xaa1e(%rip), %xmm1     # 0x18000f3d0
1800049b2:     	jb	0x1800049cc <PyInit_rcaotr_2c76336ff39711e0671e54df+0x9ec>
1800049b4:     	movq	0x308(%rsp), %rax
1800049bc:     	movb	$0x1, (%rax)
1800049bf:     	movq	$0x3d0922, 0x18(%rdx)   # imm = 0x3D0922
1800049c7:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
1800049cc:     	xorpd	%xmm8, %xmm8
1800049d1:     	addsd	%xmm8, %xmm7
1800049d6:     	testb	%al, %al
1800049d8:     	addsd	%xmm0, %xmm8
1800049dd:     	je	0x180004acf <PyInit_rcaotr_2c76336ff39711e0671e54df+0xaef>
1800049e3:     	andpd	0xa9d5(%rip), %xmm0     # 0x18000f3c0
1800049eb:     	ucomisd	0xa9dd(%rip), %xmm0     # 0x18000f3d0
1800049f3:     	movq	0x118(%rsp), %r8
1800049fb:     	movq	%rdx, %rbx
1800049fe:     	movq	0x2a0(%rsp), %r12
180004a06:     	movq	0x120(%rsp), %r11
180004a0e:     	movq	0x320(%rsp), %rsi
180004a16:     	movq	%rbp, %r14
180004a19:     	movq	0x2b8(%rsp), %rbp
180004a21:     	movq	0x2c0(%rsp), %rdx
180004a29:     	jb	0x180004706 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x726>
180004a2f:     	movq	0x308(%rsp), %rax
180004a37:     	movb	$0x1, (%rax)
180004a3a:     	movq	$0x3d0923, 0x18(%rbx)   # imm = 0x3D0923
180004a42:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004a47:     	addsd	%xmm0, %xmm8
180004a4c:     	testb	%al, %al
180004a4e:     	setne	%al
180004a51:     	movl	0x10c(%rsp), %edx
180004a58:     	andb	%al, %dl
180004a5a:     	cmpb	$0x1, %dl
180004a5d:     	jne	0x180004b15 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb35>
180004a63:     	movapd	0xa955(%rip), %xmm0     # 0x18000f3c0
180004a6b:     	andpd	%xmm8, %xmm0
180004a70:     	movb	$0x1, %al
180004a72:     	movl	%eax, 0x10c(%rsp)
180004a79:     	ucomisd	0xa94f(%rip), %xmm0     # 0x18000f3d0
180004a81:     	movq	0x118(%rsp), %r8
180004a89:     	movq	0x120(%rsp), %r11
180004a91:     	movq	0x320(%rsp), %rsi
180004a99:     	movq	0x2b0(%rsp), %r14
180004aa1:     	movq	0x2b8(%rsp), %rbp
180004aa9:     	movq	0x2c0(%rsp), %rdx
180004ab1:     	jb	0x180004b50 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xb70>
180004ab7:     	movq	0x308(%rsp), %rax
180004abf:     	movb	$0x1, (%rax)
180004ac2:     	movq	$0x3d0928, 0x18(%rbx)   # imm = 0x3D0928
180004aca:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004acf:     	movl	$0x0, 0x10c(%rsp)
180004ada:     	movq	0x118(%rsp), %r8
180004ae2:     	movq	%rdx, %rbx
180004ae5:     	movq	0x2a0(%rsp), %r12
180004aed:     	movq	0x120(%rsp), %r11
180004af5:     	movq	0x320(%rsp), %rsi
180004afd:     	movq	%rbp, %r14
180004b00:     	movq	0x2b8(%rsp), %rbp
180004b08:     	movq	0x2c0(%rsp), %rdx
180004b10:     	jmp	0x180004706 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x726>
180004b15:     	movl	$0x0, 0x10c(%rsp)
180004b20:     	movq	0x118(%rsp), %r8
180004b28:     	movq	0x120(%rsp), %r11
180004b30:     	movq	0x320(%rsp), %rsi
180004b38:     	movq	0x2b0(%rsp), %r14
180004b40:     	movq	0x2b8(%rsp), %rbp
180004b48:     	movq	0x2c0(%rsp), %rdx
180004b50:     	xorl	%eax, %eax
180004b52:     	cmpq	$-0x7, %rsi
180004b56:     	cmovlq	%r12, %rax
180004b5a:     	movq	0x38(%r11,%rax,8), %rax
180004b5f:     	testq	%rax, %rax
180004b62:     	js	0x180004e5b <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe7b>
180004b68:     	movl	0x10c(%rsp), %r14d
180004b70:     	movl	%r10d, %ebp
180004b73:     	movq	0x8(%rbx), %rdx
180004b77:     	leaq	0x1(%rdx), %r10
180004b7b:     	movq	%r10, 0x8(%rbx)
180004b7f:     	cmpq	0x10(%rbx), %rdx
180004b83:     	jge	0x180004d4f <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd6f>
180004b89:     	movq	%rcx, 0x110(%rsp)
180004b91:     	movsd	%xmm6, 0x100(%rsp)
180004b9a:     	movq	0x328(%rsp), %rcx
180004ba2:     	movq	%rcx, 0xf8(%rsp)
180004baa:     	movq	%rax, 0xf0(%rsp)
180004bb2:     	movq	0x318(%rsp), %rax
180004bba:     	movq	%rax, 0xe8(%rsp)
180004bc2:     	movq	0x310(%rsp), %rax
180004bca:     	movq	%rax, 0xe0(%rsp)
180004bd2:     	movq	0x308(%rsp), %rsi
180004bda:     	movq	%rsi, 0xd8(%rsp)
180004be2:     	movq	0x300(%rsp), %rax
180004bea:     	movq	%rax, 0xd0(%rsp)
180004bf2:     	movq	0x2f8(%rsp), %rax
180004bfa:     	movq	%rax, 0xc8(%rsp)
180004c02:     	movq	0x2f0(%rsp), %rax
180004c0a:     	movq	%rax, 0xc0(%rsp)
180004c12:     	movq	0x2e8(%rsp), %rax
180004c1a:     	movq	%rax, 0xb8(%rsp)
180004c22:     	movq	0x2e0(%rsp), %rax
180004c2a:     	movq	%rax, 0xb0(%rsp)
180004c32:     	movq	0x2d8(%rsp), %rax
180004c3a:     	movq	%rax, 0xa8(%rsp)
180004c42:     	movq	%rbx, 0xa0(%rsp)
180004c4a:     	movq	0x2c8(%rsp), %rax
180004c52:     	movq	%rax, 0x98(%rsp)
180004c5a:     	movq	0x2c0(%rsp), %rax
180004c62:     	movq	%rax, 0x90(%rsp)
180004c6a:     	movq	0x2b8(%rsp), %rax
180004c72:     	movq	%rax, 0x88(%rsp)
180004c7a:     	movq	0x2b0(%rsp), %rax
180004c82:     	movq	%rax, 0x80(%rsp)
180004c8a:     	movq	0x2a8(%rsp), %rax
180004c92:     	movq	%rax, 0x78(%rsp)
180004c97:     	movq	%r12, 0x70(%rsp)
180004c9c:     	movq	%r9, %r12
180004c9f:     	movq	%r9, 0x68(%rsp)
180004ca4:     	movq	%r13, 0x60(%rsp)
180004ca9:     	movq	0x288(%rsp), %rax
180004cb1:     	movq	%rax, 0x58(%rsp)
180004cb6:     	movq	0x280(%rsp), %rax
180004cbe:     	movq	%rax, 0x50(%rsp)
180004cc3:     	movq	0x278(%rsp), %rax
180004ccb:     	movq	%rax, 0x48(%rsp)
180004cd0:     	movq	0x270(%rsp), %rax
180004cd8:     	movq	%rax, 0x40(%rsp)
180004cdd:     	movq	%rdi, 0x38(%rsp)
180004ce2:     	movq	%r15, 0x30(%rsp)
180004ce7:     	movq	0x258(%rsp), %rax
180004cef:     	movq	%rax, 0x28(%rsp)
180004cf4:     	movq	0x250(%rsp), %rax
180004cfc:     	movq	%rax, 0x20(%rsp)
180004d01:     	leaq	0x150(%rsp), %rcx
180004d09:     	movq	%r8, 0x118(%rsp)
180004d11:     	movq	0x128(%rsp), %r9
180004d19:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
180004d1e:     	cmpb	$0x0, (%rsi)
180004d21:     	je	0x180004d67 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd87>
180004d23:     	movq	0x110(%rsp), %rax
180004d2b:     	movq	$0x0, 0x18(%rax)
180004d33:     	movq	$0x0, 0x10(%rax)
180004d3b:     	movq	$0x0, 0x8(%rax)
180004d43:     	movq	$0x0, (%rax)
180004d4a:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180004d4f:     	movq	0x308(%rsp), %rax
180004d57:     	movb	$0x1, (%rax)
180004d5a:     	movq	$0x3d092b, 0x18(%rbx)   # imm = 0x3D092B
180004d62:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
180004d67:     	movsd	0x160(%rsp), %xmm0
180004d70:     	movzbl	0x168(%rsp), %eax
180004d78:     	cmpb	$0x0, 0x158(%rsp)
180004d80:     	setne	%cl
180004d83:     	addsd	0x150(%rsp), %xmm7
180004d8c:     	decq	0x8(%rbx)
180004d90:     	andb	%cl, %bpl
180004d93:     	cmpb	$0x1, %bpl
180004d97:     	jne	0x180004dc0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xde0>
180004d99:     	movapd	0xa61f(%rip), %xmm1     # 0x18000f3c0
180004da1:     	andpd	%xmm7, %xmm1
180004da5:     	ucomisd	0xa623(%rip), %xmm1     # 0x18000f3d0
180004dad:     	jae	0x1800050f0 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1110>
180004db3:     	movl	%ebp, %r10d
180004db6:     	xorpd	%xmm1, %xmm1
180004dba:     	addsd	%xmm1, %xmm7
180004dbe:     	jmp	0x180004dc3 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xde3>
180004dc0:     	movl	%ebp, %r10d
180004dc3:     	addsd	%xmm0, %xmm8
180004dc8:     	testb	%al, %al
180004dca:     	setne	%al
180004dcd:     	andb	%al, %r14b
180004dd0:     	cmpb	$0x1, %r14b
180004dd4:     	jne	0x180004e05 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe25>
180004dd6:     	movapd	0xa5e2(%rip), %xmm0     # 0x18000f3c0
180004dde:     	andpd	%xmm8, %xmm0
180004de3:     	ucomisd	0xa5e5(%rip), %xmm0     # 0x18000f3d0
180004deb:     	jae	0x180005108 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1128>
180004df1:     	xorpd	%xmm0, %xmm0
180004df5:     	addsd	%xmm0, %xmm8
180004dfa:     	movb	$0x1, %al
180004dfc:     	movl	%eax, 0x10c(%rsp)
180004e03:     	jmp	0x180004e10 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xe30>
180004e05:     	movl	$0x0, 0x10c(%rsp)
180004e10:     	movq	0x110(%rsp), %rcx
180004e18:     	movq	0x118(%rsp), %r8
180004e20:     	movq	0x268(%rsp), %rdi
180004e28:     	movq	%r12, %r9
180004e2b:     	movq	0x2a0(%rsp), %r12
180004e33:     	movq	0x120(%rsp), %r11
180004e3b:     	movq	0x320(%rsp), %rsi
180004e43:     	movq	0x2b0(%rsp), %r14
180004e4b:     	movq	0x2b8(%rsp), %rbp
180004e53:     	movq	0x2c0(%rsp), %rdx
180004e5b:     	xorl	%eax, %eax
180004e5d:     	cmpq	$-0x8, %rsi
180004e61:     	cmovlq	%r12, %rax
180004e65:     	movq	0x40(%r11,%rax,8), %rax
180004e6a:     	testq	%rax, %rax
180004e6d:     	js	0x180005133 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1153>
180004e73:     	movq	%rdx, %rsi
180004e76:     	movq	%r14, %r11
180004e79:     	movl	%r10d, %r14d
180004e7c:     	movq	0x8(%rbx), %rdx
180004e80:     	leaq	0x1(%rdx), %r10
180004e84:     	movq	%r10, 0x8(%rbx)
180004e88:     	cmpq	0x10(%rbx), %rdx
180004e8c:     	jge	0x180005035 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1055>
180004e92:     	movq	%rcx, 0x110(%rsp)
180004e9a:     	movq	0x328(%rsp), %rcx
180004ea2:     	movq	%rcx, 0xf8(%rsp)
180004eaa:     	movq	%rax, 0xf0(%rsp)
180004eb2:     	movq	0x318(%rsp), %rax
180004eba:     	movq	%rax, 0xe8(%rsp)
180004ec2:     	movq	0x310(%rsp), %rax
180004eca:     	movq	%rax, 0xe0(%rsp)
180004ed2:     	movq	0x300(%rsp), %rax
180004eda:     	movq	%rax, 0xd0(%rsp)
180004ee2:     	movq	0x2f8(%rsp), %rax
180004eea:     	movq	%rax, 0xc8(%rsp)
180004ef2:     	movq	0x2f0(%rsp), %rax
180004efa:     	movq	%rax, 0xc0(%rsp)
180004f02:     	movq	0x2e8(%rsp), %rax
180004f0a:     	movq	%rax, 0xb8(%rsp)
180004f12:     	movq	0x2e0(%rsp), %rax
180004f1a:     	movq	%rax, 0xb0(%rsp)
180004f22:     	movq	0x2d8(%rsp), %rax
180004f2a:     	movq	%rax, 0xa8(%rsp)
180004f32:     	movq	0x2c8(%rsp), %rax
180004f3a:     	movq	%rax, 0x98(%rsp)
180004f42:     	movq	%rsi, 0x90(%rsp)
180004f4a:     	movq	%rbp, 0x88(%rsp)
180004f52:     	movq	%r11, 0x80(%rsp)
180004f5a:     	movq	0x2a8(%rsp), %rax
180004f62:     	movq	%rax, 0x78(%rsp)
180004f67:     	movq	%r12, 0x70(%rsp)
180004f6c:     	movq	%r9, 0x68(%rsp)
180004f71:     	movq	%r13, 0x60(%rsp)
180004f76:     	movq	0x288(%rsp), %rax
180004f7e:     	movq	%rax, 0x58(%rsp)
180004f83:     	movq	0x280(%rsp), %rax
180004f8b:     	movq	%rax, 0x50(%rsp)
180004f90:     	movq	0x278(%rsp), %rax
180004f98:     	movq	%rax, 0x48(%rsp)
180004f9d:     	movq	0x270(%rsp), %rax
180004fa5:     	movq	%rax, 0x40(%rsp)
180004faa:     	movq	%rdi, 0x38(%rsp)
180004faf:     	movq	%r15, 0x30(%rsp)
180004fb4:     	movq	0x258(%rsp), %rax
180004fbc:     	movq	%rax, 0x28(%rsp)
180004fc1:     	movsd	%xmm6, 0x100(%rsp)
180004fca:     	movq	0x308(%rsp), %rdi
180004fd2:     	movq	%rdi, 0xd8(%rsp)
180004fda:     	movq	%rbx, 0xa0(%rsp)
180004fe2:     	movq	0x250(%rsp), %rax
180004fea:     	movq	%rax, 0x20(%rsp)
180004fef:     	leaq	0x130(%rsp), %rcx
180004ff7:     	movq	0x128(%rsp), %r9
180004fff:     	callq	0x180004040 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x60>
180005004:     	cmpb	$0x0, (%rdi)
180005007:     	je	0x18000504d <PyInit_rcaotr_2c76336ff39711e0671e54df+0x106d>
180005009:     	movq	0x110(%rsp), %rsi
180005011:     	movq	$0x0, 0x18(%rsi)
180005019:     	movq	$0x0, 0x10(%rsi)
180005021:     	movq	$0x0, 0x8(%rsi)
180005029:     	movq	$0x0, (%rsi)
180005030:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180005035:     	movq	0x308(%rsp), %rax
18000503d:     	movb	$0x1, (%rax)
180005040:     	movq	$0x3d0930, 0x18(%rbx)   # imm = 0x3D0930
180005048:     	jmp	0x180004430 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x450>
18000504d:     	movl	0x10c(%rsp), %ebp
180005054:     	movsd	0x140(%rsp), %xmm0
18000505d:     	movzbl	0x148(%rsp), %eax
180005065:     	cmpb	$0x0, 0x138(%rsp)
18000506d:     	setne	%cl
180005070:     	addsd	0x130(%rsp), %xmm7
180005079:     	movq	%rbx, %rdx
18000507c:     	decq	0x8(%rbx)
180005080:     	andb	%cl, %r14b
180005083:     	movl	%r14d, %r10d
180005086:     	cmpb	$0x1, %r14b
18000508a:     	jne	0x1800050ae <PyInit_rcaotr_2c76336ff39711e0671e54df+0x10ce>
18000508c:     	movapd	0xa32c(%rip), %xmm1     # 0x18000f3c0
180005094:     	andpd	%xmm7, %xmm1
180005098:     	ucomisd	0xa330(%rip), %xmm1     # 0x18000f3d0
1800050a0:     	jae	0x180005150 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1170>
1800050a6:     	xorpd	%xmm1, %xmm1
1800050aa:     	addsd	%xmm1, %xmm7
1800050ae:     	testb	%al, %al
1800050b0:     	setne	%al
1800050b3:     	addsd	%xmm0, %xmm8
1800050b8:     	andb	%al, %bpl
1800050bb:     	cmpb	$0x1, %bpl
1800050bf:     	jne	0x180005120 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1140>
1800050c1:     	movapd	0xa2f7(%rip), %xmm0     # 0x18000f3c0
1800050c9:     	andpd	%xmm8, %xmm0
1800050ce:     	ucomisd	0xa2fa(%rip), %xmm0     # 0x18000f3d0
1800050d6:     	jae	0x180005168 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1188>
1800050dc:     	xorpd	%xmm0, %xmm0
1800050e0:     	addsd	%xmm0, %xmm8
1800050e5:     	movb	$0x1, %al
1800050e7:     	movl	%eax, 0x10c(%rsp)
1800050ee:     	jmp	0x18000512b <PyInit_rcaotr_2c76336ff39711e0671e54df+0x114b>
1800050f0:     	movq	0x308(%rsp), %rax
1800050f8:     	movb	$0x1, (%rax)
1800050fb:     	movq	$0x3d092c, 0x18(%rbx)   # imm = 0x3D092C
180005103:     	jmp	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
180005108:     	movq	0x308(%rsp), %rax
180005110:     	movb	$0x1, (%rax)
180005113:     	movq	$0x3d092d, 0x18(%rbx)   # imm = 0x3D092D
18000511b:     	jmp	0x180004d23 <PyInit_rcaotr_2c76336ff39711e0671e54df+0xd43>
180005120:     	movl	$0x0, 0x10c(%rsp)
18000512b:     	movq	0x110(%rsp), %rcx
180005133:     	movl	0x10c(%rsp), %eax
18000513a:     	movb	%al, 0x18(%rcx)
18000513d:     	movsd	%xmm8, 0x10(%rcx)
180005143:     	movb	%r10b, 0x8(%rcx)
180005147:     	movsd	%xmm7, (%rcx)
18000514b:     	jmp	0x18000444f <PyInit_rcaotr_2c76336ff39711e0671e54df+0x46f>
180005150:     	movq	0x308(%rsp), %rax
180005158:     	movb	$0x1, (%rax)
18000515b:     	movq	$0x3d0931, 0x18(%rdx)   # imm = 0x3D0931
180005163:     	jmp	0x180005009 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1029>
180005168:     	movq	0x308(%rsp), %rax
180005170:     	movb	$0x1, (%rax)
180005173:     	movq	$0x3d0932, 0x18(%rdx)   # imm = 0x3D0932
18000517b:     	jmp	0x180005009 <PyInit_rcaotr_2c76336ff39711e0671e54df+0x1029>
