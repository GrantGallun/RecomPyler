
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-binding-final\aot\candidate-strict\recurrence_64\rcaotr_de6cc5325c7b4615732d57b8.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180003d00 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x4339(%rip), %rax      # 0x1800053c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	cvtsi2sd	%r8, %xmm1
180001095:     	cvtsi2sd	%r9, %xmm0
18000109a:     	mulsd	%xmm0, %xmm1
18000109e:     	andpd	0x426a(%rip), %xmm1     # 0x180005310
1800010a6:     	ucomisd	0x4272(%rip), %xmm1     # 0x180005320
1800010ae:     	jae	0x180001f85 <.text+0xf85>
1800010b4:     	cmpb	$0x0, (%rdx)
1800010b7:     	jne	0x180001f88 <.text+0xf88>
1800010bd:     	movq	0x28(%rsp), %rax
1800010c2:     	imulq	%r9, %r8
1800010c6:     	leaq	(%r8,%rax), %r10
1800010ca:     	xorq	%r10, %r8
1800010cd:     	movq	%r10, %r11
1800010d0:     	xorq	%rax, %r11
1800010d3:     	testq	%r11, %r8
1800010d6:     	js	0x180001f85 <.text+0xf85>
1800010dc:     	xorps	%xmm1, %xmm1
1800010df:     	cvtsi2sd	%r10, %xmm1
1800010e4:     	mulsd	%xmm0, %xmm1
1800010e8:     	andpd	0x4220(%rip), %xmm1     # 0x180005310
1800010f0:     	ucomisd	0x4228(%rip), %xmm1     # 0x180005320
1800010f8:     	jae	0x180001f85 <.text+0xf85>
1800010fe:     	imulq	%r9, %r10
180001102:     	leaq	(%r10,%rax), %r8
180001106:     	xorq	%r8, %r10
180001109:     	movq	%r8, %r11
18000110c:     	xorq	%rax, %r11
18000110f:     	testq	%r11, %r10
180001112:     	js	0x180001f85 <.text+0xf85>
180001118:     	xorps	%xmm1, %xmm1
18000111b:     	cvtsi2sd	%r8, %xmm1
180001120:     	mulsd	%xmm0, %xmm1
180001124:     	andpd	0x41e4(%rip), %xmm1     # 0x180005310
18000112c:     	ucomisd	0x41ec(%rip), %xmm1     # 0x180005320
180001134:     	jae	0x180001f85 <.text+0xf85>
18000113a:     	imulq	%r9, %r8
18000113e:     	leaq	(%r8,%rax), %r10
180001142:     	xorq	%r10, %r8
180001145:     	movq	%r10, %r11
180001148:     	xorq	%rax, %r11
18000114b:     	testq	%r11, %r8
18000114e:     	js	0x180001f85 <.text+0xf85>
180001154:     	xorps	%xmm1, %xmm1
180001157:     	cvtsi2sd	%r10, %xmm1
18000115c:     	mulsd	%xmm0, %xmm1
180001160:     	andpd	0x41a8(%rip), %xmm1     # 0x180005310
180001168:     	ucomisd	0x41b0(%rip), %xmm1     # 0x180005320
180001170:     	jae	0x180001f85 <.text+0xf85>
180001176:     	imulq	%r9, %r10
18000117a:     	leaq	(%r10,%rax), %r8
18000117e:     	xorq	%r8, %r10
180001181:     	movq	%r8, %r11
180001184:     	xorq	%rax, %r11
180001187:     	testq	%r11, %r10
18000118a:     	js	0x180001f85 <.text+0xf85>
180001190:     	xorps	%xmm1, %xmm1
180001193:     	cvtsi2sd	%r8, %xmm1
180001198:     	mulsd	%xmm0, %xmm1
18000119c:     	andpd	0x416c(%rip), %xmm1     # 0x180005310
1800011a4:     	ucomisd	0x4174(%rip), %xmm1     # 0x180005320
1800011ac:     	jae	0x180001f85 <.text+0xf85>
1800011b2:     	imulq	%r9, %r8
1800011b6:     	leaq	(%r8,%rax), %r10
1800011ba:     	xorq	%r10, %r8
1800011bd:     	movq	%r10, %r11
1800011c0:     	xorq	%rax, %r11
1800011c3:     	testq	%r11, %r8
1800011c6:     	js	0x180001f85 <.text+0xf85>
1800011cc:     	xorps	%xmm1, %xmm1
1800011cf:     	cvtsi2sd	%r10, %xmm1
1800011d4:     	mulsd	%xmm0, %xmm1
1800011d8:     	andpd	0x4130(%rip), %xmm1     # 0x180005310
1800011e0:     	ucomisd	0x4138(%rip), %xmm1     # 0x180005320
1800011e8:     	jae	0x180001f85 <.text+0xf85>
1800011ee:     	imulq	%r9, %r10
1800011f2:     	leaq	(%r10,%rax), %r8
1800011f6:     	xorq	%r8, %r10
1800011f9:     	movq	%r8, %r11
1800011fc:     	xorq	%rax, %r11
1800011ff:     	testq	%r11, %r10
180001202:     	js	0x180001f85 <.text+0xf85>
180001208:     	xorps	%xmm1, %xmm1
18000120b:     	cvtsi2sd	%r8, %xmm1
180001210:     	mulsd	%xmm0, %xmm1
180001214:     	andpd	0x40f4(%rip), %xmm1     # 0x180005310
18000121c:     	ucomisd	0x40fc(%rip), %xmm1     # 0x180005320
180001224:     	jae	0x180001f85 <.text+0xf85>
18000122a:     	imulq	%r9, %r8
18000122e:     	leaq	(%r8,%rax), %r10
180001232:     	xorq	%r10, %r8
180001235:     	movq	%r10, %r11
180001238:     	xorq	%rax, %r11
18000123b:     	testq	%r11, %r8
18000123e:     	js	0x180001f85 <.text+0xf85>
180001244:     	xorps	%xmm1, %xmm1
180001247:     	cvtsi2sd	%r10, %xmm1
18000124c:     	mulsd	%xmm0, %xmm1
180001250:     	andpd	0x40b8(%rip), %xmm1     # 0x180005310
180001258:     	ucomisd	0x40c0(%rip), %xmm1     # 0x180005320
180001260:     	jae	0x180001f85 <.text+0xf85>
180001266:     	imulq	%r9, %r10
18000126a:     	leaq	(%r10,%rax), %r8
18000126e:     	xorq	%r8, %r10
180001271:     	movq	%r8, %r11
180001274:     	xorq	%rax, %r11
180001277:     	testq	%r11, %r10
18000127a:     	js	0x180001f85 <.text+0xf85>
180001280:     	xorps	%xmm1, %xmm1
180001283:     	cvtsi2sd	%r8, %xmm1
180001288:     	mulsd	%xmm0, %xmm1
18000128c:     	andpd	0x407c(%rip), %xmm1     # 0x180005310
180001294:     	ucomisd	0x4084(%rip), %xmm1     # 0x180005320
18000129c:     	jae	0x180001f85 <.text+0xf85>
1800012a2:     	imulq	%r9, %r8
1800012a6:     	leaq	(%r8,%rax), %r10
1800012aa:     	xorq	%r10, %r8
1800012ad:     	movq	%r10, %r11
1800012b0:     	xorq	%rax, %r11
1800012b3:     	testq	%r11, %r8
1800012b6:     	js	0x180001f85 <.text+0xf85>
1800012bc:     	xorps	%xmm1, %xmm1
1800012bf:     	cvtsi2sd	%r10, %xmm1
1800012c4:     	mulsd	%xmm0, %xmm1
1800012c8:     	andpd	0x4040(%rip), %xmm1     # 0x180005310
1800012d0:     	ucomisd	0x4048(%rip), %xmm1     # 0x180005320
1800012d8:     	jae	0x180001f85 <.text+0xf85>
1800012de:     	imulq	%r9, %r10
1800012e2:     	leaq	(%r10,%rax), %r8
1800012e6:     	xorq	%r8, %r10
1800012e9:     	movq	%r8, %r11
1800012ec:     	xorq	%rax, %r11
1800012ef:     	testq	%r11, %r10
1800012f2:     	js	0x180001f85 <.text+0xf85>
1800012f8:     	xorps	%xmm1, %xmm1
1800012fb:     	cvtsi2sd	%r8, %xmm1
180001300:     	mulsd	%xmm0, %xmm1
180001304:     	andpd	0x4004(%rip), %xmm1     # 0x180005310
18000130c:     	ucomisd	0x400c(%rip), %xmm1     # 0x180005320
180001314:     	jae	0x180001f85 <.text+0xf85>
18000131a:     	imulq	%r9, %r8
18000131e:     	leaq	(%r8,%rax), %r10
180001322:     	xorq	%r10, %r8
180001325:     	movq	%r10, %r11
180001328:     	xorq	%rax, %r11
18000132b:     	testq	%r11, %r8
18000132e:     	js	0x180001f85 <.text+0xf85>
180001334:     	xorps	%xmm1, %xmm1
180001337:     	cvtsi2sd	%r10, %xmm1
18000133c:     	mulsd	%xmm0, %xmm1
180001340:     	andpd	0x3fc8(%rip), %xmm1     # 0x180005310
180001348:     	ucomisd	0x3fd0(%rip), %xmm1     # 0x180005320
180001350:     	jae	0x180001f85 <.text+0xf85>
180001356:     	imulq	%r9, %r10
18000135a:     	leaq	(%r10,%rax), %r8
18000135e:     	xorq	%r8, %r10
180001361:     	movq	%r8, %r11
180001364:     	xorq	%rax, %r11
180001367:     	testq	%r11, %r10
18000136a:     	js	0x180001f85 <.text+0xf85>
180001370:     	xorps	%xmm1, %xmm1
180001373:     	cvtsi2sd	%r8, %xmm1
180001378:     	mulsd	%xmm0, %xmm1
18000137c:     	andpd	0x3f8c(%rip), %xmm1     # 0x180005310
180001384:     	ucomisd	0x3f94(%rip), %xmm1     # 0x180005320
18000138c:     	jae	0x180001f85 <.text+0xf85>
180001392:     	imulq	%r9, %r8
180001396:     	leaq	(%r8,%rax), %r10
18000139a:     	xorq	%r10, %r8
18000139d:     	movq	%r10, %r11
1800013a0:     	xorq	%rax, %r11
1800013a3:     	testq	%r11, %r8
1800013a6:     	js	0x180001f85 <.text+0xf85>
1800013ac:     	xorps	%xmm1, %xmm1
1800013af:     	cvtsi2sd	%r10, %xmm1
1800013b4:     	mulsd	%xmm0, %xmm1
1800013b8:     	andpd	0x3f50(%rip), %xmm1     # 0x180005310
1800013c0:     	ucomisd	0x3f58(%rip), %xmm1     # 0x180005320
1800013c8:     	jae	0x180001f85 <.text+0xf85>
1800013ce:     	imulq	%r9, %r10
1800013d2:     	leaq	(%r10,%rax), %r8
1800013d6:     	xorq	%r8, %r10
1800013d9:     	movq	%r8, %r11
1800013dc:     	xorq	%rax, %r11
1800013df:     	testq	%r11, %r10
1800013e2:     	js	0x180001f85 <.text+0xf85>
1800013e8:     	xorps	%xmm1, %xmm1
1800013eb:     	cvtsi2sd	%r8, %xmm1
1800013f0:     	mulsd	%xmm0, %xmm1
1800013f4:     	andpd	0x3f14(%rip), %xmm1     # 0x180005310
1800013fc:     	ucomisd	0x3f1c(%rip), %xmm1     # 0x180005320
180001404:     	jae	0x180001f85 <.text+0xf85>
18000140a:     	imulq	%r9, %r8
18000140e:     	leaq	(%r8,%rax), %r10
180001412:     	xorq	%r10, %r8
180001415:     	movq	%r10, %r11
180001418:     	xorq	%rax, %r11
18000141b:     	testq	%r11, %r8
18000141e:     	js	0x180001f85 <.text+0xf85>
180001424:     	xorps	%xmm1, %xmm1
180001427:     	cvtsi2sd	%r10, %xmm1
18000142c:     	mulsd	%xmm0, %xmm1
180001430:     	andpd	0x3ed8(%rip), %xmm1     # 0x180005310
180001438:     	ucomisd	0x3ee0(%rip), %xmm1     # 0x180005320
180001440:     	jae	0x180001f85 <.text+0xf85>
180001446:     	imulq	%r9, %r10
18000144a:     	leaq	(%r10,%rax), %r8
18000144e:     	xorq	%r8, %r10
180001451:     	movq	%r8, %r11
180001454:     	xorq	%rax, %r11
180001457:     	testq	%r11, %r10
18000145a:     	js	0x180001f85 <.text+0xf85>
180001460:     	xorps	%xmm1, %xmm1
180001463:     	cvtsi2sd	%r8, %xmm1
180001468:     	mulsd	%xmm0, %xmm1
18000146c:     	andpd	0x3e9c(%rip), %xmm1     # 0x180005310
180001474:     	ucomisd	0x3ea4(%rip), %xmm1     # 0x180005320
18000147c:     	jae	0x180001f85 <.text+0xf85>
180001482:     	imulq	%r9, %r8
180001486:     	leaq	(%r8,%rax), %r10
18000148a:     	xorq	%r10, %r8
18000148d:     	movq	%r10, %r11
180001490:     	xorq	%rax, %r11
180001493:     	testq	%r11, %r8
180001496:     	js	0x180001f85 <.text+0xf85>
18000149c:     	xorps	%xmm1, %xmm1
18000149f:     	cvtsi2sd	%r10, %xmm1
1800014a4:     	mulsd	%xmm0, %xmm1
1800014a8:     	andpd	0x3e60(%rip), %xmm1     # 0x180005310
1800014b0:     	ucomisd	0x3e68(%rip), %xmm1     # 0x180005320
1800014b8:     	jae	0x180001f85 <.text+0xf85>
1800014be:     	imulq	%r9, %r10
1800014c2:     	leaq	(%r10,%rax), %r8
1800014c6:     	xorq	%r8, %r10
1800014c9:     	movq	%r8, %r11
1800014cc:     	xorq	%rax, %r11
1800014cf:     	testq	%r11, %r10
1800014d2:     	js	0x180001f85 <.text+0xf85>
1800014d8:     	xorps	%xmm1, %xmm1
1800014db:     	cvtsi2sd	%r8, %xmm1
1800014e0:     	mulsd	%xmm0, %xmm1
1800014e4:     	andpd	0x3e24(%rip), %xmm1     # 0x180005310
1800014ec:     	ucomisd	0x3e2c(%rip), %xmm1     # 0x180005320
1800014f4:     	jae	0x180001f85 <.text+0xf85>
1800014fa:     	imulq	%r9, %r8
1800014fe:     	leaq	(%r8,%rax), %r10
180001502:     	xorq	%r10, %r8
180001505:     	movq	%r10, %r11
180001508:     	xorq	%rax, %r11
18000150b:     	testq	%r11, %r8
18000150e:     	js	0x180001f85 <.text+0xf85>
180001514:     	xorps	%xmm1, %xmm1
180001517:     	cvtsi2sd	%r10, %xmm1
18000151c:     	mulsd	%xmm0, %xmm1
180001520:     	andpd	0x3de8(%rip), %xmm1     # 0x180005310
180001528:     	ucomisd	0x3df0(%rip), %xmm1     # 0x180005320
180001530:     	jae	0x180001f85 <.text+0xf85>
180001536:     	imulq	%r9, %r10
18000153a:     	leaq	(%r10,%rax), %r8
18000153e:     	xorq	%r8, %r10
180001541:     	movq	%r8, %r11
180001544:     	xorq	%rax, %r11
180001547:     	testq	%r11, %r10
18000154a:     	js	0x180001f85 <.text+0xf85>
180001550:     	xorps	%xmm1, %xmm1
180001553:     	cvtsi2sd	%r8, %xmm1
180001558:     	mulsd	%xmm0, %xmm1
18000155c:     	andpd	0x3dac(%rip), %xmm1     # 0x180005310
180001564:     	ucomisd	0x3db4(%rip), %xmm1     # 0x180005320
18000156c:     	jae	0x180001f85 <.text+0xf85>
180001572:     	imulq	%r9, %r8
180001576:     	leaq	(%r8,%rax), %r10
18000157a:     	xorq	%r10, %r8
18000157d:     	movq	%r10, %r11
180001580:     	xorq	%rax, %r11
180001583:     	testq	%r11, %r8
180001586:     	js	0x180001f85 <.text+0xf85>
18000158c:     	xorps	%xmm1, %xmm1
18000158f:     	cvtsi2sd	%r10, %xmm1
180001594:     	mulsd	%xmm0, %xmm1
180001598:     	andpd	0x3d70(%rip), %xmm1     # 0x180005310
1800015a0:     	ucomisd	0x3d78(%rip), %xmm1     # 0x180005320
1800015a8:     	jae	0x180001f85 <.text+0xf85>
1800015ae:     	imulq	%r9, %r10
1800015b2:     	leaq	(%r10,%rax), %r8
1800015b6:     	xorq	%r8, %r10
1800015b9:     	movq	%r8, %r11
1800015bc:     	xorq	%rax, %r11
1800015bf:     	testq	%r11, %r10
1800015c2:     	js	0x180001f85 <.text+0xf85>
1800015c8:     	xorps	%xmm1, %xmm1
1800015cb:     	cvtsi2sd	%r8, %xmm1
1800015d0:     	mulsd	%xmm0, %xmm1
1800015d4:     	andpd	0x3d34(%rip), %xmm1     # 0x180005310
1800015dc:     	ucomisd	0x3d3c(%rip), %xmm1     # 0x180005320
1800015e4:     	jae	0x180001f85 <.text+0xf85>
1800015ea:     	imulq	%r9, %r8
1800015ee:     	leaq	(%r8,%rax), %r10
1800015f2:     	xorq	%r10, %r8
1800015f5:     	movq	%r10, %r11
1800015f8:     	xorq	%rax, %r11
1800015fb:     	testq	%r11, %r8
1800015fe:     	js	0x180001f85 <.text+0xf85>
180001604:     	xorps	%xmm1, %xmm1
180001607:     	cvtsi2sd	%r10, %xmm1
18000160c:     	mulsd	%xmm0, %xmm1
180001610:     	andpd	0x3cf8(%rip), %xmm1     # 0x180005310
180001618:     	ucomisd	0x3d00(%rip), %xmm1     # 0x180005320
180001620:     	jae	0x180001f85 <.text+0xf85>
180001626:     	imulq	%r9, %r10
18000162a:     	leaq	(%r10,%rax), %r8
18000162e:     	xorq	%r8, %r10
180001631:     	movq	%r8, %r11
180001634:     	xorq	%rax, %r11
180001637:     	testq	%r11, %r10
18000163a:     	js	0x180001f85 <.text+0xf85>
180001640:     	xorps	%xmm1, %xmm1
180001643:     	cvtsi2sd	%r8, %xmm1
180001648:     	mulsd	%xmm0, %xmm1
18000164c:     	andpd	0x3cbc(%rip), %xmm1     # 0x180005310
180001654:     	ucomisd	0x3cc4(%rip), %xmm1     # 0x180005320
18000165c:     	jae	0x180001f85 <.text+0xf85>
180001662:     	imulq	%r9, %r8
180001666:     	leaq	(%r8,%rax), %r10
18000166a:     	xorq	%r10, %r8
18000166d:     	movq	%r10, %r11
180001670:     	xorq	%rax, %r11
180001673:     	testq	%r11, %r8
180001676:     	js	0x180001f85 <.text+0xf85>
18000167c:     	xorps	%xmm1, %xmm1
18000167f:     	cvtsi2sd	%r10, %xmm1
180001684:     	mulsd	%xmm0, %xmm1
180001688:     	andpd	0x3c80(%rip), %xmm1     # 0x180005310
180001690:     	ucomisd	0x3c88(%rip), %xmm1     # 0x180005320
180001698:     	jae	0x180001f85 <.text+0xf85>
18000169e:     	imulq	%r9, %r10
1800016a2:     	leaq	(%r10,%rax), %r8
1800016a6:     	xorq	%r8, %r10
1800016a9:     	movq	%r8, %r11
1800016ac:     	xorq	%rax, %r11
1800016af:     	testq	%r11, %r10
1800016b2:     	js	0x180001f85 <.text+0xf85>
1800016b8:     	xorps	%xmm1, %xmm1
1800016bb:     	cvtsi2sd	%r8, %xmm1
1800016c0:     	mulsd	%xmm0, %xmm1
1800016c4:     	andpd	0x3c44(%rip), %xmm1     # 0x180005310
1800016cc:     	ucomisd	0x3c4c(%rip), %xmm1     # 0x180005320
1800016d4:     	jae	0x180001f85 <.text+0xf85>
1800016da:     	imulq	%r9, %r8
1800016de:     	leaq	(%r8,%rax), %r10
1800016e2:     	xorq	%r10, %r8
1800016e5:     	movq	%r10, %r11
1800016e8:     	xorq	%rax, %r11
1800016eb:     	testq	%r11, %r8
1800016ee:     	js	0x180001f85 <.text+0xf85>
1800016f4:     	xorps	%xmm1, %xmm1
1800016f7:     	cvtsi2sd	%r10, %xmm1
1800016fc:     	mulsd	%xmm0, %xmm1
180001700:     	andpd	0x3c08(%rip), %xmm1     # 0x180005310
180001708:     	ucomisd	0x3c10(%rip), %xmm1     # 0x180005320
180001710:     	jae	0x180001f85 <.text+0xf85>
180001716:     	imulq	%r9, %r10
18000171a:     	leaq	(%r10,%rax), %r8
18000171e:     	xorq	%r8, %r10
180001721:     	movq	%r8, %r11
180001724:     	xorq	%rax, %r11
180001727:     	testq	%r11, %r10
18000172a:     	js	0x180001f85 <.text+0xf85>
180001730:     	xorps	%xmm1, %xmm1
180001733:     	cvtsi2sd	%r8, %xmm1
180001738:     	mulsd	%xmm0, %xmm1
18000173c:     	andpd	0x3bcc(%rip), %xmm1     # 0x180005310
180001744:     	ucomisd	0x3bd4(%rip), %xmm1     # 0x180005320
18000174c:     	jae	0x180001f85 <.text+0xf85>
180001752:     	imulq	%r9, %r8
180001756:     	leaq	(%r8,%rax), %r10
18000175a:     	xorq	%r10, %r8
18000175d:     	movq	%r10, %r11
180001760:     	xorq	%rax, %r11
180001763:     	testq	%r11, %r8
180001766:     	js	0x180001f85 <.text+0xf85>
18000176c:     	xorps	%xmm1, %xmm1
18000176f:     	cvtsi2sd	%r10, %xmm1
180001774:     	mulsd	%xmm0, %xmm1
180001778:     	andpd	0x3b90(%rip), %xmm1     # 0x180005310
180001780:     	ucomisd	0x3b98(%rip), %xmm1     # 0x180005320
180001788:     	jae	0x180001f85 <.text+0xf85>
18000178e:     	imulq	%r9, %r10
180001792:     	leaq	(%r10,%rax), %r8
180001796:     	xorq	%r8, %r10
180001799:     	movq	%r8, %r11
18000179c:     	xorq	%rax, %r11
18000179f:     	testq	%r11, %r10
1800017a2:     	js	0x180001f85 <.text+0xf85>
1800017a8:     	xorps	%xmm1, %xmm1
1800017ab:     	cvtsi2sd	%r8, %xmm1
1800017b0:     	mulsd	%xmm0, %xmm1
1800017b4:     	andpd	0x3b54(%rip), %xmm1     # 0x180005310
1800017bc:     	ucomisd	0x3b5c(%rip), %xmm1     # 0x180005320
1800017c4:     	jae	0x180001f85 <.text+0xf85>
1800017ca:     	imulq	%r9, %r8
1800017ce:     	leaq	(%r8,%rax), %r10
1800017d2:     	xorq	%r10, %r8
1800017d5:     	movq	%r10, %r11
1800017d8:     	xorq	%rax, %r11
1800017db:     	testq	%r11, %r8
1800017de:     	js	0x180001f85 <.text+0xf85>
1800017e4:     	xorps	%xmm1, %xmm1
1800017e7:     	cvtsi2sd	%r10, %xmm1
1800017ec:     	mulsd	%xmm0, %xmm1
1800017f0:     	andpd	0x3b18(%rip), %xmm1     # 0x180005310
1800017f8:     	ucomisd	0x3b20(%rip), %xmm1     # 0x180005320
180001800:     	jae	0x180001f85 <.text+0xf85>
180001806:     	imulq	%r9, %r10
18000180a:     	leaq	(%r10,%rax), %r8
18000180e:     	xorq	%r8, %r10
180001811:     	movq	%r8, %r11
180001814:     	xorq	%rax, %r11
180001817:     	testq	%r11, %r10
18000181a:     	js	0x180001f85 <.text+0xf85>
180001820:     	xorps	%xmm1, %xmm1
180001823:     	cvtsi2sd	%r8, %xmm1
180001828:     	mulsd	%xmm0, %xmm1
18000182c:     	andpd	0x3adc(%rip), %xmm1     # 0x180005310
180001834:     	ucomisd	0x3ae4(%rip), %xmm1     # 0x180005320
18000183c:     	jae	0x180001f85 <.text+0xf85>
180001842:     	imulq	%r9, %r8
180001846:     	leaq	(%r8,%rax), %r10
18000184a:     	xorq	%r10, %r8
18000184d:     	movq	%r10, %r11
180001850:     	xorq	%rax, %r11
180001853:     	testq	%r11, %r8
180001856:     	js	0x180001f85 <.text+0xf85>
18000185c:     	xorps	%xmm1, %xmm1
18000185f:     	cvtsi2sd	%r10, %xmm1
180001864:     	mulsd	%xmm0, %xmm1
180001868:     	andpd	0x3aa0(%rip), %xmm1     # 0x180005310
180001870:     	ucomisd	0x3aa8(%rip), %xmm1     # 0x180005320
180001878:     	jae	0x180001f85 <.text+0xf85>
18000187e:     	imulq	%r9, %r10
180001882:     	leaq	(%r10,%rax), %r8
180001886:     	xorq	%r8, %r10
180001889:     	movq	%r8, %r11
18000188c:     	xorq	%rax, %r11
18000188f:     	testq	%r11, %r10
180001892:     	js	0x180001f85 <.text+0xf85>
180001898:     	xorps	%xmm1, %xmm1
18000189b:     	cvtsi2sd	%r8, %xmm1
1800018a0:     	mulsd	%xmm0, %xmm1
1800018a4:     	andpd	0x3a64(%rip), %xmm1     # 0x180005310
1800018ac:     	ucomisd	0x3a6c(%rip), %xmm1     # 0x180005320
1800018b4:     	jae	0x180001f85 <.text+0xf85>
1800018ba:     	imulq	%r9, %r8
1800018be:     	leaq	(%r8,%rax), %r10
1800018c2:     	xorq	%r10, %r8
1800018c5:     	movq	%r10, %r11
1800018c8:     	xorq	%rax, %r11
1800018cb:     	testq	%r11, %r8
1800018ce:     	js	0x180001f85 <.text+0xf85>
1800018d4:     	xorps	%xmm1, %xmm1
1800018d7:     	cvtsi2sd	%r10, %xmm1
1800018dc:     	mulsd	%xmm0, %xmm1
1800018e0:     	andpd	0x3a28(%rip), %xmm1     # 0x180005310
1800018e8:     	ucomisd	0x3a30(%rip), %xmm1     # 0x180005320
1800018f0:     	jae	0x180001f85 <.text+0xf85>
1800018f6:     	imulq	%r9, %r10
1800018fa:     	leaq	(%r10,%rax), %r8
1800018fe:     	xorq	%r8, %r10
180001901:     	movq	%r8, %r11
180001904:     	xorq	%rax, %r11
180001907:     	testq	%r11, %r10
18000190a:     	js	0x180001f85 <.text+0xf85>
180001910:     	xorps	%xmm1, %xmm1
180001913:     	cvtsi2sd	%r8, %xmm1
180001918:     	mulsd	%xmm0, %xmm1
18000191c:     	andpd	0x39ec(%rip), %xmm1     # 0x180005310
180001924:     	ucomisd	0x39f4(%rip), %xmm1     # 0x180005320
18000192c:     	jae	0x180001f85 <.text+0xf85>
180001932:     	imulq	%r9, %r8
180001936:     	leaq	(%r8,%rax), %r10
18000193a:     	xorq	%r10, %r8
18000193d:     	movq	%r10, %r11
180001940:     	xorq	%rax, %r11
180001943:     	testq	%r11, %r8
180001946:     	js	0x180001f85 <.text+0xf85>
18000194c:     	xorps	%xmm1, %xmm1
18000194f:     	cvtsi2sd	%r10, %xmm1
180001954:     	mulsd	%xmm0, %xmm1
180001958:     	andpd	0x39b0(%rip), %xmm1     # 0x180005310
180001960:     	ucomisd	0x39b8(%rip), %xmm1     # 0x180005320
180001968:     	jae	0x180001f85 <.text+0xf85>
18000196e:     	imulq	%r9, %r10
180001972:     	leaq	(%r10,%rax), %r8
180001976:     	xorq	%r8, %r10
180001979:     	movq	%r8, %r11
18000197c:     	xorq	%rax, %r11
18000197f:     	testq	%r11, %r10
180001982:     	js	0x180001f85 <.text+0xf85>
180001988:     	xorps	%xmm1, %xmm1
18000198b:     	cvtsi2sd	%r8, %xmm1
180001990:     	mulsd	%xmm0, %xmm1
180001994:     	andpd	0x3974(%rip), %xmm1     # 0x180005310
18000199c:     	ucomisd	0x397c(%rip), %xmm1     # 0x180005320
1800019a4:     	jae	0x180001f85 <.text+0xf85>
1800019aa:     	imulq	%r9, %r8
1800019ae:     	leaq	(%r8,%rax), %r10
1800019b2:     	xorq	%r10, %r8
1800019b5:     	movq	%r10, %r11
1800019b8:     	xorq	%rax, %r11
1800019bb:     	testq	%r11, %r8
1800019be:     	js	0x180001f85 <.text+0xf85>
1800019c4:     	xorps	%xmm1, %xmm1
1800019c7:     	cvtsi2sd	%r10, %xmm1
1800019cc:     	mulsd	%xmm0, %xmm1
1800019d0:     	andpd	0x3938(%rip), %xmm1     # 0x180005310
1800019d8:     	ucomisd	0x3940(%rip), %xmm1     # 0x180005320
1800019e0:     	jae	0x180001f85 <.text+0xf85>
1800019e6:     	imulq	%r9, %r10
1800019ea:     	leaq	(%r10,%rax), %r8
1800019ee:     	xorq	%r8, %r10
1800019f1:     	movq	%r8, %r11
1800019f4:     	xorq	%rax, %r11
1800019f7:     	testq	%r11, %r10
1800019fa:     	js	0x180001f85 <.text+0xf85>
180001a00:     	xorps	%xmm1, %xmm1
180001a03:     	cvtsi2sd	%r8, %xmm1
180001a08:     	mulsd	%xmm0, %xmm1
180001a0c:     	andpd	0x38fc(%rip), %xmm1     # 0x180005310
180001a14:     	ucomisd	0x3904(%rip), %xmm1     # 0x180005320
180001a1c:     	jae	0x180001f85 <.text+0xf85>
180001a22:     	imulq	%r9, %r8
180001a26:     	leaq	(%r8,%rax), %r10
180001a2a:     	xorq	%r10, %r8
180001a2d:     	movq	%r10, %r11
180001a30:     	xorq	%rax, %r11
180001a33:     	testq	%r11, %r8
180001a36:     	js	0x180001f85 <.text+0xf85>
180001a3c:     	xorps	%xmm1, %xmm1
180001a3f:     	cvtsi2sd	%r10, %xmm1
180001a44:     	mulsd	%xmm0, %xmm1
180001a48:     	andpd	0x38c0(%rip), %xmm1     # 0x180005310
180001a50:     	ucomisd	0x38c8(%rip), %xmm1     # 0x180005320
180001a58:     	jae	0x180001f85 <.text+0xf85>
180001a5e:     	imulq	%r9, %r10
180001a62:     	leaq	(%r10,%rax), %r8
180001a66:     	xorq	%r8, %r10
180001a69:     	movq	%r8, %r11
180001a6c:     	xorq	%rax, %r11
180001a6f:     	testq	%r11, %r10
180001a72:     	js	0x180001f85 <.text+0xf85>
180001a78:     	xorps	%xmm1, %xmm1
180001a7b:     	cvtsi2sd	%r8, %xmm1
180001a80:     	mulsd	%xmm0, %xmm1
180001a84:     	andpd	0x3884(%rip), %xmm1     # 0x180005310
180001a8c:     	ucomisd	0x388c(%rip), %xmm1     # 0x180005320
180001a94:     	jae	0x180001f85 <.text+0xf85>
180001a9a:     	imulq	%r9, %r8
180001a9e:     	leaq	(%r8,%rax), %r10
180001aa2:     	xorq	%r10, %r8
180001aa5:     	movq	%r10, %r11
180001aa8:     	xorq	%rax, %r11
180001aab:     	testq	%r11, %r8
180001aae:     	js	0x180001f85 <.text+0xf85>
180001ab4:     	xorps	%xmm1, %xmm1
180001ab7:     	cvtsi2sd	%r10, %xmm1
180001abc:     	mulsd	%xmm0, %xmm1
180001ac0:     	andpd	0x3848(%rip), %xmm1     # 0x180005310
180001ac8:     	ucomisd	0x3850(%rip), %xmm1     # 0x180005320
180001ad0:     	jae	0x180001f85 <.text+0xf85>
180001ad6:     	imulq	%r9, %r10
180001ada:     	leaq	(%r10,%rax), %r8
180001ade:     	xorq	%r8, %r10
180001ae1:     	movq	%r8, %r11
180001ae4:     	xorq	%rax, %r11
180001ae7:     	testq	%r11, %r10
180001aea:     	js	0x180001f85 <.text+0xf85>
180001af0:     	xorps	%xmm1, %xmm1
180001af3:     	cvtsi2sd	%r8, %xmm1
180001af8:     	mulsd	%xmm0, %xmm1
180001afc:     	andpd	0x380c(%rip), %xmm1     # 0x180005310
180001b04:     	ucomisd	0x3814(%rip), %xmm1     # 0x180005320
180001b0c:     	jae	0x180001f85 <.text+0xf85>
180001b12:     	imulq	%r9, %r8
180001b16:     	leaq	(%r8,%rax), %r10
180001b1a:     	xorq	%r10, %r8
180001b1d:     	movq	%r10, %r11
180001b20:     	xorq	%rax, %r11
180001b23:     	testq	%r11, %r8
180001b26:     	js	0x180001f85 <.text+0xf85>
180001b2c:     	xorps	%xmm1, %xmm1
180001b2f:     	cvtsi2sd	%r10, %xmm1
180001b34:     	mulsd	%xmm0, %xmm1
180001b38:     	andpd	0x37d0(%rip), %xmm1     # 0x180005310
180001b40:     	ucomisd	0x37d8(%rip), %xmm1     # 0x180005320
180001b48:     	jae	0x180001f85 <.text+0xf85>
180001b4e:     	imulq	%r9, %r10
180001b52:     	leaq	(%r10,%rax), %r8
180001b56:     	xorq	%r8, %r10
180001b59:     	movq	%r8, %r11
180001b5c:     	xorq	%rax, %r11
180001b5f:     	testq	%r11, %r10
180001b62:     	js	0x180001f85 <.text+0xf85>
180001b68:     	xorps	%xmm1, %xmm1
180001b6b:     	cvtsi2sd	%r8, %xmm1
180001b70:     	mulsd	%xmm0, %xmm1
180001b74:     	andpd	0x3794(%rip), %xmm1     # 0x180005310
180001b7c:     	ucomisd	0x379c(%rip), %xmm1     # 0x180005320
180001b84:     	jae	0x180001f85 <.text+0xf85>
180001b8a:     	imulq	%r9, %r8
180001b8e:     	leaq	(%r8,%rax), %r10
180001b92:     	xorq	%r10, %r8
180001b95:     	movq	%r10, %r11
180001b98:     	xorq	%rax, %r11
180001b9b:     	testq	%r11, %r8
180001b9e:     	js	0x180001f85 <.text+0xf85>
180001ba4:     	xorps	%xmm1, %xmm1
180001ba7:     	cvtsi2sd	%r10, %xmm1
180001bac:     	mulsd	%xmm0, %xmm1
180001bb0:     	andpd	0x3758(%rip), %xmm1     # 0x180005310
180001bb8:     	ucomisd	0x3760(%rip), %xmm1     # 0x180005320
180001bc0:     	jae	0x180001f85 <.text+0xf85>
180001bc6:     	imulq	%r9, %r10
180001bca:     	leaq	(%r10,%rax), %r8
180001bce:     	xorq	%r8, %r10
180001bd1:     	movq	%r8, %r11
180001bd4:     	xorq	%rax, %r11
180001bd7:     	testq	%r11, %r10
180001bda:     	js	0x180001f85 <.text+0xf85>
180001be0:     	xorps	%xmm1, %xmm1
180001be3:     	cvtsi2sd	%r8, %xmm1
180001be8:     	mulsd	%xmm0, %xmm1
180001bec:     	andpd	0x371c(%rip), %xmm1     # 0x180005310
180001bf4:     	ucomisd	0x3724(%rip), %xmm1     # 0x180005320
180001bfc:     	jae	0x180001f85 <.text+0xf85>
180001c02:     	imulq	%r9, %r8
180001c06:     	leaq	(%r8,%rax), %r10
180001c0a:     	xorq	%r10, %r8
180001c0d:     	movq	%r10, %r11
180001c10:     	xorq	%rax, %r11
180001c13:     	testq	%r11, %r8
180001c16:     	js	0x180001f85 <.text+0xf85>
180001c1c:     	xorps	%xmm1, %xmm1
180001c1f:     	cvtsi2sd	%r10, %xmm1
180001c24:     	mulsd	%xmm0, %xmm1
180001c28:     	andpd	0x36e0(%rip), %xmm1     # 0x180005310
180001c30:     	ucomisd	0x36e8(%rip), %xmm1     # 0x180005320
180001c38:     	jae	0x180001f85 <.text+0xf85>
180001c3e:     	imulq	%r9, %r10
180001c42:     	leaq	(%r10,%rax), %r8
180001c46:     	xorq	%r8, %r10
180001c49:     	movq	%r8, %r11
180001c4c:     	xorq	%rax, %r11
180001c4f:     	testq	%r11, %r10
180001c52:     	js	0x180001f85 <.text+0xf85>
180001c58:     	xorps	%xmm1, %xmm1
180001c5b:     	cvtsi2sd	%r8, %xmm1
180001c60:     	mulsd	%xmm0, %xmm1
180001c64:     	andpd	0x36a4(%rip), %xmm1     # 0x180005310
180001c6c:     	ucomisd	0x36ac(%rip), %xmm1     # 0x180005320
180001c74:     	jae	0x180001f85 <.text+0xf85>
180001c7a:     	imulq	%r9, %r8
180001c7e:     	leaq	(%r8,%rax), %r10
180001c82:     	xorq	%r10, %r8
180001c85:     	movq	%r10, %r11
180001c88:     	xorq	%rax, %r11
180001c8b:     	testq	%r11, %r8
180001c8e:     	js	0x180001f85 <.text+0xf85>
180001c94:     	xorps	%xmm1, %xmm1
180001c97:     	cvtsi2sd	%r10, %xmm1
180001c9c:     	mulsd	%xmm0, %xmm1
180001ca0:     	andpd	0x3668(%rip), %xmm1     # 0x180005310
180001ca8:     	ucomisd	0x3670(%rip), %xmm1     # 0x180005320
180001cb0:     	jae	0x180001f85 <.text+0xf85>
180001cb6:     	imulq	%r9, %r10
180001cba:     	leaq	(%r10,%rax), %r8
180001cbe:     	xorq	%r8, %r10
180001cc1:     	movq	%r8, %r11
180001cc4:     	xorq	%rax, %r11
180001cc7:     	testq	%r11, %r10
180001cca:     	js	0x180001f85 <.text+0xf85>
180001cd0:     	xorps	%xmm1, %xmm1
180001cd3:     	cvtsi2sd	%r8, %xmm1
180001cd8:     	mulsd	%xmm0, %xmm1
180001cdc:     	andpd	0x362c(%rip), %xmm1     # 0x180005310
180001ce4:     	ucomisd	0x3634(%rip), %xmm1     # 0x180005320
180001cec:     	jae	0x180001f85 <.text+0xf85>
180001cf2:     	imulq	%r9, %r8
180001cf6:     	leaq	(%r8,%rax), %r10
180001cfa:     	xorq	%r10, %r8
180001cfd:     	movq	%r10, %r11
180001d00:     	xorq	%rax, %r11
180001d03:     	testq	%r11, %r8
180001d06:     	js	0x180001f85 <.text+0xf85>
180001d0c:     	xorps	%xmm1, %xmm1
180001d0f:     	cvtsi2sd	%r10, %xmm1
180001d14:     	mulsd	%xmm0, %xmm1
180001d18:     	andpd	0x35f0(%rip), %xmm1     # 0x180005310
180001d20:     	ucomisd	0x35f8(%rip), %xmm1     # 0x180005320
180001d28:     	jae	0x180001f85 <.text+0xf85>
180001d2e:     	imulq	%r9, %r10
180001d32:     	leaq	(%r10,%rax), %r8
180001d36:     	xorq	%r8, %r10
180001d39:     	movq	%r8, %r11
180001d3c:     	xorq	%rax, %r11
180001d3f:     	testq	%r11, %r10
180001d42:     	js	0x180001f85 <.text+0xf85>
180001d48:     	xorps	%xmm1, %xmm1
180001d4b:     	cvtsi2sd	%r8, %xmm1
180001d50:     	mulsd	%xmm0, %xmm1
180001d54:     	andpd	0x35b4(%rip), %xmm1     # 0x180005310
180001d5c:     	ucomisd	0x35bc(%rip), %xmm1     # 0x180005320
180001d64:     	jae	0x180001f85 <.text+0xf85>
180001d6a:     	imulq	%r9, %r8
180001d6e:     	leaq	(%r8,%rax), %r10
180001d72:     	xorq	%r10, %r8
180001d75:     	movq	%r10, %r11
180001d78:     	xorq	%rax, %r11
180001d7b:     	testq	%r11, %r8
180001d7e:     	js	0x180001f85 <.text+0xf85>
180001d84:     	xorps	%xmm1, %xmm1
180001d87:     	cvtsi2sd	%r10, %xmm1
180001d8c:     	mulsd	%xmm0, %xmm1
180001d90:     	andpd	0x3578(%rip), %xmm1     # 0x180005310
180001d98:     	ucomisd	0x3580(%rip), %xmm1     # 0x180005320
180001da0:     	jae	0x180001f85 <.text+0xf85>
180001da6:     	imulq	%r9, %r10
180001daa:     	leaq	(%r10,%rax), %r8
180001dae:     	xorq	%r8, %r10
180001db1:     	movq	%r8, %r11
180001db4:     	xorq	%rax, %r11
180001db7:     	testq	%r11, %r10
180001dba:     	js	0x180001f85 <.text+0xf85>
180001dc0:     	xorps	%xmm1, %xmm1
180001dc3:     	cvtsi2sd	%r8, %xmm1
180001dc8:     	mulsd	%xmm0, %xmm1
180001dcc:     	andpd	0x353c(%rip), %xmm1     # 0x180005310
180001dd4:     	ucomisd	0x3544(%rip), %xmm1     # 0x180005320
180001ddc:     	jae	0x180001f85 <.text+0xf85>
180001de2:     	imulq	%r9, %r8
180001de6:     	leaq	(%r8,%rax), %r10
180001dea:     	xorq	%r10, %r8
180001ded:     	movq	%r10, %r11
180001df0:     	xorq	%rax, %r11
180001df3:     	testq	%r11, %r8
180001df6:     	js	0x180001f85 <.text+0xf85>
180001dfc:     	xorps	%xmm1, %xmm1
180001dff:     	cvtsi2sd	%r10, %xmm1
180001e04:     	mulsd	%xmm0, %xmm1
180001e08:     	andpd	0x3500(%rip), %xmm1     # 0x180005310
180001e10:     	ucomisd	0x3508(%rip), %xmm1     # 0x180005320
180001e18:     	jae	0x180001f85 <.text+0xf85>
180001e1e:     	imulq	%r9, %r10
180001e22:     	leaq	(%r10,%rax), %r8
180001e26:     	xorq	%r8, %r10
180001e29:     	movq	%r8, %r11
180001e2c:     	xorq	%rax, %r11
180001e2f:     	testq	%r11, %r10
180001e32:     	js	0x180001f85 <.text+0xf85>
180001e38:     	xorps	%xmm1, %xmm1
180001e3b:     	cvtsi2sd	%r8, %xmm1
180001e40:     	mulsd	%xmm0, %xmm1
180001e44:     	andpd	0x34c4(%rip), %xmm1     # 0x180005310
180001e4c:     	ucomisd	0x34cc(%rip), %xmm1     # 0x180005320
180001e54:     	jae	0x180001f85 <.text+0xf85>
180001e5a:     	imulq	%r9, %r8
180001e5e:     	leaq	(%r8,%rax), %r10
180001e62:     	xorq	%r10, %r8
180001e65:     	movq	%r10, %r11
180001e68:     	xorq	%rax, %r11
180001e6b:     	testq	%r11, %r8
180001e6e:     	js	0x180001f85 <.text+0xf85>
180001e74:     	xorps	%xmm1, %xmm1
180001e77:     	cvtsi2sd	%r10, %xmm1
180001e7c:     	mulsd	%xmm0, %xmm1
180001e80:     	andpd	0x3488(%rip), %xmm1     # 0x180005310
180001e88:     	ucomisd	0x3490(%rip), %xmm1     # 0x180005320
180001e90:     	jae	0x180001f85 <.text+0xf85>
180001e96:     	imulq	%r9, %r10
180001e9a:     	leaq	(%r10,%rax), %r8
180001e9e:     	xorq	%r8, %r10
180001ea1:     	movq	%r8, %r11
180001ea4:     	xorq	%rax, %r11
180001ea7:     	testq	%r11, %r10
180001eaa:     	js	0x180001f85 <.text+0xf85>
180001eb0:     	xorps	%xmm1, %xmm1
180001eb3:     	cvtsi2sd	%r8, %xmm1
180001eb8:     	mulsd	%xmm0, %xmm1
180001ebc:     	andpd	0x344c(%rip), %xmm1     # 0x180005310
180001ec4:     	ucomisd	0x3454(%rip), %xmm1     # 0x180005320
180001ecc:     	jae	0x180001f85 <.text+0xf85>
180001ed2:     	imulq	%r9, %r8
180001ed6:     	leaq	(%r8,%rax), %r10
180001eda:     	xorq	%r10, %r8
180001edd:     	movq	%r10, %r11
180001ee0:     	xorq	%rax, %r11
180001ee3:     	testq	%r11, %r8
180001ee6:     	js	0x180001f85 <.text+0xf85>
180001eec:     	xorps	%xmm1, %xmm1
180001eef:     	cvtsi2sd	%r10, %xmm1
180001ef4:     	mulsd	%xmm0, %xmm1
180001ef8:     	andpd	0x3410(%rip), %xmm1     # 0x180005310
180001f00:     	ucomisd	0x3418(%rip), %xmm1     # 0x180005320
180001f08:     	jae	0x180001f85 <.text+0xf85>
180001f0a:     	imulq	%r9, %r10
180001f0e:     	leaq	(%r10,%rax), %r8
180001f12:     	xorq	%r8, %r10
180001f15:     	movq	%r8, %r11
180001f18:     	xorq	%rax, %r11
180001f1b:     	testq	%r11, %r10
180001f1e:     	js	0x180001f85 <.text+0xf85>
180001f20:     	xorps	%xmm1, %xmm1
180001f23:     	cvtsi2sd	%r8, %xmm1
180001f28:     	mulsd	%xmm0, %xmm1
180001f2c:     	andpd	0x33dc(%rip), %xmm1     # 0x180005310
180001f34:     	ucomisd	0x33e4(%rip), %xmm1     # 0x180005320
180001f3c:     	jae	0x180001f85 <.text+0xf85>
180001f3e:     	imulq	%r9, %r8
180001f42:     	leaq	(%r8,%rax), %r10
180001f46:     	xorq	%r10, %r8
180001f49:     	movq	%r10, %r11
180001f4c:     	xorq	%rax, %r11
180001f4f:     	testq	%r11, %r8
180001f52:     	js	0x180001f85 <.text+0xf85>
180001f54:     	xorps	%xmm1, %xmm1
180001f57:     	cvtsi2sd	%r10, %xmm1
180001f5c:     	mulsd	%xmm1, %xmm0
180001f60:     	andpd	0x33a8(%rip), %xmm0     # 0x180005310
180001f68:     	ucomisd	0x33b0(%rip), %xmm0     # 0x180005320
180001f70:     	jae	0x180001f85 <.text+0xf85>
180001f72:     	imulq	%r9, %r10
180001f76:     	leaq	(%r10,%rax), %r8
180001f7a:     	xorq	%r8, %r10
180001f7d:     	xorq	%r8, %rax
180001f80:     	testq	%rax, %r10
180001f83:     	jns	0x180001f8b <.text+0xf8b>
180001f85:     	movb	$0x1, (%rdx)
180001f88:     	xorl	%r8d, %r8d
180001f8b:     	movq	%r8, (%rcx)
180001f8e:     	retq
180001f8f:     	nop
180001f90:     	pushq	%r15
180001f92:     	pushq	%r14
180001f94:     	pushq	%r13
180001f96:     	pushq	%r12
180001f98:     	pushq	%rsi
180001f99:     	pushq	%rdi
180001f9a:     	pushq	%rbp
180001f9b:     	pushq	%rbx
180001f9c:     	subq	$0x198, %rsp            # imm = 0x198
180001fa3:     	movq	%rdx, %rcx
180001fa6:     	leaq	0x68(%rsp), %rax
180001fab:     	movq	%rax, 0x50(%rsp)
180001fb0:     	leaq	0x70(%rsp), %rax
180001fb5:     	movq	%rax, 0x48(%rsp)
180001fba:     	leaq	0x78(%rsp), %rax
180001fbf:     	movq	%rax, 0x40(%rsp)
180001fc4:     	leaq	0x80(%rsp), %rax
180001fcc:     	movq	%rax, 0x38(%rsp)
180001fd1:     	leaq	0x88(%rsp), %rax
180001fd9:     	movq	%rax, 0x30(%rsp)
180001fde:     	leaq	0x90(%rsp), %rax
180001fe6:     	movq	%rax, 0x28(%rsp)
180001feb:     	leaq	0x98(%rsp), %rax
180001ff3:     	movq	%rax, 0x20(%rsp)
180001ff8:     	leaq	0x33f1(%rip), %rdx      # 0x1800053f0
180001fff:     	movl	$0x7, %r8d
180002005:     	movl	$0x7, %r9d
18000200b:     	callq	0x180003e91 <numba_list_iter_next+0x2f1>
180002010:     	testl	%eax, %eax
180002012:     	movq	$0x0, 0x60(%rsp)
18000201b:     	je	0x18000237c <.text+0x137c>
180002021:     	cmpq	$0x0, 0x9c37(%rip)      # 0x18000bc60
180002029:     	je	0x1800022ac <.text+0x12ac>
18000202f:     	movq	0x98(%rsp), %rcx
180002037:     	xorps	%xmm0, %xmm0
18000203a:     	movaps	%xmm0, 0x160(%rsp)
180002042:     	movaps	%xmm0, 0x170(%rsp)
18000204a:     	movaps	%xmm0, 0x180(%rsp)
180002052:     	movq	$0x0, 0x190(%rsp)
18000205e:     	leaq	0x160(%rsp), %rdx
180002066:     	callq	0x180002b70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7a0>
18000206b:     	testl	%eax, %eax
18000206d:     	jne	0x1800022c4 <.text+0x12c4>
180002073:     	cmpq	$0x8, 0x178(%rsp)
18000207c:     	jne	0x1800022c4 <.text+0x12c4>
180002082:     	movq	0x160(%rsp), %rsi
18000208a:     	movq	0x90(%rsp), %rcx
180002092:     	xorps	%xmm0, %xmm0
180002095:     	movaps	%xmm0, 0x120(%rsp)
18000209d:     	movaps	%xmm0, 0x130(%rsp)
1800020a5:     	movaps	%xmm0, 0x140(%rsp)
1800020ad:     	movq	$0x0, 0x150(%rsp)
1800020b9:     	leaq	0x120(%rsp), %rdx
1800020c1:     	callq	0x180002b70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7a0>
1800020c6:     	testl	%eax, %eax
1800020c8:     	jne	0x1800022dc <.text+0x12dc>
1800020ce:     	cmpq	$0x8, 0x138(%rsp)
1800020d7:     	jne	0x1800022dc <.text+0x12dc>
1800020dd:     	movq	0x120(%rsp), %rbx
1800020e5:     	movq	0x88(%rsp), %rcx
1800020ed:     	xorps	%xmm0, %xmm0
1800020f0:     	movaps	%xmm0, 0xe0(%rsp)
1800020f8:     	movaps	%xmm0, 0xf0(%rsp)
180002100:     	movaps	%xmm0, 0x100(%rsp)
180002108:     	movq	$0x0, 0x110(%rsp)
180002114:     	leaq	0xe0(%rsp), %rdx
18000211c:     	callq	0x180002b70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7a0>
180002121:     	testl	%eax, %eax
180002123:     	jne	0x1800022f4 <.text+0x12f4>
180002129:     	cmpq	$0x8, 0xf8(%rsp)
180002132:     	jne	0x1800022f4 <.text+0x12f4>
180002138:     	movq	0xe0(%rsp), %r14
180002140:     	movq	0x80(%rsp), %rcx
180002148:     	xorps	%xmm0, %xmm0
18000214b:     	movaps	%xmm0, 0xa0(%rsp)
180002153:     	movaps	%xmm0, 0xb0(%rsp)
18000215b:     	movaps	%xmm0, 0xc0(%rsp)
180002163:     	movq	$0x0, 0xd0(%rsp)
18000216f:     	leaq	0xa0(%rsp), %rdx
180002177:     	callq	0x180002b70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7a0>
18000217c:     	testl	%eax, %eax
18000217e:     	jne	0x180002309 <.text+0x1309>
180002184:     	cmpq	$0x1, 0xb8(%rsp)
18000218d:     	jne	0x180002309 <.text+0x1309>
180002193:     	movq	0xa0(%rsp), %rdi
18000219b:     	movq	0xc0(%rsp), %r15
1800021a3:     	movq	0x78(%rsp), %rcx
1800021a8:     	callq	0x180003e97 <numba_list_iter_next+0x2f7>
1800021ad:     	testq	%rax, %rax
1800021b0:     	movq	%rdi, 0x58(%rsp)
1800021b5:     	je	0x18000231e <.text+0x131e>
1800021bb:     	movq	%rax, %r13
1800021be:     	movq	%rsi, %rdi
1800021c1:     	movq	%rax, %rcx
1800021c4:     	callq	0x180003e9d <numba_list_iter_next+0x2fd>
1800021c9:     	movq	%rax, %r12
1800021cc:     	movq	%r13, %rcx
1800021cf:     	callq	0x180003ea3 <numba_list_iter_next+0x303>
1800021d4:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
1800021d9:     	testq	%rax, %rax
1800021dc:     	jne	0x180002357 <.text+0x1357>
1800021e2:     	movq	0x70(%rsp), %rcx
1800021e7:     	callq	0x180003e97 <numba_list_iter_next+0x2f7>
1800021ec:     	testq	%rax, %rax
1800021ef:     	je	0x180002334 <.text+0x1334>
1800021f5:     	movq	%rax, %rbp
1800021f8:     	movq	%rax, %rcx
1800021fb:     	callq	0x180003e9d <numba_list_iter_next+0x2fd>
180002200:     	movq	%rax, %r13
180002203:     	movq	%rbp, %rcx
180002206:     	callq	0x180003ea3 <numba_list_iter_next+0x303>
18000220b:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
180002210:     	testq	%rax, %rax
180002213:     	jne	0x180002357 <.text+0x1357>
180002219:     	movq	0x68(%rsp), %rcx
18000221e:     	callq	0x180003e97 <numba_list_iter_next+0x2f7>
180002223:     	testq	%rax, %rax
180002226:     	je	0x180002347 <.text+0x1347>
18000222c:     	movq	%rax, %rsi
18000222f:     	movq	%rax, %rcx
180002232:     	callq	0x180003e9d <numba_list_iter_next+0x2fd>
180002237:     	movq	%rax, %rbp
18000223a:     	movq	%rsi, %rcx
18000223d:     	callq	0x180003ea3 <numba_list_iter_next+0x303>
180002242:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
180002247:     	testq	%rax, %rax
18000224a:     	jne	0x180002357 <.text+0x1357>
180002250:     	movq	%rbp, 0x20(%rsp)
180002255:     	leaq	0x60(%rsp), %rcx
18000225a:     	movq	%r15, %rdx
18000225d:     	movq	%r12, %r8
180002260:     	movq	%r13, %r9
180002263:     	callq	0x180001090 <.text+0x90>
180002268:     	movq	0x60(%rsp), %rsi
18000226d:     	movq	%rdi, %rcx
180002270:     	callq	0x180001060 <.text+0x60>
180002275:     	movq	%rbx, %rcx
180002278:     	callq	0x180001060 <.text+0x60>
18000227d:     	movq	%r14, %rcx
180002280:     	callq	0x180001060 <.text+0x60>
180002285:     	movq	0x58(%rsp), %rcx
18000228a:     	callq	0x180001060 <.text+0x60>
18000228f:     	movq	%rsi, %rcx
180002292:     	callq	0x180003eaf <numba_list_iter_next+0x30f>
180002297:     	nop
180002298:     	addq	$0x198, %rsp            # imm = 0x198
18000229f:     	popq	%rbx
1800022a0:     	popq	%rbp
1800022a1:     	popq	%rdi
1800022a2:     	popq	%rsi
1800022a3:     	popq	%r12
1800022a5:     	popq	%r13
1800022a7:     	popq	%r14
1800022a9:     	popq	%r15
1800022ab:     	retq
1800022ac:     	movq	0x2f85(%rip), %rcx      # 0x180005238
1800022b3:     	leaq	0x3156(%rip), %rdx      # 0x180005410
1800022ba:     	callq	0x180003eb5 <numba_list_iter_next+0x315>
1800022bf:     	jmp	0x18000237c <.text+0x137c>
1800022c4:     	movq	0x2f5d(%rip), %rcx      # 0x180005228
1800022cb:     	leaq	0x323e(%rip), %rdx      # 0x180005510
1800022d2:     	callq	0x180003eb5 <numba_list_iter_next+0x315>
1800022d7:     	jmp	0x18000237c <.text+0x137c>
1800022dc:     	movq	0x2f45(%rip), %rcx      # 0x180005228
1800022e3:     	leaq	0x3226(%rip), %rdx      # 0x180005510
1800022ea:     	callq	0x180003eb5 <numba_list_iter_next+0x315>
1800022ef:     	jmp	0x180002374 <.text+0x1374>
1800022f4:     	movq	0x2f2d(%rip), %rcx      # 0x180005228
1800022fb:     	leaq	0x320e(%rip), %rdx      # 0x180005510
180002302:     	callq	0x180003eb5 <numba_list_iter_next+0x315>
180002307:     	jmp	0x18000236c <.text+0x136c>
180002309:     	movq	0x2f18(%rip), %rcx      # 0x180005228
180002310:     	leaq	0x31f9(%rip), %rdx      # 0x180005510
180002317:     	callq	0x180003eb5 <numba_list_iter_next+0x315>
18000231c:     	jmp	0x180002364 <.text+0x1364>
18000231e:     	movq	%rsi, %rdi
180002321:     	xorl	%r12d, %r12d
180002324:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
180002329:     	testq	%rax, %rax
18000232c:     	je	0x1800021e2 <.text+0x11e2>
180002332:     	jmp	0x180002357 <.text+0x1357>
180002334:     	xorl	%r13d, %r13d
180002337:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
18000233c:     	testq	%rax, %rax
18000233f:     	je	0x180002219 <.text+0x1219>
180002345:     	jmp	0x180002357 <.text+0x1357>
180002347:     	xorl	%ebp, %ebp
180002349:     	callq	0x180003ea9 <numba_list_iter_next+0x309>
18000234e:     	testq	%rax, %rax
180002351:     	je	0x180002250 <.text+0x1250>
180002357:     	movq	0x58(%rsp), %rcx
18000235c:     	callq	0x180001060 <.text+0x60>
180002361:     	movq	%rdi, %rsi
180002364:     	movq	%r14, %rcx
180002367:     	callq	0x180001060 <.text+0x60>
18000236c:     	movq	%rbx, %rcx
18000236f:     	callq	0x180001060 <.text+0x60>
180002374:     	movq	%rsi, %rcx
180002377:     	callq	0x180001060 <.text+0x60>
18000237c:     	xorl	%eax, %eax
18000237e:     	jmp	0x180002298 <.text+0x1298>
180002383:     	nopw	%cs:(%rax,%rax)
18000238d:     	nopl	(%rax)
180002390:     	subq	$0x38, %rsp
180002394:     	movq	0x108(%rsp), %rdx
18000239c:     	movq	0x120(%rsp), %r8
1800023a4:     	movq	0x128(%rsp), %r9
1800023ac:     	movq	0x130(%rsp), %rax
1800023b4:     	movq	%rax, 0x20(%rsp)
1800023b9:     	leaq	0x30(%rsp), %rcx
1800023be:     	callq	0x180001090 <.text+0x90>
1800023c3:     	movq	0x30(%rsp), %rax
1800023c8:     	addq	$0x38, %rsp
1800023cc:     	retq
1800023cd:     	nopl	(%rax)

00000001800023d0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8>:
1800023d0:     	pushq	%rsi
1800023d1:     	subq	$0x20, %rsp
1800023d5:     	leaq	0x8c64(%rip), %rcx      # 0x18000b040
1800023dc:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800023e1:     	callq	0x180003ebb <numba_list_iter_next+0x31b>
1800023e6:     	testq	%rax, %rax
1800023e9:     	je	0x18000241b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x4b>
1800023eb:     	leaq	0x8c0e(%rip), %rdx      # 0x18000b000
1800023f2:     	leaq	0x31c7(%rip), %r8       # 0x1800055c0
1800023f9:     	leaq	0x31e8(%rip), %r9       # 0x1800055e8
180002400:     	movq	%rax, %rcx
180002403:     	movq	%rax, %rsi
180002406:     	callq	0x180002de0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xa10>
18000240b:     	movl	%eax, %ecx
18000240d:     	xorl	%eax, %eax
18000240f:     	testl	%ecx, %ecx
180002411:     	cmoveq	%rsi, %rax
180002415:     	addq	$0x20, %rsp
180002419:     	popq	%rsi
18000241a:     	retq
18000241b:     	xorl	%eax, %eax
18000241d:     	addq	$0x20, %rsp
180002421:     	popq	%rsi
180002422:     	retq
180002423:     	int3
180002424:     	int3
180002425:     	int3
180002426:     	int3
180002427:     	int3
180002428:     	int3
180002429:     	int3
18000242a:     	int3
18000242b:     	int3
18000242c:     	int3
18000242d:     	int3
18000242e:     	int3
18000242f:     	int3
180002430:     	movq	%rbx, 0x8(%rsp)
180002435:     	movq	%rsi, 0x10(%rsp)
18000243a:     	pushq	%rdi
18000243b:     	subq	$0x20, %rsp
18000243f:     	movq	%rcx, %rbx
180002442:     	movq	%r8, %rdi
180002445:     	movq	0x10(%rcx), %rcx
180002449:     	movq	%rdx, %rsi
18000244c:     	testq	%rcx, %rcx
18000244f:     	je	0x18000245a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x8a>
180002451:     	movq	%r8, %rdx
180002454:     	callq	*%rsi
180002456:     	testl	%eax, %eax
180002458:     	jne	0x18000247d <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xad>
18000245a:     	movq	0x18(%rbx), %rcx
18000245e:     	testq	%rcx, %rcx
180002461:     	je	0x18000247b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xab>
180002463:     	movq	%rdi, %rdx
180002466:     	movq	%rsi, %rax
180002469:     	movq	0x30(%rsp), %rbx
18000246e:     	movq	0x38(%rsp), %rsi
180002473:     	addq	$0x20, %rsp
180002477:     	popq	%rdi
180002478:     	jmpq	*%rax
18000247b:     	xorl	%eax, %eax
18000247d:     	movq	0x30(%rsp), %rbx
180002482:     	movq	0x38(%rsp), %rsi
180002487:     	addq	$0x20, %rsp
18000248b:     	popq	%rdi
18000248c:     	retq
18000248d:     	int3
18000248e:     	int3
18000248f:     	int3
180002490:     	pushq	%rbx
180002492:     	subq	$0x20, %rsp
180002496:     	movq	%rcx, %rbx
180002499:     	movq	0x10(%rcx), %rcx
18000249d:     	testq	%rcx, %rcx
1800024a0:     	je	0x1800024bd <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xed>
1800024a2:     	movq	$0x0, 0x10(%rbx)
1800024aa:     	movl	(%rcx), %eax
1800024ac:     	testl	%eax, %eax
1800024ae:     	js	0x1800024bd <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xed>
1800024b0:     	subl	$0x1, %eax
1800024b3:     	movl	%eax, (%rcx)
1800024b5:     	jne	0x1800024bd <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xed>
1800024b7:     	callq	*0x2cf3(%rip)           # 0x1800051b0
1800024bd:     	movq	0x18(%rbx), %rcx
1800024c1:     	testq	%rcx, %rcx
1800024c4:     	je	0x1800024e1 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x111>
1800024c6:     	movq	$0x0, 0x18(%rbx)
1800024ce:     	movl	(%rcx), %eax
1800024d0:     	testl	%eax, %eax
1800024d2:     	js	0x1800024e1 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x111>
1800024d4:     	subl	$0x1, %eax
1800024d7:     	movl	%eax, (%rcx)
1800024d9:     	jne	0x1800024e1 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x111>
1800024db:     	callq	*0x2ccf(%rip)           # 0x1800051b0
1800024e1:     	xorl	%eax, %eax
1800024e3:     	addq	$0x20, %rsp
1800024e7:     	popq	%rbx
1800024e8:     	retq
1800024e9:     	int3
1800024ea:     	int3
1800024eb:     	int3
1800024ec:     	int3
1800024ed:     	int3
1800024ee:     	int3
1800024ef:     	int3
1800024f0:     	pushq	%rbx
1800024f2:     	subq	$0x20, %rsp
1800024f6:     	movq	%rcx, %rbx
1800024f9:     	callq	*0x2cf1(%rip)           # 0x1800051f0
1800024ff:     	movq	0x10(%rbx), %rcx
180002503:     	testq	%rcx, %rcx
180002506:     	je	0x180002523 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x153>
180002508:     	movq	$0x0, 0x10(%rbx)
180002510:     	movl	(%rcx), %eax
180002512:     	testl	%eax, %eax
180002514:     	js	0x180002523 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x153>
180002516:     	subl	$0x1, %eax
180002519:     	movl	%eax, (%rcx)
18000251b:     	jne	0x180002523 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x153>
18000251d:     	callq	*0x2c8d(%rip)           # 0x1800051b0
180002523:     	movq	0x18(%rbx), %rcx
180002527:     	testq	%rcx, %rcx
18000252a:     	je	0x180002547 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x177>
18000252c:     	movq	$0x0, 0x18(%rbx)
180002534:     	movl	(%rcx), %eax
180002536:     	testl	%eax, %eax
180002538:     	js	0x180002547 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x177>
18000253a:     	subl	$0x1, %eax
18000253d:     	movl	%eax, (%rcx)
18000253f:     	jne	0x180002547 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x177>
180002541:     	callq	*0x2c69(%rip)           # 0x1800051b0
180002547:     	movq	0x8(%rbx), %rax
18000254b:     	movq	%rbx, %rcx
18000254e:     	addq	$0x20, %rsp
180002552:     	popq	%rbx
180002553:     	jmpq	*0x140(%rax)
18000255a:     	int3
18000255b:     	int3
18000255c:     	int3
18000255d:     	int3
18000255e:     	int3
18000255f:     	int3
180002560:     	pushq	%rbx
180002562:     	subq	$0x30, %rsp
180002566:     	movq	%r8, %r10
180002569:     	leaq	0x58(%rsp), %rax
18000256e:     	movq	%rax, 0x28(%rsp)
180002573:     	leaq	0x9416(%rip), %r9       # 0x18000b990
18000257a:     	movq	0x2c3f(%rip), %rax      # 0x1800051c0
180002581:     	leaq	0x33a0(%rip), %r8       # 0x180005928
180002588:     	movq	%rdx, %r11
18000258b:     	movq	%rax, 0x20(%rsp)
180002590:     	movq	%rcx, %rbx
180002593:     	movq	%r10, %rdx
180002596:     	movq	%r11, %rcx
180002599:     	callq	*0x2b41(%rip)           # 0x1800050e0
18000259f:     	testl	%eax, %eax
1800025a1:     	je	0x1800025fc <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x22c>
1800025a3:     	xorl	%r8d, %r8d
1800025a6:     	xorl	%edx, %edx
1800025a8:     	movq	%rbx, %rcx
1800025ab:     	callq	*0x2c5f(%rip)           # 0x180005210
1800025b1:     	movq	%rax, %rbx
1800025b4:     	testq	%rax, %rax
1800025b7:     	je	0x1800025fc <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x22c>
1800025b9:     	movq	0x58(%rsp), %rax
1800025be:     	movl	(%rax), %ecx
1800025c0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800025c6:     	jae	0x1800025d1 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x201>
1800025c8:     	incl	%ecx
1800025ca:     	movl	%ecx, (%rax)
1800025cc:     	movq	0x58(%rsp), %rax
1800025d1:     	xorl	%ecx, %ecx
1800025d3:     	movq	%rax, 0x10(%rbx)
1800025d7:     	callq	*0x2b93(%rip)           # 0x180005170
1800025dd:     	movq	%rax, 0x18(%rbx)
1800025e1:     	testq	%rax, %rax
1800025e4:     	jne	0x180002604 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x234>
1800025e6:     	movl	(%rbx), %eax
1800025e8:     	testl	%eax, %eax
1800025ea:     	js	0x1800025fc <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x22c>
1800025ec:     	subl	$0x1, %eax
1800025ef:     	movl	%eax, (%rbx)
1800025f1:     	jne	0x1800025fc <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x22c>
1800025f3:     	movq	%rbx, %rcx
1800025f6:     	callq	*0x2bb4(%rip)           # 0x1800051b0
1800025fc:     	xorl	%eax, %eax
1800025fe:     	addq	$0x30, %rsp
180002602:     	popq	%rbx
180002603:     	retq
180002604:     	movq	%rbx, %rax
180002607:     	addq	$0x30, %rsp
18000260b:     	popq	%rbx
18000260c:     	retq
18000260d:     	int3
18000260e:     	int3
18000260f:     	int3
180002610:     	movq	%rbx, 0x8(%rsp)
180002615:     	movq	%rsi, 0x10(%rsp)
18000261a:     	pushq	%rdi
18000261b:     	subq	$0x20, %rsp
18000261f:     	movq	%rcx, %rbx
180002622:     	movq	%r8, %rdi
180002625:     	movq	0x18(%rcx), %rcx
180002629:     	movq	%rdx, %rsi
18000262c:     	testq	%rcx, %rcx
18000262f:     	je	0x18000263a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x26a>
180002631:     	movq	%r8, %rdx
180002634:     	callq	*%rsi
180002636:     	testl	%eax, %eax
180002638:     	jne	0x18000265d <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x28d>
18000263a:     	movq	0x40(%rbx), %rcx
18000263e:     	testq	%rcx, %rcx
180002641:     	je	0x18000265b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x28b>
180002643:     	movq	%rdi, %rdx
180002646:     	movq	%rsi, %rax
180002649:     	movq	0x30(%rsp), %rbx
18000264e:     	movq	0x38(%rsp), %rsi
180002653:     	addq	$0x20, %rsp
180002657:     	popq	%rdi
180002658:     	jmpq	*%rax
18000265b:     	xorl	%eax, %eax
18000265d:     	movq	0x30(%rsp), %rbx
180002662:     	movq	0x38(%rsp), %rsi
180002667:     	addq	$0x20, %rsp
18000266b:     	popq	%rdi
18000266c:     	retq
18000266d:     	int3
18000266e:     	int3
18000266f:     	int3
180002670:     	pushq	%rbx
180002672:     	subq	$0x20, %rsp
180002676:     	movq	%rcx, %rbx
180002679:     	callq	*0x2b71(%rip)           # 0x1800051f0
18000267f:     	cmpq	$0x0, 0x48(%rbx)
180002684:     	je	0x18000268f <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x2bf>
180002686:     	movq	%rbx, %rcx
180002689:     	callq	*0x2af1(%rip)           # 0x180005180
18000268f:     	movq	0x20(%rbx), %rcx
180002693:     	callq	*0x2b07(%rip)           # 0x1800051a0
180002699:     	movq	0x38(%rbx), %rcx
18000269d:     	callq	*0x2afd(%rip)           # 0x1800051a0
1800026a3:     	movq	0x18(%rbx), %rcx
1800026a7:     	testq	%rcx, %rcx
1800026aa:     	je	0x1800026bf <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x2ef>
1800026ac:     	movl	(%rcx), %eax
1800026ae:     	testl	%eax, %eax
1800026b0:     	js	0x1800026bf <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x2ef>
1800026b2:     	subl	$0x1, %eax
1800026b5:     	movl	%eax, (%rcx)
1800026b7:     	jne	0x1800026bf <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x2ef>
1800026b9:     	callq	*0x2af1(%rip)           # 0x1800051b0
1800026bf:     	movq	0x40(%rbx), %rcx
1800026c3:     	testq	%rcx, %rcx
1800026c6:     	je	0x1800026db <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x30b>
1800026c8:     	movl	(%rcx), %eax
1800026ca:     	testl	%eax, %eax
1800026cc:     	js	0x1800026db <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x30b>
1800026ce:     	subl	$0x1, %eax
1800026d1:     	movl	%eax, (%rcx)
1800026d3:     	jne	0x1800026db <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x30b>
1800026d5:     	callq	*0x2ad5(%rip)           # 0x1800051b0
1800026db:     	movq	0x8(%rbx), %rax
1800026df:     	movq	%rbx, %rcx
1800026e2:     	addq	$0x20, %rsp
1800026e6:     	popq	%rbx
1800026e7:     	jmpq	*0x140(%rax)
1800026ee:     	int3
1800026ef:     	int3
1800026f0:     	pushq	%rbx
1800026f2:     	subq	$0x20, %rsp
1800026f6:     	callq	*0x2a7c(%rip)           # 0x180005178
1800026fc:     	movq	%rax, %rbx
1800026ff:     	testq	%rax, %rax
180002702:     	jne	0x18000270a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x33a>
180002704:     	addq	$0x20, %rsp
180002708:     	popq	%rbx
180002709:     	retq
18000270a:     	movq	%rbx, %rcx
18000270d:     	movq	%rdi, 0x30(%rsp)
180002712:     	callq	0x180004a25 <numba_list_iter_next+0xe85>
180002717:     	leaq	0x1(%rax), %rcx
18000271b:     	callq	*0x2af7(%rip)           # 0x180005218
180002721:     	movq	%rax, %rdi
180002724:     	testq	%rax, %rax
180002727:     	jne	0x18000273c <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x36c>
180002729:     	callq	*0x2a09(%rip)           # 0x180005138
18000272f:     	movq	0x30(%rsp), %rdi
180002734:     	xorl	%eax, %eax
180002736:     	addq	$0x20, %rsp
18000273a:     	popq	%rbx
18000273b:     	retq
18000273c:     	movq	%rbx, %rdx
18000273f:     	movq	%rdi, %rcx
180002742:     	callq	0x180004a1f <numba_list_iter_next+0xe7f>
180002747:     	movq	%rdi, %rax
18000274a:     	movq	0x30(%rsp), %rdi
18000274f:     	addq	$0x20, %rsp
180002753:     	popq	%rbx
180002754:     	retq
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
180002760:     	movq	0x18(%rcx), %rcx
180002764:     	movq	%rdx, %rax
180002767:     	testq	%rcx, %rcx
18000276a:     	je	0x180002772 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x3a2>
18000276c:     	movq	%r8, %rdx
18000276f:     	jmpq	*%rax
180002772:     	xorl	%eax, %eax
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
180002780:     	movq	%rbx, 0x8(%rsp)
180002785:     	pushq	%rdi
180002786:     	subq	$0x20, %rsp
18000278a:     	movq	0x28(%rcx), %rax
18000278e:     	xorl	%edi, %edi
180002790:     	movq	%rcx, %rbx
180002793:     	testq	%rax, %rax
180002796:     	je	0x1800027a2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x3d2>
180002798:     	addq	$0x38, %rcx
18000279c:     	callq	*%rax
18000279e:     	movq	%rdi, 0x28(%rbx)
1800027a2:     	movq	0x18(%rbx), %rcx
1800027a6:     	testq	%rcx, %rcx
1800027a9:     	je	0x1800027c2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x3f2>
1800027ab:     	movq	%rdi, 0x18(%rbx)
1800027af:     	movl	(%rcx), %eax
1800027b1:     	testl	%eax, %eax
1800027b3:     	js	0x1800027c2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x3f2>
1800027b5:     	subl	$0x1, %eax
1800027b8:     	movl	%eax, (%rcx)
1800027ba:     	jne	0x1800027c2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x3f2>
1800027bc:     	callq	*0x29ee(%rip)           # 0x1800051b0
1800027c2:     	movq	%rdi, 0x20(%rbx)
1800027c6:     	xorl	%eax, %eax
1800027c8:     	movq	0x30(%rsp), %rbx
1800027cd:     	addq	$0x20, %rsp
1800027d1:     	popq	%rdi
1800027d2:     	retq
1800027d3:     	int3
1800027d4:     	int3
1800027d5:     	int3
1800027d6:     	int3
1800027d7:     	int3
1800027d8:     	int3
1800027d9:     	int3
1800027da:     	int3
1800027db:     	int3
1800027dc:     	int3
1800027dd:     	int3
1800027de:     	int3
1800027df:     	int3
1800027e0:     	pushq	%rbx
1800027e2:     	subq	$0x20, %rsp
1800027e6:     	movq	%rcx, %rbx
1800027e9:     	callq	*0x2a01(%rip)           # 0x1800051f0
1800027ef:     	cmpq	$0x0, 0x30(%rbx)
1800027f4:     	je	0x1800027ff <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x42f>
1800027f6:     	movq	%rbx, %rcx
1800027f9:     	callq	*0x2981(%rip)           # 0x180005180
1800027ff:     	callq	*0x292b(%rip)           # 0x180005130
180002805:     	testl	%eax, %eax
180002807:     	jne	0x180002818 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x448>
180002809:     	movq	0x28(%rbx), %rax
18000280d:     	testq	%rax, %rax
180002810:     	je	0x180002818 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x448>
180002812:     	leaq	0x38(%rbx), %rcx
180002816:     	callq	*%rax
180002818:     	movq	0x18(%rbx), %rcx
18000281c:     	testq	%rcx, %rcx
18000281f:     	je	0x180002834 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x464>
180002821:     	movl	(%rcx), %eax
180002823:     	testl	%eax, %eax
180002825:     	js	0x180002834 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x464>
180002827:     	subl	$0x1, %eax
18000282a:     	movl	%eax, (%rcx)
18000282c:     	jne	0x180002834 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x464>
18000282e:     	callq	*0x297c(%rip)           # 0x1800051b0
180002834:     	movq	0x8(%rbx), %rax
180002838:     	movq	%rbx, %rcx
18000283b:     	addq	$0x20, %rsp
18000283f:     	popq	%rbx
180002840:     	jmpq	*0x140(%rax)
180002847:     	int3
180002848:     	int3
180002849:     	int3
18000284a:     	int3
18000284b:     	int3
18000284c:     	int3
18000284d:     	int3
18000284e:     	int3
18000284f:     	int3
180002850:     	pushq	%rdi
180002852:     	subq	$0x20, %rsp
180002856:     	cmpq	$0x0, 0x20(%rcx)
18000285b:     	movq	%rcx, %rdi
18000285e:     	jne	0x18000287f <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x4af>
180002860:     	movq	0x29d1(%rip), %rcx      # 0x180005238
180002867:     	leaq	0x310a(%rip), %rdx      # 0x180005978
18000286e:     	movq	(%rcx), %rcx
180002871:     	callq	*0x29b9(%rip)           # 0x180005230
180002877:     	xorl	%eax, %eax
180002879:     	addq	$0x20, %rsp
18000287d:     	popq	%rdi
18000287e:     	retq
18000287f:     	movq	%rdi, %rdx
180002882:     	movq	%rbx, 0x30(%rsp)
180002887:     	movl	$0x1, %ecx
18000288c:     	callq	*0x285e(%rip)           # 0x1800050f0
180002892:     	movq	%rax, %rbx
180002895:     	testq	%rax, %rax
180002898:     	jne	0x1800028a5 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x4d5>
18000289a:     	movq	0x30(%rsp), %rbx
18000289f:     	addq	$0x20, %rsp
1800028a3:     	popq	%rdi
1800028a4:     	retq
1800028a5:     	xorl	%r8d, %r8d
1800028a8:     	movq	%rbx, %rdx
1800028ab:     	movq	%rdi, %rcx
1800028ae:     	callq	*0x20(%rdi)
1800028b1:     	movl	(%rbx), %ecx
1800028b3:     	movq	%rax, %rdi
1800028b6:     	testl	%ecx, %ecx
1800028b8:     	js	0x1800028ca <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x4fa>
1800028ba:     	subl	$0x1, %ecx
1800028bd:     	movl	%ecx, (%rbx)
1800028bf:     	jne	0x1800028ca <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x4fa>
1800028c1:     	movq	%rbx, %rcx
1800028c4:     	callq	*0x28e6(%rip)           # 0x1800051b0
1800028ca:     	movq	0x30(%rsp), %rbx
1800028cf:     	movq	%rdi, %rax
1800028d2:     	addq	$0x20, %rsp
1800028d6:     	popq	%rdi
1800028d7:     	retq
1800028d8:     	int3
1800028d9:     	int3
1800028da:     	int3
1800028db:     	int3
1800028dc:     	int3
1800028dd:     	int3
1800028de:     	int3
1800028df:     	int3
1800028e0:     	movq	%rbx, 0x8(%rsp)
1800028e5:     	pushq	%rdi
1800028e6:     	subq	$0x20, %rsp
1800028ea:     	movq	%r8, %rbx
1800028ed:     	callq	*0x2825(%rip)           # 0x180005118
1800028f3:     	movl	(%rbx), %ecx
1800028f5:     	movl	%eax, %edi
1800028f7:     	testl	%ecx, %ecx
1800028f9:     	js	0x18000290b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x53b>
1800028fb:     	subl	$0x1, %ecx
1800028fe:     	movl	%ecx, (%rbx)
180002900:     	jne	0x18000290b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x53b>
180002902:     	movq	%rbx, %rcx
180002905:     	callq	*0x28a5(%rip)           # 0x1800051b0
18000290b:     	movl	%edi, %ecx
18000290d:     	movq	0x30(%rsp), %rbx
180002912:     	addq	$0x20, %rsp
180002916:     	popq	%rdi
180002917:     	jmpq	*0x28ca(%rip)           # 0x1800051e8
18000291e:     	int3
18000291f:     	int3
180002920:     	movq	%rbx, 0x8(%rsp)
180002925:     	pushq	%rdi
180002926:     	subq	$0x20, %rsp
18000292a:     	movl	(%rdx), %eax
18000292c:     	movq	%rdx, %rbx
18000292f:     	movq	%rcx, %rdi
180002932:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002937:     	jae	0x18000293d <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x56d>
180002939:     	incl	%eax
18000293b:     	movl	%eax, (%rdx)
18000293d:     	movl	$0x30, %ecx
180002942:     	callq	*0x92e0(%rip)           # 0x18000bc28
180002948:     	cmpb	$0x0, 0x92b1(%rip)      # 0x18000bc00
18000294f:     	je	0x180002959 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x589>
180002951:     	lock
180002952:     	incq	0x92af(%rip)            # 0x18000bc08
180002959:     	testq	%rax, %rax
18000295c:     	je	0x180002993 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x5c3>
18000295e:     	movl	$0x1, %ecx
180002963:     	leaq	-0x8a(%rip), %rdx       # 0x1800028e0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x510>
18000296a:     	xchgq	%rcx, (%rax)
18000296d:     	xorl	%ecx, %ecx
18000296f:     	movq	%rdx, 0x8(%rax)
180002973:     	movq	%rcx, 0x20(%rax)
180002977:     	movq	%rcx, 0x28(%rax)
18000297b:     	movq	%rbx, 0x10(%rax)
18000297f:     	movq	%rdi, 0x18(%rax)
180002983:     	cmpb	%cl, 0x9277(%rip)       # 0x18000bc00
180002989:     	je	0x180002993 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x5c3>
18000298b:     	lock
18000298c:     	incq	0x9285(%rip)            # 0x18000bc18
180002993:     	movq	0x30(%rsp), %rbx
180002998:     	addq	$0x20, %rsp
18000299c:     	popq	%rdi
18000299d:     	retq
18000299e:     	int3
18000299f:     	int3
1800029a0:     	movq	%rbx, 0x8(%rsp)
1800029a5:     	pushq	%rdi
1800029a6:     	subq	$0x30, %rsp
1800029aa:     	movq	%rcx, %rdi
1800029ad:     	leaq	0x8fcc(%rip), %r9       # 0x18000b980
1800029b4:     	movq	%r8, %rax
1800029b7:     	leaq	0x58(%rsp), %rcx
1800029bc:     	movq	%rdx, %r10
1800029bf:     	movq	%rcx, 0x20(%rsp)
1800029c4:     	movq	%r10, %rcx
1800029c7:     	leaq	0x2ff2(%rip), %r8       # 0x1800059c0
1800029ce:     	movq	%rax, %rdx
1800029d1:     	callq	*0x2709(%rip)           # 0x1800050e0
1800029d7:     	testl	%eax, %eax
1800029d9:     	je	0x180002a03 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x633>
1800029db:     	movq	0x58(%rsp), %rcx
1800029e0:     	callq	*0x2742(%rip)           # 0x180005128
1800029e6:     	movq	%rax, %rbx
1800029e9:     	callq	*0x2859(%rip)           # 0x180005248
1800029ef:     	testq	%rax, %rax
1800029f2:     	jne	0x180002a03 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x633>
1800029f4:     	movq	%rbx, 0x10(%rdi)
1800029f8:     	movq	0x40(%rsp), %rbx
1800029fd:     	addq	$0x30, %rsp
180002a01:     	popq	%rdi
180002a02:     	retq
180002a03:     	movq	0x40(%rsp), %rbx
180002a08:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002a0d:     	addq	$0x30, %rsp
180002a11:     	popq	%rdi
180002a12:     	retq
180002a13:     	int3
180002a14:     	int3
180002a15:     	int3
180002a16:     	int3
180002a17:     	int3
180002a18:     	int3
180002a19:     	int3
180002a1a:     	int3
180002a1b:     	int3
180002a1c:     	int3
180002a1d:     	int3
180002a1e:     	int3
180002a1f:     	int3
180002a20:     	subq	$0x38, %rsp
180002a24:     	movl	%r8d, %eax
180002a27:     	movq	%rdx, %r10
180002a2a:     	movq	0x10(%rcx), %r8
180002a2e:     	movq	%rcx, %rdx
180002a31:     	movl	%eax, 0x28(%rsp)
180002a35:     	movq	%r10, %rcx
180002a38:     	movl	$0x0, 0x20(%rsp)
180002a40:     	movq	0x20(%r8), %r9
180002a44:     	movq	0x18(%r8), %r8
180002a48:     	callq	*0x278a(%rip)           # 0x1800051d8
180002a4e:     	addq	$0x38, %rsp
180002a52:     	retq
180002a53:     	int3
180002a54:     	int3
180002a55:     	int3
180002a56:     	int3
180002a57:     	int3
180002a58:     	int3
180002a59:     	int3
180002a5a:     	int3
180002a5b:     	int3
180002a5c:     	int3
180002a5d:     	int3
180002a5e:     	int3
180002a5f:     	int3
180002a60:     	movq	0x10(%rcx), %rax
180002a64:     	lock
180002a65:     	incq	(%rax)
180002a68:     	movq	0x2771(%rip), %rax      # 0x1800051e0
180002a6f:     	retq
180002a70:     	subq	$0x28, %rsp
180002a74:     	movq	0x10(%rcx), %rcx
180002a78:     	callq	0x180003d70 <numba_list_iter_next+0x1d0>
180002a7d:     	movq	0x275c(%rip), %rax      # 0x1800051e0
180002a84:     	addq	$0x28, %rsp
180002a88:     	retq
180002a89:     	int3
180002a8a:     	int3
180002a8b:     	int3
180002a8c:     	int3
180002a8d:     	int3
180002a8e:     	int3
180002a8f:     	int3
180002a90:     	movq	0x10(%rcx), %rcx
180002a94:     	movq	0x18(%rcx), %rcx
180002a98:     	jmpq	*0x26b1(%rip)           # 0x180005150
180002a9f:     	int3
180002aa0:     	subq	$0x28, %rsp
180002aa4:     	movq	0x10(%rcx), %rax
180002aa8:     	testq	%rax, %rax
180002aab:     	je	0x180002ac9 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x6f9>
180002aad:     	cmpq	$0x0, 0x18(%rax)
180002ab2:     	je	0x180002ac9 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x6f9>
180002ab4:     	movq	(%rax), %rcx
180002ab7:     	nop
180002ab8:     	cmpq	$-0x1, %rcx
180002abc:     	je	0x180002ac9 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x6f9>
180002abe:     	addq	$0x28, %rsp
180002ac2:     	jmpq	*0x263f(%rip)           # 0x180005108
180002ac9:     	movq	0x2700(%rip), %rcx      # 0x1800051d0
180002ad0:     	leaq	0x2ef1(%rip), %rdx      # 0x1800059c8
180002ad7:     	movq	(%rcx), %rcx
180002ada:     	callq	*0x2750(%rip)           # 0x180005230
180002ae0:     	xorl	%eax, %eax
180002ae2:     	addq	$0x28, %rsp
180002ae6:     	retq
180002ae7:     	int3
180002ae8:     	int3
180002ae9:     	int3
180002aea:     	int3
180002aeb:     	int3
180002aec:     	int3
180002aed:     	int3
180002aee:     	int3
180002aef:     	int3
180002af0:     	movq	0x10(%rcx), %rcx
180002af4:     	movq	0x28(%rcx), %rcx
180002af8:     	jmpq	*0x2651(%rip)           # 0x180005150
180002aff:     	int3
180002b00:     	movq	0x10(%rcx), %rax
180002b04:     	movq	0x10(%rax), %rax
180002b08:     	testq	%rax, %rax
180002b0b:     	je	0x180002b1c <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x74c>
180002b0d:     	movl	(%rax), %ecx
180002b0f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180002b15:     	jae	0x180002b3a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x76a>
180002b17:     	incl	%ecx
180002b19:     	movl	%ecx, (%rax)
180002b1b:     	retq
180002b1c:     	movq	0x26bd(%rip), %rcx      # 0x1800051e0
180002b23:     	movl	(%rcx), %eax
180002b25:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002b2a:     	jae	0x180002b37 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x767>
180002b2c:     	incl	%eax
180002b2e:     	movl	%eax, (%rcx)
180002b30:     	movq	0x26a9(%rip), %rcx      # 0x1800051e0
180002b37:     	movq	%rcx, %rax
180002b3a:     	retq
180002b3b:     	int3
180002b3c:     	int3
180002b3d:     	int3
180002b3e:     	int3
180002b3f:     	int3
180002b40:     	pushq	%rbx
180002b42:     	subq	$0x20, %rsp
180002b46:     	movq	%rcx, %rbx
180002b49:     	movq	0x10(%rcx), %rcx
180002b4d:     	callq	0x180003d70 <numba_list_iter_next+0x1d0>
180002b52:     	movq	0x8(%rbx), %rax
180002b56:     	movq	%rbx, %rcx
180002b59:     	addq	$0x20, %rsp
180002b5d:     	popq	%rbx
180002b5e:     	jmpq	*0x140(%rax)
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
180002b70:     	movq	%rdi, 0x18(%rsp)
180002b75:     	pushq	%r14
180002b77:     	subq	$0x20, %rsp
180002b7b:     	movq	0x90be(%rip), %rax      # 0x18000bc40
180002b82:     	movq	%rdx, %r14
180002b85:     	movq	%rcx, %rdi
180002b88:     	movq	0x8(%rcx), %rcx
180002b8c:     	movq	0x10(%rax), %rdx
180002b90:     	cmpq	%rdx, %rcx
180002b93:     	je	0x180002bb0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7e0>
180002b95:     	callq	*0x261d(%rip)           # 0x1800051b8
180002b9b:     	testl	%eax, %eax
180002b9d:     	jne	0x180002bb0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x7e0>
180002b9f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002ba4:     	movq	0x40(%rsp), %rdi
180002ba9:     	addq	$0x20, %rsp
180002bad:     	popq	%r14
180002baf:     	retq
180002bb0:     	movq	%rbx, 0x30(%rsp)
180002bb5:     	movq	%rdi, %rdx
180002bb8:     	movq	0x10(%rdi), %rbx
180002bbc:     	movq	%rbx, %rcx
180002bbf:     	movq	%rsi, 0x38(%rsp)
180002bc4:     	movl	0x18(%rdi), %esi
180002bc7:     	callq	0x180002920 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x550>
180002bcc:     	movq	%rax, (%r14)
180002bcf:     	movq	0x906a(%rip), %rax      # 0x18000bc40
180002bd6:     	movq	%rbx, 0x20(%r14)
180002bda:     	movl	0x18(%rdi), %edx
180002bdd:     	movq	0x20(%rdi), %rcx
180002be1:     	callq	*0x4f0(%rax)
180002be7:     	cmpl	$0x12, 0x905e(%rip)     # 0x18000bc4c
180002bee:     	movq	0x30(%rsp), %rbx
180002bf3:     	movq	%rax, 0x10(%r14)
180002bf7:     	movq	0x38(%rdi), %rax
180002bfb:     	jl	0x180002c03 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x833>
180002bfd:     	movq	0x28(%rax), %rax
180002c01:     	jmp	0x180002c07 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x837>
180002c03:     	movslq	0x20(%rax), %rax
180002c07:     	xorl	%r8d, %r8d
180002c0a:     	movq	%rax, 0x18(%r14)
180002c0e:     	movq	%rdi, 0x8(%r14)
180002c12:     	leaq	0x28(%r14), %rax
180002c16:     	testl	%esi, %esi
180002c18:     	jle	0x180002c5b <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x88b>
180002c1a:     	nopw	(%rax,%rax)
180002c20:     	movq	0x20(%rdi), %rcx
180002c24:     	movq	(%rcx,%r8,8), %rdx
180002c28:     	incl	%r8d
180002c2b:     	movq	%rdx, (%rax)
180002c2e:     	addq	$0x8, %rax
180002c32:     	cmpl	%esi, %r8d
180002c35:     	jl	0x180002c20 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x850>
180002c37:     	xorl	%r8d, %r8d
180002c3a:     	nopw	(%rax,%rax)
180002c40:     	movq	0x28(%rdi), %rcx
180002c44:     	leaq	0x8(%rax), %rax
180002c48:     	movslq	%r8d, %rdx
180002c4b:     	incl	%r8d
180002c4e:     	movq	(%rcx,%rdx,8), %rdx
180002c52:     	movq	%rdx, -0x8(%rax)
180002c56:     	cmpl	%esi, %r8d
180002c59:     	jl	0x180002c40 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x870>
180002c5b:     	movq	0x38(%rsp), %rsi
180002c60:     	xorl	%eax, %eax
180002c62:     	movq	0x40(%rsp), %rdi
180002c67:     	addq	$0x20, %rsp
180002c6b:     	popq	%r14
180002c6d:     	retq
180002c6e:     	int3
180002c6f:     	int3
180002c70:     	pushq	%rbx
180002c72:     	pushq	%rbp
180002c73:     	pushq	%rsi
180002c74:     	pushq	%rdi
180002c75:     	subq	$0x28, %rsp
180002c79:     	cmpq	$0x0, 0x8fcf(%rip)      # 0x18000bc50
180002c81:     	movq	%rcx, %rbp
180002c84:     	movslq	0x8(%rdx), %rdi
180002c88:     	movq	(%rdx), %rsi
180002c8b:     	jne	0x180002ce3 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x913>
180002c8d:     	leaq	0x2c74(%rip), %rcx      # 0x180005908
180002c94:     	callq	*0x256e(%rip)           # 0x180005208
180002c9a:     	movq	%rax, %rbx
180002c9d:     	testq	%rax, %rax
180002ca0:     	je	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002ca6:     	leaq	0x2c63(%rip), %rdx      # 0x180005910
180002cad:     	movq	%rax, %rcx
180002cb0:     	callq	*0x24aa(%rip)           # 0x180005160
180002cb6:     	movl	(%rbx), %edx
180002cb8:     	movq	%rax, 0x8f91(%rip)      # 0x18000bc50
180002cbf:     	testl	%edx, %edx
180002cc1:     	js	0x180002cda <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x90a>
180002cc3:     	subl	$0x1, %edx
180002cc6:     	movl	%edx, (%rbx)
180002cc8:     	jne	0x180002cda <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x90a>
180002cca:     	movq	%rbx, %rcx
180002ccd:     	callq	*0x24dd(%rip)           # 0x1800051b0
180002cd3:     	movq	0x8f76(%rip), %rax      # 0x18000bc50
180002cda:     	testq	%rax, %rax
180002cdd:     	je	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002ce3:     	movq	%rdi, %rdx
180002ce6:     	movq	%rsi, %rcx
180002ce9:     	callq	*0x2431(%rip)           # 0x180005120
180002cef:     	movq	%rax, %rdi
180002cf2:     	testq	%rax, %rax
180002cf5:     	je	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002cf7:     	movq	0x8f52(%rip), %rcx      # 0x18000bc50
180002cfe:     	xorl	%r8d, %r8d
180002d01:     	movq	%rax, %rdx
180002d04:     	callq	*0x247e(%rip)           # 0x180005188
180002d0a:     	movl	(%rdi), %ecx
180002d0c:     	movq	%rax, %rbx
180002d0f:     	testl	%ecx, %ecx
180002d11:     	js	0x180002d23 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x953>
180002d13:     	subl	$0x1, %ecx
180002d16:     	movl	%ecx, (%rdi)
180002d18:     	jne	0x180002d23 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x953>
180002d1a:     	movq	%rdi, %rcx
180002d1d:     	callq	*0x248d(%rip)           # 0x1800051b0
180002d23:     	testq	%rbx, %rbx
180002d26:     	je	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002d28:     	movq	0x8(%rbx), %r8
180002d2c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180002d37:     	jne	0x180002d75 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x9a5>
180002d39:     	movq	0x24e8(%rip), %rcx      # 0x180005228
180002d40:     	leaq	0x2d89(%rip), %rdx      # 0x180005ad0
180002d47:     	movq	0x18(%r8), %r8
180002d4b:     	movq	(%rcx), %rcx
180002d4e:     	callq	*0x2474(%rip)           # 0x1800051c8
180002d54:     	movl	(%rbx), %eax
180002d56:     	testl	%eax, %eax
180002d58:     	js	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002d5a:     	subl	$0x1, %eax
180002d5d:     	movl	%eax, (%rbx)
180002d5f:     	jne	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002d61:     	movq	%rbx, %rcx
180002d64:     	callq	*0x2446(%rip)           # 0x1800051b0
180002d6a:     	xorl	%eax, %eax
180002d6c:     	addq	$0x28, %rsp
180002d70:     	popq	%rdi
180002d71:     	popq	%rsi
180002d72:     	popq	%rbp
180002d73:     	popq	%rbx
180002d74:     	retq
180002d75:     	xorl	%r8d, %r8d
180002d78:     	leaq	0x8581(%rip), %rcx      # 0x18000b300
180002d7f:     	xorl	%edx, %edx
180002d81:     	callq	*0x2489(%rip)           # 0x180005210
180002d87:     	movq	%rax, %rdi
180002d8a:     	testq	%rax, %rax
180002d8d:     	je	0x180002d54 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x984>
180002d8f:     	movq	%rbp, %rcx
180002d92:     	movq	%rbx, 0x18(%rax)
180002d96:     	callq	*0x240c(%rip)           # 0x1800051a8
180002d9c:     	movq	%rax, 0x10(%rdi)
180002da0:     	movq	%rax, %rcx
180002da3:     	testq	%rax, %rax
180002da6:     	jne	0x180002dba <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x9ea>
180002da8:     	movl	(%rdi), %eax
180002daa:     	testl	%eax, %eax
180002dac:     	js	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002dae:     	subl	$0x1, %eax
180002db1:     	movl	%eax, (%rdi)
180002db3:     	jne	0x180002d6a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x99a>
180002db5:     	movq	%rdi, %rcx
180002db8:     	jmp	0x180002d64 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x994>
180002dba:     	movl	(%rax), %eax
180002dbc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002dc1:     	jae	0x180002dc7 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x9f7>
180002dc3:     	incl	%eax
180002dc5:     	movl	%eax, (%rcx)
180002dc7:     	movq	%rdi, %rax
180002dca:     	addq	$0x28, %rsp
180002dce:     	popq	%rdi
180002dcf:     	popq	%rsi
180002dd0:     	popq	%rbp
180002dd1:     	popq	%rbx
180002dd2:     	retq
180002dd3:     	int3
180002dd4:     	int3
180002dd5:     	int3
180002dd6:     	int3
180002dd7:     	int3
180002dd8:     	int3
180002dd9:     	int3
180002dda:     	int3
180002ddb:     	int3
180002ddc:     	int3
180002ddd:     	int3
180002dde:     	int3
180002ddf:     	int3
180002de0:     	movq	%r9, 0x20(%rsp)
180002de5:     	movq	%r8, 0x18(%rsp)
180002dea:     	movq	%rdx, 0x10(%rsp)
180002def:     	movq	%rcx, 0x8(%rsp)
180002df4:     	pushq	%rbx
180002df5:     	pushq	%rbp
180002df6:     	pushq	%rsi
180002df7:     	pushq	%rdi
180002df8:     	pushq	%r12
180002dfa:     	pushq	%r13
180002dfc:     	pushq	%r14
180002dfe:     	pushq	%r15
180002e00:     	subq	$0x68, %rsp
180002e04:     	movq	%rcx, %r14
180002e07:     	movq	%r9, %r15
180002e0a:     	leaq	0x27ff(%rip), %rcx      # 0x180005610
180002e11:     	movq	%r8, %r13
180002e14:     	movq	%rdx, %rsi
180002e17:     	callq	*0x23eb(%rip)           # 0x180005208
180002e1d:     	movq	%rax, %rdi
180002e20:     	testq	%rax, %rax
180002e23:     	jne	0x180002e5c <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xa8c>
180002e25:     	movq	0x22e4(%rip), %rcx      # 0x180005110
180002e2c:     	movq	(%rcx), %rcx
180002e2f:     	callq	*0x2363(%rip)           # 0x180005198
180002e35:     	testl	%eax, %eax
180002e37:     	je	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002e3d:     	callq	*0x2315(%rip)           # 0x180005158
180002e43:     	leaq	0x27e6(%rip), %rcx      # 0x180005630
180002e4a:     	callq	*0x23b8(%rip)           # 0x180005208
180002e50:     	movq	%rax, %rdi
180002e53:     	testq	%rax, %rax
180002e56:     	je	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002e5c:     	leaq	0x27ed(%rip), %rdx      # 0x180005650
180002e63:     	movq	%rdi, %rcx
180002e66:     	callq	*0x22f4(%rip)           # 0x180005160
180002e6c:     	movl	(%rdi), %ecx
180002e6e:     	movq	%rax, %rbx
180002e71:     	testl	%ecx, %ecx
180002e73:     	js	0x180002e85 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xab5>
180002e75:     	subl	$0x1, %ecx
180002e78:     	movl	%ecx, (%rdi)
180002e7a:     	jne	0x180002e85 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xab5>
180002e7c:     	movq	%rdi, %rcx
180002e7f:     	callq	*0x232b(%rip)           # 0x1800051b0
180002e85:     	testq	%rbx, %rbx
180002e88:     	je	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002e8e:     	movq	0x2253(%rip), %rax      # 0x1800050e8
180002e95:     	cmpq	%rax, 0x8(%rbx)
180002e99:     	je	0x180002ed5 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb05>
180002e9b:     	movq	0x2396(%rip), %rcx      # 0x180005238
180002ea2:     	leaq	0x27b7(%rip), %rdx      # 0x180005660
180002ea9:     	movq	(%rcx), %rcx
180002eac:     	callq	*0x237e(%rip)           # 0x180005230
180002eb2:     	movl	(%rbx), %eax
180002eb4:     	testl	%eax, %eax
180002eb6:     	js	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002ebc:     	subl	$0x1, %eax
180002ebf:     	movl	%eax, (%rbx)
180002ec1:     	jne	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002ec7:     	movq	%rbx, %rcx
180002eca:     	callq	*0x22e0(%rip)           # 0x1800051b0
180002ed0:     	jmp	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002ed5:     	xorl	%edx, %edx
180002ed7:     	movq	%rbx, %rcx
180002eda:     	callq	*0x22b0(%rip)           # 0x180005190
180002ee0:     	movl	(%rbx), %ecx
180002ee2:     	movq	%rax, 0x8d57(%rip)      # 0x18000bc40
180002ee9:     	testl	%ecx, %ecx
180002eeb:     	js	0x180002f04 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb34>
180002eed:     	subl	$0x1, %ecx
180002ef0:     	movl	%ecx, (%rbx)
180002ef2:     	jne	0x180002f04 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb34>
180002ef4:     	movq	%rbx, %rcx
180002ef7:     	callq	*0x22b3(%rip)           # 0x1800051b0
180002efd:     	movq	0x8d3c(%rip), %rax      # 0x18000bc40
180002f04:     	testq	%rax, %rax
180002f07:     	jne	0x180002f22 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb52>
180002f09:     	leaq	0x2778(%rip), %rdx      # 0x180005688
180002f10:     	movq	0x2321(%rip), %rcx      # 0x180005238
180002f17:     	movq	(%rcx), %rcx
180002f1a:     	callq	*0x2310(%rip)           # 0x180005230
180002f20:     	jmp	0x180002f57 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb87>
180002f22:     	callq	*(%rax)
180002f24:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180002f29:     	jbe	0x180002f8a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xbba>
180002f2b:     	movq	0x2306(%rip), %rax      # 0x180005238
180002f32:     	movq	(%rax), %rbx
180002f35:     	movq	0x8d04(%rip), %rax      # 0x18000bc40
180002f3c:     	callq	*(%rax)
180002f3e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002f44:     	leaq	0x2765(%rip), %rdx      # 0x1800056b0
180002f4b:     	movl	%eax, %r9d
180002f4e:     	movq	%rbx, %rcx
180002f51:     	callq	*0x2271(%rip)           # 0x1800051c8
180002f57:     	callq	*0x230b(%rip)           # 0x180005268
180002f5d:     	movq	0x2194(%rip), %rcx      # 0x1800050f8
180002f64:     	leaq	0x296d(%rip), %rdx      # 0x1800058d8
180002f6b:     	movq	(%rcx), %rcx
180002f6e:     	callq	*0x22bc(%rip)           # 0x180005230
180002f74:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002f79:     	addq	$0x68, %rsp
180002f7d:     	popq	%r15
180002f7f:     	popq	%r14
180002f81:     	popq	%r13
180002f83:     	popq	%r12
180002f85:     	popq	%rdi
180002f86:     	popq	%rsi
180002f87:     	popq	%rbp
180002f88:     	popq	%rbx
180002f89:     	retq
180002f8a:     	movq	0x8caf(%rip), %rax      # 0x18000bc40
180002f91:     	callq	*0x698(%rax)
180002f97:     	movl	%eax, 0x8caf(%rip)      # 0x18000bc4c
180002f9d:     	cmpl	$0x10, %eax
180002fa0:     	jge	0x180002fbe <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xbee>
180002fa2:     	movq	0x228f(%rip), %rcx      # 0x180005238
180002fa9:     	leaq	0x2750(%rip), %rdx      # 0x180005700
180002fb0:     	movl	%eax, %r9d
180002fb3:     	movl	$0x10, %r8d
180002fb9:     	movq	(%rcx), %rcx
180002fbc:     	jmp	0x180002f51 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb81>
180002fbe:     	movq	0x8c7b(%rip), %rax      # 0x18000bc40
180002fc5:     	callq	*0x690(%rax)
180002fcb:     	testl	%eax, %eax
180002fcd:     	jne	0x180002fdb <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xc0b>
180002fcf:     	leaq	0x287a(%rip), %rdx      # 0x180005850
180002fd6:     	jmp	0x180002f10 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb40>
180002fdb:     	cmpl	$0x1, %eax
180002fde:     	je	0x180002fec <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xc1c>
180002fe0:     	leaq	0x2899(%rip), %rdx      # 0x180005880
180002fe7:     	jmp	0x180002f10 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xb40>
180002fec:     	leaq	0x87ed(%rip), %rcx      # 0x18000b7e0
180002ff3:     	callq	*0x216f(%rip)           # 0x180005168
180002ff9:     	testl	%eax, %eax
180002ffb:     	jne	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
180003001:     	leaq	0x82f8(%rip), %rcx      # 0x18000b300
180003008:     	callq	*0x215a(%rip)           # 0x180005168
18000300e:     	testl	%eax, %eax
180003010:     	jne	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
180003016:     	leaq	0x8623(%rip), %rcx      # 0x18000b640
18000301d:     	callq	*0x2145(%rip)           # 0x180005168
180003023:     	testl	%eax, %eax
180003025:     	jne	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
18000302b:     	xorl	%ebx, %ebx
18000302d:     	cmpl	%ebx, 0x8c15(%rip)      # 0x18000bc48
180003033:     	jne	0x180003076 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xca6>
180003035:     	movq	%gs:0x58, %rax
18000303e:     	movl	0x8c14(%rip), %ecx      # 0x18000bc58
180003044:     	movl	$0x1, 0x8bfa(%rip)      # 0x18000bc48
18000304e:     	movq	(%rax,%rcx,8), %rdx
180003052:     	movl	$0x10, %eax
180003057:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000305e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180003063:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000306a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000306f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180003076:     	movl	%ebx, 0x8b7c(%rip)      # 0x18000bbf8
18000307c:     	movq	%rbx, %rax
18000307f:     	movb	%bl, 0x8b7b(%rip)       # 0x18000bc00
180003085:     	movq	%rbx, %rcx
180003088:     	xchgq	%rax, 0x8b79(%rip)      # 0x18000bc08
18000308f:     	xchgq	%rcx, 0x8b7a(%rip)      # 0x18000bc10
180003096:     	movq	%rbx, %rax
180003099:     	movq	%rbx, %rcx
18000309c:     	xchgq	%rax, 0x8b75(%rip)      # 0x18000bc18
1800030a3:     	xchgq	%rcx, 0x8b76(%rip)      # 0x18000bc20
1800030aa:     	movq	0x1faf(%rip), %rax      # 0x180005060
1800030b1:     	leaq	0x83e8(%rip), %rcx      # 0x18000b4a0
1800030b8:     	movq	%rax, 0x8b69(%rip)      # 0x18000bc28
1800030bf:     	movq	0x1faa(%rip), %rax      # 0x180005070
1800030c6:     	movq	%rax, 0x8b63(%rip)      # 0x18000bc30
1800030cd:     	movq	0x1f94(%rip), %rax      # 0x180005068
1800030d4:     	movq	%rax, 0x8b5d(%rip)      # 0x18000bc38
1800030db:     	movq	0x212e(%rip), %rax      # 0x180005210
1800030e2:     	movq	%rax, 0x84ef(%rip)      # 0x18000b5d8
1800030e9:     	callq	*0x2079(%rip)           # 0x180005168
1800030ef:     	testl	%eax, %eax
1800030f1:     	jne	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
1800030f7:     	leaq	0x286a(%rip), %rdx      # 0x180005968
1800030fe:     	movq	%r14, %rcx
180003101:     	callq	*0x2059(%rip)           # 0x180005160
180003107:     	movq	%rax, 0x28(%rsp)
18000310c:     	movq	%rax, %rdi
18000310f:     	testq	%rax, %rax
180003112:     	je	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
180003118:     	leaq	0x29e2(%rip), %rcx      # 0x180005b01
18000311f:     	callq	*0x1fdb(%rip)           # 0x180005100
180003125:     	movq	%rax, 0x20(%rsp)
18000312a:     	movq	%rax, %r12
18000312d:     	testq	%rax, %rax
180003130:     	je	0x180003474 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x10a4>
180003136:     	movl	%ebx, %ebp
180003138:     	cmpq	%rbx, (%rsi)
18000313b:     	je	0x1800032e4 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xf14>
180003141:     	movslq	%ebp, %rbx
180003144:     	leaq	0x30(%rsp), %rdx
180003149:     	movq	%r14, %rcx
18000314c:     	leaq	(%rbx,%rbx,4), %rax
180003150:     	movups	(%r13,%rax,8), %xmm0
180003156:     	movups	0x10(%r13,%rax,8), %xmm1
18000315c:     	movaps	%xmm0, 0x30(%rsp)
180003161:     	movsd	0x20(%r13,%rax,8), %xmm0
180003168:     	movsd	%xmm0, 0x50(%rsp)
18000316e:     	movaps	%xmm1, 0x40(%rsp)
180003173:     	callq	0x180002c70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x8a0>
180003178:     	movq	%rax, %r14
18000317b:     	testq	%rax, %rax
18000317e:     	je	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
180003184:     	movq	(%rsi), %rcx
180003187:     	callq	*0x1f73(%rip)           # 0x180005100
18000318d:     	movq	%rax, %r13
180003190:     	testq	%rax, %rax
180003193:     	je	0x180003497 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x10c7>
180003199:     	movq	(%r15,%rbx,8), %rcx
18000319d:     	xorl	%edx, %edx
18000319f:     	movq	%r14, (%rcx)
1800031a2:     	leaq	0x8637(%rip), %rcx      # 0x18000b7e0
1800031a9:     	movq	0x8(%rsi), %r12
1800031ad:     	callq	*0x1f95(%rip)           # 0x180005148
1800031b3:     	movq	%rax, %rbx
1800031b6:     	testq	%rax, %rax
1800031b9:     	je	0x180003236 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe66>
1800031bb:     	movq	%r13, %rcx
1800031be:     	callq	*0x1fb4(%rip)           # 0x180005178
1800031c4:     	movq	%rax, %rdi
1800031c7:     	testq	%rax, %rax
1800031ca:     	je	0x1800031ec <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe1c>
1800031cc:     	movq	%rax, %rcx
1800031cf:     	callq	0x180004a25 <numba_list_iter_next+0xe85>
1800031d4:     	leaq	0x1(%rax), %rcx
1800031d8:     	callq	*0x203a(%rip)           # 0x180005218
1800031de:     	movq	%rax, %rsi
1800031e1:     	testq	%rax, %rax
1800031e4:     	jne	0x1800031f4 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe24>
1800031e6:     	callq	*0x1f4c(%rip)           # 0x180005138
1800031ec:     	xorl	%eax, %eax
1800031ee:     	movq	%rax, 0x20(%rbx)
1800031f2:     	jmp	0x180003225 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe55>
1800031f4:     	movq	%rdi, %rdx
1800031f7:     	movq	%rsi, %rcx
1800031fa:     	callq	0x180004a1f <numba_list_iter_next+0xe7f>
1800031ff:     	movq	0x20(%rsp), %rcx
180003204:     	movq	%rsi, 0x20(%rbx)
180003208:     	movq	%r12, 0x28(%rbx)
18000320c:     	movl	$0x3, 0x30(%rbx)
180003213:     	callq	0x1800026f0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x320>
180003218:     	movq	%rax, 0x38(%rbx)
18000321c:     	testq	%rax, %rax
18000321f:     	jne	0x180003390 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfc0>
180003225:     	movl	(%rbx), %eax
180003227:     	testl	%eax, %eax
180003229:     	js	0x180003236 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe66>
18000322b:     	subl	$0x1, %eax
18000322e:     	movl	%eax, (%rbx)
180003230:     	je	0x1800033dd <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x100d>
180003236:     	xorl	%edi, %edi
180003238:     	movl	(%r14), %eax
18000323b:     	testl	%eax, %eax
18000323d:     	js	0x180003250 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe80>
18000323f:     	subl	$0x1, %eax
180003242:     	movl	%eax, (%r14)
180003245:     	jne	0x180003250 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe80>
180003247:     	movq	%r14, %rcx
18000324a:     	callq	*0x1f60(%rip)           # 0x1800051b0
180003250:     	movl	(%r13), %eax
180003254:     	testl	%eax, %eax
180003256:     	js	0x18000326a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe9a>
180003258:     	subl	$0x1, %eax
18000325b:     	movl	%eax, (%r13)
18000325f:     	jne	0x18000326a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe9a>
180003261:     	movq	%r13, %rcx
180003264:     	callq	*0x1f46(%rip)           # 0x1800051b0
18000326a:     	testq	%rdi, %rdi
18000326d:     	je	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
180003273:     	movq	0xb8(%rsp), %rsi
18000327b:     	movq	%rdi, %r8
18000327e:     	movq	0xb0(%rsp), %r14
180003286:     	movq	%r14, %rcx
180003289:     	movq	(%rsi), %rdx
18000328c:     	callq	*0x1f66(%rip)           # 0x1800051f8
180003292:     	movl	(%rdi), %ecx
180003294:     	testl	%eax, %eax
180003296:     	jne	0x18000343a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x106a>
18000329c:     	testl	%ecx, %ecx
18000329e:     	js	0x1800032b2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xee2>
1800032a0:     	leal	-0x1(%rcx), %eax
1800032a3:     	movl	%eax, (%rdi)
1800032a5:     	testl	%eax, %eax
1800032a7:     	jne	0x1800032b2 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xee2>
1800032a9:     	movq	%rdi, %rcx
1800032ac:     	callq	*0x1efe(%rip)           # 0x1800051b0
1800032b2:     	movq	0xc8(%rsp), %r15
1800032ba:     	addq	$0x20, %rsi
1800032be:     	movq	0xc0(%rsp), %r13
1800032c6:     	incl	%ebp
1800032c8:     	movq	%rsi, 0xb8(%rsp)
1800032d0:     	cmpq	$0x0, (%rsi)
1800032d4:     	jne	0x180003141 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xd71>
1800032da:     	movq	0x20(%rsp), %r12
1800032df:     	movq	0x28(%rsp), %rdi
1800032e4:     	movslq	%ebp, %rax
1800032e7:     	cmpq	$0x0, (%r15,%rax,8)
1800032ec:     	je	0x180003359 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xf89>
1800032ee:     	nop
1800032f0:     	movslq	%ebp, %rbx
1800032f3:     	leaq	0x30(%rsp), %rdx
1800032f8:     	movq	%r14, %rcx
1800032fb:     	leaq	(%rbx,%rbx,4), %rax
1800032ff:     	movups	(%r13,%rax,8), %xmm0
180003305:     	movups	0x10(%r13,%rax,8), %xmm1
18000330b:     	movaps	%xmm0, 0x30(%rsp)
180003310:     	movsd	0x20(%r13,%rax,8), %xmm0
180003317:     	movsd	%xmm0, 0x50(%rsp)
18000331d:     	movaps	%xmm1, 0x40(%rsp)
180003322:     	callq	0x180002c70 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x8a0>
180003327:     	testq	%rax, %rax
18000332a:     	je	0x180003455 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1085>
180003330:     	movq	(%r15,%rbx,8), %rcx
180003334:     	movq	%rax, (%rcx)
180003337:     	movl	(%rax), %ecx
180003339:     	testl	%ecx, %ecx
18000333b:     	js	0x18000334d <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xf7d>
18000333d:     	subl	$0x1, %ecx
180003340:     	movl	%ecx, (%rax)
180003342:     	jne	0x18000334d <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xf7d>
180003344:     	movq	%rax, %rcx
180003347:     	callq	*0x1e63(%rip)           # 0x1800051b0
18000334d:     	incl	%ebp
18000334f:     	movslq	%ebp, %rax
180003352:     	cmpq	$0x0, (%r15,%rax,8)
180003357:     	jne	0x1800032f0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xf20>
180003359:     	movl	(%r12), %eax
18000335d:     	testl	%eax, %eax
18000335f:     	js	0x180003373 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfa3>
180003361:     	subl	$0x1, %eax
180003364:     	movl	%eax, (%r12)
180003368:     	jne	0x180003373 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfa3>
18000336a:     	movq	%r12, %rcx
18000336d:     	callq	*0x1e3d(%rip)           # 0x1800051b0
180003373:     	movl	(%rdi), %eax
180003375:     	testl	%eax, %eax
180003377:     	js	0x180003389 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfb9>
180003379:     	subl	$0x1, %eax
18000337c:     	movl	%eax, (%rdi)
18000337e:     	jne	0x180003389 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfb9>
180003380:     	movq	%rdi, %rcx
180003383:     	callq	*0x1e27(%rip)           # 0x1800051b0
180003389:     	xorl	%eax, %eax
18000338b:     	jmp	0x180002f79 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba9>
180003390:     	movl	(%r14), %eax
180003393:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180003398:     	jae	0x18000339f <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xfcf>
18000339a:     	incl	%eax
18000339c:     	movl	%eax, (%r14)
18000339f:     	movq	0xb0(%rsp), %rcx
1800033a7:     	leaq	0x25ba(%rip), %rdx      # 0x180005968
1800033ae:     	movq	%r14, 0x18(%rbx)
1800033b2:     	movq	$0x0, 0x40(%rbx)
1800033ba:     	callq	*0x1da0(%rip)           # 0x180005160
1800033c0:     	movq	%rax, %rsi
1800033c3:     	testq	%rax, %rax
1800033c6:     	jne	0x1800033eb <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x101b>
1800033c8:     	movl	(%rbx), %eax
1800033ca:     	testl	%eax, %eax
1800033cc:     	js	0x180003236 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe66>
1800033d2:     	subl	$0x1, %eax
1800033d5:     	movl	%eax, (%rbx)
1800033d7:     	jne	0x180003236 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe66>
1800033dd:     	movq	%rbx, %rcx
1800033e0:     	callq	*0x1dca(%rip)           # 0x1800051b0
1800033e6:     	jmp	0x180003236 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe66>
1800033eb:     	xorl	%r9d, %r9d
1800033ee:     	leaq	0x20(%rbx), %rcx
1800033f2:     	movq	%rsi, %r8
1800033f5:     	movq	%rbx, %rdx
1800033f8:     	callq	*0x1d42(%rip)           # 0x180005140
1800033fe:     	movq	%rax, %rdi
180003401:     	movl	(%rbx), %eax
180003403:     	testl	%eax, %eax
180003405:     	js	0x180003417 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1047>
180003407:     	subl	$0x1, %eax
18000340a:     	movl	%eax, (%rbx)
18000340c:     	jne	0x180003417 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1047>
18000340e:     	movq	%rbx, %rcx
180003411:     	callq	*0x1d99(%rip)           # 0x1800051b0
180003417:     	movl	(%rsi), %eax
180003419:     	testl	%eax, %eax
18000341b:     	js	0x180003238 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe68>
180003421:     	subl	$0x1, %eax
180003424:     	movl	%eax, (%rsi)
180003426:     	jne	0x180003238 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe68>
18000342c:     	movq	%rsi, %rcx
18000342f:     	callq	*0x1d7b(%rip)           # 0x1800051b0
180003435:     	jmp	0x180003238 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xe68>
18000343a:     	testl	%ecx, %ecx
18000343c:     	js	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
18000343e:     	leal	-0x1(%rcx), %eax
180003441:     	movl	%eax, (%rdi)
180003443:     	testl	%eax, %eax
180003445:     	jne	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
180003447:     	movq	%rdi, %rcx
18000344a:     	callq	*0x1d60(%rip)           # 0x1800051b0
180003450:     	movq	0x20(%rsp), %r12
180003455:     	movl	(%r12), %eax
180003459:     	testl	%eax, %eax
18000345b:     	js	0x18000346f <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x109f>
18000345d:     	subl	$0x1, %eax
180003460:     	movl	%eax, (%r12)
180003464:     	jne	0x18000346f <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x109f>
180003466:     	movq	%r12, %rcx
180003469:     	callq	*0x1d41(%rip)           # 0x1800051b0
18000346f:     	movq	0x28(%rsp), %rdi
180003474:     	movl	(%rdi), %eax
180003476:     	testl	%eax, %eax
180003478:     	js	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
18000347e:     	subl	$0x1, %eax
180003481:     	movl	%eax, (%rdi)
180003483:     	jne	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
180003489:     	movq	%rdi, %rcx
18000348c:     	callq	*0x1d1e(%rip)           # 0x1800051b0
180003492:     	jmp	0x180002f74 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0xba4>
180003497:     	movl	(%r14), %eax
18000349a:     	testl	%eax, %eax
18000349c:     	js	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
18000349e:     	subl	$0x1, %eax
1800034a1:     	movl	%eax, (%r14)
1800034a4:     	jne	0x180003450 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x1080>
1800034a6:     	movq	%r14, %rcx
1800034a9:     	jmp	0x18000344a <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x107a>
1800034ab:     	int3
1800034ac:     	int3
1800034ad:     	int3
1800034ae:     	int3
1800034af:     	int3
1800034b0:     	leaq	0x87b9(%rip), %rax      # 0x18000bc70
1800034b7:     	retq
1800034b8:     	int3
1800034b9:     	int3
1800034ba:     	int3
1800034bb:     	int3
1800034bc:     	int3
1800034bd:     	int3
1800034be:     	int3
1800034bf:     	int3

00000001800034c0 <numba_list_set_method_table>:
1800034c0:     	movups	(%rdx), %xmm0
1800034c3:     	movups	%xmm0, 0x20(%rcx)
1800034c7:     	retq
1800034c8:     	int3
1800034c9:     	int3
1800034ca:     	int3
1800034cb:     	int3
1800034cc:     	int3
1800034cd:     	int3
1800034ce:     	int3
1800034cf:     	int3

00000001800034d0 <numba_list_new>:
1800034d0:     	pushq	%rbx
1800034d2:     	pushq	%rbp
1800034d3:     	pushq	%rsi
1800034d4:     	pushq	%rdi
1800034d5:     	subq	$0x28, %rsp
1800034d9:     	movq	%rcx, %rsi
1800034dc:     	movq	%r8, %rdi
1800034df:     	movl	$0x38, %ecx
1800034e4:     	movq	%rdx, %rbp
1800034e7:     	callq	*0x1b73(%rip)           # 0x180005060
1800034ed:     	movq	%rax, %rbx
1800034f0:     	testq	%rax, %rax
1800034f3:     	je	0x18000355d <numba_list_new+0x8d>
1800034f5:     	movq	$0x0, (%rax)
1800034fc:     	xorps	%xmm0, %xmm0
1800034ff:     	movq	%rbp, 0x8(%rax)
180003503:     	movq	%rdi, 0x10(%rax)
180003507:     	movl	$0x1, 0x18(%rax)
18000350e:     	movups	%xmm0, 0x20(%rax)
180003512:     	testq	%rdi, %rdi
180003515:     	je	0x18000356b <numba_list_new+0x9b>
180003517:     	imulq	%rbp, %rdi
18000351b:     	movl	$0x8, %ecx
180003520:     	movq	%rdi, %rax
180003523:     	cqto
180003525:     	andl	$0x7, %edx
180003528:     	addq	%rdx, %rax
18000352b:     	andl	$0x7, %eax
18000352e:     	subq	%rdx, %rax
180003531:     	subq	%rax, %rcx
180003534:     	movq	%rcx, %rax
180003537:     	cqto
180003539:     	andl	$0x7, %edx
18000353c:     	leaq	(%rdx,%rax), %rcx
180003540:     	andl	$0x7, %ecx
180003543:     	subq	%rdx, %rcx
180003546:     	addq	%rdi, %rcx
180003549:     	callq	*0x1b11(%rip)           # 0x180005060
18000354f:     	testq	%rax, %rax
180003552:     	jne	0x18000356d <numba_list_new+0x9d>
180003554:     	movq	%rbx, %rcx
180003557:     	callq	*0x1b0b(%rip)           # 0x180005068
18000355d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180003562:     	addq	$0x28, %rsp
180003566:     	popq	%rdi
180003567:     	popq	%rsi
180003568:     	popq	%rbp
180003569:     	popq	%rbx
18000356a:     	retq
18000356b:     	xorl	%eax, %eax
18000356d:     	movq	%rax, 0x30(%rbx)
180003571:     	xorl	%eax, %eax
180003573:     	movq	%rbx, (%rsi)
180003576:     	addq	$0x28, %rsp
18000357a:     	popq	%rdi
18000357b:     	popq	%rsi
18000357c:     	popq	%rbp
18000357d:     	popq	%rbx
18000357e:     	retq
18000357f:     	int3

0000000180003580 <numba_list_free>:
180003580:     	pushq	%rbx
180003582:     	subq	$0x20, %rsp
180003586:     	cmpq	$0x0, 0x28(%rcx)
18000358b:     	movq	%rcx, %rbx
18000358e:     	je	0x1800035c4 <numba_list_free+0x44>
180003590:     	movq	%rdi, 0x30(%rsp)
180003595:     	xorl	%edi, %edi
180003597:     	cmpq	%rdi, (%rcx)
18000359a:     	jle	0x1800035bf <numba_list_free+0x3f>
18000359c:     	nopl	(%rax)
1800035a0:     	movq	0x28(%rbx), %rax
1800035a4:     	testq	%rax, %rax
1800035a7:     	je	0x1800035b7 <numba_list_free+0x37>
1800035a9:     	movq	%rdi, %rcx
1800035ac:     	imulq	0x8(%rbx), %rcx
1800035b1:     	addq	0x30(%rbx), %rcx
1800035b5:     	callq	*%rax
1800035b7:     	incq	%rdi
1800035ba:     	cmpq	(%rbx), %rdi
1800035bd:     	jl	0x1800035a0 <numba_list_free+0x20>
1800035bf:     	movq	0x30(%rsp), %rdi
1800035c4:     	movq	0x30(%rbx), %rcx
1800035c8:     	testq	%rcx, %rcx
1800035cb:     	je	0x1800035d3 <numba_list_free+0x53>
1800035cd:     	callq	*0x1a95(%rip)           # 0x180005068
1800035d3:     	movq	%rbx, %rcx
1800035d6:     	addq	$0x20, %rsp
1800035da:     	popq	%rbx
1800035db:     	jmpq	*0x1a86(%rip)           # 0x180005068
1800035e2:     	int3
1800035e3:     	int3
1800035e4:     	int3
1800035e5:     	int3
1800035e6:     	int3
1800035e7:     	int3
1800035e8:     	int3
1800035e9:     	int3
1800035ea:     	int3
1800035eb:     	int3
1800035ec:     	int3
1800035ed:     	int3
1800035ee:     	int3
1800035ef:     	int3

00000001800035f0 <numba_list_base_ptr>:
1800035f0:     	movq	0x30(%rcx), %rax
1800035f4:     	retq
1800035f5:     	int3
1800035f6:     	int3
1800035f7:     	int3
1800035f8:     	int3
1800035f9:     	int3
1800035fa:     	int3
1800035fb:     	int3
1800035fc:     	int3
1800035fd:     	int3
1800035fe:     	int3
1800035ff:     	int3

0000000180003600 <numba_list_size_address>:
180003600:     	movq	%rcx, %rax
180003603:     	retq
180003604:     	int3
180003605:     	int3
180003606:     	int3
180003607:     	int3
180003608:     	int3
180003609:     	int3
18000360a:     	int3
18000360b:     	int3
18000360c:     	int3
18000360d:     	int3
18000360e:     	int3
18000360f:     	int3

0000000180003610 <numba_list_length>:
180003610:     	movq	(%rcx), %rax
180003613:     	retq
180003614:     	int3
180003615:     	int3
180003616:     	int3
180003617:     	int3
180003618:     	int3
180003619:     	int3
18000361a:     	int3
18000361b:     	int3
18000361c:     	int3
18000361d:     	int3
18000361e:     	int3
18000361f:     	int3

0000000180003620 <numba_list_allocated>:
180003620:     	movq	0x10(%rcx), %rax
180003624:     	retq
180003625:     	int3
180003626:     	int3
180003627:     	int3
180003628:     	int3
180003629:     	int3
18000362a:     	int3
18000362b:     	int3
18000362c:     	int3
18000362d:     	int3
18000362e:     	int3
18000362f:     	int3

0000000180003630 <numba_list_is_mutable>:
180003630:     	movl	0x18(%rcx), %eax
180003633:     	retq
180003634:     	int3
180003635:     	int3
180003636:     	int3
180003637:     	int3
180003638:     	int3
180003639:     	int3
18000363a:     	int3
18000363b:     	int3
18000363c:     	int3
18000363d:     	int3
18000363e:     	int3
18000363f:     	int3

0000000180003640 <numba_list_set_is_mutable>:
180003640:     	movl	%edx, 0x18(%rcx)
180003643:     	retq
180003644:     	int3
180003645:     	int3
180003646:     	int3
180003647:     	int3
180003648:     	int3
180003649:     	int3
18000364a:     	int3
18000364b:     	int3
18000364c:     	int3
18000364d:     	int3
18000364e:     	int3
18000364f:     	int3

0000000180003650 <numba_list_setitem>:
180003650:     	movq	%rbx, 0x10(%rsp)
180003655:     	pushq	%rsi
180003656:     	subq	$0x20, %rsp
18000365a:     	cmpl	$0x0, 0x18(%rcx)
18000365e:     	movq	%r8, %rsi
180003661:     	movq	%rcx, %rbx
180003664:     	jne	0x180003676 <numba_list_setitem+0x26>
180003666:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000366b:     	movq	0x38(%rsp), %rbx
180003670:     	addq	$0x20, %rsp
180003674:     	popq	%rsi
180003675:     	retq
180003676:     	cmpq	(%rcx), %rdx
180003679:     	jb	0x18000368b <numba_list_setitem+0x3b>
18000367b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180003680:     	movq	0x38(%rsp), %rbx
180003685:     	addq	$0x20, %rsp
180003689:     	popq	%rsi
18000368a:     	retq
18000368b:     	imulq	0x8(%rcx), %rdx
180003690:     	movq	0x28(%rcx), %rax
180003694:     	movq	%rdi, 0x30(%rsp)
180003699:     	movq	0x30(%rcx), %rdi
18000369d:     	addq	%rdx, %rdi
1800036a0:     	testq	%rax, %rax
1800036a3:     	je	0x1800036aa <numba_list_setitem+0x5a>
1800036a5:     	movq	%rdi, %rcx
1800036a8:     	callq	*%rax
1800036aa:     	movq	0x8(%rbx), %r8
1800036ae:     	movq	%rsi, %rdx
1800036b1:     	movq	%rdi, %rcx
1800036b4:     	callq	0x180004a13 <numba_list_iter_next+0xe73>
1800036b9:     	movq	0x20(%rbx), %rax
1800036bd:     	testq	%rax, %rax
1800036c0:     	je	0x1800036c7 <numba_list_setitem+0x77>
1800036c2:     	movq	%rdi, %rcx
1800036c5:     	callq	*%rax
1800036c7:     	movq	0x30(%rsp), %rdi
1800036cc:     	xorl	%eax, %eax
1800036ce:     	movq	0x38(%rsp), %rbx
1800036d3:     	addq	$0x20, %rsp
1800036d7:     	popq	%rsi
1800036d8:     	retq
1800036d9:     	int3
1800036da:     	int3
1800036db:     	int3
1800036dc:     	int3
1800036dd:     	int3
1800036de:     	int3
1800036df:     	int3

00000001800036e0 <numba_list_getitem>:
1800036e0:     	subq	$0x28, %rsp
1800036e4:     	movq	%r8, %r9
1800036e7:     	movq	%rdx, %rax
1800036ea:     	cmpq	(%rcx), %rdx
1800036ed:     	jb	0x1800036f9 <numba_list_getitem+0x19>
1800036ef:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800036f4:     	addq	$0x28, %rsp
1800036f8:     	retq
1800036f9:     	movq	0x8(%rcx), %r8
1800036fd:     	movq	%r8, %rdx
180003700:     	imulq	%rax, %rdx
180003704:     	addq	0x30(%rcx), %rdx
180003708:     	movq	%r9, %rcx
18000370b:     	callq	0x180004a13 <numba_list_iter_next+0xe73>
180003710:     	xorl	%eax, %eax
180003712:     	addq	$0x28, %rsp
180003716:     	retq
180003717:     	int3
180003718:     	int3
180003719:     	int3
18000371a:     	int3
18000371b:     	int3
18000371c:     	int3
18000371d:     	int3
18000371e:     	int3
18000371f:     	int3

0000000180003720 <numba_list_append>:
180003720:     	movq	%rbx, 0x10(%rsp)
180003725:     	pushq	%rsi
180003726:     	subq	$0x20, %rsp
18000372a:     	cmpl	$0x0, 0x18(%rcx)
18000372e:     	movq	%rdx, %rsi
180003731:     	movq	%rcx, %rbx
180003734:     	jne	0x180003746 <numba_list_append+0x26>
180003736:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000373b:     	movq	0x38(%rsp), %rbx
180003740:     	addq	$0x20, %rsp
180003744:     	popq	%rsi
180003745:     	retq
180003746:     	movq	(%rcx), %rdx
180003749:     	incq	%rdx
18000374c:     	callq	0x1800037a0 <numba_list_resize>
180003751:     	testl	%eax, %eax
180003753:     	js	0x18000378c <numba_list_append+0x6c>
180003755:     	movq	0x8(%rbx), %r8
180003759:     	movq	%rsi, %rdx
18000375c:     	movq	%rdi, 0x30(%rsp)
180003761:     	movq	(%rbx), %rdi
180003764:     	decq	%rdi
180003767:     	imulq	%r8, %rdi
18000376b:     	addq	0x30(%rbx), %rdi
18000376f:     	movq	%rdi, %rcx
180003772:     	callq	0x180004a13 <numba_list_iter_next+0xe73>
180003777:     	movq	0x20(%rbx), %rax
18000377b:     	testq	%rax, %rax
18000377e:     	je	0x180003785 <numba_list_append+0x65>
180003780:     	movq	%rdi, %rcx
180003783:     	callq	*%rax
180003785:     	movq	0x30(%rsp), %rdi
18000378a:     	xorl	%eax, %eax
18000378c:     	movq	0x38(%rsp), %rbx
180003791:     	addq	$0x20, %rsp
180003795:     	popq	%rsi
180003796:     	retq
180003797:     	int3
180003798:     	int3
180003799:     	int3
18000379a:     	int3
18000379b:     	int3
18000379c:     	int3
18000379d:     	int3
18000379e:     	int3
18000379f:     	int3

00000001800037a0 <numba_list_resize>:
1800037a0:     	movq	%rsi, 0x18(%rsp)
1800037a5:     	pushq	%rdi
1800037a6:     	subq	$0x20, %rsp
1800037aa:     	cmpl	$0x0, 0x18(%rcx)
1800037ae:     	movq	%rdx, %rsi
1800037b1:     	movq	%rcx, %rdi
1800037b4:     	jne	0x1800037c6 <numba_list_resize+0x26>
1800037b6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800037bb:     	movq	0x40(%rsp), %rsi
1800037c0:     	addq	$0x20, %rsp
1800037c4:     	popq	%rdi
1800037c5:     	retq
1800037c6:     	movq	0x10(%rcx), %rax
1800037ca:     	cmpq	%rsi, %rax
1800037cd:     	jl	0x1800037e7 <numba_list_resize+0x47>
1800037cf:     	sarq	%rax
1800037d2:     	cmpq	%rax, %rsi
1800037d5:     	jl	0x1800037e7 <numba_list_resize+0x47>
1800037d7:     	movq	%rsi, (%rcx)
1800037da:     	xorl	%eax, %eax
1800037dc:     	movq	0x40(%rsp), %rsi
1800037e1:     	addq	$0x20, %rsp
1800037e5:     	popq	%rdi
1800037e6:     	retq
1800037e7:     	cmpq	$0x9, %rsi
1800037eb:     	movq	%rbp, 0x38(%rsp)
1800037f0:     	movl	$0x3, %ecx
1800037f5:     	movl	$0x6, %eax
1800037fa:     	cmovll	%ecx, %eax
1800037fd:     	movq	%rsi, %r8
180003800:     	movq	0x8(%rdi), %rcx
180003804:     	addq	%rsi, %rax
180003807:     	sarq	$0x3, %r8
18000380b:     	xorl	%edx, %edx
18000380d:     	addq	%rax, %r8
180003810:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000381a:     	divq	%rcx
18000381d:     	cmpq	%rax, %r8
180003820:     	ja	0x18000389b <numba_list_resize+0xfb>
180003822:     	xorl	%ebp, %ebp
180003824:     	movq	%rbx, 0x30(%rsp)
180003829:     	testq	%rsi, %rsi
18000382c:     	cmovneq	%r8, %rbp
180003830:     	movq	%rbp, %rbx
180003833:     	imulq	%rcx, %rbx
180003837:     	movl	$0x8, %ecx
18000383c:     	movq	%rbx, %rax
18000383f:     	cqto
180003841:     	andl	$0x7, %edx
180003844:     	addq	%rdx, %rax
180003847:     	andl	$0x7, %eax
18000384a:     	subq	%rdx, %rax
18000384d:     	subq	%rax, %rcx
180003850:     	movq	%rcx, %rax
180003853:     	movq	0x30(%rdi), %rcx
180003857:     	cqto
180003859:     	andl	$0x7, %edx
18000385c:     	addq	%rdx, %rax
18000385f:     	andl	$0x7, %eax
180003862:     	subq	%rdx, %rax
180003865:     	leaq	(%rbx,%rax), %rdx
180003869:     	callq	*0x1801(%rip)           # 0x180005070
18000386f:     	testq	%rbx, %rbx
180003872:     	movq	0x30(%rsp), %rbx
180003877:     	je	0x18000387e <numba_list_resize+0xde>
180003879:     	testq	%rax, %rax
18000387c:     	je	0x18000389b <numba_list_resize+0xfb>
18000387e:     	movq	%rax, 0x30(%rdi)
180003882:     	xorl	%eax, %eax
180003884:     	movq	%rbp, 0x10(%rdi)
180003888:     	movq	0x38(%rsp), %rbp
18000388d:     	movq	%rsi, (%rdi)
180003890:     	movq	0x40(%rsp), %rsi
180003895:     	addq	$0x20, %rsp
180003899:     	popq	%rdi
18000389a:     	retq
18000389b:     	movq	0x38(%rsp), %rbp
1800038a0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800038a5:     	movq	0x40(%rsp), %rsi
1800038aa:     	addq	$0x20, %rsp
1800038ae:     	popq	%rdi
1800038af:     	retq

00000001800038b0 <numba_list_delitem>:
1800038b0:     	movq	%rbx, 0x10(%rsp)
1800038b5:     	pushq	%rdi
1800038b6:     	subq	$0x20, %rsp
1800038ba:     	cmpl	$0x0, 0x18(%rcx)
1800038be:     	movq	%rdx, %rdi
1800038c1:     	movq	%rcx, %rbx
1800038c4:     	jne	0x1800038d6 <numba_list_delitem+0x26>
1800038c6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800038cb:     	movq	0x38(%rsp), %rbx
1800038d0:     	addq	$0x20, %rsp
1800038d4:     	popq	%rdi
1800038d5:     	retq
1800038d6:     	cmpq	(%rcx), %rdi
1800038d9:     	jb	0x1800038eb <numba_list_delitem+0x3b>
1800038db:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800038e0:     	movq	0x38(%rsp), %rbx
1800038e5:     	addq	$0x20, %rsp
1800038e9:     	popq	%rdi
1800038ea:     	retq
1800038eb:     	movq	0x28(%rcx), %rax
1800038ef:     	movq	%rsi, 0x30(%rsp)
1800038f4:     	movq	%rdi, %rsi
1800038f7:     	imulq	0x8(%rcx), %rsi
1800038fc:     	addq	0x30(%rcx), %rsi
180003900:     	testq	%rax, %rax
180003903:     	je	0x18000390a <numba_list_delitem+0x5a>
180003905:     	movq	%rsi, %rcx
180003908:     	callq	*%rax
18000390a:     	movq	(%rbx), %r8
18000390d:     	leaq	-0x1(%r8), %rax
180003911:     	cmpq	%rax, %rdi
180003914:     	je	0x180003936 <numba_list_delitem+0x86>
180003916:     	subq	%rdi, %r8
180003919:     	leaq	0x1(%rdi), %rdx
18000391d:     	imulq	0x8(%rbx), %rdx
180003922:     	decq	%r8
180003925:     	movq	%rsi, %rcx
180003928:     	imulq	0x8(%rbx), %r8
18000392d:     	addq	0x30(%rbx), %rdx
180003931:     	callq	0x180004a19 <numba_list_iter_next+0xe79>
180003936:     	movq	(%rbx), %rdx
180003939:     	movq	%rbx, %rcx
18000393c:     	decq	%rdx
18000393f:     	callq	0x1800037a0 <numba_list_resize>
180003944:     	movq	0x30(%rsp), %rsi
180003949:     	xorl	%ecx, %ecx
18000394b:     	movq	0x38(%rsp), %rbx
180003950:     	testl	%eax, %eax
180003952:     	cmovsl	%eax, %ecx
180003955:     	movl	%ecx, %eax
180003957:     	addq	$0x20, %rsp
18000395b:     	popq	%rdi
18000395c:     	retq
18000395d:     	int3
18000395e:     	int3
18000395f:     	int3

0000000180003960 <numba_list_delete_slice>:
180003960:     	pushq	%rbx
180003962:     	pushq	%rbp
180003963:     	pushq	%rdi
180003964:     	pushq	%r15
180003966:     	subq	$0x38, %rsp
18000396a:     	cmpl	$0x0, 0x18(%rcx)
18000396e:     	movq	%r9, %rdi
180003971:     	movq	%r8, %rbp
180003974:     	movq	%rdx, %r15
180003977:     	movq	%rcx, %rbx
18000397a:     	jne	0x18000398b <numba_list_delete_slice+0x2b>
18000397c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180003981:     	addq	$0x38, %rsp
180003985:     	popq	%r15
180003987:     	popq	%rdi
180003988:     	popq	%rbp
180003989:     	popq	%rbx
18000398a:     	retq
18000398b:     	movq	%r13, 0x78(%rsp)
180003990:     	testq	%rdi, %rdi
180003993:     	jle	0x1800039b2 <numba_list_delete_slice+0x52>
180003995:     	cmpq	%r8, %r15
180003998:     	jge	0x180003b51 <numba_list_delete_slice+0x1f1>
18000399e:     	movq	%r8, %rax
1800039a1:     	subq	%r15, %rax
1800039a4:     	decq	%rax
1800039a7:     	cqto
1800039a9:     	idivq	%rdi
1800039ac:     	leal	0x1(%rax), %r13d
1800039b0:     	jmp	0x1800039d2 <numba_list_delete_slice+0x72>
1800039b2:     	cmpq	%r15, %r8
1800039b5:     	jge	0x180003b51 <numba_list_delete_slice+0x1f1>
1800039bb:     	movq	%r15, %rax
1800039be:     	movl	$0x1, %r13d
1800039c4:     	subq	%r8, %rax
1800039c7:     	decq	%rax
1800039ca:     	cqto
1800039cc:     	idivq	%rdi
1800039cf:     	subl	%eax, %r13d
1800039d2:     	testl	%r13d, %r13d
1800039d5:     	jle	0x180003b51 <numba_list_delete_slice+0x1f1>
1800039db:     	movq	%rsi, 0x68(%rsp)
1800039e0:     	movl	(%rcx), %esi
1800039e2:     	subl	%r13d, %esi
1800039e5:     	movl	%esi, 0x20(%rsp)
1800039e9:     	testq	%rdi, %rdi
1800039ec:     	jns	0x180003a07 <numba_list_delete_slice+0xa7>
1800039ee:     	leaq	0x1(%r15), %rbp
1800039f2:     	leal	-0x1(%r13), %eax
1800039f6:     	movslq	%eax, %rcx
1800039f9:     	leaq	-0x1(%rbp), %r15
1800039fd:     	imulq	%rdi, %rcx
180003a01:     	addq	%rcx, %r15
180003a04:     	negq	%rdi
180003a07:     	cmpq	$0x1, %rdi
180003a0b:     	jne	0x180003a57 <numba_list_delete_slice+0xf7>
180003a0d:     	cmpq	$0x0, 0x28(%rbx)
180003a12:     	je	0x180003a39 <numba_list_delete_slice+0xd9>
180003a14:     	movslq	%r15d, %rdi
180003a17:     	cmpq	%rbp, %rdi
180003a1a:     	jge	0x180003a39 <numba_list_delete_slice+0xd9>
180003a1c:     	nopl	(%rax)
180003a20:     	movslq	%edi, %rcx
180003a23:     	imulq	0x8(%rbx), %rcx
180003a28:     	addq	0x30(%rbx), %rcx
180003a2c:     	callq	*0x28(%rbx)
180003a2f:     	incl	%edi
180003a31:     	movslq	%edi, %rax
180003a34:     	cmpq	%rbp, %rax
180003a37:     	jl	0x180003a20 <numba_list_delete_slice+0xc0>
180003a39:     	movq	0x8(%rbx), %rcx
180003a3d:     	movq	(%rbx), %r8
180003a40:     	movq	%rcx, %rdx
180003a43:     	subq	%rbp, %r8
180003a46:     	imulq	%rcx, %r8
180003a4a:     	imulq	%rbp, %rdx
180003a4e:     	imulq	%r15, %rcx
180003a52:     	jmp	0x180003b1c <numba_list_delete_slice+0x1bc>
180003a57:     	movq	%r14, 0x30(%rsp)
180003a5c:     	movq	%r15, %r14
180003a5f:     	movl	$0x0, 0x60(%rsp)
180003a67:     	cmpq	%rbp, %r15
180003a6a:     	jge	0x180003ae9 <numba_list_delete_slice+0x189>
180003a6c:     	movq	%r12, 0x70(%rsp)
180003a71:     	movq	(%rbx), %rax
180003a74:     	leaq	(%r14,%rdi), %r12
180003a78:     	cmpq	%rax, %r12
180003a7b:     	jl	0x180003a88 <numba_list_delete_slice+0x128>
180003a7d:     	movq	%r14, %rsi
180003a80:     	notq	%rsi
180003a83:     	addq	%rax, %rsi
180003a86:     	jmp	0x180003a8c <numba_list_delete_slice+0x12c>
180003a88:     	leaq	-0x1(%rdi), %rsi
180003a8c:     	movq	0x28(%rbx), %rax
180003a90:     	testq	%rax, %rax
180003a93:     	je	0x180003aa3 <numba_list_delete_slice+0x143>
180003a95:     	movq	%r14, %rcx
180003a98:     	imulq	0x8(%rbx), %rcx
180003a9d:     	addq	0x30(%rbx), %rcx
180003aa1:     	callq	*%rax
180003aa3:     	movq	0x8(%rbx), %r9
180003aa7:     	leaq	0x1(%r14), %rdx
180003aab:     	movq	0x30(%rbx), %r10
180003aaf:     	movq	%r9, %r8
180003ab2:     	imulq	%rsi, %r8
180003ab6:     	imulq	%r9, %rdx
180003aba:     	movslq	0x60(%rsp), %rsi
180003abf:     	subq	%rsi, %r14
180003ac2:     	imulq	%r9, %r14
180003ac6:     	addq	%r10, %rdx
180003ac9:     	leaq	(%r10,%r14), %rcx
180003acd:     	callq	0x180004a19 <numba_list_iter_next+0xe79>
180003ad2:     	incl	%esi
180003ad4:     	movq	%r12, %r14
180003ad7:     	movl	%esi, 0x60(%rsp)
180003adb:     	cmpq	%rbp, %r12
180003ade:     	jl	0x180003a71 <numba_list_delete_slice+0x111>
180003ae0:     	movq	0x70(%rsp), %r12
180003ae5:     	movl	0x20(%rsp), %esi
180003ae9:     	movq	(%rbx), %r8
180003aec:     	movq	0x30(%rsp), %r14
180003af1:     	movslq	%r13d, %r10
180003af4:     	movq	%r10, %rcx
180003af7:     	imulq	%rdi, %rcx
180003afb:     	addq	%r15, %rcx
180003afe:     	cmpq	%r8, %rcx
180003b01:     	jge	0x180003b29 <numba_list_delete_slice+0x1c9>
180003b03:     	movq	0x8(%rbx), %rax
180003b07:     	subq	%rcx, %r8
180003b0a:     	movq	%rax, %rdx
180003b0d:     	imulq	%rcx, %rdx
180003b11:     	imulq	%rax, %r8
180003b15:     	subq	%r10, %rcx
180003b18:     	imulq	%rax, %rcx
180003b1c:     	addq	0x30(%rbx), %rdx
180003b20:     	addq	0x30(%rbx), %rcx
180003b24:     	callq	0x180004a19 <numba_list_iter_next+0xe79>
180003b29:     	movslq	%esi, %rdx
180003b2c:     	movq	%rbx, %rcx
180003b2f:     	callq	0x1800037a0 <numba_list_resize>
180003b34:     	movq	0x68(%rsp), %rsi
180003b39:     	xorl	%ecx, %ecx
180003b3b:     	movq	0x78(%rsp), %r13
180003b40:     	testl	%eax, %eax
180003b42:     	cmovsl	%eax, %ecx
180003b45:     	movl	%ecx, %eax
180003b47:     	addq	$0x38, %rsp
180003b4b:     	popq	%r15
180003b4d:     	popq	%rdi
180003b4e:     	popq	%rbp
180003b4f:     	popq	%rbx
180003b50:     	retq
180003b51:     	movq	0x78(%rsp), %r13
180003b56:     	xorl	%eax, %eax
180003b58:     	addq	$0x38, %rsp
180003b5c:     	popq	%r15
180003b5e:     	popq	%rdi
180003b5f:     	popq	%rbp
180003b60:     	popq	%rbx
180003b61:     	retq
180003b62:     	int3
180003b63:     	int3
180003b64:     	int3
180003b65:     	int3
180003b66:     	int3
180003b67:     	int3
180003b68:     	int3
180003b69:     	int3
180003b6a:     	int3
180003b6b:     	int3
180003b6c:     	int3
180003b6d:     	int3
180003b6e:     	int3
180003b6f:     	int3

0000000180003b70 <numba_list_iter_sizeof>:
180003b70:     	movl	$0x18, %eax
180003b75:     	retq
180003b76:     	int3
180003b77:     	int3
180003b78:     	int3
180003b79:     	int3
180003b7a:     	int3
180003b7b:     	int3
180003b7c:     	int3
180003b7d:     	int3
180003b7e:     	int3
180003b7f:     	int3

0000000180003b80 <numba_list_iter>:
180003b80:     	movq	%rdx, (%rcx)
180003b83:     	movq	(%rdx), %rax
180003b86:     	movq	%rax, 0x8(%rcx)
180003b8a:     	movq	$0x0, 0x10(%rcx)
180003b92:     	retq
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

0000000180003ba0 <numba_list_iter_next>:
180003ba0:     	movq	(%rcx), %r8
180003ba3:     	movq	(%r8), %r9
180003ba6:     	cmpq	0x8(%rcx), %r9
180003baa:     	je	0x180003bb2 <numba_list_iter_next+0x12>
180003bac:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180003bb1:     	retq
180003bb2:     	movq	0x10(%rcx), %rax
180003bb6:     	cmpq	%r9, %rax
180003bb9:     	jge	0x180003bce <numba_list_iter_next+0x2e>
180003bbb:     	imulq	0x8(%r8), %rax
180003bc0:     	addq	0x30(%r8), %rax
180003bc4:     	movq	%rax, (%rdx)
180003bc7:     	incq	0x10(%rcx)
180003bcb:     	xorl	%eax, %eax
180003bcd:     	retq
180003bce:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180003bd3:     	retq
180003bd4:     	int3
180003bd5:     	int3
180003bd6:     	int3
180003bd7:     	int3
180003bd8:     	int3
180003bd9:     	int3
180003bda:     	int3
180003bdb:     	int3
180003bdc:     	int3
180003bdd:     	int3
180003bde:     	int3
180003bdf:     	int3
180003be0:     	pushq	%rbx
180003be2:     	subq	$0x20, %rsp
180003be6:     	movq	%rcx, %rbx
180003be9:     	addq	$0x30, %rcx
180003bed:     	callq	*0x8035(%rip)           # 0x18000bc28
180003bf3:     	cmpb	$0x0, 0x8006(%rip)      # 0x18000bc00
180003bfa:     	je	0x180003c04 <numba_list_iter_next+0x64>
180003bfc:     	lock
180003bfd:     	incq	0x8004(%rip)            # 0x18000bc08
180003c04:     	testq	%rax, %rax
180003c07:     	je	0x180003c48 <numba_list_iter_next+0xa8>
180003c09:     	leaq	0x30(%rax), %rdx
180003c0d:     	testq	%rdx, %rdx
180003c10:     	je	0x180003c48 <numba_list_iter_next+0xa8>
180003c12:     	xorl	%r8d, %r8d
180003c15:     	movl	$0x1, %ecx
180003c1a:     	xchgq	%rcx, (%rax)
180003c1d:     	movq	%r8, 0x8(%rax)
180003c21:     	movq	%r8, 0x10(%rax)
180003c25:     	movq	%rdx, 0x18(%rax)
180003c29:     	movq	%rbx, 0x20(%rax)
180003c2d:     	movq	%r8, 0x28(%rax)
180003c31:     	cmpb	%r8b, 0x7fc8(%rip)      # 0x18000bc00
180003c38:     	je	0x180003c4a <numba_list_iter_next+0xaa>
180003c3a:     	lock
180003c3b:     	incq	0x7fd6(%rip)            # 0x18000bc18
180003c42:     	addq	$0x20, %rsp
180003c46:     	popq	%rbx
180003c47:     	retq
180003c48:     	xorl	%eax, %eax
180003c4a:     	addq	$0x20, %rsp
180003c4e:     	popq	%rbx
180003c4f:     	retq
180003c50:     	movq	%rbx, 0x8(%rsp)
180003c55:     	pushq	%rdi
180003c56:     	subq	$0x20, %rsp
180003c5a:     	movq	%rcx, %rdi
180003c5d:     	movq	%rdx, %rbx
180003c60:     	addq	$0x30, %rcx
180003c64:     	testq	%rdx, %rdx
180003c67:     	je	0x180003c71 <numba_list_iter_next+0xd1>
180003c69:     	movq	0x18(%rdx), %rdx
180003c6d:     	callq	*(%rbx)
180003c6f:     	jmp	0x180003c77 <numba_list_iter_next+0xd7>
180003c71:     	callq	*0x7fb1(%rip)           # 0x18000bc28
180003c77:     	cmpb	$0x0, 0x7f82(%rip)      # 0x18000bc00
180003c7e:     	movq	%rax, %r8
180003c81:     	je	0x180003c8b <numba_list_iter_next+0xeb>
180003c83:     	lock
180003c84:     	incq	0x7f7d(%rip)            # 0x18000bc08
180003c8b:     	xorl	%edx, %edx
180003c8d:     	leaq	0x30(%r8), %rax
180003c91:     	testq	%r8, %r8
180003c94:     	movl	%edx, %ecx
180003c96:     	cmovneq	%rax, %rcx
180003c9a:     	testq	%rcx, %rcx
180003c9d:     	jne	0x180003cac <numba_list_iter_next+0x10c>
180003c9f:     	xorl	%eax, %eax
180003ca1:     	movq	0x30(%rsp), %rbx
180003ca6:     	addq	$0x20, %rsp
180003caa:     	popq	%rdi
180003cab:     	retq
180003cac:     	movl	$0x1, %eax
180003cb1:     	xchgq	%rax, (%r8)
180003cb4:     	movq	%rdx, 0x8(%r8)
180003cb8:     	movq	%rdx, 0x10(%r8)
180003cbc:     	movq	%rcx, 0x18(%r8)
180003cc0:     	movq	%rdi, 0x20(%r8)
180003cc4:     	movq	%rbx, 0x28(%r8)
180003cc8:     	cmpb	%dl, 0x7f32(%rip)       # 0x18000bc00
180003cce:     	je	0x180003cd8 <numba_list_iter_next+0x138>
180003cd0:     	lock
180003cd1:     	incq	0x7f40(%rip)            # 0x18000bc18
180003cd8:     	movq	0x30(%rsp), %rbx
180003cdd:     	movq	%r8, %rax
180003ce0:     	addq	$0x20, %rsp
180003ce4:     	popq	%rdi
180003ce5:     	retq
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
180003cf0:     	lock
180003cf1:     	incq	(%rcx)
180003cf4:     	retq
180003cf5:     	int3
180003cf6:     	int3
180003cf7:     	int3
180003cf8:     	int3
180003cf9:     	int3
180003cfa:     	int3
180003cfb:     	int3
180003cfc:     	int3
180003cfd:     	int3
180003cfe:     	int3
180003cff:     	int3
180003d00:     	pushq	%rbx
180003d02:     	subq	$0x20, %rsp
180003d06:     	movq	0x8(%rcx), %rax
180003d0a:     	movq	%rcx, %rbx
180003d0d:     	testq	%rax, %rax
180003d10:     	je	0x180003d29 <numba_list_iter_next+0x189>
180003d12:     	cmpl	$0x0, 0x7edf(%rip)      # 0x18000bbf8
180003d19:     	jne	0x180003d29 <numba_list_iter_next+0x189>
180003d1b:     	movq	0x10(%rcx), %r8
180003d1f:     	movq	0x20(%rcx), %rdx
180003d23:     	movq	0x18(%rcx), %rcx
180003d27:     	callq	*%rax
180003d29:     	movq	0x28(%rbx), %rax
180003d2d:     	movq	%rbx, %rcx
180003d30:     	testq	%rax, %rax
180003d33:     	je	0x180003d3e <numba_list_iter_next+0x19e>
180003d35:     	movq	0x18(%rax), %rdx
180003d39:     	callq	*0x10(%rax)
180003d3c:     	jmp	0x180003d44 <numba_list_iter_next+0x1a4>
180003d3e:     	callq	*0x7ef4(%rip)           # 0x18000bc38
180003d44:     	cmpb	$0x0, 0x7eb5(%rip)      # 0x18000bc00
180003d4b:     	je	0x180003d69 <numba_list_iter_next+0x1c9>
180003d4d:     	leaq	0x7ebc(%rip), %rax      # 0x18000bc10
180003d54:     	lock
180003d55:     	incq	(%rax)
180003d58:     	cmpb	$0x0, 0x7ea1(%rip)      # 0x18000bc00
180003d5f:     	je	0x180003d69 <numba_list_iter_next+0x1c9>
180003d61:     	lock
180003d62:     	incq	0x7eb7(%rip)            # 0x18000bc20
180003d69:     	addq	$0x20, %rsp
180003d6d:     	popq	%rbx
180003d6e:     	retq
180003d6f:     	int3
180003d70:     	pushq	%rbx
180003d72:     	subq	$0x20, %rsp
180003d76:     	movq	%rcx, %rbx
180003d79:     	movq	$-0x1, %rax
180003d80:     	lock
180003d81:     	xaddq	%rax, (%rcx)
180003d85:     	cmpq	$0x1, %rax
180003d89:     	jne	0x180003deb <numba_list_iter_next+0x24b>
180003d8b:     	movq	0x8(%rcx), %rax
180003d8f:     	testq	%rax, %rax
180003d92:     	je	0x180003dab <numba_list_iter_next+0x20b>
180003d94:     	cmpl	$0x0, 0x7e5d(%rip)      # 0x18000bbf8
180003d9b:     	jne	0x180003dab <numba_list_iter_next+0x20b>
180003d9d:     	movq	0x10(%rcx), %r8
180003da1:     	movq	0x20(%rcx), %rdx
180003da5:     	movq	0x18(%rcx), %rcx
180003da9:     	callq	*%rax
180003dab:     	movq	0x28(%rbx), %rax
180003daf:     	movq	%rbx, %rcx
180003db2:     	testq	%rax, %rax
180003db5:     	je	0x180003dc0 <numba_list_iter_next+0x220>
180003db7:     	movq	0x18(%rax), %rdx
180003dbb:     	callq	*0x10(%rax)
180003dbe:     	jmp	0x180003dc6 <numba_list_iter_next+0x226>
180003dc0:     	callq	*0x7e72(%rip)           # 0x18000bc38
180003dc6:     	cmpb	$0x0, 0x7e33(%rip)      # 0x18000bc00
180003dcd:     	je	0x180003deb <numba_list_iter_next+0x24b>
180003dcf:     	leaq	0x7e3a(%rip), %rax      # 0x18000bc10
180003dd6:     	lock
180003dd7:     	incq	(%rax)
180003dda:     	cmpb	$0x0, 0x7e1f(%rip)      # 0x18000bc00
180003de1:     	je	0x180003deb <numba_list_iter_next+0x24b>
180003de3:     	lock
180003de4:     	incq	0x7e35(%rip)            # 0x18000bc20
180003deb:     	addq	$0x20, %rsp
180003def:     	popq	%rbx
180003df0:     	retq
180003df1:     	int3
180003df2:     	int3
180003df3:     	int3
180003df4:     	int3
180003df5:     	int3
180003df6:     	int3
180003df7:     	int3
180003df8:     	int3
180003df9:     	int3
180003dfa:     	int3
180003dfb:     	int3
180003dfc:     	int3
180003dfd:     	int3
180003dfe:     	int3
180003dff:     	int3
180003e00:     	movq	0x18(%rcx), %rax
180003e04:     	retq
180003e05:     	int3
180003e06:     	int3
180003e07:     	int3
180003e08:     	int3
180003e09:     	int3
180003e0a:     	int3
180003e0b:     	int3
180003e0c:     	int3
180003e0d:     	int3
180003e0e:     	int3
180003e0f:     	int3
180003e10:     	jmpq	*%r8
180003e13:     	int3
180003e14:     	int3
180003e15:     	int3
180003e16:     	int3
180003e17:     	int3
180003e18:     	int3
180003e19:     	int3
180003e1a:     	int3
180003e1b:     	int3
180003e1c:     	int3
180003e1d:     	int3
180003e1e:     	int3
180003e1f:     	int3
180003e20:     	movq	%rbx, 0x8(%rsp)
180003e25:     	pushq	%rdi
180003e26:     	subq	$0x20, %rsp
180003e2a:     	movq	%rcx, %rdi
180003e2d:     	movq	%rdx, %rbx
180003e30:     	movl	$0x30, %ecx
180003e35:     	callq	*0x7ded(%rip)           # 0x18000bc28
180003e3b:     	cmpb	$0x0, 0x7dbe(%rip)      # 0x18000bc00
180003e42:     	je	0x180003e4c <numba_list_iter_next+0x2ac>
180003e44:     	lock
180003e45:     	incq	0x7dbc(%rip)            # 0x18000bc08
180003e4c:     	testq	%rax, %rax
180003e4f:     	je	0x180003e86 <numba_list_iter_next+0x2e6>
180003e51:     	leaq	-0x48(%rip), %rcx       # 0x180003e10 <numba_list_iter_next+0x270>
180003e58:     	movl	$0x1, %edx
180003e5d:     	xchgq	%rdx, (%rax)
180003e60:     	movq	%rcx, 0x8(%rax)
180003e64:     	xorl	%ecx, %ecx
180003e66:     	movq	%rcx, 0x20(%rax)
180003e6a:     	movq	%rcx, 0x28(%rax)
180003e6e:     	movq	%rbx, 0x10(%rax)
180003e72:     	movq	%rdi, 0x18(%rax)
180003e76:     	cmpb	%cl, 0x7d84(%rip)       # 0x18000bc00
180003e7c:     	je	0x180003e86 <numba_list_iter_next+0x2e6>
180003e7e:     	lock
180003e7f:     	incq	0x7d92(%rip)            # 0x18000bc18
180003e86:     	movq	0x30(%rsp), %rbx
180003e8b:     	addq	$0x20, %rsp
180003e8f:     	popq	%rdi
180003e90:     	retq
180003e91:     	jmpq	*0x13d9(%rip)           # 0x180005270
180003e97:     	jmpq	*0x13c3(%rip)           # 0x180005260
180003e9d:     	jmpq	*0x13b5(%rip)           # 0x180005258
180003ea3:     	jmpq	*0x13a7(%rip)           # 0x180005250
180003ea9:     	jmpq	*0x1399(%rip)           # 0x180005248
180003eaf:     	jmpq	*0x138b(%rip)           # 0x180005240
180003eb5:     	jmpq	*0x1375(%rip)           # 0x180005230
180003ebb:     	jmpq	*0x135f(%rip)           # 0x180005220
180003ec1:     	jmpq	*0x1339(%rip)           # 0x180005200
180003ec7:     	int3
180003ec8:     	int3
180003ec9:     	int3
180003eca:     	int3
180003ecb:     	int3
180003ecc:     	int3
180003ecd:     	int3
180003ece:     	int3
180003ecf:     	int3
180003ed0:     	int3
180003ed1:     	int3
180003ed2:     	int3
180003ed3:     	int3
180003ed4:     	int3
180003ed5:     	int3
180003ed6:     	nopw	(%rax,%rax)
180003ee0:     	cmpq	0x71d9(%rip), %rcx      # 0x18000b0c0
180003ee7:     	jne	0x180003ef9 <numba_list_iter_next+0x359>
180003ee9:     	rolq	$0x10, %rcx
180003eed:     	testw	$0xffff, %cx            # imm = 0xFFFF
180003ef2:     	jne	0x180003ef5 <numba_list_iter_next+0x355>
180003ef4:     	retq
180003ef5:     	rorq	$0x10, %rcx
180003ef9:     	jmp	0x180004254 <numba_list_iter_next+0x6b4>
180003efe:     	int3
180003eff:     	int3
180003f00:     	subq	$0x28, %rsp
180003f04:     	testl	%edx, %edx
180003f06:     	je	0x180003f41 <numba_list_iter_next+0x3a1>
180003f08:     	subl	$0x1, %edx
180003f0b:     	je	0x180003f35 <numba_list_iter_next+0x395>
180003f0d:     	subl	$0x1, %edx
180003f10:     	je	0x180003f28 <numba_list_iter_next+0x388>
180003f12:     	cmpl	$0x1, %edx
180003f15:     	je	0x180003f21 <numba_list_iter_next+0x381>
180003f17:     	movl	$0x1, %eax
180003f1c:     	addq	$0x28, %rsp
180003f20:     	retq
180003f21:     	callq	0x180004420 <numba_list_iter_next+0x880>
180003f26:     	jmp	0x180003f2d <numba_list_iter_next+0x38d>
180003f28:     	callq	0x1800043f8 <numba_list_iter_next+0x858>
180003f2d:     	movzbl	%al, %eax
180003f30:     	addq	$0x28, %rsp
180003f34:     	retq
180003f35:     	movq	%r8, %rdx
180003f38:     	addq	$0x28, %rsp
180003f3c:     	jmp	0x180003f50 <numba_list_iter_next+0x3b0>
180003f41:     	testq	%r8, %r8
180003f44:     	setne	%cl
180003f47:     	addq	$0x28, %rsp
180003f4b:     	jmp	0x180004068 <numba_list_iter_next+0x4c8>
180003f50:     	movq	%rbx, 0x8(%rsp)
180003f55:     	movq	%rsi, 0x10(%rsp)
180003f5a:     	movq	%rdi, 0x20(%rsp)
180003f5f:     	pushq	%r14
180003f61:     	subq	$0x20, %rsp
180003f65:     	movq	%rdx, %rsi
180003f68:     	movq	%rcx, %r14
180003f6b:     	xorl	%ecx, %ecx
180003f6d:     	callq	0x1800044dc <numba_list_iter_next+0x93c>
180003f72:     	testb	%al, %al
180003f74:     	je	0x180004042 <numba_list_iter_next+0x4a2>
180003f7a:     	callq	0x180004370 <numba_list_iter_next+0x7d0>
180003f7f:     	movb	%al, %bl
180003f81:     	movb	%al, 0x40(%rsp)
180003f85:     	movb	$0x1, %dil
180003f88:     	cmpl	$0x0, 0x7a39(%rip)      # 0x18000b9c8
180003f8f:     	jne	0x18000405a <numba_list_iter_next+0x4ba>
180003f95:     	movl	$0x1, 0x7a29(%rip)      # 0x18000b9c8
180003f9f:     	callq	0x1800043e0 <numba_list_iter_next+0x840>
180003fa4:     	testb	%al, %al
180003fa6:     	je	0x180003ff7 <numba_list_iter_next+0x457>
180003fa8:     	callq	0x18000469c <numba_list_iter_next+0xafc>
180003fad:     	callq	0x180004330 <numba_list_iter_next+0x790>
180003fb2:     	callq	0x180004354 <numba_list_iter_next+0x7b4>
180003fb7:     	leaq	0x1312(%rip), %rdx      # 0x1800052d0
180003fbe:     	leaq	0x1303(%rip), %rcx      # 0x1800052c8
180003fc5:     	callq	0x1800049e2 <numba_list_iter_next+0xe42>
180003fca:     	testl	%eax, %eax
180003fcc:     	jne	0x180003ff7 <numba_list_iter_next+0x457>
180003fce:     	callq	0x1800043ac <numba_list_iter_next+0x80c>
180003fd3:     	testb	%al, %al
180003fd5:     	je	0x180003ff7 <numba_list_iter_next+0x457>
180003fd7:     	leaq	0x12e2(%rip), %rdx      # 0x1800052c0
180003fde:     	leaq	0x12d3(%rip), %rcx      # 0x1800052b8
180003fe5:     	callq	0x1800049dc <numba_list_iter_next+0xe3c>
180003fea:     	movl	$0x2, 0x79d4(%rip)      # 0x18000b9c8
180003ff4:     	xorb	%dil, %dil
180003ff7:     	movb	%bl, %cl
180003ff9:     	callq	0x18000463c <numba_list_iter_next+0xa9c>
180003ffe:     	testb	%dil, %dil
180004001:     	jne	0x180004042 <numba_list_iter_next+0x4a2>
180004003:     	callq	0x18000468c <numba_list_iter_next+0xaec>
180004008:     	movq	%rax, %rbx
18000400b:     	cmpq	$0x0, (%rax)
18000400f:     	je	0x180004035 <numba_list_iter_next+0x495>
180004011:     	movq	%rax, %rcx
180004014:     	callq	0x1800045a4 <numba_list_iter_next+0xa04>
180004019:     	testb	%al, %al
18000401b:     	je	0x180004035 <numba_list_iter_next+0x495>
18000401d:     	movq	%rsi, %r8
180004020:     	movl	$0x2, %edx
180004025:     	movq	%r14, %rcx
180004028:     	movq	(%rbx), %rax
18000402b:     	movq	0x125e(%rip), %r9       # 0x180005290
180004032:     	callq	*%r9
180004035:     	incl	0x7965(%rip)            # 0x18000b9a0
18000403b:     	movl	$0x1, %eax
180004040:     	jmp	0x180004044 <numba_list_iter_next+0x4a4>
180004042:     	xorl	%eax, %eax
180004044:     	movq	0x30(%rsp), %rbx
180004049:     	movq	0x38(%rsp), %rsi
18000404e:     	movq	0x48(%rsp), %rdi
180004053:     	addq	$0x20, %rsp
180004057:     	popq	%r14
180004059:     	retq
18000405a:     	movl	$0x7, %ecx
18000405f:     	callq	0x180004694 <numba_list_iter_next+0xaf4>
180004064:     	nop
180004065:     	int3
180004066:     	int3
180004067:     	int3
180004068:     	movq	%rbx, 0x8(%rsp)
18000406d:     	pushq	%rdi
18000406e:     	subq	$0x30, %rsp
180004072:     	movb	%cl, %dil
180004075:     	movl	0x7925(%rip), %eax      # 0x18000b9a0
18000407b:     	testl	%eax, %eax
18000407d:     	jg	0x18000408c <numba_list_iter_next+0x4ec>
18000407f:     	xorl	%eax, %eax
180004081:     	movq	0x40(%rsp), %rbx
180004086:     	addq	$0x30, %rsp
18000408a:     	popq	%rdi
18000408b:     	retq
18000408c:     	decl	%eax
18000408e:     	movl	%eax, 0x790c(%rip)      # 0x18000b9a0
180004094:     	callq	0x180004370 <numba_list_iter_next+0x7d0>
180004099:     	movb	%al, %bl
18000409b:     	movb	%al, 0x20(%rsp)
18000409f:     	cmpl	$0x2, 0x7922(%rip)      # 0x18000b9c8
1800040a6:     	jne	0x1800040de <numba_list_iter_next+0x53e>
1800040a8:     	callq	0x180004498 <numba_list_iter_next+0x8f8>
1800040ad:     	callq	0x180004340 <numba_list_iter_next+0x7a0>
1800040b2:     	callq	0x1800046d8 <numba_list_iter_next+0xb38>
1800040b7:     	movl	$0x0, 0x7907(%rip)      # 0x18000b9c8
1800040c1:     	movb	%bl, %cl
1800040c3:     	callq	0x18000463c <numba_list_iter_next+0xa9c>
1800040c8:     	xorl	%edx, %edx
1800040ca:     	movb	%dil, %cl
1800040cd:     	callq	0x180004660 <numba_list_iter_next+0xac0>
1800040d2:     	movzbl	%al, %ebx
1800040d5:     	callq	0x1800044c8 <numba_list_iter_next+0x928>
1800040da:     	movl	%ebx, %eax
1800040dc:     	jmp	0x180004081 <numba_list_iter_next+0x4e1>
1800040de:     	movl	$0x7, %ecx
1800040e3:     	callq	0x180004694 <numba_list_iter_next+0xaf4>
1800040e8:     	nop
1800040e9:     	nop
1800040ea:     	int3
1800040eb:     	int3
1800040ec:     	movq	%rsp, %rax
1800040ef:     	movq	%rbx, 0x20(%rax)
1800040f3:     	movq	%r8, 0x18(%rax)
1800040f7:     	movl	%edx, 0x10(%rax)
1800040fa:     	movq	%rcx, 0x8(%rax)
1800040fe:     	pushq	%rsi
1800040ff:     	pushq	%rdi
180004100:     	pushq	%r14
180004102:     	subq	$0x40, %rsp
180004106:     	movq	%r8, %rsi
180004109:     	movl	%edx, %edi
18000410b:     	movq	%rcx, %r14
18000410e:     	testl	%edx, %edx
180004110:     	jne	0x180004121 <numba_list_iter_next+0x581>
180004112:     	cmpl	%edx, 0x7888(%rip)      # 0x18000b9a0
180004118:     	jg	0x180004121 <numba_list_iter_next+0x581>
18000411a:     	xorl	%eax, %eax
18000411c:     	jmp	0x180004206 <numba_list_iter_next+0x666>
180004121:     	leal	-0x1(%rdx), %eax
180004124:     	cmpl	$0x1, %eax
180004127:     	ja	0x180004169 <numba_list_iter_next+0x5c9>
180004129:     	movq	0x14c8(%rip), %rax      # 0x1800055f8
180004130:     	testq	%rax, %rax
180004133:     	jne	0x18000413a <numba_list_iter_next+0x59a>
180004135:     	leal	0x1(%rax), %ebx
180004138:     	jmp	0x180004142 <numba_list_iter_next+0x5a2>
18000413a:     	callq	*0x1150(%rip)           # 0x180005290
180004140:     	movl	%eax, %ebx
180004142:     	movl	%ebx, 0x30(%rsp)
180004146:     	testl	%ebx, %ebx
180004148:     	je	0x1800041fc <numba_list_iter_next+0x65c>
18000414e:     	movq	%rsi, %r8
180004151:     	movl	%edi, %edx
180004153:     	movq	%r14, %rcx
180004156:     	callq	0x180003f00 <numba_list_iter_next+0x360>
18000415b:     	movl	%eax, %ebx
18000415d:     	movl	%eax, 0x30(%rsp)
180004161:     	testl	%eax, %eax
180004163:     	je	0x1800041fc <numba_list_iter_next+0x65c>
180004169:     	movq	%rsi, %r8
18000416c:     	movl	%edi, %edx
18000416e:     	movq	%r14, %rcx
180004171:     	callq	0x18000430c <numba_list_iter_next+0x76c>
180004176:     	movl	%eax, %ebx
180004178:     	movl	%eax, 0x30(%rsp)
18000417c:     	cmpl	$0x1, %edi
18000417f:     	jne	0x1800041b7 <numba_list_iter_next+0x617>
180004181:     	testl	%eax, %eax
180004183:     	jne	0x1800041b7 <numba_list_iter_next+0x617>
180004185:     	movq	%rsi, %r8
180004188:     	xorl	%edx, %edx
18000418a:     	movq	%r14, %rcx
18000418d:     	callq	0x18000430c <numba_list_iter_next+0x76c>
180004192:     	testq	%rsi, %rsi
180004195:     	setne	%cl
180004198:     	callq	0x180004068 <numba_list_iter_next+0x4c8>
18000419d:     	movq	0x1454(%rip), %rax      # 0x1800055f8
1800041a4:     	testq	%rax, %rax
1800041a7:     	je	0x1800041b7 <numba_list_iter_next+0x617>
1800041a9:     	movq	%rsi, %r8
1800041ac:     	xorl	%edx, %edx
1800041ae:     	movq	%r14, %rcx
1800041b1:     	callq	*0x10d9(%rip)           # 0x180005290
1800041b7:     	testl	%edi, %edi
1800041b9:     	je	0x1800041c0 <numba_list_iter_next+0x620>
1800041bb:     	cmpl	$0x3, %edi
1800041be:     	jne	0x1800041fc <numba_list_iter_next+0x65c>
1800041c0:     	movq	%rsi, %r8
1800041c3:     	movl	%edi, %edx
1800041c5:     	movq	%r14, %rcx
1800041c8:     	callq	0x180003f00 <numba_list_iter_next+0x360>
1800041cd:     	movl	%eax, %ebx
1800041cf:     	movl	%eax, 0x30(%rsp)
1800041d3:     	testl	%eax, %eax
1800041d5:     	je	0x1800041fc <numba_list_iter_next+0x65c>
1800041d7:     	movq	0x141a(%rip), %rax      # 0x1800055f8
1800041de:     	testq	%rax, %rax
1800041e1:     	jne	0x1800041e8 <numba_list_iter_next+0x648>
1800041e3:     	leal	0x1(%rax), %ebx
1800041e6:     	jmp	0x1800041f8 <numba_list_iter_next+0x658>
1800041e8:     	movq	%rsi, %r8
1800041eb:     	movl	%edi, %edx
1800041ed:     	movq	%r14, %rcx
1800041f0:     	callq	*0x109a(%rip)           # 0x180005290
1800041f6:     	movl	%eax, %ebx
1800041f8:     	movl	%ebx, 0x30(%rsp)
1800041fc:     	jmp	0x180004204 <numba_list_iter_next+0x664>
1800041fe:     	xorl	%ebx, %ebx
180004200:     	movl	%ebx, 0x30(%rsp)
180004204:     	movl	%ebx, %eax
180004206:     	movq	0x78(%rsp), %rbx
18000420b:     	addq	$0x40, %rsp
18000420f:     	popq	%r14
180004211:     	popq	%rdi
180004212:     	popq	%rsi
180004213:     	retq
180004214:     	movq	%rbx, 0x8(%rsp)
180004219:     	movq	%rsi, 0x10(%rsp)
18000421e:     	pushq	%rdi
18000421f:     	subq	$0x20, %rsp
180004223:     	movq	%r8, %rdi
180004226:     	movl	%edx, %ebx
180004228:     	movq	%rcx, %rsi
18000422b:     	cmpl	$0x1, %edx
18000422e:     	jne	0x180004235 <numba_list_iter_next+0x695>
180004230:     	callq	0x18000425c <numba_list_iter_next+0x6bc>
180004235:     	movq	%rdi, %r8
180004238:     	movl	%ebx, %edx
18000423a:     	movq	%rsi, %rcx
18000423d:     	movq	0x30(%rsp), %rbx
180004242:     	movq	0x38(%rsp), %rsi
180004247:     	addq	$0x20, %rsp
18000424b:     	popq	%rdi
18000424c:     	jmp	0x1800040ec <numba_list_iter_next+0x54c>
180004251:     	int3
180004252:     	int3
180004253:     	int3
180004254:     	movl	$0x2, %ecx
180004259:     	int	$0x29
18000425b:     	retq
18000425c:     	movq	%rbx, 0x18(%rsp)
180004261:     	pushq	%rbp
180004262:     	movq	%rsp, %rbp
180004265:     	subq	$0x30, %rsp
180004269:     	movq	0x6e50(%rip), %rax      # 0x18000b0c0
180004270:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000427a:     	cmpq	%rbx, %rax
18000427d:     	jne	0x1800042f6 <numba_list_iter_next+0x756>
18000427f:     	leaq	0x10(%rbp), %rcx
180004283:     	movq	$0x0, 0x10(%rbp)
18000428b:     	callq	*0xd8f(%rip)            # 0x180005020
180004291:     	movq	0x10(%rbp), %rax
180004295:     	movq	%rax, -0x10(%rbp)
180004299:     	callq	*0xd79(%rip)            # 0x180005018
18000429f:     	movl	%eax, %eax
1800042a1:     	xorq	%rax, -0x10(%rbp)
1800042a5:     	callq	*0xd65(%rip)            # 0x180005010
1800042ab:     	movl	%eax, %eax
1800042ad:     	leaq	0x18(%rbp), %rcx
1800042b1:     	xorq	%rax, -0x10(%rbp)
1800042b5:     	callq	*0xd45(%rip)            # 0x180005000
1800042bb:     	movl	0x18(%rbp), %eax
1800042be:     	leaq	-0x10(%rbp), %rcx
1800042c2:     	shlq	$0x20, %rax
1800042c6:     	xorq	0x18(%rbp), %rax
1800042ca:     	xorq	-0x10(%rbp), %rax
1800042ce:     	xorq	%rcx, %rax
1800042d1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
1800042db:     	andq	%rcx, %rax
1800042de:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
1800042e8:     	cmpq	%rbx, %rax
1800042eb:     	cmoveq	%rcx, %rax
1800042ef:     	movq	%rax, 0x6dca(%rip)      # 0x18000b0c0
1800042f6:     	movq	0x50(%rsp), %rbx
1800042fb:     	notq	%rax
1800042fe:     	movq	%rax, 0x6dfb(%rip)      # 0x18000b100
180004305:     	addq	$0x30, %rsp
180004309:     	popq	%rbp
18000430a:     	retq
18000430b:     	int3
18000430c:     	subq	$0x28, %rsp
180004310:     	cmpl	$0x1, %edx
180004313:     	jne	0x180004325 <numba_list_iter_next+0x785>
180004315:     	cmpq	$0x0, 0x12db(%rip)      # 0x1800055f8
18000431d:     	jne	0x180004325 <numba_list_iter_next+0x785>
18000431f:     	callq	*0xd03(%rip)            # 0x180005028
180004325:     	movl	$0x1, %eax
18000432a:     	addq	$0x28, %rsp
18000432e:     	retq
18000432f:     	int3
180004330:     	leaq	0x7679(%rip), %rcx      # 0x18000b9b0
180004337:     	jmpq	*0xcca(%rip)            # 0x180005008
18000433e:     	int3
18000433f:     	int3
180004340:     	leaq	0x7669(%rip), %rcx      # 0x18000b9b0
180004347:     	jmp	0x1800049d6 <numba_list_iter_next+0xe36>
18000434c:     	leaq	0x766d(%rip), %rax      # 0x18000b9c0
180004353:     	retq
180004354:     	subq	$0x28, %rsp
180004358:     	callq	0x1800034b0 <PyInit_rcaotr_de6cc5325c7b4615732d57b8+0x10e0>
18000435d:     	orq	$0x24, (%rax)
180004361:     	callq	0x18000434c <numba_list_iter_next+0x7ac>
180004366:     	orq	$0x2, (%rax)
18000436a:     	addq	$0x28, %rsp
18000436e:     	retq
18000436f:     	int3
180004370:     	subq	$0x28, %rsp
180004374:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
180004379:     	testl	%eax, %eax
18000437b:     	je	0x18000439e <numba_list_iter_next+0x7fe>
18000437d:     	movq	%gs:0x30, %rax
180004386:     	movq	0x8(%rax), %rcx
18000438a:     	jmp	0x180004391 <numba_list_iter_next+0x7f1>
18000438c:     	cmpq	%rax, %rcx
18000438f:     	je	0x1800043a5 <numba_list_iter_next+0x805>
180004391:     	xorl	%eax, %eax
180004393:     	lock
180004394:     	cmpxchgq	%rcx, 0x7634(%rip)      # 0x18000b9d0
18000439c:     	jne	0x18000438c <numba_list_iter_next+0x7ec>
18000439e:     	xorb	%al, %al
1800043a0:     	addq	$0x28, %rsp
1800043a4:     	retq
1800043a5:     	movb	$0x1, %al
1800043a7:     	jmp	0x1800043a0 <numba_list_iter_next+0x800>
1800043a9:     	int3
1800043aa:     	int3
1800043ab:     	int3
1800043ac:     	subq	$0x28, %rsp
1800043b0:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
1800043b5:     	testl	%eax, %eax
1800043b7:     	je	0x1800043c0 <numba_list_iter_next+0x820>
1800043b9:     	callq	0x180004718 <numba_list_iter_next+0xb78>
1800043be:     	jmp	0x1800043d9 <numba_list_iter_next+0x839>
1800043c0:     	callq	0x1800049b4 <numba_list_iter_next+0xe14>
1800043c5:     	movl	%eax, %ecx
1800043c7:     	callq	0x1800049ee <numba_list_iter_next+0xe4e>
1800043cc:     	testl	%eax, %eax
1800043ce:     	je	0x1800043d4 <numba_list_iter_next+0x834>
1800043d0:     	xorb	%al, %al
1800043d2:     	jmp	0x1800043db <numba_list_iter_next+0x83b>
1800043d4:     	callq	0x1800049f4 <numba_list_iter_next+0xe54>
1800043d9:     	movb	$0x1, %al
1800043db:     	addq	$0x28, %rsp
1800043df:     	retq
1800043e0:     	subq	$0x28, %rsp
1800043e4:     	xorl	%ecx, %ecx
1800043e6:     	callq	0x180004518 <numba_list_iter_next+0x978>
1800043eb:     	testb	%al, %al
1800043ed:     	setne	%al
1800043f0:     	addq	$0x28, %rsp
1800043f4:     	retq
1800043f5:     	int3
1800043f6:     	int3
1800043f7:     	int3
1800043f8:     	subq	$0x28, %rsp
1800043fc:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
180004401:     	testb	%al, %al
180004403:     	jne	0x180004409 <numba_list_iter_next+0x869>
180004405:     	xorb	%al, %al
180004407:     	jmp	0x18000441b <numba_list_iter_next+0x87b>
180004409:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
18000440e:     	testb	%al, %al
180004410:     	jne	0x180004419 <numba_list_iter_next+0x879>
180004412:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
180004417:     	jmp	0x180004405 <numba_list_iter_next+0x865>
180004419:     	movb	$0x1, %al
18000441b:     	addq	$0x28, %rsp
18000441f:     	retq
180004420:     	subq	$0x28, %rsp
180004424:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
180004429:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
18000442e:     	movb	$0x1, %al
180004430:     	addq	$0x28, %rsp
180004434:     	retq
180004435:     	int3
180004436:     	int3
180004437:     	int3
180004438:     	movq	%rbx, 0x8(%rsp)
18000443d:     	movq	%rbp, 0x10(%rsp)
180004442:     	movq	%rsi, 0x18(%rsp)
180004447:     	pushq	%rdi
180004448:     	subq	$0x20, %rsp
18000444c:     	movq	%r9, %rdi
18000444f:     	movq	%r8, %rsi
180004452:     	movl	%edx, %ebx
180004454:     	movq	%rcx, %rbp
180004457:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
18000445c:     	testl	%eax, %eax
18000445e:     	jne	0x180004476 <numba_list_iter_next+0x8d6>
180004460:     	cmpl	$0x1, %ebx
180004463:     	jne	0x180004476 <numba_list_iter_next+0x8d6>
180004465:     	movq	%rsi, %r8
180004468:     	xorl	%edx, %edx
18000446a:     	movq	%rbp, %rcx
18000446d:     	movq	%rdi, %rax
180004470:     	callq	*0xe1a(%rip)            # 0x180005290
180004476:     	movq	0x58(%rsp), %rdx
18000447b:     	movl	0x50(%rsp), %ecx
18000447f:     	movq	0x30(%rsp), %rbx
180004484:     	movq	0x38(%rsp), %rbp
180004489:     	movq	0x40(%rsp), %rsi
18000448e:     	addq	$0x20, %rsp
180004492:     	popq	%rdi
180004493:     	jmp	0x1800049e8 <numba_list_iter_next+0xe48>
180004498:     	subq	$0x28, %rsp
18000449c:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
1800044a1:     	testl	%eax, %eax
1800044a3:     	je	0x1800044b5 <numba_list_iter_next+0x915>
1800044a5:     	leaq	0x7534(%rip), %rcx      # 0x18000b9e0
1800044ac:     	addq	$0x28, %rsp
1800044b0:     	jmp	0x180004a00 <numba_list_iter_next+0xe60>
1800044b5:     	callq	0x180004a10 <numba_list_iter_next+0xe70>
1800044ba:     	testl	%eax, %eax
1800044bc:     	jne	0x1800044c3 <numba_list_iter_next+0x923>
1800044be:     	callq	0x180004a06 <numba_list_iter_next+0xe66>
1800044c3:     	addq	$0x28, %rsp
1800044c7:     	retq
1800044c8:     	subq	$0x28, %rsp
1800044cc:     	xorl	%ecx, %ecx
1800044ce:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
1800044d3:     	addq	$0x28, %rsp
1800044d7:     	jmp	0x180004a0c <numba_list_iter_next+0xe6c>
1800044dc:     	subq	$0x28, %rsp
1800044e0:     	testl	%ecx, %ecx
1800044e2:     	jne	0x1800044eb <numba_list_iter_next+0x94b>
1800044e4:     	movb	$0x1, 0x74ed(%rip)      # 0x18000b9d8
1800044eb:     	callq	0x180004718 <numba_list_iter_next+0xb78>
1800044f0:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
1800044f5:     	testb	%al, %al
1800044f7:     	jne	0x1800044fd <numba_list_iter_next+0x95d>
1800044f9:     	xorb	%al, %al
1800044fb:     	jmp	0x180004511 <numba_list_iter_next+0x971>
1800044fd:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
180004502:     	testb	%al, %al
180004504:     	jne	0x18000450f <numba_list_iter_next+0x96f>
180004506:     	xorl	%ecx, %ecx
180004508:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
18000450d:     	jmp	0x1800044f9 <numba_list_iter_next+0x959>
18000450f:     	movb	$0x1, %al
180004511:     	addq	$0x28, %rsp
180004515:     	retq
180004516:     	int3
180004517:     	int3
180004518:     	pushq	%rbx
18000451a:     	subq	$0x20, %rsp
18000451e:     	cmpb	$0x0, 0x74b4(%rip)      # 0x18000b9d9
180004525:     	movl	%ecx, %ebx
180004527:     	jne	0x180004590 <numba_list_iter_next+0x9f0>
180004529:     	cmpl	$0x1, %ecx
18000452c:     	ja	0x180004598 <numba_list_iter_next+0x9f8>
18000452e:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
180004533:     	testl	%eax, %eax
180004535:     	je	0x18000455f <numba_list_iter_next+0x9bf>
180004537:     	testl	%ebx, %ebx
180004539:     	jne	0x18000455f <numba_list_iter_next+0x9bf>
18000453b:     	leaq	0x749e(%rip), %rcx      # 0x18000b9e0
180004542:     	callq	0x1800049fa <numba_list_iter_next+0xe5a>
180004547:     	testl	%eax, %eax
180004549:     	jne	0x18000455b <numba_list_iter_next+0x9bb>
18000454b:     	leaq	0x74a6(%rip), %rcx      # 0x18000b9f8
180004552:     	callq	0x1800049fa <numba_list_iter_next+0xe5a>
180004557:     	testl	%eax, %eax
180004559:     	je	0x180004589 <numba_list_iter_next+0x9e9>
18000455b:     	xorb	%al, %al
18000455d:     	jmp	0x180004592 <numba_list_iter_next+0x9f2>
18000455f:     	movdqa	0x1099(%rip), %xmm0     # 0x180005600
180004567:     	orq	$-0x1, %rax
18000456b:     	movdqu	%xmm0, 0x746d(%rip)     # 0x18000b9e0
180004573:     	movq	%rax, 0x7476(%rip)      # 0x18000b9f0
18000457a:     	movdqu	%xmm0, 0x7476(%rip)     # 0x18000b9f8
180004582:     	movq	%rax, 0x747f(%rip)      # 0x18000ba08
180004589:     	movb	$0x1, 0x7449(%rip)      # 0x18000b9d9
180004590:     	movb	$0x1, %al
180004592:     	addq	$0x20, %rsp
180004596:     	popq	%rbx
180004597:     	retq
180004598:     	movl	$0x5, %ecx
18000459d:     	callq	0x180004694 <numba_list_iter_next+0xaf4>
1800045a2:     	int3
1800045a3:     	int3
1800045a4:     	subq	$0x18, %rsp
1800045a8:     	movq	%rcx, %r8
1800045ab:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
1800045b0:     	cmpw	%ax, -0x45b7(%rip)      # 0x180000000
1800045b7:     	jne	0x180004631 <numba_list_iter_next+0xa91>
1800045b9:     	movslq	-0x4584(%rip), %rcx     # 0x18000003c
1800045c0:     	leaq	-0x45c7(%rip), %rdx     # 0x180000000
1800045c7:     	addq	%rdx, %rcx
1800045ca:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
1800045d0:     	jne	0x180004631 <numba_list_iter_next+0xa91>
1800045d2:     	movl	$0x20b, %eax            # imm = 0x20B
1800045d7:     	cmpw	%ax, 0x18(%rcx)
1800045db:     	jne	0x180004631 <numba_list_iter_next+0xa91>
1800045dd:     	subq	%rdx, %r8
1800045e0:     	movzwl	0x14(%rcx), %edx
1800045e4:     	addq	$0x18, %rdx
1800045e8:     	addq	%rcx, %rdx
1800045eb:     	movzwl	0x6(%rcx), %eax
1800045ef:     	leaq	(%rax,%rax,4), %rcx
1800045f3:     	leaq	(%rdx,%rcx,8), %r9
1800045f7:     	movq	%rdx, (%rsp)
1800045fb:     	cmpq	%r9, %rdx
1800045fe:     	je	0x180004618 <numba_list_iter_next+0xa78>
180004600:     	movl	0xc(%rdx), %ecx
180004603:     	cmpq	%rcx, %r8
180004606:     	jb	0x180004612 <numba_list_iter_next+0xa72>
180004608:     	movl	0x8(%rdx), %eax
18000460b:     	addl	%ecx, %eax
18000460d:     	cmpq	%rax, %r8
180004610:     	jb	0x18000461a <numba_list_iter_next+0xa7a>
180004612:     	addq	$0x28, %rdx
180004616:     	jmp	0x1800045f7 <numba_list_iter_next+0xa57>
180004618:     	xorl	%edx, %edx
18000461a:     	testq	%rdx, %rdx
18000461d:     	jne	0x180004623 <numba_list_iter_next+0xa83>
18000461f:     	xorb	%al, %al
180004621:     	jmp	0x180004637 <numba_list_iter_next+0xa97>
180004623:     	cmpl	$0x0, 0x24(%rdx)
180004627:     	jge	0x18000462d <numba_list_iter_next+0xa8d>
180004629:     	xorb	%al, %al
18000462b:     	jmp	0x180004637 <numba_list_iter_next+0xa97>
18000462d:     	movb	$0x1, %al
18000462f:     	jmp	0x180004637 <numba_list_iter_next+0xa97>
180004631:     	xorb	%al, %al
180004633:     	jmp	0x180004637 <numba_list_iter_next+0xa97>
180004635:     	xorb	%al, %al
180004637:     	addq	$0x18, %rsp
18000463b:     	retq
18000463c:     	pushq	%rbx
18000463e:     	subq	$0x20, %rsp
180004642:     	movb	%cl, %bl
180004644:     	callq	0x1800049bc <numba_list_iter_next+0xe1c>
180004649:     	xorl	%edx, %edx
18000464b:     	testl	%eax, %eax
18000464d:     	je	0x18000465a <numba_list_iter_next+0xaba>
18000464f:     	testb	%bl, %bl
180004651:     	jne	0x18000465a <numba_list_iter_next+0xaba>
180004653:     	xchgq	%rdx, 0x7376(%rip)      # 0x18000b9d0
18000465a:     	addq	$0x20, %rsp
18000465e:     	popq	%rbx
18000465f:     	retq
180004660:     	pushq	%rbx
180004662:     	subq	$0x20, %rsp
180004666:     	cmpb	$0x0, 0x736b(%rip)      # 0x18000b9d8
18000466d:     	movb	%cl, %bl
18000466f:     	je	0x180004675 <numba_list_iter_next+0xad5>
180004671:     	testb	%dl, %dl
180004673:     	jne	0x180004681 <numba_list_iter_next+0xae1>
180004675:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
18000467a:     	movb	%bl, %cl
18000467c:     	callq	0x180004a0c <numba_list_iter_next+0xe6c>
180004681:     	movb	$0x1, %al
180004683:     	addq	$0x20, %rsp
180004687:     	popq	%rbx
180004688:     	retq
180004689:     	int3
18000468a:     	int3
18000468b:     	int3
18000468c:     	leaq	0x75d5(%rip), %rax      # 0x18000bc68
180004693:     	retq
180004694:     	movl	%ecx, %ecx
180004696:     	int	$0x29
180004698:     	retq
180004699:     	int3
18000469a:     	int3
18000469b:     	int3
18000469c:     	movq	%rbx, 0x8(%rsp)
1800046a1:     	pushq	%rdi
1800046a2:     	subq	$0x20, %rsp
1800046a6:     	leaq	0x3913(%rip), %rbx      # 0x180007fc0
1800046ad:     	leaq	0x390c(%rip), %rdi      # 0x180007fc0
1800046b4:     	jmp	0x1800046c8 <numba_list_iter_next+0xb28>
1800046b6:     	movq	(%rbx), %rax
1800046b9:     	testq	%rax, %rax
1800046bc:     	je	0x1800046c4 <numba_list_iter_next+0xb24>
1800046be:     	callq	*0xbcc(%rip)            # 0x180005290
1800046c4:     	addq	$0x8, %rbx
1800046c8:     	cmpq	%rdi, %rbx
1800046cb:     	jb	0x1800046b6 <numba_list_iter_next+0xb16>
1800046cd:     	movq	0x30(%rsp), %rbx
1800046d2:     	addq	$0x20, %rsp
1800046d6:     	popq	%rdi
1800046d7:     	retq
1800046d8:     	movq	%rbx, 0x8(%rsp)
1800046dd:     	pushq	%rdi
1800046de:     	subq	$0x20, %rsp
1800046e2:     	leaq	0x38e7(%rip), %rbx      # 0x180007fd0
1800046e9:     	leaq	0x38e0(%rip), %rdi      # 0x180007fd0
1800046f0:     	jmp	0x180004704 <numba_list_iter_next+0xb64>
1800046f2:     	movq	(%rbx), %rax
1800046f5:     	testq	%rax, %rax
1800046f8:     	je	0x180004700 <numba_list_iter_next+0xb60>
1800046fa:     	callq	*0xb90(%rip)            # 0x180005290
180004700:     	addq	$0x8, %rbx
180004704:     	cmpq	%rdi, %rbx
180004707:     	jb	0x1800046f2 <numba_list_iter_next+0xb52>
180004709:     	movq	0x30(%rsp), %rbx
18000470e:     	addq	$0x20, %rsp
180004712:     	popq	%rdi
180004713:     	retq
180004714:     	retq	$0x0
180004717:     	int3
180004718:     	movq	%rbx, 0x10(%rsp)
18000471d:     	movq	%rbp, 0x18(%rsp)
180004722:     	movq	%rsi, 0x20(%rsp)
180004727:     	pushq	%rdi
180004728:     	subq	$0x10, %rsp
18000472c:     	xorl	%eax, %eax
18000472e:     	xorl	%ecx, %ecx
180004730:     	cpuid
180004732:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180004738:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000473e:     	orl	%ecx, %edx
180004740:     	movl	%eax, %ebp
180004742:     	movl	$0x1, %eax
180004747:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000474d:     	orl	%ebx, %edx
18000474f:     	leal	-0x1(%rax), %ecx
180004752:     	cpuid
180004754:     	movl	%ecx, %edi
180004756:     	jne	0x1800047b6 <numba_list_iter_next+0xc16>
180004758:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000475d:     	movq	$0x8000, 0x69b0(%rip)   # imm = 0x8000
                                                # 0x18000b118
180004768:     	movq	$-0x1, 0x69ad(%rip)     # 0x18000b120
180004773:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180004778:     	je	0x1800047a2 <numba_list_iter_next+0xc02>
18000477a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000477f:     	je	0x1800047a2 <numba_list_iter_next+0xc02>
180004781:     	cmpl	$0x20670, %eax          # imm = 0x20670
180004786:     	je	0x1800047a2 <numba_list_iter_next+0xc02>
180004788:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000478d:     	cmpl	$0x20, %eax
180004790:     	ja	0x1800047b6 <numba_list_iter_next+0xc16>
180004792:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000479c:     	btq	%rax, %rcx
1800047a0:     	jae	0x1800047b6 <numba_list_iter_next+0xc16>
1800047a2:     	movl	0x726b(%rip), %r8d      # 0x18000ba14
1800047a9:     	orl	$0x1, %r8d
1800047ad:     	movl	%r8d, 0x7260(%rip)      # 0x18000ba14
1800047b4:     	jmp	0x1800047bd <numba_list_iter_next+0xc1d>
1800047b6:     	movl	0x7257(%rip), %r8d      # 0x18000ba14
1800047bd:     	xorl	%r9d, %r9d
1800047c0:     	movl	%r9d, %r11d
1800047c3:     	cmpl	$0x7, %ebp
1800047c6:     	jl	0x18000480a <numba_list_iter_next+0xc6a>
1800047c8:     	xorl	%ecx, %ecx
1800047ca:     	leal	0x7(%r9), %eax
1800047ce:     	cpuid
1800047d0:     	movl	%edx, %esi
1800047d2:     	movl	%ebx, %r10d
1800047d5:     	btl	$0x9, %ebx
1800047d9:     	jae	0x1800047e6 <numba_list_iter_next+0xc46>
1800047db:     	orl	$0x2, %r8d
1800047df:     	movl	%r8d, 0x722e(%rip)      # 0x18000ba14
1800047e6:     	cmpl	$0x1, %eax
1800047e9:     	jl	0x1800047f8 <numba_list_iter_next+0xc58>
1800047eb:     	movl	$0x7, %eax
1800047f0:     	leal	-0x6(%rax), %ecx
1800047f3:     	cpuid
1800047f5:     	movl	%edx, %r9d
1800047f8:     	movl	$0x24, %eax
1800047fd:     	cmpl	%eax, %ebp
1800047ff:     	jl	0x180004810 <numba_list_iter_next+0xc70>
180004801:     	xorl	%ecx, %ecx
180004803:     	cpuid
180004805:     	movl	%ebx, %r11d
180004808:     	jmp	0x180004810 <numba_list_iter_next+0xc70>
18000480a:     	movl	%r9d, %r10d
18000480d:     	movl	%r9d, %esi
180004810:     	movq	0x6911(%rip), %rax      # 0x18000b128
180004817:     	andq	$-0x2, %rax
18000481b:     	movl	$0x1, 0x68eb(%rip)      # 0x18000b110
180004825:     	movl	$0x2, 0x68e5(%rip)      # 0x18000b114
18000482f:     	movq	%rax, 0x68f2(%rip)      # 0x18000b128
180004836:     	btl	$0x14, %edi
18000483a:     	jae	0x18000485b <numba_list_iter_next+0xcbb>
18000483c:     	andq	$-0x11, %rax
180004840:     	movl	$0x2, 0x68c6(%rip)      # 0x18000b110
18000484a:     	movq	%rax, 0x68d7(%rip)      # 0x18000b128
180004851:     	movl	$0x6, 0x68b9(%rip)      # 0x18000b114
18000485b:     	btl	$0x1b, %edi
18000485f:     	jae	0x18000499c <numba_list_iter_next+0xdfc>
180004865:     	xorl	%ecx, %ecx
180004867:     	xgetbv
18000486a:     	shlq	$0x20, %rdx
18000486e:     	orq	%rax, %rdx
180004871:     	movq	%rdx, 0x20(%rsp)
180004876:     	btl	$0x1c, %edi
18000487a:     	jae	0x180004980 <numba_list_iter_next+0xde0>
180004880:     	movq	0x20(%rsp), %rax
180004885:     	andb	$0x6, %al
180004887:     	cmpb	$0x6, %al
180004889:     	jne	0x180004980 <numba_list_iter_next+0xde0>
18000488f:     	movl	0x687f(%rip), %eax      # 0x18000b114
180004895:     	movb	$-0x20, %dl
180004897:     	orl	$0x8, %eax
18000489a:     	movl	$0x3, 0x686c(%rip)      # 0x18000b110
1800048a4:     	movl	%eax, 0x686a(%rip)      # 0x18000b114
1800048aa:     	testb	$0x20, %r10b
1800048ae:     	je	0x180004912 <numba_list_iter_next+0xd72>
1800048b0:     	orl	$0x20, %eax
1800048b3:     	movl	$0x5, 0x6853(%rip)      # 0x18000b110
1800048bd:     	movl	%eax, 0x6851(%rip)      # 0x18000b114
1800048c3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1800048c8:     	movq	0x6859(%rip), %rax      # 0x18000b128
1800048cf:     	andl	%ecx, %r10d
1800048d2:     	andq	$-0x3, %rax
1800048d6:     	movq	%rax, 0x684b(%rip)      # 0x18000b128
1800048dd:     	cmpl	%ecx, %r10d
1800048e0:     	jne	0x180004919 <numba_list_iter_next+0xd79>
1800048e2:     	movq	0x20(%rsp), %rax
1800048e7:     	andb	%dl, %al
1800048e9:     	cmpb	%dl, %al
1800048eb:     	jne	0x180004912 <numba_list_iter_next+0xd72>
1800048ed:     	movq	0x6834(%rip), %rax      # 0x18000b128
1800048f4:     	orl	$0x40, 0x6819(%rip)     # 0x18000b114
1800048fb:     	andq	$-0x25, %rax
1800048ff:     	movl	$0x6, 0x6807(%rip)      # 0x18000b110
180004909:     	movq	%rax, 0x6818(%rip)      # 0x18000b128
180004910:     	jmp	0x180004919 <numba_list_iter_next+0xd79>
180004912:     	movq	0x680f(%rip), %rax      # 0x18000b128
180004919:     	btl	$0x17, %esi
18000491d:     	jae	0x18000492b <numba_list_iter_next+0xd8b>
18000491f:     	btrq	$0x18, %rax
180004924:     	movq	%rax, 0x67fd(%rip)      # 0x18000b128
18000492b:     	btl	$0x13, %r9d
180004930:     	jae	0x180004980 <numba_list_iter_next+0xde0>
180004932:     	movq	0x20(%rsp), %rax
180004937:     	andb	%dl, %al
180004939:     	cmpb	%dl, %al
18000493b:     	jne	0x180004980 <numba_list_iter_next+0xde0>
18000493d:     	movq	0x67e4(%rip), %rdx      # 0x18000b128
180004944:     	movl	%r11d, %eax
180004947:     	shrq	$0x10, %rax
18000494b:     	movl	%r11d, %ecx
18000494e:     	andl	$0x6, %eax
180004951:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180004957:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000495d:     	movl	%ecx, 0x70b5(%rip)      # 0x18000ba18
180004963:     	notq	%rax
180004966:     	andq	%rax, %rdx
180004969:     	movq	%rdx, 0x67b8(%rip)      # 0x18000b128
180004970:     	cmpb	$0x1, %cl
180004973:     	jbe	0x180004980 <numba_list_iter_next+0xde0>
180004975:     	andq	$-0x41, %rdx
180004979:     	movq	%rdx, 0x67a8(%rip)      # 0x18000b128
180004980:     	btl	$0x15, %r9d
180004985:     	jae	0x18000499c <numba_list_iter_next+0xdfc>
180004987:     	movq	0x20(%rsp), %rax
18000498c:     	btq	$0x13, %rax
180004991:     	jae	0x18000499c <numba_list_iter_next+0xdfc>
180004993:     	btrq	$0x7, 0x678c(%rip)      # 0x18000b128
18000499c:     	movq	0x28(%rsp), %rbx
1800049a1:     	xorl	%eax, %eax
1800049a3:     	movq	0x30(%rsp), %rbp
1800049a8:     	movq	0x38(%rsp), %rsi
1800049ad:     	addq	$0x10, %rsp
1800049b1:     	popq	%rdi
1800049b2:     	retq
1800049b3:     	int3
1800049b4:     	movl	$0x1, %eax
1800049b9:     	retq
1800049ba:     	int3
1800049bb:     	int3
1800049bc:     	xorl	%eax, %eax
1800049be:     	cmpl	%eax, 0x676c(%rip)      # 0x18000b130
1800049c4:     	setne	%al
1800049c7:     	retq
1800049c8:     	int3
1800049c9:     	int3
1800049ca:     	int3
1800049cb:     	int3
1800049cc:     	int3
1800049cd:     	int3
1800049ce:     	int3
1800049cf:     	int3
1800049d0:     	jmpq	*0x672(%rip)            # 0x180005048
1800049d6:     	jmpq	*0x674(%rip)            # 0x180005050
1800049dc:     	jmpq	*0x6ae(%rip)            # 0x180005090
1800049e2:     	jmpq	*0x6b0(%rip)            # 0x180005098
1800049e8:     	jmpq	*0x6b2(%rip)            # 0x1800050a0
1800049ee:     	jmpq	*0x6b4(%rip)            # 0x1800050a8
1800049f4:     	jmpq	*0x6b6(%rip)            # 0x1800050b0
1800049fa:     	jmpq	*0x680(%rip)            # 0x180005080
180004a00:     	jmpq	*0x6b2(%rip)            # 0x1800050b8
180004a06:     	jmpq	*0x67c(%rip)            # 0x180005088
180004a0c:     	movb	$0x1, %al
180004a0e:     	retq
180004a0f:     	int3
180004a10:     	xorl	%eax, %eax
180004a12:     	retq
180004a13:     	jmpq	*0x61f(%rip)            # 0x180005038
180004a19:     	jmpq	*0x621(%rip)            # 0x180005040
180004a1f:     	jmpq	*0x6a3(%rip)            # 0x1800050c8
180004a25:     	jmpq	*0x6a5(%rip)            # 0x1800050d0
180004a2b:     	int3
180004a2c:     	int3
180004a2d:     	int3
180004a2e:     	int3
180004a2f:     	int3
180004a30:     	int3
180004a31:     	int3
180004a32:     	int3
180004a33:     	int3
180004a34:     	int3
180004a35:     	int3
180004a36:     	nopw	(%rax,%rax)
180004a40:     	jmpq	*%rax
180004a42:     	int3
180004a43:     	int3
180004a44:     	int3
180004a45:     	int3
180004a46:     	int3
180004a47:     	int3
180004a48:     	int3
180004a49:     	int3
180004a4a:     	int3
180004a4b:     	int3
180004a4c:     	int3
180004a4d:     	int3
180004a4e:     	int3
180004a4f:     	int3
180004a50:     	int3
180004a51:     	int3
180004a52:     	int3
180004a53:     	int3
180004a54:     	int3
180004a55:     	int3
180004a56:     	nopw	(%rax,%rax)
180004a60:     	jmpq	*0x82a(%rip)            # 0x180005290
180004a66:     	pushq	%rbp
180004a68:     	subq	$0x20, %rsp
180004a6c:     	movq	%rdx, %rbp
180004a6f:     	movb	0x40(%rbp), %cl
180004a72:     	addq	$0x20, %rsp
180004a76:     	popq	%rbp
180004a77:     	jmp	0x18000463c <numba_list_iter_next+0xa9c>
180004a7c:     	int3
180004a7d:     	pushq	%rbp
180004a7f:     	subq	$0x20, %rsp
180004a83:     	movq	%rdx, %rbp
180004a86:     	movb	0x20(%rbp), %cl
180004a89:     	callq	0x18000463c <numba_list_iter_next+0xa9c>
180004a8e:     	nop
180004a8f:     	addq	$0x20, %rsp
180004a93:     	popq	%rbp
180004a94:     	retq
180004a95:     	int3
180004a96:     	pushq	%rbp
180004a98:     	subq	$0x20, %rsp
180004a9c:     	movq	%rdx, %rbp
180004a9f:     	addq	$0x20, %rsp
180004aa3:     	popq	%rbp
180004aa4:     	jmp	0x1800044c8 <numba_list_iter_next+0x928>
180004aa9:     	int3
180004aaa:     	pushq	%rbp
180004aac:     	subq	$0x30, %rsp
180004ab0:     	movq	%rdx, %rbp
180004ab3:     	movq	(%rcx), %rax
180004ab6:     	movl	(%rax), %edx
180004ab8:     	movq	%rcx, 0x28(%rsp)
180004abd:     	movl	%edx, 0x20(%rsp)
180004ac1:     	leaq	-0xbc8(%rip), %r9       # 0x180003f00 <numba_list_iter_next+0x360>
180004ac8:     	movq	0x70(%rbp), %r8
180004acc:     	movl	0x68(%rbp), %edx
180004acf:     	movq	0x60(%rbp), %rcx
180004ad3:     	callq	0x180004438 <numba_list_iter_next+0x898>
180004ad8:     	nop
180004ad9:     	addq	$0x30, %rsp
180004add:     	popq	%rbp
180004ade:     	retq
180004adf:     	int3
180004ae0:     	pushq	%rbp
180004ae2:     	movq	%rdx, %rbp
180004ae5:     	movq	(%rcx), %rax
180004ae8:     	xorl	%ecx, %ecx
180004aea:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180004af0:     	sete	%cl
180004af3:     	movl	%ecx, %eax
180004af5:     	popq	%rbp
180004af6:     	retq
180004af7:     	int3
