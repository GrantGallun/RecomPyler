
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-formal-v1\aot\unchecked-int64\fibonacci\rcnumeric_3d36deac3a8cae31652c24de.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002d30 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3319(%rip), %rax      # 0x1800043a0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	testq	%rdx, %rdx
180001093:     	jle	0x1800010b9 <.text+0xb9>
180001095:     	incq	%rdx
180001098:     	movl	$0x1, %r9d
18000109e:     	xorl	%eax, %eax
1800010a0:     	movq	%r9, %r8
1800010a3:     	addq	%r9, %rax
1800010a6:     	decq	%rdx
1800010a9:     	cmpq	$0x1, %rdx
1800010ad:     	movq	%rax, %r9
1800010b0:     	movq	%r8, %rax
1800010b3:     	ja	0x1800010a0 <.text+0xa0>
1800010b5:     	movq	%r8, (%rcx)
1800010b8:     	retq
1800010b9:     	xorl	%r8d, %r8d
1800010bc:     	movq	%r8, (%rcx)
1800010bf:     	retq
1800010c0:     	pushq	%r15
1800010c2:     	pushq	%r14
1800010c4:     	pushq	%r12
1800010c6:     	pushq	%rsi
1800010c7:     	pushq	%rdi
1800010c8:     	pushq	%rbx
1800010c9:     	subq	$0x178, %rsp            # imm = 0x178
1800010d0:     	movq	%rdx, %rcx
1800010d3:     	leaq	0x58(%rsp), %rax
1800010d8:     	movq	%rax, 0x40(%rsp)
1800010dd:     	leaq	0x60(%rsp), %rax
1800010e2:     	movq	%rax, 0x38(%rsp)
1800010e7:     	leaq	0x68(%rsp), %rax
1800010ec:     	movq	%rax, 0x30(%rsp)
1800010f1:     	leaq	0x70(%rsp), %rax
1800010f6:     	movq	%rax, 0x28(%rsp)
1800010fb:     	leaq	0x78(%rsp), %rax
180001100:     	movq	%rax, 0x20(%rsp)
180001105:     	leaq	0x32bc(%rip), %rdx      # 0x1800043c8
18000110c:     	movl	$0x5, %r8d
180001112:     	movl	$0x5, %r9d
180001118:     	callq	0x180002ec1 <numba_list_iter_next+0x2f1>
18000111d:     	testl	%eax, %eax
18000111f:     	je	0x1800013bc <.text+0x3bc>
180001125:     	cmpq	$0x0, 0x9b33(%rip)      # 0x18000ac60
18000112d:     	je	0x18000131f <.text+0x31f>
180001133:     	movq	0x78(%rsp), %rcx
180001138:     	xorps	%xmm0, %xmm0
18000113b:     	movaps	%xmm0, 0x140(%rsp)
180001143:     	movaps	%xmm0, 0x150(%rsp)
18000114b:     	movaps	%xmm0, 0x160(%rsp)
180001153:     	movq	$0x0, 0x170(%rsp)
18000115f:     	leaq	0x140(%rsp), %rdx
180001167:     	callq	0x180001ba0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7a0>
18000116c:     	testl	%eax, %eax
18000116e:     	jne	0x180001337 <.text+0x337>
180001174:     	cmpq	$0x8, 0x158(%rsp)
18000117d:     	jne	0x180001337 <.text+0x337>
180001183:     	movq	0x140(%rsp), %rsi
18000118b:     	movq	0x70(%rsp), %rcx
180001190:     	xorps	%xmm0, %xmm0
180001193:     	movaps	%xmm0, 0x100(%rsp)
18000119b:     	movaps	%xmm0, 0x110(%rsp)
1800011a3:     	movaps	%xmm0, 0x120(%rsp)
1800011ab:     	movq	$0x0, 0x130(%rsp)
1800011b7:     	leaq	0x100(%rsp), %rdx
1800011bf:     	callq	0x180001ba0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7a0>
1800011c4:     	testl	%eax, %eax
1800011c6:     	jne	0x18000134c <.text+0x34c>
1800011cc:     	cmpq	$0x8, 0x118(%rsp)
1800011d5:     	jne	0x18000134c <.text+0x34c>
1800011db:     	movq	0x100(%rsp), %rdi
1800011e3:     	movq	0x68(%rsp), %rcx
1800011e8:     	xorps	%xmm0, %xmm0
1800011eb:     	movaps	%xmm0, 0xc0(%rsp)
1800011f3:     	movaps	%xmm0, 0xd0(%rsp)
1800011fb:     	movaps	%xmm0, 0xe0(%rsp)
180001203:     	movq	$0x0, 0xf0(%rsp)
18000120f:     	leaq	0xc0(%rsp), %rdx
180001217:     	callq	0x180001ba0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7a0>
18000121c:     	testl	%eax, %eax
18000121e:     	jne	0x180001361 <.text+0x361>
180001224:     	cmpq	$0x8, 0xd8(%rsp)
18000122d:     	jne	0x180001361 <.text+0x361>
180001233:     	movq	0xc0(%rsp), %rbx
18000123b:     	movq	0x60(%rsp), %rcx
180001240:     	xorps	%xmm0, %xmm0
180001243:     	movaps	%xmm0, 0x80(%rsp)
18000124b:     	movaps	%xmm0, 0x90(%rsp)
180001253:     	movaps	%xmm0, 0xa0(%rsp)
18000125b:     	movq	$0x0, 0xb0(%rsp)
180001267:     	leaq	0x80(%rsp), %rdx
18000126f:     	callq	0x180001ba0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7a0>
180001274:     	testl	%eax, %eax
180001276:     	jne	0x180001376 <.text+0x376>
18000127c:     	cmpq	$0x1, 0x98(%rsp)
180001285:     	jne	0x180001376 <.text+0x376>
18000128b:     	movq	0x80(%rsp), %r14
180001293:     	movq	0x58(%rsp), %rcx
180001298:     	callq	0x180002ec7 <numba_list_iter_next+0x2f7>
18000129d:     	testq	%rax, %rax
1800012a0:     	je	0x18000138b <.text+0x38b>
1800012a6:     	movq	%rax, %r12
1800012a9:     	movq	%rax, %rcx
1800012ac:     	callq	0x180002ecd <numba_list_iter_next+0x2fd>
1800012b1:     	movq	%rax, %r15
1800012b4:     	movq	%r12, %rcx
1800012b7:     	callq	0x180002ed3 <numba_list_iter_next+0x303>
1800012bc:     	callq	0x180002ed9 <numba_list_iter_next+0x309>
1800012c1:     	testq	%rax, %rax
1800012c4:     	jne	0x18000139c <.text+0x39c>
1800012ca:     	movq	$0x0, 0x50(%rsp)
1800012d3:     	leaq	0x50(%rsp), %rcx
1800012d8:     	movq	%r15, %rdx
1800012db:     	callq	0x180001090 <.text+0x90>
1800012e0:     	movq	0x50(%rsp), %r15
1800012e5:     	movq	%rsi, %rcx
1800012e8:     	callq	0x180001060 <.text+0x60>
1800012ed:     	movq	%rdi, %rcx
1800012f0:     	callq	0x180001060 <.text+0x60>
1800012f5:     	movq	%rbx, %rcx
1800012f8:     	callq	0x180001060 <.text+0x60>
1800012fd:     	movq	%r14, %rcx
180001300:     	callq	0x180001060 <.text+0x60>
180001305:     	movq	%r15, %rcx
180001308:     	callq	0x180002edf <numba_list_iter_next+0x30f>
18000130d:     	nop
18000130e:     	addq	$0x178, %rsp            # imm = 0x178
180001315:     	popq	%rbx
180001316:     	popq	%rdi
180001317:     	popq	%rsi
180001318:     	popq	%r12
18000131a:     	popq	%r14
18000131c:     	popq	%r15
18000131e:     	retq
18000131f:     	movq	0x2f12(%rip), %rcx      # 0x180004238
180001326:     	leaq	0x30b3(%rip), %rdx      # 0x1800043e0
18000132d:     	callq	0x180002ee5 <numba_list_iter_next+0x315>
180001332:     	jmp	0x1800013bc <.text+0x3bc>
180001337:     	movq	0x2eea(%rip), %rcx      # 0x180004228
18000133e:     	leaq	0x318b(%rip), %rdx      # 0x1800044d0
180001345:     	callq	0x180002ee5 <numba_list_iter_next+0x315>
18000134a:     	jmp	0x1800013bc <.text+0x3bc>
18000134c:     	movq	0x2ed5(%rip), %rcx      # 0x180004228
180001353:     	leaq	0x3176(%rip), %rdx      # 0x1800044d0
18000135a:     	callq	0x180002ee5 <numba_list_iter_next+0x315>
18000135f:     	jmp	0x1800013b4 <.text+0x3b4>
180001361:     	movq	0x2ec0(%rip), %rcx      # 0x180004228
180001368:     	leaq	0x3161(%rip), %rdx      # 0x1800044d0
18000136f:     	callq	0x180002ee5 <numba_list_iter_next+0x315>
180001374:     	jmp	0x1800013ac <.text+0x3ac>
180001376:     	movq	0x2eab(%rip), %rcx      # 0x180004228
18000137d:     	leaq	0x314c(%rip), %rdx      # 0x1800044d0
180001384:     	callq	0x180002ee5 <numba_list_iter_next+0x315>
180001389:     	jmp	0x1800013a4 <.text+0x3a4>
18000138b:     	xorl	%r15d, %r15d
18000138e:     	callq	0x180002ed9 <numba_list_iter_next+0x309>
180001393:     	testq	%rax, %rax
180001396:     	je	0x1800012ca <.text+0x2ca>
18000139c:     	movq	%r14, %rcx
18000139f:     	callq	0x180001060 <.text+0x60>
1800013a4:     	movq	%rbx, %rcx
1800013a7:     	callq	0x180001060 <.text+0x60>
1800013ac:     	movq	%rdi, %rcx
1800013af:     	callq	0x180001060 <.text+0x60>
1800013b4:     	movq	%rsi, %rcx
1800013b7:     	callq	0x180001060 <.text+0x60>
1800013bc:     	xorl	%eax, %eax
1800013be:     	jmp	0x18000130e <.text+0x30e>
1800013c3:     	nopw	%cs:(%rax,%rax)
1800013cd:     	nopl	(%rax)
1800013d0:     	subq	$0x28, %rsp
1800013d4:     	movq	0x110(%rsp), %rdx
1800013dc:     	movq	$0x0, 0x20(%rsp)
1800013e5:     	leaq	0x20(%rsp), %rcx
1800013ea:     	callq	0x180001090 <.text+0x90>
1800013ef:     	movq	0x20(%rsp), %rax
1800013f4:     	addq	$0x28, %rsp
1800013f8:     	retq
1800013f9:     	nopl	(%rax)

0000000180001400 <PyInit_rcnumeric_3d36deac3a8cae31652c24de>:
180001400:     	pushq	%rsi
180001401:     	subq	$0x20, %rsp
180001405:     	leaq	0x8c34(%rip), %rcx      # 0x18000a040
18000140c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001411:     	callq	0x180002eeb <numba_list_iter_next+0x31b>
180001416:     	testq	%rax, %rax
180001419:     	je	0x18000144b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x4b>
18000141b:     	leaq	0x8bde(%rip), %rdx      # 0x18000a000
180001422:     	leaq	0x3157(%rip), %r8       # 0x180004580
180001429:     	leaq	0x3178(%rip), %r9       # 0x1800045a8
180001430:     	movq	%rax, %rcx
180001433:     	movq	%rax, %rsi
180001436:     	callq	0x180001e10 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xa10>
18000143b:     	movl	%eax, %ecx
18000143d:     	xorl	%eax, %eax
18000143f:     	testl	%ecx, %ecx
180001441:     	cmoveq	%rsi, %rax
180001445:     	addq	$0x20, %rsp
180001449:     	popq	%rsi
18000144a:     	retq
18000144b:     	xorl	%eax, %eax
18000144d:     	addq	$0x20, %rsp
180001451:     	popq	%rsi
180001452:     	retq
180001453:     	int3
180001454:     	int3
180001455:     	int3
180001456:     	int3
180001457:     	int3
180001458:     	int3
180001459:     	int3
18000145a:     	int3
18000145b:     	int3
18000145c:     	int3
18000145d:     	int3
18000145e:     	int3
18000145f:     	int3
180001460:     	movq	%rbx, 0x8(%rsp)
180001465:     	movq	%rsi, 0x10(%rsp)
18000146a:     	pushq	%rdi
18000146b:     	subq	$0x20, %rsp
18000146f:     	movq	%rcx, %rbx
180001472:     	movq	%r8, %rdi
180001475:     	movq	0x10(%rcx), %rcx
180001479:     	movq	%rdx, %rsi
18000147c:     	testq	%rcx, %rcx
18000147f:     	je	0x18000148a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x8a>
180001481:     	movq	%r8, %rdx
180001484:     	callq	*%rsi
180001486:     	testl	%eax, %eax
180001488:     	jne	0x1800014ad <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xad>
18000148a:     	movq	0x18(%rbx), %rcx
18000148e:     	testq	%rcx, %rcx
180001491:     	je	0x1800014ab <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xab>
180001493:     	movq	%rdi, %rdx
180001496:     	movq	%rsi, %rax
180001499:     	movq	0x30(%rsp), %rbx
18000149e:     	movq	0x38(%rsp), %rsi
1800014a3:     	addq	$0x20, %rsp
1800014a7:     	popq	%rdi
1800014a8:     	jmpq	*%rax
1800014ab:     	xorl	%eax, %eax
1800014ad:     	movq	0x30(%rsp), %rbx
1800014b2:     	movq	0x38(%rsp), %rsi
1800014b7:     	addq	$0x20, %rsp
1800014bb:     	popq	%rdi
1800014bc:     	retq
1800014bd:     	int3
1800014be:     	int3
1800014bf:     	int3
1800014c0:     	pushq	%rbx
1800014c2:     	subq	$0x20, %rsp
1800014c6:     	movq	%rcx, %rbx
1800014c9:     	movq	0x10(%rcx), %rcx
1800014cd:     	testq	%rcx, %rcx
1800014d0:     	je	0x1800014ed <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xed>
1800014d2:     	movq	$0x0, 0x10(%rbx)
1800014da:     	movl	(%rcx), %eax
1800014dc:     	testl	%eax, %eax
1800014de:     	js	0x1800014ed <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xed>
1800014e0:     	subl	$0x1, %eax
1800014e3:     	movl	%eax, (%rcx)
1800014e5:     	jne	0x1800014ed <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xed>
1800014e7:     	callq	*0x2cc3(%rip)           # 0x1800041b0
1800014ed:     	movq	0x18(%rbx), %rcx
1800014f1:     	testq	%rcx, %rcx
1800014f4:     	je	0x180001511 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x111>
1800014f6:     	movq	$0x0, 0x18(%rbx)
1800014fe:     	movl	(%rcx), %eax
180001500:     	testl	%eax, %eax
180001502:     	js	0x180001511 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x111>
180001504:     	subl	$0x1, %eax
180001507:     	movl	%eax, (%rcx)
180001509:     	jne	0x180001511 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x111>
18000150b:     	callq	*0x2c9f(%rip)           # 0x1800041b0
180001511:     	xorl	%eax, %eax
180001513:     	addq	$0x20, %rsp
180001517:     	popq	%rbx
180001518:     	retq
180001519:     	int3
18000151a:     	int3
18000151b:     	int3
18000151c:     	int3
18000151d:     	int3
18000151e:     	int3
18000151f:     	int3
180001520:     	pushq	%rbx
180001522:     	subq	$0x20, %rsp
180001526:     	movq	%rcx, %rbx
180001529:     	callq	*0x2cc1(%rip)           # 0x1800041f0
18000152f:     	movq	0x10(%rbx), %rcx
180001533:     	testq	%rcx, %rcx
180001536:     	je	0x180001553 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x153>
180001538:     	movq	$0x0, 0x10(%rbx)
180001540:     	movl	(%rcx), %eax
180001542:     	testl	%eax, %eax
180001544:     	js	0x180001553 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x153>
180001546:     	subl	$0x1, %eax
180001549:     	movl	%eax, (%rcx)
18000154b:     	jne	0x180001553 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x153>
18000154d:     	callq	*0x2c5d(%rip)           # 0x1800041b0
180001553:     	movq	0x18(%rbx), %rcx
180001557:     	testq	%rcx, %rcx
18000155a:     	je	0x180001577 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x177>
18000155c:     	movq	$0x0, 0x18(%rbx)
180001564:     	movl	(%rcx), %eax
180001566:     	testl	%eax, %eax
180001568:     	js	0x180001577 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x177>
18000156a:     	subl	$0x1, %eax
18000156d:     	movl	%eax, (%rcx)
18000156f:     	jne	0x180001577 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x177>
180001571:     	callq	*0x2c39(%rip)           # 0x1800041b0
180001577:     	movq	0x8(%rbx), %rax
18000157b:     	movq	%rbx, %rcx
18000157e:     	addq	$0x20, %rsp
180001582:     	popq	%rbx
180001583:     	jmpq	*0x140(%rax)
18000158a:     	int3
18000158b:     	int3
18000158c:     	int3
18000158d:     	int3
18000158e:     	int3
18000158f:     	int3
180001590:     	pushq	%rbx
180001592:     	subq	$0x30, %rsp
180001596:     	movq	%r8, %r10
180001599:     	leaq	0x58(%rsp), %rax
18000159e:     	movq	%rax, 0x28(%rsp)
1800015a3:     	leaq	0x93e6(%rip), %r9       # 0x18000a990
1800015aa:     	movq	0x2c0f(%rip), %rax      # 0x1800041c0
1800015b1:     	leaq	0x3330(%rip), %r8       # 0x1800048e8
1800015b8:     	movq	%rdx, %r11
1800015bb:     	movq	%rax, 0x20(%rsp)
1800015c0:     	movq	%rcx, %rbx
1800015c3:     	movq	%r10, %rdx
1800015c6:     	movq	%r11, %rcx
1800015c9:     	callq	*0x2b11(%rip)           # 0x1800040e0
1800015cf:     	testl	%eax, %eax
1800015d1:     	je	0x18000162c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x22c>
1800015d3:     	xorl	%r8d, %r8d
1800015d6:     	xorl	%edx, %edx
1800015d8:     	movq	%rbx, %rcx
1800015db:     	callq	*0x2c2f(%rip)           # 0x180004210
1800015e1:     	movq	%rax, %rbx
1800015e4:     	testq	%rax, %rax
1800015e7:     	je	0x18000162c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x22c>
1800015e9:     	movq	0x58(%rsp), %rax
1800015ee:     	movl	(%rax), %ecx
1800015f0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800015f6:     	jae	0x180001601 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x201>
1800015f8:     	incl	%ecx
1800015fa:     	movl	%ecx, (%rax)
1800015fc:     	movq	0x58(%rsp), %rax
180001601:     	xorl	%ecx, %ecx
180001603:     	movq	%rax, 0x10(%rbx)
180001607:     	callq	*0x2b63(%rip)           # 0x180004170
18000160d:     	movq	%rax, 0x18(%rbx)
180001611:     	testq	%rax, %rax
180001614:     	jne	0x180001634 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x234>
180001616:     	movl	(%rbx), %eax
180001618:     	testl	%eax, %eax
18000161a:     	js	0x18000162c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x22c>
18000161c:     	subl	$0x1, %eax
18000161f:     	movl	%eax, (%rbx)
180001621:     	jne	0x18000162c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x22c>
180001623:     	movq	%rbx, %rcx
180001626:     	callq	*0x2b84(%rip)           # 0x1800041b0
18000162c:     	xorl	%eax, %eax
18000162e:     	addq	$0x30, %rsp
180001632:     	popq	%rbx
180001633:     	retq
180001634:     	movq	%rbx, %rax
180001637:     	addq	$0x30, %rsp
18000163b:     	popq	%rbx
18000163c:     	retq
18000163d:     	int3
18000163e:     	int3
18000163f:     	int3
180001640:     	movq	%rbx, 0x8(%rsp)
180001645:     	movq	%rsi, 0x10(%rsp)
18000164a:     	pushq	%rdi
18000164b:     	subq	$0x20, %rsp
18000164f:     	movq	%rcx, %rbx
180001652:     	movq	%r8, %rdi
180001655:     	movq	0x18(%rcx), %rcx
180001659:     	movq	%rdx, %rsi
18000165c:     	testq	%rcx, %rcx
18000165f:     	je	0x18000166a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x26a>
180001661:     	movq	%r8, %rdx
180001664:     	callq	*%rsi
180001666:     	testl	%eax, %eax
180001668:     	jne	0x18000168d <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x28d>
18000166a:     	movq	0x40(%rbx), %rcx
18000166e:     	testq	%rcx, %rcx
180001671:     	je	0x18000168b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x28b>
180001673:     	movq	%rdi, %rdx
180001676:     	movq	%rsi, %rax
180001679:     	movq	0x30(%rsp), %rbx
18000167e:     	movq	0x38(%rsp), %rsi
180001683:     	addq	$0x20, %rsp
180001687:     	popq	%rdi
180001688:     	jmpq	*%rax
18000168b:     	xorl	%eax, %eax
18000168d:     	movq	0x30(%rsp), %rbx
180001692:     	movq	0x38(%rsp), %rsi
180001697:     	addq	$0x20, %rsp
18000169b:     	popq	%rdi
18000169c:     	retq
18000169d:     	int3
18000169e:     	int3
18000169f:     	int3
1800016a0:     	pushq	%rbx
1800016a2:     	subq	$0x20, %rsp
1800016a6:     	movq	%rcx, %rbx
1800016a9:     	callq	*0x2b41(%rip)           # 0x1800041f0
1800016af:     	cmpq	$0x0, 0x48(%rbx)
1800016b4:     	je	0x1800016bf <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x2bf>
1800016b6:     	movq	%rbx, %rcx
1800016b9:     	callq	*0x2ac1(%rip)           # 0x180004180
1800016bf:     	movq	0x20(%rbx), %rcx
1800016c3:     	callq	*0x2ad7(%rip)           # 0x1800041a0
1800016c9:     	movq	0x38(%rbx), %rcx
1800016cd:     	callq	*0x2acd(%rip)           # 0x1800041a0
1800016d3:     	movq	0x18(%rbx), %rcx
1800016d7:     	testq	%rcx, %rcx
1800016da:     	je	0x1800016ef <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x2ef>
1800016dc:     	movl	(%rcx), %eax
1800016de:     	testl	%eax, %eax
1800016e0:     	js	0x1800016ef <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x2ef>
1800016e2:     	subl	$0x1, %eax
1800016e5:     	movl	%eax, (%rcx)
1800016e7:     	jne	0x1800016ef <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x2ef>
1800016e9:     	callq	*0x2ac1(%rip)           # 0x1800041b0
1800016ef:     	movq	0x40(%rbx), %rcx
1800016f3:     	testq	%rcx, %rcx
1800016f6:     	je	0x18000170b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x30b>
1800016f8:     	movl	(%rcx), %eax
1800016fa:     	testl	%eax, %eax
1800016fc:     	js	0x18000170b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x30b>
1800016fe:     	subl	$0x1, %eax
180001701:     	movl	%eax, (%rcx)
180001703:     	jne	0x18000170b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x30b>
180001705:     	callq	*0x2aa5(%rip)           # 0x1800041b0
18000170b:     	movq	0x8(%rbx), %rax
18000170f:     	movq	%rbx, %rcx
180001712:     	addq	$0x20, %rsp
180001716:     	popq	%rbx
180001717:     	jmpq	*0x140(%rax)
18000171e:     	int3
18000171f:     	int3
180001720:     	pushq	%rbx
180001722:     	subq	$0x20, %rsp
180001726:     	callq	*0x2a4c(%rip)           # 0x180004178
18000172c:     	movq	%rax, %rbx
18000172f:     	testq	%rax, %rax
180001732:     	jne	0x18000173a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x33a>
180001734:     	addq	$0x20, %rsp
180001738:     	popq	%rbx
180001739:     	retq
18000173a:     	movq	%rbx, %rcx
18000173d:     	movq	%rdi, 0x30(%rsp)
180001742:     	callq	0x180003a55 <numba_list_iter_next+0xe85>
180001747:     	leaq	0x1(%rax), %rcx
18000174b:     	callq	*0x2ac7(%rip)           # 0x180004218
180001751:     	movq	%rax, %rdi
180001754:     	testq	%rax, %rax
180001757:     	jne	0x18000176c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x36c>
180001759:     	callq	*0x29d9(%rip)           # 0x180004138
18000175f:     	movq	0x30(%rsp), %rdi
180001764:     	xorl	%eax, %eax
180001766:     	addq	$0x20, %rsp
18000176a:     	popq	%rbx
18000176b:     	retq
18000176c:     	movq	%rbx, %rdx
18000176f:     	movq	%rdi, %rcx
180001772:     	callq	0x180003a4f <numba_list_iter_next+0xe7f>
180001777:     	movq	%rdi, %rax
18000177a:     	movq	0x30(%rsp), %rdi
18000177f:     	addq	$0x20, %rsp
180001783:     	popq	%rbx
180001784:     	retq
180001785:     	int3
180001786:     	int3
180001787:     	int3
180001788:     	int3
180001789:     	int3
18000178a:     	int3
18000178b:     	int3
18000178c:     	int3
18000178d:     	int3
18000178e:     	int3
18000178f:     	int3
180001790:     	movq	0x18(%rcx), %rcx
180001794:     	movq	%rdx, %rax
180001797:     	testq	%rcx, %rcx
18000179a:     	je	0x1800017a2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x3a2>
18000179c:     	movq	%r8, %rdx
18000179f:     	jmpq	*%rax
1800017a2:     	xorl	%eax, %eax
1800017a4:     	retq
1800017a5:     	int3
1800017a6:     	int3
1800017a7:     	int3
1800017a8:     	int3
1800017a9:     	int3
1800017aa:     	int3
1800017ab:     	int3
1800017ac:     	int3
1800017ad:     	int3
1800017ae:     	int3
1800017af:     	int3
1800017b0:     	movq	%rbx, 0x8(%rsp)
1800017b5:     	pushq	%rdi
1800017b6:     	subq	$0x20, %rsp
1800017ba:     	movq	0x28(%rcx), %rax
1800017be:     	xorl	%edi, %edi
1800017c0:     	movq	%rcx, %rbx
1800017c3:     	testq	%rax, %rax
1800017c6:     	je	0x1800017d2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x3d2>
1800017c8:     	addq	$0x38, %rcx
1800017cc:     	callq	*%rax
1800017ce:     	movq	%rdi, 0x28(%rbx)
1800017d2:     	movq	0x18(%rbx), %rcx
1800017d6:     	testq	%rcx, %rcx
1800017d9:     	je	0x1800017f2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x3f2>
1800017db:     	movq	%rdi, 0x18(%rbx)
1800017df:     	movl	(%rcx), %eax
1800017e1:     	testl	%eax, %eax
1800017e3:     	js	0x1800017f2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x3f2>
1800017e5:     	subl	$0x1, %eax
1800017e8:     	movl	%eax, (%rcx)
1800017ea:     	jne	0x1800017f2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x3f2>
1800017ec:     	callq	*0x29be(%rip)           # 0x1800041b0
1800017f2:     	movq	%rdi, 0x20(%rbx)
1800017f6:     	xorl	%eax, %eax
1800017f8:     	movq	0x30(%rsp), %rbx
1800017fd:     	addq	$0x20, %rsp
180001801:     	popq	%rdi
180001802:     	retq
180001803:     	int3
180001804:     	int3
180001805:     	int3
180001806:     	int3
180001807:     	int3
180001808:     	int3
180001809:     	int3
18000180a:     	int3
18000180b:     	int3
18000180c:     	int3
18000180d:     	int3
18000180e:     	int3
18000180f:     	int3
180001810:     	pushq	%rbx
180001812:     	subq	$0x20, %rsp
180001816:     	movq	%rcx, %rbx
180001819:     	callq	*0x29d1(%rip)           # 0x1800041f0
18000181f:     	cmpq	$0x0, 0x30(%rbx)
180001824:     	je	0x18000182f <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x42f>
180001826:     	movq	%rbx, %rcx
180001829:     	callq	*0x2951(%rip)           # 0x180004180
18000182f:     	callq	*0x28fb(%rip)           # 0x180004130
180001835:     	testl	%eax, %eax
180001837:     	jne	0x180001848 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x448>
180001839:     	movq	0x28(%rbx), %rax
18000183d:     	testq	%rax, %rax
180001840:     	je	0x180001848 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x448>
180001842:     	leaq	0x38(%rbx), %rcx
180001846:     	callq	*%rax
180001848:     	movq	0x18(%rbx), %rcx
18000184c:     	testq	%rcx, %rcx
18000184f:     	je	0x180001864 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x464>
180001851:     	movl	(%rcx), %eax
180001853:     	testl	%eax, %eax
180001855:     	js	0x180001864 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x464>
180001857:     	subl	$0x1, %eax
18000185a:     	movl	%eax, (%rcx)
18000185c:     	jne	0x180001864 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x464>
18000185e:     	callq	*0x294c(%rip)           # 0x1800041b0
180001864:     	movq	0x8(%rbx), %rax
180001868:     	movq	%rbx, %rcx
18000186b:     	addq	$0x20, %rsp
18000186f:     	popq	%rbx
180001870:     	jmpq	*0x140(%rax)
180001877:     	int3
180001878:     	int3
180001879:     	int3
18000187a:     	int3
18000187b:     	int3
18000187c:     	int3
18000187d:     	int3
18000187e:     	int3
18000187f:     	int3
180001880:     	pushq	%rdi
180001882:     	subq	$0x20, %rsp
180001886:     	cmpq	$0x0, 0x20(%rcx)
18000188b:     	movq	%rcx, %rdi
18000188e:     	jne	0x1800018af <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x4af>
180001890:     	movq	0x29a1(%rip), %rcx      # 0x180004238
180001897:     	leaq	0x309a(%rip), %rdx      # 0x180004938
18000189e:     	movq	(%rcx), %rcx
1800018a1:     	callq	*0x2989(%rip)           # 0x180004230
1800018a7:     	xorl	%eax, %eax
1800018a9:     	addq	$0x20, %rsp
1800018ad:     	popq	%rdi
1800018ae:     	retq
1800018af:     	movq	%rdi, %rdx
1800018b2:     	movq	%rbx, 0x30(%rsp)
1800018b7:     	movl	$0x1, %ecx
1800018bc:     	callq	*0x282e(%rip)           # 0x1800040f0
1800018c2:     	movq	%rax, %rbx
1800018c5:     	testq	%rax, %rax
1800018c8:     	jne	0x1800018d5 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x4d5>
1800018ca:     	movq	0x30(%rsp), %rbx
1800018cf:     	addq	$0x20, %rsp
1800018d3:     	popq	%rdi
1800018d4:     	retq
1800018d5:     	xorl	%r8d, %r8d
1800018d8:     	movq	%rbx, %rdx
1800018db:     	movq	%rdi, %rcx
1800018de:     	callq	*0x20(%rdi)
1800018e1:     	movl	(%rbx), %ecx
1800018e3:     	movq	%rax, %rdi
1800018e6:     	testl	%ecx, %ecx
1800018e8:     	js	0x1800018fa <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x4fa>
1800018ea:     	subl	$0x1, %ecx
1800018ed:     	movl	%ecx, (%rbx)
1800018ef:     	jne	0x1800018fa <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x4fa>
1800018f1:     	movq	%rbx, %rcx
1800018f4:     	callq	*0x28b6(%rip)           # 0x1800041b0
1800018fa:     	movq	0x30(%rsp), %rbx
1800018ff:     	movq	%rdi, %rax
180001902:     	addq	$0x20, %rsp
180001906:     	popq	%rdi
180001907:     	retq
180001908:     	int3
180001909:     	int3
18000190a:     	int3
18000190b:     	int3
18000190c:     	int3
18000190d:     	int3
18000190e:     	int3
18000190f:     	int3
180001910:     	movq	%rbx, 0x8(%rsp)
180001915:     	pushq	%rdi
180001916:     	subq	$0x20, %rsp
18000191a:     	movq	%r8, %rbx
18000191d:     	callq	*0x27f5(%rip)           # 0x180004118
180001923:     	movl	(%rbx), %ecx
180001925:     	movl	%eax, %edi
180001927:     	testl	%ecx, %ecx
180001929:     	js	0x18000193b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x53b>
18000192b:     	subl	$0x1, %ecx
18000192e:     	movl	%ecx, (%rbx)
180001930:     	jne	0x18000193b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x53b>
180001932:     	movq	%rbx, %rcx
180001935:     	callq	*0x2875(%rip)           # 0x1800041b0
18000193b:     	movl	%edi, %ecx
18000193d:     	movq	0x30(%rsp), %rbx
180001942:     	addq	$0x20, %rsp
180001946:     	popq	%rdi
180001947:     	jmpq	*0x289a(%rip)           # 0x1800041e8
18000194e:     	int3
18000194f:     	int3
180001950:     	movq	%rbx, 0x8(%rsp)
180001955:     	pushq	%rdi
180001956:     	subq	$0x20, %rsp
18000195a:     	movl	(%rdx), %eax
18000195c:     	movq	%rdx, %rbx
18000195f:     	movq	%rcx, %rdi
180001962:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001967:     	jae	0x18000196d <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x56d>
180001969:     	incl	%eax
18000196b:     	movl	%eax, (%rdx)
18000196d:     	movl	$0x30, %ecx
180001972:     	callq	*0x92b0(%rip)           # 0x18000ac28
180001978:     	cmpb	$0x0, 0x9281(%rip)      # 0x18000ac00
18000197f:     	je	0x180001989 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x589>
180001981:     	lock
180001982:     	incq	0x927f(%rip)            # 0x18000ac08
180001989:     	testq	%rax, %rax
18000198c:     	je	0x1800019c3 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x5c3>
18000198e:     	movl	$0x1, %ecx
180001993:     	leaq	-0x8a(%rip), %rdx       # 0x180001910 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x510>
18000199a:     	xchgq	%rcx, (%rax)
18000199d:     	xorl	%ecx, %ecx
18000199f:     	movq	%rdx, 0x8(%rax)
1800019a3:     	movq	%rcx, 0x20(%rax)
1800019a7:     	movq	%rcx, 0x28(%rax)
1800019ab:     	movq	%rbx, 0x10(%rax)
1800019af:     	movq	%rdi, 0x18(%rax)
1800019b3:     	cmpb	%cl, 0x9247(%rip)       # 0x18000ac00
1800019b9:     	je	0x1800019c3 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x5c3>
1800019bb:     	lock
1800019bc:     	incq	0x9255(%rip)            # 0x18000ac18
1800019c3:     	movq	0x30(%rsp), %rbx
1800019c8:     	addq	$0x20, %rsp
1800019cc:     	popq	%rdi
1800019cd:     	retq
1800019ce:     	int3
1800019cf:     	int3
1800019d0:     	movq	%rbx, 0x8(%rsp)
1800019d5:     	pushq	%rdi
1800019d6:     	subq	$0x30, %rsp
1800019da:     	movq	%rcx, %rdi
1800019dd:     	leaq	0x8f9c(%rip), %r9       # 0x18000a980
1800019e4:     	movq	%r8, %rax
1800019e7:     	leaq	0x58(%rsp), %rcx
1800019ec:     	movq	%rdx, %r10
1800019ef:     	movq	%rcx, 0x20(%rsp)
1800019f4:     	movq	%r10, %rcx
1800019f7:     	leaq	0x2f82(%rip), %r8       # 0x180004980
1800019fe:     	movq	%rax, %rdx
180001a01:     	callq	*0x26d9(%rip)           # 0x1800040e0
180001a07:     	testl	%eax, %eax
180001a09:     	je	0x180001a33 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x633>
180001a0b:     	movq	0x58(%rsp), %rcx
180001a10:     	callq	*0x2712(%rip)           # 0x180004128
180001a16:     	movq	%rax, %rbx
180001a19:     	callq	*0x2829(%rip)           # 0x180004248
180001a1f:     	testq	%rax, %rax
180001a22:     	jne	0x180001a33 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x633>
180001a24:     	movq	%rbx, 0x10(%rdi)
180001a28:     	movq	0x40(%rsp), %rbx
180001a2d:     	addq	$0x30, %rsp
180001a31:     	popq	%rdi
180001a32:     	retq
180001a33:     	movq	0x40(%rsp), %rbx
180001a38:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001a3d:     	addq	$0x30, %rsp
180001a41:     	popq	%rdi
180001a42:     	retq
180001a43:     	int3
180001a44:     	int3
180001a45:     	int3
180001a46:     	int3
180001a47:     	int3
180001a48:     	int3
180001a49:     	int3
180001a4a:     	int3
180001a4b:     	int3
180001a4c:     	int3
180001a4d:     	int3
180001a4e:     	int3
180001a4f:     	int3
180001a50:     	subq	$0x38, %rsp
180001a54:     	movl	%r8d, %eax
180001a57:     	movq	%rdx, %r10
180001a5a:     	movq	0x10(%rcx), %r8
180001a5e:     	movq	%rcx, %rdx
180001a61:     	movl	%eax, 0x28(%rsp)
180001a65:     	movq	%r10, %rcx
180001a68:     	movl	$0x0, 0x20(%rsp)
180001a70:     	movq	0x20(%r8), %r9
180001a74:     	movq	0x18(%r8), %r8
180001a78:     	callq	*0x275a(%rip)           # 0x1800041d8
180001a7e:     	addq	$0x38, %rsp
180001a82:     	retq
180001a83:     	int3
180001a84:     	int3
180001a85:     	int3
180001a86:     	int3
180001a87:     	int3
180001a88:     	int3
180001a89:     	int3
180001a8a:     	int3
180001a8b:     	int3
180001a8c:     	int3
180001a8d:     	int3
180001a8e:     	int3
180001a8f:     	int3
180001a90:     	movq	0x10(%rcx), %rax
180001a94:     	lock
180001a95:     	incq	(%rax)
180001a98:     	movq	0x2741(%rip), %rax      # 0x1800041e0
180001a9f:     	retq
180001aa0:     	subq	$0x28, %rsp
180001aa4:     	movq	0x10(%rcx), %rcx
180001aa8:     	callq	0x180002da0 <numba_list_iter_next+0x1d0>
180001aad:     	movq	0x272c(%rip), %rax      # 0x1800041e0
180001ab4:     	addq	$0x28, %rsp
180001ab8:     	retq
180001ab9:     	int3
180001aba:     	int3
180001abb:     	int3
180001abc:     	int3
180001abd:     	int3
180001abe:     	int3
180001abf:     	int3
180001ac0:     	movq	0x10(%rcx), %rcx
180001ac4:     	movq	0x18(%rcx), %rcx
180001ac8:     	jmpq	*0x2681(%rip)           # 0x180004150
180001acf:     	int3
180001ad0:     	subq	$0x28, %rsp
180001ad4:     	movq	0x10(%rcx), %rax
180001ad8:     	testq	%rax, %rax
180001adb:     	je	0x180001af9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x6f9>
180001add:     	cmpq	$0x0, 0x18(%rax)
180001ae2:     	je	0x180001af9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x6f9>
180001ae4:     	movq	(%rax), %rcx
180001ae7:     	nop
180001ae8:     	cmpq	$-0x1, %rcx
180001aec:     	je	0x180001af9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x6f9>
180001aee:     	addq	$0x28, %rsp
180001af2:     	jmpq	*0x260f(%rip)           # 0x180004108
180001af9:     	movq	0x26d0(%rip), %rcx      # 0x1800041d0
180001b00:     	leaq	0x2e81(%rip), %rdx      # 0x180004988
180001b07:     	movq	(%rcx), %rcx
180001b0a:     	callq	*0x2720(%rip)           # 0x180004230
180001b10:     	xorl	%eax, %eax
180001b12:     	addq	$0x28, %rsp
180001b16:     	retq
180001b17:     	int3
180001b18:     	int3
180001b19:     	int3
180001b1a:     	int3
180001b1b:     	int3
180001b1c:     	int3
180001b1d:     	int3
180001b1e:     	int3
180001b1f:     	int3
180001b20:     	movq	0x10(%rcx), %rcx
180001b24:     	movq	0x28(%rcx), %rcx
180001b28:     	jmpq	*0x2621(%rip)           # 0x180004150
180001b2f:     	int3
180001b30:     	movq	0x10(%rcx), %rax
180001b34:     	movq	0x10(%rax), %rax
180001b38:     	testq	%rax, %rax
180001b3b:     	je	0x180001b4c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x74c>
180001b3d:     	movl	(%rax), %ecx
180001b3f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001b45:     	jae	0x180001b6a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x76a>
180001b47:     	incl	%ecx
180001b49:     	movl	%ecx, (%rax)
180001b4b:     	retq
180001b4c:     	movq	0x268d(%rip), %rcx      # 0x1800041e0
180001b53:     	movl	(%rcx), %eax
180001b55:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001b5a:     	jae	0x180001b67 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x767>
180001b5c:     	incl	%eax
180001b5e:     	movl	%eax, (%rcx)
180001b60:     	movq	0x2679(%rip), %rcx      # 0x1800041e0
180001b67:     	movq	%rcx, %rax
180001b6a:     	retq
180001b6b:     	int3
180001b6c:     	int3
180001b6d:     	int3
180001b6e:     	int3
180001b6f:     	int3
180001b70:     	pushq	%rbx
180001b72:     	subq	$0x20, %rsp
180001b76:     	movq	%rcx, %rbx
180001b79:     	movq	0x10(%rcx), %rcx
180001b7d:     	callq	0x180002da0 <numba_list_iter_next+0x1d0>
180001b82:     	movq	0x8(%rbx), %rax
180001b86:     	movq	%rbx, %rcx
180001b89:     	addq	$0x20, %rsp
180001b8d:     	popq	%rbx
180001b8e:     	jmpq	*0x140(%rax)
180001b95:     	int3
180001b96:     	int3
180001b97:     	int3
180001b98:     	int3
180001b99:     	int3
180001b9a:     	int3
180001b9b:     	int3
180001b9c:     	int3
180001b9d:     	int3
180001b9e:     	int3
180001b9f:     	int3
180001ba0:     	movq	%rdi, 0x18(%rsp)
180001ba5:     	pushq	%r14
180001ba7:     	subq	$0x20, %rsp
180001bab:     	movq	0x908e(%rip), %rax      # 0x18000ac40
180001bb2:     	movq	%rdx, %r14
180001bb5:     	movq	%rcx, %rdi
180001bb8:     	movq	0x8(%rcx), %rcx
180001bbc:     	movq	0x10(%rax), %rdx
180001bc0:     	cmpq	%rdx, %rcx
180001bc3:     	je	0x180001be0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7e0>
180001bc5:     	callq	*0x25ed(%rip)           # 0x1800041b8
180001bcb:     	testl	%eax, %eax
180001bcd:     	jne	0x180001be0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x7e0>
180001bcf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001bd4:     	movq	0x40(%rsp), %rdi
180001bd9:     	addq	$0x20, %rsp
180001bdd:     	popq	%r14
180001bdf:     	retq
180001be0:     	movq	%rbx, 0x30(%rsp)
180001be5:     	movq	%rdi, %rdx
180001be8:     	movq	0x10(%rdi), %rbx
180001bec:     	movq	%rbx, %rcx
180001bef:     	movq	%rsi, 0x38(%rsp)
180001bf4:     	movl	0x18(%rdi), %esi
180001bf7:     	callq	0x180001950 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x550>
180001bfc:     	movq	%rax, (%r14)
180001bff:     	movq	0x903a(%rip), %rax      # 0x18000ac40
180001c06:     	movq	%rbx, 0x20(%r14)
180001c0a:     	movl	0x18(%rdi), %edx
180001c0d:     	movq	0x20(%rdi), %rcx
180001c11:     	callq	*0x4f0(%rax)
180001c17:     	cmpl	$0x12, 0x902e(%rip)     # 0x18000ac4c
180001c1e:     	movq	0x30(%rsp), %rbx
180001c23:     	movq	%rax, 0x10(%r14)
180001c27:     	movq	0x38(%rdi), %rax
180001c2b:     	jl	0x180001c33 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x833>
180001c2d:     	movq	0x28(%rax), %rax
180001c31:     	jmp	0x180001c37 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x837>
180001c33:     	movslq	0x20(%rax), %rax
180001c37:     	xorl	%r8d, %r8d
180001c3a:     	movq	%rax, 0x18(%r14)
180001c3e:     	movq	%rdi, 0x8(%r14)
180001c42:     	leaq	0x28(%r14), %rax
180001c46:     	testl	%esi, %esi
180001c48:     	jle	0x180001c8b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x88b>
180001c4a:     	nopw	(%rax,%rax)
180001c50:     	movq	0x20(%rdi), %rcx
180001c54:     	movq	(%rcx,%r8,8), %rdx
180001c58:     	incl	%r8d
180001c5b:     	movq	%rdx, (%rax)
180001c5e:     	addq	$0x8, %rax
180001c62:     	cmpl	%esi, %r8d
180001c65:     	jl	0x180001c50 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x850>
180001c67:     	xorl	%r8d, %r8d
180001c6a:     	nopw	(%rax,%rax)
180001c70:     	movq	0x28(%rdi), %rcx
180001c74:     	leaq	0x8(%rax), %rax
180001c78:     	movslq	%r8d, %rdx
180001c7b:     	incl	%r8d
180001c7e:     	movq	(%rcx,%rdx,8), %rdx
180001c82:     	movq	%rdx, -0x8(%rax)
180001c86:     	cmpl	%esi, %r8d
180001c89:     	jl	0x180001c70 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x870>
180001c8b:     	movq	0x38(%rsp), %rsi
180001c90:     	xorl	%eax, %eax
180001c92:     	movq	0x40(%rsp), %rdi
180001c97:     	addq	$0x20, %rsp
180001c9b:     	popq	%r14
180001c9d:     	retq
180001c9e:     	int3
180001c9f:     	int3
180001ca0:     	pushq	%rbx
180001ca2:     	pushq	%rbp
180001ca3:     	pushq	%rsi
180001ca4:     	pushq	%rdi
180001ca5:     	subq	$0x28, %rsp
180001ca9:     	cmpq	$0x0, 0x8f9f(%rip)      # 0x18000ac50
180001cb1:     	movq	%rcx, %rbp
180001cb4:     	movslq	0x8(%rdx), %rdi
180001cb8:     	movq	(%rdx), %rsi
180001cbb:     	jne	0x180001d13 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x913>
180001cbd:     	leaq	0x2c04(%rip), %rcx      # 0x1800048c8
180001cc4:     	callq	*0x253e(%rip)           # 0x180004208
180001cca:     	movq	%rax, %rbx
180001ccd:     	testq	%rax, %rax
180001cd0:     	je	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001cd6:     	leaq	0x2bf3(%rip), %rdx      # 0x1800048d0
180001cdd:     	movq	%rax, %rcx
180001ce0:     	callq	*0x247a(%rip)           # 0x180004160
180001ce6:     	movl	(%rbx), %edx
180001ce8:     	movq	%rax, 0x8f61(%rip)      # 0x18000ac50
180001cef:     	testl	%edx, %edx
180001cf1:     	js	0x180001d0a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x90a>
180001cf3:     	subl	$0x1, %edx
180001cf6:     	movl	%edx, (%rbx)
180001cf8:     	jne	0x180001d0a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x90a>
180001cfa:     	movq	%rbx, %rcx
180001cfd:     	callq	*0x24ad(%rip)           # 0x1800041b0
180001d03:     	movq	0x8f46(%rip), %rax      # 0x18000ac50
180001d0a:     	testq	%rax, %rax
180001d0d:     	je	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001d13:     	movq	%rdi, %rdx
180001d16:     	movq	%rsi, %rcx
180001d19:     	callq	*0x2401(%rip)           # 0x180004120
180001d1f:     	movq	%rax, %rdi
180001d22:     	testq	%rax, %rax
180001d25:     	je	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001d27:     	movq	0x8f22(%rip), %rcx      # 0x18000ac50
180001d2e:     	xorl	%r8d, %r8d
180001d31:     	movq	%rax, %rdx
180001d34:     	callq	*0x244e(%rip)           # 0x180004188
180001d3a:     	movl	(%rdi), %ecx
180001d3c:     	movq	%rax, %rbx
180001d3f:     	testl	%ecx, %ecx
180001d41:     	js	0x180001d53 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x953>
180001d43:     	subl	$0x1, %ecx
180001d46:     	movl	%ecx, (%rdi)
180001d48:     	jne	0x180001d53 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x953>
180001d4a:     	movq	%rdi, %rcx
180001d4d:     	callq	*0x245d(%rip)           # 0x1800041b0
180001d53:     	testq	%rbx, %rbx
180001d56:     	je	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001d58:     	movq	0x8(%rbx), %r8
180001d5c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001d67:     	jne	0x180001da5 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x9a5>
180001d69:     	movq	0x24b8(%rip), %rcx      # 0x180004228
180001d70:     	leaq	0x2d19(%rip), %rdx      # 0x180004a90
180001d77:     	movq	0x18(%r8), %r8
180001d7b:     	movq	(%rcx), %rcx
180001d7e:     	callq	*0x2444(%rip)           # 0x1800041c8
180001d84:     	movl	(%rbx), %eax
180001d86:     	testl	%eax, %eax
180001d88:     	js	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001d8a:     	subl	$0x1, %eax
180001d8d:     	movl	%eax, (%rbx)
180001d8f:     	jne	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001d91:     	movq	%rbx, %rcx
180001d94:     	callq	*0x2416(%rip)           # 0x1800041b0
180001d9a:     	xorl	%eax, %eax
180001d9c:     	addq	$0x28, %rsp
180001da0:     	popq	%rdi
180001da1:     	popq	%rsi
180001da2:     	popq	%rbp
180001da3:     	popq	%rbx
180001da4:     	retq
180001da5:     	xorl	%r8d, %r8d
180001da8:     	leaq	0x8551(%rip), %rcx      # 0x18000a300
180001daf:     	xorl	%edx, %edx
180001db1:     	callq	*0x2459(%rip)           # 0x180004210
180001db7:     	movq	%rax, %rdi
180001dba:     	testq	%rax, %rax
180001dbd:     	je	0x180001d84 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x984>
180001dbf:     	movq	%rbp, %rcx
180001dc2:     	movq	%rbx, 0x18(%rax)
180001dc6:     	callq	*0x23dc(%rip)           # 0x1800041a8
180001dcc:     	movq	%rax, 0x10(%rdi)
180001dd0:     	movq	%rax, %rcx
180001dd3:     	testq	%rax, %rax
180001dd6:     	jne	0x180001dea <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x9ea>
180001dd8:     	movl	(%rdi), %eax
180001dda:     	testl	%eax, %eax
180001ddc:     	js	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001dde:     	subl	$0x1, %eax
180001de1:     	movl	%eax, (%rdi)
180001de3:     	jne	0x180001d9a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x99a>
180001de5:     	movq	%rdi, %rcx
180001de8:     	jmp	0x180001d94 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x994>
180001dea:     	movl	(%rax), %eax
180001dec:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001df1:     	jae	0x180001df7 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x9f7>
180001df3:     	incl	%eax
180001df5:     	movl	%eax, (%rcx)
180001df7:     	movq	%rdi, %rax
180001dfa:     	addq	$0x28, %rsp
180001dfe:     	popq	%rdi
180001dff:     	popq	%rsi
180001e00:     	popq	%rbp
180001e01:     	popq	%rbx
180001e02:     	retq
180001e03:     	int3
180001e04:     	int3
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
180001e10:     	movq	%r9, 0x20(%rsp)
180001e15:     	movq	%r8, 0x18(%rsp)
180001e1a:     	movq	%rdx, 0x10(%rsp)
180001e1f:     	movq	%rcx, 0x8(%rsp)
180001e24:     	pushq	%rbx
180001e25:     	pushq	%rbp
180001e26:     	pushq	%rsi
180001e27:     	pushq	%rdi
180001e28:     	pushq	%r12
180001e2a:     	pushq	%r13
180001e2c:     	pushq	%r14
180001e2e:     	pushq	%r15
180001e30:     	subq	$0x68, %rsp
180001e34:     	movq	%rcx, %r14
180001e37:     	movq	%r9, %r15
180001e3a:     	leaq	0x278f(%rip), %rcx      # 0x1800045d0
180001e41:     	movq	%r8, %r13
180001e44:     	movq	%rdx, %rsi
180001e47:     	callq	*0x23bb(%rip)           # 0x180004208
180001e4d:     	movq	%rax, %rdi
180001e50:     	testq	%rax, %rax
180001e53:     	jne	0x180001e8c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xa8c>
180001e55:     	movq	0x22b4(%rip), %rcx      # 0x180004110
180001e5c:     	movq	(%rcx), %rcx
180001e5f:     	callq	*0x2333(%rip)           # 0x180004198
180001e65:     	testl	%eax, %eax
180001e67:     	je	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001e6d:     	callq	*0x22e5(%rip)           # 0x180004158
180001e73:     	leaq	0x2776(%rip), %rcx      # 0x1800045f0
180001e7a:     	callq	*0x2388(%rip)           # 0x180004208
180001e80:     	movq	%rax, %rdi
180001e83:     	testq	%rax, %rax
180001e86:     	je	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001e8c:     	leaq	0x277d(%rip), %rdx      # 0x180004610
180001e93:     	movq	%rdi, %rcx
180001e96:     	callq	*0x22c4(%rip)           # 0x180004160
180001e9c:     	movl	(%rdi), %ecx
180001e9e:     	movq	%rax, %rbx
180001ea1:     	testl	%ecx, %ecx
180001ea3:     	js	0x180001eb5 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xab5>
180001ea5:     	subl	$0x1, %ecx
180001ea8:     	movl	%ecx, (%rdi)
180001eaa:     	jne	0x180001eb5 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xab5>
180001eac:     	movq	%rdi, %rcx
180001eaf:     	callq	*0x22fb(%rip)           # 0x1800041b0
180001eb5:     	testq	%rbx, %rbx
180001eb8:     	je	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001ebe:     	movq	0x2223(%rip), %rax      # 0x1800040e8
180001ec5:     	cmpq	%rax, 0x8(%rbx)
180001ec9:     	je	0x180001f05 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb05>
180001ecb:     	movq	0x2366(%rip), %rcx      # 0x180004238
180001ed2:     	leaq	0x2747(%rip), %rdx      # 0x180004620
180001ed9:     	movq	(%rcx), %rcx
180001edc:     	callq	*0x234e(%rip)           # 0x180004230
180001ee2:     	movl	(%rbx), %eax
180001ee4:     	testl	%eax, %eax
180001ee6:     	js	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001eec:     	subl	$0x1, %eax
180001eef:     	movl	%eax, (%rbx)
180001ef1:     	jne	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001ef7:     	movq	%rbx, %rcx
180001efa:     	callq	*0x22b0(%rip)           # 0x1800041b0
180001f00:     	jmp	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001f05:     	xorl	%edx, %edx
180001f07:     	movq	%rbx, %rcx
180001f0a:     	callq	*0x2280(%rip)           # 0x180004190
180001f10:     	movl	(%rbx), %ecx
180001f12:     	movq	%rax, 0x8d27(%rip)      # 0x18000ac40
180001f19:     	testl	%ecx, %ecx
180001f1b:     	js	0x180001f34 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb34>
180001f1d:     	subl	$0x1, %ecx
180001f20:     	movl	%ecx, (%rbx)
180001f22:     	jne	0x180001f34 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb34>
180001f24:     	movq	%rbx, %rcx
180001f27:     	callq	*0x2283(%rip)           # 0x1800041b0
180001f2d:     	movq	0x8d0c(%rip), %rax      # 0x18000ac40
180001f34:     	testq	%rax, %rax
180001f37:     	jne	0x180001f52 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb52>
180001f39:     	leaq	0x2708(%rip), %rdx      # 0x180004648
180001f40:     	movq	0x22f1(%rip), %rcx      # 0x180004238
180001f47:     	movq	(%rcx), %rcx
180001f4a:     	callq	*0x22e0(%rip)           # 0x180004230
180001f50:     	jmp	0x180001f87 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb87>
180001f52:     	callq	*(%rax)
180001f54:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180001f59:     	jbe	0x180001fba <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xbba>
180001f5b:     	movq	0x22d6(%rip), %rax      # 0x180004238
180001f62:     	movq	(%rax), %rbx
180001f65:     	movq	0x8cd4(%rip), %rax      # 0x18000ac40
180001f6c:     	callq	*(%rax)
180001f6e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180001f74:     	leaq	0x26f5(%rip), %rdx      # 0x180004670
180001f7b:     	movl	%eax, %r9d
180001f7e:     	movq	%rbx, %rcx
180001f81:     	callq	*0x2241(%rip)           # 0x1800041c8
180001f87:     	callq	*0x22db(%rip)           # 0x180004268
180001f8d:     	movq	0x2164(%rip), %rcx      # 0x1800040f8
180001f94:     	leaq	0x28fd(%rip), %rdx      # 0x180004898
180001f9b:     	movq	(%rcx), %rcx
180001f9e:     	callq	*0x228c(%rip)           # 0x180004230
180001fa4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001fa9:     	addq	$0x68, %rsp
180001fad:     	popq	%r15
180001faf:     	popq	%r14
180001fb1:     	popq	%r13
180001fb3:     	popq	%r12
180001fb5:     	popq	%rdi
180001fb6:     	popq	%rsi
180001fb7:     	popq	%rbp
180001fb8:     	popq	%rbx
180001fb9:     	retq
180001fba:     	movq	0x8c7f(%rip), %rax      # 0x18000ac40
180001fc1:     	callq	*0x698(%rax)
180001fc7:     	movl	%eax, 0x8c7f(%rip)      # 0x18000ac4c
180001fcd:     	cmpl	$0x10, %eax
180001fd0:     	jge	0x180001fee <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xbee>
180001fd2:     	movq	0x225f(%rip), %rcx      # 0x180004238
180001fd9:     	leaq	0x26e0(%rip), %rdx      # 0x1800046c0
180001fe0:     	movl	%eax, %r9d
180001fe3:     	movl	$0x10, %r8d
180001fe9:     	movq	(%rcx), %rcx
180001fec:     	jmp	0x180001f81 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb81>
180001fee:     	movq	0x8c4b(%rip), %rax      # 0x18000ac40
180001ff5:     	callq	*0x690(%rax)
180001ffb:     	testl	%eax, %eax
180001ffd:     	jne	0x18000200b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xc0b>
180001fff:     	leaq	0x280a(%rip), %rdx      # 0x180004810
180002006:     	jmp	0x180001f40 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb40>
18000200b:     	cmpl	$0x1, %eax
18000200e:     	je	0x18000201c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xc1c>
180002010:     	leaq	0x2829(%rip), %rdx      # 0x180004840
180002017:     	jmp	0x180001f40 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xb40>
18000201c:     	leaq	0x87bd(%rip), %rcx      # 0x18000a7e0
180002023:     	callq	*0x213f(%rip)           # 0x180004168
180002029:     	testl	%eax, %eax
18000202b:     	jne	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
180002031:     	leaq	0x82c8(%rip), %rcx      # 0x18000a300
180002038:     	callq	*0x212a(%rip)           # 0x180004168
18000203e:     	testl	%eax, %eax
180002040:     	jne	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
180002046:     	leaq	0x85f3(%rip), %rcx      # 0x18000a640
18000204d:     	callq	*0x2115(%rip)           # 0x180004168
180002053:     	testl	%eax, %eax
180002055:     	jne	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
18000205b:     	xorl	%ebx, %ebx
18000205d:     	cmpl	%ebx, 0x8be5(%rip)      # 0x18000ac48
180002063:     	jne	0x1800020a6 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xca6>
180002065:     	movq	%gs:0x58, %rax
18000206e:     	movl	0x8be4(%rip), %ecx      # 0x18000ac58
180002074:     	movl	$0x1, 0x8bca(%rip)      # 0x18000ac48
18000207e:     	movq	(%rax,%rcx,8), %rdx
180002082:     	movl	$0x10, %eax
180002087:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000208e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002093:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000209a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000209f:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800020a6:     	movl	%ebx, 0x8b4c(%rip)      # 0x18000abf8
1800020ac:     	movq	%rbx, %rax
1800020af:     	movb	%bl, 0x8b4b(%rip)       # 0x18000ac00
1800020b5:     	movq	%rbx, %rcx
1800020b8:     	xchgq	%rax, 0x8b49(%rip)      # 0x18000ac08
1800020bf:     	xchgq	%rcx, 0x8b4a(%rip)      # 0x18000ac10
1800020c6:     	movq	%rbx, %rax
1800020c9:     	movq	%rbx, %rcx
1800020cc:     	xchgq	%rax, 0x8b45(%rip)      # 0x18000ac18
1800020d3:     	xchgq	%rcx, 0x8b46(%rip)      # 0x18000ac20
1800020da:     	movq	0x1f7f(%rip), %rax      # 0x180004060
1800020e1:     	leaq	0x83b8(%rip), %rcx      # 0x18000a4a0
1800020e8:     	movq	%rax, 0x8b39(%rip)      # 0x18000ac28
1800020ef:     	movq	0x1f7a(%rip), %rax      # 0x180004070
1800020f6:     	movq	%rax, 0x8b33(%rip)      # 0x18000ac30
1800020fd:     	movq	0x1f64(%rip), %rax      # 0x180004068
180002104:     	movq	%rax, 0x8b2d(%rip)      # 0x18000ac38
18000210b:     	movq	0x20fe(%rip), %rax      # 0x180004210
180002112:     	movq	%rax, 0x84bf(%rip)      # 0x18000a5d8
180002119:     	callq	*0x2049(%rip)           # 0x180004168
18000211f:     	testl	%eax, %eax
180002121:     	jne	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
180002127:     	leaq	0x27fa(%rip), %rdx      # 0x180004928
18000212e:     	movq	%r14, %rcx
180002131:     	callq	*0x2029(%rip)           # 0x180004160
180002137:     	movq	%rax, 0x28(%rsp)
18000213c:     	movq	%rax, %rdi
18000213f:     	testq	%rax, %rax
180002142:     	je	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
180002148:     	leaq	0x2972(%rip), %rcx      # 0x180004ac1
18000214f:     	callq	*0x1fab(%rip)           # 0x180004100
180002155:     	movq	%rax, 0x20(%rsp)
18000215a:     	movq	%rax, %r12
18000215d:     	testq	%rax, %rax
180002160:     	je	0x1800024a4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x10a4>
180002166:     	movl	%ebx, %ebp
180002168:     	cmpq	%rbx, (%rsi)
18000216b:     	je	0x180002314 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xf14>
180002171:     	movslq	%ebp, %rbx
180002174:     	leaq	0x30(%rsp), %rdx
180002179:     	movq	%r14, %rcx
18000217c:     	leaq	(%rbx,%rbx,4), %rax
180002180:     	movups	(%r13,%rax,8), %xmm0
180002186:     	movups	0x10(%r13,%rax,8), %xmm1
18000218c:     	movaps	%xmm0, 0x30(%rsp)
180002191:     	movsd	0x20(%r13,%rax,8), %xmm0
180002198:     	movsd	%xmm0, 0x50(%rsp)
18000219e:     	movaps	%xmm1, 0x40(%rsp)
1800021a3:     	callq	0x180001ca0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x8a0>
1800021a8:     	movq	%rax, %r14
1800021ab:     	testq	%rax, %rax
1800021ae:     	je	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
1800021b4:     	movq	(%rsi), %rcx
1800021b7:     	callq	*0x1f43(%rip)           # 0x180004100
1800021bd:     	movq	%rax, %r13
1800021c0:     	testq	%rax, %rax
1800021c3:     	je	0x1800024c7 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x10c7>
1800021c9:     	movq	(%r15,%rbx,8), %rcx
1800021cd:     	xorl	%edx, %edx
1800021cf:     	movq	%r14, (%rcx)
1800021d2:     	leaq	0x8607(%rip), %rcx      # 0x18000a7e0
1800021d9:     	movq	0x8(%rsi), %r12
1800021dd:     	callq	*0x1f65(%rip)           # 0x180004148
1800021e3:     	movq	%rax, %rbx
1800021e6:     	testq	%rax, %rax
1800021e9:     	je	0x180002266 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe66>
1800021eb:     	movq	%r13, %rcx
1800021ee:     	callq	*0x1f84(%rip)           # 0x180004178
1800021f4:     	movq	%rax, %rdi
1800021f7:     	testq	%rax, %rax
1800021fa:     	je	0x18000221c <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe1c>
1800021fc:     	movq	%rax, %rcx
1800021ff:     	callq	0x180003a55 <numba_list_iter_next+0xe85>
180002204:     	leaq	0x1(%rax), %rcx
180002208:     	callq	*0x200a(%rip)           # 0x180004218
18000220e:     	movq	%rax, %rsi
180002211:     	testq	%rax, %rax
180002214:     	jne	0x180002224 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe24>
180002216:     	callq	*0x1f1c(%rip)           # 0x180004138
18000221c:     	xorl	%eax, %eax
18000221e:     	movq	%rax, 0x20(%rbx)
180002222:     	jmp	0x180002255 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe55>
180002224:     	movq	%rdi, %rdx
180002227:     	movq	%rsi, %rcx
18000222a:     	callq	0x180003a4f <numba_list_iter_next+0xe7f>
18000222f:     	movq	0x20(%rsp), %rcx
180002234:     	movq	%rsi, 0x20(%rbx)
180002238:     	movq	%r12, 0x28(%rbx)
18000223c:     	movl	$0x3, 0x30(%rbx)
180002243:     	callq	0x180001720 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x320>
180002248:     	movq	%rax, 0x38(%rbx)
18000224c:     	testq	%rax, %rax
18000224f:     	jne	0x1800023c0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfc0>
180002255:     	movl	(%rbx), %eax
180002257:     	testl	%eax, %eax
180002259:     	js	0x180002266 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe66>
18000225b:     	subl	$0x1, %eax
18000225e:     	movl	%eax, (%rbx)
180002260:     	je	0x18000240d <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x100d>
180002266:     	xorl	%edi, %edi
180002268:     	movl	(%r14), %eax
18000226b:     	testl	%eax, %eax
18000226d:     	js	0x180002280 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe80>
18000226f:     	subl	$0x1, %eax
180002272:     	movl	%eax, (%r14)
180002275:     	jne	0x180002280 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe80>
180002277:     	movq	%r14, %rcx
18000227a:     	callq	*0x1f30(%rip)           # 0x1800041b0
180002280:     	movl	(%r13), %eax
180002284:     	testl	%eax, %eax
180002286:     	js	0x18000229a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe9a>
180002288:     	subl	$0x1, %eax
18000228b:     	movl	%eax, (%r13)
18000228f:     	jne	0x18000229a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe9a>
180002291:     	movq	%r13, %rcx
180002294:     	callq	*0x1f16(%rip)           # 0x1800041b0
18000229a:     	testq	%rdi, %rdi
18000229d:     	je	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
1800022a3:     	movq	0xb8(%rsp), %rsi
1800022ab:     	movq	%rdi, %r8
1800022ae:     	movq	0xb0(%rsp), %r14
1800022b6:     	movq	%r14, %rcx
1800022b9:     	movq	(%rsi), %rdx
1800022bc:     	callq	*0x1f36(%rip)           # 0x1800041f8
1800022c2:     	movl	(%rdi), %ecx
1800022c4:     	testl	%eax, %eax
1800022c6:     	jne	0x18000246a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x106a>
1800022cc:     	testl	%ecx, %ecx
1800022ce:     	js	0x1800022e2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xee2>
1800022d0:     	leal	-0x1(%rcx), %eax
1800022d3:     	movl	%eax, (%rdi)
1800022d5:     	testl	%eax, %eax
1800022d7:     	jne	0x1800022e2 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xee2>
1800022d9:     	movq	%rdi, %rcx
1800022dc:     	callq	*0x1ece(%rip)           # 0x1800041b0
1800022e2:     	movq	0xc8(%rsp), %r15
1800022ea:     	addq	$0x20, %rsi
1800022ee:     	movq	0xc0(%rsp), %r13
1800022f6:     	incl	%ebp
1800022f8:     	movq	%rsi, 0xb8(%rsp)
180002300:     	cmpq	$0x0, (%rsi)
180002304:     	jne	0x180002171 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xd71>
18000230a:     	movq	0x20(%rsp), %r12
18000230f:     	movq	0x28(%rsp), %rdi
180002314:     	movslq	%ebp, %rax
180002317:     	cmpq	$0x0, (%r15,%rax,8)
18000231c:     	je	0x180002389 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xf89>
18000231e:     	nop
180002320:     	movslq	%ebp, %rbx
180002323:     	leaq	0x30(%rsp), %rdx
180002328:     	movq	%r14, %rcx
18000232b:     	leaq	(%rbx,%rbx,4), %rax
18000232f:     	movups	(%r13,%rax,8), %xmm0
180002335:     	movups	0x10(%r13,%rax,8), %xmm1
18000233b:     	movaps	%xmm0, 0x30(%rsp)
180002340:     	movsd	0x20(%r13,%rax,8), %xmm0
180002347:     	movsd	%xmm0, 0x50(%rsp)
18000234d:     	movaps	%xmm1, 0x40(%rsp)
180002352:     	callq	0x180001ca0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x8a0>
180002357:     	testq	%rax, %rax
18000235a:     	je	0x180002485 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1085>
180002360:     	movq	(%r15,%rbx,8), %rcx
180002364:     	movq	%rax, (%rcx)
180002367:     	movl	(%rax), %ecx
180002369:     	testl	%ecx, %ecx
18000236b:     	js	0x18000237d <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xf7d>
18000236d:     	subl	$0x1, %ecx
180002370:     	movl	%ecx, (%rax)
180002372:     	jne	0x18000237d <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xf7d>
180002374:     	movq	%rax, %rcx
180002377:     	callq	*0x1e33(%rip)           # 0x1800041b0
18000237d:     	incl	%ebp
18000237f:     	movslq	%ebp, %rax
180002382:     	cmpq	$0x0, (%r15,%rax,8)
180002387:     	jne	0x180002320 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xf20>
180002389:     	movl	(%r12), %eax
18000238d:     	testl	%eax, %eax
18000238f:     	js	0x1800023a3 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfa3>
180002391:     	subl	$0x1, %eax
180002394:     	movl	%eax, (%r12)
180002398:     	jne	0x1800023a3 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfa3>
18000239a:     	movq	%r12, %rcx
18000239d:     	callq	*0x1e0d(%rip)           # 0x1800041b0
1800023a3:     	movl	(%rdi), %eax
1800023a5:     	testl	%eax, %eax
1800023a7:     	js	0x1800023b9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfb9>
1800023a9:     	subl	$0x1, %eax
1800023ac:     	movl	%eax, (%rdi)
1800023ae:     	jne	0x1800023b9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfb9>
1800023b0:     	movq	%rdi, %rcx
1800023b3:     	callq	*0x1df7(%rip)           # 0x1800041b0
1800023b9:     	xorl	%eax, %eax
1800023bb:     	jmp	0x180001fa9 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba9>
1800023c0:     	movl	(%r14), %eax
1800023c3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800023c8:     	jae	0x1800023cf <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xfcf>
1800023ca:     	incl	%eax
1800023cc:     	movl	%eax, (%r14)
1800023cf:     	movq	0xb0(%rsp), %rcx
1800023d7:     	leaq	0x254a(%rip), %rdx      # 0x180004928
1800023de:     	movq	%r14, 0x18(%rbx)
1800023e2:     	movq	$0x0, 0x40(%rbx)
1800023ea:     	callq	*0x1d70(%rip)           # 0x180004160
1800023f0:     	movq	%rax, %rsi
1800023f3:     	testq	%rax, %rax
1800023f6:     	jne	0x18000241b <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x101b>
1800023f8:     	movl	(%rbx), %eax
1800023fa:     	testl	%eax, %eax
1800023fc:     	js	0x180002266 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe66>
180002402:     	subl	$0x1, %eax
180002405:     	movl	%eax, (%rbx)
180002407:     	jne	0x180002266 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe66>
18000240d:     	movq	%rbx, %rcx
180002410:     	callq	*0x1d9a(%rip)           # 0x1800041b0
180002416:     	jmp	0x180002266 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe66>
18000241b:     	xorl	%r9d, %r9d
18000241e:     	leaq	0x20(%rbx), %rcx
180002422:     	movq	%rsi, %r8
180002425:     	movq	%rbx, %rdx
180002428:     	callq	*0x1d12(%rip)           # 0x180004140
18000242e:     	movq	%rax, %rdi
180002431:     	movl	(%rbx), %eax
180002433:     	testl	%eax, %eax
180002435:     	js	0x180002447 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1047>
180002437:     	subl	$0x1, %eax
18000243a:     	movl	%eax, (%rbx)
18000243c:     	jne	0x180002447 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1047>
18000243e:     	movq	%rbx, %rcx
180002441:     	callq	*0x1d69(%rip)           # 0x1800041b0
180002447:     	movl	(%rsi), %eax
180002449:     	testl	%eax, %eax
18000244b:     	js	0x180002268 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe68>
180002451:     	subl	$0x1, %eax
180002454:     	movl	%eax, (%rsi)
180002456:     	jne	0x180002268 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe68>
18000245c:     	movq	%rsi, %rcx
18000245f:     	callq	*0x1d4b(%rip)           # 0x1800041b0
180002465:     	jmp	0x180002268 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xe68>
18000246a:     	testl	%ecx, %ecx
18000246c:     	js	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
18000246e:     	leal	-0x1(%rcx), %eax
180002471:     	movl	%eax, (%rdi)
180002473:     	testl	%eax, %eax
180002475:     	jne	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
180002477:     	movq	%rdi, %rcx
18000247a:     	callq	*0x1d30(%rip)           # 0x1800041b0
180002480:     	movq	0x20(%rsp), %r12
180002485:     	movl	(%r12), %eax
180002489:     	testl	%eax, %eax
18000248b:     	js	0x18000249f <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x109f>
18000248d:     	subl	$0x1, %eax
180002490:     	movl	%eax, (%r12)
180002494:     	jne	0x18000249f <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x109f>
180002496:     	movq	%r12, %rcx
180002499:     	callq	*0x1d11(%rip)           # 0x1800041b0
18000249f:     	movq	0x28(%rsp), %rdi
1800024a4:     	movl	(%rdi), %eax
1800024a6:     	testl	%eax, %eax
1800024a8:     	js	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
1800024ae:     	subl	$0x1, %eax
1800024b1:     	movl	%eax, (%rdi)
1800024b3:     	jne	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
1800024b9:     	movq	%rdi, %rcx
1800024bc:     	callq	*0x1cee(%rip)           # 0x1800041b0
1800024c2:     	jmp	0x180001fa4 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0xba4>
1800024c7:     	movl	(%r14), %eax
1800024ca:     	testl	%eax, %eax
1800024cc:     	js	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
1800024ce:     	subl	$0x1, %eax
1800024d1:     	movl	%eax, (%r14)
1800024d4:     	jne	0x180002480 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x1080>
1800024d6:     	movq	%r14, %rcx
1800024d9:     	jmp	0x18000247a <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x107a>
1800024db:     	int3
1800024dc:     	int3
1800024dd:     	int3
1800024de:     	int3
1800024df:     	int3
1800024e0:     	leaq	0x8789(%rip), %rax      # 0x18000ac70
1800024e7:     	retq
1800024e8:     	int3
1800024e9:     	int3
1800024ea:     	int3
1800024eb:     	int3
1800024ec:     	int3
1800024ed:     	int3
1800024ee:     	int3
1800024ef:     	int3

00000001800024f0 <numba_list_set_method_table>:
1800024f0:     	movups	(%rdx), %xmm0
1800024f3:     	movups	%xmm0, 0x20(%rcx)
1800024f7:     	retq
1800024f8:     	int3
1800024f9:     	int3
1800024fa:     	int3
1800024fb:     	int3
1800024fc:     	int3
1800024fd:     	int3
1800024fe:     	int3
1800024ff:     	int3

0000000180002500 <numba_list_new>:
180002500:     	pushq	%rbx
180002502:     	pushq	%rbp
180002503:     	pushq	%rsi
180002504:     	pushq	%rdi
180002505:     	subq	$0x28, %rsp
180002509:     	movq	%rcx, %rsi
18000250c:     	movq	%r8, %rdi
18000250f:     	movl	$0x38, %ecx
180002514:     	movq	%rdx, %rbp
180002517:     	callq	*0x1b43(%rip)           # 0x180004060
18000251d:     	movq	%rax, %rbx
180002520:     	testq	%rax, %rax
180002523:     	je	0x18000258d <numba_list_new+0x8d>
180002525:     	movq	$0x0, (%rax)
18000252c:     	xorps	%xmm0, %xmm0
18000252f:     	movq	%rbp, 0x8(%rax)
180002533:     	movq	%rdi, 0x10(%rax)
180002537:     	movl	$0x1, 0x18(%rax)
18000253e:     	movups	%xmm0, 0x20(%rax)
180002542:     	testq	%rdi, %rdi
180002545:     	je	0x18000259b <numba_list_new+0x9b>
180002547:     	imulq	%rbp, %rdi
18000254b:     	movl	$0x8, %ecx
180002550:     	movq	%rdi, %rax
180002553:     	cqto
180002555:     	andl	$0x7, %edx
180002558:     	addq	%rdx, %rax
18000255b:     	andl	$0x7, %eax
18000255e:     	subq	%rdx, %rax
180002561:     	subq	%rax, %rcx
180002564:     	movq	%rcx, %rax
180002567:     	cqto
180002569:     	andl	$0x7, %edx
18000256c:     	leaq	(%rdx,%rax), %rcx
180002570:     	andl	$0x7, %ecx
180002573:     	subq	%rdx, %rcx
180002576:     	addq	%rdi, %rcx
180002579:     	callq	*0x1ae1(%rip)           # 0x180004060
18000257f:     	testq	%rax, %rax
180002582:     	jne	0x18000259d <numba_list_new+0x9d>
180002584:     	movq	%rbx, %rcx
180002587:     	callq	*0x1adb(%rip)           # 0x180004068
18000258d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002592:     	addq	$0x28, %rsp
180002596:     	popq	%rdi
180002597:     	popq	%rsi
180002598:     	popq	%rbp
180002599:     	popq	%rbx
18000259a:     	retq
18000259b:     	xorl	%eax, %eax
18000259d:     	movq	%rax, 0x30(%rbx)
1800025a1:     	xorl	%eax, %eax
1800025a3:     	movq	%rbx, (%rsi)
1800025a6:     	addq	$0x28, %rsp
1800025aa:     	popq	%rdi
1800025ab:     	popq	%rsi
1800025ac:     	popq	%rbp
1800025ad:     	popq	%rbx
1800025ae:     	retq
1800025af:     	int3

00000001800025b0 <numba_list_free>:
1800025b0:     	pushq	%rbx
1800025b2:     	subq	$0x20, %rsp
1800025b6:     	cmpq	$0x0, 0x28(%rcx)
1800025bb:     	movq	%rcx, %rbx
1800025be:     	je	0x1800025f4 <numba_list_free+0x44>
1800025c0:     	movq	%rdi, 0x30(%rsp)
1800025c5:     	xorl	%edi, %edi
1800025c7:     	cmpq	%rdi, (%rcx)
1800025ca:     	jle	0x1800025ef <numba_list_free+0x3f>
1800025cc:     	nopl	(%rax)
1800025d0:     	movq	0x28(%rbx), %rax
1800025d4:     	testq	%rax, %rax
1800025d7:     	je	0x1800025e7 <numba_list_free+0x37>
1800025d9:     	movq	%rdi, %rcx
1800025dc:     	imulq	0x8(%rbx), %rcx
1800025e1:     	addq	0x30(%rbx), %rcx
1800025e5:     	callq	*%rax
1800025e7:     	incq	%rdi
1800025ea:     	cmpq	(%rbx), %rdi
1800025ed:     	jl	0x1800025d0 <numba_list_free+0x20>
1800025ef:     	movq	0x30(%rsp), %rdi
1800025f4:     	movq	0x30(%rbx), %rcx
1800025f8:     	testq	%rcx, %rcx
1800025fb:     	je	0x180002603 <numba_list_free+0x53>
1800025fd:     	callq	*0x1a65(%rip)           # 0x180004068
180002603:     	movq	%rbx, %rcx
180002606:     	addq	$0x20, %rsp
18000260a:     	popq	%rbx
18000260b:     	jmpq	*0x1a56(%rip)           # 0x180004068
180002612:     	int3
180002613:     	int3
180002614:     	int3
180002615:     	int3
180002616:     	int3
180002617:     	int3
180002618:     	int3
180002619:     	int3
18000261a:     	int3
18000261b:     	int3
18000261c:     	int3
18000261d:     	int3
18000261e:     	int3
18000261f:     	int3

0000000180002620 <numba_list_base_ptr>:
180002620:     	movq	0x30(%rcx), %rax
180002624:     	retq
180002625:     	int3
180002626:     	int3
180002627:     	int3
180002628:     	int3
180002629:     	int3
18000262a:     	int3
18000262b:     	int3
18000262c:     	int3
18000262d:     	int3
18000262e:     	int3
18000262f:     	int3

0000000180002630 <numba_list_size_address>:
180002630:     	movq	%rcx, %rax
180002633:     	retq
180002634:     	int3
180002635:     	int3
180002636:     	int3
180002637:     	int3
180002638:     	int3
180002639:     	int3
18000263a:     	int3
18000263b:     	int3
18000263c:     	int3
18000263d:     	int3
18000263e:     	int3
18000263f:     	int3

0000000180002640 <numba_list_length>:
180002640:     	movq	(%rcx), %rax
180002643:     	retq
180002644:     	int3
180002645:     	int3
180002646:     	int3
180002647:     	int3
180002648:     	int3
180002649:     	int3
18000264a:     	int3
18000264b:     	int3
18000264c:     	int3
18000264d:     	int3
18000264e:     	int3
18000264f:     	int3

0000000180002650 <numba_list_allocated>:
180002650:     	movq	0x10(%rcx), %rax
180002654:     	retq
180002655:     	int3
180002656:     	int3
180002657:     	int3
180002658:     	int3
180002659:     	int3
18000265a:     	int3
18000265b:     	int3
18000265c:     	int3
18000265d:     	int3
18000265e:     	int3
18000265f:     	int3

0000000180002660 <numba_list_is_mutable>:
180002660:     	movl	0x18(%rcx), %eax
180002663:     	retq
180002664:     	int3
180002665:     	int3
180002666:     	int3
180002667:     	int3
180002668:     	int3
180002669:     	int3
18000266a:     	int3
18000266b:     	int3
18000266c:     	int3
18000266d:     	int3
18000266e:     	int3
18000266f:     	int3

0000000180002670 <numba_list_set_is_mutable>:
180002670:     	movl	%edx, 0x18(%rcx)
180002673:     	retq
180002674:     	int3
180002675:     	int3
180002676:     	int3
180002677:     	int3
180002678:     	int3
180002679:     	int3
18000267a:     	int3
18000267b:     	int3
18000267c:     	int3
18000267d:     	int3
18000267e:     	int3
18000267f:     	int3

0000000180002680 <numba_list_setitem>:
180002680:     	movq	%rbx, 0x10(%rsp)
180002685:     	pushq	%rsi
180002686:     	subq	$0x20, %rsp
18000268a:     	cmpl	$0x0, 0x18(%rcx)
18000268e:     	movq	%r8, %rsi
180002691:     	movq	%rcx, %rbx
180002694:     	jne	0x1800026a6 <numba_list_setitem+0x26>
180002696:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000269b:     	movq	0x38(%rsp), %rbx
1800026a0:     	addq	$0x20, %rsp
1800026a4:     	popq	%rsi
1800026a5:     	retq
1800026a6:     	cmpq	(%rcx), %rdx
1800026a9:     	jb	0x1800026bb <numba_list_setitem+0x3b>
1800026ab:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800026b0:     	movq	0x38(%rsp), %rbx
1800026b5:     	addq	$0x20, %rsp
1800026b9:     	popq	%rsi
1800026ba:     	retq
1800026bb:     	imulq	0x8(%rcx), %rdx
1800026c0:     	movq	0x28(%rcx), %rax
1800026c4:     	movq	%rdi, 0x30(%rsp)
1800026c9:     	movq	0x30(%rcx), %rdi
1800026cd:     	addq	%rdx, %rdi
1800026d0:     	testq	%rax, %rax
1800026d3:     	je	0x1800026da <numba_list_setitem+0x5a>
1800026d5:     	movq	%rdi, %rcx
1800026d8:     	callq	*%rax
1800026da:     	movq	0x8(%rbx), %r8
1800026de:     	movq	%rsi, %rdx
1800026e1:     	movq	%rdi, %rcx
1800026e4:     	callq	0x180003a43 <numba_list_iter_next+0xe73>
1800026e9:     	movq	0x20(%rbx), %rax
1800026ed:     	testq	%rax, %rax
1800026f0:     	je	0x1800026f7 <numba_list_setitem+0x77>
1800026f2:     	movq	%rdi, %rcx
1800026f5:     	callq	*%rax
1800026f7:     	movq	0x30(%rsp), %rdi
1800026fc:     	xorl	%eax, %eax
1800026fe:     	movq	0x38(%rsp), %rbx
180002703:     	addq	$0x20, %rsp
180002707:     	popq	%rsi
180002708:     	retq
180002709:     	int3
18000270a:     	int3
18000270b:     	int3
18000270c:     	int3
18000270d:     	int3
18000270e:     	int3
18000270f:     	int3

0000000180002710 <numba_list_getitem>:
180002710:     	subq	$0x28, %rsp
180002714:     	movq	%r8, %r9
180002717:     	movq	%rdx, %rax
18000271a:     	cmpq	(%rcx), %rdx
18000271d:     	jb	0x180002729 <numba_list_getitem+0x19>
18000271f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002724:     	addq	$0x28, %rsp
180002728:     	retq
180002729:     	movq	0x8(%rcx), %r8
18000272d:     	movq	%r8, %rdx
180002730:     	imulq	%rax, %rdx
180002734:     	addq	0x30(%rcx), %rdx
180002738:     	movq	%r9, %rcx
18000273b:     	callq	0x180003a43 <numba_list_iter_next+0xe73>
180002740:     	xorl	%eax, %eax
180002742:     	addq	$0x28, %rsp
180002746:     	retq
180002747:     	int3
180002748:     	int3
180002749:     	int3
18000274a:     	int3
18000274b:     	int3
18000274c:     	int3
18000274d:     	int3
18000274e:     	int3
18000274f:     	int3

0000000180002750 <numba_list_append>:
180002750:     	movq	%rbx, 0x10(%rsp)
180002755:     	pushq	%rsi
180002756:     	subq	$0x20, %rsp
18000275a:     	cmpl	$0x0, 0x18(%rcx)
18000275e:     	movq	%rdx, %rsi
180002761:     	movq	%rcx, %rbx
180002764:     	jne	0x180002776 <numba_list_append+0x26>
180002766:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000276b:     	movq	0x38(%rsp), %rbx
180002770:     	addq	$0x20, %rsp
180002774:     	popq	%rsi
180002775:     	retq
180002776:     	movq	(%rcx), %rdx
180002779:     	incq	%rdx
18000277c:     	callq	0x1800027d0 <numba_list_resize>
180002781:     	testl	%eax, %eax
180002783:     	js	0x1800027bc <numba_list_append+0x6c>
180002785:     	movq	0x8(%rbx), %r8
180002789:     	movq	%rsi, %rdx
18000278c:     	movq	%rdi, 0x30(%rsp)
180002791:     	movq	(%rbx), %rdi
180002794:     	decq	%rdi
180002797:     	imulq	%r8, %rdi
18000279b:     	addq	0x30(%rbx), %rdi
18000279f:     	movq	%rdi, %rcx
1800027a2:     	callq	0x180003a43 <numba_list_iter_next+0xe73>
1800027a7:     	movq	0x20(%rbx), %rax
1800027ab:     	testq	%rax, %rax
1800027ae:     	je	0x1800027b5 <numba_list_append+0x65>
1800027b0:     	movq	%rdi, %rcx
1800027b3:     	callq	*%rax
1800027b5:     	movq	0x30(%rsp), %rdi
1800027ba:     	xorl	%eax, %eax
1800027bc:     	movq	0x38(%rsp), %rbx
1800027c1:     	addq	$0x20, %rsp
1800027c5:     	popq	%rsi
1800027c6:     	retq
1800027c7:     	int3
1800027c8:     	int3
1800027c9:     	int3
1800027ca:     	int3
1800027cb:     	int3
1800027cc:     	int3
1800027cd:     	int3
1800027ce:     	int3
1800027cf:     	int3

00000001800027d0 <numba_list_resize>:
1800027d0:     	movq	%rsi, 0x18(%rsp)
1800027d5:     	pushq	%rdi
1800027d6:     	subq	$0x20, %rsp
1800027da:     	cmpl	$0x0, 0x18(%rcx)
1800027de:     	movq	%rdx, %rsi
1800027e1:     	movq	%rcx, %rdi
1800027e4:     	jne	0x1800027f6 <numba_list_resize+0x26>
1800027e6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800027eb:     	movq	0x40(%rsp), %rsi
1800027f0:     	addq	$0x20, %rsp
1800027f4:     	popq	%rdi
1800027f5:     	retq
1800027f6:     	movq	0x10(%rcx), %rax
1800027fa:     	cmpq	%rsi, %rax
1800027fd:     	jl	0x180002817 <numba_list_resize+0x47>
1800027ff:     	sarq	%rax
180002802:     	cmpq	%rax, %rsi
180002805:     	jl	0x180002817 <numba_list_resize+0x47>
180002807:     	movq	%rsi, (%rcx)
18000280a:     	xorl	%eax, %eax
18000280c:     	movq	0x40(%rsp), %rsi
180002811:     	addq	$0x20, %rsp
180002815:     	popq	%rdi
180002816:     	retq
180002817:     	cmpq	$0x9, %rsi
18000281b:     	movq	%rbp, 0x38(%rsp)
180002820:     	movl	$0x3, %ecx
180002825:     	movl	$0x6, %eax
18000282a:     	cmovll	%ecx, %eax
18000282d:     	movq	%rsi, %r8
180002830:     	movq	0x8(%rdi), %rcx
180002834:     	addq	%rsi, %rax
180002837:     	sarq	$0x3, %r8
18000283b:     	xorl	%edx, %edx
18000283d:     	addq	%rax, %r8
180002840:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000284a:     	divq	%rcx
18000284d:     	cmpq	%rax, %r8
180002850:     	ja	0x1800028cb <numba_list_resize+0xfb>
180002852:     	xorl	%ebp, %ebp
180002854:     	movq	%rbx, 0x30(%rsp)
180002859:     	testq	%rsi, %rsi
18000285c:     	cmovneq	%r8, %rbp
180002860:     	movq	%rbp, %rbx
180002863:     	imulq	%rcx, %rbx
180002867:     	movl	$0x8, %ecx
18000286c:     	movq	%rbx, %rax
18000286f:     	cqto
180002871:     	andl	$0x7, %edx
180002874:     	addq	%rdx, %rax
180002877:     	andl	$0x7, %eax
18000287a:     	subq	%rdx, %rax
18000287d:     	subq	%rax, %rcx
180002880:     	movq	%rcx, %rax
180002883:     	movq	0x30(%rdi), %rcx
180002887:     	cqto
180002889:     	andl	$0x7, %edx
18000288c:     	addq	%rdx, %rax
18000288f:     	andl	$0x7, %eax
180002892:     	subq	%rdx, %rax
180002895:     	leaq	(%rbx,%rax), %rdx
180002899:     	callq	*0x17d1(%rip)           # 0x180004070
18000289f:     	testq	%rbx, %rbx
1800028a2:     	movq	0x30(%rsp), %rbx
1800028a7:     	je	0x1800028ae <numba_list_resize+0xde>
1800028a9:     	testq	%rax, %rax
1800028ac:     	je	0x1800028cb <numba_list_resize+0xfb>
1800028ae:     	movq	%rax, 0x30(%rdi)
1800028b2:     	xorl	%eax, %eax
1800028b4:     	movq	%rbp, 0x10(%rdi)
1800028b8:     	movq	0x38(%rsp), %rbp
1800028bd:     	movq	%rsi, (%rdi)
1800028c0:     	movq	0x40(%rsp), %rsi
1800028c5:     	addq	$0x20, %rsp
1800028c9:     	popq	%rdi
1800028ca:     	retq
1800028cb:     	movq	0x38(%rsp), %rbp
1800028d0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800028d5:     	movq	0x40(%rsp), %rsi
1800028da:     	addq	$0x20, %rsp
1800028de:     	popq	%rdi
1800028df:     	retq

00000001800028e0 <numba_list_delitem>:
1800028e0:     	movq	%rbx, 0x10(%rsp)
1800028e5:     	pushq	%rdi
1800028e6:     	subq	$0x20, %rsp
1800028ea:     	cmpl	$0x0, 0x18(%rcx)
1800028ee:     	movq	%rdx, %rdi
1800028f1:     	movq	%rcx, %rbx
1800028f4:     	jne	0x180002906 <numba_list_delitem+0x26>
1800028f6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800028fb:     	movq	0x38(%rsp), %rbx
180002900:     	addq	$0x20, %rsp
180002904:     	popq	%rdi
180002905:     	retq
180002906:     	cmpq	(%rcx), %rdi
180002909:     	jb	0x18000291b <numba_list_delitem+0x3b>
18000290b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002910:     	movq	0x38(%rsp), %rbx
180002915:     	addq	$0x20, %rsp
180002919:     	popq	%rdi
18000291a:     	retq
18000291b:     	movq	0x28(%rcx), %rax
18000291f:     	movq	%rsi, 0x30(%rsp)
180002924:     	movq	%rdi, %rsi
180002927:     	imulq	0x8(%rcx), %rsi
18000292c:     	addq	0x30(%rcx), %rsi
180002930:     	testq	%rax, %rax
180002933:     	je	0x18000293a <numba_list_delitem+0x5a>
180002935:     	movq	%rsi, %rcx
180002938:     	callq	*%rax
18000293a:     	movq	(%rbx), %r8
18000293d:     	leaq	-0x1(%r8), %rax
180002941:     	cmpq	%rax, %rdi
180002944:     	je	0x180002966 <numba_list_delitem+0x86>
180002946:     	subq	%rdi, %r8
180002949:     	leaq	0x1(%rdi), %rdx
18000294d:     	imulq	0x8(%rbx), %rdx
180002952:     	decq	%r8
180002955:     	movq	%rsi, %rcx
180002958:     	imulq	0x8(%rbx), %r8
18000295d:     	addq	0x30(%rbx), %rdx
180002961:     	callq	0x180003a49 <numba_list_iter_next+0xe79>
180002966:     	movq	(%rbx), %rdx
180002969:     	movq	%rbx, %rcx
18000296c:     	decq	%rdx
18000296f:     	callq	0x1800027d0 <numba_list_resize>
180002974:     	movq	0x30(%rsp), %rsi
180002979:     	xorl	%ecx, %ecx
18000297b:     	movq	0x38(%rsp), %rbx
180002980:     	testl	%eax, %eax
180002982:     	cmovsl	%eax, %ecx
180002985:     	movl	%ecx, %eax
180002987:     	addq	$0x20, %rsp
18000298b:     	popq	%rdi
18000298c:     	retq
18000298d:     	int3
18000298e:     	int3
18000298f:     	int3

0000000180002990 <numba_list_delete_slice>:
180002990:     	pushq	%rbx
180002992:     	pushq	%rbp
180002993:     	pushq	%rdi
180002994:     	pushq	%r15
180002996:     	subq	$0x38, %rsp
18000299a:     	cmpl	$0x0, 0x18(%rcx)
18000299e:     	movq	%r9, %rdi
1800029a1:     	movq	%r8, %rbp
1800029a4:     	movq	%rdx, %r15
1800029a7:     	movq	%rcx, %rbx
1800029aa:     	jne	0x1800029bb <numba_list_delete_slice+0x2b>
1800029ac:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800029b1:     	addq	$0x38, %rsp
1800029b5:     	popq	%r15
1800029b7:     	popq	%rdi
1800029b8:     	popq	%rbp
1800029b9:     	popq	%rbx
1800029ba:     	retq
1800029bb:     	movq	%r13, 0x78(%rsp)
1800029c0:     	testq	%rdi, %rdi
1800029c3:     	jle	0x1800029e2 <numba_list_delete_slice+0x52>
1800029c5:     	cmpq	%r8, %r15
1800029c8:     	jge	0x180002b81 <numba_list_delete_slice+0x1f1>
1800029ce:     	movq	%r8, %rax
1800029d1:     	subq	%r15, %rax
1800029d4:     	decq	%rax
1800029d7:     	cqto
1800029d9:     	idivq	%rdi
1800029dc:     	leal	0x1(%rax), %r13d
1800029e0:     	jmp	0x180002a02 <numba_list_delete_slice+0x72>
1800029e2:     	cmpq	%r15, %r8
1800029e5:     	jge	0x180002b81 <numba_list_delete_slice+0x1f1>
1800029eb:     	movq	%r15, %rax
1800029ee:     	movl	$0x1, %r13d
1800029f4:     	subq	%r8, %rax
1800029f7:     	decq	%rax
1800029fa:     	cqto
1800029fc:     	idivq	%rdi
1800029ff:     	subl	%eax, %r13d
180002a02:     	testl	%r13d, %r13d
180002a05:     	jle	0x180002b81 <numba_list_delete_slice+0x1f1>
180002a0b:     	movq	%rsi, 0x68(%rsp)
180002a10:     	movl	(%rcx), %esi
180002a12:     	subl	%r13d, %esi
180002a15:     	movl	%esi, 0x20(%rsp)
180002a19:     	testq	%rdi, %rdi
180002a1c:     	jns	0x180002a37 <numba_list_delete_slice+0xa7>
180002a1e:     	leaq	0x1(%r15), %rbp
180002a22:     	leal	-0x1(%r13), %eax
180002a26:     	movslq	%eax, %rcx
180002a29:     	leaq	-0x1(%rbp), %r15
180002a2d:     	imulq	%rdi, %rcx
180002a31:     	addq	%rcx, %r15
180002a34:     	negq	%rdi
180002a37:     	cmpq	$0x1, %rdi
180002a3b:     	jne	0x180002a87 <numba_list_delete_slice+0xf7>
180002a3d:     	cmpq	$0x0, 0x28(%rbx)
180002a42:     	je	0x180002a69 <numba_list_delete_slice+0xd9>
180002a44:     	movslq	%r15d, %rdi
180002a47:     	cmpq	%rbp, %rdi
180002a4a:     	jge	0x180002a69 <numba_list_delete_slice+0xd9>
180002a4c:     	nopl	(%rax)
180002a50:     	movslq	%edi, %rcx
180002a53:     	imulq	0x8(%rbx), %rcx
180002a58:     	addq	0x30(%rbx), %rcx
180002a5c:     	callq	*0x28(%rbx)
180002a5f:     	incl	%edi
180002a61:     	movslq	%edi, %rax
180002a64:     	cmpq	%rbp, %rax
180002a67:     	jl	0x180002a50 <numba_list_delete_slice+0xc0>
180002a69:     	movq	0x8(%rbx), %rcx
180002a6d:     	movq	(%rbx), %r8
180002a70:     	movq	%rcx, %rdx
180002a73:     	subq	%rbp, %r8
180002a76:     	imulq	%rcx, %r8
180002a7a:     	imulq	%rbp, %rdx
180002a7e:     	imulq	%r15, %rcx
180002a82:     	jmp	0x180002b4c <numba_list_delete_slice+0x1bc>
180002a87:     	movq	%r14, 0x30(%rsp)
180002a8c:     	movq	%r15, %r14
180002a8f:     	movl	$0x0, 0x60(%rsp)
180002a97:     	cmpq	%rbp, %r15
180002a9a:     	jge	0x180002b19 <numba_list_delete_slice+0x189>
180002a9c:     	movq	%r12, 0x70(%rsp)
180002aa1:     	movq	(%rbx), %rax
180002aa4:     	leaq	(%r14,%rdi), %r12
180002aa8:     	cmpq	%rax, %r12
180002aab:     	jl	0x180002ab8 <numba_list_delete_slice+0x128>
180002aad:     	movq	%r14, %rsi
180002ab0:     	notq	%rsi
180002ab3:     	addq	%rax, %rsi
180002ab6:     	jmp	0x180002abc <numba_list_delete_slice+0x12c>
180002ab8:     	leaq	-0x1(%rdi), %rsi
180002abc:     	movq	0x28(%rbx), %rax
180002ac0:     	testq	%rax, %rax
180002ac3:     	je	0x180002ad3 <numba_list_delete_slice+0x143>
180002ac5:     	movq	%r14, %rcx
180002ac8:     	imulq	0x8(%rbx), %rcx
180002acd:     	addq	0x30(%rbx), %rcx
180002ad1:     	callq	*%rax
180002ad3:     	movq	0x8(%rbx), %r9
180002ad7:     	leaq	0x1(%r14), %rdx
180002adb:     	movq	0x30(%rbx), %r10
180002adf:     	movq	%r9, %r8
180002ae2:     	imulq	%rsi, %r8
180002ae6:     	imulq	%r9, %rdx
180002aea:     	movslq	0x60(%rsp), %rsi
180002aef:     	subq	%rsi, %r14
180002af2:     	imulq	%r9, %r14
180002af6:     	addq	%r10, %rdx
180002af9:     	leaq	(%r10,%r14), %rcx
180002afd:     	callq	0x180003a49 <numba_list_iter_next+0xe79>
180002b02:     	incl	%esi
180002b04:     	movq	%r12, %r14
180002b07:     	movl	%esi, 0x60(%rsp)
180002b0b:     	cmpq	%rbp, %r12
180002b0e:     	jl	0x180002aa1 <numba_list_delete_slice+0x111>
180002b10:     	movq	0x70(%rsp), %r12
180002b15:     	movl	0x20(%rsp), %esi
180002b19:     	movq	(%rbx), %r8
180002b1c:     	movq	0x30(%rsp), %r14
180002b21:     	movslq	%r13d, %r10
180002b24:     	movq	%r10, %rcx
180002b27:     	imulq	%rdi, %rcx
180002b2b:     	addq	%r15, %rcx
180002b2e:     	cmpq	%r8, %rcx
180002b31:     	jge	0x180002b59 <numba_list_delete_slice+0x1c9>
180002b33:     	movq	0x8(%rbx), %rax
180002b37:     	subq	%rcx, %r8
180002b3a:     	movq	%rax, %rdx
180002b3d:     	imulq	%rcx, %rdx
180002b41:     	imulq	%rax, %r8
180002b45:     	subq	%r10, %rcx
180002b48:     	imulq	%rax, %rcx
180002b4c:     	addq	0x30(%rbx), %rdx
180002b50:     	addq	0x30(%rbx), %rcx
180002b54:     	callq	0x180003a49 <numba_list_iter_next+0xe79>
180002b59:     	movslq	%esi, %rdx
180002b5c:     	movq	%rbx, %rcx
180002b5f:     	callq	0x1800027d0 <numba_list_resize>
180002b64:     	movq	0x68(%rsp), %rsi
180002b69:     	xorl	%ecx, %ecx
180002b6b:     	movq	0x78(%rsp), %r13
180002b70:     	testl	%eax, %eax
180002b72:     	cmovsl	%eax, %ecx
180002b75:     	movl	%ecx, %eax
180002b77:     	addq	$0x38, %rsp
180002b7b:     	popq	%r15
180002b7d:     	popq	%rdi
180002b7e:     	popq	%rbp
180002b7f:     	popq	%rbx
180002b80:     	retq
180002b81:     	movq	0x78(%rsp), %r13
180002b86:     	xorl	%eax, %eax
180002b88:     	addq	$0x38, %rsp
180002b8c:     	popq	%r15
180002b8e:     	popq	%rdi
180002b8f:     	popq	%rbp
180002b90:     	popq	%rbx
180002b91:     	retq
180002b92:     	int3
180002b93:     	int3
180002b94:     	int3
180002b95:     	int3
180002b96:     	int3
180002b97:     	int3
180002b98:     	int3
180002b99:     	int3
180002b9a:     	int3
180002b9b:     	int3
180002b9c:     	int3
180002b9d:     	int3
180002b9e:     	int3
180002b9f:     	int3

0000000180002ba0 <numba_list_iter_sizeof>:
180002ba0:     	movl	$0x18, %eax
180002ba5:     	retq
180002ba6:     	int3
180002ba7:     	int3
180002ba8:     	int3
180002ba9:     	int3
180002baa:     	int3
180002bab:     	int3
180002bac:     	int3
180002bad:     	int3
180002bae:     	int3
180002baf:     	int3

0000000180002bb0 <numba_list_iter>:
180002bb0:     	movq	%rdx, (%rcx)
180002bb3:     	movq	(%rdx), %rax
180002bb6:     	movq	%rax, 0x8(%rcx)
180002bba:     	movq	$0x0, 0x10(%rcx)
180002bc2:     	retq
180002bc3:     	int3
180002bc4:     	int3
180002bc5:     	int3
180002bc6:     	int3
180002bc7:     	int3
180002bc8:     	int3
180002bc9:     	int3
180002bca:     	int3
180002bcb:     	int3
180002bcc:     	int3
180002bcd:     	int3
180002bce:     	int3
180002bcf:     	int3

0000000180002bd0 <numba_list_iter_next>:
180002bd0:     	movq	(%rcx), %r8
180002bd3:     	movq	(%r8), %r9
180002bd6:     	cmpq	0x8(%rcx), %r9
180002bda:     	je	0x180002be2 <numba_list_iter_next+0x12>
180002bdc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002be1:     	retq
180002be2:     	movq	0x10(%rcx), %rax
180002be6:     	cmpq	%r9, %rax
180002be9:     	jge	0x180002bfe <numba_list_iter_next+0x2e>
180002beb:     	imulq	0x8(%r8), %rax
180002bf0:     	addq	0x30(%r8), %rax
180002bf4:     	movq	%rax, (%rdx)
180002bf7:     	incq	0x10(%rcx)
180002bfb:     	xorl	%eax, %eax
180002bfd:     	retq
180002bfe:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002c03:     	retq
180002c04:     	int3
180002c05:     	int3
180002c06:     	int3
180002c07:     	int3
180002c08:     	int3
180002c09:     	int3
180002c0a:     	int3
180002c0b:     	int3
180002c0c:     	int3
180002c0d:     	int3
180002c0e:     	int3
180002c0f:     	int3
180002c10:     	pushq	%rbx
180002c12:     	subq	$0x20, %rsp
180002c16:     	movq	%rcx, %rbx
180002c19:     	addq	$0x30, %rcx
180002c1d:     	callq	*0x8005(%rip)           # 0x18000ac28
180002c23:     	cmpb	$0x0, 0x7fd6(%rip)      # 0x18000ac00
180002c2a:     	je	0x180002c34 <numba_list_iter_next+0x64>
180002c2c:     	lock
180002c2d:     	incq	0x7fd4(%rip)            # 0x18000ac08
180002c34:     	testq	%rax, %rax
180002c37:     	je	0x180002c78 <numba_list_iter_next+0xa8>
180002c39:     	leaq	0x30(%rax), %rdx
180002c3d:     	testq	%rdx, %rdx
180002c40:     	je	0x180002c78 <numba_list_iter_next+0xa8>
180002c42:     	xorl	%r8d, %r8d
180002c45:     	movl	$0x1, %ecx
180002c4a:     	xchgq	%rcx, (%rax)
180002c4d:     	movq	%r8, 0x8(%rax)
180002c51:     	movq	%r8, 0x10(%rax)
180002c55:     	movq	%rdx, 0x18(%rax)
180002c59:     	movq	%rbx, 0x20(%rax)
180002c5d:     	movq	%r8, 0x28(%rax)
180002c61:     	cmpb	%r8b, 0x7f98(%rip)      # 0x18000ac00
180002c68:     	je	0x180002c7a <numba_list_iter_next+0xaa>
180002c6a:     	lock
180002c6b:     	incq	0x7fa6(%rip)            # 0x18000ac18
180002c72:     	addq	$0x20, %rsp
180002c76:     	popq	%rbx
180002c77:     	retq
180002c78:     	xorl	%eax, %eax
180002c7a:     	addq	$0x20, %rsp
180002c7e:     	popq	%rbx
180002c7f:     	retq
180002c80:     	movq	%rbx, 0x8(%rsp)
180002c85:     	pushq	%rdi
180002c86:     	subq	$0x20, %rsp
180002c8a:     	movq	%rcx, %rdi
180002c8d:     	movq	%rdx, %rbx
180002c90:     	addq	$0x30, %rcx
180002c94:     	testq	%rdx, %rdx
180002c97:     	je	0x180002ca1 <numba_list_iter_next+0xd1>
180002c99:     	movq	0x18(%rdx), %rdx
180002c9d:     	callq	*(%rbx)
180002c9f:     	jmp	0x180002ca7 <numba_list_iter_next+0xd7>
180002ca1:     	callq	*0x7f81(%rip)           # 0x18000ac28
180002ca7:     	cmpb	$0x0, 0x7f52(%rip)      # 0x18000ac00
180002cae:     	movq	%rax, %r8
180002cb1:     	je	0x180002cbb <numba_list_iter_next+0xeb>
180002cb3:     	lock
180002cb4:     	incq	0x7f4d(%rip)            # 0x18000ac08
180002cbb:     	xorl	%edx, %edx
180002cbd:     	leaq	0x30(%r8), %rax
180002cc1:     	testq	%r8, %r8
180002cc4:     	movl	%edx, %ecx
180002cc6:     	cmovneq	%rax, %rcx
180002cca:     	testq	%rcx, %rcx
180002ccd:     	jne	0x180002cdc <numba_list_iter_next+0x10c>
180002ccf:     	xorl	%eax, %eax
180002cd1:     	movq	0x30(%rsp), %rbx
180002cd6:     	addq	$0x20, %rsp
180002cda:     	popq	%rdi
180002cdb:     	retq
180002cdc:     	movl	$0x1, %eax
180002ce1:     	xchgq	%rax, (%r8)
180002ce4:     	movq	%rdx, 0x8(%r8)
180002ce8:     	movq	%rdx, 0x10(%r8)
180002cec:     	movq	%rcx, 0x18(%r8)
180002cf0:     	movq	%rdi, 0x20(%r8)
180002cf4:     	movq	%rbx, 0x28(%r8)
180002cf8:     	cmpb	%dl, 0x7f02(%rip)       # 0x18000ac00
180002cfe:     	je	0x180002d08 <numba_list_iter_next+0x138>
180002d00:     	lock
180002d01:     	incq	0x7f10(%rip)            # 0x18000ac18
180002d08:     	movq	0x30(%rsp), %rbx
180002d0d:     	movq	%r8, %rax
180002d10:     	addq	$0x20, %rsp
180002d14:     	popq	%rdi
180002d15:     	retq
180002d16:     	int3
180002d17:     	int3
180002d18:     	int3
180002d19:     	int3
180002d1a:     	int3
180002d1b:     	int3
180002d1c:     	int3
180002d1d:     	int3
180002d1e:     	int3
180002d1f:     	int3
180002d20:     	lock
180002d21:     	incq	(%rcx)
180002d24:     	retq
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
180002d36:     	movq	0x8(%rcx), %rax
180002d3a:     	movq	%rcx, %rbx
180002d3d:     	testq	%rax, %rax
180002d40:     	je	0x180002d59 <numba_list_iter_next+0x189>
180002d42:     	cmpl	$0x0, 0x7eaf(%rip)      # 0x18000abf8
180002d49:     	jne	0x180002d59 <numba_list_iter_next+0x189>
180002d4b:     	movq	0x10(%rcx), %r8
180002d4f:     	movq	0x20(%rcx), %rdx
180002d53:     	movq	0x18(%rcx), %rcx
180002d57:     	callq	*%rax
180002d59:     	movq	0x28(%rbx), %rax
180002d5d:     	movq	%rbx, %rcx
180002d60:     	testq	%rax, %rax
180002d63:     	je	0x180002d6e <numba_list_iter_next+0x19e>
180002d65:     	movq	0x18(%rax), %rdx
180002d69:     	callq	*0x10(%rax)
180002d6c:     	jmp	0x180002d74 <numba_list_iter_next+0x1a4>
180002d6e:     	callq	*0x7ec4(%rip)           # 0x18000ac38
180002d74:     	cmpb	$0x0, 0x7e85(%rip)      # 0x18000ac00
180002d7b:     	je	0x180002d99 <numba_list_iter_next+0x1c9>
180002d7d:     	leaq	0x7e8c(%rip), %rax      # 0x18000ac10
180002d84:     	lock
180002d85:     	incq	(%rax)
180002d88:     	cmpb	$0x0, 0x7e71(%rip)      # 0x18000ac00
180002d8f:     	je	0x180002d99 <numba_list_iter_next+0x1c9>
180002d91:     	lock
180002d92:     	incq	0x7e87(%rip)            # 0x18000ac20
180002d99:     	addq	$0x20, %rsp
180002d9d:     	popq	%rbx
180002d9e:     	retq
180002d9f:     	int3
180002da0:     	pushq	%rbx
180002da2:     	subq	$0x20, %rsp
180002da6:     	movq	%rcx, %rbx
180002da9:     	movq	$-0x1, %rax
180002db0:     	lock
180002db1:     	xaddq	%rax, (%rcx)
180002db5:     	cmpq	$0x1, %rax
180002db9:     	jne	0x180002e1b <numba_list_iter_next+0x24b>
180002dbb:     	movq	0x8(%rcx), %rax
180002dbf:     	testq	%rax, %rax
180002dc2:     	je	0x180002ddb <numba_list_iter_next+0x20b>
180002dc4:     	cmpl	$0x0, 0x7e2d(%rip)      # 0x18000abf8
180002dcb:     	jne	0x180002ddb <numba_list_iter_next+0x20b>
180002dcd:     	movq	0x10(%rcx), %r8
180002dd1:     	movq	0x20(%rcx), %rdx
180002dd5:     	movq	0x18(%rcx), %rcx
180002dd9:     	callq	*%rax
180002ddb:     	movq	0x28(%rbx), %rax
180002ddf:     	movq	%rbx, %rcx
180002de2:     	testq	%rax, %rax
180002de5:     	je	0x180002df0 <numba_list_iter_next+0x220>
180002de7:     	movq	0x18(%rax), %rdx
180002deb:     	callq	*0x10(%rax)
180002dee:     	jmp	0x180002df6 <numba_list_iter_next+0x226>
180002df0:     	callq	*0x7e42(%rip)           # 0x18000ac38
180002df6:     	cmpb	$0x0, 0x7e03(%rip)      # 0x18000ac00
180002dfd:     	je	0x180002e1b <numba_list_iter_next+0x24b>
180002dff:     	leaq	0x7e0a(%rip), %rax      # 0x18000ac10
180002e06:     	lock
180002e07:     	incq	(%rax)
180002e0a:     	cmpb	$0x0, 0x7def(%rip)      # 0x18000ac00
180002e11:     	je	0x180002e1b <numba_list_iter_next+0x24b>
180002e13:     	lock
180002e14:     	incq	0x7e05(%rip)            # 0x18000ac20
180002e1b:     	addq	$0x20, %rsp
180002e1f:     	popq	%rbx
180002e20:     	retq
180002e21:     	int3
180002e22:     	int3
180002e23:     	int3
180002e24:     	int3
180002e25:     	int3
180002e26:     	int3
180002e27:     	int3
180002e28:     	int3
180002e29:     	int3
180002e2a:     	int3
180002e2b:     	int3
180002e2c:     	int3
180002e2d:     	int3
180002e2e:     	int3
180002e2f:     	int3
180002e30:     	movq	0x18(%rcx), %rax
180002e34:     	retq
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
180002e40:     	jmpq	*%r8
180002e43:     	int3
180002e44:     	int3
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
180002e50:     	movq	%rbx, 0x8(%rsp)
180002e55:     	pushq	%rdi
180002e56:     	subq	$0x20, %rsp
180002e5a:     	movq	%rcx, %rdi
180002e5d:     	movq	%rdx, %rbx
180002e60:     	movl	$0x30, %ecx
180002e65:     	callq	*0x7dbd(%rip)           # 0x18000ac28
180002e6b:     	cmpb	$0x0, 0x7d8e(%rip)      # 0x18000ac00
180002e72:     	je	0x180002e7c <numba_list_iter_next+0x2ac>
180002e74:     	lock
180002e75:     	incq	0x7d8c(%rip)            # 0x18000ac08
180002e7c:     	testq	%rax, %rax
180002e7f:     	je	0x180002eb6 <numba_list_iter_next+0x2e6>
180002e81:     	leaq	-0x48(%rip), %rcx       # 0x180002e40 <numba_list_iter_next+0x270>
180002e88:     	movl	$0x1, %edx
180002e8d:     	xchgq	%rdx, (%rax)
180002e90:     	movq	%rcx, 0x8(%rax)
180002e94:     	xorl	%ecx, %ecx
180002e96:     	movq	%rcx, 0x20(%rax)
180002e9a:     	movq	%rcx, 0x28(%rax)
180002e9e:     	movq	%rbx, 0x10(%rax)
180002ea2:     	movq	%rdi, 0x18(%rax)
180002ea6:     	cmpb	%cl, 0x7d54(%rip)       # 0x18000ac00
180002eac:     	je	0x180002eb6 <numba_list_iter_next+0x2e6>
180002eae:     	lock
180002eaf:     	incq	0x7d62(%rip)            # 0x18000ac18
180002eb6:     	movq	0x30(%rsp), %rbx
180002ebb:     	addq	$0x20, %rsp
180002ebf:     	popq	%rdi
180002ec0:     	retq
180002ec1:     	jmpq	*0x13a9(%rip)           # 0x180004270
180002ec7:     	jmpq	*0x1393(%rip)           # 0x180004260
180002ecd:     	jmpq	*0x1385(%rip)           # 0x180004258
180002ed3:     	jmpq	*0x1377(%rip)           # 0x180004250
180002ed9:     	jmpq	*0x1369(%rip)           # 0x180004248
180002edf:     	jmpq	*0x135b(%rip)           # 0x180004240
180002ee5:     	jmpq	*0x1345(%rip)           # 0x180004230
180002eeb:     	jmpq	*0x132f(%rip)           # 0x180004220
180002ef1:     	jmpq	*0x1309(%rip)           # 0x180004200
180002ef7:     	int3
180002ef8:     	int3
180002ef9:     	int3
180002efa:     	int3
180002efb:     	int3
180002efc:     	int3
180002efd:     	int3
180002efe:     	int3
180002eff:     	int3
180002f00:     	int3
180002f01:     	int3
180002f02:     	int3
180002f03:     	int3
180002f04:     	int3
180002f05:     	int3
180002f06:     	nopw	(%rax,%rax)
180002f10:     	cmpq	0x71a9(%rip), %rcx      # 0x18000a0c0
180002f17:     	jne	0x180002f29 <numba_list_iter_next+0x359>
180002f19:     	rolq	$0x10, %rcx
180002f1d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180002f22:     	jne	0x180002f25 <numba_list_iter_next+0x355>
180002f24:     	retq
180002f25:     	rorq	$0x10, %rcx
180002f29:     	jmp	0x180003284 <numba_list_iter_next+0x6b4>
180002f2e:     	int3
180002f2f:     	int3
180002f30:     	subq	$0x28, %rsp
180002f34:     	testl	%edx, %edx
180002f36:     	je	0x180002f71 <numba_list_iter_next+0x3a1>
180002f38:     	subl	$0x1, %edx
180002f3b:     	je	0x180002f65 <numba_list_iter_next+0x395>
180002f3d:     	subl	$0x1, %edx
180002f40:     	je	0x180002f58 <numba_list_iter_next+0x388>
180002f42:     	cmpl	$0x1, %edx
180002f45:     	je	0x180002f51 <numba_list_iter_next+0x381>
180002f47:     	movl	$0x1, %eax
180002f4c:     	addq	$0x28, %rsp
180002f50:     	retq
180002f51:     	callq	0x180003450 <numba_list_iter_next+0x880>
180002f56:     	jmp	0x180002f5d <numba_list_iter_next+0x38d>
180002f58:     	callq	0x180003428 <numba_list_iter_next+0x858>
180002f5d:     	movzbl	%al, %eax
180002f60:     	addq	$0x28, %rsp
180002f64:     	retq
180002f65:     	movq	%r8, %rdx
180002f68:     	addq	$0x28, %rsp
180002f6c:     	jmp	0x180002f80 <numba_list_iter_next+0x3b0>
180002f71:     	testq	%r8, %r8
180002f74:     	setne	%cl
180002f77:     	addq	$0x28, %rsp
180002f7b:     	jmp	0x180003098 <numba_list_iter_next+0x4c8>
180002f80:     	movq	%rbx, 0x8(%rsp)
180002f85:     	movq	%rsi, 0x10(%rsp)
180002f8a:     	movq	%rdi, 0x20(%rsp)
180002f8f:     	pushq	%r14
180002f91:     	subq	$0x20, %rsp
180002f95:     	movq	%rdx, %rsi
180002f98:     	movq	%rcx, %r14
180002f9b:     	xorl	%ecx, %ecx
180002f9d:     	callq	0x18000350c <numba_list_iter_next+0x93c>
180002fa2:     	testb	%al, %al
180002fa4:     	je	0x180003072 <numba_list_iter_next+0x4a2>
180002faa:     	callq	0x1800033a0 <numba_list_iter_next+0x7d0>
180002faf:     	movb	%al, %bl
180002fb1:     	movb	%al, 0x40(%rsp)
180002fb5:     	movb	$0x1, %dil
180002fb8:     	cmpl	$0x0, 0x7a09(%rip)      # 0x18000a9c8
180002fbf:     	jne	0x18000308a <numba_list_iter_next+0x4ba>
180002fc5:     	movl	$0x1, 0x79f9(%rip)      # 0x18000a9c8
180002fcf:     	callq	0x180003410 <numba_list_iter_next+0x840>
180002fd4:     	testb	%al, %al
180002fd6:     	je	0x180003027 <numba_list_iter_next+0x457>
180002fd8:     	callq	0x1800036cc <numba_list_iter_next+0xafc>
180002fdd:     	callq	0x180003360 <numba_list_iter_next+0x790>
180002fe2:     	callq	0x180003384 <numba_list_iter_next+0x7b4>
180002fe7:     	leaq	0x12e2(%rip), %rdx      # 0x1800042d0
180002fee:     	leaq	0x12d3(%rip), %rcx      # 0x1800042c8
180002ff5:     	callq	0x180003a12 <numba_list_iter_next+0xe42>
180002ffa:     	testl	%eax, %eax
180002ffc:     	jne	0x180003027 <numba_list_iter_next+0x457>
180002ffe:     	callq	0x1800033dc <numba_list_iter_next+0x80c>
180003003:     	testb	%al, %al
180003005:     	je	0x180003027 <numba_list_iter_next+0x457>
180003007:     	leaq	0x12b2(%rip), %rdx      # 0x1800042c0
18000300e:     	leaq	0x12a3(%rip), %rcx      # 0x1800042b8
180003015:     	callq	0x180003a0c <numba_list_iter_next+0xe3c>
18000301a:     	movl	$0x2, 0x79a4(%rip)      # 0x18000a9c8
180003024:     	xorb	%dil, %dil
180003027:     	movb	%bl, %cl
180003029:     	callq	0x18000366c <numba_list_iter_next+0xa9c>
18000302e:     	testb	%dil, %dil
180003031:     	jne	0x180003072 <numba_list_iter_next+0x4a2>
180003033:     	callq	0x1800036bc <numba_list_iter_next+0xaec>
180003038:     	movq	%rax, %rbx
18000303b:     	cmpq	$0x0, (%rax)
18000303f:     	je	0x180003065 <numba_list_iter_next+0x495>
180003041:     	movq	%rax, %rcx
180003044:     	callq	0x1800035d4 <numba_list_iter_next+0xa04>
180003049:     	testb	%al, %al
18000304b:     	je	0x180003065 <numba_list_iter_next+0x495>
18000304d:     	movq	%rsi, %r8
180003050:     	movl	$0x2, %edx
180003055:     	movq	%r14, %rcx
180003058:     	movq	(%rbx), %rax
18000305b:     	movq	0x122e(%rip), %r9       # 0x180004290
180003062:     	callq	*%r9
180003065:     	incl	0x7935(%rip)            # 0x18000a9a0
18000306b:     	movl	$0x1, %eax
180003070:     	jmp	0x180003074 <numba_list_iter_next+0x4a4>
180003072:     	xorl	%eax, %eax
180003074:     	movq	0x30(%rsp), %rbx
180003079:     	movq	0x38(%rsp), %rsi
18000307e:     	movq	0x48(%rsp), %rdi
180003083:     	addq	$0x20, %rsp
180003087:     	popq	%r14
180003089:     	retq
18000308a:     	movl	$0x7, %ecx
18000308f:     	callq	0x1800036c4 <numba_list_iter_next+0xaf4>
180003094:     	nop
180003095:     	int3
180003096:     	int3
180003097:     	int3
180003098:     	movq	%rbx, 0x8(%rsp)
18000309d:     	pushq	%rdi
18000309e:     	subq	$0x30, %rsp
1800030a2:     	movb	%cl, %dil
1800030a5:     	movl	0x78f5(%rip), %eax      # 0x18000a9a0
1800030ab:     	testl	%eax, %eax
1800030ad:     	jg	0x1800030bc <numba_list_iter_next+0x4ec>
1800030af:     	xorl	%eax, %eax
1800030b1:     	movq	0x40(%rsp), %rbx
1800030b6:     	addq	$0x30, %rsp
1800030ba:     	popq	%rdi
1800030bb:     	retq
1800030bc:     	decl	%eax
1800030be:     	movl	%eax, 0x78dc(%rip)      # 0x18000a9a0
1800030c4:     	callq	0x1800033a0 <numba_list_iter_next+0x7d0>
1800030c9:     	movb	%al, %bl
1800030cb:     	movb	%al, 0x20(%rsp)
1800030cf:     	cmpl	$0x2, 0x78f2(%rip)      # 0x18000a9c8
1800030d6:     	jne	0x18000310e <numba_list_iter_next+0x53e>
1800030d8:     	callq	0x1800034c8 <numba_list_iter_next+0x8f8>
1800030dd:     	callq	0x180003370 <numba_list_iter_next+0x7a0>
1800030e2:     	callq	0x180003708 <numba_list_iter_next+0xb38>
1800030e7:     	movl	$0x0, 0x78d7(%rip)      # 0x18000a9c8
1800030f1:     	movb	%bl, %cl
1800030f3:     	callq	0x18000366c <numba_list_iter_next+0xa9c>
1800030f8:     	xorl	%edx, %edx
1800030fa:     	movb	%dil, %cl
1800030fd:     	callq	0x180003690 <numba_list_iter_next+0xac0>
180003102:     	movzbl	%al, %ebx
180003105:     	callq	0x1800034f8 <numba_list_iter_next+0x928>
18000310a:     	movl	%ebx, %eax
18000310c:     	jmp	0x1800030b1 <numba_list_iter_next+0x4e1>
18000310e:     	movl	$0x7, %ecx
180003113:     	callq	0x1800036c4 <numba_list_iter_next+0xaf4>
180003118:     	nop
180003119:     	nop
18000311a:     	int3
18000311b:     	int3
18000311c:     	movq	%rsp, %rax
18000311f:     	movq	%rbx, 0x20(%rax)
180003123:     	movq	%r8, 0x18(%rax)
180003127:     	movl	%edx, 0x10(%rax)
18000312a:     	movq	%rcx, 0x8(%rax)
18000312e:     	pushq	%rsi
18000312f:     	pushq	%rdi
180003130:     	pushq	%r14
180003132:     	subq	$0x40, %rsp
180003136:     	movq	%r8, %rsi
180003139:     	movl	%edx, %edi
18000313b:     	movq	%rcx, %r14
18000313e:     	testl	%edx, %edx
180003140:     	jne	0x180003151 <numba_list_iter_next+0x581>
180003142:     	cmpl	%edx, 0x7858(%rip)      # 0x18000a9a0
180003148:     	jg	0x180003151 <numba_list_iter_next+0x581>
18000314a:     	xorl	%eax, %eax
18000314c:     	jmp	0x180003236 <numba_list_iter_next+0x666>
180003151:     	leal	-0x1(%rdx), %eax
180003154:     	cmpl	$0x1, %eax
180003157:     	ja	0x180003199 <numba_list_iter_next+0x5c9>
180003159:     	movq	0x1458(%rip), %rax      # 0x1800045b8
180003160:     	testq	%rax, %rax
180003163:     	jne	0x18000316a <numba_list_iter_next+0x59a>
180003165:     	leal	0x1(%rax), %ebx
180003168:     	jmp	0x180003172 <numba_list_iter_next+0x5a2>
18000316a:     	callq	*0x1120(%rip)           # 0x180004290
180003170:     	movl	%eax, %ebx
180003172:     	movl	%ebx, 0x30(%rsp)
180003176:     	testl	%ebx, %ebx
180003178:     	je	0x18000322c <numba_list_iter_next+0x65c>
18000317e:     	movq	%rsi, %r8
180003181:     	movl	%edi, %edx
180003183:     	movq	%r14, %rcx
180003186:     	callq	0x180002f30 <numba_list_iter_next+0x360>
18000318b:     	movl	%eax, %ebx
18000318d:     	movl	%eax, 0x30(%rsp)
180003191:     	testl	%eax, %eax
180003193:     	je	0x18000322c <numba_list_iter_next+0x65c>
180003199:     	movq	%rsi, %r8
18000319c:     	movl	%edi, %edx
18000319e:     	movq	%r14, %rcx
1800031a1:     	callq	0x18000333c <numba_list_iter_next+0x76c>
1800031a6:     	movl	%eax, %ebx
1800031a8:     	movl	%eax, 0x30(%rsp)
1800031ac:     	cmpl	$0x1, %edi
1800031af:     	jne	0x1800031e7 <numba_list_iter_next+0x617>
1800031b1:     	testl	%eax, %eax
1800031b3:     	jne	0x1800031e7 <numba_list_iter_next+0x617>
1800031b5:     	movq	%rsi, %r8
1800031b8:     	xorl	%edx, %edx
1800031ba:     	movq	%r14, %rcx
1800031bd:     	callq	0x18000333c <numba_list_iter_next+0x76c>
1800031c2:     	testq	%rsi, %rsi
1800031c5:     	setne	%cl
1800031c8:     	callq	0x180003098 <numba_list_iter_next+0x4c8>
1800031cd:     	movq	0x13e4(%rip), %rax      # 0x1800045b8
1800031d4:     	testq	%rax, %rax
1800031d7:     	je	0x1800031e7 <numba_list_iter_next+0x617>
1800031d9:     	movq	%rsi, %r8
1800031dc:     	xorl	%edx, %edx
1800031de:     	movq	%r14, %rcx
1800031e1:     	callq	*0x10a9(%rip)           # 0x180004290
1800031e7:     	testl	%edi, %edi
1800031e9:     	je	0x1800031f0 <numba_list_iter_next+0x620>
1800031eb:     	cmpl	$0x3, %edi
1800031ee:     	jne	0x18000322c <numba_list_iter_next+0x65c>
1800031f0:     	movq	%rsi, %r8
1800031f3:     	movl	%edi, %edx
1800031f5:     	movq	%r14, %rcx
1800031f8:     	callq	0x180002f30 <numba_list_iter_next+0x360>
1800031fd:     	movl	%eax, %ebx
1800031ff:     	movl	%eax, 0x30(%rsp)
180003203:     	testl	%eax, %eax
180003205:     	je	0x18000322c <numba_list_iter_next+0x65c>
180003207:     	movq	0x13aa(%rip), %rax      # 0x1800045b8
18000320e:     	testq	%rax, %rax
180003211:     	jne	0x180003218 <numba_list_iter_next+0x648>
180003213:     	leal	0x1(%rax), %ebx
180003216:     	jmp	0x180003228 <numba_list_iter_next+0x658>
180003218:     	movq	%rsi, %r8
18000321b:     	movl	%edi, %edx
18000321d:     	movq	%r14, %rcx
180003220:     	callq	*0x106a(%rip)           # 0x180004290
180003226:     	movl	%eax, %ebx
180003228:     	movl	%ebx, 0x30(%rsp)
18000322c:     	jmp	0x180003234 <numba_list_iter_next+0x664>
18000322e:     	xorl	%ebx, %ebx
180003230:     	movl	%ebx, 0x30(%rsp)
180003234:     	movl	%ebx, %eax
180003236:     	movq	0x78(%rsp), %rbx
18000323b:     	addq	$0x40, %rsp
18000323f:     	popq	%r14
180003241:     	popq	%rdi
180003242:     	popq	%rsi
180003243:     	retq
180003244:     	movq	%rbx, 0x8(%rsp)
180003249:     	movq	%rsi, 0x10(%rsp)
18000324e:     	pushq	%rdi
18000324f:     	subq	$0x20, %rsp
180003253:     	movq	%r8, %rdi
180003256:     	movl	%edx, %ebx
180003258:     	movq	%rcx, %rsi
18000325b:     	cmpl	$0x1, %edx
18000325e:     	jne	0x180003265 <numba_list_iter_next+0x695>
180003260:     	callq	0x18000328c <numba_list_iter_next+0x6bc>
180003265:     	movq	%rdi, %r8
180003268:     	movl	%ebx, %edx
18000326a:     	movq	%rsi, %rcx
18000326d:     	movq	0x30(%rsp), %rbx
180003272:     	movq	0x38(%rsp), %rsi
180003277:     	addq	$0x20, %rsp
18000327b:     	popq	%rdi
18000327c:     	jmp	0x18000311c <numba_list_iter_next+0x54c>
180003281:     	int3
180003282:     	int3
180003283:     	int3
180003284:     	movl	$0x2, %ecx
180003289:     	int	$0x29
18000328b:     	retq
18000328c:     	movq	%rbx, 0x18(%rsp)
180003291:     	pushq	%rbp
180003292:     	movq	%rsp, %rbp
180003295:     	subq	$0x30, %rsp
180003299:     	movq	0x6e20(%rip), %rax      # 0x18000a0c0
1800032a0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1800032aa:     	cmpq	%rbx, %rax
1800032ad:     	jne	0x180003326 <numba_list_iter_next+0x756>
1800032af:     	leaq	0x10(%rbp), %rcx
1800032b3:     	movq	$0x0, 0x10(%rbp)
1800032bb:     	callq	*0xd5f(%rip)            # 0x180004020
1800032c1:     	movq	0x10(%rbp), %rax
1800032c5:     	movq	%rax, -0x10(%rbp)
1800032c9:     	callq	*0xd49(%rip)            # 0x180004018
1800032cf:     	movl	%eax, %eax
1800032d1:     	xorq	%rax, -0x10(%rbp)
1800032d5:     	callq	*0xd35(%rip)            # 0x180004010
1800032db:     	movl	%eax, %eax
1800032dd:     	leaq	0x18(%rbp), %rcx
1800032e1:     	xorq	%rax, -0x10(%rbp)
1800032e5:     	callq	*0xd15(%rip)            # 0x180004000
1800032eb:     	movl	0x18(%rbp), %eax
1800032ee:     	leaq	-0x10(%rbp), %rcx
1800032f2:     	shlq	$0x20, %rax
1800032f6:     	xorq	0x18(%rbp), %rax
1800032fa:     	xorq	-0x10(%rbp), %rax
1800032fe:     	xorq	%rcx, %rax
180003301:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000330b:     	andq	%rcx, %rax
18000330e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180003318:     	cmpq	%rbx, %rax
18000331b:     	cmoveq	%rcx, %rax
18000331f:     	movq	%rax, 0x6d9a(%rip)      # 0x18000a0c0
180003326:     	movq	0x50(%rsp), %rbx
18000332b:     	notq	%rax
18000332e:     	movq	%rax, 0x6dcb(%rip)      # 0x18000a100
180003335:     	addq	$0x30, %rsp
180003339:     	popq	%rbp
18000333a:     	retq
18000333b:     	int3
18000333c:     	subq	$0x28, %rsp
180003340:     	cmpl	$0x1, %edx
180003343:     	jne	0x180003355 <numba_list_iter_next+0x785>
180003345:     	cmpq	$0x0, 0x126b(%rip)      # 0x1800045b8
18000334d:     	jne	0x180003355 <numba_list_iter_next+0x785>
18000334f:     	callq	*0xcd3(%rip)            # 0x180004028
180003355:     	movl	$0x1, %eax
18000335a:     	addq	$0x28, %rsp
18000335e:     	retq
18000335f:     	int3
180003360:     	leaq	0x7649(%rip), %rcx      # 0x18000a9b0
180003367:     	jmpq	*0xc9a(%rip)            # 0x180004008
18000336e:     	int3
18000336f:     	int3
180003370:     	leaq	0x7639(%rip), %rcx      # 0x18000a9b0
180003377:     	jmp	0x180003a06 <numba_list_iter_next+0xe36>
18000337c:     	leaq	0x763d(%rip), %rax      # 0x18000a9c0
180003383:     	retq
180003384:     	subq	$0x28, %rsp
180003388:     	callq	0x1800024e0 <PyInit_rcnumeric_3d36deac3a8cae31652c24de+0x10e0>
18000338d:     	orq	$0x24, (%rax)
180003391:     	callq	0x18000337c <numba_list_iter_next+0x7ac>
180003396:     	orq	$0x2, (%rax)
18000339a:     	addq	$0x28, %rsp
18000339e:     	retq
18000339f:     	int3
1800033a0:     	subq	$0x28, %rsp
1800033a4:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
1800033a9:     	testl	%eax, %eax
1800033ab:     	je	0x1800033ce <numba_list_iter_next+0x7fe>
1800033ad:     	movq	%gs:0x30, %rax
1800033b6:     	movq	0x8(%rax), %rcx
1800033ba:     	jmp	0x1800033c1 <numba_list_iter_next+0x7f1>
1800033bc:     	cmpq	%rax, %rcx
1800033bf:     	je	0x1800033d5 <numba_list_iter_next+0x805>
1800033c1:     	xorl	%eax, %eax
1800033c3:     	lock
1800033c4:     	cmpxchgq	%rcx, 0x7604(%rip)      # 0x18000a9d0
1800033cc:     	jne	0x1800033bc <numba_list_iter_next+0x7ec>
1800033ce:     	xorb	%al, %al
1800033d0:     	addq	$0x28, %rsp
1800033d4:     	retq
1800033d5:     	movb	$0x1, %al
1800033d7:     	jmp	0x1800033d0 <numba_list_iter_next+0x800>
1800033d9:     	int3
1800033da:     	int3
1800033db:     	int3
1800033dc:     	subq	$0x28, %rsp
1800033e0:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
1800033e5:     	testl	%eax, %eax
1800033e7:     	je	0x1800033f0 <numba_list_iter_next+0x820>
1800033e9:     	callq	0x180003748 <numba_list_iter_next+0xb78>
1800033ee:     	jmp	0x180003409 <numba_list_iter_next+0x839>
1800033f0:     	callq	0x1800039e4 <numba_list_iter_next+0xe14>
1800033f5:     	movl	%eax, %ecx
1800033f7:     	callq	0x180003a1e <numba_list_iter_next+0xe4e>
1800033fc:     	testl	%eax, %eax
1800033fe:     	je	0x180003404 <numba_list_iter_next+0x834>
180003400:     	xorb	%al, %al
180003402:     	jmp	0x18000340b <numba_list_iter_next+0x83b>
180003404:     	callq	0x180003a24 <numba_list_iter_next+0xe54>
180003409:     	movb	$0x1, %al
18000340b:     	addq	$0x28, %rsp
18000340f:     	retq
180003410:     	subq	$0x28, %rsp
180003414:     	xorl	%ecx, %ecx
180003416:     	callq	0x180003548 <numba_list_iter_next+0x978>
18000341b:     	testb	%al, %al
18000341d:     	setne	%al
180003420:     	addq	$0x28, %rsp
180003424:     	retq
180003425:     	int3
180003426:     	int3
180003427:     	int3
180003428:     	subq	$0x28, %rsp
18000342c:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003431:     	testb	%al, %al
180003433:     	jne	0x180003439 <numba_list_iter_next+0x869>
180003435:     	xorb	%al, %al
180003437:     	jmp	0x18000344b <numba_list_iter_next+0x87b>
180003439:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
18000343e:     	testb	%al, %al
180003440:     	jne	0x180003449 <numba_list_iter_next+0x879>
180003442:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003447:     	jmp	0x180003435 <numba_list_iter_next+0x865>
180003449:     	movb	$0x1, %al
18000344b:     	addq	$0x28, %rsp
18000344f:     	retq
180003450:     	subq	$0x28, %rsp
180003454:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003459:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
18000345e:     	movb	$0x1, %al
180003460:     	addq	$0x28, %rsp
180003464:     	retq
180003465:     	int3
180003466:     	int3
180003467:     	int3
180003468:     	movq	%rbx, 0x8(%rsp)
18000346d:     	movq	%rbp, 0x10(%rsp)
180003472:     	movq	%rsi, 0x18(%rsp)
180003477:     	pushq	%rdi
180003478:     	subq	$0x20, %rsp
18000347c:     	movq	%r9, %rdi
18000347f:     	movq	%r8, %rsi
180003482:     	movl	%edx, %ebx
180003484:     	movq	%rcx, %rbp
180003487:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
18000348c:     	testl	%eax, %eax
18000348e:     	jne	0x1800034a6 <numba_list_iter_next+0x8d6>
180003490:     	cmpl	$0x1, %ebx
180003493:     	jne	0x1800034a6 <numba_list_iter_next+0x8d6>
180003495:     	movq	%rsi, %r8
180003498:     	xorl	%edx, %edx
18000349a:     	movq	%rbp, %rcx
18000349d:     	movq	%rdi, %rax
1800034a0:     	callq	*0xdea(%rip)            # 0x180004290
1800034a6:     	movq	0x58(%rsp), %rdx
1800034ab:     	movl	0x50(%rsp), %ecx
1800034af:     	movq	0x30(%rsp), %rbx
1800034b4:     	movq	0x38(%rsp), %rbp
1800034b9:     	movq	0x40(%rsp), %rsi
1800034be:     	addq	$0x20, %rsp
1800034c2:     	popq	%rdi
1800034c3:     	jmp	0x180003a18 <numba_list_iter_next+0xe48>
1800034c8:     	subq	$0x28, %rsp
1800034cc:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
1800034d1:     	testl	%eax, %eax
1800034d3:     	je	0x1800034e5 <numba_list_iter_next+0x915>
1800034d5:     	leaq	0x7504(%rip), %rcx      # 0x18000a9e0
1800034dc:     	addq	$0x28, %rsp
1800034e0:     	jmp	0x180003a30 <numba_list_iter_next+0xe60>
1800034e5:     	callq	0x180003a40 <numba_list_iter_next+0xe70>
1800034ea:     	testl	%eax, %eax
1800034ec:     	jne	0x1800034f3 <numba_list_iter_next+0x923>
1800034ee:     	callq	0x180003a36 <numba_list_iter_next+0xe66>
1800034f3:     	addq	$0x28, %rsp
1800034f7:     	retq
1800034f8:     	subq	$0x28, %rsp
1800034fc:     	xorl	%ecx, %ecx
1800034fe:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003503:     	addq	$0x28, %rsp
180003507:     	jmp	0x180003a3c <numba_list_iter_next+0xe6c>
18000350c:     	subq	$0x28, %rsp
180003510:     	testl	%ecx, %ecx
180003512:     	jne	0x18000351b <numba_list_iter_next+0x94b>
180003514:     	movb	$0x1, 0x74bd(%rip)      # 0x18000a9d8
18000351b:     	callq	0x180003748 <numba_list_iter_next+0xb78>
180003520:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003525:     	testb	%al, %al
180003527:     	jne	0x18000352d <numba_list_iter_next+0x95d>
180003529:     	xorb	%al, %al
18000352b:     	jmp	0x180003541 <numba_list_iter_next+0x971>
18000352d:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
180003532:     	testb	%al, %al
180003534:     	jne	0x18000353f <numba_list_iter_next+0x96f>
180003536:     	xorl	%ecx, %ecx
180003538:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
18000353d:     	jmp	0x180003529 <numba_list_iter_next+0x959>
18000353f:     	movb	$0x1, %al
180003541:     	addq	$0x28, %rsp
180003545:     	retq
180003546:     	int3
180003547:     	int3
180003548:     	pushq	%rbx
18000354a:     	subq	$0x20, %rsp
18000354e:     	cmpb	$0x0, 0x7484(%rip)      # 0x18000a9d9
180003555:     	movl	%ecx, %ebx
180003557:     	jne	0x1800035c0 <numba_list_iter_next+0x9f0>
180003559:     	cmpl	$0x1, %ecx
18000355c:     	ja	0x1800035c8 <numba_list_iter_next+0x9f8>
18000355e:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
180003563:     	testl	%eax, %eax
180003565:     	je	0x18000358f <numba_list_iter_next+0x9bf>
180003567:     	testl	%ebx, %ebx
180003569:     	jne	0x18000358f <numba_list_iter_next+0x9bf>
18000356b:     	leaq	0x746e(%rip), %rcx      # 0x18000a9e0
180003572:     	callq	0x180003a2a <numba_list_iter_next+0xe5a>
180003577:     	testl	%eax, %eax
180003579:     	jne	0x18000358b <numba_list_iter_next+0x9bb>
18000357b:     	leaq	0x7476(%rip), %rcx      # 0x18000a9f8
180003582:     	callq	0x180003a2a <numba_list_iter_next+0xe5a>
180003587:     	testl	%eax, %eax
180003589:     	je	0x1800035b9 <numba_list_iter_next+0x9e9>
18000358b:     	xorb	%al, %al
18000358d:     	jmp	0x1800035c2 <numba_list_iter_next+0x9f2>
18000358f:     	movdqa	0x1029(%rip), %xmm0     # 0x1800045c0
180003597:     	orq	$-0x1, %rax
18000359b:     	movdqu	%xmm0, 0x743d(%rip)     # 0x18000a9e0
1800035a3:     	movq	%rax, 0x7446(%rip)      # 0x18000a9f0
1800035aa:     	movdqu	%xmm0, 0x7446(%rip)     # 0x18000a9f8
1800035b2:     	movq	%rax, 0x744f(%rip)      # 0x18000aa08
1800035b9:     	movb	$0x1, 0x7419(%rip)      # 0x18000a9d9
1800035c0:     	movb	$0x1, %al
1800035c2:     	addq	$0x20, %rsp
1800035c6:     	popq	%rbx
1800035c7:     	retq
1800035c8:     	movl	$0x5, %ecx
1800035cd:     	callq	0x1800036c4 <numba_list_iter_next+0xaf4>
1800035d2:     	int3
1800035d3:     	int3
1800035d4:     	subq	$0x18, %rsp
1800035d8:     	movq	%rcx, %r8
1800035db:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
1800035e0:     	cmpw	%ax, -0x35e7(%rip)      # 0x180000000
1800035e7:     	jne	0x180003661 <numba_list_iter_next+0xa91>
1800035e9:     	movslq	-0x35b4(%rip), %rcx     # 0x18000003c
1800035f0:     	leaq	-0x35f7(%rip), %rdx     # 0x180000000
1800035f7:     	addq	%rdx, %rcx
1800035fa:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003600:     	jne	0x180003661 <numba_list_iter_next+0xa91>
180003602:     	movl	$0x20b, %eax            # imm = 0x20B
180003607:     	cmpw	%ax, 0x18(%rcx)
18000360b:     	jne	0x180003661 <numba_list_iter_next+0xa91>
18000360d:     	subq	%rdx, %r8
180003610:     	movzwl	0x14(%rcx), %edx
180003614:     	addq	$0x18, %rdx
180003618:     	addq	%rcx, %rdx
18000361b:     	movzwl	0x6(%rcx), %eax
18000361f:     	leaq	(%rax,%rax,4), %rcx
180003623:     	leaq	(%rdx,%rcx,8), %r9
180003627:     	movq	%rdx, (%rsp)
18000362b:     	cmpq	%r9, %rdx
18000362e:     	je	0x180003648 <numba_list_iter_next+0xa78>
180003630:     	movl	0xc(%rdx), %ecx
180003633:     	cmpq	%rcx, %r8
180003636:     	jb	0x180003642 <numba_list_iter_next+0xa72>
180003638:     	movl	0x8(%rdx), %eax
18000363b:     	addl	%ecx, %eax
18000363d:     	cmpq	%rax, %r8
180003640:     	jb	0x18000364a <numba_list_iter_next+0xa7a>
180003642:     	addq	$0x28, %rdx
180003646:     	jmp	0x180003627 <numba_list_iter_next+0xa57>
180003648:     	xorl	%edx, %edx
18000364a:     	testq	%rdx, %rdx
18000364d:     	jne	0x180003653 <numba_list_iter_next+0xa83>
18000364f:     	xorb	%al, %al
180003651:     	jmp	0x180003667 <numba_list_iter_next+0xa97>
180003653:     	cmpl	$0x0, 0x24(%rdx)
180003657:     	jge	0x18000365d <numba_list_iter_next+0xa8d>
180003659:     	xorb	%al, %al
18000365b:     	jmp	0x180003667 <numba_list_iter_next+0xa97>
18000365d:     	movb	$0x1, %al
18000365f:     	jmp	0x180003667 <numba_list_iter_next+0xa97>
180003661:     	xorb	%al, %al
180003663:     	jmp	0x180003667 <numba_list_iter_next+0xa97>
180003665:     	xorb	%al, %al
180003667:     	addq	$0x18, %rsp
18000366b:     	retq
18000366c:     	pushq	%rbx
18000366e:     	subq	$0x20, %rsp
180003672:     	movb	%cl, %bl
180003674:     	callq	0x1800039ec <numba_list_iter_next+0xe1c>
180003679:     	xorl	%edx, %edx
18000367b:     	testl	%eax, %eax
18000367d:     	je	0x18000368a <numba_list_iter_next+0xaba>
18000367f:     	testb	%bl, %bl
180003681:     	jne	0x18000368a <numba_list_iter_next+0xaba>
180003683:     	xchgq	%rdx, 0x7346(%rip)      # 0x18000a9d0
18000368a:     	addq	$0x20, %rsp
18000368e:     	popq	%rbx
18000368f:     	retq
180003690:     	pushq	%rbx
180003692:     	subq	$0x20, %rsp
180003696:     	cmpb	$0x0, 0x733b(%rip)      # 0x18000a9d8
18000369d:     	movb	%cl, %bl
18000369f:     	je	0x1800036a5 <numba_list_iter_next+0xad5>
1800036a1:     	testb	%dl, %dl
1800036a3:     	jne	0x1800036b1 <numba_list_iter_next+0xae1>
1800036a5:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
1800036aa:     	movb	%bl, %cl
1800036ac:     	callq	0x180003a3c <numba_list_iter_next+0xe6c>
1800036b1:     	movb	$0x1, %al
1800036b3:     	addq	$0x20, %rsp
1800036b7:     	popq	%rbx
1800036b8:     	retq
1800036b9:     	int3
1800036ba:     	int3
1800036bb:     	int3
1800036bc:     	leaq	0x75a5(%rip), %rax      # 0x18000ac68
1800036c3:     	retq
1800036c4:     	movl	%ecx, %ecx
1800036c6:     	int	$0x29
1800036c8:     	retq
1800036c9:     	int3
1800036ca:     	int3
1800036cb:     	int3
1800036cc:     	movq	%rbx, 0x8(%rsp)
1800036d1:     	pushq	%rdi
1800036d2:     	subq	$0x20, %rsp
1800036d6:     	leaq	0x3863(%rip), %rbx      # 0x180006f40
1800036dd:     	leaq	0x385c(%rip), %rdi      # 0x180006f40
1800036e4:     	jmp	0x1800036f8 <numba_list_iter_next+0xb28>
1800036e6:     	movq	(%rbx), %rax
1800036e9:     	testq	%rax, %rax
1800036ec:     	je	0x1800036f4 <numba_list_iter_next+0xb24>
1800036ee:     	callq	*0xb9c(%rip)            # 0x180004290
1800036f4:     	addq	$0x8, %rbx
1800036f8:     	cmpq	%rdi, %rbx
1800036fb:     	jb	0x1800036e6 <numba_list_iter_next+0xb16>
1800036fd:     	movq	0x30(%rsp), %rbx
180003702:     	addq	$0x20, %rsp
180003706:     	popq	%rdi
180003707:     	retq
180003708:     	movq	%rbx, 0x8(%rsp)
18000370d:     	pushq	%rdi
18000370e:     	subq	$0x20, %rsp
180003712:     	leaq	0x3837(%rip), %rbx      # 0x180006f50
180003719:     	leaq	0x3830(%rip), %rdi      # 0x180006f50
180003720:     	jmp	0x180003734 <numba_list_iter_next+0xb64>
180003722:     	movq	(%rbx), %rax
180003725:     	testq	%rax, %rax
180003728:     	je	0x180003730 <numba_list_iter_next+0xb60>
18000372a:     	callq	*0xb60(%rip)            # 0x180004290
180003730:     	addq	$0x8, %rbx
180003734:     	cmpq	%rdi, %rbx
180003737:     	jb	0x180003722 <numba_list_iter_next+0xb52>
180003739:     	movq	0x30(%rsp), %rbx
18000373e:     	addq	$0x20, %rsp
180003742:     	popq	%rdi
180003743:     	retq
180003744:     	retq	$0x0
180003747:     	int3
180003748:     	movq	%rbx, 0x10(%rsp)
18000374d:     	movq	%rbp, 0x18(%rsp)
180003752:     	movq	%rsi, 0x20(%rsp)
180003757:     	pushq	%rdi
180003758:     	subq	$0x10, %rsp
18000375c:     	xorl	%eax, %eax
18000375e:     	xorl	%ecx, %ecx
180003760:     	cpuid
180003762:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003768:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000376e:     	orl	%ecx, %edx
180003770:     	movl	%eax, %ebp
180003772:     	movl	$0x1, %eax
180003777:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000377d:     	orl	%ebx, %edx
18000377f:     	leal	-0x1(%rax), %ecx
180003782:     	cpuid
180003784:     	movl	%ecx, %edi
180003786:     	jne	0x1800037e6 <numba_list_iter_next+0xc16>
180003788:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000378d:     	movq	$0x8000, 0x6980(%rip)   # imm = 0x8000
                                                # 0x18000a118
180003798:     	movq	$-0x1, 0x697d(%rip)     # 0x18000a120
1800037a3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
1800037a8:     	je	0x1800037d2 <numba_list_iter_next+0xc02>
1800037aa:     	cmpl	$0x20660, %eax          # imm = 0x20660
1800037af:     	je	0x1800037d2 <numba_list_iter_next+0xc02>
1800037b1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800037b6:     	je	0x1800037d2 <numba_list_iter_next+0xc02>
1800037b8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800037bd:     	cmpl	$0x20, %eax
1800037c0:     	ja	0x1800037e6 <numba_list_iter_next+0xc16>
1800037c2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1800037cc:     	btq	%rax, %rcx
1800037d0:     	jae	0x1800037e6 <numba_list_iter_next+0xc16>
1800037d2:     	movl	0x723b(%rip), %r8d      # 0x18000aa14
1800037d9:     	orl	$0x1, %r8d
1800037dd:     	movl	%r8d, 0x7230(%rip)      # 0x18000aa14
1800037e4:     	jmp	0x1800037ed <numba_list_iter_next+0xc1d>
1800037e6:     	movl	0x7227(%rip), %r8d      # 0x18000aa14
1800037ed:     	xorl	%r9d, %r9d
1800037f0:     	movl	%r9d, %r11d
1800037f3:     	cmpl	$0x7, %ebp
1800037f6:     	jl	0x18000383a <numba_list_iter_next+0xc6a>
1800037f8:     	xorl	%ecx, %ecx
1800037fa:     	leal	0x7(%r9), %eax
1800037fe:     	cpuid
180003800:     	movl	%edx, %esi
180003802:     	movl	%ebx, %r10d
180003805:     	btl	$0x9, %ebx
180003809:     	jae	0x180003816 <numba_list_iter_next+0xc46>
18000380b:     	orl	$0x2, %r8d
18000380f:     	movl	%r8d, 0x71fe(%rip)      # 0x18000aa14
180003816:     	cmpl	$0x1, %eax
180003819:     	jl	0x180003828 <numba_list_iter_next+0xc58>
18000381b:     	movl	$0x7, %eax
180003820:     	leal	-0x6(%rax), %ecx
180003823:     	cpuid
180003825:     	movl	%edx, %r9d
180003828:     	movl	$0x24, %eax
18000382d:     	cmpl	%eax, %ebp
18000382f:     	jl	0x180003840 <numba_list_iter_next+0xc70>
180003831:     	xorl	%ecx, %ecx
180003833:     	cpuid
180003835:     	movl	%ebx, %r11d
180003838:     	jmp	0x180003840 <numba_list_iter_next+0xc70>
18000383a:     	movl	%r9d, %r10d
18000383d:     	movl	%r9d, %esi
180003840:     	movq	0x68e1(%rip), %rax      # 0x18000a128
180003847:     	andq	$-0x2, %rax
18000384b:     	movl	$0x1, 0x68bb(%rip)      # 0x18000a110
180003855:     	movl	$0x2, 0x68b5(%rip)      # 0x18000a114
18000385f:     	movq	%rax, 0x68c2(%rip)      # 0x18000a128
180003866:     	btl	$0x14, %edi
18000386a:     	jae	0x18000388b <numba_list_iter_next+0xcbb>
18000386c:     	andq	$-0x11, %rax
180003870:     	movl	$0x2, 0x6896(%rip)      # 0x18000a110
18000387a:     	movq	%rax, 0x68a7(%rip)      # 0x18000a128
180003881:     	movl	$0x6, 0x6889(%rip)      # 0x18000a114
18000388b:     	btl	$0x1b, %edi
18000388f:     	jae	0x1800039cc <numba_list_iter_next+0xdfc>
180003895:     	xorl	%ecx, %ecx
180003897:     	xgetbv
18000389a:     	shlq	$0x20, %rdx
18000389e:     	orq	%rax, %rdx
1800038a1:     	movq	%rdx, 0x20(%rsp)
1800038a6:     	btl	$0x1c, %edi
1800038aa:     	jae	0x1800039b0 <numba_list_iter_next+0xde0>
1800038b0:     	movq	0x20(%rsp), %rax
1800038b5:     	andb	$0x6, %al
1800038b7:     	cmpb	$0x6, %al
1800038b9:     	jne	0x1800039b0 <numba_list_iter_next+0xde0>
1800038bf:     	movl	0x684f(%rip), %eax      # 0x18000a114
1800038c5:     	movb	$-0x20, %dl
1800038c7:     	orl	$0x8, %eax
1800038ca:     	movl	$0x3, 0x683c(%rip)      # 0x18000a110
1800038d4:     	movl	%eax, 0x683a(%rip)      # 0x18000a114
1800038da:     	testb	$0x20, %r10b
1800038de:     	je	0x180003942 <numba_list_iter_next+0xd72>
1800038e0:     	orl	$0x20, %eax
1800038e3:     	movl	$0x5, 0x6823(%rip)      # 0x18000a110
1800038ed:     	movl	%eax, 0x6821(%rip)      # 0x18000a114
1800038f3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1800038f8:     	movq	0x6829(%rip), %rax      # 0x18000a128
1800038ff:     	andl	%ecx, %r10d
180003902:     	andq	$-0x3, %rax
180003906:     	movq	%rax, 0x681b(%rip)      # 0x18000a128
18000390d:     	cmpl	%ecx, %r10d
180003910:     	jne	0x180003949 <numba_list_iter_next+0xd79>
180003912:     	movq	0x20(%rsp), %rax
180003917:     	andb	%dl, %al
180003919:     	cmpb	%dl, %al
18000391b:     	jne	0x180003942 <numba_list_iter_next+0xd72>
18000391d:     	movq	0x6804(%rip), %rax      # 0x18000a128
180003924:     	orl	$0x40, 0x67e9(%rip)     # 0x18000a114
18000392b:     	andq	$-0x25, %rax
18000392f:     	movl	$0x6, 0x67d7(%rip)      # 0x18000a110
180003939:     	movq	%rax, 0x67e8(%rip)      # 0x18000a128
180003940:     	jmp	0x180003949 <numba_list_iter_next+0xd79>
180003942:     	movq	0x67df(%rip), %rax      # 0x18000a128
180003949:     	btl	$0x17, %esi
18000394d:     	jae	0x18000395b <numba_list_iter_next+0xd8b>
18000394f:     	btrq	$0x18, %rax
180003954:     	movq	%rax, 0x67cd(%rip)      # 0x18000a128
18000395b:     	btl	$0x13, %r9d
180003960:     	jae	0x1800039b0 <numba_list_iter_next+0xde0>
180003962:     	movq	0x20(%rsp), %rax
180003967:     	andb	%dl, %al
180003969:     	cmpb	%dl, %al
18000396b:     	jne	0x1800039b0 <numba_list_iter_next+0xde0>
18000396d:     	movq	0x67b4(%rip), %rdx      # 0x18000a128
180003974:     	movl	%r11d, %eax
180003977:     	shrq	$0x10, %rax
18000397b:     	movl	%r11d, %ecx
18000397e:     	andl	$0x6, %eax
180003981:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003987:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000398d:     	movl	%ecx, 0x7085(%rip)      # 0x18000aa18
180003993:     	notq	%rax
180003996:     	andq	%rax, %rdx
180003999:     	movq	%rdx, 0x6788(%rip)      # 0x18000a128
1800039a0:     	cmpb	$0x1, %cl
1800039a3:     	jbe	0x1800039b0 <numba_list_iter_next+0xde0>
1800039a5:     	andq	$-0x41, %rdx
1800039a9:     	movq	%rdx, 0x6778(%rip)      # 0x18000a128
1800039b0:     	btl	$0x15, %r9d
1800039b5:     	jae	0x1800039cc <numba_list_iter_next+0xdfc>
1800039b7:     	movq	0x20(%rsp), %rax
1800039bc:     	btq	$0x13, %rax
1800039c1:     	jae	0x1800039cc <numba_list_iter_next+0xdfc>
1800039c3:     	btrq	$0x7, 0x675c(%rip)      # 0x18000a128
1800039cc:     	movq	0x28(%rsp), %rbx
1800039d1:     	xorl	%eax, %eax
1800039d3:     	movq	0x30(%rsp), %rbp
1800039d8:     	movq	0x38(%rsp), %rsi
1800039dd:     	addq	$0x10, %rsp
1800039e1:     	popq	%rdi
1800039e2:     	retq
1800039e3:     	int3
1800039e4:     	movl	$0x1, %eax
1800039e9:     	retq
1800039ea:     	int3
1800039eb:     	int3
1800039ec:     	xorl	%eax, %eax
1800039ee:     	cmpl	%eax, 0x673c(%rip)      # 0x18000a130
1800039f4:     	setne	%al
1800039f7:     	retq
1800039f8:     	int3
1800039f9:     	int3
1800039fa:     	int3
1800039fb:     	int3
1800039fc:     	int3
1800039fd:     	int3
1800039fe:     	int3
1800039ff:     	int3
180003a00:     	jmpq	*0x642(%rip)            # 0x180004048
180003a06:     	jmpq	*0x644(%rip)            # 0x180004050
180003a0c:     	jmpq	*0x67e(%rip)            # 0x180004090
180003a12:     	jmpq	*0x680(%rip)            # 0x180004098
180003a18:     	jmpq	*0x682(%rip)            # 0x1800040a0
180003a1e:     	jmpq	*0x684(%rip)            # 0x1800040a8
180003a24:     	jmpq	*0x686(%rip)            # 0x1800040b0
180003a2a:     	jmpq	*0x650(%rip)            # 0x180004080
180003a30:     	jmpq	*0x682(%rip)            # 0x1800040b8
180003a36:     	jmpq	*0x64c(%rip)            # 0x180004088
180003a3c:     	movb	$0x1, %al
180003a3e:     	retq
180003a3f:     	int3
180003a40:     	xorl	%eax, %eax
180003a42:     	retq
180003a43:     	jmpq	*0x5ef(%rip)            # 0x180004038
180003a49:     	jmpq	*0x5f1(%rip)            # 0x180004040
180003a4f:     	jmpq	*0x673(%rip)            # 0x1800040c8
180003a55:     	jmpq	*0x675(%rip)            # 0x1800040d0
180003a5b:     	int3
180003a5c:     	int3
180003a5d:     	int3
180003a5e:     	int3
180003a5f:     	int3
180003a60:     	int3
180003a61:     	int3
180003a62:     	int3
180003a63:     	int3
180003a64:     	int3
180003a65:     	int3
180003a66:     	nopw	(%rax,%rax)
180003a70:     	jmpq	*%rax
180003a72:     	int3
180003a73:     	int3
180003a74:     	int3
180003a75:     	int3
180003a76:     	int3
180003a77:     	int3
180003a78:     	int3
180003a79:     	int3
180003a7a:     	int3
180003a7b:     	int3
180003a7c:     	int3
180003a7d:     	int3
180003a7e:     	int3
180003a7f:     	int3
180003a80:     	int3
180003a81:     	int3
180003a82:     	int3
180003a83:     	int3
180003a84:     	int3
180003a85:     	int3
180003a86:     	nopw	(%rax,%rax)
180003a90:     	jmpq	*0x7fa(%rip)            # 0x180004290
180003a96:     	pushq	%rbp
180003a98:     	subq	$0x20, %rsp
180003a9c:     	movq	%rdx, %rbp
180003a9f:     	movb	0x40(%rbp), %cl
180003aa2:     	addq	$0x20, %rsp
180003aa6:     	popq	%rbp
180003aa7:     	jmp	0x18000366c <numba_list_iter_next+0xa9c>
180003aac:     	int3
180003aad:     	pushq	%rbp
180003aaf:     	subq	$0x20, %rsp
180003ab3:     	movq	%rdx, %rbp
180003ab6:     	movb	0x20(%rbp), %cl
180003ab9:     	callq	0x18000366c <numba_list_iter_next+0xa9c>
180003abe:     	nop
180003abf:     	addq	$0x20, %rsp
180003ac3:     	popq	%rbp
180003ac4:     	retq
180003ac5:     	int3
180003ac6:     	pushq	%rbp
180003ac8:     	subq	$0x20, %rsp
180003acc:     	movq	%rdx, %rbp
180003acf:     	addq	$0x20, %rsp
180003ad3:     	popq	%rbp
180003ad4:     	jmp	0x1800034f8 <numba_list_iter_next+0x928>
180003ad9:     	int3
180003ada:     	pushq	%rbp
180003adc:     	subq	$0x30, %rsp
180003ae0:     	movq	%rdx, %rbp
180003ae3:     	movq	(%rcx), %rax
180003ae6:     	movl	(%rax), %edx
180003ae8:     	movq	%rcx, 0x28(%rsp)
180003aed:     	movl	%edx, 0x20(%rsp)
180003af1:     	leaq	-0xbc8(%rip), %r9       # 0x180002f30 <numba_list_iter_next+0x360>
180003af8:     	movq	0x70(%rbp), %r8
180003afc:     	movl	0x68(%rbp), %edx
180003aff:     	movq	0x60(%rbp), %rcx
180003b03:     	callq	0x180003468 <numba_list_iter_next+0x898>
180003b08:     	nop
180003b09:     	addq	$0x30, %rsp
180003b0d:     	popq	%rbp
180003b0e:     	retq
180003b0f:     	int3
180003b10:     	pushq	%rbp
180003b12:     	movq	%rdx, %rbp
180003b15:     	movq	(%rcx), %rax
180003b18:     	xorl	%ecx, %ecx
180003b1a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003b20:     	sete	%cl
180003b23:     	movl	%ecx, %eax
180003b25:     	popq	%rbp
180003b26:     	retq
180003b27:     	int3
