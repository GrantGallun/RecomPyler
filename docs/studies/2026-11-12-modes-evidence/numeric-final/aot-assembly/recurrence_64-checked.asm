
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-binding-final\aot\checked\recurrence_64\rcnumeric_2a3c148c01090ea2b4a04532.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002fa0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3319(%rip), %rax      # 0x1800043a0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	imulq	%r8, %rdx
180001094:     	addq	%r9, %rdx
180001097:     	imulq	%r8, %rdx
18000109b:     	addq	%r9, %rdx
18000109e:     	imulq	%r8, %rdx
1800010a2:     	addq	%r9, %rdx
1800010a5:     	imulq	%r8, %rdx
1800010a9:     	addq	%r9, %rdx
1800010ac:     	imulq	%r8, %rdx
1800010b0:     	addq	%r9, %rdx
1800010b3:     	imulq	%r8, %rdx
1800010b7:     	addq	%r9, %rdx
1800010ba:     	imulq	%r8, %rdx
1800010be:     	addq	%r9, %rdx
1800010c1:     	imulq	%r8, %rdx
1800010c5:     	addq	%r9, %rdx
1800010c8:     	imulq	%r8, %rdx
1800010cc:     	addq	%r9, %rdx
1800010cf:     	imulq	%r8, %rdx
1800010d3:     	addq	%r9, %rdx
1800010d6:     	imulq	%r8, %rdx
1800010da:     	addq	%r9, %rdx
1800010dd:     	imulq	%r8, %rdx
1800010e1:     	addq	%r9, %rdx
1800010e4:     	imulq	%r8, %rdx
1800010e8:     	addq	%r9, %rdx
1800010eb:     	imulq	%r8, %rdx
1800010ef:     	addq	%r9, %rdx
1800010f2:     	imulq	%r8, %rdx
1800010f6:     	addq	%r9, %rdx
1800010f9:     	imulq	%r8, %rdx
1800010fd:     	addq	%r9, %rdx
180001100:     	imulq	%r8, %rdx
180001104:     	addq	%r9, %rdx
180001107:     	imulq	%r8, %rdx
18000110b:     	addq	%r9, %rdx
18000110e:     	imulq	%r8, %rdx
180001112:     	addq	%r9, %rdx
180001115:     	imulq	%r8, %rdx
180001119:     	addq	%r9, %rdx
18000111c:     	imulq	%r8, %rdx
180001120:     	addq	%r9, %rdx
180001123:     	imulq	%r8, %rdx
180001127:     	addq	%r9, %rdx
18000112a:     	imulq	%r8, %rdx
18000112e:     	addq	%r9, %rdx
180001131:     	imulq	%r8, %rdx
180001135:     	addq	%r9, %rdx
180001138:     	imulq	%r8, %rdx
18000113c:     	addq	%r9, %rdx
18000113f:     	imulq	%r8, %rdx
180001143:     	addq	%r9, %rdx
180001146:     	imulq	%r8, %rdx
18000114a:     	addq	%r9, %rdx
18000114d:     	imulq	%r8, %rdx
180001151:     	addq	%r9, %rdx
180001154:     	imulq	%r8, %rdx
180001158:     	addq	%r9, %rdx
18000115b:     	imulq	%r8, %rdx
18000115f:     	addq	%r9, %rdx
180001162:     	imulq	%r8, %rdx
180001166:     	addq	%r9, %rdx
180001169:     	imulq	%r8, %rdx
18000116d:     	addq	%r9, %rdx
180001170:     	imulq	%r8, %rdx
180001174:     	addq	%r9, %rdx
180001177:     	imulq	%r8, %rdx
18000117b:     	addq	%r9, %rdx
18000117e:     	imulq	%r8, %rdx
180001182:     	addq	%r9, %rdx
180001185:     	imulq	%r8, %rdx
180001189:     	addq	%r9, %rdx
18000118c:     	imulq	%r8, %rdx
180001190:     	addq	%r9, %rdx
180001193:     	imulq	%r8, %rdx
180001197:     	addq	%r9, %rdx
18000119a:     	imulq	%r8, %rdx
18000119e:     	addq	%r9, %rdx
1800011a1:     	imulq	%r8, %rdx
1800011a5:     	addq	%r9, %rdx
1800011a8:     	imulq	%r8, %rdx
1800011ac:     	addq	%r9, %rdx
1800011af:     	imulq	%r8, %rdx
1800011b3:     	addq	%r9, %rdx
1800011b6:     	imulq	%r8, %rdx
1800011ba:     	addq	%r9, %rdx
1800011bd:     	imulq	%r8, %rdx
1800011c1:     	addq	%r9, %rdx
1800011c4:     	imulq	%r8, %rdx
1800011c8:     	addq	%r9, %rdx
1800011cb:     	imulq	%r8, %rdx
1800011cf:     	addq	%r9, %rdx
1800011d2:     	imulq	%r8, %rdx
1800011d6:     	addq	%r9, %rdx
1800011d9:     	imulq	%r8, %rdx
1800011dd:     	addq	%r9, %rdx
1800011e0:     	imulq	%r8, %rdx
1800011e4:     	addq	%r9, %rdx
1800011e7:     	imulq	%r8, %rdx
1800011eb:     	addq	%r9, %rdx
1800011ee:     	imulq	%r8, %rdx
1800011f2:     	addq	%r9, %rdx
1800011f5:     	imulq	%r8, %rdx
1800011f9:     	addq	%r9, %rdx
1800011fc:     	imulq	%r8, %rdx
180001200:     	addq	%r9, %rdx
180001203:     	imulq	%r8, %rdx
180001207:     	addq	%r9, %rdx
18000120a:     	imulq	%r8, %rdx
18000120e:     	addq	%r9, %rdx
180001211:     	imulq	%r8, %rdx
180001215:     	addq	%r9, %rdx
180001218:     	imulq	%r8, %rdx
18000121c:     	addq	%r9, %rdx
18000121f:     	imulq	%r8, %rdx
180001223:     	addq	%r9, %rdx
180001226:     	imulq	%r8, %rdx
18000122a:     	addq	%r9, %rdx
18000122d:     	imulq	%r8, %rdx
180001231:     	addq	%r9, %rdx
180001234:     	imulq	%r8, %rdx
180001238:     	addq	%r9, %rdx
18000123b:     	imulq	%r8, %rdx
18000123f:     	addq	%r9, %rdx
180001242:     	imulq	%r8, %rdx
180001246:     	addq	%r9, %rdx
180001249:     	imulq	%r8, %rdx
18000124d:     	addq	%r9, %rdx
180001250:     	movq	%rdx, (%rcx)
180001253:     	retq
180001254:     	nopw	%cs:(%rax,%rax)
18000125e:     	nop
180001260:     	pushq	%r15
180001262:     	pushq	%r14
180001264:     	pushq	%r13
180001266:     	pushq	%r12
180001268:     	pushq	%rsi
180001269:     	pushq	%rdi
18000126a:     	pushq	%rbp
18000126b:     	pushq	%rbx
18000126c:     	subq	$0x198, %rsp            # imm = 0x198
180001273:     	movq	%rdx, %rcx
180001276:     	leaq	0x68(%rsp), %rax
18000127b:     	movq	%rax, 0x50(%rsp)
180001280:     	leaq	0x70(%rsp), %rax
180001285:     	movq	%rax, 0x48(%rsp)
18000128a:     	leaq	0x78(%rsp), %rax
18000128f:     	movq	%rax, 0x40(%rsp)
180001294:     	leaq	0x80(%rsp), %rax
18000129c:     	movq	%rax, 0x38(%rsp)
1800012a1:     	leaq	0x88(%rsp), %rax
1800012a9:     	movq	%rax, 0x30(%rsp)
1800012ae:     	leaq	0x90(%rsp), %rax
1800012b6:     	movq	%rax, 0x28(%rsp)
1800012bb:     	leaq	0x98(%rsp), %rax
1800012c3:     	movq	%rax, 0x20(%rsp)
1800012c8:     	leaq	0x3101(%rip), %rdx      # 0x1800043d0
1800012cf:     	movl	$0x7, %r8d
1800012d5:     	movl	$0x7, %r9d
1800012db:     	callq	0x180003131 <numba_list_iter_next+0x2f1>
1800012e0:     	testl	%eax, %eax
1800012e2:     	movq	$0x0, 0x60(%rsp)
1800012eb:     	je	0x18000162b <.text+0x62b>
1800012f1:     	cmpq	$0x0, 0x9967(%rip)      # 0x18000ac60
1800012f9:     	je	0x180001565 <.text+0x565>
1800012ff:     	movq	0x98(%rsp), %rcx
180001307:     	xorps	%xmm0, %xmm0
18000130a:     	movaps	%xmm0, 0x160(%rsp)
180001312:     	movaps	%xmm0, 0x170(%rsp)
18000131a:     	movaps	%xmm0, 0x180(%rsp)
180001322:     	movq	$0x0, 0x190(%rsp)
18000132e:     	leaq	0x160(%rsp), %rdx
180001336:     	callq	0x180001e10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7a0>
18000133b:     	testl	%eax, %eax
18000133d:     	jne	0x18000157d <.text+0x57d>
180001343:     	cmpq	$0x8, 0x178(%rsp)
18000134c:     	jne	0x18000157d <.text+0x57d>
180001352:     	movq	0x160(%rsp), %rsi
18000135a:     	movq	0x90(%rsp), %rcx
180001362:     	xorps	%xmm0, %xmm0
180001365:     	movaps	%xmm0, 0x120(%rsp)
18000136d:     	movaps	%xmm0, 0x130(%rsp)
180001375:     	movaps	%xmm0, 0x140(%rsp)
18000137d:     	movq	$0x0, 0x150(%rsp)
180001389:     	leaq	0x120(%rsp), %rdx
180001391:     	callq	0x180001e10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7a0>
180001396:     	testl	%eax, %eax
180001398:     	jne	0x180001595 <.text+0x595>
18000139e:     	cmpq	$0x8, 0x138(%rsp)
1800013a7:     	jne	0x180001595 <.text+0x595>
1800013ad:     	movq	0x120(%rsp), %rdi
1800013b5:     	movq	0x88(%rsp), %rcx
1800013bd:     	xorps	%xmm0, %xmm0
1800013c0:     	movaps	%xmm0, 0xe0(%rsp)
1800013c8:     	movaps	%xmm0, 0xf0(%rsp)
1800013d0:     	movaps	%xmm0, 0x100(%rsp)
1800013d8:     	movq	$0x0, 0x110(%rsp)
1800013e4:     	leaq	0xe0(%rsp), %rdx
1800013ec:     	callq	0x180001e10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7a0>
1800013f1:     	testl	%eax, %eax
1800013f3:     	jne	0x1800015aa <.text+0x5aa>
1800013f9:     	cmpq	$0x8, 0xf8(%rsp)
180001402:     	jne	0x1800015aa <.text+0x5aa>
180001408:     	movq	0xe0(%rsp), %rbx
180001410:     	movq	0x80(%rsp), %rcx
180001418:     	xorps	%xmm0, %xmm0
18000141b:     	movaps	%xmm0, 0xa0(%rsp)
180001423:     	movaps	%xmm0, 0xb0(%rsp)
18000142b:     	movaps	%xmm0, 0xc0(%rsp)
180001433:     	movq	$0x0, 0xd0(%rsp)
18000143f:     	leaq	0xa0(%rsp), %rdx
180001447:     	callq	0x180001e10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7a0>
18000144c:     	testl	%eax, %eax
18000144e:     	jne	0x1800015bf <.text+0x5bf>
180001454:     	cmpq	$0x1, 0xb8(%rsp)
18000145d:     	jne	0x1800015bf <.text+0x5bf>
180001463:     	movq	0xa0(%rsp), %r14
18000146b:     	movq	0x78(%rsp), %rcx
180001470:     	callq	0x180003137 <numba_list_iter_next+0x2f7>
180001475:     	testq	%rax, %rax
180001478:     	je	0x1800015d4 <.text+0x5d4>
18000147e:     	movq	%rax, %r12
180001481:     	movq	%rax, %rcx
180001484:     	callq	0x18000313d <numba_list_iter_next+0x2fd>
180001489:     	movq	%rax, %r15
18000148c:     	movq	%r12, %rcx
18000148f:     	callq	0x180003143 <numba_list_iter_next+0x303>
180001494:     	callq	0x180003149 <numba_list_iter_next+0x309>
180001499:     	testq	%rax, %rax
18000149c:     	jne	0x18000160b <.text+0x60b>
1800014a2:     	movq	0x70(%rsp), %rcx
1800014a7:     	callq	0x180003137 <numba_list_iter_next+0x2f7>
1800014ac:     	testq	%rax, %rax
1800014af:     	je	0x1800015e7 <.text+0x5e7>
1800014b5:     	movq	%rax, %r13
1800014b8:     	movq	%rax, %rcx
1800014bb:     	callq	0x18000313d <numba_list_iter_next+0x2fd>
1800014c0:     	movq	%rax, %r12
1800014c3:     	movq	%r13, %rcx
1800014c6:     	callq	0x180003143 <numba_list_iter_next+0x303>
1800014cb:     	callq	0x180003149 <numba_list_iter_next+0x309>
1800014d0:     	testq	%rax, %rax
1800014d3:     	jne	0x18000160b <.text+0x60b>
1800014d9:     	movq	0x68(%rsp), %rcx
1800014de:     	callq	0x180003137 <numba_list_iter_next+0x2f7>
1800014e3:     	testq	%rax, %rax
1800014e6:     	je	0x1800015fa <.text+0x5fa>
1800014ec:     	movq	%rax, %rbp
1800014ef:     	movq	%rax, %rcx
1800014f2:     	callq	0x18000313d <numba_list_iter_next+0x2fd>
1800014f7:     	movq	%rax, %r13
1800014fa:     	movq	%rbp, %rcx
1800014fd:     	callq	0x180003143 <numba_list_iter_next+0x303>
180001502:     	callq	0x180003149 <numba_list_iter_next+0x309>
180001507:     	testq	%rax, %rax
18000150a:     	jne	0x18000160b <.text+0x60b>
180001510:     	leaq	0x60(%rsp), %rcx
180001515:     	movq	%r15, %rdx
180001518:     	movq	%r12, %r8
18000151b:     	movq	%r13, %r9
18000151e:     	callq	0x180001090 <.text+0x90>
180001523:     	movq	0x60(%rsp), %r15
180001528:     	movq	%rsi, %rcx
18000152b:     	callq	0x180001060 <.text+0x60>
180001530:     	movq	%rdi, %rcx
180001533:     	callq	0x180001060 <.text+0x60>
180001538:     	movq	%rbx, %rcx
18000153b:     	callq	0x180001060 <.text+0x60>
180001540:     	movq	%r14, %rcx
180001543:     	callq	0x180001060 <.text+0x60>
180001548:     	movq	%r15, %rcx
18000154b:     	callq	0x18000314f <numba_list_iter_next+0x30f>
180001550:     	nop
180001551:     	addq	$0x198, %rsp            # imm = 0x198
180001558:     	popq	%rbx
180001559:     	popq	%rbp
18000155a:     	popq	%rdi
18000155b:     	popq	%rsi
18000155c:     	popq	%r12
18000155e:     	popq	%r13
180001560:     	popq	%r14
180001562:     	popq	%r15
180001564:     	retq
180001565:     	movq	0x2ccc(%rip), %rcx      # 0x180004238
18000156c:     	leaq	0x2e7d(%rip), %rdx      # 0x1800043f0
180001573:     	callq	0x180003155 <numba_list_iter_next+0x315>
180001578:     	jmp	0x18000162b <.text+0x62b>
18000157d:     	movq	0x2ca4(%rip), %rcx      # 0x180004228
180001584:     	leaq	0x2f55(%rip), %rdx      # 0x1800044e0
18000158b:     	callq	0x180003155 <numba_list_iter_next+0x315>
180001590:     	jmp	0x18000162b <.text+0x62b>
180001595:     	movq	0x2c8c(%rip), %rcx      # 0x180004228
18000159c:     	leaq	0x2f3d(%rip), %rdx      # 0x1800044e0
1800015a3:     	callq	0x180003155 <numba_list_iter_next+0x315>
1800015a8:     	jmp	0x180001623 <.text+0x623>
1800015aa:     	movq	0x2c77(%rip), %rcx      # 0x180004228
1800015b1:     	leaq	0x2f28(%rip), %rdx      # 0x1800044e0
1800015b8:     	callq	0x180003155 <numba_list_iter_next+0x315>
1800015bd:     	jmp	0x18000161b <.text+0x61b>
1800015bf:     	movq	0x2c62(%rip), %rcx      # 0x180004228
1800015c6:     	leaq	0x2f13(%rip), %rdx      # 0x1800044e0
1800015cd:     	callq	0x180003155 <numba_list_iter_next+0x315>
1800015d2:     	jmp	0x180001613 <.text+0x613>
1800015d4:     	xorl	%r15d, %r15d
1800015d7:     	callq	0x180003149 <numba_list_iter_next+0x309>
1800015dc:     	testq	%rax, %rax
1800015df:     	je	0x1800014a2 <.text+0x4a2>
1800015e5:     	jmp	0x18000160b <.text+0x60b>
1800015e7:     	xorl	%r12d, %r12d
1800015ea:     	callq	0x180003149 <numba_list_iter_next+0x309>
1800015ef:     	testq	%rax, %rax
1800015f2:     	je	0x1800014d9 <.text+0x4d9>
1800015f8:     	jmp	0x18000160b <.text+0x60b>
1800015fa:     	xorl	%r13d, %r13d
1800015fd:     	callq	0x180003149 <numba_list_iter_next+0x309>
180001602:     	testq	%rax, %rax
180001605:     	je	0x180001510 <.text+0x510>
18000160b:     	movq	%r14, %rcx
18000160e:     	callq	0x180001060 <.text+0x60>
180001613:     	movq	%rbx, %rcx
180001616:     	callq	0x180001060 <.text+0x60>
18000161b:     	movq	%rdi, %rcx
18000161e:     	callq	0x180001060 <.text+0x60>
180001623:     	movq	%rsi, %rcx
180001626:     	callq	0x180001060 <.text+0x60>
18000162b:     	xorl	%eax, %eax
18000162d:     	jmp	0x180001551 <.text+0x551>
180001632:     	nopw	%cs:(%rax,%rax)
18000163c:     	nopl	(%rax)
180001640:     	subq	$0x28, %rsp
180001644:     	movq	0x110(%rsp), %rdx
18000164c:     	movq	0x118(%rsp), %r8
180001654:     	movq	0x120(%rsp), %r9
18000165c:     	leaq	0x20(%rsp), %rcx
180001661:     	callq	0x180001090 <.text+0x90>
180001666:     	movq	0x20(%rsp), %rax
18000166b:     	addq	$0x28, %rsp
18000166f:     	retq

0000000180001670 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532>:
180001670:     	pushq	%rsi
180001671:     	subq	$0x20, %rsp
180001675:     	leaq	0x89c4(%rip), %rcx      # 0x18000a040
18000167c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001681:     	callq	0x18000315b <numba_list_iter_next+0x31b>
180001686:     	testq	%rax, %rax
180001689:     	je	0x1800016bb <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x4b>
18000168b:     	leaq	0x896e(%rip), %rdx      # 0x18000a000
180001692:     	leaq	0x2ef7(%rip), %r8       # 0x180004590
180001699:     	leaq	0x2f18(%rip), %r9       # 0x1800045b8
1800016a0:     	movq	%rax, %rcx
1800016a3:     	movq	%rax, %rsi
1800016a6:     	callq	0x180002080 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xa10>
1800016ab:     	movl	%eax, %ecx
1800016ad:     	xorl	%eax, %eax
1800016af:     	testl	%ecx, %ecx
1800016b1:     	cmoveq	%rsi, %rax
1800016b5:     	addq	$0x20, %rsp
1800016b9:     	popq	%rsi
1800016ba:     	retq
1800016bb:     	xorl	%eax, %eax
1800016bd:     	addq	$0x20, %rsp
1800016c1:     	popq	%rsi
1800016c2:     	retq
1800016c3:     	int3
1800016c4:     	int3
1800016c5:     	int3
1800016c6:     	int3
1800016c7:     	int3
1800016c8:     	int3
1800016c9:     	int3
1800016ca:     	int3
1800016cb:     	int3
1800016cc:     	int3
1800016cd:     	int3
1800016ce:     	int3
1800016cf:     	int3
1800016d0:     	movq	%rbx, 0x8(%rsp)
1800016d5:     	movq	%rsi, 0x10(%rsp)
1800016da:     	pushq	%rdi
1800016db:     	subq	$0x20, %rsp
1800016df:     	movq	%rcx, %rbx
1800016e2:     	movq	%r8, %rdi
1800016e5:     	movq	0x10(%rcx), %rcx
1800016e9:     	movq	%rdx, %rsi
1800016ec:     	testq	%rcx, %rcx
1800016ef:     	je	0x1800016fa <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x8a>
1800016f1:     	movq	%r8, %rdx
1800016f4:     	callq	*%rsi
1800016f6:     	testl	%eax, %eax
1800016f8:     	jne	0x18000171d <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xad>
1800016fa:     	movq	0x18(%rbx), %rcx
1800016fe:     	testq	%rcx, %rcx
180001701:     	je	0x18000171b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xab>
180001703:     	movq	%rdi, %rdx
180001706:     	movq	%rsi, %rax
180001709:     	movq	0x30(%rsp), %rbx
18000170e:     	movq	0x38(%rsp), %rsi
180001713:     	addq	$0x20, %rsp
180001717:     	popq	%rdi
180001718:     	jmpq	*%rax
18000171b:     	xorl	%eax, %eax
18000171d:     	movq	0x30(%rsp), %rbx
180001722:     	movq	0x38(%rsp), %rsi
180001727:     	addq	$0x20, %rsp
18000172b:     	popq	%rdi
18000172c:     	retq
18000172d:     	int3
18000172e:     	int3
18000172f:     	int3
180001730:     	pushq	%rbx
180001732:     	subq	$0x20, %rsp
180001736:     	movq	%rcx, %rbx
180001739:     	movq	0x10(%rcx), %rcx
18000173d:     	testq	%rcx, %rcx
180001740:     	je	0x18000175d <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xed>
180001742:     	movq	$0x0, 0x10(%rbx)
18000174a:     	movl	(%rcx), %eax
18000174c:     	testl	%eax, %eax
18000174e:     	js	0x18000175d <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xed>
180001750:     	subl	$0x1, %eax
180001753:     	movl	%eax, (%rcx)
180001755:     	jne	0x18000175d <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xed>
180001757:     	callq	*0x2a53(%rip)           # 0x1800041b0
18000175d:     	movq	0x18(%rbx), %rcx
180001761:     	testq	%rcx, %rcx
180001764:     	je	0x180001781 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x111>
180001766:     	movq	$0x0, 0x18(%rbx)
18000176e:     	movl	(%rcx), %eax
180001770:     	testl	%eax, %eax
180001772:     	js	0x180001781 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x111>
180001774:     	subl	$0x1, %eax
180001777:     	movl	%eax, (%rcx)
180001779:     	jne	0x180001781 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x111>
18000177b:     	callq	*0x2a2f(%rip)           # 0x1800041b0
180001781:     	xorl	%eax, %eax
180001783:     	addq	$0x20, %rsp
180001787:     	popq	%rbx
180001788:     	retq
180001789:     	int3
18000178a:     	int3
18000178b:     	int3
18000178c:     	int3
18000178d:     	int3
18000178e:     	int3
18000178f:     	int3
180001790:     	pushq	%rbx
180001792:     	subq	$0x20, %rsp
180001796:     	movq	%rcx, %rbx
180001799:     	callq	*0x2a51(%rip)           # 0x1800041f0
18000179f:     	movq	0x10(%rbx), %rcx
1800017a3:     	testq	%rcx, %rcx
1800017a6:     	je	0x1800017c3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x153>
1800017a8:     	movq	$0x0, 0x10(%rbx)
1800017b0:     	movl	(%rcx), %eax
1800017b2:     	testl	%eax, %eax
1800017b4:     	js	0x1800017c3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x153>
1800017b6:     	subl	$0x1, %eax
1800017b9:     	movl	%eax, (%rcx)
1800017bb:     	jne	0x1800017c3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x153>
1800017bd:     	callq	*0x29ed(%rip)           # 0x1800041b0
1800017c3:     	movq	0x18(%rbx), %rcx
1800017c7:     	testq	%rcx, %rcx
1800017ca:     	je	0x1800017e7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x177>
1800017cc:     	movq	$0x0, 0x18(%rbx)
1800017d4:     	movl	(%rcx), %eax
1800017d6:     	testl	%eax, %eax
1800017d8:     	js	0x1800017e7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x177>
1800017da:     	subl	$0x1, %eax
1800017dd:     	movl	%eax, (%rcx)
1800017df:     	jne	0x1800017e7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x177>
1800017e1:     	callq	*0x29c9(%rip)           # 0x1800041b0
1800017e7:     	movq	0x8(%rbx), %rax
1800017eb:     	movq	%rbx, %rcx
1800017ee:     	addq	$0x20, %rsp
1800017f2:     	popq	%rbx
1800017f3:     	jmpq	*0x140(%rax)
1800017fa:     	int3
1800017fb:     	int3
1800017fc:     	int3
1800017fd:     	int3
1800017fe:     	int3
1800017ff:     	int3
180001800:     	pushq	%rbx
180001802:     	subq	$0x30, %rsp
180001806:     	movq	%r8, %r10
180001809:     	leaq	0x58(%rsp), %rax
18000180e:     	movq	%rax, 0x28(%rsp)
180001813:     	leaq	0x9176(%rip), %r9       # 0x18000a990
18000181a:     	movq	0x299f(%rip), %rax      # 0x1800041c0
180001821:     	leaq	0x30d0(%rip), %r8       # 0x1800048f8
180001828:     	movq	%rdx, %r11
18000182b:     	movq	%rax, 0x20(%rsp)
180001830:     	movq	%rcx, %rbx
180001833:     	movq	%r10, %rdx
180001836:     	movq	%r11, %rcx
180001839:     	callq	*0x28a1(%rip)           # 0x1800040e0
18000183f:     	testl	%eax, %eax
180001841:     	je	0x18000189c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x22c>
180001843:     	xorl	%r8d, %r8d
180001846:     	xorl	%edx, %edx
180001848:     	movq	%rbx, %rcx
18000184b:     	callq	*0x29bf(%rip)           # 0x180004210
180001851:     	movq	%rax, %rbx
180001854:     	testq	%rax, %rax
180001857:     	je	0x18000189c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x22c>
180001859:     	movq	0x58(%rsp), %rax
18000185e:     	movl	(%rax), %ecx
180001860:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001866:     	jae	0x180001871 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x201>
180001868:     	incl	%ecx
18000186a:     	movl	%ecx, (%rax)
18000186c:     	movq	0x58(%rsp), %rax
180001871:     	xorl	%ecx, %ecx
180001873:     	movq	%rax, 0x10(%rbx)
180001877:     	callq	*0x28f3(%rip)           # 0x180004170
18000187d:     	movq	%rax, 0x18(%rbx)
180001881:     	testq	%rax, %rax
180001884:     	jne	0x1800018a4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x234>
180001886:     	movl	(%rbx), %eax
180001888:     	testl	%eax, %eax
18000188a:     	js	0x18000189c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x22c>
18000188c:     	subl	$0x1, %eax
18000188f:     	movl	%eax, (%rbx)
180001891:     	jne	0x18000189c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x22c>
180001893:     	movq	%rbx, %rcx
180001896:     	callq	*0x2914(%rip)           # 0x1800041b0
18000189c:     	xorl	%eax, %eax
18000189e:     	addq	$0x30, %rsp
1800018a2:     	popq	%rbx
1800018a3:     	retq
1800018a4:     	movq	%rbx, %rax
1800018a7:     	addq	$0x30, %rsp
1800018ab:     	popq	%rbx
1800018ac:     	retq
1800018ad:     	int3
1800018ae:     	int3
1800018af:     	int3
1800018b0:     	movq	%rbx, 0x8(%rsp)
1800018b5:     	movq	%rsi, 0x10(%rsp)
1800018ba:     	pushq	%rdi
1800018bb:     	subq	$0x20, %rsp
1800018bf:     	movq	%rcx, %rbx
1800018c2:     	movq	%r8, %rdi
1800018c5:     	movq	0x18(%rcx), %rcx
1800018c9:     	movq	%rdx, %rsi
1800018cc:     	testq	%rcx, %rcx
1800018cf:     	je	0x1800018da <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x26a>
1800018d1:     	movq	%r8, %rdx
1800018d4:     	callq	*%rsi
1800018d6:     	testl	%eax, %eax
1800018d8:     	jne	0x1800018fd <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x28d>
1800018da:     	movq	0x40(%rbx), %rcx
1800018de:     	testq	%rcx, %rcx
1800018e1:     	je	0x1800018fb <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x28b>
1800018e3:     	movq	%rdi, %rdx
1800018e6:     	movq	%rsi, %rax
1800018e9:     	movq	0x30(%rsp), %rbx
1800018ee:     	movq	0x38(%rsp), %rsi
1800018f3:     	addq	$0x20, %rsp
1800018f7:     	popq	%rdi
1800018f8:     	jmpq	*%rax
1800018fb:     	xorl	%eax, %eax
1800018fd:     	movq	0x30(%rsp), %rbx
180001902:     	movq	0x38(%rsp), %rsi
180001907:     	addq	$0x20, %rsp
18000190b:     	popq	%rdi
18000190c:     	retq
18000190d:     	int3
18000190e:     	int3
18000190f:     	int3
180001910:     	pushq	%rbx
180001912:     	subq	$0x20, %rsp
180001916:     	movq	%rcx, %rbx
180001919:     	callq	*0x28d1(%rip)           # 0x1800041f0
18000191f:     	cmpq	$0x0, 0x48(%rbx)
180001924:     	je	0x18000192f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x2bf>
180001926:     	movq	%rbx, %rcx
180001929:     	callq	*0x2851(%rip)           # 0x180004180
18000192f:     	movq	0x20(%rbx), %rcx
180001933:     	callq	*0x2867(%rip)           # 0x1800041a0
180001939:     	movq	0x38(%rbx), %rcx
18000193d:     	callq	*0x285d(%rip)           # 0x1800041a0
180001943:     	movq	0x18(%rbx), %rcx
180001947:     	testq	%rcx, %rcx
18000194a:     	je	0x18000195f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x2ef>
18000194c:     	movl	(%rcx), %eax
18000194e:     	testl	%eax, %eax
180001950:     	js	0x18000195f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x2ef>
180001952:     	subl	$0x1, %eax
180001955:     	movl	%eax, (%rcx)
180001957:     	jne	0x18000195f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x2ef>
180001959:     	callq	*0x2851(%rip)           # 0x1800041b0
18000195f:     	movq	0x40(%rbx), %rcx
180001963:     	testq	%rcx, %rcx
180001966:     	je	0x18000197b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x30b>
180001968:     	movl	(%rcx), %eax
18000196a:     	testl	%eax, %eax
18000196c:     	js	0x18000197b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x30b>
18000196e:     	subl	$0x1, %eax
180001971:     	movl	%eax, (%rcx)
180001973:     	jne	0x18000197b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x30b>
180001975:     	callq	*0x2835(%rip)           # 0x1800041b0
18000197b:     	movq	0x8(%rbx), %rax
18000197f:     	movq	%rbx, %rcx
180001982:     	addq	$0x20, %rsp
180001986:     	popq	%rbx
180001987:     	jmpq	*0x140(%rax)
18000198e:     	int3
18000198f:     	int3
180001990:     	pushq	%rbx
180001992:     	subq	$0x20, %rsp
180001996:     	callq	*0x27dc(%rip)           # 0x180004178
18000199c:     	movq	%rax, %rbx
18000199f:     	testq	%rax, %rax
1800019a2:     	jne	0x1800019aa <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x33a>
1800019a4:     	addq	$0x20, %rsp
1800019a8:     	popq	%rbx
1800019a9:     	retq
1800019aa:     	movq	%rbx, %rcx
1800019ad:     	movq	%rdi, 0x30(%rsp)
1800019b2:     	callq	0x180003cc5 <numba_list_iter_next+0xe85>
1800019b7:     	leaq	0x1(%rax), %rcx
1800019bb:     	callq	*0x2857(%rip)           # 0x180004218
1800019c1:     	movq	%rax, %rdi
1800019c4:     	testq	%rax, %rax
1800019c7:     	jne	0x1800019dc <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x36c>
1800019c9:     	callq	*0x2769(%rip)           # 0x180004138
1800019cf:     	movq	0x30(%rsp), %rdi
1800019d4:     	xorl	%eax, %eax
1800019d6:     	addq	$0x20, %rsp
1800019da:     	popq	%rbx
1800019db:     	retq
1800019dc:     	movq	%rbx, %rdx
1800019df:     	movq	%rdi, %rcx
1800019e2:     	callq	0x180003cbf <numba_list_iter_next+0xe7f>
1800019e7:     	movq	%rdi, %rax
1800019ea:     	movq	0x30(%rsp), %rdi
1800019ef:     	addq	$0x20, %rsp
1800019f3:     	popq	%rbx
1800019f4:     	retq
1800019f5:     	int3
1800019f6:     	int3
1800019f7:     	int3
1800019f8:     	int3
1800019f9:     	int3
1800019fa:     	int3
1800019fb:     	int3
1800019fc:     	int3
1800019fd:     	int3
1800019fe:     	int3
1800019ff:     	int3
180001a00:     	movq	0x18(%rcx), %rcx
180001a04:     	movq	%rdx, %rax
180001a07:     	testq	%rcx, %rcx
180001a0a:     	je	0x180001a12 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x3a2>
180001a0c:     	movq	%r8, %rdx
180001a0f:     	jmpq	*%rax
180001a12:     	xorl	%eax, %eax
180001a14:     	retq
180001a15:     	int3
180001a16:     	int3
180001a17:     	int3
180001a18:     	int3
180001a19:     	int3
180001a1a:     	int3
180001a1b:     	int3
180001a1c:     	int3
180001a1d:     	int3
180001a1e:     	int3
180001a1f:     	int3
180001a20:     	movq	%rbx, 0x8(%rsp)
180001a25:     	pushq	%rdi
180001a26:     	subq	$0x20, %rsp
180001a2a:     	movq	0x28(%rcx), %rax
180001a2e:     	xorl	%edi, %edi
180001a30:     	movq	%rcx, %rbx
180001a33:     	testq	%rax, %rax
180001a36:     	je	0x180001a42 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x3d2>
180001a38:     	addq	$0x38, %rcx
180001a3c:     	callq	*%rax
180001a3e:     	movq	%rdi, 0x28(%rbx)
180001a42:     	movq	0x18(%rbx), %rcx
180001a46:     	testq	%rcx, %rcx
180001a49:     	je	0x180001a62 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x3f2>
180001a4b:     	movq	%rdi, 0x18(%rbx)
180001a4f:     	movl	(%rcx), %eax
180001a51:     	testl	%eax, %eax
180001a53:     	js	0x180001a62 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x3f2>
180001a55:     	subl	$0x1, %eax
180001a58:     	movl	%eax, (%rcx)
180001a5a:     	jne	0x180001a62 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x3f2>
180001a5c:     	callq	*0x274e(%rip)           # 0x1800041b0
180001a62:     	movq	%rdi, 0x20(%rbx)
180001a66:     	xorl	%eax, %eax
180001a68:     	movq	0x30(%rsp), %rbx
180001a6d:     	addq	$0x20, %rsp
180001a71:     	popq	%rdi
180001a72:     	retq
180001a73:     	int3
180001a74:     	int3
180001a75:     	int3
180001a76:     	int3
180001a77:     	int3
180001a78:     	int3
180001a79:     	int3
180001a7a:     	int3
180001a7b:     	int3
180001a7c:     	int3
180001a7d:     	int3
180001a7e:     	int3
180001a7f:     	int3
180001a80:     	pushq	%rbx
180001a82:     	subq	$0x20, %rsp
180001a86:     	movq	%rcx, %rbx
180001a89:     	callq	*0x2761(%rip)           # 0x1800041f0
180001a8f:     	cmpq	$0x0, 0x30(%rbx)
180001a94:     	je	0x180001a9f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x42f>
180001a96:     	movq	%rbx, %rcx
180001a99:     	callq	*0x26e1(%rip)           # 0x180004180
180001a9f:     	callq	*0x268b(%rip)           # 0x180004130
180001aa5:     	testl	%eax, %eax
180001aa7:     	jne	0x180001ab8 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x448>
180001aa9:     	movq	0x28(%rbx), %rax
180001aad:     	testq	%rax, %rax
180001ab0:     	je	0x180001ab8 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x448>
180001ab2:     	leaq	0x38(%rbx), %rcx
180001ab6:     	callq	*%rax
180001ab8:     	movq	0x18(%rbx), %rcx
180001abc:     	testq	%rcx, %rcx
180001abf:     	je	0x180001ad4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x464>
180001ac1:     	movl	(%rcx), %eax
180001ac3:     	testl	%eax, %eax
180001ac5:     	js	0x180001ad4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x464>
180001ac7:     	subl	$0x1, %eax
180001aca:     	movl	%eax, (%rcx)
180001acc:     	jne	0x180001ad4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x464>
180001ace:     	callq	*0x26dc(%rip)           # 0x1800041b0
180001ad4:     	movq	0x8(%rbx), %rax
180001ad8:     	movq	%rbx, %rcx
180001adb:     	addq	$0x20, %rsp
180001adf:     	popq	%rbx
180001ae0:     	jmpq	*0x140(%rax)
180001ae7:     	int3
180001ae8:     	int3
180001ae9:     	int3
180001aea:     	int3
180001aeb:     	int3
180001aec:     	int3
180001aed:     	int3
180001aee:     	int3
180001aef:     	int3
180001af0:     	pushq	%rdi
180001af2:     	subq	$0x20, %rsp
180001af6:     	cmpq	$0x0, 0x20(%rcx)
180001afb:     	movq	%rcx, %rdi
180001afe:     	jne	0x180001b1f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x4af>
180001b00:     	movq	0x2731(%rip), %rcx      # 0x180004238
180001b07:     	leaq	0x2e3a(%rip), %rdx      # 0x180004948
180001b0e:     	movq	(%rcx), %rcx
180001b11:     	callq	*0x2719(%rip)           # 0x180004230
180001b17:     	xorl	%eax, %eax
180001b19:     	addq	$0x20, %rsp
180001b1d:     	popq	%rdi
180001b1e:     	retq
180001b1f:     	movq	%rdi, %rdx
180001b22:     	movq	%rbx, 0x30(%rsp)
180001b27:     	movl	$0x1, %ecx
180001b2c:     	callq	*0x25be(%rip)           # 0x1800040f0
180001b32:     	movq	%rax, %rbx
180001b35:     	testq	%rax, %rax
180001b38:     	jne	0x180001b45 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x4d5>
180001b3a:     	movq	0x30(%rsp), %rbx
180001b3f:     	addq	$0x20, %rsp
180001b43:     	popq	%rdi
180001b44:     	retq
180001b45:     	xorl	%r8d, %r8d
180001b48:     	movq	%rbx, %rdx
180001b4b:     	movq	%rdi, %rcx
180001b4e:     	callq	*0x20(%rdi)
180001b51:     	movl	(%rbx), %ecx
180001b53:     	movq	%rax, %rdi
180001b56:     	testl	%ecx, %ecx
180001b58:     	js	0x180001b6a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x4fa>
180001b5a:     	subl	$0x1, %ecx
180001b5d:     	movl	%ecx, (%rbx)
180001b5f:     	jne	0x180001b6a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x4fa>
180001b61:     	movq	%rbx, %rcx
180001b64:     	callq	*0x2646(%rip)           # 0x1800041b0
180001b6a:     	movq	0x30(%rsp), %rbx
180001b6f:     	movq	%rdi, %rax
180001b72:     	addq	$0x20, %rsp
180001b76:     	popq	%rdi
180001b77:     	retq
180001b78:     	int3
180001b79:     	int3
180001b7a:     	int3
180001b7b:     	int3
180001b7c:     	int3
180001b7d:     	int3
180001b7e:     	int3
180001b7f:     	int3
180001b80:     	movq	%rbx, 0x8(%rsp)
180001b85:     	pushq	%rdi
180001b86:     	subq	$0x20, %rsp
180001b8a:     	movq	%r8, %rbx
180001b8d:     	callq	*0x2585(%rip)           # 0x180004118
180001b93:     	movl	(%rbx), %ecx
180001b95:     	movl	%eax, %edi
180001b97:     	testl	%ecx, %ecx
180001b99:     	js	0x180001bab <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x53b>
180001b9b:     	subl	$0x1, %ecx
180001b9e:     	movl	%ecx, (%rbx)
180001ba0:     	jne	0x180001bab <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x53b>
180001ba2:     	movq	%rbx, %rcx
180001ba5:     	callq	*0x2605(%rip)           # 0x1800041b0
180001bab:     	movl	%edi, %ecx
180001bad:     	movq	0x30(%rsp), %rbx
180001bb2:     	addq	$0x20, %rsp
180001bb6:     	popq	%rdi
180001bb7:     	jmpq	*0x262a(%rip)           # 0x1800041e8
180001bbe:     	int3
180001bbf:     	int3
180001bc0:     	movq	%rbx, 0x8(%rsp)
180001bc5:     	pushq	%rdi
180001bc6:     	subq	$0x20, %rsp
180001bca:     	movl	(%rdx), %eax
180001bcc:     	movq	%rdx, %rbx
180001bcf:     	movq	%rcx, %rdi
180001bd2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001bd7:     	jae	0x180001bdd <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x56d>
180001bd9:     	incl	%eax
180001bdb:     	movl	%eax, (%rdx)
180001bdd:     	movl	$0x30, %ecx
180001be2:     	callq	*0x9040(%rip)           # 0x18000ac28
180001be8:     	cmpb	$0x0, 0x9011(%rip)      # 0x18000ac00
180001bef:     	je	0x180001bf9 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x589>
180001bf1:     	lock
180001bf2:     	incq	0x900f(%rip)            # 0x18000ac08
180001bf9:     	testq	%rax, %rax
180001bfc:     	je	0x180001c33 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x5c3>
180001bfe:     	movl	$0x1, %ecx
180001c03:     	leaq	-0x8a(%rip), %rdx       # 0x180001b80 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x510>
180001c0a:     	xchgq	%rcx, (%rax)
180001c0d:     	xorl	%ecx, %ecx
180001c0f:     	movq	%rdx, 0x8(%rax)
180001c13:     	movq	%rcx, 0x20(%rax)
180001c17:     	movq	%rcx, 0x28(%rax)
180001c1b:     	movq	%rbx, 0x10(%rax)
180001c1f:     	movq	%rdi, 0x18(%rax)
180001c23:     	cmpb	%cl, 0x8fd7(%rip)       # 0x18000ac00
180001c29:     	je	0x180001c33 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x5c3>
180001c2b:     	lock
180001c2c:     	incq	0x8fe5(%rip)            # 0x18000ac18
180001c33:     	movq	0x30(%rsp), %rbx
180001c38:     	addq	$0x20, %rsp
180001c3c:     	popq	%rdi
180001c3d:     	retq
180001c3e:     	int3
180001c3f:     	int3
180001c40:     	movq	%rbx, 0x8(%rsp)
180001c45:     	pushq	%rdi
180001c46:     	subq	$0x30, %rsp
180001c4a:     	movq	%rcx, %rdi
180001c4d:     	leaq	0x8d2c(%rip), %r9       # 0x18000a980
180001c54:     	movq	%r8, %rax
180001c57:     	leaq	0x58(%rsp), %rcx
180001c5c:     	movq	%rdx, %r10
180001c5f:     	movq	%rcx, 0x20(%rsp)
180001c64:     	movq	%r10, %rcx
180001c67:     	leaq	0x2d22(%rip), %r8       # 0x180004990
180001c6e:     	movq	%rax, %rdx
180001c71:     	callq	*0x2469(%rip)           # 0x1800040e0
180001c77:     	testl	%eax, %eax
180001c79:     	je	0x180001ca3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x633>
180001c7b:     	movq	0x58(%rsp), %rcx
180001c80:     	callq	*0x24a2(%rip)           # 0x180004128
180001c86:     	movq	%rax, %rbx
180001c89:     	callq	*0x25b9(%rip)           # 0x180004248
180001c8f:     	testq	%rax, %rax
180001c92:     	jne	0x180001ca3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x633>
180001c94:     	movq	%rbx, 0x10(%rdi)
180001c98:     	movq	0x40(%rsp), %rbx
180001c9d:     	addq	$0x30, %rsp
180001ca1:     	popq	%rdi
180001ca2:     	retq
180001ca3:     	movq	0x40(%rsp), %rbx
180001ca8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001cad:     	addq	$0x30, %rsp
180001cb1:     	popq	%rdi
180001cb2:     	retq
180001cb3:     	int3
180001cb4:     	int3
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
180001cc0:     	subq	$0x38, %rsp
180001cc4:     	movl	%r8d, %eax
180001cc7:     	movq	%rdx, %r10
180001cca:     	movq	0x10(%rcx), %r8
180001cce:     	movq	%rcx, %rdx
180001cd1:     	movl	%eax, 0x28(%rsp)
180001cd5:     	movq	%r10, %rcx
180001cd8:     	movl	$0x0, 0x20(%rsp)
180001ce0:     	movq	0x20(%r8), %r9
180001ce4:     	movq	0x18(%r8), %r8
180001ce8:     	callq	*0x24ea(%rip)           # 0x1800041d8
180001cee:     	addq	$0x38, %rsp
180001cf2:     	retq
180001cf3:     	int3
180001cf4:     	int3
180001cf5:     	int3
180001cf6:     	int3
180001cf7:     	int3
180001cf8:     	int3
180001cf9:     	int3
180001cfa:     	int3
180001cfb:     	int3
180001cfc:     	int3
180001cfd:     	int3
180001cfe:     	int3
180001cff:     	int3
180001d00:     	movq	0x10(%rcx), %rax
180001d04:     	lock
180001d05:     	incq	(%rax)
180001d08:     	movq	0x24d1(%rip), %rax      # 0x1800041e0
180001d0f:     	retq
180001d10:     	subq	$0x28, %rsp
180001d14:     	movq	0x10(%rcx), %rcx
180001d18:     	callq	0x180003010 <numba_list_iter_next+0x1d0>
180001d1d:     	movq	0x24bc(%rip), %rax      # 0x1800041e0
180001d24:     	addq	$0x28, %rsp
180001d28:     	retq
180001d29:     	int3
180001d2a:     	int3
180001d2b:     	int3
180001d2c:     	int3
180001d2d:     	int3
180001d2e:     	int3
180001d2f:     	int3
180001d30:     	movq	0x10(%rcx), %rcx
180001d34:     	movq	0x18(%rcx), %rcx
180001d38:     	jmpq	*0x2411(%rip)           # 0x180004150
180001d3f:     	int3
180001d40:     	subq	$0x28, %rsp
180001d44:     	movq	0x10(%rcx), %rax
180001d48:     	testq	%rax, %rax
180001d4b:     	je	0x180001d69 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x6f9>
180001d4d:     	cmpq	$0x0, 0x18(%rax)
180001d52:     	je	0x180001d69 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x6f9>
180001d54:     	movq	(%rax), %rcx
180001d57:     	nop
180001d58:     	cmpq	$-0x1, %rcx
180001d5c:     	je	0x180001d69 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x6f9>
180001d5e:     	addq	$0x28, %rsp
180001d62:     	jmpq	*0x239f(%rip)           # 0x180004108
180001d69:     	movq	0x2460(%rip), %rcx      # 0x1800041d0
180001d70:     	leaq	0x2c21(%rip), %rdx      # 0x180004998
180001d77:     	movq	(%rcx), %rcx
180001d7a:     	callq	*0x24b0(%rip)           # 0x180004230
180001d80:     	xorl	%eax, %eax
180001d82:     	addq	$0x28, %rsp
180001d86:     	retq
180001d87:     	int3
180001d88:     	int3
180001d89:     	int3
180001d8a:     	int3
180001d8b:     	int3
180001d8c:     	int3
180001d8d:     	int3
180001d8e:     	int3
180001d8f:     	int3
180001d90:     	movq	0x10(%rcx), %rcx
180001d94:     	movq	0x28(%rcx), %rcx
180001d98:     	jmpq	*0x23b1(%rip)           # 0x180004150
180001d9f:     	int3
180001da0:     	movq	0x10(%rcx), %rax
180001da4:     	movq	0x10(%rax), %rax
180001da8:     	testq	%rax, %rax
180001dab:     	je	0x180001dbc <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x74c>
180001dad:     	movl	(%rax), %ecx
180001daf:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001db5:     	jae	0x180001dda <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x76a>
180001db7:     	incl	%ecx
180001db9:     	movl	%ecx, (%rax)
180001dbb:     	retq
180001dbc:     	movq	0x241d(%rip), %rcx      # 0x1800041e0
180001dc3:     	movl	(%rcx), %eax
180001dc5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001dca:     	jae	0x180001dd7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x767>
180001dcc:     	incl	%eax
180001dce:     	movl	%eax, (%rcx)
180001dd0:     	movq	0x2409(%rip), %rcx      # 0x1800041e0
180001dd7:     	movq	%rcx, %rax
180001dda:     	retq
180001ddb:     	int3
180001ddc:     	int3
180001ddd:     	int3
180001dde:     	int3
180001ddf:     	int3
180001de0:     	pushq	%rbx
180001de2:     	subq	$0x20, %rsp
180001de6:     	movq	%rcx, %rbx
180001de9:     	movq	0x10(%rcx), %rcx
180001ded:     	callq	0x180003010 <numba_list_iter_next+0x1d0>
180001df2:     	movq	0x8(%rbx), %rax
180001df6:     	movq	%rbx, %rcx
180001df9:     	addq	$0x20, %rsp
180001dfd:     	popq	%rbx
180001dfe:     	jmpq	*0x140(%rax)
180001e05:     	int3
180001e06:     	int3
180001e07:     	int3
180001e08:     	int3
180001e09:     	int3
180001e0a:     	int3
180001e0b:     	int3
180001e0c:     	int3
180001e0d:     	int3
180001e0e:     	int3
180001e0f:     	int3
180001e10:     	movq	%rdi, 0x18(%rsp)
180001e15:     	pushq	%r14
180001e17:     	subq	$0x20, %rsp
180001e1b:     	movq	0x8e1e(%rip), %rax      # 0x18000ac40
180001e22:     	movq	%rdx, %r14
180001e25:     	movq	%rcx, %rdi
180001e28:     	movq	0x8(%rcx), %rcx
180001e2c:     	movq	0x10(%rax), %rdx
180001e30:     	cmpq	%rdx, %rcx
180001e33:     	je	0x180001e50 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7e0>
180001e35:     	callq	*0x237d(%rip)           # 0x1800041b8
180001e3b:     	testl	%eax, %eax
180001e3d:     	jne	0x180001e50 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x7e0>
180001e3f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001e44:     	movq	0x40(%rsp), %rdi
180001e49:     	addq	$0x20, %rsp
180001e4d:     	popq	%r14
180001e4f:     	retq
180001e50:     	movq	%rbx, 0x30(%rsp)
180001e55:     	movq	%rdi, %rdx
180001e58:     	movq	0x10(%rdi), %rbx
180001e5c:     	movq	%rbx, %rcx
180001e5f:     	movq	%rsi, 0x38(%rsp)
180001e64:     	movl	0x18(%rdi), %esi
180001e67:     	callq	0x180001bc0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x550>
180001e6c:     	movq	%rax, (%r14)
180001e6f:     	movq	0x8dca(%rip), %rax      # 0x18000ac40
180001e76:     	movq	%rbx, 0x20(%r14)
180001e7a:     	movl	0x18(%rdi), %edx
180001e7d:     	movq	0x20(%rdi), %rcx
180001e81:     	callq	*0x4f0(%rax)
180001e87:     	cmpl	$0x12, 0x8dbe(%rip)     # 0x18000ac4c
180001e8e:     	movq	0x30(%rsp), %rbx
180001e93:     	movq	%rax, 0x10(%r14)
180001e97:     	movq	0x38(%rdi), %rax
180001e9b:     	jl	0x180001ea3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x833>
180001e9d:     	movq	0x28(%rax), %rax
180001ea1:     	jmp	0x180001ea7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x837>
180001ea3:     	movslq	0x20(%rax), %rax
180001ea7:     	xorl	%r8d, %r8d
180001eaa:     	movq	%rax, 0x18(%r14)
180001eae:     	movq	%rdi, 0x8(%r14)
180001eb2:     	leaq	0x28(%r14), %rax
180001eb6:     	testl	%esi, %esi
180001eb8:     	jle	0x180001efb <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x88b>
180001eba:     	nopw	(%rax,%rax)
180001ec0:     	movq	0x20(%rdi), %rcx
180001ec4:     	movq	(%rcx,%r8,8), %rdx
180001ec8:     	incl	%r8d
180001ecb:     	movq	%rdx, (%rax)
180001ece:     	addq	$0x8, %rax
180001ed2:     	cmpl	%esi, %r8d
180001ed5:     	jl	0x180001ec0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x850>
180001ed7:     	xorl	%r8d, %r8d
180001eda:     	nopw	(%rax,%rax)
180001ee0:     	movq	0x28(%rdi), %rcx
180001ee4:     	leaq	0x8(%rax), %rax
180001ee8:     	movslq	%r8d, %rdx
180001eeb:     	incl	%r8d
180001eee:     	movq	(%rcx,%rdx,8), %rdx
180001ef2:     	movq	%rdx, -0x8(%rax)
180001ef6:     	cmpl	%esi, %r8d
180001ef9:     	jl	0x180001ee0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x870>
180001efb:     	movq	0x38(%rsp), %rsi
180001f00:     	xorl	%eax, %eax
180001f02:     	movq	0x40(%rsp), %rdi
180001f07:     	addq	$0x20, %rsp
180001f0b:     	popq	%r14
180001f0d:     	retq
180001f0e:     	int3
180001f0f:     	int3
180001f10:     	pushq	%rbx
180001f12:     	pushq	%rbp
180001f13:     	pushq	%rsi
180001f14:     	pushq	%rdi
180001f15:     	subq	$0x28, %rsp
180001f19:     	cmpq	$0x0, 0x8d2f(%rip)      # 0x18000ac50
180001f21:     	movq	%rcx, %rbp
180001f24:     	movslq	0x8(%rdx), %rdi
180001f28:     	movq	(%rdx), %rsi
180001f2b:     	jne	0x180001f83 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x913>
180001f2d:     	leaq	0x29a4(%rip), %rcx      # 0x1800048d8
180001f34:     	callq	*0x22ce(%rip)           # 0x180004208
180001f3a:     	movq	%rax, %rbx
180001f3d:     	testq	%rax, %rax
180001f40:     	je	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180001f46:     	leaq	0x2993(%rip), %rdx      # 0x1800048e0
180001f4d:     	movq	%rax, %rcx
180001f50:     	callq	*0x220a(%rip)           # 0x180004160
180001f56:     	movl	(%rbx), %edx
180001f58:     	movq	%rax, 0x8cf1(%rip)      # 0x18000ac50
180001f5f:     	testl	%edx, %edx
180001f61:     	js	0x180001f7a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x90a>
180001f63:     	subl	$0x1, %edx
180001f66:     	movl	%edx, (%rbx)
180001f68:     	jne	0x180001f7a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x90a>
180001f6a:     	movq	%rbx, %rcx
180001f6d:     	callq	*0x223d(%rip)           # 0x1800041b0
180001f73:     	movq	0x8cd6(%rip), %rax      # 0x18000ac50
180001f7a:     	testq	%rax, %rax
180001f7d:     	je	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180001f83:     	movq	%rdi, %rdx
180001f86:     	movq	%rsi, %rcx
180001f89:     	callq	*0x2191(%rip)           # 0x180004120
180001f8f:     	movq	%rax, %rdi
180001f92:     	testq	%rax, %rax
180001f95:     	je	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180001f97:     	movq	0x8cb2(%rip), %rcx      # 0x18000ac50
180001f9e:     	xorl	%r8d, %r8d
180001fa1:     	movq	%rax, %rdx
180001fa4:     	callq	*0x21de(%rip)           # 0x180004188
180001faa:     	movl	(%rdi), %ecx
180001fac:     	movq	%rax, %rbx
180001faf:     	testl	%ecx, %ecx
180001fb1:     	js	0x180001fc3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x953>
180001fb3:     	subl	$0x1, %ecx
180001fb6:     	movl	%ecx, (%rdi)
180001fb8:     	jne	0x180001fc3 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x953>
180001fba:     	movq	%rdi, %rcx
180001fbd:     	callq	*0x21ed(%rip)           # 0x1800041b0
180001fc3:     	testq	%rbx, %rbx
180001fc6:     	je	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180001fc8:     	movq	0x8(%rbx), %r8
180001fcc:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001fd7:     	jne	0x180002015 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x9a5>
180001fd9:     	movq	0x2248(%rip), %rcx      # 0x180004228
180001fe0:     	leaq	0x2ab9(%rip), %rdx      # 0x180004aa0
180001fe7:     	movq	0x18(%r8), %r8
180001feb:     	movq	(%rcx), %rcx
180001fee:     	callq	*0x21d4(%rip)           # 0x1800041c8
180001ff4:     	movl	(%rbx), %eax
180001ff6:     	testl	%eax, %eax
180001ff8:     	js	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180001ffa:     	subl	$0x1, %eax
180001ffd:     	movl	%eax, (%rbx)
180001fff:     	jne	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180002001:     	movq	%rbx, %rcx
180002004:     	callq	*0x21a6(%rip)           # 0x1800041b0
18000200a:     	xorl	%eax, %eax
18000200c:     	addq	$0x28, %rsp
180002010:     	popq	%rdi
180002011:     	popq	%rsi
180002012:     	popq	%rbp
180002013:     	popq	%rbx
180002014:     	retq
180002015:     	xorl	%r8d, %r8d
180002018:     	leaq	0x82e1(%rip), %rcx      # 0x18000a300
18000201f:     	xorl	%edx, %edx
180002021:     	callq	*0x21e9(%rip)           # 0x180004210
180002027:     	movq	%rax, %rdi
18000202a:     	testq	%rax, %rax
18000202d:     	je	0x180001ff4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x984>
18000202f:     	movq	%rbp, %rcx
180002032:     	movq	%rbx, 0x18(%rax)
180002036:     	callq	*0x216c(%rip)           # 0x1800041a8
18000203c:     	movq	%rax, 0x10(%rdi)
180002040:     	movq	%rax, %rcx
180002043:     	testq	%rax, %rax
180002046:     	jne	0x18000205a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x9ea>
180002048:     	movl	(%rdi), %eax
18000204a:     	testl	%eax, %eax
18000204c:     	js	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
18000204e:     	subl	$0x1, %eax
180002051:     	movl	%eax, (%rdi)
180002053:     	jne	0x18000200a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x99a>
180002055:     	movq	%rdi, %rcx
180002058:     	jmp	0x180002004 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x994>
18000205a:     	movl	(%rax), %eax
18000205c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002061:     	jae	0x180002067 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x9f7>
180002063:     	incl	%eax
180002065:     	movl	%eax, (%rcx)
180002067:     	movq	%rdi, %rax
18000206a:     	addq	$0x28, %rsp
18000206e:     	popq	%rdi
18000206f:     	popq	%rsi
180002070:     	popq	%rbp
180002071:     	popq	%rbx
180002072:     	retq
180002073:     	int3
180002074:     	int3
180002075:     	int3
180002076:     	int3
180002077:     	int3
180002078:     	int3
180002079:     	int3
18000207a:     	int3
18000207b:     	int3
18000207c:     	int3
18000207d:     	int3
18000207e:     	int3
18000207f:     	int3
180002080:     	movq	%r9, 0x20(%rsp)
180002085:     	movq	%r8, 0x18(%rsp)
18000208a:     	movq	%rdx, 0x10(%rsp)
18000208f:     	movq	%rcx, 0x8(%rsp)
180002094:     	pushq	%rbx
180002095:     	pushq	%rbp
180002096:     	pushq	%rsi
180002097:     	pushq	%rdi
180002098:     	pushq	%r12
18000209a:     	pushq	%r13
18000209c:     	pushq	%r14
18000209e:     	pushq	%r15
1800020a0:     	subq	$0x68, %rsp
1800020a4:     	movq	%rcx, %r14
1800020a7:     	movq	%r9, %r15
1800020aa:     	leaq	0x252f(%rip), %rcx      # 0x1800045e0
1800020b1:     	movq	%r8, %r13
1800020b4:     	movq	%rdx, %rsi
1800020b7:     	callq	*0x214b(%rip)           # 0x180004208
1800020bd:     	movq	%rax, %rdi
1800020c0:     	testq	%rax, %rax
1800020c3:     	jne	0x1800020fc <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xa8c>
1800020c5:     	movq	0x2044(%rip), %rcx      # 0x180004110
1800020cc:     	movq	(%rcx), %rcx
1800020cf:     	callq	*0x20c3(%rip)           # 0x180004198
1800020d5:     	testl	%eax, %eax
1800020d7:     	je	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
1800020dd:     	callq	*0x2075(%rip)           # 0x180004158
1800020e3:     	leaq	0x2516(%rip), %rcx      # 0x180004600
1800020ea:     	callq	*0x2118(%rip)           # 0x180004208
1800020f0:     	movq	%rax, %rdi
1800020f3:     	testq	%rax, %rax
1800020f6:     	je	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
1800020fc:     	leaq	0x251d(%rip), %rdx      # 0x180004620
180002103:     	movq	%rdi, %rcx
180002106:     	callq	*0x2054(%rip)           # 0x180004160
18000210c:     	movl	(%rdi), %ecx
18000210e:     	movq	%rax, %rbx
180002111:     	testl	%ecx, %ecx
180002113:     	js	0x180002125 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xab5>
180002115:     	subl	$0x1, %ecx
180002118:     	movl	%ecx, (%rdi)
18000211a:     	jne	0x180002125 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xab5>
18000211c:     	movq	%rdi, %rcx
18000211f:     	callq	*0x208b(%rip)           # 0x1800041b0
180002125:     	testq	%rbx, %rbx
180002128:     	je	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
18000212e:     	movq	0x1fb3(%rip), %rax      # 0x1800040e8
180002135:     	cmpq	%rax, 0x8(%rbx)
180002139:     	je	0x180002175 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb05>
18000213b:     	movq	0x20f6(%rip), %rcx      # 0x180004238
180002142:     	leaq	0x24e7(%rip), %rdx      # 0x180004630
180002149:     	movq	(%rcx), %rcx
18000214c:     	callq	*0x20de(%rip)           # 0x180004230
180002152:     	movl	(%rbx), %eax
180002154:     	testl	%eax, %eax
180002156:     	js	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
18000215c:     	subl	$0x1, %eax
18000215f:     	movl	%eax, (%rbx)
180002161:     	jne	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
180002167:     	movq	%rbx, %rcx
18000216a:     	callq	*0x2040(%rip)           # 0x1800041b0
180002170:     	jmp	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
180002175:     	xorl	%edx, %edx
180002177:     	movq	%rbx, %rcx
18000217a:     	callq	*0x2010(%rip)           # 0x180004190
180002180:     	movl	(%rbx), %ecx
180002182:     	movq	%rax, 0x8ab7(%rip)      # 0x18000ac40
180002189:     	testl	%ecx, %ecx
18000218b:     	js	0x1800021a4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb34>
18000218d:     	subl	$0x1, %ecx
180002190:     	movl	%ecx, (%rbx)
180002192:     	jne	0x1800021a4 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb34>
180002194:     	movq	%rbx, %rcx
180002197:     	callq	*0x2013(%rip)           # 0x1800041b0
18000219d:     	movq	0x8a9c(%rip), %rax      # 0x18000ac40
1800021a4:     	testq	%rax, %rax
1800021a7:     	jne	0x1800021c2 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb52>
1800021a9:     	leaq	0x24a8(%rip), %rdx      # 0x180004658
1800021b0:     	movq	0x2081(%rip), %rcx      # 0x180004238
1800021b7:     	movq	(%rcx), %rcx
1800021ba:     	callq	*0x2070(%rip)           # 0x180004230
1800021c0:     	jmp	0x1800021f7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb87>
1800021c2:     	callq	*(%rax)
1800021c4:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
1800021c9:     	jbe	0x18000222a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xbba>
1800021cb:     	movq	0x2066(%rip), %rax      # 0x180004238
1800021d2:     	movq	(%rax), %rbx
1800021d5:     	movq	0x8a64(%rip), %rax      # 0x18000ac40
1800021dc:     	callq	*(%rax)
1800021de:     	movl	$0x2000000, %r8d        # imm = 0x2000000
1800021e4:     	leaq	0x2495(%rip), %rdx      # 0x180004680
1800021eb:     	movl	%eax, %r9d
1800021ee:     	movq	%rbx, %rcx
1800021f1:     	callq	*0x1fd1(%rip)           # 0x1800041c8
1800021f7:     	callq	*0x206b(%rip)           # 0x180004268
1800021fd:     	movq	0x1ef4(%rip), %rcx      # 0x1800040f8
180002204:     	leaq	0x269d(%rip), %rdx      # 0x1800048a8
18000220b:     	movq	(%rcx), %rcx
18000220e:     	callq	*0x201c(%rip)           # 0x180004230
180002214:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002219:     	addq	$0x68, %rsp
18000221d:     	popq	%r15
18000221f:     	popq	%r14
180002221:     	popq	%r13
180002223:     	popq	%r12
180002225:     	popq	%rdi
180002226:     	popq	%rsi
180002227:     	popq	%rbp
180002228:     	popq	%rbx
180002229:     	retq
18000222a:     	movq	0x8a0f(%rip), %rax      # 0x18000ac40
180002231:     	callq	*0x698(%rax)
180002237:     	movl	%eax, 0x8a0f(%rip)      # 0x18000ac4c
18000223d:     	cmpl	$0x10, %eax
180002240:     	jge	0x18000225e <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xbee>
180002242:     	movq	0x1fef(%rip), %rcx      # 0x180004238
180002249:     	leaq	0x2480(%rip), %rdx      # 0x1800046d0
180002250:     	movl	%eax, %r9d
180002253:     	movl	$0x10, %r8d
180002259:     	movq	(%rcx), %rcx
18000225c:     	jmp	0x1800021f1 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb81>
18000225e:     	movq	0x89db(%rip), %rax      # 0x18000ac40
180002265:     	callq	*0x690(%rax)
18000226b:     	testl	%eax, %eax
18000226d:     	jne	0x18000227b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xc0b>
18000226f:     	leaq	0x25aa(%rip), %rdx      # 0x180004820
180002276:     	jmp	0x1800021b0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb40>
18000227b:     	cmpl	$0x1, %eax
18000227e:     	je	0x18000228c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xc1c>
180002280:     	leaq	0x25c9(%rip), %rdx      # 0x180004850
180002287:     	jmp	0x1800021b0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xb40>
18000228c:     	leaq	0x854d(%rip), %rcx      # 0x18000a7e0
180002293:     	callq	*0x1ecf(%rip)           # 0x180004168
180002299:     	testl	%eax, %eax
18000229b:     	jne	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
1800022a1:     	leaq	0x8058(%rip), %rcx      # 0x18000a300
1800022a8:     	callq	*0x1eba(%rip)           # 0x180004168
1800022ae:     	testl	%eax, %eax
1800022b0:     	jne	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
1800022b6:     	leaq	0x8383(%rip), %rcx      # 0x18000a640
1800022bd:     	callq	*0x1ea5(%rip)           # 0x180004168
1800022c3:     	testl	%eax, %eax
1800022c5:     	jne	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
1800022cb:     	xorl	%ebx, %ebx
1800022cd:     	cmpl	%ebx, 0x8975(%rip)      # 0x18000ac48
1800022d3:     	jne	0x180002316 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xca6>
1800022d5:     	movq	%gs:0x58, %rax
1800022de:     	movl	0x8974(%rip), %ecx      # 0x18000ac58
1800022e4:     	movl	$0x1, 0x895a(%rip)      # 0x18000ac48
1800022ee:     	movq	(%rax,%rcx,8), %rdx
1800022f2:     	movl	$0x10, %eax
1800022f7:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800022fe:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002303:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000230a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000230f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180002316:     	movl	%ebx, 0x88dc(%rip)      # 0x18000abf8
18000231c:     	movq	%rbx, %rax
18000231f:     	movb	%bl, 0x88db(%rip)       # 0x18000ac00
180002325:     	movq	%rbx, %rcx
180002328:     	xchgq	%rax, 0x88d9(%rip)      # 0x18000ac08
18000232f:     	xchgq	%rcx, 0x88da(%rip)      # 0x18000ac10
180002336:     	movq	%rbx, %rax
180002339:     	movq	%rbx, %rcx
18000233c:     	xchgq	%rax, 0x88d5(%rip)      # 0x18000ac18
180002343:     	xchgq	%rcx, 0x88d6(%rip)      # 0x18000ac20
18000234a:     	movq	0x1d0f(%rip), %rax      # 0x180004060
180002351:     	leaq	0x8148(%rip), %rcx      # 0x18000a4a0
180002358:     	movq	%rax, 0x88c9(%rip)      # 0x18000ac28
18000235f:     	movq	0x1d0a(%rip), %rax      # 0x180004070
180002366:     	movq	%rax, 0x88c3(%rip)      # 0x18000ac30
18000236d:     	movq	0x1cf4(%rip), %rax      # 0x180004068
180002374:     	movq	%rax, 0x88bd(%rip)      # 0x18000ac38
18000237b:     	movq	0x1e8e(%rip), %rax      # 0x180004210
180002382:     	movq	%rax, 0x824f(%rip)      # 0x18000a5d8
180002389:     	callq	*0x1dd9(%rip)           # 0x180004168
18000238f:     	testl	%eax, %eax
180002391:     	jne	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
180002397:     	leaq	0x259a(%rip), %rdx      # 0x180004938
18000239e:     	movq	%r14, %rcx
1800023a1:     	callq	*0x1db9(%rip)           # 0x180004160
1800023a7:     	movq	%rax, 0x28(%rsp)
1800023ac:     	movq	%rax, %rdi
1800023af:     	testq	%rax, %rax
1800023b2:     	je	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
1800023b8:     	leaq	0x2712(%rip), %rcx      # 0x180004ad1
1800023bf:     	callq	*0x1d3b(%rip)           # 0x180004100
1800023c5:     	movq	%rax, 0x20(%rsp)
1800023ca:     	movq	%rax, %r12
1800023cd:     	testq	%rax, %rax
1800023d0:     	je	0x180002714 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x10a4>
1800023d6:     	movl	%ebx, %ebp
1800023d8:     	cmpq	%rbx, (%rsi)
1800023db:     	je	0x180002584 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xf14>
1800023e1:     	movslq	%ebp, %rbx
1800023e4:     	leaq	0x30(%rsp), %rdx
1800023e9:     	movq	%r14, %rcx
1800023ec:     	leaq	(%rbx,%rbx,4), %rax
1800023f0:     	movups	(%r13,%rax,8), %xmm0
1800023f6:     	movups	0x10(%r13,%rax,8), %xmm1
1800023fc:     	movaps	%xmm0, 0x30(%rsp)
180002401:     	movsd	0x20(%r13,%rax,8), %xmm0
180002408:     	movsd	%xmm0, 0x50(%rsp)
18000240e:     	movaps	%xmm1, 0x40(%rsp)
180002413:     	callq	0x180001f10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x8a0>
180002418:     	movq	%rax, %r14
18000241b:     	testq	%rax, %rax
18000241e:     	je	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
180002424:     	movq	(%rsi), %rcx
180002427:     	callq	*0x1cd3(%rip)           # 0x180004100
18000242d:     	movq	%rax, %r13
180002430:     	testq	%rax, %rax
180002433:     	je	0x180002737 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x10c7>
180002439:     	movq	(%r15,%rbx,8), %rcx
18000243d:     	xorl	%edx, %edx
18000243f:     	movq	%r14, (%rcx)
180002442:     	leaq	0x8397(%rip), %rcx      # 0x18000a7e0
180002449:     	movq	0x8(%rsi), %r12
18000244d:     	callq	*0x1cf5(%rip)           # 0x180004148
180002453:     	movq	%rax, %rbx
180002456:     	testq	%rax, %rax
180002459:     	je	0x1800024d6 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe66>
18000245b:     	movq	%r13, %rcx
18000245e:     	callq	*0x1d14(%rip)           # 0x180004178
180002464:     	movq	%rax, %rdi
180002467:     	testq	%rax, %rax
18000246a:     	je	0x18000248c <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe1c>
18000246c:     	movq	%rax, %rcx
18000246f:     	callq	0x180003cc5 <numba_list_iter_next+0xe85>
180002474:     	leaq	0x1(%rax), %rcx
180002478:     	callq	*0x1d9a(%rip)           # 0x180004218
18000247e:     	movq	%rax, %rsi
180002481:     	testq	%rax, %rax
180002484:     	jne	0x180002494 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe24>
180002486:     	callq	*0x1cac(%rip)           # 0x180004138
18000248c:     	xorl	%eax, %eax
18000248e:     	movq	%rax, 0x20(%rbx)
180002492:     	jmp	0x1800024c5 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe55>
180002494:     	movq	%rdi, %rdx
180002497:     	movq	%rsi, %rcx
18000249a:     	callq	0x180003cbf <numba_list_iter_next+0xe7f>
18000249f:     	movq	0x20(%rsp), %rcx
1800024a4:     	movq	%rsi, 0x20(%rbx)
1800024a8:     	movq	%r12, 0x28(%rbx)
1800024ac:     	movl	$0x3, 0x30(%rbx)
1800024b3:     	callq	0x180001990 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x320>
1800024b8:     	movq	%rax, 0x38(%rbx)
1800024bc:     	testq	%rax, %rax
1800024bf:     	jne	0x180002630 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfc0>
1800024c5:     	movl	(%rbx), %eax
1800024c7:     	testl	%eax, %eax
1800024c9:     	js	0x1800024d6 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe66>
1800024cb:     	subl	$0x1, %eax
1800024ce:     	movl	%eax, (%rbx)
1800024d0:     	je	0x18000267d <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x100d>
1800024d6:     	xorl	%edi, %edi
1800024d8:     	movl	(%r14), %eax
1800024db:     	testl	%eax, %eax
1800024dd:     	js	0x1800024f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe80>
1800024df:     	subl	$0x1, %eax
1800024e2:     	movl	%eax, (%r14)
1800024e5:     	jne	0x1800024f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe80>
1800024e7:     	movq	%r14, %rcx
1800024ea:     	callq	*0x1cc0(%rip)           # 0x1800041b0
1800024f0:     	movl	(%r13), %eax
1800024f4:     	testl	%eax, %eax
1800024f6:     	js	0x18000250a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe9a>
1800024f8:     	subl	$0x1, %eax
1800024fb:     	movl	%eax, (%r13)
1800024ff:     	jne	0x18000250a <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe9a>
180002501:     	movq	%r13, %rcx
180002504:     	callq	*0x1ca6(%rip)           # 0x1800041b0
18000250a:     	testq	%rdi, %rdi
18000250d:     	je	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
180002513:     	movq	0xb8(%rsp), %rsi
18000251b:     	movq	%rdi, %r8
18000251e:     	movq	0xb0(%rsp), %r14
180002526:     	movq	%r14, %rcx
180002529:     	movq	(%rsi), %rdx
18000252c:     	callq	*0x1cc6(%rip)           # 0x1800041f8
180002532:     	movl	(%rdi), %ecx
180002534:     	testl	%eax, %eax
180002536:     	jne	0x1800026da <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x106a>
18000253c:     	testl	%ecx, %ecx
18000253e:     	js	0x180002552 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xee2>
180002540:     	leal	-0x1(%rcx), %eax
180002543:     	movl	%eax, (%rdi)
180002545:     	testl	%eax, %eax
180002547:     	jne	0x180002552 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xee2>
180002549:     	movq	%rdi, %rcx
18000254c:     	callq	*0x1c5e(%rip)           # 0x1800041b0
180002552:     	movq	0xc8(%rsp), %r15
18000255a:     	addq	$0x20, %rsi
18000255e:     	movq	0xc0(%rsp), %r13
180002566:     	incl	%ebp
180002568:     	movq	%rsi, 0xb8(%rsp)
180002570:     	cmpq	$0x0, (%rsi)
180002574:     	jne	0x1800023e1 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xd71>
18000257a:     	movq	0x20(%rsp), %r12
18000257f:     	movq	0x28(%rsp), %rdi
180002584:     	movslq	%ebp, %rax
180002587:     	cmpq	$0x0, (%r15,%rax,8)
18000258c:     	je	0x1800025f9 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xf89>
18000258e:     	nop
180002590:     	movslq	%ebp, %rbx
180002593:     	leaq	0x30(%rsp), %rdx
180002598:     	movq	%r14, %rcx
18000259b:     	leaq	(%rbx,%rbx,4), %rax
18000259f:     	movups	(%r13,%rax,8), %xmm0
1800025a5:     	movups	0x10(%r13,%rax,8), %xmm1
1800025ab:     	movaps	%xmm0, 0x30(%rsp)
1800025b0:     	movsd	0x20(%r13,%rax,8), %xmm0
1800025b7:     	movsd	%xmm0, 0x50(%rsp)
1800025bd:     	movaps	%xmm1, 0x40(%rsp)
1800025c2:     	callq	0x180001f10 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x8a0>
1800025c7:     	testq	%rax, %rax
1800025ca:     	je	0x1800026f5 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1085>
1800025d0:     	movq	(%r15,%rbx,8), %rcx
1800025d4:     	movq	%rax, (%rcx)
1800025d7:     	movl	(%rax), %ecx
1800025d9:     	testl	%ecx, %ecx
1800025db:     	js	0x1800025ed <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xf7d>
1800025dd:     	subl	$0x1, %ecx
1800025e0:     	movl	%ecx, (%rax)
1800025e2:     	jne	0x1800025ed <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xf7d>
1800025e4:     	movq	%rax, %rcx
1800025e7:     	callq	*0x1bc3(%rip)           # 0x1800041b0
1800025ed:     	incl	%ebp
1800025ef:     	movslq	%ebp, %rax
1800025f2:     	cmpq	$0x0, (%r15,%rax,8)
1800025f7:     	jne	0x180002590 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xf20>
1800025f9:     	movl	(%r12), %eax
1800025fd:     	testl	%eax, %eax
1800025ff:     	js	0x180002613 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfa3>
180002601:     	subl	$0x1, %eax
180002604:     	movl	%eax, (%r12)
180002608:     	jne	0x180002613 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfa3>
18000260a:     	movq	%r12, %rcx
18000260d:     	callq	*0x1b9d(%rip)           # 0x1800041b0
180002613:     	movl	(%rdi), %eax
180002615:     	testl	%eax, %eax
180002617:     	js	0x180002629 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfb9>
180002619:     	subl	$0x1, %eax
18000261c:     	movl	%eax, (%rdi)
18000261e:     	jne	0x180002629 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfb9>
180002620:     	movq	%rdi, %rcx
180002623:     	callq	*0x1b87(%rip)           # 0x1800041b0
180002629:     	xorl	%eax, %eax
18000262b:     	jmp	0x180002219 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba9>
180002630:     	movl	(%r14), %eax
180002633:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002638:     	jae	0x18000263f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xfcf>
18000263a:     	incl	%eax
18000263c:     	movl	%eax, (%r14)
18000263f:     	movq	0xb0(%rsp), %rcx
180002647:     	leaq	0x22ea(%rip), %rdx      # 0x180004938
18000264e:     	movq	%r14, 0x18(%rbx)
180002652:     	movq	$0x0, 0x40(%rbx)
18000265a:     	callq	*0x1b00(%rip)           # 0x180004160
180002660:     	movq	%rax, %rsi
180002663:     	testq	%rax, %rax
180002666:     	jne	0x18000268b <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x101b>
180002668:     	movl	(%rbx), %eax
18000266a:     	testl	%eax, %eax
18000266c:     	js	0x1800024d6 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe66>
180002672:     	subl	$0x1, %eax
180002675:     	movl	%eax, (%rbx)
180002677:     	jne	0x1800024d6 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe66>
18000267d:     	movq	%rbx, %rcx
180002680:     	callq	*0x1b2a(%rip)           # 0x1800041b0
180002686:     	jmp	0x1800024d6 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe66>
18000268b:     	xorl	%r9d, %r9d
18000268e:     	leaq	0x20(%rbx), %rcx
180002692:     	movq	%rsi, %r8
180002695:     	movq	%rbx, %rdx
180002698:     	callq	*0x1aa2(%rip)           # 0x180004140
18000269e:     	movq	%rax, %rdi
1800026a1:     	movl	(%rbx), %eax
1800026a3:     	testl	%eax, %eax
1800026a5:     	js	0x1800026b7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1047>
1800026a7:     	subl	$0x1, %eax
1800026aa:     	movl	%eax, (%rbx)
1800026ac:     	jne	0x1800026b7 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1047>
1800026ae:     	movq	%rbx, %rcx
1800026b1:     	callq	*0x1af9(%rip)           # 0x1800041b0
1800026b7:     	movl	(%rsi), %eax
1800026b9:     	testl	%eax, %eax
1800026bb:     	js	0x1800024d8 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe68>
1800026c1:     	subl	$0x1, %eax
1800026c4:     	movl	%eax, (%rsi)
1800026c6:     	jne	0x1800024d8 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe68>
1800026cc:     	movq	%rsi, %rcx
1800026cf:     	callq	*0x1adb(%rip)           # 0x1800041b0
1800026d5:     	jmp	0x1800024d8 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xe68>
1800026da:     	testl	%ecx, %ecx
1800026dc:     	js	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
1800026de:     	leal	-0x1(%rcx), %eax
1800026e1:     	movl	%eax, (%rdi)
1800026e3:     	testl	%eax, %eax
1800026e5:     	jne	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
1800026e7:     	movq	%rdi, %rcx
1800026ea:     	callq	*0x1ac0(%rip)           # 0x1800041b0
1800026f0:     	movq	0x20(%rsp), %r12
1800026f5:     	movl	(%r12), %eax
1800026f9:     	testl	%eax, %eax
1800026fb:     	js	0x18000270f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x109f>
1800026fd:     	subl	$0x1, %eax
180002700:     	movl	%eax, (%r12)
180002704:     	jne	0x18000270f <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x109f>
180002706:     	movq	%r12, %rcx
180002709:     	callq	*0x1aa1(%rip)           # 0x1800041b0
18000270f:     	movq	0x28(%rsp), %rdi
180002714:     	movl	(%rdi), %eax
180002716:     	testl	%eax, %eax
180002718:     	js	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
18000271e:     	subl	$0x1, %eax
180002721:     	movl	%eax, (%rdi)
180002723:     	jne	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
180002729:     	movq	%rdi, %rcx
18000272c:     	callq	*0x1a7e(%rip)           # 0x1800041b0
180002732:     	jmp	0x180002214 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0xba4>
180002737:     	movl	(%r14), %eax
18000273a:     	testl	%eax, %eax
18000273c:     	js	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
18000273e:     	subl	$0x1, %eax
180002741:     	movl	%eax, (%r14)
180002744:     	jne	0x1800026f0 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x1080>
180002746:     	movq	%r14, %rcx
180002749:     	jmp	0x1800026ea <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x107a>
18000274b:     	int3
18000274c:     	int3
18000274d:     	int3
18000274e:     	int3
18000274f:     	int3
180002750:     	leaq	0x8519(%rip), %rax      # 0x18000ac70
180002757:     	retq
180002758:     	int3
180002759:     	int3
18000275a:     	int3
18000275b:     	int3
18000275c:     	int3
18000275d:     	int3
18000275e:     	int3
18000275f:     	int3

0000000180002760 <numba_list_set_method_table>:
180002760:     	movups	(%rdx), %xmm0
180002763:     	movups	%xmm0, 0x20(%rcx)
180002767:     	retq
180002768:     	int3
180002769:     	int3
18000276a:     	int3
18000276b:     	int3
18000276c:     	int3
18000276d:     	int3
18000276e:     	int3
18000276f:     	int3

0000000180002770 <numba_list_new>:
180002770:     	pushq	%rbx
180002772:     	pushq	%rbp
180002773:     	pushq	%rsi
180002774:     	pushq	%rdi
180002775:     	subq	$0x28, %rsp
180002779:     	movq	%rcx, %rsi
18000277c:     	movq	%r8, %rdi
18000277f:     	movl	$0x38, %ecx
180002784:     	movq	%rdx, %rbp
180002787:     	callq	*0x18d3(%rip)           # 0x180004060
18000278d:     	movq	%rax, %rbx
180002790:     	testq	%rax, %rax
180002793:     	je	0x1800027fd <numba_list_new+0x8d>
180002795:     	movq	$0x0, (%rax)
18000279c:     	xorps	%xmm0, %xmm0
18000279f:     	movq	%rbp, 0x8(%rax)
1800027a3:     	movq	%rdi, 0x10(%rax)
1800027a7:     	movl	$0x1, 0x18(%rax)
1800027ae:     	movups	%xmm0, 0x20(%rax)
1800027b2:     	testq	%rdi, %rdi
1800027b5:     	je	0x18000280b <numba_list_new+0x9b>
1800027b7:     	imulq	%rbp, %rdi
1800027bb:     	movl	$0x8, %ecx
1800027c0:     	movq	%rdi, %rax
1800027c3:     	cqto
1800027c5:     	andl	$0x7, %edx
1800027c8:     	addq	%rdx, %rax
1800027cb:     	andl	$0x7, %eax
1800027ce:     	subq	%rdx, %rax
1800027d1:     	subq	%rax, %rcx
1800027d4:     	movq	%rcx, %rax
1800027d7:     	cqto
1800027d9:     	andl	$0x7, %edx
1800027dc:     	leaq	(%rdx,%rax), %rcx
1800027e0:     	andl	$0x7, %ecx
1800027e3:     	subq	%rdx, %rcx
1800027e6:     	addq	%rdi, %rcx
1800027e9:     	callq	*0x1871(%rip)           # 0x180004060
1800027ef:     	testq	%rax, %rax
1800027f2:     	jne	0x18000280d <numba_list_new+0x9d>
1800027f4:     	movq	%rbx, %rcx
1800027f7:     	callq	*0x186b(%rip)           # 0x180004068
1800027fd:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002802:     	addq	$0x28, %rsp
180002806:     	popq	%rdi
180002807:     	popq	%rsi
180002808:     	popq	%rbp
180002809:     	popq	%rbx
18000280a:     	retq
18000280b:     	xorl	%eax, %eax
18000280d:     	movq	%rax, 0x30(%rbx)
180002811:     	xorl	%eax, %eax
180002813:     	movq	%rbx, (%rsi)
180002816:     	addq	$0x28, %rsp
18000281a:     	popq	%rdi
18000281b:     	popq	%rsi
18000281c:     	popq	%rbp
18000281d:     	popq	%rbx
18000281e:     	retq
18000281f:     	int3

0000000180002820 <numba_list_free>:
180002820:     	pushq	%rbx
180002822:     	subq	$0x20, %rsp
180002826:     	cmpq	$0x0, 0x28(%rcx)
18000282b:     	movq	%rcx, %rbx
18000282e:     	je	0x180002864 <numba_list_free+0x44>
180002830:     	movq	%rdi, 0x30(%rsp)
180002835:     	xorl	%edi, %edi
180002837:     	cmpq	%rdi, (%rcx)
18000283a:     	jle	0x18000285f <numba_list_free+0x3f>
18000283c:     	nopl	(%rax)
180002840:     	movq	0x28(%rbx), %rax
180002844:     	testq	%rax, %rax
180002847:     	je	0x180002857 <numba_list_free+0x37>
180002849:     	movq	%rdi, %rcx
18000284c:     	imulq	0x8(%rbx), %rcx
180002851:     	addq	0x30(%rbx), %rcx
180002855:     	callq	*%rax
180002857:     	incq	%rdi
18000285a:     	cmpq	(%rbx), %rdi
18000285d:     	jl	0x180002840 <numba_list_free+0x20>
18000285f:     	movq	0x30(%rsp), %rdi
180002864:     	movq	0x30(%rbx), %rcx
180002868:     	testq	%rcx, %rcx
18000286b:     	je	0x180002873 <numba_list_free+0x53>
18000286d:     	callq	*0x17f5(%rip)           # 0x180004068
180002873:     	movq	%rbx, %rcx
180002876:     	addq	$0x20, %rsp
18000287a:     	popq	%rbx
18000287b:     	jmpq	*0x17e6(%rip)           # 0x180004068
180002882:     	int3
180002883:     	int3
180002884:     	int3
180002885:     	int3
180002886:     	int3
180002887:     	int3
180002888:     	int3
180002889:     	int3
18000288a:     	int3
18000288b:     	int3
18000288c:     	int3
18000288d:     	int3
18000288e:     	int3
18000288f:     	int3

0000000180002890 <numba_list_base_ptr>:
180002890:     	movq	0x30(%rcx), %rax
180002894:     	retq
180002895:     	int3
180002896:     	int3
180002897:     	int3
180002898:     	int3
180002899:     	int3
18000289a:     	int3
18000289b:     	int3
18000289c:     	int3
18000289d:     	int3
18000289e:     	int3
18000289f:     	int3

00000001800028a0 <numba_list_size_address>:
1800028a0:     	movq	%rcx, %rax
1800028a3:     	retq
1800028a4:     	int3
1800028a5:     	int3
1800028a6:     	int3
1800028a7:     	int3
1800028a8:     	int3
1800028a9:     	int3
1800028aa:     	int3
1800028ab:     	int3
1800028ac:     	int3
1800028ad:     	int3
1800028ae:     	int3
1800028af:     	int3

00000001800028b0 <numba_list_length>:
1800028b0:     	movq	(%rcx), %rax
1800028b3:     	retq
1800028b4:     	int3
1800028b5:     	int3
1800028b6:     	int3
1800028b7:     	int3
1800028b8:     	int3
1800028b9:     	int3
1800028ba:     	int3
1800028bb:     	int3
1800028bc:     	int3
1800028bd:     	int3
1800028be:     	int3
1800028bf:     	int3

00000001800028c0 <numba_list_allocated>:
1800028c0:     	movq	0x10(%rcx), %rax
1800028c4:     	retq
1800028c5:     	int3
1800028c6:     	int3
1800028c7:     	int3
1800028c8:     	int3
1800028c9:     	int3
1800028ca:     	int3
1800028cb:     	int3
1800028cc:     	int3
1800028cd:     	int3
1800028ce:     	int3
1800028cf:     	int3

00000001800028d0 <numba_list_is_mutable>:
1800028d0:     	movl	0x18(%rcx), %eax
1800028d3:     	retq
1800028d4:     	int3
1800028d5:     	int3
1800028d6:     	int3
1800028d7:     	int3
1800028d8:     	int3
1800028d9:     	int3
1800028da:     	int3
1800028db:     	int3
1800028dc:     	int3
1800028dd:     	int3
1800028de:     	int3
1800028df:     	int3

00000001800028e0 <numba_list_set_is_mutable>:
1800028e0:     	movl	%edx, 0x18(%rcx)
1800028e3:     	retq
1800028e4:     	int3
1800028e5:     	int3
1800028e6:     	int3
1800028e7:     	int3
1800028e8:     	int3
1800028e9:     	int3
1800028ea:     	int3
1800028eb:     	int3
1800028ec:     	int3
1800028ed:     	int3
1800028ee:     	int3
1800028ef:     	int3

00000001800028f0 <numba_list_setitem>:
1800028f0:     	movq	%rbx, 0x10(%rsp)
1800028f5:     	pushq	%rsi
1800028f6:     	subq	$0x20, %rsp
1800028fa:     	cmpl	$0x0, 0x18(%rcx)
1800028fe:     	movq	%r8, %rsi
180002901:     	movq	%rcx, %rbx
180002904:     	jne	0x180002916 <numba_list_setitem+0x26>
180002906:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000290b:     	movq	0x38(%rsp), %rbx
180002910:     	addq	$0x20, %rsp
180002914:     	popq	%rsi
180002915:     	retq
180002916:     	cmpq	(%rcx), %rdx
180002919:     	jb	0x18000292b <numba_list_setitem+0x3b>
18000291b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002920:     	movq	0x38(%rsp), %rbx
180002925:     	addq	$0x20, %rsp
180002929:     	popq	%rsi
18000292a:     	retq
18000292b:     	imulq	0x8(%rcx), %rdx
180002930:     	movq	0x28(%rcx), %rax
180002934:     	movq	%rdi, 0x30(%rsp)
180002939:     	movq	0x30(%rcx), %rdi
18000293d:     	addq	%rdx, %rdi
180002940:     	testq	%rax, %rax
180002943:     	je	0x18000294a <numba_list_setitem+0x5a>
180002945:     	movq	%rdi, %rcx
180002948:     	callq	*%rax
18000294a:     	movq	0x8(%rbx), %r8
18000294e:     	movq	%rsi, %rdx
180002951:     	movq	%rdi, %rcx
180002954:     	callq	0x180003cb3 <numba_list_iter_next+0xe73>
180002959:     	movq	0x20(%rbx), %rax
18000295d:     	testq	%rax, %rax
180002960:     	je	0x180002967 <numba_list_setitem+0x77>
180002962:     	movq	%rdi, %rcx
180002965:     	callq	*%rax
180002967:     	movq	0x30(%rsp), %rdi
18000296c:     	xorl	%eax, %eax
18000296e:     	movq	0x38(%rsp), %rbx
180002973:     	addq	$0x20, %rsp
180002977:     	popq	%rsi
180002978:     	retq
180002979:     	int3
18000297a:     	int3
18000297b:     	int3
18000297c:     	int3
18000297d:     	int3
18000297e:     	int3
18000297f:     	int3

0000000180002980 <numba_list_getitem>:
180002980:     	subq	$0x28, %rsp
180002984:     	movq	%r8, %r9
180002987:     	movq	%rdx, %rax
18000298a:     	cmpq	(%rcx), %rdx
18000298d:     	jb	0x180002999 <numba_list_getitem+0x19>
18000298f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002994:     	addq	$0x28, %rsp
180002998:     	retq
180002999:     	movq	0x8(%rcx), %r8
18000299d:     	movq	%r8, %rdx
1800029a0:     	imulq	%rax, %rdx
1800029a4:     	addq	0x30(%rcx), %rdx
1800029a8:     	movq	%r9, %rcx
1800029ab:     	callq	0x180003cb3 <numba_list_iter_next+0xe73>
1800029b0:     	xorl	%eax, %eax
1800029b2:     	addq	$0x28, %rsp
1800029b6:     	retq
1800029b7:     	int3
1800029b8:     	int3
1800029b9:     	int3
1800029ba:     	int3
1800029bb:     	int3
1800029bc:     	int3
1800029bd:     	int3
1800029be:     	int3
1800029bf:     	int3

00000001800029c0 <numba_list_append>:
1800029c0:     	movq	%rbx, 0x10(%rsp)
1800029c5:     	pushq	%rsi
1800029c6:     	subq	$0x20, %rsp
1800029ca:     	cmpl	$0x0, 0x18(%rcx)
1800029ce:     	movq	%rdx, %rsi
1800029d1:     	movq	%rcx, %rbx
1800029d4:     	jne	0x1800029e6 <numba_list_append+0x26>
1800029d6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800029db:     	movq	0x38(%rsp), %rbx
1800029e0:     	addq	$0x20, %rsp
1800029e4:     	popq	%rsi
1800029e5:     	retq
1800029e6:     	movq	(%rcx), %rdx
1800029e9:     	incq	%rdx
1800029ec:     	callq	0x180002a40 <numba_list_resize>
1800029f1:     	testl	%eax, %eax
1800029f3:     	js	0x180002a2c <numba_list_append+0x6c>
1800029f5:     	movq	0x8(%rbx), %r8
1800029f9:     	movq	%rsi, %rdx
1800029fc:     	movq	%rdi, 0x30(%rsp)
180002a01:     	movq	(%rbx), %rdi
180002a04:     	decq	%rdi
180002a07:     	imulq	%r8, %rdi
180002a0b:     	addq	0x30(%rbx), %rdi
180002a0f:     	movq	%rdi, %rcx
180002a12:     	callq	0x180003cb3 <numba_list_iter_next+0xe73>
180002a17:     	movq	0x20(%rbx), %rax
180002a1b:     	testq	%rax, %rax
180002a1e:     	je	0x180002a25 <numba_list_append+0x65>
180002a20:     	movq	%rdi, %rcx
180002a23:     	callq	*%rax
180002a25:     	movq	0x30(%rsp), %rdi
180002a2a:     	xorl	%eax, %eax
180002a2c:     	movq	0x38(%rsp), %rbx
180002a31:     	addq	$0x20, %rsp
180002a35:     	popq	%rsi
180002a36:     	retq
180002a37:     	int3
180002a38:     	int3
180002a39:     	int3
180002a3a:     	int3
180002a3b:     	int3
180002a3c:     	int3
180002a3d:     	int3
180002a3e:     	int3
180002a3f:     	int3

0000000180002a40 <numba_list_resize>:
180002a40:     	movq	%rsi, 0x18(%rsp)
180002a45:     	pushq	%rdi
180002a46:     	subq	$0x20, %rsp
180002a4a:     	cmpl	$0x0, 0x18(%rcx)
180002a4e:     	movq	%rdx, %rsi
180002a51:     	movq	%rcx, %rdi
180002a54:     	jne	0x180002a66 <numba_list_resize+0x26>
180002a56:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002a5b:     	movq	0x40(%rsp), %rsi
180002a60:     	addq	$0x20, %rsp
180002a64:     	popq	%rdi
180002a65:     	retq
180002a66:     	movq	0x10(%rcx), %rax
180002a6a:     	cmpq	%rsi, %rax
180002a6d:     	jl	0x180002a87 <numba_list_resize+0x47>
180002a6f:     	sarq	%rax
180002a72:     	cmpq	%rax, %rsi
180002a75:     	jl	0x180002a87 <numba_list_resize+0x47>
180002a77:     	movq	%rsi, (%rcx)
180002a7a:     	xorl	%eax, %eax
180002a7c:     	movq	0x40(%rsp), %rsi
180002a81:     	addq	$0x20, %rsp
180002a85:     	popq	%rdi
180002a86:     	retq
180002a87:     	cmpq	$0x9, %rsi
180002a8b:     	movq	%rbp, 0x38(%rsp)
180002a90:     	movl	$0x3, %ecx
180002a95:     	movl	$0x6, %eax
180002a9a:     	cmovll	%ecx, %eax
180002a9d:     	movq	%rsi, %r8
180002aa0:     	movq	0x8(%rdi), %rcx
180002aa4:     	addq	%rsi, %rax
180002aa7:     	sarq	$0x3, %r8
180002aab:     	xorl	%edx, %edx
180002aad:     	addq	%rax, %r8
180002ab0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002aba:     	divq	%rcx
180002abd:     	cmpq	%rax, %r8
180002ac0:     	ja	0x180002b3b <numba_list_resize+0xfb>
180002ac2:     	xorl	%ebp, %ebp
180002ac4:     	movq	%rbx, 0x30(%rsp)
180002ac9:     	testq	%rsi, %rsi
180002acc:     	cmovneq	%r8, %rbp
180002ad0:     	movq	%rbp, %rbx
180002ad3:     	imulq	%rcx, %rbx
180002ad7:     	movl	$0x8, %ecx
180002adc:     	movq	%rbx, %rax
180002adf:     	cqto
180002ae1:     	andl	$0x7, %edx
180002ae4:     	addq	%rdx, %rax
180002ae7:     	andl	$0x7, %eax
180002aea:     	subq	%rdx, %rax
180002aed:     	subq	%rax, %rcx
180002af0:     	movq	%rcx, %rax
180002af3:     	movq	0x30(%rdi), %rcx
180002af7:     	cqto
180002af9:     	andl	$0x7, %edx
180002afc:     	addq	%rdx, %rax
180002aff:     	andl	$0x7, %eax
180002b02:     	subq	%rdx, %rax
180002b05:     	leaq	(%rbx,%rax), %rdx
180002b09:     	callq	*0x1561(%rip)           # 0x180004070
180002b0f:     	testq	%rbx, %rbx
180002b12:     	movq	0x30(%rsp), %rbx
180002b17:     	je	0x180002b1e <numba_list_resize+0xde>
180002b19:     	testq	%rax, %rax
180002b1c:     	je	0x180002b3b <numba_list_resize+0xfb>
180002b1e:     	movq	%rax, 0x30(%rdi)
180002b22:     	xorl	%eax, %eax
180002b24:     	movq	%rbp, 0x10(%rdi)
180002b28:     	movq	0x38(%rsp), %rbp
180002b2d:     	movq	%rsi, (%rdi)
180002b30:     	movq	0x40(%rsp), %rsi
180002b35:     	addq	$0x20, %rsp
180002b39:     	popq	%rdi
180002b3a:     	retq
180002b3b:     	movq	0x38(%rsp), %rbp
180002b40:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002b45:     	movq	0x40(%rsp), %rsi
180002b4a:     	addq	$0x20, %rsp
180002b4e:     	popq	%rdi
180002b4f:     	retq

0000000180002b50 <numba_list_delitem>:
180002b50:     	movq	%rbx, 0x10(%rsp)
180002b55:     	pushq	%rdi
180002b56:     	subq	$0x20, %rsp
180002b5a:     	cmpl	$0x0, 0x18(%rcx)
180002b5e:     	movq	%rdx, %rdi
180002b61:     	movq	%rcx, %rbx
180002b64:     	jne	0x180002b76 <numba_list_delitem+0x26>
180002b66:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002b6b:     	movq	0x38(%rsp), %rbx
180002b70:     	addq	$0x20, %rsp
180002b74:     	popq	%rdi
180002b75:     	retq
180002b76:     	cmpq	(%rcx), %rdi
180002b79:     	jb	0x180002b8b <numba_list_delitem+0x3b>
180002b7b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002b80:     	movq	0x38(%rsp), %rbx
180002b85:     	addq	$0x20, %rsp
180002b89:     	popq	%rdi
180002b8a:     	retq
180002b8b:     	movq	0x28(%rcx), %rax
180002b8f:     	movq	%rsi, 0x30(%rsp)
180002b94:     	movq	%rdi, %rsi
180002b97:     	imulq	0x8(%rcx), %rsi
180002b9c:     	addq	0x30(%rcx), %rsi
180002ba0:     	testq	%rax, %rax
180002ba3:     	je	0x180002baa <numba_list_delitem+0x5a>
180002ba5:     	movq	%rsi, %rcx
180002ba8:     	callq	*%rax
180002baa:     	movq	(%rbx), %r8
180002bad:     	leaq	-0x1(%r8), %rax
180002bb1:     	cmpq	%rax, %rdi
180002bb4:     	je	0x180002bd6 <numba_list_delitem+0x86>
180002bb6:     	subq	%rdi, %r8
180002bb9:     	leaq	0x1(%rdi), %rdx
180002bbd:     	imulq	0x8(%rbx), %rdx
180002bc2:     	decq	%r8
180002bc5:     	movq	%rsi, %rcx
180002bc8:     	imulq	0x8(%rbx), %r8
180002bcd:     	addq	0x30(%rbx), %rdx
180002bd1:     	callq	0x180003cb9 <numba_list_iter_next+0xe79>
180002bd6:     	movq	(%rbx), %rdx
180002bd9:     	movq	%rbx, %rcx
180002bdc:     	decq	%rdx
180002bdf:     	callq	0x180002a40 <numba_list_resize>
180002be4:     	movq	0x30(%rsp), %rsi
180002be9:     	xorl	%ecx, %ecx
180002beb:     	movq	0x38(%rsp), %rbx
180002bf0:     	testl	%eax, %eax
180002bf2:     	cmovsl	%eax, %ecx
180002bf5:     	movl	%ecx, %eax
180002bf7:     	addq	$0x20, %rsp
180002bfb:     	popq	%rdi
180002bfc:     	retq
180002bfd:     	int3
180002bfe:     	int3
180002bff:     	int3

0000000180002c00 <numba_list_delete_slice>:
180002c00:     	pushq	%rbx
180002c02:     	pushq	%rbp
180002c03:     	pushq	%rdi
180002c04:     	pushq	%r15
180002c06:     	subq	$0x38, %rsp
180002c0a:     	cmpl	$0x0, 0x18(%rcx)
180002c0e:     	movq	%r9, %rdi
180002c11:     	movq	%r8, %rbp
180002c14:     	movq	%rdx, %r15
180002c17:     	movq	%rcx, %rbx
180002c1a:     	jne	0x180002c2b <numba_list_delete_slice+0x2b>
180002c1c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002c21:     	addq	$0x38, %rsp
180002c25:     	popq	%r15
180002c27:     	popq	%rdi
180002c28:     	popq	%rbp
180002c29:     	popq	%rbx
180002c2a:     	retq
180002c2b:     	movq	%r13, 0x78(%rsp)
180002c30:     	testq	%rdi, %rdi
180002c33:     	jle	0x180002c52 <numba_list_delete_slice+0x52>
180002c35:     	cmpq	%r8, %r15
180002c38:     	jge	0x180002df1 <numba_list_delete_slice+0x1f1>
180002c3e:     	movq	%r8, %rax
180002c41:     	subq	%r15, %rax
180002c44:     	decq	%rax
180002c47:     	cqto
180002c49:     	idivq	%rdi
180002c4c:     	leal	0x1(%rax), %r13d
180002c50:     	jmp	0x180002c72 <numba_list_delete_slice+0x72>
180002c52:     	cmpq	%r15, %r8
180002c55:     	jge	0x180002df1 <numba_list_delete_slice+0x1f1>
180002c5b:     	movq	%r15, %rax
180002c5e:     	movl	$0x1, %r13d
180002c64:     	subq	%r8, %rax
180002c67:     	decq	%rax
180002c6a:     	cqto
180002c6c:     	idivq	%rdi
180002c6f:     	subl	%eax, %r13d
180002c72:     	testl	%r13d, %r13d
180002c75:     	jle	0x180002df1 <numba_list_delete_slice+0x1f1>
180002c7b:     	movq	%rsi, 0x68(%rsp)
180002c80:     	movl	(%rcx), %esi
180002c82:     	subl	%r13d, %esi
180002c85:     	movl	%esi, 0x20(%rsp)
180002c89:     	testq	%rdi, %rdi
180002c8c:     	jns	0x180002ca7 <numba_list_delete_slice+0xa7>
180002c8e:     	leaq	0x1(%r15), %rbp
180002c92:     	leal	-0x1(%r13), %eax
180002c96:     	movslq	%eax, %rcx
180002c99:     	leaq	-0x1(%rbp), %r15
180002c9d:     	imulq	%rdi, %rcx
180002ca1:     	addq	%rcx, %r15
180002ca4:     	negq	%rdi
180002ca7:     	cmpq	$0x1, %rdi
180002cab:     	jne	0x180002cf7 <numba_list_delete_slice+0xf7>
180002cad:     	cmpq	$0x0, 0x28(%rbx)
180002cb2:     	je	0x180002cd9 <numba_list_delete_slice+0xd9>
180002cb4:     	movslq	%r15d, %rdi
180002cb7:     	cmpq	%rbp, %rdi
180002cba:     	jge	0x180002cd9 <numba_list_delete_slice+0xd9>
180002cbc:     	nopl	(%rax)
180002cc0:     	movslq	%edi, %rcx
180002cc3:     	imulq	0x8(%rbx), %rcx
180002cc8:     	addq	0x30(%rbx), %rcx
180002ccc:     	callq	*0x28(%rbx)
180002ccf:     	incl	%edi
180002cd1:     	movslq	%edi, %rax
180002cd4:     	cmpq	%rbp, %rax
180002cd7:     	jl	0x180002cc0 <numba_list_delete_slice+0xc0>
180002cd9:     	movq	0x8(%rbx), %rcx
180002cdd:     	movq	(%rbx), %r8
180002ce0:     	movq	%rcx, %rdx
180002ce3:     	subq	%rbp, %r8
180002ce6:     	imulq	%rcx, %r8
180002cea:     	imulq	%rbp, %rdx
180002cee:     	imulq	%r15, %rcx
180002cf2:     	jmp	0x180002dbc <numba_list_delete_slice+0x1bc>
180002cf7:     	movq	%r14, 0x30(%rsp)
180002cfc:     	movq	%r15, %r14
180002cff:     	movl	$0x0, 0x60(%rsp)
180002d07:     	cmpq	%rbp, %r15
180002d0a:     	jge	0x180002d89 <numba_list_delete_slice+0x189>
180002d0c:     	movq	%r12, 0x70(%rsp)
180002d11:     	movq	(%rbx), %rax
180002d14:     	leaq	(%r14,%rdi), %r12
180002d18:     	cmpq	%rax, %r12
180002d1b:     	jl	0x180002d28 <numba_list_delete_slice+0x128>
180002d1d:     	movq	%r14, %rsi
180002d20:     	notq	%rsi
180002d23:     	addq	%rax, %rsi
180002d26:     	jmp	0x180002d2c <numba_list_delete_slice+0x12c>
180002d28:     	leaq	-0x1(%rdi), %rsi
180002d2c:     	movq	0x28(%rbx), %rax
180002d30:     	testq	%rax, %rax
180002d33:     	je	0x180002d43 <numba_list_delete_slice+0x143>
180002d35:     	movq	%r14, %rcx
180002d38:     	imulq	0x8(%rbx), %rcx
180002d3d:     	addq	0x30(%rbx), %rcx
180002d41:     	callq	*%rax
180002d43:     	movq	0x8(%rbx), %r9
180002d47:     	leaq	0x1(%r14), %rdx
180002d4b:     	movq	0x30(%rbx), %r10
180002d4f:     	movq	%r9, %r8
180002d52:     	imulq	%rsi, %r8
180002d56:     	imulq	%r9, %rdx
180002d5a:     	movslq	0x60(%rsp), %rsi
180002d5f:     	subq	%rsi, %r14
180002d62:     	imulq	%r9, %r14
180002d66:     	addq	%r10, %rdx
180002d69:     	leaq	(%r10,%r14), %rcx
180002d6d:     	callq	0x180003cb9 <numba_list_iter_next+0xe79>
180002d72:     	incl	%esi
180002d74:     	movq	%r12, %r14
180002d77:     	movl	%esi, 0x60(%rsp)
180002d7b:     	cmpq	%rbp, %r12
180002d7e:     	jl	0x180002d11 <numba_list_delete_slice+0x111>
180002d80:     	movq	0x70(%rsp), %r12
180002d85:     	movl	0x20(%rsp), %esi
180002d89:     	movq	(%rbx), %r8
180002d8c:     	movq	0x30(%rsp), %r14
180002d91:     	movslq	%r13d, %r10
180002d94:     	movq	%r10, %rcx
180002d97:     	imulq	%rdi, %rcx
180002d9b:     	addq	%r15, %rcx
180002d9e:     	cmpq	%r8, %rcx
180002da1:     	jge	0x180002dc9 <numba_list_delete_slice+0x1c9>
180002da3:     	movq	0x8(%rbx), %rax
180002da7:     	subq	%rcx, %r8
180002daa:     	movq	%rax, %rdx
180002dad:     	imulq	%rcx, %rdx
180002db1:     	imulq	%rax, %r8
180002db5:     	subq	%r10, %rcx
180002db8:     	imulq	%rax, %rcx
180002dbc:     	addq	0x30(%rbx), %rdx
180002dc0:     	addq	0x30(%rbx), %rcx
180002dc4:     	callq	0x180003cb9 <numba_list_iter_next+0xe79>
180002dc9:     	movslq	%esi, %rdx
180002dcc:     	movq	%rbx, %rcx
180002dcf:     	callq	0x180002a40 <numba_list_resize>
180002dd4:     	movq	0x68(%rsp), %rsi
180002dd9:     	xorl	%ecx, %ecx
180002ddb:     	movq	0x78(%rsp), %r13
180002de0:     	testl	%eax, %eax
180002de2:     	cmovsl	%eax, %ecx
180002de5:     	movl	%ecx, %eax
180002de7:     	addq	$0x38, %rsp
180002deb:     	popq	%r15
180002ded:     	popq	%rdi
180002dee:     	popq	%rbp
180002def:     	popq	%rbx
180002df0:     	retq
180002df1:     	movq	0x78(%rsp), %r13
180002df6:     	xorl	%eax, %eax
180002df8:     	addq	$0x38, %rsp
180002dfc:     	popq	%r15
180002dfe:     	popq	%rdi
180002dff:     	popq	%rbp
180002e00:     	popq	%rbx
180002e01:     	retq
180002e02:     	int3
180002e03:     	int3
180002e04:     	int3
180002e05:     	int3
180002e06:     	int3
180002e07:     	int3
180002e08:     	int3
180002e09:     	int3
180002e0a:     	int3
180002e0b:     	int3
180002e0c:     	int3
180002e0d:     	int3
180002e0e:     	int3
180002e0f:     	int3

0000000180002e10 <numba_list_iter_sizeof>:
180002e10:     	movl	$0x18, %eax
180002e15:     	retq
180002e16:     	int3
180002e17:     	int3
180002e18:     	int3
180002e19:     	int3
180002e1a:     	int3
180002e1b:     	int3
180002e1c:     	int3
180002e1d:     	int3
180002e1e:     	int3
180002e1f:     	int3

0000000180002e20 <numba_list_iter>:
180002e20:     	movq	%rdx, (%rcx)
180002e23:     	movq	(%rdx), %rax
180002e26:     	movq	%rax, 0x8(%rcx)
180002e2a:     	movq	$0x0, 0x10(%rcx)
180002e32:     	retq
180002e33:     	int3
180002e34:     	int3
180002e35:     	int3
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

0000000180002e40 <numba_list_iter_next>:
180002e40:     	movq	(%rcx), %r8
180002e43:     	movq	(%r8), %r9
180002e46:     	cmpq	0x8(%rcx), %r9
180002e4a:     	je	0x180002e52 <numba_list_iter_next+0x12>
180002e4c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002e51:     	retq
180002e52:     	movq	0x10(%rcx), %rax
180002e56:     	cmpq	%r9, %rax
180002e59:     	jge	0x180002e6e <numba_list_iter_next+0x2e>
180002e5b:     	imulq	0x8(%r8), %rax
180002e60:     	addq	0x30(%r8), %rax
180002e64:     	movq	%rax, (%rdx)
180002e67:     	incq	0x10(%rcx)
180002e6b:     	xorl	%eax, %eax
180002e6d:     	retq
180002e6e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002e73:     	retq
180002e74:     	int3
180002e75:     	int3
180002e76:     	int3
180002e77:     	int3
180002e78:     	int3
180002e79:     	int3
180002e7a:     	int3
180002e7b:     	int3
180002e7c:     	int3
180002e7d:     	int3
180002e7e:     	int3
180002e7f:     	int3
180002e80:     	pushq	%rbx
180002e82:     	subq	$0x20, %rsp
180002e86:     	movq	%rcx, %rbx
180002e89:     	addq	$0x30, %rcx
180002e8d:     	callq	*0x7d95(%rip)           # 0x18000ac28
180002e93:     	cmpb	$0x0, 0x7d66(%rip)      # 0x18000ac00
180002e9a:     	je	0x180002ea4 <numba_list_iter_next+0x64>
180002e9c:     	lock
180002e9d:     	incq	0x7d64(%rip)            # 0x18000ac08
180002ea4:     	testq	%rax, %rax
180002ea7:     	je	0x180002ee8 <numba_list_iter_next+0xa8>
180002ea9:     	leaq	0x30(%rax), %rdx
180002ead:     	testq	%rdx, %rdx
180002eb0:     	je	0x180002ee8 <numba_list_iter_next+0xa8>
180002eb2:     	xorl	%r8d, %r8d
180002eb5:     	movl	$0x1, %ecx
180002eba:     	xchgq	%rcx, (%rax)
180002ebd:     	movq	%r8, 0x8(%rax)
180002ec1:     	movq	%r8, 0x10(%rax)
180002ec5:     	movq	%rdx, 0x18(%rax)
180002ec9:     	movq	%rbx, 0x20(%rax)
180002ecd:     	movq	%r8, 0x28(%rax)
180002ed1:     	cmpb	%r8b, 0x7d28(%rip)      # 0x18000ac00
180002ed8:     	je	0x180002eea <numba_list_iter_next+0xaa>
180002eda:     	lock
180002edb:     	incq	0x7d36(%rip)            # 0x18000ac18
180002ee2:     	addq	$0x20, %rsp
180002ee6:     	popq	%rbx
180002ee7:     	retq
180002ee8:     	xorl	%eax, %eax
180002eea:     	addq	$0x20, %rsp
180002eee:     	popq	%rbx
180002eef:     	retq
180002ef0:     	movq	%rbx, 0x8(%rsp)
180002ef5:     	pushq	%rdi
180002ef6:     	subq	$0x20, %rsp
180002efa:     	movq	%rcx, %rdi
180002efd:     	movq	%rdx, %rbx
180002f00:     	addq	$0x30, %rcx
180002f04:     	testq	%rdx, %rdx
180002f07:     	je	0x180002f11 <numba_list_iter_next+0xd1>
180002f09:     	movq	0x18(%rdx), %rdx
180002f0d:     	callq	*(%rbx)
180002f0f:     	jmp	0x180002f17 <numba_list_iter_next+0xd7>
180002f11:     	callq	*0x7d11(%rip)           # 0x18000ac28
180002f17:     	cmpb	$0x0, 0x7ce2(%rip)      # 0x18000ac00
180002f1e:     	movq	%rax, %r8
180002f21:     	je	0x180002f2b <numba_list_iter_next+0xeb>
180002f23:     	lock
180002f24:     	incq	0x7cdd(%rip)            # 0x18000ac08
180002f2b:     	xorl	%edx, %edx
180002f2d:     	leaq	0x30(%r8), %rax
180002f31:     	testq	%r8, %r8
180002f34:     	movl	%edx, %ecx
180002f36:     	cmovneq	%rax, %rcx
180002f3a:     	testq	%rcx, %rcx
180002f3d:     	jne	0x180002f4c <numba_list_iter_next+0x10c>
180002f3f:     	xorl	%eax, %eax
180002f41:     	movq	0x30(%rsp), %rbx
180002f46:     	addq	$0x20, %rsp
180002f4a:     	popq	%rdi
180002f4b:     	retq
180002f4c:     	movl	$0x1, %eax
180002f51:     	xchgq	%rax, (%r8)
180002f54:     	movq	%rdx, 0x8(%r8)
180002f58:     	movq	%rdx, 0x10(%r8)
180002f5c:     	movq	%rcx, 0x18(%r8)
180002f60:     	movq	%rdi, 0x20(%r8)
180002f64:     	movq	%rbx, 0x28(%r8)
180002f68:     	cmpb	%dl, 0x7c92(%rip)       # 0x18000ac00
180002f6e:     	je	0x180002f78 <numba_list_iter_next+0x138>
180002f70:     	lock
180002f71:     	incq	0x7ca0(%rip)            # 0x18000ac18
180002f78:     	movq	0x30(%rsp), %rbx
180002f7d:     	movq	%r8, %rax
180002f80:     	addq	$0x20, %rsp
180002f84:     	popq	%rdi
180002f85:     	retq
180002f86:     	int3
180002f87:     	int3
180002f88:     	int3
180002f89:     	int3
180002f8a:     	int3
180002f8b:     	int3
180002f8c:     	int3
180002f8d:     	int3
180002f8e:     	int3
180002f8f:     	int3
180002f90:     	lock
180002f91:     	incq	(%rcx)
180002f94:     	retq
180002f95:     	int3
180002f96:     	int3
180002f97:     	int3
180002f98:     	int3
180002f99:     	int3
180002f9a:     	int3
180002f9b:     	int3
180002f9c:     	int3
180002f9d:     	int3
180002f9e:     	int3
180002f9f:     	int3
180002fa0:     	pushq	%rbx
180002fa2:     	subq	$0x20, %rsp
180002fa6:     	movq	0x8(%rcx), %rax
180002faa:     	movq	%rcx, %rbx
180002fad:     	testq	%rax, %rax
180002fb0:     	je	0x180002fc9 <numba_list_iter_next+0x189>
180002fb2:     	cmpl	$0x0, 0x7c3f(%rip)      # 0x18000abf8
180002fb9:     	jne	0x180002fc9 <numba_list_iter_next+0x189>
180002fbb:     	movq	0x10(%rcx), %r8
180002fbf:     	movq	0x20(%rcx), %rdx
180002fc3:     	movq	0x18(%rcx), %rcx
180002fc7:     	callq	*%rax
180002fc9:     	movq	0x28(%rbx), %rax
180002fcd:     	movq	%rbx, %rcx
180002fd0:     	testq	%rax, %rax
180002fd3:     	je	0x180002fde <numba_list_iter_next+0x19e>
180002fd5:     	movq	0x18(%rax), %rdx
180002fd9:     	callq	*0x10(%rax)
180002fdc:     	jmp	0x180002fe4 <numba_list_iter_next+0x1a4>
180002fde:     	callq	*0x7c54(%rip)           # 0x18000ac38
180002fe4:     	cmpb	$0x0, 0x7c15(%rip)      # 0x18000ac00
180002feb:     	je	0x180003009 <numba_list_iter_next+0x1c9>
180002fed:     	leaq	0x7c1c(%rip), %rax      # 0x18000ac10
180002ff4:     	lock
180002ff5:     	incq	(%rax)
180002ff8:     	cmpb	$0x0, 0x7c01(%rip)      # 0x18000ac00
180002fff:     	je	0x180003009 <numba_list_iter_next+0x1c9>
180003001:     	lock
180003002:     	incq	0x7c17(%rip)            # 0x18000ac20
180003009:     	addq	$0x20, %rsp
18000300d:     	popq	%rbx
18000300e:     	retq
18000300f:     	int3
180003010:     	pushq	%rbx
180003012:     	subq	$0x20, %rsp
180003016:     	movq	%rcx, %rbx
180003019:     	movq	$-0x1, %rax
180003020:     	lock
180003021:     	xaddq	%rax, (%rcx)
180003025:     	cmpq	$0x1, %rax
180003029:     	jne	0x18000308b <numba_list_iter_next+0x24b>
18000302b:     	movq	0x8(%rcx), %rax
18000302f:     	testq	%rax, %rax
180003032:     	je	0x18000304b <numba_list_iter_next+0x20b>
180003034:     	cmpl	$0x0, 0x7bbd(%rip)      # 0x18000abf8
18000303b:     	jne	0x18000304b <numba_list_iter_next+0x20b>
18000303d:     	movq	0x10(%rcx), %r8
180003041:     	movq	0x20(%rcx), %rdx
180003045:     	movq	0x18(%rcx), %rcx
180003049:     	callq	*%rax
18000304b:     	movq	0x28(%rbx), %rax
18000304f:     	movq	%rbx, %rcx
180003052:     	testq	%rax, %rax
180003055:     	je	0x180003060 <numba_list_iter_next+0x220>
180003057:     	movq	0x18(%rax), %rdx
18000305b:     	callq	*0x10(%rax)
18000305e:     	jmp	0x180003066 <numba_list_iter_next+0x226>
180003060:     	callq	*0x7bd2(%rip)           # 0x18000ac38
180003066:     	cmpb	$0x0, 0x7b93(%rip)      # 0x18000ac00
18000306d:     	je	0x18000308b <numba_list_iter_next+0x24b>
18000306f:     	leaq	0x7b9a(%rip), %rax      # 0x18000ac10
180003076:     	lock
180003077:     	incq	(%rax)
18000307a:     	cmpb	$0x0, 0x7b7f(%rip)      # 0x18000ac00
180003081:     	je	0x18000308b <numba_list_iter_next+0x24b>
180003083:     	lock
180003084:     	incq	0x7b95(%rip)            # 0x18000ac20
18000308b:     	addq	$0x20, %rsp
18000308f:     	popq	%rbx
180003090:     	retq
180003091:     	int3
180003092:     	int3
180003093:     	int3
180003094:     	int3
180003095:     	int3
180003096:     	int3
180003097:     	int3
180003098:     	int3
180003099:     	int3
18000309a:     	int3
18000309b:     	int3
18000309c:     	int3
18000309d:     	int3
18000309e:     	int3
18000309f:     	int3
1800030a0:     	movq	0x18(%rcx), %rax
1800030a4:     	retq
1800030a5:     	int3
1800030a6:     	int3
1800030a7:     	int3
1800030a8:     	int3
1800030a9:     	int3
1800030aa:     	int3
1800030ab:     	int3
1800030ac:     	int3
1800030ad:     	int3
1800030ae:     	int3
1800030af:     	int3
1800030b0:     	jmpq	*%r8
1800030b3:     	int3
1800030b4:     	int3
1800030b5:     	int3
1800030b6:     	int3
1800030b7:     	int3
1800030b8:     	int3
1800030b9:     	int3
1800030ba:     	int3
1800030bb:     	int3
1800030bc:     	int3
1800030bd:     	int3
1800030be:     	int3
1800030bf:     	int3
1800030c0:     	movq	%rbx, 0x8(%rsp)
1800030c5:     	pushq	%rdi
1800030c6:     	subq	$0x20, %rsp
1800030ca:     	movq	%rcx, %rdi
1800030cd:     	movq	%rdx, %rbx
1800030d0:     	movl	$0x30, %ecx
1800030d5:     	callq	*0x7b4d(%rip)           # 0x18000ac28
1800030db:     	cmpb	$0x0, 0x7b1e(%rip)      # 0x18000ac00
1800030e2:     	je	0x1800030ec <numba_list_iter_next+0x2ac>
1800030e4:     	lock
1800030e5:     	incq	0x7b1c(%rip)            # 0x18000ac08
1800030ec:     	testq	%rax, %rax
1800030ef:     	je	0x180003126 <numba_list_iter_next+0x2e6>
1800030f1:     	leaq	-0x48(%rip), %rcx       # 0x1800030b0 <numba_list_iter_next+0x270>
1800030f8:     	movl	$0x1, %edx
1800030fd:     	xchgq	%rdx, (%rax)
180003100:     	movq	%rcx, 0x8(%rax)
180003104:     	xorl	%ecx, %ecx
180003106:     	movq	%rcx, 0x20(%rax)
18000310a:     	movq	%rcx, 0x28(%rax)
18000310e:     	movq	%rbx, 0x10(%rax)
180003112:     	movq	%rdi, 0x18(%rax)
180003116:     	cmpb	%cl, 0x7ae4(%rip)       # 0x18000ac00
18000311c:     	je	0x180003126 <numba_list_iter_next+0x2e6>
18000311e:     	lock
18000311f:     	incq	0x7af2(%rip)            # 0x18000ac18
180003126:     	movq	0x30(%rsp), %rbx
18000312b:     	addq	$0x20, %rsp
18000312f:     	popq	%rdi
180003130:     	retq
180003131:     	jmpq	*0x1139(%rip)           # 0x180004270
180003137:     	jmpq	*0x1123(%rip)           # 0x180004260
18000313d:     	jmpq	*0x1115(%rip)           # 0x180004258
180003143:     	jmpq	*0x1107(%rip)           # 0x180004250
180003149:     	jmpq	*0x10f9(%rip)           # 0x180004248
18000314f:     	jmpq	*0x10eb(%rip)           # 0x180004240
180003155:     	jmpq	*0x10d5(%rip)           # 0x180004230
18000315b:     	jmpq	*0x10bf(%rip)           # 0x180004220
180003161:     	jmpq	*0x1099(%rip)           # 0x180004200
180003167:     	int3
180003168:     	int3
180003169:     	int3
18000316a:     	int3
18000316b:     	int3
18000316c:     	int3
18000316d:     	int3
18000316e:     	int3
18000316f:     	int3
180003170:     	int3
180003171:     	int3
180003172:     	int3
180003173:     	int3
180003174:     	int3
180003175:     	int3
180003176:     	nopw	(%rax,%rax)
180003180:     	cmpq	0x6f39(%rip), %rcx      # 0x18000a0c0
180003187:     	jne	0x180003199 <numba_list_iter_next+0x359>
180003189:     	rolq	$0x10, %rcx
18000318d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180003192:     	jne	0x180003195 <numba_list_iter_next+0x355>
180003194:     	retq
180003195:     	rorq	$0x10, %rcx
180003199:     	jmp	0x1800034f4 <numba_list_iter_next+0x6b4>
18000319e:     	int3
18000319f:     	int3
1800031a0:     	subq	$0x28, %rsp
1800031a4:     	testl	%edx, %edx
1800031a6:     	je	0x1800031e1 <numba_list_iter_next+0x3a1>
1800031a8:     	subl	$0x1, %edx
1800031ab:     	je	0x1800031d5 <numba_list_iter_next+0x395>
1800031ad:     	subl	$0x1, %edx
1800031b0:     	je	0x1800031c8 <numba_list_iter_next+0x388>
1800031b2:     	cmpl	$0x1, %edx
1800031b5:     	je	0x1800031c1 <numba_list_iter_next+0x381>
1800031b7:     	movl	$0x1, %eax
1800031bc:     	addq	$0x28, %rsp
1800031c0:     	retq
1800031c1:     	callq	0x1800036c0 <numba_list_iter_next+0x880>
1800031c6:     	jmp	0x1800031cd <numba_list_iter_next+0x38d>
1800031c8:     	callq	0x180003698 <numba_list_iter_next+0x858>
1800031cd:     	movzbl	%al, %eax
1800031d0:     	addq	$0x28, %rsp
1800031d4:     	retq
1800031d5:     	movq	%r8, %rdx
1800031d8:     	addq	$0x28, %rsp
1800031dc:     	jmp	0x1800031f0 <numba_list_iter_next+0x3b0>
1800031e1:     	testq	%r8, %r8
1800031e4:     	setne	%cl
1800031e7:     	addq	$0x28, %rsp
1800031eb:     	jmp	0x180003308 <numba_list_iter_next+0x4c8>
1800031f0:     	movq	%rbx, 0x8(%rsp)
1800031f5:     	movq	%rsi, 0x10(%rsp)
1800031fa:     	movq	%rdi, 0x20(%rsp)
1800031ff:     	pushq	%r14
180003201:     	subq	$0x20, %rsp
180003205:     	movq	%rdx, %rsi
180003208:     	movq	%rcx, %r14
18000320b:     	xorl	%ecx, %ecx
18000320d:     	callq	0x18000377c <numba_list_iter_next+0x93c>
180003212:     	testb	%al, %al
180003214:     	je	0x1800032e2 <numba_list_iter_next+0x4a2>
18000321a:     	callq	0x180003610 <numba_list_iter_next+0x7d0>
18000321f:     	movb	%al, %bl
180003221:     	movb	%al, 0x40(%rsp)
180003225:     	movb	$0x1, %dil
180003228:     	cmpl	$0x0, 0x7799(%rip)      # 0x18000a9c8
18000322f:     	jne	0x1800032fa <numba_list_iter_next+0x4ba>
180003235:     	movl	$0x1, 0x7789(%rip)      # 0x18000a9c8
18000323f:     	callq	0x180003680 <numba_list_iter_next+0x840>
180003244:     	testb	%al, %al
180003246:     	je	0x180003297 <numba_list_iter_next+0x457>
180003248:     	callq	0x18000393c <numba_list_iter_next+0xafc>
18000324d:     	callq	0x1800035d0 <numba_list_iter_next+0x790>
180003252:     	callq	0x1800035f4 <numba_list_iter_next+0x7b4>
180003257:     	leaq	0x1072(%rip), %rdx      # 0x1800042d0
18000325e:     	leaq	0x1063(%rip), %rcx      # 0x1800042c8
180003265:     	callq	0x180003c82 <numba_list_iter_next+0xe42>
18000326a:     	testl	%eax, %eax
18000326c:     	jne	0x180003297 <numba_list_iter_next+0x457>
18000326e:     	callq	0x18000364c <numba_list_iter_next+0x80c>
180003273:     	testb	%al, %al
180003275:     	je	0x180003297 <numba_list_iter_next+0x457>
180003277:     	leaq	0x1042(%rip), %rdx      # 0x1800042c0
18000327e:     	leaq	0x1033(%rip), %rcx      # 0x1800042b8
180003285:     	callq	0x180003c7c <numba_list_iter_next+0xe3c>
18000328a:     	movl	$0x2, 0x7734(%rip)      # 0x18000a9c8
180003294:     	xorb	%dil, %dil
180003297:     	movb	%bl, %cl
180003299:     	callq	0x1800038dc <numba_list_iter_next+0xa9c>
18000329e:     	testb	%dil, %dil
1800032a1:     	jne	0x1800032e2 <numba_list_iter_next+0x4a2>
1800032a3:     	callq	0x18000392c <numba_list_iter_next+0xaec>
1800032a8:     	movq	%rax, %rbx
1800032ab:     	cmpq	$0x0, (%rax)
1800032af:     	je	0x1800032d5 <numba_list_iter_next+0x495>
1800032b1:     	movq	%rax, %rcx
1800032b4:     	callq	0x180003844 <numba_list_iter_next+0xa04>
1800032b9:     	testb	%al, %al
1800032bb:     	je	0x1800032d5 <numba_list_iter_next+0x495>
1800032bd:     	movq	%rsi, %r8
1800032c0:     	movl	$0x2, %edx
1800032c5:     	movq	%r14, %rcx
1800032c8:     	movq	(%rbx), %rax
1800032cb:     	movq	0xfbe(%rip), %r9        # 0x180004290
1800032d2:     	callq	*%r9
1800032d5:     	incl	0x76c5(%rip)            # 0x18000a9a0
1800032db:     	movl	$0x1, %eax
1800032e0:     	jmp	0x1800032e4 <numba_list_iter_next+0x4a4>
1800032e2:     	xorl	%eax, %eax
1800032e4:     	movq	0x30(%rsp), %rbx
1800032e9:     	movq	0x38(%rsp), %rsi
1800032ee:     	movq	0x48(%rsp), %rdi
1800032f3:     	addq	$0x20, %rsp
1800032f7:     	popq	%r14
1800032f9:     	retq
1800032fa:     	movl	$0x7, %ecx
1800032ff:     	callq	0x180003934 <numba_list_iter_next+0xaf4>
180003304:     	nop
180003305:     	int3
180003306:     	int3
180003307:     	int3
180003308:     	movq	%rbx, 0x8(%rsp)
18000330d:     	pushq	%rdi
18000330e:     	subq	$0x30, %rsp
180003312:     	movb	%cl, %dil
180003315:     	movl	0x7685(%rip), %eax      # 0x18000a9a0
18000331b:     	testl	%eax, %eax
18000331d:     	jg	0x18000332c <numba_list_iter_next+0x4ec>
18000331f:     	xorl	%eax, %eax
180003321:     	movq	0x40(%rsp), %rbx
180003326:     	addq	$0x30, %rsp
18000332a:     	popq	%rdi
18000332b:     	retq
18000332c:     	decl	%eax
18000332e:     	movl	%eax, 0x766c(%rip)      # 0x18000a9a0
180003334:     	callq	0x180003610 <numba_list_iter_next+0x7d0>
180003339:     	movb	%al, %bl
18000333b:     	movb	%al, 0x20(%rsp)
18000333f:     	cmpl	$0x2, 0x7682(%rip)      # 0x18000a9c8
180003346:     	jne	0x18000337e <numba_list_iter_next+0x53e>
180003348:     	callq	0x180003738 <numba_list_iter_next+0x8f8>
18000334d:     	callq	0x1800035e0 <numba_list_iter_next+0x7a0>
180003352:     	callq	0x180003978 <numba_list_iter_next+0xb38>
180003357:     	movl	$0x0, 0x7667(%rip)      # 0x18000a9c8
180003361:     	movb	%bl, %cl
180003363:     	callq	0x1800038dc <numba_list_iter_next+0xa9c>
180003368:     	xorl	%edx, %edx
18000336a:     	movb	%dil, %cl
18000336d:     	callq	0x180003900 <numba_list_iter_next+0xac0>
180003372:     	movzbl	%al, %ebx
180003375:     	callq	0x180003768 <numba_list_iter_next+0x928>
18000337a:     	movl	%ebx, %eax
18000337c:     	jmp	0x180003321 <numba_list_iter_next+0x4e1>
18000337e:     	movl	$0x7, %ecx
180003383:     	callq	0x180003934 <numba_list_iter_next+0xaf4>
180003388:     	nop
180003389:     	nop
18000338a:     	int3
18000338b:     	int3
18000338c:     	movq	%rsp, %rax
18000338f:     	movq	%rbx, 0x20(%rax)
180003393:     	movq	%r8, 0x18(%rax)
180003397:     	movl	%edx, 0x10(%rax)
18000339a:     	movq	%rcx, 0x8(%rax)
18000339e:     	pushq	%rsi
18000339f:     	pushq	%rdi
1800033a0:     	pushq	%r14
1800033a2:     	subq	$0x40, %rsp
1800033a6:     	movq	%r8, %rsi
1800033a9:     	movl	%edx, %edi
1800033ab:     	movq	%rcx, %r14
1800033ae:     	testl	%edx, %edx
1800033b0:     	jne	0x1800033c1 <numba_list_iter_next+0x581>
1800033b2:     	cmpl	%edx, 0x75e8(%rip)      # 0x18000a9a0
1800033b8:     	jg	0x1800033c1 <numba_list_iter_next+0x581>
1800033ba:     	xorl	%eax, %eax
1800033bc:     	jmp	0x1800034a6 <numba_list_iter_next+0x666>
1800033c1:     	leal	-0x1(%rdx), %eax
1800033c4:     	cmpl	$0x1, %eax
1800033c7:     	ja	0x180003409 <numba_list_iter_next+0x5c9>
1800033c9:     	movq	0x11f8(%rip), %rax      # 0x1800045c8
1800033d0:     	testq	%rax, %rax
1800033d3:     	jne	0x1800033da <numba_list_iter_next+0x59a>
1800033d5:     	leal	0x1(%rax), %ebx
1800033d8:     	jmp	0x1800033e2 <numba_list_iter_next+0x5a2>
1800033da:     	callq	*0xeb0(%rip)            # 0x180004290
1800033e0:     	movl	%eax, %ebx
1800033e2:     	movl	%ebx, 0x30(%rsp)
1800033e6:     	testl	%ebx, %ebx
1800033e8:     	je	0x18000349c <numba_list_iter_next+0x65c>
1800033ee:     	movq	%rsi, %r8
1800033f1:     	movl	%edi, %edx
1800033f3:     	movq	%r14, %rcx
1800033f6:     	callq	0x1800031a0 <numba_list_iter_next+0x360>
1800033fb:     	movl	%eax, %ebx
1800033fd:     	movl	%eax, 0x30(%rsp)
180003401:     	testl	%eax, %eax
180003403:     	je	0x18000349c <numba_list_iter_next+0x65c>
180003409:     	movq	%rsi, %r8
18000340c:     	movl	%edi, %edx
18000340e:     	movq	%r14, %rcx
180003411:     	callq	0x1800035ac <numba_list_iter_next+0x76c>
180003416:     	movl	%eax, %ebx
180003418:     	movl	%eax, 0x30(%rsp)
18000341c:     	cmpl	$0x1, %edi
18000341f:     	jne	0x180003457 <numba_list_iter_next+0x617>
180003421:     	testl	%eax, %eax
180003423:     	jne	0x180003457 <numba_list_iter_next+0x617>
180003425:     	movq	%rsi, %r8
180003428:     	xorl	%edx, %edx
18000342a:     	movq	%r14, %rcx
18000342d:     	callq	0x1800035ac <numba_list_iter_next+0x76c>
180003432:     	testq	%rsi, %rsi
180003435:     	setne	%cl
180003438:     	callq	0x180003308 <numba_list_iter_next+0x4c8>
18000343d:     	movq	0x1184(%rip), %rax      # 0x1800045c8
180003444:     	testq	%rax, %rax
180003447:     	je	0x180003457 <numba_list_iter_next+0x617>
180003449:     	movq	%rsi, %r8
18000344c:     	xorl	%edx, %edx
18000344e:     	movq	%r14, %rcx
180003451:     	callq	*0xe39(%rip)            # 0x180004290
180003457:     	testl	%edi, %edi
180003459:     	je	0x180003460 <numba_list_iter_next+0x620>
18000345b:     	cmpl	$0x3, %edi
18000345e:     	jne	0x18000349c <numba_list_iter_next+0x65c>
180003460:     	movq	%rsi, %r8
180003463:     	movl	%edi, %edx
180003465:     	movq	%r14, %rcx
180003468:     	callq	0x1800031a0 <numba_list_iter_next+0x360>
18000346d:     	movl	%eax, %ebx
18000346f:     	movl	%eax, 0x30(%rsp)
180003473:     	testl	%eax, %eax
180003475:     	je	0x18000349c <numba_list_iter_next+0x65c>
180003477:     	movq	0x114a(%rip), %rax      # 0x1800045c8
18000347e:     	testq	%rax, %rax
180003481:     	jne	0x180003488 <numba_list_iter_next+0x648>
180003483:     	leal	0x1(%rax), %ebx
180003486:     	jmp	0x180003498 <numba_list_iter_next+0x658>
180003488:     	movq	%rsi, %r8
18000348b:     	movl	%edi, %edx
18000348d:     	movq	%r14, %rcx
180003490:     	callq	*0xdfa(%rip)            # 0x180004290
180003496:     	movl	%eax, %ebx
180003498:     	movl	%ebx, 0x30(%rsp)
18000349c:     	jmp	0x1800034a4 <numba_list_iter_next+0x664>
18000349e:     	xorl	%ebx, %ebx
1800034a0:     	movl	%ebx, 0x30(%rsp)
1800034a4:     	movl	%ebx, %eax
1800034a6:     	movq	0x78(%rsp), %rbx
1800034ab:     	addq	$0x40, %rsp
1800034af:     	popq	%r14
1800034b1:     	popq	%rdi
1800034b2:     	popq	%rsi
1800034b3:     	retq
1800034b4:     	movq	%rbx, 0x8(%rsp)
1800034b9:     	movq	%rsi, 0x10(%rsp)
1800034be:     	pushq	%rdi
1800034bf:     	subq	$0x20, %rsp
1800034c3:     	movq	%r8, %rdi
1800034c6:     	movl	%edx, %ebx
1800034c8:     	movq	%rcx, %rsi
1800034cb:     	cmpl	$0x1, %edx
1800034ce:     	jne	0x1800034d5 <numba_list_iter_next+0x695>
1800034d0:     	callq	0x1800034fc <numba_list_iter_next+0x6bc>
1800034d5:     	movq	%rdi, %r8
1800034d8:     	movl	%ebx, %edx
1800034da:     	movq	%rsi, %rcx
1800034dd:     	movq	0x30(%rsp), %rbx
1800034e2:     	movq	0x38(%rsp), %rsi
1800034e7:     	addq	$0x20, %rsp
1800034eb:     	popq	%rdi
1800034ec:     	jmp	0x18000338c <numba_list_iter_next+0x54c>
1800034f1:     	int3
1800034f2:     	int3
1800034f3:     	int3
1800034f4:     	movl	$0x2, %ecx
1800034f9:     	int	$0x29
1800034fb:     	retq
1800034fc:     	movq	%rbx, 0x18(%rsp)
180003501:     	pushq	%rbp
180003502:     	movq	%rsp, %rbp
180003505:     	subq	$0x30, %rsp
180003509:     	movq	0x6bb0(%rip), %rax      # 0x18000a0c0
180003510:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000351a:     	cmpq	%rbx, %rax
18000351d:     	jne	0x180003596 <numba_list_iter_next+0x756>
18000351f:     	leaq	0x10(%rbp), %rcx
180003523:     	movq	$0x0, 0x10(%rbp)
18000352b:     	callq	*0xaef(%rip)            # 0x180004020
180003531:     	movq	0x10(%rbp), %rax
180003535:     	movq	%rax, -0x10(%rbp)
180003539:     	callq	*0xad9(%rip)            # 0x180004018
18000353f:     	movl	%eax, %eax
180003541:     	xorq	%rax, -0x10(%rbp)
180003545:     	callq	*0xac5(%rip)            # 0x180004010
18000354b:     	movl	%eax, %eax
18000354d:     	leaq	0x18(%rbp), %rcx
180003551:     	xorq	%rax, -0x10(%rbp)
180003555:     	callq	*0xaa5(%rip)            # 0x180004000
18000355b:     	movl	0x18(%rbp), %eax
18000355e:     	leaq	-0x10(%rbp), %rcx
180003562:     	shlq	$0x20, %rax
180003566:     	xorq	0x18(%rbp), %rax
18000356a:     	xorq	-0x10(%rbp), %rax
18000356e:     	xorq	%rcx, %rax
180003571:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000357b:     	andq	%rcx, %rax
18000357e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180003588:     	cmpq	%rbx, %rax
18000358b:     	cmoveq	%rcx, %rax
18000358f:     	movq	%rax, 0x6b2a(%rip)      # 0x18000a0c0
180003596:     	movq	0x50(%rsp), %rbx
18000359b:     	notq	%rax
18000359e:     	movq	%rax, 0x6b5b(%rip)      # 0x18000a100
1800035a5:     	addq	$0x30, %rsp
1800035a9:     	popq	%rbp
1800035aa:     	retq
1800035ab:     	int3
1800035ac:     	subq	$0x28, %rsp
1800035b0:     	cmpl	$0x1, %edx
1800035b3:     	jne	0x1800035c5 <numba_list_iter_next+0x785>
1800035b5:     	cmpq	$0x0, 0x100b(%rip)      # 0x1800045c8
1800035bd:     	jne	0x1800035c5 <numba_list_iter_next+0x785>
1800035bf:     	callq	*0xa63(%rip)            # 0x180004028
1800035c5:     	movl	$0x1, %eax
1800035ca:     	addq	$0x28, %rsp
1800035ce:     	retq
1800035cf:     	int3
1800035d0:     	leaq	0x73d9(%rip), %rcx      # 0x18000a9b0
1800035d7:     	jmpq	*0xa2a(%rip)            # 0x180004008
1800035de:     	int3
1800035df:     	int3
1800035e0:     	leaq	0x73c9(%rip), %rcx      # 0x18000a9b0
1800035e7:     	jmp	0x180003c76 <numba_list_iter_next+0xe36>
1800035ec:     	leaq	0x73cd(%rip), %rax      # 0x18000a9c0
1800035f3:     	retq
1800035f4:     	subq	$0x28, %rsp
1800035f8:     	callq	0x180002750 <PyInit_rcnumeric_2a3c148c01090ea2b4a04532+0x10e0>
1800035fd:     	orq	$0x24, (%rax)
180003601:     	callq	0x1800035ec <numba_list_iter_next+0x7ac>
180003606:     	orq	$0x2, (%rax)
18000360a:     	addq	$0x28, %rsp
18000360e:     	retq
18000360f:     	int3
180003610:     	subq	$0x28, %rsp
180003614:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
180003619:     	testl	%eax, %eax
18000361b:     	je	0x18000363e <numba_list_iter_next+0x7fe>
18000361d:     	movq	%gs:0x30, %rax
180003626:     	movq	0x8(%rax), %rcx
18000362a:     	jmp	0x180003631 <numba_list_iter_next+0x7f1>
18000362c:     	cmpq	%rax, %rcx
18000362f:     	je	0x180003645 <numba_list_iter_next+0x805>
180003631:     	xorl	%eax, %eax
180003633:     	lock
180003634:     	cmpxchgq	%rcx, 0x7394(%rip)      # 0x18000a9d0
18000363c:     	jne	0x18000362c <numba_list_iter_next+0x7ec>
18000363e:     	xorb	%al, %al
180003640:     	addq	$0x28, %rsp
180003644:     	retq
180003645:     	movb	$0x1, %al
180003647:     	jmp	0x180003640 <numba_list_iter_next+0x800>
180003649:     	int3
18000364a:     	int3
18000364b:     	int3
18000364c:     	subq	$0x28, %rsp
180003650:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
180003655:     	testl	%eax, %eax
180003657:     	je	0x180003660 <numba_list_iter_next+0x820>
180003659:     	callq	0x1800039b8 <numba_list_iter_next+0xb78>
18000365e:     	jmp	0x180003679 <numba_list_iter_next+0x839>
180003660:     	callq	0x180003c54 <numba_list_iter_next+0xe14>
180003665:     	movl	%eax, %ecx
180003667:     	callq	0x180003c8e <numba_list_iter_next+0xe4e>
18000366c:     	testl	%eax, %eax
18000366e:     	je	0x180003674 <numba_list_iter_next+0x834>
180003670:     	xorb	%al, %al
180003672:     	jmp	0x18000367b <numba_list_iter_next+0x83b>
180003674:     	callq	0x180003c94 <numba_list_iter_next+0xe54>
180003679:     	movb	$0x1, %al
18000367b:     	addq	$0x28, %rsp
18000367f:     	retq
180003680:     	subq	$0x28, %rsp
180003684:     	xorl	%ecx, %ecx
180003686:     	callq	0x1800037b8 <numba_list_iter_next+0x978>
18000368b:     	testb	%al, %al
18000368d:     	setne	%al
180003690:     	addq	$0x28, %rsp
180003694:     	retq
180003695:     	int3
180003696:     	int3
180003697:     	int3
180003698:     	subq	$0x28, %rsp
18000369c:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800036a1:     	testb	%al, %al
1800036a3:     	jne	0x1800036a9 <numba_list_iter_next+0x869>
1800036a5:     	xorb	%al, %al
1800036a7:     	jmp	0x1800036bb <numba_list_iter_next+0x87b>
1800036a9:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800036ae:     	testb	%al, %al
1800036b0:     	jne	0x1800036b9 <numba_list_iter_next+0x879>
1800036b2:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800036b7:     	jmp	0x1800036a5 <numba_list_iter_next+0x865>
1800036b9:     	movb	$0x1, %al
1800036bb:     	addq	$0x28, %rsp
1800036bf:     	retq
1800036c0:     	subq	$0x28, %rsp
1800036c4:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800036c9:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800036ce:     	movb	$0x1, %al
1800036d0:     	addq	$0x28, %rsp
1800036d4:     	retq
1800036d5:     	int3
1800036d6:     	int3
1800036d7:     	int3
1800036d8:     	movq	%rbx, 0x8(%rsp)
1800036dd:     	movq	%rbp, 0x10(%rsp)
1800036e2:     	movq	%rsi, 0x18(%rsp)
1800036e7:     	pushq	%rdi
1800036e8:     	subq	$0x20, %rsp
1800036ec:     	movq	%r9, %rdi
1800036ef:     	movq	%r8, %rsi
1800036f2:     	movl	%edx, %ebx
1800036f4:     	movq	%rcx, %rbp
1800036f7:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
1800036fc:     	testl	%eax, %eax
1800036fe:     	jne	0x180003716 <numba_list_iter_next+0x8d6>
180003700:     	cmpl	$0x1, %ebx
180003703:     	jne	0x180003716 <numba_list_iter_next+0x8d6>
180003705:     	movq	%rsi, %r8
180003708:     	xorl	%edx, %edx
18000370a:     	movq	%rbp, %rcx
18000370d:     	movq	%rdi, %rax
180003710:     	callq	*0xb7a(%rip)            # 0x180004290
180003716:     	movq	0x58(%rsp), %rdx
18000371b:     	movl	0x50(%rsp), %ecx
18000371f:     	movq	0x30(%rsp), %rbx
180003724:     	movq	0x38(%rsp), %rbp
180003729:     	movq	0x40(%rsp), %rsi
18000372e:     	addq	$0x20, %rsp
180003732:     	popq	%rdi
180003733:     	jmp	0x180003c88 <numba_list_iter_next+0xe48>
180003738:     	subq	$0x28, %rsp
18000373c:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
180003741:     	testl	%eax, %eax
180003743:     	je	0x180003755 <numba_list_iter_next+0x915>
180003745:     	leaq	0x7294(%rip), %rcx      # 0x18000a9e0
18000374c:     	addq	$0x28, %rsp
180003750:     	jmp	0x180003ca0 <numba_list_iter_next+0xe60>
180003755:     	callq	0x180003cb0 <numba_list_iter_next+0xe70>
18000375a:     	testl	%eax, %eax
18000375c:     	jne	0x180003763 <numba_list_iter_next+0x923>
18000375e:     	callq	0x180003ca6 <numba_list_iter_next+0xe66>
180003763:     	addq	$0x28, %rsp
180003767:     	retq
180003768:     	subq	$0x28, %rsp
18000376c:     	xorl	%ecx, %ecx
18000376e:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
180003773:     	addq	$0x28, %rsp
180003777:     	jmp	0x180003cac <numba_list_iter_next+0xe6c>
18000377c:     	subq	$0x28, %rsp
180003780:     	testl	%ecx, %ecx
180003782:     	jne	0x18000378b <numba_list_iter_next+0x94b>
180003784:     	movb	$0x1, 0x724d(%rip)      # 0x18000a9d8
18000378b:     	callq	0x1800039b8 <numba_list_iter_next+0xb78>
180003790:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
180003795:     	testb	%al, %al
180003797:     	jne	0x18000379d <numba_list_iter_next+0x95d>
180003799:     	xorb	%al, %al
18000379b:     	jmp	0x1800037b1 <numba_list_iter_next+0x971>
18000379d:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800037a2:     	testb	%al, %al
1800037a4:     	jne	0x1800037af <numba_list_iter_next+0x96f>
1800037a6:     	xorl	%ecx, %ecx
1800037a8:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
1800037ad:     	jmp	0x180003799 <numba_list_iter_next+0x959>
1800037af:     	movb	$0x1, %al
1800037b1:     	addq	$0x28, %rsp
1800037b5:     	retq
1800037b6:     	int3
1800037b7:     	int3
1800037b8:     	pushq	%rbx
1800037ba:     	subq	$0x20, %rsp
1800037be:     	cmpb	$0x0, 0x7214(%rip)      # 0x18000a9d9
1800037c5:     	movl	%ecx, %ebx
1800037c7:     	jne	0x180003830 <numba_list_iter_next+0x9f0>
1800037c9:     	cmpl	$0x1, %ecx
1800037cc:     	ja	0x180003838 <numba_list_iter_next+0x9f8>
1800037ce:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
1800037d3:     	testl	%eax, %eax
1800037d5:     	je	0x1800037ff <numba_list_iter_next+0x9bf>
1800037d7:     	testl	%ebx, %ebx
1800037d9:     	jne	0x1800037ff <numba_list_iter_next+0x9bf>
1800037db:     	leaq	0x71fe(%rip), %rcx      # 0x18000a9e0
1800037e2:     	callq	0x180003c9a <numba_list_iter_next+0xe5a>
1800037e7:     	testl	%eax, %eax
1800037e9:     	jne	0x1800037fb <numba_list_iter_next+0x9bb>
1800037eb:     	leaq	0x7206(%rip), %rcx      # 0x18000a9f8
1800037f2:     	callq	0x180003c9a <numba_list_iter_next+0xe5a>
1800037f7:     	testl	%eax, %eax
1800037f9:     	je	0x180003829 <numba_list_iter_next+0x9e9>
1800037fb:     	xorb	%al, %al
1800037fd:     	jmp	0x180003832 <numba_list_iter_next+0x9f2>
1800037ff:     	movdqa	0xdc9(%rip), %xmm0      # 0x1800045d0
180003807:     	orq	$-0x1, %rax
18000380b:     	movdqu	%xmm0, 0x71cd(%rip)     # 0x18000a9e0
180003813:     	movq	%rax, 0x71d6(%rip)      # 0x18000a9f0
18000381a:     	movdqu	%xmm0, 0x71d6(%rip)     # 0x18000a9f8
180003822:     	movq	%rax, 0x71df(%rip)      # 0x18000aa08
180003829:     	movb	$0x1, 0x71a9(%rip)      # 0x18000a9d9
180003830:     	movb	$0x1, %al
180003832:     	addq	$0x20, %rsp
180003836:     	popq	%rbx
180003837:     	retq
180003838:     	movl	$0x5, %ecx
18000383d:     	callq	0x180003934 <numba_list_iter_next+0xaf4>
180003842:     	int3
180003843:     	int3
180003844:     	subq	$0x18, %rsp
180003848:     	movq	%rcx, %r8
18000384b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003850:     	cmpw	%ax, -0x3857(%rip)      # 0x180000000
180003857:     	jne	0x1800038d1 <numba_list_iter_next+0xa91>
180003859:     	movslq	-0x3824(%rip), %rcx     # 0x18000003c
180003860:     	leaq	-0x3867(%rip), %rdx     # 0x180000000
180003867:     	addq	%rdx, %rcx
18000386a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003870:     	jne	0x1800038d1 <numba_list_iter_next+0xa91>
180003872:     	movl	$0x20b, %eax            # imm = 0x20B
180003877:     	cmpw	%ax, 0x18(%rcx)
18000387b:     	jne	0x1800038d1 <numba_list_iter_next+0xa91>
18000387d:     	subq	%rdx, %r8
180003880:     	movzwl	0x14(%rcx), %edx
180003884:     	addq	$0x18, %rdx
180003888:     	addq	%rcx, %rdx
18000388b:     	movzwl	0x6(%rcx), %eax
18000388f:     	leaq	(%rax,%rax,4), %rcx
180003893:     	leaq	(%rdx,%rcx,8), %r9
180003897:     	movq	%rdx, (%rsp)
18000389b:     	cmpq	%r9, %rdx
18000389e:     	je	0x1800038b8 <numba_list_iter_next+0xa78>
1800038a0:     	movl	0xc(%rdx), %ecx
1800038a3:     	cmpq	%rcx, %r8
1800038a6:     	jb	0x1800038b2 <numba_list_iter_next+0xa72>
1800038a8:     	movl	0x8(%rdx), %eax
1800038ab:     	addl	%ecx, %eax
1800038ad:     	cmpq	%rax, %r8
1800038b0:     	jb	0x1800038ba <numba_list_iter_next+0xa7a>
1800038b2:     	addq	$0x28, %rdx
1800038b6:     	jmp	0x180003897 <numba_list_iter_next+0xa57>
1800038b8:     	xorl	%edx, %edx
1800038ba:     	testq	%rdx, %rdx
1800038bd:     	jne	0x1800038c3 <numba_list_iter_next+0xa83>
1800038bf:     	xorb	%al, %al
1800038c1:     	jmp	0x1800038d7 <numba_list_iter_next+0xa97>
1800038c3:     	cmpl	$0x0, 0x24(%rdx)
1800038c7:     	jge	0x1800038cd <numba_list_iter_next+0xa8d>
1800038c9:     	xorb	%al, %al
1800038cb:     	jmp	0x1800038d7 <numba_list_iter_next+0xa97>
1800038cd:     	movb	$0x1, %al
1800038cf:     	jmp	0x1800038d7 <numba_list_iter_next+0xa97>
1800038d1:     	xorb	%al, %al
1800038d3:     	jmp	0x1800038d7 <numba_list_iter_next+0xa97>
1800038d5:     	xorb	%al, %al
1800038d7:     	addq	$0x18, %rsp
1800038db:     	retq
1800038dc:     	pushq	%rbx
1800038de:     	subq	$0x20, %rsp
1800038e2:     	movb	%cl, %bl
1800038e4:     	callq	0x180003c5c <numba_list_iter_next+0xe1c>
1800038e9:     	xorl	%edx, %edx
1800038eb:     	testl	%eax, %eax
1800038ed:     	je	0x1800038fa <numba_list_iter_next+0xaba>
1800038ef:     	testb	%bl, %bl
1800038f1:     	jne	0x1800038fa <numba_list_iter_next+0xaba>
1800038f3:     	xchgq	%rdx, 0x70d6(%rip)      # 0x18000a9d0
1800038fa:     	addq	$0x20, %rsp
1800038fe:     	popq	%rbx
1800038ff:     	retq
180003900:     	pushq	%rbx
180003902:     	subq	$0x20, %rsp
180003906:     	cmpb	$0x0, 0x70cb(%rip)      # 0x18000a9d8
18000390d:     	movb	%cl, %bl
18000390f:     	je	0x180003915 <numba_list_iter_next+0xad5>
180003911:     	testb	%dl, %dl
180003913:     	jne	0x180003921 <numba_list_iter_next+0xae1>
180003915:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
18000391a:     	movb	%bl, %cl
18000391c:     	callq	0x180003cac <numba_list_iter_next+0xe6c>
180003921:     	movb	$0x1, %al
180003923:     	addq	$0x20, %rsp
180003927:     	popq	%rbx
180003928:     	retq
180003929:     	int3
18000392a:     	int3
18000392b:     	int3
18000392c:     	leaq	0x7335(%rip), %rax      # 0x18000ac68
180003933:     	retq
180003934:     	movl	%ecx, %ecx
180003936:     	int	$0x29
180003938:     	retq
180003939:     	int3
18000393a:     	int3
18000393b:     	int3
18000393c:     	movq	%rbx, 0x8(%rsp)
180003941:     	pushq	%rdi
180003942:     	subq	$0x20, %rsp
180003946:     	leaq	0x35f3(%rip), %rbx      # 0x180006f40
18000394d:     	leaq	0x35ec(%rip), %rdi      # 0x180006f40
180003954:     	jmp	0x180003968 <numba_list_iter_next+0xb28>
180003956:     	movq	(%rbx), %rax
180003959:     	testq	%rax, %rax
18000395c:     	je	0x180003964 <numba_list_iter_next+0xb24>
18000395e:     	callq	*0x92c(%rip)            # 0x180004290
180003964:     	addq	$0x8, %rbx
180003968:     	cmpq	%rdi, %rbx
18000396b:     	jb	0x180003956 <numba_list_iter_next+0xb16>
18000396d:     	movq	0x30(%rsp), %rbx
180003972:     	addq	$0x20, %rsp
180003976:     	popq	%rdi
180003977:     	retq
180003978:     	movq	%rbx, 0x8(%rsp)
18000397d:     	pushq	%rdi
18000397e:     	subq	$0x20, %rsp
180003982:     	leaq	0x35c7(%rip), %rbx      # 0x180006f50
180003989:     	leaq	0x35c0(%rip), %rdi      # 0x180006f50
180003990:     	jmp	0x1800039a4 <numba_list_iter_next+0xb64>
180003992:     	movq	(%rbx), %rax
180003995:     	testq	%rax, %rax
180003998:     	je	0x1800039a0 <numba_list_iter_next+0xb60>
18000399a:     	callq	*0x8f0(%rip)            # 0x180004290
1800039a0:     	addq	$0x8, %rbx
1800039a4:     	cmpq	%rdi, %rbx
1800039a7:     	jb	0x180003992 <numba_list_iter_next+0xb52>
1800039a9:     	movq	0x30(%rsp), %rbx
1800039ae:     	addq	$0x20, %rsp
1800039b2:     	popq	%rdi
1800039b3:     	retq
1800039b4:     	retq	$0x0
1800039b7:     	int3
1800039b8:     	movq	%rbx, 0x10(%rsp)
1800039bd:     	movq	%rbp, 0x18(%rsp)
1800039c2:     	movq	%rsi, 0x20(%rsp)
1800039c7:     	pushq	%rdi
1800039c8:     	subq	$0x10, %rsp
1800039cc:     	xorl	%eax, %eax
1800039ce:     	xorl	%ecx, %ecx
1800039d0:     	cpuid
1800039d2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
1800039d8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
1800039de:     	orl	%ecx, %edx
1800039e0:     	movl	%eax, %ebp
1800039e2:     	movl	$0x1, %eax
1800039e7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
1800039ed:     	orl	%ebx, %edx
1800039ef:     	leal	-0x1(%rax), %ecx
1800039f2:     	cpuid
1800039f4:     	movl	%ecx, %edi
1800039f6:     	jne	0x180003a56 <numba_list_iter_next+0xc16>
1800039f8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
1800039fd:     	movq	$0x8000, 0x6710(%rip)   # imm = 0x8000
                                                # 0x18000a118
180003a08:     	movq	$-0x1, 0x670d(%rip)     # 0x18000a120
180003a13:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180003a18:     	je	0x180003a42 <numba_list_iter_next+0xc02>
180003a1a:     	cmpl	$0x20660, %eax          # imm = 0x20660
180003a1f:     	je	0x180003a42 <numba_list_iter_next+0xc02>
180003a21:     	cmpl	$0x20670, %eax          # imm = 0x20670
180003a26:     	je	0x180003a42 <numba_list_iter_next+0xc02>
180003a28:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180003a2d:     	cmpl	$0x20, %eax
180003a30:     	ja	0x180003a56 <numba_list_iter_next+0xc16>
180003a32:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180003a3c:     	btq	%rax, %rcx
180003a40:     	jae	0x180003a56 <numba_list_iter_next+0xc16>
180003a42:     	movl	0x6fcb(%rip), %r8d      # 0x18000aa14
180003a49:     	orl	$0x1, %r8d
180003a4d:     	movl	%r8d, 0x6fc0(%rip)      # 0x18000aa14
180003a54:     	jmp	0x180003a5d <numba_list_iter_next+0xc1d>
180003a56:     	movl	0x6fb7(%rip), %r8d      # 0x18000aa14
180003a5d:     	xorl	%r9d, %r9d
180003a60:     	movl	%r9d, %r11d
180003a63:     	cmpl	$0x7, %ebp
180003a66:     	jl	0x180003aaa <numba_list_iter_next+0xc6a>
180003a68:     	xorl	%ecx, %ecx
180003a6a:     	leal	0x7(%r9), %eax
180003a6e:     	cpuid
180003a70:     	movl	%edx, %esi
180003a72:     	movl	%ebx, %r10d
180003a75:     	btl	$0x9, %ebx
180003a79:     	jae	0x180003a86 <numba_list_iter_next+0xc46>
180003a7b:     	orl	$0x2, %r8d
180003a7f:     	movl	%r8d, 0x6f8e(%rip)      # 0x18000aa14
180003a86:     	cmpl	$0x1, %eax
180003a89:     	jl	0x180003a98 <numba_list_iter_next+0xc58>
180003a8b:     	movl	$0x7, %eax
180003a90:     	leal	-0x6(%rax), %ecx
180003a93:     	cpuid
180003a95:     	movl	%edx, %r9d
180003a98:     	movl	$0x24, %eax
180003a9d:     	cmpl	%eax, %ebp
180003a9f:     	jl	0x180003ab0 <numba_list_iter_next+0xc70>
180003aa1:     	xorl	%ecx, %ecx
180003aa3:     	cpuid
180003aa5:     	movl	%ebx, %r11d
180003aa8:     	jmp	0x180003ab0 <numba_list_iter_next+0xc70>
180003aaa:     	movl	%r9d, %r10d
180003aad:     	movl	%r9d, %esi
180003ab0:     	movq	0x6671(%rip), %rax      # 0x18000a128
180003ab7:     	andq	$-0x2, %rax
180003abb:     	movl	$0x1, 0x664b(%rip)      # 0x18000a110
180003ac5:     	movl	$0x2, 0x6645(%rip)      # 0x18000a114
180003acf:     	movq	%rax, 0x6652(%rip)      # 0x18000a128
180003ad6:     	btl	$0x14, %edi
180003ada:     	jae	0x180003afb <numba_list_iter_next+0xcbb>
180003adc:     	andq	$-0x11, %rax
180003ae0:     	movl	$0x2, 0x6626(%rip)      # 0x18000a110
180003aea:     	movq	%rax, 0x6637(%rip)      # 0x18000a128
180003af1:     	movl	$0x6, 0x6619(%rip)      # 0x18000a114
180003afb:     	btl	$0x1b, %edi
180003aff:     	jae	0x180003c3c <numba_list_iter_next+0xdfc>
180003b05:     	xorl	%ecx, %ecx
180003b07:     	xgetbv
180003b0a:     	shlq	$0x20, %rdx
180003b0e:     	orq	%rax, %rdx
180003b11:     	movq	%rdx, 0x20(%rsp)
180003b16:     	btl	$0x1c, %edi
180003b1a:     	jae	0x180003c20 <numba_list_iter_next+0xde0>
180003b20:     	movq	0x20(%rsp), %rax
180003b25:     	andb	$0x6, %al
180003b27:     	cmpb	$0x6, %al
180003b29:     	jne	0x180003c20 <numba_list_iter_next+0xde0>
180003b2f:     	movl	0x65df(%rip), %eax      # 0x18000a114
180003b35:     	movb	$-0x20, %dl
180003b37:     	orl	$0x8, %eax
180003b3a:     	movl	$0x3, 0x65cc(%rip)      # 0x18000a110
180003b44:     	movl	%eax, 0x65ca(%rip)      # 0x18000a114
180003b4a:     	testb	$0x20, %r10b
180003b4e:     	je	0x180003bb2 <numba_list_iter_next+0xd72>
180003b50:     	orl	$0x20, %eax
180003b53:     	movl	$0x5, 0x65b3(%rip)      # 0x18000a110
180003b5d:     	movl	%eax, 0x65b1(%rip)      # 0x18000a114
180003b63:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003b68:     	movq	0x65b9(%rip), %rax      # 0x18000a128
180003b6f:     	andl	%ecx, %r10d
180003b72:     	andq	$-0x3, %rax
180003b76:     	movq	%rax, 0x65ab(%rip)      # 0x18000a128
180003b7d:     	cmpl	%ecx, %r10d
180003b80:     	jne	0x180003bb9 <numba_list_iter_next+0xd79>
180003b82:     	movq	0x20(%rsp), %rax
180003b87:     	andb	%dl, %al
180003b89:     	cmpb	%dl, %al
180003b8b:     	jne	0x180003bb2 <numba_list_iter_next+0xd72>
180003b8d:     	movq	0x6594(%rip), %rax      # 0x18000a128
180003b94:     	orl	$0x40, 0x6579(%rip)     # 0x18000a114
180003b9b:     	andq	$-0x25, %rax
180003b9f:     	movl	$0x6, 0x6567(%rip)      # 0x18000a110
180003ba9:     	movq	%rax, 0x6578(%rip)      # 0x18000a128
180003bb0:     	jmp	0x180003bb9 <numba_list_iter_next+0xd79>
180003bb2:     	movq	0x656f(%rip), %rax      # 0x18000a128
180003bb9:     	btl	$0x17, %esi
180003bbd:     	jae	0x180003bcb <numba_list_iter_next+0xd8b>
180003bbf:     	btrq	$0x18, %rax
180003bc4:     	movq	%rax, 0x655d(%rip)      # 0x18000a128
180003bcb:     	btl	$0x13, %r9d
180003bd0:     	jae	0x180003c20 <numba_list_iter_next+0xde0>
180003bd2:     	movq	0x20(%rsp), %rax
180003bd7:     	andb	%dl, %al
180003bd9:     	cmpb	%dl, %al
180003bdb:     	jne	0x180003c20 <numba_list_iter_next+0xde0>
180003bdd:     	movq	0x6544(%rip), %rdx      # 0x18000a128
180003be4:     	movl	%r11d, %eax
180003be7:     	shrq	$0x10, %rax
180003beb:     	movl	%r11d, %ecx
180003bee:     	andl	$0x6, %eax
180003bf1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003bf7:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003bfd:     	movl	%ecx, 0x6e15(%rip)      # 0x18000aa18
180003c03:     	notq	%rax
180003c06:     	andq	%rax, %rdx
180003c09:     	movq	%rdx, 0x6518(%rip)      # 0x18000a128
180003c10:     	cmpb	$0x1, %cl
180003c13:     	jbe	0x180003c20 <numba_list_iter_next+0xde0>
180003c15:     	andq	$-0x41, %rdx
180003c19:     	movq	%rdx, 0x6508(%rip)      # 0x18000a128
180003c20:     	btl	$0x15, %r9d
180003c25:     	jae	0x180003c3c <numba_list_iter_next+0xdfc>
180003c27:     	movq	0x20(%rsp), %rax
180003c2c:     	btq	$0x13, %rax
180003c31:     	jae	0x180003c3c <numba_list_iter_next+0xdfc>
180003c33:     	btrq	$0x7, 0x64ec(%rip)      # 0x18000a128
180003c3c:     	movq	0x28(%rsp), %rbx
180003c41:     	xorl	%eax, %eax
180003c43:     	movq	0x30(%rsp), %rbp
180003c48:     	movq	0x38(%rsp), %rsi
180003c4d:     	addq	$0x10, %rsp
180003c51:     	popq	%rdi
180003c52:     	retq
180003c53:     	int3
180003c54:     	movl	$0x1, %eax
180003c59:     	retq
180003c5a:     	int3
180003c5b:     	int3
180003c5c:     	xorl	%eax, %eax
180003c5e:     	cmpl	%eax, 0x64cc(%rip)      # 0x18000a130
180003c64:     	setne	%al
180003c67:     	retq
180003c68:     	int3
180003c69:     	int3
180003c6a:     	int3
180003c6b:     	int3
180003c6c:     	int3
180003c6d:     	int3
180003c6e:     	int3
180003c6f:     	int3
180003c70:     	jmpq	*0x3d2(%rip)            # 0x180004048
180003c76:     	jmpq	*0x3d4(%rip)            # 0x180004050
180003c7c:     	jmpq	*0x40e(%rip)            # 0x180004090
180003c82:     	jmpq	*0x410(%rip)            # 0x180004098
180003c88:     	jmpq	*0x412(%rip)            # 0x1800040a0
180003c8e:     	jmpq	*0x414(%rip)            # 0x1800040a8
180003c94:     	jmpq	*0x416(%rip)            # 0x1800040b0
180003c9a:     	jmpq	*0x3e0(%rip)            # 0x180004080
180003ca0:     	jmpq	*0x412(%rip)            # 0x1800040b8
180003ca6:     	jmpq	*0x3dc(%rip)            # 0x180004088
180003cac:     	movb	$0x1, %al
180003cae:     	retq
180003caf:     	int3
180003cb0:     	xorl	%eax, %eax
180003cb2:     	retq
180003cb3:     	jmpq	*0x37f(%rip)            # 0x180004038
180003cb9:     	jmpq	*0x381(%rip)            # 0x180004040
180003cbf:     	jmpq	*0x403(%rip)            # 0x1800040c8
180003cc5:     	jmpq	*0x405(%rip)            # 0x1800040d0
180003ccb:     	int3
180003ccc:     	int3
180003ccd:     	int3
180003cce:     	int3
180003ccf:     	int3
180003cd0:     	int3
180003cd1:     	int3
180003cd2:     	int3
180003cd3:     	int3
180003cd4:     	int3
180003cd5:     	int3
180003cd6:     	nopw	(%rax,%rax)
180003ce0:     	jmpq	*%rax
180003ce2:     	int3
180003ce3:     	int3
180003ce4:     	int3
180003ce5:     	int3
180003ce6:     	int3
180003ce7:     	int3
180003ce8:     	int3
180003ce9:     	int3
180003cea:     	int3
180003ceb:     	int3
180003cec:     	int3
180003ced:     	int3
180003cee:     	int3
180003cef:     	int3
180003cf0:     	int3
180003cf1:     	int3
180003cf2:     	int3
180003cf3:     	int3
180003cf4:     	int3
180003cf5:     	int3
180003cf6:     	nopw	(%rax,%rax)
180003d00:     	jmpq	*0x58a(%rip)            # 0x180004290
180003d06:     	pushq	%rbp
180003d08:     	subq	$0x20, %rsp
180003d0c:     	movq	%rdx, %rbp
180003d0f:     	movb	0x40(%rbp), %cl
180003d12:     	addq	$0x20, %rsp
180003d16:     	popq	%rbp
180003d17:     	jmp	0x1800038dc <numba_list_iter_next+0xa9c>
180003d1c:     	int3
180003d1d:     	pushq	%rbp
180003d1f:     	subq	$0x20, %rsp
180003d23:     	movq	%rdx, %rbp
180003d26:     	movb	0x20(%rbp), %cl
180003d29:     	callq	0x1800038dc <numba_list_iter_next+0xa9c>
180003d2e:     	nop
180003d2f:     	addq	$0x20, %rsp
180003d33:     	popq	%rbp
180003d34:     	retq
180003d35:     	int3
180003d36:     	pushq	%rbp
180003d38:     	subq	$0x20, %rsp
180003d3c:     	movq	%rdx, %rbp
180003d3f:     	addq	$0x20, %rsp
180003d43:     	popq	%rbp
180003d44:     	jmp	0x180003768 <numba_list_iter_next+0x928>
180003d49:     	int3
180003d4a:     	pushq	%rbp
180003d4c:     	subq	$0x30, %rsp
180003d50:     	movq	%rdx, %rbp
180003d53:     	movq	(%rcx), %rax
180003d56:     	movl	(%rax), %edx
180003d58:     	movq	%rcx, 0x28(%rsp)
180003d5d:     	movl	%edx, 0x20(%rsp)
180003d61:     	leaq	-0xbc8(%rip), %r9       # 0x1800031a0 <numba_list_iter_next+0x360>
180003d68:     	movq	0x70(%rbp), %r8
180003d6c:     	movl	0x68(%rbp), %edx
180003d6f:     	movq	0x60(%rbp), %rcx
180003d73:     	callq	0x1800036d8 <numba_list_iter_next+0x898>
180003d78:     	nop
180003d79:     	addq	$0x30, %rsp
180003d7d:     	popq	%rbp
180003d7e:     	retq
180003d7f:     	int3
180003d80:     	pushq	%rbp
180003d82:     	movq	%rdx, %rbp
180003d85:     	movq	(%rcx), %rax
180003d88:     	xorl	%ecx, %ecx
180003d8a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003d90:     	sete	%cl
180003d93:     	movl	%ecx, %eax
180003d95:     	popq	%rbp
180003d96:     	retq
180003d97:     	int3
