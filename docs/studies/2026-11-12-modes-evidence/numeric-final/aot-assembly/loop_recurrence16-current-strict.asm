
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-binding-final\aot\current-strict\loop_recurrence16\rcaotr_0cedc59f0901480dc0803d7c.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180003220 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x4339(%rip), %rax      # 0x1800053c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	pushq	%rsi
180001091:     	movq	0x30(%rsp), %rax
180001096:     	movq	0x38(%rsp), %r10
18000109b:     	xorl	%r11d, %r11d
18000109e:     	testq	%r10, %r10
1800010a1:     	cmovleq	%r11, %r10
1800010a5:     	cvtsi2sd	%r9, %xmm0
1800010aa:     	incq	%r10
1800010ad:     	movapd	0x425b(%rip), %xmm1     # 0x180005310
1800010b5:     	movsd	0x4263(%rip), %xmm2     # 0x180005320
1800010bd:     	decq	%r10
1800010c0:     	testq	%r10, %r10
1800010c3:     	jle	0x180001404 <.text+0x404>
1800010c9:     	xorps	%xmm3, %xmm3
1800010cc:     	cvtsi2sd	%r8, %xmm3
1800010d1:     	mulsd	%xmm0, %xmm3
1800010d5:     	andpd	%xmm1, %xmm3
1800010d9:     	ucomisd	%xmm2, %xmm3
1800010dd:     	jae	0x1800013fe <.text+0x3fe>
1800010e3:     	cmpb	$0x0, (%rdx)
1800010e6:     	jne	0x180001401 <.text+0x401>
1800010ec:     	imulq	%r9, %r8
1800010f0:     	leaq	(%r8,%rax), %r11
1800010f4:     	xorq	%r11, %r8
1800010f7:     	movq	%r11, %rsi
1800010fa:     	xorq	%rax, %rsi
1800010fd:     	testq	%rsi, %r8
180001100:     	js	0x1800013fe <.text+0x3fe>
180001106:     	xorps	%xmm3, %xmm3
180001109:     	cvtsi2sd	%r11, %xmm3
18000110e:     	mulsd	%xmm0, %xmm3
180001112:     	andpd	%xmm1, %xmm3
180001116:     	ucomisd	%xmm2, %xmm3
18000111a:     	jae	0x1800013fe <.text+0x3fe>
180001120:     	imulq	%r9, %r11
180001124:     	leaq	(%r11,%rax), %r8
180001128:     	xorq	%r8, %r11
18000112b:     	movq	%r8, %rsi
18000112e:     	xorq	%rax, %rsi
180001131:     	testq	%rsi, %r11
180001134:     	js	0x1800013fe <.text+0x3fe>
18000113a:     	xorps	%xmm3, %xmm3
18000113d:     	cvtsi2sd	%r8, %xmm3
180001142:     	mulsd	%xmm0, %xmm3
180001146:     	andpd	%xmm1, %xmm3
18000114a:     	ucomisd	%xmm2, %xmm3
18000114e:     	jae	0x1800013fe <.text+0x3fe>
180001154:     	imulq	%r9, %r8
180001158:     	leaq	(%r8,%rax), %r11
18000115c:     	xorq	%r11, %r8
18000115f:     	movq	%r11, %rsi
180001162:     	xorq	%rax, %rsi
180001165:     	testq	%rsi, %r8
180001168:     	js	0x1800013fe <.text+0x3fe>
18000116e:     	xorps	%xmm3, %xmm3
180001171:     	cvtsi2sd	%r11, %xmm3
180001176:     	mulsd	%xmm0, %xmm3
18000117a:     	andpd	%xmm1, %xmm3
18000117e:     	ucomisd	%xmm2, %xmm3
180001182:     	jae	0x1800013fe <.text+0x3fe>
180001188:     	imulq	%r9, %r11
18000118c:     	leaq	(%r11,%rax), %r8
180001190:     	xorq	%r8, %r11
180001193:     	movq	%r8, %rsi
180001196:     	xorq	%rax, %rsi
180001199:     	testq	%rsi, %r11
18000119c:     	js	0x1800013fe <.text+0x3fe>
1800011a2:     	xorps	%xmm3, %xmm3
1800011a5:     	cvtsi2sd	%r8, %xmm3
1800011aa:     	mulsd	%xmm0, %xmm3
1800011ae:     	andpd	%xmm1, %xmm3
1800011b2:     	ucomisd	%xmm2, %xmm3
1800011b6:     	jae	0x1800013fe <.text+0x3fe>
1800011bc:     	imulq	%r9, %r8
1800011c0:     	leaq	(%r8,%rax), %r11
1800011c4:     	xorq	%r11, %r8
1800011c7:     	movq	%r11, %rsi
1800011ca:     	xorq	%rax, %rsi
1800011cd:     	testq	%rsi, %r8
1800011d0:     	js	0x1800013fe <.text+0x3fe>
1800011d6:     	xorps	%xmm3, %xmm3
1800011d9:     	cvtsi2sd	%r11, %xmm3
1800011de:     	mulsd	%xmm0, %xmm3
1800011e2:     	andpd	%xmm1, %xmm3
1800011e6:     	ucomisd	%xmm2, %xmm3
1800011ea:     	jae	0x1800013fe <.text+0x3fe>
1800011f0:     	imulq	%r9, %r11
1800011f4:     	leaq	(%r11,%rax), %r8
1800011f8:     	xorq	%r8, %r11
1800011fb:     	movq	%r8, %rsi
1800011fe:     	xorq	%rax, %rsi
180001201:     	testq	%rsi, %r11
180001204:     	js	0x1800013fe <.text+0x3fe>
18000120a:     	xorps	%xmm3, %xmm3
18000120d:     	cvtsi2sd	%r8, %xmm3
180001212:     	mulsd	%xmm0, %xmm3
180001216:     	andpd	%xmm1, %xmm3
18000121a:     	ucomisd	%xmm2, %xmm3
18000121e:     	jae	0x1800013fe <.text+0x3fe>
180001224:     	imulq	%r9, %r8
180001228:     	leaq	(%r8,%rax), %r11
18000122c:     	xorq	%r11, %r8
18000122f:     	movq	%r11, %rsi
180001232:     	xorq	%rax, %rsi
180001235:     	testq	%rsi, %r8
180001238:     	js	0x1800013fe <.text+0x3fe>
18000123e:     	xorps	%xmm3, %xmm3
180001241:     	cvtsi2sd	%r11, %xmm3
180001246:     	mulsd	%xmm0, %xmm3
18000124a:     	andpd	%xmm1, %xmm3
18000124e:     	ucomisd	%xmm2, %xmm3
180001252:     	jae	0x1800013fe <.text+0x3fe>
180001258:     	imulq	%r9, %r11
18000125c:     	leaq	(%r11,%rax), %r8
180001260:     	xorq	%r8, %r11
180001263:     	movq	%r8, %rsi
180001266:     	xorq	%rax, %rsi
180001269:     	testq	%rsi, %r11
18000126c:     	js	0x1800013fe <.text+0x3fe>
180001272:     	xorps	%xmm3, %xmm3
180001275:     	cvtsi2sd	%r8, %xmm3
18000127a:     	mulsd	%xmm0, %xmm3
18000127e:     	andpd	%xmm1, %xmm3
180001282:     	ucomisd	%xmm2, %xmm3
180001286:     	jae	0x1800013fe <.text+0x3fe>
18000128c:     	imulq	%r9, %r8
180001290:     	leaq	(%r8,%rax), %r11
180001294:     	xorq	%r11, %r8
180001297:     	movq	%r11, %rsi
18000129a:     	xorq	%rax, %rsi
18000129d:     	testq	%rsi, %r8
1800012a0:     	js	0x1800013fe <.text+0x3fe>
1800012a6:     	xorps	%xmm3, %xmm3
1800012a9:     	cvtsi2sd	%r11, %xmm3
1800012ae:     	mulsd	%xmm0, %xmm3
1800012b2:     	andpd	%xmm1, %xmm3
1800012b6:     	ucomisd	%xmm2, %xmm3
1800012ba:     	jae	0x1800013fe <.text+0x3fe>
1800012c0:     	imulq	%r9, %r11
1800012c4:     	leaq	(%r11,%rax), %r8
1800012c8:     	xorq	%r8, %r11
1800012cb:     	movq	%r8, %rsi
1800012ce:     	xorq	%rax, %rsi
1800012d1:     	testq	%rsi, %r11
1800012d4:     	js	0x1800013fe <.text+0x3fe>
1800012da:     	xorps	%xmm3, %xmm3
1800012dd:     	cvtsi2sd	%r8, %xmm3
1800012e2:     	mulsd	%xmm0, %xmm3
1800012e6:     	andpd	%xmm1, %xmm3
1800012ea:     	ucomisd	%xmm2, %xmm3
1800012ee:     	jae	0x1800013fe <.text+0x3fe>
1800012f4:     	imulq	%r9, %r8
1800012f8:     	leaq	(%r8,%rax), %r11
1800012fc:     	xorq	%r11, %r8
1800012ff:     	movq	%r11, %rsi
180001302:     	xorq	%rax, %rsi
180001305:     	testq	%rsi, %r8
180001308:     	js	0x1800013fe <.text+0x3fe>
18000130e:     	xorps	%xmm3, %xmm3
180001311:     	cvtsi2sd	%r11, %xmm3
180001316:     	mulsd	%xmm0, %xmm3
18000131a:     	andpd	%xmm1, %xmm3
18000131e:     	ucomisd	%xmm2, %xmm3
180001322:     	jae	0x1800013fe <.text+0x3fe>
180001328:     	imulq	%r9, %r11
18000132c:     	leaq	(%r11,%rax), %r8
180001330:     	xorq	%r8, %r11
180001333:     	movq	%r8, %rsi
180001336:     	xorq	%rax, %rsi
180001339:     	testq	%rsi, %r11
18000133c:     	js	0x1800013fe <.text+0x3fe>
180001342:     	xorps	%xmm3, %xmm3
180001345:     	cvtsi2sd	%r8, %xmm3
18000134a:     	mulsd	%xmm0, %xmm3
18000134e:     	andpd	%xmm1, %xmm3
180001352:     	ucomisd	%xmm2, %xmm3
180001356:     	jae	0x1800013fe <.text+0x3fe>
18000135c:     	imulq	%r9, %r8
180001360:     	leaq	(%r8,%rax), %r11
180001364:     	xorq	%r11, %r8
180001367:     	movq	%r11, %rsi
18000136a:     	xorq	%rax, %rsi
18000136d:     	testq	%rsi, %r8
180001370:     	js	0x1800013fe <.text+0x3fe>
180001376:     	xorps	%xmm3, %xmm3
180001379:     	cvtsi2sd	%r11, %xmm3
18000137e:     	mulsd	%xmm0, %xmm3
180001382:     	andpd	%xmm1, %xmm3
180001386:     	ucomisd	%xmm2, %xmm3
18000138a:     	jae	0x1800013fe <.text+0x3fe>
18000138c:     	imulq	%r9, %r11
180001390:     	leaq	(%r11,%rax), %r8
180001394:     	xorq	%r8, %r11
180001397:     	movq	%r8, %rsi
18000139a:     	xorq	%rax, %rsi
18000139d:     	testq	%rsi, %r11
1800013a0:     	js	0x1800013fe <.text+0x3fe>
1800013a2:     	xorps	%xmm3, %xmm3
1800013a5:     	cvtsi2sd	%r8, %xmm3
1800013aa:     	mulsd	%xmm0, %xmm3
1800013ae:     	andpd	%xmm1, %xmm3
1800013b2:     	ucomisd	%xmm2, %xmm3
1800013b6:     	jae	0x1800013fe <.text+0x3fe>
1800013b8:     	imulq	%r9, %r8
1800013bc:     	leaq	(%r8,%rax), %r11
1800013c0:     	xorq	%r11, %r8
1800013c3:     	movq	%r11, %rsi
1800013c6:     	xorq	%rax, %rsi
1800013c9:     	testq	%rsi, %r8
1800013cc:     	js	0x1800013fe <.text+0x3fe>
1800013ce:     	xorps	%xmm3, %xmm3
1800013d1:     	cvtsi2sd	%r11, %xmm3
1800013d6:     	mulsd	%xmm0, %xmm3
1800013da:     	andpd	%xmm1, %xmm3
1800013de:     	ucomisd	%xmm2, %xmm3
1800013e2:     	jae	0x1800013fe <.text+0x3fe>
1800013e4:     	imulq	%r9, %r11
1800013e8:     	leaq	(%r11,%rax), %r8
1800013ec:     	xorq	%r8, %r11
1800013ef:     	movq	%r8, %rsi
1800013f2:     	xorq	%rax, %rsi
1800013f5:     	testq	%rsi, %r11
1800013f8:     	jns	0x1800010bd <.text+0xbd>
1800013fe:     	movb	$0x1, (%rdx)
180001401:     	xorl	%r8d, %r8d
180001404:     	movq	%r8, (%rcx)
180001407:     	popq	%rsi
180001408:     	retq
180001409:     	nopl	(%rax)
180001410:     	pushq	%r15
180001412:     	pushq	%r14
180001414:     	pushq	%r13
180001416:     	pushq	%r12
180001418:     	pushq	%rsi
180001419:     	pushq	%rdi
18000141a:     	pushq	%rbp
18000141b:     	pushq	%rbx
18000141c:     	subq	$0x1b8, %rsp            # imm = 0x1B8
180001423:     	movq	%rdx, %rcx
180001426:     	leaq	0x80(%rsp), %rax
18000142e:     	movq	%rax, 0x58(%rsp)
180001433:     	leaq	0x88(%rsp), %rax
18000143b:     	movq	%rax, 0x50(%rsp)
180001440:     	leaq	0x90(%rsp), %rax
180001448:     	movq	%rax, 0x48(%rsp)
18000144d:     	leaq	0x98(%rsp), %rax
180001455:     	movq	%rax, 0x40(%rsp)
18000145a:     	leaq	0xa0(%rsp), %rax
180001462:     	movq	%rax, 0x38(%rsp)
180001467:     	leaq	0xa8(%rsp), %rax
18000146f:     	movq	%rax, 0x30(%rsp)
180001474:     	leaq	0xb0(%rsp), %rax
18000147c:     	movq	%rax, 0x28(%rsp)
180001481:     	leaq	0xb8(%rsp), %rax
180001489:     	movq	%rax, 0x20(%rsp)
18000148e:     	leaq	0x3f5b(%rip), %rdx      # 0x1800053f0
180001495:     	movl	$0x8, %r8d
18000149b:     	movl	$0x8, %r9d
1800014a1:     	callq	0x1800033b1 <numba_list_iter_next+0x2f1>
1800014a6:     	testl	%eax, %eax
1800014a8:     	movq	$0x0, 0x68(%rsp)
1800014b1:     	je	0x180001880 <.text+0x880>
1800014b7:     	cmpq	$0x0, 0xa7a1(%rip)      # 0x18000bc60
1800014bf:     	je	0x1800017b5 <.text+0x7b5>
1800014c5:     	movq	0xb8(%rsp), %rcx
1800014cd:     	xorps	%xmm0, %xmm0
1800014d0:     	movaps	%xmm0, 0x180(%rsp)
1800014d8:     	movaps	%xmm0, 0x190(%rsp)
1800014e0:     	movaps	%xmm0, 0x1a0(%rsp)
1800014e8:     	movq	$0x0, 0x1b0(%rsp)
1800014f4:     	leaq	0x180(%rsp), %rdx
1800014fc:     	callq	0x180002090 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7a0>
180001501:     	testl	%eax, %eax
180001503:     	jne	0x1800017cd <.text+0x7cd>
180001509:     	cmpq	$0x8, 0x198(%rsp)
180001512:     	jne	0x1800017cd <.text+0x7cd>
180001518:     	movq	0x180(%rsp), %rdi
180001520:     	movq	0xb0(%rsp), %rcx
180001528:     	xorps	%xmm0, %xmm0
18000152b:     	movaps	%xmm0, 0x140(%rsp)
180001533:     	movaps	%xmm0, 0x150(%rsp)
18000153b:     	movaps	%xmm0, 0x160(%rsp)
180001543:     	movq	$0x0, 0x170(%rsp)
18000154f:     	leaq	0x140(%rsp), %rdx
180001557:     	callq	0x180002090 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7a0>
18000155c:     	testl	%eax, %eax
18000155e:     	jne	0x1800017e5 <.text+0x7e5>
180001564:     	cmpq	$0x8, 0x158(%rsp)
18000156d:     	jne	0x1800017e5 <.text+0x7e5>
180001573:     	movq	0x140(%rsp), %rbx
18000157b:     	movq	0xa8(%rsp), %rcx
180001583:     	xorps	%xmm0, %xmm0
180001586:     	movaps	%xmm0, 0x100(%rsp)
18000158e:     	movaps	%xmm0, 0x110(%rsp)
180001596:     	movaps	%xmm0, 0x120(%rsp)
18000159e:     	movq	$0x0, 0x130(%rsp)
1800015aa:     	leaq	0x100(%rsp), %rdx
1800015b2:     	callq	0x180002090 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7a0>
1800015b7:     	testl	%eax, %eax
1800015b9:     	jne	0x1800017fa <.text+0x7fa>
1800015bf:     	cmpq	$0x8, 0x118(%rsp)
1800015c8:     	jne	0x1800017fa <.text+0x7fa>
1800015ce:     	movq	0x100(%rsp), %r14
1800015d6:     	movq	0xa0(%rsp), %rcx
1800015de:     	xorps	%xmm0, %xmm0
1800015e1:     	movaps	%xmm0, 0xc0(%rsp)
1800015e9:     	movaps	%xmm0, 0xd0(%rsp)
1800015f1:     	movaps	%xmm0, 0xe0(%rsp)
1800015f9:     	movq	$0x0, 0xf0(%rsp)
180001605:     	leaq	0xc0(%rsp), %rdx
18000160d:     	callq	0x180002090 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7a0>
180001612:     	testl	%eax, %eax
180001614:     	jne	0x18000180f <.text+0x80f>
18000161a:     	cmpq	$0x1, 0xd8(%rsp)
180001623:     	jne	0x18000180f <.text+0x80f>
180001629:     	movq	0xc0(%rsp), %r15
180001631:     	movq	0xe0(%rsp), %r12
180001639:     	movq	0x98(%rsp), %rcx
180001641:     	callq	0x1800033b7 <numba_list_iter_next+0x2f7>
180001646:     	testq	%rax, %rax
180001649:     	je	0x180001824 <.text+0x824>
18000164f:     	movq	%rax, %rsi
180001652:     	movq	%rax, %rcx
180001655:     	callq	0x1800033bd <numba_list_iter_next+0x2fd>
18000165a:     	movq	%rax, %r13
18000165d:     	movq	%rsi, %rcx
180001660:     	callq	0x1800033c3 <numba_list_iter_next+0x303>
180001665:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
18000166a:     	testq	%rax, %rax
18000166d:     	jne	0x180001860 <.text+0x860>
180001673:     	movq	0x90(%rsp), %rcx
18000167b:     	callq	0x1800033b7 <numba_list_iter_next+0x2f7>
180001680:     	testq	%rax, %rax
180001683:     	je	0x180001837 <.text+0x837>
180001689:     	movq	%rax, %rsi
18000168c:     	movq	%rax, %rcx
18000168f:     	callq	0x1800033bd <numba_list_iter_next+0x2fd>
180001694:     	movq	%rax, %rbp
180001697:     	movq	%rsi, %rcx
18000169a:     	callq	0x1800033c3 <numba_list_iter_next+0x303>
18000169f:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
1800016a4:     	testq	%rax, %rax
1800016a7:     	jne	0x180001860 <.text+0x860>
1800016ad:     	movq	0x88(%rsp), %rcx
1800016b5:     	callq	0x1800033b7 <numba_list_iter_next+0x2f7>
1800016ba:     	testq	%rax, %rax
1800016bd:     	je	0x180001849 <.text+0x849>
1800016c3:     	movq	%rax, %rsi
1800016c6:     	movq	%rax, %rcx
1800016c9:     	callq	0x1800033bd <numba_list_iter_next+0x2fd>
1800016ce:     	movq	%rax, 0x70(%rsp)
1800016d3:     	movq	%rsi, %rcx
1800016d6:     	callq	0x1800033c3 <numba_list_iter_next+0x303>
1800016db:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
1800016e0:     	testq	%rax, %rax
1800016e3:     	jne	0x180001860 <.text+0x860>
1800016e9:     	movq	%rbp, 0x78(%rsp)
1800016ee:     	movq	%r13, %rbp
1800016f1:     	movq	%r12, %r13
1800016f4:     	movq	%r15, %r12
1800016f7:     	movq	%r14, %r15
1800016fa:     	movq	%rbx, %r14
1800016fd:     	movq	%rdi, %rbx
180001700:     	movq	0x80(%rsp), %rcx
180001708:     	callq	0x1800033b7 <numba_list_iter_next+0x2f7>
18000170d:     	testq	%rax, %rax
180001710:     	je	0x180001887 <.text+0x887>
180001716:     	movq	%rax, %rdi
180001719:     	movq	%rax, %rcx
18000171c:     	callq	0x1800033bd <numba_list_iter_next+0x2fd>
180001721:     	movq	%rax, %rsi
180001724:     	movq	%rdi, %rcx
180001727:     	callq	0x1800033c3 <numba_list_iter_next+0x303>
18000172c:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
180001731:     	testq	%rax, %rax
180001734:     	movq	%rbx, %rdi
180001737:     	movq	%r14, %rbx
18000173a:     	movq	%r15, %r14
18000173d:     	movq	%r12, %r15
180001740:     	movq	0x78(%rsp), %r9
180001745:     	jne	0x180001860 <.text+0x860>
18000174b:     	movq	$0x0, 0x68(%rsp)
180001754:     	movq	%rsi, 0x28(%rsp)
180001759:     	movq	0x70(%rsp), %rax
18000175e:     	movq	%rax, 0x20(%rsp)
180001763:     	leaq	0x68(%rsp), %rcx
180001768:     	movq	%r13, %rdx
18000176b:     	movq	%rbp, %r8
18000176e:     	callq	0x180001090 <.text+0x90>
180001773:     	movq	0x68(%rsp), %rsi
180001778:     	movq	%rdi, %rcx
18000177b:     	callq	0x180001060 <.text+0x60>
180001780:     	movq	%rbx, %rcx
180001783:     	callq	0x180001060 <.text+0x60>
180001788:     	movq	%r14, %rcx
18000178b:     	callq	0x180001060 <.text+0x60>
180001790:     	movq	%r15, %rcx
180001793:     	callq	0x180001060 <.text+0x60>
180001798:     	movq	%rsi, %rcx
18000179b:     	callq	0x1800033cf <numba_list_iter_next+0x30f>
1800017a0:     	nop
1800017a1:     	addq	$0x1b8, %rsp            # imm = 0x1B8
1800017a8:     	popq	%rbx
1800017a9:     	popq	%rbp
1800017aa:     	popq	%rdi
1800017ab:     	popq	%rsi
1800017ac:     	popq	%r12
1800017ae:     	popq	%r13
1800017b0:     	popq	%r14
1800017b2:     	popq	%r15
1800017b4:     	retq
1800017b5:     	movq	0x3a7c(%rip), %rcx      # 0x180005238
1800017bc:     	leaq	0x3c4d(%rip), %rdx      # 0x180005410
1800017c3:     	callq	0x1800033d5 <numba_list_iter_next+0x315>
1800017c8:     	jmp	0x180001880 <.text+0x880>
1800017cd:     	movq	0x3a54(%rip), %rcx      # 0x180005228
1800017d4:     	leaq	0x3d35(%rip), %rdx      # 0x180005510
1800017db:     	callq	0x1800033d5 <numba_list_iter_next+0x315>
1800017e0:     	jmp	0x180001880 <.text+0x880>
1800017e5:     	movq	0x3a3c(%rip), %rcx      # 0x180005228
1800017ec:     	leaq	0x3d1d(%rip), %rdx      # 0x180005510
1800017f3:     	callq	0x1800033d5 <numba_list_iter_next+0x315>
1800017f8:     	jmp	0x180001878 <.text+0x878>
1800017fa:     	movq	0x3a27(%rip), %rcx      # 0x180005228
180001801:     	leaq	0x3d08(%rip), %rdx      # 0x180005510
180001808:     	callq	0x1800033d5 <numba_list_iter_next+0x315>
18000180d:     	jmp	0x180001870 <.text+0x870>
18000180f:     	movq	0x3a12(%rip), %rcx      # 0x180005228
180001816:     	leaq	0x3cf3(%rip), %rdx      # 0x180005510
18000181d:     	callq	0x1800033d5 <numba_list_iter_next+0x315>
180001822:     	jmp	0x180001868 <.text+0x868>
180001824:     	xorl	%r13d, %r13d
180001827:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
18000182c:     	testq	%rax, %rax
18000182f:     	je	0x180001673 <.text+0x673>
180001835:     	jmp	0x180001860 <.text+0x860>
180001837:     	xorl	%ebp, %ebp
180001839:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
18000183e:     	testq	%rax, %rax
180001841:     	je	0x1800016ad <.text+0x6ad>
180001847:     	jmp	0x180001860 <.text+0x860>
180001849:     	movq	$0x0, 0x70(%rsp)
180001852:     	callq	0x1800033c9 <numba_list_iter_next+0x309>
180001857:     	testq	%rax, %rax
18000185a:     	je	0x1800016e9 <.text+0x6e9>
180001860:     	movq	%r15, %rcx
180001863:     	callq	0x180001060 <.text+0x60>
180001868:     	movq	%r14, %rcx
18000186b:     	callq	0x180001060 <.text+0x60>
180001870:     	movq	%rbx, %rcx
180001873:     	callq	0x180001060 <.text+0x60>
180001878:     	movq	%rdi, %rcx
18000187b:     	callq	0x180001060 <.text+0x60>
180001880:     	xorl	%eax, %eax
180001882:     	jmp	0x1800017a1 <.text+0x7a1>
180001887:     	xorl	%esi, %esi
180001889:     	jmp	0x18000172c <.text+0x72c>
18000188e:     	nop
180001890:     	subq	$0x38, %rsp
180001894:     	movq	0x108(%rsp), %rdx
18000189c:     	movq	0x120(%rsp), %r8
1800018a4:     	movq	0x128(%rsp), %r9
1800018ac:     	movq	0x130(%rsp), %rax
1800018b4:     	movq	0x138(%rsp), %rcx
1800018bc:     	movq	$0x0, 0x30(%rsp)
1800018c5:     	movq	%rcx, 0x28(%rsp)
1800018ca:     	movq	%rax, 0x20(%rsp)
1800018cf:     	leaq	0x30(%rsp), %rcx
1800018d4:     	callq	0x180001090 <.text+0x90>
1800018d9:     	movq	0x30(%rsp), %rax
1800018de:     	addq	$0x38, %rsp
1800018e2:     	retq
1800018e3:     	nopw	%cs:(%rax,%rax)
1800018ed:     	nopl	(%rax)

00000001800018f0 <PyInit_rcaotr_0cedc59f0901480dc0803d7c>:
1800018f0:     	pushq	%rsi
1800018f1:     	subq	$0x20, %rsp
1800018f5:     	leaq	0x9744(%rip), %rcx      # 0x18000b040
1800018fc:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001901:     	callq	0x1800033db <numba_list_iter_next+0x31b>
180001906:     	testq	%rax, %rax
180001909:     	je	0x18000193b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x4b>
18000190b:     	leaq	0x96ee(%rip), %rdx      # 0x18000b000
180001912:     	leaq	0x3ca7(%rip), %r8       # 0x1800055c0
180001919:     	leaq	0x3cc8(%rip), %r9       # 0x1800055e8
180001920:     	movq	%rax, %rcx
180001923:     	movq	%rax, %rsi
180001926:     	callq	0x180002300 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xa10>
18000192b:     	movl	%eax, %ecx
18000192d:     	xorl	%eax, %eax
18000192f:     	testl	%ecx, %ecx
180001931:     	cmoveq	%rsi, %rax
180001935:     	addq	$0x20, %rsp
180001939:     	popq	%rsi
18000193a:     	retq
18000193b:     	xorl	%eax, %eax
18000193d:     	addq	$0x20, %rsp
180001941:     	popq	%rsi
180001942:     	retq
180001943:     	int3
180001944:     	int3
180001945:     	int3
180001946:     	int3
180001947:     	int3
180001948:     	int3
180001949:     	int3
18000194a:     	int3
18000194b:     	int3
18000194c:     	int3
18000194d:     	int3
18000194e:     	int3
18000194f:     	int3
180001950:     	movq	%rbx, 0x8(%rsp)
180001955:     	movq	%rsi, 0x10(%rsp)
18000195a:     	pushq	%rdi
18000195b:     	subq	$0x20, %rsp
18000195f:     	movq	%rcx, %rbx
180001962:     	movq	%r8, %rdi
180001965:     	movq	0x10(%rcx), %rcx
180001969:     	movq	%rdx, %rsi
18000196c:     	testq	%rcx, %rcx
18000196f:     	je	0x18000197a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x8a>
180001971:     	movq	%r8, %rdx
180001974:     	callq	*%rsi
180001976:     	testl	%eax, %eax
180001978:     	jne	0x18000199d <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xad>
18000197a:     	movq	0x18(%rbx), %rcx
18000197e:     	testq	%rcx, %rcx
180001981:     	je	0x18000199b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xab>
180001983:     	movq	%rdi, %rdx
180001986:     	movq	%rsi, %rax
180001989:     	movq	0x30(%rsp), %rbx
18000198e:     	movq	0x38(%rsp), %rsi
180001993:     	addq	$0x20, %rsp
180001997:     	popq	%rdi
180001998:     	jmpq	*%rax
18000199b:     	xorl	%eax, %eax
18000199d:     	movq	0x30(%rsp), %rbx
1800019a2:     	movq	0x38(%rsp), %rsi
1800019a7:     	addq	$0x20, %rsp
1800019ab:     	popq	%rdi
1800019ac:     	retq
1800019ad:     	int3
1800019ae:     	int3
1800019af:     	int3
1800019b0:     	pushq	%rbx
1800019b2:     	subq	$0x20, %rsp
1800019b6:     	movq	%rcx, %rbx
1800019b9:     	movq	0x10(%rcx), %rcx
1800019bd:     	testq	%rcx, %rcx
1800019c0:     	je	0x1800019dd <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xed>
1800019c2:     	movq	$0x0, 0x10(%rbx)
1800019ca:     	movl	(%rcx), %eax
1800019cc:     	testl	%eax, %eax
1800019ce:     	js	0x1800019dd <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xed>
1800019d0:     	subl	$0x1, %eax
1800019d3:     	movl	%eax, (%rcx)
1800019d5:     	jne	0x1800019dd <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xed>
1800019d7:     	callq	*0x37d3(%rip)           # 0x1800051b0
1800019dd:     	movq	0x18(%rbx), %rcx
1800019e1:     	testq	%rcx, %rcx
1800019e4:     	je	0x180001a01 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x111>
1800019e6:     	movq	$0x0, 0x18(%rbx)
1800019ee:     	movl	(%rcx), %eax
1800019f0:     	testl	%eax, %eax
1800019f2:     	js	0x180001a01 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x111>
1800019f4:     	subl	$0x1, %eax
1800019f7:     	movl	%eax, (%rcx)
1800019f9:     	jne	0x180001a01 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x111>
1800019fb:     	callq	*0x37af(%rip)           # 0x1800051b0
180001a01:     	xorl	%eax, %eax
180001a03:     	addq	$0x20, %rsp
180001a07:     	popq	%rbx
180001a08:     	retq
180001a09:     	int3
180001a0a:     	int3
180001a0b:     	int3
180001a0c:     	int3
180001a0d:     	int3
180001a0e:     	int3
180001a0f:     	int3
180001a10:     	pushq	%rbx
180001a12:     	subq	$0x20, %rsp
180001a16:     	movq	%rcx, %rbx
180001a19:     	callq	*0x37d1(%rip)           # 0x1800051f0
180001a1f:     	movq	0x10(%rbx), %rcx
180001a23:     	testq	%rcx, %rcx
180001a26:     	je	0x180001a43 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x153>
180001a28:     	movq	$0x0, 0x10(%rbx)
180001a30:     	movl	(%rcx), %eax
180001a32:     	testl	%eax, %eax
180001a34:     	js	0x180001a43 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x153>
180001a36:     	subl	$0x1, %eax
180001a39:     	movl	%eax, (%rcx)
180001a3b:     	jne	0x180001a43 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x153>
180001a3d:     	callq	*0x376d(%rip)           # 0x1800051b0
180001a43:     	movq	0x18(%rbx), %rcx
180001a47:     	testq	%rcx, %rcx
180001a4a:     	je	0x180001a67 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x177>
180001a4c:     	movq	$0x0, 0x18(%rbx)
180001a54:     	movl	(%rcx), %eax
180001a56:     	testl	%eax, %eax
180001a58:     	js	0x180001a67 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x177>
180001a5a:     	subl	$0x1, %eax
180001a5d:     	movl	%eax, (%rcx)
180001a5f:     	jne	0x180001a67 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x177>
180001a61:     	callq	*0x3749(%rip)           # 0x1800051b0
180001a67:     	movq	0x8(%rbx), %rax
180001a6b:     	movq	%rbx, %rcx
180001a6e:     	addq	$0x20, %rsp
180001a72:     	popq	%rbx
180001a73:     	jmpq	*0x140(%rax)
180001a7a:     	int3
180001a7b:     	int3
180001a7c:     	int3
180001a7d:     	int3
180001a7e:     	int3
180001a7f:     	int3
180001a80:     	pushq	%rbx
180001a82:     	subq	$0x30, %rsp
180001a86:     	movq	%r8, %r10
180001a89:     	leaq	0x58(%rsp), %rax
180001a8e:     	movq	%rax, 0x28(%rsp)
180001a93:     	leaq	0x9ef6(%rip), %r9       # 0x18000b990
180001a9a:     	movq	0x371f(%rip), %rax      # 0x1800051c0
180001aa1:     	leaq	0x3e80(%rip), %r8       # 0x180005928
180001aa8:     	movq	%rdx, %r11
180001aab:     	movq	%rax, 0x20(%rsp)
180001ab0:     	movq	%rcx, %rbx
180001ab3:     	movq	%r10, %rdx
180001ab6:     	movq	%r11, %rcx
180001ab9:     	callq	*0x3621(%rip)           # 0x1800050e0
180001abf:     	testl	%eax, %eax
180001ac1:     	je	0x180001b1c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x22c>
180001ac3:     	xorl	%r8d, %r8d
180001ac6:     	xorl	%edx, %edx
180001ac8:     	movq	%rbx, %rcx
180001acb:     	callq	*0x373f(%rip)           # 0x180005210
180001ad1:     	movq	%rax, %rbx
180001ad4:     	testq	%rax, %rax
180001ad7:     	je	0x180001b1c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x22c>
180001ad9:     	movq	0x58(%rsp), %rax
180001ade:     	movl	(%rax), %ecx
180001ae0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001ae6:     	jae	0x180001af1 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x201>
180001ae8:     	incl	%ecx
180001aea:     	movl	%ecx, (%rax)
180001aec:     	movq	0x58(%rsp), %rax
180001af1:     	xorl	%ecx, %ecx
180001af3:     	movq	%rax, 0x10(%rbx)
180001af7:     	callq	*0x3673(%rip)           # 0x180005170
180001afd:     	movq	%rax, 0x18(%rbx)
180001b01:     	testq	%rax, %rax
180001b04:     	jne	0x180001b24 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x234>
180001b06:     	movl	(%rbx), %eax
180001b08:     	testl	%eax, %eax
180001b0a:     	js	0x180001b1c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x22c>
180001b0c:     	subl	$0x1, %eax
180001b0f:     	movl	%eax, (%rbx)
180001b11:     	jne	0x180001b1c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x22c>
180001b13:     	movq	%rbx, %rcx
180001b16:     	callq	*0x3694(%rip)           # 0x1800051b0
180001b1c:     	xorl	%eax, %eax
180001b1e:     	addq	$0x30, %rsp
180001b22:     	popq	%rbx
180001b23:     	retq
180001b24:     	movq	%rbx, %rax
180001b27:     	addq	$0x30, %rsp
180001b2b:     	popq	%rbx
180001b2c:     	retq
180001b2d:     	int3
180001b2e:     	int3
180001b2f:     	int3
180001b30:     	movq	%rbx, 0x8(%rsp)
180001b35:     	movq	%rsi, 0x10(%rsp)
180001b3a:     	pushq	%rdi
180001b3b:     	subq	$0x20, %rsp
180001b3f:     	movq	%rcx, %rbx
180001b42:     	movq	%r8, %rdi
180001b45:     	movq	0x18(%rcx), %rcx
180001b49:     	movq	%rdx, %rsi
180001b4c:     	testq	%rcx, %rcx
180001b4f:     	je	0x180001b5a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x26a>
180001b51:     	movq	%r8, %rdx
180001b54:     	callq	*%rsi
180001b56:     	testl	%eax, %eax
180001b58:     	jne	0x180001b7d <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x28d>
180001b5a:     	movq	0x40(%rbx), %rcx
180001b5e:     	testq	%rcx, %rcx
180001b61:     	je	0x180001b7b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x28b>
180001b63:     	movq	%rdi, %rdx
180001b66:     	movq	%rsi, %rax
180001b69:     	movq	0x30(%rsp), %rbx
180001b6e:     	movq	0x38(%rsp), %rsi
180001b73:     	addq	$0x20, %rsp
180001b77:     	popq	%rdi
180001b78:     	jmpq	*%rax
180001b7b:     	xorl	%eax, %eax
180001b7d:     	movq	0x30(%rsp), %rbx
180001b82:     	movq	0x38(%rsp), %rsi
180001b87:     	addq	$0x20, %rsp
180001b8b:     	popq	%rdi
180001b8c:     	retq
180001b8d:     	int3
180001b8e:     	int3
180001b8f:     	int3
180001b90:     	pushq	%rbx
180001b92:     	subq	$0x20, %rsp
180001b96:     	movq	%rcx, %rbx
180001b99:     	callq	*0x3651(%rip)           # 0x1800051f0
180001b9f:     	cmpq	$0x0, 0x48(%rbx)
180001ba4:     	je	0x180001baf <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x2bf>
180001ba6:     	movq	%rbx, %rcx
180001ba9:     	callq	*0x35d1(%rip)           # 0x180005180
180001baf:     	movq	0x20(%rbx), %rcx
180001bb3:     	callq	*0x35e7(%rip)           # 0x1800051a0
180001bb9:     	movq	0x38(%rbx), %rcx
180001bbd:     	callq	*0x35dd(%rip)           # 0x1800051a0
180001bc3:     	movq	0x18(%rbx), %rcx
180001bc7:     	testq	%rcx, %rcx
180001bca:     	je	0x180001bdf <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x2ef>
180001bcc:     	movl	(%rcx), %eax
180001bce:     	testl	%eax, %eax
180001bd0:     	js	0x180001bdf <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x2ef>
180001bd2:     	subl	$0x1, %eax
180001bd5:     	movl	%eax, (%rcx)
180001bd7:     	jne	0x180001bdf <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x2ef>
180001bd9:     	callq	*0x35d1(%rip)           # 0x1800051b0
180001bdf:     	movq	0x40(%rbx), %rcx
180001be3:     	testq	%rcx, %rcx
180001be6:     	je	0x180001bfb <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x30b>
180001be8:     	movl	(%rcx), %eax
180001bea:     	testl	%eax, %eax
180001bec:     	js	0x180001bfb <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x30b>
180001bee:     	subl	$0x1, %eax
180001bf1:     	movl	%eax, (%rcx)
180001bf3:     	jne	0x180001bfb <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x30b>
180001bf5:     	callq	*0x35b5(%rip)           # 0x1800051b0
180001bfb:     	movq	0x8(%rbx), %rax
180001bff:     	movq	%rbx, %rcx
180001c02:     	addq	$0x20, %rsp
180001c06:     	popq	%rbx
180001c07:     	jmpq	*0x140(%rax)
180001c0e:     	int3
180001c0f:     	int3
180001c10:     	pushq	%rbx
180001c12:     	subq	$0x20, %rsp
180001c16:     	callq	*0x355c(%rip)           # 0x180005178
180001c1c:     	movq	%rax, %rbx
180001c1f:     	testq	%rax, %rax
180001c22:     	jne	0x180001c2a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x33a>
180001c24:     	addq	$0x20, %rsp
180001c28:     	popq	%rbx
180001c29:     	retq
180001c2a:     	movq	%rbx, %rcx
180001c2d:     	movq	%rdi, 0x30(%rsp)
180001c32:     	callq	0x180003f45 <numba_list_iter_next+0xe85>
180001c37:     	leaq	0x1(%rax), %rcx
180001c3b:     	callq	*0x35d7(%rip)           # 0x180005218
180001c41:     	movq	%rax, %rdi
180001c44:     	testq	%rax, %rax
180001c47:     	jne	0x180001c5c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x36c>
180001c49:     	callq	*0x34e9(%rip)           # 0x180005138
180001c4f:     	movq	0x30(%rsp), %rdi
180001c54:     	xorl	%eax, %eax
180001c56:     	addq	$0x20, %rsp
180001c5a:     	popq	%rbx
180001c5b:     	retq
180001c5c:     	movq	%rbx, %rdx
180001c5f:     	movq	%rdi, %rcx
180001c62:     	callq	0x180003f3f <numba_list_iter_next+0xe7f>
180001c67:     	movq	%rdi, %rax
180001c6a:     	movq	0x30(%rsp), %rdi
180001c6f:     	addq	$0x20, %rsp
180001c73:     	popq	%rbx
180001c74:     	retq
180001c75:     	int3
180001c76:     	int3
180001c77:     	int3
180001c78:     	int3
180001c79:     	int3
180001c7a:     	int3
180001c7b:     	int3
180001c7c:     	int3
180001c7d:     	int3
180001c7e:     	int3
180001c7f:     	int3
180001c80:     	movq	0x18(%rcx), %rcx
180001c84:     	movq	%rdx, %rax
180001c87:     	testq	%rcx, %rcx
180001c8a:     	je	0x180001c92 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x3a2>
180001c8c:     	movq	%r8, %rdx
180001c8f:     	jmpq	*%rax
180001c92:     	xorl	%eax, %eax
180001c94:     	retq
180001c95:     	int3
180001c96:     	int3
180001c97:     	int3
180001c98:     	int3
180001c99:     	int3
180001c9a:     	int3
180001c9b:     	int3
180001c9c:     	int3
180001c9d:     	int3
180001c9e:     	int3
180001c9f:     	int3
180001ca0:     	movq	%rbx, 0x8(%rsp)
180001ca5:     	pushq	%rdi
180001ca6:     	subq	$0x20, %rsp
180001caa:     	movq	0x28(%rcx), %rax
180001cae:     	xorl	%edi, %edi
180001cb0:     	movq	%rcx, %rbx
180001cb3:     	testq	%rax, %rax
180001cb6:     	je	0x180001cc2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x3d2>
180001cb8:     	addq	$0x38, %rcx
180001cbc:     	callq	*%rax
180001cbe:     	movq	%rdi, 0x28(%rbx)
180001cc2:     	movq	0x18(%rbx), %rcx
180001cc6:     	testq	%rcx, %rcx
180001cc9:     	je	0x180001ce2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x3f2>
180001ccb:     	movq	%rdi, 0x18(%rbx)
180001ccf:     	movl	(%rcx), %eax
180001cd1:     	testl	%eax, %eax
180001cd3:     	js	0x180001ce2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x3f2>
180001cd5:     	subl	$0x1, %eax
180001cd8:     	movl	%eax, (%rcx)
180001cda:     	jne	0x180001ce2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x3f2>
180001cdc:     	callq	*0x34ce(%rip)           # 0x1800051b0
180001ce2:     	movq	%rdi, 0x20(%rbx)
180001ce6:     	xorl	%eax, %eax
180001ce8:     	movq	0x30(%rsp), %rbx
180001ced:     	addq	$0x20, %rsp
180001cf1:     	popq	%rdi
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
180001d00:     	pushq	%rbx
180001d02:     	subq	$0x20, %rsp
180001d06:     	movq	%rcx, %rbx
180001d09:     	callq	*0x34e1(%rip)           # 0x1800051f0
180001d0f:     	cmpq	$0x0, 0x30(%rbx)
180001d14:     	je	0x180001d1f <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x42f>
180001d16:     	movq	%rbx, %rcx
180001d19:     	callq	*0x3461(%rip)           # 0x180005180
180001d1f:     	callq	*0x340b(%rip)           # 0x180005130
180001d25:     	testl	%eax, %eax
180001d27:     	jne	0x180001d38 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x448>
180001d29:     	movq	0x28(%rbx), %rax
180001d2d:     	testq	%rax, %rax
180001d30:     	je	0x180001d38 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x448>
180001d32:     	leaq	0x38(%rbx), %rcx
180001d36:     	callq	*%rax
180001d38:     	movq	0x18(%rbx), %rcx
180001d3c:     	testq	%rcx, %rcx
180001d3f:     	je	0x180001d54 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x464>
180001d41:     	movl	(%rcx), %eax
180001d43:     	testl	%eax, %eax
180001d45:     	js	0x180001d54 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x464>
180001d47:     	subl	$0x1, %eax
180001d4a:     	movl	%eax, (%rcx)
180001d4c:     	jne	0x180001d54 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x464>
180001d4e:     	callq	*0x345c(%rip)           # 0x1800051b0
180001d54:     	movq	0x8(%rbx), %rax
180001d58:     	movq	%rbx, %rcx
180001d5b:     	addq	$0x20, %rsp
180001d5f:     	popq	%rbx
180001d60:     	jmpq	*0x140(%rax)
180001d67:     	int3
180001d68:     	int3
180001d69:     	int3
180001d6a:     	int3
180001d6b:     	int3
180001d6c:     	int3
180001d6d:     	int3
180001d6e:     	int3
180001d6f:     	int3
180001d70:     	pushq	%rdi
180001d72:     	subq	$0x20, %rsp
180001d76:     	cmpq	$0x0, 0x20(%rcx)
180001d7b:     	movq	%rcx, %rdi
180001d7e:     	jne	0x180001d9f <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x4af>
180001d80:     	movq	0x34b1(%rip), %rcx      # 0x180005238
180001d87:     	leaq	0x3bea(%rip), %rdx      # 0x180005978
180001d8e:     	movq	(%rcx), %rcx
180001d91:     	callq	*0x3499(%rip)           # 0x180005230
180001d97:     	xorl	%eax, %eax
180001d99:     	addq	$0x20, %rsp
180001d9d:     	popq	%rdi
180001d9e:     	retq
180001d9f:     	movq	%rdi, %rdx
180001da2:     	movq	%rbx, 0x30(%rsp)
180001da7:     	movl	$0x1, %ecx
180001dac:     	callq	*0x333e(%rip)           # 0x1800050f0
180001db2:     	movq	%rax, %rbx
180001db5:     	testq	%rax, %rax
180001db8:     	jne	0x180001dc5 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x4d5>
180001dba:     	movq	0x30(%rsp), %rbx
180001dbf:     	addq	$0x20, %rsp
180001dc3:     	popq	%rdi
180001dc4:     	retq
180001dc5:     	xorl	%r8d, %r8d
180001dc8:     	movq	%rbx, %rdx
180001dcb:     	movq	%rdi, %rcx
180001dce:     	callq	*0x20(%rdi)
180001dd1:     	movl	(%rbx), %ecx
180001dd3:     	movq	%rax, %rdi
180001dd6:     	testl	%ecx, %ecx
180001dd8:     	js	0x180001dea <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x4fa>
180001dda:     	subl	$0x1, %ecx
180001ddd:     	movl	%ecx, (%rbx)
180001ddf:     	jne	0x180001dea <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x4fa>
180001de1:     	movq	%rbx, %rcx
180001de4:     	callq	*0x33c6(%rip)           # 0x1800051b0
180001dea:     	movq	0x30(%rsp), %rbx
180001def:     	movq	%rdi, %rax
180001df2:     	addq	$0x20, %rsp
180001df6:     	popq	%rdi
180001df7:     	retq
180001df8:     	int3
180001df9:     	int3
180001dfa:     	int3
180001dfb:     	int3
180001dfc:     	int3
180001dfd:     	int3
180001dfe:     	int3
180001dff:     	int3
180001e00:     	movq	%rbx, 0x8(%rsp)
180001e05:     	pushq	%rdi
180001e06:     	subq	$0x20, %rsp
180001e0a:     	movq	%r8, %rbx
180001e0d:     	callq	*0x3305(%rip)           # 0x180005118
180001e13:     	movl	(%rbx), %ecx
180001e15:     	movl	%eax, %edi
180001e17:     	testl	%ecx, %ecx
180001e19:     	js	0x180001e2b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x53b>
180001e1b:     	subl	$0x1, %ecx
180001e1e:     	movl	%ecx, (%rbx)
180001e20:     	jne	0x180001e2b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x53b>
180001e22:     	movq	%rbx, %rcx
180001e25:     	callq	*0x3385(%rip)           # 0x1800051b0
180001e2b:     	movl	%edi, %ecx
180001e2d:     	movq	0x30(%rsp), %rbx
180001e32:     	addq	$0x20, %rsp
180001e36:     	popq	%rdi
180001e37:     	jmpq	*0x33aa(%rip)           # 0x1800051e8
180001e3e:     	int3
180001e3f:     	int3
180001e40:     	movq	%rbx, 0x8(%rsp)
180001e45:     	pushq	%rdi
180001e46:     	subq	$0x20, %rsp
180001e4a:     	movl	(%rdx), %eax
180001e4c:     	movq	%rdx, %rbx
180001e4f:     	movq	%rcx, %rdi
180001e52:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001e57:     	jae	0x180001e5d <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x56d>
180001e59:     	incl	%eax
180001e5b:     	movl	%eax, (%rdx)
180001e5d:     	movl	$0x30, %ecx
180001e62:     	callq	*0x9dc0(%rip)           # 0x18000bc28
180001e68:     	cmpb	$0x0, 0x9d91(%rip)      # 0x18000bc00
180001e6f:     	je	0x180001e79 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x589>
180001e71:     	lock
180001e72:     	incq	0x9d8f(%rip)            # 0x18000bc08
180001e79:     	testq	%rax, %rax
180001e7c:     	je	0x180001eb3 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x5c3>
180001e7e:     	movl	$0x1, %ecx
180001e83:     	leaq	-0x8a(%rip), %rdx       # 0x180001e00 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x510>
180001e8a:     	xchgq	%rcx, (%rax)
180001e8d:     	xorl	%ecx, %ecx
180001e8f:     	movq	%rdx, 0x8(%rax)
180001e93:     	movq	%rcx, 0x20(%rax)
180001e97:     	movq	%rcx, 0x28(%rax)
180001e9b:     	movq	%rbx, 0x10(%rax)
180001e9f:     	movq	%rdi, 0x18(%rax)
180001ea3:     	cmpb	%cl, 0x9d57(%rip)       # 0x18000bc00
180001ea9:     	je	0x180001eb3 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x5c3>
180001eab:     	lock
180001eac:     	incq	0x9d65(%rip)            # 0x18000bc18
180001eb3:     	movq	0x30(%rsp), %rbx
180001eb8:     	addq	$0x20, %rsp
180001ebc:     	popq	%rdi
180001ebd:     	retq
180001ebe:     	int3
180001ebf:     	int3
180001ec0:     	movq	%rbx, 0x8(%rsp)
180001ec5:     	pushq	%rdi
180001ec6:     	subq	$0x30, %rsp
180001eca:     	movq	%rcx, %rdi
180001ecd:     	leaq	0x9aac(%rip), %r9       # 0x18000b980
180001ed4:     	movq	%r8, %rax
180001ed7:     	leaq	0x58(%rsp), %rcx
180001edc:     	movq	%rdx, %r10
180001edf:     	movq	%rcx, 0x20(%rsp)
180001ee4:     	movq	%r10, %rcx
180001ee7:     	leaq	0x3ad2(%rip), %r8       # 0x1800059c0
180001eee:     	movq	%rax, %rdx
180001ef1:     	callq	*0x31e9(%rip)           # 0x1800050e0
180001ef7:     	testl	%eax, %eax
180001ef9:     	je	0x180001f23 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x633>
180001efb:     	movq	0x58(%rsp), %rcx
180001f00:     	callq	*0x3222(%rip)           # 0x180005128
180001f06:     	movq	%rax, %rbx
180001f09:     	callq	*0x3339(%rip)           # 0x180005248
180001f0f:     	testq	%rax, %rax
180001f12:     	jne	0x180001f23 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x633>
180001f14:     	movq	%rbx, 0x10(%rdi)
180001f18:     	movq	0x40(%rsp), %rbx
180001f1d:     	addq	$0x30, %rsp
180001f21:     	popq	%rdi
180001f22:     	retq
180001f23:     	movq	0x40(%rsp), %rbx
180001f28:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001f2d:     	addq	$0x30, %rsp
180001f31:     	popq	%rdi
180001f32:     	retq
180001f33:     	int3
180001f34:     	int3
180001f35:     	int3
180001f36:     	int3
180001f37:     	int3
180001f38:     	int3
180001f39:     	int3
180001f3a:     	int3
180001f3b:     	int3
180001f3c:     	int3
180001f3d:     	int3
180001f3e:     	int3
180001f3f:     	int3
180001f40:     	subq	$0x38, %rsp
180001f44:     	movl	%r8d, %eax
180001f47:     	movq	%rdx, %r10
180001f4a:     	movq	0x10(%rcx), %r8
180001f4e:     	movq	%rcx, %rdx
180001f51:     	movl	%eax, 0x28(%rsp)
180001f55:     	movq	%r10, %rcx
180001f58:     	movl	$0x0, 0x20(%rsp)
180001f60:     	movq	0x20(%r8), %r9
180001f64:     	movq	0x18(%r8), %r8
180001f68:     	callq	*0x326a(%rip)           # 0x1800051d8
180001f6e:     	addq	$0x38, %rsp
180001f72:     	retq
180001f73:     	int3
180001f74:     	int3
180001f75:     	int3
180001f76:     	int3
180001f77:     	int3
180001f78:     	int3
180001f79:     	int3
180001f7a:     	int3
180001f7b:     	int3
180001f7c:     	int3
180001f7d:     	int3
180001f7e:     	int3
180001f7f:     	int3
180001f80:     	movq	0x10(%rcx), %rax
180001f84:     	lock
180001f85:     	incq	(%rax)
180001f88:     	movq	0x3251(%rip), %rax      # 0x1800051e0
180001f8f:     	retq
180001f90:     	subq	$0x28, %rsp
180001f94:     	movq	0x10(%rcx), %rcx
180001f98:     	callq	0x180003290 <numba_list_iter_next+0x1d0>
180001f9d:     	movq	0x323c(%rip), %rax      # 0x1800051e0
180001fa4:     	addq	$0x28, %rsp
180001fa8:     	retq
180001fa9:     	int3
180001faa:     	int3
180001fab:     	int3
180001fac:     	int3
180001fad:     	int3
180001fae:     	int3
180001faf:     	int3
180001fb0:     	movq	0x10(%rcx), %rcx
180001fb4:     	movq	0x18(%rcx), %rcx
180001fb8:     	jmpq	*0x3191(%rip)           # 0x180005150
180001fbf:     	int3
180001fc0:     	subq	$0x28, %rsp
180001fc4:     	movq	0x10(%rcx), %rax
180001fc8:     	testq	%rax, %rax
180001fcb:     	je	0x180001fe9 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x6f9>
180001fcd:     	cmpq	$0x0, 0x18(%rax)
180001fd2:     	je	0x180001fe9 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x6f9>
180001fd4:     	movq	(%rax), %rcx
180001fd7:     	nop
180001fd8:     	cmpq	$-0x1, %rcx
180001fdc:     	je	0x180001fe9 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x6f9>
180001fde:     	addq	$0x28, %rsp
180001fe2:     	jmpq	*0x311f(%rip)           # 0x180005108
180001fe9:     	movq	0x31e0(%rip), %rcx      # 0x1800051d0
180001ff0:     	leaq	0x39d1(%rip), %rdx      # 0x1800059c8
180001ff7:     	movq	(%rcx), %rcx
180001ffa:     	callq	*0x3230(%rip)           # 0x180005230
180002000:     	xorl	%eax, %eax
180002002:     	addq	$0x28, %rsp
180002006:     	retq
180002007:     	int3
180002008:     	int3
180002009:     	int3
18000200a:     	int3
18000200b:     	int3
18000200c:     	int3
18000200d:     	int3
18000200e:     	int3
18000200f:     	int3
180002010:     	movq	0x10(%rcx), %rcx
180002014:     	movq	0x28(%rcx), %rcx
180002018:     	jmpq	*0x3131(%rip)           # 0x180005150
18000201f:     	int3
180002020:     	movq	0x10(%rcx), %rax
180002024:     	movq	0x10(%rax), %rax
180002028:     	testq	%rax, %rax
18000202b:     	je	0x18000203c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x74c>
18000202d:     	movl	(%rax), %ecx
18000202f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180002035:     	jae	0x18000205a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x76a>
180002037:     	incl	%ecx
180002039:     	movl	%ecx, (%rax)
18000203b:     	retq
18000203c:     	movq	0x319d(%rip), %rcx      # 0x1800051e0
180002043:     	movl	(%rcx), %eax
180002045:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000204a:     	jae	0x180002057 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x767>
18000204c:     	incl	%eax
18000204e:     	movl	%eax, (%rcx)
180002050:     	movq	0x3189(%rip), %rcx      # 0x1800051e0
180002057:     	movq	%rcx, %rax
18000205a:     	retq
18000205b:     	int3
18000205c:     	int3
18000205d:     	int3
18000205e:     	int3
18000205f:     	int3
180002060:     	pushq	%rbx
180002062:     	subq	$0x20, %rsp
180002066:     	movq	%rcx, %rbx
180002069:     	movq	0x10(%rcx), %rcx
18000206d:     	callq	0x180003290 <numba_list_iter_next+0x1d0>
180002072:     	movq	0x8(%rbx), %rax
180002076:     	movq	%rbx, %rcx
180002079:     	addq	$0x20, %rsp
18000207d:     	popq	%rbx
18000207e:     	jmpq	*0x140(%rax)
180002085:     	int3
180002086:     	int3
180002087:     	int3
180002088:     	int3
180002089:     	int3
18000208a:     	int3
18000208b:     	int3
18000208c:     	int3
18000208d:     	int3
18000208e:     	int3
18000208f:     	int3
180002090:     	movq	%rdi, 0x18(%rsp)
180002095:     	pushq	%r14
180002097:     	subq	$0x20, %rsp
18000209b:     	movq	0x9b9e(%rip), %rax      # 0x18000bc40
1800020a2:     	movq	%rdx, %r14
1800020a5:     	movq	%rcx, %rdi
1800020a8:     	movq	0x8(%rcx), %rcx
1800020ac:     	movq	0x10(%rax), %rdx
1800020b0:     	cmpq	%rdx, %rcx
1800020b3:     	je	0x1800020d0 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7e0>
1800020b5:     	callq	*0x30fd(%rip)           # 0x1800051b8
1800020bb:     	testl	%eax, %eax
1800020bd:     	jne	0x1800020d0 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x7e0>
1800020bf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800020c4:     	movq	0x40(%rsp), %rdi
1800020c9:     	addq	$0x20, %rsp
1800020cd:     	popq	%r14
1800020cf:     	retq
1800020d0:     	movq	%rbx, 0x30(%rsp)
1800020d5:     	movq	%rdi, %rdx
1800020d8:     	movq	0x10(%rdi), %rbx
1800020dc:     	movq	%rbx, %rcx
1800020df:     	movq	%rsi, 0x38(%rsp)
1800020e4:     	movl	0x18(%rdi), %esi
1800020e7:     	callq	0x180001e40 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x550>
1800020ec:     	movq	%rax, (%r14)
1800020ef:     	movq	0x9b4a(%rip), %rax      # 0x18000bc40
1800020f6:     	movq	%rbx, 0x20(%r14)
1800020fa:     	movl	0x18(%rdi), %edx
1800020fd:     	movq	0x20(%rdi), %rcx
180002101:     	callq	*0x4f0(%rax)
180002107:     	cmpl	$0x12, 0x9b3e(%rip)     # 0x18000bc4c
18000210e:     	movq	0x30(%rsp), %rbx
180002113:     	movq	%rax, 0x10(%r14)
180002117:     	movq	0x38(%rdi), %rax
18000211b:     	jl	0x180002123 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x833>
18000211d:     	movq	0x28(%rax), %rax
180002121:     	jmp	0x180002127 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x837>
180002123:     	movslq	0x20(%rax), %rax
180002127:     	xorl	%r8d, %r8d
18000212a:     	movq	%rax, 0x18(%r14)
18000212e:     	movq	%rdi, 0x8(%r14)
180002132:     	leaq	0x28(%r14), %rax
180002136:     	testl	%esi, %esi
180002138:     	jle	0x18000217b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x88b>
18000213a:     	nopw	(%rax,%rax)
180002140:     	movq	0x20(%rdi), %rcx
180002144:     	movq	(%rcx,%r8,8), %rdx
180002148:     	incl	%r8d
18000214b:     	movq	%rdx, (%rax)
18000214e:     	addq	$0x8, %rax
180002152:     	cmpl	%esi, %r8d
180002155:     	jl	0x180002140 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x850>
180002157:     	xorl	%r8d, %r8d
18000215a:     	nopw	(%rax,%rax)
180002160:     	movq	0x28(%rdi), %rcx
180002164:     	leaq	0x8(%rax), %rax
180002168:     	movslq	%r8d, %rdx
18000216b:     	incl	%r8d
18000216e:     	movq	(%rcx,%rdx,8), %rdx
180002172:     	movq	%rdx, -0x8(%rax)
180002176:     	cmpl	%esi, %r8d
180002179:     	jl	0x180002160 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x870>
18000217b:     	movq	0x38(%rsp), %rsi
180002180:     	xorl	%eax, %eax
180002182:     	movq	0x40(%rsp), %rdi
180002187:     	addq	$0x20, %rsp
18000218b:     	popq	%r14
18000218d:     	retq
18000218e:     	int3
18000218f:     	int3
180002190:     	pushq	%rbx
180002192:     	pushq	%rbp
180002193:     	pushq	%rsi
180002194:     	pushq	%rdi
180002195:     	subq	$0x28, %rsp
180002199:     	cmpq	$0x0, 0x9aaf(%rip)      # 0x18000bc50
1800021a1:     	movq	%rcx, %rbp
1800021a4:     	movslq	0x8(%rdx), %rdi
1800021a8:     	movq	(%rdx), %rsi
1800021ab:     	jne	0x180002203 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x913>
1800021ad:     	leaq	0x3754(%rip), %rcx      # 0x180005908
1800021b4:     	callq	*0x304e(%rip)           # 0x180005208
1800021ba:     	movq	%rax, %rbx
1800021bd:     	testq	%rax, %rax
1800021c0:     	je	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
1800021c6:     	leaq	0x3743(%rip), %rdx      # 0x180005910
1800021cd:     	movq	%rax, %rcx
1800021d0:     	callq	*0x2f8a(%rip)           # 0x180005160
1800021d6:     	movl	(%rbx), %edx
1800021d8:     	movq	%rax, 0x9a71(%rip)      # 0x18000bc50
1800021df:     	testl	%edx, %edx
1800021e1:     	js	0x1800021fa <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x90a>
1800021e3:     	subl	$0x1, %edx
1800021e6:     	movl	%edx, (%rbx)
1800021e8:     	jne	0x1800021fa <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x90a>
1800021ea:     	movq	%rbx, %rcx
1800021ed:     	callq	*0x2fbd(%rip)           # 0x1800051b0
1800021f3:     	movq	0x9a56(%rip), %rax      # 0x18000bc50
1800021fa:     	testq	%rax, %rax
1800021fd:     	je	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
180002203:     	movq	%rdi, %rdx
180002206:     	movq	%rsi, %rcx
180002209:     	callq	*0x2f11(%rip)           # 0x180005120
18000220f:     	movq	%rax, %rdi
180002212:     	testq	%rax, %rax
180002215:     	je	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
180002217:     	movq	0x9a32(%rip), %rcx      # 0x18000bc50
18000221e:     	xorl	%r8d, %r8d
180002221:     	movq	%rax, %rdx
180002224:     	callq	*0x2f5e(%rip)           # 0x180005188
18000222a:     	movl	(%rdi), %ecx
18000222c:     	movq	%rax, %rbx
18000222f:     	testl	%ecx, %ecx
180002231:     	js	0x180002243 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x953>
180002233:     	subl	$0x1, %ecx
180002236:     	movl	%ecx, (%rdi)
180002238:     	jne	0x180002243 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x953>
18000223a:     	movq	%rdi, %rcx
18000223d:     	callq	*0x2f6d(%rip)           # 0x1800051b0
180002243:     	testq	%rbx, %rbx
180002246:     	je	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
180002248:     	movq	0x8(%rbx), %r8
18000224c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180002257:     	jne	0x180002295 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x9a5>
180002259:     	movq	0x2fc8(%rip), %rcx      # 0x180005228
180002260:     	leaq	0x3869(%rip), %rdx      # 0x180005ad0
180002267:     	movq	0x18(%r8), %r8
18000226b:     	movq	(%rcx), %rcx
18000226e:     	callq	*0x2f54(%rip)           # 0x1800051c8
180002274:     	movl	(%rbx), %eax
180002276:     	testl	%eax, %eax
180002278:     	js	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
18000227a:     	subl	$0x1, %eax
18000227d:     	movl	%eax, (%rbx)
18000227f:     	jne	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
180002281:     	movq	%rbx, %rcx
180002284:     	callq	*0x2f26(%rip)           # 0x1800051b0
18000228a:     	xorl	%eax, %eax
18000228c:     	addq	$0x28, %rsp
180002290:     	popq	%rdi
180002291:     	popq	%rsi
180002292:     	popq	%rbp
180002293:     	popq	%rbx
180002294:     	retq
180002295:     	xorl	%r8d, %r8d
180002298:     	leaq	0x9061(%rip), %rcx      # 0x18000b300
18000229f:     	xorl	%edx, %edx
1800022a1:     	callq	*0x2f69(%rip)           # 0x180005210
1800022a7:     	movq	%rax, %rdi
1800022aa:     	testq	%rax, %rax
1800022ad:     	je	0x180002274 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x984>
1800022af:     	movq	%rbp, %rcx
1800022b2:     	movq	%rbx, 0x18(%rax)
1800022b6:     	callq	*0x2eec(%rip)           # 0x1800051a8
1800022bc:     	movq	%rax, 0x10(%rdi)
1800022c0:     	movq	%rax, %rcx
1800022c3:     	testq	%rax, %rax
1800022c6:     	jne	0x1800022da <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x9ea>
1800022c8:     	movl	(%rdi), %eax
1800022ca:     	testl	%eax, %eax
1800022cc:     	js	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
1800022ce:     	subl	$0x1, %eax
1800022d1:     	movl	%eax, (%rdi)
1800022d3:     	jne	0x18000228a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x99a>
1800022d5:     	movq	%rdi, %rcx
1800022d8:     	jmp	0x180002284 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x994>
1800022da:     	movl	(%rax), %eax
1800022dc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800022e1:     	jae	0x1800022e7 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x9f7>
1800022e3:     	incl	%eax
1800022e5:     	movl	%eax, (%rcx)
1800022e7:     	movq	%rdi, %rax
1800022ea:     	addq	$0x28, %rsp
1800022ee:     	popq	%rdi
1800022ef:     	popq	%rsi
1800022f0:     	popq	%rbp
1800022f1:     	popq	%rbx
1800022f2:     	retq
1800022f3:     	int3
1800022f4:     	int3
1800022f5:     	int3
1800022f6:     	int3
1800022f7:     	int3
1800022f8:     	int3
1800022f9:     	int3
1800022fa:     	int3
1800022fb:     	int3
1800022fc:     	int3
1800022fd:     	int3
1800022fe:     	int3
1800022ff:     	int3
180002300:     	movq	%r9, 0x20(%rsp)
180002305:     	movq	%r8, 0x18(%rsp)
18000230a:     	movq	%rdx, 0x10(%rsp)
18000230f:     	movq	%rcx, 0x8(%rsp)
180002314:     	pushq	%rbx
180002315:     	pushq	%rbp
180002316:     	pushq	%rsi
180002317:     	pushq	%rdi
180002318:     	pushq	%r12
18000231a:     	pushq	%r13
18000231c:     	pushq	%r14
18000231e:     	pushq	%r15
180002320:     	subq	$0x68, %rsp
180002324:     	movq	%rcx, %r14
180002327:     	movq	%r9, %r15
18000232a:     	leaq	0x32df(%rip), %rcx      # 0x180005610
180002331:     	movq	%r8, %r13
180002334:     	movq	%rdx, %rsi
180002337:     	callq	*0x2ecb(%rip)           # 0x180005208
18000233d:     	movq	%rax, %rdi
180002340:     	testq	%rax, %rax
180002343:     	jne	0x18000237c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xa8c>
180002345:     	movq	0x2dc4(%rip), %rcx      # 0x180005110
18000234c:     	movq	(%rcx), %rcx
18000234f:     	callq	*0x2e43(%rip)           # 0x180005198
180002355:     	testl	%eax, %eax
180002357:     	je	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
18000235d:     	callq	*0x2df5(%rip)           # 0x180005158
180002363:     	leaq	0x32c6(%rip), %rcx      # 0x180005630
18000236a:     	callq	*0x2e98(%rip)           # 0x180005208
180002370:     	movq	%rax, %rdi
180002373:     	testq	%rax, %rax
180002376:     	je	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
18000237c:     	leaq	0x32cd(%rip), %rdx      # 0x180005650
180002383:     	movq	%rdi, %rcx
180002386:     	callq	*0x2dd4(%rip)           # 0x180005160
18000238c:     	movl	(%rdi), %ecx
18000238e:     	movq	%rax, %rbx
180002391:     	testl	%ecx, %ecx
180002393:     	js	0x1800023a5 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xab5>
180002395:     	subl	$0x1, %ecx
180002398:     	movl	%ecx, (%rdi)
18000239a:     	jne	0x1800023a5 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xab5>
18000239c:     	movq	%rdi, %rcx
18000239f:     	callq	*0x2e0b(%rip)           # 0x1800051b0
1800023a5:     	testq	%rbx, %rbx
1800023a8:     	je	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
1800023ae:     	movq	0x2d33(%rip), %rax      # 0x1800050e8
1800023b5:     	cmpq	%rax, 0x8(%rbx)
1800023b9:     	je	0x1800023f5 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb05>
1800023bb:     	movq	0x2e76(%rip), %rcx      # 0x180005238
1800023c2:     	leaq	0x3297(%rip), %rdx      # 0x180005660
1800023c9:     	movq	(%rcx), %rcx
1800023cc:     	callq	*0x2e5e(%rip)           # 0x180005230
1800023d2:     	movl	(%rbx), %eax
1800023d4:     	testl	%eax, %eax
1800023d6:     	js	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
1800023dc:     	subl	$0x1, %eax
1800023df:     	movl	%eax, (%rbx)
1800023e1:     	jne	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
1800023e7:     	movq	%rbx, %rcx
1800023ea:     	callq	*0x2dc0(%rip)           # 0x1800051b0
1800023f0:     	jmp	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
1800023f5:     	xorl	%edx, %edx
1800023f7:     	movq	%rbx, %rcx
1800023fa:     	callq	*0x2d90(%rip)           # 0x180005190
180002400:     	movl	(%rbx), %ecx
180002402:     	movq	%rax, 0x9837(%rip)      # 0x18000bc40
180002409:     	testl	%ecx, %ecx
18000240b:     	js	0x180002424 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb34>
18000240d:     	subl	$0x1, %ecx
180002410:     	movl	%ecx, (%rbx)
180002412:     	jne	0x180002424 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb34>
180002414:     	movq	%rbx, %rcx
180002417:     	callq	*0x2d93(%rip)           # 0x1800051b0
18000241d:     	movq	0x981c(%rip), %rax      # 0x18000bc40
180002424:     	testq	%rax, %rax
180002427:     	jne	0x180002442 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb52>
180002429:     	leaq	0x3258(%rip), %rdx      # 0x180005688
180002430:     	movq	0x2e01(%rip), %rcx      # 0x180005238
180002437:     	movq	(%rcx), %rcx
18000243a:     	callq	*0x2df0(%rip)           # 0x180005230
180002440:     	jmp	0x180002477 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb87>
180002442:     	callq	*(%rax)
180002444:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180002449:     	jbe	0x1800024aa <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xbba>
18000244b:     	movq	0x2de6(%rip), %rax      # 0x180005238
180002452:     	movq	(%rax), %rbx
180002455:     	movq	0x97e4(%rip), %rax      # 0x18000bc40
18000245c:     	callq	*(%rax)
18000245e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002464:     	leaq	0x3245(%rip), %rdx      # 0x1800056b0
18000246b:     	movl	%eax, %r9d
18000246e:     	movq	%rbx, %rcx
180002471:     	callq	*0x2d51(%rip)           # 0x1800051c8
180002477:     	callq	*0x2deb(%rip)           # 0x180005268
18000247d:     	movq	0x2c74(%rip), %rcx      # 0x1800050f8
180002484:     	leaq	0x344d(%rip), %rdx      # 0x1800058d8
18000248b:     	movq	(%rcx), %rcx
18000248e:     	callq	*0x2d9c(%rip)           # 0x180005230
180002494:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002499:     	addq	$0x68, %rsp
18000249d:     	popq	%r15
18000249f:     	popq	%r14
1800024a1:     	popq	%r13
1800024a3:     	popq	%r12
1800024a5:     	popq	%rdi
1800024a6:     	popq	%rsi
1800024a7:     	popq	%rbp
1800024a8:     	popq	%rbx
1800024a9:     	retq
1800024aa:     	movq	0x978f(%rip), %rax      # 0x18000bc40
1800024b1:     	callq	*0x698(%rax)
1800024b7:     	movl	%eax, 0x978f(%rip)      # 0x18000bc4c
1800024bd:     	cmpl	$0x10, %eax
1800024c0:     	jge	0x1800024de <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xbee>
1800024c2:     	movq	0x2d6f(%rip), %rcx      # 0x180005238
1800024c9:     	leaq	0x3230(%rip), %rdx      # 0x180005700
1800024d0:     	movl	%eax, %r9d
1800024d3:     	movl	$0x10, %r8d
1800024d9:     	movq	(%rcx), %rcx
1800024dc:     	jmp	0x180002471 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb81>
1800024de:     	movq	0x975b(%rip), %rax      # 0x18000bc40
1800024e5:     	callq	*0x690(%rax)
1800024eb:     	testl	%eax, %eax
1800024ed:     	jne	0x1800024fb <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xc0b>
1800024ef:     	leaq	0x335a(%rip), %rdx      # 0x180005850
1800024f6:     	jmp	0x180002430 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb40>
1800024fb:     	cmpl	$0x1, %eax
1800024fe:     	je	0x18000250c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xc1c>
180002500:     	leaq	0x3379(%rip), %rdx      # 0x180005880
180002507:     	jmp	0x180002430 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xb40>
18000250c:     	leaq	0x92cd(%rip), %rcx      # 0x18000b7e0
180002513:     	callq	*0x2c4f(%rip)           # 0x180005168
180002519:     	testl	%eax, %eax
18000251b:     	jne	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
180002521:     	leaq	0x8dd8(%rip), %rcx      # 0x18000b300
180002528:     	callq	*0x2c3a(%rip)           # 0x180005168
18000252e:     	testl	%eax, %eax
180002530:     	jne	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
180002536:     	leaq	0x9103(%rip), %rcx      # 0x18000b640
18000253d:     	callq	*0x2c25(%rip)           # 0x180005168
180002543:     	testl	%eax, %eax
180002545:     	jne	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
18000254b:     	xorl	%ebx, %ebx
18000254d:     	cmpl	%ebx, 0x96f5(%rip)      # 0x18000bc48
180002553:     	jne	0x180002596 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xca6>
180002555:     	movq	%gs:0x58, %rax
18000255e:     	movl	0x96f4(%rip), %ecx      # 0x18000bc58
180002564:     	movl	$0x1, 0x96da(%rip)      # 0x18000bc48
18000256e:     	movq	(%rax,%rcx,8), %rdx
180002572:     	movl	$0x10, %eax
180002577:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000257e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002583:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000258a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000258f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180002596:     	movl	%ebx, 0x965c(%rip)      # 0x18000bbf8
18000259c:     	movq	%rbx, %rax
18000259f:     	movb	%bl, 0x965b(%rip)       # 0x18000bc00
1800025a5:     	movq	%rbx, %rcx
1800025a8:     	xchgq	%rax, 0x9659(%rip)      # 0x18000bc08
1800025af:     	xchgq	%rcx, 0x965a(%rip)      # 0x18000bc10
1800025b6:     	movq	%rbx, %rax
1800025b9:     	movq	%rbx, %rcx
1800025bc:     	xchgq	%rax, 0x9655(%rip)      # 0x18000bc18
1800025c3:     	xchgq	%rcx, 0x9656(%rip)      # 0x18000bc20
1800025ca:     	movq	0x2a8f(%rip), %rax      # 0x180005060
1800025d1:     	leaq	0x8ec8(%rip), %rcx      # 0x18000b4a0
1800025d8:     	movq	%rax, 0x9649(%rip)      # 0x18000bc28
1800025df:     	movq	0x2a8a(%rip), %rax      # 0x180005070
1800025e6:     	movq	%rax, 0x9643(%rip)      # 0x18000bc30
1800025ed:     	movq	0x2a74(%rip), %rax      # 0x180005068
1800025f4:     	movq	%rax, 0x963d(%rip)      # 0x18000bc38
1800025fb:     	movq	0x2c0e(%rip), %rax      # 0x180005210
180002602:     	movq	%rax, 0x8fcf(%rip)      # 0x18000b5d8
180002609:     	callq	*0x2b59(%rip)           # 0x180005168
18000260f:     	testl	%eax, %eax
180002611:     	jne	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
180002617:     	leaq	0x334a(%rip), %rdx      # 0x180005968
18000261e:     	movq	%r14, %rcx
180002621:     	callq	*0x2b39(%rip)           # 0x180005160
180002627:     	movq	%rax, 0x28(%rsp)
18000262c:     	movq	%rax, %rdi
18000262f:     	testq	%rax, %rax
180002632:     	je	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
180002638:     	leaq	0x34c2(%rip), %rcx      # 0x180005b01
18000263f:     	callq	*0x2abb(%rip)           # 0x180005100
180002645:     	movq	%rax, 0x20(%rsp)
18000264a:     	movq	%rax, %r12
18000264d:     	testq	%rax, %rax
180002650:     	je	0x180002994 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x10a4>
180002656:     	movl	%ebx, %ebp
180002658:     	cmpq	%rbx, (%rsi)
18000265b:     	je	0x180002804 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xf14>
180002661:     	movslq	%ebp, %rbx
180002664:     	leaq	0x30(%rsp), %rdx
180002669:     	movq	%r14, %rcx
18000266c:     	leaq	(%rbx,%rbx,4), %rax
180002670:     	movups	(%r13,%rax,8), %xmm0
180002676:     	movups	0x10(%r13,%rax,8), %xmm1
18000267c:     	movaps	%xmm0, 0x30(%rsp)
180002681:     	movsd	0x20(%r13,%rax,8), %xmm0
180002688:     	movsd	%xmm0, 0x50(%rsp)
18000268e:     	movaps	%xmm1, 0x40(%rsp)
180002693:     	callq	0x180002190 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x8a0>
180002698:     	movq	%rax, %r14
18000269b:     	testq	%rax, %rax
18000269e:     	je	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
1800026a4:     	movq	(%rsi), %rcx
1800026a7:     	callq	*0x2a53(%rip)           # 0x180005100
1800026ad:     	movq	%rax, %r13
1800026b0:     	testq	%rax, %rax
1800026b3:     	je	0x1800029b7 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x10c7>
1800026b9:     	movq	(%r15,%rbx,8), %rcx
1800026bd:     	xorl	%edx, %edx
1800026bf:     	movq	%r14, (%rcx)
1800026c2:     	leaq	0x9117(%rip), %rcx      # 0x18000b7e0
1800026c9:     	movq	0x8(%rsi), %r12
1800026cd:     	callq	*0x2a75(%rip)           # 0x180005148
1800026d3:     	movq	%rax, %rbx
1800026d6:     	testq	%rax, %rax
1800026d9:     	je	0x180002756 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe66>
1800026db:     	movq	%r13, %rcx
1800026de:     	callq	*0x2a94(%rip)           # 0x180005178
1800026e4:     	movq	%rax, %rdi
1800026e7:     	testq	%rax, %rax
1800026ea:     	je	0x18000270c <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe1c>
1800026ec:     	movq	%rax, %rcx
1800026ef:     	callq	0x180003f45 <numba_list_iter_next+0xe85>
1800026f4:     	leaq	0x1(%rax), %rcx
1800026f8:     	callq	*0x2b1a(%rip)           # 0x180005218
1800026fe:     	movq	%rax, %rsi
180002701:     	testq	%rax, %rax
180002704:     	jne	0x180002714 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe24>
180002706:     	callq	*0x2a2c(%rip)           # 0x180005138
18000270c:     	xorl	%eax, %eax
18000270e:     	movq	%rax, 0x20(%rbx)
180002712:     	jmp	0x180002745 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe55>
180002714:     	movq	%rdi, %rdx
180002717:     	movq	%rsi, %rcx
18000271a:     	callq	0x180003f3f <numba_list_iter_next+0xe7f>
18000271f:     	movq	0x20(%rsp), %rcx
180002724:     	movq	%rsi, 0x20(%rbx)
180002728:     	movq	%r12, 0x28(%rbx)
18000272c:     	movl	$0x3, 0x30(%rbx)
180002733:     	callq	0x180001c10 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x320>
180002738:     	movq	%rax, 0x38(%rbx)
18000273c:     	testq	%rax, %rax
18000273f:     	jne	0x1800028b0 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfc0>
180002745:     	movl	(%rbx), %eax
180002747:     	testl	%eax, %eax
180002749:     	js	0x180002756 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe66>
18000274b:     	subl	$0x1, %eax
18000274e:     	movl	%eax, (%rbx)
180002750:     	je	0x1800028fd <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x100d>
180002756:     	xorl	%edi, %edi
180002758:     	movl	(%r14), %eax
18000275b:     	testl	%eax, %eax
18000275d:     	js	0x180002770 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe80>
18000275f:     	subl	$0x1, %eax
180002762:     	movl	%eax, (%r14)
180002765:     	jne	0x180002770 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe80>
180002767:     	movq	%r14, %rcx
18000276a:     	callq	*0x2a40(%rip)           # 0x1800051b0
180002770:     	movl	(%r13), %eax
180002774:     	testl	%eax, %eax
180002776:     	js	0x18000278a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe9a>
180002778:     	subl	$0x1, %eax
18000277b:     	movl	%eax, (%r13)
18000277f:     	jne	0x18000278a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe9a>
180002781:     	movq	%r13, %rcx
180002784:     	callq	*0x2a26(%rip)           # 0x1800051b0
18000278a:     	testq	%rdi, %rdi
18000278d:     	je	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
180002793:     	movq	0xb8(%rsp), %rsi
18000279b:     	movq	%rdi, %r8
18000279e:     	movq	0xb0(%rsp), %r14
1800027a6:     	movq	%r14, %rcx
1800027a9:     	movq	(%rsi), %rdx
1800027ac:     	callq	*0x2a46(%rip)           # 0x1800051f8
1800027b2:     	movl	(%rdi), %ecx
1800027b4:     	testl	%eax, %eax
1800027b6:     	jne	0x18000295a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x106a>
1800027bc:     	testl	%ecx, %ecx
1800027be:     	js	0x1800027d2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xee2>
1800027c0:     	leal	-0x1(%rcx), %eax
1800027c3:     	movl	%eax, (%rdi)
1800027c5:     	testl	%eax, %eax
1800027c7:     	jne	0x1800027d2 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xee2>
1800027c9:     	movq	%rdi, %rcx
1800027cc:     	callq	*0x29de(%rip)           # 0x1800051b0
1800027d2:     	movq	0xc8(%rsp), %r15
1800027da:     	addq	$0x20, %rsi
1800027de:     	movq	0xc0(%rsp), %r13
1800027e6:     	incl	%ebp
1800027e8:     	movq	%rsi, 0xb8(%rsp)
1800027f0:     	cmpq	$0x0, (%rsi)
1800027f4:     	jne	0x180002661 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xd71>
1800027fa:     	movq	0x20(%rsp), %r12
1800027ff:     	movq	0x28(%rsp), %rdi
180002804:     	movslq	%ebp, %rax
180002807:     	cmpq	$0x0, (%r15,%rax,8)
18000280c:     	je	0x180002879 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xf89>
18000280e:     	nop
180002810:     	movslq	%ebp, %rbx
180002813:     	leaq	0x30(%rsp), %rdx
180002818:     	movq	%r14, %rcx
18000281b:     	leaq	(%rbx,%rbx,4), %rax
18000281f:     	movups	(%r13,%rax,8), %xmm0
180002825:     	movups	0x10(%r13,%rax,8), %xmm1
18000282b:     	movaps	%xmm0, 0x30(%rsp)
180002830:     	movsd	0x20(%r13,%rax,8), %xmm0
180002837:     	movsd	%xmm0, 0x50(%rsp)
18000283d:     	movaps	%xmm1, 0x40(%rsp)
180002842:     	callq	0x180002190 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x8a0>
180002847:     	testq	%rax, %rax
18000284a:     	je	0x180002975 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1085>
180002850:     	movq	(%r15,%rbx,8), %rcx
180002854:     	movq	%rax, (%rcx)
180002857:     	movl	(%rax), %ecx
180002859:     	testl	%ecx, %ecx
18000285b:     	js	0x18000286d <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xf7d>
18000285d:     	subl	$0x1, %ecx
180002860:     	movl	%ecx, (%rax)
180002862:     	jne	0x18000286d <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xf7d>
180002864:     	movq	%rax, %rcx
180002867:     	callq	*0x2943(%rip)           # 0x1800051b0
18000286d:     	incl	%ebp
18000286f:     	movslq	%ebp, %rax
180002872:     	cmpq	$0x0, (%r15,%rax,8)
180002877:     	jne	0x180002810 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xf20>
180002879:     	movl	(%r12), %eax
18000287d:     	testl	%eax, %eax
18000287f:     	js	0x180002893 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfa3>
180002881:     	subl	$0x1, %eax
180002884:     	movl	%eax, (%r12)
180002888:     	jne	0x180002893 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfa3>
18000288a:     	movq	%r12, %rcx
18000288d:     	callq	*0x291d(%rip)           # 0x1800051b0
180002893:     	movl	(%rdi), %eax
180002895:     	testl	%eax, %eax
180002897:     	js	0x1800028a9 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfb9>
180002899:     	subl	$0x1, %eax
18000289c:     	movl	%eax, (%rdi)
18000289e:     	jne	0x1800028a9 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfb9>
1800028a0:     	movq	%rdi, %rcx
1800028a3:     	callq	*0x2907(%rip)           # 0x1800051b0
1800028a9:     	xorl	%eax, %eax
1800028ab:     	jmp	0x180002499 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba9>
1800028b0:     	movl	(%r14), %eax
1800028b3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800028b8:     	jae	0x1800028bf <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xfcf>
1800028ba:     	incl	%eax
1800028bc:     	movl	%eax, (%r14)
1800028bf:     	movq	0xb0(%rsp), %rcx
1800028c7:     	leaq	0x309a(%rip), %rdx      # 0x180005968
1800028ce:     	movq	%r14, 0x18(%rbx)
1800028d2:     	movq	$0x0, 0x40(%rbx)
1800028da:     	callq	*0x2880(%rip)           # 0x180005160
1800028e0:     	movq	%rax, %rsi
1800028e3:     	testq	%rax, %rax
1800028e6:     	jne	0x18000290b <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x101b>
1800028e8:     	movl	(%rbx), %eax
1800028ea:     	testl	%eax, %eax
1800028ec:     	js	0x180002756 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe66>
1800028f2:     	subl	$0x1, %eax
1800028f5:     	movl	%eax, (%rbx)
1800028f7:     	jne	0x180002756 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe66>
1800028fd:     	movq	%rbx, %rcx
180002900:     	callq	*0x28aa(%rip)           # 0x1800051b0
180002906:     	jmp	0x180002756 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe66>
18000290b:     	xorl	%r9d, %r9d
18000290e:     	leaq	0x20(%rbx), %rcx
180002912:     	movq	%rsi, %r8
180002915:     	movq	%rbx, %rdx
180002918:     	callq	*0x2822(%rip)           # 0x180005140
18000291e:     	movq	%rax, %rdi
180002921:     	movl	(%rbx), %eax
180002923:     	testl	%eax, %eax
180002925:     	js	0x180002937 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1047>
180002927:     	subl	$0x1, %eax
18000292a:     	movl	%eax, (%rbx)
18000292c:     	jne	0x180002937 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1047>
18000292e:     	movq	%rbx, %rcx
180002931:     	callq	*0x2879(%rip)           # 0x1800051b0
180002937:     	movl	(%rsi), %eax
180002939:     	testl	%eax, %eax
18000293b:     	js	0x180002758 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe68>
180002941:     	subl	$0x1, %eax
180002944:     	movl	%eax, (%rsi)
180002946:     	jne	0x180002758 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe68>
18000294c:     	movq	%rsi, %rcx
18000294f:     	callq	*0x285b(%rip)           # 0x1800051b0
180002955:     	jmp	0x180002758 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xe68>
18000295a:     	testl	%ecx, %ecx
18000295c:     	js	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
18000295e:     	leal	-0x1(%rcx), %eax
180002961:     	movl	%eax, (%rdi)
180002963:     	testl	%eax, %eax
180002965:     	jne	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
180002967:     	movq	%rdi, %rcx
18000296a:     	callq	*0x2840(%rip)           # 0x1800051b0
180002970:     	movq	0x20(%rsp), %r12
180002975:     	movl	(%r12), %eax
180002979:     	testl	%eax, %eax
18000297b:     	js	0x18000298f <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x109f>
18000297d:     	subl	$0x1, %eax
180002980:     	movl	%eax, (%r12)
180002984:     	jne	0x18000298f <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x109f>
180002986:     	movq	%r12, %rcx
180002989:     	callq	*0x2821(%rip)           # 0x1800051b0
18000298f:     	movq	0x28(%rsp), %rdi
180002994:     	movl	(%rdi), %eax
180002996:     	testl	%eax, %eax
180002998:     	js	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
18000299e:     	subl	$0x1, %eax
1800029a1:     	movl	%eax, (%rdi)
1800029a3:     	jne	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
1800029a9:     	movq	%rdi, %rcx
1800029ac:     	callq	*0x27fe(%rip)           # 0x1800051b0
1800029b2:     	jmp	0x180002494 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0xba4>
1800029b7:     	movl	(%r14), %eax
1800029ba:     	testl	%eax, %eax
1800029bc:     	js	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
1800029be:     	subl	$0x1, %eax
1800029c1:     	movl	%eax, (%r14)
1800029c4:     	jne	0x180002970 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x1080>
1800029c6:     	movq	%r14, %rcx
1800029c9:     	jmp	0x18000296a <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x107a>
1800029cb:     	int3
1800029cc:     	int3
1800029cd:     	int3
1800029ce:     	int3
1800029cf:     	int3
1800029d0:     	leaq	0x9299(%rip), %rax      # 0x18000bc70
1800029d7:     	retq
1800029d8:     	int3
1800029d9:     	int3
1800029da:     	int3
1800029db:     	int3
1800029dc:     	int3
1800029dd:     	int3
1800029de:     	int3
1800029df:     	int3

00000001800029e0 <numba_list_set_method_table>:
1800029e0:     	movups	(%rdx), %xmm0
1800029e3:     	movups	%xmm0, 0x20(%rcx)
1800029e7:     	retq
1800029e8:     	int3
1800029e9:     	int3
1800029ea:     	int3
1800029eb:     	int3
1800029ec:     	int3
1800029ed:     	int3
1800029ee:     	int3
1800029ef:     	int3

00000001800029f0 <numba_list_new>:
1800029f0:     	pushq	%rbx
1800029f2:     	pushq	%rbp
1800029f3:     	pushq	%rsi
1800029f4:     	pushq	%rdi
1800029f5:     	subq	$0x28, %rsp
1800029f9:     	movq	%rcx, %rsi
1800029fc:     	movq	%r8, %rdi
1800029ff:     	movl	$0x38, %ecx
180002a04:     	movq	%rdx, %rbp
180002a07:     	callq	*0x2653(%rip)           # 0x180005060
180002a0d:     	movq	%rax, %rbx
180002a10:     	testq	%rax, %rax
180002a13:     	je	0x180002a7d <numba_list_new+0x8d>
180002a15:     	movq	$0x0, (%rax)
180002a1c:     	xorps	%xmm0, %xmm0
180002a1f:     	movq	%rbp, 0x8(%rax)
180002a23:     	movq	%rdi, 0x10(%rax)
180002a27:     	movl	$0x1, 0x18(%rax)
180002a2e:     	movups	%xmm0, 0x20(%rax)
180002a32:     	testq	%rdi, %rdi
180002a35:     	je	0x180002a8b <numba_list_new+0x9b>
180002a37:     	imulq	%rbp, %rdi
180002a3b:     	movl	$0x8, %ecx
180002a40:     	movq	%rdi, %rax
180002a43:     	cqto
180002a45:     	andl	$0x7, %edx
180002a48:     	addq	%rdx, %rax
180002a4b:     	andl	$0x7, %eax
180002a4e:     	subq	%rdx, %rax
180002a51:     	subq	%rax, %rcx
180002a54:     	movq	%rcx, %rax
180002a57:     	cqto
180002a59:     	andl	$0x7, %edx
180002a5c:     	leaq	(%rdx,%rax), %rcx
180002a60:     	andl	$0x7, %ecx
180002a63:     	subq	%rdx, %rcx
180002a66:     	addq	%rdi, %rcx
180002a69:     	callq	*0x25f1(%rip)           # 0x180005060
180002a6f:     	testq	%rax, %rax
180002a72:     	jne	0x180002a8d <numba_list_new+0x9d>
180002a74:     	movq	%rbx, %rcx
180002a77:     	callq	*0x25eb(%rip)           # 0x180005068
180002a7d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002a82:     	addq	$0x28, %rsp
180002a86:     	popq	%rdi
180002a87:     	popq	%rsi
180002a88:     	popq	%rbp
180002a89:     	popq	%rbx
180002a8a:     	retq
180002a8b:     	xorl	%eax, %eax
180002a8d:     	movq	%rax, 0x30(%rbx)
180002a91:     	xorl	%eax, %eax
180002a93:     	movq	%rbx, (%rsi)
180002a96:     	addq	$0x28, %rsp
180002a9a:     	popq	%rdi
180002a9b:     	popq	%rsi
180002a9c:     	popq	%rbp
180002a9d:     	popq	%rbx
180002a9e:     	retq
180002a9f:     	int3

0000000180002aa0 <numba_list_free>:
180002aa0:     	pushq	%rbx
180002aa2:     	subq	$0x20, %rsp
180002aa6:     	cmpq	$0x0, 0x28(%rcx)
180002aab:     	movq	%rcx, %rbx
180002aae:     	je	0x180002ae4 <numba_list_free+0x44>
180002ab0:     	movq	%rdi, 0x30(%rsp)
180002ab5:     	xorl	%edi, %edi
180002ab7:     	cmpq	%rdi, (%rcx)
180002aba:     	jle	0x180002adf <numba_list_free+0x3f>
180002abc:     	nopl	(%rax)
180002ac0:     	movq	0x28(%rbx), %rax
180002ac4:     	testq	%rax, %rax
180002ac7:     	je	0x180002ad7 <numba_list_free+0x37>
180002ac9:     	movq	%rdi, %rcx
180002acc:     	imulq	0x8(%rbx), %rcx
180002ad1:     	addq	0x30(%rbx), %rcx
180002ad5:     	callq	*%rax
180002ad7:     	incq	%rdi
180002ada:     	cmpq	(%rbx), %rdi
180002add:     	jl	0x180002ac0 <numba_list_free+0x20>
180002adf:     	movq	0x30(%rsp), %rdi
180002ae4:     	movq	0x30(%rbx), %rcx
180002ae8:     	testq	%rcx, %rcx
180002aeb:     	je	0x180002af3 <numba_list_free+0x53>
180002aed:     	callq	*0x2575(%rip)           # 0x180005068
180002af3:     	movq	%rbx, %rcx
180002af6:     	addq	$0x20, %rsp
180002afa:     	popq	%rbx
180002afb:     	jmpq	*0x2566(%rip)           # 0x180005068
180002b02:     	int3
180002b03:     	int3
180002b04:     	int3
180002b05:     	int3
180002b06:     	int3
180002b07:     	int3
180002b08:     	int3
180002b09:     	int3
180002b0a:     	int3
180002b0b:     	int3
180002b0c:     	int3
180002b0d:     	int3
180002b0e:     	int3
180002b0f:     	int3

0000000180002b10 <numba_list_base_ptr>:
180002b10:     	movq	0x30(%rcx), %rax
180002b14:     	retq
180002b15:     	int3
180002b16:     	int3
180002b17:     	int3
180002b18:     	int3
180002b19:     	int3
180002b1a:     	int3
180002b1b:     	int3
180002b1c:     	int3
180002b1d:     	int3
180002b1e:     	int3
180002b1f:     	int3

0000000180002b20 <numba_list_size_address>:
180002b20:     	movq	%rcx, %rax
180002b23:     	retq
180002b24:     	int3
180002b25:     	int3
180002b26:     	int3
180002b27:     	int3
180002b28:     	int3
180002b29:     	int3
180002b2a:     	int3
180002b2b:     	int3
180002b2c:     	int3
180002b2d:     	int3
180002b2e:     	int3
180002b2f:     	int3

0000000180002b30 <numba_list_length>:
180002b30:     	movq	(%rcx), %rax
180002b33:     	retq
180002b34:     	int3
180002b35:     	int3
180002b36:     	int3
180002b37:     	int3
180002b38:     	int3
180002b39:     	int3
180002b3a:     	int3
180002b3b:     	int3
180002b3c:     	int3
180002b3d:     	int3
180002b3e:     	int3
180002b3f:     	int3

0000000180002b40 <numba_list_allocated>:
180002b40:     	movq	0x10(%rcx), %rax
180002b44:     	retq
180002b45:     	int3
180002b46:     	int3
180002b47:     	int3
180002b48:     	int3
180002b49:     	int3
180002b4a:     	int3
180002b4b:     	int3
180002b4c:     	int3
180002b4d:     	int3
180002b4e:     	int3
180002b4f:     	int3

0000000180002b50 <numba_list_is_mutable>:
180002b50:     	movl	0x18(%rcx), %eax
180002b53:     	retq
180002b54:     	int3
180002b55:     	int3
180002b56:     	int3
180002b57:     	int3
180002b58:     	int3
180002b59:     	int3
180002b5a:     	int3
180002b5b:     	int3
180002b5c:     	int3
180002b5d:     	int3
180002b5e:     	int3
180002b5f:     	int3

0000000180002b60 <numba_list_set_is_mutable>:
180002b60:     	movl	%edx, 0x18(%rcx)
180002b63:     	retq
180002b64:     	int3
180002b65:     	int3
180002b66:     	int3
180002b67:     	int3
180002b68:     	int3
180002b69:     	int3
180002b6a:     	int3
180002b6b:     	int3
180002b6c:     	int3
180002b6d:     	int3
180002b6e:     	int3
180002b6f:     	int3

0000000180002b70 <numba_list_setitem>:
180002b70:     	movq	%rbx, 0x10(%rsp)
180002b75:     	pushq	%rsi
180002b76:     	subq	$0x20, %rsp
180002b7a:     	cmpl	$0x0, 0x18(%rcx)
180002b7e:     	movq	%r8, %rsi
180002b81:     	movq	%rcx, %rbx
180002b84:     	jne	0x180002b96 <numba_list_setitem+0x26>
180002b86:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002b8b:     	movq	0x38(%rsp), %rbx
180002b90:     	addq	$0x20, %rsp
180002b94:     	popq	%rsi
180002b95:     	retq
180002b96:     	cmpq	(%rcx), %rdx
180002b99:     	jb	0x180002bab <numba_list_setitem+0x3b>
180002b9b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002ba0:     	movq	0x38(%rsp), %rbx
180002ba5:     	addq	$0x20, %rsp
180002ba9:     	popq	%rsi
180002baa:     	retq
180002bab:     	imulq	0x8(%rcx), %rdx
180002bb0:     	movq	0x28(%rcx), %rax
180002bb4:     	movq	%rdi, 0x30(%rsp)
180002bb9:     	movq	0x30(%rcx), %rdi
180002bbd:     	addq	%rdx, %rdi
180002bc0:     	testq	%rax, %rax
180002bc3:     	je	0x180002bca <numba_list_setitem+0x5a>
180002bc5:     	movq	%rdi, %rcx
180002bc8:     	callq	*%rax
180002bca:     	movq	0x8(%rbx), %r8
180002bce:     	movq	%rsi, %rdx
180002bd1:     	movq	%rdi, %rcx
180002bd4:     	callq	0x180003f33 <numba_list_iter_next+0xe73>
180002bd9:     	movq	0x20(%rbx), %rax
180002bdd:     	testq	%rax, %rax
180002be0:     	je	0x180002be7 <numba_list_setitem+0x77>
180002be2:     	movq	%rdi, %rcx
180002be5:     	callq	*%rax
180002be7:     	movq	0x30(%rsp), %rdi
180002bec:     	xorl	%eax, %eax
180002bee:     	movq	0x38(%rsp), %rbx
180002bf3:     	addq	$0x20, %rsp
180002bf7:     	popq	%rsi
180002bf8:     	retq
180002bf9:     	int3
180002bfa:     	int3
180002bfb:     	int3
180002bfc:     	int3
180002bfd:     	int3
180002bfe:     	int3
180002bff:     	int3

0000000180002c00 <numba_list_getitem>:
180002c00:     	subq	$0x28, %rsp
180002c04:     	movq	%r8, %r9
180002c07:     	movq	%rdx, %rax
180002c0a:     	cmpq	(%rcx), %rdx
180002c0d:     	jb	0x180002c19 <numba_list_getitem+0x19>
180002c0f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002c14:     	addq	$0x28, %rsp
180002c18:     	retq
180002c19:     	movq	0x8(%rcx), %r8
180002c1d:     	movq	%r8, %rdx
180002c20:     	imulq	%rax, %rdx
180002c24:     	addq	0x30(%rcx), %rdx
180002c28:     	movq	%r9, %rcx
180002c2b:     	callq	0x180003f33 <numba_list_iter_next+0xe73>
180002c30:     	xorl	%eax, %eax
180002c32:     	addq	$0x28, %rsp
180002c36:     	retq
180002c37:     	int3
180002c38:     	int3
180002c39:     	int3
180002c3a:     	int3
180002c3b:     	int3
180002c3c:     	int3
180002c3d:     	int3
180002c3e:     	int3
180002c3f:     	int3

0000000180002c40 <numba_list_append>:
180002c40:     	movq	%rbx, 0x10(%rsp)
180002c45:     	pushq	%rsi
180002c46:     	subq	$0x20, %rsp
180002c4a:     	cmpl	$0x0, 0x18(%rcx)
180002c4e:     	movq	%rdx, %rsi
180002c51:     	movq	%rcx, %rbx
180002c54:     	jne	0x180002c66 <numba_list_append+0x26>
180002c56:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002c5b:     	movq	0x38(%rsp), %rbx
180002c60:     	addq	$0x20, %rsp
180002c64:     	popq	%rsi
180002c65:     	retq
180002c66:     	movq	(%rcx), %rdx
180002c69:     	incq	%rdx
180002c6c:     	callq	0x180002cc0 <numba_list_resize>
180002c71:     	testl	%eax, %eax
180002c73:     	js	0x180002cac <numba_list_append+0x6c>
180002c75:     	movq	0x8(%rbx), %r8
180002c79:     	movq	%rsi, %rdx
180002c7c:     	movq	%rdi, 0x30(%rsp)
180002c81:     	movq	(%rbx), %rdi
180002c84:     	decq	%rdi
180002c87:     	imulq	%r8, %rdi
180002c8b:     	addq	0x30(%rbx), %rdi
180002c8f:     	movq	%rdi, %rcx
180002c92:     	callq	0x180003f33 <numba_list_iter_next+0xe73>
180002c97:     	movq	0x20(%rbx), %rax
180002c9b:     	testq	%rax, %rax
180002c9e:     	je	0x180002ca5 <numba_list_append+0x65>
180002ca0:     	movq	%rdi, %rcx
180002ca3:     	callq	*%rax
180002ca5:     	movq	0x30(%rsp), %rdi
180002caa:     	xorl	%eax, %eax
180002cac:     	movq	0x38(%rsp), %rbx
180002cb1:     	addq	$0x20, %rsp
180002cb5:     	popq	%rsi
180002cb6:     	retq
180002cb7:     	int3
180002cb8:     	int3
180002cb9:     	int3
180002cba:     	int3
180002cbb:     	int3
180002cbc:     	int3
180002cbd:     	int3
180002cbe:     	int3
180002cbf:     	int3

0000000180002cc0 <numba_list_resize>:
180002cc0:     	movq	%rsi, 0x18(%rsp)
180002cc5:     	pushq	%rdi
180002cc6:     	subq	$0x20, %rsp
180002cca:     	cmpl	$0x0, 0x18(%rcx)
180002cce:     	movq	%rdx, %rsi
180002cd1:     	movq	%rcx, %rdi
180002cd4:     	jne	0x180002ce6 <numba_list_resize+0x26>
180002cd6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002cdb:     	movq	0x40(%rsp), %rsi
180002ce0:     	addq	$0x20, %rsp
180002ce4:     	popq	%rdi
180002ce5:     	retq
180002ce6:     	movq	0x10(%rcx), %rax
180002cea:     	cmpq	%rsi, %rax
180002ced:     	jl	0x180002d07 <numba_list_resize+0x47>
180002cef:     	sarq	%rax
180002cf2:     	cmpq	%rax, %rsi
180002cf5:     	jl	0x180002d07 <numba_list_resize+0x47>
180002cf7:     	movq	%rsi, (%rcx)
180002cfa:     	xorl	%eax, %eax
180002cfc:     	movq	0x40(%rsp), %rsi
180002d01:     	addq	$0x20, %rsp
180002d05:     	popq	%rdi
180002d06:     	retq
180002d07:     	cmpq	$0x9, %rsi
180002d0b:     	movq	%rbp, 0x38(%rsp)
180002d10:     	movl	$0x3, %ecx
180002d15:     	movl	$0x6, %eax
180002d1a:     	cmovll	%ecx, %eax
180002d1d:     	movq	%rsi, %r8
180002d20:     	movq	0x8(%rdi), %rcx
180002d24:     	addq	%rsi, %rax
180002d27:     	sarq	$0x3, %r8
180002d2b:     	xorl	%edx, %edx
180002d2d:     	addq	%rax, %r8
180002d30:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002d3a:     	divq	%rcx
180002d3d:     	cmpq	%rax, %r8
180002d40:     	ja	0x180002dbb <numba_list_resize+0xfb>
180002d42:     	xorl	%ebp, %ebp
180002d44:     	movq	%rbx, 0x30(%rsp)
180002d49:     	testq	%rsi, %rsi
180002d4c:     	cmovneq	%r8, %rbp
180002d50:     	movq	%rbp, %rbx
180002d53:     	imulq	%rcx, %rbx
180002d57:     	movl	$0x8, %ecx
180002d5c:     	movq	%rbx, %rax
180002d5f:     	cqto
180002d61:     	andl	$0x7, %edx
180002d64:     	addq	%rdx, %rax
180002d67:     	andl	$0x7, %eax
180002d6a:     	subq	%rdx, %rax
180002d6d:     	subq	%rax, %rcx
180002d70:     	movq	%rcx, %rax
180002d73:     	movq	0x30(%rdi), %rcx
180002d77:     	cqto
180002d79:     	andl	$0x7, %edx
180002d7c:     	addq	%rdx, %rax
180002d7f:     	andl	$0x7, %eax
180002d82:     	subq	%rdx, %rax
180002d85:     	leaq	(%rbx,%rax), %rdx
180002d89:     	callq	*0x22e1(%rip)           # 0x180005070
180002d8f:     	testq	%rbx, %rbx
180002d92:     	movq	0x30(%rsp), %rbx
180002d97:     	je	0x180002d9e <numba_list_resize+0xde>
180002d99:     	testq	%rax, %rax
180002d9c:     	je	0x180002dbb <numba_list_resize+0xfb>
180002d9e:     	movq	%rax, 0x30(%rdi)
180002da2:     	xorl	%eax, %eax
180002da4:     	movq	%rbp, 0x10(%rdi)
180002da8:     	movq	0x38(%rsp), %rbp
180002dad:     	movq	%rsi, (%rdi)
180002db0:     	movq	0x40(%rsp), %rsi
180002db5:     	addq	$0x20, %rsp
180002db9:     	popq	%rdi
180002dba:     	retq
180002dbb:     	movq	0x38(%rsp), %rbp
180002dc0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002dc5:     	movq	0x40(%rsp), %rsi
180002dca:     	addq	$0x20, %rsp
180002dce:     	popq	%rdi
180002dcf:     	retq

0000000180002dd0 <numba_list_delitem>:
180002dd0:     	movq	%rbx, 0x10(%rsp)
180002dd5:     	pushq	%rdi
180002dd6:     	subq	$0x20, %rsp
180002dda:     	cmpl	$0x0, 0x18(%rcx)
180002dde:     	movq	%rdx, %rdi
180002de1:     	movq	%rcx, %rbx
180002de4:     	jne	0x180002df6 <numba_list_delitem+0x26>
180002de6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002deb:     	movq	0x38(%rsp), %rbx
180002df0:     	addq	$0x20, %rsp
180002df4:     	popq	%rdi
180002df5:     	retq
180002df6:     	cmpq	(%rcx), %rdi
180002df9:     	jb	0x180002e0b <numba_list_delitem+0x3b>
180002dfb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002e00:     	movq	0x38(%rsp), %rbx
180002e05:     	addq	$0x20, %rsp
180002e09:     	popq	%rdi
180002e0a:     	retq
180002e0b:     	movq	0x28(%rcx), %rax
180002e0f:     	movq	%rsi, 0x30(%rsp)
180002e14:     	movq	%rdi, %rsi
180002e17:     	imulq	0x8(%rcx), %rsi
180002e1c:     	addq	0x30(%rcx), %rsi
180002e20:     	testq	%rax, %rax
180002e23:     	je	0x180002e2a <numba_list_delitem+0x5a>
180002e25:     	movq	%rsi, %rcx
180002e28:     	callq	*%rax
180002e2a:     	movq	(%rbx), %r8
180002e2d:     	leaq	-0x1(%r8), %rax
180002e31:     	cmpq	%rax, %rdi
180002e34:     	je	0x180002e56 <numba_list_delitem+0x86>
180002e36:     	subq	%rdi, %r8
180002e39:     	leaq	0x1(%rdi), %rdx
180002e3d:     	imulq	0x8(%rbx), %rdx
180002e42:     	decq	%r8
180002e45:     	movq	%rsi, %rcx
180002e48:     	imulq	0x8(%rbx), %r8
180002e4d:     	addq	0x30(%rbx), %rdx
180002e51:     	callq	0x180003f39 <numba_list_iter_next+0xe79>
180002e56:     	movq	(%rbx), %rdx
180002e59:     	movq	%rbx, %rcx
180002e5c:     	decq	%rdx
180002e5f:     	callq	0x180002cc0 <numba_list_resize>
180002e64:     	movq	0x30(%rsp), %rsi
180002e69:     	xorl	%ecx, %ecx
180002e6b:     	movq	0x38(%rsp), %rbx
180002e70:     	testl	%eax, %eax
180002e72:     	cmovsl	%eax, %ecx
180002e75:     	movl	%ecx, %eax
180002e77:     	addq	$0x20, %rsp
180002e7b:     	popq	%rdi
180002e7c:     	retq
180002e7d:     	int3
180002e7e:     	int3
180002e7f:     	int3

0000000180002e80 <numba_list_delete_slice>:
180002e80:     	pushq	%rbx
180002e82:     	pushq	%rbp
180002e83:     	pushq	%rdi
180002e84:     	pushq	%r15
180002e86:     	subq	$0x38, %rsp
180002e8a:     	cmpl	$0x0, 0x18(%rcx)
180002e8e:     	movq	%r9, %rdi
180002e91:     	movq	%r8, %rbp
180002e94:     	movq	%rdx, %r15
180002e97:     	movq	%rcx, %rbx
180002e9a:     	jne	0x180002eab <numba_list_delete_slice+0x2b>
180002e9c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002ea1:     	addq	$0x38, %rsp
180002ea5:     	popq	%r15
180002ea7:     	popq	%rdi
180002ea8:     	popq	%rbp
180002ea9:     	popq	%rbx
180002eaa:     	retq
180002eab:     	movq	%r13, 0x78(%rsp)
180002eb0:     	testq	%rdi, %rdi
180002eb3:     	jle	0x180002ed2 <numba_list_delete_slice+0x52>
180002eb5:     	cmpq	%r8, %r15
180002eb8:     	jge	0x180003071 <numba_list_delete_slice+0x1f1>
180002ebe:     	movq	%r8, %rax
180002ec1:     	subq	%r15, %rax
180002ec4:     	decq	%rax
180002ec7:     	cqto
180002ec9:     	idivq	%rdi
180002ecc:     	leal	0x1(%rax), %r13d
180002ed0:     	jmp	0x180002ef2 <numba_list_delete_slice+0x72>
180002ed2:     	cmpq	%r15, %r8
180002ed5:     	jge	0x180003071 <numba_list_delete_slice+0x1f1>
180002edb:     	movq	%r15, %rax
180002ede:     	movl	$0x1, %r13d
180002ee4:     	subq	%r8, %rax
180002ee7:     	decq	%rax
180002eea:     	cqto
180002eec:     	idivq	%rdi
180002eef:     	subl	%eax, %r13d
180002ef2:     	testl	%r13d, %r13d
180002ef5:     	jle	0x180003071 <numba_list_delete_slice+0x1f1>
180002efb:     	movq	%rsi, 0x68(%rsp)
180002f00:     	movl	(%rcx), %esi
180002f02:     	subl	%r13d, %esi
180002f05:     	movl	%esi, 0x20(%rsp)
180002f09:     	testq	%rdi, %rdi
180002f0c:     	jns	0x180002f27 <numba_list_delete_slice+0xa7>
180002f0e:     	leaq	0x1(%r15), %rbp
180002f12:     	leal	-0x1(%r13), %eax
180002f16:     	movslq	%eax, %rcx
180002f19:     	leaq	-0x1(%rbp), %r15
180002f1d:     	imulq	%rdi, %rcx
180002f21:     	addq	%rcx, %r15
180002f24:     	negq	%rdi
180002f27:     	cmpq	$0x1, %rdi
180002f2b:     	jne	0x180002f77 <numba_list_delete_slice+0xf7>
180002f2d:     	cmpq	$0x0, 0x28(%rbx)
180002f32:     	je	0x180002f59 <numba_list_delete_slice+0xd9>
180002f34:     	movslq	%r15d, %rdi
180002f37:     	cmpq	%rbp, %rdi
180002f3a:     	jge	0x180002f59 <numba_list_delete_slice+0xd9>
180002f3c:     	nopl	(%rax)
180002f40:     	movslq	%edi, %rcx
180002f43:     	imulq	0x8(%rbx), %rcx
180002f48:     	addq	0x30(%rbx), %rcx
180002f4c:     	callq	*0x28(%rbx)
180002f4f:     	incl	%edi
180002f51:     	movslq	%edi, %rax
180002f54:     	cmpq	%rbp, %rax
180002f57:     	jl	0x180002f40 <numba_list_delete_slice+0xc0>
180002f59:     	movq	0x8(%rbx), %rcx
180002f5d:     	movq	(%rbx), %r8
180002f60:     	movq	%rcx, %rdx
180002f63:     	subq	%rbp, %r8
180002f66:     	imulq	%rcx, %r8
180002f6a:     	imulq	%rbp, %rdx
180002f6e:     	imulq	%r15, %rcx
180002f72:     	jmp	0x18000303c <numba_list_delete_slice+0x1bc>
180002f77:     	movq	%r14, 0x30(%rsp)
180002f7c:     	movq	%r15, %r14
180002f7f:     	movl	$0x0, 0x60(%rsp)
180002f87:     	cmpq	%rbp, %r15
180002f8a:     	jge	0x180003009 <numba_list_delete_slice+0x189>
180002f8c:     	movq	%r12, 0x70(%rsp)
180002f91:     	movq	(%rbx), %rax
180002f94:     	leaq	(%r14,%rdi), %r12
180002f98:     	cmpq	%rax, %r12
180002f9b:     	jl	0x180002fa8 <numba_list_delete_slice+0x128>
180002f9d:     	movq	%r14, %rsi
180002fa0:     	notq	%rsi
180002fa3:     	addq	%rax, %rsi
180002fa6:     	jmp	0x180002fac <numba_list_delete_slice+0x12c>
180002fa8:     	leaq	-0x1(%rdi), %rsi
180002fac:     	movq	0x28(%rbx), %rax
180002fb0:     	testq	%rax, %rax
180002fb3:     	je	0x180002fc3 <numba_list_delete_slice+0x143>
180002fb5:     	movq	%r14, %rcx
180002fb8:     	imulq	0x8(%rbx), %rcx
180002fbd:     	addq	0x30(%rbx), %rcx
180002fc1:     	callq	*%rax
180002fc3:     	movq	0x8(%rbx), %r9
180002fc7:     	leaq	0x1(%r14), %rdx
180002fcb:     	movq	0x30(%rbx), %r10
180002fcf:     	movq	%r9, %r8
180002fd2:     	imulq	%rsi, %r8
180002fd6:     	imulq	%r9, %rdx
180002fda:     	movslq	0x60(%rsp), %rsi
180002fdf:     	subq	%rsi, %r14
180002fe2:     	imulq	%r9, %r14
180002fe6:     	addq	%r10, %rdx
180002fe9:     	leaq	(%r10,%r14), %rcx
180002fed:     	callq	0x180003f39 <numba_list_iter_next+0xe79>
180002ff2:     	incl	%esi
180002ff4:     	movq	%r12, %r14
180002ff7:     	movl	%esi, 0x60(%rsp)
180002ffb:     	cmpq	%rbp, %r12
180002ffe:     	jl	0x180002f91 <numba_list_delete_slice+0x111>
180003000:     	movq	0x70(%rsp), %r12
180003005:     	movl	0x20(%rsp), %esi
180003009:     	movq	(%rbx), %r8
18000300c:     	movq	0x30(%rsp), %r14
180003011:     	movslq	%r13d, %r10
180003014:     	movq	%r10, %rcx
180003017:     	imulq	%rdi, %rcx
18000301b:     	addq	%r15, %rcx
18000301e:     	cmpq	%r8, %rcx
180003021:     	jge	0x180003049 <numba_list_delete_slice+0x1c9>
180003023:     	movq	0x8(%rbx), %rax
180003027:     	subq	%rcx, %r8
18000302a:     	movq	%rax, %rdx
18000302d:     	imulq	%rcx, %rdx
180003031:     	imulq	%rax, %r8
180003035:     	subq	%r10, %rcx
180003038:     	imulq	%rax, %rcx
18000303c:     	addq	0x30(%rbx), %rdx
180003040:     	addq	0x30(%rbx), %rcx
180003044:     	callq	0x180003f39 <numba_list_iter_next+0xe79>
180003049:     	movslq	%esi, %rdx
18000304c:     	movq	%rbx, %rcx
18000304f:     	callq	0x180002cc0 <numba_list_resize>
180003054:     	movq	0x68(%rsp), %rsi
180003059:     	xorl	%ecx, %ecx
18000305b:     	movq	0x78(%rsp), %r13
180003060:     	testl	%eax, %eax
180003062:     	cmovsl	%eax, %ecx
180003065:     	movl	%ecx, %eax
180003067:     	addq	$0x38, %rsp
18000306b:     	popq	%r15
18000306d:     	popq	%rdi
18000306e:     	popq	%rbp
18000306f:     	popq	%rbx
180003070:     	retq
180003071:     	movq	0x78(%rsp), %r13
180003076:     	xorl	%eax, %eax
180003078:     	addq	$0x38, %rsp
18000307c:     	popq	%r15
18000307e:     	popq	%rdi
18000307f:     	popq	%rbp
180003080:     	popq	%rbx
180003081:     	retq
180003082:     	int3
180003083:     	int3
180003084:     	int3
180003085:     	int3
180003086:     	int3
180003087:     	int3
180003088:     	int3
180003089:     	int3
18000308a:     	int3
18000308b:     	int3
18000308c:     	int3
18000308d:     	int3
18000308e:     	int3
18000308f:     	int3

0000000180003090 <numba_list_iter_sizeof>:
180003090:     	movl	$0x18, %eax
180003095:     	retq
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

00000001800030a0 <numba_list_iter>:
1800030a0:     	movq	%rdx, (%rcx)
1800030a3:     	movq	(%rdx), %rax
1800030a6:     	movq	%rax, 0x8(%rcx)
1800030aa:     	movq	$0x0, 0x10(%rcx)
1800030b2:     	retq
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

00000001800030c0 <numba_list_iter_next>:
1800030c0:     	movq	(%rcx), %r8
1800030c3:     	movq	(%r8), %r9
1800030c6:     	cmpq	0x8(%rcx), %r9
1800030ca:     	je	0x1800030d2 <numba_list_iter_next+0x12>
1800030cc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
1800030d1:     	retq
1800030d2:     	movq	0x10(%rcx), %rax
1800030d6:     	cmpq	%r9, %rax
1800030d9:     	jge	0x1800030ee <numba_list_iter_next+0x2e>
1800030db:     	imulq	0x8(%r8), %rax
1800030e0:     	addq	0x30(%r8), %rax
1800030e4:     	movq	%rax, (%rdx)
1800030e7:     	incq	0x10(%rcx)
1800030eb:     	xorl	%eax, %eax
1800030ed:     	retq
1800030ee:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
1800030f3:     	retq
1800030f4:     	int3
1800030f5:     	int3
1800030f6:     	int3
1800030f7:     	int3
1800030f8:     	int3
1800030f9:     	int3
1800030fa:     	int3
1800030fb:     	int3
1800030fc:     	int3
1800030fd:     	int3
1800030fe:     	int3
1800030ff:     	int3
180003100:     	pushq	%rbx
180003102:     	subq	$0x20, %rsp
180003106:     	movq	%rcx, %rbx
180003109:     	addq	$0x30, %rcx
18000310d:     	callq	*0x8b15(%rip)           # 0x18000bc28
180003113:     	cmpb	$0x0, 0x8ae6(%rip)      # 0x18000bc00
18000311a:     	je	0x180003124 <numba_list_iter_next+0x64>
18000311c:     	lock
18000311d:     	incq	0x8ae4(%rip)            # 0x18000bc08
180003124:     	testq	%rax, %rax
180003127:     	je	0x180003168 <numba_list_iter_next+0xa8>
180003129:     	leaq	0x30(%rax), %rdx
18000312d:     	testq	%rdx, %rdx
180003130:     	je	0x180003168 <numba_list_iter_next+0xa8>
180003132:     	xorl	%r8d, %r8d
180003135:     	movl	$0x1, %ecx
18000313a:     	xchgq	%rcx, (%rax)
18000313d:     	movq	%r8, 0x8(%rax)
180003141:     	movq	%r8, 0x10(%rax)
180003145:     	movq	%rdx, 0x18(%rax)
180003149:     	movq	%rbx, 0x20(%rax)
18000314d:     	movq	%r8, 0x28(%rax)
180003151:     	cmpb	%r8b, 0x8aa8(%rip)      # 0x18000bc00
180003158:     	je	0x18000316a <numba_list_iter_next+0xaa>
18000315a:     	lock
18000315b:     	incq	0x8ab6(%rip)            # 0x18000bc18
180003162:     	addq	$0x20, %rsp
180003166:     	popq	%rbx
180003167:     	retq
180003168:     	xorl	%eax, %eax
18000316a:     	addq	$0x20, %rsp
18000316e:     	popq	%rbx
18000316f:     	retq
180003170:     	movq	%rbx, 0x8(%rsp)
180003175:     	pushq	%rdi
180003176:     	subq	$0x20, %rsp
18000317a:     	movq	%rcx, %rdi
18000317d:     	movq	%rdx, %rbx
180003180:     	addq	$0x30, %rcx
180003184:     	testq	%rdx, %rdx
180003187:     	je	0x180003191 <numba_list_iter_next+0xd1>
180003189:     	movq	0x18(%rdx), %rdx
18000318d:     	callq	*(%rbx)
18000318f:     	jmp	0x180003197 <numba_list_iter_next+0xd7>
180003191:     	callq	*0x8a91(%rip)           # 0x18000bc28
180003197:     	cmpb	$0x0, 0x8a62(%rip)      # 0x18000bc00
18000319e:     	movq	%rax, %r8
1800031a1:     	je	0x1800031ab <numba_list_iter_next+0xeb>
1800031a3:     	lock
1800031a4:     	incq	0x8a5d(%rip)            # 0x18000bc08
1800031ab:     	xorl	%edx, %edx
1800031ad:     	leaq	0x30(%r8), %rax
1800031b1:     	testq	%r8, %r8
1800031b4:     	movl	%edx, %ecx
1800031b6:     	cmovneq	%rax, %rcx
1800031ba:     	testq	%rcx, %rcx
1800031bd:     	jne	0x1800031cc <numba_list_iter_next+0x10c>
1800031bf:     	xorl	%eax, %eax
1800031c1:     	movq	0x30(%rsp), %rbx
1800031c6:     	addq	$0x20, %rsp
1800031ca:     	popq	%rdi
1800031cb:     	retq
1800031cc:     	movl	$0x1, %eax
1800031d1:     	xchgq	%rax, (%r8)
1800031d4:     	movq	%rdx, 0x8(%r8)
1800031d8:     	movq	%rdx, 0x10(%r8)
1800031dc:     	movq	%rcx, 0x18(%r8)
1800031e0:     	movq	%rdi, 0x20(%r8)
1800031e4:     	movq	%rbx, 0x28(%r8)
1800031e8:     	cmpb	%dl, 0x8a12(%rip)       # 0x18000bc00
1800031ee:     	je	0x1800031f8 <numba_list_iter_next+0x138>
1800031f0:     	lock
1800031f1:     	incq	0x8a20(%rip)            # 0x18000bc18
1800031f8:     	movq	0x30(%rsp), %rbx
1800031fd:     	movq	%r8, %rax
180003200:     	addq	$0x20, %rsp
180003204:     	popq	%rdi
180003205:     	retq
180003206:     	int3
180003207:     	int3
180003208:     	int3
180003209:     	int3
18000320a:     	int3
18000320b:     	int3
18000320c:     	int3
18000320d:     	int3
18000320e:     	int3
18000320f:     	int3
180003210:     	lock
180003211:     	incq	(%rcx)
180003214:     	retq
180003215:     	int3
180003216:     	int3
180003217:     	int3
180003218:     	int3
180003219:     	int3
18000321a:     	int3
18000321b:     	int3
18000321c:     	int3
18000321d:     	int3
18000321e:     	int3
18000321f:     	int3
180003220:     	pushq	%rbx
180003222:     	subq	$0x20, %rsp
180003226:     	movq	0x8(%rcx), %rax
18000322a:     	movq	%rcx, %rbx
18000322d:     	testq	%rax, %rax
180003230:     	je	0x180003249 <numba_list_iter_next+0x189>
180003232:     	cmpl	$0x0, 0x89bf(%rip)      # 0x18000bbf8
180003239:     	jne	0x180003249 <numba_list_iter_next+0x189>
18000323b:     	movq	0x10(%rcx), %r8
18000323f:     	movq	0x20(%rcx), %rdx
180003243:     	movq	0x18(%rcx), %rcx
180003247:     	callq	*%rax
180003249:     	movq	0x28(%rbx), %rax
18000324d:     	movq	%rbx, %rcx
180003250:     	testq	%rax, %rax
180003253:     	je	0x18000325e <numba_list_iter_next+0x19e>
180003255:     	movq	0x18(%rax), %rdx
180003259:     	callq	*0x10(%rax)
18000325c:     	jmp	0x180003264 <numba_list_iter_next+0x1a4>
18000325e:     	callq	*0x89d4(%rip)           # 0x18000bc38
180003264:     	cmpb	$0x0, 0x8995(%rip)      # 0x18000bc00
18000326b:     	je	0x180003289 <numba_list_iter_next+0x1c9>
18000326d:     	leaq	0x899c(%rip), %rax      # 0x18000bc10
180003274:     	lock
180003275:     	incq	(%rax)
180003278:     	cmpb	$0x0, 0x8981(%rip)      # 0x18000bc00
18000327f:     	je	0x180003289 <numba_list_iter_next+0x1c9>
180003281:     	lock
180003282:     	incq	0x8997(%rip)            # 0x18000bc20
180003289:     	addq	$0x20, %rsp
18000328d:     	popq	%rbx
18000328e:     	retq
18000328f:     	int3
180003290:     	pushq	%rbx
180003292:     	subq	$0x20, %rsp
180003296:     	movq	%rcx, %rbx
180003299:     	movq	$-0x1, %rax
1800032a0:     	lock
1800032a1:     	xaddq	%rax, (%rcx)
1800032a5:     	cmpq	$0x1, %rax
1800032a9:     	jne	0x18000330b <numba_list_iter_next+0x24b>
1800032ab:     	movq	0x8(%rcx), %rax
1800032af:     	testq	%rax, %rax
1800032b2:     	je	0x1800032cb <numba_list_iter_next+0x20b>
1800032b4:     	cmpl	$0x0, 0x893d(%rip)      # 0x18000bbf8
1800032bb:     	jne	0x1800032cb <numba_list_iter_next+0x20b>
1800032bd:     	movq	0x10(%rcx), %r8
1800032c1:     	movq	0x20(%rcx), %rdx
1800032c5:     	movq	0x18(%rcx), %rcx
1800032c9:     	callq	*%rax
1800032cb:     	movq	0x28(%rbx), %rax
1800032cf:     	movq	%rbx, %rcx
1800032d2:     	testq	%rax, %rax
1800032d5:     	je	0x1800032e0 <numba_list_iter_next+0x220>
1800032d7:     	movq	0x18(%rax), %rdx
1800032db:     	callq	*0x10(%rax)
1800032de:     	jmp	0x1800032e6 <numba_list_iter_next+0x226>
1800032e0:     	callq	*0x8952(%rip)           # 0x18000bc38
1800032e6:     	cmpb	$0x0, 0x8913(%rip)      # 0x18000bc00
1800032ed:     	je	0x18000330b <numba_list_iter_next+0x24b>
1800032ef:     	leaq	0x891a(%rip), %rax      # 0x18000bc10
1800032f6:     	lock
1800032f7:     	incq	(%rax)
1800032fa:     	cmpb	$0x0, 0x88ff(%rip)      # 0x18000bc00
180003301:     	je	0x18000330b <numba_list_iter_next+0x24b>
180003303:     	lock
180003304:     	incq	0x8915(%rip)            # 0x18000bc20
18000330b:     	addq	$0x20, %rsp
18000330f:     	popq	%rbx
180003310:     	retq
180003311:     	int3
180003312:     	int3
180003313:     	int3
180003314:     	int3
180003315:     	int3
180003316:     	int3
180003317:     	int3
180003318:     	int3
180003319:     	int3
18000331a:     	int3
18000331b:     	int3
18000331c:     	int3
18000331d:     	int3
18000331e:     	int3
18000331f:     	int3
180003320:     	movq	0x18(%rcx), %rax
180003324:     	retq
180003325:     	int3
180003326:     	int3
180003327:     	int3
180003328:     	int3
180003329:     	int3
18000332a:     	int3
18000332b:     	int3
18000332c:     	int3
18000332d:     	int3
18000332e:     	int3
18000332f:     	int3
180003330:     	jmpq	*%r8
180003333:     	int3
180003334:     	int3
180003335:     	int3
180003336:     	int3
180003337:     	int3
180003338:     	int3
180003339:     	int3
18000333a:     	int3
18000333b:     	int3
18000333c:     	int3
18000333d:     	int3
18000333e:     	int3
18000333f:     	int3
180003340:     	movq	%rbx, 0x8(%rsp)
180003345:     	pushq	%rdi
180003346:     	subq	$0x20, %rsp
18000334a:     	movq	%rcx, %rdi
18000334d:     	movq	%rdx, %rbx
180003350:     	movl	$0x30, %ecx
180003355:     	callq	*0x88cd(%rip)           # 0x18000bc28
18000335b:     	cmpb	$0x0, 0x889e(%rip)      # 0x18000bc00
180003362:     	je	0x18000336c <numba_list_iter_next+0x2ac>
180003364:     	lock
180003365:     	incq	0x889c(%rip)            # 0x18000bc08
18000336c:     	testq	%rax, %rax
18000336f:     	je	0x1800033a6 <numba_list_iter_next+0x2e6>
180003371:     	leaq	-0x48(%rip), %rcx       # 0x180003330 <numba_list_iter_next+0x270>
180003378:     	movl	$0x1, %edx
18000337d:     	xchgq	%rdx, (%rax)
180003380:     	movq	%rcx, 0x8(%rax)
180003384:     	xorl	%ecx, %ecx
180003386:     	movq	%rcx, 0x20(%rax)
18000338a:     	movq	%rcx, 0x28(%rax)
18000338e:     	movq	%rbx, 0x10(%rax)
180003392:     	movq	%rdi, 0x18(%rax)
180003396:     	cmpb	%cl, 0x8864(%rip)       # 0x18000bc00
18000339c:     	je	0x1800033a6 <numba_list_iter_next+0x2e6>
18000339e:     	lock
18000339f:     	incq	0x8872(%rip)            # 0x18000bc18
1800033a6:     	movq	0x30(%rsp), %rbx
1800033ab:     	addq	$0x20, %rsp
1800033af:     	popq	%rdi
1800033b0:     	retq
1800033b1:     	jmpq	*0x1eb9(%rip)           # 0x180005270
1800033b7:     	jmpq	*0x1ea3(%rip)           # 0x180005260
1800033bd:     	jmpq	*0x1e95(%rip)           # 0x180005258
1800033c3:     	jmpq	*0x1e87(%rip)           # 0x180005250
1800033c9:     	jmpq	*0x1e79(%rip)           # 0x180005248
1800033cf:     	jmpq	*0x1e6b(%rip)           # 0x180005240
1800033d5:     	jmpq	*0x1e55(%rip)           # 0x180005230
1800033db:     	jmpq	*0x1e3f(%rip)           # 0x180005220
1800033e1:     	jmpq	*0x1e19(%rip)           # 0x180005200
1800033e7:     	int3
1800033e8:     	int3
1800033e9:     	int3
1800033ea:     	int3
1800033eb:     	int3
1800033ec:     	int3
1800033ed:     	int3
1800033ee:     	int3
1800033ef:     	int3
1800033f0:     	int3
1800033f1:     	int3
1800033f2:     	int3
1800033f3:     	int3
1800033f4:     	int3
1800033f5:     	int3
1800033f6:     	nopw	(%rax,%rax)
180003400:     	cmpq	0x7cb9(%rip), %rcx      # 0x18000b0c0
180003407:     	jne	0x180003419 <numba_list_iter_next+0x359>
180003409:     	rolq	$0x10, %rcx
18000340d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180003412:     	jne	0x180003415 <numba_list_iter_next+0x355>
180003414:     	retq
180003415:     	rorq	$0x10, %rcx
180003419:     	jmp	0x180003774 <numba_list_iter_next+0x6b4>
18000341e:     	int3
18000341f:     	int3
180003420:     	subq	$0x28, %rsp
180003424:     	testl	%edx, %edx
180003426:     	je	0x180003461 <numba_list_iter_next+0x3a1>
180003428:     	subl	$0x1, %edx
18000342b:     	je	0x180003455 <numba_list_iter_next+0x395>
18000342d:     	subl	$0x1, %edx
180003430:     	je	0x180003448 <numba_list_iter_next+0x388>
180003432:     	cmpl	$0x1, %edx
180003435:     	je	0x180003441 <numba_list_iter_next+0x381>
180003437:     	movl	$0x1, %eax
18000343c:     	addq	$0x28, %rsp
180003440:     	retq
180003441:     	callq	0x180003940 <numba_list_iter_next+0x880>
180003446:     	jmp	0x18000344d <numba_list_iter_next+0x38d>
180003448:     	callq	0x180003918 <numba_list_iter_next+0x858>
18000344d:     	movzbl	%al, %eax
180003450:     	addq	$0x28, %rsp
180003454:     	retq
180003455:     	movq	%r8, %rdx
180003458:     	addq	$0x28, %rsp
18000345c:     	jmp	0x180003470 <numba_list_iter_next+0x3b0>
180003461:     	testq	%r8, %r8
180003464:     	setne	%cl
180003467:     	addq	$0x28, %rsp
18000346b:     	jmp	0x180003588 <numba_list_iter_next+0x4c8>
180003470:     	movq	%rbx, 0x8(%rsp)
180003475:     	movq	%rsi, 0x10(%rsp)
18000347a:     	movq	%rdi, 0x20(%rsp)
18000347f:     	pushq	%r14
180003481:     	subq	$0x20, %rsp
180003485:     	movq	%rdx, %rsi
180003488:     	movq	%rcx, %r14
18000348b:     	xorl	%ecx, %ecx
18000348d:     	callq	0x1800039fc <numba_list_iter_next+0x93c>
180003492:     	testb	%al, %al
180003494:     	je	0x180003562 <numba_list_iter_next+0x4a2>
18000349a:     	callq	0x180003890 <numba_list_iter_next+0x7d0>
18000349f:     	movb	%al, %bl
1800034a1:     	movb	%al, 0x40(%rsp)
1800034a5:     	movb	$0x1, %dil
1800034a8:     	cmpl	$0x0, 0x8519(%rip)      # 0x18000b9c8
1800034af:     	jne	0x18000357a <numba_list_iter_next+0x4ba>
1800034b5:     	movl	$0x1, 0x8509(%rip)      # 0x18000b9c8
1800034bf:     	callq	0x180003900 <numba_list_iter_next+0x840>
1800034c4:     	testb	%al, %al
1800034c6:     	je	0x180003517 <numba_list_iter_next+0x457>
1800034c8:     	callq	0x180003bbc <numba_list_iter_next+0xafc>
1800034cd:     	callq	0x180003850 <numba_list_iter_next+0x790>
1800034d2:     	callq	0x180003874 <numba_list_iter_next+0x7b4>
1800034d7:     	leaq	0x1df2(%rip), %rdx      # 0x1800052d0
1800034de:     	leaq	0x1de3(%rip), %rcx      # 0x1800052c8
1800034e5:     	callq	0x180003f02 <numba_list_iter_next+0xe42>
1800034ea:     	testl	%eax, %eax
1800034ec:     	jne	0x180003517 <numba_list_iter_next+0x457>
1800034ee:     	callq	0x1800038cc <numba_list_iter_next+0x80c>
1800034f3:     	testb	%al, %al
1800034f5:     	je	0x180003517 <numba_list_iter_next+0x457>
1800034f7:     	leaq	0x1dc2(%rip), %rdx      # 0x1800052c0
1800034fe:     	leaq	0x1db3(%rip), %rcx      # 0x1800052b8
180003505:     	callq	0x180003efc <numba_list_iter_next+0xe3c>
18000350a:     	movl	$0x2, 0x84b4(%rip)      # 0x18000b9c8
180003514:     	xorb	%dil, %dil
180003517:     	movb	%bl, %cl
180003519:     	callq	0x180003b5c <numba_list_iter_next+0xa9c>
18000351e:     	testb	%dil, %dil
180003521:     	jne	0x180003562 <numba_list_iter_next+0x4a2>
180003523:     	callq	0x180003bac <numba_list_iter_next+0xaec>
180003528:     	movq	%rax, %rbx
18000352b:     	cmpq	$0x0, (%rax)
18000352f:     	je	0x180003555 <numba_list_iter_next+0x495>
180003531:     	movq	%rax, %rcx
180003534:     	callq	0x180003ac4 <numba_list_iter_next+0xa04>
180003539:     	testb	%al, %al
18000353b:     	je	0x180003555 <numba_list_iter_next+0x495>
18000353d:     	movq	%rsi, %r8
180003540:     	movl	$0x2, %edx
180003545:     	movq	%r14, %rcx
180003548:     	movq	(%rbx), %rax
18000354b:     	movq	0x1d3e(%rip), %r9       # 0x180005290
180003552:     	callq	*%r9
180003555:     	incl	0x8445(%rip)            # 0x18000b9a0
18000355b:     	movl	$0x1, %eax
180003560:     	jmp	0x180003564 <numba_list_iter_next+0x4a4>
180003562:     	xorl	%eax, %eax
180003564:     	movq	0x30(%rsp), %rbx
180003569:     	movq	0x38(%rsp), %rsi
18000356e:     	movq	0x48(%rsp), %rdi
180003573:     	addq	$0x20, %rsp
180003577:     	popq	%r14
180003579:     	retq
18000357a:     	movl	$0x7, %ecx
18000357f:     	callq	0x180003bb4 <numba_list_iter_next+0xaf4>
180003584:     	nop
180003585:     	int3
180003586:     	int3
180003587:     	int3
180003588:     	movq	%rbx, 0x8(%rsp)
18000358d:     	pushq	%rdi
18000358e:     	subq	$0x30, %rsp
180003592:     	movb	%cl, %dil
180003595:     	movl	0x8405(%rip), %eax      # 0x18000b9a0
18000359b:     	testl	%eax, %eax
18000359d:     	jg	0x1800035ac <numba_list_iter_next+0x4ec>
18000359f:     	xorl	%eax, %eax
1800035a1:     	movq	0x40(%rsp), %rbx
1800035a6:     	addq	$0x30, %rsp
1800035aa:     	popq	%rdi
1800035ab:     	retq
1800035ac:     	decl	%eax
1800035ae:     	movl	%eax, 0x83ec(%rip)      # 0x18000b9a0
1800035b4:     	callq	0x180003890 <numba_list_iter_next+0x7d0>
1800035b9:     	movb	%al, %bl
1800035bb:     	movb	%al, 0x20(%rsp)
1800035bf:     	cmpl	$0x2, 0x8402(%rip)      # 0x18000b9c8
1800035c6:     	jne	0x1800035fe <numba_list_iter_next+0x53e>
1800035c8:     	callq	0x1800039b8 <numba_list_iter_next+0x8f8>
1800035cd:     	callq	0x180003860 <numba_list_iter_next+0x7a0>
1800035d2:     	callq	0x180003bf8 <numba_list_iter_next+0xb38>
1800035d7:     	movl	$0x0, 0x83e7(%rip)      # 0x18000b9c8
1800035e1:     	movb	%bl, %cl
1800035e3:     	callq	0x180003b5c <numba_list_iter_next+0xa9c>
1800035e8:     	xorl	%edx, %edx
1800035ea:     	movb	%dil, %cl
1800035ed:     	callq	0x180003b80 <numba_list_iter_next+0xac0>
1800035f2:     	movzbl	%al, %ebx
1800035f5:     	callq	0x1800039e8 <numba_list_iter_next+0x928>
1800035fa:     	movl	%ebx, %eax
1800035fc:     	jmp	0x1800035a1 <numba_list_iter_next+0x4e1>
1800035fe:     	movl	$0x7, %ecx
180003603:     	callq	0x180003bb4 <numba_list_iter_next+0xaf4>
180003608:     	nop
180003609:     	nop
18000360a:     	int3
18000360b:     	int3
18000360c:     	movq	%rsp, %rax
18000360f:     	movq	%rbx, 0x20(%rax)
180003613:     	movq	%r8, 0x18(%rax)
180003617:     	movl	%edx, 0x10(%rax)
18000361a:     	movq	%rcx, 0x8(%rax)
18000361e:     	pushq	%rsi
18000361f:     	pushq	%rdi
180003620:     	pushq	%r14
180003622:     	subq	$0x40, %rsp
180003626:     	movq	%r8, %rsi
180003629:     	movl	%edx, %edi
18000362b:     	movq	%rcx, %r14
18000362e:     	testl	%edx, %edx
180003630:     	jne	0x180003641 <numba_list_iter_next+0x581>
180003632:     	cmpl	%edx, 0x8368(%rip)      # 0x18000b9a0
180003638:     	jg	0x180003641 <numba_list_iter_next+0x581>
18000363a:     	xorl	%eax, %eax
18000363c:     	jmp	0x180003726 <numba_list_iter_next+0x666>
180003641:     	leal	-0x1(%rdx), %eax
180003644:     	cmpl	$0x1, %eax
180003647:     	ja	0x180003689 <numba_list_iter_next+0x5c9>
180003649:     	movq	0x1fa8(%rip), %rax      # 0x1800055f8
180003650:     	testq	%rax, %rax
180003653:     	jne	0x18000365a <numba_list_iter_next+0x59a>
180003655:     	leal	0x1(%rax), %ebx
180003658:     	jmp	0x180003662 <numba_list_iter_next+0x5a2>
18000365a:     	callq	*0x1c30(%rip)           # 0x180005290
180003660:     	movl	%eax, %ebx
180003662:     	movl	%ebx, 0x30(%rsp)
180003666:     	testl	%ebx, %ebx
180003668:     	je	0x18000371c <numba_list_iter_next+0x65c>
18000366e:     	movq	%rsi, %r8
180003671:     	movl	%edi, %edx
180003673:     	movq	%r14, %rcx
180003676:     	callq	0x180003420 <numba_list_iter_next+0x360>
18000367b:     	movl	%eax, %ebx
18000367d:     	movl	%eax, 0x30(%rsp)
180003681:     	testl	%eax, %eax
180003683:     	je	0x18000371c <numba_list_iter_next+0x65c>
180003689:     	movq	%rsi, %r8
18000368c:     	movl	%edi, %edx
18000368e:     	movq	%r14, %rcx
180003691:     	callq	0x18000382c <numba_list_iter_next+0x76c>
180003696:     	movl	%eax, %ebx
180003698:     	movl	%eax, 0x30(%rsp)
18000369c:     	cmpl	$0x1, %edi
18000369f:     	jne	0x1800036d7 <numba_list_iter_next+0x617>
1800036a1:     	testl	%eax, %eax
1800036a3:     	jne	0x1800036d7 <numba_list_iter_next+0x617>
1800036a5:     	movq	%rsi, %r8
1800036a8:     	xorl	%edx, %edx
1800036aa:     	movq	%r14, %rcx
1800036ad:     	callq	0x18000382c <numba_list_iter_next+0x76c>
1800036b2:     	testq	%rsi, %rsi
1800036b5:     	setne	%cl
1800036b8:     	callq	0x180003588 <numba_list_iter_next+0x4c8>
1800036bd:     	movq	0x1f34(%rip), %rax      # 0x1800055f8
1800036c4:     	testq	%rax, %rax
1800036c7:     	je	0x1800036d7 <numba_list_iter_next+0x617>
1800036c9:     	movq	%rsi, %r8
1800036cc:     	xorl	%edx, %edx
1800036ce:     	movq	%r14, %rcx
1800036d1:     	callq	*0x1bb9(%rip)           # 0x180005290
1800036d7:     	testl	%edi, %edi
1800036d9:     	je	0x1800036e0 <numba_list_iter_next+0x620>
1800036db:     	cmpl	$0x3, %edi
1800036de:     	jne	0x18000371c <numba_list_iter_next+0x65c>
1800036e0:     	movq	%rsi, %r8
1800036e3:     	movl	%edi, %edx
1800036e5:     	movq	%r14, %rcx
1800036e8:     	callq	0x180003420 <numba_list_iter_next+0x360>
1800036ed:     	movl	%eax, %ebx
1800036ef:     	movl	%eax, 0x30(%rsp)
1800036f3:     	testl	%eax, %eax
1800036f5:     	je	0x18000371c <numba_list_iter_next+0x65c>
1800036f7:     	movq	0x1efa(%rip), %rax      # 0x1800055f8
1800036fe:     	testq	%rax, %rax
180003701:     	jne	0x180003708 <numba_list_iter_next+0x648>
180003703:     	leal	0x1(%rax), %ebx
180003706:     	jmp	0x180003718 <numba_list_iter_next+0x658>
180003708:     	movq	%rsi, %r8
18000370b:     	movl	%edi, %edx
18000370d:     	movq	%r14, %rcx
180003710:     	callq	*0x1b7a(%rip)           # 0x180005290
180003716:     	movl	%eax, %ebx
180003718:     	movl	%ebx, 0x30(%rsp)
18000371c:     	jmp	0x180003724 <numba_list_iter_next+0x664>
18000371e:     	xorl	%ebx, %ebx
180003720:     	movl	%ebx, 0x30(%rsp)
180003724:     	movl	%ebx, %eax
180003726:     	movq	0x78(%rsp), %rbx
18000372b:     	addq	$0x40, %rsp
18000372f:     	popq	%r14
180003731:     	popq	%rdi
180003732:     	popq	%rsi
180003733:     	retq
180003734:     	movq	%rbx, 0x8(%rsp)
180003739:     	movq	%rsi, 0x10(%rsp)
18000373e:     	pushq	%rdi
18000373f:     	subq	$0x20, %rsp
180003743:     	movq	%r8, %rdi
180003746:     	movl	%edx, %ebx
180003748:     	movq	%rcx, %rsi
18000374b:     	cmpl	$0x1, %edx
18000374e:     	jne	0x180003755 <numba_list_iter_next+0x695>
180003750:     	callq	0x18000377c <numba_list_iter_next+0x6bc>
180003755:     	movq	%rdi, %r8
180003758:     	movl	%ebx, %edx
18000375a:     	movq	%rsi, %rcx
18000375d:     	movq	0x30(%rsp), %rbx
180003762:     	movq	0x38(%rsp), %rsi
180003767:     	addq	$0x20, %rsp
18000376b:     	popq	%rdi
18000376c:     	jmp	0x18000360c <numba_list_iter_next+0x54c>
180003771:     	int3
180003772:     	int3
180003773:     	int3
180003774:     	movl	$0x2, %ecx
180003779:     	int	$0x29
18000377b:     	retq
18000377c:     	movq	%rbx, 0x18(%rsp)
180003781:     	pushq	%rbp
180003782:     	movq	%rsp, %rbp
180003785:     	subq	$0x30, %rsp
180003789:     	movq	0x7930(%rip), %rax      # 0x18000b0c0
180003790:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000379a:     	cmpq	%rbx, %rax
18000379d:     	jne	0x180003816 <numba_list_iter_next+0x756>
18000379f:     	leaq	0x10(%rbp), %rcx
1800037a3:     	movq	$0x0, 0x10(%rbp)
1800037ab:     	callq	*0x186f(%rip)           # 0x180005020
1800037b1:     	movq	0x10(%rbp), %rax
1800037b5:     	movq	%rax, -0x10(%rbp)
1800037b9:     	callq	*0x1859(%rip)           # 0x180005018
1800037bf:     	movl	%eax, %eax
1800037c1:     	xorq	%rax, -0x10(%rbp)
1800037c5:     	callq	*0x1845(%rip)           # 0x180005010
1800037cb:     	movl	%eax, %eax
1800037cd:     	leaq	0x18(%rbp), %rcx
1800037d1:     	xorq	%rax, -0x10(%rbp)
1800037d5:     	callq	*0x1825(%rip)           # 0x180005000
1800037db:     	movl	0x18(%rbp), %eax
1800037de:     	leaq	-0x10(%rbp), %rcx
1800037e2:     	shlq	$0x20, %rax
1800037e6:     	xorq	0x18(%rbp), %rax
1800037ea:     	xorq	-0x10(%rbp), %rax
1800037ee:     	xorq	%rcx, %rax
1800037f1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
1800037fb:     	andq	%rcx, %rax
1800037fe:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180003808:     	cmpq	%rbx, %rax
18000380b:     	cmoveq	%rcx, %rax
18000380f:     	movq	%rax, 0x78aa(%rip)      # 0x18000b0c0
180003816:     	movq	0x50(%rsp), %rbx
18000381b:     	notq	%rax
18000381e:     	movq	%rax, 0x78db(%rip)      # 0x18000b100
180003825:     	addq	$0x30, %rsp
180003829:     	popq	%rbp
18000382a:     	retq
18000382b:     	int3
18000382c:     	subq	$0x28, %rsp
180003830:     	cmpl	$0x1, %edx
180003833:     	jne	0x180003845 <numba_list_iter_next+0x785>
180003835:     	cmpq	$0x0, 0x1dbb(%rip)      # 0x1800055f8
18000383d:     	jne	0x180003845 <numba_list_iter_next+0x785>
18000383f:     	callq	*0x17e3(%rip)           # 0x180005028
180003845:     	movl	$0x1, %eax
18000384a:     	addq	$0x28, %rsp
18000384e:     	retq
18000384f:     	int3
180003850:     	leaq	0x8159(%rip), %rcx      # 0x18000b9b0
180003857:     	jmpq	*0x17aa(%rip)           # 0x180005008
18000385e:     	int3
18000385f:     	int3
180003860:     	leaq	0x8149(%rip), %rcx      # 0x18000b9b0
180003867:     	jmp	0x180003ef6 <numba_list_iter_next+0xe36>
18000386c:     	leaq	0x814d(%rip), %rax      # 0x18000b9c0
180003873:     	retq
180003874:     	subq	$0x28, %rsp
180003878:     	callq	0x1800029d0 <PyInit_rcaotr_0cedc59f0901480dc0803d7c+0x10e0>
18000387d:     	orq	$0x24, (%rax)
180003881:     	callq	0x18000386c <numba_list_iter_next+0x7ac>
180003886:     	orq	$0x2, (%rax)
18000388a:     	addq	$0x28, %rsp
18000388e:     	retq
18000388f:     	int3
180003890:     	subq	$0x28, %rsp
180003894:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
180003899:     	testl	%eax, %eax
18000389b:     	je	0x1800038be <numba_list_iter_next+0x7fe>
18000389d:     	movq	%gs:0x30, %rax
1800038a6:     	movq	0x8(%rax), %rcx
1800038aa:     	jmp	0x1800038b1 <numba_list_iter_next+0x7f1>
1800038ac:     	cmpq	%rax, %rcx
1800038af:     	je	0x1800038c5 <numba_list_iter_next+0x805>
1800038b1:     	xorl	%eax, %eax
1800038b3:     	lock
1800038b4:     	cmpxchgq	%rcx, 0x8114(%rip)      # 0x18000b9d0
1800038bc:     	jne	0x1800038ac <numba_list_iter_next+0x7ec>
1800038be:     	xorb	%al, %al
1800038c0:     	addq	$0x28, %rsp
1800038c4:     	retq
1800038c5:     	movb	$0x1, %al
1800038c7:     	jmp	0x1800038c0 <numba_list_iter_next+0x800>
1800038c9:     	int3
1800038ca:     	int3
1800038cb:     	int3
1800038cc:     	subq	$0x28, %rsp
1800038d0:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
1800038d5:     	testl	%eax, %eax
1800038d7:     	je	0x1800038e0 <numba_list_iter_next+0x820>
1800038d9:     	callq	0x180003c38 <numba_list_iter_next+0xb78>
1800038de:     	jmp	0x1800038f9 <numba_list_iter_next+0x839>
1800038e0:     	callq	0x180003ed4 <numba_list_iter_next+0xe14>
1800038e5:     	movl	%eax, %ecx
1800038e7:     	callq	0x180003f0e <numba_list_iter_next+0xe4e>
1800038ec:     	testl	%eax, %eax
1800038ee:     	je	0x1800038f4 <numba_list_iter_next+0x834>
1800038f0:     	xorb	%al, %al
1800038f2:     	jmp	0x1800038fb <numba_list_iter_next+0x83b>
1800038f4:     	callq	0x180003f14 <numba_list_iter_next+0xe54>
1800038f9:     	movb	$0x1, %al
1800038fb:     	addq	$0x28, %rsp
1800038ff:     	retq
180003900:     	subq	$0x28, %rsp
180003904:     	xorl	%ecx, %ecx
180003906:     	callq	0x180003a38 <numba_list_iter_next+0x978>
18000390b:     	testb	%al, %al
18000390d:     	setne	%al
180003910:     	addq	$0x28, %rsp
180003914:     	retq
180003915:     	int3
180003916:     	int3
180003917:     	int3
180003918:     	subq	$0x28, %rsp
18000391c:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003921:     	testb	%al, %al
180003923:     	jne	0x180003929 <numba_list_iter_next+0x869>
180003925:     	xorb	%al, %al
180003927:     	jmp	0x18000393b <numba_list_iter_next+0x87b>
180003929:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
18000392e:     	testb	%al, %al
180003930:     	jne	0x180003939 <numba_list_iter_next+0x879>
180003932:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003937:     	jmp	0x180003925 <numba_list_iter_next+0x865>
180003939:     	movb	$0x1, %al
18000393b:     	addq	$0x28, %rsp
18000393f:     	retq
180003940:     	subq	$0x28, %rsp
180003944:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003949:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
18000394e:     	movb	$0x1, %al
180003950:     	addq	$0x28, %rsp
180003954:     	retq
180003955:     	int3
180003956:     	int3
180003957:     	int3
180003958:     	movq	%rbx, 0x8(%rsp)
18000395d:     	movq	%rbp, 0x10(%rsp)
180003962:     	movq	%rsi, 0x18(%rsp)
180003967:     	pushq	%rdi
180003968:     	subq	$0x20, %rsp
18000396c:     	movq	%r9, %rdi
18000396f:     	movq	%r8, %rsi
180003972:     	movl	%edx, %ebx
180003974:     	movq	%rcx, %rbp
180003977:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
18000397c:     	testl	%eax, %eax
18000397e:     	jne	0x180003996 <numba_list_iter_next+0x8d6>
180003980:     	cmpl	$0x1, %ebx
180003983:     	jne	0x180003996 <numba_list_iter_next+0x8d6>
180003985:     	movq	%rsi, %r8
180003988:     	xorl	%edx, %edx
18000398a:     	movq	%rbp, %rcx
18000398d:     	movq	%rdi, %rax
180003990:     	callq	*0x18fa(%rip)           # 0x180005290
180003996:     	movq	0x58(%rsp), %rdx
18000399b:     	movl	0x50(%rsp), %ecx
18000399f:     	movq	0x30(%rsp), %rbx
1800039a4:     	movq	0x38(%rsp), %rbp
1800039a9:     	movq	0x40(%rsp), %rsi
1800039ae:     	addq	$0x20, %rsp
1800039b2:     	popq	%rdi
1800039b3:     	jmp	0x180003f08 <numba_list_iter_next+0xe48>
1800039b8:     	subq	$0x28, %rsp
1800039bc:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
1800039c1:     	testl	%eax, %eax
1800039c3:     	je	0x1800039d5 <numba_list_iter_next+0x915>
1800039c5:     	leaq	0x8014(%rip), %rcx      # 0x18000b9e0
1800039cc:     	addq	$0x28, %rsp
1800039d0:     	jmp	0x180003f20 <numba_list_iter_next+0xe60>
1800039d5:     	callq	0x180003f30 <numba_list_iter_next+0xe70>
1800039da:     	testl	%eax, %eax
1800039dc:     	jne	0x1800039e3 <numba_list_iter_next+0x923>
1800039de:     	callq	0x180003f26 <numba_list_iter_next+0xe66>
1800039e3:     	addq	$0x28, %rsp
1800039e7:     	retq
1800039e8:     	subq	$0x28, %rsp
1800039ec:     	xorl	%ecx, %ecx
1800039ee:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
1800039f3:     	addq	$0x28, %rsp
1800039f7:     	jmp	0x180003f2c <numba_list_iter_next+0xe6c>
1800039fc:     	subq	$0x28, %rsp
180003a00:     	testl	%ecx, %ecx
180003a02:     	jne	0x180003a0b <numba_list_iter_next+0x94b>
180003a04:     	movb	$0x1, 0x7fcd(%rip)      # 0x18000b9d8
180003a0b:     	callq	0x180003c38 <numba_list_iter_next+0xb78>
180003a10:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003a15:     	testb	%al, %al
180003a17:     	jne	0x180003a1d <numba_list_iter_next+0x95d>
180003a19:     	xorb	%al, %al
180003a1b:     	jmp	0x180003a31 <numba_list_iter_next+0x971>
180003a1d:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003a22:     	testb	%al, %al
180003a24:     	jne	0x180003a2f <numba_list_iter_next+0x96f>
180003a26:     	xorl	%ecx, %ecx
180003a28:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003a2d:     	jmp	0x180003a19 <numba_list_iter_next+0x959>
180003a2f:     	movb	$0x1, %al
180003a31:     	addq	$0x28, %rsp
180003a35:     	retq
180003a36:     	int3
180003a37:     	int3
180003a38:     	pushq	%rbx
180003a3a:     	subq	$0x20, %rsp
180003a3e:     	cmpb	$0x0, 0x7f94(%rip)      # 0x18000b9d9
180003a45:     	movl	%ecx, %ebx
180003a47:     	jne	0x180003ab0 <numba_list_iter_next+0x9f0>
180003a49:     	cmpl	$0x1, %ecx
180003a4c:     	ja	0x180003ab8 <numba_list_iter_next+0x9f8>
180003a4e:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
180003a53:     	testl	%eax, %eax
180003a55:     	je	0x180003a7f <numba_list_iter_next+0x9bf>
180003a57:     	testl	%ebx, %ebx
180003a59:     	jne	0x180003a7f <numba_list_iter_next+0x9bf>
180003a5b:     	leaq	0x7f7e(%rip), %rcx      # 0x18000b9e0
180003a62:     	callq	0x180003f1a <numba_list_iter_next+0xe5a>
180003a67:     	testl	%eax, %eax
180003a69:     	jne	0x180003a7b <numba_list_iter_next+0x9bb>
180003a6b:     	leaq	0x7f86(%rip), %rcx      # 0x18000b9f8
180003a72:     	callq	0x180003f1a <numba_list_iter_next+0xe5a>
180003a77:     	testl	%eax, %eax
180003a79:     	je	0x180003aa9 <numba_list_iter_next+0x9e9>
180003a7b:     	xorb	%al, %al
180003a7d:     	jmp	0x180003ab2 <numba_list_iter_next+0x9f2>
180003a7f:     	movdqa	0x1b79(%rip), %xmm0     # 0x180005600
180003a87:     	orq	$-0x1, %rax
180003a8b:     	movdqu	%xmm0, 0x7f4d(%rip)     # 0x18000b9e0
180003a93:     	movq	%rax, 0x7f56(%rip)      # 0x18000b9f0
180003a9a:     	movdqu	%xmm0, 0x7f56(%rip)     # 0x18000b9f8
180003aa2:     	movq	%rax, 0x7f5f(%rip)      # 0x18000ba08
180003aa9:     	movb	$0x1, 0x7f29(%rip)      # 0x18000b9d9
180003ab0:     	movb	$0x1, %al
180003ab2:     	addq	$0x20, %rsp
180003ab6:     	popq	%rbx
180003ab7:     	retq
180003ab8:     	movl	$0x5, %ecx
180003abd:     	callq	0x180003bb4 <numba_list_iter_next+0xaf4>
180003ac2:     	int3
180003ac3:     	int3
180003ac4:     	subq	$0x18, %rsp
180003ac8:     	movq	%rcx, %r8
180003acb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003ad0:     	cmpw	%ax, -0x3ad7(%rip)      # 0x180000000
180003ad7:     	jne	0x180003b51 <numba_list_iter_next+0xa91>
180003ad9:     	movslq	-0x3aa4(%rip), %rcx     # 0x18000003c
180003ae0:     	leaq	-0x3ae7(%rip), %rdx     # 0x180000000
180003ae7:     	addq	%rdx, %rcx
180003aea:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003af0:     	jne	0x180003b51 <numba_list_iter_next+0xa91>
180003af2:     	movl	$0x20b, %eax            # imm = 0x20B
180003af7:     	cmpw	%ax, 0x18(%rcx)
180003afb:     	jne	0x180003b51 <numba_list_iter_next+0xa91>
180003afd:     	subq	%rdx, %r8
180003b00:     	movzwl	0x14(%rcx), %edx
180003b04:     	addq	$0x18, %rdx
180003b08:     	addq	%rcx, %rdx
180003b0b:     	movzwl	0x6(%rcx), %eax
180003b0f:     	leaq	(%rax,%rax,4), %rcx
180003b13:     	leaq	(%rdx,%rcx,8), %r9
180003b17:     	movq	%rdx, (%rsp)
180003b1b:     	cmpq	%r9, %rdx
180003b1e:     	je	0x180003b38 <numba_list_iter_next+0xa78>
180003b20:     	movl	0xc(%rdx), %ecx
180003b23:     	cmpq	%rcx, %r8
180003b26:     	jb	0x180003b32 <numba_list_iter_next+0xa72>
180003b28:     	movl	0x8(%rdx), %eax
180003b2b:     	addl	%ecx, %eax
180003b2d:     	cmpq	%rax, %r8
180003b30:     	jb	0x180003b3a <numba_list_iter_next+0xa7a>
180003b32:     	addq	$0x28, %rdx
180003b36:     	jmp	0x180003b17 <numba_list_iter_next+0xa57>
180003b38:     	xorl	%edx, %edx
180003b3a:     	testq	%rdx, %rdx
180003b3d:     	jne	0x180003b43 <numba_list_iter_next+0xa83>
180003b3f:     	xorb	%al, %al
180003b41:     	jmp	0x180003b57 <numba_list_iter_next+0xa97>
180003b43:     	cmpl	$0x0, 0x24(%rdx)
180003b47:     	jge	0x180003b4d <numba_list_iter_next+0xa8d>
180003b49:     	xorb	%al, %al
180003b4b:     	jmp	0x180003b57 <numba_list_iter_next+0xa97>
180003b4d:     	movb	$0x1, %al
180003b4f:     	jmp	0x180003b57 <numba_list_iter_next+0xa97>
180003b51:     	xorb	%al, %al
180003b53:     	jmp	0x180003b57 <numba_list_iter_next+0xa97>
180003b55:     	xorb	%al, %al
180003b57:     	addq	$0x18, %rsp
180003b5b:     	retq
180003b5c:     	pushq	%rbx
180003b5e:     	subq	$0x20, %rsp
180003b62:     	movb	%cl, %bl
180003b64:     	callq	0x180003edc <numba_list_iter_next+0xe1c>
180003b69:     	xorl	%edx, %edx
180003b6b:     	testl	%eax, %eax
180003b6d:     	je	0x180003b7a <numba_list_iter_next+0xaba>
180003b6f:     	testb	%bl, %bl
180003b71:     	jne	0x180003b7a <numba_list_iter_next+0xaba>
180003b73:     	xchgq	%rdx, 0x7e56(%rip)      # 0x18000b9d0
180003b7a:     	addq	$0x20, %rsp
180003b7e:     	popq	%rbx
180003b7f:     	retq
180003b80:     	pushq	%rbx
180003b82:     	subq	$0x20, %rsp
180003b86:     	cmpb	$0x0, 0x7e4b(%rip)      # 0x18000b9d8
180003b8d:     	movb	%cl, %bl
180003b8f:     	je	0x180003b95 <numba_list_iter_next+0xad5>
180003b91:     	testb	%dl, %dl
180003b93:     	jne	0x180003ba1 <numba_list_iter_next+0xae1>
180003b95:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003b9a:     	movb	%bl, %cl
180003b9c:     	callq	0x180003f2c <numba_list_iter_next+0xe6c>
180003ba1:     	movb	$0x1, %al
180003ba3:     	addq	$0x20, %rsp
180003ba7:     	popq	%rbx
180003ba8:     	retq
180003ba9:     	int3
180003baa:     	int3
180003bab:     	int3
180003bac:     	leaq	0x80b5(%rip), %rax      # 0x18000bc68
180003bb3:     	retq
180003bb4:     	movl	%ecx, %ecx
180003bb6:     	int	$0x29
180003bb8:     	retq
180003bb9:     	int3
180003bba:     	int3
180003bbb:     	int3
180003bbc:     	movq	%rbx, 0x8(%rsp)
180003bc1:     	pushq	%rdi
180003bc2:     	subq	$0x20, %rsp
180003bc6:     	leaq	0x43f3(%rip), %rbx      # 0x180007fc0
180003bcd:     	leaq	0x43ec(%rip), %rdi      # 0x180007fc0
180003bd4:     	jmp	0x180003be8 <numba_list_iter_next+0xb28>
180003bd6:     	movq	(%rbx), %rax
180003bd9:     	testq	%rax, %rax
180003bdc:     	je	0x180003be4 <numba_list_iter_next+0xb24>
180003bde:     	callq	*0x16ac(%rip)           # 0x180005290
180003be4:     	addq	$0x8, %rbx
180003be8:     	cmpq	%rdi, %rbx
180003beb:     	jb	0x180003bd6 <numba_list_iter_next+0xb16>
180003bed:     	movq	0x30(%rsp), %rbx
180003bf2:     	addq	$0x20, %rsp
180003bf6:     	popq	%rdi
180003bf7:     	retq
180003bf8:     	movq	%rbx, 0x8(%rsp)
180003bfd:     	pushq	%rdi
180003bfe:     	subq	$0x20, %rsp
180003c02:     	leaq	0x43c7(%rip), %rbx      # 0x180007fd0
180003c09:     	leaq	0x43c0(%rip), %rdi      # 0x180007fd0
180003c10:     	jmp	0x180003c24 <numba_list_iter_next+0xb64>
180003c12:     	movq	(%rbx), %rax
180003c15:     	testq	%rax, %rax
180003c18:     	je	0x180003c20 <numba_list_iter_next+0xb60>
180003c1a:     	callq	*0x1670(%rip)           # 0x180005290
180003c20:     	addq	$0x8, %rbx
180003c24:     	cmpq	%rdi, %rbx
180003c27:     	jb	0x180003c12 <numba_list_iter_next+0xb52>
180003c29:     	movq	0x30(%rsp), %rbx
180003c2e:     	addq	$0x20, %rsp
180003c32:     	popq	%rdi
180003c33:     	retq
180003c34:     	retq	$0x0
180003c37:     	int3
180003c38:     	movq	%rbx, 0x10(%rsp)
180003c3d:     	movq	%rbp, 0x18(%rsp)
180003c42:     	movq	%rsi, 0x20(%rsp)
180003c47:     	pushq	%rdi
180003c48:     	subq	$0x10, %rsp
180003c4c:     	xorl	%eax, %eax
180003c4e:     	xorl	%ecx, %ecx
180003c50:     	cpuid
180003c52:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003c58:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
180003c5e:     	orl	%ecx, %edx
180003c60:     	movl	%eax, %ebp
180003c62:     	movl	$0x1, %eax
180003c67:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
180003c6d:     	orl	%ebx, %edx
180003c6f:     	leal	-0x1(%rax), %ecx
180003c72:     	cpuid
180003c74:     	movl	%ecx, %edi
180003c76:     	jne	0x180003cd6 <numba_list_iter_next+0xc16>
180003c78:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
180003c7d:     	movq	$0x8000, 0x7490(%rip)   # imm = 0x8000
                                                # 0x18000b118
180003c88:     	movq	$-0x1, 0x748d(%rip)     # 0x18000b120
180003c93:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180003c98:     	je	0x180003cc2 <numba_list_iter_next+0xc02>
180003c9a:     	cmpl	$0x20660, %eax          # imm = 0x20660
180003c9f:     	je	0x180003cc2 <numba_list_iter_next+0xc02>
180003ca1:     	cmpl	$0x20670, %eax          # imm = 0x20670
180003ca6:     	je	0x180003cc2 <numba_list_iter_next+0xc02>
180003ca8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180003cad:     	cmpl	$0x20, %eax
180003cb0:     	ja	0x180003cd6 <numba_list_iter_next+0xc16>
180003cb2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180003cbc:     	btq	%rax, %rcx
180003cc0:     	jae	0x180003cd6 <numba_list_iter_next+0xc16>
180003cc2:     	movl	0x7d4b(%rip), %r8d      # 0x18000ba14
180003cc9:     	orl	$0x1, %r8d
180003ccd:     	movl	%r8d, 0x7d40(%rip)      # 0x18000ba14
180003cd4:     	jmp	0x180003cdd <numba_list_iter_next+0xc1d>
180003cd6:     	movl	0x7d37(%rip), %r8d      # 0x18000ba14
180003cdd:     	xorl	%r9d, %r9d
180003ce0:     	movl	%r9d, %r11d
180003ce3:     	cmpl	$0x7, %ebp
180003ce6:     	jl	0x180003d2a <numba_list_iter_next+0xc6a>
180003ce8:     	xorl	%ecx, %ecx
180003cea:     	leal	0x7(%r9), %eax
180003cee:     	cpuid
180003cf0:     	movl	%edx, %esi
180003cf2:     	movl	%ebx, %r10d
180003cf5:     	btl	$0x9, %ebx
180003cf9:     	jae	0x180003d06 <numba_list_iter_next+0xc46>
180003cfb:     	orl	$0x2, %r8d
180003cff:     	movl	%r8d, 0x7d0e(%rip)      # 0x18000ba14
180003d06:     	cmpl	$0x1, %eax
180003d09:     	jl	0x180003d18 <numba_list_iter_next+0xc58>
180003d0b:     	movl	$0x7, %eax
180003d10:     	leal	-0x6(%rax), %ecx
180003d13:     	cpuid
180003d15:     	movl	%edx, %r9d
180003d18:     	movl	$0x24, %eax
180003d1d:     	cmpl	%eax, %ebp
180003d1f:     	jl	0x180003d30 <numba_list_iter_next+0xc70>
180003d21:     	xorl	%ecx, %ecx
180003d23:     	cpuid
180003d25:     	movl	%ebx, %r11d
180003d28:     	jmp	0x180003d30 <numba_list_iter_next+0xc70>
180003d2a:     	movl	%r9d, %r10d
180003d2d:     	movl	%r9d, %esi
180003d30:     	movq	0x73f1(%rip), %rax      # 0x18000b128
180003d37:     	andq	$-0x2, %rax
180003d3b:     	movl	$0x1, 0x73cb(%rip)      # 0x18000b110
180003d45:     	movl	$0x2, 0x73c5(%rip)      # 0x18000b114
180003d4f:     	movq	%rax, 0x73d2(%rip)      # 0x18000b128
180003d56:     	btl	$0x14, %edi
180003d5a:     	jae	0x180003d7b <numba_list_iter_next+0xcbb>
180003d5c:     	andq	$-0x11, %rax
180003d60:     	movl	$0x2, 0x73a6(%rip)      # 0x18000b110
180003d6a:     	movq	%rax, 0x73b7(%rip)      # 0x18000b128
180003d71:     	movl	$0x6, 0x7399(%rip)      # 0x18000b114
180003d7b:     	btl	$0x1b, %edi
180003d7f:     	jae	0x180003ebc <numba_list_iter_next+0xdfc>
180003d85:     	xorl	%ecx, %ecx
180003d87:     	xgetbv
180003d8a:     	shlq	$0x20, %rdx
180003d8e:     	orq	%rax, %rdx
180003d91:     	movq	%rdx, 0x20(%rsp)
180003d96:     	btl	$0x1c, %edi
180003d9a:     	jae	0x180003ea0 <numba_list_iter_next+0xde0>
180003da0:     	movq	0x20(%rsp), %rax
180003da5:     	andb	$0x6, %al
180003da7:     	cmpb	$0x6, %al
180003da9:     	jne	0x180003ea0 <numba_list_iter_next+0xde0>
180003daf:     	movl	0x735f(%rip), %eax      # 0x18000b114
180003db5:     	movb	$-0x20, %dl
180003db7:     	orl	$0x8, %eax
180003dba:     	movl	$0x3, 0x734c(%rip)      # 0x18000b110
180003dc4:     	movl	%eax, 0x734a(%rip)      # 0x18000b114
180003dca:     	testb	$0x20, %r10b
180003dce:     	je	0x180003e32 <numba_list_iter_next+0xd72>
180003dd0:     	orl	$0x20, %eax
180003dd3:     	movl	$0x5, 0x7333(%rip)      # 0x18000b110
180003ddd:     	movl	%eax, 0x7331(%rip)      # 0x18000b114
180003de3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003de8:     	movq	0x7339(%rip), %rax      # 0x18000b128
180003def:     	andl	%ecx, %r10d
180003df2:     	andq	$-0x3, %rax
180003df6:     	movq	%rax, 0x732b(%rip)      # 0x18000b128
180003dfd:     	cmpl	%ecx, %r10d
180003e00:     	jne	0x180003e39 <numba_list_iter_next+0xd79>
180003e02:     	movq	0x20(%rsp), %rax
180003e07:     	andb	%dl, %al
180003e09:     	cmpb	%dl, %al
180003e0b:     	jne	0x180003e32 <numba_list_iter_next+0xd72>
180003e0d:     	movq	0x7314(%rip), %rax      # 0x18000b128
180003e14:     	orl	$0x40, 0x72f9(%rip)     # 0x18000b114
180003e1b:     	andq	$-0x25, %rax
180003e1f:     	movl	$0x6, 0x72e7(%rip)      # 0x18000b110
180003e29:     	movq	%rax, 0x72f8(%rip)      # 0x18000b128
180003e30:     	jmp	0x180003e39 <numba_list_iter_next+0xd79>
180003e32:     	movq	0x72ef(%rip), %rax      # 0x18000b128
180003e39:     	btl	$0x17, %esi
180003e3d:     	jae	0x180003e4b <numba_list_iter_next+0xd8b>
180003e3f:     	btrq	$0x18, %rax
180003e44:     	movq	%rax, 0x72dd(%rip)      # 0x18000b128
180003e4b:     	btl	$0x13, %r9d
180003e50:     	jae	0x180003ea0 <numba_list_iter_next+0xde0>
180003e52:     	movq	0x20(%rsp), %rax
180003e57:     	andb	%dl, %al
180003e59:     	cmpb	%dl, %al
180003e5b:     	jne	0x180003ea0 <numba_list_iter_next+0xde0>
180003e5d:     	movq	0x72c4(%rip), %rdx      # 0x18000b128
180003e64:     	movl	%r11d, %eax
180003e67:     	shrq	$0x10, %rax
180003e6b:     	movl	%r11d, %ecx
180003e6e:     	andl	$0x6, %eax
180003e71:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003e77:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003e7d:     	movl	%ecx, 0x7b95(%rip)      # 0x18000ba18
180003e83:     	notq	%rax
180003e86:     	andq	%rax, %rdx
180003e89:     	movq	%rdx, 0x7298(%rip)      # 0x18000b128
180003e90:     	cmpb	$0x1, %cl
180003e93:     	jbe	0x180003ea0 <numba_list_iter_next+0xde0>
180003e95:     	andq	$-0x41, %rdx
180003e99:     	movq	%rdx, 0x7288(%rip)      # 0x18000b128
180003ea0:     	btl	$0x15, %r9d
180003ea5:     	jae	0x180003ebc <numba_list_iter_next+0xdfc>
180003ea7:     	movq	0x20(%rsp), %rax
180003eac:     	btq	$0x13, %rax
180003eb1:     	jae	0x180003ebc <numba_list_iter_next+0xdfc>
180003eb3:     	btrq	$0x7, 0x726c(%rip)      # 0x18000b128
180003ebc:     	movq	0x28(%rsp), %rbx
180003ec1:     	xorl	%eax, %eax
180003ec3:     	movq	0x30(%rsp), %rbp
180003ec8:     	movq	0x38(%rsp), %rsi
180003ecd:     	addq	$0x10, %rsp
180003ed1:     	popq	%rdi
180003ed2:     	retq
180003ed3:     	int3
180003ed4:     	movl	$0x1, %eax
180003ed9:     	retq
180003eda:     	int3
180003edb:     	int3
180003edc:     	xorl	%eax, %eax
180003ede:     	cmpl	%eax, 0x724c(%rip)      # 0x18000b130
180003ee4:     	setne	%al
180003ee7:     	retq
180003ee8:     	int3
180003ee9:     	int3
180003eea:     	int3
180003eeb:     	int3
180003eec:     	int3
180003eed:     	int3
180003eee:     	int3
180003eef:     	int3
180003ef0:     	jmpq	*0x1152(%rip)           # 0x180005048
180003ef6:     	jmpq	*0x1154(%rip)           # 0x180005050
180003efc:     	jmpq	*0x118e(%rip)           # 0x180005090
180003f02:     	jmpq	*0x1190(%rip)           # 0x180005098
180003f08:     	jmpq	*0x1192(%rip)           # 0x1800050a0
180003f0e:     	jmpq	*0x1194(%rip)           # 0x1800050a8
180003f14:     	jmpq	*0x1196(%rip)           # 0x1800050b0
180003f1a:     	jmpq	*0x1160(%rip)           # 0x180005080
180003f20:     	jmpq	*0x1192(%rip)           # 0x1800050b8
180003f26:     	jmpq	*0x115c(%rip)           # 0x180005088
180003f2c:     	movb	$0x1, %al
180003f2e:     	retq
180003f2f:     	int3
180003f30:     	xorl	%eax, %eax
180003f32:     	retq
180003f33:     	jmpq	*0x10ff(%rip)           # 0x180005038
180003f39:     	jmpq	*0x1101(%rip)           # 0x180005040
180003f3f:     	jmpq	*0x1183(%rip)           # 0x1800050c8
180003f45:     	jmpq	*0x1185(%rip)           # 0x1800050d0
180003f4b:     	int3
180003f4c:     	int3
180003f4d:     	int3
180003f4e:     	int3
180003f4f:     	int3
180003f50:     	int3
180003f51:     	int3
180003f52:     	int3
180003f53:     	int3
180003f54:     	int3
180003f55:     	int3
180003f56:     	nopw	(%rax,%rax)
180003f60:     	jmpq	*%rax
180003f62:     	int3
180003f63:     	int3
180003f64:     	int3
180003f65:     	int3
180003f66:     	int3
180003f67:     	int3
180003f68:     	int3
180003f69:     	int3
180003f6a:     	int3
180003f6b:     	int3
180003f6c:     	int3
180003f6d:     	int3
180003f6e:     	int3
180003f6f:     	int3
180003f70:     	int3
180003f71:     	int3
180003f72:     	int3
180003f73:     	int3
180003f74:     	int3
180003f75:     	int3
180003f76:     	nopw	(%rax,%rax)
180003f80:     	jmpq	*0x130a(%rip)           # 0x180005290
180003f86:     	pushq	%rbp
180003f88:     	subq	$0x20, %rsp
180003f8c:     	movq	%rdx, %rbp
180003f8f:     	movb	0x40(%rbp), %cl
180003f92:     	addq	$0x20, %rsp
180003f96:     	popq	%rbp
180003f97:     	jmp	0x180003b5c <numba_list_iter_next+0xa9c>
180003f9c:     	int3
180003f9d:     	pushq	%rbp
180003f9f:     	subq	$0x20, %rsp
180003fa3:     	movq	%rdx, %rbp
180003fa6:     	movb	0x20(%rbp), %cl
180003fa9:     	callq	0x180003b5c <numba_list_iter_next+0xa9c>
180003fae:     	nop
180003faf:     	addq	$0x20, %rsp
180003fb3:     	popq	%rbp
180003fb4:     	retq
180003fb5:     	int3
180003fb6:     	pushq	%rbp
180003fb8:     	subq	$0x20, %rsp
180003fbc:     	movq	%rdx, %rbp
180003fbf:     	addq	$0x20, %rsp
180003fc3:     	popq	%rbp
180003fc4:     	jmp	0x1800039e8 <numba_list_iter_next+0x928>
180003fc9:     	int3
180003fca:     	pushq	%rbp
180003fcc:     	subq	$0x30, %rsp
180003fd0:     	movq	%rdx, %rbp
180003fd3:     	movq	(%rcx), %rax
180003fd6:     	movl	(%rax), %edx
180003fd8:     	movq	%rcx, 0x28(%rsp)
180003fdd:     	movl	%edx, 0x20(%rsp)
180003fe1:     	leaq	-0xbc8(%rip), %r9       # 0x180003420 <numba_list_iter_next+0x360>
180003fe8:     	movq	0x70(%rbp), %r8
180003fec:     	movl	0x68(%rbp), %edx
180003fef:     	movq	0x60(%rbp), %rcx
180003ff3:     	callq	0x180003958 <numba_list_iter_next+0x898>
180003ff8:     	nop
180003ff9:     	addq	$0x30, %rsp
180003ffd:     	popq	%rbp
180003ffe:     	retq
180003fff:     	int3
180004000:     	pushq	%rbp
180004002:     	movq	%rdx, %rbp
180004005:     	movq	(%rcx), %rax
180004008:     	xorl	%ecx, %ecx
18000400a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180004010:     	sete	%cl
180004013:     	movl	%ecx, %eax
180004015:     	popq	%rbp
180004016:     	retq
180004017:     	int3
