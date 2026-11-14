
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-formal-v1\aot\candidate-strict\recurrence_16\rcaotr_aaf42c2db6d9b748cf4faa74.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x1800031c0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3339(%rip), %rax      # 0x1800043c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	cvtsi2sd	%r8, %xmm1
180001095:     	cvtsi2sd	%r9, %xmm0
18000109a:     	mulsd	%xmm0, %xmm1
18000109e:     	andpd	0x326a(%rip), %xmm1     # 0x180004310
1800010a6:     	ucomisd	0x3272(%rip), %xmm1     # 0x180004320
1800010ae:     	jae	0x180001445 <.text+0x445>
1800010b4:     	cmpb	$0x0, (%rdx)
1800010b7:     	jne	0x180001448 <.text+0x448>
1800010bd:     	movq	0x28(%rsp), %rax
1800010c2:     	imulq	%r9, %r8
1800010c6:     	leaq	(%r8,%rax), %r10
1800010ca:     	xorq	%r10, %r8
1800010cd:     	movq	%r10, %r11
1800010d0:     	xorq	%rax, %r11
1800010d3:     	testq	%r11, %r8
1800010d6:     	js	0x180001445 <.text+0x445>
1800010dc:     	xorps	%xmm1, %xmm1
1800010df:     	cvtsi2sd	%r10, %xmm1
1800010e4:     	mulsd	%xmm0, %xmm1
1800010e8:     	andpd	0x3220(%rip), %xmm1     # 0x180004310
1800010f0:     	ucomisd	0x3228(%rip), %xmm1     # 0x180004320
1800010f8:     	jae	0x180001445 <.text+0x445>
1800010fe:     	imulq	%r9, %r10
180001102:     	leaq	(%r10,%rax), %r8
180001106:     	xorq	%r8, %r10
180001109:     	movq	%r8, %r11
18000110c:     	xorq	%rax, %r11
18000110f:     	testq	%r11, %r10
180001112:     	js	0x180001445 <.text+0x445>
180001118:     	xorps	%xmm1, %xmm1
18000111b:     	cvtsi2sd	%r8, %xmm1
180001120:     	mulsd	%xmm0, %xmm1
180001124:     	andpd	0x31e4(%rip), %xmm1     # 0x180004310
18000112c:     	ucomisd	0x31ec(%rip), %xmm1     # 0x180004320
180001134:     	jae	0x180001445 <.text+0x445>
18000113a:     	imulq	%r9, %r8
18000113e:     	leaq	(%r8,%rax), %r10
180001142:     	xorq	%r10, %r8
180001145:     	movq	%r10, %r11
180001148:     	xorq	%rax, %r11
18000114b:     	testq	%r11, %r8
18000114e:     	js	0x180001445 <.text+0x445>
180001154:     	xorps	%xmm1, %xmm1
180001157:     	cvtsi2sd	%r10, %xmm1
18000115c:     	mulsd	%xmm0, %xmm1
180001160:     	andpd	0x31a8(%rip), %xmm1     # 0x180004310
180001168:     	ucomisd	0x31b0(%rip), %xmm1     # 0x180004320
180001170:     	jae	0x180001445 <.text+0x445>
180001176:     	imulq	%r9, %r10
18000117a:     	leaq	(%r10,%rax), %r8
18000117e:     	xorq	%r8, %r10
180001181:     	movq	%r8, %r11
180001184:     	xorq	%rax, %r11
180001187:     	testq	%r11, %r10
18000118a:     	js	0x180001445 <.text+0x445>
180001190:     	xorps	%xmm1, %xmm1
180001193:     	cvtsi2sd	%r8, %xmm1
180001198:     	mulsd	%xmm0, %xmm1
18000119c:     	andpd	0x316c(%rip), %xmm1     # 0x180004310
1800011a4:     	ucomisd	0x3174(%rip), %xmm1     # 0x180004320
1800011ac:     	jae	0x180001445 <.text+0x445>
1800011b2:     	imulq	%r9, %r8
1800011b6:     	leaq	(%r8,%rax), %r10
1800011ba:     	xorq	%r10, %r8
1800011bd:     	movq	%r10, %r11
1800011c0:     	xorq	%rax, %r11
1800011c3:     	testq	%r11, %r8
1800011c6:     	js	0x180001445 <.text+0x445>
1800011cc:     	xorps	%xmm1, %xmm1
1800011cf:     	cvtsi2sd	%r10, %xmm1
1800011d4:     	mulsd	%xmm0, %xmm1
1800011d8:     	andpd	0x3130(%rip), %xmm1     # 0x180004310
1800011e0:     	ucomisd	0x3138(%rip), %xmm1     # 0x180004320
1800011e8:     	jae	0x180001445 <.text+0x445>
1800011ee:     	imulq	%r9, %r10
1800011f2:     	leaq	(%r10,%rax), %r8
1800011f6:     	xorq	%r8, %r10
1800011f9:     	movq	%r8, %r11
1800011fc:     	xorq	%rax, %r11
1800011ff:     	testq	%r11, %r10
180001202:     	js	0x180001445 <.text+0x445>
180001208:     	xorps	%xmm1, %xmm1
18000120b:     	cvtsi2sd	%r8, %xmm1
180001210:     	mulsd	%xmm0, %xmm1
180001214:     	andpd	0x30f4(%rip), %xmm1     # 0x180004310
18000121c:     	ucomisd	0x30fc(%rip), %xmm1     # 0x180004320
180001224:     	jae	0x180001445 <.text+0x445>
18000122a:     	imulq	%r9, %r8
18000122e:     	leaq	(%r8,%rax), %r10
180001232:     	xorq	%r10, %r8
180001235:     	movq	%r10, %r11
180001238:     	xorq	%rax, %r11
18000123b:     	testq	%r11, %r8
18000123e:     	js	0x180001445 <.text+0x445>
180001244:     	xorps	%xmm1, %xmm1
180001247:     	cvtsi2sd	%r10, %xmm1
18000124c:     	mulsd	%xmm0, %xmm1
180001250:     	andpd	0x30b8(%rip), %xmm1     # 0x180004310
180001258:     	ucomisd	0x30c0(%rip), %xmm1     # 0x180004320
180001260:     	jae	0x180001445 <.text+0x445>
180001266:     	imulq	%r9, %r10
18000126a:     	leaq	(%r10,%rax), %r8
18000126e:     	xorq	%r8, %r10
180001271:     	movq	%r8, %r11
180001274:     	xorq	%rax, %r11
180001277:     	testq	%r11, %r10
18000127a:     	js	0x180001445 <.text+0x445>
180001280:     	xorps	%xmm1, %xmm1
180001283:     	cvtsi2sd	%r8, %xmm1
180001288:     	mulsd	%xmm0, %xmm1
18000128c:     	andpd	0x307c(%rip), %xmm1     # 0x180004310
180001294:     	ucomisd	0x3084(%rip), %xmm1     # 0x180004320
18000129c:     	jae	0x180001445 <.text+0x445>
1800012a2:     	imulq	%r9, %r8
1800012a6:     	leaq	(%r8,%rax), %r10
1800012aa:     	xorq	%r10, %r8
1800012ad:     	movq	%r10, %r11
1800012b0:     	xorq	%rax, %r11
1800012b3:     	testq	%r11, %r8
1800012b6:     	js	0x180001445 <.text+0x445>
1800012bc:     	xorps	%xmm1, %xmm1
1800012bf:     	cvtsi2sd	%r10, %xmm1
1800012c4:     	mulsd	%xmm0, %xmm1
1800012c8:     	andpd	0x3040(%rip), %xmm1     # 0x180004310
1800012d0:     	ucomisd	0x3048(%rip), %xmm1     # 0x180004320
1800012d8:     	jae	0x180001445 <.text+0x445>
1800012de:     	imulq	%r9, %r10
1800012e2:     	leaq	(%r10,%rax), %r8
1800012e6:     	xorq	%r8, %r10
1800012e9:     	movq	%r8, %r11
1800012ec:     	xorq	%rax, %r11
1800012ef:     	testq	%r11, %r10
1800012f2:     	js	0x180001445 <.text+0x445>
1800012f8:     	xorps	%xmm1, %xmm1
1800012fb:     	cvtsi2sd	%r8, %xmm1
180001300:     	mulsd	%xmm0, %xmm1
180001304:     	andpd	0x3004(%rip), %xmm1     # 0x180004310
18000130c:     	ucomisd	0x300c(%rip), %xmm1     # 0x180004320
180001314:     	jae	0x180001445 <.text+0x445>
18000131a:     	imulq	%r9, %r8
18000131e:     	leaq	(%r8,%rax), %r10
180001322:     	xorq	%r10, %r8
180001325:     	movq	%r10, %r11
180001328:     	xorq	%rax, %r11
18000132b:     	testq	%r11, %r8
18000132e:     	js	0x180001445 <.text+0x445>
180001334:     	xorps	%xmm1, %xmm1
180001337:     	cvtsi2sd	%r10, %xmm1
18000133c:     	mulsd	%xmm0, %xmm1
180001340:     	andpd	0x2fc8(%rip), %xmm1     # 0x180004310
180001348:     	ucomisd	0x2fd0(%rip), %xmm1     # 0x180004320
180001350:     	jae	0x180001445 <.text+0x445>
180001356:     	imulq	%r9, %r10
18000135a:     	leaq	(%r10,%rax), %r8
18000135e:     	xorq	%r8, %r10
180001361:     	movq	%r8, %r11
180001364:     	xorq	%rax, %r11
180001367:     	testq	%r11, %r10
18000136a:     	js	0x180001445 <.text+0x445>
180001370:     	xorps	%xmm1, %xmm1
180001373:     	cvtsi2sd	%r8, %xmm1
180001378:     	mulsd	%xmm0, %xmm1
18000137c:     	andpd	0x2f8c(%rip), %xmm1     # 0x180004310
180001384:     	ucomisd	0x2f94(%rip), %xmm1     # 0x180004320
18000138c:     	jae	0x180001445 <.text+0x445>
180001392:     	imulq	%r9, %r8
180001396:     	leaq	(%r8,%rax), %r10
18000139a:     	xorq	%r10, %r8
18000139d:     	movq	%r10, %r11
1800013a0:     	xorq	%rax, %r11
1800013a3:     	testq	%r11, %r8
1800013a6:     	js	0x180001445 <.text+0x445>
1800013ac:     	xorps	%xmm1, %xmm1
1800013af:     	cvtsi2sd	%r10, %xmm1
1800013b4:     	mulsd	%xmm0, %xmm1
1800013b8:     	andpd	0x2f50(%rip), %xmm1     # 0x180004310
1800013c0:     	ucomisd	0x2f58(%rip), %xmm1     # 0x180004320
1800013c8:     	jae	0x180001445 <.text+0x445>
1800013ca:     	imulq	%r9, %r10
1800013ce:     	leaq	(%r10,%rax), %r8
1800013d2:     	xorq	%r8, %r10
1800013d5:     	movq	%r8, %r11
1800013d8:     	xorq	%rax, %r11
1800013db:     	testq	%r11, %r10
1800013de:     	js	0x180001445 <.text+0x445>
1800013e0:     	xorps	%xmm1, %xmm1
1800013e3:     	cvtsi2sd	%r8, %xmm1
1800013e8:     	mulsd	%xmm0, %xmm1
1800013ec:     	andpd	0x2f1c(%rip), %xmm1     # 0x180004310
1800013f4:     	ucomisd	0x2f24(%rip), %xmm1     # 0x180004320
1800013fc:     	jae	0x180001445 <.text+0x445>
1800013fe:     	imulq	%r9, %r8
180001402:     	leaq	(%r8,%rax), %r10
180001406:     	xorq	%r10, %r8
180001409:     	movq	%r10, %r11
18000140c:     	xorq	%rax, %r11
18000140f:     	testq	%r11, %r8
180001412:     	js	0x180001445 <.text+0x445>
180001414:     	xorps	%xmm1, %xmm1
180001417:     	cvtsi2sd	%r10, %xmm1
18000141c:     	mulsd	%xmm1, %xmm0
180001420:     	andpd	0x2ee8(%rip), %xmm0     # 0x180004310
180001428:     	ucomisd	0x2ef0(%rip), %xmm0     # 0x180004320
180001430:     	jae	0x180001445 <.text+0x445>
180001432:     	imulq	%r9, %r10
180001436:     	leaq	(%r10,%rax), %r8
18000143a:     	xorq	%r8, %r10
18000143d:     	xorq	%r8, %rax
180001440:     	testq	%rax, %r10
180001443:     	jns	0x18000144b <.text+0x44b>
180001445:     	movb	$0x1, (%rdx)
180001448:     	xorl	%r8d, %r8d
18000144b:     	movq	%r8, (%rcx)
18000144e:     	retq
18000144f:     	nop
180001450:     	pushq	%r15
180001452:     	pushq	%r14
180001454:     	pushq	%r13
180001456:     	pushq	%r12
180001458:     	pushq	%rsi
180001459:     	pushq	%rdi
18000145a:     	pushq	%rbp
18000145b:     	pushq	%rbx
18000145c:     	subq	$0x198, %rsp            # imm = 0x198
180001463:     	movq	%rdx, %rcx
180001466:     	leaq	0x68(%rsp), %rax
18000146b:     	movq	%rax, 0x50(%rsp)
180001470:     	leaq	0x70(%rsp), %rax
180001475:     	movq	%rax, 0x48(%rsp)
18000147a:     	leaq	0x78(%rsp), %rax
18000147f:     	movq	%rax, 0x40(%rsp)
180001484:     	leaq	0x80(%rsp), %rax
18000148c:     	movq	%rax, 0x38(%rsp)
180001491:     	leaq	0x88(%rsp), %rax
180001499:     	movq	%rax, 0x30(%rsp)
18000149e:     	leaq	0x90(%rsp), %rax
1800014a6:     	movq	%rax, 0x28(%rsp)
1800014ab:     	leaq	0x98(%rsp), %rax
1800014b3:     	movq	%rax, 0x20(%rsp)
1800014b8:     	leaq	0x2f31(%rip), %rdx      # 0x1800043f0
1800014bf:     	movl	$0x7, %r8d
1800014c5:     	movl	$0x7, %r9d
1800014cb:     	callq	0x180003351 <numba_list_iter_next+0x2f1>
1800014d0:     	testl	%eax, %eax
1800014d2:     	movq	$0x0, 0x60(%rsp)
1800014db:     	je	0x18000183c <.text+0x83c>
1800014e1:     	cmpq	$0x0, 0x9777(%rip)      # 0x18000ac60
1800014e9:     	je	0x18000176c <.text+0x76c>
1800014ef:     	movq	0x98(%rsp), %rcx
1800014f7:     	xorps	%xmm0, %xmm0
1800014fa:     	movaps	%xmm0, 0x160(%rsp)
180001502:     	movaps	%xmm0, 0x170(%rsp)
18000150a:     	movaps	%xmm0, 0x180(%rsp)
180001512:     	movq	$0x0, 0x190(%rsp)
18000151e:     	leaq	0x160(%rsp), %rdx
180001526:     	callq	0x180002030 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7a0>
18000152b:     	testl	%eax, %eax
18000152d:     	jne	0x180001784 <.text+0x784>
180001533:     	cmpq	$0x8, 0x178(%rsp)
18000153c:     	jne	0x180001784 <.text+0x784>
180001542:     	movq	0x160(%rsp), %rsi
18000154a:     	movq	0x90(%rsp), %rcx
180001552:     	xorps	%xmm0, %xmm0
180001555:     	movaps	%xmm0, 0x120(%rsp)
18000155d:     	movaps	%xmm0, 0x130(%rsp)
180001565:     	movaps	%xmm0, 0x140(%rsp)
18000156d:     	movq	$0x0, 0x150(%rsp)
180001579:     	leaq	0x120(%rsp), %rdx
180001581:     	callq	0x180002030 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7a0>
180001586:     	testl	%eax, %eax
180001588:     	jne	0x18000179c <.text+0x79c>
18000158e:     	cmpq	$0x8, 0x138(%rsp)
180001597:     	jne	0x18000179c <.text+0x79c>
18000159d:     	movq	0x120(%rsp), %rbx
1800015a5:     	movq	0x88(%rsp), %rcx
1800015ad:     	xorps	%xmm0, %xmm0
1800015b0:     	movaps	%xmm0, 0xe0(%rsp)
1800015b8:     	movaps	%xmm0, 0xf0(%rsp)
1800015c0:     	movaps	%xmm0, 0x100(%rsp)
1800015c8:     	movq	$0x0, 0x110(%rsp)
1800015d4:     	leaq	0xe0(%rsp), %rdx
1800015dc:     	callq	0x180002030 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7a0>
1800015e1:     	testl	%eax, %eax
1800015e3:     	jne	0x1800017b4 <.text+0x7b4>
1800015e9:     	cmpq	$0x8, 0xf8(%rsp)
1800015f2:     	jne	0x1800017b4 <.text+0x7b4>
1800015f8:     	movq	0xe0(%rsp), %r14
180001600:     	movq	0x80(%rsp), %rcx
180001608:     	xorps	%xmm0, %xmm0
18000160b:     	movaps	%xmm0, 0xa0(%rsp)
180001613:     	movaps	%xmm0, 0xb0(%rsp)
18000161b:     	movaps	%xmm0, 0xc0(%rsp)
180001623:     	movq	$0x0, 0xd0(%rsp)
18000162f:     	leaq	0xa0(%rsp), %rdx
180001637:     	callq	0x180002030 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7a0>
18000163c:     	testl	%eax, %eax
18000163e:     	jne	0x1800017c9 <.text+0x7c9>
180001644:     	cmpq	$0x1, 0xb8(%rsp)
18000164d:     	jne	0x1800017c9 <.text+0x7c9>
180001653:     	movq	0xa0(%rsp), %rdi
18000165b:     	movq	0xc0(%rsp), %r15
180001663:     	movq	0x78(%rsp), %rcx
180001668:     	callq	0x180003357 <numba_list_iter_next+0x2f7>
18000166d:     	testq	%rax, %rax
180001670:     	movq	%rdi, 0x58(%rsp)
180001675:     	je	0x1800017de <.text+0x7de>
18000167b:     	movq	%rax, %r13
18000167e:     	movq	%rsi, %rdi
180001681:     	movq	%rax, %rcx
180001684:     	callq	0x18000335d <numba_list_iter_next+0x2fd>
180001689:     	movq	%rax, %r12
18000168c:     	movq	%r13, %rcx
18000168f:     	callq	0x180003363 <numba_list_iter_next+0x303>
180001694:     	callq	0x180003369 <numba_list_iter_next+0x309>
180001699:     	testq	%rax, %rax
18000169c:     	jne	0x180001817 <.text+0x817>
1800016a2:     	movq	0x70(%rsp), %rcx
1800016a7:     	callq	0x180003357 <numba_list_iter_next+0x2f7>
1800016ac:     	testq	%rax, %rax
1800016af:     	je	0x1800017f4 <.text+0x7f4>
1800016b5:     	movq	%rax, %rbp
1800016b8:     	movq	%rax, %rcx
1800016bb:     	callq	0x18000335d <numba_list_iter_next+0x2fd>
1800016c0:     	movq	%rax, %r13
1800016c3:     	movq	%rbp, %rcx
1800016c6:     	callq	0x180003363 <numba_list_iter_next+0x303>
1800016cb:     	callq	0x180003369 <numba_list_iter_next+0x309>
1800016d0:     	testq	%rax, %rax
1800016d3:     	jne	0x180001817 <.text+0x817>
1800016d9:     	movq	0x68(%rsp), %rcx
1800016de:     	callq	0x180003357 <numba_list_iter_next+0x2f7>
1800016e3:     	testq	%rax, %rax
1800016e6:     	je	0x180001807 <.text+0x807>
1800016ec:     	movq	%rax, %rsi
1800016ef:     	movq	%rax, %rcx
1800016f2:     	callq	0x18000335d <numba_list_iter_next+0x2fd>
1800016f7:     	movq	%rax, %rbp
1800016fa:     	movq	%rsi, %rcx
1800016fd:     	callq	0x180003363 <numba_list_iter_next+0x303>
180001702:     	callq	0x180003369 <numba_list_iter_next+0x309>
180001707:     	testq	%rax, %rax
18000170a:     	jne	0x180001817 <.text+0x817>
180001710:     	movq	%rbp, 0x20(%rsp)
180001715:     	leaq	0x60(%rsp), %rcx
18000171a:     	movq	%r15, %rdx
18000171d:     	movq	%r12, %r8
180001720:     	movq	%r13, %r9
180001723:     	callq	0x180001090 <.text+0x90>
180001728:     	movq	0x60(%rsp), %rsi
18000172d:     	movq	%rdi, %rcx
180001730:     	callq	0x180001060 <.text+0x60>
180001735:     	movq	%rbx, %rcx
180001738:     	callq	0x180001060 <.text+0x60>
18000173d:     	movq	%r14, %rcx
180001740:     	callq	0x180001060 <.text+0x60>
180001745:     	movq	0x58(%rsp), %rcx
18000174a:     	callq	0x180001060 <.text+0x60>
18000174f:     	movq	%rsi, %rcx
180001752:     	callq	0x18000336f <numba_list_iter_next+0x30f>
180001757:     	nop
180001758:     	addq	$0x198, %rsp            # imm = 0x198
18000175f:     	popq	%rbx
180001760:     	popq	%rbp
180001761:     	popq	%rdi
180001762:     	popq	%rsi
180001763:     	popq	%r12
180001765:     	popq	%r13
180001767:     	popq	%r14
180001769:     	popq	%r15
18000176b:     	retq
18000176c:     	movq	0x2ac5(%rip), %rcx      # 0x180004238
180001773:     	leaq	0x2c96(%rip), %rdx      # 0x180004410
18000177a:     	callq	0x180003375 <numba_list_iter_next+0x315>
18000177f:     	jmp	0x18000183c <.text+0x83c>
180001784:     	movq	0x2a9d(%rip), %rcx      # 0x180004228
18000178b:     	leaq	0x2d7e(%rip), %rdx      # 0x180004510
180001792:     	callq	0x180003375 <numba_list_iter_next+0x315>
180001797:     	jmp	0x18000183c <.text+0x83c>
18000179c:     	movq	0x2a85(%rip), %rcx      # 0x180004228
1800017a3:     	leaq	0x2d66(%rip), %rdx      # 0x180004510
1800017aa:     	callq	0x180003375 <numba_list_iter_next+0x315>
1800017af:     	jmp	0x180001834 <.text+0x834>
1800017b4:     	movq	0x2a6d(%rip), %rcx      # 0x180004228
1800017bb:     	leaq	0x2d4e(%rip), %rdx      # 0x180004510
1800017c2:     	callq	0x180003375 <numba_list_iter_next+0x315>
1800017c7:     	jmp	0x18000182c <.text+0x82c>
1800017c9:     	movq	0x2a58(%rip), %rcx      # 0x180004228
1800017d0:     	leaq	0x2d39(%rip), %rdx      # 0x180004510
1800017d7:     	callq	0x180003375 <numba_list_iter_next+0x315>
1800017dc:     	jmp	0x180001824 <.text+0x824>
1800017de:     	movq	%rsi, %rdi
1800017e1:     	xorl	%r12d, %r12d
1800017e4:     	callq	0x180003369 <numba_list_iter_next+0x309>
1800017e9:     	testq	%rax, %rax
1800017ec:     	je	0x1800016a2 <.text+0x6a2>
1800017f2:     	jmp	0x180001817 <.text+0x817>
1800017f4:     	xorl	%r13d, %r13d
1800017f7:     	callq	0x180003369 <numba_list_iter_next+0x309>
1800017fc:     	testq	%rax, %rax
1800017ff:     	je	0x1800016d9 <.text+0x6d9>
180001805:     	jmp	0x180001817 <.text+0x817>
180001807:     	xorl	%ebp, %ebp
180001809:     	callq	0x180003369 <numba_list_iter_next+0x309>
18000180e:     	testq	%rax, %rax
180001811:     	je	0x180001710 <.text+0x710>
180001817:     	movq	0x58(%rsp), %rcx
18000181c:     	callq	0x180001060 <.text+0x60>
180001821:     	movq	%rdi, %rsi
180001824:     	movq	%r14, %rcx
180001827:     	callq	0x180001060 <.text+0x60>
18000182c:     	movq	%rbx, %rcx
18000182f:     	callq	0x180001060 <.text+0x60>
180001834:     	movq	%rsi, %rcx
180001837:     	callq	0x180001060 <.text+0x60>
18000183c:     	xorl	%eax, %eax
18000183e:     	jmp	0x180001758 <.text+0x758>
180001843:     	nopw	%cs:(%rax,%rax)
18000184d:     	nopl	(%rax)
180001850:     	subq	$0x38, %rsp
180001854:     	movq	0x108(%rsp), %rdx
18000185c:     	movq	0x120(%rsp), %r8
180001864:     	movq	0x128(%rsp), %r9
18000186c:     	movq	0x130(%rsp), %rax
180001874:     	movq	%rax, 0x20(%rsp)
180001879:     	leaq	0x30(%rsp), %rcx
18000187e:     	callq	0x180001090 <.text+0x90>
180001883:     	movq	0x30(%rsp), %rax
180001888:     	addq	$0x38, %rsp
18000188c:     	retq
18000188d:     	nopl	(%rax)

0000000180001890 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74>:
180001890:     	pushq	%rsi
180001891:     	subq	$0x20, %rsp
180001895:     	leaq	0x87a4(%rip), %rcx      # 0x18000a040
18000189c:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800018a1:     	callq	0x18000337b <numba_list_iter_next+0x31b>
1800018a6:     	testq	%rax, %rax
1800018a9:     	je	0x1800018db <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x4b>
1800018ab:     	leaq	0x874e(%rip), %rdx      # 0x18000a000
1800018b2:     	leaq	0x2d07(%rip), %r8       # 0x1800045c0
1800018b9:     	leaq	0x2d28(%rip), %r9       # 0x1800045e8
1800018c0:     	movq	%rax, %rcx
1800018c3:     	movq	%rax, %rsi
1800018c6:     	callq	0x1800022a0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xa10>
1800018cb:     	movl	%eax, %ecx
1800018cd:     	xorl	%eax, %eax
1800018cf:     	testl	%ecx, %ecx
1800018d1:     	cmoveq	%rsi, %rax
1800018d5:     	addq	$0x20, %rsp
1800018d9:     	popq	%rsi
1800018da:     	retq
1800018db:     	xorl	%eax, %eax
1800018dd:     	addq	$0x20, %rsp
1800018e1:     	popq	%rsi
1800018e2:     	retq
1800018e3:     	int3
1800018e4:     	int3
1800018e5:     	int3
1800018e6:     	int3
1800018e7:     	int3
1800018e8:     	int3
1800018e9:     	int3
1800018ea:     	int3
1800018eb:     	int3
1800018ec:     	int3
1800018ed:     	int3
1800018ee:     	int3
1800018ef:     	int3
1800018f0:     	movq	%rbx, 0x8(%rsp)
1800018f5:     	movq	%rsi, 0x10(%rsp)
1800018fa:     	pushq	%rdi
1800018fb:     	subq	$0x20, %rsp
1800018ff:     	movq	%rcx, %rbx
180001902:     	movq	%r8, %rdi
180001905:     	movq	0x10(%rcx), %rcx
180001909:     	movq	%rdx, %rsi
18000190c:     	testq	%rcx, %rcx
18000190f:     	je	0x18000191a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x8a>
180001911:     	movq	%r8, %rdx
180001914:     	callq	*%rsi
180001916:     	testl	%eax, %eax
180001918:     	jne	0x18000193d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xad>
18000191a:     	movq	0x18(%rbx), %rcx
18000191e:     	testq	%rcx, %rcx
180001921:     	je	0x18000193b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xab>
180001923:     	movq	%rdi, %rdx
180001926:     	movq	%rsi, %rax
180001929:     	movq	0x30(%rsp), %rbx
18000192e:     	movq	0x38(%rsp), %rsi
180001933:     	addq	$0x20, %rsp
180001937:     	popq	%rdi
180001938:     	jmpq	*%rax
18000193b:     	xorl	%eax, %eax
18000193d:     	movq	0x30(%rsp), %rbx
180001942:     	movq	0x38(%rsp), %rsi
180001947:     	addq	$0x20, %rsp
18000194b:     	popq	%rdi
18000194c:     	retq
18000194d:     	int3
18000194e:     	int3
18000194f:     	int3
180001950:     	pushq	%rbx
180001952:     	subq	$0x20, %rsp
180001956:     	movq	%rcx, %rbx
180001959:     	movq	0x10(%rcx), %rcx
18000195d:     	testq	%rcx, %rcx
180001960:     	je	0x18000197d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xed>
180001962:     	movq	$0x0, 0x10(%rbx)
18000196a:     	movl	(%rcx), %eax
18000196c:     	testl	%eax, %eax
18000196e:     	js	0x18000197d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xed>
180001970:     	subl	$0x1, %eax
180001973:     	movl	%eax, (%rcx)
180001975:     	jne	0x18000197d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xed>
180001977:     	callq	*0x2833(%rip)           # 0x1800041b0
18000197d:     	movq	0x18(%rbx), %rcx
180001981:     	testq	%rcx, %rcx
180001984:     	je	0x1800019a1 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x111>
180001986:     	movq	$0x0, 0x18(%rbx)
18000198e:     	movl	(%rcx), %eax
180001990:     	testl	%eax, %eax
180001992:     	js	0x1800019a1 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x111>
180001994:     	subl	$0x1, %eax
180001997:     	movl	%eax, (%rcx)
180001999:     	jne	0x1800019a1 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x111>
18000199b:     	callq	*0x280f(%rip)           # 0x1800041b0
1800019a1:     	xorl	%eax, %eax
1800019a3:     	addq	$0x20, %rsp
1800019a7:     	popq	%rbx
1800019a8:     	retq
1800019a9:     	int3
1800019aa:     	int3
1800019ab:     	int3
1800019ac:     	int3
1800019ad:     	int3
1800019ae:     	int3
1800019af:     	int3
1800019b0:     	pushq	%rbx
1800019b2:     	subq	$0x20, %rsp
1800019b6:     	movq	%rcx, %rbx
1800019b9:     	callq	*0x2831(%rip)           # 0x1800041f0
1800019bf:     	movq	0x10(%rbx), %rcx
1800019c3:     	testq	%rcx, %rcx
1800019c6:     	je	0x1800019e3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x153>
1800019c8:     	movq	$0x0, 0x10(%rbx)
1800019d0:     	movl	(%rcx), %eax
1800019d2:     	testl	%eax, %eax
1800019d4:     	js	0x1800019e3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x153>
1800019d6:     	subl	$0x1, %eax
1800019d9:     	movl	%eax, (%rcx)
1800019db:     	jne	0x1800019e3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x153>
1800019dd:     	callq	*0x27cd(%rip)           # 0x1800041b0
1800019e3:     	movq	0x18(%rbx), %rcx
1800019e7:     	testq	%rcx, %rcx
1800019ea:     	je	0x180001a07 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x177>
1800019ec:     	movq	$0x0, 0x18(%rbx)
1800019f4:     	movl	(%rcx), %eax
1800019f6:     	testl	%eax, %eax
1800019f8:     	js	0x180001a07 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x177>
1800019fa:     	subl	$0x1, %eax
1800019fd:     	movl	%eax, (%rcx)
1800019ff:     	jne	0x180001a07 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x177>
180001a01:     	callq	*0x27a9(%rip)           # 0x1800041b0
180001a07:     	movq	0x8(%rbx), %rax
180001a0b:     	movq	%rbx, %rcx
180001a0e:     	addq	$0x20, %rsp
180001a12:     	popq	%rbx
180001a13:     	jmpq	*0x140(%rax)
180001a1a:     	int3
180001a1b:     	int3
180001a1c:     	int3
180001a1d:     	int3
180001a1e:     	int3
180001a1f:     	int3
180001a20:     	pushq	%rbx
180001a22:     	subq	$0x30, %rsp
180001a26:     	movq	%r8, %r10
180001a29:     	leaq	0x58(%rsp), %rax
180001a2e:     	movq	%rax, 0x28(%rsp)
180001a33:     	leaq	0x8f56(%rip), %r9       # 0x18000a990
180001a3a:     	movq	0x277f(%rip), %rax      # 0x1800041c0
180001a41:     	leaq	0x2ee0(%rip), %r8       # 0x180004928
180001a48:     	movq	%rdx, %r11
180001a4b:     	movq	%rax, 0x20(%rsp)
180001a50:     	movq	%rcx, %rbx
180001a53:     	movq	%r10, %rdx
180001a56:     	movq	%r11, %rcx
180001a59:     	callq	*0x2681(%rip)           # 0x1800040e0
180001a5f:     	testl	%eax, %eax
180001a61:     	je	0x180001abc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x22c>
180001a63:     	xorl	%r8d, %r8d
180001a66:     	xorl	%edx, %edx
180001a68:     	movq	%rbx, %rcx
180001a6b:     	callq	*0x279f(%rip)           # 0x180004210
180001a71:     	movq	%rax, %rbx
180001a74:     	testq	%rax, %rax
180001a77:     	je	0x180001abc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x22c>
180001a79:     	movq	0x58(%rsp), %rax
180001a7e:     	movl	(%rax), %ecx
180001a80:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001a86:     	jae	0x180001a91 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x201>
180001a88:     	incl	%ecx
180001a8a:     	movl	%ecx, (%rax)
180001a8c:     	movq	0x58(%rsp), %rax
180001a91:     	xorl	%ecx, %ecx
180001a93:     	movq	%rax, 0x10(%rbx)
180001a97:     	callq	*0x26d3(%rip)           # 0x180004170
180001a9d:     	movq	%rax, 0x18(%rbx)
180001aa1:     	testq	%rax, %rax
180001aa4:     	jne	0x180001ac4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x234>
180001aa6:     	movl	(%rbx), %eax
180001aa8:     	testl	%eax, %eax
180001aaa:     	js	0x180001abc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x22c>
180001aac:     	subl	$0x1, %eax
180001aaf:     	movl	%eax, (%rbx)
180001ab1:     	jne	0x180001abc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x22c>
180001ab3:     	movq	%rbx, %rcx
180001ab6:     	callq	*0x26f4(%rip)           # 0x1800041b0
180001abc:     	xorl	%eax, %eax
180001abe:     	addq	$0x30, %rsp
180001ac2:     	popq	%rbx
180001ac3:     	retq
180001ac4:     	movq	%rbx, %rax
180001ac7:     	addq	$0x30, %rsp
180001acb:     	popq	%rbx
180001acc:     	retq
180001acd:     	int3
180001ace:     	int3
180001acf:     	int3
180001ad0:     	movq	%rbx, 0x8(%rsp)
180001ad5:     	movq	%rsi, 0x10(%rsp)
180001ada:     	pushq	%rdi
180001adb:     	subq	$0x20, %rsp
180001adf:     	movq	%rcx, %rbx
180001ae2:     	movq	%r8, %rdi
180001ae5:     	movq	0x18(%rcx), %rcx
180001ae9:     	movq	%rdx, %rsi
180001aec:     	testq	%rcx, %rcx
180001aef:     	je	0x180001afa <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x26a>
180001af1:     	movq	%r8, %rdx
180001af4:     	callq	*%rsi
180001af6:     	testl	%eax, %eax
180001af8:     	jne	0x180001b1d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x28d>
180001afa:     	movq	0x40(%rbx), %rcx
180001afe:     	testq	%rcx, %rcx
180001b01:     	je	0x180001b1b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x28b>
180001b03:     	movq	%rdi, %rdx
180001b06:     	movq	%rsi, %rax
180001b09:     	movq	0x30(%rsp), %rbx
180001b0e:     	movq	0x38(%rsp), %rsi
180001b13:     	addq	$0x20, %rsp
180001b17:     	popq	%rdi
180001b18:     	jmpq	*%rax
180001b1b:     	xorl	%eax, %eax
180001b1d:     	movq	0x30(%rsp), %rbx
180001b22:     	movq	0x38(%rsp), %rsi
180001b27:     	addq	$0x20, %rsp
180001b2b:     	popq	%rdi
180001b2c:     	retq
180001b2d:     	int3
180001b2e:     	int3
180001b2f:     	int3
180001b30:     	pushq	%rbx
180001b32:     	subq	$0x20, %rsp
180001b36:     	movq	%rcx, %rbx
180001b39:     	callq	*0x26b1(%rip)           # 0x1800041f0
180001b3f:     	cmpq	$0x0, 0x48(%rbx)
180001b44:     	je	0x180001b4f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x2bf>
180001b46:     	movq	%rbx, %rcx
180001b49:     	callq	*0x2631(%rip)           # 0x180004180
180001b4f:     	movq	0x20(%rbx), %rcx
180001b53:     	callq	*0x2647(%rip)           # 0x1800041a0
180001b59:     	movq	0x38(%rbx), %rcx
180001b5d:     	callq	*0x263d(%rip)           # 0x1800041a0
180001b63:     	movq	0x18(%rbx), %rcx
180001b67:     	testq	%rcx, %rcx
180001b6a:     	je	0x180001b7f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x2ef>
180001b6c:     	movl	(%rcx), %eax
180001b6e:     	testl	%eax, %eax
180001b70:     	js	0x180001b7f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x2ef>
180001b72:     	subl	$0x1, %eax
180001b75:     	movl	%eax, (%rcx)
180001b77:     	jne	0x180001b7f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x2ef>
180001b79:     	callq	*0x2631(%rip)           # 0x1800041b0
180001b7f:     	movq	0x40(%rbx), %rcx
180001b83:     	testq	%rcx, %rcx
180001b86:     	je	0x180001b9b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x30b>
180001b88:     	movl	(%rcx), %eax
180001b8a:     	testl	%eax, %eax
180001b8c:     	js	0x180001b9b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x30b>
180001b8e:     	subl	$0x1, %eax
180001b91:     	movl	%eax, (%rcx)
180001b93:     	jne	0x180001b9b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x30b>
180001b95:     	callq	*0x2615(%rip)           # 0x1800041b0
180001b9b:     	movq	0x8(%rbx), %rax
180001b9f:     	movq	%rbx, %rcx
180001ba2:     	addq	$0x20, %rsp
180001ba6:     	popq	%rbx
180001ba7:     	jmpq	*0x140(%rax)
180001bae:     	int3
180001baf:     	int3
180001bb0:     	pushq	%rbx
180001bb2:     	subq	$0x20, %rsp
180001bb6:     	callq	*0x25bc(%rip)           # 0x180004178
180001bbc:     	movq	%rax, %rbx
180001bbf:     	testq	%rax, %rax
180001bc2:     	jne	0x180001bca <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x33a>
180001bc4:     	addq	$0x20, %rsp
180001bc8:     	popq	%rbx
180001bc9:     	retq
180001bca:     	movq	%rbx, %rcx
180001bcd:     	movq	%rdi, 0x30(%rsp)
180001bd2:     	callq	0x180003ee5 <numba_list_iter_next+0xe85>
180001bd7:     	leaq	0x1(%rax), %rcx
180001bdb:     	callq	*0x2637(%rip)           # 0x180004218
180001be1:     	movq	%rax, %rdi
180001be4:     	testq	%rax, %rax
180001be7:     	jne	0x180001bfc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x36c>
180001be9:     	callq	*0x2549(%rip)           # 0x180004138
180001bef:     	movq	0x30(%rsp), %rdi
180001bf4:     	xorl	%eax, %eax
180001bf6:     	addq	$0x20, %rsp
180001bfa:     	popq	%rbx
180001bfb:     	retq
180001bfc:     	movq	%rbx, %rdx
180001bff:     	movq	%rdi, %rcx
180001c02:     	callq	0x180003edf <numba_list_iter_next+0xe7f>
180001c07:     	movq	%rdi, %rax
180001c0a:     	movq	0x30(%rsp), %rdi
180001c0f:     	addq	$0x20, %rsp
180001c13:     	popq	%rbx
180001c14:     	retq
180001c15:     	int3
180001c16:     	int3
180001c17:     	int3
180001c18:     	int3
180001c19:     	int3
180001c1a:     	int3
180001c1b:     	int3
180001c1c:     	int3
180001c1d:     	int3
180001c1e:     	int3
180001c1f:     	int3
180001c20:     	movq	0x18(%rcx), %rcx
180001c24:     	movq	%rdx, %rax
180001c27:     	testq	%rcx, %rcx
180001c2a:     	je	0x180001c32 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x3a2>
180001c2c:     	movq	%r8, %rdx
180001c2f:     	jmpq	*%rax
180001c32:     	xorl	%eax, %eax
180001c34:     	retq
180001c35:     	int3
180001c36:     	int3
180001c37:     	int3
180001c38:     	int3
180001c39:     	int3
180001c3a:     	int3
180001c3b:     	int3
180001c3c:     	int3
180001c3d:     	int3
180001c3e:     	int3
180001c3f:     	int3
180001c40:     	movq	%rbx, 0x8(%rsp)
180001c45:     	pushq	%rdi
180001c46:     	subq	$0x20, %rsp
180001c4a:     	movq	0x28(%rcx), %rax
180001c4e:     	xorl	%edi, %edi
180001c50:     	movq	%rcx, %rbx
180001c53:     	testq	%rax, %rax
180001c56:     	je	0x180001c62 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x3d2>
180001c58:     	addq	$0x38, %rcx
180001c5c:     	callq	*%rax
180001c5e:     	movq	%rdi, 0x28(%rbx)
180001c62:     	movq	0x18(%rbx), %rcx
180001c66:     	testq	%rcx, %rcx
180001c69:     	je	0x180001c82 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x3f2>
180001c6b:     	movq	%rdi, 0x18(%rbx)
180001c6f:     	movl	(%rcx), %eax
180001c71:     	testl	%eax, %eax
180001c73:     	js	0x180001c82 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x3f2>
180001c75:     	subl	$0x1, %eax
180001c78:     	movl	%eax, (%rcx)
180001c7a:     	jne	0x180001c82 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x3f2>
180001c7c:     	callq	*0x252e(%rip)           # 0x1800041b0
180001c82:     	movq	%rdi, 0x20(%rbx)
180001c86:     	xorl	%eax, %eax
180001c88:     	movq	0x30(%rsp), %rbx
180001c8d:     	addq	$0x20, %rsp
180001c91:     	popq	%rdi
180001c92:     	retq
180001c93:     	int3
180001c94:     	int3
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
180001ca0:     	pushq	%rbx
180001ca2:     	subq	$0x20, %rsp
180001ca6:     	movq	%rcx, %rbx
180001ca9:     	callq	*0x2541(%rip)           # 0x1800041f0
180001caf:     	cmpq	$0x0, 0x30(%rbx)
180001cb4:     	je	0x180001cbf <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x42f>
180001cb6:     	movq	%rbx, %rcx
180001cb9:     	callq	*0x24c1(%rip)           # 0x180004180
180001cbf:     	callq	*0x246b(%rip)           # 0x180004130
180001cc5:     	testl	%eax, %eax
180001cc7:     	jne	0x180001cd8 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x448>
180001cc9:     	movq	0x28(%rbx), %rax
180001ccd:     	testq	%rax, %rax
180001cd0:     	je	0x180001cd8 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x448>
180001cd2:     	leaq	0x38(%rbx), %rcx
180001cd6:     	callq	*%rax
180001cd8:     	movq	0x18(%rbx), %rcx
180001cdc:     	testq	%rcx, %rcx
180001cdf:     	je	0x180001cf4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x464>
180001ce1:     	movl	(%rcx), %eax
180001ce3:     	testl	%eax, %eax
180001ce5:     	js	0x180001cf4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x464>
180001ce7:     	subl	$0x1, %eax
180001cea:     	movl	%eax, (%rcx)
180001cec:     	jne	0x180001cf4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x464>
180001cee:     	callq	*0x24bc(%rip)           # 0x1800041b0
180001cf4:     	movq	0x8(%rbx), %rax
180001cf8:     	movq	%rbx, %rcx
180001cfb:     	addq	$0x20, %rsp
180001cff:     	popq	%rbx
180001d00:     	jmpq	*0x140(%rax)
180001d07:     	int3
180001d08:     	int3
180001d09:     	int3
180001d0a:     	int3
180001d0b:     	int3
180001d0c:     	int3
180001d0d:     	int3
180001d0e:     	int3
180001d0f:     	int3
180001d10:     	pushq	%rdi
180001d12:     	subq	$0x20, %rsp
180001d16:     	cmpq	$0x0, 0x20(%rcx)
180001d1b:     	movq	%rcx, %rdi
180001d1e:     	jne	0x180001d3f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x4af>
180001d20:     	movq	0x2511(%rip), %rcx      # 0x180004238
180001d27:     	leaq	0x2c4a(%rip), %rdx      # 0x180004978
180001d2e:     	movq	(%rcx), %rcx
180001d31:     	callq	*0x24f9(%rip)           # 0x180004230
180001d37:     	xorl	%eax, %eax
180001d39:     	addq	$0x20, %rsp
180001d3d:     	popq	%rdi
180001d3e:     	retq
180001d3f:     	movq	%rdi, %rdx
180001d42:     	movq	%rbx, 0x30(%rsp)
180001d47:     	movl	$0x1, %ecx
180001d4c:     	callq	*0x239e(%rip)           # 0x1800040f0
180001d52:     	movq	%rax, %rbx
180001d55:     	testq	%rax, %rax
180001d58:     	jne	0x180001d65 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x4d5>
180001d5a:     	movq	0x30(%rsp), %rbx
180001d5f:     	addq	$0x20, %rsp
180001d63:     	popq	%rdi
180001d64:     	retq
180001d65:     	xorl	%r8d, %r8d
180001d68:     	movq	%rbx, %rdx
180001d6b:     	movq	%rdi, %rcx
180001d6e:     	callq	*0x20(%rdi)
180001d71:     	movl	(%rbx), %ecx
180001d73:     	movq	%rax, %rdi
180001d76:     	testl	%ecx, %ecx
180001d78:     	js	0x180001d8a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x4fa>
180001d7a:     	subl	$0x1, %ecx
180001d7d:     	movl	%ecx, (%rbx)
180001d7f:     	jne	0x180001d8a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x4fa>
180001d81:     	movq	%rbx, %rcx
180001d84:     	callq	*0x2426(%rip)           # 0x1800041b0
180001d8a:     	movq	0x30(%rsp), %rbx
180001d8f:     	movq	%rdi, %rax
180001d92:     	addq	$0x20, %rsp
180001d96:     	popq	%rdi
180001d97:     	retq
180001d98:     	int3
180001d99:     	int3
180001d9a:     	int3
180001d9b:     	int3
180001d9c:     	int3
180001d9d:     	int3
180001d9e:     	int3
180001d9f:     	int3
180001da0:     	movq	%rbx, 0x8(%rsp)
180001da5:     	pushq	%rdi
180001da6:     	subq	$0x20, %rsp
180001daa:     	movq	%r8, %rbx
180001dad:     	callq	*0x2365(%rip)           # 0x180004118
180001db3:     	movl	(%rbx), %ecx
180001db5:     	movl	%eax, %edi
180001db7:     	testl	%ecx, %ecx
180001db9:     	js	0x180001dcb <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x53b>
180001dbb:     	subl	$0x1, %ecx
180001dbe:     	movl	%ecx, (%rbx)
180001dc0:     	jne	0x180001dcb <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x53b>
180001dc2:     	movq	%rbx, %rcx
180001dc5:     	callq	*0x23e5(%rip)           # 0x1800041b0
180001dcb:     	movl	%edi, %ecx
180001dcd:     	movq	0x30(%rsp), %rbx
180001dd2:     	addq	$0x20, %rsp
180001dd6:     	popq	%rdi
180001dd7:     	jmpq	*0x240a(%rip)           # 0x1800041e8
180001dde:     	int3
180001ddf:     	int3
180001de0:     	movq	%rbx, 0x8(%rsp)
180001de5:     	pushq	%rdi
180001de6:     	subq	$0x20, %rsp
180001dea:     	movl	(%rdx), %eax
180001dec:     	movq	%rdx, %rbx
180001def:     	movq	%rcx, %rdi
180001df2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001df7:     	jae	0x180001dfd <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x56d>
180001df9:     	incl	%eax
180001dfb:     	movl	%eax, (%rdx)
180001dfd:     	movl	$0x30, %ecx
180001e02:     	callq	*0x8e20(%rip)           # 0x18000ac28
180001e08:     	cmpb	$0x0, 0x8df1(%rip)      # 0x18000ac00
180001e0f:     	je	0x180001e19 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x589>
180001e11:     	lock
180001e12:     	incq	0x8def(%rip)            # 0x18000ac08
180001e19:     	testq	%rax, %rax
180001e1c:     	je	0x180001e53 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x5c3>
180001e1e:     	movl	$0x1, %ecx
180001e23:     	leaq	-0x8a(%rip), %rdx       # 0x180001da0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x510>
180001e2a:     	xchgq	%rcx, (%rax)
180001e2d:     	xorl	%ecx, %ecx
180001e2f:     	movq	%rdx, 0x8(%rax)
180001e33:     	movq	%rcx, 0x20(%rax)
180001e37:     	movq	%rcx, 0x28(%rax)
180001e3b:     	movq	%rbx, 0x10(%rax)
180001e3f:     	movq	%rdi, 0x18(%rax)
180001e43:     	cmpb	%cl, 0x8db7(%rip)       # 0x18000ac00
180001e49:     	je	0x180001e53 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x5c3>
180001e4b:     	lock
180001e4c:     	incq	0x8dc5(%rip)            # 0x18000ac18
180001e53:     	movq	0x30(%rsp), %rbx
180001e58:     	addq	$0x20, %rsp
180001e5c:     	popq	%rdi
180001e5d:     	retq
180001e5e:     	int3
180001e5f:     	int3
180001e60:     	movq	%rbx, 0x8(%rsp)
180001e65:     	pushq	%rdi
180001e66:     	subq	$0x30, %rsp
180001e6a:     	movq	%rcx, %rdi
180001e6d:     	leaq	0x8b0c(%rip), %r9       # 0x18000a980
180001e74:     	movq	%r8, %rax
180001e77:     	leaq	0x58(%rsp), %rcx
180001e7c:     	movq	%rdx, %r10
180001e7f:     	movq	%rcx, 0x20(%rsp)
180001e84:     	movq	%r10, %rcx
180001e87:     	leaq	0x2b32(%rip), %r8       # 0x1800049c0
180001e8e:     	movq	%rax, %rdx
180001e91:     	callq	*0x2249(%rip)           # 0x1800040e0
180001e97:     	testl	%eax, %eax
180001e99:     	je	0x180001ec3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x633>
180001e9b:     	movq	0x58(%rsp), %rcx
180001ea0:     	callq	*0x2282(%rip)           # 0x180004128
180001ea6:     	movq	%rax, %rbx
180001ea9:     	callq	*0x2399(%rip)           # 0x180004248
180001eaf:     	testq	%rax, %rax
180001eb2:     	jne	0x180001ec3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x633>
180001eb4:     	movq	%rbx, 0x10(%rdi)
180001eb8:     	movq	0x40(%rsp), %rbx
180001ebd:     	addq	$0x30, %rsp
180001ec1:     	popq	%rdi
180001ec2:     	retq
180001ec3:     	movq	0x40(%rsp), %rbx
180001ec8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001ecd:     	addq	$0x30, %rsp
180001ed1:     	popq	%rdi
180001ed2:     	retq
180001ed3:     	int3
180001ed4:     	int3
180001ed5:     	int3
180001ed6:     	int3
180001ed7:     	int3
180001ed8:     	int3
180001ed9:     	int3
180001eda:     	int3
180001edb:     	int3
180001edc:     	int3
180001edd:     	int3
180001ede:     	int3
180001edf:     	int3
180001ee0:     	subq	$0x38, %rsp
180001ee4:     	movl	%r8d, %eax
180001ee7:     	movq	%rdx, %r10
180001eea:     	movq	0x10(%rcx), %r8
180001eee:     	movq	%rcx, %rdx
180001ef1:     	movl	%eax, 0x28(%rsp)
180001ef5:     	movq	%r10, %rcx
180001ef8:     	movl	$0x0, 0x20(%rsp)
180001f00:     	movq	0x20(%r8), %r9
180001f04:     	movq	0x18(%r8), %r8
180001f08:     	callq	*0x22ca(%rip)           # 0x1800041d8
180001f0e:     	addq	$0x38, %rsp
180001f12:     	retq
180001f13:     	int3
180001f14:     	int3
180001f15:     	int3
180001f16:     	int3
180001f17:     	int3
180001f18:     	int3
180001f19:     	int3
180001f1a:     	int3
180001f1b:     	int3
180001f1c:     	int3
180001f1d:     	int3
180001f1e:     	int3
180001f1f:     	int3
180001f20:     	movq	0x10(%rcx), %rax
180001f24:     	lock
180001f25:     	incq	(%rax)
180001f28:     	movq	0x22b1(%rip), %rax      # 0x1800041e0
180001f2f:     	retq
180001f30:     	subq	$0x28, %rsp
180001f34:     	movq	0x10(%rcx), %rcx
180001f38:     	callq	0x180003230 <numba_list_iter_next+0x1d0>
180001f3d:     	movq	0x229c(%rip), %rax      # 0x1800041e0
180001f44:     	addq	$0x28, %rsp
180001f48:     	retq
180001f49:     	int3
180001f4a:     	int3
180001f4b:     	int3
180001f4c:     	int3
180001f4d:     	int3
180001f4e:     	int3
180001f4f:     	int3
180001f50:     	movq	0x10(%rcx), %rcx
180001f54:     	movq	0x18(%rcx), %rcx
180001f58:     	jmpq	*0x21f1(%rip)           # 0x180004150
180001f5f:     	int3
180001f60:     	subq	$0x28, %rsp
180001f64:     	movq	0x10(%rcx), %rax
180001f68:     	testq	%rax, %rax
180001f6b:     	je	0x180001f89 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x6f9>
180001f6d:     	cmpq	$0x0, 0x18(%rax)
180001f72:     	je	0x180001f89 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x6f9>
180001f74:     	movq	(%rax), %rcx
180001f77:     	nop
180001f78:     	cmpq	$-0x1, %rcx
180001f7c:     	je	0x180001f89 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x6f9>
180001f7e:     	addq	$0x28, %rsp
180001f82:     	jmpq	*0x217f(%rip)           # 0x180004108
180001f89:     	movq	0x2240(%rip), %rcx      # 0x1800041d0
180001f90:     	leaq	0x2a31(%rip), %rdx      # 0x1800049c8
180001f97:     	movq	(%rcx), %rcx
180001f9a:     	callq	*0x2290(%rip)           # 0x180004230
180001fa0:     	xorl	%eax, %eax
180001fa2:     	addq	$0x28, %rsp
180001fa6:     	retq
180001fa7:     	int3
180001fa8:     	int3
180001fa9:     	int3
180001faa:     	int3
180001fab:     	int3
180001fac:     	int3
180001fad:     	int3
180001fae:     	int3
180001faf:     	int3
180001fb0:     	movq	0x10(%rcx), %rcx
180001fb4:     	movq	0x28(%rcx), %rcx
180001fb8:     	jmpq	*0x2191(%rip)           # 0x180004150
180001fbf:     	int3
180001fc0:     	movq	0x10(%rcx), %rax
180001fc4:     	movq	0x10(%rax), %rax
180001fc8:     	testq	%rax, %rax
180001fcb:     	je	0x180001fdc <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x74c>
180001fcd:     	movl	(%rax), %ecx
180001fcf:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001fd5:     	jae	0x180001ffa <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x76a>
180001fd7:     	incl	%ecx
180001fd9:     	movl	%ecx, (%rax)
180001fdb:     	retq
180001fdc:     	movq	0x21fd(%rip), %rcx      # 0x1800041e0
180001fe3:     	movl	(%rcx), %eax
180001fe5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001fea:     	jae	0x180001ff7 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x767>
180001fec:     	incl	%eax
180001fee:     	movl	%eax, (%rcx)
180001ff0:     	movq	0x21e9(%rip), %rcx      # 0x1800041e0
180001ff7:     	movq	%rcx, %rax
180001ffa:     	retq
180001ffb:     	int3
180001ffc:     	int3
180001ffd:     	int3
180001ffe:     	int3
180001fff:     	int3
180002000:     	pushq	%rbx
180002002:     	subq	$0x20, %rsp
180002006:     	movq	%rcx, %rbx
180002009:     	movq	0x10(%rcx), %rcx
18000200d:     	callq	0x180003230 <numba_list_iter_next+0x1d0>
180002012:     	movq	0x8(%rbx), %rax
180002016:     	movq	%rbx, %rcx
180002019:     	addq	$0x20, %rsp
18000201d:     	popq	%rbx
18000201e:     	jmpq	*0x140(%rax)
180002025:     	int3
180002026:     	int3
180002027:     	int3
180002028:     	int3
180002029:     	int3
18000202a:     	int3
18000202b:     	int3
18000202c:     	int3
18000202d:     	int3
18000202e:     	int3
18000202f:     	int3
180002030:     	movq	%rdi, 0x18(%rsp)
180002035:     	pushq	%r14
180002037:     	subq	$0x20, %rsp
18000203b:     	movq	0x8bfe(%rip), %rax      # 0x18000ac40
180002042:     	movq	%rdx, %r14
180002045:     	movq	%rcx, %rdi
180002048:     	movq	0x8(%rcx), %rcx
18000204c:     	movq	0x10(%rax), %rdx
180002050:     	cmpq	%rdx, %rcx
180002053:     	je	0x180002070 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7e0>
180002055:     	callq	*0x215d(%rip)           # 0x1800041b8
18000205b:     	testl	%eax, %eax
18000205d:     	jne	0x180002070 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x7e0>
18000205f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002064:     	movq	0x40(%rsp), %rdi
180002069:     	addq	$0x20, %rsp
18000206d:     	popq	%r14
18000206f:     	retq
180002070:     	movq	%rbx, 0x30(%rsp)
180002075:     	movq	%rdi, %rdx
180002078:     	movq	0x10(%rdi), %rbx
18000207c:     	movq	%rbx, %rcx
18000207f:     	movq	%rsi, 0x38(%rsp)
180002084:     	movl	0x18(%rdi), %esi
180002087:     	callq	0x180001de0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x550>
18000208c:     	movq	%rax, (%r14)
18000208f:     	movq	0x8baa(%rip), %rax      # 0x18000ac40
180002096:     	movq	%rbx, 0x20(%r14)
18000209a:     	movl	0x18(%rdi), %edx
18000209d:     	movq	0x20(%rdi), %rcx
1800020a1:     	callq	*0x4f0(%rax)
1800020a7:     	cmpl	$0x12, 0x8b9e(%rip)     # 0x18000ac4c
1800020ae:     	movq	0x30(%rsp), %rbx
1800020b3:     	movq	%rax, 0x10(%r14)
1800020b7:     	movq	0x38(%rdi), %rax
1800020bb:     	jl	0x1800020c3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x833>
1800020bd:     	movq	0x28(%rax), %rax
1800020c1:     	jmp	0x1800020c7 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x837>
1800020c3:     	movslq	0x20(%rax), %rax
1800020c7:     	xorl	%r8d, %r8d
1800020ca:     	movq	%rax, 0x18(%r14)
1800020ce:     	movq	%rdi, 0x8(%r14)
1800020d2:     	leaq	0x28(%r14), %rax
1800020d6:     	testl	%esi, %esi
1800020d8:     	jle	0x18000211b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x88b>
1800020da:     	nopw	(%rax,%rax)
1800020e0:     	movq	0x20(%rdi), %rcx
1800020e4:     	movq	(%rcx,%r8,8), %rdx
1800020e8:     	incl	%r8d
1800020eb:     	movq	%rdx, (%rax)
1800020ee:     	addq	$0x8, %rax
1800020f2:     	cmpl	%esi, %r8d
1800020f5:     	jl	0x1800020e0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x850>
1800020f7:     	xorl	%r8d, %r8d
1800020fa:     	nopw	(%rax,%rax)
180002100:     	movq	0x28(%rdi), %rcx
180002104:     	leaq	0x8(%rax), %rax
180002108:     	movslq	%r8d, %rdx
18000210b:     	incl	%r8d
18000210e:     	movq	(%rcx,%rdx,8), %rdx
180002112:     	movq	%rdx, -0x8(%rax)
180002116:     	cmpl	%esi, %r8d
180002119:     	jl	0x180002100 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x870>
18000211b:     	movq	0x38(%rsp), %rsi
180002120:     	xorl	%eax, %eax
180002122:     	movq	0x40(%rsp), %rdi
180002127:     	addq	$0x20, %rsp
18000212b:     	popq	%r14
18000212d:     	retq
18000212e:     	int3
18000212f:     	int3
180002130:     	pushq	%rbx
180002132:     	pushq	%rbp
180002133:     	pushq	%rsi
180002134:     	pushq	%rdi
180002135:     	subq	$0x28, %rsp
180002139:     	cmpq	$0x0, 0x8b0f(%rip)      # 0x18000ac50
180002141:     	movq	%rcx, %rbp
180002144:     	movslq	0x8(%rdx), %rdi
180002148:     	movq	(%rdx), %rsi
18000214b:     	jne	0x1800021a3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x913>
18000214d:     	leaq	0x27b4(%rip), %rcx      # 0x180004908
180002154:     	callq	*0x20ae(%rip)           # 0x180004208
18000215a:     	movq	%rax, %rbx
18000215d:     	testq	%rax, %rax
180002160:     	je	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
180002166:     	leaq	0x27a3(%rip), %rdx      # 0x180004910
18000216d:     	movq	%rax, %rcx
180002170:     	callq	*0x1fea(%rip)           # 0x180004160
180002176:     	movl	(%rbx), %edx
180002178:     	movq	%rax, 0x8ad1(%rip)      # 0x18000ac50
18000217f:     	testl	%edx, %edx
180002181:     	js	0x18000219a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x90a>
180002183:     	subl	$0x1, %edx
180002186:     	movl	%edx, (%rbx)
180002188:     	jne	0x18000219a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x90a>
18000218a:     	movq	%rbx, %rcx
18000218d:     	callq	*0x201d(%rip)           # 0x1800041b0
180002193:     	movq	0x8ab6(%rip), %rax      # 0x18000ac50
18000219a:     	testq	%rax, %rax
18000219d:     	je	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
1800021a3:     	movq	%rdi, %rdx
1800021a6:     	movq	%rsi, %rcx
1800021a9:     	callq	*0x1f71(%rip)           # 0x180004120
1800021af:     	movq	%rax, %rdi
1800021b2:     	testq	%rax, %rax
1800021b5:     	je	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
1800021b7:     	movq	0x8a92(%rip), %rcx      # 0x18000ac50
1800021be:     	xorl	%r8d, %r8d
1800021c1:     	movq	%rax, %rdx
1800021c4:     	callq	*0x1fbe(%rip)           # 0x180004188
1800021ca:     	movl	(%rdi), %ecx
1800021cc:     	movq	%rax, %rbx
1800021cf:     	testl	%ecx, %ecx
1800021d1:     	js	0x1800021e3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x953>
1800021d3:     	subl	$0x1, %ecx
1800021d6:     	movl	%ecx, (%rdi)
1800021d8:     	jne	0x1800021e3 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x953>
1800021da:     	movq	%rdi, %rcx
1800021dd:     	callq	*0x1fcd(%rip)           # 0x1800041b0
1800021e3:     	testq	%rbx, %rbx
1800021e6:     	je	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
1800021e8:     	movq	0x8(%rbx), %r8
1800021ec:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
1800021f7:     	jne	0x180002235 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x9a5>
1800021f9:     	movq	0x2028(%rip), %rcx      # 0x180004228
180002200:     	leaq	0x28c9(%rip), %rdx      # 0x180004ad0
180002207:     	movq	0x18(%r8), %r8
18000220b:     	movq	(%rcx), %rcx
18000220e:     	callq	*0x1fb4(%rip)           # 0x1800041c8
180002214:     	movl	(%rbx), %eax
180002216:     	testl	%eax, %eax
180002218:     	js	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
18000221a:     	subl	$0x1, %eax
18000221d:     	movl	%eax, (%rbx)
18000221f:     	jne	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
180002221:     	movq	%rbx, %rcx
180002224:     	callq	*0x1f86(%rip)           # 0x1800041b0
18000222a:     	xorl	%eax, %eax
18000222c:     	addq	$0x28, %rsp
180002230:     	popq	%rdi
180002231:     	popq	%rsi
180002232:     	popq	%rbp
180002233:     	popq	%rbx
180002234:     	retq
180002235:     	xorl	%r8d, %r8d
180002238:     	leaq	0x80c1(%rip), %rcx      # 0x18000a300
18000223f:     	xorl	%edx, %edx
180002241:     	callq	*0x1fc9(%rip)           # 0x180004210
180002247:     	movq	%rax, %rdi
18000224a:     	testq	%rax, %rax
18000224d:     	je	0x180002214 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x984>
18000224f:     	movq	%rbp, %rcx
180002252:     	movq	%rbx, 0x18(%rax)
180002256:     	callq	*0x1f4c(%rip)           # 0x1800041a8
18000225c:     	movq	%rax, 0x10(%rdi)
180002260:     	movq	%rax, %rcx
180002263:     	testq	%rax, %rax
180002266:     	jne	0x18000227a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x9ea>
180002268:     	movl	(%rdi), %eax
18000226a:     	testl	%eax, %eax
18000226c:     	js	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
18000226e:     	subl	$0x1, %eax
180002271:     	movl	%eax, (%rdi)
180002273:     	jne	0x18000222a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x99a>
180002275:     	movq	%rdi, %rcx
180002278:     	jmp	0x180002224 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x994>
18000227a:     	movl	(%rax), %eax
18000227c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002281:     	jae	0x180002287 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x9f7>
180002283:     	incl	%eax
180002285:     	movl	%eax, (%rcx)
180002287:     	movq	%rdi, %rax
18000228a:     	addq	$0x28, %rsp
18000228e:     	popq	%rdi
18000228f:     	popq	%rsi
180002290:     	popq	%rbp
180002291:     	popq	%rbx
180002292:     	retq
180002293:     	int3
180002294:     	int3
180002295:     	int3
180002296:     	int3
180002297:     	int3
180002298:     	int3
180002299:     	int3
18000229a:     	int3
18000229b:     	int3
18000229c:     	int3
18000229d:     	int3
18000229e:     	int3
18000229f:     	int3
1800022a0:     	movq	%r9, 0x20(%rsp)
1800022a5:     	movq	%r8, 0x18(%rsp)
1800022aa:     	movq	%rdx, 0x10(%rsp)
1800022af:     	movq	%rcx, 0x8(%rsp)
1800022b4:     	pushq	%rbx
1800022b5:     	pushq	%rbp
1800022b6:     	pushq	%rsi
1800022b7:     	pushq	%rdi
1800022b8:     	pushq	%r12
1800022ba:     	pushq	%r13
1800022bc:     	pushq	%r14
1800022be:     	pushq	%r15
1800022c0:     	subq	$0x68, %rsp
1800022c4:     	movq	%rcx, %r14
1800022c7:     	movq	%r9, %r15
1800022ca:     	leaq	0x233f(%rip), %rcx      # 0x180004610
1800022d1:     	movq	%r8, %r13
1800022d4:     	movq	%rdx, %rsi
1800022d7:     	callq	*0x1f2b(%rip)           # 0x180004208
1800022dd:     	movq	%rax, %rdi
1800022e0:     	testq	%rax, %rax
1800022e3:     	jne	0x18000231c <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xa8c>
1800022e5:     	movq	0x1e24(%rip), %rcx      # 0x180004110
1800022ec:     	movq	(%rcx), %rcx
1800022ef:     	callq	*0x1ea3(%rip)           # 0x180004198
1800022f5:     	testl	%eax, %eax
1800022f7:     	je	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
1800022fd:     	callq	*0x1e55(%rip)           # 0x180004158
180002303:     	leaq	0x2326(%rip), %rcx      # 0x180004630
18000230a:     	callq	*0x1ef8(%rip)           # 0x180004208
180002310:     	movq	%rax, %rdi
180002313:     	testq	%rax, %rax
180002316:     	je	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
18000231c:     	leaq	0x232d(%rip), %rdx      # 0x180004650
180002323:     	movq	%rdi, %rcx
180002326:     	callq	*0x1e34(%rip)           # 0x180004160
18000232c:     	movl	(%rdi), %ecx
18000232e:     	movq	%rax, %rbx
180002331:     	testl	%ecx, %ecx
180002333:     	js	0x180002345 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xab5>
180002335:     	subl	$0x1, %ecx
180002338:     	movl	%ecx, (%rdi)
18000233a:     	jne	0x180002345 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xab5>
18000233c:     	movq	%rdi, %rcx
18000233f:     	callq	*0x1e6b(%rip)           # 0x1800041b0
180002345:     	testq	%rbx, %rbx
180002348:     	je	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
18000234e:     	movq	0x1d93(%rip), %rax      # 0x1800040e8
180002355:     	cmpq	%rax, 0x8(%rbx)
180002359:     	je	0x180002395 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb05>
18000235b:     	movq	0x1ed6(%rip), %rcx      # 0x180004238
180002362:     	leaq	0x22f7(%rip), %rdx      # 0x180004660
180002369:     	movq	(%rcx), %rcx
18000236c:     	callq	*0x1ebe(%rip)           # 0x180004230
180002372:     	movl	(%rbx), %eax
180002374:     	testl	%eax, %eax
180002376:     	js	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
18000237c:     	subl	$0x1, %eax
18000237f:     	movl	%eax, (%rbx)
180002381:     	jne	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
180002387:     	movq	%rbx, %rcx
18000238a:     	callq	*0x1e20(%rip)           # 0x1800041b0
180002390:     	jmp	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
180002395:     	xorl	%edx, %edx
180002397:     	movq	%rbx, %rcx
18000239a:     	callq	*0x1df0(%rip)           # 0x180004190
1800023a0:     	movl	(%rbx), %ecx
1800023a2:     	movq	%rax, 0x8897(%rip)      # 0x18000ac40
1800023a9:     	testl	%ecx, %ecx
1800023ab:     	js	0x1800023c4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb34>
1800023ad:     	subl	$0x1, %ecx
1800023b0:     	movl	%ecx, (%rbx)
1800023b2:     	jne	0x1800023c4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb34>
1800023b4:     	movq	%rbx, %rcx
1800023b7:     	callq	*0x1df3(%rip)           # 0x1800041b0
1800023bd:     	movq	0x887c(%rip), %rax      # 0x18000ac40
1800023c4:     	testq	%rax, %rax
1800023c7:     	jne	0x1800023e2 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb52>
1800023c9:     	leaq	0x22b8(%rip), %rdx      # 0x180004688
1800023d0:     	movq	0x1e61(%rip), %rcx      # 0x180004238
1800023d7:     	movq	(%rcx), %rcx
1800023da:     	callq	*0x1e50(%rip)           # 0x180004230
1800023e0:     	jmp	0x180002417 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb87>
1800023e2:     	callq	*(%rax)
1800023e4:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
1800023e9:     	jbe	0x18000244a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xbba>
1800023eb:     	movq	0x1e46(%rip), %rax      # 0x180004238
1800023f2:     	movq	(%rax), %rbx
1800023f5:     	movq	0x8844(%rip), %rax      # 0x18000ac40
1800023fc:     	callq	*(%rax)
1800023fe:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002404:     	leaq	0x22a5(%rip), %rdx      # 0x1800046b0
18000240b:     	movl	%eax, %r9d
18000240e:     	movq	%rbx, %rcx
180002411:     	callq	*0x1db1(%rip)           # 0x1800041c8
180002417:     	callq	*0x1e4b(%rip)           # 0x180004268
18000241d:     	movq	0x1cd4(%rip), %rcx      # 0x1800040f8
180002424:     	leaq	0x24ad(%rip), %rdx      # 0x1800048d8
18000242b:     	movq	(%rcx), %rcx
18000242e:     	callq	*0x1dfc(%rip)           # 0x180004230
180002434:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002439:     	addq	$0x68, %rsp
18000243d:     	popq	%r15
18000243f:     	popq	%r14
180002441:     	popq	%r13
180002443:     	popq	%r12
180002445:     	popq	%rdi
180002446:     	popq	%rsi
180002447:     	popq	%rbp
180002448:     	popq	%rbx
180002449:     	retq
18000244a:     	movq	0x87ef(%rip), %rax      # 0x18000ac40
180002451:     	callq	*0x698(%rax)
180002457:     	movl	%eax, 0x87ef(%rip)      # 0x18000ac4c
18000245d:     	cmpl	$0x10, %eax
180002460:     	jge	0x18000247e <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xbee>
180002462:     	movq	0x1dcf(%rip), %rcx      # 0x180004238
180002469:     	leaq	0x2290(%rip), %rdx      # 0x180004700
180002470:     	movl	%eax, %r9d
180002473:     	movl	$0x10, %r8d
180002479:     	movq	(%rcx), %rcx
18000247c:     	jmp	0x180002411 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb81>
18000247e:     	movq	0x87bb(%rip), %rax      # 0x18000ac40
180002485:     	callq	*0x690(%rax)
18000248b:     	testl	%eax, %eax
18000248d:     	jne	0x18000249b <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xc0b>
18000248f:     	leaq	0x23ba(%rip), %rdx      # 0x180004850
180002496:     	jmp	0x1800023d0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb40>
18000249b:     	cmpl	$0x1, %eax
18000249e:     	je	0x1800024ac <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xc1c>
1800024a0:     	leaq	0x23d9(%rip), %rdx      # 0x180004880
1800024a7:     	jmp	0x1800023d0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xb40>
1800024ac:     	leaq	0x832d(%rip), %rcx      # 0x18000a7e0
1800024b3:     	callq	*0x1caf(%rip)           # 0x180004168
1800024b9:     	testl	%eax, %eax
1800024bb:     	jne	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
1800024c1:     	leaq	0x7e38(%rip), %rcx      # 0x18000a300
1800024c8:     	callq	*0x1c9a(%rip)           # 0x180004168
1800024ce:     	testl	%eax, %eax
1800024d0:     	jne	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
1800024d6:     	leaq	0x8163(%rip), %rcx      # 0x18000a640
1800024dd:     	callq	*0x1c85(%rip)           # 0x180004168
1800024e3:     	testl	%eax, %eax
1800024e5:     	jne	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
1800024eb:     	xorl	%ebx, %ebx
1800024ed:     	cmpl	%ebx, 0x8755(%rip)      # 0x18000ac48
1800024f3:     	jne	0x180002536 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xca6>
1800024f5:     	movq	%gs:0x58, %rax
1800024fe:     	movl	0x8754(%rip), %ecx      # 0x18000ac58
180002504:     	movl	$0x1, 0x873a(%rip)      # 0x18000ac48
18000250e:     	movq	(%rax,%rcx,8), %rdx
180002512:     	movl	$0x10, %eax
180002517:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000251e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002523:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000252a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000252f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180002536:     	movl	%ebx, 0x86bc(%rip)      # 0x18000abf8
18000253c:     	movq	%rbx, %rax
18000253f:     	movb	%bl, 0x86bb(%rip)       # 0x18000ac00
180002545:     	movq	%rbx, %rcx
180002548:     	xchgq	%rax, 0x86b9(%rip)      # 0x18000ac08
18000254f:     	xchgq	%rcx, 0x86ba(%rip)      # 0x18000ac10
180002556:     	movq	%rbx, %rax
180002559:     	movq	%rbx, %rcx
18000255c:     	xchgq	%rax, 0x86b5(%rip)      # 0x18000ac18
180002563:     	xchgq	%rcx, 0x86b6(%rip)      # 0x18000ac20
18000256a:     	movq	0x1aef(%rip), %rax      # 0x180004060
180002571:     	leaq	0x7f28(%rip), %rcx      # 0x18000a4a0
180002578:     	movq	%rax, 0x86a9(%rip)      # 0x18000ac28
18000257f:     	movq	0x1aea(%rip), %rax      # 0x180004070
180002586:     	movq	%rax, 0x86a3(%rip)      # 0x18000ac30
18000258d:     	movq	0x1ad4(%rip), %rax      # 0x180004068
180002594:     	movq	%rax, 0x869d(%rip)      # 0x18000ac38
18000259b:     	movq	0x1c6e(%rip), %rax      # 0x180004210
1800025a2:     	movq	%rax, 0x802f(%rip)      # 0x18000a5d8
1800025a9:     	callq	*0x1bb9(%rip)           # 0x180004168
1800025af:     	testl	%eax, %eax
1800025b1:     	jne	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
1800025b7:     	leaq	0x23aa(%rip), %rdx      # 0x180004968
1800025be:     	movq	%r14, %rcx
1800025c1:     	callq	*0x1b99(%rip)           # 0x180004160
1800025c7:     	movq	%rax, 0x28(%rsp)
1800025cc:     	movq	%rax, %rdi
1800025cf:     	testq	%rax, %rax
1800025d2:     	je	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
1800025d8:     	leaq	0x2522(%rip), %rcx      # 0x180004b01
1800025df:     	callq	*0x1b1b(%rip)           # 0x180004100
1800025e5:     	movq	%rax, 0x20(%rsp)
1800025ea:     	movq	%rax, %r12
1800025ed:     	testq	%rax, %rax
1800025f0:     	je	0x180002934 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x10a4>
1800025f6:     	movl	%ebx, %ebp
1800025f8:     	cmpq	%rbx, (%rsi)
1800025fb:     	je	0x1800027a4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xf14>
180002601:     	movslq	%ebp, %rbx
180002604:     	leaq	0x30(%rsp), %rdx
180002609:     	movq	%r14, %rcx
18000260c:     	leaq	(%rbx,%rbx,4), %rax
180002610:     	movups	(%r13,%rax,8), %xmm0
180002616:     	movups	0x10(%r13,%rax,8), %xmm1
18000261c:     	movaps	%xmm0, 0x30(%rsp)
180002621:     	movsd	0x20(%r13,%rax,8), %xmm0
180002628:     	movsd	%xmm0, 0x50(%rsp)
18000262e:     	movaps	%xmm1, 0x40(%rsp)
180002633:     	callq	0x180002130 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x8a0>
180002638:     	movq	%rax, %r14
18000263b:     	testq	%rax, %rax
18000263e:     	je	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
180002644:     	movq	(%rsi), %rcx
180002647:     	callq	*0x1ab3(%rip)           # 0x180004100
18000264d:     	movq	%rax, %r13
180002650:     	testq	%rax, %rax
180002653:     	je	0x180002957 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x10c7>
180002659:     	movq	(%r15,%rbx,8), %rcx
18000265d:     	xorl	%edx, %edx
18000265f:     	movq	%r14, (%rcx)
180002662:     	leaq	0x8177(%rip), %rcx      # 0x18000a7e0
180002669:     	movq	0x8(%rsi), %r12
18000266d:     	callq	*0x1ad5(%rip)           # 0x180004148
180002673:     	movq	%rax, %rbx
180002676:     	testq	%rax, %rax
180002679:     	je	0x1800026f6 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe66>
18000267b:     	movq	%r13, %rcx
18000267e:     	callq	*0x1af4(%rip)           # 0x180004178
180002684:     	movq	%rax, %rdi
180002687:     	testq	%rax, %rax
18000268a:     	je	0x1800026ac <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe1c>
18000268c:     	movq	%rax, %rcx
18000268f:     	callq	0x180003ee5 <numba_list_iter_next+0xe85>
180002694:     	leaq	0x1(%rax), %rcx
180002698:     	callq	*0x1b7a(%rip)           # 0x180004218
18000269e:     	movq	%rax, %rsi
1800026a1:     	testq	%rax, %rax
1800026a4:     	jne	0x1800026b4 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe24>
1800026a6:     	callq	*0x1a8c(%rip)           # 0x180004138
1800026ac:     	xorl	%eax, %eax
1800026ae:     	movq	%rax, 0x20(%rbx)
1800026b2:     	jmp	0x1800026e5 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe55>
1800026b4:     	movq	%rdi, %rdx
1800026b7:     	movq	%rsi, %rcx
1800026ba:     	callq	0x180003edf <numba_list_iter_next+0xe7f>
1800026bf:     	movq	0x20(%rsp), %rcx
1800026c4:     	movq	%rsi, 0x20(%rbx)
1800026c8:     	movq	%r12, 0x28(%rbx)
1800026cc:     	movl	$0x3, 0x30(%rbx)
1800026d3:     	callq	0x180001bb0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x320>
1800026d8:     	movq	%rax, 0x38(%rbx)
1800026dc:     	testq	%rax, %rax
1800026df:     	jne	0x180002850 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfc0>
1800026e5:     	movl	(%rbx), %eax
1800026e7:     	testl	%eax, %eax
1800026e9:     	js	0x1800026f6 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe66>
1800026eb:     	subl	$0x1, %eax
1800026ee:     	movl	%eax, (%rbx)
1800026f0:     	je	0x18000289d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x100d>
1800026f6:     	xorl	%edi, %edi
1800026f8:     	movl	(%r14), %eax
1800026fb:     	testl	%eax, %eax
1800026fd:     	js	0x180002710 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe80>
1800026ff:     	subl	$0x1, %eax
180002702:     	movl	%eax, (%r14)
180002705:     	jne	0x180002710 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe80>
180002707:     	movq	%r14, %rcx
18000270a:     	callq	*0x1aa0(%rip)           # 0x1800041b0
180002710:     	movl	(%r13), %eax
180002714:     	testl	%eax, %eax
180002716:     	js	0x18000272a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe9a>
180002718:     	subl	$0x1, %eax
18000271b:     	movl	%eax, (%r13)
18000271f:     	jne	0x18000272a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe9a>
180002721:     	movq	%r13, %rcx
180002724:     	callq	*0x1a86(%rip)           # 0x1800041b0
18000272a:     	testq	%rdi, %rdi
18000272d:     	je	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
180002733:     	movq	0xb8(%rsp), %rsi
18000273b:     	movq	%rdi, %r8
18000273e:     	movq	0xb0(%rsp), %r14
180002746:     	movq	%r14, %rcx
180002749:     	movq	(%rsi), %rdx
18000274c:     	callq	*0x1aa6(%rip)           # 0x1800041f8
180002752:     	movl	(%rdi), %ecx
180002754:     	testl	%eax, %eax
180002756:     	jne	0x1800028fa <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x106a>
18000275c:     	testl	%ecx, %ecx
18000275e:     	js	0x180002772 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xee2>
180002760:     	leal	-0x1(%rcx), %eax
180002763:     	movl	%eax, (%rdi)
180002765:     	testl	%eax, %eax
180002767:     	jne	0x180002772 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xee2>
180002769:     	movq	%rdi, %rcx
18000276c:     	callq	*0x1a3e(%rip)           # 0x1800041b0
180002772:     	movq	0xc8(%rsp), %r15
18000277a:     	addq	$0x20, %rsi
18000277e:     	movq	0xc0(%rsp), %r13
180002786:     	incl	%ebp
180002788:     	movq	%rsi, 0xb8(%rsp)
180002790:     	cmpq	$0x0, (%rsi)
180002794:     	jne	0x180002601 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xd71>
18000279a:     	movq	0x20(%rsp), %r12
18000279f:     	movq	0x28(%rsp), %rdi
1800027a4:     	movslq	%ebp, %rax
1800027a7:     	cmpq	$0x0, (%r15,%rax,8)
1800027ac:     	je	0x180002819 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xf89>
1800027ae:     	nop
1800027b0:     	movslq	%ebp, %rbx
1800027b3:     	leaq	0x30(%rsp), %rdx
1800027b8:     	movq	%r14, %rcx
1800027bb:     	leaq	(%rbx,%rbx,4), %rax
1800027bf:     	movups	(%r13,%rax,8), %xmm0
1800027c5:     	movups	0x10(%r13,%rax,8), %xmm1
1800027cb:     	movaps	%xmm0, 0x30(%rsp)
1800027d0:     	movsd	0x20(%r13,%rax,8), %xmm0
1800027d7:     	movsd	%xmm0, 0x50(%rsp)
1800027dd:     	movaps	%xmm1, 0x40(%rsp)
1800027e2:     	callq	0x180002130 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x8a0>
1800027e7:     	testq	%rax, %rax
1800027ea:     	je	0x180002915 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1085>
1800027f0:     	movq	(%r15,%rbx,8), %rcx
1800027f4:     	movq	%rax, (%rcx)
1800027f7:     	movl	(%rax), %ecx
1800027f9:     	testl	%ecx, %ecx
1800027fb:     	js	0x18000280d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xf7d>
1800027fd:     	subl	$0x1, %ecx
180002800:     	movl	%ecx, (%rax)
180002802:     	jne	0x18000280d <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xf7d>
180002804:     	movq	%rax, %rcx
180002807:     	callq	*0x19a3(%rip)           # 0x1800041b0
18000280d:     	incl	%ebp
18000280f:     	movslq	%ebp, %rax
180002812:     	cmpq	$0x0, (%r15,%rax,8)
180002817:     	jne	0x1800027b0 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xf20>
180002819:     	movl	(%r12), %eax
18000281d:     	testl	%eax, %eax
18000281f:     	js	0x180002833 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfa3>
180002821:     	subl	$0x1, %eax
180002824:     	movl	%eax, (%r12)
180002828:     	jne	0x180002833 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfa3>
18000282a:     	movq	%r12, %rcx
18000282d:     	callq	*0x197d(%rip)           # 0x1800041b0
180002833:     	movl	(%rdi), %eax
180002835:     	testl	%eax, %eax
180002837:     	js	0x180002849 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfb9>
180002839:     	subl	$0x1, %eax
18000283c:     	movl	%eax, (%rdi)
18000283e:     	jne	0x180002849 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfb9>
180002840:     	movq	%rdi, %rcx
180002843:     	callq	*0x1967(%rip)           # 0x1800041b0
180002849:     	xorl	%eax, %eax
18000284b:     	jmp	0x180002439 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba9>
180002850:     	movl	(%r14), %eax
180002853:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002858:     	jae	0x18000285f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xfcf>
18000285a:     	incl	%eax
18000285c:     	movl	%eax, (%r14)
18000285f:     	movq	0xb0(%rsp), %rcx
180002867:     	leaq	0x20fa(%rip), %rdx      # 0x180004968
18000286e:     	movq	%r14, 0x18(%rbx)
180002872:     	movq	$0x0, 0x40(%rbx)
18000287a:     	callq	*0x18e0(%rip)           # 0x180004160
180002880:     	movq	%rax, %rsi
180002883:     	testq	%rax, %rax
180002886:     	jne	0x1800028ab <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x101b>
180002888:     	movl	(%rbx), %eax
18000288a:     	testl	%eax, %eax
18000288c:     	js	0x1800026f6 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe66>
180002892:     	subl	$0x1, %eax
180002895:     	movl	%eax, (%rbx)
180002897:     	jne	0x1800026f6 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe66>
18000289d:     	movq	%rbx, %rcx
1800028a0:     	callq	*0x190a(%rip)           # 0x1800041b0
1800028a6:     	jmp	0x1800026f6 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe66>
1800028ab:     	xorl	%r9d, %r9d
1800028ae:     	leaq	0x20(%rbx), %rcx
1800028b2:     	movq	%rsi, %r8
1800028b5:     	movq	%rbx, %rdx
1800028b8:     	callq	*0x1882(%rip)           # 0x180004140
1800028be:     	movq	%rax, %rdi
1800028c1:     	movl	(%rbx), %eax
1800028c3:     	testl	%eax, %eax
1800028c5:     	js	0x1800028d7 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1047>
1800028c7:     	subl	$0x1, %eax
1800028ca:     	movl	%eax, (%rbx)
1800028cc:     	jne	0x1800028d7 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1047>
1800028ce:     	movq	%rbx, %rcx
1800028d1:     	callq	*0x18d9(%rip)           # 0x1800041b0
1800028d7:     	movl	(%rsi), %eax
1800028d9:     	testl	%eax, %eax
1800028db:     	js	0x1800026f8 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe68>
1800028e1:     	subl	$0x1, %eax
1800028e4:     	movl	%eax, (%rsi)
1800028e6:     	jne	0x1800026f8 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe68>
1800028ec:     	movq	%rsi, %rcx
1800028ef:     	callq	*0x18bb(%rip)           # 0x1800041b0
1800028f5:     	jmp	0x1800026f8 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xe68>
1800028fa:     	testl	%ecx, %ecx
1800028fc:     	js	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
1800028fe:     	leal	-0x1(%rcx), %eax
180002901:     	movl	%eax, (%rdi)
180002903:     	testl	%eax, %eax
180002905:     	jne	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
180002907:     	movq	%rdi, %rcx
18000290a:     	callq	*0x18a0(%rip)           # 0x1800041b0
180002910:     	movq	0x20(%rsp), %r12
180002915:     	movl	(%r12), %eax
180002919:     	testl	%eax, %eax
18000291b:     	js	0x18000292f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x109f>
18000291d:     	subl	$0x1, %eax
180002920:     	movl	%eax, (%r12)
180002924:     	jne	0x18000292f <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x109f>
180002926:     	movq	%r12, %rcx
180002929:     	callq	*0x1881(%rip)           # 0x1800041b0
18000292f:     	movq	0x28(%rsp), %rdi
180002934:     	movl	(%rdi), %eax
180002936:     	testl	%eax, %eax
180002938:     	js	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
18000293e:     	subl	$0x1, %eax
180002941:     	movl	%eax, (%rdi)
180002943:     	jne	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
180002949:     	movq	%rdi, %rcx
18000294c:     	callq	*0x185e(%rip)           # 0x1800041b0
180002952:     	jmp	0x180002434 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0xba4>
180002957:     	movl	(%r14), %eax
18000295a:     	testl	%eax, %eax
18000295c:     	js	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
18000295e:     	subl	$0x1, %eax
180002961:     	movl	%eax, (%r14)
180002964:     	jne	0x180002910 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x1080>
180002966:     	movq	%r14, %rcx
180002969:     	jmp	0x18000290a <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x107a>
18000296b:     	int3
18000296c:     	int3
18000296d:     	int3
18000296e:     	int3
18000296f:     	int3
180002970:     	leaq	0x82f9(%rip), %rax      # 0x18000ac70
180002977:     	retq
180002978:     	int3
180002979:     	int3
18000297a:     	int3
18000297b:     	int3
18000297c:     	int3
18000297d:     	int3
18000297e:     	int3
18000297f:     	int3

0000000180002980 <numba_list_set_method_table>:
180002980:     	movups	(%rdx), %xmm0
180002983:     	movups	%xmm0, 0x20(%rcx)
180002987:     	retq
180002988:     	int3
180002989:     	int3
18000298a:     	int3
18000298b:     	int3
18000298c:     	int3
18000298d:     	int3
18000298e:     	int3
18000298f:     	int3

0000000180002990 <numba_list_new>:
180002990:     	pushq	%rbx
180002992:     	pushq	%rbp
180002993:     	pushq	%rsi
180002994:     	pushq	%rdi
180002995:     	subq	$0x28, %rsp
180002999:     	movq	%rcx, %rsi
18000299c:     	movq	%r8, %rdi
18000299f:     	movl	$0x38, %ecx
1800029a4:     	movq	%rdx, %rbp
1800029a7:     	callq	*0x16b3(%rip)           # 0x180004060
1800029ad:     	movq	%rax, %rbx
1800029b0:     	testq	%rax, %rax
1800029b3:     	je	0x180002a1d <numba_list_new+0x8d>
1800029b5:     	movq	$0x0, (%rax)
1800029bc:     	xorps	%xmm0, %xmm0
1800029bf:     	movq	%rbp, 0x8(%rax)
1800029c3:     	movq	%rdi, 0x10(%rax)
1800029c7:     	movl	$0x1, 0x18(%rax)
1800029ce:     	movups	%xmm0, 0x20(%rax)
1800029d2:     	testq	%rdi, %rdi
1800029d5:     	je	0x180002a2b <numba_list_new+0x9b>
1800029d7:     	imulq	%rbp, %rdi
1800029db:     	movl	$0x8, %ecx
1800029e0:     	movq	%rdi, %rax
1800029e3:     	cqto
1800029e5:     	andl	$0x7, %edx
1800029e8:     	addq	%rdx, %rax
1800029eb:     	andl	$0x7, %eax
1800029ee:     	subq	%rdx, %rax
1800029f1:     	subq	%rax, %rcx
1800029f4:     	movq	%rcx, %rax
1800029f7:     	cqto
1800029f9:     	andl	$0x7, %edx
1800029fc:     	leaq	(%rdx,%rax), %rcx
180002a00:     	andl	$0x7, %ecx
180002a03:     	subq	%rdx, %rcx
180002a06:     	addq	%rdi, %rcx
180002a09:     	callq	*0x1651(%rip)           # 0x180004060
180002a0f:     	testq	%rax, %rax
180002a12:     	jne	0x180002a2d <numba_list_new+0x9d>
180002a14:     	movq	%rbx, %rcx
180002a17:     	callq	*0x164b(%rip)           # 0x180004068
180002a1d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002a22:     	addq	$0x28, %rsp
180002a26:     	popq	%rdi
180002a27:     	popq	%rsi
180002a28:     	popq	%rbp
180002a29:     	popq	%rbx
180002a2a:     	retq
180002a2b:     	xorl	%eax, %eax
180002a2d:     	movq	%rax, 0x30(%rbx)
180002a31:     	xorl	%eax, %eax
180002a33:     	movq	%rbx, (%rsi)
180002a36:     	addq	$0x28, %rsp
180002a3a:     	popq	%rdi
180002a3b:     	popq	%rsi
180002a3c:     	popq	%rbp
180002a3d:     	popq	%rbx
180002a3e:     	retq
180002a3f:     	int3

0000000180002a40 <numba_list_free>:
180002a40:     	pushq	%rbx
180002a42:     	subq	$0x20, %rsp
180002a46:     	cmpq	$0x0, 0x28(%rcx)
180002a4b:     	movq	%rcx, %rbx
180002a4e:     	je	0x180002a84 <numba_list_free+0x44>
180002a50:     	movq	%rdi, 0x30(%rsp)
180002a55:     	xorl	%edi, %edi
180002a57:     	cmpq	%rdi, (%rcx)
180002a5a:     	jle	0x180002a7f <numba_list_free+0x3f>
180002a5c:     	nopl	(%rax)
180002a60:     	movq	0x28(%rbx), %rax
180002a64:     	testq	%rax, %rax
180002a67:     	je	0x180002a77 <numba_list_free+0x37>
180002a69:     	movq	%rdi, %rcx
180002a6c:     	imulq	0x8(%rbx), %rcx
180002a71:     	addq	0x30(%rbx), %rcx
180002a75:     	callq	*%rax
180002a77:     	incq	%rdi
180002a7a:     	cmpq	(%rbx), %rdi
180002a7d:     	jl	0x180002a60 <numba_list_free+0x20>
180002a7f:     	movq	0x30(%rsp), %rdi
180002a84:     	movq	0x30(%rbx), %rcx
180002a88:     	testq	%rcx, %rcx
180002a8b:     	je	0x180002a93 <numba_list_free+0x53>
180002a8d:     	callq	*0x15d5(%rip)           # 0x180004068
180002a93:     	movq	%rbx, %rcx
180002a96:     	addq	$0x20, %rsp
180002a9a:     	popq	%rbx
180002a9b:     	jmpq	*0x15c6(%rip)           # 0x180004068
180002aa2:     	int3
180002aa3:     	int3
180002aa4:     	int3
180002aa5:     	int3
180002aa6:     	int3
180002aa7:     	int3
180002aa8:     	int3
180002aa9:     	int3
180002aaa:     	int3
180002aab:     	int3
180002aac:     	int3
180002aad:     	int3
180002aae:     	int3
180002aaf:     	int3

0000000180002ab0 <numba_list_base_ptr>:
180002ab0:     	movq	0x30(%rcx), %rax
180002ab4:     	retq
180002ab5:     	int3
180002ab6:     	int3
180002ab7:     	int3
180002ab8:     	int3
180002ab9:     	int3
180002aba:     	int3
180002abb:     	int3
180002abc:     	int3
180002abd:     	int3
180002abe:     	int3
180002abf:     	int3

0000000180002ac0 <numba_list_size_address>:
180002ac0:     	movq	%rcx, %rax
180002ac3:     	retq
180002ac4:     	int3
180002ac5:     	int3
180002ac6:     	int3
180002ac7:     	int3
180002ac8:     	int3
180002ac9:     	int3
180002aca:     	int3
180002acb:     	int3
180002acc:     	int3
180002acd:     	int3
180002ace:     	int3
180002acf:     	int3

0000000180002ad0 <numba_list_length>:
180002ad0:     	movq	(%rcx), %rax
180002ad3:     	retq
180002ad4:     	int3
180002ad5:     	int3
180002ad6:     	int3
180002ad7:     	int3
180002ad8:     	int3
180002ad9:     	int3
180002ada:     	int3
180002adb:     	int3
180002adc:     	int3
180002add:     	int3
180002ade:     	int3
180002adf:     	int3

0000000180002ae0 <numba_list_allocated>:
180002ae0:     	movq	0x10(%rcx), %rax
180002ae4:     	retq
180002ae5:     	int3
180002ae6:     	int3
180002ae7:     	int3
180002ae8:     	int3
180002ae9:     	int3
180002aea:     	int3
180002aeb:     	int3
180002aec:     	int3
180002aed:     	int3
180002aee:     	int3
180002aef:     	int3

0000000180002af0 <numba_list_is_mutable>:
180002af0:     	movl	0x18(%rcx), %eax
180002af3:     	retq
180002af4:     	int3
180002af5:     	int3
180002af6:     	int3
180002af7:     	int3
180002af8:     	int3
180002af9:     	int3
180002afa:     	int3
180002afb:     	int3
180002afc:     	int3
180002afd:     	int3
180002afe:     	int3
180002aff:     	int3

0000000180002b00 <numba_list_set_is_mutable>:
180002b00:     	movl	%edx, 0x18(%rcx)
180002b03:     	retq
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

0000000180002b10 <numba_list_setitem>:
180002b10:     	movq	%rbx, 0x10(%rsp)
180002b15:     	pushq	%rsi
180002b16:     	subq	$0x20, %rsp
180002b1a:     	cmpl	$0x0, 0x18(%rcx)
180002b1e:     	movq	%r8, %rsi
180002b21:     	movq	%rcx, %rbx
180002b24:     	jne	0x180002b36 <numba_list_setitem+0x26>
180002b26:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002b2b:     	movq	0x38(%rsp), %rbx
180002b30:     	addq	$0x20, %rsp
180002b34:     	popq	%rsi
180002b35:     	retq
180002b36:     	cmpq	(%rcx), %rdx
180002b39:     	jb	0x180002b4b <numba_list_setitem+0x3b>
180002b3b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002b40:     	movq	0x38(%rsp), %rbx
180002b45:     	addq	$0x20, %rsp
180002b49:     	popq	%rsi
180002b4a:     	retq
180002b4b:     	imulq	0x8(%rcx), %rdx
180002b50:     	movq	0x28(%rcx), %rax
180002b54:     	movq	%rdi, 0x30(%rsp)
180002b59:     	movq	0x30(%rcx), %rdi
180002b5d:     	addq	%rdx, %rdi
180002b60:     	testq	%rax, %rax
180002b63:     	je	0x180002b6a <numba_list_setitem+0x5a>
180002b65:     	movq	%rdi, %rcx
180002b68:     	callq	*%rax
180002b6a:     	movq	0x8(%rbx), %r8
180002b6e:     	movq	%rsi, %rdx
180002b71:     	movq	%rdi, %rcx
180002b74:     	callq	0x180003ed3 <numba_list_iter_next+0xe73>
180002b79:     	movq	0x20(%rbx), %rax
180002b7d:     	testq	%rax, %rax
180002b80:     	je	0x180002b87 <numba_list_setitem+0x77>
180002b82:     	movq	%rdi, %rcx
180002b85:     	callq	*%rax
180002b87:     	movq	0x30(%rsp), %rdi
180002b8c:     	xorl	%eax, %eax
180002b8e:     	movq	0x38(%rsp), %rbx
180002b93:     	addq	$0x20, %rsp
180002b97:     	popq	%rsi
180002b98:     	retq
180002b99:     	int3
180002b9a:     	int3
180002b9b:     	int3
180002b9c:     	int3
180002b9d:     	int3
180002b9e:     	int3
180002b9f:     	int3

0000000180002ba0 <numba_list_getitem>:
180002ba0:     	subq	$0x28, %rsp
180002ba4:     	movq	%r8, %r9
180002ba7:     	movq	%rdx, %rax
180002baa:     	cmpq	(%rcx), %rdx
180002bad:     	jb	0x180002bb9 <numba_list_getitem+0x19>
180002baf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002bb4:     	addq	$0x28, %rsp
180002bb8:     	retq
180002bb9:     	movq	0x8(%rcx), %r8
180002bbd:     	movq	%r8, %rdx
180002bc0:     	imulq	%rax, %rdx
180002bc4:     	addq	0x30(%rcx), %rdx
180002bc8:     	movq	%r9, %rcx
180002bcb:     	callq	0x180003ed3 <numba_list_iter_next+0xe73>
180002bd0:     	xorl	%eax, %eax
180002bd2:     	addq	$0x28, %rsp
180002bd6:     	retq
180002bd7:     	int3
180002bd8:     	int3
180002bd9:     	int3
180002bda:     	int3
180002bdb:     	int3
180002bdc:     	int3
180002bdd:     	int3
180002bde:     	int3
180002bdf:     	int3

0000000180002be0 <numba_list_append>:
180002be0:     	movq	%rbx, 0x10(%rsp)
180002be5:     	pushq	%rsi
180002be6:     	subq	$0x20, %rsp
180002bea:     	cmpl	$0x0, 0x18(%rcx)
180002bee:     	movq	%rdx, %rsi
180002bf1:     	movq	%rcx, %rbx
180002bf4:     	jne	0x180002c06 <numba_list_append+0x26>
180002bf6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002bfb:     	movq	0x38(%rsp), %rbx
180002c00:     	addq	$0x20, %rsp
180002c04:     	popq	%rsi
180002c05:     	retq
180002c06:     	movq	(%rcx), %rdx
180002c09:     	incq	%rdx
180002c0c:     	callq	0x180002c60 <numba_list_resize>
180002c11:     	testl	%eax, %eax
180002c13:     	js	0x180002c4c <numba_list_append+0x6c>
180002c15:     	movq	0x8(%rbx), %r8
180002c19:     	movq	%rsi, %rdx
180002c1c:     	movq	%rdi, 0x30(%rsp)
180002c21:     	movq	(%rbx), %rdi
180002c24:     	decq	%rdi
180002c27:     	imulq	%r8, %rdi
180002c2b:     	addq	0x30(%rbx), %rdi
180002c2f:     	movq	%rdi, %rcx
180002c32:     	callq	0x180003ed3 <numba_list_iter_next+0xe73>
180002c37:     	movq	0x20(%rbx), %rax
180002c3b:     	testq	%rax, %rax
180002c3e:     	je	0x180002c45 <numba_list_append+0x65>
180002c40:     	movq	%rdi, %rcx
180002c43:     	callq	*%rax
180002c45:     	movq	0x30(%rsp), %rdi
180002c4a:     	xorl	%eax, %eax
180002c4c:     	movq	0x38(%rsp), %rbx
180002c51:     	addq	$0x20, %rsp
180002c55:     	popq	%rsi
180002c56:     	retq
180002c57:     	int3
180002c58:     	int3
180002c59:     	int3
180002c5a:     	int3
180002c5b:     	int3
180002c5c:     	int3
180002c5d:     	int3
180002c5e:     	int3
180002c5f:     	int3

0000000180002c60 <numba_list_resize>:
180002c60:     	movq	%rsi, 0x18(%rsp)
180002c65:     	pushq	%rdi
180002c66:     	subq	$0x20, %rsp
180002c6a:     	cmpl	$0x0, 0x18(%rcx)
180002c6e:     	movq	%rdx, %rsi
180002c71:     	movq	%rcx, %rdi
180002c74:     	jne	0x180002c86 <numba_list_resize+0x26>
180002c76:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002c7b:     	movq	0x40(%rsp), %rsi
180002c80:     	addq	$0x20, %rsp
180002c84:     	popq	%rdi
180002c85:     	retq
180002c86:     	movq	0x10(%rcx), %rax
180002c8a:     	cmpq	%rsi, %rax
180002c8d:     	jl	0x180002ca7 <numba_list_resize+0x47>
180002c8f:     	sarq	%rax
180002c92:     	cmpq	%rax, %rsi
180002c95:     	jl	0x180002ca7 <numba_list_resize+0x47>
180002c97:     	movq	%rsi, (%rcx)
180002c9a:     	xorl	%eax, %eax
180002c9c:     	movq	0x40(%rsp), %rsi
180002ca1:     	addq	$0x20, %rsp
180002ca5:     	popq	%rdi
180002ca6:     	retq
180002ca7:     	cmpq	$0x9, %rsi
180002cab:     	movq	%rbp, 0x38(%rsp)
180002cb0:     	movl	$0x3, %ecx
180002cb5:     	movl	$0x6, %eax
180002cba:     	cmovll	%ecx, %eax
180002cbd:     	movq	%rsi, %r8
180002cc0:     	movq	0x8(%rdi), %rcx
180002cc4:     	addq	%rsi, %rax
180002cc7:     	sarq	$0x3, %r8
180002ccb:     	xorl	%edx, %edx
180002ccd:     	addq	%rax, %r8
180002cd0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002cda:     	divq	%rcx
180002cdd:     	cmpq	%rax, %r8
180002ce0:     	ja	0x180002d5b <numba_list_resize+0xfb>
180002ce2:     	xorl	%ebp, %ebp
180002ce4:     	movq	%rbx, 0x30(%rsp)
180002ce9:     	testq	%rsi, %rsi
180002cec:     	cmovneq	%r8, %rbp
180002cf0:     	movq	%rbp, %rbx
180002cf3:     	imulq	%rcx, %rbx
180002cf7:     	movl	$0x8, %ecx
180002cfc:     	movq	%rbx, %rax
180002cff:     	cqto
180002d01:     	andl	$0x7, %edx
180002d04:     	addq	%rdx, %rax
180002d07:     	andl	$0x7, %eax
180002d0a:     	subq	%rdx, %rax
180002d0d:     	subq	%rax, %rcx
180002d10:     	movq	%rcx, %rax
180002d13:     	movq	0x30(%rdi), %rcx
180002d17:     	cqto
180002d19:     	andl	$0x7, %edx
180002d1c:     	addq	%rdx, %rax
180002d1f:     	andl	$0x7, %eax
180002d22:     	subq	%rdx, %rax
180002d25:     	leaq	(%rbx,%rax), %rdx
180002d29:     	callq	*0x1341(%rip)           # 0x180004070
180002d2f:     	testq	%rbx, %rbx
180002d32:     	movq	0x30(%rsp), %rbx
180002d37:     	je	0x180002d3e <numba_list_resize+0xde>
180002d39:     	testq	%rax, %rax
180002d3c:     	je	0x180002d5b <numba_list_resize+0xfb>
180002d3e:     	movq	%rax, 0x30(%rdi)
180002d42:     	xorl	%eax, %eax
180002d44:     	movq	%rbp, 0x10(%rdi)
180002d48:     	movq	0x38(%rsp), %rbp
180002d4d:     	movq	%rsi, (%rdi)
180002d50:     	movq	0x40(%rsp), %rsi
180002d55:     	addq	$0x20, %rsp
180002d59:     	popq	%rdi
180002d5a:     	retq
180002d5b:     	movq	0x38(%rsp), %rbp
180002d60:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002d65:     	movq	0x40(%rsp), %rsi
180002d6a:     	addq	$0x20, %rsp
180002d6e:     	popq	%rdi
180002d6f:     	retq

0000000180002d70 <numba_list_delitem>:
180002d70:     	movq	%rbx, 0x10(%rsp)
180002d75:     	pushq	%rdi
180002d76:     	subq	$0x20, %rsp
180002d7a:     	cmpl	$0x0, 0x18(%rcx)
180002d7e:     	movq	%rdx, %rdi
180002d81:     	movq	%rcx, %rbx
180002d84:     	jne	0x180002d96 <numba_list_delitem+0x26>
180002d86:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002d8b:     	movq	0x38(%rsp), %rbx
180002d90:     	addq	$0x20, %rsp
180002d94:     	popq	%rdi
180002d95:     	retq
180002d96:     	cmpq	(%rcx), %rdi
180002d99:     	jb	0x180002dab <numba_list_delitem+0x3b>
180002d9b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002da0:     	movq	0x38(%rsp), %rbx
180002da5:     	addq	$0x20, %rsp
180002da9:     	popq	%rdi
180002daa:     	retq
180002dab:     	movq	0x28(%rcx), %rax
180002daf:     	movq	%rsi, 0x30(%rsp)
180002db4:     	movq	%rdi, %rsi
180002db7:     	imulq	0x8(%rcx), %rsi
180002dbc:     	addq	0x30(%rcx), %rsi
180002dc0:     	testq	%rax, %rax
180002dc3:     	je	0x180002dca <numba_list_delitem+0x5a>
180002dc5:     	movq	%rsi, %rcx
180002dc8:     	callq	*%rax
180002dca:     	movq	(%rbx), %r8
180002dcd:     	leaq	-0x1(%r8), %rax
180002dd1:     	cmpq	%rax, %rdi
180002dd4:     	je	0x180002df6 <numba_list_delitem+0x86>
180002dd6:     	subq	%rdi, %r8
180002dd9:     	leaq	0x1(%rdi), %rdx
180002ddd:     	imulq	0x8(%rbx), %rdx
180002de2:     	decq	%r8
180002de5:     	movq	%rsi, %rcx
180002de8:     	imulq	0x8(%rbx), %r8
180002ded:     	addq	0x30(%rbx), %rdx
180002df1:     	callq	0x180003ed9 <numba_list_iter_next+0xe79>
180002df6:     	movq	(%rbx), %rdx
180002df9:     	movq	%rbx, %rcx
180002dfc:     	decq	%rdx
180002dff:     	callq	0x180002c60 <numba_list_resize>
180002e04:     	movq	0x30(%rsp), %rsi
180002e09:     	xorl	%ecx, %ecx
180002e0b:     	movq	0x38(%rsp), %rbx
180002e10:     	testl	%eax, %eax
180002e12:     	cmovsl	%eax, %ecx
180002e15:     	movl	%ecx, %eax
180002e17:     	addq	$0x20, %rsp
180002e1b:     	popq	%rdi
180002e1c:     	retq
180002e1d:     	int3
180002e1e:     	int3
180002e1f:     	int3

0000000180002e20 <numba_list_delete_slice>:
180002e20:     	pushq	%rbx
180002e22:     	pushq	%rbp
180002e23:     	pushq	%rdi
180002e24:     	pushq	%r15
180002e26:     	subq	$0x38, %rsp
180002e2a:     	cmpl	$0x0, 0x18(%rcx)
180002e2e:     	movq	%r9, %rdi
180002e31:     	movq	%r8, %rbp
180002e34:     	movq	%rdx, %r15
180002e37:     	movq	%rcx, %rbx
180002e3a:     	jne	0x180002e4b <numba_list_delete_slice+0x2b>
180002e3c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002e41:     	addq	$0x38, %rsp
180002e45:     	popq	%r15
180002e47:     	popq	%rdi
180002e48:     	popq	%rbp
180002e49:     	popq	%rbx
180002e4a:     	retq
180002e4b:     	movq	%r13, 0x78(%rsp)
180002e50:     	testq	%rdi, %rdi
180002e53:     	jle	0x180002e72 <numba_list_delete_slice+0x52>
180002e55:     	cmpq	%r8, %r15
180002e58:     	jge	0x180003011 <numba_list_delete_slice+0x1f1>
180002e5e:     	movq	%r8, %rax
180002e61:     	subq	%r15, %rax
180002e64:     	decq	%rax
180002e67:     	cqto
180002e69:     	idivq	%rdi
180002e6c:     	leal	0x1(%rax), %r13d
180002e70:     	jmp	0x180002e92 <numba_list_delete_slice+0x72>
180002e72:     	cmpq	%r15, %r8
180002e75:     	jge	0x180003011 <numba_list_delete_slice+0x1f1>
180002e7b:     	movq	%r15, %rax
180002e7e:     	movl	$0x1, %r13d
180002e84:     	subq	%r8, %rax
180002e87:     	decq	%rax
180002e8a:     	cqto
180002e8c:     	idivq	%rdi
180002e8f:     	subl	%eax, %r13d
180002e92:     	testl	%r13d, %r13d
180002e95:     	jle	0x180003011 <numba_list_delete_slice+0x1f1>
180002e9b:     	movq	%rsi, 0x68(%rsp)
180002ea0:     	movl	(%rcx), %esi
180002ea2:     	subl	%r13d, %esi
180002ea5:     	movl	%esi, 0x20(%rsp)
180002ea9:     	testq	%rdi, %rdi
180002eac:     	jns	0x180002ec7 <numba_list_delete_slice+0xa7>
180002eae:     	leaq	0x1(%r15), %rbp
180002eb2:     	leal	-0x1(%r13), %eax
180002eb6:     	movslq	%eax, %rcx
180002eb9:     	leaq	-0x1(%rbp), %r15
180002ebd:     	imulq	%rdi, %rcx
180002ec1:     	addq	%rcx, %r15
180002ec4:     	negq	%rdi
180002ec7:     	cmpq	$0x1, %rdi
180002ecb:     	jne	0x180002f17 <numba_list_delete_slice+0xf7>
180002ecd:     	cmpq	$0x0, 0x28(%rbx)
180002ed2:     	je	0x180002ef9 <numba_list_delete_slice+0xd9>
180002ed4:     	movslq	%r15d, %rdi
180002ed7:     	cmpq	%rbp, %rdi
180002eda:     	jge	0x180002ef9 <numba_list_delete_slice+0xd9>
180002edc:     	nopl	(%rax)
180002ee0:     	movslq	%edi, %rcx
180002ee3:     	imulq	0x8(%rbx), %rcx
180002ee8:     	addq	0x30(%rbx), %rcx
180002eec:     	callq	*0x28(%rbx)
180002eef:     	incl	%edi
180002ef1:     	movslq	%edi, %rax
180002ef4:     	cmpq	%rbp, %rax
180002ef7:     	jl	0x180002ee0 <numba_list_delete_slice+0xc0>
180002ef9:     	movq	0x8(%rbx), %rcx
180002efd:     	movq	(%rbx), %r8
180002f00:     	movq	%rcx, %rdx
180002f03:     	subq	%rbp, %r8
180002f06:     	imulq	%rcx, %r8
180002f0a:     	imulq	%rbp, %rdx
180002f0e:     	imulq	%r15, %rcx
180002f12:     	jmp	0x180002fdc <numba_list_delete_slice+0x1bc>
180002f17:     	movq	%r14, 0x30(%rsp)
180002f1c:     	movq	%r15, %r14
180002f1f:     	movl	$0x0, 0x60(%rsp)
180002f27:     	cmpq	%rbp, %r15
180002f2a:     	jge	0x180002fa9 <numba_list_delete_slice+0x189>
180002f2c:     	movq	%r12, 0x70(%rsp)
180002f31:     	movq	(%rbx), %rax
180002f34:     	leaq	(%r14,%rdi), %r12
180002f38:     	cmpq	%rax, %r12
180002f3b:     	jl	0x180002f48 <numba_list_delete_slice+0x128>
180002f3d:     	movq	%r14, %rsi
180002f40:     	notq	%rsi
180002f43:     	addq	%rax, %rsi
180002f46:     	jmp	0x180002f4c <numba_list_delete_slice+0x12c>
180002f48:     	leaq	-0x1(%rdi), %rsi
180002f4c:     	movq	0x28(%rbx), %rax
180002f50:     	testq	%rax, %rax
180002f53:     	je	0x180002f63 <numba_list_delete_slice+0x143>
180002f55:     	movq	%r14, %rcx
180002f58:     	imulq	0x8(%rbx), %rcx
180002f5d:     	addq	0x30(%rbx), %rcx
180002f61:     	callq	*%rax
180002f63:     	movq	0x8(%rbx), %r9
180002f67:     	leaq	0x1(%r14), %rdx
180002f6b:     	movq	0x30(%rbx), %r10
180002f6f:     	movq	%r9, %r8
180002f72:     	imulq	%rsi, %r8
180002f76:     	imulq	%r9, %rdx
180002f7a:     	movslq	0x60(%rsp), %rsi
180002f7f:     	subq	%rsi, %r14
180002f82:     	imulq	%r9, %r14
180002f86:     	addq	%r10, %rdx
180002f89:     	leaq	(%r10,%r14), %rcx
180002f8d:     	callq	0x180003ed9 <numba_list_iter_next+0xe79>
180002f92:     	incl	%esi
180002f94:     	movq	%r12, %r14
180002f97:     	movl	%esi, 0x60(%rsp)
180002f9b:     	cmpq	%rbp, %r12
180002f9e:     	jl	0x180002f31 <numba_list_delete_slice+0x111>
180002fa0:     	movq	0x70(%rsp), %r12
180002fa5:     	movl	0x20(%rsp), %esi
180002fa9:     	movq	(%rbx), %r8
180002fac:     	movq	0x30(%rsp), %r14
180002fb1:     	movslq	%r13d, %r10
180002fb4:     	movq	%r10, %rcx
180002fb7:     	imulq	%rdi, %rcx
180002fbb:     	addq	%r15, %rcx
180002fbe:     	cmpq	%r8, %rcx
180002fc1:     	jge	0x180002fe9 <numba_list_delete_slice+0x1c9>
180002fc3:     	movq	0x8(%rbx), %rax
180002fc7:     	subq	%rcx, %r8
180002fca:     	movq	%rax, %rdx
180002fcd:     	imulq	%rcx, %rdx
180002fd1:     	imulq	%rax, %r8
180002fd5:     	subq	%r10, %rcx
180002fd8:     	imulq	%rax, %rcx
180002fdc:     	addq	0x30(%rbx), %rdx
180002fe0:     	addq	0x30(%rbx), %rcx
180002fe4:     	callq	0x180003ed9 <numba_list_iter_next+0xe79>
180002fe9:     	movslq	%esi, %rdx
180002fec:     	movq	%rbx, %rcx
180002fef:     	callq	0x180002c60 <numba_list_resize>
180002ff4:     	movq	0x68(%rsp), %rsi
180002ff9:     	xorl	%ecx, %ecx
180002ffb:     	movq	0x78(%rsp), %r13
180003000:     	testl	%eax, %eax
180003002:     	cmovsl	%eax, %ecx
180003005:     	movl	%ecx, %eax
180003007:     	addq	$0x38, %rsp
18000300b:     	popq	%r15
18000300d:     	popq	%rdi
18000300e:     	popq	%rbp
18000300f:     	popq	%rbx
180003010:     	retq
180003011:     	movq	0x78(%rsp), %r13
180003016:     	xorl	%eax, %eax
180003018:     	addq	$0x38, %rsp
18000301c:     	popq	%r15
18000301e:     	popq	%rdi
18000301f:     	popq	%rbp
180003020:     	popq	%rbx
180003021:     	retq
180003022:     	int3
180003023:     	int3
180003024:     	int3
180003025:     	int3
180003026:     	int3
180003027:     	int3
180003028:     	int3
180003029:     	int3
18000302a:     	int3
18000302b:     	int3
18000302c:     	int3
18000302d:     	int3
18000302e:     	int3
18000302f:     	int3

0000000180003030 <numba_list_iter_sizeof>:
180003030:     	movl	$0x18, %eax
180003035:     	retq
180003036:     	int3
180003037:     	int3
180003038:     	int3
180003039:     	int3
18000303a:     	int3
18000303b:     	int3
18000303c:     	int3
18000303d:     	int3
18000303e:     	int3
18000303f:     	int3

0000000180003040 <numba_list_iter>:
180003040:     	movq	%rdx, (%rcx)
180003043:     	movq	(%rdx), %rax
180003046:     	movq	%rax, 0x8(%rcx)
18000304a:     	movq	$0x0, 0x10(%rcx)
180003052:     	retq
180003053:     	int3
180003054:     	int3
180003055:     	int3
180003056:     	int3
180003057:     	int3
180003058:     	int3
180003059:     	int3
18000305a:     	int3
18000305b:     	int3
18000305c:     	int3
18000305d:     	int3
18000305e:     	int3
18000305f:     	int3

0000000180003060 <numba_list_iter_next>:
180003060:     	movq	(%rcx), %r8
180003063:     	movq	(%r8), %r9
180003066:     	cmpq	0x8(%rcx), %r9
18000306a:     	je	0x180003072 <numba_list_iter_next+0x12>
18000306c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180003071:     	retq
180003072:     	movq	0x10(%rcx), %rax
180003076:     	cmpq	%r9, %rax
180003079:     	jge	0x18000308e <numba_list_iter_next+0x2e>
18000307b:     	imulq	0x8(%r8), %rax
180003080:     	addq	0x30(%r8), %rax
180003084:     	movq	%rax, (%rdx)
180003087:     	incq	0x10(%rcx)
18000308b:     	xorl	%eax, %eax
18000308d:     	retq
18000308e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180003093:     	retq
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
1800030a0:     	pushq	%rbx
1800030a2:     	subq	$0x20, %rsp
1800030a6:     	movq	%rcx, %rbx
1800030a9:     	addq	$0x30, %rcx
1800030ad:     	callq	*0x7b75(%rip)           # 0x18000ac28
1800030b3:     	cmpb	$0x0, 0x7b46(%rip)      # 0x18000ac00
1800030ba:     	je	0x1800030c4 <numba_list_iter_next+0x64>
1800030bc:     	lock
1800030bd:     	incq	0x7b44(%rip)            # 0x18000ac08
1800030c4:     	testq	%rax, %rax
1800030c7:     	je	0x180003108 <numba_list_iter_next+0xa8>
1800030c9:     	leaq	0x30(%rax), %rdx
1800030cd:     	testq	%rdx, %rdx
1800030d0:     	je	0x180003108 <numba_list_iter_next+0xa8>
1800030d2:     	xorl	%r8d, %r8d
1800030d5:     	movl	$0x1, %ecx
1800030da:     	xchgq	%rcx, (%rax)
1800030dd:     	movq	%r8, 0x8(%rax)
1800030e1:     	movq	%r8, 0x10(%rax)
1800030e5:     	movq	%rdx, 0x18(%rax)
1800030e9:     	movq	%rbx, 0x20(%rax)
1800030ed:     	movq	%r8, 0x28(%rax)
1800030f1:     	cmpb	%r8b, 0x7b08(%rip)      # 0x18000ac00
1800030f8:     	je	0x18000310a <numba_list_iter_next+0xaa>
1800030fa:     	lock
1800030fb:     	incq	0x7b16(%rip)            # 0x18000ac18
180003102:     	addq	$0x20, %rsp
180003106:     	popq	%rbx
180003107:     	retq
180003108:     	xorl	%eax, %eax
18000310a:     	addq	$0x20, %rsp
18000310e:     	popq	%rbx
18000310f:     	retq
180003110:     	movq	%rbx, 0x8(%rsp)
180003115:     	pushq	%rdi
180003116:     	subq	$0x20, %rsp
18000311a:     	movq	%rcx, %rdi
18000311d:     	movq	%rdx, %rbx
180003120:     	addq	$0x30, %rcx
180003124:     	testq	%rdx, %rdx
180003127:     	je	0x180003131 <numba_list_iter_next+0xd1>
180003129:     	movq	0x18(%rdx), %rdx
18000312d:     	callq	*(%rbx)
18000312f:     	jmp	0x180003137 <numba_list_iter_next+0xd7>
180003131:     	callq	*0x7af1(%rip)           # 0x18000ac28
180003137:     	cmpb	$0x0, 0x7ac2(%rip)      # 0x18000ac00
18000313e:     	movq	%rax, %r8
180003141:     	je	0x18000314b <numba_list_iter_next+0xeb>
180003143:     	lock
180003144:     	incq	0x7abd(%rip)            # 0x18000ac08
18000314b:     	xorl	%edx, %edx
18000314d:     	leaq	0x30(%r8), %rax
180003151:     	testq	%r8, %r8
180003154:     	movl	%edx, %ecx
180003156:     	cmovneq	%rax, %rcx
18000315a:     	testq	%rcx, %rcx
18000315d:     	jne	0x18000316c <numba_list_iter_next+0x10c>
18000315f:     	xorl	%eax, %eax
180003161:     	movq	0x30(%rsp), %rbx
180003166:     	addq	$0x20, %rsp
18000316a:     	popq	%rdi
18000316b:     	retq
18000316c:     	movl	$0x1, %eax
180003171:     	xchgq	%rax, (%r8)
180003174:     	movq	%rdx, 0x8(%r8)
180003178:     	movq	%rdx, 0x10(%r8)
18000317c:     	movq	%rcx, 0x18(%r8)
180003180:     	movq	%rdi, 0x20(%r8)
180003184:     	movq	%rbx, 0x28(%r8)
180003188:     	cmpb	%dl, 0x7a72(%rip)       # 0x18000ac00
18000318e:     	je	0x180003198 <numba_list_iter_next+0x138>
180003190:     	lock
180003191:     	incq	0x7a80(%rip)            # 0x18000ac18
180003198:     	movq	0x30(%rsp), %rbx
18000319d:     	movq	%r8, %rax
1800031a0:     	addq	$0x20, %rsp
1800031a4:     	popq	%rdi
1800031a5:     	retq
1800031a6:     	int3
1800031a7:     	int3
1800031a8:     	int3
1800031a9:     	int3
1800031aa:     	int3
1800031ab:     	int3
1800031ac:     	int3
1800031ad:     	int3
1800031ae:     	int3
1800031af:     	int3
1800031b0:     	lock
1800031b1:     	incq	(%rcx)
1800031b4:     	retq
1800031b5:     	int3
1800031b6:     	int3
1800031b7:     	int3
1800031b8:     	int3
1800031b9:     	int3
1800031ba:     	int3
1800031bb:     	int3
1800031bc:     	int3
1800031bd:     	int3
1800031be:     	int3
1800031bf:     	int3
1800031c0:     	pushq	%rbx
1800031c2:     	subq	$0x20, %rsp
1800031c6:     	movq	0x8(%rcx), %rax
1800031ca:     	movq	%rcx, %rbx
1800031cd:     	testq	%rax, %rax
1800031d0:     	je	0x1800031e9 <numba_list_iter_next+0x189>
1800031d2:     	cmpl	$0x0, 0x7a1f(%rip)      # 0x18000abf8
1800031d9:     	jne	0x1800031e9 <numba_list_iter_next+0x189>
1800031db:     	movq	0x10(%rcx), %r8
1800031df:     	movq	0x20(%rcx), %rdx
1800031e3:     	movq	0x18(%rcx), %rcx
1800031e7:     	callq	*%rax
1800031e9:     	movq	0x28(%rbx), %rax
1800031ed:     	movq	%rbx, %rcx
1800031f0:     	testq	%rax, %rax
1800031f3:     	je	0x1800031fe <numba_list_iter_next+0x19e>
1800031f5:     	movq	0x18(%rax), %rdx
1800031f9:     	callq	*0x10(%rax)
1800031fc:     	jmp	0x180003204 <numba_list_iter_next+0x1a4>
1800031fe:     	callq	*0x7a34(%rip)           # 0x18000ac38
180003204:     	cmpb	$0x0, 0x79f5(%rip)      # 0x18000ac00
18000320b:     	je	0x180003229 <numba_list_iter_next+0x1c9>
18000320d:     	leaq	0x79fc(%rip), %rax      # 0x18000ac10
180003214:     	lock
180003215:     	incq	(%rax)
180003218:     	cmpb	$0x0, 0x79e1(%rip)      # 0x18000ac00
18000321f:     	je	0x180003229 <numba_list_iter_next+0x1c9>
180003221:     	lock
180003222:     	incq	0x79f7(%rip)            # 0x18000ac20
180003229:     	addq	$0x20, %rsp
18000322d:     	popq	%rbx
18000322e:     	retq
18000322f:     	int3
180003230:     	pushq	%rbx
180003232:     	subq	$0x20, %rsp
180003236:     	movq	%rcx, %rbx
180003239:     	movq	$-0x1, %rax
180003240:     	lock
180003241:     	xaddq	%rax, (%rcx)
180003245:     	cmpq	$0x1, %rax
180003249:     	jne	0x1800032ab <numba_list_iter_next+0x24b>
18000324b:     	movq	0x8(%rcx), %rax
18000324f:     	testq	%rax, %rax
180003252:     	je	0x18000326b <numba_list_iter_next+0x20b>
180003254:     	cmpl	$0x0, 0x799d(%rip)      # 0x18000abf8
18000325b:     	jne	0x18000326b <numba_list_iter_next+0x20b>
18000325d:     	movq	0x10(%rcx), %r8
180003261:     	movq	0x20(%rcx), %rdx
180003265:     	movq	0x18(%rcx), %rcx
180003269:     	callq	*%rax
18000326b:     	movq	0x28(%rbx), %rax
18000326f:     	movq	%rbx, %rcx
180003272:     	testq	%rax, %rax
180003275:     	je	0x180003280 <numba_list_iter_next+0x220>
180003277:     	movq	0x18(%rax), %rdx
18000327b:     	callq	*0x10(%rax)
18000327e:     	jmp	0x180003286 <numba_list_iter_next+0x226>
180003280:     	callq	*0x79b2(%rip)           # 0x18000ac38
180003286:     	cmpb	$0x0, 0x7973(%rip)      # 0x18000ac00
18000328d:     	je	0x1800032ab <numba_list_iter_next+0x24b>
18000328f:     	leaq	0x797a(%rip), %rax      # 0x18000ac10
180003296:     	lock
180003297:     	incq	(%rax)
18000329a:     	cmpb	$0x0, 0x795f(%rip)      # 0x18000ac00
1800032a1:     	je	0x1800032ab <numba_list_iter_next+0x24b>
1800032a3:     	lock
1800032a4:     	incq	0x7975(%rip)            # 0x18000ac20
1800032ab:     	addq	$0x20, %rsp
1800032af:     	popq	%rbx
1800032b0:     	retq
1800032b1:     	int3
1800032b2:     	int3
1800032b3:     	int3
1800032b4:     	int3
1800032b5:     	int3
1800032b6:     	int3
1800032b7:     	int3
1800032b8:     	int3
1800032b9:     	int3
1800032ba:     	int3
1800032bb:     	int3
1800032bc:     	int3
1800032bd:     	int3
1800032be:     	int3
1800032bf:     	int3
1800032c0:     	movq	0x18(%rcx), %rax
1800032c4:     	retq
1800032c5:     	int3
1800032c6:     	int3
1800032c7:     	int3
1800032c8:     	int3
1800032c9:     	int3
1800032ca:     	int3
1800032cb:     	int3
1800032cc:     	int3
1800032cd:     	int3
1800032ce:     	int3
1800032cf:     	int3
1800032d0:     	jmpq	*%r8
1800032d3:     	int3
1800032d4:     	int3
1800032d5:     	int3
1800032d6:     	int3
1800032d7:     	int3
1800032d8:     	int3
1800032d9:     	int3
1800032da:     	int3
1800032db:     	int3
1800032dc:     	int3
1800032dd:     	int3
1800032de:     	int3
1800032df:     	int3
1800032e0:     	movq	%rbx, 0x8(%rsp)
1800032e5:     	pushq	%rdi
1800032e6:     	subq	$0x20, %rsp
1800032ea:     	movq	%rcx, %rdi
1800032ed:     	movq	%rdx, %rbx
1800032f0:     	movl	$0x30, %ecx
1800032f5:     	callq	*0x792d(%rip)           # 0x18000ac28
1800032fb:     	cmpb	$0x0, 0x78fe(%rip)      # 0x18000ac00
180003302:     	je	0x18000330c <numba_list_iter_next+0x2ac>
180003304:     	lock
180003305:     	incq	0x78fc(%rip)            # 0x18000ac08
18000330c:     	testq	%rax, %rax
18000330f:     	je	0x180003346 <numba_list_iter_next+0x2e6>
180003311:     	leaq	-0x48(%rip), %rcx       # 0x1800032d0 <numba_list_iter_next+0x270>
180003318:     	movl	$0x1, %edx
18000331d:     	xchgq	%rdx, (%rax)
180003320:     	movq	%rcx, 0x8(%rax)
180003324:     	xorl	%ecx, %ecx
180003326:     	movq	%rcx, 0x20(%rax)
18000332a:     	movq	%rcx, 0x28(%rax)
18000332e:     	movq	%rbx, 0x10(%rax)
180003332:     	movq	%rdi, 0x18(%rax)
180003336:     	cmpb	%cl, 0x78c4(%rip)       # 0x18000ac00
18000333c:     	je	0x180003346 <numba_list_iter_next+0x2e6>
18000333e:     	lock
18000333f:     	incq	0x78d2(%rip)            # 0x18000ac18
180003346:     	movq	0x30(%rsp), %rbx
18000334b:     	addq	$0x20, %rsp
18000334f:     	popq	%rdi
180003350:     	retq
180003351:     	jmpq	*0xf19(%rip)            # 0x180004270
180003357:     	jmpq	*0xf03(%rip)            # 0x180004260
18000335d:     	jmpq	*0xef5(%rip)            # 0x180004258
180003363:     	jmpq	*0xee7(%rip)            # 0x180004250
180003369:     	jmpq	*0xed9(%rip)            # 0x180004248
18000336f:     	jmpq	*0xecb(%rip)            # 0x180004240
180003375:     	jmpq	*0xeb5(%rip)            # 0x180004230
18000337b:     	jmpq	*0xe9f(%rip)            # 0x180004220
180003381:     	jmpq	*0xe79(%rip)            # 0x180004200
180003387:     	int3
180003388:     	int3
180003389:     	int3
18000338a:     	int3
18000338b:     	int3
18000338c:     	int3
18000338d:     	int3
18000338e:     	int3
18000338f:     	int3
180003390:     	int3
180003391:     	int3
180003392:     	int3
180003393:     	int3
180003394:     	int3
180003395:     	int3
180003396:     	nopw	(%rax,%rax)
1800033a0:     	cmpq	0x6d19(%rip), %rcx      # 0x18000a0c0
1800033a7:     	jne	0x1800033b9 <numba_list_iter_next+0x359>
1800033a9:     	rolq	$0x10, %rcx
1800033ad:     	testw	$0xffff, %cx            # imm = 0xFFFF
1800033b2:     	jne	0x1800033b5 <numba_list_iter_next+0x355>
1800033b4:     	retq
1800033b5:     	rorq	$0x10, %rcx
1800033b9:     	jmp	0x180003714 <numba_list_iter_next+0x6b4>
1800033be:     	int3
1800033bf:     	int3
1800033c0:     	subq	$0x28, %rsp
1800033c4:     	testl	%edx, %edx
1800033c6:     	je	0x180003401 <numba_list_iter_next+0x3a1>
1800033c8:     	subl	$0x1, %edx
1800033cb:     	je	0x1800033f5 <numba_list_iter_next+0x395>
1800033cd:     	subl	$0x1, %edx
1800033d0:     	je	0x1800033e8 <numba_list_iter_next+0x388>
1800033d2:     	cmpl	$0x1, %edx
1800033d5:     	je	0x1800033e1 <numba_list_iter_next+0x381>
1800033d7:     	movl	$0x1, %eax
1800033dc:     	addq	$0x28, %rsp
1800033e0:     	retq
1800033e1:     	callq	0x1800038e0 <numba_list_iter_next+0x880>
1800033e6:     	jmp	0x1800033ed <numba_list_iter_next+0x38d>
1800033e8:     	callq	0x1800038b8 <numba_list_iter_next+0x858>
1800033ed:     	movzbl	%al, %eax
1800033f0:     	addq	$0x28, %rsp
1800033f4:     	retq
1800033f5:     	movq	%r8, %rdx
1800033f8:     	addq	$0x28, %rsp
1800033fc:     	jmp	0x180003410 <numba_list_iter_next+0x3b0>
180003401:     	testq	%r8, %r8
180003404:     	setne	%cl
180003407:     	addq	$0x28, %rsp
18000340b:     	jmp	0x180003528 <numba_list_iter_next+0x4c8>
180003410:     	movq	%rbx, 0x8(%rsp)
180003415:     	movq	%rsi, 0x10(%rsp)
18000341a:     	movq	%rdi, 0x20(%rsp)
18000341f:     	pushq	%r14
180003421:     	subq	$0x20, %rsp
180003425:     	movq	%rdx, %rsi
180003428:     	movq	%rcx, %r14
18000342b:     	xorl	%ecx, %ecx
18000342d:     	callq	0x18000399c <numba_list_iter_next+0x93c>
180003432:     	testb	%al, %al
180003434:     	je	0x180003502 <numba_list_iter_next+0x4a2>
18000343a:     	callq	0x180003830 <numba_list_iter_next+0x7d0>
18000343f:     	movb	%al, %bl
180003441:     	movb	%al, 0x40(%rsp)
180003445:     	movb	$0x1, %dil
180003448:     	cmpl	$0x0, 0x7579(%rip)      # 0x18000a9c8
18000344f:     	jne	0x18000351a <numba_list_iter_next+0x4ba>
180003455:     	movl	$0x1, 0x7569(%rip)      # 0x18000a9c8
18000345f:     	callq	0x1800038a0 <numba_list_iter_next+0x840>
180003464:     	testb	%al, %al
180003466:     	je	0x1800034b7 <numba_list_iter_next+0x457>
180003468:     	callq	0x180003b5c <numba_list_iter_next+0xafc>
18000346d:     	callq	0x1800037f0 <numba_list_iter_next+0x790>
180003472:     	callq	0x180003814 <numba_list_iter_next+0x7b4>
180003477:     	leaq	0xe52(%rip), %rdx       # 0x1800042d0
18000347e:     	leaq	0xe43(%rip), %rcx       # 0x1800042c8
180003485:     	callq	0x180003ea2 <numba_list_iter_next+0xe42>
18000348a:     	testl	%eax, %eax
18000348c:     	jne	0x1800034b7 <numba_list_iter_next+0x457>
18000348e:     	callq	0x18000386c <numba_list_iter_next+0x80c>
180003493:     	testb	%al, %al
180003495:     	je	0x1800034b7 <numba_list_iter_next+0x457>
180003497:     	leaq	0xe22(%rip), %rdx       # 0x1800042c0
18000349e:     	leaq	0xe13(%rip), %rcx       # 0x1800042b8
1800034a5:     	callq	0x180003e9c <numba_list_iter_next+0xe3c>
1800034aa:     	movl	$0x2, 0x7514(%rip)      # 0x18000a9c8
1800034b4:     	xorb	%dil, %dil
1800034b7:     	movb	%bl, %cl
1800034b9:     	callq	0x180003afc <numba_list_iter_next+0xa9c>
1800034be:     	testb	%dil, %dil
1800034c1:     	jne	0x180003502 <numba_list_iter_next+0x4a2>
1800034c3:     	callq	0x180003b4c <numba_list_iter_next+0xaec>
1800034c8:     	movq	%rax, %rbx
1800034cb:     	cmpq	$0x0, (%rax)
1800034cf:     	je	0x1800034f5 <numba_list_iter_next+0x495>
1800034d1:     	movq	%rax, %rcx
1800034d4:     	callq	0x180003a64 <numba_list_iter_next+0xa04>
1800034d9:     	testb	%al, %al
1800034db:     	je	0x1800034f5 <numba_list_iter_next+0x495>
1800034dd:     	movq	%rsi, %r8
1800034e0:     	movl	$0x2, %edx
1800034e5:     	movq	%r14, %rcx
1800034e8:     	movq	(%rbx), %rax
1800034eb:     	movq	0xd9e(%rip), %r9        # 0x180004290
1800034f2:     	callq	*%r9
1800034f5:     	incl	0x74a5(%rip)            # 0x18000a9a0
1800034fb:     	movl	$0x1, %eax
180003500:     	jmp	0x180003504 <numba_list_iter_next+0x4a4>
180003502:     	xorl	%eax, %eax
180003504:     	movq	0x30(%rsp), %rbx
180003509:     	movq	0x38(%rsp), %rsi
18000350e:     	movq	0x48(%rsp), %rdi
180003513:     	addq	$0x20, %rsp
180003517:     	popq	%r14
180003519:     	retq
18000351a:     	movl	$0x7, %ecx
18000351f:     	callq	0x180003b54 <numba_list_iter_next+0xaf4>
180003524:     	nop
180003525:     	int3
180003526:     	int3
180003527:     	int3
180003528:     	movq	%rbx, 0x8(%rsp)
18000352d:     	pushq	%rdi
18000352e:     	subq	$0x30, %rsp
180003532:     	movb	%cl, %dil
180003535:     	movl	0x7465(%rip), %eax      # 0x18000a9a0
18000353b:     	testl	%eax, %eax
18000353d:     	jg	0x18000354c <numba_list_iter_next+0x4ec>
18000353f:     	xorl	%eax, %eax
180003541:     	movq	0x40(%rsp), %rbx
180003546:     	addq	$0x30, %rsp
18000354a:     	popq	%rdi
18000354b:     	retq
18000354c:     	decl	%eax
18000354e:     	movl	%eax, 0x744c(%rip)      # 0x18000a9a0
180003554:     	callq	0x180003830 <numba_list_iter_next+0x7d0>
180003559:     	movb	%al, %bl
18000355b:     	movb	%al, 0x20(%rsp)
18000355f:     	cmpl	$0x2, 0x7462(%rip)      # 0x18000a9c8
180003566:     	jne	0x18000359e <numba_list_iter_next+0x53e>
180003568:     	callq	0x180003958 <numba_list_iter_next+0x8f8>
18000356d:     	callq	0x180003800 <numba_list_iter_next+0x7a0>
180003572:     	callq	0x180003b98 <numba_list_iter_next+0xb38>
180003577:     	movl	$0x0, 0x7447(%rip)      # 0x18000a9c8
180003581:     	movb	%bl, %cl
180003583:     	callq	0x180003afc <numba_list_iter_next+0xa9c>
180003588:     	xorl	%edx, %edx
18000358a:     	movb	%dil, %cl
18000358d:     	callq	0x180003b20 <numba_list_iter_next+0xac0>
180003592:     	movzbl	%al, %ebx
180003595:     	callq	0x180003988 <numba_list_iter_next+0x928>
18000359a:     	movl	%ebx, %eax
18000359c:     	jmp	0x180003541 <numba_list_iter_next+0x4e1>
18000359e:     	movl	$0x7, %ecx
1800035a3:     	callq	0x180003b54 <numba_list_iter_next+0xaf4>
1800035a8:     	nop
1800035a9:     	nop
1800035aa:     	int3
1800035ab:     	int3
1800035ac:     	movq	%rsp, %rax
1800035af:     	movq	%rbx, 0x20(%rax)
1800035b3:     	movq	%r8, 0x18(%rax)
1800035b7:     	movl	%edx, 0x10(%rax)
1800035ba:     	movq	%rcx, 0x8(%rax)
1800035be:     	pushq	%rsi
1800035bf:     	pushq	%rdi
1800035c0:     	pushq	%r14
1800035c2:     	subq	$0x40, %rsp
1800035c6:     	movq	%r8, %rsi
1800035c9:     	movl	%edx, %edi
1800035cb:     	movq	%rcx, %r14
1800035ce:     	testl	%edx, %edx
1800035d0:     	jne	0x1800035e1 <numba_list_iter_next+0x581>
1800035d2:     	cmpl	%edx, 0x73c8(%rip)      # 0x18000a9a0
1800035d8:     	jg	0x1800035e1 <numba_list_iter_next+0x581>
1800035da:     	xorl	%eax, %eax
1800035dc:     	jmp	0x1800036c6 <numba_list_iter_next+0x666>
1800035e1:     	leal	-0x1(%rdx), %eax
1800035e4:     	cmpl	$0x1, %eax
1800035e7:     	ja	0x180003629 <numba_list_iter_next+0x5c9>
1800035e9:     	movq	0x1008(%rip), %rax      # 0x1800045f8
1800035f0:     	testq	%rax, %rax
1800035f3:     	jne	0x1800035fa <numba_list_iter_next+0x59a>
1800035f5:     	leal	0x1(%rax), %ebx
1800035f8:     	jmp	0x180003602 <numba_list_iter_next+0x5a2>
1800035fa:     	callq	*0xc90(%rip)            # 0x180004290
180003600:     	movl	%eax, %ebx
180003602:     	movl	%ebx, 0x30(%rsp)
180003606:     	testl	%ebx, %ebx
180003608:     	je	0x1800036bc <numba_list_iter_next+0x65c>
18000360e:     	movq	%rsi, %r8
180003611:     	movl	%edi, %edx
180003613:     	movq	%r14, %rcx
180003616:     	callq	0x1800033c0 <numba_list_iter_next+0x360>
18000361b:     	movl	%eax, %ebx
18000361d:     	movl	%eax, 0x30(%rsp)
180003621:     	testl	%eax, %eax
180003623:     	je	0x1800036bc <numba_list_iter_next+0x65c>
180003629:     	movq	%rsi, %r8
18000362c:     	movl	%edi, %edx
18000362e:     	movq	%r14, %rcx
180003631:     	callq	0x1800037cc <numba_list_iter_next+0x76c>
180003636:     	movl	%eax, %ebx
180003638:     	movl	%eax, 0x30(%rsp)
18000363c:     	cmpl	$0x1, %edi
18000363f:     	jne	0x180003677 <numba_list_iter_next+0x617>
180003641:     	testl	%eax, %eax
180003643:     	jne	0x180003677 <numba_list_iter_next+0x617>
180003645:     	movq	%rsi, %r8
180003648:     	xorl	%edx, %edx
18000364a:     	movq	%r14, %rcx
18000364d:     	callq	0x1800037cc <numba_list_iter_next+0x76c>
180003652:     	testq	%rsi, %rsi
180003655:     	setne	%cl
180003658:     	callq	0x180003528 <numba_list_iter_next+0x4c8>
18000365d:     	movq	0xf94(%rip), %rax       # 0x1800045f8
180003664:     	testq	%rax, %rax
180003667:     	je	0x180003677 <numba_list_iter_next+0x617>
180003669:     	movq	%rsi, %r8
18000366c:     	xorl	%edx, %edx
18000366e:     	movq	%r14, %rcx
180003671:     	callq	*0xc19(%rip)            # 0x180004290
180003677:     	testl	%edi, %edi
180003679:     	je	0x180003680 <numba_list_iter_next+0x620>
18000367b:     	cmpl	$0x3, %edi
18000367e:     	jne	0x1800036bc <numba_list_iter_next+0x65c>
180003680:     	movq	%rsi, %r8
180003683:     	movl	%edi, %edx
180003685:     	movq	%r14, %rcx
180003688:     	callq	0x1800033c0 <numba_list_iter_next+0x360>
18000368d:     	movl	%eax, %ebx
18000368f:     	movl	%eax, 0x30(%rsp)
180003693:     	testl	%eax, %eax
180003695:     	je	0x1800036bc <numba_list_iter_next+0x65c>
180003697:     	movq	0xf5a(%rip), %rax       # 0x1800045f8
18000369e:     	testq	%rax, %rax
1800036a1:     	jne	0x1800036a8 <numba_list_iter_next+0x648>
1800036a3:     	leal	0x1(%rax), %ebx
1800036a6:     	jmp	0x1800036b8 <numba_list_iter_next+0x658>
1800036a8:     	movq	%rsi, %r8
1800036ab:     	movl	%edi, %edx
1800036ad:     	movq	%r14, %rcx
1800036b0:     	callq	*0xbda(%rip)            # 0x180004290
1800036b6:     	movl	%eax, %ebx
1800036b8:     	movl	%ebx, 0x30(%rsp)
1800036bc:     	jmp	0x1800036c4 <numba_list_iter_next+0x664>
1800036be:     	xorl	%ebx, %ebx
1800036c0:     	movl	%ebx, 0x30(%rsp)
1800036c4:     	movl	%ebx, %eax
1800036c6:     	movq	0x78(%rsp), %rbx
1800036cb:     	addq	$0x40, %rsp
1800036cf:     	popq	%r14
1800036d1:     	popq	%rdi
1800036d2:     	popq	%rsi
1800036d3:     	retq
1800036d4:     	movq	%rbx, 0x8(%rsp)
1800036d9:     	movq	%rsi, 0x10(%rsp)
1800036de:     	pushq	%rdi
1800036df:     	subq	$0x20, %rsp
1800036e3:     	movq	%r8, %rdi
1800036e6:     	movl	%edx, %ebx
1800036e8:     	movq	%rcx, %rsi
1800036eb:     	cmpl	$0x1, %edx
1800036ee:     	jne	0x1800036f5 <numba_list_iter_next+0x695>
1800036f0:     	callq	0x18000371c <numba_list_iter_next+0x6bc>
1800036f5:     	movq	%rdi, %r8
1800036f8:     	movl	%ebx, %edx
1800036fa:     	movq	%rsi, %rcx
1800036fd:     	movq	0x30(%rsp), %rbx
180003702:     	movq	0x38(%rsp), %rsi
180003707:     	addq	$0x20, %rsp
18000370b:     	popq	%rdi
18000370c:     	jmp	0x1800035ac <numba_list_iter_next+0x54c>
180003711:     	int3
180003712:     	int3
180003713:     	int3
180003714:     	movl	$0x2, %ecx
180003719:     	int	$0x29
18000371b:     	retq
18000371c:     	movq	%rbx, 0x18(%rsp)
180003721:     	pushq	%rbp
180003722:     	movq	%rsp, %rbp
180003725:     	subq	$0x30, %rsp
180003729:     	movq	0x6990(%rip), %rax      # 0x18000a0c0
180003730:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000373a:     	cmpq	%rbx, %rax
18000373d:     	jne	0x1800037b6 <numba_list_iter_next+0x756>
18000373f:     	leaq	0x10(%rbp), %rcx
180003743:     	movq	$0x0, 0x10(%rbp)
18000374b:     	callq	*0x8cf(%rip)            # 0x180004020
180003751:     	movq	0x10(%rbp), %rax
180003755:     	movq	%rax, -0x10(%rbp)
180003759:     	callq	*0x8b9(%rip)            # 0x180004018
18000375f:     	movl	%eax, %eax
180003761:     	xorq	%rax, -0x10(%rbp)
180003765:     	callq	*0x8a5(%rip)            # 0x180004010
18000376b:     	movl	%eax, %eax
18000376d:     	leaq	0x18(%rbp), %rcx
180003771:     	xorq	%rax, -0x10(%rbp)
180003775:     	callq	*0x885(%rip)            # 0x180004000
18000377b:     	movl	0x18(%rbp), %eax
18000377e:     	leaq	-0x10(%rbp), %rcx
180003782:     	shlq	$0x20, %rax
180003786:     	xorq	0x18(%rbp), %rax
18000378a:     	xorq	-0x10(%rbp), %rax
18000378e:     	xorq	%rcx, %rax
180003791:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000379b:     	andq	%rcx, %rax
18000379e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
1800037a8:     	cmpq	%rbx, %rax
1800037ab:     	cmoveq	%rcx, %rax
1800037af:     	movq	%rax, 0x690a(%rip)      # 0x18000a0c0
1800037b6:     	movq	0x50(%rsp), %rbx
1800037bb:     	notq	%rax
1800037be:     	movq	%rax, 0x693b(%rip)      # 0x18000a100
1800037c5:     	addq	$0x30, %rsp
1800037c9:     	popq	%rbp
1800037ca:     	retq
1800037cb:     	int3
1800037cc:     	subq	$0x28, %rsp
1800037d0:     	cmpl	$0x1, %edx
1800037d3:     	jne	0x1800037e5 <numba_list_iter_next+0x785>
1800037d5:     	cmpq	$0x0, 0xe1b(%rip)       # 0x1800045f8
1800037dd:     	jne	0x1800037e5 <numba_list_iter_next+0x785>
1800037df:     	callq	*0x843(%rip)            # 0x180004028
1800037e5:     	movl	$0x1, %eax
1800037ea:     	addq	$0x28, %rsp
1800037ee:     	retq
1800037ef:     	int3
1800037f0:     	leaq	0x71b9(%rip), %rcx      # 0x18000a9b0
1800037f7:     	jmpq	*0x80a(%rip)            # 0x180004008
1800037fe:     	int3
1800037ff:     	int3
180003800:     	leaq	0x71a9(%rip), %rcx      # 0x18000a9b0
180003807:     	jmp	0x180003e96 <numba_list_iter_next+0xe36>
18000380c:     	leaq	0x71ad(%rip), %rax      # 0x18000a9c0
180003813:     	retq
180003814:     	subq	$0x28, %rsp
180003818:     	callq	0x180002970 <PyInit_rcaotr_aaf42c2db6d9b748cf4faa74+0x10e0>
18000381d:     	orq	$0x24, (%rax)
180003821:     	callq	0x18000380c <numba_list_iter_next+0x7ac>
180003826:     	orq	$0x2, (%rax)
18000382a:     	addq	$0x28, %rsp
18000382e:     	retq
18000382f:     	int3
180003830:     	subq	$0x28, %rsp
180003834:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
180003839:     	testl	%eax, %eax
18000383b:     	je	0x18000385e <numba_list_iter_next+0x7fe>
18000383d:     	movq	%gs:0x30, %rax
180003846:     	movq	0x8(%rax), %rcx
18000384a:     	jmp	0x180003851 <numba_list_iter_next+0x7f1>
18000384c:     	cmpq	%rax, %rcx
18000384f:     	je	0x180003865 <numba_list_iter_next+0x805>
180003851:     	xorl	%eax, %eax
180003853:     	lock
180003854:     	cmpxchgq	%rcx, 0x7174(%rip)      # 0x18000a9d0
18000385c:     	jne	0x18000384c <numba_list_iter_next+0x7ec>
18000385e:     	xorb	%al, %al
180003860:     	addq	$0x28, %rsp
180003864:     	retq
180003865:     	movb	$0x1, %al
180003867:     	jmp	0x180003860 <numba_list_iter_next+0x800>
180003869:     	int3
18000386a:     	int3
18000386b:     	int3
18000386c:     	subq	$0x28, %rsp
180003870:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
180003875:     	testl	%eax, %eax
180003877:     	je	0x180003880 <numba_list_iter_next+0x820>
180003879:     	callq	0x180003bd8 <numba_list_iter_next+0xb78>
18000387e:     	jmp	0x180003899 <numba_list_iter_next+0x839>
180003880:     	callq	0x180003e74 <numba_list_iter_next+0xe14>
180003885:     	movl	%eax, %ecx
180003887:     	callq	0x180003eae <numba_list_iter_next+0xe4e>
18000388c:     	testl	%eax, %eax
18000388e:     	je	0x180003894 <numba_list_iter_next+0x834>
180003890:     	xorb	%al, %al
180003892:     	jmp	0x18000389b <numba_list_iter_next+0x83b>
180003894:     	callq	0x180003eb4 <numba_list_iter_next+0xe54>
180003899:     	movb	$0x1, %al
18000389b:     	addq	$0x28, %rsp
18000389f:     	retq
1800038a0:     	subq	$0x28, %rsp
1800038a4:     	xorl	%ecx, %ecx
1800038a6:     	callq	0x1800039d8 <numba_list_iter_next+0x978>
1800038ab:     	testb	%al, %al
1800038ad:     	setne	%al
1800038b0:     	addq	$0x28, %rsp
1800038b4:     	retq
1800038b5:     	int3
1800038b6:     	int3
1800038b7:     	int3
1800038b8:     	subq	$0x28, %rsp
1800038bc:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800038c1:     	testb	%al, %al
1800038c3:     	jne	0x1800038c9 <numba_list_iter_next+0x869>
1800038c5:     	xorb	%al, %al
1800038c7:     	jmp	0x1800038db <numba_list_iter_next+0x87b>
1800038c9:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800038ce:     	testb	%al, %al
1800038d0:     	jne	0x1800038d9 <numba_list_iter_next+0x879>
1800038d2:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800038d7:     	jmp	0x1800038c5 <numba_list_iter_next+0x865>
1800038d9:     	movb	$0x1, %al
1800038db:     	addq	$0x28, %rsp
1800038df:     	retq
1800038e0:     	subq	$0x28, %rsp
1800038e4:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800038e9:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800038ee:     	movb	$0x1, %al
1800038f0:     	addq	$0x28, %rsp
1800038f4:     	retq
1800038f5:     	int3
1800038f6:     	int3
1800038f7:     	int3
1800038f8:     	movq	%rbx, 0x8(%rsp)
1800038fd:     	movq	%rbp, 0x10(%rsp)
180003902:     	movq	%rsi, 0x18(%rsp)
180003907:     	pushq	%rdi
180003908:     	subq	$0x20, %rsp
18000390c:     	movq	%r9, %rdi
18000390f:     	movq	%r8, %rsi
180003912:     	movl	%edx, %ebx
180003914:     	movq	%rcx, %rbp
180003917:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
18000391c:     	testl	%eax, %eax
18000391e:     	jne	0x180003936 <numba_list_iter_next+0x8d6>
180003920:     	cmpl	$0x1, %ebx
180003923:     	jne	0x180003936 <numba_list_iter_next+0x8d6>
180003925:     	movq	%rsi, %r8
180003928:     	xorl	%edx, %edx
18000392a:     	movq	%rbp, %rcx
18000392d:     	movq	%rdi, %rax
180003930:     	callq	*0x95a(%rip)            # 0x180004290
180003936:     	movq	0x58(%rsp), %rdx
18000393b:     	movl	0x50(%rsp), %ecx
18000393f:     	movq	0x30(%rsp), %rbx
180003944:     	movq	0x38(%rsp), %rbp
180003949:     	movq	0x40(%rsp), %rsi
18000394e:     	addq	$0x20, %rsp
180003952:     	popq	%rdi
180003953:     	jmp	0x180003ea8 <numba_list_iter_next+0xe48>
180003958:     	subq	$0x28, %rsp
18000395c:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
180003961:     	testl	%eax, %eax
180003963:     	je	0x180003975 <numba_list_iter_next+0x915>
180003965:     	leaq	0x7074(%rip), %rcx      # 0x18000a9e0
18000396c:     	addq	$0x28, %rsp
180003970:     	jmp	0x180003ec0 <numba_list_iter_next+0xe60>
180003975:     	callq	0x180003ed0 <numba_list_iter_next+0xe70>
18000397a:     	testl	%eax, %eax
18000397c:     	jne	0x180003983 <numba_list_iter_next+0x923>
18000397e:     	callq	0x180003ec6 <numba_list_iter_next+0xe66>
180003983:     	addq	$0x28, %rsp
180003987:     	retq
180003988:     	subq	$0x28, %rsp
18000398c:     	xorl	%ecx, %ecx
18000398e:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
180003993:     	addq	$0x28, %rsp
180003997:     	jmp	0x180003ecc <numba_list_iter_next+0xe6c>
18000399c:     	subq	$0x28, %rsp
1800039a0:     	testl	%ecx, %ecx
1800039a2:     	jne	0x1800039ab <numba_list_iter_next+0x94b>
1800039a4:     	movb	$0x1, 0x702d(%rip)      # 0x18000a9d8
1800039ab:     	callq	0x180003bd8 <numba_list_iter_next+0xb78>
1800039b0:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800039b5:     	testb	%al, %al
1800039b7:     	jne	0x1800039bd <numba_list_iter_next+0x95d>
1800039b9:     	xorb	%al, %al
1800039bb:     	jmp	0x1800039d1 <numba_list_iter_next+0x971>
1800039bd:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800039c2:     	testb	%al, %al
1800039c4:     	jne	0x1800039cf <numba_list_iter_next+0x96f>
1800039c6:     	xorl	%ecx, %ecx
1800039c8:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
1800039cd:     	jmp	0x1800039b9 <numba_list_iter_next+0x959>
1800039cf:     	movb	$0x1, %al
1800039d1:     	addq	$0x28, %rsp
1800039d5:     	retq
1800039d6:     	int3
1800039d7:     	int3
1800039d8:     	pushq	%rbx
1800039da:     	subq	$0x20, %rsp
1800039de:     	cmpb	$0x0, 0x6ff4(%rip)      # 0x18000a9d9
1800039e5:     	movl	%ecx, %ebx
1800039e7:     	jne	0x180003a50 <numba_list_iter_next+0x9f0>
1800039e9:     	cmpl	$0x1, %ecx
1800039ec:     	ja	0x180003a58 <numba_list_iter_next+0x9f8>
1800039ee:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
1800039f3:     	testl	%eax, %eax
1800039f5:     	je	0x180003a1f <numba_list_iter_next+0x9bf>
1800039f7:     	testl	%ebx, %ebx
1800039f9:     	jne	0x180003a1f <numba_list_iter_next+0x9bf>
1800039fb:     	leaq	0x6fde(%rip), %rcx      # 0x18000a9e0
180003a02:     	callq	0x180003eba <numba_list_iter_next+0xe5a>
180003a07:     	testl	%eax, %eax
180003a09:     	jne	0x180003a1b <numba_list_iter_next+0x9bb>
180003a0b:     	leaq	0x6fe6(%rip), %rcx      # 0x18000a9f8
180003a12:     	callq	0x180003eba <numba_list_iter_next+0xe5a>
180003a17:     	testl	%eax, %eax
180003a19:     	je	0x180003a49 <numba_list_iter_next+0x9e9>
180003a1b:     	xorb	%al, %al
180003a1d:     	jmp	0x180003a52 <numba_list_iter_next+0x9f2>
180003a1f:     	movdqa	0xbd9(%rip), %xmm0      # 0x180004600
180003a27:     	orq	$-0x1, %rax
180003a2b:     	movdqu	%xmm0, 0x6fad(%rip)     # 0x18000a9e0
180003a33:     	movq	%rax, 0x6fb6(%rip)      # 0x18000a9f0
180003a3a:     	movdqu	%xmm0, 0x6fb6(%rip)     # 0x18000a9f8
180003a42:     	movq	%rax, 0x6fbf(%rip)      # 0x18000aa08
180003a49:     	movb	$0x1, 0x6f89(%rip)      # 0x18000a9d9
180003a50:     	movb	$0x1, %al
180003a52:     	addq	$0x20, %rsp
180003a56:     	popq	%rbx
180003a57:     	retq
180003a58:     	movl	$0x5, %ecx
180003a5d:     	callq	0x180003b54 <numba_list_iter_next+0xaf4>
180003a62:     	int3
180003a63:     	int3
180003a64:     	subq	$0x18, %rsp
180003a68:     	movq	%rcx, %r8
180003a6b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003a70:     	cmpw	%ax, -0x3a77(%rip)      # 0x180000000
180003a77:     	jne	0x180003af1 <numba_list_iter_next+0xa91>
180003a79:     	movslq	-0x3a44(%rip), %rcx     # 0x18000003c
180003a80:     	leaq	-0x3a87(%rip), %rdx     # 0x180000000
180003a87:     	addq	%rdx, %rcx
180003a8a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003a90:     	jne	0x180003af1 <numba_list_iter_next+0xa91>
180003a92:     	movl	$0x20b, %eax            # imm = 0x20B
180003a97:     	cmpw	%ax, 0x18(%rcx)
180003a9b:     	jne	0x180003af1 <numba_list_iter_next+0xa91>
180003a9d:     	subq	%rdx, %r8
180003aa0:     	movzwl	0x14(%rcx), %edx
180003aa4:     	addq	$0x18, %rdx
180003aa8:     	addq	%rcx, %rdx
180003aab:     	movzwl	0x6(%rcx), %eax
180003aaf:     	leaq	(%rax,%rax,4), %rcx
180003ab3:     	leaq	(%rdx,%rcx,8), %r9
180003ab7:     	movq	%rdx, (%rsp)
180003abb:     	cmpq	%r9, %rdx
180003abe:     	je	0x180003ad8 <numba_list_iter_next+0xa78>
180003ac0:     	movl	0xc(%rdx), %ecx
180003ac3:     	cmpq	%rcx, %r8
180003ac6:     	jb	0x180003ad2 <numba_list_iter_next+0xa72>
180003ac8:     	movl	0x8(%rdx), %eax
180003acb:     	addl	%ecx, %eax
180003acd:     	cmpq	%rax, %r8
180003ad0:     	jb	0x180003ada <numba_list_iter_next+0xa7a>
180003ad2:     	addq	$0x28, %rdx
180003ad6:     	jmp	0x180003ab7 <numba_list_iter_next+0xa57>
180003ad8:     	xorl	%edx, %edx
180003ada:     	testq	%rdx, %rdx
180003add:     	jne	0x180003ae3 <numba_list_iter_next+0xa83>
180003adf:     	xorb	%al, %al
180003ae1:     	jmp	0x180003af7 <numba_list_iter_next+0xa97>
180003ae3:     	cmpl	$0x0, 0x24(%rdx)
180003ae7:     	jge	0x180003aed <numba_list_iter_next+0xa8d>
180003ae9:     	xorb	%al, %al
180003aeb:     	jmp	0x180003af7 <numba_list_iter_next+0xa97>
180003aed:     	movb	$0x1, %al
180003aef:     	jmp	0x180003af7 <numba_list_iter_next+0xa97>
180003af1:     	xorb	%al, %al
180003af3:     	jmp	0x180003af7 <numba_list_iter_next+0xa97>
180003af5:     	xorb	%al, %al
180003af7:     	addq	$0x18, %rsp
180003afb:     	retq
180003afc:     	pushq	%rbx
180003afe:     	subq	$0x20, %rsp
180003b02:     	movb	%cl, %bl
180003b04:     	callq	0x180003e7c <numba_list_iter_next+0xe1c>
180003b09:     	xorl	%edx, %edx
180003b0b:     	testl	%eax, %eax
180003b0d:     	je	0x180003b1a <numba_list_iter_next+0xaba>
180003b0f:     	testb	%bl, %bl
180003b11:     	jne	0x180003b1a <numba_list_iter_next+0xaba>
180003b13:     	xchgq	%rdx, 0x6eb6(%rip)      # 0x18000a9d0
180003b1a:     	addq	$0x20, %rsp
180003b1e:     	popq	%rbx
180003b1f:     	retq
180003b20:     	pushq	%rbx
180003b22:     	subq	$0x20, %rsp
180003b26:     	cmpb	$0x0, 0x6eab(%rip)      # 0x18000a9d8
180003b2d:     	movb	%cl, %bl
180003b2f:     	je	0x180003b35 <numba_list_iter_next+0xad5>
180003b31:     	testb	%dl, %dl
180003b33:     	jne	0x180003b41 <numba_list_iter_next+0xae1>
180003b35:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
180003b3a:     	movb	%bl, %cl
180003b3c:     	callq	0x180003ecc <numba_list_iter_next+0xe6c>
180003b41:     	movb	$0x1, %al
180003b43:     	addq	$0x20, %rsp
180003b47:     	popq	%rbx
180003b48:     	retq
180003b49:     	int3
180003b4a:     	int3
180003b4b:     	int3
180003b4c:     	leaq	0x7115(%rip), %rax      # 0x18000ac68
180003b53:     	retq
180003b54:     	movl	%ecx, %ecx
180003b56:     	int	$0x29
180003b58:     	retq
180003b59:     	int3
180003b5a:     	int3
180003b5b:     	int3
180003b5c:     	movq	%rbx, 0x8(%rsp)
180003b61:     	pushq	%rdi
180003b62:     	subq	$0x20, %rsp
180003b66:     	leaq	0x3453(%rip), %rbx      # 0x180006fc0
180003b6d:     	leaq	0x344c(%rip), %rdi      # 0x180006fc0
180003b74:     	jmp	0x180003b88 <numba_list_iter_next+0xb28>
180003b76:     	movq	(%rbx), %rax
180003b79:     	testq	%rax, %rax
180003b7c:     	je	0x180003b84 <numba_list_iter_next+0xb24>
180003b7e:     	callq	*0x70c(%rip)            # 0x180004290
180003b84:     	addq	$0x8, %rbx
180003b88:     	cmpq	%rdi, %rbx
180003b8b:     	jb	0x180003b76 <numba_list_iter_next+0xb16>
180003b8d:     	movq	0x30(%rsp), %rbx
180003b92:     	addq	$0x20, %rsp
180003b96:     	popq	%rdi
180003b97:     	retq
180003b98:     	movq	%rbx, 0x8(%rsp)
180003b9d:     	pushq	%rdi
180003b9e:     	subq	$0x20, %rsp
180003ba2:     	leaq	0x3427(%rip), %rbx      # 0x180006fd0
180003ba9:     	leaq	0x3420(%rip), %rdi      # 0x180006fd0
180003bb0:     	jmp	0x180003bc4 <numba_list_iter_next+0xb64>
180003bb2:     	movq	(%rbx), %rax
180003bb5:     	testq	%rax, %rax
180003bb8:     	je	0x180003bc0 <numba_list_iter_next+0xb60>
180003bba:     	callq	*0x6d0(%rip)            # 0x180004290
180003bc0:     	addq	$0x8, %rbx
180003bc4:     	cmpq	%rdi, %rbx
180003bc7:     	jb	0x180003bb2 <numba_list_iter_next+0xb52>
180003bc9:     	movq	0x30(%rsp), %rbx
180003bce:     	addq	$0x20, %rsp
180003bd2:     	popq	%rdi
180003bd3:     	retq
180003bd4:     	retq	$0x0
180003bd7:     	int3
180003bd8:     	movq	%rbx, 0x10(%rsp)
180003bdd:     	movq	%rbp, 0x18(%rsp)
180003be2:     	movq	%rsi, 0x20(%rsp)
180003be7:     	pushq	%rdi
180003be8:     	subq	$0x10, %rsp
180003bec:     	xorl	%eax, %eax
180003bee:     	xorl	%ecx, %ecx
180003bf0:     	cpuid
180003bf2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003bf8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
180003bfe:     	orl	%ecx, %edx
180003c00:     	movl	%eax, %ebp
180003c02:     	movl	$0x1, %eax
180003c07:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
180003c0d:     	orl	%ebx, %edx
180003c0f:     	leal	-0x1(%rax), %ecx
180003c12:     	cpuid
180003c14:     	movl	%ecx, %edi
180003c16:     	jne	0x180003c76 <numba_list_iter_next+0xc16>
180003c18:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
180003c1d:     	movq	$0x8000, 0x64f0(%rip)   # imm = 0x8000
                                                # 0x18000a118
180003c28:     	movq	$-0x1, 0x64ed(%rip)     # 0x18000a120
180003c33:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180003c38:     	je	0x180003c62 <numba_list_iter_next+0xc02>
180003c3a:     	cmpl	$0x20660, %eax          # imm = 0x20660
180003c3f:     	je	0x180003c62 <numba_list_iter_next+0xc02>
180003c41:     	cmpl	$0x20670, %eax          # imm = 0x20670
180003c46:     	je	0x180003c62 <numba_list_iter_next+0xc02>
180003c48:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180003c4d:     	cmpl	$0x20, %eax
180003c50:     	ja	0x180003c76 <numba_list_iter_next+0xc16>
180003c52:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180003c5c:     	btq	%rax, %rcx
180003c60:     	jae	0x180003c76 <numba_list_iter_next+0xc16>
180003c62:     	movl	0x6dab(%rip), %r8d      # 0x18000aa14
180003c69:     	orl	$0x1, %r8d
180003c6d:     	movl	%r8d, 0x6da0(%rip)      # 0x18000aa14
180003c74:     	jmp	0x180003c7d <numba_list_iter_next+0xc1d>
180003c76:     	movl	0x6d97(%rip), %r8d      # 0x18000aa14
180003c7d:     	xorl	%r9d, %r9d
180003c80:     	movl	%r9d, %r11d
180003c83:     	cmpl	$0x7, %ebp
180003c86:     	jl	0x180003cca <numba_list_iter_next+0xc6a>
180003c88:     	xorl	%ecx, %ecx
180003c8a:     	leal	0x7(%r9), %eax
180003c8e:     	cpuid
180003c90:     	movl	%edx, %esi
180003c92:     	movl	%ebx, %r10d
180003c95:     	btl	$0x9, %ebx
180003c99:     	jae	0x180003ca6 <numba_list_iter_next+0xc46>
180003c9b:     	orl	$0x2, %r8d
180003c9f:     	movl	%r8d, 0x6d6e(%rip)      # 0x18000aa14
180003ca6:     	cmpl	$0x1, %eax
180003ca9:     	jl	0x180003cb8 <numba_list_iter_next+0xc58>
180003cab:     	movl	$0x7, %eax
180003cb0:     	leal	-0x6(%rax), %ecx
180003cb3:     	cpuid
180003cb5:     	movl	%edx, %r9d
180003cb8:     	movl	$0x24, %eax
180003cbd:     	cmpl	%eax, %ebp
180003cbf:     	jl	0x180003cd0 <numba_list_iter_next+0xc70>
180003cc1:     	xorl	%ecx, %ecx
180003cc3:     	cpuid
180003cc5:     	movl	%ebx, %r11d
180003cc8:     	jmp	0x180003cd0 <numba_list_iter_next+0xc70>
180003cca:     	movl	%r9d, %r10d
180003ccd:     	movl	%r9d, %esi
180003cd0:     	movq	0x6451(%rip), %rax      # 0x18000a128
180003cd7:     	andq	$-0x2, %rax
180003cdb:     	movl	$0x1, 0x642b(%rip)      # 0x18000a110
180003ce5:     	movl	$0x2, 0x6425(%rip)      # 0x18000a114
180003cef:     	movq	%rax, 0x6432(%rip)      # 0x18000a128
180003cf6:     	btl	$0x14, %edi
180003cfa:     	jae	0x180003d1b <numba_list_iter_next+0xcbb>
180003cfc:     	andq	$-0x11, %rax
180003d00:     	movl	$0x2, 0x6406(%rip)      # 0x18000a110
180003d0a:     	movq	%rax, 0x6417(%rip)      # 0x18000a128
180003d11:     	movl	$0x6, 0x63f9(%rip)      # 0x18000a114
180003d1b:     	btl	$0x1b, %edi
180003d1f:     	jae	0x180003e5c <numba_list_iter_next+0xdfc>
180003d25:     	xorl	%ecx, %ecx
180003d27:     	xgetbv
180003d2a:     	shlq	$0x20, %rdx
180003d2e:     	orq	%rax, %rdx
180003d31:     	movq	%rdx, 0x20(%rsp)
180003d36:     	btl	$0x1c, %edi
180003d3a:     	jae	0x180003e40 <numba_list_iter_next+0xde0>
180003d40:     	movq	0x20(%rsp), %rax
180003d45:     	andb	$0x6, %al
180003d47:     	cmpb	$0x6, %al
180003d49:     	jne	0x180003e40 <numba_list_iter_next+0xde0>
180003d4f:     	movl	0x63bf(%rip), %eax      # 0x18000a114
180003d55:     	movb	$-0x20, %dl
180003d57:     	orl	$0x8, %eax
180003d5a:     	movl	$0x3, 0x63ac(%rip)      # 0x18000a110
180003d64:     	movl	%eax, 0x63aa(%rip)      # 0x18000a114
180003d6a:     	testb	$0x20, %r10b
180003d6e:     	je	0x180003dd2 <numba_list_iter_next+0xd72>
180003d70:     	orl	$0x20, %eax
180003d73:     	movl	$0x5, 0x6393(%rip)      # 0x18000a110
180003d7d:     	movl	%eax, 0x6391(%rip)      # 0x18000a114
180003d83:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003d88:     	movq	0x6399(%rip), %rax      # 0x18000a128
180003d8f:     	andl	%ecx, %r10d
180003d92:     	andq	$-0x3, %rax
180003d96:     	movq	%rax, 0x638b(%rip)      # 0x18000a128
180003d9d:     	cmpl	%ecx, %r10d
180003da0:     	jne	0x180003dd9 <numba_list_iter_next+0xd79>
180003da2:     	movq	0x20(%rsp), %rax
180003da7:     	andb	%dl, %al
180003da9:     	cmpb	%dl, %al
180003dab:     	jne	0x180003dd2 <numba_list_iter_next+0xd72>
180003dad:     	movq	0x6374(%rip), %rax      # 0x18000a128
180003db4:     	orl	$0x40, 0x6359(%rip)     # 0x18000a114
180003dbb:     	andq	$-0x25, %rax
180003dbf:     	movl	$0x6, 0x6347(%rip)      # 0x18000a110
180003dc9:     	movq	%rax, 0x6358(%rip)      # 0x18000a128
180003dd0:     	jmp	0x180003dd9 <numba_list_iter_next+0xd79>
180003dd2:     	movq	0x634f(%rip), %rax      # 0x18000a128
180003dd9:     	btl	$0x17, %esi
180003ddd:     	jae	0x180003deb <numba_list_iter_next+0xd8b>
180003ddf:     	btrq	$0x18, %rax
180003de4:     	movq	%rax, 0x633d(%rip)      # 0x18000a128
180003deb:     	btl	$0x13, %r9d
180003df0:     	jae	0x180003e40 <numba_list_iter_next+0xde0>
180003df2:     	movq	0x20(%rsp), %rax
180003df7:     	andb	%dl, %al
180003df9:     	cmpb	%dl, %al
180003dfb:     	jne	0x180003e40 <numba_list_iter_next+0xde0>
180003dfd:     	movq	0x6324(%rip), %rdx      # 0x18000a128
180003e04:     	movl	%r11d, %eax
180003e07:     	shrq	$0x10, %rax
180003e0b:     	movl	%r11d, %ecx
180003e0e:     	andl	$0x6, %eax
180003e11:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003e17:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003e1d:     	movl	%ecx, 0x6bf5(%rip)      # 0x18000aa18
180003e23:     	notq	%rax
180003e26:     	andq	%rax, %rdx
180003e29:     	movq	%rdx, 0x62f8(%rip)      # 0x18000a128
180003e30:     	cmpb	$0x1, %cl
180003e33:     	jbe	0x180003e40 <numba_list_iter_next+0xde0>
180003e35:     	andq	$-0x41, %rdx
180003e39:     	movq	%rdx, 0x62e8(%rip)      # 0x18000a128
180003e40:     	btl	$0x15, %r9d
180003e45:     	jae	0x180003e5c <numba_list_iter_next+0xdfc>
180003e47:     	movq	0x20(%rsp), %rax
180003e4c:     	btq	$0x13, %rax
180003e51:     	jae	0x180003e5c <numba_list_iter_next+0xdfc>
180003e53:     	btrq	$0x7, 0x62cc(%rip)      # 0x18000a128
180003e5c:     	movq	0x28(%rsp), %rbx
180003e61:     	xorl	%eax, %eax
180003e63:     	movq	0x30(%rsp), %rbp
180003e68:     	movq	0x38(%rsp), %rsi
180003e6d:     	addq	$0x10, %rsp
180003e71:     	popq	%rdi
180003e72:     	retq
180003e73:     	int3
180003e74:     	movl	$0x1, %eax
180003e79:     	retq
180003e7a:     	int3
180003e7b:     	int3
180003e7c:     	xorl	%eax, %eax
180003e7e:     	cmpl	%eax, 0x62ac(%rip)      # 0x18000a130
180003e84:     	setne	%al
180003e87:     	retq
180003e88:     	int3
180003e89:     	int3
180003e8a:     	int3
180003e8b:     	int3
180003e8c:     	int3
180003e8d:     	int3
180003e8e:     	int3
180003e8f:     	int3
180003e90:     	jmpq	*0x1b2(%rip)            # 0x180004048
180003e96:     	jmpq	*0x1b4(%rip)            # 0x180004050
180003e9c:     	jmpq	*0x1ee(%rip)            # 0x180004090
180003ea2:     	jmpq	*0x1f0(%rip)            # 0x180004098
180003ea8:     	jmpq	*0x1f2(%rip)            # 0x1800040a0
180003eae:     	jmpq	*0x1f4(%rip)            # 0x1800040a8
180003eb4:     	jmpq	*0x1f6(%rip)            # 0x1800040b0
180003eba:     	jmpq	*0x1c0(%rip)            # 0x180004080
180003ec0:     	jmpq	*0x1f2(%rip)            # 0x1800040b8
180003ec6:     	jmpq	*0x1bc(%rip)            # 0x180004088
180003ecc:     	movb	$0x1, %al
180003ece:     	retq
180003ecf:     	int3
180003ed0:     	xorl	%eax, %eax
180003ed2:     	retq
180003ed3:     	jmpq	*0x15f(%rip)            # 0x180004038
180003ed9:     	jmpq	*0x161(%rip)            # 0x180004040
180003edf:     	jmpq	*0x1e3(%rip)            # 0x1800040c8
180003ee5:     	jmpq	*0x1e5(%rip)            # 0x1800040d0
180003eeb:     	int3
180003eec:     	int3
180003eed:     	int3
180003eee:     	int3
180003eef:     	int3
180003ef0:     	int3
180003ef1:     	int3
180003ef2:     	int3
180003ef3:     	int3
180003ef4:     	int3
180003ef5:     	int3
180003ef6:     	nopw	(%rax,%rax)
180003f00:     	jmpq	*%rax
180003f02:     	int3
180003f03:     	int3
180003f04:     	int3
180003f05:     	int3
180003f06:     	int3
180003f07:     	int3
180003f08:     	int3
180003f09:     	int3
180003f0a:     	int3
180003f0b:     	int3
180003f0c:     	int3
180003f0d:     	int3
180003f0e:     	int3
180003f0f:     	int3
180003f10:     	int3
180003f11:     	int3
180003f12:     	int3
180003f13:     	int3
180003f14:     	int3
180003f15:     	int3
180003f16:     	nopw	(%rax,%rax)
180003f20:     	jmpq	*0x36a(%rip)            # 0x180004290
180003f26:     	pushq	%rbp
180003f28:     	subq	$0x20, %rsp
180003f2c:     	movq	%rdx, %rbp
180003f2f:     	movb	0x40(%rbp), %cl
180003f32:     	addq	$0x20, %rsp
180003f36:     	popq	%rbp
180003f37:     	jmp	0x180003afc <numba_list_iter_next+0xa9c>
180003f3c:     	int3
180003f3d:     	pushq	%rbp
180003f3f:     	subq	$0x20, %rsp
180003f43:     	movq	%rdx, %rbp
180003f46:     	movb	0x20(%rbp), %cl
180003f49:     	callq	0x180003afc <numba_list_iter_next+0xa9c>
180003f4e:     	nop
180003f4f:     	addq	$0x20, %rsp
180003f53:     	popq	%rbp
180003f54:     	retq
180003f55:     	int3
180003f56:     	pushq	%rbp
180003f58:     	subq	$0x20, %rsp
180003f5c:     	movq	%rdx, %rbp
180003f5f:     	addq	$0x20, %rsp
180003f63:     	popq	%rbp
180003f64:     	jmp	0x180003988 <numba_list_iter_next+0x928>
180003f69:     	int3
180003f6a:     	pushq	%rbp
180003f6c:     	subq	$0x30, %rsp
180003f70:     	movq	%rdx, %rbp
180003f73:     	movq	(%rcx), %rax
180003f76:     	movl	(%rax), %edx
180003f78:     	movq	%rcx, 0x28(%rsp)
180003f7d:     	movl	%edx, 0x20(%rsp)
180003f81:     	leaq	-0xbc8(%rip), %r9       # 0x1800033c0 <numba_list_iter_next+0x360>
180003f88:     	movq	0x70(%rbp), %r8
180003f8c:     	movl	0x68(%rbp), %edx
180003f8f:     	movq	0x60(%rbp), %rcx
180003f93:     	callq	0x1800038f8 <numba_list_iter_next+0x898>
180003f98:     	nop
180003f99:     	addq	$0x30, %rsp
180003f9d:     	popq	%rbp
180003f9e:     	retq
180003f9f:     	int3
180003fa0:     	pushq	%rbp
180003fa2:     	movq	%rdx, %rbp
180003fa5:     	movq	(%rcx), %rax
180003fa8:     	xorl	%ecx, %ecx
180003faa:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003fb0:     	sete	%cl
180003fb3:     	movl	%ecx, %eax
180003fb5:     	popq	%rbp
180003fb6:     	retq
180003fb7:     	int3
