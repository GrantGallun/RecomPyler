
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-formal-v1\aot\candidate-strict\recurrence_1\rcaotr_cfc86c0ea0bdaa7b4e79b193.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002e50 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3339(%rip), %rax      # 0x1800043c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	cvtsi2sd	%r8, %xmm0
180001095:     	cvtsi2sd	%r9, %xmm1
18000109a:     	mulsd	%xmm0, %xmm1
18000109e:     	andpd	0x326a(%rip), %xmm1     # 0x180004310
1800010a6:     	ucomisd	0x3272(%rip), %xmm1     # 0x180004320
1800010ae:     	jae	0x1800010d1 <.text+0xd1>
1800010b0:     	cmpb	$0x0, (%rdx)
1800010b3:     	jne	0x1800010d4 <.text+0xd4>
1800010b5:     	movq	0x28(%rsp), %r10
1800010ba:     	imulq	%r8, %r9
1800010be:     	leaq	(%r9,%r10), %rax
1800010c2:     	xorq	%rax, %r9
1800010c5:     	xorq	%rax, %r10
1800010c8:     	testq	%r10, %r9
1800010cb:     	js	0x1800010d1 <.text+0xd1>
1800010cd:     	movq	%rax, (%rcx)
1800010d0:     	retq
1800010d1:     	movb	$0x1, (%rdx)
1800010d4:     	xorl	%eax, %eax
1800010d6:     	movq	%rax, (%rcx)
1800010d9:     	retq
1800010da:     	nopw	(%rax,%rax)
1800010e0:     	pushq	%r15
1800010e2:     	pushq	%r14
1800010e4:     	pushq	%r13
1800010e6:     	pushq	%r12
1800010e8:     	pushq	%rsi
1800010e9:     	pushq	%rdi
1800010ea:     	pushq	%rbp
1800010eb:     	pushq	%rbx
1800010ec:     	subq	$0x198, %rsp            # imm = 0x198
1800010f3:     	movq	%rdx, %rcx
1800010f6:     	leaq	0x68(%rsp), %rax
1800010fb:     	movq	%rax, 0x50(%rsp)
180001100:     	leaq	0x70(%rsp), %rax
180001105:     	movq	%rax, 0x48(%rsp)
18000110a:     	leaq	0x78(%rsp), %rax
18000110f:     	movq	%rax, 0x40(%rsp)
180001114:     	leaq	0x80(%rsp), %rax
18000111c:     	movq	%rax, 0x38(%rsp)
180001121:     	leaq	0x88(%rsp), %rax
180001129:     	movq	%rax, 0x30(%rsp)
18000112e:     	leaq	0x90(%rsp), %rax
180001136:     	movq	%rax, 0x28(%rsp)
18000113b:     	leaq	0x98(%rsp), %rax
180001143:     	movq	%rax, 0x20(%rsp)
180001148:     	leaq	0x3299(%rip), %rdx      # 0x1800043e8
18000114f:     	movl	$0x7, %r8d
180001155:     	movl	$0x7, %r9d
18000115b:     	callq	0x180002fe1 <numba_list_iter_next+0x2f1>
180001160:     	testl	%eax, %eax
180001162:     	movq	$0x0, 0x60(%rsp)
18000116b:     	je	0x1800014cc <.text+0x4cc>
180001171:     	cmpq	$0x0, 0x9ae7(%rip)      # 0x18000ac60
180001179:     	je	0x1800013fc <.text+0x3fc>
18000117f:     	movq	0x98(%rsp), %rcx
180001187:     	xorps	%xmm0, %xmm0
18000118a:     	movaps	%xmm0, 0x160(%rsp)
180001192:     	movaps	%xmm0, 0x170(%rsp)
18000119a:     	movaps	%xmm0, 0x180(%rsp)
1800011a2:     	movq	$0x0, 0x190(%rsp)
1800011ae:     	leaq	0x160(%rsp), %rdx
1800011b6:     	callq	0x180001cc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7a0>
1800011bb:     	testl	%eax, %eax
1800011bd:     	jne	0x180001414 <.text+0x414>
1800011c3:     	cmpq	$0x8, 0x178(%rsp)
1800011cc:     	jne	0x180001414 <.text+0x414>
1800011d2:     	movq	0x160(%rsp), %rsi
1800011da:     	movq	0x90(%rsp), %rcx
1800011e2:     	xorps	%xmm0, %xmm0
1800011e5:     	movaps	%xmm0, 0x120(%rsp)
1800011ed:     	movaps	%xmm0, 0x130(%rsp)
1800011f5:     	movaps	%xmm0, 0x140(%rsp)
1800011fd:     	movq	$0x0, 0x150(%rsp)
180001209:     	leaq	0x120(%rsp), %rdx
180001211:     	callq	0x180001cc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7a0>
180001216:     	testl	%eax, %eax
180001218:     	jne	0x18000142c <.text+0x42c>
18000121e:     	cmpq	$0x8, 0x138(%rsp)
180001227:     	jne	0x18000142c <.text+0x42c>
18000122d:     	movq	0x120(%rsp), %rbx
180001235:     	movq	0x88(%rsp), %rcx
18000123d:     	xorps	%xmm0, %xmm0
180001240:     	movaps	%xmm0, 0xe0(%rsp)
180001248:     	movaps	%xmm0, 0xf0(%rsp)
180001250:     	movaps	%xmm0, 0x100(%rsp)
180001258:     	movq	$0x0, 0x110(%rsp)
180001264:     	leaq	0xe0(%rsp), %rdx
18000126c:     	callq	0x180001cc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7a0>
180001271:     	testl	%eax, %eax
180001273:     	jne	0x180001444 <.text+0x444>
180001279:     	cmpq	$0x8, 0xf8(%rsp)
180001282:     	jne	0x180001444 <.text+0x444>
180001288:     	movq	0xe0(%rsp), %r14
180001290:     	movq	0x80(%rsp), %rcx
180001298:     	xorps	%xmm0, %xmm0
18000129b:     	movaps	%xmm0, 0xa0(%rsp)
1800012a3:     	movaps	%xmm0, 0xb0(%rsp)
1800012ab:     	movaps	%xmm0, 0xc0(%rsp)
1800012b3:     	movq	$0x0, 0xd0(%rsp)
1800012bf:     	leaq	0xa0(%rsp), %rdx
1800012c7:     	callq	0x180001cc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7a0>
1800012cc:     	testl	%eax, %eax
1800012ce:     	jne	0x180001459 <.text+0x459>
1800012d4:     	cmpq	$0x1, 0xb8(%rsp)
1800012dd:     	jne	0x180001459 <.text+0x459>
1800012e3:     	movq	0xa0(%rsp), %rdi
1800012eb:     	movq	0xc0(%rsp), %r15
1800012f3:     	movq	0x78(%rsp), %rcx
1800012f8:     	callq	0x180002fe7 <numba_list_iter_next+0x2f7>
1800012fd:     	testq	%rax, %rax
180001300:     	movq	%rdi, 0x58(%rsp)
180001305:     	je	0x18000146e <.text+0x46e>
18000130b:     	movq	%rax, %r13
18000130e:     	movq	%rsi, %rdi
180001311:     	movq	%rax, %rcx
180001314:     	callq	0x180002fed <numba_list_iter_next+0x2fd>
180001319:     	movq	%rax, %r12
18000131c:     	movq	%r13, %rcx
18000131f:     	callq	0x180002ff3 <numba_list_iter_next+0x303>
180001324:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
180001329:     	testq	%rax, %rax
18000132c:     	jne	0x1800014a7 <.text+0x4a7>
180001332:     	movq	0x70(%rsp), %rcx
180001337:     	callq	0x180002fe7 <numba_list_iter_next+0x2f7>
18000133c:     	testq	%rax, %rax
18000133f:     	je	0x180001484 <.text+0x484>
180001345:     	movq	%rax, %rbp
180001348:     	movq	%rax, %rcx
18000134b:     	callq	0x180002fed <numba_list_iter_next+0x2fd>
180001350:     	movq	%rax, %r13
180001353:     	movq	%rbp, %rcx
180001356:     	callq	0x180002ff3 <numba_list_iter_next+0x303>
18000135b:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
180001360:     	testq	%rax, %rax
180001363:     	jne	0x1800014a7 <.text+0x4a7>
180001369:     	movq	0x68(%rsp), %rcx
18000136e:     	callq	0x180002fe7 <numba_list_iter_next+0x2f7>
180001373:     	testq	%rax, %rax
180001376:     	je	0x180001497 <.text+0x497>
18000137c:     	movq	%rax, %rsi
18000137f:     	movq	%rax, %rcx
180001382:     	callq	0x180002fed <numba_list_iter_next+0x2fd>
180001387:     	movq	%rax, %rbp
18000138a:     	movq	%rsi, %rcx
18000138d:     	callq	0x180002ff3 <numba_list_iter_next+0x303>
180001392:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
180001397:     	testq	%rax, %rax
18000139a:     	jne	0x1800014a7 <.text+0x4a7>
1800013a0:     	movq	%rbp, 0x20(%rsp)
1800013a5:     	leaq	0x60(%rsp), %rcx
1800013aa:     	movq	%r15, %rdx
1800013ad:     	movq	%r12, %r8
1800013b0:     	movq	%r13, %r9
1800013b3:     	callq	0x180001090 <.text+0x90>
1800013b8:     	movq	0x60(%rsp), %rsi
1800013bd:     	movq	%rdi, %rcx
1800013c0:     	callq	0x180001060 <.text+0x60>
1800013c5:     	movq	%rbx, %rcx
1800013c8:     	callq	0x180001060 <.text+0x60>
1800013cd:     	movq	%r14, %rcx
1800013d0:     	callq	0x180001060 <.text+0x60>
1800013d5:     	movq	0x58(%rsp), %rcx
1800013da:     	callq	0x180001060 <.text+0x60>
1800013df:     	movq	%rsi, %rcx
1800013e2:     	callq	0x180002fff <numba_list_iter_next+0x30f>
1800013e7:     	nop
1800013e8:     	addq	$0x198, %rsp            # imm = 0x198
1800013ef:     	popq	%rbx
1800013f0:     	popq	%rbp
1800013f1:     	popq	%rdi
1800013f2:     	popq	%rsi
1800013f3:     	popq	%r12
1800013f5:     	popq	%r13
1800013f7:     	popq	%r14
1800013f9:     	popq	%r15
1800013fb:     	retq
1800013fc:     	movq	0x2e35(%rip), %rcx      # 0x180004238
180001403:     	leaq	0x2ff6(%rip), %rdx      # 0x180004400
18000140a:     	callq	0x180003005 <numba_list_iter_next+0x315>
18000140f:     	jmp	0x1800014cc <.text+0x4cc>
180001414:     	movq	0x2e0d(%rip), %rcx      # 0x180004228
18000141b:     	leaq	0x30de(%rip), %rdx      # 0x180004500
180001422:     	callq	0x180003005 <numba_list_iter_next+0x315>
180001427:     	jmp	0x1800014cc <.text+0x4cc>
18000142c:     	movq	0x2df5(%rip), %rcx      # 0x180004228
180001433:     	leaq	0x30c6(%rip), %rdx      # 0x180004500
18000143a:     	callq	0x180003005 <numba_list_iter_next+0x315>
18000143f:     	jmp	0x1800014c4 <.text+0x4c4>
180001444:     	movq	0x2ddd(%rip), %rcx      # 0x180004228
18000144b:     	leaq	0x30ae(%rip), %rdx      # 0x180004500
180001452:     	callq	0x180003005 <numba_list_iter_next+0x315>
180001457:     	jmp	0x1800014bc <.text+0x4bc>
180001459:     	movq	0x2dc8(%rip), %rcx      # 0x180004228
180001460:     	leaq	0x3099(%rip), %rdx      # 0x180004500
180001467:     	callq	0x180003005 <numba_list_iter_next+0x315>
18000146c:     	jmp	0x1800014b4 <.text+0x4b4>
18000146e:     	movq	%rsi, %rdi
180001471:     	xorl	%r12d, %r12d
180001474:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
180001479:     	testq	%rax, %rax
18000147c:     	je	0x180001332 <.text+0x332>
180001482:     	jmp	0x1800014a7 <.text+0x4a7>
180001484:     	xorl	%r13d, %r13d
180001487:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
18000148c:     	testq	%rax, %rax
18000148f:     	je	0x180001369 <.text+0x369>
180001495:     	jmp	0x1800014a7 <.text+0x4a7>
180001497:     	xorl	%ebp, %ebp
180001499:     	callq	0x180002ff9 <numba_list_iter_next+0x309>
18000149e:     	testq	%rax, %rax
1800014a1:     	je	0x1800013a0 <.text+0x3a0>
1800014a7:     	movq	0x58(%rsp), %rcx
1800014ac:     	callq	0x180001060 <.text+0x60>
1800014b1:     	movq	%rdi, %rsi
1800014b4:     	movq	%r14, %rcx
1800014b7:     	callq	0x180001060 <.text+0x60>
1800014bc:     	movq	%rbx, %rcx
1800014bf:     	callq	0x180001060 <.text+0x60>
1800014c4:     	movq	%rsi, %rcx
1800014c7:     	callq	0x180001060 <.text+0x60>
1800014cc:     	xorl	%eax, %eax
1800014ce:     	jmp	0x1800013e8 <.text+0x3e8>
1800014d3:     	nopw	%cs:(%rax,%rax)
1800014dd:     	nopl	(%rax)
1800014e0:     	subq	$0x38, %rsp
1800014e4:     	movq	0x108(%rsp), %rdx
1800014ec:     	movq	0x120(%rsp), %r8
1800014f4:     	movq	0x128(%rsp), %r9
1800014fc:     	movq	0x130(%rsp), %rax
180001504:     	movq	%rax, 0x20(%rsp)
180001509:     	leaq	0x30(%rsp), %rcx
18000150e:     	callq	0x180001090 <.text+0x90>
180001513:     	movq	0x30(%rsp), %rax
180001518:     	addq	$0x38, %rsp
18000151c:     	retq
18000151d:     	nopl	(%rax)

0000000180001520 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193>:
180001520:     	pushq	%rsi
180001521:     	subq	$0x20, %rsp
180001525:     	leaq	0x8b14(%rip), %rcx      # 0x18000a040
18000152c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001531:     	callq	0x18000300b <numba_list_iter_next+0x31b>
180001536:     	testq	%rax, %rax
180001539:     	je	0x18000156b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x4b>
18000153b:     	leaq	0x8abe(%rip), %rdx      # 0x18000a000
180001542:     	leaq	0x3067(%rip), %r8       # 0x1800045b0
180001549:     	leaq	0x3088(%rip), %r9       # 0x1800045d8
180001550:     	movq	%rax, %rcx
180001553:     	movq	%rax, %rsi
180001556:     	callq	0x180001f30 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xa10>
18000155b:     	movl	%eax, %ecx
18000155d:     	xorl	%eax, %eax
18000155f:     	testl	%ecx, %ecx
180001561:     	cmoveq	%rsi, %rax
180001565:     	addq	$0x20, %rsp
180001569:     	popq	%rsi
18000156a:     	retq
18000156b:     	xorl	%eax, %eax
18000156d:     	addq	$0x20, %rsp
180001571:     	popq	%rsi
180001572:     	retq
180001573:     	int3
180001574:     	int3
180001575:     	int3
180001576:     	int3
180001577:     	int3
180001578:     	int3
180001579:     	int3
18000157a:     	int3
18000157b:     	int3
18000157c:     	int3
18000157d:     	int3
18000157e:     	int3
18000157f:     	int3
180001580:     	movq	%rbx, 0x8(%rsp)
180001585:     	movq	%rsi, 0x10(%rsp)
18000158a:     	pushq	%rdi
18000158b:     	subq	$0x20, %rsp
18000158f:     	movq	%rcx, %rbx
180001592:     	movq	%r8, %rdi
180001595:     	movq	0x10(%rcx), %rcx
180001599:     	movq	%rdx, %rsi
18000159c:     	testq	%rcx, %rcx
18000159f:     	je	0x1800015aa <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x8a>
1800015a1:     	movq	%r8, %rdx
1800015a4:     	callq	*%rsi
1800015a6:     	testl	%eax, %eax
1800015a8:     	jne	0x1800015cd <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xad>
1800015aa:     	movq	0x18(%rbx), %rcx
1800015ae:     	testq	%rcx, %rcx
1800015b1:     	je	0x1800015cb <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xab>
1800015b3:     	movq	%rdi, %rdx
1800015b6:     	movq	%rsi, %rax
1800015b9:     	movq	0x30(%rsp), %rbx
1800015be:     	movq	0x38(%rsp), %rsi
1800015c3:     	addq	$0x20, %rsp
1800015c7:     	popq	%rdi
1800015c8:     	jmpq	*%rax
1800015cb:     	xorl	%eax, %eax
1800015cd:     	movq	0x30(%rsp), %rbx
1800015d2:     	movq	0x38(%rsp), %rsi
1800015d7:     	addq	$0x20, %rsp
1800015db:     	popq	%rdi
1800015dc:     	retq
1800015dd:     	int3
1800015de:     	int3
1800015df:     	int3
1800015e0:     	pushq	%rbx
1800015e2:     	subq	$0x20, %rsp
1800015e6:     	movq	%rcx, %rbx
1800015e9:     	movq	0x10(%rcx), %rcx
1800015ed:     	testq	%rcx, %rcx
1800015f0:     	je	0x18000160d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xed>
1800015f2:     	movq	$0x0, 0x10(%rbx)
1800015fa:     	movl	(%rcx), %eax
1800015fc:     	testl	%eax, %eax
1800015fe:     	js	0x18000160d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xed>
180001600:     	subl	$0x1, %eax
180001603:     	movl	%eax, (%rcx)
180001605:     	jne	0x18000160d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xed>
180001607:     	callq	*0x2ba3(%rip)           # 0x1800041b0
18000160d:     	movq	0x18(%rbx), %rcx
180001611:     	testq	%rcx, %rcx
180001614:     	je	0x180001631 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x111>
180001616:     	movq	$0x0, 0x18(%rbx)
18000161e:     	movl	(%rcx), %eax
180001620:     	testl	%eax, %eax
180001622:     	js	0x180001631 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x111>
180001624:     	subl	$0x1, %eax
180001627:     	movl	%eax, (%rcx)
180001629:     	jne	0x180001631 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x111>
18000162b:     	callq	*0x2b7f(%rip)           # 0x1800041b0
180001631:     	xorl	%eax, %eax
180001633:     	addq	$0x20, %rsp
180001637:     	popq	%rbx
180001638:     	retq
180001639:     	int3
18000163a:     	int3
18000163b:     	int3
18000163c:     	int3
18000163d:     	int3
18000163e:     	int3
18000163f:     	int3
180001640:     	pushq	%rbx
180001642:     	subq	$0x20, %rsp
180001646:     	movq	%rcx, %rbx
180001649:     	callq	*0x2ba1(%rip)           # 0x1800041f0
18000164f:     	movq	0x10(%rbx), %rcx
180001653:     	testq	%rcx, %rcx
180001656:     	je	0x180001673 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x153>
180001658:     	movq	$0x0, 0x10(%rbx)
180001660:     	movl	(%rcx), %eax
180001662:     	testl	%eax, %eax
180001664:     	js	0x180001673 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x153>
180001666:     	subl	$0x1, %eax
180001669:     	movl	%eax, (%rcx)
18000166b:     	jne	0x180001673 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x153>
18000166d:     	callq	*0x2b3d(%rip)           # 0x1800041b0
180001673:     	movq	0x18(%rbx), %rcx
180001677:     	testq	%rcx, %rcx
18000167a:     	je	0x180001697 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x177>
18000167c:     	movq	$0x0, 0x18(%rbx)
180001684:     	movl	(%rcx), %eax
180001686:     	testl	%eax, %eax
180001688:     	js	0x180001697 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x177>
18000168a:     	subl	$0x1, %eax
18000168d:     	movl	%eax, (%rcx)
18000168f:     	jne	0x180001697 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x177>
180001691:     	callq	*0x2b19(%rip)           # 0x1800041b0
180001697:     	movq	0x8(%rbx), %rax
18000169b:     	movq	%rbx, %rcx
18000169e:     	addq	$0x20, %rsp
1800016a2:     	popq	%rbx
1800016a3:     	jmpq	*0x140(%rax)
1800016aa:     	int3
1800016ab:     	int3
1800016ac:     	int3
1800016ad:     	int3
1800016ae:     	int3
1800016af:     	int3
1800016b0:     	pushq	%rbx
1800016b2:     	subq	$0x30, %rsp
1800016b6:     	movq	%r8, %r10
1800016b9:     	leaq	0x58(%rsp), %rax
1800016be:     	movq	%rax, 0x28(%rsp)
1800016c3:     	leaq	0x92c6(%rip), %r9       # 0x18000a990
1800016ca:     	movq	0x2aef(%rip), %rax      # 0x1800041c0
1800016d1:     	leaq	0x3240(%rip), %r8       # 0x180004918
1800016d8:     	movq	%rdx, %r11
1800016db:     	movq	%rax, 0x20(%rsp)
1800016e0:     	movq	%rcx, %rbx
1800016e3:     	movq	%r10, %rdx
1800016e6:     	movq	%r11, %rcx
1800016e9:     	callq	*0x29f1(%rip)           # 0x1800040e0
1800016ef:     	testl	%eax, %eax
1800016f1:     	je	0x18000174c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x22c>
1800016f3:     	xorl	%r8d, %r8d
1800016f6:     	xorl	%edx, %edx
1800016f8:     	movq	%rbx, %rcx
1800016fb:     	callq	*0x2b0f(%rip)           # 0x180004210
180001701:     	movq	%rax, %rbx
180001704:     	testq	%rax, %rax
180001707:     	je	0x18000174c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x22c>
180001709:     	movq	0x58(%rsp), %rax
18000170e:     	movl	(%rax), %ecx
180001710:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001716:     	jae	0x180001721 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x201>
180001718:     	incl	%ecx
18000171a:     	movl	%ecx, (%rax)
18000171c:     	movq	0x58(%rsp), %rax
180001721:     	xorl	%ecx, %ecx
180001723:     	movq	%rax, 0x10(%rbx)
180001727:     	callq	*0x2a43(%rip)           # 0x180004170
18000172d:     	movq	%rax, 0x18(%rbx)
180001731:     	testq	%rax, %rax
180001734:     	jne	0x180001754 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x234>
180001736:     	movl	(%rbx), %eax
180001738:     	testl	%eax, %eax
18000173a:     	js	0x18000174c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x22c>
18000173c:     	subl	$0x1, %eax
18000173f:     	movl	%eax, (%rbx)
180001741:     	jne	0x18000174c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x22c>
180001743:     	movq	%rbx, %rcx
180001746:     	callq	*0x2a64(%rip)           # 0x1800041b0
18000174c:     	xorl	%eax, %eax
18000174e:     	addq	$0x30, %rsp
180001752:     	popq	%rbx
180001753:     	retq
180001754:     	movq	%rbx, %rax
180001757:     	addq	$0x30, %rsp
18000175b:     	popq	%rbx
18000175c:     	retq
18000175d:     	int3
18000175e:     	int3
18000175f:     	int3
180001760:     	movq	%rbx, 0x8(%rsp)
180001765:     	movq	%rsi, 0x10(%rsp)
18000176a:     	pushq	%rdi
18000176b:     	subq	$0x20, %rsp
18000176f:     	movq	%rcx, %rbx
180001772:     	movq	%r8, %rdi
180001775:     	movq	0x18(%rcx), %rcx
180001779:     	movq	%rdx, %rsi
18000177c:     	testq	%rcx, %rcx
18000177f:     	je	0x18000178a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x26a>
180001781:     	movq	%r8, %rdx
180001784:     	callq	*%rsi
180001786:     	testl	%eax, %eax
180001788:     	jne	0x1800017ad <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x28d>
18000178a:     	movq	0x40(%rbx), %rcx
18000178e:     	testq	%rcx, %rcx
180001791:     	je	0x1800017ab <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x28b>
180001793:     	movq	%rdi, %rdx
180001796:     	movq	%rsi, %rax
180001799:     	movq	0x30(%rsp), %rbx
18000179e:     	movq	0x38(%rsp), %rsi
1800017a3:     	addq	$0x20, %rsp
1800017a7:     	popq	%rdi
1800017a8:     	jmpq	*%rax
1800017ab:     	xorl	%eax, %eax
1800017ad:     	movq	0x30(%rsp), %rbx
1800017b2:     	movq	0x38(%rsp), %rsi
1800017b7:     	addq	$0x20, %rsp
1800017bb:     	popq	%rdi
1800017bc:     	retq
1800017bd:     	int3
1800017be:     	int3
1800017bf:     	int3
1800017c0:     	pushq	%rbx
1800017c2:     	subq	$0x20, %rsp
1800017c6:     	movq	%rcx, %rbx
1800017c9:     	callq	*0x2a21(%rip)           # 0x1800041f0
1800017cf:     	cmpq	$0x0, 0x48(%rbx)
1800017d4:     	je	0x1800017df <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x2bf>
1800017d6:     	movq	%rbx, %rcx
1800017d9:     	callq	*0x29a1(%rip)           # 0x180004180
1800017df:     	movq	0x20(%rbx), %rcx
1800017e3:     	callq	*0x29b7(%rip)           # 0x1800041a0
1800017e9:     	movq	0x38(%rbx), %rcx
1800017ed:     	callq	*0x29ad(%rip)           # 0x1800041a0
1800017f3:     	movq	0x18(%rbx), %rcx
1800017f7:     	testq	%rcx, %rcx
1800017fa:     	je	0x18000180f <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x2ef>
1800017fc:     	movl	(%rcx), %eax
1800017fe:     	testl	%eax, %eax
180001800:     	js	0x18000180f <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x2ef>
180001802:     	subl	$0x1, %eax
180001805:     	movl	%eax, (%rcx)
180001807:     	jne	0x18000180f <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x2ef>
180001809:     	callq	*0x29a1(%rip)           # 0x1800041b0
18000180f:     	movq	0x40(%rbx), %rcx
180001813:     	testq	%rcx, %rcx
180001816:     	je	0x18000182b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x30b>
180001818:     	movl	(%rcx), %eax
18000181a:     	testl	%eax, %eax
18000181c:     	js	0x18000182b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x30b>
18000181e:     	subl	$0x1, %eax
180001821:     	movl	%eax, (%rcx)
180001823:     	jne	0x18000182b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x30b>
180001825:     	callq	*0x2985(%rip)           # 0x1800041b0
18000182b:     	movq	0x8(%rbx), %rax
18000182f:     	movq	%rbx, %rcx
180001832:     	addq	$0x20, %rsp
180001836:     	popq	%rbx
180001837:     	jmpq	*0x140(%rax)
18000183e:     	int3
18000183f:     	int3
180001840:     	pushq	%rbx
180001842:     	subq	$0x20, %rsp
180001846:     	callq	*0x292c(%rip)           # 0x180004178
18000184c:     	movq	%rax, %rbx
18000184f:     	testq	%rax, %rax
180001852:     	jne	0x18000185a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x33a>
180001854:     	addq	$0x20, %rsp
180001858:     	popq	%rbx
180001859:     	retq
18000185a:     	movq	%rbx, %rcx
18000185d:     	movq	%rdi, 0x30(%rsp)
180001862:     	callq	0x180003b75 <numba_list_iter_next+0xe85>
180001867:     	leaq	0x1(%rax), %rcx
18000186b:     	callq	*0x29a7(%rip)           # 0x180004218
180001871:     	movq	%rax, %rdi
180001874:     	testq	%rax, %rax
180001877:     	jne	0x18000188c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x36c>
180001879:     	callq	*0x28b9(%rip)           # 0x180004138
18000187f:     	movq	0x30(%rsp), %rdi
180001884:     	xorl	%eax, %eax
180001886:     	addq	$0x20, %rsp
18000188a:     	popq	%rbx
18000188b:     	retq
18000188c:     	movq	%rbx, %rdx
18000188f:     	movq	%rdi, %rcx
180001892:     	callq	0x180003b6f <numba_list_iter_next+0xe7f>
180001897:     	movq	%rdi, %rax
18000189a:     	movq	0x30(%rsp), %rdi
18000189f:     	addq	$0x20, %rsp
1800018a3:     	popq	%rbx
1800018a4:     	retq
1800018a5:     	int3
1800018a6:     	int3
1800018a7:     	int3
1800018a8:     	int3
1800018a9:     	int3
1800018aa:     	int3
1800018ab:     	int3
1800018ac:     	int3
1800018ad:     	int3
1800018ae:     	int3
1800018af:     	int3
1800018b0:     	movq	0x18(%rcx), %rcx
1800018b4:     	movq	%rdx, %rax
1800018b7:     	testq	%rcx, %rcx
1800018ba:     	je	0x1800018c2 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x3a2>
1800018bc:     	movq	%r8, %rdx
1800018bf:     	jmpq	*%rax
1800018c2:     	xorl	%eax, %eax
1800018c4:     	retq
1800018c5:     	int3
1800018c6:     	int3
1800018c7:     	int3
1800018c8:     	int3
1800018c9:     	int3
1800018ca:     	int3
1800018cb:     	int3
1800018cc:     	int3
1800018cd:     	int3
1800018ce:     	int3
1800018cf:     	int3
1800018d0:     	movq	%rbx, 0x8(%rsp)
1800018d5:     	pushq	%rdi
1800018d6:     	subq	$0x20, %rsp
1800018da:     	movq	0x28(%rcx), %rax
1800018de:     	xorl	%edi, %edi
1800018e0:     	movq	%rcx, %rbx
1800018e3:     	testq	%rax, %rax
1800018e6:     	je	0x1800018f2 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x3d2>
1800018e8:     	addq	$0x38, %rcx
1800018ec:     	callq	*%rax
1800018ee:     	movq	%rdi, 0x28(%rbx)
1800018f2:     	movq	0x18(%rbx), %rcx
1800018f6:     	testq	%rcx, %rcx
1800018f9:     	je	0x180001912 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x3f2>
1800018fb:     	movq	%rdi, 0x18(%rbx)
1800018ff:     	movl	(%rcx), %eax
180001901:     	testl	%eax, %eax
180001903:     	js	0x180001912 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x3f2>
180001905:     	subl	$0x1, %eax
180001908:     	movl	%eax, (%rcx)
18000190a:     	jne	0x180001912 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x3f2>
18000190c:     	callq	*0x289e(%rip)           # 0x1800041b0
180001912:     	movq	%rdi, 0x20(%rbx)
180001916:     	xorl	%eax, %eax
180001918:     	movq	0x30(%rsp), %rbx
18000191d:     	addq	$0x20, %rsp
180001921:     	popq	%rdi
180001922:     	retq
180001923:     	int3
180001924:     	int3
180001925:     	int3
180001926:     	int3
180001927:     	int3
180001928:     	int3
180001929:     	int3
18000192a:     	int3
18000192b:     	int3
18000192c:     	int3
18000192d:     	int3
18000192e:     	int3
18000192f:     	int3
180001930:     	pushq	%rbx
180001932:     	subq	$0x20, %rsp
180001936:     	movq	%rcx, %rbx
180001939:     	callq	*0x28b1(%rip)           # 0x1800041f0
18000193f:     	cmpq	$0x0, 0x30(%rbx)
180001944:     	je	0x18000194f <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x42f>
180001946:     	movq	%rbx, %rcx
180001949:     	callq	*0x2831(%rip)           # 0x180004180
18000194f:     	callq	*0x27db(%rip)           # 0x180004130
180001955:     	testl	%eax, %eax
180001957:     	jne	0x180001968 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x448>
180001959:     	movq	0x28(%rbx), %rax
18000195d:     	testq	%rax, %rax
180001960:     	je	0x180001968 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x448>
180001962:     	leaq	0x38(%rbx), %rcx
180001966:     	callq	*%rax
180001968:     	movq	0x18(%rbx), %rcx
18000196c:     	testq	%rcx, %rcx
18000196f:     	je	0x180001984 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x464>
180001971:     	movl	(%rcx), %eax
180001973:     	testl	%eax, %eax
180001975:     	js	0x180001984 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x464>
180001977:     	subl	$0x1, %eax
18000197a:     	movl	%eax, (%rcx)
18000197c:     	jne	0x180001984 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x464>
18000197e:     	callq	*0x282c(%rip)           # 0x1800041b0
180001984:     	movq	0x8(%rbx), %rax
180001988:     	movq	%rbx, %rcx
18000198b:     	addq	$0x20, %rsp
18000198f:     	popq	%rbx
180001990:     	jmpq	*0x140(%rax)
180001997:     	int3
180001998:     	int3
180001999:     	int3
18000199a:     	int3
18000199b:     	int3
18000199c:     	int3
18000199d:     	int3
18000199e:     	int3
18000199f:     	int3
1800019a0:     	pushq	%rdi
1800019a2:     	subq	$0x20, %rsp
1800019a6:     	cmpq	$0x0, 0x20(%rcx)
1800019ab:     	movq	%rcx, %rdi
1800019ae:     	jne	0x1800019cf <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x4af>
1800019b0:     	movq	0x2881(%rip), %rcx      # 0x180004238
1800019b7:     	leaq	0x2faa(%rip), %rdx      # 0x180004968
1800019be:     	movq	(%rcx), %rcx
1800019c1:     	callq	*0x2869(%rip)           # 0x180004230
1800019c7:     	xorl	%eax, %eax
1800019c9:     	addq	$0x20, %rsp
1800019cd:     	popq	%rdi
1800019ce:     	retq
1800019cf:     	movq	%rdi, %rdx
1800019d2:     	movq	%rbx, 0x30(%rsp)
1800019d7:     	movl	$0x1, %ecx
1800019dc:     	callq	*0x270e(%rip)           # 0x1800040f0
1800019e2:     	movq	%rax, %rbx
1800019e5:     	testq	%rax, %rax
1800019e8:     	jne	0x1800019f5 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x4d5>
1800019ea:     	movq	0x30(%rsp), %rbx
1800019ef:     	addq	$0x20, %rsp
1800019f3:     	popq	%rdi
1800019f4:     	retq
1800019f5:     	xorl	%r8d, %r8d
1800019f8:     	movq	%rbx, %rdx
1800019fb:     	movq	%rdi, %rcx
1800019fe:     	callq	*0x20(%rdi)
180001a01:     	movl	(%rbx), %ecx
180001a03:     	movq	%rax, %rdi
180001a06:     	testl	%ecx, %ecx
180001a08:     	js	0x180001a1a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x4fa>
180001a0a:     	subl	$0x1, %ecx
180001a0d:     	movl	%ecx, (%rbx)
180001a0f:     	jne	0x180001a1a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x4fa>
180001a11:     	movq	%rbx, %rcx
180001a14:     	callq	*0x2796(%rip)           # 0x1800041b0
180001a1a:     	movq	0x30(%rsp), %rbx
180001a1f:     	movq	%rdi, %rax
180001a22:     	addq	$0x20, %rsp
180001a26:     	popq	%rdi
180001a27:     	retq
180001a28:     	int3
180001a29:     	int3
180001a2a:     	int3
180001a2b:     	int3
180001a2c:     	int3
180001a2d:     	int3
180001a2e:     	int3
180001a2f:     	int3
180001a30:     	movq	%rbx, 0x8(%rsp)
180001a35:     	pushq	%rdi
180001a36:     	subq	$0x20, %rsp
180001a3a:     	movq	%r8, %rbx
180001a3d:     	callq	*0x26d5(%rip)           # 0x180004118
180001a43:     	movl	(%rbx), %ecx
180001a45:     	movl	%eax, %edi
180001a47:     	testl	%ecx, %ecx
180001a49:     	js	0x180001a5b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x53b>
180001a4b:     	subl	$0x1, %ecx
180001a4e:     	movl	%ecx, (%rbx)
180001a50:     	jne	0x180001a5b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x53b>
180001a52:     	movq	%rbx, %rcx
180001a55:     	callq	*0x2755(%rip)           # 0x1800041b0
180001a5b:     	movl	%edi, %ecx
180001a5d:     	movq	0x30(%rsp), %rbx
180001a62:     	addq	$0x20, %rsp
180001a66:     	popq	%rdi
180001a67:     	jmpq	*0x277a(%rip)           # 0x1800041e8
180001a6e:     	int3
180001a6f:     	int3
180001a70:     	movq	%rbx, 0x8(%rsp)
180001a75:     	pushq	%rdi
180001a76:     	subq	$0x20, %rsp
180001a7a:     	movl	(%rdx), %eax
180001a7c:     	movq	%rdx, %rbx
180001a7f:     	movq	%rcx, %rdi
180001a82:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001a87:     	jae	0x180001a8d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x56d>
180001a89:     	incl	%eax
180001a8b:     	movl	%eax, (%rdx)
180001a8d:     	movl	$0x30, %ecx
180001a92:     	callq	*0x9190(%rip)           # 0x18000ac28
180001a98:     	cmpb	$0x0, 0x9161(%rip)      # 0x18000ac00
180001a9f:     	je	0x180001aa9 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x589>
180001aa1:     	lock
180001aa2:     	incq	0x915f(%rip)            # 0x18000ac08
180001aa9:     	testq	%rax, %rax
180001aac:     	je	0x180001ae3 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x5c3>
180001aae:     	movl	$0x1, %ecx
180001ab3:     	leaq	-0x8a(%rip), %rdx       # 0x180001a30 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x510>
180001aba:     	xchgq	%rcx, (%rax)
180001abd:     	xorl	%ecx, %ecx
180001abf:     	movq	%rdx, 0x8(%rax)
180001ac3:     	movq	%rcx, 0x20(%rax)
180001ac7:     	movq	%rcx, 0x28(%rax)
180001acb:     	movq	%rbx, 0x10(%rax)
180001acf:     	movq	%rdi, 0x18(%rax)
180001ad3:     	cmpb	%cl, 0x9127(%rip)       # 0x18000ac00
180001ad9:     	je	0x180001ae3 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x5c3>
180001adb:     	lock
180001adc:     	incq	0x9135(%rip)            # 0x18000ac18
180001ae3:     	movq	0x30(%rsp), %rbx
180001ae8:     	addq	$0x20, %rsp
180001aec:     	popq	%rdi
180001aed:     	retq
180001aee:     	int3
180001aef:     	int3
180001af0:     	movq	%rbx, 0x8(%rsp)
180001af5:     	pushq	%rdi
180001af6:     	subq	$0x30, %rsp
180001afa:     	movq	%rcx, %rdi
180001afd:     	leaq	0x8e7c(%rip), %r9       # 0x18000a980
180001b04:     	movq	%r8, %rax
180001b07:     	leaq	0x58(%rsp), %rcx
180001b0c:     	movq	%rdx, %r10
180001b0f:     	movq	%rcx, 0x20(%rsp)
180001b14:     	movq	%r10, %rcx
180001b17:     	leaq	0x2e92(%rip), %r8       # 0x1800049b0
180001b1e:     	movq	%rax, %rdx
180001b21:     	callq	*0x25b9(%rip)           # 0x1800040e0
180001b27:     	testl	%eax, %eax
180001b29:     	je	0x180001b53 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x633>
180001b2b:     	movq	0x58(%rsp), %rcx
180001b30:     	callq	*0x25f2(%rip)           # 0x180004128
180001b36:     	movq	%rax, %rbx
180001b39:     	callq	*0x2709(%rip)           # 0x180004248
180001b3f:     	testq	%rax, %rax
180001b42:     	jne	0x180001b53 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x633>
180001b44:     	movq	%rbx, 0x10(%rdi)
180001b48:     	movq	0x40(%rsp), %rbx
180001b4d:     	addq	$0x30, %rsp
180001b51:     	popq	%rdi
180001b52:     	retq
180001b53:     	movq	0x40(%rsp), %rbx
180001b58:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001b5d:     	addq	$0x30, %rsp
180001b61:     	popq	%rdi
180001b62:     	retq
180001b63:     	int3
180001b64:     	int3
180001b65:     	int3
180001b66:     	int3
180001b67:     	int3
180001b68:     	int3
180001b69:     	int3
180001b6a:     	int3
180001b6b:     	int3
180001b6c:     	int3
180001b6d:     	int3
180001b6e:     	int3
180001b6f:     	int3
180001b70:     	subq	$0x38, %rsp
180001b74:     	movl	%r8d, %eax
180001b77:     	movq	%rdx, %r10
180001b7a:     	movq	0x10(%rcx), %r8
180001b7e:     	movq	%rcx, %rdx
180001b81:     	movl	%eax, 0x28(%rsp)
180001b85:     	movq	%r10, %rcx
180001b88:     	movl	$0x0, 0x20(%rsp)
180001b90:     	movq	0x20(%r8), %r9
180001b94:     	movq	0x18(%r8), %r8
180001b98:     	callq	*0x263a(%rip)           # 0x1800041d8
180001b9e:     	addq	$0x38, %rsp
180001ba2:     	retq
180001ba3:     	int3
180001ba4:     	int3
180001ba5:     	int3
180001ba6:     	int3
180001ba7:     	int3
180001ba8:     	int3
180001ba9:     	int3
180001baa:     	int3
180001bab:     	int3
180001bac:     	int3
180001bad:     	int3
180001bae:     	int3
180001baf:     	int3
180001bb0:     	movq	0x10(%rcx), %rax
180001bb4:     	lock
180001bb5:     	incq	(%rax)
180001bb8:     	movq	0x2621(%rip), %rax      # 0x1800041e0
180001bbf:     	retq
180001bc0:     	subq	$0x28, %rsp
180001bc4:     	movq	0x10(%rcx), %rcx
180001bc8:     	callq	0x180002ec0 <numba_list_iter_next+0x1d0>
180001bcd:     	movq	0x260c(%rip), %rax      # 0x1800041e0
180001bd4:     	addq	$0x28, %rsp
180001bd8:     	retq
180001bd9:     	int3
180001bda:     	int3
180001bdb:     	int3
180001bdc:     	int3
180001bdd:     	int3
180001bde:     	int3
180001bdf:     	int3
180001be0:     	movq	0x10(%rcx), %rcx
180001be4:     	movq	0x18(%rcx), %rcx
180001be8:     	jmpq	*0x2561(%rip)           # 0x180004150
180001bef:     	int3
180001bf0:     	subq	$0x28, %rsp
180001bf4:     	movq	0x10(%rcx), %rax
180001bf8:     	testq	%rax, %rax
180001bfb:     	je	0x180001c19 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x6f9>
180001bfd:     	cmpq	$0x0, 0x18(%rax)
180001c02:     	je	0x180001c19 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x6f9>
180001c04:     	movq	(%rax), %rcx
180001c07:     	nop
180001c08:     	cmpq	$-0x1, %rcx
180001c0c:     	je	0x180001c19 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x6f9>
180001c0e:     	addq	$0x28, %rsp
180001c12:     	jmpq	*0x24ef(%rip)           # 0x180004108
180001c19:     	movq	0x25b0(%rip), %rcx      # 0x1800041d0
180001c20:     	leaq	0x2d91(%rip), %rdx      # 0x1800049b8
180001c27:     	movq	(%rcx), %rcx
180001c2a:     	callq	*0x2600(%rip)           # 0x180004230
180001c30:     	xorl	%eax, %eax
180001c32:     	addq	$0x28, %rsp
180001c36:     	retq
180001c37:     	int3
180001c38:     	int3
180001c39:     	int3
180001c3a:     	int3
180001c3b:     	int3
180001c3c:     	int3
180001c3d:     	int3
180001c3e:     	int3
180001c3f:     	int3
180001c40:     	movq	0x10(%rcx), %rcx
180001c44:     	movq	0x28(%rcx), %rcx
180001c48:     	jmpq	*0x2501(%rip)           # 0x180004150
180001c4f:     	int3
180001c50:     	movq	0x10(%rcx), %rax
180001c54:     	movq	0x10(%rax), %rax
180001c58:     	testq	%rax, %rax
180001c5b:     	je	0x180001c6c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x74c>
180001c5d:     	movl	(%rax), %ecx
180001c5f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001c65:     	jae	0x180001c8a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x76a>
180001c67:     	incl	%ecx
180001c69:     	movl	%ecx, (%rax)
180001c6b:     	retq
180001c6c:     	movq	0x256d(%rip), %rcx      # 0x1800041e0
180001c73:     	movl	(%rcx), %eax
180001c75:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001c7a:     	jae	0x180001c87 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x767>
180001c7c:     	incl	%eax
180001c7e:     	movl	%eax, (%rcx)
180001c80:     	movq	0x2559(%rip), %rcx      # 0x1800041e0
180001c87:     	movq	%rcx, %rax
180001c8a:     	retq
180001c8b:     	int3
180001c8c:     	int3
180001c8d:     	int3
180001c8e:     	int3
180001c8f:     	int3
180001c90:     	pushq	%rbx
180001c92:     	subq	$0x20, %rsp
180001c96:     	movq	%rcx, %rbx
180001c99:     	movq	0x10(%rcx), %rcx
180001c9d:     	callq	0x180002ec0 <numba_list_iter_next+0x1d0>
180001ca2:     	movq	0x8(%rbx), %rax
180001ca6:     	movq	%rbx, %rcx
180001ca9:     	addq	$0x20, %rsp
180001cad:     	popq	%rbx
180001cae:     	jmpq	*0x140(%rax)
180001cb5:     	int3
180001cb6:     	int3
180001cb7:     	int3
180001cb8:     	int3
180001cb9:     	int3
180001cba:     	int3
180001cbb:     	int3
180001cbc:     	int3
180001cbd:     	int3
180001cbe:     	int3
180001cbf:     	int3
180001cc0:     	movq	%rdi, 0x18(%rsp)
180001cc5:     	pushq	%r14
180001cc7:     	subq	$0x20, %rsp
180001ccb:     	movq	0x8f6e(%rip), %rax      # 0x18000ac40
180001cd2:     	movq	%rdx, %r14
180001cd5:     	movq	%rcx, %rdi
180001cd8:     	movq	0x8(%rcx), %rcx
180001cdc:     	movq	0x10(%rax), %rdx
180001ce0:     	cmpq	%rdx, %rcx
180001ce3:     	je	0x180001d00 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7e0>
180001ce5:     	callq	*0x24cd(%rip)           # 0x1800041b8
180001ceb:     	testl	%eax, %eax
180001ced:     	jne	0x180001d00 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x7e0>
180001cef:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001cf4:     	movq	0x40(%rsp), %rdi
180001cf9:     	addq	$0x20, %rsp
180001cfd:     	popq	%r14
180001cff:     	retq
180001d00:     	movq	%rbx, 0x30(%rsp)
180001d05:     	movq	%rdi, %rdx
180001d08:     	movq	0x10(%rdi), %rbx
180001d0c:     	movq	%rbx, %rcx
180001d0f:     	movq	%rsi, 0x38(%rsp)
180001d14:     	movl	0x18(%rdi), %esi
180001d17:     	callq	0x180001a70 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x550>
180001d1c:     	movq	%rax, (%r14)
180001d1f:     	movq	0x8f1a(%rip), %rax      # 0x18000ac40
180001d26:     	movq	%rbx, 0x20(%r14)
180001d2a:     	movl	0x18(%rdi), %edx
180001d2d:     	movq	0x20(%rdi), %rcx
180001d31:     	callq	*0x4f0(%rax)
180001d37:     	cmpl	$0x12, 0x8f0e(%rip)     # 0x18000ac4c
180001d3e:     	movq	0x30(%rsp), %rbx
180001d43:     	movq	%rax, 0x10(%r14)
180001d47:     	movq	0x38(%rdi), %rax
180001d4b:     	jl	0x180001d53 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x833>
180001d4d:     	movq	0x28(%rax), %rax
180001d51:     	jmp	0x180001d57 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x837>
180001d53:     	movslq	0x20(%rax), %rax
180001d57:     	xorl	%r8d, %r8d
180001d5a:     	movq	%rax, 0x18(%r14)
180001d5e:     	movq	%rdi, 0x8(%r14)
180001d62:     	leaq	0x28(%r14), %rax
180001d66:     	testl	%esi, %esi
180001d68:     	jle	0x180001dab <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x88b>
180001d6a:     	nopw	(%rax,%rax)
180001d70:     	movq	0x20(%rdi), %rcx
180001d74:     	movq	(%rcx,%r8,8), %rdx
180001d78:     	incl	%r8d
180001d7b:     	movq	%rdx, (%rax)
180001d7e:     	addq	$0x8, %rax
180001d82:     	cmpl	%esi, %r8d
180001d85:     	jl	0x180001d70 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x850>
180001d87:     	xorl	%r8d, %r8d
180001d8a:     	nopw	(%rax,%rax)
180001d90:     	movq	0x28(%rdi), %rcx
180001d94:     	leaq	0x8(%rax), %rax
180001d98:     	movslq	%r8d, %rdx
180001d9b:     	incl	%r8d
180001d9e:     	movq	(%rcx,%rdx,8), %rdx
180001da2:     	movq	%rdx, -0x8(%rax)
180001da6:     	cmpl	%esi, %r8d
180001da9:     	jl	0x180001d90 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x870>
180001dab:     	movq	0x38(%rsp), %rsi
180001db0:     	xorl	%eax, %eax
180001db2:     	movq	0x40(%rsp), %rdi
180001db7:     	addq	$0x20, %rsp
180001dbb:     	popq	%r14
180001dbd:     	retq
180001dbe:     	int3
180001dbf:     	int3
180001dc0:     	pushq	%rbx
180001dc2:     	pushq	%rbp
180001dc3:     	pushq	%rsi
180001dc4:     	pushq	%rdi
180001dc5:     	subq	$0x28, %rsp
180001dc9:     	cmpq	$0x0, 0x8e7f(%rip)      # 0x18000ac50
180001dd1:     	movq	%rcx, %rbp
180001dd4:     	movslq	0x8(%rdx), %rdi
180001dd8:     	movq	(%rdx), %rsi
180001ddb:     	jne	0x180001e33 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x913>
180001ddd:     	leaq	0x2b14(%rip), %rcx      # 0x1800048f8
180001de4:     	callq	*0x241e(%rip)           # 0x180004208
180001dea:     	movq	%rax, %rbx
180001ded:     	testq	%rax, %rax
180001df0:     	je	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001df6:     	leaq	0x2b03(%rip), %rdx      # 0x180004900
180001dfd:     	movq	%rax, %rcx
180001e00:     	callq	*0x235a(%rip)           # 0x180004160
180001e06:     	movl	(%rbx), %edx
180001e08:     	movq	%rax, 0x8e41(%rip)      # 0x18000ac50
180001e0f:     	testl	%edx, %edx
180001e11:     	js	0x180001e2a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x90a>
180001e13:     	subl	$0x1, %edx
180001e16:     	movl	%edx, (%rbx)
180001e18:     	jne	0x180001e2a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x90a>
180001e1a:     	movq	%rbx, %rcx
180001e1d:     	callq	*0x238d(%rip)           # 0x1800041b0
180001e23:     	movq	0x8e26(%rip), %rax      # 0x18000ac50
180001e2a:     	testq	%rax, %rax
180001e2d:     	je	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001e33:     	movq	%rdi, %rdx
180001e36:     	movq	%rsi, %rcx
180001e39:     	callq	*0x22e1(%rip)           # 0x180004120
180001e3f:     	movq	%rax, %rdi
180001e42:     	testq	%rax, %rax
180001e45:     	je	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001e47:     	movq	0x8e02(%rip), %rcx      # 0x18000ac50
180001e4e:     	xorl	%r8d, %r8d
180001e51:     	movq	%rax, %rdx
180001e54:     	callq	*0x232e(%rip)           # 0x180004188
180001e5a:     	movl	(%rdi), %ecx
180001e5c:     	movq	%rax, %rbx
180001e5f:     	testl	%ecx, %ecx
180001e61:     	js	0x180001e73 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x953>
180001e63:     	subl	$0x1, %ecx
180001e66:     	movl	%ecx, (%rdi)
180001e68:     	jne	0x180001e73 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x953>
180001e6a:     	movq	%rdi, %rcx
180001e6d:     	callq	*0x233d(%rip)           # 0x1800041b0
180001e73:     	testq	%rbx, %rbx
180001e76:     	je	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001e78:     	movq	0x8(%rbx), %r8
180001e7c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001e87:     	jne	0x180001ec5 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x9a5>
180001e89:     	movq	0x2398(%rip), %rcx      # 0x180004228
180001e90:     	leaq	0x2c29(%rip), %rdx      # 0x180004ac0
180001e97:     	movq	0x18(%r8), %r8
180001e9b:     	movq	(%rcx), %rcx
180001e9e:     	callq	*0x2324(%rip)           # 0x1800041c8
180001ea4:     	movl	(%rbx), %eax
180001ea6:     	testl	%eax, %eax
180001ea8:     	js	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001eaa:     	subl	$0x1, %eax
180001ead:     	movl	%eax, (%rbx)
180001eaf:     	jne	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001eb1:     	movq	%rbx, %rcx
180001eb4:     	callq	*0x22f6(%rip)           # 0x1800041b0
180001eba:     	xorl	%eax, %eax
180001ebc:     	addq	$0x28, %rsp
180001ec0:     	popq	%rdi
180001ec1:     	popq	%rsi
180001ec2:     	popq	%rbp
180001ec3:     	popq	%rbx
180001ec4:     	retq
180001ec5:     	xorl	%r8d, %r8d
180001ec8:     	leaq	0x8431(%rip), %rcx      # 0x18000a300
180001ecf:     	xorl	%edx, %edx
180001ed1:     	callq	*0x2339(%rip)           # 0x180004210
180001ed7:     	movq	%rax, %rdi
180001eda:     	testq	%rax, %rax
180001edd:     	je	0x180001ea4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x984>
180001edf:     	movq	%rbp, %rcx
180001ee2:     	movq	%rbx, 0x18(%rax)
180001ee6:     	callq	*0x22bc(%rip)           # 0x1800041a8
180001eec:     	movq	%rax, 0x10(%rdi)
180001ef0:     	movq	%rax, %rcx
180001ef3:     	testq	%rax, %rax
180001ef6:     	jne	0x180001f0a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x9ea>
180001ef8:     	movl	(%rdi), %eax
180001efa:     	testl	%eax, %eax
180001efc:     	js	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001efe:     	subl	$0x1, %eax
180001f01:     	movl	%eax, (%rdi)
180001f03:     	jne	0x180001eba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x99a>
180001f05:     	movq	%rdi, %rcx
180001f08:     	jmp	0x180001eb4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x994>
180001f0a:     	movl	(%rax), %eax
180001f0c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001f11:     	jae	0x180001f17 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x9f7>
180001f13:     	incl	%eax
180001f15:     	movl	%eax, (%rcx)
180001f17:     	movq	%rdi, %rax
180001f1a:     	addq	$0x28, %rsp
180001f1e:     	popq	%rdi
180001f1f:     	popq	%rsi
180001f20:     	popq	%rbp
180001f21:     	popq	%rbx
180001f22:     	retq
180001f23:     	int3
180001f24:     	int3
180001f25:     	int3
180001f26:     	int3
180001f27:     	int3
180001f28:     	int3
180001f29:     	int3
180001f2a:     	int3
180001f2b:     	int3
180001f2c:     	int3
180001f2d:     	int3
180001f2e:     	int3
180001f2f:     	int3
180001f30:     	movq	%r9, 0x20(%rsp)
180001f35:     	movq	%r8, 0x18(%rsp)
180001f3a:     	movq	%rdx, 0x10(%rsp)
180001f3f:     	movq	%rcx, 0x8(%rsp)
180001f44:     	pushq	%rbx
180001f45:     	pushq	%rbp
180001f46:     	pushq	%rsi
180001f47:     	pushq	%rdi
180001f48:     	pushq	%r12
180001f4a:     	pushq	%r13
180001f4c:     	pushq	%r14
180001f4e:     	pushq	%r15
180001f50:     	subq	$0x68, %rsp
180001f54:     	movq	%rcx, %r14
180001f57:     	movq	%r9, %r15
180001f5a:     	leaq	0x269f(%rip), %rcx      # 0x180004600
180001f61:     	movq	%r8, %r13
180001f64:     	movq	%rdx, %rsi
180001f67:     	callq	*0x229b(%rip)           # 0x180004208
180001f6d:     	movq	%rax, %rdi
180001f70:     	testq	%rax, %rax
180001f73:     	jne	0x180001fac <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xa8c>
180001f75:     	movq	0x2194(%rip), %rcx      # 0x180004110
180001f7c:     	movq	(%rcx), %rcx
180001f7f:     	callq	*0x2213(%rip)           # 0x180004198
180001f85:     	testl	%eax, %eax
180001f87:     	je	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180001f8d:     	callq	*0x21c5(%rip)           # 0x180004158
180001f93:     	leaq	0x2686(%rip), %rcx      # 0x180004620
180001f9a:     	callq	*0x2268(%rip)           # 0x180004208
180001fa0:     	movq	%rax, %rdi
180001fa3:     	testq	%rax, %rax
180001fa6:     	je	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180001fac:     	leaq	0x268d(%rip), %rdx      # 0x180004640
180001fb3:     	movq	%rdi, %rcx
180001fb6:     	callq	*0x21a4(%rip)           # 0x180004160
180001fbc:     	movl	(%rdi), %ecx
180001fbe:     	movq	%rax, %rbx
180001fc1:     	testl	%ecx, %ecx
180001fc3:     	js	0x180001fd5 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xab5>
180001fc5:     	subl	$0x1, %ecx
180001fc8:     	movl	%ecx, (%rdi)
180001fca:     	jne	0x180001fd5 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xab5>
180001fcc:     	movq	%rdi, %rcx
180001fcf:     	callq	*0x21db(%rip)           # 0x1800041b0
180001fd5:     	testq	%rbx, %rbx
180001fd8:     	je	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180001fde:     	movq	0x2103(%rip), %rax      # 0x1800040e8
180001fe5:     	cmpq	%rax, 0x8(%rbx)
180001fe9:     	je	0x180002025 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb05>
180001feb:     	movq	0x2246(%rip), %rcx      # 0x180004238
180001ff2:     	leaq	0x2657(%rip), %rdx      # 0x180004650
180001ff9:     	movq	(%rcx), %rcx
180001ffc:     	callq	*0x222e(%rip)           # 0x180004230
180002002:     	movl	(%rbx), %eax
180002004:     	testl	%eax, %eax
180002006:     	js	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
18000200c:     	subl	$0x1, %eax
18000200f:     	movl	%eax, (%rbx)
180002011:     	jne	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180002017:     	movq	%rbx, %rcx
18000201a:     	callq	*0x2190(%rip)           # 0x1800041b0
180002020:     	jmp	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180002025:     	xorl	%edx, %edx
180002027:     	movq	%rbx, %rcx
18000202a:     	callq	*0x2160(%rip)           # 0x180004190
180002030:     	movl	(%rbx), %ecx
180002032:     	movq	%rax, 0x8c07(%rip)      # 0x18000ac40
180002039:     	testl	%ecx, %ecx
18000203b:     	js	0x180002054 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb34>
18000203d:     	subl	$0x1, %ecx
180002040:     	movl	%ecx, (%rbx)
180002042:     	jne	0x180002054 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb34>
180002044:     	movq	%rbx, %rcx
180002047:     	callq	*0x2163(%rip)           # 0x1800041b0
18000204d:     	movq	0x8bec(%rip), %rax      # 0x18000ac40
180002054:     	testq	%rax, %rax
180002057:     	jne	0x180002072 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb52>
180002059:     	leaq	0x2618(%rip), %rdx      # 0x180004678
180002060:     	movq	0x21d1(%rip), %rcx      # 0x180004238
180002067:     	movq	(%rcx), %rcx
18000206a:     	callq	*0x21c0(%rip)           # 0x180004230
180002070:     	jmp	0x1800020a7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb87>
180002072:     	callq	*(%rax)
180002074:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180002079:     	jbe	0x1800020da <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xbba>
18000207b:     	movq	0x21b6(%rip), %rax      # 0x180004238
180002082:     	movq	(%rax), %rbx
180002085:     	movq	0x8bb4(%rip), %rax      # 0x18000ac40
18000208c:     	callq	*(%rax)
18000208e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002094:     	leaq	0x2605(%rip), %rdx      # 0x1800046a0
18000209b:     	movl	%eax, %r9d
18000209e:     	movq	%rbx, %rcx
1800020a1:     	callq	*0x2121(%rip)           # 0x1800041c8
1800020a7:     	callq	*0x21bb(%rip)           # 0x180004268
1800020ad:     	movq	0x2044(%rip), %rcx      # 0x1800040f8
1800020b4:     	leaq	0x280d(%rip), %rdx      # 0x1800048c8
1800020bb:     	movq	(%rcx), %rcx
1800020be:     	callq	*0x216c(%rip)           # 0x180004230
1800020c4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800020c9:     	addq	$0x68, %rsp
1800020cd:     	popq	%r15
1800020cf:     	popq	%r14
1800020d1:     	popq	%r13
1800020d3:     	popq	%r12
1800020d5:     	popq	%rdi
1800020d6:     	popq	%rsi
1800020d7:     	popq	%rbp
1800020d8:     	popq	%rbx
1800020d9:     	retq
1800020da:     	movq	0x8b5f(%rip), %rax      # 0x18000ac40
1800020e1:     	callq	*0x698(%rax)
1800020e7:     	movl	%eax, 0x8b5f(%rip)      # 0x18000ac4c
1800020ed:     	cmpl	$0x10, %eax
1800020f0:     	jge	0x18000210e <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xbee>
1800020f2:     	movq	0x213f(%rip), %rcx      # 0x180004238
1800020f9:     	leaq	0x25f0(%rip), %rdx      # 0x1800046f0
180002100:     	movl	%eax, %r9d
180002103:     	movl	$0x10, %r8d
180002109:     	movq	(%rcx), %rcx
18000210c:     	jmp	0x1800020a1 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb81>
18000210e:     	movq	0x8b2b(%rip), %rax      # 0x18000ac40
180002115:     	callq	*0x690(%rax)
18000211b:     	testl	%eax, %eax
18000211d:     	jne	0x18000212b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xc0b>
18000211f:     	leaq	0x271a(%rip), %rdx      # 0x180004840
180002126:     	jmp	0x180002060 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb40>
18000212b:     	cmpl	$0x1, %eax
18000212e:     	je	0x18000213c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xc1c>
180002130:     	leaq	0x2739(%rip), %rdx      # 0x180004870
180002137:     	jmp	0x180002060 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xb40>
18000213c:     	leaq	0x869d(%rip), %rcx      # 0x18000a7e0
180002143:     	callq	*0x201f(%rip)           # 0x180004168
180002149:     	testl	%eax, %eax
18000214b:     	jne	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
180002151:     	leaq	0x81a8(%rip), %rcx      # 0x18000a300
180002158:     	callq	*0x200a(%rip)           # 0x180004168
18000215e:     	testl	%eax, %eax
180002160:     	jne	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
180002166:     	leaq	0x84d3(%rip), %rcx      # 0x18000a640
18000216d:     	callq	*0x1ff5(%rip)           # 0x180004168
180002173:     	testl	%eax, %eax
180002175:     	jne	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
18000217b:     	xorl	%ebx, %ebx
18000217d:     	cmpl	%ebx, 0x8ac5(%rip)      # 0x18000ac48
180002183:     	jne	0x1800021c6 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xca6>
180002185:     	movq	%gs:0x58, %rax
18000218e:     	movl	0x8ac4(%rip), %ecx      # 0x18000ac58
180002194:     	movl	$0x1, 0x8aaa(%rip)      # 0x18000ac48
18000219e:     	movq	(%rax,%rcx,8), %rdx
1800021a2:     	movl	$0x10, %eax
1800021a7:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800021ae:     	movl	$0x9f0, %eax            # imm = 0x9F0
1800021b3:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800021ba:     	movl	$0x13d0, %eax           # imm = 0x13D0
1800021bf:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800021c6:     	movl	%ebx, 0x8a2c(%rip)      # 0x18000abf8
1800021cc:     	movq	%rbx, %rax
1800021cf:     	movb	%bl, 0x8a2b(%rip)       # 0x18000ac00
1800021d5:     	movq	%rbx, %rcx
1800021d8:     	xchgq	%rax, 0x8a29(%rip)      # 0x18000ac08
1800021df:     	xchgq	%rcx, 0x8a2a(%rip)      # 0x18000ac10
1800021e6:     	movq	%rbx, %rax
1800021e9:     	movq	%rbx, %rcx
1800021ec:     	xchgq	%rax, 0x8a25(%rip)      # 0x18000ac18
1800021f3:     	xchgq	%rcx, 0x8a26(%rip)      # 0x18000ac20
1800021fa:     	movq	0x1e5f(%rip), %rax      # 0x180004060
180002201:     	leaq	0x8298(%rip), %rcx      # 0x18000a4a0
180002208:     	movq	%rax, 0x8a19(%rip)      # 0x18000ac28
18000220f:     	movq	0x1e5a(%rip), %rax      # 0x180004070
180002216:     	movq	%rax, 0x8a13(%rip)      # 0x18000ac30
18000221d:     	movq	0x1e44(%rip), %rax      # 0x180004068
180002224:     	movq	%rax, 0x8a0d(%rip)      # 0x18000ac38
18000222b:     	movq	0x1fde(%rip), %rax      # 0x180004210
180002232:     	movq	%rax, 0x839f(%rip)      # 0x18000a5d8
180002239:     	callq	*0x1f29(%rip)           # 0x180004168
18000223f:     	testl	%eax, %eax
180002241:     	jne	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
180002247:     	leaq	0x270a(%rip), %rdx      # 0x180004958
18000224e:     	movq	%r14, %rcx
180002251:     	callq	*0x1f09(%rip)           # 0x180004160
180002257:     	movq	%rax, 0x28(%rsp)
18000225c:     	movq	%rax, %rdi
18000225f:     	testq	%rax, %rax
180002262:     	je	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
180002268:     	leaq	0x2882(%rip), %rcx      # 0x180004af1
18000226f:     	callq	*0x1e8b(%rip)           # 0x180004100
180002275:     	movq	%rax, 0x20(%rsp)
18000227a:     	movq	%rax, %r12
18000227d:     	testq	%rax, %rax
180002280:     	je	0x1800025c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x10a4>
180002286:     	movl	%ebx, %ebp
180002288:     	cmpq	%rbx, (%rsi)
18000228b:     	je	0x180002434 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xf14>
180002291:     	movslq	%ebp, %rbx
180002294:     	leaq	0x30(%rsp), %rdx
180002299:     	movq	%r14, %rcx
18000229c:     	leaq	(%rbx,%rbx,4), %rax
1800022a0:     	movups	(%r13,%rax,8), %xmm0
1800022a6:     	movups	0x10(%r13,%rax,8), %xmm1
1800022ac:     	movaps	%xmm0, 0x30(%rsp)
1800022b1:     	movsd	0x20(%r13,%rax,8), %xmm0
1800022b8:     	movsd	%xmm0, 0x50(%rsp)
1800022be:     	movaps	%xmm1, 0x40(%rsp)
1800022c3:     	callq	0x180001dc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x8a0>
1800022c8:     	movq	%rax, %r14
1800022cb:     	testq	%rax, %rax
1800022ce:     	je	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
1800022d4:     	movq	(%rsi), %rcx
1800022d7:     	callq	*0x1e23(%rip)           # 0x180004100
1800022dd:     	movq	%rax, %r13
1800022e0:     	testq	%rax, %rax
1800022e3:     	je	0x1800025e7 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x10c7>
1800022e9:     	movq	(%r15,%rbx,8), %rcx
1800022ed:     	xorl	%edx, %edx
1800022ef:     	movq	%r14, (%rcx)
1800022f2:     	leaq	0x84e7(%rip), %rcx      # 0x18000a7e0
1800022f9:     	movq	0x8(%rsi), %r12
1800022fd:     	callq	*0x1e45(%rip)           # 0x180004148
180002303:     	movq	%rax, %rbx
180002306:     	testq	%rax, %rax
180002309:     	je	0x180002386 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe66>
18000230b:     	movq	%r13, %rcx
18000230e:     	callq	*0x1e64(%rip)           # 0x180004178
180002314:     	movq	%rax, %rdi
180002317:     	testq	%rax, %rax
18000231a:     	je	0x18000233c <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe1c>
18000231c:     	movq	%rax, %rcx
18000231f:     	callq	0x180003b75 <numba_list_iter_next+0xe85>
180002324:     	leaq	0x1(%rax), %rcx
180002328:     	callq	*0x1eea(%rip)           # 0x180004218
18000232e:     	movq	%rax, %rsi
180002331:     	testq	%rax, %rax
180002334:     	jne	0x180002344 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe24>
180002336:     	callq	*0x1dfc(%rip)           # 0x180004138
18000233c:     	xorl	%eax, %eax
18000233e:     	movq	%rax, 0x20(%rbx)
180002342:     	jmp	0x180002375 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe55>
180002344:     	movq	%rdi, %rdx
180002347:     	movq	%rsi, %rcx
18000234a:     	callq	0x180003b6f <numba_list_iter_next+0xe7f>
18000234f:     	movq	0x20(%rsp), %rcx
180002354:     	movq	%rsi, 0x20(%rbx)
180002358:     	movq	%r12, 0x28(%rbx)
18000235c:     	movl	$0x3, 0x30(%rbx)
180002363:     	callq	0x180001840 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x320>
180002368:     	movq	%rax, 0x38(%rbx)
18000236c:     	testq	%rax, %rax
18000236f:     	jne	0x1800024e0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfc0>
180002375:     	movl	(%rbx), %eax
180002377:     	testl	%eax, %eax
180002379:     	js	0x180002386 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe66>
18000237b:     	subl	$0x1, %eax
18000237e:     	movl	%eax, (%rbx)
180002380:     	je	0x18000252d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x100d>
180002386:     	xorl	%edi, %edi
180002388:     	movl	(%r14), %eax
18000238b:     	testl	%eax, %eax
18000238d:     	js	0x1800023a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe80>
18000238f:     	subl	$0x1, %eax
180002392:     	movl	%eax, (%r14)
180002395:     	jne	0x1800023a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe80>
180002397:     	movq	%r14, %rcx
18000239a:     	callq	*0x1e10(%rip)           # 0x1800041b0
1800023a0:     	movl	(%r13), %eax
1800023a4:     	testl	%eax, %eax
1800023a6:     	js	0x1800023ba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe9a>
1800023a8:     	subl	$0x1, %eax
1800023ab:     	movl	%eax, (%r13)
1800023af:     	jne	0x1800023ba <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe9a>
1800023b1:     	movq	%r13, %rcx
1800023b4:     	callq	*0x1df6(%rip)           # 0x1800041b0
1800023ba:     	testq	%rdi, %rdi
1800023bd:     	je	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
1800023c3:     	movq	0xb8(%rsp), %rsi
1800023cb:     	movq	%rdi, %r8
1800023ce:     	movq	0xb0(%rsp), %r14
1800023d6:     	movq	%r14, %rcx
1800023d9:     	movq	(%rsi), %rdx
1800023dc:     	callq	*0x1e16(%rip)           # 0x1800041f8
1800023e2:     	movl	(%rdi), %ecx
1800023e4:     	testl	%eax, %eax
1800023e6:     	jne	0x18000258a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x106a>
1800023ec:     	testl	%ecx, %ecx
1800023ee:     	js	0x180002402 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xee2>
1800023f0:     	leal	-0x1(%rcx), %eax
1800023f3:     	movl	%eax, (%rdi)
1800023f5:     	testl	%eax, %eax
1800023f7:     	jne	0x180002402 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xee2>
1800023f9:     	movq	%rdi, %rcx
1800023fc:     	callq	*0x1dae(%rip)           # 0x1800041b0
180002402:     	movq	0xc8(%rsp), %r15
18000240a:     	addq	$0x20, %rsi
18000240e:     	movq	0xc0(%rsp), %r13
180002416:     	incl	%ebp
180002418:     	movq	%rsi, 0xb8(%rsp)
180002420:     	cmpq	$0x0, (%rsi)
180002424:     	jne	0x180002291 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xd71>
18000242a:     	movq	0x20(%rsp), %r12
18000242f:     	movq	0x28(%rsp), %rdi
180002434:     	movslq	%ebp, %rax
180002437:     	cmpq	$0x0, (%r15,%rax,8)
18000243c:     	je	0x1800024a9 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xf89>
18000243e:     	nop
180002440:     	movslq	%ebp, %rbx
180002443:     	leaq	0x30(%rsp), %rdx
180002448:     	movq	%r14, %rcx
18000244b:     	leaq	(%rbx,%rbx,4), %rax
18000244f:     	movups	(%r13,%rax,8), %xmm0
180002455:     	movups	0x10(%r13,%rax,8), %xmm1
18000245b:     	movaps	%xmm0, 0x30(%rsp)
180002460:     	movsd	0x20(%r13,%rax,8), %xmm0
180002467:     	movsd	%xmm0, 0x50(%rsp)
18000246d:     	movaps	%xmm1, 0x40(%rsp)
180002472:     	callq	0x180001dc0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x8a0>
180002477:     	testq	%rax, %rax
18000247a:     	je	0x1800025a5 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1085>
180002480:     	movq	(%r15,%rbx,8), %rcx
180002484:     	movq	%rax, (%rcx)
180002487:     	movl	(%rax), %ecx
180002489:     	testl	%ecx, %ecx
18000248b:     	js	0x18000249d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xf7d>
18000248d:     	subl	$0x1, %ecx
180002490:     	movl	%ecx, (%rax)
180002492:     	jne	0x18000249d <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xf7d>
180002494:     	movq	%rax, %rcx
180002497:     	callq	*0x1d13(%rip)           # 0x1800041b0
18000249d:     	incl	%ebp
18000249f:     	movslq	%ebp, %rax
1800024a2:     	cmpq	$0x0, (%r15,%rax,8)
1800024a7:     	jne	0x180002440 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xf20>
1800024a9:     	movl	(%r12), %eax
1800024ad:     	testl	%eax, %eax
1800024af:     	js	0x1800024c3 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfa3>
1800024b1:     	subl	$0x1, %eax
1800024b4:     	movl	%eax, (%r12)
1800024b8:     	jne	0x1800024c3 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfa3>
1800024ba:     	movq	%r12, %rcx
1800024bd:     	callq	*0x1ced(%rip)           # 0x1800041b0
1800024c3:     	movl	(%rdi), %eax
1800024c5:     	testl	%eax, %eax
1800024c7:     	js	0x1800024d9 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfb9>
1800024c9:     	subl	$0x1, %eax
1800024cc:     	movl	%eax, (%rdi)
1800024ce:     	jne	0x1800024d9 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfb9>
1800024d0:     	movq	%rdi, %rcx
1800024d3:     	callq	*0x1cd7(%rip)           # 0x1800041b0
1800024d9:     	xorl	%eax, %eax
1800024db:     	jmp	0x1800020c9 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba9>
1800024e0:     	movl	(%r14), %eax
1800024e3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800024e8:     	jae	0x1800024ef <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xfcf>
1800024ea:     	incl	%eax
1800024ec:     	movl	%eax, (%r14)
1800024ef:     	movq	0xb0(%rsp), %rcx
1800024f7:     	leaq	0x245a(%rip), %rdx      # 0x180004958
1800024fe:     	movq	%r14, 0x18(%rbx)
180002502:     	movq	$0x0, 0x40(%rbx)
18000250a:     	callq	*0x1c50(%rip)           # 0x180004160
180002510:     	movq	%rax, %rsi
180002513:     	testq	%rax, %rax
180002516:     	jne	0x18000253b <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x101b>
180002518:     	movl	(%rbx), %eax
18000251a:     	testl	%eax, %eax
18000251c:     	js	0x180002386 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe66>
180002522:     	subl	$0x1, %eax
180002525:     	movl	%eax, (%rbx)
180002527:     	jne	0x180002386 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe66>
18000252d:     	movq	%rbx, %rcx
180002530:     	callq	*0x1c7a(%rip)           # 0x1800041b0
180002536:     	jmp	0x180002386 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe66>
18000253b:     	xorl	%r9d, %r9d
18000253e:     	leaq	0x20(%rbx), %rcx
180002542:     	movq	%rsi, %r8
180002545:     	movq	%rbx, %rdx
180002548:     	callq	*0x1bf2(%rip)           # 0x180004140
18000254e:     	movq	%rax, %rdi
180002551:     	movl	(%rbx), %eax
180002553:     	testl	%eax, %eax
180002555:     	js	0x180002567 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1047>
180002557:     	subl	$0x1, %eax
18000255a:     	movl	%eax, (%rbx)
18000255c:     	jne	0x180002567 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1047>
18000255e:     	movq	%rbx, %rcx
180002561:     	callq	*0x1c49(%rip)           # 0x1800041b0
180002567:     	movl	(%rsi), %eax
180002569:     	testl	%eax, %eax
18000256b:     	js	0x180002388 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe68>
180002571:     	subl	$0x1, %eax
180002574:     	movl	%eax, (%rsi)
180002576:     	jne	0x180002388 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe68>
18000257c:     	movq	%rsi, %rcx
18000257f:     	callq	*0x1c2b(%rip)           # 0x1800041b0
180002585:     	jmp	0x180002388 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xe68>
18000258a:     	testl	%ecx, %ecx
18000258c:     	js	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
18000258e:     	leal	-0x1(%rcx), %eax
180002591:     	movl	%eax, (%rdi)
180002593:     	testl	%eax, %eax
180002595:     	jne	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
180002597:     	movq	%rdi, %rcx
18000259a:     	callq	*0x1c10(%rip)           # 0x1800041b0
1800025a0:     	movq	0x20(%rsp), %r12
1800025a5:     	movl	(%r12), %eax
1800025a9:     	testl	%eax, %eax
1800025ab:     	js	0x1800025bf <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x109f>
1800025ad:     	subl	$0x1, %eax
1800025b0:     	movl	%eax, (%r12)
1800025b4:     	jne	0x1800025bf <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x109f>
1800025b6:     	movq	%r12, %rcx
1800025b9:     	callq	*0x1bf1(%rip)           # 0x1800041b0
1800025bf:     	movq	0x28(%rsp), %rdi
1800025c4:     	movl	(%rdi), %eax
1800025c6:     	testl	%eax, %eax
1800025c8:     	js	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
1800025ce:     	subl	$0x1, %eax
1800025d1:     	movl	%eax, (%rdi)
1800025d3:     	jne	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
1800025d9:     	movq	%rdi, %rcx
1800025dc:     	callq	*0x1bce(%rip)           # 0x1800041b0
1800025e2:     	jmp	0x1800020c4 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0xba4>
1800025e7:     	movl	(%r14), %eax
1800025ea:     	testl	%eax, %eax
1800025ec:     	js	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
1800025ee:     	subl	$0x1, %eax
1800025f1:     	movl	%eax, (%r14)
1800025f4:     	jne	0x1800025a0 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x1080>
1800025f6:     	movq	%r14, %rcx
1800025f9:     	jmp	0x18000259a <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x107a>
1800025fb:     	int3
1800025fc:     	int3
1800025fd:     	int3
1800025fe:     	int3
1800025ff:     	int3
180002600:     	leaq	0x8669(%rip), %rax      # 0x18000ac70
180002607:     	retq
180002608:     	int3
180002609:     	int3
18000260a:     	int3
18000260b:     	int3
18000260c:     	int3
18000260d:     	int3
18000260e:     	int3
18000260f:     	int3

0000000180002610 <numba_list_set_method_table>:
180002610:     	movups	(%rdx), %xmm0
180002613:     	movups	%xmm0, 0x20(%rcx)
180002617:     	retq
180002618:     	int3
180002619:     	int3
18000261a:     	int3
18000261b:     	int3
18000261c:     	int3
18000261d:     	int3
18000261e:     	int3
18000261f:     	int3

0000000180002620 <numba_list_new>:
180002620:     	pushq	%rbx
180002622:     	pushq	%rbp
180002623:     	pushq	%rsi
180002624:     	pushq	%rdi
180002625:     	subq	$0x28, %rsp
180002629:     	movq	%rcx, %rsi
18000262c:     	movq	%r8, %rdi
18000262f:     	movl	$0x38, %ecx
180002634:     	movq	%rdx, %rbp
180002637:     	callq	*0x1a23(%rip)           # 0x180004060
18000263d:     	movq	%rax, %rbx
180002640:     	testq	%rax, %rax
180002643:     	je	0x1800026ad <numba_list_new+0x8d>
180002645:     	movq	$0x0, (%rax)
18000264c:     	xorps	%xmm0, %xmm0
18000264f:     	movq	%rbp, 0x8(%rax)
180002653:     	movq	%rdi, 0x10(%rax)
180002657:     	movl	$0x1, 0x18(%rax)
18000265e:     	movups	%xmm0, 0x20(%rax)
180002662:     	testq	%rdi, %rdi
180002665:     	je	0x1800026bb <numba_list_new+0x9b>
180002667:     	imulq	%rbp, %rdi
18000266b:     	movl	$0x8, %ecx
180002670:     	movq	%rdi, %rax
180002673:     	cqto
180002675:     	andl	$0x7, %edx
180002678:     	addq	%rdx, %rax
18000267b:     	andl	$0x7, %eax
18000267e:     	subq	%rdx, %rax
180002681:     	subq	%rax, %rcx
180002684:     	movq	%rcx, %rax
180002687:     	cqto
180002689:     	andl	$0x7, %edx
18000268c:     	leaq	(%rdx,%rax), %rcx
180002690:     	andl	$0x7, %ecx
180002693:     	subq	%rdx, %rcx
180002696:     	addq	%rdi, %rcx
180002699:     	callq	*0x19c1(%rip)           # 0x180004060
18000269f:     	testq	%rax, %rax
1800026a2:     	jne	0x1800026bd <numba_list_new+0x9d>
1800026a4:     	movq	%rbx, %rcx
1800026a7:     	callq	*0x19bb(%rip)           # 0x180004068
1800026ad:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800026b2:     	addq	$0x28, %rsp
1800026b6:     	popq	%rdi
1800026b7:     	popq	%rsi
1800026b8:     	popq	%rbp
1800026b9:     	popq	%rbx
1800026ba:     	retq
1800026bb:     	xorl	%eax, %eax
1800026bd:     	movq	%rax, 0x30(%rbx)
1800026c1:     	xorl	%eax, %eax
1800026c3:     	movq	%rbx, (%rsi)
1800026c6:     	addq	$0x28, %rsp
1800026ca:     	popq	%rdi
1800026cb:     	popq	%rsi
1800026cc:     	popq	%rbp
1800026cd:     	popq	%rbx
1800026ce:     	retq
1800026cf:     	int3

00000001800026d0 <numba_list_free>:
1800026d0:     	pushq	%rbx
1800026d2:     	subq	$0x20, %rsp
1800026d6:     	cmpq	$0x0, 0x28(%rcx)
1800026db:     	movq	%rcx, %rbx
1800026de:     	je	0x180002714 <numba_list_free+0x44>
1800026e0:     	movq	%rdi, 0x30(%rsp)
1800026e5:     	xorl	%edi, %edi
1800026e7:     	cmpq	%rdi, (%rcx)
1800026ea:     	jle	0x18000270f <numba_list_free+0x3f>
1800026ec:     	nopl	(%rax)
1800026f0:     	movq	0x28(%rbx), %rax
1800026f4:     	testq	%rax, %rax
1800026f7:     	je	0x180002707 <numba_list_free+0x37>
1800026f9:     	movq	%rdi, %rcx
1800026fc:     	imulq	0x8(%rbx), %rcx
180002701:     	addq	0x30(%rbx), %rcx
180002705:     	callq	*%rax
180002707:     	incq	%rdi
18000270a:     	cmpq	(%rbx), %rdi
18000270d:     	jl	0x1800026f0 <numba_list_free+0x20>
18000270f:     	movq	0x30(%rsp), %rdi
180002714:     	movq	0x30(%rbx), %rcx
180002718:     	testq	%rcx, %rcx
18000271b:     	je	0x180002723 <numba_list_free+0x53>
18000271d:     	callq	*0x1945(%rip)           # 0x180004068
180002723:     	movq	%rbx, %rcx
180002726:     	addq	$0x20, %rsp
18000272a:     	popq	%rbx
18000272b:     	jmpq	*0x1936(%rip)           # 0x180004068
180002732:     	int3
180002733:     	int3
180002734:     	int3
180002735:     	int3
180002736:     	int3
180002737:     	int3
180002738:     	int3
180002739:     	int3
18000273a:     	int3
18000273b:     	int3
18000273c:     	int3
18000273d:     	int3
18000273e:     	int3
18000273f:     	int3

0000000180002740 <numba_list_base_ptr>:
180002740:     	movq	0x30(%rcx), %rax
180002744:     	retq
180002745:     	int3
180002746:     	int3
180002747:     	int3
180002748:     	int3
180002749:     	int3
18000274a:     	int3
18000274b:     	int3
18000274c:     	int3
18000274d:     	int3
18000274e:     	int3
18000274f:     	int3

0000000180002750 <numba_list_size_address>:
180002750:     	movq	%rcx, %rax
180002753:     	retq
180002754:     	int3
180002755:     	int3
180002756:     	int3
180002757:     	int3
180002758:     	int3
180002759:     	int3
18000275a:     	int3
18000275b:     	int3
18000275c:     	int3
18000275d:     	int3
18000275e:     	int3
18000275f:     	int3

0000000180002760 <numba_list_length>:
180002760:     	movq	(%rcx), %rax
180002763:     	retq
180002764:     	int3
180002765:     	int3
180002766:     	int3
180002767:     	int3
180002768:     	int3
180002769:     	int3
18000276a:     	int3
18000276b:     	int3
18000276c:     	int3
18000276d:     	int3
18000276e:     	int3
18000276f:     	int3

0000000180002770 <numba_list_allocated>:
180002770:     	movq	0x10(%rcx), %rax
180002774:     	retq
180002775:     	int3
180002776:     	int3
180002777:     	int3
180002778:     	int3
180002779:     	int3
18000277a:     	int3
18000277b:     	int3
18000277c:     	int3
18000277d:     	int3
18000277e:     	int3
18000277f:     	int3

0000000180002780 <numba_list_is_mutable>:
180002780:     	movl	0x18(%rcx), %eax
180002783:     	retq
180002784:     	int3
180002785:     	int3
180002786:     	int3
180002787:     	int3
180002788:     	int3
180002789:     	int3
18000278a:     	int3
18000278b:     	int3
18000278c:     	int3
18000278d:     	int3
18000278e:     	int3
18000278f:     	int3

0000000180002790 <numba_list_set_is_mutable>:
180002790:     	movl	%edx, 0x18(%rcx)
180002793:     	retq
180002794:     	int3
180002795:     	int3
180002796:     	int3
180002797:     	int3
180002798:     	int3
180002799:     	int3
18000279a:     	int3
18000279b:     	int3
18000279c:     	int3
18000279d:     	int3
18000279e:     	int3
18000279f:     	int3

00000001800027a0 <numba_list_setitem>:
1800027a0:     	movq	%rbx, 0x10(%rsp)
1800027a5:     	pushq	%rsi
1800027a6:     	subq	$0x20, %rsp
1800027aa:     	cmpl	$0x0, 0x18(%rcx)
1800027ae:     	movq	%r8, %rsi
1800027b1:     	movq	%rcx, %rbx
1800027b4:     	jne	0x1800027c6 <numba_list_setitem+0x26>
1800027b6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800027bb:     	movq	0x38(%rsp), %rbx
1800027c0:     	addq	$0x20, %rsp
1800027c4:     	popq	%rsi
1800027c5:     	retq
1800027c6:     	cmpq	(%rcx), %rdx
1800027c9:     	jb	0x1800027db <numba_list_setitem+0x3b>
1800027cb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800027d0:     	movq	0x38(%rsp), %rbx
1800027d5:     	addq	$0x20, %rsp
1800027d9:     	popq	%rsi
1800027da:     	retq
1800027db:     	imulq	0x8(%rcx), %rdx
1800027e0:     	movq	0x28(%rcx), %rax
1800027e4:     	movq	%rdi, 0x30(%rsp)
1800027e9:     	movq	0x30(%rcx), %rdi
1800027ed:     	addq	%rdx, %rdi
1800027f0:     	testq	%rax, %rax
1800027f3:     	je	0x1800027fa <numba_list_setitem+0x5a>
1800027f5:     	movq	%rdi, %rcx
1800027f8:     	callq	*%rax
1800027fa:     	movq	0x8(%rbx), %r8
1800027fe:     	movq	%rsi, %rdx
180002801:     	movq	%rdi, %rcx
180002804:     	callq	0x180003b63 <numba_list_iter_next+0xe73>
180002809:     	movq	0x20(%rbx), %rax
18000280d:     	testq	%rax, %rax
180002810:     	je	0x180002817 <numba_list_setitem+0x77>
180002812:     	movq	%rdi, %rcx
180002815:     	callq	*%rax
180002817:     	movq	0x30(%rsp), %rdi
18000281c:     	xorl	%eax, %eax
18000281e:     	movq	0x38(%rsp), %rbx
180002823:     	addq	$0x20, %rsp
180002827:     	popq	%rsi
180002828:     	retq
180002829:     	int3
18000282a:     	int3
18000282b:     	int3
18000282c:     	int3
18000282d:     	int3
18000282e:     	int3
18000282f:     	int3

0000000180002830 <numba_list_getitem>:
180002830:     	subq	$0x28, %rsp
180002834:     	movq	%r8, %r9
180002837:     	movq	%rdx, %rax
18000283a:     	cmpq	(%rcx), %rdx
18000283d:     	jb	0x180002849 <numba_list_getitem+0x19>
18000283f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002844:     	addq	$0x28, %rsp
180002848:     	retq
180002849:     	movq	0x8(%rcx), %r8
18000284d:     	movq	%r8, %rdx
180002850:     	imulq	%rax, %rdx
180002854:     	addq	0x30(%rcx), %rdx
180002858:     	movq	%r9, %rcx
18000285b:     	callq	0x180003b63 <numba_list_iter_next+0xe73>
180002860:     	xorl	%eax, %eax
180002862:     	addq	$0x28, %rsp
180002866:     	retq
180002867:     	int3
180002868:     	int3
180002869:     	int3
18000286a:     	int3
18000286b:     	int3
18000286c:     	int3
18000286d:     	int3
18000286e:     	int3
18000286f:     	int3

0000000180002870 <numba_list_append>:
180002870:     	movq	%rbx, 0x10(%rsp)
180002875:     	pushq	%rsi
180002876:     	subq	$0x20, %rsp
18000287a:     	cmpl	$0x0, 0x18(%rcx)
18000287e:     	movq	%rdx, %rsi
180002881:     	movq	%rcx, %rbx
180002884:     	jne	0x180002896 <numba_list_append+0x26>
180002886:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000288b:     	movq	0x38(%rsp), %rbx
180002890:     	addq	$0x20, %rsp
180002894:     	popq	%rsi
180002895:     	retq
180002896:     	movq	(%rcx), %rdx
180002899:     	incq	%rdx
18000289c:     	callq	0x1800028f0 <numba_list_resize>
1800028a1:     	testl	%eax, %eax
1800028a3:     	js	0x1800028dc <numba_list_append+0x6c>
1800028a5:     	movq	0x8(%rbx), %r8
1800028a9:     	movq	%rsi, %rdx
1800028ac:     	movq	%rdi, 0x30(%rsp)
1800028b1:     	movq	(%rbx), %rdi
1800028b4:     	decq	%rdi
1800028b7:     	imulq	%r8, %rdi
1800028bb:     	addq	0x30(%rbx), %rdi
1800028bf:     	movq	%rdi, %rcx
1800028c2:     	callq	0x180003b63 <numba_list_iter_next+0xe73>
1800028c7:     	movq	0x20(%rbx), %rax
1800028cb:     	testq	%rax, %rax
1800028ce:     	je	0x1800028d5 <numba_list_append+0x65>
1800028d0:     	movq	%rdi, %rcx
1800028d3:     	callq	*%rax
1800028d5:     	movq	0x30(%rsp), %rdi
1800028da:     	xorl	%eax, %eax
1800028dc:     	movq	0x38(%rsp), %rbx
1800028e1:     	addq	$0x20, %rsp
1800028e5:     	popq	%rsi
1800028e6:     	retq
1800028e7:     	int3
1800028e8:     	int3
1800028e9:     	int3
1800028ea:     	int3
1800028eb:     	int3
1800028ec:     	int3
1800028ed:     	int3
1800028ee:     	int3
1800028ef:     	int3

00000001800028f0 <numba_list_resize>:
1800028f0:     	movq	%rsi, 0x18(%rsp)
1800028f5:     	pushq	%rdi
1800028f6:     	subq	$0x20, %rsp
1800028fa:     	cmpl	$0x0, 0x18(%rcx)
1800028fe:     	movq	%rdx, %rsi
180002901:     	movq	%rcx, %rdi
180002904:     	jne	0x180002916 <numba_list_resize+0x26>
180002906:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000290b:     	movq	0x40(%rsp), %rsi
180002910:     	addq	$0x20, %rsp
180002914:     	popq	%rdi
180002915:     	retq
180002916:     	movq	0x10(%rcx), %rax
18000291a:     	cmpq	%rsi, %rax
18000291d:     	jl	0x180002937 <numba_list_resize+0x47>
18000291f:     	sarq	%rax
180002922:     	cmpq	%rax, %rsi
180002925:     	jl	0x180002937 <numba_list_resize+0x47>
180002927:     	movq	%rsi, (%rcx)
18000292a:     	xorl	%eax, %eax
18000292c:     	movq	0x40(%rsp), %rsi
180002931:     	addq	$0x20, %rsp
180002935:     	popq	%rdi
180002936:     	retq
180002937:     	cmpq	$0x9, %rsi
18000293b:     	movq	%rbp, 0x38(%rsp)
180002940:     	movl	$0x3, %ecx
180002945:     	movl	$0x6, %eax
18000294a:     	cmovll	%ecx, %eax
18000294d:     	movq	%rsi, %r8
180002950:     	movq	0x8(%rdi), %rcx
180002954:     	addq	%rsi, %rax
180002957:     	sarq	$0x3, %r8
18000295b:     	xorl	%edx, %edx
18000295d:     	addq	%rax, %r8
180002960:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000296a:     	divq	%rcx
18000296d:     	cmpq	%rax, %r8
180002970:     	ja	0x1800029eb <numba_list_resize+0xfb>
180002972:     	xorl	%ebp, %ebp
180002974:     	movq	%rbx, 0x30(%rsp)
180002979:     	testq	%rsi, %rsi
18000297c:     	cmovneq	%r8, %rbp
180002980:     	movq	%rbp, %rbx
180002983:     	imulq	%rcx, %rbx
180002987:     	movl	$0x8, %ecx
18000298c:     	movq	%rbx, %rax
18000298f:     	cqto
180002991:     	andl	$0x7, %edx
180002994:     	addq	%rdx, %rax
180002997:     	andl	$0x7, %eax
18000299a:     	subq	%rdx, %rax
18000299d:     	subq	%rax, %rcx
1800029a0:     	movq	%rcx, %rax
1800029a3:     	movq	0x30(%rdi), %rcx
1800029a7:     	cqto
1800029a9:     	andl	$0x7, %edx
1800029ac:     	addq	%rdx, %rax
1800029af:     	andl	$0x7, %eax
1800029b2:     	subq	%rdx, %rax
1800029b5:     	leaq	(%rbx,%rax), %rdx
1800029b9:     	callq	*0x16b1(%rip)           # 0x180004070
1800029bf:     	testq	%rbx, %rbx
1800029c2:     	movq	0x30(%rsp), %rbx
1800029c7:     	je	0x1800029ce <numba_list_resize+0xde>
1800029c9:     	testq	%rax, %rax
1800029cc:     	je	0x1800029eb <numba_list_resize+0xfb>
1800029ce:     	movq	%rax, 0x30(%rdi)
1800029d2:     	xorl	%eax, %eax
1800029d4:     	movq	%rbp, 0x10(%rdi)
1800029d8:     	movq	0x38(%rsp), %rbp
1800029dd:     	movq	%rsi, (%rdi)
1800029e0:     	movq	0x40(%rsp), %rsi
1800029e5:     	addq	$0x20, %rsp
1800029e9:     	popq	%rdi
1800029ea:     	retq
1800029eb:     	movq	0x38(%rsp), %rbp
1800029f0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800029f5:     	movq	0x40(%rsp), %rsi
1800029fa:     	addq	$0x20, %rsp
1800029fe:     	popq	%rdi
1800029ff:     	retq

0000000180002a00 <numba_list_delitem>:
180002a00:     	movq	%rbx, 0x10(%rsp)
180002a05:     	pushq	%rdi
180002a06:     	subq	$0x20, %rsp
180002a0a:     	cmpl	$0x0, 0x18(%rcx)
180002a0e:     	movq	%rdx, %rdi
180002a11:     	movq	%rcx, %rbx
180002a14:     	jne	0x180002a26 <numba_list_delitem+0x26>
180002a16:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002a1b:     	movq	0x38(%rsp), %rbx
180002a20:     	addq	$0x20, %rsp
180002a24:     	popq	%rdi
180002a25:     	retq
180002a26:     	cmpq	(%rcx), %rdi
180002a29:     	jb	0x180002a3b <numba_list_delitem+0x3b>
180002a2b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002a30:     	movq	0x38(%rsp), %rbx
180002a35:     	addq	$0x20, %rsp
180002a39:     	popq	%rdi
180002a3a:     	retq
180002a3b:     	movq	0x28(%rcx), %rax
180002a3f:     	movq	%rsi, 0x30(%rsp)
180002a44:     	movq	%rdi, %rsi
180002a47:     	imulq	0x8(%rcx), %rsi
180002a4c:     	addq	0x30(%rcx), %rsi
180002a50:     	testq	%rax, %rax
180002a53:     	je	0x180002a5a <numba_list_delitem+0x5a>
180002a55:     	movq	%rsi, %rcx
180002a58:     	callq	*%rax
180002a5a:     	movq	(%rbx), %r8
180002a5d:     	leaq	-0x1(%r8), %rax
180002a61:     	cmpq	%rax, %rdi
180002a64:     	je	0x180002a86 <numba_list_delitem+0x86>
180002a66:     	subq	%rdi, %r8
180002a69:     	leaq	0x1(%rdi), %rdx
180002a6d:     	imulq	0x8(%rbx), %rdx
180002a72:     	decq	%r8
180002a75:     	movq	%rsi, %rcx
180002a78:     	imulq	0x8(%rbx), %r8
180002a7d:     	addq	0x30(%rbx), %rdx
180002a81:     	callq	0x180003b69 <numba_list_iter_next+0xe79>
180002a86:     	movq	(%rbx), %rdx
180002a89:     	movq	%rbx, %rcx
180002a8c:     	decq	%rdx
180002a8f:     	callq	0x1800028f0 <numba_list_resize>
180002a94:     	movq	0x30(%rsp), %rsi
180002a99:     	xorl	%ecx, %ecx
180002a9b:     	movq	0x38(%rsp), %rbx
180002aa0:     	testl	%eax, %eax
180002aa2:     	cmovsl	%eax, %ecx
180002aa5:     	movl	%ecx, %eax
180002aa7:     	addq	$0x20, %rsp
180002aab:     	popq	%rdi
180002aac:     	retq
180002aad:     	int3
180002aae:     	int3
180002aaf:     	int3

0000000180002ab0 <numba_list_delete_slice>:
180002ab0:     	pushq	%rbx
180002ab2:     	pushq	%rbp
180002ab3:     	pushq	%rdi
180002ab4:     	pushq	%r15
180002ab6:     	subq	$0x38, %rsp
180002aba:     	cmpl	$0x0, 0x18(%rcx)
180002abe:     	movq	%r9, %rdi
180002ac1:     	movq	%r8, %rbp
180002ac4:     	movq	%rdx, %r15
180002ac7:     	movq	%rcx, %rbx
180002aca:     	jne	0x180002adb <numba_list_delete_slice+0x2b>
180002acc:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002ad1:     	addq	$0x38, %rsp
180002ad5:     	popq	%r15
180002ad7:     	popq	%rdi
180002ad8:     	popq	%rbp
180002ad9:     	popq	%rbx
180002ada:     	retq
180002adb:     	movq	%r13, 0x78(%rsp)
180002ae0:     	testq	%rdi, %rdi
180002ae3:     	jle	0x180002b02 <numba_list_delete_slice+0x52>
180002ae5:     	cmpq	%r8, %r15
180002ae8:     	jge	0x180002ca1 <numba_list_delete_slice+0x1f1>
180002aee:     	movq	%r8, %rax
180002af1:     	subq	%r15, %rax
180002af4:     	decq	%rax
180002af7:     	cqto
180002af9:     	idivq	%rdi
180002afc:     	leal	0x1(%rax), %r13d
180002b00:     	jmp	0x180002b22 <numba_list_delete_slice+0x72>
180002b02:     	cmpq	%r15, %r8
180002b05:     	jge	0x180002ca1 <numba_list_delete_slice+0x1f1>
180002b0b:     	movq	%r15, %rax
180002b0e:     	movl	$0x1, %r13d
180002b14:     	subq	%r8, %rax
180002b17:     	decq	%rax
180002b1a:     	cqto
180002b1c:     	idivq	%rdi
180002b1f:     	subl	%eax, %r13d
180002b22:     	testl	%r13d, %r13d
180002b25:     	jle	0x180002ca1 <numba_list_delete_slice+0x1f1>
180002b2b:     	movq	%rsi, 0x68(%rsp)
180002b30:     	movl	(%rcx), %esi
180002b32:     	subl	%r13d, %esi
180002b35:     	movl	%esi, 0x20(%rsp)
180002b39:     	testq	%rdi, %rdi
180002b3c:     	jns	0x180002b57 <numba_list_delete_slice+0xa7>
180002b3e:     	leaq	0x1(%r15), %rbp
180002b42:     	leal	-0x1(%r13), %eax
180002b46:     	movslq	%eax, %rcx
180002b49:     	leaq	-0x1(%rbp), %r15
180002b4d:     	imulq	%rdi, %rcx
180002b51:     	addq	%rcx, %r15
180002b54:     	negq	%rdi
180002b57:     	cmpq	$0x1, %rdi
180002b5b:     	jne	0x180002ba7 <numba_list_delete_slice+0xf7>
180002b5d:     	cmpq	$0x0, 0x28(%rbx)
180002b62:     	je	0x180002b89 <numba_list_delete_slice+0xd9>
180002b64:     	movslq	%r15d, %rdi
180002b67:     	cmpq	%rbp, %rdi
180002b6a:     	jge	0x180002b89 <numba_list_delete_slice+0xd9>
180002b6c:     	nopl	(%rax)
180002b70:     	movslq	%edi, %rcx
180002b73:     	imulq	0x8(%rbx), %rcx
180002b78:     	addq	0x30(%rbx), %rcx
180002b7c:     	callq	*0x28(%rbx)
180002b7f:     	incl	%edi
180002b81:     	movslq	%edi, %rax
180002b84:     	cmpq	%rbp, %rax
180002b87:     	jl	0x180002b70 <numba_list_delete_slice+0xc0>
180002b89:     	movq	0x8(%rbx), %rcx
180002b8d:     	movq	(%rbx), %r8
180002b90:     	movq	%rcx, %rdx
180002b93:     	subq	%rbp, %r8
180002b96:     	imulq	%rcx, %r8
180002b9a:     	imulq	%rbp, %rdx
180002b9e:     	imulq	%r15, %rcx
180002ba2:     	jmp	0x180002c6c <numba_list_delete_slice+0x1bc>
180002ba7:     	movq	%r14, 0x30(%rsp)
180002bac:     	movq	%r15, %r14
180002baf:     	movl	$0x0, 0x60(%rsp)
180002bb7:     	cmpq	%rbp, %r15
180002bba:     	jge	0x180002c39 <numba_list_delete_slice+0x189>
180002bbc:     	movq	%r12, 0x70(%rsp)
180002bc1:     	movq	(%rbx), %rax
180002bc4:     	leaq	(%r14,%rdi), %r12
180002bc8:     	cmpq	%rax, %r12
180002bcb:     	jl	0x180002bd8 <numba_list_delete_slice+0x128>
180002bcd:     	movq	%r14, %rsi
180002bd0:     	notq	%rsi
180002bd3:     	addq	%rax, %rsi
180002bd6:     	jmp	0x180002bdc <numba_list_delete_slice+0x12c>
180002bd8:     	leaq	-0x1(%rdi), %rsi
180002bdc:     	movq	0x28(%rbx), %rax
180002be0:     	testq	%rax, %rax
180002be3:     	je	0x180002bf3 <numba_list_delete_slice+0x143>
180002be5:     	movq	%r14, %rcx
180002be8:     	imulq	0x8(%rbx), %rcx
180002bed:     	addq	0x30(%rbx), %rcx
180002bf1:     	callq	*%rax
180002bf3:     	movq	0x8(%rbx), %r9
180002bf7:     	leaq	0x1(%r14), %rdx
180002bfb:     	movq	0x30(%rbx), %r10
180002bff:     	movq	%r9, %r8
180002c02:     	imulq	%rsi, %r8
180002c06:     	imulq	%r9, %rdx
180002c0a:     	movslq	0x60(%rsp), %rsi
180002c0f:     	subq	%rsi, %r14
180002c12:     	imulq	%r9, %r14
180002c16:     	addq	%r10, %rdx
180002c19:     	leaq	(%r10,%r14), %rcx
180002c1d:     	callq	0x180003b69 <numba_list_iter_next+0xe79>
180002c22:     	incl	%esi
180002c24:     	movq	%r12, %r14
180002c27:     	movl	%esi, 0x60(%rsp)
180002c2b:     	cmpq	%rbp, %r12
180002c2e:     	jl	0x180002bc1 <numba_list_delete_slice+0x111>
180002c30:     	movq	0x70(%rsp), %r12
180002c35:     	movl	0x20(%rsp), %esi
180002c39:     	movq	(%rbx), %r8
180002c3c:     	movq	0x30(%rsp), %r14
180002c41:     	movslq	%r13d, %r10
180002c44:     	movq	%r10, %rcx
180002c47:     	imulq	%rdi, %rcx
180002c4b:     	addq	%r15, %rcx
180002c4e:     	cmpq	%r8, %rcx
180002c51:     	jge	0x180002c79 <numba_list_delete_slice+0x1c9>
180002c53:     	movq	0x8(%rbx), %rax
180002c57:     	subq	%rcx, %r8
180002c5a:     	movq	%rax, %rdx
180002c5d:     	imulq	%rcx, %rdx
180002c61:     	imulq	%rax, %r8
180002c65:     	subq	%r10, %rcx
180002c68:     	imulq	%rax, %rcx
180002c6c:     	addq	0x30(%rbx), %rdx
180002c70:     	addq	0x30(%rbx), %rcx
180002c74:     	callq	0x180003b69 <numba_list_iter_next+0xe79>
180002c79:     	movslq	%esi, %rdx
180002c7c:     	movq	%rbx, %rcx
180002c7f:     	callq	0x1800028f0 <numba_list_resize>
180002c84:     	movq	0x68(%rsp), %rsi
180002c89:     	xorl	%ecx, %ecx
180002c8b:     	movq	0x78(%rsp), %r13
180002c90:     	testl	%eax, %eax
180002c92:     	cmovsl	%eax, %ecx
180002c95:     	movl	%ecx, %eax
180002c97:     	addq	$0x38, %rsp
180002c9b:     	popq	%r15
180002c9d:     	popq	%rdi
180002c9e:     	popq	%rbp
180002c9f:     	popq	%rbx
180002ca0:     	retq
180002ca1:     	movq	0x78(%rsp), %r13
180002ca6:     	xorl	%eax, %eax
180002ca8:     	addq	$0x38, %rsp
180002cac:     	popq	%r15
180002cae:     	popq	%rdi
180002caf:     	popq	%rbp
180002cb0:     	popq	%rbx
180002cb1:     	retq
180002cb2:     	int3
180002cb3:     	int3
180002cb4:     	int3
180002cb5:     	int3
180002cb6:     	int3
180002cb7:     	int3
180002cb8:     	int3
180002cb9:     	int3
180002cba:     	int3
180002cbb:     	int3
180002cbc:     	int3
180002cbd:     	int3
180002cbe:     	int3
180002cbf:     	int3

0000000180002cc0 <numba_list_iter_sizeof>:
180002cc0:     	movl	$0x18, %eax
180002cc5:     	retq
180002cc6:     	int3
180002cc7:     	int3
180002cc8:     	int3
180002cc9:     	int3
180002cca:     	int3
180002ccb:     	int3
180002ccc:     	int3
180002ccd:     	int3
180002cce:     	int3
180002ccf:     	int3

0000000180002cd0 <numba_list_iter>:
180002cd0:     	movq	%rdx, (%rcx)
180002cd3:     	movq	(%rdx), %rax
180002cd6:     	movq	%rax, 0x8(%rcx)
180002cda:     	movq	$0x0, 0x10(%rcx)
180002ce2:     	retq
180002ce3:     	int3
180002ce4:     	int3
180002ce5:     	int3
180002ce6:     	int3
180002ce7:     	int3
180002ce8:     	int3
180002ce9:     	int3
180002cea:     	int3
180002ceb:     	int3
180002cec:     	int3
180002ced:     	int3
180002cee:     	int3
180002cef:     	int3

0000000180002cf0 <numba_list_iter_next>:
180002cf0:     	movq	(%rcx), %r8
180002cf3:     	movq	(%r8), %r9
180002cf6:     	cmpq	0x8(%rcx), %r9
180002cfa:     	je	0x180002d02 <numba_list_iter_next+0x12>
180002cfc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002d01:     	retq
180002d02:     	movq	0x10(%rcx), %rax
180002d06:     	cmpq	%r9, %rax
180002d09:     	jge	0x180002d1e <numba_list_iter_next+0x2e>
180002d0b:     	imulq	0x8(%r8), %rax
180002d10:     	addq	0x30(%r8), %rax
180002d14:     	movq	%rax, (%rdx)
180002d17:     	incq	0x10(%rcx)
180002d1b:     	xorl	%eax, %eax
180002d1d:     	retq
180002d1e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002d23:     	retq
180002d24:     	int3
180002d25:     	int3
180002d26:     	int3
180002d27:     	int3
180002d28:     	int3
180002d29:     	int3
180002d2a:     	int3
180002d2b:     	int3
180002d2c:     	int3
180002d2d:     	int3
180002d2e:     	int3
180002d2f:     	int3
180002d30:     	pushq	%rbx
180002d32:     	subq	$0x20, %rsp
180002d36:     	movq	%rcx, %rbx
180002d39:     	addq	$0x30, %rcx
180002d3d:     	callq	*0x7ee5(%rip)           # 0x18000ac28
180002d43:     	cmpb	$0x0, 0x7eb6(%rip)      # 0x18000ac00
180002d4a:     	je	0x180002d54 <numba_list_iter_next+0x64>
180002d4c:     	lock
180002d4d:     	incq	0x7eb4(%rip)            # 0x18000ac08
180002d54:     	testq	%rax, %rax
180002d57:     	je	0x180002d98 <numba_list_iter_next+0xa8>
180002d59:     	leaq	0x30(%rax), %rdx
180002d5d:     	testq	%rdx, %rdx
180002d60:     	je	0x180002d98 <numba_list_iter_next+0xa8>
180002d62:     	xorl	%r8d, %r8d
180002d65:     	movl	$0x1, %ecx
180002d6a:     	xchgq	%rcx, (%rax)
180002d6d:     	movq	%r8, 0x8(%rax)
180002d71:     	movq	%r8, 0x10(%rax)
180002d75:     	movq	%rdx, 0x18(%rax)
180002d79:     	movq	%rbx, 0x20(%rax)
180002d7d:     	movq	%r8, 0x28(%rax)
180002d81:     	cmpb	%r8b, 0x7e78(%rip)      # 0x18000ac00
180002d88:     	je	0x180002d9a <numba_list_iter_next+0xaa>
180002d8a:     	lock
180002d8b:     	incq	0x7e86(%rip)            # 0x18000ac18
180002d92:     	addq	$0x20, %rsp
180002d96:     	popq	%rbx
180002d97:     	retq
180002d98:     	xorl	%eax, %eax
180002d9a:     	addq	$0x20, %rsp
180002d9e:     	popq	%rbx
180002d9f:     	retq
180002da0:     	movq	%rbx, 0x8(%rsp)
180002da5:     	pushq	%rdi
180002da6:     	subq	$0x20, %rsp
180002daa:     	movq	%rcx, %rdi
180002dad:     	movq	%rdx, %rbx
180002db0:     	addq	$0x30, %rcx
180002db4:     	testq	%rdx, %rdx
180002db7:     	je	0x180002dc1 <numba_list_iter_next+0xd1>
180002db9:     	movq	0x18(%rdx), %rdx
180002dbd:     	callq	*(%rbx)
180002dbf:     	jmp	0x180002dc7 <numba_list_iter_next+0xd7>
180002dc1:     	callq	*0x7e61(%rip)           # 0x18000ac28
180002dc7:     	cmpb	$0x0, 0x7e32(%rip)      # 0x18000ac00
180002dce:     	movq	%rax, %r8
180002dd1:     	je	0x180002ddb <numba_list_iter_next+0xeb>
180002dd3:     	lock
180002dd4:     	incq	0x7e2d(%rip)            # 0x18000ac08
180002ddb:     	xorl	%edx, %edx
180002ddd:     	leaq	0x30(%r8), %rax
180002de1:     	testq	%r8, %r8
180002de4:     	movl	%edx, %ecx
180002de6:     	cmovneq	%rax, %rcx
180002dea:     	testq	%rcx, %rcx
180002ded:     	jne	0x180002dfc <numba_list_iter_next+0x10c>
180002def:     	xorl	%eax, %eax
180002df1:     	movq	0x30(%rsp), %rbx
180002df6:     	addq	$0x20, %rsp
180002dfa:     	popq	%rdi
180002dfb:     	retq
180002dfc:     	movl	$0x1, %eax
180002e01:     	xchgq	%rax, (%r8)
180002e04:     	movq	%rdx, 0x8(%r8)
180002e08:     	movq	%rdx, 0x10(%r8)
180002e0c:     	movq	%rcx, 0x18(%r8)
180002e10:     	movq	%rdi, 0x20(%r8)
180002e14:     	movq	%rbx, 0x28(%r8)
180002e18:     	cmpb	%dl, 0x7de2(%rip)       # 0x18000ac00
180002e1e:     	je	0x180002e28 <numba_list_iter_next+0x138>
180002e20:     	lock
180002e21:     	incq	0x7df0(%rip)            # 0x18000ac18
180002e28:     	movq	0x30(%rsp), %rbx
180002e2d:     	movq	%r8, %rax
180002e30:     	addq	$0x20, %rsp
180002e34:     	popq	%rdi
180002e35:     	retq
180002e36:     	int3
180002e37:     	int3
180002e38:     	int3
180002e39:     	int3
180002e3a:     	int3
180002e3b:     	int3
180002e3c:     	int3
180002e3d:     	int3
180002e3e:     	int3
180002e3f:     	int3
180002e40:     	lock
180002e41:     	incq	(%rcx)
180002e44:     	retq
180002e45:     	int3
180002e46:     	int3
180002e47:     	int3
180002e48:     	int3
180002e49:     	int3
180002e4a:     	int3
180002e4b:     	int3
180002e4c:     	int3
180002e4d:     	int3
180002e4e:     	int3
180002e4f:     	int3
180002e50:     	pushq	%rbx
180002e52:     	subq	$0x20, %rsp
180002e56:     	movq	0x8(%rcx), %rax
180002e5a:     	movq	%rcx, %rbx
180002e5d:     	testq	%rax, %rax
180002e60:     	je	0x180002e79 <numba_list_iter_next+0x189>
180002e62:     	cmpl	$0x0, 0x7d8f(%rip)      # 0x18000abf8
180002e69:     	jne	0x180002e79 <numba_list_iter_next+0x189>
180002e6b:     	movq	0x10(%rcx), %r8
180002e6f:     	movq	0x20(%rcx), %rdx
180002e73:     	movq	0x18(%rcx), %rcx
180002e77:     	callq	*%rax
180002e79:     	movq	0x28(%rbx), %rax
180002e7d:     	movq	%rbx, %rcx
180002e80:     	testq	%rax, %rax
180002e83:     	je	0x180002e8e <numba_list_iter_next+0x19e>
180002e85:     	movq	0x18(%rax), %rdx
180002e89:     	callq	*0x10(%rax)
180002e8c:     	jmp	0x180002e94 <numba_list_iter_next+0x1a4>
180002e8e:     	callq	*0x7da4(%rip)           # 0x18000ac38
180002e94:     	cmpb	$0x0, 0x7d65(%rip)      # 0x18000ac00
180002e9b:     	je	0x180002eb9 <numba_list_iter_next+0x1c9>
180002e9d:     	leaq	0x7d6c(%rip), %rax      # 0x18000ac10
180002ea4:     	lock
180002ea5:     	incq	(%rax)
180002ea8:     	cmpb	$0x0, 0x7d51(%rip)      # 0x18000ac00
180002eaf:     	je	0x180002eb9 <numba_list_iter_next+0x1c9>
180002eb1:     	lock
180002eb2:     	incq	0x7d67(%rip)            # 0x18000ac20
180002eb9:     	addq	$0x20, %rsp
180002ebd:     	popq	%rbx
180002ebe:     	retq
180002ebf:     	int3
180002ec0:     	pushq	%rbx
180002ec2:     	subq	$0x20, %rsp
180002ec6:     	movq	%rcx, %rbx
180002ec9:     	movq	$-0x1, %rax
180002ed0:     	lock
180002ed1:     	xaddq	%rax, (%rcx)
180002ed5:     	cmpq	$0x1, %rax
180002ed9:     	jne	0x180002f3b <numba_list_iter_next+0x24b>
180002edb:     	movq	0x8(%rcx), %rax
180002edf:     	testq	%rax, %rax
180002ee2:     	je	0x180002efb <numba_list_iter_next+0x20b>
180002ee4:     	cmpl	$0x0, 0x7d0d(%rip)      # 0x18000abf8
180002eeb:     	jne	0x180002efb <numba_list_iter_next+0x20b>
180002eed:     	movq	0x10(%rcx), %r8
180002ef1:     	movq	0x20(%rcx), %rdx
180002ef5:     	movq	0x18(%rcx), %rcx
180002ef9:     	callq	*%rax
180002efb:     	movq	0x28(%rbx), %rax
180002eff:     	movq	%rbx, %rcx
180002f02:     	testq	%rax, %rax
180002f05:     	je	0x180002f10 <numba_list_iter_next+0x220>
180002f07:     	movq	0x18(%rax), %rdx
180002f0b:     	callq	*0x10(%rax)
180002f0e:     	jmp	0x180002f16 <numba_list_iter_next+0x226>
180002f10:     	callq	*0x7d22(%rip)           # 0x18000ac38
180002f16:     	cmpb	$0x0, 0x7ce3(%rip)      # 0x18000ac00
180002f1d:     	je	0x180002f3b <numba_list_iter_next+0x24b>
180002f1f:     	leaq	0x7cea(%rip), %rax      # 0x18000ac10
180002f26:     	lock
180002f27:     	incq	(%rax)
180002f2a:     	cmpb	$0x0, 0x7ccf(%rip)      # 0x18000ac00
180002f31:     	je	0x180002f3b <numba_list_iter_next+0x24b>
180002f33:     	lock
180002f34:     	incq	0x7ce5(%rip)            # 0x18000ac20
180002f3b:     	addq	$0x20, %rsp
180002f3f:     	popq	%rbx
180002f40:     	retq
180002f41:     	int3
180002f42:     	int3
180002f43:     	int3
180002f44:     	int3
180002f45:     	int3
180002f46:     	int3
180002f47:     	int3
180002f48:     	int3
180002f49:     	int3
180002f4a:     	int3
180002f4b:     	int3
180002f4c:     	int3
180002f4d:     	int3
180002f4e:     	int3
180002f4f:     	int3
180002f50:     	movq	0x18(%rcx), %rax
180002f54:     	retq
180002f55:     	int3
180002f56:     	int3
180002f57:     	int3
180002f58:     	int3
180002f59:     	int3
180002f5a:     	int3
180002f5b:     	int3
180002f5c:     	int3
180002f5d:     	int3
180002f5e:     	int3
180002f5f:     	int3
180002f60:     	jmpq	*%r8
180002f63:     	int3
180002f64:     	int3
180002f65:     	int3
180002f66:     	int3
180002f67:     	int3
180002f68:     	int3
180002f69:     	int3
180002f6a:     	int3
180002f6b:     	int3
180002f6c:     	int3
180002f6d:     	int3
180002f6e:     	int3
180002f6f:     	int3
180002f70:     	movq	%rbx, 0x8(%rsp)
180002f75:     	pushq	%rdi
180002f76:     	subq	$0x20, %rsp
180002f7a:     	movq	%rcx, %rdi
180002f7d:     	movq	%rdx, %rbx
180002f80:     	movl	$0x30, %ecx
180002f85:     	callq	*0x7c9d(%rip)           # 0x18000ac28
180002f8b:     	cmpb	$0x0, 0x7c6e(%rip)      # 0x18000ac00
180002f92:     	je	0x180002f9c <numba_list_iter_next+0x2ac>
180002f94:     	lock
180002f95:     	incq	0x7c6c(%rip)            # 0x18000ac08
180002f9c:     	testq	%rax, %rax
180002f9f:     	je	0x180002fd6 <numba_list_iter_next+0x2e6>
180002fa1:     	leaq	-0x48(%rip), %rcx       # 0x180002f60 <numba_list_iter_next+0x270>
180002fa8:     	movl	$0x1, %edx
180002fad:     	xchgq	%rdx, (%rax)
180002fb0:     	movq	%rcx, 0x8(%rax)
180002fb4:     	xorl	%ecx, %ecx
180002fb6:     	movq	%rcx, 0x20(%rax)
180002fba:     	movq	%rcx, 0x28(%rax)
180002fbe:     	movq	%rbx, 0x10(%rax)
180002fc2:     	movq	%rdi, 0x18(%rax)
180002fc6:     	cmpb	%cl, 0x7c34(%rip)       # 0x18000ac00
180002fcc:     	je	0x180002fd6 <numba_list_iter_next+0x2e6>
180002fce:     	lock
180002fcf:     	incq	0x7c42(%rip)            # 0x18000ac18
180002fd6:     	movq	0x30(%rsp), %rbx
180002fdb:     	addq	$0x20, %rsp
180002fdf:     	popq	%rdi
180002fe0:     	retq
180002fe1:     	jmpq	*0x1289(%rip)           # 0x180004270
180002fe7:     	jmpq	*0x1273(%rip)           # 0x180004260
180002fed:     	jmpq	*0x1265(%rip)           # 0x180004258
180002ff3:     	jmpq	*0x1257(%rip)           # 0x180004250
180002ff9:     	jmpq	*0x1249(%rip)           # 0x180004248
180002fff:     	jmpq	*0x123b(%rip)           # 0x180004240
180003005:     	jmpq	*0x1225(%rip)           # 0x180004230
18000300b:     	jmpq	*0x120f(%rip)           # 0x180004220
180003011:     	jmpq	*0x11e9(%rip)           # 0x180004200
180003017:     	int3
180003018:     	int3
180003019:     	int3
18000301a:     	int3
18000301b:     	int3
18000301c:     	int3
18000301d:     	int3
18000301e:     	int3
18000301f:     	int3
180003020:     	int3
180003021:     	int3
180003022:     	int3
180003023:     	int3
180003024:     	int3
180003025:     	int3
180003026:     	nopw	(%rax,%rax)
180003030:     	cmpq	0x7089(%rip), %rcx      # 0x18000a0c0
180003037:     	jne	0x180003049 <numba_list_iter_next+0x359>
180003039:     	rolq	$0x10, %rcx
18000303d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180003042:     	jne	0x180003045 <numba_list_iter_next+0x355>
180003044:     	retq
180003045:     	rorq	$0x10, %rcx
180003049:     	jmp	0x1800033a4 <numba_list_iter_next+0x6b4>
18000304e:     	int3
18000304f:     	int3
180003050:     	subq	$0x28, %rsp
180003054:     	testl	%edx, %edx
180003056:     	je	0x180003091 <numba_list_iter_next+0x3a1>
180003058:     	subl	$0x1, %edx
18000305b:     	je	0x180003085 <numba_list_iter_next+0x395>
18000305d:     	subl	$0x1, %edx
180003060:     	je	0x180003078 <numba_list_iter_next+0x388>
180003062:     	cmpl	$0x1, %edx
180003065:     	je	0x180003071 <numba_list_iter_next+0x381>
180003067:     	movl	$0x1, %eax
18000306c:     	addq	$0x28, %rsp
180003070:     	retq
180003071:     	callq	0x180003570 <numba_list_iter_next+0x880>
180003076:     	jmp	0x18000307d <numba_list_iter_next+0x38d>
180003078:     	callq	0x180003548 <numba_list_iter_next+0x858>
18000307d:     	movzbl	%al, %eax
180003080:     	addq	$0x28, %rsp
180003084:     	retq
180003085:     	movq	%r8, %rdx
180003088:     	addq	$0x28, %rsp
18000308c:     	jmp	0x1800030a0 <numba_list_iter_next+0x3b0>
180003091:     	testq	%r8, %r8
180003094:     	setne	%cl
180003097:     	addq	$0x28, %rsp
18000309b:     	jmp	0x1800031b8 <numba_list_iter_next+0x4c8>
1800030a0:     	movq	%rbx, 0x8(%rsp)
1800030a5:     	movq	%rsi, 0x10(%rsp)
1800030aa:     	movq	%rdi, 0x20(%rsp)
1800030af:     	pushq	%r14
1800030b1:     	subq	$0x20, %rsp
1800030b5:     	movq	%rdx, %rsi
1800030b8:     	movq	%rcx, %r14
1800030bb:     	xorl	%ecx, %ecx
1800030bd:     	callq	0x18000362c <numba_list_iter_next+0x93c>
1800030c2:     	testb	%al, %al
1800030c4:     	je	0x180003192 <numba_list_iter_next+0x4a2>
1800030ca:     	callq	0x1800034c0 <numba_list_iter_next+0x7d0>
1800030cf:     	movb	%al, %bl
1800030d1:     	movb	%al, 0x40(%rsp)
1800030d5:     	movb	$0x1, %dil
1800030d8:     	cmpl	$0x0, 0x78e9(%rip)      # 0x18000a9c8
1800030df:     	jne	0x1800031aa <numba_list_iter_next+0x4ba>
1800030e5:     	movl	$0x1, 0x78d9(%rip)      # 0x18000a9c8
1800030ef:     	callq	0x180003530 <numba_list_iter_next+0x840>
1800030f4:     	testb	%al, %al
1800030f6:     	je	0x180003147 <numba_list_iter_next+0x457>
1800030f8:     	callq	0x1800037ec <numba_list_iter_next+0xafc>
1800030fd:     	callq	0x180003480 <numba_list_iter_next+0x790>
180003102:     	callq	0x1800034a4 <numba_list_iter_next+0x7b4>
180003107:     	leaq	0x11c2(%rip), %rdx      # 0x1800042d0
18000310e:     	leaq	0x11b3(%rip), %rcx      # 0x1800042c8
180003115:     	callq	0x180003b32 <numba_list_iter_next+0xe42>
18000311a:     	testl	%eax, %eax
18000311c:     	jne	0x180003147 <numba_list_iter_next+0x457>
18000311e:     	callq	0x1800034fc <numba_list_iter_next+0x80c>
180003123:     	testb	%al, %al
180003125:     	je	0x180003147 <numba_list_iter_next+0x457>
180003127:     	leaq	0x1192(%rip), %rdx      # 0x1800042c0
18000312e:     	leaq	0x1183(%rip), %rcx      # 0x1800042b8
180003135:     	callq	0x180003b2c <numba_list_iter_next+0xe3c>
18000313a:     	movl	$0x2, 0x7884(%rip)      # 0x18000a9c8
180003144:     	xorb	%dil, %dil
180003147:     	movb	%bl, %cl
180003149:     	callq	0x18000378c <numba_list_iter_next+0xa9c>
18000314e:     	testb	%dil, %dil
180003151:     	jne	0x180003192 <numba_list_iter_next+0x4a2>
180003153:     	callq	0x1800037dc <numba_list_iter_next+0xaec>
180003158:     	movq	%rax, %rbx
18000315b:     	cmpq	$0x0, (%rax)
18000315f:     	je	0x180003185 <numba_list_iter_next+0x495>
180003161:     	movq	%rax, %rcx
180003164:     	callq	0x1800036f4 <numba_list_iter_next+0xa04>
180003169:     	testb	%al, %al
18000316b:     	je	0x180003185 <numba_list_iter_next+0x495>
18000316d:     	movq	%rsi, %r8
180003170:     	movl	$0x2, %edx
180003175:     	movq	%r14, %rcx
180003178:     	movq	(%rbx), %rax
18000317b:     	movq	0x110e(%rip), %r9       # 0x180004290
180003182:     	callq	*%r9
180003185:     	incl	0x7815(%rip)            # 0x18000a9a0
18000318b:     	movl	$0x1, %eax
180003190:     	jmp	0x180003194 <numba_list_iter_next+0x4a4>
180003192:     	xorl	%eax, %eax
180003194:     	movq	0x30(%rsp), %rbx
180003199:     	movq	0x38(%rsp), %rsi
18000319e:     	movq	0x48(%rsp), %rdi
1800031a3:     	addq	$0x20, %rsp
1800031a7:     	popq	%r14
1800031a9:     	retq
1800031aa:     	movl	$0x7, %ecx
1800031af:     	callq	0x1800037e4 <numba_list_iter_next+0xaf4>
1800031b4:     	nop
1800031b5:     	int3
1800031b6:     	int3
1800031b7:     	int3
1800031b8:     	movq	%rbx, 0x8(%rsp)
1800031bd:     	pushq	%rdi
1800031be:     	subq	$0x30, %rsp
1800031c2:     	movb	%cl, %dil
1800031c5:     	movl	0x77d5(%rip), %eax      # 0x18000a9a0
1800031cb:     	testl	%eax, %eax
1800031cd:     	jg	0x1800031dc <numba_list_iter_next+0x4ec>
1800031cf:     	xorl	%eax, %eax
1800031d1:     	movq	0x40(%rsp), %rbx
1800031d6:     	addq	$0x30, %rsp
1800031da:     	popq	%rdi
1800031db:     	retq
1800031dc:     	decl	%eax
1800031de:     	movl	%eax, 0x77bc(%rip)      # 0x18000a9a0
1800031e4:     	callq	0x1800034c0 <numba_list_iter_next+0x7d0>
1800031e9:     	movb	%al, %bl
1800031eb:     	movb	%al, 0x20(%rsp)
1800031ef:     	cmpl	$0x2, 0x77d2(%rip)      # 0x18000a9c8
1800031f6:     	jne	0x18000322e <numba_list_iter_next+0x53e>
1800031f8:     	callq	0x1800035e8 <numba_list_iter_next+0x8f8>
1800031fd:     	callq	0x180003490 <numba_list_iter_next+0x7a0>
180003202:     	callq	0x180003828 <numba_list_iter_next+0xb38>
180003207:     	movl	$0x0, 0x77b7(%rip)      # 0x18000a9c8
180003211:     	movb	%bl, %cl
180003213:     	callq	0x18000378c <numba_list_iter_next+0xa9c>
180003218:     	xorl	%edx, %edx
18000321a:     	movb	%dil, %cl
18000321d:     	callq	0x1800037b0 <numba_list_iter_next+0xac0>
180003222:     	movzbl	%al, %ebx
180003225:     	callq	0x180003618 <numba_list_iter_next+0x928>
18000322a:     	movl	%ebx, %eax
18000322c:     	jmp	0x1800031d1 <numba_list_iter_next+0x4e1>
18000322e:     	movl	$0x7, %ecx
180003233:     	callq	0x1800037e4 <numba_list_iter_next+0xaf4>
180003238:     	nop
180003239:     	nop
18000323a:     	int3
18000323b:     	int3
18000323c:     	movq	%rsp, %rax
18000323f:     	movq	%rbx, 0x20(%rax)
180003243:     	movq	%r8, 0x18(%rax)
180003247:     	movl	%edx, 0x10(%rax)
18000324a:     	movq	%rcx, 0x8(%rax)
18000324e:     	pushq	%rsi
18000324f:     	pushq	%rdi
180003250:     	pushq	%r14
180003252:     	subq	$0x40, %rsp
180003256:     	movq	%r8, %rsi
180003259:     	movl	%edx, %edi
18000325b:     	movq	%rcx, %r14
18000325e:     	testl	%edx, %edx
180003260:     	jne	0x180003271 <numba_list_iter_next+0x581>
180003262:     	cmpl	%edx, 0x7738(%rip)      # 0x18000a9a0
180003268:     	jg	0x180003271 <numba_list_iter_next+0x581>
18000326a:     	xorl	%eax, %eax
18000326c:     	jmp	0x180003356 <numba_list_iter_next+0x666>
180003271:     	leal	-0x1(%rdx), %eax
180003274:     	cmpl	$0x1, %eax
180003277:     	ja	0x1800032b9 <numba_list_iter_next+0x5c9>
180003279:     	movq	0x1368(%rip), %rax      # 0x1800045e8
180003280:     	testq	%rax, %rax
180003283:     	jne	0x18000328a <numba_list_iter_next+0x59a>
180003285:     	leal	0x1(%rax), %ebx
180003288:     	jmp	0x180003292 <numba_list_iter_next+0x5a2>
18000328a:     	callq	*0x1000(%rip)           # 0x180004290
180003290:     	movl	%eax, %ebx
180003292:     	movl	%ebx, 0x30(%rsp)
180003296:     	testl	%ebx, %ebx
180003298:     	je	0x18000334c <numba_list_iter_next+0x65c>
18000329e:     	movq	%rsi, %r8
1800032a1:     	movl	%edi, %edx
1800032a3:     	movq	%r14, %rcx
1800032a6:     	callq	0x180003050 <numba_list_iter_next+0x360>
1800032ab:     	movl	%eax, %ebx
1800032ad:     	movl	%eax, 0x30(%rsp)
1800032b1:     	testl	%eax, %eax
1800032b3:     	je	0x18000334c <numba_list_iter_next+0x65c>
1800032b9:     	movq	%rsi, %r8
1800032bc:     	movl	%edi, %edx
1800032be:     	movq	%r14, %rcx
1800032c1:     	callq	0x18000345c <numba_list_iter_next+0x76c>
1800032c6:     	movl	%eax, %ebx
1800032c8:     	movl	%eax, 0x30(%rsp)
1800032cc:     	cmpl	$0x1, %edi
1800032cf:     	jne	0x180003307 <numba_list_iter_next+0x617>
1800032d1:     	testl	%eax, %eax
1800032d3:     	jne	0x180003307 <numba_list_iter_next+0x617>
1800032d5:     	movq	%rsi, %r8
1800032d8:     	xorl	%edx, %edx
1800032da:     	movq	%r14, %rcx
1800032dd:     	callq	0x18000345c <numba_list_iter_next+0x76c>
1800032e2:     	testq	%rsi, %rsi
1800032e5:     	setne	%cl
1800032e8:     	callq	0x1800031b8 <numba_list_iter_next+0x4c8>
1800032ed:     	movq	0x12f4(%rip), %rax      # 0x1800045e8
1800032f4:     	testq	%rax, %rax
1800032f7:     	je	0x180003307 <numba_list_iter_next+0x617>
1800032f9:     	movq	%rsi, %r8
1800032fc:     	xorl	%edx, %edx
1800032fe:     	movq	%r14, %rcx
180003301:     	callq	*0xf89(%rip)            # 0x180004290
180003307:     	testl	%edi, %edi
180003309:     	je	0x180003310 <numba_list_iter_next+0x620>
18000330b:     	cmpl	$0x3, %edi
18000330e:     	jne	0x18000334c <numba_list_iter_next+0x65c>
180003310:     	movq	%rsi, %r8
180003313:     	movl	%edi, %edx
180003315:     	movq	%r14, %rcx
180003318:     	callq	0x180003050 <numba_list_iter_next+0x360>
18000331d:     	movl	%eax, %ebx
18000331f:     	movl	%eax, 0x30(%rsp)
180003323:     	testl	%eax, %eax
180003325:     	je	0x18000334c <numba_list_iter_next+0x65c>
180003327:     	movq	0x12ba(%rip), %rax      # 0x1800045e8
18000332e:     	testq	%rax, %rax
180003331:     	jne	0x180003338 <numba_list_iter_next+0x648>
180003333:     	leal	0x1(%rax), %ebx
180003336:     	jmp	0x180003348 <numba_list_iter_next+0x658>
180003338:     	movq	%rsi, %r8
18000333b:     	movl	%edi, %edx
18000333d:     	movq	%r14, %rcx
180003340:     	callq	*0xf4a(%rip)            # 0x180004290
180003346:     	movl	%eax, %ebx
180003348:     	movl	%ebx, 0x30(%rsp)
18000334c:     	jmp	0x180003354 <numba_list_iter_next+0x664>
18000334e:     	xorl	%ebx, %ebx
180003350:     	movl	%ebx, 0x30(%rsp)
180003354:     	movl	%ebx, %eax
180003356:     	movq	0x78(%rsp), %rbx
18000335b:     	addq	$0x40, %rsp
18000335f:     	popq	%r14
180003361:     	popq	%rdi
180003362:     	popq	%rsi
180003363:     	retq
180003364:     	movq	%rbx, 0x8(%rsp)
180003369:     	movq	%rsi, 0x10(%rsp)
18000336e:     	pushq	%rdi
18000336f:     	subq	$0x20, %rsp
180003373:     	movq	%r8, %rdi
180003376:     	movl	%edx, %ebx
180003378:     	movq	%rcx, %rsi
18000337b:     	cmpl	$0x1, %edx
18000337e:     	jne	0x180003385 <numba_list_iter_next+0x695>
180003380:     	callq	0x1800033ac <numba_list_iter_next+0x6bc>
180003385:     	movq	%rdi, %r8
180003388:     	movl	%ebx, %edx
18000338a:     	movq	%rsi, %rcx
18000338d:     	movq	0x30(%rsp), %rbx
180003392:     	movq	0x38(%rsp), %rsi
180003397:     	addq	$0x20, %rsp
18000339b:     	popq	%rdi
18000339c:     	jmp	0x18000323c <numba_list_iter_next+0x54c>
1800033a1:     	int3
1800033a2:     	int3
1800033a3:     	int3
1800033a4:     	movl	$0x2, %ecx
1800033a9:     	int	$0x29
1800033ab:     	retq
1800033ac:     	movq	%rbx, 0x18(%rsp)
1800033b1:     	pushq	%rbp
1800033b2:     	movq	%rsp, %rbp
1800033b5:     	subq	$0x30, %rsp
1800033b9:     	movq	0x6d00(%rip), %rax      # 0x18000a0c0
1800033c0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1800033ca:     	cmpq	%rbx, %rax
1800033cd:     	jne	0x180003446 <numba_list_iter_next+0x756>
1800033cf:     	leaq	0x10(%rbp), %rcx
1800033d3:     	movq	$0x0, 0x10(%rbp)
1800033db:     	callq	*0xc3f(%rip)            # 0x180004020
1800033e1:     	movq	0x10(%rbp), %rax
1800033e5:     	movq	%rax, -0x10(%rbp)
1800033e9:     	callq	*0xc29(%rip)            # 0x180004018
1800033ef:     	movl	%eax, %eax
1800033f1:     	xorq	%rax, -0x10(%rbp)
1800033f5:     	callq	*0xc15(%rip)            # 0x180004010
1800033fb:     	movl	%eax, %eax
1800033fd:     	leaq	0x18(%rbp), %rcx
180003401:     	xorq	%rax, -0x10(%rbp)
180003405:     	callq	*0xbf5(%rip)            # 0x180004000
18000340b:     	movl	0x18(%rbp), %eax
18000340e:     	leaq	-0x10(%rbp), %rcx
180003412:     	shlq	$0x20, %rax
180003416:     	xorq	0x18(%rbp), %rax
18000341a:     	xorq	-0x10(%rbp), %rax
18000341e:     	xorq	%rcx, %rax
180003421:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000342b:     	andq	%rcx, %rax
18000342e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180003438:     	cmpq	%rbx, %rax
18000343b:     	cmoveq	%rcx, %rax
18000343f:     	movq	%rax, 0x6c7a(%rip)      # 0x18000a0c0
180003446:     	movq	0x50(%rsp), %rbx
18000344b:     	notq	%rax
18000344e:     	movq	%rax, 0x6cab(%rip)      # 0x18000a100
180003455:     	addq	$0x30, %rsp
180003459:     	popq	%rbp
18000345a:     	retq
18000345b:     	int3
18000345c:     	subq	$0x28, %rsp
180003460:     	cmpl	$0x1, %edx
180003463:     	jne	0x180003475 <numba_list_iter_next+0x785>
180003465:     	cmpq	$0x0, 0x117b(%rip)      # 0x1800045e8
18000346d:     	jne	0x180003475 <numba_list_iter_next+0x785>
18000346f:     	callq	*0xbb3(%rip)            # 0x180004028
180003475:     	movl	$0x1, %eax
18000347a:     	addq	$0x28, %rsp
18000347e:     	retq
18000347f:     	int3
180003480:     	leaq	0x7529(%rip), %rcx      # 0x18000a9b0
180003487:     	jmpq	*0xb7a(%rip)            # 0x180004008
18000348e:     	int3
18000348f:     	int3
180003490:     	leaq	0x7519(%rip), %rcx      # 0x18000a9b0
180003497:     	jmp	0x180003b26 <numba_list_iter_next+0xe36>
18000349c:     	leaq	0x751d(%rip), %rax      # 0x18000a9c0
1800034a3:     	retq
1800034a4:     	subq	$0x28, %rsp
1800034a8:     	callq	0x180002600 <PyInit_rcaotr_cfc86c0ea0bdaa7b4e79b193+0x10e0>
1800034ad:     	orq	$0x24, (%rax)
1800034b1:     	callq	0x18000349c <numba_list_iter_next+0x7ac>
1800034b6:     	orq	$0x2, (%rax)
1800034ba:     	addq	$0x28, %rsp
1800034be:     	retq
1800034bf:     	int3
1800034c0:     	subq	$0x28, %rsp
1800034c4:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
1800034c9:     	testl	%eax, %eax
1800034cb:     	je	0x1800034ee <numba_list_iter_next+0x7fe>
1800034cd:     	movq	%gs:0x30, %rax
1800034d6:     	movq	0x8(%rax), %rcx
1800034da:     	jmp	0x1800034e1 <numba_list_iter_next+0x7f1>
1800034dc:     	cmpq	%rax, %rcx
1800034df:     	je	0x1800034f5 <numba_list_iter_next+0x805>
1800034e1:     	xorl	%eax, %eax
1800034e3:     	lock
1800034e4:     	cmpxchgq	%rcx, 0x74e4(%rip)      # 0x18000a9d0
1800034ec:     	jne	0x1800034dc <numba_list_iter_next+0x7ec>
1800034ee:     	xorb	%al, %al
1800034f0:     	addq	$0x28, %rsp
1800034f4:     	retq
1800034f5:     	movb	$0x1, %al
1800034f7:     	jmp	0x1800034f0 <numba_list_iter_next+0x800>
1800034f9:     	int3
1800034fa:     	int3
1800034fb:     	int3
1800034fc:     	subq	$0x28, %rsp
180003500:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
180003505:     	testl	%eax, %eax
180003507:     	je	0x180003510 <numba_list_iter_next+0x820>
180003509:     	callq	0x180003868 <numba_list_iter_next+0xb78>
18000350e:     	jmp	0x180003529 <numba_list_iter_next+0x839>
180003510:     	callq	0x180003b04 <numba_list_iter_next+0xe14>
180003515:     	movl	%eax, %ecx
180003517:     	callq	0x180003b3e <numba_list_iter_next+0xe4e>
18000351c:     	testl	%eax, %eax
18000351e:     	je	0x180003524 <numba_list_iter_next+0x834>
180003520:     	xorb	%al, %al
180003522:     	jmp	0x18000352b <numba_list_iter_next+0x83b>
180003524:     	callq	0x180003b44 <numba_list_iter_next+0xe54>
180003529:     	movb	$0x1, %al
18000352b:     	addq	$0x28, %rsp
18000352f:     	retq
180003530:     	subq	$0x28, %rsp
180003534:     	xorl	%ecx, %ecx
180003536:     	callq	0x180003668 <numba_list_iter_next+0x978>
18000353b:     	testb	%al, %al
18000353d:     	setne	%al
180003540:     	addq	$0x28, %rsp
180003544:     	retq
180003545:     	int3
180003546:     	int3
180003547:     	int3
180003548:     	subq	$0x28, %rsp
18000354c:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003551:     	testb	%al, %al
180003553:     	jne	0x180003559 <numba_list_iter_next+0x869>
180003555:     	xorb	%al, %al
180003557:     	jmp	0x18000356b <numba_list_iter_next+0x87b>
180003559:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
18000355e:     	testb	%al, %al
180003560:     	jne	0x180003569 <numba_list_iter_next+0x879>
180003562:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003567:     	jmp	0x180003555 <numba_list_iter_next+0x865>
180003569:     	movb	$0x1, %al
18000356b:     	addq	$0x28, %rsp
18000356f:     	retq
180003570:     	subq	$0x28, %rsp
180003574:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003579:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
18000357e:     	movb	$0x1, %al
180003580:     	addq	$0x28, %rsp
180003584:     	retq
180003585:     	int3
180003586:     	int3
180003587:     	int3
180003588:     	movq	%rbx, 0x8(%rsp)
18000358d:     	movq	%rbp, 0x10(%rsp)
180003592:     	movq	%rsi, 0x18(%rsp)
180003597:     	pushq	%rdi
180003598:     	subq	$0x20, %rsp
18000359c:     	movq	%r9, %rdi
18000359f:     	movq	%r8, %rsi
1800035a2:     	movl	%edx, %ebx
1800035a4:     	movq	%rcx, %rbp
1800035a7:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
1800035ac:     	testl	%eax, %eax
1800035ae:     	jne	0x1800035c6 <numba_list_iter_next+0x8d6>
1800035b0:     	cmpl	$0x1, %ebx
1800035b3:     	jne	0x1800035c6 <numba_list_iter_next+0x8d6>
1800035b5:     	movq	%rsi, %r8
1800035b8:     	xorl	%edx, %edx
1800035ba:     	movq	%rbp, %rcx
1800035bd:     	movq	%rdi, %rax
1800035c0:     	callq	*0xcca(%rip)            # 0x180004290
1800035c6:     	movq	0x58(%rsp), %rdx
1800035cb:     	movl	0x50(%rsp), %ecx
1800035cf:     	movq	0x30(%rsp), %rbx
1800035d4:     	movq	0x38(%rsp), %rbp
1800035d9:     	movq	0x40(%rsp), %rsi
1800035de:     	addq	$0x20, %rsp
1800035e2:     	popq	%rdi
1800035e3:     	jmp	0x180003b38 <numba_list_iter_next+0xe48>
1800035e8:     	subq	$0x28, %rsp
1800035ec:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
1800035f1:     	testl	%eax, %eax
1800035f3:     	je	0x180003605 <numba_list_iter_next+0x915>
1800035f5:     	leaq	0x73e4(%rip), %rcx      # 0x18000a9e0
1800035fc:     	addq	$0x28, %rsp
180003600:     	jmp	0x180003b50 <numba_list_iter_next+0xe60>
180003605:     	callq	0x180003b60 <numba_list_iter_next+0xe70>
18000360a:     	testl	%eax, %eax
18000360c:     	jne	0x180003613 <numba_list_iter_next+0x923>
18000360e:     	callq	0x180003b56 <numba_list_iter_next+0xe66>
180003613:     	addq	$0x28, %rsp
180003617:     	retq
180003618:     	subq	$0x28, %rsp
18000361c:     	xorl	%ecx, %ecx
18000361e:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003623:     	addq	$0x28, %rsp
180003627:     	jmp	0x180003b5c <numba_list_iter_next+0xe6c>
18000362c:     	subq	$0x28, %rsp
180003630:     	testl	%ecx, %ecx
180003632:     	jne	0x18000363b <numba_list_iter_next+0x94b>
180003634:     	movb	$0x1, 0x739d(%rip)      # 0x18000a9d8
18000363b:     	callq	0x180003868 <numba_list_iter_next+0xb78>
180003640:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003645:     	testb	%al, %al
180003647:     	jne	0x18000364d <numba_list_iter_next+0x95d>
180003649:     	xorb	%al, %al
18000364b:     	jmp	0x180003661 <numba_list_iter_next+0x971>
18000364d:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
180003652:     	testb	%al, %al
180003654:     	jne	0x18000365f <numba_list_iter_next+0x96f>
180003656:     	xorl	%ecx, %ecx
180003658:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
18000365d:     	jmp	0x180003649 <numba_list_iter_next+0x959>
18000365f:     	movb	$0x1, %al
180003661:     	addq	$0x28, %rsp
180003665:     	retq
180003666:     	int3
180003667:     	int3
180003668:     	pushq	%rbx
18000366a:     	subq	$0x20, %rsp
18000366e:     	cmpb	$0x0, 0x7364(%rip)      # 0x18000a9d9
180003675:     	movl	%ecx, %ebx
180003677:     	jne	0x1800036e0 <numba_list_iter_next+0x9f0>
180003679:     	cmpl	$0x1, %ecx
18000367c:     	ja	0x1800036e8 <numba_list_iter_next+0x9f8>
18000367e:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
180003683:     	testl	%eax, %eax
180003685:     	je	0x1800036af <numba_list_iter_next+0x9bf>
180003687:     	testl	%ebx, %ebx
180003689:     	jne	0x1800036af <numba_list_iter_next+0x9bf>
18000368b:     	leaq	0x734e(%rip), %rcx      # 0x18000a9e0
180003692:     	callq	0x180003b4a <numba_list_iter_next+0xe5a>
180003697:     	testl	%eax, %eax
180003699:     	jne	0x1800036ab <numba_list_iter_next+0x9bb>
18000369b:     	leaq	0x7356(%rip), %rcx      # 0x18000a9f8
1800036a2:     	callq	0x180003b4a <numba_list_iter_next+0xe5a>
1800036a7:     	testl	%eax, %eax
1800036a9:     	je	0x1800036d9 <numba_list_iter_next+0x9e9>
1800036ab:     	xorb	%al, %al
1800036ad:     	jmp	0x1800036e2 <numba_list_iter_next+0x9f2>
1800036af:     	movdqa	0xf39(%rip), %xmm0      # 0x1800045f0
1800036b7:     	orq	$-0x1, %rax
1800036bb:     	movdqu	%xmm0, 0x731d(%rip)     # 0x18000a9e0
1800036c3:     	movq	%rax, 0x7326(%rip)      # 0x18000a9f0
1800036ca:     	movdqu	%xmm0, 0x7326(%rip)     # 0x18000a9f8
1800036d2:     	movq	%rax, 0x732f(%rip)      # 0x18000aa08
1800036d9:     	movb	$0x1, 0x72f9(%rip)      # 0x18000a9d9
1800036e0:     	movb	$0x1, %al
1800036e2:     	addq	$0x20, %rsp
1800036e6:     	popq	%rbx
1800036e7:     	retq
1800036e8:     	movl	$0x5, %ecx
1800036ed:     	callq	0x1800037e4 <numba_list_iter_next+0xaf4>
1800036f2:     	int3
1800036f3:     	int3
1800036f4:     	subq	$0x18, %rsp
1800036f8:     	movq	%rcx, %r8
1800036fb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003700:     	cmpw	%ax, -0x3707(%rip)      # 0x180000000
180003707:     	jne	0x180003781 <numba_list_iter_next+0xa91>
180003709:     	movslq	-0x36d4(%rip), %rcx     # 0x18000003c
180003710:     	leaq	-0x3717(%rip), %rdx     # 0x180000000
180003717:     	addq	%rdx, %rcx
18000371a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003720:     	jne	0x180003781 <numba_list_iter_next+0xa91>
180003722:     	movl	$0x20b, %eax            # imm = 0x20B
180003727:     	cmpw	%ax, 0x18(%rcx)
18000372b:     	jne	0x180003781 <numba_list_iter_next+0xa91>
18000372d:     	subq	%rdx, %r8
180003730:     	movzwl	0x14(%rcx), %edx
180003734:     	addq	$0x18, %rdx
180003738:     	addq	%rcx, %rdx
18000373b:     	movzwl	0x6(%rcx), %eax
18000373f:     	leaq	(%rax,%rax,4), %rcx
180003743:     	leaq	(%rdx,%rcx,8), %r9
180003747:     	movq	%rdx, (%rsp)
18000374b:     	cmpq	%r9, %rdx
18000374e:     	je	0x180003768 <numba_list_iter_next+0xa78>
180003750:     	movl	0xc(%rdx), %ecx
180003753:     	cmpq	%rcx, %r8
180003756:     	jb	0x180003762 <numba_list_iter_next+0xa72>
180003758:     	movl	0x8(%rdx), %eax
18000375b:     	addl	%ecx, %eax
18000375d:     	cmpq	%rax, %r8
180003760:     	jb	0x18000376a <numba_list_iter_next+0xa7a>
180003762:     	addq	$0x28, %rdx
180003766:     	jmp	0x180003747 <numba_list_iter_next+0xa57>
180003768:     	xorl	%edx, %edx
18000376a:     	testq	%rdx, %rdx
18000376d:     	jne	0x180003773 <numba_list_iter_next+0xa83>
18000376f:     	xorb	%al, %al
180003771:     	jmp	0x180003787 <numba_list_iter_next+0xa97>
180003773:     	cmpl	$0x0, 0x24(%rdx)
180003777:     	jge	0x18000377d <numba_list_iter_next+0xa8d>
180003779:     	xorb	%al, %al
18000377b:     	jmp	0x180003787 <numba_list_iter_next+0xa97>
18000377d:     	movb	$0x1, %al
18000377f:     	jmp	0x180003787 <numba_list_iter_next+0xa97>
180003781:     	xorb	%al, %al
180003783:     	jmp	0x180003787 <numba_list_iter_next+0xa97>
180003785:     	xorb	%al, %al
180003787:     	addq	$0x18, %rsp
18000378b:     	retq
18000378c:     	pushq	%rbx
18000378e:     	subq	$0x20, %rsp
180003792:     	movb	%cl, %bl
180003794:     	callq	0x180003b0c <numba_list_iter_next+0xe1c>
180003799:     	xorl	%edx, %edx
18000379b:     	testl	%eax, %eax
18000379d:     	je	0x1800037aa <numba_list_iter_next+0xaba>
18000379f:     	testb	%bl, %bl
1800037a1:     	jne	0x1800037aa <numba_list_iter_next+0xaba>
1800037a3:     	xchgq	%rdx, 0x7226(%rip)      # 0x18000a9d0
1800037aa:     	addq	$0x20, %rsp
1800037ae:     	popq	%rbx
1800037af:     	retq
1800037b0:     	pushq	%rbx
1800037b2:     	subq	$0x20, %rsp
1800037b6:     	cmpb	$0x0, 0x721b(%rip)      # 0x18000a9d8
1800037bd:     	movb	%cl, %bl
1800037bf:     	je	0x1800037c5 <numba_list_iter_next+0xad5>
1800037c1:     	testb	%dl, %dl
1800037c3:     	jne	0x1800037d1 <numba_list_iter_next+0xae1>
1800037c5:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
1800037ca:     	movb	%bl, %cl
1800037cc:     	callq	0x180003b5c <numba_list_iter_next+0xe6c>
1800037d1:     	movb	$0x1, %al
1800037d3:     	addq	$0x20, %rsp
1800037d7:     	popq	%rbx
1800037d8:     	retq
1800037d9:     	int3
1800037da:     	int3
1800037db:     	int3
1800037dc:     	leaq	0x7485(%rip), %rax      # 0x18000ac68
1800037e3:     	retq
1800037e4:     	movl	%ecx, %ecx
1800037e6:     	int	$0x29
1800037e8:     	retq
1800037e9:     	int3
1800037ea:     	int3
1800037eb:     	int3
1800037ec:     	movq	%rbx, 0x8(%rsp)
1800037f1:     	pushq	%rdi
1800037f2:     	subq	$0x20, %rsp
1800037f6:     	leaq	0x37c3(%rip), %rbx      # 0x180006fc0
1800037fd:     	leaq	0x37bc(%rip), %rdi      # 0x180006fc0
180003804:     	jmp	0x180003818 <numba_list_iter_next+0xb28>
180003806:     	movq	(%rbx), %rax
180003809:     	testq	%rax, %rax
18000380c:     	je	0x180003814 <numba_list_iter_next+0xb24>
18000380e:     	callq	*0xa7c(%rip)            # 0x180004290
180003814:     	addq	$0x8, %rbx
180003818:     	cmpq	%rdi, %rbx
18000381b:     	jb	0x180003806 <numba_list_iter_next+0xb16>
18000381d:     	movq	0x30(%rsp), %rbx
180003822:     	addq	$0x20, %rsp
180003826:     	popq	%rdi
180003827:     	retq
180003828:     	movq	%rbx, 0x8(%rsp)
18000382d:     	pushq	%rdi
18000382e:     	subq	$0x20, %rsp
180003832:     	leaq	0x3797(%rip), %rbx      # 0x180006fd0
180003839:     	leaq	0x3790(%rip), %rdi      # 0x180006fd0
180003840:     	jmp	0x180003854 <numba_list_iter_next+0xb64>
180003842:     	movq	(%rbx), %rax
180003845:     	testq	%rax, %rax
180003848:     	je	0x180003850 <numba_list_iter_next+0xb60>
18000384a:     	callq	*0xa40(%rip)            # 0x180004290
180003850:     	addq	$0x8, %rbx
180003854:     	cmpq	%rdi, %rbx
180003857:     	jb	0x180003842 <numba_list_iter_next+0xb52>
180003859:     	movq	0x30(%rsp), %rbx
18000385e:     	addq	$0x20, %rsp
180003862:     	popq	%rdi
180003863:     	retq
180003864:     	retq	$0x0
180003867:     	int3
180003868:     	movq	%rbx, 0x10(%rsp)
18000386d:     	movq	%rbp, 0x18(%rsp)
180003872:     	movq	%rsi, 0x20(%rsp)
180003877:     	pushq	%rdi
180003878:     	subq	$0x10, %rsp
18000387c:     	xorl	%eax, %eax
18000387e:     	xorl	%ecx, %ecx
180003880:     	cpuid
180003882:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003888:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000388e:     	orl	%ecx, %edx
180003890:     	movl	%eax, %ebp
180003892:     	movl	$0x1, %eax
180003897:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000389d:     	orl	%ebx, %edx
18000389f:     	leal	-0x1(%rax), %ecx
1800038a2:     	cpuid
1800038a4:     	movl	%ecx, %edi
1800038a6:     	jne	0x180003906 <numba_list_iter_next+0xc16>
1800038a8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
1800038ad:     	movq	$0x8000, 0x6860(%rip)   # imm = 0x8000
                                                # 0x18000a118
1800038b8:     	movq	$-0x1, 0x685d(%rip)     # 0x18000a120
1800038c3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
1800038c8:     	je	0x1800038f2 <numba_list_iter_next+0xc02>
1800038ca:     	cmpl	$0x20660, %eax          # imm = 0x20660
1800038cf:     	je	0x1800038f2 <numba_list_iter_next+0xc02>
1800038d1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800038d6:     	je	0x1800038f2 <numba_list_iter_next+0xc02>
1800038d8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800038dd:     	cmpl	$0x20, %eax
1800038e0:     	ja	0x180003906 <numba_list_iter_next+0xc16>
1800038e2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1800038ec:     	btq	%rax, %rcx
1800038f0:     	jae	0x180003906 <numba_list_iter_next+0xc16>
1800038f2:     	movl	0x711b(%rip), %r8d      # 0x18000aa14
1800038f9:     	orl	$0x1, %r8d
1800038fd:     	movl	%r8d, 0x7110(%rip)      # 0x18000aa14
180003904:     	jmp	0x18000390d <numba_list_iter_next+0xc1d>
180003906:     	movl	0x7107(%rip), %r8d      # 0x18000aa14
18000390d:     	xorl	%r9d, %r9d
180003910:     	movl	%r9d, %r11d
180003913:     	cmpl	$0x7, %ebp
180003916:     	jl	0x18000395a <numba_list_iter_next+0xc6a>
180003918:     	xorl	%ecx, %ecx
18000391a:     	leal	0x7(%r9), %eax
18000391e:     	cpuid
180003920:     	movl	%edx, %esi
180003922:     	movl	%ebx, %r10d
180003925:     	btl	$0x9, %ebx
180003929:     	jae	0x180003936 <numba_list_iter_next+0xc46>
18000392b:     	orl	$0x2, %r8d
18000392f:     	movl	%r8d, 0x70de(%rip)      # 0x18000aa14
180003936:     	cmpl	$0x1, %eax
180003939:     	jl	0x180003948 <numba_list_iter_next+0xc58>
18000393b:     	movl	$0x7, %eax
180003940:     	leal	-0x6(%rax), %ecx
180003943:     	cpuid
180003945:     	movl	%edx, %r9d
180003948:     	movl	$0x24, %eax
18000394d:     	cmpl	%eax, %ebp
18000394f:     	jl	0x180003960 <numba_list_iter_next+0xc70>
180003951:     	xorl	%ecx, %ecx
180003953:     	cpuid
180003955:     	movl	%ebx, %r11d
180003958:     	jmp	0x180003960 <numba_list_iter_next+0xc70>
18000395a:     	movl	%r9d, %r10d
18000395d:     	movl	%r9d, %esi
180003960:     	movq	0x67c1(%rip), %rax      # 0x18000a128
180003967:     	andq	$-0x2, %rax
18000396b:     	movl	$0x1, 0x679b(%rip)      # 0x18000a110
180003975:     	movl	$0x2, 0x6795(%rip)      # 0x18000a114
18000397f:     	movq	%rax, 0x67a2(%rip)      # 0x18000a128
180003986:     	btl	$0x14, %edi
18000398a:     	jae	0x1800039ab <numba_list_iter_next+0xcbb>
18000398c:     	andq	$-0x11, %rax
180003990:     	movl	$0x2, 0x6776(%rip)      # 0x18000a110
18000399a:     	movq	%rax, 0x6787(%rip)      # 0x18000a128
1800039a1:     	movl	$0x6, 0x6769(%rip)      # 0x18000a114
1800039ab:     	btl	$0x1b, %edi
1800039af:     	jae	0x180003aec <numba_list_iter_next+0xdfc>
1800039b5:     	xorl	%ecx, %ecx
1800039b7:     	xgetbv
1800039ba:     	shlq	$0x20, %rdx
1800039be:     	orq	%rax, %rdx
1800039c1:     	movq	%rdx, 0x20(%rsp)
1800039c6:     	btl	$0x1c, %edi
1800039ca:     	jae	0x180003ad0 <numba_list_iter_next+0xde0>
1800039d0:     	movq	0x20(%rsp), %rax
1800039d5:     	andb	$0x6, %al
1800039d7:     	cmpb	$0x6, %al
1800039d9:     	jne	0x180003ad0 <numba_list_iter_next+0xde0>
1800039df:     	movl	0x672f(%rip), %eax      # 0x18000a114
1800039e5:     	movb	$-0x20, %dl
1800039e7:     	orl	$0x8, %eax
1800039ea:     	movl	$0x3, 0x671c(%rip)      # 0x18000a110
1800039f4:     	movl	%eax, 0x671a(%rip)      # 0x18000a114
1800039fa:     	testb	$0x20, %r10b
1800039fe:     	je	0x180003a62 <numba_list_iter_next+0xd72>
180003a00:     	orl	$0x20, %eax
180003a03:     	movl	$0x5, 0x6703(%rip)      # 0x18000a110
180003a0d:     	movl	%eax, 0x6701(%rip)      # 0x18000a114
180003a13:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003a18:     	movq	0x6709(%rip), %rax      # 0x18000a128
180003a1f:     	andl	%ecx, %r10d
180003a22:     	andq	$-0x3, %rax
180003a26:     	movq	%rax, 0x66fb(%rip)      # 0x18000a128
180003a2d:     	cmpl	%ecx, %r10d
180003a30:     	jne	0x180003a69 <numba_list_iter_next+0xd79>
180003a32:     	movq	0x20(%rsp), %rax
180003a37:     	andb	%dl, %al
180003a39:     	cmpb	%dl, %al
180003a3b:     	jne	0x180003a62 <numba_list_iter_next+0xd72>
180003a3d:     	movq	0x66e4(%rip), %rax      # 0x18000a128
180003a44:     	orl	$0x40, 0x66c9(%rip)     # 0x18000a114
180003a4b:     	andq	$-0x25, %rax
180003a4f:     	movl	$0x6, 0x66b7(%rip)      # 0x18000a110
180003a59:     	movq	%rax, 0x66c8(%rip)      # 0x18000a128
180003a60:     	jmp	0x180003a69 <numba_list_iter_next+0xd79>
180003a62:     	movq	0x66bf(%rip), %rax      # 0x18000a128
180003a69:     	btl	$0x17, %esi
180003a6d:     	jae	0x180003a7b <numba_list_iter_next+0xd8b>
180003a6f:     	btrq	$0x18, %rax
180003a74:     	movq	%rax, 0x66ad(%rip)      # 0x18000a128
180003a7b:     	btl	$0x13, %r9d
180003a80:     	jae	0x180003ad0 <numba_list_iter_next+0xde0>
180003a82:     	movq	0x20(%rsp), %rax
180003a87:     	andb	%dl, %al
180003a89:     	cmpb	%dl, %al
180003a8b:     	jne	0x180003ad0 <numba_list_iter_next+0xde0>
180003a8d:     	movq	0x6694(%rip), %rdx      # 0x18000a128
180003a94:     	movl	%r11d, %eax
180003a97:     	shrq	$0x10, %rax
180003a9b:     	movl	%r11d, %ecx
180003a9e:     	andl	$0x6, %eax
180003aa1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003aa7:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003aad:     	movl	%ecx, 0x6f65(%rip)      # 0x18000aa18
180003ab3:     	notq	%rax
180003ab6:     	andq	%rax, %rdx
180003ab9:     	movq	%rdx, 0x6668(%rip)      # 0x18000a128
180003ac0:     	cmpb	$0x1, %cl
180003ac3:     	jbe	0x180003ad0 <numba_list_iter_next+0xde0>
180003ac5:     	andq	$-0x41, %rdx
180003ac9:     	movq	%rdx, 0x6658(%rip)      # 0x18000a128
180003ad0:     	btl	$0x15, %r9d
180003ad5:     	jae	0x180003aec <numba_list_iter_next+0xdfc>
180003ad7:     	movq	0x20(%rsp), %rax
180003adc:     	btq	$0x13, %rax
180003ae1:     	jae	0x180003aec <numba_list_iter_next+0xdfc>
180003ae3:     	btrq	$0x7, 0x663c(%rip)      # 0x18000a128
180003aec:     	movq	0x28(%rsp), %rbx
180003af1:     	xorl	%eax, %eax
180003af3:     	movq	0x30(%rsp), %rbp
180003af8:     	movq	0x38(%rsp), %rsi
180003afd:     	addq	$0x10, %rsp
180003b01:     	popq	%rdi
180003b02:     	retq
180003b03:     	int3
180003b04:     	movl	$0x1, %eax
180003b09:     	retq
180003b0a:     	int3
180003b0b:     	int3
180003b0c:     	xorl	%eax, %eax
180003b0e:     	cmpl	%eax, 0x661c(%rip)      # 0x18000a130
180003b14:     	setne	%al
180003b17:     	retq
180003b18:     	int3
180003b19:     	int3
180003b1a:     	int3
180003b1b:     	int3
180003b1c:     	int3
180003b1d:     	int3
180003b1e:     	int3
180003b1f:     	int3
180003b20:     	jmpq	*0x522(%rip)            # 0x180004048
180003b26:     	jmpq	*0x524(%rip)            # 0x180004050
180003b2c:     	jmpq	*0x55e(%rip)            # 0x180004090
180003b32:     	jmpq	*0x560(%rip)            # 0x180004098
180003b38:     	jmpq	*0x562(%rip)            # 0x1800040a0
180003b3e:     	jmpq	*0x564(%rip)            # 0x1800040a8
180003b44:     	jmpq	*0x566(%rip)            # 0x1800040b0
180003b4a:     	jmpq	*0x530(%rip)            # 0x180004080
180003b50:     	jmpq	*0x562(%rip)            # 0x1800040b8
180003b56:     	jmpq	*0x52c(%rip)            # 0x180004088
180003b5c:     	movb	$0x1, %al
180003b5e:     	retq
180003b5f:     	int3
180003b60:     	xorl	%eax, %eax
180003b62:     	retq
180003b63:     	jmpq	*0x4cf(%rip)            # 0x180004038
180003b69:     	jmpq	*0x4d1(%rip)            # 0x180004040
180003b6f:     	jmpq	*0x553(%rip)            # 0x1800040c8
180003b75:     	jmpq	*0x555(%rip)            # 0x1800040d0
180003b7b:     	int3
180003b7c:     	int3
180003b7d:     	int3
180003b7e:     	int3
180003b7f:     	int3
180003b80:     	int3
180003b81:     	int3
180003b82:     	int3
180003b83:     	int3
180003b84:     	int3
180003b85:     	int3
180003b86:     	nopw	(%rax,%rax)
180003b90:     	jmpq	*%rax
180003b92:     	int3
180003b93:     	int3
180003b94:     	int3
180003b95:     	int3
180003b96:     	int3
180003b97:     	int3
180003b98:     	int3
180003b99:     	int3
180003b9a:     	int3
180003b9b:     	int3
180003b9c:     	int3
180003b9d:     	int3
180003b9e:     	int3
180003b9f:     	int3
180003ba0:     	int3
180003ba1:     	int3
180003ba2:     	int3
180003ba3:     	int3
180003ba4:     	int3
180003ba5:     	int3
180003ba6:     	nopw	(%rax,%rax)
180003bb0:     	jmpq	*0x6da(%rip)            # 0x180004290
180003bb6:     	pushq	%rbp
180003bb8:     	subq	$0x20, %rsp
180003bbc:     	movq	%rdx, %rbp
180003bbf:     	movb	0x40(%rbp), %cl
180003bc2:     	addq	$0x20, %rsp
180003bc6:     	popq	%rbp
180003bc7:     	jmp	0x18000378c <numba_list_iter_next+0xa9c>
180003bcc:     	int3
180003bcd:     	pushq	%rbp
180003bcf:     	subq	$0x20, %rsp
180003bd3:     	movq	%rdx, %rbp
180003bd6:     	movb	0x20(%rbp), %cl
180003bd9:     	callq	0x18000378c <numba_list_iter_next+0xa9c>
180003bde:     	nop
180003bdf:     	addq	$0x20, %rsp
180003be3:     	popq	%rbp
180003be4:     	retq
180003be5:     	int3
180003be6:     	pushq	%rbp
180003be8:     	subq	$0x20, %rsp
180003bec:     	movq	%rdx, %rbp
180003bef:     	addq	$0x20, %rsp
180003bf3:     	popq	%rbp
180003bf4:     	jmp	0x180003618 <numba_list_iter_next+0x928>
180003bf9:     	int3
180003bfa:     	pushq	%rbp
180003bfc:     	subq	$0x30, %rsp
180003c00:     	movq	%rdx, %rbp
180003c03:     	movq	(%rcx), %rax
180003c06:     	movl	(%rax), %edx
180003c08:     	movq	%rcx, 0x28(%rsp)
180003c0d:     	movl	%edx, 0x20(%rsp)
180003c11:     	leaq	-0xbc8(%rip), %r9       # 0x180003050 <numba_list_iter_next+0x360>
180003c18:     	movq	0x70(%rbp), %r8
180003c1c:     	movl	0x68(%rbp), %edx
180003c1f:     	movq	0x60(%rbp), %rcx
180003c23:     	callq	0x180003588 <numba_list_iter_next+0x898>
180003c28:     	nop
180003c29:     	addq	$0x30, %rsp
180003c2d:     	popq	%rbp
180003c2e:     	retq
180003c2f:     	int3
180003c30:     	pushq	%rbp
180003c32:     	movq	%rdx, %rbp
180003c35:     	movq	(%rcx), %rax
180003c38:     	xorl	%ecx, %ecx
180003c3a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003c40:     	sete	%cl
180003c43:     	movl	%ecx, %eax
180003c45:     	popq	%rbp
180003c46:     	retq
180003c47:     	int3
