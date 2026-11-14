
D:\Code\Datathon\recompyler-codex-20261111\wave6-study\results-v2\cache\forceonly-direct\recompyler\rcaotr_b8ad585ae5ddf1131de85239.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x18000b3c0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0xc3f9(%rip), %rax      # 0x18000d480
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
18000109c:     	subq	$0x1a8, %rsp            # imm = 0x1A8
1800010a3:     	movapd	%xmm8, 0x190(%rsp)
1800010ad:     	movaps	%xmm7, 0x180(%rsp)
1800010b5:     	movapd	%xmm6, 0x170(%rsp)
1800010be:     	movq	0x2f8(%rsp), %r11
1800010c6:     	movq	0x2c8(%rsp), %r15
1800010ce:     	movq	0x290(%rsp), %rbx
1800010d6:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
1800010e0:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
1800010ea:     	xorpd	%xmm0, %xmm0
1800010ee:     	movapd	%xmm0, 0x150(%rsp)
1800010f7:     	leaq	(%r11,%rax), %rsi
1800010fb:     	cmpq	%r10, %rsi
1800010fe:     	jb	0x180001110 <.text+0x110>
180001100:     	movq	0x300(%rsp), %rsi
180001108:     	addq	%rsi, %rax
18000110b:     	cmpq	%r10, %rax
18000110e:     	jae	0x180001152 <.text+0x152>
180001110:     	movb	$0x1, (%r15)
180001114:     	movq	$0x4, 0x18(%rbx)
18000111c:     	xorl	%eax, %eax
18000111e:     	movq	$0x0, (%rcx)
180001125:     	movaps	0x170(%rsp), %xmm6
18000112d:     	movaps	0x180(%rsp), %xmm7
180001135:     	movaps	0x190(%rsp), %xmm8
18000113e:     	addq	$0x1a8, %rsp            # imm = 0x1A8
180001145:     	popq	%rbx
180001146:     	popq	%rbp
180001147:     	popq	%rdi
180001148:     	popq	%rsi
180001149:     	popq	%r12
18000114b:     	popq	%r13
18000114d:     	popq	%r14
18000114f:     	popq	%r15
180001151:     	retq
180001152:     	movq	0x260(%rsp), %r12
18000115a:     	movq	(%rbx), %r10
18000115d:     	leaq	0x4(%r10), %rax
180001161:     	cmpq	%r12, %rax
180001164:     	jle	0x18000116c <.text+0x16c>
180001166:     	movb	$0x2, (%r15)
18000116a:     	jmp	0x18000111c <.text+0x11c>
18000116c:     	movq	%rax, (%rbx)
18000116f:     	xorl	%eax, %eax
180001171:     	cmpb	$0x0, (%r15)
180001175:     	jne	0x18000111e <.text+0x11e>
180001177:     	movq	0x220(%rsp), %r13
18000117f:     	xorps	%xmm0, %xmm0
180001182:     	cvtsi2sd	%r11, %xmm0
180001187:     	movsd	0xc221(%rip), %xmm1     # 0x18000d3b0
18000118f:     	mulsd	%xmm1, %xmm0
180001193:     	cvtsi2sd	%rsi, %xmm2
180001198:     	mulsd	%xmm1, %xmm2
18000119c:     	movsd	%xmm0, 0x10(%r13,%r10,8)
1800011a3:     	movsd	%xmm2, 0x18(%r13,%r10,8)
1800011aa:     	movsd	%xmm0, 0x8(%r13,%r10,8)
1800011b1:     	movsd	%xmm2, (%r13,%r10,8)
1800011b8:     	cmpb	$0x0, (%r15)
1800011bc:     	jne	0x18000111e <.text+0x11e>
1800011c2:     	movq	(%rbx), %r14
1800011c5:     	leaq	0xb(%r14), %r11
1800011c9:     	cmpq	%r12, %r11
1800011cc:     	jle	0x1800011d7 <.text+0x1d7>
1800011ce:     	movb	$0x2, (%r15)
1800011d2:     	jmp	0x18000111e <.text+0x11e>
1800011d7:     	movq	%r11, (%rbx)
1800011da:     	cmpb	$0x0, (%r15)
1800011de:     	jne	0x18000111e <.text+0x11e>
1800011e4:     	movq	0x258(%rsp), %rdi
1800011ec:     	movq	%r10, (%rdi,%r14,8)
1800011f0:     	movq	$0x4, 0x8(%rdi,%r14,8)
1800011f9:     	movq	(%rbx), %r10
1800011fc:     	cmpq	%r12, %r10
1800011ff:     	movq	%r10, %r11
180001202:     	jle	0x18000120e <.text+0x20e>
180001204:     	movb	$0x2, (%r15)
180001208:     	movq	(%rbx), %r10
18000120b:     	xorl	%r11d, %r11d
18000120e:     	leaq	0x3(%r10), %rsi
180001212:     	cmpq	%r12, %rsi
180001215:     	jg	0x1800011ce <.text+0x1ce>
180001217:     	movq	%rsi, (%rbx)
18000121a:     	cmpb	$0x0, (%r15)
18000121e:     	jne	0x18000111e <.text+0x11e>
180001224:     	movq	%r10, %rsi
180001227:     	sarq	$0x3f, %rsi
18000122b:     	andq	%r12, %rsi
18000122e:     	leaq	(%rdi,%r10,8), %rdi
180001232:     	movq	$0x0, (%rdi,%rsi,8)
18000123a:     	xorl	%esi, %esi
18000123c:     	cmpq	$-0x1, %r10
180001240:     	movl	$0x0, %ebp
180001245:     	cmovlq	%r12, %rbp
180001249:     	movq	$0x0, 0x8(%rdi,%rbp,8)
180001252:     	cmpq	$-0x2, %r10
180001256:     	cmovlq	%r12, %rsi
18000125a:     	movq	%r11, 0x10(%rdi,%rsi,8)
18000125f:     	cmpb	$0x0, (%r15)
180001263:     	jne	0x18000111c <.text+0x11c>
180001269:     	movq	0x258(%rsp), %rdi
180001271:     	leaq	(%rdi,%r14,8), %r11
180001275:     	movq	%r10, 0x30(%r11)
180001279:     	movq	$0x0, 0x18(%r11)
180001281:     	movq	(%rbx), %r10
180001284:     	leaq	0x4(%r10), %rsi
180001288:     	cmpq	%r12, %rsi
18000128b:     	jg	0x1800011ce <.text+0x1ce>
180001291:     	movq	%r8, 0x140(%rsp)
180001299:     	movq	%r9, 0x148(%rsp)
1800012a1:     	movq	%rdx, 0x138(%rsp)
1800012a9:     	movq	%rsi, (%rbx)
1800012ac:     	cmpb	$0x0, (%r15)
1800012b0:     	jne	0x18000111c <.text+0x11c>
1800012b6:     	movq	%rcx, 0x118(%rsp)
1800012be:     	movq	$0x0, (%r13,%r10,8)
1800012c7:     	movq	$0x1, 0x8(%rdi,%r10,8)
1800012d0:     	movq	$0x0, 0x10(%r13,%r10,8)
1800012d9:     	movq	$0x1, 0x18(%rdi,%r10,8)
1800012e2:     	cmpb	$0x0, (%r15)
1800012e6:     	jne	0x180001323 <.text+0x323>
1800012e8:     	movq	%r10, 0x10(%r11)
1800012ec:     	movq	$0x0, 0x48(%r13,%r14,8)
1800012f5:     	movq	$0x1, 0x50(%r11)
1800012fd:     	movq	$-0x1, 0x20(%r11)
180001305:     	movq	$-0x1, 0x28(%r11)
18000130d:     	movq	$-0x1, 0x38(%r11)
180001315:     	movq	$-0x1, 0x40(%r11)
18000131d:     	cmpb	$0x0, (%r15)
180001321:     	je	0x180001332 <.text+0x332>
180001323:     	xorl	%eax, %eax
180001325:     	movq	0x118(%rsp), %rcx
18000132d:     	jmp	0x18000111e <.text+0x11e>
180001332:     	movq	0x2e0(%rsp), %rdx
18000133a:     	movq	%rdx, %rax
18000133d:     	sarq	$0x3f, %rax
180001341:     	andq	%r12, %rax
180001344:     	movq	0x258(%rsp), %rcx
18000134c:     	leaq	(%rcx,%rdx,8), %rcx
180001350:     	movq	%rax, 0x128(%rsp)
180001358:     	movq	%rcx, %rbp
18000135b:     	cmpq	$0x0, (%rcx,%rax,8)
180001360:     	jle	0x18000158b <.text+0x58b>
180001366:     	xorl	%esi, %esi
180001368:     	cmpq	$-0x2, 0x2e0(%rsp)
180001371:     	movl	$0x0, %edi
180001376:     	cmovlq	%r12, %rdi
18000137a:     	movq	0x8(%rbx), %rax
18000137e:     	movq	0x10(%rbp,%rdi,8), %rcx
180001383:     	addq	%rsi, %rcx
180001386:     	movq	0x258(%rsp), %rdx
18000138e:     	leaq	(%rdx,%rcx,8), %rdx
180001392:     	sarq	$0x3f, %rcx
180001396:     	andq	%r12, %rcx
180001399:     	movq	(%rdx,%rcx,8), %rcx
18000139d:     	leaq	0x1(%rax), %rdx
1800013a1:     	movq	%rdx, 0x8(%rbx)
1800013a5:     	cmpq	0x10(%rbx), %rax
1800013a9:     	jge	0x18000187a <.text+0x87a>
1800013af:     	movq	%rcx, 0x100(%rsp)
1800013b7:     	movq	%r14, 0xf8(%rsp)
1800013bf:     	movq	0x2d8(%rsp), %rax
1800013c7:     	movq	%rax, 0xe8(%rsp)
1800013cf:     	movq	0x2d0(%rsp), %rax
1800013d7:     	movq	%rax, 0xe0(%rsp)
1800013df:     	movq	%r15, 0xd8(%rsp)
1800013e7:     	movq	0x2c0(%rsp), %rax
1800013ef:     	movq	%rax, 0xd0(%rsp)
1800013f7:     	movq	0x2b8(%rsp), %rax
1800013ff:     	movq	%rax, 0xc8(%rsp)
180001407:     	movq	0x2b0(%rsp), %rax
18000140f:     	movq	%rax, 0xc0(%rsp)
180001417:     	movq	0x2a8(%rsp), %rax
18000141f:     	movq	%rax, 0xb8(%rsp)
180001427:     	movq	0x2a0(%rsp), %rax
18000142f:     	movq	%rax, 0xb0(%rsp)
180001437:     	movq	0x298(%rsp), %rax
18000143f:     	movq	%rax, 0xa8(%rsp)
180001447:     	movq	%rbx, 0xa0(%rsp)
18000144f:     	movq	0x288(%rsp), %rax
180001457:     	movq	%rax, 0x98(%rsp)
18000145f:     	movq	0x280(%rsp), %rax
180001467:     	movq	%rax, 0x90(%rsp)
18000146f:     	movq	0x278(%rsp), %rax
180001477:     	movq	%rax, 0x88(%rsp)
18000147f:     	movq	0x270(%rsp), %rax
180001487:     	movq	%rax, 0x80(%rsp)
18000148f:     	movq	0x268(%rsp), %rax
180001497:     	movq	%rax, 0x78(%rsp)
18000149c:     	movq	%r12, 0x70(%rsp)
1800014a1:     	movq	0x258(%rsp), %rax
1800014a9:     	movq	%rax, 0x68(%rsp)
1800014ae:     	movq	0x250(%rsp), %rax
1800014b6:     	movq	%rax, 0x60(%rsp)
1800014bb:     	movq	0x248(%rsp), %rax
1800014c3:     	movq	%rax, 0x58(%rsp)
1800014c8:     	movq	0x240(%rsp), %rax
1800014d0:     	movq	%rax, 0x50(%rsp)
1800014d5:     	movq	0x238(%rsp), %rax
1800014dd:     	movq	%rax, 0x48(%rsp)
1800014e2:     	movq	0x230(%rsp), %rax
1800014ea:     	movq	%rax, 0x40(%rsp)
1800014ef:     	movq	0x228(%rsp), %rax
1800014f7:     	movq	%rax, 0x38(%rsp)
1800014fc:     	movq	%r13, 0x30(%rsp)
180001501:     	movq	0x218(%rsp), %rax
180001509:     	movq	%rax, 0x28(%rsp)
18000150e:     	movq	0x210(%rsp), %rax
180001516:     	movq	%rax, 0x20(%rsp)
18000151b:     	movq	$-0x1, 0x108(%rsp)
180001527:     	movq	$0x0, 0xf0(%rsp)
180001533:     	leaq	0x127(%rsp), %rcx
18000153b:     	leaq	0x160(%rsp), %rdx
180001543:     	movq	0x140(%rsp), %r8
18000154b:     	movq	0x148(%rsp), %r9
180001553:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180001558:     	testl	%eax, %eax
18000155a:     	jne	0x18000186d <.text+0x86d>
180001560:     	cmpb	$0x0, (%r15)
180001564:     	jne	0x180001323 <.text+0x323>
18000156a:     	incq	%rsi
18000156d:     	movq	0x8(%rbx), %rax
180001571:     	decq	%rax
180001574:     	movq	%rax, 0x8(%rbx)
180001578:     	movq	0x128(%rsp), %rcx
180001580:     	cmpq	(%rbp,%rcx,8), %rsi
180001585:     	jl	0x18000137e <.text+0x37e>
18000158b:     	movsd	0x2f0(%rsp), %xmm6
180001594:     	movsd	0x2e8(%rsp), %xmm7
18000159d:     	xorl	%esi, %esi
18000159f:     	cmpq	$-0x2, 0x2e0(%rsp)
1800015a8:     	movl	$0x0, %eax
1800015ad:     	cmovlq	%r12, %rax
1800015b1:     	movq	%rax, 0x130(%rsp)
1800015b9:     	xorpd	%xmm8, %xmm8
1800015be:     	jmp	0x1800015d9 <.text+0x5d9>
1800015c0:     	movb	$0x1, (%r15)
1800015c4:     	movq	$0x4c4b43, 0x18(%rbx)   # imm = 0x4C4B43
1800015cc:     	incq	%rsi
1800015cf:     	cmpb	$0x0, (%r15)
1800015d3:     	jne	0x1800019b0 <.text+0x9b0>
1800015d9:     	movq	0x128(%rsp), %rax
1800015e1:     	cmpq	(%rbp,%rax,8), %rsi
1800015e6:     	jge	0x18000188b <.text+0x88b>
1800015ec:     	movq	0x130(%rsp), %rax
1800015f4:     	movq	0x10(%rbp,%rax,8), %rax
1800015f9:     	addq	%rsi, %rax
1800015fc:     	movq	0x258(%rsp), %rcx
180001604:     	leaq	(%rcx,%rax,8), %rcx
180001608:     	sarq	$0x3f, %rax
18000160c:     	andq	%r12, %rax
18000160f:     	movq	(%rcx,%rax,8), %rdi
180001613:     	movq	0x8(%rbx), %rax
180001617:     	leaq	0x1(%rax), %rcx
18000161b:     	movq	%rcx, 0x8(%rbx)
18000161f:     	cmpq	0x10(%rbx), %rax
180001623:     	jge	0x1800019bd <.text+0x9bd>
180001629:     	movsd	%xmm7, 0x100(%rsp)
180001632:     	movq	%rdi, 0xf8(%rsp)
18000163a:     	movq	%r14, 0xf0(%rsp)
180001642:     	movq	0x2d8(%rsp), %rax
18000164a:     	movq	%rax, 0xe8(%rsp)
180001652:     	movq	0x2d0(%rsp), %rax
18000165a:     	movq	%rax, 0xe0(%rsp)
180001662:     	movq	%r15, 0xd8(%rsp)
18000166a:     	movq	0x2c0(%rsp), %rax
180001672:     	movq	%rax, 0xd0(%rsp)
18000167a:     	movq	0x2b8(%rsp), %rax
180001682:     	movq	%rax, 0xc8(%rsp)
18000168a:     	movq	0x2b0(%rsp), %rax
180001692:     	movq	%rax, 0xc0(%rsp)
18000169a:     	movq	0x2a8(%rsp), %rax
1800016a2:     	movq	%rax, 0xb8(%rsp)
1800016aa:     	movq	0x2a0(%rsp), %rax
1800016b2:     	movq	%rax, 0xb0(%rsp)
1800016ba:     	movq	0x298(%rsp), %rax
1800016c2:     	movq	%rax, 0xa8(%rsp)
1800016ca:     	movq	%rbx, 0xa0(%rsp)
1800016d2:     	movq	0x288(%rsp), %rax
1800016da:     	movq	%rax, 0x98(%rsp)
1800016e2:     	movq	0x280(%rsp), %rax
1800016ea:     	movq	%rax, 0x90(%rsp)
1800016f2:     	movq	0x278(%rsp), %rax
1800016fa:     	movq	%rax, 0x88(%rsp)
180001702:     	movq	0x270(%rsp), %rax
18000170a:     	movq	%rax, 0x80(%rsp)
180001712:     	movq	0x268(%rsp), %rax
18000171a:     	movq	%rax, 0x78(%rsp)
18000171f:     	movq	%r12, 0x70(%rsp)
180001724:     	movq	0x258(%rsp), %rax
18000172c:     	movq	%rax, 0x68(%rsp)
180001731:     	movq	0x250(%rsp), %rax
180001739:     	movq	%rax, 0x60(%rsp)
18000173e:     	movq	0x248(%rsp), %rax
180001746:     	movq	%rax, 0x58(%rsp)
18000174b:     	movq	0x240(%rsp), %rax
180001753:     	movq	%rax, 0x50(%rsp)
180001758:     	movq	0x238(%rsp), %rax
180001760:     	movq	%rax, 0x48(%rsp)
180001765:     	movq	0x230(%rsp), %rax
18000176d:     	movq	%rax, 0x40(%rsp)
180001772:     	movq	0x228(%rsp), %rax
18000177a:     	movq	%rax, 0x38(%rsp)
18000177f:     	movq	%r13, 0x30(%rsp)
180001784:     	movq	0x218(%rsp), %rax
18000178c:     	movq	%rax, 0x28(%rsp)
180001791:     	movq	0x210(%rsp), %rax
180001799:     	movq	%rax, 0x20(%rsp)
18000179e:     	leaq	0x150(%rsp), %rcx
1800017a6:     	leaq	0x168(%rsp), %rdx
1800017ae:     	movq	0x140(%rsp), %r8
1800017b6:     	movq	0x148(%rsp), %r9
1800017be:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
1800017c3:     	testl	%eax, %eax
1800017c5:     	jne	0x18000186d <.text+0x86d>
1800017cb:     	xorl	%eax, %eax
1800017cd:     	cmpb	$0x0, (%r15)
1800017d1:     	jne	0x1800019b0 <.text+0x9b0>
1800017d7:     	movsd	0x150(%rsp), %xmm1
1800017e0:     	movsd	0x158(%rsp), %xmm0
1800017e9:     	decq	0x8(%rbx)
1800017ed:     	movsd	0x8(%r13,%rdi,8), %xmm2
1800017f4:     	ucomisd	%xmm8, %xmm2
1800017f9:     	jne	0x180001801 <.text+0x801>
1800017fb:     	jnp	0x1800015c0 <.text+0x5c0>
180001801:     	movq	0x258(%rsp), %rdx
180001809:     	movq	(%rdx,%rdi,8), %rcx
18000180d:     	divsd	%xmm2, %xmm1
180001811:     	addsd	(%r13,%rcx,8), %xmm1
180001818:     	movsd	%xmm1, (%r13,%rcx,8)
18000181f:     	movq	$0x0, 0x8(%rdx,%rcx,8)
180001828:     	movsd	0x8(%r13,%rdi,8), %xmm1
18000182f:     	ucomisd	%xmm8, %xmm1
180001834:     	jne	0x180001849 <.text+0x849>
180001836:     	jp	0x180001849 <.text+0x849>
180001838:     	movb	$0x1, (%r15)
18000183c:     	movq	$0x4c4b44, 0x18(%rbx)   # imm = 0x4C4B44
180001844:     	jmp	0x1800015cc <.text+0x5cc>
180001849:     	movq	(%rdx,%rdi,8), %rcx
18000184d:     	divsd	%xmm1, %xmm0
180001851:     	addsd	0x10(%r13,%rcx,8), %xmm0
180001858:     	movsd	%xmm0, 0x10(%r13,%rcx,8)
18000185f:     	movq	$0x0, 0x18(%rdx,%rcx,8)
180001868:     	jmp	0x1800015cc <.text+0x5cc>
18000186d:     	movq	0x138(%rsp), %rcx
180001875:     	jmp	0x18000111e <.text+0x11e>
18000187a:     	movb	$0x1, (%r15)
18000187e:     	movq	$0x9, 0x18(%rbx)
180001886:     	jmp	0x180001323 <.text+0x323>
18000188b:     	xorl	%eax, %eax
18000188d:     	xorl	%ecx, %ecx
18000188f:     	movq	0x128(%rsp), %rdx
180001897:     	cmpq	(%rbp,%rdx,8), %rcx
18000189c:     	jge	0x1800019b0 <.text+0x9b0>
1800018a2:     	movq	0x130(%rsp), %rdx
1800018aa:     	movq	0x10(%rbp,%rdx,8), %rdx
1800018af:     	addq	%rcx, %rdx
1800018b2:     	movq	0x258(%rsp), %r10
1800018ba:     	leaq	(%r10,%rdx,8), %r8
1800018be:     	sarq	$0x3f, %rdx
1800018c2:     	andq	%r12, %rdx
1800018c5:     	movq	(%r8,%rdx,8), %rdx
1800018c9:     	incq	%rcx
1800018cc:     	movq	(%r10,%rdx,8), %r8
1800018d0:     	movq	0x18(%r10,%rdx,8), %r9
1800018d5:     	movsd	(%r13,%r8,8), %xmm0
1800018dc:     	mulsd	%xmm6, %xmm0
1800018e0:     	addsd	(%r13,%r9,8), %xmm0
1800018e7:     	movsd	%xmm0, (%r13,%r9,8)
1800018ee:     	movq	$0x0, 0x8(%r10,%r9,8)
1800018f7:     	movq	(%r10,%rdx,8), %r8
1800018fb:     	movq	0x18(%r10,%rdx,8), %r9
180001900:     	movsd	0x10(%r13,%r8,8), %xmm0
180001907:     	mulsd	%xmm6, %xmm0
18000190b:     	addsd	0x10(%r13,%r9,8), %xmm0
180001912:     	movsd	%xmm0, 0x10(%r13,%r9,8)
180001919:     	movq	$0x0, 0x18(%r10,%r9,8)
180001922:     	movq	0x10(%r10,%rdx,8), %r8
180001927:     	movq	0x18(%r10,%rdx,8), %r9
18000192c:     	movsd	(%r13,%r9,8), %xmm0
180001933:     	mulsd	%xmm6, %xmm0
180001937:     	addsd	(%r13,%r8,8), %xmm0
18000193e:     	movsd	%xmm0, (%r13,%r8,8)
180001945:     	movq	$0x0, 0x8(%r10,%r8,8)
18000194e:     	movq	0x10(%r10,%rdx,8), %r8
180001953:     	movq	0x18(%r10,%rdx,8), %r9
180001958:     	movsd	0x10(%r13,%r9,8), %xmm0
18000195f:     	mulsd	%xmm6, %xmm0
180001963:     	addsd	0x10(%r13,%r8,8), %xmm0
18000196a:     	movsd	%xmm0, 0x10(%r13,%r8,8)
180001971:     	movq	$0x0, 0x18(%r10,%r8,8)
18000197a:     	movq	(%r10,%rdx,8), %r8
18000197e:     	movq	$0x0, (%r13,%r8,8)
180001987:     	movq	$0x1, 0x8(%r10,%r8,8)
180001990:     	movq	(%r10,%rdx,8), %rdx
180001994:     	movq	$0x0, 0x10(%r13,%rdx,8)
18000199d:     	movq	$0x1, 0x18(%r10,%rdx,8)
1800019a6:     	cmpb	$0x0, (%r15)
1800019aa:     	je	0x18000188f <.text+0x88f>
1800019b0:     	movq	0x118(%rsp), %rcx
1800019b8:     	jmp	0x18000111e <.text+0x11e>
1800019bd:     	movb	$0x1, (%r15)
1800019c1:     	movq	$0xd, 0x18(%rbx)
1800019c9:     	jmp	0x180001323 <.text+0x323>
1800019ce:     	nop
1800019d0:     	pushq	%r15
1800019d2:     	pushq	%r14
1800019d4:     	pushq	%r13
1800019d6:     	pushq	%r12
1800019d8:     	pushq	%rsi
1800019d9:     	pushq	%rdi
1800019da:     	pushq	%rbp
1800019db:     	pushq	%rbx
1800019dc:     	subq	$0x338, %rsp            # imm = 0x338
1800019e3:     	movaps	%xmm7, 0x320(%rsp)
1800019eb:     	movaps	%xmm6, 0x310(%rsp)
1800019f3:     	movq	%rdx, %rcx
1800019f6:     	leaq	0x1c8(%rsp), %rax
1800019fe:     	movq	%rax, 0x60(%rsp)
180001a03:     	leaq	0x1d0(%rsp), %rax
180001a0b:     	movq	%rax, 0x58(%rsp)
180001a10:     	leaq	0x1d8(%rsp), %rax
180001a18:     	movq	%rax, 0x50(%rsp)
180001a1d:     	leaq	0x1e0(%rsp), %rax
180001a25:     	movq	%rax, 0x48(%rsp)
180001a2a:     	leaq	0x1e8(%rsp), %rax
180001a32:     	movq	%rax, 0x40(%rsp)
180001a37:     	leaq	0x1f0(%rsp), %rax
180001a3f:     	movq	%rax, 0x38(%rsp)
180001a44:     	leaq	0x1f8(%rsp), %rax
180001a4c:     	movq	%rax, 0x30(%rsp)
180001a51:     	leaq	0x200(%rsp), %rax
180001a59:     	movq	%rax, 0x28(%rsp)
180001a5e:     	leaq	0x208(%rsp), %rax
180001a66:     	movq	%rax, 0x20(%rsp)
180001a6b:     	leaq	0xba3e(%rip), %rdx      # 0x18000d4b0
180001a72:     	movl	$0x9, %r8d
180001a78:     	movl	$0x9, %r9d
180001a7e:     	callq	0x18000b571 <numba_list_iter_next+0x311>
180001a83:     	testl	%eax, %eax
180001a85:     	movq	$0x0, 0x130(%rsp)
180001a91:     	je	0x18000218c <.text+0x118c>
180001a97:     	cmpq	$0x0, 0x13231(%rip)     # 0x180014cd0
180001a9f:     	je	0x1800020b4 <.text+0x10b4>
180001aa5:     	movq	0x208(%rsp), %rcx
180001aad:     	xorps	%xmm0, %xmm0
180001ab0:     	movaps	%xmm0, 0x2d0(%rsp)
180001ab8:     	movaps	%xmm0, 0x2e0(%rsp)
180001ac0:     	movaps	%xmm0, 0x2f0(%rsp)
180001ac8:     	movq	$0x0, 0x300(%rsp)
180001ad4:     	leaq	0x2d0(%rsp), %rdx
180001adc:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180001ae1:     	testl	%eax, %eax
180001ae3:     	jne	0x1800020cc <.text+0x10cc>
180001ae9:     	cmpq	$0x8, 0x2e8(%rsp)
180001af2:     	jne	0x1800020cc <.text+0x10cc>
180001af8:     	movq	0x2d0(%rsp), %rbx
180001b00:     	movq	0x2d8(%rsp), %rbp
180001b08:     	movq	0x2e0(%rsp), %rsi
180001b10:     	movq	0x2f0(%rsp), %rdi
180001b18:     	movq	0x2f8(%rsp), %r15
180001b20:     	movq	0x300(%rsp), %r13
180001b28:     	movq	0x200(%rsp), %rcx
180001b30:     	xorps	%xmm0, %xmm0
180001b33:     	movaps	%xmm0, 0x290(%rsp)
180001b3b:     	movaps	%xmm0, 0x2a0(%rsp)
180001b43:     	movaps	%xmm0, 0x2b0(%rsp)
180001b4b:     	movq	$0x0, 0x2c0(%rsp)
180001b57:     	leaq	0x290(%rsp), %rdx
180001b5f:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180001b64:     	testl	%eax, %eax
180001b66:     	jne	0x1800020e4 <.text+0x10e4>
180001b6c:     	cmpq	$0x8, 0x2a8(%rsp)
180001b75:     	jne	0x1800020e4 <.text+0x10e4>
180001b7b:     	movq	0x290(%rsp), %r12
180001b83:     	movq	0x298(%rsp), %r14
180001b8b:     	movq	0x2a0(%rsp), %rax
180001b93:     	movq	%rax, 0x1c0(%rsp)
180001b9b:     	movq	0x2b0(%rsp), %rax
180001ba3:     	movq	%rax, 0x1b8(%rsp)
180001bab:     	movq	0x2b8(%rsp), %rax
180001bb3:     	movq	%rax, 0x1b0(%rsp)
180001bbb:     	movq	0x2c0(%rsp), %rax
180001bc3:     	movq	%rax, 0x1a8(%rsp)
180001bcb:     	movq	0x1f8(%rsp), %rcx
180001bd3:     	xorps	%xmm0, %xmm0
180001bd6:     	movaps	%xmm0, 0x250(%rsp)
180001bde:     	movaps	%xmm0, 0x260(%rsp)
180001be6:     	movaps	%xmm0, 0x270(%rsp)
180001bee:     	movq	$0x0, 0x280(%rsp)
180001bfa:     	leaq	0x250(%rsp), %rdx
180001c02:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180001c07:     	testl	%eax, %eax
180001c09:     	jne	0x1800020fc <.text+0x10fc>
180001c0f:     	cmpq	$0x8, 0x268(%rsp)
180001c18:     	jne	0x1800020fc <.text+0x10fc>
180001c1e:     	movq	%r14, 0x1a0(%rsp)
180001c26:     	movq	0x250(%rsp), %r14
180001c2e:     	movq	0x258(%rsp), %rax
180001c36:     	movq	%rax, 0x198(%rsp)
180001c3e:     	movq	0x260(%rsp), %rax
180001c46:     	movq	%rax, 0x190(%rsp)
180001c4e:     	movq	0x270(%rsp), %rax
180001c56:     	movq	%rax, 0x188(%rsp)
180001c5e:     	movq	0x278(%rsp), %rax
180001c66:     	movq	%rax, 0x180(%rsp)
180001c6e:     	movq	0x280(%rsp), %rax
180001c76:     	movq	%rax, 0x178(%rsp)
180001c7e:     	movq	0x1f0(%rsp), %rcx
180001c86:     	xorps	%xmm0, %xmm0
180001c89:     	movaps	%xmm0, 0x210(%rsp)
180001c91:     	movaps	%xmm0, 0x220(%rsp)
180001c99:     	movaps	%xmm0, 0x230(%rsp)
180001ca1:     	movq	$0x0, 0x240(%rsp)
180001cad:     	leaq	0x210(%rsp), %rdx
180001cb5:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180001cba:     	testl	%eax, %eax
180001cbc:     	jne	0x180002111 <.text+0x1111>
180001cc2:     	cmpq	$0x1, 0x228(%rsp)
180001ccb:     	jne	0x180002111 <.text+0x1111>
180001cd1:     	movq	%r13, 0x150(%rsp)
180001cd9:     	movq	%r15, 0x158(%rsp)
180001ce1:     	movq	%rdi, 0x160(%rsp)
180001ce9:     	movq	%rsi, 0x168(%rsp)
180001cf1:     	movq	0x210(%rsp), %r15
180001cf9:     	movq	0x218(%rsp), %rax
180001d01:     	movq	%rax, 0x148(%rsp)
180001d09:     	movq	0x220(%rsp), %rax
180001d11:     	movq	%rax, 0x140(%rsp)
180001d19:     	movq	0x230(%rsp), %rax
180001d21:     	movq	%rax, 0x138(%rsp)
180001d29:     	movq	0x238(%rsp), %rdi
180001d31:     	movq	0x240(%rsp), %rsi
180001d39:     	movq	0x1e8(%rsp), %rcx
180001d41:     	callq	0x18000b577 <numba_list_iter_next+0x317>
180001d46:     	testq	%rax, %rax
180001d49:     	movq	%rbx, 0x128(%rsp)
180001d51:     	movq	%r12, 0x120(%rsp)
180001d59:     	movq	%rbp, 0x170(%rsp)
180001d61:     	je	0x180002126 <.text+0x1126>
180001d67:     	movq	%rax, %r13
180001d6a:     	movq	%rax, %rcx
180001d6d:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
180001d72:     	movq	%rax, %r12
180001d75:     	movq	%r13, %rcx
180001d78:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180001d7d:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180001d82:     	testq	%rax, %rax
180001d85:     	jne	0x18000215c <.text+0x115c>
180001d8b:     	movq	0x1e0(%rsp), %rcx
180001d93:     	callq	0x18000b58f <numba_list_iter_next+0x32f>
180001d98:     	movq	%rax, %rbx
180001d9b:     	movq	%rax, %rcx
180001d9e:     	callq	0x18000b595 <numba_list_iter_next+0x335>
180001da3:     	movaps	%xmm0, %xmm6
180001da6:     	movq	%rbx, %rcx
180001da9:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180001dae:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180001db3:     	testq	%rax, %rax
180001db6:     	jne	0x18000215c <.text+0x115c>
180001dbc:     	movq	0x1d8(%rsp), %rcx
180001dc4:     	callq	0x18000b58f <numba_list_iter_next+0x32f>
180001dc9:     	movq	%rax, %rbx
180001dcc:     	movq	%rax, %rcx
180001dcf:     	callq	0x18000b595 <numba_list_iter_next+0x335>
180001dd4:     	movaps	%xmm0, %xmm7
180001dd7:     	movq	%rbx, %rcx
180001dda:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180001ddf:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180001de4:     	testq	%rax, %rax
180001de7:     	jne	0x18000215c <.text+0x115c>
180001ded:     	movq	0x1d0(%rsp), %rcx
180001df5:     	callq	0x18000b577 <numba_list_iter_next+0x317>
180001dfa:     	testq	%rax, %rax
180001dfd:     	je	0x180002139 <.text+0x1139>
180001e03:     	movq	%rax, %rbp
180001e06:     	movq	%rax, %rcx
180001e09:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
180001e0e:     	movq	%rax, %r13
180001e11:     	movq	%rbp, %rcx
180001e14:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180001e19:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180001e1e:     	testq	%rax, %rax
180001e21:     	jne	0x18000215c <.text+0x115c>
180001e27:     	movq	0x1c8(%rsp), %rcx
180001e2f:     	callq	0x18000b577 <numba_list_iter_next+0x317>
180001e34:     	testq	%rax, %rax
180001e37:     	je	0x18000214c <.text+0x114c>
180001e3d:     	movq	%rax, %rbx
180001e40:     	movq	%rax, %rcx
180001e43:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
180001e48:     	movq	%rax, %rbp
180001e4b:     	movq	%rbx, %rcx
180001e4e:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180001e53:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180001e58:     	testq	%rax, %rax
180001e5b:     	jne	0x18000215c <.text+0x115c>
180001e61:     	movq	%rbp, 0x110(%rsp)
180001e69:     	movq	%r13, 0x108(%rsp)
180001e71:     	movq	%r12, 0xf0(%rsp)
180001e79:     	movq	%rsi, 0xe8(%rsp)
180001e81:     	movq	%rdi, 0xe0(%rsp)
180001e89:     	movq	0x138(%rsp), %rax
180001e91:     	movq	%rax, 0xd8(%rsp)
180001e99:     	movq	0x140(%rsp), %rax
180001ea1:     	movq	%rax, 0xc8(%rsp)
180001ea9:     	movq	0x148(%rsp), %rax
180001eb1:     	movq	%rax, 0xc0(%rsp)
180001eb9:     	movq	0x178(%rsp), %rax
180001ec1:     	movq	%rax, 0xb0(%rsp)
180001ec9:     	movq	0x180(%rsp), %rax
180001ed1:     	movq	%rax, 0xa8(%rsp)
180001ed9:     	movq	0x188(%rsp), %rax
180001ee1:     	movq	%rax, 0xa0(%rsp)
180001ee9:     	movq	0x190(%rsp), %rax
180001ef1:     	movq	%rax, 0x90(%rsp)
180001ef9:     	movq	0x198(%rsp), %rax
180001f01:     	movq	%rax, 0x88(%rsp)
180001f09:     	movq	0x1a8(%rsp), %rax
180001f11:     	movq	%rax, 0x78(%rsp)
180001f16:     	movq	0x1b0(%rsp), %rax
180001f1e:     	movq	%rax, 0x70(%rsp)
180001f23:     	movq	0x1b8(%rsp), %rax
180001f2b:     	movq	%rax, 0x68(%rsp)
180001f30:     	movq	0x1c0(%rsp), %rax
180001f38:     	movq	%rax, 0x58(%rsp)
180001f3d:     	movq	0x1a0(%rsp), %rax
180001f45:     	movq	%rax, 0x50(%rsp)
180001f4a:     	movq	0x150(%rsp), %rax
180001f52:     	movq	%rax, 0x40(%rsp)
180001f57:     	movq	0x158(%rsp), %rax
180001f5f:     	movq	%rax, 0x38(%rsp)
180001f64:     	movsd	%xmm7, 0x100(%rsp)
180001f6d:     	movsd	%xmm6, 0xf8(%rsp)
180001f76:     	movq	%r15, 0xb8(%rsp)
180001f7e:     	movq	%r14, 0x80(%rsp)
180001f86:     	movq	0x120(%rsp), %rdi
180001f8e:     	movq	%rdi, 0x48(%rsp)
180001f93:     	movq	0x160(%rsp), %rax
180001f9b:     	movq	%rax, 0x30(%rsp)
180001fa0:     	movq	0x168(%rsp), %rax
180001fa8:     	movq	%rax, 0x20(%rsp)
180001fad:     	movq	$0x1, 0xd0(%rsp)
180001fb9:     	movq	$0x8, 0x98(%rsp)
180001fc5:     	movq	$0x8, 0x60(%rsp)
180001fce:     	movq	$0x8, 0x28(%rsp)
180001fd7:     	leaq	0x308(%rsp), %rcx
180001fdf:     	leaq	0x130(%rsp), %rdx
180001fe7:     	movq	0x170(%rsp), %r9
180001fef:     	movq	0x128(%rsp), %rsi
180001ff7:     	movq	%rsi, %r8
180001ffa:     	callq	0x180001090 <.text+0x90>
180001fff:     	movl	%eax, %ebp
180002001:     	movq	0x130(%rsp), %rbx
180002009:     	movq	%rsi, %rcx
18000200c:     	callq	0x180001060 <.text+0x60>
180002011:     	movq	%rdi, %rcx
180002014:     	callq	0x180001060 <.text+0x60>
180002019:     	movq	%r14, %rcx
18000201c:     	callq	0x180001060 <.text+0x60>
180002021:     	movq	%r15, %rcx
180002024:     	callq	0x180001060 <.text+0x60>
180002029:     	testl	%ebp, %ebp
18000202b:     	jne	0x180002063 <.text+0x1063>
18000202d:     	movq	0xb29c(%rip), %rsi      # 0x18000d2d0
180002034:     	movq	%rsi, %rcx
180002037:     	callq	0x18000b59b <numba_list_iter_next+0x33b>
18000203c:     	movq	%rsi, %rax
18000203f:     	movaps	0x310(%rsp), %xmm6
180002047:     	movaps	0x320(%rsp), %xmm7
18000204f:     	addq	$0x338, %rsp            # imm = 0x338
180002056:     	popq	%rbx
180002057:     	popq	%rbp
180002058:     	popq	%rdi
180002059:     	popq	%rsi
18000205a:     	popq	%r12
18000205c:     	popq	%r13
18000205e:     	popq	%r14
180002060:     	popq	%r15
180002062:     	retq
180002063:     	jle	0x180002193 <.text+0x1193>
180002069:     	callq	0x18000b5a1 <numba_list_iter_next+0x341>
18000206e:     	movl	0x8(%rbx), %edx
180002071:     	movq	(%rbx), %rcx
180002074:     	cmpl	$0x0, 0x20(%rbx)
180002078:     	jle	0x1800021b2 <.text+0x11b2>
18000207e:     	movslq	%edx, %rdx
180002081:     	callq	0x18000b5a7 <numba_list_iter_next+0x347>
180002086:     	movq	%rax, %rsi
180002089:     	movq	0x10(%rbx), %rcx
18000208d:     	callq	*0x18(%rbx)
180002090:     	testq	%rax, %rax
180002093:     	je	0x1800021db <.text+0x11db>
180002099:     	movq	%rsi, %rcx
18000209c:     	movq	%rax, %rdx
18000209f:     	callq	0x180009a40 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5eb0>
1800020a4:     	movq	%rax, %rsi
1800020a7:     	movq	%rbx, %rcx
1800020aa:     	callq	0x18000b4d0 <numba_list_iter_next+0x270>
1800020af:     	jmp	0x1800021be <.text+0x11be>
1800020b4:     	movq	0xb1f5(%rip), %rcx      # 0x18000d2b0
1800020bb:     	leaq	0xb40e(%rip), %rdx      # 0x18000d4d0
1800020c2:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800020c7:     	jmp	0x18000218c <.text+0x118c>
1800020cc:     	movq	0xb1cd(%rip), %rcx      # 0x18000d2a0
1800020d3:     	leaq	0xb4f6(%rip), %rdx      # 0x18000d5d0
1800020da:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800020df:     	jmp	0x18000218c <.text+0x118c>
1800020e4:     	movq	0xb1b5(%rip), %rcx      # 0x18000d2a0
1800020eb:     	leaq	0xb4de(%rip), %rdx      # 0x18000d5d0
1800020f2:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800020f7:     	jmp	0x180002184 <.text+0x1184>
1800020fc:     	movq	0xb19d(%rip), %rcx      # 0x18000d2a0
180002103:     	leaq	0xb4c6(%rip), %rdx      # 0x18000d5d0
18000210a:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
18000210f:     	jmp	0x18000217c <.text+0x117c>
180002111:     	movq	0xb188(%rip), %rcx      # 0x18000d2a0
180002118:     	leaq	0xb4b1(%rip), %rdx      # 0x18000d5d0
18000211f:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180002124:     	jmp	0x180002174 <.text+0x1174>
180002126:     	xorl	%r12d, %r12d
180002129:     	callq	0x18000b589 <numba_list_iter_next+0x329>
18000212e:     	testq	%rax, %rax
180002131:     	je	0x180001d8b <.text+0xd8b>
180002137:     	jmp	0x18000215c <.text+0x115c>
180002139:     	xorl	%r13d, %r13d
18000213c:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180002141:     	testq	%rax, %rax
180002144:     	je	0x180001e27 <.text+0xe27>
18000214a:     	jmp	0x18000215c <.text+0x115c>
18000214c:     	xorl	%ebp, %ebp
18000214e:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180002153:     	testq	%rax, %rax
180002156:     	je	0x180001e61 <.text+0xe61>
18000215c:     	movq	%r15, %rcx
18000215f:     	callq	0x180001060 <.text+0x60>
180002164:     	movq	0x128(%rsp), %rbx
18000216c:     	movq	0x120(%rsp), %r12
180002174:     	movq	%r14, %rcx
180002177:     	callq	0x180001060 <.text+0x60>
18000217c:     	movq	%r12, %rcx
18000217f:     	callq	0x180001060 <.text+0x60>
180002184:     	movq	%rbx, %rcx
180002187:     	callq	0x180001060 <.text+0x60>
18000218c:     	xorl	%esi, %esi
18000218e:     	jmp	0x18000203c <.text+0x103c>
180002193:     	cmpl	$-0x3, %ebp
180002196:     	je	0x1800021cd <.text+0x11cd>
180002198:     	cmpl	$-0x1, %ebp
18000219b:     	je	0x18000218c <.text+0x118c>
18000219d:     	movq	0xb0f4(%rip), %rcx      # 0x18000d298
1800021a4:     	leaq	0xb4c5(%rip), %rdx      # 0x18000d670
1800021ab:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800021b0:     	jmp	0x18000218c <.text+0x118c>
1800021b2:     	movq	0x10(%rbx), %r8
1800021b6:     	callq	0x180009960 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dd0>
1800021bb:     	movq	%rax, %rsi
1800021be:     	testq	%rsi, %rsi
1800021c1:     	je	0x18000218c <.text+0x118c>
1800021c3:     	movq	%rsi, %rcx
1800021c6:     	callq	0x180009500 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5970>
1800021cb:     	jmp	0x18000218c <.text+0x118c>
1800021cd:     	movq	0xb0bc(%rip), %rcx      # 0x18000d290
1800021d4:     	callq	0x18000b5b3 <numba_list_iter_next+0x353>
1800021d9:     	jmp	0x18000218c <.text+0x118c>
1800021db:     	movq	0xb0ce(%rip), %rcx      # 0x18000d2b0
1800021e2:     	leaq	0xb447(%rip), %rdx      # 0x18000d630
1800021e9:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800021ee:     	jmp	0x18000218c <.text+0x118c>
1800021f0:     	pushq	%r15
1800021f2:     	pushq	%r14
1800021f4:     	pushq	%r13
1800021f6:     	pushq	%r12
1800021f8:     	pushq	%rsi
1800021f9:     	pushq	%rdi
1800021fa:     	pushq	%rbp
1800021fb:     	pushq	%rbx
1800021fc:     	subq	$0x148, %rsp            # imm = 0x148
180002203:     	movq	%r9, %r12
180002206:     	movq	%r8, %r13
180002209:     	movq	%rdx, 0x140(%rsp)
180002211:     	movq	%rcx, 0x138(%rsp)
180002219:     	movsd	0x278(%rsp), %xmm0
180002222:     	movsd	0x280(%rsp), %xmm1
18000222b:     	movq	$0x0, 0x130(%rsp)
180002237:     	movq	$0x0, 0x128(%rsp)
180002243:     	movq	0x220(%rsp), %rbp
18000224b:     	movq	0x228(%rsp), %r15
180002253:     	movq	0x230(%rsp), %r14
18000225b:     	movq	0x238(%rsp), %rbx
180002263:     	movq	0x240(%rsp), %rdi
18000226b:     	movq	0x248(%rsp), %rsi
180002273:     	movq	0x250(%rsp), %r11
18000227b:     	movq	0x258(%rsp), %r10
180002283:     	movq	0x260(%rsp), %r9
18000228b:     	movq	0x268(%rsp), %r8
180002293:     	movq	0x270(%rsp), %rdx
18000229b:     	movq	0x288(%rsp), %rcx
1800022a3:     	movq	0x290(%rsp), %rax
1800022ab:     	movq	%rax, 0x110(%rsp)
1800022b3:     	movq	%rcx, 0x108(%rsp)
1800022bb:     	movq	%rdx, 0xf0(%rsp)
1800022c3:     	movq	%r8, 0xe8(%rsp)
1800022cb:     	movq	%r9, 0xe0(%rsp)
1800022d3:     	movq	%r10, 0xd8(%rsp)
1800022db:     	movq	%r11, 0xd0(%rsp)
1800022e3:     	movq	%rsi, 0xc8(%rsp)
1800022eb:     	movq	%rdi, 0xc0(%rsp)
1800022f3:     	movq	%rbx, 0xb8(%rsp)
1800022fb:     	movq	%r14, 0xb0(%rsp)
180002303:     	movq	%r15, 0xa8(%rsp)
18000230b:     	movq	%rbp, 0xa0(%rsp)
180002313:     	movq	0x218(%rsp), %rax
18000231b:     	movq	%rax, 0x98(%rsp)
180002323:     	movq	0x210(%rsp), %rax
18000232b:     	movq	%rax, 0x90(%rsp)
180002333:     	movq	0x208(%rsp), %rax
18000233b:     	movq	%rax, 0x88(%rsp)
180002343:     	movq	0x200(%rsp), %rax
18000234b:     	movq	%rax, 0x80(%rsp)
180002353:     	movq	0x1f8(%rsp), %rax
18000235b:     	movq	%rax, 0x78(%rsp)
180002360:     	movq	0x1f0(%rsp), %rax
180002368:     	movq	%rax, 0x70(%rsp)
18000236d:     	movq	0x1e8(%rsp), %rax
180002375:     	movq	%rax, 0x68(%rsp)
18000237a:     	movq	0x1e0(%rsp), %rax
180002382:     	movq	%rax, 0x60(%rsp)
180002387:     	movq	0x1d8(%rsp), %rax
18000238f:     	movq	%rax, 0x58(%rsp)
180002394:     	movq	0x1d0(%rsp), %rax
18000239c:     	movq	%rax, 0x50(%rsp)
1800023a1:     	movq	0x1c8(%rsp), %rax
1800023a9:     	movq	%rax, 0x48(%rsp)
1800023ae:     	movq	0x1c0(%rsp), %rax
1800023b6:     	movq	%rax, 0x40(%rsp)
1800023bb:     	movq	0x1b8(%rsp), %rax
1800023c3:     	movq	%rax, 0x38(%rsp)
1800023c8:     	movq	0x1b0(%rsp), %rax
1800023d0:     	movq	%rax, 0x30(%rsp)
1800023d5:     	movsd	%xmm1, 0x100(%rsp)
1800023de:     	movsd	%xmm0, 0xf8(%rsp)
1800023e7:     	movq	%r12, 0x28(%rsp)
1800023ec:     	movq	%r13, 0x20(%rsp)
1800023f1:     	leaq	0x130(%rsp), %rcx
1800023f9:     	leaq	0x128(%rsp), %rdx
180002401:     	movq	0x138(%rsp), %r8
180002409:     	movq	0x140(%rsp), %r9
180002411:     	callq	0x180001090 <.text+0x90>
180002416:     	movl	%eax, %edx
180002418:     	movq	0x128(%rsp), %rsi
180002420:     	movq	0x130(%rsp), %rax
180002428:     	movl	$0x0, 0x124(%rsp)
180002433:     	testl	%edx, %edx
180002435:     	jne	0x18000244b <.text+0x144b>
180002437:     	addq	$0x148, %rsp            # imm = 0x148
18000243e:     	popq	%rbx
18000243f:     	popq	%rbp
180002440:     	popq	%rdi
180002441:     	popq	%rsi
180002442:     	popq	%r12
180002444:     	popq	%r13
180002446:     	popq	%r14
180002448:     	popq	%r15
18000244a:     	retq
18000244b:     	movq	%rax, %rbx
18000244e:     	leaq	0x124(%rsp), %rcx
180002456:     	movl	%edx, %edi
180002458:     	callq	0x1800094d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5940>
18000245d:     	testl	%edi, %edi
18000245f:     	jle	0x1800024a5 <.text+0x14a5>
180002461:     	callq	0x18000b5a1 <numba_list_iter_next+0x341>
180002466:     	movl	0x8(%rsi), %edx
180002469:     	movq	(%rsi), %rcx
18000246c:     	cmpl	$0x0, 0x20(%rsi)
180002470:     	jle	0x1800024c6 <.text+0x14c6>
180002472:     	movslq	%edx, %rdx
180002475:     	callq	0x18000b5a7 <numba_list_iter_next+0x347>
18000247a:     	movq	%rax, %rdi
18000247d:     	movq	0x10(%rsi), %rcx
180002481:     	callq	*0x18(%rsi)
180002484:     	testq	%rax, %rax
180002487:     	je	0x180002521 <.text+0x1521>
18000248d:     	movq	%rdi, %rcx
180002490:     	movq	%rax, %rdx
180002493:     	callq	0x180009a40 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5eb0>
180002498:     	movq	%rax, %rdi
18000249b:     	movq	%rsi, %rcx
18000249e:     	callq	0x18000b4d0 <numba_list_iter_next+0x270>
1800024a3:     	jmp	0x1800024d2 <.text+0x14d2>
1800024a5:     	movl	%edi, %eax
1800024a7:     	cmpl	$-0x3, %edi
1800024aa:     	je	0x180002513 <.text+0x1513>
1800024ac:     	cmpl	$-0x1, %eax
1800024af:     	je	0x1800024df <.text+0x14df>
1800024b1:     	movq	0xade0(%rip), %rcx      # 0x18000d298
1800024b8:     	leaq	0xb221(%rip), %rdx      # 0x18000d6e0
1800024bf:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
1800024c4:     	jmp	0x1800024df <.text+0x14df>
1800024c6:     	movq	0x10(%rsi), %r8
1800024ca:     	callq	0x180009960 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dd0>
1800024cf:     	movq	%rax, %rdi
1800024d2:     	testq	%rdi, %rdi
1800024d5:     	je	0x1800024df <.text+0x14df>
1800024d7:     	movq	%rdi, %rcx
1800024da:     	callq	0x180009500 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5970>
1800024df:     	leaq	0xb22a(%rip), %rcx      # 0x18000d710
1800024e6:     	callq	0x18000b5b9 <numba_list_iter_next+0x359>
1800024eb:     	movq	%rax, %rsi
1800024ee:     	movq	%rax, %rcx
1800024f1:     	callq	0x18000b5bf <numba_list_iter_next+0x35f>
1800024f6:     	movq	%rsi, %rcx
1800024f9:     	callq	0x18000b583 <numba_list_iter_next+0x323>
1800024fe:     	leaq	0x124(%rsp), %rcx
180002506:     	callq	0x1800094f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5960>
18000250b:     	movq	%rbx, %rax
18000250e:     	jmp	0x180002437 <.text+0x1437>
180002513:     	movq	0xad76(%rip), %rcx      # 0x18000d290
18000251a:     	callq	0x18000b5b3 <numba_list_iter_next+0x353>
18000251f:     	jmp	0x1800024df <.text+0x14df>
180002521:     	movq	0xad88(%rip), %rcx      # 0x18000d2b0
180002528:     	leaq	0xb171(%rip), %rdx      # 0x18000d6a0
18000252f:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180002534:     	xorl	%eax, %eax
180002536:     	jmp	0x180002437 <.text+0x1437>
18000253b:     	nopl	(%rax,%rax)
180002540:     	pushq	%r15
180002542:     	pushq	%r14
180002544:     	pushq	%r13
180002546:     	pushq	%r12
180002548:     	pushq	%rsi
180002549:     	pushq	%rdi
18000254a:     	pushq	%rbp
18000254b:     	pushq	%rbx
18000254c:     	subq	$0x1a8, %rsp            # imm = 0x1A8
180002553:     	movapd	%xmm7, 0x190(%rsp)
18000255c:     	movaps	%xmm6, 0x180(%rsp)
180002564:     	movq	0x2f8(%rsp), %r10
18000256c:     	movq	0x2c8(%rsp), %r15
180002574:     	movq	0x290(%rsp), %r14
18000257c:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180002586:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
180002590:     	xorpd	%xmm0, %xmm0
180002594:     	movapd	%xmm0, 0x160(%rsp)
18000259d:     	movq	$0x0, 0x178(%rsp)
1800025a9:     	movb	$0x0, 0x11f(%rsp)
1800025b1:     	movq	$0x0, 0x158(%rsp)
1800025bd:     	leaq	(%r10,%rax), %r11
1800025c1:     	cmpq	%rsi, %r11
1800025c4:     	jb	0x1800025d6 <.text+0x15d6>
1800025c6:     	movq	0x300(%rsp), %r11
1800025ce:     	addq	%r11, %rax
1800025d1:     	cmpq	%rsi, %rax
1800025d4:     	jae	0x18000260f <.text+0x160f>
1800025d6:     	movb	$0x1, (%r15)
1800025da:     	movq	$0x4, 0x18(%r14)
1800025e2:     	movq	$0x0, (%rcx)
1800025e9:     	xorl	%eax, %eax
1800025eb:     	movaps	0x180(%rsp), %xmm6
1800025f3:     	movaps	0x190(%rsp), %xmm7
1800025fb:     	addq	$0x1a8, %rsp            # imm = 0x1A8
180002602:     	popq	%rbx
180002603:     	popq	%rbp
180002604:     	popq	%rdi
180002605:     	popq	%rsi
180002606:     	popq	%r12
180002608:     	popq	%r13
18000260a:     	popq	%r14
18000260c:     	popq	%r15
18000260e:     	retq
18000260f:     	movq	0x260(%rsp), %r12
180002617:     	movq	(%r14), %rax
18000261a:     	leaq	0x4(%rax), %rsi
18000261e:     	cmpq	%r12, %rsi
180002621:     	jle	0x180002629 <.text+0x1629>
180002623:     	movb	$0x2, (%r15)
180002627:     	jmp	0x1800025e2 <.text+0x15e2>
180002629:     	movq	%rsi, (%r14)
18000262c:     	cmpb	$0x0, (%r15)
180002630:     	jne	0x1800025e2 <.text+0x15e2>
180002632:     	movq	0x220(%rsp), %r13
18000263a:     	testq	%rax, %rax
18000263d:     	js	0x180002684 <.text+0x1684>
18000263f:     	xorps	%xmm0, %xmm0
180002642:     	cvtsi2sd	%r11, %xmm0
180002647:     	movsd	0xad61(%rip), %xmm1     # 0x18000d3b0
18000264f:     	mulsd	%xmm1, %xmm0
180002653:     	cvtsi2sd	%r10, %xmm2
180002658:     	mulsd	%xmm1, %xmm2
18000265c:     	movsd	%xmm2, 0x10(%r13,%rax,8)
180002663:     	movsd	%xmm0, 0x18(%r13,%rax,8)
18000266a:     	movsd	%xmm2, 0x8(%r13,%rax,8)
180002671:     	movsd	%xmm0, (%r13,%rax,8)
180002678:     	cmpb	$0x0, (%r15)
18000267c:     	jne	0x1800025e2 <.text+0x15e2>
180002682:     	jmp	0x18000269a <.text+0x169a>
180002684:     	movb	$0x1, (%r15)
180002688:     	movq	$0xf4242, 0x18(%r14)    # imm = 0xF4242
180002690:     	cmpb	$0x0, (%r15)
180002694:     	jne	0x1800025e2 <.text+0x15e2>
18000269a:     	movq	(%r14), %rsi
18000269d:     	leaq	0xb(%rsi), %r10
1800026a1:     	cmpq	%r12, %r10
1800026a4:     	jg	0x180002623 <.text+0x1623>
1800026aa:     	movq	%r10, (%r14)
1800026ad:     	cmpb	$0x0, (%r15)
1800026b1:     	jne	0x1800025e2 <.text+0x15e2>
1800026b7:     	movq	0x258(%rsp), %rbp
1800026bf:     	movq	%rax, (%rbp,%rsi,8)
1800026c4:     	movq	$0x4, 0x8(%rbp,%rsi,8)
1800026cd:     	movq	(%r14), %r10
1800026d0:     	cmpq	%r12, %r10
1800026d3:     	movq	%r10, %rax
1800026d6:     	jle	0x1800026e1 <.text+0x16e1>
1800026d8:     	movb	$0x2, (%r15)
1800026dc:     	movq	(%r14), %r10
1800026df:     	xorl	%eax, %eax
1800026e1:     	leaq	0x3(%r10), %r11
1800026e5:     	cmpq	%r12, %r11
1800026e8:     	jg	0x180002623 <.text+0x1623>
1800026ee:     	movq	%r11, (%r14)
1800026f1:     	cmpb	$0x0, (%r15)
1800026f5:     	jne	0x1800025e2 <.text+0x15e2>
1800026fb:     	movq	%r10, %r11
1800026fe:     	sarq	$0x3f, %r11
180002702:     	andq	%r12, %r11
180002705:     	leaq	(%rbp,%r10,8), %rdi
18000270a:     	movq	$0x0, (%rdi,%r11,8)
180002712:     	xorl	%r11d, %r11d
180002715:     	cmpq	$-0x1, %r10
180002719:     	movl	$0x0, %ebx
18000271e:     	cmovlq	%r12, %rbx
180002722:     	movq	$0x0, 0x8(%rdi,%rbx,8)
18000272b:     	cmpq	$-0x2, %r10
18000272f:     	cmovlq	%r12, %r11
180002733:     	movq	%rax, 0x10(%rdi,%r11,8)
180002738:     	cmpb	$0x0, (%r15)
18000273c:     	jne	0x1800025e2 <.text+0x15e2>
180002742:     	leaq	(%rbp,%rsi,8), %rax
180002747:     	movq	%r10, 0x30(%rax)
18000274b:     	movq	$0x0, 0x18(%rax)
180002753:     	movq	(%r14), %r10
180002756:     	leaq	0x4(%r10), %r11
18000275a:     	cmpq	%r12, %r11
18000275d:     	jg	0x180002623 <.text+0x1623>
180002763:     	movq	%r11, (%r14)
180002766:     	cmpb	$0x0, (%r15)
18000276a:     	jne	0x1800025e2 <.text+0x15e2>
180002770:     	movq	%r8, 0x150(%rsp)
180002778:     	movq	%r9, 0x148(%rsp)
180002780:     	movq	%rdx, 0x140(%rsp)
180002788:     	movq	%rcx, 0x120(%rsp)
180002790:     	testq	%r10, %r10
180002793:     	js	0x1800027bc <.text+0x17bc>
180002795:     	movq	$0x0, (%r13,%r10,8)
18000279e:     	leaq	(%rbp,%r10,8), %rcx
1800027a3:     	movq	$0x1, 0x8(%rbp,%r10,8)
1800027ac:     	movq	$0x0, 0x10(%r13,%r10,8)
1800027b5:     	movl	$0x1, %edx
1800027ba:     	jmp	0x1800027c8 <.text+0x17c8>
1800027bc:     	movb	$0x1, (%r15)
1800027c0:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
1800027c5:     	movq	%r14, %rcx
1800027c8:     	movq	%rdx, 0x18(%rcx)
1800027cc:     	cmpb	$0x0, (%r15)
1800027d0:     	movq	0x120(%rsp), %rcx
1800027d8:     	jne	0x1800025e2 <.text+0x15e2>
1800027de:     	movq	%r10, 0x10(%rax)
1800027e2:     	movq	$0x0, 0x48(%r13,%rsi,8)
1800027eb:     	movq	$0x1, 0x50(%rax)
1800027f3:     	movq	$-0x1, 0x20(%rax)
1800027fb:     	movq	$-0x1, 0x28(%rax)
180002803:     	movq	$-0x1, 0x38(%rax)
18000280b:     	movq	$-0x1, 0x40(%rax)
180002813:     	cmpb	$0x0, (%r15)
180002817:     	jne	0x1800025e2 <.text+0x15e2>
18000281d:     	movq	0x2e0(%rsp), %rax
180002825:     	movq	%rax, %rcx
180002828:     	sarq	$0x3f, %rcx
18000282c:     	andq	%r12, %rcx
18000282f:     	xorl	%edx, %edx
180002831:     	cmpq	$-0x2, %rax
180002835:     	leaq	(%rbp,%rax,8), %rax
18000283a:     	cmovlq	%r12, %rdx
18000283e:     	movq	%rdx, 0x138(%rsp)
180002846:     	movq	%rcx, 0x130(%rsp)
18000284e:     	movq	%rax, 0x128(%rsp)
180002856:     	cmpq	$0x0, (%rax,%rcx,8)
18000285b:     	jle	0x180002a96 <.text+0x1a96>
180002861:     	testq	%rsi, %rsi
180002864:     	js	0x180002d76 <.text+0x1d76>
18000286a:     	movq	0x8(%r14), %rax
18000286e:     	xorl	%edi, %edi
180002870:     	leaq	0x11f(%rsp), %rbx
180002878:     	movq	0x138(%rsp), %rcx
180002880:     	movq	0x128(%rsp), %rdx
180002888:     	movq	0x10(%rdx,%rcx,8), %rcx
18000288d:     	addq	%rdi, %rcx
180002890:     	leaq	(%rbp,%rcx,8), %rdx
180002895:     	sarq	$0x3f, %rcx
180002899:     	andq	%r12, %rcx
18000289c:     	movq	(%rdx,%rcx,8), %rcx
1800028a0:     	leaq	0x1(%rax), %rdx
1800028a4:     	movq	%rdx, 0x8(%r14)
1800028a8:     	cmpq	0x10(%r14), %rax
1800028ac:     	jge	0x180002d76 <.text+0x1d76>
1800028b2:     	movq	%rcx, 0x100(%rsp)
1800028ba:     	movq	%rsi, 0xf8(%rsp)
1800028c2:     	movq	0x2d8(%rsp), %rax
1800028ca:     	movq	%rax, 0xe8(%rsp)
1800028d2:     	movq	0x2d0(%rsp), %rax
1800028da:     	movq	%rax, 0xe0(%rsp)
1800028e2:     	movq	%r15, 0xd8(%rsp)
1800028ea:     	movq	0x2c0(%rsp), %rax
1800028f2:     	movq	%rax, 0xd0(%rsp)
1800028fa:     	movq	0x2b8(%rsp), %rax
180002902:     	movq	%rax, 0xc8(%rsp)
18000290a:     	movq	0x2b0(%rsp), %rax
180002912:     	movq	%rax, 0xc0(%rsp)
18000291a:     	movq	0x2a8(%rsp), %rax
180002922:     	movq	%rax, 0xb8(%rsp)
18000292a:     	movq	0x2a0(%rsp), %rax
180002932:     	movq	%rax, 0xb0(%rsp)
18000293a:     	movq	0x298(%rsp), %rax
180002942:     	movq	%rax, 0xa8(%rsp)
18000294a:     	movq	%r14, 0xa0(%rsp)
180002952:     	movq	0x288(%rsp), %rax
18000295a:     	movq	%rax, 0x98(%rsp)
180002962:     	movq	0x280(%rsp), %rax
18000296a:     	movq	%rax, 0x90(%rsp)
180002972:     	movq	0x278(%rsp), %rax
18000297a:     	movq	%rax, 0x88(%rsp)
180002982:     	movq	0x270(%rsp), %rax
18000298a:     	movq	%rax, 0x80(%rsp)
180002992:     	movq	0x268(%rsp), %rax
18000299a:     	movq	%rax, 0x78(%rsp)
18000299f:     	movq	%r12, 0x70(%rsp)
1800029a4:     	movq	%rbp, 0x68(%rsp)
1800029a9:     	movq	0x250(%rsp), %rax
1800029b1:     	movq	%rax, 0x60(%rsp)
1800029b6:     	movq	0x248(%rsp), %rax
1800029be:     	movq	%rax, 0x58(%rsp)
1800029c3:     	movq	0x240(%rsp), %rax
1800029cb:     	movq	%rax, 0x50(%rsp)
1800029d0:     	movq	0x238(%rsp), %rax
1800029d8:     	movq	%rax, 0x48(%rsp)
1800029dd:     	movq	0x230(%rsp), %rax
1800029e5:     	movq	%rax, 0x40(%rsp)
1800029ea:     	movq	0x228(%rsp), %rax
1800029f2:     	movq	%rax, 0x38(%rsp)
1800029f7:     	movq	%r13, 0x30(%rsp)
1800029fc:     	movq	0x218(%rsp), %rax
180002a04:     	movq	%rax, 0x28(%rsp)
180002a09:     	movq	0x210(%rsp), %rax
180002a11:     	movq	%rax, 0x20(%rsp)
180002a16:     	movq	$-0x1, 0x108(%rsp)
180002a22:     	movq	$0x0, 0xf0(%rsp)
180002a2e:     	movq	%rbx, %rcx
180002a31:     	leaq	0x158(%rsp), %rdx
180002a39:     	movq	0x150(%rsp), %r8
180002a41:     	movq	0x148(%rsp), %r9
180002a49:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180002a4e:     	testl	%eax, %eax
180002a50:     	jne	0x180002fab <.text+0x1fab>
180002a56:     	cmpb	$0x0, (%r15)
180002a5a:     	jne	0x180002d82 <.text+0x1d82>
180002a60:     	incq	%rdi
180002a63:     	movq	0x8(%r14), %rax
180002a67:     	decq	%rax
180002a6a:     	movq	%rax, 0x8(%r14)
180002a6e:     	movq	0x130(%rsp), %rcx
180002a76:     	movq	0x128(%rsp), %rdx
180002a7e:     	cmpq	(%rdx,%rcx,8), %rdi
180002a82:     	jl	0x180002878 <.text+0x1878>
180002a88:     	leaq	0x18(%r14), %rax
180002a8c:     	movq	%rax, 0x110(%rsp)
180002a94:     	jmp	0x180002aab <.text+0x1aab>
180002a96:     	leaq	0x18(%r14), %rax
180002a9a:     	movq	%rax, 0x110(%rsp)
180002aa2:     	testq	%rsi, %rsi
180002aa5:     	js	0x180002d96 <.text+0x1d96>
180002aab:     	movsd	0x2e8(%rsp), %xmm6
180002ab4:     	xorl	%edi, %edi
180002ab6:     	xorpd	%xmm7, %xmm7
180002aba:     	movq	0x130(%rsp), %rax
180002ac2:     	movq	0x128(%rsp), %rcx
180002aca:     	cmpq	(%rcx,%rax,8), %rdi
180002ace:     	jge	0x180002d96 <.text+0x1d96>
180002ad4:     	movq	0x138(%rsp), %rax
180002adc:     	movq	0x128(%rsp), %rcx
180002ae4:     	movq	0x10(%rcx,%rax,8), %rax
180002ae9:     	addq	%rdi, %rax
180002aec:     	leaq	(%rbp,%rax,8), %rcx
180002af1:     	sarq	$0x3f, %rax
180002af5:     	andq	%r12, %rax
180002af8:     	movq	(%rcx,%rax,8), %rbx
180002afc:     	movq	0x8(%r14), %rax
180002b00:     	leaq	0x1(%rax), %rcx
180002b04:     	movq	%rcx, 0x8(%r14)
180002b08:     	cmpq	0x10(%r14), %rax
180002b0c:     	jge	0x180002fdb <.text+0x1fdb>
180002b12:     	movsd	%xmm6, 0x100(%rsp)
180002b1b:     	movq	%rbx, 0xf8(%rsp)
180002b23:     	movq	%rsi, 0xf0(%rsp)
180002b2b:     	movq	0x2d8(%rsp), %rax
180002b33:     	movq	%rax, 0xe8(%rsp)
180002b3b:     	movq	0x2d0(%rsp), %rax
180002b43:     	movq	%rax, 0xe0(%rsp)
180002b4b:     	movq	%r15, 0xd8(%rsp)
180002b53:     	movq	0x2c0(%rsp), %rax
180002b5b:     	movq	%rax, 0xd0(%rsp)
180002b63:     	movq	0x2b8(%rsp), %rax
180002b6b:     	movq	%rax, 0xc8(%rsp)
180002b73:     	movq	0x2b0(%rsp), %rax
180002b7b:     	movq	%rax, 0xc0(%rsp)
180002b83:     	movq	0x2a8(%rsp), %rax
180002b8b:     	movq	%rax, 0xb8(%rsp)
180002b93:     	movq	0x2a0(%rsp), %rax
180002b9b:     	movq	%rax, 0xb0(%rsp)
180002ba3:     	movq	0x298(%rsp), %rax
180002bab:     	movq	%rax, 0xa8(%rsp)
180002bb3:     	movq	%r14, 0xa0(%rsp)
180002bbb:     	movq	0x288(%rsp), %rax
180002bc3:     	movq	%rax, 0x98(%rsp)
180002bcb:     	movq	0x280(%rsp), %rax
180002bd3:     	movq	%rax, 0x90(%rsp)
180002bdb:     	movq	0x278(%rsp), %rax
180002be3:     	movq	%rax, 0x88(%rsp)
180002beb:     	movq	0x270(%rsp), %rax
180002bf3:     	movq	%rax, 0x80(%rsp)
180002bfb:     	movq	0x268(%rsp), %rax
180002c03:     	movq	%rax, 0x78(%rsp)
180002c08:     	movq	%r12, 0x70(%rsp)
180002c0d:     	movq	%rbp, 0x68(%rsp)
180002c12:     	movq	0x250(%rsp), %rax
180002c1a:     	movq	%rax, 0x60(%rsp)
180002c1f:     	movq	0x248(%rsp), %rax
180002c27:     	movq	%rax, 0x58(%rsp)
180002c2c:     	movq	0x240(%rsp), %rax
180002c34:     	movq	%rax, 0x50(%rsp)
180002c39:     	movq	0x238(%rsp), %rax
180002c41:     	movq	%rax, 0x48(%rsp)
180002c46:     	movq	0x230(%rsp), %rax
180002c4e:     	movq	%rax, 0x40(%rsp)
180002c53:     	movq	0x228(%rsp), %rax
180002c5b:     	movq	%rax, 0x38(%rsp)
180002c60:     	movq	%r13, 0x30(%rsp)
180002c65:     	movq	0x218(%rsp), %rax
180002c6d:     	movq	%rax, 0x28(%rsp)
180002c72:     	movq	0x210(%rsp), %rax
180002c7a:     	movq	%rax, 0x20(%rsp)
180002c7f:     	leaq	0x160(%rsp), %rcx
180002c87:     	leaq	0x178(%rsp), %rdx
180002c8f:     	movq	0x150(%rsp), %r8
180002c97:     	movq	0x148(%rsp), %r9
180002c9f:     	callq	0x1800066c0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b30>
180002ca4:     	testl	%eax, %eax
180002ca6:     	jne	0x18000300b <.text+0x200b>
180002cac:     	cmpb	$0x0, (%r15)
180002cb0:     	jne	0x180002d82 <.text+0x1d82>
180002cb6:     	movsd	0x160(%rsp), %xmm1
180002cbf:     	movsd	0x168(%rsp), %xmm0
180002cc8:     	decq	0x8(%r14)
180002ccc:     	testq	%rbx, %rbx
180002ccf:     	js	0x180002ff3 <.text+0x1ff3>
180002cd5:     	movq	(%rbp,%rbx,8), %rax
180002cda:     	testq	%rax, %rax
180002cdd:     	js	0x180002cee <.text+0x1cee>
180002cdf:     	movsd	0x8(%r13,%rbx,8), %xmm2
180002ce6:     	ucomisd	%xmm7, %xmm2
180002cea:     	jne	0x180002d10 <.text+0x1d10>
180002cec:     	jp	0x180002d10 <.text+0x1d10>
180002cee:     	movb	$0x1, (%r15)
180002cf2:     	movq	0x110(%rsp), %rax
180002cfa:     	movq	$0x4c4b43, (%rax)       # imm = 0x4C4B43
180002d01:     	incq	%rdi
180002d04:     	cmpb	$0x0, (%r15)
180002d08:     	je	0x180002aba <.text+0x1aba>
180002d0e:     	jmp	0x180002d82 <.text+0x1d82>
180002d10:     	divsd	%xmm2, %xmm1
180002d14:     	addsd	(%r13,%rax,8), %xmm1
180002d1b:     	movsd	%xmm1, (%r13,%rax,8)
180002d22:     	movq	$0x0, 0x8(%rbp,%rax,8)
180002d2b:     	movq	(%rbp,%rbx,8), %rax
180002d30:     	testq	%rax, %rax
180002d33:     	js	0x180002d44 <.text+0x1d44>
180002d35:     	movsd	0x8(%r13,%rbx,8), %xmm1
180002d3c:     	ucomisd	%xmm7, %xmm1
180002d40:     	jne	0x180002d59 <.text+0x1d59>
180002d42:     	jp	0x180002d59 <.text+0x1d59>
180002d44:     	movb	$0x1, (%r15)
180002d48:     	movq	0x110(%rsp), %rax
180002d50:     	movq	$0x4c4b44, (%rax)       # imm = 0x4C4B44
180002d57:     	jmp	0x180002d01 <.text+0x1d01>
180002d59:     	divsd	%xmm1, %xmm0
180002d5d:     	addsd	0x10(%r13,%rax,8), %xmm0
180002d64:     	movsd	%xmm0, 0x10(%r13,%rax,8)
180002d6b:     	movq	$0x0, 0x18(%rbp,%rax,8)
180002d74:     	jmp	0x180002d01 <.text+0x1d01>
180002d76:     	movb	$0x1, (%r15)
180002d7a:     	movq	$0x9, 0x18(%r14)
180002d82:     	movq	0x120(%rsp), %rax
180002d8a:     	movq	$0x0, (%rax)
180002d91:     	jmp	0x1800025e9 <.text+0x15e9>
180002d96:     	movsd	0x2f0(%rsp), %xmm0
180002d9f:     	xorl	%eax, %eax
180002da1:     	jmp	0x180002dbf <.text+0x1dbf>
180002da3:     	movb	$0x1, (%r15)
180002da7:     	movq	0x110(%rsp), %rcx
180002daf:     	movq	$0x5b8d83, (%rcx)       # imm = 0x5B8D83
180002db6:     	incq	%rax
180002db9:     	cmpb	$0x0, (%r15)
180002dbd:     	jne	0x180002d82 <.text+0x1d82>
180002dbf:     	movq	0x130(%rsp), %rcx
180002dc7:     	movq	0x128(%rsp), %rdx
180002dcf:     	cmpq	(%rdx,%rcx,8), %rax
180002dd3:     	jge	0x180002d82 <.text+0x1d82>
180002dd5:     	movq	0x138(%rsp), %rcx
180002ddd:     	movq	0x128(%rsp), %rdx
180002de5:     	movq	0x10(%rdx,%rcx,8), %rcx
180002dea:     	addq	%rax, %rcx
180002ded:     	leaq	(%rbp,%rcx,8), %rdx
180002df2:     	sarq	$0x3f, %rcx
180002df6:     	andq	%r12, %rcx
180002df9:     	movq	(%rdx,%rcx,8), %rcx
180002dfd:     	testq	%rcx, %rcx
180002e00:     	js	0x180002fc3 <.text+0x1fc3>
180002e06:     	movq	0x18(%rbp,%rcx,8), %rdx
180002e0b:     	testq	%rdx, %rdx
180002e0e:     	js	0x180002da3 <.text+0x1da3>
180002e10:     	movq	(%rbp,%rcx,8), %r8
180002e15:     	testq	%r8, %r8
180002e18:     	js	0x180002da3 <.text+0x1da3>
180002e1a:     	movsd	(%r13,%r8,8), %xmm1
180002e21:     	mulsd	%xmm0, %xmm1
180002e25:     	addsd	(%r13,%rdx,8), %xmm1
180002e2c:     	movsd	%xmm1, (%r13,%rdx,8)
180002e33:     	movq	$0x0, 0x8(%rbp,%rdx,8)
180002e3c:     	movq	0x18(%rbp,%rcx,8), %rdx
180002e41:     	testq	%rdx, %rdx
180002e44:     	js	0x180002f33 <.text+0x1f33>
180002e4a:     	movq	(%rbp,%rcx,8), %r8
180002e4f:     	testq	%r8, %r8
180002e52:     	js	0x180002f33 <.text+0x1f33>
180002e58:     	movsd	0x10(%r13,%r8,8), %xmm1
180002e5f:     	mulsd	%xmm0, %xmm1
180002e63:     	addsd	0x10(%r13,%rdx,8), %xmm1
180002e6a:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
180002e71:     	movq	$0x0, 0x18(%rbp,%rdx,8)
180002e7a:     	movq	0x10(%rbp,%rcx,8), %rdx
180002e7f:     	testq	%rdx, %rdx
180002e82:     	js	0x180002f4b <.text+0x1f4b>
180002e88:     	movq	0x18(%rbp,%rcx,8), %r8
180002e8d:     	testq	%r8, %r8
180002e90:     	js	0x180002f4b <.text+0x1f4b>
180002e96:     	movsd	(%r13,%r8,8), %xmm1
180002e9d:     	mulsd	%xmm0, %xmm1
180002ea1:     	addsd	(%r13,%rdx,8), %xmm1
180002ea8:     	movsd	%xmm1, (%r13,%rdx,8)
180002eaf:     	movq	$0x0, 0x8(%rbp,%rdx,8)
180002eb8:     	movq	0x10(%rbp,%rcx,8), %rdx
180002ebd:     	testq	%rdx, %rdx
180002ec0:     	js	0x180002f63 <.text+0x1f63>
180002ec6:     	movq	0x18(%rbp,%rcx,8), %r8
180002ecb:     	testq	%r8, %r8
180002ece:     	js	0x180002f63 <.text+0x1f63>
180002ed4:     	movsd	0x10(%r13,%r8,8), %xmm1
180002edb:     	mulsd	%xmm0, %xmm1
180002edf:     	addsd	0x10(%r13,%rdx,8), %xmm1
180002ee6:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
180002eed:     	movq	$0x0, 0x18(%rbp,%rdx,8)
180002ef6:     	movq	(%rbp,%rcx,8), %rdx
180002efb:     	testq	%rdx, %rdx
180002efe:     	js	0x180002f7b <.text+0x1f7b>
180002f00:     	movq	$0x0, (%r13,%rdx,8)
180002f09:     	movq	$0x1, 0x8(%rbp,%rdx,8)
180002f12:     	movq	(%rbp,%rcx,8), %rcx
180002f17:     	testq	%rcx, %rcx
180002f1a:     	js	0x180002f93 <.text+0x1f93>
180002f1c:     	movq	$0x0, 0x10(%r13,%rcx,8)
180002f25:     	movq	$0x1, 0x18(%rbp,%rcx,8)
180002f2e:     	jmp	0x180002db6 <.text+0x1db6>
180002f33:     	movb	$0x1, (%r15)
180002f37:     	movq	0x110(%rsp), %rcx
180002f3f:     	movq	$0x5b8d84, (%rcx)       # imm = 0x5B8D84
180002f46:     	jmp	0x180002db6 <.text+0x1db6>
180002f4b:     	movb	$0x1, (%r15)
180002f4f:     	movq	0x110(%rsp), %rcx
180002f57:     	movq	$0x5b8d87, (%rcx)       # imm = 0x5B8D87
180002f5e:     	jmp	0x180002db6 <.text+0x1db6>
180002f63:     	movb	$0x1, (%r15)
180002f67:     	movq	0x110(%rsp), %rcx
180002f6f:     	movq	$0x5b8d88, (%rcx)       # imm = 0x5B8D88
180002f76:     	jmp	0x180002db6 <.text+0x1db6>
180002f7b:     	movb	$0x1, (%r15)
180002f7f:     	movq	0x110(%rsp), %rcx
180002f87:     	movq	$0x5b8d8b, (%rcx)       # imm = 0x5B8D8B
180002f8e:     	jmp	0x180002db6 <.text+0x1db6>
180002f93:     	movb	$0x1, (%r15)
180002f97:     	movq	0x110(%rsp), %rcx
180002f9f:     	movq	$0x5b8d8c, (%rcx)       # imm = 0x5B8D8C
180002fa6:     	jmp	0x180002db6 <.text+0x1db6>
180002fab:     	movq	0x158(%rsp), %rdx
180002fb3:     	movq	0x140(%rsp), %rcx
180002fbb:     	movq	%rdx, (%rcx)
180002fbe:     	jmp	0x1800025eb <.text+0x15eb>
180002fc3:     	movb	$0x1, (%r15)
180002fc7:     	movq	0x110(%rsp), %rax
180002fcf:     	movq	$0x12, (%rax)
180002fd6:     	jmp	0x180002d82 <.text+0x1d82>
180002fdb:     	movb	$0x1, (%r15)
180002fdf:     	movq	0x110(%rsp), %rax
180002fe7:     	movq	$0xd, (%rax)
180002fee:     	jmp	0x180002d82 <.text+0x1d82>
180002ff3:     	movb	$0x1, (%r15)
180002ff7:     	movq	0x110(%rsp), %rax
180002fff:     	movq	$0xe, (%rax)
180003006:     	jmp	0x180002d82 <.text+0x1d82>
18000300b:     	movq	0x140(%rsp), %rcx
180003013:     	movq	$0x0, (%rcx)
18000301a:     	jmp	0x1800025eb <.text+0x15eb>
18000301f:     	nop
180003020:     	pushq	%r15
180003022:     	pushq	%r14
180003024:     	pushq	%r13
180003026:     	pushq	%r12
180003028:     	pushq	%rsi
180003029:     	pushq	%rdi
18000302a:     	pushq	%rbp
18000302b:     	pushq	%rbx
18000302c:     	subq	$0x338, %rsp            # imm = 0x338
180003033:     	movaps	%xmm7, 0x320(%rsp)
18000303b:     	movaps	%xmm6, 0x310(%rsp)
180003043:     	movq	%rdx, %rcx
180003046:     	leaq	0x1c8(%rsp), %rax
18000304e:     	movq	%rax, 0x60(%rsp)
180003053:     	leaq	0x1d0(%rsp), %rax
18000305b:     	movq	%rax, 0x58(%rsp)
180003060:     	leaq	0x1d8(%rsp), %rax
180003068:     	movq	%rax, 0x50(%rsp)
18000306d:     	leaq	0x1e0(%rsp), %rax
180003075:     	movq	%rax, 0x48(%rsp)
18000307a:     	leaq	0x1e8(%rsp), %rax
180003082:     	movq	%rax, 0x40(%rsp)
180003087:     	leaq	0x1f0(%rsp), %rax
18000308f:     	movq	%rax, 0x38(%rsp)
180003094:     	leaq	0x1f8(%rsp), %rax
18000309c:     	movq	%rax, 0x30(%rsp)
1800030a1:     	leaq	0x200(%rsp), %rax
1800030a9:     	movq	%rax, 0x28(%rsp)
1800030ae:     	leaq	0x208(%rsp), %rax
1800030b6:     	movq	%rax, 0x20(%rsp)
1800030bb:     	leaq	0xa66e(%rip), %rdx      # 0x18000d730
1800030c2:     	movl	$0x9, %r8d
1800030c8:     	movl	$0x9, %r9d
1800030ce:     	callq	0x18000b571 <numba_list_iter_next+0x311>
1800030d3:     	testl	%eax, %eax
1800030d5:     	movq	$0x0, 0x130(%rsp)
1800030e1:     	je	0x1800037dc <.text+0x27dc>
1800030e7:     	cmpq	$0x0, 0x11bd9(%rip)     # 0x180014cc8
1800030ef:     	je	0x180003704 <.text+0x2704>
1800030f5:     	movq	0x208(%rsp), %rcx
1800030fd:     	xorps	%xmm0, %xmm0
180003100:     	movaps	%xmm0, 0x2d0(%rsp)
180003108:     	movaps	%xmm0, 0x2e0(%rsp)
180003110:     	movaps	%xmm0, 0x2f0(%rsp)
180003118:     	movq	$0x0, 0x300(%rsp)
180003124:     	leaq	0x2d0(%rsp), %rdx
18000312c:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180003131:     	testl	%eax, %eax
180003133:     	jne	0x18000371c <.text+0x271c>
180003139:     	cmpq	$0x8, 0x2e8(%rsp)
180003142:     	jne	0x18000371c <.text+0x271c>
180003148:     	movq	0x2d0(%rsp), %rbx
180003150:     	movq	0x2d8(%rsp), %rbp
180003158:     	movq	0x2e0(%rsp), %rsi
180003160:     	movq	0x2f0(%rsp), %rdi
180003168:     	movq	0x2f8(%rsp), %r15
180003170:     	movq	0x300(%rsp), %r13
180003178:     	movq	0x200(%rsp), %rcx
180003180:     	xorps	%xmm0, %xmm0
180003183:     	movaps	%xmm0, 0x290(%rsp)
18000318b:     	movaps	%xmm0, 0x2a0(%rsp)
180003193:     	movaps	%xmm0, 0x2b0(%rsp)
18000319b:     	movq	$0x0, 0x2c0(%rsp)
1800031a7:     	leaq	0x290(%rsp), %rdx
1800031af:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
1800031b4:     	testl	%eax, %eax
1800031b6:     	jne	0x180003734 <.text+0x2734>
1800031bc:     	cmpq	$0x8, 0x2a8(%rsp)
1800031c5:     	jne	0x180003734 <.text+0x2734>
1800031cb:     	movq	0x290(%rsp), %r12
1800031d3:     	movq	0x298(%rsp), %r14
1800031db:     	movq	0x2a0(%rsp), %rax
1800031e3:     	movq	%rax, 0x1c0(%rsp)
1800031eb:     	movq	0x2b0(%rsp), %rax
1800031f3:     	movq	%rax, 0x1b8(%rsp)
1800031fb:     	movq	0x2b8(%rsp), %rax
180003203:     	movq	%rax, 0x1b0(%rsp)
18000320b:     	movq	0x2c0(%rsp), %rax
180003213:     	movq	%rax, 0x1a8(%rsp)
18000321b:     	movq	0x1f8(%rsp), %rcx
180003223:     	xorps	%xmm0, %xmm0
180003226:     	movaps	%xmm0, 0x250(%rsp)
18000322e:     	movaps	%xmm0, 0x260(%rsp)
180003236:     	movaps	%xmm0, 0x270(%rsp)
18000323e:     	movq	$0x0, 0x280(%rsp)
18000324a:     	leaq	0x250(%rsp), %rdx
180003252:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
180003257:     	testl	%eax, %eax
180003259:     	jne	0x18000374c <.text+0x274c>
18000325f:     	cmpq	$0x8, 0x268(%rsp)
180003268:     	jne	0x18000374c <.text+0x274c>
18000326e:     	movq	%r14, 0x1a0(%rsp)
180003276:     	movq	0x250(%rsp), %r14
18000327e:     	movq	0x258(%rsp), %rax
180003286:     	movq	%rax, 0x198(%rsp)
18000328e:     	movq	0x260(%rsp), %rax
180003296:     	movq	%rax, 0x190(%rsp)
18000329e:     	movq	0x270(%rsp), %rax
1800032a6:     	movq	%rax, 0x188(%rsp)
1800032ae:     	movq	0x278(%rsp), %rax
1800032b6:     	movq	%rax, 0x180(%rsp)
1800032be:     	movq	0x280(%rsp), %rax
1800032c6:     	movq	%rax, 0x178(%rsp)
1800032ce:     	movq	0x1f0(%rsp), %rcx
1800032d6:     	xorps	%xmm0, %xmm0
1800032d9:     	movaps	%xmm0, 0x210(%rsp)
1800032e1:     	movaps	%xmm0, 0x220(%rsp)
1800032e9:     	movaps	%xmm0, 0x230(%rsp)
1800032f1:     	movq	$0x0, 0x240(%rsp)
1800032fd:     	leaq	0x210(%rsp), %rdx
180003305:     	callq	0x18000a230 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66a0>
18000330a:     	testl	%eax, %eax
18000330c:     	jne	0x180003761 <.text+0x2761>
180003312:     	cmpq	$0x1, 0x228(%rsp)
18000331b:     	jne	0x180003761 <.text+0x2761>
180003321:     	movq	%r13, 0x150(%rsp)
180003329:     	movq	%r15, 0x158(%rsp)
180003331:     	movq	%rdi, 0x160(%rsp)
180003339:     	movq	%rsi, 0x168(%rsp)
180003341:     	movq	0x210(%rsp), %r15
180003349:     	movq	0x218(%rsp), %rax
180003351:     	movq	%rax, 0x148(%rsp)
180003359:     	movq	0x220(%rsp), %rax
180003361:     	movq	%rax, 0x140(%rsp)
180003369:     	movq	0x230(%rsp), %rax
180003371:     	movq	%rax, 0x138(%rsp)
180003379:     	movq	0x238(%rsp), %rdi
180003381:     	movq	0x240(%rsp), %rsi
180003389:     	movq	0x1e8(%rsp), %rcx
180003391:     	callq	0x18000b577 <numba_list_iter_next+0x317>
180003396:     	testq	%rax, %rax
180003399:     	movq	%rbx, 0x128(%rsp)
1800033a1:     	movq	%r12, 0x120(%rsp)
1800033a9:     	movq	%rbp, 0x170(%rsp)
1800033b1:     	je	0x180003776 <.text+0x2776>
1800033b7:     	movq	%rax, %r13
1800033ba:     	movq	%rax, %rcx
1800033bd:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
1800033c2:     	movq	%rax, %r12
1800033c5:     	movq	%r13, %rcx
1800033c8:     	callq	0x18000b583 <numba_list_iter_next+0x323>
1800033cd:     	callq	0x18000b589 <numba_list_iter_next+0x329>
1800033d2:     	testq	%rax, %rax
1800033d5:     	jne	0x1800037ac <.text+0x27ac>
1800033db:     	movq	0x1e0(%rsp), %rcx
1800033e3:     	callq	0x18000b58f <numba_list_iter_next+0x32f>
1800033e8:     	movq	%rax, %rbx
1800033eb:     	movq	%rax, %rcx
1800033ee:     	callq	0x18000b595 <numba_list_iter_next+0x335>
1800033f3:     	movaps	%xmm0, %xmm6
1800033f6:     	movq	%rbx, %rcx
1800033f9:     	callq	0x18000b583 <numba_list_iter_next+0x323>
1800033fe:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180003403:     	testq	%rax, %rax
180003406:     	jne	0x1800037ac <.text+0x27ac>
18000340c:     	movq	0x1d8(%rsp), %rcx
180003414:     	callq	0x18000b58f <numba_list_iter_next+0x32f>
180003419:     	movq	%rax, %rbx
18000341c:     	movq	%rax, %rcx
18000341f:     	callq	0x18000b595 <numba_list_iter_next+0x335>
180003424:     	movaps	%xmm0, %xmm7
180003427:     	movq	%rbx, %rcx
18000342a:     	callq	0x18000b583 <numba_list_iter_next+0x323>
18000342f:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180003434:     	testq	%rax, %rax
180003437:     	jne	0x1800037ac <.text+0x27ac>
18000343d:     	movq	0x1d0(%rsp), %rcx
180003445:     	callq	0x18000b577 <numba_list_iter_next+0x317>
18000344a:     	testq	%rax, %rax
18000344d:     	je	0x180003789 <.text+0x2789>
180003453:     	movq	%rax, %rbp
180003456:     	movq	%rax, %rcx
180003459:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
18000345e:     	movq	%rax, %r13
180003461:     	movq	%rbp, %rcx
180003464:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180003469:     	callq	0x18000b589 <numba_list_iter_next+0x329>
18000346e:     	testq	%rax, %rax
180003471:     	jne	0x1800037ac <.text+0x27ac>
180003477:     	movq	0x1c8(%rsp), %rcx
18000347f:     	callq	0x18000b577 <numba_list_iter_next+0x317>
180003484:     	testq	%rax, %rax
180003487:     	je	0x18000379c <.text+0x279c>
18000348d:     	movq	%rax, %rbx
180003490:     	movq	%rax, %rcx
180003493:     	callq	0x18000b57d <numba_list_iter_next+0x31d>
180003498:     	movq	%rax, %rbp
18000349b:     	movq	%rbx, %rcx
18000349e:     	callq	0x18000b583 <numba_list_iter_next+0x323>
1800034a3:     	callq	0x18000b589 <numba_list_iter_next+0x329>
1800034a8:     	testq	%rax, %rax
1800034ab:     	jne	0x1800037ac <.text+0x27ac>
1800034b1:     	movq	%rbp, 0x110(%rsp)
1800034b9:     	movq	%r13, 0x108(%rsp)
1800034c1:     	movq	%r12, 0xf0(%rsp)
1800034c9:     	movq	%rsi, 0xe8(%rsp)
1800034d1:     	movq	%rdi, 0xe0(%rsp)
1800034d9:     	movq	0x138(%rsp), %rax
1800034e1:     	movq	%rax, 0xd8(%rsp)
1800034e9:     	movq	0x140(%rsp), %rax
1800034f1:     	movq	%rax, 0xc8(%rsp)
1800034f9:     	movq	0x148(%rsp), %rax
180003501:     	movq	%rax, 0xc0(%rsp)
180003509:     	movq	0x178(%rsp), %rax
180003511:     	movq	%rax, 0xb0(%rsp)
180003519:     	movq	0x180(%rsp), %rax
180003521:     	movq	%rax, 0xa8(%rsp)
180003529:     	movq	0x188(%rsp), %rax
180003531:     	movq	%rax, 0xa0(%rsp)
180003539:     	movq	0x190(%rsp), %rax
180003541:     	movq	%rax, 0x90(%rsp)
180003549:     	movq	0x198(%rsp), %rax
180003551:     	movq	%rax, 0x88(%rsp)
180003559:     	movq	0x1a8(%rsp), %rax
180003561:     	movq	%rax, 0x78(%rsp)
180003566:     	movq	0x1b0(%rsp), %rax
18000356e:     	movq	%rax, 0x70(%rsp)
180003573:     	movq	0x1b8(%rsp), %rax
18000357b:     	movq	%rax, 0x68(%rsp)
180003580:     	movq	0x1c0(%rsp), %rax
180003588:     	movq	%rax, 0x58(%rsp)
18000358d:     	movq	0x1a0(%rsp), %rax
180003595:     	movq	%rax, 0x50(%rsp)
18000359a:     	movq	0x150(%rsp), %rax
1800035a2:     	movq	%rax, 0x40(%rsp)
1800035a7:     	movq	0x158(%rsp), %rax
1800035af:     	movq	%rax, 0x38(%rsp)
1800035b4:     	movsd	%xmm7, 0x100(%rsp)
1800035bd:     	movsd	%xmm6, 0xf8(%rsp)
1800035c6:     	movq	%r15, 0xb8(%rsp)
1800035ce:     	movq	%r14, 0x80(%rsp)
1800035d6:     	movq	0x120(%rsp), %rdi
1800035de:     	movq	%rdi, 0x48(%rsp)
1800035e3:     	movq	0x160(%rsp), %rax
1800035eb:     	movq	%rax, 0x30(%rsp)
1800035f0:     	movq	0x168(%rsp), %rax
1800035f8:     	movq	%rax, 0x20(%rsp)
1800035fd:     	movq	$0x1, 0xd0(%rsp)
180003609:     	movq	$0x8, 0x98(%rsp)
180003615:     	movq	$0x8, 0x60(%rsp)
18000361e:     	movq	$0x8, 0x28(%rsp)
180003627:     	leaq	0x308(%rsp), %rcx
18000362f:     	leaq	0x130(%rsp), %rdx
180003637:     	movq	0x170(%rsp), %r9
18000363f:     	movq	0x128(%rsp), %rsi
180003647:     	movq	%rsi, %r8
18000364a:     	callq	0x180002540 <.text+0x1540>
18000364f:     	movl	%eax, %ebp
180003651:     	movq	0x130(%rsp), %rbx
180003659:     	movq	%rsi, %rcx
18000365c:     	callq	0x180001060 <.text+0x60>
180003661:     	movq	%rdi, %rcx
180003664:     	callq	0x180001060 <.text+0x60>
180003669:     	movq	%r14, %rcx
18000366c:     	callq	0x180001060 <.text+0x60>
180003671:     	movq	%r15, %rcx
180003674:     	callq	0x180001060 <.text+0x60>
180003679:     	testl	%ebp, %ebp
18000367b:     	jne	0x1800036b3 <.text+0x26b3>
18000367d:     	movq	0x9c4c(%rip), %rsi      # 0x18000d2d0
180003684:     	movq	%rsi, %rcx
180003687:     	callq	0x18000b59b <numba_list_iter_next+0x33b>
18000368c:     	movq	%rsi, %rax
18000368f:     	movaps	0x310(%rsp), %xmm6
180003697:     	movaps	0x320(%rsp), %xmm7
18000369f:     	addq	$0x338, %rsp            # imm = 0x338
1800036a6:     	popq	%rbx
1800036a7:     	popq	%rbp
1800036a8:     	popq	%rdi
1800036a9:     	popq	%rsi
1800036aa:     	popq	%r12
1800036ac:     	popq	%r13
1800036ae:     	popq	%r14
1800036b0:     	popq	%r15
1800036b2:     	retq
1800036b3:     	jle	0x1800037e3 <.text+0x27e3>
1800036b9:     	callq	0x18000b5a1 <numba_list_iter_next+0x341>
1800036be:     	movl	0x8(%rbx), %edx
1800036c1:     	movq	(%rbx), %rcx
1800036c4:     	cmpl	$0x0, 0x20(%rbx)
1800036c8:     	jle	0x180003802 <.text+0x2802>
1800036ce:     	movslq	%edx, %rdx
1800036d1:     	callq	0x18000b5a7 <numba_list_iter_next+0x347>
1800036d6:     	movq	%rax, %rsi
1800036d9:     	movq	0x10(%rbx), %rcx
1800036dd:     	callq	*0x18(%rbx)
1800036e0:     	testq	%rax, %rax
1800036e3:     	je	0x18000382b <.text+0x282b>
1800036e9:     	movq	%rsi, %rcx
1800036ec:     	movq	%rax, %rdx
1800036ef:     	callq	0x180009a40 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5eb0>
1800036f4:     	movq	%rax, %rsi
1800036f7:     	movq	%rbx, %rcx
1800036fa:     	callq	0x18000b4d0 <numba_list_iter_next+0x270>
1800036ff:     	jmp	0x18000380e <.text+0x280e>
180003704:     	movq	0x9ba5(%rip), %rcx      # 0x18000d2b0
18000370b:     	leaq	0xa03e(%rip), %rdx      # 0x18000d750
180003712:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003717:     	jmp	0x1800037dc <.text+0x27dc>
18000371c:     	movq	0x9b7d(%rip), %rcx      # 0x18000d2a0
180003723:     	leaq	0xa126(%rip), %rdx      # 0x18000d850
18000372a:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
18000372f:     	jmp	0x1800037dc <.text+0x27dc>
180003734:     	movq	0x9b65(%rip), %rcx      # 0x18000d2a0
18000373b:     	leaq	0xa10e(%rip), %rdx      # 0x18000d850
180003742:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003747:     	jmp	0x1800037d4 <.text+0x27d4>
18000374c:     	movq	0x9b4d(%rip), %rcx      # 0x18000d2a0
180003753:     	leaq	0xa0f6(%rip), %rdx      # 0x18000d850
18000375a:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
18000375f:     	jmp	0x1800037cc <.text+0x27cc>
180003761:     	movq	0x9b38(%rip), %rcx      # 0x18000d2a0
180003768:     	leaq	0xa0e1(%rip), %rdx      # 0x18000d850
18000376f:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003774:     	jmp	0x1800037c4 <.text+0x27c4>
180003776:     	xorl	%r12d, %r12d
180003779:     	callq	0x18000b589 <numba_list_iter_next+0x329>
18000377e:     	testq	%rax, %rax
180003781:     	je	0x1800033db <.text+0x23db>
180003787:     	jmp	0x1800037ac <.text+0x27ac>
180003789:     	xorl	%r13d, %r13d
18000378c:     	callq	0x18000b589 <numba_list_iter_next+0x329>
180003791:     	testq	%rax, %rax
180003794:     	je	0x180003477 <.text+0x2477>
18000379a:     	jmp	0x1800037ac <.text+0x27ac>
18000379c:     	xorl	%ebp, %ebp
18000379e:     	callq	0x18000b589 <numba_list_iter_next+0x329>
1800037a3:     	testq	%rax, %rax
1800037a6:     	je	0x1800034b1 <.text+0x24b1>
1800037ac:     	movq	%r15, %rcx
1800037af:     	callq	0x180001060 <.text+0x60>
1800037b4:     	movq	0x128(%rsp), %rbx
1800037bc:     	movq	0x120(%rsp), %r12
1800037c4:     	movq	%r14, %rcx
1800037c7:     	callq	0x180001060 <.text+0x60>
1800037cc:     	movq	%r12, %rcx
1800037cf:     	callq	0x180001060 <.text+0x60>
1800037d4:     	movq	%rbx, %rcx
1800037d7:     	callq	0x180001060 <.text+0x60>
1800037dc:     	xorl	%esi, %esi
1800037de:     	jmp	0x18000368c <.text+0x268c>
1800037e3:     	cmpl	$-0x3, %ebp
1800037e6:     	je	0x18000381d <.text+0x281d>
1800037e8:     	cmpl	$-0x1, %ebp
1800037eb:     	je	0x1800037dc <.text+0x27dc>
1800037ed:     	movq	0x9aa4(%rip), %rcx      # 0x18000d298
1800037f4:     	leaq	0xa0f5(%rip), %rdx      # 0x18000d8f0
1800037fb:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003800:     	jmp	0x1800037dc <.text+0x27dc>
180003802:     	movq	0x10(%rbx), %r8
180003806:     	callq	0x180009960 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dd0>
18000380b:     	movq	%rax, %rsi
18000380e:     	testq	%rsi, %rsi
180003811:     	je	0x1800037dc <.text+0x27dc>
180003813:     	movq	%rsi, %rcx
180003816:     	callq	0x180009500 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5970>
18000381b:     	jmp	0x1800037dc <.text+0x27dc>
18000381d:     	movq	0x9a6c(%rip), %rcx      # 0x18000d290
180003824:     	callq	0x18000b5b3 <numba_list_iter_next+0x353>
180003829:     	jmp	0x1800037dc <.text+0x27dc>
18000382b:     	movq	0x9a7e(%rip), %rcx      # 0x18000d2b0
180003832:     	leaq	0xa077(%rip), %rdx      # 0x18000d8b0
180003839:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
18000383e:     	jmp	0x1800037dc <.text+0x27dc>
180003840:     	pushq	%r15
180003842:     	pushq	%r14
180003844:     	pushq	%r13
180003846:     	pushq	%r12
180003848:     	pushq	%rsi
180003849:     	pushq	%rdi
18000384a:     	pushq	%rbp
18000384b:     	pushq	%rbx
18000384c:     	subq	$0x148, %rsp            # imm = 0x148
180003853:     	movq	%r9, %r12
180003856:     	movq	%r8, %r13
180003859:     	movq	%rdx, 0x140(%rsp)
180003861:     	movq	%rcx, 0x138(%rsp)
180003869:     	movsd	0x278(%rsp), %xmm0
180003872:     	movsd	0x280(%rsp), %xmm1
18000387b:     	movq	$0x0, 0x130(%rsp)
180003887:     	movq	$0x0, 0x128(%rsp)
180003893:     	movq	0x220(%rsp), %rbp
18000389b:     	movq	0x228(%rsp), %r15
1800038a3:     	movq	0x230(%rsp), %r14
1800038ab:     	movq	0x238(%rsp), %rbx
1800038b3:     	movq	0x240(%rsp), %rdi
1800038bb:     	movq	0x248(%rsp), %rsi
1800038c3:     	movq	0x250(%rsp), %r11
1800038cb:     	movq	0x258(%rsp), %r10
1800038d3:     	movq	0x260(%rsp), %r9
1800038db:     	movq	0x268(%rsp), %r8
1800038e3:     	movq	0x270(%rsp), %rdx
1800038eb:     	movq	0x288(%rsp), %rcx
1800038f3:     	movq	0x290(%rsp), %rax
1800038fb:     	movq	%rax, 0x110(%rsp)
180003903:     	movq	%rcx, 0x108(%rsp)
18000390b:     	movq	%rdx, 0xf0(%rsp)
180003913:     	movq	%r8, 0xe8(%rsp)
18000391b:     	movq	%r9, 0xe0(%rsp)
180003923:     	movq	%r10, 0xd8(%rsp)
18000392b:     	movq	%r11, 0xd0(%rsp)
180003933:     	movq	%rsi, 0xc8(%rsp)
18000393b:     	movq	%rdi, 0xc0(%rsp)
180003943:     	movq	%rbx, 0xb8(%rsp)
18000394b:     	movq	%r14, 0xb0(%rsp)
180003953:     	movq	%r15, 0xa8(%rsp)
18000395b:     	movq	%rbp, 0xa0(%rsp)
180003963:     	movq	0x218(%rsp), %rax
18000396b:     	movq	%rax, 0x98(%rsp)
180003973:     	movq	0x210(%rsp), %rax
18000397b:     	movq	%rax, 0x90(%rsp)
180003983:     	movq	0x208(%rsp), %rax
18000398b:     	movq	%rax, 0x88(%rsp)
180003993:     	movq	0x200(%rsp), %rax
18000399b:     	movq	%rax, 0x80(%rsp)
1800039a3:     	movq	0x1f8(%rsp), %rax
1800039ab:     	movq	%rax, 0x78(%rsp)
1800039b0:     	movq	0x1f0(%rsp), %rax
1800039b8:     	movq	%rax, 0x70(%rsp)
1800039bd:     	movq	0x1e8(%rsp), %rax
1800039c5:     	movq	%rax, 0x68(%rsp)
1800039ca:     	movq	0x1e0(%rsp), %rax
1800039d2:     	movq	%rax, 0x60(%rsp)
1800039d7:     	movq	0x1d8(%rsp), %rax
1800039df:     	movq	%rax, 0x58(%rsp)
1800039e4:     	movq	0x1d0(%rsp), %rax
1800039ec:     	movq	%rax, 0x50(%rsp)
1800039f1:     	movq	0x1c8(%rsp), %rax
1800039f9:     	movq	%rax, 0x48(%rsp)
1800039fe:     	movq	0x1c0(%rsp), %rax
180003a06:     	movq	%rax, 0x40(%rsp)
180003a0b:     	movq	0x1b8(%rsp), %rax
180003a13:     	movq	%rax, 0x38(%rsp)
180003a18:     	movq	0x1b0(%rsp), %rax
180003a20:     	movq	%rax, 0x30(%rsp)
180003a25:     	movsd	%xmm1, 0x100(%rsp)
180003a2e:     	movsd	%xmm0, 0xf8(%rsp)
180003a37:     	movq	%r12, 0x28(%rsp)
180003a3c:     	movq	%r13, 0x20(%rsp)
180003a41:     	leaq	0x130(%rsp), %rcx
180003a49:     	leaq	0x128(%rsp), %rdx
180003a51:     	movq	0x138(%rsp), %r8
180003a59:     	movq	0x140(%rsp), %r9
180003a61:     	callq	0x180002540 <.text+0x1540>
180003a66:     	movl	%eax, %edx
180003a68:     	movq	0x128(%rsp), %rsi
180003a70:     	movq	0x130(%rsp), %rax
180003a78:     	movl	$0x0, 0x124(%rsp)
180003a83:     	testl	%edx, %edx
180003a85:     	jne	0x180003a9b <.text+0x2a9b>
180003a87:     	addq	$0x148, %rsp            # imm = 0x148
180003a8e:     	popq	%rbx
180003a8f:     	popq	%rbp
180003a90:     	popq	%rdi
180003a91:     	popq	%rsi
180003a92:     	popq	%r12
180003a94:     	popq	%r13
180003a96:     	popq	%r14
180003a98:     	popq	%r15
180003a9a:     	retq
180003a9b:     	movq	%rax, %rbx
180003a9e:     	leaq	0x124(%rsp), %rcx
180003aa6:     	movl	%edx, %edi
180003aa8:     	callq	0x1800094d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5940>
180003aad:     	testl	%edi, %edi
180003aaf:     	jle	0x180003af5 <.text+0x2af5>
180003ab1:     	callq	0x18000b5a1 <numba_list_iter_next+0x341>
180003ab6:     	movl	0x8(%rsi), %edx
180003ab9:     	movq	(%rsi), %rcx
180003abc:     	cmpl	$0x0, 0x20(%rsi)
180003ac0:     	jle	0x180003b16 <.text+0x2b16>
180003ac2:     	movslq	%edx, %rdx
180003ac5:     	callq	0x18000b5a7 <numba_list_iter_next+0x347>
180003aca:     	movq	%rax, %rdi
180003acd:     	movq	0x10(%rsi), %rcx
180003ad1:     	callq	*0x18(%rsi)
180003ad4:     	testq	%rax, %rax
180003ad7:     	je	0x180003b71 <.text+0x2b71>
180003add:     	movq	%rdi, %rcx
180003ae0:     	movq	%rax, %rdx
180003ae3:     	callq	0x180009a40 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5eb0>
180003ae8:     	movq	%rax, %rdi
180003aeb:     	movq	%rsi, %rcx
180003aee:     	callq	0x18000b4d0 <numba_list_iter_next+0x270>
180003af3:     	jmp	0x180003b22 <.text+0x2b22>
180003af5:     	movl	%edi, %eax
180003af7:     	cmpl	$-0x3, %edi
180003afa:     	je	0x180003b63 <.text+0x2b63>
180003afc:     	cmpl	$-0x1, %eax
180003aff:     	je	0x180003b2f <.text+0x2b2f>
180003b01:     	movq	0x9790(%rip), %rcx      # 0x18000d298
180003b08:     	leaq	0x9e51(%rip), %rdx      # 0x18000d960
180003b0f:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003b14:     	jmp	0x180003b2f <.text+0x2b2f>
180003b16:     	movq	0x10(%rsi), %r8
180003b1a:     	callq	0x180009960 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dd0>
180003b1f:     	movq	%rax, %rdi
180003b22:     	testq	%rdi, %rdi
180003b25:     	je	0x180003b2f <.text+0x2b2f>
180003b27:     	movq	%rdi, %rcx
180003b2a:     	callq	0x180009500 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5970>
180003b2f:     	leaq	0x9e5a(%rip), %rcx      # 0x18000d990
180003b36:     	callq	0x18000b5b9 <numba_list_iter_next+0x359>
180003b3b:     	movq	%rax, %rsi
180003b3e:     	movq	%rax, %rcx
180003b41:     	callq	0x18000b5bf <numba_list_iter_next+0x35f>
180003b46:     	movq	%rsi, %rcx
180003b49:     	callq	0x18000b583 <numba_list_iter_next+0x323>
180003b4e:     	leaq	0x124(%rsp), %rcx
180003b56:     	callq	0x1800094f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5960>
180003b5b:     	movq	%rbx, %rax
180003b5e:     	jmp	0x180003a87 <.text+0x2a87>
180003b63:     	movq	0x9726(%rip), %rcx      # 0x18000d290
180003b6a:     	callq	0x18000b5b3 <numba_list_iter_next+0x353>
180003b6f:     	jmp	0x180003b2f <.text+0x2b2f>
180003b71:     	movq	0x9738(%rip), %rcx      # 0x18000d2b0
180003b78:     	leaq	0x9da1(%rip), %rdx      # 0x18000d920
180003b7f:     	callq	0x18000b5ad <numba_list_iter_next+0x34d>
180003b84:     	xorl	%eax, %eax
180003b86:     	jmp	0x180003a87 <.text+0x2a87>
180003b8b:     	nopl	(%rax,%rax)

0000000180003b90 <PyInit_rcaotr_b8ad585ae5ddf1131de85239>:
180003b90:     	pushq	%rsi
180003b91:     	subq	$0x20, %rsp
180003b95:     	leaq	0x104c4(%rip), %rcx     # 0x180014060
180003b9c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180003ba1:     	callq	0x18000b5c5 <numba_list_iter_next+0x365>
180003ba6:     	testq	%rax, %rax
180003ba9:     	je	0x180003bdb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4b>
180003bab:     	leaq	0x1044e(%rip), %rdx     # 0x180014000
180003bb2:     	leaq	0x9e47(%rip), %r8       # 0x18000da00
180003bb9:     	leaq	0x9f30(%rip), %r9       # 0x18000daf0
180003bc0:     	movq	%rax, %rcx
180003bc3:     	movq	%rax, %rsi
180003bc6:     	callq	0x18000a4a0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6910>
180003bcb:     	movl	%eax, %ecx
180003bcd:     	xorl	%eax, %eax
180003bcf:     	testl	%ecx, %ecx
180003bd1:     	cmoveq	%rsi, %rax
180003bd5:     	addq	$0x20, %rsp
180003bd9:     	popq	%rsi
180003bda:     	retq
180003bdb:     	xorl	%eax, %eax
180003bdd:     	addq	$0x20, %rsp
180003be1:     	popq	%rsi
180003be2:     	retq
180003be3:     	nopw	%cs:(%rax,%rax)
180003bed:     	nopl	(%rax)
180003bf0:     	pushq	%r15
180003bf2:     	pushq	%r14
180003bf4:     	pushq	%r13
180003bf6:     	pushq	%r12
180003bf8:     	pushq	%rsi
180003bf9:     	pushq	%rdi
180003bfa:     	pushq	%rbp
180003bfb:     	pushq	%rbx
180003bfc:     	subq	$0x198, %rsp            # imm = 0x198
180003c03:     	movapd	%xmm8, 0x180(%rsp)
180003c0d:     	movapd	%xmm7, 0x170(%rsp)
180003c16:     	movapd	%xmm6, 0x160(%rsp)
180003c1f:     	movq	0x2d0(%rsp), %r13
180003c27:     	movq	0x210(%rsp), %rdi
180003c2f:     	movsd	0x48(%rdi,%r13,8), %xmm0
180003c36:     	xorpd	%xmm1, %xmm1
180003c3a:     	ucomisd	%xmm1, %xmm0
180003c3e:     	jne	0x180003c80 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xf0>
180003c40:     	jp	0x180003c80 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xf0>
180003c42:     	movq	$0x0, 0x8(%rcx)
180003c4a:     	movq	$0x0, (%rcx)
180003c51:     	xorl	%eax, %eax
180003c53:     	movaps	0x160(%rsp), %xmm6
180003c5b:     	movaps	0x170(%rsp), %xmm7
180003c63:     	movaps	0x180(%rsp), %xmm8
180003c6c:     	addq	$0x198, %rsp            # imm = 0x198
180003c73:     	popq	%rbx
180003c74:     	popq	%rbp
180003c75:     	popq	%rdi
180003c76:     	popq	%rsi
180003c77:     	popq	%r12
180003c79:     	popq	%r13
180003c7b:     	popq	%r14
180003c7d:     	popq	%r15
180003c7f:     	retq
180003c80:     	movq	0x2d8(%rsp), %r12
180003c88:     	movq	0x250(%rsp), %r15
180003c90:     	movq	0x248(%rsp), %r14
180003c98:     	movq	0x30(%r14,%r13,8), %rax
180003c9d:     	movq	%rax, %r10
180003ca0:     	sarq	$0x3f, %r10
180003ca4:     	andq	%r15, %r10
180003ca7:     	leaq	(%r14,%rax,8), %rdx
180003cab:     	cmpq	$0x1, (%rdx,%r10,8)
180003cb0:     	jne	0x180003cd7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x147>
180003cb2:     	xorl	%r10d, %r10d
180003cb5:     	cmpq	$-0x2, %rax
180003cb9:     	cmovlq	%r15, %r10
180003cbd:     	movq	0x10(%rdx,%r10,8), %rax
180003cc2:     	leaq	(%r14,%rax,8), %rdx
180003cc6:     	sarq	$0x3f, %rax
180003cca:     	andq	%r15, %rax
180003ccd:     	cmpq	%r12, (%rdx,%rax,8)
180003cd1:     	je	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003cd7:     	movq	0x2b8(%rsp), %rbx
180003cdf:     	movq	0x280(%rsp), %rsi
180003ce7:     	movq	0x10(%r14,%r13,8), %r10
180003cec:     	movsd	(%rdi,%r10,8), %xmm1
180003cf2:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003cf8:     	setne	%r11b
180003cfc:     	movq	0x10(%r14,%r12,8), %rdx
180003d01:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d07:     	setne	%al
180003d0a:     	subsd	(%rdi,%rdx,8), %xmm1
180003d0f:     	andb	%r11b, %al
180003d12:     	cmpb	$0x1, %al
180003d14:     	jne	0x180003d38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1a8>
180003d16:     	movapd	0x96a2(%rip), %xmm2     # 0x18000d3c0
180003d1e:     	andpd	%xmm1, %xmm2
180003d22:     	ucomisd	0x96a6(%rip), %xmm2     # 0x18000d3d0
180003d2a:     	jae	0x180003dde <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x24e>
180003d30:     	xorpd	%xmm2, %xmm2
180003d34:     	addsd	%xmm2, %xmm1
180003d38:     	movsd	0x10(%rdi,%r10,8), %xmm2
180003d3f:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d45:     	subsd	0x10(%rdi,%rdx,8), %xmm2
180003d4b:     	je	0x180003db5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x225>
180003d4d:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d53:     	je	0x180003db5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x225>
180003d55:     	movapd	0x9663(%rip), %xmm3     # 0x18000d3c0
180003d5d:     	andpd	%xmm2, %xmm3
180003d61:     	ucomisd	0x9667(%rip), %xmm3     # 0x18000d3d0
180003d69:     	jae	0x180003e25 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x295>
180003d6f:     	movapd	%xmm1, %xmm3
180003d73:     	mulsd	%xmm1, %xmm3
180003d77:     	ucomisd	0x9651(%rip), %xmm3     # 0x18000d3d0
180003d7f:     	setae	%dl
180003d82:     	testb	%dl, %al
180003d84:     	jne	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003d86:     	xorpd	%xmm4, %xmm4
180003d8a:     	addsd	%xmm4, %xmm2
180003d8e:     	movapd	%xmm2, %xmm4
180003d92:     	mulsd	%xmm2, %xmm4
180003d96:     	ucomisd	0x9632(%rip), %xmm4     # 0x18000d3d0
180003d9e:     	jae	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003da0:     	addsd	%xmm4, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	setae	%dl
180003daf:     	testb	%dl, %al
180003db1:     	jne	0x180003dce <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x23e>
180003db3:     	jmp	0x180003dfa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x26a>
180003db5:     	movapd	%xmm1, %xmm3
180003db9:     	mulsd	%xmm1, %xmm3
180003dbd:     	ucomisd	0x960b(%rip), %xmm3     # 0x18000d3d0
180003dc5:     	setae	%dl
180003dc8:     	andb	%dl, %al
180003dca:     	cmpb	$0x1, %al
180003dcc:     	jne	0x180003dee <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x25e>
180003dce:     	movb	$0x1, (%rbx)
180003dd1:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003dd9:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003dde:     	movb	$0x1, (%rbx)
180003de1:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003de9:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003dee:     	movapd	%xmm2, %xmm4
180003df2:     	mulsd	%xmm2, %xmm4
180003df6:     	addsd	%xmm4, %xmm3
180003dfa:     	xorps	%xmm4, %xmm4
180003dfd:     	sqrtsd	%xmm3, %xmm4
180003e01:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e07:     	je	0x180003e56 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2c6>
180003e09:     	xorpd	%xmm5, %xmm5
180003e0d:     	ucomisd	%xmm5, %xmm3
180003e11:     	jne	0x180003e35 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2a5>
180003e13:     	jp	0x180003e35 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2a5>
180003e15:     	movb	$0x1, (%rbx)
180003e18:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e20:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e25:     	movb	$0x1, (%rbx)
180003e28:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e30:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e35:     	movsd	0x2e0(%rsp), %xmm6
180003e3e:     	movq	(%r14,%r13,8), %rax
180003e42:     	movsd	0x8(%rdi,%rax,8), %xmm3
180003e48:     	addsd	%xmm3, %xmm3
180003e4c:     	divsd	%xmm4, %xmm3
180003e50:     	ucomisd	%xmm3, %xmm6
180003e54:     	jbe	0x180003ebb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x32b>
180003e56:     	movsd	0x957a(%rip), %xmm3     # 0x18000d3d8
180003e5e:     	maxsd	%xmm4, %xmm3
180003e62:     	movapd	%xmm3, %xmm4
180003e66:     	mulsd	%xmm3, %xmm4
180003e6a:     	xorpd	%xmm5, %xmm5
180003e6e:     	ucomisd	%xmm5, %xmm4
180003e72:     	jne	0x180003e86 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2f6>
180003e74:     	jp	0x180003e86 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2f6>
180003e76:     	movb	$0x1, (%rbx)
180003e79:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180003e81:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180003e86:     	movsd	0x8(%rdi,%r12,8), %xmm5
180003e8d:     	mulsd	0x954b(%rip), %xmm5     # 0x18000d3e0
180003e95:     	mulsd	%xmm5, %xmm0
180003e99:     	divsd	%xmm4, %xmm0
180003e9d:     	mulsd	%xmm0, %xmm1
180003ea1:     	divsd	%xmm3, %xmm1
180003ea5:     	mulsd	%xmm0, %xmm2
180003ea9:     	divsd	%xmm3, %xmm2
180003ead:     	movsd	%xmm1, (%rcx)
180003eb1:     	movsd	%xmm2, 0x8(%rcx)
180003eb6:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
180003ebb:     	movq	0x2c8(%rsp), %rdx
180003ec3:     	movq	0x298(%rsp), %rbp
180003ecb:     	movq	0x290(%rsp), %r11
180003ed3:     	movq	0x20(%r14,%r13,8), %rax
180003ed8:     	testq	%rax, %rax
180003edb:     	js	0x1800040cb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x53b>
180003ee1:     	movq	0x8(%rsi), %rdx
180003ee5:     	leaq	0x1(%rdx), %r10
180003ee9:     	movq	%r10, 0x8(%rsi)
180003eed:     	cmpq	0x10(%rsi), %rdx
180003ef1:     	jge	0x180004489 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8f9>
180003ef7:     	movq	%rcx, 0x108(%rsp)
180003eff:     	movsd	%xmm6, 0x100(%rsp)
180003f08:     	movq	%r12, 0xf8(%rsp)
180003f10:     	movq	%rax, 0xf0(%rsp)
180003f18:     	movq	0x2c8(%rsp), %rax
180003f20:     	movq	%rax, 0xe8(%rsp)
180003f28:     	movq	0x2c0(%rsp), %rax
180003f30:     	movq	%rax, 0xe0(%rsp)
180003f38:     	movq	%rbx, 0xd8(%rsp)
180003f40:     	movq	0x2b0(%rsp), %rax
180003f48:     	movq	%rax, 0xd0(%rsp)
180003f50:     	movq	0x2a8(%rsp), %rax
180003f58:     	movq	%rax, 0xc8(%rsp)
180003f60:     	movq	0x2a0(%rsp), %rax
180003f68:     	movq	%rax, 0xc0(%rsp)
180003f70:     	movq	%rbp, 0xb8(%rsp)
180003f78:     	movq	%r11, 0xb0(%rsp)
180003f80:     	movq	0x288(%rsp), %rax
180003f88:     	movq	%rax, 0xa8(%rsp)
180003f90:     	movq	%rsi, 0xa0(%rsp)
180003f98:     	movq	0x278(%rsp), %rax
180003fa0:     	movq	%rax, 0x98(%rsp)
180003fa8:     	movq	0x270(%rsp), %rax
180003fb0:     	movq	%rax, 0x90(%rsp)
180003fb8:     	movq	0x268(%rsp), %rax
180003fc0:     	movq	%rax, 0x88(%rsp)
180003fc8:     	movq	0x260(%rsp), %rax
180003fd0:     	movq	%rax, 0x80(%rsp)
180003fd8:     	movq	0x258(%rsp), %rax
180003fe0:     	movq	%rax, 0x78(%rsp)
180003fe5:     	movq	%r15, 0x70(%rsp)
180003fea:     	movq	%r14, 0x68(%rsp)
180003fef:     	movq	0x240(%rsp), %rax
180003ff7:     	movq	%rax, 0x60(%rsp)
180003ffc:     	movq	0x238(%rsp), %rax
180004004:     	movq	%rax, 0x58(%rsp)
180004009:     	movq	0x230(%rsp), %rax
180004011:     	movq	%rax, 0x50(%rsp)
180004016:     	movq	0x228(%rsp), %rax
18000401e:     	movq	%rax, 0x48(%rsp)
180004023:     	movq	0x220(%rsp), %rax
18000402b:     	movq	%rax, 0x40(%rsp)
180004030:     	movq	0x218(%rsp), %rax
180004038:     	movq	%rax, 0x38(%rsp)
18000403d:     	movq	%rdi, 0x30(%rsp)
180004042:     	movq	0x208(%rsp), %rax
18000404a:     	movq	%rax, 0x28(%rsp)
18000404f:     	movq	0x200(%rsp), %rax
180004057:     	movq	%rax, 0x20(%rsp)
18000405c:     	leaq	0x150(%rsp), %rcx
180004064:     	movq	%r8, 0x110(%rsp)
18000406c:     	movq	%r9, %rbp
18000406f:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004074:     	cmpb	$0x0, (%rbx)
180004077:     	jne	0x18000446d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8dd>
18000407d:     	xorpd	%xmm8, %xmm8
180004082:     	movsd	0x150(%rsp), %xmm7
18000408b:     	addsd	%xmm8, %xmm7
180004090:     	addsd	0x158(%rsp), %xmm8
18000409a:     	decq	0x8(%rsi)
18000409e:     	movq	0x108(%rsp), %rcx
1800040a6:     	movq	%rbp, %r9
1800040a9:     	movq	0x110(%rsp), %r8
1800040b1:     	movq	0x290(%rsp), %r11
1800040b9:     	movq	0x298(%rsp), %rbp
1800040c1:     	movq	0x2c8(%rsp), %rdx
1800040c9:     	jmp	0x1800040d4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x544>
1800040cb:     	xorpd	%xmm7, %xmm7
1800040cf:     	xorpd	%xmm8, %xmm8
1800040d4:     	movq	0x28(%r14,%r13,8), %rax
1800040d9:     	testq	%rax, %rax
1800040dc:     	js	0x1800042c2 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x732>
1800040e2:     	movq	0x8(%rsi), %rdx
1800040e6:     	leaq	0x1(%rdx), %r10
1800040ea:     	movq	%r10, 0x8(%rsi)
1800040ee:     	cmpq	0x10(%rsi), %rdx
1800040f2:     	jge	0x180004499 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x909>
1800040f8:     	movq	%rcx, 0x108(%rsp)
180004100:     	movsd	%xmm6, 0x100(%rsp)
180004109:     	movq	%r12, 0xf8(%rsp)
180004111:     	movq	%rax, 0xf0(%rsp)
180004119:     	movq	0x2c8(%rsp), %rax
180004121:     	movq	%rax, 0xe8(%rsp)
180004129:     	movq	0x2c0(%rsp), %rax
180004131:     	movq	%rax, 0xe0(%rsp)
180004139:     	movq	%rbx, 0xd8(%rsp)
180004141:     	movq	0x2b0(%rsp), %rax
180004149:     	movq	%rax, 0xd0(%rsp)
180004151:     	movq	0x2a8(%rsp), %rax
180004159:     	movq	%rax, 0xc8(%rsp)
180004161:     	movq	0x2a0(%rsp), %rax
180004169:     	movq	%rax, 0xc0(%rsp)
180004171:     	movq	%rbp, 0xb8(%rsp)
180004179:     	movq	%r11, 0xb0(%rsp)
180004181:     	movq	0x288(%rsp), %rax
180004189:     	movq	%rax, 0xa8(%rsp)
180004191:     	movq	%rsi, 0xa0(%rsp)
180004199:     	movq	0x278(%rsp), %rax
1800041a1:     	movq	%rax, 0x98(%rsp)
1800041a9:     	movq	0x270(%rsp), %rax
1800041b1:     	movq	%rax, 0x90(%rsp)
1800041b9:     	movq	0x268(%rsp), %rax
1800041c1:     	movq	%rax, 0x88(%rsp)
1800041c9:     	movq	0x260(%rsp), %rax
1800041d1:     	movq	%rax, 0x80(%rsp)
1800041d9:     	movq	0x258(%rsp), %rax
1800041e1:     	movq	%rax, 0x78(%rsp)
1800041e6:     	movq	%r15, 0x70(%rsp)
1800041eb:     	movq	%r14, 0x68(%rsp)
1800041f0:     	movq	0x240(%rsp), %rax
1800041f8:     	movq	%rax, 0x60(%rsp)
1800041fd:     	movq	0x238(%rsp), %rax
180004205:     	movq	%rax, 0x58(%rsp)
18000420a:     	movq	0x230(%rsp), %rax
180004212:     	movq	%rax, 0x50(%rsp)
180004217:     	movq	0x228(%rsp), %rax
18000421f:     	movq	%rax, 0x48(%rsp)
180004224:     	movq	0x220(%rsp), %rax
18000422c:     	movq	%rax, 0x40(%rsp)
180004231:     	movq	0x218(%rsp), %rax
180004239:     	movq	%rax, 0x38(%rsp)
18000423e:     	movq	%rdi, 0x30(%rsp)
180004243:     	movq	0x208(%rsp), %rax
18000424b:     	movq	%rax, 0x28(%rsp)
180004250:     	movq	0x200(%rsp), %rax
180004258:     	movq	%rax, 0x20(%rsp)
18000425d:     	leaq	0x140(%rsp), %rcx
180004265:     	movq	%r8, 0x110(%rsp)
18000426d:     	movq	%r9, 0x118(%rsp)
180004275:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
18000427a:     	cmpb	$0x0, (%rbx)
18000427d:     	jne	0x18000446d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x8dd>
180004283:     	addsd	0x140(%rsp), %xmm7
18000428c:     	addsd	0x148(%rsp), %xmm8
180004296:     	decq	0x8(%rsi)
18000429a:     	movq	0x108(%rsp), %rcx
1800042a2:     	movq	0x118(%rsp), %r9
1800042aa:     	movq	0x110(%rsp), %r8
1800042b2:     	movq	0x290(%rsp), %r11
1800042ba:     	movq	0x2c8(%rsp), %rdx
1800042c2:     	movq	0x38(%r14,%r13,8), %rax
1800042c7:     	testq	%rax, %rax
1800042ca:     	js	0x1800044f8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x968>
1800042d0:     	movq	0x8(%rsi), %rdx
1800042d4:     	leaq	0x1(%rdx), %r10
1800042d8:     	movq	%r10, 0x8(%rsi)
1800042dc:     	cmpq	0x10(%rsi), %rdx
1800042e0:     	jge	0x1800044a9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x919>
1800042e6:     	movq	%rcx, 0x108(%rsp)
1800042ee:     	movsd	%xmm6, 0x100(%rsp)
1800042f7:     	movq	%r12, 0xf8(%rsp)
1800042ff:     	movq	%rax, 0xf0(%rsp)
180004307:     	movq	0x2c8(%rsp), %rax
18000430f:     	movq	%rax, 0xe8(%rsp)
180004317:     	movq	0x2c0(%rsp), %rax
18000431f:     	movq	%rax, 0xe0(%rsp)
180004327:     	movq	%rbx, 0xd8(%rsp)
18000432f:     	movq	0x2b0(%rsp), %rax
180004337:     	movq	%rax, 0xd0(%rsp)
18000433f:     	movq	0x2a8(%rsp), %rax
180004347:     	movq	%rax, 0xc8(%rsp)
18000434f:     	movq	0x2a0(%rsp), %rax
180004357:     	movq	%rax, 0xc0(%rsp)
18000435f:     	movq	%rbp, 0xb8(%rsp)
180004367:     	movq	%r11, 0xb0(%rsp)
18000436f:     	movq	0x288(%rsp), %rax
180004377:     	movq	%rax, 0xa8(%rsp)
18000437f:     	movq	%rsi, 0xa0(%rsp)
180004387:     	movq	0x278(%rsp), %rax
18000438f:     	movq	%rax, 0x98(%rsp)
180004397:     	movq	0x270(%rsp), %rax
18000439f:     	movq	%rax, 0x90(%rsp)
1800043a7:     	movq	0x268(%rsp), %rax
1800043af:     	movq	%rax, 0x88(%rsp)
1800043b7:     	movq	0x260(%rsp), %rax
1800043bf:     	movq	%rax, 0x80(%rsp)
1800043c7:     	movq	0x258(%rsp), %rax
1800043cf:     	movq	%rax, 0x78(%rsp)
1800043d4:     	movq	%r15, 0x70(%rsp)
1800043d9:     	movq	%r14, 0x68(%rsp)
1800043de:     	movq	0x240(%rsp), %rax
1800043e6:     	movq	%rax, 0x60(%rsp)
1800043eb:     	movq	0x238(%rsp), %rax
1800043f3:     	movq	%rax, 0x58(%rsp)
1800043f8:     	movq	0x230(%rsp), %rax
180004400:     	movq	%rax, 0x50(%rsp)
180004405:     	movq	0x228(%rsp), %rax
18000440d:     	movq	%rax, 0x48(%rsp)
180004412:     	movq	0x220(%rsp), %rax
18000441a:     	movq	%rax, 0x40(%rsp)
18000441f:     	movq	0x218(%rsp), %rax
180004427:     	movq	%rax, 0x38(%rsp)
18000442c:     	movq	%rdi, 0x30(%rsp)
180004431:     	movq	0x208(%rsp), %rax
180004439:     	movq	%rax, 0x28(%rsp)
18000443e:     	movq	0x200(%rsp), %rax
180004446:     	movq	%rax, 0x20(%rsp)
18000444b:     	leaq	0x130(%rsp), %rcx
180004453:     	movq	%r8, 0x110(%rsp)
18000445b:     	movq	%r9, 0x118(%rsp)
180004463:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004468:     	cmpb	$0x0, (%rbx)
18000446b:     	je	0x1800044b9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x929>
18000446d:     	movq	0x108(%rsp), %rax
180004475:     	movq	$0x0, 0x8(%rax)
18000447d:     	movq	$0x0, (%rax)
180004484:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
180004489:     	movb	$0x1, (%rbx)
18000448c:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004494:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
180004499:     	movb	$0x1, (%rbx)
18000449c:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
1800044a4:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800044a9:     	movb	$0x1, (%rbx)
1800044ac:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800044b4:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800044b9:     	addsd	0x130(%rsp), %xmm7
1800044c2:     	addsd	0x138(%rsp), %xmm8
1800044cc:     	decq	0x8(%rsi)
1800044d0:     	movq	0x108(%rsp), %rcx
1800044d8:     	movq	0x118(%rsp), %r9
1800044e0:     	movq	0x110(%rsp), %r8
1800044e8:     	movq	0x290(%rsp), %r11
1800044f0:     	movq	0x2c8(%rsp), %rdx
1800044f8:     	movq	0x40(%r14,%r13,8), %rax
1800044fd:     	testq	%rax, %rax
180004500:     	js	0x1800046da <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb4a>
180004506:     	movq	%rdx, %r13
180004509:     	movq	0x8(%rsi), %rdx
18000450d:     	leaq	0x1(%rdx), %r10
180004511:     	movq	%r10, 0x8(%rsi)
180004515:     	cmpq	0x10(%rsi), %rdx
180004519:     	jge	0x1800046ab <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb1b>
18000451f:     	movq	%rcx, 0x108(%rsp)
180004527:     	movq	%r12, 0xf8(%rsp)
18000452f:     	movq	%rax, 0xf0(%rsp)
180004537:     	movq	%r13, 0xe8(%rsp)
18000453f:     	movq	0x2c0(%rsp), %rax
180004547:     	movq	%rax, 0xe0(%rsp)
18000454f:     	movq	0x2b0(%rsp), %rax
180004557:     	movq	%rax, 0xd0(%rsp)
18000455f:     	movq	0x2a8(%rsp), %rax
180004567:     	movq	%rax, 0xc8(%rsp)
18000456f:     	movq	0x2a0(%rsp), %rax
180004577:     	movq	%rax, 0xc0(%rsp)
18000457f:     	movq	%rbp, 0xb8(%rsp)
180004587:     	movq	%r11, 0xb0(%rsp)
18000458f:     	movq	0x288(%rsp), %rax
180004597:     	movq	%rax, 0xa8(%rsp)
18000459f:     	movq	0x278(%rsp), %rax
1800045a7:     	movq	%rax, 0x98(%rsp)
1800045af:     	movq	0x270(%rsp), %rax
1800045b7:     	movq	%rax, 0x90(%rsp)
1800045bf:     	movq	0x268(%rsp), %rax
1800045c7:     	movq	%rax, 0x88(%rsp)
1800045cf:     	movq	0x260(%rsp), %rax
1800045d7:     	movq	%rax, 0x80(%rsp)
1800045df:     	movq	0x258(%rsp), %rax
1800045e7:     	movq	%rax, 0x78(%rsp)
1800045ec:     	movq	%r15, 0x70(%rsp)
1800045f1:     	movq	%r14, 0x68(%rsp)
1800045f6:     	movq	0x240(%rsp), %rax
1800045fe:     	movq	%rax, 0x60(%rsp)
180004603:     	movq	0x238(%rsp), %rax
18000460b:     	movq	%rax, 0x58(%rsp)
180004610:     	movq	0x230(%rsp), %rax
180004618:     	movq	%rax, 0x50(%rsp)
18000461d:     	movq	0x228(%rsp), %rax
180004625:     	movq	%rax, 0x48(%rsp)
18000462a:     	movq	0x220(%rsp), %rax
180004632:     	movq	%rax, 0x40(%rsp)
180004637:     	movq	0x218(%rsp), %rax
18000463f:     	movq	%rax, 0x38(%rsp)
180004644:     	movq	%rdi, 0x30(%rsp)
180004649:     	movq	0x208(%rsp), %rax
180004651:     	movq	%rax, 0x28(%rsp)
180004656:     	movsd	%xmm6, 0x100(%rsp)
18000465f:     	movq	%rbx, 0xd8(%rsp)
180004667:     	movq	%rsi, 0xa0(%rsp)
18000466f:     	movq	0x200(%rsp), %rax
180004677:     	movq	%rax, 0x20(%rsp)
18000467c:     	leaq	0x120(%rsp), %rcx
180004684:     	callq	0x180003bf0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x60>
180004689:     	cmpb	$0x0, (%rbx)
18000468c:     	je	0x1800046bb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2b>
18000468e:     	movq	0x108(%rsp), %r13
180004696:     	movq	$0x0, 0x8(%r13)
18000469e:     	movq	$0x0, (%r13)
1800046a6:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
1800046ab:     	movb	$0x1, (%rbx)
1800046ae:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
1800046b6:     	jmp	0x180003c42 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb2>
1800046bb:     	addsd	0x120(%rsp), %xmm7
1800046c4:     	addsd	0x128(%rsp), %xmm8
1800046ce:     	decq	0x8(%rsi)
1800046d2:     	movq	0x108(%rsp), %rcx
1800046da:     	movsd	%xmm7, (%rcx)
1800046de:     	movsd	%xmm8, 0x8(%rcx)
1800046e4:     	jmp	0x180003c51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xc1>
1800046e9:     	nopl	(%rax)
1800046f0:     	pushq	%r15
1800046f2:     	pushq	%r14
1800046f4:     	pushq	%r13
1800046f6:     	pushq	%r12
1800046f8:     	pushq	%rsi
1800046f9:     	pushq	%rdi
1800046fa:     	pushq	%rbp
1800046fb:     	pushq	%rbx
1800046fc:     	subq	$0x178, %rsp            # imm = 0x178
180004703:     	movq	0x2b0(%rsp), %rax
18000470b:     	movq	0x298(%rsp), %r13
180004713:     	movq	0x260(%rsp), %rbp
18000471b:     	movq	0x258(%rsp), %rdi
180004723:     	movb	$0x0, 0x137(%rsp)
18000472b:     	movb	$0x0, 0x127(%rsp)
180004733:     	movb	$0x0, 0x126(%rsp)
18000473b:     	movb	$0x0, 0x125(%rsp)
180004743:     	movb	$0x0, 0x124(%rsp)
18000474b:     	movb	$0x0, 0x136(%rsp)
180004753:     	movb	$0x0, 0x135(%rsp)
18000475b:     	movb	$0x0, 0x134(%rsp)
180004763:     	movb	$0x0, 0x133(%rsp)
18000476b:     	cmpq	$0x1, %rax
18000476f:     	movq	0x230(%rsp), %r15
180004777:     	movq	0x228(%rsp), %rbx
18000477f:     	movq	0x1f0(%rsp), %r14
180004787:     	je	0x180004922 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xd92>
18000478d:     	testq	%rax, %rax
180004790:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004796:     	movq	0x2c0(%rsp), %rsi
18000479e:     	movq	0x2b8(%rsp), %rdi
1800047a6:     	movq	(%rbx,%rdi,8), %rax
1800047aa:     	movq	0x10(%rbx,%rsi,8), %rdx
1800047af:     	movsd	(%r14,%rdx,8), %xmm0
1800047b5:     	movsd	0x8(%r14,%rax,8), %xmm2
1800047bc:     	movsd	0x10(%r14,%rax,8), %xmm1
1800047c3:     	movapd	%xmm1, %xmm3
1800047c7:     	subsd	%xmm2, %xmm3
1800047cb:     	xorl	%r12d, %r12d
1800047ce:     	ucomisd	%xmm3, %xmm0
1800047d2:     	jb	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
1800047d8:     	addsd	%xmm2, %xmm1
1800047dc:     	ucomisd	%xmm0, %xmm1
1800047e0:     	jbe	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
1800047e6:     	movsd	0x10(%r14,%rdx,8), %xmm0
1800047ed:     	movsd	(%r14,%rax,8), %xmm2
1800047f3:     	movsd	0x18(%r14,%rax,8), %xmm1
1800047fa:     	movapd	%xmm1, %xmm3
1800047fe:     	subsd	%xmm2, %xmm3
180004802:     	ucomisd	%xmm3, %xmm0
180004806:     	jb	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
18000480c:     	addsd	%xmm2, %xmm1
180004810:     	xorl	%r12d, %r12d
180004813:     	ucomisd	%xmm0, %xmm1
180004817:     	jbe	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
18000481d:     	cmpb	$0x0, (%r13)
180004822:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180004828:     	movq	0x18(%rbx,%rdi,8), %r12
18000482d:     	movq	0x30(%rbx,%rdi,8), %rdx
180004832:     	movq	%rdx, %r11
180004835:     	sarq	$0x3f, %r11
180004839:     	andq	%r15, %r11
18000483c:     	leaq	(%rbx,%rdx,8), %rax
180004840:     	movq	(%rax,%r11,8), %r10
180004844:     	cmpq	0x8(%rbx,%rdi,8), %r10
180004849:     	jge	0x180004b40 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfb0>
18000484f:     	testq	%r12, %r12
180004852:     	jne	0x180004b49 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfb9>
180004858:     	xorl	%r9d, %r9d
18000485b:     	cmpq	$-0x1, %rdx
18000485f:     	cmovlq	%r15, %r9
180004863:     	cmpq	0x8(%rax,%r9,8), %r10
180004868:     	jne	0x1800053dd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x184d>
18000486e:     	leaq	(%r10,%r10), %r8
180004872:     	testq	%r10, %r10
180004875:     	movl	$0x4, %eax
18000487a:     	cmovneq	%r8, %rax
18000487e:     	movq	(%rbp), %r12
180004882:     	leaq	(%r12,%rax), %r8
180004886:     	cmpq	%r15, %r8
180004889:     	jg	0x18000492f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xd9f>
18000488f:     	movq	%r8, (%rbp)
180004893:     	cmpb	$0x0, (%r13)
180004898:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
18000489e:     	movq	%r12, 0x128(%rsp)
1800048a6:     	movq	%rax, 0x168(%rsp)
1800048ae:     	movq	%r9, 0x170(%rsp)
1800048b6:     	xorl	%eax, %eax
1800048b8:     	movq	%rdx, 0x158(%rsp)
1800048c0:     	cmpq	$-0x2, %rdx
1800048c4:     	cmovlq	%r15, %rax
1800048c8:     	movq	%rax, 0x140(%rsp)
1800048d0:     	movq	%r10, 0x148(%rsp)
1800048d8:     	testq	%r10, %r10
1800048db:     	jle	0x18000539f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x180f>
1800048e1:     	movq	0x158(%rsp), %rax
1800048e9:     	leaq	(%rbx,%rax,8), %rax
1800048ed:     	movq	0x140(%rsp), %r8
1800048f5:     	movq	0x10(%rax,%r8,8), %r9
1800048fa:     	movq	0x148(%rsp), %rax
180004902:     	movl	%eax, %r10d
180004905:     	andl	$0x7, %r10d
180004909:     	cmpq	$0x7, %rax
18000490d:     	ja	0x18000516e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x15de>
180004913:     	leaq	(,%r15,8), %r12
18000491b:     	xorl	%edx, %edx
18000491d:     	jmp	0x18000535d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x17cd>
180004922:     	movq	(%rbp), %rdx
180004926:     	leaq	0x4(%rdx), %rax
18000492a:     	cmpq	%r15, %rax
18000492d:     	jle	0x180004939 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xda9>
18000492f:     	movb	$0x2, (%r13)
180004934:     	jmp	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004939:     	movq	0x2c8(%rsp), %rsi
180004941:     	movq	(%rbx,%rsi,8), %r10
180004945:     	movsd	0x10(%r14,%r10,8), %xmm1
18000494c:     	movsd	0x18(%r14,%r10,8), %xmm2
180004953:     	movsd	0x8a55(%rip), %xmm0     # 0x18000d3b0
18000495b:     	movsd	0x8(%r14,%r10,8), %xmm3
180004962:     	mulsd	%xmm0, %xmm3
180004966:     	mulsd	(%r14,%r10,8), %xmm0
18000496c:     	movq	%rax, (%rbp)
180004970:     	cmpb	$0x0, (%r13)
180004975:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
18000497b:     	movapd	%xmm1, %xmm4
18000497f:     	addsd	%xmm3, %xmm4
180004983:     	movapd	%xmm2, %xmm5
180004987:     	subsd	%xmm0, %xmm5
18000498b:     	movsd	%xmm4, 0x10(%r14,%rdx,8)
180004992:     	movsd	%xmm5, 0x18(%r14,%rdx,8)
180004999:     	movsd	%xmm3, 0x8(%r14,%rdx,8)
1800049a0:     	movsd	%xmm0, (%r14,%rdx,8)
1800049a6:     	cmpb	$0x0, (%r13)
1800049ab:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
1800049b1:     	movq	(%rbp), %rax
1800049b5:     	leaq	0xb(%rax), %r11
1800049b9:     	cmpq	%r15, %r11
1800049bc:     	jg	0x18000492f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xd9f>
1800049c2:     	movq	0x8(%rbx,%rsi,8), %r10
1800049c7:     	movq	%r11, (%rbp)
1800049cb:     	cmpb	$0x0, (%r13)
1800049d0:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
1800049d6:     	movq	%rdx, (%rbx,%rax,8)
1800049da:     	movq	%r10, 0x8(%rbx,%rax,8)
1800049df:     	movq	(%rbp), %rdx
1800049e3:     	cmpq	%r15, %rdx
1800049e6:     	movq	%rdx, %r10
1800049e9:     	jle	0x1800049f7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xe67>
1800049eb:     	movb	$0x2, (%r13)
1800049f0:     	movq	(%rbp), %rdx
1800049f4:     	xorl	%r10d, %r10d
1800049f7:     	leaq	0x3(%rdx), %r11
1800049fb:     	cmpq	%r15, %r11
1800049fe:     	jg	0x18000492f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xd9f>
180004a04:     	movq	%r11, (%rbp)
180004a08:     	cmpb	$0x0, (%r13)
180004a0d:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004a13:     	movq	%rdx, %r11
180004a16:     	sarq	$0x3f, %r11
180004a1a:     	andq	%r15, %r11
180004a1d:     	leaq	(%rbx,%rdx,8), %rsi
180004a21:     	movq	$0x0, (%rsi,%r11,8)
180004a29:     	xorl	%r12d, %r12d
180004a2c:     	cmpq	$-0x1, %rdx
180004a30:     	movl	$0x0, %r11d
180004a36:     	cmovlq	%r15, %r11
180004a3a:     	movq	$0x0, 0x8(%rsi,%r11,8)
180004a43:     	cmpq	$-0x2, %rdx
180004a47:     	movl	$0x0, %r11d
180004a4d:     	cmovlq	%r15, %r11
180004a51:     	movq	%r10, 0x10(%rsi,%r11,8)
180004a56:     	cmpb	$0x0, (%r13)
180004a5b:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180004a61:     	leaq	(%rbx,%rax,8), %r10
180004a65:     	movq	%rdx, 0x30(%r10)
180004a69:     	movq	$0x0, 0x18(%r10)
180004a71:     	movq	(%rbp), %rdx
180004a75:     	leaq	0x4(%rdx), %r11
180004a79:     	cmpq	%r15, %r11
180004a7c:     	jg	0x18000492f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xd9f>
180004a82:     	movq	%r11, (%rbp)
180004a86:     	cmpb	$0x0, (%r13)
180004a8b:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004a91:     	movq	%r8, 0x128(%rsp)
180004a99:     	movq	%r9, 0x138(%rsp)
180004aa1:     	movq	%rcx, 0x118(%rsp)
180004aa9:     	movq	$0x0, (%r14,%rdx,8)
180004ab1:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180004aba:     	movq	$0x0, 0x10(%r14,%rdx,8)
180004ac3:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180004acc:     	cmpb	$0x0, (%r13)
180004ad1:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180004ad7:     	movq	%r13, %rsi
180004ada:     	movq	%rdx, 0x10(%r10)
180004ade:     	movq	$0x0, 0x48(%r14,%rax,8)
180004ae7:     	movq	$0x1, 0x50(%r10)
180004aef:     	movq	$-0x1, 0x20(%r10)
180004af7:     	movq	$-0x1, 0x28(%r10)
180004aff:     	movq	$-0x1, 0x38(%r10)
180004b07:     	movq	$-0x1, 0x40(%r10)
180004b0f:     	cmpb	$0x0, (%r13)
180004b14:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180004b1a:     	movq	0x2c8(%rsp), %rcx
180004b22:     	movq	%rax, 0x20(%rbx,%rcx,8)
180004b27:     	movq	(%rbp), %rcx
180004b2b:     	leaq	0x4(%rcx), %rax
180004b2f:     	cmpq	%r15, %rax
180004b32:     	jle	0x180005783 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1bf3>
180004b38:     	movb	$0x2, (%rsi)
180004b3b:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180004b40:     	testq	%r12, %r12
180004b43:     	je	0x180004d70 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x11e0>
180004b49:     	movq	0x20(%rbx,%rdi,8), %rax
180004b4e:     	testq	%rax, %rax
180004b51:     	js	0x180004f6e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13de>
180004b57:     	movq	0x8(%rbp), %rdx
180004b5b:     	leaq	0x1(%rdx), %r10
180004b5f:     	movq	%r10, 0x8(%rbp)
180004b63:     	cmpq	0x10(%rbp), %rdx
180004b67:     	jge	0x180004f6e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13de>
180004b6d:     	movq	%rcx, 0x118(%rsp)
180004b75:     	movb	$0x0, 0x127(%rsp)
180004b7d:     	movq	%rsi, 0x100(%rsp)
180004b85:     	movq	%rax, 0xf8(%rsp)
180004b8d:     	movq	0x2a8(%rsp), %rax
180004b95:     	movq	%rax, 0xe8(%rsp)
180004b9d:     	movq	0x2a0(%rsp), %rax
180004ba5:     	movq	%rax, 0xe0(%rsp)
180004bad:     	movq	%r13, 0xd8(%rsp)
180004bb5:     	movq	0x290(%rsp), %rax
180004bbd:     	movq	%rax, 0xd0(%rsp)
180004bc5:     	movq	0x288(%rsp), %rax
180004bcd:     	movq	%rax, 0xc8(%rsp)
180004bd5:     	movq	0x280(%rsp), %rax
180004bdd:     	movq	%rax, 0xc0(%rsp)
180004be5:     	movq	0x278(%rsp), %rax
180004bed:     	movq	%rax, 0xb8(%rsp)
180004bf5:     	movq	0x270(%rsp), %rax
180004bfd:     	movq	%rax, 0xb0(%rsp)
180004c05:     	movq	0x268(%rsp), %rax
180004c0d:     	movq	%rax, 0xa8(%rsp)
180004c15:     	movq	%rbp, 0xa0(%rsp)
180004c1d:     	movq	0x258(%rsp), %rax
180004c25:     	movq	%rax, 0x98(%rsp)
180004c2d:     	movq	0x250(%rsp), %rax
180004c35:     	movq	%rax, 0x90(%rsp)
180004c3d:     	movq	0x248(%rsp), %rax
180004c45:     	movq	%rax, 0x88(%rsp)
180004c4d:     	movq	0x240(%rsp), %rax
180004c55:     	movq	%rax, 0x80(%rsp)
180004c5d:     	movq	0x238(%rsp), %rax
180004c65:     	movq	%rax, 0x78(%rsp)
180004c6a:     	movq	%r15, 0x70(%rsp)
180004c6f:     	movq	%rbx, 0x68(%rsp)
180004c74:     	movq	0x220(%rsp), %rax
180004c7c:     	movq	%rax, 0x60(%rsp)
180004c81:     	movq	0x218(%rsp), %rax
180004c89:     	movq	%rax, 0x58(%rsp)
180004c8e:     	movq	0x210(%rsp), %rax
180004c96:     	movq	%rax, 0x50(%rsp)
180004c9b:     	movq	0x208(%rsp), %rax
180004ca3:     	movq	%rax, 0x48(%rsp)
180004ca8:     	movq	0x200(%rsp), %rax
180004cb0:     	movq	%rax, 0x40(%rsp)
180004cb5:     	movq	0x1f8(%rsp), %rax
180004cbd:     	movq	%rax, 0x38(%rsp)
180004cc2:     	movq	%r14, 0x30(%rsp)
180004cc7:     	movq	0x1e8(%rsp), %rax
180004ccf:     	movq	%rax, 0x28(%rsp)
180004cd4:     	movq	0x1e0(%rsp), %rax
180004cdc:     	movq	%rax, 0x20(%rsp)
180004ce1:     	movq	$-0x1, 0x108(%rsp)
180004ced:     	movq	$0x0, 0xf0(%rsp)
180004cf9:     	leaq	0x127(%rsp), %rcx
180004d01:     	movq	%r8, 0x128(%rsp)
180004d09:     	movq	%r9, 0x138(%rsp)
180004d11:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180004d16:     	cmpb	$0x0, (%r13)
180004d1b:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180004d21:     	movq	0x8(%rbp), %rdx
180004d25:     	leaq	-0x1(%rdx), %rax
180004d29:     	cmpb	$0x0, 0x127(%rsp)
180004d31:     	movq	%rax, 0x8(%rbp)
180004d35:     	movb	$0x1, %r12b
180004d38:     	movq	0x118(%rsp), %rcx
180004d40:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180004d46:     	movq	0x28(%rbx,%rdi,8), %rax
180004d4b:     	testq	%rax, %rax
180004d4e:     	js	0x180004d5e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x11ce>
180004d50:     	movq	%rdx, 0x8(%rbp)
180004d54:     	cmpq	0x10(%rbp), %rdx
180004d58:     	jle	0x180004f9b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x140b>
180004d5e:     	movb	$0x1, (%r13)
180004d63:     	movq	$0x2dc6ce, 0x18(%rbp)   # imm = 0x2DC6CE
180004d6b:     	jmp	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004d70:     	movq	0x8(%rbp), %rax
180004d74:     	leaq	0x1(%rax), %rdx
180004d78:     	movq	%rdx, 0x8(%rbp)
180004d7c:     	cmpq	0x10(%rbp), %rax
180004d80:     	jge	0x180004f3a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13aa>
180004d86:     	movq	%rcx, 0x118(%rsp)
180004d8e:     	movq	%rdi, 0x108(%rsp)
180004d96:     	movq	0x2a8(%rsp), %rax
180004d9e:     	movq	%rax, 0xe8(%rsp)
180004da6:     	movq	0x2a0(%rsp), %rax
180004dae:     	movq	%rax, 0xe0(%rsp)
180004db6:     	movq	%r13, 0xd8(%rsp)
180004dbe:     	movq	0x290(%rsp), %rax
180004dc6:     	movq	%rax, 0xd0(%rsp)
180004dce:     	movq	0x288(%rsp), %rax
180004dd6:     	movq	%rax, 0xc8(%rsp)
180004dde:     	movq	0x280(%rsp), %rax
180004de6:     	movq	%rax, 0xc0(%rsp)
180004dee:     	movq	0x278(%rsp), %rax
180004df6:     	movq	%rax, 0xb8(%rsp)
180004dfe:     	movq	0x270(%rsp), %rax
180004e06:     	movq	%rax, 0xb0(%rsp)
180004e0e:     	movq	0x268(%rsp), %rax
180004e16:     	movq	%rax, 0xa8(%rsp)
180004e1e:     	movq	%rbp, 0xa0(%rsp)
180004e26:     	movq	0x258(%rsp), %rax
180004e2e:     	movq	%rax, 0x98(%rsp)
180004e36:     	movq	0x250(%rsp), %rax
180004e3e:     	movq	%rax, 0x90(%rsp)
180004e46:     	movq	0x248(%rsp), %rax
180004e4e:     	movq	%rax, 0x88(%rsp)
180004e56:     	movq	0x240(%rsp), %rax
180004e5e:     	movq	%rax, 0x80(%rsp)
180004e66:     	movq	0x238(%rsp), %rax
180004e6e:     	movq	%rax, 0x78(%rsp)
180004e73:     	movq	%r15, 0x70(%rsp)
180004e78:     	movq	%rbx, 0x68(%rsp)
180004e7d:     	movq	0x220(%rsp), %rax
180004e85:     	movq	%rax, 0x60(%rsp)
180004e8a:     	movq	0x218(%rsp), %rax
180004e92:     	movq	%rax, 0x58(%rsp)
180004e97:     	movq	0x210(%rsp), %rax
180004e9f:     	movq	%rax, 0x50(%rsp)
180004ea4:     	movq	0x208(%rsp), %rax
180004eac:     	movq	%rax, 0x48(%rsp)
180004eb1:     	movq	0x200(%rsp), %rax
180004eb9:     	movq	%rax, 0x40(%rsp)
180004ebe:     	movq	0x1f8(%rsp), %rax
180004ec6:     	movq	%rax, 0x38(%rsp)
180004ecb:     	movq	%r14, 0x30(%rsp)
180004ed0:     	movq	0x1e8(%rsp), %rax
180004ed8:     	movq	%rax, 0x28(%rsp)
180004edd:     	movq	0x1e0(%rsp), %rax
180004ee5:     	movq	%rax, 0x20(%rsp)
180004eea:     	movq	$-0x1, 0x100(%rsp)
180004ef6:     	movq	$-0x1, 0xf8(%rsp)
180004f02:     	movq	$0x1, 0xf0(%rsp)
180004f0e:     	leaq	0x137(%rsp), %rcx
180004f16:     	movq	%r8, 0x128(%rsp)
180004f1e:     	movq	%r9, %r12
180004f21:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180004f26:     	cmpb	$0x0, (%r13)
180004f2b:     	je	0x180004f49 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13b9>
180004f2d:     	xorl	%r12d, %r12d
180004f30:     	movq	0x118(%rsp), %rcx
180004f38:     	jmp	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180004f3a:     	movb	$0x1, (%r13)
180004f3f:     	movq	$0x2dc6cb, 0x18(%rbp)   # imm = 0x2DC6CB
180004f47:     	jmp	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
180004f49:     	decq	0x8(%rbp)
180004f4d:     	movq	0x118(%rsp), %rcx
180004f55:     	movq	%r12, %r9
180004f58:     	movq	0x128(%rsp), %r8
180004f60:     	movq	0x20(%rbx,%rdi,8), %rax
180004f65:     	testq	%rax, %rax
180004f68:     	jns	0x180004b57 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfc7>
180004f6e:     	movb	$0x1, (%r13)
180004f73:     	movq	$0x2dc6cd, 0x18(%rbp)   # imm = 0x2DC6CD
180004f7b:     	xorl	%r12d, %r12d
180004f7e:     	andb	$0x1, %r12b
180004f82:     	movb	%r12b, (%rcx)
180004f85:     	xorl	%eax, %eax
180004f87:     	addq	$0x178, %rsp            # imm = 0x178
180004f8e:     	popq	%rbx
180004f8f:     	popq	%rbp
180004f90:     	popq	%rdi
180004f91:     	popq	%rsi
180004f92:     	popq	%r12
180004f94:     	popq	%r13
180004f96:     	popq	%r14
180004f98:     	popq	%r15
180004f9a:     	retq
180004f9b:     	movb	$0x0, 0x126(%rsp)
180004fa3:     	movq	%rsi, 0x100(%rsp)
180004fab:     	movq	%rax, 0xf8(%rsp)
180004fb3:     	movq	0x2a8(%rsp), %rax
180004fbb:     	movq	%rax, 0xe8(%rsp)
180004fc3:     	movq	0x2a0(%rsp), %rax
180004fcb:     	movq	%rax, 0xe0(%rsp)
180004fd3:     	movq	%r13, 0xd8(%rsp)
180004fdb:     	movq	0x290(%rsp), %rax
180004fe3:     	movq	%rax, 0xd0(%rsp)
180004feb:     	movq	0x288(%rsp), %rax
180004ff3:     	movq	%rax, 0xc8(%rsp)
180004ffb:     	movq	0x280(%rsp), %rax
180005003:     	movq	%rax, 0xc0(%rsp)
18000500b:     	movq	0x278(%rsp), %rax
180005013:     	movq	%rax, 0xb8(%rsp)
18000501b:     	movq	0x270(%rsp), %rax
180005023:     	movq	%rax, 0xb0(%rsp)
18000502b:     	movq	0x268(%rsp), %rax
180005033:     	movq	%rax, 0xa8(%rsp)
18000503b:     	movq	%rbp, 0xa0(%rsp)
180005043:     	movq	0x258(%rsp), %rax
18000504b:     	movq	%rax, 0x98(%rsp)
180005053:     	movq	0x250(%rsp), %rax
18000505b:     	movq	%rax, 0x90(%rsp)
180005063:     	movq	0x248(%rsp), %rax
18000506b:     	movq	%rax, 0x88(%rsp)
180005073:     	movq	0x240(%rsp), %rax
18000507b:     	movq	%rax, 0x80(%rsp)
180005083:     	movq	0x238(%rsp), %rax
18000508b:     	movq	%rax, 0x78(%rsp)
180005090:     	movq	%r15, 0x70(%rsp)
180005095:     	movq	%rbx, 0x68(%rsp)
18000509a:     	movq	0x220(%rsp), %rax
1800050a2:     	movq	%rax, 0x60(%rsp)
1800050a7:     	movq	0x218(%rsp), %rax
1800050af:     	movq	%rax, 0x58(%rsp)
1800050b4:     	movq	0x210(%rsp), %rax
1800050bc:     	movq	%rax, 0x50(%rsp)
1800050c1:     	movq	0x208(%rsp), %rax
1800050c9:     	movq	%rax, 0x48(%rsp)
1800050ce:     	movq	0x200(%rsp), %rax
1800050d6:     	movq	%rax, 0x40(%rsp)
1800050db:     	movq	0x1f8(%rsp), %rax
1800050e3:     	movq	%rax, 0x38(%rsp)
1800050e8:     	movq	%r14, 0x30(%rsp)
1800050ed:     	movq	0x1e8(%rsp), %rax
1800050f5:     	movq	%rax, 0x28(%rsp)
1800050fa:     	movq	0x1e0(%rsp), %rax
180005102:     	movq	%rax, 0x20(%rsp)
180005107:     	movq	$-0x1, 0x108(%rsp)
180005113:     	movq	$0x0, 0xf0(%rsp)
18000511f:     	leaq	0x126(%rsp), %rcx
180005127:     	movq	0x128(%rsp), %r8
18000512f:     	movq	0x138(%rsp), %r9
180005137:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
18000513c:     	cmpb	$0x0, (%r13)
180005141:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005147:     	movq	0x8(%rbp), %rcx
18000514b:     	leaq	-0x1(%rcx), %rax
18000514f:     	cmpb	$0x0, 0x126(%rsp)
180005157:     	movq	%rax, 0x8(%rbp)
18000515b:     	je	0x18000553f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x19af>
180005161:     	movq	0x118(%rsp), %rcx
180005169:     	jmp	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
18000516e:     	movq	%r10, 0x160(%rsp)
180005176:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005180:     	andq	%rax, %rdx
180005183:     	movq	0x128(%rsp), %rax
18000518b:     	leaq	(%rbx,%rax,8), %rax
18000518f:     	movq	%rax, 0x150(%rsp)
180005197:     	leaq	(,%r15,8), %r12
18000519f:     	xorl	%r8d, %r8d
1800051a2:     	movq	%rdx, 0x138(%rsp)
1800051aa:     	leaq	(%r9,%r8), %r10
1800051ae:     	sarq	$0x3f, %r10
1800051b2:     	andq	%r12, %r10
1800051b5:     	leaq	(%rbx,%r9,8), %rsi
1800051b9:     	addq	%rsi, %r10
1800051bc:     	movq	(%r10,%r8,8), %r10
1800051c0:     	movq	0x128(%rsp), %rax
1800051c8:     	addq	%r8, %rax
1800051cb:     	sarq	$0x3f, %rax
1800051cf:     	andq	%r12, %rax
1800051d2:     	movq	0x150(%rsp), %r13
1800051da:     	addq	%r13, %rax
1800051dd:     	movq	%r10, (%rax,%r8,8)
1800051e1:     	leaq	0x1(%r9,%r8), %rax
1800051e6:     	sarq	$0x3f, %rax
1800051ea:     	andq	%r12, %rax
1800051ed:     	addq	%rsi, %rax
1800051f0:     	movq	0x8(%rax,%r8,8), %rax
1800051f5:     	movq	0x128(%rsp), %rdx
1800051fd:     	leaq	0x1(%rdx,%r8), %r10
180005202:     	sarq	$0x3f, %r10
180005206:     	andq	%r12, %r10
180005209:     	addq	%r13, %r10
18000520c:     	movq	%rax, 0x8(%r10,%r8,8)
180005211:     	leaq	0x2(%r9,%r8), %rax
180005216:     	sarq	$0x3f, %rax
18000521a:     	andq	%r12, %rax
18000521d:     	movq	%rsi, 0x118(%rsp)
180005225:     	addq	%rsi, %rax
180005228:     	movq	0x10(%rax,%r8,8), %rax
18000522d:     	leaq	0x2(%rdx,%r8), %r10
180005232:     	movq	%rdx, %rsi
180005235:     	sarq	$0x3f, %r10
180005239:     	andq	%r12, %r10
18000523c:     	addq	%r13, %r10
18000523f:     	movq	%rax, 0x10(%r10,%r8,8)
180005244:     	leaq	0x3(%r9,%r8), %rax
180005249:     	sarq	$0x3f, %rax
18000524d:     	andq	%r12, %rax
180005250:     	addq	0x118(%rsp), %rax
180005258:     	movq	0x18(%rax,%r8,8), %rax
18000525d:     	leaq	0x3(%rdx,%r8), %r10
180005262:     	sarq	$0x3f, %r10
180005266:     	andq	%r12, %r10
180005269:     	addq	%r13, %r10
18000526c:     	movq	%rax, 0x18(%r10,%r8,8)
180005271:     	leaq	0x4(%r9,%r8), %rax
180005276:     	sarq	$0x3f, %rax
18000527a:     	andq	%r12, %rax
18000527d:     	addq	0x118(%rsp), %rax
180005285:     	movq	0x20(%rax,%r8,8), %rax
18000528a:     	leaq	0x4(%rsi,%r8), %r10
18000528f:     	sarq	$0x3f, %r10
180005293:     	andq	%r12, %r10
180005296:     	addq	%r13, %r10
180005299:     	movq	%r13, %rsi
18000529c:     	movq	%rax, 0x20(%r10,%r8,8)
1800052a1:     	leaq	0x5(%r9,%r8), %rax
1800052a6:     	sarq	$0x3f, %rax
1800052aa:     	andq	%r12, %rax
1800052ad:     	addq	0x118(%rsp), %rax
1800052b5:     	movq	0x28(%rax,%r8,8), %rax
1800052ba:     	leaq	0x5(%rdx,%r8), %r10
1800052bf:     	movq	%rdx, %r13
1800052c2:     	sarq	$0x3f, %r10
1800052c6:     	andq	%r12, %r10
1800052c9:     	addq	%rsi, %r10
1800052cc:     	movq	%rax, 0x28(%r10,%r8,8)
1800052d1:     	leaq	0x6(%r9,%r8), %rax
1800052d6:     	sarq	$0x3f, %rax
1800052da:     	andq	%r12, %rax
1800052dd:     	addq	0x118(%rsp), %rax
1800052e5:     	movq	0x30(%rax,%r8,8), %rax
1800052ea:     	leaq	0x6(%rdx,%r8), %r10
1800052ef:     	sarq	$0x3f, %r10
1800052f3:     	andq	%r12, %r10
1800052f6:     	addq	%rsi, %r10
1800052f9:     	movq	%rax, 0x30(%r10,%r8,8)
1800052fe:     	leaq	0x7(%r9,%r8), %rax
180005303:     	sarq	$0x3f, %rax
180005307:     	andq	%r12, %rax
18000530a:     	addq	0x118(%rsp), %rax
180005312:     	movq	0x138(%rsp), %rdx
18000531a:     	movq	0x38(%rax,%r8,8), %rax
18000531f:     	leaq	0x7(%r13,%r8), %r10
180005324:     	sarq	$0x3f, %r10
180005328:     	andq	%r12, %r10
18000532b:     	addq	%rsi, %r10
18000532e:     	movq	%rax, 0x38(%r10,%r8,8)
180005333:     	addq	$0x8, %r8
180005337:     	cmpq	%r8, %rdx
18000533a:     	jne	0x1800051aa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x161a>
180005340:     	movq	0x160(%rsp), %r10
180005348:     	testq	%r10, %r10
18000534b:     	movq	0x298(%rsp), %r13
180005353:     	movq	0x2c0(%rsp), %rsi
18000535b:     	je	0x18000539f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x180f>
18000535d:     	movq	0x128(%rsp), %rax
180005365:     	leaq	(%rdx,%rax), %r8
180005369:     	addq	%rdx, %r9
18000536c:     	movq	%r9, %rax
18000536f:     	sarq	$0x3f, %rax
180005373:     	andq	%r12, %rax
180005376:     	addq	%rbx, %rax
180005379:     	movq	(%rax,%r9,8), %rax
18000537d:     	movq	%r10, %rdx
180005380:     	movq	%r8, %r10
180005383:     	sarq	$0x3f, %r10
180005387:     	andq	%r12, %r10
18000538a:     	addq	%rbx, %r10
18000538d:     	movq	%rax, (%r10,%r8,8)
180005391:     	movq	%rdx, %r10
180005394:     	incq	%r8
180005397:     	incq	%r9
18000539a:     	decq	%r10
18000539d:     	jne	0x18000536c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x17dc>
18000539f:     	movq	0x158(%rsp), %rdx
1800053a7:     	leaq	(%rbx,%rdx,8), %rax
1800053ab:     	movq	0x170(%rsp), %r8
1800053b3:     	movq	0x168(%rsp), %r9
1800053bb:     	movq	%r9, 0x8(%rax,%r8,8)
1800053c0:     	movq	0x128(%rsp), %r8
1800053c8:     	movq	0x140(%rsp), %r9
1800053d0:     	movq	%r8, 0x10(%rax,%r9,8)
1800053d5:     	movq	0x148(%rsp), %r10
1800053dd:     	movq	%rax, %r8
1800053e0:     	leaq	0x1(%r10), %rax
1800053e4:     	movq	%rax, (%r8,%r11,8)
1800053e8:     	cmpb	$0x0, (%r13)
1800053ed:     	jne	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
1800053f3:     	xorl	%eax, %eax
1800053f5:     	cmpq	$-0x2, %rdx
1800053f9:     	cmovlq	%r15, %rax
1800053fd:     	addq	0x10(%r8,%rax,8), %r10
180005402:     	movq	%r10, %rax
180005405:     	sarq	$0x3f, %rax
180005409:     	andq	%r15, %rax
18000540c:     	leaq	(%rbx,%r10,8), %rdx
180005410:     	movq	%rsi, (%rdx,%rax,8)
180005414:     	movsd	0x48(%r14,%rdi,8), %xmm2
18000541b:     	movsd	0x8(%r14,%rsi,8), %xmm1
180005422:     	movapd	%xmm2, %xmm0
180005426:     	addsd	%xmm1, %xmm0
18000542a:     	xorpd	%xmm3, %xmm3
18000542e:     	ucomisd	%xmm3, %xmm0
180005432:     	jbe	0x180005503 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1973>
180005438:     	movq	0x10(%rbx,%rdi,8), %rax
18000543d:     	cmpq	$0x0, 0x8(%rbx,%rax,8)
180005443:     	mulsd	(%r14,%rax,8), %xmm2
180005449:     	je	0x180005475 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x18e5>
18000544b:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
180005451:     	je	0x180005475 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x18e5>
180005453:     	movapd	0x7f65(%rip), %xmm3     # 0x18000d3c0
18000545b:     	andpd	%xmm2, %xmm3
18000545f:     	ucomisd	0x7f69(%rip), %xmm3     # 0x18000d3d0
180005467:     	jae	0x180005521 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1991>
18000546d:     	xorpd	%xmm3, %xmm3
180005471:     	addsd	%xmm3, %xmm2
180005475:     	movq	0x10(%rbx,%rsi,8), %rdx
18000547a:     	mulsd	(%r14,%rdx,8), %xmm1
180005480:     	addsd	%xmm2, %xmm1
180005484:     	divsd	%xmm0, %xmm1
180005488:     	movsd	%xmm1, (%r14,%rax,8)
18000548e:     	movq	$0x0, 0x8(%rbx,%rax,8)
180005497:     	movq	0x10(%rbx,%rdi,8), %rax
18000549c:     	movsd	0x10(%r14,%rax,8), %xmm1
1800054a3:     	cmpq	$0x0, 0x18(%rbx,%rax,8)
1800054a9:     	mulsd	0x48(%r14,%rdi,8), %xmm1
1800054b0:     	je	0x1800054d8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1948>
1800054b2:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
1800054b8:     	je	0x1800054d8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1948>
1800054ba:     	movapd	0x7efe(%rip), %xmm2     # 0x18000d3c0
1800054c2:     	andpd	%xmm1, %xmm2
1800054c6:     	ucomisd	0x7f02(%rip), %xmm2     # 0x18000d3d0
1800054ce:     	jae	0x180005530 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x19a0>
1800054d0:     	xorpd	%xmm2, %xmm2
1800054d4:     	addsd	%xmm2, %xmm1
1800054d8:     	movq	0x10(%rbx,%rsi,8), %rdx
1800054dd:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800054e4:     	mulsd	0x8(%r14,%rsi,8), %xmm2
1800054eb:     	addsd	%xmm1, %xmm2
1800054ef:     	divsd	%xmm0, %xmm2
1800054f3:     	movsd	%xmm2, 0x10(%r14,%rax,8)
1800054fa:     	movq	$0x0, 0x18(%rbx,%rax,8)
180005503:     	movsd	%xmm0, 0x48(%r14,%rdi,8)
18000550a:     	movq	$0x0, 0x50(%rbx,%rdi,8)
180005513:     	cmpb	$0x0, (%r13)
180005518:     	sete	%r12b
18000551c:     	jmp	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180005521:     	movb	$0x1, (%r13)
180005526:     	movq	$0x895447, 0x18(%rbp)   # imm = 0x895447
18000552e:     	jmp	0x180005513 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1983>
180005530:     	movb	$0x1, (%r13)
180005535:     	movq	$0x895449, 0x18(%rbp)   # imm = 0x895449
18000553d:     	jmp	0x180005513 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1983>
18000553f:     	movq	0x38(%rbx,%rdi,8), %rax
180005544:     	testq	%rax, %rax
180005547:     	js	0x18000556b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x19db>
180005549:     	movq	%rcx, 0x8(%rbp)
18000554d:     	cmpq	0x10(%rbp), %rcx
180005551:     	jle	0x18000557d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x19ed>
180005553:     	movq	0x298(%rsp), %rax
18000555b:     	movb	$0x1, (%rax)
18000555e:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180005566:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000556b:     	movb	$0x1, (%r13)
180005570:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180005578:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000557d:     	movb	$0x0, 0x125(%rsp)
180005585:     	movq	%rsi, 0x100(%rsp)
18000558d:     	movq	%rax, 0xf8(%rsp)
180005595:     	movq	0x2a8(%rsp), %rax
18000559d:     	movq	%rax, 0xe8(%rsp)
1800055a5:     	movq	0x2a0(%rsp), %rax
1800055ad:     	movq	%rax, 0xe0(%rsp)
1800055b5:     	movq	0x298(%rsp), %r13
1800055bd:     	movq	%r13, 0xd8(%rsp)
1800055c5:     	movq	0x290(%rsp), %rax
1800055cd:     	movq	%rax, 0xd0(%rsp)
1800055d5:     	movq	0x288(%rsp), %rax
1800055dd:     	movq	%rax, 0xc8(%rsp)
1800055e5:     	movq	0x280(%rsp), %rax
1800055ed:     	movq	%rax, 0xc0(%rsp)
1800055f5:     	movq	0x278(%rsp), %rax
1800055fd:     	movq	%rax, 0xb8(%rsp)
180005605:     	movq	0x270(%rsp), %rax
18000560d:     	movq	%rax, 0xb0(%rsp)
180005615:     	movq	0x268(%rsp), %rax
18000561d:     	movq	%rax, 0xa8(%rsp)
180005625:     	movq	%rbp, 0xa0(%rsp)
18000562d:     	movq	0x258(%rsp), %rax
180005635:     	movq	%rax, 0x98(%rsp)
18000563d:     	movq	0x250(%rsp), %rax
180005645:     	movq	%rax, 0x90(%rsp)
18000564d:     	movq	0x248(%rsp), %rax
180005655:     	movq	%rax, 0x88(%rsp)
18000565d:     	movq	0x240(%rsp), %rax
180005665:     	movq	%rax, 0x80(%rsp)
18000566d:     	movq	0x238(%rsp), %rax
180005675:     	movq	%rax, 0x78(%rsp)
18000567a:     	movq	%r15, 0x70(%rsp)
18000567f:     	movq	%rbx, 0x68(%rsp)
180005684:     	movq	0x220(%rsp), %rax
18000568c:     	movq	%rax, 0x60(%rsp)
180005691:     	movq	0x218(%rsp), %rax
180005699:     	movq	%rax, 0x58(%rsp)
18000569e:     	movq	0x210(%rsp), %rax
1800056a6:     	movq	%rax, 0x50(%rsp)
1800056ab:     	movq	0x208(%rsp), %rax
1800056b3:     	movq	%rax, 0x48(%rsp)
1800056b8:     	movq	0x200(%rsp), %rax
1800056c0:     	movq	%rax, 0x40(%rsp)
1800056c5:     	movq	0x1f8(%rsp), %rax
1800056cd:     	movq	%rax, 0x38(%rsp)
1800056d2:     	movq	%r14, 0x30(%rsp)
1800056d7:     	movq	0x1e8(%rsp), %rax
1800056df:     	movq	%rax, 0x28(%rsp)
1800056e4:     	movq	0x1e0(%rsp), %rax
1800056ec:     	movq	%rax, 0x20(%rsp)
1800056f1:     	movq	$-0x1, 0x108(%rsp)
1800056fd:     	movq	$0x0, 0xf0(%rsp)
180005709:     	leaq	0x125(%rsp), %rcx
180005711:     	movq	0x128(%rsp), %r8
180005719:     	movq	0x138(%rsp), %r9
180005721:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180005726:     	cmpb	$0x0, (%r13)
18000572b:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005731:     	movq	0x8(%rbp), %rax
180005735:     	leaq	-0x1(%rax), %rcx
180005739:     	cmpb	$0x0, 0x125(%rsp)
180005741:     	movq	%rcx, 0x8(%rbp)
180005745:     	movq	0x118(%rsp), %rcx
18000574d:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180005753:     	movq	0x40(%rbx,%rdi,8), %rcx
180005758:     	testq	%rcx, %rcx
18000575b:     	js	0x18000576b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1bdb>
18000575d:     	movq	%rax, 0x8(%rbp)
180005761:     	cmpq	0x10(%rbp), %rax
180005765:     	jle	0x1800064b8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2928>
18000576b:     	movq	0x298(%rsp), %rax
180005773:     	movb	$0x1, (%rax)
180005776:     	movq	$0x2dc6d0, 0x18(%rbp)   # imm = 0x2DC6D0
18000577e:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005783:     	movq	%rax, (%rbp)
180005787:     	cmpb	$0x0, (%rsi)
18000578a:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005790:     	subsd	%xmm3, %xmm1
180005794:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
18000579b:     	movsd	%xmm5, 0x18(%r14,%rcx,8)
1800057a2:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
1800057a9:     	movsd	%xmm0, (%r14,%rcx,8)
1800057af:     	cmpb	$0x0, (%rsi)
1800057b2:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800057b8:     	movq	(%rbp), %rax
1800057bc:     	leaq	0xb(%rax), %r8
1800057c0:     	cmpq	%r15, %r8
1800057c3:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
1800057c9:     	movq	0x2c8(%rsp), %rdx
1800057d1:     	movq	0x8(%rbx,%rdx,8), %rdx
1800057d6:     	movq	%r8, (%rbp)
1800057da:     	cmpb	$0x0, (%rsi)
1800057dd:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800057e3:     	movq	%rcx, (%rbx,%rax,8)
1800057e7:     	movq	%rdx, 0x8(%rbx,%rax,8)
1800057ec:     	movq	(%rbp), %rdx
1800057f0:     	cmpq	%r15, %rdx
1800057f3:     	movq	%rdx, %rcx
1800057f6:     	jle	0x180005801 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1c71>
1800057f8:     	movb	$0x2, (%rsi)
1800057fb:     	movq	(%rbp), %rdx
1800057ff:     	xorl	%ecx, %ecx
180005801:     	leaq	0x3(%rdx), %r8
180005805:     	cmpq	%r15, %r8
180005808:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
18000580e:     	movq	%r8, (%rbp)
180005812:     	cmpb	$0x0, (%rsi)
180005815:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000581b:     	movq	%rdx, %r8
18000581e:     	sarq	$0x3f, %r8
180005822:     	andq	%r15, %r8
180005825:     	leaq	(%rbx,%rdx,8), %r9
180005829:     	movq	$0x0, (%r9,%r8,8)
180005831:     	xorl	%r12d, %r12d
180005834:     	cmpq	$-0x1, %rdx
180005838:     	movl	$0x0, %r8d
18000583e:     	cmovlq	%r15, %r8
180005842:     	movq	$0x0, 0x8(%r9,%r8,8)
18000584b:     	cmpq	$-0x2, %rdx
18000584f:     	movl	$0x0, %r8d
180005855:     	cmovlq	%r15, %r8
180005859:     	movq	%rcx, 0x10(%r9,%r8,8)
18000585e:     	cmpb	$0x0, (%rsi)
180005861:     	movq	0x118(%rsp), %rcx
180005869:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
18000586f:     	leaq	(%rbx,%rax,8), %rcx
180005873:     	movq	%rdx, 0x30(%rcx)
180005877:     	movq	$0x0, 0x18(%rcx)
18000587f:     	movq	(%rbp), %rdx
180005883:     	leaq	0x4(%rdx), %r8
180005887:     	cmpq	%r15, %r8
18000588a:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005890:     	movq	%r8, (%rbp)
180005894:     	cmpb	$0x0, (%rsi)
180005897:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000589d:     	movq	$0x0, (%r14,%rdx,8)
1800058a5:     	movq	$0x1, 0x8(%rbx,%rdx,8)
1800058ae:     	movq	$0x0, 0x10(%r14,%rdx,8)
1800058b7:     	movq	$0x1, 0x18(%rbx,%rdx,8)
1800058c0:     	cmpb	$0x0, (%rsi)
1800058c3:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800058c9:     	movq	%rdx, 0x10(%rcx)
1800058cd:     	movq	$0x0, 0x48(%r14,%rax,8)
1800058d6:     	movq	$0x1, 0x50(%rcx)
1800058de:     	movq	$-0x1, 0x20(%rcx)
1800058e6:     	movq	$-0x1, 0x28(%rcx)
1800058ee:     	movq	$-0x1, 0x38(%rcx)
1800058f6:     	movq	$-0x1, 0x40(%rcx)
1800058fe:     	cmpb	$0x0, (%rsi)
180005901:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005907:     	movq	0x2c8(%rsp), %rcx
18000590f:     	movq	%rax, 0x28(%rbx,%rcx,8)
180005914:     	movq	(%rbp), %rcx
180005918:     	leaq	0x4(%rcx), %rax
18000591c:     	cmpq	%r15, %rax
18000591f:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005925:     	movq	%rax, (%rbp)
180005929:     	cmpb	$0x0, (%rsi)
18000592c:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005932:     	addsd	%xmm0, %xmm2
180005936:     	movsd	%xmm4, 0x10(%r14,%rcx,8)
18000593d:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005944:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
18000594b:     	movsd	%xmm0, (%r14,%rcx,8)
180005951:     	cmpb	$0x0, (%rsi)
180005954:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000595a:     	movq	(%rbp), %rax
18000595e:     	leaq	0xb(%rax), %r8
180005962:     	cmpq	%r15, %r8
180005965:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
18000596b:     	movq	0x2c8(%rsp), %rdx
180005973:     	movq	0x8(%rbx,%rdx,8), %rdx
180005978:     	movq	%r8, (%rbp)
18000597c:     	cmpb	$0x0, (%rsi)
18000597f:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005985:     	movq	%rcx, (%rbx,%rax,8)
180005989:     	movq	%rdx, 0x8(%rbx,%rax,8)
18000598e:     	movq	(%rbp), %rdx
180005992:     	cmpq	%r15, %rdx
180005995:     	movq	%rdx, %rcx
180005998:     	jle	0x1800059a3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1e13>
18000599a:     	movb	$0x2, (%rsi)
18000599d:     	movq	(%rbp), %rdx
1800059a1:     	xorl	%ecx, %ecx
1800059a3:     	leaq	0x3(%rdx), %r8
1800059a7:     	cmpq	%r15, %r8
1800059aa:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
1800059b0:     	movq	%r8, (%rbp)
1800059b4:     	cmpb	$0x0, (%rsi)
1800059b7:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800059bd:     	movq	%rdx, %r8
1800059c0:     	sarq	$0x3f, %r8
1800059c4:     	andq	%r15, %r8
1800059c7:     	leaq	(%rbx,%rdx,8), %r9
1800059cb:     	movq	$0x0, (%r9,%r8,8)
1800059d3:     	xorl	%r12d, %r12d
1800059d6:     	cmpq	$-0x1, %rdx
1800059da:     	movl	$0x0, %r8d
1800059e0:     	cmovlq	%r15, %r8
1800059e4:     	movq	$0x0, 0x8(%r9,%r8,8)
1800059ed:     	cmpq	$-0x2, %rdx
1800059f1:     	movl	$0x0, %r8d
1800059f7:     	cmovlq	%r15, %r8
1800059fb:     	movq	%rcx, 0x10(%r9,%r8,8)
180005a00:     	cmpb	$0x0, (%rsi)
180005a03:     	movq	0x118(%rsp), %rcx
180005a0b:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180005a11:     	leaq	(%rbx,%rax,8), %rcx
180005a15:     	movq	%rdx, 0x30(%rcx)
180005a19:     	movq	$0x0, 0x18(%rcx)
180005a21:     	movq	(%rbp), %rdx
180005a25:     	leaq	0x4(%rdx), %r8
180005a29:     	cmpq	%r15, %r8
180005a2c:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005a32:     	movq	%r8, (%rbp)
180005a36:     	cmpb	$0x0, (%rsi)
180005a39:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005a3f:     	movq	$0x0, (%r14,%rdx,8)
180005a47:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005a50:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005a59:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005a62:     	cmpb	$0x0, (%rsi)
180005a65:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005a6b:     	movq	%rdx, 0x10(%rcx)
180005a6f:     	movq	$0x0, 0x48(%r14,%rax,8)
180005a78:     	movq	$0x1, 0x50(%rcx)
180005a80:     	movq	$-0x1, 0x20(%rcx)
180005a88:     	movq	$-0x1, 0x28(%rcx)
180005a90:     	movq	$-0x1, 0x38(%rcx)
180005a98:     	movq	$-0x1, 0x40(%rcx)
180005aa0:     	cmpb	$0x0, (%rsi)
180005aa3:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005aa9:     	movq	0x2c8(%rsp), %rcx
180005ab1:     	movq	%rax, 0x38(%rbx,%rcx,8)
180005ab6:     	movq	(%rbp), %rcx
180005aba:     	leaq	0x4(%rcx), %rax
180005abe:     	cmpq	%r15, %rax
180005ac1:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005ac7:     	movq	%rax, (%rbp)
180005acb:     	cmpb	$0x0, (%rsi)
180005ace:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005ad4:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
180005adb:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005ae2:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005ae9:     	movsd	%xmm0, (%r14,%rcx,8)
180005aef:     	cmpb	$0x0, (%rsi)
180005af2:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005af8:     	movq	(%rbp), %rax
180005afc:     	leaq	0xb(%rax), %r8
180005b00:     	cmpq	%r15, %r8
180005b03:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005b09:     	movq	0x2c8(%rsp), %rdx
180005b11:     	movq	0x8(%rbx,%rdx,8), %rdx
180005b16:     	movq	%r8, (%rbp)
180005b1a:     	cmpb	$0x0, (%rsi)
180005b1d:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005b23:     	movq	%rcx, (%rbx,%rax,8)
180005b27:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005b2c:     	movq	(%rbp), %rdx
180005b30:     	cmpq	%r15, %rdx
180005b33:     	movq	%rdx, %rcx
180005b36:     	jle	0x180005b41 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x1fb1>
180005b38:     	movb	$0x2, (%rsi)
180005b3b:     	movq	(%rbp), %rdx
180005b3f:     	xorl	%ecx, %ecx
180005b41:     	leaq	0x3(%rdx), %r8
180005b45:     	cmpq	%r15, %r8
180005b48:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005b4e:     	movq	%r8, (%rbp)
180005b52:     	cmpb	$0x0, (%rsi)
180005b55:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005b5b:     	movq	%rdx, %r8
180005b5e:     	sarq	$0x3f, %r8
180005b62:     	andq	%r15, %r8
180005b65:     	leaq	(%rbx,%rdx,8), %r9
180005b69:     	movq	$0x0, (%r9,%r8,8)
180005b71:     	xorl	%r12d, %r12d
180005b74:     	cmpq	$-0x1, %rdx
180005b78:     	movl	$0x0, %r8d
180005b7e:     	cmovlq	%r15, %r8
180005b82:     	movq	$0x0, 0x8(%r9,%r8,8)
180005b8b:     	cmpq	$-0x2, %rdx
180005b8f:     	movl	$0x0, %r8d
180005b95:     	cmovlq	%r15, %r8
180005b99:     	movq	%rcx, 0x10(%r9,%r8,8)
180005b9e:     	cmpb	$0x0, (%rsi)
180005ba1:     	movq	0x118(%rsp), %rcx
180005ba9:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
180005baf:     	leaq	(%rbx,%rax,8), %rcx
180005bb3:     	movq	%rdx, 0x30(%rcx)
180005bb7:     	movq	$0x0, 0x18(%rcx)
180005bbf:     	movq	(%rbp), %rdx
180005bc3:     	leaq	0x4(%rdx), %r8
180005bc7:     	cmpq	%r15, %r8
180005bca:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
180005bd0:     	movq	%r8, (%rbp)
180005bd4:     	cmpb	$0x0, (%rsi)
180005bd7:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005bdd:     	movq	$0x0, (%r14,%rdx,8)
180005be5:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005bee:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005bf7:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005c00:     	cmpb	$0x0, (%rsi)
180005c03:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005c09:     	movq	%rdx, 0x10(%rcx)
180005c0d:     	movq	$0x0, 0x48(%r14,%rax,8)
180005c16:     	movq	$0x1, 0x50(%rcx)
180005c1e:     	movq	$-0x1, 0x20(%rcx)
180005c26:     	movq	$-0x1, 0x28(%rcx)
180005c2e:     	movq	$-0x1, 0x38(%rcx)
180005c36:     	movq	$-0x1, 0x40(%rcx)
180005c3e:     	cmpb	$0x0, (%rsi)
180005c41:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005c47:     	movq	0x2c8(%rsp), %rcx
180005c4f:     	movq	%rax, 0x40(%rbx,%rcx,8)
180005c54:     	movq	$0x1, 0x18(%rbx,%rcx,8)
180005c5d:     	movq	0x30(%rbx,%rcx,8), %rax
180005c62:     	movq	%rax, %rcx
180005c65:     	sarq	$0x3f, %rcx
180005c69:     	andq	%r15, %rcx
180005c6c:     	leaq	(%rbx,%rax,8), %rdx
180005c70:     	movq	%rcx, 0x148(%rsp)
180005c78:     	movq	%rdx, 0x150(%rsp)
180005c80:     	cmpq	$0x0, (%rdx,%rcx,8)
180005c85:     	jle	0x18000642a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x289a>
180005c8b:     	leaq	(,%r15,8), %rcx
180005c93:     	xorl	%r13d, %r13d
180005c96:     	cmpq	$-0x2, %rax
180005c9a:     	cmovgeq	%r13, %rcx
180005c9e:     	movq	%rcx, 0x140(%rsp)
180005ca6:     	movq	0x2c8(%rsp), %rax
180005cae:     	movq	0x20(%rbx,%rax,8), %rax
180005cb3:     	testq	%rax, %rax
180005cb6:     	js	0x18000667c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2aec>
180005cbc:     	movq	0x150(%rsp), %rcx
180005cc4:     	movq	0x140(%rsp), %rdx
180005ccc:     	movq	0x10(%rcx,%rdx), %rcx
180005cd1:     	addq	%r13, %rcx
180005cd4:     	leaq	(%rbx,%rcx,8), %rdx
180005cd8:     	sarq	$0x3f, %rcx
180005cdc:     	andq	%r15, %rcx
180005cdf:     	movq	(%rdx,%rcx,8), %r12
180005ce3:     	movq	0x8(%rbp), %rcx
180005ce7:     	leaq	0x1(%rcx), %rdx
180005ceb:     	movq	%rdx, 0x8(%rbp)
180005cef:     	cmpq	0x10(%rbp), %rcx
180005cf3:     	jge	0x18000667c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2aec>
180005cf9:     	movq	%r12, 0x100(%rsp)
180005d01:     	movq	%rax, 0xf8(%rsp)
180005d09:     	movq	0x2a8(%rsp), %rax
180005d11:     	movq	%rax, 0xe8(%rsp)
180005d19:     	movq	0x2a0(%rsp), %rax
180005d21:     	movq	%rax, 0xe0(%rsp)
180005d29:     	movq	%rsi, 0xd8(%rsp)
180005d31:     	movq	0x290(%rsp), %rax
180005d39:     	movq	%rax, 0xd0(%rsp)
180005d41:     	movq	0x288(%rsp), %rax
180005d49:     	movq	%rax, 0xc8(%rsp)
180005d51:     	movq	0x280(%rsp), %rax
180005d59:     	movq	%rax, 0xc0(%rsp)
180005d61:     	movq	0x278(%rsp), %rax
180005d69:     	movq	%rax, 0xb8(%rsp)
180005d71:     	movq	0x270(%rsp), %rax
180005d79:     	movq	%rax, 0xb0(%rsp)
180005d81:     	movq	0x268(%rsp), %rax
180005d89:     	movq	%rax, 0xa8(%rsp)
180005d91:     	movq	%rbp, 0xa0(%rsp)
180005d99:     	movq	%rdi, 0x98(%rsp)
180005da1:     	movq	0x250(%rsp), %rax
180005da9:     	movq	%rax, 0x90(%rsp)
180005db1:     	movq	0x248(%rsp), %rax
180005db9:     	movq	%rax, 0x88(%rsp)
180005dc1:     	movq	0x240(%rsp), %rax
180005dc9:     	movq	%rax, 0x80(%rsp)
180005dd1:     	movq	0x238(%rsp), %rax
180005dd9:     	movq	%rax, 0x78(%rsp)
180005dde:     	movq	%r15, 0x70(%rsp)
180005de3:     	movq	%rbx, 0x68(%rsp)
180005de8:     	movq	0x220(%rsp), %rax
180005df0:     	movq	%rax, 0x60(%rsp)
180005df5:     	movq	0x218(%rsp), %rax
180005dfd:     	movq	%rax, 0x58(%rsp)
180005e02:     	movq	0x210(%rsp), %rax
180005e0a:     	movq	%rax, 0x50(%rsp)
180005e0f:     	movq	0x208(%rsp), %rax
180005e17:     	movq	%rax, 0x48(%rsp)
180005e1c:     	movq	0x200(%rsp), %rax
180005e24:     	movq	%rax, 0x40(%rsp)
180005e29:     	movq	0x1f8(%rsp), %rax
180005e31:     	movq	%rax, 0x38(%rsp)
180005e36:     	movq	%r14, 0x30(%rsp)
180005e3b:     	movq	0x1e8(%rsp), %rax
180005e43:     	movq	%rax, 0x28(%rsp)
180005e48:     	movq	0x1e0(%rsp), %rax
180005e50:     	movq	%rax, 0x20(%rsp)
180005e55:     	movq	$-0x1, 0x108(%rsp)
180005e61:     	movq	$0x0, 0xf0(%rsp)
180005e6d:     	leaq	0x136(%rsp), %rcx
180005e75:     	movq	0x128(%rsp), %r8
180005e7d:     	movq	0x138(%rsp), %r9
180005e85:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180005e8a:     	movq	0x298(%rsp), %rax
180005e92:     	cmpb	$0x0, (%rax)
180005e95:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180005e9b:     	movq	0x8(%rbp), %rcx
180005e9f:     	leaq	-0x1(%rcx), %rax
180005ea3:     	movq	%rax, 0x8(%rbp)
180005ea7:     	movq	0x2c8(%rsp), %rax
180005eaf:     	movq	0x28(%rbx,%rax,8), %rax
180005eb4:     	testq	%rax, %rax
180005eb7:     	js	0x18000668c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2afc>
180005ebd:     	movq	%rcx, 0x8(%rbp)
180005ec1:     	cmpq	0x10(%rbp), %rcx
180005ec5:     	jg	0x18000668c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2afc>
180005ecb:     	movq	%r12, 0x100(%rsp)
180005ed3:     	movq	%rax, 0xf8(%rsp)
180005edb:     	movq	0x2a8(%rsp), %rax
180005ee3:     	movq	%rax, 0xe8(%rsp)
180005eeb:     	movq	0x2a0(%rsp), %rax
180005ef3:     	movq	%rax, 0xe0(%rsp)
180005efb:     	movq	%rsi, 0xd8(%rsp)
180005f03:     	movq	0x290(%rsp), %rax
180005f0b:     	movq	%rax, 0xd0(%rsp)
180005f13:     	movq	0x288(%rsp), %rax
180005f1b:     	movq	%rax, 0xc8(%rsp)
180005f23:     	movq	0x280(%rsp), %rax
180005f2b:     	movq	%rax, 0xc0(%rsp)
180005f33:     	movq	0x278(%rsp), %rax
180005f3b:     	movq	%rax, 0xb8(%rsp)
180005f43:     	movq	0x270(%rsp), %rax
180005f4b:     	movq	%rax, 0xb0(%rsp)
180005f53:     	movq	0x268(%rsp), %rax
180005f5b:     	movq	%rax, 0xa8(%rsp)
180005f63:     	movq	%rbp, 0xa0(%rsp)
180005f6b:     	movq	%rdi, 0x98(%rsp)
180005f73:     	movq	0x250(%rsp), %rax
180005f7b:     	movq	%rax, 0x90(%rsp)
180005f83:     	movq	0x248(%rsp), %rax
180005f8b:     	movq	%rax, 0x88(%rsp)
180005f93:     	movq	0x240(%rsp), %rax
180005f9b:     	movq	%rax, 0x80(%rsp)
180005fa3:     	movq	0x238(%rsp), %rax
180005fab:     	movq	%rax, 0x78(%rsp)
180005fb0:     	movq	%r15, 0x70(%rsp)
180005fb5:     	movq	%rbx, 0x68(%rsp)
180005fba:     	movq	0x220(%rsp), %rax
180005fc2:     	movq	%rax, 0x60(%rsp)
180005fc7:     	movq	0x218(%rsp), %rax
180005fcf:     	movq	%rax, 0x58(%rsp)
180005fd4:     	movq	0x210(%rsp), %rax
180005fdc:     	movq	%rax, 0x50(%rsp)
180005fe1:     	movq	0x208(%rsp), %rax
180005fe9:     	movq	%rax, 0x48(%rsp)
180005fee:     	movq	0x200(%rsp), %rax
180005ff6:     	movq	%rax, 0x40(%rsp)
180005ffb:     	movq	0x1f8(%rsp), %rax
180006003:     	movq	%rax, 0x38(%rsp)
180006008:     	movq	%r14, 0x30(%rsp)
18000600d:     	movq	0x1e8(%rsp), %rax
180006015:     	movq	%rax, 0x28(%rsp)
18000601a:     	movq	0x1e0(%rsp), %rax
180006022:     	movq	%rax, 0x20(%rsp)
180006027:     	movq	$-0x1, 0x108(%rsp)
180006033:     	movq	$0x0, 0xf0(%rsp)
18000603f:     	leaq	0x135(%rsp), %rcx
180006047:     	movq	0x128(%rsp), %r8
18000604f:     	movq	0x138(%rsp), %r9
180006057:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
18000605c:     	movq	0x298(%rsp), %rax
180006064:     	cmpb	$0x0, (%rax)
180006067:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000606d:     	movq	0x8(%rbp), %rcx
180006071:     	leaq	-0x1(%rcx), %rax
180006075:     	movq	%rax, 0x8(%rbp)
180006079:     	movq	0x2c8(%rsp), %rax
180006081:     	movq	0x38(%rbx,%rax,8), %rax
180006086:     	testq	%rax, %rax
180006089:     	js	0x18000669c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b0c>
18000608f:     	movq	%rcx, 0x8(%rbp)
180006093:     	cmpq	0x10(%rbp), %rcx
180006097:     	jg	0x18000669c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b0c>
18000609d:     	movq	%r12, 0x100(%rsp)
1800060a5:     	movq	%rax, 0xf8(%rsp)
1800060ad:     	movq	0x2a8(%rsp), %rax
1800060b5:     	movq	%rax, 0xe8(%rsp)
1800060bd:     	movq	0x2a0(%rsp), %rax
1800060c5:     	movq	%rax, 0xe0(%rsp)
1800060cd:     	movq	%rsi, 0xd8(%rsp)
1800060d5:     	movq	0x290(%rsp), %rax
1800060dd:     	movq	%rax, 0xd0(%rsp)
1800060e5:     	movq	0x288(%rsp), %rax
1800060ed:     	movq	%rax, 0xc8(%rsp)
1800060f5:     	movq	0x280(%rsp), %rax
1800060fd:     	movq	%rax, 0xc0(%rsp)
180006105:     	movq	0x278(%rsp), %rax
18000610d:     	movq	%rax, 0xb8(%rsp)
180006115:     	movq	0x270(%rsp), %rax
18000611d:     	movq	%rax, 0xb0(%rsp)
180006125:     	movq	0x268(%rsp), %rax
18000612d:     	movq	%rax, 0xa8(%rsp)
180006135:     	movq	%rbp, 0xa0(%rsp)
18000613d:     	movq	%rdi, 0x98(%rsp)
180006145:     	movq	0x250(%rsp), %rax
18000614d:     	movq	%rax, 0x90(%rsp)
180006155:     	movq	0x248(%rsp), %rax
18000615d:     	movq	%rax, 0x88(%rsp)
180006165:     	movq	0x240(%rsp), %rax
18000616d:     	movq	%rax, 0x80(%rsp)
180006175:     	movq	0x238(%rsp), %rax
18000617d:     	movq	%rax, 0x78(%rsp)
180006182:     	movq	%r15, 0x70(%rsp)
180006187:     	movq	%rbx, 0x68(%rsp)
18000618c:     	movq	0x220(%rsp), %rax
180006194:     	movq	%rax, 0x60(%rsp)
180006199:     	movq	0x218(%rsp), %rax
1800061a1:     	movq	%rax, 0x58(%rsp)
1800061a6:     	movq	0x210(%rsp), %rax
1800061ae:     	movq	%rax, 0x50(%rsp)
1800061b3:     	movq	0x208(%rsp), %rax
1800061bb:     	movq	%rax, 0x48(%rsp)
1800061c0:     	movq	0x200(%rsp), %rax
1800061c8:     	movq	%rax, 0x40(%rsp)
1800061cd:     	movq	0x1f8(%rsp), %rax
1800061d5:     	movq	%rax, 0x38(%rsp)
1800061da:     	movq	%r14, 0x30(%rsp)
1800061df:     	movq	0x1e8(%rsp), %rax
1800061e7:     	movq	%rax, 0x28(%rsp)
1800061ec:     	movq	0x1e0(%rsp), %rax
1800061f4:     	movq	%rax, 0x20(%rsp)
1800061f9:     	movq	$-0x1, 0x108(%rsp)
180006205:     	movq	$0x0, 0xf0(%rsp)
180006211:     	leaq	0x134(%rsp), %rcx
180006219:     	movq	0x128(%rsp), %r8
180006221:     	movq	0x138(%rsp), %r9
180006229:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
18000622e:     	movq	0x298(%rsp), %rax
180006236:     	cmpb	$0x0, (%rax)
180006239:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000623f:     	movq	0x8(%rbp), %rcx
180006243:     	leaq	-0x1(%rcx), %rax
180006247:     	movq	%rax, 0x8(%rbp)
18000624b:     	movq	0x2c8(%rsp), %rax
180006253:     	movq	0x40(%rbx,%rax,8), %rax
180006258:     	testq	%rax, %rax
18000625b:     	js	0x1800066ac <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b1c>
180006261:     	movq	%rcx, 0x8(%rbp)
180006265:     	cmpq	0x10(%rbp), %rcx
180006269:     	jg	0x1800066ac <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b1c>
18000626f:     	movq	%r12, 0x100(%rsp)
180006277:     	movq	%rax, 0xf8(%rsp)
18000627f:     	movq	0x2a8(%rsp), %rax
180006287:     	movq	%rax, 0xe8(%rsp)
18000628f:     	movq	0x2a0(%rsp), %rax
180006297:     	movq	%rax, 0xe0(%rsp)
18000629f:     	movq	%rsi, 0xd8(%rsp)
1800062a7:     	movq	0x290(%rsp), %rax
1800062af:     	movq	%rax, 0xd0(%rsp)
1800062b7:     	movq	0x288(%rsp), %rax
1800062bf:     	movq	%rax, 0xc8(%rsp)
1800062c7:     	movq	0x280(%rsp), %rax
1800062cf:     	movq	%rax, 0xc0(%rsp)
1800062d7:     	movq	0x278(%rsp), %rax
1800062df:     	movq	%rax, 0xb8(%rsp)
1800062e7:     	movq	0x270(%rsp), %rax
1800062ef:     	movq	%rax, 0xb0(%rsp)
1800062f7:     	movq	0x268(%rsp), %rax
1800062ff:     	movq	%rax, 0xa8(%rsp)
180006307:     	movq	%rbp, 0xa0(%rsp)
18000630f:     	movq	%rdi, 0x98(%rsp)
180006317:     	movq	0x250(%rsp), %rax
18000631f:     	movq	%rax, 0x90(%rsp)
180006327:     	movq	0x248(%rsp), %rax
18000632f:     	movq	%rax, 0x88(%rsp)
180006337:     	movq	0x240(%rsp), %rax
18000633f:     	movq	%rax, 0x80(%rsp)
180006347:     	movq	0x238(%rsp), %rax
18000634f:     	movq	%rax, 0x78(%rsp)
180006354:     	movq	%r15, 0x70(%rsp)
180006359:     	movq	%rbx, 0x68(%rsp)
18000635e:     	movq	0x220(%rsp), %rax
180006366:     	movq	%rax, 0x60(%rsp)
18000636b:     	movq	0x218(%rsp), %rax
180006373:     	movq	%rax, 0x58(%rsp)
180006378:     	movq	0x210(%rsp), %rax
180006380:     	movq	%rax, 0x50(%rsp)
180006385:     	movq	0x208(%rsp), %rax
18000638d:     	movq	%rax, 0x48(%rsp)
180006392:     	movq	0x200(%rsp), %rax
18000639a:     	movq	%rax, 0x40(%rsp)
18000639f:     	movq	0x1f8(%rsp), %rax
1800063a7:     	movq	%rax, 0x38(%rsp)
1800063ac:     	movq	%r14, 0x30(%rsp)
1800063b1:     	movq	0x1e8(%rsp), %rax
1800063b9:     	movq	%rax, 0x28(%rsp)
1800063be:     	movq	0x1e0(%rsp), %rax
1800063c6:     	movq	%rax, 0x20(%rsp)
1800063cb:     	movq	$-0x1, 0x108(%rsp)
1800063d7:     	movq	$0x0, 0xf0(%rsp)
1800063e3:     	leaq	0x133(%rsp), %rcx
1800063eb:     	movq	0x128(%rsp), %r8
1800063f3:     	movq	0x138(%rsp), %r9
1800063fb:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180006400:     	cmpb	$0x0, (%rsi)
180006403:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180006409:     	incq	%r13
18000640c:     	decq	0x8(%rbp)
180006410:     	movq	0x148(%rsp), %rax
180006418:     	movq	0x150(%rsp), %rcx
180006420:     	cmpq	(%rcx,%rax,8), %r13
180006424:     	jl	0x180005ca6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2116>
18000642a:     	movq	(%rbp), %rax
18000642e:     	cmpq	%r15, %rax
180006431:     	movq	%rax, %rcx
180006434:     	jle	0x18000643f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x28af>
180006436:     	movb	$0x2, (%rsi)
180006439:     	movq	(%rbp), %rax
18000643d:     	xorl	%ecx, %ecx
18000643f:     	leaq	0x3(%rax), %rdx
180006443:     	cmpq	%r15, %rdx
180006446:     	jg	0x180004b38 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xfa8>
18000644c:     	movq	%rdx, (%rbp)
180006450:     	cmpb	$0x0, (%rsi)
180006453:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
180006459:     	movq	%rax, %rdx
18000645c:     	sarq	$0x3f, %rdx
180006460:     	andq	%r15, %rdx
180006463:     	leaq	(%rbx,%rax,8), %r8
180006467:     	movq	$0x0, (%r8,%rdx,8)
18000646f:     	xorl	%r12d, %r12d
180006472:     	cmpq	$-0x1, %rax
180006476:     	movl	$0x0, %edx
18000647b:     	cmovlq	%r15, %rdx
18000647f:     	movq	$0x0, 0x8(%r8,%rdx,8)
180006488:     	cmpq	$-0x2, %rax
18000648c:     	cmovgeq	%r12, %r15
180006490:     	movq	%rcx, 0x10(%r8,%r15,8)
180006495:     	cmpb	$0x0, (%rsi)
180006498:     	movq	0x118(%rsp), %rcx
1800064a0:     	jne	0x180004f7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13ee>
1800064a6:     	movq	0x2c8(%rsp), %rdx
1800064ae:     	movq	%rax, 0x30(%rbx,%rdx,8)
1800064b3:     	jmp	0x180004f7b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x13eb>
1800064b8:     	movb	$0x0, 0x124(%rsp)
1800064c0:     	movq	%rsi, 0x100(%rsp)
1800064c8:     	movq	%rcx, 0xf8(%rsp)
1800064d0:     	movq	0x2a8(%rsp), %rax
1800064d8:     	movq	%rax, 0xe8(%rsp)
1800064e0:     	movq	0x2a0(%rsp), %rax
1800064e8:     	movq	%rax, 0xe0(%rsp)
1800064f0:     	movq	0x290(%rsp), %rax
1800064f8:     	movq	%rax, 0xd0(%rsp)
180006500:     	movq	0x288(%rsp), %rax
180006508:     	movq	%rax, 0xc8(%rsp)
180006510:     	movq	0x280(%rsp), %rax
180006518:     	movq	%rax, 0xc0(%rsp)
180006520:     	movq	0x278(%rsp), %rax
180006528:     	movq	%rax, 0xb8(%rsp)
180006530:     	movq	0x270(%rsp), %rax
180006538:     	movq	%rax, 0xb0(%rsp)
180006540:     	movq	0x268(%rsp), %rax
180006548:     	movq	%rax, 0xa8(%rsp)
180006550:     	movq	0x258(%rsp), %rax
180006558:     	movq	%rax, 0x98(%rsp)
180006560:     	movq	0x250(%rsp), %rax
180006568:     	movq	%rax, 0x90(%rsp)
180006570:     	movq	0x248(%rsp), %rax
180006578:     	movq	%rax, 0x88(%rsp)
180006580:     	movq	0x240(%rsp), %rax
180006588:     	movq	%rax, 0x80(%rsp)
180006590:     	movq	0x238(%rsp), %rax
180006598:     	movq	%rax, 0x78(%rsp)
18000659d:     	movq	%r15, 0x70(%rsp)
1800065a2:     	movq	%rbx, 0x68(%rsp)
1800065a7:     	movq	0x220(%rsp), %rax
1800065af:     	movq	%rax, 0x60(%rsp)
1800065b4:     	movq	0x218(%rsp), %rax
1800065bc:     	movq	%rax, 0x58(%rsp)
1800065c1:     	movq	0x210(%rsp), %rax
1800065c9:     	movq	%rax, 0x50(%rsp)
1800065ce:     	movq	0x208(%rsp), %rax
1800065d6:     	movq	%rax, 0x48(%rsp)
1800065db:     	movq	0x200(%rsp), %rax
1800065e3:     	movq	%rax, 0x40(%rsp)
1800065e8:     	movq	0x1f8(%rsp), %rax
1800065f0:     	movq	%rax, 0x38(%rsp)
1800065f5:     	movq	%r14, 0x30(%rsp)
1800065fa:     	movq	0x1e8(%rsp), %rax
180006602:     	movq	%rax, 0x28(%rsp)
180006607:     	movq	0x298(%rsp), %rsi
18000660f:     	movq	%rsi, 0xd8(%rsp)
180006617:     	movq	%rbp, 0xa0(%rsp)
18000661f:     	movq	0x1e0(%rsp), %rax
180006627:     	movq	%rax, 0x20(%rsp)
18000662c:     	movq	$-0x1, 0x108(%rsp)
180006638:     	movq	$0x0, 0xf0(%rsp)
180006644:     	leaq	0x124(%rsp), %rcx
18000664c:     	movq	0x128(%rsp), %r8
180006654:     	movq	0x138(%rsp), %r9
18000665c:     	callq	0x1800046f0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0xb60>
180006661:     	cmpb	$0x0, (%rsi)
180006664:     	jne	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000666a:     	movzbl	0x124(%rsp), %r12d
180006673:     	decq	0x8(%rbp)
180006677:     	jmp	0x180005161 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x15d1>
18000667c:     	movb	$0x1, (%rsi)
18000667f:     	movq	$0x989697, 0x18(%rbp)   # imm = 0x989697
180006687:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000668c:     	movb	$0x1, (%rsi)
18000668f:     	movq	$0x989698, 0x18(%rbp)   # imm = 0x989698
180006697:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
18000669c:     	movb	$0x1, (%rsi)
18000669f:     	movq	$0x989699, 0x18(%rbp)   # imm = 0x989699
1800066a7:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800066ac:     	movb	$0x1, (%rsi)
1800066af:     	movq	$0x98969a, 0x18(%rbp)   # imm = 0x98969A
1800066b7:     	jmp	0x180004f2d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x139d>
1800066bc:     	nopl	(%rax)
1800066c0:     	pushq	%r15
1800066c2:     	pushq	%r14
1800066c4:     	pushq	%r13
1800066c6:     	pushq	%r12
1800066c8:     	pushq	%rsi
1800066c9:     	pushq	%rdi
1800066ca:     	pushq	%rbp
1800066cb:     	pushq	%rbx
1800066cc:     	subq	$0x198, %rsp            # imm = 0x198
1800066d3:     	movapd	%xmm8, 0x180(%rsp)
1800066dd:     	movapd	%xmm7, 0x170(%rsp)
1800066e6:     	movapd	%xmm6, 0x160(%rsp)
1800066ef:     	movq	0x2d0(%rsp), %rsi
1800066f7:     	movq	0x210(%rsp), %r14
1800066ff:     	movsd	0x48(%r14,%rsi,8), %xmm0
180006706:     	xorpd	%xmm1, %xmm1
18000670a:     	ucomisd	%xmm1, %xmm0
18000670e:     	jne	0x180006716 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b86>
180006710:     	jnp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006716:     	movq	0x2d8(%rsp), %rbp
18000671e:     	movq	0x250(%rsp), %r13
180006726:     	movq	0x248(%rsp), %r12
18000672e:     	movq	0x30(%r12,%rsi,8), %rax
180006733:     	movq	%rax, %r10
180006736:     	sarq	$0x3f, %r10
18000673a:     	andq	%r13, %r10
18000673d:     	leaq	(%r12,%rax,8), %rdx
180006741:     	cmpq	$0x1, (%rdx,%r10,8)
180006746:     	jne	0x18000676d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2bdd>
180006748:     	xorl	%r10d, %r10d
18000674b:     	cmpq	$-0x2, %rax
18000674f:     	cmovlq	%r13, %r10
180006753:     	movq	0x10(%rdx,%r10,8), %rax
180006758:     	leaq	(%r12,%rax,8), %rdx
18000675c:     	sarq	$0x3f, %rax
180006760:     	andq	%r13, %rax
180006763:     	cmpq	%rbp, (%rdx,%rax,8)
180006767:     	je	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
18000676d:     	movq	0x2b8(%rsp), %r15
180006775:     	movq	0x280(%rsp), %rbx
18000677d:     	movq	0x10(%r12,%rsi,8), %rdx
180006782:     	testq	%rdx, %rdx
180006785:     	js	0x180006874 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2ce4>
18000678b:     	testq	%rbp, %rbp
18000678e:     	js	0x180006874 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2ce4>
180006794:     	movq	0x10(%r12,%rbp,8), %r10
180006799:     	testq	%r10, %r10
18000679c:     	js	0x180006874 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2ce4>
1800067a2:     	movsd	(%r14,%rdx,8), %xmm1
1800067a8:     	cmpq	$0x0, 0x8(%r12,%rdx,8)
1800067ae:     	setne	%r11b
1800067b2:     	cmpq	$0x0, 0x8(%r12,%r10,8)
1800067b8:     	setne	%al
1800067bb:     	subsd	(%r14,%r10,8), %xmm1
1800067c1:     	andb	%r11b, %al
1800067c4:     	cmpb	$0x1, %al
1800067c6:     	jne	0x1800067ea <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2c5a>
1800067c8:     	movapd	0x6bf0(%rip), %xmm2     # 0x18000d3c0
1800067d0:     	andpd	%xmm1, %xmm2
1800067d4:     	ucomisd	0x6bf4(%rip), %xmm2     # 0x18000d3d0
1800067dc:     	jae	0x180006874 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2ce4>
1800067e2:     	xorpd	%xmm2, %xmm2
1800067e6:     	addsd	%xmm2, %xmm1
1800067ea:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800067f1:     	cmpq	$0x0, 0x18(%r12,%rdx,8)
1800067f7:     	subsd	0x10(%r14,%r10,8), %xmm2
1800067fe:     	je	0x1800068be <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d2e>
180006804:     	cmpq	$0x0, 0x18(%r12,%r10,8)
18000680a:     	je	0x1800068be <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d2e>
180006810:     	movapd	0x6ba8(%rip), %xmm3     # 0x18000d3c0
180006818:     	andpd	%xmm2, %xmm3
18000681c:     	ucomisd	0x6bac(%rip), %xmm3     # 0x18000d3d0
180006824:     	jae	0x180006926 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d96>
18000682a:     	movapd	%xmm1, %xmm3
18000682e:     	mulsd	%xmm1, %xmm3
180006832:     	ucomisd	0x6b96(%rip), %xmm3     # 0x18000d3d0
18000683a:     	setae	%dl
18000683d:     	testb	%dl, %al
18000683f:     	jne	0x1800068d7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d47>
180006845:     	xorpd	%xmm4, %xmm4
180006849:     	addsd	%xmm4, %xmm2
18000684d:     	movapd	%xmm2, %xmm4
180006851:     	mulsd	%xmm2, %xmm4
180006855:     	ucomisd	0x6b73(%rip), %xmm4     # 0x18000d3d0
18000685d:     	jae	0x1800068d7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d47>
18000685f:     	addsd	%xmm4, %xmm3
180006863:     	ucomisd	0x6b65(%rip), %xmm3     # 0x18000d3d0
18000686b:     	setae	%dl
18000686e:     	testb	%dl, %al
180006870:     	jne	0x1800068d7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d47>
180006872:     	jmp	0x1800068f1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d61>
180006874:     	movb	$0x1, (%r15)
180006878:     	movq	$0x3d090a, 0x18(%rbx)   # imm = 0x3D090A
180006880:     	movq	$0x0, 0x8(%rcx)
180006888:     	movq	$0x0, (%rcx)
18000688f:     	xorl	%eax, %eax
180006891:     	movaps	0x160(%rsp), %xmm6
180006899:     	movaps	0x170(%rsp), %xmm7
1800068a1:     	movaps	0x180(%rsp), %xmm8
1800068aa:     	addq	$0x198, %rsp            # imm = 0x198
1800068b1:     	popq	%rbx
1800068b2:     	popq	%rbp
1800068b3:     	popq	%rdi
1800068b4:     	popq	%rsi
1800068b5:     	popq	%r12
1800068b7:     	popq	%r13
1800068b9:     	popq	%r14
1800068bb:     	popq	%r15
1800068bd:     	retq
1800068be:     	movapd	%xmm1, %xmm3
1800068c2:     	mulsd	%xmm1, %xmm3
1800068c6:     	ucomisd	0x6b02(%rip), %xmm3     # 0x18000d3d0
1800068ce:     	setae	%dl
1800068d1:     	andb	%dl, %al
1800068d3:     	cmpb	$0x1, %al
1800068d5:     	jne	0x1800068e5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d55>
1800068d7:     	movb	$0x1, (%r15)
1800068db:     	movq	$0x3d090c, 0x18(%rbx)   # imm = 0x3D090C
1800068e3:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
1800068e5:     	movapd	%xmm2, %xmm4
1800068e9:     	mulsd	%xmm2, %xmm4
1800068ed:     	addsd	%xmm4, %xmm3
1800068f1:     	xorps	%xmm4, %xmm4
1800068f4:     	sqrtsd	%xmm3, %xmm4
1800068f8:     	cmpq	$0x0, 0x18(%r12,%rsi,8)
1800068fe:     	je	0x180006955 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2dc5>
180006900:     	movq	(%r12,%rsi,8), %rax
180006904:     	testq	%rax, %rax
180006907:     	js	0x180006915 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2d85>
180006909:     	xorpd	%xmm5, %xmm5
18000690d:     	ucomisd	%xmm5, %xmm3
180006911:     	jne	0x180006937 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2da7>
180006913:     	jp	0x180006937 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2da7>
180006915:     	movb	$0x1, (%r15)
180006919:     	movq	$0x3d090f, 0x18(%rbx)   # imm = 0x3D090F
180006921:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006926:     	movb	$0x1, (%r15)
18000692a:     	movq	$0x3d090b, 0x18(%rbx)   # imm = 0x3D090B
180006932:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006937:     	movsd	0x2e0(%rsp), %xmm6
180006940:     	movsd	0x8(%r14,%rax,8), %xmm3
180006947:     	addsd	%xmm3, %xmm3
18000694b:     	divsd	%xmm4, %xmm3
18000694f:     	ucomisd	%xmm3, %xmm6
180006953:     	jbe	0x1800069bb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2e2b>
180006955:     	movsd	0x6a7b(%rip), %xmm3     # 0x18000d3d8
18000695d:     	maxsd	%xmm4, %xmm3
180006961:     	movapd	%xmm3, %xmm4
180006965:     	mulsd	%xmm3, %xmm4
180006969:     	xorpd	%xmm5, %xmm5
18000696d:     	ucomisd	%xmm5, %xmm4
180006971:     	jne	0x180006986 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2df6>
180006973:     	jp	0x180006986 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2df6>
180006975:     	movb	$0x1, (%r15)
180006979:     	movq	$0x3d0915, 0x18(%rbx)   # imm = 0x3D0915
180006981:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006986:     	movsd	0x8(%r14,%rbp,8), %xmm5
18000698d:     	mulsd	0x6a4b(%rip), %xmm5     # 0x18000d3e0
180006995:     	mulsd	%xmm5, %xmm0
180006999:     	divsd	%xmm4, %xmm0
18000699d:     	mulsd	%xmm0, %xmm1
1800069a1:     	divsd	%xmm3, %xmm1
1800069a5:     	mulsd	%xmm0, %xmm2
1800069a9:     	divsd	%xmm3, %xmm2
1800069ad:     	movsd	%xmm1, (%rcx)
1800069b1:     	movsd	%xmm2, 0x8(%rcx)
1800069b6:     	jmp	0x18000688f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cff>
1800069bb:     	movq	0x258(%rsp), %rdi
1800069c3:     	movq	0x240(%rsp), %r11
1800069cb:     	movq	0x20(%r12,%rsi,8), %rax
1800069d0:     	testq	%rax, %rax
1800069d3:     	js	0x180006bbc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x302c>
1800069d9:     	movq	0x8(%rbx), %rdx
1800069dd:     	leaq	0x1(%rdx), %r10
1800069e1:     	movq	%r10, 0x8(%rbx)
1800069e5:     	cmpq	0x10(%rbx), %rdx
1800069e9:     	jge	0x180006f76 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x33e6>
1800069ef:     	movq	%rcx, 0x108(%rsp)
1800069f7:     	movsd	%xmm6, 0x100(%rsp)
180006a00:     	movq	%rbp, 0xf8(%rsp)
180006a08:     	movq	%rax, 0xf0(%rsp)
180006a10:     	movq	0x2c8(%rsp), %rax
180006a18:     	movq	%rax, 0xe8(%rsp)
180006a20:     	movq	0x2c0(%rsp), %rax
180006a28:     	movq	%rax, 0xe0(%rsp)
180006a30:     	movq	%r15, 0xd8(%rsp)
180006a38:     	movq	0x2b0(%rsp), %rax
180006a40:     	movq	%rax, 0xd0(%rsp)
180006a48:     	movq	0x2a8(%rsp), %rax
180006a50:     	movq	%rax, 0xc8(%rsp)
180006a58:     	movq	0x2a0(%rsp), %rax
180006a60:     	movq	%rax, 0xc0(%rsp)
180006a68:     	movq	0x298(%rsp), %rax
180006a70:     	movq	%rax, 0xb8(%rsp)
180006a78:     	movq	0x290(%rsp), %rax
180006a80:     	movq	%rax, 0xb0(%rsp)
180006a88:     	movq	0x288(%rsp), %rax
180006a90:     	movq	%rax, 0xa8(%rsp)
180006a98:     	movq	%rbx, 0xa0(%rsp)
180006aa0:     	movq	0x278(%rsp), %rax
180006aa8:     	movq	%rax, 0x98(%rsp)
180006ab0:     	movq	0x270(%rsp), %rax
180006ab8:     	movq	%rax, 0x90(%rsp)
180006ac0:     	movq	0x268(%rsp), %rax
180006ac8:     	movq	%rax, 0x88(%rsp)
180006ad0:     	movq	0x260(%rsp), %rax
180006ad8:     	movq	%rax, 0x80(%rsp)
180006ae0:     	movq	%rdi, 0x78(%rsp)
180006ae5:     	movq	%r13, 0x70(%rsp)
180006aea:     	movq	%r12, 0x68(%rsp)
180006aef:     	movq	%r11, 0x60(%rsp)
180006af4:     	movq	0x238(%rsp), %rax
180006afc:     	movq	%rax, 0x58(%rsp)
180006b01:     	movq	0x230(%rsp), %rax
180006b09:     	movq	%rax, 0x50(%rsp)
180006b0e:     	movq	0x228(%rsp), %rax
180006b16:     	movq	%rax, 0x48(%rsp)
180006b1b:     	movq	0x220(%rsp), %rax
180006b23:     	movq	%rax, 0x40(%rsp)
180006b28:     	movq	0x218(%rsp), %rax
180006b30:     	movq	%rax, 0x38(%rsp)
180006b35:     	movq	%r14, 0x30(%rsp)
180006b3a:     	movq	0x208(%rsp), %rax
180006b42:     	movq	%rax, 0x28(%rsp)
180006b47:     	movq	0x200(%rsp), %rax
180006b4f:     	movq	%rax, 0x20(%rsp)
180006b54:     	leaq	0x150(%rsp), %rcx
180006b5c:     	movq	%r8, 0x110(%rsp)
180006b64:     	movq	%r9, %rdi
180006b67:     	callq	0x1800066c0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b30>
180006b6c:     	cmpb	$0x0, (%r15)
180006b70:     	jne	0x1800071aa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x361a>
180006b76:     	xorpd	%xmm8, %xmm8
180006b7b:     	movsd	0x150(%rsp), %xmm7
180006b84:     	addsd	%xmm8, %xmm7
180006b89:     	addsd	0x158(%rsp), %xmm8
180006b93:     	decq	0x8(%rbx)
180006b97:     	movq	0x108(%rsp), %rcx
180006b9f:     	movq	%rdi, %r9
180006ba2:     	movq	0x110(%rsp), %r8
180006baa:     	movq	0x240(%rsp), %r11
180006bb2:     	movq	0x258(%rsp), %rdi
180006bba:     	jmp	0x180006bc5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3035>
180006bbc:     	xorpd	%xmm7, %xmm7
180006bc0:     	xorpd	%xmm8, %xmm8
180006bc5:     	movq	0x28(%r12,%rsi,8), %rax
180006bca:     	testq	%rax, %rax
180006bcd:     	js	0x180006daa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x321a>
180006bd3:     	movq	0x8(%rbx), %rdx
180006bd7:     	leaq	0x1(%rdx), %r10
180006bdb:     	movq	%r10, 0x8(%rbx)
180006bdf:     	cmpq	0x10(%rbx), %rdx
180006be3:     	jge	0x180006f87 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x33f7>
180006be9:     	movq	%rcx, 0x108(%rsp)
180006bf1:     	movsd	%xmm6, 0x100(%rsp)
180006bfa:     	movq	%rbp, 0xf8(%rsp)
180006c02:     	movq	%rax, 0xf0(%rsp)
180006c0a:     	movq	0x2c8(%rsp), %rax
180006c12:     	movq	%rax, 0xe8(%rsp)
180006c1a:     	movq	0x2c0(%rsp), %rax
180006c22:     	movq	%rax, 0xe0(%rsp)
180006c2a:     	movq	%r15, 0xd8(%rsp)
180006c32:     	movq	0x2b0(%rsp), %rax
180006c3a:     	movq	%rax, 0xd0(%rsp)
180006c42:     	movq	0x2a8(%rsp), %rax
180006c4a:     	movq	%rax, 0xc8(%rsp)
180006c52:     	movq	0x2a0(%rsp), %rax
180006c5a:     	movq	%rax, 0xc0(%rsp)
180006c62:     	movq	0x298(%rsp), %rax
180006c6a:     	movq	%rax, 0xb8(%rsp)
180006c72:     	movq	0x290(%rsp), %rax
180006c7a:     	movq	%rax, 0xb0(%rsp)
180006c82:     	movq	0x288(%rsp), %rax
180006c8a:     	movq	%rax, 0xa8(%rsp)
180006c92:     	movq	%rbx, 0xa0(%rsp)
180006c9a:     	movq	0x278(%rsp), %rax
180006ca2:     	movq	%rax, 0x98(%rsp)
180006caa:     	movq	0x270(%rsp), %rax
180006cb2:     	movq	%rax, 0x90(%rsp)
180006cba:     	movq	0x268(%rsp), %rax
180006cc2:     	movq	%rax, 0x88(%rsp)
180006cca:     	movq	0x260(%rsp), %rax
180006cd2:     	movq	%rax, 0x80(%rsp)
180006cda:     	movq	%rdi, 0x78(%rsp)
180006cdf:     	movq	%r13, 0x70(%rsp)
180006ce4:     	movq	%r12, 0x68(%rsp)
180006ce9:     	movq	%r11, 0x60(%rsp)
180006cee:     	movq	0x238(%rsp), %rax
180006cf6:     	movq	%rax, 0x58(%rsp)
180006cfb:     	movq	0x230(%rsp), %rax
180006d03:     	movq	%rax, 0x50(%rsp)
180006d08:     	movq	0x228(%rsp), %rax
180006d10:     	movq	%rax, 0x48(%rsp)
180006d15:     	movq	0x220(%rsp), %rax
180006d1d:     	movq	%rax, 0x40(%rsp)
180006d22:     	movq	0x218(%rsp), %rax
180006d2a:     	movq	%rax, 0x38(%rsp)
180006d2f:     	movq	%r14, 0x30(%rsp)
180006d34:     	movq	0x208(%rsp), %rax
180006d3c:     	movq	%rax, 0x28(%rsp)
180006d41:     	movq	0x200(%rsp), %rax
180006d49:     	movq	%rax, 0x20(%rsp)
180006d4e:     	leaq	0x140(%rsp), %rcx
180006d56:     	movq	%r8, 0x110(%rsp)
180006d5e:     	movq	%r9, %rdi
180006d61:     	callq	0x1800066c0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b30>
180006d66:     	cmpb	$0x0, (%r15)
180006d6a:     	jne	0x1800071aa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x361a>
180006d70:     	addsd	0x140(%rsp), %xmm7
180006d79:     	addsd	0x148(%rsp), %xmm8
180006d83:     	decq	0x8(%rbx)
180006d87:     	movq	0x108(%rsp), %rcx
180006d8f:     	movq	%rdi, %r9
180006d92:     	movq	0x110(%rsp), %r8
180006d9a:     	movq	0x240(%rsp), %r11
180006da2:     	movq	0x258(%rsp), %rdi
180006daa:     	movq	0x38(%r12,%rsi,8), %rax
180006daf:     	testq	%rax, %rax
180006db2:     	js	0x180006f98 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3408>
180006db8:     	movq	0x8(%rbx), %rdx
180006dbc:     	leaq	0x1(%rdx), %r10
180006dc0:     	movq	%r10, 0x8(%rbx)
180006dc4:     	cmpq	0x10(%rbx), %rdx
180006dc8:     	jge	0x18000718d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x35fd>
180006dce:     	movq	%rcx, 0x108(%rsp)
180006dd6:     	movsd	%xmm6, 0x100(%rsp)
180006ddf:     	movq	%rbp, 0xf8(%rsp)
180006de7:     	movq	%rax, 0xf0(%rsp)
180006def:     	movq	0x2c8(%rsp), %rax
180006df7:     	movq	%rax, 0xe8(%rsp)
180006dff:     	movq	0x2c0(%rsp), %rax
180006e07:     	movq	%rax, 0xe0(%rsp)
180006e0f:     	movq	%r15, 0xd8(%rsp)
180006e17:     	movq	0x2b0(%rsp), %rax
180006e1f:     	movq	%rax, 0xd0(%rsp)
180006e27:     	movq	0x2a8(%rsp), %rax
180006e2f:     	movq	%rax, 0xc8(%rsp)
180006e37:     	movq	0x2a0(%rsp), %rax
180006e3f:     	movq	%rax, 0xc0(%rsp)
180006e47:     	movq	0x298(%rsp), %rax
180006e4f:     	movq	%rax, 0xb8(%rsp)
180006e57:     	movq	0x290(%rsp), %rax
180006e5f:     	movq	%rax, 0xb0(%rsp)
180006e67:     	movq	0x288(%rsp), %rax
180006e6f:     	movq	%rax, 0xa8(%rsp)
180006e77:     	movq	%rbx, 0xa0(%rsp)
180006e7f:     	movq	0x278(%rsp), %rax
180006e87:     	movq	%rax, 0x98(%rsp)
180006e8f:     	movq	0x270(%rsp), %rax
180006e97:     	movq	%rax, 0x90(%rsp)
180006e9f:     	movq	0x268(%rsp), %rax
180006ea7:     	movq	%rax, 0x88(%rsp)
180006eaf:     	movq	0x260(%rsp), %rax
180006eb7:     	movq	%rax, 0x80(%rsp)
180006ebf:     	movq	%rdi, 0x78(%rsp)
180006ec4:     	movq	%r13, 0x70(%rsp)
180006ec9:     	movq	%r12, 0x68(%rsp)
180006ece:     	movq	%r11, %rdi
180006ed1:     	movq	%r11, 0x60(%rsp)
180006ed6:     	movq	0x238(%rsp), %rax
180006ede:     	movq	%rax, 0x58(%rsp)
180006ee3:     	movq	0x230(%rsp), %rax
180006eeb:     	movq	%rax, 0x50(%rsp)
180006ef0:     	movq	0x228(%rsp), %rax
180006ef8:     	movq	%rax, 0x48(%rsp)
180006efd:     	movq	0x220(%rsp), %rax
180006f05:     	movq	%rax, 0x40(%rsp)
180006f0a:     	movq	0x218(%rsp), %rax
180006f12:     	movq	%rax, 0x38(%rsp)
180006f17:     	movq	%r14, 0x30(%rsp)
180006f1c:     	movq	0x208(%rsp), %rax
180006f24:     	movq	%rax, 0x28(%rsp)
180006f29:     	movq	0x200(%rsp), %rax
180006f31:     	movq	%rax, 0x20(%rsp)
180006f36:     	leaq	0x130(%rsp), %rcx
180006f3e:     	movq	%r8, 0x110(%rsp)
180006f46:     	movq	%r9, 0x118(%rsp)
180006f4e:     	callq	0x1800066c0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b30>
180006f53:     	cmpb	$0x0, (%r15)
180006f57:     	jne	0x1800071aa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x361a>
180006f5d:     	addsd	0x130(%rsp), %xmm7
180006f66:     	addsd	0x138(%rsp), %xmm8
180006f70:     	decq	0x8(%rbx)
180006f74:     	jmp	0x180006fb3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3423>
180006f76:     	movb	$0x1, (%r15)
180006f7a:     	movq	$0x3d0921, 0x18(%rbx)   # imm = 0x3D0921
180006f82:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006f87:     	movb	$0x1, (%r15)
180006f8b:     	movq	$0x3d0926, 0x18(%rbx)   # imm = 0x3D0926
180006f93:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
180006f98:     	movq	%r11, %rdi
180006f9b:     	movq	%r8, 0x110(%rsp)
180006fa3:     	movq	%r9, 0x118(%rsp)
180006fab:     	movq	%rcx, 0x108(%rsp)
180006fb3:     	movq	0x40(%r12,%rsi,8), %rax
180006fb8:     	testq	%rax, %rax
180006fbb:     	js	0x180007176 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x35e6>
180006fc1:     	movq	0x8(%rbx), %rcx
180006fc5:     	leaq	0x1(%rcx), %rdx
180006fc9:     	movq	%rdx, 0x8(%rbx)
180006fcd:     	cmpq	0x10(%rbx), %rcx
180006fd1:     	jge	0x18000719e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x360e>
180006fd7:     	movq	%rbp, 0xf8(%rsp)
180006fdf:     	movq	%rax, 0xf0(%rsp)
180006fe7:     	movq	0x2c8(%rsp), %rax
180006fef:     	movq	%rax, 0xe8(%rsp)
180006ff7:     	movq	0x2c0(%rsp), %rax
180006fff:     	movq	%rax, 0xe0(%rsp)
180007007:     	movq	0x2b0(%rsp), %rax
18000700f:     	movq	%rax, 0xd0(%rsp)
180007017:     	movq	0x2a8(%rsp), %rax
18000701f:     	movq	%rax, 0xc8(%rsp)
180007027:     	movq	0x2a0(%rsp), %rax
18000702f:     	movq	%rax, 0xc0(%rsp)
180007037:     	movq	0x298(%rsp), %rax
18000703f:     	movq	%rax, 0xb8(%rsp)
180007047:     	movq	0x290(%rsp), %rax
18000704f:     	movq	%rax, 0xb0(%rsp)
180007057:     	movq	0x288(%rsp), %rax
18000705f:     	movq	%rax, 0xa8(%rsp)
180007067:     	movq	0x278(%rsp), %rax
18000706f:     	movq	%rax, 0x98(%rsp)
180007077:     	movq	0x270(%rsp), %rax
18000707f:     	movq	%rax, 0x90(%rsp)
180007087:     	movq	0x268(%rsp), %rax
18000708f:     	movq	%rax, 0x88(%rsp)
180007097:     	movq	0x260(%rsp), %rax
18000709f:     	movq	%rax, 0x80(%rsp)
1800070a7:     	movq	0x258(%rsp), %rax
1800070af:     	movq	%rax, 0x78(%rsp)
1800070b4:     	movq	%r13, 0x70(%rsp)
1800070b9:     	movq	%r12, 0x68(%rsp)
1800070be:     	movq	%rdi, 0x60(%rsp)
1800070c3:     	movq	0x238(%rsp), %rax
1800070cb:     	movq	%rax, 0x58(%rsp)
1800070d0:     	movq	0x230(%rsp), %rax
1800070d8:     	movq	%rax, 0x50(%rsp)
1800070dd:     	movq	0x228(%rsp), %rax
1800070e5:     	movq	%rax, 0x48(%rsp)
1800070ea:     	movq	0x220(%rsp), %rax
1800070f2:     	movq	%rax, 0x40(%rsp)
1800070f7:     	movq	0x218(%rsp), %rax
1800070ff:     	movq	%rax, 0x38(%rsp)
180007104:     	movq	%r14, 0x30(%rsp)
180007109:     	movq	0x208(%rsp), %rax
180007111:     	movq	%rax, 0x28(%rsp)
180007116:     	movsd	%xmm6, 0x100(%rsp)
18000711f:     	movq	%r15, 0xd8(%rsp)
180007127:     	movq	%rbx, 0xa0(%rsp)
18000712f:     	movq	0x200(%rsp), %rax
180007137:     	movq	%rax, 0x20(%rsp)
18000713c:     	leaq	0x120(%rsp), %rcx
180007144:     	movq	0x110(%rsp), %r8
18000714c:     	movq	0x118(%rsp), %r9
180007154:     	callq	0x1800066c0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2b30>
180007159:     	cmpb	$0x0, (%r15)
18000715d:     	jne	0x1800071aa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x361a>
18000715f:     	addsd	0x120(%rsp), %xmm7
180007168:     	addsd	0x128(%rsp), %xmm8
180007172:     	decq	0x8(%rbx)
180007176:     	movq	0x108(%rsp), %rax
18000717e:     	movsd	%xmm7, (%rax)
180007182:     	movsd	%xmm8, 0x8(%rax)
180007188:     	jmp	0x18000688f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cff>
18000718d:     	movb	$0x1, (%r15)
180007191:     	movq	$0x3d092b, 0x18(%rbx)   # imm = 0x3D092B
180007199:     	jmp	0x180006880 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cf0>
18000719e:     	movb	$0x1, (%r15)
1800071a2:     	movq	$0x3d0930, 0x18(%rbx)   # imm = 0x3D0930
1800071aa:     	movq	0x108(%rsp), %rax
1800071b2:     	movq	$0x0, 0x8(%rax)
1800071ba:     	movq	$0x0, (%rax)
1800071c1:     	jmp	0x18000688f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x2cff>
1800071c6:     	nopw	%cs:(%rax,%rax)
1800071d0:     	pushq	%r15
1800071d2:     	pushq	%r14
1800071d4:     	pushq	%r13
1800071d6:     	pushq	%r12
1800071d8:     	pushq	%rsi
1800071d9:     	pushq	%rdi
1800071da:     	pushq	%rbp
1800071db:     	pushq	%rbx
1800071dc:     	subq	$0x1c8, %rsp            # imm = 0x1C8
1800071e3:     	movq	0x300(%rsp), %rax
1800071eb:     	movq	0x2e8(%rsp), %r15
1800071f3:     	movq	0x2b0(%rsp), %r12
1800071fb:     	movb	$0x0, 0x12f(%rsp)
180007203:     	movq	$0x0, 0x1a8(%rsp)
18000720f:     	movb	$0x0, 0x11f(%rsp)
180007217:     	movq	$0x0, 0x1a0(%rsp)
180007223:     	movb	$0x0, 0x11e(%rsp)
18000722b:     	movq	$0x0, 0x198(%rsp)
180007237:     	movb	$0x0, 0x11d(%rsp)
18000723f:     	movq	$0x0, 0x190(%rsp)
18000724b:     	movb	$0x0, 0x11c(%rsp)
180007253:     	movq	$0x0, 0x188(%rsp)
18000725f:     	movb	$0x0, 0x12e(%rsp)
180007267:     	movq	$0x0, 0x180(%rsp)
180007273:     	movb	$0x0, 0x12d(%rsp)
18000727b:     	movq	$0x0, 0x178(%rsp)
180007287:     	movb	$0x0, 0x12c(%rsp)
18000728f:     	movq	$0x0, 0x170(%rsp)
18000729b:     	movb	$0x0, 0x12b(%rsp)
1800072a3:     	movq	$0x0, 0x168(%rsp)
1800072af:     	cmpq	$0x1, %rax
1800072b3:     	movq	0x280(%rsp), %rbx
1800072bb:     	movq	0x278(%rsp), %r13
1800072c3:     	movq	0x258(%rsp), %rdi
1800072cb:     	movq	0x248(%rsp), %r14
1800072d3:     	movq	0x240(%rsp), %rbp
1800072db:     	je	0x180007382 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x37f2>
1800072e1:     	testq	%rax, %rax
1800072e4:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800072ea:     	movq	0x308(%rsp), %rsi
1800072f2:     	movq	(%r13,%rsi,8), %rax
1800072f7:     	testq	%rax, %rax
1800072fa:     	js	0x1800073af <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x381f>
180007300:     	movq	0x310(%rsp), %r10
180007308:     	testq	%r10, %r10
18000730b:     	js	0x1800073af <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x381f>
180007311:     	movq	0x10(%r13,%r10,8), %r11
180007316:     	testq	%r11, %r11
180007319:     	js	0x18000743f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x38af>
18000731f:     	movsd	(%rbp,%r11,8), %xmm0
180007326:     	movsd	0x8(%rbp,%rax,8), %xmm2
18000732c:     	movsd	0x10(%rbp,%rax,8), %xmm1
180007332:     	movapd	%xmm1, %xmm3
180007336:     	subsd	%xmm2, %xmm3
18000733a:     	xorl	%r10d, %r10d
18000733d:     	ucomisd	%xmm3, %xmm0
180007341:     	jb	0x180007461 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x38d1>
180007347:     	addsd	%xmm2, %xmm1
18000734b:     	ucomisd	%xmm0, %xmm1
18000734f:     	jbe	0x180007461 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x38d1>
180007355:     	movsd	0x10(%rbp,%r11,8), %xmm0
18000735c:     	movsd	(%rbp,%rax,8), %xmm1
180007362:     	movsd	0x18(%rbp,%rax,8), %xmm2
180007368:     	movapd	%xmm2, %xmm3
18000736c:     	subsd	%xmm1, %xmm3
180007370:     	ucomisd	%xmm3, %xmm0
180007374:     	jae	0x180007455 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x38c5>
18000737a:     	xorl	%r10d, %r10d
18000737d:     	jmp	0x180007461 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x38d1>
180007382:     	movq	0x318(%rsp), %rsi
18000738a:     	testq	%rsi, %rsi
18000738d:     	js	0x1800073c1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3831>
18000738f:     	movq	(%r13,%rsi,8), %rax
180007394:     	testq	%rax, %rax
180007397:     	js	0x1800073c1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3831>
180007399:     	movq	(%r12), %r10
18000739d:     	leaq	0x4(%r10), %r11
1800073a1:     	cmpq	%rbx, %r11
1800073a4:     	jle	0x1800073d3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3843>
1800073a6:     	movb	$0x2, (%r15)
1800073aa:     	jmp	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800073af:     	movb	$0x1, (%r15)
1800073b3:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
1800073bc:     	jmp	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800073c1:     	movb	$0x1, (%r15)
1800073c5:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
1800073ce:     	jmp	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800073d3:     	movsd	0x10(%rbp,%rax,8), %xmm1
1800073d9:     	movsd	0x18(%rbp,%rax,8), %xmm2
1800073df:     	movsd	0x5fc9(%rip), %xmm0     # 0x18000d3b0
1800073e7:     	movsd	0x8(%rbp,%rax,8), %xmm3
1800073ed:     	mulsd	%xmm0, %xmm3
1800073f1:     	mulsd	(%rbp,%rax,8), %xmm0
1800073f7:     	movq	%r11, (%r12)
1800073fb:     	cmpb	$0x0, (%r15)
1800073ff:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007405:     	movapd	%xmm1, %xmm4
180007409:     	addsd	%xmm3, %xmm4
18000740d:     	movapd	%xmm2, %xmm5
180007411:     	subsd	%xmm0, %xmm5
180007415:     	testq	%r10, %r10
180007418:     	js	0x18000757b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x39eb>
18000741e:     	movsd	%xmm4, 0x10(%rbp,%r10,8)
180007425:     	movsd	%xmm5, 0x18(%rbp,%r10,8)
18000742c:     	movsd	%xmm3, 0x8(%rbp,%r10,8)
180007433:     	movsd	%xmm0, (%rbp,%r10,8)
18000743a:     	jmp	0x180007588 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x39f8>
18000743f:     	movb	$0x1, (%r15)
180007443:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
18000744c:     	cmpb	$0x0, (%r15)
180007450:     	jmp	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007455:     	addsd	%xmm1, %xmm2
180007459:     	ucomisd	%xmm0, %xmm2
18000745d:     	seta	%r10b
180007461:     	cmpb	$0x0, (%r15)
180007465:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
18000746b:     	testb	%r10b, %r10b
18000746e:     	je	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007474:     	movq	0x18(%r13,%rsi,8), %rax
180007479:     	movq	0x30(%r13,%rsi,8), %rdi
18000747e:     	movq	%rdi, %r11
180007481:     	sarq	$0x3f, %r11
180007485:     	andq	%rbx, %r11
180007488:     	movq	%rdi, %r10
18000748b:     	leaq	(%r13,%rdi,8), %rdi
180007490:     	movq	%r11, 0x140(%rsp)
180007498:     	movq	(%rdi,%r11,8), %r11
18000749c:     	movq	%r11, 0x110(%rsp)
1800074a4:     	cmpq	0x8(%r13,%rsi,8), %r11
1800074a9:     	jge	0x18000771f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3b8f>
1800074af:     	testq	%rax, %rax
1800074b2:     	jne	0x180007728 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3b98>
1800074b8:     	movq	%rdi, %r14
1800074bb:     	xorl	%r8d, %r8d
1800074be:     	cmpq	$-0x1, %r10
1800074c2:     	cmovlq	%rbx, %r8
1800074c6:     	movq	0x110(%rsp), %rdx
1800074ce:     	cmpq	0x8(%rdi,%r8,8), %rdx
1800074d3:     	jne	0x180007fd0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4440>
1800074d9:     	leaq	(%rdx,%rdx), %rax
1800074dd:     	testq	%rdx, %rdx
1800074e0:     	movl	$0x4, %r9d
1800074e6:     	cmovneq	%rax, %r9
1800074ea:     	movq	(%r12), %r11
1800074ee:     	leaq	(%r11,%r9), %rax
1800074f2:     	cmpq	%rbx, %rax
1800074f5:     	jg	0x1800073a6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3816>
1800074fb:     	movq	%rax, (%r12)
1800074ff:     	cmpb	$0x0, (%r15)
180007503:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007509:     	movq	%r14, 0x150(%rsp)
180007511:     	movq	%r11, 0x148(%rsp)
180007519:     	movq	%r9, 0x158(%rsp)
180007521:     	movq	%r8, 0x160(%rsp)
180007529:     	xorl	%r11d, %r11d
18000752c:     	movq	%r10, 0x1c0(%rsp)
180007534:     	cmpq	$-0x2, %r10
180007538:     	cmovlq	%rbx, %r11
18000753c:     	testq	%rdx, %rdx
18000753f:     	jle	0x180007f96 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4406>
180007545:     	movq	0x150(%rsp), %rax
18000754d:     	movq	0x10(%rax,%r11,8), %r14
180007552:     	movq	0x110(%rsp), %rax
18000755a:     	movl	%eax, %r10d
18000755d:     	andl	$0x7, %r10d
180007561:     	cmpq	$0x7, %rax
180007565:     	ja	0x180007d7e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41ee>
18000756b:     	leaq	(,%rbx,8), %r8
180007573:     	xorl	%r9d, %r9d
180007576:     	jmp	0x180007f5a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x43ca>
18000757b:     	movb	$0x1, (%r15)
18000757f:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180007588:     	cmpb	$0x0, (%r15)
18000758c:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007592:     	movq	(%r12), %r11
180007596:     	leaq	0xb(%r11), %rax
18000759a:     	cmpq	%rbx, %rax
18000759d:     	jg	0x1800073a6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3816>
1800075a3:     	movq	%r11, 0x140(%rsp)
1800075ab:     	movq	0x8(%r13,%rsi,8), %r11
1800075b0:     	movq	%rax, (%r12)
1800075b4:     	cmpb	$0x0, (%r15)
1800075b8:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800075be:     	movq	0x140(%rsp), %rax
1800075c6:     	movq	%r10, (%r13,%rax,8)
1800075cb:     	movq	%r11, 0x8(%r13,%rax,8)
1800075d0:     	movq	(%r12), %r11
1800075d4:     	cmpq	%rbx, %r11
1800075d7:     	movq	%r11, %r10
1800075da:     	jle	0x1800075e7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3a57>
1800075dc:     	movb	$0x2, (%r15)
1800075e0:     	movq	(%r12), %r11
1800075e4:     	xorl	%r10d, %r10d
1800075e7:     	leaq	0x3(%r11), %rax
1800075eb:     	cmpq	%rbx, %rax
1800075ee:     	jg	0x1800073a6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3816>
1800075f4:     	movq	%rax, (%r12)
1800075f8:     	cmpb	$0x0, (%r15)
1800075fc:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007602:     	movq	%r11, %rax
180007605:     	sarq	$0x3f, %rax
180007609:     	andq	%rbx, %rax
18000760c:     	movq	%r10, 0x120(%rsp)
180007614:     	leaq	(%r13,%r11,8), %r10
180007619:     	movq	$0x0, (%r10,%rax,8)
180007621:     	movq	$0x0, 0x110(%rsp)
18000762d:     	cmpq	$-0x1, %r11
180007631:     	movl	$0x0, %eax
180007636:     	cmovlq	%rbx, %rax
18000763a:     	leaq	(%r13,%r11,8), %r10
18000763f:     	movq	$0x0, 0x8(%r10,%rax,8)
180007648:     	cmpq	$-0x2, %r11
18000764c:     	movq	0x110(%rsp), %rax
180007654:     	cmovlq	%rbx, %rax
180007658:     	movq	%rax, 0x110(%rsp)
180007660:     	leaq	(%r13,%r11,8), %rax
180007665:     	movq	0x120(%rsp), %r10
18000766d:     	movq	%r11, 0x130(%rsp)
180007675:     	movq	0x110(%rsp), %r11
18000767d:     	movq	%r10, 0x10(%rax,%r11,8)
180007682:     	movq	0x130(%rsp), %r11
18000768a:     	cmpb	$0x0, (%r15)
18000768e:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007694:     	movq	0x140(%rsp), %rax
18000769c:     	leaq	(%r13,%rax,8), %r10
1800076a1:     	movq	%r11, 0x30(%r10)
1800076a5:     	movq	$0x0, 0x18(%r10)
1800076ad:     	movq	(%r12), %r11
1800076b1:     	leaq	0x4(%r11), %rax
1800076b5:     	cmpq	%rbx, %rax
1800076b8:     	jg	0x1800073a6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3816>
1800076be:     	movq	%rax, (%r12)
1800076c2:     	cmpb	$0x0, (%r15)
1800076c6:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
1800076cc:     	movq	%r8, 0x130(%rsp)
1800076d4:     	movq	%r9, 0x138(%rsp)
1800076dc:     	movq	%rdx, 0x120(%rsp)
1800076e4:     	movq	%rcx, 0x110(%rsp)
1800076ec:     	testq	%r11, %r11
1800076ef:     	js	0x1800083ee <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x485e>
1800076f5:     	movq	$0x0, (%rbp,%r11,8)
1800076fe:     	leaq	(%r13,%r11,8), %rcx
180007703:     	movq	$0x1, 0x8(%r13,%r11,8)
18000770c:     	movq	$0x0, 0x10(%rbp,%r11,8)
180007715:     	movl	$0x1, %edx
18000771a:     	jmp	0x1800083fa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x486a>
18000771f:     	testq	%rax, %rax
180007722:     	je	0x180007932 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3da2>
180007728:     	movq	0x20(%r13,%rsi,8), %rax
18000772d:     	testq	%rax, %rax
180007730:     	js	0x180007b41 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fb1>
180007736:     	movq	0x8(%r12), %r10
18000773b:     	leaq	0x1(%r10), %r11
18000773f:     	movq	%r11, 0x8(%r12)
180007744:     	cmpq	0x10(%r12), %r10
180007749:     	jge	0x180007b41 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fb1>
18000774f:     	movq	%rdx, 0x120(%rsp)
180007757:     	movq	%rcx, 0x110(%rsp)
18000775f:     	movb	$0x0, 0x11f(%rsp)
180007767:     	movq	0x310(%rsp), %rcx
18000776f:     	movq	%rcx, 0x100(%rsp)
180007777:     	movq	%rax, 0xf8(%rsp)
18000777f:     	movq	0x2f8(%rsp), %rax
180007787:     	movq	%rax, 0xe8(%rsp)
18000778f:     	movq	0x2f0(%rsp), %rax
180007797:     	movq	%rax, 0xe0(%rsp)
18000779f:     	movq	%r15, 0xd8(%rsp)
1800077a7:     	movq	0x2e0(%rsp), %rax
1800077af:     	movq	%rax, 0xd0(%rsp)
1800077b7:     	movq	0x2d8(%rsp), %rax
1800077bf:     	movq	%rax, 0xc8(%rsp)
1800077c7:     	movq	0x2d0(%rsp), %rax
1800077cf:     	movq	%rax, 0xc0(%rsp)
1800077d7:     	movq	0x2c8(%rsp), %rax
1800077df:     	movq	%rax, 0xb8(%rsp)
1800077e7:     	movq	0x2c0(%rsp), %rax
1800077ef:     	movq	%rax, 0xb0(%rsp)
1800077f7:     	movq	0x2b8(%rsp), %rax
1800077ff:     	movq	%rax, 0xa8(%rsp)
180007807:     	movq	%r12, 0xa0(%rsp)
18000780f:     	movq	0x2a8(%rsp), %rax
180007817:     	movq	%rax, 0x98(%rsp)
18000781f:     	movq	0x2a0(%rsp), %rax
180007827:     	movq	%rax, 0x90(%rsp)
18000782f:     	movq	0x298(%rsp), %rax
180007837:     	movq	%rax, 0x88(%rsp)
18000783f:     	movq	0x290(%rsp), %rax
180007847:     	movq	%rax, 0x80(%rsp)
18000784f:     	movq	0x288(%rsp), %rax
180007857:     	movq	%rax, 0x78(%rsp)
18000785c:     	movq	%rbx, 0x70(%rsp)
180007861:     	movq	%r13, 0x68(%rsp)
180007866:     	movq	0x270(%rsp), %rax
18000786e:     	movq	%rax, 0x60(%rsp)
180007873:     	movq	0x268(%rsp), %rax
18000787b:     	movq	%rax, 0x58(%rsp)
180007880:     	movq	0x260(%rsp), %rax
180007888:     	movq	%rax, 0x50(%rsp)
18000788d:     	movq	0x258(%rsp), %rdi
180007895:     	movq	%rdi, 0x48(%rsp)
18000789a:     	movq	0x250(%rsp), %rax
1800078a2:     	movq	%rax, 0x40(%rsp)
1800078a7:     	movq	0x248(%rsp), %r14
1800078af:     	movq	%r14, 0x38(%rsp)
1800078b4:     	movq	%rbp, 0x30(%rsp)
1800078b9:     	movq	0x238(%rsp), %rax
1800078c1:     	movq	%rax, 0x28(%rsp)
1800078c6:     	movq	0x230(%rsp), %rax
1800078ce:     	movq	%rax, 0x20(%rsp)
1800078d3:     	movq	$-0x1, 0x108(%rsp)
1800078df:     	movq	$0x0, 0xf0(%rsp)
1800078eb:     	leaq	0x11f(%rsp), %rcx
1800078f3:     	leaq	0x1a0(%rsp), %rdx
1800078fb:     	movq	%r8, 0x130(%rsp)
180007903:     	movq	%r9, 0x138(%rsp)
18000790b:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180007910:     	testl	%eax, %eax
180007912:     	jne	0x1800081bf <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x462f>
180007918:     	cmpb	$0x0, (%r15)
18000791c:     	movq	0x110(%rsp), %rax
180007924:     	je	0x180007b76 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fe6>
18000792a:     	movb	$0x0, (%rax)
18000792d:     	jmp	0x180007b51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fc1>
180007932:     	movq	0x8(%r12), %rax
180007937:     	leaq	0x1(%rax), %r10
18000793b:     	movq	%r10, 0x8(%r12)
180007940:     	cmpq	0x10(%r12), %rax
180007945:     	jge	0x180007b67 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fd7>
18000794b:     	movq	%rdx, 0x120(%rsp)
180007953:     	movq	%rcx, 0x110(%rsp)
18000795b:     	movq	%rsi, 0x108(%rsp)
180007963:     	movq	0x2f8(%rsp), %rax
18000796b:     	movq	%rax, 0xe8(%rsp)
180007973:     	movq	0x2f0(%rsp), %rax
18000797b:     	movq	%rax, 0xe0(%rsp)
180007983:     	movq	%r15, 0xd8(%rsp)
18000798b:     	movq	0x2e0(%rsp), %rax
180007993:     	movq	%rax, 0xd0(%rsp)
18000799b:     	movq	0x2d8(%rsp), %rax
1800079a3:     	movq	%rax, 0xc8(%rsp)
1800079ab:     	movq	0x2d0(%rsp), %rax
1800079b3:     	movq	%rax, 0xc0(%rsp)
1800079bb:     	movq	0x2c8(%rsp), %rax
1800079c3:     	movq	%rax, 0xb8(%rsp)
1800079cb:     	movq	0x2c0(%rsp), %rax
1800079d3:     	movq	%rax, 0xb0(%rsp)
1800079db:     	movq	0x2b8(%rsp), %rax
1800079e3:     	movq	%rax, 0xa8(%rsp)
1800079eb:     	movq	%r12, 0xa0(%rsp)
1800079f3:     	movq	0x2a8(%rsp), %rax
1800079fb:     	movq	%rax, 0x98(%rsp)
180007a03:     	movq	0x2a0(%rsp), %rax
180007a0b:     	movq	%rax, 0x90(%rsp)
180007a13:     	movq	0x298(%rsp), %rax
180007a1b:     	movq	%rax, 0x88(%rsp)
180007a23:     	movq	0x290(%rsp), %rax
180007a2b:     	movq	%rax, 0x80(%rsp)
180007a33:     	movq	0x288(%rsp), %rax
180007a3b:     	movq	%rax, 0x78(%rsp)
180007a40:     	movq	%rbx, 0x70(%rsp)
180007a45:     	movq	%r13, 0x68(%rsp)
180007a4a:     	movq	0x270(%rsp), %rax
180007a52:     	movq	%rax, 0x60(%rsp)
180007a57:     	movq	0x268(%rsp), %rax
180007a5f:     	movq	%rax, 0x58(%rsp)
180007a64:     	movq	0x260(%rsp), %rax
180007a6c:     	movq	%rax, 0x50(%rsp)
180007a71:     	movq	0x258(%rsp), %rax
180007a79:     	movq	%rax, 0x48(%rsp)
180007a7e:     	movq	0x250(%rsp), %rax
180007a86:     	movq	%rax, 0x40(%rsp)
180007a8b:     	movq	0x248(%rsp), %rax
180007a93:     	movq	%rax, 0x38(%rsp)
180007a98:     	movq	%rbp, 0x30(%rsp)
180007a9d:     	movq	0x238(%rsp), %rax
180007aa5:     	movq	%rax, 0x28(%rsp)
180007aaa:     	movq	0x230(%rsp), %rax
180007ab2:     	movq	%rax, 0x20(%rsp)
180007ab7:     	movq	$-0x1, 0x100(%rsp)
180007ac3:     	movq	$-0x1, 0xf8(%rsp)
180007acf:     	movq	$0x1, 0xf0(%rsp)
180007adb:     	leaq	0x12f(%rsp), %rcx
180007ae3:     	leaq	0x1a8(%rsp), %rdx
180007aeb:     	movq	%r8, 0x130(%rsp)
180007af3:     	movq	%r9, 0x138(%rsp)
180007afb:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180007b00:     	testl	%eax, %eax
180007b02:     	jne	0x1800081c9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4639>
180007b08:     	cmpb	$0x0, (%r15)
180007b0c:     	movq	0x110(%rsp), %rcx
180007b14:     	movq	0x120(%rsp), %rdx
180007b1c:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007b1e:     	decq	0x8(%r12)
180007b23:     	movq	0x138(%rsp), %r9
180007b2b:     	movq	0x130(%rsp), %r8
180007b33:     	movq	0x20(%r13,%rsi,8), %rax
180007b38:     	testq	%rax, %rax
180007b3b:     	jns	0x180007736 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3ba6>
180007b41:     	movb	$0x1, (%r15)
180007b45:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
180007b4e:     	movb	$0x0, (%rcx)
180007b51:     	xorl	%eax, %eax
180007b53:     	addq	$0x1c8, %rsp            # imm = 0x1C8
180007b5a:     	popq	%rbx
180007b5b:     	popq	%rbp
180007b5c:     	popq	%rdi
180007b5d:     	popq	%rsi
180007b5e:     	popq	%r12
180007b60:     	popq	%r13
180007b62:     	popq	%r14
180007b64:     	popq	%r15
180007b66:     	retq
180007b67:     	movb	$0x1, (%r15)
180007b6b:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
180007b74:     	jmp	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007b76:     	movzbl	0x11f(%rsp), %ecx
180007b7e:     	movq	0x8(%r12), %rdx
180007b83:     	leaq	-0x1(%rdx), %r8
180007b87:     	movq	%r8, 0x8(%r12)
180007b8c:     	testb	$0x1, %cl
180007b8f:     	je	0x180007b96 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4006>
180007b91:     	movb	$0x1, (%rax)
180007b94:     	jmp	0x180007b51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fc1>
180007b96:     	movq	0x28(%r13,%rsi,8), %rcx
180007b9b:     	testq	%rcx, %rcx
180007b9e:     	js	0x180007bac <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x401c>
180007ba0:     	movq	%rdx, 0x8(%r12)
180007ba5:     	cmpq	0x10(%r12), %rdx
180007baa:     	jle	0x180007bbe <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x402e>
180007bac:     	movb	$0x1, (%r15)
180007bb0:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180007bb9:     	jmp	0x18000792a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3d9a>
180007bbe:     	movb	$0x0, 0x11e(%rsp)
180007bc6:     	movq	0x310(%rsp), %rax
180007bce:     	movq	%rax, 0x100(%rsp)
180007bd6:     	movq	%rcx, 0xf8(%rsp)
180007bde:     	movq	0x2f8(%rsp), %rax
180007be6:     	movq	%rax, 0xe8(%rsp)
180007bee:     	movq	0x2f0(%rsp), %rax
180007bf6:     	movq	%rax, 0xe0(%rsp)
180007bfe:     	movq	%r15, 0xd8(%rsp)
180007c06:     	movq	0x2e0(%rsp), %rax
180007c0e:     	movq	%rax, 0xd0(%rsp)
180007c16:     	movq	0x2d8(%rsp), %rax
180007c1e:     	movq	%rax, 0xc8(%rsp)
180007c26:     	movq	0x2d0(%rsp), %rax
180007c2e:     	movq	%rax, 0xc0(%rsp)
180007c36:     	movq	0x2c8(%rsp), %rax
180007c3e:     	movq	%rax, 0xb8(%rsp)
180007c46:     	movq	0x2c0(%rsp), %rax
180007c4e:     	movq	%rax, 0xb0(%rsp)
180007c56:     	movq	0x2b8(%rsp), %rax
180007c5e:     	movq	%rax, 0xa8(%rsp)
180007c66:     	movq	%r12, 0xa0(%rsp)
180007c6e:     	movq	0x2a8(%rsp), %rax
180007c76:     	movq	%rax, 0x98(%rsp)
180007c7e:     	movq	0x2a0(%rsp), %rax
180007c86:     	movq	%rax, 0x90(%rsp)
180007c8e:     	movq	0x298(%rsp), %rax
180007c96:     	movq	%rax, 0x88(%rsp)
180007c9e:     	movq	0x290(%rsp), %rax
180007ca6:     	movq	%rax, 0x80(%rsp)
180007cae:     	movq	0x288(%rsp), %rax
180007cb6:     	movq	%rax, 0x78(%rsp)
180007cbb:     	movq	%rbx, 0x70(%rsp)
180007cc0:     	movq	%r13, 0x68(%rsp)
180007cc5:     	movq	0x270(%rsp), %rax
180007ccd:     	movq	%rax, 0x60(%rsp)
180007cd2:     	movq	0x268(%rsp), %rax
180007cda:     	movq	%rax, 0x58(%rsp)
180007cdf:     	movq	0x260(%rsp), %rax
180007ce7:     	movq	%rax, 0x50(%rsp)
180007cec:     	movq	%rdi, 0x48(%rsp)
180007cf1:     	movq	0x250(%rsp), %rax
180007cf9:     	movq	%rax, 0x40(%rsp)
180007cfe:     	movq	%r14, 0x38(%rsp)
180007d03:     	movq	%rbp, 0x30(%rsp)
180007d08:     	movq	0x238(%rsp), %rax
180007d10:     	movq	%rax, 0x28(%rsp)
180007d15:     	movq	0x230(%rsp), %rax
180007d1d:     	movq	%rax, 0x20(%rsp)
180007d22:     	movq	$-0x1, 0x108(%rsp)
180007d2e:     	movq	$0x0, 0xf0(%rsp)
180007d3a:     	leaq	0x11e(%rsp), %rcx
180007d42:     	leaq	0x198(%rsp), %rdx
180007d4a:     	movq	0x130(%rsp), %r8
180007d52:     	movq	0x138(%rsp), %r9
180007d5a:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180007d5f:     	testl	%eax, %eax
180007d61:     	jne	0x18000847a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48ea>
180007d67:     	cmpb	$0x0, (%r15)
180007d6b:     	je	0x180008151 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45c1>
180007d71:     	movq	0x110(%rsp), %rax
180007d79:     	jmp	0x18000792a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3d9a>
180007d7e:     	movq	%r10, 0x1b0(%rsp)
180007d86:     	movq	%r11, 0x1b8(%rsp)
180007d8e:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180007d98:     	andq	%rax, %r9
180007d9b:     	movq	0x148(%rsp), %r11
180007da3:     	leaq	(,%rbx,8), %r8
180007dab:     	xorl	%edx, %edx
180007dad:     	movq	%r9, 0x138(%rsp)
180007db5:     	leaq	(%r14,%rdx), %rax
180007db9:     	sarq	$0x3f, %rax
180007dbd:     	andq	%r8, %rax
180007dc0:     	leaq	(%r13,%r14,8), %rdi
180007dc5:     	addq	%rdi, %rax
180007dc8:     	movq	(%rax,%rdx,8), %rax
180007dcc:     	leaq	(%r11,%rdx), %r9
180007dd0:     	sarq	$0x3f, %r9
180007dd4:     	andq	%r8, %r9
180007dd7:     	leaq	(%r13,%r11,8), %r10
180007ddc:     	movq	%r10, 0x120(%rsp)
180007de4:     	addq	%r10, %r9
180007de7:     	movq	%rax, (%r9,%rdx,8)
180007deb:     	leaq	0x1(%r14,%rdx), %rax
180007df0:     	sarq	$0x3f, %rax
180007df4:     	andq	%r8, %rax
180007df7:     	movq	%rdi, %r10
180007dfa:     	addq	%rdi, %rax
180007dfd:     	movq	0x8(%rax,%rdx,8), %rax
180007e02:     	leaq	0x1(%r11,%rdx), %r9
180007e07:     	sarq	$0x3f, %r9
180007e0b:     	andq	%r8, %r9
180007e0e:     	movq	0x120(%rsp), %rdi
180007e16:     	addq	%rdi, %r9
180007e19:     	movq	%rax, 0x8(%r9,%rdx,8)
180007e1e:     	leaq	0x2(%r14,%rdx), %rax
180007e23:     	sarq	$0x3f, %rax
180007e27:     	andq	%r8, %rax
180007e2a:     	addq	%r10, %rax
180007e2d:     	movq	%r10, 0x130(%rsp)
180007e35:     	movq	0x10(%rax,%rdx,8), %rax
180007e3a:     	leaq	0x2(%r11,%rdx), %r9
180007e3f:     	sarq	$0x3f, %r9
180007e43:     	andq	%r8, %r9
180007e46:     	addq	%rdi, %r9
180007e49:     	movq	%rax, 0x10(%r9,%rdx,8)
180007e4e:     	leaq	0x3(%r14,%rdx), %rax
180007e53:     	sarq	$0x3f, %rax
180007e57:     	andq	%r8, %rax
180007e5a:     	addq	%r10, %rax
180007e5d:     	movq	0x18(%rax,%rdx,8), %rax
180007e62:     	leaq	0x3(%r11,%rdx), %r9
180007e67:     	sarq	$0x3f, %r9
180007e6b:     	andq	%r8, %r9
180007e6e:     	addq	%rdi, %r9
180007e71:     	movq	%rdi, %r10
180007e74:     	movq	%rax, 0x18(%r9,%rdx,8)
180007e79:     	leaq	0x4(%r14,%rdx), %rax
180007e7e:     	sarq	$0x3f, %rax
180007e82:     	andq	%r8, %rax
180007e85:     	movq	0x130(%rsp), %rdi
180007e8d:     	addq	%rdi, %rax
180007e90:     	movq	0x20(%rax,%rdx,8), %rax
180007e95:     	leaq	0x4(%r11,%rdx), %r9
180007e9a:     	sarq	$0x3f, %r9
180007e9e:     	andq	%r8, %r9
180007ea1:     	addq	%r10, %r9
180007ea4:     	movq	%rax, 0x20(%r9,%rdx,8)
180007ea9:     	leaq	0x5(%r14,%rdx), %rax
180007eae:     	sarq	$0x3f, %rax
180007eb2:     	andq	%r8, %rax
180007eb5:     	addq	%rdi, %rax
180007eb8:     	movq	0x28(%rax,%rdx,8), %rax
180007ebd:     	leaq	0x5(%r11,%rdx), %r9
180007ec2:     	sarq	$0x3f, %r9
180007ec6:     	andq	%r8, %r9
180007ec9:     	addq	0x120(%rsp), %r9
180007ed1:     	movq	%rax, 0x28(%r9,%rdx,8)
180007ed6:     	leaq	0x6(%r14,%rdx), %rax
180007edb:     	sarq	$0x3f, %rax
180007edf:     	andq	%r8, %rax
180007ee2:     	addq	%rdi, %rax
180007ee5:     	movq	0x30(%rax,%rdx,8), %rax
180007eea:     	leaq	0x6(%r11,%rdx), %r9
180007eef:     	sarq	$0x3f, %r9
180007ef3:     	andq	%r8, %r9
180007ef6:     	addq	0x120(%rsp), %r9
180007efe:     	movq	%rax, 0x30(%r9,%rdx,8)
180007f03:     	leaq	0x7(%r14,%rdx), %rax
180007f08:     	sarq	$0x3f, %rax
180007f0c:     	andq	%r8, %rax
180007f0f:     	addq	%rdi, %rax
180007f12:     	movq	0x38(%rax,%rdx,8), %rax
180007f17:     	leaq	0x7(%r11,%rdx), %r9
180007f1c:     	sarq	$0x3f, %r9
180007f20:     	andq	%r8, %r9
180007f23:     	addq	0x120(%rsp), %r9
180007f2b:     	movq	%rax, 0x38(%r9,%rdx,8)
180007f30:     	movq	0x138(%rsp), %r9
180007f38:     	addq	$0x8, %rdx
180007f3c:     	cmpq	%rdx, %r9
180007f3f:     	jne	0x180007db5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4225>
180007f45:     	movq	0x1b0(%rsp), %r10
180007f4d:     	testq	%r10, %r10
180007f50:     	movq	0x1b8(%rsp), %r11
180007f58:     	je	0x180007f96 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4406>
180007f5a:     	movq	0x148(%rsp), %rax
180007f62:     	leaq	(%r9,%rax), %rdx
180007f66:     	addq	%r9, %r14
180007f69:     	movq	%r14, %rax
180007f6c:     	sarq	$0x3f, %rax
180007f70:     	andq	%r8, %rax
180007f73:     	addq	%r13, %rax
180007f76:     	movq	(%rax,%r14,8), %rax
180007f7a:     	movq	%rdx, %r9
180007f7d:     	sarq	$0x3f, %r9
180007f81:     	andq	%r8, %r9
180007f84:     	addq	%r13, %r9
180007f87:     	movq	%rax, (%r9,%rdx,8)
180007f8b:     	incq	%rdx
180007f8e:     	incq	%r14
180007f91:     	decq	%r10
180007f94:     	jne	0x180007f69 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x43d9>
180007f96:     	movq	0x160(%rsp), %rax
180007f9e:     	movq	0x158(%rsp), %rdx
180007fa6:     	movq	0x150(%rsp), %r14
180007fae:     	movq	%rdx, 0x8(%r14,%rax,8)
180007fb3:     	movq	0x148(%rsp), %rax
180007fbb:     	movq	%rax, 0x10(%r14,%r11,8)
180007fc0:     	movq	0x110(%rsp), %rdx
180007fc8:     	movq	0x1c0(%rsp), %r10
180007fd0:     	leaq	0x1(%rdx), %rax
180007fd4:     	movq	0x140(%rsp), %r8
180007fdc:     	movq	%rax, (%r14,%r8,8)
180007fe0:     	cmpb	$0x0, (%r15)
180007fe4:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180007fea:     	xorl	%eax, %eax
180007fec:     	cmpq	$-0x2, %r10
180007ff0:     	cmovlq	%rbx, %rax
180007ff4:     	addq	0x10(%r14,%rax,8), %rdx
180007ff9:     	movq	%rdx, %rax
180007ffc:     	sarq	$0x3f, %rax
180008000:     	andq	%rbx, %rax
180008003:     	leaq	(%r13,%rdx,8), %rdx
180008008:     	movq	0x310(%rsp), %r8
180008010:     	movq	%r8, (%rdx,%rax,8)
180008014:     	movsd	0x48(%rbp,%rsi,8), %xmm1
18000801a:     	movsd	0x8(%rbp,%r8,8), %xmm2
180008021:     	movapd	%xmm1, %xmm0
180008025:     	addsd	%xmm2, %xmm0
180008029:     	xorpd	%xmm3, %xmm3
18000802d:     	ucomisd	%xmm3, %xmm0
180008031:     	jbe	0x180008131 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45a1>
180008037:     	movq	0x10(%r13,%rsi,8), %rax
18000803c:     	testq	%rax, %rax
18000803f:     	js	0x180008142 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45b2>
180008045:     	cmpq	$0x0, 0x8(%r13,%rax,8)
18000804b:     	mulsd	(%rbp,%rax,8), %xmm1
180008051:     	je	0x18000807d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x44ed>
180008053:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
180008059:     	je	0x18000807d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x44ed>
18000805b:     	movapd	0x535d(%rip), %xmm3     # 0x18000d3c0
180008063:     	andpd	%xmm1, %xmm3
180008067:     	ucomisd	0x5361(%rip), %xmm3     # 0x18000d3d0
18000806f:     	jae	0x180008142 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45b2>
180008075:     	xorpd	%xmm3, %xmm3
180008079:     	addsd	%xmm3, %xmm1
18000807d:     	movq	0x10(%r13,%r8,8), %rdx
180008082:     	testq	%rdx, %rdx
180008085:     	js	0x180008142 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45b2>
18000808b:     	mulsd	(%rbp,%rdx,8), %xmm2
180008091:     	addsd	%xmm2, %xmm1
180008095:     	divsd	%xmm0, %xmm1
180008099:     	movsd	%xmm1, (%rbp,%rax,8)
18000809f:     	movq	$0x0, 0x8(%r13,%rax,8)
1800080a8:     	movq	0x10(%r13,%rsi,8), %rax
1800080ad:     	testq	%rax, %rax
1800080b0:     	js	0x180008178 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45e8>
1800080b6:     	movsd	0x10(%rbp,%rax,8), %xmm1
1800080bc:     	cmpq	$0x0, 0x18(%r13,%rax,8)
1800080c2:     	mulsd	0x48(%rbp,%rsi,8), %xmm1
1800080c8:     	je	0x1800080f4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4564>
1800080ca:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
1800080d0:     	je	0x1800080f4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4564>
1800080d2:     	movapd	0x52e6(%rip), %xmm2     # 0x18000d3c0
1800080da:     	andpd	%xmm1, %xmm2
1800080de:     	ucomisd	0x52ea(%rip), %xmm2     # 0x18000d3d0
1800080e6:     	jae	0x180008178 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45e8>
1800080ec:     	xorpd	%xmm2, %xmm2
1800080f0:     	addsd	%xmm2, %xmm1
1800080f4:     	movq	0x310(%rsp), %rdx
1800080fc:     	movq	0x10(%r13,%rdx,8), %rdx
180008101:     	testq	%rdx, %rdx
180008104:     	js	0x180008178 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45e8>
180008106:     	movsd	0x10(%rbp,%rdx,8), %xmm2
18000810c:     	movq	0x310(%rsp), %rdx
180008114:     	mulsd	0x8(%rbp,%rdx,8), %xmm2
18000811a:     	addsd	%xmm2, %xmm1
18000811e:     	divsd	%xmm0, %xmm1
180008122:     	movsd	%xmm1, 0x10(%rbp,%rax,8)
180008128:     	movq	$0x0, 0x18(%r13,%rax,8)
180008131:     	movsd	%xmm0, 0x48(%rbp,%rsi,8)
180008137:     	movq	$0x0, 0x50(%r13,%rsi,8)
180008140:     	jmp	0x180008185 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45f5>
180008142:     	movb	$0x1, (%r15)
180008146:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
18000814f:     	jmp	0x180008185 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45f5>
180008151:     	movzbl	0x11e(%rsp), %eax
180008159:     	movq	0x8(%r12), %rcx
18000815e:     	leaq	-0x1(%rcx), %rdx
180008162:     	movq	%rdx, 0x8(%r12)
180008167:     	testb	$0x1, %al
180008169:     	je	0x180008197 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4607>
18000816b:     	movq	0x110(%rsp), %rax
180008173:     	jmp	0x180007b91 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4001>
180008178:     	movb	$0x1, (%r15)
18000817c:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180008185:     	cmpb	$0x0, (%r15)
180008189:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
18000818f:     	movb	$0x1, (%rcx)
180008192:     	jmp	0x180007b51 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fc1>
180008197:     	movq	0x38(%r13,%rsi,8), %rax
18000819c:     	testq	%rax, %rax
18000819f:     	js	0x1800081ad <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x461d>
1800081a1:     	movq	%rcx, 0x8(%r12)
1800081a6:     	cmpq	0x10(%r12), %rcx
1800081ab:     	jle	0x1800081e1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4651>
1800081ad:     	movb	$0x1, (%r15)
1800081b1:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
1800081ba:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800081bf:     	movq	0x1a0(%rsp), %rdx
1800081c7:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
1800081c9:     	movq	0x1a8(%rsp), %rdx
1800081d1:     	movq	0x120(%rsp), %rcx
1800081d9:     	movq	%rdx, (%rcx)
1800081dc:     	jmp	0x180007b53 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fc3>
1800081e1:     	movb	$0x0, 0x11d(%rsp)
1800081e9:     	movq	0x310(%rsp), %rcx
1800081f1:     	movq	%rcx, 0x100(%rsp)
1800081f9:     	movq	%rax, 0xf8(%rsp)
180008201:     	movq	0x2f8(%rsp), %rax
180008209:     	movq	%rax, 0xe8(%rsp)
180008211:     	movq	0x2f0(%rsp), %rax
180008219:     	movq	%rax, 0xe0(%rsp)
180008221:     	movq	%r15, 0xd8(%rsp)
180008229:     	movq	0x2e0(%rsp), %rax
180008231:     	movq	%rax, 0xd0(%rsp)
180008239:     	movq	0x2d8(%rsp), %rax
180008241:     	movq	%rax, 0xc8(%rsp)
180008249:     	movq	0x2d0(%rsp), %rax
180008251:     	movq	%rax, 0xc0(%rsp)
180008259:     	movq	0x2c8(%rsp), %rax
180008261:     	movq	%rax, 0xb8(%rsp)
180008269:     	movq	0x2c0(%rsp), %rax
180008271:     	movq	%rax, 0xb0(%rsp)
180008279:     	movq	0x2b8(%rsp), %rax
180008281:     	movq	%rax, 0xa8(%rsp)
180008289:     	movq	%r12, 0xa0(%rsp)
180008291:     	movq	0x2a8(%rsp), %rax
180008299:     	movq	%rax, 0x98(%rsp)
1800082a1:     	movq	0x2a0(%rsp), %rax
1800082a9:     	movq	%rax, 0x90(%rsp)
1800082b1:     	movq	0x298(%rsp), %rax
1800082b9:     	movq	%rax, 0x88(%rsp)
1800082c1:     	movq	0x290(%rsp), %rax
1800082c9:     	movq	%rax, 0x80(%rsp)
1800082d1:     	movq	0x288(%rsp), %rax
1800082d9:     	movq	%rax, 0x78(%rsp)
1800082de:     	movq	%rbx, 0x70(%rsp)
1800082e3:     	movq	%r13, 0x68(%rsp)
1800082e8:     	movq	0x270(%rsp), %rax
1800082f0:     	movq	%rax, 0x60(%rsp)
1800082f5:     	movq	0x268(%rsp), %rax
1800082fd:     	movq	%rax, 0x58(%rsp)
180008302:     	movq	0x260(%rsp), %rax
18000830a:     	movq	%rax, 0x50(%rsp)
18000830f:     	movq	0x258(%rsp), %rax
180008317:     	movq	%rax, 0x48(%rsp)
18000831c:     	movq	0x250(%rsp), %rax
180008324:     	movq	%rax, 0x40(%rsp)
180008329:     	movq	0x248(%rsp), %rax
180008331:     	movq	%rax, 0x38(%rsp)
180008336:     	movq	%rbp, 0x30(%rsp)
18000833b:     	movq	0x238(%rsp), %rax
180008343:     	movq	%rax, 0x28(%rsp)
180008348:     	movq	0x230(%rsp), %rax
180008350:     	movq	%rax, 0x20(%rsp)
180008355:     	movq	$-0x1, 0x108(%rsp)
180008361:     	movq	$0x0, 0xf0(%rsp)
18000836d:     	leaq	0x11d(%rsp), %rcx
180008375:     	leaq	0x190(%rsp), %rdx
18000837d:     	movq	0x130(%rsp), %r8
180008385:     	movq	0x138(%rsp), %r9
18000838d:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180008392:     	testl	%eax, %eax
180008394:     	jne	0x1800087b7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4c27>
18000839a:     	cmpb	$0x0, (%r15)
18000839e:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800083a4:     	movzbl	0x11d(%rsp), %eax
1800083ac:     	movq	0x8(%r12), %rcx
1800083b1:     	leaq	-0x1(%rcx), %rdx
1800083b5:     	movq	%rdx, 0x8(%r12)
1800083ba:     	testb	$0x1, %al
1800083bc:     	jne	0x18000816b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45db>
1800083c2:     	movq	0x40(%r13,%rsi,8), %rax
1800083c7:     	testq	%rax, %rax
1800083ca:     	js	0x1800083dc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x484c>
1800083cc:     	movq	%rcx, 0x8(%r12)
1800083d1:     	cmpq	0x10(%r12), %rcx
1800083d6:     	jle	0x1800084bf <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x492f>
1800083dc:     	movb	$0x1, (%r15)
1800083e0:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
1800083e9:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800083ee:     	movb	$0x1, (%r15)
1800083f2:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
1800083f7:     	movq	%r12, %rcx
1800083fa:     	movq	%rdx, 0x18(%rcx)
1800083fe:     	cmpb	$0x0, (%r15)
180008402:     	movq	0x110(%rsp), %rcx
18000840a:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180008410:     	movq	%r11, 0x10(%r10)
180008414:     	movq	0x140(%rsp), %rax
18000841c:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008425:     	movq	$0x1, 0x50(%r10)
18000842d:     	movq	$-0x1, 0x20(%r10)
180008435:     	movq	$-0x1, 0x28(%r10)
18000843d:     	movq	$-0x1, 0x38(%r10)
180008445:     	movq	$-0x1, 0x40(%r10)
18000844d:     	cmpb	$0x0, (%r15)
180008451:     	jne	0x180007b4e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fbe>
180008457:     	movq	0x140(%rsp), %rax
18000845f:     	movq	%rax, 0x20(%r13,%rsi,8)
180008464:     	movq	(%r12), %rcx
180008468:     	leaq	0x4(%rcx), %rax
18000846c:     	cmpq	%rbx, %rax
18000846f:     	jle	0x180008487 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48f7>
180008471:     	movb	$0x2, (%r15)
180008475:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000847a:     	movq	0x198(%rsp), %rdx
180008482:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
180008487:     	movq	%rax, (%r12)
18000848b:     	cmpb	$0x0, (%r15)
18000848f:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008495:     	subsd	%xmm3, %xmm1
180008499:     	testq	%rcx, %rcx
18000849c:     	js	0x18000869c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4b0c>
1800084a2:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
1800084a8:     	movsd	%xmm5, 0x18(%rbp,%rcx,8)
1800084ae:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
1800084b4:     	movsd	%xmm0, (%rbp,%rcx,8)
1800084ba:     	jmp	0x1800086a9 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4b19>
1800084bf:     	movb	$0x0, 0x11c(%rsp)
1800084c7:     	movq	0x310(%rsp), %rcx
1800084cf:     	movq	%rcx, 0x100(%rsp)
1800084d7:     	movq	%rax, 0xf8(%rsp)
1800084df:     	movq	0x2f8(%rsp), %rax
1800084e7:     	movq	%rax, 0xe8(%rsp)
1800084ef:     	movq	0x2f0(%rsp), %rax
1800084f7:     	movq	%rax, 0xe0(%rsp)
1800084ff:     	movq	0x2e0(%rsp), %rax
180008507:     	movq	%rax, 0xd0(%rsp)
18000850f:     	movq	0x2d8(%rsp), %rax
180008517:     	movq	%rax, 0xc8(%rsp)
18000851f:     	movq	0x2d0(%rsp), %rax
180008527:     	movq	%rax, 0xc0(%rsp)
18000852f:     	movq	0x2c8(%rsp), %rax
180008537:     	movq	%rax, 0xb8(%rsp)
18000853f:     	movq	0x2c0(%rsp), %rax
180008547:     	movq	%rax, 0xb0(%rsp)
18000854f:     	movq	0x2b8(%rsp), %rax
180008557:     	movq	%rax, 0xa8(%rsp)
18000855f:     	movq	0x2a8(%rsp), %rax
180008567:     	movq	%rax, 0x98(%rsp)
18000856f:     	movq	0x2a0(%rsp), %rax
180008577:     	movq	%rax, 0x90(%rsp)
18000857f:     	movq	0x298(%rsp), %rax
180008587:     	movq	%rax, 0x88(%rsp)
18000858f:     	movq	0x290(%rsp), %rax
180008597:     	movq	%rax, 0x80(%rsp)
18000859f:     	movq	0x288(%rsp), %rax
1800085a7:     	movq	%rax, 0x78(%rsp)
1800085ac:     	movq	%rbx, 0x70(%rsp)
1800085b1:     	movq	%r13, 0x68(%rsp)
1800085b6:     	movq	0x270(%rsp), %rax
1800085be:     	movq	%rax, 0x60(%rsp)
1800085c3:     	movq	0x268(%rsp), %rax
1800085cb:     	movq	%rax, 0x58(%rsp)
1800085d0:     	movq	0x260(%rsp), %rax
1800085d8:     	movq	%rax, 0x50(%rsp)
1800085dd:     	movq	0x258(%rsp), %rax
1800085e5:     	movq	%rax, 0x48(%rsp)
1800085ea:     	movq	0x250(%rsp), %rax
1800085f2:     	movq	%rax, 0x40(%rsp)
1800085f7:     	movq	0x248(%rsp), %rax
1800085ff:     	movq	%rax, 0x38(%rsp)
180008604:     	movq	%rbp, 0x30(%rsp)
180008609:     	movq	%r15, 0xd8(%rsp)
180008611:     	movq	%r12, 0xa0(%rsp)
180008619:     	movq	0x238(%rsp), %rax
180008621:     	movq	%rax, 0x28(%rsp)
180008626:     	movq	0x230(%rsp), %rax
18000862e:     	movq	%rax, 0x20(%rsp)
180008633:     	movq	$-0x1, 0x108(%rsp)
18000863f:     	movq	$0x0, 0xf0(%rsp)
18000864b:     	leaq	0x11c(%rsp), %rcx
180008653:     	leaq	0x188(%rsp), %rdx
18000865b:     	movq	0x130(%rsp), %r8
180008663:     	movq	0x138(%rsp), %r9
18000866b:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180008670:     	testl	%eax, %eax
180008672:     	jne	0x1800087c4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4c34>
180008678:     	cmpb	$0x0, (%r15)
18000867c:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008682:     	movzbl	0x11c(%rsp), %eax
18000868a:     	decq	0x8(%r12)
18000868f:     	testb	$0x1, %al
180008691:     	je	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008697:     	jmp	0x18000816b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x45db>
18000869c:     	movb	$0x1, (%r15)
1800086a0:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800086a9:     	cmpb	$0x0, (%r15)
1800086ad:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800086b3:     	movq	(%r12), %rax
1800086b7:     	leaq	0xb(%rax), %r8
1800086bb:     	cmpq	%rbx, %r8
1800086be:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
1800086c4:     	movq	0x8(%r13,%rsi,8), %rdx
1800086c9:     	movq	%r8, (%r12)
1800086cd:     	cmpb	$0x0, (%r15)
1800086d1:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800086d7:     	movq	%rcx, (%r13,%rax,8)
1800086dc:     	movq	%rdx, 0x8(%r13,%rax,8)
1800086e1:     	movq	(%r12), %rdx
1800086e5:     	cmpq	%rbx, %rdx
1800086e8:     	movq	%rdx, %rcx
1800086eb:     	jle	0x1800086f7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4b67>
1800086ed:     	movb	$0x2, (%r15)
1800086f1:     	movq	(%r12), %rdx
1800086f5:     	xorl	%ecx, %ecx
1800086f7:     	leaq	0x3(%rdx), %r8
1800086fb:     	cmpq	%rbx, %r8
1800086fe:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008704:     	movq	%r8, (%r12)
180008708:     	cmpb	$0x0, (%r15)
18000870c:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008712:     	movq	%rdx, %r8
180008715:     	sarq	$0x3f, %r8
180008719:     	andq	%rbx, %r8
18000871c:     	leaq	(%r13,%rdx,8), %r9
180008721:     	movq	$0x0, (%r9,%r8,8)
180008729:     	xorl	%r8d, %r8d
18000872c:     	cmpq	$-0x1, %rdx
180008730:     	movl	$0x0, %r10d
180008736:     	cmovlq	%rbx, %r10
18000873a:     	movq	$0x0, 0x8(%r9,%r10,8)
180008743:     	cmpq	$-0x2, %rdx
180008747:     	cmovlq	%rbx, %r8
18000874b:     	movq	%rcx, 0x10(%r9,%r8,8)
180008750:     	cmpb	$0x0, (%r15)
180008754:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000875a:     	leaq	(%r13,%rax,8), %rcx
18000875f:     	movq	%rdx, 0x30(%rcx)
180008763:     	movq	$0x0, 0x18(%rcx)
18000876b:     	movq	(%r12), %rdx
18000876f:     	leaq	0x4(%rdx), %r8
180008773:     	cmpq	%rbx, %r8
180008776:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
18000877c:     	movq	%r8, (%r12)
180008780:     	cmpb	$0x0, (%r15)
180008784:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000878a:     	testq	%rdx, %rdx
18000878d:     	js	0x1800087d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4c41>
18000878f:     	movq	$0x0, (%rbp,%rdx,8)
180008798:     	leaq	(%r13,%rdx,8), %r8
18000879d:     	movq	$0x1, 0x8(%r13,%rdx,8)
1800087a6:     	movq	$0x0, 0x10(%rbp,%rdx,8)
1800087af:     	movl	$0x1, %r9d
1800087b5:     	jmp	0x1800087de <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4c4e>
1800087b7:     	movq	0x190(%rsp), %rdx
1800087bf:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
1800087c4:     	movq	0x188(%rsp), %rdx
1800087cc:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
1800087d1:     	movb	$0x1, (%r15)
1800087d5:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
1800087db:     	movq	%r12, %r8
1800087de:     	movq	%r9, 0x18(%r8)
1800087e2:     	cmpb	$0x0, (%r15)
1800087e6:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800087ec:     	movq	%rdx, 0x10(%rcx)
1800087f0:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800087f9:     	movq	$0x1, 0x50(%rcx)
180008801:     	movq	$-0x1, 0x20(%rcx)
180008809:     	movq	$-0x1, 0x28(%rcx)
180008811:     	movq	$-0x1, 0x38(%rcx)
180008819:     	movq	$-0x1, 0x40(%rcx)
180008821:     	cmpb	$0x0, (%r15)
180008825:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000882b:     	movq	%rax, 0x28(%r13,%rsi,8)
180008830:     	movq	(%r12), %rcx
180008834:     	leaq	0x4(%rcx), %rax
180008838:     	cmpq	%rbx, %rax
18000883b:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008841:     	movq	%rax, (%r12)
180008845:     	cmpb	$0x0, (%r15)
180008849:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000884f:     	addsd	%xmm0, %xmm2
180008853:     	testq	%rcx, %rcx
180008856:     	js	0x180008872 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4ce2>
180008858:     	movsd	%xmm4, 0x10(%rbp,%rcx,8)
18000885e:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008864:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
18000886a:     	movsd	%xmm0, (%rbp,%rcx,8)
180008870:     	jmp	0x18000887f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4cef>
180008872:     	movb	$0x1, (%r15)
180008876:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
18000887f:     	cmpb	$0x0, (%r15)
180008883:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008889:     	movq	(%r12), %rax
18000888d:     	leaq	0xb(%rax), %r8
180008891:     	cmpq	%rbx, %r8
180008894:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
18000889a:     	movq	0x8(%r13,%rsi,8), %rdx
18000889f:     	movq	%r8, (%r12)
1800088a3:     	cmpb	$0x0, (%r15)
1800088a7:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800088ad:     	movq	%rcx, (%r13,%rax,8)
1800088b2:     	movq	%rdx, 0x8(%r13,%rax,8)
1800088b7:     	movq	(%r12), %rdx
1800088bb:     	cmpq	%rbx, %rdx
1800088be:     	movq	%rdx, %rcx
1800088c1:     	jle	0x1800088cd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4d3d>
1800088c3:     	movb	$0x2, (%r15)
1800088c7:     	movq	(%r12), %rdx
1800088cb:     	xorl	%ecx, %ecx
1800088cd:     	leaq	0x3(%rdx), %r8
1800088d1:     	cmpq	%rbx, %r8
1800088d4:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
1800088da:     	movq	%r8, (%r12)
1800088de:     	cmpb	$0x0, (%r15)
1800088e2:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800088e8:     	movq	%rdx, %r8
1800088eb:     	sarq	$0x3f, %r8
1800088ef:     	andq	%rbx, %r8
1800088f2:     	leaq	(%r13,%rdx,8), %r9
1800088f7:     	movq	$0x0, (%r9,%r8,8)
1800088ff:     	xorl	%r8d, %r8d
180008902:     	cmpq	$-0x1, %rdx
180008906:     	movl	$0x0, %r10d
18000890c:     	cmovlq	%rbx, %r10
180008910:     	movq	$0x0, 0x8(%r9,%r10,8)
180008919:     	cmpq	$-0x2, %rdx
18000891d:     	cmovlq	%rbx, %r8
180008921:     	movq	%rcx, 0x10(%r9,%r8,8)
180008926:     	cmpb	$0x0, (%r15)
18000892a:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008930:     	leaq	(%r13,%rax,8), %rcx
180008935:     	movq	%rdx, 0x30(%rcx)
180008939:     	movq	$0x0, 0x18(%rcx)
180008941:     	movq	(%r12), %rdx
180008945:     	leaq	0x4(%rdx), %r8
180008949:     	cmpq	%rbx, %r8
18000894c:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008952:     	movq	%r8, (%r12)
180008956:     	cmpb	$0x0, (%r15)
18000895a:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008960:     	testq	%rdx, %rdx
180008963:     	js	0x18000898d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4dfd>
180008965:     	movq	$0x0, (%rbp,%rdx,8)
18000896e:     	leaq	(%r13,%rdx,8), %r8
180008973:     	movq	$0x1, 0x8(%r13,%rdx,8)
18000897c:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008985:     	movl	$0x1, %r9d
18000898b:     	jmp	0x18000899a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4e0a>
18000898d:     	movb	$0x1, (%r15)
180008991:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008997:     	movq	%r12, %r8
18000899a:     	movq	%r9, 0x18(%r8)
18000899e:     	cmpb	$0x0, (%r15)
1800089a2:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800089a8:     	movq	%rdx, 0x10(%rcx)
1800089ac:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800089b5:     	movq	$0x1, 0x50(%rcx)
1800089bd:     	movq	$-0x1, 0x20(%rcx)
1800089c5:     	movq	$-0x1, 0x28(%rcx)
1800089cd:     	movq	$-0x1, 0x38(%rcx)
1800089d5:     	movq	$-0x1, 0x40(%rcx)
1800089dd:     	cmpb	$0x0, (%r15)
1800089e1:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800089e7:     	movq	%rax, 0x38(%r13,%rsi,8)
1800089ec:     	movq	(%r12), %rcx
1800089f0:     	leaq	0x4(%rcx), %rax
1800089f4:     	cmpq	%rbx, %rax
1800089f7:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
1800089fd:     	movq	%rax, (%r12)
180008a01:     	cmpb	$0x0, (%r15)
180008a05:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008a0b:     	testq	%rcx, %rcx
180008a0e:     	js	0x180008a2a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4e9a>
180008a10:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
180008a16:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008a1c:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008a22:     	movsd	%xmm0, (%rbp,%rcx,8)
180008a28:     	jmp	0x180008a37 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4ea7>
180008a2a:     	movb	$0x1, (%r15)
180008a2e:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008a37:     	cmpb	$0x0, (%r15)
180008a3b:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008a41:     	movq	(%r12), %rax
180008a45:     	leaq	0xb(%rax), %r8
180008a49:     	cmpq	%rbx, %r8
180008a4c:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008a52:     	movq	0x8(%r13,%rsi,8), %rdx
180008a57:     	movq	%r8, (%r12)
180008a5b:     	cmpb	$0x0, (%r15)
180008a5f:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008a65:     	movq	%rcx, (%r13,%rax,8)
180008a6a:     	movq	%rdx, 0x8(%r13,%rax,8)
180008a6f:     	movq	(%r12), %rdx
180008a73:     	cmpq	%rbx, %rdx
180008a76:     	movq	%rdx, %rcx
180008a79:     	jle	0x180008a85 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4ef5>
180008a7b:     	movb	$0x2, (%r15)
180008a7f:     	movq	(%r12), %rdx
180008a83:     	xorl	%ecx, %ecx
180008a85:     	leaq	0x3(%rdx), %r8
180008a89:     	cmpq	%rbx, %r8
180008a8c:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008a92:     	movq	%r8, (%r12)
180008a96:     	cmpb	$0x0, (%r15)
180008a9a:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008aa0:     	movq	%rdx, %r8
180008aa3:     	sarq	$0x3f, %r8
180008aa7:     	andq	%rbx, %r8
180008aaa:     	leaq	(%r13,%rdx,8), %r9
180008aaf:     	movq	$0x0, (%r9,%r8,8)
180008ab7:     	xorl	%r8d, %r8d
180008aba:     	cmpq	$-0x1, %rdx
180008abe:     	movl	$0x0, %r10d
180008ac4:     	cmovlq	%rbx, %r10
180008ac8:     	movq	$0x0, 0x8(%r9,%r10,8)
180008ad1:     	cmpq	$-0x2, %rdx
180008ad5:     	cmovlq	%rbx, %r8
180008ad9:     	movq	%rcx, 0x10(%r9,%r8,8)
180008ade:     	cmpb	$0x0, (%r15)
180008ae2:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008ae8:     	leaq	(%r13,%rax,8), %rcx
180008aed:     	movq	%rdx, 0x30(%rcx)
180008af1:     	movq	$0x0, 0x18(%rcx)
180008af9:     	movq	(%r12), %rdx
180008afd:     	leaq	0x4(%rdx), %r8
180008b01:     	cmpq	%rbx, %r8
180008b04:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
180008b0a:     	movq	%r8, (%r12)
180008b0e:     	cmpb	$0x0, (%r15)
180008b12:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008b18:     	testq	%rdx, %rdx
180008b1b:     	js	0x180008b45 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4fb5>
180008b1d:     	movq	$0x0, (%rbp,%rdx,8)
180008b26:     	leaq	(%r13,%rdx,8), %r8
180008b2b:     	movq	$0x1, 0x8(%r13,%rdx,8)
180008b34:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008b3d:     	movl	$0x1, %r9d
180008b43:     	jmp	0x180008b52 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4fc2>
180008b45:     	movb	$0x1, (%r15)
180008b49:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008b4f:     	movq	%r12, %r8
180008b52:     	movq	%r9, 0x18(%r8)
180008b56:     	cmpb	$0x0, (%r15)
180008b5a:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008b60:     	movq	%rdx, 0x10(%rcx)
180008b64:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008b6d:     	movq	$0x1, 0x50(%rcx)
180008b75:     	movq	$-0x1, 0x20(%rcx)
180008b7d:     	movq	$-0x1, 0x28(%rcx)
180008b85:     	movq	$-0x1, 0x38(%rcx)
180008b8d:     	movq	$-0x1, 0x40(%rcx)
180008b95:     	cmpb	$0x0, (%r15)
180008b99:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008b9f:     	movq	%rax, 0x40(%r13,%rsi,8)
180008ba4:     	movq	$0x1, 0x18(%r13,%rsi,8)
180008bad:     	movq	0x30(%r13,%rsi,8), %rax
180008bb2:     	movq	%rax, %rcx
180008bb5:     	sarq	$0x3f, %rcx
180008bb9:     	andq	%rbx, %rcx
180008bbc:     	leaq	(%r13,%rax,8), %rdx
180008bc1:     	movq	%rcx, 0x160(%rsp)
180008bc9:     	movq	%rdx, 0x150(%rsp)
180008bd1:     	cmpq	$0x0, (%rdx,%rcx,8)
180008bd6:     	jle	0x1800093c1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5831>
180008bdc:     	leaq	(,%rbx,8), %rcx
180008be4:     	xorl	%edx, %edx
180008be6:     	cmpq	$-0x2, %rax
180008bea:     	movl	$0x0, %eax
180008bef:     	movq	%rax, 0x148(%rsp)
180008bf7:     	cmovgeq	%rdx, %rcx
180008bfb:     	movq	%rcx, 0x158(%rsp)
180008c03:     	movq	0x20(%r13,%rsi,8), %rax
180008c08:     	testq	%rax, %rax
180008c0b:     	js	0x18000944e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58be>
180008c11:     	movq	0x150(%rsp), %rcx
180008c19:     	movq	0x158(%rsp), %rdx
180008c21:     	movq	0x10(%rcx,%rdx), %rcx
180008c26:     	addq	0x148(%rsp), %rcx
180008c2e:     	leaq	(%r13,%rcx,8), %rdx
180008c33:     	sarq	$0x3f, %rcx
180008c37:     	andq	%rbx, %rcx
180008c3a:     	movq	(%rdx,%rcx,8), %rcx
180008c3e:     	movq	%rcx, 0x140(%rsp)
180008c46:     	movq	0x8(%r12), %rcx
180008c4b:     	leaq	0x1(%rcx), %rdx
180008c4f:     	movq	%rdx, 0x8(%r12)
180008c54:     	cmpq	0x10(%r12), %rcx
180008c59:     	jge	0x18000944e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58be>
180008c5f:     	movq	0x140(%rsp), %rcx
180008c67:     	movq	%rcx, 0x100(%rsp)
180008c6f:     	movq	%rax, 0xf8(%rsp)
180008c77:     	movq	0x2f8(%rsp), %rax
180008c7f:     	movq	%rax, 0xe8(%rsp)
180008c87:     	movq	0x2f0(%rsp), %rax
180008c8f:     	movq	%rax, 0xe0(%rsp)
180008c97:     	movq	%r15, 0xd8(%rsp)
180008c9f:     	movq	0x2e0(%rsp), %rax
180008ca7:     	movq	%rax, 0xd0(%rsp)
180008caf:     	movq	0x2d8(%rsp), %rax
180008cb7:     	movq	%rax, 0xc8(%rsp)
180008cbf:     	movq	0x2d0(%rsp), %rax
180008cc7:     	movq	%rax, 0xc0(%rsp)
180008ccf:     	movq	0x2c8(%rsp), %rax
180008cd7:     	movq	%rax, 0xb8(%rsp)
180008cdf:     	movq	0x2c0(%rsp), %rax
180008ce7:     	movq	%rax, 0xb0(%rsp)
180008cef:     	movq	0x2b8(%rsp), %rax
180008cf7:     	movq	%rax, 0xa8(%rsp)
180008cff:     	movq	%r12, 0xa0(%rsp)
180008d07:     	movq	0x2a8(%rsp), %rax
180008d0f:     	movq	%rax, 0x98(%rsp)
180008d17:     	movq	0x2a0(%rsp), %rax
180008d1f:     	movq	%rax, 0x90(%rsp)
180008d27:     	movq	0x298(%rsp), %rax
180008d2f:     	movq	%rax, 0x88(%rsp)
180008d37:     	movq	0x290(%rsp), %rax
180008d3f:     	movq	%rax, 0x80(%rsp)
180008d47:     	movq	0x288(%rsp), %rax
180008d4f:     	movq	%rax, 0x78(%rsp)
180008d54:     	movq	%rbx, 0x70(%rsp)
180008d59:     	movq	%r13, 0x68(%rsp)
180008d5e:     	movq	0x270(%rsp), %rax
180008d66:     	movq	%rax, 0x60(%rsp)
180008d6b:     	movq	0x268(%rsp), %rax
180008d73:     	movq	%rax, 0x58(%rsp)
180008d78:     	movq	0x260(%rsp), %rax
180008d80:     	movq	%rax, 0x50(%rsp)
180008d85:     	movq	%rdi, 0x48(%rsp)
180008d8a:     	movq	0x250(%rsp), %rax
180008d92:     	movq	%rax, 0x40(%rsp)
180008d97:     	movq	%r14, 0x38(%rsp)
180008d9c:     	movq	%rbp, 0x30(%rsp)
180008da1:     	movq	0x238(%rsp), %rax
180008da9:     	movq	%rax, 0x28(%rsp)
180008dae:     	movq	0x230(%rsp), %rax
180008db6:     	movq	%rax, 0x20(%rsp)
180008dbb:     	movq	$-0x1, 0x108(%rsp)
180008dc7:     	movq	$0x0, 0xf0(%rsp)
180008dd3:     	leaq	0x12e(%rsp), %rcx
180008ddb:     	leaq	0x180(%rsp), %rdx
180008de3:     	movq	0x130(%rsp), %r8
180008deb:     	movq	0x138(%rsp), %r9
180008df3:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180008df8:     	testl	%eax, %eax
180008dfa:     	jne	0x180009460 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58d0>
180008e00:     	cmpb	$0x0, (%r15)
180008e04:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008e0a:     	movq	0x8(%r12), %rcx
180008e0f:     	leaq	-0x1(%rcx), %rax
180008e13:     	movq	%rax, 0x8(%r12)
180008e18:     	movq	0x28(%r13,%rsi,8), %rax
180008e1d:     	testq	%rax, %rax
180008e20:     	js	0x18000946d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58dd>
180008e26:     	movq	%rcx, 0x8(%r12)
180008e2b:     	cmpq	0x10(%r12), %rcx
180008e30:     	jg	0x18000946d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58dd>
180008e36:     	movq	0x140(%rsp), %rcx
180008e3e:     	movq	%rcx, 0x100(%rsp)
180008e46:     	movq	%rax, 0xf8(%rsp)
180008e4e:     	movq	0x2f8(%rsp), %rax
180008e56:     	movq	%rax, 0xe8(%rsp)
180008e5e:     	movq	0x2f0(%rsp), %rax
180008e66:     	movq	%rax, 0xe0(%rsp)
180008e6e:     	movq	%r15, 0xd8(%rsp)
180008e76:     	movq	0x2e0(%rsp), %rax
180008e7e:     	movq	%rax, 0xd0(%rsp)
180008e86:     	movq	0x2d8(%rsp), %rax
180008e8e:     	movq	%rax, 0xc8(%rsp)
180008e96:     	movq	0x2d0(%rsp), %rax
180008e9e:     	movq	%rax, 0xc0(%rsp)
180008ea6:     	movq	0x2c8(%rsp), %rax
180008eae:     	movq	%rax, 0xb8(%rsp)
180008eb6:     	movq	0x2c0(%rsp), %rax
180008ebe:     	movq	%rax, 0xb0(%rsp)
180008ec6:     	movq	0x2b8(%rsp), %rax
180008ece:     	movq	%rax, 0xa8(%rsp)
180008ed6:     	movq	%r12, 0xa0(%rsp)
180008ede:     	movq	0x2a8(%rsp), %rax
180008ee6:     	movq	%rax, 0x98(%rsp)
180008eee:     	movq	0x2a0(%rsp), %rax
180008ef6:     	movq	%rax, 0x90(%rsp)
180008efe:     	movq	0x298(%rsp), %rax
180008f06:     	movq	%rax, 0x88(%rsp)
180008f0e:     	movq	0x290(%rsp), %rax
180008f16:     	movq	%rax, 0x80(%rsp)
180008f1e:     	movq	0x288(%rsp), %rax
180008f26:     	movq	%rax, 0x78(%rsp)
180008f2b:     	movq	%rbx, 0x70(%rsp)
180008f30:     	movq	%r13, 0x68(%rsp)
180008f35:     	movq	0x270(%rsp), %rax
180008f3d:     	movq	%rax, 0x60(%rsp)
180008f42:     	movq	0x268(%rsp), %rax
180008f4a:     	movq	%rax, 0x58(%rsp)
180008f4f:     	movq	0x260(%rsp), %rax
180008f57:     	movq	%rax, 0x50(%rsp)
180008f5c:     	movq	%rdi, 0x48(%rsp)
180008f61:     	movq	0x250(%rsp), %rax
180008f69:     	movq	%rax, 0x40(%rsp)
180008f6e:     	movq	%r14, 0x38(%rsp)
180008f73:     	movq	%rbp, 0x30(%rsp)
180008f78:     	movq	0x238(%rsp), %rax
180008f80:     	movq	%rax, 0x28(%rsp)
180008f85:     	movq	0x230(%rsp), %rax
180008f8d:     	movq	%rax, 0x20(%rsp)
180008f92:     	movq	$-0x1, 0x108(%rsp)
180008f9e:     	movq	$0x0, 0xf0(%rsp)
180008faa:     	leaq	0x12d(%rsp), %rcx
180008fb2:     	leaq	0x178(%rsp), %rdx
180008fba:     	movq	0x130(%rsp), %r8
180008fc2:     	movq	0x138(%rsp), %r9
180008fca:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
180008fcf:     	testl	%eax, %eax
180008fd1:     	jne	0x18000947f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58ef>
180008fd7:     	cmpb	$0x0, (%r15)
180008fdb:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180008fe1:     	movq	0x8(%r12), %rcx
180008fe6:     	leaq	-0x1(%rcx), %rax
180008fea:     	movq	%rax, 0x8(%r12)
180008fef:     	movq	0x38(%r13,%rsi,8), %rax
180008ff4:     	testq	%rax, %rax
180008ff7:     	js	0x18000948c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58fc>
180008ffd:     	movq	%rcx, 0x8(%r12)
180009002:     	cmpq	0x10(%r12), %rcx
180009007:     	jg	0x18000948c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x58fc>
18000900d:     	movq	0x140(%rsp), %rcx
180009015:     	movq	%rcx, 0x100(%rsp)
18000901d:     	movq	%rax, 0xf8(%rsp)
180009025:     	movq	0x2f8(%rsp), %rax
18000902d:     	movq	%rax, 0xe8(%rsp)
180009035:     	movq	0x2f0(%rsp), %rax
18000903d:     	movq	%rax, 0xe0(%rsp)
180009045:     	movq	%r15, 0xd8(%rsp)
18000904d:     	movq	0x2e0(%rsp), %rax
180009055:     	movq	%rax, 0xd0(%rsp)
18000905d:     	movq	0x2d8(%rsp), %rax
180009065:     	movq	%rax, 0xc8(%rsp)
18000906d:     	movq	0x2d0(%rsp), %rax
180009075:     	movq	%rax, 0xc0(%rsp)
18000907d:     	movq	0x2c8(%rsp), %rax
180009085:     	movq	%rax, 0xb8(%rsp)
18000908d:     	movq	0x2c0(%rsp), %rax
180009095:     	movq	%rax, 0xb0(%rsp)
18000909d:     	movq	0x2b8(%rsp), %rax
1800090a5:     	movq	%rax, 0xa8(%rsp)
1800090ad:     	movq	%r12, 0xa0(%rsp)
1800090b5:     	movq	0x2a8(%rsp), %rax
1800090bd:     	movq	%rax, 0x98(%rsp)
1800090c5:     	movq	0x2a0(%rsp), %rax
1800090cd:     	movq	%rax, 0x90(%rsp)
1800090d5:     	movq	0x298(%rsp), %rax
1800090dd:     	movq	%rax, 0x88(%rsp)
1800090e5:     	movq	0x290(%rsp), %rax
1800090ed:     	movq	%rax, 0x80(%rsp)
1800090f5:     	movq	0x288(%rsp), %rax
1800090fd:     	movq	%rax, 0x78(%rsp)
180009102:     	movq	%rbx, 0x70(%rsp)
180009107:     	movq	%r13, 0x68(%rsp)
18000910c:     	movq	0x270(%rsp), %rax
180009114:     	movq	%rax, 0x60(%rsp)
180009119:     	movq	0x268(%rsp), %rax
180009121:     	movq	%rax, 0x58(%rsp)
180009126:     	movq	0x260(%rsp), %rax
18000912e:     	movq	%rax, 0x50(%rsp)
180009133:     	movq	%rdi, 0x48(%rsp)
180009138:     	movq	0x250(%rsp), %rax
180009140:     	movq	%rax, 0x40(%rsp)
180009145:     	movq	%r14, 0x38(%rsp)
18000914a:     	movq	%rbp, 0x30(%rsp)
18000914f:     	movq	0x238(%rsp), %rax
180009157:     	movq	%rax, 0x28(%rsp)
18000915c:     	movq	0x230(%rsp), %rax
180009164:     	movq	%rax, 0x20(%rsp)
180009169:     	movq	$-0x1, 0x108(%rsp)
180009175:     	movq	$0x0, 0xf0(%rsp)
180009181:     	leaq	0x12c(%rsp), %rcx
180009189:     	leaq	0x170(%rsp), %rdx
180009191:     	movq	0x130(%rsp), %r8
180009199:     	movq	0x138(%rsp), %r9
1800091a1:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
1800091a6:     	testl	%eax, %eax
1800091a8:     	jne	0x18000949e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x590e>
1800091ae:     	cmpb	$0x0, (%r15)
1800091b2:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800091b8:     	movq	0x8(%r12), %rcx
1800091bd:     	leaq	-0x1(%rcx), %rax
1800091c1:     	movq	%rax, 0x8(%r12)
1800091c6:     	movq	0x40(%r13,%rsi,8), %rax
1800091cb:     	testq	%rax, %rax
1800091ce:     	js	0x1800094ab <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x591b>
1800091d4:     	movq	%rcx, 0x8(%r12)
1800091d9:     	cmpq	0x10(%r12), %rcx
1800091de:     	jg	0x1800094ab <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x591b>
1800091e4:     	movq	0x140(%rsp), %rcx
1800091ec:     	movq	%rcx, 0x100(%rsp)
1800091f4:     	movq	%rax, 0xf8(%rsp)
1800091fc:     	movq	0x2f8(%rsp), %rax
180009204:     	movq	%rax, 0xe8(%rsp)
18000920c:     	movq	0x2f0(%rsp), %rax
180009214:     	movq	%rax, 0xe0(%rsp)
18000921c:     	movq	%r15, 0xd8(%rsp)
180009224:     	movq	0x2e0(%rsp), %rax
18000922c:     	movq	%rax, 0xd0(%rsp)
180009234:     	movq	0x2d8(%rsp), %rax
18000923c:     	movq	%rax, 0xc8(%rsp)
180009244:     	movq	0x2d0(%rsp), %rax
18000924c:     	movq	%rax, 0xc0(%rsp)
180009254:     	movq	0x2c8(%rsp), %rax
18000925c:     	movq	%rax, 0xb8(%rsp)
180009264:     	movq	0x2c0(%rsp), %rax
18000926c:     	movq	%rax, 0xb0(%rsp)
180009274:     	movq	0x2b8(%rsp), %rax
18000927c:     	movq	%rax, 0xa8(%rsp)
180009284:     	movq	%r12, 0xa0(%rsp)
18000928c:     	movq	0x2a8(%rsp), %rax
180009294:     	movq	%rax, 0x98(%rsp)
18000929c:     	movq	0x2a0(%rsp), %rax
1800092a4:     	movq	%rax, 0x90(%rsp)
1800092ac:     	movq	0x298(%rsp), %rax
1800092b4:     	movq	%rax, 0x88(%rsp)
1800092bc:     	movq	0x290(%rsp), %rax
1800092c4:     	movq	%rax, 0x80(%rsp)
1800092cc:     	movq	0x288(%rsp), %rax
1800092d4:     	movq	%rax, 0x78(%rsp)
1800092d9:     	movq	%rbx, 0x70(%rsp)
1800092de:     	movq	%r13, 0x68(%rsp)
1800092e3:     	movq	0x270(%rsp), %rax
1800092eb:     	movq	%rax, 0x60(%rsp)
1800092f0:     	movq	0x268(%rsp), %rax
1800092f8:     	movq	%rax, 0x58(%rsp)
1800092fd:     	movq	0x260(%rsp), %rax
180009305:     	movq	%rax, 0x50(%rsp)
18000930a:     	movq	%rdi, 0x48(%rsp)
18000930f:     	movq	0x250(%rsp), %rax
180009317:     	movq	%rax, 0x40(%rsp)
18000931c:     	movq	%r14, 0x38(%rsp)
180009321:     	movq	%rbp, 0x30(%rsp)
180009326:     	movq	0x238(%rsp), %rax
18000932e:     	movq	%rax, 0x28(%rsp)
180009333:     	movq	0x230(%rsp), %rax
18000933b:     	movq	%rax, 0x20(%rsp)
180009340:     	movq	$-0x1, 0x108(%rsp)
18000934c:     	movq	$0x0, 0xf0(%rsp)
180009358:     	leaq	0x12b(%rsp), %rcx
180009360:     	leaq	0x168(%rsp), %rdx
180009368:     	movq	0x130(%rsp), %r8
180009370:     	movq	0x138(%rsp), %r9
180009378:     	callq	0x1800071d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3640>
18000937d:     	testl	%eax, %eax
18000937f:     	jne	0x1800094bd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x592d>
180009385:     	cmpb	$0x0, (%r15)
180009389:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000938f:     	movq	0x148(%rsp), %r8
180009397:     	incq	%r8
18000939a:     	decq	0x8(%r12)
18000939f:     	movq	0x160(%rsp), %rax
1800093a7:     	movq	0x150(%rsp), %rcx
1800093af:     	movq	%r8, 0x148(%rsp)
1800093b7:     	cmpq	(%rcx,%rax,8), %r8
1800093bb:     	jl	0x180008c03 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5073>
1800093c1:     	movq	(%r12), %rcx
1800093c5:     	cmpq	%rbx, %rcx
1800093c8:     	movq	%rcx, %rdx
1800093cb:     	jle	0x1800093d7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5847>
1800093cd:     	movb	$0x2, (%r15)
1800093d1:     	movq	(%r12), %rcx
1800093d5:     	xorl	%edx, %edx
1800093d7:     	leaq	0x3(%rcx), %rax
1800093db:     	cmpq	%rbx, %rax
1800093de:     	jg	0x180008471 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x48e1>
1800093e4:     	movq	%rax, (%r12)
1800093e8:     	cmpb	$0x0, (%r15)
1800093ec:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800093f2:     	movq	%rcx, %rax
1800093f5:     	sarq	$0x3f, %rax
1800093f9:     	andq	%rbx, %rax
1800093fc:     	leaq	(%r13,%rcx,8), %r8
180009401:     	movq	$0x0, (%r8,%rax,8)
180009409:     	xorl	%eax, %eax
18000940b:     	cmpq	$-0x1, %rcx
18000940f:     	movl	$0x0, %r9d
180009415:     	cmovlq	%rbx, %r9
180009419:     	movq	$0x0, 0x8(%r8,%r9,8)
180009422:     	cmpq	$-0x2, %rcx
180009426:     	cmovgeq	%rax, %rbx
18000942a:     	movq	%rdx, 0x10(%r8,%rbx,8)
18000942f:     	cmpb	$0x0, (%r15)
180009433:     	jne	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180009439:     	movq	%rcx, 0x30(%r13,%rsi,8)
18000943e:     	movq	0x110(%rsp), %rcx
180009446:     	movb	$0x0, (%rcx)
180009449:     	jmp	0x180007b53 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x3fc3>
18000944e:     	movb	$0x1, (%r15)
180009452:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
18000945b:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
180009460:     	movq	0x180(%rsp), %rdx
180009468:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
18000946d:     	movb	$0x1, (%r15)
180009471:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
18000947a:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000947f:     	movq	0x178(%rsp), %rdx
180009487:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
18000948c:     	movb	$0x1, (%r15)
180009490:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180009499:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
18000949e:     	movq	0x170(%rsp), %rdx
1800094a6:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
1800094ab:     	movb	$0x1, (%r15)
1800094af:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
1800094b8:     	jmp	0x180007d71 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x41e1>
1800094bd:     	movq	0x168(%rsp), %rdx
1800094c5:     	jmp	0x1800081d1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x4641>
1800094ca:     	int3
1800094cb:     	int3
1800094cc:     	int3
1800094cd:     	int3
1800094ce:     	int3
1800094cf:     	int3
1800094d0:     	pushq	%rbx
1800094d2:     	subq	$0x20, %rsp
1800094d6:     	movq	%rcx, %rbx
1800094d9:     	callq	*0x3c11(%rip)           # 0x18000d0f0
1800094df:     	movl	%eax, (%rbx)
1800094e1:     	addq	$0x20, %rsp
1800094e5:     	popq	%rbx
1800094e6:     	retq
1800094e7:     	int3
1800094e8:     	int3
1800094e9:     	int3
1800094ea:     	int3
1800094eb:     	int3
1800094ec:     	int3
1800094ed:     	int3
1800094ee:     	int3
1800094ef:     	int3
1800094f0:     	movl	(%rcx), %ecx
1800094f2:     	jmpq	*0x3d17(%rip)           # 0x18000d210
1800094f9:     	int3
1800094fa:     	int3
1800094fb:     	int3
1800094fc:     	int3
1800094fd:     	int3
1800094fe:     	int3
1800094ff:     	int3
180009500:     	pushq	%rbp
180009502:     	pushq	%rbx
180009503:     	pushq	%rsi
180009504:     	pushq	%rdi
180009505:     	pushq	%r14
180009507:     	pushq	%r15
180009509:     	movq	%rsp, %rbp
18000950c:     	subq	$0x48, %rsp
180009510:     	movq	0x3cc9(%rip), %rax      # 0x18000d1e0
180009517:     	xorl	%r15d, %r15d
18000951a:     	movq	%rcx, %rsi
18000951d:     	movq	%r15, 0x38(%rbp)
180009521:     	movl	%r15d, %r14d
180009524:     	movq	%r15, 0x50(%rbp)
180009528:     	movq	%r15, 0x48(%rbp)
18000952c:     	cmpq	%rax, 0x8(%rcx)
180009530:     	jne	0x18000969e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b0e>
180009536:     	leaq	0x48(%rbp), %rax
18000953a:     	leaq	0x50(%rbp), %r9
18000953e:     	movq	%rax, 0x20(%rsp)
180009543:     	leaq	0x38(%rbp), %r8
180009547:     	leaq	0x4936(%rip), %rdx      # 0x18000de84
18000954e:     	callq	*0x3bdc(%rip)           # 0x18000d130
180009554:     	testl	%eax, %eax
180009556:     	jne	0x180009694 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b04>
18000955c:     	movq	0x48(%rbp), %rbx
180009560:     	testq	%rbx, %rbx
180009563:     	je	0x180009685 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5af5>
180009569:     	cmpq	0x3d60(%rip), %rbx      # 0x18000d2d0
180009570:     	je	0x180009685 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5af5>
180009576:     	movq	0x8(%rbx), %rax
18000957a:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009584:     	je	0x180009685 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5af5>
18000958a:     	movq	0x20(%rbx), %rcx
18000958e:     	callq	*0x3bec(%rip)           # 0x18000d180
180009594:     	movq	0x28(%rbx), %rcx
180009598:     	movq	%rax, %rdi
18000959b:     	callq	*0x3bdf(%rip)           # 0x18000d180
1800095a1:     	movq	0x30(%rbx), %rcx
1800095a5:     	movq	%rax, %r14
1800095a8:     	callq	*0x3be2(%rip)           # 0x18000d190
1800095ae:     	leaq	-0x10(%rbp), %r8
1800095b2:     	movl	%eax, %ebx
1800095b4:     	leaq	-0x18(%rbp), %rdx
1800095b8:     	leaq	0x40(%rbp), %rcx
1800095bc:     	callq	*0x3bde(%rip)           # 0x18000d1a0
1800095c2:     	callq	*0x3b98(%rip)           # 0x18000d160
1800095c8:     	movq	%rax, %rsi
1800095cb:     	testq	%rax, %rax
1800095ce:     	je	0x18000967b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5aeb>
1800095d4:     	movl	%ebx, %r8d
1800095d7:     	movq	%rdi, %rdx
1800095da:     	movq	%r14, %rcx
1800095dd:     	callq	*0x3c75(%rip)           # 0x18000d258
1800095e3:     	movq	%rax, %rdi
1800095e6:     	testq	%rax, %rax
1800095e9:     	je	0x18000967b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5aeb>
1800095ef:     	callq	*0x3c73(%rip)           # 0x18000d268
1800095f5:     	xorl	%r9d, %r9d
1800095f8:     	movq	%rsi, %r8
1800095fb:     	movq	%rax, %rcx
1800095fe:     	movq	%rdi, %rdx
180009601:     	callq	*0x3c39(%rip)           # 0x18000d240
180009607:     	movl	(%rsi), %ecx
180009609:     	movq	%rax, %rbx
18000960c:     	testl	%ecx, %ecx
18000960e:     	js	0x180009620 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5a90>
180009610:     	subl	$0x1, %ecx
180009613:     	movl	%ecx, (%rsi)
180009615:     	jne	0x180009620 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5a90>
180009617:     	movq	%rsi, %rcx
18000961a:     	callq	*0x3ba8(%rip)           # 0x18000d1c8
180009620:     	movl	(%rdi), %eax
180009622:     	testl	%eax, %eax
180009624:     	js	0x180009636 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5aa6>
180009626:     	subl	$0x1, %eax
180009629:     	movl	%eax, (%rdi)
18000962b:     	jne	0x180009636 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5aa6>
18000962d:     	movq	%rdi, %rcx
180009630:     	callq	*0x3b92(%rip)           # 0x18000d1c8
180009636:     	testq	%rbx, %rbx
180009639:     	je	0x18000967b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5aeb>
18000963b:     	movq	-0x10(%rbp), %r8
18000963f:     	movq	-0x18(%rbp), %rdx
180009643:     	movq	0x40(%rbp), %rcx
180009647:     	callq	*0x3b83(%rip)           # 0x18000d1d0
18000964d:     	movq	%rbx, %rcx
180009650:     	callq	*0x3bd2(%rip)           # 0x18000d228
180009656:     	movl	(%rbx), %eax
180009658:     	testl	%eax, %eax
18000965a:     	js	0x180009685 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5af5>
18000965c:     	subl	$0x1, %eax
18000965f:     	movl	%eax, (%rbx)
180009661:     	jne	0x180009685 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5af5>
180009663:     	movq	%rbx, %rcx
180009666:     	callq	*0x3b5c(%rip)           # 0x18000d1c8
18000966c:     	xorl	%eax, %eax
18000966e:     	addq	$0x48, %rsp
180009672:     	popq	%r15
180009674:     	popq	%r14
180009676:     	popq	%rdi
180009677:     	popq	%rsi
180009678:     	popq	%rbx
180009679:     	popq	%rbp
18000967a:     	retq
18000967b:     	movq	0x40(%rbp), %rcx
18000967f:     	callq	*0x3b7b(%rip)           # 0x18000d200
180009685:     	xorl	%eax, %eax
180009687:     	addq	$0x48, %rsp
18000968b:     	popq	%r15
18000968d:     	popq	%r14
18000968f:     	popq	%rdi
180009690:     	popq	%rsi
180009691:     	popq	%rbx
180009692:     	popq	%rbp
180009693:     	retq
180009694:     	movq	0x38(%rbp), %rbx
180009698:     	movq	0x50(%rbp), %r14
18000969c:     	jmp	0x1800096a5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b15>
18000969e:     	movq	%rsi, %rbx
1800096a1:     	movq	%rbx, 0x38(%rbp)
1800096a5:     	cmpq	0x3c24(%rip), %rbx      # 0x18000d2d0
1800096ac:     	jne	0x180009744 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5bb4>
1800096b2:     	leaq	-0x18(%rbp), %r8
1800096b6:     	leaq	-0x10(%rbp), %rdx
1800096ba:     	leaq	0x40(%rbp), %rcx
1800096be:     	callq	*0x3a5c(%rip)           # 0x18000d120
1800096c4:     	movq	0x3c05(%rip), %rax      # 0x18000d2d0
1800096cb:     	cmpq	%rax, 0x40(%rbp)
1800096cf:     	jne	0x1800096e4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b54>
1800096d1:     	movq	0x3bd8(%rip), %rcx      # 0x18000d2b0
1800096d8:     	leaq	0x4759(%rip), %rdx      # 0x18000de38
1800096df:     	jmp	0x180009805 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c75>
1800096e4:     	movq	0x40(%rbp), %rcx
1800096e8:     	testq	%rcx, %rcx
1800096eb:     	je	0x1800096fa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b6a>
1800096ed:     	movl	(%rcx), %eax
1800096ef:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800096f4:     	jae	0x1800096fa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b6a>
1800096f6:     	incl	%eax
1800096f8:     	movl	%eax, (%rcx)
1800096fa:     	movq	-0x10(%rbp), %rcx
1800096fe:     	testq	%rcx, %rcx
180009701:     	je	0x180009710 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b80>
180009703:     	movl	(%rcx), %eax
180009705:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000970a:     	jae	0x180009710 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b80>
18000970c:     	incl	%eax
18000970e:     	movl	%eax, (%rcx)
180009710:     	movq	-0x18(%rbp), %r8
180009714:     	testq	%r8, %r8
180009717:     	je	0x18000972c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b9c>
180009719:     	movl	(%r8), %eax
18000971c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009721:     	jae	0x18000972c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5b9c>
180009723:     	incl	%eax
180009725:     	movl	%eax, (%r8)
180009728:     	movq	-0x18(%rbp), %r8
18000972c:     	movq	-0x10(%rbp), %rdx
180009730:     	movq	0x40(%rbp), %rcx
180009734:     	callq	*0x3a96(%rip)           # 0x18000d1d0
18000973a:     	movl	$0x1, %ebx
18000973f:     	jmp	0x180009811 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c81>
180009744:     	movq	0x8(%rbx), %rcx
180009748:     	movl	0xa8(%rcx), %eax
18000974e:     	testl	%eax, %eax
180009750:     	jns	0x1800097e6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c56>
180009756:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180009760:     	je	0x1800097e6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c56>
180009766:     	movq	%r14, %rdx
180009769:     	movq	%rbx, %rcx
18000976c:     	callq	*0x3976(%rip)           # 0x18000d0e8
180009772:     	movq	%rax, %rdi
180009775:     	testq	%rax, %rax
180009778:     	je	0x18000980e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c7e>
18000977e:     	movq	0x8(%rax), %rax
180009782:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
18000978c:     	jne	0x1800097bd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c2d>
18000978e:     	movq	0x3b0b(%rip), %rcx      # 0x18000d2a0
180009795:     	leaq	0x46bc(%rip), %rdx      # 0x18000de58
18000979c:     	movq	(%rcx), %rcx
18000979f:     	callq	*0x3b03(%rip)           # 0x18000d2a8
1800097a5:     	movl	(%rdi), %eax
1800097a7:     	testl	%eax, %eax
1800097a9:     	js	0x18000980e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c7e>
1800097ab:     	subl	$0x1, %eax
1800097ae:     	movl	%eax, (%rdi)
1800097b0:     	jne	0x18000980e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c7e>
1800097b2:     	movq	%rdi, %rcx
1800097b5:     	callq	*0x3a0d(%rip)           # 0x18000d1c8
1800097bb:     	jmp	0x18000980e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c7e>
1800097bd:     	movl	(%rdi), %eax
1800097bf:     	testl	%eax, %eax
1800097c1:     	js	0x1800097d3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c43>
1800097c3:     	subl	$0x1, %eax
1800097c6:     	movl	%eax, (%rdi)
1800097c8:     	jne	0x1800097d3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c43>
1800097ca:     	movq	%rdi, %rcx
1800097cd:     	callq	*0x39f5(%rip)           # 0x18000d1c8
1800097d3:     	movq	%r14, %rdx
1800097d6:     	movq	%rbx, %rcx
1800097d9:     	callq	*0x3a81(%rip)           # 0x18000d260
1800097df:     	movl	$0x1, %ebx
1800097e4:     	jmp	0x180009811 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c81>
1800097e6:     	btl	$0x1e, %eax
1800097ea:     	jae	0x1800097f7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c67>
1800097ec:     	movq	%rbx, %rdx
1800097ef:     	callq	*0x3a6b(%rip)           # 0x18000d260
1800097f5:     	jmp	0x18000980e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5c7e>
1800097f7:     	movq	0x3aa2(%rip), %rcx      # 0x18000d2a0
1800097fe:     	leaq	0x4653(%rip), %rdx      # 0x18000de58
180009805:     	movq	(%rcx), %rcx
180009808:     	callq	*0x3a9a(%rip)           # 0x18000d2a8
18000980e:     	movl	%r15d, %ebx
180009811:     	movq	0x48(%rbp), %rdi
180009815:     	testq	%rdi, %rdi
180009818:     	je	0x18000993b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dab>
18000981e:     	cmpq	0x3aab(%rip), %rdi      # 0x18000d2d0
180009825:     	je	0x18000993b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dab>
18000982b:     	movq	0x8(%rdi), %rax
18000982f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009839:     	je	0x18000993b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dab>
18000983f:     	movq	0x20(%rdi), %rcx
180009843:     	movq	%r12, 0x40(%rsp)
180009848:     	callq	*0x3932(%rip)           # 0x18000d180
18000984e:     	movq	0x28(%rdi), %rcx
180009852:     	movq	%rax, %r14
180009855:     	callq	*0x3925(%rip)           # 0x18000d180
18000985b:     	movq	0x30(%rdi), %rcx
18000985f:     	movq	%rax, %r12
180009862:     	callq	*0x3928(%rip)           # 0x18000d190
180009868:     	leaq	-0x10(%rbp), %r8
18000986c:     	movl	%eax, %edi
18000986e:     	leaq	-0x18(%rbp), %rdx
180009872:     	leaq	0x40(%rbp), %rcx
180009876:     	callq	*0x3924(%rip)           # 0x18000d1a0
18000987c:     	callq	*0x38de(%rip)           # 0x18000d160
180009882:     	movq	%rax, %r15
180009885:     	testq	%rax, %rax
180009888:     	je	0x18000992c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d9c>
18000988e:     	movl	%edi, %r8d
180009891:     	movq	%r14, %rdx
180009894:     	movq	%r12, %rcx
180009897:     	callq	*0x39bb(%rip)           # 0x18000d258
18000989d:     	movq	%rax, %r14
1800098a0:     	testq	%rax, %rax
1800098a3:     	je	0x18000992c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d9c>
1800098a9:     	callq	*0x39b9(%rip)           # 0x18000d268
1800098af:     	xorl	%r9d, %r9d
1800098b2:     	movq	%r15, %r8
1800098b5:     	movq	%rax, %rcx
1800098b8:     	movq	%r14, %rdx
1800098bb:     	callq	*0x397f(%rip)           # 0x18000d240
1800098c1:     	movl	(%r15), %ecx
1800098c4:     	movq	%rax, %rdi
1800098c7:     	testl	%ecx, %ecx
1800098c9:     	js	0x1800098dc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d4c>
1800098cb:     	subl	$0x1, %ecx
1800098ce:     	movl	%ecx, (%r15)
1800098d1:     	jne	0x1800098dc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d4c>
1800098d3:     	movq	%r15, %rcx
1800098d6:     	callq	*0x38ec(%rip)           # 0x18000d1c8
1800098dc:     	movl	(%r14), %eax
1800098df:     	testl	%eax, %eax
1800098e1:     	js	0x1800098f4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d64>
1800098e3:     	subl	$0x1, %eax
1800098e6:     	movl	%eax, (%r14)
1800098e9:     	jne	0x1800098f4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d64>
1800098eb:     	movq	%r14, %rcx
1800098ee:     	callq	*0x38d4(%rip)           # 0x18000d1c8
1800098f4:     	testq	%rdi, %rdi
1800098f7:     	je	0x18000992c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5d9c>
1800098f9:     	movq	-0x10(%rbp), %r8
1800098fd:     	movq	-0x18(%rbp), %rdx
180009901:     	movq	0x40(%rbp), %rcx
180009905:     	callq	*0x38c5(%rip)           # 0x18000d1d0
18000990b:     	movq	%rdi, %rcx
18000990e:     	callq	*0x3914(%rip)           # 0x18000d228
180009914:     	movl	(%rdi), %eax
180009916:     	testl	%eax, %eax
180009918:     	js	0x180009936 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5da6>
18000991a:     	subl	$0x1, %eax
18000991d:     	movl	%eax, (%rdi)
18000991f:     	jne	0x180009936 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5da6>
180009921:     	movq	%rdi, %rcx
180009924:     	callq	*0x389e(%rip)           # 0x18000d1c8
18000992a:     	jmp	0x180009936 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5da6>
18000992c:     	movq	0x40(%rbp), %rcx
180009930:     	callq	*0x38ca(%rip)           # 0x18000d200
180009936:     	movq	0x40(%rsp), %r12
18000993b:     	movl	(%rsi), %ecx
18000993d:     	testl	%ecx, %ecx
18000993f:     	js	0x180009951 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dc1>
180009941:     	subl	$0x1, %ecx
180009944:     	movl	%ecx, (%rsi)
180009946:     	jne	0x180009951 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5dc1>
180009948:     	movq	%rsi, %rcx
18000994b:     	callq	*0x3877(%rip)           # 0x18000d1c8
180009951:     	movl	%ebx, %eax
180009953:     	addq	$0x48, %rsp
180009957:     	popq	%r15
180009959:     	popq	%r14
18000995b:     	popq	%rdi
18000995c:     	popq	%rsi
18000995d:     	popq	%rbx
18000995e:     	popq	%rbp
18000995f:     	retq
180009960:     	movq	%rbx, 0x8(%rsp)
180009965:     	movq	%rsi, 0x10(%rsp)
18000996a:     	pushq	%rdi
18000996b:     	subq	$0x20, %rsp
18000996f:     	cmpq	$0x0, 0xb321(%rip)      # 0x180014c98
180009977:     	movq	%rcx, %rsi
18000997a:     	movslq	%edx, %rdi
18000997d:     	jne	0x1800099cd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e3d>
18000997f:     	leaq	0x4502(%rip), %rcx      # 0x18000de88
180009986:     	callq	*0x38ac(%rip)           # 0x18000d238
18000998c:     	movq	%rax, %rbx
18000998f:     	testq	%rax, %rax
180009992:     	je	0x1800099e1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e51>
180009994:     	leaq	0x44f5(%rip), %rdx      # 0x18000de90
18000999b:     	movq	%rax, %rcx
18000999e:     	callq	*0x37c4(%rip)           # 0x18000d168
1800099a4:     	movl	(%rbx), %ecx
1800099a6:     	movq	%rax, 0xb2eb(%rip)      # 0x180014c98
1800099ad:     	testl	%ecx, %ecx
1800099af:     	js	0x1800099c8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e38>
1800099b1:     	subl	$0x1, %ecx
1800099b4:     	movl	%ecx, (%rbx)
1800099b6:     	jne	0x1800099c8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e38>
1800099b8:     	movq	%rbx, %rcx
1800099bb:     	callq	*0x3807(%rip)           # 0x18000d1c8
1800099c1:     	movq	0xb2d0(%rip), %rax      # 0x180014c98
1800099c8:     	testq	%rax, %rax
1800099cb:     	je	0x1800099e1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e51>
1800099cd:     	movq	%rdi, %rdx
1800099d0:     	movq	%rsi, %rcx
1800099d3:     	callq	*0x38df(%rip)           # 0x18000d2b8
1800099d9:     	movq	%rax, %rbx
1800099dc:     	testq	%rax, %rax
1800099df:     	jne	0x1800099f3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e63>
1800099e1:     	xorl	%eax, %eax
1800099e3:     	movq	0x30(%rsp), %rbx
1800099e8:     	movq	0x38(%rsp), %rsi
1800099ed:     	addq	$0x20, %rsp
1800099f1:     	popq	%rdi
1800099f2:     	retq
1800099f3:     	movq	0xb29e(%rip), %rcx      # 0x180014c98
1800099fa:     	xorl	%r8d, %r8d
1800099fd:     	movq	%rbx, %rdx
180009a00:     	callq	*0x3792(%rip)           # 0x18000d198
180009a06:     	movl	(%rbx), %ecx
180009a08:     	movq	%rax, %rdi
180009a0b:     	testl	%ecx, %ecx
180009a0d:     	js	0x180009a1f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e8f>
180009a0f:     	subl	$0x1, %ecx
180009a12:     	movl	%ecx, (%rbx)
180009a14:     	jne	0x180009a1f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5e8f>
180009a16:     	movq	%rbx, %rcx
180009a19:     	callq	*0x37a9(%rip)           # 0x18000d1c8
180009a1f:     	movq	0x30(%rsp), %rbx
180009a24:     	movq	%rdi, %rax
180009a27:     	movq	0x38(%rsp), %rsi
180009a2c:     	addq	$0x20, %rsp
180009a30:     	popq	%rdi
180009a31:     	retq
180009a32:     	int3
180009a33:     	int3
180009a34:     	int3
180009a35:     	int3
180009a36:     	int3
180009a37:     	int3
180009a38:     	int3
180009a39:     	int3
180009a3a:     	int3
180009a3b:     	int3
180009a3c:     	int3
180009a3d:     	int3
180009a3e:     	int3
180009a3f:     	int3
180009a40:     	movq	%rbx, 0x8(%rsp)
180009a45:     	movq	%rsi, 0x10(%rsp)
180009a4a:     	pushq	%rdi
180009a4b:     	subq	$0x20, %rsp
180009a4f:     	movq	0xb23a(%rip), %rax      # 0x180014c90
180009a56:     	movq	%rdx, %rdi
180009a59:     	movq	%rcx, %rsi
180009a5c:     	testq	%rax, %rax
180009a5f:     	jne	0x180009ac1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f31>
180009a61:     	leaq	0x4430(%rip), %rcx      # 0x18000de98
180009a68:     	callq	*0x37ca(%rip)           # 0x18000d238
180009a6e:     	movq	%rax, %rbx
180009a71:     	testq	%rax, %rax
180009a74:     	je	0x180009aaf <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f1f>
180009a76:     	leaq	0x4433(%rip), %rdx      # 0x18000deb0
180009a7d:     	movq	%rax, %rcx
180009a80:     	callq	*0x36e2(%rip)           # 0x18000d168
180009a86:     	movl	(%rbx), %ecx
180009a88:     	movq	%rax, 0xb201(%rip)      # 0x180014c90
180009a8f:     	testl	%ecx, %ecx
180009a91:     	js	0x180009aaa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f1a>
180009a93:     	subl	$0x1, %ecx
180009a96:     	movl	%ecx, (%rbx)
180009a98:     	jne	0x180009aaa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f1a>
180009a9a:     	movq	%rbx, %rcx
180009a9d:     	callq	*0x3725(%rip)           # 0x18000d1c8
180009aa3:     	movq	0xb1e6(%rip), %rax      # 0x180014c90
180009aaa:     	testq	%rax, %rax
180009aad:     	jne	0x180009ac1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f31>
180009aaf:     	xorl	%eax, %eax
180009ab1:     	movq	0x30(%rsp), %rbx
180009ab6:     	movq	0x38(%rsp), %rsi
180009abb:     	addq	$0x20, %rsp
180009abf:     	popq	%rdi
180009ac0:     	retq
180009ac1:     	xorl	%r9d, %r9d
180009ac4:     	movq	%rdi, %r8
180009ac7:     	movq	%rsi, %rdx
180009aca:     	movq	%rax, %rcx
180009acd:     	movq	0x30(%rsp), %rbx
180009ad2:     	movq	0x38(%rsp), %rsi
180009ad7:     	addq	$0x20, %rsp
180009adb:     	popq	%rdi
180009adc:     	jmpq	*0x36b5(%rip)           # 0x18000d198
180009ae3:     	int3
180009ae4:     	int3
180009ae5:     	int3
180009ae6:     	int3
180009ae7:     	int3
180009ae8:     	int3
180009ae9:     	int3
180009aea:     	int3
180009aeb:     	int3
180009aec:     	int3
180009aed:     	int3
180009aee:     	int3
180009aef:     	int3
180009af0:     	movq	%rbx, 0x8(%rsp)
180009af5:     	movq	%rsi, 0x10(%rsp)
180009afa:     	pushq	%rdi
180009afb:     	subq	$0x20, %rsp
180009aff:     	movq	%rcx, %rbx
180009b02:     	movq	%r8, %rdi
180009b05:     	movq	0x10(%rcx), %rcx
180009b09:     	movq	%rdx, %rsi
180009b0c:     	testq	%rcx, %rcx
180009b0f:     	je	0x180009b1a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5f8a>
180009b11:     	movq	%r8, %rdx
180009b14:     	callq	*%rsi
180009b16:     	testl	%eax, %eax
180009b18:     	jne	0x180009b3d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5fad>
180009b1a:     	movq	0x18(%rbx), %rcx
180009b1e:     	testq	%rcx, %rcx
180009b21:     	je	0x180009b3b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5fab>
180009b23:     	movq	%rdi, %rdx
180009b26:     	movq	%rsi, %rax
180009b29:     	movq	0x30(%rsp), %rbx
180009b2e:     	movq	0x38(%rsp), %rsi
180009b33:     	addq	$0x20, %rsp
180009b37:     	popq	%rdi
180009b38:     	jmpq	*%rax
180009b3b:     	xorl	%eax, %eax
180009b3d:     	movq	0x30(%rsp), %rbx
180009b42:     	movq	0x38(%rsp), %rsi
180009b47:     	addq	$0x20, %rsp
180009b4b:     	popq	%rdi
180009b4c:     	retq
180009b4d:     	int3
180009b4e:     	int3
180009b4f:     	int3
180009b50:     	pushq	%rbx
180009b52:     	subq	$0x20, %rsp
180009b56:     	movq	%rcx, %rbx
180009b59:     	movq	0x10(%rcx), %rcx
180009b5d:     	testq	%rcx, %rcx
180009b60:     	je	0x180009b7d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5fed>
180009b62:     	movq	$0x0, 0x10(%rbx)
180009b6a:     	movl	(%rcx), %eax
180009b6c:     	testl	%eax, %eax
180009b6e:     	js	0x180009b7d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5fed>
180009b70:     	subl	$0x1, %eax
180009b73:     	movl	%eax, (%rcx)
180009b75:     	jne	0x180009b7d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x5fed>
180009b77:     	callq	*0x364b(%rip)           # 0x18000d1c8
180009b7d:     	movq	0x18(%rbx), %rcx
180009b81:     	testq	%rcx, %rcx
180009b84:     	je	0x180009ba1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6011>
180009b86:     	movq	$0x0, 0x18(%rbx)
180009b8e:     	movl	(%rcx), %eax
180009b90:     	testl	%eax, %eax
180009b92:     	js	0x180009ba1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6011>
180009b94:     	subl	$0x1, %eax
180009b97:     	movl	%eax, (%rcx)
180009b99:     	jne	0x180009ba1 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6011>
180009b9b:     	callq	*0x3627(%rip)           # 0x18000d1c8
180009ba1:     	xorl	%eax, %eax
180009ba3:     	addq	$0x20, %rsp
180009ba7:     	popq	%rbx
180009ba8:     	retq
180009ba9:     	int3
180009baa:     	int3
180009bab:     	int3
180009bac:     	int3
180009bad:     	int3
180009bae:     	int3
180009baf:     	int3
180009bb0:     	pushq	%rbx
180009bb2:     	subq	$0x20, %rsp
180009bb6:     	movq	%rcx, %rbx
180009bb9:     	callq	*0x3659(%rip)           # 0x18000d218
180009bbf:     	movq	0x10(%rbx), %rcx
180009bc3:     	testq	%rcx, %rcx
180009bc6:     	je	0x180009be3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6053>
180009bc8:     	movq	$0x0, 0x10(%rbx)
180009bd0:     	movl	(%rcx), %eax
180009bd2:     	testl	%eax, %eax
180009bd4:     	js	0x180009be3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6053>
180009bd6:     	subl	$0x1, %eax
180009bd9:     	movl	%eax, (%rcx)
180009bdb:     	jne	0x180009be3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6053>
180009bdd:     	callq	*0x35e5(%rip)           # 0x18000d1c8
180009be3:     	movq	0x18(%rbx), %rcx
180009be7:     	testq	%rcx, %rcx
180009bea:     	je	0x180009c07 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6077>
180009bec:     	movq	$0x0, 0x18(%rbx)
180009bf4:     	movl	(%rcx), %eax
180009bf6:     	testl	%eax, %eax
180009bf8:     	js	0x180009c07 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6077>
180009bfa:     	subl	$0x1, %eax
180009bfd:     	movl	%eax, (%rcx)
180009bff:     	jne	0x180009c07 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6077>
180009c01:     	callq	*0x35c1(%rip)           # 0x18000d1c8
180009c07:     	movq	0x8(%rbx), %rax
180009c0b:     	movq	%rbx, %rcx
180009c0e:     	addq	$0x20, %rsp
180009c12:     	popq	%rbx
180009c13:     	jmpq	*0x140(%rax)
180009c1a:     	int3
180009c1b:     	int3
180009c1c:     	int3
180009c1d:     	int3
180009c1e:     	int3
180009c1f:     	int3
180009c20:     	pushq	%rbx
180009c22:     	subq	$0x30, %rsp
180009c26:     	movq	%r8, %r10
180009c29:     	leaq	0x58(%rsp), %rax
180009c2e:     	movq	%rax, 0x28(%rsp)
180009c33:     	leaq	0xad96(%rip), %r9       # 0x1800149d0
180009c3a:     	movq	0x35a7(%rip), %rax      # 0x18000d1e8
180009c41:     	leaq	0x4298(%rip), %r8       # 0x18000dee0
180009c48:     	movq	%rdx, %r11
180009c4b:     	movq	%rax, 0x20(%rsp)
180009c50:     	movq	%rcx, %rbx
180009c53:     	movq	%r10, %rdx
180009c56:     	movq	%r11, %rcx
180009c59:     	callq	*0x3499(%rip)           # 0x18000d0f8
180009c5f:     	testl	%eax, %eax
180009c61:     	je	0x180009cbc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x612c>
180009c63:     	xorl	%r8d, %r8d
180009c66:     	xorl	%edx, %edx
180009c68:     	movq	%rbx, %rcx
180009c6b:     	callq	*0x35d7(%rip)           # 0x18000d248
180009c71:     	movq	%rax, %rbx
180009c74:     	testq	%rax, %rax
180009c77:     	je	0x180009cbc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x612c>
180009c79:     	movq	0x58(%rsp), %rax
180009c7e:     	movl	(%rax), %ecx
180009c80:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180009c86:     	jae	0x180009c91 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6101>
180009c88:     	incl	%ecx
180009c8a:     	movl	%ecx, (%rax)
180009c8c:     	movq	0x58(%rsp), %rax
180009c91:     	xorl	%ecx, %ecx
180009c93:     	movq	%rax, 0x10(%rbx)
180009c97:     	callq	*0x34db(%rip)           # 0x18000d178
180009c9d:     	movq	%rax, 0x18(%rbx)
180009ca1:     	testq	%rax, %rax
180009ca4:     	jne	0x180009cc4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6134>
180009ca6:     	movl	(%rbx), %eax
180009ca8:     	testl	%eax, %eax
180009caa:     	js	0x180009cbc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x612c>
180009cac:     	subl	$0x1, %eax
180009caf:     	movl	%eax, (%rbx)
180009cb1:     	jne	0x180009cbc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x612c>
180009cb3:     	movq	%rbx, %rcx
180009cb6:     	callq	*0x350c(%rip)           # 0x18000d1c8
180009cbc:     	xorl	%eax, %eax
180009cbe:     	addq	$0x30, %rsp
180009cc2:     	popq	%rbx
180009cc3:     	retq
180009cc4:     	movq	%rbx, %rax
180009cc7:     	addq	$0x30, %rsp
180009ccb:     	popq	%rbx
180009ccc:     	retq
180009ccd:     	int3
180009cce:     	int3
180009ccf:     	int3
180009cd0:     	movq	%rbx, 0x8(%rsp)
180009cd5:     	movq	%rsi, 0x10(%rsp)
180009cda:     	pushq	%rdi
180009cdb:     	subq	$0x20, %rsp
180009cdf:     	movq	%rcx, %rbx
180009ce2:     	movq	%r8, %rdi
180009ce5:     	movq	0x18(%rcx), %rcx
180009ce9:     	movq	%rdx, %rsi
180009cec:     	testq	%rcx, %rcx
180009cef:     	je	0x180009cfa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x616a>
180009cf1:     	movq	%r8, %rdx
180009cf4:     	callq	*%rsi
180009cf6:     	testl	%eax, %eax
180009cf8:     	jne	0x180009d1d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x618d>
180009cfa:     	movq	0x40(%rbx), %rcx
180009cfe:     	testq	%rcx, %rcx
180009d01:     	je	0x180009d1b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x618b>
180009d03:     	movq	%rdi, %rdx
180009d06:     	movq	%rsi, %rax
180009d09:     	movq	0x30(%rsp), %rbx
180009d0e:     	movq	0x38(%rsp), %rsi
180009d13:     	addq	$0x20, %rsp
180009d17:     	popq	%rdi
180009d18:     	jmpq	*%rax
180009d1b:     	xorl	%eax, %eax
180009d1d:     	movq	0x30(%rsp), %rbx
180009d22:     	movq	0x38(%rsp), %rsi
180009d27:     	addq	$0x20, %rsp
180009d2b:     	popq	%rdi
180009d2c:     	retq
180009d2d:     	int3
180009d2e:     	int3
180009d2f:     	int3
180009d30:     	pushq	%rbx
180009d32:     	subq	$0x20, %rsp
180009d36:     	movq	%rcx, %rbx
180009d39:     	callq	*0x34d9(%rip)           # 0x18000d218
180009d3f:     	cmpq	$0x0, 0x48(%rbx)
180009d44:     	je	0x180009d4f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x61bf>
180009d46:     	movq	%rbx, %rcx
180009d49:     	callq	*0x3439(%rip)           # 0x18000d188
180009d4f:     	movq	0x20(%rbx), %rcx
180009d53:     	callq	*0x345f(%rip)           # 0x18000d1b8
180009d59:     	movq	0x38(%rbx), %rcx
180009d5d:     	callq	*0x3455(%rip)           # 0x18000d1b8
180009d63:     	movq	0x18(%rbx), %rcx
180009d67:     	testq	%rcx, %rcx
180009d6a:     	je	0x180009d7f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x61ef>
180009d6c:     	movl	(%rcx), %eax
180009d6e:     	testl	%eax, %eax
180009d70:     	js	0x180009d7f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x61ef>
180009d72:     	subl	$0x1, %eax
180009d75:     	movl	%eax, (%rcx)
180009d77:     	jne	0x180009d7f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x61ef>
180009d79:     	callq	*0x3449(%rip)           # 0x18000d1c8
180009d7f:     	movq	0x40(%rbx), %rcx
180009d83:     	testq	%rcx, %rcx
180009d86:     	je	0x180009d9b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x620b>
180009d88:     	movl	(%rcx), %eax
180009d8a:     	testl	%eax, %eax
180009d8c:     	js	0x180009d9b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x620b>
180009d8e:     	subl	$0x1, %eax
180009d91:     	movl	%eax, (%rcx)
180009d93:     	jne	0x180009d9b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x620b>
180009d95:     	callq	*0x342d(%rip)           # 0x18000d1c8
180009d9b:     	movq	0x8(%rbx), %rax
180009d9f:     	movq	%rbx, %rcx
180009da2:     	addq	$0x20, %rsp
180009da6:     	popq	%rbx
180009da7:     	jmpq	*0x140(%rax)
180009dae:     	int3
180009daf:     	int3
180009db0:     	pushq	%rbx
180009db2:     	subq	$0x20, %rsp
180009db6:     	callq	*0x33c4(%rip)           # 0x18000d180
180009dbc:     	movq	%rax, %rbx
180009dbf:     	testq	%rax, %rax
180009dc2:     	jne	0x180009dca <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x623a>
180009dc4:     	addq	$0x20, %rsp
180009dc8:     	popq	%rbx
180009dc9:     	retq
180009dca:     	movq	%rbx, %rcx
180009dcd:     	movq	%rdi, 0x30(%rsp)
180009dd2:     	callq	0x18000c135 <numba_list_iter_next+0xed5>
180009dd7:     	leaq	0x1(%rax), %rcx
180009ddb:     	callq	*0x346f(%rip)           # 0x18000d250
180009de1:     	movq	%rax, %rdi
180009de4:     	testq	%rax, %rax
180009de7:     	jne	0x180009dfc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x626c>
180009de9:     	callq	*0x3351(%rip)           # 0x18000d140
180009def:     	movq	0x30(%rsp), %rdi
180009df4:     	xorl	%eax, %eax
180009df6:     	addq	$0x20, %rsp
180009dfa:     	popq	%rbx
180009dfb:     	retq
180009dfc:     	movq	%rbx, %rdx
180009dff:     	movq	%rdi, %rcx
180009e02:     	callq	0x18000c12f <numba_list_iter_next+0xecf>
180009e07:     	movq	%rdi, %rax
180009e0a:     	movq	0x30(%rsp), %rdi
180009e0f:     	addq	$0x20, %rsp
180009e13:     	popq	%rbx
180009e14:     	retq
180009e15:     	int3
180009e16:     	int3
180009e17:     	int3
180009e18:     	int3
180009e19:     	int3
180009e1a:     	int3
180009e1b:     	int3
180009e1c:     	int3
180009e1d:     	int3
180009e1e:     	int3
180009e1f:     	int3
180009e20:     	movq	0x18(%rcx), %rcx
180009e24:     	movq	%rdx, %rax
180009e27:     	testq	%rcx, %rcx
180009e2a:     	je	0x180009e32 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x62a2>
180009e2c:     	movq	%r8, %rdx
180009e2f:     	jmpq	*%rax
180009e32:     	xorl	%eax, %eax
180009e34:     	retq
180009e35:     	int3
180009e36:     	int3
180009e37:     	int3
180009e38:     	int3
180009e39:     	int3
180009e3a:     	int3
180009e3b:     	int3
180009e3c:     	int3
180009e3d:     	int3
180009e3e:     	int3
180009e3f:     	int3
180009e40:     	movq	%rbx, 0x8(%rsp)
180009e45:     	pushq	%rdi
180009e46:     	subq	$0x20, %rsp
180009e4a:     	movq	0x28(%rcx), %rax
180009e4e:     	xorl	%edi, %edi
180009e50:     	movq	%rcx, %rbx
180009e53:     	testq	%rax, %rax
180009e56:     	je	0x180009e62 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x62d2>
180009e58:     	addq	$0x38, %rcx
180009e5c:     	callq	*%rax
180009e5e:     	movq	%rdi, 0x28(%rbx)
180009e62:     	movq	0x18(%rbx), %rcx
180009e66:     	testq	%rcx, %rcx
180009e69:     	je	0x180009e82 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x62f2>
180009e6b:     	movq	%rdi, 0x18(%rbx)
180009e6f:     	movl	(%rcx), %eax
180009e71:     	testl	%eax, %eax
180009e73:     	js	0x180009e82 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x62f2>
180009e75:     	subl	$0x1, %eax
180009e78:     	movl	%eax, (%rcx)
180009e7a:     	jne	0x180009e82 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x62f2>
180009e7c:     	callq	*0x3346(%rip)           # 0x18000d1c8
180009e82:     	movq	%rdi, 0x20(%rbx)
180009e86:     	xorl	%eax, %eax
180009e88:     	movq	0x30(%rsp), %rbx
180009e8d:     	addq	$0x20, %rsp
180009e91:     	popq	%rdi
180009e92:     	retq
180009e93:     	int3
180009e94:     	int3
180009e95:     	int3
180009e96:     	int3
180009e97:     	int3
180009e98:     	int3
180009e99:     	int3
180009e9a:     	int3
180009e9b:     	int3
180009e9c:     	int3
180009e9d:     	int3
180009e9e:     	int3
180009e9f:     	int3
180009ea0:     	pushq	%rbx
180009ea2:     	subq	$0x20, %rsp
180009ea6:     	movq	%rcx, %rbx
180009ea9:     	callq	*0x3369(%rip)           # 0x18000d218
180009eaf:     	cmpq	$0x0, 0x30(%rbx)
180009eb4:     	je	0x180009ebf <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x632f>
180009eb6:     	movq	%rbx, %rcx
180009eb9:     	callq	*0x32c9(%rip)           # 0x18000d188
180009ebf:     	callq	*0x3243(%rip)           # 0x18000d108
180009ec5:     	testl	%eax, %eax
180009ec7:     	jne	0x180009ed8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6348>
180009ec9:     	movq	0x28(%rbx), %rax
180009ecd:     	testq	%rax, %rax
180009ed0:     	je	0x180009ed8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6348>
180009ed2:     	leaq	0x38(%rbx), %rcx
180009ed6:     	callq	*%rax
180009ed8:     	movq	0x18(%rbx), %rcx
180009edc:     	testq	%rcx, %rcx
180009edf:     	je	0x180009ef4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6364>
180009ee1:     	movl	(%rcx), %eax
180009ee3:     	testl	%eax, %eax
180009ee5:     	js	0x180009ef4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6364>
180009ee7:     	subl	$0x1, %eax
180009eea:     	movl	%eax, (%rcx)
180009eec:     	jne	0x180009ef4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6364>
180009eee:     	callq	*0x32d4(%rip)           # 0x18000d1c8
180009ef4:     	movq	0x8(%rbx), %rax
180009ef8:     	movq	%rbx, %rcx
180009efb:     	addq	$0x20, %rsp
180009eff:     	popq	%rbx
180009f00:     	jmpq	*0x140(%rax)
180009f07:     	int3
180009f08:     	int3
180009f09:     	int3
180009f0a:     	int3
180009f0b:     	int3
180009f0c:     	int3
180009f0d:     	int3
180009f0e:     	int3
180009f0f:     	int3
180009f10:     	pushq	%rdi
180009f12:     	subq	$0x20, %rsp
180009f16:     	cmpq	$0x0, 0x20(%rcx)
180009f1b:     	movq	%rcx, %rdi
180009f1e:     	jne	0x180009f3f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x63af>
180009f20:     	movq	0x3389(%rip), %rcx      # 0x18000d2b0
180009f27:     	leaq	0x4002(%rip), %rdx      # 0x18000df30
180009f2e:     	movq	(%rcx), %rcx
180009f31:     	callq	*0x3371(%rip)           # 0x18000d2a8
180009f37:     	xorl	%eax, %eax
180009f39:     	addq	$0x20, %rsp
180009f3d:     	popq	%rdi
180009f3e:     	retq
180009f3f:     	movq	%rdi, %rdx
180009f42:     	movq	%rbx, 0x30(%rsp)
180009f47:     	movl	$0x1, %ecx
180009f4c:     	callq	*0x33b6(%rip)           # 0x18000d308
180009f52:     	movq	%rax, %rbx
180009f55:     	testq	%rax, %rax
180009f58:     	jne	0x180009f65 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x63d5>
180009f5a:     	movq	0x30(%rsp), %rbx
180009f5f:     	addq	$0x20, %rsp
180009f63:     	popq	%rdi
180009f64:     	retq
180009f65:     	xorl	%r8d, %r8d
180009f68:     	movq	%rbx, %rdx
180009f6b:     	movq	%rdi, %rcx
180009f6e:     	callq	*0x20(%rdi)
180009f71:     	movl	(%rbx), %ecx
180009f73:     	movq	%rax, %rdi
180009f76:     	testl	%ecx, %ecx
180009f78:     	js	0x180009f8a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x63fa>
180009f7a:     	subl	$0x1, %ecx
180009f7d:     	movl	%ecx, (%rbx)
180009f7f:     	jne	0x180009f8a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x63fa>
180009f81:     	movq	%rbx, %rcx
180009f84:     	callq	*0x323e(%rip)           # 0x18000d1c8
180009f8a:     	movq	0x30(%rsp), %rbx
180009f8f:     	movq	%rdi, %rax
180009f92:     	addq	$0x20, %rsp
180009f96:     	popq	%rdi
180009f97:     	retq
180009f98:     	int3
180009f99:     	int3
180009f9a:     	int3
180009f9b:     	int3
180009f9c:     	int3
180009f9d:     	int3
180009f9e:     	int3
180009f9f:     	int3
180009fa0:     	movq	%rbx, 0x8(%rsp)
180009fa5:     	pushq	%rdi
180009fa6:     	subq	$0x20, %rsp
180009faa:     	movq	%r8, %rbx
180009fad:     	callq	*0x313d(%rip)           # 0x18000d0f0
180009fb3:     	movl	(%rbx), %ecx
180009fb5:     	movl	%eax, %edi
180009fb7:     	testl	%ecx, %ecx
180009fb9:     	js	0x180009fcb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x643b>
180009fbb:     	subl	$0x1, %ecx
180009fbe:     	movl	%ecx, (%rbx)
180009fc0:     	jne	0x180009fcb <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x643b>
180009fc2:     	movq	%rbx, %rcx
180009fc5:     	callq	*0x31fd(%rip)           # 0x18000d1c8
180009fcb:     	movl	%edi, %ecx
180009fcd:     	movq	0x30(%rsp), %rbx
180009fd2:     	addq	$0x20, %rsp
180009fd6:     	popq	%rdi
180009fd7:     	jmpq	*0x3232(%rip)           # 0x18000d210
180009fde:     	int3
180009fdf:     	int3
180009fe0:     	movq	%rbx, 0x8(%rsp)
180009fe5:     	pushq	%rdi
180009fe6:     	subq	$0x20, %rsp
180009fea:     	movl	(%rdx), %eax
180009fec:     	movq	%rdx, %rbx
180009fef:     	movq	%rcx, %rdi
180009ff2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009ff7:     	jae	0x180009ffd <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x646d>
180009ff9:     	incl	%eax
180009ffb:     	movl	%eax, (%rdx)
180009ffd:     	movl	$0x30, %ecx
18000a002:     	callq	*0xac60(%rip)           # 0x180014c68
18000a008:     	cmpb	$0x0, 0xac31(%rip)      # 0x180014c40
18000a00f:     	je	0x18000a019 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6489>
18000a011:     	lock
18000a012:     	incq	0xac2f(%rip)            # 0x180014c48
18000a019:     	testq	%rax, %rax
18000a01c:     	je	0x18000a053 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x64c3>
18000a01e:     	movl	$0x1, %ecx
18000a023:     	leaq	-0x8a(%rip), %rdx       # 0x180009fa0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6410>
18000a02a:     	xchgq	%rcx, (%rax)
18000a02d:     	xorl	%ecx, %ecx
18000a02f:     	movq	%rdx, 0x8(%rax)
18000a033:     	movq	%rcx, 0x20(%rax)
18000a037:     	movq	%rcx, 0x28(%rax)
18000a03b:     	movq	%rbx, 0x10(%rax)
18000a03f:     	movq	%rdi, 0x18(%rax)
18000a043:     	cmpb	%cl, 0xabf7(%rip)       # 0x180014c40
18000a049:     	je	0x18000a053 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x64c3>
18000a04b:     	lock
18000a04c:     	incq	0xac05(%rip)            # 0x180014c58
18000a053:     	movq	0x30(%rsp), %rbx
18000a058:     	addq	$0x20, %rsp
18000a05c:     	popq	%rdi
18000a05d:     	retq
18000a05e:     	int3
18000a05f:     	int3
18000a060:     	movq	%rbx, 0x8(%rsp)
18000a065:     	pushq	%rdi
18000a066:     	subq	$0x30, %rsp
18000a06a:     	movq	%rcx, %rdi
18000a06d:     	leaq	0xa94c(%rip), %r9       # 0x1800149c0
18000a074:     	movq	%r8, %rax
18000a077:     	leaq	0x58(%rsp), %rcx
18000a07c:     	movq	%rdx, %r10
18000a07f:     	movq	%rcx, 0x20(%rsp)
18000a084:     	movq	%r10, %rcx
18000a087:     	leaq	0x3eea(%rip), %r8       # 0x18000df78
18000a08e:     	movq	%rax, %rdx
18000a091:     	callq	*0x3061(%rip)           # 0x18000d0f8
18000a097:     	testl	%eax, %eax
18000a099:     	je	0x18000a0c3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6533>
18000a09b:     	movq	0x58(%rsp), %rcx
18000a0a0:     	callq	*0x303a(%rip)           # 0x18000d0e0
18000a0a6:     	movq	%rax, %rbx
18000a0a9:     	callq	*0x3239(%rip)           # 0x18000d2e8
18000a0af:     	testq	%rax, %rax
18000a0b2:     	jne	0x18000a0c3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6533>
18000a0b4:     	movq	%rbx, 0x10(%rdi)
18000a0b8:     	movq	0x40(%rsp), %rbx
18000a0bd:     	addq	$0x30, %rsp
18000a0c1:     	popq	%rdi
18000a0c2:     	retq
18000a0c3:     	movq	0x40(%rsp), %rbx
18000a0c8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a0cd:     	addq	$0x30, %rsp
18000a0d1:     	popq	%rdi
18000a0d2:     	retq
18000a0d3:     	int3
18000a0d4:     	int3
18000a0d5:     	int3
18000a0d6:     	int3
18000a0d7:     	int3
18000a0d8:     	int3
18000a0d9:     	int3
18000a0da:     	int3
18000a0db:     	int3
18000a0dc:     	int3
18000a0dd:     	int3
18000a0de:     	int3
18000a0df:     	int3
18000a0e0:     	subq	$0x38, %rsp
18000a0e4:     	movl	%r8d, %eax
18000a0e7:     	movq	%rdx, %r10
18000a0ea:     	movq	0x10(%rcx), %r8
18000a0ee:     	movq	%rcx, %rdx
18000a0f1:     	movl	%eax, 0x28(%rsp)
18000a0f5:     	movq	%r10, %rcx
18000a0f8:     	movl	$0x0, 0x20(%rsp)
18000a100:     	movq	0x20(%r8), %r9
18000a104:     	movq	0x18(%r8), %r8
18000a108:     	callq	*0x30fa(%rip)           # 0x18000d208
18000a10e:     	addq	$0x38, %rsp
18000a112:     	retq
18000a113:     	int3
18000a114:     	int3
18000a115:     	int3
18000a116:     	int3
18000a117:     	int3
18000a118:     	int3
18000a119:     	int3
18000a11a:     	int3
18000a11b:     	int3
18000a11c:     	int3
18000a11d:     	int3
18000a11e:     	int3
18000a11f:     	int3
18000a120:     	movq	0x10(%rcx), %rax
18000a124:     	lock
18000a125:     	incq	(%rax)
18000a128:     	movq	0x31a1(%rip), %rax      # 0x18000d2d0
18000a12f:     	retq
18000a130:     	subq	$0x28, %rsp
18000a134:     	movq	0x10(%rcx), %rcx
18000a138:     	callq	0x18000b430 <numba_list_iter_next+0x1d0>
18000a13d:     	movq	0x318c(%rip), %rax      # 0x18000d2d0
18000a144:     	addq	$0x28, %rsp
18000a148:     	retq
18000a149:     	int3
18000a14a:     	int3
18000a14b:     	int3
18000a14c:     	int3
18000a14d:     	int3
18000a14e:     	int3
18000a14f:     	int3
18000a150:     	movq	0x10(%rcx), %rcx
18000a154:     	movq	0x18(%rcx), %rcx
18000a158:     	jmpq	*0x2ff9(%rip)           # 0x18000d158
18000a15f:     	int3
18000a160:     	subq	$0x28, %rsp
18000a164:     	movq	0x10(%rcx), %rax
18000a168:     	testq	%rax, %rax
18000a16b:     	je	0x18000a189 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x65f9>
18000a16d:     	cmpq	$0x0, 0x18(%rax)
18000a172:     	je	0x18000a189 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x65f9>
18000a174:     	movq	(%rax), %rcx
18000a177:     	nop
18000a178:     	cmpq	$-0x1, %rcx
18000a17c:     	je	0x18000a189 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x65f9>
18000a17e:     	addq	$0x28, %rsp
18000a182:     	jmpq	*0x2f9f(%rip)           # 0x18000d128
18000a189:     	movq	0x3068(%rip), %rcx      # 0x18000d1f8
18000a190:     	leaq	0x3de9(%rip), %rdx      # 0x18000df80
18000a197:     	movq	(%rcx), %rcx
18000a19a:     	callq	*0x3108(%rip)           # 0x18000d2a8
18000a1a0:     	xorl	%eax, %eax
18000a1a2:     	addq	$0x28, %rsp
18000a1a6:     	retq
18000a1a7:     	int3
18000a1a8:     	int3
18000a1a9:     	int3
18000a1aa:     	int3
18000a1ab:     	int3
18000a1ac:     	int3
18000a1ad:     	int3
18000a1ae:     	int3
18000a1af:     	int3
18000a1b0:     	movq	0x10(%rcx), %rcx
18000a1b4:     	movq	0x28(%rcx), %rcx
18000a1b8:     	jmpq	*0x2f99(%rip)           # 0x18000d158
18000a1bf:     	int3
18000a1c0:     	movq	0x10(%rcx), %rax
18000a1c4:     	movq	0x10(%rax), %rax
18000a1c8:     	testq	%rax, %rax
18000a1cb:     	je	0x18000a1dc <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x664c>
18000a1cd:     	movl	(%rax), %ecx
18000a1cf:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000a1d5:     	jae	0x18000a1fa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x666a>
18000a1d7:     	incl	%ecx
18000a1d9:     	movl	%ecx, (%rax)
18000a1db:     	retq
18000a1dc:     	movq	0x30ed(%rip), %rcx      # 0x18000d2d0
18000a1e3:     	movl	(%rcx), %eax
18000a1e5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a1ea:     	jae	0x18000a1f7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6667>
18000a1ec:     	incl	%eax
18000a1ee:     	movl	%eax, (%rcx)
18000a1f0:     	movq	0x30d9(%rip), %rcx      # 0x18000d2d0
18000a1f7:     	movq	%rcx, %rax
18000a1fa:     	retq
18000a1fb:     	int3
18000a1fc:     	int3
18000a1fd:     	int3
18000a1fe:     	int3
18000a1ff:     	int3
18000a200:     	pushq	%rbx
18000a202:     	subq	$0x20, %rsp
18000a206:     	movq	%rcx, %rbx
18000a209:     	movq	0x10(%rcx), %rcx
18000a20d:     	callq	0x18000b430 <numba_list_iter_next+0x1d0>
18000a212:     	movq	0x8(%rbx), %rax
18000a216:     	movq	%rbx, %rcx
18000a219:     	addq	$0x20, %rsp
18000a21d:     	popq	%rbx
18000a21e:     	jmpq	*0x140(%rax)
18000a225:     	int3
18000a226:     	int3
18000a227:     	int3
18000a228:     	int3
18000a229:     	int3
18000a22a:     	int3
18000a22b:     	int3
18000a22c:     	int3
18000a22d:     	int3
18000a22e:     	int3
18000a22f:     	int3
18000a230:     	movq	%rdi, 0x18(%rsp)
18000a235:     	pushq	%r14
18000a237:     	subq	$0x20, %rsp
18000a23b:     	movq	0xaa3e(%rip), %rax      # 0x180014c80
18000a242:     	movq	%rdx, %r14
18000a245:     	movq	%rcx, %rdi
18000a248:     	movq	0x8(%rcx), %rcx
18000a24c:     	movq	0x10(%rax), %rdx
18000a250:     	cmpq	%rdx, %rcx
18000a253:     	je	0x18000a270 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66e0>
18000a255:     	callq	*0x2f7d(%rip)           # 0x18000d1d8
18000a25b:     	testl	%eax, %eax
18000a25d:     	jne	0x18000a270 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x66e0>
18000a25f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a264:     	movq	0x40(%rsp), %rdi
18000a269:     	addq	$0x20, %rsp
18000a26d:     	popq	%r14
18000a26f:     	retq
18000a270:     	movq	%rbx, 0x30(%rsp)
18000a275:     	movq	%rdi, %rdx
18000a278:     	movq	0x10(%rdi), %rbx
18000a27c:     	movq	%rbx, %rcx
18000a27f:     	movq	%rsi, 0x38(%rsp)
18000a284:     	movl	0x18(%rdi), %esi
18000a287:     	callq	0x180009fe0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6450>
18000a28c:     	movq	%rax, (%r14)
18000a28f:     	movq	0xa9ea(%rip), %rax      # 0x180014c80
18000a296:     	movq	%rbx, 0x20(%r14)
18000a29a:     	movl	0x18(%rdi), %edx
18000a29d:     	movq	0x20(%rdi), %rcx
18000a2a1:     	callq	*0x4f0(%rax)
18000a2a7:     	cmpl	$0x12, 0xa9de(%rip)     # 0x180014c8c
18000a2ae:     	movq	0x30(%rsp), %rbx
18000a2b3:     	movq	%rax, 0x10(%r14)
18000a2b7:     	movq	0x38(%rdi), %rax
18000a2bb:     	jl	0x18000a2c3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6733>
18000a2bd:     	movq	0x28(%rax), %rax
18000a2c1:     	jmp	0x18000a2c7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6737>
18000a2c3:     	movslq	0x20(%rax), %rax
18000a2c7:     	xorl	%r8d, %r8d
18000a2ca:     	movq	%rax, 0x18(%r14)
18000a2ce:     	movq	%rdi, 0x8(%r14)
18000a2d2:     	leaq	0x28(%r14), %rax
18000a2d6:     	testl	%esi, %esi
18000a2d8:     	jle	0x18000a31b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x678b>
18000a2da:     	nopw	(%rax,%rax)
18000a2e0:     	movq	0x20(%rdi), %rcx
18000a2e4:     	movq	(%rcx,%r8,8), %rdx
18000a2e8:     	incl	%r8d
18000a2eb:     	movq	%rdx, (%rax)
18000a2ee:     	addq	$0x8, %rax
18000a2f2:     	cmpl	%esi, %r8d
18000a2f5:     	jl	0x18000a2e0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6750>
18000a2f7:     	xorl	%r8d, %r8d
18000a2fa:     	nopw	(%rax,%rax)
18000a300:     	movq	0x28(%rdi), %rcx
18000a304:     	leaq	0x8(%rax), %rax
18000a308:     	movslq	%r8d, %rdx
18000a30b:     	incl	%r8d
18000a30e:     	movq	(%rcx,%rdx,8), %rdx
18000a312:     	movq	%rdx, -0x8(%rax)
18000a316:     	cmpl	%esi, %r8d
18000a319:     	jl	0x18000a300 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6770>
18000a31b:     	movq	0x38(%rsp), %rsi
18000a320:     	xorl	%eax, %eax
18000a322:     	movq	0x40(%rsp), %rdi
18000a327:     	addq	$0x20, %rsp
18000a32b:     	popq	%r14
18000a32d:     	retq
18000a32e:     	int3
18000a32f:     	int3
18000a330:     	pushq	%rbx
18000a332:     	pushq	%rbp
18000a333:     	pushq	%rsi
18000a334:     	pushq	%rdi
18000a335:     	subq	$0x28, %rsp
18000a339:     	cmpq	$0x0, 0xa957(%rip)      # 0x180014c98
18000a341:     	movq	%rcx, %rbp
18000a344:     	movslq	0x8(%rdx), %rdi
18000a348:     	movq	(%rdx), %rsi
18000a34b:     	jne	0x18000a3a3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6813>
18000a34d:     	leaq	0x3b34(%rip), %rcx      # 0x18000de88
18000a354:     	callq	*0x2ede(%rip)           # 0x18000d238
18000a35a:     	movq	%rax, %rbx
18000a35d:     	testq	%rax, %rax
18000a360:     	je	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a366:     	leaq	0x3b23(%rip), %rdx      # 0x18000de90
18000a36d:     	movq	%rax, %rcx
18000a370:     	callq	*0x2df2(%rip)           # 0x18000d168
18000a376:     	movl	(%rbx), %edx
18000a378:     	movq	%rax, 0xa919(%rip)      # 0x180014c98
18000a37f:     	testl	%edx, %edx
18000a381:     	js	0x18000a39a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x680a>
18000a383:     	subl	$0x1, %edx
18000a386:     	movl	%edx, (%rbx)
18000a388:     	jne	0x18000a39a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x680a>
18000a38a:     	movq	%rbx, %rcx
18000a38d:     	callq	*0x2e35(%rip)           # 0x18000d1c8
18000a393:     	movq	0xa8fe(%rip), %rax      # 0x180014c98
18000a39a:     	testq	%rax, %rax
18000a39d:     	je	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a3a3:     	movq	%rdi, %rdx
18000a3a6:     	movq	%rsi, %rcx
18000a3a9:     	callq	*0x2f09(%rip)           # 0x18000d2b8
18000a3af:     	movq	%rax, %rdi
18000a3b2:     	testq	%rax, %rax
18000a3b5:     	je	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a3b7:     	movq	0xa8da(%rip), %rcx      # 0x180014c98
18000a3be:     	xorl	%r8d, %r8d
18000a3c1:     	movq	%rax, %rdx
18000a3c4:     	callq	*0x2dce(%rip)           # 0x18000d198
18000a3ca:     	movl	(%rdi), %ecx
18000a3cc:     	movq	%rax, %rbx
18000a3cf:     	testl	%ecx, %ecx
18000a3d1:     	js	0x18000a3e3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6853>
18000a3d3:     	subl	$0x1, %ecx
18000a3d6:     	movl	%ecx, (%rdi)
18000a3d8:     	jne	0x18000a3e3 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6853>
18000a3da:     	movq	%rdi, %rcx
18000a3dd:     	callq	*0x2de5(%rip)           # 0x18000d1c8
18000a3e3:     	testq	%rbx, %rbx
18000a3e6:     	je	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a3e8:     	movq	0x8(%rbx), %r8
18000a3ec:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
18000a3f7:     	jne	0x18000a435 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x68a5>
18000a3f9:     	movq	0x2ea0(%rip), %rcx      # 0x18000d2a0
18000a400:     	leaq	0x3c81(%rip), %rdx      # 0x18000e088
18000a407:     	movq	0x18(%r8), %r8
18000a40b:     	movq	(%rcx), %rcx
18000a40e:     	callq	*0x2ddc(%rip)           # 0x18000d1f0
18000a414:     	movl	(%rbx), %eax
18000a416:     	testl	%eax, %eax
18000a418:     	js	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a41a:     	subl	$0x1, %eax
18000a41d:     	movl	%eax, (%rbx)
18000a41f:     	jne	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a421:     	movq	%rbx, %rcx
18000a424:     	callq	*0x2d9e(%rip)           # 0x18000d1c8
18000a42a:     	xorl	%eax, %eax
18000a42c:     	addq	$0x28, %rsp
18000a430:     	popq	%rdi
18000a431:     	popq	%rsi
18000a432:     	popq	%rbp
18000a433:     	popq	%rbx
18000a434:     	retq
18000a435:     	xorl	%r8d, %r8d
18000a438:     	leaq	0x9f01(%rip), %rcx      # 0x180014340
18000a43f:     	xorl	%edx, %edx
18000a441:     	callq	*0x2e01(%rip)           # 0x18000d248
18000a447:     	movq	%rax, %rdi
18000a44a:     	testq	%rax, %rax
18000a44d:     	je	0x18000a414 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6884>
18000a44f:     	movq	%rbp, %rcx
18000a452:     	movq	%rbx, 0x18(%rax)
18000a456:     	callq	*0x2d64(%rip)           # 0x18000d1c0
18000a45c:     	movq	%rax, 0x10(%rdi)
18000a460:     	movq	%rax, %rcx
18000a463:     	testq	%rax, %rax
18000a466:     	jne	0x18000a47a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x68ea>
18000a468:     	movl	(%rdi), %eax
18000a46a:     	testl	%eax, %eax
18000a46c:     	js	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a46e:     	subl	$0x1, %eax
18000a471:     	movl	%eax, (%rdi)
18000a473:     	jne	0x18000a42a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x689a>
18000a475:     	movq	%rdi, %rcx
18000a478:     	jmp	0x18000a424 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6894>
18000a47a:     	movl	(%rax), %eax
18000a47c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a481:     	jae	0x18000a487 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x68f7>
18000a483:     	incl	%eax
18000a485:     	movl	%eax, (%rcx)
18000a487:     	movq	%rdi, %rax
18000a48a:     	addq	$0x28, %rsp
18000a48e:     	popq	%rdi
18000a48f:     	popq	%rsi
18000a490:     	popq	%rbp
18000a491:     	popq	%rbx
18000a492:     	retq
18000a493:     	int3
18000a494:     	int3
18000a495:     	int3
18000a496:     	int3
18000a497:     	int3
18000a498:     	int3
18000a499:     	int3
18000a49a:     	int3
18000a49b:     	int3
18000a49c:     	int3
18000a49d:     	int3
18000a49e:     	int3
18000a49f:     	int3
18000a4a0:     	movq	%r9, 0x20(%rsp)
18000a4a5:     	movq	%r8, 0x18(%rsp)
18000a4aa:     	movq	%rdx, 0x10(%rsp)
18000a4af:     	movq	%rcx, 0x8(%rsp)
18000a4b4:     	pushq	%rbx
18000a4b5:     	pushq	%rbp
18000a4b6:     	pushq	%rsi
18000a4b7:     	pushq	%rdi
18000a4b8:     	pushq	%r12
18000a4ba:     	pushq	%r13
18000a4bc:     	pushq	%r14
18000a4be:     	pushq	%r15
18000a4c0:     	subq	$0x68, %rsp
18000a4c4:     	movq	%rcx, %r14
18000a4c7:     	movq	%r9, %r15
18000a4ca:     	leaq	0x366f(%rip), %rcx      # 0x18000db40
18000a4d1:     	movq	%r8, %r13
18000a4d4:     	movq	%rdx, %rsi
18000a4d7:     	callq	*0x2d5b(%rip)           # 0x18000d238
18000a4dd:     	movq	%rax, %rdi
18000a4e0:     	testq	%rax, %rax
18000a4e3:     	jne	0x18000a51c <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x698c>
18000a4e5:     	movq	0x2c4c(%rip), %rcx      # 0x18000d138
18000a4ec:     	movq	(%rcx), %rcx
18000a4ef:     	callq	*0x2cbb(%rip)           # 0x18000d1b0
18000a4f5:     	testl	%eax, %eax
18000a4f7:     	je	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a4fd:     	callq	*0x2dbd(%rip)           # 0x18000d2c0
18000a503:     	leaq	0x3656(%rip), %rcx      # 0x18000db60
18000a50a:     	callq	*0x2d28(%rip)           # 0x18000d238
18000a510:     	movq	%rax, %rdi
18000a513:     	testq	%rax, %rax
18000a516:     	je	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a51c:     	leaq	0x365d(%rip), %rdx      # 0x18000db80
18000a523:     	movq	%rdi, %rcx
18000a526:     	callq	*0x2c3c(%rip)           # 0x18000d168
18000a52c:     	movl	(%rdi), %ecx
18000a52e:     	movq	%rax, %rbx
18000a531:     	testl	%ecx, %ecx
18000a533:     	js	0x18000a545 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x69b5>
18000a535:     	subl	$0x1, %ecx
18000a538:     	movl	%ecx, (%rdi)
18000a53a:     	jne	0x18000a545 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x69b5>
18000a53c:     	movq	%rdi, %rcx
18000a53f:     	callq	*0x2c83(%rip)           # 0x18000d1c8
18000a545:     	testq	%rbx, %rbx
18000a548:     	je	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a54e:     	movq	0x2bab(%rip), %rax      # 0x18000d100
18000a555:     	cmpq	%rax, 0x8(%rbx)
18000a559:     	je	0x18000a595 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a05>
18000a55b:     	movq	0x2d4e(%rip), %rcx      # 0x18000d2b0
18000a562:     	leaq	0x3627(%rip), %rdx      # 0x18000db90
18000a569:     	movq	(%rcx), %rcx
18000a56c:     	callq	*0x2d36(%rip)           # 0x18000d2a8
18000a572:     	movl	(%rbx), %eax
18000a574:     	testl	%eax, %eax
18000a576:     	js	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a57c:     	subl	$0x1, %eax
18000a57f:     	movl	%eax, (%rbx)
18000a581:     	jne	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a587:     	movq	%rbx, %rcx
18000a58a:     	callq	*0x2c38(%rip)           # 0x18000d1c8
18000a590:     	jmp	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a595:     	xorl	%edx, %edx
18000a597:     	movq	%rbx, %rcx
18000a59a:     	callq	*0x2c08(%rip)           # 0x18000d1a8
18000a5a0:     	movl	(%rbx), %ecx
18000a5a2:     	movq	%rax, 0xa6d7(%rip)      # 0x180014c80
18000a5a9:     	testl	%ecx, %ecx
18000a5ab:     	js	0x18000a5c4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a34>
18000a5ad:     	subl	$0x1, %ecx
18000a5b0:     	movl	%ecx, (%rbx)
18000a5b2:     	jne	0x18000a5c4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a34>
18000a5b4:     	movq	%rbx, %rcx
18000a5b7:     	callq	*0x2c0b(%rip)           # 0x18000d1c8
18000a5bd:     	movq	0xa6bc(%rip), %rax      # 0x180014c80
18000a5c4:     	testq	%rax, %rax
18000a5c7:     	jne	0x18000a5e2 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a52>
18000a5c9:     	leaq	0x35e8(%rip), %rdx      # 0x18000dbb8
18000a5d0:     	movq	0x2cd9(%rip), %rcx      # 0x18000d2b0
18000a5d7:     	movq	(%rcx), %rcx
18000a5da:     	callq	*0x2cc8(%rip)           # 0x18000d2a8
18000a5e0:     	jmp	0x18000a617 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a87>
18000a5e2:     	callq	*(%rax)
18000a5e4:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
18000a5e9:     	jbe	0x18000a64a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aba>
18000a5eb:     	movq	0x2cbe(%rip), %rax      # 0x18000d2b0
18000a5f2:     	movq	(%rax), %rbx
18000a5f5:     	movq	0xa684(%rip), %rax      # 0x180014c80
18000a5fc:     	callq	*(%rax)
18000a5fe:     	movl	$0x2000000, %r8d        # imm = 0x2000000
18000a604:     	leaq	0x35d5(%rip), %rdx      # 0x18000dbe0
18000a60b:     	movl	%eax, %r9d
18000a60e:     	movq	%rbx, %rcx
18000a611:     	callq	*0x2bd9(%rip)           # 0x18000d1f0
18000a617:     	callq	*0x2afb(%rip)           # 0x18000d118
18000a61d:     	movq	0x2aec(%rip), %rcx      # 0x18000d110
18000a624:     	leaq	0x37dd(%rip), %rdx      # 0x18000de08
18000a62b:     	movq	(%rcx), %rcx
18000a62e:     	callq	*0x2c74(%rip)           # 0x18000d2a8
18000a634:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a639:     	addq	$0x68, %rsp
18000a63d:     	popq	%r15
18000a63f:     	popq	%r14
18000a641:     	popq	%r13
18000a643:     	popq	%r12
18000a645:     	popq	%rdi
18000a646:     	popq	%rsi
18000a647:     	popq	%rbp
18000a648:     	popq	%rbx
18000a649:     	retq
18000a64a:     	movq	0xa62f(%rip), %rax      # 0x180014c80
18000a651:     	callq	*0x698(%rax)
18000a657:     	movl	%eax, 0xa62f(%rip)      # 0x180014c8c
18000a65d:     	cmpl	$0x10, %eax
18000a660:     	jge	0x18000a67e <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aee>
18000a662:     	movq	0x2c47(%rip), %rcx      # 0x18000d2b0
18000a669:     	leaq	0x35c0(%rip), %rdx      # 0x18000dc30
18000a670:     	movl	%eax, %r9d
18000a673:     	movl	$0x10, %r8d
18000a679:     	movq	(%rcx), %rcx
18000a67c:     	jmp	0x18000a611 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a81>
18000a67e:     	movq	0xa5fb(%rip), %rax      # 0x180014c80
18000a685:     	callq	*0x690(%rax)
18000a68b:     	testl	%eax, %eax
18000a68d:     	jne	0x18000a69b <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6b0b>
18000a68f:     	leaq	0x36ea(%rip), %rdx      # 0x18000dd80
18000a696:     	jmp	0x18000a5d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a40>
18000a69b:     	cmpl	$0x1, %eax
18000a69e:     	je	0x18000a6ac <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6b1c>
18000a6a0:     	leaq	0x3709(%rip), %rdx      # 0x18000ddb0
18000a6a7:     	jmp	0x18000a5d0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6a40>
18000a6ac:     	leaq	0xa16d(%rip), %rcx      # 0x180014820
18000a6b3:     	callq	*0x2ab7(%rip)           # 0x18000d170
18000a6b9:     	testl	%eax, %eax
18000a6bb:     	jne	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000a6c1:     	leaq	0x9c78(%rip), %rcx      # 0x180014340
18000a6c8:     	callq	*0x2aa2(%rip)           # 0x18000d170
18000a6ce:     	testl	%eax, %eax
18000a6d0:     	jne	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000a6d6:     	leaq	0x9fa3(%rip), %rcx      # 0x180014680
18000a6dd:     	callq	*0x2a8d(%rip)           # 0x18000d170
18000a6e3:     	testl	%eax, %eax
18000a6e5:     	jne	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000a6eb:     	xorl	%ebx, %ebx
18000a6ed:     	cmpl	%ebx, 0xa595(%rip)      # 0x180014c88
18000a6f3:     	jne	0x18000a736 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6ba6>
18000a6f5:     	movq	%gs:0x58, %rax
18000a6fe:     	movl	0xa59c(%rip), %ecx      # 0x180014ca0
18000a704:     	movl	$0x1, 0xa57a(%rip)      # 0x180014c88
18000a70e:     	movq	(%rax,%rcx,8), %rdx
18000a712:     	movl	$0x10, %eax
18000a717:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a71e:     	movl	$0x9f0, %eax            # imm = 0x9F0
18000a723:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a72a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000a72f:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a736:     	movl	%ebx, 0xa4fc(%rip)      # 0x180014c38
18000a73c:     	movq	%rbx, %rax
18000a73f:     	movb	%bl, 0xa4fb(%rip)       # 0x180014c40
18000a745:     	movq	%rbx, %rcx
18000a748:     	xchgq	%rax, 0xa4f9(%rip)      # 0x180014c48
18000a74f:     	xchgq	%rcx, 0xa4fa(%rip)      # 0x180014c50
18000a756:     	movq	%rbx, %rax
18000a759:     	movq	%rbx, %rcx
18000a75c:     	xchgq	%rax, 0xa4f5(%rip)      # 0x180014c58
18000a763:     	xchgq	%rcx, 0xa4f6(%rip)      # 0x180014c60
18000a76a:     	movq	0x28ef(%rip), %rax      # 0x18000d060
18000a771:     	leaq	0x9d68(%rip), %rcx      # 0x1800144e0
18000a778:     	movq	%rax, 0xa4e9(%rip)      # 0x180014c68
18000a77f:     	movq	0x28ea(%rip), %rax      # 0x18000d070
18000a786:     	movq	%rax, 0xa4e3(%rip)      # 0x180014c70
18000a78d:     	movq	0x28d4(%rip), %rax      # 0x18000d068
18000a794:     	movq	%rax, 0xa4dd(%rip)      # 0x180014c78
18000a79b:     	movq	0x2aa6(%rip), %rax      # 0x18000d248
18000a7a2:     	movq	%rax, 0x9e6f(%rip)      # 0x180014618
18000a7a9:     	callq	*0x29c1(%rip)           # 0x18000d170
18000a7af:     	testl	%eax, %eax
18000a7b1:     	jne	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000a7b7:     	leaq	0x3762(%rip), %rdx      # 0x18000df20
18000a7be:     	movq	%r14, %rcx
18000a7c1:     	callq	*0x29a1(%rip)           # 0x18000d168
18000a7c7:     	movq	%rax, 0x28(%rsp)
18000a7cc:     	movq	%rax, %rdi
18000a7cf:     	testq	%rax, %rax
18000a7d2:     	je	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000a7d8:     	leaq	0x38da(%rip), %rcx      # 0x18000e0b9
18000a7df:     	callq	*0x2a9b(%rip)           # 0x18000d280
18000a7e5:     	movq	%rax, 0x20(%rsp)
18000a7ea:     	movq	%rax, %r12
18000a7ed:     	testq	%rax, %rax
18000a7f0:     	je	0x18000ab34 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6fa4>
18000a7f6:     	movl	%ebx, %ebp
18000a7f8:     	cmpq	%rbx, (%rsi)
18000a7fb:     	je	0x18000a9a4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6e14>
18000a801:     	movslq	%ebp, %rbx
18000a804:     	leaq	0x30(%rsp), %rdx
18000a809:     	movq	%r14, %rcx
18000a80c:     	leaq	(%rbx,%rbx,4), %rax
18000a810:     	movups	(%r13,%rax,8), %xmm0
18000a816:     	movups	0x10(%r13,%rax,8), %xmm1
18000a81c:     	movaps	%xmm0, 0x30(%rsp)
18000a821:     	movsd	0x20(%r13,%rax,8), %xmm0
18000a828:     	movsd	%xmm0, 0x50(%rsp)
18000a82e:     	movaps	%xmm1, 0x40(%rsp)
18000a833:     	callq	0x18000a330 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x67a0>
18000a838:     	movq	%rax, %r14
18000a83b:     	testq	%rax, %rax
18000a83e:     	je	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000a844:     	movq	(%rsi), %rcx
18000a847:     	callq	*0x2a33(%rip)           # 0x18000d280
18000a84d:     	movq	%rax, %r13
18000a850:     	testq	%rax, %rax
18000a853:     	je	0x18000ab57 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6fc7>
18000a859:     	movq	(%r15,%rbx,8), %rcx
18000a85d:     	xorl	%edx, %edx
18000a85f:     	movq	%r14, (%rcx)
18000a862:     	leaq	0x9fb7(%rip), %rcx      # 0x180014820
18000a869:     	movq	0x8(%rsi), %r12
18000a86d:     	callq	*0x28dd(%rip)           # 0x18000d150
18000a873:     	movq	%rax, %rbx
18000a876:     	testq	%rax, %rax
18000a879:     	je	0x18000a8f6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d66>
18000a87b:     	movq	%r13, %rcx
18000a87e:     	callq	*0x28fc(%rip)           # 0x18000d180
18000a884:     	movq	%rax, %rdi
18000a887:     	testq	%rax, %rax
18000a88a:     	je	0x18000a8ac <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d1c>
18000a88c:     	movq	%rax, %rcx
18000a88f:     	callq	0x18000c135 <numba_list_iter_next+0xed5>
18000a894:     	leaq	0x1(%rax), %rcx
18000a898:     	callq	*0x29b2(%rip)           # 0x18000d250
18000a89e:     	movq	%rax, %rsi
18000a8a1:     	testq	%rax, %rax
18000a8a4:     	jne	0x18000a8b4 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d24>
18000a8a6:     	callq	*0x2894(%rip)           # 0x18000d140
18000a8ac:     	xorl	%eax, %eax
18000a8ae:     	movq	%rax, 0x20(%rbx)
18000a8b2:     	jmp	0x18000a8e5 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d55>
18000a8b4:     	movq	%rdi, %rdx
18000a8b7:     	movq	%rsi, %rcx
18000a8ba:     	callq	0x18000c12f <numba_list_iter_next+0xecf>
18000a8bf:     	movq	0x20(%rsp), %rcx
18000a8c4:     	movq	%rsi, 0x20(%rbx)
18000a8c8:     	movq	%r12, 0x28(%rbx)
18000a8cc:     	movl	$0x3, 0x30(%rbx)
18000a8d3:     	callq	0x180009db0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6220>
18000a8d8:     	movq	%rax, 0x38(%rbx)
18000a8dc:     	testq	%rax, %rax
18000a8df:     	jne	0x18000aa50 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6ec0>
18000a8e5:     	movl	(%rbx), %eax
18000a8e7:     	testl	%eax, %eax
18000a8e9:     	js	0x18000a8f6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d66>
18000a8eb:     	subl	$0x1, %eax
18000a8ee:     	movl	%eax, (%rbx)
18000a8f0:     	je	0x18000aa9d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f0d>
18000a8f6:     	xorl	%edi, %edi
18000a8f8:     	movl	(%r14), %eax
18000a8fb:     	testl	%eax, %eax
18000a8fd:     	js	0x18000a910 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d80>
18000a8ff:     	subl	$0x1, %eax
18000a902:     	movl	%eax, (%r14)
18000a905:     	jne	0x18000a910 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d80>
18000a907:     	movq	%r14, %rcx
18000a90a:     	callq	*0x28b8(%rip)           # 0x18000d1c8
18000a910:     	movl	(%r13), %eax
18000a914:     	testl	%eax, %eax
18000a916:     	js	0x18000a92a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d9a>
18000a918:     	subl	$0x1, %eax
18000a91b:     	movl	%eax, (%r13)
18000a91f:     	jne	0x18000a92a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d9a>
18000a921:     	movq	%r13, %rcx
18000a924:     	callq	*0x289e(%rip)           # 0x18000d1c8
18000a92a:     	testq	%rdi, %rdi
18000a92d:     	je	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000a933:     	movq	0xb8(%rsp), %rsi
18000a93b:     	movq	%rdi, %r8
18000a93e:     	movq	0xb0(%rsp), %r14
18000a946:     	movq	%r14, %rcx
18000a949:     	movq	(%rsi), %rdx
18000a94c:     	callq	*0x28ce(%rip)           # 0x18000d220
18000a952:     	movl	(%rdi), %ecx
18000a954:     	testl	%eax, %eax
18000a956:     	jne	0x18000aafa <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f6a>
18000a95c:     	testl	%ecx, %ecx
18000a95e:     	js	0x18000a972 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6de2>
18000a960:     	leal	-0x1(%rcx), %eax
18000a963:     	movl	%eax, (%rdi)
18000a965:     	testl	%eax, %eax
18000a967:     	jne	0x18000a972 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6de2>
18000a969:     	movq	%rdi, %rcx
18000a96c:     	callq	*0x2856(%rip)           # 0x18000d1c8
18000a972:     	movq	0xc8(%rsp), %r15
18000a97a:     	addq	$0x20, %rsi
18000a97e:     	movq	0xc0(%rsp), %r13
18000a986:     	incl	%ebp
18000a988:     	movq	%rsi, 0xb8(%rsp)
18000a990:     	cmpq	$0x0, (%rsi)
18000a994:     	jne	0x18000a801 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6c71>
18000a99a:     	movq	0x20(%rsp), %r12
18000a99f:     	movq	0x28(%rsp), %rdi
18000a9a4:     	movslq	%ebp, %rax
18000a9a7:     	cmpq	$0x0, (%r15,%rax,8)
18000a9ac:     	je	0x18000aa19 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6e89>
18000a9ae:     	nop
18000a9b0:     	movslq	%ebp, %rbx
18000a9b3:     	leaq	0x30(%rsp), %rdx
18000a9b8:     	movq	%r14, %rcx
18000a9bb:     	leaq	(%rbx,%rbx,4), %rax
18000a9bf:     	movups	(%r13,%rax,8), %xmm0
18000a9c5:     	movups	0x10(%r13,%rax,8), %xmm1
18000a9cb:     	movaps	%xmm0, 0x30(%rsp)
18000a9d0:     	movsd	0x20(%r13,%rax,8), %xmm0
18000a9d7:     	movsd	%xmm0, 0x50(%rsp)
18000a9dd:     	movaps	%xmm1, 0x40(%rsp)
18000a9e2:     	callq	0x18000a330 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x67a0>
18000a9e7:     	testq	%rax, %rax
18000a9ea:     	je	0x18000ab15 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f85>
18000a9f0:     	movq	(%r15,%rbx,8), %rcx
18000a9f4:     	movq	%rax, (%rcx)
18000a9f7:     	movl	(%rax), %ecx
18000a9f9:     	testl	%ecx, %ecx
18000a9fb:     	js	0x18000aa0d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6e7d>
18000a9fd:     	subl	$0x1, %ecx
18000aa00:     	movl	%ecx, (%rax)
18000aa02:     	jne	0x18000aa0d <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6e7d>
18000aa04:     	movq	%rax, %rcx
18000aa07:     	callq	*0x27bb(%rip)           # 0x18000d1c8
18000aa0d:     	incl	%ebp
18000aa0f:     	movslq	%ebp, %rax
18000aa12:     	cmpq	$0x0, (%r15,%rax,8)
18000aa17:     	jne	0x18000a9b0 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6e20>
18000aa19:     	movl	(%r12), %eax
18000aa1d:     	testl	%eax, %eax
18000aa1f:     	js	0x18000aa33 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6ea3>
18000aa21:     	subl	$0x1, %eax
18000aa24:     	movl	%eax, (%r12)
18000aa28:     	jne	0x18000aa33 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6ea3>
18000aa2a:     	movq	%r12, %rcx
18000aa2d:     	callq	*0x2795(%rip)           # 0x18000d1c8
18000aa33:     	movl	(%rdi), %eax
18000aa35:     	testl	%eax, %eax
18000aa37:     	js	0x18000aa49 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6eb9>
18000aa39:     	subl	$0x1, %eax
18000aa3c:     	movl	%eax, (%rdi)
18000aa3e:     	jne	0x18000aa49 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6eb9>
18000aa40:     	movq	%rdi, %rcx
18000aa43:     	callq	*0x277f(%rip)           # 0x18000d1c8
18000aa49:     	xorl	%eax, %eax
18000aa4b:     	jmp	0x18000a639 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa9>
18000aa50:     	movl	(%r14), %eax
18000aa53:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000aa58:     	jae	0x18000aa5f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6ecf>
18000aa5a:     	incl	%eax
18000aa5c:     	movl	%eax, (%r14)
18000aa5f:     	movq	0xb0(%rsp), %rcx
18000aa67:     	leaq	0x34b2(%rip), %rdx      # 0x18000df20
18000aa6e:     	movq	%r14, 0x18(%rbx)
18000aa72:     	movq	$0x0, 0x40(%rbx)
18000aa7a:     	callq	*0x26e8(%rip)           # 0x18000d168
18000aa80:     	movq	%rax, %rsi
18000aa83:     	testq	%rax, %rax
18000aa86:     	jne	0x18000aaab <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f1b>
18000aa88:     	movl	(%rbx), %eax
18000aa8a:     	testl	%eax, %eax
18000aa8c:     	js	0x18000a8f6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d66>
18000aa92:     	subl	$0x1, %eax
18000aa95:     	movl	%eax, (%rbx)
18000aa97:     	jne	0x18000a8f6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d66>
18000aa9d:     	movq	%rbx, %rcx
18000aaa0:     	callq	*0x2722(%rip)           # 0x18000d1c8
18000aaa6:     	jmp	0x18000a8f6 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d66>
18000aaab:     	xorl	%r9d, %r9d
18000aaae:     	leaq	0x20(%rbx), %rcx
18000aab2:     	movq	%rsi, %r8
18000aab5:     	movq	%rbx, %rdx
18000aab8:     	callq	*0x268a(%rip)           # 0x18000d148
18000aabe:     	movq	%rax, %rdi
18000aac1:     	movl	(%rbx), %eax
18000aac3:     	testl	%eax, %eax
18000aac5:     	js	0x18000aad7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f47>
18000aac7:     	subl	$0x1, %eax
18000aaca:     	movl	%eax, (%rbx)
18000aacc:     	jne	0x18000aad7 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f47>
18000aace:     	movq	%rbx, %rcx
18000aad1:     	callq	*0x26f1(%rip)           # 0x18000d1c8
18000aad7:     	movl	(%rsi), %eax
18000aad9:     	testl	%eax, %eax
18000aadb:     	js	0x18000a8f8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d68>
18000aae1:     	subl	$0x1, %eax
18000aae4:     	movl	%eax, (%rsi)
18000aae6:     	jne	0x18000a8f8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d68>
18000aaec:     	movq	%rsi, %rcx
18000aaef:     	callq	*0x26d3(%rip)           # 0x18000d1c8
18000aaf5:     	jmp	0x18000a8f8 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6d68>
18000aafa:     	testl	%ecx, %ecx
18000aafc:     	js	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000aafe:     	leal	-0x1(%rcx), %eax
18000ab01:     	movl	%eax, (%rdi)
18000ab03:     	testl	%eax, %eax
18000ab05:     	jne	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000ab07:     	movq	%rdi, %rcx
18000ab0a:     	callq	*0x26b8(%rip)           # 0x18000d1c8
18000ab10:     	movq	0x20(%rsp), %r12
18000ab15:     	movl	(%r12), %eax
18000ab19:     	testl	%eax, %eax
18000ab1b:     	js	0x18000ab2f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f9f>
18000ab1d:     	subl	$0x1, %eax
18000ab20:     	movl	%eax, (%r12)
18000ab24:     	jne	0x18000ab2f <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f9f>
18000ab26:     	movq	%r12, %rcx
18000ab29:     	callq	*0x2699(%rip)           # 0x18000d1c8
18000ab2f:     	movq	0x28(%rsp), %rdi
18000ab34:     	movl	(%rdi), %eax
18000ab36:     	testl	%eax, %eax
18000ab38:     	js	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000ab3e:     	subl	$0x1, %eax
18000ab41:     	movl	%eax, (%rdi)
18000ab43:     	jne	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000ab49:     	movq	%rdi, %rcx
18000ab4c:     	callq	*0x2676(%rip)           # 0x18000d1c8
18000ab52:     	jmp	0x18000a634 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6aa4>
18000ab57:     	movl	(%r14), %eax
18000ab5a:     	testl	%eax, %eax
18000ab5c:     	js	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000ab5e:     	subl	$0x1, %eax
18000ab61:     	movl	%eax, (%r14)
18000ab64:     	jne	0x18000ab10 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f80>
18000ab66:     	movq	%r14, %rcx
18000ab69:     	jmp	0x18000ab0a <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6f7a>
18000ab6b:     	int3
18000ab6c:     	int3
18000ab6d:     	int3
18000ab6e:     	int3
18000ab6f:     	int3
18000ab70:     	leaq	0xa169(%rip), %rax      # 0x180014ce0
18000ab77:     	retq
18000ab78:     	int3
18000ab79:     	int3
18000ab7a:     	int3
18000ab7b:     	int3
18000ab7c:     	int3
18000ab7d:     	int3
18000ab7e:     	int3
18000ab7f:     	int3

000000018000ab80 <numba_list_set_method_table>:
18000ab80:     	movups	(%rdx), %xmm0
18000ab83:     	movups	%xmm0, 0x20(%rcx)
18000ab87:     	retq
18000ab88:     	int3
18000ab89:     	int3
18000ab8a:     	int3
18000ab8b:     	int3
18000ab8c:     	int3
18000ab8d:     	int3
18000ab8e:     	int3
18000ab8f:     	int3

000000018000ab90 <numba_list_new>:
18000ab90:     	pushq	%rbx
18000ab92:     	pushq	%rbp
18000ab93:     	pushq	%rsi
18000ab94:     	pushq	%rdi
18000ab95:     	subq	$0x28, %rsp
18000ab99:     	movq	%rcx, %rsi
18000ab9c:     	movq	%r8, %rdi
18000ab9f:     	movl	$0x38, %ecx
18000aba4:     	movq	%rdx, %rbp
18000aba7:     	callq	*0x24b3(%rip)           # 0x18000d060
18000abad:     	movq	%rax, %rbx
18000abb0:     	testq	%rax, %rax
18000abb3:     	je	0x18000ac1d <numba_list_new+0x8d>
18000abb5:     	movq	$0x0, (%rax)
18000abbc:     	xorps	%xmm0, %xmm0
18000abbf:     	movq	%rbp, 0x8(%rax)
18000abc3:     	movq	%rdi, 0x10(%rax)
18000abc7:     	movl	$0x1, 0x18(%rax)
18000abce:     	movups	%xmm0, 0x20(%rax)
18000abd2:     	testq	%rdi, %rdi
18000abd5:     	je	0x18000ac2b <numba_list_new+0x9b>
18000abd7:     	imulq	%rbp, %rdi
18000abdb:     	movl	$0x8, %ecx
18000abe0:     	movq	%rdi, %rax
18000abe3:     	cqto
18000abe5:     	andl	$0x7, %edx
18000abe8:     	addq	%rdx, %rax
18000abeb:     	andl	$0x7, %eax
18000abee:     	subq	%rdx, %rax
18000abf1:     	subq	%rax, %rcx
18000abf4:     	movq	%rcx, %rax
18000abf7:     	cqto
18000abf9:     	andl	$0x7, %edx
18000abfc:     	leaq	(%rdx,%rax), %rcx
18000ac00:     	andl	$0x7, %ecx
18000ac03:     	subq	%rdx, %rcx
18000ac06:     	addq	%rdi, %rcx
18000ac09:     	callq	*0x2451(%rip)           # 0x18000d060
18000ac0f:     	testq	%rax, %rax
18000ac12:     	jne	0x18000ac2d <numba_list_new+0x9d>
18000ac14:     	movq	%rbx, %rcx
18000ac17:     	callq	*0x244b(%rip)           # 0x18000d068
18000ac1d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000ac22:     	addq	$0x28, %rsp
18000ac26:     	popq	%rdi
18000ac27:     	popq	%rsi
18000ac28:     	popq	%rbp
18000ac29:     	popq	%rbx
18000ac2a:     	retq
18000ac2b:     	xorl	%eax, %eax
18000ac2d:     	movq	%rax, 0x30(%rbx)
18000ac31:     	xorl	%eax, %eax
18000ac33:     	movq	%rbx, (%rsi)
18000ac36:     	addq	$0x28, %rsp
18000ac3a:     	popq	%rdi
18000ac3b:     	popq	%rsi
18000ac3c:     	popq	%rbp
18000ac3d:     	popq	%rbx
18000ac3e:     	retq
18000ac3f:     	int3

000000018000ac40 <numba_list_free>:
18000ac40:     	pushq	%rbx
18000ac42:     	subq	$0x20, %rsp
18000ac46:     	cmpq	$0x0, 0x28(%rcx)
18000ac4b:     	movq	%rcx, %rbx
18000ac4e:     	je	0x18000ac84 <numba_list_free+0x44>
18000ac50:     	movq	%rdi, 0x30(%rsp)
18000ac55:     	xorl	%edi, %edi
18000ac57:     	cmpq	%rdi, (%rcx)
18000ac5a:     	jle	0x18000ac7f <numba_list_free+0x3f>
18000ac5c:     	nopl	(%rax)
18000ac60:     	movq	0x28(%rbx), %rax
18000ac64:     	testq	%rax, %rax
18000ac67:     	je	0x18000ac77 <numba_list_free+0x37>
18000ac69:     	movq	%rdi, %rcx
18000ac6c:     	imulq	0x8(%rbx), %rcx
18000ac71:     	addq	0x30(%rbx), %rcx
18000ac75:     	callq	*%rax
18000ac77:     	incq	%rdi
18000ac7a:     	cmpq	(%rbx), %rdi
18000ac7d:     	jl	0x18000ac60 <numba_list_free+0x20>
18000ac7f:     	movq	0x30(%rsp), %rdi
18000ac84:     	movq	0x30(%rbx), %rcx
18000ac88:     	testq	%rcx, %rcx
18000ac8b:     	je	0x18000ac93 <numba_list_free+0x53>
18000ac8d:     	callq	*0x23d5(%rip)           # 0x18000d068
18000ac93:     	movq	%rbx, %rcx
18000ac96:     	addq	$0x20, %rsp
18000ac9a:     	popq	%rbx
18000ac9b:     	jmpq	*0x23c6(%rip)           # 0x18000d068
18000aca2:     	int3
18000aca3:     	int3
18000aca4:     	int3
18000aca5:     	int3
18000aca6:     	int3
18000aca7:     	int3
18000aca8:     	int3
18000aca9:     	int3
18000acaa:     	int3
18000acab:     	int3
18000acac:     	int3
18000acad:     	int3
18000acae:     	int3
18000acaf:     	int3

000000018000acb0 <numba_list_base_ptr>:
18000acb0:     	movq	0x30(%rcx), %rax
18000acb4:     	retq
18000acb5:     	int3
18000acb6:     	int3
18000acb7:     	int3
18000acb8:     	int3
18000acb9:     	int3
18000acba:     	int3
18000acbb:     	int3
18000acbc:     	int3
18000acbd:     	int3
18000acbe:     	int3
18000acbf:     	int3

000000018000acc0 <numba_list_size_address>:
18000acc0:     	movq	%rcx, %rax
18000acc3:     	retq
18000acc4:     	int3
18000acc5:     	int3
18000acc6:     	int3
18000acc7:     	int3
18000acc8:     	int3
18000acc9:     	int3
18000acca:     	int3
18000accb:     	int3
18000accc:     	int3
18000accd:     	int3
18000acce:     	int3
18000accf:     	int3

000000018000acd0 <numba_list_length>:
18000acd0:     	movq	(%rcx), %rax
18000acd3:     	retq
18000acd4:     	int3
18000acd5:     	int3
18000acd6:     	int3
18000acd7:     	int3
18000acd8:     	int3
18000acd9:     	int3
18000acda:     	int3
18000acdb:     	int3
18000acdc:     	int3
18000acdd:     	int3
18000acde:     	int3
18000acdf:     	int3

000000018000ace0 <numba_list_allocated>:
18000ace0:     	movq	0x10(%rcx), %rax
18000ace4:     	retq
18000ace5:     	int3
18000ace6:     	int3
18000ace7:     	int3
18000ace8:     	int3
18000ace9:     	int3
18000acea:     	int3
18000aceb:     	int3
18000acec:     	int3
18000aced:     	int3
18000acee:     	int3
18000acef:     	int3

000000018000acf0 <numba_list_is_mutable>:
18000acf0:     	movl	0x18(%rcx), %eax
18000acf3:     	retq
18000acf4:     	int3
18000acf5:     	int3
18000acf6:     	int3
18000acf7:     	int3
18000acf8:     	int3
18000acf9:     	int3
18000acfa:     	int3
18000acfb:     	int3
18000acfc:     	int3
18000acfd:     	int3
18000acfe:     	int3
18000acff:     	int3

000000018000ad00 <numba_list_set_is_mutable>:
18000ad00:     	movl	%edx, 0x18(%rcx)
18000ad03:     	retq
18000ad04:     	int3
18000ad05:     	int3
18000ad06:     	int3
18000ad07:     	int3
18000ad08:     	int3
18000ad09:     	int3
18000ad0a:     	int3
18000ad0b:     	int3
18000ad0c:     	int3
18000ad0d:     	int3
18000ad0e:     	int3
18000ad0f:     	int3

000000018000ad10 <numba_list_setitem>:
18000ad10:     	movq	%rbx, 0x10(%rsp)
18000ad15:     	pushq	%rsi
18000ad16:     	subq	$0x20, %rsp
18000ad1a:     	cmpl	$0x0, 0x18(%rcx)
18000ad1e:     	movq	%r8, %rsi
18000ad21:     	movq	%rcx, %rbx
18000ad24:     	jne	0x18000ad36 <numba_list_setitem+0x26>
18000ad26:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000ad2b:     	movq	0x38(%rsp), %rbx
18000ad30:     	addq	$0x20, %rsp
18000ad34:     	popq	%rsi
18000ad35:     	retq
18000ad36:     	cmpq	(%rcx), %rdx
18000ad39:     	jb	0x18000ad4b <numba_list_setitem+0x3b>
18000ad3b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000ad40:     	movq	0x38(%rsp), %rbx
18000ad45:     	addq	$0x20, %rsp
18000ad49:     	popq	%rsi
18000ad4a:     	retq
18000ad4b:     	imulq	0x8(%rcx), %rdx
18000ad50:     	movq	0x28(%rcx), %rax
18000ad54:     	movq	%rdi, 0x30(%rsp)
18000ad59:     	movq	0x30(%rcx), %rdi
18000ad5d:     	addq	%rdx, %rdi
18000ad60:     	testq	%rax, %rax
18000ad63:     	je	0x18000ad6a <numba_list_setitem+0x5a>
18000ad65:     	movq	%rdi, %rcx
18000ad68:     	callq	*%rax
18000ad6a:     	movq	0x8(%rbx), %r8
18000ad6e:     	movq	%rsi, %rdx
18000ad71:     	movq	%rdi, %rcx
18000ad74:     	callq	0x18000c123 <numba_list_iter_next+0xec3>
18000ad79:     	movq	0x20(%rbx), %rax
18000ad7d:     	testq	%rax, %rax
18000ad80:     	je	0x18000ad87 <numba_list_setitem+0x77>
18000ad82:     	movq	%rdi, %rcx
18000ad85:     	callq	*%rax
18000ad87:     	movq	0x30(%rsp), %rdi
18000ad8c:     	xorl	%eax, %eax
18000ad8e:     	movq	0x38(%rsp), %rbx
18000ad93:     	addq	$0x20, %rsp
18000ad97:     	popq	%rsi
18000ad98:     	retq
18000ad99:     	int3
18000ad9a:     	int3
18000ad9b:     	int3
18000ad9c:     	int3
18000ad9d:     	int3
18000ad9e:     	int3
18000ad9f:     	int3

000000018000ada0 <numba_list_getitem>:
18000ada0:     	subq	$0x28, %rsp
18000ada4:     	movq	%r8, %r9
18000ada7:     	movq	%rdx, %rax
18000adaa:     	cmpq	(%rcx), %rdx
18000adad:     	jb	0x18000adb9 <numba_list_getitem+0x19>
18000adaf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000adb4:     	addq	$0x28, %rsp
18000adb8:     	retq
18000adb9:     	movq	0x8(%rcx), %r8
18000adbd:     	movq	%r8, %rdx
18000adc0:     	imulq	%rax, %rdx
18000adc4:     	addq	0x30(%rcx), %rdx
18000adc8:     	movq	%r9, %rcx
18000adcb:     	callq	0x18000c123 <numba_list_iter_next+0xec3>
18000add0:     	xorl	%eax, %eax
18000add2:     	addq	$0x28, %rsp
18000add6:     	retq
18000add7:     	int3
18000add8:     	int3
18000add9:     	int3
18000adda:     	int3
18000addb:     	int3
18000addc:     	int3
18000addd:     	int3
18000adde:     	int3
18000addf:     	int3

000000018000ade0 <numba_list_append>:
18000ade0:     	movq	%rbx, 0x10(%rsp)
18000ade5:     	pushq	%rsi
18000ade6:     	subq	$0x20, %rsp
18000adea:     	cmpl	$0x0, 0x18(%rcx)
18000adee:     	movq	%rdx, %rsi
18000adf1:     	movq	%rcx, %rbx
18000adf4:     	jne	0x18000ae06 <numba_list_append+0x26>
18000adf6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000adfb:     	movq	0x38(%rsp), %rbx
18000ae00:     	addq	$0x20, %rsp
18000ae04:     	popq	%rsi
18000ae05:     	retq
18000ae06:     	movq	(%rcx), %rdx
18000ae09:     	incq	%rdx
18000ae0c:     	callq	0x18000ae60 <numba_list_resize>
18000ae11:     	testl	%eax, %eax
18000ae13:     	js	0x18000ae4c <numba_list_append+0x6c>
18000ae15:     	movq	0x8(%rbx), %r8
18000ae19:     	movq	%rsi, %rdx
18000ae1c:     	movq	%rdi, 0x30(%rsp)
18000ae21:     	movq	(%rbx), %rdi
18000ae24:     	decq	%rdi
18000ae27:     	imulq	%r8, %rdi
18000ae2b:     	addq	0x30(%rbx), %rdi
18000ae2f:     	movq	%rdi, %rcx
18000ae32:     	callq	0x18000c123 <numba_list_iter_next+0xec3>
18000ae37:     	movq	0x20(%rbx), %rax
18000ae3b:     	testq	%rax, %rax
18000ae3e:     	je	0x18000ae45 <numba_list_append+0x65>
18000ae40:     	movq	%rdi, %rcx
18000ae43:     	callq	*%rax
18000ae45:     	movq	0x30(%rsp), %rdi
18000ae4a:     	xorl	%eax, %eax
18000ae4c:     	movq	0x38(%rsp), %rbx
18000ae51:     	addq	$0x20, %rsp
18000ae55:     	popq	%rsi
18000ae56:     	retq
18000ae57:     	int3
18000ae58:     	int3
18000ae59:     	int3
18000ae5a:     	int3
18000ae5b:     	int3
18000ae5c:     	int3
18000ae5d:     	int3
18000ae5e:     	int3
18000ae5f:     	int3

000000018000ae60 <numba_list_resize>:
18000ae60:     	movq	%rsi, 0x18(%rsp)
18000ae65:     	pushq	%rdi
18000ae66:     	subq	$0x20, %rsp
18000ae6a:     	cmpl	$0x0, 0x18(%rcx)
18000ae6e:     	movq	%rdx, %rsi
18000ae71:     	movq	%rcx, %rdi
18000ae74:     	jne	0x18000ae86 <numba_list_resize+0x26>
18000ae76:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000ae7b:     	movq	0x40(%rsp), %rsi
18000ae80:     	addq	$0x20, %rsp
18000ae84:     	popq	%rdi
18000ae85:     	retq
18000ae86:     	movq	0x10(%rcx), %rax
18000ae8a:     	cmpq	%rsi, %rax
18000ae8d:     	jl	0x18000aea7 <numba_list_resize+0x47>
18000ae8f:     	sarq	%rax
18000ae92:     	cmpq	%rax, %rsi
18000ae95:     	jl	0x18000aea7 <numba_list_resize+0x47>
18000ae97:     	movq	%rsi, (%rcx)
18000ae9a:     	xorl	%eax, %eax
18000ae9c:     	movq	0x40(%rsp), %rsi
18000aea1:     	addq	$0x20, %rsp
18000aea5:     	popq	%rdi
18000aea6:     	retq
18000aea7:     	cmpq	$0x9, %rsi
18000aeab:     	movq	%rbp, 0x38(%rsp)
18000aeb0:     	movl	$0x3, %ecx
18000aeb5:     	movl	$0x6, %eax
18000aeba:     	cmovll	%ecx, %eax
18000aebd:     	movq	%rsi, %r8
18000aec0:     	movq	0x8(%rdi), %rcx
18000aec4:     	addq	%rsi, %rax
18000aec7:     	sarq	$0x3, %r8
18000aecb:     	xorl	%edx, %edx
18000aecd:     	addq	%rax, %r8
18000aed0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000aeda:     	divq	%rcx
18000aedd:     	cmpq	%rax, %r8
18000aee0:     	ja	0x18000af5b <numba_list_resize+0xfb>
18000aee2:     	xorl	%ebp, %ebp
18000aee4:     	movq	%rbx, 0x30(%rsp)
18000aee9:     	testq	%rsi, %rsi
18000aeec:     	cmovneq	%r8, %rbp
18000aef0:     	movq	%rbp, %rbx
18000aef3:     	imulq	%rcx, %rbx
18000aef7:     	movl	$0x8, %ecx
18000aefc:     	movq	%rbx, %rax
18000aeff:     	cqto
18000af01:     	andl	$0x7, %edx
18000af04:     	addq	%rdx, %rax
18000af07:     	andl	$0x7, %eax
18000af0a:     	subq	%rdx, %rax
18000af0d:     	subq	%rax, %rcx
18000af10:     	movq	%rcx, %rax
18000af13:     	movq	0x30(%rdi), %rcx
18000af17:     	cqto
18000af19:     	andl	$0x7, %edx
18000af1c:     	addq	%rdx, %rax
18000af1f:     	andl	$0x7, %eax
18000af22:     	subq	%rdx, %rax
18000af25:     	leaq	(%rbx,%rax), %rdx
18000af29:     	callq	*0x2141(%rip)           # 0x18000d070
18000af2f:     	testq	%rbx, %rbx
18000af32:     	movq	0x30(%rsp), %rbx
18000af37:     	je	0x18000af3e <numba_list_resize+0xde>
18000af39:     	testq	%rax, %rax
18000af3c:     	je	0x18000af5b <numba_list_resize+0xfb>
18000af3e:     	movq	%rax, 0x30(%rdi)
18000af42:     	xorl	%eax, %eax
18000af44:     	movq	%rbp, 0x10(%rdi)
18000af48:     	movq	0x38(%rsp), %rbp
18000af4d:     	movq	%rsi, (%rdi)
18000af50:     	movq	0x40(%rsp), %rsi
18000af55:     	addq	$0x20, %rsp
18000af59:     	popq	%rdi
18000af5a:     	retq
18000af5b:     	movq	0x38(%rsp), %rbp
18000af60:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000af65:     	movq	0x40(%rsp), %rsi
18000af6a:     	addq	$0x20, %rsp
18000af6e:     	popq	%rdi
18000af6f:     	retq

000000018000af70 <numba_list_delitem>:
18000af70:     	movq	%rbx, 0x10(%rsp)
18000af75:     	pushq	%rdi
18000af76:     	subq	$0x20, %rsp
18000af7a:     	cmpl	$0x0, 0x18(%rcx)
18000af7e:     	movq	%rdx, %rdi
18000af81:     	movq	%rcx, %rbx
18000af84:     	jne	0x18000af96 <numba_list_delitem+0x26>
18000af86:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000af8b:     	movq	0x38(%rsp), %rbx
18000af90:     	addq	$0x20, %rsp
18000af94:     	popq	%rdi
18000af95:     	retq
18000af96:     	cmpq	(%rcx), %rdi
18000af99:     	jb	0x18000afab <numba_list_delitem+0x3b>
18000af9b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000afa0:     	movq	0x38(%rsp), %rbx
18000afa5:     	addq	$0x20, %rsp
18000afa9:     	popq	%rdi
18000afaa:     	retq
18000afab:     	movq	0x28(%rcx), %rax
18000afaf:     	movq	%rsi, 0x30(%rsp)
18000afb4:     	movq	%rdi, %rsi
18000afb7:     	imulq	0x8(%rcx), %rsi
18000afbc:     	addq	0x30(%rcx), %rsi
18000afc0:     	testq	%rax, %rax
18000afc3:     	je	0x18000afca <numba_list_delitem+0x5a>
18000afc5:     	movq	%rsi, %rcx
18000afc8:     	callq	*%rax
18000afca:     	movq	(%rbx), %r8
18000afcd:     	leaq	-0x1(%r8), %rax
18000afd1:     	cmpq	%rax, %rdi
18000afd4:     	je	0x18000aff6 <numba_list_delitem+0x86>
18000afd6:     	subq	%rdi, %r8
18000afd9:     	leaq	0x1(%rdi), %rdx
18000afdd:     	imulq	0x8(%rbx), %rdx
18000afe2:     	decq	%r8
18000afe5:     	movq	%rsi, %rcx
18000afe8:     	imulq	0x8(%rbx), %r8
18000afed:     	addq	0x30(%rbx), %rdx
18000aff1:     	callq	0x18000c129 <numba_list_iter_next+0xec9>
18000aff6:     	movq	(%rbx), %rdx
18000aff9:     	movq	%rbx, %rcx
18000affc:     	decq	%rdx
18000afff:     	callq	0x18000ae60 <numba_list_resize>
18000b004:     	movq	0x30(%rsp), %rsi
18000b009:     	xorl	%ecx, %ecx
18000b00b:     	movq	0x38(%rsp), %rbx
18000b010:     	testl	%eax, %eax
18000b012:     	cmovsl	%eax, %ecx
18000b015:     	movl	%ecx, %eax
18000b017:     	addq	$0x20, %rsp
18000b01b:     	popq	%rdi
18000b01c:     	retq
18000b01d:     	int3
18000b01e:     	int3
18000b01f:     	int3

000000018000b020 <numba_list_delete_slice>:
18000b020:     	pushq	%rbx
18000b022:     	pushq	%rbp
18000b023:     	pushq	%rdi
18000b024:     	pushq	%r15
18000b026:     	subq	$0x38, %rsp
18000b02a:     	cmpl	$0x0, 0x18(%rcx)
18000b02e:     	movq	%r9, %rdi
18000b031:     	movq	%r8, %rbp
18000b034:     	movq	%rdx, %r15
18000b037:     	movq	%rcx, %rbx
18000b03a:     	jne	0x18000b04b <numba_list_delete_slice+0x2b>
18000b03c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b041:     	addq	$0x38, %rsp
18000b045:     	popq	%r15
18000b047:     	popq	%rdi
18000b048:     	popq	%rbp
18000b049:     	popq	%rbx
18000b04a:     	retq
18000b04b:     	movq	%r13, 0x78(%rsp)
18000b050:     	testq	%rdi, %rdi
18000b053:     	jle	0x18000b072 <numba_list_delete_slice+0x52>
18000b055:     	cmpq	%r8, %r15
18000b058:     	jge	0x18000b211 <numba_list_delete_slice+0x1f1>
18000b05e:     	movq	%r8, %rax
18000b061:     	subq	%r15, %rax
18000b064:     	decq	%rax
18000b067:     	cqto
18000b069:     	idivq	%rdi
18000b06c:     	leal	0x1(%rax), %r13d
18000b070:     	jmp	0x18000b092 <numba_list_delete_slice+0x72>
18000b072:     	cmpq	%r15, %r8
18000b075:     	jge	0x18000b211 <numba_list_delete_slice+0x1f1>
18000b07b:     	movq	%r15, %rax
18000b07e:     	movl	$0x1, %r13d
18000b084:     	subq	%r8, %rax
18000b087:     	decq	%rax
18000b08a:     	cqto
18000b08c:     	idivq	%rdi
18000b08f:     	subl	%eax, %r13d
18000b092:     	testl	%r13d, %r13d
18000b095:     	jle	0x18000b211 <numba_list_delete_slice+0x1f1>
18000b09b:     	movq	%rsi, 0x68(%rsp)
18000b0a0:     	movl	(%rcx), %esi
18000b0a2:     	subl	%r13d, %esi
18000b0a5:     	movl	%esi, 0x20(%rsp)
18000b0a9:     	testq	%rdi, %rdi
18000b0ac:     	jns	0x18000b0c7 <numba_list_delete_slice+0xa7>
18000b0ae:     	leaq	0x1(%r15), %rbp
18000b0b2:     	leal	-0x1(%r13), %eax
18000b0b6:     	movslq	%eax, %rcx
18000b0b9:     	leaq	-0x1(%rbp), %r15
18000b0bd:     	imulq	%rdi, %rcx
18000b0c1:     	addq	%rcx, %r15
18000b0c4:     	negq	%rdi
18000b0c7:     	cmpq	$0x1, %rdi
18000b0cb:     	jne	0x18000b117 <numba_list_delete_slice+0xf7>
18000b0cd:     	cmpq	$0x0, 0x28(%rbx)
18000b0d2:     	je	0x18000b0f9 <numba_list_delete_slice+0xd9>
18000b0d4:     	movslq	%r15d, %rdi
18000b0d7:     	cmpq	%rbp, %rdi
18000b0da:     	jge	0x18000b0f9 <numba_list_delete_slice+0xd9>
18000b0dc:     	nopl	(%rax)
18000b0e0:     	movslq	%edi, %rcx
18000b0e3:     	imulq	0x8(%rbx), %rcx
18000b0e8:     	addq	0x30(%rbx), %rcx
18000b0ec:     	callq	*0x28(%rbx)
18000b0ef:     	incl	%edi
18000b0f1:     	movslq	%edi, %rax
18000b0f4:     	cmpq	%rbp, %rax
18000b0f7:     	jl	0x18000b0e0 <numba_list_delete_slice+0xc0>
18000b0f9:     	movq	0x8(%rbx), %rcx
18000b0fd:     	movq	(%rbx), %r8
18000b100:     	movq	%rcx, %rdx
18000b103:     	subq	%rbp, %r8
18000b106:     	imulq	%rcx, %r8
18000b10a:     	imulq	%rbp, %rdx
18000b10e:     	imulq	%r15, %rcx
18000b112:     	jmp	0x18000b1dc <numba_list_delete_slice+0x1bc>
18000b117:     	movq	%r14, 0x30(%rsp)
18000b11c:     	movq	%r15, %r14
18000b11f:     	movl	$0x0, 0x60(%rsp)
18000b127:     	cmpq	%rbp, %r15
18000b12a:     	jge	0x18000b1a9 <numba_list_delete_slice+0x189>
18000b12c:     	movq	%r12, 0x70(%rsp)
18000b131:     	movq	(%rbx), %rax
18000b134:     	leaq	(%r14,%rdi), %r12
18000b138:     	cmpq	%rax, %r12
18000b13b:     	jl	0x18000b148 <numba_list_delete_slice+0x128>
18000b13d:     	movq	%r14, %rsi
18000b140:     	notq	%rsi
18000b143:     	addq	%rax, %rsi
18000b146:     	jmp	0x18000b14c <numba_list_delete_slice+0x12c>
18000b148:     	leaq	-0x1(%rdi), %rsi
18000b14c:     	movq	0x28(%rbx), %rax
18000b150:     	testq	%rax, %rax
18000b153:     	je	0x18000b163 <numba_list_delete_slice+0x143>
18000b155:     	movq	%r14, %rcx
18000b158:     	imulq	0x8(%rbx), %rcx
18000b15d:     	addq	0x30(%rbx), %rcx
18000b161:     	callq	*%rax
18000b163:     	movq	0x8(%rbx), %r9
18000b167:     	leaq	0x1(%r14), %rdx
18000b16b:     	movq	0x30(%rbx), %r10
18000b16f:     	movq	%r9, %r8
18000b172:     	imulq	%rsi, %r8
18000b176:     	imulq	%r9, %rdx
18000b17a:     	movslq	0x60(%rsp), %rsi
18000b17f:     	subq	%rsi, %r14
18000b182:     	imulq	%r9, %r14
18000b186:     	addq	%r10, %rdx
18000b189:     	leaq	(%r10,%r14), %rcx
18000b18d:     	callq	0x18000c129 <numba_list_iter_next+0xec9>
18000b192:     	incl	%esi
18000b194:     	movq	%r12, %r14
18000b197:     	movl	%esi, 0x60(%rsp)
18000b19b:     	cmpq	%rbp, %r12
18000b19e:     	jl	0x18000b131 <numba_list_delete_slice+0x111>
18000b1a0:     	movq	0x70(%rsp), %r12
18000b1a5:     	movl	0x20(%rsp), %esi
18000b1a9:     	movq	(%rbx), %r8
18000b1ac:     	movq	0x30(%rsp), %r14
18000b1b1:     	movslq	%r13d, %r10
18000b1b4:     	movq	%r10, %rcx
18000b1b7:     	imulq	%rdi, %rcx
18000b1bb:     	addq	%r15, %rcx
18000b1be:     	cmpq	%r8, %rcx
18000b1c1:     	jge	0x18000b1e9 <numba_list_delete_slice+0x1c9>
18000b1c3:     	movq	0x8(%rbx), %rax
18000b1c7:     	subq	%rcx, %r8
18000b1ca:     	movq	%rax, %rdx
18000b1cd:     	imulq	%rcx, %rdx
18000b1d1:     	imulq	%rax, %r8
18000b1d5:     	subq	%r10, %rcx
18000b1d8:     	imulq	%rax, %rcx
18000b1dc:     	addq	0x30(%rbx), %rdx
18000b1e0:     	addq	0x30(%rbx), %rcx
18000b1e4:     	callq	0x18000c129 <numba_list_iter_next+0xec9>
18000b1e9:     	movslq	%esi, %rdx
18000b1ec:     	movq	%rbx, %rcx
18000b1ef:     	callq	0x18000ae60 <numba_list_resize>
18000b1f4:     	movq	0x68(%rsp), %rsi
18000b1f9:     	xorl	%ecx, %ecx
18000b1fb:     	movq	0x78(%rsp), %r13
18000b200:     	testl	%eax, %eax
18000b202:     	cmovsl	%eax, %ecx
18000b205:     	movl	%ecx, %eax
18000b207:     	addq	$0x38, %rsp
18000b20b:     	popq	%r15
18000b20d:     	popq	%rdi
18000b20e:     	popq	%rbp
18000b20f:     	popq	%rbx
18000b210:     	retq
18000b211:     	movq	0x78(%rsp), %r13
18000b216:     	xorl	%eax, %eax
18000b218:     	addq	$0x38, %rsp
18000b21c:     	popq	%r15
18000b21e:     	popq	%rdi
18000b21f:     	popq	%rbp
18000b220:     	popq	%rbx
18000b221:     	retq
18000b222:     	int3
18000b223:     	int3
18000b224:     	int3
18000b225:     	int3
18000b226:     	int3
18000b227:     	int3
18000b228:     	int3
18000b229:     	int3
18000b22a:     	int3
18000b22b:     	int3
18000b22c:     	int3
18000b22d:     	int3
18000b22e:     	int3
18000b22f:     	int3

000000018000b230 <numba_list_iter_sizeof>:
18000b230:     	movl	$0x18, %eax
18000b235:     	retq
18000b236:     	int3
18000b237:     	int3
18000b238:     	int3
18000b239:     	int3
18000b23a:     	int3
18000b23b:     	int3
18000b23c:     	int3
18000b23d:     	int3
18000b23e:     	int3
18000b23f:     	int3

000000018000b240 <numba_list_iter>:
18000b240:     	movq	%rdx, (%rcx)
18000b243:     	movq	(%rdx), %rax
18000b246:     	movq	%rax, 0x8(%rcx)
18000b24a:     	movq	$0x0, 0x10(%rcx)
18000b252:     	retq
18000b253:     	int3
18000b254:     	int3
18000b255:     	int3
18000b256:     	int3
18000b257:     	int3
18000b258:     	int3
18000b259:     	int3
18000b25a:     	int3
18000b25b:     	int3
18000b25c:     	int3
18000b25d:     	int3
18000b25e:     	int3
18000b25f:     	int3

000000018000b260 <numba_list_iter_next>:
18000b260:     	movq	(%rcx), %r8
18000b263:     	movq	(%r8), %r9
18000b266:     	cmpq	0x8(%rcx), %r9
18000b26a:     	je	0x18000b272 <numba_list_iter_next+0x12>
18000b26c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
18000b271:     	retq
18000b272:     	movq	0x10(%rcx), %rax
18000b276:     	cmpq	%r9, %rax
18000b279:     	jge	0x18000b28e <numba_list_iter_next+0x2e>
18000b27b:     	imulq	0x8(%r8), %rax
18000b280:     	addq	0x30(%r8), %rax
18000b284:     	movq	%rax, (%rdx)
18000b287:     	incq	0x10(%rcx)
18000b28b:     	xorl	%eax, %eax
18000b28d:     	retq
18000b28e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
18000b293:     	retq
18000b294:     	int3
18000b295:     	int3
18000b296:     	int3
18000b297:     	int3
18000b298:     	int3
18000b299:     	int3
18000b29a:     	int3
18000b29b:     	int3
18000b29c:     	int3
18000b29d:     	int3
18000b29e:     	int3
18000b29f:     	int3
18000b2a0:     	pushq	%rbx
18000b2a2:     	subq	$0x20, %rsp
18000b2a6:     	movq	%rcx, %rbx
18000b2a9:     	addq	$0x30, %rcx
18000b2ad:     	callq	*0x99b5(%rip)           # 0x180014c68
18000b2b3:     	cmpb	$0x0, 0x9986(%rip)      # 0x180014c40
18000b2ba:     	je	0x18000b2c4 <numba_list_iter_next+0x64>
18000b2bc:     	lock
18000b2bd:     	incq	0x9984(%rip)            # 0x180014c48
18000b2c4:     	testq	%rax, %rax
18000b2c7:     	je	0x18000b308 <numba_list_iter_next+0xa8>
18000b2c9:     	leaq	0x30(%rax), %rdx
18000b2cd:     	testq	%rdx, %rdx
18000b2d0:     	je	0x18000b308 <numba_list_iter_next+0xa8>
18000b2d2:     	xorl	%r8d, %r8d
18000b2d5:     	movl	$0x1, %ecx
18000b2da:     	xchgq	%rcx, (%rax)
18000b2dd:     	movq	%r8, 0x8(%rax)
18000b2e1:     	movq	%r8, 0x10(%rax)
18000b2e5:     	movq	%rdx, 0x18(%rax)
18000b2e9:     	movq	%rbx, 0x20(%rax)
18000b2ed:     	movq	%r8, 0x28(%rax)
18000b2f1:     	cmpb	%r8b, 0x9948(%rip)      # 0x180014c40
18000b2f8:     	je	0x18000b30a <numba_list_iter_next+0xaa>
18000b2fa:     	lock
18000b2fb:     	incq	0x9956(%rip)            # 0x180014c58
18000b302:     	addq	$0x20, %rsp
18000b306:     	popq	%rbx
18000b307:     	retq
18000b308:     	xorl	%eax, %eax
18000b30a:     	addq	$0x20, %rsp
18000b30e:     	popq	%rbx
18000b30f:     	retq
18000b310:     	movq	%rbx, 0x8(%rsp)
18000b315:     	pushq	%rdi
18000b316:     	subq	$0x20, %rsp
18000b31a:     	movq	%rcx, %rdi
18000b31d:     	movq	%rdx, %rbx
18000b320:     	addq	$0x30, %rcx
18000b324:     	testq	%rdx, %rdx
18000b327:     	je	0x18000b331 <numba_list_iter_next+0xd1>
18000b329:     	movq	0x18(%rdx), %rdx
18000b32d:     	callq	*(%rbx)
18000b32f:     	jmp	0x18000b337 <numba_list_iter_next+0xd7>
18000b331:     	callq	*0x9931(%rip)           # 0x180014c68
18000b337:     	cmpb	$0x0, 0x9902(%rip)      # 0x180014c40
18000b33e:     	movq	%rax, %r8
18000b341:     	je	0x18000b34b <numba_list_iter_next+0xeb>
18000b343:     	lock
18000b344:     	incq	0x98fd(%rip)            # 0x180014c48
18000b34b:     	xorl	%edx, %edx
18000b34d:     	leaq	0x30(%r8), %rax
18000b351:     	testq	%r8, %r8
18000b354:     	movl	%edx, %ecx
18000b356:     	cmovneq	%rax, %rcx
18000b35a:     	testq	%rcx, %rcx
18000b35d:     	jne	0x18000b36c <numba_list_iter_next+0x10c>
18000b35f:     	xorl	%eax, %eax
18000b361:     	movq	0x30(%rsp), %rbx
18000b366:     	addq	$0x20, %rsp
18000b36a:     	popq	%rdi
18000b36b:     	retq
18000b36c:     	movl	$0x1, %eax
18000b371:     	xchgq	%rax, (%r8)
18000b374:     	movq	%rdx, 0x8(%r8)
18000b378:     	movq	%rdx, 0x10(%r8)
18000b37c:     	movq	%rcx, 0x18(%r8)
18000b380:     	movq	%rdi, 0x20(%r8)
18000b384:     	movq	%rbx, 0x28(%r8)
18000b388:     	cmpb	%dl, 0x98b2(%rip)       # 0x180014c40
18000b38e:     	je	0x18000b398 <numba_list_iter_next+0x138>
18000b390:     	lock
18000b391:     	incq	0x98c0(%rip)            # 0x180014c58
18000b398:     	movq	0x30(%rsp), %rbx
18000b39d:     	movq	%r8, %rax
18000b3a0:     	addq	$0x20, %rsp
18000b3a4:     	popq	%rdi
18000b3a5:     	retq
18000b3a6:     	int3
18000b3a7:     	int3
18000b3a8:     	int3
18000b3a9:     	int3
18000b3aa:     	int3
18000b3ab:     	int3
18000b3ac:     	int3
18000b3ad:     	int3
18000b3ae:     	int3
18000b3af:     	int3
18000b3b0:     	lock
18000b3b1:     	incq	(%rcx)
18000b3b4:     	retq
18000b3b5:     	int3
18000b3b6:     	int3
18000b3b7:     	int3
18000b3b8:     	int3
18000b3b9:     	int3
18000b3ba:     	int3
18000b3bb:     	int3
18000b3bc:     	int3
18000b3bd:     	int3
18000b3be:     	int3
18000b3bf:     	int3
18000b3c0:     	pushq	%rbx
18000b3c2:     	subq	$0x20, %rsp
18000b3c6:     	movq	0x8(%rcx), %rax
18000b3ca:     	movq	%rcx, %rbx
18000b3cd:     	testq	%rax, %rax
18000b3d0:     	je	0x18000b3e9 <numba_list_iter_next+0x189>
18000b3d2:     	cmpl	$0x0, 0x985f(%rip)      # 0x180014c38
18000b3d9:     	jne	0x18000b3e9 <numba_list_iter_next+0x189>
18000b3db:     	movq	0x10(%rcx), %r8
18000b3df:     	movq	0x20(%rcx), %rdx
18000b3e3:     	movq	0x18(%rcx), %rcx
18000b3e7:     	callq	*%rax
18000b3e9:     	movq	0x28(%rbx), %rax
18000b3ed:     	movq	%rbx, %rcx
18000b3f0:     	testq	%rax, %rax
18000b3f3:     	je	0x18000b3fe <numba_list_iter_next+0x19e>
18000b3f5:     	movq	0x18(%rax), %rdx
18000b3f9:     	callq	*0x10(%rax)
18000b3fc:     	jmp	0x18000b404 <numba_list_iter_next+0x1a4>
18000b3fe:     	callq	*0x9874(%rip)           # 0x180014c78
18000b404:     	cmpb	$0x0, 0x9835(%rip)      # 0x180014c40
18000b40b:     	je	0x18000b429 <numba_list_iter_next+0x1c9>
18000b40d:     	leaq	0x983c(%rip), %rax      # 0x180014c50
18000b414:     	lock
18000b415:     	incq	(%rax)
18000b418:     	cmpb	$0x0, 0x9821(%rip)      # 0x180014c40
18000b41f:     	je	0x18000b429 <numba_list_iter_next+0x1c9>
18000b421:     	lock
18000b422:     	incq	0x9837(%rip)            # 0x180014c60
18000b429:     	addq	$0x20, %rsp
18000b42d:     	popq	%rbx
18000b42e:     	retq
18000b42f:     	int3
18000b430:     	pushq	%rbx
18000b432:     	subq	$0x20, %rsp
18000b436:     	movq	%rcx, %rbx
18000b439:     	movq	$-0x1, %rax
18000b440:     	lock
18000b441:     	xaddq	%rax, (%rcx)
18000b445:     	cmpq	$0x1, %rax
18000b449:     	jne	0x18000b4ab <numba_list_iter_next+0x24b>
18000b44b:     	movq	0x8(%rcx), %rax
18000b44f:     	testq	%rax, %rax
18000b452:     	je	0x18000b46b <numba_list_iter_next+0x20b>
18000b454:     	cmpl	$0x0, 0x97dd(%rip)      # 0x180014c38
18000b45b:     	jne	0x18000b46b <numba_list_iter_next+0x20b>
18000b45d:     	movq	0x10(%rcx), %r8
18000b461:     	movq	0x20(%rcx), %rdx
18000b465:     	movq	0x18(%rcx), %rcx
18000b469:     	callq	*%rax
18000b46b:     	movq	0x28(%rbx), %rax
18000b46f:     	movq	%rbx, %rcx
18000b472:     	testq	%rax, %rax
18000b475:     	je	0x18000b480 <numba_list_iter_next+0x220>
18000b477:     	movq	0x18(%rax), %rdx
18000b47b:     	callq	*0x10(%rax)
18000b47e:     	jmp	0x18000b486 <numba_list_iter_next+0x226>
18000b480:     	callq	*0x97f2(%rip)           # 0x180014c78
18000b486:     	cmpb	$0x0, 0x97b3(%rip)      # 0x180014c40
18000b48d:     	je	0x18000b4ab <numba_list_iter_next+0x24b>
18000b48f:     	leaq	0x97ba(%rip), %rax      # 0x180014c50
18000b496:     	lock
18000b497:     	incq	(%rax)
18000b49a:     	cmpb	$0x0, 0x979f(%rip)      # 0x180014c40
18000b4a1:     	je	0x18000b4ab <numba_list_iter_next+0x24b>
18000b4a3:     	lock
18000b4a4:     	incq	0x97b5(%rip)            # 0x180014c60
18000b4ab:     	addq	$0x20, %rsp
18000b4af:     	popq	%rbx
18000b4b0:     	retq
18000b4b1:     	int3
18000b4b2:     	int3
18000b4b3:     	int3
18000b4b4:     	int3
18000b4b5:     	int3
18000b4b6:     	int3
18000b4b7:     	int3
18000b4b8:     	int3
18000b4b9:     	int3
18000b4ba:     	int3
18000b4bb:     	int3
18000b4bc:     	int3
18000b4bd:     	int3
18000b4be:     	int3
18000b4bf:     	int3
18000b4c0:     	movq	0x18(%rcx), %rax
18000b4c4:     	retq
18000b4c5:     	int3
18000b4c6:     	int3
18000b4c7:     	int3
18000b4c8:     	int3
18000b4c9:     	int3
18000b4ca:     	int3
18000b4cb:     	int3
18000b4cc:     	int3
18000b4cd:     	int3
18000b4ce:     	int3
18000b4cf:     	int3
18000b4d0:     	subq	$0x28, %rsp
18000b4d4:     	callq	*0x979e(%rip)           # 0x180014c78
18000b4da:     	cmpb	$0x0, 0x975f(%rip)      # 0x180014c40
18000b4e1:     	je	0x18000b4eb <numba_list_iter_next+0x28b>
18000b4e3:     	lock
18000b4e4:     	incq	0x9765(%rip)            # 0x180014c50
18000b4eb:     	addq	$0x28, %rsp
18000b4ef:     	retq
18000b4f0:     	jmpq	*%r8
18000b4f3:     	int3
18000b4f4:     	int3
18000b4f5:     	int3
18000b4f6:     	int3
18000b4f7:     	int3
18000b4f8:     	int3
18000b4f9:     	int3
18000b4fa:     	int3
18000b4fb:     	int3
18000b4fc:     	int3
18000b4fd:     	int3
18000b4fe:     	int3
18000b4ff:     	int3
18000b500:     	movq	%rbx, 0x8(%rsp)
18000b505:     	pushq	%rdi
18000b506:     	subq	$0x20, %rsp
18000b50a:     	movq	%rcx, %rdi
18000b50d:     	movq	%rdx, %rbx
18000b510:     	movl	$0x30, %ecx
18000b515:     	callq	*0x974d(%rip)           # 0x180014c68
18000b51b:     	cmpb	$0x0, 0x971e(%rip)      # 0x180014c40
18000b522:     	je	0x18000b52c <numba_list_iter_next+0x2cc>
18000b524:     	lock
18000b525:     	incq	0x971c(%rip)            # 0x180014c48
18000b52c:     	testq	%rax, %rax
18000b52f:     	je	0x18000b566 <numba_list_iter_next+0x306>
18000b531:     	leaq	-0x48(%rip), %rcx       # 0x18000b4f0 <numba_list_iter_next+0x290>
18000b538:     	movl	$0x1, %edx
18000b53d:     	xchgq	%rdx, (%rax)
18000b540:     	movq	%rcx, 0x8(%rax)
18000b544:     	xorl	%ecx, %ecx
18000b546:     	movq	%rcx, 0x20(%rax)
18000b54a:     	movq	%rcx, 0x28(%rax)
18000b54e:     	movq	%rbx, 0x10(%rax)
18000b552:     	movq	%rdi, 0x18(%rax)
18000b556:     	cmpb	%cl, 0x96e4(%rip)       # 0x180014c40
18000b55c:     	je	0x18000b566 <numba_list_iter_next+0x306>
18000b55e:     	lock
18000b55f:     	incq	0x96f2(%rip)            # 0x180014c58
18000b566:     	movq	0x30(%rsp), %rbx
18000b56b:     	addq	$0x20, %rsp
18000b56f:     	popq	%rdi
18000b570:     	retq
18000b571:     	jmpq	*0x1d99(%rip)           # 0x18000d310
18000b577:     	jmpq	*0x1d83(%rip)           # 0x18000d300
18000b57d:     	jmpq	*0x1d75(%rip)           # 0x18000d2f8
18000b583:     	jmpq	*0x1d67(%rip)           # 0x18000d2f0
18000b589:     	jmpq	*0x1d59(%rip)           # 0x18000d2e8
18000b58f:     	jmpq	*0x1d4b(%rip)           # 0x18000d2e0
18000b595:     	jmpq	*0x1d3d(%rip)           # 0x18000d2d8
18000b59b:     	jmpq	*0x1d27(%rip)           # 0x18000d2c8
18000b5a1:     	jmpq	*0x1d19(%rip)           # 0x18000d2c0
18000b5a7:     	jmpq	*0x1d0b(%rip)           # 0x18000d2b8
18000b5ad:     	jmpq	*0x1cf5(%rip)           # 0x18000d2a8
18000b5b3:     	jmpq	*0x1ccf(%rip)           # 0x18000d288
18000b5b9:     	jmpq	*0x1cc1(%rip)           # 0x18000d280
18000b5bf:     	jmpq	*0x1cb3(%rip)           # 0x18000d278
18000b5c5:     	jmpq	*0x1ca5(%rip)           # 0x18000d270
18000b5cb:     	jmpq	*0x1c5f(%rip)           # 0x18000d230
18000b5d1:     	int3
18000b5d2:     	int3
18000b5d3:     	int3
18000b5d4:     	int3
18000b5d5:     	int3
18000b5d6:     	int3
18000b5d7:     	int3
18000b5d8:     	int3
18000b5d9:     	int3
18000b5da:     	int3
18000b5db:     	int3
18000b5dc:     	int3
18000b5dd:     	int3
18000b5de:     	int3
18000b5df:     	int3
18000b5e0:     	int3
18000b5e1:     	int3
18000b5e2:     	int3
18000b5e3:     	int3
18000b5e4:     	int3
18000b5e5:     	int3
18000b5e6:     	nopw	(%rax,%rax)
18000b5f0:     	cmpq	0x8b09(%rip), %rcx      # 0x180014100
18000b5f7:     	jne	0x18000b609 <numba_list_iter_next+0x3a9>
18000b5f9:     	rolq	$0x10, %rcx
18000b5fd:     	testw	$0xffff, %cx            # imm = 0xFFFF
18000b602:     	jne	0x18000b605 <numba_list_iter_next+0x3a5>
18000b604:     	retq
18000b605:     	rorq	$0x10, %rcx
18000b609:     	jmp	0x18000b964 <numba_list_iter_next+0x704>
18000b60e:     	int3
18000b60f:     	int3
18000b610:     	subq	$0x28, %rsp
18000b614:     	testl	%edx, %edx
18000b616:     	je	0x18000b651 <numba_list_iter_next+0x3f1>
18000b618:     	subl	$0x1, %edx
18000b61b:     	je	0x18000b645 <numba_list_iter_next+0x3e5>
18000b61d:     	subl	$0x1, %edx
18000b620:     	je	0x18000b638 <numba_list_iter_next+0x3d8>
18000b622:     	cmpl	$0x1, %edx
18000b625:     	je	0x18000b631 <numba_list_iter_next+0x3d1>
18000b627:     	movl	$0x1, %eax
18000b62c:     	addq	$0x28, %rsp
18000b630:     	retq
18000b631:     	callq	0x18000bb30 <numba_list_iter_next+0x8d0>
18000b636:     	jmp	0x18000b63d <numba_list_iter_next+0x3dd>
18000b638:     	callq	0x18000bb08 <numba_list_iter_next+0x8a8>
18000b63d:     	movzbl	%al, %eax
18000b640:     	addq	$0x28, %rsp
18000b644:     	retq
18000b645:     	movq	%r8, %rdx
18000b648:     	addq	$0x28, %rsp
18000b64c:     	jmp	0x18000b660 <numba_list_iter_next+0x400>
18000b651:     	testq	%r8, %r8
18000b654:     	setne	%cl
18000b657:     	addq	$0x28, %rsp
18000b65b:     	jmp	0x18000b778 <numba_list_iter_next+0x518>
18000b660:     	movq	%rbx, 0x8(%rsp)
18000b665:     	movq	%rsi, 0x10(%rsp)
18000b66a:     	movq	%rdi, 0x20(%rsp)
18000b66f:     	pushq	%r14
18000b671:     	subq	$0x20, %rsp
18000b675:     	movq	%rdx, %rsi
18000b678:     	movq	%rcx, %r14
18000b67b:     	xorl	%ecx, %ecx
18000b67d:     	callq	0x18000bbec <numba_list_iter_next+0x98c>
18000b682:     	testb	%al, %al
18000b684:     	je	0x18000b752 <numba_list_iter_next+0x4f2>
18000b68a:     	callq	0x18000ba80 <numba_list_iter_next+0x820>
18000b68f:     	movb	%al, %bl
18000b691:     	movb	%al, 0x40(%rsp)
18000b695:     	movb	$0x1, %dil
18000b698:     	cmpl	$0x0, 0x9369(%rip)      # 0x180014a08
18000b69f:     	jne	0x18000b76a <numba_list_iter_next+0x50a>
18000b6a5:     	movl	$0x1, 0x9359(%rip)      # 0x180014a08
18000b6af:     	callq	0x18000baf0 <numba_list_iter_next+0x890>
18000b6b4:     	testb	%al, %al
18000b6b6:     	je	0x18000b707 <numba_list_iter_next+0x4a7>
18000b6b8:     	callq	0x18000bdac <numba_list_iter_next+0xb4c>
18000b6bd:     	callq	0x18000ba40 <numba_list_iter_next+0x7e0>
18000b6c2:     	callq	0x18000ba64 <numba_list_iter_next+0x804>
18000b6c7:     	leaq	0x1ca2(%rip), %rdx      # 0x18000d370
18000b6ce:     	leaq	0x1c93(%rip), %rcx      # 0x18000d368
18000b6d5:     	callq	0x18000c0f2 <numba_list_iter_next+0xe92>
18000b6da:     	testl	%eax, %eax
18000b6dc:     	jne	0x18000b707 <numba_list_iter_next+0x4a7>
18000b6de:     	callq	0x18000babc <numba_list_iter_next+0x85c>
18000b6e3:     	testb	%al, %al
18000b6e5:     	je	0x18000b707 <numba_list_iter_next+0x4a7>
18000b6e7:     	leaq	0x1c72(%rip), %rdx      # 0x18000d360
18000b6ee:     	leaq	0x1c63(%rip), %rcx      # 0x18000d358
18000b6f5:     	callq	0x18000c0ec <numba_list_iter_next+0xe8c>
18000b6fa:     	movl	$0x2, 0x9304(%rip)      # 0x180014a08
18000b704:     	xorb	%dil, %dil
18000b707:     	movb	%bl, %cl
18000b709:     	callq	0x18000bd4c <numba_list_iter_next+0xaec>
18000b70e:     	testb	%dil, %dil
18000b711:     	jne	0x18000b752 <numba_list_iter_next+0x4f2>
18000b713:     	callq	0x18000bd9c <numba_list_iter_next+0xb3c>
18000b718:     	movq	%rax, %rbx
18000b71b:     	cmpq	$0x0, (%rax)
18000b71f:     	je	0x18000b745 <numba_list_iter_next+0x4e5>
18000b721:     	movq	%rax, %rcx
18000b724:     	callq	0x18000bcb4 <numba_list_iter_next+0xa54>
18000b729:     	testb	%al, %al
18000b72b:     	je	0x18000b745 <numba_list_iter_next+0x4e5>
18000b72d:     	movq	%rsi, %r8
18000b730:     	movl	$0x2, %edx
18000b735:     	movq	%r14, %rcx
18000b738:     	movq	(%rbx), %rax
18000b73b:     	movq	0x1bee(%rip), %r9       # 0x18000d330
18000b742:     	callq	*%r9
18000b745:     	incl	0x9295(%rip)            # 0x1800149e0
18000b74b:     	movl	$0x1, %eax
18000b750:     	jmp	0x18000b754 <numba_list_iter_next+0x4f4>
18000b752:     	xorl	%eax, %eax
18000b754:     	movq	0x30(%rsp), %rbx
18000b759:     	movq	0x38(%rsp), %rsi
18000b75e:     	movq	0x48(%rsp), %rdi
18000b763:     	addq	$0x20, %rsp
18000b767:     	popq	%r14
18000b769:     	retq
18000b76a:     	movl	$0x7, %ecx
18000b76f:     	callq	0x18000bda4 <numba_list_iter_next+0xb44>
18000b774:     	nop
18000b775:     	int3
18000b776:     	int3
18000b777:     	int3
18000b778:     	movq	%rbx, 0x8(%rsp)
18000b77d:     	pushq	%rdi
18000b77e:     	subq	$0x30, %rsp
18000b782:     	movb	%cl, %dil
18000b785:     	movl	0x9255(%rip), %eax      # 0x1800149e0
18000b78b:     	testl	%eax, %eax
18000b78d:     	jg	0x18000b79c <numba_list_iter_next+0x53c>
18000b78f:     	xorl	%eax, %eax
18000b791:     	movq	0x40(%rsp), %rbx
18000b796:     	addq	$0x30, %rsp
18000b79a:     	popq	%rdi
18000b79b:     	retq
18000b79c:     	decl	%eax
18000b79e:     	movl	%eax, 0x923c(%rip)      # 0x1800149e0
18000b7a4:     	callq	0x18000ba80 <numba_list_iter_next+0x820>
18000b7a9:     	movb	%al, %bl
18000b7ab:     	movb	%al, 0x20(%rsp)
18000b7af:     	cmpl	$0x2, 0x9252(%rip)      # 0x180014a08
18000b7b6:     	jne	0x18000b7ee <numba_list_iter_next+0x58e>
18000b7b8:     	callq	0x18000bba8 <numba_list_iter_next+0x948>
18000b7bd:     	callq	0x18000ba50 <numba_list_iter_next+0x7f0>
18000b7c2:     	callq	0x18000bde8 <numba_list_iter_next+0xb88>
18000b7c7:     	movl	$0x0, 0x9237(%rip)      # 0x180014a08
18000b7d1:     	movb	%bl, %cl
18000b7d3:     	callq	0x18000bd4c <numba_list_iter_next+0xaec>
18000b7d8:     	xorl	%edx, %edx
18000b7da:     	movb	%dil, %cl
18000b7dd:     	callq	0x18000bd70 <numba_list_iter_next+0xb10>
18000b7e2:     	movzbl	%al, %ebx
18000b7e5:     	callq	0x18000bbd8 <numba_list_iter_next+0x978>
18000b7ea:     	movl	%ebx, %eax
18000b7ec:     	jmp	0x18000b791 <numba_list_iter_next+0x531>
18000b7ee:     	movl	$0x7, %ecx
18000b7f3:     	callq	0x18000bda4 <numba_list_iter_next+0xb44>
18000b7f8:     	nop
18000b7f9:     	nop
18000b7fa:     	int3
18000b7fb:     	int3
18000b7fc:     	movq	%rsp, %rax
18000b7ff:     	movq	%rbx, 0x20(%rax)
18000b803:     	movq	%r8, 0x18(%rax)
18000b807:     	movl	%edx, 0x10(%rax)
18000b80a:     	movq	%rcx, 0x8(%rax)
18000b80e:     	pushq	%rsi
18000b80f:     	pushq	%rdi
18000b810:     	pushq	%r14
18000b812:     	subq	$0x40, %rsp
18000b816:     	movq	%r8, %rsi
18000b819:     	movl	%edx, %edi
18000b81b:     	movq	%rcx, %r14
18000b81e:     	testl	%edx, %edx
18000b820:     	jne	0x18000b831 <numba_list_iter_next+0x5d1>
18000b822:     	cmpl	%edx, 0x91b8(%rip)      # 0x1800149e0
18000b828:     	jg	0x18000b831 <numba_list_iter_next+0x5d1>
18000b82a:     	xorl	%eax, %eax
18000b82c:     	jmp	0x18000b916 <numba_list_iter_next+0x6b6>
18000b831:     	leal	-0x1(%rdx), %eax
18000b834:     	cmpl	$0x1, %eax
18000b837:     	ja	0x18000b879 <numba_list_iter_next+0x619>
18000b839:     	movq	0x22e8(%rip), %rax      # 0x18000db28
18000b840:     	testq	%rax, %rax
18000b843:     	jne	0x18000b84a <numba_list_iter_next+0x5ea>
18000b845:     	leal	0x1(%rax), %ebx
18000b848:     	jmp	0x18000b852 <numba_list_iter_next+0x5f2>
18000b84a:     	callq	*0x1ae0(%rip)           # 0x18000d330
18000b850:     	movl	%eax, %ebx
18000b852:     	movl	%ebx, 0x30(%rsp)
18000b856:     	testl	%ebx, %ebx
18000b858:     	je	0x18000b90c <numba_list_iter_next+0x6ac>
18000b85e:     	movq	%rsi, %r8
18000b861:     	movl	%edi, %edx
18000b863:     	movq	%r14, %rcx
18000b866:     	callq	0x18000b610 <numba_list_iter_next+0x3b0>
18000b86b:     	movl	%eax, %ebx
18000b86d:     	movl	%eax, 0x30(%rsp)
18000b871:     	testl	%eax, %eax
18000b873:     	je	0x18000b90c <numba_list_iter_next+0x6ac>
18000b879:     	movq	%rsi, %r8
18000b87c:     	movl	%edi, %edx
18000b87e:     	movq	%r14, %rcx
18000b881:     	callq	0x18000ba1c <numba_list_iter_next+0x7bc>
18000b886:     	movl	%eax, %ebx
18000b888:     	movl	%eax, 0x30(%rsp)
18000b88c:     	cmpl	$0x1, %edi
18000b88f:     	jne	0x18000b8c7 <numba_list_iter_next+0x667>
18000b891:     	testl	%eax, %eax
18000b893:     	jne	0x18000b8c7 <numba_list_iter_next+0x667>
18000b895:     	movq	%rsi, %r8
18000b898:     	xorl	%edx, %edx
18000b89a:     	movq	%r14, %rcx
18000b89d:     	callq	0x18000ba1c <numba_list_iter_next+0x7bc>
18000b8a2:     	testq	%rsi, %rsi
18000b8a5:     	setne	%cl
18000b8a8:     	callq	0x18000b778 <numba_list_iter_next+0x518>
18000b8ad:     	movq	0x2274(%rip), %rax      # 0x18000db28
18000b8b4:     	testq	%rax, %rax
18000b8b7:     	je	0x18000b8c7 <numba_list_iter_next+0x667>
18000b8b9:     	movq	%rsi, %r8
18000b8bc:     	xorl	%edx, %edx
18000b8be:     	movq	%r14, %rcx
18000b8c1:     	callq	*0x1a69(%rip)           # 0x18000d330
18000b8c7:     	testl	%edi, %edi
18000b8c9:     	je	0x18000b8d0 <numba_list_iter_next+0x670>
18000b8cb:     	cmpl	$0x3, %edi
18000b8ce:     	jne	0x18000b90c <numba_list_iter_next+0x6ac>
18000b8d0:     	movq	%rsi, %r8
18000b8d3:     	movl	%edi, %edx
18000b8d5:     	movq	%r14, %rcx
18000b8d8:     	callq	0x18000b610 <numba_list_iter_next+0x3b0>
18000b8dd:     	movl	%eax, %ebx
18000b8df:     	movl	%eax, 0x30(%rsp)
18000b8e3:     	testl	%eax, %eax
18000b8e5:     	je	0x18000b90c <numba_list_iter_next+0x6ac>
18000b8e7:     	movq	0x223a(%rip), %rax      # 0x18000db28
18000b8ee:     	testq	%rax, %rax
18000b8f1:     	jne	0x18000b8f8 <numba_list_iter_next+0x698>
18000b8f3:     	leal	0x1(%rax), %ebx
18000b8f6:     	jmp	0x18000b908 <numba_list_iter_next+0x6a8>
18000b8f8:     	movq	%rsi, %r8
18000b8fb:     	movl	%edi, %edx
18000b8fd:     	movq	%r14, %rcx
18000b900:     	callq	*0x1a2a(%rip)           # 0x18000d330
18000b906:     	movl	%eax, %ebx
18000b908:     	movl	%ebx, 0x30(%rsp)
18000b90c:     	jmp	0x18000b914 <numba_list_iter_next+0x6b4>
18000b90e:     	xorl	%ebx, %ebx
18000b910:     	movl	%ebx, 0x30(%rsp)
18000b914:     	movl	%ebx, %eax
18000b916:     	movq	0x78(%rsp), %rbx
18000b91b:     	addq	$0x40, %rsp
18000b91f:     	popq	%r14
18000b921:     	popq	%rdi
18000b922:     	popq	%rsi
18000b923:     	retq
18000b924:     	movq	%rbx, 0x8(%rsp)
18000b929:     	movq	%rsi, 0x10(%rsp)
18000b92e:     	pushq	%rdi
18000b92f:     	subq	$0x20, %rsp
18000b933:     	movq	%r8, %rdi
18000b936:     	movl	%edx, %ebx
18000b938:     	movq	%rcx, %rsi
18000b93b:     	cmpl	$0x1, %edx
18000b93e:     	jne	0x18000b945 <numba_list_iter_next+0x6e5>
18000b940:     	callq	0x18000b96c <numba_list_iter_next+0x70c>
18000b945:     	movq	%rdi, %r8
18000b948:     	movl	%ebx, %edx
18000b94a:     	movq	%rsi, %rcx
18000b94d:     	movq	0x30(%rsp), %rbx
18000b952:     	movq	0x38(%rsp), %rsi
18000b957:     	addq	$0x20, %rsp
18000b95b:     	popq	%rdi
18000b95c:     	jmp	0x18000b7fc <numba_list_iter_next+0x59c>
18000b961:     	int3
18000b962:     	int3
18000b963:     	int3
18000b964:     	movl	$0x2, %ecx
18000b969:     	int	$0x29
18000b96b:     	retq
18000b96c:     	movq	%rbx, 0x18(%rsp)
18000b971:     	pushq	%rbp
18000b972:     	movq	%rsp, %rbp
18000b975:     	subq	$0x30, %rsp
18000b979:     	movq	0x8780(%rip), %rax      # 0x180014100
18000b980:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000b98a:     	cmpq	%rbx, %rax
18000b98d:     	jne	0x18000ba06 <numba_list_iter_next+0x7a6>
18000b98f:     	leaq	0x10(%rbp), %rcx
18000b993:     	movq	$0x0, 0x10(%rbp)
18000b99b:     	callq	*0x167f(%rip)           # 0x18000d020
18000b9a1:     	movq	0x10(%rbp), %rax
18000b9a5:     	movq	%rax, -0x10(%rbp)
18000b9a9:     	callq	*0x1669(%rip)           # 0x18000d018
18000b9af:     	movl	%eax, %eax
18000b9b1:     	xorq	%rax, -0x10(%rbp)
18000b9b5:     	callq	*0x1655(%rip)           # 0x18000d010
18000b9bb:     	movl	%eax, %eax
18000b9bd:     	leaq	0x18(%rbp), %rcx
18000b9c1:     	xorq	%rax, -0x10(%rbp)
18000b9c5:     	callq	*0x1635(%rip)           # 0x18000d000
18000b9cb:     	movl	0x18(%rbp), %eax
18000b9ce:     	leaq	-0x10(%rbp), %rcx
18000b9d2:     	shlq	$0x20, %rax
18000b9d6:     	xorq	0x18(%rbp), %rax
18000b9da:     	xorq	-0x10(%rbp), %rax
18000b9de:     	xorq	%rcx, %rax
18000b9e1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000b9eb:     	andq	%rcx, %rax
18000b9ee:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
18000b9f8:     	cmpq	%rbx, %rax
18000b9fb:     	cmoveq	%rcx, %rax
18000b9ff:     	movq	%rax, 0x86fa(%rip)      # 0x180014100
18000ba06:     	movq	0x50(%rsp), %rbx
18000ba0b:     	notq	%rax
18000ba0e:     	movq	%rax, 0x872b(%rip)      # 0x180014140
18000ba15:     	addq	$0x30, %rsp
18000ba19:     	popq	%rbp
18000ba1a:     	retq
18000ba1b:     	int3
18000ba1c:     	subq	$0x28, %rsp
18000ba20:     	cmpl	$0x1, %edx
18000ba23:     	jne	0x18000ba35 <numba_list_iter_next+0x7d5>
18000ba25:     	cmpq	$0x0, 0x20fb(%rip)      # 0x18000db28
18000ba2d:     	jne	0x18000ba35 <numba_list_iter_next+0x7d5>
18000ba2f:     	callq	*0x15f3(%rip)           # 0x18000d028
18000ba35:     	movl	$0x1, %eax
18000ba3a:     	addq	$0x28, %rsp
18000ba3e:     	retq
18000ba3f:     	int3
18000ba40:     	leaq	0x8fa9(%rip), %rcx      # 0x1800149f0
18000ba47:     	jmpq	*0x15ba(%rip)           # 0x18000d008
18000ba4e:     	int3
18000ba4f:     	int3
18000ba50:     	leaq	0x8f99(%rip), %rcx      # 0x1800149f0
18000ba57:     	jmp	0x18000c0e6 <numba_list_iter_next+0xe86>
18000ba5c:     	leaq	0x8f9d(%rip), %rax      # 0x180014a00
18000ba63:     	retq
18000ba64:     	subq	$0x28, %rsp
18000ba68:     	callq	0x18000ab70 <PyInit_rcaotr_b8ad585ae5ddf1131de85239+0x6fe0>
18000ba6d:     	orq	$0x24, (%rax)
18000ba71:     	callq	0x18000ba5c <numba_list_iter_next+0x7fc>
18000ba76:     	orq	$0x2, (%rax)
18000ba7a:     	addq	$0x28, %rsp
18000ba7e:     	retq
18000ba7f:     	int3
18000ba80:     	subq	$0x28, %rsp
18000ba84:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000ba89:     	testl	%eax, %eax
18000ba8b:     	je	0x18000baae <numba_list_iter_next+0x84e>
18000ba8d:     	movq	%gs:0x30, %rax
18000ba96:     	movq	0x8(%rax), %rcx
18000ba9a:     	jmp	0x18000baa1 <numba_list_iter_next+0x841>
18000ba9c:     	cmpq	%rax, %rcx
18000ba9f:     	je	0x18000bab5 <numba_list_iter_next+0x855>
18000baa1:     	xorl	%eax, %eax
18000baa3:     	lock
18000baa4:     	cmpxchgq	%rcx, 0x8f64(%rip)      # 0x180014a10
18000baac:     	jne	0x18000ba9c <numba_list_iter_next+0x83c>
18000baae:     	xorb	%al, %al
18000bab0:     	addq	$0x28, %rsp
18000bab4:     	retq
18000bab5:     	movb	$0x1, %al
18000bab7:     	jmp	0x18000bab0 <numba_list_iter_next+0x850>
18000bab9:     	int3
18000baba:     	int3
18000babb:     	int3
18000babc:     	subq	$0x28, %rsp
18000bac0:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000bac5:     	testl	%eax, %eax
18000bac7:     	je	0x18000bad0 <numba_list_iter_next+0x870>
18000bac9:     	callq	0x18000be28 <numba_list_iter_next+0xbc8>
18000bace:     	jmp	0x18000bae9 <numba_list_iter_next+0x889>
18000bad0:     	callq	0x18000c0c4 <numba_list_iter_next+0xe64>
18000bad5:     	movl	%eax, %ecx
18000bad7:     	callq	0x18000c0fe <numba_list_iter_next+0xe9e>
18000badc:     	testl	%eax, %eax
18000bade:     	je	0x18000bae4 <numba_list_iter_next+0x884>
18000bae0:     	xorb	%al, %al
18000bae2:     	jmp	0x18000baeb <numba_list_iter_next+0x88b>
18000bae4:     	callq	0x18000c104 <numba_list_iter_next+0xea4>
18000bae9:     	movb	$0x1, %al
18000baeb:     	addq	$0x28, %rsp
18000baef:     	retq
18000baf0:     	subq	$0x28, %rsp
18000baf4:     	xorl	%ecx, %ecx
18000baf6:     	callq	0x18000bc28 <numba_list_iter_next+0x9c8>
18000bafb:     	testb	%al, %al
18000bafd:     	setne	%al
18000bb00:     	addq	$0x28, %rsp
18000bb04:     	retq
18000bb05:     	int3
18000bb06:     	int3
18000bb07:     	int3
18000bb08:     	subq	$0x28, %rsp
18000bb0c:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bb11:     	testb	%al, %al
18000bb13:     	jne	0x18000bb19 <numba_list_iter_next+0x8b9>
18000bb15:     	xorb	%al, %al
18000bb17:     	jmp	0x18000bb2b <numba_list_iter_next+0x8cb>
18000bb19:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bb1e:     	testb	%al, %al
18000bb20:     	jne	0x18000bb29 <numba_list_iter_next+0x8c9>
18000bb22:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bb27:     	jmp	0x18000bb15 <numba_list_iter_next+0x8b5>
18000bb29:     	movb	$0x1, %al
18000bb2b:     	addq	$0x28, %rsp
18000bb2f:     	retq
18000bb30:     	subq	$0x28, %rsp
18000bb34:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bb39:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bb3e:     	movb	$0x1, %al
18000bb40:     	addq	$0x28, %rsp
18000bb44:     	retq
18000bb45:     	int3
18000bb46:     	int3
18000bb47:     	int3
18000bb48:     	movq	%rbx, 0x8(%rsp)
18000bb4d:     	movq	%rbp, 0x10(%rsp)
18000bb52:     	movq	%rsi, 0x18(%rsp)
18000bb57:     	pushq	%rdi
18000bb58:     	subq	$0x20, %rsp
18000bb5c:     	movq	%r9, %rdi
18000bb5f:     	movq	%r8, %rsi
18000bb62:     	movl	%edx, %ebx
18000bb64:     	movq	%rcx, %rbp
18000bb67:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000bb6c:     	testl	%eax, %eax
18000bb6e:     	jne	0x18000bb86 <numba_list_iter_next+0x926>
18000bb70:     	cmpl	$0x1, %ebx
18000bb73:     	jne	0x18000bb86 <numba_list_iter_next+0x926>
18000bb75:     	movq	%rsi, %r8
18000bb78:     	xorl	%edx, %edx
18000bb7a:     	movq	%rbp, %rcx
18000bb7d:     	movq	%rdi, %rax
18000bb80:     	callq	*0x17aa(%rip)           # 0x18000d330
18000bb86:     	movq	0x58(%rsp), %rdx
18000bb8b:     	movl	0x50(%rsp), %ecx
18000bb8f:     	movq	0x30(%rsp), %rbx
18000bb94:     	movq	0x38(%rsp), %rbp
18000bb99:     	movq	0x40(%rsp), %rsi
18000bb9e:     	addq	$0x20, %rsp
18000bba2:     	popq	%rdi
18000bba3:     	jmp	0x18000c0f8 <numba_list_iter_next+0xe98>
18000bba8:     	subq	$0x28, %rsp
18000bbac:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000bbb1:     	testl	%eax, %eax
18000bbb3:     	je	0x18000bbc5 <numba_list_iter_next+0x965>
18000bbb5:     	leaq	0x8e64(%rip), %rcx      # 0x180014a20
18000bbbc:     	addq	$0x28, %rsp
18000bbc0:     	jmp	0x18000c110 <numba_list_iter_next+0xeb0>
18000bbc5:     	callq	0x18000c120 <numba_list_iter_next+0xec0>
18000bbca:     	testl	%eax, %eax
18000bbcc:     	jne	0x18000bbd3 <numba_list_iter_next+0x973>
18000bbce:     	callq	0x18000c116 <numba_list_iter_next+0xeb6>
18000bbd3:     	addq	$0x28, %rsp
18000bbd7:     	retq
18000bbd8:     	subq	$0x28, %rsp
18000bbdc:     	xorl	%ecx, %ecx
18000bbde:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bbe3:     	addq	$0x28, %rsp
18000bbe7:     	jmp	0x18000c11c <numba_list_iter_next+0xebc>
18000bbec:     	subq	$0x28, %rsp
18000bbf0:     	testl	%ecx, %ecx
18000bbf2:     	jne	0x18000bbfb <numba_list_iter_next+0x99b>
18000bbf4:     	movb	$0x1, 0x8e1d(%rip)      # 0x180014a18
18000bbfb:     	callq	0x18000be28 <numba_list_iter_next+0xbc8>
18000bc00:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bc05:     	testb	%al, %al
18000bc07:     	jne	0x18000bc0d <numba_list_iter_next+0x9ad>
18000bc09:     	xorb	%al, %al
18000bc0b:     	jmp	0x18000bc21 <numba_list_iter_next+0x9c1>
18000bc0d:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bc12:     	testb	%al, %al
18000bc14:     	jne	0x18000bc1f <numba_list_iter_next+0x9bf>
18000bc16:     	xorl	%ecx, %ecx
18000bc18:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bc1d:     	jmp	0x18000bc09 <numba_list_iter_next+0x9a9>
18000bc1f:     	movb	$0x1, %al
18000bc21:     	addq	$0x28, %rsp
18000bc25:     	retq
18000bc26:     	int3
18000bc27:     	int3
18000bc28:     	pushq	%rbx
18000bc2a:     	subq	$0x20, %rsp
18000bc2e:     	cmpb	$0x0, 0x8de4(%rip)      # 0x180014a19
18000bc35:     	movl	%ecx, %ebx
18000bc37:     	jne	0x18000bca0 <numba_list_iter_next+0xa40>
18000bc39:     	cmpl	$0x1, %ecx
18000bc3c:     	ja	0x18000bca8 <numba_list_iter_next+0xa48>
18000bc3e:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000bc43:     	testl	%eax, %eax
18000bc45:     	je	0x18000bc6f <numba_list_iter_next+0xa0f>
18000bc47:     	testl	%ebx, %ebx
18000bc49:     	jne	0x18000bc6f <numba_list_iter_next+0xa0f>
18000bc4b:     	leaq	0x8dce(%rip), %rcx      # 0x180014a20
18000bc52:     	callq	0x18000c10a <numba_list_iter_next+0xeaa>
18000bc57:     	testl	%eax, %eax
18000bc59:     	jne	0x18000bc6b <numba_list_iter_next+0xa0b>
18000bc5b:     	leaq	0x8dd6(%rip), %rcx      # 0x180014a38
18000bc62:     	callq	0x18000c10a <numba_list_iter_next+0xeaa>
18000bc67:     	testl	%eax, %eax
18000bc69:     	je	0x18000bc99 <numba_list_iter_next+0xa39>
18000bc6b:     	xorb	%al, %al
18000bc6d:     	jmp	0x18000bca2 <numba_list_iter_next+0xa42>
18000bc6f:     	movdqa	0x1eb9(%rip), %xmm0     # 0x18000db30
18000bc77:     	orq	$-0x1, %rax
18000bc7b:     	movdqu	%xmm0, 0x8d9d(%rip)     # 0x180014a20
18000bc83:     	movq	%rax, 0x8da6(%rip)      # 0x180014a30
18000bc8a:     	movdqu	%xmm0, 0x8da6(%rip)     # 0x180014a38
18000bc92:     	movq	%rax, 0x8daf(%rip)      # 0x180014a48
18000bc99:     	movb	$0x1, 0x8d79(%rip)      # 0x180014a19
18000bca0:     	movb	$0x1, %al
18000bca2:     	addq	$0x20, %rsp
18000bca6:     	popq	%rbx
18000bca7:     	retq
18000bca8:     	movl	$0x5, %ecx
18000bcad:     	callq	0x18000bda4 <numba_list_iter_next+0xb44>
18000bcb2:     	int3
18000bcb3:     	int3
18000bcb4:     	subq	$0x18, %rsp
18000bcb8:     	movq	%rcx, %r8
18000bcbb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
18000bcc0:     	cmpw	%ax, -0xbcc7(%rip)      # 0x180000000
18000bcc7:     	jne	0x18000bd41 <numba_list_iter_next+0xae1>
18000bcc9:     	movslq	-0xbc94(%rip), %rcx     # 0x18000003c
18000bcd0:     	leaq	-0xbcd7(%rip), %rdx     # 0x180000000
18000bcd7:     	addq	%rdx, %rcx
18000bcda:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
18000bce0:     	jne	0x18000bd41 <numba_list_iter_next+0xae1>
18000bce2:     	movl	$0x20b, %eax            # imm = 0x20B
18000bce7:     	cmpw	%ax, 0x18(%rcx)
18000bceb:     	jne	0x18000bd41 <numba_list_iter_next+0xae1>
18000bced:     	subq	%rdx, %r8
18000bcf0:     	movzwl	0x14(%rcx), %edx
18000bcf4:     	addq	$0x18, %rdx
18000bcf8:     	addq	%rcx, %rdx
18000bcfb:     	movzwl	0x6(%rcx), %eax
18000bcff:     	leaq	(%rax,%rax,4), %rcx
18000bd03:     	leaq	(%rdx,%rcx,8), %r9
18000bd07:     	movq	%rdx, (%rsp)
18000bd0b:     	cmpq	%r9, %rdx
18000bd0e:     	je	0x18000bd28 <numba_list_iter_next+0xac8>
18000bd10:     	movl	0xc(%rdx), %ecx
18000bd13:     	cmpq	%rcx, %r8
18000bd16:     	jb	0x18000bd22 <numba_list_iter_next+0xac2>
18000bd18:     	movl	0x8(%rdx), %eax
18000bd1b:     	addl	%ecx, %eax
18000bd1d:     	cmpq	%rax, %r8
18000bd20:     	jb	0x18000bd2a <numba_list_iter_next+0xaca>
18000bd22:     	addq	$0x28, %rdx
18000bd26:     	jmp	0x18000bd07 <numba_list_iter_next+0xaa7>
18000bd28:     	xorl	%edx, %edx
18000bd2a:     	testq	%rdx, %rdx
18000bd2d:     	jne	0x18000bd33 <numba_list_iter_next+0xad3>
18000bd2f:     	xorb	%al, %al
18000bd31:     	jmp	0x18000bd47 <numba_list_iter_next+0xae7>
18000bd33:     	cmpl	$0x0, 0x24(%rdx)
18000bd37:     	jge	0x18000bd3d <numba_list_iter_next+0xadd>
18000bd39:     	xorb	%al, %al
18000bd3b:     	jmp	0x18000bd47 <numba_list_iter_next+0xae7>
18000bd3d:     	movb	$0x1, %al
18000bd3f:     	jmp	0x18000bd47 <numba_list_iter_next+0xae7>
18000bd41:     	xorb	%al, %al
18000bd43:     	jmp	0x18000bd47 <numba_list_iter_next+0xae7>
18000bd45:     	xorb	%al, %al
18000bd47:     	addq	$0x18, %rsp
18000bd4b:     	retq
18000bd4c:     	pushq	%rbx
18000bd4e:     	subq	$0x20, %rsp
18000bd52:     	movb	%cl, %bl
18000bd54:     	callq	0x18000c0cc <numba_list_iter_next+0xe6c>
18000bd59:     	xorl	%edx, %edx
18000bd5b:     	testl	%eax, %eax
18000bd5d:     	je	0x18000bd6a <numba_list_iter_next+0xb0a>
18000bd5f:     	testb	%bl, %bl
18000bd61:     	jne	0x18000bd6a <numba_list_iter_next+0xb0a>
18000bd63:     	xchgq	%rdx, 0x8ca6(%rip)      # 0x180014a10
18000bd6a:     	addq	$0x20, %rsp
18000bd6e:     	popq	%rbx
18000bd6f:     	retq
18000bd70:     	pushq	%rbx
18000bd72:     	subq	$0x20, %rsp
18000bd76:     	cmpb	$0x0, 0x8c9b(%rip)      # 0x180014a18
18000bd7d:     	movb	%cl, %bl
18000bd7f:     	je	0x18000bd85 <numba_list_iter_next+0xb25>
18000bd81:     	testb	%dl, %dl
18000bd83:     	jne	0x18000bd91 <numba_list_iter_next+0xb31>
18000bd85:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bd8a:     	movb	%bl, %cl
18000bd8c:     	callq	0x18000c11c <numba_list_iter_next+0xebc>
18000bd91:     	movb	$0x1, %al
18000bd93:     	addq	$0x20, %rsp
18000bd97:     	popq	%rbx
18000bd98:     	retq
18000bd99:     	int3
18000bd9a:     	int3
18000bd9b:     	int3
18000bd9c:     	leaq	0x8f35(%rip), %rax      # 0x180014cd8
18000bda3:     	retq
18000bda4:     	movl	%ecx, %ecx
18000bda6:     	int	$0x29
18000bda8:     	retq
18000bda9:     	int3
18000bdaa:     	int3
18000bdab:     	int3
18000bdac:     	movq	%rbx, 0x8(%rsp)
18000bdb1:     	pushq	%rdi
18000bdb2:     	subq	$0x20, %rsp
18000bdb6:     	leaq	0x478b(%rip), %rbx      # 0x180010548
18000bdbd:     	leaq	0x4784(%rip), %rdi      # 0x180010548
18000bdc4:     	jmp	0x18000bdd8 <numba_list_iter_next+0xb78>
18000bdc6:     	movq	(%rbx), %rax
18000bdc9:     	testq	%rax, %rax
18000bdcc:     	je	0x18000bdd4 <numba_list_iter_next+0xb74>
18000bdce:     	callq	*0x155c(%rip)           # 0x18000d330
18000bdd4:     	addq	$0x8, %rbx
18000bdd8:     	cmpq	%rdi, %rbx
18000bddb:     	jb	0x18000bdc6 <numba_list_iter_next+0xb66>
18000bddd:     	movq	0x30(%rsp), %rbx
18000bde2:     	addq	$0x20, %rsp
18000bde6:     	popq	%rdi
18000bde7:     	retq
18000bde8:     	movq	%rbx, 0x8(%rsp)
18000bded:     	pushq	%rdi
18000bdee:     	subq	$0x20, %rsp
18000bdf2:     	leaq	0x475f(%rip), %rbx      # 0x180010558
18000bdf9:     	leaq	0x4758(%rip), %rdi      # 0x180010558
18000be00:     	jmp	0x18000be14 <numba_list_iter_next+0xbb4>
18000be02:     	movq	(%rbx), %rax
18000be05:     	testq	%rax, %rax
18000be08:     	je	0x18000be10 <numba_list_iter_next+0xbb0>
18000be0a:     	callq	*0x1520(%rip)           # 0x18000d330
18000be10:     	addq	$0x8, %rbx
18000be14:     	cmpq	%rdi, %rbx
18000be17:     	jb	0x18000be02 <numba_list_iter_next+0xba2>
18000be19:     	movq	0x30(%rsp), %rbx
18000be1e:     	addq	$0x20, %rsp
18000be22:     	popq	%rdi
18000be23:     	retq
18000be24:     	retq	$0x0
18000be27:     	int3
18000be28:     	movq	%rbx, 0x10(%rsp)
18000be2d:     	movq	%rbp, 0x18(%rsp)
18000be32:     	movq	%rsi, 0x20(%rsp)
18000be37:     	pushq	%rdi
18000be38:     	subq	$0x10, %rsp
18000be3c:     	xorl	%eax, %eax
18000be3e:     	xorl	%ecx, %ecx
18000be40:     	cpuid
18000be42:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
18000be48:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000be4e:     	orl	%ecx, %edx
18000be50:     	movl	%eax, %ebp
18000be52:     	movl	$0x1, %eax
18000be57:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000be5d:     	orl	%ebx, %edx
18000be5f:     	leal	-0x1(%rax), %ecx
18000be62:     	cpuid
18000be64:     	movl	%ecx, %edi
18000be66:     	jne	0x18000bec6 <numba_list_iter_next+0xc66>
18000be68:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000be6d:     	movq	$0x8000, 0x82e0(%rip)   # imm = 0x8000
                                                # 0x180014158
18000be78:     	movq	$-0x1, 0x82dd(%rip)     # 0x180014160
18000be83:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
18000be88:     	je	0x18000beb2 <numba_list_iter_next+0xc52>
18000be8a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000be8f:     	je	0x18000beb2 <numba_list_iter_next+0xc52>
18000be91:     	cmpl	$0x20670, %eax          # imm = 0x20670
18000be96:     	je	0x18000beb2 <numba_list_iter_next+0xc52>
18000be98:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000be9d:     	cmpl	$0x20, %eax
18000bea0:     	ja	0x18000bec6 <numba_list_iter_next+0xc66>
18000bea2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000beac:     	btq	%rax, %rcx
18000beb0:     	jae	0x18000bec6 <numba_list_iter_next+0xc66>
18000beb2:     	movl	0x8b9b(%rip), %r8d      # 0x180014a54
18000beb9:     	orl	$0x1, %r8d
18000bebd:     	movl	%r8d, 0x8b90(%rip)      # 0x180014a54
18000bec4:     	jmp	0x18000becd <numba_list_iter_next+0xc6d>
18000bec6:     	movl	0x8b87(%rip), %r8d      # 0x180014a54
18000becd:     	xorl	%r9d, %r9d
18000bed0:     	movl	%r9d, %r11d
18000bed3:     	cmpl	$0x7, %ebp
18000bed6:     	jl	0x18000bf1a <numba_list_iter_next+0xcba>
18000bed8:     	xorl	%ecx, %ecx
18000beda:     	leal	0x7(%r9), %eax
18000bede:     	cpuid
18000bee0:     	movl	%edx, %esi
18000bee2:     	movl	%ebx, %r10d
18000bee5:     	btl	$0x9, %ebx
18000bee9:     	jae	0x18000bef6 <numba_list_iter_next+0xc96>
18000beeb:     	orl	$0x2, %r8d
18000beef:     	movl	%r8d, 0x8b5e(%rip)      # 0x180014a54
18000bef6:     	cmpl	$0x1, %eax
18000bef9:     	jl	0x18000bf08 <numba_list_iter_next+0xca8>
18000befb:     	movl	$0x7, %eax
18000bf00:     	leal	-0x6(%rax), %ecx
18000bf03:     	cpuid
18000bf05:     	movl	%edx, %r9d
18000bf08:     	movl	$0x24, %eax
18000bf0d:     	cmpl	%eax, %ebp
18000bf0f:     	jl	0x18000bf20 <numba_list_iter_next+0xcc0>
18000bf11:     	xorl	%ecx, %ecx
18000bf13:     	cpuid
18000bf15:     	movl	%ebx, %r11d
18000bf18:     	jmp	0x18000bf20 <numba_list_iter_next+0xcc0>
18000bf1a:     	movl	%r9d, %r10d
18000bf1d:     	movl	%r9d, %esi
18000bf20:     	movq	0x8241(%rip), %rax      # 0x180014168
18000bf27:     	andq	$-0x2, %rax
18000bf2b:     	movl	$0x1, 0x821b(%rip)      # 0x180014150
18000bf35:     	movl	$0x2, 0x8215(%rip)      # 0x180014154
18000bf3f:     	movq	%rax, 0x8222(%rip)      # 0x180014168
18000bf46:     	btl	$0x14, %edi
18000bf4a:     	jae	0x18000bf6b <numba_list_iter_next+0xd0b>
18000bf4c:     	andq	$-0x11, %rax
18000bf50:     	movl	$0x2, 0x81f6(%rip)      # 0x180014150
18000bf5a:     	movq	%rax, 0x8207(%rip)      # 0x180014168
18000bf61:     	movl	$0x6, 0x81e9(%rip)      # 0x180014154
18000bf6b:     	btl	$0x1b, %edi
18000bf6f:     	jae	0x18000c0ac <numba_list_iter_next+0xe4c>
18000bf75:     	xorl	%ecx, %ecx
18000bf77:     	xgetbv
18000bf7a:     	shlq	$0x20, %rdx
18000bf7e:     	orq	%rax, %rdx
18000bf81:     	movq	%rdx, 0x20(%rsp)
18000bf86:     	btl	$0x1c, %edi
18000bf8a:     	jae	0x18000c090 <numba_list_iter_next+0xe30>
18000bf90:     	movq	0x20(%rsp), %rax
18000bf95:     	andb	$0x6, %al
18000bf97:     	cmpb	$0x6, %al
18000bf99:     	jne	0x18000c090 <numba_list_iter_next+0xe30>
18000bf9f:     	movl	0x81af(%rip), %eax      # 0x180014154
18000bfa5:     	movb	$-0x20, %dl
18000bfa7:     	orl	$0x8, %eax
18000bfaa:     	movl	$0x3, 0x819c(%rip)      # 0x180014150
18000bfb4:     	movl	%eax, 0x819a(%rip)      # 0x180014154
18000bfba:     	testb	$0x20, %r10b
18000bfbe:     	je	0x18000c022 <numba_list_iter_next+0xdc2>
18000bfc0:     	orl	$0x20, %eax
18000bfc3:     	movl	$0x5, 0x8183(%rip)      # 0x180014150
18000bfcd:     	movl	%eax, 0x8181(%rip)      # 0x180014154
18000bfd3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
18000bfd8:     	movq	0x8189(%rip), %rax      # 0x180014168
18000bfdf:     	andl	%ecx, %r10d
18000bfe2:     	andq	$-0x3, %rax
18000bfe6:     	movq	%rax, 0x817b(%rip)      # 0x180014168
18000bfed:     	cmpl	%ecx, %r10d
18000bff0:     	jne	0x18000c029 <numba_list_iter_next+0xdc9>
18000bff2:     	movq	0x20(%rsp), %rax
18000bff7:     	andb	%dl, %al
18000bff9:     	cmpb	%dl, %al
18000bffb:     	jne	0x18000c022 <numba_list_iter_next+0xdc2>
18000bffd:     	movq	0x8164(%rip), %rax      # 0x180014168
18000c004:     	orl	$0x40, 0x8149(%rip)     # 0x180014154
18000c00b:     	andq	$-0x25, %rax
18000c00f:     	movl	$0x6, 0x8137(%rip)      # 0x180014150
18000c019:     	movq	%rax, 0x8148(%rip)      # 0x180014168
18000c020:     	jmp	0x18000c029 <numba_list_iter_next+0xdc9>
18000c022:     	movq	0x813f(%rip), %rax      # 0x180014168
18000c029:     	btl	$0x17, %esi
18000c02d:     	jae	0x18000c03b <numba_list_iter_next+0xddb>
18000c02f:     	btrq	$0x18, %rax
18000c034:     	movq	%rax, 0x812d(%rip)      # 0x180014168
18000c03b:     	btl	$0x13, %r9d
18000c040:     	jae	0x18000c090 <numba_list_iter_next+0xe30>
18000c042:     	movq	0x20(%rsp), %rax
18000c047:     	andb	%dl, %al
18000c049:     	cmpb	%dl, %al
18000c04b:     	jne	0x18000c090 <numba_list_iter_next+0xe30>
18000c04d:     	movq	0x8114(%rip), %rdx      # 0x180014168
18000c054:     	movl	%r11d, %eax
18000c057:     	shrq	$0x10, %rax
18000c05b:     	movl	%r11d, %ecx
18000c05e:     	andl	$0x6, %eax
18000c061:     	andl	$0x400ff, %ecx          # imm = 0x400FF
18000c067:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000c06d:     	movl	%ecx, 0x89e5(%rip)      # 0x180014a58
18000c073:     	notq	%rax
18000c076:     	andq	%rax, %rdx
18000c079:     	movq	%rdx, 0x80e8(%rip)      # 0x180014168
18000c080:     	cmpb	$0x1, %cl
18000c083:     	jbe	0x18000c090 <numba_list_iter_next+0xe30>
18000c085:     	andq	$-0x41, %rdx
18000c089:     	movq	%rdx, 0x80d8(%rip)      # 0x180014168
18000c090:     	btl	$0x15, %r9d
18000c095:     	jae	0x18000c0ac <numba_list_iter_next+0xe4c>
18000c097:     	movq	0x20(%rsp), %rax
18000c09c:     	btq	$0x13, %rax
18000c0a1:     	jae	0x18000c0ac <numba_list_iter_next+0xe4c>
18000c0a3:     	btrq	$0x7, 0x80bc(%rip)      # 0x180014168
18000c0ac:     	movq	0x28(%rsp), %rbx
18000c0b1:     	xorl	%eax, %eax
18000c0b3:     	movq	0x30(%rsp), %rbp
18000c0b8:     	movq	0x38(%rsp), %rsi
18000c0bd:     	addq	$0x10, %rsp
18000c0c1:     	popq	%rdi
18000c0c2:     	retq
18000c0c3:     	int3
18000c0c4:     	movl	$0x1, %eax
18000c0c9:     	retq
18000c0ca:     	int3
18000c0cb:     	int3
18000c0cc:     	xorl	%eax, %eax
18000c0ce:     	cmpl	%eax, 0x809c(%rip)      # 0x180014170
18000c0d4:     	setne	%al
18000c0d7:     	retq
18000c0d8:     	int3
18000c0d9:     	int3
18000c0da:     	int3
18000c0db:     	int3
18000c0dc:     	int3
18000c0dd:     	int3
18000c0de:     	int3
18000c0df:     	int3
18000c0e0:     	jmpq	*0xf62(%rip)            # 0x18000d048
18000c0e6:     	jmpq	*0xf64(%rip)            # 0x18000d050
18000c0ec:     	jmpq	*0xf9e(%rip)            # 0x18000d090
18000c0f2:     	jmpq	*0xfa0(%rip)            # 0x18000d098
18000c0f8:     	jmpq	*0xfa2(%rip)            # 0x18000d0a0
18000c0fe:     	jmpq	*0xfa4(%rip)            # 0x18000d0a8
18000c104:     	jmpq	*0xfa6(%rip)            # 0x18000d0b0
18000c10a:     	jmpq	*0xf70(%rip)            # 0x18000d080
18000c110:     	jmpq	*0xfa2(%rip)            # 0x18000d0b8
18000c116:     	jmpq	*0xf6c(%rip)            # 0x18000d088
18000c11c:     	movb	$0x1, %al
18000c11e:     	retq
18000c11f:     	int3
18000c120:     	xorl	%eax, %eax
18000c122:     	retq
18000c123:     	jmpq	*0xf0f(%rip)            # 0x18000d038
18000c129:     	jmpq	*0xf11(%rip)            # 0x18000d040
18000c12f:     	jmpq	*0xf93(%rip)            # 0x18000d0c8
18000c135:     	jmpq	*0xf95(%rip)            # 0x18000d0d0
18000c13b:     	int3
18000c13c:     	int3
18000c13d:     	int3
18000c13e:     	int3
18000c13f:     	int3
18000c140:     	int3
18000c141:     	int3
18000c142:     	int3
18000c143:     	int3
18000c144:     	int3
18000c145:     	int3
18000c146:     	nopw	(%rax,%rax)
18000c150:     	jmpq	*%rax
18000c152:     	int3
18000c153:     	int3
18000c154:     	int3
18000c155:     	int3
18000c156:     	int3
18000c157:     	int3
18000c158:     	int3
18000c159:     	int3
18000c15a:     	int3
18000c15b:     	int3
18000c15c:     	int3
18000c15d:     	int3
18000c15e:     	int3
18000c15f:     	int3
18000c160:     	int3
18000c161:     	int3
18000c162:     	int3
18000c163:     	int3
18000c164:     	int3
18000c165:     	int3
18000c166:     	nopw	(%rax,%rax)
18000c170:     	jmpq	*0x11ba(%rip)           # 0x18000d330
18000c176:     	pushq	%rbp
18000c178:     	subq	$0x20, %rsp
18000c17c:     	movq	%rdx, %rbp
18000c17f:     	movb	0x40(%rbp), %cl
18000c182:     	addq	$0x20, %rsp
18000c186:     	popq	%rbp
18000c187:     	jmp	0x18000bd4c <numba_list_iter_next+0xaec>
18000c18c:     	int3
18000c18d:     	pushq	%rbp
18000c18f:     	subq	$0x20, %rsp
18000c193:     	movq	%rdx, %rbp
18000c196:     	movb	0x20(%rbp), %cl
18000c199:     	callq	0x18000bd4c <numba_list_iter_next+0xaec>
18000c19e:     	nop
18000c19f:     	addq	$0x20, %rsp
18000c1a3:     	popq	%rbp
18000c1a4:     	retq
18000c1a5:     	int3
18000c1a6:     	pushq	%rbp
18000c1a8:     	subq	$0x20, %rsp
18000c1ac:     	movq	%rdx, %rbp
18000c1af:     	addq	$0x20, %rsp
18000c1b3:     	popq	%rbp
18000c1b4:     	jmp	0x18000bbd8 <numba_list_iter_next+0x978>
18000c1b9:     	int3
18000c1ba:     	pushq	%rbp
18000c1bc:     	subq	$0x30, %rsp
18000c1c0:     	movq	%rdx, %rbp
18000c1c3:     	movq	(%rcx), %rax
18000c1c6:     	movl	(%rax), %edx
18000c1c8:     	movq	%rcx, 0x28(%rsp)
18000c1cd:     	movl	%edx, 0x20(%rsp)
18000c1d1:     	leaq	-0xbc8(%rip), %r9       # 0x18000b610 <numba_list_iter_next+0x3b0>
18000c1d8:     	movq	0x70(%rbp), %r8
18000c1dc:     	movl	0x68(%rbp), %edx
18000c1df:     	movq	0x60(%rbp), %rcx
18000c1e3:     	callq	0x18000bb48 <numba_list_iter_next+0x8e8>
18000c1e8:     	nop
18000c1e9:     	addq	$0x30, %rsp
18000c1ed:     	popq	%rbp
18000c1ee:     	retq
18000c1ef:     	int3
18000c1f0:     	pushq	%rbp
18000c1f2:     	movq	%rdx, %rbp
18000c1f5:     	movq	(%rcx), %rax
18000c1f8:     	xorl	%ecx, %ecx
18000c1fa:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
18000c200:     	sete	%cl
18000c203:     	movl	%ecx, %eax
18000c205:     	popq	%rbp
18000c206:     	retq
18000c207:     	int3
