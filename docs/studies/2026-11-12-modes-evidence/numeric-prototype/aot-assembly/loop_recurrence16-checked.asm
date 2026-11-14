
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-formal-v1\aot\checked\loop_recurrence16\rcnumeric_202f683b665d056f07b8d3ed.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002ef0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3319(%rip), %rax      # 0x1800043a0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	movq	0x28(%rsp), %rax
180001095:     	testq	%rax, %rax
180001098:     	jle	0x180001119 <.text+0x119>
18000109a:     	incq	%rax
18000109d:     	nopl	(%rax)
1800010a0:     	imulq	%r8, %rdx
1800010a4:     	addq	%r9, %rdx
1800010a7:     	imulq	%r8, %rdx
1800010ab:     	addq	%r9, %rdx
1800010ae:     	imulq	%r8, %rdx
1800010b2:     	addq	%r9, %rdx
1800010b5:     	imulq	%r8, %rdx
1800010b9:     	addq	%r9, %rdx
1800010bc:     	imulq	%r8, %rdx
1800010c0:     	addq	%r9, %rdx
1800010c3:     	imulq	%r8, %rdx
1800010c7:     	addq	%r9, %rdx
1800010ca:     	imulq	%r8, %rdx
1800010ce:     	addq	%r9, %rdx
1800010d1:     	imulq	%r8, %rdx
1800010d5:     	addq	%r9, %rdx
1800010d8:     	imulq	%r8, %rdx
1800010dc:     	addq	%r9, %rdx
1800010df:     	imulq	%r8, %rdx
1800010e3:     	addq	%r9, %rdx
1800010e6:     	imulq	%r8, %rdx
1800010ea:     	addq	%r9, %rdx
1800010ed:     	imulq	%r8, %rdx
1800010f1:     	addq	%r9, %rdx
1800010f4:     	imulq	%r8, %rdx
1800010f8:     	addq	%r9, %rdx
1800010fb:     	imulq	%r8, %rdx
1800010ff:     	addq	%r9, %rdx
180001102:     	imulq	%r8, %rdx
180001106:     	addq	%r9, %rdx
180001109:     	imulq	%r8, %rdx
18000110d:     	addq	%r9, %rdx
180001110:     	decq	%rax
180001113:     	cmpq	$0x1, %rax
180001117:     	ja	0x1800010a0 <.text+0xa0>
180001119:     	movq	%rdx, (%rcx)
18000111c:     	retq
18000111d:     	nopl	(%rax)
180001120:     	pushq	%r15
180001122:     	pushq	%r14
180001124:     	pushq	%r13
180001126:     	pushq	%r12
180001128:     	pushq	%rsi
180001129:     	pushq	%rdi
18000112a:     	pushq	%rbp
18000112b:     	pushq	%rbx
18000112c:     	subq	$0x1a8, %rsp            # imm = 0x1A8
180001133:     	movq	%rdx, %rcx
180001136:     	leaq	0x70(%rsp), %rax
18000113b:     	movq	%rax, 0x58(%rsp)
180001140:     	leaq	0x78(%rsp), %rax
180001145:     	movq	%rax, 0x50(%rsp)
18000114a:     	leaq	0x80(%rsp), %rax
180001152:     	movq	%rax, 0x48(%rsp)
180001157:     	leaq	0x88(%rsp), %rax
18000115f:     	movq	%rax, 0x40(%rsp)
180001164:     	leaq	0x90(%rsp), %rax
18000116c:     	movq	%rax, 0x38(%rsp)
180001171:     	leaq	0x98(%rsp), %rax
180001179:     	movq	%rax, 0x30(%rsp)
18000117e:     	leaq	0xa0(%rsp), %rax
180001186:     	movq	%rax, 0x28(%rsp)
18000118b:     	leaq	0xa8(%rsp), %rax
180001193:     	movq	%rax, 0x20(%rsp)
180001198:     	leaq	0x3231(%rip), %rdx      # 0x1800043d0
18000119f:     	movl	$0x8, %r8d
1800011a5:     	movl	$0x8, %r9d
1800011ab:     	callq	0x180003081 <numba_list_iter_next+0x2f1>
1800011b0:     	testl	%eax, %eax
1800011b2:     	movq	$0x0, 0x60(%rsp)
1800011bb:     	je	0x180001564 <.text+0x564>
1800011c1:     	cmpq	$0x0, 0x9a97(%rip)      # 0x18000ac60
1800011c9:     	je	0x180001487 <.text+0x487>
1800011cf:     	movq	0xa8(%rsp), %rcx
1800011d7:     	xorps	%xmm0, %xmm0
1800011da:     	movaps	%xmm0, 0x170(%rsp)
1800011e2:     	movaps	%xmm0, 0x180(%rsp)
1800011ea:     	movaps	%xmm0, 0x190(%rsp)
1800011f2:     	movq	$0x0, 0x1a0(%rsp)
1800011fe:     	leaq	0x170(%rsp), %rdx
180001206:     	callq	0x180001d60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7a0>
18000120b:     	testl	%eax, %eax
18000120d:     	jne	0x18000149f <.text+0x49f>
180001213:     	cmpq	$0x8, 0x188(%rsp)
18000121c:     	jne	0x18000149f <.text+0x49f>
180001222:     	movq	0x170(%rsp), %rdi
18000122a:     	movq	0xa0(%rsp), %rcx
180001232:     	xorps	%xmm0, %xmm0
180001235:     	movaps	%xmm0, 0x130(%rsp)
18000123d:     	movaps	%xmm0, 0x140(%rsp)
180001245:     	movaps	%xmm0, 0x150(%rsp)
18000124d:     	movq	$0x0, 0x160(%rsp)
180001259:     	leaq	0x130(%rsp), %rdx
180001261:     	callq	0x180001d60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7a0>
180001266:     	testl	%eax, %eax
180001268:     	jne	0x1800014b7 <.text+0x4b7>
18000126e:     	cmpq	$0x8, 0x148(%rsp)
180001277:     	jne	0x1800014b7 <.text+0x4b7>
18000127d:     	movq	0x130(%rsp), %rbx
180001285:     	movq	0x98(%rsp), %rcx
18000128d:     	xorps	%xmm0, %xmm0
180001290:     	movaps	%xmm0, 0xf0(%rsp)
180001298:     	movaps	%xmm0, 0x100(%rsp)
1800012a0:     	movaps	%xmm0, 0x110(%rsp)
1800012a8:     	movq	$0x0, 0x120(%rsp)
1800012b4:     	leaq	0xf0(%rsp), %rdx
1800012bc:     	callq	0x180001d60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7a0>
1800012c1:     	testl	%eax, %eax
1800012c3:     	jne	0x1800014cf <.text+0x4cf>
1800012c9:     	cmpq	$0x8, 0x108(%rsp)
1800012d2:     	jne	0x1800014cf <.text+0x4cf>
1800012d8:     	movq	0xf0(%rsp), %r14
1800012e0:     	movq	0x90(%rsp), %rcx
1800012e8:     	xorps	%xmm0, %xmm0
1800012eb:     	movaps	%xmm0, 0xb0(%rsp)
1800012f3:     	movaps	%xmm0, 0xc0(%rsp)
1800012fb:     	movaps	%xmm0, 0xd0(%rsp)
180001303:     	movq	$0x0, 0xe0(%rsp)
18000130f:     	leaq	0xb0(%rsp), %rdx
180001317:     	callq	0x180001d60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7a0>
18000131c:     	testl	%eax, %eax
18000131e:     	jne	0x1800014e4 <.text+0x4e4>
180001324:     	cmpq	$0x1, 0xc8(%rsp)
18000132d:     	jne	0x1800014e4 <.text+0x4e4>
180001333:     	movq	0xb0(%rsp), %rsi
18000133b:     	movq	0x88(%rsp), %rcx
180001343:     	callq	0x180003087 <numba_list_iter_next+0x2f7>
180001348:     	testq	%rax, %rax
18000134b:     	movq	%rsi, 0x68(%rsp)
180001350:     	je	0x1800014f9 <.text+0x4f9>
180001356:     	movq	%rax, %r12
180001359:     	movq	%rax, %rcx
18000135c:     	callq	0x18000308d <numba_list_iter_next+0x2fd>
180001361:     	movq	%rax, %r15
180001364:     	movq	%r12, %rcx
180001367:     	callq	0x180003093 <numba_list_iter_next+0x303>
18000136c:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001371:     	testq	%rax, %rax
180001374:     	jne	0x180001542 <.text+0x542>
18000137a:     	movq	0x80(%rsp), %rcx
180001382:     	callq	0x180003087 <numba_list_iter_next+0x2f7>
180001387:     	testq	%rax, %rax
18000138a:     	je	0x18000150c <.text+0x50c>
180001390:     	movq	%rax, %r13
180001393:     	movq	%rax, %rcx
180001396:     	callq	0x18000308d <numba_list_iter_next+0x2fd>
18000139b:     	movq	%rax, %r12
18000139e:     	movq	%r13, %rcx
1800013a1:     	callq	0x180003093 <numba_list_iter_next+0x303>
1800013a6:     	callq	0x180003099 <numba_list_iter_next+0x309>
1800013ab:     	testq	%rax, %rax
1800013ae:     	jne	0x180001542 <.text+0x542>
1800013b4:     	movq	0x78(%rsp), %rcx
1800013b9:     	callq	0x180003087 <numba_list_iter_next+0x2f7>
1800013be:     	testq	%rax, %rax
1800013c1:     	je	0x18000151f <.text+0x51f>
1800013c7:     	movq	%rax, %rbp
1800013ca:     	movq	%rax, %rcx
1800013cd:     	callq	0x18000308d <numba_list_iter_next+0x2fd>
1800013d2:     	movq	%rax, %r13
1800013d5:     	movq	%rbp, %rcx
1800013d8:     	callq	0x180003093 <numba_list_iter_next+0x303>
1800013dd:     	callq	0x180003099 <numba_list_iter_next+0x309>
1800013e2:     	testq	%rax, %rax
1800013e5:     	jne	0x180001542 <.text+0x542>
1800013eb:     	movq	0x70(%rsp), %rcx
1800013f0:     	callq	0x180003087 <numba_list_iter_next+0x2f7>
1800013f5:     	testq	%rax, %rax
1800013f8:     	je	0x180001532 <.text+0x532>
1800013fe:     	movq	%rax, %rsi
180001401:     	movq	%rax, %rcx
180001404:     	callq	0x18000308d <numba_list_iter_next+0x2fd>
180001409:     	movq	%rax, %rbp
18000140c:     	movq	%rsi, %rcx
18000140f:     	callq	0x180003093 <numba_list_iter_next+0x303>
180001414:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001419:     	testq	%rax, %rax
18000141c:     	jne	0x180001542 <.text+0x542>
180001422:     	movq	$0x0, 0x60(%rsp)
18000142b:     	movq	%rbp, 0x20(%rsp)
180001430:     	leaq	0x60(%rsp), %rcx
180001435:     	movq	%r15, %rdx
180001438:     	movq	%r12, %r8
18000143b:     	movq	%r13, %r9
18000143e:     	callq	0x180001090 <.text+0x90>
180001443:     	movq	0x60(%rsp), %rsi
180001448:     	movq	%rdi, %rcx
18000144b:     	callq	0x180001060 <.text+0x60>
180001450:     	movq	%rbx, %rcx
180001453:     	callq	0x180001060 <.text+0x60>
180001458:     	movq	%r14, %rcx
18000145b:     	callq	0x180001060 <.text+0x60>
180001460:     	movq	0x68(%rsp), %rcx
180001465:     	callq	0x180001060 <.text+0x60>
18000146a:     	movq	%rsi, %rcx
18000146d:     	callq	0x18000309f <numba_list_iter_next+0x30f>
180001472:     	nop
180001473:     	addq	$0x1a8, %rsp            # imm = 0x1A8
18000147a:     	popq	%rbx
18000147b:     	popq	%rbp
18000147c:     	popq	%rdi
18000147d:     	popq	%rsi
18000147e:     	popq	%r12
180001480:     	popq	%r13
180001482:     	popq	%r14
180001484:     	popq	%r15
180001486:     	retq
180001487:     	movq	0x2daa(%rip), %rcx      # 0x180004238
18000148e:     	leaq	0x2f5b(%rip), %rdx      # 0x1800043f0
180001495:     	callq	0x1800030a5 <numba_list_iter_next+0x315>
18000149a:     	jmp	0x180001564 <.text+0x564>
18000149f:     	movq	0x2d82(%rip), %rcx      # 0x180004228
1800014a6:     	leaq	0x3043(%rip), %rdx      # 0x1800044f0
1800014ad:     	callq	0x1800030a5 <numba_list_iter_next+0x315>
1800014b2:     	jmp	0x180001564 <.text+0x564>
1800014b7:     	movq	0x2d6a(%rip), %rcx      # 0x180004228
1800014be:     	leaq	0x302b(%rip), %rdx      # 0x1800044f0
1800014c5:     	callq	0x1800030a5 <numba_list_iter_next+0x315>
1800014ca:     	jmp	0x18000155c <.text+0x55c>
1800014cf:     	movq	0x2d52(%rip), %rcx      # 0x180004228
1800014d6:     	leaq	0x3013(%rip), %rdx      # 0x1800044f0
1800014dd:     	callq	0x1800030a5 <numba_list_iter_next+0x315>
1800014e2:     	jmp	0x180001554 <.text+0x554>
1800014e4:     	movq	0x2d3d(%rip), %rcx      # 0x180004228
1800014eb:     	leaq	0x2ffe(%rip), %rdx      # 0x1800044f0
1800014f2:     	callq	0x1800030a5 <numba_list_iter_next+0x315>
1800014f7:     	jmp	0x18000154c <.text+0x54c>
1800014f9:     	xorl	%r15d, %r15d
1800014fc:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001501:     	testq	%rax, %rax
180001504:     	je	0x18000137a <.text+0x37a>
18000150a:     	jmp	0x180001542 <.text+0x542>
18000150c:     	xorl	%r12d, %r12d
18000150f:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001514:     	testq	%rax, %rax
180001517:     	je	0x1800013b4 <.text+0x3b4>
18000151d:     	jmp	0x180001542 <.text+0x542>
18000151f:     	xorl	%r13d, %r13d
180001522:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001527:     	testq	%rax, %rax
18000152a:     	je	0x1800013eb <.text+0x3eb>
180001530:     	jmp	0x180001542 <.text+0x542>
180001532:     	xorl	%ebp, %ebp
180001534:     	callq	0x180003099 <numba_list_iter_next+0x309>
180001539:     	testq	%rax, %rax
18000153c:     	je	0x180001422 <.text+0x422>
180001542:     	movq	0x68(%rsp), %rcx
180001547:     	callq	0x180001060 <.text+0x60>
18000154c:     	movq	%r14, %rcx
18000154f:     	callq	0x180001060 <.text+0x60>
180001554:     	movq	%rbx, %rcx
180001557:     	callq	0x180001060 <.text+0x60>
18000155c:     	movq	%rdi, %rcx
18000155f:     	callq	0x180001060 <.text+0x60>
180001564:     	xorl	%eax, %eax
180001566:     	jmp	0x180001473 <.text+0x473>
18000156b:     	nopl	(%rax,%rax)
180001570:     	subq	$0x38, %rsp
180001574:     	movq	0x120(%rsp), %rdx
18000157c:     	movq	0x128(%rsp), %r8
180001584:     	movq	0x130(%rsp), %r9
18000158c:     	movq	0x138(%rsp), %rax
180001594:     	movq	$0x0, 0x30(%rsp)
18000159d:     	movq	%rax, 0x20(%rsp)
1800015a2:     	leaq	0x30(%rsp), %rcx
1800015a7:     	callq	0x180001090 <.text+0x90>
1800015ac:     	movq	0x30(%rsp), %rax
1800015b1:     	addq	$0x38, %rsp
1800015b5:     	retq
1800015b6:     	nopw	%cs:(%rax,%rax)

00000001800015c0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed>:
1800015c0:     	pushq	%rsi
1800015c1:     	subq	$0x20, %rsp
1800015c5:     	leaq	0x8a74(%rip), %rcx      # 0x18000a040
1800015cc:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800015d1:     	callq	0x1800030ab <numba_list_iter_next+0x31b>
1800015d6:     	testq	%rax, %rax
1800015d9:     	je	0x18000160b <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x4b>
1800015db:     	leaq	0x8a1e(%rip), %rdx      # 0x18000a000
1800015e2:     	leaq	0x2fb7(%rip), %r8       # 0x1800045a0
1800015e9:     	leaq	0x2fd8(%rip), %r9       # 0x1800045c8
1800015f0:     	movq	%rax, %rcx
1800015f3:     	movq	%rax, %rsi
1800015f6:     	callq	0x180001fd0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xa10>
1800015fb:     	movl	%eax, %ecx
1800015fd:     	xorl	%eax, %eax
1800015ff:     	testl	%ecx, %ecx
180001601:     	cmoveq	%rsi, %rax
180001605:     	addq	$0x20, %rsp
180001609:     	popq	%rsi
18000160a:     	retq
18000160b:     	xorl	%eax, %eax
18000160d:     	addq	$0x20, %rsp
180001611:     	popq	%rsi
180001612:     	retq
180001613:     	int3
180001614:     	int3
180001615:     	int3
180001616:     	int3
180001617:     	int3
180001618:     	int3
180001619:     	int3
18000161a:     	int3
18000161b:     	int3
18000161c:     	int3
18000161d:     	int3
18000161e:     	int3
18000161f:     	int3
180001620:     	movq	%rbx, 0x8(%rsp)
180001625:     	movq	%rsi, 0x10(%rsp)
18000162a:     	pushq	%rdi
18000162b:     	subq	$0x20, %rsp
18000162f:     	movq	%rcx, %rbx
180001632:     	movq	%r8, %rdi
180001635:     	movq	0x10(%rcx), %rcx
180001639:     	movq	%rdx, %rsi
18000163c:     	testq	%rcx, %rcx
18000163f:     	je	0x18000164a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x8a>
180001641:     	movq	%r8, %rdx
180001644:     	callq	*%rsi
180001646:     	testl	%eax, %eax
180001648:     	jne	0x18000166d <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xad>
18000164a:     	movq	0x18(%rbx), %rcx
18000164e:     	testq	%rcx, %rcx
180001651:     	je	0x18000166b <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xab>
180001653:     	movq	%rdi, %rdx
180001656:     	movq	%rsi, %rax
180001659:     	movq	0x30(%rsp), %rbx
18000165e:     	movq	0x38(%rsp), %rsi
180001663:     	addq	$0x20, %rsp
180001667:     	popq	%rdi
180001668:     	jmpq	*%rax
18000166b:     	xorl	%eax, %eax
18000166d:     	movq	0x30(%rsp), %rbx
180001672:     	movq	0x38(%rsp), %rsi
180001677:     	addq	$0x20, %rsp
18000167b:     	popq	%rdi
18000167c:     	retq
18000167d:     	int3
18000167e:     	int3
18000167f:     	int3
180001680:     	pushq	%rbx
180001682:     	subq	$0x20, %rsp
180001686:     	movq	%rcx, %rbx
180001689:     	movq	0x10(%rcx), %rcx
18000168d:     	testq	%rcx, %rcx
180001690:     	je	0x1800016ad <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xed>
180001692:     	movq	$0x0, 0x10(%rbx)
18000169a:     	movl	(%rcx), %eax
18000169c:     	testl	%eax, %eax
18000169e:     	js	0x1800016ad <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xed>
1800016a0:     	subl	$0x1, %eax
1800016a3:     	movl	%eax, (%rcx)
1800016a5:     	jne	0x1800016ad <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xed>
1800016a7:     	callq	*0x2b03(%rip)           # 0x1800041b0
1800016ad:     	movq	0x18(%rbx), %rcx
1800016b1:     	testq	%rcx, %rcx
1800016b4:     	je	0x1800016d1 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x111>
1800016b6:     	movq	$0x0, 0x18(%rbx)
1800016be:     	movl	(%rcx), %eax
1800016c0:     	testl	%eax, %eax
1800016c2:     	js	0x1800016d1 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x111>
1800016c4:     	subl	$0x1, %eax
1800016c7:     	movl	%eax, (%rcx)
1800016c9:     	jne	0x1800016d1 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x111>
1800016cb:     	callq	*0x2adf(%rip)           # 0x1800041b0
1800016d1:     	xorl	%eax, %eax
1800016d3:     	addq	$0x20, %rsp
1800016d7:     	popq	%rbx
1800016d8:     	retq
1800016d9:     	int3
1800016da:     	int3
1800016db:     	int3
1800016dc:     	int3
1800016dd:     	int3
1800016de:     	int3
1800016df:     	int3
1800016e0:     	pushq	%rbx
1800016e2:     	subq	$0x20, %rsp
1800016e6:     	movq	%rcx, %rbx
1800016e9:     	callq	*0x2b01(%rip)           # 0x1800041f0
1800016ef:     	movq	0x10(%rbx), %rcx
1800016f3:     	testq	%rcx, %rcx
1800016f6:     	je	0x180001713 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x153>
1800016f8:     	movq	$0x0, 0x10(%rbx)
180001700:     	movl	(%rcx), %eax
180001702:     	testl	%eax, %eax
180001704:     	js	0x180001713 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x153>
180001706:     	subl	$0x1, %eax
180001709:     	movl	%eax, (%rcx)
18000170b:     	jne	0x180001713 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x153>
18000170d:     	callq	*0x2a9d(%rip)           # 0x1800041b0
180001713:     	movq	0x18(%rbx), %rcx
180001717:     	testq	%rcx, %rcx
18000171a:     	je	0x180001737 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x177>
18000171c:     	movq	$0x0, 0x18(%rbx)
180001724:     	movl	(%rcx), %eax
180001726:     	testl	%eax, %eax
180001728:     	js	0x180001737 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x177>
18000172a:     	subl	$0x1, %eax
18000172d:     	movl	%eax, (%rcx)
18000172f:     	jne	0x180001737 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x177>
180001731:     	callq	*0x2a79(%rip)           # 0x1800041b0
180001737:     	movq	0x8(%rbx), %rax
18000173b:     	movq	%rbx, %rcx
18000173e:     	addq	$0x20, %rsp
180001742:     	popq	%rbx
180001743:     	jmpq	*0x140(%rax)
18000174a:     	int3
18000174b:     	int3
18000174c:     	int3
18000174d:     	int3
18000174e:     	int3
18000174f:     	int3
180001750:     	pushq	%rbx
180001752:     	subq	$0x30, %rsp
180001756:     	movq	%r8, %r10
180001759:     	leaq	0x58(%rsp), %rax
18000175e:     	movq	%rax, 0x28(%rsp)
180001763:     	leaq	0x9226(%rip), %r9       # 0x18000a990
18000176a:     	movq	0x2a4f(%rip), %rax      # 0x1800041c0
180001771:     	leaq	0x3190(%rip), %r8       # 0x180004908
180001778:     	movq	%rdx, %r11
18000177b:     	movq	%rax, 0x20(%rsp)
180001780:     	movq	%rcx, %rbx
180001783:     	movq	%r10, %rdx
180001786:     	movq	%r11, %rcx
180001789:     	callq	*0x2951(%rip)           # 0x1800040e0
18000178f:     	testl	%eax, %eax
180001791:     	je	0x1800017ec <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x22c>
180001793:     	xorl	%r8d, %r8d
180001796:     	xorl	%edx, %edx
180001798:     	movq	%rbx, %rcx
18000179b:     	callq	*0x2a6f(%rip)           # 0x180004210
1800017a1:     	movq	%rax, %rbx
1800017a4:     	testq	%rax, %rax
1800017a7:     	je	0x1800017ec <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x22c>
1800017a9:     	movq	0x58(%rsp), %rax
1800017ae:     	movl	(%rax), %ecx
1800017b0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800017b6:     	jae	0x1800017c1 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x201>
1800017b8:     	incl	%ecx
1800017ba:     	movl	%ecx, (%rax)
1800017bc:     	movq	0x58(%rsp), %rax
1800017c1:     	xorl	%ecx, %ecx
1800017c3:     	movq	%rax, 0x10(%rbx)
1800017c7:     	callq	*0x29a3(%rip)           # 0x180004170
1800017cd:     	movq	%rax, 0x18(%rbx)
1800017d1:     	testq	%rax, %rax
1800017d4:     	jne	0x1800017f4 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x234>
1800017d6:     	movl	(%rbx), %eax
1800017d8:     	testl	%eax, %eax
1800017da:     	js	0x1800017ec <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x22c>
1800017dc:     	subl	$0x1, %eax
1800017df:     	movl	%eax, (%rbx)
1800017e1:     	jne	0x1800017ec <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x22c>
1800017e3:     	movq	%rbx, %rcx
1800017e6:     	callq	*0x29c4(%rip)           # 0x1800041b0
1800017ec:     	xorl	%eax, %eax
1800017ee:     	addq	$0x30, %rsp
1800017f2:     	popq	%rbx
1800017f3:     	retq
1800017f4:     	movq	%rbx, %rax
1800017f7:     	addq	$0x30, %rsp
1800017fb:     	popq	%rbx
1800017fc:     	retq
1800017fd:     	int3
1800017fe:     	int3
1800017ff:     	int3
180001800:     	movq	%rbx, 0x8(%rsp)
180001805:     	movq	%rsi, 0x10(%rsp)
18000180a:     	pushq	%rdi
18000180b:     	subq	$0x20, %rsp
18000180f:     	movq	%rcx, %rbx
180001812:     	movq	%r8, %rdi
180001815:     	movq	0x18(%rcx), %rcx
180001819:     	movq	%rdx, %rsi
18000181c:     	testq	%rcx, %rcx
18000181f:     	je	0x18000182a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x26a>
180001821:     	movq	%r8, %rdx
180001824:     	callq	*%rsi
180001826:     	testl	%eax, %eax
180001828:     	jne	0x18000184d <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x28d>
18000182a:     	movq	0x40(%rbx), %rcx
18000182e:     	testq	%rcx, %rcx
180001831:     	je	0x18000184b <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x28b>
180001833:     	movq	%rdi, %rdx
180001836:     	movq	%rsi, %rax
180001839:     	movq	0x30(%rsp), %rbx
18000183e:     	movq	0x38(%rsp), %rsi
180001843:     	addq	$0x20, %rsp
180001847:     	popq	%rdi
180001848:     	jmpq	*%rax
18000184b:     	xorl	%eax, %eax
18000184d:     	movq	0x30(%rsp), %rbx
180001852:     	movq	0x38(%rsp), %rsi
180001857:     	addq	$0x20, %rsp
18000185b:     	popq	%rdi
18000185c:     	retq
18000185d:     	int3
18000185e:     	int3
18000185f:     	int3
180001860:     	pushq	%rbx
180001862:     	subq	$0x20, %rsp
180001866:     	movq	%rcx, %rbx
180001869:     	callq	*0x2981(%rip)           # 0x1800041f0
18000186f:     	cmpq	$0x0, 0x48(%rbx)
180001874:     	je	0x18000187f <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x2bf>
180001876:     	movq	%rbx, %rcx
180001879:     	callq	*0x2901(%rip)           # 0x180004180
18000187f:     	movq	0x20(%rbx), %rcx
180001883:     	callq	*0x2917(%rip)           # 0x1800041a0
180001889:     	movq	0x38(%rbx), %rcx
18000188d:     	callq	*0x290d(%rip)           # 0x1800041a0
180001893:     	movq	0x18(%rbx), %rcx
180001897:     	testq	%rcx, %rcx
18000189a:     	je	0x1800018af <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x2ef>
18000189c:     	movl	(%rcx), %eax
18000189e:     	testl	%eax, %eax
1800018a0:     	js	0x1800018af <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x2ef>
1800018a2:     	subl	$0x1, %eax
1800018a5:     	movl	%eax, (%rcx)
1800018a7:     	jne	0x1800018af <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x2ef>
1800018a9:     	callq	*0x2901(%rip)           # 0x1800041b0
1800018af:     	movq	0x40(%rbx), %rcx
1800018b3:     	testq	%rcx, %rcx
1800018b6:     	je	0x1800018cb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x30b>
1800018b8:     	movl	(%rcx), %eax
1800018ba:     	testl	%eax, %eax
1800018bc:     	js	0x1800018cb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x30b>
1800018be:     	subl	$0x1, %eax
1800018c1:     	movl	%eax, (%rcx)
1800018c3:     	jne	0x1800018cb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x30b>
1800018c5:     	callq	*0x28e5(%rip)           # 0x1800041b0
1800018cb:     	movq	0x8(%rbx), %rax
1800018cf:     	movq	%rbx, %rcx
1800018d2:     	addq	$0x20, %rsp
1800018d6:     	popq	%rbx
1800018d7:     	jmpq	*0x140(%rax)
1800018de:     	int3
1800018df:     	int3
1800018e0:     	pushq	%rbx
1800018e2:     	subq	$0x20, %rsp
1800018e6:     	callq	*0x288c(%rip)           # 0x180004178
1800018ec:     	movq	%rax, %rbx
1800018ef:     	testq	%rax, %rax
1800018f2:     	jne	0x1800018fa <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x33a>
1800018f4:     	addq	$0x20, %rsp
1800018f8:     	popq	%rbx
1800018f9:     	retq
1800018fa:     	movq	%rbx, %rcx
1800018fd:     	movq	%rdi, 0x30(%rsp)
180001902:     	callq	0x180003c15 <numba_list_iter_next+0xe85>
180001907:     	leaq	0x1(%rax), %rcx
18000190b:     	callq	*0x2907(%rip)           # 0x180004218
180001911:     	movq	%rax, %rdi
180001914:     	testq	%rax, %rax
180001917:     	jne	0x18000192c <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x36c>
180001919:     	callq	*0x2819(%rip)           # 0x180004138
18000191f:     	movq	0x30(%rsp), %rdi
180001924:     	xorl	%eax, %eax
180001926:     	addq	$0x20, %rsp
18000192a:     	popq	%rbx
18000192b:     	retq
18000192c:     	movq	%rbx, %rdx
18000192f:     	movq	%rdi, %rcx
180001932:     	callq	0x180003c0f <numba_list_iter_next+0xe7f>
180001937:     	movq	%rdi, %rax
18000193a:     	movq	0x30(%rsp), %rdi
18000193f:     	addq	$0x20, %rsp
180001943:     	popq	%rbx
180001944:     	retq
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
180001950:     	movq	0x18(%rcx), %rcx
180001954:     	movq	%rdx, %rax
180001957:     	testq	%rcx, %rcx
18000195a:     	je	0x180001962 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x3a2>
18000195c:     	movq	%r8, %rdx
18000195f:     	jmpq	*%rax
180001962:     	xorl	%eax, %eax
180001964:     	retq
180001965:     	int3
180001966:     	int3
180001967:     	int3
180001968:     	int3
180001969:     	int3
18000196a:     	int3
18000196b:     	int3
18000196c:     	int3
18000196d:     	int3
18000196e:     	int3
18000196f:     	int3
180001970:     	movq	%rbx, 0x8(%rsp)
180001975:     	pushq	%rdi
180001976:     	subq	$0x20, %rsp
18000197a:     	movq	0x28(%rcx), %rax
18000197e:     	xorl	%edi, %edi
180001980:     	movq	%rcx, %rbx
180001983:     	testq	%rax, %rax
180001986:     	je	0x180001992 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x3d2>
180001988:     	addq	$0x38, %rcx
18000198c:     	callq	*%rax
18000198e:     	movq	%rdi, 0x28(%rbx)
180001992:     	movq	0x18(%rbx), %rcx
180001996:     	testq	%rcx, %rcx
180001999:     	je	0x1800019b2 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x3f2>
18000199b:     	movq	%rdi, 0x18(%rbx)
18000199f:     	movl	(%rcx), %eax
1800019a1:     	testl	%eax, %eax
1800019a3:     	js	0x1800019b2 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x3f2>
1800019a5:     	subl	$0x1, %eax
1800019a8:     	movl	%eax, (%rcx)
1800019aa:     	jne	0x1800019b2 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x3f2>
1800019ac:     	callq	*0x27fe(%rip)           # 0x1800041b0
1800019b2:     	movq	%rdi, 0x20(%rbx)
1800019b6:     	xorl	%eax, %eax
1800019b8:     	movq	0x30(%rsp), %rbx
1800019bd:     	addq	$0x20, %rsp
1800019c1:     	popq	%rdi
1800019c2:     	retq
1800019c3:     	int3
1800019c4:     	int3
1800019c5:     	int3
1800019c6:     	int3
1800019c7:     	int3
1800019c8:     	int3
1800019c9:     	int3
1800019ca:     	int3
1800019cb:     	int3
1800019cc:     	int3
1800019cd:     	int3
1800019ce:     	int3
1800019cf:     	int3
1800019d0:     	pushq	%rbx
1800019d2:     	subq	$0x20, %rsp
1800019d6:     	movq	%rcx, %rbx
1800019d9:     	callq	*0x2811(%rip)           # 0x1800041f0
1800019df:     	cmpq	$0x0, 0x30(%rbx)
1800019e4:     	je	0x1800019ef <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x42f>
1800019e6:     	movq	%rbx, %rcx
1800019e9:     	callq	*0x2791(%rip)           # 0x180004180
1800019ef:     	callq	*0x273b(%rip)           # 0x180004130
1800019f5:     	testl	%eax, %eax
1800019f7:     	jne	0x180001a08 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x448>
1800019f9:     	movq	0x28(%rbx), %rax
1800019fd:     	testq	%rax, %rax
180001a00:     	je	0x180001a08 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x448>
180001a02:     	leaq	0x38(%rbx), %rcx
180001a06:     	callq	*%rax
180001a08:     	movq	0x18(%rbx), %rcx
180001a0c:     	testq	%rcx, %rcx
180001a0f:     	je	0x180001a24 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x464>
180001a11:     	movl	(%rcx), %eax
180001a13:     	testl	%eax, %eax
180001a15:     	js	0x180001a24 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x464>
180001a17:     	subl	$0x1, %eax
180001a1a:     	movl	%eax, (%rcx)
180001a1c:     	jne	0x180001a24 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x464>
180001a1e:     	callq	*0x278c(%rip)           # 0x1800041b0
180001a24:     	movq	0x8(%rbx), %rax
180001a28:     	movq	%rbx, %rcx
180001a2b:     	addq	$0x20, %rsp
180001a2f:     	popq	%rbx
180001a30:     	jmpq	*0x140(%rax)
180001a37:     	int3
180001a38:     	int3
180001a39:     	int3
180001a3a:     	int3
180001a3b:     	int3
180001a3c:     	int3
180001a3d:     	int3
180001a3e:     	int3
180001a3f:     	int3
180001a40:     	pushq	%rdi
180001a42:     	subq	$0x20, %rsp
180001a46:     	cmpq	$0x0, 0x20(%rcx)
180001a4b:     	movq	%rcx, %rdi
180001a4e:     	jne	0x180001a6f <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x4af>
180001a50:     	movq	0x27e1(%rip), %rcx      # 0x180004238
180001a57:     	leaq	0x2efa(%rip), %rdx      # 0x180004958
180001a5e:     	movq	(%rcx), %rcx
180001a61:     	callq	*0x27c9(%rip)           # 0x180004230
180001a67:     	xorl	%eax, %eax
180001a69:     	addq	$0x20, %rsp
180001a6d:     	popq	%rdi
180001a6e:     	retq
180001a6f:     	movq	%rdi, %rdx
180001a72:     	movq	%rbx, 0x30(%rsp)
180001a77:     	movl	$0x1, %ecx
180001a7c:     	callq	*0x266e(%rip)           # 0x1800040f0
180001a82:     	movq	%rax, %rbx
180001a85:     	testq	%rax, %rax
180001a88:     	jne	0x180001a95 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x4d5>
180001a8a:     	movq	0x30(%rsp), %rbx
180001a8f:     	addq	$0x20, %rsp
180001a93:     	popq	%rdi
180001a94:     	retq
180001a95:     	xorl	%r8d, %r8d
180001a98:     	movq	%rbx, %rdx
180001a9b:     	movq	%rdi, %rcx
180001a9e:     	callq	*0x20(%rdi)
180001aa1:     	movl	(%rbx), %ecx
180001aa3:     	movq	%rax, %rdi
180001aa6:     	testl	%ecx, %ecx
180001aa8:     	js	0x180001aba <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x4fa>
180001aaa:     	subl	$0x1, %ecx
180001aad:     	movl	%ecx, (%rbx)
180001aaf:     	jne	0x180001aba <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x4fa>
180001ab1:     	movq	%rbx, %rcx
180001ab4:     	callq	*0x26f6(%rip)           # 0x1800041b0
180001aba:     	movq	0x30(%rsp), %rbx
180001abf:     	movq	%rdi, %rax
180001ac2:     	addq	$0x20, %rsp
180001ac6:     	popq	%rdi
180001ac7:     	retq
180001ac8:     	int3
180001ac9:     	int3
180001aca:     	int3
180001acb:     	int3
180001acc:     	int3
180001acd:     	int3
180001ace:     	int3
180001acf:     	int3
180001ad0:     	movq	%rbx, 0x8(%rsp)
180001ad5:     	pushq	%rdi
180001ad6:     	subq	$0x20, %rsp
180001ada:     	movq	%r8, %rbx
180001add:     	callq	*0x2635(%rip)           # 0x180004118
180001ae3:     	movl	(%rbx), %ecx
180001ae5:     	movl	%eax, %edi
180001ae7:     	testl	%ecx, %ecx
180001ae9:     	js	0x180001afb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x53b>
180001aeb:     	subl	$0x1, %ecx
180001aee:     	movl	%ecx, (%rbx)
180001af0:     	jne	0x180001afb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x53b>
180001af2:     	movq	%rbx, %rcx
180001af5:     	callq	*0x26b5(%rip)           # 0x1800041b0
180001afb:     	movl	%edi, %ecx
180001afd:     	movq	0x30(%rsp), %rbx
180001b02:     	addq	$0x20, %rsp
180001b06:     	popq	%rdi
180001b07:     	jmpq	*0x26da(%rip)           # 0x1800041e8
180001b0e:     	int3
180001b0f:     	int3
180001b10:     	movq	%rbx, 0x8(%rsp)
180001b15:     	pushq	%rdi
180001b16:     	subq	$0x20, %rsp
180001b1a:     	movl	(%rdx), %eax
180001b1c:     	movq	%rdx, %rbx
180001b1f:     	movq	%rcx, %rdi
180001b22:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001b27:     	jae	0x180001b2d <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x56d>
180001b29:     	incl	%eax
180001b2b:     	movl	%eax, (%rdx)
180001b2d:     	movl	$0x30, %ecx
180001b32:     	callq	*0x90f0(%rip)           # 0x18000ac28
180001b38:     	cmpb	$0x0, 0x90c1(%rip)      # 0x18000ac00
180001b3f:     	je	0x180001b49 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x589>
180001b41:     	lock
180001b42:     	incq	0x90bf(%rip)            # 0x18000ac08
180001b49:     	testq	%rax, %rax
180001b4c:     	je	0x180001b83 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x5c3>
180001b4e:     	movl	$0x1, %ecx
180001b53:     	leaq	-0x8a(%rip), %rdx       # 0x180001ad0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x510>
180001b5a:     	xchgq	%rcx, (%rax)
180001b5d:     	xorl	%ecx, %ecx
180001b5f:     	movq	%rdx, 0x8(%rax)
180001b63:     	movq	%rcx, 0x20(%rax)
180001b67:     	movq	%rcx, 0x28(%rax)
180001b6b:     	movq	%rbx, 0x10(%rax)
180001b6f:     	movq	%rdi, 0x18(%rax)
180001b73:     	cmpb	%cl, 0x9087(%rip)       # 0x18000ac00
180001b79:     	je	0x180001b83 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x5c3>
180001b7b:     	lock
180001b7c:     	incq	0x9095(%rip)            # 0x18000ac18
180001b83:     	movq	0x30(%rsp), %rbx
180001b88:     	addq	$0x20, %rsp
180001b8c:     	popq	%rdi
180001b8d:     	retq
180001b8e:     	int3
180001b8f:     	int3
180001b90:     	movq	%rbx, 0x8(%rsp)
180001b95:     	pushq	%rdi
180001b96:     	subq	$0x30, %rsp
180001b9a:     	movq	%rcx, %rdi
180001b9d:     	leaq	0x8ddc(%rip), %r9       # 0x18000a980
180001ba4:     	movq	%r8, %rax
180001ba7:     	leaq	0x58(%rsp), %rcx
180001bac:     	movq	%rdx, %r10
180001baf:     	movq	%rcx, 0x20(%rsp)
180001bb4:     	movq	%r10, %rcx
180001bb7:     	leaq	0x2de2(%rip), %r8       # 0x1800049a0
180001bbe:     	movq	%rax, %rdx
180001bc1:     	callq	*0x2519(%rip)           # 0x1800040e0
180001bc7:     	testl	%eax, %eax
180001bc9:     	je	0x180001bf3 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x633>
180001bcb:     	movq	0x58(%rsp), %rcx
180001bd0:     	callq	*0x2552(%rip)           # 0x180004128
180001bd6:     	movq	%rax, %rbx
180001bd9:     	callq	*0x2669(%rip)           # 0x180004248
180001bdf:     	testq	%rax, %rax
180001be2:     	jne	0x180001bf3 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x633>
180001be4:     	movq	%rbx, 0x10(%rdi)
180001be8:     	movq	0x40(%rsp), %rbx
180001bed:     	addq	$0x30, %rsp
180001bf1:     	popq	%rdi
180001bf2:     	retq
180001bf3:     	movq	0x40(%rsp), %rbx
180001bf8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001bfd:     	addq	$0x30, %rsp
180001c01:     	popq	%rdi
180001c02:     	retq
180001c03:     	int3
180001c04:     	int3
180001c05:     	int3
180001c06:     	int3
180001c07:     	int3
180001c08:     	int3
180001c09:     	int3
180001c0a:     	int3
180001c0b:     	int3
180001c0c:     	int3
180001c0d:     	int3
180001c0e:     	int3
180001c0f:     	int3
180001c10:     	subq	$0x38, %rsp
180001c14:     	movl	%r8d, %eax
180001c17:     	movq	%rdx, %r10
180001c1a:     	movq	0x10(%rcx), %r8
180001c1e:     	movq	%rcx, %rdx
180001c21:     	movl	%eax, 0x28(%rsp)
180001c25:     	movq	%r10, %rcx
180001c28:     	movl	$0x0, 0x20(%rsp)
180001c30:     	movq	0x20(%r8), %r9
180001c34:     	movq	0x18(%r8), %r8
180001c38:     	callq	*0x259a(%rip)           # 0x1800041d8
180001c3e:     	addq	$0x38, %rsp
180001c42:     	retq
180001c43:     	int3
180001c44:     	int3
180001c45:     	int3
180001c46:     	int3
180001c47:     	int3
180001c48:     	int3
180001c49:     	int3
180001c4a:     	int3
180001c4b:     	int3
180001c4c:     	int3
180001c4d:     	int3
180001c4e:     	int3
180001c4f:     	int3
180001c50:     	movq	0x10(%rcx), %rax
180001c54:     	lock
180001c55:     	incq	(%rax)
180001c58:     	movq	0x2581(%rip), %rax      # 0x1800041e0
180001c5f:     	retq
180001c60:     	subq	$0x28, %rsp
180001c64:     	movq	0x10(%rcx), %rcx
180001c68:     	callq	0x180002f60 <numba_list_iter_next+0x1d0>
180001c6d:     	movq	0x256c(%rip), %rax      # 0x1800041e0
180001c74:     	addq	$0x28, %rsp
180001c78:     	retq
180001c79:     	int3
180001c7a:     	int3
180001c7b:     	int3
180001c7c:     	int3
180001c7d:     	int3
180001c7e:     	int3
180001c7f:     	int3
180001c80:     	movq	0x10(%rcx), %rcx
180001c84:     	movq	0x18(%rcx), %rcx
180001c88:     	jmpq	*0x24c1(%rip)           # 0x180004150
180001c8f:     	int3
180001c90:     	subq	$0x28, %rsp
180001c94:     	movq	0x10(%rcx), %rax
180001c98:     	testq	%rax, %rax
180001c9b:     	je	0x180001cb9 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x6f9>
180001c9d:     	cmpq	$0x0, 0x18(%rax)
180001ca2:     	je	0x180001cb9 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x6f9>
180001ca4:     	movq	(%rax), %rcx
180001ca7:     	nop
180001ca8:     	cmpq	$-0x1, %rcx
180001cac:     	je	0x180001cb9 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x6f9>
180001cae:     	addq	$0x28, %rsp
180001cb2:     	jmpq	*0x244f(%rip)           # 0x180004108
180001cb9:     	movq	0x2510(%rip), %rcx      # 0x1800041d0
180001cc0:     	leaq	0x2ce1(%rip), %rdx      # 0x1800049a8
180001cc7:     	movq	(%rcx), %rcx
180001cca:     	callq	*0x2560(%rip)           # 0x180004230
180001cd0:     	xorl	%eax, %eax
180001cd2:     	addq	$0x28, %rsp
180001cd6:     	retq
180001cd7:     	int3
180001cd8:     	int3
180001cd9:     	int3
180001cda:     	int3
180001cdb:     	int3
180001cdc:     	int3
180001cdd:     	int3
180001cde:     	int3
180001cdf:     	int3
180001ce0:     	movq	0x10(%rcx), %rcx
180001ce4:     	movq	0x28(%rcx), %rcx
180001ce8:     	jmpq	*0x2461(%rip)           # 0x180004150
180001cef:     	int3
180001cf0:     	movq	0x10(%rcx), %rax
180001cf4:     	movq	0x10(%rax), %rax
180001cf8:     	testq	%rax, %rax
180001cfb:     	je	0x180001d0c <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x74c>
180001cfd:     	movl	(%rax), %ecx
180001cff:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001d05:     	jae	0x180001d2a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x76a>
180001d07:     	incl	%ecx
180001d09:     	movl	%ecx, (%rax)
180001d0b:     	retq
180001d0c:     	movq	0x24cd(%rip), %rcx      # 0x1800041e0
180001d13:     	movl	(%rcx), %eax
180001d15:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001d1a:     	jae	0x180001d27 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x767>
180001d1c:     	incl	%eax
180001d1e:     	movl	%eax, (%rcx)
180001d20:     	movq	0x24b9(%rip), %rcx      # 0x1800041e0
180001d27:     	movq	%rcx, %rax
180001d2a:     	retq
180001d2b:     	int3
180001d2c:     	int3
180001d2d:     	int3
180001d2e:     	int3
180001d2f:     	int3
180001d30:     	pushq	%rbx
180001d32:     	subq	$0x20, %rsp
180001d36:     	movq	%rcx, %rbx
180001d39:     	movq	0x10(%rcx), %rcx
180001d3d:     	callq	0x180002f60 <numba_list_iter_next+0x1d0>
180001d42:     	movq	0x8(%rbx), %rax
180001d46:     	movq	%rbx, %rcx
180001d49:     	addq	$0x20, %rsp
180001d4d:     	popq	%rbx
180001d4e:     	jmpq	*0x140(%rax)
180001d55:     	int3
180001d56:     	int3
180001d57:     	int3
180001d58:     	int3
180001d59:     	int3
180001d5a:     	int3
180001d5b:     	int3
180001d5c:     	int3
180001d5d:     	int3
180001d5e:     	int3
180001d5f:     	int3
180001d60:     	movq	%rdi, 0x18(%rsp)
180001d65:     	pushq	%r14
180001d67:     	subq	$0x20, %rsp
180001d6b:     	movq	0x8ece(%rip), %rax      # 0x18000ac40
180001d72:     	movq	%rdx, %r14
180001d75:     	movq	%rcx, %rdi
180001d78:     	movq	0x8(%rcx), %rcx
180001d7c:     	movq	0x10(%rax), %rdx
180001d80:     	cmpq	%rdx, %rcx
180001d83:     	je	0x180001da0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7e0>
180001d85:     	callq	*0x242d(%rip)           # 0x1800041b8
180001d8b:     	testl	%eax, %eax
180001d8d:     	jne	0x180001da0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x7e0>
180001d8f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001d94:     	movq	0x40(%rsp), %rdi
180001d99:     	addq	$0x20, %rsp
180001d9d:     	popq	%r14
180001d9f:     	retq
180001da0:     	movq	%rbx, 0x30(%rsp)
180001da5:     	movq	%rdi, %rdx
180001da8:     	movq	0x10(%rdi), %rbx
180001dac:     	movq	%rbx, %rcx
180001daf:     	movq	%rsi, 0x38(%rsp)
180001db4:     	movl	0x18(%rdi), %esi
180001db7:     	callq	0x180001b10 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x550>
180001dbc:     	movq	%rax, (%r14)
180001dbf:     	movq	0x8e7a(%rip), %rax      # 0x18000ac40
180001dc6:     	movq	%rbx, 0x20(%r14)
180001dca:     	movl	0x18(%rdi), %edx
180001dcd:     	movq	0x20(%rdi), %rcx
180001dd1:     	callq	*0x4f0(%rax)
180001dd7:     	cmpl	$0x12, 0x8e6e(%rip)     # 0x18000ac4c
180001dde:     	movq	0x30(%rsp), %rbx
180001de3:     	movq	%rax, 0x10(%r14)
180001de7:     	movq	0x38(%rdi), %rax
180001deb:     	jl	0x180001df3 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x833>
180001ded:     	movq	0x28(%rax), %rax
180001df1:     	jmp	0x180001df7 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x837>
180001df3:     	movslq	0x20(%rax), %rax
180001df7:     	xorl	%r8d, %r8d
180001dfa:     	movq	%rax, 0x18(%r14)
180001dfe:     	movq	%rdi, 0x8(%r14)
180001e02:     	leaq	0x28(%r14), %rax
180001e06:     	testl	%esi, %esi
180001e08:     	jle	0x180001e4b <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x88b>
180001e0a:     	nopw	(%rax,%rax)
180001e10:     	movq	0x20(%rdi), %rcx
180001e14:     	movq	(%rcx,%r8,8), %rdx
180001e18:     	incl	%r8d
180001e1b:     	movq	%rdx, (%rax)
180001e1e:     	addq	$0x8, %rax
180001e22:     	cmpl	%esi, %r8d
180001e25:     	jl	0x180001e10 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x850>
180001e27:     	xorl	%r8d, %r8d
180001e2a:     	nopw	(%rax,%rax)
180001e30:     	movq	0x28(%rdi), %rcx
180001e34:     	leaq	0x8(%rax), %rax
180001e38:     	movslq	%r8d, %rdx
180001e3b:     	incl	%r8d
180001e3e:     	movq	(%rcx,%rdx,8), %rdx
180001e42:     	movq	%rdx, -0x8(%rax)
180001e46:     	cmpl	%esi, %r8d
180001e49:     	jl	0x180001e30 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x870>
180001e4b:     	movq	0x38(%rsp), %rsi
180001e50:     	xorl	%eax, %eax
180001e52:     	movq	0x40(%rsp), %rdi
180001e57:     	addq	$0x20, %rsp
180001e5b:     	popq	%r14
180001e5d:     	retq
180001e5e:     	int3
180001e5f:     	int3
180001e60:     	pushq	%rbx
180001e62:     	pushq	%rbp
180001e63:     	pushq	%rsi
180001e64:     	pushq	%rdi
180001e65:     	subq	$0x28, %rsp
180001e69:     	cmpq	$0x0, 0x8ddf(%rip)      # 0x18000ac50
180001e71:     	movq	%rcx, %rbp
180001e74:     	movslq	0x8(%rdx), %rdi
180001e78:     	movq	(%rdx), %rsi
180001e7b:     	jne	0x180001ed3 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x913>
180001e7d:     	leaq	0x2a64(%rip), %rcx      # 0x1800048e8
180001e84:     	callq	*0x237e(%rip)           # 0x180004208
180001e8a:     	movq	%rax, %rbx
180001e8d:     	testq	%rax, %rax
180001e90:     	je	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001e96:     	leaq	0x2a53(%rip), %rdx      # 0x1800048f0
180001e9d:     	movq	%rax, %rcx
180001ea0:     	callq	*0x22ba(%rip)           # 0x180004160
180001ea6:     	movl	(%rbx), %edx
180001ea8:     	movq	%rax, 0x8da1(%rip)      # 0x18000ac50
180001eaf:     	testl	%edx, %edx
180001eb1:     	js	0x180001eca <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x90a>
180001eb3:     	subl	$0x1, %edx
180001eb6:     	movl	%edx, (%rbx)
180001eb8:     	jne	0x180001eca <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x90a>
180001eba:     	movq	%rbx, %rcx
180001ebd:     	callq	*0x22ed(%rip)           # 0x1800041b0
180001ec3:     	movq	0x8d86(%rip), %rax      # 0x18000ac50
180001eca:     	testq	%rax, %rax
180001ecd:     	je	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001ed3:     	movq	%rdi, %rdx
180001ed6:     	movq	%rsi, %rcx
180001ed9:     	callq	*0x2241(%rip)           # 0x180004120
180001edf:     	movq	%rax, %rdi
180001ee2:     	testq	%rax, %rax
180001ee5:     	je	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001ee7:     	movq	0x8d62(%rip), %rcx      # 0x18000ac50
180001eee:     	xorl	%r8d, %r8d
180001ef1:     	movq	%rax, %rdx
180001ef4:     	callq	*0x228e(%rip)           # 0x180004188
180001efa:     	movl	(%rdi), %ecx
180001efc:     	movq	%rax, %rbx
180001eff:     	testl	%ecx, %ecx
180001f01:     	js	0x180001f13 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x953>
180001f03:     	subl	$0x1, %ecx
180001f06:     	movl	%ecx, (%rdi)
180001f08:     	jne	0x180001f13 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x953>
180001f0a:     	movq	%rdi, %rcx
180001f0d:     	callq	*0x229d(%rip)           # 0x1800041b0
180001f13:     	testq	%rbx, %rbx
180001f16:     	je	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001f18:     	movq	0x8(%rbx), %r8
180001f1c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001f27:     	jne	0x180001f65 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x9a5>
180001f29:     	movq	0x22f8(%rip), %rcx      # 0x180004228
180001f30:     	leaq	0x2b79(%rip), %rdx      # 0x180004ab0
180001f37:     	movq	0x18(%r8), %r8
180001f3b:     	movq	(%rcx), %rcx
180001f3e:     	callq	*0x2284(%rip)           # 0x1800041c8
180001f44:     	movl	(%rbx), %eax
180001f46:     	testl	%eax, %eax
180001f48:     	js	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001f4a:     	subl	$0x1, %eax
180001f4d:     	movl	%eax, (%rbx)
180001f4f:     	jne	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001f51:     	movq	%rbx, %rcx
180001f54:     	callq	*0x2256(%rip)           # 0x1800041b0
180001f5a:     	xorl	%eax, %eax
180001f5c:     	addq	$0x28, %rsp
180001f60:     	popq	%rdi
180001f61:     	popq	%rsi
180001f62:     	popq	%rbp
180001f63:     	popq	%rbx
180001f64:     	retq
180001f65:     	xorl	%r8d, %r8d
180001f68:     	leaq	0x8391(%rip), %rcx      # 0x18000a300
180001f6f:     	xorl	%edx, %edx
180001f71:     	callq	*0x2299(%rip)           # 0x180004210
180001f77:     	movq	%rax, %rdi
180001f7a:     	testq	%rax, %rax
180001f7d:     	je	0x180001f44 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x984>
180001f7f:     	movq	%rbp, %rcx
180001f82:     	movq	%rbx, 0x18(%rax)
180001f86:     	callq	*0x221c(%rip)           # 0x1800041a8
180001f8c:     	movq	%rax, 0x10(%rdi)
180001f90:     	movq	%rax, %rcx
180001f93:     	testq	%rax, %rax
180001f96:     	jne	0x180001faa <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x9ea>
180001f98:     	movl	(%rdi), %eax
180001f9a:     	testl	%eax, %eax
180001f9c:     	js	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001f9e:     	subl	$0x1, %eax
180001fa1:     	movl	%eax, (%rdi)
180001fa3:     	jne	0x180001f5a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x99a>
180001fa5:     	movq	%rdi, %rcx
180001fa8:     	jmp	0x180001f54 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x994>
180001faa:     	movl	(%rax), %eax
180001fac:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001fb1:     	jae	0x180001fb7 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x9f7>
180001fb3:     	incl	%eax
180001fb5:     	movl	%eax, (%rcx)
180001fb7:     	movq	%rdi, %rax
180001fba:     	addq	$0x28, %rsp
180001fbe:     	popq	%rdi
180001fbf:     	popq	%rsi
180001fc0:     	popq	%rbp
180001fc1:     	popq	%rbx
180001fc2:     	retq
180001fc3:     	int3
180001fc4:     	int3
180001fc5:     	int3
180001fc6:     	int3
180001fc7:     	int3
180001fc8:     	int3
180001fc9:     	int3
180001fca:     	int3
180001fcb:     	int3
180001fcc:     	int3
180001fcd:     	int3
180001fce:     	int3
180001fcf:     	int3
180001fd0:     	movq	%r9, 0x20(%rsp)
180001fd5:     	movq	%r8, 0x18(%rsp)
180001fda:     	movq	%rdx, 0x10(%rsp)
180001fdf:     	movq	%rcx, 0x8(%rsp)
180001fe4:     	pushq	%rbx
180001fe5:     	pushq	%rbp
180001fe6:     	pushq	%rsi
180001fe7:     	pushq	%rdi
180001fe8:     	pushq	%r12
180001fea:     	pushq	%r13
180001fec:     	pushq	%r14
180001fee:     	pushq	%r15
180001ff0:     	subq	$0x68, %rsp
180001ff4:     	movq	%rcx, %r14
180001ff7:     	movq	%r9, %r15
180001ffa:     	leaq	0x25ef(%rip), %rcx      # 0x1800045f0
180002001:     	movq	%r8, %r13
180002004:     	movq	%rdx, %rsi
180002007:     	callq	*0x21fb(%rip)           # 0x180004208
18000200d:     	movq	%rax, %rdi
180002010:     	testq	%rax, %rax
180002013:     	jne	0x18000204c <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xa8c>
180002015:     	movq	0x20f4(%rip), %rcx      # 0x180004110
18000201c:     	movq	(%rcx), %rcx
18000201f:     	callq	*0x2173(%rip)           # 0x180004198
180002025:     	testl	%eax, %eax
180002027:     	je	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
18000202d:     	callq	*0x2125(%rip)           # 0x180004158
180002033:     	leaq	0x25d6(%rip), %rcx      # 0x180004610
18000203a:     	callq	*0x21c8(%rip)           # 0x180004208
180002040:     	movq	%rax, %rdi
180002043:     	testq	%rax, %rax
180002046:     	je	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
18000204c:     	leaq	0x25dd(%rip), %rdx      # 0x180004630
180002053:     	movq	%rdi, %rcx
180002056:     	callq	*0x2104(%rip)           # 0x180004160
18000205c:     	movl	(%rdi), %ecx
18000205e:     	movq	%rax, %rbx
180002061:     	testl	%ecx, %ecx
180002063:     	js	0x180002075 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xab5>
180002065:     	subl	$0x1, %ecx
180002068:     	movl	%ecx, (%rdi)
18000206a:     	jne	0x180002075 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xab5>
18000206c:     	movq	%rdi, %rcx
18000206f:     	callq	*0x213b(%rip)           # 0x1800041b0
180002075:     	testq	%rbx, %rbx
180002078:     	je	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
18000207e:     	movq	0x2063(%rip), %rax      # 0x1800040e8
180002085:     	cmpq	%rax, 0x8(%rbx)
180002089:     	je	0x1800020c5 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb05>
18000208b:     	movq	0x21a6(%rip), %rcx      # 0x180004238
180002092:     	leaq	0x25a7(%rip), %rdx      # 0x180004640
180002099:     	movq	(%rcx), %rcx
18000209c:     	callq	*0x218e(%rip)           # 0x180004230
1800020a2:     	movl	(%rbx), %eax
1800020a4:     	testl	%eax, %eax
1800020a6:     	js	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
1800020ac:     	subl	$0x1, %eax
1800020af:     	movl	%eax, (%rbx)
1800020b1:     	jne	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
1800020b7:     	movq	%rbx, %rcx
1800020ba:     	callq	*0x20f0(%rip)           # 0x1800041b0
1800020c0:     	jmp	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
1800020c5:     	xorl	%edx, %edx
1800020c7:     	movq	%rbx, %rcx
1800020ca:     	callq	*0x20c0(%rip)           # 0x180004190
1800020d0:     	movl	(%rbx), %ecx
1800020d2:     	movq	%rax, 0x8b67(%rip)      # 0x18000ac40
1800020d9:     	testl	%ecx, %ecx
1800020db:     	js	0x1800020f4 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb34>
1800020dd:     	subl	$0x1, %ecx
1800020e0:     	movl	%ecx, (%rbx)
1800020e2:     	jne	0x1800020f4 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb34>
1800020e4:     	movq	%rbx, %rcx
1800020e7:     	callq	*0x20c3(%rip)           # 0x1800041b0
1800020ed:     	movq	0x8b4c(%rip), %rax      # 0x18000ac40
1800020f4:     	testq	%rax, %rax
1800020f7:     	jne	0x180002112 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb52>
1800020f9:     	leaq	0x2568(%rip), %rdx      # 0x180004668
180002100:     	movq	0x2131(%rip), %rcx      # 0x180004238
180002107:     	movq	(%rcx), %rcx
18000210a:     	callq	*0x2120(%rip)           # 0x180004230
180002110:     	jmp	0x180002147 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb87>
180002112:     	callq	*(%rax)
180002114:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180002119:     	jbe	0x18000217a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xbba>
18000211b:     	movq	0x2116(%rip), %rax      # 0x180004238
180002122:     	movq	(%rax), %rbx
180002125:     	movq	0x8b14(%rip), %rax      # 0x18000ac40
18000212c:     	callq	*(%rax)
18000212e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002134:     	leaq	0x2555(%rip), %rdx      # 0x180004690
18000213b:     	movl	%eax, %r9d
18000213e:     	movq	%rbx, %rcx
180002141:     	callq	*0x2081(%rip)           # 0x1800041c8
180002147:     	callq	*0x211b(%rip)           # 0x180004268
18000214d:     	movq	0x1fa4(%rip), %rcx      # 0x1800040f8
180002154:     	leaq	0x275d(%rip), %rdx      # 0x1800048b8
18000215b:     	movq	(%rcx), %rcx
18000215e:     	callq	*0x20cc(%rip)           # 0x180004230
180002164:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002169:     	addq	$0x68, %rsp
18000216d:     	popq	%r15
18000216f:     	popq	%r14
180002171:     	popq	%r13
180002173:     	popq	%r12
180002175:     	popq	%rdi
180002176:     	popq	%rsi
180002177:     	popq	%rbp
180002178:     	popq	%rbx
180002179:     	retq
18000217a:     	movq	0x8abf(%rip), %rax      # 0x18000ac40
180002181:     	callq	*0x698(%rax)
180002187:     	movl	%eax, 0x8abf(%rip)      # 0x18000ac4c
18000218d:     	cmpl	$0x10, %eax
180002190:     	jge	0x1800021ae <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xbee>
180002192:     	movq	0x209f(%rip), %rcx      # 0x180004238
180002199:     	leaq	0x2540(%rip), %rdx      # 0x1800046e0
1800021a0:     	movl	%eax, %r9d
1800021a3:     	movl	$0x10, %r8d
1800021a9:     	movq	(%rcx), %rcx
1800021ac:     	jmp	0x180002141 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb81>
1800021ae:     	movq	0x8a8b(%rip), %rax      # 0x18000ac40
1800021b5:     	callq	*0x690(%rax)
1800021bb:     	testl	%eax, %eax
1800021bd:     	jne	0x1800021cb <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xc0b>
1800021bf:     	leaq	0x266a(%rip), %rdx      # 0x180004830
1800021c6:     	jmp	0x180002100 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb40>
1800021cb:     	cmpl	$0x1, %eax
1800021ce:     	je	0x1800021dc <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xc1c>
1800021d0:     	leaq	0x2689(%rip), %rdx      # 0x180004860
1800021d7:     	jmp	0x180002100 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xb40>
1800021dc:     	leaq	0x85fd(%rip), %rcx      # 0x18000a7e0
1800021e3:     	callq	*0x1f7f(%rip)           # 0x180004168
1800021e9:     	testl	%eax, %eax
1800021eb:     	jne	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
1800021f1:     	leaq	0x8108(%rip), %rcx      # 0x18000a300
1800021f8:     	callq	*0x1f6a(%rip)           # 0x180004168
1800021fe:     	testl	%eax, %eax
180002200:     	jne	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
180002206:     	leaq	0x8433(%rip), %rcx      # 0x18000a640
18000220d:     	callq	*0x1f55(%rip)           # 0x180004168
180002213:     	testl	%eax, %eax
180002215:     	jne	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
18000221b:     	xorl	%ebx, %ebx
18000221d:     	cmpl	%ebx, 0x8a25(%rip)      # 0x18000ac48
180002223:     	jne	0x180002266 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xca6>
180002225:     	movq	%gs:0x58, %rax
18000222e:     	movl	0x8a24(%rip), %ecx      # 0x18000ac58
180002234:     	movl	$0x1, 0x8a0a(%rip)      # 0x18000ac48
18000223e:     	movq	(%rax,%rcx,8), %rdx
180002242:     	movl	$0x10, %eax
180002247:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000224e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002253:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000225a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000225f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180002266:     	movl	%ebx, 0x898c(%rip)      # 0x18000abf8
18000226c:     	movq	%rbx, %rax
18000226f:     	movb	%bl, 0x898b(%rip)       # 0x18000ac00
180002275:     	movq	%rbx, %rcx
180002278:     	xchgq	%rax, 0x8989(%rip)      # 0x18000ac08
18000227f:     	xchgq	%rcx, 0x898a(%rip)      # 0x18000ac10
180002286:     	movq	%rbx, %rax
180002289:     	movq	%rbx, %rcx
18000228c:     	xchgq	%rax, 0x8985(%rip)      # 0x18000ac18
180002293:     	xchgq	%rcx, 0x8986(%rip)      # 0x18000ac20
18000229a:     	movq	0x1dbf(%rip), %rax      # 0x180004060
1800022a1:     	leaq	0x81f8(%rip), %rcx      # 0x18000a4a0
1800022a8:     	movq	%rax, 0x8979(%rip)      # 0x18000ac28
1800022af:     	movq	0x1dba(%rip), %rax      # 0x180004070
1800022b6:     	movq	%rax, 0x8973(%rip)      # 0x18000ac30
1800022bd:     	movq	0x1da4(%rip), %rax      # 0x180004068
1800022c4:     	movq	%rax, 0x896d(%rip)      # 0x18000ac38
1800022cb:     	movq	0x1f3e(%rip), %rax      # 0x180004210
1800022d2:     	movq	%rax, 0x82ff(%rip)      # 0x18000a5d8
1800022d9:     	callq	*0x1e89(%rip)           # 0x180004168
1800022df:     	testl	%eax, %eax
1800022e1:     	jne	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
1800022e7:     	leaq	0x265a(%rip), %rdx      # 0x180004948
1800022ee:     	movq	%r14, %rcx
1800022f1:     	callq	*0x1e69(%rip)           # 0x180004160
1800022f7:     	movq	%rax, 0x28(%rsp)
1800022fc:     	movq	%rax, %rdi
1800022ff:     	testq	%rax, %rax
180002302:     	je	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
180002308:     	leaq	0x27d2(%rip), %rcx      # 0x180004ae1
18000230f:     	callq	*0x1deb(%rip)           # 0x180004100
180002315:     	movq	%rax, 0x20(%rsp)
18000231a:     	movq	%rax, %r12
18000231d:     	testq	%rax, %rax
180002320:     	je	0x180002664 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x10a4>
180002326:     	movl	%ebx, %ebp
180002328:     	cmpq	%rbx, (%rsi)
18000232b:     	je	0x1800024d4 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xf14>
180002331:     	movslq	%ebp, %rbx
180002334:     	leaq	0x30(%rsp), %rdx
180002339:     	movq	%r14, %rcx
18000233c:     	leaq	(%rbx,%rbx,4), %rax
180002340:     	movups	(%r13,%rax,8), %xmm0
180002346:     	movups	0x10(%r13,%rax,8), %xmm1
18000234c:     	movaps	%xmm0, 0x30(%rsp)
180002351:     	movsd	0x20(%r13,%rax,8), %xmm0
180002358:     	movsd	%xmm0, 0x50(%rsp)
18000235e:     	movaps	%xmm1, 0x40(%rsp)
180002363:     	callq	0x180001e60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x8a0>
180002368:     	movq	%rax, %r14
18000236b:     	testq	%rax, %rax
18000236e:     	je	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
180002374:     	movq	(%rsi), %rcx
180002377:     	callq	*0x1d83(%rip)           # 0x180004100
18000237d:     	movq	%rax, %r13
180002380:     	testq	%rax, %rax
180002383:     	je	0x180002687 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x10c7>
180002389:     	movq	(%r15,%rbx,8), %rcx
18000238d:     	xorl	%edx, %edx
18000238f:     	movq	%r14, (%rcx)
180002392:     	leaq	0x8447(%rip), %rcx      # 0x18000a7e0
180002399:     	movq	0x8(%rsi), %r12
18000239d:     	callq	*0x1da5(%rip)           # 0x180004148
1800023a3:     	movq	%rax, %rbx
1800023a6:     	testq	%rax, %rax
1800023a9:     	je	0x180002426 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe66>
1800023ab:     	movq	%r13, %rcx
1800023ae:     	callq	*0x1dc4(%rip)           # 0x180004178
1800023b4:     	movq	%rax, %rdi
1800023b7:     	testq	%rax, %rax
1800023ba:     	je	0x1800023dc <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe1c>
1800023bc:     	movq	%rax, %rcx
1800023bf:     	callq	0x180003c15 <numba_list_iter_next+0xe85>
1800023c4:     	leaq	0x1(%rax), %rcx
1800023c8:     	callq	*0x1e4a(%rip)           # 0x180004218
1800023ce:     	movq	%rax, %rsi
1800023d1:     	testq	%rax, %rax
1800023d4:     	jne	0x1800023e4 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe24>
1800023d6:     	callq	*0x1d5c(%rip)           # 0x180004138
1800023dc:     	xorl	%eax, %eax
1800023de:     	movq	%rax, 0x20(%rbx)
1800023e2:     	jmp	0x180002415 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe55>
1800023e4:     	movq	%rdi, %rdx
1800023e7:     	movq	%rsi, %rcx
1800023ea:     	callq	0x180003c0f <numba_list_iter_next+0xe7f>
1800023ef:     	movq	0x20(%rsp), %rcx
1800023f4:     	movq	%rsi, 0x20(%rbx)
1800023f8:     	movq	%r12, 0x28(%rbx)
1800023fc:     	movl	$0x3, 0x30(%rbx)
180002403:     	callq	0x1800018e0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x320>
180002408:     	movq	%rax, 0x38(%rbx)
18000240c:     	testq	%rax, %rax
18000240f:     	jne	0x180002580 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfc0>
180002415:     	movl	(%rbx), %eax
180002417:     	testl	%eax, %eax
180002419:     	js	0x180002426 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe66>
18000241b:     	subl	$0x1, %eax
18000241e:     	movl	%eax, (%rbx)
180002420:     	je	0x1800025cd <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x100d>
180002426:     	xorl	%edi, %edi
180002428:     	movl	(%r14), %eax
18000242b:     	testl	%eax, %eax
18000242d:     	js	0x180002440 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe80>
18000242f:     	subl	$0x1, %eax
180002432:     	movl	%eax, (%r14)
180002435:     	jne	0x180002440 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe80>
180002437:     	movq	%r14, %rcx
18000243a:     	callq	*0x1d70(%rip)           # 0x1800041b0
180002440:     	movl	(%r13), %eax
180002444:     	testl	%eax, %eax
180002446:     	js	0x18000245a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe9a>
180002448:     	subl	$0x1, %eax
18000244b:     	movl	%eax, (%r13)
18000244f:     	jne	0x18000245a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe9a>
180002451:     	movq	%r13, %rcx
180002454:     	callq	*0x1d56(%rip)           # 0x1800041b0
18000245a:     	testq	%rdi, %rdi
18000245d:     	je	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
180002463:     	movq	0xb8(%rsp), %rsi
18000246b:     	movq	%rdi, %r8
18000246e:     	movq	0xb0(%rsp), %r14
180002476:     	movq	%r14, %rcx
180002479:     	movq	(%rsi), %rdx
18000247c:     	callq	*0x1d76(%rip)           # 0x1800041f8
180002482:     	movl	(%rdi), %ecx
180002484:     	testl	%eax, %eax
180002486:     	jne	0x18000262a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x106a>
18000248c:     	testl	%ecx, %ecx
18000248e:     	js	0x1800024a2 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xee2>
180002490:     	leal	-0x1(%rcx), %eax
180002493:     	movl	%eax, (%rdi)
180002495:     	testl	%eax, %eax
180002497:     	jne	0x1800024a2 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xee2>
180002499:     	movq	%rdi, %rcx
18000249c:     	callq	*0x1d0e(%rip)           # 0x1800041b0
1800024a2:     	movq	0xc8(%rsp), %r15
1800024aa:     	addq	$0x20, %rsi
1800024ae:     	movq	0xc0(%rsp), %r13
1800024b6:     	incl	%ebp
1800024b8:     	movq	%rsi, 0xb8(%rsp)
1800024c0:     	cmpq	$0x0, (%rsi)
1800024c4:     	jne	0x180002331 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xd71>
1800024ca:     	movq	0x20(%rsp), %r12
1800024cf:     	movq	0x28(%rsp), %rdi
1800024d4:     	movslq	%ebp, %rax
1800024d7:     	cmpq	$0x0, (%r15,%rax,8)
1800024dc:     	je	0x180002549 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xf89>
1800024de:     	nop
1800024e0:     	movslq	%ebp, %rbx
1800024e3:     	leaq	0x30(%rsp), %rdx
1800024e8:     	movq	%r14, %rcx
1800024eb:     	leaq	(%rbx,%rbx,4), %rax
1800024ef:     	movups	(%r13,%rax,8), %xmm0
1800024f5:     	movups	0x10(%r13,%rax,8), %xmm1
1800024fb:     	movaps	%xmm0, 0x30(%rsp)
180002500:     	movsd	0x20(%r13,%rax,8), %xmm0
180002507:     	movsd	%xmm0, 0x50(%rsp)
18000250d:     	movaps	%xmm1, 0x40(%rsp)
180002512:     	callq	0x180001e60 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x8a0>
180002517:     	testq	%rax, %rax
18000251a:     	je	0x180002645 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1085>
180002520:     	movq	(%r15,%rbx,8), %rcx
180002524:     	movq	%rax, (%rcx)
180002527:     	movl	(%rax), %ecx
180002529:     	testl	%ecx, %ecx
18000252b:     	js	0x18000253d <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xf7d>
18000252d:     	subl	$0x1, %ecx
180002530:     	movl	%ecx, (%rax)
180002532:     	jne	0x18000253d <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xf7d>
180002534:     	movq	%rax, %rcx
180002537:     	callq	*0x1c73(%rip)           # 0x1800041b0
18000253d:     	incl	%ebp
18000253f:     	movslq	%ebp, %rax
180002542:     	cmpq	$0x0, (%r15,%rax,8)
180002547:     	jne	0x1800024e0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xf20>
180002549:     	movl	(%r12), %eax
18000254d:     	testl	%eax, %eax
18000254f:     	js	0x180002563 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfa3>
180002551:     	subl	$0x1, %eax
180002554:     	movl	%eax, (%r12)
180002558:     	jne	0x180002563 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfa3>
18000255a:     	movq	%r12, %rcx
18000255d:     	callq	*0x1c4d(%rip)           # 0x1800041b0
180002563:     	movl	(%rdi), %eax
180002565:     	testl	%eax, %eax
180002567:     	js	0x180002579 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfb9>
180002569:     	subl	$0x1, %eax
18000256c:     	movl	%eax, (%rdi)
18000256e:     	jne	0x180002579 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfb9>
180002570:     	movq	%rdi, %rcx
180002573:     	callq	*0x1c37(%rip)           # 0x1800041b0
180002579:     	xorl	%eax, %eax
18000257b:     	jmp	0x180002169 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba9>
180002580:     	movl	(%r14), %eax
180002583:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002588:     	jae	0x18000258f <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xfcf>
18000258a:     	incl	%eax
18000258c:     	movl	%eax, (%r14)
18000258f:     	movq	0xb0(%rsp), %rcx
180002597:     	leaq	0x23aa(%rip), %rdx      # 0x180004948
18000259e:     	movq	%r14, 0x18(%rbx)
1800025a2:     	movq	$0x0, 0x40(%rbx)
1800025aa:     	callq	*0x1bb0(%rip)           # 0x180004160
1800025b0:     	movq	%rax, %rsi
1800025b3:     	testq	%rax, %rax
1800025b6:     	jne	0x1800025db <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x101b>
1800025b8:     	movl	(%rbx), %eax
1800025ba:     	testl	%eax, %eax
1800025bc:     	js	0x180002426 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe66>
1800025c2:     	subl	$0x1, %eax
1800025c5:     	movl	%eax, (%rbx)
1800025c7:     	jne	0x180002426 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe66>
1800025cd:     	movq	%rbx, %rcx
1800025d0:     	callq	*0x1bda(%rip)           # 0x1800041b0
1800025d6:     	jmp	0x180002426 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe66>
1800025db:     	xorl	%r9d, %r9d
1800025de:     	leaq	0x20(%rbx), %rcx
1800025e2:     	movq	%rsi, %r8
1800025e5:     	movq	%rbx, %rdx
1800025e8:     	callq	*0x1b52(%rip)           # 0x180004140
1800025ee:     	movq	%rax, %rdi
1800025f1:     	movl	(%rbx), %eax
1800025f3:     	testl	%eax, %eax
1800025f5:     	js	0x180002607 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1047>
1800025f7:     	subl	$0x1, %eax
1800025fa:     	movl	%eax, (%rbx)
1800025fc:     	jne	0x180002607 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1047>
1800025fe:     	movq	%rbx, %rcx
180002601:     	callq	*0x1ba9(%rip)           # 0x1800041b0
180002607:     	movl	(%rsi), %eax
180002609:     	testl	%eax, %eax
18000260b:     	js	0x180002428 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe68>
180002611:     	subl	$0x1, %eax
180002614:     	movl	%eax, (%rsi)
180002616:     	jne	0x180002428 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe68>
18000261c:     	movq	%rsi, %rcx
18000261f:     	callq	*0x1b8b(%rip)           # 0x1800041b0
180002625:     	jmp	0x180002428 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xe68>
18000262a:     	testl	%ecx, %ecx
18000262c:     	js	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
18000262e:     	leal	-0x1(%rcx), %eax
180002631:     	movl	%eax, (%rdi)
180002633:     	testl	%eax, %eax
180002635:     	jne	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
180002637:     	movq	%rdi, %rcx
18000263a:     	callq	*0x1b70(%rip)           # 0x1800041b0
180002640:     	movq	0x20(%rsp), %r12
180002645:     	movl	(%r12), %eax
180002649:     	testl	%eax, %eax
18000264b:     	js	0x18000265f <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x109f>
18000264d:     	subl	$0x1, %eax
180002650:     	movl	%eax, (%r12)
180002654:     	jne	0x18000265f <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x109f>
180002656:     	movq	%r12, %rcx
180002659:     	callq	*0x1b51(%rip)           # 0x1800041b0
18000265f:     	movq	0x28(%rsp), %rdi
180002664:     	movl	(%rdi), %eax
180002666:     	testl	%eax, %eax
180002668:     	js	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
18000266e:     	subl	$0x1, %eax
180002671:     	movl	%eax, (%rdi)
180002673:     	jne	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
180002679:     	movq	%rdi, %rcx
18000267c:     	callq	*0x1b2e(%rip)           # 0x1800041b0
180002682:     	jmp	0x180002164 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0xba4>
180002687:     	movl	(%r14), %eax
18000268a:     	testl	%eax, %eax
18000268c:     	js	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
18000268e:     	subl	$0x1, %eax
180002691:     	movl	%eax, (%r14)
180002694:     	jne	0x180002640 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x1080>
180002696:     	movq	%r14, %rcx
180002699:     	jmp	0x18000263a <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x107a>
18000269b:     	int3
18000269c:     	int3
18000269d:     	int3
18000269e:     	int3
18000269f:     	int3
1800026a0:     	leaq	0x85c9(%rip), %rax      # 0x18000ac70
1800026a7:     	retq
1800026a8:     	int3
1800026a9:     	int3
1800026aa:     	int3
1800026ab:     	int3
1800026ac:     	int3
1800026ad:     	int3
1800026ae:     	int3
1800026af:     	int3

00000001800026b0 <numba_list_set_method_table>:
1800026b0:     	movups	(%rdx), %xmm0
1800026b3:     	movups	%xmm0, 0x20(%rcx)
1800026b7:     	retq
1800026b8:     	int3
1800026b9:     	int3
1800026ba:     	int3
1800026bb:     	int3
1800026bc:     	int3
1800026bd:     	int3
1800026be:     	int3
1800026bf:     	int3

00000001800026c0 <numba_list_new>:
1800026c0:     	pushq	%rbx
1800026c2:     	pushq	%rbp
1800026c3:     	pushq	%rsi
1800026c4:     	pushq	%rdi
1800026c5:     	subq	$0x28, %rsp
1800026c9:     	movq	%rcx, %rsi
1800026cc:     	movq	%r8, %rdi
1800026cf:     	movl	$0x38, %ecx
1800026d4:     	movq	%rdx, %rbp
1800026d7:     	callq	*0x1983(%rip)           # 0x180004060
1800026dd:     	movq	%rax, %rbx
1800026e0:     	testq	%rax, %rax
1800026e3:     	je	0x18000274d <numba_list_new+0x8d>
1800026e5:     	movq	$0x0, (%rax)
1800026ec:     	xorps	%xmm0, %xmm0
1800026ef:     	movq	%rbp, 0x8(%rax)
1800026f3:     	movq	%rdi, 0x10(%rax)
1800026f7:     	movl	$0x1, 0x18(%rax)
1800026fe:     	movups	%xmm0, 0x20(%rax)
180002702:     	testq	%rdi, %rdi
180002705:     	je	0x18000275b <numba_list_new+0x9b>
180002707:     	imulq	%rbp, %rdi
18000270b:     	movl	$0x8, %ecx
180002710:     	movq	%rdi, %rax
180002713:     	cqto
180002715:     	andl	$0x7, %edx
180002718:     	addq	%rdx, %rax
18000271b:     	andl	$0x7, %eax
18000271e:     	subq	%rdx, %rax
180002721:     	subq	%rax, %rcx
180002724:     	movq	%rcx, %rax
180002727:     	cqto
180002729:     	andl	$0x7, %edx
18000272c:     	leaq	(%rdx,%rax), %rcx
180002730:     	andl	$0x7, %ecx
180002733:     	subq	%rdx, %rcx
180002736:     	addq	%rdi, %rcx
180002739:     	callq	*0x1921(%rip)           # 0x180004060
18000273f:     	testq	%rax, %rax
180002742:     	jne	0x18000275d <numba_list_new+0x9d>
180002744:     	movq	%rbx, %rcx
180002747:     	callq	*0x191b(%rip)           # 0x180004068
18000274d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002752:     	addq	$0x28, %rsp
180002756:     	popq	%rdi
180002757:     	popq	%rsi
180002758:     	popq	%rbp
180002759:     	popq	%rbx
18000275a:     	retq
18000275b:     	xorl	%eax, %eax
18000275d:     	movq	%rax, 0x30(%rbx)
180002761:     	xorl	%eax, %eax
180002763:     	movq	%rbx, (%rsi)
180002766:     	addq	$0x28, %rsp
18000276a:     	popq	%rdi
18000276b:     	popq	%rsi
18000276c:     	popq	%rbp
18000276d:     	popq	%rbx
18000276e:     	retq
18000276f:     	int3

0000000180002770 <numba_list_free>:
180002770:     	pushq	%rbx
180002772:     	subq	$0x20, %rsp
180002776:     	cmpq	$0x0, 0x28(%rcx)
18000277b:     	movq	%rcx, %rbx
18000277e:     	je	0x1800027b4 <numba_list_free+0x44>
180002780:     	movq	%rdi, 0x30(%rsp)
180002785:     	xorl	%edi, %edi
180002787:     	cmpq	%rdi, (%rcx)
18000278a:     	jle	0x1800027af <numba_list_free+0x3f>
18000278c:     	nopl	(%rax)
180002790:     	movq	0x28(%rbx), %rax
180002794:     	testq	%rax, %rax
180002797:     	je	0x1800027a7 <numba_list_free+0x37>
180002799:     	movq	%rdi, %rcx
18000279c:     	imulq	0x8(%rbx), %rcx
1800027a1:     	addq	0x30(%rbx), %rcx
1800027a5:     	callq	*%rax
1800027a7:     	incq	%rdi
1800027aa:     	cmpq	(%rbx), %rdi
1800027ad:     	jl	0x180002790 <numba_list_free+0x20>
1800027af:     	movq	0x30(%rsp), %rdi
1800027b4:     	movq	0x30(%rbx), %rcx
1800027b8:     	testq	%rcx, %rcx
1800027bb:     	je	0x1800027c3 <numba_list_free+0x53>
1800027bd:     	callq	*0x18a5(%rip)           # 0x180004068
1800027c3:     	movq	%rbx, %rcx
1800027c6:     	addq	$0x20, %rsp
1800027ca:     	popq	%rbx
1800027cb:     	jmpq	*0x1896(%rip)           # 0x180004068
1800027d2:     	int3
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

00000001800027e0 <numba_list_base_ptr>:
1800027e0:     	movq	0x30(%rcx), %rax
1800027e4:     	retq
1800027e5:     	int3
1800027e6:     	int3
1800027e7:     	int3
1800027e8:     	int3
1800027e9:     	int3
1800027ea:     	int3
1800027eb:     	int3
1800027ec:     	int3
1800027ed:     	int3
1800027ee:     	int3
1800027ef:     	int3

00000001800027f0 <numba_list_size_address>:
1800027f0:     	movq	%rcx, %rax
1800027f3:     	retq
1800027f4:     	int3
1800027f5:     	int3
1800027f6:     	int3
1800027f7:     	int3
1800027f8:     	int3
1800027f9:     	int3
1800027fa:     	int3
1800027fb:     	int3
1800027fc:     	int3
1800027fd:     	int3
1800027fe:     	int3
1800027ff:     	int3

0000000180002800 <numba_list_length>:
180002800:     	movq	(%rcx), %rax
180002803:     	retq
180002804:     	int3
180002805:     	int3
180002806:     	int3
180002807:     	int3
180002808:     	int3
180002809:     	int3
18000280a:     	int3
18000280b:     	int3
18000280c:     	int3
18000280d:     	int3
18000280e:     	int3
18000280f:     	int3

0000000180002810 <numba_list_allocated>:
180002810:     	movq	0x10(%rcx), %rax
180002814:     	retq
180002815:     	int3
180002816:     	int3
180002817:     	int3
180002818:     	int3
180002819:     	int3
18000281a:     	int3
18000281b:     	int3
18000281c:     	int3
18000281d:     	int3
18000281e:     	int3
18000281f:     	int3

0000000180002820 <numba_list_is_mutable>:
180002820:     	movl	0x18(%rcx), %eax
180002823:     	retq
180002824:     	int3
180002825:     	int3
180002826:     	int3
180002827:     	int3
180002828:     	int3
180002829:     	int3
18000282a:     	int3
18000282b:     	int3
18000282c:     	int3
18000282d:     	int3
18000282e:     	int3
18000282f:     	int3

0000000180002830 <numba_list_set_is_mutable>:
180002830:     	movl	%edx, 0x18(%rcx)
180002833:     	retq
180002834:     	int3
180002835:     	int3
180002836:     	int3
180002837:     	int3
180002838:     	int3
180002839:     	int3
18000283a:     	int3
18000283b:     	int3
18000283c:     	int3
18000283d:     	int3
18000283e:     	int3
18000283f:     	int3

0000000180002840 <numba_list_setitem>:
180002840:     	movq	%rbx, 0x10(%rsp)
180002845:     	pushq	%rsi
180002846:     	subq	$0x20, %rsp
18000284a:     	cmpl	$0x0, 0x18(%rcx)
18000284e:     	movq	%r8, %rsi
180002851:     	movq	%rcx, %rbx
180002854:     	jne	0x180002866 <numba_list_setitem+0x26>
180002856:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000285b:     	movq	0x38(%rsp), %rbx
180002860:     	addq	$0x20, %rsp
180002864:     	popq	%rsi
180002865:     	retq
180002866:     	cmpq	(%rcx), %rdx
180002869:     	jb	0x18000287b <numba_list_setitem+0x3b>
18000286b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002870:     	movq	0x38(%rsp), %rbx
180002875:     	addq	$0x20, %rsp
180002879:     	popq	%rsi
18000287a:     	retq
18000287b:     	imulq	0x8(%rcx), %rdx
180002880:     	movq	0x28(%rcx), %rax
180002884:     	movq	%rdi, 0x30(%rsp)
180002889:     	movq	0x30(%rcx), %rdi
18000288d:     	addq	%rdx, %rdi
180002890:     	testq	%rax, %rax
180002893:     	je	0x18000289a <numba_list_setitem+0x5a>
180002895:     	movq	%rdi, %rcx
180002898:     	callq	*%rax
18000289a:     	movq	0x8(%rbx), %r8
18000289e:     	movq	%rsi, %rdx
1800028a1:     	movq	%rdi, %rcx
1800028a4:     	callq	0x180003c03 <numba_list_iter_next+0xe73>
1800028a9:     	movq	0x20(%rbx), %rax
1800028ad:     	testq	%rax, %rax
1800028b0:     	je	0x1800028b7 <numba_list_setitem+0x77>
1800028b2:     	movq	%rdi, %rcx
1800028b5:     	callq	*%rax
1800028b7:     	movq	0x30(%rsp), %rdi
1800028bc:     	xorl	%eax, %eax
1800028be:     	movq	0x38(%rsp), %rbx
1800028c3:     	addq	$0x20, %rsp
1800028c7:     	popq	%rsi
1800028c8:     	retq
1800028c9:     	int3
1800028ca:     	int3
1800028cb:     	int3
1800028cc:     	int3
1800028cd:     	int3
1800028ce:     	int3
1800028cf:     	int3

00000001800028d0 <numba_list_getitem>:
1800028d0:     	subq	$0x28, %rsp
1800028d4:     	movq	%r8, %r9
1800028d7:     	movq	%rdx, %rax
1800028da:     	cmpq	(%rcx), %rdx
1800028dd:     	jb	0x1800028e9 <numba_list_getitem+0x19>
1800028df:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800028e4:     	addq	$0x28, %rsp
1800028e8:     	retq
1800028e9:     	movq	0x8(%rcx), %r8
1800028ed:     	movq	%r8, %rdx
1800028f0:     	imulq	%rax, %rdx
1800028f4:     	addq	0x30(%rcx), %rdx
1800028f8:     	movq	%r9, %rcx
1800028fb:     	callq	0x180003c03 <numba_list_iter_next+0xe73>
180002900:     	xorl	%eax, %eax
180002902:     	addq	$0x28, %rsp
180002906:     	retq
180002907:     	int3
180002908:     	int3
180002909:     	int3
18000290a:     	int3
18000290b:     	int3
18000290c:     	int3
18000290d:     	int3
18000290e:     	int3
18000290f:     	int3

0000000180002910 <numba_list_append>:
180002910:     	movq	%rbx, 0x10(%rsp)
180002915:     	pushq	%rsi
180002916:     	subq	$0x20, %rsp
18000291a:     	cmpl	$0x0, 0x18(%rcx)
18000291e:     	movq	%rdx, %rsi
180002921:     	movq	%rcx, %rbx
180002924:     	jne	0x180002936 <numba_list_append+0x26>
180002926:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000292b:     	movq	0x38(%rsp), %rbx
180002930:     	addq	$0x20, %rsp
180002934:     	popq	%rsi
180002935:     	retq
180002936:     	movq	(%rcx), %rdx
180002939:     	incq	%rdx
18000293c:     	callq	0x180002990 <numba_list_resize>
180002941:     	testl	%eax, %eax
180002943:     	js	0x18000297c <numba_list_append+0x6c>
180002945:     	movq	0x8(%rbx), %r8
180002949:     	movq	%rsi, %rdx
18000294c:     	movq	%rdi, 0x30(%rsp)
180002951:     	movq	(%rbx), %rdi
180002954:     	decq	%rdi
180002957:     	imulq	%r8, %rdi
18000295b:     	addq	0x30(%rbx), %rdi
18000295f:     	movq	%rdi, %rcx
180002962:     	callq	0x180003c03 <numba_list_iter_next+0xe73>
180002967:     	movq	0x20(%rbx), %rax
18000296b:     	testq	%rax, %rax
18000296e:     	je	0x180002975 <numba_list_append+0x65>
180002970:     	movq	%rdi, %rcx
180002973:     	callq	*%rax
180002975:     	movq	0x30(%rsp), %rdi
18000297a:     	xorl	%eax, %eax
18000297c:     	movq	0x38(%rsp), %rbx
180002981:     	addq	$0x20, %rsp
180002985:     	popq	%rsi
180002986:     	retq
180002987:     	int3
180002988:     	int3
180002989:     	int3
18000298a:     	int3
18000298b:     	int3
18000298c:     	int3
18000298d:     	int3
18000298e:     	int3
18000298f:     	int3

0000000180002990 <numba_list_resize>:
180002990:     	movq	%rsi, 0x18(%rsp)
180002995:     	pushq	%rdi
180002996:     	subq	$0x20, %rsp
18000299a:     	cmpl	$0x0, 0x18(%rcx)
18000299e:     	movq	%rdx, %rsi
1800029a1:     	movq	%rcx, %rdi
1800029a4:     	jne	0x1800029b6 <numba_list_resize+0x26>
1800029a6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800029ab:     	movq	0x40(%rsp), %rsi
1800029b0:     	addq	$0x20, %rsp
1800029b4:     	popq	%rdi
1800029b5:     	retq
1800029b6:     	movq	0x10(%rcx), %rax
1800029ba:     	cmpq	%rsi, %rax
1800029bd:     	jl	0x1800029d7 <numba_list_resize+0x47>
1800029bf:     	sarq	%rax
1800029c2:     	cmpq	%rax, %rsi
1800029c5:     	jl	0x1800029d7 <numba_list_resize+0x47>
1800029c7:     	movq	%rsi, (%rcx)
1800029ca:     	xorl	%eax, %eax
1800029cc:     	movq	0x40(%rsp), %rsi
1800029d1:     	addq	$0x20, %rsp
1800029d5:     	popq	%rdi
1800029d6:     	retq
1800029d7:     	cmpq	$0x9, %rsi
1800029db:     	movq	%rbp, 0x38(%rsp)
1800029e0:     	movl	$0x3, %ecx
1800029e5:     	movl	$0x6, %eax
1800029ea:     	cmovll	%ecx, %eax
1800029ed:     	movq	%rsi, %r8
1800029f0:     	movq	0x8(%rdi), %rcx
1800029f4:     	addq	%rsi, %rax
1800029f7:     	sarq	$0x3, %r8
1800029fb:     	xorl	%edx, %edx
1800029fd:     	addq	%rax, %r8
180002a00:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180002a0a:     	divq	%rcx
180002a0d:     	cmpq	%rax, %r8
180002a10:     	ja	0x180002a8b <numba_list_resize+0xfb>
180002a12:     	xorl	%ebp, %ebp
180002a14:     	movq	%rbx, 0x30(%rsp)
180002a19:     	testq	%rsi, %rsi
180002a1c:     	cmovneq	%r8, %rbp
180002a20:     	movq	%rbp, %rbx
180002a23:     	imulq	%rcx, %rbx
180002a27:     	movl	$0x8, %ecx
180002a2c:     	movq	%rbx, %rax
180002a2f:     	cqto
180002a31:     	andl	$0x7, %edx
180002a34:     	addq	%rdx, %rax
180002a37:     	andl	$0x7, %eax
180002a3a:     	subq	%rdx, %rax
180002a3d:     	subq	%rax, %rcx
180002a40:     	movq	%rcx, %rax
180002a43:     	movq	0x30(%rdi), %rcx
180002a47:     	cqto
180002a49:     	andl	$0x7, %edx
180002a4c:     	addq	%rdx, %rax
180002a4f:     	andl	$0x7, %eax
180002a52:     	subq	%rdx, %rax
180002a55:     	leaq	(%rbx,%rax), %rdx
180002a59:     	callq	*0x1611(%rip)           # 0x180004070
180002a5f:     	testq	%rbx, %rbx
180002a62:     	movq	0x30(%rsp), %rbx
180002a67:     	je	0x180002a6e <numba_list_resize+0xde>
180002a69:     	testq	%rax, %rax
180002a6c:     	je	0x180002a8b <numba_list_resize+0xfb>
180002a6e:     	movq	%rax, 0x30(%rdi)
180002a72:     	xorl	%eax, %eax
180002a74:     	movq	%rbp, 0x10(%rdi)
180002a78:     	movq	0x38(%rsp), %rbp
180002a7d:     	movq	%rsi, (%rdi)
180002a80:     	movq	0x40(%rsp), %rsi
180002a85:     	addq	$0x20, %rsp
180002a89:     	popq	%rdi
180002a8a:     	retq
180002a8b:     	movq	0x38(%rsp), %rbp
180002a90:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002a95:     	movq	0x40(%rsp), %rsi
180002a9a:     	addq	$0x20, %rsp
180002a9e:     	popq	%rdi
180002a9f:     	retq

0000000180002aa0 <numba_list_delitem>:
180002aa0:     	movq	%rbx, 0x10(%rsp)
180002aa5:     	pushq	%rdi
180002aa6:     	subq	$0x20, %rsp
180002aaa:     	cmpl	$0x0, 0x18(%rcx)
180002aae:     	movq	%rdx, %rdi
180002ab1:     	movq	%rcx, %rbx
180002ab4:     	jne	0x180002ac6 <numba_list_delitem+0x26>
180002ab6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002abb:     	movq	0x38(%rsp), %rbx
180002ac0:     	addq	$0x20, %rsp
180002ac4:     	popq	%rdi
180002ac5:     	retq
180002ac6:     	cmpq	(%rcx), %rdi
180002ac9:     	jb	0x180002adb <numba_list_delitem+0x3b>
180002acb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002ad0:     	movq	0x38(%rsp), %rbx
180002ad5:     	addq	$0x20, %rsp
180002ad9:     	popq	%rdi
180002ada:     	retq
180002adb:     	movq	0x28(%rcx), %rax
180002adf:     	movq	%rsi, 0x30(%rsp)
180002ae4:     	movq	%rdi, %rsi
180002ae7:     	imulq	0x8(%rcx), %rsi
180002aec:     	addq	0x30(%rcx), %rsi
180002af0:     	testq	%rax, %rax
180002af3:     	je	0x180002afa <numba_list_delitem+0x5a>
180002af5:     	movq	%rsi, %rcx
180002af8:     	callq	*%rax
180002afa:     	movq	(%rbx), %r8
180002afd:     	leaq	-0x1(%r8), %rax
180002b01:     	cmpq	%rax, %rdi
180002b04:     	je	0x180002b26 <numba_list_delitem+0x86>
180002b06:     	subq	%rdi, %r8
180002b09:     	leaq	0x1(%rdi), %rdx
180002b0d:     	imulq	0x8(%rbx), %rdx
180002b12:     	decq	%r8
180002b15:     	movq	%rsi, %rcx
180002b18:     	imulq	0x8(%rbx), %r8
180002b1d:     	addq	0x30(%rbx), %rdx
180002b21:     	callq	0x180003c09 <numba_list_iter_next+0xe79>
180002b26:     	movq	(%rbx), %rdx
180002b29:     	movq	%rbx, %rcx
180002b2c:     	decq	%rdx
180002b2f:     	callq	0x180002990 <numba_list_resize>
180002b34:     	movq	0x30(%rsp), %rsi
180002b39:     	xorl	%ecx, %ecx
180002b3b:     	movq	0x38(%rsp), %rbx
180002b40:     	testl	%eax, %eax
180002b42:     	cmovsl	%eax, %ecx
180002b45:     	movl	%ecx, %eax
180002b47:     	addq	$0x20, %rsp
180002b4b:     	popq	%rdi
180002b4c:     	retq
180002b4d:     	int3
180002b4e:     	int3
180002b4f:     	int3

0000000180002b50 <numba_list_delete_slice>:
180002b50:     	pushq	%rbx
180002b52:     	pushq	%rbp
180002b53:     	pushq	%rdi
180002b54:     	pushq	%r15
180002b56:     	subq	$0x38, %rsp
180002b5a:     	cmpl	$0x0, 0x18(%rcx)
180002b5e:     	movq	%r9, %rdi
180002b61:     	movq	%r8, %rbp
180002b64:     	movq	%rdx, %r15
180002b67:     	movq	%rcx, %rbx
180002b6a:     	jne	0x180002b7b <numba_list_delete_slice+0x2b>
180002b6c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002b71:     	addq	$0x38, %rsp
180002b75:     	popq	%r15
180002b77:     	popq	%rdi
180002b78:     	popq	%rbp
180002b79:     	popq	%rbx
180002b7a:     	retq
180002b7b:     	movq	%r13, 0x78(%rsp)
180002b80:     	testq	%rdi, %rdi
180002b83:     	jle	0x180002ba2 <numba_list_delete_slice+0x52>
180002b85:     	cmpq	%r8, %r15
180002b88:     	jge	0x180002d41 <numba_list_delete_slice+0x1f1>
180002b8e:     	movq	%r8, %rax
180002b91:     	subq	%r15, %rax
180002b94:     	decq	%rax
180002b97:     	cqto
180002b99:     	idivq	%rdi
180002b9c:     	leal	0x1(%rax), %r13d
180002ba0:     	jmp	0x180002bc2 <numba_list_delete_slice+0x72>
180002ba2:     	cmpq	%r15, %r8
180002ba5:     	jge	0x180002d41 <numba_list_delete_slice+0x1f1>
180002bab:     	movq	%r15, %rax
180002bae:     	movl	$0x1, %r13d
180002bb4:     	subq	%r8, %rax
180002bb7:     	decq	%rax
180002bba:     	cqto
180002bbc:     	idivq	%rdi
180002bbf:     	subl	%eax, %r13d
180002bc2:     	testl	%r13d, %r13d
180002bc5:     	jle	0x180002d41 <numba_list_delete_slice+0x1f1>
180002bcb:     	movq	%rsi, 0x68(%rsp)
180002bd0:     	movl	(%rcx), %esi
180002bd2:     	subl	%r13d, %esi
180002bd5:     	movl	%esi, 0x20(%rsp)
180002bd9:     	testq	%rdi, %rdi
180002bdc:     	jns	0x180002bf7 <numba_list_delete_slice+0xa7>
180002bde:     	leaq	0x1(%r15), %rbp
180002be2:     	leal	-0x1(%r13), %eax
180002be6:     	movslq	%eax, %rcx
180002be9:     	leaq	-0x1(%rbp), %r15
180002bed:     	imulq	%rdi, %rcx
180002bf1:     	addq	%rcx, %r15
180002bf4:     	negq	%rdi
180002bf7:     	cmpq	$0x1, %rdi
180002bfb:     	jne	0x180002c47 <numba_list_delete_slice+0xf7>
180002bfd:     	cmpq	$0x0, 0x28(%rbx)
180002c02:     	je	0x180002c29 <numba_list_delete_slice+0xd9>
180002c04:     	movslq	%r15d, %rdi
180002c07:     	cmpq	%rbp, %rdi
180002c0a:     	jge	0x180002c29 <numba_list_delete_slice+0xd9>
180002c0c:     	nopl	(%rax)
180002c10:     	movslq	%edi, %rcx
180002c13:     	imulq	0x8(%rbx), %rcx
180002c18:     	addq	0x30(%rbx), %rcx
180002c1c:     	callq	*0x28(%rbx)
180002c1f:     	incl	%edi
180002c21:     	movslq	%edi, %rax
180002c24:     	cmpq	%rbp, %rax
180002c27:     	jl	0x180002c10 <numba_list_delete_slice+0xc0>
180002c29:     	movq	0x8(%rbx), %rcx
180002c2d:     	movq	(%rbx), %r8
180002c30:     	movq	%rcx, %rdx
180002c33:     	subq	%rbp, %r8
180002c36:     	imulq	%rcx, %r8
180002c3a:     	imulq	%rbp, %rdx
180002c3e:     	imulq	%r15, %rcx
180002c42:     	jmp	0x180002d0c <numba_list_delete_slice+0x1bc>
180002c47:     	movq	%r14, 0x30(%rsp)
180002c4c:     	movq	%r15, %r14
180002c4f:     	movl	$0x0, 0x60(%rsp)
180002c57:     	cmpq	%rbp, %r15
180002c5a:     	jge	0x180002cd9 <numba_list_delete_slice+0x189>
180002c5c:     	movq	%r12, 0x70(%rsp)
180002c61:     	movq	(%rbx), %rax
180002c64:     	leaq	(%r14,%rdi), %r12
180002c68:     	cmpq	%rax, %r12
180002c6b:     	jl	0x180002c78 <numba_list_delete_slice+0x128>
180002c6d:     	movq	%r14, %rsi
180002c70:     	notq	%rsi
180002c73:     	addq	%rax, %rsi
180002c76:     	jmp	0x180002c7c <numba_list_delete_slice+0x12c>
180002c78:     	leaq	-0x1(%rdi), %rsi
180002c7c:     	movq	0x28(%rbx), %rax
180002c80:     	testq	%rax, %rax
180002c83:     	je	0x180002c93 <numba_list_delete_slice+0x143>
180002c85:     	movq	%r14, %rcx
180002c88:     	imulq	0x8(%rbx), %rcx
180002c8d:     	addq	0x30(%rbx), %rcx
180002c91:     	callq	*%rax
180002c93:     	movq	0x8(%rbx), %r9
180002c97:     	leaq	0x1(%r14), %rdx
180002c9b:     	movq	0x30(%rbx), %r10
180002c9f:     	movq	%r9, %r8
180002ca2:     	imulq	%rsi, %r8
180002ca6:     	imulq	%r9, %rdx
180002caa:     	movslq	0x60(%rsp), %rsi
180002caf:     	subq	%rsi, %r14
180002cb2:     	imulq	%r9, %r14
180002cb6:     	addq	%r10, %rdx
180002cb9:     	leaq	(%r10,%r14), %rcx
180002cbd:     	callq	0x180003c09 <numba_list_iter_next+0xe79>
180002cc2:     	incl	%esi
180002cc4:     	movq	%r12, %r14
180002cc7:     	movl	%esi, 0x60(%rsp)
180002ccb:     	cmpq	%rbp, %r12
180002cce:     	jl	0x180002c61 <numba_list_delete_slice+0x111>
180002cd0:     	movq	0x70(%rsp), %r12
180002cd5:     	movl	0x20(%rsp), %esi
180002cd9:     	movq	(%rbx), %r8
180002cdc:     	movq	0x30(%rsp), %r14
180002ce1:     	movslq	%r13d, %r10
180002ce4:     	movq	%r10, %rcx
180002ce7:     	imulq	%rdi, %rcx
180002ceb:     	addq	%r15, %rcx
180002cee:     	cmpq	%r8, %rcx
180002cf1:     	jge	0x180002d19 <numba_list_delete_slice+0x1c9>
180002cf3:     	movq	0x8(%rbx), %rax
180002cf7:     	subq	%rcx, %r8
180002cfa:     	movq	%rax, %rdx
180002cfd:     	imulq	%rcx, %rdx
180002d01:     	imulq	%rax, %r8
180002d05:     	subq	%r10, %rcx
180002d08:     	imulq	%rax, %rcx
180002d0c:     	addq	0x30(%rbx), %rdx
180002d10:     	addq	0x30(%rbx), %rcx
180002d14:     	callq	0x180003c09 <numba_list_iter_next+0xe79>
180002d19:     	movslq	%esi, %rdx
180002d1c:     	movq	%rbx, %rcx
180002d1f:     	callq	0x180002990 <numba_list_resize>
180002d24:     	movq	0x68(%rsp), %rsi
180002d29:     	xorl	%ecx, %ecx
180002d2b:     	movq	0x78(%rsp), %r13
180002d30:     	testl	%eax, %eax
180002d32:     	cmovsl	%eax, %ecx
180002d35:     	movl	%ecx, %eax
180002d37:     	addq	$0x38, %rsp
180002d3b:     	popq	%r15
180002d3d:     	popq	%rdi
180002d3e:     	popq	%rbp
180002d3f:     	popq	%rbx
180002d40:     	retq
180002d41:     	movq	0x78(%rsp), %r13
180002d46:     	xorl	%eax, %eax
180002d48:     	addq	$0x38, %rsp
180002d4c:     	popq	%r15
180002d4e:     	popq	%rdi
180002d4f:     	popq	%rbp
180002d50:     	popq	%rbx
180002d51:     	retq
180002d52:     	int3
180002d53:     	int3
180002d54:     	int3
180002d55:     	int3
180002d56:     	int3
180002d57:     	int3
180002d58:     	int3
180002d59:     	int3
180002d5a:     	int3
180002d5b:     	int3
180002d5c:     	int3
180002d5d:     	int3
180002d5e:     	int3
180002d5f:     	int3

0000000180002d60 <numba_list_iter_sizeof>:
180002d60:     	movl	$0x18, %eax
180002d65:     	retq
180002d66:     	int3
180002d67:     	int3
180002d68:     	int3
180002d69:     	int3
180002d6a:     	int3
180002d6b:     	int3
180002d6c:     	int3
180002d6d:     	int3
180002d6e:     	int3
180002d6f:     	int3

0000000180002d70 <numba_list_iter>:
180002d70:     	movq	%rdx, (%rcx)
180002d73:     	movq	(%rdx), %rax
180002d76:     	movq	%rax, 0x8(%rcx)
180002d7a:     	movq	$0x0, 0x10(%rcx)
180002d82:     	retq
180002d83:     	int3
180002d84:     	int3
180002d85:     	int3
180002d86:     	int3
180002d87:     	int3
180002d88:     	int3
180002d89:     	int3
180002d8a:     	int3
180002d8b:     	int3
180002d8c:     	int3
180002d8d:     	int3
180002d8e:     	int3
180002d8f:     	int3

0000000180002d90 <numba_list_iter_next>:
180002d90:     	movq	(%rcx), %r8
180002d93:     	movq	(%r8), %r9
180002d96:     	cmpq	0x8(%rcx), %r9
180002d9a:     	je	0x180002da2 <numba_list_iter_next+0x12>
180002d9c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002da1:     	retq
180002da2:     	movq	0x10(%rcx), %rax
180002da6:     	cmpq	%r9, %rax
180002da9:     	jge	0x180002dbe <numba_list_iter_next+0x2e>
180002dab:     	imulq	0x8(%r8), %rax
180002db0:     	addq	0x30(%r8), %rax
180002db4:     	movq	%rax, (%rdx)
180002db7:     	incq	0x10(%rcx)
180002dbb:     	xorl	%eax, %eax
180002dbd:     	retq
180002dbe:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002dc3:     	retq
180002dc4:     	int3
180002dc5:     	int3
180002dc6:     	int3
180002dc7:     	int3
180002dc8:     	int3
180002dc9:     	int3
180002dca:     	int3
180002dcb:     	int3
180002dcc:     	int3
180002dcd:     	int3
180002dce:     	int3
180002dcf:     	int3
180002dd0:     	pushq	%rbx
180002dd2:     	subq	$0x20, %rsp
180002dd6:     	movq	%rcx, %rbx
180002dd9:     	addq	$0x30, %rcx
180002ddd:     	callq	*0x7e45(%rip)           # 0x18000ac28
180002de3:     	cmpb	$0x0, 0x7e16(%rip)      # 0x18000ac00
180002dea:     	je	0x180002df4 <numba_list_iter_next+0x64>
180002dec:     	lock
180002ded:     	incq	0x7e14(%rip)            # 0x18000ac08
180002df4:     	testq	%rax, %rax
180002df7:     	je	0x180002e38 <numba_list_iter_next+0xa8>
180002df9:     	leaq	0x30(%rax), %rdx
180002dfd:     	testq	%rdx, %rdx
180002e00:     	je	0x180002e38 <numba_list_iter_next+0xa8>
180002e02:     	xorl	%r8d, %r8d
180002e05:     	movl	$0x1, %ecx
180002e0a:     	xchgq	%rcx, (%rax)
180002e0d:     	movq	%r8, 0x8(%rax)
180002e11:     	movq	%r8, 0x10(%rax)
180002e15:     	movq	%rdx, 0x18(%rax)
180002e19:     	movq	%rbx, 0x20(%rax)
180002e1d:     	movq	%r8, 0x28(%rax)
180002e21:     	cmpb	%r8b, 0x7dd8(%rip)      # 0x18000ac00
180002e28:     	je	0x180002e3a <numba_list_iter_next+0xaa>
180002e2a:     	lock
180002e2b:     	incq	0x7de6(%rip)            # 0x18000ac18
180002e32:     	addq	$0x20, %rsp
180002e36:     	popq	%rbx
180002e37:     	retq
180002e38:     	xorl	%eax, %eax
180002e3a:     	addq	$0x20, %rsp
180002e3e:     	popq	%rbx
180002e3f:     	retq
180002e40:     	movq	%rbx, 0x8(%rsp)
180002e45:     	pushq	%rdi
180002e46:     	subq	$0x20, %rsp
180002e4a:     	movq	%rcx, %rdi
180002e4d:     	movq	%rdx, %rbx
180002e50:     	addq	$0x30, %rcx
180002e54:     	testq	%rdx, %rdx
180002e57:     	je	0x180002e61 <numba_list_iter_next+0xd1>
180002e59:     	movq	0x18(%rdx), %rdx
180002e5d:     	callq	*(%rbx)
180002e5f:     	jmp	0x180002e67 <numba_list_iter_next+0xd7>
180002e61:     	callq	*0x7dc1(%rip)           # 0x18000ac28
180002e67:     	cmpb	$0x0, 0x7d92(%rip)      # 0x18000ac00
180002e6e:     	movq	%rax, %r8
180002e71:     	je	0x180002e7b <numba_list_iter_next+0xeb>
180002e73:     	lock
180002e74:     	incq	0x7d8d(%rip)            # 0x18000ac08
180002e7b:     	xorl	%edx, %edx
180002e7d:     	leaq	0x30(%r8), %rax
180002e81:     	testq	%r8, %r8
180002e84:     	movl	%edx, %ecx
180002e86:     	cmovneq	%rax, %rcx
180002e8a:     	testq	%rcx, %rcx
180002e8d:     	jne	0x180002e9c <numba_list_iter_next+0x10c>
180002e8f:     	xorl	%eax, %eax
180002e91:     	movq	0x30(%rsp), %rbx
180002e96:     	addq	$0x20, %rsp
180002e9a:     	popq	%rdi
180002e9b:     	retq
180002e9c:     	movl	$0x1, %eax
180002ea1:     	xchgq	%rax, (%r8)
180002ea4:     	movq	%rdx, 0x8(%r8)
180002ea8:     	movq	%rdx, 0x10(%r8)
180002eac:     	movq	%rcx, 0x18(%r8)
180002eb0:     	movq	%rdi, 0x20(%r8)
180002eb4:     	movq	%rbx, 0x28(%r8)
180002eb8:     	cmpb	%dl, 0x7d42(%rip)       # 0x18000ac00
180002ebe:     	je	0x180002ec8 <numba_list_iter_next+0x138>
180002ec0:     	lock
180002ec1:     	incq	0x7d50(%rip)            # 0x18000ac18
180002ec8:     	movq	0x30(%rsp), %rbx
180002ecd:     	movq	%r8, %rax
180002ed0:     	addq	$0x20, %rsp
180002ed4:     	popq	%rdi
180002ed5:     	retq
180002ed6:     	int3
180002ed7:     	int3
180002ed8:     	int3
180002ed9:     	int3
180002eda:     	int3
180002edb:     	int3
180002edc:     	int3
180002edd:     	int3
180002ede:     	int3
180002edf:     	int3
180002ee0:     	lock
180002ee1:     	incq	(%rcx)
180002ee4:     	retq
180002ee5:     	int3
180002ee6:     	int3
180002ee7:     	int3
180002ee8:     	int3
180002ee9:     	int3
180002eea:     	int3
180002eeb:     	int3
180002eec:     	int3
180002eed:     	int3
180002eee:     	int3
180002eef:     	int3
180002ef0:     	pushq	%rbx
180002ef2:     	subq	$0x20, %rsp
180002ef6:     	movq	0x8(%rcx), %rax
180002efa:     	movq	%rcx, %rbx
180002efd:     	testq	%rax, %rax
180002f00:     	je	0x180002f19 <numba_list_iter_next+0x189>
180002f02:     	cmpl	$0x0, 0x7cef(%rip)      # 0x18000abf8
180002f09:     	jne	0x180002f19 <numba_list_iter_next+0x189>
180002f0b:     	movq	0x10(%rcx), %r8
180002f0f:     	movq	0x20(%rcx), %rdx
180002f13:     	movq	0x18(%rcx), %rcx
180002f17:     	callq	*%rax
180002f19:     	movq	0x28(%rbx), %rax
180002f1d:     	movq	%rbx, %rcx
180002f20:     	testq	%rax, %rax
180002f23:     	je	0x180002f2e <numba_list_iter_next+0x19e>
180002f25:     	movq	0x18(%rax), %rdx
180002f29:     	callq	*0x10(%rax)
180002f2c:     	jmp	0x180002f34 <numba_list_iter_next+0x1a4>
180002f2e:     	callq	*0x7d04(%rip)           # 0x18000ac38
180002f34:     	cmpb	$0x0, 0x7cc5(%rip)      # 0x18000ac00
180002f3b:     	je	0x180002f59 <numba_list_iter_next+0x1c9>
180002f3d:     	leaq	0x7ccc(%rip), %rax      # 0x18000ac10
180002f44:     	lock
180002f45:     	incq	(%rax)
180002f48:     	cmpb	$0x0, 0x7cb1(%rip)      # 0x18000ac00
180002f4f:     	je	0x180002f59 <numba_list_iter_next+0x1c9>
180002f51:     	lock
180002f52:     	incq	0x7cc7(%rip)            # 0x18000ac20
180002f59:     	addq	$0x20, %rsp
180002f5d:     	popq	%rbx
180002f5e:     	retq
180002f5f:     	int3
180002f60:     	pushq	%rbx
180002f62:     	subq	$0x20, %rsp
180002f66:     	movq	%rcx, %rbx
180002f69:     	movq	$-0x1, %rax
180002f70:     	lock
180002f71:     	xaddq	%rax, (%rcx)
180002f75:     	cmpq	$0x1, %rax
180002f79:     	jne	0x180002fdb <numba_list_iter_next+0x24b>
180002f7b:     	movq	0x8(%rcx), %rax
180002f7f:     	testq	%rax, %rax
180002f82:     	je	0x180002f9b <numba_list_iter_next+0x20b>
180002f84:     	cmpl	$0x0, 0x7c6d(%rip)      # 0x18000abf8
180002f8b:     	jne	0x180002f9b <numba_list_iter_next+0x20b>
180002f8d:     	movq	0x10(%rcx), %r8
180002f91:     	movq	0x20(%rcx), %rdx
180002f95:     	movq	0x18(%rcx), %rcx
180002f99:     	callq	*%rax
180002f9b:     	movq	0x28(%rbx), %rax
180002f9f:     	movq	%rbx, %rcx
180002fa2:     	testq	%rax, %rax
180002fa5:     	je	0x180002fb0 <numba_list_iter_next+0x220>
180002fa7:     	movq	0x18(%rax), %rdx
180002fab:     	callq	*0x10(%rax)
180002fae:     	jmp	0x180002fb6 <numba_list_iter_next+0x226>
180002fb0:     	callq	*0x7c82(%rip)           # 0x18000ac38
180002fb6:     	cmpb	$0x0, 0x7c43(%rip)      # 0x18000ac00
180002fbd:     	je	0x180002fdb <numba_list_iter_next+0x24b>
180002fbf:     	leaq	0x7c4a(%rip), %rax      # 0x18000ac10
180002fc6:     	lock
180002fc7:     	incq	(%rax)
180002fca:     	cmpb	$0x0, 0x7c2f(%rip)      # 0x18000ac00
180002fd1:     	je	0x180002fdb <numba_list_iter_next+0x24b>
180002fd3:     	lock
180002fd4:     	incq	0x7c45(%rip)            # 0x18000ac20
180002fdb:     	addq	$0x20, %rsp
180002fdf:     	popq	%rbx
180002fe0:     	retq
180002fe1:     	int3
180002fe2:     	int3
180002fe3:     	int3
180002fe4:     	int3
180002fe5:     	int3
180002fe6:     	int3
180002fe7:     	int3
180002fe8:     	int3
180002fe9:     	int3
180002fea:     	int3
180002feb:     	int3
180002fec:     	int3
180002fed:     	int3
180002fee:     	int3
180002fef:     	int3
180002ff0:     	movq	0x18(%rcx), %rax
180002ff4:     	retq
180002ff5:     	int3
180002ff6:     	int3
180002ff7:     	int3
180002ff8:     	int3
180002ff9:     	int3
180002ffa:     	int3
180002ffb:     	int3
180002ffc:     	int3
180002ffd:     	int3
180002ffe:     	int3
180002fff:     	int3
180003000:     	jmpq	*%r8
180003003:     	int3
180003004:     	int3
180003005:     	int3
180003006:     	int3
180003007:     	int3
180003008:     	int3
180003009:     	int3
18000300a:     	int3
18000300b:     	int3
18000300c:     	int3
18000300d:     	int3
18000300e:     	int3
18000300f:     	int3
180003010:     	movq	%rbx, 0x8(%rsp)
180003015:     	pushq	%rdi
180003016:     	subq	$0x20, %rsp
18000301a:     	movq	%rcx, %rdi
18000301d:     	movq	%rdx, %rbx
180003020:     	movl	$0x30, %ecx
180003025:     	callq	*0x7bfd(%rip)           # 0x18000ac28
18000302b:     	cmpb	$0x0, 0x7bce(%rip)      # 0x18000ac00
180003032:     	je	0x18000303c <numba_list_iter_next+0x2ac>
180003034:     	lock
180003035:     	incq	0x7bcc(%rip)            # 0x18000ac08
18000303c:     	testq	%rax, %rax
18000303f:     	je	0x180003076 <numba_list_iter_next+0x2e6>
180003041:     	leaq	-0x48(%rip), %rcx       # 0x180003000 <numba_list_iter_next+0x270>
180003048:     	movl	$0x1, %edx
18000304d:     	xchgq	%rdx, (%rax)
180003050:     	movq	%rcx, 0x8(%rax)
180003054:     	xorl	%ecx, %ecx
180003056:     	movq	%rcx, 0x20(%rax)
18000305a:     	movq	%rcx, 0x28(%rax)
18000305e:     	movq	%rbx, 0x10(%rax)
180003062:     	movq	%rdi, 0x18(%rax)
180003066:     	cmpb	%cl, 0x7b94(%rip)       # 0x18000ac00
18000306c:     	je	0x180003076 <numba_list_iter_next+0x2e6>
18000306e:     	lock
18000306f:     	incq	0x7ba2(%rip)            # 0x18000ac18
180003076:     	movq	0x30(%rsp), %rbx
18000307b:     	addq	$0x20, %rsp
18000307f:     	popq	%rdi
180003080:     	retq
180003081:     	jmpq	*0x11e9(%rip)           # 0x180004270
180003087:     	jmpq	*0x11d3(%rip)           # 0x180004260
18000308d:     	jmpq	*0x11c5(%rip)           # 0x180004258
180003093:     	jmpq	*0x11b7(%rip)           # 0x180004250
180003099:     	jmpq	*0x11a9(%rip)           # 0x180004248
18000309f:     	jmpq	*0x119b(%rip)           # 0x180004240
1800030a5:     	jmpq	*0x1185(%rip)           # 0x180004230
1800030ab:     	jmpq	*0x116f(%rip)           # 0x180004220
1800030b1:     	jmpq	*0x1149(%rip)           # 0x180004200
1800030b7:     	int3
1800030b8:     	int3
1800030b9:     	int3
1800030ba:     	int3
1800030bb:     	int3
1800030bc:     	int3
1800030bd:     	int3
1800030be:     	int3
1800030bf:     	int3
1800030c0:     	int3
1800030c1:     	int3
1800030c2:     	int3
1800030c3:     	int3
1800030c4:     	int3
1800030c5:     	int3
1800030c6:     	nopw	(%rax,%rax)
1800030d0:     	cmpq	0x6fe9(%rip), %rcx      # 0x18000a0c0
1800030d7:     	jne	0x1800030e9 <numba_list_iter_next+0x359>
1800030d9:     	rolq	$0x10, %rcx
1800030dd:     	testw	$0xffff, %cx            # imm = 0xFFFF
1800030e2:     	jne	0x1800030e5 <numba_list_iter_next+0x355>
1800030e4:     	retq
1800030e5:     	rorq	$0x10, %rcx
1800030e9:     	jmp	0x180003444 <numba_list_iter_next+0x6b4>
1800030ee:     	int3
1800030ef:     	int3
1800030f0:     	subq	$0x28, %rsp
1800030f4:     	testl	%edx, %edx
1800030f6:     	je	0x180003131 <numba_list_iter_next+0x3a1>
1800030f8:     	subl	$0x1, %edx
1800030fb:     	je	0x180003125 <numba_list_iter_next+0x395>
1800030fd:     	subl	$0x1, %edx
180003100:     	je	0x180003118 <numba_list_iter_next+0x388>
180003102:     	cmpl	$0x1, %edx
180003105:     	je	0x180003111 <numba_list_iter_next+0x381>
180003107:     	movl	$0x1, %eax
18000310c:     	addq	$0x28, %rsp
180003110:     	retq
180003111:     	callq	0x180003610 <numba_list_iter_next+0x880>
180003116:     	jmp	0x18000311d <numba_list_iter_next+0x38d>
180003118:     	callq	0x1800035e8 <numba_list_iter_next+0x858>
18000311d:     	movzbl	%al, %eax
180003120:     	addq	$0x28, %rsp
180003124:     	retq
180003125:     	movq	%r8, %rdx
180003128:     	addq	$0x28, %rsp
18000312c:     	jmp	0x180003140 <numba_list_iter_next+0x3b0>
180003131:     	testq	%r8, %r8
180003134:     	setne	%cl
180003137:     	addq	$0x28, %rsp
18000313b:     	jmp	0x180003258 <numba_list_iter_next+0x4c8>
180003140:     	movq	%rbx, 0x8(%rsp)
180003145:     	movq	%rsi, 0x10(%rsp)
18000314a:     	movq	%rdi, 0x20(%rsp)
18000314f:     	pushq	%r14
180003151:     	subq	$0x20, %rsp
180003155:     	movq	%rdx, %rsi
180003158:     	movq	%rcx, %r14
18000315b:     	xorl	%ecx, %ecx
18000315d:     	callq	0x1800036cc <numba_list_iter_next+0x93c>
180003162:     	testb	%al, %al
180003164:     	je	0x180003232 <numba_list_iter_next+0x4a2>
18000316a:     	callq	0x180003560 <numba_list_iter_next+0x7d0>
18000316f:     	movb	%al, %bl
180003171:     	movb	%al, 0x40(%rsp)
180003175:     	movb	$0x1, %dil
180003178:     	cmpl	$0x0, 0x7849(%rip)      # 0x18000a9c8
18000317f:     	jne	0x18000324a <numba_list_iter_next+0x4ba>
180003185:     	movl	$0x1, 0x7839(%rip)      # 0x18000a9c8
18000318f:     	callq	0x1800035d0 <numba_list_iter_next+0x840>
180003194:     	testb	%al, %al
180003196:     	je	0x1800031e7 <numba_list_iter_next+0x457>
180003198:     	callq	0x18000388c <numba_list_iter_next+0xafc>
18000319d:     	callq	0x180003520 <numba_list_iter_next+0x790>
1800031a2:     	callq	0x180003544 <numba_list_iter_next+0x7b4>
1800031a7:     	leaq	0x1122(%rip), %rdx      # 0x1800042d0
1800031ae:     	leaq	0x1113(%rip), %rcx      # 0x1800042c8
1800031b5:     	callq	0x180003bd2 <numba_list_iter_next+0xe42>
1800031ba:     	testl	%eax, %eax
1800031bc:     	jne	0x1800031e7 <numba_list_iter_next+0x457>
1800031be:     	callq	0x18000359c <numba_list_iter_next+0x80c>
1800031c3:     	testb	%al, %al
1800031c5:     	je	0x1800031e7 <numba_list_iter_next+0x457>
1800031c7:     	leaq	0x10f2(%rip), %rdx      # 0x1800042c0
1800031ce:     	leaq	0x10e3(%rip), %rcx      # 0x1800042b8
1800031d5:     	callq	0x180003bcc <numba_list_iter_next+0xe3c>
1800031da:     	movl	$0x2, 0x77e4(%rip)      # 0x18000a9c8
1800031e4:     	xorb	%dil, %dil
1800031e7:     	movb	%bl, %cl
1800031e9:     	callq	0x18000382c <numba_list_iter_next+0xa9c>
1800031ee:     	testb	%dil, %dil
1800031f1:     	jne	0x180003232 <numba_list_iter_next+0x4a2>
1800031f3:     	callq	0x18000387c <numba_list_iter_next+0xaec>
1800031f8:     	movq	%rax, %rbx
1800031fb:     	cmpq	$0x0, (%rax)
1800031ff:     	je	0x180003225 <numba_list_iter_next+0x495>
180003201:     	movq	%rax, %rcx
180003204:     	callq	0x180003794 <numba_list_iter_next+0xa04>
180003209:     	testb	%al, %al
18000320b:     	je	0x180003225 <numba_list_iter_next+0x495>
18000320d:     	movq	%rsi, %r8
180003210:     	movl	$0x2, %edx
180003215:     	movq	%r14, %rcx
180003218:     	movq	(%rbx), %rax
18000321b:     	movq	0x106e(%rip), %r9       # 0x180004290
180003222:     	callq	*%r9
180003225:     	incl	0x7775(%rip)            # 0x18000a9a0
18000322b:     	movl	$0x1, %eax
180003230:     	jmp	0x180003234 <numba_list_iter_next+0x4a4>
180003232:     	xorl	%eax, %eax
180003234:     	movq	0x30(%rsp), %rbx
180003239:     	movq	0x38(%rsp), %rsi
18000323e:     	movq	0x48(%rsp), %rdi
180003243:     	addq	$0x20, %rsp
180003247:     	popq	%r14
180003249:     	retq
18000324a:     	movl	$0x7, %ecx
18000324f:     	callq	0x180003884 <numba_list_iter_next+0xaf4>
180003254:     	nop
180003255:     	int3
180003256:     	int3
180003257:     	int3
180003258:     	movq	%rbx, 0x8(%rsp)
18000325d:     	pushq	%rdi
18000325e:     	subq	$0x30, %rsp
180003262:     	movb	%cl, %dil
180003265:     	movl	0x7735(%rip), %eax      # 0x18000a9a0
18000326b:     	testl	%eax, %eax
18000326d:     	jg	0x18000327c <numba_list_iter_next+0x4ec>
18000326f:     	xorl	%eax, %eax
180003271:     	movq	0x40(%rsp), %rbx
180003276:     	addq	$0x30, %rsp
18000327a:     	popq	%rdi
18000327b:     	retq
18000327c:     	decl	%eax
18000327e:     	movl	%eax, 0x771c(%rip)      # 0x18000a9a0
180003284:     	callq	0x180003560 <numba_list_iter_next+0x7d0>
180003289:     	movb	%al, %bl
18000328b:     	movb	%al, 0x20(%rsp)
18000328f:     	cmpl	$0x2, 0x7732(%rip)      # 0x18000a9c8
180003296:     	jne	0x1800032ce <numba_list_iter_next+0x53e>
180003298:     	callq	0x180003688 <numba_list_iter_next+0x8f8>
18000329d:     	callq	0x180003530 <numba_list_iter_next+0x7a0>
1800032a2:     	callq	0x1800038c8 <numba_list_iter_next+0xb38>
1800032a7:     	movl	$0x0, 0x7717(%rip)      # 0x18000a9c8
1800032b1:     	movb	%bl, %cl
1800032b3:     	callq	0x18000382c <numba_list_iter_next+0xa9c>
1800032b8:     	xorl	%edx, %edx
1800032ba:     	movb	%dil, %cl
1800032bd:     	callq	0x180003850 <numba_list_iter_next+0xac0>
1800032c2:     	movzbl	%al, %ebx
1800032c5:     	callq	0x1800036b8 <numba_list_iter_next+0x928>
1800032ca:     	movl	%ebx, %eax
1800032cc:     	jmp	0x180003271 <numba_list_iter_next+0x4e1>
1800032ce:     	movl	$0x7, %ecx
1800032d3:     	callq	0x180003884 <numba_list_iter_next+0xaf4>
1800032d8:     	nop
1800032d9:     	nop
1800032da:     	int3
1800032db:     	int3
1800032dc:     	movq	%rsp, %rax
1800032df:     	movq	%rbx, 0x20(%rax)
1800032e3:     	movq	%r8, 0x18(%rax)
1800032e7:     	movl	%edx, 0x10(%rax)
1800032ea:     	movq	%rcx, 0x8(%rax)
1800032ee:     	pushq	%rsi
1800032ef:     	pushq	%rdi
1800032f0:     	pushq	%r14
1800032f2:     	subq	$0x40, %rsp
1800032f6:     	movq	%r8, %rsi
1800032f9:     	movl	%edx, %edi
1800032fb:     	movq	%rcx, %r14
1800032fe:     	testl	%edx, %edx
180003300:     	jne	0x180003311 <numba_list_iter_next+0x581>
180003302:     	cmpl	%edx, 0x7698(%rip)      # 0x18000a9a0
180003308:     	jg	0x180003311 <numba_list_iter_next+0x581>
18000330a:     	xorl	%eax, %eax
18000330c:     	jmp	0x1800033f6 <numba_list_iter_next+0x666>
180003311:     	leal	-0x1(%rdx), %eax
180003314:     	cmpl	$0x1, %eax
180003317:     	ja	0x180003359 <numba_list_iter_next+0x5c9>
180003319:     	movq	0x12b8(%rip), %rax      # 0x1800045d8
180003320:     	testq	%rax, %rax
180003323:     	jne	0x18000332a <numba_list_iter_next+0x59a>
180003325:     	leal	0x1(%rax), %ebx
180003328:     	jmp	0x180003332 <numba_list_iter_next+0x5a2>
18000332a:     	callq	*0xf60(%rip)            # 0x180004290
180003330:     	movl	%eax, %ebx
180003332:     	movl	%ebx, 0x30(%rsp)
180003336:     	testl	%ebx, %ebx
180003338:     	je	0x1800033ec <numba_list_iter_next+0x65c>
18000333e:     	movq	%rsi, %r8
180003341:     	movl	%edi, %edx
180003343:     	movq	%r14, %rcx
180003346:     	callq	0x1800030f0 <numba_list_iter_next+0x360>
18000334b:     	movl	%eax, %ebx
18000334d:     	movl	%eax, 0x30(%rsp)
180003351:     	testl	%eax, %eax
180003353:     	je	0x1800033ec <numba_list_iter_next+0x65c>
180003359:     	movq	%rsi, %r8
18000335c:     	movl	%edi, %edx
18000335e:     	movq	%r14, %rcx
180003361:     	callq	0x1800034fc <numba_list_iter_next+0x76c>
180003366:     	movl	%eax, %ebx
180003368:     	movl	%eax, 0x30(%rsp)
18000336c:     	cmpl	$0x1, %edi
18000336f:     	jne	0x1800033a7 <numba_list_iter_next+0x617>
180003371:     	testl	%eax, %eax
180003373:     	jne	0x1800033a7 <numba_list_iter_next+0x617>
180003375:     	movq	%rsi, %r8
180003378:     	xorl	%edx, %edx
18000337a:     	movq	%r14, %rcx
18000337d:     	callq	0x1800034fc <numba_list_iter_next+0x76c>
180003382:     	testq	%rsi, %rsi
180003385:     	setne	%cl
180003388:     	callq	0x180003258 <numba_list_iter_next+0x4c8>
18000338d:     	movq	0x1244(%rip), %rax      # 0x1800045d8
180003394:     	testq	%rax, %rax
180003397:     	je	0x1800033a7 <numba_list_iter_next+0x617>
180003399:     	movq	%rsi, %r8
18000339c:     	xorl	%edx, %edx
18000339e:     	movq	%r14, %rcx
1800033a1:     	callq	*0xee9(%rip)            # 0x180004290
1800033a7:     	testl	%edi, %edi
1800033a9:     	je	0x1800033b0 <numba_list_iter_next+0x620>
1800033ab:     	cmpl	$0x3, %edi
1800033ae:     	jne	0x1800033ec <numba_list_iter_next+0x65c>
1800033b0:     	movq	%rsi, %r8
1800033b3:     	movl	%edi, %edx
1800033b5:     	movq	%r14, %rcx
1800033b8:     	callq	0x1800030f0 <numba_list_iter_next+0x360>
1800033bd:     	movl	%eax, %ebx
1800033bf:     	movl	%eax, 0x30(%rsp)
1800033c3:     	testl	%eax, %eax
1800033c5:     	je	0x1800033ec <numba_list_iter_next+0x65c>
1800033c7:     	movq	0x120a(%rip), %rax      # 0x1800045d8
1800033ce:     	testq	%rax, %rax
1800033d1:     	jne	0x1800033d8 <numba_list_iter_next+0x648>
1800033d3:     	leal	0x1(%rax), %ebx
1800033d6:     	jmp	0x1800033e8 <numba_list_iter_next+0x658>
1800033d8:     	movq	%rsi, %r8
1800033db:     	movl	%edi, %edx
1800033dd:     	movq	%r14, %rcx
1800033e0:     	callq	*0xeaa(%rip)            # 0x180004290
1800033e6:     	movl	%eax, %ebx
1800033e8:     	movl	%ebx, 0x30(%rsp)
1800033ec:     	jmp	0x1800033f4 <numba_list_iter_next+0x664>
1800033ee:     	xorl	%ebx, %ebx
1800033f0:     	movl	%ebx, 0x30(%rsp)
1800033f4:     	movl	%ebx, %eax
1800033f6:     	movq	0x78(%rsp), %rbx
1800033fb:     	addq	$0x40, %rsp
1800033ff:     	popq	%r14
180003401:     	popq	%rdi
180003402:     	popq	%rsi
180003403:     	retq
180003404:     	movq	%rbx, 0x8(%rsp)
180003409:     	movq	%rsi, 0x10(%rsp)
18000340e:     	pushq	%rdi
18000340f:     	subq	$0x20, %rsp
180003413:     	movq	%r8, %rdi
180003416:     	movl	%edx, %ebx
180003418:     	movq	%rcx, %rsi
18000341b:     	cmpl	$0x1, %edx
18000341e:     	jne	0x180003425 <numba_list_iter_next+0x695>
180003420:     	callq	0x18000344c <numba_list_iter_next+0x6bc>
180003425:     	movq	%rdi, %r8
180003428:     	movl	%ebx, %edx
18000342a:     	movq	%rsi, %rcx
18000342d:     	movq	0x30(%rsp), %rbx
180003432:     	movq	0x38(%rsp), %rsi
180003437:     	addq	$0x20, %rsp
18000343b:     	popq	%rdi
18000343c:     	jmp	0x1800032dc <numba_list_iter_next+0x54c>
180003441:     	int3
180003442:     	int3
180003443:     	int3
180003444:     	movl	$0x2, %ecx
180003449:     	int	$0x29
18000344b:     	retq
18000344c:     	movq	%rbx, 0x18(%rsp)
180003451:     	pushq	%rbp
180003452:     	movq	%rsp, %rbp
180003455:     	subq	$0x30, %rsp
180003459:     	movq	0x6c60(%rip), %rax      # 0x18000a0c0
180003460:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000346a:     	cmpq	%rbx, %rax
18000346d:     	jne	0x1800034e6 <numba_list_iter_next+0x756>
18000346f:     	leaq	0x10(%rbp), %rcx
180003473:     	movq	$0x0, 0x10(%rbp)
18000347b:     	callq	*0xb9f(%rip)            # 0x180004020
180003481:     	movq	0x10(%rbp), %rax
180003485:     	movq	%rax, -0x10(%rbp)
180003489:     	callq	*0xb89(%rip)            # 0x180004018
18000348f:     	movl	%eax, %eax
180003491:     	xorq	%rax, -0x10(%rbp)
180003495:     	callq	*0xb75(%rip)            # 0x180004010
18000349b:     	movl	%eax, %eax
18000349d:     	leaq	0x18(%rbp), %rcx
1800034a1:     	xorq	%rax, -0x10(%rbp)
1800034a5:     	callq	*0xb55(%rip)            # 0x180004000
1800034ab:     	movl	0x18(%rbp), %eax
1800034ae:     	leaq	-0x10(%rbp), %rcx
1800034b2:     	shlq	$0x20, %rax
1800034b6:     	xorq	0x18(%rbp), %rax
1800034ba:     	xorq	-0x10(%rbp), %rax
1800034be:     	xorq	%rcx, %rax
1800034c1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
1800034cb:     	andq	%rcx, %rax
1800034ce:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
1800034d8:     	cmpq	%rbx, %rax
1800034db:     	cmoveq	%rcx, %rax
1800034df:     	movq	%rax, 0x6bda(%rip)      # 0x18000a0c0
1800034e6:     	movq	0x50(%rsp), %rbx
1800034eb:     	notq	%rax
1800034ee:     	movq	%rax, 0x6c0b(%rip)      # 0x18000a100
1800034f5:     	addq	$0x30, %rsp
1800034f9:     	popq	%rbp
1800034fa:     	retq
1800034fb:     	int3
1800034fc:     	subq	$0x28, %rsp
180003500:     	cmpl	$0x1, %edx
180003503:     	jne	0x180003515 <numba_list_iter_next+0x785>
180003505:     	cmpq	$0x0, 0x10cb(%rip)      # 0x1800045d8
18000350d:     	jne	0x180003515 <numba_list_iter_next+0x785>
18000350f:     	callq	*0xb13(%rip)            # 0x180004028
180003515:     	movl	$0x1, %eax
18000351a:     	addq	$0x28, %rsp
18000351e:     	retq
18000351f:     	int3
180003520:     	leaq	0x7489(%rip), %rcx      # 0x18000a9b0
180003527:     	jmpq	*0xada(%rip)            # 0x180004008
18000352e:     	int3
18000352f:     	int3
180003530:     	leaq	0x7479(%rip), %rcx      # 0x18000a9b0
180003537:     	jmp	0x180003bc6 <numba_list_iter_next+0xe36>
18000353c:     	leaq	0x747d(%rip), %rax      # 0x18000a9c0
180003543:     	retq
180003544:     	subq	$0x28, %rsp
180003548:     	callq	0x1800026a0 <PyInit_rcnumeric_202f683b665d056f07b8d3ed+0x10e0>
18000354d:     	orq	$0x24, (%rax)
180003551:     	callq	0x18000353c <numba_list_iter_next+0x7ac>
180003556:     	orq	$0x2, (%rax)
18000355a:     	addq	$0x28, %rsp
18000355e:     	retq
18000355f:     	int3
180003560:     	subq	$0x28, %rsp
180003564:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
180003569:     	testl	%eax, %eax
18000356b:     	je	0x18000358e <numba_list_iter_next+0x7fe>
18000356d:     	movq	%gs:0x30, %rax
180003576:     	movq	0x8(%rax), %rcx
18000357a:     	jmp	0x180003581 <numba_list_iter_next+0x7f1>
18000357c:     	cmpq	%rax, %rcx
18000357f:     	je	0x180003595 <numba_list_iter_next+0x805>
180003581:     	xorl	%eax, %eax
180003583:     	lock
180003584:     	cmpxchgq	%rcx, 0x7444(%rip)      # 0x18000a9d0
18000358c:     	jne	0x18000357c <numba_list_iter_next+0x7ec>
18000358e:     	xorb	%al, %al
180003590:     	addq	$0x28, %rsp
180003594:     	retq
180003595:     	movb	$0x1, %al
180003597:     	jmp	0x180003590 <numba_list_iter_next+0x800>
180003599:     	int3
18000359a:     	int3
18000359b:     	int3
18000359c:     	subq	$0x28, %rsp
1800035a0:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
1800035a5:     	testl	%eax, %eax
1800035a7:     	je	0x1800035b0 <numba_list_iter_next+0x820>
1800035a9:     	callq	0x180003908 <numba_list_iter_next+0xb78>
1800035ae:     	jmp	0x1800035c9 <numba_list_iter_next+0x839>
1800035b0:     	callq	0x180003ba4 <numba_list_iter_next+0xe14>
1800035b5:     	movl	%eax, %ecx
1800035b7:     	callq	0x180003bde <numba_list_iter_next+0xe4e>
1800035bc:     	testl	%eax, %eax
1800035be:     	je	0x1800035c4 <numba_list_iter_next+0x834>
1800035c0:     	xorb	%al, %al
1800035c2:     	jmp	0x1800035cb <numba_list_iter_next+0x83b>
1800035c4:     	callq	0x180003be4 <numba_list_iter_next+0xe54>
1800035c9:     	movb	$0x1, %al
1800035cb:     	addq	$0x28, %rsp
1800035cf:     	retq
1800035d0:     	subq	$0x28, %rsp
1800035d4:     	xorl	%ecx, %ecx
1800035d6:     	callq	0x180003708 <numba_list_iter_next+0x978>
1800035db:     	testb	%al, %al
1800035dd:     	setne	%al
1800035e0:     	addq	$0x28, %rsp
1800035e4:     	retq
1800035e5:     	int3
1800035e6:     	int3
1800035e7:     	int3
1800035e8:     	subq	$0x28, %rsp
1800035ec:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800035f1:     	testb	%al, %al
1800035f3:     	jne	0x1800035f9 <numba_list_iter_next+0x869>
1800035f5:     	xorb	%al, %al
1800035f7:     	jmp	0x18000360b <numba_list_iter_next+0x87b>
1800035f9:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800035fe:     	testb	%al, %al
180003600:     	jne	0x180003609 <numba_list_iter_next+0x879>
180003602:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
180003607:     	jmp	0x1800035f5 <numba_list_iter_next+0x865>
180003609:     	movb	$0x1, %al
18000360b:     	addq	$0x28, %rsp
18000360f:     	retq
180003610:     	subq	$0x28, %rsp
180003614:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
180003619:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
18000361e:     	movb	$0x1, %al
180003620:     	addq	$0x28, %rsp
180003624:     	retq
180003625:     	int3
180003626:     	int3
180003627:     	int3
180003628:     	movq	%rbx, 0x8(%rsp)
18000362d:     	movq	%rbp, 0x10(%rsp)
180003632:     	movq	%rsi, 0x18(%rsp)
180003637:     	pushq	%rdi
180003638:     	subq	$0x20, %rsp
18000363c:     	movq	%r9, %rdi
18000363f:     	movq	%r8, %rsi
180003642:     	movl	%edx, %ebx
180003644:     	movq	%rcx, %rbp
180003647:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
18000364c:     	testl	%eax, %eax
18000364e:     	jne	0x180003666 <numba_list_iter_next+0x8d6>
180003650:     	cmpl	$0x1, %ebx
180003653:     	jne	0x180003666 <numba_list_iter_next+0x8d6>
180003655:     	movq	%rsi, %r8
180003658:     	xorl	%edx, %edx
18000365a:     	movq	%rbp, %rcx
18000365d:     	movq	%rdi, %rax
180003660:     	callq	*0xc2a(%rip)            # 0x180004290
180003666:     	movq	0x58(%rsp), %rdx
18000366b:     	movl	0x50(%rsp), %ecx
18000366f:     	movq	0x30(%rsp), %rbx
180003674:     	movq	0x38(%rsp), %rbp
180003679:     	movq	0x40(%rsp), %rsi
18000367e:     	addq	$0x20, %rsp
180003682:     	popq	%rdi
180003683:     	jmp	0x180003bd8 <numba_list_iter_next+0xe48>
180003688:     	subq	$0x28, %rsp
18000368c:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
180003691:     	testl	%eax, %eax
180003693:     	je	0x1800036a5 <numba_list_iter_next+0x915>
180003695:     	leaq	0x7344(%rip), %rcx      # 0x18000a9e0
18000369c:     	addq	$0x28, %rsp
1800036a0:     	jmp	0x180003bf0 <numba_list_iter_next+0xe60>
1800036a5:     	callq	0x180003c00 <numba_list_iter_next+0xe70>
1800036aa:     	testl	%eax, %eax
1800036ac:     	jne	0x1800036b3 <numba_list_iter_next+0x923>
1800036ae:     	callq	0x180003bf6 <numba_list_iter_next+0xe66>
1800036b3:     	addq	$0x28, %rsp
1800036b7:     	retq
1800036b8:     	subq	$0x28, %rsp
1800036bc:     	xorl	%ecx, %ecx
1800036be:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800036c3:     	addq	$0x28, %rsp
1800036c7:     	jmp	0x180003bfc <numba_list_iter_next+0xe6c>
1800036cc:     	subq	$0x28, %rsp
1800036d0:     	testl	%ecx, %ecx
1800036d2:     	jne	0x1800036db <numba_list_iter_next+0x94b>
1800036d4:     	movb	$0x1, 0x72fd(%rip)      # 0x18000a9d8
1800036db:     	callq	0x180003908 <numba_list_iter_next+0xb78>
1800036e0:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800036e5:     	testb	%al, %al
1800036e7:     	jne	0x1800036ed <numba_list_iter_next+0x95d>
1800036e9:     	xorb	%al, %al
1800036eb:     	jmp	0x180003701 <numba_list_iter_next+0x971>
1800036ed:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800036f2:     	testb	%al, %al
1800036f4:     	jne	0x1800036ff <numba_list_iter_next+0x96f>
1800036f6:     	xorl	%ecx, %ecx
1800036f8:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
1800036fd:     	jmp	0x1800036e9 <numba_list_iter_next+0x959>
1800036ff:     	movb	$0x1, %al
180003701:     	addq	$0x28, %rsp
180003705:     	retq
180003706:     	int3
180003707:     	int3
180003708:     	pushq	%rbx
18000370a:     	subq	$0x20, %rsp
18000370e:     	cmpb	$0x0, 0x72c4(%rip)      # 0x18000a9d9
180003715:     	movl	%ecx, %ebx
180003717:     	jne	0x180003780 <numba_list_iter_next+0x9f0>
180003719:     	cmpl	$0x1, %ecx
18000371c:     	ja	0x180003788 <numba_list_iter_next+0x9f8>
18000371e:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
180003723:     	testl	%eax, %eax
180003725:     	je	0x18000374f <numba_list_iter_next+0x9bf>
180003727:     	testl	%ebx, %ebx
180003729:     	jne	0x18000374f <numba_list_iter_next+0x9bf>
18000372b:     	leaq	0x72ae(%rip), %rcx      # 0x18000a9e0
180003732:     	callq	0x180003bea <numba_list_iter_next+0xe5a>
180003737:     	testl	%eax, %eax
180003739:     	jne	0x18000374b <numba_list_iter_next+0x9bb>
18000373b:     	leaq	0x72b6(%rip), %rcx      # 0x18000a9f8
180003742:     	callq	0x180003bea <numba_list_iter_next+0xe5a>
180003747:     	testl	%eax, %eax
180003749:     	je	0x180003779 <numba_list_iter_next+0x9e9>
18000374b:     	xorb	%al, %al
18000374d:     	jmp	0x180003782 <numba_list_iter_next+0x9f2>
18000374f:     	movdqa	0xe89(%rip), %xmm0      # 0x1800045e0
180003757:     	orq	$-0x1, %rax
18000375b:     	movdqu	%xmm0, 0x727d(%rip)     # 0x18000a9e0
180003763:     	movq	%rax, 0x7286(%rip)      # 0x18000a9f0
18000376a:     	movdqu	%xmm0, 0x7286(%rip)     # 0x18000a9f8
180003772:     	movq	%rax, 0x728f(%rip)      # 0x18000aa08
180003779:     	movb	$0x1, 0x7259(%rip)      # 0x18000a9d9
180003780:     	movb	$0x1, %al
180003782:     	addq	$0x20, %rsp
180003786:     	popq	%rbx
180003787:     	retq
180003788:     	movl	$0x5, %ecx
18000378d:     	callq	0x180003884 <numba_list_iter_next+0xaf4>
180003792:     	int3
180003793:     	int3
180003794:     	subq	$0x18, %rsp
180003798:     	movq	%rcx, %r8
18000379b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
1800037a0:     	cmpw	%ax, -0x37a7(%rip)      # 0x180000000
1800037a7:     	jne	0x180003821 <numba_list_iter_next+0xa91>
1800037a9:     	movslq	-0x3774(%rip), %rcx     # 0x18000003c
1800037b0:     	leaq	-0x37b7(%rip), %rdx     # 0x180000000
1800037b7:     	addq	%rdx, %rcx
1800037ba:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
1800037c0:     	jne	0x180003821 <numba_list_iter_next+0xa91>
1800037c2:     	movl	$0x20b, %eax            # imm = 0x20B
1800037c7:     	cmpw	%ax, 0x18(%rcx)
1800037cb:     	jne	0x180003821 <numba_list_iter_next+0xa91>
1800037cd:     	subq	%rdx, %r8
1800037d0:     	movzwl	0x14(%rcx), %edx
1800037d4:     	addq	$0x18, %rdx
1800037d8:     	addq	%rcx, %rdx
1800037db:     	movzwl	0x6(%rcx), %eax
1800037df:     	leaq	(%rax,%rax,4), %rcx
1800037e3:     	leaq	(%rdx,%rcx,8), %r9
1800037e7:     	movq	%rdx, (%rsp)
1800037eb:     	cmpq	%r9, %rdx
1800037ee:     	je	0x180003808 <numba_list_iter_next+0xa78>
1800037f0:     	movl	0xc(%rdx), %ecx
1800037f3:     	cmpq	%rcx, %r8
1800037f6:     	jb	0x180003802 <numba_list_iter_next+0xa72>
1800037f8:     	movl	0x8(%rdx), %eax
1800037fb:     	addl	%ecx, %eax
1800037fd:     	cmpq	%rax, %r8
180003800:     	jb	0x18000380a <numba_list_iter_next+0xa7a>
180003802:     	addq	$0x28, %rdx
180003806:     	jmp	0x1800037e7 <numba_list_iter_next+0xa57>
180003808:     	xorl	%edx, %edx
18000380a:     	testq	%rdx, %rdx
18000380d:     	jne	0x180003813 <numba_list_iter_next+0xa83>
18000380f:     	xorb	%al, %al
180003811:     	jmp	0x180003827 <numba_list_iter_next+0xa97>
180003813:     	cmpl	$0x0, 0x24(%rdx)
180003817:     	jge	0x18000381d <numba_list_iter_next+0xa8d>
180003819:     	xorb	%al, %al
18000381b:     	jmp	0x180003827 <numba_list_iter_next+0xa97>
18000381d:     	movb	$0x1, %al
18000381f:     	jmp	0x180003827 <numba_list_iter_next+0xa97>
180003821:     	xorb	%al, %al
180003823:     	jmp	0x180003827 <numba_list_iter_next+0xa97>
180003825:     	xorb	%al, %al
180003827:     	addq	$0x18, %rsp
18000382b:     	retq
18000382c:     	pushq	%rbx
18000382e:     	subq	$0x20, %rsp
180003832:     	movb	%cl, %bl
180003834:     	callq	0x180003bac <numba_list_iter_next+0xe1c>
180003839:     	xorl	%edx, %edx
18000383b:     	testl	%eax, %eax
18000383d:     	je	0x18000384a <numba_list_iter_next+0xaba>
18000383f:     	testb	%bl, %bl
180003841:     	jne	0x18000384a <numba_list_iter_next+0xaba>
180003843:     	xchgq	%rdx, 0x7186(%rip)      # 0x18000a9d0
18000384a:     	addq	$0x20, %rsp
18000384e:     	popq	%rbx
18000384f:     	retq
180003850:     	pushq	%rbx
180003852:     	subq	$0x20, %rsp
180003856:     	cmpb	$0x0, 0x717b(%rip)      # 0x18000a9d8
18000385d:     	movb	%cl, %bl
18000385f:     	je	0x180003865 <numba_list_iter_next+0xad5>
180003861:     	testb	%dl, %dl
180003863:     	jne	0x180003871 <numba_list_iter_next+0xae1>
180003865:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
18000386a:     	movb	%bl, %cl
18000386c:     	callq	0x180003bfc <numba_list_iter_next+0xe6c>
180003871:     	movb	$0x1, %al
180003873:     	addq	$0x20, %rsp
180003877:     	popq	%rbx
180003878:     	retq
180003879:     	int3
18000387a:     	int3
18000387b:     	int3
18000387c:     	leaq	0x73e5(%rip), %rax      # 0x18000ac68
180003883:     	retq
180003884:     	movl	%ecx, %ecx
180003886:     	int	$0x29
180003888:     	retq
180003889:     	int3
18000388a:     	int3
18000388b:     	int3
18000388c:     	movq	%rbx, 0x8(%rsp)
180003891:     	pushq	%rdi
180003892:     	subq	$0x20, %rsp
180003896:     	leaq	0x3723(%rip), %rbx      # 0x180006fc0
18000389d:     	leaq	0x371c(%rip), %rdi      # 0x180006fc0
1800038a4:     	jmp	0x1800038b8 <numba_list_iter_next+0xb28>
1800038a6:     	movq	(%rbx), %rax
1800038a9:     	testq	%rax, %rax
1800038ac:     	je	0x1800038b4 <numba_list_iter_next+0xb24>
1800038ae:     	callq	*0x9dc(%rip)            # 0x180004290
1800038b4:     	addq	$0x8, %rbx
1800038b8:     	cmpq	%rdi, %rbx
1800038bb:     	jb	0x1800038a6 <numba_list_iter_next+0xb16>
1800038bd:     	movq	0x30(%rsp), %rbx
1800038c2:     	addq	$0x20, %rsp
1800038c6:     	popq	%rdi
1800038c7:     	retq
1800038c8:     	movq	%rbx, 0x8(%rsp)
1800038cd:     	pushq	%rdi
1800038ce:     	subq	$0x20, %rsp
1800038d2:     	leaq	0x36f7(%rip), %rbx      # 0x180006fd0
1800038d9:     	leaq	0x36f0(%rip), %rdi      # 0x180006fd0
1800038e0:     	jmp	0x1800038f4 <numba_list_iter_next+0xb64>
1800038e2:     	movq	(%rbx), %rax
1800038e5:     	testq	%rax, %rax
1800038e8:     	je	0x1800038f0 <numba_list_iter_next+0xb60>
1800038ea:     	callq	*0x9a0(%rip)            # 0x180004290
1800038f0:     	addq	$0x8, %rbx
1800038f4:     	cmpq	%rdi, %rbx
1800038f7:     	jb	0x1800038e2 <numba_list_iter_next+0xb52>
1800038f9:     	movq	0x30(%rsp), %rbx
1800038fe:     	addq	$0x20, %rsp
180003902:     	popq	%rdi
180003903:     	retq
180003904:     	retq	$0x0
180003907:     	int3
180003908:     	movq	%rbx, 0x10(%rsp)
18000390d:     	movq	%rbp, 0x18(%rsp)
180003912:     	movq	%rsi, 0x20(%rsp)
180003917:     	pushq	%rdi
180003918:     	subq	$0x10, %rsp
18000391c:     	xorl	%eax, %eax
18000391e:     	xorl	%ecx, %ecx
180003920:     	cpuid
180003922:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003928:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000392e:     	orl	%ecx, %edx
180003930:     	movl	%eax, %ebp
180003932:     	movl	$0x1, %eax
180003937:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000393d:     	orl	%ebx, %edx
18000393f:     	leal	-0x1(%rax), %ecx
180003942:     	cpuid
180003944:     	movl	%ecx, %edi
180003946:     	jne	0x1800039a6 <numba_list_iter_next+0xc16>
180003948:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000394d:     	movq	$0x8000, 0x67c0(%rip)   # imm = 0x8000
                                                # 0x18000a118
180003958:     	movq	$-0x1, 0x67bd(%rip)     # 0x18000a120
180003963:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180003968:     	je	0x180003992 <numba_list_iter_next+0xc02>
18000396a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000396f:     	je	0x180003992 <numba_list_iter_next+0xc02>
180003971:     	cmpl	$0x20670, %eax          # imm = 0x20670
180003976:     	je	0x180003992 <numba_list_iter_next+0xc02>
180003978:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000397d:     	cmpl	$0x20, %eax
180003980:     	ja	0x1800039a6 <numba_list_iter_next+0xc16>
180003982:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000398c:     	btq	%rax, %rcx
180003990:     	jae	0x1800039a6 <numba_list_iter_next+0xc16>
180003992:     	movl	0x707b(%rip), %r8d      # 0x18000aa14
180003999:     	orl	$0x1, %r8d
18000399d:     	movl	%r8d, 0x7070(%rip)      # 0x18000aa14
1800039a4:     	jmp	0x1800039ad <numba_list_iter_next+0xc1d>
1800039a6:     	movl	0x7067(%rip), %r8d      # 0x18000aa14
1800039ad:     	xorl	%r9d, %r9d
1800039b0:     	movl	%r9d, %r11d
1800039b3:     	cmpl	$0x7, %ebp
1800039b6:     	jl	0x1800039fa <numba_list_iter_next+0xc6a>
1800039b8:     	xorl	%ecx, %ecx
1800039ba:     	leal	0x7(%r9), %eax
1800039be:     	cpuid
1800039c0:     	movl	%edx, %esi
1800039c2:     	movl	%ebx, %r10d
1800039c5:     	btl	$0x9, %ebx
1800039c9:     	jae	0x1800039d6 <numba_list_iter_next+0xc46>
1800039cb:     	orl	$0x2, %r8d
1800039cf:     	movl	%r8d, 0x703e(%rip)      # 0x18000aa14
1800039d6:     	cmpl	$0x1, %eax
1800039d9:     	jl	0x1800039e8 <numba_list_iter_next+0xc58>
1800039db:     	movl	$0x7, %eax
1800039e0:     	leal	-0x6(%rax), %ecx
1800039e3:     	cpuid
1800039e5:     	movl	%edx, %r9d
1800039e8:     	movl	$0x24, %eax
1800039ed:     	cmpl	%eax, %ebp
1800039ef:     	jl	0x180003a00 <numba_list_iter_next+0xc70>
1800039f1:     	xorl	%ecx, %ecx
1800039f3:     	cpuid
1800039f5:     	movl	%ebx, %r11d
1800039f8:     	jmp	0x180003a00 <numba_list_iter_next+0xc70>
1800039fa:     	movl	%r9d, %r10d
1800039fd:     	movl	%r9d, %esi
180003a00:     	movq	0x6721(%rip), %rax      # 0x18000a128
180003a07:     	andq	$-0x2, %rax
180003a0b:     	movl	$0x1, 0x66fb(%rip)      # 0x18000a110
180003a15:     	movl	$0x2, 0x66f5(%rip)      # 0x18000a114
180003a1f:     	movq	%rax, 0x6702(%rip)      # 0x18000a128
180003a26:     	btl	$0x14, %edi
180003a2a:     	jae	0x180003a4b <numba_list_iter_next+0xcbb>
180003a2c:     	andq	$-0x11, %rax
180003a30:     	movl	$0x2, 0x66d6(%rip)      # 0x18000a110
180003a3a:     	movq	%rax, 0x66e7(%rip)      # 0x18000a128
180003a41:     	movl	$0x6, 0x66c9(%rip)      # 0x18000a114
180003a4b:     	btl	$0x1b, %edi
180003a4f:     	jae	0x180003b8c <numba_list_iter_next+0xdfc>
180003a55:     	xorl	%ecx, %ecx
180003a57:     	xgetbv
180003a5a:     	shlq	$0x20, %rdx
180003a5e:     	orq	%rax, %rdx
180003a61:     	movq	%rdx, 0x20(%rsp)
180003a66:     	btl	$0x1c, %edi
180003a6a:     	jae	0x180003b70 <numba_list_iter_next+0xde0>
180003a70:     	movq	0x20(%rsp), %rax
180003a75:     	andb	$0x6, %al
180003a77:     	cmpb	$0x6, %al
180003a79:     	jne	0x180003b70 <numba_list_iter_next+0xde0>
180003a7f:     	movl	0x668f(%rip), %eax      # 0x18000a114
180003a85:     	movb	$-0x20, %dl
180003a87:     	orl	$0x8, %eax
180003a8a:     	movl	$0x3, 0x667c(%rip)      # 0x18000a110
180003a94:     	movl	%eax, 0x667a(%rip)      # 0x18000a114
180003a9a:     	testb	$0x20, %r10b
180003a9e:     	je	0x180003b02 <numba_list_iter_next+0xd72>
180003aa0:     	orl	$0x20, %eax
180003aa3:     	movl	$0x5, 0x6663(%rip)      # 0x18000a110
180003aad:     	movl	%eax, 0x6661(%rip)      # 0x18000a114
180003ab3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003ab8:     	movq	0x6669(%rip), %rax      # 0x18000a128
180003abf:     	andl	%ecx, %r10d
180003ac2:     	andq	$-0x3, %rax
180003ac6:     	movq	%rax, 0x665b(%rip)      # 0x18000a128
180003acd:     	cmpl	%ecx, %r10d
180003ad0:     	jne	0x180003b09 <numba_list_iter_next+0xd79>
180003ad2:     	movq	0x20(%rsp), %rax
180003ad7:     	andb	%dl, %al
180003ad9:     	cmpb	%dl, %al
180003adb:     	jne	0x180003b02 <numba_list_iter_next+0xd72>
180003add:     	movq	0x6644(%rip), %rax      # 0x18000a128
180003ae4:     	orl	$0x40, 0x6629(%rip)     # 0x18000a114
180003aeb:     	andq	$-0x25, %rax
180003aef:     	movl	$0x6, 0x6617(%rip)      # 0x18000a110
180003af9:     	movq	%rax, 0x6628(%rip)      # 0x18000a128
180003b00:     	jmp	0x180003b09 <numba_list_iter_next+0xd79>
180003b02:     	movq	0x661f(%rip), %rax      # 0x18000a128
180003b09:     	btl	$0x17, %esi
180003b0d:     	jae	0x180003b1b <numba_list_iter_next+0xd8b>
180003b0f:     	btrq	$0x18, %rax
180003b14:     	movq	%rax, 0x660d(%rip)      # 0x18000a128
180003b1b:     	btl	$0x13, %r9d
180003b20:     	jae	0x180003b70 <numba_list_iter_next+0xde0>
180003b22:     	movq	0x20(%rsp), %rax
180003b27:     	andb	%dl, %al
180003b29:     	cmpb	%dl, %al
180003b2b:     	jne	0x180003b70 <numba_list_iter_next+0xde0>
180003b2d:     	movq	0x65f4(%rip), %rdx      # 0x18000a128
180003b34:     	movl	%r11d, %eax
180003b37:     	shrq	$0x10, %rax
180003b3b:     	movl	%r11d, %ecx
180003b3e:     	andl	$0x6, %eax
180003b41:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003b47:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003b4d:     	movl	%ecx, 0x6ec5(%rip)      # 0x18000aa18
180003b53:     	notq	%rax
180003b56:     	andq	%rax, %rdx
180003b59:     	movq	%rdx, 0x65c8(%rip)      # 0x18000a128
180003b60:     	cmpb	$0x1, %cl
180003b63:     	jbe	0x180003b70 <numba_list_iter_next+0xde0>
180003b65:     	andq	$-0x41, %rdx
180003b69:     	movq	%rdx, 0x65b8(%rip)      # 0x18000a128
180003b70:     	btl	$0x15, %r9d
180003b75:     	jae	0x180003b8c <numba_list_iter_next+0xdfc>
180003b77:     	movq	0x20(%rsp), %rax
180003b7c:     	btq	$0x13, %rax
180003b81:     	jae	0x180003b8c <numba_list_iter_next+0xdfc>
180003b83:     	btrq	$0x7, 0x659c(%rip)      # 0x18000a128
180003b8c:     	movq	0x28(%rsp), %rbx
180003b91:     	xorl	%eax, %eax
180003b93:     	movq	0x30(%rsp), %rbp
180003b98:     	movq	0x38(%rsp), %rsi
180003b9d:     	addq	$0x10, %rsp
180003ba1:     	popq	%rdi
180003ba2:     	retq
180003ba3:     	int3
180003ba4:     	movl	$0x1, %eax
180003ba9:     	retq
180003baa:     	int3
180003bab:     	int3
180003bac:     	xorl	%eax, %eax
180003bae:     	cmpl	%eax, 0x657c(%rip)      # 0x18000a130
180003bb4:     	setne	%al
180003bb7:     	retq
180003bb8:     	int3
180003bb9:     	int3
180003bba:     	int3
180003bbb:     	int3
180003bbc:     	int3
180003bbd:     	int3
180003bbe:     	int3
180003bbf:     	int3
180003bc0:     	jmpq	*0x482(%rip)            # 0x180004048
180003bc6:     	jmpq	*0x484(%rip)            # 0x180004050
180003bcc:     	jmpq	*0x4be(%rip)            # 0x180004090
180003bd2:     	jmpq	*0x4c0(%rip)            # 0x180004098
180003bd8:     	jmpq	*0x4c2(%rip)            # 0x1800040a0
180003bde:     	jmpq	*0x4c4(%rip)            # 0x1800040a8
180003be4:     	jmpq	*0x4c6(%rip)            # 0x1800040b0
180003bea:     	jmpq	*0x490(%rip)            # 0x180004080
180003bf0:     	jmpq	*0x4c2(%rip)            # 0x1800040b8
180003bf6:     	jmpq	*0x48c(%rip)            # 0x180004088
180003bfc:     	movb	$0x1, %al
180003bfe:     	retq
180003bff:     	int3
180003c00:     	xorl	%eax, %eax
180003c02:     	retq
180003c03:     	jmpq	*0x42f(%rip)            # 0x180004038
180003c09:     	jmpq	*0x431(%rip)            # 0x180004040
180003c0f:     	jmpq	*0x4b3(%rip)            # 0x1800040c8
180003c15:     	jmpq	*0x4b5(%rip)            # 0x1800040d0
180003c1b:     	int3
180003c1c:     	int3
180003c1d:     	int3
180003c1e:     	int3
180003c1f:     	int3
180003c20:     	int3
180003c21:     	int3
180003c22:     	int3
180003c23:     	int3
180003c24:     	int3
180003c25:     	int3
180003c26:     	nopw	(%rax,%rax)
180003c30:     	jmpq	*%rax
180003c32:     	int3
180003c33:     	int3
180003c34:     	int3
180003c35:     	int3
180003c36:     	int3
180003c37:     	int3
180003c38:     	int3
180003c39:     	int3
180003c3a:     	int3
180003c3b:     	int3
180003c3c:     	int3
180003c3d:     	int3
180003c3e:     	int3
180003c3f:     	int3
180003c40:     	int3
180003c41:     	int3
180003c42:     	int3
180003c43:     	int3
180003c44:     	int3
180003c45:     	int3
180003c46:     	nopw	(%rax,%rax)
180003c50:     	jmpq	*0x63a(%rip)            # 0x180004290
180003c56:     	pushq	%rbp
180003c58:     	subq	$0x20, %rsp
180003c5c:     	movq	%rdx, %rbp
180003c5f:     	movb	0x40(%rbp), %cl
180003c62:     	addq	$0x20, %rsp
180003c66:     	popq	%rbp
180003c67:     	jmp	0x18000382c <numba_list_iter_next+0xa9c>
180003c6c:     	int3
180003c6d:     	pushq	%rbp
180003c6f:     	subq	$0x20, %rsp
180003c73:     	movq	%rdx, %rbp
180003c76:     	movb	0x20(%rbp), %cl
180003c79:     	callq	0x18000382c <numba_list_iter_next+0xa9c>
180003c7e:     	nop
180003c7f:     	addq	$0x20, %rsp
180003c83:     	popq	%rbp
180003c84:     	retq
180003c85:     	int3
180003c86:     	pushq	%rbp
180003c88:     	subq	$0x20, %rsp
180003c8c:     	movq	%rdx, %rbp
180003c8f:     	addq	$0x20, %rsp
180003c93:     	popq	%rbp
180003c94:     	jmp	0x1800036b8 <numba_list_iter_next+0x928>
180003c99:     	int3
180003c9a:     	pushq	%rbp
180003c9c:     	subq	$0x30, %rsp
180003ca0:     	movq	%rdx, %rbp
180003ca3:     	movq	(%rcx), %rax
180003ca6:     	movl	(%rax), %edx
180003ca8:     	movq	%rcx, 0x28(%rsp)
180003cad:     	movl	%edx, 0x20(%rsp)
180003cb1:     	leaq	-0xbc8(%rip), %r9       # 0x1800030f0 <numba_list_iter_next+0x360>
180003cb8:     	movq	0x70(%rbp), %r8
180003cbc:     	movl	0x68(%rbp), %edx
180003cbf:     	movq	0x60(%rbp), %rcx
180003cc3:     	callq	0x180003628 <numba_list_iter_next+0x898>
180003cc8:     	nop
180003cc9:     	addq	$0x30, %rsp
180003ccd:     	popq	%rbp
180003cce:     	retq
180003ccf:     	int3
180003cd0:     	pushq	%rbp
180003cd2:     	movq	%rdx, %rbp
180003cd5:     	movq	(%rcx), %rax
180003cd8:     	xorl	%ecx, %ecx
180003cda:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003ce0:     	sete	%cl
180003ce3:     	movl	%ecx, %eax
180003ce5:     	popq	%rbp
180003ce6:     	retq
180003ce7:     	int3
