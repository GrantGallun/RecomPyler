
D:\Code\Datathon\recompyler-codex-20261111\wave5-study\results\cache\raytrace\candidate\recompyler\rcaotr_ced2c43c3452451226d0f64a.cp314-win_amd64.pyd:	file format coff-x86-64

Disassembly of section .text:

0000000180001000 <.text>:
180001000:     	movl	$0x1, %eax
180001005:     	lock
180001006:     	xaddq	%rax, (%rcx)
18000100a:     	incq	%rax
18000100d:     	retq
18000100e:     	nop
180001010:     	movq	$-0x1, %rax
180001017:     	lock
180001018:     	xaddq	%rax, (%rcx)
18000101c:     	decq	%rax
18000101f:     	retq
180001020:     	movq	%rdx, %rax
180001023:     	xorl	%edx, %edx
180001025:     	lock
180001026:     	cmpxchgq	%r8, (%rcx)
18000102a:     	sete	%dl
18000102d:     	movq	%rax, (%r9)
180001030:     	movl	%edx, %eax
180001032:     	retq
180001033:     	nopw	%cs:(%rax,%rax)
18000103d:     	nopl	(%rax)
180001040:     	movq	0x18(%rcx), %rax
180001044:     	retq
180001045:     	nopw	%cs:(%rax,%rax)
18000104f:     	nop
180001050:     	testq	%rcx, %rcx
180001053:     	je	0x180001059 <.text+0x59>
180001055:     	lock
180001056:     	incq	(%rcx)
180001059:     	retq
18000105a:     	nopw	(%rax,%rax)
180001060:     	testq	%rcx, %rcx
180001063:     	je	0x18000106b <.text+0x6b>
180001065:     	lock
180001066:     	decq	(%rcx)
180001069:     	je	0x18000106c <.text+0x6c>
18000106b:     	retq
18000106c:     	jmp	0x1800086e0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x9439(%rip), %rax      # 0x18000a4c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	pushq	%r15
180001092:     	pushq	%r14
180001094:     	pushq	%r13
180001096:     	pushq	%r12
180001098:     	pushq	%rsi
180001099:     	pushq	%rdi
18000109a:     	pushq	%rbp
18000109b:     	pushq	%rbx
18000109c:     	subq	$0x2a8, %rsp            # imm = 0x2A8
1800010a3:     	movapd	%xmm15, 0x290(%rsp)
1800010ad:     	movapd	%xmm14, 0x280(%rsp)
1800010b7:     	movapd	%xmm13, 0x270(%rsp)
1800010c1:     	movapd	%xmm12, 0x260(%rsp)
1800010cb:     	movapd	%xmm11, 0x250(%rsp)
1800010d5:     	movapd	%xmm10, 0x240(%rsp)
1800010df:     	movapd	%xmm9, 0x230(%rsp)
1800010e9:     	movapd	%xmm8, 0x220(%rsp)
1800010f3:     	movapd	%xmm7, 0x210(%rsp)
1800010fc:     	movaps	%xmm6, 0x200(%rsp)
180001104:     	movq	%r9, %rbx
180001107:     	movq	%r8, %r14
18000110a:     	movq	%rdx, %rdi
18000110d:     	movq	%rcx, %rsi
180001110:     	movq	0x3e0(%rsp), %r15
180001118:     	movq	0x3c8(%rsp), %r13
180001120:     	movq	0x390(%rsp), %rbp
180001128:     	movq	0x358(%rsp), %r12
180001130:     	movq	$0x0, 0x170(%rsp)
18000113c:     	movb	$0x0, 0x178(%rsp)
180001144:     	movq	$0x0, 0x180(%rsp)
180001150:     	movb	$0x0, 0x188(%rsp)
180001158:     	movq	$0x0, 0x190(%rsp)
180001164:     	movb	$0x0, 0x198(%rsp)
18000116c:     	movq	$0x0, 0x1a0(%rsp)
180001178:     	movb	$0x0, 0x1a8(%rsp)
180001180:     	movq	$0x0, 0x1b0(%rsp)
18000118c:     	movb	$0x0, 0x1b8(%rsp)
180001194:     	movq	$0x0, 0x1c0(%rsp)
1800011a0:     	movb	$0x0, 0x1c8(%rsp)
1800011a8:     	movq	$0x0, 0x1f8(%rsp)
1800011b4:     	xorps	%xmm6, %xmm6
1800011b7:     	cvtsi2sdq	(%r12,%r15,8), %xmm6
1800011bd:     	mulsd	0x91eb(%rip), %xmm6     # 0x18000a3b0
1800011c5:     	mulsd	0x91eb(%rip), %xmm6     # 0x18000a3b8
1800011cd:     	divsd	0x91eb(%rip), %xmm6     # 0x18000a3c0
1800011d5:     	movapd	%xmm6, %xmm0
1800011d9:     	callq	0x1800093fc <numba_list_iter_next+0xe7c>
1800011de:     	ucomisd	%xmm0, %xmm0
1800011e2:     	jp	0x180001238 <.text+0x238>
1800011e4:     	movq	%xmm0, %rax
1800011e9:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
1800011f3:     	andq	%rcx, %rax
1800011f6:     	movabsq	$0x7ff0000000000000, %rdx # imm = 0x7FF0000000000000
180001200:     	cmpq	%rdx, %rax
180001203:     	setne	%al
180001206:     	movq	%xmm6, %r8
18000120b:     	andq	%rcx, %r8
18000120e:     	cmpq	%rdx, %r8
180001211:     	sete	%cl
180001214:     	orb	%al, %cl
180001216:     	je	0x180001238 <.text+0x238>
180001218:     	movq	0x3e8(%rsp), %rdx
180001220:     	movq	0x10(%r12,%rdx,8), %rcx
180001225:     	movq	%rcx, %rax
180001228:     	negq	%rax
18000122b:     	jno	0x1800012ba <.text+0x2ba>
180001231:     	movb	$0x1, (%r13)
180001236:     	jmp	0x180001245 <.text+0x245>
180001238:     	movb	$0x1, (%r13)
18000123d:     	movq	$0x3, 0x18(%rbp)
180001245:     	xorl	%eax, %eax
180001247:     	movq	$0x0, (%rsi)
18000124e:     	movaps	0x200(%rsp), %xmm6
180001256:     	movaps	0x210(%rsp), %xmm7
18000125e:     	movaps	0x220(%rsp), %xmm8
180001267:     	movaps	0x230(%rsp), %xmm9
180001270:     	movaps	0x240(%rsp), %xmm10
180001279:     	movaps	0x250(%rsp), %xmm11
180001282:     	movaps	0x260(%rsp), %xmm12
18000128b:     	movaps	0x270(%rsp), %xmm13
180001294:     	movaps	0x280(%rsp), %xmm14
18000129d:     	movaps	0x290(%rsp), %xmm15
1800012a6:     	addq	$0x2a8, %rsp            # imm = 0x2A8
1800012ad:     	popq	%rbx
1800012ae:     	popq	%rbp
1800012af:     	popq	%rdi
1800012b0:     	popq	%rsi
1800012b1:     	popq	%r12
1800012b3:     	popq	%r13
1800012b5:     	popq	%r14
1800012b7:     	popq	%r15
1800012b9:     	retq
1800012ba:     	xorl	%eax, %eax
1800012bc:     	cmpb	$0x0, (%r13)
1800012c1:     	jne	0x180001247 <.text+0x247>
1800012c3:     	decq	%rcx
1800012c6:     	je	0x1800012e6 <.text+0x2e6>
1800012c8:     	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
1800012d2:     	movq	0x8(%r12,%rdx,8), %rdx
1800012d7:     	cmpq	%r8, %rdx
1800012da:     	jne	0x1800012f8 <.text+0x2f8>
1800012dc:     	movb	$0x1, (%r13)
1800012e1:     	jmp	0x180001247 <.text+0x247>
1800012e6:     	movb	$0x1, (%r13)
1800012eb:     	movq	$0x7, 0x18(%rbp)
1800012f3:     	jmp	0x180001247 <.text+0x247>
1800012f8:     	decq	%rdx
1800012fb:     	je	0x180001417 <.text+0x417>
180001301:     	movq	0x360(%rsp), %r11
180001309:     	movq	0x320(%rsp), %r10
180001311:     	movq	0x10(%r12,%r15,8), %r8
180001316:     	movq	0x20(%r12,%r15,8), %r9
18000131b:     	movsd	(%r10,%r8,8), %xmm1
180001321:     	subsd	(%r10,%r9,8), %xmm1
180001327:     	movapd	0x90a1(%rip), %xmm2     # 0x18000a3d0
18000132f:     	andpd	%xmm1, %xmm2
180001333:     	ucomisd	0x90a5(%rip), %xmm2     # 0x18000a3e0
18000133b:     	jae	0x1800013ce <.text+0x3ce>
180001341:     	movsd	0x10(%r10,%r8,8), %xmm2
180001348:     	subsd	0x10(%r10,%r9,8), %xmm2
18000134f:     	movapd	0x9079(%rip), %xmm3     # 0x18000a3d0
180001357:     	andpd	%xmm2, %xmm3
18000135b:     	ucomisd	0x907d(%rip), %xmm3     # 0x18000a3e0
180001363:     	jae	0x1800013ce <.text+0x3ce>
180001365:     	movsd	0x20(%r10,%r8,8), %xmm3
18000136c:     	subsd	0x20(%r10,%r9,8), %xmm3
180001373:     	movapd	0x9055(%rip), %xmm4     # 0x18000a3d0
18000137b:     	andpd	%xmm3, %xmm4
18000137f:     	ucomisd	0x9059(%rip), %xmm4     # 0x18000a3e0
180001387:     	jae	0x1800013ce <.text+0x3ce>
180001389:     	movq	(%rbp), %r8
18000138d:     	leaq	0x6(%r8), %r10
180001391:     	cmpq	%r11, %r10
180001394:     	jg	0x18000140d <.text+0x40d>
180001396:     	movq	%r10, (%rbp)
18000139a:     	cmpb	$0x0, (%r13)
18000139f:     	jne	0x180001247 <.text+0x247>
1800013a5:     	movq	0x320(%rsp), %r10
1800013ad:     	movsd	%xmm1, (%r10,%r8,8)
1800013b3:     	movsd	%xmm2, 0x10(%r10,%r8,8)
1800013ba:     	movsd	%xmm3, 0x20(%r10,%r8,8)
1800013c1:     	cmpb	$0x0, (%r13)
1800013c6:     	jne	0x180001247 <.text+0x247>
1800013cc:     	jmp	0x1800013ed <.text+0x3ed>
1800013ce:     	movb	$0x1, (%r13)
1800013d3:     	movq	$0xf4243, 0x18(%rbp)    # imm = 0xF4243
1800013db:     	cmpb	$0x0, (%r13)
1800013e0:     	jne	0x180001247 <.text+0x247>
1800013e6:     	movq	$-0x1, %r8
1800013ed:     	movq	%r8, 0x138(%rsp)
1800013f5:     	movq	%r11, %r8
1800013f8:     	movq	(%rbp), %r11
1800013fc:     	movq	%r11, 0x148(%rsp)
180001404:     	leaq	0x2(%r11), %r10
180001408:     	cmpq	%r8, %r10
18000140b:     	jle	0x180001429 <.text+0x429>
18000140d:     	movb	$0x2, (%r13)
180001412:     	jmp	0x180001247 <.text+0x247>
180001417:     	movb	$0x1, (%r13)
18000141c:     	movq	$0x8, 0x18(%rbp)
180001424:     	jmp	0x180001247 <.text+0x247>
180001429:     	movq	%r10, (%rbp)
18000142d:     	cmpb	$0x0, (%r13)
180001432:     	jne	0x180001247 <.text+0x247>
180001438:     	movq	0x148(%rsp), %r10
180001440:     	movq	%r9, (%r12,%r10,8)
180001444:     	cmpb	$0x0, (%r13)
180001449:     	jne	0x180001247 <.text+0x247>
18000144f:     	movq	%r8, %r11
180001452:     	movq	0x320(%rsp), %r9
18000145a:     	movq	0x138(%rsp), %r8
180001462:     	movsd	(%r9,%r8,8), %xmm1
180001468:     	mulsd	%xmm1, %xmm1
18000146c:     	movapd	0x8f5c(%rip), %xmm2     # 0x18000a3d0
180001474:     	andpd	%xmm1, %xmm2
180001478:     	ucomisd	0x8f60(%rip), %xmm2     # 0x18000a3e0
180001480:     	jae	0x1800014f8 <.text+0x4f8>
180001482:     	movsd	0x10(%r9,%r8,8), %xmm2
180001489:     	mulsd	%xmm2, %xmm2
18000148d:     	movapd	0x8f3b(%rip), %xmm3     # 0x18000a3d0
180001495:     	andpd	%xmm2, %xmm3
180001499:     	ucomisd	0x8f3f(%rip), %xmm3     # 0x18000a3e0
1800014a1:     	jae	0x1800014f8 <.text+0x4f8>
1800014a3:     	addsd	%xmm2, %xmm1
1800014a7:     	movapd	0x8f21(%rip), %xmm2     # 0x18000a3d0
1800014af:     	andpd	%xmm1, %xmm2
1800014b3:     	ucomisd	0x8f25(%rip), %xmm2     # 0x18000a3e0
1800014bb:     	jae	0x1800014f8 <.text+0x4f8>
1800014bd:     	movsd	0x20(%r9,%r8,8), %xmm2
1800014c4:     	mulsd	%xmm2, %xmm2
1800014c8:     	movapd	0x8f00(%rip), %xmm3     # 0x18000a3d0
1800014d0:     	andpd	%xmm2, %xmm3
1800014d4:     	ucomisd	0x8f04(%rip), %xmm3     # 0x18000a3e0
1800014dc:     	jae	0x1800014f8 <.text+0x4f8>
1800014de:     	addsd	%xmm2, %xmm1
1800014e2:     	movapd	0x8ee6(%rip), %xmm2     # 0x18000a3d0
1800014ea:     	andpd	%xmm1, %xmm2
1800014ee:     	ucomisd	0x8eea(%rip), %xmm2     # 0x18000a3e0
1800014f6:     	jb	0x180001514 <.text+0x514>
1800014f8:     	movb	$0x1, (%r13)
1800014fd:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001505:     	cmpb	$0x0, (%r13)
18000150a:     	jne	0x180001247 <.text+0x247>
180001510:     	xorpd	%xmm1, %xmm1
180001514:     	sqrtsd	%xmm1, %xmm1
180001518:     	xorpd	%xmm2, %xmm2
18000151c:     	ucomisd	%xmm2, %xmm1
180001520:     	jne	0x180001705 <.text+0x705>
180001526:     	jp	0x180001705 <.text+0x705>
18000152c:     	movb	$0x1, (%r13)
180001531:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001539:     	cmpb	$0x0, (%r13)
18000153e:     	jne	0x180001247 <.text+0x247>
180001544:     	movq	$-0x1, %rax
18000154b:     	movq	0x148(%rsp), %r8
180001553:     	movq	%rax, 0x8(%r12,%r8,8)
180001558:     	cmpb	$0x0, (%r13)
18000155d:     	jne	0x180001245 <.text+0x245>
180001563:     	movq	(%r12), %r8
180001567:     	movq	0x320(%rsp), %r9
18000156f:     	movsd	0x10(%r9,%rax,8), %xmm4
180001576:     	movsd	0x20(%r9,%r8,8), %xmm5
18000157d:     	movapd	%xmm4, %xmm1
180001581:     	mulsd	%xmm5, %xmm1
180001585:     	movapd	0x8e43(%rip), %xmm2     # 0x18000a3d0
18000158d:     	andpd	%xmm1, %xmm2
180001591:     	ucomisd	0x8e47(%rip), %xmm2     # 0x18000a3e0
180001599:     	jae	0x180001793 <.text+0x793>
18000159f:     	movsd	0x20(%r9,%rax,8), %xmm2
1800015a6:     	movsd	0x10(%r9,%r8,8), %xmm3
1800015ad:     	movapd	%xmm2, %xmm6
1800015b1:     	mulsd	%xmm3, %xmm6
1800015b5:     	movapd	0x8e13(%rip), %xmm7     # 0x18000a3d0
1800015bd:     	andpd	%xmm6, %xmm7
1800015c1:     	ucomisd	0x8e17(%rip), %xmm7     # 0x18000a3e0
1800015c9:     	jae	0x180001793 <.text+0x793>
1800015cf:     	subsd	%xmm6, %xmm1
1800015d3:     	movapd	0x8df5(%rip), %xmm6     # 0x18000a3d0
1800015db:     	andpd	%xmm1, %xmm6
1800015df:     	ucomisd	0x8df9(%rip), %xmm6     # 0x18000a3e0
1800015e7:     	jae	0x180001793 <.text+0x793>
1800015ed:     	movsd	(%r9,%r8,8), %xmm6
1800015f3:     	mulsd	%xmm6, %xmm2
1800015f7:     	movapd	0x8dd1(%rip), %xmm7     # 0x18000a3d0
1800015ff:     	andpd	%xmm2, %xmm7
180001603:     	ucomisd	0x8dd5(%rip), %xmm7     # 0x18000a3e0
18000160b:     	jae	0x180001793 <.text+0x793>
180001611:     	movq	0x320(%rsp), %r8
180001619:     	movsd	(%r8,%rax,8), %xmm7
18000161f:     	mulsd	%xmm7, %xmm5
180001623:     	movapd	0x8da4(%rip), %xmm8     # 0x18000a3d0
18000162c:     	andpd	%xmm5, %xmm8
180001631:     	ucomisd	0x8da6(%rip), %xmm8     # 0x18000a3e0
18000163a:     	jae	0x180001793 <.text+0x793>
180001640:     	subsd	%xmm5, %xmm2
180001644:     	movapd	0x8d84(%rip), %xmm5     # 0x18000a3d0
18000164c:     	andpd	%xmm2, %xmm5
180001650:     	ucomisd	0x8d88(%rip), %xmm5     # 0x18000a3e0
180001658:     	jae	0x180001793 <.text+0x793>
18000165e:     	mulsd	%xmm7, %xmm3
180001662:     	movapd	0x8d66(%rip), %xmm5     # 0x18000a3d0
18000166a:     	andpd	%xmm3, %xmm5
18000166e:     	ucomisd	0x8d6a(%rip), %xmm5     # 0x18000a3e0
180001676:     	jae	0x180001793 <.text+0x793>
18000167c:     	mulsd	%xmm6, %xmm4
180001680:     	movapd	0x8d48(%rip), %xmm5     # 0x18000a3d0
180001688:     	andpd	%xmm4, %xmm5
18000168c:     	ucomisd	0x8d4c(%rip), %xmm5     # 0x18000a3e0
180001694:     	jae	0x180001793 <.text+0x793>
18000169a:     	subsd	%xmm4, %xmm3
18000169e:     	movapd	0x8d2a(%rip), %xmm4     # 0x18000a3d0
1800016a6:     	andpd	%xmm3, %xmm4
1800016aa:     	ucomisd	0x8d2e(%rip), %xmm4     # 0x18000a3e0
1800016b2:     	jae	0x180001793 <.text+0x793>
1800016b8:     	movq	(%rbp), %rax
1800016bc:     	leaq	0x6(%rax), %r8
1800016c0:     	cmpq	0x360(%rsp), %r8
1800016c8:     	jg	0x180001712 <.text+0x712>
1800016ca:     	movq	%r8, (%rbp)
1800016ce:     	cmpb	$0x0, (%r13)
1800016d3:     	jne	0x180001245 <.text+0x245>
1800016d9:     	movq	0x320(%rsp), %r8
1800016e1:     	movsd	%xmm1, (%r8,%rax,8)
1800016e7:     	movsd	%xmm2, 0x10(%r8,%rax,8)
1800016ee:     	movsd	%xmm3, 0x20(%r8,%rax,8)
1800016f5:     	cmpb	$0x0, (%r13)
1800016fa:     	jne	0x180001245 <.text+0x245>
180001700:     	jmp	0x1800017bf <.text+0x7bf>
180001705:     	movq	(%rbp), %rax
180001709:     	leaq	0x6(%rax), %r9
18000170d:     	cmpq	%r11, %r9
180001710:     	jle	0x18000171c <.text+0x71c>
180001712:     	movb	$0x2, (%r13)
180001717:     	jmp	0x180001245 <.text+0x245>
18000171c:     	movq	0x320(%rsp), %r10
180001724:     	movq	0x138(%rsp), %r8
18000172c:     	movsd	(%r10,%r8,8), %xmm2
180001732:     	movsd	0x10(%r10,%r8,8), %xmm3
180001739:     	movsd	0x20(%r10,%r8,8), %xmm4
180001740:     	movq	%r9, (%rbp)
180001744:     	cmpb	$0x0, (%r13)
180001749:     	jne	0x180001245 <.text+0x245>
18000174f:     	movsd	0x8c91(%rip), %xmm5     # 0x18000a3e8
180001757:     	divsd	%xmm1, %xmm5
18000175b:     	mulsd	%xmm5, %xmm2
18000175f:     	mulsd	%xmm5, %xmm3
180001763:     	mulsd	%xmm4, %xmm5
180001767:     	movq	0x320(%rsp), %r8
18000176f:     	movsd	%xmm2, (%r8,%rax,8)
180001775:     	movsd	%xmm3, 0x10(%r8,%rax,8)
18000177c:     	movsd	%xmm5, 0x20(%r8,%rax,8)
180001783:     	cmpb	$0x0, (%r13)
180001788:     	jne	0x180001245 <.text+0x245>
18000178e:     	jmp	0x18000154b <.text+0x54b>
180001793:     	movb	$0x1, (%r13)
180001798:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
1800017a0:     	cmpb	$0x0, (%r13)
1800017a5:     	jne	0x180001245 <.text+0x245>
1800017ab:     	movq	0x320(%rsp), %rax
1800017b3:     	movsd	-0x8(%rax), %xmm1
1800017b8:     	movq	$-0x1, %rax
1800017bf:     	mulsd	%xmm1, %xmm1
1800017c3:     	movapd	0x8c05(%rip), %xmm2     # 0x18000a3d0
1800017cb:     	andpd	%xmm1, %xmm2
1800017cf:     	ucomisd	0x8c09(%rip), %xmm2     # 0x18000a3e0
1800017d7:     	jae	0x180001857 <.text+0x857>
1800017d9:     	movq	0x320(%rsp), %r8
1800017e1:     	movsd	0x10(%r8,%rax,8), %xmm2
1800017e8:     	mulsd	%xmm2, %xmm2
1800017ec:     	movapd	0x8bdc(%rip), %xmm3     # 0x18000a3d0
1800017f4:     	andpd	%xmm2, %xmm3
1800017f8:     	ucomisd	0x8be0(%rip), %xmm3     # 0x18000a3e0
180001800:     	jae	0x180001857 <.text+0x857>
180001802:     	addsd	%xmm2, %xmm1
180001806:     	movapd	0x8bc2(%rip), %xmm2     # 0x18000a3d0
18000180e:     	andpd	%xmm1, %xmm2
180001812:     	ucomisd	0x8bc6(%rip), %xmm2     # 0x18000a3e0
18000181a:     	jae	0x180001857 <.text+0x857>
18000181c:     	movsd	0x20(%r8,%rax,8), %xmm2
180001823:     	mulsd	%xmm2, %xmm2
180001827:     	movapd	0x8ba1(%rip), %xmm3     # 0x18000a3d0
18000182f:     	andpd	%xmm2, %xmm3
180001833:     	ucomisd	0x8ba5(%rip), %xmm3     # 0x18000a3e0
18000183b:     	jae	0x180001857 <.text+0x857>
18000183d:     	addsd	%xmm2, %xmm1
180001841:     	movapd	0x8b87(%rip), %xmm2     # 0x18000a3d0
180001849:     	andpd	%xmm1, %xmm2
18000184d:     	ucomisd	0x8b8b(%rip), %xmm2     # 0x18000a3e0
180001855:     	jb	0x180001873 <.text+0x873>
180001857:     	movb	$0x1, (%r13)
18000185c:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001864:     	cmpb	$0x0, (%r13)
180001869:     	jne	0x180001245 <.text+0x245>
18000186f:     	xorpd	%xmm1, %xmm1
180001873:     	sqrtsd	%xmm1, %xmm1
180001877:     	xorpd	%xmm2, %xmm2
18000187b:     	ucomisd	%xmm2, %xmm1
18000187f:     	jne	0x180001a74 <.text+0xa74>
180001885:     	jp	0x180001a74 <.text+0xa74>
18000188b:     	movb	$0x1, (%r13)
180001890:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001898:     	cmpb	$0x0, (%r13)
18000189d:     	jne	0x180001245 <.text+0x245>
1800018a3:     	movq	0x320(%rsp), %rax
1800018ab:     	movsd	0x8(%rax), %xmm2
1800018b0:     	movq	$-0x1, 0x138(%rsp)
1800018bc:     	movq	0x148(%rsp), %rax
1800018c4:     	movq	0x8(%r12,%rax,8), %rax
1800018c9:     	movq	0x320(%rsp), %r8
1800018d1:     	movsd	0x20(%r8,%rax,8), %xmm5
1800018d8:     	movapd	%xmm2, %xmm1
1800018dc:     	mulsd	%xmm5, %xmm1
1800018e0:     	movapd	0x8ae8(%rip), %xmm3     # 0x18000a3d0
1800018e8:     	andpd	%xmm1, %xmm3
1800018ec:     	ucomisd	0x8aec(%rip), %xmm3     # 0x18000a3e0
1800018f4:     	jae	0x180001b09 <.text+0xb09>
1800018fa:     	movq	0x138(%rsp), %r9
180001902:     	movsd	0x20(%r8,%r9,8), %xmm3
180001909:     	movsd	0x10(%r8,%rax,8), %xmm4
180001910:     	movapd	%xmm3, %xmm6
180001914:     	mulsd	%xmm4, %xmm6
180001918:     	movapd	0x8ab0(%rip), %xmm7     # 0x18000a3d0
180001920:     	andpd	%xmm6, %xmm7
180001924:     	ucomisd	0x8ab4(%rip), %xmm7     # 0x18000a3e0
18000192c:     	jae	0x180001b09 <.text+0xb09>
180001932:     	subsd	%xmm6, %xmm1
180001936:     	movapd	0x8a92(%rip), %xmm6     # 0x18000a3d0
18000193e:     	andpd	%xmm1, %xmm6
180001942:     	ucomisd	0x8a96(%rip), %xmm6     # 0x18000a3e0
18000194a:     	jae	0x180001b09 <.text+0xb09>
180001950:     	movsd	(%r8,%rax,8), %xmm6
180001956:     	mulsd	%xmm6, %xmm3
18000195a:     	movapd	0x8a6e(%rip), %xmm7     # 0x18000a3d0
180001962:     	andpd	%xmm3, %xmm7
180001966:     	ucomisd	0x8a72(%rip), %xmm7     # 0x18000a3e0
18000196e:     	jae	0x180001b09 <.text+0xb09>
180001974:     	movq	0x320(%rsp), %rax
18000197c:     	movq	0x138(%rsp), %r8
180001984:     	movsd	(%rax,%r8,8), %xmm7
18000198a:     	mulsd	%xmm7, %xmm5
18000198e:     	movapd	0x8a39(%rip), %xmm8     # 0x18000a3d0
180001997:     	andpd	%xmm5, %xmm8
18000199c:     	ucomisd	0x8a3b(%rip), %xmm8     # 0x18000a3e0
1800019a5:     	jae	0x180001b09 <.text+0xb09>
1800019ab:     	subsd	%xmm5, %xmm3
1800019af:     	movapd	0x8a19(%rip), %xmm5     # 0x18000a3d0
1800019b7:     	andpd	%xmm3, %xmm5
1800019bb:     	ucomisd	0x8a1d(%rip), %xmm5     # 0x18000a3e0
1800019c3:     	jae	0x180001b09 <.text+0xb09>
1800019c9:     	mulsd	%xmm7, %xmm4
1800019cd:     	movapd	0x89fb(%rip), %xmm5     # 0x18000a3d0
1800019d5:     	andpd	%xmm4, %xmm5
1800019d9:     	ucomisd	0x89ff(%rip), %xmm5     # 0x18000a3e0
1800019e1:     	jae	0x180001b09 <.text+0xb09>
1800019e7:     	mulsd	%xmm6, %xmm2
1800019eb:     	movapd	0x89dd(%rip), %xmm5     # 0x18000a3d0
1800019f3:     	andpd	%xmm2, %xmm5
1800019f7:     	ucomisd	0x89e1(%rip), %xmm5     # 0x18000a3e0
1800019ff:     	jae	0x180001b09 <.text+0xb09>
180001a05:     	subsd	%xmm2, %xmm4
180001a09:     	movapd	0x89bf(%rip), %xmm2     # 0x18000a3d0
180001a11:     	andpd	%xmm4, %xmm2
180001a15:     	ucomisd	0x89c3(%rip), %xmm2     # 0x18000a3e0
180001a1d:     	jae	0x180001b09 <.text+0xb09>
180001a23:     	movq	(%rbp), %rax
180001a27:     	leaq	0x6(%rax), %r8
180001a2b:     	cmpq	0x360(%rsp), %r8
180001a33:     	jg	0x180001712 <.text+0x712>
180001a39:     	movq	%r8, (%rbp)
180001a3d:     	cmpb	$0x0, (%r13)
180001a42:     	jne	0x180001245 <.text+0x245>
180001a48:     	movq	0x320(%rsp), %r8
180001a50:     	movsd	%xmm1, (%r8,%rax,8)
180001a56:     	movsd	%xmm3, 0x10(%r8,%rax,8)
180001a5d:     	movsd	%xmm4, 0x20(%r8,%rax,8)
180001a64:     	cmpb	$0x0, (%r13)
180001a69:     	jne	0x180001245 <.text+0x245>
180001a6f:     	jmp	0x180001b35 <.text+0xb35>
180001a74:     	movq	(%rbp), %r9
180001a78:     	movq	%r9, 0x138(%rsp)
180001a80:     	leaq	0x6(%r9), %r8
180001a84:     	cmpq	0x360(%rsp), %r8
180001a8c:     	jg	0x180001712 <.text+0x712>
180001a92:     	movq	0x320(%rsp), %r9
180001a9a:     	movsd	(%r9,%rax,8), %xmm3
180001aa0:     	movsd	0x10(%r9,%rax,8), %xmm2
180001aa7:     	movsd	0x20(%r9,%rax,8), %xmm4
180001aae:     	movq	%r8, (%rbp)
180001ab2:     	cmpb	$0x0, (%r13)
180001ab7:     	jne	0x180001245 <.text+0x245>
180001abd:     	movsd	0x8923(%rip), %xmm5     # 0x18000a3e8
180001ac5:     	divsd	%xmm1, %xmm5
180001ac9:     	mulsd	%xmm5, %xmm3
180001acd:     	mulsd	%xmm5, %xmm2
180001ad1:     	mulsd	%xmm4, %xmm5
180001ad5:     	movq	0x320(%rsp), %rax
180001add:     	movq	0x138(%rsp), %r8
180001ae5:     	movsd	%xmm3, (%rax,%r8,8)
180001aeb:     	movsd	%xmm2, 0x10(%rax,%r8,8)
180001af2:     	movsd	%xmm5, 0x20(%rax,%r8,8)
180001af9:     	cmpb	$0x0, (%r13)
180001afe:     	jne	0x180001245 <.text+0x245>
180001b04:     	jmp	0x1800018bc <.text+0x8bc>
180001b09:     	movb	$0x1, (%r13)
180001b0e:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
180001b16:     	cmpb	$0x0, (%r13)
180001b1b:     	jne	0x180001245 <.text+0x245>
180001b21:     	movq	0x320(%rsp), %rax
180001b29:     	movsd	-0x8(%rax), %xmm1
180001b2e:     	movq	$-0x1, %rax
180001b35:     	mulsd	%xmm1, %xmm1
180001b39:     	movapd	0x888f(%rip), %xmm2     # 0x18000a3d0
180001b41:     	andpd	%xmm1, %xmm2
180001b45:     	ucomisd	0x8893(%rip), %xmm2     # 0x18000a3e0
180001b4d:     	jae	0x180001bcd <.text+0xbcd>
180001b4f:     	movq	0x320(%rsp), %r8
180001b57:     	movsd	0x10(%r8,%rax,8), %xmm2
180001b5e:     	mulsd	%xmm2, %xmm2
180001b62:     	movapd	0x8866(%rip), %xmm3     # 0x18000a3d0
180001b6a:     	andpd	%xmm2, %xmm3
180001b6e:     	ucomisd	0x886a(%rip), %xmm3     # 0x18000a3e0
180001b76:     	jae	0x180001bcd <.text+0xbcd>
180001b78:     	addsd	%xmm2, %xmm1
180001b7c:     	movapd	0x884c(%rip), %xmm2     # 0x18000a3d0
180001b84:     	andpd	%xmm1, %xmm2
180001b88:     	ucomisd	0x8850(%rip), %xmm2     # 0x18000a3e0
180001b90:     	jae	0x180001bcd <.text+0xbcd>
180001b92:     	movsd	0x20(%r8,%rax,8), %xmm2
180001b99:     	mulsd	%xmm2, %xmm2
180001b9d:     	movapd	0x882b(%rip), %xmm3     # 0x18000a3d0
180001ba5:     	andpd	%xmm2, %xmm3
180001ba9:     	ucomisd	0x882f(%rip), %xmm3     # 0x18000a3e0
180001bb1:     	jae	0x180001bcd <.text+0xbcd>
180001bb3:     	addsd	%xmm2, %xmm1
180001bb7:     	movapd	0x8811(%rip), %xmm2     # 0x18000a3d0
180001bbf:     	andpd	%xmm1, %xmm2
180001bc3:     	ucomisd	0x8815(%rip), %xmm2     # 0x18000a3e0
180001bcb:     	jb	0x180001be9 <.text+0xbe9>
180001bcd:     	movb	$0x1, (%r13)
180001bd2:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001bda:     	cmpb	$0x0, (%r13)
180001bdf:     	jne	0x180001245 <.text+0x245>
180001be5:     	xorpd	%xmm1, %xmm1
180001be9:     	sqrtsd	%xmm1, %xmm1
180001bed:     	xorpd	%xmm2, %xmm2
180001bf1:     	ucomisd	%xmm2, %xmm1
180001bf5:     	jne	0x1800027f5 <.text+0x17f5>
180001bfb:     	jp	0x1800027f5 <.text+0x17f5>
180001c01:     	movb	$0x1, (%r13)
180001c06:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001c0e:     	cmpb	$0x0, (%r13)
180001c13:     	jne	0x180001245 <.text+0x245>
180001c19:     	movq	$-0x1, 0x160(%rsp)
180001c25:     	movq	0x3e8(%rsp), %rax
180001c2d:     	movq	0x8(%r12,%rax,8), %rax
180001c32:     	movq	%rax, 0x1e0(%rsp)
180001c3a:     	testq	%rax, %rax
180001c3d:     	jle	0x180001245 <.text+0x245>
180001c43:     	xorps	%xmm1, %xmm1
180001c46:     	cvtsi2sd	%rcx, %xmm1
180001c4b:     	xorps	%xmm2, %xmm2
180001c4e:     	cvtsi2sd	%rdx, %xmm2
180001c53:     	movsd	0x876d(%rip), %xmm6     # 0x18000a3c8
180001c5b:     	movapd	%xmm0, %xmm8
180001c60:     	mulsd	%xmm0, %xmm6
180001c64:     	movapd	%xmm0, %xmm7
180001c68:     	addsd	%xmm0, %xmm8
180001c6d:     	movapd	%xmm6, %xmm9
180001c72:     	addsd	%xmm6, %xmm9
180001c77:     	divsd	%xmm1, %xmm8
180001c7c:     	divsd	%xmm2, %xmm9
180001c81:     	movapd	0x8746(%rip), %xmm10    # 0x18000a3d0
180001c8a:     	movsd	0x874d(%rip), %xmm11    # 0x18000a3e0
180001c93:     	xorpd	%xmm12, %xmm12
180001c98:     	movsd	0x874f(%rip), %xmm13    # 0x18000a3f0
180001ca1:     	movsd	0x8756(%rip), %xmm15    # 0x18000a400
180001caa:     	movq	$-0x1, 0x168(%rsp)
180001cb6:     	movq	$0x0, 0x158(%rsp)
180001cc2:     	movq	0x158(%rsp), %rcx
180001cca:     	leaq	0x1(%rcx), %rax
180001cce:     	movq	%rax, 0x158(%rsp)
180001cd6:     	movq	0x3e8(%rsp), %rax
180001cde:     	movq	0x10(%r12,%rax,8), %rdx
180001ce3:     	testq	%rdx, %rdx
180001ce6:     	movl	$0x0, %eax
180001ceb:     	cmovleq	%rax, %rdx
180001cef:     	movq	%rdx, 0x1f0(%rsp)
180001cf7:     	movq	%rcx, 0x1e8(%rsp)
180001cff:     	xorps	%xmm14, %xmm14
180001d03:     	cvtsi2sd	%rcx, %xmm14
180001d08:     	mulsd	%xmm9, %xmm14
180001d0d:     	subsd	%xmm6, %xmm14
180001d12:     	movq	$0x0, 0x140(%rsp)
180001d1e:     	movq	0x140(%rsp), %rax
180001d26:     	cmpq	%rax, 0x1f0(%rsp)
180001d2e:     	je	0x1800027d2 <.text+0x17d2>
180001d34:     	movq	(%rbp), %rdx
180001d38:     	leaq	0x6(%rdx), %rax
180001d3c:     	cmpq	0x360(%rsp), %rax
180001d44:     	jg	0x180001712 <.text+0x712>
180001d4a:     	movq	0x320(%rsp), %rcx
180001d52:     	movq	0x138(%rsp), %r8
180001d5a:     	movsd	(%rcx,%r8,8), %xmm0
180001d60:     	movsd	0x10(%rcx,%r8,8), %xmm1
180001d67:     	movsd	0x20(%rcx,%r8,8), %xmm2
180001d6e:     	movq	%rax, (%rbp)
180001d72:     	cmpb	$0x0, (%r13)
180001d77:     	jne	0x180001245 <.text+0x245>
180001d7d:     	xorps	%xmm3, %xmm3
180001d80:     	cvtsi2sdq	0x140(%rsp), %xmm3
180001d8a:     	mulsd	%xmm8, %xmm3
180001d8f:     	subsd	%xmm7, %xmm3
180001d93:     	mulsd	%xmm3, %xmm0
180001d97:     	mulsd	%xmm3, %xmm1
180001d9b:     	mulsd	%xmm2, %xmm3
180001d9f:     	movq	0x320(%rsp), %rax
180001da7:     	movsd	%xmm0, (%rax,%rdx,8)
180001dac:     	movsd	%xmm1, 0x10(%rax,%rdx,8)
180001db2:     	movsd	%xmm3, 0x20(%rax,%rdx,8)
180001db8:     	cmpb	$0x0, (%r13)
180001dbd:     	jne	0x180001245 <.text+0x245>
180001dc3:     	movq	(%rbp), %rax
180001dc7:     	leaq	0x6(%rax), %rcx
180001dcb:     	cmpq	0x360(%rsp), %rcx
180001dd3:     	jg	0x180001712 <.text+0x712>
180001dd9:     	movq	0x320(%rsp), %r8
180001de1:     	movq	0x160(%rsp), %r9
180001de9:     	movsd	(%r8,%r9,8), %xmm0
180001def:     	movsd	0x10(%r8,%r9,8), %xmm1
180001df6:     	movsd	0x20(%r8,%r9,8), %xmm2
180001dfd:     	movq	%rcx, (%rbp)
180001e01:     	cmpb	$0x0, (%r13)
180001e06:     	jne	0x180001245 <.text+0x245>
180001e0c:     	mulsd	%xmm14, %xmm0
180001e11:     	mulsd	%xmm14, %xmm1
180001e16:     	mulsd	%xmm14, %xmm2
180001e1b:     	movq	0x320(%rsp), %rcx
180001e23:     	movsd	%xmm0, (%rcx,%rax,8)
180001e28:     	movsd	%xmm1, 0x10(%rcx,%rax,8)
180001e2e:     	movsd	%xmm2, 0x20(%rcx,%rax,8)
180001e34:     	cmpb	$0x0, (%r13)
180001e39:     	jne	0x180001245 <.text+0x245>
180001e3f:     	movq	0x148(%rsp), %r8
180001e47:     	movq	(%r12,%r8,8), %rcx
180001e4b:     	movq	0x8(%r12,%r8,8), %r8
180001e50:     	movq	0x320(%rsp), %r9
180001e58:     	movsd	(%r9,%r8,8), %xmm0
180001e5e:     	addsd	(%r9,%rdx,8), %xmm0
180001e64:     	movapd	%xmm0, %xmm1
180001e68:     	andpd	%xmm10, %xmm1
180001e6d:     	ucomisd	%xmm11, %xmm1
180001e72:     	jae	0x180001f0c <.text+0xf0c>
180001e78:     	movsd	0x10(%r9,%r8,8), %xmm1
180001e7f:     	addsd	0x10(%r9,%rdx,8), %xmm1
180001e86:     	movapd	%xmm1, %xmm2
180001e8a:     	andpd	%xmm10, %xmm2
180001e8f:     	ucomisd	%xmm11, %xmm2
180001e94:     	jae	0x180001f0c <.text+0xf0c>
180001e96:     	movsd	0x20(%r9,%r8,8), %xmm2
180001e9d:     	addsd	0x20(%r9,%rdx,8), %xmm2
180001ea4:     	movapd	%xmm2, %xmm3
180001ea8:     	andpd	%xmm10, %xmm3
180001ead:     	ucomisd	%xmm11, %xmm3
180001eb2:     	jae	0x180001f0c <.text+0xf0c>
180001eb4:     	movq	(%rbp), %r8
180001eb8:     	leaq	0x6(%r8), %rdx
180001ebc:     	cmpq	0x360(%rsp), %rdx
180001ec4:     	jg	0x180001712 <.text+0x712>
180001eca:     	movq	%rdx, (%rbp)
180001ece:     	cmpb	$0x0, (%r13)
180001ed3:     	jne	0x180001245 <.text+0x245>
180001ed9:     	movq	0x320(%rsp), %rdx
180001ee1:     	movsd	%xmm0, (%rdx,%r8,8)
180001ee7:     	movsd	%xmm1, 0x10(%rdx,%r8,8)
180001eee:     	movsd	%xmm2, 0x20(%rdx,%r8,8)
180001ef5:     	movzbl	(%r13), %r9d
180001efa:     	movl	%r9d, %edx
180001efd:     	negb	%dl
180001eff:     	movl	$0x0, %edx
180001f04:     	sbbq	%rdx, %rdx
180001f07:     	orq	%r8, %rdx
180001f0a:     	jmp	0x180001f25 <.text+0xf25>
180001f0c:     	movb	$0x1, (%r13)
180001f11:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
180001f19:     	movzbl	(%r13), %r9d
180001f1e:     	movq	$-0x1, %rdx
180001f25:     	testb	%r9b, %r9b
180001f28:     	jne	0x180001245 <.text+0x245>
180001f2e:     	movq	0x320(%rsp), %r8
180001f36:     	movsd	(%r8,%rdx,8), %xmm0
180001f3c:     	addsd	(%r8,%rax,8), %xmm0
180001f42:     	movapd	%xmm0, %xmm1
180001f46:     	andpd	%xmm10, %xmm1
180001f4b:     	ucomisd	%xmm11, %xmm1
180001f50:     	jae	0x180001fe7 <.text+0xfe7>
180001f56:     	movsd	0x10(%r8,%rdx,8), %xmm1
180001f5d:     	addsd	0x10(%r8,%rax,8), %xmm1
180001f64:     	movapd	%xmm1, %xmm2
180001f68:     	andpd	%xmm10, %xmm2
180001f6d:     	ucomisd	%xmm11, %xmm2
180001f72:     	jae	0x180001fe7 <.text+0xfe7>
180001f74:     	movsd	0x20(%r8,%rdx,8), %xmm2
180001f7b:     	addsd	0x20(%r8,%rax,8), %xmm2
180001f82:     	movapd	%xmm2, %xmm3
180001f86:     	andpd	%xmm10, %xmm3
180001f8b:     	ucomisd	%xmm11, %xmm3
180001f90:     	jae	0x180001fe7 <.text+0xfe7>
180001f92:     	movq	(%rbp), %rax
180001f96:     	leaq	0x6(%rax), %rdx
180001f9a:     	cmpq	0x360(%rsp), %rdx
180001fa2:     	jg	0x180001712 <.text+0x712>
180001fa8:     	movq	%rdx, (%rbp)
180001fac:     	cmpb	$0x0, (%r13)
180001fb1:     	jne	0x180001245 <.text+0x245>
180001fb7:     	movq	0x320(%rsp), %rdx
180001fbf:     	movsd	%xmm0, (%rdx,%rax,8)
180001fc4:     	movsd	%xmm1, 0x10(%rdx,%rax,8)
180001fca:     	movsd	%xmm2, 0x20(%rdx,%rax,8)
180001fd0:     	movzbl	(%r13), %r8d
180001fd5:     	movl	%r8d, %edx
180001fd8:     	negb	%dl
180001fda:     	movl	$0x0, %edx
180001fdf:     	sbbq	%rdx, %rdx
180001fe2:     	orq	%rax, %rdx
180001fe5:     	jmp	0x180002000 <.text+0x1000>
180001fe7:     	movb	$0x1, (%r13)
180001fec:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
180001ff4:     	movzbl	(%r13), %r8d
180001ff9:     	movq	$-0x1, %rdx
180002000:     	testb	%r8b, %r8b
180002003:     	jne	0x180001245 <.text+0x245>
180002009:     	movq	(%rbp), %rax
18000200d:     	leaq	0x2(%rax), %r8
180002011:     	cmpq	0x360(%rsp), %r8
180002019:     	jg	0x180001712 <.text+0x712>
18000201f:     	movq	%r8, (%rbp)
180002023:     	cmpb	$0x0, (%r13)
180002028:     	jne	0x180001245 <.text+0x245>
18000202e:     	movq	%rcx, (%r12,%rax,8)
180002032:     	cmpb	$0x0, (%r13)
180002037:     	jne	0x180001245 <.text+0x245>
18000203d:     	movq	0x320(%rsp), %rcx
180002045:     	movsd	(%rcx,%rdx,8), %xmm0
18000204a:     	mulsd	%xmm0, %xmm0
18000204e:     	movapd	%xmm0, %xmm1
180002052:     	andpd	%xmm10, %xmm1
180002057:     	ucomisd	%xmm11, %xmm1
18000205c:     	jae	0x1800020ba <.text+0x10ba>
18000205e:     	movsd	0x10(%rcx,%rdx,8), %xmm1
180002064:     	mulsd	%xmm1, %xmm1
180002068:     	movapd	%xmm1, %xmm2
18000206c:     	andpd	%xmm10, %xmm2
180002071:     	ucomisd	%xmm11, %xmm2
180002076:     	jae	0x1800020ba <.text+0x10ba>
180002078:     	addsd	%xmm1, %xmm0
18000207c:     	movapd	%xmm0, %xmm1
180002080:     	andpd	%xmm10, %xmm1
180002085:     	ucomisd	%xmm11, %xmm1
18000208a:     	jae	0x1800020ba <.text+0x10ba>
18000208c:     	movsd	0x20(%rcx,%rdx,8), %xmm1
180002092:     	mulsd	%xmm1, %xmm1
180002096:     	movapd	%xmm1, %xmm2
18000209a:     	andpd	%xmm10, %xmm2
18000209f:     	ucomisd	%xmm11, %xmm2
1800020a4:     	jae	0x1800020ba <.text+0x10ba>
1800020a6:     	addsd	%xmm1, %xmm0
1800020aa:     	movapd	%xmm0, %xmm1
1800020ae:     	andpd	%xmm10, %xmm1
1800020b3:     	ucomisd	%xmm11, %xmm1
1800020b8:     	jb	0x1800020d6 <.text+0x10d6>
1800020ba:     	movb	$0x1, (%r13)
1800020bf:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800020c7:     	xorpd	%xmm0, %xmm0
1800020cb:     	cmpb	$0x0, (%r13)
1800020d0:     	jne	0x180001245 <.text+0x245>
1800020d6:     	sqrtsd	%xmm0, %xmm0
1800020da:     	ucomisd	%xmm12, %xmm0
1800020df:     	jne	0x180002101 <.text+0x1101>
1800020e1:     	jp	0x180002101 <.text+0x1101>
1800020e3:     	movb	$0x1, (%r13)
1800020e8:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800020f0:     	movzbl	(%r13), %edx
1800020f5:     	movq	$-0x1, %r8
1800020fc:     	jmp	0x18000218a <.text+0x118a>
180002101:     	movq	(%rbp), %rcx
180002105:     	leaq	0x6(%rcx), %r8
180002109:     	cmpq	0x360(%rsp), %r8
180002111:     	jg	0x180001712 <.text+0x712>
180002117:     	movq	0x320(%rsp), %r9
18000211f:     	movsd	(%r9,%rdx,8), %xmm1
180002125:     	movsd	0x10(%r9,%rdx,8), %xmm2
18000212c:     	movsd	0x20(%r9,%rdx,8), %xmm3
180002133:     	movq	%r8, (%rbp)
180002137:     	cmpb	$0x0, (%r13)
18000213c:     	jne	0x180001245 <.text+0x245>
180002142:     	movsd	0x829e(%rip), %xmm4     # 0x18000a3e8
18000214a:     	divsd	%xmm0, %xmm4
18000214e:     	mulsd	%xmm4, %xmm1
180002152:     	mulsd	%xmm4, %xmm2
180002156:     	mulsd	%xmm3, %xmm4
18000215a:     	movq	0x320(%rsp), %rdx
180002162:     	movsd	%xmm1, (%rdx,%rcx,8)
180002167:     	movsd	%xmm2, 0x10(%rdx,%rcx,8)
18000216d:     	movsd	%xmm4, 0x20(%rdx,%rcx,8)
180002173:     	movzbl	(%r13), %edx
180002178:     	movl	%edx, %r8d
18000217b:     	negb	%r8b
18000217e:     	movl	$0x0, %r8d
180002184:     	sbbq	%r8, %r8
180002187:     	orq	%rcx, %r8
18000218a:     	testb	%dl, %dl
18000218c:     	jne	0x180001245 <.text+0x245>
180002192:     	movq	%r8, 0x8(%r12,%rax,8)
180002197:     	cmpb	$0x0, (%r13)
18000219c:     	jne	0x180001245 <.text+0x245>
1800021a2:     	movq	0x8(%rbp), %rcx
1800021a6:     	leaq	0x1(%rcx), %rdx
1800021aa:     	movq	%rdx, 0x8(%rbp)
1800021ae:     	cmpq	0x10(%rbp), %rcx
1800021b2:     	jge	0x18000288a <.text+0x188a>
1800021b8:     	movq	$0x0, 0x170(%rsp)
1800021c4:     	movb	$0x0, 0x178(%rsp)
1800021cc:     	movq	$0x0, 0x180(%rsp)
1800021d8:     	movb	$0x0, 0x188(%rsp)
1800021e0:     	movq	$0x0, 0x190(%rsp)
1800021ec:     	movb	$0x0, 0x198(%rsp)
1800021f4:     	movq	$0x0, 0x1a0(%rsp)
180002200:     	movb	$0x0, 0x1a8(%rsp)
180002208:     	movq	$0x0, 0x1b0(%rsp)
180002214:     	movb	$0x0, 0x1b8(%rsp)
18000221c:     	movq	$0x0, 0x1c0(%rsp)
180002228:     	movb	$0x0, 0x1c8(%rsp)
180002230:     	movq	%rax, 0x100(%rsp)
180002238:     	movq	%r15, 0xf8(%rsp)
180002240:     	movq	0x3d8(%rsp), %rax
180002248:     	movq	%rax, 0xe8(%rsp)
180002250:     	movq	0x3d0(%rsp), %rax
180002258:     	movq	%rax, 0xe0(%rsp)
180002260:     	movq	%r13, 0xd8(%rsp)
180002268:     	movq	0x3c0(%rsp), %rax
180002270:     	movq	%rax, 0xd0(%rsp)
180002278:     	movq	0x3b8(%rsp), %rax
180002280:     	movq	%rax, 0xc8(%rsp)
180002288:     	movq	0x3b0(%rsp), %rax
180002290:     	movq	%rax, 0xc0(%rsp)
180002298:     	movq	0x3a8(%rsp), %rax
1800022a0:     	movq	%rax, 0xb8(%rsp)
1800022a8:     	movq	0x3a0(%rsp), %rax
1800022b0:     	movq	%rax, 0xb0(%rsp)
1800022b8:     	movq	0x398(%rsp), %rax
1800022c0:     	movq	%rax, 0xa8(%rsp)
1800022c8:     	movq	%rbp, 0xa0(%rsp)
1800022d0:     	movq	0x388(%rsp), %rax
1800022d8:     	movq	%rax, 0x98(%rsp)
1800022e0:     	movq	0x380(%rsp), %rax
1800022e8:     	movq	%rax, 0x90(%rsp)
1800022f0:     	movq	0x378(%rsp), %rax
1800022f8:     	movq	%rax, 0x88(%rsp)
180002300:     	movq	0x370(%rsp), %rax
180002308:     	movq	%rax, 0x80(%rsp)
180002310:     	movq	0x368(%rsp), %rax
180002318:     	movq	%rax, 0x78(%rsp)
18000231d:     	movq	0x360(%rsp), %rax
180002325:     	movq	%rax, 0x70(%rsp)
18000232a:     	movq	%r12, 0x68(%rsp)
18000232f:     	movq	0x350(%rsp), %rax
180002337:     	movq	%rax, 0x60(%rsp)
18000233c:     	movq	0x348(%rsp), %rax
180002344:     	movq	%rax, 0x58(%rsp)
180002349:     	movq	0x340(%rsp), %rax
180002351:     	movq	%rax, 0x50(%rsp)
180002356:     	movq	0x338(%rsp), %rax
18000235e:     	movq	%rax, 0x48(%rsp)
180002363:     	movq	0x330(%rsp), %rax
18000236b:     	movq	%rax, 0x40(%rsp)
180002370:     	movq	0x328(%rsp), %rax
180002378:     	movq	%rax, 0x38(%rsp)
18000237d:     	movq	0x320(%rsp), %rax
180002385:     	movq	%rax, 0x30(%rsp)
18000238a:     	movq	0x318(%rsp), %rax
180002392:     	movq	%rax, 0x28(%rsp)
180002397:     	movq	0x310(%rsp), %rax
18000239f:     	movq	%rax, 0x20(%rsp)
1800023a4:     	movq	$-0x1, 0x128(%rsp)
1800023b0:     	movq	$-0x1, 0x120(%rsp)
1800023bc:     	movq	$-0x1, 0x118(%rsp)
1800023c8:     	movq	$-0x1, 0x110(%rsp)
1800023d4:     	movq	$-0x1, 0x108(%rsp)
1800023e0:     	movq	$0x0, 0xf0(%rsp)
1800023ec:     	leaq	0x170(%rsp), %rcx
1800023f4:     	leaq	0x1f8(%rsp), %rdx
1800023fc:     	movq	%r14, %r8
1800023ff:     	movq	%rbx, %r9
180002402:     	callq	0x180003330 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x60>
180002407:     	testl	%eax, %eax
180002409:     	jne	0x18000289c <.text+0x189c>
18000240f:     	cmpb	$0x0, (%r13)
180002414:     	jne	0x180001245 <.text+0x245>
18000241a:     	movsd	0x170(%rsp), %xmm2
180002423:     	movsd	0x180(%rsp), %xmm1
18000242c:     	movsd	0x190(%rsp), %xmm0
180002435:     	decq	0x8(%rbp)
180002439:     	movq	0x3e8(%rsp), %rax
180002441:     	movq	0x8(%r12,%rax,8), %rax
180002446:     	movq	%rax, %rcx
180002449:     	subq	0x1e8(%rsp), %rcx
180002451:     	movq	%rcx, %rdx
180002454:     	notq	%rdx
180002457:     	testq	%rdx, %rax
18000245a:     	js	0x180001231 <.text+0x231>
180002460:     	cmpb	$0x0, (%r13)
180002465:     	jne	0x180001245 <.text+0x245>
18000246b:     	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
180002475:     	cmpq	%rdx, %rcx
180002478:     	je	0x180001231 <.text+0x231>
18000247e:     	decq	%rcx
180002481:     	movq	0x3e8(%rsp), %rdx
180002489:     	movq	0x10(%r12,%rdx,8), %rdx
18000248e:     	cvtsi2sd	%rcx, %xmm3
180002493:     	cvtsi2sd	%rdx, %xmm4
180002498:     	mulsd	%xmm3, %xmm4
18000249c:     	andpd	%xmm10, %xmm4
1800024a1:     	ucomisd	%xmm13, %xmm4
1800024a6:     	jae	0x180001231 <.text+0x231>
1800024ac:     	imulq	%rdx, %rcx
1800024b0:     	addq	0x168(%rsp), %rax
1800024b8:     	imulq	%rdx, %rax
1800024bc:     	movq	0x140(%rsp), %r8
1800024c4:     	addq	%r8, %rax
1800024c7:     	xorq	%rax, %rcx
1800024ca:     	movq	%rax, %rdx
1800024cd:     	xorq	%r8, %rdx
1800024d0:     	testq	%rdx, %rcx
1800024d3:     	js	0x180001231 <.text+0x231>
1800024d9:     	xorps	%xmm3, %xmm3
1800024dc:     	cvtsi2sd	%rax, %xmm3
1800024e1:     	mulsd	0x7f0f(%rip), %xmm3     # 0x18000a3f8
1800024e9:     	andpd	%xmm10, %xmm3
1800024ee:     	ucomisd	%xmm13, %xmm3
1800024f3:     	jae	0x180001231 <.text+0x231>
1800024f9:     	mulsd	%xmm15, %xmm2
1800024fe:     	movapd	%xmm2, %xmm3
180002502:     	andpd	%xmm10, %xmm3
180002507:     	ucomisd	%xmm11, %xmm3
18000250c:     	jae	0x18000278f <.text+0x178f>
180002512:     	movsd	0x7eee(%rip), %xmm4     # 0x18000a408
18000251a:     	ucomisd	%xmm3, %xmm4
18000251e:     	jbe	0x18000278f <.text+0x178f>
180002524:     	leaq	(%rax,%rax,2), %rcx
180002528:     	cvttsd2si	%xmm2, %rdx
18000252d:     	testq	%rdx, %rdx
180002530:     	movl	$0x0, %r8d
180002536:     	cmovleq	%r8, %rdx
18000253a:     	cmpq	$0xff, %rdx
180002541:     	movl	$0xff, %r8d
180002547:     	cmovgeq	%r8, %rdx
18000254b:     	movq	0x3e8(%rsp), %r8
180002553:     	movq	(%r12,%r8,8), %r9
180002557:     	movq	%r9, %r8
18000255a:     	sarq	$0x3f, %r8
18000255e:     	andq	0x360(%rsp), %r8
180002566:     	leaq	(%r12,%r9,8), %r10
18000256a:     	movq	(%r10,%r8,8), %r11
18000256e:     	testq	%rax, %rax
180002571:     	movq	%rcx, %r8
180002574:     	jns	0x180002582 <.text+0x1582>
180002576:     	movq	%r11, %r8
180002579:     	addq	%rcx, %r8
18000257c:     	js	0x18000278f <.text+0x178f>
180002582:     	cmpq	%r11, %r8
180002585:     	jge	0x18000278f <.text+0x178f>
18000258b:     	cmpq	$-0x2, %r9
18000258f:     	movl	$0x0, %r9d
180002595:     	movq	0x360(%rsp), %r11
18000259d:     	cmovlq	%r11, %r9
1800025a1:     	addq	0x10(%r10,%r9,8), %r8
1800025a6:     	movq	%r8, %r9
1800025a9:     	sarq	$0x3f, %r9
1800025ad:     	andq	%r11, %r9
1800025b0:     	leaq	(%r12,%r8,8), %r8
1800025b4:     	movq	%rdx, (%r8,%r9,8)
1800025b8:     	mulsd	%xmm15, %xmm1
1800025bd:     	movapd	%xmm1, %xmm2
1800025c1:     	andpd	%xmm10, %xmm2
1800025c6:     	ucomisd	%xmm11, %xmm2
1800025cb:     	jae	0x1800027b4 <.text+0x17b4>
1800025d1:     	movsd	0x7e2f(%rip), %xmm3     # 0x18000a408
1800025d9:     	ucomisd	%xmm2, %xmm3
1800025dd:     	jbe	0x1800027b4 <.text+0x17b4>
1800025e3:     	cvttsd2si	%xmm1, %r8
1800025e8:     	testq	%r8, %r8
1800025eb:     	movl	$0x0, %edx
1800025f0:     	cmovleq	%rdx, %r8
1800025f4:     	cmpq	$0xff, %r8
1800025fb:     	movl	$0xff, %edx
180002600:     	cmovgeq	%rdx, %r8
180002604:     	leaq	0x1(%rcx), %r9
180002608:     	movq	%rcx, %rdx
18000260b:     	notq	%rdx
18000260e:     	movq	%r9, 0x150(%rsp)
180002616:     	testq	%rdx, %r9
180002619:     	js	0x180001231 <.text+0x231>
18000261f:     	cmpb	$0x0, (%r13)
180002624:     	jne	0x180001245 <.text+0x245>
18000262a:     	movq	0x3e8(%rsp), %r10
180002632:     	movq	(%r12,%r10,8), %r9
180002636:     	movq	%r9, %r11
180002639:     	sarq	$0x3f, %r11
18000263d:     	andq	0x360(%rsp), %r11
180002645:     	testq	%rax, %rax
180002648:     	leaq	(%r12,%r9,8), %r10
18000264c:     	movq	%r10, 0x1d8(%rsp)
180002654:     	movq	%r9, 0x1d0(%rsp)
18000265c:     	leaq	(%r12,%r9,8), %r10
180002660:     	movq	(%r10,%r11,8), %r11
180002664:     	jns	0x180002674 <.text+0x1674>
180002666:     	addq	%r11, 0x150(%rsp)
18000266e:     	js	0x1800027b4 <.text+0x17b4>
180002674:     	cmpq	%r11, 0x150(%rsp)
18000267c:     	jge	0x1800027b4 <.text+0x17b4>
180002682:     	cmpq	$-0x2, 0x1d0(%rsp)
18000268b:     	movl	$0x0, %r10d
180002691:     	movq	0x360(%rsp), %r11
180002699:     	cmovlq	%r11, %r10
18000269d:     	movq	0x1d8(%rsp), %r11
1800026a5:     	movq	0x150(%rsp), %r9
1800026ad:     	addq	0x10(%r11,%r10,8), %r9
1800026b2:     	movq	%r9, %r10
1800026b5:     	sarq	$0x3f, %r10
1800026b9:     	andq	0x360(%rsp), %r10
1800026c1:     	leaq	(%r12,%r9,8), %r9
1800026c5:     	movq	%r8, (%r9,%r10,8)
1800026c9:     	mulsd	%xmm15, %xmm0
1800026ce:     	movapd	%xmm0, %xmm1
1800026d2:     	andpd	%xmm10, %xmm1
1800026d7:     	ucomisd	%xmm11, %xmm1
1800026dc:     	jae	0x1800027c3 <.text+0x17c3>
1800026e2:     	movsd	0x7d1e(%rip), %xmm2     # 0x18000a408
1800026ea:     	ucomisd	%xmm1, %xmm2
1800026ee:     	jbe	0x1800027c3 <.text+0x17c3>
1800026f4:     	cvttsd2si	%xmm0, %r8
1800026f9:     	testq	%r8, %r8
1800026fc:     	movl	$0x0, %r9d
180002702:     	cmovleq	%r9, %r8
180002706:     	cmpq	$0xff, %r8
18000270d:     	movl	$0xff, %r9d
180002713:     	cmovgeq	%r9, %r8
180002717:     	addq	$0x2, %rcx
18000271b:     	testq	%rdx, %rcx
18000271e:     	js	0x180001231 <.text+0x231>
180002724:     	cmpb	$0x0, (%r13)
180002729:     	jne	0x180001245 <.text+0x245>
18000272f:     	movq	0x3e8(%rsp), %rdx
180002737:     	movq	(%r12,%rdx,8), %rdx
18000273b:     	movq	%rdx, %r9
18000273e:     	sarq	$0x3f, %r9
180002742:     	andq	0x360(%rsp), %r9
18000274a:     	testq	%rax, %rax
18000274d:     	leaq	(%r12,%rdx,8), %rax
180002751:     	movq	(%rax,%r9,8), %r9
180002755:     	jns	0x18000275c <.text+0x175c>
180002757:     	addq	%r9, %rcx
18000275a:     	js	0x1800027c3 <.text+0x17c3>
18000275c:     	cmpq	%r9, %rcx
18000275f:     	jge	0x1800027c3 <.text+0x17c3>
180002761:     	cmpq	$-0x2, %rdx
180002765:     	movl	$0x0, %edx
18000276a:     	movq	0x360(%rsp), %r9
180002772:     	cmovlq	%r9, %rdx
180002776:     	addq	0x10(%rax,%rdx,8), %rcx
18000277b:     	movq	%rcx, %rax
18000277e:     	sarq	$0x3f, %rax
180002782:     	andq	%r9, %rax
180002785:     	leaq	(%r12,%rcx,8), %rcx
180002789:     	movq	%r8, (%rcx,%rax,8)
18000278d:     	jmp	0x18000279c <.text+0x179c>
18000278f:     	movb	$0x1, (%r13)
180002794:     	movq	$0x7a1203, 0x18(%rbp)   # imm = 0x7A1203
18000279c:     	incq	0x140(%rsp)
1800027a4:     	cmpb	$0x0, (%r13)
1800027a9:     	je	0x180001d1e <.text+0xd1e>
1800027af:     	jmp	0x180001245 <.text+0x245>
1800027b4:     	movb	$0x1, (%r13)
1800027b9:     	movq	$0x7a1204, 0x18(%rbp)   # imm = 0x7A1204
1800027c1:     	jmp	0x18000279c <.text+0x179c>
1800027c3:     	movb	$0x1, (%r13)
1800027c8:     	movq	$0x7a1205, 0x18(%rbp)   # imm = 0x7A1205
1800027d0:     	jmp	0x18000279c <.text+0x179c>
1800027d2:     	decq	0x168(%rsp)
1800027da:     	movq	0x158(%rsp), %rax
1800027e2:     	cmpq	0x1e0(%rsp), %rax
1800027ea:     	jne	0x180001cc2 <.text+0xcc2>
1800027f0:     	jmp	0x180001245 <.text+0x245>
1800027f5:     	movq	(%rbp), %r8
1800027f9:     	movq	%r8, 0x160(%rsp)
180002801:     	addq	$0x6, %r8
180002805:     	cmpq	0x360(%rsp), %r8
18000280d:     	jg	0x180001712 <.text+0x712>
180002813:     	movq	0x320(%rsp), %r9
18000281b:     	movsd	(%r9,%rax,8), %xmm2
180002821:     	movsd	0x10(%r9,%rax,8), %xmm3
180002828:     	movsd	0x20(%r9,%rax,8), %xmm4
18000282f:     	movq	%r8, (%rbp)
180002833:     	cmpb	$0x0, (%r13)
180002838:     	jne	0x180001245 <.text+0x245>
18000283e:     	movsd	0x7ba2(%rip), %xmm5     # 0x18000a3e8
180002846:     	divsd	%xmm1, %xmm5
18000284a:     	mulsd	%xmm5, %xmm2
18000284e:     	mulsd	%xmm5, %xmm3
180002852:     	mulsd	%xmm4, %xmm5
180002856:     	movq	0x320(%rsp), %rax
18000285e:     	movq	0x160(%rsp), %r8
180002866:     	movsd	%xmm2, (%rax,%r8,8)
18000286c:     	movsd	%xmm3, 0x10(%rax,%r8,8)
180002873:     	movsd	%xmm5, 0x20(%rax,%r8,8)
18000287a:     	cmpb	$0x0, (%r13)
18000287f:     	jne	0x180001245 <.text+0x245>
180002885:     	jmp	0x180001c25 <.text+0xc25>
18000288a:     	movb	$0x1, (%r13)
18000288f:     	movq	$0x13, 0x18(%rbp)
180002897:     	jmp	0x180001245 <.text+0x245>
18000289c:     	movq	%rdi, %rsi
18000289f:     	jmp	0x180001247 <.text+0x247>
1800028a4:     	nopw	%cs:(%rax,%rax)
1800028ae:     	nop
1800028b0:     	pushq	%r15
1800028b2:     	pushq	%r14
1800028b4:     	pushq	%r13
1800028b6:     	pushq	%r12
1800028b8:     	pushq	%rsi
1800028b9:     	pushq	%rdi
1800028ba:     	pushq	%rbp
1800028bb:     	pushq	%rbx
1800028bc:     	subq	$0x2d8, %rsp            # imm = 0x2D8
1800028c3:     	movq	%rdx, %rcx
1800028c6:     	leaq	0x1a0(%rsp), %rax
1800028ce:     	movq	%rax, 0x48(%rsp)
1800028d3:     	leaq	0x1a8(%rsp), %rax
1800028db:     	movq	%rax, 0x40(%rsp)
1800028e0:     	leaq	0x1b0(%rsp), %rax
1800028e8:     	movq	%rax, 0x38(%rsp)
1800028ed:     	leaq	0x1b8(%rsp), %rax
1800028f5:     	movq	%rax, 0x30(%rsp)
1800028fa:     	leaq	0x1c0(%rsp), %rax
180002902:     	movq	%rax, 0x28(%rsp)
180002907:     	leaq	0x1c8(%rsp), %rax
18000290f:     	movq	%rax, 0x20(%rsp)
180002914:     	leaq	0x7bcd(%rip), %rdx      # 0x18000a4e8
18000291b:     	movl	$0x6, %r8d
180002921:     	movl	$0x6, %r9d
180002927:     	callq	0x180008891 <numba_list_iter_next+0x311>
18000292c:     	testl	%eax, %eax
18000292e:     	movq	$0x0, 0x118(%rsp)
18000293a:     	je	0x180002f58 <.text+0x1f58>
180002940:     	cmpq	$0x0, 0xf328(%rip)      # 0x180011c70
180002948:     	je	0x180002e8d <.text+0x1e8d>
18000294e:     	movq	0x1c8(%rsp), %rcx
180002956:     	xorps	%xmm0, %xmm0
180002959:     	movaps	%xmm0, 0x290(%rsp)
180002961:     	movaps	%xmm0, 0x2a0(%rsp)
180002969:     	movaps	%xmm0, 0x2b0(%rsp)
180002971:     	movq	$0x0, 0x2c0(%rsp)
18000297d:     	leaq	0x290(%rsp), %rdx
180002985:     	callq	0x180007550 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4280>
18000298a:     	testl	%eax, %eax
18000298c:     	jne	0x180002ea5 <.text+0x1ea5>
180002992:     	cmpq	$0x8, 0x2a8(%rsp)
18000299b:     	jne	0x180002ea5 <.text+0x1ea5>
1800029a1:     	movq	0x290(%rsp), %rsi
1800029a9:     	movq	0x298(%rsp), %rbp
1800029b1:     	movq	0x2a0(%rsp), %rbx
1800029b9:     	movq	0x2b0(%rsp), %r14
1800029c1:     	movq	0x2b8(%rsp), %r15
1800029c9:     	movq	0x2c0(%rsp), %r12
1800029d1:     	movq	0x1c0(%rsp), %rcx
1800029d9:     	xorps	%xmm0, %xmm0
1800029dc:     	movaps	%xmm0, 0x250(%rsp)
1800029e4:     	movaps	%xmm0, 0x260(%rsp)
1800029ec:     	movaps	%xmm0, 0x270(%rsp)
1800029f4:     	movq	$0x0, 0x280(%rsp)
180002a00:     	leaq	0x250(%rsp), %rdx
180002a08:     	callq	0x180007550 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4280>
180002a0d:     	testl	%eax, %eax
180002a0f:     	jne	0x180002ebd <.text+0x1ebd>
180002a15:     	cmpq	$0x8, 0x268(%rsp)
180002a1e:     	jne	0x180002ebd <.text+0x1ebd>
180002a24:     	movq	0x250(%rsp), %rdi
180002a2c:     	movq	0x258(%rsp), %r13
180002a34:     	movq	0x260(%rsp), %rax
180002a3c:     	movq	%rax, 0x198(%rsp)
180002a44:     	movq	0x270(%rsp), %rax
180002a4c:     	movq	%rax, 0x190(%rsp)
180002a54:     	movq	0x278(%rsp), %rax
180002a5c:     	movq	%rax, 0x188(%rsp)
180002a64:     	movq	0x280(%rsp), %rax
180002a6c:     	movq	%rax, 0x180(%rsp)
180002a74:     	movq	0x1b8(%rsp), %rcx
180002a7c:     	xorps	%xmm0, %xmm0
180002a7f:     	movaps	%xmm0, 0x210(%rsp)
180002a87:     	movaps	%xmm0, 0x220(%rsp)
180002a8f:     	movaps	%xmm0, 0x230(%rsp)
180002a97:     	movq	$0x0, 0x240(%rsp)
180002aa3:     	leaq	0x210(%rsp), %rdx
180002aab:     	callq	0x180007550 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4280>
180002ab0:     	testl	%eax, %eax
180002ab2:     	jne	0x180002ed2 <.text+0x1ed2>
180002ab8:     	cmpq	$0x8, 0x228(%rsp)
180002ac1:     	jne	0x180002ed2 <.text+0x1ed2>
180002ac7:     	movq	%r13, 0x178(%rsp)
180002acf:     	movq	0x210(%rsp), %r13
180002ad7:     	movq	0x218(%rsp), %rax
180002adf:     	movq	%rax, 0x170(%rsp)
180002ae7:     	movq	0x220(%rsp), %rax
180002aef:     	movq	%rax, 0x168(%rsp)
180002af7:     	movq	0x230(%rsp), %rax
180002aff:     	movq	%rax, 0x160(%rsp)
180002b07:     	movq	0x238(%rsp), %rax
180002b0f:     	movq	%rax, 0x158(%rsp)
180002b17:     	movq	0x240(%rsp), %rax
180002b1f:     	movq	%rax, 0x150(%rsp)
180002b27:     	movq	0x1b0(%rsp), %rcx
180002b2f:     	xorps	%xmm0, %xmm0
180002b32:     	movaps	%xmm0, 0x1d0(%rsp)
180002b3a:     	movaps	%xmm0, 0x1e0(%rsp)
180002b42:     	movaps	%xmm0, 0x1f0(%rsp)
180002b4a:     	movq	$0x0, 0x200(%rsp)
180002b56:     	leaq	0x1d0(%rsp), %rdx
180002b5e:     	callq	0x180007550 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4280>
180002b63:     	testl	%eax, %eax
180002b65:     	jne	0x180002ee7 <.text+0x1ee7>
180002b6b:     	cmpq	$0x1, 0x1e8(%rsp)
180002b74:     	jne	0x180002ee7 <.text+0x1ee7>
180002b7a:     	movq	%r13, 0x100(%rsp)
180002b82:     	movq	%r12, 0x130(%rsp)
180002b8a:     	movq	%r15, 0x138(%rsp)
180002b92:     	movq	%r14, 0x140(%rsp)
180002b9a:     	movq	%rbx, 0x148(%rsp)
180002ba2:     	movq	%rdi, 0x108(%rsp)
180002baa:     	movq	%rsi, 0x110(%rsp)
180002bb2:     	movq	0x1d0(%rsp), %r15
180002bba:     	movq	0x1d8(%rsp), %rax
180002bc2:     	movq	%rax, 0x128(%rsp)
180002bca:     	movq	0x1e0(%rsp), %rax
180002bd2:     	movq	%rax, 0x120(%rsp)
180002bda:     	movq	0x1f0(%rsp), %rbx
180002be2:     	movq	0x1f8(%rsp), %r14
180002bea:     	movq	0x200(%rsp), %rdi
180002bf2:     	movq	0x1a8(%rsp), %rcx
180002bfa:     	callq	0x180008897 <numba_list_iter_next+0x317>
180002bff:     	testq	%rax, %rax
180002c02:     	je	0x180002efc <.text+0x1efc>
180002c08:     	movq	%rax, %r13
180002c0b:     	movq	%rax, %rcx
180002c0e:     	callq	0x18000889d <numba_list_iter_next+0x31d>
180002c13:     	movq	%rax, %r12
180002c16:     	movq	%r13, %rcx
180002c19:     	callq	0x1800088a3 <numba_list_iter_next+0x323>
180002c1e:     	callq	0x1800088a9 <numba_list_iter_next+0x329>
180002c23:     	testq	%rax, %rax
180002c26:     	jne	0x180002f20 <.text+0x1f20>
180002c2c:     	movq	%rbp, %rsi
180002c2f:     	movq	0x1a0(%rsp), %rcx
180002c37:     	callq	0x180008897 <numba_list_iter_next+0x317>
180002c3c:     	testq	%rax, %rax
180002c3f:     	je	0x180002f0f <.text+0x1f0f>
180002c45:     	movq	%rax, %rbp
180002c48:     	movq	%rax, %rcx
180002c4b:     	callq	0x18000889d <numba_list_iter_next+0x31d>
180002c50:     	movq	%rax, %r13
180002c53:     	movq	%rbp, %rcx
180002c56:     	callq	0x1800088a3 <numba_list_iter_next+0x323>
180002c5b:     	callq	0x1800088a9 <numba_list_iter_next+0x329>
180002c60:     	testq	%rax, %rax
180002c63:     	jne	0x180002f20 <.text+0x1f20>
180002c69:     	movq	%r13, 0xf8(%rsp)
180002c71:     	movq	%r12, 0xf0(%rsp)
180002c79:     	movq	%rdi, 0xe8(%rsp)
180002c81:     	movq	%r14, 0xe0(%rsp)
180002c89:     	movq	%rbx, 0xd8(%rsp)
180002c91:     	movq	0x120(%rsp), %rax
180002c99:     	movq	%rax, 0xc8(%rsp)
180002ca1:     	movq	0x128(%rsp), %rax
180002ca9:     	movq	%rax, 0xc0(%rsp)
180002cb1:     	movq	0x150(%rsp), %rax
180002cb9:     	movq	%rax, 0xb0(%rsp)
180002cc1:     	movq	0x158(%rsp), %rax
180002cc9:     	movq	%rax, 0xa8(%rsp)
180002cd1:     	movq	0x160(%rsp), %rax
180002cd9:     	movq	%rax, 0xa0(%rsp)
180002ce1:     	movq	0x168(%rsp), %rax
180002ce9:     	movq	%rax, 0x90(%rsp)
180002cf1:     	movq	0x170(%rsp), %rax
180002cf9:     	movq	%rax, 0x88(%rsp)
180002d01:     	movq	0x180(%rsp), %rax
180002d09:     	movq	%rax, 0x78(%rsp)
180002d0e:     	movq	0x188(%rsp), %rax
180002d16:     	movq	%rax, 0x70(%rsp)
180002d1b:     	movq	0x190(%rsp), %rax
180002d23:     	movq	%rax, 0x68(%rsp)
180002d28:     	movq	0x198(%rsp), %rax
180002d30:     	movq	%rax, 0x58(%rsp)
180002d35:     	movq	0x178(%rsp), %rax
180002d3d:     	movq	%rax, 0x50(%rsp)
180002d42:     	movq	0x130(%rsp), %rax
180002d4a:     	movq	%rax, 0x40(%rsp)
180002d4f:     	movq	0x138(%rsp), %rax
180002d57:     	movq	%rax, 0x38(%rsp)
180002d5c:     	movq	%r15, 0xb8(%rsp)
180002d64:     	movq	0x100(%rsp), %r14
180002d6c:     	movq	%r14, 0x80(%rsp)
180002d74:     	movq	0x108(%rsp), %rdi
180002d7c:     	movq	%rdi, 0x48(%rsp)
180002d81:     	movq	0x140(%rsp), %rax
180002d89:     	movq	%rax, 0x30(%rsp)
180002d8e:     	movq	0x148(%rsp), %rax
180002d96:     	movq	%rax, 0x20(%rsp)
180002d9b:     	movq	$0x1, 0xd0(%rsp)
180002da7:     	movq	$0x8, 0x98(%rsp)
180002db3:     	movq	$0x8, 0x60(%rsp)
180002dbc:     	movq	$0x8, 0x28(%rsp)
180002dc5:     	leaq	0x2d0(%rsp), %rcx
180002dcd:     	leaq	0x118(%rsp), %rdx
180002dd5:     	movq	%rsi, %r9
180002dd8:     	movq	0x110(%rsp), %rsi
180002de0:     	movq	%rsi, %r8
180002de3:     	callq	0x180001090 <.text+0x90>
180002de8:     	movl	%eax, %ebp
180002dea:     	movq	0x118(%rsp), %rbx
180002df2:     	movq	%rsi, %rcx
180002df5:     	callq	0x180001060 <.text+0x60>
180002dfa:     	movq	%rdi, %rcx
180002dfd:     	callq	0x180001060 <.text+0x60>
180002e02:     	movq	%r14, %rcx
180002e05:     	callq	0x180001060 <.text+0x60>
180002e0a:     	movq	%r15, %rcx
180002e0d:     	callq	0x180001060 <.text+0x60>
180002e12:     	testl	%ebp, %ebp
180002e14:     	jne	0x180002e3c <.text+0x1e3c>
180002e16:     	movq	0x74c3(%rip), %rsi      # 0x18000a2e0
180002e1d:     	movq	%rsi, %rcx
180002e20:     	callq	0x1800088af <numba_list_iter_next+0x32f>
180002e25:     	movq	%rsi, %rax
180002e28:     	addq	$0x2d8, %rsp            # imm = 0x2D8
180002e2f:     	popq	%rbx
180002e30:     	popq	%rbp
180002e31:     	popq	%rdi
180002e32:     	popq	%rsi
180002e33:     	popq	%r12
180002e35:     	popq	%r13
180002e37:     	popq	%r14
180002e39:     	popq	%r15
180002e3b:     	retq
180002e3c:     	jle	0x180002f5f <.text+0x1f5f>
180002e42:     	callq	0x1800088b5 <numba_list_iter_next+0x335>
180002e47:     	movl	0x8(%rbx), %edx
180002e4a:     	movq	(%rbx), %rcx
180002e4d:     	cmpl	$0x0, 0x20(%rbx)
180002e51:     	jle	0x180002f7e <.text+0x1f7e>
180002e57:     	movslq	%edx, %rdx
180002e5a:     	callq	0x1800088bb <numba_list_iter_next+0x33b>
180002e5f:     	movq	%rax, %rsi
180002e62:     	movq	0x10(%rbx), %rcx
180002e66:     	callq	*0x18(%rbx)
180002e69:     	testq	%rax, %rax
180002e6c:     	je	0x180002fa7 <.text+0x1fa7>
180002e72:     	movq	%rsi, %rcx
180002e75:     	movq	%rax, %rdx
180002e78:     	callq	0x180006d60 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a90>
180002e7d:     	movq	%rax, %rsi
180002e80:     	movq	%rbx, %rcx
180002e83:     	callq	0x1800087f0 <numba_list_iter_next+0x270>
180002e88:     	jmp	0x180002f8a <.text+0x1f8a>
180002e8d:     	movq	0x742c(%rip), %rcx      # 0x18000a2c0
180002e94:     	leaq	0x7665(%rip), %rdx      # 0x18000a500
180002e9b:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002ea0:     	jmp	0x180002f58 <.text+0x1f58>
180002ea5:     	movq	0x7404(%rip), %rcx      # 0x18000a2b0
180002eac:     	leaq	0x773d(%rip), %rdx      # 0x18000a5f0
180002eb3:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002eb8:     	jmp	0x180002f58 <.text+0x1f58>
180002ebd:     	movq	0x73ec(%rip), %rcx      # 0x18000a2b0
180002ec4:     	leaq	0x7725(%rip), %rdx      # 0x18000a5f0
180002ecb:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002ed0:     	jmp	0x180002f50 <.text+0x1f50>
180002ed2:     	movq	0x73d7(%rip), %rcx      # 0x18000a2b0
180002ed9:     	leaq	0x7710(%rip), %rdx      # 0x18000a5f0
180002ee0:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002ee5:     	jmp	0x180002f48 <.text+0x1f48>
180002ee7:     	movq	0x73c2(%rip), %rcx      # 0x18000a2b0
180002eee:     	leaq	0x76fb(%rip), %rdx      # 0x18000a5f0
180002ef5:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002efa:     	jmp	0x180002f40 <.text+0x1f40>
180002efc:     	xorl	%r12d, %r12d
180002eff:     	callq	0x1800088a9 <numba_list_iter_next+0x329>
180002f04:     	testq	%rax, %rax
180002f07:     	je	0x180002c2c <.text+0x1c2c>
180002f0d:     	jmp	0x180002f20 <.text+0x1f20>
180002f0f:     	xorl	%r13d, %r13d
180002f12:     	callq	0x1800088a9 <numba_list_iter_next+0x329>
180002f17:     	testq	%rax, %rax
180002f1a:     	je	0x180002c69 <.text+0x1c69>
180002f20:     	movq	%r15, %rcx
180002f23:     	callq	0x180001060 <.text+0x60>
180002f28:     	movq	0x110(%rsp), %rsi
180002f30:     	movq	0x108(%rsp), %rdi
180002f38:     	movq	0x100(%rsp), %r13
180002f40:     	movq	%r13, %rcx
180002f43:     	callq	0x180001060 <.text+0x60>
180002f48:     	movq	%rdi, %rcx
180002f4b:     	callq	0x180001060 <.text+0x60>
180002f50:     	movq	%rsi, %rcx
180002f53:     	callq	0x180001060 <.text+0x60>
180002f58:     	xorl	%esi, %esi
180002f5a:     	jmp	0x180002e25 <.text+0x1e25>
180002f5f:     	cmpl	$-0x3, %ebp
180002f62:     	je	0x180002f99 <.text+0x1f99>
180002f64:     	cmpl	$-0x1, %ebp
180002f67:     	je	0x180002f58 <.text+0x1f58>
180002f69:     	movq	0x7338(%rip), %rcx      # 0x18000a2a8
180002f70:     	leaq	0x7719(%rip), %rdx      # 0x18000a690
180002f77:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002f7c:     	jmp	0x180002f58 <.text+0x1f58>
180002f7e:     	movq	0x10(%rbx), %r8
180002f82:     	callq	0x180006c80 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39b0>
180002f87:     	movq	%rax, %rsi
180002f8a:     	testq	%rsi, %rsi
180002f8d:     	je	0x180002f58 <.text+0x1f58>
180002f8f:     	movq	%rsi, %rcx
180002f92:     	callq	0x180006820 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3550>
180002f97:     	jmp	0x180002f58 <.text+0x1f58>
180002f99:     	movq	0x7300(%rip), %rcx      # 0x18000a2a0
180002fa0:     	callq	0x1800088c7 <numba_list_iter_next+0x347>
180002fa5:     	jmp	0x180002f58 <.text+0x1f58>
180002fa7:     	movq	0x7312(%rip), %rcx      # 0x18000a2c0
180002fae:     	leaq	0x769b(%rip), %rdx      # 0x18000a650
180002fb5:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180002fba:     	jmp	0x180002f58 <.text+0x1f58>
180002fbc:     	nopl	(%rax)
180002fc0:     	pushq	%r15
180002fc2:     	pushq	%r14
180002fc4:     	pushq	%r13
180002fc6:     	pushq	%r12
180002fc8:     	pushq	%rsi
180002fc9:     	pushq	%rdi
180002fca:     	pushq	%rbp
180002fcb:     	pushq	%rbx
180002fcc:     	subq	$0x128, %rsp            # imm = 0x128
180002fd3:     	movq	%r9, %r12
180002fd6:     	movq	%r8, %r15
180002fd9:     	movq	%rdx, 0x120(%rsp)
180002fe1:     	movq	%rcx, %rbp
180002fe4:     	movq	$0x0, 0x118(%rsp)
180002ff0:     	movq	$0x0, 0x110(%rsp)
180002ffc:     	movq	0x200(%rsp), %r13
180003004:     	movq	0x208(%rsp), %r14
18000300c:     	movq	0x210(%rsp), %rbx
180003014:     	movq	0x218(%rsp), %rdi
18000301c:     	movq	0x220(%rsp), %rsi
180003024:     	movq	0x228(%rsp), %r11
18000302c:     	movq	0x230(%rsp), %r10
180003034:     	movq	0x238(%rsp), %r9
18000303c:     	movq	0x240(%rsp), %r8
180003044:     	movq	0x248(%rsp), %rdx
18000304c:     	movq	0x250(%rsp), %rcx
180003054:     	movq	0x258(%rsp), %rax
18000305c:     	movq	%rax, 0xf8(%rsp)
180003064:     	movq	%rcx, 0xf0(%rsp)
18000306c:     	movq	%rdx, 0xe8(%rsp)
180003074:     	movq	%r8, 0xe0(%rsp)
18000307c:     	movq	%r9, 0xd8(%rsp)
180003084:     	movq	%r10, 0xd0(%rsp)
18000308c:     	movq	%r11, 0xc8(%rsp)
180003094:     	movq	%rsi, 0xc0(%rsp)
18000309c:     	movq	%rdi, 0xb8(%rsp)
1800030a4:     	movq	%rbx, 0xb0(%rsp)
1800030ac:     	movq	%r14, 0xa8(%rsp)
1800030b4:     	movq	%r13, 0xa0(%rsp)
1800030bc:     	movq	0x1f8(%rsp), %rax
1800030c4:     	movq	%rax, 0x98(%rsp)
1800030cc:     	movq	0x1f0(%rsp), %rax
1800030d4:     	movq	%rax, 0x90(%rsp)
1800030dc:     	movq	0x1e8(%rsp), %rax
1800030e4:     	movq	%rax, 0x88(%rsp)
1800030ec:     	movq	0x1e0(%rsp), %rax
1800030f4:     	movq	%rax, 0x80(%rsp)
1800030fc:     	movq	0x1d8(%rsp), %rax
180003104:     	movq	%rax, 0x78(%rsp)
180003109:     	movq	0x1d0(%rsp), %rax
180003111:     	movq	%rax, 0x70(%rsp)
180003116:     	movq	0x1c8(%rsp), %rax
18000311e:     	movq	%rax, 0x68(%rsp)
180003123:     	movq	0x1c0(%rsp), %rax
18000312b:     	movq	%rax, 0x60(%rsp)
180003130:     	movq	0x1b8(%rsp), %rax
180003138:     	movq	%rax, 0x58(%rsp)
18000313d:     	movq	0x1b0(%rsp), %rax
180003145:     	movq	%rax, 0x50(%rsp)
18000314a:     	movq	0x1a8(%rsp), %rax
180003152:     	movq	%rax, 0x48(%rsp)
180003157:     	movq	0x1a0(%rsp), %rax
18000315f:     	movq	%rax, 0x40(%rsp)
180003164:     	movq	0x198(%rsp), %rax
18000316c:     	movq	%rax, 0x38(%rsp)
180003171:     	movq	0x190(%rsp), %rax
180003179:     	movq	%rax, 0x30(%rsp)
18000317e:     	movq	%r12, 0x28(%rsp)
180003183:     	movq	%r15, 0x20(%rsp)
180003188:     	leaq	0x118(%rsp), %rcx
180003190:     	leaq	0x110(%rsp), %rdx
180003198:     	movq	%rbp, %r8
18000319b:     	movq	0x120(%rsp), %r9
1800031a3:     	callq	0x180001090 <.text+0x90>
1800031a8:     	movl	%eax, %edx
1800031aa:     	movq	0x110(%rsp), %rsi
1800031b2:     	movq	0x118(%rsp), %rax
1800031ba:     	movl	$0x0, 0x10c(%rsp)
1800031c5:     	testl	%edx, %edx
1800031c7:     	jne	0x1800031dd <.text+0x21dd>
1800031c9:     	addq	$0x128, %rsp            # imm = 0x128
1800031d0:     	popq	%rbx
1800031d1:     	popq	%rbp
1800031d2:     	popq	%rdi
1800031d3:     	popq	%rsi
1800031d4:     	popq	%r12
1800031d6:     	popq	%r13
1800031d8:     	popq	%r14
1800031da:     	popq	%r15
1800031dc:     	retq
1800031dd:     	movq	%rax, %rbx
1800031e0:     	leaq	0x10c(%rsp), %rcx
1800031e8:     	movl	%edx, %edi
1800031ea:     	callq	0x1800067f0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3520>
1800031ef:     	testl	%edi, %edi
1800031f1:     	jle	0x180003237 <.text+0x2237>
1800031f3:     	callq	0x1800088b5 <numba_list_iter_next+0x335>
1800031f8:     	movl	0x8(%rsi), %edx
1800031fb:     	movq	(%rsi), %rcx
1800031fe:     	cmpl	$0x0, 0x20(%rsi)
180003202:     	jle	0x180003258 <.text+0x2258>
180003204:     	movslq	%edx, %rdx
180003207:     	callq	0x1800088bb <numba_list_iter_next+0x33b>
18000320c:     	movq	%rax, %rdi
18000320f:     	movq	0x10(%rsi), %rcx
180003213:     	callq	*0x18(%rsi)
180003216:     	testq	%rax, %rax
180003219:     	je	0x1800032b3 <.text+0x22b3>
18000321f:     	movq	%rdi, %rcx
180003222:     	movq	%rax, %rdx
180003225:     	callq	0x180006d60 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a90>
18000322a:     	movq	%rax, %rdi
18000322d:     	movq	%rsi, %rcx
180003230:     	callq	0x1800087f0 <numba_list_iter_next+0x270>
180003235:     	jmp	0x180003264 <.text+0x2264>
180003237:     	movl	%edi, %eax
180003239:     	cmpl	$-0x3, %edi
18000323c:     	je	0x1800032a5 <.text+0x22a5>
18000323e:     	cmpl	$-0x1, %eax
180003241:     	je	0x180003271 <.text+0x2271>
180003243:     	movq	0x705e(%rip), %rcx      # 0x18000a2a8
18000324a:     	leaq	0x74af(%rip), %rdx      # 0x18000a700
180003251:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
180003256:     	jmp	0x180003271 <.text+0x2271>
180003258:     	movq	0x10(%rsi), %r8
18000325c:     	callq	0x180006c80 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39b0>
180003261:     	movq	%rax, %rdi
180003264:     	testq	%rdi, %rdi
180003267:     	je	0x180003271 <.text+0x2271>
180003269:     	movq	%rdi, %rcx
18000326c:     	callq	0x180006820 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3550>
180003271:     	leaq	0x74b8(%rip), %rcx      # 0x18000a730
180003278:     	callq	0x1800088cd <numba_list_iter_next+0x34d>
18000327d:     	movq	%rax, %rsi
180003280:     	movq	%rax, %rcx
180003283:     	callq	0x1800088d3 <numba_list_iter_next+0x353>
180003288:     	movq	%rsi, %rcx
18000328b:     	callq	0x1800088a3 <numba_list_iter_next+0x323>
180003290:     	leaq	0x10c(%rsp), %rcx
180003298:     	callq	0x180006810 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3540>
18000329d:     	movq	%rbx, %rax
1800032a0:     	jmp	0x1800031c9 <.text+0x21c9>
1800032a5:     	movq	0x6ff4(%rip), %rcx      # 0x18000a2a0
1800032ac:     	callq	0x1800088c7 <numba_list_iter_next+0x347>
1800032b1:     	jmp	0x180003271 <.text+0x2271>
1800032b3:     	movq	0x7006(%rip), %rcx      # 0x18000a2c0
1800032ba:     	leaq	0x73ff(%rip), %rdx      # 0x18000a6c0
1800032c1:     	callq	0x1800088c1 <numba_list_iter_next+0x341>
1800032c6:     	xorl	%eax, %eax
1800032c8:     	jmp	0x1800031c9 <.text+0x21c9>
1800032cd:     	nopl	(%rax)

00000001800032d0 <PyInit_rcaotr_ced2c43c3452451226d0f64a>:
1800032d0:     	pushq	%rsi
1800032d1:     	subq	$0x20, %rsp
1800032d5:     	leaq	0xdd64(%rip), %rcx      # 0x180011040
1800032dc:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800032e1:     	callq	0x1800088d9 <numba_list_iter_next+0x359>
1800032e6:     	testq	%rax, %rax
1800032e9:     	je	0x18000331b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b>
1800032eb:     	leaq	0xdd0e(%rip), %rdx      # 0x180011000
1800032f2:     	leaq	0x74a7(%rip), %r8       # 0x18000a7a0
1800032f9:     	leaq	0x74f0(%rip), %r9       # 0x18000a7f0
180003300:     	movq	%rax, %rcx
180003303:     	movq	%rax, %rsi
180003306:     	callq	0x1800077c0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x44f0>
18000330b:     	movl	%eax, %ecx
18000330d:     	xorl	%eax, %eax
18000330f:     	testl	%ecx, %ecx
180003311:     	cmoveq	%rsi, %rax
180003315:     	addq	$0x20, %rsp
180003319:     	popq	%rsi
18000331a:     	retq
18000331b:     	xorl	%eax, %eax
18000331d:     	addq	$0x20, %rsp
180003321:     	popq	%rsi
180003322:     	retq
180003323:     	nopw	%cs:(%rax,%rax)
18000332d:     	nopl	(%rax)
180003330:     	pushq	%r15
180003332:     	pushq	%r14
180003334:     	pushq	%r13
180003336:     	pushq	%r12
180003338:     	pushq	%rsi
180003339:     	pushq	%rdi
18000333a:     	pushq	%rbp
18000333b:     	pushq	%rbx
18000333c:     	subq	$0x308, %rsp            # imm = 0x308
180003343:     	movapd	%xmm15, 0x2f0(%rsp)
18000334d:     	movapd	%xmm14, 0x2e0(%rsp)
180003357:     	movapd	%xmm13, 0x2d0(%rsp)
180003361:     	movapd	%xmm12, 0x2c0(%rsp)
18000336b:     	movapd	%xmm11, 0x2b0(%rsp)
180003375:     	movapd	%xmm10, 0x2a0(%rsp)
18000337f:     	movapd	%xmm9, 0x290(%rsp)
180003389:     	movapd	%xmm8, 0x280(%rsp)
180003393:     	movapd	%xmm7, 0x270(%rsp)
18000339c:     	movapd	%xmm6, 0x260(%rsp)
1800033a5:     	movq	0x440(%rsp), %rax
1800033ad:     	movq	0x428(%rsp), %r13
1800033b5:     	movq	0x3f0(%rsp), %r14
1800033bd:     	movq	$0x0, 0x1f8(%rsp)
1800033c9:     	movb	$0x0, 0x200(%rsp)
1800033d1:     	movq	$0x0, 0x208(%rsp)
1800033dd:     	movb	$0x0, 0x210(%rsp)
1800033e5:     	movq	$0x0, 0x218(%rsp)
1800033f1:     	movb	$0x0, 0x220(%rsp)
1800033f9:     	movq	$0x0, 0x228(%rsp)
180003405:     	movb	$0x0, 0x230(%rsp)
18000340d:     	movq	$0x0, 0x238(%rsp)
180003419:     	movb	$0x0, 0x240(%rsp)
180003421:     	movq	$0x0, 0x248(%rsp)
18000342d:     	movb	$0x0, 0x250(%rsp)
180003435:     	movq	$0x0, 0x198(%rsp)
180003441:     	movb	$0x0, 0x1a0(%rsp)
180003449:     	movq	$0x0, 0x1a8(%rsp)
180003455:     	movb	$0x0, 0x1b0(%rsp)
18000345d:     	movq	$0x0, 0x1b8(%rsp)
180003469:     	movb	$0x0, 0x1c0(%rsp)
180003471:     	movq	$0x0, 0x1c8(%rsp)
18000347d:     	movb	$0x0, 0x1d0(%rsp)
180003485:     	movq	$0x0, 0x1d8(%rsp)
180003491:     	movb	$0x0, 0x1e0(%rsp)
180003499:     	movq	$0x0, 0x1e8(%rsp)
1800034a5:     	movb	$0x0, 0x1f0(%rsp)
1800034ad:     	cmpq	$0x1, %rax
1800034b1:     	movq	0x3c0(%rsp), %rbx
1800034b9:     	movq	0x3a0(%rsp), %r15
1800034c1:     	movq	0x398(%rsp), %r10
1800034c9:     	movq	0x390(%rsp), %r12
1800034d1:     	movq	0x388(%rsp), %rbp
1800034d9:     	movq	0x380(%rsp), %rsi
1800034e1:     	je	0x180003550 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x280>
1800034e3:     	testq	%rax, %rax
1800034e6:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800034ec:     	movq	0x448(%rsp), %rdi
1800034f4:     	movq	0x3b8(%rsp), %rax
1800034fc:     	movq	0x28(%rax,%rdi,8), %rdx
180003501:     	cmpq	$0x3, %rdx
180003505:     	jle	0x180003673 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a3>
18000350b:     	movb	$0x0, 0x58(%rcx)
18000350f:     	movq	$0x0, 0x50(%rcx)
180003517:     	movb	$0x0, 0x48(%rcx)
18000351b:     	movq	$0x0, 0x40(%rcx)
180003523:     	movb	$0x0, 0x38(%rcx)
180003527:     	movq	$0x0, 0x30(%rcx)
18000352f:     	movb	$0x1, 0x28(%rcx)
180003533:     	movq	$0x0, 0x20(%rcx)
18000353b:     	movb	$0x1, 0x18(%rcx)
18000353f:     	movq	$0x0, 0x10(%rcx)
180003547:     	movb	$0x1, 0x8(%rcx)
18000354b:     	jmp	0x180005d56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a86>
180003550:     	movq	0x458(%rsp), %rdx
180003558:     	movq	%rdx, %rax
18000355b:     	sarq	$0x3f, %rax
18000355f:     	andq	%rbx, %rax
180003562:     	movq	0x3b8(%rsp), %r11
18000356a:     	leaq	(%r11,%rdx,8), %rdi
18000356e:     	movq	(%rdi,%rax,8), %rax
180003572:     	cmpq	$0x1, %rax
180003576:     	je	0x1800036cf <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ff>
18000357c:     	testq	%rax, %rax
18000357f:     	jne	0x1800037aa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4da>
180003585:     	movq	%r10, %rbx
180003588:     	movq	%r12, %r10
18000358b:     	movq	%rdx, %r12
18000358e:     	movq	0x10(%rdi), %rdx
180003592:     	xorl	%eax, %eax
180003594:     	cmpq	$-0x2, %rdx
180003598:     	movl	$0x0, %r11d
18000359e:     	cmovlq	%rbp, %r11
1800035a2:     	cmpq	$-0x4, %rdx
1800035a6:     	cmovlq	%rbp, %rax
1800035aa:     	cmpb	$0x0, (%r13)
1800035af:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800035b5:     	movq	%r9, 0x170(%rsp)
1800035bd:     	movq	%rsi, %rdi
1800035c0:     	leaq	(%rsi,%rdx,8), %rsi
1800035c4:     	sarq	$0x3f, %rdx
1800035c8:     	andq	%rbp, %rdx
1800035cb:     	movsd	(%rsi,%rdx,8), %xmm8
1800035d1:     	movsd	0x10(%rsi,%r11,8), %xmm7
1800035d8:     	movsd	0x20(%rsi,%rax,8), %xmm6
1800035de:     	movq	%rdi, %rsi
1800035e1:     	movq	%r12, %rdx
1800035e4:     	movq	%r10, %r12
1800035e7:     	movq	%rbx, %r10
1800035ea:     	movq	0x478(%rsp), %r9
1800035f2:     	movq	0x460(%rsp), %rax
1800035fa:     	movsd	0x20(%rsi,%rdx,8), %xmm1
180003600:     	xorpd	%xmm0, %xmm0
180003604:     	ucomisd	%xmm0, %xmm1
180003608:     	setbe	%bl
18000360b:     	ja	0x18000380b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x53b>
180003611:     	shlq	$0x3, %rdx
180003615:     	xorpd	%xmm1, %xmm1
180003619:     	xorpd	%xmm2, %xmm2
18000361d:     	movq	0x3c0(%rsp), %rbp
180003625:     	movsd	0x18(%rsi,%rdx), %xmm4
18000362b:     	xorpd	%xmm3, %xmm3
18000362f:     	ucomisd	%xmm3, %xmm4
180003633:     	jbe	0x180005f47 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c77>
180003639:     	movq	%rax, %r12
18000363c:     	movq	%rdx, 0x170(%rsp)
180003644:     	movq	(%r14), %r10
180003647:     	cmpq	%rbp, %r10
18000364a:     	movq	%r10, %r11
18000364d:     	jle	0x18000365a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x38a>
18000364f:     	movb	$0x2, (%r13)
180003654:     	movq	(%r14), %r10
180003657:     	xorl	%r11d, %r11d
18000365a:     	movq	%r13, %r8
18000365d:     	leaq	0x3(%r10), %rax
180003661:     	cmpq	%rbp, %rax
180003664:     	jle	0x180004392 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x10c2>
18000366a:     	movb	$0x2, (%r8)
18000366e:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003673:     	leaq	0x1(%rdx), %rax
180003677:     	notq	%rdx
18000367a:     	testq	%rdx, %rax
18000367d:     	js	0x180005cf9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a29>
180003683:     	cmpb	$0x0, (%r13)
180003688:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000368e:     	movq	%r9, 0x170(%rsp)
180003696:     	movq	0x3b8(%rsp), %rdx
18000369e:     	movq	%rax, 0x28(%rdx,%rdi,8)
1800036a3:     	movq	(%r14), %rax
1800036a6:     	cmpq	%rbx, %rax
1800036a9:     	movq	%rax, %rdx
1800036ac:     	jle	0x1800036b8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3e8>
1800036ae:     	movb	$0x2, (%r13)
1800036b3:     	movq	(%r14), %rax
1800036b6:     	xorl	%edx, %edx
1800036b8:     	leaq	0x3(%rax), %r11
1800036bc:     	cmpq	%rbx, %r11
1800036bf:     	jle	0x18000399e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x6ce>
1800036c5:     	movb	$0x2, (%r13)
1800036ca:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800036cf:     	movq	%r9, 0x170(%rsp)
1800036d7:     	cmpb	$0x0, (%r13)
1800036dc:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800036e2:     	movq	0x3b8(%rsp), %rax
1800036ea:     	movq	0x8(%rax), %rax
1800036ee:     	movq	0x470(%rsp), %r9
1800036f6:     	movsd	(%rsi,%r9,8), %xmm0
1800036fc:     	subsd	(%rsi,%rax,8), %xmm0
180003701:     	movapd	0x6cc7(%rip), %xmm1     # 0x18000a3d0
180003709:     	andpd	%xmm0, %xmm1
18000370d:     	ucomisd	0x6ccb(%rip), %xmm1     # 0x18000a3e0
180003715:     	jae	0x1800037bc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4ec>
18000371b:     	movsd	0x10(%rsi,%r9,8), %xmm1
180003722:     	subsd	0x10(%rsi,%rax,8), %xmm1
180003728:     	movapd	0x6ca0(%rip), %xmm2     # 0x18000a3d0
180003730:     	andpd	%xmm1, %xmm2
180003734:     	ucomisd	0x6ca4(%rip), %xmm2     # 0x18000a3e0
18000373c:     	jae	0x1800037bc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4ec>
18000373e:     	movsd	0x20(%rsi,%r9,8), %xmm2
180003745:     	subsd	0x20(%rsi,%rax,8), %xmm2
18000374b:     	movapd	0x6c7d(%rip), %xmm3     # 0x18000a3d0
180003753:     	andpd	%xmm2, %xmm3
180003757:     	ucomisd	0x6c81(%rip), %xmm3     # 0x18000a3e0
18000375f:     	jae	0x1800037bc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4ec>
180003761:     	movq	%rdx, %r9
180003764:     	movq	(%r14), %rax
180003767:     	leaq	0x6(%rax), %r11
18000376b:     	movb	$0x2, %dl
18000376d:     	cmpq	0x3c0(%rsp), %r11
180003775:     	jg	0x180003802 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x532>
18000377b:     	movq	%r11, (%r14)
18000377e:     	cmpb	$0x0, (%r13)
180003783:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003789:     	movq	%r9, %rdx
18000378c:     	movsd	%xmm0, (%rsi,%rax,8)
180003791:     	movsd	%xmm1, 0x10(%rsi,%rax,8)
180003797:     	movsd	%xmm2, 0x20(%rsi,%rax,8)
18000379d:     	cmpb	$0x0, (%r13)
1800037a2:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800037a8:     	jmp	0x1800037db <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x50b>
1800037aa:     	movb	$0x1, (%r13)
1800037af:     	movq	$0x1406f42, 0x18(%r14)  # imm = 0x1406F42
1800037b7:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800037bc:     	movb	$0x1, (%r13)
1800037c1:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
1800037c9:     	cmpb	$0x0, (%r13)
1800037ce:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800037d4:     	movq	$-0x1, %rax
1800037db:     	movq	0x28(%rdi), %r9
1800037df:     	testq	%r9, %r9
1800037e2:     	je	0x180004f75 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1ca5>
1800037e8:     	movq	%rdx, %rbp
1800037eb:     	movq	(%r14), %r11
1800037ee:     	leaq	0x6(%r11), %r15
1800037f2:     	movb	$0x2, %dl
1800037f4:     	cmpq	0x3c0(%rsp), %r15
1800037fc:     	jle	0x180004f9f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1ccf>
180003802:     	movb	%dl, (%r13)
180003806:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000380b:     	movq	0x468(%rsp), %rax
180003813:     	movq	0x3b8(%rsp), %r11
18000381b:     	movq	0x8(%r11,%rax,8), %rdi
180003820:     	movsd	(%rsi,%rdi,8), %xmm1
180003825:     	mulsd	(%rsi,%r9,8), %xmm1
18000382b:     	movapd	0x6b9d(%rip), %xmm0     # 0x18000a3d0
180003833:     	andpd	%xmm1, %xmm0
180003837:     	ucomisd	0x6ba1(%rip), %xmm0     # 0x18000a3e0
18000383f:     	movq	0x3c0(%rsp), %rbp
180003847:     	jae	0x1800038ce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x5fe>
18000384d:     	movsd	0x10(%rsi,%rdi,8), %xmm0
180003853:     	mulsd	0x10(%rsi,%r9,8), %xmm0
18000385a:     	movapd	0x6b6e(%rip), %xmm2     # 0x18000a3d0
180003862:     	andpd	%xmm0, %xmm2
180003866:     	ucomisd	0x6b72(%rip), %xmm2     # 0x18000a3e0
18000386e:     	jae	0x1800038ce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x5fe>
180003870:     	addsd	%xmm0, %xmm1
180003874:     	movapd	0x6b54(%rip), %xmm0     # 0x18000a3d0
18000387c:     	andpd	%xmm1, %xmm0
180003880:     	ucomisd	0x6b58(%rip), %xmm0     # 0x18000a3e0
180003888:     	jae	0x1800038ce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x5fe>
18000388a:     	leaq	(,%r9,8), %rax
180003892:     	movsd	0x20(%rsi,%rdi,8), %xmm0
180003898:     	mulsd	0x20(%rsi,%rax), %xmm0
18000389e:     	movapd	0x6b2a(%rip), %xmm2     # 0x18000a3d0
1800038a6:     	andpd	%xmm0, %xmm2
1800038aa:     	ucomisd	0x6b2e(%rip), %xmm2     # 0x18000a3e0
1800038b2:     	jae	0x1800038ce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x5fe>
1800038b4:     	addsd	%xmm0, %xmm1
1800038b8:     	movapd	0x6b10(%rip), %xmm0     # 0x18000a3d0
1800038c0:     	andpd	%xmm1, %xmm0
1800038c4:     	ucomisd	0x6b14(%rip), %xmm0     # 0x18000a3e0
1800038cc:     	jb	0x1800038f2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x622>
1800038ce:     	movb	$0x1, (%r13)
1800038d3:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
1800038db:     	cmpb	$0x0, (%r13)
1800038e0:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800038e6:     	leaq	(,%r9,8), %rax
1800038ee:     	xorpd	%xmm1, %xmm1
1800038f2:     	movsd	(%rsi,%rax), %xmm0
1800038f7:     	mulsd	%xmm1, %xmm0
1800038fb:     	movapd	0x6acd(%rip), %xmm2     # 0x18000a3d0
180003903:     	andpd	%xmm0, %xmm2
180003907:     	ucomisd	0x6ad1(%rip), %xmm2     # 0x18000a3e0
18000390f:     	jae	0x1800042c3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xff3>
180003915:     	movsd	0x10(%rsi,%rax), %xmm2
18000391b:     	mulsd	%xmm1, %xmm2
18000391f:     	movapd	0x6aa9(%rip), %xmm3     # 0x18000a3d0
180003927:     	andpd	%xmm2, %xmm3
18000392b:     	ucomisd	0x6aad(%rip), %xmm3     # 0x18000a3e0
180003933:     	jae	0x1800042c3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xff3>
180003939:     	mulsd	0x20(%rsi,%rax), %xmm1
18000393f:     	movapd	0x6a89(%rip), %xmm3     # 0x18000a3d0
180003947:     	andpd	%xmm1, %xmm3
18000394b:     	ucomisd	0x6a8d(%rip), %xmm3     # 0x18000a3e0
180003953:     	jae	0x1800042c3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xff3>
180003959:     	movq	%rdx, %r9
18000395c:     	movq	(%r14), %rax
18000395f:     	leaq	0x6(%rax), %rdx
180003963:     	cmpq	%rbp, %rdx
180003966:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
18000396c:     	movq	%rdx, (%r14)
18000396f:     	cmpb	$0x0, (%r13)
180003974:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000397a:     	movq	%r9, %rdx
18000397d:     	movsd	%xmm0, (%rsi,%rax,8)
180003982:     	movsd	%xmm2, 0x10(%rsi,%rax,8)
180003988:     	movsd	%xmm1, 0x20(%rsi,%rax,8)
18000398e:     	cmpb	$0x0, (%r13)
180003993:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003999:     	jmp	0x1800042e7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1017>
18000399e:     	movq	%r11, (%r14)
1800039a1:     	cmpb	$0x0, (%r13)
1800039a6:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800039ac:     	movq	%rax, %r9
1800039af:     	sarq	$0x3f, %r9
1800039b3:     	andq	%rbx, %r9
1800039b6:     	movq	0x3b8(%rsp), %r11
1800039be:     	leaq	(%r11,%rax,8), %r11
1800039c2:     	movq	$0x0, (%r11,%r9,8)
1800039ca:     	xorl	%ebp, %ebp
1800039cc:     	cmpq	$-0x1, %rax
1800039d0:     	movl	$0x0, %r15d
1800039d6:     	cmovlq	%rbx, %r15
1800039da:     	movq	$0x0, 0x8(%r11,%r15,8)
1800039e3:     	cmpq	$-0x2, %rax
1800039e7:     	cmovlq	%rbx, %rbp
1800039eb:     	movq	%rdx, 0x10(%r11,%rbp,8)
1800039f0:     	cmpb	$0x0, (%r13)
1800039f5:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800039fb:     	movq	%r15, 0x178(%rsp)
180003a03:     	movq	%r11, 0x138(%rsp)
180003a0b:     	movq	0x3b8(%rsp), %rdx
180003a13:     	movq	0x18(%rdx,%rdi,8), %rax
180003a18:     	movq	%rax, %r11
180003a1b:     	sarq	$0x3f, %r11
180003a1f:     	andq	%rbx, %r11
180003a22:     	leaq	(%rdx,%rax,8), %rdi
180003a26:     	movq	%r11, 0x188(%rsp)
180003a2e:     	cmpq	$0x0, (%rdi,%r11,8)
180003a33:     	jle	0x1800051f6 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1f26>
180003a39:     	movq	%rbp, 0x140(%rsp)
180003a41:     	leaq	(,%rbx,8), %rbp
180003a49:     	xorl	%esi, %esi
180003a4b:     	cmpq	$-0x2, %rax
180003a4f:     	movl	$0x0, %eax
180003a54:     	cmovlq	%rbp, %rax
180003a58:     	movq	%rax, 0x190(%rsp)
180003a60:     	shlq	$0x3, %r9
180003a64:     	movapd	0x6964(%rip), %xmm0     # 0x18000a3d0
180003a6c:     	movsd	0x696c(%rip), %xmm1     # 0x18000a3e0
180003a74:     	movsd	0x6994(%rip), %xmm2     # 0x18000a410
180003a7c:     	movq	%r9, 0x168(%rsp)
180003a84:     	movq	%rdi, 0x180(%rsp)
180003a8c:     	movq	0x190(%rsp), %rax
180003a94:     	movq	0x10(%rdi,%rax), %rax
180003a99:     	movq	%rsi, 0x148(%rsp)
180003aa1:     	addq	%rsi, %rax
180003aa4:     	movq	0x3b8(%rsp), %rsi
180003aac:     	leaq	(%rsi,%rax,8), %rdx
180003ab0:     	sarq	$0x3f, %rax
180003ab4:     	andq	%rbx, %rax
180003ab7:     	movq	(%rdx,%rax,8), %rax
180003abb:     	movq	%rax, %rdx
180003abe:     	sarq	$0x3f, %rdx
180003ac2:     	andq	%rbx, %rdx
180003ac5:     	leaq	(%rsi,%rax,8), %r11
180003ac9:     	movq	(%r11,%rdx,8), %rdx
180003acd:     	cmpq	$-0x1, %rax
180003ad1:     	movl	$0x0, %eax
180003ad6:     	cmovlq	%rbx, %rax
180003ada:     	movq	0x8(%r11,%rax,8), %r15
180003adf:     	movq	%rdx, %rax
180003ae2:     	sarq	$0x3f, %rax
180003ae6:     	andq	%rbx, %rax
180003ae9:     	movq	%rdx, 0x150(%rsp)
180003af1:     	leaq	(%rsi,%rdx,8), %rdx
180003af5:     	movq	(%rdx,%rax,8), %rax
180003af9:     	cmpq	$0x1, %rax
180003afd:     	je	0x180003bd8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x908>
180003b03:     	testq	%rax, %rax
180003b06:     	movq	0x380(%rsp), %rsi
180003b0e:     	jne	0x180005dcb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2afb>
180003b14:     	cmpb	$0x0, (%r13)
180003b19:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003b1f:     	movq	0x450(%rsp), %rax
180003b27:     	movq	0x3b8(%rsp), %r11
180003b2f:     	movq	(%r11,%rax,8), %rax
180003b33:     	movq	0x8(%rdx), %rdx
180003b37:     	movsd	(%rsi,%rdx,8), %xmm3
180003b3c:     	subsd	(%rsi,%rax,8), %xmm3
180003b41:     	movapd	%xmm3, %xmm4
180003b45:     	andpd	%xmm0, %xmm4
180003b49:     	ucomisd	%xmm1, %xmm4
180003b4d:     	jae	0x180003cc2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9f2>
180003b53:     	movsd	0x10(%rsi,%rdx,8), %xmm4
180003b59:     	subsd	0x10(%rsi,%rax,8), %xmm4
180003b5f:     	movapd	%xmm4, %xmm5
180003b63:     	andpd	%xmm0, %xmm5
180003b67:     	ucomisd	%xmm1, %xmm5
180003b6b:     	jae	0x180003cc2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9f2>
180003b71:     	movsd	0x20(%rsi,%rdx,8), %xmm5
180003b77:     	subsd	0x20(%rsi,%rax,8), %xmm5
180003b7d:     	movapd	%xmm5, %xmm6
180003b81:     	andpd	%xmm0, %xmm6
180003b85:     	ucomisd	%xmm1, %xmm6
180003b89:     	jae	0x180003cc2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9f2>
180003b8f:     	movq	(%r14), %rdx
180003b92:     	leaq	0x6(%rdx), %rax
180003b96:     	cmpq	%rbx, %rax
180003b99:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
180003b9f:     	movq	%rax, (%r14)
180003ba2:     	cmpb	$0x0, (%r13)
180003ba7:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003bad:     	movsd	%xmm3, (%rsi,%rdx,8)
180003bb2:     	movsd	%xmm4, 0x10(%rsi,%rdx,8)
180003bb8:     	movsd	%xmm5, 0x20(%rsi,%rdx,8)
180003bbe:     	movzbl	(%r13), %r11d
180003bc3:     	movl	%r11d, %eax
180003bc6:     	negb	%al
180003bc8:     	movl	$0x0, %eax
180003bcd:     	sbbq	%rax, %rax
180003bd0:     	orq	%rdx, %rax
180003bd3:     	jmp	0x180003cdb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xa0b>
180003bd8:     	cmpb	$0x0, (%r13)
180003bdd:     	movq	0x380(%rsp), %rsi
180003be5:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003beb:     	movq	0x20(%rdx), %rax
180003bef:     	movq	0x450(%rsp), %rdx
180003bf7:     	movq	0x3b8(%rsp), %r11
180003bff:     	movq	0x8(%r11,%rdx,8), %rdx
180003c04:     	movsd	(%rsi,%rdx,8), %xmm4
180003c09:     	mulsd	(%rsi,%rax,8), %xmm4
180003c0e:     	movapd	%xmm4, %xmm3
180003c12:     	andpd	%xmm0, %xmm3
180003c16:     	ucomisd	%xmm1, %xmm3
180003c1a:     	jae	0x180003c74 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9a4>
180003c1c:     	movsd	0x10(%rsi,%rdx,8), %xmm3
180003c22:     	mulsd	0x10(%rsi,%rax,8), %xmm3
180003c28:     	movapd	%xmm3, %xmm5
180003c2c:     	andpd	%xmm0, %xmm5
180003c30:     	ucomisd	%xmm1, %xmm5
180003c34:     	jae	0x180003c74 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9a4>
180003c36:     	addsd	%xmm3, %xmm4
180003c3a:     	movapd	%xmm4, %xmm3
180003c3e:     	andpd	%xmm0, %xmm3
180003c42:     	ucomisd	%xmm1, %xmm3
180003c46:     	jae	0x180003c74 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9a4>
180003c48:     	movsd	0x20(%rsi,%rdx,8), %xmm3
180003c4e:     	mulsd	0x20(%rsi,%rax,8), %xmm3
180003c54:     	movapd	%xmm3, %xmm5
180003c58:     	andpd	%xmm0, %xmm5
180003c5c:     	ucomisd	%xmm1, %xmm5
180003c60:     	jae	0x180003c74 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9a4>
180003c62:     	addsd	%xmm3, %xmm4
180003c66:     	movapd	%xmm4, %xmm3
180003c6a:     	andpd	%xmm0, %xmm3
180003c6e:     	ucomisd	%xmm1, %xmm3
180003c72:     	jb	0x180003c90 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9c0>
180003c74:     	movb	$0x1, (%r13)
180003c79:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003c81:     	xorpd	%xmm4, %xmm4
180003c85:     	cmpb	$0x0, (%r13)
180003c8a:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003c90:     	xorpd	%xmm5, %xmm5
180003c94:     	ucomisd	%xmm5, %xmm4
180003c98:     	movapd	%xmm2, %xmm3
180003c9c:     	divsd	%xmm4, %xmm3
180003ca0:     	jne	0x180003ca8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9d8>
180003ca2:     	jp	0x180003ca8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x9d8>
180003ca4:     	xorpd	%xmm3, %xmm3
180003ca8:     	cmpneqsd	%xmm5, %xmm4
180003cad:     	movq	%xmm4, %rax
180003cb2:     	andl	$0x1, %eax
180003cb5:     	movq	%rax, 0x158(%rsp)
180003cbd:     	jmp	0x180003ee5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xc15>
180003cc2:     	movb	$0x1, (%r13)
180003cc7:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
180003ccf:     	movzbl	(%r13), %r11d
180003cd4:     	movq	$-0x1, %rax
180003cdb:     	xorpd	%xmm3, %xmm3
180003cdf:     	testb	%r11b, %r11b
180003ce2:     	je	0x180003d00 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xa30>
180003ce4:     	movq	$0x0, 0x158(%rsp)
180003cf0:     	cmpb	$0x0, (%r13)
180003cf5:     	je	0x180003ee5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xc15>
180003cfb:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003d00:     	movq	0x450(%rsp), %rdx
180003d08:     	movq	0x3b8(%rsp), %r11
180003d10:     	movq	0x8(%r11,%rdx,8), %rdx
180003d15:     	movsd	(%rsi,%rax,8), %xmm4
180003d1a:     	mulsd	(%rsi,%rdx,8), %xmm4
180003d1f:     	movapd	%xmm4, %xmm5
180003d23:     	andpd	%xmm0, %xmm5
180003d27:     	ucomisd	%xmm1, %xmm5
180003d2b:     	jae	0x180003d85 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xab5>
180003d2d:     	movsd	0x10(%rsi,%rax,8), %xmm5
180003d33:     	mulsd	0x10(%rsi,%rdx,8), %xmm5
180003d39:     	movapd	%xmm5, %xmm6
180003d3d:     	andpd	%xmm0, %xmm6
180003d41:     	ucomisd	%xmm1, %xmm6
180003d45:     	jae	0x180003d85 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xab5>
180003d47:     	addsd	%xmm5, %xmm4
180003d4b:     	movapd	%xmm4, %xmm5
180003d4f:     	andpd	%xmm0, %xmm5
180003d53:     	ucomisd	%xmm1, %xmm5
180003d57:     	jae	0x180003d85 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xab5>
180003d59:     	movsd	0x20(%rsi,%rax,8), %xmm5
180003d5f:     	mulsd	0x20(%rsi,%rdx,8), %xmm5
180003d65:     	movapd	%xmm5, %xmm6
180003d69:     	andpd	%xmm0, %xmm6
180003d6d:     	ucomisd	%xmm1, %xmm6
180003d71:     	jae	0x180003d85 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xab5>
180003d73:     	addsd	%xmm5, %xmm4
180003d77:     	movapd	%xmm4, %xmm5
180003d7b:     	andpd	%xmm0, %xmm5
180003d7f:     	ucomisd	%xmm1, %xmm5
180003d83:     	jb	0x180003da1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xad1>
180003d85:     	movb	$0x1, (%r13)
180003d8a:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003d92:     	xorpd	%xmm4, %xmm4
180003d96:     	cmpb	$0x0, (%r13)
180003d9b:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003da1:     	movq	0x150(%rsp), %rdx
180003da9:     	movsd	0x10(%rsi,%rdx,8), %xmm5
180003daf:     	mulsd	%xmm5, %xmm5
180003db3:     	movapd	%xmm5, %xmm6
180003db7:     	andpd	%xmm0, %xmm6
180003dbb:     	ucomisd	%xmm1, %xmm6
180003dbf:     	jae	0x180003ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xbf1>
180003dc5:     	movsd	(%rsi,%rax,8), %xmm6
180003dca:     	mulsd	%xmm6, %xmm6
180003dce:     	movapd	%xmm6, %xmm7
180003dd2:     	andpd	%xmm0, %xmm7
180003dd6:     	ucomisd	%xmm1, %xmm7
180003dda:     	jae	0x180003e36 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xb66>
180003ddc:     	movsd	0x10(%rsi,%rax,8), %xmm7
180003de2:     	mulsd	%xmm7, %xmm7
180003de6:     	movapd	%xmm7, %xmm8
180003deb:     	andpd	%xmm0, %xmm8
180003df0:     	ucomisd	%xmm1, %xmm8
180003df5:     	jae	0x180003e36 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xb66>
180003df7:     	addsd	%xmm7, %xmm6
180003dfb:     	movapd	%xmm6, %xmm7
180003dff:     	andpd	%xmm0, %xmm7
180003e03:     	ucomisd	%xmm1, %xmm7
180003e07:     	jae	0x180003e36 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xb66>
180003e09:     	movsd	0x20(%rsi,%rax,8), %xmm7
180003e0f:     	mulsd	%xmm7, %xmm7
180003e13:     	movapd	%xmm7, %xmm8
180003e18:     	andpd	%xmm0, %xmm8
180003e1d:     	ucomisd	%xmm1, %xmm8
180003e22:     	jae	0x180003e36 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xb66>
180003e24:     	addsd	%xmm7, %xmm6
180003e28:     	movapd	%xmm6, %xmm7
180003e2c:     	andpd	%xmm0, %xmm7
180003e30:     	ucomisd	%xmm1, %xmm7
180003e34:     	jb	0x180003e52 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xb82>
180003e36:     	movb	$0x1, (%r13)
180003e3b:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003e43:     	xorpd	%xmm6, %xmm6
180003e47:     	cmpb	$0x0, (%r13)
180003e4c:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003e52:     	movapd	%xmm4, %xmm7
180003e56:     	mulsd	%xmm4, %xmm7
180003e5a:     	movapd	%xmm7, %xmm8
180003e5f:     	andpd	%xmm0, %xmm8
180003e64:     	ucomisd	%xmm1, %xmm8
180003e69:     	jae	0x180003ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xbf1>
180003e6b:     	subsd	%xmm7, %xmm6
180003e6f:     	movapd	%xmm6, %xmm7
180003e73:     	andpd	%xmm0, %xmm7
180003e77:     	ucomisd	%xmm1, %xmm7
180003e7b:     	jae	0x180003ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xbf1>
180003e7d:     	subsd	%xmm6, %xmm5
180003e81:     	movapd	%xmm5, %xmm6
180003e85:     	andpd	%xmm0, %xmm6
180003e89:     	ucomisd	%xmm1, %xmm6
180003e8d:     	jae	0x180003ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xbf1>
180003e8f:     	ucomisd	%xmm5, %xmm3
180003e93:     	ja	0x180003ce4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xa14>
180003e99:     	xorps	%xmm3, %xmm3
180003e9c:     	sqrtsd	%xmm5, %xmm3
180003ea0:     	subsd	%xmm3, %xmm4
180003ea4:     	movl	$0x1, %eax
180003ea9:     	movq	%rax, 0x158(%rsp)
180003eb1:     	movapd	%xmm4, %xmm3
180003eb5:     	cmpb	$0x0, (%r13)
180003eba:     	je	0x180003ee5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xc15>
180003ebc:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003ec1:     	movb	$0x1, (%r13)
180003ec6:     	movq	$0xe4e1c4, 0x18(%r14)   # imm = 0xE4E1C4
180003ece:     	movq	$0x0, 0x158(%rsp)
180003eda:     	cmpb	$0x0, (%r13)
180003edf:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003ee5:     	movq	%r15, 0x160(%rsp)
180003eed:     	movq	0x138(%rsp), %rdi
180003ef5:     	movq	(%rdi,%r9), %r15
180003ef9:     	movq	0x178(%rsp), %rax
180003f01:     	cmpq	0x8(%rdi,%rax,8), %r15
180003f06:     	jne	0x180004174 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xea4>
180003f0c:     	leaq	(%r15,%r15), %r9
180003f10:     	testq	%r15, %r15
180003f13:     	movl	$0x4, %eax
180003f18:     	cmoveq	%rax, %r9
180003f1c:     	movq	0x3f0(%rsp), %rdx
180003f24:     	movq	(%rdx), %rdi
180003f27:     	leaq	(%rdi,%r9), %rax
180003f2b:     	cmpq	%rbx, %rax
180003f2e:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
180003f34:     	movq	%rax, (%rdx)
180003f37:     	cmpb	$0x0, (%r13)
180003f3c:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180003f42:     	testq	%r15, %r15
180003f45:     	jle	0x180004137 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xe67>
180003f4b:     	movq	0x138(%rsp), %rax
180003f53:     	movq	0x140(%rsp), %rdx
180003f5b:     	movq	0x10(%rax,%rdx,8), %r14
180003f60:     	movl	%r15d, %r13d
180003f63:     	andl	$0x7, %r13d
180003f67:     	cmpq	$0x8, %r15
180003f6b:     	jae	0x180003f74 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xca4>
180003f6d:     	xorl	%ebx, %ebx
180003f6f:     	jmp	0x1800040fb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xe2b>
180003f74:     	movq	%r12, %r10
180003f77:     	movq	%r15, %rbx
180003f7a:     	movabsq	$0x7ffffffffffffff8, %rax # imm = 0x7FFFFFFFFFFFFFF8
180003f84:     	andq	%rax, %rbx
180003f87:     	movq	0x3b8(%rsp), %rdx
180003f8f:     	leaq	(%rdx,%r14,8), %rax
180003f93:     	leaq	(%rdx,%rdi,8), %rdx
180003f97:     	xorl	%r11d, %r11d
180003f9a:     	leaq	(%r14,%r11), %rsi
180003f9e:     	sarq	$0x3f, %rsi
180003fa2:     	andq	%rbp, %rsi
180003fa5:     	addq	%rax, %rsi
180003fa8:     	movq	(%rsi,%r11,8), %rsi
180003fac:     	leaq	(%rdi,%r11), %r12
180003fb0:     	sarq	$0x3f, %r12
180003fb4:     	andq	%rbp, %r12
180003fb7:     	addq	%rdx, %r12
180003fba:     	movq	%rsi, (%r12,%r11,8)
180003fbe:     	leaq	0x1(%r14,%r11), %rsi
180003fc3:     	sarq	$0x3f, %rsi
180003fc7:     	andq	%rbp, %rsi
180003fca:     	addq	%rax, %rsi
180003fcd:     	movq	0x8(%rsi,%r11,8), %rsi
180003fd2:     	leaq	0x1(%rdi,%r11), %r12
180003fd7:     	sarq	$0x3f, %r12
180003fdb:     	andq	%rbp, %r12
180003fde:     	addq	%rdx, %r12
180003fe1:     	movq	%rsi, 0x8(%r12,%r11,8)
180003fe6:     	leaq	0x2(%r14,%r11), %rsi
180003feb:     	sarq	$0x3f, %rsi
180003fef:     	andq	%rbp, %rsi
180003ff2:     	addq	%rax, %rsi
180003ff5:     	movq	0x10(%rsi,%r11,8), %rsi
180003ffa:     	leaq	0x2(%rdi,%r11), %r12
180003fff:     	sarq	$0x3f, %r12
180004003:     	andq	%rbp, %r12
180004006:     	addq	%rdx, %r12
180004009:     	movq	%rsi, 0x10(%r12,%r11,8)
18000400e:     	leaq	0x3(%r14,%r11), %rsi
180004013:     	sarq	$0x3f, %rsi
180004017:     	andq	%rbp, %rsi
18000401a:     	addq	%rax, %rsi
18000401d:     	movq	0x18(%rsi,%r11,8), %rsi
180004022:     	leaq	0x3(%rdi,%r11), %r12
180004027:     	sarq	$0x3f, %r12
18000402b:     	andq	%rbp, %r12
18000402e:     	addq	%rdx, %r12
180004031:     	movq	%rsi, 0x18(%r12,%r11,8)
180004036:     	leaq	0x4(%r14,%r11), %rsi
18000403b:     	sarq	$0x3f, %rsi
18000403f:     	andq	%rbp, %rsi
180004042:     	addq	%rax, %rsi
180004045:     	movq	0x20(%rsi,%r11,8), %rsi
18000404a:     	leaq	0x4(%rdi,%r11), %r12
18000404f:     	sarq	$0x3f, %r12
180004053:     	andq	%rbp, %r12
180004056:     	addq	%rdx, %r12
180004059:     	movq	%rsi, 0x20(%r12,%r11,8)
18000405e:     	leaq	0x5(%r14,%r11), %rsi
180004063:     	sarq	$0x3f, %rsi
180004067:     	andq	%rbp, %rsi
18000406a:     	addq	%rax, %rsi
18000406d:     	movq	0x28(%rsi,%r11,8), %rsi
180004072:     	leaq	0x5(%rdi,%r11), %r12
180004077:     	sarq	$0x3f, %r12
18000407b:     	andq	%rbp, %r12
18000407e:     	addq	%rdx, %r12
180004081:     	movq	%rsi, 0x28(%r12,%r11,8)
180004086:     	leaq	0x6(%r14,%r11), %rsi
18000408b:     	sarq	$0x3f, %rsi
18000408f:     	andq	%rbp, %rsi
180004092:     	addq	%rax, %rsi
180004095:     	movq	0x30(%rsi,%r11,8), %rsi
18000409a:     	leaq	0x6(%rdi,%r11), %r12
18000409f:     	sarq	$0x3f, %r12
1800040a3:     	andq	%rbp, %r12
1800040a6:     	addq	%rdx, %r12
1800040a9:     	movq	%rsi, 0x30(%r12,%r11,8)
1800040ae:     	leaq	0x7(%r14,%r11), %rsi
1800040b3:     	sarq	$0x3f, %rsi
1800040b7:     	andq	%rbp, %rsi
1800040ba:     	addq	%rax, %rsi
1800040bd:     	movq	0x38(%rsi,%r11,8), %rsi
1800040c2:     	leaq	0x7(%rdi,%r11), %r12
1800040c7:     	sarq	$0x3f, %r12
1800040cb:     	andq	%rbp, %r12
1800040ce:     	addq	%rdx, %r12
1800040d1:     	movq	%rsi, 0x38(%r12,%r11,8)
1800040d6:     	addq	$0x8, %r11
1800040da:     	cmpq	%r11, %rbx
1800040dd:     	jne	0x180003f9a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xcca>
1800040e3:     	testq	%r13, %r13
1800040e6:     	movq	0x380(%rsp), %rsi
1800040ee:     	movq	%r10, %r12
1800040f1:     	movq	0x398(%rsp), %r10
1800040f9:     	je	0x180004137 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xe67>
1800040fb:     	leaq	(%rbx,%rdi), %rax
1800040ff:     	addq	%rbx, %r14
180004102:     	movq	%r14, %rdx
180004105:     	sarq	$0x3f, %rdx
180004109:     	andq	%rbp, %rdx
18000410c:     	movq	0x3b8(%rsp), %rbx
180004114:     	addq	%rbx, %rdx
180004117:     	movq	(%rdx,%r14,8), %rdx
18000411b:     	movq	%rax, %r11
18000411e:     	sarq	$0x3f, %r11
180004122:     	andq	%rbp, %r11
180004125:     	addq	%rbx, %r11
180004128:     	movq	%rdx, (%r11,%rax,8)
18000412c:     	incq	%rax
18000412f:     	incq	%r14
180004132:     	decq	%r13
180004135:     	jne	0x180004102 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xe32>
180004137:     	movq	0x138(%rsp), %rax
18000413f:     	movq	0x178(%rsp), %rdx
180004147:     	movq	%r9, 0x8(%rax,%rdx,8)
18000414c:     	movq	0x140(%rsp), %rdx
180004154:     	movq	%rdi, 0x10(%rax,%rdx,8)
180004159:     	movq	0x428(%rsp), %r13
180004161:     	movq	0x3c0(%rsp), %rbx
180004169:     	movq	%rax, %rdi
18000416c:     	movq	0x168(%rsp), %r9
180004174:     	leaq	0x1(%r15), %rax
180004178:     	movq	%rax, (%rdi,%r9)
18000417c:     	cmpb	$0x0, (%r13)
180004181:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004187:     	movq	0x3f0(%rsp), %r11
18000418f:     	movq	(%r11), %rax
180004192:     	leaq	0x4(%rax), %rdx
180004196:     	cmpq	%rbx, %rdx
180004199:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
18000419f:     	movq	0x140(%rsp), %r14
1800041a7:     	addq	0x10(%rdi,%r14,8), %r15
1800041ac:     	movq	%rdx, (%r11)
1800041af:     	cmpb	$0x0, (%r13)
1800041b4:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800041ba:     	movq	0x148(%rsp), %r9
1800041c2:     	incq	%r9
1800041c5:     	movq	%rax, %rdx
1800041c8:     	sarq	$0x3f, %rdx
1800041cc:     	andq	%rbx, %rdx
1800041cf:     	movq	0x3b8(%rsp), %rdi
1800041d7:     	leaq	(%rdi,%rax,8), %r11
1800041db:     	movq	0x150(%rsp), %r14
1800041e3:     	movq	%r14, (%r11,%rdx,8)
1800041e7:     	cmpq	$-0x1, %rax
1800041eb:     	movl	$0x0, %edx
1800041f0:     	cmovlq	0x388(%rsp), %rdx
1800041f9:     	leaq	(%rsi,%rax,8), %rsi
1800041fd:     	movsd	%xmm3, 0x8(%rsi,%rdx,8)
180004203:     	movq	%r9, %rsi
180004206:     	cmpq	$-0x2, %rax
18000420a:     	movl	$0x0, %edx
18000420f:     	cmovlq	%rbx, %rdx
180004213:     	movq	0x158(%rsp), %r9
18000421b:     	movq	%r9, 0x10(%r11,%rdx,8)
180004220:     	cmpq	$-0x3, %rax
180004224:     	movl	$0x0, %edx
180004229:     	cmovlq	%rbx, %rdx
18000422d:     	movq	0x160(%rsp), %r9
180004235:     	movq	%r9, 0x18(%r11,%rdx,8)
18000423a:     	leaq	(%rdi,%r15,8), %rdx
18000423e:     	sarq	$0x3f, %r15
180004242:     	andq	%rbx, %r15
180004245:     	movq	%rax, (%rdx,%r15,8)
180004249:     	movq	0x188(%rsp), %rax
180004251:     	movq	0x180(%rsp), %rdi
180004259:     	cmpq	(%rdi,%rax,8), %rsi
18000425d:     	movq	0x3f0(%rsp), %r14
180004265:     	movq	0x168(%rsp), %r9
18000426d:     	jl	0x180003a8c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x7bc>
180004273:     	movq	0x380(%rsp), %rsi
18000427b:     	movq	0x140(%rsp), %rbp
180004283:     	movq	0x138(%rsp), %rdx
18000428b:     	movq	(%rdx,%r9), %rax
18000428f:     	testq	%rax, %rax
180004292:     	jg	0x18000520f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1f3f>
180004298:     	xorpd	%xmm0, %xmm0
18000429c:     	movq	$-0x1, %r9
1800042a3:     	movq	$0x0, 0x138(%rsp)
1800042af:     	xorl	%r14d, %r14d
1800042b2:     	movq	$-0x1, 0x148(%rsp)
1800042be:     	jmp	0x180005c14 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2944>
1800042c3:     	movb	$0x1, (%r13)
1800042c8:     	movq	$0x1d905c2, 0x18(%r14)  # imm = 0x1D905C2
1800042d0:     	cmpb	$0x0, (%r13)
1800042d5:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800042db:     	movsd	-0x8(%rsi), %xmm0
1800042e0:     	movq	$-0x1, %rax
1800042e7:     	addsd	%xmm0, %xmm0
1800042eb:     	movapd	0x60dd(%rip), %xmm1     # 0x18000a3d0
1800042f3:     	andpd	%xmm0, %xmm1
1800042f7:     	ucomisd	0x60e1(%rip), %xmm1     # 0x18000a3e0
1800042ff:     	jae	0x18000511e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1e4e>
180004305:     	movsd	0x10(%rsi,%rax,8), %xmm1
18000430b:     	addsd	%xmm1, %xmm1
18000430f:     	movapd	0x60b9(%rip), %xmm2     # 0x18000a3d0
180004317:     	andpd	%xmm1, %xmm2
18000431b:     	ucomisd	0x60bd(%rip), %xmm2     # 0x18000a3e0
180004323:     	jae	0x18000511e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1e4e>
180004329:     	movsd	0x20(%rsi,%rax,8), %xmm2
18000432f:     	addsd	%xmm2, %xmm2
180004333:     	movapd	0x6095(%rip), %xmm3     # 0x18000a3d0
18000433b:     	andpd	%xmm2, %xmm3
18000433f:     	ucomisd	0x6099(%rip), %xmm3     # 0x18000a3e0
180004347:     	jae	0x18000511e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1e4e>
18000434d:     	movq	%rdx, %r9
180004350:     	movq	(%r14), %rax
180004353:     	leaq	0x6(%rax), %rdx
180004357:     	cmpq	%rbp, %rdx
18000435a:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
180004360:     	movq	%rdx, (%r14)
180004363:     	cmpb	$0x0, (%r13)
180004368:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000436e:     	movq	%r9, %rdx
180004371:     	movsd	%xmm0, (%rsi,%rax,8)
180004376:     	movsd	%xmm1, 0x10(%rsi,%rax,8)
18000437c:     	movsd	%xmm2, 0x20(%rsi,%rax,8)
180004382:     	cmpb	$0x0, (%r13)
180004387:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000438d:     	jmp	0x180005142 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1e72>
180004392:     	movq	%r14, %rdx
180004395:     	movq	%rax, (%r14)
180004398:     	cmpb	$0x0, (%r8)
18000439c:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800043a2:     	movq	%rbp, %r14
1800043a5:     	movq	%r8, %rsi
1800043a8:     	movq	%r10, %rax
1800043ab:     	sarq	$0x3f, %rax
1800043af:     	andq	%r14, %rax
1800043b2:     	movq	0x3b8(%rsp), %r9
1800043ba:     	leaq	(%r9,%r10,8), %r15
1800043be:     	movq	$0x0, (%r15,%rax,8)
1800043c6:     	xorl	%r13d, %r13d
1800043c9:     	cmpq	$-0x1, %r10
1800043cd:     	movl	$0x0, %r9d
1800043d3:     	cmovlq	%r14, %r9
1800043d7:     	movq	$0x0, 0x8(%r15,%r9,8)
1800043e0:     	cmpq	$-0x2, %r10
1800043e4:     	cmovlq	%r14, %r13
1800043e8:     	movq	%r15, 0x150(%rsp)
1800043f0:     	movq	%r13, 0x148(%rsp)
1800043f8:     	movq	%r11, 0x10(%r15,%r13,8)
1800043fd:     	cmpb	$0x0, (%r8)
180004401:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004407:     	movq	0x3b8(%rsp), %r11
18000440f:     	movq	0x8(%r11,%r12,8), %r10
180004414:     	movq	%r10, %rbx
180004417:     	sarq	$0x3f, %rbx
18000441b:     	andq	%r14, %rbx
18000441e:     	leaq	(%r11,%r10,8), %r11
180004422:     	cmpq	$0x0, (%r11,%rbx,8)
180004427:     	jle	0x18000580c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x253c>
18000442d:     	movq	%r14, %rdi
180004430:     	movq	%rbx, 0x190(%rsp)
180004438:     	leaq	(,%r14,8), %r15
180004440:     	xorl	%r13d, %r13d
180004443:     	cmpq	$-0x2, %r10
180004447:     	movl	$0x0, %r10d
18000444d:     	cmovlq	%r15, %r10
180004451:     	shlq	$0x3, %rax
180004455:     	movapd	0x5f73(%rip), %xmm4     # 0x18000a3d0
18000445d:     	movsd	0x5f7b(%rip), %xmm5     # 0x18000a3e0
180004465:     	xorpd	%xmm9, %xmm9
18000446a:     	movq	%r11, 0x188(%rsp)
180004472:     	movq	%r15, 0x168(%rsp)
18000447a:     	movq	%r10, 0x180(%rsp)
180004482:     	movq	0x10(%r11,%r10), %r10
180004487:     	addq	%r13, %r10
18000448a:     	movq	0x3b8(%rsp), %rbx
180004492:     	leaq	(%rbx,%r10,8), %r11
180004496:     	sarq	$0x3f, %r10
18000449a:     	andq	%rdi, %r10
18000449d:     	movq	(%r11,%r10,8), %r10
1800044a1:     	movq	%r10, 0x158(%rsp)
1800044a9:     	incq	%r13
1800044ac:     	movq	%r13, 0x178(%rsp)
1800044b4:     	movq	0x18(%rbx,%r12,8), %r10
1800044b9:     	leaq	(%rbx,%r10,8), %r11
1800044bd:     	movq	%r11, 0x138(%rsp)
1800044c5:     	movq	%r10, %r11
1800044c8:     	sarq	$0x3f, %r11
1800044cc:     	andq	%r15, %r11
1800044cf:     	movq	%r11, 0x140(%rsp)
1800044d7:     	cmpq	$-0x2, %r10
1800044db:     	movl	$0x0, %r10d
1800044e1:     	cmovlq	%r15, %r10
1800044e5:     	movq	%r10, 0x160(%rsp)
1800044ed:     	xorl	%r15d, %r15d
1800044f0:     	movq	0x138(%rsp), %r10
1800044f8:     	movq	0x140(%rsp), %r11
180004500:     	cmpq	(%r10,%r11), %r15
180004504:     	jge	0x180004c0e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x193e>
18000450a:     	cmpb	$0x0, (%rsi)
18000450d:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004513:     	movq	0x138(%rsp), %r10
18000451b:     	movq	0x160(%rsp), %r11
180004523:     	movq	0x10(%r10,%r11), %r10
180004528:     	addq	%r15, %r10
18000452b:     	movq	0x3b8(%rsp), %rbx
180004533:     	leaq	(%rbx,%r10,8), %r11
180004537:     	sarq	$0x3f, %r10
18000453b:     	andq	%r14, %r10
18000453e:     	movq	(%r11,%r10,8), %r10
180004542:     	leaq	(%rbx,%r10,8), %r11
180004546:     	sarq	$0x3f, %r10
18000454a:     	andq	%r14, %r10
18000454d:     	movq	(%r11,%r10,8), %rdi
180004551:     	movq	0x380(%rsp), %r10
180004559:     	movq	0x158(%rsp), %rbx
180004561:     	movsd	(%r10,%rbx,8), %xmm12
180004567:     	movq	0x470(%rsp), %r11
18000456f:     	subsd	(%r10,%r11,8), %xmm12
180004575:     	movapd	%xmm12, %xmm10
18000457a:     	andpd	%xmm4, %xmm10
18000457f:     	ucomisd	%xmm5, %xmm10
180004584:     	jae	0x180004619 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1349>
18000458a:     	movsd	0x10(%r10,%rbx,8), %xmm13
180004591:     	subsd	0x10(%r10,%r11,8), %xmm13
180004598:     	movapd	%xmm13, %xmm10
18000459d:     	andpd	%xmm4, %xmm10
1800045a2:     	ucomisd	%xmm5, %xmm10
1800045a7:     	jae	0x180004619 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1349>
1800045a9:     	movsd	0x20(%r10,%rbx,8), %xmm14
1800045b0:     	subsd	0x20(%r10,%r11,8), %xmm14
1800045b7:     	movapd	%xmm14, %xmm10
1800045bc:     	andpd	%xmm4, %xmm10
1800045c1:     	ucomisd	%xmm5, %xmm10
1800045c6:     	jae	0x180004619 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1349>
1800045c8:     	movq	(%rdx), %r11
1800045cb:     	leaq	0x6(%r11), %r10
1800045cf:     	cmpq	%r14, %r10
1800045d2:     	jg	0x18000366a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a>
1800045d8:     	movq	%r10, (%rdx)
1800045db:     	cmpb	$0x0, (%r8)
1800045df:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800045e5:     	movq	0x380(%rsp), %rsi
1800045ed:     	movsd	%xmm12, (%rsi,%r11,8)
1800045f3:     	movsd	%xmm13, 0x10(%rsi,%r11,8)
1800045fa:     	movsd	%xmm14, 0x20(%rsi,%r11,8)
180004601:     	movzbl	(%r8), %ebp
180004605:     	movl	%ebp, %r10d
180004608:     	negb	%r10b
18000460b:     	movl	$0x0, %r10d
180004611:     	sbbq	%r10, %r10
180004614:     	orq	%r11, %r10
180004617:     	jmp	0x18000462e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x135e>
180004619:     	movb	$0x1, (%rsi)
18000461c:     	movq	$0xf4243, 0x18(%rdx)    # imm = 0xF4243
180004624:     	movzbl	(%rsi), %ebp
180004627:     	movq	$-0x1, %r10
18000462e:     	testb	%bpl, %bpl
180004631:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004637:     	movq	(%rdx), %rbp
18000463a:     	leaq	0x2(%rbp), %r11
18000463e:     	cmpq	%r14, %r11
180004641:     	jg	0x18000366a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a>
180004647:     	movq	%r11, (%rdx)
18000464a:     	cmpb	$0x0, (%r8)
18000464e:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004654:     	movq	%r8, %r11
180004657:     	movq	0x470(%rsp), %rsi
18000465f:     	movq	0x3b8(%rsp), %rbx
180004667:     	movq	%rsi, (%rbx,%rbp,8)
18000466b:     	cmpb	$0x0, (%r8)
18000466f:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004675:     	movq	0x380(%rsp), %rsi
18000467d:     	movsd	(%rsi,%r10,8), %xmm12
180004683:     	mulsd	%xmm12, %xmm12
180004688:     	movapd	%xmm12, %xmm10
18000468d:     	andpd	%xmm4, %xmm10
180004692:     	ucomisd	%xmm5, %xmm10
180004697:     	jae	0x1800046ff <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x142f>
180004699:     	movsd	0x10(%rsi,%r10,8), %xmm13
1800046a0:     	mulsd	%xmm13, %xmm13
1800046a5:     	movapd	%xmm13, %xmm10
1800046aa:     	andpd	%xmm4, %xmm10
1800046af:     	ucomisd	%xmm5, %xmm10
1800046b4:     	jae	0x1800046ff <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x142f>
1800046b6:     	addsd	%xmm13, %xmm12
1800046bb:     	movapd	%xmm12, %xmm10
1800046c0:     	andpd	%xmm4, %xmm10
1800046c5:     	ucomisd	%xmm5, %xmm10
1800046ca:     	jae	0x1800046ff <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x142f>
1800046cc:     	movsd	0x20(%rsi,%r10,8), %xmm13
1800046d3:     	mulsd	%xmm13, %xmm13
1800046d8:     	movapd	%xmm13, %xmm10
1800046dd:     	andpd	%xmm4, %xmm10
1800046e2:     	ucomisd	%xmm5, %xmm10
1800046e7:     	jae	0x1800046ff <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x142f>
1800046e9:     	addsd	%xmm13, %xmm12
1800046ee:     	movapd	%xmm12, %xmm10
1800046f3:     	andpd	%xmm4, %xmm10
1800046f8:     	ucomisd	%xmm5, %xmm10
1800046fd:     	jb	0x18000471a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x144a>
1800046ff:     	movb	$0x1, (%r11)
180004703:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
18000470b:     	xorpd	%xmm12, %xmm12
180004710:     	cmpb	$0x0, (%r11)
180004714:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000471a:     	sqrtsd	%xmm12, %xmm12
18000471f:     	ucomisd	%xmm9, %xmm12
180004724:     	jne	0x180004741 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1471>
180004726:     	jp	0x180004741 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1471>
180004728:     	movb	$0x1, (%r11)
18000472c:     	movq	$0x3d0902, 0x18(%rdx)   # imm = 0x3D0902
180004734:     	movzbl	(%r11), %r13d
180004738:     	movq	$-0x1, %r10
18000473f:     	jmp	0x1800047b9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x14e9>
180004741:     	movq	(%rdx), %r11
180004744:     	leaq	0x6(%r11), %r13
180004748:     	cmpq	%r14, %r13
18000474b:     	jg	0x18000366a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a>
180004751:     	movsd	(%rsi,%r10,8), %xmm13
180004757:     	movsd	0x10(%rsi,%r10,8), %xmm14
18000475e:     	movsd	0x20(%rsi,%r10,8), %xmm15
180004765:     	movq	%r13, (%rdx)
180004768:     	cmpb	$0x0, (%r8)
18000476c:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004772:     	movsd	0x5c6d(%rip), %xmm10    # 0x18000a3e8
18000477b:     	divsd	%xmm12, %xmm10
180004780:     	mulsd	%xmm10, %xmm13
180004785:     	mulsd	%xmm10, %xmm14
18000478a:     	mulsd	%xmm15, %xmm10
18000478f:     	movsd	%xmm13, (%rsi,%r11,8)
180004795:     	movsd	%xmm14, 0x10(%rsi,%r11,8)
18000479c:     	movsd	%xmm10, 0x20(%rsi,%r11,8)
1800047a3:     	movzbl	(%r8), %r13d
1800047a7:     	movl	%r13d, %r10d
1800047aa:     	negb	%r10b
1800047ad:     	movl	$0x0, %r10d
1800047b3:     	sbbq	%r10, %r10
1800047b6:     	orq	%r11, %r10
1800047b9:     	testb	%r13b, %r13b
1800047bc:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800047c2:     	movq	0x3b8(%rsp), %rsi
1800047ca:     	movq	%r10, 0x8(%rsi,%rbp,8)
1800047cf:     	cmpb	$0x0, (%r8)
1800047d3:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800047d9:     	movq	%rdi, %rsi
1800047dc:     	sarq	$0x3f, %rsi
1800047e0:     	andq	%r14, %rsi
1800047e3:     	movq	0x3b8(%rsp), %r11
1800047eb:     	leaq	(%r11,%rdi,8), %r11
1800047ef:     	movq	(%r11,%rsi,8), %r13
1800047f3:     	cmpq	$0x1, %r13
1800047f7:     	je	0x1800048de <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x160e>
1800047fd:     	testq	%r13, %r13
180004800:     	movq	0x380(%rsp), %r13
180004808:     	jne	0x180004cc6 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x19f6>
18000480e:     	movq	0x8(%r11), %r11
180004812:     	movq	0x3b8(%rsp), %r10
18000481a:     	movq	(%r10,%rbp,8), %r10
18000481e:     	movsd	(%r13,%r11,8), %xmm12
180004825:     	subsd	(%r13,%r10,8), %xmm12
18000482c:     	movapd	%xmm12, %xmm10
180004831:     	andpd	%xmm4, %xmm10
180004836:     	ucomisd	%xmm5, %xmm10
18000483b:     	movq	%r8, %rsi
18000483e:     	jae	0x1800049c2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16f2>
180004844:     	movsd	0x10(%r13,%r11,8), %xmm13
18000484b:     	subsd	0x10(%r13,%r10,8), %xmm13
180004852:     	movapd	%xmm13, %xmm10
180004857:     	andpd	%xmm4, %xmm10
18000485c:     	ucomisd	%xmm5, %xmm10
180004861:     	jae	0x1800049c2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16f2>
180004867:     	movsd	0x20(%r13,%r11,8), %xmm14
18000486e:     	subsd	0x20(%r13,%r10,8), %xmm14
180004875:     	movapd	%xmm14, %xmm10
18000487a:     	andpd	%xmm4, %xmm10
18000487f:     	ucomisd	%xmm5, %xmm10
180004884:     	jae	0x1800049c2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16f2>
18000488a:     	movq	(%rdx), %r11
18000488d:     	leaq	0x6(%r11), %r10
180004891:     	cmpq	%r14, %r10
180004894:     	jg	0x18000366a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a>
18000489a:     	movq	%r10, (%rdx)
18000489d:     	cmpb	$0x0, (%r8)
1800048a1:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800048a7:     	movq	0x380(%rsp), %rsi
1800048af:     	movsd	%xmm12, (%rsi,%r11,8)
1800048b5:     	movsd	%xmm13, 0x10(%rsi,%r11,8)
1800048bc:     	movsd	%xmm14, 0x20(%rsi,%r11,8)
1800048c3:     	movzbl	(%r8), %r13d
1800048c7:     	movl	%r13d, %r10d
1800048ca:     	negb	%r10b
1800048cd:     	movl	$0x0, %r10d
1800048d3:     	sbbq	%r10, %r10
1800048d6:     	orq	%r11, %r10
1800048d9:     	jmp	0x1800049d8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1708>
1800048de:     	movq	0x20(%r11), %rdi
1800048e2:     	movq	0x380(%rsp), %r11
1800048ea:     	movsd	(%r11,%r10,8), %xmm12
1800048f0:     	mulsd	(%r11,%rdi,8), %xmm12
1800048f6:     	movapd	%xmm12, %xmm10
1800048fb:     	andpd	%xmm4, %xmm10
180004900:     	ucomisd	%xmm5, %xmm10
180004905:     	movq	%r8, %rsi
180004908:     	jae	0x180004974 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16a4>
18000490a:     	movsd	0x10(%r11,%r10,8), %xmm10
180004911:     	mulsd	0x10(%r11,%rdi,8), %xmm10
180004918:     	movapd	%xmm10, %xmm11
18000491d:     	andpd	%xmm4, %xmm11
180004922:     	ucomisd	%xmm5, %xmm11
180004927:     	jae	0x180004974 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16a4>
180004929:     	addsd	%xmm10, %xmm12
18000492e:     	movapd	%xmm12, %xmm10
180004933:     	andpd	%xmm4, %xmm10
180004938:     	ucomisd	%xmm5, %xmm10
18000493d:     	jae	0x180004974 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16a4>
18000493f:     	movsd	0x20(%r11,%r10,8), %xmm10
180004946:     	mulsd	0x20(%r11,%rdi,8), %xmm10
18000494d:     	movapd	%xmm10, %xmm11
180004952:     	andpd	%xmm4, %xmm11
180004957:     	ucomisd	%xmm5, %xmm11
18000495c:     	jae	0x180004974 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16a4>
18000495e:     	addsd	%xmm10, %xmm12
180004963:     	movapd	%xmm12, %xmm10
180004968:     	andpd	%xmm4, %xmm10
18000496d:     	ucomisd	%xmm5, %xmm10
180004972:     	jb	0x18000498d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16bd>
180004974:     	movb	$0x1, (%rsi)
180004977:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
18000497f:     	xorpd	%xmm12, %xmm12
180004984:     	cmpb	$0x0, (%rsi)
180004987:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000498d:     	xorpd	%xmm14, %xmm14
180004992:     	ucomisd	%xmm14, %xmm12
180004997:     	movsd	0x5a70(%rip), %xmm13    # 0x18000a410
1800049a0:     	divsd	%xmm12, %xmm13
1800049a5:     	jne	0x1800049ae <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16de>
1800049a7:     	jp	0x1800049ae <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x16de>
1800049a9:     	xorpd	%xmm13, %xmm13
1800049ae:     	cmpneqsd	%xmm14, %xmm12
1800049b4:     	movq	%xmm12, %r10
1800049b9:     	andl	$0x1, %r10d
1800049bd:     	jmp	0x180004be5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1915>
1800049c2:     	movb	$0x1, (%rsi)
1800049c5:     	movq	$0xf4243, 0x18(%rdx)    # imm = 0xF4243
1800049cd:     	movzbl	(%rsi), %r13d
1800049d1:     	movq	$-0x1, %r10
1800049d8:     	xorpd	%xmm13, %xmm13
1800049dd:     	testb	%r13b, %r13b
1800049e0:     	je	0x1800049ed <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x171d>
1800049e2:     	xorl	%r10d, %r10d
1800049e5:     	movq	%r8, %rsi
1800049e8:     	jmp	0x180004bdc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x190c>
1800049ed:     	movq	0x3b8(%rsp), %r11
1800049f5:     	movq	0x8(%r11,%rbp,8), %rbp
1800049fa:     	movq	0x380(%rsp), %r11
180004a02:     	movsd	(%r11,%r10,8), %xmm14
180004a08:     	mulsd	(%r11,%rbp,8), %xmm14
180004a0e:     	movapd	%xmm14, %xmm10
180004a13:     	andpd	%xmm4, %xmm10
180004a18:     	ucomisd	%xmm5, %xmm10
180004a1d:     	movq	%r8, %rsi
180004a20:     	jae	0x180004a8c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x17bc>
180004a22:     	movsd	0x10(%r11,%r10,8), %xmm12
180004a29:     	mulsd	0x10(%r11,%rbp,8), %xmm12
180004a30:     	movapd	%xmm12, %xmm10
180004a35:     	andpd	%xmm4, %xmm10
180004a3a:     	ucomisd	%xmm5, %xmm10
180004a3f:     	jae	0x180004a8c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x17bc>
180004a41:     	addsd	%xmm12, %xmm14
180004a46:     	movapd	%xmm14, %xmm10
180004a4b:     	andpd	%xmm4, %xmm10
180004a50:     	ucomisd	%xmm5, %xmm10
180004a55:     	jae	0x180004a8c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x17bc>
180004a57:     	movsd	0x20(%r11,%r10,8), %xmm12
180004a5e:     	mulsd	0x20(%r11,%rbp,8), %xmm12
180004a65:     	movapd	%xmm12, %xmm10
180004a6a:     	andpd	%xmm4, %xmm10
180004a6f:     	ucomisd	%xmm5, %xmm10
180004a74:     	jae	0x180004a8c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x17bc>
180004a76:     	addsd	%xmm12, %xmm14
180004a7b:     	movapd	%xmm14, %xmm10
180004a80:     	andpd	%xmm4, %xmm10
180004a85:     	ucomisd	%xmm5, %xmm10
180004a8a:     	jb	0x180004aa5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x17d5>
180004a8c:     	movb	$0x1, (%rsi)
180004a8f:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
180004a97:     	xorpd	%xmm14, %xmm14
180004a9c:     	cmpb	$0x0, (%rsi)
180004a9f:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004aa5:     	movsd	0x10(%r11,%rdi,8), %xmm15
180004aac:     	mulsd	%xmm15, %xmm15
180004ab1:     	movapd	%xmm15, %xmm10
180004ab6:     	andpd	%xmm4, %xmm10
180004abb:     	ucomisd	%xmm5, %xmm10
180004ac0:     	jae	0x180004bce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x18fe>
180004ac6:     	movsd	(%r11,%r10,8), %xmm12
180004acc:     	mulsd	%xmm12, %xmm12
180004ad1:     	movapd	%xmm12, %xmm10
180004ad6:     	andpd	%xmm4, %xmm10
180004adb:     	ucomisd	%xmm5, %xmm10
180004ae0:     	jae	0x180004b48 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1878>
180004ae2:     	movsd	0x10(%r11,%r10,8), %xmm11
180004ae9:     	mulsd	%xmm11, %xmm11
180004aee:     	movapd	%xmm11, %xmm10
180004af3:     	andpd	%xmm4, %xmm10
180004af8:     	ucomisd	%xmm5, %xmm10
180004afd:     	jae	0x180004b48 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1878>
180004aff:     	addsd	%xmm11, %xmm12
180004b04:     	movapd	%xmm12, %xmm10
180004b09:     	andpd	%xmm4, %xmm10
180004b0e:     	ucomisd	%xmm5, %xmm10
180004b13:     	jae	0x180004b48 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1878>
180004b15:     	movsd	0x20(%r11,%r10,8), %xmm10
180004b1c:     	mulsd	%xmm10, %xmm10
180004b21:     	movapd	%xmm10, %xmm11
180004b26:     	andpd	%xmm4, %xmm11
180004b2b:     	ucomisd	%xmm5, %xmm11
180004b30:     	jae	0x180004b48 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1878>
180004b32:     	addsd	%xmm10, %xmm12
180004b37:     	movapd	%xmm12, %xmm10
180004b3c:     	andpd	%xmm4, %xmm10
180004b41:     	ucomisd	%xmm5, %xmm10
180004b46:     	jb	0x180004b61 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1891>
180004b48:     	movb	$0x1, (%rsi)
180004b4b:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
180004b53:     	xorpd	%xmm12, %xmm12
180004b58:     	cmpb	$0x0, (%rsi)
180004b5b:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004b61:     	movapd	%xmm14, %xmm10
180004b66:     	mulsd	%xmm14, %xmm10
180004b6b:     	movapd	%xmm10, %xmm11
180004b70:     	andpd	%xmm4, %xmm11
180004b75:     	ucomisd	%xmm5, %xmm11
180004b7a:     	jae	0x180004bce <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x18fe>
180004b7c:     	subsd	%xmm10, %xmm12
180004b81:     	movapd	%xmm12, %xmm10
180004b86:     	andpd	%xmm4, %xmm10
180004b8b:     	ucomisd	%xmm5, %xmm10
180004b90:     	jae	0x180004c05 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1935>
180004b92:     	subsd	%xmm12, %xmm15
180004b97:     	movapd	%xmm15, %xmm10
180004b9c:     	andpd	%xmm4, %xmm10
180004ba1:     	ucomisd	%xmm5, %xmm10
180004ba6:     	jae	0x180004c05 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1935>
180004ba8:     	ucomisd	%xmm15, %xmm13
180004bad:     	ja	0x1800049e2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1712>
180004bb3:     	xorps	%xmm10, %xmm10
180004bb7:     	sqrtsd	%xmm15, %xmm10
180004bbc:     	subsd	%xmm10, %xmm14
180004bc1:     	movb	$0x1, %r10b
180004bc4:     	movapd	%xmm14, %xmm13
180004bc9:     	jmp	0x1800049e5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1715>
180004bce:     	movb	$0x1, (%rsi)
180004bd1:     	movq	$0xe4e1c4, 0x18(%rdx)   # imm = 0xE4E1C4
180004bd9:     	xorl	%r10d, %r10d
180004bdc:     	cmpb	$0x0, (%rsi)
180004bdf:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004be5:     	incq	%r15
180004be8:     	testb	%r10b, %r10b
180004beb:     	je	0x1800044f0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1220>
180004bf1:     	ucomisd	0x581e(%rip), %xmm13    # 0x18000a418
180004bfa:     	jbe	0x1800044f0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1220>
180004c00:     	jmp	0x180004f32 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1c62>
180004c05:     	movq	%r8, %rsi
180004c08:     	movb	$0x1, (%r8)
180004c0c:     	jmp	0x180004bd1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1901>
180004c0e:     	cmpb	$0x0, (%rsi)
180004c11:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004c17:     	movq	0x150(%rsp), %r10
180004c1f:     	movq	(%r10,%rax), %rdi
180004c23:     	cmpq	0x8(%r10,%r9,8), %rdi
180004c28:     	jne	0x180004ede <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1c0e>
180004c2e:     	leaq	(%rdi,%rdi), %rsi
180004c32:     	movq	%rdi, 0x160(%rsp)
180004c3a:     	testq	%rdi, %rdi
180004c3d:     	movl	$0x4, %r10d
180004c43:     	cmoveq	%r10, %rsi
180004c47:     	movq	(%rdx), %r11
180004c4a:     	movq	%rsi, 0x258(%rsp)
180004c52:     	leaq	(%r11,%rsi), %r10
180004c56:     	cmpq	%r14, %r10
180004c59:     	jg	0x18000366a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a>
180004c5f:     	movq	%r10, (%rdx)
180004c62:     	cmpb	$0x0, (%r8)
180004c66:     	movq	0x160(%rsp), %r10
180004c6e:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004c74:     	movq	%rcx, 0x140(%rsp)
180004c7c:     	testq	%r10, %r10
180004c7f:     	jle	0x180004eac <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1bdc>
180004c85:     	movq	0x3b8(%rsp), %rsi
180004c8d:     	movq	0x150(%rsp), %rcx
180004c95:     	movq	0x148(%rsp), %r10
180004c9d:     	movq	0x10(%rcx,%r10,8), %r15
180004ca2:     	movq	0x160(%rsp), %rcx
180004caa:     	movl	%ecx, %r13d
180004cad:     	andl	$0x7, %r13d
180004cb1:     	cmpq	$0x8, %rcx
180004cb5:     	jae	0x180004ce4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1a14>
180004cb7:     	xorl	%ecx, %ecx
180004cb9:     	movq	0x168(%rsp), %rbx
180004cc1:     	jmp	0x180004e6e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1b9e>
180004cc6:     	movq	%r8, %rsi
180004cc9:     	movb	$0x1, (%r8)
180004ccd:     	movq	$0x206cc83, 0x18(%rdx)  # imm = 0x206CC83
180004cd5:     	cmpb	$0x0, (%r8)
180004cd9:     	je	0x180004f32 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1c62>
180004cdf:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004ce4:     	movq	0x160(%rsp), %r10
180004cec:     	movabsq	$0x7ffffffffffffff8, %rcx # imm = 0x7FFFFFFFFFFFFFF8
180004cf6:     	andq	%rcx, %r10
180004cf9:     	movq	%r10, 0x138(%rsp)
180004d01:     	leaq	(%rsi,%r15,8), %rdi
180004d05:     	leaq	(%rsi,%r11,8), %rbp
180004d09:     	xorl	%ecx, %ecx
180004d0b:     	movq	0x168(%rsp), %rbx
180004d13:     	leaq	(%r15,%rcx), %r10
180004d17:     	sarq	$0x3f, %r10
180004d1b:     	andq	%rbx, %r10
180004d1e:     	addq	%rdi, %r10
180004d21:     	movq	(%r10,%rcx,8), %r10
180004d25:     	leaq	(%r11,%rcx), %rsi
180004d29:     	sarq	$0x3f, %rsi
180004d2d:     	andq	%rbx, %rsi
180004d30:     	addq	%rbp, %rsi
180004d33:     	movq	%r10, (%rsi,%rcx,8)
180004d37:     	leaq	0x1(%r15,%rcx), %r10
180004d3c:     	sarq	$0x3f, %r10
180004d40:     	andq	%rbx, %r10
180004d43:     	addq	%rdi, %r10
180004d46:     	movq	0x8(%r10,%rcx,8), %r10
180004d4b:     	leaq	0x1(%r11,%rcx), %rsi
180004d50:     	sarq	$0x3f, %rsi
180004d54:     	andq	%rbx, %rsi
180004d57:     	addq	%rbp, %rsi
180004d5a:     	movq	%r10, 0x8(%rsi,%rcx,8)
180004d5f:     	leaq	0x2(%r15,%rcx), %r10
180004d64:     	sarq	$0x3f, %r10
180004d68:     	andq	%rbx, %r10
180004d6b:     	addq	%rdi, %r10
180004d6e:     	movq	0x10(%r10,%rcx,8), %r10
180004d73:     	leaq	0x2(%r11,%rcx), %rsi
180004d78:     	sarq	$0x3f, %rsi
180004d7c:     	andq	%rbx, %rsi
180004d7f:     	addq	%rbp, %rsi
180004d82:     	movq	%r10, 0x10(%rsi,%rcx,8)
180004d87:     	leaq	0x3(%r15,%rcx), %r10
180004d8c:     	sarq	$0x3f, %r10
180004d90:     	andq	%rbx, %r10
180004d93:     	addq	%rdi, %r10
180004d96:     	movq	0x18(%r10,%rcx,8), %r10
180004d9b:     	leaq	0x3(%r11,%rcx), %rsi
180004da0:     	sarq	$0x3f, %rsi
180004da4:     	andq	%rbx, %rsi
180004da7:     	addq	%rbp, %rsi
180004daa:     	movq	%r10, 0x18(%rsi,%rcx,8)
180004daf:     	leaq	0x4(%r15,%rcx), %r10
180004db4:     	sarq	$0x3f, %r10
180004db8:     	andq	%rbx, %r10
180004dbb:     	addq	%rdi, %r10
180004dbe:     	movq	0x20(%r10,%rcx,8), %r10
180004dc3:     	leaq	0x4(%r11,%rcx), %rsi
180004dc8:     	sarq	$0x3f, %rsi
180004dcc:     	andq	%rbx, %rsi
180004dcf:     	addq	%rbp, %rsi
180004dd2:     	movq	%r10, 0x20(%rsi,%rcx,8)
180004dd7:     	leaq	0x5(%r15,%rcx), %r10
180004ddc:     	sarq	$0x3f, %r10
180004de0:     	andq	%rbx, %r10
180004de3:     	addq	%rdi, %r10
180004de6:     	movq	0x28(%r10,%rcx,8), %r10
180004deb:     	leaq	0x5(%r11,%rcx), %rsi
180004df0:     	sarq	$0x3f, %rsi
180004df4:     	andq	%rbx, %rsi
180004df7:     	addq	%rbp, %rsi
180004dfa:     	movq	%r10, 0x28(%rsi,%rcx,8)
180004dff:     	leaq	0x6(%r15,%rcx), %r10
180004e04:     	sarq	$0x3f, %r10
180004e08:     	andq	%rbx, %r10
180004e0b:     	addq	%rdi, %r10
180004e0e:     	movq	0x30(%r10,%rcx,8), %r10
180004e13:     	leaq	0x6(%r11,%rcx), %rsi
180004e18:     	sarq	$0x3f, %rsi
180004e1c:     	andq	%rbx, %rsi
180004e1f:     	addq	%rbp, %rsi
180004e22:     	movq	%r10, 0x30(%rsi,%rcx,8)
180004e27:     	leaq	0x7(%r15,%rcx), %r10
180004e2c:     	sarq	$0x3f, %r10
180004e30:     	andq	%rbx, %r10
180004e33:     	addq	%rdi, %r10
180004e36:     	movq	0x38(%r10,%rcx,8), %r10
180004e3b:     	leaq	0x7(%r11,%rcx), %rsi
180004e40:     	sarq	$0x3f, %rsi
180004e44:     	andq	%rbx, %rsi
180004e47:     	addq	%rbp, %rsi
180004e4a:     	movq	%r10, 0x38(%rsi,%rcx,8)
180004e4f:     	addq	$0x8, %rcx
180004e53:     	cmpq	%rcx, 0x138(%rsp)
180004e5b:     	jne	0x180004d13 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1a43>
180004e61:     	movq	0x138(%rsp), %rcx
180004e69:     	testq	%r13, %r13
180004e6c:     	je	0x180004eac <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1bdc>
180004e6e:     	movq	%rcx, %r10
180004e71:     	addq	%r11, %rcx
180004e74:     	addq	%r10, %r15
180004e77:     	movq	%r15, %r10
180004e7a:     	sarq	$0x3f, %r10
180004e7e:     	andq	%rbx, %r10
180004e81:     	movq	0x3b8(%rsp), %rdi
180004e89:     	addq	%rdi, %r10
180004e8c:     	movq	(%r10,%r15,8), %r10
180004e90:     	movq	%rcx, %rsi
180004e93:     	sarq	$0x3f, %rsi
180004e97:     	andq	%rbx, %rsi
180004e9a:     	addq	%rdi, %rsi
180004e9d:     	movq	%r10, (%rsi,%rcx,8)
180004ea1:     	incq	%rcx
180004ea4:     	incq	%r15
180004ea7:     	decq	%r13
180004eaa:     	jne	0x180004e77 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1ba7>
180004eac:     	movq	0x150(%rsp), %rcx
180004eb4:     	movq	0x258(%rsp), %r10
180004ebc:     	movq	%r10, 0x8(%rcx,%r9,8)
180004ec1:     	movq	0x148(%rsp), %r10
180004ec9:     	movq	%r11, 0x10(%rcx,%r10,8)
180004ece:     	movq	0x140(%rsp), %rcx
180004ed6:     	movq	0x160(%rsp), %rdi
180004ede:     	leaq	0x1(%rdi), %r10
180004ee2:     	movq	0x150(%rsp), %r11
180004eea:     	movq	%r10, (%r11,%rax)
180004eee:     	cmpb	$0x0, (%r8)
180004ef2:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004ef8:     	movq	%r8, %rsi
180004efb:     	movq	0x150(%rsp), %r10
180004f03:     	movq	0x148(%rsp), %r11
180004f0b:     	addq	0x10(%r10,%r11,8), %rdi
180004f10:     	movq	%rdi, %r10
180004f13:     	sarq	$0x3f, %r10
180004f17:     	andq	%r14, %r10
180004f1a:     	movq	0x3b8(%rsp), %r11
180004f22:     	leaq	(%r11,%rdi,8), %r11
180004f26:     	movq	0x158(%rsp), %rdi
180004f2e:     	movq	%rdi, (%r11,%r10,8)
180004f32:     	movq	0x190(%rsp), %r10
180004f3a:     	movq	0x188(%rsp), %r11
180004f42:     	movq	0x178(%rsp), %r13
180004f4a:     	cmpq	(%r11,%r10,8), %r13
180004f4e:     	movq	%r14, %rdi
180004f51:     	movq	0x168(%rsp), %r15
180004f59:     	movq	0x180(%rsp), %r10
180004f61:     	jl	0x180004482 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x11b2>
180004f67:     	cmpb	$0x0, (%rsi)
180004f6a:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004f70:     	jmp	0x180005810 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2540>
180004f75:     	movb	$0x1, (%r13)
180004f7a:     	movq	$0x18cba83, 0x18(%r14)  # imm = 0x18CBA83
180004f82:     	xorpd	%xmm6, %xmm6
180004f86:     	xorpd	%xmm7, %xmm7
180004f8a:     	xorpd	%xmm8, %xmm8
180004f8f:     	cmpb	$0x0, (%r13)
180004f94:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004f9a:     	jmp	0x1800035ea <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x31a>
180004f9f:     	movsd	(%rsi,%rax,8), %xmm0
180004fa4:     	movsd	0x10(%rsi,%rax,8), %xmm1
180004faa:     	movsd	0x20(%rsi,%rax,8), %xmm2
180004fb0:     	movq	%r15, (%r14)
180004fb3:     	cmpb	$0x0, (%r13)
180004fb8:     	movq	0x3a0(%rsp), %r15
180004fc0:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180004fc6:     	xorps	%xmm3, %xmm3
180004fc9:     	cvtsi2sd	%r9, %xmm3
180004fce:     	movsd	0x5412(%rip), %xmm4     # 0x18000a3e8
180004fd6:     	divsd	%xmm3, %xmm4
180004fda:     	mulsd	%xmm4, %xmm0
180004fde:     	mulsd	%xmm4, %xmm1
180004fe2:     	mulsd	%xmm2, %xmm4
180004fe6:     	movsd	%xmm0, (%rsi,%r11,8)
180004fec:     	movsd	%xmm1, 0x10(%rsi,%r11,8)
180004ff3:     	movsd	%xmm4, 0x20(%rsi,%r11,8)
180004ffa:     	cmpb	$0x0, (%r13)
180004fff:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005005:     	movq	%rbp, %rdx
180005008:     	movsd	(%rsi,%rax,8), %xmm2
18000500d:     	movapd	0x53bb(%rip), %xmm0     # 0x18000a3d0
180005015:     	andpd	%xmm0, %xmm2
180005019:     	addsd	0x538f(%rip), %xmm2     # 0x18000a3b0
180005021:     	movapd	%xmm2, %xmm3
180005025:     	andpd	%xmm0, %xmm3
180005029:     	movsd	0x53d7(%rip), %xmm1     # 0x18000a408
180005031:     	ucomisd	%xmm3, %xmm1
180005035:     	jbe	0x1800057fa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x252a>
18000503b:     	movsd	0x10(%rsi,%rax,8), %xmm3
180005041:     	andpd	%xmm0, %xmm3
180005045:     	addsd	0x5363(%rip), %xmm3     # 0x18000a3b0
18000504d:     	movapd	%xmm3, %xmm4
180005051:     	andpd	%xmm0, %xmm4
180005055:     	ucomisd	%xmm4, %xmm1
180005059:     	jbe	0x1800057fa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x252a>
18000505f:     	cvttsd2si	%xmm2, %rsi
180005064:     	cvttsd2si	%xmm3, %r9
180005069:     	leaq	(%r9,%rsi), %r11
18000506d:     	xorq	%r11, %rsi
180005070:     	xorq	%r11, %r9
180005073:     	movb	$0x1, %dl
180005075:     	testq	%r9, %rsi
180005078:     	js	0x180003802 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x532>
18000507e:     	movq	0x380(%rsp), %rsi
180005086:     	movsd	0x20(%rsi,%rax,8), %xmm2
18000508c:     	andpd	%xmm0, %xmm2
180005090:     	addsd	0x5318(%rip), %xmm2     # 0x18000a3b0
180005098:     	andpd	%xmm2, %xmm0
18000509c:     	ucomisd	%xmm0, %xmm1
1800050a0:     	jbe	0x180005fa8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2cd8>
1800050a6:     	cvttsd2si	%xmm2, %rsi
1800050ab:     	leaq	(%r11,%rsi), %rax
1800050af:     	xorq	%rax, %r11
1800050b2:     	xorq	%rax, %rsi
1800050b5:     	testq	%rsi, %r11
1800050b8:     	js	0x180003802 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x532>
1800050be:     	testb	$0x1, %al
1800050c0:     	jne	0x1800060fc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2e2c>
1800050c6:     	movq	0x10(%rdi), %rax
1800050ca:     	movq	%rax, %rdx
1800050cd:     	sarq	$0x3f, %rdx
1800050d1:     	movq	0x388(%rsp), %rbx
1800050d9:     	andq	%rbx, %rdx
1800050dc:     	movq	0x380(%rsp), %rdi
1800050e4:     	leaq	(%rdi,%rax,8), %r11
1800050e8:     	movsd	(%r11,%rdx,8), %xmm8
1800050ee:     	xorl	%edx, %edx
1800050f0:     	cmpq	$-0x2, %rax
1800050f4:     	movl	$0x0, %esi
1800050f9:     	cmovlq	%rbx, %rsi
1800050fd:     	movsd	0x10(%r11,%rsi,8), %xmm7
180005104:     	movq	%rdi, %rsi
180005107:     	cmpq	$-0x4, %rax
18000510b:     	cmovlq	%rbx, %rdx
18000510f:     	movsd	0x20(%r11,%rdx,8), %xmm6
180005116:     	movq	%rbp, %rdx
180005119:     	jmp	0x180004f8f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1cbf>
18000511e:     	movb	$0x1, (%r13)
180005123:     	movq	$0x1e84802, 0x18(%r14)  # imm = 0x1E84802
18000512b:     	cmpb	$0x0, (%r13)
180005130:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005136:     	movsd	-0x8(%rsi), %xmm0
18000513b:     	movq	$-0x1, %rax
180005142:     	movsd	(%rsi,%rdi,8), %xmm1
180005147:     	subsd	%xmm0, %xmm1
18000514b:     	movapd	0x527d(%rip), %xmm0     # 0x18000a3d0
180005153:     	andpd	%xmm1, %xmm0
180005157:     	ucomisd	0x5281(%rip), %xmm0     # 0x18000a3e0
18000515f:     	jae	0x180005388 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x20b8>
180005165:     	movsd	0x10(%rsi,%rdi,8), %xmm0
18000516b:     	subsd	0x10(%rsi,%rax,8), %xmm0
180005171:     	movapd	0x5257(%rip), %xmm2     # 0x18000a3d0
180005179:     	andpd	%xmm0, %xmm2
18000517d:     	ucomisd	0x525b(%rip), %xmm2     # 0x18000a3e0
180005185:     	jae	0x180005388 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x20b8>
18000518b:     	movsd	0x20(%rsi,%rdi,8), %xmm2
180005191:     	subsd	0x20(%rsi,%rax,8), %xmm2
180005197:     	movapd	0x5231(%rip), %xmm3     # 0x18000a3d0
18000519f:     	andpd	%xmm2, %xmm3
1800051a3:     	ucomisd	0x5235(%rip), %xmm3     # 0x18000a3e0
1800051ab:     	jae	0x180005388 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x20b8>
1800051b1:     	movq	%rdx, %r9
1800051b4:     	movq	(%r14), %rax
1800051b7:     	leaq	0x6(%rax), %rdx
1800051bb:     	cmpq	%rbp, %rdx
1800051be:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
1800051c4:     	movq	%rdx, (%r14)
1800051c7:     	cmpb	$0x0, (%r13)
1800051cc:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800051d2:     	movq	%r9, %rdx
1800051d5:     	movsd	%xmm1, (%rsi,%rax,8)
1800051da:     	movsd	%xmm0, 0x10(%rsi,%rax,8)
1800051e0:     	movsd	%xmm2, 0x20(%rsi,%rax,8)
1800051e6:     	cmpb	$0x0, (%r13)
1800051eb:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800051f1:     	jmp	0x1800053a7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x20d7>
1800051f6:     	shlq	$0x3, %r9
1800051fa:     	movq	0x138(%rsp), %rdx
180005202:     	movq	(%rdx,%r9), %rax
180005206:     	testq	%rax, %rax
180005209:     	jle	0x180004298 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0xfc8>
18000520f:     	movq	0x10(%rdx,%rbp,8), %rdx
180005214:     	leaq	(,%rbx,8), %r9
18000521c:     	movq	%r9, 0x150(%rsp)
180005224:     	xorpd	%xmm0, %xmm0
180005228:     	movq	$-0x1, %r9
18000522f:     	movq	$0x0, 0x138(%rsp)
18000523b:     	movsd	0x51dd(%rip), %xmm1     # 0x18000a420
180005243:     	xorl	%r15d, %r15d
180005246:     	movq	$-0x1, 0x148(%rsp)
180005252:     	jmp	0x180005279 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1fa9>
180005254:     	movl	%r15d, %r14d
180005257:     	movq	%r12, %r13
18000525a:     	movq	0x390(%rsp), %r12
180005262:     	movq	0x398(%rsp), %r10
18000526a:     	incq	%rdx
18000526d:     	decq	%rax
180005270:     	movl	%r14d, %r15d
180005273:     	je	0x180005c14 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2944>
180005279:     	movq	%r13, %r12
18000527c:     	movq	%rdx, %r11
18000527f:     	sarq	$0x3f, %r11
180005283:     	andq	0x150(%rsp), %r11
18000528b:     	movq	0x3b8(%rsp), %r10
180005293:     	addq	%r10, %r11
180005296:     	movq	(%r11,%rdx,8), %r14
18000529a:     	leaq	(%r10,%r14,8), %rbp
18000529e:     	cmpq	$-0x1, %r14
1800052a2:     	movl	$0x0, %r11d
1800052a8:     	cmovlq	0x388(%rsp), %r11
1800052b1:     	cmpq	$-0x2, %r14
1800052b5:     	movl	$0x0, %edi
1800052ba:     	movq	0x3c0(%rsp), %rbx
1800052c2:     	cmovlq	%rbx, %rdi
1800052c6:     	cmpq	$-0x3, %r14
1800052ca:     	movl	$0x0, %r13d
1800052d0:     	cmovlq	%rbx, %r13
1800052d4:     	cmpq	$0x0, 0x10(%rbp,%rdi,8)
1800052da:     	je	0x180005254 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1f84>
1800052e0:     	leaq	(%rsi,%r14,8), %rdi
1800052e4:     	movsd	0x8(%rdi,%r11,8), %xmm2
1800052eb:     	ucomisd	%xmm1, %xmm2
1800052ef:     	jbe	0x180005254 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1f84>
1800052f5:     	sarq	$0x3f, %r14
1800052f9:     	andq	0x3c0(%rsp), %r14
180005301:     	movq	(%rbp,%r14,8), %r11
180005306:     	movq	0x18(%rbp,%r13,8), %rbp
18000530b:     	movb	$0x1, %r14b
18000530e:     	testb	$0x1, 0x138(%rsp)
180005316:     	movq	0x398(%rsp), %r10
18000531e:     	je	0x18000534f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x207f>
180005320:     	testb	$0x1, %r15b
180005324:     	movq	%r12, %r13
180005327:     	je	0x180005bd1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2901>
18000532d:     	ucomisd	%xmm2, %xmm0
180005331:     	jbe	0x180005342 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2072>
180005333:     	movq	%r11, 0x148(%rsp)
18000533b:     	movapd	%xmm2, %xmm0
18000533f:     	movq	%rbp, %r9
180005342:     	movb	$0x1, %r11b
180005345:     	movq	%r11, 0x138(%rsp)
18000534d:     	jmp	0x18000536c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x209c>
18000534f:     	movq	%r11, 0x148(%rsp)
180005357:     	movapd	%xmm2, %xmm0
18000535b:     	movq	%rbp, %r9
18000535e:     	movb	$0x1, %r11b
180005361:     	movq	%r11, 0x138(%rsp)
180005369:     	movq	%r12, %r13
18000536c:     	movq	0x390(%rsp), %r12
180005374:     	incq	%rdx
180005377:     	decq	%rax
18000537a:     	movl	%r14d, %r15d
18000537d:     	jne	0x180005279 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1fa9>
180005383:     	jmp	0x180005c14 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2944>
180005388:     	movb	$0x1, (%r13)
18000538d:     	movq	$0x1f78a43, 0x18(%r14)  # imm = 0x1F78A43
180005395:     	cmpb	$0x0, (%r13)
18000539a:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800053a0:     	movq	$-0x1, %rax
1800053a7:     	movq	%r15, %r9
1800053aa:     	movq	%rdx, %r15
1800053ad:     	movq	(%r14), %rdi
1800053b0:     	leaq	0x2(%rdi), %rdx
1800053b4:     	cmpq	%rbp, %rdx
1800053b7:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
1800053bd:     	movq	%rdx, (%r14)
1800053c0:     	cmpb	$0x0, (%r13)
1800053c5:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800053cb:     	movq	0x3b8(%rsp), %rdx
1800053d3:     	movq	0x470(%rsp), %r11
1800053db:     	movq	%r11, (%rdx,%rdi,8)
1800053df:     	cmpb	$0x0, (%r13)
1800053e4:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800053ea:     	movq	%rsi, %rbp
1800053ed:     	movq	%r13, %rsi
1800053f0:     	movq	%rcx, %r13
1800053f3:     	movsd	(%rbp,%rax,8), %xmm0
1800053f9:     	mulsd	%xmm0, %xmm0
1800053fd:     	movapd	0x4fcb(%rip), %xmm1     # 0x18000a3d0
180005405:     	andpd	%xmm0, %xmm1
180005409:     	ucomisd	0x4fcf(%rip), %xmm1     # 0x18000a3e0
180005411:     	jae	0x180005487 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x21b7>
180005413:     	movsd	0x10(%rbp,%rax,8), %xmm1
180005419:     	mulsd	%xmm1, %xmm1
18000541d:     	movapd	0x4fab(%rip), %xmm2     # 0x18000a3d0
180005425:     	andpd	%xmm1, %xmm2
180005429:     	ucomisd	0x4faf(%rip), %xmm2     # 0x18000a3e0
180005431:     	jae	0x180005487 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x21b7>
180005433:     	addsd	%xmm1, %xmm0
180005437:     	movapd	0x4f91(%rip), %xmm1     # 0x18000a3d0
18000543f:     	andpd	%xmm0, %xmm1
180005443:     	ucomisd	0x4f95(%rip), %xmm1     # 0x18000a3e0
18000544b:     	jae	0x180005487 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x21b7>
18000544d:     	movsd	0x20(%rbp,%rax,8), %xmm1
180005453:     	mulsd	%xmm1, %xmm1
180005457:     	movapd	0x4f71(%rip), %xmm2     # 0x18000a3d0
18000545f:     	andpd	%xmm1, %xmm2
180005463:     	ucomisd	0x4f75(%rip), %xmm2     # 0x18000a3e0
18000546b:     	jae	0x180005487 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x21b7>
18000546d:     	addsd	%xmm1, %xmm0
180005471:     	movapd	0x4f57(%rip), %xmm1     # 0x18000a3d0
180005479:     	andpd	%xmm0, %xmm1
18000547d:     	ucomisd	0x4f5b(%rip), %xmm1     # 0x18000a3e0
180005485:     	jb	0x1800054aa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x21da>
180005487:     	movb	$0x1, (%rsi)
18000548a:     	movq	0x3f0(%rsp), %rdx
180005492:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
18000549a:     	cmpb	$0x0, (%rsi)
18000549d:     	movq	%r13, %rcx
1800054a0:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800054a6:     	xorpd	%xmm0, %xmm0
1800054aa:     	sqrtsd	%xmm0, %xmm0
1800054ae:     	xorpd	%xmm1, %xmm1
1800054b2:     	ucomisd	%xmm1, %xmm0
1800054b6:     	jne	0x180006570 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x32a0>
1800054bc:     	jp	0x180006570 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x32a0>
1800054c2:     	movb	$0x1, (%rsi)
1800054c5:     	movq	0x3f0(%rsp), %rcx
1800054cd:     	movq	$0x3d0902, 0x18(%rcx)   # imm = 0x3D0902
1800054d5:     	cmpb	$0x0, (%rsi)
1800054d8:     	movq	%r13, %rcx
1800054db:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800054e1:     	movq	$-0x1, %rdx
1800054e8:     	movq	0x3b8(%rsp), %rax
1800054f0:     	movq	%rdx, 0x8(%rax,%rdi,8)
1800054f5:     	cmpb	$0x0, (%rsi)
1800054f8:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800054fe:     	movq	0x3f0(%rsp), %rdx
180005506:     	movq	0x8(%rdx), %rax
18000550a:     	leaq	0x1(%rax), %rcx
18000550e:     	movq	%rcx, 0x8(%rdx)
180005512:     	cmpq	0x10(%rdx), %rax
180005516:     	jge	0x18000668b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x33bb>
18000551c:     	movq	$0x0, 0x198(%rsp)
180005528:     	movb	$0x0, 0x1a0(%rsp)
180005530:     	movq	$0x0, 0x1a8(%rsp)
18000553c:     	movb	$0x0, 0x1b0(%rsp)
180005544:     	movq	$0x0, 0x1b8(%rsp)
180005550:     	movb	$0x0, 0x1c0(%rsp)
180005558:     	movq	$0x0, 0x1c8(%rsp)
180005564:     	movb	$0x0, 0x1d0(%rsp)
18000556c:     	movq	$0x0, 0x1d8(%rsp)
180005578:     	movb	$0x0, 0x1e0(%rsp)
180005580:     	movq	$0x0, 0x1e8(%rsp)
18000558c:     	movb	$0x0, 0x1f0(%rsp)
180005594:     	movq	%rdi, 0x100(%rsp)
18000559c:     	movq	0x438(%rsp), %rax
1800055a4:     	movq	%rax, 0xe8(%rsp)
1800055ac:     	movq	0x430(%rsp), %rax
1800055b4:     	movq	%rax, 0xe0(%rsp)
1800055bc:     	movq	0x420(%rsp), %rax
1800055c4:     	movq	%rax, 0xd0(%rsp)
1800055cc:     	movq	0x418(%rsp), %rax
1800055d4:     	movq	%rax, 0xc8(%rsp)
1800055dc:     	movq	0x410(%rsp), %rax
1800055e4:     	movq	%rax, 0xc0(%rsp)
1800055ec:     	movq	0x408(%rsp), %rax
1800055f4:     	movq	%rax, 0xb8(%rsp)
1800055fc:     	movq	0x400(%rsp), %rax
180005604:     	movq	%rax, 0xb0(%rsp)
18000560c:     	movq	0x3f8(%rsp), %rax
180005614:     	movq	%rax, 0xa8(%rsp)
18000561c:     	movq	0x3e8(%rsp), %rax
180005624:     	movq	%rax, 0x98(%rsp)
18000562c:     	movq	0x3e0(%rsp), %rax
180005634:     	movq	%rax, 0x90(%rsp)
18000563c:     	movq	0x3d8(%rsp), %rax
180005644:     	movq	%rax, 0x88(%rsp)
18000564c:     	movq	0x3d0(%rsp), %rax
180005654:     	movq	%rax, 0x80(%rsp)
18000565c:     	movq	0x3c8(%rsp), %rax
180005664:     	movq	%rax, 0x78(%rsp)
180005669:     	movq	0x3b0(%rsp), %rax
180005671:     	movq	%rax, 0x60(%rsp)
180005676:     	movq	0x3a8(%rsp), %rax
18000567e:     	movq	%rax, 0x58(%rsp)
180005683:     	movq	%r9, 0x50(%rsp)
180005688:     	movq	%r10, 0x48(%rsp)
18000568d:     	movq	%r12, 0x40(%rsp)
180005692:     	movq	0x388(%rsp), %rax
18000569a:     	movq	%rax, 0x38(%rsp)
18000569f:     	movq	0x378(%rsp), %rax
1800056a7:     	movq	%rax, 0x28(%rsp)
1800056ac:     	movq	0x460(%rsp), %rax
1800056b4:     	movq	%rax, 0xf8(%rsp)
1800056bc:     	movq	%rsi, 0xd8(%rsp)
1800056c4:     	movq	0x3f0(%rsp), %rax
1800056cc:     	movq	%rax, 0xa0(%rsp)
1800056d4:     	movq	0x3c0(%rsp), %rax
1800056dc:     	movq	%rax, 0x70(%rsp)
1800056e1:     	movq	0x3b8(%rsp), %rax
1800056e9:     	movq	%rax, 0x68(%rsp)
1800056ee:     	movq	%rbp, 0x30(%rsp)
1800056f3:     	movq	0x370(%rsp), %rax
1800056fb:     	movq	%rax, 0x20(%rsp)
180005700:     	movq	$-0x1, 0x128(%rsp)
18000570c:     	movq	$-0x1, 0x120(%rsp)
180005718:     	movq	$-0x1, 0x118(%rsp)
180005724:     	movq	$-0x1, 0x110(%rsp)
180005730:     	movq	$-0x1, 0x108(%rsp)
18000573c:     	movq	$0x0, 0xf0(%rsp)
180005748:     	leaq	0x198(%rsp), %rcx
180005750:     	movq	0x170(%rsp), %r9
180005758:     	callq	0x180003330 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x60>
18000575d:     	cmpb	$0x0, (%rsi)
180005760:     	jne	0x18000669e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x33ce>
180005766:     	movsd	0x1b8(%rsp), %xmm2
18000576f:     	movsd	0x198(%rsp), %xmm0
180005778:     	movsd	0x1a8(%rsp), %xmm1
180005781:     	movq	0x3f0(%rsp), %rax
180005789:     	decq	0x8(%rax)
18000578d:     	cmpb	$0x0, (%rsi)
180005790:     	jne	0x18000669e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x33ce>
180005796:     	movq	%r15, %rdx
180005799:     	movsd	0x20(%rbp,%r15,8), %xmm3
1800057a0:     	shlq	$0x3, %rdx
1800057a4:     	mulsd	%xmm3, %xmm0
1800057a8:     	xorpd	%xmm4, %xmm4
1800057ac:     	addsd	%xmm4, %xmm0
1800057b0:     	mulsd	%xmm3, %xmm1
1800057b4:     	addsd	%xmm4, %xmm1
1800057b8:     	mulsd	%xmm3, %xmm2
1800057bc:     	addsd	%xmm4, %xmm2
1800057c0:     	movq	%r13, %rcx
1800057c3:     	movq	%rsi, %r13
1800057c6:     	movq	%rbp, %rsi
1800057c9:     	movq	0x3f0(%rsp), %r14
1800057d1:     	movq	0x3c0(%rsp), %rbp
1800057d9:     	movq	0x460(%rsp), %rax
1800057e1:     	movsd	0x18(%rsi,%rdx), %xmm4
1800057e7:     	xorpd	%xmm3, %xmm3
1800057eb:     	ucomisd	%xmm3, %xmm4
1800057ef:     	ja	0x180003639 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x369>
1800057f5:     	jmp	0x180005f47 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c77>
1800057fa:     	movb	$0x1, (%r13)
1800057ff:     	movq	$0x18cba84, 0x18(%r14)  # imm = 0x18CBA84
180005807:     	jmp	0x180004f82 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1cb2>
18000580c:     	shlq	$0x3, %rax
180005810:     	movq	0x150(%rsp), %r12
180005818:     	cmpq	$0x0, (%r12,%rax)
18000581d:     	jle	0x180005f02 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c32>
180005823:     	xorpd	%xmm5, %xmm5
180005827:     	xorl	%r9d, %r9d
18000582a:     	movapd	0x4b9d(%rip), %xmm9     # 0x18000a3d0
180005833:     	movsd	0x4ba4(%rip), %xmm10    # 0x18000a3e0
18000583c:     	xorpd	%xmm4, %xmm4
180005840:     	movq	%rdx, %r13
180005843:     	movq	0x148(%rsp), %rbp
18000584b:     	movq	0x10(%r12,%rbp,8), %r10
180005850:     	addq	%r9, %r10
180005853:     	movq	0x3b8(%rsp), %r11
18000585b:     	leaq	(%r11,%r10,8), %r11
18000585f:     	sarq	$0x3f, %r10
180005863:     	andq	%r14, %r10
180005866:     	movq	(%r11,%r10,8), %r10
18000586a:     	movq	0x380(%rsp), %r11
180005872:     	movsd	(%r11,%r10,8), %xmm12
180005878:     	movq	0x470(%rsp), %rdi
180005880:     	subsd	(%r11,%rdi,8), %xmm12
180005886:     	movapd	%xmm12, %xmm13
18000588b:     	andpd	%xmm9, %xmm13
180005890:     	ucomisd	%xmm10, %xmm13
180005895:     	jae	0x18000592a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x265a>
18000589b:     	movsd	0x10(%r11,%r10,8), %xmm13
1800058a2:     	subsd	0x10(%r11,%rdi,8), %xmm13
1800058a9:     	movapd	%xmm13, %xmm14
1800058ae:     	andpd	%xmm9, %xmm14
1800058b3:     	ucomisd	%xmm10, %xmm14
1800058b8:     	jae	0x18000592a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x265a>
1800058ba:     	movsd	0x20(%r11,%r10,8), %xmm14
1800058c1:     	subsd	0x20(%r11,%rdi,8), %xmm14
1800058c8:     	movapd	%xmm14, %xmm15
1800058cd:     	andpd	%xmm9, %xmm15
1800058d2:     	ucomisd	%xmm10, %xmm15
1800058d7:     	jae	0x18000592a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x265a>
1800058d9:     	movq	(%r13), %r11
1800058dd:     	leaq	0x6(%r11), %r10
1800058e1:     	cmpq	%r14, %r10
1800058e4:     	jg	0x1800060f4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2e24>
1800058ea:     	movq	%r10, (%r13)
1800058ee:     	cmpb	$0x0, (%rsi)
1800058f1:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800058f7:     	movq	0x380(%rsp), %r10
1800058ff:     	movsd	%xmm12, (%r10,%r11,8)
180005905:     	movsd	%xmm13, 0x10(%r10,%r11,8)
18000590c:     	movsd	%xmm14, 0x20(%r10,%r11,8)
180005913:     	movzbl	(%rsi), %edi
180005916:     	movl	%edi, %r10d
180005919:     	negb	%r10b
18000591c:     	movl	$0x0, %r10d
180005922:     	sbbq	%r10, %r10
180005925:     	orq	%r11, %r10
180005928:     	jmp	0x18000593f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x266f>
18000592a:     	movb	$0x1, (%rsi)
18000592d:     	movq	$0xf4243, 0x18(%r13)    # imm = 0xF4243
180005935:     	movzbl	(%rsi), %edi
180005938:     	movq	$-0x1, %r10
18000593f:     	testb	%dil, %dil
180005942:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005948:     	movq	0x380(%rsp), %r11
180005950:     	movsd	(%r11,%r10,8), %xmm12
180005956:     	mulsd	%xmm12, %xmm12
18000595b:     	movapd	%xmm12, %xmm13
180005960:     	andpd	%xmm9, %xmm13
180005965:     	ucomisd	%xmm10, %xmm13
18000596a:     	jae	0x1800059d2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2702>
18000596c:     	movsd	0x10(%r11,%r10,8), %xmm13
180005973:     	mulsd	%xmm13, %xmm13
180005978:     	movapd	%xmm13, %xmm14
18000597d:     	andpd	%xmm9, %xmm14
180005982:     	ucomisd	%xmm10, %xmm14
180005987:     	jae	0x1800059d2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2702>
180005989:     	addsd	%xmm13, %xmm12
18000598e:     	movapd	%xmm12, %xmm13
180005993:     	andpd	%xmm9, %xmm13
180005998:     	ucomisd	%xmm10, %xmm13
18000599d:     	jae	0x1800059d2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2702>
18000599f:     	movsd	0x20(%r11,%r10,8), %xmm13
1800059a6:     	mulsd	%xmm13, %xmm13
1800059ab:     	movapd	%xmm13, %xmm14
1800059b0:     	andpd	%xmm9, %xmm14
1800059b5:     	ucomisd	%xmm10, %xmm14
1800059ba:     	jae	0x1800059d2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2702>
1800059bc:     	addsd	%xmm13, %xmm12
1800059c1:     	movapd	%xmm12, %xmm13
1800059c6:     	andpd	%xmm9, %xmm13
1800059cb:     	ucomisd	%xmm10, %xmm13
1800059d0:     	jb	0x1800059eb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x271b>
1800059d2:     	movb	$0x1, (%rsi)
1800059d5:     	movq	$0x14fb183, 0x18(%r13)  # imm = 0x14FB183
1800059dd:     	xorpd	%xmm12, %xmm12
1800059e2:     	cmpb	$0x0, (%rsi)
1800059e5:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800059eb:     	sqrtsd	%xmm12, %xmm12
1800059f0:     	ucomisd	%xmm5, %xmm12
1800059f5:     	jne	0x180005a13 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2743>
1800059f7:     	jp	0x180005a13 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2743>
1800059f9:     	movb	$0x1, (%rsi)
1800059fc:     	movq	$0x3d0902, 0x18(%r13)   # imm = 0x3D0902
180005a04:     	movzbl	(%rsi), %edi
180005a07:     	movq	$-0x1, %r10
180005a0e:     	jmp	0x180005a9b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x27cb>
180005a13:     	movq	(%r13), %r11
180005a17:     	leaq	0x6(%r11), %rdi
180005a1b:     	cmpq	%r14, %rdi
180005a1e:     	jg	0x1800060f4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2e24>
180005a24:     	movq	0x380(%rsp), %r15
180005a2c:     	movsd	(%r15,%r10,8), %xmm13
180005a32:     	movsd	0x10(%r15,%r10,8), %xmm14
180005a39:     	movsd	0x20(%r15,%r10,8), %xmm15
180005a40:     	movq	%rdi, (%r13)
180005a44:     	cmpb	$0x0, (%rsi)
180005a47:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005a4d:     	movsd	0x4992(%rip), %xmm11    # 0x18000a3e8
180005a56:     	divsd	%xmm12, %xmm11
180005a5b:     	mulsd	%xmm11, %xmm13
180005a60:     	mulsd	%xmm11, %xmm14
180005a65:     	mulsd	%xmm15, %xmm11
180005a6a:     	movq	0x380(%rsp), %r10
180005a72:     	movsd	%xmm13, (%r10,%r11,8)
180005a78:     	movsd	%xmm14, 0x10(%r10,%r11,8)
180005a7f:     	movsd	%xmm11, 0x20(%r10,%r11,8)
180005a86:     	movzbl	(%rsi), %edi
180005a89:     	movl	%edi, %r10d
180005a8c:     	negb	%r10b
180005a8f:     	movl	$0x0, %r10d
180005a95:     	sbbq	%r10, %r10
180005a98:     	orq	%r11, %r10
180005a9b:     	testb	%dil, %dil
180005a9e:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005aa4:     	movq	0x380(%rsp), %r11
180005aac:     	movsd	(%r11,%r10,8), %xmm12
180005ab2:     	movq	0x478(%rsp), %rdi
180005aba:     	mulsd	(%r11,%rdi,8), %xmm12
180005ac0:     	movapd	%xmm12, %xmm11
180005ac5:     	andpd	%xmm9, %xmm11
180005aca:     	ucomisd	%xmm10, %xmm11
180005acf:     	jae	0x180005b83 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28b3>
180005ad5:     	movsd	0x10(%r11,%r10,8), %xmm13
180005adc:     	mulsd	0x10(%r11,%rdi,8), %xmm13
180005ae3:     	movapd	%xmm13, %xmm11
180005ae8:     	andpd	%xmm9, %xmm11
180005aed:     	ucomisd	%xmm10, %xmm11
180005af2:     	jae	0x180005b83 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28b3>
180005af8:     	addsd	%xmm13, %xmm12
180005afd:     	movapd	%xmm12, %xmm11
180005b02:     	andpd	%xmm9, %xmm11
180005b07:     	ucomisd	%xmm10, %xmm11
180005b0c:     	jae	0x180005b83 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28b3>
180005b0e:     	movsd	0x20(%r11,%r10,8), %xmm13
180005b15:     	movq	0x478(%rsp), %r10
180005b1d:     	mulsd	0x20(%r11,%r10,8), %xmm13
180005b24:     	movapd	%xmm13, %xmm11
180005b29:     	andpd	%xmm9, %xmm11
180005b2e:     	ucomisd	%xmm10, %xmm11
180005b33:     	jae	0x180005b83 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28b3>
180005b35:     	addsd	%xmm13, %xmm12
180005b3a:     	movapd	%xmm12, %xmm11
180005b3f:     	andpd	%xmm9, %xmm11
180005b44:     	ucomisd	%xmm10, %xmm11
180005b49:     	jae	0x180005b83 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28b3>
180005b4b:     	ucomisd	%xmm5, %xmm12
180005b50:     	jbe	0x180005ba9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28d9>
180005b52:     	addsd	%xmm12, %xmm4
180005b57:     	movapd	%xmm4, %xmm11
180005b5c:     	andpd	%xmm9, %xmm11
180005b61:     	ucomisd	%xmm10, %xmm11
180005b66:     	movq	%r8, %rsi
180005b69:     	movq	%rdx, %r13
180005b6c:     	movq	0x150(%rsp), %r12
180005b74:     	movq	0x148(%rsp), %rbp
180005b7c:     	jb	0x180005b97 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x28c7>
180005b7e:     	jmp	0x18000667b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x33ab>
180005b83:     	movb	$0x1, (%rsi)
180005b86:     	movq	$0x14fb183, 0x18(%r13)  # imm = 0x14FB183
180005b8e:     	cmpb	$0x0, (%rsi)
180005b91:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005b97:     	incq	%r9
180005b9a:     	cmpq	(%r12,%rax), %r9
180005b9e:     	jl	0x18000584b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x257b>
180005ba4:     	jmp	0x180005f06 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c36>
180005ba9:     	movq	%r8, %rsi
180005bac:     	movq	%rdx, %r13
180005baf:     	movq	0x150(%rsp), %r12
180005bb7:     	movq	0x148(%rsp), %rbp
180005bbf:     	incq	%r9
180005bc2:     	cmpq	(%r12,%rax), %r9
180005bc6:     	jl	0x18000584b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x257b>
180005bcc:     	jmp	0x180005f06 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c36>
180005bd1:     	movb	$0x1, (%r13)
180005bd6:     	movq	0x3f0(%rsp), %rax
180005bde:     	movq	$0x1036646, 0x18(%rax)  # imm = 0x1036646
180005be6:     	xorpd	%xmm0, %xmm0
180005bea:     	movq	$-0x1, %r9
180005bf1:     	movq	$0x0, 0x138(%rsp)
180005bfd:     	xorl	%r14d, %r14d
180005c00:     	movq	$-0x1, 0x148(%rsp)
180005c0c:     	movq	0x390(%rsp), %r12
180005c14:     	cmpb	$0x0, (%r13)
180005c19:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005c1f:     	testb	$0x1, 0x138(%rsp)
180005c27:     	je	0x180005ccd <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x29fd>
180005c2d:     	movq	%rsi, %r15
180005c30:     	movq	0x450(%rsp), %rax
180005c38:     	movq	0x3b8(%rsp), %rdx
180005c40:     	movq	(%rdx,%rax,8), %rax
180005c44:     	testb	$0x1, %r14b
180005c48:     	je	0x180005ddd <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2b0d>
180005c4e:     	movq	0x3f0(%rsp), %rsi
180005c56:     	movq	(%rsi), %rdx
180005c59:     	leaq	0x6(%rdx), %r11
180005c5d:     	cmpq	0x3c0(%rsp), %r11
180005c65:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
180005c6b:     	movq	%r10, %rbp
180005c6e:     	movq	0x450(%rsp), %r10
180005c76:     	movq	0x3b8(%rsp), %rdi
180005c7e:     	movq	0x8(%rdi,%r10,8), %rdi
180005c83:     	movsd	(%r15,%rdi,8), %xmm1
180005c89:     	movsd	0x10(%r15,%rdi,8), %xmm2
180005c90:     	movsd	0x20(%r15,%rdi,8), %xmm3
180005c97:     	movq	%r11, (%rsi)
180005c9a:     	cmpb	$0x0, (%r13)
180005c9f:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005ca1:     	mulsd	%xmm0, %xmm1
180005ca5:     	mulsd	%xmm0, %xmm2
180005ca9:     	mulsd	%xmm0, %xmm3
180005cad:     	movsd	%xmm1, (%r15,%rdx,8)
180005cb3:     	movsd	%xmm2, 0x10(%r15,%rdx,8)
180005cba:     	movsd	%xmm3, 0x20(%r15,%rdx,8)
180005cc1:     	cmpb	$0x0, (%r13)
180005cc6:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005cc8:     	jmp	0x180005e0d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2b3d>
180005ccd:     	movq	0x448(%rsp), %r8
180005cd5:     	movq	0x3b8(%rsp), %rax
180005cdd:     	movq	0x28(%rax,%r8,8), %rax
180005ce2:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005cec:     	addq	$0x8, %rdx
180005cf0:     	cmpq	%rdx, %rax
180005cf3:     	jne	0x180005eed <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c1d>
180005cf9:     	movb	$0x1, (%r13)
180005cfe:     	movq	$0x0, 0x58(%rcx)
180005d06:     	movq	$0x0, 0x50(%rcx)
180005d0e:     	movq	$0x0, 0x48(%rcx)
180005d16:     	movq	$0x0, 0x40(%rcx)
180005d1e:     	movq	$0x0, 0x38(%rcx)
180005d26:     	movq	$0x0, 0x30(%rcx)
180005d2e:     	movq	$0x0, 0x28(%rcx)
180005d36:     	movq	$0x0, 0x20(%rcx)
180005d3e:     	movq	$0x0, 0x18(%rcx)
180005d46:     	movq	$0x0, 0x10(%rcx)
180005d4e:     	movq	$0x0, 0x8(%rcx)
180005d56:     	movq	$0x0, (%rcx)
180005d5d:     	xorl	%eax, %eax
180005d5f:     	movaps	0x260(%rsp), %xmm6
180005d67:     	movaps	0x270(%rsp), %xmm7
180005d6f:     	movaps	0x280(%rsp), %xmm8
180005d78:     	movaps	0x290(%rsp), %xmm9
180005d81:     	movaps	0x2a0(%rsp), %xmm10
180005d8a:     	movaps	0x2b0(%rsp), %xmm11
180005d93:     	movaps	0x2c0(%rsp), %xmm12
180005d9c:     	movaps	0x2d0(%rsp), %xmm13
180005da5:     	movaps	0x2e0(%rsp), %xmm14
180005dae:     	movaps	0x2f0(%rsp), %xmm15
180005db7:     	addq	$0x308, %rsp            # imm = 0x308
180005dbe:     	popq	%rbx
180005dbf:     	popq	%rbp
180005dc0:     	popq	%rdi
180005dc1:     	popq	%rsi
180005dc2:     	popq	%r12
180005dc4:     	popq	%r13
180005dc6:     	popq	%r14
180005dc8:     	popq	%r15
180005dca:     	retq
180005dcb:     	movb	$0x1, (%r13)
180005dd0:     	movq	$0x6acfc6, 0x18(%r14)   # imm = 0x6ACFC6
180005dd8:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005ddd:     	movb	$0x1, (%r13)
180005de2:     	movq	0x3f0(%rsp), %rdx
180005dea:     	movq	$0x15ef3c2, 0x18(%rdx)  # imm = 0x15EF3C2
180005df2:     	cmpb	$0x0, (%r13)
180005df7:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005dfd:     	movq	%r10, %rbp
180005e00:     	movsd	-0x8(%r15), %xmm1
180005e06:     	movq	$-0x1, %rdx
180005e0d:     	movq	0x3b8(%rsp), %rbx
180005e15:     	movq	%r13, %rsi
180005e18:     	movq	%rcx, 0x140(%rsp)
180005e20:     	addsd	(%r15,%rax,8), %xmm1
180005e26:     	movapd	0x45a2(%rip), %xmm0     # 0x18000a3d0
180005e2e:     	andpd	%xmm1, %xmm0
180005e32:     	ucomisd	0x45a6(%rip), %xmm0     # 0x18000a3e0
180005e3a:     	jae	0x180005fca <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2cfa>
180005e40:     	movsd	0x10(%r15,%rax,8), %xmm0
180005e47:     	addsd	0x10(%r15,%rdx,8), %xmm0
180005e4e:     	movapd	0x457a(%rip), %xmm2     # 0x18000a3d0
180005e56:     	andpd	%xmm0, %xmm2
180005e5a:     	ucomisd	0x457e(%rip), %xmm2     # 0x18000a3e0
180005e62:     	jae	0x180005fca <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2cfa>
180005e68:     	movsd	0x20(%r15,%rax,8), %xmm2
180005e6f:     	addsd	0x20(%r15,%rdx,8), %xmm2
180005e76:     	movapd	0x4552(%rip), %xmm3     # 0x18000a3d0
180005e7e:     	andpd	%xmm2, %xmm3
180005e82:     	ucomisd	0x4556(%rip), %xmm3     # 0x18000a3e0
180005e8a:     	jae	0x180005fca <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2cfa>
180005e90:     	movq	0x3f0(%rsp), %rdx
180005e98:     	movq	(%rdx), %rdi
180005e9b:     	leaq	0x6(%rdi), %rax
180005e9f:     	cmpq	0x3c0(%rsp), %rax
180005ea7:     	movq	0x140(%rsp), %rcx
180005eaf:     	movq	%rsi, %r13
180005eb2:     	jg	0x1800036c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f5>
180005eb8:     	movq	%rax, (%rdx)
180005ebb:     	cmpb	$0x0, (%r13)
180005ec0:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005ec6:     	movq	%rbx, %r10
180005ec9:     	movsd	%xmm1, (%r15,%rdi,8)
180005ecf:     	movsd	%xmm0, 0x10(%r15,%rdi,8)
180005ed6:     	movsd	%xmm2, 0x20(%r15,%rdi,8)
180005edd:     	cmpb	$0x0, (%r13)
180005ee2:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005ee8:     	jmp	0x180005ff8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2d28>
180005eed:     	decq	%rax
180005ef0:     	movq	0x3b8(%rsp), %rdx
180005ef8:     	movq	%rax, 0x28(%rdx,%r8,8)
180005efd:     	jmp	0x18000350b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x23b>
180005f02:     	xorpd	%xmm4, %xmm4
180005f06:     	minsd	0x44da(%rip), %xmm4     # 0x18000a3e8
180005f0e:     	movq	0x380(%rsp), %rsi
180005f16:     	movq	0x170(%rsp), %rdx
180005f1e:     	mulsd	0x18(%rsi,%rdx), %xmm4
180005f24:     	movapd	%xmm8, %xmm5
180005f29:     	mulsd	%xmm4, %xmm5
180005f2d:     	addsd	%xmm5, %xmm0
180005f31:     	movapd	%xmm7, %xmm5
180005f35:     	mulsd	%xmm4, %xmm5
180005f39:     	addsd	%xmm5, %xmm1
180005f3d:     	mulsd	%xmm6, %xmm4
180005f41:     	addsd	%xmm4, %xmm2
180005f45:     	xorl	%ebx, %ebx
180005f47:     	movsd	0x8(%rsi,%rdx), %xmm4
180005f4d:     	ucomisd	%xmm3, %xmm4
180005f51:     	jbe	0x180005f6f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2c9f>
180005f53:     	mulsd	%xmm4, %xmm8
180005f58:     	addsd	%xmm8, %xmm0
180005f5d:     	mulsd	%xmm4, %xmm7
180005f61:     	addsd	%xmm7, %xmm1
180005f65:     	mulsd	%xmm4, %xmm6
180005f69:     	addsd	%xmm6, %xmm2
180005f6d:     	xorl	%ebx, %ebx
180005f6f:     	movb	%bl, 0x58(%rcx)
180005f72:     	movsd	%xmm2, 0x50(%rcx)
180005f77:     	movb	%bl, 0x48(%rcx)
180005f7a:     	movsd	%xmm1, 0x40(%rcx)
180005f7f:     	movb	%bl, 0x38(%rcx)
180005f82:     	movsd	%xmm0, 0x30(%rcx)
180005f87:     	movb	$0x0, 0x28(%rcx)
180005f8b:     	movq	$0x0, 0x20(%rcx)
180005f93:     	movb	$0x0, 0x18(%rcx)
180005f97:     	movq	$0x0, 0x10(%rcx)
180005f9f:     	movb	$0x0, 0x8(%rcx)
180005fa3:     	jmp	0x180005d56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a86>
180005fa8:     	movb	$0x1, (%r13)
180005fad:     	movq	$0x18cba84, 0x18(%r14)  # imm = 0x18CBA84
180005fb5:     	xorpd	%xmm6, %xmm6
180005fb9:     	xorpd	%xmm7, %xmm7
180005fbd:     	xorpd	%xmm8, %xmm8
180005fc2:     	movq	%rbp, %rdx
180005fc5:     	jmp	0x180004f8f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1cbf>
180005fca:     	movb	$0x1, (%rsi)
180005fcd:     	movq	0x3f0(%rsp), %rcx
180005fd5:     	movq	$0x16e3603, 0x18(%rcx)  # imm = 0x16E3603
180005fdd:     	cmpb	$0x0, (%rsi)
180005fe0:     	movq	0x140(%rsp), %rcx
180005fe8:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180005fee:     	movq	%rbx, %r10
180005ff1:     	movq	$-0x1, %rdi
180005ff8:     	movq	0x148(%rsp), %rcx
180006000:     	leaq	(%r10,%rcx,8), %rax
180006004:     	sarq	$0x3f, %rcx
180006008:     	andq	0x3c0(%rsp), %rcx
180006010:     	movq	(%rax,%rcx,8), %rcx
180006014:     	cmpq	$0x1, %rcx
180006018:     	je	0x1800061a8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2ed8>
18000601e:     	testq	%rcx, %rcx
180006021:     	jne	0x18000643f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x316f>
180006027:     	movq	0x8(%rax), %rax
18000602b:     	movsd	(%r15,%rdi,8), %xmm0
180006031:     	subsd	(%r15,%rax,8), %xmm0
180006037:     	movapd	0x4391(%rip), %xmm1     # 0x18000a3d0
18000603f:     	andpd	%xmm0, %xmm1
180006043:     	ucomisd	0x4395(%rip), %xmm1     # 0x18000a3e0
18000604b:     	jae	0x180006457 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3187>
180006051:     	movsd	0x10(%r15,%rdi,8), %xmm1
180006058:     	subsd	0x10(%r15,%rax,8), %xmm1
18000605f:     	movapd	0x4369(%rip), %xmm2     # 0x18000a3d0
180006067:     	andpd	%xmm1, %xmm2
18000606b:     	ucomisd	0x436d(%rip), %xmm2     # 0x18000a3e0
180006073:     	jae	0x180006457 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3187>
180006079:     	movsd	0x20(%r15,%rdi,8), %xmm2
180006080:     	subsd	0x20(%r15,%rax,8), %xmm2
180006087:     	movapd	0x4341(%rip), %xmm3     # 0x18000a3d0
18000608f:     	andpd	%xmm2, %xmm3
180006093:     	ucomisd	0x4345(%rip), %xmm3     # 0x18000a3e0
18000609b:     	jae	0x180006457 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3187>
1800060a1:     	movq	0x3f0(%rsp), %rax
1800060a9:     	movq	(%rax), %rax
1800060ac:     	leaq	0x6(%rax), %rcx
1800060b0:     	cmpq	0x3c0(%rsp), %rcx
1800060b8:     	jg	0x18000671c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344c>
1800060be:     	movq	0x3f0(%rsp), %rdx
1800060c6:     	movq	%rcx, (%rdx)
1800060c9:     	cmpb	$0x0, (%rsi)
1800060cc:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
1800060d2:     	movsd	%xmm0, (%r15,%rax,8)
1800060d8:     	movsd	%xmm1, 0x10(%r15,%rax,8)
1800060df:     	movsd	%xmm2, 0x20(%r15,%rax,8)
1800060e6:     	cmpb	$0x0, (%rsi)
1800060e9:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
1800060ef:     	jmp	0x180006480 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x31b0>
1800060f4:     	movb	$0x2, (%rsi)
1800060f7:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800060fc:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180006106:     	movabsq	$-0x40000000000001, %r13 # imm = 0xFFBFFFFFFFFFFFFF
180006110:     	movq	0x30(%rdi), %rsi
180006114:     	movq	%rsi, %r11
180006117:     	sarq	$0x3f, %r11
18000611b:     	andq	%rbx, %r11
18000611e:     	movq	0x3b8(%rsp), %rdx
180006126:     	leaq	(%rdx,%rsi,8), %rdi
18000612a:     	movq	(%rdi,%r11,8), %r11
18000612e:     	xorl	%edx, %edx
180006130:     	cmpq	$-0x1, %rsi
180006134:     	movl	$0x0, %r15d
18000613a:     	cmovlq	%rbx, %r15
18000613e:     	cmpq	$-0x2, %rsi
180006142:     	cmovlq	%rbx, %rdx
180006146:     	leaq	(%r11,%rax), %rsi
18000614a:     	cmpq	%r13, %rsi
18000614d:     	jb	0x18000616e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2e9e>
18000614f:     	movq	0x8(%rdi,%r15,8), %r15
180006154:     	leaq	(%r15,%rax), %rsi
180006158:     	cmpq	%r13, %rsi
18000615b:     	jb	0x18000616e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2e9e>
18000615d:     	movq	0x10(%rdi,%rdx,8), %rdi
180006162:     	addq	%rdi, %rax
180006165:     	cmpq	%r13, %rax
180006168:     	jae	0x180006594 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x32c4>
18000616e:     	movq	0x428(%rsp), %r13
180006176:     	movb	$0x1, (%r13)
18000617b:     	movq	$0x18cba87, 0x18(%r14)  # imm = 0x18CBA87
180006183:     	xorpd	%xmm6, %xmm6
180006187:     	xorpd	%xmm7, %xmm7
18000618b:     	xorpd	%xmm8, %xmm8
180006190:     	movq	0x380(%rsp), %rsi
180006198:     	movq	%rbp, %rdx
18000619b:     	movq	0x3a0(%rsp), %r15
1800061a3:     	jmp	0x180004f8f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x1cbf>
1800061a8:     	movq	0x20(%rax), %rcx
1800061ac:     	movq	0x3f0(%rsp), %r11
1800061b4:     	movq	0x8(%r11), %rax
1800061b8:     	leaq	0x1(%rax), %rdx
1800061bc:     	movq	%rdx, 0x8(%r11)
1800061c0:     	cmpq	0x10(%r11), %rax
1800061c4:     	jge	0x18000643f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x316f>
1800061ca:     	movq	$0x0, 0x228(%rsp)
1800061d6:     	movb	$0x0, 0x230(%rsp)
1800061de:     	movq	$0x0, 0x238(%rsp)
1800061ea:     	movb	$0x0, 0x240(%rsp)
1800061f2:     	movq	$0x0, 0x248(%rsp)
1800061fe:     	movb	$0x0, 0x250(%rsp)
180006206:     	movq	%rcx, 0x128(%rsp)
18000620e:     	movq	%rdi, 0x120(%rsp)
180006216:     	movq	0x450(%rsp), %rax
18000621e:     	movq	%rax, 0x118(%rsp)
180006226:     	movq	%r9, 0x108(%rsp)
18000622e:     	movq	0x438(%rsp), %rax
180006236:     	movq	%rax, 0xe8(%rsp)
18000623e:     	movq	0x430(%rsp), %rax
180006246:     	movq	%rax, 0xe0(%rsp)
18000624e:     	movq	0x420(%rsp), %rax
180006256:     	movq	%rax, 0xd0(%rsp)
18000625e:     	movq	0x418(%rsp), %rax
180006266:     	movq	%rax, 0xc8(%rsp)
18000626e:     	movq	0x410(%rsp), %rax
180006276:     	movq	%rax, 0xc0(%rsp)
18000627e:     	movq	0x408(%rsp), %rax
180006286:     	movq	%rax, 0xb8(%rsp)
18000628e:     	movq	0x400(%rsp), %rax
180006296:     	movq	%rax, 0xb0(%rsp)
18000629e:     	movq	0x3f8(%rsp), %rax
1800062a6:     	movq	%rax, 0xa8(%rsp)
1800062ae:     	movq	0x3e8(%rsp), %rax
1800062b6:     	movq	%rax, 0x98(%rsp)
1800062be:     	movq	0x3e0(%rsp), %rax
1800062c6:     	movq	%rax, 0x90(%rsp)
1800062ce:     	movq	0x3d8(%rsp), %rax
1800062d6:     	movq	%rax, 0x88(%rsp)
1800062de:     	movq	0x3d0(%rsp), %rax
1800062e6:     	movq	%rax, 0x80(%rsp)
1800062ee:     	movq	0x3c8(%rsp), %rax
1800062f6:     	movq	%rax, 0x78(%rsp)
1800062fb:     	movq	0x3c0(%rsp), %rax
180006303:     	movq	%rax, 0x70(%rsp)
180006308:     	movq	0x3b0(%rsp), %rax
180006310:     	movq	%rax, 0x60(%rsp)
180006315:     	movq	0x3a8(%rsp), %rax
18000631d:     	movq	%rax, 0x58(%rsp)
180006322:     	movq	0x3a0(%rsp), %rax
18000632a:     	movq	%rax, 0x50(%rsp)
18000632f:     	movq	%rbp, 0x48(%rsp)
180006334:     	movq	%r12, 0x40(%rsp)
180006339:     	movq	0x388(%rsp), %rax
180006341:     	movq	%rax, 0x38(%rsp)
180006346:     	movq	%r15, 0x30(%rsp)
18000634b:     	movq	0x378(%rsp), %rax
180006353:     	movq	%rax, 0x28(%rsp)
180006358:     	movq	0x448(%rsp), %rax
180006360:     	movq	%rax, 0x110(%rsp)
180006368:     	movq	%rsi, 0xd8(%rsp)
180006370:     	movq	0x3f0(%rsp), %rax
180006378:     	movq	%rax, 0xa0(%rsp)
180006380:     	movq	%rbx, 0x68(%rsp)
180006385:     	movq	0x370(%rsp), %rax
18000638d:     	movq	%rax, 0x20(%rsp)
180006392:     	movq	$-0x1, 0x100(%rsp)
18000639e:     	movq	$-0x1, 0xf8(%rsp)
1800063aa:     	movq	$0x1, 0xf0(%rsp)
1800063b6:     	leaq	0x1f8(%rsp), %rcx
1800063be:     	movq	0x170(%rsp), %r9
1800063c6:     	callq	0x180003330 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x60>
1800063cb:     	cmpb	$0x0, (%rsi)
1800063ce:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
1800063d4:     	movsd	0x228(%rsp), %xmm0
1800063dd:     	movzbl	0x230(%rsp), %eax
1800063e5:     	movsd	0x238(%rsp), %xmm1
1800063ee:     	movzbl	0x240(%rsp), %edx
1800063f6:     	movsd	0x248(%rsp), %xmm2
1800063ff:     	movzbl	0x250(%rsp), %ecx
180006407:     	movq	0x3f0(%rsp), %r8
18000640f:     	decq	0x8(%r8)
180006413:     	movq	0x448(%rsp), %r8
18000641b:     	movq	0x28(%rbx,%r8,8), %r8
180006420:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
18000642a:     	addq	$0x8, %r9
18000642e:     	cmpq	%r9, %r8
180006431:     	jne	0x180006611 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3341>
180006437:     	movb	$0x1, (%rsi)
18000643a:     	jmp	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
18000643f:     	movb	$0x1, (%rsi)
180006442:     	movq	0x3f0(%rsp), %rax
18000644a:     	movq	$0x6acfce, 0x18(%rax)   # imm = 0x6ACFCE
180006452:     	jmp	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
180006457:     	movb	$0x1, (%rsi)
18000645a:     	movq	0x3f0(%rsp), %rcx
180006462:     	movq	$0xf4243, 0x18(%rcx)    # imm = 0xF4243
18000646a:     	cmpb	$0x0, (%rsi)
18000646d:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
180006473:     	movsd	-0x8(%r15), %xmm0
180006479:     	movq	$-0x1, %rax
180006480:     	mulsd	%xmm0, %xmm0
180006484:     	movapd	0x3f44(%rip), %xmm1     # 0x18000a3d0
18000648c:     	andpd	%xmm0, %xmm1
180006490:     	ucomisd	0x3f48(%rip), %xmm1     # 0x18000a3e0
180006498:     	jae	0x180006510 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3240>
18000649a:     	movsd	0x10(%r15,%rax,8), %xmm1
1800064a1:     	mulsd	%xmm1, %xmm1
1800064a5:     	movapd	0x3f23(%rip), %xmm2     # 0x18000a3d0
1800064ad:     	andpd	%xmm1, %xmm2
1800064b1:     	ucomisd	0x3f27(%rip), %xmm2     # 0x18000a3e0
1800064b9:     	jae	0x180006510 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3240>
1800064bb:     	addsd	%xmm1, %xmm0
1800064bf:     	movapd	0x3f09(%rip), %xmm1     # 0x18000a3d0
1800064c7:     	andpd	%xmm0, %xmm1
1800064cb:     	ucomisd	0x3f0d(%rip), %xmm1     # 0x18000a3e0
1800064d3:     	jae	0x180006510 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3240>
1800064d5:     	movsd	0x20(%r15,%rax,8), %xmm1
1800064dc:     	mulsd	%xmm1, %xmm1
1800064e0:     	movapd	0x3ee8(%rip), %xmm2     # 0x18000a3d0
1800064e8:     	andpd	%xmm1, %xmm2
1800064ec:     	ucomisd	0x3eec(%rip), %xmm2     # 0x18000a3e0
1800064f4:     	jae	0x180006510 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3240>
1800064f6:     	addsd	%xmm1, %xmm0
1800064fa:     	movapd	0x3ece(%rip), %xmm1     # 0x18000a3d0
180006502:     	andpd	%xmm0, %xmm1
180006506:     	ucomisd	0x3ed2(%rip), %xmm1     # 0x18000a3e0
18000650e:     	jb	0x180006530 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3260>
180006510:     	movb	$0x1, (%rsi)
180006513:     	movq	0x3f0(%rsp), %rdx
18000651b:     	movq	$0x14fb183, 0x18(%rdx)  # imm = 0x14FB183
180006523:     	cmpb	$0x0, (%rsi)
180006526:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
18000652c:     	xorpd	%xmm0, %xmm0
180006530:     	sqrtsd	%xmm0, %xmm0
180006534:     	xorpd	%xmm1, %xmm1
180006538:     	ucomisd	%xmm1, %xmm0
18000653c:     	jne	0x180006703 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3433>
180006542:     	jp	0x180006703 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3433>
180006548:     	movb	$0x1, (%rsi)
18000654b:     	movq	0x3f0(%rsp), %rcx
180006553:     	movq	$0x3d0902, 0x18(%rcx)   # imm = 0x3D0902
18000655b:     	cmpb	$0x0, (%rsi)
18000655e:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
180006564:     	movq	$-0x1, %rcx
18000656b:     	jmp	0x1800061ac <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2edc>
180006570:     	movq	0x3f0(%rsp), %rcx
180006578:     	movq	(%rcx), %rdx
18000657b:     	leaq	0x6(%rdx), %rcx
18000657f:     	cmpq	0x3c0(%rsp), %rcx
180006587:     	jle	0x1800065b0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x32e0>
180006589:     	movb	$0x2, (%rsi)
18000658c:     	movq	%r13, %rcx
18000658f:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
180006594:     	cvtsi2sd	%r11, %xmm8
180006599:     	cvtsi2sd	%r15, %xmm7
18000659e:     	cvtsi2sd	%rdi, %xmm6
1800065a3:     	movq	0x428(%rsp), %r13
1800065ab:     	jmp	0x180006190 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2ec0>
1800065b0:     	movsd	(%rbp,%rax,8), %xmm1
1800065b6:     	movsd	0x10(%rbp,%rax,8), %xmm2
1800065bc:     	movsd	0x20(%rbp,%rax,8), %xmm3
1800065c2:     	movq	0x3f0(%rsp), %rax
1800065ca:     	movq	%rcx, (%rax)
1800065cd:     	cmpb	$0x0, (%rsi)
1800065d0:     	movq	%r13, %rcx
1800065d3:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
1800065d9:     	movsd	0x3e07(%rip), %xmm4     # 0x18000a3e8
1800065e1:     	divsd	%xmm0, %xmm4
1800065e5:     	mulsd	%xmm4, %xmm1
1800065e9:     	mulsd	%xmm4, %xmm2
1800065ed:     	mulsd	%xmm3, %xmm4
1800065f1:     	movsd	%xmm1, (%rbp,%rdx,8)
1800065f7:     	movsd	%xmm2, 0x10(%rbp,%rdx,8)
1800065fd:     	movsd	%xmm4, 0x20(%rbp,%rdx,8)
180006603:     	cmpb	$0x0, (%rsi)
180006606:     	jne	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000660c:     	jmp	0x1800054e8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2218>
180006611:     	cmpb	$0x0, (%rsi)
180006614:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
18000661a:     	decq	%r8
18000661d:     	testb	%dl, %dl
18000661f:     	movq	0x448(%rsp), %rdx
180006627:     	movq	%r8, 0x28(%rbx,%rdx,8)
18000662c:     	movq	0x140(%rsp), %rdx
180006634:     	setne	0x18(%rdx)
180006638:     	testb	%cl, %cl
18000663a:     	setne	0x28(%rdx)
18000663e:     	testb	%al, %al
180006640:     	movsd	%xmm2, 0x20(%rdx)
180006645:     	movsd	%xmm1, 0x10(%rdx)
18000664a:     	setne	0x8(%rdx)
18000664e:     	movsd	%xmm0, (%rdx)
180006652:     	movb	$0x0, 0x58(%rdx)
180006656:     	movq	$0x0, 0x50(%rdx)
18000665e:     	movb	$0x0, 0x48(%rdx)
180006662:     	movq	$0x0, 0x40(%rdx)
18000666a:     	movb	$0x0, 0x38(%rdx)
18000666e:     	movq	$0x0, 0x30(%rdx)
180006676:     	jmp	0x180005d5d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a8d>
18000667b:     	movb	$0x1, (%rsi)
18000667e:     	movq	$0x1406f4f, 0x18(%r13)  # imm = 0x1406F4F
180006686:     	jmp	0x180005cfe <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a2e>
18000668b:     	movb	$0x1, (%rsi)
18000668e:     	movq	0x3f0(%rsp), %rax
180006696:     	movq	$0x1406f47, 0x18(%rax)  # imm = 0x1406F47
18000669e:     	movq	$0x0, 0x58(%r13)
1800066a6:     	movq	$0x0, 0x50(%r13)
1800066ae:     	movq	$0x0, 0x48(%r13)
1800066b6:     	movq	$0x0, 0x40(%r13)
1800066be:     	movq	$0x0, 0x38(%r13)
1800066c6:     	movq	$0x0, 0x30(%r13)
1800066ce:     	movq	$0x0, 0x28(%r13)
1800066d6:     	movq	$0x0, 0x20(%r13)
1800066de:     	movq	$0x0, 0x18(%r13)
1800066e6:     	movq	$0x0, 0x10(%r13)
1800066ee:     	movq	$0x0, 0x8(%r13)
1800066f6:     	movq	$0x0, (%r13)
1800066fe:     	jmp	0x180005d5d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a8d>
180006703:     	movq	0x3f0(%rsp), %rcx
18000670b:     	movq	(%rcx), %rcx
18000670e:     	leaq	0x6(%rcx), %rdx
180006712:     	cmpq	0x3c0(%rsp), %rdx
18000671a:     	jle	0x18000678b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x34bb>
18000671c:     	movb	$0x2, (%rsi)
18000671f:     	movq	0x140(%rsp), %rax
180006727:     	movq	$0x0, 0x58(%rax)
18000672f:     	movq	$0x0, 0x50(%rax)
180006737:     	movq	$0x0, 0x48(%rax)
18000673f:     	movq	$0x0, 0x40(%rax)
180006747:     	movq	$0x0, 0x38(%rax)
18000674f:     	movq	$0x0, 0x30(%rax)
180006757:     	movq	$0x0, 0x28(%rax)
18000675f:     	movq	$0x0, 0x20(%rax)
180006767:     	movq	$0x0, 0x18(%rax)
18000676f:     	movq	$0x0, 0x10(%rax)
180006777:     	movq	$0x0, 0x8(%rax)
18000677f:     	movq	$0x0, (%rax)
180006786:     	jmp	0x180005d5d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2a8d>
18000678b:     	movsd	(%r15,%rax,8), %xmm1
180006791:     	movsd	0x10(%r15,%rax,8), %xmm2
180006798:     	movsd	0x20(%r15,%rax,8), %xmm3
18000679f:     	movq	0x3f0(%rsp), %rax
1800067a7:     	movq	%rdx, (%rax)
1800067aa:     	cmpb	$0x0, (%rsi)
1800067ad:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
1800067b3:     	movsd	0x3c2d(%rip), %xmm4     # 0x18000a3e8
1800067bb:     	divsd	%xmm0, %xmm4
1800067bf:     	mulsd	%xmm4, %xmm1
1800067c3:     	mulsd	%xmm4, %xmm2
1800067c7:     	mulsd	%xmm3, %xmm4
1800067cb:     	movsd	%xmm1, (%r15,%rcx,8)
1800067d1:     	movsd	%xmm2, 0x10(%r15,%rcx,8)
1800067d8:     	movsd	%xmm4, 0x20(%r15,%rcx,8)
1800067df:     	cmpb	$0x0, (%rsi)
1800067e2:     	jne	0x18000671f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x344f>
1800067e8:     	jmp	0x1800061ac <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x2edc>
1800067ed:     	int3
1800067ee:     	int3
1800067ef:     	int3
1800067f0:     	pushq	%rbx
1800067f2:     	subq	$0x20, %rsp
1800067f6:     	movq	%rcx, %rbx
1800067f9:     	callq	*0x38f1(%rip)           # 0x18000a0f0
1800067ff:     	movl	%eax, (%rbx)
180006801:     	addq	$0x20, %rsp
180006805:     	popq	%rbx
180006806:     	retq
180006807:     	int3
180006808:     	int3
180006809:     	int3
18000680a:     	int3
18000680b:     	int3
18000680c:     	int3
18000680d:     	int3
18000680e:     	int3
18000680f:     	int3
180006810:     	movl	(%rcx), %ecx
180006812:     	jmpq	*0x3a07(%rip)           # 0x18000a220
180006819:     	int3
18000681a:     	int3
18000681b:     	int3
18000681c:     	int3
18000681d:     	int3
18000681e:     	int3
18000681f:     	int3
180006820:     	pushq	%rbp
180006822:     	pushq	%rbx
180006823:     	pushq	%rsi
180006824:     	pushq	%rdi
180006825:     	pushq	%r14
180006827:     	pushq	%r15
180006829:     	movq	%rsp, %rbp
18000682c:     	subq	$0x48, %rsp
180006830:     	movq	0x39b9(%rip), %rax      # 0x18000a1f0
180006837:     	xorl	%r15d, %r15d
18000683a:     	movq	%rcx, %rsi
18000683d:     	movq	%r15, 0x38(%rbp)
180006841:     	movl	%r15d, %r14d
180006844:     	movq	%r15, 0x50(%rbp)
180006848:     	movq	%r15, 0x48(%rbp)
18000684c:     	cmpq	%rax, 0x8(%rcx)
180006850:     	jne	0x1800069be <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36ee>
180006856:     	leaq	0x48(%rbp), %rax
18000685a:     	leaq	0x50(%rbp), %r9
18000685e:     	movq	%rax, 0x20(%rsp)
180006863:     	leaq	0x38(%rbp), %r8
180006867:     	leaq	0x42f6(%rip), %rdx      # 0x18000ab64
18000686e:     	callq	*0x38bc(%rip)           # 0x18000a130
180006874:     	testl	%eax, %eax
180006876:     	jne	0x1800069b4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36e4>
18000687c:     	movq	0x48(%rbp), %rbx
180006880:     	testq	%rbx, %rbx
180006883:     	je	0x1800069a5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36d5>
180006889:     	cmpq	0x3a50(%rip), %rbx      # 0x18000a2e0
180006890:     	je	0x1800069a5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36d5>
180006896:     	movq	0x8(%rbx), %rax
18000689a:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
1800068a4:     	je	0x1800069a5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36d5>
1800068aa:     	movq	0x20(%rbx), %rcx
1800068ae:     	callq	*0x38dc(%rip)           # 0x18000a190
1800068b4:     	movq	0x28(%rbx), %rcx
1800068b8:     	movq	%rax, %rdi
1800068bb:     	callq	*0x38cf(%rip)           # 0x18000a190
1800068c1:     	movq	0x30(%rbx), %rcx
1800068c5:     	movq	%rax, %r14
1800068c8:     	callq	*0x38d2(%rip)           # 0x18000a1a0
1800068ce:     	leaq	-0x10(%rbp), %r8
1800068d2:     	movl	%eax, %ebx
1800068d4:     	leaq	-0x18(%rbp), %rdx
1800068d8:     	leaq	0x40(%rbp), %rcx
1800068dc:     	callq	*0x38ce(%rip)           # 0x18000a1b0
1800068e2:     	callq	*0x3888(%rip)           # 0x18000a170
1800068e8:     	movq	%rax, %rsi
1800068eb:     	testq	%rax, %rax
1800068ee:     	je	0x18000699b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36cb>
1800068f4:     	movl	%ebx, %r8d
1800068f7:     	movq	%rdi, %rdx
1800068fa:     	movq	%r14, %rcx
1800068fd:     	callq	*0x3965(%rip)           # 0x18000a268
180006903:     	movq	%rax, %rdi
180006906:     	testq	%rax, %rax
180006909:     	je	0x18000699b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36cb>
18000690f:     	callq	*0x3963(%rip)           # 0x18000a278
180006915:     	xorl	%r9d, %r9d
180006918:     	movq	%rsi, %r8
18000691b:     	movq	%rax, %rcx
18000691e:     	movq	%rdi, %rdx
180006921:     	callq	*0x3929(%rip)           # 0x18000a250
180006927:     	movl	(%rsi), %ecx
180006929:     	movq	%rax, %rbx
18000692c:     	testl	%ecx, %ecx
18000692e:     	js	0x180006940 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3670>
180006930:     	subl	$0x1, %ecx
180006933:     	movl	%ecx, (%rsi)
180006935:     	jne	0x180006940 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3670>
180006937:     	movq	%rsi, %rcx
18000693a:     	callq	*0x3898(%rip)           # 0x18000a1d8
180006940:     	movl	(%rdi), %eax
180006942:     	testl	%eax, %eax
180006944:     	js	0x180006956 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3686>
180006946:     	subl	$0x1, %eax
180006949:     	movl	%eax, (%rdi)
18000694b:     	jne	0x180006956 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3686>
18000694d:     	movq	%rdi, %rcx
180006950:     	callq	*0x3882(%rip)           # 0x18000a1d8
180006956:     	testq	%rbx, %rbx
180006959:     	je	0x18000699b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36cb>
18000695b:     	movq	-0x10(%rbp), %r8
18000695f:     	movq	-0x18(%rbp), %rdx
180006963:     	movq	0x40(%rbp), %rcx
180006967:     	callq	*0x3873(%rip)           # 0x18000a1e0
18000696d:     	movq	%rbx, %rcx
180006970:     	callq	*0x38c2(%rip)           # 0x18000a238
180006976:     	movl	(%rbx), %eax
180006978:     	testl	%eax, %eax
18000697a:     	js	0x1800069a5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36d5>
18000697c:     	subl	$0x1, %eax
18000697f:     	movl	%eax, (%rbx)
180006981:     	jne	0x1800069a5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36d5>
180006983:     	movq	%rbx, %rcx
180006986:     	callq	*0x384c(%rip)           # 0x18000a1d8
18000698c:     	xorl	%eax, %eax
18000698e:     	addq	$0x48, %rsp
180006992:     	popq	%r15
180006994:     	popq	%r14
180006996:     	popq	%rdi
180006997:     	popq	%rsi
180006998:     	popq	%rbx
180006999:     	popq	%rbp
18000699a:     	retq
18000699b:     	movq	0x40(%rbp), %rcx
18000699f:     	callq	*0x386b(%rip)           # 0x18000a210
1800069a5:     	xorl	%eax, %eax
1800069a7:     	addq	$0x48, %rsp
1800069ab:     	popq	%r15
1800069ad:     	popq	%r14
1800069af:     	popq	%rdi
1800069b0:     	popq	%rsi
1800069b1:     	popq	%rbx
1800069b2:     	popq	%rbp
1800069b3:     	retq
1800069b4:     	movq	0x38(%rbp), %rbx
1800069b8:     	movq	0x50(%rbp), %r14
1800069bc:     	jmp	0x1800069c5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x36f5>
1800069be:     	movq	%rsi, %rbx
1800069c1:     	movq	%rbx, 0x38(%rbp)
1800069c5:     	cmpq	0x3914(%rip), %rbx      # 0x18000a2e0
1800069cc:     	jne	0x180006a64 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3794>
1800069d2:     	leaq	-0x18(%rbp), %r8
1800069d6:     	leaq	-0x10(%rbp), %rdx
1800069da:     	leaq	0x40(%rbp), %rcx
1800069de:     	callq	*0x373c(%rip)           # 0x18000a120
1800069e4:     	movq	0x38f5(%rip), %rax      # 0x18000a2e0
1800069eb:     	cmpq	%rax, 0x40(%rbp)
1800069ef:     	jne	0x180006a04 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3734>
1800069f1:     	movq	0x38c8(%rip), %rcx      # 0x18000a2c0
1800069f8:     	leaq	0x4119(%rip), %rdx      # 0x18000ab18
1800069ff:     	jmp	0x180006b25 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3855>
180006a04:     	movq	0x40(%rbp), %rcx
180006a08:     	testq	%rcx, %rcx
180006a0b:     	je	0x180006a1a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x374a>
180006a0d:     	movl	(%rcx), %eax
180006a0f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006a14:     	jae	0x180006a1a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x374a>
180006a16:     	incl	%eax
180006a18:     	movl	%eax, (%rcx)
180006a1a:     	movq	-0x10(%rbp), %rcx
180006a1e:     	testq	%rcx, %rcx
180006a21:     	je	0x180006a30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3760>
180006a23:     	movl	(%rcx), %eax
180006a25:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006a2a:     	jae	0x180006a30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3760>
180006a2c:     	incl	%eax
180006a2e:     	movl	%eax, (%rcx)
180006a30:     	movq	-0x18(%rbp), %r8
180006a34:     	testq	%r8, %r8
180006a37:     	je	0x180006a4c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x377c>
180006a39:     	movl	(%r8), %eax
180006a3c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006a41:     	jae	0x180006a4c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x377c>
180006a43:     	incl	%eax
180006a45:     	movl	%eax, (%r8)
180006a48:     	movq	-0x18(%rbp), %r8
180006a4c:     	movq	-0x10(%rbp), %rdx
180006a50:     	movq	0x40(%rbp), %rcx
180006a54:     	callq	*0x3786(%rip)           # 0x18000a1e0
180006a5a:     	movl	$0x1, %ebx
180006a5f:     	jmp	0x180006b31 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3861>
180006a64:     	movq	0x8(%rbx), %rcx
180006a68:     	movl	0xa8(%rcx), %eax
180006a6e:     	testl	%eax, %eax
180006a70:     	jns	0x180006b06 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3836>
180006a76:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180006a80:     	je	0x180006b06 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3836>
180006a86:     	movq	%r14, %rdx
180006a89:     	movq	%rbx, %rcx
180006a8c:     	callq	*0x367e(%rip)           # 0x18000a110
180006a92:     	movq	%rax, %rdi
180006a95:     	testq	%rax, %rax
180006a98:     	je	0x180006b2e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x385e>
180006a9e:     	movq	0x8(%rax), %rax
180006aa2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
180006aac:     	jne	0x180006add <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x380d>
180006aae:     	movq	0x37fb(%rip), %rcx      # 0x18000a2b0
180006ab5:     	leaq	0x407c(%rip), %rdx      # 0x18000ab38
180006abc:     	movq	(%rcx), %rcx
180006abf:     	callq	*0x37f3(%rip)           # 0x18000a2b8
180006ac5:     	movl	(%rdi), %eax
180006ac7:     	testl	%eax, %eax
180006ac9:     	js	0x180006b2e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x385e>
180006acb:     	subl	$0x1, %eax
180006ace:     	movl	%eax, (%rdi)
180006ad0:     	jne	0x180006b2e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x385e>
180006ad2:     	movq	%rdi, %rcx
180006ad5:     	callq	*0x36fd(%rip)           # 0x18000a1d8
180006adb:     	jmp	0x180006b2e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x385e>
180006add:     	movl	(%rdi), %eax
180006adf:     	testl	%eax, %eax
180006ae1:     	js	0x180006af3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3823>
180006ae3:     	subl	$0x1, %eax
180006ae6:     	movl	%eax, (%rdi)
180006ae8:     	jne	0x180006af3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3823>
180006aea:     	movq	%rdi, %rcx
180006aed:     	callq	*0x36e5(%rip)           # 0x18000a1d8
180006af3:     	movq	%r14, %rdx
180006af6:     	movq	%rbx, %rcx
180006af9:     	callq	*0x3771(%rip)           # 0x18000a270
180006aff:     	movl	$0x1, %ebx
180006b04:     	jmp	0x180006b31 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3861>
180006b06:     	btl	$0x1e, %eax
180006b0a:     	jae	0x180006b17 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3847>
180006b0c:     	movq	%rbx, %rdx
180006b0f:     	callq	*0x375b(%rip)           # 0x18000a270
180006b15:     	jmp	0x180006b2e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x385e>
180006b17:     	movq	0x3792(%rip), %rcx      # 0x18000a2b0
180006b1e:     	leaq	0x4013(%rip), %rdx      # 0x18000ab38
180006b25:     	movq	(%rcx), %rcx
180006b28:     	callq	*0x378a(%rip)           # 0x18000a2b8
180006b2e:     	movl	%r15d, %ebx
180006b31:     	movq	0x48(%rbp), %rdi
180006b35:     	testq	%rdi, %rdi
180006b38:     	je	0x180006c5b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x398b>
180006b3e:     	cmpq	0x379b(%rip), %rdi      # 0x18000a2e0
180006b45:     	je	0x180006c5b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x398b>
180006b4b:     	movq	0x8(%rdi), %rax
180006b4f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006b59:     	je	0x180006c5b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x398b>
180006b5f:     	movq	0x20(%rdi), %rcx
180006b63:     	movq	%r12, 0x40(%rsp)
180006b68:     	callq	*0x3622(%rip)           # 0x18000a190
180006b6e:     	movq	0x28(%rdi), %rcx
180006b72:     	movq	%rax, %r14
180006b75:     	callq	*0x3615(%rip)           # 0x18000a190
180006b7b:     	movq	0x30(%rdi), %rcx
180006b7f:     	movq	%rax, %r12
180006b82:     	callq	*0x3618(%rip)           # 0x18000a1a0
180006b88:     	leaq	-0x10(%rbp), %r8
180006b8c:     	movl	%eax, %edi
180006b8e:     	leaq	-0x18(%rbp), %rdx
180006b92:     	leaq	0x40(%rbp), %rcx
180006b96:     	callq	*0x3614(%rip)           # 0x18000a1b0
180006b9c:     	callq	*0x35ce(%rip)           # 0x18000a170
180006ba2:     	movq	%rax, %r15
180006ba5:     	testq	%rax, %rax
180006ba8:     	je	0x180006c4c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x397c>
180006bae:     	movl	%edi, %r8d
180006bb1:     	movq	%r14, %rdx
180006bb4:     	movq	%r12, %rcx
180006bb7:     	callq	*0x36ab(%rip)           # 0x18000a268
180006bbd:     	movq	%rax, %r14
180006bc0:     	testq	%rax, %rax
180006bc3:     	je	0x180006c4c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x397c>
180006bc9:     	callq	*0x36a9(%rip)           # 0x18000a278
180006bcf:     	xorl	%r9d, %r9d
180006bd2:     	movq	%r15, %r8
180006bd5:     	movq	%rax, %rcx
180006bd8:     	movq	%r14, %rdx
180006bdb:     	callq	*0x366f(%rip)           # 0x18000a250
180006be1:     	movl	(%r15), %ecx
180006be4:     	movq	%rax, %rdi
180006be7:     	testl	%ecx, %ecx
180006be9:     	js	0x180006bfc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x392c>
180006beb:     	subl	$0x1, %ecx
180006bee:     	movl	%ecx, (%r15)
180006bf1:     	jne	0x180006bfc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x392c>
180006bf3:     	movq	%r15, %rcx
180006bf6:     	callq	*0x35dc(%rip)           # 0x18000a1d8
180006bfc:     	movl	(%r14), %eax
180006bff:     	testl	%eax, %eax
180006c01:     	js	0x180006c14 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3944>
180006c03:     	subl	$0x1, %eax
180006c06:     	movl	%eax, (%r14)
180006c09:     	jne	0x180006c14 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3944>
180006c0b:     	movq	%r14, %rcx
180006c0e:     	callq	*0x35c4(%rip)           # 0x18000a1d8
180006c14:     	testq	%rdi, %rdi
180006c17:     	je	0x180006c4c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x397c>
180006c19:     	movq	-0x10(%rbp), %r8
180006c1d:     	movq	-0x18(%rbp), %rdx
180006c21:     	movq	0x40(%rbp), %rcx
180006c25:     	callq	*0x35b5(%rip)           # 0x18000a1e0
180006c2b:     	movq	%rdi, %rcx
180006c2e:     	callq	*0x3604(%rip)           # 0x18000a238
180006c34:     	movl	(%rdi), %eax
180006c36:     	testl	%eax, %eax
180006c38:     	js	0x180006c56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3986>
180006c3a:     	subl	$0x1, %eax
180006c3d:     	movl	%eax, (%rdi)
180006c3f:     	jne	0x180006c56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3986>
180006c41:     	movq	%rdi, %rcx
180006c44:     	callq	*0x358e(%rip)           # 0x18000a1d8
180006c4a:     	jmp	0x180006c56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3986>
180006c4c:     	movq	0x40(%rbp), %rcx
180006c50:     	callq	*0x35ba(%rip)           # 0x18000a210
180006c56:     	movq	0x40(%rsp), %r12
180006c5b:     	movl	(%rsi), %ecx
180006c5d:     	testl	%ecx, %ecx
180006c5f:     	js	0x180006c71 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a1>
180006c61:     	subl	$0x1, %ecx
180006c64:     	movl	%ecx, (%rsi)
180006c66:     	jne	0x180006c71 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x39a1>
180006c68:     	movq	%rsi, %rcx
180006c6b:     	callq	*0x3567(%rip)           # 0x18000a1d8
180006c71:     	movl	%ebx, %eax
180006c73:     	addq	$0x48, %rsp
180006c77:     	popq	%r15
180006c79:     	popq	%r14
180006c7b:     	popq	%rdi
180006c7c:     	popq	%rsi
180006c7d:     	popq	%rbx
180006c7e:     	popq	%rbp
180006c7f:     	retq
180006c80:     	movq	%rbx, 0x8(%rsp)
180006c85:     	movq	%rsi, 0x10(%rsp)
180006c8a:     	pushq	%rdi
180006c8b:     	subq	$0x20, %rsp
180006c8f:     	cmpq	$0x0, 0xafc1(%rip)      # 0x180011c58
180006c97:     	movq	%rcx, %rsi
180006c9a:     	movslq	%edx, %rdi
180006c9d:     	jne	0x180006ced <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a1d>
180006c9f:     	leaq	0x3ec2(%rip), %rcx      # 0x18000ab68
180006ca6:     	callq	*0x359c(%rip)           # 0x18000a248
180006cac:     	movq	%rax, %rbx
180006caf:     	testq	%rax, %rax
180006cb2:     	je	0x180006d01 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a31>
180006cb4:     	leaq	0x3eb5(%rip), %rdx      # 0x18000ab70
180006cbb:     	movq	%rax, %rcx
180006cbe:     	callq	*0x34b4(%rip)           # 0x18000a178
180006cc4:     	movl	(%rbx), %ecx
180006cc6:     	movq	%rax, 0xaf8b(%rip)      # 0x180011c58
180006ccd:     	testl	%ecx, %ecx
180006ccf:     	js	0x180006ce8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a18>
180006cd1:     	subl	$0x1, %ecx
180006cd4:     	movl	%ecx, (%rbx)
180006cd6:     	jne	0x180006ce8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a18>
180006cd8:     	movq	%rbx, %rcx
180006cdb:     	callq	*0x34f7(%rip)           # 0x18000a1d8
180006ce1:     	movq	0xaf70(%rip), %rax      # 0x180011c58
180006ce8:     	testq	%rax, %rax
180006ceb:     	je	0x180006d01 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a31>
180006ced:     	movq	%rdi, %rdx
180006cf0:     	movq	%rsi, %rcx
180006cf3:     	callq	*0x35cf(%rip)           # 0x18000a2c8
180006cf9:     	movq	%rax, %rbx
180006cfc:     	testq	%rax, %rax
180006cff:     	jne	0x180006d13 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a43>
180006d01:     	xorl	%eax, %eax
180006d03:     	movq	0x30(%rsp), %rbx
180006d08:     	movq	0x38(%rsp), %rsi
180006d0d:     	addq	$0x20, %rsp
180006d11:     	popq	%rdi
180006d12:     	retq
180006d13:     	movq	0xaf3e(%rip), %rcx      # 0x180011c58
180006d1a:     	xorl	%r8d, %r8d
180006d1d:     	movq	%rbx, %rdx
180006d20:     	callq	*0x3482(%rip)           # 0x18000a1a8
180006d26:     	movl	(%rbx), %ecx
180006d28:     	movq	%rax, %rdi
180006d2b:     	testl	%ecx, %ecx
180006d2d:     	js	0x180006d3f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a6f>
180006d2f:     	subl	$0x1, %ecx
180006d32:     	movl	%ecx, (%rbx)
180006d34:     	jne	0x180006d3f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3a6f>
180006d36:     	movq	%rbx, %rcx
180006d39:     	callq	*0x3499(%rip)           # 0x18000a1d8
180006d3f:     	movq	0x30(%rsp), %rbx
180006d44:     	movq	%rdi, %rax
180006d47:     	movq	0x38(%rsp), %rsi
180006d4c:     	addq	$0x20, %rsp
180006d50:     	popq	%rdi
180006d51:     	retq
180006d52:     	int3
180006d53:     	int3
180006d54:     	int3
180006d55:     	int3
180006d56:     	int3
180006d57:     	int3
180006d58:     	int3
180006d59:     	int3
180006d5a:     	int3
180006d5b:     	int3
180006d5c:     	int3
180006d5d:     	int3
180006d5e:     	int3
180006d5f:     	int3
180006d60:     	movq	%rbx, 0x8(%rsp)
180006d65:     	movq	%rsi, 0x10(%rsp)
180006d6a:     	pushq	%rdi
180006d6b:     	subq	$0x20, %rsp
180006d6f:     	movq	0xaeda(%rip), %rax      # 0x180011c50
180006d76:     	movq	%rdx, %rdi
180006d79:     	movq	%rcx, %rsi
180006d7c:     	testq	%rax, %rax
180006d7f:     	jne	0x180006de1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3b11>
180006d81:     	leaq	0x3df0(%rip), %rcx      # 0x18000ab78
180006d88:     	callq	*0x34ba(%rip)           # 0x18000a248
180006d8e:     	movq	%rax, %rbx
180006d91:     	testq	%rax, %rax
180006d94:     	je	0x180006dcf <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3aff>
180006d96:     	leaq	0x3df3(%rip), %rdx      # 0x18000ab90
180006d9d:     	movq	%rax, %rcx
180006da0:     	callq	*0x33d2(%rip)           # 0x18000a178
180006da6:     	movl	(%rbx), %ecx
180006da8:     	movq	%rax, 0xaea1(%rip)      # 0x180011c50
180006daf:     	testl	%ecx, %ecx
180006db1:     	js	0x180006dca <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3afa>
180006db3:     	subl	$0x1, %ecx
180006db6:     	movl	%ecx, (%rbx)
180006db8:     	jne	0x180006dca <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3afa>
180006dba:     	movq	%rbx, %rcx
180006dbd:     	callq	*0x3415(%rip)           # 0x18000a1d8
180006dc3:     	movq	0xae86(%rip), %rax      # 0x180011c50
180006dca:     	testq	%rax, %rax
180006dcd:     	jne	0x180006de1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3b11>
180006dcf:     	xorl	%eax, %eax
180006dd1:     	movq	0x30(%rsp), %rbx
180006dd6:     	movq	0x38(%rsp), %rsi
180006ddb:     	addq	$0x20, %rsp
180006ddf:     	popq	%rdi
180006de0:     	retq
180006de1:     	xorl	%r9d, %r9d
180006de4:     	movq	%rdi, %r8
180006de7:     	movq	%rsi, %rdx
180006dea:     	movq	%rax, %rcx
180006ded:     	movq	0x30(%rsp), %rbx
180006df2:     	movq	0x38(%rsp), %rsi
180006df7:     	addq	$0x20, %rsp
180006dfb:     	popq	%rdi
180006dfc:     	jmpq	*0x33a5(%rip)           # 0x18000a1a8
180006e03:     	int3
180006e04:     	int3
180006e05:     	int3
180006e06:     	int3
180006e07:     	int3
180006e08:     	int3
180006e09:     	int3
180006e0a:     	int3
180006e0b:     	int3
180006e0c:     	int3
180006e0d:     	int3
180006e0e:     	int3
180006e0f:     	int3
180006e10:     	movq	%rbx, 0x8(%rsp)
180006e15:     	movq	%rsi, 0x10(%rsp)
180006e1a:     	pushq	%rdi
180006e1b:     	subq	$0x20, %rsp
180006e1f:     	movq	%rcx, %rbx
180006e22:     	movq	%r8, %rdi
180006e25:     	movq	0x10(%rcx), %rcx
180006e29:     	movq	%rdx, %rsi
180006e2c:     	testq	%rcx, %rcx
180006e2f:     	je	0x180006e3a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3b6a>
180006e31:     	movq	%r8, %rdx
180006e34:     	callq	*%rsi
180006e36:     	testl	%eax, %eax
180006e38:     	jne	0x180006e5d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3b8d>
180006e3a:     	movq	0x18(%rbx), %rcx
180006e3e:     	testq	%rcx, %rcx
180006e41:     	je	0x180006e5b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3b8b>
180006e43:     	movq	%rdi, %rdx
180006e46:     	movq	%rsi, %rax
180006e49:     	movq	0x30(%rsp), %rbx
180006e4e:     	movq	0x38(%rsp), %rsi
180006e53:     	addq	$0x20, %rsp
180006e57:     	popq	%rdi
180006e58:     	jmpq	*%rax
180006e5b:     	xorl	%eax, %eax
180006e5d:     	movq	0x30(%rsp), %rbx
180006e62:     	movq	0x38(%rsp), %rsi
180006e67:     	addq	$0x20, %rsp
180006e6b:     	popq	%rdi
180006e6c:     	retq
180006e6d:     	int3
180006e6e:     	int3
180006e6f:     	int3
180006e70:     	pushq	%rbx
180006e72:     	subq	$0x20, %rsp
180006e76:     	movq	%rcx, %rbx
180006e79:     	movq	0x10(%rcx), %rcx
180006e7d:     	testq	%rcx, %rcx
180006e80:     	je	0x180006e9d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bcd>
180006e82:     	movq	$0x0, 0x10(%rbx)
180006e8a:     	movl	(%rcx), %eax
180006e8c:     	testl	%eax, %eax
180006e8e:     	js	0x180006e9d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bcd>
180006e90:     	subl	$0x1, %eax
180006e93:     	movl	%eax, (%rcx)
180006e95:     	jne	0x180006e9d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bcd>
180006e97:     	callq	*0x333b(%rip)           # 0x18000a1d8
180006e9d:     	movq	0x18(%rbx), %rcx
180006ea1:     	testq	%rcx, %rcx
180006ea4:     	je	0x180006ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bf1>
180006ea6:     	movq	$0x0, 0x18(%rbx)
180006eae:     	movl	(%rcx), %eax
180006eb0:     	testl	%eax, %eax
180006eb2:     	js	0x180006ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bf1>
180006eb4:     	subl	$0x1, %eax
180006eb7:     	movl	%eax, (%rcx)
180006eb9:     	jne	0x180006ec1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3bf1>
180006ebb:     	callq	*0x3317(%rip)           # 0x18000a1d8
180006ec1:     	xorl	%eax, %eax
180006ec3:     	addq	$0x20, %rsp
180006ec7:     	popq	%rbx
180006ec8:     	retq
180006ec9:     	int3
180006eca:     	int3
180006ecb:     	int3
180006ecc:     	int3
180006ecd:     	int3
180006ece:     	int3
180006ecf:     	int3
180006ed0:     	pushq	%rbx
180006ed2:     	subq	$0x20, %rsp
180006ed6:     	movq	%rcx, %rbx
180006ed9:     	callq	*0x3349(%rip)           # 0x18000a228
180006edf:     	movq	0x10(%rbx), %rcx
180006ee3:     	testq	%rcx, %rcx
180006ee6:     	je	0x180006f03 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c33>
180006ee8:     	movq	$0x0, 0x10(%rbx)
180006ef0:     	movl	(%rcx), %eax
180006ef2:     	testl	%eax, %eax
180006ef4:     	js	0x180006f03 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c33>
180006ef6:     	subl	$0x1, %eax
180006ef9:     	movl	%eax, (%rcx)
180006efb:     	jne	0x180006f03 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c33>
180006efd:     	callq	*0x32d5(%rip)           # 0x18000a1d8
180006f03:     	movq	0x18(%rbx), %rcx
180006f07:     	testq	%rcx, %rcx
180006f0a:     	je	0x180006f27 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c57>
180006f0c:     	movq	$0x0, 0x18(%rbx)
180006f14:     	movl	(%rcx), %eax
180006f16:     	testl	%eax, %eax
180006f18:     	js	0x180006f27 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c57>
180006f1a:     	subl	$0x1, %eax
180006f1d:     	movl	%eax, (%rcx)
180006f1f:     	jne	0x180006f27 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3c57>
180006f21:     	callq	*0x32b1(%rip)           # 0x18000a1d8
180006f27:     	movq	0x8(%rbx), %rax
180006f2b:     	movq	%rbx, %rcx
180006f2e:     	addq	$0x20, %rsp
180006f32:     	popq	%rbx
180006f33:     	jmpq	*0x140(%rax)
180006f3a:     	int3
180006f3b:     	int3
180006f3c:     	int3
180006f3d:     	int3
180006f3e:     	int3
180006f3f:     	int3
180006f40:     	pushq	%rbx
180006f42:     	subq	$0x30, %rsp
180006f46:     	movq	%r8, %r10
180006f49:     	leaq	0x58(%rsp), %rax
180006f4e:     	movq	%rax, 0x28(%rsp)
180006f53:     	leaq	0xaa36(%rip), %r9       # 0x180011990
180006f5a:     	movq	0x3297(%rip), %rax      # 0x18000a1f8
180006f61:     	leaq	0x3c58(%rip), %r8       # 0x18000abc0
180006f68:     	movq	%rdx, %r11
180006f6b:     	movq	%rax, 0x20(%rsp)
180006f70:     	movq	%rcx, %rbx
180006f73:     	movq	%r10, %rdx
180006f76:     	movq	%r11, %rcx
180006f79:     	callq	*0x3179(%rip)           # 0x18000a0f8
180006f7f:     	testl	%eax, %eax
180006f81:     	je	0x180006fdc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d0c>
180006f83:     	xorl	%r8d, %r8d
180006f86:     	xorl	%edx, %edx
180006f88:     	movq	%rbx, %rcx
180006f8b:     	callq	*0x32c7(%rip)           # 0x18000a258
180006f91:     	movq	%rax, %rbx
180006f94:     	testq	%rax, %rax
180006f97:     	je	0x180006fdc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d0c>
180006f99:     	movq	0x58(%rsp), %rax
180006f9e:     	movl	(%rax), %ecx
180006fa0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180006fa6:     	jae	0x180006fb1 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ce1>
180006fa8:     	incl	%ecx
180006faa:     	movl	%ecx, (%rax)
180006fac:     	movq	0x58(%rsp), %rax
180006fb1:     	xorl	%ecx, %ecx
180006fb3:     	movq	%rax, 0x10(%rbx)
180006fb7:     	callq	*0x31cb(%rip)           # 0x18000a188
180006fbd:     	movq	%rax, 0x18(%rbx)
180006fc1:     	testq	%rax, %rax
180006fc4:     	jne	0x180006fe4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d14>
180006fc6:     	movl	(%rbx), %eax
180006fc8:     	testl	%eax, %eax
180006fca:     	js	0x180006fdc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d0c>
180006fcc:     	subl	$0x1, %eax
180006fcf:     	movl	%eax, (%rbx)
180006fd1:     	jne	0x180006fdc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d0c>
180006fd3:     	movq	%rbx, %rcx
180006fd6:     	callq	*0x31fc(%rip)           # 0x18000a1d8
180006fdc:     	xorl	%eax, %eax
180006fde:     	addq	$0x30, %rsp
180006fe2:     	popq	%rbx
180006fe3:     	retq
180006fe4:     	movq	%rbx, %rax
180006fe7:     	addq	$0x30, %rsp
180006feb:     	popq	%rbx
180006fec:     	retq
180006fed:     	int3
180006fee:     	int3
180006fef:     	int3
180006ff0:     	movq	%rbx, 0x8(%rsp)
180006ff5:     	movq	%rsi, 0x10(%rsp)
180006ffa:     	pushq	%rdi
180006ffb:     	subq	$0x20, %rsp
180006fff:     	movq	%rcx, %rbx
180007002:     	movq	%r8, %rdi
180007005:     	movq	0x18(%rcx), %rcx
180007009:     	movq	%rdx, %rsi
18000700c:     	testq	%rcx, %rcx
18000700f:     	je	0x18000701a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d4a>
180007011:     	movq	%r8, %rdx
180007014:     	callq	*%rsi
180007016:     	testl	%eax, %eax
180007018:     	jne	0x18000703d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d6d>
18000701a:     	movq	0x40(%rbx), %rcx
18000701e:     	testq	%rcx, %rcx
180007021:     	je	0x18000703b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d6b>
180007023:     	movq	%rdi, %rdx
180007026:     	movq	%rsi, %rax
180007029:     	movq	0x30(%rsp), %rbx
18000702e:     	movq	0x38(%rsp), %rsi
180007033:     	addq	$0x20, %rsp
180007037:     	popq	%rdi
180007038:     	jmpq	*%rax
18000703b:     	xorl	%eax, %eax
18000703d:     	movq	0x30(%rsp), %rbx
180007042:     	movq	0x38(%rsp), %rsi
180007047:     	addq	$0x20, %rsp
18000704b:     	popq	%rdi
18000704c:     	retq
18000704d:     	int3
18000704e:     	int3
18000704f:     	int3
180007050:     	pushq	%rbx
180007052:     	subq	$0x20, %rsp
180007056:     	movq	%rcx, %rbx
180007059:     	callq	*0x31c9(%rip)           # 0x18000a228
18000705f:     	cmpq	$0x0, 0x48(%rbx)
180007064:     	je	0x18000706f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3d9f>
180007066:     	movq	%rbx, %rcx
180007069:     	callq	*0x3129(%rip)           # 0x18000a198
18000706f:     	movq	0x20(%rbx), %rcx
180007073:     	callq	*0x314f(%rip)           # 0x18000a1c8
180007079:     	movq	0x38(%rbx), %rcx
18000707d:     	callq	*0x3145(%rip)           # 0x18000a1c8
180007083:     	movq	0x18(%rbx), %rcx
180007087:     	testq	%rcx, %rcx
18000708a:     	je	0x18000709f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3dcf>
18000708c:     	movl	(%rcx), %eax
18000708e:     	testl	%eax, %eax
180007090:     	js	0x18000709f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3dcf>
180007092:     	subl	$0x1, %eax
180007095:     	movl	%eax, (%rcx)
180007097:     	jne	0x18000709f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3dcf>
180007099:     	callq	*0x3139(%rip)           # 0x18000a1d8
18000709f:     	movq	0x40(%rbx), %rcx
1800070a3:     	testq	%rcx, %rcx
1800070a6:     	je	0x1800070bb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3deb>
1800070a8:     	movl	(%rcx), %eax
1800070aa:     	testl	%eax, %eax
1800070ac:     	js	0x1800070bb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3deb>
1800070ae:     	subl	$0x1, %eax
1800070b1:     	movl	%eax, (%rcx)
1800070b3:     	jne	0x1800070bb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3deb>
1800070b5:     	callq	*0x311d(%rip)           # 0x18000a1d8
1800070bb:     	movq	0x8(%rbx), %rax
1800070bf:     	movq	%rbx, %rcx
1800070c2:     	addq	$0x20, %rsp
1800070c6:     	popq	%rbx
1800070c7:     	jmpq	*0x140(%rax)
1800070ce:     	int3
1800070cf:     	int3
1800070d0:     	pushq	%rbx
1800070d2:     	subq	$0x20, %rsp
1800070d6:     	callq	*0x30b4(%rip)           # 0x18000a190
1800070dc:     	movq	%rax, %rbx
1800070df:     	testq	%rax, %rax
1800070e2:     	jne	0x1800070ea <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3e1a>
1800070e4:     	addq	$0x20, %rsp
1800070e8:     	popq	%rbx
1800070e9:     	retq
1800070ea:     	movq	%rbx, %rcx
1800070ed:     	movq	%rdi, 0x30(%rsp)
1800070f2:     	callq	0x18000944d <numba_list_iter_next+0xecd>
1800070f7:     	leaq	0x1(%rax), %rcx
1800070fb:     	callq	*0x315f(%rip)           # 0x18000a260
180007101:     	movq	%rax, %rdi
180007104:     	testq	%rax, %rax
180007107:     	jne	0x18000711c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3e4c>
180007109:     	callq	*0x3041(%rip)           # 0x18000a150
18000710f:     	movq	0x30(%rsp), %rdi
180007114:     	xorl	%eax, %eax
180007116:     	addq	$0x20, %rsp
18000711a:     	popq	%rbx
18000711b:     	retq
18000711c:     	movq	%rbx, %rdx
18000711f:     	movq	%rdi, %rcx
180007122:     	callq	0x180009447 <numba_list_iter_next+0xec7>
180007127:     	movq	%rdi, %rax
18000712a:     	movq	0x30(%rsp), %rdi
18000712f:     	addq	$0x20, %rsp
180007133:     	popq	%rbx
180007134:     	retq
180007135:     	int3
180007136:     	int3
180007137:     	int3
180007138:     	int3
180007139:     	int3
18000713a:     	int3
18000713b:     	int3
18000713c:     	int3
18000713d:     	int3
18000713e:     	int3
18000713f:     	int3
180007140:     	movq	0x18(%rcx), %rcx
180007144:     	movq	%rdx, %rax
180007147:     	testq	%rcx, %rcx
18000714a:     	je	0x180007152 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3e82>
18000714c:     	movq	%r8, %rdx
18000714f:     	jmpq	*%rax
180007152:     	xorl	%eax, %eax
180007154:     	retq
180007155:     	int3
180007156:     	int3
180007157:     	int3
180007158:     	int3
180007159:     	int3
18000715a:     	int3
18000715b:     	int3
18000715c:     	int3
18000715d:     	int3
18000715e:     	int3
18000715f:     	int3
180007160:     	movq	%rbx, 0x8(%rsp)
180007165:     	pushq	%rdi
180007166:     	subq	$0x20, %rsp
18000716a:     	movq	0x28(%rcx), %rax
18000716e:     	xorl	%edi, %edi
180007170:     	movq	%rcx, %rbx
180007173:     	testq	%rax, %rax
180007176:     	je	0x180007182 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3eb2>
180007178:     	addq	$0x38, %rcx
18000717c:     	callq	*%rax
18000717e:     	movq	%rdi, 0x28(%rbx)
180007182:     	movq	0x18(%rbx), %rcx
180007186:     	testq	%rcx, %rcx
180007189:     	je	0x1800071a2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ed2>
18000718b:     	movq	%rdi, 0x18(%rbx)
18000718f:     	movl	(%rcx), %eax
180007191:     	testl	%eax, %eax
180007193:     	js	0x1800071a2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ed2>
180007195:     	subl	$0x1, %eax
180007198:     	movl	%eax, (%rcx)
18000719a:     	jne	0x1800071a2 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ed2>
18000719c:     	callq	*0x3036(%rip)           # 0x18000a1d8
1800071a2:     	movq	%rdi, 0x20(%rbx)
1800071a6:     	xorl	%eax, %eax
1800071a8:     	movq	0x30(%rsp), %rbx
1800071ad:     	addq	$0x20, %rsp
1800071b1:     	popq	%rdi
1800071b2:     	retq
1800071b3:     	int3
1800071b4:     	int3
1800071b5:     	int3
1800071b6:     	int3
1800071b7:     	int3
1800071b8:     	int3
1800071b9:     	int3
1800071ba:     	int3
1800071bb:     	int3
1800071bc:     	int3
1800071bd:     	int3
1800071be:     	int3
1800071bf:     	int3
1800071c0:     	pushq	%rbx
1800071c2:     	subq	$0x20, %rsp
1800071c6:     	movq	%rcx, %rbx
1800071c9:     	callq	*0x3059(%rip)           # 0x18000a228
1800071cf:     	cmpq	$0x0, 0x30(%rbx)
1800071d4:     	je	0x1800071df <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f0f>
1800071d6:     	movq	%rbx, %rcx
1800071d9:     	callq	*0x2fb9(%rip)           # 0x18000a198
1800071df:     	callq	*0x2f63(%rip)           # 0x18000a148
1800071e5:     	testl	%eax, %eax
1800071e7:     	jne	0x1800071f8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f28>
1800071e9:     	movq	0x28(%rbx), %rax
1800071ed:     	testq	%rax, %rax
1800071f0:     	je	0x1800071f8 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f28>
1800071f2:     	leaq	0x38(%rbx), %rcx
1800071f6:     	callq	*%rax
1800071f8:     	movq	0x18(%rbx), %rcx
1800071fc:     	testq	%rcx, %rcx
1800071ff:     	je	0x180007214 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f44>
180007201:     	movl	(%rcx), %eax
180007203:     	testl	%eax, %eax
180007205:     	js	0x180007214 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f44>
180007207:     	subl	$0x1, %eax
18000720a:     	movl	%eax, (%rcx)
18000720c:     	jne	0x180007214 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f44>
18000720e:     	callq	*0x2fc4(%rip)           # 0x18000a1d8
180007214:     	movq	0x8(%rbx), %rax
180007218:     	movq	%rbx, %rcx
18000721b:     	addq	$0x20, %rsp
18000721f:     	popq	%rbx
180007220:     	jmpq	*0x140(%rax)
180007227:     	int3
180007228:     	int3
180007229:     	int3
18000722a:     	int3
18000722b:     	int3
18000722c:     	int3
18000722d:     	int3
18000722e:     	int3
18000722f:     	int3
180007230:     	pushq	%rdi
180007232:     	subq	$0x20, %rsp
180007236:     	cmpq	$0x0, 0x20(%rcx)
18000723b:     	movq	%rcx, %rdi
18000723e:     	jne	0x18000725f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3f8f>
180007240:     	movq	0x3079(%rip), %rcx      # 0x18000a2c0
180007247:     	leaq	0x39c2(%rip), %rdx      # 0x18000ac10
18000724e:     	movq	(%rcx), %rcx
180007251:     	callq	*0x3061(%rip)           # 0x18000a2b8
180007257:     	xorl	%eax, %eax
180007259:     	addq	$0x20, %rsp
18000725d:     	popq	%rdi
18000725e:     	retq
18000725f:     	movq	%rdi, %rdx
180007262:     	movq	%rbx, 0x30(%rsp)
180007267:     	movl	$0x1, %ecx
18000726c:     	callq	*0x2e96(%rip)           # 0x18000a108
180007272:     	movq	%rax, %rbx
180007275:     	testq	%rax, %rax
180007278:     	jne	0x180007285 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3fb5>
18000727a:     	movq	0x30(%rsp), %rbx
18000727f:     	addq	$0x20, %rsp
180007283:     	popq	%rdi
180007284:     	retq
180007285:     	xorl	%r8d, %r8d
180007288:     	movq	%rbx, %rdx
18000728b:     	movq	%rdi, %rcx
18000728e:     	callq	*0x20(%rdi)
180007291:     	movl	(%rbx), %ecx
180007293:     	movq	%rax, %rdi
180007296:     	testl	%ecx, %ecx
180007298:     	js	0x1800072aa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3fda>
18000729a:     	subl	$0x1, %ecx
18000729d:     	movl	%ecx, (%rbx)
18000729f:     	jne	0x1800072aa <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3fda>
1800072a1:     	movq	%rbx, %rcx
1800072a4:     	callq	*0x2f2e(%rip)           # 0x18000a1d8
1800072aa:     	movq	0x30(%rsp), %rbx
1800072af:     	movq	%rdi, %rax
1800072b2:     	addq	$0x20, %rsp
1800072b6:     	popq	%rdi
1800072b7:     	retq
1800072b8:     	int3
1800072b9:     	int3
1800072ba:     	int3
1800072bb:     	int3
1800072bc:     	int3
1800072bd:     	int3
1800072be:     	int3
1800072bf:     	int3
1800072c0:     	movq	%rbx, 0x8(%rsp)
1800072c5:     	pushq	%rdi
1800072c6:     	subq	$0x20, %rsp
1800072ca:     	movq	%r8, %rbx
1800072cd:     	callq	*0x2e1d(%rip)           # 0x18000a0f0
1800072d3:     	movl	(%rbx), %ecx
1800072d5:     	movl	%eax, %edi
1800072d7:     	testl	%ecx, %ecx
1800072d9:     	js	0x1800072eb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x401b>
1800072db:     	subl	$0x1, %ecx
1800072de:     	movl	%ecx, (%rbx)
1800072e0:     	jne	0x1800072eb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x401b>
1800072e2:     	movq	%rbx, %rcx
1800072e5:     	callq	*0x2eed(%rip)           # 0x18000a1d8
1800072eb:     	movl	%edi, %ecx
1800072ed:     	movq	0x30(%rsp), %rbx
1800072f2:     	addq	$0x20, %rsp
1800072f6:     	popq	%rdi
1800072f7:     	jmpq	*0x2f22(%rip)           # 0x18000a220
1800072fe:     	int3
1800072ff:     	int3
180007300:     	movq	%rbx, 0x8(%rsp)
180007305:     	pushq	%rdi
180007306:     	subq	$0x20, %rsp
18000730a:     	movl	(%rdx), %eax
18000730c:     	movq	%rdx, %rbx
18000730f:     	movq	%rcx, %rdi
180007312:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007317:     	jae	0x18000731d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x404d>
180007319:     	incl	%eax
18000731b:     	movl	%eax, (%rdx)
18000731d:     	movl	$0x30, %ecx
180007322:     	callq	*0xa900(%rip)           # 0x180011c28
180007328:     	cmpb	$0x0, 0xa8d1(%rip)      # 0x180011c00
18000732f:     	je	0x180007339 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4069>
180007331:     	lock
180007332:     	incq	0xa8cf(%rip)            # 0x180011c08
180007339:     	testq	%rax, %rax
18000733c:     	je	0x180007373 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x40a3>
18000733e:     	movl	$0x1, %ecx
180007343:     	leaq	-0x8a(%rip), %rdx       # 0x1800072c0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3ff0>
18000734a:     	xchgq	%rcx, (%rax)
18000734d:     	xorl	%ecx, %ecx
18000734f:     	movq	%rdx, 0x8(%rax)
180007353:     	movq	%rcx, 0x20(%rax)
180007357:     	movq	%rcx, 0x28(%rax)
18000735b:     	movq	%rbx, 0x10(%rax)
18000735f:     	movq	%rdi, 0x18(%rax)
180007363:     	cmpb	%cl, 0xa897(%rip)       # 0x180011c00
180007369:     	je	0x180007373 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x40a3>
18000736b:     	lock
18000736c:     	incq	0xa8a5(%rip)            # 0x180011c18
180007373:     	movq	0x30(%rsp), %rbx
180007378:     	addq	$0x20, %rsp
18000737c:     	popq	%rdi
18000737d:     	retq
18000737e:     	int3
18000737f:     	int3
180007380:     	movq	%rbx, 0x8(%rsp)
180007385:     	pushq	%rdi
180007386:     	subq	$0x30, %rsp
18000738a:     	movq	%rcx, %rdi
18000738d:     	leaq	0xa5ec(%rip), %r9       # 0x180011980
180007394:     	movq	%r8, %rax
180007397:     	leaq	0x58(%rsp), %rcx
18000739c:     	movq	%rdx, %r10
18000739f:     	movq	%rcx, 0x20(%rsp)
1800073a4:     	movq	%r10, %rcx
1800073a7:     	leaq	0x38aa(%rip), %r8       # 0x18000ac58
1800073ae:     	movq	%rax, %rdx
1800073b1:     	callq	*0x2d41(%rip)           # 0x18000a0f8
1800073b7:     	testl	%eax, %eax
1800073b9:     	je	0x1800073e3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4113>
1800073bb:     	movq	0x58(%rsp), %rcx
1800073c0:     	callq	*0x2d7a(%rip)           # 0x18000a140
1800073c6:     	movq	%rax, %rbx
1800073c9:     	callq	*0x2f19(%rip)           # 0x18000a2e8
1800073cf:     	testq	%rax, %rax
1800073d2:     	jne	0x1800073e3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4113>
1800073d4:     	movq	%rbx, 0x10(%rdi)
1800073d8:     	movq	0x40(%rsp), %rbx
1800073dd:     	addq	$0x30, %rsp
1800073e1:     	popq	%rdi
1800073e2:     	retq
1800073e3:     	movq	0x40(%rsp), %rbx
1800073e8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800073ed:     	addq	$0x30, %rsp
1800073f1:     	popq	%rdi
1800073f2:     	retq
1800073f3:     	int3
1800073f4:     	int3
1800073f5:     	int3
1800073f6:     	int3
1800073f7:     	int3
1800073f8:     	int3
1800073f9:     	int3
1800073fa:     	int3
1800073fb:     	int3
1800073fc:     	int3
1800073fd:     	int3
1800073fe:     	int3
1800073ff:     	int3
180007400:     	subq	$0x38, %rsp
180007404:     	movl	%r8d, %eax
180007407:     	movq	%rdx, %r10
18000740a:     	movq	0x10(%rcx), %r8
18000740e:     	movq	%rcx, %rdx
180007411:     	movl	%eax, 0x28(%rsp)
180007415:     	movq	%r10, %rcx
180007418:     	movl	$0x0, 0x20(%rsp)
180007420:     	movq	0x20(%r8), %r9
180007424:     	movq	0x18(%r8), %r8
180007428:     	callq	*0x2dea(%rip)           # 0x18000a218
18000742e:     	addq	$0x38, %rsp
180007432:     	retq
180007433:     	int3
180007434:     	int3
180007435:     	int3
180007436:     	int3
180007437:     	int3
180007438:     	int3
180007439:     	int3
18000743a:     	int3
18000743b:     	int3
18000743c:     	int3
18000743d:     	int3
18000743e:     	int3
18000743f:     	int3
180007440:     	movq	0x10(%rcx), %rax
180007444:     	lock
180007445:     	incq	(%rax)
180007448:     	movq	0x2e91(%rip), %rax      # 0x18000a2e0
18000744f:     	retq
180007450:     	subq	$0x28, %rsp
180007454:     	movq	0x10(%rcx), %rcx
180007458:     	callq	0x180008750 <numba_list_iter_next+0x1d0>
18000745d:     	movq	0x2e7c(%rip), %rax      # 0x18000a2e0
180007464:     	addq	$0x28, %rsp
180007468:     	retq
180007469:     	int3
18000746a:     	int3
18000746b:     	int3
18000746c:     	int3
18000746d:     	int3
18000746e:     	int3
18000746f:     	int3
180007470:     	movq	0x10(%rcx), %rcx
180007474:     	movq	0x18(%rcx), %rcx
180007478:     	jmpq	*0x2ce9(%rip)           # 0x18000a168
18000747f:     	int3
180007480:     	subq	$0x28, %rsp
180007484:     	movq	0x10(%rcx), %rax
180007488:     	testq	%rax, %rax
18000748b:     	je	0x1800074a9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x41d9>
18000748d:     	cmpq	$0x0, 0x18(%rax)
180007492:     	je	0x1800074a9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x41d9>
180007494:     	movq	(%rax), %rcx
180007497:     	nop
180007498:     	cmpq	$-0x1, %rcx
18000749c:     	je	0x1800074a9 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x41d9>
18000749e:     	addq	$0x28, %rsp
1800074a2:     	jmpq	*0x2c7f(%rip)           # 0x18000a128
1800074a9:     	movq	0x2d58(%rip), %rcx      # 0x18000a208
1800074b0:     	leaq	0x37a9(%rip), %rdx      # 0x18000ac60
1800074b7:     	movq	(%rcx), %rcx
1800074ba:     	callq	*0x2df8(%rip)           # 0x18000a2b8
1800074c0:     	xorl	%eax, %eax
1800074c2:     	addq	$0x28, %rsp
1800074c6:     	retq
1800074c7:     	int3
1800074c8:     	int3
1800074c9:     	int3
1800074ca:     	int3
1800074cb:     	int3
1800074cc:     	int3
1800074cd:     	int3
1800074ce:     	int3
1800074cf:     	int3
1800074d0:     	movq	0x10(%rcx), %rcx
1800074d4:     	movq	0x28(%rcx), %rcx
1800074d8:     	jmpq	*0x2c89(%rip)           # 0x18000a168
1800074df:     	int3
1800074e0:     	movq	0x10(%rcx), %rax
1800074e4:     	movq	0x10(%rax), %rax
1800074e8:     	testq	%rax, %rax
1800074eb:     	je	0x1800074fc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x422c>
1800074ed:     	movl	(%rax), %ecx
1800074ef:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800074f5:     	jae	0x18000751a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x424a>
1800074f7:     	incl	%ecx
1800074f9:     	movl	%ecx, (%rax)
1800074fb:     	retq
1800074fc:     	movq	0x2ddd(%rip), %rcx      # 0x18000a2e0
180007503:     	movl	(%rcx), %eax
180007505:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000750a:     	jae	0x180007517 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4247>
18000750c:     	incl	%eax
18000750e:     	movl	%eax, (%rcx)
180007510:     	movq	0x2dc9(%rip), %rcx      # 0x18000a2e0
180007517:     	movq	%rcx, %rax
18000751a:     	retq
18000751b:     	int3
18000751c:     	int3
18000751d:     	int3
18000751e:     	int3
18000751f:     	int3
180007520:     	pushq	%rbx
180007522:     	subq	$0x20, %rsp
180007526:     	movq	%rcx, %rbx
180007529:     	movq	0x10(%rcx), %rcx
18000752d:     	callq	0x180008750 <numba_list_iter_next+0x1d0>
180007532:     	movq	0x8(%rbx), %rax
180007536:     	movq	%rbx, %rcx
180007539:     	addq	$0x20, %rsp
18000753d:     	popq	%rbx
18000753e:     	jmpq	*0x140(%rax)
180007545:     	int3
180007546:     	int3
180007547:     	int3
180007548:     	int3
180007549:     	int3
18000754a:     	int3
18000754b:     	int3
18000754c:     	int3
18000754d:     	int3
18000754e:     	int3
18000754f:     	int3
180007550:     	movq	%rdi, 0x18(%rsp)
180007555:     	pushq	%r14
180007557:     	subq	$0x20, %rsp
18000755b:     	movq	0xa6de(%rip), %rax      # 0x180011c40
180007562:     	movq	%rdx, %r14
180007565:     	movq	%rcx, %rdi
180007568:     	movq	0x8(%rcx), %rcx
18000756c:     	movq	0x10(%rax), %rdx
180007570:     	cmpq	%rdx, %rcx
180007573:     	je	0x180007590 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x42c0>
180007575:     	callq	*0x2c6d(%rip)           # 0x18000a1e8
18000757b:     	testl	%eax, %eax
18000757d:     	jne	0x180007590 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x42c0>
18000757f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007584:     	movq	0x40(%rsp), %rdi
180007589:     	addq	$0x20, %rsp
18000758d:     	popq	%r14
18000758f:     	retq
180007590:     	movq	%rbx, 0x30(%rsp)
180007595:     	movq	%rdi, %rdx
180007598:     	movq	0x10(%rdi), %rbx
18000759c:     	movq	%rbx, %rcx
18000759f:     	movq	%rsi, 0x38(%rsp)
1800075a4:     	movl	0x18(%rdi), %esi
1800075a7:     	callq	0x180007300 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4030>
1800075ac:     	movq	%rax, (%r14)
1800075af:     	movq	0xa68a(%rip), %rax      # 0x180011c40
1800075b6:     	movq	%rbx, 0x20(%r14)
1800075ba:     	movl	0x18(%rdi), %edx
1800075bd:     	movq	0x20(%rdi), %rcx
1800075c1:     	callq	*0x4f0(%rax)
1800075c7:     	cmpl	$0x12, 0xa67e(%rip)     # 0x180011c4c
1800075ce:     	movq	0x30(%rsp), %rbx
1800075d3:     	movq	%rax, 0x10(%r14)
1800075d7:     	movq	0x38(%rdi), %rax
1800075db:     	jl	0x1800075e3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4313>
1800075dd:     	movq	0x28(%rax), %rax
1800075e1:     	jmp	0x1800075e7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4317>
1800075e3:     	movslq	0x20(%rax), %rax
1800075e7:     	xorl	%r8d, %r8d
1800075ea:     	movq	%rax, 0x18(%r14)
1800075ee:     	movq	%rdi, 0x8(%r14)
1800075f2:     	leaq	0x28(%r14), %rax
1800075f6:     	testl	%esi, %esi
1800075f8:     	jle	0x18000763b <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x436b>
1800075fa:     	nopw	(%rax,%rax)
180007600:     	movq	0x20(%rdi), %rcx
180007604:     	movq	(%rcx,%r8,8), %rdx
180007608:     	incl	%r8d
18000760b:     	movq	%rdx, (%rax)
18000760e:     	addq	$0x8, %rax
180007612:     	cmpl	%esi, %r8d
180007615:     	jl	0x180007600 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4330>
180007617:     	xorl	%r8d, %r8d
18000761a:     	nopw	(%rax,%rax)
180007620:     	movq	0x28(%rdi), %rcx
180007624:     	leaq	0x8(%rax), %rax
180007628:     	movslq	%r8d, %rdx
18000762b:     	incl	%r8d
18000762e:     	movq	(%rcx,%rdx,8), %rdx
180007632:     	movq	%rdx, -0x8(%rax)
180007636:     	cmpl	%esi, %r8d
180007639:     	jl	0x180007620 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4350>
18000763b:     	movq	0x38(%rsp), %rsi
180007640:     	xorl	%eax, %eax
180007642:     	movq	0x40(%rsp), %rdi
180007647:     	addq	$0x20, %rsp
18000764b:     	popq	%r14
18000764d:     	retq
18000764e:     	int3
18000764f:     	int3
180007650:     	pushq	%rbx
180007652:     	pushq	%rbp
180007653:     	pushq	%rsi
180007654:     	pushq	%rdi
180007655:     	subq	$0x28, %rsp
180007659:     	cmpq	$0x0, 0xa5f7(%rip)      # 0x180011c58
180007661:     	movq	%rcx, %rbp
180007664:     	movslq	0x8(%rdx), %rdi
180007668:     	movq	(%rdx), %rsi
18000766b:     	jne	0x1800076c3 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x43f3>
18000766d:     	leaq	0x34f4(%rip), %rcx      # 0x18000ab68
180007674:     	callq	*0x2bce(%rip)           # 0x18000a248
18000767a:     	movq	%rax, %rbx
18000767d:     	testq	%rax, %rax
180007680:     	je	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
180007686:     	leaq	0x34e3(%rip), %rdx      # 0x18000ab70
18000768d:     	movq	%rax, %rcx
180007690:     	callq	*0x2ae2(%rip)           # 0x18000a178
180007696:     	movl	(%rbx), %edx
180007698:     	movq	%rax, 0xa5b9(%rip)      # 0x180011c58
18000769f:     	testl	%edx, %edx
1800076a1:     	js	0x1800076ba <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x43ea>
1800076a3:     	subl	$0x1, %edx
1800076a6:     	movl	%edx, (%rbx)
1800076a8:     	jne	0x1800076ba <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x43ea>
1800076aa:     	movq	%rbx, %rcx
1800076ad:     	callq	*0x2b25(%rip)           # 0x18000a1d8
1800076b3:     	movq	0xa59e(%rip), %rax      # 0x180011c58
1800076ba:     	testq	%rax, %rax
1800076bd:     	je	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
1800076c3:     	movq	%rdi, %rdx
1800076c6:     	movq	%rsi, %rcx
1800076c9:     	callq	*0x2bf9(%rip)           # 0x18000a2c8
1800076cf:     	movq	%rax, %rdi
1800076d2:     	testq	%rax, %rax
1800076d5:     	je	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
1800076d7:     	movq	0xa57a(%rip), %rcx      # 0x180011c58
1800076de:     	xorl	%r8d, %r8d
1800076e1:     	movq	%rax, %rdx
1800076e4:     	callq	*0x2abe(%rip)           # 0x18000a1a8
1800076ea:     	movl	(%rdi), %ecx
1800076ec:     	movq	%rax, %rbx
1800076ef:     	testl	%ecx, %ecx
1800076f1:     	js	0x180007703 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4433>
1800076f3:     	subl	$0x1, %ecx
1800076f6:     	movl	%ecx, (%rdi)
1800076f8:     	jne	0x180007703 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4433>
1800076fa:     	movq	%rdi, %rcx
1800076fd:     	callq	*0x2ad5(%rip)           # 0x18000a1d8
180007703:     	testq	%rbx, %rbx
180007706:     	je	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
180007708:     	movq	0x8(%rbx), %r8
18000770c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180007717:     	jne	0x180007755 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4485>
180007719:     	movq	0x2b90(%rip), %rcx      # 0x18000a2b0
180007720:     	leaq	0x3641(%rip), %rdx      # 0x18000ad68
180007727:     	movq	0x18(%r8), %r8
18000772b:     	movq	(%rcx), %rcx
18000772e:     	callq	*0x2acc(%rip)           # 0x18000a200
180007734:     	movl	(%rbx), %eax
180007736:     	testl	%eax, %eax
180007738:     	js	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
18000773a:     	subl	$0x1, %eax
18000773d:     	movl	%eax, (%rbx)
18000773f:     	jne	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
180007741:     	movq	%rbx, %rcx
180007744:     	callq	*0x2a8e(%rip)           # 0x18000a1d8
18000774a:     	xorl	%eax, %eax
18000774c:     	addq	$0x28, %rsp
180007750:     	popq	%rdi
180007751:     	popq	%rsi
180007752:     	popq	%rbp
180007753:     	popq	%rbx
180007754:     	retq
180007755:     	xorl	%r8d, %r8d
180007758:     	leaq	0x9ba1(%rip), %rcx      # 0x180011300
18000775f:     	xorl	%edx, %edx
180007761:     	callq	*0x2af1(%rip)           # 0x18000a258
180007767:     	movq	%rax, %rdi
18000776a:     	testq	%rax, %rax
18000776d:     	je	0x180007734 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4464>
18000776f:     	movq	%rbp, %rcx
180007772:     	movq	%rbx, 0x18(%rax)
180007776:     	callq	*0x2a54(%rip)           # 0x18000a1d0
18000777c:     	movq	%rax, 0x10(%rdi)
180007780:     	movq	%rax, %rcx
180007783:     	testq	%rax, %rax
180007786:     	jne	0x18000779a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x44ca>
180007788:     	movl	(%rdi), %eax
18000778a:     	testl	%eax, %eax
18000778c:     	js	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
18000778e:     	subl	$0x1, %eax
180007791:     	movl	%eax, (%rdi)
180007793:     	jne	0x18000774a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x447a>
180007795:     	movq	%rdi, %rcx
180007798:     	jmp	0x180007744 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4474>
18000779a:     	movl	(%rax), %eax
18000779c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800077a1:     	jae	0x1800077a7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x44d7>
1800077a3:     	incl	%eax
1800077a5:     	movl	%eax, (%rcx)
1800077a7:     	movq	%rdi, %rax
1800077aa:     	addq	$0x28, %rsp
1800077ae:     	popq	%rdi
1800077af:     	popq	%rsi
1800077b0:     	popq	%rbp
1800077b1:     	popq	%rbx
1800077b2:     	retq
1800077b3:     	int3
1800077b4:     	int3
1800077b5:     	int3
1800077b6:     	int3
1800077b7:     	int3
1800077b8:     	int3
1800077b9:     	int3
1800077ba:     	int3
1800077bb:     	int3
1800077bc:     	int3
1800077bd:     	int3
1800077be:     	int3
1800077bf:     	int3
1800077c0:     	movq	%r9, 0x20(%rsp)
1800077c5:     	movq	%r8, 0x18(%rsp)
1800077ca:     	movq	%rdx, 0x10(%rsp)
1800077cf:     	movq	%rcx, 0x8(%rsp)
1800077d4:     	pushq	%rbx
1800077d5:     	pushq	%rbp
1800077d6:     	pushq	%rsi
1800077d7:     	pushq	%rdi
1800077d8:     	pushq	%r12
1800077da:     	pushq	%r13
1800077dc:     	pushq	%r14
1800077de:     	pushq	%r15
1800077e0:     	subq	$0x68, %rsp
1800077e4:     	movq	%rcx, %r14
1800077e7:     	movq	%r9, %r15
1800077ea:     	leaq	0x302f(%rip), %rcx      # 0x18000a820
1800077f1:     	movq	%r8, %r13
1800077f4:     	movq	%rdx, %rsi
1800077f7:     	callq	*0x2a4b(%rip)           # 0x18000a248
1800077fd:     	movq	%rax, %rdi
180007800:     	testq	%rax, %rax
180007803:     	jne	0x18000783c <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x456c>
180007805:     	movq	0x292c(%rip), %rcx      # 0x18000a138
18000780c:     	movq	(%rcx), %rcx
18000780f:     	callq	*0x29ab(%rip)           # 0x18000a1c0
180007815:     	testl	%eax, %eax
180007817:     	je	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
18000781d:     	callq	*0x2aad(%rip)           # 0x18000a2d0
180007823:     	leaq	0x3016(%rip), %rcx      # 0x18000a840
18000782a:     	callq	*0x2a18(%rip)           # 0x18000a248
180007830:     	movq	%rax, %rdi
180007833:     	testq	%rax, %rax
180007836:     	je	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
18000783c:     	leaq	0x301d(%rip), %rdx      # 0x18000a860
180007843:     	movq	%rdi, %rcx
180007846:     	callq	*0x292c(%rip)           # 0x18000a178
18000784c:     	movl	(%rdi), %ecx
18000784e:     	movq	%rax, %rbx
180007851:     	testl	%ecx, %ecx
180007853:     	js	0x180007865 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4595>
180007855:     	subl	$0x1, %ecx
180007858:     	movl	%ecx, (%rdi)
18000785a:     	jne	0x180007865 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4595>
18000785c:     	movq	%rdi, %rcx
18000785f:     	callq	*0x2973(%rip)           # 0x18000a1d8
180007865:     	testq	%rbx, %rbx
180007868:     	je	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
18000786e:     	movq	0x288b(%rip), %rax      # 0x18000a100
180007875:     	cmpq	%rax, 0x8(%rbx)
180007879:     	je	0x1800078b5 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x45e5>
18000787b:     	movq	0x2a3e(%rip), %rcx      # 0x18000a2c0
180007882:     	leaq	0x2fe7(%rip), %rdx      # 0x18000a870
180007889:     	movq	(%rcx), %rcx
18000788c:     	callq	*0x2a26(%rip)           # 0x18000a2b8
180007892:     	movl	(%rbx), %eax
180007894:     	testl	%eax, %eax
180007896:     	js	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
18000789c:     	subl	$0x1, %eax
18000789f:     	movl	%eax, (%rbx)
1800078a1:     	jne	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
1800078a7:     	movq	%rbx, %rcx
1800078aa:     	callq	*0x2928(%rip)           # 0x18000a1d8
1800078b0:     	jmp	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
1800078b5:     	xorl	%edx, %edx
1800078b7:     	movq	%rbx, %rcx
1800078ba:     	callq	*0x28f8(%rip)           # 0x18000a1b8
1800078c0:     	movl	(%rbx), %ecx
1800078c2:     	movq	%rax, 0xa377(%rip)      # 0x180011c40
1800078c9:     	testl	%ecx, %ecx
1800078cb:     	js	0x1800078e4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4614>
1800078cd:     	subl	$0x1, %ecx
1800078d0:     	movl	%ecx, (%rbx)
1800078d2:     	jne	0x1800078e4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4614>
1800078d4:     	movq	%rbx, %rcx
1800078d7:     	callq	*0x28fb(%rip)           # 0x18000a1d8
1800078dd:     	movq	0xa35c(%rip), %rax      # 0x180011c40
1800078e4:     	testq	%rax, %rax
1800078e7:     	jne	0x180007902 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4632>
1800078e9:     	leaq	0x2fa8(%rip), %rdx      # 0x18000a898
1800078f0:     	movq	0x29c9(%rip), %rcx      # 0x18000a2c0
1800078f7:     	movq	(%rcx), %rcx
1800078fa:     	callq	*0x29b8(%rip)           # 0x18000a2b8
180007900:     	jmp	0x180007937 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4667>
180007902:     	callq	*(%rax)
180007904:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180007909:     	jbe	0x18000796a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x469a>
18000790b:     	movq	0x29ae(%rip), %rax      # 0x18000a2c0
180007912:     	movq	(%rax), %rbx
180007915:     	movq	0xa324(%rip), %rax      # 0x180011c40
18000791c:     	callq	*(%rax)
18000791e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180007924:     	leaq	0x2f95(%rip), %rdx      # 0x18000a8c0
18000792b:     	movl	%eax, %r9d
18000792e:     	movq	%rbx, %rcx
180007931:     	callq	*0x28c9(%rip)           # 0x18000a200
180007937:     	callq	*0x27db(%rip)           # 0x18000a118
18000793d:     	movq	0x29c4(%rip), %rcx      # 0x18000a308
180007944:     	leaq	0x319d(%rip), %rdx      # 0x18000aae8
18000794b:     	movq	(%rcx), %rcx
18000794e:     	callq	*0x2964(%rip)           # 0x18000a2b8
180007954:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007959:     	addq	$0x68, %rsp
18000795d:     	popq	%r15
18000795f:     	popq	%r14
180007961:     	popq	%r13
180007963:     	popq	%r12
180007965:     	popq	%rdi
180007966:     	popq	%rsi
180007967:     	popq	%rbp
180007968:     	popq	%rbx
180007969:     	retq
18000796a:     	movq	0xa2cf(%rip), %rax      # 0x180011c40
180007971:     	callq	*0x698(%rax)
180007977:     	movl	%eax, 0xa2cf(%rip)      # 0x180011c4c
18000797d:     	cmpl	$0x10, %eax
180007980:     	jge	0x18000799e <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x46ce>
180007982:     	movq	0x2937(%rip), %rcx      # 0x18000a2c0
180007989:     	leaq	0x2f80(%rip), %rdx      # 0x18000a910
180007990:     	movl	%eax, %r9d
180007993:     	movl	$0x10, %r8d
180007999:     	movq	(%rcx), %rcx
18000799c:     	jmp	0x180007931 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4661>
18000799e:     	movq	0xa29b(%rip), %rax      # 0x180011c40
1800079a5:     	callq	*0x690(%rax)
1800079ab:     	testl	%eax, %eax
1800079ad:     	jne	0x1800079bb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x46eb>
1800079af:     	leaq	0x30aa(%rip), %rdx      # 0x18000aa60
1800079b6:     	jmp	0x1800078f0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4620>
1800079bb:     	cmpl	$0x1, %eax
1800079be:     	je	0x1800079cc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x46fc>
1800079c0:     	leaq	0x30c9(%rip), %rdx      # 0x18000aa90
1800079c7:     	jmp	0x1800078f0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4620>
1800079cc:     	leaq	0x9e0d(%rip), %rcx      # 0x1800117e0
1800079d3:     	callq	*0x27a7(%rip)           # 0x18000a180
1800079d9:     	testl	%eax, %eax
1800079db:     	jne	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
1800079e1:     	leaq	0x9918(%rip), %rcx      # 0x180011300
1800079e8:     	callq	*0x2792(%rip)           # 0x18000a180
1800079ee:     	testl	%eax, %eax
1800079f0:     	jne	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
1800079f6:     	leaq	0x9c43(%rip), %rcx      # 0x180011640
1800079fd:     	callq	*0x277d(%rip)           # 0x18000a180
180007a03:     	testl	%eax, %eax
180007a05:     	jne	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007a0b:     	xorl	%ebx, %ebx
180007a0d:     	cmpl	%ebx, 0xa235(%rip)      # 0x180011c48
180007a13:     	jne	0x180007a56 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4786>
180007a15:     	movq	%gs:0x58, %rax
180007a1e:     	movl	0xa23c(%rip), %ecx      # 0x180011c60
180007a24:     	movl	$0x1, 0xa21a(%rip)      # 0x180011c48
180007a2e:     	movq	(%rax,%rcx,8), %rdx
180007a32:     	movl	$0x10, %eax
180007a37:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007a3e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180007a43:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007a4a:     	movl	$0x13d0, %eax           # imm = 0x13D0
180007a4f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007a56:     	movl	%ebx, 0xa19c(%rip)      # 0x180011bf8
180007a5c:     	movq	%rbx, %rax
180007a5f:     	movb	%bl, 0xa19b(%rip)       # 0x180011c00
180007a65:     	movq	%rbx, %rcx
180007a68:     	xchgq	%rax, 0xa199(%rip)      # 0x180011c08
180007a6f:     	xchgq	%rcx, 0xa19a(%rip)      # 0x180011c10
180007a76:     	movq	%rbx, %rax
180007a79:     	movq	%rbx, %rcx
180007a7c:     	xchgq	%rax, 0xa195(%rip)      # 0x180011c18
180007a83:     	xchgq	%rcx, 0xa196(%rip)      # 0x180011c20
180007a8a:     	movq	0x25d7(%rip), %rax      # 0x18000a068
180007a91:     	leaq	0x9a08(%rip), %rcx      # 0x1800114a0
180007a98:     	movq	%rax, 0xa189(%rip)      # 0x180011c28
180007a9f:     	movq	0x25ba(%rip), %rax      # 0x18000a060
180007aa6:     	movq	%rax, 0xa183(%rip)      # 0x180011c30
180007aad:     	movq	0x25bc(%rip), %rax      # 0x18000a070
180007ab4:     	movq	%rax, 0xa17d(%rip)      # 0x180011c38
180007abb:     	movq	0x2796(%rip), %rax      # 0x18000a258
180007ac2:     	movq	%rax, 0x9b0f(%rip)      # 0x1800115d8
180007ac9:     	callq	*0x26b1(%rip)           # 0x18000a180
180007acf:     	testl	%eax, %eax
180007ad1:     	jne	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007ad7:     	leaq	0x3122(%rip), %rdx      # 0x18000ac00
180007ade:     	movq	%r14, %rcx
180007ae1:     	callq	*0x2691(%rip)           # 0x18000a178
180007ae7:     	movq	%rax, 0x28(%rsp)
180007aec:     	movq	%rax, %rdi
180007aef:     	testq	%rax, %rax
180007af2:     	je	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007af8:     	leaq	0x329a(%rip), %rcx      # 0x18000ad99
180007aff:     	callq	*0x278b(%rip)           # 0x18000a290
180007b05:     	movq	%rax, 0x20(%rsp)
180007b0a:     	movq	%rax, %r12
180007b0d:     	testq	%rax, %rax
180007b10:     	je	0x180007e54 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b84>
180007b16:     	movl	%ebx, %ebp
180007b18:     	cmpq	%rbx, (%rsi)
180007b1b:     	je	0x180007cc4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x49f4>
180007b21:     	movslq	%ebp, %rbx
180007b24:     	leaq	0x30(%rsp), %rdx
180007b29:     	movq	%r14, %rcx
180007b2c:     	leaq	(%rbx,%rbx,4), %rax
180007b30:     	movups	(%r13,%rax,8), %xmm0
180007b36:     	movups	0x10(%r13,%rax,8), %xmm1
180007b3c:     	movaps	%xmm0, 0x30(%rsp)
180007b41:     	movsd	0x20(%r13,%rax,8), %xmm0
180007b48:     	movsd	%xmm0, 0x50(%rsp)
180007b4e:     	movaps	%xmm1, 0x40(%rsp)
180007b53:     	callq	0x180007650 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4380>
180007b58:     	movq	%rax, %r14
180007b5b:     	testq	%rax, %rax
180007b5e:     	je	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007b64:     	movq	(%rsi), %rcx
180007b67:     	callq	*0x2723(%rip)           # 0x18000a290
180007b6d:     	movq	%rax, %r13
180007b70:     	testq	%rax, %rax
180007b73:     	je	0x180007e77 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4ba7>
180007b79:     	movq	(%r15,%rbx,8), %rcx
180007b7d:     	xorl	%edx, %edx
180007b7f:     	movq	%r14, (%rcx)
180007b82:     	leaq	0x9c57(%rip), %rcx      # 0x1800117e0
180007b89:     	movq	0x8(%rsi), %r12
180007b8d:     	callq	*0x25cd(%rip)           # 0x18000a160
180007b93:     	movq	%rax, %rbx
180007b96:     	testq	%rax, %rax
180007b99:     	je	0x180007c16 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4946>
180007b9b:     	movq	%r13, %rcx
180007b9e:     	callq	*0x25ec(%rip)           # 0x18000a190
180007ba4:     	movq	%rax, %rdi
180007ba7:     	testq	%rax, %rax
180007baa:     	je	0x180007bcc <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x48fc>
180007bac:     	movq	%rax, %rcx
180007baf:     	callq	0x18000944d <numba_list_iter_next+0xecd>
180007bb4:     	leaq	0x1(%rax), %rcx
180007bb8:     	callq	*0x26a2(%rip)           # 0x18000a260
180007bbe:     	movq	%rax, %rsi
180007bc1:     	testq	%rax, %rax
180007bc4:     	jne	0x180007bd4 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4904>
180007bc6:     	callq	*0x2584(%rip)           # 0x18000a150
180007bcc:     	xorl	%eax, %eax
180007bce:     	movq	%rax, 0x20(%rbx)
180007bd2:     	jmp	0x180007c05 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4935>
180007bd4:     	movq	%rdi, %rdx
180007bd7:     	movq	%rsi, %rcx
180007bda:     	callq	0x180009447 <numba_list_iter_next+0xec7>
180007bdf:     	movq	0x20(%rsp), %rcx
180007be4:     	movq	%rsi, 0x20(%rbx)
180007be8:     	movq	%r12, 0x28(%rbx)
180007bec:     	movl	$0x3, 0x30(%rbx)
180007bf3:     	callq	0x1800070d0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x3e00>
180007bf8:     	movq	%rax, 0x38(%rbx)
180007bfc:     	testq	%rax, %rax
180007bff:     	jne	0x180007d70 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4aa0>
180007c05:     	movl	(%rbx), %eax
180007c07:     	testl	%eax, %eax
180007c09:     	js	0x180007c16 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4946>
180007c0b:     	subl	$0x1, %eax
180007c0e:     	movl	%eax, (%rbx)
180007c10:     	je	0x180007dbd <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4aed>
180007c16:     	xorl	%edi, %edi
180007c18:     	movl	(%r14), %eax
180007c1b:     	testl	%eax, %eax
180007c1d:     	js	0x180007c30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4960>
180007c1f:     	subl	$0x1, %eax
180007c22:     	movl	%eax, (%r14)
180007c25:     	jne	0x180007c30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4960>
180007c27:     	movq	%r14, %rcx
180007c2a:     	callq	*0x25a8(%rip)           # 0x18000a1d8
180007c30:     	movl	(%r13), %eax
180007c34:     	testl	%eax, %eax
180007c36:     	js	0x180007c4a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x497a>
180007c38:     	subl	$0x1, %eax
180007c3b:     	movl	%eax, (%r13)
180007c3f:     	jne	0x180007c4a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x497a>
180007c41:     	movq	%r13, %rcx
180007c44:     	callq	*0x258e(%rip)           # 0x18000a1d8
180007c4a:     	testq	%rdi, %rdi
180007c4d:     	je	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007c53:     	movq	0xb8(%rsp), %rsi
180007c5b:     	movq	%rdi, %r8
180007c5e:     	movq	0xb0(%rsp), %r14
180007c66:     	movq	%r14, %rcx
180007c69:     	movq	(%rsi), %rdx
180007c6c:     	callq	*0x25be(%rip)           # 0x18000a230
180007c72:     	movl	(%rdi), %ecx
180007c74:     	testl	%eax, %eax
180007c76:     	jne	0x180007e1a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b4a>
180007c7c:     	testl	%ecx, %ecx
180007c7e:     	js	0x180007c92 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x49c2>
180007c80:     	leal	-0x1(%rcx), %eax
180007c83:     	movl	%eax, (%rdi)
180007c85:     	testl	%eax, %eax
180007c87:     	jne	0x180007c92 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x49c2>
180007c89:     	movq	%rdi, %rcx
180007c8c:     	callq	*0x2546(%rip)           # 0x18000a1d8
180007c92:     	movq	0xc8(%rsp), %r15
180007c9a:     	addq	$0x20, %rsi
180007c9e:     	movq	0xc0(%rsp), %r13
180007ca6:     	incl	%ebp
180007ca8:     	movq	%rsi, 0xb8(%rsp)
180007cb0:     	cmpq	$0x0, (%rsi)
180007cb4:     	jne	0x180007b21 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4851>
180007cba:     	movq	0x20(%rsp), %r12
180007cbf:     	movq	0x28(%rsp), %rdi
180007cc4:     	movslq	%ebp, %rax
180007cc7:     	cmpq	$0x0, (%r15,%rax,8)
180007ccc:     	je	0x180007d39 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a69>
180007cce:     	nop
180007cd0:     	movslq	%ebp, %rbx
180007cd3:     	leaq	0x30(%rsp), %rdx
180007cd8:     	movq	%r14, %rcx
180007cdb:     	leaq	(%rbx,%rbx,4), %rax
180007cdf:     	movups	(%r13,%rax,8), %xmm0
180007ce5:     	movups	0x10(%r13,%rax,8), %xmm1
180007ceb:     	movaps	%xmm0, 0x30(%rsp)
180007cf0:     	movsd	0x20(%r13,%rax,8), %xmm0
180007cf7:     	movsd	%xmm0, 0x50(%rsp)
180007cfd:     	movaps	%xmm1, 0x40(%rsp)
180007d02:     	callq	0x180007650 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4380>
180007d07:     	testq	%rax, %rax
180007d0a:     	je	0x180007e35 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b65>
180007d10:     	movq	(%r15,%rbx,8), %rcx
180007d14:     	movq	%rax, (%rcx)
180007d17:     	movl	(%rax), %ecx
180007d19:     	testl	%ecx, %ecx
180007d1b:     	js	0x180007d2d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a5d>
180007d1d:     	subl	$0x1, %ecx
180007d20:     	movl	%ecx, (%rax)
180007d22:     	jne	0x180007d2d <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a5d>
180007d24:     	movq	%rax, %rcx
180007d27:     	callq	*0x24ab(%rip)           # 0x18000a1d8
180007d2d:     	incl	%ebp
180007d2f:     	movslq	%ebp, %rax
180007d32:     	cmpq	$0x0, (%r15,%rax,8)
180007d37:     	jne	0x180007cd0 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a00>
180007d39:     	movl	(%r12), %eax
180007d3d:     	testl	%eax, %eax
180007d3f:     	js	0x180007d53 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a83>
180007d41:     	subl	$0x1, %eax
180007d44:     	movl	%eax, (%r12)
180007d48:     	jne	0x180007d53 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a83>
180007d4a:     	movq	%r12, %rcx
180007d4d:     	callq	*0x2485(%rip)           # 0x18000a1d8
180007d53:     	movl	(%rdi), %eax
180007d55:     	testl	%eax, %eax
180007d57:     	js	0x180007d69 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a99>
180007d59:     	subl	$0x1, %eax
180007d5c:     	movl	%eax, (%rdi)
180007d5e:     	jne	0x180007d69 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4a99>
180007d60:     	movq	%rdi, %rcx
180007d63:     	callq	*0x246f(%rip)           # 0x18000a1d8
180007d69:     	xorl	%eax, %eax
180007d6b:     	jmp	0x180007959 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4689>
180007d70:     	movl	(%r14), %eax
180007d73:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007d78:     	jae	0x180007d7f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4aaf>
180007d7a:     	incl	%eax
180007d7c:     	movl	%eax, (%r14)
180007d7f:     	movq	0xb0(%rsp), %rcx
180007d87:     	leaq	0x2e72(%rip), %rdx      # 0x18000ac00
180007d8e:     	movq	%r14, 0x18(%rbx)
180007d92:     	movq	$0x0, 0x40(%rbx)
180007d9a:     	callq	*0x23d8(%rip)           # 0x18000a178
180007da0:     	movq	%rax, %rsi
180007da3:     	testq	%rax, %rax
180007da6:     	jne	0x180007dcb <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4afb>
180007da8:     	movl	(%rbx), %eax
180007daa:     	testl	%eax, %eax
180007dac:     	js	0x180007c16 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4946>
180007db2:     	subl	$0x1, %eax
180007db5:     	movl	%eax, (%rbx)
180007db7:     	jne	0x180007c16 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4946>
180007dbd:     	movq	%rbx, %rcx
180007dc0:     	callq	*0x2412(%rip)           # 0x18000a1d8
180007dc6:     	jmp	0x180007c16 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4946>
180007dcb:     	xorl	%r9d, %r9d
180007dce:     	leaq	0x20(%rbx), %rcx
180007dd2:     	movq	%rsi, %r8
180007dd5:     	movq	%rbx, %rdx
180007dd8:     	callq	*0x237a(%rip)           # 0x18000a158
180007dde:     	movq	%rax, %rdi
180007de1:     	movl	(%rbx), %eax
180007de3:     	testl	%eax, %eax
180007de5:     	js	0x180007df7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b27>
180007de7:     	subl	$0x1, %eax
180007dea:     	movl	%eax, (%rbx)
180007dec:     	jne	0x180007df7 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b27>
180007dee:     	movq	%rbx, %rcx
180007df1:     	callq	*0x23e1(%rip)           # 0x18000a1d8
180007df7:     	movl	(%rsi), %eax
180007df9:     	testl	%eax, %eax
180007dfb:     	js	0x180007c18 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4948>
180007e01:     	subl	$0x1, %eax
180007e04:     	movl	%eax, (%rsi)
180007e06:     	jne	0x180007c18 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4948>
180007e0c:     	movq	%rsi, %rcx
180007e0f:     	callq	*0x23c3(%rip)           # 0x18000a1d8
180007e15:     	jmp	0x180007c18 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4948>
180007e1a:     	testl	%ecx, %ecx
180007e1c:     	js	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007e1e:     	leal	-0x1(%rcx), %eax
180007e21:     	movl	%eax, (%rdi)
180007e23:     	testl	%eax, %eax
180007e25:     	jne	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007e27:     	movq	%rdi, %rcx
180007e2a:     	callq	*0x23a8(%rip)           # 0x18000a1d8
180007e30:     	movq	0x20(%rsp), %r12
180007e35:     	movl	(%r12), %eax
180007e39:     	testl	%eax, %eax
180007e3b:     	js	0x180007e4f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b7f>
180007e3d:     	subl	$0x1, %eax
180007e40:     	movl	%eax, (%r12)
180007e44:     	jne	0x180007e4f <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b7f>
180007e46:     	movq	%r12, %rcx
180007e49:     	callq	*0x2389(%rip)           # 0x18000a1d8
180007e4f:     	movq	0x28(%rsp), %rdi
180007e54:     	movl	(%rdi), %eax
180007e56:     	testl	%eax, %eax
180007e58:     	js	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007e5e:     	subl	$0x1, %eax
180007e61:     	movl	%eax, (%rdi)
180007e63:     	jne	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007e69:     	movq	%rdi, %rcx
180007e6c:     	callq	*0x2366(%rip)           # 0x18000a1d8
180007e72:     	jmp	0x180007954 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4684>
180007e77:     	movl	(%r14), %eax
180007e7a:     	testl	%eax, %eax
180007e7c:     	js	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007e7e:     	subl	$0x1, %eax
180007e81:     	movl	%eax, (%r14)
180007e84:     	jne	0x180007e30 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b60>
180007e86:     	movq	%r14, %rcx
180007e89:     	jmp	0x180007e2a <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4b5a>
180007e8b:     	int3
180007e8c:     	int3
180007e8d:     	int3
180007e8e:     	int3
180007e8f:     	int3
180007e90:     	leaq	0x9de9(%rip), %rax      # 0x180011c80
180007e97:     	retq
180007e98:     	int3
180007e99:     	int3
180007e9a:     	int3
180007e9b:     	int3
180007e9c:     	int3
180007e9d:     	int3
180007e9e:     	int3
180007e9f:     	int3

0000000180007ea0 <numba_list_set_method_table>:
180007ea0:     	movups	(%rdx), %xmm0
180007ea3:     	movups	%xmm0, 0x20(%rcx)
180007ea7:     	retq
180007ea8:     	int3
180007ea9:     	int3
180007eaa:     	int3
180007eab:     	int3
180007eac:     	int3
180007ead:     	int3
180007eae:     	int3
180007eaf:     	int3

0000000180007eb0 <numba_list_new>:
180007eb0:     	pushq	%rbx
180007eb2:     	pushq	%rbp
180007eb3:     	pushq	%rsi
180007eb4:     	pushq	%rdi
180007eb5:     	subq	$0x28, %rsp
180007eb9:     	movq	%rcx, %rsi
180007ebc:     	movq	%r8, %rdi
180007ebf:     	movl	$0x38, %ecx
180007ec4:     	movq	%rdx, %rbp
180007ec7:     	callq	*0x219b(%rip)           # 0x18000a068
180007ecd:     	movq	%rax, %rbx
180007ed0:     	testq	%rax, %rax
180007ed3:     	je	0x180007f3d <numba_list_new+0x8d>
180007ed5:     	movq	$0x0, (%rax)
180007edc:     	xorps	%xmm0, %xmm0
180007edf:     	movq	%rbp, 0x8(%rax)
180007ee3:     	movq	%rdi, 0x10(%rax)
180007ee7:     	movl	$0x1, 0x18(%rax)
180007eee:     	movups	%xmm0, 0x20(%rax)
180007ef2:     	testq	%rdi, %rdi
180007ef5:     	je	0x180007f4b <numba_list_new+0x9b>
180007ef7:     	imulq	%rbp, %rdi
180007efb:     	movl	$0x8, %ecx
180007f00:     	movq	%rdi, %rax
180007f03:     	cqto
180007f05:     	andl	$0x7, %edx
180007f08:     	addq	%rdx, %rax
180007f0b:     	andl	$0x7, %eax
180007f0e:     	subq	%rdx, %rax
180007f11:     	subq	%rax, %rcx
180007f14:     	movq	%rcx, %rax
180007f17:     	cqto
180007f19:     	andl	$0x7, %edx
180007f1c:     	leaq	(%rdx,%rax), %rcx
180007f20:     	andl	$0x7, %ecx
180007f23:     	subq	%rdx, %rcx
180007f26:     	addq	%rdi, %rcx
180007f29:     	callq	*0x2139(%rip)           # 0x18000a068
180007f2f:     	testq	%rax, %rax
180007f32:     	jne	0x180007f4d <numba_list_new+0x9d>
180007f34:     	movq	%rbx, %rcx
180007f37:     	callq	*0x2133(%rip)           # 0x18000a070
180007f3d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180007f42:     	addq	$0x28, %rsp
180007f46:     	popq	%rdi
180007f47:     	popq	%rsi
180007f48:     	popq	%rbp
180007f49:     	popq	%rbx
180007f4a:     	retq
180007f4b:     	xorl	%eax, %eax
180007f4d:     	movq	%rax, 0x30(%rbx)
180007f51:     	xorl	%eax, %eax
180007f53:     	movq	%rbx, (%rsi)
180007f56:     	addq	$0x28, %rsp
180007f5a:     	popq	%rdi
180007f5b:     	popq	%rsi
180007f5c:     	popq	%rbp
180007f5d:     	popq	%rbx
180007f5e:     	retq
180007f5f:     	int3

0000000180007f60 <numba_list_free>:
180007f60:     	pushq	%rbx
180007f62:     	subq	$0x20, %rsp
180007f66:     	cmpq	$0x0, 0x28(%rcx)
180007f6b:     	movq	%rcx, %rbx
180007f6e:     	je	0x180007fa4 <numba_list_free+0x44>
180007f70:     	movq	%rdi, 0x30(%rsp)
180007f75:     	xorl	%edi, %edi
180007f77:     	cmpq	%rdi, (%rcx)
180007f7a:     	jle	0x180007f9f <numba_list_free+0x3f>
180007f7c:     	nopl	(%rax)
180007f80:     	movq	0x28(%rbx), %rax
180007f84:     	testq	%rax, %rax
180007f87:     	je	0x180007f97 <numba_list_free+0x37>
180007f89:     	movq	%rdi, %rcx
180007f8c:     	imulq	0x8(%rbx), %rcx
180007f91:     	addq	0x30(%rbx), %rcx
180007f95:     	callq	*%rax
180007f97:     	incq	%rdi
180007f9a:     	cmpq	(%rbx), %rdi
180007f9d:     	jl	0x180007f80 <numba_list_free+0x20>
180007f9f:     	movq	0x30(%rsp), %rdi
180007fa4:     	movq	0x30(%rbx), %rcx
180007fa8:     	testq	%rcx, %rcx
180007fab:     	je	0x180007fb3 <numba_list_free+0x53>
180007fad:     	callq	*0x20bd(%rip)           # 0x18000a070
180007fb3:     	movq	%rbx, %rcx
180007fb6:     	addq	$0x20, %rsp
180007fba:     	popq	%rbx
180007fbb:     	jmpq	*0x20ae(%rip)           # 0x18000a070
180007fc2:     	int3
180007fc3:     	int3
180007fc4:     	int3
180007fc5:     	int3
180007fc6:     	int3
180007fc7:     	int3
180007fc8:     	int3
180007fc9:     	int3
180007fca:     	int3
180007fcb:     	int3
180007fcc:     	int3
180007fcd:     	int3
180007fce:     	int3
180007fcf:     	int3

0000000180007fd0 <numba_list_base_ptr>:
180007fd0:     	movq	0x30(%rcx), %rax
180007fd4:     	retq
180007fd5:     	int3
180007fd6:     	int3
180007fd7:     	int3
180007fd8:     	int3
180007fd9:     	int3
180007fda:     	int3
180007fdb:     	int3
180007fdc:     	int3
180007fdd:     	int3
180007fde:     	int3
180007fdf:     	int3

0000000180007fe0 <numba_list_size_address>:
180007fe0:     	movq	%rcx, %rax
180007fe3:     	retq
180007fe4:     	int3
180007fe5:     	int3
180007fe6:     	int3
180007fe7:     	int3
180007fe8:     	int3
180007fe9:     	int3
180007fea:     	int3
180007feb:     	int3
180007fec:     	int3
180007fed:     	int3
180007fee:     	int3
180007fef:     	int3

0000000180007ff0 <numba_list_length>:
180007ff0:     	movq	(%rcx), %rax
180007ff3:     	retq
180007ff4:     	int3
180007ff5:     	int3
180007ff6:     	int3
180007ff7:     	int3
180007ff8:     	int3
180007ff9:     	int3
180007ffa:     	int3
180007ffb:     	int3
180007ffc:     	int3
180007ffd:     	int3
180007ffe:     	int3
180007fff:     	int3

0000000180008000 <numba_list_allocated>:
180008000:     	movq	0x10(%rcx), %rax
180008004:     	retq
180008005:     	int3
180008006:     	int3
180008007:     	int3
180008008:     	int3
180008009:     	int3
18000800a:     	int3
18000800b:     	int3
18000800c:     	int3
18000800d:     	int3
18000800e:     	int3
18000800f:     	int3

0000000180008010 <numba_list_is_mutable>:
180008010:     	movl	0x18(%rcx), %eax
180008013:     	retq
180008014:     	int3
180008015:     	int3
180008016:     	int3
180008017:     	int3
180008018:     	int3
180008019:     	int3
18000801a:     	int3
18000801b:     	int3
18000801c:     	int3
18000801d:     	int3
18000801e:     	int3
18000801f:     	int3

0000000180008020 <numba_list_set_is_mutable>:
180008020:     	movl	%edx, 0x18(%rcx)
180008023:     	retq
180008024:     	int3
180008025:     	int3
180008026:     	int3
180008027:     	int3
180008028:     	int3
180008029:     	int3
18000802a:     	int3
18000802b:     	int3
18000802c:     	int3
18000802d:     	int3
18000802e:     	int3
18000802f:     	int3

0000000180008030 <numba_list_setitem>:
180008030:     	movq	%rbx, 0x10(%rsp)
180008035:     	pushq	%rsi
180008036:     	subq	$0x20, %rsp
18000803a:     	cmpl	$0x0, 0x18(%rcx)
18000803e:     	movq	%r8, %rsi
180008041:     	movq	%rcx, %rbx
180008044:     	jne	0x180008056 <numba_list_setitem+0x26>
180008046:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000804b:     	movq	0x38(%rsp), %rbx
180008050:     	addq	$0x20, %rsp
180008054:     	popq	%rsi
180008055:     	retq
180008056:     	cmpq	(%rcx), %rdx
180008059:     	jb	0x18000806b <numba_list_setitem+0x3b>
18000805b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180008060:     	movq	0x38(%rsp), %rbx
180008065:     	addq	$0x20, %rsp
180008069:     	popq	%rsi
18000806a:     	retq
18000806b:     	imulq	0x8(%rcx), %rdx
180008070:     	movq	0x28(%rcx), %rax
180008074:     	movq	%rdi, 0x30(%rsp)
180008079:     	movq	0x30(%rcx), %rdi
18000807d:     	addq	%rdx, %rdi
180008080:     	testq	%rax, %rax
180008083:     	je	0x18000808a <numba_list_setitem+0x5a>
180008085:     	movq	%rdi, %rcx
180008088:     	callq	*%rax
18000808a:     	movq	0x8(%rbx), %r8
18000808e:     	movq	%rsi, %rdx
180008091:     	movq	%rdi, %rcx
180008094:     	callq	0x18000943b <numba_list_iter_next+0xebb>
180008099:     	movq	0x20(%rbx), %rax
18000809d:     	testq	%rax, %rax
1800080a0:     	je	0x1800080a7 <numba_list_setitem+0x77>
1800080a2:     	movq	%rdi, %rcx
1800080a5:     	callq	*%rax
1800080a7:     	movq	0x30(%rsp), %rdi
1800080ac:     	xorl	%eax, %eax
1800080ae:     	movq	0x38(%rsp), %rbx
1800080b3:     	addq	$0x20, %rsp
1800080b7:     	popq	%rsi
1800080b8:     	retq
1800080b9:     	int3
1800080ba:     	int3
1800080bb:     	int3
1800080bc:     	int3
1800080bd:     	int3
1800080be:     	int3
1800080bf:     	int3

00000001800080c0 <numba_list_getitem>:
1800080c0:     	subq	$0x28, %rsp
1800080c4:     	movq	%r8, %r9
1800080c7:     	movq	%rdx, %rax
1800080ca:     	cmpq	(%rcx), %rdx
1800080cd:     	jb	0x1800080d9 <numba_list_getitem+0x19>
1800080cf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800080d4:     	addq	$0x28, %rsp
1800080d8:     	retq
1800080d9:     	movq	0x8(%rcx), %r8
1800080dd:     	movq	%r8, %rdx
1800080e0:     	imulq	%rax, %rdx
1800080e4:     	addq	0x30(%rcx), %rdx
1800080e8:     	movq	%r9, %rcx
1800080eb:     	callq	0x18000943b <numba_list_iter_next+0xebb>
1800080f0:     	xorl	%eax, %eax
1800080f2:     	addq	$0x28, %rsp
1800080f6:     	retq
1800080f7:     	int3
1800080f8:     	int3
1800080f9:     	int3
1800080fa:     	int3
1800080fb:     	int3
1800080fc:     	int3
1800080fd:     	int3
1800080fe:     	int3
1800080ff:     	int3

0000000180008100 <numba_list_append>:
180008100:     	movq	%rbx, 0x10(%rsp)
180008105:     	pushq	%rsi
180008106:     	subq	$0x20, %rsp
18000810a:     	cmpl	$0x0, 0x18(%rcx)
18000810e:     	movq	%rdx, %rsi
180008111:     	movq	%rcx, %rbx
180008114:     	jne	0x180008126 <numba_list_append+0x26>
180008116:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000811b:     	movq	0x38(%rsp), %rbx
180008120:     	addq	$0x20, %rsp
180008124:     	popq	%rsi
180008125:     	retq
180008126:     	movq	(%rcx), %rdx
180008129:     	incq	%rdx
18000812c:     	callq	0x180008180 <numba_list_resize>
180008131:     	testl	%eax, %eax
180008133:     	js	0x18000816c <numba_list_append+0x6c>
180008135:     	movq	0x8(%rbx), %r8
180008139:     	movq	%rsi, %rdx
18000813c:     	movq	%rdi, 0x30(%rsp)
180008141:     	movq	(%rbx), %rdi
180008144:     	decq	%rdi
180008147:     	imulq	%r8, %rdi
18000814b:     	addq	0x30(%rbx), %rdi
18000814f:     	movq	%rdi, %rcx
180008152:     	callq	0x18000943b <numba_list_iter_next+0xebb>
180008157:     	movq	0x20(%rbx), %rax
18000815b:     	testq	%rax, %rax
18000815e:     	je	0x180008165 <numba_list_append+0x65>
180008160:     	movq	%rdi, %rcx
180008163:     	callq	*%rax
180008165:     	movq	0x30(%rsp), %rdi
18000816a:     	xorl	%eax, %eax
18000816c:     	movq	0x38(%rsp), %rbx
180008171:     	addq	$0x20, %rsp
180008175:     	popq	%rsi
180008176:     	retq
180008177:     	int3
180008178:     	int3
180008179:     	int3
18000817a:     	int3
18000817b:     	int3
18000817c:     	int3
18000817d:     	int3
18000817e:     	int3
18000817f:     	int3

0000000180008180 <numba_list_resize>:
180008180:     	movq	%rsi, 0x18(%rsp)
180008185:     	pushq	%rdi
180008186:     	subq	$0x20, %rsp
18000818a:     	cmpl	$0x0, 0x18(%rcx)
18000818e:     	movq	%rdx, %rsi
180008191:     	movq	%rcx, %rdi
180008194:     	jne	0x1800081a6 <numba_list_resize+0x26>
180008196:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000819b:     	movq	0x40(%rsp), %rsi
1800081a0:     	addq	$0x20, %rsp
1800081a4:     	popq	%rdi
1800081a5:     	retq
1800081a6:     	movq	0x10(%rcx), %rax
1800081aa:     	cmpq	%rsi, %rax
1800081ad:     	jl	0x1800081c7 <numba_list_resize+0x47>
1800081af:     	sarq	%rax
1800081b2:     	cmpq	%rax, %rsi
1800081b5:     	jl	0x1800081c7 <numba_list_resize+0x47>
1800081b7:     	movq	%rsi, (%rcx)
1800081ba:     	xorl	%eax, %eax
1800081bc:     	movq	0x40(%rsp), %rsi
1800081c1:     	addq	$0x20, %rsp
1800081c5:     	popq	%rdi
1800081c6:     	retq
1800081c7:     	cmpq	$0x9, %rsi
1800081cb:     	movq	%rbp, 0x38(%rsp)
1800081d0:     	movl	$0x3, %ecx
1800081d5:     	movl	$0x6, %eax
1800081da:     	cmovll	%ecx, %eax
1800081dd:     	movq	%rsi, %r8
1800081e0:     	movq	0x8(%rdi), %rcx
1800081e4:     	addq	%rsi, %rax
1800081e7:     	sarq	$0x3, %r8
1800081eb:     	xorl	%edx, %edx
1800081ed:     	addq	%rax, %r8
1800081f0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
1800081fa:     	divq	%rcx
1800081fd:     	cmpq	%rax, %r8
180008200:     	ja	0x18000827b <numba_list_resize+0xfb>
180008202:     	xorl	%ebp, %ebp
180008204:     	movq	%rbx, 0x30(%rsp)
180008209:     	testq	%rsi, %rsi
18000820c:     	cmovneq	%r8, %rbp
180008210:     	movq	%rbp, %rbx
180008213:     	imulq	%rcx, %rbx
180008217:     	movl	$0x8, %ecx
18000821c:     	movq	%rbx, %rax
18000821f:     	cqto
180008221:     	andl	$0x7, %edx
180008224:     	addq	%rdx, %rax
180008227:     	andl	$0x7, %eax
18000822a:     	subq	%rdx, %rax
18000822d:     	subq	%rax, %rcx
180008230:     	movq	%rcx, %rax
180008233:     	movq	0x30(%rdi), %rcx
180008237:     	cqto
180008239:     	andl	$0x7, %edx
18000823c:     	addq	%rdx, %rax
18000823f:     	andl	$0x7, %eax
180008242:     	subq	%rdx, %rax
180008245:     	leaq	(%rbx,%rax), %rdx
180008249:     	callq	*0x1e11(%rip)           # 0x18000a060
18000824f:     	testq	%rbx, %rbx
180008252:     	movq	0x30(%rsp), %rbx
180008257:     	je	0x18000825e <numba_list_resize+0xde>
180008259:     	testq	%rax, %rax
18000825c:     	je	0x18000827b <numba_list_resize+0xfb>
18000825e:     	movq	%rax, 0x30(%rdi)
180008262:     	xorl	%eax, %eax
180008264:     	movq	%rbp, 0x10(%rdi)
180008268:     	movq	0x38(%rsp), %rbp
18000826d:     	movq	%rsi, (%rdi)
180008270:     	movq	0x40(%rsp), %rsi
180008275:     	addq	$0x20, %rsp
180008279:     	popq	%rdi
18000827a:     	retq
18000827b:     	movq	0x38(%rsp), %rbp
180008280:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180008285:     	movq	0x40(%rsp), %rsi
18000828a:     	addq	$0x20, %rsp
18000828e:     	popq	%rdi
18000828f:     	retq

0000000180008290 <numba_list_delitem>:
180008290:     	movq	%rbx, 0x10(%rsp)
180008295:     	pushq	%rdi
180008296:     	subq	$0x20, %rsp
18000829a:     	cmpl	$0x0, 0x18(%rcx)
18000829e:     	movq	%rdx, %rdi
1800082a1:     	movq	%rcx, %rbx
1800082a4:     	jne	0x1800082b6 <numba_list_delitem+0x26>
1800082a6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800082ab:     	movq	0x38(%rsp), %rbx
1800082b0:     	addq	$0x20, %rsp
1800082b4:     	popq	%rdi
1800082b5:     	retq
1800082b6:     	cmpq	(%rcx), %rdi
1800082b9:     	jb	0x1800082cb <numba_list_delitem+0x3b>
1800082bb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800082c0:     	movq	0x38(%rsp), %rbx
1800082c5:     	addq	$0x20, %rsp
1800082c9:     	popq	%rdi
1800082ca:     	retq
1800082cb:     	movq	0x28(%rcx), %rax
1800082cf:     	movq	%rsi, 0x30(%rsp)
1800082d4:     	movq	%rdi, %rsi
1800082d7:     	imulq	0x8(%rcx), %rsi
1800082dc:     	addq	0x30(%rcx), %rsi
1800082e0:     	testq	%rax, %rax
1800082e3:     	je	0x1800082ea <numba_list_delitem+0x5a>
1800082e5:     	movq	%rsi, %rcx
1800082e8:     	callq	*%rax
1800082ea:     	movq	(%rbx), %r8
1800082ed:     	leaq	-0x1(%r8), %rax
1800082f1:     	cmpq	%rax, %rdi
1800082f4:     	je	0x180008316 <numba_list_delitem+0x86>
1800082f6:     	subq	%rdi, %r8
1800082f9:     	leaq	0x1(%rdi), %rdx
1800082fd:     	imulq	0x8(%rbx), %rdx
180008302:     	decq	%r8
180008305:     	movq	%rsi, %rcx
180008308:     	imulq	0x8(%rbx), %r8
18000830d:     	addq	0x30(%rbx), %rdx
180008311:     	callq	0x180009441 <numba_list_iter_next+0xec1>
180008316:     	movq	(%rbx), %rdx
180008319:     	movq	%rbx, %rcx
18000831c:     	decq	%rdx
18000831f:     	callq	0x180008180 <numba_list_resize>
180008324:     	movq	0x30(%rsp), %rsi
180008329:     	xorl	%ecx, %ecx
18000832b:     	movq	0x38(%rsp), %rbx
180008330:     	testl	%eax, %eax
180008332:     	cmovsl	%eax, %ecx
180008335:     	movl	%ecx, %eax
180008337:     	addq	$0x20, %rsp
18000833b:     	popq	%rdi
18000833c:     	retq
18000833d:     	int3
18000833e:     	int3
18000833f:     	int3

0000000180008340 <numba_list_delete_slice>:
180008340:     	pushq	%rbx
180008342:     	pushq	%rbp
180008343:     	pushq	%rdi
180008344:     	pushq	%r15
180008346:     	subq	$0x38, %rsp
18000834a:     	cmpl	$0x0, 0x18(%rcx)
18000834e:     	movq	%r9, %rdi
180008351:     	movq	%r8, %rbp
180008354:     	movq	%rdx, %r15
180008357:     	movq	%rcx, %rbx
18000835a:     	jne	0x18000836b <numba_list_delete_slice+0x2b>
18000835c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180008361:     	addq	$0x38, %rsp
180008365:     	popq	%r15
180008367:     	popq	%rdi
180008368:     	popq	%rbp
180008369:     	popq	%rbx
18000836a:     	retq
18000836b:     	movq	%r13, 0x78(%rsp)
180008370:     	testq	%rdi, %rdi
180008373:     	jle	0x180008392 <numba_list_delete_slice+0x52>
180008375:     	cmpq	%r8, %r15
180008378:     	jge	0x180008531 <numba_list_delete_slice+0x1f1>
18000837e:     	movq	%r8, %rax
180008381:     	subq	%r15, %rax
180008384:     	decq	%rax
180008387:     	cqto
180008389:     	idivq	%rdi
18000838c:     	leal	0x1(%rax), %r13d
180008390:     	jmp	0x1800083b2 <numba_list_delete_slice+0x72>
180008392:     	cmpq	%r15, %r8
180008395:     	jge	0x180008531 <numba_list_delete_slice+0x1f1>
18000839b:     	movq	%r15, %rax
18000839e:     	movl	$0x1, %r13d
1800083a4:     	subq	%r8, %rax
1800083a7:     	decq	%rax
1800083aa:     	cqto
1800083ac:     	idivq	%rdi
1800083af:     	subl	%eax, %r13d
1800083b2:     	testl	%r13d, %r13d
1800083b5:     	jle	0x180008531 <numba_list_delete_slice+0x1f1>
1800083bb:     	movq	%rsi, 0x68(%rsp)
1800083c0:     	movl	(%rcx), %esi
1800083c2:     	subl	%r13d, %esi
1800083c5:     	movl	%esi, 0x20(%rsp)
1800083c9:     	testq	%rdi, %rdi
1800083cc:     	jns	0x1800083e7 <numba_list_delete_slice+0xa7>
1800083ce:     	leaq	0x1(%r15), %rbp
1800083d2:     	leal	-0x1(%r13), %eax
1800083d6:     	movslq	%eax, %rcx
1800083d9:     	leaq	-0x1(%rbp), %r15
1800083dd:     	imulq	%rdi, %rcx
1800083e1:     	addq	%rcx, %r15
1800083e4:     	negq	%rdi
1800083e7:     	cmpq	$0x1, %rdi
1800083eb:     	jne	0x180008437 <numba_list_delete_slice+0xf7>
1800083ed:     	cmpq	$0x0, 0x28(%rbx)
1800083f2:     	je	0x180008419 <numba_list_delete_slice+0xd9>
1800083f4:     	movslq	%r15d, %rdi
1800083f7:     	cmpq	%rbp, %rdi
1800083fa:     	jge	0x180008419 <numba_list_delete_slice+0xd9>
1800083fc:     	nopl	(%rax)
180008400:     	movslq	%edi, %rcx
180008403:     	imulq	0x8(%rbx), %rcx
180008408:     	addq	0x30(%rbx), %rcx
18000840c:     	callq	*0x28(%rbx)
18000840f:     	incl	%edi
180008411:     	movslq	%edi, %rax
180008414:     	cmpq	%rbp, %rax
180008417:     	jl	0x180008400 <numba_list_delete_slice+0xc0>
180008419:     	movq	0x8(%rbx), %rcx
18000841d:     	movq	(%rbx), %r8
180008420:     	movq	%rcx, %rdx
180008423:     	subq	%rbp, %r8
180008426:     	imulq	%rcx, %r8
18000842a:     	imulq	%rbp, %rdx
18000842e:     	imulq	%r15, %rcx
180008432:     	jmp	0x1800084fc <numba_list_delete_slice+0x1bc>
180008437:     	movq	%r14, 0x30(%rsp)
18000843c:     	movq	%r15, %r14
18000843f:     	movl	$0x0, 0x60(%rsp)
180008447:     	cmpq	%rbp, %r15
18000844a:     	jge	0x1800084c9 <numba_list_delete_slice+0x189>
18000844c:     	movq	%r12, 0x70(%rsp)
180008451:     	movq	(%rbx), %rax
180008454:     	leaq	(%r14,%rdi), %r12
180008458:     	cmpq	%rax, %r12
18000845b:     	jl	0x180008468 <numba_list_delete_slice+0x128>
18000845d:     	movq	%r14, %rsi
180008460:     	notq	%rsi
180008463:     	addq	%rax, %rsi
180008466:     	jmp	0x18000846c <numba_list_delete_slice+0x12c>
180008468:     	leaq	-0x1(%rdi), %rsi
18000846c:     	movq	0x28(%rbx), %rax
180008470:     	testq	%rax, %rax
180008473:     	je	0x180008483 <numba_list_delete_slice+0x143>
180008475:     	movq	%r14, %rcx
180008478:     	imulq	0x8(%rbx), %rcx
18000847d:     	addq	0x30(%rbx), %rcx
180008481:     	callq	*%rax
180008483:     	movq	0x8(%rbx), %r9
180008487:     	leaq	0x1(%r14), %rdx
18000848b:     	movq	0x30(%rbx), %r10
18000848f:     	movq	%r9, %r8
180008492:     	imulq	%rsi, %r8
180008496:     	imulq	%r9, %rdx
18000849a:     	movslq	0x60(%rsp), %rsi
18000849f:     	subq	%rsi, %r14
1800084a2:     	imulq	%r9, %r14
1800084a6:     	addq	%r10, %rdx
1800084a9:     	leaq	(%r10,%r14), %rcx
1800084ad:     	callq	0x180009441 <numba_list_iter_next+0xec1>
1800084b2:     	incl	%esi
1800084b4:     	movq	%r12, %r14
1800084b7:     	movl	%esi, 0x60(%rsp)
1800084bb:     	cmpq	%rbp, %r12
1800084be:     	jl	0x180008451 <numba_list_delete_slice+0x111>
1800084c0:     	movq	0x70(%rsp), %r12
1800084c5:     	movl	0x20(%rsp), %esi
1800084c9:     	movq	(%rbx), %r8
1800084cc:     	movq	0x30(%rsp), %r14
1800084d1:     	movslq	%r13d, %r10
1800084d4:     	movq	%r10, %rcx
1800084d7:     	imulq	%rdi, %rcx
1800084db:     	addq	%r15, %rcx
1800084de:     	cmpq	%r8, %rcx
1800084e1:     	jge	0x180008509 <numba_list_delete_slice+0x1c9>
1800084e3:     	movq	0x8(%rbx), %rax
1800084e7:     	subq	%rcx, %r8
1800084ea:     	movq	%rax, %rdx
1800084ed:     	imulq	%rcx, %rdx
1800084f1:     	imulq	%rax, %r8
1800084f5:     	subq	%r10, %rcx
1800084f8:     	imulq	%rax, %rcx
1800084fc:     	addq	0x30(%rbx), %rdx
180008500:     	addq	0x30(%rbx), %rcx
180008504:     	callq	0x180009441 <numba_list_iter_next+0xec1>
180008509:     	movslq	%esi, %rdx
18000850c:     	movq	%rbx, %rcx
18000850f:     	callq	0x180008180 <numba_list_resize>
180008514:     	movq	0x68(%rsp), %rsi
180008519:     	xorl	%ecx, %ecx
18000851b:     	movq	0x78(%rsp), %r13
180008520:     	testl	%eax, %eax
180008522:     	cmovsl	%eax, %ecx
180008525:     	movl	%ecx, %eax
180008527:     	addq	$0x38, %rsp
18000852b:     	popq	%r15
18000852d:     	popq	%rdi
18000852e:     	popq	%rbp
18000852f:     	popq	%rbx
180008530:     	retq
180008531:     	movq	0x78(%rsp), %r13
180008536:     	xorl	%eax, %eax
180008538:     	addq	$0x38, %rsp
18000853c:     	popq	%r15
18000853e:     	popq	%rdi
18000853f:     	popq	%rbp
180008540:     	popq	%rbx
180008541:     	retq
180008542:     	int3
180008543:     	int3
180008544:     	int3
180008545:     	int3
180008546:     	int3
180008547:     	int3
180008548:     	int3
180008549:     	int3
18000854a:     	int3
18000854b:     	int3
18000854c:     	int3
18000854d:     	int3
18000854e:     	int3
18000854f:     	int3

0000000180008550 <numba_list_iter_sizeof>:
180008550:     	movl	$0x18, %eax
180008555:     	retq
180008556:     	int3
180008557:     	int3
180008558:     	int3
180008559:     	int3
18000855a:     	int3
18000855b:     	int3
18000855c:     	int3
18000855d:     	int3
18000855e:     	int3
18000855f:     	int3

0000000180008560 <numba_list_iter>:
180008560:     	movq	%rdx, (%rcx)
180008563:     	movq	(%rdx), %rax
180008566:     	movq	%rax, 0x8(%rcx)
18000856a:     	movq	$0x0, 0x10(%rcx)
180008572:     	retq
180008573:     	int3
180008574:     	int3
180008575:     	int3
180008576:     	int3
180008577:     	int3
180008578:     	int3
180008579:     	int3
18000857a:     	int3
18000857b:     	int3
18000857c:     	int3
18000857d:     	int3
18000857e:     	int3
18000857f:     	int3

0000000180008580 <numba_list_iter_next>:
180008580:     	movq	(%rcx), %r8
180008583:     	movq	(%r8), %r9
180008586:     	cmpq	0x8(%rcx), %r9
18000858a:     	je	0x180008592 <numba_list_iter_next+0x12>
18000858c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180008591:     	retq
180008592:     	movq	0x10(%rcx), %rax
180008596:     	cmpq	%r9, %rax
180008599:     	jge	0x1800085ae <numba_list_iter_next+0x2e>
18000859b:     	imulq	0x8(%r8), %rax
1800085a0:     	addq	0x30(%r8), %rax
1800085a4:     	movq	%rax, (%rdx)
1800085a7:     	incq	0x10(%rcx)
1800085ab:     	xorl	%eax, %eax
1800085ad:     	retq
1800085ae:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
1800085b3:     	retq
1800085b4:     	int3
1800085b5:     	int3
1800085b6:     	int3
1800085b7:     	int3
1800085b8:     	int3
1800085b9:     	int3
1800085ba:     	int3
1800085bb:     	int3
1800085bc:     	int3
1800085bd:     	int3
1800085be:     	int3
1800085bf:     	int3
1800085c0:     	pushq	%rbx
1800085c2:     	subq	$0x20, %rsp
1800085c6:     	movq	%rcx, %rbx
1800085c9:     	addq	$0x30, %rcx
1800085cd:     	callq	*0x9655(%rip)           # 0x180011c28
1800085d3:     	cmpb	$0x0, 0x9626(%rip)      # 0x180011c00
1800085da:     	je	0x1800085e4 <numba_list_iter_next+0x64>
1800085dc:     	lock
1800085dd:     	incq	0x9624(%rip)            # 0x180011c08
1800085e4:     	testq	%rax, %rax
1800085e7:     	je	0x180008628 <numba_list_iter_next+0xa8>
1800085e9:     	leaq	0x30(%rax), %rdx
1800085ed:     	testq	%rdx, %rdx
1800085f0:     	je	0x180008628 <numba_list_iter_next+0xa8>
1800085f2:     	xorl	%r8d, %r8d
1800085f5:     	movl	$0x1, %ecx
1800085fa:     	xchgq	%rcx, (%rax)
1800085fd:     	movq	%r8, 0x8(%rax)
180008601:     	movq	%r8, 0x10(%rax)
180008605:     	movq	%rdx, 0x18(%rax)
180008609:     	movq	%rbx, 0x20(%rax)
18000860d:     	movq	%r8, 0x28(%rax)
180008611:     	cmpb	%r8b, 0x95e8(%rip)      # 0x180011c00
180008618:     	je	0x18000862a <numba_list_iter_next+0xaa>
18000861a:     	lock
18000861b:     	incq	0x95f6(%rip)            # 0x180011c18
180008622:     	addq	$0x20, %rsp
180008626:     	popq	%rbx
180008627:     	retq
180008628:     	xorl	%eax, %eax
18000862a:     	addq	$0x20, %rsp
18000862e:     	popq	%rbx
18000862f:     	retq
180008630:     	movq	%rbx, 0x8(%rsp)
180008635:     	pushq	%rdi
180008636:     	subq	$0x20, %rsp
18000863a:     	movq	%rcx, %rdi
18000863d:     	movq	%rdx, %rbx
180008640:     	addq	$0x30, %rcx
180008644:     	testq	%rdx, %rdx
180008647:     	je	0x180008651 <numba_list_iter_next+0xd1>
180008649:     	movq	0x18(%rdx), %rdx
18000864d:     	callq	*(%rbx)
18000864f:     	jmp	0x180008657 <numba_list_iter_next+0xd7>
180008651:     	callq	*0x95d1(%rip)           # 0x180011c28
180008657:     	cmpb	$0x0, 0x95a2(%rip)      # 0x180011c00
18000865e:     	movq	%rax, %r8
180008661:     	je	0x18000866b <numba_list_iter_next+0xeb>
180008663:     	lock
180008664:     	incq	0x959d(%rip)            # 0x180011c08
18000866b:     	xorl	%edx, %edx
18000866d:     	leaq	0x30(%r8), %rax
180008671:     	testq	%r8, %r8
180008674:     	movl	%edx, %ecx
180008676:     	cmovneq	%rax, %rcx
18000867a:     	testq	%rcx, %rcx
18000867d:     	jne	0x18000868c <numba_list_iter_next+0x10c>
18000867f:     	xorl	%eax, %eax
180008681:     	movq	0x30(%rsp), %rbx
180008686:     	addq	$0x20, %rsp
18000868a:     	popq	%rdi
18000868b:     	retq
18000868c:     	movl	$0x1, %eax
180008691:     	xchgq	%rax, (%r8)
180008694:     	movq	%rdx, 0x8(%r8)
180008698:     	movq	%rdx, 0x10(%r8)
18000869c:     	movq	%rcx, 0x18(%r8)
1800086a0:     	movq	%rdi, 0x20(%r8)
1800086a4:     	movq	%rbx, 0x28(%r8)
1800086a8:     	cmpb	%dl, 0x9552(%rip)       # 0x180011c00
1800086ae:     	je	0x1800086b8 <numba_list_iter_next+0x138>
1800086b0:     	lock
1800086b1:     	incq	0x9560(%rip)            # 0x180011c18
1800086b8:     	movq	0x30(%rsp), %rbx
1800086bd:     	movq	%r8, %rax
1800086c0:     	addq	$0x20, %rsp
1800086c4:     	popq	%rdi
1800086c5:     	retq
1800086c6:     	int3
1800086c7:     	int3
1800086c8:     	int3
1800086c9:     	int3
1800086ca:     	int3
1800086cb:     	int3
1800086cc:     	int3
1800086cd:     	int3
1800086ce:     	int3
1800086cf:     	int3
1800086d0:     	lock
1800086d1:     	incq	(%rcx)
1800086d4:     	retq
1800086d5:     	int3
1800086d6:     	int3
1800086d7:     	int3
1800086d8:     	int3
1800086d9:     	int3
1800086da:     	int3
1800086db:     	int3
1800086dc:     	int3
1800086dd:     	int3
1800086de:     	int3
1800086df:     	int3
1800086e0:     	pushq	%rbx
1800086e2:     	subq	$0x20, %rsp
1800086e6:     	movq	0x8(%rcx), %rax
1800086ea:     	movq	%rcx, %rbx
1800086ed:     	testq	%rax, %rax
1800086f0:     	je	0x180008709 <numba_list_iter_next+0x189>
1800086f2:     	cmpl	$0x0, 0x94ff(%rip)      # 0x180011bf8
1800086f9:     	jne	0x180008709 <numba_list_iter_next+0x189>
1800086fb:     	movq	0x10(%rcx), %r8
1800086ff:     	movq	0x20(%rcx), %rdx
180008703:     	movq	0x18(%rcx), %rcx
180008707:     	callq	*%rax
180008709:     	movq	0x28(%rbx), %rax
18000870d:     	movq	%rbx, %rcx
180008710:     	testq	%rax, %rax
180008713:     	je	0x18000871e <numba_list_iter_next+0x19e>
180008715:     	movq	0x18(%rax), %rdx
180008719:     	callq	*0x10(%rax)
18000871c:     	jmp	0x180008724 <numba_list_iter_next+0x1a4>
18000871e:     	callq	*0x9514(%rip)           # 0x180011c38
180008724:     	cmpb	$0x0, 0x94d5(%rip)      # 0x180011c00
18000872b:     	je	0x180008749 <numba_list_iter_next+0x1c9>
18000872d:     	leaq	0x94dc(%rip), %rax      # 0x180011c10
180008734:     	lock
180008735:     	incq	(%rax)
180008738:     	cmpb	$0x0, 0x94c1(%rip)      # 0x180011c00
18000873f:     	je	0x180008749 <numba_list_iter_next+0x1c9>
180008741:     	lock
180008742:     	incq	0x94d7(%rip)            # 0x180011c20
180008749:     	addq	$0x20, %rsp
18000874d:     	popq	%rbx
18000874e:     	retq
18000874f:     	int3
180008750:     	pushq	%rbx
180008752:     	subq	$0x20, %rsp
180008756:     	movq	%rcx, %rbx
180008759:     	movq	$-0x1, %rax
180008760:     	lock
180008761:     	xaddq	%rax, (%rcx)
180008765:     	cmpq	$0x1, %rax
180008769:     	jne	0x1800087cb <numba_list_iter_next+0x24b>
18000876b:     	movq	0x8(%rcx), %rax
18000876f:     	testq	%rax, %rax
180008772:     	je	0x18000878b <numba_list_iter_next+0x20b>
180008774:     	cmpl	$0x0, 0x947d(%rip)      # 0x180011bf8
18000877b:     	jne	0x18000878b <numba_list_iter_next+0x20b>
18000877d:     	movq	0x10(%rcx), %r8
180008781:     	movq	0x20(%rcx), %rdx
180008785:     	movq	0x18(%rcx), %rcx
180008789:     	callq	*%rax
18000878b:     	movq	0x28(%rbx), %rax
18000878f:     	movq	%rbx, %rcx
180008792:     	testq	%rax, %rax
180008795:     	je	0x1800087a0 <numba_list_iter_next+0x220>
180008797:     	movq	0x18(%rax), %rdx
18000879b:     	callq	*0x10(%rax)
18000879e:     	jmp	0x1800087a6 <numba_list_iter_next+0x226>
1800087a0:     	callq	*0x9492(%rip)           # 0x180011c38
1800087a6:     	cmpb	$0x0, 0x9453(%rip)      # 0x180011c00
1800087ad:     	je	0x1800087cb <numba_list_iter_next+0x24b>
1800087af:     	leaq	0x945a(%rip), %rax      # 0x180011c10
1800087b6:     	lock
1800087b7:     	incq	(%rax)
1800087ba:     	cmpb	$0x0, 0x943f(%rip)      # 0x180011c00
1800087c1:     	je	0x1800087cb <numba_list_iter_next+0x24b>
1800087c3:     	lock
1800087c4:     	incq	0x9455(%rip)            # 0x180011c20
1800087cb:     	addq	$0x20, %rsp
1800087cf:     	popq	%rbx
1800087d0:     	retq
1800087d1:     	int3
1800087d2:     	int3
1800087d3:     	int3
1800087d4:     	int3
1800087d5:     	int3
1800087d6:     	int3
1800087d7:     	int3
1800087d8:     	int3
1800087d9:     	int3
1800087da:     	int3
1800087db:     	int3
1800087dc:     	int3
1800087dd:     	int3
1800087de:     	int3
1800087df:     	int3
1800087e0:     	movq	0x18(%rcx), %rax
1800087e4:     	retq
1800087e5:     	int3
1800087e6:     	int3
1800087e7:     	int3
1800087e8:     	int3
1800087e9:     	int3
1800087ea:     	int3
1800087eb:     	int3
1800087ec:     	int3
1800087ed:     	int3
1800087ee:     	int3
1800087ef:     	int3
1800087f0:     	subq	$0x28, %rsp
1800087f4:     	callq	*0x943e(%rip)           # 0x180011c38
1800087fa:     	cmpb	$0x0, 0x93ff(%rip)      # 0x180011c00
180008801:     	je	0x18000880b <numba_list_iter_next+0x28b>
180008803:     	lock
180008804:     	incq	0x9405(%rip)            # 0x180011c10
18000880b:     	addq	$0x28, %rsp
18000880f:     	retq
180008810:     	jmpq	*%r8
180008813:     	int3
180008814:     	int3
180008815:     	int3
180008816:     	int3
180008817:     	int3
180008818:     	int3
180008819:     	int3
18000881a:     	int3
18000881b:     	int3
18000881c:     	int3
18000881d:     	int3
18000881e:     	int3
18000881f:     	int3
180008820:     	movq	%rbx, 0x8(%rsp)
180008825:     	pushq	%rdi
180008826:     	subq	$0x20, %rsp
18000882a:     	movq	%rcx, %rdi
18000882d:     	movq	%rdx, %rbx
180008830:     	movl	$0x30, %ecx
180008835:     	callq	*0x93ed(%rip)           # 0x180011c28
18000883b:     	cmpb	$0x0, 0x93be(%rip)      # 0x180011c00
180008842:     	je	0x18000884c <numba_list_iter_next+0x2cc>
180008844:     	lock
180008845:     	incq	0x93bc(%rip)            # 0x180011c08
18000884c:     	testq	%rax, %rax
18000884f:     	je	0x180008886 <numba_list_iter_next+0x306>
180008851:     	leaq	-0x48(%rip), %rcx       # 0x180008810 <numba_list_iter_next+0x290>
180008858:     	movl	$0x1, %edx
18000885d:     	xchgq	%rdx, (%rax)
180008860:     	movq	%rcx, 0x8(%rax)
180008864:     	xorl	%ecx, %ecx
180008866:     	movq	%rcx, 0x20(%rax)
18000886a:     	movq	%rcx, 0x28(%rax)
18000886e:     	movq	%rbx, 0x10(%rax)
180008872:     	movq	%rdi, 0x18(%rax)
180008876:     	cmpb	%cl, 0x9384(%rip)       # 0x180011c00
18000887c:     	je	0x180008886 <numba_list_iter_next+0x306>
18000887e:     	lock
18000887f:     	incq	0x9392(%rip)            # 0x180011c18
180008886:     	movq	0x30(%rsp), %rbx
18000888b:     	addq	$0x20, %rsp
18000888f:     	popq	%rdi
180008890:     	retq
180008891:     	jmpq	*0x1a79(%rip)           # 0x18000a310
180008897:     	jmpq	*0x1a63(%rip)           # 0x18000a300
18000889d:     	jmpq	*0x1a55(%rip)           # 0x18000a2f8
1800088a3:     	jmpq	*0x1a47(%rip)           # 0x18000a2f0
1800088a9:     	jmpq	*0x1a39(%rip)           # 0x18000a2e8
1800088af:     	jmpq	*0x1a23(%rip)           # 0x18000a2d8
1800088b5:     	jmpq	*0x1a15(%rip)           # 0x18000a2d0
1800088bb:     	jmpq	*0x1a07(%rip)           # 0x18000a2c8
1800088c1:     	jmpq	*0x19f1(%rip)           # 0x18000a2b8
1800088c7:     	jmpq	*0x19cb(%rip)           # 0x18000a298
1800088cd:     	jmpq	*0x19bd(%rip)           # 0x18000a290
1800088d3:     	jmpq	*0x19af(%rip)           # 0x18000a288
1800088d9:     	jmpq	*0x19a1(%rip)           # 0x18000a280
1800088df:     	jmpq	*0x195b(%rip)           # 0x18000a240
1800088e5:     	int3
1800088e6:     	int3
1800088e7:     	int3
1800088e8:     	int3
1800088e9:     	int3
1800088ea:     	int3
1800088eb:     	int3
1800088ec:     	int3
1800088ed:     	int3
1800088ee:     	int3
1800088ef:     	int3
1800088f0:     	int3
1800088f1:     	int3
1800088f2:     	int3
1800088f3:     	int3
1800088f4:     	int3
1800088f5:     	int3
1800088f6:     	nopw	(%rax,%rax)
180008900:     	cmpq	0x87b9(%rip), %rcx      # 0x1800110c0
180008907:     	jne	0x180008919 <numba_list_iter_next+0x399>
180008909:     	rolq	$0x10, %rcx
18000890d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180008912:     	jne	0x180008915 <numba_list_iter_next+0x395>
180008914:     	retq
180008915:     	rorq	$0x10, %rcx
180008919:     	jmp	0x180008c74 <numba_list_iter_next+0x6f4>
18000891e:     	int3
18000891f:     	int3
180008920:     	subq	$0x28, %rsp
180008924:     	testl	%edx, %edx
180008926:     	je	0x180008961 <numba_list_iter_next+0x3e1>
180008928:     	subl	$0x1, %edx
18000892b:     	je	0x180008955 <numba_list_iter_next+0x3d5>
18000892d:     	subl	$0x1, %edx
180008930:     	je	0x180008948 <numba_list_iter_next+0x3c8>
180008932:     	cmpl	$0x1, %edx
180008935:     	je	0x180008941 <numba_list_iter_next+0x3c1>
180008937:     	movl	$0x1, %eax
18000893c:     	addq	$0x28, %rsp
180008940:     	retq
180008941:     	callq	0x180008e40 <numba_list_iter_next+0x8c0>
180008946:     	jmp	0x18000894d <numba_list_iter_next+0x3cd>
180008948:     	callq	0x180008e18 <numba_list_iter_next+0x898>
18000894d:     	movzbl	%al, %eax
180008950:     	addq	$0x28, %rsp
180008954:     	retq
180008955:     	movq	%r8, %rdx
180008958:     	addq	$0x28, %rsp
18000895c:     	jmp	0x180008970 <numba_list_iter_next+0x3f0>
180008961:     	testq	%r8, %r8
180008964:     	setne	%cl
180008967:     	addq	$0x28, %rsp
18000896b:     	jmp	0x180008a88 <numba_list_iter_next+0x508>
180008970:     	movq	%rbx, 0x8(%rsp)
180008975:     	movq	%rsi, 0x10(%rsp)
18000897a:     	movq	%rdi, 0x20(%rsp)
18000897f:     	pushq	%r14
180008981:     	subq	$0x20, %rsp
180008985:     	movq	%rdx, %rsi
180008988:     	movq	%rcx, %r14
18000898b:     	xorl	%ecx, %ecx
18000898d:     	callq	0x180008efc <numba_list_iter_next+0x97c>
180008992:     	testb	%al, %al
180008994:     	je	0x180008a62 <numba_list_iter_next+0x4e2>
18000899a:     	callq	0x180008d90 <numba_list_iter_next+0x810>
18000899f:     	movb	%al, %bl
1800089a1:     	movb	%al, 0x40(%rsp)
1800089a5:     	movb	$0x1, %dil
1800089a8:     	cmpl	$0x0, 0x9019(%rip)      # 0x1800119c8
1800089af:     	jne	0x180008a7a <numba_list_iter_next+0x4fa>
1800089b5:     	movl	$0x1, 0x9009(%rip)      # 0x1800119c8
1800089bf:     	callq	0x180008e00 <numba_list_iter_next+0x880>
1800089c4:     	testb	%al, %al
1800089c6:     	je	0x180008a17 <numba_list_iter_next+0x497>
1800089c8:     	callq	0x1800090bc <numba_list_iter_next+0xb3c>
1800089cd:     	callq	0x180008d50 <numba_list_iter_next+0x7d0>
1800089d2:     	callq	0x180008d74 <numba_list_iter_next+0x7f4>
1800089d7:     	leaq	0x1992(%rip), %rdx      # 0x18000a370
1800089de:     	leaq	0x1983(%rip), %rcx      # 0x18000a368
1800089e5:     	callq	0x180009408 <numba_list_iter_next+0xe88>
1800089ea:     	testl	%eax, %eax
1800089ec:     	jne	0x180008a17 <numba_list_iter_next+0x497>
1800089ee:     	callq	0x180008dcc <numba_list_iter_next+0x84c>
1800089f3:     	testb	%al, %al
1800089f5:     	je	0x180008a17 <numba_list_iter_next+0x497>
1800089f7:     	leaq	0x1962(%rip), %rdx      # 0x18000a360
1800089fe:     	leaq	0x1953(%rip), %rcx      # 0x18000a358
180008a05:     	callq	0x180009402 <numba_list_iter_next+0xe82>
180008a0a:     	movl	$0x2, 0x8fb4(%rip)      # 0x1800119c8
180008a14:     	xorb	%dil, %dil
180008a17:     	movb	%bl, %cl
180008a19:     	callq	0x18000905c <numba_list_iter_next+0xadc>
180008a1e:     	testb	%dil, %dil
180008a21:     	jne	0x180008a62 <numba_list_iter_next+0x4e2>
180008a23:     	callq	0x1800090ac <numba_list_iter_next+0xb2c>
180008a28:     	movq	%rax, %rbx
180008a2b:     	cmpq	$0x0, (%rax)
180008a2f:     	je	0x180008a55 <numba_list_iter_next+0x4d5>
180008a31:     	movq	%rax, %rcx
180008a34:     	callq	0x180008fc4 <numba_list_iter_next+0xa44>
180008a39:     	testb	%al, %al
180008a3b:     	je	0x180008a55 <numba_list_iter_next+0x4d5>
180008a3d:     	movq	%rsi, %r8
180008a40:     	movl	$0x2, %edx
180008a45:     	movq	%r14, %rcx
180008a48:     	movq	(%rbx), %rax
180008a4b:     	movq	0x18de(%rip), %r9       # 0x18000a330
180008a52:     	callq	*%r9
180008a55:     	incl	0x8f45(%rip)            # 0x1800119a0
180008a5b:     	movl	$0x1, %eax
180008a60:     	jmp	0x180008a64 <numba_list_iter_next+0x4e4>
180008a62:     	xorl	%eax, %eax
180008a64:     	movq	0x30(%rsp), %rbx
180008a69:     	movq	0x38(%rsp), %rsi
180008a6e:     	movq	0x48(%rsp), %rdi
180008a73:     	addq	$0x20, %rsp
180008a77:     	popq	%r14
180008a79:     	retq
180008a7a:     	movl	$0x7, %ecx
180008a7f:     	callq	0x1800090b4 <numba_list_iter_next+0xb34>
180008a84:     	nop
180008a85:     	int3
180008a86:     	int3
180008a87:     	int3
180008a88:     	movq	%rbx, 0x8(%rsp)
180008a8d:     	pushq	%rdi
180008a8e:     	subq	$0x30, %rsp
180008a92:     	movb	%cl, %dil
180008a95:     	movl	0x8f05(%rip), %eax      # 0x1800119a0
180008a9b:     	testl	%eax, %eax
180008a9d:     	jg	0x180008aac <numba_list_iter_next+0x52c>
180008a9f:     	xorl	%eax, %eax
180008aa1:     	movq	0x40(%rsp), %rbx
180008aa6:     	addq	$0x30, %rsp
180008aaa:     	popq	%rdi
180008aab:     	retq
180008aac:     	decl	%eax
180008aae:     	movl	%eax, 0x8eec(%rip)      # 0x1800119a0
180008ab4:     	callq	0x180008d90 <numba_list_iter_next+0x810>
180008ab9:     	movb	%al, %bl
180008abb:     	movb	%al, 0x20(%rsp)
180008abf:     	cmpl	$0x2, 0x8f02(%rip)      # 0x1800119c8
180008ac6:     	jne	0x180008afe <numba_list_iter_next+0x57e>
180008ac8:     	callq	0x180008eb8 <numba_list_iter_next+0x938>
180008acd:     	callq	0x180008d60 <numba_list_iter_next+0x7e0>
180008ad2:     	callq	0x1800090f8 <numba_list_iter_next+0xb78>
180008ad7:     	movl	$0x0, 0x8ee7(%rip)      # 0x1800119c8
180008ae1:     	movb	%bl, %cl
180008ae3:     	callq	0x18000905c <numba_list_iter_next+0xadc>
180008ae8:     	xorl	%edx, %edx
180008aea:     	movb	%dil, %cl
180008aed:     	callq	0x180009080 <numba_list_iter_next+0xb00>
180008af2:     	movzbl	%al, %ebx
180008af5:     	callq	0x180008ee8 <numba_list_iter_next+0x968>
180008afa:     	movl	%ebx, %eax
180008afc:     	jmp	0x180008aa1 <numba_list_iter_next+0x521>
180008afe:     	movl	$0x7, %ecx
180008b03:     	callq	0x1800090b4 <numba_list_iter_next+0xb34>
180008b08:     	nop
180008b09:     	nop
180008b0a:     	int3
180008b0b:     	int3
180008b0c:     	movq	%rsp, %rax
180008b0f:     	movq	%rbx, 0x20(%rax)
180008b13:     	movq	%r8, 0x18(%rax)
180008b17:     	movl	%edx, 0x10(%rax)
180008b1a:     	movq	%rcx, 0x8(%rax)
180008b1e:     	pushq	%rsi
180008b1f:     	pushq	%rdi
180008b20:     	pushq	%r14
180008b22:     	subq	$0x40, %rsp
180008b26:     	movq	%r8, %rsi
180008b29:     	movl	%edx, %edi
180008b2b:     	movq	%rcx, %r14
180008b2e:     	testl	%edx, %edx
180008b30:     	jne	0x180008b41 <numba_list_iter_next+0x5c1>
180008b32:     	cmpl	%edx, 0x8e68(%rip)      # 0x1800119a0
180008b38:     	jg	0x180008b41 <numba_list_iter_next+0x5c1>
180008b3a:     	xorl	%eax, %eax
180008b3c:     	jmp	0x180008c26 <numba_list_iter_next+0x6a6>
180008b41:     	leal	-0x1(%rdx), %eax
180008b44:     	cmpl	$0x1, %eax
180008b47:     	ja	0x180008b89 <numba_list_iter_next+0x609>
180008b49:     	movq	0x1cb8(%rip), %rax      # 0x18000a808
180008b50:     	testq	%rax, %rax
180008b53:     	jne	0x180008b5a <numba_list_iter_next+0x5da>
180008b55:     	leal	0x1(%rax), %ebx
180008b58:     	jmp	0x180008b62 <numba_list_iter_next+0x5e2>
180008b5a:     	callq	*0x17d0(%rip)           # 0x18000a330
180008b60:     	movl	%eax, %ebx
180008b62:     	movl	%ebx, 0x30(%rsp)
180008b66:     	testl	%ebx, %ebx
180008b68:     	je	0x180008c1c <numba_list_iter_next+0x69c>
180008b6e:     	movq	%rsi, %r8
180008b71:     	movl	%edi, %edx
180008b73:     	movq	%r14, %rcx
180008b76:     	callq	0x180008920 <numba_list_iter_next+0x3a0>
180008b7b:     	movl	%eax, %ebx
180008b7d:     	movl	%eax, 0x30(%rsp)
180008b81:     	testl	%eax, %eax
180008b83:     	je	0x180008c1c <numba_list_iter_next+0x69c>
180008b89:     	movq	%rsi, %r8
180008b8c:     	movl	%edi, %edx
180008b8e:     	movq	%r14, %rcx
180008b91:     	callq	0x180008d2c <numba_list_iter_next+0x7ac>
180008b96:     	movl	%eax, %ebx
180008b98:     	movl	%eax, 0x30(%rsp)
180008b9c:     	cmpl	$0x1, %edi
180008b9f:     	jne	0x180008bd7 <numba_list_iter_next+0x657>
180008ba1:     	testl	%eax, %eax
180008ba3:     	jne	0x180008bd7 <numba_list_iter_next+0x657>
180008ba5:     	movq	%rsi, %r8
180008ba8:     	xorl	%edx, %edx
180008baa:     	movq	%r14, %rcx
180008bad:     	callq	0x180008d2c <numba_list_iter_next+0x7ac>
180008bb2:     	testq	%rsi, %rsi
180008bb5:     	setne	%cl
180008bb8:     	callq	0x180008a88 <numba_list_iter_next+0x508>
180008bbd:     	movq	0x1c44(%rip), %rax      # 0x18000a808
180008bc4:     	testq	%rax, %rax
180008bc7:     	je	0x180008bd7 <numba_list_iter_next+0x657>
180008bc9:     	movq	%rsi, %r8
180008bcc:     	xorl	%edx, %edx
180008bce:     	movq	%r14, %rcx
180008bd1:     	callq	*0x1759(%rip)           # 0x18000a330
180008bd7:     	testl	%edi, %edi
180008bd9:     	je	0x180008be0 <numba_list_iter_next+0x660>
180008bdb:     	cmpl	$0x3, %edi
180008bde:     	jne	0x180008c1c <numba_list_iter_next+0x69c>
180008be0:     	movq	%rsi, %r8
180008be3:     	movl	%edi, %edx
180008be5:     	movq	%r14, %rcx
180008be8:     	callq	0x180008920 <numba_list_iter_next+0x3a0>
180008bed:     	movl	%eax, %ebx
180008bef:     	movl	%eax, 0x30(%rsp)
180008bf3:     	testl	%eax, %eax
180008bf5:     	je	0x180008c1c <numba_list_iter_next+0x69c>
180008bf7:     	movq	0x1c0a(%rip), %rax      # 0x18000a808
180008bfe:     	testq	%rax, %rax
180008c01:     	jne	0x180008c08 <numba_list_iter_next+0x688>
180008c03:     	leal	0x1(%rax), %ebx
180008c06:     	jmp	0x180008c18 <numba_list_iter_next+0x698>
180008c08:     	movq	%rsi, %r8
180008c0b:     	movl	%edi, %edx
180008c0d:     	movq	%r14, %rcx
180008c10:     	callq	*0x171a(%rip)           # 0x18000a330
180008c16:     	movl	%eax, %ebx
180008c18:     	movl	%ebx, 0x30(%rsp)
180008c1c:     	jmp	0x180008c24 <numba_list_iter_next+0x6a4>
180008c1e:     	xorl	%ebx, %ebx
180008c20:     	movl	%ebx, 0x30(%rsp)
180008c24:     	movl	%ebx, %eax
180008c26:     	movq	0x78(%rsp), %rbx
180008c2b:     	addq	$0x40, %rsp
180008c2f:     	popq	%r14
180008c31:     	popq	%rdi
180008c32:     	popq	%rsi
180008c33:     	retq
180008c34:     	movq	%rbx, 0x8(%rsp)
180008c39:     	movq	%rsi, 0x10(%rsp)
180008c3e:     	pushq	%rdi
180008c3f:     	subq	$0x20, %rsp
180008c43:     	movq	%r8, %rdi
180008c46:     	movl	%edx, %ebx
180008c48:     	movq	%rcx, %rsi
180008c4b:     	cmpl	$0x1, %edx
180008c4e:     	jne	0x180008c55 <numba_list_iter_next+0x6d5>
180008c50:     	callq	0x180008c7c <numba_list_iter_next+0x6fc>
180008c55:     	movq	%rdi, %r8
180008c58:     	movl	%ebx, %edx
180008c5a:     	movq	%rsi, %rcx
180008c5d:     	movq	0x30(%rsp), %rbx
180008c62:     	movq	0x38(%rsp), %rsi
180008c67:     	addq	$0x20, %rsp
180008c6b:     	popq	%rdi
180008c6c:     	jmp	0x180008b0c <numba_list_iter_next+0x58c>
180008c71:     	int3
180008c72:     	int3
180008c73:     	int3
180008c74:     	movl	$0x2, %ecx
180008c79:     	int	$0x29
180008c7b:     	retq
180008c7c:     	movq	%rbx, 0x18(%rsp)
180008c81:     	pushq	%rbp
180008c82:     	movq	%rsp, %rbp
180008c85:     	subq	$0x30, %rsp
180008c89:     	movq	0x8430(%rip), %rax      # 0x1800110c0
180008c90:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
180008c9a:     	cmpq	%rbx, %rax
180008c9d:     	jne	0x180008d16 <numba_list_iter_next+0x796>
180008c9f:     	leaq	0x10(%rbp), %rcx
180008ca3:     	movq	$0x0, 0x10(%rbp)
180008cab:     	callq	*0x1377(%rip)           # 0x18000a028
180008cb1:     	movq	0x10(%rbp), %rax
180008cb5:     	movq	%rax, -0x10(%rbp)
180008cb9:     	callq	*0x1351(%rip)           # 0x18000a010
180008cbf:     	movl	%eax, %eax
180008cc1:     	xorq	%rax, -0x10(%rbp)
180008cc5:     	callq	*0x133d(%rip)           # 0x18000a008
180008ccb:     	movl	%eax, %eax
180008ccd:     	leaq	0x18(%rbp), %rcx
180008cd1:     	xorq	%rax, -0x10(%rbp)
180008cd5:     	callq	*0x1325(%rip)           # 0x18000a000
180008cdb:     	movl	0x18(%rbp), %eax
180008cde:     	leaq	-0x10(%rbp), %rcx
180008ce2:     	shlq	$0x20, %rax
180008ce6:     	xorq	0x18(%rbp), %rax
180008cea:     	xorq	-0x10(%rbp), %rax
180008cee:     	xorq	%rcx, %rax
180008cf1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
180008cfb:     	andq	%rcx, %rax
180008cfe:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180008d08:     	cmpq	%rbx, %rax
180008d0b:     	cmoveq	%rcx, %rax
180008d0f:     	movq	%rax, 0x83aa(%rip)      # 0x1800110c0
180008d16:     	movq	0x50(%rsp), %rbx
180008d1b:     	notq	%rax
180008d1e:     	movq	%rax, 0x83db(%rip)      # 0x180011100
180008d25:     	addq	$0x30, %rsp
180008d29:     	popq	%rbp
180008d2a:     	retq
180008d2b:     	int3
180008d2c:     	subq	$0x28, %rsp
180008d30:     	cmpl	$0x1, %edx
180008d33:     	jne	0x180008d45 <numba_list_iter_next+0x7c5>
180008d35:     	cmpq	$0x0, 0x1acb(%rip)      # 0x18000a808
180008d3d:     	jne	0x180008d45 <numba_list_iter_next+0x7c5>
180008d3f:     	callq	*0x12db(%rip)           # 0x18000a020
180008d45:     	movl	$0x1, %eax
180008d4a:     	addq	$0x28, %rsp
180008d4e:     	retq
180008d4f:     	int3
180008d50:     	leaq	0x8c59(%rip), %rcx      # 0x1800119b0
180008d57:     	jmpq	*0x12ba(%rip)           # 0x18000a018
180008d5e:     	int3
180008d5f:     	int3
180008d60:     	leaq	0x8c49(%rip), %rcx      # 0x1800119b0
180008d67:     	jmp	0x1800093f6 <numba_list_iter_next+0xe76>
180008d6c:     	leaq	0x8c4d(%rip), %rax      # 0x1800119c0
180008d73:     	retq
180008d74:     	subq	$0x28, %rsp
180008d78:     	callq	0x180007e90 <PyInit_rcaotr_ced2c43c3452451226d0f64a+0x4bc0>
180008d7d:     	orq	$0x24, (%rax)
180008d81:     	callq	0x180008d6c <numba_list_iter_next+0x7ec>
180008d86:     	orq	$0x2, (%rax)
180008d8a:     	addq	$0x28, %rsp
180008d8e:     	retq
180008d8f:     	int3
180008d90:     	subq	$0x28, %rsp
180008d94:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180008d99:     	testl	%eax, %eax
180008d9b:     	je	0x180008dbe <numba_list_iter_next+0x83e>
180008d9d:     	movq	%gs:0x30, %rax
180008da6:     	movq	0x8(%rax), %rcx
180008daa:     	jmp	0x180008db1 <numba_list_iter_next+0x831>
180008dac:     	cmpq	%rax, %rcx
180008daf:     	je	0x180008dc5 <numba_list_iter_next+0x845>
180008db1:     	xorl	%eax, %eax
180008db3:     	lock
180008db4:     	cmpxchgq	%rcx, 0x8c14(%rip)      # 0x1800119d0
180008dbc:     	jne	0x180008dac <numba_list_iter_next+0x82c>
180008dbe:     	xorb	%al, %al
180008dc0:     	addq	$0x28, %rsp
180008dc4:     	retq
180008dc5:     	movb	$0x1, %al
180008dc7:     	jmp	0x180008dc0 <numba_list_iter_next+0x840>
180008dc9:     	int3
180008dca:     	int3
180008dcb:     	int3
180008dcc:     	subq	$0x28, %rsp
180008dd0:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180008dd5:     	testl	%eax, %eax
180008dd7:     	je	0x180008de0 <numba_list_iter_next+0x860>
180008dd9:     	callq	0x180009138 <numba_list_iter_next+0xbb8>
180008dde:     	jmp	0x180008df9 <numba_list_iter_next+0x879>
180008de0:     	callq	0x1800093d4 <numba_list_iter_next+0xe54>
180008de5:     	movl	%eax, %ecx
180008de7:     	callq	0x180009414 <numba_list_iter_next+0xe94>
180008dec:     	testl	%eax, %eax
180008dee:     	je	0x180008df4 <numba_list_iter_next+0x874>
180008df0:     	xorb	%al, %al
180008df2:     	jmp	0x180008dfb <numba_list_iter_next+0x87b>
180008df4:     	callq	0x18000941a <numba_list_iter_next+0xe9a>
180008df9:     	movb	$0x1, %al
180008dfb:     	addq	$0x28, %rsp
180008dff:     	retq
180008e00:     	subq	$0x28, %rsp
180008e04:     	xorl	%ecx, %ecx
180008e06:     	callq	0x180008f38 <numba_list_iter_next+0x9b8>
180008e0b:     	testb	%al, %al
180008e0d:     	setne	%al
180008e10:     	addq	$0x28, %rsp
180008e14:     	retq
180008e15:     	int3
180008e16:     	int3
180008e17:     	int3
180008e18:     	subq	$0x28, %rsp
180008e1c:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008e21:     	testb	%al, %al
180008e23:     	jne	0x180008e29 <numba_list_iter_next+0x8a9>
180008e25:     	xorb	%al, %al
180008e27:     	jmp	0x180008e3b <numba_list_iter_next+0x8bb>
180008e29:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008e2e:     	testb	%al, %al
180008e30:     	jne	0x180008e39 <numba_list_iter_next+0x8b9>
180008e32:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008e37:     	jmp	0x180008e25 <numba_list_iter_next+0x8a5>
180008e39:     	movb	$0x1, %al
180008e3b:     	addq	$0x28, %rsp
180008e3f:     	retq
180008e40:     	subq	$0x28, %rsp
180008e44:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008e49:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008e4e:     	movb	$0x1, %al
180008e50:     	addq	$0x28, %rsp
180008e54:     	retq
180008e55:     	int3
180008e56:     	int3
180008e57:     	int3
180008e58:     	movq	%rbx, 0x8(%rsp)
180008e5d:     	movq	%rbp, 0x10(%rsp)
180008e62:     	movq	%rsi, 0x18(%rsp)
180008e67:     	pushq	%rdi
180008e68:     	subq	$0x20, %rsp
180008e6c:     	movq	%r9, %rdi
180008e6f:     	movq	%r8, %rsi
180008e72:     	movl	%edx, %ebx
180008e74:     	movq	%rcx, %rbp
180008e77:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180008e7c:     	testl	%eax, %eax
180008e7e:     	jne	0x180008e96 <numba_list_iter_next+0x916>
180008e80:     	cmpl	$0x1, %ebx
180008e83:     	jne	0x180008e96 <numba_list_iter_next+0x916>
180008e85:     	movq	%rsi, %r8
180008e88:     	xorl	%edx, %edx
180008e8a:     	movq	%rbp, %rcx
180008e8d:     	movq	%rdi, %rax
180008e90:     	callq	*0x149a(%rip)           # 0x18000a330
180008e96:     	movq	0x58(%rsp), %rdx
180008e9b:     	movl	0x50(%rsp), %ecx
180008e9f:     	movq	0x30(%rsp), %rbx
180008ea4:     	movq	0x38(%rsp), %rbp
180008ea9:     	movq	0x40(%rsp), %rsi
180008eae:     	addq	$0x20, %rsp
180008eb2:     	popq	%rdi
180008eb3:     	jmp	0x18000940e <numba_list_iter_next+0xe8e>
180008eb8:     	subq	$0x28, %rsp
180008ebc:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180008ec1:     	testl	%eax, %eax
180008ec3:     	je	0x180008ed5 <numba_list_iter_next+0x955>
180008ec5:     	leaq	0x8b14(%rip), %rcx      # 0x1800119e0
180008ecc:     	addq	$0x28, %rsp
180008ed0:     	jmp	0x180009426 <numba_list_iter_next+0xea6>
180008ed5:     	callq	0x180009438 <numba_list_iter_next+0xeb8>
180008eda:     	testl	%eax, %eax
180008edc:     	jne	0x180008ee3 <numba_list_iter_next+0x963>
180008ede:     	callq	0x18000942c <numba_list_iter_next+0xeac>
180008ee3:     	addq	$0x28, %rsp
180008ee7:     	retq
180008ee8:     	subq	$0x28, %rsp
180008eec:     	xorl	%ecx, %ecx
180008eee:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008ef3:     	addq	$0x28, %rsp
180008ef7:     	jmp	0x180009434 <numba_list_iter_next+0xeb4>
180008efc:     	subq	$0x28, %rsp
180008f00:     	testl	%ecx, %ecx
180008f02:     	jne	0x180008f0b <numba_list_iter_next+0x98b>
180008f04:     	movb	$0x1, 0x8acd(%rip)      # 0x1800119d8
180008f0b:     	callq	0x180009138 <numba_list_iter_next+0xbb8>
180008f10:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008f15:     	testb	%al, %al
180008f17:     	jne	0x180008f1d <numba_list_iter_next+0x99d>
180008f19:     	xorb	%al, %al
180008f1b:     	jmp	0x180008f31 <numba_list_iter_next+0x9b1>
180008f1d:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008f22:     	testb	%al, %al
180008f24:     	jne	0x180008f2f <numba_list_iter_next+0x9af>
180008f26:     	xorl	%ecx, %ecx
180008f28:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
180008f2d:     	jmp	0x180008f19 <numba_list_iter_next+0x999>
180008f2f:     	movb	$0x1, %al
180008f31:     	addq	$0x28, %rsp
180008f35:     	retq
180008f36:     	int3
180008f37:     	int3
180008f38:     	pushq	%rbx
180008f3a:     	subq	$0x20, %rsp
180008f3e:     	cmpb	$0x0, 0x8a94(%rip)      # 0x1800119d9
180008f45:     	movl	%ecx, %ebx
180008f47:     	jne	0x180008fb0 <numba_list_iter_next+0xa30>
180008f49:     	cmpl	$0x1, %ecx
180008f4c:     	ja	0x180008fb8 <numba_list_iter_next+0xa38>
180008f4e:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180008f53:     	testl	%eax, %eax
180008f55:     	je	0x180008f7f <numba_list_iter_next+0x9ff>
180008f57:     	testl	%ebx, %ebx
180008f59:     	jne	0x180008f7f <numba_list_iter_next+0x9ff>
180008f5b:     	leaq	0x8a7e(%rip), %rcx      # 0x1800119e0
180008f62:     	callq	0x180009420 <numba_list_iter_next+0xea0>
180008f67:     	testl	%eax, %eax
180008f69:     	jne	0x180008f7b <numba_list_iter_next+0x9fb>
180008f6b:     	leaq	0x8a86(%rip), %rcx      # 0x1800119f8
180008f72:     	callq	0x180009420 <numba_list_iter_next+0xea0>
180008f77:     	testl	%eax, %eax
180008f79:     	je	0x180008fa9 <numba_list_iter_next+0xa29>
180008f7b:     	xorb	%al, %al
180008f7d:     	jmp	0x180008fb2 <numba_list_iter_next+0xa32>
180008f7f:     	movdqa	0x1889(%rip), %xmm0     # 0x18000a810
180008f87:     	orq	$-0x1, %rax
180008f8b:     	movdqu	%xmm0, 0x8a4d(%rip)     # 0x1800119e0
180008f93:     	movq	%rax, 0x8a56(%rip)      # 0x1800119f0
180008f9a:     	movdqu	%xmm0, 0x8a56(%rip)     # 0x1800119f8
180008fa2:     	movq	%rax, 0x8a5f(%rip)      # 0x180011a08
180008fa9:     	movb	$0x1, 0x8a29(%rip)      # 0x1800119d9
180008fb0:     	movb	$0x1, %al
180008fb2:     	addq	$0x20, %rsp
180008fb6:     	popq	%rbx
180008fb7:     	retq
180008fb8:     	movl	$0x5, %ecx
180008fbd:     	callq	0x1800090b4 <numba_list_iter_next+0xb34>
180008fc2:     	int3
180008fc3:     	int3
180008fc4:     	subq	$0x18, %rsp
180008fc8:     	movq	%rcx, %r8
180008fcb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180008fd0:     	cmpw	%ax, -0x8fd7(%rip)      # 0x180000000
180008fd7:     	jne	0x180009051 <numba_list_iter_next+0xad1>
180008fd9:     	movslq	-0x8fa4(%rip), %rcx     # 0x18000003c
180008fe0:     	leaq	-0x8fe7(%rip), %rdx     # 0x180000000
180008fe7:     	addq	%rdx, %rcx
180008fea:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180008ff0:     	jne	0x180009051 <numba_list_iter_next+0xad1>
180008ff2:     	movl	$0x20b, %eax            # imm = 0x20B
180008ff7:     	cmpw	%ax, 0x18(%rcx)
180008ffb:     	jne	0x180009051 <numba_list_iter_next+0xad1>
180008ffd:     	subq	%rdx, %r8
180009000:     	movzwl	0x14(%rcx), %edx
180009004:     	addq	$0x18, %rdx
180009008:     	addq	%rcx, %rdx
18000900b:     	movzwl	0x6(%rcx), %eax
18000900f:     	leaq	(%rax,%rax,4), %rcx
180009013:     	leaq	(%rdx,%rcx,8), %r9
180009017:     	movq	%rdx, (%rsp)
18000901b:     	cmpq	%r9, %rdx
18000901e:     	je	0x180009038 <numba_list_iter_next+0xab8>
180009020:     	movl	0xc(%rdx), %ecx
180009023:     	cmpq	%rcx, %r8
180009026:     	jb	0x180009032 <numba_list_iter_next+0xab2>
180009028:     	movl	0x8(%rdx), %eax
18000902b:     	addl	%ecx, %eax
18000902d:     	cmpq	%rax, %r8
180009030:     	jb	0x18000903a <numba_list_iter_next+0xaba>
180009032:     	addq	$0x28, %rdx
180009036:     	jmp	0x180009017 <numba_list_iter_next+0xa97>
180009038:     	xorl	%edx, %edx
18000903a:     	testq	%rdx, %rdx
18000903d:     	jne	0x180009043 <numba_list_iter_next+0xac3>
18000903f:     	xorb	%al, %al
180009041:     	jmp	0x180009057 <numba_list_iter_next+0xad7>
180009043:     	cmpl	$0x0, 0x24(%rdx)
180009047:     	jge	0x18000904d <numba_list_iter_next+0xacd>
180009049:     	xorb	%al, %al
18000904b:     	jmp	0x180009057 <numba_list_iter_next+0xad7>
18000904d:     	movb	$0x1, %al
18000904f:     	jmp	0x180009057 <numba_list_iter_next+0xad7>
180009051:     	xorb	%al, %al
180009053:     	jmp	0x180009057 <numba_list_iter_next+0xad7>
180009055:     	xorb	%al, %al
180009057:     	addq	$0x18, %rsp
18000905b:     	retq
18000905c:     	pushq	%rbx
18000905e:     	subq	$0x20, %rsp
180009062:     	movb	%cl, %bl
180009064:     	callq	0x1800093dc <numba_list_iter_next+0xe5c>
180009069:     	xorl	%edx, %edx
18000906b:     	testl	%eax, %eax
18000906d:     	je	0x18000907a <numba_list_iter_next+0xafa>
18000906f:     	testb	%bl, %bl
180009071:     	jne	0x18000907a <numba_list_iter_next+0xafa>
180009073:     	xchgq	%rdx, 0x8956(%rip)      # 0x1800119d0
18000907a:     	addq	$0x20, %rsp
18000907e:     	popq	%rbx
18000907f:     	retq
180009080:     	pushq	%rbx
180009082:     	subq	$0x20, %rsp
180009086:     	cmpb	$0x0, 0x894b(%rip)      # 0x1800119d8
18000908d:     	movb	%cl, %bl
18000908f:     	je	0x180009095 <numba_list_iter_next+0xb15>
180009091:     	testb	%dl, %dl
180009093:     	jne	0x1800090a1 <numba_list_iter_next+0xb21>
180009095:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
18000909a:     	movb	%bl, %cl
18000909c:     	callq	0x180009434 <numba_list_iter_next+0xeb4>
1800090a1:     	movb	$0x1, %al
1800090a3:     	addq	$0x20, %rsp
1800090a7:     	popq	%rbx
1800090a8:     	retq
1800090a9:     	int3
1800090aa:     	int3
1800090ab:     	int3
1800090ac:     	leaq	0x8bc5(%rip), %rax      # 0x180011c78
1800090b3:     	retq
1800090b4:     	movl	%ecx, %ecx
1800090b6:     	int	$0x29
1800090b8:     	retq
1800090b9:     	int3
1800090ba:     	int3
1800090bb:     	int3
1800090bc:     	movq	%rbx, 0x8(%rsp)
1800090c1:     	pushq	%rdi
1800090c2:     	subq	$0x20, %rsp
1800090c6:     	leaq	0x417b(%rip), %rbx      # 0x18000d248
1800090cd:     	leaq	0x4174(%rip), %rdi      # 0x18000d248
1800090d4:     	jmp	0x1800090e8 <numba_list_iter_next+0xb68>
1800090d6:     	movq	(%rbx), %rax
1800090d9:     	testq	%rax, %rax
1800090dc:     	je	0x1800090e4 <numba_list_iter_next+0xb64>
1800090de:     	callq	*0x124c(%rip)           # 0x18000a330
1800090e4:     	addq	$0x8, %rbx
1800090e8:     	cmpq	%rdi, %rbx
1800090eb:     	jb	0x1800090d6 <numba_list_iter_next+0xb56>
1800090ed:     	movq	0x30(%rsp), %rbx
1800090f2:     	addq	$0x20, %rsp
1800090f6:     	popq	%rdi
1800090f7:     	retq
1800090f8:     	movq	%rbx, 0x8(%rsp)
1800090fd:     	pushq	%rdi
1800090fe:     	subq	$0x20, %rsp
180009102:     	leaq	0x414f(%rip), %rbx      # 0x18000d258
180009109:     	leaq	0x4148(%rip), %rdi      # 0x18000d258
180009110:     	jmp	0x180009124 <numba_list_iter_next+0xba4>
180009112:     	movq	(%rbx), %rax
180009115:     	testq	%rax, %rax
180009118:     	je	0x180009120 <numba_list_iter_next+0xba0>
18000911a:     	callq	*0x1210(%rip)           # 0x18000a330
180009120:     	addq	$0x8, %rbx
180009124:     	cmpq	%rdi, %rbx
180009127:     	jb	0x180009112 <numba_list_iter_next+0xb92>
180009129:     	movq	0x30(%rsp), %rbx
18000912e:     	addq	$0x20, %rsp
180009132:     	popq	%rdi
180009133:     	retq
180009134:     	retq	$0x0
180009137:     	int3
180009138:     	movq	%rbx, 0x10(%rsp)
18000913d:     	movq	%rbp, 0x18(%rsp)
180009142:     	movq	%rsi, 0x20(%rsp)
180009147:     	pushq	%rdi
180009148:     	subq	$0x10, %rsp
18000914c:     	xorl	%eax, %eax
18000914e:     	xorl	%ecx, %ecx
180009150:     	cpuid
180009152:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180009158:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000915e:     	orl	%ecx, %edx
180009160:     	movl	%eax, %ebp
180009162:     	movl	$0x1, %eax
180009167:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000916d:     	orl	%ebx, %edx
18000916f:     	leal	-0x1(%rax), %ecx
180009172:     	cpuid
180009174:     	movl	%ecx, %edi
180009176:     	jne	0x1800091d6 <numba_list_iter_next+0xc56>
180009178:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000917d:     	movq	$0x8000, 0x7f90(%rip)   # imm = 0x8000
                                                # 0x180011118
180009188:     	movq	$-0x1, 0x7f8d(%rip)     # 0x180011120
180009193:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180009198:     	je	0x1800091c2 <numba_list_iter_next+0xc42>
18000919a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000919f:     	je	0x1800091c2 <numba_list_iter_next+0xc42>
1800091a1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800091a6:     	je	0x1800091c2 <numba_list_iter_next+0xc42>
1800091a8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800091ad:     	cmpl	$0x20, %eax
1800091b0:     	ja	0x1800091d6 <numba_list_iter_next+0xc56>
1800091b2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1800091bc:     	btq	%rax, %rcx
1800091c0:     	jae	0x1800091d6 <numba_list_iter_next+0xc56>
1800091c2:     	movl	0x884b(%rip), %r8d      # 0x180011a14
1800091c9:     	orl	$0x1, %r8d
1800091cd:     	movl	%r8d, 0x8840(%rip)      # 0x180011a14
1800091d4:     	jmp	0x1800091dd <numba_list_iter_next+0xc5d>
1800091d6:     	movl	0x8837(%rip), %r8d      # 0x180011a14
1800091dd:     	xorl	%r9d, %r9d
1800091e0:     	movl	%r9d, %r11d
1800091e3:     	cmpl	$0x7, %ebp
1800091e6:     	jl	0x18000922a <numba_list_iter_next+0xcaa>
1800091e8:     	xorl	%ecx, %ecx
1800091ea:     	leal	0x7(%r9), %eax
1800091ee:     	cpuid
1800091f0:     	movl	%edx, %esi
1800091f2:     	movl	%ebx, %r10d
1800091f5:     	btl	$0x9, %ebx
1800091f9:     	jae	0x180009206 <numba_list_iter_next+0xc86>
1800091fb:     	orl	$0x2, %r8d
1800091ff:     	movl	%r8d, 0x880e(%rip)      # 0x180011a14
180009206:     	cmpl	$0x1, %eax
180009209:     	jl	0x180009218 <numba_list_iter_next+0xc98>
18000920b:     	movl	$0x7, %eax
180009210:     	leal	-0x6(%rax), %ecx
180009213:     	cpuid
180009215:     	movl	%edx, %r9d
180009218:     	movl	$0x24, %eax
18000921d:     	cmpl	%eax, %ebp
18000921f:     	jl	0x180009230 <numba_list_iter_next+0xcb0>
180009221:     	xorl	%ecx, %ecx
180009223:     	cpuid
180009225:     	movl	%ebx, %r11d
180009228:     	jmp	0x180009230 <numba_list_iter_next+0xcb0>
18000922a:     	movl	%r9d, %r10d
18000922d:     	movl	%r9d, %esi
180009230:     	movq	0x7ef1(%rip), %rax      # 0x180011128
180009237:     	andq	$-0x2, %rax
18000923b:     	movl	$0x1, 0x7ecb(%rip)      # 0x180011110
180009245:     	movl	$0x2, 0x7ec5(%rip)      # 0x180011114
18000924f:     	movq	%rax, 0x7ed2(%rip)      # 0x180011128
180009256:     	btl	$0x14, %edi
18000925a:     	jae	0x18000927b <numba_list_iter_next+0xcfb>
18000925c:     	andq	$-0x11, %rax
180009260:     	movl	$0x2, 0x7ea6(%rip)      # 0x180011110
18000926a:     	movq	%rax, 0x7eb7(%rip)      # 0x180011128
180009271:     	movl	$0x6, 0x7e99(%rip)      # 0x180011114
18000927b:     	btl	$0x1b, %edi
18000927f:     	jae	0x1800093bc <numba_list_iter_next+0xe3c>
180009285:     	xorl	%ecx, %ecx
180009287:     	xgetbv
18000928a:     	shlq	$0x20, %rdx
18000928e:     	orq	%rax, %rdx
180009291:     	movq	%rdx, 0x20(%rsp)
180009296:     	btl	$0x1c, %edi
18000929a:     	jae	0x1800093a0 <numba_list_iter_next+0xe20>
1800092a0:     	movq	0x20(%rsp), %rax
1800092a5:     	andb	$0x6, %al
1800092a7:     	cmpb	$0x6, %al
1800092a9:     	jne	0x1800093a0 <numba_list_iter_next+0xe20>
1800092af:     	movl	0x7e5f(%rip), %eax      # 0x180011114
1800092b5:     	movb	$-0x20, %dl
1800092b7:     	orl	$0x8, %eax
1800092ba:     	movl	$0x3, 0x7e4c(%rip)      # 0x180011110
1800092c4:     	movl	%eax, 0x7e4a(%rip)      # 0x180011114
1800092ca:     	testb	$0x20, %r10b
1800092ce:     	je	0x180009332 <numba_list_iter_next+0xdb2>
1800092d0:     	orl	$0x20, %eax
1800092d3:     	movl	$0x5, 0x7e33(%rip)      # 0x180011110
1800092dd:     	movl	%eax, 0x7e31(%rip)      # 0x180011114
1800092e3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1800092e8:     	movq	0x7e39(%rip), %rax      # 0x180011128
1800092ef:     	andl	%ecx, %r10d
1800092f2:     	andq	$-0x3, %rax
1800092f6:     	movq	%rax, 0x7e2b(%rip)      # 0x180011128
1800092fd:     	cmpl	%ecx, %r10d
180009300:     	jne	0x180009339 <numba_list_iter_next+0xdb9>
180009302:     	movq	0x20(%rsp), %rax
180009307:     	andb	%dl, %al
180009309:     	cmpb	%dl, %al
18000930b:     	jne	0x180009332 <numba_list_iter_next+0xdb2>
18000930d:     	movq	0x7e14(%rip), %rax      # 0x180011128
180009314:     	orl	$0x40, 0x7df9(%rip)     # 0x180011114
18000931b:     	andq	$-0x25, %rax
18000931f:     	movl	$0x6, 0x7de7(%rip)      # 0x180011110
180009329:     	movq	%rax, 0x7df8(%rip)      # 0x180011128
180009330:     	jmp	0x180009339 <numba_list_iter_next+0xdb9>
180009332:     	movq	0x7def(%rip), %rax      # 0x180011128
180009339:     	btl	$0x17, %esi
18000933d:     	jae	0x18000934b <numba_list_iter_next+0xdcb>
18000933f:     	btrq	$0x18, %rax
180009344:     	movq	%rax, 0x7ddd(%rip)      # 0x180011128
18000934b:     	btl	$0x13, %r9d
180009350:     	jae	0x1800093a0 <numba_list_iter_next+0xe20>
180009352:     	movq	0x20(%rsp), %rax
180009357:     	andb	%dl, %al
180009359:     	cmpb	%dl, %al
18000935b:     	jne	0x1800093a0 <numba_list_iter_next+0xe20>
18000935d:     	movq	0x7dc4(%rip), %rdx      # 0x180011128
180009364:     	movl	%r11d, %eax
180009367:     	shrq	$0x10, %rax
18000936b:     	movl	%r11d, %ecx
18000936e:     	andl	$0x6, %eax
180009371:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180009377:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000937d:     	movl	%ecx, 0x8695(%rip)      # 0x180011a18
180009383:     	notq	%rax
180009386:     	andq	%rax, %rdx
180009389:     	movq	%rdx, 0x7d98(%rip)      # 0x180011128
180009390:     	cmpb	$0x1, %cl
180009393:     	jbe	0x1800093a0 <numba_list_iter_next+0xe20>
180009395:     	andq	$-0x41, %rdx
180009399:     	movq	%rdx, 0x7d88(%rip)      # 0x180011128
1800093a0:     	btl	$0x15, %r9d
1800093a5:     	jae	0x1800093bc <numba_list_iter_next+0xe3c>
1800093a7:     	movq	0x20(%rsp), %rax
1800093ac:     	btq	$0x13, %rax
1800093b1:     	jae	0x1800093bc <numba_list_iter_next+0xe3c>
1800093b3:     	btrq	$0x7, 0x7d6c(%rip)      # 0x180011128
1800093bc:     	movq	0x28(%rsp), %rbx
1800093c1:     	xorl	%eax, %eax
1800093c3:     	movq	0x30(%rsp), %rbp
1800093c8:     	movq	0x38(%rsp), %rsi
1800093cd:     	addq	$0x10, %rsp
1800093d1:     	popq	%rdi
1800093d2:     	retq
1800093d3:     	int3
1800093d4:     	movl	$0x1, %eax
1800093d9:     	retq
1800093da:     	int3
1800093db:     	int3
1800093dc:     	xorl	%eax, %eax
1800093de:     	cmpl	%eax, 0x7d4c(%rip)      # 0x180011130
1800093e4:     	setne	%al
1800093e7:     	retq
1800093e8:     	int3
1800093e9:     	int3
1800093ea:     	int3
1800093eb:     	int3
1800093ec:     	int3
1800093ed:     	int3
1800093ee:     	int3
1800093ef:     	int3
1800093f0:     	jmpq	*0xc52(%rip)            # 0x18000a048
1800093f6:     	jmpq	*0xc54(%rip)            # 0x18000a050
1800093fc:     	jmpq	*0xc7e(%rip)            # 0x18000a080
180009402:     	jmpq	*0xc90(%rip)            # 0x18000a098
180009408:     	jmpq	*0xc92(%rip)            # 0x18000a0a0
18000940e:     	jmpq	*0xc94(%rip)            # 0x18000a0a8
180009414:     	jmpq	*0xc96(%rip)            # 0x18000a0b0
18000941a:     	jmpq	*0xc98(%rip)            # 0x18000a0b8
180009420:     	jmpq	*0xc9a(%rip)            # 0x18000a0c0
180009426:     	jmpq	*0xc9c(%rip)            # 0x18000a0c8
18000942c:     	jmpq	*0xc5e(%rip)            # 0x18000a090
180009432:     	int3
180009433:     	int3
180009434:     	movb	$0x1, %al
180009436:     	retq
180009437:     	int3
180009438:     	xorl	%eax, %eax
18000943a:     	retq
18000943b:     	jmpq	*0xbff(%rip)            # 0x18000a040
180009441:     	jmpq	*0xbf1(%rip)            # 0x18000a038
180009447:     	jmpq	*0xc8b(%rip)            # 0x18000a0d8
18000944d:     	jmpq	*0xc8d(%rip)            # 0x18000a0e0
180009453:     	int3
180009454:     	int3
180009455:     	int3
180009456:     	int3
180009457:     	int3
180009458:     	int3
180009459:     	int3
18000945a:     	int3
18000945b:     	int3
18000945c:     	int3
18000945d:     	int3
18000945e:     	int3
18000945f:     	int3
180009460:     	int3
180009461:     	int3
180009462:     	int3
180009463:     	int3
180009464:     	int3
180009465:     	int3
180009466:     	nopw	(%rax,%rax)
180009470:     	jmpq	*%rax
180009472:     	int3
180009473:     	int3
180009474:     	int3
180009475:     	int3
180009476:     	int3
180009477:     	int3
180009478:     	int3
180009479:     	int3
18000947a:     	int3
18000947b:     	int3
18000947c:     	int3
18000947d:     	int3
18000947e:     	int3
18000947f:     	int3
180009480:     	int3
180009481:     	int3
180009482:     	int3
180009483:     	int3
180009484:     	int3
180009485:     	int3
180009486:     	nopw	(%rax,%rax)
180009490:     	jmpq	*0xe9a(%rip)            # 0x18000a330
180009496:     	pushq	%rbp
180009498:     	subq	$0x20, %rsp
18000949c:     	movq	%rdx, %rbp
18000949f:     	movb	0x40(%rbp), %cl
1800094a2:     	addq	$0x20, %rsp
1800094a6:     	popq	%rbp
1800094a7:     	jmp	0x18000905c <numba_list_iter_next+0xadc>
1800094ac:     	int3
1800094ad:     	pushq	%rbp
1800094af:     	subq	$0x20, %rsp
1800094b3:     	movq	%rdx, %rbp
1800094b6:     	movb	0x20(%rbp), %cl
1800094b9:     	callq	0x18000905c <numba_list_iter_next+0xadc>
1800094be:     	nop
1800094bf:     	addq	$0x20, %rsp
1800094c3:     	popq	%rbp
1800094c4:     	retq
1800094c5:     	int3
1800094c6:     	pushq	%rbp
1800094c8:     	subq	$0x20, %rsp
1800094cc:     	movq	%rdx, %rbp
1800094cf:     	addq	$0x20, %rsp
1800094d3:     	popq	%rbp
1800094d4:     	jmp	0x180008ee8 <numba_list_iter_next+0x968>
1800094d9:     	int3
1800094da:     	pushq	%rbp
1800094dc:     	subq	$0x30, %rsp
1800094e0:     	movq	%rdx, %rbp
1800094e3:     	movq	(%rcx), %rax
1800094e6:     	movl	(%rax), %edx
1800094e8:     	movq	%rcx, 0x28(%rsp)
1800094ed:     	movl	%edx, 0x20(%rsp)
1800094f1:     	leaq	-0xbd8(%rip), %r9       # 0x180008920 <numba_list_iter_next+0x3a0>
1800094f8:     	movq	0x70(%rbp), %r8
1800094fc:     	movl	0x68(%rbp), %edx
1800094ff:     	movq	0x60(%rbp), %rcx
180009503:     	callq	0x180008e58 <numba_list_iter_next+0x8d8>
180009508:     	nop
180009509:     	addq	$0x30, %rsp
18000950d:     	popq	%rbp
18000950e:     	retq
18000950f:     	int3
180009510:     	pushq	%rbp
180009512:     	movq	%rdx, %rbp
180009515:     	movq	(%rcx), %rax
180009518:     	xorl	%ecx, %ecx
18000951a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180009520:     	sete	%cl
180009523:     	movl	%ecx, %eax
180009525:     	popq	%rbp
180009526:     	retq
180009527:     	int3
