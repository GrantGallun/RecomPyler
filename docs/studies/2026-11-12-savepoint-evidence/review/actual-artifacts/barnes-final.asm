
D:\Code\Datathon\recompyler-codex-20261111\wave8-native\results\cache\barnes_hut\final\recompyler\rcaotr_962a53ce990e9bd4541a3246.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x1800089d0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x93f9(%rip), %rax      # 0x18000a480
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	pushq	%r14
180001092:     	pushq	%rsi
180001093:     	pushq	%rdi
180001094:     	pushq	%rbx
180001095:     	subq	$0x78, %rsp
180001099:     	movq	%rcx, %rsi
18000109c:     	movq	0x108(%rsp), %rax
1800010a4:     	movq	0xf0(%rsp), %rcx
1800010ac:     	movq	0xd8(%rsp), %r10
1800010b4:     	movq	0xc0(%rsp), %r11
1800010bc:     	movq	0x100(%rsp), %rdi
1800010c4:     	movq	0xe8(%rsp), %rbx
1800010cc:     	movq	$0x0, 0x68(%rsp)
1800010d5:     	movq	0xd0(%rsp), %r14
1800010dd:     	xorq	%r9, %r14
1800010e0:     	xorq	$0x4, %rbx
1800010e4:     	orq	%r14, %rbx
1800010e7:     	xorq	$0x1, %rdi
1800010eb:     	xorq	$0x8, %r11
1800010ef:     	orq	%rdi, %r11
1800010f2:     	orq	%rbx, %r11
1800010f5:     	xorq	$0x8, %r10
1800010f9:     	xorq	$0x8, %rcx
1800010fd:     	orq	%r10, %rcx
180001100:     	orq	%r11, %rcx
180001103:     	xorq	$0x1, %rax
180001107:     	orq	%rcx, %rax
18000110a:     	jne	0x1800011aa <.text+0x1aa>
180001110:     	movq	%rdx, %rdi
180001113:     	movq	0x130(%rsp), %rcx
18000111b:     	movq	0x128(%rsp), %rdx
180001123:     	movsd	0x120(%rsp), %xmm0
18000112c:     	movsd	0x118(%rsp), %xmm1
180001135:     	movq	0x110(%rsp), %r10
18000113d:     	movq	0xf8(%rsp), %r11
180001145:     	movq	0xe0(%rsp), %rbx
18000114d:     	movq	0xc8(%rsp), %rax
180001155:     	movq	$0x0, 0x70(%rsp)
18000115e:     	movq	%rcx, 0x58(%rsp)
180001163:     	movq	%rdx, 0x50(%rsp)
180001168:     	movsd	%xmm0, 0x48(%rsp)
18000116e:     	movsd	%xmm1, 0x40(%rsp)
180001174:     	movq	%r10, 0x38(%rsp)
180001179:     	movq	%r9, 0x30(%rsp)
18000117e:     	movq	%r11, 0x28(%rsp)
180001183:     	movq	%rbx, 0x20(%rsp)
180001188:     	leaq	0x70(%rsp), %rcx
18000118d:     	leaq	0x68(%rsp), %rdx
180001192:     	movq	%rax, %r9
180001195:     	callq	0x1800025d0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x60>
18000119a:     	testl	%eax, %eax
18000119c:     	jne	0x1800011c3 <.text+0x1c3>
18000119e:     	movq	0x70(%rsp), %rax
1800011a3:     	movq	%rax, (%rsi)
1800011a6:     	xorl	%eax, %eax
1800011a8:     	jmp	0x1800011b9 <.text+0x1b9>
1800011aa:     	leaq	0x939f(%rip), %rax      # 0x18000a550
1800011b1:     	movq	%rax, (%rdx)
1800011b4:     	movl	$0x1, %eax
1800011b9:     	addq	$0x78, %rsp
1800011bd:     	popq	%rbx
1800011be:     	popq	%rdi
1800011bf:     	popq	%rsi
1800011c0:     	popq	%r14
1800011c2:     	retq
1800011c3:     	movq	0x68(%rsp), %rcx
1800011c8:     	movq	%rcx, (%rdi)
1800011cb:     	jmp	0x1800011b9 <.text+0x1b9>
1800011cd:     	nopl	(%rax)
1800011d0:     	pushq	%r15
1800011d2:     	pushq	%r14
1800011d4:     	pushq	%r13
1800011d6:     	pushq	%r12
1800011d8:     	pushq	%rsi
1800011d9:     	pushq	%rdi
1800011da:     	pushq	%rbp
1800011db:     	pushq	%rbx
1800011dc:     	subq	$0x278, %rsp            # imm = 0x278
1800011e3:     	movaps	%xmm7, 0x260(%rsp)
1800011eb:     	movaps	%xmm6, 0x250(%rsp)
1800011f3:     	movq	%rdx, %rcx
1800011f6:     	leaq	0x108(%rsp), %rax
1800011fe:     	movq	%rax, 0x60(%rsp)
180001203:     	leaq	0x110(%rsp), %rax
18000120b:     	movq	%rax, 0x58(%rsp)
180001210:     	leaq	0x118(%rsp), %rax
180001218:     	movq	%rax, 0x50(%rsp)
18000121d:     	leaq	0x120(%rsp), %rax
180001225:     	movq	%rax, 0x48(%rsp)
18000122a:     	leaq	0x128(%rsp), %rax
180001232:     	movq	%rax, 0x40(%rsp)
180001237:     	leaq	0x130(%rsp), %rax
18000123f:     	movq	%rax, 0x38(%rsp)
180001244:     	leaq	0x138(%rsp), %rax
18000124c:     	movq	%rax, 0x30(%rsp)
180001251:     	leaq	0x140(%rsp), %rax
180001259:     	movq	%rax, 0x28(%rsp)
18000125e:     	leaq	0x148(%rsp), %rax
180001266:     	movq	%rax, 0x20(%rsp)
18000126b:     	leaq	0x930e(%rip), %rdx      # 0x18000a580
180001272:     	movl	$0x9, %r8d
180001278:     	movl	$0x9, %r9d
18000127e:     	callq	0x180008b81 <numba_list_iter_next+0x311>
180001283:     	testl	%eax, %eax
180001285:     	movq	$0x0, 0xb8(%rsp)
180001291:     	je	0x18000183b <.text+0x83b>
180001297:     	cmpq	$0x0, 0x10a59(%rip)     # 0x180011cf8
18000129f:     	je	0x180001773 <.text+0x773>
1800012a5:     	movq	0x148(%rsp), %rcx
1800012ad:     	xorps	%xmm0, %xmm0
1800012b0:     	movaps	%xmm0, 0x210(%rsp)
1800012b8:     	movaps	%xmm0, 0x220(%rsp)
1800012c0:     	movaps	%xmm0, 0x230(%rsp)
1800012c8:     	movq	$0x0, 0x240(%rsp)
1800012d4:     	leaq	0x210(%rsp), %rdx
1800012dc:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
1800012e1:     	testl	%eax, %eax
1800012e3:     	jne	0x18000178b <.text+0x78b>
1800012e9:     	cmpq	$0x8, 0x228(%rsp)
1800012f2:     	jne	0x18000178b <.text+0x78b>
1800012f8:     	movq	0x210(%rsp), %rdi
180001300:     	movq	0x230(%rsp), %r14
180001308:     	movq	0x238(%rsp), %r12
180001310:     	movq	0x240(%rsp), %rbx
180001318:     	movq	0x140(%rsp), %rcx
180001320:     	xorps	%xmm0, %xmm0
180001323:     	movaps	%xmm0, 0x1d0(%rsp)
18000132b:     	movaps	%xmm0, 0x1e0(%rsp)
180001333:     	movaps	%xmm0, 0x1f0(%rsp)
18000133b:     	movq	$0x0, 0x200(%rsp)
180001347:     	leaq	0x1d0(%rsp), %rdx
18000134f:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
180001354:     	testl	%eax, %eax
180001356:     	jne	0x1800017a3 <.text+0x7a3>
18000135c:     	cmpq	$0x8, 0x1e8(%rsp)
180001365:     	jne	0x1800017a3 <.text+0x7a3>
18000136b:     	movq	0x1d0(%rsp), %r15
180001373:     	movq	0x1f0(%rsp), %rbp
18000137b:     	movq	0x1f8(%rsp), %rsi
180001383:     	movq	0x200(%rsp), %r13
18000138b:     	movq	0x138(%rsp), %rcx
180001393:     	xorps	%xmm0, %xmm0
180001396:     	movaps	%xmm0, 0x190(%rsp)
18000139e:     	movaps	%xmm0, 0x1a0(%rsp)
1800013a6:     	movaps	%xmm0, 0x1b0(%rsp)
1800013ae:     	movq	$0x0, 0x1c0(%rsp)
1800013ba:     	leaq	0x190(%rsp), %rdx
1800013c2:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
1800013c7:     	testl	%eax, %eax
1800013c9:     	jne	0x1800017b8 <.text+0x7b8>
1800013cf:     	cmpq	$0x8, 0x1a8(%rsp)
1800013d8:     	jne	0x1800017b8 <.text+0x7b8>
1800013de:     	movq	%r13, 0x100(%rsp)
1800013e6:     	movq	0x190(%rsp), %r13
1800013ee:     	movq	0x1b0(%rsp), %rax
1800013f6:     	movq	%rax, 0xf8(%rsp)
1800013fe:     	movq	0x1b8(%rsp), %rax
180001406:     	movq	%rax, 0xf0(%rsp)
18000140e:     	movq	0x1c0(%rsp), %rax
180001416:     	movq	%rax, 0xe8(%rsp)
18000141e:     	movq	0x130(%rsp), %rcx
180001426:     	xorps	%xmm0, %xmm0
180001429:     	movaps	%xmm0, 0x150(%rsp)
180001431:     	movaps	%xmm0, 0x160(%rsp)
180001439:     	movaps	%xmm0, 0x170(%rsp)
180001441:     	movq	$0x0, 0x180(%rsp)
18000144d:     	leaq	0x150(%rsp), %rdx
180001455:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
18000145a:     	testl	%eax, %eax
18000145c:     	jne	0x1800017cd <.text+0x7cd>
180001462:     	cmpq	$0x1, 0x168(%rsp)
18000146b:     	jne	0x1800017cd <.text+0x7cd>
180001471:     	movq	%rsi, 0xd8(%rsp)
180001479:     	movq	0x150(%rsp), %rax
180001481:     	movq	%rax, 0xa8(%rsp)
180001489:     	movq	0x170(%rsp), %rax
180001491:     	movq	%rax, 0xd0(%rsp)
180001499:     	movq	0x178(%rsp), %rax
1800014a1:     	movq	%rax, 0xc8(%rsp)
1800014a9:     	movq	0x180(%rsp), %rax
1800014b1:     	movq	%rax, 0xc0(%rsp)
1800014b9:     	movq	0x128(%rsp), %rcx
1800014c1:     	callq	0x180008b87 <numba_list_iter_next+0x317>
1800014c6:     	testq	%rax, %rax
1800014c9:     	movq	%r13, 0xb0(%rsp)
1800014d1:     	movq	%rbp, 0xe0(%rsp)
1800014d9:     	je	0x1800017e2 <.text+0x7e2>
1800014df:     	movq	%rax, %rsi
1800014e2:     	movq	%rax, %rcx
1800014e5:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
1800014ea:     	movq	%rax, 0xa0(%rsp)
1800014f2:     	movq	%rsi, %rcx
1800014f5:     	callq	0x180008b93 <numba_list_iter_next+0x323>
1800014fa:     	callq	0x180008b99 <numba_list_iter_next+0x329>
1800014ff:     	testq	%rax, %rax
180001502:     	jne	0x18000180e <.text+0x80e>
180001508:     	movq	0x120(%rsp), %rcx
180001510:     	callq	0x180008b9f <numba_list_iter_next+0x32f>
180001515:     	movq	%rax, %rsi
180001518:     	movq	%rax, %rcx
18000151b:     	callq	0x180008ba5 <numba_list_iter_next+0x335>
180001520:     	movaps	%xmm0, %xmm6
180001523:     	movq	%rsi, %rcx
180001526:     	callq	0x180008b93 <numba_list_iter_next+0x323>
18000152b:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001530:     	testq	%rax, %rax
180001533:     	jne	0x18000180e <.text+0x80e>
180001539:     	movq	0x118(%rsp), %rcx
180001541:     	callq	0x180008b9f <numba_list_iter_next+0x32f>
180001546:     	movq	%rax, %rsi
180001549:     	movq	%rax, %rcx
18000154c:     	callq	0x180008ba5 <numba_list_iter_next+0x335>
180001551:     	movaps	%xmm0, %xmm7
180001554:     	movq	%rsi, %rcx
180001557:     	callq	0x180008b93 <numba_list_iter_next+0x323>
18000155c:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001561:     	testq	%rax, %rax
180001564:     	jne	0x18000180e <.text+0x80e>
18000156a:     	movq	0x110(%rsp), %rcx
180001572:     	callq	0x180008b87 <numba_list_iter_next+0x317>
180001577:     	testq	%rax, %rax
18000157a:     	je	0x1800017fe <.text+0x7fe>
180001580:     	movq	%rax, %rsi
180001583:     	movq	%rax, %rcx
180001586:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
18000158b:     	movq	%rax, %rbp
18000158e:     	movq	%rsi, %rcx
180001591:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180001596:     	callq	0x180008b99 <numba_list_iter_next+0x329>
18000159b:     	testq	%rax, %rax
18000159e:     	jne	0x18000180e <.text+0x80e>
1800015a4:     	movq	%rbx, %r13
1800015a7:     	movq	%r12, %rbx
1800015aa:     	movq	%r14, %r12
1800015ad:     	movq	%r15, %r14
1800015b0:     	movq	%rdi, %r15
1800015b3:     	movq	0x108(%rsp), %rcx
1800015bb:     	callq	0x180008b87 <numba_list_iter_next+0x317>
1800015c0:     	testq	%rax, %rax
1800015c3:     	je	0x180001842 <.text+0x842>
1800015c9:     	movq	%rax, %rdi
1800015cc:     	movq	%rax, %rcx
1800015cf:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
1800015d4:     	movq	%rax, %rsi
1800015d7:     	movq	%rdi, %rcx
1800015da:     	callq	0x180008b93 <numba_list_iter_next+0x323>
1800015df:     	callq	0x180008b99 <numba_list_iter_next+0x329>
1800015e4:     	testq	%rax, %rax
1800015e7:     	movq	%r15, %rdi
1800015ea:     	movq	%r14, %r15
1800015ed:     	jne	0x18000180e <.text+0x80e>
1800015f3:     	movq	%rsi, 0x90(%rsp)
1800015fb:     	movq	%rbp, 0x88(%rsp)
180001603:     	movsd	%xmm7, 0x80(%rsp)
18000160c:     	movsd	%xmm6, 0x78(%rsp)
180001612:     	movq	0xa0(%rsp), %rax
18000161a:     	movq	%rax, 0x70(%rsp)
18000161f:     	movq	0xc0(%rsp), %rax
180001627:     	movq	%rax, 0x68(%rsp)
18000162c:     	movq	0xc8(%rsp), %rax
180001634:     	movq	%rax, 0x60(%rsp)
180001639:     	movq	0xd0(%rsp), %rax
180001641:     	movq	%rax, 0x58(%rsp)
180001646:     	movq	0xe8(%rsp), %rax
18000164e:     	movq	%rax, 0x50(%rsp)
180001653:     	movq	0xf0(%rsp), %rax
18000165b:     	movq	%rax, 0x48(%rsp)
180001660:     	movq	0xf8(%rsp), %rax
180001668:     	movq	%rax, 0x40(%rsp)
18000166d:     	movq	0x100(%rsp), %rax
180001675:     	movq	%rax, 0x38(%rsp)
18000167a:     	movq	0xd8(%rsp), %rax
180001682:     	movq	%rax, 0x30(%rsp)
180001687:     	movq	0xe0(%rsp), %rax
18000168f:     	movq	%rax, 0x28(%rsp)
180001694:     	movq	%r13, 0x20(%rsp)
180001699:     	leaq	0x248(%rsp), %rcx
1800016a1:     	leaq	0xb8(%rsp), %rdx
1800016a9:     	movq	%r12, %r8
1800016ac:     	movq	%rbx, %r9
1800016af:     	callq	0x180001090 <.text+0x90>
1800016b4:     	movl	%eax, %ebp
1800016b6:     	movq	0xb8(%rsp), %rbx
1800016be:     	movq	%rdi, %rcx
1800016c1:     	callq	0x180001060 <.text+0x60>
1800016c6:     	movq	%r15, %rcx
1800016c9:     	callq	0x180001060 <.text+0x60>
1800016ce:     	movq	0xb0(%rsp), %rcx
1800016d6:     	callq	0x180001060 <.text+0x60>
1800016db:     	movq	0xa8(%rsp), %rcx
1800016e3:     	callq	0x180001060 <.text+0x60>
1800016e8:     	testl	%ebp, %ebp
1800016ea:     	jne	0x180001722 <.text+0x722>
1800016ec:     	movq	0x8bdd(%rip), %rsi      # 0x18000a2d0
1800016f3:     	movq	%rsi, %rcx
1800016f6:     	callq	0x180008bab <numba_list_iter_next+0x33b>
1800016fb:     	movq	%rsi, %rax
1800016fe:     	movaps	0x250(%rsp), %xmm6
180001706:     	movaps	0x260(%rsp), %xmm7
18000170e:     	addq	$0x278, %rsp            # imm = 0x278
180001715:     	popq	%rbx
180001716:     	popq	%rbp
180001717:     	popq	%rdi
180001718:     	popq	%rsi
180001719:     	popq	%r12
18000171b:     	popq	%r13
18000171d:     	popq	%r14
18000171f:     	popq	%r15
180001721:     	retq
180001722:     	jle	0x180001849 <.text+0x849>
180001728:     	callq	0x180008bb1 <numba_list_iter_next+0x341>
18000172d:     	movl	0x8(%rbx), %edx
180001730:     	movq	(%rbx), %rcx
180001733:     	cmpl	$0x0, 0x20(%rbx)
180001737:     	jle	0x180001868 <.text+0x868>
18000173d:     	movslq	%edx, %rdx
180001740:     	callq	0x180008bb7 <numba_list_iter_next+0x347>
180001745:     	movq	%rax, %rsi
180001748:     	movq	0x10(%rbx), %rcx
18000174c:     	callq	*0x18(%rbx)
18000174f:     	testq	%rax, %rax
180001752:     	je	0x180001891 <.text+0x891>
180001758:     	movq	%rsi, %rcx
18000175b:     	movq	%rax, %rdx
18000175e:     	callq	0x180007050 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ae0>
180001763:     	movq	%rax, %rsi
180001766:     	movq	%rbx, %rcx
180001769:     	callq	0x180008ae0 <numba_list_iter_next+0x270>
18000176e:     	jmp	0x180001874 <.text+0x874>
180001773:     	movq	0x8b36(%rip), %rcx      # 0x18000a2b0
18000177a:     	leaq	0x8e1f(%rip), %rdx      # 0x18000a5a0
180001781:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180001786:     	jmp	0x18000183b <.text+0x83b>
18000178b:     	movq	0x8b0e(%rip), %rcx      # 0x18000a2a0
180001792:     	leaq	0x8f07(%rip), %rdx      # 0x18000a6a0
180001799:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
18000179e:     	jmp	0x18000183b <.text+0x83b>
1800017a3:     	movq	0x8af6(%rip), %rcx      # 0x18000a2a0
1800017aa:     	leaq	0x8eef(%rip), %rdx      # 0x18000a6a0
1800017b1:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800017b6:     	jmp	0x180001833 <.text+0x833>
1800017b8:     	movq	0x8ae1(%rip), %rcx      # 0x18000a2a0
1800017bf:     	leaq	0x8eda(%rip), %rdx      # 0x18000a6a0
1800017c6:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800017cb:     	jmp	0x18000182b <.text+0x82b>
1800017cd:     	movq	0x8acc(%rip), %rcx      # 0x18000a2a0
1800017d4:     	leaq	0x8ec5(%rip), %rdx      # 0x18000a6a0
1800017db:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800017e0:     	jmp	0x180001823 <.text+0x823>
1800017e2:     	movq	$0x0, 0xa0(%rsp)
1800017ee:     	callq	0x180008b99 <numba_list_iter_next+0x329>
1800017f3:     	testq	%rax, %rax
1800017f6:     	je	0x180001508 <.text+0x508>
1800017fc:     	jmp	0x18000180e <.text+0x80e>
1800017fe:     	xorl	%ebp, %ebp
180001800:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001805:     	testq	%rax, %rax
180001808:     	je	0x1800015a4 <.text+0x5a4>
18000180e:     	movq	0xa8(%rsp), %rcx
180001816:     	callq	0x180001060 <.text+0x60>
18000181b:     	movq	0xb0(%rsp), %r13
180001823:     	movq	%r13, %rcx
180001826:     	callq	0x180001060 <.text+0x60>
18000182b:     	movq	%r15, %rcx
18000182e:     	callq	0x180001060 <.text+0x60>
180001833:     	movq	%rdi, %rcx
180001836:     	callq	0x180001060 <.text+0x60>
18000183b:     	xorl	%esi, %esi
18000183d:     	jmp	0x1800016fb <.text+0x6fb>
180001842:     	xorl	%esi, %esi
180001844:     	jmp	0x1800015df <.text+0x5df>
180001849:     	cmpl	$-0x3, %ebp
18000184c:     	je	0x180001883 <.text+0x883>
18000184e:     	cmpl	$-0x1, %ebp
180001851:     	je	0x18000183b <.text+0x83b>
180001853:     	movq	0x8a3e(%rip), %rcx      # 0x18000a298
18000185a:     	leaq	0x8edf(%rip), %rdx      # 0x18000a740
180001861:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180001866:     	jmp	0x18000183b <.text+0x83b>
180001868:     	movq	0x10(%rbx), %r8
18000186c:     	callq	0x180006f70 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a00>
180001871:     	movq	%rax, %rsi
180001874:     	testq	%rsi, %rsi
180001877:     	je	0x18000183b <.text+0x83b>
180001879:     	movq	%rsi, %rcx
18000187c:     	callq	0x180006b10 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x45a0>
180001881:     	jmp	0x18000183b <.text+0x83b>
180001883:     	movq	0x8a06(%rip), %rcx      # 0x18000a290
18000188a:     	callq	0x180008bc3 <numba_list_iter_next+0x353>
18000188f:     	jmp	0x18000183b <.text+0x83b>
180001891:     	movq	0x8a18(%rip), %rcx      # 0x18000a2b0
180001898:     	leaq	0x8e61(%rip), %rdx      # 0x18000a700
18000189f:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800018a4:     	jmp	0x18000183b <.text+0x83b>
1800018a6:     	nopw	%cs:(%rax,%rax)
1800018b0:     	pushq	%r15
1800018b2:     	pushq	%r14
1800018b4:     	pushq	%r13
1800018b6:     	pushq	%r12
1800018b8:     	pushq	%rsi
1800018b9:     	pushq	%rdi
1800018ba:     	pushq	%rbp
1800018bb:     	pushq	%rbx
1800018bc:     	subq	$0xb8, %rsp
1800018c3:     	movq	0x120(%rsp), %r8
1800018cb:     	movq	0x128(%rsp), %r9
1800018d3:     	movq	0x130(%rsp), %rax
1800018db:     	movq	0x158(%rsp), %rcx
1800018e3:     	movq	0x160(%rsp), %rdx
1800018eb:     	movq	0x168(%rsp), %r10
1800018f3:     	movq	0x190(%rsp), %r11
1800018fb:     	movq	0x198(%rsp), %rsi
180001903:     	movq	0x1a0(%rsp), %rdi
18000190b:     	movq	0x1c8(%rsp), %rbx
180001913:     	movq	0x1d0(%rsp), %r14
18000191b:     	movq	0x1d8(%rsp), %r15
180001923:     	movq	0x1e0(%rsp), %r12
18000192b:     	movsd	0x1e8(%rsp), %xmm0
180001934:     	movsd	0x1f0(%rsp), %xmm1
18000193d:     	movq	0x1f8(%rsp), %r13
180001945:     	movq	0x200(%rsp), %rbp
18000194d:     	movq	$0x0, 0xb0(%rsp)
180001959:     	movq	$0x0, 0xa8(%rsp)
180001965:     	movq	%rbp, 0x90(%rsp)
18000196d:     	movq	%r13, 0x88(%rsp)
180001975:     	movsd	%xmm1, 0x80(%rsp)
18000197e:     	movsd	%xmm0, 0x78(%rsp)
180001984:     	movq	%r12, 0x70(%rsp)
180001989:     	movq	%r15, 0x68(%rsp)
18000198e:     	movq	%r14, 0x60(%rsp)
180001993:     	movq	%rbx, 0x58(%rsp)
180001998:     	movq	%rdi, 0x50(%rsp)
18000199d:     	movq	%rsi, 0x48(%rsp)
1800019a2:     	movq	%r11, 0x40(%rsp)
1800019a7:     	movq	%r10, 0x38(%rsp)
1800019ac:     	movq	%rdx, 0x30(%rsp)
1800019b1:     	movq	%rcx, 0x28(%rsp)
1800019b6:     	movq	%rax, 0x20(%rsp)
1800019bb:     	leaq	0xb0(%rsp), %rcx
1800019c3:     	leaq	0xa8(%rsp), %rdx
1800019cb:     	callq	0x180001090 <.text+0x90>
1800019d0:     	movl	%eax, %edx
1800019d2:     	movq	0xa8(%rsp), %rsi
1800019da:     	movq	0xb0(%rsp), %rax
1800019e2:     	movl	$0x0, 0xa4(%rsp)
1800019ed:     	testl	%edx, %edx
1800019ef:     	jne	0x180001a05 <.text+0xa05>
1800019f1:     	addq	$0xb8, %rsp
1800019f8:     	popq	%rbx
1800019f9:     	popq	%rbp
1800019fa:     	popq	%rdi
1800019fb:     	popq	%rsi
1800019fc:     	popq	%r12
1800019fe:     	popq	%r13
180001a00:     	popq	%r14
180001a02:     	popq	%r15
180001a04:     	retq
180001a05:     	movq	%rax, %rbx
180001a08:     	leaq	0xa4(%rsp), %rcx
180001a10:     	movl	%edx, %edi
180001a12:     	callq	0x180006ae0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4570>
180001a17:     	testl	%edi, %edi
180001a19:     	jle	0x180001a5f <.text+0xa5f>
180001a1b:     	callq	0x180008bb1 <numba_list_iter_next+0x341>
180001a20:     	movl	0x8(%rsi), %edx
180001a23:     	movq	(%rsi), %rcx
180001a26:     	cmpl	$0x0, 0x20(%rsi)
180001a2a:     	jle	0x180001a80 <.text+0xa80>
180001a2c:     	movslq	%edx, %rdx
180001a2f:     	callq	0x180008bb7 <numba_list_iter_next+0x347>
180001a34:     	movq	%rax, %rdi
180001a37:     	movq	0x10(%rsi), %rcx
180001a3b:     	callq	*0x18(%rsi)
180001a3e:     	testq	%rax, %rax
180001a41:     	je	0x180001adb <.text+0xadb>
180001a47:     	movq	%rdi, %rcx
180001a4a:     	movq	%rax, %rdx
180001a4d:     	callq	0x180007050 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ae0>
180001a52:     	movq	%rax, %rdi
180001a55:     	movq	%rsi, %rcx
180001a58:     	callq	0x180008ae0 <numba_list_iter_next+0x270>
180001a5d:     	jmp	0x180001a8c <.text+0xa8c>
180001a5f:     	movl	%edi, %eax
180001a61:     	cmpl	$-0x3, %edi
180001a64:     	je	0x180001acd <.text+0xacd>
180001a66:     	cmpl	$-0x1, %eax
180001a69:     	je	0x180001a99 <.text+0xa99>
180001a6b:     	movq	0x8826(%rip), %rcx      # 0x18000a298
180001a72:     	leaq	0x8d37(%rip), %rdx      # 0x18000a7b0
180001a79:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180001a7e:     	jmp	0x180001a99 <.text+0xa99>
180001a80:     	movq	0x10(%rsi), %r8
180001a84:     	callq	0x180006f70 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a00>
180001a89:     	movq	%rax, %rdi
180001a8c:     	testq	%rdi, %rdi
180001a8f:     	je	0x180001a99 <.text+0xa99>
180001a91:     	movq	%rdi, %rcx
180001a94:     	callq	0x180006b10 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x45a0>
180001a99:     	leaq	0x8d40(%rip), %rcx      # 0x18000a7e0
180001aa0:     	callq	0x180008bc9 <numba_list_iter_next+0x359>
180001aa5:     	movq	%rax, %rsi
180001aa8:     	movq	%rax, %rcx
180001aab:     	callq	0x180008bcf <numba_list_iter_next+0x35f>
180001ab0:     	movq	%rsi, %rcx
180001ab3:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180001ab8:     	leaq	0xa4(%rsp), %rcx
180001ac0:     	callq	0x180006b00 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4590>
180001ac5:     	movq	%rbx, %rax
180001ac8:     	jmp	0x1800019f1 <.text+0x9f1>
180001acd:     	movq	0x87bc(%rip), %rcx      # 0x18000a290
180001ad4:     	callq	0x180008bc3 <numba_list_iter_next+0x353>
180001ad9:     	jmp	0x180001a99 <.text+0xa99>
180001adb:     	movq	0x87ce(%rip), %rcx      # 0x18000a2b0
180001ae2:     	leaq	0x8c87(%rip), %rdx      # 0x18000a770
180001ae9:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180001aee:     	xorl	%eax, %eax
180001af0:     	jmp	0x1800019f1 <.text+0x9f1>
180001af5:     	nopw	%cs:(%rax,%rax)
180001aff:     	nop
180001b00:     	pushq	%r14
180001b02:     	pushq	%rsi
180001b03:     	pushq	%rdi
180001b04:     	pushq	%rbx
180001b05:     	subq	$0x78, %rsp
180001b09:     	movq	%rcx, %rsi
180001b0c:     	movq	0x108(%rsp), %rax
180001b14:     	movq	0xf0(%rsp), %rcx
180001b1c:     	movq	0xd8(%rsp), %r10
180001b24:     	movq	0xc0(%rsp), %r11
180001b2c:     	movq	0x100(%rsp), %rdi
180001b34:     	movq	0xe8(%rsp), %rbx
180001b3c:     	movq	$0x0, 0x68(%rsp)
180001b45:     	movq	0xd0(%rsp), %r14
180001b4d:     	xorq	%r9, %r14
180001b50:     	xorq	$0x4, %rbx
180001b54:     	orq	%r14, %rbx
180001b57:     	xorq	$0x1, %rdi
180001b5b:     	xorq	$0x8, %r11
180001b5f:     	orq	%rdi, %r11
180001b62:     	orq	%rbx, %r11
180001b65:     	xorq	$0x8, %r10
180001b69:     	xorq	$0x8, %rcx
180001b6d:     	orq	%r10, %rcx
180001b70:     	orq	%r11, %rcx
180001b73:     	xorq	$0x1, %rax
180001b77:     	orq	%rcx, %rax
180001b7a:     	jne	0x180001c1a <.text+0xc1a>
180001b80:     	movq	%rdx, %rdi
180001b83:     	movq	0x130(%rsp), %rcx
180001b8b:     	movq	0x128(%rsp), %rdx
180001b93:     	movsd	0x120(%rsp), %xmm0
180001b9c:     	movsd	0x118(%rsp), %xmm1
180001ba5:     	movq	0x110(%rsp), %r10
180001bad:     	movq	0xf8(%rsp), %r11
180001bb5:     	movq	0xe0(%rsp), %rbx
180001bbd:     	movq	0xc8(%rsp), %rax
180001bc5:     	movq	$0x0, 0x70(%rsp)
180001bce:     	movq	%rcx, 0x58(%rsp)
180001bd3:     	movq	%rdx, 0x50(%rsp)
180001bd8:     	movsd	%xmm0, 0x48(%rsp)
180001bde:     	movsd	%xmm1, 0x40(%rsp)
180001be4:     	movq	%r10, 0x38(%rsp)
180001be9:     	movq	%r9, 0x30(%rsp)
180001bee:     	movq	%r11, 0x28(%rsp)
180001bf3:     	movq	%rbx, 0x20(%rsp)
180001bf8:     	leaq	0x70(%rsp), %rcx
180001bfd:     	leaq	0x68(%rsp), %rdx
180001c02:     	movq	%rax, %r9
180001c05:     	callq	0x1800046c0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2150>
180001c0a:     	testl	%eax, %eax
180001c0c:     	jne	0x180001c33 <.text+0xc33>
180001c0e:     	movq	0x70(%rsp), %rax
180001c13:     	movq	%rax, (%rsi)
180001c16:     	xorl	%eax, %eax
180001c18:     	jmp	0x180001c29 <.text+0xc29>
180001c1a:     	leaq	0x8c7f(%rip), %rax      # 0x18000a8a0
180001c21:     	movq	%rax, (%rdx)
180001c24:     	movl	$0x1, %eax
180001c29:     	addq	$0x78, %rsp
180001c2d:     	popq	%rbx
180001c2e:     	popq	%rdi
180001c2f:     	popq	%rsi
180001c30:     	popq	%r14
180001c32:     	retq
180001c33:     	movq	0x68(%rsp), %rcx
180001c38:     	movq	%rcx, (%rdi)
180001c3b:     	jmp	0x180001c29 <.text+0xc29>
180001c3d:     	nopl	(%rax)
180001c40:     	pushq	%r15
180001c42:     	pushq	%r14
180001c44:     	pushq	%r13
180001c46:     	pushq	%r12
180001c48:     	pushq	%rsi
180001c49:     	pushq	%rdi
180001c4a:     	pushq	%rbp
180001c4b:     	pushq	%rbx
180001c4c:     	subq	$0x278, %rsp            # imm = 0x278
180001c53:     	movaps	%xmm7, 0x260(%rsp)
180001c5b:     	movaps	%xmm6, 0x250(%rsp)
180001c63:     	movq	%rdx, %rcx
180001c66:     	leaq	0x108(%rsp), %rax
180001c6e:     	movq	%rax, 0x60(%rsp)
180001c73:     	leaq	0x110(%rsp), %rax
180001c7b:     	movq	%rax, 0x58(%rsp)
180001c80:     	leaq	0x118(%rsp), %rax
180001c88:     	movq	%rax, 0x50(%rsp)
180001c8d:     	leaq	0x120(%rsp), %rax
180001c95:     	movq	%rax, 0x48(%rsp)
180001c9a:     	leaq	0x128(%rsp), %rax
180001ca2:     	movq	%rax, 0x40(%rsp)
180001ca7:     	leaq	0x130(%rsp), %rax
180001caf:     	movq	%rax, 0x38(%rsp)
180001cb4:     	leaq	0x138(%rsp), %rax
180001cbc:     	movq	%rax, 0x30(%rsp)
180001cc1:     	leaq	0x140(%rsp), %rax
180001cc9:     	movq	%rax, 0x28(%rsp)
180001cce:     	leaq	0x148(%rsp), %rax
180001cd6:     	movq	%rax, 0x20(%rsp)
180001cdb:     	leaq	0x8bee(%rip), %rdx      # 0x18000a8d0
180001ce2:     	movl	$0x9, %r8d
180001ce8:     	movl	$0x9, %r9d
180001cee:     	callq	0x180008b81 <numba_list_iter_next+0x311>
180001cf3:     	testl	%eax, %eax
180001cf5:     	movq	$0x0, 0xb8(%rsp)
180001d01:     	je	0x1800022ab <.text+0x12ab>
180001d07:     	cmpq	$0x0, 0xffe1(%rip)      # 0x180011cf0
180001d0f:     	je	0x1800021e3 <.text+0x11e3>
180001d15:     	movq	0x148(%rsp), %rcx
180001d1d:     	xorps	%xmm0, %xmm0
180001d20:     	movaps	%xmm0, 0x210(%rsp)
180001d28:     	movaps	%xmm0, 0x220(%rsp)
180001d30:     	movaps	%xmm0, 0x230(%rsp)
180001d38:     	movq	$0x0, 0x240(%rsp)
180001d44:     	leaq	0x210(%rsp), %rdx
180001d4c:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
180001d51:     	testl	%eax, %eax
180001d53:     	jne	0x1800021fb <.text+0x11fb>
180001d59:     	cmpq	$0x8, 0x228(%rsp)
180001d62:     	jne	0x1800021fb <.text+0x11fb>
180001d68:     	movq	0x210(%rsp), %rdi
180001d70:     	movq	0x230(%rsp), %r14
180001d78:     	movq	0x238(%rsp), %r12
180001d80:     	movq	0x240(%rsp), %rbx
180001d88:     	movq	0x140(%rsp), %rcx
180001d90:     	xorps	%xmm0, %xmm0
180001d93:     	movaps	%xmm0, 0x1d0(%rsp)
180001d9b:     	movaps	%xmm0, 0x1e0(%rsp)
180001da3:     	movaps	%xmm0, 0x1f0(%rsp)
180001dab:     	movq	$0x0, 0x200(%rsp)
180001db7:     	leaq	0x1d0(%rsp), %rdx
180001dbf:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
180001dc4:     	testl	%eax, %eax
180001dc6:     	jne	0x180002213 <.text+0x1213>
180001dcc:     	cmpq	$0x8, 0x1e8(%rsp)
180001dd5:     	jne	0x180002213 <.text+0x1213>
180001ddb:     	movq	0x1d0(%rsp), %r15
180001de3:     	movq	0x1f0(%rsp), %rbp
180001deb:     	movq	0x1f8(%rsp), %rsi
180001df3:     	movq	0x200(%rsp), %r13
180001dfb:     	movq	0x138(%rsp), %rcx
180001e03:     	xorps	%xmm0, %xmm0
180001e06:     	movaps	%xmm0, 0x190(%rsp)
180001e0e:     	movaps	%xmm0, 0x1a0(%rsp)
180001e16:     	movaps	%xmm0, 0x1b0(%rsp)
180001e1e:     	movq	$0x0, 0x1c0(%rsp)
180001e2a:     	leaq	0x190(%rsp), %rdx
180001e32:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
180001e37:     	testl	%eax, %eax
180001e39:     	jne	0x180002228 <.text+0x1228>
180001e3f:     	cmpq	$0x8, 0x1a8(%rsp)
180001e48:     	jne	0x180002228 <.text+0x1228>
180001e4e:     	movq	%r13, 0x100(%rsp)
180001e56:     	movq	0x190(%rsp), %r13
180001e5e:     	movq	0x1b0(%rsp), %rax
180001e66:     	movq	%rax, 0xf8(%rsp)
180001e6e:     	movq	0x1b8(%rsp), %rax
180001e76:     	movq	%rax, 0xf0(%rsp)
180001e7e:     	movq	0x1c0(%rsp), %rax
180001e86:     	movq	%rax, 0xe8(%rsp)
180001e8e:     	movq	0x130(%rsp), %rcx
180001e96:     	xorps	%xmm0, %xmm0
180001e99:     	movaps	%xmm0, 0x150(%rsp)
180001ea1:     	movaps	%xmm0, 0x160(%rsp)
180001ea9:     	movaps	%xmm0, 0x170(%rsp)
180001eb1:     	movq	$0x0, 0x180(%rsp)
180001ebd:     	leaq	0x150(%rsp), %rdx
180001ec5:     	callq	0x180007840 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x52d0>
180001eca:     	testl	%eax, %eax
180001ecc:     	jne	0x18000223d <.text+0x123d>
180001ed2:     	cmpq	$0x1, 0x168(%rsp)
180001edb:     	jne	0x18000223d <.text+0x123d>
180001ee1:     	movq	%rsi, 0xd8(%rsp)
180001ee9:     	movq	0x150(%rsp), %rax
180001ef1:     	movq	%rax, 0xa8(%rsp)
180001ef9:     	movq	0x170(%rsp), %rax
180001f01:     	movq	%rax, 0xd0(%rsp)
180001f09:     	movq	0x178(%rsp), %rax
180001f11:     	movq	%rax, 0xc8(%rsp)
180001f19:     	movq	0x180(%rsp), %rax
180001f21:     	movq	%rax, 0xc0(%rsp)
180001f29:     	movq	0x128(%rsp), %rcx
180001f31:     	callq	0x180008b87 <numba_list_iter_next+0x317>
180001f36:     	testq	%rax, %rax
180001f39:     	movq	%r13, 0xb0(%rsp)
180001f41:     	movq	%rbp, 0xe0(%rsp)
180001f49:     	je	0x180002252 <.text+0x1252>
180001f4f:     	movq	%rax, %rsi
180001f52:     	movq	%rax, %rcx
180001f55:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
180001f5a:     	movq	%rax, 0xa0(%rsp)
180001f62:     	movq	%rsi, %rcx
180001f65:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180001f6a:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001f6f:     	testq	%rax, %rax
180001f72:     	jne	0x18000227e <.text+0x127e>
180001f78:     	movq	0x120(%rsp), %rcx
180001f80:     	callq	0x180008b9f <numba_list_iter_next+0x32f>
180001f85:     	movq	%rax, %rsi
180001f88:     	movq	%rax, %rcx
180001f8b:     	callq	0x180008ba5 <numba_list_iter_next+0x335>
180001f90:     	movaps	%xmm0, %xmm6
180001f93:     	movq	%rsi, %rcx
180001f96:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180001f9b:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001fa0:     	testq	%rax, %rax
180001fa3:     	jne	0x18000227e <.text+0x127e>
180001fa9:     	movq	0x118(%rsp), %rcx
180001fb1:     	callq	0x180008b9f <numba_list_iter_next+0x32f>
180001fb6:     	movq	%rax, %rsi
180001fb9:     	movq	%rax, %rcx
180001fbc:     	callq	0x180008ba5 <numba_list_iter_next+0x335>
180001fc1:     	movaps	%xmm0, %xmm7
180001fc4:     	movq	%rsi, %rcx
180001fc7:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180001fcc:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180001fd1:     	testq	%rax, %rax
180001fd4:     	jne	0x18000227e <.text+0x127e>
180001fda:     	movq	0x110(%rsp), %rcx
180001fe2:     	callq	0x180008b87 <numba_list_iter_next+0x317>
180001fe7:     	testq	%rax, %rax
180001fea:     	je	0x18000226e <.text+0x126e>
180001ff0:     	movq	%rax, %rsi
180001ff3:     	movq	%rax, %rcx
180001ff6:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
180001ffb:     	movq	%rax, %rbp
180001ffe:     	movq	%rsi, %rcx
180002001:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180002006:     	callq	0x180008b99 <numba_list_iter_next+0x329>
18000200b:     	testq	%rax, %rax
18000200e:     	jne	0x18000227e <.text+0x127e>
180002014:     	movq	%rbx, %r13
180002017:     	movq	%r12, %rbx
18000201a:     	movq	%r14, %r12
18000201d:     	movq	%r15, %r14
180002020:     	movq	%rdi, %r15
180002023:     	movq	0x108(%rsp), %rcx
18000202b:     	callq	0x180008b87 <numba_list_iter_next+0x317>
180002030:     	testq	%rax, %rax
180002033:     	je	0x1800022b2 <.text+0x12b2>
180002039:     	movq	%rax, %rdi
18000203c:     	movq	%rax, %rcx
18000203f:     	callq	0x180008b8d <numba_list_iter_next+0x31d>
180002044:     	movq	%rax, %rsi
180002047:     	movq	%rdi, %rcx
18000204a:     	callq	0x180008b93 <numba_list_iter_next+0x323>
18000204f:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180002054:     	testq	%rax, %rax
180002057:     	movq	%r15, %rdi
18000205a:     	movq	%r14, %r15
18000205d:     	jne	0x18000227e <.text+0x127e>
180002063:     	movq	%rsi, 0x90(%rsp)
18000206b:     	movq	%rbp, 0x88(%rsp)
180002073:     	movsd	%xmm7, 0x80(%rsp)
18000207c:     	movsd	%xmm6, 0x78(%rsp)
180002082:     	movq	0xa0(%rsp), %rax
18000208a:     	movq	%rax, 0x70(%rsp)
18000208f:     	movq	0xc0(%rsp), %rax
180002097:     	movq	%rax, 0x68(%rsp)
18000209c:     	movq	0xc8(%rsp), %rax
1800020a4:     	movq	%rax, 0x60(%rsp)
1800020a9:     	movq	0xd0(%rsp), %rax
1800020b1:     	movq	%rax, 0x58(%rsp)
1800020b6:     	movq	0xe8(%rsp), %rax
1800020be:     	movq	%rax, 0x50(%rsp)
1800020c3:     	movq	0xf0(%rsp), %rax
1800020cb:     	movq	%rax, 0x48(%rsp)
1800020d0:     	movq	0xf8(%rsp), %rax
1800020d8:     	movq	%rax, 0x40(%rsp)
1800020dd:     	movq	0x100(%rsp), %rax
1800020e5:     	movq	%rax, 0x38(%rsp)
1800020ea:     	movq	0xd8(%rsp), %rax
1800020f2:     	movq	%rax, 0x30(%rsp)
1800020f7:     	movq	0xe0(%rsp), %rax
1800020ff:     	movq	%rax, 0x28(%rsp)
180002104:     	movq	%r13, 0x20(%rsp)
180002109:     	leaq	0x248(%rsp), %rcx
180002111:     	leaq	0xb8(%rsp), %rdx
180002119:     	movq	%r12, %r8
18000211c:     	movq	%rbx, %r9
18000211f:     	callq	0x180001b00 <.text+0xb00>
180002124:     	movl	%eax, %ebp
180002126:     	movq	0xb8(%rsp), %rbx
18000212e:     	movq	%rdi, %rcx
180002131:     	callq	0x180001060 <.text+0x60>
180002136:     	movq	%r15, %rcx
180002139:     	callq	0x180001060 <.text+0x60>
18000213e:     	movq	0xb0(%rsp), %rcx
180002146:     	callq	0x180001060 <.text+0x60>
18000214b:     	movq	0xa8(%rsp), %rcx
180002153:     	callq	0x180001060 <.text+0x60>
180002158:     	testl	%ebp, %ebp
18000215a:     	jne	0x180002192 <.text+0x1192>
18000215c:     	movq	0x816d(%rip), %rsi      # 0x18000a2d0
180002163:     	movq	%rsi, %rcx
180002166:     	callq	0x180008bab <numba_list_iter_next+0x33b>
18000216b:     	movq	%rsi, %rax
18000216e:     	movaps	0x250(%rsp), %xmm6
180002176:     	movaps	0x260(%rsp), %xmm7
18000217e:     	addq	$0x278, %rsp            # imm = 0x278
180002185:     	popq	%rbx
180002186:     	popq	%rbp
180002187:     	popq	%rdi
180002188:     	popq	%rsi
180002189:     	popq	%r12
18000218b:     	popq	%r13
18000218d:     	popq	%r14
18000218f:     	popq	%r15
180002191:     	retq
180002192:     	jle	0x1800022b9 <.text+0x12b9>
180002198:     	callq	0x180008bb1 <numba_list_iter_next+0x341>
18000219d:     	movl	0x8(%rbx), %edx
1800021a0:     	movq	(%rbx), %rcx
1800021a3:     	cmpl	$0x0, 0x20(%rbx)
1800021a7:     	jle	0x1800022d8 <.text+0x12d8>
1800021ad:     	movslq	%edx, %rdx
1800021b0:     	callq	0x180008bb7 <numba_list_iter_next+0x347>
1800021b5:     	movq	%rax, %rsi
1800021b8:     	movq	0x10(%rbx), %rcx
1800021bc:     	callq	*0x18(%rbx)
1800021bf:     	testq	%rax, %rax
1800021c2:     	je	0x180002301 <.text+0x1301>
1800021c8:     	movq	%rsi, %rcx
1800021cb:     	movq	%rax, %rdx
1800021ce:     	callq	0x180007050 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ae0>
1800021d3:     	movq	%rax, %rsi
1800021d6:     	movq	%rbx, %rcx
1800021d9:     	callq	0x180008ae0 <numba_list_iter_next+0x270>
1800021de:     	jmp	0x1800022e4 <.text+0x12e4>
1800021e3:     	movq	0x80c6(%rip), %rcx      # 0x18000a2b0
1800021ea:     	leaq	0x86ff(%rip), %rdx      # 0x18000a8f0
1800021f1:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800021f6:     	jmp	0x1800022ab <.text+0x12ab>
1800021fb:     	movq	0x809e(%rip), %rcx      # 0x18000a2a0
180002202:     	leaq	0x87e7(%rip), %rdx      # 0x18000a9f0
180002209:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
18000220e:     	jmp	0x1800022ab <.text+0x12ab>
180002213:     	movq	0x8086(%rip), %rcx      # 0x18000a2a0
18000221a:     	leaq	0x87cf(%rip), %rdx      # 0x18000a9f0
180002221:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180002226:     	jmp	0x1800022a3 <.text+0x12a3>
180002228:     	movq	0x8071(%rip), %rcx      # 0x18000a2a0
18000222f:     	leaq	0x87ba(%rip), %rdx      # 0x18000a9f0
180002236:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
18000223b:     	jmp	0x18000229b <.text+0x129b>
18000223d:     	movq	0x805c(%rip), %rcx      # 0x18000a2a0
180002244:     	leaq	0x87a5(%rip), %rdx      # 0x18000a9f0
18000224b:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180002250:     	jmp	0x180002293 <.text+0x1293>
180002252:     	movq	$0x0, 0xa0(%rsp)
18000225e:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180002263:     	testq	%rax, %rax
180002266:     	je	0x180001f78 <.text+0xf78>
18000226c:     	jmp	0x18000227e <.text+0x127e>
18000226e:     	xorl	%ebp, %ebp
180002270:     	callq	0x180008b99 <numba_list_iter_next+0x329>
180002275:     	testq	%rax, %rax
180002278:     	je	0x180002014 <.text+0x1014>
18000227e:     	movq	0xa8(%rsp), %rcx
180002286:     	callq	0x180001060 <.text+0x60>
18000228b:     	movq	0xb0(%rsp), %r13
180002293:     	movq	%r13, %rcx
180002296:     	callq	0x180001060 <.text+0x60>
18000229b:     	movq	%r15, %rcx
18000229e:     	callq	0x180001060 <.text+0x60>
1800022a3:     	movq	%rdi, %rcx
1800022a6:     	callq	0x180001060 <.text+0x60>
1800022ab:     	xorl	%esi, %esi
1800022ad:     	jmp	0x18000216b <.text+0x116b>
1800022b2:     	xorl	%esi, %esi
1800022b4:     	jmp	0x18000204f <.text+0x104f>
1800022b9:     	cmpl	$-0x3, %ebp
1800022bc:     	je	0x1800022f3 <.text+0x12f3>
1800022be:     	cmpl	$-0x1, %ebp
1800022c1:     	je	0x1800022ab <.text+0x12ab>
1800022c3:     	movq	0x7fce(%rip), %rcx      # 0x18000a298
1800022ca:     	leaq	0x87bf(%rip), %rdx      # 0x18000aa90
1800022d1:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800022d6:     	jmp	0x1800022ab <.text+0x12ab>
1800022d8:     	movq	0x10(%rbx), %r8
1800022dc:     	callq	0x180006f70 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a00>
1800022e1:     	movq	%rax, %rsi
1800022e4:     	testq	%rsi, %rsi
1800022e7:     	je	0x1800022ab <.text+0x12ab>
1800022e9:     	movq	%rsi, %rcx
1800022ec:     	callq	0x180006b10 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x45a0>
1800022f1:     	jmp	0x1800022ab <.text+0x12ab>
1800022f3:     	movq	0x7f96(%rip), %rcx      # 0x18000a290
1800022fa:     	callq	0x180008bc3 <numba_list_iter_next+0x353>
1800022ff:     	jmp	0x1800022ab <.text+0x12ab>
180002301:     	movq	0x7fa8(%rip), %rcx      # 0x18000a2b0
180002308:     	leaq	0x8741(%rip), %rdx      # 0x18000aa50
18000230f:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
180002314:     	jmp	0x1800022ab <.text+0x12ab>
180002316:     	nopw	%cs:(%rax,%rax)
180002320:     	pushq	%r15
180002322:     	pushq	%r14
180002324:     	pushq	%r13
180002326:     	pushq	%r12
180002328:     	pushq	%rsi
180002329:     	pushq	%rdi
18000232a:     	pushq	%rbp
18000232b:     	pushq	%rbx
18000232c:     	subq	$0xb8, %rsp
180002333:     	movq	0x120(%rsp), %r8
18000233b:     	movq	0x128(%rsp), %r9
180002343:     	movq	0x130(%rsp), %rax
18000234b:     	movq	0x158(%rsp), %rcx
180002353:     	movq	0x160(%rsp), %rdx
18000235b:     	movq	0x168(%rsp), %r10
180002363:     	movq	0x190(%rsp), %r11
18000236b:     	movq	0x198(%rsp), %rsi
180002373:     	movq	0x1a0(%rsp), %rdi
18000237b:     	movq	0x1c8(%rsp), %rbx
180002383:     	movq	0x1d0(%rsp), %r14
18000238b:     	movq	0x1d8(%rsp), %r15
180002393:     	movq	0x1e0(%rsp), %r12
18000239b:     	movsd	0x1e8(%rsp), %xmm0
1800023a4:     	movsd	0x1f0(%rsp), %xmm1
1800023ad:     	movq	0x1f8(%rsp), %r13
1800023b5:     	movq	0x200(%rsp), %rbp
1800023bd:     	movq	$0x0, 0xb0(%rsp)
1800023c9:     	movq	$0x0, 0xa8(%rsp)
1800023d5:     	movq	%rbp, 0x90(%rsp)
1800023dd:     	movq	%r13, 0x88(%rsp)
1800023e5:     	movsd	%xmm1, 0x80(%rsp)
1800023ee:     	movsd	%xmm0, 0x78(%rsp)
1800023f4:     	movq	%r12, 0x70(%rsp)
1800023f9:     	movq	%r15, 0x68(%rsp)
1800023fe:     	movq	%r14, 0x60(%rsp)
180002403:     	movq	%rbx, 0x58(%rsp)
180002408:     	movq	%rdi, 0x50(%rsp)
18000240d:     	movq	%rsi, 0x48(%rsp)
180002412:     	movq	%r11, 0x40(%rsp)
180002417:     	movq	%r10, 0x38(%rsp)
18000241c:     	movq	%rdx, 0x30(%rsp)
180002421:     	movq	%rcx, 0x28(%rsp)
180002426:     	movq	%rax, 0x20(%rsp)
18000242b:     	leaq	0xb0(%rsp), %rcx
180002433:     	leaq	0xa8(%rsp), %rdx
18000243b:     	callq	0x180001b00 <.text+0xb00>
180002440:     	movl	%eax, %edx
180002442:     	movq	0xa8(%rsp), %rsi
18000244a:     	movq	0xb0(%rsp), %rax
180002452:     	movl	$0x0, 0xa4(%rsp)
18000245d:     	testl	%edx, %edx
18000245f:     	jne	0x180002475 <.text+0x1475>
180002461:     	addq	$0xb8, %rsp
180002468:     	popq	%rbx
180002469:     	popq	%rbp
18000246a:     	popq	%rdi
18000246b:     	popq	%rsi
18000246c:     	popq	%r12
18000246e:     	popq	%r13
180002470:     	popq	%r14
180002472:     	popq	%r15
180002474:     	retq
180002475:     	movq	%rax, %rbx
180002478:     	leaq	0xa4(%rsp), %rcx
180002480:     	movl	%edx, %edi
180002482:     	callq	0x180006ae0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4570>
180002487:     	testl	%edi, %edi
180002489:     	jle	0x1800024cf <.text+0x14cf>
18000248b:     	callq	0x180008bb1 <numba_list_iter_next+0x341>
180002490:     	movl	0x8(%rsi), %edx
180002493:     	movq	(%rsi), %rcx
180002496:     	cmpl	$0x0, 0x20(%rsi)
18000249a:     	jle	0x1800024f0 <.text+0x14f0>
18000249c:     	movslq	%edx, %rdx
18000249f:     	callq	0x180008bb7 <numba_list_iter_next+0x347>
1800024a4:     	movq	%rax, %rdi
1800024a7:     	movq	0x10(%rsi), %rcx
1800024ab:     	callq	*0x18(%rsi)
1800024ae:     	testq	%rax, %rax
1800024b1:     	je	0x18000254b <.text+0x154b>
1800024b7:     	movq	%rdi, %rcx
1800024ba:     	movq	%rax, %rdx
1800024bd:     	callq	0x180007050 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ae0>
1800024c2:     	movq	%rax, %rdi
1800024c5:     	movq	%rsi, %rcx
1800024c8:     	callq	0x180008ae0 <numba_list_iter_next+0x270>
1800024cd:     	jmp	0x1800024fc <.text+0x14fc>
1800024cf:     	movl	%edi, %eax
1800024d1:     	cmpl	$-0x3, %edi
1800024d4:     	je	0x18000253d <.text+0x153d>
1800024d6:     	cmpl	$-0x1, %eax
1800024d9:     	je	0x180002509 <.text+0x1509>
1800024db:     	movq	0x7db6(%rip), %rcx      # 0x18000a298
1800024e2:     	leaq	0x8617(%rip), %rdx      # 0x18000ab00
1800024e9:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
1800024ee:     	jmp	0x180002509 <.text+0x1509>
1800024f0:     	movq	0x10(%rsi), %r8
1800024f4:     	callq	0x180006f70 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a00>
1800024f9:     	movq	%rax, %rdi
1800024fc:     	testq	%rdi, %rdi
1800024ff:     	je	0x180002509 <.text+0x1509>
180002501:     	movq	%rdi, %rcx
180002504:     	callq	0x180006b10 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x45a0>
180002509:     	leaq	0x8620(%rip), %rcx      # 0x18000ab30
180002510:     	callq	0x180008bc9 <numba_list_iter_next+0x359>
180002515:     	movq	%rax, %rsi
180002518:     	movq	%rax, %rcx
18000251b:     	callq	0x180008bcf <numba_list_iter_next+0x35f>
180002520:     	movq	%rsi, %rcx
180002523:     	callq	0x180008b93 <numba_list_iter_next+0x323>
180002528:     	leaq	0xa4(%rsp), %rcx
180002530:     	callq	0x180006b00 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4590>
180002535:     	movq	%rbx, %rax
180002538:     	jmp	0x180002461 <.text+0x1461>
18000253d:     	movq	0x7d4c(%rip), %rcx      # 0x18000a290
180002544:     	callq	0x180008bc3 <numba_list_iter_next+0x353>
180002549:     	jmp	0x180002509 <.text+0x1509>
18000254b:     	movq	0x7d5e(%rip), %rcx      # 0x18000a2b0
180002552:     	leaq	0x8567(%rip), %rdx      # 0x18000aac0
180002559:     	callq	0x180008bbd <numba_list_iter_next+0x34d>
18000255e:     	xorl	%eax, %eax
180002560:     	jmp	0x180002461 <.text+0x1461>
180002565:     	nopw	%cs:(%rax,%rax)
18000256f:     	nop

0000000180002570 <PyInit_rcaotr_962a53ce990e9bd4541a3246>:
180002570:     	pushq	%rsi
180002571:     	subq	$0x20, %rsp
180002575:     	leaq	0xeae4(%rip), %rcx      # 0x180011060
18000257c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180002581:     	callq	0x180008bd5 <numba_list_iter_next+0x365>
180002586:     	testq	%rax, %rax
180002589:     	je	0x1800025bb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b>
18000258b:     	leaq	0xea6e(%rip), %rdx      # 0x180011000
180002592:     	leaq	0x8607(%rip), %r8       # 0x18000aba0
180002599:     	leaq	0x87c0(%rip), %r9       # 0x18000ad60
1800025a0:     	movq	%rax, %rcx
1800025a3:     	movq	%rax, %rsi
1800025a6:     	callq	0x180007ab0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5540>
1800025ab:     	movl	%eax, %ecx
1800025ad:     	xorl	%eax, %eax
1800025af:     	testl	%ecx, %ecx
1800025b1:     	cmoveq	%rsi, %rax
1800025b5:     	addq	$0x20, %rsp
1800025b9:     	popq	%rsi
1800025ba:     	retq
1800025bb:     	xorl	%eax, %eax
1800025bd:     	addq	$0x20, %rsp
1800025c1:     	popq	%rsi
1800025c2:     	retq
1800025c3:     	nopw	%cs:(%rax,%rax)
1800025cd:     	nopl	(%rax)
1800025d0:     	pushq	%r15
1800025d2:     	pushq	%r14
1800025d4:     	pushq	%r13
1800025d6:     	pushq	%r12
1800025d8:     	pushq	%rsi
1800025d9:     	pushq	%rdi
1800025da:     	pushq	%rbp
1800025db:     	pushq	%rbx
1800025dc:     	subq	$0xf8, %rsp
1800025e3:     	movapd	%xmm8, 0xe0(%rsp)
1800025ed:     	movaps	%xmm7, 0xd0(%rsp)
1800025f5:     	movapd	%xmm6, 0xc0(%rsp)
1800025fe:     	movq	0x190(%rsp), %r11
180002606:     	movq	0x168(%rsp), %r15
18000260e:     	movq	0x160(%rsp), %r13
180002616:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180002620:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
18000262a:     	movq	$0x0, 0x90(%rsp)
180002636:     	movq	$0x0, 0xa0(%rsp)
180002642:     	leaq	(%r11,%rax), %rsi
180002646:     	cmpq	%r10, %rsi
180002649:     	jb	0x18000265b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xeb>
18000264b:     	movq	0x198(%rsp), %rsi
180002653:     	addq	%rsi, %rax
180002656:     	cmpq	%r10, %rax
180002659:     	jae	0x18000269d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x12d>
18000265b:     	movb	$0x1, (%r15)
18000265f:     	movq	$0x4, 0x18(%r13)
180002667:     	xorl	%eax, %eax
180002669:     	movq	$0x0, (%rcx)
180002670:     	movaps	0xc0(%rsp), %xmm6
180002678:     	movaps	0xd0(%rsp), %xmm7
180002680:     	movaps	0xe0(%rsp), %xmm8
180002689:     	addq	$0xf8, %rsp
180002690:     	popq	%rbx
180002691:     	popq	%rbp
180002692:     	popq	%rdi
180002693:     	popq	%rsi
180002694:     	popq	%r12
180002696:     	popq	%r13
180002698:     	popq	%r14
18000269a:     	popq	%r15
18000269c:     	retq
18000269d:     	movq	0x170(%rsp), %r12
1800026a5:     	movq	(%r13), %r10
1800026a9:     	leaq	0x4(%r10), %rax
1800026ad:     	cmpq	%r12, %rax
1800026b0:     	jle	0x1800026b8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x148>
1800026b2:     	movb	$0x2, (%r15)
1800026b6:     	jmp	0x180002667 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf7>
1800026b8:     	movq	%rax, (%r13)
1800026bc:     	xorl	%eax, %eax
1800026be:     	cmpb	$0x0, (%r15)
1800026c2:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
1800026c4:     	cvtsi2sd	%r11, %xmm0
1800026c9:     	movsd	0x7cdf(%rip), %xmm1     # 0x18000a3b0
1800026d1:     	mulsd	%xmm1, %xmm0
1800026d5:     	cvtsi2sd	%rsi, %xmm2
1800026da:     	mulsd	%xmm1, %xmm2
1800026de:     	movsd	%xmm0, 0x10(%r8,%r10,8)
1800026e5:     	movsd	%xmm2, 0x18(%r8,%r10,8)
1800026ec:     	movsd	%xmm0, 0x8(%r8,%r10,8)
1800026f3:     	movsd	%xmm2, (%r8,%r10,8)
1800026f9:     	cmpb	$0x0, (%r15)
1800026fd:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002703:     	movq	(%r13), %rbx
180002707:     	leaq	0xb(%rbx), %r11
18000270b:     	cmpq	%r12, %r11
18000270e:     	jle	0x180002719 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1a9>
180002710:     	movb	$0x2, (%r15)
180002714:     	jmp	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002719:     	movq	%r11, (%r13)
18000271d:     	cmpb	$0x0, (%r15)
180002721:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002727:     	movq	%r10, (%r9,%rbx,8)
18000272b:     	movq	$0x4, 0x8(%r9,%rbx,8)
180002734:     	movq	(%r13), %r10
180002738:     	cmpq	%r12, %r10
18000273b:     	movq	%r10, %r11
18000273e:     	jle	0x18000274b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1db>
180002740:     	movb	$0x2, (%r15)
180002744:     	movq	(%r13), %r10
180002748:     	xorl	%r11d, %r11d
18000274b:     	leaq	0x3(%r10), %rsi
18000274f:     	cmpq	%r12, %rsi
180002752:     	jg	0x180002710 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1a0>
180002754:     	movq	%rsi, (%r13)
180002758:     	cmpb	$0x0, (%r15)
18000275c:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002762:     	movq	%r10, %rax
180002765:     	sarq	$0x3f, %rax
180002769:     	andq	%r12, %rax
18000276c:     	leaq	(%r9,%r10,8), %rsi
180002770:     	movq	$0x0, (%rsi,%rax,8)
180002778:     	xorl	%eax, %eax
18000277a:     	cmpq	$-0x1, %r10
18000277e:     	movl	$0x0, %edi
180002783:     	cmovlq	%r12, %rdi
180002787:     	movq	$0x0, 0x8(%rsi,%rdi,8)
180002790:     	cmpq	$-0x2, %r10
180002794:     	movl	$0x0, %edi
180002799:     	cmovlq	%r12, %rdi
18000279d:     	movq	%r11, 0x10(%rsi,%rdi,8)
1800027a2:     	cmpb	$0x0, (%r15)
1800027a6:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
1800027ac:     	leaq	(%r9,%rbx,8), %r11
1800027b0:     	movq	%r10, 0x30(%r11)
1800027b4:     	movq	$0x0, 0x18(%r11)
1800027bc:     	movq	(%r13), %r10
1800027c0:     	leaq	0x4(%r10), %rsi
1800027c4:     	cmpq	%r12, %rsi
1800027c7:     	jg	0x180002710 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1a0>
1800027cd:     	movq	%rdx, 0x88(%rsp)
1800027d5:     	movq	%rsi, (%r13)
1800027d9:     	cmpb	$0x0, (%r15)
1800027dd:     	jne	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
1800027e3:     	movq	%rcx, 0x60(%rsp)
1800027e8:     	movq	$0x0, (%r8,%r10,8)
1800027f0:     	movq	$0x1, 0x8(%r9,%r10,8)
1800027f9:     	movq	%r8, 0x68(%rsp)
1800027fe:     	movq	$0x0, 0x10(%r8,%r10,8)
180002807:     	movq	$0x1, 0x18(%r9,%r10,8)
180002810:     	cmpb	$0x0, (%r15)
180002814:     	jne	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
18000281a:     	movq	%r9, %rdi
18000281d:     	movq	%r10, 0x10(%r11)
180002821:     	movq	0x68(%rsp), %rcx
180002826:     	movq	$0x0, 0x48(%rcx,%rbx,8)
18000282f:     	movq	$0x1, 0x50(%r11)
180002837:     	movq	$-0x1, 0x20(%r11)
18000283f:     	movq	$-0x1, 0x28(%r11)
180002847:     	movq	$-0x1, 0x38(%r11)
18000284f:     	movq	$-0x1, 0x40(%r11)
180002857:     	cmpb	$0x0, (%r15)
18000285b:     	jne	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
180002861:     	movq	0x178(%rsp), %rcx
180002869:     	movq	%rcx, %rax
18000286c:     	sarq	$0x3f, %rax
180002870:     	andq	%r12, %rax
180002873:     	leaq	(%rdi,%rcx,8), %rbp
180002877:     	movq	%rax, 0x78(%rsp)
18000287c:     	cmpq	$0x0, (%rbp,%rax,8)
180002882:     	jle	0x18000294a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3da>
180002888:     	leaq	(,%r12,8), %rsi
180002890:     	xorl	%r14d, %r14d
180002893:     	cmpq	$-0x2, 0x178(%rsp)
18000289c:     	movq	0x8(%r13), %rax
1800028a0:     	cmovgeq	%r14, %rsi
1800028a4:     	shlq	$0x3, 0x78(%rsp)
1800028aa:     	movq	0x10(%rbp,%rsi), %rcx
1800028af:     	addq	%r14, %rcx
1800028b2:     	leaq	(%rdi,%rcx,8), %rdx
1800028b6:     	sarq	$0x3f, %rcx
1800028ba:     	andq	%r12, %rcx
1800028bd:     	movq	(%rdx,%rcx,8), %rcx
1800028c1:     	leaq	0x1(%rax), %rdx
1800028c5:     	movq	%rdx, 0x8(%r13)
1800028c9:     	cmpq	0x10(%r13), %rax
1800028cd:     	jge	0x180002ade <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56e>
1800028d3:     	movq	%rcx, 0x48(%rsp)
1800028d8:     	movq	%rbx, 0x40(%rsp)
1800028dd:     	movq	%r12, 0x30(%rsp)
1800028e2:     	movq	%r15, 0x28(%rsp)
1800028e7:     	movq	%r13, 0x20(%rsp)
1800028ec:     	movq	$-0x1, 0x50(%rsp)
1800028f5:     	movq	$0x0, 0x38(%rsp)
1800028fe:     	leaq	0x77(%rsp), %rcx
180002903:     	leaq	0xb0(%rsp), %rdx
18000290b:     	movq	0x68(%rsp), %r8
180002910:     	movq	%rdi, %r9
180002913:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180002918:     	testl	%eax, %eax
18000291a:     	jne	0x180002ad1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x561>
180002920:     	cmpb	$0x0, (%r15)
180002924:     	jne	0x180002c15 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a5>
18000292a:     	incq	%r14
18000292d:     	movq	0x8(%r13), %rax
180002931:     	decq	%rax
180002934:     	movq	%rax, 0x8(%r13)
180002938:     	movq	0x78(%rsp), %rcx
18000293d:     	cmpq	(%rbp,%rcx), %r14
180002942:     	jl	0x1800028aa <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x33a>
180002948:     	jmp	0x180002950 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3e0>
18000294a:     	shlq	$0x3, 0x78(%rsp)
180002950:     	movsd	0x188(%rsp), %xmm6
180002959:     	movsd	0x180(%rsp), %xmm7
180002962:     	leaq	(,%r12,8), %rax
18000296a:     	xorl	%r14d, %r14d
18000296d:     	cmpq	$-0x2, 0x178(%rsp)
180002976:     	cmovgeq	%r14, %rax
18000297a:     	movq	%rax, 0x80(%rsp)
180002982:     	xorpd	%xmm8, %xmm8
180002987:     	jmp	0x1800029a2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x432>
180002989:     	movb	$0x1, (%r15)
18000298d:     	movq	$0x4c4b43, 0x18(%r13)   # imm = 0x4C4B43
180002995:     	incq	%r14
180002998:     	cmpb	$0x0, (%r15)
18000299c:     	jne	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
1800029a2:     	movq	0x78(%rsp), %rax
1800029a7:     	cmpq	(%rbp,%rax), %r14
1800029ac:     	jge	0x180002aef <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x57f>
1800029b2:     	movq	0x80(%rsp), %rax
1800029ba:     	movq	0x10(%rbp,%rax), %rax
1800029bf:     	addq	%r14, %rax
1800029c2:     	leaq	(%rdi,%rax,8), %rcx
1800029c6:     	sarq	$0x3f, %rax
1800029ca:     	andq	%r12, %rax
1800029cd:     	movq	(%rcx,%rax,8), %rsi
1800029d1:     	movq	0x8(%r13), %rax
1800029d5:     	leaq	0x1(%rax), %rcx
1800029d9:     	movq	%rcx, 0x8(%r13)
1800029dd:     	cmpq	0x10(%r13), %rax
1800029e1:     	jge	0x180002c09 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x699>
1800029e7:     	movsd	%xmm7, 0x48(%rsp)
1800029ed:     	movq	%rsi, 0x40(%rsp)
1800029f2:     	movq	%rbx, 0x38(%rsp)
1800029f7:     	movq	%r12, 0x30(%rsp)
1800029fc:     	movq	%r15, 0x28(%rsp)
180002a01:     	movq	%r13, 0x20(%rsp)
180002a06:     	leaq	0x90(%rsp), %rcx
180002a0e:     	leaq	0xb8(%rsp), %rdx
180002a16:     	movq	0x68(%rsp), %r8
180002a1b:     	movq	%rdi, %r9
180002a1e:     	callq	0x180002c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6c0>
180002a23:     	testl	%eax, %eax
180002a25:     	jne	0x180002ad1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x561>
180002a2b:     	xorl	%eax, %eax
180002a2d:     	cmpb	$0x0, (%r15)
180002a31:     	jne	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
180002a37:     	movsd	0x90(%rsp), %xmm1
180002a40:     	movsd	0xa0(%rsp), %xmm0
180002a49:     	decq	0x8(%r13)
180002a4d:     	movq	0x68(%rsp), %rcx
180002a52:     	movsd	0x8(%rcx,%rsi,8), %xmm2
180002a58:     	ucomisd	%xmm8, %xmm2
180002a5d:     	jne	0x180002a65 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f5>
180002a5f:     	jnp	0x180002989 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x419>
180002a65:     	movq	(%rdi,%rsi,8), %rdx
180002a69:     	divsd	%xmm2, %xmm1
180002a6d:     	movq	0x68(%rsp), %r8
180002a72:     	addsd	(%r8,%rdx,8), %xmm1
180002a78:     	movsd	%xmm1, (%r8,%rdx,8)
180002a7e:     	movq	$0x0, 0x8(%rdi,%rdx,8)
180002a87:     	movsd	0x8(%r8,%rsi,8), %xmm1
180002a8e:     	ucomisd	%xmm8, %xmm1
180002a93:     	jne	0x180002aa8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x538>
180002a95:     	jp	0x180002aa8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x538>
180002a97:     	movb	$0x1, (%r15)
180002a9b:     	movq	$0x4c4b44, 0x18(%r13)   # imm = 0x4C4B44
180002aa3:     	jmp	0x180002995 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x425>
180002aa8:     	movq	(%rdi,%rsi,8), %rdx
180002aac:     	divsd	%xmm1, %xmm0
180002ab0:     	movq	0x68(%rsp), %r8
180002ab5:     	addsd	0x10(%r8,%rdx,8), %xmm0
180002abc:     	movsd	%xmm0, 0x10(%r8,%rdx,8)
180002ac3:     	movq	$0x0, 0x18(%rdi,%rdx,8)
180002acc:     	jmp	0x180002995 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x425>
180002ad1:     	movq	0x88(%rsp), %rcx
180002ad9:     	jmp	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002ade:     	movb	$0x1, (%r15)
180002ae2:     	movq	$0x9, 0x18(%r13)
180002aea:     	jmp	0x180002c15 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a5>
180002aef:     	xorl	%eax, %eax
180002af1:     	xorl	%ecx, %ecx
180002af3:     	movq	0x78(%rsp), %rdx
180002af8:     	cmpq	(%rbp,%rdx), %rcx
180002afd:     	jge	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
180002b03:     	movq	0x80(%rsp), %rdx
180002b0b:     	movq	0x10(%rbp,%rdx), %r8
180002b10:     	addq	%rcx, %r8
180002b13:     	leaq	(%rdi,%r8,8), %r9
180002b17:     	sarq	$0x3f, %r8
180002b1b:     	andq	%r12, %r8
180002b1e:     	movq	(%r9,%r8,8), %r8
180002b22:     	incq	%rcx
180002b25:     	movq	(%rdi,%r8,8), %r10
180002b29:     	movq	0x18(%rdi,%r8,8), %r11
180002b2e:     	movq	0x68(%rsp), %r9
180002b33:     	movsd	(%r9,%r10,8), %xmm0
180002b39:     	mulsd	%xmm6, %xmm0
180002b3d:     	addsd	(%r9,%r11,8), %xmm0
180002b43:     	movsd	%xmm0, (%r9,%r11,8)
180002b49:     	movq	$0x0, 0x8(%rdi,%r11,8)
180002b52:     	movq	(%rdi,%r8,8), %r10
180002b56:     	movq	0x18(%rdi,%r8,8), %r11
180002b5b:     	movsd	0x10(%r9,%r10,8), %xmm0
180002b62:     	mulsd	%xmm6, %xmm0
180002b66:     	addsd	0x10(%r9,%r11,8), %xmm0
180002b6d:     	movsd	%xmm0, 0x10(%r9,%r11,8)
180002b74:     	movq	$0x0, 0x18(%rdi,%r11,8)
180002b7d:     	movq	0x10(%rdi,%r8,8), %r10
180002b82:     	movq	0x18(%rdi,%r8,8), %r11
180002b87:     	movsd	(%r9,%r11,8), %xmm0
180002b8d:     	mulsd	%xmm6, %xmm0
180002b91:     	addsd	(%r9,%r10,8), %xmm0
180002b97:     	movsd	%xmm0, (%r9,%r10,8)
180002b9d:     	movq	$0x0, 0x8(%rdi,%r10,8)
180002ba6:     	movq	0x10(%rdi,%r8,8), %r10
180002bab:     	movq	0x18(%rdi,%r8,8), %r11
180002bb0:     	movsd	0x10(%r9,%r11,8), %xmm0
180002bb7:     	mulsd	%xmm6, %xmm0
180002bbb:     	addsd	0x10(%r9,%r10,8), %xmm0
180002bc2:     	movsd	%xmm0, 0x10(%r9,%r10,8)
180002bc9:     	movq	$0x0, 0x18(%rdi,%r10,8)
180002bd2:     	movq	(%rdi,%r8,8), %r10
180002bd6:     	movq	$0x0, (%r9,%r10,8)
180002bde:     	movq	$0x1, 0x8(%rdi,%r10,8)
180002be7:     	movq	(%rdi,%r8,8), %r8
180002beb:     	movq	$0x0, 0x10(%r9,%r8,8)
180002bf4:     	movq	$0x1, 0x18(%rdi,%r8,8)
180002bfd:     	cmpb	$0x0, (%r15)
180002c01:     	je	0x180002af3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x583>
180002c07:     	jmp	0x180002c17 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6a7>
180002c09:     	movb	$0x1, (%r15)
180002c0d:     	movq	$0xd, 0x18(%r13)
180002c15:     	xorl	%eax, %eax
180002c17:     	movq	0x60(%rsp), %rcx
180002c1c:     	jmp	0x180002669 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xf9>
180002c21:     	nopw	%cs:(%rax,%rax)
180002c2b:     	nopl	(%rax,%rax)
180002c30:     	pushq	%r15
180002c32:     	pushq	%r14
180002c34:     	pushq	%r13
180002c36:     	pushq	%r12
180002c38:     	pushq	%rsi
180002c39:     	pushq	%rdi
180002c3a:     	pushq	%rbp
180002c3b:     	pushq	%rbx
180002c3c:     	subq	$0x118, %rsp            # imm = 0x118
180002c43:     	movapd	%xmm8, 0x100(%rsp)
180002c4d:     	movapd	%xmm7, 0xf0(%rsp)
180002c56:     	movapd	%xmm6, 0xe0(%rsp)
180002c5f:     	movq	0x198(%rsp), %r15
180002c67:     	movq	$0x0, 0x60(%rsp)
180002c70:     	movb	$0x0, 0x68(%rsp)
180002c75:     	movq	$0x0, 0x70(%rsp)
180002c7e:     	movsd	0x48(%r8,%r15,8), %xmm0
180002c85:     	xorpd	%xmm1, %xmm1
180002c89:     	ucomisd	%xmm1, %xmm0
180002c8d:     	jne	0x180002ca6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x736>
180002c8f:     	jp	0x180002ca6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x736>
180002c91:     	movb	$0x1, 0x18(%rcx)
180002c95:     	movq	$0x0, 0x10(%rcx)
180002c9d:     	movb	$0x1, 0x8(%rcx)
180002ca1:     	jmp	0x180002eb4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x944>
180002ca6:     	movq	0x1a0(%rsp), %rbx
180002cae:     	movq	0x190(%rsp), %r14
180002cb6:     	movq	0x188(%rsp), %rdi
180002cbe:     	movq	0x180(%rsp), %rsi
180002cc6:     	movq	0x30(%r9,%r15,8), %rdx
180002ccb:     	leaq	(%r9,%rdx,8), %rax
180002ccf:     	sarq	$0x3f, %rdx
180002cd3:     	andq	%r14, %rdx
180002cd6:     	cmpq	$0x1, (%rax,%rdx,8)
180002cdb:     	jne	0x180002cf1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x781>
180002cdd:     	cmpq	$0x0, (%rax)
180002ce1:     	jle	0x180002dea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x87a>
180002ce7:     	movq	0x10(%rax), %rax
180002ceb:     	cmpq	%rbx, (%r9,%rax,8)
180002cef:     	je	0x180002c91 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x721>
180002cf1:     	movq	0x10(%r9,%r15,8), %r10
180002cf6:     	movsd	(%r8,%r10,8), %xmm1
180002cfc:     	cmpq	$0x0, 0x8(%r9,%r10,8)
180002d02:     	setne	%r11b
180002d06:     	movq	0x10(%r9,%rbx,8), %rdx
180002d0b:     	cmpq	$0x0, 0x8(%r9,%rdx,8)
180002d11:     	setne	%al
180002d14:     	subsd	(%r8,%rdx,8), %xmm1
180002d1a:     	andb	%r11b, %al
180002d1d:     	cmpb	$0x1, %al
180002d1f:     	jne	0x180002d43 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x7d3>
180002d21:     	movapd	0x7697(%rip), %xmm2     # 0x18000a3c0
180002d29:     	andpd	%xmm1, %xmm2
180002d2d:     	ucomisd	0x769b(%rip), %xmm2     # 0x18000a3d0
180002d35:     	jae	0x180002dfa <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x88a>
180002d3b:     	xorpd	%xmm2, %xmm2
180002d3f:     	addsd	%xmm2, %xmm1
180002d43:     	movsd	0x10(%r8,%r10,8), %xmm2
180002d4a:     	cmpq	$0x0, 0x18(%r9,%r10,8)
180002d50:     	subsd	0x10(%r8,%rdx,8), %xmm2
180002d57:     	je	0x180002dc1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x851>
180002d59:     	cmpq	$0x0, 0x18(%r9,%rdx,8)
180002d5f:     	je	0x180002dc1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x851>
180002d61:     	movapd	0x7657(%rip), %xmm3     # 0x18000a3c0
180002d69:     	andpd	%xmm2, %xmm3
180002d6d:     	ucomisd	0x765b(%rip), %xmm3     # 0x18000a3d0
180002d75:     	jae	0x180002e3e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x8ce>
180002d7b:     	movapd	%xmm1, %xmm3
180002d7f:     	mulsd	%xmm1, %xmm3
180002d83:     	ucomisd	0x7645(%rip), %xmm3     # 0x18000a3d0
180002d8b:     	setae	%dl
180002d8e:     	testb	%dl, %al
180002d90:     	jne	0x180002dda <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x86a>
180002d92:     	xorpd	%xmm4, %xmm4
180002d96:     	addsd	%xmm4, %xmm2
180002d9a:     	movapd	%xmm2, %xmm4
180002d9e:     	mulsd	%xmm2, %xmm4
180002da2:     	ucomisd	0x7626(%rip), %xmm4     # 0x18000a3d0
180002daa:     	jae	0x180002dda <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x86a>
180002dac:     	addsd	%xmm4, %xmm3
180002db0:     	ucomisd	0x7618(%rip), %xmm3     # 0x18000a3d0
180002db8:     	setae	%dl
180002dbb:     	testb	%dl, %al
180002dbd:     	jne	0x180002dda <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x86a>
180002dbf:     	jmp	0x180002e16 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x8a6>
180002dc1:     	movapd	%xmm1, %xmm3
180002dc5:     	mulsd	%xmm1, %xmm3
180002dc9:     	ucomisd	0x75ff(%rip), %xmm3     # 0x18000a3d0
180002dd1:     	setae	%dl
180002dd4:     	andb	%dl, %al
180002dd6:     	cmpb	$0x1, %al
180002dd8:     	jne	0x180002e0a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x89a>
180002dda:     	movb	$0x1, (%rdi)
180002ddd:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180002de5:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180002dea:     	movb	$0x1, (%rdi)
180002ded:     	movq	$0x3d0906, 0x18(%rsi)   # imm = 0x3D0906
180002df5:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180002dfa:     	movb	$0x1, (%rdi)
180002dfd:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180002e05:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180002e0a:     	movapd	%xmm2, %xmm4
180002e0e:     	mulsd	%xmm2, %xmm4
180002e12:     	addsd	%xmm4, %xmm3
180002e16:     	xorps	%xmm4, %xmm4
180002e19:     	sqrtsd	%xmm3, %xmm4
180002e1d:     	cmpq	$0x0, 0x18(%r9,%r15,8)
180002e23:     	je	0x180002e71 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x901>
180002e25:     	xorpd	%xmm5, %xmm5
180002e29:     	ucomisd	%xmm5, %xmm3
180002e2d:     	jne	0x180002e4b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x8db>
180002e2f:     	jp	0x180002e4b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x8db>
180002e31:     	movb	$0x1, (%rdi)
180002e34:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180002e3c:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180002e3e:     	movb	$0x1, (%rdi)
180002e41:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180002e49:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180002e4b:     	movsd	0x1a8(%rsp), %xmm6
180002e54:     	movq	(%r9,%r15,8), %rax
180002e58:     	movsd	0x8(%r8,%rax,8), %xmm3
180002e5f:     	addsd	%xmm3, %xmm3
180002e63:     	divsd	%xmm4, %xmm3
180002e67:     	ucomisd	%xmm3, %xmm6
180002e6b:     	jbe	0x180002f24 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x9b4>
180002e71:     	movsd	0x755f(%rip), %xmm3     # 0x18000a3d8
180002e79:     	maxsd	%xmm4, %xmm3
180002e7d:     	movapd	%xmm3, %xmm4
180002e81:     	mulsd	%xmm3, %xmm4
180002e85:     	xorpd	%xmm5, %xmm5
180002e89:     	ucomisd	%xmm5, %xmm4
180002e8d:     	jne	0x180002eea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x97a>
180002e8f:     	jp	0x180002eea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x97a>
180002e91:     	movb	$0x1, (%rdi)
180002e94:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180002e9c:     	movq	$0x0, 0x18(%rcx)
180002ea4:     	movq	$0x0, 0x10(%rcx)
180002eac:     	movq	$0x0, 0x8(%rcx)
180002eb4:     	movq	$0x0, (%rcx)
180002ebb:     	xorl	%eax, %eax
180002ebd:     	movaps	0xe0(%rsp), %xmm6
180002ec5:     	movaps	0xf0(%rsp), %xmm7
180002ecd:     	movaps	0x100(%rsp), %xmm8
180002ed6:     	addq	$0x118, %rsp            # imm = 0x118
180002edd:     	popq	%rbx
180002ede:     	popq	%rbp
180002edf:     	popq	%rdi
180002ee0:     	popq	%rsi
180002ee1:     	popq	%r12
180002ee3:     	popq	%r13
180002ee5:     	popq	%r14
180002ee7:     	popq	%r15
180002ee9:     	retq
180002eea:     	movsd	0x8(%r8,%rbx,8), %xmm5
180002ef1:     	mulsd	0x74e7(%rip), %xmm5     # 0x18000a3e0
180002ef9:     	mulsd	%xmm5, %xmm0
180002efd:     	divsd	%xmm4, %xmm0
180002f01:     	mulsd	%xmm0, %xmm1
180002f05:     	divsd	%xmm3, %xmm1
180002f09:     	mulsd	%xmm0, %xmm2
180002f0d:     	divsd	%xmm3, %xmm2
180002f11:     	movsd	%xmm2, 0x10(%rcx)
180002f16:     	movsd	%xmm1, (%rcx)
180002f1a:     	movb	$0x0, 0x18(%rcx)
180002f1e:     	movb	$0x0, 0x8(%rcx)
180002f22:     	jmp	0x180002ebb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x94b>
180002f24:     	movq	0x20(%r9,%r15,8), %rax
180002f29:     	testq	%rax, %rax
180002f2c:     	js	0x180002fc9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xa59>
180002f32:     	movq	0x8(%rsi), %rdx
180002f36:     	leaq	0x1(%rdx), %r10
180002f3a:     	movq	%r10, 0x8(%rsi)
180002f3e:     	cmpq	0x10(%rsi), %rdx
180002f42:     	jge	0x180003113 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xba3>
180002f48:     	movq	%rcx, %r13
180002f4b:     	movsd	%xmm6, 0x48(%rsp)
180002f51:     	movq	%rbx, 0x40(%rsp)
180002f56:     	movq	%rax, 0x38(%rsp)
180002f5b:     	movq	%r14, 0x30(%rsp)
180002f60:     	movq	%rdi, 0x28(%rsp)
180002f65:     	movq	%rsi, 0x20(%rsp)
180002f6a:     	leaq	0xc0(%rsp), %rcx
180002f72:     	movq	%r8, %r12
180002f75:     	movq	%r9, %rbp
180002f78:     	callq	0x180002c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6c0>
180002f7d:     	cmpb	$0x0, (%rdi)
180002f80:     	jne	0x1800030ee <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xb7e>
180002f86:     	cmpb	$0x0, 0xd8(%rsp)
180002f8e:     	setne	%dl
180002f91:     	cmpb	$0x0, 0xc8(%rsp)
180002f99:     	setne	%r11b
180002f9d:     	xorpd	%xmm8, %xmm8
180002fa2:     	movsd	0xc0(%rsp), %xmm7
180002fab:     	addsd	%xmm8, %xmm7
180002fb0:     	addsd	0xd0(%rsp), %xmm8
180002fba:     	decq	0x8(%rsi)
180002fbe:     	movq	%r13, %rcx
180002fc1:     	movq	%r12, %r8
180002fc4:     	movq	%rbp, %r9
180002fc7:     	jmp	0x180002fd7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xa67>
180002fc9:     	movb	$0x1, %r11b
180002fcc:     	xorpd	%xmm7, %xmm7
180002fd0:     	xorpd	%xmm8, %xmm8
180002fd5:     	movb	$0x1, %dl
180002fd7:     	movq	0x28(%r9,%r15,8), %rax
180002fdc:     	testq	%rax, %rax
180002fdf:     	js	0x180003087 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xb17>
180002fe5:     	movl	%edx, %ebp
180002fe7:     	movq	0x8(%rsi), %rdx
180002feb:     	leaq	0x1(%rdx), %r10
180002fef:     	movq	%r10, 0x8(%rsi)
180002ff3:     	cmpq	0x10(%rsi), %rdx
180002ff7:     	jge	0x180003123 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xbb3>
180002ffd:     	movb	%r11b, 0x57(%rsp)
180003002:     	movq	%rcx, %r13
180003005:     	movsd	%xmm6, 0x48(%rsp)
18000300b:     	movq	%rbx, 0x40(%rsp)
180003010:     	movq	%rax, 0x38(%rsp)
180003015:     	movq	%r14, 0x30(%rsp)
18000301a:     	movq	%rdi, 0x28(%rsp)
18000301f:     	movq	%rsi, 0x20(%rsp)
180003024:     	leaq	0xa0(%rsp), %rcx
18000302c:     	movq	%r8, 0x58(%rsp)
180003031:     	movq	%r9, %r12
180003034:     	callq	0x180002c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6c0>
180003039:     	cmpb	$0x0, (%rdi)
18000303c:     	jne	0x1800030ee <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xb7e>
180003042:     	cmpb	$0x0, 0xb8(%rsp)
18000304a:     	setne	%al
18000304d:     	cmpb	$0x0, 0xa8(%rsp)
180003055:     	setne	%cl
180003058:     	addsd	0xa0(%rsp), %xmm7
180003061:     	addsd	0xb0(%rsp), %xmm8
18000306b:     	decq	0x8(%rsi)
18000306f:     	movzbl	0x57(%rsp), %r11d
180003075:     	andb	%cl, %r11b
180003078:     	movl	%ebp, %edx
18000307a:     	andb	%al, %dl
18000307c:     	movq	%r13, %rcx
18000307f:     	movq	0x58(%rsp), %r8
180003084:     	movq	%r12, %r9
180003087:     	movq	0x38(%r9,%r15,8), %rax
18000308c:     	testq	%rax, %rax
18000308f:     	js	0x180003188 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xc18>
180003095:     	movl	%edx, %ebp
180003097:     	movq	0x8(%rsi), %rdx
18000309b:     	leaq	0x1(%rdx), %r10
18000309f:     	movq	%r10, 0x8(%rsi)
1800030a3:     	cmpq	0x10(%rsi), %rdx
1800030a7:     	jge	0x180003133 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xbc3>
1800030ad:     	movb	%r11b, 0x57(%rsp)
1800030b2:     	movq	%rcx, %r13
1800030b5:     	movsd	%xmm6, 0x48(%rsp)
1800030bb:     	movq	%rbx, 0x40(%rsp)
1800030c0:     	movq	%rax, 0x38(%rsp)
1800030c5:     	movq	%r14, 0x30(%rsp)
1800030ca:     	movq	%rdi, 0x28(%rsp)
1800030cf:     	movq	%rsi, 0x20(%rsp)
1800030d4:     	leaq	0x80(%rsp), %rcx
1800030dc:     	movq	%r8, 0x58(%rsp)
1800030e1:     	movq	%r9, %r12
1800030e4:     	callq	0x180002c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6c0>
1800030e9:     	cmpb	$0x0, (%rdi)
1800030ec:     	je	0x180003143 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xbd3>
1800030ee:     	movq	$0x0, 0x18(%r13)
1800030f6:     	movq	$0x0, 0x10(%r13)
1800030fe:     	movq	$0x0, 0x8(%r13)
180003106:     	movq	$0x0, (%r13)
18000310e:     	jmp	0x180002ebb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x94b>
180003113:     	movb	$0x1, (%rdi)
180003116:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
18000311e:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180003123:     	movb	$0x1, (%rdi)
180003126:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
18000312e:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180003133:     	movb	$0x1, (%rdi)
180003136:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
18000313e:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180003143:     	cmpb	$0x0, 0x98(%rsp)
18000314b:     	setne	%al
18000314e:     	cmpb	$0x0, 0x88(%rsp)
180003156:     	setne	%cl
180003159:     	addsd	0x80(%rsp), %xmm7
180003162:     	addsd	0x90(%rsp), %xmm8
18000316c:     	decq	0x8(%rsi)
180003170:     	movzbl	0x57(%rsp), %r11d
180003176:     	andb	%cl, %r11b
180003179:     	movl	%ebp, %edx
18000317b:     	andb	%al, %dl
18000317d:     	movq	%r13, %rcx
180003180:     	movq	0x58(%rsp), %r8
180003185:     	movq	%r12, %r9
180003188:     	movq	0x40(%r9,%r15,8), %rax
18000318d:     	testq	%rax, %rax
180003190:     	js	0x180003242 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcd2>
180003196:     	movl	%edx, %r12d
180003199:     	movq	0x8(%rsi), %rdx
18000319d:     	leaq	0x1(%rdx), %r10
1800031a1:     	movq	%r10, 0x8(%rsi)
1800031a5:     	cmpq	0x10(%rsi), %rdx
1800031a9:     	jge	0x180003203 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xc93>
1800031ab:     	movl	%r11d, %ebp
1800031ae:     	movq	%rcx, %r15
1800031b1:     	movsd	%xmm6, 0x48(%rsp)
1800031b7:     	movq	%rbx, 0x40(%rsp)
1800031bc:     	movq	%rax, 0x38(%rsp)
1800031c1:     	movq	%r14, 0x30(%rsp)
1800031c6:     	movq	%rdi, 0x28(%rsp)
1800031cb:     	movq	%rsi, 0x20(%rsp)
1800031d0:     	leaq	0x60(%rsp), %rcx
1800031d5:     	callq	0x180002c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x6c0>
1800031da:     	cmpb	$0x0, (%rdi)
1800031dd:     	je	0x180003213 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xca3>
1800031df:     	movq	$0x0, 0x18(%r15)
1800031e7:     	movq	$0x0, 0x10(%r15)
1800031ef:     	movq	$0x0, 0x8(%r15)
1800031f7:     	movq	$0x0, (%r15)
1800031fe:     	jmp	0x180002ebb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x94b>
180003203:     	movb	$0x1, (%rdi)
180003206:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
18000320e:     	jmp	0x180002e9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x92c>
180003213:     	cmpb	$0x0, 0x78(%rsp)
180003218:     	setne	%al
18000321b:     	cmpb	$0x0, 0x68(%rsp)
180003220:     	setne	%cl
180003223:     	addsd	0x60(%rsp), %xmm7
180003229:     	addsd	0x70(%rsp), %xmm8
180003230:     	decq	0x8(%rsi)
180003234:     	movl	%ebp, %r11d
180003237:     	andb	%cl, %r11b
18000323a:     	movl	%r12d, %edx
18000323d:     	andb	%al, %dl
18000323f:     	movq	%r15, %rcx
180003242:     	movb	%dl, 0x18(%rcx)
180003245:     	movsd	%xmm8, 0x10(%rcx)
18000324b:     	movb	%r11b, 0x8(%rcx)
18000324f:     	movsd	%xmm7, (%rcx)
180003253:     	jmp	0x180002ebb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x94b>
180003258:     	nopl	(%rax,%rax)
180003260:     	pushq	%r15
180003262:     	pushq	%r14
180003264:     	pushq	%r13
180003266:     	pushq	%r12
180003268:     	pushq	%rsi
180003269:     	pushq	%rdi
18000326a:     	pushq	%rbp
18000326b:     	pushq	%rbx
18000326c:     	subq	$0xf8, %rsp
180003273:     	movq	0x178(%rsp), %rax
18000327b:     	movq	0x170(%rsp), %rbx
180003283:     	movq	0x168(%rsp), %r13
18000328b:     	movq	0x160(%rsp), %rbp
180003293:     	movb	$0x0, 0x67(%rsp)
180003298:     	movb	$0x0, 0x62(%rsp)
18000329d:     	movb	$0x0, 0x61(%rsp)
1800032a2:     	movb	$0x0, 0x60(%rsp)
1800032a7:     	movb	$0x0, 0x5f(%rsp)
1800032ac:     	movb	$0x0, 0x66(%rsp)
1800032b1:     	movb	$0x0, 0x65(%rsp)
1800032b6:     	movb	$0x0, 0x64(%rsp)
1800032bb:     	movb	$0x0, 0x63(%rsp)
1800032c0:     	testq	%rax, %rax
1800032c3:     	je	0x1800032ea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xd7a>
1800032c5:     	cmpq	$0x1, %rax
1800032c9:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800032cf:     	movq	(%rbp), %rdx
1800032d3:     	leaq	0x4(%rdx), %rax
1800032d7:     	cmpq	%rbx, %rax
1800032da:     	jle	0x18000345e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xeee>
1800032e0:     	movb	$0x2, (%r13)
1800032e5:     	jmp	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800032ea:     	movq	0x188(%rsp), %r14
1800032f2:     	movq	0x180(%rsp), %r15
1800032fa:     	movq	(%r9,%r15,8), %rax
1800032fe:     	movq	0x10(%r9,%r14,8), %rdx
180003303:     	movsd	(%r8,%rdx,8), %xmm0
180003309:     	movsd	0x8(%r8,%rax,8), %xmm2
180003310:     	movsd	0x10(%r8,%rax,8), %xmm1
180003317:     	movapd	%xmm1, %xmm3
18000331b:     	subsd	%xmm2, %xmm3
18000331f:     	xorl	%r12d, %r12d
180003322:     	ucomisd	%xmm3, %xmm0
180003326:     	jb	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
18000332c:     	addsd	%xmm2, %xmm1
180003330:     	ucomisd	%xmm0, %xmm1
180003334:     	jbe	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
18000333a:     	movsd	0x10(%r8,%rdx,8), %xmm0
180003341:     	movsd	(%r8,%rax,8), %xmm2
180003347:     	movsd	0x18(%r8,%rax,8), %xmm1
18000334e:     	movapd	%xmm1, %xmm3
180003352:     	subsd	%xmm2, %xmm3
180003356:     	ucomisd	%xmm3, %xmm0
18000335a:     	jb	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
180003360:     	addsd	%xmm2, %xmm1
180003364:     	xorl	%r12d, %r12d
180003367:     	ucomisd	%xmm0, %xmm1
18000336b:     	jbe	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003371:     	cmpb	$0x0, (%r13)
180003376:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
18000337c:     	movq	0x18(%r9,%r15,8), %r10
180003381:     	movq	0x30(%r9,%r15,8), %rdx
180003386:     	movq	%rdx, %r11
180003389:     	sarq	$0x3f, %r11
18000338d:     	andq	%rbx, %r11
180003390:     	leaq	(%r9,%rdx,8), %r12
180003394:     	movq	(%r12,%r11,8), %rdi
180003398:     	cmpq	0x8(%r9,%r15,8), %rdi
18000339d:     	jge	0x180003659 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10e9>
1800033a3:     	testq	%r10, %r10
1800033a6:     	jne	0x18000365e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10ee>
1800033ac:     	xorl	%eax, %eax
1800033ae:     	cmpq	$-0x1, %rdx
1800033b2:     	cmovlq	%rbx, %rax
1800033b6:     	cmpq	0x8(%r12,%rax,8), %rdi
1800033bb:     	jne	0x180003b6c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x15fc>
1800033c1:     	leaq	(%rdi,%rdi), %r10
1800033c5:     	testq	%rdi, %rdi
1800033c8:     	movl	$0x4, %r14d
1800033ce:     	cmovneq	%r10, %r14
1800033d2:     	movq	(%rbp), %rsi
1800033d6:     	movq	%rsi, 0x70(%rsp)
1800033db:     	leaq	(%rsi,%r14), %r10
1800033df:     	cmpq	%rbx, %r10
1800033e2:     	jg	0x1800032e0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xd70>
1800033e8:     	movq	%r10, (%rbp)
1800033ec:     	cmpb	$0x0, (%r13)
1800033f1:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800033f7:     	movq	%r14, 0xb8(%rsp)
1800033ff:     	movq	%rax, 0xc0(%rsp)
180003407:     	xorl	%eax, %eax
180003409:     	movq	%rdx, 0x90(%rsp)
180003411:     	cmpq	$-0x2, %rdx
180003415:     	cmovlq	%rbx, %rax
180003419:     	movq	%rax, 0x98(%rsp)
180003421:     	testq	%rdi, %rdi
180003424:     	jle	0x180003b2d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x15bd>
18000342a:     	movq	0x98(%rsp), %rax
180003432:     	movq	0x10(%r12,%rax,8), %rsi
180003437:     	movl	%edi, %edx
180003439:     	andl	$0x7, %edx
18000343c:     	cmpq	$0x7, %rdi
180003440:     	ja	0x18000383b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x12cb>
180003446:     	leaq	(,%rbx,8), %rax
18000344e:     	movq	%rax, 0xa8(%rsp)
180003456:     	xorl	%r13d, %r13d
180003459:     	jmp	0x180003adf <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x156f>
18000345e:     	movq	0x190(%rsp), %r15
180003466:     	movq	(%r9,%r15,8), %r10
18000346a:     	movsd	0x10(%r8,%r10,8), %xmm2
180003471:     	movsd	0x18(%r8,%r10,8), %xmm1
180003478:     	movsd	0x6f30(%rip), %xmm0     # 0x18000a3b0
180003480:     	movsd	0x8(%r8,%r10,8), %xmm3
180003487:     	mulsd	%xmm0, %xmm3
18000348b:     	mulsd	(%r8,%r10,8), %xmm0
180003491:     	movq	%rax, (%rbp)
180003495:     	cmpb	$0x0, (%r13)
18000349a:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800034a0:     	movapd	%xmm2, %xmm4
1800034a4:     	addsd	%xmm3, %xmm4
1800034a8:     	movapd	%xmm1, %xmm5
1800034ac:     	subsd	%xmm0, %xmm5
1800034b0:     	movsd	%xmm4, 0x10(%r8,%rdx,8)
1800034b7:     	movsd	%xmm5, 0x18(%r8,%rdx,8)
1800034be:     	movsd	%xmm3, 0x8(%r8,%rdx,8)
1800034c5:     	movsd	%xmm0, (%r8,%rdx,8)
1800034cb:     	cmpb	$0x0, (%r13)
1800034d0:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800034d6:     	movq	(%rbp), %rax
1800034da:     	leaq	0xb(%rax), %r11
1800034de:     	cmpq	%rbx, %r11
1800034e1:     	jg	0x1800032e0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xd70>
1800034e7:     	movq	0x8(%r9,%r15,8), %r10
1800034ec:     	movq	%r11, (%rbp)
1800034f0:     	cmpb	$0x0, (%r13)
1800034f5:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800034fb:     	movq	%rdx, (%r9,%rax,8)
1800034ff:     	movq	%r10, 0x8(%r9,%rax,8)
180003504:     	movq	(%rbp), %rdx
180003508:     	cmpq	%rbx, %rdx
18000350b:     	movq	%rdx, %r10
18000350e:     	jle	0x18000351c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xfac>
180003510:     	movb	$0x2, (%r13)
180003515:     	movq	(%rbp), %rdx
180003519:     	xorl	%r10d, %r10d
18000351c:     	leaq	0x3(%rdx), %r11
180003520:     	cmpq	%rbx, %r11
180003523:     	jg	0x1800032e0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xd70>
180003529:     	movq	%r11, (%rbp)
18000352d:     	cmpb	$0x0, (%r13)
180003532:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
180003538:     	movq	%rdx, %r11
18000353b:     	sarq	$0x3f, %r11
18000353f:     	andq	%rbx, %r11
180003542:     	leaq	(%r9,%rdx,8), %rsi
180003546:     	movq	$0x0, (%rsi,%r11,8)
18000354e:     	xorl	%r12d, %r12d
180003551:     	cmpq	$-0x1, %rdx
180003555:     	movl	$0x0, %r11d
18000355b:     	cmovlq	%rbx, %r11
18000355f:     	movq	$0x0, 0x8(%rsi,%r11,8)
180003568:     	cmpq	$-0x2, %rdx
18000356c:     	movl	$0x0, %r11d
180003572:     	cmovlq	%rbx, %r11
180003576:     	movq	%r10, 0x10(%rsi,%r11,8)
18000357b:     	cmpb	$0x0, (%r13)
180003580:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003586:     	leaq	(%r9,%rax,8), %r10
18000358a:     	movq	%rdx, 0x30(%r10)
18000358e:     	movq	$0x0, 0x18(%r10)
180003596:     	movq	(%rbp), %rdx
18000359a:     	leaq	0x4(%rdx), %r11
18000359e:     	cmpq	%rbx, %r11
1800035a1:     	jg	0x1800032e0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xd70>
1800035a7:     	movq	%r11, (%rbp)
1800035ab:     	cmpb	$0x0, (%r13)
1800035b0:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
1800035b6:     	movq	%rcx, %r14
1800035b9:     	movq	$0x0, (%r8,%rdx,8)
1800035c1:     	movq	$0x1, 0x8(%r9,%rdx,8)
1800035ca:     	movq	$0x0, 0x10(%r8,%rdx,8)
1800035d3:     	movq	$0x1, 0x18(%r9,%rdx,8)
1800035dc:     	cmpb	$0x0, (%r13)
1800035e1:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800035e7:     	movq	%r8, %rdi
1800035ea:     	movq	%r9, %rsi
1800035ed:     	movq	%rdx, 0x10(%r10)
1800035f1:     	movq	$0x0, 0x48(%r8,%rax,8)
1800035fa:     	movq	$0x1, 0x50(%r10)
180003602:     	movq	$-0x1, 0x20(%r10)
18000360a:     	movq	$-0x1, 0x28(%r10)
180003612:     	movq	$-0x1, 0x38(%r10)
18000361a:     	movq	$-0x1, 0x40(%r10)
180003622:     	movq	0x168(%rsp), %rcx
18000362a:     	cmpb	$0x0, (%rcx)
18000362d:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003633:     	movq	%rax, 0x20(%rsi,%r15,8)
180003638:     	movq	(%rbp), %rcx
18000363c:     	leaq	0x4(%rcx), %rax
180003640:     	cmpq	%rbx, %rax
180003643:     	jle	0x180003da4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1834>
180003649:     	movq	0x168(%rsp), %rax
180003651:     	movb	$0x2, (%rax)
180003654:     	jmp	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003659:     	testq	%r10, %r10
18000365c:     	je	0x1800036d9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1169>
18000365e:     	movq	0x20(%r9,%r15,8), %rax
180003663:     	testq	%rax, %rax
180003666:     	js	0x1800037a2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1232>
18000366c:     	movq	0x8(%rbp), %rdx
180003670:     	leaq	0x1(%rdx), %r10
180003674:     	movq	%r10, 0x8(%rbp)
180003678:     	cmpq	0x10(%rbp), %rdx
18000367c:     	jge	0x1800037a2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1232>
180003682:     	movq	%rcx, %rdi
180003685:     	movb	$0x0, 0x62(%rsp)
18000368a:     	movq	%r14, 0x48(%rsp)
18000368f:     	movq	%rax, 0x40(%rsp)
180003694:     	movq	%rbx, 0x30(%rsp)
180003699:     	movq	%r13, 0x28(%rsp)
18000369e:     	movq	%rbp, 0x20(%rsp)
1800036a3:     	movq	$-0x1, 0x50(%rsp)
1800036ac:     	movq	$0x0, 0x38(%rsp)
1800036b5:     	leaq	0x62(%rsp), %rcx
1800036ba:     	movq	%r8, 0x68(%rsp)
1800036bf:     	movq	%r9, %rsi
1800036c2:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
1800036c7:     	cmpb	$0x0, (%r13)
1800036cc:     	je	0x18000374b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x11db>
1800036ce:     	xorl	%r12d, %r12d
1800036d1:     	movq	%rdi, %rcx
1800036d4:     	jmp	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
1800036d9:     	movq	0x8(%rbp), %rax
1800036dd:     	leaq	0x1(%rax), %rdx
1800036e1:     	movq	%rdx, 0x8(%rbp)
1800036e5:     	cmpq	0x10(%rbp), %rax
1800036e9:     	jge	0x18000373c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x11cc>
1800036eb:     	movq	%rcx, %rsi
1800036ee:     	movq	%r15, 0x50(%rsp)
1800036f3:     	movq	%rbx, 0x30(%rsp)
1800036f8:     	movq	%r13, 0x28(%rsp)
1800036fd:     	movq	%rbp, 0x20(%rsp)
180003702:     	movq	$-0x1, 0x48(%rsp)
18000370b:     	movq	$-0x1, 0x40(%rsp)
180003714:     	movq	$0x1, 0x38(%rsp)
18000371d:     	leaq	0x67(%rsp), %rcx
180003722:     	movq	%r8, %rdi
180003725:     	movq	%r9, %r12
180003728:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
18000372d:     	cmpb	$0x0, (%r13)
180003732:     	je	0x180003787 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1217>
180003734:     	xorl	%r12d, %r12d
180003737:     	movq	%rsi, %rcx
18000373a:     	jmp	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
18000373c:     	movb	$0x1, (%r13)
180003741:     	movq	$0x2dc6cb, 0x18(%rbp)   # imm = 0x2DC6CB
180003749:     	jmp	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
18000374b:     	movq	0x8(%rbp), %rdx
18000374f:     	leaq	-0x1(%rdx), %rax
180003753:     	cmpb	$0x0, 0x62(%rsp)
180003758:     	movq	%rax, 0x8(%rbp)
18000375c:     	movb	$0x1, %r12b
18000375f:     	movq	%rdi, %rcx
180003762:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003764:     	movq	0x28(%rsi,%r15,8), %rax
180003769:     	testq	%rax, %rax
18000376c:     	js	0x180003778 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1208>
18000376e:     	movq	%rdx, 0x8(%rbp)
180003772:     	cmpq	0x10(%rbp), %rdx
180003776:     	jle	0x1800037cf <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x125f>
180003778:     	movb	$0x1, (%r13)
18000377d:     	movq	$0x2dc6ce, 0x18(%rbp)   # imm = 0x2DC6CE
180003785:     	jmp	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
180003787:     	decq	0x8(%rbp)
18000378b:     	movq	%rsi, %rcx
18000378e:     	movq	%r12, %r9
180003791:     	movq	%rdi, %r8
180003794:     	movq	0x20(%r9,%r15,8), %rax
180003799:     	testq	%rax, %rax
18000379c:     	jns	0x18000366c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10fc>
1800037a2:     	movb	$0x1, (%r13)
1800037a7:     	movq	$0x2dc6cd, 0x18(%rbp)   # imm = 0x2DC6CD
1800037af:     	xorl	%r12d, %r12d
1800037b2:     	andb	$0x1, %r12b
1800037b6:     	movb	%r12b, (%rcx)
1800037b9:     	xorl	%eax, %eax
1800037bb:     	addq	$0xf8, %rsp
1800037c2:     	popq	%rbx
1800037c3:     	popq	%rbp
1800037c4:     	popq	%rdi
1800037c5:     	popq	%rsi
1800037c6:     	popq	%r12
1800037c8:     	popq	%r13
1800037ca:     	popq	%r14
1800037cc:     	popq	%r15
1800037ce:     	retq
1800037cf:     	movq	%rsi, %r9
1800037d2:     	movb	$0x0, 0x61(%rsp)
1800037d7:     	movq	%r14, 0x48(%rsp)
1800037dc:     	movq	%rax, 0x40(%rsp)
1800037e1:     	movq	%rbx, 0x30(%rsp)
1800037e6:     	movq	%r13, 0x28(%rsp)
1800037eb:     	movq	%rbp, 0x20(%rsp)
1800037f0:     	movq	$-0x1, 0x50(%rsp)
1800037f9:     	movq	$0x0, 0x38(%rsp)
180003802:     	leaq	0x61(%rsp), %rcx
180003807:     	movq	0x68(%rsp), %r8
18000380c:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180003811:     	cmpb	$0x0, (%r13)
180003816:     	jne	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
18000381c:     	movq	0x8(%rbp), %rcx
180003820:     	leaq	-0x1(%rcx), %rax
180003824:     	cmpb	$0x0, 0x61(%rsp)
180003829:     	movq	%rax, 0x8(%rbp)
18000382d:     	je	0x180003ccb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x175b>
180003833:     	movq	%rdi, %rcx
180003836:     	jmp	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
18000383b:     	movabsq	$0x7ffffffffffffff8, %r13 # imm = 0x7FFFFFFFFFFFFFF8
180003845:     	movq	%rdi, 0xb0(%rsp)
18000384d:     	andq	%rdi, %r13
180003850:     	leaq	(%r9,%rsi,8), %rax
180003854:     	movq	%rax, 0xd8(%rsp)
18000385c:     	movq	0x70(%rsp), %rax
180003861:     	leaq	(%r9,%rax,8), %rax
180003865:     	movq	%rax, 0xc8(%rsp)
18000386d:     	leaq	(,%rbx,8), %rax
180003875:     	movq	%rax, 0xa8(%rsp)
18000387d:     	movq	%rsi, 0xa0(%rsp)
180003885:     	xorl	%esi, %esi
180003887:     	movq	%r13, 0xd0(%rsp)
18000388f:     	movq	0xa0(%rsp), %rax
180003897:     	leaq	(%rax,%rsi), %r12
18000389b:     	movq	%r12, %r10
18000389e:     	sarq	$0x3f, %r10
1800038a2:     	leaq	(,%rbx,8), %r14
1800038aa:     	andq	%r14, %r10
1800038ad:     	movq	0xd8(%rsp), %r13
1800038b5:     	addq	%r13, %r10
1800038b8:     	movq	(%r10,%rsi,8), %rax
1800038bc:     	movq	%rax, 0x68(%rsp)
1800038c1:     	movq	0x70(%rsp), %rax
1800038c6:     	leaq	(%rax,%rsi), %rdi
1800038ca:     	movq	%rdi, %r10
1800038cd:     	sarq	$0x3f, %r10
1800038d1:     	andq	%r14, %r10
1800038d4:     	movq	0xc8(%rsp), %r14
1800038dc:     	addq	%r14, %r10
1800038df:     	movq	0x68(%rsp), %rax
1800038e4:     	movq	%rax, (%r10,%rsi,8)
1800038e8:     	movq	%r12, %r10
1800038eb:     	incq	%r10
1800038ee:     	movl	$0x8, %r10d
1800038f4:     	leaq	0x8(,%rbx,8), %rax
1800038fc:     	movq	%rax, 0x78(%rsp)
180003901:     	cmovsq	%rax, %r10
180003905:     	addq	%r13, %r10
180003908:     	movq	(%r10,%rsi,8), %r10
18000390c:     	movq	%rdi, %rax
18000390f:     	incq	%rax
180003912:     	movl	$0x8, %eax
180003917:     	cmovsq	0x78(%rsp), %rax
18000391d:     	addq	%r14, %rax
180003920:     	movq	%r10, (%rax,%rsi,8)
180003924:     	movq	%r12, %rax
180003927:     	addq	$0x2, %rax
18000392b:     	movl	$0x10, %eax
180003930:     	leaq	0x10(,%rbx,8), %r10
180003938:     	movq	%r10, 0x88(%rsp)
180003940:     	cmovsq	%r10, %rax
180003944:     	addq	%r13, %rax
180003947:     	movq	(%rax,%rsi,8), %rax
18000394b:     	movq	%rdi, %r10
18000394e:     	addq	$0x2, %r10
180003952:     	movl	$0x10, %r10d
180003958:     	cmovsq	0x88(%rsp), %r10
180003961:     	addq	%r14, %r10
180003964:     	movq	%rax, (%r10,%rsi,8)
180003968:     	movq	%r12, %rax
18000396b:     	addq	$0x3, %rax
18000396f:     	movl	$0x18, %eax
180003974:     	leaq	0x18(,%rbx,8), %r10
18000397c:     	movq	%r10, 0x80(%rsp)
180003984:     	cmovsq	%r10, %rax
180003988:     	addq	%r13, %rax
18000398b:     	movq	(%rax,%rsi,8), %rax
18000398f:     	movq	%rdi, %r10
180003992:     	addq	$0x3, %r10
180003996:     	movl	$0x18, %r10d
18000399c:     	cmovsq	0x80(%rsp), %r10
1800039a5:     	addq	%r14, %r10
1800039a8:     	movq	%rax, (%r10,%rsi,8)
1800039ac:     	movq	%r12, %rax
1800039af:     	addq	$0x4, %rax
1800039b3:     	movl	$0x20, %eax
1800039b8:     	leaq	0x20(,%rbx,8), %r10
1800039c0:     	movq	%r10, 0xf0(%rsp)
1800039c8:     	cmovsq	%r10, %rax
1800039cc:     	addq	%r13, %rax
1800039cf:     	movq	(%rax,%rsi,8), %rax
1800039d3:     	movq	%rdi, %r10
1800039d6:     	addq	$0x4, %r10
1800039da:     	movl	$0x20, %r10d
1800039e0:     	cmovsq	0xf0(%rsp), %r10
1800039e9:     	addq	%r14, %r10
1800039ec:     	movq	%rax, (%r10,%rsi,8)
1800039f0:     	movq	%r12, %rax
1800039f3:     	addq	$0x5, %rax
1800039f7:     	movl	$0x28, %eax
1800039fc:     	leaq	0x28(,%rbx,8), %r10
180003a04:     	movq	%r10, 0xe8(%rsp)
180003a0c:     	cmovsq	%r10, %rax
180003a10:     	addq	%r13, %rax
180003a13:     	movq	(%rax,%rsi,8), %rax
180003a17:     	movq	%rdi, %r10
180003a1a:     	addq	$0x5, %r10
180003a1e:     	movl	$0x28, %r10d
180003a24:     	cmovsq	0xe8(%rsp), %r10
180003a2d:     	addq	%r14, %r10
180003a30:     	movq	%rax, (%r10,%rsi,8)
180003a34:     	movq	%r12, %rax
180003a37:     	addq	$0x6, %rax
180003a3b:     	movl	$0x30, %eax
180003a40:     	leaq	0x30(,%rbx,8), %r10
180003a48:     	movq	%r10, 0xe0(%rsp)
180003a50:     	cmovsq	%r10, %rax
180003a54:     	addq	%r13, %rax
180003a57:     	movq	(%rax,%rsi,8), %rax
180003a5b:     	movq	%rdi, %r10
180003a5e:     	addq	$0x6, %r10
180003a62:     	movl	$0x30, %r10d
180003a68:     	cmovsq	0xe0(%rsp), %r10
180003a71:     	addq	%r14, %r10
180003a74:     	movq	%rax, (%r10,%rsi,8)
180003a78:     	addq	$0x7, %r12
180003a7c:     	movl	$0x38, %eax
180003a81:     	leaq	0x38(,%rbx,8), %r12
180003a89:     	cmovsq	%r12, %rax
180003a8d:     	addq	%r13, %rax
180003a90:     	movq	0xd0(%rsp), %r13
180003a98:     	movq	(%rax,%rsi,8), %rax
180003a9c:     	addq	$0x7, %rdi
180003aa0:     	movl	$0x38, %r10d
180003aa6:     	cmovsq	%r12, %r10
180003aaa:     	addq	%r14, %r10
180003aad:     	movq	%rax, (%r10,%rsi,8)
180003ab1:     	addq	$0x8, %rsi
180003ab5:     	cmpq	%rsi, %r13
180003ab8:     	jne	0x18000388f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x131f>
180003abe:     	testq	%rdx, %rdx
180003ac1:     	movq	0xb0(%rsp), %rdi
180003ac9:     	movq	0x90(%rsp), %rax
180003ad1:     	leaq	(%r9,%rax,8), %r12
180003ad5:     	movq	0xa0(%rsp), %rsi
180003add:     	je	0x180003b2d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x15bd>
180003adf:     	movq	0x70(%rsp), %rax
180003ae4:     	leaq	(%r13,%rax), %r10
180003ae9:     	addq	%r13, %rsi
180003aec:     	movq	0xa8(%rsp), %r13
180003af4:     	movq	%rsi, %rax
180003af7:     	sarq	$0x3f, %rax
180003afb:     	andq	%r13, %rax
180003afe:     	addq	%r9, %rax
180003b01:     	movq	(%rax,%rsi,8), %rax
180003b05:     	movq	%rdx, %r14
180003b08:     	movq	%rsi, %rdx
180003b0b:     	movq	%r10, %rsi
180003b0e:     	sarq	$0x3f, %rsi
180003b12:     	andq	%r13, %rsi
180003b15:     	addq	%r9, %rsi
180003b18:     	movq	%rax, (%rsi,%r10,8)
180003b1c:     	movq	%rdx, %rsi
180003b1f:     	movq	%r14, %rdx
180003b22:     	incq	%r10
180003b25:     	incq	%rsi
180003b28:     	decq	%rdx
180003b2b:     	jne	0x180003af4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1584>
180003b2d:     	movq	0xc0(%rsp), %rax
180003b35:     	movq	0xb8(%rsp), %r10
180003b3d:     	movq	%r10, 0x8(%r12,%rax,8)
180003b42:     	movq	0x70(%rsp), %rax
180003b47:     	movq	0x98(%rsp), %r10
180003b4f:     	movq	%rax, 0x10(%r12,%r10,8)
180003b54:     	movq	0x90(%rsp), %rdx
180003b5c:     	movq	0x168(%rsp), %r13
180003b64:     	movq	0x188(%rsp), %r14
180003b6c:     	leaq	0x1(%rdi), %rax
180003b70:     	movq	%rax, (%r12,%r11,8)
180003b74:     	cmpb	$0x0, (%r13)
180003b79:     	jne	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
180003b7f:     	xorl	%eax, %eax
180003b81:     	cmpq	$-0x2, %rdx
180003b85:     	cmovlq	%rbx, %rax
180003b89:     	addq	0x10(%r12,%rax,8), %rdi
180003b8e:     	movq	%rdi, %rax
180003b91:     	sarq	$0x3f, %rax
180003b95:     	andq	%rbx, %rax
180003b98:     	leaq	(%r9,%rdi,8), %rdx
180003b9c:     	movq	%r14, (%rdx,%rax,8)
180003ba0:     	movsd	0x48(%r8,%r15,8), %xmm2
180003ba7:     	movsd	0x8(%r8,%r14,8), %xmm1
180003bae:     	movapd	%xmm2, %xmm0
180003bb2:     	addsd	%xmm1, %xmm0
180003bb6:     	xorpd	%xmm3, %xmm3
180003bba:     	ucomisd	%xmm3, %xmm0
180003bbe:     	jbe	0x180003c8f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x171f>
180003bc4:     	movq	0x10(%r9,%r15,8), %rax
180003bc9:     	cmpq	$0x0, 0x8(%r9,%rax,8)
180003bcf:     	mulsd	(%r8,%rax,8), %xmm2
180003bd5:     	je	0x180003c01 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1691>
180003bd7:     	cmpq	$0x0, 0x50(%r9,%r15,8)
180003bdd:     	je	0x180003c01 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1691>
180003bdf:     	movapd	0x67d9(%rip), %xmm3     # 0x18000a3c0
180003be7:     	andpd	%xmm2, %xmm3
180003beb:     	ucomisd	0x67dd(%rip), %xmm3     # 0x18000a3d0
180003bf3:     	jae	0x180003cad <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x173d>
180003bf9:     	xorpd	%xmm3, %xmm3
180003bfd:     	addsd	%xmm3, %xmm2
180003c01:     	movq	0x10(%r9,%r14,8), %rdx
180003c06:     	mulsd	(%r8,%rdx,8), %xmm1
180003c0c:     	addsd	%xmm2, %xmm1
180003c10:     	divsd	%xmm0, %xmm1
180003c14:     	movsd	%xmm1, (%r8,%rax,8)
180003c1a:     	movq	$0x0, 0x8(%r9,%rax,8)
180003c23:     	movq	0x10(%r9,%r15,8), %rax
180003c28:     	movsd	0x10(%r8,%rax,8), %xmm1
180003c2f:     	cmpq	$0x0, 0x18(%r9,%rax,8)
180003c35:     	mulsd	0x48(%r8,%r15,8), %xmm1
180003c3c:     	je	0x180003c64 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x16f4>
180003c3e:     	cmpq	$0x0, 0x50(%r9,%r15,8)
180003c44:     	je	0x180003c64 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x16f4>
180003c46:     	movapd	0x6772(%rip), %xmm2     # 0x18000a3c0
180003c4e:     	andpd	%xmm1, %xmm2
180003c52:     	ucomisd	0x6776(%rip), %xmm2     # 0x18000a3d0
180003c5a:     	jae	0x180003cbc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x174c>
180003c5c:     	xorpd	%xmm2, %xmm2
180003c60:     	addsd	%xmm2, %xmm1
180003c64:     	movq	0x10(%r9,%r14,8), %rdx
180003c69:     	movsd	0x10(%r8,%rdx,8), %xmm2
180003c70:     	mulsd	0x8(%r8,%r14,8), %xmm2
180003c77:     	addsd	%xmm1, %xmm2
180003c7b:     	divsd	%xmm0, %xmm2
180003c7f:     	movsd	%xmm2, 0x10(%r8,%rax,8)
180003c86:     	movq	$0x0, 0x18(%r9,%rax,8)
180003c8f:     	movsd	%xmm0, 0x48(%r8,%r15,8)
180003c96:     	movq	$0x0, 0x50(%r9,%r15,8)
180003c9f:     	cmpb	$0x0, (%r13)
180003ca4:     	sete	%r12b
180003ca8:     	jmp	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003cad:     	movb	$0x1, (%r13)
180003cb2:     	movq	$0x895447, 0x18(%rbp)   # imm = 0x895447
180003cba:     	jmp	0x180003c9f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x172f>
180003cbc:     	movb	$0x1, (%r13)
180003cc1:     	movq	$0x895449, 0x18(%rbp)   # imm = 0x895449
180003cc9:     	jmp	0x180003c9f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x172f>
180003ccb:     	movq	0x38(%rsi,%r15,8), %rax
180003cd0:     	testq	%rax, %rax
180003cd3:     	js	0x180003cf7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1787>
180003cd5:     	movq	%rcx, 0x8(%rbp)
180003cd9:     	cmpq	0x10(%rbp), %rcx
180003cdd:     	jle	0x180003d09 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1799>
180003cdf:     	movq	0x168(%rsp), %rax
180003ce7:     	movb	$0x1, (%rax)
180003cea:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180003cf2:     	jmp	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
180003cf7:     	movb	$0x1, (%r13)
180003cfc:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180003d04:     	jmp	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
180003d09:     	movb	$0x0, 0x60(%rsp)
180003d0e:     	movq	%r14, 0x48(%rsp)
180003d13:     	movq	%rax, 0x40(%rsp)
180003d18:     	movq	%rbx, 0x30(%rsp)
180003d1d:     	movq	0x168(%rsp), %r13
180003d25:     	movq	%r13, 0x28(%rsp)
180003d2a:     	movq	%rbp, 0x20(%rsp)
180003d2f:     	movq	$-0x1, 0x50(%rsp)
180003d38:     	movq	$0x0, 0x38(%rsp)
180003d41:     	leaq	0x60(%rsp), %rcx
180003d46:     	movq	0x68(%rsp), %r8
180003d4b:     	movq	%rsi, %r9
180003d4e:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180003d53:     	cmpb	$0x0, (%r13)
180003d58:     	jne	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
180003d5e:     	movq	0x8(%rbp), %rax
180003d62:     	leaq	-0x1(%rax), %rcx
180003d66:     	cmpb	$0x0, 0x60(%rsp)
180003d6b:     	movq	%rcx, 0x8(%rbp)
180003d6f:     	movq	%rdi, %rcx
180003d72:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003d78:     	movq	0x40(%rsi,%r15,8), %rcx
180003d7d:     	testq	%rcx, %rcx
180003d80:     	js	0x180003d8c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x181c>
180003d82:     	movq	%rax, 0x8(%rbp)
180003d86:     	cmpq	0x10(%rbp), %rax
180003d8a:     	jle	0x180003de0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1870>
180003d8c:     	movq	0x168(%rsp), %rax
180003d94:     	movb	$0x1, (%rax)
180003d97:     	movq	$0x2dc6d0, 0x18(%rbp)   # imm = 0x2DC6D0
180003d9f:     	jmp	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
180003da4:     	movq	%rax, (%rbp)
180003da8:     	movq	0x168(%rsp), %rax
180003db0:     	cmpb	$0x0, (%rax)
180003db3:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003db5:     	subsd	%xmm3, %xmm2
180003db9:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
180003dbf:     	movsd	%xmm5, 0x18(%rdi,%rcx,8)
180003dc5:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
180003dcb:     	movsd	%xmm0, (%rdi,%rcx,8)
180003dd0:     	cmpb	$0x0, (%rax)
180003dd3:     	je	0x180003e42 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x18d2>
180003dd5:     	xorl	%r12d, %r12d
180003dd8:     	movq	%r14, %rcx
180003ddb:     	jmp	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003de0:     	movb	$0x0, 0x5f(%rsp)
180003de5:     	movq	%r14, 0x48(%rsp)
180003dea:     	movq	%rcx, 0x40(%rsp)
180003def:     	movq	%rbx, 0x30(%rsp)
180003df4:     	movq	0x168(%rsp), %rbx
180003dfc:     	movq	%rbx, 0x28(%rsp)
180003e01:     	movq	%rbp, 0x20(%rsp)
180003e06:     	movq	$-0x1, 0x50(%rsp)
180003e0f:     	movq	$0x0, 0x38(%rsp)
180003e18:     	leaq	0x5f(%rsp), %rcx
180003e1d:     	movq	0x68(%rsp), %r8
180003e22:     	movq	%rsi, %r9
180003e25:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180003e2a:     	cmpb	$0x0, (%rbx)
180003e2d:     	jne	0x1800036ce <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x115e>
180003e33:     	movzbl	0x5f(%rsp), %r12d
180003e39:     	decq	0x8(%rbp)
180003e3d:     	jmp	0x180003833 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x12c3>
180003e42:     	movq	(%rbp), %rax
180003e46:     	leaq	0xb(%rax), %r8
180003e4a:     	cmpq	%rbx, %r8
180003e4d:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180003e53:     	movq	0x8(%rsi,%r15,8), %rdx
180003e58:     	movq	%r8, (%rbp)
180003e5c:     	movq	0x168(%rsp), %r8
180003e64:     	cmpb	$0x0, (%r8)
180003e68:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003e6e:     	movq	%rcx, (%rsi,%rax,8)
180003e72:     	movq	%rdx, 0x8(%rsi,%rax,8)
180003e77:     	movq	(%rbp), %rdx
180003e7b:     	cmpq	%rbx, %rdx
180003e7e:     	movq	%rdx, %rcx
180003e81:     	jle	0x180003e94 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1924>
180003e83:     	movq	0x168(%rsp), %rcx
180003e8b:     	movb	$0x2, (%rcx)
180003e8e:     	movq	(%rbp), %rdx
180003e92:     	xorl	%ecx, %ecx
180003e94:     	leaq	0x3(%rdx), %r8
180003e98:     	cmpq	%rbx, %r8
180003e9b:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180003ea1:     	movq	%r8, (%rbp)
180003ea5:     	movq	0x168(%rsp), %r8
180003ead:     	cmpb	$0x0, (%r8)
180003eb1:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003eb7:     	movq	%rdx, %r9
180003eba:     	sarq	$0x3f, %r9
180003ebe:     	andq	%rbx, %r9
180003ec1:     	leaq	(%rsi,%rdx,8), %r10
180003ec5:     	movq	$0x0, (%r10,%r9,8)
180003ecd:     	xorl	%r12d, %r12d
180003ed0:     	cmpq	$-0x1, %rdx
180003ed4:     	movl	$0x0, %r9d
180003eda:     	cmovlq	%rbx, %r9
180003ede:     	movq	$0x0, 0x8(%r10,%r9,8)
180003ee7:     	cmpq	$-0x2, %rdx
180003eeb:     	movl	$0x0, %r9d
180003ef1:     	cmovlq	%rbx, %r9
180003ef5:     	movq	%rcx, 0x10(%r10,%r9,8)
180003efa:     	movq	0x168(%rsp), %rcx
180003f02:     	cmpb	$0x0, (%rcx)
180003f05:     	movq	%r14, %rcx
180003f08:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180003f0e:     	leaq	(%rsi,%rax,8), %rcx
180003f12:     	movq	%rdx, 0x30(%rcx)
180003f16:     	movq	$0x0, 0x18(%rcx)
180003f1e:     	movq	(%rbp), %rdx
180003f22:     	leaq	0x4(%rdx), %r8
180003f26:     	cmpq	%rbx, %r8
180003f29:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180003f2f:     	movq	%r8, (%rbp)
180003f33:     	movq	0x168(%rsp), %r8
180003f3b:     	cmpb	$0x0, (%r8)
180003f3f:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003f45:     	movq	$0x0, (%rdi,%rdx,8)
180003f4d:     	movq	$0x1, 0x8(%rsi,%rdx,8)
180003f56:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180003f5f:     	movq	$0x1, 0x18(%rsi,%rdx,8)
180003f68:     	cmpb	$0x0, (%r8)
180003f6c:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003f72:     	movq	%rdx, 0x10(%rcx)
180003f76:     	movq	$0x0, 0x48(%rdi,%rax,8)
180003f7f:     	movq	$0x1, 0x50(%rcx)
180003f87:     	movq	$-0x1, 0x20(%rcx)
180003f8f:     	movq	$-0x1, 0x28(%rcx)
180003f97:     	movq	$-0x1, 0x38(%rcx)
180003f9f:     	movq	$-0x1, 0x40(%rcx)
180003fa7:     	movq	0x168(%rsp), %rcx
180003faf:     	cmpb	$0x0, (%rcx)
180003fb2:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003fb8:     	movq	%rax, 0x28(%rsi,%r15,8)
180003fbd:     	movq	(%rbp), %rcx
180003fc1:     	leaq	0x4(%rcx), %rax
180003fc5:     	cmpq	%rbx, %rax
180003fc8:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180003fce:     	movq	%rax, (%rbp)
180003fd2:     	movq	0x168(%rsp), %rax
180003fda:     	cmpb	$0x0, (%rax)
180003fdd:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180003fe3:     	addsd	%xmm0, %xmm1
180003fe7:     	movsd	%xmm4, 0x10(%rdi,%rcx,8)
180003fed:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
180003ff3:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
180003ff9:     	movsd	%xmm0, (%rdi,%rcx,8)
180003ffe:     	cmpb	$0x0, (%rax)
180004001:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004007:     	movq	(%rbp), %rax
18000400b:     	leaq	0xb(%rax), %r8
18000400f:     	cmpq	%rbx, %r8
180004012:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180004018:     	movq	0x8(%rsi,%r15,8), %rdx
18000401d:     	movq	%r8, (%rbp)
180004021:     	movq	0x168(%rsp), %r8
180004029:     	cmpb	$0x0, (%r8)
18000402d:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004033:     	movq	%rcx, (%rsi,%rax,8)
180004037:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000403c:     	movq	(%rbp), %rdx
180004040:     	cmpq	%rbx, %rdx
180004043:     	movq	%rdx, %rcx
180004046:     	jle	0x180004059 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1ae9>
180004048:     	movq	0x168(%rsp), %rcx
180004050:     	movb	$0x2, (%rcx)
180004053:     	movq	(%rbp), %rdx
180004057:     	xorl	%ecx, %ecx
180004059:     	leaq	0x3(%rdx), %r8
18000405d:     	cmpq	%rbx, %r8
180004060:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180004066:     	movq	%r8, (%rbp)
18000406a:     	movq	0x168(%rsp), %r8
180004072:     	cmpb	$0x0, (%r8)
180004076:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000407c:     	movq	%rdx, %r9
18000407f:     	sarq	$0x3f, %r9
180004083:     	andq	%rbx, %r9
180004086:     	leaq	(%rsi,%rdx,8), %r10
18000408a:     	movq	$0x0, (%r10,%r9,8)
180004092:     	xorl	%r12d, %r12d
180004095:     	cmpq	$-0x1, %rdx
180004099:     	movl	$0x0, %r9d
18000409f:     	cmovlq	%rbx, %r9
1800040a3:     	movq	$0x0, 0x8(%r10,%r9,8)
1800040ac:     	cmpq	$-0x2, %rdx
1800040b0:     	movl	$0x0, %r9d
1800040b6:     	cmovlq	%rbx, %r9
1800040ba:     	movq	%rcx, 0x10(%r10,%r9,8)
1800040bf:     	movq	0x168(%rsp), %rcx
1800040c7:     	cmpb	$0x0, (%rcx)
1800040ca:     	movq	%r14, %rcx
1800040cd:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
1800040d3:     	leaq	(%rsi,%rax,8), %rcx
1800040d7:     	movq	%rdx, 0x30(%rcx)
1800040db:     	movq	$0x0, 0x18(%rcx)
1800040e3:     	movq	(%rbp), %rdx
1800040e7:     	leaq	0x4(%rdx), %r8
1800040eb:     	cmpq	%rbx, %r8
1800040ee:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
1800040f4:     	movq	%r8, (%rbp)
1800040f8:     	movq	0x168(%rsp), %r8
180004100:     	cmpb	$0x0, (%r8)
180004104:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000410a:     	movq	$0x0, (%rdi,%rdx,8)
180004112:     	movq	$0x1, 0x8(%rsi,%rdx,8)
18000411b:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180004124:     	movq	$0x1, 0x18(%rsi,%rdx,8)
18000412d:     	cmpb	$0x0, (%r8)
180004131:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004137:     	movq	%rdx, 0x10(%rcx)
18000413b:     	movq	$0x0, 0x48(%rdi,%rax,8)
180004144:     	movq	$0x1, 0x50(%rcx)
18000414c:     	movq	$-0x1, 0x20(%rcx)
180004154:     	movq	$-0x1, 0x28(%rcx)
18000415c:     	movq	$-0x1, 0x38(%rcx)
180004164:     	movq	$-0x1, 0x40(%rcx)
18000416c:     	movq	0x168(%rsp), %rcx
180004174:     	cmpb	$0x0, (%rcx)
180004177:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000417d:     	movq	%rax, 0x38(%rsi,%r15,8)
180004182:     	movq	(%rbp), %rcx
180004186:     	leaq	0x4(%rcx), %rax
18000418a:     	cmpq	%rbx, %rax
18000418d:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180004193:     	movq	%rax, (%rbp)
180004197:     	movq	0x168(%rsp), %rax
18000419f:     	cmpb	$0x0, (%rax)
1800041a2:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800041a8:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
1800041ae:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
1800041b4:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800041ba:     	movsd	%xmm0, (%rdi,%rcx,8)
1800041bf:     	cmpb	$0x0, (%rax)
1800041c2:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800041c8:     	movq	(%rbp), %rax
1800041cc:     	leaq	0xb(%rax), %r8
1800041d0:     	cmpq	%rbx, %r8
1800041d3:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
1800041d9:     	movq	0x8(%rsi,%r15,8), %rdx
1800041de:     	movq	%r8, (%rbp)
1800041e2:     	movq	0x168(%rsp), %r8
1800041ea:     	cmpb	$0x0, (%r8)
1800041ee:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800041f4:     	movq	%rcx, (%rsi,%rax,8)
1800041f8:     	movq	%rdx, 0x8(%rsi,%rax,8)
1800041fd:     	movq	(%rbp), %rdx
180004201:     	cmpq	%rbx, %rdx
180004204:     	movq	%rdx, %rcx
180004207:     	jle	0x18000421a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1caa>
180004209:     	movq	0x168(%rsp), %rcx
180004211:     	movb	$0x2, (%rcx)
180004214:     	movq	(%rbp), %rdx
180004218:     	xorl	%ecx, %ecx
18000421a:     	leaq	0x3(%rdx), %r8
18000421e:     	cmpq	%rbx, %r8
180004221:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
180004227:     	movq	%r8, (%rbp)
18000422b:     	movq	0x168(%rsp), %r8
180004233:     	cmpb	$0x0, (%r8)
180004237:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000423d:     	movq	%rdx, %r9
180004240:     	sarq	$0x3f, %r9
180004244:     	andq	%rbx, %r9
180004247:     	leaq	(%rsi,%rdx,8), %r10
18000424b:     	movq	$0x0, (%r10,%r9,8)
180004253:     	xorl	%r12d, %r12d
180004256:     	cmpq	$-0x1, %rdx
18000425a:     	movl	$0x0, %r9d
180004260:     	cmovlq	%rbx, %r9
180004264:     	movq	$0x0, 0x8(%r10,%r9,8)
18000426d:     	cmpq	$-0x2, %rdx
180004271:     	movl	$0x0, %r9d
180004277:     	cmovlq	%rbx, %r9
18000427b:     	movq	%rcx, 0x10(%r10,%r9,8)
180004280:     	movq	0x168(%rsp), %rcx
180004288:     	cmpb	$0x0, (%rcx)
18000428b:     	movq	%r14, %rcx
18000428e:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180004294:     	leaq	(%rsi,%rax,8), %rcx
180004298:     	movq	%rdx, 0x30(%rcx)
18000429c:     	movq	$0x0, 0x18(%rcx)
1800042a4:     	movq	(%rbp), %rdx
1800042a8:     	leaq	0x4(%rdx), %r8
1800042ac:     	cmpq	%rbx, %r8
1800042af:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
1800042b5:     	movq	%r8, (%rbp)
1800042b9:     	movq	0x168(%rsp), %r8
1800042c1:     	cmpb	$0x0, (%r8)
1800042c5:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800042cb:     	movq	$0x0, (%rdi,%rdx,8)
1800042d3:     	movq	$0x1, 0x8(%rsi,%rdx,8)
1800042dc:     	movq	$0x0, 0x10(%rdi,%rdx,8)
1800042e5:     	movq	$0x1, 0x18(%rsi,%rdx,8)
1800042ee:     	cmpb	$0x0, (%r8)
1800042f2:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800042f8:     	movq	%rdx, 0x10(%rcx)
1800042fc:     	movq	$0x0, 0x48(%rdi,%rax,8)
180004305:     	movq	$0x1, 0x50(%rcx)
18000430d:     	movq	$-0x1, 0x20(%rcx)
180004315:     	movq	$-0x1, 0x28(%rcx)
18000431d:     	movq	$-0x1, 0x38(%rcx)
180004325:     	movq	$-0x1, 0x40(%rcx)
18000432d:     	movq	0x168(%rsp), %rcx
180004335:     	cmpb	$0x0, (%rcx)
180004338:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000433e:     	movq	%rax, 0x40(%rsi,%r15,8)
180004343:     	movq	$0x1, 0x18(%rsi,%r15,8)
18000434c:     	movq	0x30(%rsi,%r15,8), %rax
180004351:     	movq	%rax, %rdx
180004354:     	sarq	$0x3f, %rdx
180004358:     	andq	%rbx, %rdx
18000435b:     	leaq	(%rsi,%rax,8), %rcx
18000435f:     	movq	%rdx, 0x88(%rsp)
180004367:     	movq	%rcx, 0x78(%rsp)
18000436c:     	cmpq	$0x0, (%rcx,%rdx,8)
180004371:     	jle	0x1800045c1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2051>
180004377:     	leaq	(,%rbx,8), %rcx
18000437f:     	xorl	%r12d, %r12d
180004382:     	cmpq	$-0x2, %rax
180004386:     	cmovgeq	%r12, %rcx
18000438a:     	movq	%rcx, 0x80(%rsp)
180004392:     	movq	0x20(%rsi,%r15,8), %rax
180004397:     	testq	%rax, %rax
18000439a:     	js	0x18000465a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x20ea>
1800043a0:     	movq	0x78(%rsp), %rcx
1800043a5:     	movq	0x80(%rsp), %rdx
1800043ad:     	movq	0x10(%rcx,%rdx), %rcx
1800043b2:     	addq	%r12, %rcx
1800043b5:     	leaq	(%rsi,%rcx,8), %rdx
1800043b9:     	sarq	$0x3f, %rcx
1800043bd:     	andq	%rbx, %rcx
1800043c0:     	movq	(%rdx,%rcx,8), %rcx
1800043c4:     	movq	%rcx, 0x68(%rsp)
1800043c9:     	movq	0x8(%rbp), %rcx
1800043cd:     	leaq	0x1(%rcx), %rdx
1800043d1:     	movq	%rdx, 0x8(%rbp)
1800043d5:     	cmpq	0x10(%rbp), %rcx
1800043d9:     	jge	0x18000465a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x20ea>
1800043df:     	movq	0x68(%rsp), %rcx
1800043e4:     	movq	%rcx, 0x48(%rsp)
1800043e9:     	movq	%rax, 0x40(%rsp)
1800043ee:     	movq	%rbx, 0x30(%rsp)
1800043f3:     	movq	0x168(%rsp), %r13
1800043fb:     	movq	%r13, 0x28(%rsp)
180004400:     	movq	%rbp, 0x20(%rsp)
180004405:     	movq	$-0x1, 0x50(%rsp)
18000440e:     	movq	$0x0, 0x38(%rsp)
180004417:     	leaq	0x66(%rsp), %rcx
18000441c:     	movq	%rdi, %r8
18000441f:     	movq	%rsi, %r9
180004422:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180004427:     	cmpb	$0x0, (%r13)
18000442c:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004432:     	movq	0x8(%rbp), %rcx
180004436:     	leaq	-0x1(%rcx), %rax
18000443a:     	movq	%rax, 0x8(%rbp)
18000443e:     	movq	0x28(%rsi,%r15,8), %rax
180004443:     	testq	%rax, %rax
180004446:     	js	0x180004672 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2102>
18000444c:     	movq	%rcx, 0x8(%rbp)
180004450:     	cmpq	0x10(%rbp), %rcx
180004454:     	jg	0x180004672 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2102>
18000445a:     	movq	0x68(%rsp), %rcx
18000445f:     	movq	%rcx, 0x48(%rsp)
180004464:     	movq	%rax, 0x40(%rsp)
180004469:     	movq	%rbx, 0x30(%rsp)
18000446e:     	movq	0x168(%rsp), %r13
180004476:     	movq	%r13, 0x28(%rsp)
18000447b:     	movq	%rbp, 0x20(%rsp)
180004480:     	movq	$-0x1, 0x50(%rsp)
180004489:     	movq	$0x0, 0x38(%rsp)
180004492:     	leaq	0x65(%rsp), %rcx
180004497:     	movq	%rdi, %r8
18000449a:     	movq	%rsi, %r9
18000449d:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
1800044a2:     	cmpb	$0x0, (%r13)
1800044a7:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800044ad:     	movq	0x8(%rbp), %rcx
1800044b1:     	leaq	-0x1(%rcx), %rax
1800044b5:     	movq	%rax, 0x8(%rbp)
1800044b9:     	movq	0x38(%rsi,%r15,8), %rax
1800044be:     	testq	%rax, %rax
1800044c1:     	js	0x18000468a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x211a>
1800044c7:     	movq	%rcx, 0x8(%rbp)
1800044cb:     	cmpq	0x10(%rbp), %rcx
1800044cf:     	jg	0x18000468a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x211a>
1800044d5:     	movq	0x68(%rsp), %rcx
1800044da:     	movq	%rcx, 0x48(%rsp)
1800044df:     	movq	%rax, 0x40(%rsp)
1800044e4:     	movq	%rbx, 0x30(%rsp)
1800044e9:     	movq	0x168(%rsp), %r13
1800044f1:     	movq	%r13, 0x28(%rsp)
1800044f6:     	movq	%rbp, 0x20(%rsp)
1800044fb:     	movq	$-0x1, 0x50(%rsp)
180004504:     	movq	$0x0, 0x38(%rsp)
18000450d:     	leaq	0x64(%rsp), %rcx
180004512:     	movq	%rdi, %r8
180004515:     	movq	%rsi, %r9
180004518:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
18000451d:     	cmpb	$0x0, (%r13)
180004522:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004528:     	movq	0x8(%rbp), %rcx
18000452c:     	leaq	-0x1(%rcx), %rax
180004530:     	movq	%rax, 0x8(%rbp)
180004534:     	movq	0x40(%rsi,%r15,8), %rax
180004539:     	testq	%rax, %rax
18000453c:     	js	0x1800046a2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2132>
180004542:     	movq	%rcx, 0x8(%rbp)
180004546:     	cmpq	0x10(%rbp), %rcx
18000454a:     	jg	0x1800046a2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2132>
180004550:     	movq	0x68(%rsp), %rcx
180004555:     	movq	%rcx, 0x48(%rsp)
18000455a:     	movq	%rax, 0x40(%rsp)
18000455f:     	movq	%rbx, 0x30(%rsp)
180004564:     	movq	0x168(%rsp), %r13
18000456c:     	movq	%r13, 0x28(%rsp)
180004571:     	movq	%rbp, 0x20(%rsp)
180004576:     	movq	$-0x1, 0x50(%rsp)
18000457f:     	movq	$0x0, 0x38(%rsp)
180004588:     	leaq	0x63(%rsp), %rcx
18000458d:     	movq	%rdi, %r8
180004590:     	movq	%rsi, %r9
180004593:     	callq	0x180003260 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0xcf0>
180004598:     	cmpb	$0x0, (%r13)
18000459d:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800045a3:     	incq	%r12
1800045a6:     	decq	0x8(%rbp)
1800045aa:     	movq	0x88(%rsp), %rax
1800045b2:     	movq	0x78(%rsp), %rcx
1800045b7:     	cmpq	(%rcx,%rax,8), %r12
1800045bb:     	jl	0x180004392 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1e22>
1800045c1:     	movq	(%rbp), %rax
1800045c5:     	cmpq	%rbx, %rax
1800045c8:     	movq	%rax, %rcx
1800045cb:     	jle	0x1800045de <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x206e>
1800045cd:     	movq	0x168(%rsp), %rax
1800045d5:     	movb	$0x2, (%rax)
1800045d8:     	movq	(%rbp), %rax
1800045dc:     	xorl	%ecx, %ecx
1800045de:     	leaq	0x3(%rax), %rdx
1800045e2:     	cmpq	%rbx, %rdx
1800045e5:     	jg	0x180003649 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x10d9>
1800045eb:     	movq	%rdx, (%rbp)
1800045ef:     	movq	0x168(%rsp), %rdx
1800045f7:     	cmpb	$0x0, (%rdx)
1800045fa:     	jne	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004600:     	movq	%rax, %rdx
180004603:     	sarq	$0x3f, %rdx
180004607:     	andq	%rbx, %rdx
18000460a:     	leaq	(%rsi,%rax,8), %r8
18000460e:     	movq	$0x0, (%r8,%rdx,8)
180004616:     	xorl	%r12d, %r12d
180004619:     	cmpq	$-0x1, %rax
18000461d:     	movl	$0x0, %edx
180004622:     	cmovlq	%rbx, %rdx
180004626:     	movq	$0x0, 0x8(%r8,%rdx,8)
18000462f:     	cmpq	$-0x2, %rax
180004633:     	cmovgeq	%r12, %rbx
180004637:     	movq	%rcx, 0x10(%r8,%rbx,8)
18000463c:     	movq	0x168(%rsp), %rcx
180004644:     	cmpb	$0x0, (%rcx)
180004647:     	movq	%r14, %rcx
18000464a:     	jne	0x1800037b2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1242>
180004650:     	movq	%rax, 0x30(%rsi,%r15,8)
180004655:     	jmp	0x1800037af <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x123f>
18000465a:     	movq	0x168(%rsp), %rax
180004662:     	movb	$0x1, (%rax)
180004665:     	movq	$0x989697, 0x18(%rbp)   # imm = 0x989697
18000466d:     	jmp	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
180004672:     	movq	0x168(%rsp), %rax
18000467a:     	movb	$0x1, (%rax)
18000467d:     	movq	$0x989698, 0x18(%rbp)   # imm = 0x989698
180004685:     	jmp	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
18000468a:     	movq	0x168(%rsp), %rax
180004692:     	movb	$0x1, (%rax)
180004695:     	movq	$0x989699, 0x18(%rbp)   # imm = 0x989699
18000469d:     	jmp	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800046a2:     	movq	0x168(%rsp), %rax
1800046aa:     	movb	$0x1, (%rax)
1800046ad:     	movq	$0x98969a, 0x18(%rbp)   # imm = 0x98969A
1800046b5:     	jmp	0x180003dd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x1865>
1800046ba:     	nopw	(%rax,%rax)
1800046c0:     	pushq	%r15
1800046c2:     	pushq	%r14
1800046c4:     	pushq	%r13
1800046c6:     	pushq	%r12
1800046c8:     	pushq	%rsi
1800046c9:     	pushq	%rdi
1800046ca:     	pushq	%rbp
1800046cb:     	pushq	%rbx
1800046cc:     	subq	$0xe8, %rsp
1800046d3:     	movapd	%xmm7, 0xd0(%rsp)
1800046dc:     	movaps	%xmm6, 0xc0(%rsp)
1800046e4:     	movq	0x180(%rsp), %r10
1800046ec:     	movq	0x158(%rsp), %r12
1800046f4:     	movq	0x150(%rsp), %r15
1800046fc:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180004706:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
180004710:     	movq	$0x0, 0xa0(%rsp)
18000471c:     	movb	$0x0, 0xa8(%rsp)
180004724:     	movq	$0x0, 0xb0(%rsp)
180004730:     	movb	$0x0, 0xb8(%rsp)
180004738:     	movq	$0x0, 0x98(%rsp)
180004744:     	movb	$0x0, 0x67(%rsp)
180004749:     	movq	$0x0, 0x90(%rsp)
180004755:     	leaq	(%r10,%rax), %r11
180004759:     	cmpq	%rsi, %r11
18000475c:     	jb	0x18000476e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x21fe>
18000475e:     	movq	0x188(%rsp), %r11
180004766:     	addq	%r11, %rax
180004769:     	cmpq	%rsi, %rax
18000476c:     	jae	0x1800047a8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2238>
18000476e:     	movb	$0x1, (%r12)
180004773:     	movq	$0x4, 0x18(%r15)
18000477b:     	movq	$0x0, (%rcx)
180004782:     	xorl	%eax, %eax
180004784:     	movaps	0xc0(%rsp), %xmm6
18000478c:     	movaps	0xd0(%rsp), %xmm7
180004794:     	addq	$0xe8, %rsp
18000479b:     	popq	%rbx
18000479c:     	popq	%rbp
18000479d:     	popq	%rdi
18000479e:     	popq	%rsi
18000479f:     	popq	%r12
1800047a1:     	popq	%r13
1800047a3:     	popq	%r14
1800047a5:     	popq	%r15
1800047a7:     	retq
1800047a8:     	movq	0x160(%rsp), %r13
1800047b0:     	movq	(%r15), %rax
1800047b3:     	leaq	0x4(%rax), %rsi
1800047b7:     	cmpq	%r13, %rsi
1800047ba:     	jle	0x1800047c3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2253>
1800047bc:     	movb	$0x2, (%r12)
1800047c1:     	jmp	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
1800047c3:     	movq	%rsi, (%r15)
1800047c6:     	cmpb	$0x0, (%r12)
1800047cb:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
1800047cd:     	testq	%rax, %rax
1800047d0:     	js	0x180004814 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x22a4>
1800047d2:     	cvtsi2sd	%r11, %xmm0
1800047d7:     	movsd	0x5bd1(%rip), %xmm1     # 0x18000a3b0
1800047df:     	mulsd	%xmm1, %xmm0
1800047e3:     	cvtsi2sd	%r10, %xmm2
1800047e8:     	mulsd	%xmm1, %xmm2
1800047ec:     	movsd	%xmm2, 0x10(%r8,%rax,8)
1800047f3:     	movsd	%xmm0, 0x18(%r8,%rax,8)
1800047fa:     	movsd	%xmm2, 0x8(%r8,%rax,8)
180004801:     	movsd	%xmm0, (%r8,%rax,8)
180004807:     	cmpb	$0x0, (%r12)
18000480c:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
180004812:     	jmp	0x18000482c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x22bc>
180004814:     	movb	$0x1, (%r12)
180004819:     	movq	$0xf4242, 0x18(%r15)    # imm = 0xF4242
180004821:     	cmpb	$0x0, (%r12)
180004826:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
18000482c:     	movq	(%r15), %rbp
18000482f:     	leaq	0xb(%rbp), %r10
180004833:     	cmpq	%r13, %r10
180004836:     	jg	0x1800047bc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x224c>
180004838:     	movq	%r10, (%r15)
18000483b:     	cmpb	$0x0, (%r12)
180004840:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
180004846:     	movq	%rax, (%r9,%rbp,8)
18000484a:     	movq	$0x4, 0x8(%r9,%rbp,8)
180004853:     	movq	(%r15), %r10
180004856:     	cmpq	%r13, %r10
180004859:     	movq	%r10, %rax
18000485c:     	jle	0x180004868 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x22f8>
18000485e:     	movb	$0x2, (%r12)
180004863:     	movq	(%r15), %r10
180004866:     	xorl	%eax, %eax
180004868:     	leaq	0x3(%r10), %r11
18000486c:     	cmpq	%r13, %r11
18000486f:     	jg	0x1800047bc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x224c>
180004875:     	movq	%r11, (%r15)
180004878:     	cmpb	$0x0, (%r12)
18000487d:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
180004883:     	movq	%r10, %r11
180004886:     	sarq	$0x3f, %r11
18000488a:     	andq	%r13, %r11
18000488d:     	leaq	(%r9,%r10,8), %rsi
180004891:     	movq	$0x0, (%rsi,%r11,8)
180004899:     	xorl	%r11d, %r11d
18000489c:     	cmpq	$-0x1, %r10
1800048a0:     	movl	$0x0, %edi
1800048a5:     	cmovlq	%r13, %rdi
1800048a9:     	movq	$0x0, 0x8(%rsi,%rdi,8)
1800048b2:     	cmpq	$-0x2, %r10
1800048b6:     	cmovlq	%r13, %r11
1800048ba:     	movq	%rax, 0x10(%rsi,%r11,8)
1800048bf:     	cmpb	$0x0, (%r12)
1800048c4:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
1800048ca:     	leaq	(%r9,%rbp,8), %rax
1800048ce:     	movq	%r10, 0x30(%rax)
1800048d2:     	movq	$0x0, 0x18(%rax)
1800048da:     	movq	(%r15), %r10
1800048dd:     	leaq	0x4(%r10), %r11
1800048e1:     	cmpq	%r13, %r11
1800048e4:     	jg	0x1800047bc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x224c>
1800048ea:     	movq	%r11, (%r15)
1800048ed:     	cmpb	$0x0, (%r12)
1800048f2:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
1800048f8:     	movq	%rdx, 0x88(%rsp)
180004900:     	movq	%r8, %rdi
180004903:     	movq	%r9, %rsi
180004906:     	movq	%rcx, 0x68(%rsp)
18000490b:     	testq	%r10, %r10
18000490e:     	js	0x180004935 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x23c5>
180004910:     	movq	$0x0, (%rdi,%r10,8)
180004918:     	leaq	(%rsi,%r10,8), %rcx
18000491c:     	movq	$0x1, 0x8(%rsi,%r10,8)
180004925:     	movq	$0x0, 0x10(%rdi,%r10,8)
18000492e:     	movl	$0x1, %edx
180004933:     	jmp	0x180004942 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x23d2>
180004935:     	movb	$0x1, (%r12)
18000493a:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
18000493f:     	movq	%r15, %rcx
180004942:     	movq	%rdx, 0x18(%rcx)
180004946:     	cmpb	$0x0, (%r12)
18000494b:     	movq	0x68(%rsp), %rcx
180004950:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
180004956:     	movq	%r10, 0x10(%rax)
18000495a:     	movq	$0x0, 0x48(%rdi,%rbp,8)
180004963:     	movq	$0x1, 0x50(%rax)
18000496b:     	movq	$-0x1, 0x20(%rax)
180004973:     	movq	$-0x1, 0x28(%rax)
18000497b:     	movq	$-0x1, 0x38(%rax)
180004983:     	movq	$-0x1, 0x40(%rax)
18000498b:     	cmpb	$0x0, (%r12)
180004990:     	jne	0x18000477b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x220b>
180004996:     	movq	0x168(%rsp), %rax
18000499e:     	movq	%rax, %rcx
1800049a1:     	sarq	$0x3f, %rcx
1800049a5:     	andq	%r13, %rcx
1800049a8:     	leaq	(%rsi,%rax,8), %rdx
1800049ac:     	xorl	%r8d, %r8d
1800049af:     	cmpq	$-0x2, %rax
1800049b3:     	cmovlq	%r13, %r8
1800049b7:     	movq	%r8, 0x80(%rsp)
1800049bf:     	movq	%rcx, 0x78(%rsp)
1800049c4:     	movq	%rdx, 0x70(%rsp)
1800049c9:     	cmpq	$0x0, (%rdx,%rcx,8)
1800049ce:     	jle	0x180004aa5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2535>
1800049d4:     	testq	%rbp, %rbp
1800049d7:     	js	0x180004c14 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26a4>
1800049dd:     	movq	0x8(%r15), %rax
1800049e1:     	shlq	$0x3, 0x80(%rsp)
1800049ea:     	shlq	$0x3, 0x78(%rsp)
1800049f0:     	xorl	%ebx, %ebx
1800049f2:     	leaq	0x67(%rsp), %r14
1800049f7:     	movq	0x70(%rsp), %rcx
1800049fc:     	movq	0x80(%rsp), %rdx
180004a04:     	movq	0x10(%rcx,%rdx), %rcx
180004a09:     	addq	%rbx, %rcx
180004a0c:     	leaq	(%rsi,%rcx,8), %rdx
180004a10:     	sarq	$0x3f, %rcx
180004a14:     	andq	%r13, %rcx
180004a17:     	movq	(%rdx,%rcx,8), %rcx
180004a1b:     	leaq	0x1(%rax), %rdx
180004a1f:     	movq	%rdx, 0x8(%r15)
180004a23:     	cmpq	0x10(%r15), %rax
180004a27:     	jge	0x180004c14 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26a4>
180004a2d:     	movq	%rcx, 0x48(%rsp)
180004a32:     	movq	%rbp, 0x40(%rsp)
180004a37:     	movq	%r13, 0x30(%rsp)
180004a3c:     	movq	%r12, 0x28(%rsp)
180004a41:     	movq	%r15, 0x20(%rsp)
180004a46:     	movq	$-0x1, 0x50(%rsp)
180004a4f:     	movq	$0x0, 0x38(%rsp)
180004a58:     	movq	%r14, %rcx
180004a5b:     	leaq	0x90(%rsp), %rdx
180004a63:     	movq	%rdi, %r8
180004a66:     	movq	%rsi, %r9
180004a69:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180004a6e:     	testl	%eax, %eax
180004a70:     	jne	0x180004df5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2885>
180004a76:     	cmpb	$0x0, (%r12)
180004a7b:     	jne	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004a81:     	incq	%rbx
180004a84:     	movq	0x8(%r15), %rax
180004a88:     	decq	%rax
180004a8b:     	movq	%rax, 0x8(%r15)
180004a8f:     	movq	0x78(%rsp), %rcx
180004a94:     	movq	0x70(%rsp), %rdx
180004a99:     	cmpq	(%rdx,%rcx), %rbx
180004a9d:     	jl	0x1800049f7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2487>
180004aa3:     	jmp	0x180004abd <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x254d>
180004aa5:     	shlq	$0x3, 0x78(%rsp)
180004aab:     	shlq	$0x3, 0x80(%rsp)
180004ab4:     	testq	%rbp, %rbp
180004ab7:     	js	0x180004c32 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26c2>
180004abd:     	movsd	0x170(%rsp), %xmm6
180004ac6:     	xorl	%ebx, %ebx
180004ac8:     	xorpd	%xmm7, %xmm7
180004acc:     	movq	0x78(%rsp), %rax
180004ad1:     	movq	0x70(%rsp), %rcx
180004ad6:     	cmpq	(%rcx,%rax), %rbx
180004ada:     	jge	0x180004c32 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26c2>
180004ae0:     	movq	0x70(%rsp), %rax
180004ae5:     	movq	0x80(%rsp), %rcx
180004aed:     	movq	0x10(%rax,%rcx), %rax
180004af2:     	addq	%rbx, %rax
180004af5:     	leaq	(%rsi,%rax,8), %rcx
180004af9:     	sarq	$0x3f, %rax
180004afd:     	andq	%r13, %rax
180004b00:     	movq	(%rcx,%rax,8), %r14
180004b04:     	movq	0x8(%r15), %rax
180004b08:     	leaq	0x1(%rax), %rcx
180004b0c:     	movq	%rcx, 0x8(%r15)
180004b10:     	cmpq	0x10(%r15), %rax
180004b14:     	jge	0x180004e1f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28af>
180004b1a:     	movsd	%xmm6, 0x48(%rsp)
180004b20:     	movq	%r14, 0x40(%rsp)
180004b25:     	movq	%rbp, 0x38(%rsp)
180004b2a:     	movq	%r13, 0x30(%rsp)
180004b2f:     	movq	%r12, 0x28(%rsp)
180004b34:     	movq	%r15, 0x20(%rsp)
180004b39:     	leaq	0xa0(%rsp), %rcx
180004b41:     	leaq	0x98(%rsp), %rdx
180004b49:     	movq	%rdi, %r8
180004b4c:     	movq	%rsi, %r9
180004b4f:     	callq	0x180004e60 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28f0>
180004b54:     	testl	%eax, %eax
180004b56:     	jne	0x180004e43 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28d3>
180004b5c:     	cmpb	$0x0, (%r12)
180004b61:     	jne	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004b67:     	movsd	0xa0(%rsp), %xmm1
180004b70:     	movsd	0xb0(%rsp), %xmm0
180004b79:     	decq	0x8(%r15)
180004b7d:     	testq	%r14, %r14
180004b80:     	js	0x180004e31 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28c1>
180004b86:     	movq	(%rsi,%r14,8), %rax
180004b8a:     	testq	%rax, %rax
180004b8d:     	js	0x180004b9e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x262e>
180004b8f:     	movsd	0x8(%rdi,%r14,8), %xmm2
180004b96:     	ucomisd	%xmm7, %xmm2
180004b9a:     	jne	0x180004bbb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x264b>
180004b9c:     	jp	0x180004bbb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x264b>
180004b9e:     	movb	$0x1, (%r12)
180004ba3:     	movq	$0x4c4b43, 0x18(%r15)   # imm = 0x4C4B43
180004bab:     	incq	%rbx
180004bae:     	cmpb	$0x0, (%r12)
180004bb3:     	je	0x180004acc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x255c>
180004bb9:     	jmp	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004bbb:     	divsd	%xmm2, %xmm1
180004bbf:     	addsd	(%rdi,%rax,8), %xmm1
180004bc4:     	movsd	%xmm1, (%rdi,%rax,8)
180004bc9:     	movq	$0x0, 0x8(%rsi,%rax,8)
180004bd2:     	movq	(%rsi,%r14,8), %rax
180004bd6:     	testq	%rax, %rax
180004bd9:     	js	0x180004bea <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x267a>
180004bdb:     	movsd	0x8(%rdi,%r14,8), %xmm1
180004be2:     	ucomisd	%xmm7, %xmm1
180004be6:     	jne	0x180004bf9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2689>
180004be8:     	jp	0x180004bf9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2689>
180004bea:     	movb	$0x1, (%r12)
180004bef:     	movq	$0x4c4b44, 0x18(%r15)   # imm = 0x4C4B44
180004bf7:     	jmp	0x180004bab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x263b>
180004bf9:     	divsd	%xmm1, %xmm0
180004bfd:     	addsd	0x10(%rdi,%rax,8), %xmm0
180004c03:     	movsd	%xmm0, 0x10(%rdi,%rax,8)
180004c09:     	movq	$0x0, 0x18(%rsi,%rax,8)
180004c12:     	jmp	0x180004bab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x263b>
180004c14:     	movb	$0x1, (%r12)
180004c19:     	movq	$0x9, 0x18(%r15)
180004c21:     	movq	0x68(%rsp), %rax
180004c26:     	movq	$0x0, (%rax)
180004c2d:     	jmp	0x180004782 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2212>
180004c32:     	movsd	0x178(%rsp), %xmm0
180004c3b:     	xorl	%eax, %eax
180004c3d:     	movq	0x78(%rsp), %rcx
180004c42:     	movq	0x70(%rsp), %rdx
180004c47:     	cmpq	(%rdx,%rcx), %rax
180004c4b:     	jge	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004c4d:     	movq	0x70(%rsp), %rcx
180004c52:     	movq	0x80(%rsp), %rdx
180004c5a:     	movq	0x10(%rcx,%rdx), %rcx
180004c5f:     	addq	%rax, %rcx
180004c62:     	leaq	(%rsi,%rcx,8), %rdx
180004c66:     	sarq	$0x3f, %rcx
180004c6a:     	andq	%r13, %rcx
180004c6d:     	movq	(%rdx,%rcx,8), %rcx
180004c71:     	testq	%rcx, %rcx
180004c74:     	js	0x180004e0d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x289d>
180004c7a:     	movq	0x18(%rsi,%rcx,8), %rdx
180004c7f:     	testq	%rdx, %rdx
180004c82:     	js	0x180004d95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2825>
180004c88:     	movq	(%rsi,%rcx,8), %r8
180004c8c:     	testq	%r8, %r8
180004c8f:     	js	0x180004d95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2825>
180004c95:     	movsd	(%rdi,%r8,8), %xmm1
180004c9b:     	mulsd	%xmm0, %xmm1
180004c9f:     	addsd	(%rdi,%rdx,8), %xmm1
180004ca4:     	movsd	%xmm1, (%rdi,%rdx,8)
180004ca9:     	movq	$0x0, 0x8(%rsi,%rdx,8)
180004cb2:     	movq	0x18(%rsi,%rcx,8), %rdx
180004cb7:     	testq	%rdx, %rdx
180004cba:     	js	0x180004da1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2831>
180004cc0:     	movq	(%rsi,%rcx,8), %r8
180004cc4:     	testq	%r8, %r8
180004cc7:     	js	0x180004da1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2831>
180004ccd:     	movsd	0x10(%rdi,%r8,8), %xmm1
180004cd4:     	mulsd	%xmm0, %xmm1
180004cd8:     	addsd	0x10(%rdi,%rdx,8), %xmm1
180004cde:     	movsd	%xmm1, 0x10(%rdi,%rdx,8)
180004ce4:     	movq	$0x0, 0x18(%rsi,%rdx,8)
180004ced:     	movq	0x10(%rsi,%rcx,8), %rdx
180004cf2:     	testq	%rdx, %rdx
180004cf5:     	js	0x180004dad <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x283d>
180004cfb:     	movq	0x18(%rsi,%rcx,8), %r8
180004d00:     	testq	%r8, %r8
180004d03:     	js	0x180004dad <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x283d>
180004d09:     	movsd	(%rdi,%r8,8), %xmm1
180004d0f:     	mulsd	%xmm0, %xmm1
180004d13:     	addsd	(%rdi,%rdx,8), %xmm1
180004d18:     	movsd	%xmm1, (%rdi,%rdx,8)
180004d1d:     	movq	$0x0, 0x8(%rsi,%rdx,8)
180004d26:     	movq	0x10(%rsi,%rcx,8), %rdx
180004d2b:     	testq	%rdx, %rdx
180004d2e:     	js	0x180004db9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2849>
180004d34:     	movq	0x18(%rsi,%rcx,8), %r8
180004d39:     	testq	%r8, %r8
180004d3c:     	js	0x180004db9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2849>
180004d3e:     	movsd	0x10(%rdi,%r8,8), %xmm1
180004d45:     	mulsd	%xmm0, %xmm1
180004d49:     	addsd	0x10(%rdi,%rdx,8), %xmm1
180004d4f:     	movsd	%xmm1, 0x10(%rdi,%rdx,8)
180004d55:     	movq	$0x0, 0x18(%rsi,%rdx,8)
180004d5e:     	movq	(%rsi,%rcx,8), %rdx
180004d62:     	testq	%rdx, %rdx
180004d65:     	js	0x180004ddd <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x286d>
180004d67:     	movq	$0x0, (%rdi,%rdx,8)
180004d6f:     	movq	$0x1, 0x8(%rsi,%rdx,8)
180004d78:     	movq	(%rsi,%rcx,8), %rcx
180004d7c:     	testq	%rcx, %rcx
180004d7f:     	js	0x180004de9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2879>
180004d81:     	movq	$0x0, 0x10(%rdi,%rcx,8)
180004d8a:     	leaq	(%rsi,%rcx,8), %rdx
180004d8e:     	movl	$0x1, %ecx
180004d93:     	jmp	0x180004dc6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2856>
180004d95:     	movb	$0x1, (%r12)
180004d9a:     	movl	$0x5b8d83, %ecx         # imm = 0x5B8D83
180004d9f:     	jmp	0x180004dc3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2853>
180004da1:     	movb	$0x1, (%r12)
180004da6:     	movl	$0x5b8d84, %ecx         # imm = 0x5B8D84
180004dab:     	jmp	0x180004dc3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2853>
180004dad:     	movb	$0x1, (%r12)
180004db2:     	movl	$0x5b8d87, %ecx         # imm = 0x5B8D87
180004db7:     	jmp	0x180004dc3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2853>
180004db9:     	movb	$0x1, (%r12)
180004dbe:     	movl	$0x5b8d88, %ecx         # imm = 0x5B8D88
180004dc3:     	movq	%r15, %rdx
180004dc6:     	movq	%rcx, 0x18(%rdx)
180004dca:     	incq	%rax
180004dcd:     	cmpb	$0x0, (%r12)
180004dd2:     	je	0x180004c3d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26cd>
180004dd8:     	jmp	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004ddd:     	movb	$0x1, (%r12)
180004de2:     	movl	$0x5b8d8b, %ecx         # imm = 0x5B8D8B
180004de7:     	jmp	0x180004dc3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2853>
180004de9:     	movb	$0x1, (%r12)
180004dee:     	movl	$0x5b8d8c, %ecx         # imm = 0x5B8D8C
180004df3:     	jmp	0x180004dc3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2853>
180004df5:     	movq	0x90(%rsp), %rdx
180004dfd:     	movq	0x88(%rsp), %rcx
180004e05:     	movq	%rdx, (%rcx)
180004e08:     	jmp	0x180004784 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2214>
180004e0d:     	movb	$0x1, (%r12)
180004e12:     	movq	$0x12, 0x18(%r15)
180004e1a:     	jmp	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004e1f:     	movb	$0x1, (%r12)
180004e24:     	movq	$0xd, 0x18(%r15)
180004e2c:     	jmp	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004e31:     	movb	$0x1, (%r12)
180004e36:     	movq	$0xe, 0x18(%r15)
180004e3e:     	jmp	0x180004c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x26b1>
180004e43:     	movq	0x88(%rsp), %rcx
180004e4b:     	movq	$0x0, (%rcx)
180004e52:     	jmp	0x180004784 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2214>
180004e57:     	nopw	(%rax,%rax)
180004e60:     	pushq	%r15
180004e62:     	pushq	%r14
180004e64:     	pushq	%r13
180004e66:     	pushq	%r12
180004e68:     	pushq	%rsi
180004e69:     	pushq	%rdi
180004e6a:     	pushq	%rbp
180004e6b:     	pushq	%rbx
180004e6c:     	subq	$0x118, %rsp            # imm = 0x118
180004e73:     	movapd	%xmm8, 0x100(%rsp)
180004e7d:     	movapd	%xmm7, 0xf0(%rsp)
180004e86:     	movapd	%xmm6, 0xe0(%rsp)
180004e8f:     	movq	0x198(%rsp), %r12
180004e97:     	movq	$0x0, 0x60(%rsp)
180004ea0:     	movb	$0x0, 0x68(%rsp)
180004ea5:     	movq	$0x0, 0x70(%rsp)
180004eae:     	movsd	0x48(%r8,%r12,8), %xmm0
180004eb5:     	xorpd	%xmm1, %xmm1
180004eb9:     	ucomisd	%xmm1, %xmm0
180004ebd:     	jne	0x180004ed6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2966>
180004ebf:     	jp	0x180004ed6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2966>
180004ec1:     	movb	$0x1, 0x18(%rcx)
180004ec5:     	movq	$0x0, 0x10(%rcx)
180004ecd:     	movb	$0x1, 0x8(%rcx)
180004ed1:     	jmp	0x18000510c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b9c>
180004ed6:     	movq	0x1a0(%rsp), %r14
180004ede:     	movq	0x190(%rsp), %r15
180004ee6:     	movq	0x188(%rsp), %rbx
180004eee:     	movq	0x180(%rsp), %rdi
180004ef6:     	movq	0x30(%r9,%r12,8), %rdx
180004efb:     	leaq	(%r9,%rdx,8), %rax
180004eff:     	sarq	$0x3f, %rdx
180004f03:     	andq	%r15, %rdx
180004f06:     	cmpq	$0x1, (%rax,%rdx,8)
180004f0b:     	jne	0x180004f21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x29b1>
180004f0d:     	cmpq	$0x0, (%rax)
180004f11:     	jle	0x180005024 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ab4>
180004f17:     	movq	0x10(%rax), %rax
180004f1b:     	cmpq	%r14, (%r9,%rax,8)
180004f1f:     	je	0x180004ec1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2951>
180004f21:     	movq	0x10(%r9,%r12,8), %rdx
180004f26:     	testq	%rdx, %rdx
180004f29:     	js	0x180005014 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2aa4>
180004f2f:     	testq	%r14, %r14
180004f32:     	js	0x180005014 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2aa4>
180004f38:     	movq	0x10(%r9,%r14,8), %r10
180004f3d:     	testq	%r10, %r10
180004f40:     	js	0x180005014 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2aa4>
180004f46:     	movsd	(%r8,%rdx,8), %xmm1
180004f4c:     	cmpq	$0x0, 0x8(%r9,%rdx,8)
180004f52:     	setne	%r11b
180004f56:     	cmpq	$0x0, 0x8(%r9,%r10,8)
180004f5c:     	setne	%al
180004f5f:     	subsd	(%r8,%r10,8), %xmm1
180004f65:     	andb	%r11b, %al
180004f68:     	cmpb	$0x1, %al
180004f6a:     	jne	0x180004f8e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2a1e>
180004f6c:     	movapd	0x544c(%rip), %xmm2     # 0x18000a3c0
180004f74:     	andpd	%xmm1, %xmm2
180004f78:     	ucomisd	0x5450(%rip), %xmm2     # 0x18000a3d0
180004f80:     	jae	0x180005014 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2aa4>
180004f86:     	xorpd	%xmm2, %xmm2
180004f8a:     	addsd	%xmm2, %xmm1
180004f8e:     	movsd	0x10(%r8,%rdx,8), %xmm2
180004f95:     	cmpq	$0x0, 0x18(%r9,%rdx,8)
180004f9b:     	subsd	0x10(%r8,%r10,8), %xmm2
180004fa2:     	je	0x180005034 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ac4>
180004fa8:     	cmpq	$0x0, 0x18(%r9,%r10,8)
180004fae:     	je	0x180005034 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ac4>
180004fb4:     	movapd	0x5404(%rip), %xmm3     # 0x18000a3c0
180004fbc:     	andpd	%xmm2, %xmm3
180004fc0:     	ucomisd	0x5408(%rip), %xmm3     # 0x18000a3d0
180004fc8:     	jae	0x18000509a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b2a>
180004fce:     	movapd	%xmm1, %xmm3
180004fd2:     	mulsd	%xmm1, %xmm3
180004fd6:     	ucomisd	0x53f2(%rip), %xmm3     # 0x18000a3d0
180004fde:     	setae	%dl
180004fe1:     	testb	%dl, %al
180004fe3:     	jne	0x18000504d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2add>
180004fe5:     	xorpd	%xmm4, %xmm4
180004fe9:     	addsd	%xmm4, %xmm2
180004fed:     	movapd	%xmm2, %xmm4
180004ff1:     	mulsd	%xmm2, %xmm4
180004ff5:     	ucomisd	0x53d3(%rip), %xmm4     # 0x18000a3d0
180004ffd:     	jae	0x18000504d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2add>
180004fff:     	addsd	%xmm4, %xmm3
180005003:     	ucomisd	0x53c5(%rip), %xmm3     # 0x18000a3d0
18000500b:     	setae	%dl
18000500e:     	testb	%dl, %al
180005010:     	jne	0x18000504d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2add>
180005012:     	jmp	0x180005069 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2af9>
180005014:     	movb	$0x1, (%rbx)
180005017:     	movq	$0x3d090a, 0x18(%rdi)   # imm = 0x3D090A
18000501f:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
180005024:     	movb	$0x1, (%rbx)
180005027:     	movq	$0x3d0906, 0x18(%rdi)   # imm = 0x3D0906
18000502f:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
180005034:     	movapd	%xmm1, %xmm3
180005038:     	mulsd	%xmm1, %xmm3
18000503c:     	ucomisd	0x538c(%rip), %xmm3     # 0x18000a3d0
180005044:     	setae	%dl
180005047:     	andb	%dl, %al
180005049:     	cmpb	$0x1, %al
18000504b:     	jne	0x18000505d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2aed>
18000504d:     	movb	$0x1, (%rbx)
180005050:     	movq	$0x3d090c, 0x18(%rdi)   # imm = 0x3D090C
180005058:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
18000505d:     	movapd	%xmm2, %xmm4
180005061:     	mulsd	%xmm2, %xmm4
180005065:     	addsd	%xmm4, %xmm3
180005069:     	xorps	%xmm4, %xmm4
18000506c:     	sqrtsd	%xmm3, %xmm4
180005070:     	cmpq	$0x0, 0x18(%r9,%r12,8)
180005076:     	je	0x1800050c9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b59>
180005078:     	movq	(%r9,%r12,8), %rax
18000507c:     	testq	%rax, %rax
18000507f:     	js	0x18000508d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b1d>
180005081:     	xorpd	%xmm5, %xmm5
180005085:     	ucomisd	%xmm5, %xmm3
180005089:     	jne	0x1800050a7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b37>
18000508b:     	jp	0x1800050a7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b37>
18000508d:     	movb	$0x1, (%rbx)
180005090:     	movq	$0x3d090f, 0x18(%rdi)   # imm = 0x3D090F
180005098:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
18000509a:     	movb	$0x1, (%rbx)
18000509d:     	movq	$0x3d090b, 0x18(%rdi)   # imm = 0x3D090B
1800050a5:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
1800050a7:     	movsd	0x1a8(%rsp), %xmm7
1800050b0:     	movsd	0x8(%r8,%rax,8), %xmm3
1800050b7:     	addsd	%xmm3, %xmm3
1800050bb:     	divsd	%xmm4, %xmm3
1800050bf:     	ucomisd	%xmm3, %xmm7
1800050c3:     	jbe	0x18000517c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2c0c>
1800050c9:     	movsd	0x5307(%rip), %xmm3     # 0x18000a3d8
1800050d1:     	maxsd	%xmm4, %xmm3
1800050d5:     	movapd	%xmm3, %xmm4
1800050d9:     	mulsd	%xmm3, %xmm4
1800050dd:     	xorpd	%xmm5, %xmm5
1800050e1:     	ucomisd	%xmm5, %xmm4
1800050e5:     	jne	0x180005142 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2bd2>
1800050e7:     	jp	0x180005142 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2bd2>
1800050e9:     	movb	$0x1, (%rbx)
1800050ec:     	movq	$0x3d0915, 0x18(%rdi)   # imm = 0x3D0915
1800050f4:     	movq	$0x0, 0x18(%rcx)
1800050fc:     	movq	$0x0, 0x10(%rcx)
180005104:     	movq	$0x0, 0x8(%rcx)
18000510c:     	movq	$0x0, (%rcx)
180005113:     	xorl	%eax, %eax
180005115:     	movaps	0xe0(%rsp), %xmm6
18000511d:     	movaps	0xf0(%rsp), %xmm7
180005125:     	movaps	0x100(%rsp), %xmm8
18000512e:     	addq	$0x118, %rsp            # imm = 0x118
180005135:     	popq	%rbx
180005136:     	popq	%rbp
180005137:     	popq	%rdi
180005138:     	popq	%rsi
180005139:     	popq	%r12
18000513b:     	popq	%r13
18000513d:     	popq	%r14
18000513f:     	popq	%r15
180005141:     	retq
180005142:     	movsd	0x8(%r8,%r14,8), %xmm5
180005149:     	mulsd	0x528f(%rip), %xmm5     # 0x18000a3e0
180005151:     	mulsd	%xmm5, %xmm0
180005155:     	divsd	%xmm4, %xmm0
180005159:     	mulsd	%xmm0, %xmm1
18000515d:     	divsd	%xmm3, %xmm1
180005161:     	mulsd	%xmm0, %xmm2
180005165:     	divsd	%xmm3, %xmm2
180005169:     	movsd	%xmm2, 0x10(%rcx)
18000516e:     	movsd	%xmm1, (%rcx)
180005172:     	movb	$0x0, 0x18(%rcx)
180005176:     	movb	$0x0, 0x8(%rcx)
18000517a:     	jmp	0x180005113 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ba3>
18000517c:     	movq	0x20(%r9,%r12,8), %rax
180005181:     	testq	%rax, %rax
180005184:     	js	0x180005223 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2cb3>
18000518a:     	movq	0x8(%rdi), %rdx
18000518e:     	leaq	0x1(%rdx), %r10
180005192:     	movq	%r10, 0x8(%rdi)
180005196:     	cmpq	0x10(%rdi), %rdx
18000519a:     	jge	0x18000537e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2e0e>
1800051a0:     	movq	%rcx, %rsi
1800051a3:     	movsd	%xmm7, 0x48(%rsp)
1800051a9:     	movq	%r14, 0x40(%rsp)
1800051ae:     	movq	%rax, 0x38(%rsp)
1800051b3:     	movq	%r15, 0x30(%rsp)
1800051b8:     	movq	%rbx, 0x28(%rsp)
1800051bd:     	movq	%rdi, 0x20(%rsp)
1800051c2:     	leaq	0xc0(%rsp), %rcx
1800051ca:     	movq	%r8, %r13
1800051cd:     	movq	%r9, %rbp
1800051d0:     	callq	0x180004e60 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28f0>
1800051d5:     	cmpb	$0x0, (%rbx)
1800051d8:     	jne	0x18000545a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2eea>
1800051de:     	cmpb	$0x0, 0xd8(%rsp)
1800051e6:     	setne	0x57(%rsp)
1800051eb:     	cmpb	$0x0, 0xc8(%rsp)
1800051f3:     	setne	%r11b
1800051f7:     	xorpd	%xmm8, %xmm8
1800051fc:     	movsd	0xc0(%rsp), %xmm6
180005205:     	addsd	%xmm8, %xmm6
18000520a:     	addsd	0xd0(%rsp), %xmm8
180005214:     	decq	0x8(%rdi)
180005218:     	movq	%rsi, %rcx
18000521b:     	movq	%r13, %r8
18000521e:     	movq	%rbp, %r9
180005221:     	jmp	0x180005234 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2cc4>
180005223:     	movb	$0x1, %r11b
180005226:     	xorpd	%xmm6, %xmm6
18000522a:     	xorpd	%xmm8, %xmm8
18000522f:     	movb	$0x1, 0x57(%rsp)
180005234:     	movq	0x28(%r9,%r12,8), %rax
180005239:     	testq	%rax, %rax
18000523c:     	js	0x1800052de <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2d6e>
180005242:     	movq	0x8(%rdi), %rdx
180005246:     	leaq	0x1(%rdx), %r10
18000524a:     	movq	%r10, 0x8(%rdi)
18000524e:     	cmpq	0x10(%rdi), %rdx
180005252:     	jge	0x18000538e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2e1e>
180005258:     	movb	%r11b, 0x58(%rsp)
18000525d:     	movq	%rcx, %rsi
180005260:     	movsd	%xmm7, 0x48(%rsp)
180005266:     	movq	%r14, 0x40(%rsp)
18000526b:     	movq	%rax, 0x38(%rsp)
180005270:     	movq	%r15, 0x30(%rsp)
180005275:     	movq	%rbx, 0x28(%rsp)
18000527a:     	movq	%rdi, 0x20(%rsp)
18000527f:     	leaq	0xa0(%rsp), %rcx
180005287:     	movq	%r8, %rbp
18000528a:     	movq	%r9, %r13
18000528d:     	callq	0x180004e60 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28f0>
180005292:     	cmpb	$0x0, (%rbx)
180005295:     	jne	0x18000545a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2eea>
18000529b:     	cmpb	$0x0, 0xb8(%rsp)
1800052a3:     	setne	%al
1800052a6:     	cmpb	$0x0, 0xa8(%rsp)
1800052ae:     	setne	%cl
1800052b1:     	addsd	0xa0(%rsp), %xmm6
1800052ba:     	addsd	0xb0(%rsp), %xmm8
1800052c4:     	decq	0x8(%rdi)
1800052c8:     	movzbl	0x58(%rsp), %r11d
1800052ce:     	andb	%cl, %r11b
1800052d1:     	andb	%al, 0x57(%rsp)
1800052d5:     	movq	%rsi, %rcx
1800052d8:     	movq	%rbp, %r8
1800052db:     	movq	%r13, %r9
1800052de:     	movq	0x38(%r9,%r12,8), %rax
1800052e3:     	testq	%rax, %rax
1800052e6:     	js	0x18000539e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2e2e>
1800052ec:     	movq	0x8(%rdi), %rdx
1800052f0:     	leaq	0x1(%rdx), %r10
1800052f4:     	movq	%r10, 0x8(%rdi)
1800052f8:     	cmpq	0x10(%rdi), %rdx
1800052fc:     	jge	0x18000543f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ecf>
180005302:     	movl	%r11d, %ebp
180005305:     	movq	%rcx, %rsi
180005308:     	movsd	%xmm7, 0x48(%rsp)
18000530e:     	movq	%r14, 0x40(%rsp)
180005313:     	movq	%rax, 0x38(%rsp)
180005318:     	movq	%r15, 0x30(%rsp)
18000531d:     	movq	%rbx, 0x28(%rsp)
180005322:     	movq	%rdi, 0x20(%rsp)
180005327:     	leaq	0x80(%rsp), %rcx
18000532f:     	movq	%r8, 0x58(%rsp)
180005334:     	movq	%r9, %r13
180005337:     	callq	0x180004e60 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28f0>
18000533c:     	cmpb	$0x0, (%rbx)
18000533f:     	jne	0x18000545a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2eea>
180005345:     	cmpb	$0x0, 0x98(%rsp)
18000534d:     	setne	%al
180005350:     	cmpb	$0x0, 0x88(%rsp)
180005358:     	setne	%cl
18000535b:     	addsd	0x80(%rsp), %xmm6
180005364:     	addsd	0x90(%rsp), %xmm8
18000536e:     	decq	0x8(%rdi)
180005372:     	andb	%cl, %bpl
180005375:     	andb	%al, 0x57(%rsp)
180005379:     	movq	%r13, %r9
18000537c:     	jmp	0x1800053a9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2e39>
18000537e:     	movb	$0x1, (%rbx)
180005381:     	movq	$0x3d0921, 0x18(%rdi)   # imm = 0x3D0921
180005389:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
18000538e:     	movb	$0x1, (%rbx)
180005391:     	movq	$0x3d0926, 0x18(%rdi)   # imm = 0x3D0926
180005399:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
18000539e:     	movl	%r11d, %ebp
1800053a1:     	movq	%r8, 0x58(%rsp)
1800053a6:     	movq	%rcx, %rsi
1800053a9:     	movq	0x40(%r9,%r12,8), %rcx
1800053ae:     	testq	%rcx, %rcx
1800053b1:     	js	0x180005424 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2eb4>
1800053b3:     	movq	0x8(%rdi), %rdx
1800053b7:     	leaq	0x1(%rdx), %r8
1800053bb:     	movq	%r8, 0x8(%rdi)
1800053bf:     	cmpq	0x10(%rdi), %rdx
1800053c3:     	jge	0x18000544f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2edf>
1800053c9:     	movsd	%xmm7, 0x48(%rsp)
1800053cf:     	movq	%r14, 0x40(%rsp)
1800053d4:     	movq	%rcx, 0x38(%rsp)
1800053d9:     	movq	%r15, 0x30(%rsp)
1800053de:     	movq	%rbx, 0x28(%rsp)
1800053e3:     	movq	%rdi, 0x20(%rsp)
1800053e8:     	leaq	0x60(%rsp), %rcx
1800053ed:     	movq	0x58(%rsp), %r8
1800053f2:     	callq	0x180004e60 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x28f0>
1800053f7:     	cmpb	$0x0, (%rbx)
1800053fa:     	jne	0x18000545a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2eea>
1800053fc:     	cmpb	$0x0, 0x78(%rsp)
180005401:     	setne	%al
180005404:     	cmpb	$0x0, 0x68(%rsp)
180005409:     	setne	%cl
18000540c:     	addsd	0x60(%rsp), %xmm6
180005412:     	addsd	0x70(%rsp), %xmm8
180005419:     	decq	0x8(%rdi)
18000541d:     	andb	%cl, %bpl
180005420:     	andb	%al, 0x57(%rsp)
180005424:     	movzbl	0x57(%rsp), %eax
180005429:     	movb	%al, 0x18(%rsi)
18000542c:     	movsd	%xmm8, 0x10(%rsi)
180005432:     	movb	%bpl, 0x8(%rsi)
180005436:     	movsd	%xmm6, (%rsi)
18000543a:     	jmp	0x180005113 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ba3>
18000543f:     	movb	$0x1, (%rbx)
180005442:     	movq	$0x3d092b, 0x18(%rdi)   # imm = 0x3D092B
18000544a:     	jmp	0x1800050f4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2b84>
18000544f:     	movb	$0x1, (%rbx)
180005452:     	movq	$0x3d0930, 0x18(%rdi)   # imm = 0x3D0930
18000545a:     	movq	$0x0, 0x18(%rsi)
180005462:     	movq	$0x0, 0x10(%rsi)
18000546a:     	movq	$0x0, 0x8(%rsi)
180005472:     	movq	$0x0, (%rsi)
180005479:     	jmp	0x180005113 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2ba3>
18000547e:     	nop
180005480:     	pushq	%r15
180005482:     	pushq	%r14
180005484:     	pushq	%r13
180005486:     	pushq	%r12
180005488:     	pushq	%rsi
180005489:     	pushq	%rdi
18000548a:     	pushq	%rbp
18000548b:     	pushq	%rbx
18000548c:     	subq	$0x158, %rsp            # imm = 0x158
180005493:     	movq	0x1d8(%rsp), %rax
18000549b:     	movq	0x1d0(%rsp), %r13
1800054a3:     	movq	0x1c8(%rsp), %r15
1800054ab:     	movq	0x1c0(%rsp), %r12
1800054b3:     	movb	$0x0, 0x6f(%rsp)
1800054b8:     	movq	$0x0, 0xe8(%rsp)
1800054c4:     	movb	$0x0, 0x5f(%rsp)
1800054c9:     	movq	$0x0, 0xe0(%rsp)
1800054d5:     	movb	$0x0, 0x5e(%rsp)
1800054da:     	movq	$0x0, 0xd8(%rsp)
1800054e6:     	movb	$0x0, 0x5d(%rsp)
1800054eb:     	movq	$0x0, 0xd0(%rsp)
1800054f7:     	movb	$0x0, 0x5c(%rsp)
1800054fc:     	movq	$0x0, 0xc8(%rsp)
180005508:     	movb	$0x0, 0x6e(%rsp)
18000550d:     	movq	$0x0, 0xc0(%rsp)
180005519:     	movb	$0x0, 0x6d(%rsp)
18000551e:     	movq	$0x0, 0xb8(%rsp)
18000552a:     	movb	$0x0, 0x6c(%rsp)
18000552f:     	movq	$0x0, 0xb0(%rsp)
18000553b:     	movb	$0x0, 0x6b(%rsp)
180005540:     	movq	$0x0, 0xa8(%rsp)
18000554c:     	cmpq	$0x1, %rax
180005550:     	je	0x1800055f8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3088>
180005556:     	testq	%rax, %rax
180005559:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000555f:     	movq	0x1e0(%rsp), %rbx
180005567:     	movq	(%r9,%rbx,8), %rax
18000556b:     	testq	%rax, %rax
18000556e:     	js	0x180005624 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30b4>
180005574:     	movq	0x1e8(%rsp), %r14
18000557c:     	testq	%r14, %r14
18000557f:     	js	0x180005624 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30b4>
180005585:     	movq	0x10(%r9,%r14,8), %r11
18000558a:     	testq	%r11, %r11
18000558d:     	js	0x1800056b6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3146>
180005593:     	movsd	(%r8,%r11,8), %xmm0
180005599:     	movsd	0x8(%r8,%rax,8), %xmm2
1800055a0:     	movsd	0x10(%r8,%rax,8), %xmm1
1800055a7:     	movapd	%xmm1, %xmm3
1800055ab:     	subsd	%xmm2, %xmm3
1800055af:     	xorl	%r10d, %r10d
1800055b2:     	ucomisd	%xmm3, %xmm0
1800055b6:     	jb	0x1800056d8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3168>
1800055bc:     	addsd	%xmm2, %xmm1
1800055c0:     	ucomisd	%xmm0, %xmm1
1800055c4:     	jbe	0x1800056d8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3168>
1800055ca:     	movsd	0x10(%r8,%r11,8), %xmm0
1800055d1:     	movsd	(%r8,%rax,8), %xmm1
1800055d7:     	movsd	0x18(%r8,%rax,8), %xmm2
1800055de:     	movapd	%xmm2, %xmm3
1800055e2:     	subsd	%xmm1, %xmm3
1800055e6:     	ucomisd	%xmm3, %xmm0
1800055ea:     	jae	0x1800056cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x315c>
1800055f0:     	xorl	%r10d, %r10d
1800055f3:     	jmp	0x1800056d8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3168>
1800055f8:     	movq	0x1f0(%rsp), %rbp
180005600:     	testq	%rbp, %rbp
180005603:     	js	0x180005636 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30c6>
180005605:     	movq	(%r9,%rbp,8), %rax
180005609:     	testq	%rax, %rax
18000560c:     	js	0x180005636 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30c6>
18000560e:     	movq	(%r12), %r10
180005612:     	leaq	0x4(%r10), %r11
180005616:     	cmpq	%r13, %r11
180005619:     	jle	0x180005648 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30d8>
18000561b:     	movb	$0x2, (%r15)
18000561f:     	jmp	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005624:     	movb	$0x1, (%r15)
180005628:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
180005631:     	jmp	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005636:     	movb	$0x1, (%r15)
18000563a:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
180005643:     	jmp	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005648:     	movsd	0x10(%r8,%rax,8), %xmm2
18000564f:     	movsd	0x18(%r8,%rax,8), %xmm1
180005656:     	movsd	0x4d52(%rip), %xmm0     # 0x18000a3b0
18000565e:     	movsd	0x8(%r8,%rax,8), %xmm3
180005665:     	mulsd	%xmm0, %xmm3
180005669:     	mulsd	(%r8,%rax,8), %xmm0
18000566f:     	movq	%r11, (%r12)
180005673:     	cmpb	$0x0, (%r15)
180005677:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000567d:     	movapd	%xmm2, %xmm4
180005681:     	addsd	%xmm3, %xmm4
180005685:     	movapd	%xmm1, %xmm5
180005689:     	subsd	%xmm0, %xmm5
18000568d:     	testq	%r10, %r10
180005690:     	js	0x1800057e9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3279>
180005696:     	movsd	%xmm4, 0x10(%r8,%r10,8)
18000569d:     	movsd	%xmm5, 0x18(%r8,%r10,8)
1800056a4:     	movsd	%xmm3, 0x8(%r8,%r10,8)
1800056ab:     	movsd	%xmm0, (%r8,%r10,8)
1800056b1:     	jmp	0x1800057f6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3286>
1800056b6:     	movb	$0x1, (%r15)
1800056ba:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
1800056c3:     	cmpb	$0x0, (%r15)
1800056c7:     	jmp	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
1800056cc:     	addsd	%xmm1, %xmm2
1800056d0:     	ucomisd	%xmm0, %xmm2
1800056d4:     	seta	%r10b
1800056d8:     	cmpb	$0x0, (%r15)
1800056dc:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
1800056e2:     	testb	%r10b, %r10b
1800056e5:     	je	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
1800056eb:     	movq	0x18(%r9,%rbx,8), %r11
1800056f0:     	movq	0x30(%r9,%rbx,8), %r10
1800056f5:     	movq	%r10, %rsi
1800056f8:     	sarq	$0x3f, %rsi
1800056fc:     	andq	%r13, %rsi
1800056ff:     	leaq	(%r9,%r10,8), %rbp
180005703:     	movq	(%rbp,%rsi,8), %rdi
180005708:     	cmpq	0x8(%r9,%rbx,8), %rdi
18000570d:     	jge	0x180005910 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x33a0>
180005713:     	testq	%r11, %r11
180005716:     	jne	0x180005919 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x33a9>
18000571c:     	xorl	%eax, %eax
18000571e:     	cmpq	$-0x1, %r10
180005722:     	cmovlq	%r13, %rax
180005726:     	cmpq	0x8(%rbp,%rax,8), %rdi
18000572b:     	jne	0x180005e6b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x38fb>
180005731:     	leaq	(%rdi,%rdi), %rdx
180005735:     	testq	%rdi, %rdi
180005738:     	movl	$0x4, %r11d
18000573e:     	cmovneq	%rdx, %r11
180005742:     	movq	(%r12), %rdx
180005746:     	movq	%rdx, 0x78(%rsp)
18000574b:     	movq	0x78(%rsp), %rdx
180005750:     	addq	%r11, %rdx
180005753:     	cmpq	%r13, %rdx
180005756:     	jg	0x18000561b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30ab>
18000575c:     	movq	%rdx, (%r12)
180005760:     	cmpb	$0x0, (%r15)
180005764:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000576a:     	movq	%rbp, 0x90(%rsp)
180005772:     	movq	%r11, 0x100(%rsp)
18000577a:     	movq	%rax, 0x108(%rsp)
180005782:     	xorl	%eax, %eax
180005784:     	movq	%r10, 0xf8(%rsp)
18000578c:     	cmpq	$-0x2, %r10
180005790:     	cmovlq	%r13, %rax
180005794:     	movq	%rax, 0x98(%rsp)
18000579c:     	testq	%rdi, %rdi
18000579f:     	jle	0x180005e34 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x38c4>
1800057a5:     	movq	0x98(%rsp), %rax
1800057ad:     	movq	0x90(%rsp), %rdx
1800057b5:     	movq	0x10(%rdx,%rax,8), %r11
1800057ba:     	movl	%edi, %eax
1800057bc:     	andl	$0x7, %eax
1800057bf:     	movq	%rax, 0x80(%rsp)
1800057c7:     	cmpq	$0x7, %rdi
1800057cb:     	ja	0x180005b21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35b1>
1800057d1:     	leaq	(,%r13,8), %rax
1800057d9:     	movq	%rax, 0xa0(%rsp)
1800057e1:     	xorl	%r10d, %r10d
1800057e4:     	jmp	0x180005ddd <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x386d>
1800057e9:     	movb	$0x1, (%r15)
1800057ed:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800057f6:     	cmpb	$0x0, (%r15)
1800057fa:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005800:     	movq	(%r12), %rax
180005804:     	leaq	0xb(%rax), %rsi
180005808:     	cmpq	%r13, %rsi
18000580b:     	jg	0x18000561b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30ab>
180005811:     	movq	0x8(%r9,%rbp,8), %r11
180005816:     	movq	%rsi, (%r12)
18000581a:     	cmpb	$0x0, (%r15)
18000581e:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005824:     	movq	%r10, (%r9,%rax,8)
180005828:     	movq	%r11, 0x8(%r9,%rax,8)
18000582d:     	movq	(%r12), %r11
180005831:     	cmpq	%r13, %r11
180005834:     	movq	%r11, %r10
180005837:     	jle	0x180005844 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x32d4>
180005839:     	movb	$0x2, (%r15)
18000583d:     	movq	(%r12), %r11
180005841:     	xorl	%r10d, %r10d
180005844:     	leaq	0x3(%r11), %rsi
180005848:     	cmpq	%r13, %rsi
18000584b:     	jg	0x18000561b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30ab>
180005851:     	movq	%rsi, (%r12)
180005855:     	cmpb	$0x0, (%r15)
180005859:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000585f:     	movq	%r11, %rsi
180005862:     	sarq	$0x3f, %rsi
180005866:     	andq	%r13, %rsi
180005869:     	leaq	(%r9,%r11,8), %rdi
18000586d:     	movq	$0x0, (%rdi,%rsi,8)
180005875:     	xorl	%esi, %esi
180005877:     	cmpq	$-0x1, %r11
18000587b:     	movl	$0x0, %ebx
180005880:     	cmovlq	%r13, %rbx
180005884:     	movq	$0x0, 0x8(%rdi,%rbx,8)
18000588d:     	cmpq	$-0x2, %r11
180005891:     	cmovlq	%r13, %rsi
180005895:     	movq	%r10, 0x10(%rdi,%rsi,8)
18000589a:     	cmpb	$0x0, (%r15)
18000589e:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
1800058a4:     	leaq	(%r9,%rax,8), %r10
1800058a8:     	movq	%r11, 0x30(%r10)
1800058ac:     	movq	$0x0, 0x18(%r10)
1800058b4:     	movq	(%r12), %r11
1800058b8:     	leaq	0x4(%r11), %rsi
1800058bc:     	cmpq	%r13, %rsi
1800058bf:     	jg	0x18000561b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x30ab>
1800058c5:     	movq	%rsi, (%r12)
1800058c9:     	cmpb	$0x0, (%r15)
1800058cd:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
1800058d3:     	movq	%rdx, %r14
1800058d6:     	movq	%r8, %rdi
1800058d9:     	movq	%r9, %rsi
1800058dc:     	movq	%rcx, %rbx
1800058df:     	testq	%r11, %r11
1800058e2:     	js	0x180006102 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3b92>
1800058e8:     	movq	$0x0, (%rdi,%r11,8)
1800058f0:     	leaq	(%rsi,%r11,8), %rcx
1800058f4:     	movq	$0x1, 0x8(%rsi,%r11,8)
1800058fd:     	movq	$0x0, 0x10(%rdi,%r11,8)
180005906:     	movl	$0x1, %edx
18000590b:     	jmp	0x18000610e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3b9e>
180005910:     	testq	%r11, %r11
180005913:     	je	0x1800059ad <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x343d>
180005919:     	movq	0x20(%r9,%rbx,8), %rax
18000591e:     	testq	%rax, %rax
180005921:     	js	0x180005a44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34d4>
180005927:     	movq	0x8(%r12), %r10
18000592c:     	leaq	0x1(%r10), %r11
180005930:     	movq	%r11, 0x8(%r12)
180005935:     	cmpq	0x10(%r12), %r10
18000593a:     	jge	0x180005a44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34d4>
180005940:     	movq	%rdx, 0x60(%rsp)
180005945:     	movq	%rcx, %rbp
180005948:     	movb	$0x0, 0x5f(%rsp)
18000594d:     	movq	%r14, 0x48(%rsp)
180005952:     	movq	%rax, 0x40(%rsp)
180005957:     	movq	%r13, 0x30(%rsp)
18000595c:     	movq	%r15, 0x28(%rsp)
180005961:     	movq	%r12, 0x20(%rsp)
180005966:     	movq	$-0x1, 0x50(%rsp)
18000596f:     	movq	$0x0, 0x38(%rsp)
180005978:     	leaq	0x5f(%rsp), %rcx
18000597d:     	leaq	0xe0(%rsp), %rdx
180005985:     	movq	%r8, %rdi
180005988:     	movq	%r9, %rsi
18000598b:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180005990:     	testl	%eax, %eax
180005992:     	jne	0x18000603c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3acc>
180005998:     	cmpb	$0x0, (%r15)
18000599c:     	movq	%rbp, %rax
18000599f:     	je	0x180005a79 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3509>
1800059a5:     	movb	$0x0, (%rax)
1800059a8:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
1800059ad:     	movq	0x8(%r12), %rax
1800059b2:     	leaq	0x1(%rax), %r10
1800059b6:     	movq	%r10, 0x8(%r12)
1800059bb:     	cmpq	0x10(%r12), %rax
1800059c0:     	jge	0x180005a6a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34fa>
1800059c6:     	movq	%rdx, %rsi
1800059c9:     	movq	%rcx, %rdi
1800059cc:     	movq	%rbx, 0x50(%rsp)
1800059d1:     	movq	%r13, 0x30(%rsp)
1800059d6:     	movq	%r15, 0x28(%rsp)
1800059db:     	movq	%r12, 0x20(%rsp)
1800059e0:     	movq	$-0x1, 0x48(%rsp)
1800059e9:     	movq	$-0x1, 0x40(%rsp)
1800059f2:     	movq	$0x1, 0x38(%rsp)
1800059fb:     	leaq	0x6f(%rsp), %rcx
180005a00:     	leaq	0xe8(%rsp), %rdx
180005a08:     	movq	%r8, 0x60(%rsp)
180005a0d:     	movq	%r9, %rbp
180005a10:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180005a15:     	testl	%eax, %eax
180005a17:     	jne	0x180006051 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3ae1>
180005a1d:     	cmpb	$0x0, (%r15)
180005a21:     	movq	%rdi, %rcx
180005a24:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005a26:     	movq	%rsi, %rdx
180005a29:     	decq	0x8(%r12)
180005a2e:     	movq	%rbp, %r9
180005a31:     	movq	0x60(%rsp), %r8
180005a36:     	movq	0x20(%r9,%rbx,8), %rax
180005a3b:     	testq	%rax, %rax
180005a3e:     	jns	0x180005927 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x33b7>
180005a44:     	movb	$0x1, (%r15)
180005a48:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
180005a51:     	movb	$0x0, (%rcx)
180005a54:     	xorl	%eax, %eax
180005a56:     	addq	$0x158, %rsp            # imm = 0x158
180005a5d:     	popq	%rbx
180005a5e:     	popq	%rbp
180005a5f:     	popq	%rdi
180005a60:     	popq	%rsi
180005a61:     	popq	%r12
180005a63:     	popq	%r13
180005a65:     	popq	%r14
180005a67:     	popq	%r15
180005a69:     	retq
180005a6a:     	movb	$0x1, (%r15)
180005a6e:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
180005a77:     	jmp	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005a79:     	movzbl	0x5f(%rsp), %ecx
180005a7e:     	movq	0x8(%r12), %rdx
180005a83:     	leaq	-0x1(%rdx), %r8
180005a87:     	movq	%r8, 0x8(%r12)
180005a8c:     	testb	$0x1, %cl
180005a8f:     	je	0x180005a96 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3526>
180005a91:     	movb	$0x1, (%rax)
180005a94:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
180005a96:     	movq	0x28(%rsi,%rbx,8), %rcx
180005a9b:     	testq	%rcx, %rcx
180005a9e:     	js	0x180005aac <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x353c>
180005aa0:     	movq	%rdx, 0x8(%r12)
180005aa5:     	cmpq	0x10(%r12), %rdx
180005aaa:     	jle	0x180005abe <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x354e>
180005aac:     	movb	$0x1, (%r15)
180005ab0:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180005ab9:     	jmp	0x1800059a5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3435>
180005abe:     	movq	%rsi, %r9
180005ac1:     	movb	$0x0, 0x5e(%rsp)
180005ac6:     	movq	%r14, 0x48(%rsp)
180005acb:     	movq	%rcx, 0x40(%rsp)
180005ad0:     	movq	%r13, 0x30(%rsp)
180005ad5:     	movq	%r15, 0x28(%rsp)
180005ada:     	movq	%r12, 0x20(%rsp)
180005adf:     	movq	$-0x1, 0x50(%rsp)
180005ae8:     	movq	$0x0, 0x38(%rsp)
180005af1:     	leaq	0x5e(%rsp), %rcx
180005af6:     	leaq	0xd8(%rsp), %rdx
180005afe:     	movq	%rdi, %r8
180005b01:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180005b06:     	testl	%eax, %eax
180005b08:     	jne	0x180006179 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c09>
180005b0e:     	cmpb	$0x0, (%r15)
180005b12:     	je	0x180005fd5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a65>
180005b18:     	movb	$0x0, (%rbp)
180005b1c:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
180005b21:     	movabsq	$0x7ffffffffffffff8, %r10 # imm = 0x7FFFFFFFFFFFFFF8
180005b2b:     	movq	%rdi, 0xf0(%rsp)
180005b33:     	andq	%rdi, %r10
180005b36:     	leaq	(%r9,%r11,8), %rax
180005b3a:     	movq	%rax, 0x60(%rsp)
180005b3f:     	movq	0x78(%rsp), %rax
180005b44:     	leaq	(%r9,%rax,8), %rax
180005b48:     	movq	%rax, 0x70(%rsp)
180005b4d:     	leaq	(,%r13,8), %rax
180005b55:     	movq	%rax, 0xa0(%rsp)
180005b5d:     	xorl	%edx, %edx
180005b5f:     	movq	%r11, 0x118(%rsp)
180005b67:     	movq	%r10, 0x110(%rsp)
180005b6f:     	leaq	(%r11,%rdx), %rbp
180005b73:     	movq	%rbp, %r11
180005b76:     	sarq	$0x3f, %r11
180005b7a:     	leaq	(,%r13,8), %rax
180005b82:     	andq	%rax, %r11
180005b85:     	movq	0x60(%rsp), %r10
180005b8a:     	addq	%r10, %r11
180005b8d:     	movq	(%r11,%rdx,8), %r11
180005b91:     	movq	%r11, 0x88(%rsp)
180005b99:     	movq	0x78(%rsp), %r11
180005b9e:     	leaq	(%r11,%rdx), %rdi
180005ba2:     	movq	%rdi, %r11
180005ba5:     	sarq	$0x3f, %r11
180005ba9:     	andq	%rax, %r11
180005bac:     	addq	0x70(%rsp), %r11
180005bb1:     	movq	0x88(%rsp), %rax
180005bb9:     	movq	%rax, (%r11,%rdx,8)
180005bbd:     	movq	%rbp, %r11
180005bc0:     	incq	%r11
180005bc3:     	movl	$0x8, %r11d
180005bc9:     	leaq	0x8(,%r13,8), %rax
180005bd1:     	movq	%rax, 0x148(%rsp)
180005bd9:     	cmovsq	%rax, %r11
180005bdd:     	addq	%r10, %r11
180005be0:     	movq	(%r11,%rdx,8), %r11
180005be4:     	movq	%rdi, %rax
180005be7:     	incq	%rax
180005bea:     	movl	$0x8, %eax
180005bef:     	cmovsq	0x148(%rsp), %rax
180005bf8:     	addq	0x70(%rsp), %rax
180005bfd:     	movq	%r11, (%rax,%rdx,8)
180005c01:     	movq	%rbp, %rax
180005c04:     	addq	$0x2, %rax
180005c08:     	movl	$0x10, %eax
180005c0d:     	leaq	0x10(,%r13,8), %r11
180005c15:     	movq	%r11, 0x140(%rsp)
180005c1d:     	cmovsq	%r11, %rax
180005c21:     	addq	%r10, %rax
180005c24:     	movq	(%rax,%rdx,8), %rax
180005c28:     	movq	%rdi, %r11
180005c2b:     	addq	$0x2, %r11
180005c2f:     	movl	$0x10, %r11d
180005c35:     	cmovsq	0x140(%rsp), %r11
180005c3e:     	movq	0x70(%rsp), %r10
180005c43:     	addq	%r10, %r11
180005c46:     	movq	%rax, (%r11,%rdx,8)
180005c4a:     	movq	%rbp, %rax
180005c4d:     	addq	$0x3, %rax
180005c51:     	movl	$0x18, %eax
180005c56:     	leaq	0x18(,%r13,8), %r11
180005c5e:     	movq	%r11, 0x138(%rsp)
180005c66:     	cmovsq	%r11, %rax
180005c6a:     	addq	0x60(%rsp), %rax
180005c6f:     	movq	(%rax,%rdx,8), %rax
180005c73:     	movq	%rdi, %r11
180005c76:     	addq	$0x3, %r11
180005c7a:     	movl	$0x18, %r11d
180005c80:     	cmovsq	0x138(%rsp), %r11
180005c89:     	addq	%r10, %r11
180005c8c:     	movq	%rax, (%r11,%rdx,8)
180005c90:     	movq	%rbp, %rax
180005c93:     	addq	$0x4, %rax
180005c97:     	movl	$0x20, %eax
180005c9c:     	leaq	0x20(,%r13,8), %r11
180005ca4:     	movq	%r11, 0x130(%rsp)
180005cac:     	cmovsq	%r11, %rax
180005cb0:     	movq	0x60(%rsp), %r10
180005cb5:     	addq	%r10, %rax
180005cb8:     	movq	(%rax,%rdx,8), %rax
180005cbc:     	movq	%rdi, %r11
180005cbf:     	addq	$0x4, %r11
180005cc3:     	movl	$0x20, %r11d
180005cc9:     	cmovsq	0x130(%rsp), %r11
180005cd2:     	addq	0x70(%rsp), %r11
180005cd7:     	movq	%rax, (%r11,%rdx,8)
180005cdb:     	movq	%rbp, %rax
180005cde:     	addq	$0x5, %rax
180005ce2:     	movl	$0x28, %eax
180005ce7:     	leaq	0x28(,%r13,8), %r11
180005cef:     	movq	%r11, 0x128(%rsp)
180005cf7:     	cmovsq	%r11, %rax
180005cfb:     	addq	%r10, %rax
180005cfe:     	movq	(%rax,%rdx,8), %rax
180005d02:     	movq	%rdi, %r11
180005d05:     	addq	$0x5, %r11
180005d09:     	movl	$0x28, %r11d
180005d0f:     	cmovsq	0x128(%rsp), %r11
180005d18:     	movq	0x70(%rsp), %r10
180005d1d:     	addq	%r10, %r11
180005d20:     	movq	%rax, (%r11,%rdx,8)
180005d24:     	movq	%rbp, %rax
180005d27:     	addq	$0x6, %rax
180005d2b:     	movl	$0x30, %eax
180005d30:     	leaq	0x30(,%r13,8), %r11
180005d38:     	movq	%r11, 0x120(%rsp)
180005d40:     	cmovsq	%r11, %rax
180005d44:     	addq	0x60(%rsp), %rax
180005d49:     	movq	(%rax,%rdx,8), %rax
180005d4d:     	movq	%rdi, %r11
180005d50:     	addq	$0x6, %r11
180005d54:     	movl	$0x30, %r11d
180005d5a:     	cmovsq	0x120(%rsp), %r11
180005d63:     	addq	%r10, %r11
180005d66:     	movq	%rax, (%r11,%rdx,8)
180005d6a:     	addq	$0x7, %rbp
180005d6e:     	movl	$0x38, %eax
180005d73:     	leaq	0x38(,%r13,8), %r11
180005d7b:     	movq	%r11, 0x150(%rsp)
180005d83:     	cmovsq	%r11, %rax
180005d87:     	addq	0x60(%rsp), %rax
180005d8c:     	movq	0x110(%rsp), %rbp
180005d94:     	movq	(%rax,%rdx,8), %rax
180005d98:     	addq	$0x7, %rdi
180005d9c:     	movl	$0x38, %r11d
180005da2:     	cmovsq	0x150(%rsp), %r11
180005dab:     	addq	%r10, %r11
180005dae:     	movq	%rax, (%r11,%rdx,8)
180005db2:     	movq	0x118(%rsp), %r11
180005dba:     	addq	$0x8, %rdx
180005dbe:     	cmpq	%rdx, %rbp
180005dc1:     	jne	0x180005b6f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35ff>
180005dc7:     	movq	%rbp, %r10
180005dca:     	cmpq	$0x0, 0x80(%rsp)
180005dd3:     	movq	0xf0(%rsp), %rdi
180005ddb:     	je	0x180005e34 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x38c4>
180005ddd:     	movq	0x78(%rsp), %rax
180005de2:     	leaq	(%r10,%rax), %rdx
180005de6:     	addq	%r10, %r11
180005de9:     	movq	0xa0(%rsp), %r10
180005df1:     	movq	%r11, %rax
180005df4:     	sarq	$0x3f, %rax
180005df8:     	andq	%r10, %rax
180005dfb:     	addq	%r9, %rax
180005dfe:     	movq	(%rax,%r11,8), %rax
180005e02:     	movq	%r11, %rbp
180005e05:     	movq	%rdx, %r11
180005e08:     	sarq	$0x3f, %r11
180005e0c:     	andq	%r10, %r11
180005e0f:     	addq	%r9, %r11
180005e12:     	movq	%rax, (%r11,%rdx,8)
180005e16:     	movq	%rbp, %r11
180005e19:     	movq	0x80(%rsp), %rax
180005e21:     	incq	%rdx
180005e24:     	incq	%r11
180005e27:     	decq	%rax
180005e2a:     	movq	%rax, 0x80(%rsp)
180005e32:     	jne	0x180005df1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3881>
180005e34:     	movq	0x108(%rsp), %rax
180005e3c:     	movq	0x100(%rsp), %rdx
180005e44:     	movq	0x90(%rsp), %rbp
180005e4c:     	movq	%rdx, 0x8(%rbp,%rax,8)
180005e51:     	movq	0x78(%rsp), %rax
180005e56:     	movq	0x98(%rsp), %rdx
180005e5e:     	movq	%rax, 0x10(%rbp,%rdx,8)
180005e63:     	movq	0xf8(%rsp), %r10
180005e6b:     	leaq	0x1(%rdi), %rax
180005e6f:     	movq	%rax, (%rbp,%rsi,8)
180005e74:     	cmpb	$0x0, (%r15)
180005e78:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
180005e7e:     	xorl	%eax, %eax
180005e80:     	cmpq	$-0x2, %r10
180005e84:     	cmovlq	%r13, %rax
180005e88:     	addq	0x10(%rbp,%rax,8), %rdi
180005e8d:     	movq	%rdi, %rax
180005e90:     	sarq	$0x3f, %rax
180005e94:     	andq	%r13, %rax
180005e97:     	leaq	(%r9,%rdi,8), %rdx
180005e9b:     	movq	%r14, (%rdx,%rax,8)
180005e9f:     	movsd	0x48(%r8,%rbx,8), %xmm1
180005ea6:     	movsd	0x8(%r8,%r14,8), %xmm2
180005ead:     	movapd	%xmm1, %xmm0
180005eb1:     	addsd	%xmm2, %xmm0
180005eb5:     	xorpd	%xmm3, %xmm3
180005eb9:     	ucomisd	%xmm3, %xmm0
180005ebd:     	jbe	0x180005fb4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a44>
180005ec3:     	movq	0x10(%r9,%rbx,8), %rax
180005ec8:     	testq	%rax, %rax
180005ecb:     	js	0x180005fc6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a56>
180005ed1:     	cmpq	$0x0, 0x8(%r9,%rax,8)
180005ed7:     	mulsd	(%r8,%rax,8), %xmm1
180005edd:     	je	0x180005f09 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3999>
180005edf:     	cmpq	$0x0, 0x50(%r9,%rbx,8)
180005ee5:     	je	0x180005f09 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3999>
180005ee7:     	movapd	0x44d1(%rip), %xmm3     # 0x18000a3c0
180005eef:     	andpd	%xmm1, %xmm3
180005ef3:     	ucomisd	0x44d5(%rip), %xmm3     # 0x18000a3d0
180005efb:     	jae	0x180005fc6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a56>
180005f01:     	xorpd	%xmm3, %xmm3
180005f05:     	addsd	%xmm3, %xmm1
180005f09:     	movq	0x10(%r9,%r14,8), %rdx
180005f0e:     	testq	%rdx, %rdx
180005f11:     	js	0x180005fc6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a56>
180005f17:     	mulsd	(%r8,%rdx,8), %xmm2
180005f1d:     	addsd	%xmm2, %xmm1
180005f21:     	divsd	%xmm0, %xmm1
180005f25:     	movsd	%xmm1, (%r8,%rax,8)
180005f2b:     	movq	$0x0, 0x8(%r9,%rax,8)
180005f34:     	movq	0x10(%r9,%rbx,8), %rax
180005f39:     	testq	%rax, %rax
180005f3c:     	js	0x180005ff5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a85>
180005f42:     	movsd	0x10(%r8,%rax,8), %xmm1
180005f49:     	movq	%r9, %rdx
180005f4c:     	cmpq	$0x0, 0x18(%r9,%rax,8)
180005f52:     	mulsd	0x48(%r8,%rbx,8), %xmm1
180005f59:     	je	0x180005f81 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a11>
180005f5b:     	cmpq	$0x0, 0x50(%rdx,%rbx,8)
180005f61:     	je	0x180005f81 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a11>
180005f63:     	movapd	0x4455(%rip), %xmm2     # 0x18000a3c0
180005f6b:     	andpd	%xmm1, %xmm2
180005f6f:     	ucomisd	0x4459(%rip), %xmm2     # 0x18000a3d0
180005f77:     	jae	0x180005ff5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a85>
180005f79:     	xorpd	%xmm2, %xmm2
180005f7d:     	addsd	%xmm2, %xmm1
180005f81:     	movq	0x10(%rdx,%r14,8), %r9
180005f86:     	testq	%r9, %r9
180005f89:     	js	0x180005ff5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a85>
180005f8b:     	movsd	0x10(%r8,%r9,8), %xmm2
180005f92:     	mulsd	0x8(%r8,%r14,8), %xmm2
180005f99:     	addsd	%xmm2, %xmm1
180005f9d:     	divsd	%xmm0, %xmm1
180005fa1:     	movsd	%xmm1, 0x10(%r8,%rax,8)
180005fa8:     	movq	%rdx, %r9
180005fab:     	movq	$0x0, 0x18(%rdx,%rax,8)
180005fb4:     	movsd	%xmm0, 0x48(%r8,%rbx,8)
180005fbb:     	movq	$0x0, 0x50(%r9,%rbx,8)
180005fc4:     	jmp	0x180006002 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a92>
180005fc6:     	movb	$0x1, (%r15)
180005fca:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
180005fd3:     	jmp	0x180006002 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a92>
180005fd5:     	movzbl	0x5e(%rsp), %eax
180005fda:     	movq	0x8(%r12), %rcx
180005fdf:     	leaq	-0x1(%rcx), %rdx
180005fe3:     	movq	%rdx, 0x8(%r12)
180005fe8:     	testb	$0x1, %al
180005fea:     	je	0x180006014 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3aa4>
180005fec:     	movb	$0x1, (%rbp)
180005ff0:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
180005ff5:     	movb	$0x1, (%r15)
180005ff9:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180006002:     	cmpb	$0x0, (%r15)
180006006:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000600c:     	movb	$0x1, (%rcx)
18000600f:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
180006014:     	movq	0x38(%rsi,%rbx,8), %rax
180006019:     	testq	%rax, %rax
18000601c:     	js	0x18000602a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3aba>
18000601e:     	movq	%rcx, 0x8(%r12)
180006023:     	cmpq	0x10(%r12), %rcx
180006028:     	jle	0x180006061 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3af1>
18000602a:     	movb	$0x1, (%r15)
18000602e:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
180006037:     	jmp	0x180005b18 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35a8>
18000603c:     	movq	0xe0(%rsp), %rdx
180006044:     	movq	0x60(%rsp), %rcx
180006049:     	movq	%rdx, (%rcx)
18000604c:     	jmp	0x180005a56 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e6>
180006051:     	movq	0xe8(%rsp), %rcx
180006059:     	movq	%rcx, (%rsi)
18000605c:     	jmp	0x180005a56 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e6>
180006061:     	movb	$0x0, 0x5d(%rsp)
180006066:     	movq	%r14, 0x48(%rsp)
18000606b:     	movq	%rax, 0x40(%rsp)
180006070:     	movq	%r13, 0x30(%rsp)
180006075:     	movq	%r15, 0x28(%rsp)
18000607a:     	movq	%r12, 0x20(%rsp)
18000607f:     	movq	$-0x1, 0x50(%rsp)
180006088:     	movq	$0x0, 0x38(%rsp)
180006091:     	leaq	0x5d(%rsp), %rcx
180006096:     	leaq	0xd0(%rsp), %rdx
18000609e:     	movq	%rdi, %r8
1800060a1:     	movq	%rsi, %r9
1800060a4:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
1800060a9:     	testl	%eax, %eax
1800060ab:     	jne	0x18000633d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3dcd>
1800060b1:     	cmpb	$0x0, (%r15)
1800060b5:     	jne	0x180005b18 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35a8>
1800060bb:     	movzbl	0x5d(%rsp), %eax
1800060c0:     	movq	0x8(%r12), %rcx
1800060c5:     	leaq	-0x1(%rcx), %rdx
1800060c9:     	movq	%rdx, 0x8(%r12)
1800060ce:     	testb	$0x1, %al
1800060d0:     	jne	0x180005fec <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a7c>
1800060d6:     	movq	0x40(%rsi,%rbx,8), %rax
1800060db:     	testq	%rax, %rax
1800060de:     	js	0x1800060f0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3b80>
1800060e0:     	movq	%rcx, 0x8(%r12)
1800060e5:     	cmpq	0x10(%r12), %rcx
1800060ea:     	jle	0x1800061ba <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c4a>
1800060f0:     	movb	$0x1, (%r15)
1800060f4:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
1800060fd:     	jmp	0x180005b18 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35a8>
180006102:     	movb	$0x1, (%r15)
180006106:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
18000610b:     	movq	%r12, %rcx
18000610e:     	movq	%rdx, 0x18(%rcx)
180006112:     	cmpb	$0x0, (%r15)
180006116:     	movq	%rbx, %rcx
180006119:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000611f:     	movq	%r11, 0x10(%r10)
180006123:     	movq	$0x0, 0x48(%rdi,%rax,8)
18000612c:     	movq	$0x1, 0x50(%r10)
180006134:     	movq	$-0x1, 0x20(%r10)
18000613c:     	movq	$-0x1, 0x28(%r10)
180006144:     	movq	$-0x1, 0x38(%r10)
18000614c:     	movq	$-0x1, 0x40(%r10)
180006154:     	cmpb	$0x0, (%r15)
180006158:     	jne	0x180005a51 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e1>
18000615e:     	movq	%rax, 0x20(%rsi,%rbp,8)
180006163:     	movq	(%r12), %rcx
180006167:     	leaq	0x4(%rcx), %rax
18000616b:     	cmpq	%r13, %rax
18000616e:     	jle	0x180006186 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c16>
180006170:     	movb	$0x2, (%r15)
180006174:     	jmp	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006179:     	movq	0xd8(%rsp), %rdx
180006181:     	jmp	0x180006044 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3ad4>
180006186:     	movq	%rax, (%r12)
18000618a:     	cmpb	$0x0, (%r15)
18000618e:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006194:     	subsd	%xmm3, %xmm2
180006198:     	testq	%rcx, %rcx
18000619b:     	js	0x18000622b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cbb>
1800061a1:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
1800061a7:     	movsd	%xmm5, 0x18(%rdi,%rcx,8)
1800061ad:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800061b3:     	movsd	%xmm0, (%rdi,%rcx,8)
1800061b8:     	jmp	0x180006238 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cc8>
1800061ba:     	movb	$0x0, 0x5c(%rsp)
1800061bf:     	movq	%r14, 0x48(%rsp)
1800061c4:     	movq	%rax, 0x40(%rsp)
1800061c9:     	movq	%r13, 0x30(%rsp)
1800061ce:     	movq	%r15, 0x28(%rsp)
1800061d3:     	movq	%r12, 0x20(%rsp)
1800061d8:     	movq	$-0x1, 0x50(%rsp)
1800061e1:     	movq	$0x0, 0x38(%rsp)
1800061ea:     	leaq	0x5c(%rsp), %rcx
1800061ef:     	leaq	0xc8(%rsp), %rdx
1800061f7:     	movq	%rdi, %r8
1800061fa:     	movq	%rsi, %r9
1800061fd:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180006202:     	testl	%eax, %eax
180006204:     	jne	0x18000634a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3dda>
18000620a:     	cmpb	$0x0, (%r15)
18000620e:     	jne	0x180005b18 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35a8>
180006214:     	movzbl	0x5c(%rsp), %eax
180006219:     	decq	0x8(%r12)
18000621e:     	testb	$0x1, %al
180006220:     	je	0x180005b18 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x35a8>
180006226:     	jmp	0x180005fec <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3a7c>
18000622b:     	movb	$0x1, (%r15)
18000622f:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180006238:     	cmpb	$0x0, (%r15)
18000623c:     	je	0x180006246 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cd6>
18000623e:     	movb	$0x0, (%rbx)
180006241:     	jmp	0x180005a54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e4>
180006246:     	movq	(%r12), %rax
18000624a:     	leaq	0xb(%rax), %r8
18000624e:     	cmpq	%r13, %r8
180006251:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006257:     	movq	0x8(%rsi,%rbp,8), %rdx
18000625c:     	movq	%r8, (%r12)
180006260:     	cmpb	$0x0, (%r15)
180006264:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006266:     	movq	%rcx, (%rsi,%rax,8)
18000626a:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000626f:     	movq	(%r12), %rdx
180006273:     	cmpq	%r13, %rdx
180006276:     	movq	%rdx, %rcx
180006279:     	jle	0x180006285 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3d15>
18000627b:     	movb	$0x2, (%r15)
18000627f:     	movq	(%r12), %rdx
180006283:     	xorl	%ecx, %ecx
180006285:     	leaq	0x3(%rdx), %r8
180006289:     	cmpq	%r13, %r8
18000628c:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006292:     	movq	%r8, (%r12)
180006296:     	cmpb	$0x0, (%r15)
18000629a:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
18000629c:     	movq	%rdx, %r8
18000629f:     	sarq	$0x3f, %r8
1800062a3:     	andq	%r13, %r8
1800062a6:     	leaq	(%rsi,%rdx,8), %r9
1800062aa:     	movq	$0x0, (%r9,%r8,8)
1800062b2:     	xorl	%r8d, %r8d
1800062b5:     	cmpq	$-0x1, %rdx
1800062b9:     	movl	$0x0, %r10d
1800062bf:     	cmovlq	%r13, %r10
1800062c3:     	movq	$0x0, 0x8(%r9,%r10,8)
1800062cc:     	cmpq	$-0x2, %rdx
1800062d0:     	cmovlq	%r13, %r8
1800062d4:     	movq	%rcx, 0x10(%r9,%r8,8)
1800062d9:     	cmpb	$0x0, (%r15)
1800062dd:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800062e3:     	leaq	(%rsi,%rax,8), %rcx
1800062e7:     	movq	%rdx, 0x30(%rcx)
1800062eb:     	movq	$0x0, 0x18(%rcx)
1800062f3:     	movq	(%r12), %rdx
1800062f7:     	leaq	0x4(%rdx), %r8
1800062fb:     	cmpq	%r13, %r8
1800062fe:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006304:     	movq	%r8, (%r12)
180006308:     	cmpb	$0x0, (%r15)
18000630c:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006312:     	testq	%rdx, %rdx
180006315:     	js	0x180006357 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3de7>
180006317:     	movq	$0x0, (%rdi,%rdx,8)
18000631f:     	leaq	(%rsi,%rdx,8), %r8
180006323:     	movq	$0x1, 0x8(%rsi,%rdx,8)
18000632c:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180006335:     	movl	$0x1, %r9d
18000633b:     	jmp	0x180006364 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3df4>
18000633d:     	movq	0xd0(%rsp), %rdx
180006345:     	jmp	0x180006044 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3ad4>
18000634a:     	movq	0xc8(%rsp), %rdx
180006352:     	jmp	0x180006044 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3ad4>
180006357:     	movb	$0x1, (%r15)
18000635b:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180006361:     	movq	%r12, %r8
180006364:     	movq	%r9, 0x18(%r8)
180006368:     	cmpb	$0x0, (%r15)
18000636c:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006372:     	movq	%rdx, 0x10(%rcx)
180006376:     	movq	$0x0, 0x48(%rdi,%rax,8)
18000637f:     	movq	$0x1, 0x50(%rcx)
180006387:     	movq	$-0x1, 0x20(%rcx)
18000638f:     	movq	$-0x1, 0x28(%rcx)
180006397:     	movq	$-0x1, 0x38(%rcx)
18000639f:     	movq	$-0x1, 0x40(%rcx)
1800063a7:     	cmpb	$0x0, (%r15)
1800063ab:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800063b1:     	movq	%rax, 0x28(%rsi,%rbp,8)
1800063b6:     	movq	(%r12), %rcx
1800063ba:     	leaq	0x4(%rcx), %rax
1800063be:     	cmpq	%r13, %rax
1800063c1:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
1800063c7:     	movq	%rax, (%r12)
1800063cb:     	cmpb	$0x0, (%r15)
1800063cf:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800063d5:     	addsd	%xmm0, %xmm1
1800063d9:     	testq	%rcx, %rcx
1800063dc:     	js	0x1800063f7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3e87>
1800063de:     	movsd	%xmm4, 0x10(%rdi,%rcx,8)
1800063e4:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
1800063ea:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800063f0:     	movsd	%xmm0, (%rdi,%rcx,8)
1800063f5:     	jmp	0x180006404 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3e94>
1800063f7:     	movb	$0x1, (%r15)
1800063fb:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180006404:     	cmpb	$0x0, (%r15)
180006408:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
18000640e:     	movq	(%r12), %rax
180006412:     	leaq	0xb(%rax), %r8
180006416:     	cmpq	%r13, %r8
180006419:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
18000641f:     	movq	0x8(%rsi,%rbp,8), %rdx
180006424:     	movq	%r8, (%r12)
180006428:     	cmpb	$0x0, (%r15)
18000642c:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006432:     	movq	%rcx, (%rsi,%rax,8)
180006436:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000643b:     	movq	(%r12), %rdx
18000643f:     	cmpq	%r13, %rdx
180006442:     	movq	%rdx, %rcx
180006445:     	jle	0x180006451 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3ee1>
180006447:     	movb	$0x2, (%r15)
18000644b:     	movq	(%r12), %rdx
18000644f:     	xorl	%ecx, %ecx
180006451:     	leaq	0x3(%rdx), %r8
180006455:     	cmpq	%r13, %r8
180006458:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
18000645e:     	movq	%r8, (%r12)
180006462:     	cmpb	$0x0, (%r15)
180006466:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
18000646c:     	movq	%rdx, %r8
18000646f:     	sarq	$0x3f, %r8
180006473:     	andq	%r13, %r8
180006476:     	leaq	(%rsi,%rdx,8), %r9
18000647a:     	movq	$0x0, (%r9,%r8,8)
180006482:     	xorl	%r8d, %r8d
180006485:     	cmpq	$-0x1, %rdx
180006489:     	movl	$0x0, %r10d
18000648f:     	cmovlq	%r13, %r10
180006493:     	movq	$0x0, 0x8(%r9,%r10,8)
18000649c:     	cmpq	$-0x2, %rdx
1800064a0:     	cmovlq	%r13, %r8
1800064a4:     	movq	%rcx, 0x10(%r9,%r8,8)
1800064a9:     	cmpb	$0x0, (%r15)
1800064ad:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800064b3:     	leaq	(%rsi,%rax,8), %rcx
1800064b7:     	movq	%rdx, 0x30(%rcx)
1800064bb:     	movq	$0x0, 0x18(%rcx)
1800064c3:     	movq	(%r12), %rdx
1800064c7:     	leaq	0x4(%rdx), %r8
1800064cb:     	cmpq	%r13, %r8
1800064ce:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
1800064d4:     	movq	%r8, (%r12)
1800064d8:     	cmpb	$0x0, (%r15)
1800064dc:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800064e2:     	testq	%rdx, %rdx
1800064e5:     	js	0x18000650d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3f9d>
1800064e7:     	movq	$0x0, (%rdi,%rdx,8)
1800064ef:     	leaq	(%rsi,%rdx,8), %r8
1800064f3:     	movq	$0x1, 0x8(%rsi,%rdx,8)
1800064fc:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180006505:     	movl	$0x1, %r9d
18000650b:     	jmp	0x18000651a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3faa>
18000650d:     	movb	$0x1, (%r15)
180006511:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180006517:     	movq	%r12, %r8
18000651a:     	movq	%r9, 0x18(%r8)
18000651e:     	cmpb	$0x0, (%r15)
180006522:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006528:     	movq	%rdx, 0x10(%rcx)
18000652c:     	movq	$0x0, 0x48(%rdi,%rax,8)
180006535:     	movq	$0x1, 0x50(%rcx)
18000653d:     	movq	$-0x1, 0x20(%rcx)
180006545:     	movq	$-0x1, 0x28(%rcx)
18000654d:     	movq	$-0x1, 0x38(%rcx)
180006555:     	movq	$-0x1, 0x40(%rcx)
18000655d:     	cmpb	$0x0, (%r15)
180006561:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006567:     	movq	%rax, 0x38(%rsi,%rbp,8)
18000656c:     	movq	(%r12), %rcx
180006570:     	leaq	0x4(%rcx), %rax
180006574:     	cmpq	%r13, %rax
180006577:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
18000657d:     	movq	%rax, (%r12)
180006581:     	cmpb	$0x0, (%r15)
180006585:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
18000658b:     	testq	%rcx, %rcx
18000658e:     	js	0x1800065a9 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4039>
180006590:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
180006596:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
18000659c:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800065a2:     	movsd	%xmm0, (%rdi,%rcx,8)
1800065a7:     	jmp	0x1800065b6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4046>
1800065a9:     	movb	$0x1, (%r15)
1800065ad:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800065b6:     	cmpb	$0x0, (%r15)
1800065ba:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800065c0:     	movq	(%r12), %rax
1800065c4:     	leaq	0xb(%rax), %r8
1800065c8:     	cmpq	%r13, %r8
1800065cb:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
1800065d1:     	movq	0x8(%rsi,%rbp,8), %rdx
1800065d6:     	movq	%r8, (%r12)
1800065da:     	cmpb	$0x0, (%r15)
1800065de:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800065e4:     	movq	%rcx, (%rsi,%rax,8)
1800065e8:     	movq	%rdx, 0x8(%rsi,%rax,8)
1800065ed:     	movq	(%r12), %rdx
1800065f1:     	cmpq	%r13, %rdx
1800065f4:     	movq	%rdx, %rcx
1800065f7:     	jle	0x180006603 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4093>
1800065f9:     	movb	$0x2, (%r15)
1800065fd:     	movq	(%r12), %rdx
180006601:     	xorl	%ecx, %ecx
180006603:     	leaq	0x3(%rdx), %r8
180006607:     	cmpq	%r13, %r8
18000660a:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006610:     	movq	%r8, (%r12)
180006614:     	cmpb	$0x0, (%r15)
180006618:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
18000661e:     	movq	%rdx, %r8
180006621:     	sarq	$0x3f, %r8
180006625:     	andq	%r13, %r8
180006628:     	leaq	(%rsi,%rdx,8), %r9
18000662c:     	movq	$0x0, (%r9,%r8,8)
180006634:     	xorl	%r8d, %r8d
180006637:     	cmpq	$-0x1, %rdx
18000663b:     	movl	$0x0, %r10d
180006641:     	cmovlq	%r13, %r10
180006645:     	movq	$0x0, 0x8(%r9,%r10,8)
18000664e:     	cmpq	$-0x2, %rdx
180006652:     	cmovlq	%r13, %r8
180006656:     	movq	%rcx, 0x10(%r9,%r8,8)
18000665b:     	cmpb	$0x0, (%r15)
18000665f:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006665:     	leaq	(%rsi,%rax,8), %rcx
180006669:     	movq	%rdx, 0x30(%rcx)
18000666d:     	movq	$0x0, 0x18(%rcx)
180006675:     	movq	(%r12), %rdx
180006679:     	leaq	0x4(%rdx), %r8
18000667d:     	cmpq	%r13, %r8
180006680:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006686:     	movq	%r8, (%r12)
18000668a:     	cmpb	$0x0, (%r15)
18000668e:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006694:     	testq	%rdx, %rdx
180006697:     	js	0x1800066bf <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x414f>
180006699:     	movq	$0x0, (%rdi,%rdx,8)
1800066a1:     	leaq	(%rsi,%rdx,8), %r8
1800066a5:     	movq	$0x1, 0x8(%rsi,%rdx,8)
1800066ae:     	movq	$0x0, 0x10(%rdi,%rdx,8)
1800066b7:     	movl	$0x1, %r9d
1800066bd:     	jmp	0x1800066cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x415c>
1800066bf:     	movb	$0x1, (%r15)
1800066c3:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
1800066c9:     	movq	%r12, %r8
1800066cc:     	movq	%r9, 0x18(%r8)
1800066d0:     	cmpb	$0x0, (%r15)
1800066d4:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800066da:     	movq	%rdx, 0x10(%rcx)
1800066de:     	movq	$0x0, 0x48(%rdi,%rax,8)
1800066e7:     	movq	$0x1, 0x50(%rcx)
1800066ef:     	movq	$-0x1, 0x20(%rcx)
1800066f7:     	movq	$-0x1, 0x28(%rcx)
1800066ff:     	movq	$-0x1, 0x38(%rcx)
180006707:     	movq	$-0x1, 0x40(%rcx)
18000670f:     	cmpb	$0x0, (%r15)
180006713:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006719:     	movq	%rax, 0x40(%rsi,%rbp,8)
18000671e:     	movq	$0x1, 0x18(%rsi,%rbp,8)
180006727:     	movq	0x30(%rsi,%rbp,8), %rax
18000672c:     	movq	%rax, %rdx
18000672f:     	sarq	$0x3f, %rdx
180006733:     	andq	%r13, %rdx
180006736:     	leaq	(%rsi,%rax,8), %rcx
18000673a:     	movq	%rdx, 0x78(%rsp)
18000673f:     	movq	%rcx, 0x80(%rsp)
180006747:     	cmpq	$0x0, (%rcx,%rdx,8)
18000674c:     	jle	0x1800069e0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4470>
180006752:     	leaq	(,%r13,8), %rcx
18000675a:     	xorl	%edx, %edx
18000675c:     	cmpq	$-0x2, %rax
180006760:     	movl	$0x0, %eax
180006765:     	movq	%rax, 0x70(%rsp)
18000676a:     	cmovgeq	%rdx, %rcx
18000676e:     	movq	%rcx, 0x88(%rsp)
180006776:     	movq	0x20(%rsi,%rbp,8), %rax
18000677b:     	testq	%rax, %rax
18000677e:     	js	0x180006a64 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x44f4>
180006784:     	movq	0x80(%rsp), %rcx
18000678c:     	movq	0x88(%rsp), %rdx
180006794:     	movq	0x10(%rcx,%rdx), %rcx
180006799:     	addq	0x70(%rsp), %rcx
18000679e:     	leaq	(%rsi,%rcx,8), %rdx
1800067a2:     	sarq	$0x3f, %rcx
1800067a6:     	andq	%r13, %rcx
1800067a9:     	movq	(%rdx,%rcx,8), %rcx
1800067ad:     	movq	%rcx, 0x60(%rsp)
1800067b2:     	movq	0x8(%r12), %rcx
1800067b7:     	leaq	0x1(%rcx), %rdx
1800067bb:     	movq	%rdx, 0x8(%r12)
1800067c0:     	cmpq	0x10(%r12), %rcx
1800067c5:     	jge	0x180006a64 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x44f4>
1800067cb:     	movq	0x60(%rsp), %rcx
1800067d0:     	movq	%rcx, 0x48(%rsp)
1800067d5:     	movq	%rax, 0x40(%rsp)
1800067da:     	movq	%r13, 0x30(%rsp)
1800067df:     	movq	%r15, 0x28(%rsp)
1800067e4:     	movq	%r12, 0x20(%rsp)
1800067e9:     	movq	$-0x1, 0x50(%rsp)
1800067f2:     	movq	$0x0, 0x38(%rsp)
1800067fb:     	leaq	0x6e(%rsp), %rcx
180006800:     	leaq	0xc0(%rsp), %rdx
180006808:     	movq	%rdi, %r8
18000680b:     	movq	%rsi, %r9
18000680e:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180006813:     	testl	%eax, %eax
180006815:     	jne	0x180006a76 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4506>
18000681b:     	cmpb	$0x0, (%r15)
18000681f:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006825:     	movq	0x8(%r12), %rcx
18000682a:     	leaq	-0x1(%rcx), %rax
18000682e:     	movq	%rax, 0x8(%r12)
180006833:     	movq	0x28(%rsi,%rbp,8), %rax
180006838:     	testq	%rax, %rax
18000683b:     	js	0x180006a80 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4510>
180006841:     	movq	%rcx, 0x8(%r12)
180006846:     	cmpq	0x10(%r12), %rcx
18000684b:     	jg	0x180006a80 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4510>
180006851:     	movq	0x60(%rsp), %rcx
180006856:     	movq	%rcx, 0x48(%rsp)
18000685b:     	movq	%rax, 0x40(%rsp)
180006860:     	movq	%r13, 0x30(%rsp)
180006865:     	movq	%r15, 0x28(%rsp)
18000686a:     	movq	%r12, 0x20(%rsp)
18000686f:     	movq	$-0x1, 0x50(%rsp)
180006878:     	movq	$0x0, 0x38(%rsp)
180006881:     	leaq	0x6d(%rsp), %rcx
180006886:     	leaq	0xb8(%rsp), %rdx
18000688e:     	movq	%rdi, %r8
180006891:     	movq	%rsi, %r9
180006894:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
180006899:     	testl	%eax, %eax
18000689b:     	jne	0x180006a92 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4522>
1800068a1:     	cmpb	$0x0, (%r15)
1800068a5:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800068ab:     	movq	0x8(%r12), %rcx
1800068b0:     	leaq	-0x1(%rcx), %rax
1800068b4:     	movq	%rax, 0x8(%r12)
1800068b9:     	movq	0x38(%rsi,%rbp,8), %rax
1800068be:     	testq	%rax, %rax
1800068c1:     	js	0x180006a9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x452c>
1800068c7:     	movq	%rcx, 0x8(%r12)
1800068cc:     	cmpq	0x10(%r12), %rcx
1800068d1:     	jg	0x180006a9c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x452c>
1800068d7:     	movq	0x60(%rsp), %rcx
1800068dc:     	movq	%rcx, 0x48(%rsp)
1800068e1:     	movq	%rax, 0x40(%rsp)
1800068e6:     	movq	%r13, 0x30(%rsp)
1800068eb:     	movq	%r15, 0x28(%rsp)
1800068f0:     	movq	%r12, 0x20(%rsp)
1800068f5:     	movq	$-0x1, 0x50(%rsp)
1800068fe:     	movq	$0x0, 0x38(%rsp)
180006907:     	leaq	0x6c(%rsp), %rcx
18000690c:     	leaq	0xb0(%rsp), %rdx
180006914:     	movq	%rdi, %r8
180006917:     	movq	%rsi, %r9
18000691a:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
18000691f:     	testl	%eax, %eax
180006921:     	jne	0x180006aae <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x453e>
180006927:     	cmpb	$0x0, (%r15)
18000692b:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006931:     	movq	0x8(%r12), %rcx
180006936:     	leaq	-0x1(%rcx), %rax
18000693a:     	movq	%rax, 0x8(%r12)
18000693f:     	movq	0x40(%rsi,%rbp,8), %rax
180006944:     	testq	%rax, %rax
180006947:     	js	0x180006ab8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4548>
18000694d:     	movq	%rcx, 0x8(%r12)
180006952:     	cmpq	0x10(%r12), %rcx
180006957:     	jg	0x180006ab8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4548>
18000695d:     	movq	0x60(%rsp), %rcx
180006962:     	movq	%rcx, 0x48(%rsp)
180006967:     	movq	%rax, 0x40(%rsp)
18000696c:     	movq	%r13, 0x30(%rsp)
180006971:     	movq	%r15, 0x28(%rsp)
180006976:     	movq	%r12, 0x20(%rsp)
18000697b:     	movq	$-0x1, 0x50(%rsp)
180006984:     	movq	$0x0, 0x38(%rsp)
18000698d:     	leaq	0x6b(%rsp), %rcx
180006992:     	leaq	0xa8(%rsp), %rdx
18000699a:     	movq	%rdi, %r8
18000699d:     	movq	%rsi, %r9
1800069a0:     	callq	0x180005480 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x2f10>
1800069a5:     	testl	%eax, %eax
1800069a7:     	jne	0x180006aca <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x455a>
1800069ad:     	cmpb	$0x0, (%r15)
1800069b1:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
1800069b7:     	movq	0x70(%rsp), %r8
1800069bc:     	incq	%r8
1800069bf:     	decq	0x8(%r12)
1800069c4:     	movq	0x78(%rsp), %rax
1800069c9:     	movq	0x80(%rsp), %rcx
1800069d1:     	movq	%r8, 0x70(%rsp)
1800069d6:     	cmpq	(%rcx,%rax,8), %r8
1800069da:     	jl	0x180006776 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4206>
1800069e0:     	movq	(%r12), %rcx
1800069e4:     	cmpq	%r13, %rcx
1800069e7:     	movq	%rcx, %rdx
1800069ea:     	jle	0x1800069f6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4486>
1800069ec:     	movb	$0x2, (%r15)
1800069f0:     	movq	(%r12), %rcx
1800069f4:     	xorl	%edx, %edx
1800069f6:     	leaq	0x3(%rcx), %rax
1800069fa:     	cmpq	%r13, %rax
1800069fd:     	jg	0x180006170 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3c00>
180006a03:     	movq	%rax, (%r12)
180006a07:     	cmpb	$0x0, (%r15)
180006a0b:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006a11:     	movq	%rcx, %rax
180006a14:     	sarq	$0x3f, %rax
180006a18:     	andq	%r13, %rax
180006a1b:     	leaq	(%rsi,%rcx,8), %r8
180006a1f:     	movq	$0x0, (%r8,%rax,8)
180006a27:     	xorl	%eax, %eax
180006a29:     	cmpq	$-0x1, %rcx
180006a2d:     	movl	$0x0, %r9d
180006a33:     	cmovlq	%r13, %r9
180006a37:     	movq	$0x0, 0x8(%r8,%r9,8)
180006a40:     	cmpq	$-0x2, %rcx
180006a44:     	cmovgeq	%rax, %r13
180006a48:     	movq	%rdx, 0x10(%r8,%r13,8)
180006a4d:     	cmpb	$0x0, (%r15)
180006a51:     	jne	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006a57:     	movq	%rcx, 0x30(%rsi,%rbp,8)
180006a5c:     	movb	$0x0, (%rbx)
180006a5f:     	jmp	0x180005a56 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e6>
180006a64:     	movb	$0x1, (%r15)
180006a68:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
180006a71:     	jmp	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006a76:     	movq	0xc0(%rsp), %rcx
180006a7e:     	jmp	0x180006ad2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4562>
180006a80:     	movb	$0x1, (%r15)
180006a84:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
180006a8d:     	jmp	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006a92:     	movq	0xb8(%rsp), %rcx
180006a9a:     	jmp	0x180006ad2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4562>
180006a9c:     	movb	$0x1, (%r15)
180006aa0:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180006aa9:     	jmp	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006aae:     	movq	0xb0(%rsp), %rcx
180006ab6:     	jmp	0x180006ad2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4562>
180006ab8:     	movb	$0x1, (%r15)
180006abc:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
180006ac5:     	jmp	0x18000623e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x3cce>
180006aca:     	movq	0xa8(%rsp), %rcx
180006ad2:     	movq	%rcx, (%r14)
180006ad5:     	jmp	0x180005a56 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x34e6>
180006ada:     	int3
180006adb:     	int3
180006adc:     	int3
180006add:     	int3
180006ade:     	int3
180006adf:     	int3
180006ae0:     	pushq	%rbx
180006ae2:     	subq	$0x20, %rsp
180006ae6:     	movq	%rcx, %rbx
180006ae9:     	callq	*0x3601(%rip)           # 0x18000a0f0
180006aef:     	movl	%eax, (%rbx)
180006af1:     	addq	$0x20, %rsp
180006af5:     	popq	%rbx
180006af6:     	retq
180006af7:     	int3
180006af8:     	int3
180006af9:     	int3
180006afa:     	int3
180006afb:     	int3
180006afc:     	int3
180006afd:     	int3
180006afe:     	int3
180006aff:     	int3
180006b00:     	movl	(%rcx), %ecx
180006b02:     	jmpq	*0x3707(%rip)           # 0x18000a210
180006b09:     	int3
180006b0a:     	int3
180006b0b:     	int3
180006b0c:     	int3
180006b0d:     	int3
180006b0e:     	int3
180006b0f:     	int3
180006b10:     	pushq	%rbp
180006b12:     	pushq	%rbx
180006b13:     	pushq	%rsi
180006b14:     	pushq	%rdi
180006b15:     	pushq	%r14
180006b17:     	pushq	%r15
180006b19:     	movq	%rsp, %rbp
180006b1c:     	subq	$0x48, %rsp
180006b20:     	movq	0x36b9(%rip), %rax      # 0x18000a1e0
180006b27:     	xorl	%r15d, %r15d
180006b2a:     	movq	%rcx, %rsi
180006b2d:     	movq	%r15, 0x38(%rbp)
180006b31:     	movl	%r15d, %r14d
180006b34:     	movq	%r15, 0x50(%rbp)
180006b38:     	movq	%r15, 0x48(%rbp)
180006b3c:     	cmpq	%rax, 0x8(%rcx)
180006b40:     	jne	0x180006cae <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x473e>
180006b46:     	leaq	0x48(%rbp), %rax
180006b4a:     	leaq	0x50(%rbp), %r9
180006b4e:     	movq	%rax, 0x20(%rsp)
180006b53:     	leaq	0x38(%rbp), %r8
180006b57:     	leaq	0x45c6(%rip), %rdx      # 0x18000b124
180006b5e:     	callq	*0x35cc(%rip)           # 0x18000a130
180006b64:     	testl	%eax, %eax
180006b66:     	jne	0x180006ca4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4734>
180006b6c:     	movq	0x48(%rbp), %rbx
180006b70:     	testq	%rbx, %rbx
180006b73:     	je	0x180006c95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4725>
180006b79:     	cmpq	0x3750(%rip), %rbx      # 0x18000a2d0
180006b80:     	je	0x180006c95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4725>
180006b86:     	movq	0x8(%rbx), %rax
180006b8a:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006b94:     	je	0x180006c95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4725>
180006b9a:     	movq	0x20(%rbx), %rcx
180006b9e:     	callq	*0x35dc(%rip)           # 0x18000a180
180006ba4:     	movq	0x28(%rbx), %rcx
180006ba8:     	movq	%rax, %rdi
180006bab:     	callq	*0x35cf(%rip)           # 0x18000a180
180006bb1:     	movq	0x30(%rbx), %rcx
180006bb5:     	movq	%rax, %r14
180006bb8:     	callq	*0x35d2(%rip)           # 0x18000a190
180006bbe:     	leaq	-0x10(%rbp), %r8
180006bc2:     	movl	%eax, %ebx
180006bc4:     	leaq	-0x18(%rbp), %rdx
180006bc8:     	leaq	0x40(%rbp), %rcx
180006bcc:     	callq	*0x35ce(%rip)           # 0x18000a1a0
180006bd2:     	callq	*0x3588(%rip)           # 0x18000a160
180006bd8:     	movq	%rax, %rsi
180006bdb:     	testq	%rax, %rax
180006bde:     	je	0x180006c8b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x471b>
180006be4:     	movl	%ebx, %r8d
180006be7:     	movq	%rdi, %rdx
180006bea:     	movq	%r14, %rcx
180006bed:     	callq	*0x3665(%rip)           # 0x18000a258
180006bf3:     	movq	%rax, %rdi
180006bf6:     	testq	%rax, %rax
180006bf9:     	je	0x180006c8b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x471b>
180006bff:     	callq	*0x3663(%rip)           # 0x18000a268
180006c05:     	xorl	%r9d, %r9d
180006c08:     	movq	%rsi, %r8
180006c0b:     	movq	%rax, %rcx
180006c0e:     	movq	%rdi, %rdx
180006c11:     	callq	*0x3629(%rip)           # 0x18000a240
180006c17:     	movl	(%rsi), %ecx
180006c19:     	movq	%rax, %rbx
180006c1c:     	testl	%ecx, %ecx
180006c1e:     	js	0x180006c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x46c0>
180006c20:     	subl	$0x1, %ecx
180006c23:     	movl	%ecx, (%rsi)
180006c25:     	jne	0x180006c30 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x46c0>
180006c27:     	movq	%rsi, %rcx
180006c2a:     	callq	*0x3598(%rip)           # 0x18000a1c8
180006c30:     	movl	(%rdi), %eax
180006c32:     	testl	%eax, %eax
180006c34:     	js	0x180006c46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x46d6>
180006c36:     	subl	$0x1, %eax
180006c39:     	movl	%eax, (%rdi)
180006c3b:     	jne	0x180006c46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x46d6>
180006c3d:     	movq	%rdi, %rcx
180006c40:     	callq	*0x3582(%rip)           # 0x18000a1c8
180006c46:     	testq	%rbx, %rbx
180006c49:     	je	0x180006c8b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x471b>
180006c4b:     	movq	-0x10(%rbp), %r8
180006c4f:     	movq	-0x18(%rbp), %rdx
180006c53:     	movq	0x40(%rbp), %rcx
180006c57:     	callq	*0x3573(%rip)           # 0x18000a1d0
180006c5d:     	movq	%rbx, %rcx
180006c60:     	callq	*0x35c2(%rip)           # 0x18000a228
180006c66:     	movl	(%rbx), %eax
180006c68:     	testl	%eax, %eax
180006c6a:     	js	0x180006c95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4725>
180006c6c:     	subl	$0x1, %eax
180006c6f:     	movl	%eax, (%rbx)
180006c71:     	jne	0x180006c95 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4725>
180006c73:     	movq	%rbx, %rcx
180006c76:     	callq	*0x354c(%rip)           # 0x18000a1c8
180006c7c:     	xorl	%eax, %eax
180006c7e:     	addq	$0x48, %rsp
180006c82:     	popq	%r15
180006c84:     	popq	%r14
180006c86:     	popq	%rdi
180006c87:     	popq	%rsi
180006c88:     	popq	%rbx
180006c89:     	popq	%rbp
180006c8a:     	retq
180006c8b:     	movq	0x40(%rbp), %rcx
180006c8f:     	callq	*0x356b(%rip)           # 0x18000a200
180006c95:     	xorl	%eax, %eax
180006c97:     	addq	$0x48, %rsp
180006c9b:     	popq	%r15
180006c9d:     	popq	%r14
180006c9f:     	popq	%rdi
180006ca0:     	popq	%rsi
180006ca1:     	popq	%rbx
180006ca2:     	popq	%rbp
180006ca3:     	retq
180006ca4:     	movq	0x38(%rbp), %rbx
180006ca8:     	movq	0x50(%rbp), %r14
180006cac:     	jmp	0x180006cb5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4745>
180006cae:     	movq	%rsi, %rbx
180006cb1:     	movq	%rbx, 0x38(%rbp)
180006cb5:     	cmpq	0x3614(%rip), %rbx      # 0x18000a2d0
180006cbc:     	jne	0x180006d54 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x47e4>
180006cc2:     	leaq	-0x18(%rbp), %r8
180006cc6:     	leaq	-0x10(%rbp), %rdx
180006cca:     	leaq	0x40(%rbp), %rcx
180006cce:     	callq	*0x344c(%rip)           # 0x18000a120
180006cd4:     	movq	0x35f5(%rip), %rax      # 0x18000a2d0
180006cdb:     	cmpq	%rax, 0x40(%rbp)
180006cdf:     	jne	0x180006cf4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4784>
180006ce1:     	movq	0x35c8(%rip), %rcx      # 0x18000a2b0
180006ce8:     	leaq	0x43e9(%rip), %rdx      # 0x18000b0d8
180006cef:     	jmp	0x180006e15 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48a5>
180006cf4:     	movq	0x40(%rbp), %rcx
180006cf8:     	testq	%rcx, %rcx
180006cfb:     	je	0x180006d0a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x479a>
180006cfd:     	movl	(%rcx), %eax
180006cff:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d04:     	jae	0x180006d0a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x479a>
180006d06:     	incl	%eax
180006d08:     	movl	%eax, (%rcx)
180006d0a:     	movq	-0x10(%rbp), %rcx
180006d0e:     	testq	%rcx, %rcx
180006d11:     	je	0x180006d20 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x47b0>
180006d13:     	movl	(%rcx), %eax
180006d15:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d1a:     	jae	0x180006d20 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x47b0>
180006d1c:     	incl	%eax
180006d1e:     	movl	%eax, (%rcx)
180006d20:     	movq	-0x18(%rbp), %r8
180006d24:     	testq	%r8, %r8
180006d27:     	je	0x180006d3c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x47cc>
180006d29:     	movl	(%r8), %eax
180006d2c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d31:     	jae	0x180006d3c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x47cc>
180006d33:     	incl	%eax
180006d35:     	movl	%eax, (%r8)
180006d38:     	movq	-0x18(%rbp), %r8
180006d3c:     	movq	-0x10(%rbp), %rdx
180006d40:     	movq	0x40(%rbp), %rcx
180006d44:     	callq	*0x3486(%rip)           # 0x18000a1d0
180006d4a:     	movl	$0x1, %ebx
180006d4f:     	jmp	0x180006e21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48b1>
180006d54:     	movq	0x8(%rbx), %rcx
180006d58:     	movl	0xa8(%rcx), %eax
180006d5e:     	testl	%eax, %eax
180006d60:     	jns	0x180006df6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4886>
180006d66:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180006d70:     	je	0x180006df6 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4886>
180006d76:     	movq	%r14, %rdx
180006d79:     	movq	%rbx, %rcx
180006d7c:     	callq	*0x3366(%rip)           # 0x18000a0e8
180006d82:     	movq	%rax, %rdi
180006d85:     	testq	%rax, %rax
180006d88:     	je	0x180006e1e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48ae>
180006d8e:     	movq	0x8(%rax), %rax
180006d92:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
180006d9c:     	jne	0x180006dcd <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x485d>
180006d9e:     	movq	0x34fb(%rip), %rcx      # 0x18000a2a0
180006da5:     	leaq	0x434c(%rip), %rdx      # 0x18000b0f8
180006dac:     	movq	(%rcx), %rcx
180006daf:     	callq	*0x34f3(%rip)           # 0x18000a2a8
180006db5:     	movl	(%rdi), %eax
180006db7:     	testl	%eax, %eax
180006db9:     	js	0x180006e1e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48ae>
180006dbb:     	subl	$0x1, %eax
180006dbe:     	movl	%eax, (%rdi)
180006dc0:     	jne	0x180006e1e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48ae>
180006dc2:     	movq	%rdi, %rcx
180006dc5:     	callq	*0x33fd(%rip)           # 0x18000a1c8
180006dcb:     	jmp	0x180006e1e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48ae>
180006dcd:     	movl	(%rdi), %eax
180006dcf:     	testl	%eax, %eax
180006dd1:     	js	0x180006de3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4873>
180006dd3:     	subl	$0x1, %eax
180006dd6:     	movl	%eax, (%rdi)
180006dd8:     	jne	0x180006de3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4873>
180006dda:     	movq	%rdi, %rcx
180006ddd:     	callq	*0x33e5(%rip)           # 0x18000a1c8
180006de3:     	movq	%r14, %rdx
180006de6:     	movq	%rbx, %rcx
180006de9:     	callq	*0x3471(%rip)           # 0x18000a260
180006def:     	movl	$0x1, %ebx
180006df4:     	jmp	0x180006e21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48b1>
180006df6:     	btl	$0x1e, %eax
180006dfa:     	jae	0x180006e07 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4897>
180006dfc:     	movq	%rbx, %rdx
180006dff:     	callq	*0x345b(%rip)           # 0x18000a260
180006e05:     	jmp	0x180006e1e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x48ae>
180006e07:     	movq	0x3492(%rip), %rcx      # 0x18000a2a0
180006e0e:     	leaq	0x42e3(%rip), %rdx      # 0x18000b0f8
180006e15:     	movq	(%rcx), %rcx
180006e18:     	callq	*0x348a(%rip)           # 0x18000a2a8
180006e1e:     	movl	%r15d, %ebx
180006e21:     	movq	0x48(%rbp), %rdi
180006e25:     	testq	%rdi, %rdi
180006e28:     	je	0x180006f4b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49db>
180006e2e:     	cmpq	0x349b(%rip), %rdi      # 0x18000a2d0
180006e35:     	je	0x180006f4b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49db>
180006e3b:     	movq	0x8(%rdi), %rax
180006e3f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006e49:     	je	0x180006f4b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49db>
180006e4f:     	movq	0x20(%rdi), %rcx
180006e53:     	movq	%r12, 0x40(%rsp)
180006e58:     	callq	*0x3322(%rip)           # 0x18000a180
180006e5e:     	movq	0x28(%rdi), %rcx
180006e62:     	movq	%rax, %r14
180006e65:     	callq	*0x3315(%rip)           # 0x18000a180
180006e6b:     	movq	0x30(%rdi), %rcx
180006e6f:     	movq	%rax, %r12
180006e72:     	callq	*0x3318(%rip)           # 0x18000a190
180006e78:     	leaq	-0x10(%rbp), %r8
180006e7c:     	movl	%eax, %edi
180006e7e:     	leaq	-0x18(%rbp), %rdx
180006e82:     	leaq	0x40(%rbp), %rcx
180006e86:     	callq	*0x3314(%rip)           # 0x18000a1a0
180006e8c:     	callq	*0x32ce(%rip)           # 0x18000a160
180006e92:     	movq	%rax, %r15
180006e95:     	testq	%rax, %rax
180006e98:     	je	0x180006f3c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49cc>
180006e9e:     	movl	%edi, %r8d
180006ea1:     	movq	%r14, %rdx
180006ea4:     	movq	%r12, %rcx
180006ea7:     	callq	*0x33ab(%rip)           # 0x18000a258
180006ead:     	movq	%rax, %r14
180006eb0:     	testq	%rax, %rax
180006eb3:     	je	0x180006f3c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49cc>
180006eb9:     	callq	*0x33a9(%rip)           # 0x18000a268
180006ebf:     	xorl	%r9d, %r9d
180006ec2:     	movq	%r15, %r8
180006ec5:     	movq	%rax, %rcx
180006ec8:     	movq	%r14, %rdx
180006ecb:     	callq	*0x336f(%rip)           # 0x18000a240
180006ed1:     	movl	(%r15), %ecx
180006ed4:     	movq	%rax, %rdi
180006ed7:     	testl	%ecx, %ecx
180006ed9:     	js	0x180006eec <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x497c>
180006edb:     	subl	$0x1, %ecx
180006ede:     	movl	%ecx, (%r15)
180006ee1:     	jne	0x180006eec <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x497c>
180006ee3:     	movq	%r15, %rcx
180006ee6:     	callq	*0x32dc(%rip)           # 0x18000a1c8
180006eec:     	movl	(%r14), %eax
180006eef:     	testl	%eax, %eax
180006ef1:     	js	0x180006f04 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4994>
180006ef3:     	subl	$0x1, %eax
180006ef6:     	movl	%eax, (%r14)
180006ef9:     	jne	0x180006f04 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4994>
180006efb:     	movq	%r14, %rcx
180006efe:     	callq	*0x32c4(%rip)           # 0x18000a1c8
180006f04:     	testq	%rdi, %rdi
180006f07:     	je	0x180006f3c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49cc>
180006f09:     	movq	-0x10(%rbp), %r8
180006f0d:     	movq	-0x18(%rbp), %rdx
180006f11:     	movq	0x40(%rbp), %rcx
180006f15:     	callq	*0x32b5(%rip)           # 0x18000a1d0
180006f1b:     	movq	%rdi, %rcx
180006f1e:     	callq	*0x3304(%rip)           # 0x18000a228
180006f24:     	movl	(%rdi), %eax
180006f26:     	testl	%eax, %eax
180006f28:     	js	0x180006f46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49d6>
180006f2a:     	subl	$0x1, %eax
180006f2d:     	movl	%eax, (%rdi)
180006f2f:     	jne	0x180006f46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49d6>
180006f31:     	movq	%rdi, %rcx
180006f34:     	callq	*0x328e(%rip)           # 0x18000a1c8
180006f3a:     	jmp	0x180006f46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49d6>
180006f3c:     	movq	0x40(%rbp), %rcx
180006f40:     	callq	*0x32ba(%rip)           # 0x18000a200
180006f46:     	movq	0x40(%rsp), %r12
180006f4b:     	movl	(%rsi), %ecx
180006f4d:     	testl	%ecx, %ecx
180006f4f:     	js	0x180006f61 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49f1>
180006f51:     	subl	$0x1, %ecx
180006f54:     	movl	%ecx, (%rsi)
180006f56:     	jne	0x180006f61 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x49f1>
180006f58:     	movq	%rsi, %rcx
180006f5b:     	callq	*0x3267(%rip)           # 0x18000a1c8
180006f61:     	movl	%ebx, %eax
180006f63:     	addq	$0x48, %rsp
180006f67:     	popq	%r15
180006f69:     	popq	%r14
180006f6b:     	popq	%rdi
180006f6c:     	popq	%rsi
180006f6d:     	popq	%rbx
180006f6e:     	popq	%rbp
180006f6f:     	retq
180006f70:     	movq	%rbx, 0x8(%rsp)
180006f75:     	movq	%rsi, 0x10(%rsp)
180006f7a:     	pushq	%rdi
180006f7b:     	subq	$0x20, %rsp
180006f7f:     	cmpq	$0x0, 0xad11(%rip)      # 0x180011c98
180006f87:     	movq	%rcx, %rsi
180006f8a:     	movslq	%edx, %rdi
180006f8d:     	jne	0x180006fdd <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a6d>
180006f8f:     	leaq	0x4192(%rip), %rcx      # 0x18000b128
180006f96:     	callq	*0x329c(%rip)           # 0x18000a238
180006f9c:     	movq	%rax, %rbx
180006f9f:     	testq	%rax, %rax
180006fa2:     	je	0x180006ff1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a81>
180006fa4:     	leaq	0x4185(%rip), %rdx      # 0x18000b130
180006fab:     	movq	%rax, %rcx
180006fae:     	callq	*0x31b4(%rip)           # 0x18000a168
180006fb4:     	movl	(%rbx), %ecx
180006fb6:     	movq	%rax, 0xacdb(%rip)      # 0x180011c98
180006fbd:     	testl	%ecx, %ecx
180006fbf:     	js	0x180006fd8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a68>
180006fc1:     	subl	$0x1, %ecx
180006fc4:     	movl	%ecx, (%rbx)
180006fc6:     	jne	0x180006fd8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a68>
180006fc8:     	movq	%rbx, %rcx
180006fcb:     	callq	*0x31f7(%rip)           # 0x18000a1c8
180006fd1:     	movq	0xacc0(%rip), %rax      # 0x180011c98
180006fd8:     	testq	%rax, %rax
180006fdb:     	je	0x180006ff1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a81>
180006fdd:     	movq	%rdi, %rdx
180006fe0:     	movq	%rsi, %rcx
180006fe3:     	callq	*0x32cf(%rip)           # 0x18000a2b8
180006fe9:     	movq	%rax, %rbx
180006fec:     	testq	%rax, %rax
180006fef:     	jne	0x180007003 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4a93>
180006ff1:     	xorl	%eax, %eax
180006ff3:     	movq	0x30(%rsp), %rbx
180006ff8:     	movq	0x38(%rsp), %rsi
180006ffd:     	addq	$0x20, %rsp
180007001:     	popq	%rdi
180007002:     	retq
180007003:     	movq	0xac8e(%rip), %rcx      # 0x180011c98
18000700a:     	xorl	%r8d, %r8d
18000700d:     	movq	%rbx, %rdx
180007010:     	callq	*0x3182(%rip)           # 0x18000a198
180007016:     	movl	(%rbx), %ecx
180007018:     	movq	%rax, %rdi
18000701b:     	testl	%ecx, %ecx
18000701d:     	js	0x18000702f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4abf>
18000701f:     	subl	$0x1, %ecx
180007022:     	movl	%ecx, (%rbx)
180007024:     	jne	0x18000702f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4abf>
180007026:     	movq	%rbx, %rcx
180007029:     	callq	*0x3199(%rip)           # 0x18000a1c8
18000702f:     	movq	0x30(%rsp), %rbx
180007034:     	movq	%rdi, %rax
180007037:     	movq	0x38(%rsp), %rsi
18000703c:     	addq	$0x20, %rsp
180007040:     	popq	%rdi
180007041:     	retq
180007042:     	int3
180007043:     	int3
180007044:     	int3
180007045:     	int3
180007046:     	int3
180007047:     	int3
180007048:     	int3
180007049:     	int3
18000704a:     	int3
18000704b:     	int3
18000704c:     	int3
18000704d:     	int3
18000704e:     	int3
18000704f:     	int3
180007050:     	movq	%rbx, 0x8(%rsp)
180007055:     	movq	%rsi, 0x10(%rsp)
18000705a:     	pushq	%rdi
18000705b:     	subq	$0x20, %rsp
18000705f:     	movq	0xac2a(%rip), %rax      # 0x180011c90
180007066:     	movq	%rdx, %rdi
180007069:     	movq	%rcx, %rsi
18000706c:     	testq	%rax, %rax
18000706f:     	jne	0x1800070d1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b61>
180007071:     	leaq	0x40c0(%rip), %rcx      # 0x18000b138
180007078:     	callq	*0x31ba(%rip)           # 0x18000a238
18000707e:     	movq	%rax, %rbx
180007081:     	testq	%rax, %rax
180007084:     	je	0x1800070bf <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b4f>
180007086:     	leaq	0x40c3(%rip), %rdx      # 0x18000b150
18000708d:     	movq	%rax, %rcx
180007090:     	callq	*0x30d2(%rip)           # 0x18000a168
180007096:     	movl	(%rbx), %ecx
180007098:     	movq	%rax, 0xabf1(%rip)      # 0x180011c90
18000709f:     	testl	%ecx, %ecx
1800070a1:     	js	0x1800070ba <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b4a>
1800070a3:     	subl	$0x1, %ecx
1800070a6:     	movl	%ecx, (%rbx)
1800070a8:     	jne	0x1800070ba <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b4a>
1800070aa:     	movq	%rbx, %rcx
1800070ad:     	callq	*0x3115(%rip)           # 0x18000a1c8
1800070b3:     	movq	0xabd6(%rip), %rax      # 0x180011c90
1800070ba:     	testq	%rax, %rax
1800070bd:     	jne	0x1800070d1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4b61>
1800070bf:     	xorl	%eax, %eax
1800070c1:     	movq	0x30(%rsp), %rbx
1800070c6:     	movq	0x38(%rsp), %rsi
1800070cb:     	addq	$0x20, %rsp
1800070cf:     	popq	%rdi
1800070d0:     	retq
1800070d1:     	xorl	%r9d, %r9d
1800070d4:     	movq	%rdi, %r8
1800070d7:     	movq	%rsi, %rdx
1800070da:     	movq	%rax, %rcx
1800070dd:     	movq	0x30(%rsp), %rbx
1800070e2:     	movq	0x38(%rsp), %rsi
1800070e7:     	addq	$0x20, %rsp
1800070eb:     	popq	%rdi
1800070ec:     	jmpq	*0x30a5(%rip)           # 0x18000a198
1800070f3:     	int3
1800070f4:     	int3
1800070f5:     	int3
1800070f6:     	int3
1800070f7:     	int3
1800070f8:     	int3
1800070f9:     	int3
1800070fa:     	int3
1800070fb:     	int3
1800070fc:     	int3
1800070fd:     	int3
1800070fe:     	int3
1800070ff:     	int3
180007100:     	movq	%rbx, 0x8(%rsp)
180007105:     	movq	%rsi, 0x10(%rsp)
18000710a:     	pushq	%rdi
18000710b:     	subq	$0x20, %rsp
18000710f:     	movq	%rcx, %rbx
180007112:     	movq	%r8, %rdi
180007115:     	movq	0x10(%rcx), %rcx
180007119:     	movq	%rdx, %rsi
18000711c:     	testq	%rcx, %rcx
18000711f:     	je	0x18000712a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4bba>
180007121:     	movq	%r8, %rdx
180007124:     	callq	*%rsi
180007126:     	testl	%eax, %eax
180007128:     	jne	0x18000714d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4bdd>
18000712a:     	movq	0x18(%rbx), %rcx
18000712e:     	testq	%rcx, %rcx
180007131:     	je	0x18000714b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4bdb>
180007133:     	movq	%rdi, %rdx
180007136:     	movq	%rsi, %rax
180007139:     	movq	0x30(%rsp), %rbx
18000713e:     	movq	0x38(%rsp), %rsi
180007143:     	addq	$0x20, %rsp
180007147:     	popq	%rdi
180007148:     	jmpq	*%rax
18000714b:     	xorl	%eax, %eax
18000714d:     	movq	0x30(%rsp), %rbx
180007152:     	movq	0x38(%rsp), %rsi
180007157:     	addq	$0x20, %rsp
18000715b:     	popq	%rdi
18000715c:     	retq
18000715d:     	int3
18000715e:     	int3
18000715f:     	int3
180007160:     	pushq	%rbx
180007162:     	subq	$0x20, %rsp
180007166:     	movq	%rcx, %rbx
180007169:     	movq	0x10(%rcx), %rcx
18000716d:     	testq	%rcx, %rcx
180007170:     	je	0x18000718d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c1d>
180007172:     	movq	$0x0, 0x10(%rbx)
18000717a:     	movl	(%rcx), %eax
18000717c:     	testl	%eax, %eax
18000717e:     	js	0x18000718d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c1d>
180007180:     	subl	$0x1, %eax
180007183:     	movl	%eax, (%rcx)
180007185:     	jne	0x18000718d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c1d>
180007187:     	callq	*0x303b(%rip)           # 0x18000a1c8
18000718d:     	movq	0x18(%rbx), %rcx
180007191:     	testq	%rcx, %rcx
180007194:     	je	0x1800071b1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c41>
180007196:     	movq	$0x0, 0x18(%rbx)
18000719e:     	movl	(%rcx), %eax
1800071a0:     	testl	%eax, %eax
1800071a2:     	js	0x1800071b1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c41>
1800071a4:     	subl	$0x1, %eax
1800071a7:     	movl	%eax, (%rcx)
1800071a9:     	jne	0x1800071b1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c41>
1800071ab:     	callq	*0x3017(%rip)           # 0x18000a1c8
1800071b1:     	xorl	%eax, %eax
1800071b3:     	addq	$0x20, %rsp
1800071b7:     	popq	%rbx
1800071b8:     	retq
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
1800071c9:     	callq	*0x3049(%rip)           # 0x18000a218
1800071cf:     	movq	0x10(%rbx), %rcx
1800071d3:     	testq	%rcx, %rcx
1800071d6:     	je	0x1800071f3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c83>
1800071d8:     	movq	$0x0, 0x10(%rbx)
1800071e0:     	movl	(%rcx), %eax
1800071e2:     	testl	%eax, %eax
1800071e4:     	js	0x1800071f3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c83>
1800071e6:     	subl	$0x1, %eax
1800071e9:     	movl	%eax, (%rcx)
1800071eb:     	jne	0x1800071f3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4c83>
1800071ed:     	callq	*0x2fd5(%rip)           # 0x18000a1c8
1800071f3:     	movq	0x18(%rbx), %rcx
1800071f7:     	testq	%rcx, %rcx
1800071fa:     	je	0x180007217 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ca7>
1800071fc:     	movq	$0x0, 0x18(%rbx)
180007204:     	movl	(%rcx), %eax
180007206:     	testl	%eax, %eax
180007208:     	js	0x180007217 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ca7>
18000720a:     	subl	$0x1, %eax
18000720d:     	movl	%eax, (%rcx)
18000720f:     	jne	0x180007217 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ca7>
180007211:     	callq	*0x2fb1(%rip)           # 0x18000a1c8
180007217:     	movq	0x8(%rbx), %rax
18000721b:     	movq	%rbx, %rcx
18000721e:     	addq	$0x20, %rsp
180007222:     	popq	%rbx
180007223:     	jmpq	*0x140(%rax)
18000722a:     	int3
18000722b:     	int3
18000722c:     	int3
18000722d:     	int3
18000722e:     	int3
18000722f:     	int3
180007230:     	pushq	%rbx
180007232:     	subq	$0x30, %rsp
180007236:     	movq	%r8, %r10
180007239:     	leaq	0x58(%rsp), %rax
18000723e:     	movq	%rax, 0x28(%rsp)
180007243:     	leaq	0xa786(%rip), %r9       # 0x1800119d0
18000724a:     	movq	0x2f97(%rip), %rax      # 0x18000a1e8
180007251:     	leaq	0x3f28(%rip), %r8       # 0x18000b180
180007258:     	movq	%rdx, %r11
18000725b:     	movq	%rax, 0x20(%rsp)
180007260:     	movq	%rcx, %rbx
180007263:     	movq	%r10, %rdx
180007266:     	movq	%r11, %rcx
180007269:     	callq	*0x2e89(%rip)           # 0x18000a0f8
18000726f:     	testl	%eax, %eax
180007271:     	je	0x1800072cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d5c>
180007273:     	xorl	%r8d, %r8d
180007276:     	xorl	%edx, %edx
180007278:     	movq	%rbx, %rcx
18000727b:     	callq	*0x2fc7(%rip)           # 0x18000a248
180007281:     	movq	%rax, %rbx
180007284:     	testq	%rax, %rax
180007287:     	je	0x1800072cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d5c>
180007289:     	movq	0x58(%rsp), %rax
18000728e:     	movl	(%rax), %ecx
180007290:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180007296:     	jae	0x1800072a1 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d31>
180007298:     	incl	%ecx
18000729a:     	movl	%ecx, (%rax)
18000729c:     	movq	0x58(%rsp), %rax
1800072a1:     	xorl	%ecx, %ecx
1800072a3:     	movq	%rax, 0x10(%rbx)
1800072a7:     	callq	*0x2ecb(%rip)           # 0x18000a178
1800072ad:     	movq	%rax, 0x18(%rbx)
1800072b1:     	testq	%rax, %rax
1800072b4:     	jne	0x1800072d4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d64>
1800072b6:     	movl	(%rbx), %eax
1800072b8:     	testl	%eax, %eax
1800072ba:     	js	0x1800072cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d5c>
1800072bc:     	subl	$0x1, %eax
1800072bf:     	movl	%eax, (%rbx)
1800072c1:     	jne	0x1800072cc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d5c>
1800072c3:     	movq	%rbx, %rcx
1800072c6:     	callq	*0x2efc(%rip)           # 0x18000a1c8
1800072cc:     	xorl	%eax, %eax
1800072ce:     	addq	$0x30, %rsp
1800072d2:     	popq	%rbx
1800072d3:     	retq
1800072d4:     	movq	%rbx, %rax
1800072d7:     	addq	$0x30, %rsp
1800072db:     	popq	%rbx
1800072dc:     	retq
1800072dd:     	int3
1800072de:     	int3
1800072df:     	int3
1800072e0:     	movq	%rbx, 0x8(%rsp)
1800072e5:     	movq	%rsi, 0x10(%rsp)
1800072ea:     	pushq	%rdi
1800072eb:     	subq	$0x20, %rsp
1800072ef:     	movq	%rcx, %rbx
1800072f2:     	movq	%r8, %rdi
1800072f5:     	movq	0x18(%rcx), %rcx
1800072f9:     	movq	%rdx, %rsi
1800072fc:     	testq	%rcx, %rcx
1800072ff:     	je	0x18000730a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4d9a>
180007301:     	movq	%r8, %rdx
180007304:     	callq	*%rsi
180007306:     	testl	%eax, %eax
180007308:     	jne	0x18000732d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4dbd>
18000730a:     	movq	0x40(%rbx), %rcx
18000730e:     	testq	%rcx, %rcx
180007311:     	je	0x18000732b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4dbb>
180007313:     	movq	%rdi, %rdx
180007316:     	movq	%rsi, %rax
180007319:     	movq	0x30(%rsp), %rbx
18000731e:     	movq	0x38(%rsp), %rsi
180007323:     	addq	$0x20, %rsp
180007327:     	popq	%rdi
180007328:     	jmpq	*%rax
18000732b:     	xorl	%eax, %eax
18000732d:     	movq	0x30(%rsp), %rbx
180007332:     	movq	0x38(%rsp), %rsi
180007337:     	addq	$0x20, %rsp
18000733b:     	popq	%rdi
18000733c:     	retq
18000733d:     	int3
18000733e:     	int3
18000733f:     	int3
180007340:     	pushq	%rbx
180007342:     	subq	$0x20, %rsp
180007346:     	movq	%rcx, %rbx
180007349:     	callq	*0x2ec9(%rip)           # 0x18000a218
18000734f:     	cmpq	$0x0, 0x48(%rbx)
180007354:     	je	0x18000735f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4def>
180007356:     	movq	%rbx, %rcx
180007359:     	callq	*0x2e29(%rip)           # 0x18000a188
18000735f:     	movq	0x20(%rbx), %rcx
180007363:     	callq	*0x2e4f(%rip)           # 0x18000a1b8
180007369:     	movq	0x38(%rbx), %rcx
18000736d:     	callq	*0x2e45(%rip)           # 0x18000a1b8
180007373:     	movq	0x18(%rbx), %rcx
180007377:     	testq	%rcx, %rcx
18000737a:     	je	0x18000738f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e1f>
18000737c:     	movl	(%rcx), %eax
18000737e:     	testl	%eax, %eax
180007380:     	js	0x18000738f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e1f>
180007382:     	subl	$0x1, %eax
180007385:     	movl	%eax, (%rcx)
180007387:     	jne	0x18000738f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e1f>
180007389:     	callq	*0x2e39(%rip)           # 0x18000a1c8
18000738f:     	movq	0x40(%rbx), %rcx
180007393:     	testq	%rcx, %rcx
180007396:     	je	0x1800073ab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e3b>
180007398:     	movl	(%rcx), %eax
18000739a:     	testl	%eax, %eax
18000739c:     	js	0x1800073ab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e3b>
18000739e:     	subl	$0x1, %eax
1800073a1:     	movl	%eax, (%rcx)
1800073a3:     	jne	0x1800073ab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e3b>
1800073a5:     	callq	*0x2e1d(%rip)           # 0x18000a1c8
1800073ab:     	movq	0x8(%rbx), %rax
1800073af:     	movq	%rbx, %rcx
1800073b2:     	addq	$0x20, %rsp
1800073b6:     	popq	%rbx
1800073b7:     	jmpq	*0x140(%rax)
1800073be:     	int3
1800073bf:     	int3
1800073c0:     	pushq	%rbx
1800073c2:     	subq	$0x20, %rsp
1800073c6:     	callq	*0x2db4(%rip)           # 0x18000a180
1800073cc:     	movq	%rax, %rbx
1800073cf:     	testq	%rax, %rax
1800073d2:     	jne	0x1800073da <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e6a>
1800073d4:     	addq	$0x20, %rsp
1800073d8:     	popq	%rbx
1800073d9:     	retq
1800073da:     	movq	%rbx, %rcx
1800073dd:     	movq	%rdi, 0x30(%rsp)
1800073e2:     	callq	0x180009745 <numba_list_iter_next+0xed5>
1800073e7:     	leaq	0x1(%rax), %rcx
1800073eb:     	callq	*0x2e5f(%rip)           # 0x18000a250
1800073f1:     	movq	%rax, %rdi
1800073f4:     	testq	%rax, %rax
1800073f7:     	jne	0x18000740c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e9c>
1800073f9:     	callq	*0x2d41(%rip)           # 0x18000a140
1800073ff:     	movq	0x30(%rsp), %rdi
180007404:     	xorl	%eax, %eax
180007406:     	addq	$0x20, %rsp
18000740a:     	popq	%rbx
18000740b:     	retq
18000740c:     	movq	%rbx, %rdx
18000740f:     	movq	%rdi, %rcx
180007412:     	callq	0x18000973f <numba_list_iter_next+0xecf>
180007417:     	movq	%rdi, %rax
18000741a:     	movq	0x30(%rsp), %rdi
18000741f:     	addq	$0x20, %rsp
180007423:     	popq	%rbx
180007424:     	retq
180007425:     	int3
180007426:     	int3
180007427:     	int3
180007428:     	int3
180007429:     	int3
18000742a:     	int3
18000742b:     	int3
18000742c:     	int3
18000742d:     	int3
18000742e:     	int3
18000742f:     	int3
180007430:     	movq	0x18(%rcx), %rcx
180007434:     	movq	%rdx, %rax
180007437:     	testq	%rcx, %rcx
18000743a:     	je	0x180007442 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4ed2>
18000743c:     	movq	%r8, %rdx
18000743f:     	jmpq	*%rax
180007442:     	xorl	%eax, %eax
180007444:     	retq
180007445:     	int3
180007446:     	int3
180007447:     	int3
180007448:     	int3
180007449:     	int3
18000744a:     	int3
18000744b:     	int3
18000744c:     	int3
18000744d:     	int3
18000744e:     	int3
18000744f:     	int3
180007450:     	movq	%rbx, 0x8(%rsp)
180007455:     	pushq	%rdi
180007456:     	subq	$0x20, %rsp
18000745a:     	movq	0x28(%rcx), %rax
18000745e:     	xorl	%edi, %edi
180007460:     	movq	%rcx, %rbx
180007463:     	testq	%rax, %rax
180007466:     	je	0x180007472 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f02>
180007468:     	addq	$0x38, %rcx
18000746c:     	callq	*%rax
18000746e:     	movq	%rdi, 0x28(%rbx)
180007472:     	movq	0x18(%rbx), %rcx
180007476:     	testq	%rcx, %rcx
180007479:     	je	0x180007492 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f22>
18000747b:     	movq	%rdi, 0x18(%rbx)
18000747f:     	movl	(%rcx), %eax
180007481:     	testl	%eax, %eax
180007483:     	js	0x180007492 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f22>
180007485:     	subl	$0x1, %eax
180007488:     	movl	%eax, (%rcx)
18000748a:     	jne	0x180007492 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f22>
18000748c:     	callq	*0x2d36(%rip)           # 0x18000a1c8
180007492:     	movq	%rdi, 0x20(%rbx)
180007496:     	xorl	%eax, %eax
180007498:     	movq	0x30(%rsp), %rbx
18000749d:     	addq	$0x20, %rsp
1800074a1:     	popq	%rdi
1800074a2:     	retq
1800074a3:     	int3
1800074a4:     	int3
1800074a5:     	int3
1800074a6:     	int3
1800074a7:     	int3
1800074a8:     	int3
1800074a9:     	int3
1800074aa:     	int3
1800074ab:     	int3
1800074ac:     	int3
1800074ad:     	int3
1800074ae:     	int3
1800074af:     	int3
1800074b0:     	pushq	%rbx
1800074b2:     	subq	$0x20, %rsp
1800074b6:     	movq	%rcx, %rbx
1800074b9:     	callq	*0x2d59(%rip)           # 0x18000a218
1800074bf:     	cmpq	$0x0, 0x30(%rbx)
1800074c4:     	je	0x1800074cf <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f5f>
1800074c6:     	movq	%rbx, %rcx
1800074c9:     	callq	*0x2cb9(%rip)           # 0x18000a188
1800074cf:     	callq	*0x2c33(%rip)           # 0x18000a108
1800074d5:     	testl	%eax, %eax
1800074d7:     	jne	0x1800074e8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f78>
1800074d9:     	movq	0x28(%rbx), %rax
1800074dd:     	testq	%rax, %rax
1800074e0:     	je	0x1800074e8 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f78>
1800074e2:     	leaq	0x38(%rbx), %rcx
1800074e6:     	callq	*%rax
1800074e8:     	movq	0x18(%rbx), %rcx
1800074ec:     	testq	%rcx, %rcx
1800074ef:     	je	0x180007504 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f94>
1800074f1:     	movl	(%rcx), %eax
1800074f3:     	testl	%eax, %eax
1800074f5:     	js	0x180007504 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f94>
1800074f7:     	subl	$0x1, %eax
1800074fa:     	movl	%eax, (%rcx)
1800074fc:     	jne	0x180007504 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4f94>
1800074fe:     	callq	*0x2cc4(%rip)           # 0x18000a1c8
180007504:     	movq	0x8(%rbx), %rax
180007508:     	movq	%rbx, %rcx
18000750b:     	addq	$0x20, %rsp
18000750f:     	popq	%rbx
180007510:     	jmpq	*0x140(%rax)
180007517:     	int3
180007518:     	int3
180007519:     	int3
18000751a:     	int3
18000751b:     	int3
18000751c:     	int3
18000751d:     	int3
18000751e:     	int3
18000751f:     	int3
180007520:     	pushq	%rdi
180007522:     	subq	$0x20, %rsp
180007526:     	cmpq	$0x0, 0x20(%rcx)
18000752b:     	movq	%rcx, %rdi
18000752e:     	jne	0x18000754f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4fdf>
180007530:     	movq	0x2d79(%rip), %rcx      # 0x18000a2b0
180007537:     	leaq	0x3c92(%rip), %rdx      # 0x18000b1d0
18000753e:     	movq	(%rcx), %rcx
180007541:     	callq	*0x2d61(%rip)           # 0x18000a2a8
180007547:     	xorl	%eax, %eax
180007549:     	addq	$0x20, %rsp
18000754d:     	popq	%rdi
18000754e:     	retq
18000754f:     	movq	%rdi, %rdx
180007552:     	movq	%rbx, 0x30(%rsp)
180007557:     	movl	$0x1, %ecx
18000755c:     	callq	*0x2da6(%rip)           # 0x18000a308
180007562:     	movq	%rax, %rbx
180007565:     	testq	%rax, %rax
180007568:     	jne	0x180007575 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5005>
18000756a:     	movq	0x30(%rsp), %rbx
18000756f:     	addq	$0x20, %rsp
180007573:     	popq	%rdi
180007574:     	retq
180007575:     	xorl	%r8d, %r8d
180007578:     	movq	%rbx, %rdx
18000757b:     	movq	%rdi, %rcx
18000757e:     	callq	*0x20(%rdi)
180007581:     	movl	(%rbx), %ecx
180007583:     	movq	%rax, %rdi
180007586:     	testl	%ecx, %ecx
180007588:     	js	0x18000759a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x502a>
18000758a:     	subl	$0x1, %ecx
18000758d:     	movl	%ecx, (%rbx)
18000758f:     	jne	0x18000759a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x502a>
180007591:     	movq	%rbx, %rcx
180007594:     	callq	*0x2c2e(%rip)           # 0x18000a1c8
18000759a:     	movq	0x30(%rsp), %rbx
18000759f:     	movq	%rdi, %rax
1800075a2:     	addq	$0x20, %rsp
1800075a6:     	popq	%rdi
1800075a7:     	retq
1800075a8:     	int3
1800075a9:     	int3
1800075aa:     	int3
1800075ab:     	int3
1800075ac:     	int3
1800075ad:     	int3
1800075ae:     	int3
1800075af:     	int3
1800075b0:     	movq	%rbx, 0x8(%rsp)
1800075b5:     	pushq	%rdi
1800075b6:     	subq	$0x20, %rsp
1800075ba:     	movq	%r8, %rbx
1800075bd:     	callq	*0x2b2d(%rip)           # 0x18000a0f0
1800075c3:     	movl	(%rbx), %ecx
1800075c5:     	movl	%eax, %edi
1800075c7:     	testl	%ecx, %ecx
1800075c9:     	js	0x1800075db <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x506b>
1800075cb:     	subl	$0x1, %ecx
1800075ce:     	movl	%ecx, (%rbx)
1800075d0:     	jne	0x1800075db <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x506b>
1800075d2:     	movq	%rbx, %rcx
1800075d5:     	callq	*0x2bed(%rip)           # 0x18000a1c8
1800075db:     	movl	%edi, %ecx
1800075dd:     	movq	0x30(%rsp), %rbx
1800075e2:     	addq	$0x20, %rsp
1800075e6:     	popq	%rdi
1800075e7:     	jmpq	*0x2c22(%rip)           # 0x18000a210
1800075ee:     	int3
1800075ef:     	int3
1800075f0:     	movq	%rbx, 0x8(%rsp)
1800075f5:     	pushq	%rdi
1800075f6:     	subq	$0x20, %rsp
1800075fa:     	movl	(%rdx), %eax
1800075fc:     	movq	%rdx, %rbx
1800075ff:     	movq	%rcx, %rdi
180007602:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007607:     	jae	0x18000760d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x509d>
180007609:     	incl	%eax
18000760b:     	movl	%eax, (%rdx)
18000760d:     	movl	$0x30, %ecx
180007612:     	callq	*0xa650(%rip)           # 0x180011c68
180007618:     	cmpb	$0x0, 0xa621(%rip)      # 0x180011c40
18000761f:     	je	0x180007629 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x50b9>
180007621:     	lock
180007622:     	incq	0xa61f(%rip)            # 0x180011c48
180007629:     	testq	%rax, %rax
18000762c:     	je	0x180007663 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x50f3>
18000762e:     	movl	$0x1, %ecx
180007633:     	leaq	-0x8a(%rip), %rdx       # 0x1800075b0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5040>
18000763a:     	xchgq	%rcx, (%rax)
18000763d:     	xorl	%ecx, %ecx
18000763f:     	movq	%rdx, 0x8(%rax)
180007643:     	movq	%rcx, 0x20(%rax)
180007647:     	movq	%rcx, 0x28(%rax)
18000764b:     	movq	%rbx, 0x10(%rax)
18000764f:     	movq	%rdi, 0x18(%rax)
180007653:     	cmpb	%cl, 0xa5e7(%rip)       # 0x180011c40
180007659:     	je	0x180007663 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x50f3>
18000765b:     	lock
18000765c:     	incq	0xa5f5(%rip)            # 0x180011c58
180007663:     	movq	0x30(%rsp), %rbx
180007668:     	addq	$0x20, %rsp
18000766c:     	popq	%rdi
18000766d:     	retq
18000766e:     	int3
18000766f:     	int3
180007670:     	movq	%rbx, 0x8(%rsp)
180007675:     	pushq	%rdi
180007676:     	subq	$0x30, %rsp
18000767a:     	movq	%rcx, %rdi
18000767d:     	leaq	0xa33c(%rip), %r9       # 0x1800119c0
180007684:     	movq	%r8, %rax
180007687:     	leaq	0x58(%rsp), %rcx
18000768c:     	movq	%rdx, %r10
18000768f:     	movq	%rcx, 0x20(%rsp)
180007694:     	movq	%r10, %rcx
180007697:     	leaq	0x3b7a(%rip), %r8       # 0x18000b218
18000769e:     	movq	%rax, %rdx
1800076a1:     	callq	*0x2a51(%rip)           # 0x18000a0f8
1800076a7:     	testl	%eax, %eax
1800076a9:     	je	0x1800076d3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5163>
1800076ab:     	movq	0x58(%rsp), %rcx
1800076b0:     	callq	*0x2a2a(%rip)           # 0x18000a0e0
1800076b6:     	movq	%rax, %rbx
1800076b9:     	callq	*0x2c29(%rip)           # 0x18000a2e8
1800076bf:     	testq	%rax, %rax
1800076c2:     	jne	0x1800076d3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5163>
1800076c4:     	movq	%rbx, 0x10(%rdi)
1800076c8:     	movq	0x40(%rsp), %rbx
1800076cd:     	addq	$0x30, %rsp
1800076d1:     	popq	%rdi
1800076d2:     	retq
1800076d3:     	movq	0x40(%rsp), %rbx
1800076d8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800076dd:     	addq	$0x30, %rsp
1800076e1:     	popq	%rdi
1800076e2:     	retq
1800076e3:     	int3
1800076e4:     	int3
1800076e5:     	int3
1800076e6:     	int3
1800076e7:     	int3
1800076e8:     	int3
1800076e9:     	int3
1800076ea:     	int3
1800076eb:     	int3
1800076ec:     	int3
1800076ed:     	int3
1800076ee:     	int3
1800076ef:     	int3
1800076f0:     	subq	$0x38, %rsp
1800076f4:     	movl	%r8d, %eax
1800076f7:     	movq	%rdx, %r10
1800076fa:     	movq	0x10(%rcx), %r8
1800076fe:     	movq	%rcx, %rdx
180007701:     	movl	%eax, 0x28(%rsp)
180007705:     	movq	%r10, %rcx
180007708:     	movl	$0x0, 0x20(%rsp)
180007710:     	movq	0x20(%r8), %r9
180007714:     	movq	0x18(%r8), %r8
180007718:     	callq	*0x2aea(%rip)           # 0x18000a208
18000771e:     	addq	$0x38, %rsp
180007722:     	retq
180007723:     	int3
180007724:     	int3
180007725:     	int3
180007726:     	int3
180007727:     	int3
180007728:     	int3
180007729:     	int3
18000772a:     	int3
18000772b:     	int3
18000772c:     	int3
18000772d:     	int3
18000772e:     	int3
18000772f:     	int3
180007730:     	movq	0x10(%rcx), %rax
180007734:     	lock
180007735:     	incq	(%rax)
180007738:     	movq	0x2b91(%rip), %rax      # 0x18000a2d0
18000773f:     	retq
180007740:     	subq	$0x28, %rsp
180007744:     	movq	0x10(%rcx), %rcx
180007748:     	callq	0x180008a40 <numba_list_iter_next+0x1d0>
18000774d:     	movq	0x2b7c(%rip), %rax      # 0x18000a2d0
180007754:     	addq	$0x28, %rsp
180007758:     	retq
180007759:     	int3
18000775a:     	int3
18000775b:     	int3
18000775c:     	int3
18000775d:     	int3
18000775e:     	int3
18000775f:     	int3
180007760:     	movq	0x10(%rcx), %rcx
180007764:     	movq	0x18(%rcx), %rcx
180007768:     	jmpq	*0x29e9(%rip)           # 0x18000a158
18000776f:     	int3
180007770:     	subq	$0x28, %rsp
180007774:     	movq	0x10(%rcx), %rax
180007778:     	testq	%rax, %rax
18000777b:     	je	0x180007799 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5229>
18000777d:     	cmpq	$0x0, 0x18(%rax)
180007782:     	je	0x180007799 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5229>
180007784:     	movq	(%rax), %rcx
180007787:     	nop
180007788:     	cmpq	$-0x1, %rcx
18000778c:     	je	0x180007799 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5229>
18000778e:     	addq	$0x28, %rsp
180007792:     	jmpq	*0x298f(%rip)           # 0x18000a128
180007799:     	movq	0x2a58(%rip), %rcx      # 0x18000a1f8
1800077a0:     	leaq	0x3a79(%rip), %rdx      # 0x18000b220
1800077a7:     	movq	(%rcx), %rcx
1800077aa:     	callq	*0x2af8(%rip)           # 0x18000a2a8
1800077b0:     	xorl	%eax, %eax
1800077b2:     	addq	$0x28, %rsp
1800077b6:     	retq
1800077b7:     	int3
1800077b8:     	int3
1800077b9:     	int3
1800077ba:     	int3
1800077bb:     	int3
1800077bc:     	int3
1800077bd:     	int3
1800077be:     	int3
1800077bf:     	int3
1800077c0:     	movq	0x10(%rcx), %rcx
1800077c4:     	movq	0x28(%rcx), %rcx
1800077c8:     	jmpq	*0x2989(%rip)           # 0x18000a158
1800077cf:     	int3
1800077d0:     	movq	0x10(%rcx), %rax
1800077d4:     	movq	0x10(%rax), %rax
1800077d8:     	testq	%rax, %rax
1800077db:     	je	0x1800077ec <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x527c>
1800077dd:     	movl	(%rax), %ecx
1800077df:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800077e5:     	jae	0x18000780a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x529a>
1800077e7:     	incl	%ecx
1800077e9:     	movl	%ecx, (%rax)
1800077eb:     	retq
1800077ec:     	movq	0x2add(%rip), %rcx      # 0x18000a2d0
1800077f3:     	movl	(%rcx), %eax
1800077f5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800077fa:     	jae	0x180007807 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5297>
1800077fc:     	incl	%eax
1800077fe:     	movl	%eax, (%rcx)
180007800:     	movq	0x2ac9(%rip), %rcx      # 0x18000a2d0
180007807:     	movq	%rcx, %rax
18000780a:     	retq
18000780b:     	int3
18000780c:     	int3
18000780d:     	int3
18000780e:     	int3
18000780f:     	int3
180007810:     	pushq	%rbx
180007812:     	subq	$0x20, %rsp
180007816:     	movq	%rcx, %rbx
180007819:     	movq	0x10(%rcx), %rcx
18000781d:     	callq	0x180008a40 <numba_list_iter_next+0x1d0>
180007822:     	movq	0x8(%rbx), %rax
180007826:     	movq	%rbx, %rcx
180007829:     	addq	$0x20, %rsp
18000782d:     	popq	%rbx
18000782e:     	jmpq	*0x140(%rax)
180007835:     	int3
180007836:     	int3
180007837:     	int3
180007838:     	int3
180007839:     	int3
18000783a:     	int3
18000783b:     	int3
18000783c:     	int3
18000783d:     	int3
18000783e:     	int3
18000783f:     	int3
180007840:     	movq	%rdi, 0x18(%rsp)
180007845:     	pushq	%r14
180007847:     	subq	$0x20, %rsp
18000784b:     	movq	0xa42e(%rip), %rax      # 0x180011c80
180007852:     	movq	%rdx, %r14
180007855:     	movq	%rcx, %rdi
180007858:     	movq	0x8(%rcx), %rcx
18000785c:     	movq	0x10(%rax), %rdx
180007860:     	cmpq	%rdx, %rcx
180007863:     	je	0x180007880 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5310>
180007865:     	callq	*0x296d(%rip)           # 0x18000a1d8
18000786b:     	testl	%eax, %eax
18000786d:     	jne	0x180007880 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5310>
18000786f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007874:     	movq	0x40(%rsp), %rdi
180007879:     	addq	$0x20, %rsp
18000787d:     	popq	%r14
18000787f:     	retq
180007880:     	movq	%rbx, 0x30(%rsp)
180007885:     	movq	%rdi, %rdx
180007888:     	movq	0x10(%rdi), %rbx
18000788c:     	movq	%rbx, %rcx
18000788f:     	movq	%rsi, 0x38(%rsp)
180007894:     	movl	0x18(%rdi), %esi
180007897:     	callq	0x1800075f0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5080>
18000789c:     	movq	%rax, (%r14)
18000789f:     	movq	0xa3da(%rip), %rax      # 0x180011c80
1800078a6:     	movq	%rbx, 0x20(%r14)
1800078aa:     	movl	0x18(%rdi), %edx
1800078ad:     	movq	0x20(%rdi), %rcx
1800078b1:     	callq	*0x4f0(%rax)
1800078b7:     	cmpl	$0x12, 0xa3ce(%rip)     # 0x180011c8c
1800078be:     	movq	0x30(%rsp), %rbx
1800078c3:     	movq	%rax, 0x10(%r14)
1800078c7:     	movq	0x38(%rdi), %rax
1800078cb:     	jl	0x1800078d3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5363>
1800078cd:     	movq	0x28(%rax), %rax
1800078d1:     	jmp	0x1800078d7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5367>
1800078d3:     	movslq	0x20(%rax), %rax
1800078d7:     	xorl	%r8d, %r8d
1800078da:     	movq	%rax, 0x18(%r14)
1800078de:     	movq	%rdi, 0x8(%r14)
1800078e2:     	leaq	0x28(%r14), %rax
1800078e6:     	testl	%esi, %esi
1800078e8:     	jle	0x18000792b <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x53bb>
1800078ea:     	nopw	(%rax,%rax)
1800078f0:     	movq	0x20(%rdi), %rcx
1800078f4:     	movq	(%rcx,%r8,8), %rdx
1800078f8:     	incl	%r8d
1800078fb:     	movq	%rdx, (%rax)
1800078fe:     	addq	$0x8, %rax
180007902:     	cmpl	%esi, %r8d
180007905:     	jl	0x1800078f0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5380>
180007907:     	xorl	%r8d, %r8d
18000790a:     	nopw	(%rax,%rax)
180007910:     	movq	0x28(%rdi), %rcx
180007914:     	leaq	0x8(%rax), %rax
180007918:     	movslq	%r8d, %rdx
18000791b:     	incl	%r8d
18000791e:     	movq	(%rcx,%rdx,8), %rdx
180007922:     	movq	%rdx, -0x8(%rax)
180007926:     	cmpl	%esi, %r8d
180007929:     	jl	0x180007910 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x53a0>
18000792b:     	movq	0x38(%rsp), %rsi
180007930:     	xorl	%eax, %eax
180007932:     	movq	0x40(%rsp), %rdi
180007937:     	addq	$0x20, %rsp
18000793b:     	popq	%r14
18000793d:     	retq
18000793e:     	int3
18000793f:     	int3
180007940:     	pushq	%rbx
180007942:     	pushq	%rbp
180007943:     	pushq	%rsi
180007944:     	pushq	%rdi
180007945:     	subq	$0x28, %rsp
180007949:     	cmpq	$0x0, 0xa347(%rip)      # 0x180011c98
180007951:     	movq	%rcx, %rbp
180007954:     	movslq	0x8(%rdx), %rdi
180007958:     	movq	(%rdx), %rsi
18000795b:     	jne	0x1800079b3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5443>
18000795d:     	leaq	0x37c4(%rip), %rcx      # 0x18000b128
180007964:     	callq	*0x28ce(%rip)           # 0x18000a238
18000796a:     	movq	%rax, %rbx
18000796d:     	testq	%rax, %rax
180007970:     	je	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
180007976:     	leaq	0x37b3(%rip), %rdx      # 0x18000b130
18000797d:     	movq	%rax, %rcx
180007980:     	callq	*0x27e2(%rip)           # 0x18000a168
180007986:     	movl	(%rbx), %edx
180007988:     	movq	%rax, 0xa309(%rip)      # 0x180011c98
18000798f:     	testl	%edx, %edx
180007991:     	js	0x1800079aa <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x543a>
180007993:     	subl	$0x1, %edx
180007996:     	movl	%edx, (%rbx)
180007998:     	jne	0x1800079aa <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x543a>
18000799a:     	movq	%rbx, %rcx
18000799d:     	callq	*0x2825(%rip)           # 0x18000a1c8
1800079a3:     	movq	0xa2ee(%rip), %rax      # 0x180011c98
1800079aa:     	testq	%rax, %rax
1800079ad:     	je	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
1800079b3:     	movq	%rdi, %rdx
1800079b6:     	movq	%rsi, %rcx
1800079b9:     	callq	*0x28f9(%rip)           # 0x18000a2b8
1800079bf:     	movq	%rax, %rdi
1800079c2:     	testq	%rax, %rax
1800079c5:     	je	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
1800079c7:     	movq	0xa2ca(%rip), %rcx      # 0x180011c98
1800079ce:     	xorl	%r8d, %r8d
1800079d1:     	movq	%rax, %rdx
1800079d4:     	callq	*0x27be(%rip)           # 0x18000a198
1800079da:     	movl	(%rdi), %ecx
1800079dc:     	movq	%rax, %rbx
1800079df:     	testl	%ecx, %ecx
1800079e1:     	js	0x1800079f3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5483>
1800079e3:     	subl	$0x1, %ecx
1800079e6:     	movl	%ecx, (%rdi)
1800079e8:     	jne	0x1800079f3 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5483>
1800079ea:     	movq	%rdi, %rcx
1800079ed:     	callq	*0x27d5(%rip)           # 0x18000a1c8
1800079f3:     	testq	%rbx, %rbx
1800079f6:     	je	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
1800079f8:     	movq	0x8(%rbx), %r8
1800079fc:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180007a07:     	jne	0x180007a45 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54d5>
180007a09:     	movq	0x2890(%rip), %rcx      # 0x18000a2a0
180007a10:     	leaq	0x3911(%rip), %rdx      # 0x18000b328
180007a17:     	movq	0x18(%r8), %r8
180007a1b:     	movq	(%rcx), %rcx
180007a1e:     	callq	*0x27cc(%rip)           # 0x18000a1f0
180007a24:     	movl	(%rbx), %eax
180007a26:     	testl	%eax, %eax
180007a28:     	js	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
180007a2a:     	subl	$0x1, %eax
180007a2d:     	movl	%eax, (%rbx)
180007a2f:     	jne	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
180007a31:     	movq	%rbx, %rcx
180007a34:     	callq	*0x278e(%rip)           # 0x18000a1c8
180007a3a:     	xorl	%eax, %eax
180007a3c:     	addq	$0x28, %rsp
180007a40:     	popq	%rdi
180007a41:     	popq	%rsi
180007a42:     	popq	%rbp
180007a43:     	popq	%rbx
180007a44:     	retq
180007a45:     	xorl	%r8d, %r8d
180007a48:     	leaq	0x98f1(%rip), %rcx      # 0x180011340
180007a4f:     	xorl	%edx, %edx
180007a51:     	callq	*0x27f1(%rip)           # 0x18000a248
180007a57:     	movq	%rax, %rdi
180007a5a:     	testq	%rax, %rax
180007a5d:     	je	0x180007a24 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54b4>
180007a5f:     	movq	%rbp, %rcx
180007a62:     	movq	%rbx, 0x18(%rax)
180007a66:     	callq	*0x2754(%rip)           # 0x18000a1c0
180007a6c:     	movq	%rax, 0x10(%rdi)
180007a70:     	movq	%rax, %rcx
180007a73:     	testq	%rax, %rax
180007a76:     	jne	0x180007a8a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x551a>
180007a78:     	movl	(%rdi), %eax
180007a7a:     	testl	%eax, %eax
180007a7c:     	js	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
180007a7e:     	subl	$0x1, %eax
180007a81:     	movl	%eax, (%rdi)
180007a83:     	jne	0x180007a3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54ca>
180007a85:     	movq	%rdi, %rcx
180007a88:     	jmp	0x180007a34 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x54c4>
180007a8a:     	movl	(%rax), %eax
180007a8c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007a91:     	jae	0x180007a97 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5527>
180007a93:     	incl	%eax
180007a95:     	movl	%eax, (%rcx)
180007a97:     	movq	%rdi, %rax
180007a9a:     	addq	$0x28, %rsp
180007a9e:     	popq	%rdi
180007a9f:     	popq	%rsi
180007aa0:     	popq	%rbp
180007aa1:     	popq	%rbx
180007aa2:     	retq
180007aa3:     	int3
180007aa4:     	int3
180007aa5:     	int3
180007aa6:     	int3
180007aa7:     	int3
180007aa8:     	int3
180007aa9:     	int3
180007aaa:     	int3
180007aab:     	int3
180007aac:     	int3
180007aad:     	int3
180007aae:     	int3
180007aaf:     	int3
180007ab0:     	movq	%r9, 0x20(%rsp)
180007ab5:     	movq	%r8, 0x18(%rsp)
180007aba:     	movq	%rdx, 0x10(%rsp)
180007abf:     	movq	%rcx, 0x8(%rsp)
180007ac4:     	pushq	%rbx
180007ac5:     	pushq	%rbp
180007ac6:     	pushq	%rsi
180007ac7:     	pushq	%rdi
180007ac8:     	pushq	%r12
180007aca:     	pushq	%r13
180007acc:     	pushq	%r14
180007ace:     	pushq	%r15
180007ad0:     	subq	$0x68, %rsp
180007ad4:     	movq	%rcx, %r14
180007ad7:     	movq	%r9, %r15
180007ada:     	leaq	0x32ff(%rip), %rcx      # 0x18000ade0
180007ae1:     	movq	%r8, %r13
180007ae4:     	movq	%rdx, %rsi
180007ae7:     	callq	*0x274b(%rip)           # 0x18000a238
180007aed:     	movq	%rax, %rdi
180007af0:     	testq	%rax, %rax
180007af3:     	jne	0x180007b2c <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x55bc>
180007af5:     	movq	0x263c(%rip), %rcx      # 0x18000a138
180007afc:     	movq	(%rcx), %rcx
180007aff:     	callq	*0x26ab(%rip)           # 0x18000a1b0
180007b05:     	testl	%eax, %eax
180007b07:     	je	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007b0d:     	callq	*0x27ad(%rip)           # 0x18000a2c0
180007b13:     	leaq	0x32e6(%rip), %rcx      # 0x18000ae00
180007b1a:     	callq	*0x2718(%rip)           # 0x18000a238
180007b20:     	movq	%rax, %rdi
180007b23:     	testq	%rax, %rax
180007b26:     	je	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007b2c:     	leaq	0x32ed(%rip), %rdx      # 0x18000ae20
180007b33:     	movq	%rdi, %rcx
180007b36:     	callq	*0x262c(%rip)           # 0x18000a168
180007b3c:     	movl	(%rdi), %ecx
180007b3e:     	movq	%rax, %rbx
180007b41:     	testl	%ecx, %ecx
180007b43:     	js	0x180007b55 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x55e5>
180007b45:     	subl	$0x1, %ecx
180007b48:     	movl	%ecx, (%rdi)
180007b4a:     	jne	0x180007b55 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x55e5>
180007b4c:     	movq	%rdi, %rcx
180007b4f:     	callq	*0x2673(%rip)           # 0x18000a1c8
180007b55:     	testq	%rbx, %rbx
180007b58:     	je	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007b5e:     	movq	0x259b(%rip), %rax      # 0x18000a100
180007b65:     	cmpq	%rax, 0x8(%rbx)
180007b69:     	je	0x180007ba5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5635>
180007b6b:     	movq	0x273e(%rip), %rcx      # 0x18000a2b0
180007b72:     	leaq	0x32b7(%rip), %rdx      # 0x18000ae30
180007b79:     	movq	(%rcx), %rcx
180007b7c:     	callq	*0x2726(%rip)           # 0x18000a2a8
180007b82:     	movl	(%rbx), %eax
180007b84:     	testl	%eax, %eax
180007b86:     	js	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007b8c:     	subl	$0x1, %eax
180007b8f:     	movl	%eax, (%rbx)
180007b91:     	jne	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007b97:     	movq	%rbx, %rcx
180007b9a:     	callq	*0x2628(%rip)           # 0x18000a1c8
180007ba0:     	jmp	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007ba5:     	xorl	%edx, %edx
180007ba7:     	movq	%rbx, %rcx
180007baa:     	callq	*0x25f8(%rip)           # 0x18000a1a8
180007bb0:     	movl	(%rbx), %ecx
180007bb2:     	movq	%rax, 0xa0c7(%rip)      # 0x180011c80
180007bb9:     	testl	%ecx, %ecx
180007bbb:     	js	0x180007bd4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5664>
180007bbd:     	subl	$0x1, %ecx
180007bc0:     	movl	%ecx, (%rbx)
180007bc2:     	jne	0x180007bd4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5664>
180007bc4:     	movq	%rbx, %rcx
180007bc7:     	callq	*0x25fb(%rip)           # 0x18000a1c8
180007bcd:     	movq	0xa0ac(%rip), %rax      # 0x180011c80
180007bd4:     	testq	%rax, %rax
180007bd7:     	jne	0x180007bf2 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5682>
180007bd9:     	leaq	0x3278(%rip), %rdx      # 0x18000ae58
180007be0:     	movq	0x26c9(%rip), %rcx      # 0x18000a2b0
180007be7:     	movq	(%rcx), %rcx
180007bea:     	callq	*0x26b8(%rip)           # 0x18000a2a8
180007bf0:     	jmp	0x180007c27 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b7>
180007bf2:     	callq	*(%rax)
180007bf4:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180007bf9:     	jbe	0x180007c5a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56ea>
180007bfb:     	movq	0x26ae(%rip), %rax      # 0x18000a2b0
180007c02:     	movq	(%rax), %rbx
180007c05:     	movq	0xa074(%rip), %rax      # 0x180011c80
180007c0c:     	callq	*(%rax)
180007c0e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180007c14:     	leaq	0x3265(%rip), %rdx      # 0x18000ae80
180007c1b:     	movl	%eax, %r9d
180007c1e:     	movq	%rbx, %rcx
180007c21:     	callq	*0x25c9(%rip)           # 0x18000a1f0
180007c27:     	callq	*0x24eb(%rip)           # 0x18000a118
180007c2d:     	movq	0x24dc(%rip), %rcx      # 0x18000a110
180007c34:     	leaq	0x346d(%rip), %rdx      # 0x18000b0a8
180007c3b:     	movq	(%rcx), %rcx
180007c3e:     	callq	*0x2664(%rip)           # 0x18000a2a8
180007c44:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007c49:     	addq	$0x68, %rsp
180007c4d:     	popq	%r15
180007c4f:     	popq	%r14
180007c51:     	popq	%r13
180007c53:     	popq	%r12
180007c55:     	popq	%rdi
180007c56:     	popq	%rsi
180007c57:     	popq	%rbp
180007c58:     	popq	%rbx
180007c59:     	retq
180007c5a:     	movq	0xa01f(%rip), %rax      # 0x180011c80
180007c61:     	callq	*0x698(%rax)
180007c67:     	movl	%eax, 0xa01f(%rip)      # 0x180011c8c
180007c6d:     	cmpl	$0x10, %eax
180007c70:     	jge	0x180007c8e <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x571e>
180007c72:     	movq	0x2637(%rip), %rcx      # 0x18000a2b0
180007c79:     	leaq	0x3250(%rip), %rdx      # 0x18000aed0
180007c80:     	movl	%eax, %r9d
180007c83:     	movl	$0x10, %r8d
180007c89:     	movq	(%rcx), %rcx
180007c8c:     	jmp	0x180007c21 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56b1>
180007c8e:     	movq	0x9feb(%rip), %rax      # 0x180011c80
180007c95:     	callq	*0x690(%rax)
180007c9b:     	testl	%eax, %eax
180007c9d:     	jne	0x180007cab <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x573b>
180007c9f:     	leaq	0x337a(%rip), %rdx      # 0x18000b020
180007ca6:     	jmp	0x180007be0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5670>
180007cab:     	cmpl	$0x1, %eax
180007cae:     	je	0x180007cbc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x574c>
180007cb0:     	leaq	0x3399(%rip), %rdx      # 0x18000b050
180007cb7:     	jmp	0x180007be0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5670>
180007cbc:     	leaq	0x9b5d(%rip), %rcx      # 0x180011820
180007cc3:     	callq	*0x24a7(%rip)           # 0x18000a170
180007cc9:     	testl	%eax, %eax
180007ccb:     	jne	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180007cd1:     	leaq	0x9668(%rip), %rcx      # 0x180011340
180007cd8:     	callq	*0x2492(%rip)           # 0x18000a170
180007cde:     	testl	%eax, %eax
180007ce0:     	jne	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180007ce6:     	leaq	0x9993(%rip), %rcx      # 0x180011680
180007ced:     	callq	*0x247d(%rip)           # 0x18000a170
180007cf3:     	testl	%eax, %eax
180007cf5:     	jne	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180007cfb:     	xorl	%ebx, %ebx
180007cfd:     	cmpl	%ebx, 0x9f85(%rip)      # 0x180011c88
180007d03:     	jne	0x180007d46 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x57d6>
180007d05:     	movq	%gs:0x58, %rax
180007d0e:     	movl	0x9f8c(%rip), %ecx      # 0x180011ca0
180007d14:     	movl	$0x1, 0x9f6a(%rip)      # 0x180011c88
180007d1e:     	movq	(%rax,%rcx,8), %rdx
180007d22:     	movl	$0x10, %eax
180007d27:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d2e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180007d33:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d3a:     	movl	$0x13d0, %eax           # imm = 0x13D0
180007d3f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d46:     	movl	%ebx, 0x9eec(%rip)      # 0x180011c38
180007d4c:     	movq	%rbx, %rax
180007d4f:     	movb	%bl, 0x9eeb(%rip)       # 0x180011c40
180007d55:     	movq	%rbx, %rcx
180007d58:     	xchgq	%rax, 0x9ee9(%rip)      # 0x180011c48
180007d5f:     	xchgq	%rcx, 0x9eea(%rip)      # 0x180011c50
180007d66:     	movq	%rbx, %rax
180007d69:     	movq	%rbx, %rcx
180007d6c:     	xchgq	%rax, 0x9ee5(%rip)      # 0x180011c58
180007d73:     	xchgq	%rcx, 0x9ee6(%rip)      # 0x180011c60
180007d7a:     	movq	0x22df(%rip), %rax      # 0x18000a060
180007d81:     	leaq	0x9758(%rip), %rcx      # 0x1800114e0
180007d88:     	movq	%rax, 0x9ed9(%rip)      # 0x180011c68
180007d8f:     	movq	0x22da(%rip), %rax      # 0x18000a070
180007d96:     	movq	%rax, 0x9ed3(%rip)      # 0x180011c70
180007d9d:     	movq	0x22c4(%rip), %rax      # 0x18000a068
180007da4:     	movq	%rax, 0x9ecd(%rip)      # 0x180011c78
180007dab:     	movq	0x2496(%rip), %rax      # 0x18000a248
180007db2:     	movq	%rax, 0x985f(%rip)      # 0x180011618
180007db9:     	callq	*0x23b1(%rip)           # 0x18000a170
180007dbf:     	testl	%eax, %eax
180007dc1:     	jne	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180007dc7:     	leaq	0x33f2(%rip), %rdx      # 0x18000b1c0
180007dce:     	movq	%r14, %rcx
180007dd1:     	callq	*0x2391(%rip)           # 0x18000a168
180007dd7:     	movq	%rax, 0x28(%rsp)
180007ddc:     	movq	%rax, %rdi
180007ddf:     	testq	%rax, %rax
180007de2:     	je	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180007de8:     	leaq	0x356a(%rip), %rcx      # 0x18000b359
180007def:     	callq	*0x248b(%rip)           # 0x18000a280
180007df5:     	movq	%rax, 0x20(%rsp)
180007dfa:     	movq	%rax, %r12
180007dfd:     	testq	%rax, %rax
180007e00:     	je	0x180008144 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bd4>
180007e06:     	movl	%ebx, %ebp
180007e08:     	cmpq	%rbx, (%rsi)
180007e0b:     	je	0x180007fb4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5a44>
180007e11:     	movslq	%ebp, %rbx
180007e14:     	leaq	0x30(%rsp), %rdx
180007e19:     	movq	%r14, %rcx
180007e1c:     	leaq	(%rbx,%rbx,4), %rax
180007e20:     	movups	(%r13,%rax,8), %xmm0
180007e26:     	movups	0x10(%r13,%rax,8), %xmm1
180007e2c:     	movaps	%xmm0, 0x30(%rsp)
180007e31:     	movsd	0x20(%r13,%rax,8), %xmm0
180007e38:     	movsd	%xmm0, 0x50(%rsp)
180007e3e:     	movaps	%xmm1, 0x40(%rsp)
180007e43:     	callq	0x180007940 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x53d0>
180007e48:     	movq	%rax, %r14
180007e4b:     	testq	%rax, %rax
180007e4e:     	je	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
180007e54:     	movq	(%rsi), %rcx
180007e57:     	callq	*0x2423(%rip)           # 0x18000a280
180007e5d:     	movq	%rax, %r13
180007e60:     	testq	%rax, %rax
180007e63:     	je	0x180008167 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bf7>
180007e69:     	movq	(%r15,%rbx,8), %rcx
180007e6d:     	xorl	%edx, %edx
180007e6f:     	movq	%r14, (%rcx)
180007e72:     	leaq	0x99a7(%rip), %rcx      # 0x180011820
180007e79:     	movq	0x8(%rsi), %r12
180007e7d:     	callq	*0x22cd(%rip)           # 0x18000a150
180007e83:     	movq	%rax, %rbx
180007e86:     	testq	%rax, %rax
180007e89:     	je	0x180007f06 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5996>
180007e8b:     	movq	%r13, %rcx
180007e8e:     	callq	*0x22ec(%rip)           # 0x18000a180
180007e94:     	movq	%rax, %rdi
180007e97:     	testq	%rax, %rax
180007e9a:     	je	0x180007ebc <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x594c>
180007e9c:     	movq	%rax, %rcx
180007e9f:     	callq	0x180009745 <numba_list_iter_next+0xed5>
180007ea4:     	leaq	0x1(%rax), %rcx
180007ea8:     	callq	*0x23a2(%rip)           # 0x18000a250
180007eae:     	movq	%rax, %rsi
180007eb1:     	testq	%rax, %rax
180007eb4:     	jne	0x180007ec4 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5954>
180007eb6:     	callq	*0x2284(%rip)           # 0x18000a140
180007ebc:     	xorl	%eax, %eax
180007ebe:     	movq	%rax, 0x20(%rbx)
180007ec2:     	jmp	0x180007ef5 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5985>
180007ec4:     	movq	%rdi, %rdx
180007ec7:     	movq	%rsi, %rcx
180007eca:     	callq	0x18000973f <numba_list_iter_next+0xecf>
180007ecf:     	movq	0x20(%rsp), %rcx
180007ed4:     	movq	%rsi, 0x20(%rbx)
180007ed8:     	movq	%r12, 0x28(%rbx)
180007edc:     	movl	$0x3, 0x30(%rbx)
180007ee3:     	callq	0x1800073c0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x4e50>
180007ee8:     	movq	%rax, 0x38(%rbx)
180007eec:     	testq	%rax, %rax
180007eef:     	jne	0x180008060 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5af0>
180007ef5:     	movl	(%rbx), %eax
180007ef7:     	testl	%eax, %eax
180007ef9:     	js	0x180007f06 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5996>
180007efb:     	subl	$0x1, %eax
180007efe:     	movl	%eax, (%rbx)
180007f00:     	je	0x1800080ad <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5b3d>
180007f06:     	xorl	%edi, %edi
180007f08:     	movl	(%r14), %eax
180007f0b:     	testl	%eax, %eax
180007f0d:     	js	0x180007f20 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x59b0>
180007f0f:     	subl	$0x1, %eax
180007f12:     	movl	%eax, (%r14)
180007f15:     	jne	0x180007f20 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x59b0>
180007f17:     	movq	%r14, %rcx
180007f1a:     	callq	*0x22a8(%rip)           # 0x18000a1c8
180007f20:     	movl	(%r13), %eax
180007f24:     	testl	%eax, %eax
180007f26:     	js	0x180007f3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x59ca>
180007f28:     	subl	$0x1, %eax
180007f2b:     	movl	%eax, (%r13)
180007f2f:     	jne	0x180007f3a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x59ca>
180007f31:     	movq	%r13, %rcx
180007f34:     	callq	*0x228e(%rip)           # 0x18000a1c8
180007f3a:     	testq	%rdi, %rdi
180007f3d:     	je	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
180007f43:     	movq	0xb8(%rsp), %rsi
180007f4b:     	movq	%rdi, %r8
180007f4e:     	movq	0xb0(%rsp), %r14
180007f56:     	movq	%r14, %rcx
180007f59:     	movq	(%rsi), %rdx
180007f5c:     	callq	*0x22be(%rip)           # 0x18000a220
180007f62:     	movl	(%rdi), %ecx
180007f64:     	testl	%eax, %eax
180007f66:     	jne	0x18000810a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5b9a>
180007f6c:     	testl	%ecx, %ecx
180007f6e:     	js	0x180007f82 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5a12>
180007f70:     	leal	-0x1(%rcx), %eax
180007f73:     	movl	%eax, (%rdi)
180007f75:     	testl	%eax, %eax
180007f77:     	jne	0x180007f82 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5a12>
180007f79:     	movq	%rdi, %rcx
180007f7c:     	callq	*0x2246(%rip)           # 0x18000a1c8
180007f82:     	movq	0xc8(%rsp), %r15
180007f8a:     	addq	$0x20, %rsi
180007f8e:     	movq	0xc0(%rsp), %r13
180007f96:     	incl	%ebp
180007f98:     	movq	%rsi, 0xb8(%rsp)
180007fa0:     	cmpq	$0x0, (%rsi)
180007fa4:     	jne	0x180007e11 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x58a1>
180007faa:     	movq	0x20(%rsp), %r12
180007faf:     	movq	0x28(%rsp), %rdi
180007fb4:     	movslq	%ebp, %rax
180007fb7:     	cmpq	$0x0, (%r15,%rax,8)
180007fbc:     	je	0x180008029 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5ab9>
180007fbe:     	nop
180007fc0:     	movslq	%ebp, %rbx
180007fc3:     	leaq	0x30(%rsp), %rdx
180007fc8:     	movq	%r14, %rcx
180007fcb:     	leaq	(%rbx,%rbx,4), %rax
180007fcf:     	movups	(%r13,%rax,8), %xmm0
180007fd5:     	movups	0x10(%r13,%rax,8), %xmm1
180007fdb:     	movaps	%xmm0, 0x30(%rsp)
180007fe0:     	movsd	0x20(%r13,%rax,8), %xmm0
180007fe7:     	movsd	%xmm0, 0x50(%rsp)
180007fed:     	movaps	%xmm1, 0x40(%rsp)
180007ff2:     	callq	0x180007940 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x53d0>
180007ff7:     	testq	%rax, %rax
180007ffa:     	je	0x180008125 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb5>
180008000:     	movq	(%r15,%rbx,8), %rcx
180008004:     	movq	%rax, (%rcx)
180008007:     	movl	(%rax), %ecx
180008009:     	testl	%ecx, %ecx
18000800b:     	js	0x18000801d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5aad>
18000800d:     	subl	$0x1, %ecx
180008010:     	movl	%ecx, (%rax)
180008012:     	jne	0x18000801d <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5aad>
180008014:     	movq	%rax, %rcx
180008017:     	callq	*0x21ab(%rip)           # 0x18000a1c8
18000801d:     	incl	%ebp
18000801f:     	movslq	%ebp, %rax
180008022:     	cmpq	$0x0, (%r15,%rax,8)
180008027:     	jne	0x180007fc0 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5a50>
180008029:     	movl	(%r12), %eax
18000802d:     	testl	%eax, %eax
18000802f:     	js	0x180008043 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5ad3>
180008031:     	subl	$0x1, %eax
180008034:     	movl	%eax, (%r12)
180008038:     	jne	0x180008043 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5ad3>
18000803a:     	movq	%r12, %rcx
18000803d:     	callq	*0x2185(%rip)           # 0x18000a1c8
180008043:     	movl	(%rdi), %eax
180008045:     	testl	%eax, %eax
180008047:     	js	0x180008059 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5ae9>
180008049:     	subl	$0x1, %eax
18000804c:     	movl	%eax, (%rdi)
18000804e:     	jne	0x180008059 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5ae9>
180008050:     	movq	%rdi, %rcx
180008053:     	callq	*0x216f(%rip)           # 0x18000a1c8
180008059:     	xorl	%eax, %eax
18000805b:     	jmp	0x180007c49 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d9>
180008060:     	movl	(%r14), %eax
180008063:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180008068:     	jae	0x18000806f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5aff>
18000806a:     	incl	%eax
18000806c:     	movl	%eax, (%r14)
18000806f:     	movq	0xb0(%rsp), %rcx
180008077:     	leaq	0x3142(%rip), %rdx      # 0x18000b1c0
18000807e:     	movq	%r14, 0x18(%rbx)
180008082:     	movq	$0x0, 0x40(%rbx)
18000808a:     	callq	*0x20d8(%rip)           # 0x18000a168
180008090:     	movq	%rax, %rsi
180008093:     	testq	%rax, %rax
180008096:     	jne	0x1800080bb <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5b4b>
180008098:     	movl	(%rbx), %eax
18000809a:     	testl	%eax, %eax
18000809c:     	js	0x180007f06 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5996>
1800080a2:     	subl	$0x1, %eax
1800080a5:     	movl	%eax, (%rbx)
1800080a7:     	jne	0x180007f06 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5996>
1800080ad:     	movq	%rbx, %rcx
1800080b0:     	callq	*0x2112(%rip)           # 0x18000a1c8
1800080b6:     	jmp	0x180007f06 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5996>
1800080bb:     	xorl	%r9d, %r9d
1800080be:     	leaq	0x20(%rbx), %rcx
1800080c2:     	movq	%rsi, %r8
1800080c5:     	movq	%rbx, %rdx
1800080c8:     	callq	*0x207a(%rip)           # 0x18000a148
1800080ce:     	movq	%rax, %rdi
1800080d1:     	movl	(%rbx), %eax
1800080d3:     	testl	%eax, %eax
1800080d5:     	js	0x1800080e7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5b77>
1800080d7:     	subl	$0x1, %eax
1800080da:     	movl	%eax, (%rbx)
1800080dc:     	jne	0x1800080e7 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5b77>
1800080de:     	movq	%rbx, %rcx
1800080e1:     	callq	*0x20e1(%rip)           # 0x18000a1c8
1800080e7:     	movl	(%rsi), %eax
1800080e9:     	testl	%eax, %eax
1800080eb:     	js	0x180007f08 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5998>
1800080f1:     	subl	$0x1, %eax
1800080f4:     	movl	%eax, (%rsi)
1800080f6:     	jne	0x180007f08 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5998>
1800080fc:     	movq	%rsi, %rcx
1800080ff:     	callq	*0x20c3(%rip)           # 0x18000a1c8
180008105:     	jmp	0x180007f08 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5998>
18000810a:     	testl	%ecx, %ecx
18000810c:     	js	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
18000810e:     	leal	-0x1(%rcx), %eax
180008111:     	movl	%eax, (%rdi)
180008113:     	testl	%eax, %eax
180008115:     	jne	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
180008117:     	movq	%rdi, %rcx
18000811a:     	callq	*0x20a8(%rip)           # 0x18000a1c8
180008120:     	movq	0x20(%rsp), %r12
180008125:     	movl	(%r12), %eax
180008129:     	testl	%eax, %eax
18000812b:     	js	0x18000813f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bcf>
18000812d:     	subl	$0x1, %eax
180008130:     	movl	%eax, (%r12)
180008134:     	jne	0x18000813f <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bcf>
180008136:     	movq	%r12, %rcx
180008139:     	callq	*0x2089(%rip)           # 0x18000a1c8
18000813f:     	movq	0x28(%rsp), %rdi
180008144:     	movl	(%rdi), %eax
180008146:     	testl	%eax, %eax
180008148:     	js	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
18000814e:     	subl	$0x1, %eax
180008151:     	movl	%eax, (%rdi)
180008153:     	jne	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180008159:     	movq	%rdi, %rcx
18000815c:     	callq	*0x2066(%rip)           # 0x18000a1c8
180008162:     	jmp	0x180007c44 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x56d4>
180008167:     	movl	(%r14), %eax
18000816a:     	testl	%eax, %eax
18000816c:     	js	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
18000816e:     	subl	$0x1, %eax
180008171:     	movl	%eax, (%r14)
180008174:     	jne	0x180008120 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5bb0>
180008176:     	movq	%r14, %rcx
180008179:     	jmp	0x18000811a <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5baa>
18000817b:     	int3
18000817c:     	int3
18000817d:     	int3
18000817e:     	int3
18000817f:     	int3
180008180:     	leaq	0x9b81(%rip), %rax      # 0x180011d08
180008187:     	retq
180008188:     	int3
180008189:     	int3
18000818a:     	int3
18000818b:     	int3
18000818c:     	int3
18000818d:     	int3
18000818e:     	int3
18000818f:     	int3

0000000180008190 <numba_list_set_method_table>:
180008190:     	movups	(%rdx), %xmm0
180008193:     	movups	%xmm0, 0x20(%rcx)
180008197:     	retq
180008198:     	int3
180008199:     	int3
18000819a:     	int3
18000819b:     	int3
18000819c:     	int3
18000819d:     	int3
18000819e:     	int3
18000819f:     	int3

00000001800081a0 <numba_list_new>:
1800081a0:     	pushq	%rbx
1800081a2:     	pushq	%rbp
1800081a3:     	pushq	%rsi
1800081a4:     	pushq	%rdi
1800081a5:     	subq	$0x28, %rsp
1800081a9:     	movq	%rcx, %rsi
1800081ac:     	movq	%r8, %rdi
1800081af:     	movl	$0x38, %ecx
1800081b4:     	movq	%rdx, %rbp
1800081b7:     	callq	*0x1ea3(%rip)           # 0x18000a060
1800081bd:     	movq	%rax, %rbx
1800081c0:     	testq	%rax, %rax
1800081c3:     	je	0x18000822d <numba_list_new+0x8d>
1800081c5:     	movq	$0x0, (%rax)
1800081cc:     	xorps	%xmm0, %xmm0
1800081cf:     	movq	%rbp, 0x8(%rax)
1800081d3:     	movq	%rdi, 0x10(%rax)
1800081d7:     	movl	$0x1, 0x18(%rax)
1800081de:     	movups	%xmm0, 0x20(%rax)
1800081e2:     	testq	%rdi, %rdi
1800081e5:     	je	0x18000823b <numba_list_new+0x9b>
1800081e7:     	imulq	%rbp, %rdi
1800081eb:     	movl	$0x8, %ecx
1800081f0:     	movq	%rdi, %rax
1800081f3:     	cqto
1800081f5:     	andl	$0x7, %edx
1800081f8:     	addq	%rdx, %rax
1800081fb:     	andl	$0x7, %eax
1800081fe:     	subq	%rdx, %rax
180008201:     	subq	%rax, %rcx
180008204:     	movq	%rcx, %rax
180008207:     	cqto
180008209:     	andl	$0x7, %edx
18000820c:     	leaq	(%rdx,%rax), %rcx
180008210:     	andl	$0x7, %ecx
180008213:     	subq	%rdx, %rcx
180008216:     	addq	%rdi, %rcx
180008219:     	callq	*0x1e41(%rip)           # 0x18000a060
18000821f:     	testq	%rax, %rax
180008222:     	jne	0x18000823d <numba_list_new+0x9d>
180008224:     	movq	%rbx, %rcx
180008227:     	callq	*0x1e3b(%rip)           # 0x18000a068
18000822d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180008232:     	addq	$0x28, %rsp
180008236:     	popq	%rdi
180008237:     	popq	%rsi
180008238:     	popq	%rbp
180008239:     	popq	%rbx
18000823a:     	retq
18000823b:     	xorl	%eax, %eax
18000823d:     	movq	%rax, 0x30(%rbx)
180008241:     	xorl	%eax, %eax
180008243:     	movq	%rbx, (%rsi)
180008246:     	addq	$0x28, %rsp
18000824a:     	popq	%rdi
18000824b:     	popq	%rsi
18000824c:     	popq	%rbp
18000824d:     	popq	%rbx
18000824e:     	retq
18000824f:     	int3

0000000180008250 <numba_list_free>:
180008250:     	pushq	%rbx
180008252:     	subq	$0x20, %rsp
180008256:     	cmpq	$0x0, 0x28(%rcx)
18000825b:     	movq	%rcx, %rbx
18000825e:     	je	0x180008294 <numba_list_free+0x44>
180008260:     	movq	%rdi, 0x30(%rsp)
180008265:     	xorl	%edi, %edi
180008267:     	cmpq	%rdi, (%rcx)
18000826a:     	jle	0x18000828f <numba_list_free+0x3f>
18000826c:     	nopl	(%rax)
180008270:     	movq	0x28(%rbx), %rax
180008274:     	testq	%rax, %rax
180008277:     	je	0x180008287 <numba_list_free+0x37>
180008279:     	movq	%rdi, %rcx
18000827c:     	imulq	0x8(%rbx), %rcx
180008281:     	addq	0x30(%rbx), %rcx
180008285:     	callq	*%rax
180008287:     	incq	%rdi
18000828a:     	cmpq	(%rbx), %rdi
18000828d:     	jl	0x180008270 <numba_list_free+0x20>
18000828f:     	movq	0x30(%rsp), %rdi
180008294:     	movq	0x30(%rbx), %rcx
180008298:     	testq	%rcx, %rcx
18000829b:     	je	0x1800082a3 <numba_list_free+0x53>
18000829d:     	callq	*0x1dc5(%rip)           # 0x18000a068
1800082a3:     	movq	%rbx, %rcx
1800082a6:     	addq	$0x20, %rsp
1800082aa:     	popq	%rbx
1800082ab:     	jmpq	*0x1db6(%rip)           # 0x18000a068
1800082b2:     	int3
1800082b3:     	int3
1800082b4:     	int3
1800082b5:     	int3
1800082b6:     	int3
1800082b7:     	int3
1800082b8:     	int3
1800082b9:     	int3
1800082ba:     	int3
1800082bb:     	int3
1800082bc:     	int3
1800082bd:     	int3
1800082be:     	int3
1800082bf:     	int3

00000001800082c0 <numba_list_base_ptr>:
1800082c0:     	movq	0x30(%rcx), %rax
1800082c4:     	retq
1800082c5:     	int3
1800082c6:     	int3
1800082c7:     	int3
1800082c8:     	int3
1800082c9:     	int3
1800082ca:     	int3
1800082cb:     	int3
1800082cc:     	int3
1800082cd:     	int3
1800082ce:     	int3
1800082cf:     	int3

00000001800082d0 <numba_list_size_address>:
1800082d0:     	movq	%rcx, %rax
1800082d3:     	retq
1800082d4:     	int3
1800082d5:     	int3
1800082d6:     	int3
1800082d7:     	int3
1800082d8:     	int3
1800082d9:     	int3
1800082da:     	int3
1800082db:     	int3
1800082dc:     	int3
1800082dd:     	int3
1800082de:     	int3
1800082df:     	int3

00000001800082e0 <numba_list_length>:
1800082e0:     	movq	(%rcx), %rax
1800082e3:     	retq
1800082e4:     	int3
1800082e5:     	int3
1800082e6:     	int3
1800082e7:     	int3
1800082e8:     	int3
1800082e9:     	int3
1800082ea:     	int3
1800082eb:     	int3
1800082ec:     	int3
1800082ed:     	int3
1800082ee:     	int3
1800082ef:     	int3

00000001800082f0 <numba_list_allocated>:
1800082f0:     	movq	0x10(%rcx), %rax
1800082f4:     	retq
1800082f5:     	int3
1800082f6:     	int3
1800082f7:     	int3
1800082f8:     	int3
1800082f9:     	int3
1800082fa:     	int3
1800082fb:     	int3
1800082fc:     	int3
1800082fd:     	int3
1800082fe:     	int3
1800082ff:     	int3

0000000180008300 <numba_list_is_mutable>:
180008300:     	movl	0x18(%rcx), %eax
180008303:     	retq
180008304:     	int3
180008305:     	int3
180008306:     	int3
180008307:     	int3
180008308:     	int3
180008309:     	int3
18000830a:     	int3
18000830b:     	int3
18000830c:     	int3
18000830d:     	int3
18000830e:     	int3
18000830f:     	int3

0000000180008310 <numba_list_set_is_mutable>:
180008310:     	movl	%edx, 0x18(%rcx)
180008313:     	retq
180008314:     	int3
180008315:     	int3
180008316:     	int3
180008317:     	int3
180008318:     	int3
180008319:     	int3
18000831a:     	int3
18000831b:     	int3
18000831c:     	int3
18000831d:     	int3
18000831e:     	int3
18000831f:     	int3

0000000180008320 <numba_list_setitem>:
180008320:     	movq	%rbx, 0x10(%rsp)
180008325:     	pushq	%rsi
180008326:     	subq	$0x20, %rsp
18000832a:     	cmpl	$0x0, 0x18(%rcx)
18000832e:     	movq	%r8, %rsi
180008331:     	movq	%rcx, %rbx
180008334:     	jne	0x180008346 <numba_list_setitem+0x26>
180008336:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000833b:     	movq	0x38(%rsp), %rbx
180008340:     	addq	$0x20, %rsp
180008344:     	popq	%rsi
180008345:     	retq
180008346:     	cmpq	(%rcx), %rdx
180008349:     	jb	0x18000835b <numba_list_setitem+0x3b>
18000834b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180008350:     	movq	0x38(%rsp), %rbx
180008355:     	addq	$0x20, %rsp
180008359:     	popq	%rsi
18000835a:     	retq
18000835b:     	imulq	0x8(%rcx), %rdx
180008360:     	movq	0x28(%rcx), %rax
180008364:     	movq	%rdi, 0x30(%rsp)
180008369:     	movq	0x30(%rcx), %rdi
18000836d:     	addq	%rdx, %rdi
180008370:     	testq	%rax, %rax
180008373:     	je	0x18000837a <numba_list_setitem+0x5a>
180008375:     	movq	%rdi, %rcx
180008378:     	callq	*%rax
18000837a:     	movq	0x8(%rbx), %r8
18000837e:     	movq	%rsi, %rdx
180008381:     	movq	%rdi, %rcx
180008384:     	callq	0x180009733 <numba_list_iter_next+0xec3>
180008389:     	movq	0x20(%rbx), %rax
18000838d:     	testq	%rax, %rax
180008390:     	je	0x180008397 <numba_list_setitem+0x77>
180008392:     	movq	%rdi, %rcx
180008395:     	callq	*%rax
180008397:     	movq	0x30(%rsp), %rdi
18000839c:     	xorl	%eax, %eax
18000839e:     	movq	0x38(%rsp), %rbx
1800083a3:     	addq	$0x20, %rsp
1800083a7:     	popq	%rsi
1800083a8:     	retq
1800083a9:     	int3
1800083aa:     	int3
1800083ab:     	int3
1800083ac:     	int3
1800083ad:     	int3
1800083ae:     	int3
1800083af:     	int3

00000001800083b0 <numba_list_getitem>:
1800083b0:     	subq	$0x28, %rsp
1800083b4:     	movq	%r8, %r9
1800083b7:     	movq	%rdx, %rax
1800083ba:     	cmpq	(%rcx), %rdx
1800083bd:     	jb	0x1800083c9 <numba_list_getitem+0x19>
1800083bf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800083c4:     	addq	$0x28, %rsp
1800083c8:     	retq
1800083c9:     	movq	0x8(%rcx), %r8
1800083cd:     	movq	%r8, %rdx
1800083d0:     	imulq	%rax, %rdx
1800083d4:     	addq	0x30(%rcx), %rdx
1800083d8:     	movq	%r9, %rcx
1800083db:     	callq	0x180009733 <numba_list_iter_next+0xec3>
1800083e0:     	xorl	%eax, %eax
1800083e2:     	addq	$0x28, %rsp
1800083e6:     	retq
1800083e7:     	int3
1800083e8:     	int3
1800083e9:     	int3
1800083ea:     	int3
1800083eb:     	int3
1800083ec:     	int3
1800083ed:     	int3
1800083ee:     	int3
1800083ef:     	int3

00000001800083f0 <numba_list_append>:
1800083f0:     	movq	%rbx, 0x10(%rsp)
1800083f5:     	pushq	%rsi
1800083f6:     	subq	$0x20, %rsp
1800083fa:     	cmpl	$0x0, 0x18(%rcx)
1800083fe:     	movq	%rdx, %rsi
180008401:     	movq	%rcx, %rbx
180008404:     	jne	0x180008416 <numba_list_append+0x26>
180008406:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000840b:     	movq	0x38(%rsp), %rbx
180008410:     	addq	$0x20, %rsp
180008414:     	popq	%rsi
180008415:     	retq
180008416:     	movq	(%rcx), %rdx
180008419:     	incq	%rdx
18000841c:     	callq	0x180008470 <numba_list_resize>
180008421:     	testl	%eax, %eax
180008423:     	js	0x18000845c <numba_list_append+0x6c>
180008425:     	movq	0x8(%rbx), %r8
180008429:     	movq	%rsi, %rdx
18000842c:     	movq	%rdi, 0x30(%rsp)
180008431:     	movq	(%rbx), %rdi
180008434:     	decq	%rdi
180008437:     	imulq	%r8, %rdi
18000843b:     	addq	0x30(%rbx), %rdi
18000843f:     	movq	%rdi, %rcx
180008442:     	callq	0x180009733 <numba_list_iter_next+0xec3>
180008447:     	movq	0x20(%rbx), %rax
18000844b:     	testq	%rax, %rax
18000844e:     	je	0x180008455 <numba_list_append+0x65>
180008450:     	movq	%rdi, %rcx
180008453:     	callq	*%rax
180008455:     	movq	0x30(%rsp), %rdi
18000845a:     	xorl	%eax, %eax
18000845c:     	movq	0x38(%rsp), %rbx
180008461:     	addq	$0x20, %rsp
180008465:     	popq	%rsi
180008466:     	retq
180008467:     	int3
180008468:     	int3
180008469:     	int3
18000846a:     	int3
18000846b:     	int3
18000846c:     	int3
18000846d:     	int3
18000846e:     	int3
18000846f:     	int3

0000000180008470 <numba_list_resize>:
180008470:     	movq	%rsi, 0x18(%rsp)
180008475:     	pushq	%rdi
180008476:     	subq	$0x20, %rsp
18000847a:     	cmpl	$0x0, 0x18(%rcx)
18000847e:     	movq	%rdx, %rsi
180008481:     	movq	%rcx, %rdi
180008484:     	jne	0x180008496 <numba_list_resize+0x26>
180008486:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000848b:     	movq	0x40(%rsp), %rsi
180008490:     	addq	$0x20, %rsp
180008494:     	popq	%rdi
180008495:     	retq
180008496:     	movq	0x10(%rcx), %rax
18000849a:     	cmpq	%rsi, %rax
18000849d:     	jl	0x1800084b7 <numba_list_resize+0x47>
18000849f:     	sarq	%rax
1800084a2:     	cmpq	%rax, %rsi
1800084a5:     	jl	0x1800084b7 <numba_list_resize+0x47>
1800084a7:     	movq	%rsi, (%rcx)
1800084aa:     	xorl	%eax, %eax
1800084ac:     	movq	0x40(%rsp), %rsi
1800084b1:     	addq	$0x20, %rsp
1800084b5:     	popq	%rdi
1800084b6:     	retq
1800084b7:     	cmpq	$0x9, %rsi
1800084bb:     	movq	%rbp, 0x38(%rsp)
1800084c0:     	movl	$0x3, %ecx
1800084c5:     	movl	$0x6, %eax
1800084ca:     	cmovll	%ecx, %eax
1800084cd:     	movq	%rsi, %r8
1800084d0:     	movq	0x8(%rdi), %rcx
1800084d4:     	addq	%rsi, %rax
1800084d7:     	sarq	$0x3, %r8
1800084db:     	xorl	%edx, %edx
1800084dd:     	addq	%rax, %r8
1800084e0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
1800084ea:     	divq	%rcx
1800084ed:     	cmpq	%rax, %r8
1800084f0:     	ja	0x18000856b <numba_list_resize+0xfb>
1800084f2:     	xorl	%ebp, %ebp
1800084f4:     	movq	%rbx, 0x30(%rsp)
1800084f9:     	testq	%rsi, %rsi
1800084fc:     	cmovneq	%r8, %rbp
180008500:     	movq	%rbp, %rbx
180008503:     	imulq	%rcx, %rbx
180008507:     	movl	$0x8, %ecx
18000850c:     	movq	%rbx, %rax
18000850f:     	cqto
180008511:     	andl	$0x7, %edx
180008514:     	addq	%rdx, %rax
180008517:     	andl	$0x7, %eax
18000851a:     	subq	%rdx, %rax
18000851d:     	subq	%rax, %rcx
180008520:     	movq	%rcx, %rax
180008523:     	movq	0x30(%rdi), %rcx
180008527:     	cqto
180008529:     	andl	$0x7, %edx
18000852c:     	addq	%rdx, %rax
18000852f:     	andl	$0x7, %eax
180008532:     	subq	%rdx, %rax
180008535:     	leaq	(%rbx,%rax), %rdx
180008539:     	callq	*0x1b31(%rip)           # 0x18000a070
18000853f:     	testq	%rbx, %rbx
180008542:     	movq	0x30(%rsp), %rbx
180008547:     	je	0x18000854e <numba_list_resize+0xde>
180008549:     	testq	%rax, %rax
18000854c:     	je	0x18000856b <numba_list_resize+0xfb>
18000854e:     	movq	%rax, 0x30(%rdi)
180008552:     	xorl	%eax, %eax
180008554:     	movq	%rbp, 0x10(%rdi)
180008558:     	movq	0x38(%rsp), %rbp
18000855d:     	movq	%rsi, (%rdi)
180008560:     	movq	0x40(%rsp), %rsi
180008565:     	addq	$0x20, %rsp
180008569:     	popq	%rdi
18000856a:     	retq
18000856b:     	movq	0x38(%rsp), %rbp
180008570:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180008575:     	movq	0x40(%rsp), %rsi
18000857a:     	addq	$0x20, %rsp
18000857e:     	popq	%rdi
18000857f:     	retq

0000000180008580 <numba_list_delitem>:
180008580:     	movq	%rbx, 0x10(%rsp)
180008585:     	pushq	%rdi
180008586:     	subq	$0x20, %rsp
18000858a:     	cmpl	$0x0, 0x18(%rcx)
18000858e:     	movq	%rdx, %rdi
180008591:     	movq	%rcx, %rbx
180008594:     	jne	0x1800085a6 <numba_list_delitem+0x26>
180008596:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000859b:     	movq	0x38(%rsp), %rbx
1800085a0:     	addq	$0x20, %rsp
1800085a4:     	popq	%rdi
1800085a5:     	retq
1800085a6:     	cmpq	(%rcx), %rdi
1800085a9:     	jb	0x1800085bb <numba_list_delitem+0x3b>
1800085ab:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800085b0:     	movq	0x38(%rsp), %rbx
1800085b5:     	addq	$0x20, %rsp
1800085b9:     	popq	%rdi
1800085ba:     	retq
1800085bb:     	movq	0x28(%rcx), %rax
1800085bf:     	movq	%rsi, 0x30(%rsp)
1800085c4:     	movq	%rdi, %rsi
1800085c7:     	imulq	0x8(%rcx), %rsi
1800085cc:     	addq	0x30(%rcx), %rsi
1800085d0:     	testq	%rax, %rax
1800085d3:     	je	0x1800085da <numba_list_delitem+0x5a>
1800085d5:     	movq	%rsi, %rcx
1800085d8:     	callq	*%rax
1800085da:     	movq	(%rbx), %r8
1800085dd:     	leaq	-0x1(%r8), %rax
1800085e1:     	cmpq	%rax, %rdi
1800085e4:     	je	0x180008606 <numba_list_delitem+0x86>
1800085e6:     	subq	%rdi, %r8
1800085e9:     	leaq	0x1(%rdi), %rdx
1800085ed:     	imulq	0x8(%rbx), %rdx
1800085f2:     	decq	%r8
1800085f5:     	movq	%rsi, %rcx
1800085f8:     	imulq	0x8(%rbx), %r8
1800085fd:     	addq	0x30(%rbx), %rdx
180008601:     	callq	0x180009739 <numba_list_iter_next+0xec9>
180008606:     	movq	(%rbx), %rdx
180008609:     	movq	%rbx, %rcx
18000860c:     	decq	%rdx
18000860f:     	callq	0x180008470 <numba_list_resize>
180008614:     	movq	0x30(%rsp), %rsi
180008619:     	xorl	%ecx, %ecx
18000861b:     	movq	0x38(%rsp), %rbx
180008620:     	testl	%eax, %eax
180008622:     	cmovsl	%eax, %ecx
180008625:     	movl	%ecx, %eax
180008627:     	addq	$0x20, %rsp
18000862b:     	popq	%rdi
18000862c:     	retq
18000862d:     	int3
18000862e:     	int3
18000862f:     	int3

0000000180008630 <numba_list_delete_slice>:
180008630:     	pushq	%rbx
180008632:     	pushq	%rbp
180008633:     	pushq	%rdi
180008634:     	pushq	%r15
180008636:     	subq	$0x38, %rsp
18000863a:     	cmpl	$0x0, 0x18(%rcx)
18000863e:     	movq	%r9, %rdi
180008641:     	movq	%r8, %rbp
180008644:     	movq	%rdx, %r15
180008647:     	movq	%rcx, %rbx
18000864a:     	jne	0x18000865b <numba_list_delete_slice+0x2b>
18000864c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180008651:     	addq	$0x38, %rsp
180008655:     	popq	%r15
180008657:     	popq	%rdi
180008658:     	popq	%rbp
180008659:     	popq	%rbx
18000865a:     	retq
18000865b:     	movq	%r13, 0x78(%rsp)
180008660:     	testq	%rdi, %rdi
180008663:     	jle	0x180008682 <numba_list_delete_slice+0x52>
180008665:     	cmpq	%r8, %r15
180008668:     	jge	0x180008821 <numba_list_delete_slice+0x1f1>
18000866e:     	movq	%r8, %rax
180008671:     	subq	%r15, %rax
180008674:     	decq	%rax
180008677:     	cqto
180008679:     	idivq	%rdi
18000867c:     	leal	0x1(%rax), %r13d
180008680:     	jmp	0x1800086a2 <numba_list_delete_slice+0x72>
180008682:     	cmpq	%r15, %r8
180008685:     	jge	0x180008821 <numba_list_delete_slice+0x1f1>
18000868b:     	movq	%r15, %rax
18000868e:     	movl	$0x1, %r13d
180008694:     	subq	%r8, %rax
180008697:     	decq	%rax
18000869a:     	cqto
18000869c:     	idivq	%rdi
18000869f:     	subl	%eax, %r13d
1800086a2:     	testl	%r13d, %r13d
1800086a5:     	jle	0x180008821 <numba_list_delete_slice+0x1f1>
1800086ab:     	movq	%rsi, 0x68(%rsp)
1800086b0:     	movl	(%rcx), %esi
1800086b2:     	subl	%r13d, %esi
1800086b5:     	movl	%esi, 0x20(%rsp)
1800086b9:     	testq	%rdi, %rdi
1800086bc:     	jns	0x1800086d7 <numba_list_delete_slice+0xa7>
1800086be:     	leaq	0x1(%r15), %rbp
1800086c2:     	leal	-0x1(%r13), %eax
1800086c6:     	movslq	%eax, %rcx
1800086c9:     	leaq	-0x1(%rbp), %r15
1800086cd:     	imulq	%rdi, %rcx
1800086d1:     	addq	%rcx, %r15
1800086d4:     	negq	%rdi
1800086d7:     	cmpq	$0x1, %rdi
1800086db:     	jne	0x180008727 <numba_list_delete_slice+0xf7>
1800086dd:     	cmpq	$0x0, 0x28(%rbx)
1800086e2:     	je	0x180008709 <numba_list_delete_slice+0xd9>
1800086e4:     	movslq	%r15d, %rdi
1800086e7:     	cmpq	%rbp, %rdi
1800086ea:     	jge	0x180008709 <numba_list_delete_slice+0xd9>
1800086ec:     	nopl	(%rax)
1800086f0:     	movslq	%edi, %rcx
1800086f3:     	imulq	0x8(%rbx), %rcx
1800086f8:     	addq	0x30(%rbx), %rcx
1800086fc:     	callq	*0x28(%rbx)
1800086ff:     	incl	%edi
180008701:     	movslq	%edi, %rax
180008704:     	cmpq	%rbp, %rax
180008707:     	jl	0x1800086f0 <numba_list_delete_slice+0xc0>
180008709:     	movq	0x8(%rbx), %rcx
18000870d:     	movq	(%rbx), %r8
180008710:     	movq	%rcx, %rdx
180008713:     	subq	%rbp, %r8
180008716:     	imulq	%rcx, %r8
18000871a:     	imulq	%rbp, %rdx
18000871e:     	imulq	%r15, %rcx
180008722:     	jmp	0x1800087ec <numba_list_delete_slice+0x1bc>
180008727:     	movq	%r14, 0x30(%rsp)
18000872c:     	movq	%r15, %r14
18000872f:     	movl	$0x0, 0x60(%rsp)
180008737:     	cmpq	%rbp, %r15
18000873a:     	jge	0x1800087b9 <numba_list_delete_slice+0x189>
18000873c:     	movq	%r12, 0x70(%rsp)
180008741:     	movq	(%rbx), %rax
180008744:     	leaq	(%r14,%rdi), %r12
180008748:     	cmpq	%rax, %r12
18000874b:     	jl	0x180008758 <numba_list_delete_slice+0x128>
18000874d:     	movq	%r14, %rsi
180008750:     	notq	%rsi
180008753:     	addq	%rax, %rsi
180008756:     	jmp	0x18000875c <numba_list_delete_slice+0x12c>
180008758:     	leaq	-0x1(%rdi), %rsi
18000875c:     	movq	0x28(%rbx), %rax
180008760:     	testq	%rax, %rax
180008763:     	je	0x180008773 <numba_list_delete_slice+0x143>
180008765:     	movq	%r14, %rcx
180008768:     	imulq	0x8(%rbx), %rcx
18000876d:     	addq	0x30(%rbx), %rcx
180008771:     	callq	*%rax
180008773:     	movq	0x8(%rbx), %r9
180008777:     	leaq	0x1(%r14), %rdx
18000877b:     	movq	0x30(%rbx), %r10
18000877f:     	movq	%r9, %r8
180008782:     	imulq	%rsi, %r8
180008786:     	imulq	%r9, %rdx
18000878a:     	movslq	0x60(%rsp), %rsi
18000878f:     	subq	%rsi, %r14
180008792:     	imulq	%r9, %r14
180008796:     	addq	%r10, %rdx
180008799:     	leaq	(%r10,%r14), %rcx
18000879d:     	callq	0x180009739 <numba_list_iter_next+0xec9>
1800087a2:     	incl	%esi
1800087a4:     	movq	%r12, %r14
1800087a7:     	movl	%esi, 0x60(%rsp)
1800087ab:     	cmpq	%rbp, %r12
1800087ae:     	jl	0x180008741 <numba_list_delete_slice+0x111>
1800087b0:     	movq	0x70(%rsp), %r12
1800087b5:     	movl	0x20(%rsp), %esi
1800087b9:     	movq	(%rbx), %r8
1800087bc:     	movq	0x30(%rsp), %r14
1800087c1:     	movslq	%r13d, %r10
1800087c4:     	movq	%r10, %rcx
1800087c7:     	imulq	%rdi, %rcx
1800087cb:     	addq	%r15, %rcx
1800087ce:     	cmpq	%r8, %rcx
1800087d1:     	jge	0x1800087f9 <numba_list_delete_slice+0x1c9>
1800087d3:     	movq	0x8(%rbx), %rax
1800087d7:     	subq	%rcx, %r8
1800087da:     	movq	%rax, %rdx
1800087dd:     	imulq	%rcx, %rdx
1800087e1:     	imulq	%rax, %r8
1800087e5:     	subq	%r10, %rcx
1800087e8:     	imulq	%rax, %rcx
1800087ec:     	addq	0x30(%rbx), %rdx
1800087f0:     	addq	0x30(%rbx), %rcx
1800087f4:     	callq	0x180009739 <numba_list_iter_next+0xec9>
1800087f9:     	movslq	%esi, %rdx
1800087fc:     	movq	%rbx, %rcx
1800087ff:     	callq	0x180008470 <numba_list_resize>
180008804:     	movq	0x68(%rsp), %rsi
180008809:     	xorl	%ecx, %ecx
18000880b:     	movq	0x78(%rsp), %r13
180008810:     	testl	%eax, %eax
180008812:     	cmovsl	%eax, %ecx
180008815:     	movl	%ecx, %eax
180008817:     	addq	$0x38, %rsp
18000881b:     	popq	%r15
18000881d:     	popq	%rdi
18000881e:     	popq	%rbp
18000881f:     	popq	%rbx
180008820:     	retq
180008821:     	movq	0x78(%rsp), %r13
180008826:     	xorl	%eax, %eax
180008828:     	addq	$0x38, %rsp
18000882c:     	popq	%r15
18000882e:     	popq	%rdi
18000882f:     	popq	%rbp
180008830:     	popq	%rbx
180008831:     	retq
180008832:     	int3
180008833:     	int3
180008834:     	int3
180008835:     	int3
180008836:     	int3
180008837:     	int3
180008838:     	int3
180008839:     	int3
18000883a:     	int3
18000883b:     	int3
18000883c:     	int3
18000883d:     	int3
18000883e:     	int3
18000883f:     	int3

0000000180008840 <numba_list_iter_sizeof>:
180008840:     	movl	$0x18, %eax
180008845:     	retq
180008846:     	int3
180008847:     	int3
180008848:     	int3
180008849:     	int3
18000884a:     	int3
18000884b:     	int3
18000884c:     	int3
18000884d:     	int3
18000884e:     	int3
18000884f:     	int3

0000000180008850 <numba_list_iter>:
180008850:     	movq	%rdx, (%rcx)
180008853:     	movq	(%rdx), %rax
180008856:     	movq	%rax, 0x8(%rcx)
18000885a:     	movq	$0x0, 0x10(%rcx)
180008862:     	retq
180008863:     	int3
180008864:     	int3
180008865:     	int3
180008866:     	int3
180008867:     	int3
180008868:     	int3
180008869:     	int3
18000886a:     	int3
18000886b:     	int3
18000886c:     	int3
18000886d:     	int3
18000886e:     	int3
18000886f:     	int3

0000000180008870 <numba_list_iter_next>:
180008870:     	movq	(%rcx), %r8
180008873:     	movq	(%r8), %r9
180008876:     	cmpq	0x8(%rcx), %r9
18000887a:     	je	0x180008882 <numba_list_iter_next+0x12>
18000887c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180008881:     	retq
180008882:     	movq	0x10(%rcx), %rax
180008886:     	cmpq	%r9, %rax
180008889:     	jge	0x18000889e <numba_list_iter_next+0x2e>
18000888b:     	imulq	0x8(%r8), %rax
180008890:     	addq	0x30(%r8), %rax
180008894:     	movq	%rax, (%rdx)
180008897:     	incq	0x10(%rcx)
18000889b:     	xorl	%eax, %eax
18000889d:     	retq
18000889e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
1800088a3:     	retq
1800088a4:     	int3
1800088a5:     	int3
1800088a6:     	int3
1800088a7:     	int3
1800088a8:     	int3
1800088a9:     	int3
1800088aa:     	int3
1800088ab:     	int3
1800088ac:     	int3
1800088ad:     	int3
1800088ae:     	int3
1800088af:     	int3
1800088b0:     	pushq	%rbx
1800088b2:     	subq	$0x20, %rsp
1800088b6:     	movq	%rcx, %rbx
1800088b9:     	addq	$0x30, %rcx
1800088bd:     	callq	*0x93a5(%rip)           # 0x180011c68
1800088c3:     	cmpb	$0x0, 0x9376(%rip)      # 0x180011c40
1800088ca:     	je	0x1800088d4 <numba_list_iter_next+0x64>
1800088cc:     	lock
1800088cd:     	incq	0x9374(%rip)            # 0x180011c48
1800088d4:     	testq	%rax, %rax
1800088d7:     	je	0x180008918 <numba_list_iter_next+0xa8>
1800088d9:     	leaq	0x30(%rax), %rdx
1800088dd:     	testq	%rdx, %rdx
1800088e0:     	je	0x180008918 <numba_list_iter_next+0xa8>
1800088e2:     	xorl	%r8d, %r8d
1800088e5:     	movl	$0x1, %ecx
1800088ea:     	xchgq	%rcx, (%rax)
1800088ed:     	movq	%r8, 0x8(%rax)
1800088f1:     	movq	%r8, 0x10(%rax)
1800088f5:     	movq	%rdx, 0x18(%rax)
1800088f9:     	movq	%rbx, 0x20(%rax)
1800088fd:     	movq	%r8, 0x28(%rax)
180008901:     	cmpb	%r8b, 0x9338(%rip)      # 0x180011c40
180008908:     	je	0x18000891a <numba_list_iter_next+0xaa>
18000890a:     	lock
18000890b:     	incq	0x9346(%rip)            # 0x180011c58
180008912:     	addq	$0x20, %rsp
180008916:     	popq	%rbx
180008917:     	retq
180008918:     	xorl	%eax, %eax
18000891a:     	addq	$0x20, %rsp
18000891e:     	popq	%rbx
18000891f:     	retq
180008920:     	movq	%rbx, 0x8(%rsp)
180008925:     	pushq	%rdi
180008926:     	subq	$0x20, %rsp
18000892a:     	movq	%rcx, %rdi
18000892d:     	movq	%rdx, %rbx
180008930:     	addq	$0x30, %rcx
180008934:     	testq	%rdx, %rdx
180008937:     	je	0x180008941 <numba_list_iter_next+0xd1>
180008939:     	movq	0x18(%rdx), %rdx
18000893d:     	callq	*(%rbx)
18000893f:     	jmp	0x180008947 <numba_list_iter_next+0xd7>
180008941:     	callq	*0x9321(%rip)           # 0x180011c68
180008947:     	cmpb	$0x0, 0x92f2(%rip)      # 0x180011c40
18000894e:     	movq	%rax, %r8
180008951:     	je	0x18000895b <numba_list_iter_next+0xeb>
180008953:     	lock
180008954:     	incq	0x92ed(%rip)            # 0x180011c48
18000895b:     	xorl	%edx, %edx
18000895d:     	leaq	0x30(%r8), %rax
180008961:     	testq	%r8, %r8
180008964:     	movl	%edx, %ecx
180008966:     	cmovneq	%rax, %rcx
18000896a:     	testq	%rcx, %rcx
18000896d:     	jne	0x18000897c <numba_list_iter_next+0x10c>
18000896f:     	xorl	%eax, %eax
180008971:     	movq	0x30(%rsp), %rbx
180008976:     	addq	$0x20, %rsp
18000897a:     	popq	%rdi
18000897b:     	retq
18000897c:     	movl	$0x1, %eax
180008981:     	xchgq	%rax, (%r8)
180008984:     	movq	%rdx, 0x8(%r8)
180008988:     	movq	%rdx, 0x10(%r8)
18000898c:     	movq	%rcx, 0x18(%r8)
180008990:     	movq	%rdi, 0x20(%r8)
180008994:     	movq	%rbx, 0x28(%r8)
180008998:     	cmpb	%dl, 0x92a2(%rip)       # 0x180011c40
18000899e:     	je	0x1800089a8 <numba_list_iter_next+0x138>
1800089a0:     	lock
1800089a1:     	incq	0x92b0(%rip)            # 0x180011c58
1800089a8:     	movq	0x30(%rsp), %rbx
1800089ad:     	movq	%r8, %rax
1800089b0:     	addq	$0x20, %rsp
1800089b4:     	popq	%rdi
1800089b5:     	retq
1800089b6:     	int3
1800089b7:     	int3
1800089b8:     	int3
1800089b9:     	int3
1800089ba:     	int3
1800089bb:     	int3
1800089bc:     	int3
1800089bd:     	int3
1800089be:     	int3
1800089bf:     	int3
1800089c0:     	lock
1800089c1:     	incq	(%rcx)
1800089c4:     	retq
1800089c5:     	int3
1800089c6:     	int3
1800089c7:     	int3
1800089c8:     	int3
1800089c9:     	int3
1800089ca:     	int3
1800089cb:     	int3
1800089cc:     	int3
1800089cd:     	int3
1800089ce:     	int3
1800089cf:     	int3
1800089d0:     	pushq	%rbx
1800089d2:     	subq	$0x20, %rsp
1800089d6:     	movq	0x8(%rcx), %rax
1800089da:     	movq	%rcx, %rbx
1800089dd:     	testq	%rax, %rax
1800089e0:     	je	0x1800089f9 <numba_list_iter_next+0x189>
1800089e2:     	cmpl	$0x0, 0x924f(%rip)      # 0x180011c38
1800089e9:     	jne	0x1800089f9 <numba_list_iter_next+0x189>
1800089eb:     	movq	0x10(%rcx), %r8
1800089ef:     	movq	0x20(%rcx), %rdx
1800089f3:     	movq	0x18(%rcx), %rcx
1800089f7:     	callq	*%rax
1800089f9:     	movq	0x28(%rbx), %rax
1800089fd:     	movq	%rbx, %rcx
180008a00:     	testq	%rax, %rax
180008a03:     	je	0x180008a0e <numba_list_iter_next+0x19e>
180008a05:     	movq	0x18(%rax), %rdx
180008a09:     	callq	*0x10(%rax)
180008a0c:     	jmp	0x180008a14 <numba_list_iter_next+0x1a4>
180008a0e:     	callq	*0x9264(%rip)           # 0x180011c78
180008a14:     	cmpb	$0x0, 0x9225(%rip)      # 0x180011c40
180008a1b:     	je	0x180008a39 <numba_list_iter_next+0x1c9>
180008a1d:     	leaq	0x922c(%rip), %rax      # 0x180011c50
180008a24:     	lock
180008a25:     	incq	(%rax)
180008a28:     	cmpb	$0x0, 0x9211(%rip)      # 0x180011c40
180008a2f:     	je	0x180008a39 <numba_list_iter_next+0x1c9>
180008a31:     	lock
180008a32:     	incq	0x9227(%rip)            # 0x180011c60
180008a39:     	addq	$0x20, %rsp
180008a3d:     	popq	%rbx
180008a3e:     	retq
180008a3f:     	int3
180008a40:     	pushq	%rbx
180008a42:     	subq	$0x20, %rsp
180008a46:     	movq	%rcx, %rbx
180008a49:     	movq	$-0x1, %rax
180008a50:     	lock
180008a51:     	xaddq	%rax, (%rcx)
180008a55:     	cmpq	$0x1, %rax
180008a59:     	jne	0x180008abb <numba_list_iter_next+0x24b>
180008a5b:     	movq	0x8(%rcx), %rax
180008a5f:     	testq	%rax, %rax
180008a62:     	je	0x180008a7b <numba_list_iter_next+0x20b>
180008a64:     	cmpl	$0x0, 0x91cd(%rip)      # 0x180011c38
180008a6b:     	jne	0x180008a7b <numba_list_iter_next+0x20b>
180008a6d:     	movq	0x10(%rcx), %r8
180008a71:     	movq	0x20(%rcx), %rdx
180008a75:     	movq	0x18(%rcx), %rcx
180008a79:     	callq	*%rax
180008a7b:     	movq	0x28(%rbx), %rax
180008a7f:     	movq	%rbx, %rcx
180008a82:     	testq	%rax, %rax
180008a85:     	je	0x180008a90 <numba_list_iter_next+0x220>
180008a87:     	movq	0x18(%rax), %rdx
180008a8b:     	callq	*0x10(%rax)
180008a8e:     	jmp	0x180008a96 <numba_list_iter_next+0x226>
180008a90:     	callq	*0x91e2(%rip)           # 0x180011c78
180008a96:     	cmpb	$0x0, 0x91a3(%rip)      # 0x180011c40
180008a9d:     	je	0x180008abb <numba_list_iter_next+0x24b>
180008a9f:     	leaq	0x91aa(%rip), %rax      # 0x180011c50
180008aa6:     	lock
180008aa7:     	incq	(%rax)
180008aaa:     	cmpb	$0x0, 0x918f(%rip)      # 0x180011c40
180008ab1:     	je	0x180008abb <numba_list_iter_next+0x24b>
180008ab3:     	lock
180008ab4:     	incq	0x91a5(%rip)            # 0x180011c60
180008abb:     	addq	$0x20, %rsp
180008abf:     	popq	%rbx
180008ac0:     	retq
180008ac1:     	int3
180008ac2:     	int3
180008ac3:     	int3
180008ac4:     	int3
180008ac5:     	int3
180008ac6:     	int3
180008ac7:     	int3
180008ac8:     	int3
180008ac9:     	int3
180008aca:     	int3
180008acb:     	int3
180008acc:     	int3
180008acd:     	int3
180008ace:     	int3
180008acf:     	int3
180008ad0:     	movq	0x18(%rcx), %rax
180008ad4:     	retq
180008ad5:     	int3
180008ad6:     	int3
180008ad7:     	int3
180008ad8:     	int3
180008ad9:     	int3
180008ada:     	int3
180008adb:     	int3
180008adc:     	int3
180008add:     	int3
180008ade:     	int3
180008adf:     	int3
180008ae0:     	subq	$0x28, %rsp
180008ae4:     	callq	*0x918e(%rip)           # 0x180011c78
180008aea:     	cmpb	$0x0, 0x914f(%rip)      # 0x180011c40
180008af1:     	je	0x180008afb <numba_list_iter_next+0x28b>
180008af3:     	lock
180008af4:     	incq	0x9155(%rip)            # 0x180011c50
180008afb:     	addq	$0x28, %rsp
180008aff:     	retq
180008b00:     	jmpq	*%r8
180008b03:     	int3
180008b04:     	int3
180008b05:     	int3
180008b06:     	int3
180008b07:     	int3
180008b08:     	int3
180008b09:     	int3
180008b0a:     	int3
180008b0b:     	int3
180008b0c:     	int3
180008b0d:     	int3
180008b0e:     	int3
180008b0f:     	int3
180008b10:     	movq	%rbx, 0x8(%rsp)
180008b15:     	pushq	%rdi
180008b16:     	subq	$0x20, %rsp
180008b1a:     	movq	%rcx, %rdi
180008b1d:     	movq	%rdx, %rbx
180008b20:     	movl	$0x30, %ecx
180008b25:     	callq	*0x913d(%rip)           # 0x180011c68
180008b2b:     	cmpb	$0x0, 0x910e(%rip)      # 0x180011c40
180008b32:     	je	0x180008b3c <numba_list_iter_next+0x2cc>
180008b34:     	lock
180008b35:     	incq	0x910c(%rip)            # 0x180011c48
180008b3c:     	testq	%rax, %rax
180008b3f:     	je	0x180008b76 <numba_list_iter_next+0x306>
180008b41:     	leaq	-0x48(%rip), %rcx       # 0x180008b00 <numba_list_iter_next+0x290>
180008b48:     	movl	$0x1, %edx
180008b4d:     	xchgq	%rdx, (%rax)
180008b50:     	movq	%rcx, 0x8(%rax)
180008b54:     	xorl	%ecx, %ecx
180008b56:     	movq	%rcx, 0x20(%rax)
180008b5a:     	movq	%rcx, 0x28(%rax)
180008b5e:     	movq	%rbx, 0x10(%rax)
180008b62:     	movq	%rdi, 0x18(%rax)
180008b66:     	cmpb	%cl, 0x90d4(%rip)       # 0x180011c40
180008b6c:     	je	0x180008b76 <numba_list_iter_next+0x306>
180008b6e:     	lock
180008b6f:     	incq	0x90e2(%rip)            # 0x180011c58
180008b76:     	movq	0x30(%rsp), %rbx
180008b7b:     	addq	$0x20, %rsp
180008b7f:     	popq	%rdi
180008b80:     	retq
180008b81:     	jmpq	*0x1789(%rip)           # 0x18000a310
180008b87:     	jmpq	*0x1773(%rip)           # 0x18000a300
180008b8d:     	jmpq	*0x1765(%rip)           # 0x18000a2f8
180008b93:     	jmpq	*0x1757(%rip)           # 0x18000a2f0
180008b99:     	jmpq	*0x1749(%rip)           # 0x18000a2e8
180008b9f:     	jmpq	*0x173b(%rip)           # 0x18000a2e0
180008ba5:     	jmpq	*0x172d(%rip)           # 0x18000a2d8
180008bab:     	jmpq	*0x1717(%rip)           # 0x18000a2c8
180008bb1:     	jmpq	*0x1709(%rip)           # 0x18000a2c0
180008bb7:     	jmpq	*0x16fb(%rip)           # 0x18000a2b8
180008bbd:     	jmpq	*0x16e5(%rip)           # 0x18000a2a8
180008bc3:     	jmpq	*0x16bf(%rip)           # 0x18000a288
180008bc9:     	jmpq	*0x16b1(%rip)           # 0x18000a280
180008bcf:     	jmpq	*0x16a3(%rip)           # 0x18000a278
180008bd5:     	jmpq	*0x1695(%rip)           # 0x18000a270
180008bdb:     	jmpq	*0x164f(%rip)           # 0x18000a230
180008be1:     	int3
180008be2:     	int3
180008be3:     	int3
180008be4:     	int3
180008be5:     	int3
180008be6:     	int3
180008be7:     	int3
180008be8:     	int3
180008be9:     	int3
180008bea:     	int3
180008beb:     	int3
180008bec:     	int3
180008bed:     	int3
180008bee:     	int3
180008bef:     	int3
180008bf0:     	int3
180008bf1:     	int3
180008bf2:     	int3
180008bf3:     	int3
180008bf4:     	int3
180008bf5:     	int3
180008bf6:     	nopw	(%rax,%rax)
180008c00:     	cmpq	0x84f9(%rip), %rcx      # 0x180011100
180008c07:     	jne	0x180008c19 <numba_list_iter_next+0x3a9>
180008c09:     	rolq	$0x10, %rcx
180008c0d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180008c12:     	jne	0x180008c15 <numba_list_iter_next+0x3a5>
180008c14:     	retq
180008c15:     	rorq	$0x10, %rcx
180008c19:     	jmp	0x180008f74 <numba_list_iter_next+0x704>
180008c1e:     	int3
180008c1f:     	int3
180008c20:     	subq	$0x28, %rsp
180008c24:     	testl	%edx, %edx
180008c26:     	je	0x180008c61 <numba_list_iter_next+0x3f1>
180008c28:     	subl	$0x1, %edx
180008c2b:     	je	0x180008c55 <numba_list_iter_next+0x3e5>
180008c2d:     	subl	$0x1, %edx
180008c30:     	je	0x180008c48 <numba_list_iter_next+0x3d8>
180008c32:     	cmpl	$0x1, %edx
180008c35:     	je	0x180008c41 <numba_list_iter_next+0x3d1>
180008c37:     	movl	$0x1, %eax
180008c3c:     	addq	$0x28, %rsp
180008c40:     	retq
180008c41:     	callq	0x180009140 <numba_list_iter_next+0x8d0>
180008c46:     	jmp	0x180008c4d <numba_list_iter_next+0x3dd>
180008c48:     	callq	0x180009118 <numba_list_iter_next+0x8a8>
180008c4d:     	movzbl	%al, %eax
180008c50:     	addq	$0x28, %rsp
180008c54:     	retq
180008c55:     	movq	%r8, %rdx
180008c58:     	addq	$0x28, %rsp
180008c5c:     	jmp	0x180008c70 <numba_list_iter_next+0x400>
180008c61:     	testq	%r8, %r8
180008c64:     	setne	%cl
180008c67:     	addq	$0x28, %rsp
180008c6b:     	jmp	0x180008d88 <numba_list_iter_next+0x518>
180008c70:     	movq	%rbx, 0x8(%rsp)
180008c75:     	movq	%rsi, 0x10(%rsp)
180008c7a:     	movq	%rdi, 0x20(%rsp)
180008c7f:     	pushq	%r14
180008c81:     	subq	$0x20, %rsp
180008c85:     	movq	%rdx, %rsi
180008c88:     	movq	%rcx, %r14
180008c8b:     	xorl	%ecx, %ecx
180008c8d:     	callq	0x1800091fc <numba_list_iter_next+0x98c>
180008c92:     	testb	%al, %al
180008c94:     	je	0x180008d62 <numba_list_iter_next+0x4f2>
180008c9a:     	callq	0x180009090 <numba_list_iter_next+0x820>
180008c9f:     	movb	%al, %bl
180008ca1:     	movb	%al, 0x40(%rsp)
180008ca5:     	movb	$0x1, %dil
180008ca8:     	cmpl	$0x0, 0x8d59(%rip)      # 0x180011a08
180008caf:     	jne	0x180008d7a <numba_list_iter_next+0x50a>
180008cb5:     	movl	$0x1, 0x8d49(%rip)      # 0x180011a08
180008cbf:     	callq	0x180009100 <numba_list_iter_next+0x890>
180008cc4:     	testb	%al, %al
180008cc6:     	je	0x180008d17 <numba_list_iter_next+0x4a7>
180008cc8:     	callq	0x1800093bc <numba_list_iter_next+0xb4c>
180008ccd:     	callq	0x180009050 <numba_list_iter_next+0x7e0>
180008cd2:     	callq	0x180009074 <numba_list_iter_next+0x804>
180008cd7:     	leaq	0x1692(%rip), %rdx      # 0x18000a370
180008cde:     	leaq	0x1683(%rip), %rcx      # 0x18000a368
180008ce5:     	callq	0x180009702 <numba_list_iter_next+0xe92>
180008cea:     	testl	%eax, %eax
180008cec:     	jne	0x180008d17 <numba_list_iter_next+0x4a7>
180008cee:     	callq	0x1800090cc <numba_list_iter_next+0x85c>
180008cf3:     	testb	%al, %al
180008cf5:     	je	0x180008d17 <numba_list_iter_next+0x4a7>
180008cf7:     	leaq	0x1662(%rip), %rdx      # 0x18000a360
180008cfe:     	leaq	0x1653(%rip), %rcx      # 0x18000a358
180008d05:     	callq	0x1800096fc <numba_list_iter_next+0xe8c>
180008d0a:     	movl	$0x2, 0x8cf4(%rip)      # 0x180011a08
180008d14:     	xorb	%dil, %dil
180008d17:     	movb	%bl, %cl
180008d19:     	callq	0x18000935c <numba_list_iter_next+0xaec>
180008d1e:     	testb	%dil, %dil
180008d21:     	jne	0x180008d62 <numba_list_iter_next+0x4f2>
180008d23:     	callq	0x1800093ac <numba_list_iter_next+0xb3c>
180008d28:     	movq	%rax, %rbx
180008d2b:     	cmpq	$0x0, (%rax)
180008d2f:     	je	0x180008d55 <numba_list_iter_next+0x4e5>
180008d31:     	movq	%rax, %rcx
180008d34:     	callq	0x1800092c4 <numba_list_iter_next+0xa54>
180008d39:     	testb	%al, %al
180008d3b:     	je	0x180008d55 <numba_list_iter_next+0x4e5>
180008d3d:     	movq	%rsi, %r8
180008d40:     	movl	$0x2, %edx
180008d45:     	movq	%r14, %rcx
180008d48:     	movq	(%rbx), %rax
180008d4b:     	movq	0x15de(%rip), %r9       # 0x18000a330
180008d52:     	callq	*%r9
180008d55:     	incl	0x8c85(%rip)            # 0x1800119e0
180008d5b:     	movl	$0x1, %eax
180008d60:     	jmp	0x180008d64 <numba_list_iter_next+0x4f4>
180008d62:     	xorl	%eax, %eax
180008d64:     	movq	0x30(%rsp), %rbx
180008d69:     	movq	0x38(%rsp), %rsi
180008d6e:     	movq	0x48(%rsp), %rdi
180008d73:     	addq	$0x20, %rsp
180008d77:     	popq	%r14
180008d79:     	retq
180008d7a:     	movl	$0x7, %ecx
180008d7f:     	callq	0x1800093b4 <numba_list_iter_next+0xb44>
180008d84:     	nop
180008d85:     	int3
180008d86:     	int3
180008d87:     	int3
180008d88:     	movq	%rbx, 0x8(%rsp)
180008d8d:     	pushq	%rdi
180008d8e:     	subq	$0x30, %rsp
180008d92:     	movb	%cl, %dil
180008d95:     	movl	0x8c45(%rip), %eax      # 0x1800119e0
180008d9b:     	testl	%eax, %eax
180008d9d:     	jg	0x180008dac <numba_list_iter_next+0x53c>
180008d9f:     	xorl	%eax, %eax
180008da1:     	movq	0x40(%rsp), %rbx
180008da6:     	addq	$0x30, %rsp
180008daa:     	popq	%rdi
180008dab:     	retq
180008dac:     	decl	%eax
180008dae:     	movl	%eax, 0x8c2c(%rip)      # 0x1800119e0
180008db4:     	callq	0x180009090 <numba_list_iter_next+0x820>
180008db9:     	movb	%al, %bl
180008dbb:     	movb	%al, 0x20(%rsp)
180008dbf:     	cmpl	$0x2, 0x8c42(%rip)      # 0x180011a08
180008dc6:     	jne	0x180008dfe <numba_list_iter_next+0x58e>
180008dc8:     	callq	0x1800091b8 <numba_list_iter_next+0x948>
180008dcd:     	callq	0x180009060 <numba_list_iter_next+0x7f0>
180008dd2:     	callq	0x1800093f8 <numba_list_iter_next+0xb88>
180008dd7:     	movl	$0x0, 0x8c27(%rip)      # 0x180011a08
180008de1:     	movb	%bl, %cl
180008de3:     	callq	0x18000935c <numba_list_iter_next+0xaec>
180008de8:     	xorl	%edx, %edx
180008dea:     	movb	%dil, %cl
180008ded:     	callq	0x180009380 <numba_list_iter_next+0xb10>
180008df2:     	movzbl	%al, %ebx
180008df5:     	callq	0x1800091e8 <numba_list_iter_next+0x978>
180008dfa:     	movl	%ebx, %eax
180008dfc:     	jmp	0x180008da1 <numba_list_iter_next+0x531>
180008dfe:     	movl	$0x7, %ecx
180008e03:     	callq	0x1800093b4 <numba_list_iter_next+0xb44>
180008e08:     	nop
180008e09:     	nop
180008e0a:     	int3
180008e0b:     	int3
180008e0c:     	movq	%rsp, %rax
180008e0f:     	movq	%rbx, 0x20(%rax)
180008e13:     	movq	%r8, 0x18(%rax)
180008e17:     	movl	%edx, 0x10(%rax)
180008e1a:     	movq	%rcx, 0x8(%rax)
180008e1e:     	pushq	%rsi
180008e1f:     	pushq	%rdi
180008e20:     	pushq	%r14
180008e22:     	subq	$0x40, %rsp
180008e26:     	movq	%r8, %rsi
180008e29:     	movl	%edx, %edi
180008e2b:     	movq	%rcx, %r14
180008e2e:     	testl	%edx, %edx
180008e30:     	jne	0x180008e41 <numba_list_iter_next+0x5d1>
180008e32:     	cmpl	%edx, 0x8ba8(%rip)      # 0x1800119e0
180008e38:     	jg	0x180008e41 <numba_list_iter_next+0x5d1>
180008e3a:     	xorl	%eax, %eax
180008e3c:     	jmp	0x180008f26 <numba_list_iter_next+0x6b6>
180008e41:     	leal	-0x1(%rdx), %eax
180008e44:     	cmpl	$0x1, %eax
180008e47:     	ja	0x180008e89 <numba_list_iter_next+0x619>
180008e49:     	movq	0x1f70(%rip), %rax      # 0x18000adc0
180008e50:     	testq	%rax, %rax
180008e53:     	jne	0x180008e5a <numba_list_iter_next+0x5ea>
180008e55:     	leal	0x1(%rax), %ebx
180008e58:     	jmp	0x180008e62 <numba_list_iter_next+0x5f2>
180008e5a:     	callq	*0x14d0(%rip)           # 0x18000a330
180008e60:     	movl	%eax, %ebx
180008e62:     	movl	%ebx, 0x30(%rsp)
180008e66:     	testl	%ebx, %ebx
180008e68:     	je	0x180008f1c <numba_list_iter_next+0x6ac>
180008e6e:     	movq	%rsi, %r8
180008e71:     	movl	%edi, %edx
180008e73:     	movq	%r14, %rcx
180008e76:     	callq	0x180008c20 <numba_list_iter_next+0x3b0>
180008e7b:     	movl	%eax, %ebx
180008e7d:     	movl	%eax, 0x30(%rsp)
180008e81:     	testl	%eax, %eax
180008e83:     	je	0x180008f1c <numba_list_iter_next+0x6ac>
180008e89:     	movq	%rsi, %r8
180008e8c:     	movl	%edi, %edx
180008e8e:     	movq	%r14, %rcx
180008e91:     	callq	0x18000902c <numba_list_iter_next+0x7bc>
180008e96:     	movl	%eax, %ebx
180008e98:     	movl	%eax, 0x30(%rsp)
180008e9c:     	cmpl	$0x1, %edi
180008e9f:     	jne	0x180008ed7 <numba_list_iter_next+0x667>
180008ea1:     	testl	%eax, %eax
180008ea3:     	jne	0x180008ed7 <numba_list_iter_next+0x667>
180008ea5:     	movq	%rsi, %r8
180008ea8:     	xorl	%edx, %edx
180008eaa:     	movq	%r14, %rcx
180008ead:     	callq	0x18000902c <numba_list_iter_next+0x7bc>
180008eb2:     	testq	%rsi, %rsi
180008eb5:     	setne	%cl
180008eb8:     	callq	0x180008d88 <numba_list_iter_next+0x518>
180008ebd:     	movq	0x1efc(%rip), %rax      # 0x18000adc0
180008ec4:     	testq	%rax, %rax
180008ec7:     	je	0x180008ed7 <numba_list_iter_next+0x667>
180008ec9:     	movq	%rsi, %r8
180008ecc:     	xorl	%edx, %edx
180008ece:     	movq	%r14, %rcx
180008ed1:     	callq	*0x1459(%rip)           # 0x18000a330
180008ed7:     	testl	%edi, %edi
180008ed9:     	je	0x180008ee0 <numba_list_iter_next+0x670>
180008edb:     	cmpl	$0x3, %edi
180008ede:     	jne	0x180008f1c <numba_list_iter_next+0x6ac>
180008ee0:     	movq	%rsi, %r8
180008ee3:     	movl	%edi, %edx
180008ee5:     	movq	%r14, %rcx
180008ee8:     	callq	0x180008c20 <numba_list_iter_next+0x3b0>
180008eed:     	movl	%eax, %ebx
180008eef:     	movl	%eax, 0x30(%rsp)
180008ef3:     	testl	%eax, %eax
180008ef5:     	je	0x180008f1c <numba_list_iter_next+0x6ac>
180008ef7:     	movq	0x1ec2(%rip), %rax      # 0x18000adc0
180008efe:     	testq	%rax, %rax
180008f01:     	jne	0x180008f08 <numba_list_iter_next+0x698>
180008f03:     	leal	0x1(%rax), %ebx
180008f06:     	jmp	0x180008f18 <numba_list_iter_next+0x6a8>
180008f08:     	movq	%rsi, %r8
180008f0b:     	movl	%edi, %edx
180008f0d:     	movq	%r14, %rcx
180008f10:     	callq	*0x141a(%rip)           # 0x18000a330
180008f16:     	movl	%eax, %ebx
180008f18:     	movl	%ebx, 0x30(%rsp)
180008f1c:     	jmp	0x180008f24 <numba_list_iter_next+0x6b4>
180008f1e:     	xorl	%ebx, %ebx
180008f20:     	movl	%ebx, 0x30(%rsp)
180008f24:     	movl	%ebx, %eax
180008f26:     	movq	0x78(%rsp), %rbx
180008f2b:     	addq	$0x40, %rsp
180008f2f:     	popq	%r14
180008f31:     	popq	%rdi
180008f32:     	popq	%rsi
180008f33:     	retq
180008f34:     	movq	%rbx, 0x8(%rsp)
180008f39:     	movq	%rsi, 0x10(%rsp)
180008f3e:     	pushq	%rdi
180008f3f:     	subq	$0x20, %rsp
180008f43:     	movq	%r8, %rdi
180008f46:     	movl	%edx, %ebx
180008f48:     	movq	%rcx, %rsi
180008f4b:     	cmpl	$0x1, %edx
180008f4e:     	jne	0x180008f55 <numba_list_iter_next+0x6e5>
180008f50:     	callq	0x180008f7c <numba_list_iter_next+0x70c>
180008f55:     	movq	%rdi, %r8
180008f58:     	movl	%ebx, %edx
180008f5a:     	movq	%rsi, %rcx
180008f5d:     	movq	0x30(%rsp), %rbx
180008f62:     	movq	0x38(%rsp), %rsi
180008f67:     	addq	$0x20, %rsp
180008f6b:     	popq	%rdi
180008f6c:     	jmp	0x180008e0c <numba_list_iter_next+0x59c>
180008f71:     	int3
180008f72:     	int3
180008f73:     	int3
180008f74:     	movl	$0x2, %ecx
180008f79:     	int	$0x29
180008f7b:     	retq
180008f7c:     	movq	%rbx, 0x18(%rsp)
180008f81:     	pushq	%rbp
180008f82:     	movq	%rsp, %rbp
180008f85:     	subq	$0x30, %rsp
180008f89:     	movq	0x8170(%rip), %rax      # 0x180011100
180008f90:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
180008f9a:     	cmpq	%rbx, %rax
180008f9d:     	jne	0x180009016 <numba_list_iter_next+0x7a6>
180008f9f:     	leaq	0x10(%rbp), %rcx
180008fa3:     	movq	$0x0, 0x10(%rbp)
180008fab:     	callq	*0x106f(%rip)           # 0x18000a020
180008fb1:     	movq	0x10(%rbp), %rax
180008fb5:     	movq	%rax, -0x10(%rbp)
180008fb9:     	callq	*0x1059(%rip)           # 0x18000a018
180008fbf:     	movl	%eax, %eax
180008fc1:     	xorq	%rax, -0x10(%rbp)
180008fc5:     	callq	*0x1045(%rip)           # 0x18000a010
180008fcb:     	movl	%eax, %eax
180008fcd:     	leaq	0x18(%rbp), %rcx
180008fd1:     	xorq	%rax, -0x10(%rbp)
180008fd5:     	callq	*0x1025(%rip)           # 0x18000a000
180008fdb:     	movl	0x18(%rbp), %eax
180008fde:     	leaq	-0x10(%rbp), %rcx
180008fe2:     	shlq	$0x20, %rax
180008fe6:     	xorq	0x18(%rbp), %rax
180008fea:     	xorq	-0x10(%rbp), %rax
180008fee:     	xorq	%rcx, %rax
180008ff1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
180008ffb:     	andq	%rcx, %rax
180008ffe:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180009008:     	cmpq	%rbx, %rax
18000900b:     	cmoveq	%rcx, %rax
18000900f:     	movq	%rax, 0x80ea(%rip)      # 0x180011100
180009016:     	movq	0x50(%rsp), %rbx
18000901b:     	notq	%rax
18000901e:     	movq	%rax, 0x811b(%rip)      # 0x180011140
180009025:     	addq	$0x30, %rsp
180009029:     	popq	%rbp
18000902a:     	retq
18000902b:     	int3
18000902c:     	subq	$0x28, %rsp
180009030:     	cmpl	$0x1, %edx
180009033:     	jne	0x180009045 <numba_list_iter_next+0x7d5>
180009035:     	cmpq	$0x0, 0x1d83(%rip)      # 0x18000adc0
18000903d:     	jne	0x180009045 <numba_list_iter_next+0x7d5>
18000903f:     	callq	*0xfe3(%rip)            # 0x18000a028
180009045:     	movl	$0x1, %eax
18000904a:     	addq	$0x28, %rsp
18000904e:     	retq
18000904f:     	int3
180009050:     	leaq	0x8999(%rip), %rcx      # 0x1800119f0
180009057:     	jmpq	*0xfaa(%rip)            # 0x18000a008
18000905e:     	int3
18000905f:     	int3
180009060:     	leaq	0x8989(%rip), %rcx      # 0x1800119f0
180009067:     	jmp	0x1800096f6 <numba_list_iter_next+0xe86>
18000906c:     	leaq	0x898d(%rip), %rax      # 0x180011a00
180009073:     	retq
180009074:     	subq	$0x28, %rsp
180009078:     	callq	0x180008180 <PyInit_rcaotr_962a53ce990e9bd4541a3246+0x5c10>
18000907d:     	orq	$0x24, (%rax)
180009081:     	callq	0x18000906c <numba_list_iter_next+0x7fc>
180009086:     	orq	$0x2, (%rax)
18000908a:     	addq	$0x28, %rsp
18000908e:     	retq
18000908f:     	int3
180009090:     	subq	$0x28, %rsp
180009094:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
180009099:     	testl	%eax, %eax
18000909b:     	je	0x1800090be <numba_list_iter_next+0x84e>
18000909d:     	movq	%gs:0x30, %rax
1800090a6:     	movq	0x8(%rax), %rcx
1800090aa:     	jmp	0x1800090b1 <numba_list_iter_next+0x841>
1800090ac:     	cmpq	%rax, %rcx
1800090af:     	je	0x1800090c5 <numba_list_iter_next+0x855>
1800090b1:     	xorl	%eax, %eax
1800090b3:     	lock
1800090b4:     	cmpxchgq	%rcx, 0x8954(%rip)      # 0x180011a10
1800090bc:     	jne	0x1800090ac <numba_list_iter_next+0x83c>
1800090be:     	xorb	%al, %al
1800090c0:     	addq	$0x28, %rsp
1800090c4:     	retq
1800090c5:     	movb	$0x1, %al
1800090c7:     	jmp	0x1800090c0 <numba_list_iter_next+0x850>
1800090c9:     	int3
1800090ca:     	int3
1800090cb:     	int3
1800090cc:     	subq	$0x28, %rsp
1800090d0:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
1800090d5:     	testl	%eax, %eax
1800090d7:     	je	0x1800090e0 <numba_list_iter_next+0x870>
1800090d9:     	callq	0x180009438 <numba_list_iter_next+0xbc8>
1800090de:     	jmp	0x1800090f9 <numba_list_iter_next+0x889>
1800090e0:     	callq	0x1800096d4 <numba_list_iter_next+0xe64>
1800090e5:     	movl	%eax, %ecx
1800090e7:     	callq	0x18000970e <numba_list_iter_next+0xe9e>
1800090ec:     	testl	%eax, %eax
1800090ee:     	je	0x1800090f4 <numba_list_iter_next+0x884>
1800090f0:     	xorb	%al, %al
1800090f2:     	jmp	0x1800090fb <numba_list_iter_next+0x88b>
1800090f4:     	callq	0x180009714 <numba_list_iter_next+0xea4>
1800090f9:     	movb	$0x1, %al
1800090fb:     	addq	$0x28, %rsp
1800090ff:     	retq
180009100:     	subq	$0x28, %rsp
180009104:     	xorl	%ecx, %ecx
180009106:     	callq	0x180009238 <numba_list_iter_next+0x9c8>
18000910b:     	testb	%al, %al
18000910d:     	setne	%al
180009110:     	addq	$0x28, %rsp
180009114:     	retq
180009115:     	int3
180009116:     	int3
180009117:     	int3
180009118:     	subq	$0x28, %rsp
18000911c:     	callq	0x18000972c <numba_list_iter_next+0xebc>
180009121:     	testb	%al, %al
180009123:     	jne	0x180009129 <numba_list_iter_next+0x8b9>
180009125:     	xorb	%al, %al
180009127:     	jmp	0x18000913b <numba_list_iter_next+0x8cb>
180009129:     	callq	0x18000972c <numba_list_iter_next+0xebc>
18000912e:     	testb	%al, %al
180009130:     	jne	0x180009139 <numba_list_iter_next+0x8c9>
180009132:     	callq	0x18000972c <numba_list_iter_next+0xebc>
180009137:     	jmp	0x180009125 <numba_list_iter_next+0x8b5>
180009139:     	movb	$0x1, %al
18000913b:     	addq	$0x28, %rsp
18000913f:     	retq
180009140:     	subq	$0x28, %rsp
180009144:     	callq	0x18000972c <numba_list_iter_next+0xebc>
180009149:     	callq	0x18000972c <numba_list_iter_next+0xebc>
18000914e:     	movb	$0x1, %al
180009150:     	addq	$0x28, %rsp
180009154:     	retq
180009155:     	int3
180009156:     	int3
180009157:     	int3
180009158:     	movq	%rbx, 0x8(%rsp)
18000915d:     	movq	%rbp, 0x10(%rsp)
180009162:     	movq	%rsi, 0x18(%rsp)
180009167:     	pushq	%rdi
180009168:     	subq	$0x20, %rsp
18000916c:     	movq	%r9, %rdi
18000916f:     	movq	%r8, %rsi
180009172:     	movl	%edx, %ebx
180009174:     	movq	%rcx, %rbp
180009177:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
18000917c:     	testl	%eax, %eax
18000917e:     	jne	0x180009196 <numba_list_iter_next+0x926>
180009180:     	cmpl	$0x1, %ebx
180009183:     	jne	0x180009196 <numba_list_iter_next+0x926>
180009185:     	movq	%rsi, %r8
180009188:     	xorl	%edx, %edx
18000918a:     	movq	%rbp, %rcx
18000918d:     	movq	%rdi, %rax
180009190:     	callq	*0x119a(%rip)           # 0x18000a330
180009196:     	movq	0x58(%rsp), %rdx
18000919b:     	movl	0x50(%rsp), %ecx
18000919f:     	movq	0x30(%rsp), %rbx
1800091a4:     	movq	0x38(%rsp), %rbp
1800091a9:     	movq	0x40(%rsp), %rsi
1800091ae:     	addq	$0x20, %rsp
1800091b2:     	popq	%rdi
1800091b3:     	jmp	0x180009708 <numba_list_iter_next+0xe98>
1800091b8:     	subq	$0x28, %rsp
1800091bc:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
1800091c1:     	testl	%eax, %eax
1800091c3:     	je	0x1800091d5 <numba_list_iter_next+0x965>
1800091c5:     	leaq	0x8854(%rip), %rcx      # 0x180011a20
1800091cc:     	addq	$0x28, %rsp
1800091d0:     	jmp	0x180009720 <numba_list_iter_next+0xeb0>
1800091d5:     	callq	0x180009730 <numba_list_iter_next+0xec0>
1800091da:     	testl	%eax, %eax
1800091dc:     	jne	0x1800091e3 <numba_list_iter_next+0x973>
1800091de:     	callq	0x180009726 <numba_list_iter_next+0xeb6>
1800091e3:     	addq	$0x28, %rsp
1800091e7:     	retq
1800091e8:     	subq	$0x28, %rsp
1800091ec:     	xorl	%ecx, %ecx
1800091ee:     	callq	0x18000972c <numba_list_iter_next+0xebc>
1800091f3:     	addq	$0x28, %rsp
1800091f7:     	jmp	0x18000972c <numba_list_iter_next+0xebc>
1800091fc:     	subq	$0x28, %rsp
180009200:     	testl	%ecx, %ecx
180009202:     	jne	0x18000920b <numba_list_iter_next+0x99b>
180009204:     	movb	$0x1, 0x880d(%rip)      # 0x180011a18
18000920b:     	callq	0x180009438 <numba_list_iter_next+0xbc8>
180009210:     	callq	0x18000972c <numba_list_iter_next+0xebc>
180009215:     	testb	%al, %al
180009217:     	jne	0x18000921d <numba_list_iter_next+0x9ad>
180009219:     	xorb	%al, %al
18000921b:     	jmp	0x180009231 <numba_list_iter_next+0x9c1>
18000921d:     	callq	0x18000972c <numba_list_iter_next+0xebc>
180009222:     	testb	%al, %al
180009224:     	jne	0x18000922f <numba_list_iter_next+0x9bf>
180009226:     	xorl	%ecx, %ecx
180009228:     	callq	0x18000972c <numba_list_iter_next+0xebc>
18000922d:     	jmp	0x180009219 <numba_list_iter_next+0x9a9>
18000922f:     	movb	$0x1, %al
180009231:     	addq	$0x28, %rsp
180009235:     	retq
180009236:     	int3
180009237:     	int3
180009238:     	pushq	%rbx
18000923a:     	subq	$0x20, %rsp
18000923e:     	cmpb	$0x0, 0x87d4(%rip)      # 0x180011a19
180009245:     	movl	%ecx, %ebx
180009247:     	jne	0x1800092b0 <numba_list_iter_next+0xa40>
180009249:     	cmpl	$0x1, %ecx
18000924c:     	ja	0x1800092b8 <numba_list_iter_next+0xa48>
18000924e:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
180009253:     	testl	%eax, %eax
180009255:     	je	0x18000927f <numba_list_iter_next+0xa0f>
180009257:     	testl	%ebx, %ebx
180009259:     	jne	0x18000927f <numba_list_iter_next+0xa0f>
18000925b:     	leaq	0x87be(%rip), %rcx      # 0x180011a20
180009262:     	callq	0x18000971a <numba_list_iter_next+0xeaa>
180009267:     	testl	%eax, %eax
180009269:     	jne	0x18000927b <numba_list_iter_next+0xa0b>
18000926b:     	leaq	0x87c6(%rip), %rcx      # 0x180011a38
180009272:     	callq	0x18000971a <numba_list_iter_next+0xeaa>
180009277:     	testl	%eax, %eax
180009279:     	je	0x1800092a9 <numba_list_iter_next+0xa39>
18000927b:     	xorb	%al, %al
18000927d:     	jmp	0x1800092b2 <numba_list_iter_next+0xa42>
18000927f:     	movdqa	0x1b49(%rip), %xmm0     # 0x18000add0
180009287:     	orq	$-0x1, %rax
18000928b:     	movdqu	%xmm0, 0x878d(%rip)     # 0x180011a20
180009293:     	movq	%rax, 0x8796(%rip)      # 0x180011a30
18000929a:     	movdqu	%xmm0, 0x8796(%rip)     # 0x180011a38
1800092a2:     	movq	%rax, 0x879f(%rip)      # 0x180011a48
1800092a9:     	movb	$0x1, 0x8769(%rip)      # 0x180011a19
1800092b0:     	movb	$0x1, %al
1800092b2:     	addq	$0x20, %rsp
1800092b6:     	popq	%rbx
1800092b7:     	retq
1800092b8:     	movl	$0x5, %ecx
1800092bd:     	callq	0x1800093b4 <numba_list_iter_next+0xb44>
1800092c2:     	int3
1800092c3:     	int3
1800092c4:     	subq	$0x18, %rsp
1800092c8:     	movq	%rcx, %r8
1800092cb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
1800092d0:     	cmpw	%ax, -0x92d7(%rip)      # 0x180000000
1800092d7:     	jne	0x180009351 <numba_list_iter_next+0xae1>
1800092d9:     	movslq	-0x92a4(%rip), %rcx     # 0x18000003c
1800092e0:     	leaq	-0x92e7(%rip), %rdx     # 0x180000000
1800092e7:     	addq	%rdx, %rcx
1800092ea:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
1800092f0:     	jne	0x180009351 <numba_list_iter_next+0xae1>
1800092f2:     	movl	$0x20b, %eax            # imm = 0x20B
1800092f7:     	cmpw	%ax, 0x18(%rcx)
1800092fb:     	jne	0x180009351 <numba_list_iter_next+0xae1>
1800092fd:     	subq	%rdx, %r8
180009300:     	movzwl	0x14(%rcx), %edx
180009304:     	addq	$0x18, %rdx
180009308:     	addq	%rcx, %rdx
18000930b:     	movzwl	0x6(%rcx), %eax
18000930f:     	leaq	(%rax,%rax,4), %rcx
180009313:     	leaq	(%rdx,%rcx,8), %r9
180009317:     	movq	%rdx, (%rsp)
18000931b:     	cmpq	%r9, %rdx
18000931e:     	je	0x180009338 <numba_list_iter_next+0xac8>
180009320:     	movl	0xc(%rdx), %ecx
180009323:     	cmpq	%rcx, %r8
180009326:     	jb	0x180009332 <numba_list_iter_next+0xac2>
180009328:     	movl	0x8(%rdx), %eax
18000932b:     	addl	%ecx, %eax
18000932d:     	cmpq	%rax, %r8
180009330:     	jb	0x18000933a <numba_list_iter_next+0xaca>
180009332:     	addq	$0x28, %rdx
180009336:     	jmp	0x180009317 <numba_list_iter_next+0xaa7>
180009338:     	xorl	%edx, %edx
18000933a:     	testq	%rdx, %rdx
18000933d:     	jne	0x180009343 <numba_list_iter_next+0xad3>
18000933f:     	xorb	%al, %al
180009341:     	jmp	0x180009357 <numba_list_iter_next+0xae7>
180009343:     	cmpl	$0x0, 0x24(%rdx)
180009347:     	jge	0x18000934d <numba_list_iter_next+0xadd>
180009349:     	xorb	%al, %al
18000934b:     	jmp	0x180009357 <numba_list_iter_next+0xae7>
18000934d:     	movb	$0x1, %al
18000934f:     	jmp	0x180009357 <numba_list_iter_next+0xae7>
180009351:     	xorb	%al, %al
180009353:     	jmp	0x180009357 <numba_list_iter_next+0xae7>
180009355:     	xorb	%al, %al
180009357:     	addq	$0x18, %rsp
18000935b:     	retq
18000935c:     	pushq	%rbx
18000935e:     	subq	$0x20, %rsp
180009362:     	movb	%cl, %bl
180009364:     	callq	0x1800096dc <numba_list_iter_next+0xe6c>
180009369:     	xorl	%edx, %edx
18000936b:     	testl	%eax, %eax
18000936d:     	je	0x18000937a <numba_list_iter_next+0xb0a>
18000936f:     	testb	%bl, %bl
180009371:     	jne	0x18000937a <numba_list_iter_next+0xb0a>
180009373:     	xchgq	%rdx, 0x8696(%rip)      # 0x180011a10
18000937a:     	addq	$0x20, %rsp
18000937e:     	popq	%rbx
18000937f:     	retq
180009380:     	pushq	%rbx
180009382:     	subq	$0x20, %rsp
180009386:     	cmpb	$0x0, 0x868b(%rip)      # 0x180011a18
18000938d:     	movb	%cl, %bl
18000938f:     	je	0x180009395 <numba_list_iter_next+0xb25>
180009391:     	testb	%dl, %dl
180009393:     	jne	0x1800093a1 <numba_list_iter_next+0xb31>
180009395:     	callq	0x18000972c <numba_list_iter_next+0xebc>
18000939a:     	movb	%bl, %cl
18000939c:     	callq	0x18000972c <numba_list_iter_next+0xebc>
1800093a1:     	movb	$0x1, %al
1800093a3:     	addq	$0x20, %rsp
1800093a7:     	popq	%rbx
1800093a8:     	retq
1800093a9:     	int3
1800093aa:     	int3
1800093ab:     	int3
1800093ac:     	leaq	0x894d(%rip), %rax      # 0x180011d00
1800093b3:     	retq
1800093b4:     	movl	%ecx, %ecx
1800093b6:     	int	$0x29
1800093b8:     	retq
1800093b9:     	int3
1800093ba:     	int3
1800093bb:     	int3
1800093bc:     	movq	%rbx, 0x8(%rsp)
1800093c1:     	pushq	%rdi
1800093c2:     	subq	$0x20, %rsp
1800093c6:     	leaq	0x43fb(%rip), %rbx      # 0x18000d7c8
1800093cd:     	leaq	0x43f4(%rip), %rdi      # 0x18000d7c8
1800093d4:     	jmp	0x1800093e8 <numba_list_iter_next+0xb78>
1800093d6:     	movq	(%rbx), %rax
1800093d9:     	testq	%rax, %rax
1800093dc:     	je	0x1800093e4 <numba_list_iter_next+0xb74>
1800093de:     	callq	*0xf4c(%rip)            # 0x18000a330
1800093e4:     	addq	$0x8, %rbx
1800093e8:     	cmpq	%rdi, %rbx
1800093eb:     	jb	0x1800093d6 <numba_list_iter_next+0xb66>
1800093ed:     	movq	0x30(%rsp), %rbx
1800093f2:     	addq	$0x20, %rsp
1800093f6:     	popq	%rdi
1800093f7:     	retq
1800093f8:     	movq	%rbx, 0x8(%rsp)
1800093fd:     	pushq	%rdi
1800093fe:     	subq	$0x20, %rsp
180009402:     	leaq	0x43cf(%rip), %rbx      # 0x18000d7d8
180009409:     	leaq	0x43c8(%rip), %rdi      # 0x18000d7d8
180009410:     	jmp	0x180009424 <numba_list_iter_next+0xbb4>
180009412:     	movq	(%rbx), %rax
180009415:     	testq	%rax, %rax
180009418:     	je	0x180009420 <numba_list_iter_next+0xbb0>
18000941a:     	callq	*0xf10(%rip)            # 0x18000a330
180009420:     	addq	$0x8, %rbx
180009424:     	cmpq	%rdi, %rbx
180009427:     	jb	0x180009412 <numba_list_iter_next+0xba2>
180009429:     	movq	0x30(%rsp), %rbx
18000942e:     	addq	$0x20, %rsp
180009432:     	popq	%rdi
180009433:     	retq
180009434:     	retq	$0x0
180009437:     	int3
180009438:     	movq	%rbx, 0x10(%rsp)
18000943d:     	movq	%rbp, 0x18(%rsp)
180009442:     	movq	%rsi, 0x20(%rsp)
180009447:     	pushq	%rdi
180009448:     	subq	$0x10, %rsp
18000944c:     	xorl	%eax, %eax
18000944e:     	xorl	%ecx, %ecx
180009450:     	cpuid
180009452:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180009458:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000945e:     	orl	%ecx, %edx
180009460:     	movl	%eax, %ebp
180009462:     	movl	$0x1, %eax
180009467:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000946d:     	orl	%ebx, %edx
18000946f:     	leal	-0x1(%rax), %ecx
180009472:     	cpuid
180009474:     	movl	%ecx, %edi
180009476:     	jne	0x1800094d6 <numba_list_iter_next+0xc66>
180009478:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000947d:     	movq	$0x8000, 0x7cd0(%rip)   # imm = 0x8000
                                                # 0x180011158
180009488:     	movq	$-0x1, 0x7ccd(%rip)     # 0x180011160
180009493:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180009498:     	je	0x1800094c2 <numba_list_iter_next+0xc52>
18000949a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000949f:     	je	0x1800094c2 <numba_list_iter_next+0xc52>
1800094a1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800094a6:     	je	0x1800094c2 <numba_list_iter_next+0xc52>
1800094a8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800094ad:     	cmpl	$0x20, %eax
1800094b0:     	ja	0x1800094d6 <numba_list_iter_next+0xc66>
1800094b2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1800094bc:     	btq	%rax, %rcx
1800094c0:     	jae	0x1800094d6 <numba_list_iter_next+0xc66>
1800094c2:     	movl	0x858b(%rip), %r8d      # 0x180011a54
1800094c9:     	orl	$0x1, %r8d
1800094cd:     	movl	%r8d, 0x8580(%rip)      # 0x180011a54
1800094d4:     	jmp	0x1800094dd <numba_list_iter_next+0xc6d>
1800094d6:     	movl	0x8577(%rip), %r8d      # 0x180011a54
1800094dd:     	xorl	%r9d, %r9d
1800094e0:     	movl	%r9d, %r11d
1800094e3:     	cmpl	$0x7, %ebp
1800094e6:     	jl	0x18000952a <numba_list_iter_next+0xcba>
1800094e8:     	xorl	%ecx, %ecx
1800094ea:     	leal	0x7(%r9), %eax
1800094ee:     	cpuid
1800094f0:     	movl	%edx, %esi
1800094f2:     	movl	%ebx, %r10d
1800094f5:     	btl	$0x9, %ebx
1800094f9:     	jae	0x180009506 <numba_list_iter_next+0xc96>
1800094fb:     	orl	$0x2, %r8d
1800094ff:     	movl	%r8d, 0x854e(%rip)      # 0x180011a54
180009506:     	cmpl	$0x1, %eax
180009509:     	jl	0x180009518 <numba_list_iter_next+0xca8>
18000950b:     	movl	$0x7, %eax
180009510:     	leal	-0x6(%rax), %ecx
180009513:     	cpuid
180009515:     	movl	%edx, %r9d
180009518:     	movl	$0x24, %eax
18000951d:     	cmpl	%eax, %ebp
18000951f:     	jl	0x180009530 <numba_list_iter_next+0xcc0>
180009521:     	xorl	%ecx, %ecx
180009523:     	cpuid
180009525:     	movl	%ebx, %r11d
180009528:     	jmp	0x180009530 <numba_list_iter_next+0xcc0>
18000952a:     	movl	%r9d, %r10d
18000952d:     	movl	%r9d, %esi
180009530:     	movq	0x7c31(%rip), %rax      # 0x180011168
180009537:     	andq	$-0x2, %rax
18000953b:     	movl	$0x1, 0x7c0b(%rip)      # 0x180011150
180009545:     	movl	$0x2, 0x7c05(%rip)      # 0x180011154
18000954f:     	movq	%rax, 0x7c12(%rip)      # 0x180011168
180009556:     	btl	$0x14, %edi
18000955a:     	jae	0x18000957b <numba_list_iter_next+0xd0b>
18000955c:     	andq	$-0x11, %rax
180009560:     	movl	$0x2, 0x7be6(%rip)      # 0x180011150
18000956a:     	movq	%rax, 0x7bf7(%rip)      # 0x180011168
180009571:     	movl	$0x6, 0x7bd9(%rip)      # 0x180011154
18000957b:     	btl	$0x1b, %edi
18000957f:     	jae	0x1800096bc <numba_list_iter_next+0xe4c>
180009585:     	xorl	%ecx, %ecx
180009587:     	xgetbv
18000958a:     	shlq	$0x20, %rdx
18000958e:     	orq	%rax, %rdx
180009591:     	movq	%rdx, 0x20(%rsp)
180009596:     	btl	$0x1c, %edi
18000959a:     	jae	0x1800096a0 <numba_list_iter_next+0xe30>
1800095a0:     	movq	0x20(%rsp), %rax
1800095a5:     	andb	$0x6, %al
1800095a7:     	cmpb	$0x6, %al
1800095a9:     	jne	0x1800096a0 <numba_list_iter_next+0xe30>
1800095af:     	movl	0x7b9f(%rip), %eax      # 0x180011154
1800095b5:     	movb	$-0x20, %dl
1800095b7:     	orl	$0x8, %eax
1800095ba:     	movl	$0x3, 0x7b8c(%rip)      # 0x180011150
1800095c4:     	movl	%eax, 0x7b8a(%rip)      # 0x180011154
1800095ca:     	testb	$0x20, %r10b
1800095ce:     	je	0x180009632 <numba_list_iter_next+0xdc2>
1800095d0:     	orl	$0x20, %eax
1800095d3:     	movl	$0x5, 0x7b73(%rip)      # 0x180011150
1800095dd:     	movl	%eax, 0x7b71(%rip)      # 0x180011154
1800095e3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1800095e8:     	movq	0x7b79(%rip), %rax      # 0x180011168
1800095ef:     	andl	%ecx, %r10d
1800095f2:     	andq	$-0x3, %rax
1800095f6:     	movq	%rax, 0x7b6b(%rip)      # 0x180011168
1800095fd:     	cmpl	%ecx, %r10d
180009600:     	jne	0x180009639 <numba_list_iter_next+0xdc9>
180009602:     	movq	0x20(%rsp), %rax
180009607:     	andb	%dl, %al
180009609:     	cmpb	%dl, %al
18000960b:     	jne	0x180009632 <numba_list_iter_next+0xdc2>
18000960d:     	movq	0x7b54(%rip), %rax      # 0x180011168
180009614:     	orl	$0x40, 0x7b39(%rip)     # 0x180011154
18000961b:     	andq	$-0x25, %rax
18000961f:     	movl	$0x6, 0x7b27(%rip)      # 0x180011150
180009629:     	movq	%rax, 0x7b38(%rip)      # 0x180011168
180009630:     	jmp	0x180009639 <numba_list_iter_next+0xdc9>
180009632:     	movq	0x7b2f(%rip), %rax      # 0x180011168
180009639:     	btl	$0x17, %esi
18000963d:     	jae	0x18000964b <numba_list_iter_next+0xddb>
18000963f:     	btrq	$0x18, %rax
180009644:     	movq	%rax, 0x7b1d(%rip)      # 0x180011168
18000964b:     	btl	$0x13, %r9d
180009650:     	jae	0x1800096a0 <numba_list_iter_next+0xe30>
180009652:     	movq	0x20(%rsp), %rax
180009657:     	andb	%dl, %al
180009659:     	cmpb	%dl, %al
18000965b:     	jne	0x1800096a0 <numba_list_iter_next+0xe30>
18000965d:     	movq	0x7b04(%rip), %rdx      # 0x180011168
180009664:     	movl	%r11d, %eax
180009667:     	shrq	$0x10, %rax
18000966b:     	movl	%r11d, %ecx
18000966e:     	andl	$0x6, %eax
180009671:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180009677:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000967d:     	movl	%ecx, 0x83d5(%rip)      # 0x180011a58
180009683:     	notq	%rax
180009686:     	andq	%rax, %rdx
180009689:     	movq	%rdx, 0x7ad8(%rip)      # 0x180011168
180009690:     	cmpb	$0x1, %cl
180009693:     	jbe	0x1800096a0 <numba_list_iter_next+0xe30>
180009695:     	andq	$-0x41, %rdx
180009699:     	movq	%rdx, 0x7ac8(%rip)      # 0x180011168
1800096a0:     	btl	$0x15, %r9d
1800096a5:     	jae	0x1800096bc <numba_list_iter_next+0xe4c>
1800096a7:     	movq	0x20(%rsp), %rax
1800096ac:     	btq	$0x13, %rax
1800096b1:     	jae	0x1800096bc <numba_list_iter_next+0xe4c>
1800096b3:     	btrq	$0x7, 0x7aac(%rip)      # 0x180011168
1800096bc:     	movq	0x28(%rsp), %rbx
1800096c1:     	xorl	%eax, %eax
1800096c3:     	movq	0x30(%rsp), %rbp
1800096c8:     	movq	0x38(%rsp), %rsi
1800096cd:     	addq	$0x10, %rsp
1800096d1:     	popq	%rdi
1800096d2:     	retq
1800096d3:     	int3
1800096d4:     	movl	$0x1, %eax
1800096d9:     	retq
1800096da:     	int3
1800096db:     	int3
1800096dc:     	xorl	%eax, %eax
1800096de:     	cmpl	%eax, 0x7a8c(%rip)      # 0x180011170
1800096e4:     	setne	%al
1800096e7:     	retq
1800096e8:     	int3
1800096e9:     	int3
1800096ea:     	int3
1800096eb:     	int3
1800096ec:     	int3
1800096ed:     	int3
1800096ee:     	int3
1800096ef:     	int3
1800096f0:     	jmpq	*0x952(%rip)            # 0x18000a048
1800096f6:     	jmpq	*0x954(%rip)            # 0x18000a050
1800096fc:     	jmpq	*0x98e(%rip)            # 0x18000a090
180009702:     	jmpq	*0x990(%rip)            # 0x18000a098
180009708:     	jmpq	*0x992(%rip)            # 0x18000a0a0
18000970e:     	jmpq	*0x994(%rip)            # 0x18000a0a8
180009714:     	jmpq	*0x996(%rip)            # 0x18000a0b0
18000971a:     	jmpq	*0x960(%rip)            # 0x18000a080
180009720:     	jmpq	*0x992(%rip)            # 0x18000a0b8
180009726:     	jmpq	*0x95c(%rip)            # 0x18000a088
18000972c:     	movb	$0x1, %al
18000972e:     	retq
18000972f:     	int3
180009730:     	xorl	%eax, %eax
180009732:     	retq
180009733:     	jmpq	*0x8ff(%rip)            # 0x18000a038
180009739:     	jmpq	*0x901(%rip)            # 0x18000a040
18000973f:     	jmpq	*0x983(%rip)            # 0x18000a0c8
180009745:     	jmpq	*0x985(%rip)            # 0x18000a0d0
18000974b:     	int3
18000974c:     	int3
18000974d:     	int3
18000974e:     	int3
18000974f:     	int3
180009750:     	int3
180009751:     	int3
180009752:     	int3
180009753:     	int3
180009754:     	int3
180009755:     	int3
180009756:     	nopw	(%rax,%rax)
180009760:     	jmpq	*%rax
180009762:     	int3
180009763:     	int3
180009764:     	int3
180009765:     	int3
180009766:     	int3
180009767:     	int3
180009768:     	int3
180009769:     	int3
18000976a:     	int3
18000976b:     	int3
18000976c:     	int3
18000976d:     	int3
18000976e:     	int3
18000976f:     	int3
180009770:     	int3
180009771:     	int3
180009772:     	int3
180009773:     	int3
180009774:     	int3
180009775:     	int3
180009776:     	nopw	(%rax,%rax)
180009780:     	jmpq	*0xbaa(%rip)            # 0x18000a330
180009786:     	pushq	%rbp
180009788:     	subq	$0x20, %rsp
18000978c:     	movq	%rdx, %rbp
18000978f:     	movb	0x40(%rbp), %cl
180009792:     	addq	$0x20, %rsp
180009796:     	popq	%rbp
180009797:     	jmp	0x18000935c <numba_list_iter_next+0xaec>
18000979c:     	int3
18000979d:     	pushq	%rbp
18000979f:     	subq	$0x20, %rsp
1800097a3:     	movq	%rdx, %rbp
1800097a6:     	movb	0x20(%rbp), %cl
1800097a9:     	callq	0x18000935c <numba_list_iter_next+0xaec>
1800097ae:     	nop
1800097af:     	addq	$0x20, %rsp
1800097b3:     	popq	%rbp
1800097b4:     	retq
1800097b5:     	int3
1800097b6:     	pushq	%rbp
1800097b8:     	subq	$0x20, %rsp
1800097bc:     	movq	%rdx, %rbp
1800097bf:     	addq	$0x20, %rsp
1800097c3:     	popq	%rbp
1800097c4:     	jmp	0x1800091e8 <numba_list_iter_next+0x978>
1800097c9:     	int3
1800097ca:     	pushq	%rbp
1800097cc:     	subq	$0x30, %rsp
1800097d0:     	movq	%rdx, %rbp
1800097d3:     	movq	(%rcx), %rax
1800097d6:     	movl	(%rax), %edx
1800097d8:     	movq	%rcx, 0x28(%rsp)
1800097dd:     	movl	%edx, 0x20(%rsp)
1800097e1:     	leaq	-0xbc8(%rip), %r9       # 0x180008c20 <numba_list_iter_next+0x3b0>
1800097e8:     	movq	0x70(%rbp), %r8
1800097ec:     	movl	0x68(%rbp), %edx
1800097ef:     	movq	0x60(%rbp), %rcx
1800097f3:     	callq	0x180009158 <numba_list_iter_next+0x8e8>
1800097f8:     	nop
1800097f9:     	addq	$0x30, %rsp
1800097fd:     	popq	%rbp
1800097fe:     	retq
1800097ff:     	int3
180009800:     	pushq	%rbp
180009802:     	movq	%rdx, %rbp
180009805:     	movq	(%rcx), %rax
180009808:     	xorl	%ecx, %ecx
18000980a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180009810:     	sete	%cl
180009813:     	movl	%ecx, %eax
180009815:     	popq	%rbp
180009816:     	retq
180009817:     	int3
