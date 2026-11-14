
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-binding-final\aot\candidate-strict\fibonacci\rcaotr_b19cba7e9f83b6770fdb3d59.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002d70 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3319(%rip), %rax      # 0x1800043a0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	xorl	%eax, %eax
180001092:     	testq	%r8, %r8
180001095:     	cmovleq	%rax, %r8
180001099:     	incq	%r8
18000109c:     	movl	$0x1, %r9d
1800010a2:     	nopw	%cs:(%rax,%rax)
1800010ac:     	nopl	(%rax)
1800010b0:     	decq	%r8
1800010b3:     	testq	%r8, %r8
1800010b6:     	jle	0x1800010dc <.text+0xdc>
1800010b8:     	leaq	(%r9,%rax), %r10
1800010bc:     	xorq	%r10, %rax
1800010bf:     	movq	%r10, %r11
1800010c2:     	xorq	%r9, %r11
1800010c5:     	testq	%r11, %rax
1800010c8:     	js	0x1800010d7 <.text+0xd7>
1800010ca:     	cmpb	$0x0, (%rdx)
1800010cd:     	movq	%r9, %rax
1800010d0:     	movq	%r10, %r9
1800010d3:     	je	0x1800010b0 <.text+0xb0>
1800010d5:     	jmp	0x1800010da <.text+0xda>
1800010d7:     	movb	$0x1, (%rdx)
1800010da:     	xorl	%eax, %eax
1800010dc:     	movq	%rax, (%rcx)
1800010df:     	retq
1800010e0:     	pushq	%r15
1800010e2:     	pushq	%r14
1800010e4:     	pushq	%r13
1800010e6:     	pushq	%r12
1800010e8:     	pushq	%rsi
1800010e9:     	pushq	%rdi
1800010ea:     	pushq	%rbx
1800010eb:     	subq	$0x180, %rsp            # imm = 0x180
1800010f2:     	movq	%rdx, %rcx
1800010f5:     	leaq	0x58(%rsp), %rax
1800010fa:     	movq	%rax, 0x40(%rsp)
1800010ff:     	leaq	0x60(%rsp), %rax
180001104:     	movq	%rax, 0x38(%rsp)
180001109:     	leaq	0x68(%rsp), %rax
18000110e:     	movq	%rax, 0x30(%rsp)
180001113:     	leaq	0x70(%rsp), %rax
180001118:     	movq	%rax, 0x28(%rsp)
18000111d:     	leaq	0x78(%rsp), %rax
180001122:     	movq	%rax, 0x20(%rsp)
180001127:     	leaq	0x329a(%rip), %rdx      # 0x1800043c8
18000112e:     	movl	$0x5, %r8d
180001134:     	movl	$0x5, %r9d
18000113a:     	callq	0x180002f01 <numba_list_iter_next+0x2f1>
18000113f:     	testl	%eax, %eax
180001141:     	je	0x1800013eb <.text+0x3eb>
180001147:     	cmpq	$0x0, 0x9b11(%rip)      # 0x18000ac60
18000114f:     	je	0x18000134e <.text+0x34e>
180001155:     	movq	0x78(%rsp), %rcx
18000115a:     	xorps	%xmm0, %xmm0
18000115d:     	movaps	%xmm0, 0x140(%rsp)
180001165:     	movaps	%xmm0, 0x150(%rsp)
18000116d:     	movaps	%xmm0, 0x160(%rsp)
180001175:     	movq	$0x0, 0x170(%rsp)
180001181:     	leaq	0x140(%rsp), %rdx
180001189:     	callq	0x180001be0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7a0>
18000118e:     	testl	%eax, %eax
180001190:     	jne	0x180001366 <.text+0x366>
180001196:     	cmpq	$0x8, 0x158(%rsp)
18000119f:     	jne	0x180001366 <.text+0x366>
1800011a5:     	movq	0x140(%rsp), %rsi
1800011ad:     	movq	0x70(%rsp), %rcx
1800011b2:     	xorps	%xmm0, %xmm0
1800011b5:     	movaps	%xmm0, 0x100(%rsp)
1800011bd:     	movaps	%xmm0, 0x110(%rsp)
1800011c5:     	movaps	%xmm0, 0x120(%rsp)
1800011cd:     	movq	$0x0, 0x130(%rsp)
1800011d9:     	leaq	0x100(%rsp), %rdx
1800011e1:     	callq	0x180001be0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7a0>
1800011e6:     	testl	%eax, %eax
1800011e8:     	jne	0x18000137b <.text+0x37b>
1800011ee:     	cmpq	$0x8, 0x118(%rsp)
1800011f7:     	jne	0x18000137b <.text+0x37b>
1800011fd:     	movq	0x100(%rsp), %rdi
180001205:     	movq	0x68(%rsp), %rcx
18000120a:     	xorps	%xmm0, %xmm0
18000120d:     	movaps	%xmm0, 0xc0(%rsp)
180001215:     	movaps	%xmm0, 0xd0(%rsp)
18000121d:     	movaps	%xmm0, 0xe0(%rsp)
180001225:     	movq	$0x0, 0xf0(%rsp)
180001231:     	leaq	0xc0(%rsp), %rdx
180001239:     	callq	0x180001be0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7a0>
18000123e:     	testl	%eax, %eax
180001240:     	jne	0x180001390 <.text+0x390>
180001246:     	cmpq	$0x8, 0xd8(%rsp)
18000124f:     	jne	0x180001390 <.text+0x390>
180001255:     	movq	0xc0(%rsp), %rbx
18000125d:     	movq	0x60(%rsp), %rcx
180001262:     	xorps	%xmm0, %xmm0
180001265:     	movaps	%xmm0, 0x80(%rsp)
18000126d:     	movaps	%xmm0, 0x90(%rsp)
180001275:     	movaps	%xmm0, 0xa0(%rsp)
18000127d:     	movq	$0x0, 0xb0(%rsp)
180001289:     	leaq	0x80(%rsp), %rdx
180001291:     	callq	0x180001be0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7a0>
180001296:     	testl	%eax, %eax
180001298:     	jne	0x1800013a5 <.text+0x3a5>
18000129e:     	cmpq	$0x1, 0x98(%rsp)
1800012a7:     	jne	0x1800013a5 <.text+0x3a5>
1800012ad:     	movq	0x80(%rsp), %r14
1800012b5:     	movq	0xa0(%rsp), %r15
1800012bd:     	movq	0x58(%rsp), %rcx
1800012c2:     	callq	0x180002f07 <numba_list_iter_next+0x2f7>
1800012c7:     	testq	%rax, %rax
1800012ca:     	je	0x1800013ba <.text+0x3ba>
1800012d0:     	movq	%rax, %r13
1800012d3:     	movq	%rax, %rcx
1800012d6:     	callq	0x180002f0d <numba_list_iter_next+0x2fd>
1800012db:     	movq	%rax, %r12
1800012de:     	movq	%r13, %rcx
1800012e1:     	callq	0x180002f13 <numba_list_iter_next+0x303>
1800012e6:     	callq	0x180002f19 <numba_list_iter_next+0x309>
1800012eb:     	testq	%rax, %rax
1800012ee:     	jne	0x1800013cb <.text+0x3cb>
1800012f4:     	movq	$0x0, 0x50(%rsp)
1800012fd:     	leaq	0x50(%rsp), %rcx
180001302:     	movq	%r15, %rdx
180001305:     	movq	%r12, %r8
180001308:     	callq	0x180001090 <.text+0x90>
18000130d:     	movq	0x50(%rsp), %r15
180001312:     	movq	%rsi, %rcx
180001315:     	callq	0x180001060 <.text+0x60>
18000131a:     	movq	%rdi, %rcx
18000131d:     	callq	0x180001060 <.text+0x60>
180001322:     	movq	%rbx, %rcx
180001325:     	callq	0x180001060 <.text+0x60>
18000132a:     	movq	%r14, %rcx
18000132d:     	callq	0x180001060 <.text+0x60>
180001332:     	movq	%r15, %rcx
180001335:     	callq	0x180002f1f <numba_list_iter_next+0x30f>
18000133a:     	nop
18000133b:     	addq	$0x180, %rsp            # imm = 0x180
180001342:     	popq	%rbx
180001343:     	popq	%rdi
180001344:     	popq	%rsi
180001345:     	popq	%r12
180001347:     	popq	%r13
180001349:     	popq	%r14
18000134b:     	popq	%r15
18000134d:     	retq
18000134e:     	movq	0x2ee3(%rip), %rcx      # 0x180004238
180001355:     	leaq	0x3084(%rip), %rdx      # 0x1800043e0
18000135c:     	callq	0x180002f25 <numba_list_iter_next+0x315>
180001361:     	jmp	0x1800013eb <.text+0x3eb>
180001366:     	movq	0x2ebb(%rip), %rcx      # 0x180004228
18000136d:     	leaq	0x315c(%rip), %rdx      # 0x1800044d0
180001374:     	callq	0x180002f25 <numba_list_iter_next+0x315>
180001379:     	jmp	0x1800013eb <.text+0x3eb>
18000137b:     	movq	0x2ea6(%rip), %rcx      # 0x180004228
180001382:     	leaq	0x3147(%rip), %rdx      # 0x1800044d0
180001389:     	callq	0x180002f25 <numba_list_iter_next+0x315>
18000138e:     	jmp	0x1800013e3 <.text+0x3e3>
180001390:     	movq	0x2e91(%rip), %rcx      # 0x180004228
180001397:     	leaq	0x3132(%rip), %rdx      # 0x1800044d0
18000139e:     	callq	0x180002f25 <numba_list_iter_next+0x315>
1800013a3:     	jmp	0x1800013db <.text+0x3db>
1800013a5:     	movq	0x2e7c(%rip), %rcx      # 0x180004228
1800013ac:     	leaq	0x311d(%rip), %rdx      # 0x1800044d0
1800013b3:     	callq	0x180002f25 <numba_list_iter_next+0x315>
1800013b8:     	jmp	0x1800013d3 <.text+0x3d3>
1800013ba:     	xorl	%r12d, %r12d
1800013bd:     	callq	0x180002f19 <numba_list_iter_next+0x309>
1800013c2:     	testq	%rax, %rax
1800013c5:     	je	0x1800012f4 <.text+0x2f4>
1800013cb:     	movq	%r14, %rcx
1800013ce:     	callq	0x180001060 <.text+0x60>
1800013d3:     	movq	%rbx, %rcx
1800013d6:     	callq	0x180001060 <.text+0x60>
1800013db:     	movq	%rdi, %rcx
1800013de:     	callq	0x180001060 <.text+0x60>
1800013e3:     	movq	%rsi, %rcx
1800013e6:     	callq	0x180001060 <.text+0x60>
1800013eb:     	xorl	%eax, %eax
1800013ed:     	jmp	0x18000133b <.text+0x33b>
1800013f2:     	nopw	%cs:(%rax,%rax)
1800013fc:     	nopl	(%rax)
180001400:     	subq	$0x28, %rsp
180001404:     	movq	0xf8(%rsp), %rdx
18000140c:     	movq	0x110(%rsp), %r8
180001414:     	movq	$0x0, 0x20(%rsp)
18000141d:     	leaq	0x20(%rsp), %rcx
180001422:     	callq	0x180001090 <.text+0x90>
180001427:     	movq	0x20(%rsp), %rax
18000142c:     	addq	$0x28, %rsp
180001430:     	retq
180001431:     	nopw	%cs:(%rax,%rax)
18000143b:     	nopl	(%rax,%rax)

0000000180001440 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59>:
180001440:     	pushq	%rsi
180001441:     	subq	$0x20, %rsp
180001445:     	leaq	0x8bf4(%rip), %rcx      # 0x18000a040
18000144c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001451:     	callq	0x180002f2b <numba_list_iter_next+0x31b>
180001456:     	testq	%rax, %rax
180001459:     	je	0x18000148b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x4b>
18000145b:     	leaq	0x8b9e(%rip), %rdx      # 0x18000a000
180001462:     	leaq	0x3117(%rip), %r8       # 0x180004580
180001469:     	leaq	0x3138(%rip), %r9       # 0x1800045a8
180001470:     	movq	%rax, %rcx
180001473:     	movq	%rax, %rsi
180001476:     	callq	0x180001e50 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xa10>
18000147b:     	movl	%eax, %ecx
18000147d:     	xorl	%eax, %eax
18000147f:     	testl	%ecx, %ecx
180001481:     	cmoveq	%rsi, %rax
180001485:     	addq	$0x20, %rsp
180001489:     	popq	%rsi
18000148a:     	retq
18000148b:     	xorl	%eax, %eax
18000148d:     	addq	$0x20, %rsp
180001491:     	popq	%rsi
180001492:     	retq
180001493:     	int3
180001494:     	int3
180001495:     	int3
180001496:     	int3
180001497:     	int3
180001498:     	int3
180001499:     	int3
18000149a:     	int3
18000149b:     	int3
18000149c:     	int3
18000149d:     	int3
18000149e:     	int3
18000149f:     	int3
1800014a0:     	movq	%rbx, 0x8(%rsp)
1800014a5:     	movq	%rsi, 0x10(%rsp)
1800014aa:     	pushq	%rdi
1800014ab:     	subq	$0x20, %rsp
1800014af:     	movq	%rcx, %rbx
1800014b2:     	movq	%r8, %rdi
1800014b5:     	movq	0x10(%rcx), %rcx
1800014b9:     	movq	%rdx, %rsi
1800014bc:     	testq	%rcx, %rcx
1800014bf:     	je	0x1800014ca <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x8a>
1800014c1:     	movq	%r8, %rdx
1800014c4:     	callq	*%rsi
1800014c6:     	testl	%eax, %eax
1800014c8:     	jne	0x1800014ed <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xad>
1800014ca:     	movq	0x18(%rbx), %rcx
1800014ce:     	testq	%rcx, %rcx
1800014d1:     	je	0x1800014eb <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xab>
1800014d3:     	movq	%rdi, %rdx
1800014d6:     	movq	%rsi, %rax
1800014d9:     	movq	0x30(%rsp), %rbx
1800014de:     	movq	0x38(%rsp), %rsi
1800014e3:     	addq	$0x20, %rsp
1800014e7:     	popq	%rdi
1800014e8:     	jmpq	*%rax
1800014eb:     	xorl	%eax, %eax
1800014ed:     	movq	0x30(%rsp), %rbx
1800014f2:     	movq	0x38(%rsp), %rsi
1800014f7:     	addq	$0x20, %rsp
1800014fb:     	popq	%rdi
1800014fc:     	retq
1800014fd:     	int3
1800014fe:     	int3
1800014ff:     	int3
180001500:     	pushq	%rbx
180001502:     	subq	$0x20, %rsp
180001506:     	movq	%rcx, %rbx
180001509:     	movq	0x10(%rcx), %rcx
18000150d:     	testq	%rcx, %rcx
180001510:     	je	0x18000152d <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xed>
180001512:     	movq	$0x0, 0x10(%rbx)
18000151a:     	movl	(%rcx), %eax
18000151c:     	testl	%eax, %eax
18000151e:     	js	0x18000152d <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xed>
180001520:     	subl	$0x1, %eax
180001523:     	movl	%eax, (%rcx)
180001525:     	jne	0x18000152d <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xed>
180001527:     	callq	*0x2c83(%rip)           # 0x1800041b0
18000152d:     	movq	0x18(%rbx), %rcx
180001531:     	testq	%rcx, %rcx
180001534:     	je	0x180001551 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x111>
180001536:     	movq	$0x0, 0x18(%rbx)
18000153e:     	movl	(%rcx), %eax
180001540:     	testl	%eax, %eax
180001542:     	js	0x180001551 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x111>
180001544:     	subl	$0x1, %eax
180001547:     	movl	%eax, (%rcx)
180001549:     	jne	0x180001551 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x111>
18000154b:     	callq	*0x2c5f(%rip)           # 0x1800041b0
180001551:     	xorl	%eax, %eax
180001553:     	addq	$0x20, %rsp
180001557:     	popq	%rbx
180001558:     	retq
180001559:     	int3
18000155a:     	int3
18000155b:     	int3
18000155c:     	int3
18000155d:     	int3
18000155e:     	int3
18000155f:     	int3
180001560:     	pushq	%rbx
180001562:     	subq	$0x20, %rsp
180001566:     	movq	%rcx, %rbx
180001569:     	callq	*0x2c81(%rip)           # 0x1800041f0
18000156f:     	movq	0x10(%rbx), %rcx
180001573:     	testq	%rcx, %rcx
180001576:     	je	0x180001593 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x153>
180001578:     	movq	$0x0, 0x10(%rbx)
180001580:     	movl	(%rcx), %eax
180001582:     	testl	%eax, %eax
180001584:     	js	0x180001593 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x153>
180001586:     	subl	$0x1, %eax
180001589:     	movl	%eax, (%rcx)
18000158b:     	jne	0x180001593 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x153>
18000158d:     	callq	*0x2c1d(%rip)           # 0x1800041b0
180001593:     	movq	0x18(%rbx), %rcx
180001597:     	testq	%rcx, %rcx
18000159a:     	je	0x1800015b7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x177>
18000159c:     	movq	$0x0, 0x18(%rbx)
1800015a4:     	movl	(%rcx), %eax
1800015a6:     	testl	%eax, %eax
1800015a8:     	js	0x1800015b7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x177>
1800015aa:     	subl	$0x1, %eax
1800015ad:     	movl	%eax, (%rcx)
1800015af:     	jne	0x1800015b7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x177>
1800015b1:     	callq	*0x2bf9(%rip)           # 0x1800041b0
1800015b7:     	movq	0x8(%rbx), %rax
1800015bb:     	movq	%rbx, %rcx
1800015be:     	addq	$0x20, %rsp
1800015c2:     	popq	%rbx
1800015c3:     	jmpq	*0x140(%rax)
1800015ca:     	int3
1800015cb:     	int3
1800015cc:     	int3
1800015cd:     	int3
1800015ce:     	int3
1800015cf:     	int3
1800015d0:     	pushq	%rbx
1800015d2:     	subq	$0x30, %rsp
1800015d6:     	movq	%r8, %r10
1800015d9:     	leaq	0x58(%rsp), %rax
1800015de:     	movq	%rax, 0x28(%rsp)
1800015e3:     	leaq	0x93a6(%rip), %r9       # 0x18000a990
1800015ea:     	movq	0x2bcf(%rip), %rax      # 0x1800041c0
1800015f1:     	leaq	0x32f0(%rip), %r8       # 0x1800048e8
1800015f8:     	movq	%rdx, %r11
1800015fb:     	movq	%rax, 0x20(%rsp)
180001600:     	movq	%rcx, %rbx
180001603:     	movq	%r10, %rdx
180001606:     	movq	%r11, %rcx
180001609:     	callq	*0x2ad1(%rip)           # 0x1800040e0
18000160f:     	testl	%eax, %eax
180001611:     	je	0x18000166c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x22c>
180001613:     	xorl	%r8d, %r8d
180001616:     	xorl	%edx, %edx
180001618:     	movq	%rbx, %rcx
18000161b:     	callq	*0x2bef(%rip)           # 0x180004210
180001621:     	movq	%rax, %rbx
180001624:     	testq	%rax, %rax
180001627:     	je	0x18000166c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x22c>
180001629:     	movq	0x58(%rsp), %rax
18000162e:     	movl	(%rax), %ecx
180001630:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001636:     	jae	0x180001641 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x201>
180001638:     	incl	%ecx
18000163a:     	movl	%ecx, (%rax)
18000163c:     	movq	0x58(%rsp), %rax
180001641:     	xorl	%ecx, %ecx
180001643:     	movq	%rax, 0x10(%rbx)
180001647:     	callq	*0x2b23(%rip)           # 0x180004170
18000164d:     	movq	%rax, 0x18(%rbx)
180001651:     	testq	%rax, %rax
180001654:     	jne	0x180001674 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x234>
180001656:     	movl	(%rbx), %eax
180001658:     	testl	%eax, %eax
18000165a:     	js	0x18000166c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x22c>
18000165c:     	subl	$0x1, %eax
18000165f:     	movl	%eax, (%rbx)
180001661:     	jne	0x18000166c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x22c>
180001663:     	movq	%rbx, %rcx
180001666:     	callq	*0x2b44(%rip)           # 0x1800041b0
18000166c:     	xorl	%eax, %eax
18000166e:     	addq	$0x30, %rsp
180001672:     	popq	%rbx
180001673:     	retq
180001674:     	movq	%rbx, %rax
180001677:     	addq	$0x30, %rsp
18000167b:     	popq	%rbx
18000167c:     	retq
18000167d:     	int3
18000167e:     	int3
18000167f:     	int3
180001680:     	movq	%rbx, 0x8(%rsp)
180001685:     	movq	%rsi, 0x10(%rsp)
18000168a:     	pushq	%rdi
18000168b:     	subq	$0x20, %rsp
18000168f:     	movq	%rcx, %rbx
180001692:     	movq	%r8, %rdi
180001695:     	movq	0x18(%rcx), %rcx
180001699:     	movq	%rdx, %rsi
18000169c:     	testq	%rcx, %rcx
18000169f:     	je	0x1800016aa <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x26a>
1800016a1:     	movq	%r8, %rdx
1800016a4:     	callq	*%rsi
1800016a6:     	testl	%eax, %eax
1800016a8:     	jne	0x1800016cd <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x28d>
1800016aa:     	movq	0x40(%rbx), %rcx
1800016ae:     	testq	%rcx, %rcx
1800016b1:     	je	0x1800016cb <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x28b>
1800016b3:     	movq	%rdi, %rdx
1800016b6:     	movq	%rsi, %rax
1800016b9:     	movq	0x30(%rsp), %rbx
1800016be:     	movq	0x38(%rsp), %rsi
1800016c3:     	addq	$0x20, %rsp
1800016c7:     	popq	%rdi
1800016c8:     	jmpq	*%rax
1800016cb:     	xorl	%eax, %eax
1800016cd:     	movq	0x30(%rsp), %rbx
1800016d2:     	movq	0x38(%rsp), %rsi
1800016d7:     	addq	$0x20, %rsp
1800016db:     	popq	%rdi
1800016dc:     	retq
1800016dd:     	int3
1800016de:     	int3
1800016df:     	int3
1800016e0:     	pushq	%rbx
1800016e2:     	subq	$0x20, %rsp
1800016e6:     	movq	%rcx, %rbx
1800016e9:     	callq	*0x2b01(%rip)           # 0x1800041f0
1800016ef:     	cmpq	$0x0, 0x48(%rbx)
1800016f4:     	je	0x1800016ff <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x2bf>
1800016f6:     	movq	%rbx, %rcx
1800016f9:     	callq	*0x2a81(%rip)           # 0x180004180
1800016ff:     	movq	0x20(%rbx), %rcx
180001703:     	callq	*0x2a97(%rip)           # 0x1800041a0
180001709:     	movq	0x38(%rbx), %rcx
18000170d:     	callq	*0x2a8d(%rip)           # 0x1800041a0
180001713:     	movq	0x18(%rbx), %rcx
180001717:     	testq	%rcx, %rcx
18000171a:     	je	0x18000172f <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x2ef>
18000171c:     	movl	(%rcx), %eax
18000171e:     	testl	%eax, %eax
180001720:     	js	0x18000172f <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x2ef>
180001722:     	subl	$0x1, %eax
180001725:     	movl	%eax, (%rcx)
180001727:     	jne	0x18000172f <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x2ef>
180001729:     	callq	*0x2a81(%rip)           # 0x1800041b0
18000172f:     	movq	0x40(%rbx), %rcx
180001733:     	testq	%rcx, %rcx
180001736:     	je	0x18000174b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x30b>
180001738:     	movl	(%rcx), %eax
18000173a:     	testl	%eax, %eax
18000173c:     	js	0x18000174b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x30b>
18000173e:     	subl	$0x1, %eax
180001741:     	movl	%eax, (%rcx)
180001743:     	jne	0x18000174b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x30b>
180001745:     	callq	*0x2a65(%rip)           # 0x1800041b0
18000174b:     	movq	0x8(%rbx), %rax
18000174f:     	movq	%rbx, %rcx
180001752:     	addq	$0x20, %rsp
180001756:     	popq	%rbx
180001757:     	jmpq	*0x140(%rax)
18000175e:     	int3
18000175f:     	int3
180001760:     	pushq	%rbx
180001762:     	subq	$0x20, %rsp
180001766:     	callq	*0x2a0c(%rip)           # 0x180004178
18000176c:     	movq	%rax, %rbx
18000176f:     	testq	%rax, %rax
180001772:     	jne	0x18000177a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x33a>
180001774:     	addq	$0x20, %rsp
180001778:     	popq	%rbx
180001779:     	retq
18000177a:     	movq	%rbx, %rcx
18000177d:     	movq	%rdi, 0x30(%rsp)
180001782:     	callq	0x180003a95 <numba_list_iter_next+0xe85>
180001787:     	leaq	0x1(%rax), %rcx
18000178b:     	callq	*0x2a87(%rip)           # 0x180004218
180001791:     	movq	%rax, %rdi
180001794:     	testq	%rax, %rax
180001797:     	jne	0x1800017ac <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x36c>
180001799:     	callq	*0x2999(%rip)           # 0x180004138
18000179f:     	movq	0x30(%rsp), %rdi
1800017a4:     	xorl	%eax, %eax
1800017a6:     	addq	$0x20, %rsp
1800017aa:     	popq	%rbx
1800017ab:     	retq
1800017ac:     	movq	%rbx, %rdx
1800017af:     	movq	%rdi, %rcx
1800017b2:     	callq	0x180003a8f <numba_list_iter_next+0xe7f>
1800017b7:     	movq	%rdi, %rax
1800017ba:     	movq	0x30(%rsp), %rdi
1800017bf:     	addq	$0x20, %rsp
1800017c3:     	popq	%rbx
1800017c4:     	retq
1800017c5:     	int3
1800017c6:     	int3
1800017c7:     	int3
1800017c8:     	int3
1800017c9:     	int3
1800017ca:     	int3
1800017cb:     	int3
1800017cc:     	int3
1800017cd:     	int3
1800017ce:     	int3
1800017cf:     	int3
1800017d0:     	movq	0x18(%rcx), %rcx
1800017d4:     	movq	%rdx, %rax
1800017d7:     	testq	%rcx, %rcx
1800017da:     	je	0x1800017e2 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x3a2>
1800017dc:     	movq	%r8, %rdx
1800017df:     	jmpq	*%rax
1800017e2:     	xorl	%eax, %eax
1800017e4:     	retq
1800017e5:     	int3
1800017e6:     	int3
1800017e7:     	int3
1800017e8:     	int3
1800017e9:     	int3
1800017ea:     	int3
1800017eb:     	int3
1800017ec:     	int3
1800017ed:     	int3
1800017ee:     	int3
1800017ef:     	int3
1800017f0:     	movq	%rbx, 0x8(%rsp)
1800017f5:     	pushq	%rdi
1800017f6:     	subq	$0x20, %rsp
1800017fa:     	movq	0x28(%rcx), %rax
1800017fe:     	xorl	%edi, %edi
180001800:     	movq	%rcx, %rbx
180001803:     	testq	%rax, %rax
180001806:     	je	0x180001812 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x3d2>
180001808:     	addq	$0x38, %rcx
18000180c:     	callq	*%rax
18000180e:     	movq	%rdi, 0x28(%rbx)
180001812:     	movq	0x18(%rbx), %rcx
180001816:     	testq	%rcx, %rcx
180001819:     	je	0x180001832 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x3f2>
18000181b:     	movq	%rdi, 0x18(%rbx)
18000181f:     	movl	(%rcx), %eax
180001821:     	testl	%eax, %eax
180001823:     	js	0x180001832 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x3f2>
180001825:     	subl	$0x1, %eax
180001828:     	movl	%eax, (%rcx)
18000182a:     	jne	0x180001832 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x3f2>
18000182c:     	callq	*0x297e(%rip)           # 0x1800041b0
180001832:     	movq	%rdi, 0x20(%rbx)
180001836:     	xorl	%eax, %eax
180001838:     	movq	0x30(%rsp), %rbx
18000183d:     	addq	$0x20, %rsp
180001841:     	popq	%rdi
180001842:     	retq
180001843:     	int3
180001844:     	int3
180001845:     	int3
180001846:     	int3
180001847:     	int3
180001848:     	int3
180001849:     	int3
18000184a:     	int3
18000184b:     	int3
18000184c:     	int3
18000184d:     	int3
18000184e:     	int3
18000184f:     	int3
180001850:     	pushq	%rbx
180001852:     	subq	$0x20, %rsp
180001856:     	movq	%rcx, %rbx
180001859:     	callq	*0x2991(%rip)           # 0x1800041f0
18000185f:     	cmpq	$0x0, 0x30(%rbx)
180001864:     	je	0x18000186f <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x42f>
180001866:     	movq	%rbx, %rcx
180001869:     	callq	*0x2911(%rip)           # 0x180004180
18000186f:     	callq	*0x28bb(%rip)           # 0x180004130
180001875:     	testl	%eax, %eax
180001877:     	jne	0x180001888 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x448>
180001879:     	movq	0x28(%rbx), %rax
18000187d:     	testq	%rax, %rax
180001880:     	je	0x180001888 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x448>
180001882:     	leaq	0x38(%rbx), %rcx
180001886:     	callq	*%rax
180001888:     	movq	0x18(%rbx), %rcx
18000188c:     	testq	%rcx, %rcx
18000188f:     	je	0x1800018a4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x464>
180001891:     	movl	(%rcx), %eax
180001893:     	testl	%eax, %eax
180001895:     	js	0x1800018a4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x464>
180001897:     	subl	$0x1, %eax
18000189a:     	movl	%eax, (%rcx)
18000189c:     	jne	0x1800018a4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x464>
18000189e:     	callq	*0x290c(%rip)           # 0x1800041b0
1800018a4:     	movq	0x8(%rbx), %rax
1800018a8:     	movq	%rbx, %rcx
1800018ab:     	addq	$0x20, %rsp
1800018af:     	popq	%rbx
1800018b0:     	jmpq	*0x140(%rax)
1800018b7:     	int3
1800018b8:     	int3
1800018b9:     	int3
1800018ba:     	int3
1800018bb:     	int3
1800018bc:     	int3
1800018bd:     	int3
1800018be:     	int3
1800018bf:     	int3
1800018c0:     	pushq	%rdi
1800018c2:     	subq	$0x20, %rsp
1800018c6:     	cmpq	$0x0, 0x20(%rcx)
1800018cb:     	movq	%rcx, %rdi
1800018ce:     	jne	0x1800018ef <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x4af>
1800018d0:     	movq	0x2961(%rip), %rcx      # 0x180004238
1800018d7:     	leaq	0x305a(%rip), %rdx      # 0x180004938
1800018de:     	movq	(%rcx), %rcx
1800018e1:     	callq	*0x2949(%rip)           # 0x180004230
1800018e7:     	xorl	%eax, %eax
1800018e9:     	addq	$0x20, %rsp
1800018ed:     	popq	%rdi
1800018ee:     	retq
1800018ef:     	movq	%rdi, %rdx
1800018f2:     	movq	%rbx, 0x30(%rsp)
1800018f7:     	movl	$0x1, %ecx
1800018fc:     	callq	*0x27ee(%rip)           # 0x1800040f0
180001902:     	movq	%rax, %rbx
180001905:     	testq	%rax, %rax
180001908:     	jne	0x180001915 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x4d5>
18000190a:     	movq	0x30(%rsp), %rbx
18000190f:     	addq	$0x20, %rsp
180001913:     	popq	%rdi
180001914:     	retq
180001915:     	xorl	%r8d, %r8d
180001918:     	movq	%rbx, %rdx
18000191b:     	movq	%rdi, %rcx
18000191e:     	callq	*0x20(%rdi)
180001921:     	movl	(%rbx), %ecx
180001923:     	movq	%rax, %rdi
180001926:     	testl	%ecx, %ecx
180001928:     	js	0x18000193a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x4fa>
18000192a:     	subl	$0x1, %ecx
18000192d:     	movl	%ecx, (%rbx)
18000192f:     	jne	0x18000193a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x4fa>
180001931:     	movq	%rbx, %rcx
180001934:     	callq	*0x2876(%rip)           # 0x1800041b0
18000193a:     	movq	0x30(%rsp), %rbx
18000193f:     	movq	%rdi, %rax
180001942:     	addq	$0x20, %rsp
180001946:     	popq	%rdi
180001947:     	retq
180001948:     	int3
180001949:     	int3
18000194a:     	int3
18000194b:     	int3
18000194c:     	int3
18000194d:     	int3
18000194e:     	int3
18000194f:     	int3
180001950:     	movq	%rbx, 0x8(%rsp)
180001955:     	pushq	%rdi
180001956:     	subq	$0x20, %rsp
18000195a:     	movq	%r8, %rbx
18000195d:     	callq	*0x27b5(%rip)           # 0x180004118
180001963:     	movl	(%rbx), %ecx
180001965:     	movl	%eax, %edi
180001967:     	testl	%ecx, %ecx
180001969:     	js	0x18000197b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x53b>
18000196b:     	subl	$0x1, %ecx
18000196e:     	movl	%ecx, (%rbx)
180001970:     	jne	0x18000197b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x53b>
180001972:     	movq	%rbx, %rcx
180001975:     	callq	*0x2835(%rip)           # 0x1800041b0
18000197b:     	movl	%edi, %ecx
18000197d:     	movq	0x30(%rsp), %rbx
180001982:     	addq	$0x20, %rsp
180001986:     	popq	%rdi
180001987:     	jmpq	*0x285a(%rip)           # 0x1800041e8
18000198e:     	int3
18000198f:     	int3
180001990:     	movq	%rbx, 0x8(%rsp)
180001995:     	pushq	%rdi
180001996:     	subq	$0x20, %rsp
18000199a:     	movl	(%rdx), %eax
18000199c:     	movq	%rdx, %rbx
18000199f:     	movq	%rcx, %rdi
1800019a2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800019a7:     	jae	0x1800019ad <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x56d>
1800019a9:     	incl	%eax
1800019ab:     	movl	%eax, (%rdx)
1800019ad:     	movl	$0x30, %ecx
1800019b2:     	callq	*0x9270(%rip)           # 0x18000ac28
1800019b8:     	cmpb	$0x0, 0x9241(%rip)      # 0x18000ac00
1800019bf:     	je	0x1800019c9 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x589>
1800019c1:     	lock
1800019c2:     	incq	0x923f(%rip)            # 0x18000ac08
1800019c9:     	testq	%rax, %rax
1800019cc:     	je	0x180001a03 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x5c3>
1800019ce:     	movl	$0x1, %ecx
1800019d3:     	leaq	-0x8a(%rip), %rdx       # 0x180001950 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x510>
1800019da:     	xchgq	%rcx, (%rax)
1800019dd:     	xorl	%ecx, %ecx
1800019df:     	movq	%rdx, 0x8(%rax)
1800019e3:     	movq	%rcx, 0x20(%rax)
1800019e7:     	movq	%rcx, 0x28(%rax)
1800019eb:     	movq	%rbx, 0x10(%rax)
1800019ef:     	movq	%rdi, 0x18(%rax)
1800019f3:     	cmpb	%cl, 0x9207(%rip)       # 0x18000ac00
1800019f9:     	je	0x180001a03 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x5c3>
1800019fb:     	lock
1800019fc:     	incq	0x9215(%rip)            # 0x18000ac18
180001a03:     	movq	0x30(%rsp), %rbx
180001a08:     	addq	$0x20, %rsp
180001a0c:     	popq	%rdi
180001a0d:     	retq
180001a0e:     	int3
180001a0f:     	int3
180001a10:     	movq	%rbx, 0x8(%rsp)
180001a15:     	pushq	%rdi
180001a16:     	subq	$0x30, %rsp
180001a1a:     	movq	%rcx, %rdi
180001a1d:     	leaq	0x8f5c(%rip), %r9       # 0x18000a980
180001a24:     	movq	%r8, %rax
180001a27:     	leaq	0x58(%rsp), %rcx
180001a2c:     	movq	%rdx, %r10
180001a2f:     	movq	%rcx, 0x20(%rsp)
180001a34:     	movq	%r10, %rcx
180001a37:     	leaq	0x2f42(%rip), %r8       # 0x180004980
180001a3e:     	movq	%rax, %rdx
180001a41:     	callq	*0x2699(%rip)           # 0x1800040e0
180001a47:     	testl	%eax, %eax
180001a49:     	je	0x180001a73 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x633>
180001a4b:     	movq	0x58(%rsp), %rcx
180001a50:     	callq	*0x26d2(%rip)           # 0x180004128
180001a56:     	movq	%rax, %rbx
180001a59:     	callq	*0x27e9(%rip)           # 0x180004248
180001a5f:     	testq	%rax, %rax
180001a62:     	jne	0x180001a73 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x633>
180001a64:     	movq	%rbx, 0x10(%rdi)
180001a68:     	movq	0x40(%rsp), %rbx
180001a6d:     	addq	$0x30, %rsp
180001a71:     	popq	%rdi
180001a72:     	retq
180001a73:     	movq	0x40(%rsp), %rbx
180001a78:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001a7d:     	addq	$0x30, %rsp
180001a81:     	popq	%rdi
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
180001a90:     	subq	$0x38, %rsp
180001a94:     	movl	%r8d, %eax
180001a97:     	movq	%rdx, %r10
180001a9a:     	movq	0x10(%rcx), %r8
180001a9e:     	movq	%rcx, %rdx
180001aa1:     	movl	%eax, 0x28(%rsp)
180001aa5:     	movq	%r10, %rcx
180001aa8:     	movl	$0x0, 0x20(%rsp)
180001ab0:     	movq	0x20(%r8), %r9
180001ab4:     	movq	0x18(%r8), %r8
180001ab8:     	callq	*0x271a(%rip)           # 0x1800041d8
180001abe:     	addq	$0x38, %rsp
180001ac2:     	retq
180001ac3:     	int3
180001ac4:     	int3
180001ac5:     	int3
180001ac6:     	int3
180001ac7:     	int3
180001ac8:     	int3
180001ac9:     	int3
180001aca:     	int3
180001acb:     	int3
180001acc:     	int3
180001acd:     	int3
180001ace:     	int3
180001acf:     	int3
180001ad0:     	movq	0x10(%rcx), %rax
180001ad4:     	lock
180001ad5:     	incq	(%rax)
180001ad8:     	movq	0x2701(%rip), %rax      # 0x1800041e0
180001adf:     	retq
180001ae0:     	subq	$0x28, %rsp
180001ae4:     	movq	0x10(%rcx), %rcx
180001ae8:     	callq	0x180002de0 <numba_list_iter_next+0x1d0>
180001aed:     	movq	0x26ec(%rip), %rax      # 0x1800041e0
180001af4:     	addq	$0x28, %rsp
180001af8:     	retq
180001af9:     	int3
180001afa:     	int3
180001afb:     	int3
180001afc:     	int3
180001afd:     	int3
180001afe:     	int3
180001aff:     	int3
180001b00:     	movq	0x10(%rcx), %rcx
180001b04:     	movq	0x18(%rcx), %rcx
180001b08:     	jmpq	*0x2641(%rip)           # 0x180004150
180001b0f:     	int3
180001b10:     	subq	$0x28, %rsp
180001b14:     	movq	0x10(%rcx), %rax
180001b18:     	testq	%rax, %rax
180001b1b:     	je	0x180001b39 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x6f9>
180001b1d:     	cmpq	$0x0, 0x18(%rax)
180001b22:     	je	0x180001b39 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x6f9>
180001b24:     	movq	(%rax), %rcx
180001b27:     	nop
180001b28:     	cmpq	$-0x1, %rcx
180001b2c:     	je	0x180001b39 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x6f9>
180001b2e:     	addq	$0x28, %rsp
180001b32:     	jmpq	*0x25cf(%rip)           # 0x180004108
180001b39:     	movq	0x2690(%rip), %rcx      # 0x1800041d0
180001b40:     	leaq	0x2e41(%rip), %rdx      # 0x180004988
180001b47:     	movq	(%rcx), %rcx
180001b4a:     	callq	*0x26e0(%rip)           # 0x180004230
180001b50:     	xorl	%eax, %eax
180001b52:     	addq	$0x28, %rsp
180001b56:     	retq
180001b57:     	int3
180001b58:     	int3
180001b59:     	int3
180001b5a:     	int3
180001b5b:     	int3
180001b5c:     	int3
180001b5d:     	int3
180001b5e:     	int3
180001b5f:     	int3
180001b60:     	movq	0x10(%rcx), %rcx
180001b64:     	movq	0x28(%rcx), %rcx
180001b68:     	jmpq	*0x25e1(%rip)           # 0x180004150
180001b6f:     	int3
180001b70:     	movq	0x10(%rcx), %rax
180001b74:     	movq	0x10(%rax), %rax
180001b78:     	testq	%rax, %rax
180001b7b:     	je	0x180001b8c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x74c>
180001b7d:     	movl	(%rax), %ecx
180001b7f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001b85:     	jae	0x180001baa <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x76a>
180001b87:     	incl	%ecx
180001b89:     	movl	%ecx, (%rax)
180001b8b:     	retq
180001b8c:     	movq	0x264d(%rip), %rcx      # 0x1800041e0
180001b93:     	movl	(%rcx), %eax
180001b95:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001b9a:     	jae	0x180001ba7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x767>
180001b9c:     	incl	%eax
180001b9e:     	movl	%eax, (%rcx)
180001ba0:     	movq	0x2639(%rip), %rcx      # 0x1800041e0
180001ba7:     	movq	%rcx, %rax
180001baa:     	retq
180001bab:     	int3
180001bac:     	int3
180001bad:     	int3
180001bae:     	int3
180001baf:     	int3
180001bb0:     	pushq	%rbx
180001bb2:     	subq	$0x20, %rsp
180001bb6:     	movq	%rcx, %rbx
180001bb9:     	movq	0x10(%rcx), %rcx
180001bbd:     	callq	0x180002de0 <numba_list_iter_next+0x1d0>
180001bc2:     	movq	0x8(%rbx), %rax
180001bc6:     	movq	%rbx, %rcx
180001bc9:     	addq	$0x20, %rsp
180001bcd:     	popq	%rbx
180001bce:     	jmpq	*0x140(%rax)
180001bd5:     	int3
180001bd6:     	int3
180001bd7:     	int3
180001bd8:     	int3
180001bd9:     	int3
180001bda:     	int3
180001bdb:     	int3
180001bdc:     	int3
180001bdd:     	int3
180001bde:     	int3
180001bdf:     	int3
180001be0:     	movq	%rdi, 0x18(%rsp)
180001be5:     	pushq	%r14
180001be7:     	subq	$0x20, %rsp
180001beb:     	movq	0x904e(%rip), %rax      # 0x18000ac40
180001bf2:     	movq	%rdx, %r14
180001bf5:     	movq	%rcx, %rdi
180001bf8:     	movq	0x8(%rcx), %rcx
180001bfc:     	movq	0x10(%rax), %rdx
180001c00:     	cmpq	%rdx, %rcx
180001c03:     	je	0x180001c20 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7e0>
180001c05:     	callq	*0x25ad(%rip)           # 0x1800041b8
180001c0b:     	testl	%eax, %eax
180001c0d:     	jne	0x180001c20 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x7e0>
180001c0f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001c14:     	movq	0x40(%rsp), %rdi
180001c19:     	addq	$0x20, %rsp
180001c1d:     	popq	%r14
180001c1f:     	retq
180001c20:     	movq	%rbx, 0x30(%rsp)
180001c25:     	movq	%rdi, %rdx
180001c28:     	movq	0x10(%rdi), %rbx
180001c2c:     	movq	%rbx, %rcx
180001c2f:     	movq	%rsi, 0x38(%rsp)
180001c34:     	movl	0x18(%rdi), %esi
180001c37:     	callq	0x180001990 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x550>
180001c3c:     	movq	%rax, (%r14)
180001c3f:     	movq	0x8ffa(%rip), %rax      # 0x18000ac40
180001c46:     	movq	%rbx, 0x20(%r14)
180001c4a:     	movl	0x18(%rdi), %edx
180001c4d:     	movq	0x20(%rdi), %rcx
180001c51:     	callq	*0x4f0(%rax)
180001c57:     	cmpl	$0x12, 0x8fee(%rip)     # 0x18000ac4c
180001c5e:     	movq	0x30(%rsp), %rbx
180001c63:     	movq	%rax, 0x10(%r14)
180001c67:     	movq	0x38(%rdi), %rax
180001c6b:     	jl	0x180001c73 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x833>
180001c6d:     	movq	0x28(%rax), %rax
180001c71:     	jmp	0x180001c77 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x837>
180001c73:     	movslq	0x20(%rax), %rax
180001c77:     	xorl	%r8d, %r8d
180001c7a:     	movq	%rax, 0x18(%r14)
180001c7e:     	movq	%rdi, 0x8(%r14)
180001c82:     	leaq	0x28(%r14), %rax
180001c86:     	testl	%esi, %esi
180001c88:     	jle	0x180001ccb <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x88b>
180001c8a:     	nopw	(%rax,%rax)
180001c90:     	movq	0x20(%rdi), %rcx
180001c94:     	movq	(%rcx,%r8,8), %rdx
180001c98:     	incl	%r8d
180001c9b:     	movq	%rdx, (%rax)
180001c9e:     	addq	$0x8, %rax
180001ca2:     	cmpl	%esi, %r8d
180001ca5:     	jl	0x180001c90 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x850>
180001ca7:     	xorl	%r8d, %r8d
180001caa:     	nopw	(%rax,%rax)
180001cb0:     	movq	0x28(%rdi), %rcx
180001cb4:     	leaq	0x8(%rax), %rax
180001cb8:     	movslq	%r8d, %rdx
180001cbb:     	incl	%r8d
180001cbe:     	movq	(%rcx,%rdx,8), %rdx
180001cc2:     	movq	%rdx, -0x8(%rax)
180001cc6:     	cmpl	%esi, %r8d
180001cc9:     	jl	0x180001cb0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x870>
180001ccb:     	movq	0x38(%rsp), %rsi
180001cd0:     	xorl	%eax, %eax
180001cd2:     	movq	0x40(%rsp), %rdi
180001cd7:     	addq	$0x20, %rsp
180001cdb:     	popq	%r14
180001cdd:     	retq
180001cde:     	int3
180001cdf:     	int3
180001ce0:     	pushq	%rbx
180001ce2:     	pushq	%rbp
180001ce3:     	pushq	%rsi
180001ce4:     	pushq	%rdi
180001ce5:     	subq	$0x28, %rsp
180001ce9:     	cmpq	$0x0, 0x8f5f(%rip)      # 0x18000ac50
180001cf1:     	movq	%rcx, %rbp
180001cf4:     	movslq	0x8(%rdx), %rdi
180001cf8:     	movq	(%rdx), %rsi
180001cfb:     	jne	0x180001d53 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x913>
180001cfd:     	leaq	0x2bc4(%rip), %rcx      # 0x1800048c8
180001d04:     	callq	*0x24fe(%rip)           # 0x180004208
180001d0a:     	movq	%rax, %rbx
180001d0d:     	testq	%rax, %rax
180001d10:     	je	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001d16:     	leaq	0x2bb3(%rip), %rdx      # 0x1800048d0
180001d1d:     	movq	%rax, %rcx
180001d20:     	callq	*0x243a(%rip)           # 0x180004160
180001d26:     	movl	(%rbx), %edx
180001d28:     	movq	%rax, 0x8f21(%rip)      # 0x18000ac50
180001d2f:     	testl	%edx, %edx
180001d31:     	js	0x180001d4a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x90a>
180001d33:     	subl	$0x1, %edx
180001d36:     	movl	%edx, (%rbx)
180001d38:     	jne	0x180001d4a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x90a>
180001d3a:     	movq	%rbx, %rcx
180001d3d:     	callq	*0x246d(%rip)           # 0x1800041b0
180001d43:     	movq	0x8f06(%rip), %rax      # 0x18000ac50
180001d4a:     	testq	%rax, %rax
180001d4d:     	je	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001d53:     	movq	%rdi, %rdx
180001d56:     	movq	%rsi, %rcx
180001d59:     	callq	*0x23c1(%rip)           # 0x180004120
180001d5f:     	movq	%rax, %rdi
180001d62:     	testq	%rax, %rax
180001d65:     	je	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001d67:     	movq	0x8ee2(%rip), %rcx      # 0x18000ac50
180001d6e:     	xorl	%r8d, %r8d
180001d71:     	movq	%rax, %rdx
180001d74:     	callq	*0x240e(%rip)           # 0x180004188
180001d7a:     	movl	(%rdi), %ecx
180001d7c:     	movq	%rax, %rbx
180001d7f:     	testl	%ecx, %ecx
180001d81:     	js	0x180001d93 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x953>
180001d83:     	subl	$0x1, %ecx
180001d86:     	movl	%ecx, (%rdi)
180001d88:     	jne	0x180001d93 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x953>
180001d8a:     	movq	%rdi, %rcx
180001d8d:     	callq	*0x241d(%rip)           # 0x1800041b0
180001d93:     	testq	%rbx, %rbx
180001d96:     	je	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001d98:     	movq	0x8(%rbx), %r8
180001d9c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001da7:     	jne	0x180001de5 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x9a5>
180001da9:     	movq	0x2478(%rip), %rcx      # 0x180004228
180001db0:     	leaq	0x2cd9(%rip), %rdx      # 0x180004a90
180001db7:     	movq	0x18(%r8), %r8
180001dbb:     	movq	(%rcx), %rcx
180001dbe:     	callq	*0x2404(%rip)           # 0x1800041c8
180001dc4:     	movl	(%rbx), %eax
180001dc6:     	testl	%eax, %eax
180001dc8:     	js	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001dca:     	subl	$0x1, %eax
180001dcd:     	movl	%eax, (%rbx)
180001dcf:     	jne	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001dd1:     	movq	%rbx, %rcx
180001dd4:     	callq	*0x23d6(%rip)           # 0x1800041b0
180001dda:     	xorl	%eax, %eax
180001ddc:     	addq	$0x28, %rsp
180001de0:     	popq	%rdi
180001de1:     	popq	%rsi
180001de2:     	popq	%rbp
180001de3:     	popq	%rbx
180001de4:     	retq
180001de5:     	xorl	%r8d, %r8d
180001de8:     	leaq	0x8511(%rip), %rcx      # 0x18000a300
180001def:     	xorl	%edx, %edx
180001df1:     	callq	*0x2419(%rip)           # 0x180004210
180001df7:     	movq	%rax, %rdi
180001dfa:     	testq	%rax, %rax
180001dfd:     	je	0x180001dc4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x984>
180001dff:     	movq	%rbp, %rcx
180001e02:     	movq	%rbx, 0x18(%rax)
180001e06:     	callq	*0x239c(%rip)           # 0x1800041a8
180001e0c:     	movq	%rax, 0x10(%rdi)
180001e10:     	movq	%rax, %rcx
180001e13:     	testq	%rax, %rax
180001e16:     	jne	0x180001e2a <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x9ea>
180001e18:     	movl	(%rdi), %eax
180001e1a:     	testl	%eax, %eax
180001e1c:     	js	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001e1e:     	subl	$0x1, %eax
180001e21:     	movl	%eax, (%rdi)
180001e23:     	jne	0x180001dda <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x99a>
180001e25:     	movq	%rdi, %rcx
180001e28:     	jmp	0x180001dd4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x994>
180001e2a:     	movl	(%rax), %eax
180001e2c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001e31:     	jae	0x180001e37 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x9f7>
180001e33:     	incl	%eax
180001e35:     	movl	%eax, (%rcx)
180001e37:     	movq	%rdi, %rax
180001e3a:     	addq	$0x28, %rsp
180001e3e:     	popq	%rdi
180001e3f:     	popq	%rsi
180001e40:     	popq	%rbp
180001e41:     	popq	%rbx
180001e42:     	retq
180001e43:     	int3
180001e44:     	int3
180001e45:     	int3
180001e46:     	int3
180001e47:     	int3
180001e48:     	int3
180001e49:     	int3
180001e4a:     	int3
180001e4b:     	int3
180001e4c:     	int3
180001e4d:     	int3
180001e4e:     	int3
180001e4f:     	int3
180001e50:     	movq	%r9, 0x20(%rsp)
180001e55:     	movq	%r8, 0x18(%rsp)
180001e5a:     	movq	%rdx, 0x10(%rsp)
180001e5f:     	movq	%rcx, 0x8(%rsp)
180001e64:     	pushq	%rbx
180001e65:     	pushq	%rbp
180001e66:     	pushq	%rsi
180001e67:     	pushq	%rdi
180001e68:     	pushq	%r12
180001e6a:     	pushq	%r13
180001e6c:     	pushq	%r14
180001e6e:     	pushq	%r15
180001e70:     	subq	$0x68, %rsp
180001e74:     	movq	%rcx, %r14
180001e77:     	movq	%r9, %r15
180001e7a:     	leaq	0x274f(%rip), %rcx      # 0x1800045d0
180001e81:     	movq	%r8, %r13
180001e84:     	movq	%rdx, %rsi
180001e87:     	callq	*0x237b(%rip)           # 0x180004208
180001e8d:     	movq	%rax, %rdi
180001e90:     	testq	%rax, %rax
180001e93:     	jne	0x180001ecc <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xa8c>
180001e95:     	movq	0x2274(%rip), %rcx      # 0x180004110
180001e9c:     	movq	(%rcx), %rcx
180001e9f:     	callq	*0x22f3(%rip)           # 0x180004198
180001ea5:     	testl	%eax, %eax
180001ea7:     	je	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001ead:     	callq	*0x22a5(%rip)           # 0x180004158
180001eb3:     	leaq	0x2736(%rip), %rcx      # 0x1800045f0
180001eba:     	callq	*0x2348(%rip)           # 0x180004208
180001ec0:     	movq	%rax, %rdi
180001ec3:     	testq	%rax, %rax
180001ec6:     	je	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001ecc:     	leaq	0x273d(%rip), %rdx      # 0x180004610
180001ed3:     	movq	%rdi, %rcx
180001ed6:     	callq	*0x2284(%rip)           # 0x180004160
180001edc:     	movl	(%rdi), %ecx
180001ede:     	movq	%rax, %rbx
180001ee1:     	testl	%ecx, %ecx
180001ee3:     	js	0x180001ef5 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xab5>
180001ee5:     	subl	$0x1, %ecx
180001ee8:     	movl	%ecx, (%rdi)
180001eea:     	jne	0x180001ef5 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xab5>
180001eec:     	movq	%rdi, %rcx
180001eef:     	callq	*0x22bb(%rip)           # 0x1800041b0
180001ef5:     	testq	%rbx, %rbx
180001ef8:     	je	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001efe:     	movq	0x21e3(%rip), %rax      # 0x1800040e8
180001f05:     	cmpq	%rax, 0x8(%rbx)
180001f09:     	je	0x180001f45 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb05>
180001f0b:     	movq	0x2326(%rip), %rcx      # 0x180004238
180001f12:     	leaq	0x2707(%rip), %rdx      # 0x180004620
180001f19:     	movq	(%rcx), %rcx
180001f1c:     	callq	*0x230e(%rip)           # 0x180004230
180001f22:     	movl	(%rbx), %eax
180001f24:     	testl	%eax, %eax
180001f26:     	js	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001f2c:     	subl	$0x1, %eax
180001f2f:     	movl	%eax, (%rbx)
180001f31:     	jne	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001f37:     	movq	%rbx, %rcx
180001f3a:     	callq	*0x2270(%rip)           # 0x1800041b0
180001f40:     	jmp	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001f45:     	xorl	%edx, %edx
180001f47:     	movq	%rbx, %rcx
180001f4a:     	callq	*0x2240(%rip)           # 0x180004190
180001f50:     	movl	(%rbx), %ecx
180001f52:     	movq	%rax, 0x8ce7(%rip)      # 0x18000ac40
180001f59:     	testl	%ecx, %ecx
180001f5b:     	js	0x180001f74 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb34>
180001f5d:     	subl	$0x1, %ecx
180001f60:     	movl	%ecx, (%rbx)
180001f62:     	jne	0x180001f74 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb34>
180001f64:     	movq	%rbx, %rcx
180001f67:     	callq	*0x2243(%rip)           # 0x1800041b0
180001f6d:     	movq	0x8ccc(%rip), %rax      # 0x18000ac40
180001f74:     	testq	%rax, %rax
180001f77:     	jne	0x180001f92 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb52>
180001f79:     	leaq	0x26c8(%rip), %rdx      # 0x180004648
180001f80:     	movq	0x22b1(%rip), %rcx      # 0x180004238
180001f87:     	movq	(%rcx), %rcx
180001f8a:     	callq	*0x22a0(%rip)           # 0x180004230
180001f90:     	jmp	0x180001fc7 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb87>
180001f92:     	callq	*(%rax)
180001f94:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180001f99:     	jbe	0x180001ffa <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xbba>
180001f9b:     	movq	0x2296(%rip), %rax      # 0x180004238
180001fa2:     	movq	(%rax), %rbx
180001fa5:     	movq	0x8c94(%rip), %rax      # 0x18000ac40
180001fac:     	callq	*(%rax)
180001fae:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180001fb4:     	leaq	0x26b5(%rip), %rdx      # 0x180004670
180001fbb:     	movl	%eax, %r9d
180001fbe:     	movq	%rbx, %rcx
180001fc1:     	callq	*0x2201(%rip)           # 0x1800041c8
180001fc7:     	callq	*0x229b(%rip)           # 0x180004268
180001fcd:     	movq	0x2124(%rip), %rcx      # 0x1800040f8
180001fd4:     	leaq	0x28bd(%rip), %rdx      # 0x180004898
180001fdb:     	movq	(%rcx), %rcx
180001fde:     	callq	*0x224c(%rip)           # 0x180004230
180001fe4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001fe9:     	addq	$0x68, %rsp
180001fed:     	popq	%r15
180001fef:     	popq	%r14
180001ff1:     	popq	%r13
180001ff3:     	popq	%r12
180001ff5:     	popq	%rdi
180001ff6:     	popq	%rsi
180001ff7:     	popq	%rbp
180001ff8:     	popq	%rbx
180001ff9:     	retq
180001ffa:     	movq	0x8c3f(%rip), %rax      # 0x18000ac40
180002001:     	callq	*0x698(%rax)
180002007:     	movl	%eax, 0x8c3f(%rip)      # 0x18000ac4c
18000200d:     	cmpl	$0x10, %eax
180002010:     	jge	0x18000202e <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xbee>
180002012:     	movq	0x221f(%rip), %rcx      # 0x180004238
180002019:     	leaq	0x26a0(%rip), %rdx      # 0x1800046c0
180002020:     	movl	%eax, %r9d
180002023:     	movl	$0x10, %r8d
180002029:     	movq	(%rcx), %rcx
18000202c:     	jmp	0x180001fc1 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb81>
18000202e:     	movq	0x8c0b(%rip), %rax      # 0x18000ac40
180002035:     	callq	*0x690(%rax)
18000203b:     	testl	%eax, %eax
18000203d:     	jne	0x18000204b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xc0b>
18000203f:     	leaq	0x27ca(%rip), %rdx      # 0x180004810
180002046:     	jmp	0x180001f80 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb40>
18000204b:     	cmpl	$0x1, %eax
18000204e:     	je	0x18000205c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xc1c>
180002050:     	leaq	0x27e9(%rip), %rdx      # 0x180004840
180002057:     	jmp	0x180001f80 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xb40>
18000205c:     	leaq	0x877d(%rip), %rcx      # 0x18000a7e0
180002063:     	callq	*0x20ff(%rip)           # 0x180004168
180002069:     	testl	%eax, %eax
18000206b:     	jne	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
180002071:     	leaq	0x8288(%rip), %rcx      # 0x18000a300
180002078:     	callq	*0x20ea(%rip)           # 0x180004168
18000207e:     	testl	%eax, %eax
180002080:     	jne	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
180002086:     	leaq	0x85b3(%rip), %rcx      # 0x18000a640
18000208d:     	callq	*0x20d5(%rip)           # 0x180004168
180002093:     	testl	%eax, %eax
180002095:     	jne	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
18000209b:     	xorl	%ebx, %ebx
18000209d:     	cmpl	%ebx, 0x8ba5(%rip)      # 0x18000ac48
1800020a3:     	jne	0x1800020e6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xca6>
1800020a5:     	movq	%gs:0x58, %rax
1800020ae:     	movl	0x8ba4(%rip), %ecx      # 0x18000ac58
1800020b4:     	movl	$0x1, 0x8b8a(%rip)      # 0x18000ac48
1800020be:     	movq	(%rax,%rcx,8), %rdx
1800020c2:     	movl	$0x10, %eax
1800020c7:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800020ce:     	movl	$0x9f0, %eax            # imm = 0x9F0
1800020d3:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800020da:     	movl	$0x13d0, %eax           # imm = 0x13D0
1800020df:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800020e6:     	movl	%ebx, 0x8b0c(%rip)      # 0x18000abf8
1800020ec:     	movq	%rbx, %rax
1800020ef:     	movb	%bl, 0x8b0b(%rip)       # 0x18000ac00
1800020f5:     	movq	%rbx, %rcx
1800020f8:     	xchgq	%rax, 0x8b09(%rip)      # 0x18000ac08
1800020ff:     	xchgq	%rcx, 0x8b0a(%rip)      # 0x18000ac10
180002106:     	movq	%rbx, %rax
180002109:     	movq	%rbx, %rcx
18000210c:     	xchgq	%rax, 0x8b05(%rip)      # 0x18000ac18
180002113:     	xchgq	%rcx, 0x8b06(%rip)      # 0x18000ac20
18000211a:     	movq	0x1f3f(%rip), %rax      # 0x180004060
180002121:     	leaq	0x8378(%rip), %rcx      # 0x18000a4a0
180002128:     	movq	%rax, 0x8af9(%rip)      # 0x18000ac28
18000212f:     	movq	0x1f3a(%rip), %rax      # 0x180004070
180002136:     	movq	%rax, 0x8af3(%rip)      # 0x18000ac30
18000213d:     	movq	0x1f24(%rip), %rax      # 0x180004068
180002144:     	movq	%rax, 0x8aed(%rip)      # 0x18000ac38
18000214b:     	movq	0x20be(%rip), %rax      # 0x180004210
180002152:     	movq	%rax, 0x847f(%rip)      # 0x18000a5d8
180002159:     	callq	*0x2009(%rip)           # 0x180004168
18000215f:     	testl	%eax, %eax
180002161:     	jne	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
180002167:     	leaq	0x27ba(%rip), %rdx      # 0x180004928
18000216e:     	movq	%r14, %rcx
180002171:     	callq	*0x1fe9(%rip)           # 0x180004160
180002177:     	movq	%rax, 0x28(%rsp)
18000217c:     	movq	%rax, %rdi
18000217f:     	testq	%rax, %rax
180002182:     	je	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
180002188:     	leaq	0x2932(%rip), %rcx      # 0x180004ac1
18000218f:     	callq	*0x1f6b(%rip)           # 0x180004100
180002195:     	movq	%rax, 0x20(%rsp)
18000219a:     	movq	%rax, %r12
18000219d:     	testq	%rax, %rax
1800021a0:     	je	0x1800024e4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x10a4>
1800021a6:     	movl	%ebx, %ebp
1800021a8:     	cmpq	%rbx, (%rsi)
1800021ab:     	je	0x180002354 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xf14>
1800021b1:     	movslq	%ebp, %rbx
1800021b4:     	leaq	0x30(%rsp), %rdx
1800021b9:     	movq	%r14, %rcx
1800021bc:     	leaq	(%rbx,%rbx,4), %rax
1800021c0:     	movups	(%r13,%rax,8), %xmm0
1800021c6:     	movups	0x10(%r13,%rax,8), %xmm1
1800021cc:     	movaps	%xmm0, 0x30(%rsp)
1800021d1:     	movsd	0x20(%r13,%rax,8), %xmm0
1800021d8:     	movsd	%xmm0, 0x50(%rsp)
1800021de:     	movaps	%xmm1, 0x40(%rsp)
1800021e3:     	callq	0x180001ce0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x8a0>
1800021e8:     	movq	%rax, %r14
1800021eb:     	testq	%rax, %rax
1800021ee:     	je	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
1800021f4:     	movq	(%rsi), %rcx
1800021f7:     	callq	*0x1f03(%rip)           # 0x180004100
1800021fd:     	movq	%rax, %r13
180002200:     	testq	%rax, %rax
180002203:     	je	0x180002507 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x10c7>
180002209:     	movq	(%r15,%rbx,8), %rcx
18000220d:     	xorl	%edx, %edx
18000220f:     	movq	%r14, (%rcx)
180002212:     	leaq	0x85c7(%rip), %rcx      # 0x18000a7e0
180002219:     	movq	0x8(%rsi), %r12
18000221d:     	callq	*0x1f25(%rip)           # 0x180004148
180002223:     	movq	%rax, %rbx
180002226:     	testq	%rax, %rax
180002229:     	je	0x1800022a6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe66>
18000222b:     	movq	%r13, %rcx
18000222e:     	callq	*0x1f44(%rip)           # 0x180004178
180002234:     	movq	%rax, %rdi
180002237:     	testq	%rax, %rax
18000223a:     	je	0x18000225c <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe1c>
18000223c:     	movq	%rax, %rcx
18000223f:     	callq	0x180003a95 <numba_list_iter_next+0xe85>
180002244:     	leaq	0x1(%rax), %rcx
180002248:     	callq	*0x1fca(%rip)           # 0x180004218
18000224e:     	movq	%rax, %rsi
180002251:     	testq	%rax, %rax
180002254:     	jne	0x180002264 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe24>
180002256:     	callq	*0x1edc(%rip)           # 0x180004138
18000225c:     	xorl	%eax, %eax
18000225e:     	movq	%rax, 0x20(%rbx)
180002262:     	jmp	0x180002295 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe55>
180002264:     	movq	%rdi, %rdx
180002267:     	movq	%rsi, %rcx
18000226a:     	callq	0x180003a8f <numba_list_iter_next+0xe7f>
18000226f:     	movq	0x20(%rsp), %rcx
180002274:     	movq	%rsi, 0x20(%rbx)
180002278:     	movq	%r12, 0x28(%rbx)
18000227c:     	movl	$0x3, 0x30(%rbx)
180002283:     	callq	0x180001760 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x320>
180002288:     	movq	%rax, 0x38(%rbx)
18000228c:     	testq	%rax, %rax
18000228f:     	jne	0x180002400 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfc0>
180002295:     	movl	(%rbx), %eax
180002297:     	testl	%eax, %eax
180002299:     	js	0x1800022a6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe66>
18000229b:     	subl	$0x1, %eax
18000229e:     	movl	%eax, (%rbx)
1800022a0:     	je	0x18000244d <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x100d>
1800022a6:     	xorl	%edi, %edi
1800022a8:     	movl	(%r14), %eax
1800022ab:     	testl	%eax, %eax
1800022ad:     	js	0x1800022c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe80>
1800022af:     	subl	$0x1, %eax
1800022b2:     	movl	%eax, (%r14)
1800022b5:     	jne	0x1800022c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe80>
1800022b7:     	movq	%r14, %rcx
1800022ba:     	callq	*0x1ef0(%rip)           # 0x1800041b0
1800022c0:     	movl	(%r13), %eax
1800022c4:     	testl	%eax, %eax
1800022c6:     	js	0x1800022da <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe9a>
1800022c8:     	subl	$0x1, %eax
1800022cb:     	movl	%eax, (%r13)
1800022cf:     	jne	0x1800022da <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe9a>
1800022d1:     	movq	%r13, %rcx
1800022d4:     	callq	*0x1ed6(%rip)           # 0x1800041b0
1800022da:     	testq	%rdi, %rdi
1800022dd:     	je	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
1800022e3:     	movq	0xb8(%rsp), %rsi
1800022eb:     	movq	%rdi, %r8
1800022ee:     	movq	0xb0(%rsp), %r14
1800022f6:     	movq	%r14, %rcx
1800022f9:     	movq	(%rsi), %rdx
1800022fc:     	callq	*0x1ef6(%rip)           # 0x1800041f8
180002302:     	movl	(%rdi), %ecx
180002304:     	testl	%eax, %eax
180002306:     	jne	0x1800024aa <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x106a>
18000230c:     	testl	%ecx, %ecx
18000230e:     	js	0x180002322 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xee2>
180002310:     	leal	-0x1(%rcx), %eax
180002313:     	movl	%eax, (%rdi)
180002315:     	testl	%eax, %eax
180002317:     	jne	0x180002322 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xee2>
180002319:     	movq	%rdi, %rcx
18000231c:     	callq	*0x1e8e(%rip)           # 0x1800041b0
180002322:     	movq	0xc8(%rsp), %r15
18000232a:     	addq	$0x20, %rsi
18000232e:     	movq	0xc0(%rsp), %r13
180002336:     	incl	%ebp
180002338:     	movq	%rsi, 0xb8(%rsp)
180002340:     	cmpq	$0x0, (%rsi)
180002344:     	jne	0x1800021b1 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xd71>
18000234a:     	movq	0x20(%rsp), %r12
18000234f:     	movq	0x28(%rsp), %rdi
180002354:     	movslq	%ebp, %rax
180002357:     	cmpq	$0x0, (%r15,%rax,8)
18000235c:     	je	0x1800023c9 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xf89>
18000235e:     	nop
180002360:     	movslq	%ebp, %rbx
180002363:     	leaq	0x30(%rsp), %rdx
180002368:     	movq	%r14, %rcx
18000236b:     	leaq	(%rbx,%rbx,4), %rax
18000236f:     	movups	(%r13,%rax,8), %xmm0
180002375:     	movups	0x10(%r13,%rax,8), %xmm1
18000237b:     	movaps	%xmm0, 0x30(%rsp)
180002380:     	movsd	0x20(%r13,%rax,8), %xmm0
180002387:     	movsd	%xmm0, 0x50(%rsp)
18000238d:     	movaps	%xmm1, 0x40(%rsp)
180002392:     	callq	0x180001ce0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x8a0>
180002397:     	testq	%rax, %rax
18000239a:     	je	0x1800024c5 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1085>
1800023a0:     	movq	(%r15,%rbx,8), %rcx
1800023a4:     	movq	%rax, (%rcx)
1800023a7:     	movl	(%rax), %ecx
1800023a9:     	testl	%ecx, %ecx
1800023ab:     	js	0x1800023bd <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xf7d>
1800023ad:     	subl	$0x1, %ecx
1800023b0:     	movl	%ecx, (%rax)
1800023b2:     	jne	0x1800023bd <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xf7d>
1800023b4:     	movq	%rax, %rcx
1800023b7:     	callq	*0x1df3(%rip)           # 0x1800041b0
1800023bd:     	incl	%ebp
1800023bf:     	movslq	%ebp, %rax
1800023c2:     	cmpq	$0x0, (%r15,%rax,8)
1800023c7:     	jne	0x180002360 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xf20>
1800023c9:     	movl	(%r12), %eax
1800023cd:     	testl	%eax, %eax
1800023cf:     	js	0x1800023e3 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfa3>
1800023d1:     	subl	$0x1, %eax
1800023d4:     	movl	%eax, (%r12)
1800023d8:     	jne	0x1800023e3 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfa3>
1800023da:     	movq	%r12, %rcx
1800023dd:     	callq	*0x1dcd(%rip)           # 0x1800041b0
1800023e3:     	movl	(%rdi), %eax
1800023e5:     	testl	%eax, %eax
1800023e7:     	js	0x1800023f9 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfb9>
1800023e9:     	subl	$0x1, %eax
1800023ec:     	movl	%eax, (%rdi)
1800023ee:     	jne	0x1800023f9 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfb9>
1800023f0:     	movq	%rdi, %rcx
1800023f3:     	callq	*0x1db7(%rip)           # 0x1800041b0
1800023f9:     	xorl	%eax, %eax
1800023fb:     	jmp	0x180001fe9 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba9>
180002400:     	movl	(%r14), %eax
180002403:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002408:     	jae	0x18000240f <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xfcf>
18000240a:     	incl	%eax
18000240c:     	movl	%eax, (%r14)
18000240f:     	movq	0xb0(%rsp), %rcx
180002417:     	leaq	0x250a(%rip), %rdx      # 0x180004928
18000241e:     	movq	%r14, 0x18(%rbx)
180002422:     	movq	$0x0, 0x40(%rbx)
18000242a:     	callq	*0x1d30(%rip)           # 0x180004160
180002430:     	movq	%rax, %rsi
180002433:     	testq	%rax, %rax
180002436:     	jne	0x18000245b <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x101b>
180002438:     	movl	(%rbx), %eax
18000243a:     	testl	%eax, %eax
18000243c:     	js	0x1800022a6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe66>
180002442:     	subl	$0x1, %eax
180002445:     	movl	%eax, (%rbx)
180002447:     	jne	0x1800022a6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe66>
18000244d:     	movq	%rbx, %rcx
180002450:     	callq	*0x1d5a(%rip)           # 0x1800041b0
180002456:     	jmp	0x1800022a6 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe66>
18000245b:     	xorl	%r9d, %r9d
18000245e:     	leaq	0x20(%rbx), %rcx
180002462:     	movq	%rsi, %r8
180002465:     	movq	%rbx, %rdx
180002468:     	callq	*0x1cd2(%rip)           # 0x180004140
18000246e:     	movq	%rax, %rdi
180002471:     	movl	(%rbx), %eax
180002473:     	testl	%eax, %eax
180002475:     	js	0x180002487 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1047>
180002477:     	subl	$0x1, %eax
18000247a:     	movl	%eax, (%rbx)
18000247c:     	jne	0x180002487 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1047>
18000247e:     	movq	%rbx, %rcx
180002481:     	callq	*0x1d29(%rip)           # 0x1800041b0
180002487:     	movl	(%rsi), %eax
180002489:     	testl	%eax, %eax
18000248b:     	js	0x1800022a8 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe68>
180002491:     	subl	$0x1, %eax
180002494:     	movl	%eax, (%rsi)
180002496:     	jne	0x1800022a8 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe68>
18000249c:     	movq	%rsi, %rcx
18000249f:     	callq	*0x1d0b(%rip)           # 0x1800041b0
1800024a5:     	jmp	0x1800022a8 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xe68>
1800024aa:     	testl	%ecx, %ecx
1800024ac:     	js	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
1800024ae:     	leal	-0x1(%rcx), %eax
1800024b1:     	movl	%eax, (%rdi)
1800024b3:     	testl	%eax, %eax
1800024b5:     	jne	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
1800024b7:     	movq	%rdi, %rcx
1800024ba:     	callq	*0x1cf0(%rip)           # 0x1800041b0
1800024c0:     	movq	0x20(%rsp), %r12
1800024c5:     	movl	(%r12), %eax
1800024c9:     	testl	%eax, %eax
1800024cb:     	js	0x1800024df <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x109f>
1800024cd:     	subl	$0x1, %eax
1800024d0:     	movl	%eax, (%r12)
1800024d4:     	jne	0x1800024df <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x109f>
1800024d6:     	movq	%r12, %rcx
1800024d9:     	callq	*0x1cd1(%rip)           # 0x1800041b0
1800024df:     	movq	0x28(%rsp), %rdi
1800024e4:     	movl	(%rdi), %eax
1800024e6:     	testl	%eax, %eax
1800024e8:     	js	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
1800024ee:     	subl	$0x1, %eax
1800024f1:     	movl	%eax, (%rdi)
1800024f3:     	jne	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
1800024f9:     	movq	%rdi, %rcx
1800024fc:     	callq	*0x1cae(%rip)           # 0x1800041b0
180002502:     	jmp	0x180001fe4 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0xba4>
180002507:     	movl	(%r14), %eax
18000250a:     	testl	%eax, %eax
18000250c:     	js	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
18000250e:     	subl	$0x1, %eax
180002511:     	movl	%eax, (%r14)
180002514:     	jne	0x1800024c0 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x1080>
180002516:     	movq	%r14, %rcx
180002519:     	jmp	0x1800024ba <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x107a>
18000251b:     	int3
18000251c:     	int3
18000251d:     	int3
18000251e:     	int3
18000251f:     	int3
180002520:     	leaq	0x8749(%rip), %rax      # 0x18000ac70
180002527:     	retq
180002528:     	int3
180002529:     	int3
18000252a:     	int3
18000252b:     	int3
18000252c:     	int3
18000252d:     	int3
18000252e:     	int3
18000252f:     	int3

0000000180002530 <numba_list_set_method_table>:
180002530:     	movups	(%rdx), %xmm0
180002533:     	movups	%xmm0, 0x20(%rcx)
180002537:     	retq
180002538:     	int3
180002539:     	int3
18000253a:     	int3
18000253b:     	int3
18000253c:     	int3
18000253d:     	int3
18000253e:     	int3
18000253f:     	int3

0000000180002540 <numba_list_new>:
180002540:     	pushq	%rbx
180002542:     	pushq	%rbp
180002543:     	pushq	%rsi
180002544:     	pushq	%rdi
180002545:     	subq	$0x28, %rsp
180002549:     	movq	%rcx, %rsi
18000254c:     	movq	%r8, %rdi
18000254f:     	movl	$0x38, %ecx
180002554:     	movq	%rdx, %rbp
180002557:     	callq	*0x1b03(%rip)           # 0x180004060
18000255d:     	movq	%rax, %rbx
180002560:     	testq	%rax, %rax
180002563:     	je	0x1800025cd <numba_list_new+0x8d>
180002565:     	movq	$0x0, (%rax)
18000256c:     	xorps	%xmm0, %xmm0
18000256f:     	movq	%rbp, 0x8(%rax)
180002573:     	movq	%rdi, 0x10(%rax)
180002577:     	movl	$0x1, 0x18(%rax)
18000257e:     	movups	%xmm0, 0x20(%rax)
180002582:     	testq	%rdi, %rdi
180002585:     	je	0x1800025db <numba_list_new+0x9b>
180002587:     	imulq	%rbp, %rdi
18000258b:     	movl	$0x8, %ecx
180002590:     	movq	%rdi, %rax
180002593:     	cqto
180002595:     	andl	$0x7, %edx
180002598:     	addq	%rdx, %rax
18000259b:     	andl	$0x7, %eax
18000259e:     	subq	%rdx, %rax
1800025a1:     	subq	%rax, %rcx
1800025a4:     	movq	%rcx, %rax
1800025a7:     	cqto
1800025a9:     	andl	$0x7, %edx
1800025ac:     	leaq	(%rdx,%rax), %rcx
1800025b0:     	andl	$0x7, %ecx
1800025b3:     	subq	%rdx, %rcx
1800025b6:     	addq	%rdi, %rcx
1800025b9:     	callq	*0x1aa1(%rip)           # 0x180004060
1800025bf:     	testq	%rax, %rax
1800025c2:     	jne	0x1800025dd <numba_list_new+0x9d>
1800025c4:     	movq	%rbx, %rcx
1800025c7:     	callq	*0x1a9b(%rip)           # 0x180004068
1800025cd:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800025d2:     	addq	$0x28, %rsp
1800025d6:     	popq	%rdi
1800025d7:     	popq	%rsi
1800025d8:     	popq	%rbp
1800025d9:     	popq	%rbx
1800025da:     	retq
1800025db:     	xorl	%eax, %eax
1800025dd:     	movq	%rax, 0x30(%rbx)
1800025e1:     	xorl	%eax, %eax
1800025e3:     	movq	%rbx, (%rsi)
1800025e6:     	addq	$0x28, %rsp
1800025ea:     	popq	%rdi
1800025eb:     	popq	%rsi
1800025ec:     	popq	%rbp
1800025ed:     	popq	%rbx
1800025ee:     	retq
1800025ef:     	int3

00000001800025f0 <numba_list_free>:
1800025f0:     	pushq	%rbx
1800025f2:     	subq	$0x20, %rsp
1800025f6:     	cmpq	$0x0, 0x28(%rcx)
1800025fb:     	movq	%rcx, %rbx
1800025fe:     	je	0x180002634 <numba_list_free+0x44>
180002600:     	movq	%rdi, 0x30(%rsp)
180002605:     	xorl	%edi, %edi
180002607:     	cmpq	%rdi, (%rcx)
18000260a:     	jle	0x18000262f <numba_list_free+0x3f>
18000260c:     	nopl	(%rax)
180002610:     	movq	0x28(%rbx), %rax
180002614:     	testq	%rax, %rax
180002617:     	je	0x180002627 <numba_list_free+0x37>
180002619:     	movq	%rdi, %rcx
18000261c:     	imulq	0x8(%rbx), %rcx
180002621:     	addq	0x30(%rbx), %rcx
180002625:     	callq	*%rax
180002627:     	incq	%rdi
18000262a:     	cmpq	(%rbx), %rdi
18000262d:     	jl	0x180002610 <numba_list_free+0x20>
18000262f:     	movq	0x30(%rsp), %rdi
180002634:     	movq	0x30(%rbx), %rcx
180002638:     	testq	%rcx, %rcx
18000263b:     	je	0x180002643 <numba_list_free+0x53>
18000263d:     	callq	*0x1a25(%rip)           # 0x180004068
180002643:     	movq	%rbx, %rcx
180002646:     	addq	$0x20, %rsp
18000264a:     	popq	%rbx
18000264b:     	jmpq	*0x1a16(%rip)           # 0x180004068
180002652:     	int3
180002653:     	int3
180002654:     	int3
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

0000000180002660 <numba_list_base_ptr>:
180002660:     	movq	0x30(%rcx), %rax
180002664:     	retq
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

0000000180002670 <numba_list_size_address>:
180002670:     	movq	%rcx, %rax
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

0000000180002680 <numba_list_length>:
180002680:     	movq	(%rcx), %rax
180002683:     	retq
180002684:     	int3
180002685:     	int3
180002686:     	int3
180002687:     	int3
180002688:     	int3
180002689:     	int3
18000268a:     	int3
18000268b:     	int3
18000268c:     	int3
18000268d:     	int3
18000268e:     	int3
18000268f:     	int3

0000000180002690 <numba_list_allocated>:
180002690:     	movq	0x10(%rcx), %rax
180002694:     	retq
180002695:     	int3
180002696:     	int3
180002697:     	int3
180002698:     	int3
180002699:     	int3
18000269a:     	int3
18000269b:     	int3
18000269c:     	int3
18000269d:     	int3
18000269e:     	int3
18000269f:     	int3

00000001800026a0 <numba_list_is_mutable>:
1800026a0:     	movl	0x18(%rcx), %eax
1800026a3:     	retq
1800026a4:     	int3
1800026a5:     	int3
1800026a6:     	int3
1800026a7:     	int3
1800026a8:     	int3
1800026a9:     	int3
1800026aa:     	int3
1800026ab:     	int3
1800026ac:     	int3
1800026ad:     	int3
1800026ae:     	int3
1800026af:     	int3

00000001800026b0 <numba_list_set_is_mutable>:
1800026b0:     	movl	%edx, 0x18(%rcx)
1800026b3:     	retq
1800026b4:     	int3
1800026b5:     	int3
1800026b6:     	int3
1800026b7:     	int3
1800026b8:     	int3
1800026b9:     	int3
1800026ba:     	int3
1800026bb:     	int3
1800026bc:     	int3
1800026bd:     	int3
1800026be:     	int3
1800026bf:     	int3

00000001800026c0 <numba_list_setitem>:
1800026c0:     	movq	%rbx, 0x10(%rsp)
1800026c5:     	pushq	%rsi
1800026c6:     	subq	$0x20, %rsp
1800026ca:     	cmpl	$0x0, 0x18(%rcx)
1800026ce:     	movq	%r8, %rsi
1800026d1:     	movq	%rcx, %rbx
1800026d4:     	jne	0x1800026e6 <numba_list_setitem+0x26>
1800026d6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800026db:     	movq	0x38(%rsp), %rbx
1800026e0:     	addq	$0x20, %rsp
1800026e4:     	popq	%rsi
1800026e5:     	retq
1800026e6:     	cmpq	(%rcx), %rdx
1800026e9:     	jb	0x1800026fb <numba_list_setitem+0x3b>
1800026eb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800026f0:     	movq	0x38(%rsp), %rbx
1800026f5:     	addq	$0x20, %rsp
1800026f9:     	popq	%rsi
1800026fa:     	retq
1800026fb:     	imulq	0x8(%rcx), %rdx
180002700:     	movq	0x28(%rcx), %rax
180002704:     	movq	%rdi, 0x30(%rsp)
180002709:     	movq	0x30(%rcx), %rdi
18000270d:     	addq	%rdx, %rdi
180002710:     	testq	%rax, %rax
180002713:     	je	0x18000271a <numba_list_setitem+0x5a>
180002715:     	movq	%rdi, %rcx
180002718:     	callq	*%rax
18000271a:     	movq	0x8(%rbx), %r8
18000271e:     	movq	%rsi, %rdx
180002721:     	movq	%rdi, %rcx
180002724:     	callq	0x180003a83 <numba_list_iter_next+0xe73>
180002729:     	movq	0x20(%rbx), %rax
18000272d:     	testq	%rax, %rax
180002730:     	je	0x180002737 <numba_list_setitem+0x77>
180002732:     	movq	%rdi, %rcx
180002735:     	callq	*%rax
180002737:     	movq	0x30(%rsp), %rdi
18000273c:     	xorl	%eax, %eax
18000273e:     	movq	0x38(%rsp), %rbx
180002743:     	addq	$0x20, %rsp
180002747:     	popq	%rsi
180002748:     	retq
180002749:     	int3
18000274a:     	int3
18000274b:     	int3
18000274c:     	int3
18000274d:     	int3
18000274e:     	int3
18000274f:     	int3

0000000180002750 <numba_list_getitem>:
180002750:     	subq	$0x28, %rsp
180002754:     	movq	%r8, %r9
180002757:     	movq	%rdx, %rax
18000275a:     	cmpq	(%rcx), %rdx
18000275d:     	jb	0x180002769 <numba_list_getitem+0x19>
18000275f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002764:     	addq	$0x28, %rsp
180002768:     	retq
180002769:     	movq	0x8(%rcx), %r8
18000276d:     	movq	%r8, %rdx
180002770:     	imulq	%rax, %rdx
180002774:     	addq	0x30(%rcx), %rdx
180002778:     	movq	%r9, %rcx
18000277b:     	callq	0x180003a83 <numba_list_iter_next+0xe73>
180002780:     	xorl	%eax, %eax
180002782:     	addq	$0x28, %rsp
180002786:     	retq
180002787:     	int3
180002788:     	int3
180002789:     	int3
18000278a:     	int3
18000278b:     	int3
18000278c:     	int3
18000278d:     	int3
18000278e:     	int3
18000278f:     	int3

0000000180002790 <numba_list_append>:
180002790:     	movq	%rbx, 0x10(%rsp)
180002795:     	pushq	%rsi
180002796:     	subq	$0x20, %rsp
18000279a:     	cmpl	$0x0, 0x18(%rcx)
18000279e:     	movq	%rdx, %rsi
1800027a1:     	movq	%rcx, %rbx
1800027a4:     	jne	0x1800027b6 <numba_list_append+0x26>
1800027a6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800027ab:     	movq	0x38(%rsp), %rbx
1800027b0:     	addq	$0x20, %rsp
1800027b4:     	popq	%rsi
1800027b5:     	retq
1800027b6:     	movq	(%rcx), %rdx
1800027b9:     	incq	%rdx
1800027bc:     	callq	0x180002810 <numba_list_resize>
1800027c1:     	testl	%eax, %eax
1800027c3:     	js	0x1800027fc <numba_list_append+0x6c>
1800027c5:     	movq	0x8(%rbx), %r8
1800027c9:     	movq	%rsi, %rdx
1800027cc:     	movq	%rdi, 0x30(%rsp)
1800027d1:     	movq	(%rbx), %rdi
1800027d4:     	decq	%rdi
1800027d7:     	imulq	%r8, %rdi
1800027db:     	addq	0x30(%rbx), %rdi
1800027df:     	movq	%rdi, %rcx
1800027e2:     	callq	0x180003a83 <numba_list_iter_next+0xe73>
1800027e7:     	movq	0x20(%rbx), %rax
1800027eb:     	testq	%rax, %rax
1800027ee:     	je	0x1800027f5 <numba_list_append+0x65>
1800027f0:     	movq	%rdi, %rcx
1800027f3:     	callq	*%rax
1800027f5:     	movq	0x30(%rsp), %rdi
1800027fa:     	xorl	%eax, %eax
1800027fc:     	movq	0x38(%rsp), %rbx
180002801:     	addq	$0x20, %rsp
180002805:     	popq	%rsi
180002806:     	retq
180002807:     	int3
180002808:     	int3
180002809:     	int3
18000280a:     	int3
18000280b:     	int3
18000280c:     	int3
18000280d:     	int3
18000280e:     	int3
18000280f:     	int3

0000000180002810 <numba_list_resize>:
180002810:     	movq	%rsi, 0x18(%rsp)
180002815:     	pushq	%rdi
180002816:     	subq	$0x20, %rsp
18000281a:     	cmpl	$0x0, 0x18(%rcx)
18000281e:     	movq	%rdx, %rsi
180002821:     	movq	%rcx, %rdi
180002824:     	jne	0x180002836 <numba_list_resize+0x26>
180002826:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000282b:     	movq	0x40(%rsp), %rsi
180002830:     	addq	$0x20, %rsp
180002834:     	popq	%rdi
180002835:     	retq
180002836:     	movq	0x10(%rcx), %rax
18000283a:     	cmpq	%rsi, %rax
18000283d:     	jl	0x180002857 <numba_list_resize+0x47>
18000283f:     	sarq	%rax
180002842:     	cmpq	%rax, %rsi
180002845:     	jl	0x180002857 <numba_list_resize+0x47>
180002847:     	movq	%rsi, (%rcx)
18000284a:     	xorl	%eax, %eax
18000284c:     	movq	0x40(%rsp), %rsi
180002851:     	addq	$0x20, %rsp
180002855:     	popq	%rdi
180002856:     	retq
180002857:     	cmpq	$0x9, %rsi
18000285b:     	movq	%rbp, 0x38(%rsp)
180002860:     	movl	$0x3, %ecx
180002865:     	movl	$0x6, %eax
18000286a:     	cmovll	%ecx, %eax
18000286d:     	movq	%rsi, %r8
180002870:     	movq	0x8(%rdi), %rcx
180002874:     	addq	%rsi, %rax
180002877:     	sarq	$0x3, %r8
18000287b:     	xorl	%edx, %edx
18000287d:     	addq	%rax, %r8
180002880:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000288a:     	divq	%rcx
18000288d:     	cmpq	%rax, %r8
180002890:     	ja	0x18000290b <numba_list_resize+0xfb>
180002892:     	xorl	%ebp, %ebp
180002894:     	movq	%rbx, 0x30(%rsp)
180002899:     	testq	%rsi, %rsi
18000289c:     	cmovneq	%r8, %rbp
1800028a0:     	movq	%rbp, %rbx
1800028a3:     	imulq	%rcx, %rbx
1800028a7:     	movl	$0x8, %ecx
1800028ac:     	movq	%rbx, %rax
1800028af:     	cqto
1800028b1:     	andl	$0x7, %edx
1800028b4:     	addq	%rdx, %rax
1800028b7:     	andl	$0x7, %eax
1800028ba:     	subq	%rdx, %rax
1800028bd:     	subq	%rax, %rcx
1800028c0:     	movq	%rcx, %rax
1800028c3:     	movq	0x30(%rdi), %rcx
1800028c7:     	cqto
1800028c9:     	andl	$0x7, %edx
1800028cc:     	addq	%rdx, %rax
1800028cf:     	andl	$0x7, %eax
1800028d2:     	subq	%rdx, %rax
1800028d5:     	leaq	(%rbx,%rax), %rdx
1800028d9:     	callq	*0x1791(%rip)           # 0x180004070
1800028df:     	testq	%rbx, %rbx
1800028e2:     	movq	0x30(%rsp), %rbx
1800028e7:     	je	0x1800028ee <numba_list_resize+0xde>
1800028e9:     	testq	%rax, %rax
1800028ec:     	je	0x18000290b <numba_list_resize+0xfb>
1800028ee:     	movq	%rax, 0x30(%rdi)
1800028f2:     	xorl	%eax, %eax
1800028f4:     	movq	%rbp, 0x10(%rdi)
1800028f8:     	movq	0x38(%rsp), %rbp
1800028fd:     	movq	%rsi, (%rdi)
180002900:     	movq	0x40(%rsp), %rsi
180002905:     	addq	$0x20, %rsp
180002909:     	popq	%rdi
18000290a:     	retq
18000290b:     	movq	0x38(%rsp), %rbp
180002910:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002915:     	movq	0x40(%rsp), %rsi
18000291a:     	addq	$0x20, %rsp
18000291e:     	popq	%rdi
18000291f:     	retq

0000000180002920 <numba_list_delitem>:
180002920:     	movq	%rbx, 0x10(%rsp)
180002925:     	pushq	%rdi
180002926:     	subq	$0x20, %rsp
18000292a:     	cmpl	$0x0, 0x18(%rcx)
18000292e:     	movq	%rdx, %rdi
180002931:     	movq	%rcx, %rbx
180002934:     	jne	0x180002946 <numba_list_delitem+0x26>
180002936:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000293b:     	movq	0x38(%rsp), %rbx
180002940:     	addq	$0x20, %rsp
180002944:     	popq	%rdi
180002945:     	retq
180002946:     	cmpq	(%rcx), %rdi
180002949:     	jb	0x18000295b <numba_list_delitem+0x3b>
18000294b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002950:     	movq	0x38(%rsp), %rbx
180002955:     	addq	$0x20, %rsp
180002959:     	popq	%rdi
18000295a:     	retq
18000295b:     	movq	0x28(%rcx), %rax
18000295f:     	movq	%rsi, 0x30(%rsp)
180002964:     	movq	%rdi, %rsi
180002967:     	imulq	0x8(%rcx), %rsi
18000296c:     	addq	0x30(%rcx), %rsi
180002970:     	testq	%rax, %rax
180002973:     	je	0x18000297a <numba_list_delitem+0x5a>
180002975:     	movq	%rsi, %rcx
180002978:     	callq	*%rax
18000297a:     	movq	(%rbx), %r8
18000297d:     	leaq	-0x1(%r8), %rax
180002981:     	cmpq	%rax, %rdi
180002984:     	je	0x1800029a6 <numba_list_delitem+0x86>
180002986:     	subq	%rdi, %r8
180002989:     	leaq	0x1(%rdi), %rdx
18000298d:     	imulq	0x8(%rbx), %rdx
180002992:     	decq	%r8
180002995:     	movq	%rsi, %rcx
180002998:     	imulq	0x8(%rbx), %r8
18000299d:     	addq	0x30(%rbx), %rdx
1800029a1:     	callq	0x180003a89 <numba_list_iter_next+0xe79>
1800029a6:     	movq	(%rbx), %rdx
1800029a9:     	movq	%rbx, %rcx
1800029ac:     	decq	%rdx
1800029af:     	callq	0x180002810 <numba_list_resize>
1800029b4:     	movq	0x30(%rsp), %rsi
1800029b9:     	xorl	%ecx, %ecx
1800029bb:     	movq	0x38(%rsp), %rbx
1800029c0:     	testl	%eax, %eax
1800029c2:     	cmovsl	%eax, %ecx
1800029c5:     	movl	%ecx, %eax
1800029c7:     	addq	$0x20, %rsp
1800029cb:     	popq	%rdi
1800029cc:     	retq
1800029cd:     	int3
1800029ce:     	int3
1800029cf:     	int3

00000001800029d0 <numba_list_delete_slice>:
1800029d0:     	pushq	%rbx
1800029d2:     	pushq	%rbp
1800029d3:     	pushq	%rdi
1800029d4:     	pushq	%r15
1800029d6:     	subq	$0x38, %rsp
1800029da:     	cmpl	$0x0, 0x18(%rcx)
1800029de:     	movq	%r9, %rdi
1800029e1:     	movq	%r8, %rbp
1800029e4:     	movq	%rdx, %r15
1800029e7:     	movq	%rcx, %rbx
1800029ea:     	jne	0x1800029fb <numba_list_delete_slice+0x2b>
1800029ec:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800029f1:     	addq	$0x38, %rsp
1800029f5:     	popq	%r15
1800029f7:     	popq	%rdi
1800029f8:     	popq	%rbp
1800029f9:     	popq	%rbx
1800029fa:     	retq
1800029fb:     	movq	%r13, 0x78(%rsp)
180002a00:     	testq	%rdi, %rdi
180002a03:     	jle	0x180002a22 <numba_list_delete_slice+0x52>
180002a05:     	cmpq	%r8, %r15
180002a08:     	jge	0x180002bc1 <numba_list_delete_slice+0x1f1>
180002a0e:     	movq	%r8, %rax
180002a11:     	subq	%r15, %rax
180002a14:     	decq	%rax
180002a17:     	cqto
180002a19:     	idivq	%rdi
180002a1c:     	leal	0x1(%rax), %r13d
180002a20:     	jmp	0x180002a42 <numba_list_delete_slice+0x72>
180002a22:     	cmpq	%r15, %r8
180002a25:     	jge	0x180002bc1 <numba_list_delete_slice+0x1f1>
180002a2b:     	movq	%r15, %rax
180002a2e:     	movl	$0x1, %r13d
180002a34:     	subq	%r8, %rax
180002a37:     	decq	%rax
180002a3a:     	cqto
180002a3c:     	idivq	%rdi
180002a3f:     	subl	%eax, %r13d
180002a42:     	testl	%r13d, %r13d
180002a45:     	jle	0x180002bc1 <numba_list_delete_slice+0x1f1>
180002a4b:     	movq	%rsi, 0x68(%rsp)
180002a50:     	movl	(%rcx), %esi
180002a52:     	subl	%r13d, %esi
180002a55:     	movl	%esi, 0x20(%rsp)
180002a59:     	testq	%rdi, %rdi
180002a5c:     	jns	0x180002a77 <numba_list_delete_slice+0xa7>
180002a5e:     	leaq	0x1(%r15), %rbp
180002a62:     	leal	-0x1(%r13), %eax
180002a66:     	movslq	%eax, %rcx
180002a69:     	leaq	-0x1(%rbp), %r15
180002a6d:     	imulq	%rdi, %rcx
180002a71:     	addq	%rcx, %r15
180002a74:     	negq	%rdi
180002a77:     	cmpq	$0x1, %rdi
180002a7b:     	jne	0x180002ac7 <numba_list_delete_slice+0xf7>
180002a7d:     	cmpq	$0x0, 0x28(%rbx)
180002a82:     	je	0x180002aa9 <numba_list_delete_slice+0xd9>
180002a84:     	movslq	%r15d, %rdi
180002a87:     	cmpq	%rbp, %rdi
180002a8a:     	jge	0x180002aa9 <numba_list_delete_slice+0xd9>
180002a8c:     	nopl	(%rax)
180002a90:     	movslq	%edi, %rcx
180002a93:     	imulq	0x8(%rbx), %rcx
180002a98:     	addq	0x30(%rbx), %rcx
180002a9c:     	callq	*0x28(%rbx)
180002a9f:     	incl	%edi
180002aa1:     	movslq	%edi, %rax
180002aa4:     	cmpq	%rbp, %rax
180002aa7:     	jl	0x180002a90 <numba_list_delete_slice+0xc0>
180002aa9:     	movq	0x8(%rbx), %rcx
180002aad:     	movq	(%rbx), %r8
180002ab0:     	movq	%rcx, %rdx
180002ab3:     	subq	%rbp, %r8
180002ab6:     	imulq	%rcx, %r8
180002aba:     	imulq	%rbp, %rdx
180002abe:     	imulq	%r15, %rcx
180002ac2:     	jmp	0x180002b8c <numba_list_delete_slice+0x1bc>
180002ac7:     	movq	%r14, 0x30(%rsp)
180002acc:     	movq	%r15, %r14
180002acf:     	movl	$0x0, 0x60(%rsp)
180002ad7:     	cmpq	%rbp, %r15
180002ada:     	jge	0x180002b59 <numba_list_delete_slice+0x189>
180002adc:     	movq	%r12, 0x70(%rsp)
180002ae1:     	movq	(%rbx), %rax
180002ae4:     	leaq	(%r14,%rdi), %r12
180002ae8:     	cmpq	%rax, %r12
180002aeb:     	jl	0x180002af8 <numba_list_delete_slice+0x128>
180002aed:     	movq	%r14, %rsi
180002af0:     	notq	%rsi
180002af3:     	addq	%rax, %rsi
180002af6:     	jmp	0x180002afc <numba_list_delete_slice+0x12c>
180002af8:     	leaq	-0x1(%rdi), %rsi
180002afc:     	movq	0x28(%rbx), %rax
180002b00:     	testq	%rax, %rax
180002b03:     	je	0x180002b13 <numba_list_delete_slice+0x143>
180002b05:     	movq	%r14, %rcx
180002b08:     	imulq	0x8(%rbx), %rcx
180002b0d:     	addq	0x30(%rbx), %rcx
180002b11:     	callq	*%rax
180002b13:     	movq	0x8(%rbx), %r9
180002b17:     	leaq	0x1(%r14), %rdx
180002b1b:     	movq	0x30(%rbx), %r10
180002b1f:     	movq	%r9, %r8
180002b22:     	imulq	%rsi, %r8
180002b26:     	imulq	%r9, %rdx
180002b2a:     	movslq	0x60(%rsp), %rsi
180002b2f:     	subq	%rsi, %r14
180002b32:     	imulq	%r9, %r14
180002b36:     	addq	%r10, %rdx
180002b39:     	leaq	(%r10,%r14), %rcx
180002b3d:     	callq	0x180003a89 <numba_list_iter_next+0xe79>
180002b42:     	incl	%esi
180002b44:     	movq	%r12, %r14
180002b47:     	movl	%esi, 0x60(%rsp)
180002b4b:     	cmpq	%rbp, %r12
180002b4e:     	jl	0x180002ae1 <numba_list_delete_slice+0x111>
180002b50:     	movq	0x70(%rsp), %r12
180002b55:     	movl	0x20(%rsp), %esi
180002b59:     	movq	(%rbx), %r8
180002b5c:     	movq	0x30(%rsp), %r14
180002b61:     	movslq	%r13d, %r10
180002b64:     	movq	%r10, %rcx
180002b67:     	imulq	%rdi, %rcx
180002b6b:     	addq	%r15, %rcx
180002b6e:     	cmpq	%r8, %rcx
180002b71:     	jge	0x180002b99 <numba_list_delete_slice+0x1c9>
180002b73:     	movq	0x8(%rbx), %rax
180002b77:     	subq	%rcx, %r8
180002b7a:     	movq	%rax, %rdx
180002b7d:     	imulq	%rcx, %rdx
180002b81:     	imulq	%rax, %r8
180002b85:     	subq	%r10, %rcx
180002b88:     	imulq	%rax, %rcx
180002b8c:     	addq	0x30(%rbx), %rdx
180002b90:     	addq	0x30(%rbx), %rcx
180002b94:     	callq	0x180003a89 <numba_list_iter_next+0xe79>
180002b99:     	movslq	%esi, %rdx
180002b9c:     	movq	%rbx, %rcx
180002b9f:     	callq	0x180002810 <numba_list_resize>
180002ba4:     	movq	0x68(%rsp), %rsi
180002ba9:     	xorl	%ecx, %ecx
180002bab:     	movq	0x78(%rsp), %r13
180002bb0:     	testl	%eax, %eax
180002bb2:     	cmovsl	%eax, %ecx
180002bb5:     	movl	%ecx, %eax
180002bb7:     	addq	$0x38, %rsp
180002bbb:     	popq	%r15
180002bbd:     	popq	%rdi
180002bbe:     	popq	%rbp
180002bbf:     	popq	%rbx
180002bc0:     	retq
180002bc1:     	movq	0x78(%rsp), %r13
180002bc6:     	xorl	%eax, %eax
180002bc8:     	addq	$0x38, %rsp
180002bcc:     	popq	%r15
180002bce:     	popq	%rdi
180002bcf:     	popq	%rbp
180002bd0:     	popq	%rbx
180002bd1:     	retq
180002bd2:     	int3
180002bd3:     	int3
180002bd4:     	int3
180002bd5:     	int3
180002bd6:     	int3
180002bd7:     	int3
180002bd8:     	int3
180002bd9:     	int3
180002bda:     	int3
180002bdb:     	int3
180002bdc:     	int3
180002bdd:     	int3
180002bde:     	int3
180002bdf:     	int3

0000000180002be0 <numba_list_iter_sizeof>:
180002be0:     	movl	$0x18, %eax
180002be5:     	retq
180002be6:     	int3
180002be7:     	int3
180002be8:     	int3
180002be9:     	int3
180002bea:     	int3
180002beb:     	int3
180002bec:     	int3
180002bed:     	int3
180002bee:     	int3
180002bef:     	int3

0000000180002bf0 <numba_list_iter>:
180002bf0:     	movq	%rdx, (%rcx)
180002bf3:     	movq	(%rdx), %rax
180002bf6:     	movq	%rax, 0x8(%rcx)
180002bfa:     	movq	$0x0, 0x10(%rcx)
180002c02:     	retq
180002c03:     	int3
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

0000000180002c10 <numba_list_iter_next>:
180002c10:     	movq	(%rcx), %r8
180002c13:     	movq	(%r8), %r9
180002c16:     	cmpq	0x8(%rcx), %r9
180002c1a:     	je	0x180002c22 <numba_list_iter_next+0x12>
180002c1c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002c21:     	retq
180002c22:     	movq	0x10(%rcx), %rax
180002c26:     	cmpq	%r9, %rax
180002c29:     	jge	0x180002c3e <numba_list_iter_next+0x2e>
180002c2b:     	imulq	0x8(%r8), %rax
180002c30:     	addq	0x30(%r8), %rax
180002c34:     	movq	%rax, (%rdx)
180002c37:     	incq	0x10(%rcx)
180002c3b:     	xorl	%eax, %eax
180002c3d:     	retq
180002c3e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002c43:     	retq
180002c44:     	int3
180002c45:     	int3
180002c46:     	int3
180002c47:     	int3
180002c48:     	int3
180002c49:     	int3
180002c4a:     	int3
180002c4b:     	int3
180002c4c:     	int3
180002c4d:     	int3
180002c4e:     	int3
180002c4f:     	int3
180002c50:     	pushq	%rbx
180002c52:     	subq	$0x20, %rsp
180002c56:     	movq	%rcx, %rbx
180002c59:     	addq	$0x30, %rcx
180002c5d:     	callq	*0x7fc5(%rip)           # 0x18000ac28
180002c63:     	cmpb	$0x0, 0x7f96(%rip)      # 0x18000ac00
180002c6a:     	je	0x180002c74 <numba_list_iter_next+0x64>
180002c6c:     	lock
180002c6d:     	incq	0x7f94(%rip)            # 0x18000ac08
180002c74:     	testq	%rax, %rax
180002c77:     	je	0x180002cb8 <numba_list_iter_next+0xa8>
180002c79:     	leaq	0x30(%rax), %rdx
180002c7d:     	testq	%rdx, %rdx
180002c80:     	je	0x180002cb8 <numba_list_iter_next+0xa8>
180002c82:     	xorl	%r8d, %r8d
180002c85:     	movl	$0x1, %ecx
180002c8a:     	xchgq	%rcx, (%rax)
180002c8d:     	movq	%r8, 0x8(%rax)
180002c91:     	movq	%r8, 0x10(%rax)
180002c95:     	movq	%rdx, 0x18(%rax)
180002c99:     	movq	%rbx, 0x20(%rax)
180002c9d:     	movq	%r8, 0x28(%rax)
180002ca1:     	cmpb	%r8b, 0x7f58(%rip)      # 0x18000ac00
180002ca8:     	je	0x180002cba <numba_list_iter_next+0xaa>
180002caa:     	lock
180002cab:     	incq	0x7f66(%rip)            # 0x18000ac18
180002cb2:     	addq	$0x20, %rsp
180002cb6:     	popq	%rbx
180002cb7:     	retq
180002cb8:     	xorl	%eax, %eax
180002cba:     	addq	$0x20, %rsp
180002cbe:     	popq	%rbx
180002cbf:     	retq
180002cc0:     	movq	%rbx, 0x8(%rsp)
180002cc5:     	pushq	%rdi
180002cc6:     	subq	$0x20, %rsp
180002cca:     	movq	%rcx, %rdi
180002ccd:     	movq	%rdx, %rbx
180002cd0:     	addq	$0x30, %rcx
180002cd4:     	testq	%rdx, %rdx
180002cd7:     	je	0x180002ce1 <numba_list_iter_next+0xd1>
180002cd9:     	movq	0x18(%rdx), %rdx
180002cdd:     	callq	*(%rbx)
180002cdf:     	jmp	0x180002ce7 <numba_list_iter_next+0xd7>
180002ce1:     	callq	*0x7f41(%rip)           # 0x18000ac28
180002ce7:     	cmpb	$0x0, 0x7f12(%rip)      # 0x18000ac00
180002cee:     	movq	%rax, %r8
180002cf1:     	je	0x180002cfb <numba_list_iter_next+0xeb>
180002cf3:     	lock
180002cf4:     	incq	0x7f0d(%rip)            # 0x18000ac08
180002cfb:     	xorl	%edx, %edx
180002cfd:     	leaq	0x30(%r8), %rax
180002d01:     	testq	%r8, %r8
180002d04:     	movl	%edx, %ecx
180002d06:     	cmovneq	%rax, %rcx
180002d0a:     	testq	%rcx, %rcx
180002d0d:     	jne	0x180002d1c <numba_list_iter_next+0x10c>
180002d0f:     	xorl	%eax, %eax
180002d11:     	movq	0x30(%rsp), %rbx
180002d16:     	addq	$0x20, %rsp
180002d1a:     	popq	%rdi
180002d1b:     	retq
180002d1c:     	movl	$0x1, %eax
180002d21:     	xchgq	%rax, (%r8)
180002d24:     	movq	%rdx, 0x8(%r8)
180002d28:     	movq	%rdx, 0x10(%r8)
180002d2c:     	movq	%rcx, 0x18(%r8)
180002d30:     	movq	%rdi, 0x20(%r8)
180002d34:     	movq	%rbx, 0x28(%r8)
180002d38:     	cmpb	%dl, 0x7ec2(%rip)       # 0x18000ac00
180002d3e:     	je	0x180002d48 <numba_list_iter_next+0x138>
180002d40:     	lock
180002d41:     	incq	0x7ed0(%rip)            # 0x18000ac18
180002d48:     	movq	0x30(%rsp), %rbx
180002d4d:     	movq	%r8, %rax
180002d50:     	addq	$0x20, %rsp
180002d54:     	popq	%rdi
180002d55:     	retq
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
180002d60:     	lock
180002d61:     	incq	(%rcx)
180002d64:     	retq
180002d65:     	int3
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
180002d70:     	pushq	%rbx
180002d72:     	subq	$0x20, %rsp
180002d76:     	movq	0x8(%rcx), %rax
180002d7a:     	movq	%rcx, %rbx
180002d7d:     	testq	%rax, %rax
180002d80:     	je	0x180002d99 <numba_list_iter_next+0x189>
180002d82:     	cmpl	$0x0, 0x7e6f(%rip)      # 0x18000abf8
180002d89:     	jne	0x180002d99 <numba_list_iter_next+0x189>
180002d8b:     	movq	0x10(%rcx), %r8
180002d8f:     	movq	0x20(%rcx), %rdx
180002d93:     	movq	0x18(%rcx), %rcx
180002d97:     	callq	*%rax
180002d99:     	movq	0x28(%rbx), %rax
180002d9d:     	movq	%rbx, %rcx
180002da0:     	testq	%rax, %rax
180002da3:     	je	0x180002dae <numba_list_iter_next+0x19e>
180002da5:     	movq	0x18(%rax), %rdx
180002da9:     	callq	*0x10(%rax)
180002dac:     	jmp	0x180002db4 <numba_list_iter_next+0x1a4>
180002dae:     	callq	*0x7e84(%rip)           # 0x18000ac38
180002db4:     	cmpb	$0x0, 0x7e45(%rip)      # 0x18000ac00
180002dbb:     	je	0x180002dd9 <numba_list_iter_next+0x1c9>
180002dbd:     	leaq	0x7e4c(%rip), %rax      # 0x18000ac10
180002dc4:     	lock
180002dc5:     	incq	(%rax)
180002dc8:     	cmpb	$0x0, 0x7e31(%rip)      # 0x18000ac00
180002dcf:     	je	0x180002dd9 <numba_list_iter_next+0x1c9>
180002dd1:     	lock
180002dd2:     	incq	0x7e47(%rip)            # 0x18000ac20
180002dd9:     	addq	$0x20, %rsp
180002ddd:     	popq	%rbx
180002dde:     	retq
180002ddf:     	int3
180002de0:     	pushq	%rbx
180002de2:     	subq	$0x20, %rsp
180002de6:     	movq	%rcx, %rbx
180002de9:     	movq	$-0x1, %rax
180002df0:     	lock
180002df1:     	xaddq	%rax, (%rcx)
180002df5:     	cmpq	$0x1, %rax
180002df9:     	jne	0x180002e5b <numba_list_iter_next+0x24b>
180002dfb:     	movq	0x8(%rcx), %rax
180002dff:     	testq	%rax, %rax
180002e02:     	je	0x180002e1b <numba_list_iter_next+0x20b>
180002e04:     	cmpl	$0x0, 0x7ded(%rip)      # 0x18000abf8
180002e0b:     	jne	0x180002e1b <numba_list_iter_next+0x20b>
180002e0d:     	movq	0x10(%rcx), %r8
180002e11:     	movq	0x20(%rcx), %rdx
180002e15:     	movq	0x18(%rcx), %rcx
180002e19:     	callq	*%rax
180002e1b:     	movq	0x28(%rbx), %rax
180002e1f:     	movq	%rbx, %rcx
180002e22:     	testq	%rax, %rax
180002e25:     	je	0x180002e30 <numba_list_iter_next+0x220>
180002e27:     	movq	0x18(%rax), %rdx
180002e2b:     	callq	*0x10(%rax)
180002e2e:     	jmp	0x180002e36 <numba_list_iter_next+0x226>
180002e30:     	callq	*0x7e02(%rip)           # 0x18000ac38
180002e36:     	cmpb	$0x0, 0x7dc3(%rip)      # 0x18000ac00
180002e3d:     	je	0x180002e5b <numba_list_iter_next+0x24b>
180002e3f:     	leaq	0x7dca(%rip), %rax      # 0x18000ac10
180002e46:     	lock
180002e47:     	incq	(%rax)
180002e4a:     	cmpb	$0x0, 0x7daf(%rip)      # 0x18000ac00
180002e51:     	je	0x180002e5b <numba_list_iter_next+0x24b>
180002e53:     	lock
180002e54:     	incq	0x7dc5(%rip)            # 0x18000ac20
180002e5b:     	addq	$0x20, %rsp
180002e5f:     	popq	%rbx
180002e60:     	retq
180002e61:     	int3
180002e62:     	int3
180002e63:     	int3
180002e64:     	int3
180002e65:     	int3
180002e66:     	int3
180002e67:     	int3
180002e68:     	int3
180002e69:     	int3
180002e6a:     	int3
180002e6b:     	int3
180002e6c:     	int3
180002e6d:     	int3
180002e6e:     	int3
180002e6f:     	int3
180002e70:     	movq	0x18(%rcx), %rax
180002e74:     	retq
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
180002e80:     	jmpq	*%r8
180002e83:     	int3
180002e84:     	int3
180002e85:     	int3
180002e86:     	int3
180002e87:     	int3
180002e88:     	int3
180002e89:     	int3
180002e8a:     	int3
180002e8b:     	int3
180002e8c:     	int3
180002e8d:     	int3
180002e8e:     	int3
180002e8f:     	int3
180002e90:     	movq	%rbx, 0x8(%rsp)
180002e95:     	pushq	%rdi
180002e96:     	subq	$0x20, %rsp
180002e9a:     	movq	%rcx, %rdi
180002e9d:     	movq	%rdx, %rbx
180002ea0:     	movl	$0x30, %ecx
180002ea5:     	callq	*0x7d7d(%rip)           # 0x18000ac28
180002eab:     	cmpb	$0x0, 0x7d4e(%rip)      # 0x18000ac00
180002eb2:     	je	0x180002ebc <numba_list_iter_next+0x2ac>
180002eb4:     	lock
180002eb5:     	incq	0x7d4c(%rip)            # 0x18000ac08
180002ebc:     	testq	%rax, %rax
180002ebf:     	je	0x180002ef6 <numba_list_iter_next+0x2e6>
180002ec1:     	leaq	-0x48(%rip), %rcx       # 0x180002e80 <numba_list_iter_next+0x270>
180002ec8:     	movl	$0x1, %edx
180002ecd:     	xchgq	%rdx, (%rax)
180002ed0:     	movq	%rcx, 0x8(%rax)
180002ed4:     	xorl	%ecx, %ecx
180002ed6:     	movq	%rcx, 0x20(%rax)
180002eda:     	movq	%rcx, 0x28(%rax)
180002ede:     	movq	%rbx, 0x10(%rax)
180002ee2:     	movq	%rdi, 0x18(%rax)
180002ee6:     	cmpb	%cl, 0x7d14(%rip)       # 0x18000ac00
180002eec:     	je	0x180002ef6 <numba_list_iter_next+0x2e6>
180002eee:     	lock
180002eef:     	incq	0x7d22(%rip)            # 0x18000ac18
180002ef6:     	movq	0x30(%rsp), %rbx
180002efb:     	addq	$0x20, %rsp
180002eff:     	popq	%rdi
180002f00:     	retq
180002f01:     	jmpq	*0x1369(%rip)           # 0x180004270
180002f07:     	jmpq	*0x1353(%rip)           # 0x180004260
180002f0d:     	jmpq	*0x1345(%rip)           # 0x180004258
180002f13:     	jmpq	*0x1337(%rip)           # 0x180004250
180002f19:     	jmpq	*0x1329(%rip)           # 0x180004248
180002f1f:     	jmpq	*0x131b(%rip)           # 0x180004240
180002f25:     	jmpq	*0x1305(%rip)           # 0x180004230
180002f2b:     	jmpq	*0x12ef(%rip)           # 0x180004220
180002f31:     	jmpq	*0x12c9(%rip)           # 0x180004200
180002f37:     	int3
180002f38:     	int3
180002f39:     	int3
180002f3a:     	int3
180002f3b:     	int3
180002f3c:     	int3
180002f3d:     	int3
180002f3e:     	int3
180002f3f:     	int3
180002f40:     	int3
180002f41:     	int3
180002f42:     	int3
180002f43:     	int3
180002f44:     	int3
180002f45:     	int3
180002f46:     	nopw	(%rax,%rax)
180002f50:     	cmpq	0x7169(%rip), %rcx      # 0x18000a0c0
180002f57:     	jne	0x180002f69 <numba_list_iter_next+0x359>
180002f59:     	rolq	$0x10, %rcx
180002f5d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180002f62:     	jne	0x180002f65 <numba_list_iter_next+0x355>
180002f64:     	retq
180002f65:     	rorq	$0x10, %rcx
180002f69:     	jmp	0x1800032c4 <numba_list_iter_next+0x6b4>
180002f6e:     	int3
180002f6f:     	int3
180002f70:     	subq	$0x28, %rsp
180002f74:     	testl	%edx, %edx
180002f76:     	je	0x180002fb1 <numba_list_iter_next+0x3a1>
180002f78:     	subl	$0x1, %edx
180002f7b:     	je	0x180002fa5 <numba_list_iter_next+0x395>
180002f7d:     	subl	$0x1, %edx
180002f80:     	je	0x180002f98 <numba_list_iter_next+0x388>
180002f82:     	cmpl	$0x1, %edx
180002f85:     	je	0x180002f91 <numba_list_iter_next+0x381>
180002f87:     	movl	$0x1, %eax
180002f8c:     	addq	$0x28, %rsp
180002f90:     	retq
180002f91:     	callq	0x180003490 <numba_list_iter_next+0x880>
180002f96:     	jmp	0x180002f9d <numba_list_iter_next+0x38d>
180002f98:     	callq	0x180003468 <numba_list_iter_next+0x858>
180002f9d:     	movzbl	%al, %eax
180002fa0:     	addq	$0x28, %rsp
180002fa4:     	retq
180002fa5:     	movq	%r8, %rdx
180002fa8:     	addq	$0x28, %rsp
180002fac:     	jmp	0x180002fc0 <numba_list_iter_next+0x3b0>
180002fb1:     	testq	%r8, %r8
180002fb4:     	setne	%cl
180002fb7:     	addq	$0x28, %rsp
180002fbb:     	jmp	0x1800030d8 <numba_list_iter_next+0x4c8>
180002fc0:     	movq	%rbx, 0x8(%rsp)
180002fc5:     	movq	%rsi, 0x10(%rsp)
180002fca:     	movq	%rdi, 0x20(%rsp)
180002fcf:     	pushq	%r14
180002fd1:     	subq	$0x20, %rsp
180002fd5:     	movq	%rdx, %rsi
180002fd8:     	movq	%rcx, %r14
180002fdb:     	xorl	%ecx, %ecx
180002fdd:     	callq	0x18000354c <numba_list_iter_next+0x93c>
180002fe2:     	testb	%al, %al
180002fe4:     	je	0x1800030b2 <numba_list_iter_next+0x4a2>
180002fea:     	callq	0x1800033e0 <numba_list_iter_next+0x7d0>
180002fef:     	movb	%al, %bl
180002ff1:     	movb	%al, 0x40(%rsp)
180002ff5:     	movb	$0x1, %dil
180002ff8:     	cmpl	$0x0, 0x79c9(%rip)      # 0x18000a9c8
180002fff:     	jne	0x1800030ca <numba_list_iter_next+0x4ba>
180003005:     	movl	$0x1, 0x79b9(%rip)      # 0x18000a9c8
18000300f:     	callq	0x180003450 <numba_list_iter_next+0x840>
180003014:     	testb	%al, %al
180003016:     	je	0x180003067 <numba_list_iter_next+0x457>
180003018:     	callq	0x18000370c <numba_list_iter_next+0xafc>
18000301d:     	callq	0x1800033a0 <numba_list_iter_next+0x790>
180003022:     	callq	0x1800033c4 <numba_list_iter_next+0x7b4>
180003027:     	leaq	0x12a2(%rip), %rdx      # 0x1800042d0
18000302e:     	leaq	0x1293(%rip), %rcx      # 0x1800042c8
180003035:     	callq	0x180003a52 <numba_list_iter_next+0xe42>
18000303a:     	testl	%eax, %eax
18000303c:     	jne	0x180003067 <numba_list_iter_next+0x457>
18000303e:     	callq	0x18000341c <numba_list_iter_next+0x80c>
180003043:     	testb	%al, %al
180003045:     	je	0x180003067 <numba_list_iter_next+0x457>
180003047:     	leaq	0x1272(%rip), %rdx      # 0x1800042c0
18000304e:     	leaq	0x1263(%rip), %rcx      # 0x1800042b8
180003055:     	callq	0x180003a4c <numba_list_iter_next+0xe3c>
18000305a:     	movl	$0x2, 0x7964(%rip)      # 0x18000a9c8
180003064:     	xorb	%dil, %dil
180003067:     	movb	%bl, %cl
180003069:     	callq	0x1800036ac <numba_list_iter_next+0xa9c>
18000306e:     	testb	%dil, %dil
180003071:     	jne	0x1800030b2 <numba_list_iter_next+0x4a2>
180003073:     	callq	0x1800036fc <numba_list_iter_next+0xaec>
180003078:     	movq	%rax, %rbx
18000307b:     	cmpq	$0x0, (%rax)
18000307f:     	je	0x1800030a5 <numba_list_iter_next+0x495>
180003081:     	movq	%rax, %rcx
180003084:     	callq	0x180003614 <numba_list_iter_next+0xa04>
180003089:     	testb	%al, %al
18000308b:     	je	0x1800030a5 <numba_list_iter_next+0x495>
18000308d:     	movq	%rsi, %r8
180003090:     	movl	$0x2, %edx
180003095:     	movq	%r14, %rcx
180003098:     	movq	(%rbx), %rax
18000309b:     	movq	0x11ee(%rip), %r9       # 0x180004290
1800030a2:     	callq	*%r9
1800030a5:     	incl	0x78f5(%rip)            # 0x18000a9a0
1800030ab:     	movl	$0x1, %eax
1800030b0:     	jmp	0x1800030b4 <numba_list_iter_next+0x4a4>
1800030b2:     	xorl	%eax, %eax
1800030b4:     	movq	0x30(%rsp), %rbx
1800030b9:     	movq	0x38(%rsp), %rsi
1800030be:     	movq	0x48(%rsp), %rdi
1800030c3:     	addq	$0x20, %rsp
1800030c7:     	popq	%r14
1800030c9:     	retq
1800030ca:     	movl	$0x7, %ecx
1800030cf:     	callq	0x180003704 <numba_list_iter_next+0xaf4>
1800030d4:     	nop
1800030d5:     	int3
1800030d6:     	int3
1800030d7:     	int3
1800030d8:     	movq	%rbx, 0x8(%rsp)
1800030dd:     	pushq	%rdi
1800030de:     	subq	$0x30, %rsp
1800030e2:     	movb	%cl, %dil
1800030e5:     	movl	0x78b5(%rip), %eax      # 0x18000a9a0
1800030eb:     	testl	%eax, %eax
1800030ed:     	jg	0x1800030fc <numba_list_iter_next+0x4ec>
1800030ef:     	xorl	%eax, %eax
1800030f1:     	movq	0x40(%rsp), %rbx
1800030f6:     	addq	$0x30, %rsp
1800030fa:     	popq	%rdi
1800030fb:     	retq
1800030fc:     	decl	%eax
1800030fe:     	movl	%eax, 0x789c(%rip)      # 0x18000a9a0
180003104:     	callq	0x1800033e0 <numba_list_iter_next+0x7d0>
180003109:     	movb	%al, %bl
18000310b:     	movb	%al, 0x20(%rsp)
18000310f:     	cmpl	$0x2, 0x78b2(%rip)      # 0x18000a9c8
180003116:     	jne	0x18000314e <numba_list_iter_next+0x53e>
180003118:     	callq	0x180003508 <numba_list_iter_next+0x8f8>
18000311d:     	callq	0x1800033b0 <numba_list_iter_next+0x7a0>
180003122:     	callq	0x180003748 <numba_list_iter_next+0xb38>
180003127:     	movl	$0x0, 0x7897(%rip)      # 0x18000a9c8
180003131:     	movb	%bl, %cl
180003133:     	callq	0x1800036ac <numba_list_iter_next+0xa9c>
180003138:     	xorl	%edx, %edx
18000313a:     	movb	%dil, %cl
18000313d:     	callq	0x1800036d0 <numba_list_iter_next+0xac0>
180003142:     	movzbl	%al, %ebx
180003145:     	callq	0x180003538 <numba_list_iter_next+0x928>
18000314a:     	movl	%ebx, %eax
18000314c:     	jmp	0x1800030f1 <numba_list_iter_next+0x4e1>
18000314e:     	movl	$0x7, %ecx
180003153:     	callq	0x180003704 <numba_list_iter_next+0xaf4>
180003158:     	nop
180003159:     	nop
18000315a:     	int3
18000315b:     	int3
18000315c:     	movq	%rsp, %rax
18000315f:     	movq	%rbx, 0x20(%rax)
180003163:     	movq	%r8, 0x18(%rax)
180003167:     	movl	%edx, 0x10(%rax)
18000316a:     	movq	%rcx, 0x8(%rax)
18000316e:     	pushq	%rsi
18000316f:     	pushq	%rdi
180003170:     	pushq	%r14
180003172:     	subq	$0x40, %rsp
180003176:     	movq	%r8, %rsi
180003179:     	movl	%edx, %edi
18000317b:     	movq	%rcx, %r14
18000317e:     	testl	%edx, %edx
180003180:     	jne	0x180003191 <numba_list_iter_next+0x581>
180003182:     	cmpl	%edx, 0x7818(%rip)      # 0x18000a9a0
180003188:     	jg	0x180003191 <numba_list_iter_next+0x581>
18000318a:     	xorl	%eax, %eax
18000318c:     	jmp	0x180003276 <numba_list_iter_next+0x666>
180003191:     	leal	-0x1(%rdx), %eax
180003194:     	cmpl	$0x1, %eax
180003197:     	ja	0x1800031d9 <numba_list_iter_next+0x5c9>
180003199:     	movq	0x1418(%rip), %rax      # 0x1800045b8
1800031a0:     	testq	%rax, %rax
1800031a3:     	jne	0x1800031aa <numba_list_iter_next+0x59a>
1800031a5:     	leal	0x1(%rax), %ebx
1800031a8:     	jmp	0x1800031b2 <numba_list_iter_next+0x5a2>
1800031aa:     	callq	*0x10e0(%rip)           # 0x180004290
1800031b0:     	movl	%eax, %ebx
1800031b2:     	movl	%ebx, 0x30(%rsp)
1800031b6:     	testl	%ebx, %ebx
1800031b8:     	je	0x18000326c <numba_list_iter_next+0x65c>
1800031be:     	movq	%rsi, %r8
1800031c1:     	movl	%edi, %edx
1800031c3:     	movq	%r14, %rcx
1800031c6:     	callq	0x180002f70 <numba_list_iter_next+0x360>
1800031cb:     	movl	%eax, %ebx
1800031cd:     	movl	%eax, 0x30(%rsp)
1800031d1:     	testl	%eax, %eax
1800031d3:     	je	0x18000326c <numba_list_iter_next+0x65c>
1800031d9:     	movq	%rsi, %r8
1800031dc:     	movl	%edi, %edx
1800031de:     	movq	%r14, %rcx
1800031e1:     	callq	0x18000337c <numba_list_iter_next+0x76c>
1800031e6:     	movl	%eax, %ebx
1800031e8:     	movl	%eax, 0x30(%rsp)
1800031ec:     	cmpl	$0x1, %edi
1800031ef:     	jne	0x180003227 <numba_list_iter_next+0x617>
1800031f1:     	testl	%eax, %eax
1800031f3:     	jne	0x180003227 <numba_list_iter_next+0x617>
1800031f5:     	movq	%rsi, %r8
1800031f8:     	xorl	%edx, %edx
1800031fa:     	movq	%r14, %rcx
1800031fd:     	callq	0x18000337c <numba_list_iter_next+0x76c>
180003202:     	testq	%rsi, %rsi
180003205:     	setne	%cl
180003208:     	callq	0x1800030d8 <numba_list_iter_next+0x4c8>
18000320d:     	movq	0x13a4(%rip), %rax      # 0x1800045b8
180003214:     	testq	%rax, %rax
180003217:     	je	0x180003227 <numba_list_iter_next+0x617>
180003219:     	movq	%rsi, %r8
18000321c:     	xorl	%edx, %edx
18000321e:     	movq	%r14, %rcx
180003221:     	callq	*0x1069(%rip)           # 0x180004290
180003227:     	testl	%edi, %edi
180003229:     	je	0x180003230 <numba_list_iter_next+0x620>
18000322b:     	cmpl	$0x3, %edi
18000322e:     	jne	0x18000326c <numba_list_iter_next+0x65c>
180003230:     	movq	%rsi, %r8
180003233:     	movl	%edi, %edx
180003235:     	movq	%r14, %rcx
180003238:     	callq	0x180002f70 <numba_list_iter_next+0x360>
18000323d:     	movl	%eax, %ebx
18000323f:     	movl	%eax, 0x30(%rsp)
180003243:     	testl	%eax, %eax
180003245:     	je	0x18000326c <numba_list_iter_next+0x65c>
180003247:     	movq	0x136a(%rip), %rax      # 0x1800045b8
18000324e:     	testq	%rax, %rax
180003251:     	jne	0x180003258 <numba_list_iter_next+0x648>
180003253:     	leal	0x1(%rax), %ebx
180003256:     	jmp	0x180003268 <numba_list_iter_next+0x658>
180003258:     	movq	%rsi, %r8
18000325b:     	movl	%edi, %edx
18000325d:     	movq	%r14, %rcx
180003260:     	callq	*0x102a(%rip)           # 0x180004290
180003266:     	movl	%eax, %ebx
180003268:     	movl	%ebx, 0x30(%rsp)
18000326c:     	jmp	0x180003274 <numba_list_iter_next+0x664>
18000326e:     	xorl	%ebx, %ebx
180003270:     	movl	%ebx, 0x30(%rsp)
180003274:     	movl	%ebx, %eax
180003276:     	movq	0x78(%rsp), %rbx
18000327b:     	addq	$0x40, %rsp
18000327f:     	popq	%r14
180003281:     	popq	%rdi
180003282:     	popq	%rsi
180003283:     	retq
180003284:     	movq	%rbx, 0x8(%rsp)
180003289:     	movq	%rsi, 0x10(%rsp)
18000328e:     	pushq	%rdi
18000328f:     	subq	$0x20, %rsp
180003293:     	movq	%r8, %rdi
180003296:     	movl	%edx, %ebx
180003298:     	movq	%rcx, %rsi
18000329b:     	cmpl	$0x1, %edx
18000329e:     	jne	0x1800032a5 <numba_list_iter_next+0x695>
1800032a0:     	callq	0x1800032cc <numba_list_iter_next+0x6bc>
1800032a5:     	movq	%rdi, %r8
1800032a8:     	movl	%ebx, %edx
1800032aa:     	movq	%rsi, %rcx
1800032ad:     	movq	0x30(%rsp), %rbx
1800032b2:     	movq	0x38(%rsp), %rsi
1800032b7:     	addq	$0x20, %rsp
1800032bb:     	popq	%rdi
1800032bc:     	jmp	0x18000315c <numba_list_iter_next+0x54c>
1800032c1:     	int3
1800032c2:     	int3
1800032c3:     	int3
1800032c4:     	movl	$0x2, %ecx
1800032c9:     	int	$0x29
1800032cb:     	retq
1800032cc:     	movq	%rbx, 0x18(%rsp)
1800032d1:     	pushq	%rbp
1800032d2:     	movq	%rsp, %rbp
1800032d5:     	subq	$0x30, %rsp
1800032d9:     	movq	0x6de0(%rip), %rax      # 0x18000a0c0
1800032e0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1800032ea:     	cmpq	%rbx, %rax
1800032ed:     	jne	0x180003366 <numba_list_iter_next+0x756>
1800032ef:     	leaq	0x10(%rbp), %rcx
1800032f3:     	movq	$0x0, 0x10(%rbp)
1800032fb:     	callq	*0xd1f(%rip)            # 0x180004020
180003301:     	movq	0x10(%rbp), %rax
180003305:     	movq	%rax, -0x10(%rbp)
180003309:     	callq	*0xd09(%rip)            # 0x180004018
18000330f:     	movl	%eax, %eax
180003311:     	xorq	%rax, -0x10(%rbp)
180003315:     	callq	*0xcf5(%rip)            # 0x180004010
18000331b:     	movl	%eax, %eax
18000331d:     	leaq	0x18(%rbp), %rcx
180003321:     	xorq	%rax, -0x10(%rbp)
180003325:     	callq	*0xcd5(%rip)            # 0x180004000
18000332b:     	movl	0x18(%rbp), %eax
18000332e:     	leaq	-0x10(%rbp), %rcx
180003332:     	shlq	$0x20, %rax
180003336:     	xorq	0x18(%rbp), %rax
18000333a:     	xorq	-0x10(%rbp), %rax
18000333e:     	xorq	%rcx, %rax
180003341:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000334b:     	andq	%rcx, %rax
18000334e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180003358:     	cmpq	%rbx, %rax
18000335b:     	cmoveq	%rcx, %rax
18000335f:     	movq	%rax, 0x6d5a(%rip)      # 0x18000a0c0
180003366:     	movq	0x50(%rsp), %rbx
18000336b:     	notq	%rax
18000336e:     	movq	%rax, 0x6d8b(%rip)      # 0x18000a100
180003375:     	addq	$0x30, %rsp
180003379:     	popq	%rbp
18000337a:     	retq
18000337b:     	int3
18000337c:     	subq	$0x28, %rsp
180003380:     	cmpl	$0x1, %edx
180003383:     	jne	0x180003395 <numba_list_iter_next+0x785>
180003385:     	cmpq	$0x0, 0x122b(%rip)      # 0x1800045b8
18000338d:     	jne	0x180003395 <numba_list_iter_next+0x785>
18000338f:     	callq	*0xc93(%rip)            # 0x180004028
180003395:     	movl	$0x1, %eax
18000339a:     	addq	$0x28, %rsp
18000339e:     	retq
18000339f:     	int3
1800033a0:     	leaq	0x7609(%rip), %rcx      # 0x18000a9b0
1800033a7:     	jmpq	*0xc5a(%rip)            # 0x180004008
1800033ae:     	int3
1800033af:     	int3
1800033b0:     	leaq	0x75f9(%rip), %rcx      # 0x18000a9b0
1800033b7:     	jmp	0x180003a46 <numba_list_iter_next+0xe36>
1800033bc:     	leaq	0x75fd(%rip), %rax      # 0x18000a9c0
1800033c3:     	retq
1800033c4:     	subq	$0x28, %rsp
1800033c8:     	callq	0x180002520 <PyInit_rcaotr_b19cba7e9f83b6770fdb3d59+0x10e0>
1800033cd:     	orq	$0x24, (%rax)
1800033d1:     	callq	0x1800033bc <numba_list_iter_next+0x7ac>
1800033d6:     	orq	$0x2, (%rax)
1800033da:     	addq	$0x28, %rsp
1800033de:     	retq
1800033df:     	int3
1800033e0:     	subq	$0x28, %rsp
1800033e4:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
1800033e9:     	testl	%eax, %eax
1800033eb:     	je	0x18000340e <numba_list_iter_next+0x7fe>
1800033ed:     	movq	%gs:0x30, %rax
1800033f6:     	movq	0x8(%rax), %rcx
1800033fa:     	jmp	0x180003401 <numba_list_iter_next+0x7f1>
1800033fc:     	cmpq	%rax, %rcx
1800033ff:     	je	0x180003415 <numba_list_iter_next+0x805>
180003401:     	xorl	%eax, %eax
180003403:     	lock
180003404:     	cmpxchgq	%rcx, 0x75c4(%rip)      # 0x18000a9d0
18000340c:     	jne	0x1800033fc <numba_list_iter_next+0x7ec>
18000340e:     	xorb	%al, %al
180003410:     	addq	$0x28, %rsp
180003414:     	retq
180003415:     	movb	$0x1, %al
180003417:     	jmp	0x180003410 <numba_list_iter_next+0x800>
180003419:     	int3
18000341a:     	int3
18000341b:     	int3
18000341c:     	subq	$0x28, %rsp
180003420:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
180003425:     	testl	%eax, %eax
180003427:     	je	0x180003430 <numba_list_iter_next+0x820>
180003429:     	callq	0x180003788 <numba_list_iter_next+0xb78>
18000342e:     	jmp	0x180003449 <numba_list_iter_next+0x839>
180003430:     	callq	0x180003a24 <numba_list_iter_next+0xe14>
180003435:     	movl	%eax, %ecx
180003437:     	callq	0x180003a5e <numba_list_iter_next+0xe4e>
18000343c:     	testl	%eax, %eax
18000343e:     	je	0x180003444 <numba_list_iter_next+0x834>
180003440:     	xorb	%al, %al
180003442:     	jmp	0x18000344b <numba_list_iter_next+0x83b>
180003444:     	callq	0x180003a64 <numba_list_iter_next+0xe54>
180003449:     	movb	$0x1, %al
18000344b:     	addq	$0x28, %rsp
18000344f:     	retq
180003450:     	subq	$0x28, %rsp
180003454:     	xorl	%ecx, %ecx
180003456:     	callq	0x180003588 <numba_list_iter_next+0x978>
18000345b:     	testb	%al, %al
18000345d:     	setne	%al
180003460:     	addq	$0x28, %rsp
180003464:     	retq
180003465:     	int3
180003466:     	int3
180003467:     	int3
180003468:     	subq	$0x28, %rsp
18000346c:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003471:     	testb	%al, %al
180003473:     	jne	0x180003479 <numba_list_iter_next+0x869>
180003475:     	xorb	%al, %al
180003477:     	jmp	0x18000348b <numba_list_iter_next+0x87b>
180003479:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
18000347e:     	testb	%al, %al
180003480:     	jne	0x180003489 <numba_list_iter_next+0x879>
180003482:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003487:     	jmp	0x180003475 <numba_list_iter_next+0x865>
180003489:     	movb	$0x1, %al
18000348b:     	addq	$0x28, %rsp
18000348f:     	retq
180003490:     	subq	$0x28, %rsp
180003494:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003499:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
18000349e:     	movb	$0x1, %al
1800034a0:     	addq	$0x28, %rsp
1800034a4:     	retq
1800034a5:     	int3
1800034a6:     	int3
1800034a7:     	int3
1800034a8:     	movq	%rbx, 0x8(%rsp)
1800034ad:     	movq	%rbp, 0x10(%rsp)
1800034b2:     	movq	%rsi, 0x18(%rsp)
1800034b7:     	pushq	%rdi
1800034b8:     	subq	$0x20, %rsp
1800034bc:     	movq	%r9, %rdi
1800034bf:     	movq	%r8, %rsi
1800034c2:     	movl	%edx, %ebx
1800034c4:     	movq	%rcx, %rbp
1800034c7:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
1800034cc:     	testl	%eax, %eax
1800034ce:     	jne	0x1800034e6 <numba_list_iter_next+0x8d6>
1800034d0:     	cmpl	$0x1, %ebx
1800034d3:     	jne	0x1800034e6 <numba_list_iter_next+0x8d6>
1800034d5:     	movq	%rsi, %r8
1800034d8:     	xorl	%edx, %edx
1800034da:     	movq	%rbp, %rcx
1800034dd:     	movq	%rdi, %rax
1800034e0:     	callq	*0xdaa(%rip)            # 0x180004290
1800034e6:     	movq	0x58(%rsp), %rdx
1800034eb:     	movl	0x50(%rsp), %ecx
1800034ef:     	movq	0x30(%rsp), %rbx
1800034f4:     	movq	0x38(%rsp), %rbp
1800034f9:     	movq	0x40(%rsp), %rsi
1800034fe:     	addq	$0x20, %rsp
180003502:     	popq	%rdi
180003503:     	jmp	0x180003a58 <numba_list_iter_next+0xe48>
180003508:     	subq	$0x28, %rsp
18000350c:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
180003511:     	testl	%eax, %eax
180003513:     	je	0x180003525 <numba_list_iter_next+0x915>
180003515:     	leaq	0x74c4(%rip), %rcx      # 0x18000a9e0
18000351c:     	addq	$0x28, %rsp
180003520:     	jmp	0x180003a70 <numba_list_iter_next+0xe60>
180003525:     	callq	0x180003a80 <numba_list_iter_next+0xe70>
18000352a:     	testl	%eax, %eax
18000352c:     	jne	0x180003533 <numba_list_iter_next+0x923>
18000352e:     	callq	0x180003a76 <numba_list_iter_next+0xe66>
180003533:     	addq	$0x28, %rsp
180003537:     	retq
180003538:     	subq	$0x28, %rsp
18000353c:     	xorl	%ecx, %ecx
18000353e:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003543:     	addq	$0x28, %rsp
180003547:     	jmp	0x180003a7c <numba_list_iter_next+0xe6c>
18000354c:     	subq	$0x28, %rsp
180003550:     	testl	%ecx, %ecx
180003552:     	jne	0x18000355b <numba_list_iter_next+0x94b>
180003554:     	movb	$0x1, 0x747d(%rip)      # 0x18000a9d8
18000355b:     	callq	0x180003788 <numba_list_iter_next+0xb78>
180003560:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003565:     	testb	%al, %al
180003567:     	jne	0x18000356d <numba_list_iter_next+0x95d>
180003569:     	xorb	%al, %al
18000356b:     	jmp	0x180003581 <numba_list_iter_next+0x971>
18000356d:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
180003572:     	testb	%al, %al
180003574:     	jne	0x18000357f <numba_list_iter_next+0x96f>
180003576:     	xorl	%ecx, %ecx
180003578:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
18000357d:     	jmp	0x180003569 <numba_list_iter_next+0x959>
18000357f:     	movb	$0x1, %al
180003581:     	addq	$0x28, %rsp
180003585:     	retq
180003586:     	int3
180003587:     	int3
180003588:     	pushq	%rbx
18000358a:     	subq	$0x20, %rsp
18000358e:     	cmpb	$0x0, 0x7444(%rip)      # 0x18000a9d9
180003595:     	movl	%ecx, %ebx
180003597:     	jne	0x180003600 <numba_list_iter_next+0x9f0>
180003599:     	cmpl	$0x1, %ecx
18000359c:     	ja	0x180003608 <numba_list_iter_next+0x9f8>
18000359e:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
1800035a3:     	testl	%eax, %eax
1800035a5:     	je	0x1800035cf <numba_list_iter_next+0x9bf>
1800035a7:     	testl	%ebx, %ebx
1800035a9:     	jne	0x1800035cf <numba_list_iter_next+0x9bf>
1800035ab:     	leaq	0x742e(%rip), %rcx      # 0x18000a9e0
1800035b2:     	callq	0x180003a6a <numba_list_iter_next+0xe5a>
1800035b7:     	testl	%eax, %eax
1800035b9:     	jne	0x1800035cb <numba_list_iter_next+0x9bb>
1800035bb:     	leaq	0x7436(%rip), %rcx      # 0x18000a9f8
1800035c2:     	callq	0x180003a6a <numba_list_iter_next+0xe5a>
1800035c7:     	testl	%eax, %eax
1800035c9:     	je	0x1800035f9 <numba_list_iter_next+0x9e9>
1800035cb:     	xorb	%al, %al
1800035cd:     	jmp	0x180003602 <numba_list_iter_next+0x9f2>
1800035cf:     	movdqa	0xfe9(%rip), %xmm0      # 0x1800045c0
1800035d7:     	orq	$-0x1, %rax
1800035db:     	movdqu	%xmm0, 0x73fd(%rip)     # 0x18000a9e0
1800035e3:     	movq	%rax, 0x7406(%rip)      # 0x18000a9f0
1800035ea:     	movdqu	%xmm0, 0x7406(%rip)     # 0x18000a9f8
1800035f2:     	movq	%rax, 0x740f(%rip)      # 0x18000aa08
1800035f9:     	movb	$0x1, 0x73d9(%rip)      # 0x18000a9d9
180003600:     	movb	$0x1, %al
180003602:     	addq	$0x20, %rsp
180003606:     	popq	%rbx
180003607:     	retq
180003608:     	movl	$0x5, %ecx
18000360d:     	callq	0x180003704 <numba_list_iter_next+0xaf4>
180003612:     	int3
180003613:     	int3
180003614:     	subq	$0x18, %rsp
180003618:     	movq	%rcx, %r8
18000361b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003620:     	cmpw	%ax, -0x3627(%rip)      # 0x180000000
180003627:     	jne	0x1800036a1 <numba_list_iter_next+0xa91>
180003629:     	movslq	-0x35f4(%rip), %rcx     # 0x18000003c
180003630:     	leaq	-0x3637(%rip), %rdx     # 0x180000000
180003637:     	addq	%rdx, %rcx
18000363a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180003640:     	jne	0x1800036a1 <numba_list_iter_next+0xa91>
180003642:     	movl	$0x20b, %eax            # imm = 0x20B
180003647:     	cmpw	%ax, 0x18(%rcx)
18000364b:     	jne	0x1800036a1 <numba_list_iter_next+0xa91>
18000364d:     	subq	%rdx, %r8
180003650:     	movzwl	0x14(%rcx), %edx
180003654:     	addq	$0x18, %rdx
180003658:     	addq	%rcx, %rdx
18000365b:     	movzwl	0x6(%rcx), %eax
18000365f:     	leaq	(%rax,%rax,4), %rcx
180003663:     	leaq	(%rdx,%rcx,8), %r9
180003667:     	movq	%rdx, (%rsp)
18000366b:     	cmpq	%r9, %rdx
18000366e:     	je	0x180003688 <numba_list_iter_next+0xa78>
180003670:     	movl	0xc(%rdx), %ecx
180003673:     	cmpq	%rcx, %r8
180003676:     	jb	0x180003682 <numba_list_iter_next+0xa72>
180003678:     	movl	0x8(%rdx), %eax
18000367b:     	addl	%ecx, %eax
18000367d:     	cmpq	%rax, %r8
180003680:     	jb	0x18000368a <numba_list_iter_next+0xa7a>
180003682:     	addq	$0x28, %rdx
180003686:     	jmp	0x180003667 <numba_list_iter_next+0xa57>
180003688:     	xorl	%edx, %edx
18000368a:     	testq	%rdx, %rdx
18000368d:     	jne	0x180003693 <numba_list_iter_next+0xa83>
18000368f:     	xorb	%al, %al
180003691:     	jmp	0x1800036a7 <numba_list_iter_next+0xa97>
180003693:     	cmpl	$0x0, 0x24(%rdx)
180003697:     	jge	0x18000369d <numba_list_iter_next+0xa8d>
180003699:     	xorb	%al, %al
18000369b:     	jmp	0x1800036a7 <numba_list_iter_next+0xa97>
18000369d:     	movb	$0x1, %al
18000369f:     	jmp	0x1800036a7 <numba_list_iter_next+0xa97>
1800036a1:     	xorb	%al, %al
1800036a3:     	jmp	0x1800036a7 <numba_list_iter_next+0xa97>
1800036a5:     	xorb	%al, %al
1800036a7:     	addq	$0x18, %rsp
1800036ab:     	retq
1800036ac:     	pushq	%rbx
1800036ae:     	subq	$0x20, %rsp
1800036b2:     	movb	%cl, %bl
1800036b4:     	callq	0x180003a2c <numba_list_iter_next+0xe1c>
1800036b9:     	xorl	%edx, %edx
1800036bb:     	testl	%eax, %eax
1800036bd:     	je	0x1800036ca <numba_list_iter_next+0xaba>
1800036bf:     	testb	%bl, %bl
1800036c1:     	jne	0x1800036ca <numba_list_iter_next+0xaba>
1800036c3:     	xchgq	%rdx, 0x7306(%rip)      # 0x18000a9d0
1800036ca:     	addq	$0x20, %rsp
1800036ce:     	popq	%rbx
1800036cf:     	retq
1800036d0:     	pushq	%rbx
1800036d2:     	subq	$0x20, %rsp
1800036d6:     	cmpb	$0x0, 0x72fb(%rip)      # 0x18000a9d8
1800036dd:     	movb	%cl, %bl
1800036df:     	je	0x1800036e5 <numba_list_iter_next+0xad5>
1800036e1:     	testb	%dl, %dl
1800036e3:     	jne	0x1800036f1 <numba_list_iter_next+0xae1>
1800036e5:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
1800036ea:     	movb	%bl, %cl
1800036ec:     	callq	0x180003a7c <numba_list_iter_next+0xe6c>
1800036f1:     	movb	$0x1, %al
1800036f3:     	addq	$0x20, %rsp
1800036f7:     	popq	%rbx
1800036f8:     	retq
1800036f9:     	int3
1800036fa:     	int3
1800036fb:     	int3
1800036fc:     	leaq	0x7565(%rip), %rax      # 0x18000ac68
180003703:     	retq
180003704:     	movl	%ecx, %ecx
180003706:     	int	$0x29
180003708:     	retq
180003709:     	int3
18000370a:     	int3
18000370b:     	int3
18000370c:     	movq	%rbx, 0x8(%rsp)
180003711:     	pushq	%rdi
180003712:     	subq	$0x20, %rsp
180003716:     	leaq	0x3823(%rip), %rbx      # 0x180006f40
18000371d:     	leaq	0x381c(%rip), %rdi      # 0x180006f40
180003724:     	jmp	0x180003738 <numba_list_iter_next+0xb28>
180003726:     	movq	(%rbx), %rax
180003729:     	testq	%rax, %rax
18000372c:     	je	0x180003734 <numba_list_iter_next+0xb24>
18000372e:     	callq	*0xb5c(%rip)            # 0x180004290
180003734:     	addq	$0x8, %rbx
180003738:     	cmpq	%rdi, %rbx
18000373b:     	jb	0x180003726 <numba_list_iter_next+0xb16>
18000373d:     	movq	0x30(%rsp), %rbx
180003742:     	addq	$0x20, %rsp
180003746:     	popq	%rdi
180003747:     	retq
180003748:     	movq	%rbx, 0x8(%rsp)
18000374d:     	pushq	%rdi
18000374e:     	subq	$0x20, %rsp
180003752:     	leaq	0x37f7(%rip), %rbx      # 0x180006f50
180003759:     	leaq	0x37f0(%rip), %rdi      # 0x180006f50
180003760:     	jmp	0x180003774 <numba_list_iter_next+0xb64>
180003762:     	movq	(%rbx), %rax
180003765:     	testq	%rax, %rax
180003768:     	je	0x180003770 <numba_list_iter_next+0xb60>
18000376a:     	callq	*0xb20(%rip)            # 0x180004290
180003770:     	addq	$0x8, %rbx
180003774:     	cmpq	%rdi, %rbx
180003777:     	jb	0x180003762 <numba_list_iter_next+0xb52>
180003779:     	movq	0x30(%rsp), %rbx
18000377e:     	addq	$0x20, %rsp
180003782:     	popq	%rdi
180003783:     	retq
180003784:     	retq	$0x0
180003787:     	int3
180003788:     	movq	%rbx, 0x10(%rsp)
18000378d:     	movq	%rbp, 0x18(%rsp)
180003792:     	movq	%rsi, 0x20(%rsp)
180003797:     	pushq	%rdi
180003798:     	subq	$0x10, %rsp
18000379c:     	xorl	%eax, %eax
18000379e:     	xorl	%ecx, %ecx
1800037a0:     	cpuid
1800037a2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
1800037a8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
1800037ae:     	orl	%ecx, %edx
1800037b0:     	movl	%eax, %ebp
1800037b2:     	movl	$0x1, %eax
1800037b7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
1800037bd:     	orl	%ebx, %edx
1800037bf:     	leal	-0x1(%rax), %ecx
1800037c2:     	cpuid
1800037c4:     	movl	%ecx, %edi
1800037c6:     	jne	0x180003826 <numba_list_iter_next+0xc16>
1800037c8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
1800037cd:     	movq	$0x8000, 0x6940(%rip)   # imm = 0x8000
                                                # 0x18000a118
1800037d8:     	movq	$-0x1, 0x693d(%rip)     # 0x18000a120
1800037e3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
1800037e8:     	je	0x180003812 <numba_list_iter_next+0xc02>
1800037ea:     	cmpl	$0x20660, %eax          # imm = 0x20660
1800037ef:     	je	0x180003812 <numba_list_iter_next+0xc02>
1800037f1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800037f6:     	je	0x180003812 <numba_list_iter_next+0xc02>
1800037f8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800037fd:     	cmpl	$0x20, %eax
180003800:     	ja	0x180003826 <numba_list_iter_next+0xc16>
180003802:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000380c:     	btq	%rax, %rcx
180003810:     	jae	0x180003826 <numba_list_iter_next+0xc16>
180003812:     	movl	0x71fb(%rip), %r8d      # 0x18000aa14
180003819:     	orl	$0x1, %r8d
18000381d:     	movl	%r8d, 0x71f0(%rip)      # 0x18000aa14
180003824:     	jmp	0x18000382d <numba_list_iter_next+0xc1d>
180003826:     	movl	0x71e7(%rip), %r8d      # 0x18000aa14
18000382d:     	xorl	%r9d, %r9d
180003830:     	movl	%r9d, %r11d
180003833:     	cmpl	$0x7, %ebp
180003836:     	jl	0x18000387a <numba_list_iter_next+0xc6a>
180003838:     	xorl	%ecx, %ecx
18000383a:     	leal	0x7(%r9), %eax
18000383e:     	cpuid
180003840:     	movl	%edx, %esi
180003842:     	movl	%ebx, %r10d
180003845:     	btl	$0x9, %ebx
180003849:     	jae	0x180003856 <numba_list_iter_next+0xc46>
18000384b:     	orl	$0x2, %r8d
18000384f:     	movl	%r8d, 0x71be(%rip)      # 0x18000aa14
180003856:     	cmpl	$0x1, %eax
180003859:     	jl	0x180003868 <numba_list_iter_next+0xc58>
18000385b:     	movl	$0x7, %eax
180003860:     	leal	-0x6(%rax), %ecx
180003863:     	cpuid
180003865:     	movl	%edx, %r9d
180003868:     	movl	$0x24, %eax
18000386d:     	cmpl	%eax, %ebp
18000386f:     	jl	0x180003880 <numba_list_iter_next+0xc70>
180003871:     	xorl	%ecx, %ecx
180003873:     	cpuid
180003875:     	movl	%ebx, %r11d
180003878:     	jmp	0x180003880 <numba_list_iter_next+0xc70>
18000387a:     	movl	%r9d, %r10d
18000387d:     	movl	%r9d, %esi
180003880:     	movq	0x68a1(%rip), %rax      # 0x18000a128
180003887:     	andq	$-0x2, %rax
18000388b:     	movl	$0x1, 0x687b(%rip)      # 0x18000a110
180003895:     	movl	$0x2, 0x6875(%rip)      # 0x18000a114
18000389f:     	movq	%rax, 0x6882(%rip)      # 0x18000a128
1800038a6:     	btl	$0x14, %edi
1800038aa:     	jae	0x1800038cb <numba_list_iter_next+0xcbb>
1800038ac:     	andq	$-0x11, %rax
1800038b0:     	movl	$0x2, 0x6856(%rip)      # 0x18000a110
1800038ba:     	movq	%rax, 0x6867(%rip)      # 0x18000a128
1800038c1:     	movl	$0x6, 0x6849(%rip)      # 0x18000a114
1800038cb:     	btl	$0x1b, %edi
1800038cf:     	jae	0x180003a0c <numba_list_iter_next+0xdfc>
1800038d5:     	xorl	%ecx, %ecx
1800038d7:     	xgetbv
1800038da:     	shlq	$0x20, %rdx
1800038de:     	orq	%rax, %rdx
1800038e1:     	movq	%rdx, 0x20(%rsp)
1800038e6:     	btl	$0x1c, %edi
1800038ea:     	jae	0x1800039f0 <numba_list_iter_next+0xde0>
1800038f0:     	movq	0x20(%rsp), %rax
1800038f5:     	andb	$0x6, %al
1800038f7:     	cmpb	$0x6, %al
1800038f9:     	jne	0x1800039f0 <numba_list_iter_next+0xde0>
1800038ff:     	movl	0x680f(%rip), %eax      # 0x18000a114
180003905:     	movb	$-0x20, %dl
180003907:     	orl	$0x8, %eax
18000390a:     	movl	$0x3, 0x67fc(%rip)      # 0x18000a110
180003914:     	movl	%eax, 0x67fa(%rip)      # 0x18000a114
18000391a:     	testb	$0x20, %r10b
18000391e:     	je	0x180003982 <numba_list_iter_next+0xd72>
180003920:     	orl	$0x20, %eax
180003923:     	movl	$0x5, 0x67e3(%rip)      # 0x18000a110
18000392d:     	movl	%eax, 0x67e1(%rip)      # 0x18000a114
180003933:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180003938:     	movq	0x67e9(%rip), %rax      # 0x18000a128
18000393f:     	andl	%ecx, %r10d
180003942:     	andq	$-0x3, %rax
180003946:     	movq	%rax, 0x67db(%rip)      # 0x18000a128
18000394d:     	cmpl	%ecx, %r10d
180003950:     	jne	0x180003989 <numba_list_iter_next+0xd79>
180003952:     	movq	0x20(%rsp), %rax
180003957:     	andb	%dl, %al
180003959:     	cmpb	%dl, %al
18000395b:     	jne	0x180003982 <numba_list_iter_next+0xd72>
18000395d:     	movq	0x67c4(%rip), %rax      # 0x18000a128
180003964:     	orl	$0x40, 0x67a9(%rip)     # 0x18000a114
18000396b:     	andq	$-0x25, %rax
18000396f:     	movl	$0x6, 0x6797(%rip)      # 0x18000a110
180003979:     	movq	%rax, 0x67a8(%rip)      # 0x18000a128
180003980:     	jmp	0x180003989 <numba_list_iter_next+0xd79>
180003982:     	movq	0x679f(%rip), %rax      # 0x18000a128
180003989:     	btl	$0x17, %esi
18000398d:     	jae	0x18000399b <numba_list_iter_next+0xd8b>
18000398f:     	btrq	$0x18, %rax
180003994:     	movq	%rax, 0x678d(%rip)      # 0x18000a128
18000399b:     	btl	$0x13, %r9d
1800039a0:     	jae	0x1800039f0 <numba_list_iter_next+0xde0>
1800039a2:     	movq	0x20(%rsp), %rax
1800039a7:     	andb	%dl, %al
1800039a9:     	cmpb	%dl, %al
1800039ab:     	jne	0x1800039f0 <numba_list_iter_next+0xde0>
1800039ad:     	movq	0x6774(%rip), %rdx      # 0x18000a128
1800039b4:     	movl	%r11d, %eax
1800039b7:     	shrq	$0x10, %rax
1800039bb:     	movl	%r11d, %ecx
1800039be:     	andl	$0x6, %eax
1800039c1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
1800039c7:     	orq	$0x1000029, %rax        # imm = 0x1000029
1800039cd:     	movl	%ecx, 0x7045(%rip)      # 0x18000aa18
1800039d3:     	notq	%rax
1800039d6:     	andq	%rax, %rdx
1800039d9:     	movq	%rdx, 0x6748(%rip)      # 0x18000a128
1800039e0:     	cmpb	$0x1, %cl
1800039e3:     	jbe	0x1800039f0 <numba_list_iter_next+0xde0>
1800039e5:     	andq	$-0x41, %rdx
1800039e9:     	movq	%rdx, 0x6738(%rip)      # 0x18000a128
1800039f0:     	btl	$0x15, %r9d
1800039f5:     	jae	0x180003a0c <numba_list_iter_next+0xdfc>
1800039f7:     	movq	0x20(%rsp), %rax
1800039fc:     	btq	$0x13, %rax
180003a01:     	jae	0x180003a0c <numba_list_iter_next+0xdfc>
180003a03:     	btrq	$0x7, 0x671c(%rip)      # 0x18000a128
180003a0c:     	movq	0x28(%rsp), %rbx
180003a11:     	xorl	%eax, %eax
180003a13:     	movq	0x30(%rsp), %rbp
180003a18:     	movq	0x38(%rsp), %rsi
180003a1d:     	addq	$0x10, %rsp
180003a21:     	popq	%rdi
180003a22:     	retq
180003a23:     	int3
180003a24:     	movl	$0x1, %eax
180003a29:     	retq
180003a2a:     	int3
180003a2b:     	int3
180003a2c:     	xorl	%eax, %eax
180003a2e:     	cmpl	%eax, 0x66fc(%rip)      # 0x18000a130
180003a34:     	setne	%al
180003a37:     	retq
180003a38:     	int3
180003a39:     	int3
180003a3a:     	int3
180003a3b:     	int3
180003a3c:     	int3
180003a3d:     	int3
180003a3e:     	int3
180003a3f:     	int3
180003a40:     	jmpq	*0x602(%rip)            # 0x180004048
180003a46:     	jmpq	*0x604(%rip)            # 0x180004050
180003a4c:     	jmpq	*0x63e(%rip)            # 0x180004090
180003a52:     	jmpq	*0x640(%rip)            # 0x180004098
180003a58:     	jmpq	*0x642(%rip)            # 0x1800040a0
180003a5e:     	jmpq	*0x644(%rip)            # 0x1800040a8
180003a64:     	jmpq	*0x646(%rip)            # 0x1800040b0
180003a6a:     	jmpq	*0x610(%rip)            # 0x180004080
180003a70:     	jmpq	*0x642(%rip)            # 0x1800040b8
180003a76:     	jmpq	*0x60c(%rip)            # 0x180004088
180003a7c:     	movb	$0x1, %al
180003a7e:     	retq
180003a7f:     	int3
180003a80:     	xorl	%eax, %eax
180003a82:     	retq
180003a83:     	jmpq	*0x5af(%rip)            # 0x180004038
180003a89:     	jmpq	*0x5b1(%rip)            # 0x180004040
180003a8f:     	jmpq	*0x633(%rip)            # 0x1800040c8
180003a95:     	jmpq	*0x635(%rip)            # 0x1800040d0
180003a9b:     	int3
180003a9c:     	int3
180003a9d:     	int3
180003a9e:     	int3
180003a9f:     	int3
180003aa0:     	int3
180003aa1:     	int3
180003aa2:     	int3
180003aa3:     	int3
180003aa4:     	int3
180003aa5:     	int3
180003aa6:     	nopw	(%rax,%rax)
180003ab0:     	jmpq	*%rax
180003ab2:     	int3
180003ab3:     	int3
180003ab4:     	int3
180003ab5:     	int3
180003ab6:     	int3
180003ab7:     	int3
180003ab8:     	int3
180003ab9:     	int3
180003aba:     	int3
180003abb:     	int3
180003abc:     	int3
180003abd:     	int3
180003abe:     	int3
180003abf:     	int3
180003ac0:     	int3
180003ac1:     	int3
180003ac2:     	int3
180003ac3:     	int3
180003ac4:     	int3
180003ac5:     	int3
180003ac6:     	nopw	(%rax,%rax)
180003ad0:     	jmpq	*0x7ba(%rip)            # 0x180004290
180003ad6:     	pushq	%rbp
180003ad8:     	subq	$0x20, %rsp
180003adc:     	movq	%rdx, %rbp
180003adf:     	movb	0x40(%rbp), %cl
180003ae2:     	addq	$0x20, %rsp
180003ae6:     	popq	%rbp
180003ae7:     	jmp	0x1800036ac <numba_list_iter_next+0xa9c>
180003aec:     	int3
180003aed:     	pushq	%rbp
180003aef:     	subq	$0x20, %rsp
180003af3:     	movq	%rdx, %rbp
180003af6:     	movb	0x20(%rbp), %cl
180003af9:     	callq	0x1800036ac <numba_list_iter_next+0xa9c>
180003afe:     	nop
180003aff:     	addq	$0x20, %rsp
180003b03:     	popq	%rbp
180003b04:     	retq
180003b05:     	int3
180003b06:     	pushq	%rbp
180003b08:     	subq	$0x20, %rsp
180003b0c:     	movq	%rdx, %rbp
180003b0f:     	addq	$0x20, %rsp
180003b13:     	popq	%rbp
180003b14:     	jmp	0x180003538 <numba_list_iter_next+0x928>
180003b19:     	int3
180003b1a:     	pushq	%rbp
180003b1c:     	subq	$0x30, %rsp
180003b20:     	movq	%rdx, %rbp
180003b23:     	movq	(%rcx), %rax
180003b26:     	movl	(%rax), %edx
180003b28:     	movq	%rcx, 0x28(%rsp)
180003b2d:     	movl	%edx, 0x20(%rsp)
180003b31:     	leaq	-0xbc8(%rip), %r9       # 0x180002f70 <numba_list_iter_next+0x360>
180003b38:     	movq	0x70(%rbp), %r8
180003b3c:     	movl	0x68(%rbp), %edx
180003b3f:     	movq	0x60(%rbp), %rcx
180003b43:     	callq	0x1800034a8 <numba_list_iter_next+0x898>
180003b48:     	nop
180003b49:     	addq	$0x30, %rsp
180003b4d:     	popq	%rbp
180003b4e:     	retq
180003b4f:     	int3
180003b50:     	pushq	%rbp
180003b52:     	movq	%rdx, %rbp
180003b55:     	movq	(%rcx), %rax
180003b58:     	xorl	%ecx, %ecx
180003b5a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003b60:     	sete	%cl
180003b63:     	movl	%ecx, %eax
180003b65:     	popq	%rbp
180003b66:     	retq
180003b67:     	int3
