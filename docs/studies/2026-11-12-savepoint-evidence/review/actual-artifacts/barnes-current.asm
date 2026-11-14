
D:\Code\Datathon\recompyler-codex-20261111\wave8-native\results\cache\barnes_hut\current\recompyler\rcaotr_b767982c3d43c6022e2cef09.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180008a00 <numba_list_iter_next+0x160>
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
180001195:     	callq	0x1800025d0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x60>
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
18000127e:     	callq	0x180008bb1 <numba_list_iter_next+0x311>
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
1800012dc:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
18000134f:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
1800013c2:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
180001455:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
1800014c1:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
1800014c6:     	testq	%rax, %rax
1800014c9:     	movq	%r13, 0xb0(%rsp)
1800014d1:     	movq	%rbp, 0xe0(%rsp)
1800014d9:     	je	0x1800017e2 <.text+0x7e2>
1800014df:     	movq	%rax, %rsi
1800014e2:     	movq	%rax, %rcx
1800014e5:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
1800014ea:     	movq	%rax, 0xa0(%rsp)
1800014f2:     	movq	%rsi, %rcx
1800014f5:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
1800014fa:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
1800014ff:     	testq	%rax, %rax
180001502:     	jne	0x18000180e <.text+0x80e>
180001508:     	movq	0x120(%rsp), %rcx
180001510:     	callq	0x180008bcf <numba_list_iter_next+0x32f>
180001515:     	movq	%rax, %rsi
180001518:     	movq	%rax, %rcx
18000151b:     	callq	0x180008bd5 <numba_list_iter_next+0x335>
180001520:     	movaps	%xmm0, %xmm6
180001523:     	movq	%rsi, %rcx
180001526:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
18000152b:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180001530:     	testq	%rax, %rax
180001533:     	jne	0x18000180e <.text+0x80e>
180001539:     	movq	0x118(%rsp), %rcx
180001541:     	callq	0x180008bcf <numba_list_iter_next+0x32f>
180001546:     	movq	%rax, %rsi
180001549:     	movq	%rax, %rcx
18000154c:     	callq	0x180008bd5 <numba_list_iter_next+0x335>
180001551:     	movaps	%xmm0, %xmm7
180001554:     	movq	%rsi, %rcx
180001557:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
18000155c:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180001561:     	testq	%rax, %rax
180001564:     	jne	0x18000180e <.text+0x80e>
18000156a:     	movq	0x110(%rsp), %rcx
180001572:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
180001577:     	testq	%rax, %rax
18000157a:     	je	0x1800017fe <.text+0x7fe>
180001580:     	movq	%rax, %rsi
180001583:     	movq	%rax, %rcx
180001586:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
18000158b:     	movq	%rax, %rbp
18000158e:     	movq	%rsi, %rcx
180001591:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180001596:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
18000159b:     	testq	%rax, %rax
18000159e:     	jne	0x18000180e <.text+0x80e>
1800015a4:     	movq	%rbx, %r13
1800015a7:     	movq	%r12, %rbx
1800015aa:     	movq	%r14, %r12
1800015ad:     	movq	%r15, %r14
1800015b0:     	movq	%rdi, %r15
1800015b3:     	movq	0x108(%rsp), %rcx
1800015bb:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
1800015c0:     	testq	%rax, %rax
1800015c3:     	je	0x180001842 <.text+0x842>
1800015c9:     	movq	%rax, %rdi
1800015cc:     	movq	%rax, %rcx
1800015cf:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
1800015d4:     	movq	%rax, %rsi
1800015d7:     	movq	%rdi, %rcx
1800015da:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
1800015df:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
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
1800016f6:     	callq	0x180008bdb <numba_list_iter_next+0x33b>
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
180001728:     	callq	0x180008be1 <numba_list_iter_next+0x341>
18000172d:     	movl	0x8(%rbx), %edx
180001730:     	movq	(%rbx), %rcx
180001733:     	cmpl	$0x0, 0x20(%rbx)
180001737:     	jle	0x180001868 <.text+0x868>
18000173d:     	movslq	%edx, %rdx
180001740:     	callq	0x180008be7 <numba_list_iter_next+0x347>
180001745:     	movq	%rax, %rsi
180001748:     	movq	0x10(%rbx), %rcx
18000174c:     	callq	*0x18(%rbx)
18000174f:     	testq	%rax, %rax
180001752:     	je	0x180001891 <.text+0x891>
180001758:     	movq	%rsi, %rcx
18000175b:     	movq	%rax, %rdx
18000175e:     	callq	0x180007080 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b10>
180001763:     	movq	%rax, %rsi
180001766:     	movq	%rbx, %rcx
180001769:     	callq	0x180008b10 <numba_list_iter_next+0x270>
18000176e:     	jmp	0x180001874 <.text+0x874>
180001773:     	movq	0x8b36(%rip), %rcx      # 0x18000a2b0
18000177a:     	leaq	0x8e1f(%rip), %rdx      # 0x18000a5a0
180001781:     	callq	0x180008bed <numba_list_iter_next+0x34d>
180001786:     	jmp	0x18000183b <.text+0x83b>
18000178b:     	movq	0x8b0e(%rip), %rcx      # 0x18000a2a0
180001792:     	leaq	0x8f07(%rip), %rdx      # 0x18000a6a0
180001799:     	callq	0x180008bed <numba_list_iter_next+0x34d>
18000179e:     	jmp	0x18000183b <.text+0x83b>
1800017a3:     	movq	0x8af6(%rip), %rcx      # 0x18000a2a0
1800017aa:     	leaq	0x8eef(%rip), %rdx      # 0x18000a6a0
1800017b1:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800017b6:     	jmp	0x180001833 <.text+0x833>
1800017b8:     	movq	0x8ae1(%rip), %rcx      # 0x18000a2a0
1800017bf:     	leaq	0x8eda(%rip), %rdx      # 0x18000a6a0
1800017c6:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800017cb:     	jmp	0x18000182b <.text+0x82b>
1800017cd:     	movq	0x8acc(%rip), %rcx      # 0x18000a2a0
1800017d4:     	leaq	0x8ec5(%rip), %rdx      # 0x18000a6a0
1800017db:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800017e0:     	jmp	0x180001823 <.text+0x823>
1800017e2:     	movq	$0x0, 0xa0(%rsp)
1800017ee:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
1800017f3:     	testq	%rax, %rax
1800017f6:     	je	0x180001508 <.text+0x508>
1800017fc:     	jmp	0x18000180e <.text+0x80e>
1800017fe:     	xorl	%ebp, %ebp
180001800:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
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
180001861:     	callq	0x180008bed <numba_list_iter_next+0x34d>
180001866:     	jmp	0x18000183b <.text+0x83b>
180001868:     	movq	0x10(%rbx), %r8
18000186c:     	callq	0x180006fa0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a30>
180001871:     	movq	%rax, %rsi
180001874:     	testq	%rsi, %rsi
180001877:     	je	0x18000183b <.text+0x83b>
180001879:     	movq	%rsi, %rcx
18000187c:     	callq	0x180006b40 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45d0>
180001881:     	jmp	0x18000183b <.text+0x83b>
180001883:     	movq	0x8a06(%rip), %rcx      # 0x18000a290
18000188a:     	callq	0x180008bf3 <numba_list_iter_next+0x353>
18000188f:     	jmp	0x18000183b <.text+0x83b>
180001891:     	movq	0x8a18(%rip), %rcx      # 0x18000a2b0
180001898:     	leaq	0x8e61(%rip), %rdx      # 0x18000a700
18000189f:     	callq	0x180008bed <numba_list_iter_next+0x34d>
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
180001a12:     	callq	0x180006b10 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45a0>
180001a17:     	testl	%edi, %edi
180001a19:     	jle	0x180001a5f <.text+0xa5f>
180001a1b:     	callq	0x180008be1 <numba_list_iter_next+0x341>
180001a20:     	movl	0x8(%rsi), %edx
180001a23:     	movq	(%rsi), %rcx
180001a26:     	cmpl	$0x0, 0x20(%rsi)
180001a2a:     	jle	0x180001a80 <.text+0xa80>
180001a2c:     	movslq	%edx, %rdx
180001a2f:     	callq	0x180008be7 <numba_list_iter_next+0x347>
180001a34:     	movq	%rax, %rdi
180001a37:     	movq	0x10(%rsi), %rcx
180001a3b:     	callq	*0x18(%rsi)
180001a3e:     	testq	%rax, %rax
180001a41:     	je	0x180001adb <.text+0xadb>
180001a47:     	movq	%rdi, %rcx
180001a4a:     	movq	%rax, %rdx
180001a4d:     	callq	0x180007080 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b10>
180001a52:     	movq	%rax, %rdi
180001a55:     	movq	%rsi, %rcx
180001a58:     	callq	0x180008b10 <numba_list_iter_next+0x270>
180001a5d:     	jmp	0x180001a8c <.text+0xa8c>
180001a5f:     	movl	%edi, %eax
180001a61:     	cmpl	$-0x3, %edi
180001a64:     	je	0x180001acd <.text+0xacd>
180001a66:     	cmpl	$-0x1, %eax
180001a69:     	je	0x180001a99 <.text+0xa99>
180001a6b:     	movq	0x8826(%rip), %rcx      # 0x18000a298
180001a72:     	leaq	0x8d37(%rip), %rdx      # 0x18000a7b0
180001a79:     	callq	0x180008bed <numba_list_iter_next+0x34d>
180001a7e:     	jmp	0x180001a99 <.text+0xa99>
180001a80:     	movq	0x10(%rsi), %r8
180001a84:     	callq	0x180006fa0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a30>
180001a89:     	movq	%rax, %rdi
180001a8c:     	testq	%rdi, %rdi
180001a8f:     	je	0x180001a99 <.text+0xa99>
180001a91:     	movq	%rdi, %rcx
180001a94:     	callq	0x180006b40 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45d0>
180001a99:     	leaq	0x8d40(%rip), %rcx      # 0x18000a7e0
180001aa0:     	callq	0x180008bf9 <numba_list_iter_next+0x359>
180001aa5:     	movq	%rax, %rsi
180001aa8:     	movq	%rax, %rcx
180001aab:     	callq	0x180008bff <numba_list_iter_next+0x35f>
180001ab0:     	movq	%rsi, %rcx
180001ab3:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180001ab8:     	leaq	0xa4(%rsp), %rcx
180001ac0:     	callq	0x180006b30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45c0>
180001ac5:     	movq	%rbx, %rax
180001ac8:     	jmp	0x1800019f1 <.text+0x9f1>
180001acd:     	movq	0x87bc(%rip), %rcx      # 0x18000a290
180001ad4:     	callq	0x180008bf3 <numba_list_iter_next+0x353>
180001ad9:     	jmp	0x180001a99 <.text+0xa99>
180001adb:     	movq	0x87ce(%rip), %rcx      # 0x18000a2b0
180001ae2:     	leaq	0x8c87(%rip), %rdx      # 0x18000a770
180001ae9:     	callq	0x180008bed <numba_list_iter_next+0x34d>
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
180001c05:     	callq	0x1800046c0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2150>
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
180001cee:     	callq	0x180008bb1 <numba_list_iter_next+0x311>
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
180001d4c:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
180001dbf:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
180001e32:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
180001ec5:     	callq	0x180007870 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5300>
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
180001f31:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
180001f36:     	testq	%rax, %rax
180001f39:     	movq	%r13, 0xb0(%rsp)
180001f41:     	movq	%rbp, 0xe0(%rsp)
180001f49:     	je	0x180002252 <.text+0x1252>
180001f4f:     	movq	%rax, %rsi
180001f52:     	movq	%rax, %rcx
180001f55:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
180001f5a:     	movq	%rax, 0xa0(%rsp)
180001f62:     	movq	%rsi, %rcx
180001f65:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180001f6a:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180001f6f:     	testq	%rax, %rax
180001f72:     	jne	0x18000227e <.text+0x127e>
180001f78:     	movq	0x120(%rsp), %rcx
180001f80:     	callq	0x180008bcf <numba_list_iter_next+0x32f>
180001f85:     	movq	%rax, %rsi
180001f88:     	movq	%rax, %rcx
180001f8b:     	callq	0x180008bd5 <numba_list_iter_next+0x335>
180001f90:     	movaps	%xmm0, %xmm6
180001f93:     	movq	%rsi, %rcx
180001f96:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180001f9b:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180001fa0:     	testq	%rax, %rax
180001fa3:     	jne	0x18000227e <.text+0x127e>
180001fa9:     	movq	0x118(%rsp), %rcx
180001fb1:     	callq	0x180008bcf <numba_list_iter_next+0x32f>
180001fb6:     	movq	%rax, %rsi
180001fb9:     	movq	%rax, %rcx
180001fbc:     	callq	0x180008bd5 <numba_list_iter_next+0x335>
180001fc1:     	movaps	%xmm0, %xmm7
180001fc4:     	movq	%rsi, %rcx
180001fc7:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180001fcc:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180001fd1:     	testq	%rax, %rax
180001fd4:     	jne	0x18000227e <.text+0x127e>
180001fda:     	movq	0x110(%rsp), %rcx
180001fe2:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
180001fe7:     	testq	%rax, %rax
180001fea:     	je	0x18000226e <.text+0x126e>
180001ff0:     	movq	%rax, %rsi
180001ff3:     	movq	%rax, %rcx
180001ff6:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
180001ffb:     	movq	%rax, %rbp
180001ffe:     	movq	%rsi, %rcx
180002001:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180002006:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
18000200b:     	testq	%rax, %rax
18000200e:     	jne	0x18000227e <.text+0x127e>
180002014:     	movq	%rbx, %r13
180002017:     	movq	%r12, %rbx
18000201a:     	movq	%r14, %r12
18000201d:     	movq	%r15, %r14
180002020:     	movq	%rdi, %r15
180002023:     	movq	0x108(%rsp), %rcx
18000202b:     	callq	0x180008bb7 <numba_list_iter_next+0x317>
180002030:     	testq	%rax, %rax
180002033:     	je	0x1800022b2 <.text+0x12b2>
180002039:     	movq	%rax, %rdi
18000203c:     	movq	%rax, %rcx
18000203f:     	callq	0x180008bbd <numba_list_iter_next+0x31d>
180002044:     	movq	%rax, %rsi
180002047:     	movq	%rdi, %rcx
18000204a:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
18000204f:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
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
180002166:     	callq	0x180008bdb <numba_list_iter_next+0x33b>
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
180002198:     	callq	0x180008be1 <numba_list_iter_next+0x341>
18000219d:     	movl	0x8(%rbx), %edx
1800021a0:     	movq	(%rbx), %rcx
1800021a3:     	cmpl	$0x0, 0x20(%rbx)
1800021a7:     	jle	0x1800022d8 <.text+0x12d8>
1800021ad:     	movslq	%edx, %rdx
1800021b0:     	callq	0x180008be7 <numba_list_iter_next+0x347>
1800021b5:     	movq	%rax, %rsi
1800021b8:     	movq	0x10(%rbx), %rcx
1800021bc:     	callq	*0x18(%rbx)
1800021bf:     	testq	%rax, %rax
1800021c2:     	je	0x180002301 <.text+0x1301>
1800021c8:     	movq	%rsi, %rcx
1800021cb:     	movq	%rax, %rdx
1800021ce:     	callq	0x180007080 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b10>
1800021d3:     	movq	%rax, %rsi
1800021d6:     	movq	%rbx, %rcx
1800021d9:     	callq	0x180008b10 <numba_list_iter_next+0x270>
1800021de:     	jmp	0x1800022e4 <.text+0x12e4>
1800021e3:     	movq	0x80c6(%rip), %rcx      # 0x18000a2b0
1800021ea:     	leaq	0x86ff(%rip), %rdx      # 0x18000a8f0
1800021f1:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800021f6:     	jmp	0x1800022ab <.text+0x12ab>
1800021fb:     	movq	0x809e(%rip), %rcx      # 0x18000a2a0
180002202:     	leaq	0x87e7(%rip), %rdx      # 0x18000a9f0
180002209:     	callq	0x180008bed <numba_list_iter_next+0x34d>
18000220e:     	jmp	0x1800022ab <.text+0x12ab>
180002213:     	movq	0x8086(%rip), %rcx      # 0x18000a2a0
18000221a:     	leaq	0x87cf(%rip), %rdx      # 0x18000a9f0
180002221:     	callq	0x180008bed <numba_list_iter_next+0x34d>
180002226:     	jmp	0x1800022a3 <.text+0x12a3>
180002228:     	movq	0x8071(%rip), %rcx      # 0x18000a2a0
18000222f:     	leaq	0x87ba(%rip), %rdx      # 0x18000a9f0
180002236:     	callq	0x180008bed <numba_list_iter_next+0x34d>
18000223b:     	jmp	0x18000229b <.text+0x129b>
18000223d:     	movq	0x805c(%rip), %rcx      # 0x18000a2a0
180002244:     	leaq	0x87a5(%rip), %rdx      # 0x18000a9f0
18000224b:     	callq	0x180008bed <numba_list_iter_next+0x34d>
180002250:     	jmp	0x180002293 <.text+0x1293>
180002252:     	movq	$0x0, 0xa0(%rsp)
18000225e:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
180002263:     	testq	%rax, %rax
180002266:     	je	0x180001f78 <.text+0xf78>
18000226c:     	jmp	0x18000227e <.text+0x127e>
18000226e:     	xorl	%ebp, %ebp
180002270:     	callq	0x180008bc9 <numba_list_iter_next+0x329>
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
1800022d1:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800022d6:     	jmp	0x1800022ab <.text+0x12ab>
1800022d8:     	movq	0x10(%rbx), %r8
1800022dc:     	callq	0x180006fa0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a30>
1800022e1:     	movq	%rax, %rsi
1800022e4:     	testq	%rsi, %rsi
1800022e7:     	je	0x1800022ab <.text+0x12ab>
1800022e9:     	movq	%rsi, %rcx
1800022ec:     	callq	0x180006b40 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45d0>
1800022f1:     	jmp	0x1800022ab <.text+0x12ab>
1800022f3:     	movq	0x7f96(%rip), %rcx      # 0x18000a290
1800022fa:     	callq	0x180008bf3 <numba_list_iter_next+0x353>
1800022ff:     	jmp	0x1800022ab <.text+0x12ab>
180002301:     	movq	0x7fa8(%rip), %rcx      # 0x18000a2b0
180002308:     	leaq	0x8741(%rip), %rdx      # 0x18000aa50
18000230f:     	callq	0x180008bed <numba_list_iter_next+0x34d>
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
180002482:     	callq	0x180006b10 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45a0>
180002487:     	testl	%edi, %edi
180002489:     	jle	0x1800024cf <.text+0x14cf>
18000248b:     	callq	0x180008be1 <numba_list_iter_next+0x341>
180002490:     	movl	0x8(%rsi), %edx
180002493:     	movq	(%rsi), %rcx
180002496:     	cmpl	$0x0, 0x20(%rsi)
18000249a:     	jle	0x1800024f0 <.text+0x14f0>
18000249c:     	movslq	%edx, %rdx
18000249f:     	callq	0x180008be7 <numba_list_iter_next+0x347>
1800024a4:     	movq	%rax, %rdi
1800024a7:     	movq	0x10(%rsi), %rcx
1800024ab:     	callq	*0x18(%rsi)
1800024ae:     	testq	%rax, %rax
1800024b1:     	je	0x18000254b <.text+0x154b>
1800024b7:     	movq	%rdi, %rcx
1800024ba:     	movq	%rax, %rdx
1800024bd:     	callq	0x180007080 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b10>
1800024c2:     	movq	%rax, %rdi
1800024c5:     	movq	%rsi, %rcx
1800024c8:     	callq	0x180008b10 <numba_list_iter_next+0x270>
1800024cd:     	jmp	0x1800024fc <.text+0x14fc>
1800024cf:     	movl	%edi, %eax
1800024d1:     	cmpl	$-0x3, %edi
1800024d4:     	je	0x18000253d <.text+0x153d>
1800024d6:     	cmpl	$-0x1, %eax
1800024d9:     	je	0x180002509 <.text+0x1509>
1800024db:     	movq	0x7db6(%rip), %rcx      # 0x18000a298
1800024e2:     	leaq	0x8617(%rip), %rdx      # 0x18000ab00
1800024e9:     	callq	0x180008bed <numba_list_iter_next+0x34d>
1800024ee:     	jmp	0x180002509 <.text+0x1509>
1800024f0:     	movq	0x10(%rsi), %r8
1800024f4:     	callq	0x180006fa0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a30>
1800024f9:     	movq	%rax, %rdi
1800024fc:     	testq	%rdi, %rdi
1800024ff:     	je	0x180002509 <.text+0x1509>
180002501:     	movq	%rdi, %rcx
180002504:     	callq	0x180006b40 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45d0>
180002509:     	leaq	0x8620(%rip), %rcx      # 0x18000ab30
180002510:     	callq	0x180008bf9 <numba_list_iter_next+0x359>
180002515:     	movq	%rax, %rsi
180002518:     	movq	%rax, %rcx
18000251b:     	callq	0x180008bff <numba_list_iter_next+0x35f>
180002520:     	movq	%rsi, %rcx
180002523:     	callq	0x180008bc3 <numba_list_iter_next+0x323>
180002528:     	leaq	0xa4(%rsp), %rcx
180002530:     	callq	0x180006b30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x45c0>
180002535:     	movq	%rbx, %rax
180002538:     	jmp	0x180002461 <.text+0x1461>
18000253d:     	movq	0x7d4c(%rip), %rcx      # 0x18000a290
180002544:     	callq	0x180008bf3 <numba_list_iter_next+0x353>
180002549:     	jmp	0x180002509 <.text+0x1509>
18000254b:     	movq	0x7d5e(%rip), %rcx      # 0x18000a2b0
180002552:     	leaq	0x8567(%rip), %rdx      # 0x18000aac0
180002559:     	callq	0x180008bed <numba_list_iter_next+0x34d>
18000255e:     	xorl	%eax, %eax
180002560:     	jmp	0x180002461 <.text+0x1461>
180002565:     	nopw	%cs:(%rax,%rax)
18000256f:     	nop

0000000180002570 <PyInit_rcaotr_b767982c3d43c6022e2cef09>:
180002570:     	pushq	%rsi
180002571:     	subq	$0x20, %rsp
180002575:     	leaq	0xeae4(%rip), %rcx      # 0x180011060
18000257c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180002581:     	callq	0x180008c05 <numba_list_iter_next+0x365>
180002586:     	testq	%rax, %rax
180002589:     	je	0x1800025bb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b>
18000258b:     	leaq	0xea6e(%rip), %rdx      # 0x180011000
180002592:     	leaq	0x8607(%rip), %r8       # 0x18000aba0
180002599:     	leaq	0x87c0(%rip), %r9       # 0x18000ad60
1800025a0:     	movq	%rax, %rcx
1800025a3:     	movq	%rax, %rsi
1800025a6:     	callq	0x180007ae0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5570>
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
180002649:     	jb	0x18000265b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xeb>
18000264b:     	movq	0x198(%rsp), %rsi
180002653:     	addq	%rsi, %rax
180002656:     	cmpq	%r10, %rax
180002659:     	jae	0x18000269d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x12d>
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
1800026b0:     	jle	0x1800026b8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x148>
1800026b2:     	movb	$0x2, (%r15)
1800026b6:     	jmp	0x180002667 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf7>
1800026b8:     	movq	%rax, (%r13)
1800026bc:     	xorl	%eax, %eax
1800026be:     	cmpb	$0x0, (%r15)
1800026c2:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
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
1800026fd:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
180002703:     	movq	(%r13), %rbx
180002707:     	leaq	0xb(%rbx), %r11
18000270b:     	cmpq	%r12, %r11
18000270e:     	jle	0x180002719 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1a9>
180002710:     	movb	$0x2, (%r15)
180002714:     	jmp	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
180002719:     	movq	%r11, (%r13)
18000271d:     	cmpb	$0x0, (%r15)
180002721:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
180002727:     	movq	%r10, (%r9,%rbx,8)
18000272b:     	movq	$0x4, 0x8(%r9,%rbx,8)
180002734:     	movq	(%r13), %r10
180002738:     	cmpq	%r12, %r10
18000273b:     	movq	%r10, %r11
18000273e:     	jle	0x18000274b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1db>
180002740:     	movb	$0x2, (%r15)
180002744:     	movq	(%r13), %r10
180002748:     	xorl	%r11d, %r11d
18000274b:     	leaq	0x3(%r10), %rsi
18000274f:     	cmpq	%r12, %rsi
180002752:     	jg	0x180002710 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1a0>
180002754:     	movq	%rsi, (%r13)
180002758:     	cmpb	$0x0, (%r15)
18000275c:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
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
1800027a6:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
1800027ac:     	leaq	(%r9,%rbx,8), %r11
1800027b0:     	movq	%r10, 0x30(%r11)
1800027b4:     	movq	$0x0, 0x18(%r11)
1800027bc:     	movq	(%r13), %r10
1800027c0:     	leaq	0x4(%r10), %rsi
1800027c4:     	cmpq	%r12, %rsi
1800027c7:     	jg	0x180002710 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1a0>
1800027cd:     	movq	%rdx, 0x88(%rsp)
1800027d5:     	movq	%rsi, (%r13)
1800027d9:     	cmpb	$0x0, (%r15)
1800027dd:     	jne	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
1800027e3:     	movq	%rcx, 0x60(%rsp)
1800027e8:     	movq	$0x0, (%r8,%r10,8)
1800027f0:     	movq	$0x1, 0x8(%r9,%r10,8)
1800027f9:     	movq	%r8, 0x68(%rsp)
1800027fe:     	movq	$0x0, 0x10(%r8,%r10,8)
180002807:     	movq	$0x1, 0x18(%r9,%r10,8)
180002810:     	cmpb	$0x0, (%r15)
180002814:     	jne	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
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
18000285b:     	jne	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
180002861:     	movq	0x178(%rsp), %rcx
180002869:     	movq	%rcx, %rax
18000286c:     	sarq	$0x3f, %rax
180002870:     	andq	%r12, %rax
180002873:     	leaq	(%rdi,%rcx,8), %rbp
180002877:     	movq	%rax, 0x78(%rsp)
18000287c:     	cmpq	$0x0, (%rbp,%rax,8)
180002882:     	jle	0x18000294a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3da>
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
1800028cd:     	jge	0x180002ade <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e>
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
180002913:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180002918:     	testl	%eax, %eax
18000291a:     	jne	0x180002ad1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x561>
180002920:     	cmpb	$0x0, (%r15)
180002924:     	jne	0x180002c15 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a5>
18000292a:     	incq	%r14
18000292d:     	movq	0x8(%r13), %rax
180002931:     	decq	%rax
180002934:     	movq	%rax, 0x8(%r13)
180002938:     	movq	0x78(%rsp), %rcx
18000293d:     	cmpq	(%rbp,%rcx), %r14
180002942:     	jl	0x1800028aa <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x33a>
180002948:     	jmp	0x180002950 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3e0>
18000294a:     	shlq	$0x3, 0x78(%rsp)
180002950:     	movsd	0x188(%rsp), %xmm6
180002959:     	movsd	0x180(%rsp), %xmm7
180002962:     	leaq	(,%r12,8), %rax
18000296a:     	xorl	%r14d, %r14d
18000296d:     	cmpq	$-0x2, 0x178(%rsp)
180002976:     	cmovgeq	%r14, %rax
18000297a:     	movq	%rax, 0x80(%rsp)
180002982:     	xorpd	%xmm8, %xmm8
180002987:     	jmp	0x1800029a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x432>
180002989:     	movb	$0x1, (%r15)
18000298d:     	movq	$0x4c4b43, 0x18(%r13)   # imm = 0x4C4B43
180002995:     	incq	%r14
180002998:     	cmpb	$0x0, (%r15)
18000299c:     	jne	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
1800029a2:     	movq	0x78(%rsp), %rax
1800029a7:     	cmpq	(%rbp,%rax), %r14
1800029ac:     	jge	0x180002aef <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x57f>
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
1800029e1:     	jge	0x180002c09 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x699>
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
180002a1e:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
180002a23:     	testl	%eax, %eax
180002a25:     	jne	0x180002ad1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x561>
180002a2b:     	xorl	%eax, %eax
180002a2d:     	cmpb	$0x0, (%r15)
180002a31:     	jne	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
180002a37:     	movsd	0x90(%rsp), %xmm1
180002a40:     	movsd	0xa0(%rsp), %xmm0
180002a49:     	decq	0x8(%r13)
180002a4d:     	movq	0x68(%rsp), %rcx
180002a52:     	movsd	0x8(%rcx,%rsi,8), %xmm2
180002a58:     	ucomisd	%xmm8, %xmm2
180002a5d:     	jne	0x180002a65 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f5>
180002a5f:     	jnp	0x180002989 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x419>
180002a65:     	movq	(%rdi,%rsi,8), %rdx
180002a69:     	divsd	%xmm2, %xmm1
180002a6d:     	movq	0x68(%rsp), %r8
180002a72:     	addsd	(%r8,%rdx,8), %xmm1
180002a78:     	movsd	%xmm1, (%r8,%rdx,8)
180002a7e:     	movq	$0x0, 0x8(%rdi,%rdx,8)
180002a87:     	movsd	0x8(%r8,%rsi,8), %xmm1
180002a8e:     	ucomisd	%xmm8, %xmm1
180002a93:     	jne	0x180002aa8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x538>
180002a95:     	jp	0x180002aa8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x538>
180002a97:     	movb	$0x1, (%r15)
180002a9b:     	movq	$0x4c4b44, 0x18(%r13)   # imm = 0x4C4B44
180002aa3:     	jmp	0x180002995 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x425>
180002aa8:     	movq	(%rdi,%rsi,8), %rdx
180002aac:     	divsd	%xmm1, %xmm0
180002ab0:     	movq	0x68(%rsp), %r8
180002ab5:     	addsd	0x10(%r8,%rdx,8), %xmm0
180002abc:     	movsd	%xmm0, 0x10(%r8,%rdx,8)
180002ac3:     	movq	$0x0, 0x18(%rdi,%rdx,8)
180002acc:     	jmp	0x180002995 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x425>
180002ad1:     	movq	0x88(%rsp), %rcx
180002ad9:     	jmp	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
180002ade:     	movb	$0x1, (%r15)
180002ae2:     	movq	$0x9, 0x18(%r13)
180002aea:     	jmp	0x180002c15 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a5>
180002aef:     	xorl	%eax, %eax
180002af1:     	xorl	%ecx, %ecx
180002af3:     	movq	0x78(%rsp), %rdx
180002af8:     	cmpq	(%rbp,%rdx), %rcx
180002afd:     	jge	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
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
180002c01:     	je	0x180002af3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x583>
180002c07:     	jmp	0x180002c17 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6a7>
180002c09:     	movb	$0x1, (%r15)
180002c0d:     	movq	$0xd, 0x18(%r13)
180002c15:     	xorl	%eax, %eax
180002c17:     	movq	0x60(%rsp), %rcx
180002c1c:     	jmp	0x180002669 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xf9>
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
180002c8d:     	jne	0x180002ca6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x736>
180002c8f:     	jp	0x180002ca6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x736>
180002c91:     	movb	$0x1, 0x18(%rcx)
180002c95:     	movq	$0x0, 0x10(%rcx)
180002c9d:     	movb	$0x1, 0x8(%rcx)
180002ca1:     	jmp	0x180002eb4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x944>
180002ca6:     	movq	0x1a0(%rsp), %rdi
180002cae:     	movq	0x190(%rsp), %r14
180002cb6:     	movq	0x30(%r9,%r15,8), %rax
180002cbb:     	movq	%rax, %r10
180002cbe:     	sarq	$0x3f, %r10
180002cc2:     	andq	%r14, %r10
180002cc5:     	leaq	(%r9,%rax,8), %rdx
180002cc9:     	cmpq	$0x1, (%rdx,%r10,8)
180002cce:     	jne	0x180002cf1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x781>
180002cd0:     	xorl	%r10d, %r10d
180002cd3:     	cmpq	$-0x2, %rax
180002cd7:     	cmovlq	%r14, %r10
180002cdb:     	movq	0x10(%rdx,%r10,8), %rax
180002ce0:     	leaq	(%r9,%rax,8), %rdx
180002ce4:     	sarq	$0x3f, %rax
180002ce8:     	andq	%r14, %rax
180002ceb:     	cmpq	%rdi, (%rdx,%rax,8)
180002cef:     	je	0x180002c91 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x721>
180002cf1:     	movq	0x188(%rsp), %rbx
180002cf9:     	movq	0x180(%rsp), %rsi
180002d01:     	movq	0x10(%r9,%r15,8), %r10
180002d06:     	movsd	(%r8,%r10,8), %xmm1
180002d0c:     	cmpq	$0x0, 0x8(%r9,%r10,8)
180002d12:     	setne	%r11b
180002d16:     	movq	0x10(%r9,%rdi,8), %rdx
180002d1b:     	cmpq	$0x0, 0x8(%r9,%rdx,8)
180002d21:     	setne	%al
180002d24:     	subsd	(%r8,%rdx,8), %xmm1
180002d2a:     	andb	%r11b, %al
180002d2d:     	cmpb	$0x1, %al
180002d2f:     	jne	0x180002d53 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x7e3>
180002d31:     	movapd	0x7687(%rip), %xmm2     # 0x18000a3c0
180002d39:     	andpd	%xmm1, %xmm2
180002d3d:     	ucomisd	0x768b(%rip), %xmm2     # 0x18000a3d0
180002d45:     	jae	0x180002dfa <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x88a>
180002d4b:     	xorpd	%xmm2, %xmm2
180002d4f:     	addsd	%xmm2, %xmm1
180002d53:     	movsd	0x10(%r8,%r10,8), %xmm2
180002d5a:     	cmpq	$0x0, 0x18(%r9,%r10,8)
180002d60:     	subsd	0x10(%r8,%rdx,8), %xmm2
180002d67:     	je	0x180002dd1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x861>
180002d69:     	cmpq	$0x0, 0x18(%r9,%rdx,8)
180002d6f:     	je	0x180002dd1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x861>
180002d71:     	movapd	0x7647(%rip), %xmm3     # 0x18000a3c0
180002d79:     	andpd	%xmm2, %xmm3
180002d7d:     	ucomisd	0x764b(%rip), %xmm3     # 0x18000a3d0
180002d85:     	jae	0x180002e3e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8ce>
180002d8b:     	movapd	%xmm1, %xmm3
180002d8f:     	mulsd	%xmm1, %xmm3
180002d93:     	ucomisd	0x7635(%rip), %xmm3     # 0x18000a3d0
180002d9b:     	setae	%dl
180002d9e:     	testb	%dl, %al
180002da0:     	jne	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002da2:     	xorpd	%xmm4, %xmm4
180002da6:     	addsd	%xmm4, %xmm2
180002daa:     	movapd	%xmm2, %xmm4
180002dae:     	mulsd	%xmm2, %xmm4
180002db2:     	ucomisd	0x7616(%rip), %xmm4     # 0x18000a3d0
180002dba:     	jae	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002dbc:     	addsd	%xmm4, %xmm3
180002dc0:     	ucomisd	0x7608(%rip), %xmm3     # 0x18000a3d0
180002dc8:     	setae	%dl
180002dcb:     	testb	%dl, %al
180002dcd:     	jne	0x180002dea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x87a>
180002dcf:     	jmp	0x180002e16 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8a6>
180002dd1:     	movapd	%xmm1, %xmm3
180002dd5:     	mulsd	%xmm1, %xmm3
180002dd9:     	ucomisd	0x75ef(%rip), %xmm3     # 0x18000a3d0
180002de1:     	setae	%dl
180002de4:     	andb	%dl, %al
180002de6:     	cmpb	$0x1, %al
180002de8:     	jne	0x180002e0a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x89a>
180002dea:     	movb	$0x1, (%rbx)
180002ded:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180002df5:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002dfa:     	movb	$0x1, (%rbx)
180002dfd:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180002e05:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e0a:     	movapd	%xmm2, %xmm4
180002e0e:     	mulsd	%xmm2, %xmm4
180002e12:     	addsd	%xmm4, %xmm3
180002e16:     	xorps	%xmm4, %xmm4
180002e19:     	sqrtsd	%xmm3, %xmm4
180002e1d:     	cmpq	$0x0, 0x18(%r9,%r15,8)
180002e23:     	je	0x180002e71 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x901>
180002e25:     	xorpd	%xmm5, %xmm5
180002e29:     	ucomisd	%xmm5, %xmm3
180002e2d:     	jne	0x180002e4b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8db>
180002e2f:     	jp	0x180002e4b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x8db>
180002e31:     	movb	$0x1, (%rbx)
180002e34:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180002e3c:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e3e:     	movb	$0x1, (%rbx)
180002e41:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180002e49:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180002e4b:     	movsd	0x1a8(%rsp), %xmm6
180002e54:     	movq	(%r9,%r15,8), %rax
180002e58:     	movsd	0x8(%r8,%rax,8), %xmm3
180002e5f:     	addsd	%xmm3, %xmm3
180002e63:     	divsd	%xmm4, %xmm3
180002e67:     	ucomisd	%xmm3, %xmm6
180002e6b:     	jbe	0x180002f24 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x9b4>
180002e71:     	movsd	0x755f(%rip), %xmm3     # 0x18000a3d8
180002e79:     	maxsd	%xmm4, %xmm3
180002e7d:     	movapd	%xmm3, %xmm4
180002e81:     	mulsd	%xmm3, %xmm4
180002e85:     	xorpd	%xmm5, %xmm5
180002e89:     	ucomisd	%xmm5, %xmm4
180002e8d:     	jne	0x180002eea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x97a>
180002e8f:     	jp	0x180002eea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x97a>
180002e91:     	movb	$0x1, (%rbx)
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
180002eea:     	movsd	0x8(%r8,%rdi,8), %xmm5
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
180002f22:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180002f24:     	movq	0x20(%r9,%r15,8), %rax
180002f29:     	testq	%rax, %rax
180002f2c:     	js	0x180002fc9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xa59>
180002f32:     	movq	0x8(%rsi), %rdx
180002f36:     	leaq	0x1(%rdx), %r10
180002f3a:     	movq	%r10, 0x8(%rsi)
180002f3e:     	cmpq	0x10(%rsi), %rdx
180002f42:     	jge	0x180003113 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xba3>
180002f48:     	movq	%rcx, %r13
180002f4b:     	movsd	%xmm6, 0x48(%rsp)
180002f51:     	movq	%rdi, 0x40(%rsp)
180002f56:     	movq	%rax, 0x38(%rsp)
180002f5b:     	movq	%r14, 0x30(%rsp)
180002f60:     	movq	%rbx, 0x28(%rsp)
180002f65:     	movq	%rsi, 0x20(%rsp)
180002f6a:     	leaq	0xc0(%rsp), %rcx
180002f72:     	movq	%r8, %r12
180002f75:     	movq	%r9, %rbp
180002f78:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
180002f7d:     	cmpb	$0x0, (%rbx)
180002f80:     	jne	0x1800030ee <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb7e>
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
180002fc7:     	jmp	0x180002fd7 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xa67>
180002fc9:     	movb	$0x1, %r11b
180002fcc:     	xorpd	%xmm7, %xmm7
180002fd0:     	xorpd	%xmm8, %xmm8
180002fd5:     	movb	$0x1, %dl
180002fd7:     	movq	0x28(%r9,%r15,8), %rax
180002fdc:     	testq	%rax, %rax
180002fdf:     	js	0x180003087 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb17>
180002fe5:     	movl	%edx, %ebp
180002fe7:     	movq	0x8(%rsi), %rdx
180002feb:     	leaq	0x1(%rdx), %r10
180002fef:     	movq	%r10, 0x8(%rsi)
180002ff3:     	cmpq	0x10(%rsi), %rdx
180002ff7:     	jge	0x180003123 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbb3>
180002ffd:     	movb	%r11b, 0x57(%rsp)
180003002:     	movq	%rcx, %r13
180003005:     	movsd	%xmm6, 0x48(%rsp)
18000300b:     	movq	%rdi, 0x40(%rsp)
180003010:     	movq	%rax, 0x38(%rsp)
180003015:     	movq	%r14, 0x30(%rsp)
18000301a:     	movq	%rbx, 0x28(%rsp)
18000301f:     	movq	%rsi, 0x20(%rsp)
180003024:     	leaq	0xa0(%rsp), %rcx
18000302c:     	movq	%r8, 0x58(%rsp)
180003031:     	movq	%r9, %r12
180003034:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
180003039:     	cmpb	$0x0, (%rbx)
18000303c:     	jne	0x1800030ee <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xb7e>
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
18000308f:     	js	0x180003188 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xc18>
180003095:     	movl	%edx, %ebp
180003097:     	movq	0x8(%rsi), %rdx
18000309b:     	leaq	0x1(%rdx), %r10
18000309f:     	movq	%r10, 0x8(%rsi)
1800030a3:     	cmpq	0x10(%rsi), %rdx
1800030a7:     	jge	0x180003133 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbc3>
1800030ad:     	movb	%r11b, 0x57(%rsp)
1800030b2:     	movq	%rcx, %r13
1800030b5:     	movsd	%xmm6, 0x48(%rsp)
1800030bb:     	movq	%rdi, 0x40(%rsp)
1800030c0:     	movq	%rax, 0x38(%rsp)
1800030c5:     	movq	%r14, 0x30(%rsp)
1800030ca:     	movq	%rbx, 0x28(%rsp)
1800030cf:     	movq	%rsi, 0x20(%rsp)
1800030d4:     	leaq	0x80(%rsp), %rcx
1800030dc:     	movq	%r8, 0x58(%rsp)
1800030e1:     	movq	%r9, %r12
1800030e4:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
1800030e9:     	cmpb	$0x0, (%rbx)
1800030ec:     	je	0x180003143 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xbd3>
1800030ee:     	movq	$0x0, 0x18(%r13)
1800030f6:     	movq	$0x0, 0x10(%r13)
1800030fe:     	movq	$0x0, 0x8(%r13)
180003106:     	movq	$0x0, (%r13)
18000310e:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180003113:     	movb	$0x1, (%rbx)
180003116:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
18000311e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003123:     	movb	$0x1, (%rbx)
180003126:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
18000312e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
180003133:     	movb	$0x1, (%rbx)
180003136:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
18000313e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
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
180003190:     	js	0x180003242 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcd2>
180003196:     	movl	%edx, %r12d
180003199:     	movq	0x8(%rsi), %rdx
18000319d:     	leaq	0x1(%rdx), %r10
1800031a1:     	movq	%r10, 0x8(%rsi)
1800031a5:     	cmpq	0x10(%rsi), %rdx
1800031a9:     	jge	0x180003203 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xc93>
1800031ab:     	movl	%r11d, %ebp
1800031ae:     	movq	%rcx, %r15
1800031b1:     	movsd	%xmm6, 0x48(%rsp)
1800031b7:     	movq	%rdi, 0x40(%rsp)
1800031bc:     	movq	%rax, 0x38(%rsp)
1800031c1:     	movq	%r14, 0x30(%rsp)
1800031c6:     	movq	%rbx, 0x28(%rsp)
1800031cb:     	movq	%rsi, 0x20(%rsp)
1800031d0:     	leaq	0x60(%rsp), %rcx
1800031d5:     	callq	0x180002c30 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x6c0>
1800031da:     	cmpb	$0x0, (%rbx)
1800031dd:     	je	0x180003213 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xca3>
1800031df:     	movq	$0x0, 0x18(%r15)
1800031e7:     	movq	$0x0, 0x10(%r15)
1800031ef:     	movq	$0x0, 0x8(%r15)
1800031f7:     	movq	$0x0, (%r15)
1800031fe:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
180003203:     	movb	$0x1, (%rbx)
180003206:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
18000320e:     	jmp	0x180002e9c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x92c>
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
180003253:     	jmp	0x180002ebb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x94b>
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
1800032c3:     	je	0x1800032ea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xd7a>
1800032c5:     	cmpq	$0x1, %rax
1800032c9:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800032cf:     	movq	(%rbp), %rdx
1800032d3:     	leaq	0x4(%rdx), %rax
1800032d7:     	cmpq	%rbx, %rax
1800032da:     	jle	0x18000345e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xeee>
1800032e0:     	movb	$0x2, (%r13)
1800032e5:     	jmp	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
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
180003326:     	jb	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
18000332c:     	addsd	%xmm2, %xmm1
180003330:     	ucomisd	%xmm0, %xmm1
180003334:     	jbe	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
18000333a:     	movsd	0x10(%r8,%rdx,8), %xmm0
180003341:     	movsd	(%r8,%rax,8), %xmm2
180003347:     	movsd	0x18(%r8,%rax,8), %xmm1
18000334e:     	movapd	%xmm1, %xmm3
180003352:     	subsd	%xmm2, %xmm3
180003356:     	ucomisd	%xmm3, %xmm0
18000335a:     	jb	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
180003360:     	addsd	%xmm2, %xmm1
180003364:     	xorl	%r12d, %r12d
180003367:     	ucomisd	%xmm0, %xmm1
18000336b:     	jbe	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003371:     	cmpb	$0x0, (%r13)
180003376:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
18000337c:     	movq	0x18(%r9,%r15,8), %r10
180003381:     	movq	0x30(%r9,%r15,8), %rdx
180003386:     	movq	%rdx, %r11
180003389:     	sarq	$0x3f, %r11
18000338d:     	andq	%rbx, %r11
180003390:     	leaq	(%r9,%rdx,8), %r12
180003394:     	movq	(%r12,%r11,8), %rdi
180003398:     	cmpq	0x8(%r9,%r15,8), %rdi
18000339d:     	jge	0x180003659 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10e9>
1800033a3:     	testq	%r10, %r10
1800033a6:     	jne	0x18000365e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10ee>
1800033ac:     	xorl	%eax, %eax
1800033ae:     	cmpq	$-0x1, %rdx
1800033b2:     	cmovlq	%rbx, %rax
1800033b6:     	cmpq	0x8(%r12,%rax,8), %rdi
1800033bb:     	jne	0x180003b6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x15fc>
1800033c1:     	leaq	(%rdi,%rdi), %r10
1800033c5:     	testq	%rdi, %rdi
1800033c8:     	movl	$0x4, %r14d
1800033ce:     	cmovneq	%r10, %r14
1800033d2:     	movq	(%rbp), %rsi
1800033d6:     	movq	%rsi, 0x70(%rsp)
1800033db:     	leaq	(%rsi,%r14), %r10
1800033df:     	cmpq	%rbx, %r10
1800033e2:     	jg	0x1800032e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xd70>
1800033e8:     	movq	%r10, (%rbp)
1800033ec:     	cmpb	$0x0, (%r13)
1800033f1:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800033f7:     	movq	%r14, 0xb8(%rsp)
1800033ff:     	movq	%rax, 0xc0(%rsp)
180003407:     	xorl	%eax, %eax
180003409:     	movq	%rdx, 0x90(%rsp)
180003411:     	cmpq	$-0x2, %rdx
180003415:     	cmovlq	%rbx, %rax
180003419:     	movq	%rax, 0x98(%rsp)
180003421:     	testq	%rdi, %rdi
180003424:     	jle	0x180003b2d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x15bd>
18000342a:     	movq	0x98(%rsp), %rax
180003432:     	movq	0x10(%r12,%rax,8), %rsi
180003437:     	movl	%edi, %edx
180003439:     	andl	$0x7, %edx
18000343c:     	cmpq	$0x7, %rdi
180003440:     	ja	0x18000383b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x12cb>
180003446:     	leaq	(,%rbx,8), %rax
18000344e:     	movq	%rax, 0xa8(%rsp)
180003456:     	xorl	%r13d, %r13d
180003459:     	jmp	0x180003adf <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x156f>
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
18000349a:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800034a0:     	movapd	%xmm2, %xmm4
1800034a4:     	addsd	%xmm3, %xmm4
1800034a8:     	movapd	%xmm1, %xmm5
1800034ac:     	subsd	%xmm0, %xmm5
1800034b0:     	movsd	%xmm4, 0x10(%r8,%rdx,8)
1800034b7:     	movsd	%xmm5, 0x18(%r8,%rdx,8)
1800034be:     	movsd	%xmm3, 0x8(%r8,%rdx,8)
1800034c5:     	movsd	%xmm0, (%r8,%rdx,8)
1800034cb:     	cmpb	$0x0, (%r13)
1800034d0:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800034d6:     	movq	(%rbp), %rax
1800034da:     	leaq	0xb(%rax), %r11
1800034de:     	cmpq	%rbx, %r11
1800034e1:     	jg	0x1800032e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xd70>
1800034e7:     	movq	0x8(%r9,%r15,8), %r10
1800034ec:     	movq	%r11, (%rbp)
1800034f0:     	cmpb	$0x0, (%r13)
1800034f5:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800034fb:     	movq	%rdx, (%r9,%rax,8)
1800034ff:     	movq	%r10, 0x8(%r9,%rax,8)
180003504:     	movq	(%rbp), %rdx
180003508:     	cmpq	%rbx, %rdx
18000350b:     	movq	%rdx, %r10
18000350e:     	jle	0x18000351c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xfac>
180003510:     	movb	$0x2, (%r13)
180003515:     	movq	(%rbp), %rdx
180003519:     	xorl	%r10d, %r10d
18000351c:     	leaq	0x3(%rdx), %r11
180003520:     	cmpq	%rbx, %r11
180003523:     	jg	0x1800032e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xd70>
180003529:     	movq	%r11, (%rbp)
18000352d:     	cmpb	$0x0, (%r13)
180003532:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
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
180003580:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003586:     	leaq	(%r9,%rax,8), %r10
18000358a:     	movq	%rdx, 0x30(%r10)
18000358e:     	movq	$0x0, 0x18(%r10)
180003596:     	movq	(%rbp), %rdx
18000359a:     	leaq	0x4(%rdx), %r11
18000359e:     	cmpq	%rbx, %r11
1800035a1:     	jg	0x1800032e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xd70>
1800035a7:     	movq	%r11, (%rbp)
1800035ab:     	cmpb	$0x0, (%r13)
1800035b0:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
1800035b6:     	movq	%rcx, %r14
1800035b9:     	movq	$0x0, (%r8,%rdx,8)
1800035c1:     	movq	$0x1, 0x8(%r9,%rdx,8)
1800035ca:     	movq	$0x0, 0x10(%r8,%rdx,8)
1800035d3:     	movq	$0x1, 0x18(%r9,%rdx,8)
1800035dc:     	cmpb	$0x0, (%r13)
1800035e1:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
18000362d:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003633:     	movq	%rax, 0x20(%rsi,%r15,8)
180003638:     	movq	(%rbp), %rcx
18000363c:     	leaq	0x4(%rcx), %rax
180003640:     	cmpq	%rbx, %rax
180003643:     	jle	0x180003da4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1834>
180003649:     	movq	0x168(%rsp), %rax
180003651:     	movb	$0x2, (%rax)
180003654:     	jmp	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003659:     	testq	%r10, %r10
18000365c:     	je	0x1800036d9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1169>
18000365e:     	movq	0x20(%r9,%r15,8), %rax
180003663:     	testq	%rax, %rax
180003666:     	js	0x1800037a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1232>
18000366c:     	movq	0x8(%rbp), %rdx
180003670:     	leaq	0x1(%rdx), %r10
180003674:     	movq	%r10, 0x8(%rbp)
180003678:     	cmpq	0x10(%rbp), %rdx
18000367c:     	jge	0x1800037a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1232>
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
1800036c2:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
1800036c7:     	cmpb	$0x0, (%r13)
1800036cc:     	je	0x18000374b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x11db>
1800036ce:     	xorl	%r12d, %r12d
1800036d1:     	movq	%rdi, %rcx
1800036d4:     	jmp	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
1800036d9:     	movq	0x8(%rbp), %rax
1800036dd:     	leaq	0x1(%rax), %rdx
1800036e1:     	movq	%rdx, 0x8(%rbp)
1800036e5:     	cmpq	0x10(%rbp), %rax
1800036e9:     	jge	0x18000373c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x11cc>
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
180003728:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
18000372d:     	cmpb	$0x0, (%r13)
180003732:     	je	0x180003787 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1217>
180003734:     	xorl	%r12d, %r12d
180003737:     	movq	%rsi, %rcx
18000373a:     	jmp	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
18000373c:     	movb	$0x1, (%r13)
180003741:     	movq	$0x2dc6cb, 0x18(%rbp)   # imm = 0x2DC6CB
180003749:     	jmp	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
18000374b:     	movq	0x8(%rbp), %rdx
18000374f:     	leaq	-0x1(%rdx), %rax
180003753:     	cmpb	$0x0, 0x62(%rsp)
180003758:     	movq	%rax, 0x8(%rbp)
18000375c:     	movb	$0x1, %r12b
18000375f:     	movq	%rdi, %rcx
180003762:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003764:     	movq	0x28(%rsi,%r15,8), %rax
180003769:     	testq	%rax, %rax
18000376c:     	js	0x180003778 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1208>
18000376e:     	movq	%rdx, 0x8(%rbp)
180003772:     	cmpq	0x10(%rbp), %rdx
180003776:     	jle	0x1800037cf <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x125f>
180003778:     	movb	$0x1, (%r13)
18000377d:     	movq	$0x2dc6ce, 0x18(%rbp)   # imm = 0x2DC6CE
180003785:     	jmp	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
180003787:     	decq	0x8(%rbp)
18000378b:     	movq	%rsi, %rcx
18000378e:     	movq	%r12, %r9
180003791:     	movq	%rdi, %r8
180003794:     	movq	0x20(%r9,%r15,8), %rax
180003799:     	testq	%rax, %rax
18000379c:     	jns	0x18000366c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10fc>
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
18000380c:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180003811:     	cmpb	$0x0, (%r13)
180003816:     	jne	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
18000381c:     	movq	0x8(%rbp), %rcx
180003820:     	leaq	-0x1(%rcx), %rax
180003824:     	cmpb	$0x0, 0x61(%rsp)
180003829:     	movq	%rax, 0x8(%rbp)
18000382d:     	je	0x180003ccb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x175b>
180003833:     	movq	%rdi, %rcx
180003836:     	jmp	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
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
180003ab8:     	jne	0x18000388f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x131f>
180003abe:     	testq	%rdx, %rdx
180003ac1:     	movq	0xb0(%rsp), %rdi
180003ac9:     	movq	0x90(%rsp), %rax
180003ad1:     	leaq	(%r9,%rax,8), %r12
180003ad5:     	movq	0xa0(%rsp), %rsi
180003add:     	je	0x180003b2d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x15bd>
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
180003b2b:     	jne	0x180003af4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1584>
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
180003b79:     	jne	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
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
180003bbe:     	jbe	0x180003c8f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x171f>
180003bc4:     	movq	0x10(%r9,%r15,8), %rax
180003bc9:     	cmpq	$0x0, 0x8(%r9,%rax,8)
180003bcf:     	mulsd	(%r8,%rax,8), %xmm2
180003bd5:     	je	0x180003c01 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1691>
180003bd7:     	cmpq	$0x0, 0x50(%r9,%r15,8)
180003bdd:     	je	0x180003c01 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1691>
180003bdf:     	movapd	0x67d9(%rip), %xmm3     # 0x18000a3c0
180003be7:     	andpd	%xmm2, %xmm3
180003beb:     	ucomisd	0x67dd(%rip), %xmm3     # 0x18000a3d0
180003bf3:     	jae	0x180003cad <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x173d>
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
180003c3c:     	je	0x180003c64 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x16f4>
180003c3e:     	cmpq	$0x0, 0x50(%r9,%r15,8)
180003c44:     	je	0x180003c64 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x16f4>
180003c46:     	movapd	0x6772(%rip), %xmm2     # 0x18000a3c0
180003c4e:     	andpd	%xmm1, %xmm2
180003c52:     	ucomisd	0x6776(%rip), %xmm2     # 0x18000a3d0
180003c5a:     	jae	0x180003cbc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x174c>
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
180003ca8:     	jmp	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003cad:     	movb	$0x1, (%r13)
180003cb2:     	movq	$0x895447, 0x18(%rbp)   # imm = 0x895447
180003cba:     	jmp	0x180003c9f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x172f>
180003cbc:     	movb	$0x1, (%r13)
180003cc1:     	movq	$0x895449, 0x18(%rbp)   # imm = 0x895449
180003cc9:     	jmp	0x180003c9f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x172f>
180003ccb:     	movq	0x38(%rsi,%r15,8), %rax
180003cd0:     	testq	%rax, %rax
180003cd3:     	js	0x180003cf7 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1787>
180003cd5:     	movq	%rcx, 0x8(%rbp)
180003cd9:     	cmpq	0x10(%rbp), %rcx
180003cdd:     	jle	0x180003d09 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1799>
180003cdf:     	movq	0x168(%rsp), %rax
180003ce7:     	movb	$0x1, (%rax)
180003cea:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180003cf2:     	jmp	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
180003cf7:     	movb	$0x1, (%r13)
180003cfc:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180003d04:     	jmp	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
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
180003d4e:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180003d53:     	cmpb	$0x0, (%r13)
180003d58:     	jne	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
180003d5e:     	movq	0x8(%rbp), %rax
180003d62:     	leaq	-0x1(%rax), %rcx
180003d66:     	cmpb	$0x0, 0x60(%rsp)
180003d6b:     	movq	%rcx, 0x8(%rbp)
180003d6f:     	movq	%rdi, %rcx
180003d72:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003d78:     	movq	0x40(%rsi,%r15,8), %rcx
180003d7d:     	testq	%rcx, %rcx
180003d80:     	js	0x180003d8c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x181c>
180003d82:     	movq	%rax, 0x8(%rbp)
180003d86:     	cmpq	0x10(%rbp), %rax
180003d8a:     	jle	0x180003de0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1870>
180003d8c:     	movq	0x168(%rsp), %rax
180003d94:     	movb	$0x1, (%rax)
180003d97:     	movq	$0x2dc6d0, 0x18(%rbp)   # imm = 0x2DC6D0
180003d9f:     	jmp	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
180003da4:     	movq	%rax, (%rbp)
180003da8:     	movq	0x168(%rsp), %rax
180003db0:     	cmpb	$0x0, (%rax)
180003db3:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003db5:     	subsd	%xmm3, %xmm2
180003db9:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
180003dbf:     	movsd	%xmm5, 0x18(%rdi,%rcx,8)
180003dc5:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
180003dcb:     	movsd	%xmm0, (%rdi,%rcx,8)
180003dd0:     	cmpb	$0x0, (%rax)
180003dd3:     	je	0x180003e42 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x18d2>
180003dd5:     	xorl	%r12d, %r12d
180003dd8:     	movq	%r14, %rcx
180003ddb:     	jmp	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
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
180003e25:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180003e2a:     	cmpb	$0x0, (%rbx)
180003e2d:     	jne	0x1800036ce <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x115e>
180003e33:     	movzbl	0x5f(%rsp), %r12d
180003e39:     	decq	0x8(%rbp)
180003e3d:     	jmp	0x180003833 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x12c3>
180003e42:     	movq	(%rbp), %rax
180003e46:     	leaq	0xb(%rax), %r8
180003e4a:     	cmpq	%rbx, %r8
180003e4d:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180003e53:     	movq	0x8(%rsi,%r15,8), %rdx
180003e58:     	movq	%r8, (%rbp)
180003e5c:     	movq	0x168(%rsp), %r8
180003e64:     	cmpb	$0x0, (%r8)
180003e68:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003e6e:     	movq	%rcx, (%rsi,%rax,8)
180003e72:     	movq	%rdx, 0x8(%rsi,%rax,8)
180003e77:     	movq	(%rbp), %rdx
180003e7b:     	cmpq	%rbx, %rdx
180003e7e:     	movq	%rdx, %rcx
180003e81:     	jle	0x180003e94 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1924>
180003e83:     	movq	0x168(%rsp), %rcx
180003e8b:     	movb	$0x2, (%rcx)
180003e8e:     	movq	(%rbp), %rdx
180003e92:     	xorl	%ecx, %ecx
180003e94:     	leaq	0x3(%rdx), %r8
180003e98:     	cmpq	%rbx, %r8
180003e9b:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180003ea1:     	movq	%r8, (%rbp)
180003ea5:     	movq	0x168(%rsp), %r8
180003ead:     	cmpb	$0x0, (%r8)
180003eb1:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
180003f08:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180003f0e:     	leaq	(%rsi,%rax,8), %rcx
180003f12:     	movq	%rdx, 0x30(%rcx)
180003f16:     	movq	$0x0, 0x18(%rcx)
180003f1e:     	movq	(%rbp), %rdx
180003f22:     	leaq	0x4(%rdx), %r8
180003f26:     	cmpq	%rbx, %r8
180003f29:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180003f2f:     	movq	%r8, (%rbp)
180003f33:     	movq	0x168(%rsp), %r8
180003f3b:     	cmpb	$0x0, (%r8)
180003f3f:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003f45:     	movq	$0x0, (%rdi,%rdx,8)
180003f4d:     	movq	$0x1, 0x8(%rsi,%rdx,8)
180003f56:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180003f5f:     	movq	$0x1, 0x18(%rsi,%rdx,8)
180003f68:     	cmpb	$0x0, (%r8)
180003f6c:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003f72:     	movq	%rdx, 0x10(%rcx)
180003f76:     	movq	$0x0, 0x48(%rdi,%rax,8)
180003f7f:     	movq	$0x1, 0x50(%rcx)
180003f87:     	movq	$-0x1, 0x20(%rcx)
180003f8f:     	movq	$-0x1, 0x28(%rcx)
180003f97:     	movq	$-0x1, 0x38(%rcx)
180003f9f:     	movq	$-0x1, 0x40(%rcx)
180003fa7:     	movq	0x168(%rsp), %rcx
180003faf:     	cmpb	$0x0, (%rcx)
180003fb2:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003fb8:     	movq	%rax, 0x28(%rsi,%r15,8)
180003fbd:     	movq	(%rbp), %rcx
180003fc1:     	leaq	0x4(%rcx), %rax
180003fc5:     	cmpq	%rbx, %rax
180003fc8:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180003fce:     	movq	%rax, (%rbp)
180003fd2:     	movq	0x168(%rsp), %rax
180003fda:     	cmpb	$0x0, (%rax)
180003fdd:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180003fe3:     	addsd	%xmm0, %xmm1
180003fe7:     	movsd	%xmm4, 0x10(%rdi,%rcx,8)
180003fed:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
180003ff3:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
180003ff9:     	movsd	%xmm0, (%rdi,%rcx,8)
180003ffe:     	cmpb	$0x0, (%rax)
180004001:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004007:     	movq	(%rbp), %rax
18000400b:     	leaq	0xb(%rax), %r8
18000400f:     	cmpq	%rbx, %r8
180004012:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180004018:     	movq	0x8(%rsi,%r15,8), %rdx
18000401d:     	movq	%r8, (%rbp)
180004021:     	movq	0x168(%rsp), %r8
180004029:     	cmpb	$0x0, (%r8)
18000402d:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004033:     	movq	%rcx, (%rsi,%rax,8)
180004037:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000403c:     	movq	(%rbp), %rdx
180004040:     	cmpq	%rbx, %rdx
180004043:     	movq	%rdx, %rcx
180004046:     	jle	0x180004059 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1ae9>
180004048:     	movq	0x168(%rsp), %rcx
180004050:     	movb	$0x2, (%rcx)
180004053:     	movq	(%rbp), %rdx
180004057:     	xorl	%ecx, %ecx
180004059:     	leaq	0x3(%rdx), %r8
18000405d:     	cmpq	%rbx, %r8
180004060:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180004066:     	movq	%r8, (%rbp)
18000406a:     	movq	0x168(%rsp), %r8
180004072:     	cmpb	$0x0, (%r8)
180004076:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
1800040cd:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
1800040d3:     	leaq	(%rsi,%rax,8), %rcx
1800040d7:     	movq	%rdx, 0x30(%rcx)
1800040db:     	movq	$0x0, 0x18(%rcx)
1800040e3:     	movq	(%rbp), %rdx
1800040e7:     	leaq	0x4(%rdx), %r8
1800040eb:     	cmpq	%rbx, %r8
1800040ee:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
1800040f4:     	movq	%r8, (%rbp)
1800040f8:     	movq	0x168(%rsp), %r8
180004100:     	cmpb	$0x0, (%r8)
180004104:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
18000410a:     	movq	$0x0, (%rdi,%rdx,8)
180004112:     	movq	$0x1, 0x8(%rsi,%rdx,8)
18000411b:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180004124:     	movq	$0x1, 0x18(%rsi,%rdx,8)
18000412d:     	cmpb	$0x0, (%r8)
180004131:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004137:     	movq	%rdx, 0x10(%rcx)
18000413b:     	movq	$0x0, 0x48(%rdi,%rax,8)
180004144:     	movq	$0x1, 0x50(%rcx)
18000414c:     	movq	$-0x1, 0x20(%rcx)
180004154:     	movq	$-0x1, 0x28(%rcx)
18000415c:     	movq	$-0x1, 0x38(%rcx)
180004164:     	movq	$-0x1, 0x40(%rcx)
18000416c:     	movq	0x168(%rsp), %rcx
180004174:     	cmpb	$0x0, (%rcx)
180004177:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
18000417d:     	movq	%rax, 0x38(%rsi,%r15,8)
180004182:     	movq	(%rbp), %rcx
180004186:     	leaq	0x4(%rcx), %rax
18000418a:     	cmpq	%rbx, %rax
18000418d:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180004193:     	movq	%rax, (%rbp)
180004197:     	movq	0x168(%rsp), %rax
18000419f:     	cmpb	$0x0, (%rax)
1800041a2:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800041a8:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
1800041ae:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
1800041b4:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800041ba:     	movsd	%xmm0, (%rdi,%rcx,8)
1800041bf:     	cmpb	$0x0, (%rax)
1800041c2:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800041c8:     	movq	(%rbp), %rax
1800041cc:     	leaq	0xb(%rax), %r8
1800041d0:     	cmpq	%rbx, %r8
1800041d3:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
1800041d9:     	movq	0x8(%rsi,%r15,8), %rdx
1800041de:     	movq	%r8, (%rbp)
1800041e2:     	movq	0x168(%rsp), %r8
1800041ea:     	cmpb	$0x0, (%r8)
1800041ee:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800041f4:     	movq	%rcx, (%rsi,%rax,8)
1800041f8:     	movq	%rdx, 0x8(%rsi,%rax,8)
1800041fd:     	movq	(%rbp), %rdx
180004201:     	cmpq	%rbx, %rdx
180004204:     	movq	%rdx, %rcx
180004207:     	jle	0x18000421a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1caa>
180004209:     	movq	0x168(%rsp), %rcx
180004211:     	movb	$0x2, (%rcx)
180004214:     	movq	(%rbp), %rdx
180004218:     	xorl	%ecx, %ecx
18000421a:     	leaq	0x3(%rdx), %r8
18000421e:     	cmpq	%rbx, %r8
180004221:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
180004227:     	movq	%r8, (%rbp)
18000422b:     	movq	0x168(%rsp), %r8
180004233:     	cmpb	$0x0, (%r8)
180004237:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
18000428e:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180004294:     	leaq	(%rsi,%rax,8), %rcx
180004298:     	movq	%rdx, 0x30(%rcx)
18000429c:     	movq	$0x0, 0x18(%rcx)
1800042a4:     	movq	(%rbp), %rdx
1800042a8:     	leaq	0x4(%rdx), %r8
1800042ac:     	cmpq	%rbx, %r8
1800042af:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
1800042b5:     	movq	%r8, (%rbp)
1800042b9:     	movq	0x168(%rsp), %r8
1800042c1:     	cmpb	$0x0, (%r8)
1800042c5:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800042cb:     	movq	$0x0, (%rdi,%rdx,8)
1800042d3:     	movq	$0x1, 0x8(%rsi,%rdx,8)
1800042dc:     	movq	$0x0, 0x10(%rdi,%rdx,8)
1800042e5:     	movq	$0x1, 0x18(%rsi,%rdx,8)
1800042ee:     	cmpb	$0x0, (%r8)
1800042f2:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800042f8:     	movq	%rdx, 0x10(%rcx)
1800042fc:     	movq	$0x0, 0x48(%rdi,%rax,8)
180004305:     	movq	$0x1, 0x50(%rcx)
18000430d:     	movq	$-0x1, 0x20(%rcx)
180004315:     	movq	$-0x1, 0x28(%rcx)
18000431d:     	movq	$-0x1, 0x38(%rcx)
180004325:     	movq	$-0x1, 0x40(%rcx)
18000432d:     	movq	0x168(%rsp), %rcx
180004335:     	cmpb	$0x0, (%rcx)
180004338:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
180004371:     	jle	0x1800045c1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2051>
180004377:     	leaq	(,%rbx,8), %rcx
18000437f:     	xorl	%r12d, %r12d
180004382:     	cmpq	$-0x2, %rax
180004386:     	cmovgeq	%r12, %rcx
18000438a:     	movq	%rcx, 0x80(%rsp)
180004392:     	movq	0x20(%rsi,%r15,8), %rax
180004397:     	testq	%rax, %rax
18000439a:     	js	0x18000465a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x20ea>
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
1800043d9:     	jge	0x18000465a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x20ea>
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
180004422:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180004427:     	cmpb	$0x0, (%r13)
18000442c:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004432:     	movq	0x8(%rbp), %rcx
180004436:     	leaq	-0x1(%rcx), %rax
18000443a:     	movq	%rax, 0x8(%rbp)
18000443e:     	movq	0x28(%rsi,%r15,8), %rax
180004443:     	testq	%rax, %rax
180004446:     	js	0x180004672 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2102>
18000444c:     	movq	%rcx, 0x8(%rbp)
180004450:     	cmpq	0x10(%rbp), %rcx
180004454:     	jg	0x180004672 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2102>
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
18000449d:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
1800044a2:     	cmpb	$0x0, (%r13)
1800044a7:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800044ad:     	movq	0x8(%rbp), %rcx
1800044b1:     	leaq	-0x1(%rcx), %rax
1800044b5:     	movq	%rax, 0x8(%rbp)
1800044b9:     	movq	0x38(%rsi,%r15,8), %rax
1800044be:     	testq	%rax, %rax
1800044c1:     	js	0x18000468a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x211a>
1800044c7:     	movq	%rcx, 0x8(%rbp)
1800044cb:     	cmpq	0x10(%rbp), %rcx
1800044cf:     	jg	0x18000468a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x211a>
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
180004518:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
18000451d:     	cmpb	$0x0, (%r13)
180004522:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004528:     	movq	0x8(%rbp), %rcx
18000452c:     	leaq	-0x1(%rcx), %rax
180004530:     	movq	%rax, 0x8(%rbp)
180004534:     	movq	0x40(%rsi,%r15,8), %rax
180004539:     	testq	%rax, %rax
18000453c:     	js	0x1800046a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2132>
180004542:     	movq	%rcx, 0x8(%rbp)
180004546:     	cmpq	0x10(%rbp), %rcx
18000454a:     	jg	0x1800046a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2132>
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
180004593:     	callq	0x180003260 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0xcf0>
180004598:     	cmpb	$0x0, (%r13)
18000459d:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800045a3:     	incq	%r12
1800045a6:     	decq	0x8(%rbp)
1800045aa:     	movq	0x88(%rsp), %rax
1800045b2:     	movq	0x78(%rsp), %rcx
1800045b7:     	cmpq	(%rcx,%rax,8), %r12
1800045bb:     	jl	0x180004392 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1e22>
1800045c1:     	movq	(%rbp), %rax
1800045c5:     	cmpq	%rbx, %rax
1800045c8:     	movq	%rax, %rcx
1800045cb:     	jle	0x1800045de <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x206e>
1800045cd:     	movq	0x168(%rsp), %rax
1800045d5:     	movb	$0x2, (%rax)
1800045d8:     	movq	(%rbp), %rax
1800045dc:     	xorl	%ecx, %ecx
1800045de:     	leaq	0x3(%rax), %rdx
1800045e2:     	cmpq	%rbx, %rdx
1800045e5:     	jg	0x180003649 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x10d9>
1800045eb:     	movq	%rdx, (%rbp)
1800045ef:     	movq	0x168(%rsp), %rdx
1800045f7:     	cmpb	$0x0, (%rdx)
1800045fa:     	jne	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
18000464a:     	jne	0x1800037b2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1242>
180004650:     	movq	%rax, 0x30(%rsi,%r15,8)
180004655:     	jmp	0x1800037af <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x123f>
18000465a:     	movq	0x168(%rsp), %rax
180004662:     	movb	$0x1, (%rax)
180004665:     	movq	$0x989697, 0x18(%rbp)   # imm = 0x989697
18000466d:     	jmp	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
180004672:     	movq	0x168(%rsp), %rax
18000467a:     	movb	$0x1, (%rax)
18000467d:     	movq	$0x989698, 0x18(%rbp)   # imm = 0x989698
180004685:     	jmp	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
18000468a:     	movq	0x168(%rsp), %rax
180004692:     	movb	$0x1, (%rax)
180004695:     	movq	$0x989699, 0x18(%rbp)   # imm = 0x989699
18000469d:     	jmp	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
1800046a2:     	movq	0x168(%rsp), %rax
1800046aa:     	movb	$0x1, (%rax)
1800046ad:     	movq	$0x98969a, 0x18(%rbp)   # imm = 0x98969A
1800046b5:     	jmp	0x180003dd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x1865>
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
18000475c:     	jb	0x18000476e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x21fe>
18000475e:     	movq	0x188(%rsp), %r11
180004766:     	addq	%r11, %rax
180004769:     	cmpq	%rsi, %rax
18000476c:     	jae	0x1800047a8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2238>
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
1800047ba:     	jle	0x1800047c3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2253>
1800047bc:     	movb	$0x2, (%r12)
1800047c1:     	jmp	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
1800047c3:     	movq	%rsi, (%r15)
1800047c6:     	cmpb	$0x0, (%r12)
1800047cb:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
1800047cd:     	testq	%rax, %rax
1800047d0:     	js	0x180004814 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x22a4>
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
18000480c:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
180004812:     	jmp	0x18000482c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x22bc>
180004814:     	movb	$0x1, (%r12)
180004819:     	movq	$0xf4242, 0x18(%r15)    # imm = 0xF4242
180004821:     	cmpb	$0x0, (%r12)
180004826:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
18000482c:     	movq	(%r15), %rbp
18000482f:     	leaq	0xb(%rbp), %r10
180004833:     	cmpq	%r13, %r10
180004836:     	jg	0x1800047bc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x224c>
180004838:     	movq	%r10, (%r15)
18000483b:     	cmpb	$0x0, (%r12)
180004840:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
180004846:     	movq	%rax, (%r9,%rbp,8)
18000484a:     	movq	$0x4, 0x8(%r9,%rbp,8)
180004853:     	movq	(%r15), %r10
180004856:     	cmpq	%r13, %r10
180004859:     	movq	%r10, %rax
18000485c:     	jle	0x180004868 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x22f8>
18000485e:     	movb	$0x2, (%r12)
180004863:     	movq	(%r15), %r10
180004866:     	xorl	%eax, %eax
180004868:     	leaq	0x3(%r10), %r11
18000486c:     	cmpq	%r13, %r11
18000486f:     	jg	0x1800047bc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x224c>
180004875:     	movq	%r11, (%r15)
180004878:     	cmpb	$0x0, (%r12)
18000487d:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
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
1800048c4:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
1800048ca:     	leaq	(%r9,%rbp,8), %rax
1800048ce:     	movq	%r10, 0x30(%rax)
1800048d2:     	movq	$0x0, 0x18(%rax)
1800048da:     	movq	(%r15), %r10
1800048dd:     	leaq	0x4(%r10), %r11
1800048e1:     	cmpq	%r13, %r11
1800048e4:     	jg	0x1800047bc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x224c>
1800048ea:     	movq	%r11, (%r15)
1800048ed:     	cmpb	$0x0, (%r12)
1800048f2:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
1800048f8:     	movq	%rdx, 0x88(%rsp)
180004900:     	movq	%r8, %rdi
180004903:     	movq	%r9, %rsi
180004906:     	movq	%rcx, 0x68(%rsp)
18000490b:     	testq	%r10, %r10
18000490e:     	js	0x180004935 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x23c5>
180004910:     	movq	$0x0, (%rdi,%r10,8)
180004918:     	leaq	(%rsi,%r10,8), %rcx
18000491c:     	movq	$0x1, 0x8(%rsi,%r10,8)
180004925:     	movq	$0x0, 0x10(%rdi,%r10,8)
18000492e:     	movl	$0x1, %edx
180004933:     	jmp	0x180004942 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x23d2>
180004935:     	movb	$0x1, (%r12)
18000493a:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
18000493f:     	movq	%r15, %rcx
180004942:     	movq	%rdx, 0x18(%rcx)
180004946:     	cmpb	$0x0, (%r12)
18000494b:     	movq	0x68(%rsp), %rcx
180004950:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
180004956:     	movq	%r10, 0x10(%rax)
18000495a:     	movq	$0x0, 0x48(%rdi,%rbp,8)
180004963:     	movq	$0x1, 0x50(%rax)
18000496b:     	movq	$-0x1, 0x20(%rax)
180004973:     	movq	$-0x1, 0x28(%rax)
18000497b:     	movq	$-0x1, 0x38(%rax)
180004983:     	movq	$-0x1, 0x40(%rax)
18000498b:     	cmpb	$0x0, (%r12)
180004990:     	jne	0x18000477b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x220b>
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
1800049ce:     	jle	0x180004aa5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2535>
1800049d4:     	testq	%rbp, %rbp
1800049d7:     	js	0x180004c14 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26a4>
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
180004a27:     	jge	0x180004c14 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26a4>
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
180004a69:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
180004a6e:     	testl	%eax, %eax
180004a70:     	jne	0x180004df5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2885>
180004a76:     	cmpb	$0x0, (%r12)
180004a7b:     	jne	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004a81:     	incq	%rbx
180004a84:     	movq	0x8(%r15), %rax
180004a88:     	decq	%rax
180004a8b:     	movq	%rax, 0x8(%r15)
180004a8f:     	movq	0x78(%rsp), %rcx
180004a94:     	movq	0x70(%rsp), %rdx
180004a99:     	cmpq	(%rdx,%rcx), %rbx
180004a9d:     	jl	0x1800049f7 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2487>
180004aa3:     	jmp	0x180004abd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x254d>
180004aa5:     	shlq	$0x3, 0x78(%rsp)
180004aab:     	shlq	$0x3, 0x80(%rsp)
180004ab4:     	testq	%rbp, %rbp
180004ab7:     	js	0x180004c32 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26c2>
180004abd:     	movsd	0x170(%rsp), %xmm6
180004ac6:     	xorl	%ebx, %ebx
180004ac8:     	xorpd	%xmm7, %xmm7
180004acc:     	movq	0x78(%rsp), %rax
180004ad1:     	movq	0x70(%rsp), %rcx
180004ad6:     	cmpq	(%rcx,%rax), %rbx
180004ada:     	jge	0x180004c32 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26c2>
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
180004b14:     	jge	0x180004e1f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28af>
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
180004b4f:     	callq	0x180004e60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28f0>
180004b54:     	testl	%eax, %eax
180004b56:     	jne	0x180004e43 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28d3>
180004b5c:     	cmpb	$0x0, (%r12)
180004b61:     	jne	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004b67:     	movsd	0xa0(%rsp), %xmm1
180004b70:     	movsd	0xb0(%rsp), %xmm0
180004b79:     	decq	0x8(%r15)
180004b7d:     	testq	%r14, %r14
180004b80:     	js	0x180004e31 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28c1>
180004b86:     	movq	(%rsi,%r14,8), %rax
180004b8a:     	testq	%rax, %rax
180004b8d:     	js	0x180004b9e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x262e>
180004b8f:     	movsd	0x8(%rdi,%r14,8), %xmm2
180004b96:     	ucomisd	%xmm7, %xmm2
180004b9a:     	jne	0x180004bbb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x264b>
180004b9c:     	jp	0x180004bbb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x264b>
180004b9e:     	movb	$0x1, (%r12)
180004ba3:     	movq	$0x4c4b43, 0x18(%r15)   # imm = 0x4C4B43
180004bab:     	incq	%rbx
180004bae:     	cmpb	$0x0, (%r12)
180004bb3:     	je	0x180004acc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x255c>
180004bb9:     	jmp	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004bbb:     	divsd	%xmm2, %xmm1
180004bbf:     	addsd	(%rdi,%rax,8), %xmm1
180004bc4:     	movsd	%xmm1, (%rdi,%rax,8)
180004bc9:     	movq	$0x0, 0x8(%rsi,%rax,8)
180004bd2:     	movq	(%rsi,%r14,8), %rax
180004bd6:     	testq	%rax, %rax
180004bd9:     	js	0x180004bea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x267a>
180004bdb:     	movsd	0x8(%rdi,%r14,8), %xmm1
180004be2:     	ucomisd	%xmm7, %xmm1
180004be6:     	jne	0x180004bf9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2689>
180004be8:     	jp	0x180004bf9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2689>
180004bea:     	movb	$0x1, (%r12)
180004bef:     	movq	$0x4c4b44, 0x18(%r15)   # imm = 0x4C4B44
180004bf7:     	jmp	0x180004bab <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x263b>
180004bf9:     	divsd	%xmm1, %xmm0
180004bfd:     	addsd	0x10(%rdi,%rax,8), %xmm0
180004c03:     	movsd	%xmm0, 0x10(%rdi,%rax,8)
180004c09:     	movq	$0x0, 0x18(%rsi,%rax,8)
180004c12:     	jmp	0x180004bab <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x263b>
180004c14:     	movb	$0x1, (%r12)
180004c19:     	movq	$0x9, 0x18(%r15)
180004c21:     	movq	0x68(%rsp), %rax
180004c26:     	movq	$0x0, (%rax)
180004c2d:     	jmp	0x180004782 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2212>
180004c32:     	movsd	0x178(%rsp), %xmm0
180004c3b:     	xorl	%eax, %eax
180004c3d:     	movq	0x78(%rsp), %rcx
180004c42:     	movq	0x70(%rsp), %rdx
180004c47:     	cmpq	(%rdx,%rcx), %rax
180004c4b:     	jge	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004c4d:     	movq	0x70(%rsp), %rcx
180004c52:     	movq	0x80(%rsp), %rdx
180004c5a:     	movq	0x10(%rcx,%rdx), %rcx
180004c5f:     	addq	%rax, %rcx
180004c62:     	leaq	(%rsi,%rcx,8), %rdx
180004c66:     	sarq	$0x3f, %rcx
180004c6a:     	andq	%r13, %rcx
180004c6d:     	movq	(%rdx,%rcx,8), %rcx
180004c71:     	testq	%rcx, %rcx
180004c74:     	js	0x180004e0d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x289d>
180004c7a:     	movq	0x18(%rsi,%rcx,8), %rdx
180004c7f:     	testq	%rdx, %rdx
180004c82:     	js	0x180004d95 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2825>
180004c88:     	movq	(%rsi,%rcx,8), %r8
180004c8c:     	testq	%r8, %r8
180004c8f:     	js	0x180004d95 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2825>
180004c95:     	movsd	(%rdi,%r8,8), %xmm1
180004c9b:     	mulsd	%xmm0, %xmm1
180004c9f:     	addsd	(%rdi,%rdx,8), %xmm1
180004ca4:     	movsd	%xmm1, (%rdi,%rdx,8)
180004ca9:     	movq	$0x0, 0x8(%rsi,%rdx,8)
180004cb2:     	movq	0x18(%rsi,%rcx,8), %rdx
180004cb7:     	testq	%rdx, %rdx
180004cba:     	js	0x180004da1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2831>
180004cc0:     	movq	(%rsi,%rcx,8), %r8
180004cc4:     	testq	%r8, %r8
180004cc7:     	js	0x180004da1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2831>
180004ccd:     	movsd	0x10(%rdi,%r8,8), %xmm1
180004cd4:     	mulsd	%xmm0, %xmm1
180004cd8:     	addsd	0x10(%rdi,%rdx,8), %xmm1
180004cde:     	movsd	%xmm1, 0x10(%rdi,%rdx,8)
180004ce4:     	movq	$0x0, 0x18(%rsi,%rdx,8)
180004ced:     	movq	0x10(%rsi,%rcx,8), %rdx
180004cf2:     	testq	%rdx, %rdx
180004cf5:     	js	0x180004dad <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x283d>
180004cfb:     	movq	0x18(%rsi,%rcx,8), %r8
180004d00:     	testq	%r8, %r8
180004d03:     	js	0x180004dad <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x283d>
180004d09:     	movsd	(%rdi,%r8,8), %xmm1
180004d0f:     	mulsd	%xmm0, %xmm1
180004d13:     	addsd	(%rdi,%rdx,8), %xmm1
180004d18:     	movsd	%xmm1, (%rdi,%rdx,8)
180004d1d:     	movq	$0x0, 0x8(%rsi,%rdx,8)
180004d26:     	movq	0x10(%rsi,%rcx,8), %rdx
180004d2b:     	testq	%rdx, %rdx
180004d2e:     	js	0x180004db9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2849>
180004d34:     	movq	0x18(%rsi,%rcx,8), %r8
180004d39:     	testq	%r8, %r8
180004d3c:     	js	0x180004db9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2849>
180004d3e:     	movsd	0x10(%rdi,%r8,8), %xmm1
180004d45:     	mulsd	%xmm0, %xmm1
180004d49:     	addsd	0x10(%rdi,%rdx,8), %xmm1
180004d4f:     	movsd	%xmm1, 0x10(%rdi,%rdx,8)
180004d55:     	movq	$0x0, 0x18(%rsi,%rdx,8)
180004d5e:     	movq	(%rsi,%rcx,8), %rdx
180004d62:     	testq	%rdx, %rdx
180004d65:     	js	0x180004ddd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x286d>
180004d67:     	movq	$0x0, (%rdi,%rdx,8)
180004d6f:     	movq	$0x1, 0x8(%rsi,%rdx,8)
180004d78:     	movq	(%rsi,%rcx,8), %rcx
180004d7c:     	testq	%rcx, %rcx
180004d7f:     	js	0x180004de9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2879>
180004d81:     	movq	$0x0, 0x10(%rdi,%rcx,8)
180004d8a:     	leaq	(%rsi,%rcx,8), %rdx
180004d8e:     	movl	$0x1, %ecx
180004d93:     	jmp	0x180004dc6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2856>
180004d95:     	movb	$0x1, (%r12)
180004d9a:     	movl	$0x5b8d83, %ecx         # imm = 0x5B8D83
180004d9f:     	jmp	0x180004dc3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2853>
180004da1:     	movb	$0x1, (%r12)
180004da6:     	movl	$0x5b8d84, %ecx         # imm = 0x5B8D84
180004dab:     	jmp	0x180004dc3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2853>
180004dad:     	movb	$0x1, (%r12)
180004db2:     	movl	$0x5b8d87, %ecx         # imm = 0x5B8D87
180004db7:     	jmp	0x180004dc3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2853>
180004db9:     	movb	$0x1, (%r12)
180004dbe:     	movl	$0x5b8d88, %ecx         # imm = 0x5B8D88
180004dc3:     	movq	%r15, %rdx
180004dc6:     	movq	%rcx, 0x18(%rdx)
180004dca:     	incq	%rax
180004dcd:     	cmpb	$0x0, (%r12)
180004dd2:     	je	0x180004c3d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26cd>
180004dd8:     	jmp	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004ddd:     	movb	$0x1, (%r12)
180004de2:     	movl	$0x5b8d8b, %ecx         # imm = 0x5B8D8B
180004de7:     	jmp	0x180004dc3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2853>
180004de9:     	movb	$0x1, (%r12)
180004dee:     	movl	$0x5b8d8c, %ecx         # imm = 0x5B8D8C
180004df3:     	jmp	0x180004dc3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2853>
180004df5:     	movq	0x90(%rsp), %rdx
180004dfd:     	movq	0x88(%rsp), %rcx
180004e05:     	movq	%rdx, (%rcx)
180004e08:     	jmp	0x180004784 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2214>
180004e0d:     	movb	$0x1, (%r12)
180004e12:     	movq	$0x12, 0x18(%r15)
180004e1a:     	jmp	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004e1f:     	movb	$0x1, (%r12)
180004e24:     	movq	$0xd, 0x18(%r15)
180004e2c:     	jmp	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004e31:     	movb	$0x1, (%r12)
180004e36:     	movq	$0xe, 0x18(%r15)
180004e3e:     	jmp	0x180004c21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x26b1>
180004e43:     	movq	0x88(%rsp), %rcx
180004e4b:     	movq	$0x0, (%rcx)
180004e52:     	jmp	0x180004784 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2214>
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
180004ebd:     	jne	0x180004ed6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2966>
180004ebf:     	jp	0x180004ed6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2966>
180004ec1:     	movb	$0x1, 0x18(%rcx)
180004ec5:     	movq	$0x0, 0x10(%rcx)
180004ecd:     	movb	$0x1, 0x8(%rcx)
180004ed1:     	jmp	0x180005053 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2ae3>
180004ed6:     	movq	0x1a0(%rsp), %rbx
180004ede:     	movq	0x190(%rsp), %r15
180004ee6:     	movq	0x30(%r9,%r12,8), %rax
180004eeb:     	movq	%rax, %r10
180004eee:     	sarq	$0x3f, %r10
180004ef2:     	andq	%r15, %r10
180004ef5:     	leaq	(%r9,%rax,8), %rdx
180004ef9:     	cmpq	$0x1, (%rdx,%r10,8)
180004efe:     	jne	0x180004f21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x29b1>
180004f00:     	xorl	%r10d, %r10d
180004f03:     	cmpq	$-0x2, %rax
180004f07:     	cmovlq	%r15, %r10
180004f0b:     	movq	0x10(%rdx,%r10,8), %rax
180004f10:     	leaq	(%r9,%rax,8), %rdx
180004f14:     	sarq	$0x3f, %rax
180004f18:     	andq	%r15, %rax
180004f1b:     	cmpq	%rbx, (%rdx,%rax,8)
180004f1f:     	je	0x180004ec1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2951>
180004f21:     	movq	0x188(%rsp), %r14
180004f29:     	movq	0x180(%rsp), %rdi
180004f31:     	movq	0x10(%r9,%r12,8), %rdx
180004f36:     	testq	%rdx, %rdx
180004f39:     	js	0x18000502f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2abf>
180004f3f:     	testq	%rbx, %rbx
180004f42:     	js	0x18000502f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2abf>
180004f48:     	movq	0x10(%r9,%rbx,8), %r10
180004f4d:     	testq	%r10, %r10
180004f50:     	js	0x18000502f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2abf>
180004f56:     	movsd	(%r8,%rdx,8), %xmm1
180004f5c:     	cmpq	$0x0, 0x8(%r9,%rdx,8)
180004f62:     	setne	%r11b
180004f66:     	cmpq	$0x0, 0x8(%r9,%r10,8)
180004f6c:     	setne	%al
180004f6f:     	subsd	(%r8,%r10,8), %xmm1
180004f75:     	andb	%r11b, %al
180004f78:     	cmpb	$0x1, %al
180004f7a:     	jne	0x180004f9e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2a2e>
180004f7c:     	movapd	0x543c(%rip), %xmm2     # 0x18000a3c0
180004f84:     	andpd	%xmm1, %xmm2
180004f88:     	ucomisd	0x5440(%rip), %xmm2     # 0x18000a3d0
180004f90:     	jae	0x18000502f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2abf>
180004f96:     	xorpd	%xmm2, %xmm2
180004f9a:     	addsd	%xmm2, %xmm1
180004f9e:     	movsd	0x10(%r8,%rdx,8), %xmm2
180004fa5:     	cmpq	$0x0, 0x18(%r9,%rdx,8)
180004fab:     	subsd	0x10(%r8,%r10,8), %xmm2
180004fb2:     	je	0x180005089 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b19>
180004fb8:     	cmpq	$0x0, 0x18(%r9,%r10,8)
180004fbe:     	je	0x180005089 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b19>
180004fc4:     	movapd	0x53f4(%rip), %xmm3     # 0x18000a3c0
180004fcc:     	andpd	%xmm2, %xmm3
180004fd0:     	ucomisd	0x53f8(%rip), %xmm3     # 0x18000a3d0
180004fd8:     	jae	0x1800050f1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b81>
180004fde:     	movapd	%xmm1, %xmm3
180004fe2:     	mulsd	%xmm1, %xmm3
180004fe6:     	ucomisd	0x53e2(%rip), %xmm3     # 0x18000a3d0
180004fee:     	setae	%dl
180004ff1:     	testb	%dl, %al
180004ff3:     	jne	0x1800050a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b32>
180004ff9:     	xorpd	%xmm4, %xmm4
180004ffd:     	addsd	%xmm4, %xmm2
180005001:     	movapd	%xmm2, %xmm4
180005005:     	mulsd	%xmm2, %xmm4
180005009:     	ucomisd	0x53bf(%rip), %xmm4     # 0x18000a3d0
180005011:     	jae	0x1800050a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b32>
180005017:     	addsd	%xmm4, %xmm3
18000501b:     	ucomisd	0x53ad(%rip), %xmm3     # 0x18000a3d0
180005023:     	setae	%dl
180005026:     	testb	%dl, %al
180005028:     	jne	0x1800050a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b32>
18000502a:     	jmp	0x1800050bc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b4c>
18000502f:     	movb	$0x1, (%r14)
180005033:     	movq	$0x3d090a, 0x18(%rdi)   # imm = 0x3D090A
18000503b:     	movq	$0x0, 0x18(%rcx)
180005043:     	movq	$0x0, 0x10(%rcx)
18000504b:     	movq	$0x0, 0x8(%rcx)
180005053:     	movq	$0x0, (%rcx)
18000505a:     	xorl	%eax, %eax
18000505c:     	movaps	0xe0(%rsp), %xmm6
180005064:     	movaps	0xf0(%rsp), %xmm7
18000506c:     	movaps	0x100(%rsp), %xmm8
180005075:     	addq	$0x118, %rsp            # imm = 0x118
18000507c:     	popq	%rbx
18000507d:     	popq	%rbp
18000507e:     	popq	%rdi
18000507f:     	popq	%rsi
180005080:     	popq	%r12
180005082:     	popq	%r13
180005084:     	popq	%r14
180005086:     	popq	%r15
180005088:     	retq
180005089:     	movapd	%xmm1, %xmm3
18000508d:     	mulsd	%xmm1, %xmm3
180005091:     	ucomisd	0x5337(%rip), %xmm3     # 0x18000a3d0
180005099:     	setae	%dl
18000509c:     	andb	%dl, %al
18000509e:     	cmpb	$0x1, %al
1800050a0:     	jne	0x1800050b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b40>
1800050a2:     	movb	$0x1, (%r14)
1800050a6:     	movq	$0x3d090c, 0x18(%rdi)   # imm = 0x3D090C
1800050ae:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
1800050b0:     	movapd	%xmm2, %xmm4
1800050b4:     	mulsd	%xmm2, %xmm4
1800050b8:     	addsd	%xmm4, %xmm3
1800050bc:     	xorps	%xmm4, %xmm4
1800050bf:     	sqrtsd	%xmm3, %xmm4
1800050c3:     	cmpq	$0x0, 0x18(%r9,%r12,8)
1800050c9:     	je	0x180005120 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2bb0>
1800050cb:     	movq	(%r9,%r12,8), %rax
1800050cf:     	testq	%rax, %rax
1800050d2:     	js	0x1800050e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b70>
1800050d4:     	xorpd	%xmm5, %xmm5
1800050d8:     	ucomisd	%xmm5, %xmm3
1800050dc:     	jne	0x180005102 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b92>
1800050de:     	jp	0x180005102 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2b92>
1800050e0:     	movb	$0x1, (%r14)
1800050e4:     	movq	$0x3d090f, 0x18(%rdi)   # imm = 0x3D090F
1800050ec:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
1800050f1:     	movb	$0x1, (%r14)
1800050f5:     	movq	$0x3d090b, 0x18(%rdi)   # imm = 0x3D090B
1800050fd:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
180005102:     	movsd	0x1a8(%rsp), %xmm7
18000510b:     	movsd	0x8(%r8,%rax,8), %xmm3
180005112:     	addsd	%xmm3, %xmm3
180005116:     	divsd	%xmm4, %xmm3
18000511a:     	ucomisd	%xmm3, %xmm7
18000511e:     	jbe	0x18000518e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2c1e>
180005120:     	movsd	0x52b0(%rip), %xmm3     # 0x18000a3d8
180005128:     	maxsd	%xmm4, %xmm3
18000512c:     	movapd	%xmm3, %xmm4
180005130:     	mulsd	%xmm3, %xmm4
180005134:     	xorpd	%xmm5, %xmm5
180005138:     	ucomisd	%xmm5, %xmm4
18000513c:     	jne	0x180005151 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2be1>
18000513e:     	jp	0x180005151 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2be1>
180005140:     	movb	$0x1, (%r14)
180005144:     	movq	$0x3d0915, 0x18(%rdi)   # imm = 0x3D0915
18000514c:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
180005151:     	movsd	0x8(%r8,%rbx,8), %xmm5
180005158:     	mulsd	0x5280(%rip), %xmm5     # 0x18000a3e0
180005160:     	mulsd	%xmm5, %xmm0
180005164:     	divsd	%xmm4, %xmm0
180005168:     	mulsd	%xmm0, %xmm1
18000516c:     	divsd	%xmm3, %xmm1
180005170:     	mulsd	%xmm0, %xmm2
180005174:     	divsd	%xmm3, %xmm2
180005178:     	movsd	%xmm2, 0x10(%rcx)
18000517d:     	movsd	%xmm1, (%rcx)
180005181:     	movb	$0x0, 0x18(%rcx)
180005185:     	movb	$0x0, 0x8(%rcx)
180005189:     	jmp	0x18000505a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2aea>
18000518e:     	movq	0x20(%r9,%r12,8), %rax
180005193:     	testq	%rax, %rax
180005196:     	js	0x180005234 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2cc4>
18000519c:     	movq	0x8(%rdi), %rdx
1800051a0:     	leaq	0x1(%rdx), %r10
1800051a4:     	movq	%r10, 0x8(%rdi)
1800051a8:     	cmpq	0x10(%rdi), %rdx
1800051ac:     	jge	0x18000539f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2e2f>
1800051b2:     	movq	%rcx, %rsi
1800051b5:     	movsd	%xmm7, 0x48(%rsp)
1800051bb:     	movq	%rbx, 0x40(%rsp)
1800051c0:     	movq	%rax, 0x38(%rsp)
1800051c5:     	movq	%r15, 0x30(%rsp)
1800051ca:     	movq	%r14, 0x28(%rsp)
1800051cf:     	movq	%rdi, 0x20(%rsp)
1800051d4:     	leaq	0xc0(%rsp), %rcx
1800051dc:     	movq	%r8, %r13
1800051df:     	movq	%r9, %rbp
1800051e2:     	callq	0x180004e60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28f0>
1800051e7:     	cmpb	$0x0, (%r14)
1800051eb:     	jne	0x180005482 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f12>
1800051f1:     	cmpb	$0x0, 0xd8(%rsp)
1800051f9:     	setne	%dl
1800051fc:     	cmpb	$0x0, 0xc8(%rsp)
180005204:     	setne	%r11b
180005208:     	xorpd	%xmm8, %xmm8
18000520d:     	movsd	0xc0(%rsp), %xmm6
180005216:     	addsd	%xmm8, %xmm6
18000521b:     	addsd	0xd0(%rsp), %xmm8
180005225:     	decq	0x8(%rdi)
180005229:     	movq	%rsi, %rcx
18000522c:     	movq	%r13, %r8
18000522f:     	movq	%rbp, %r9
180005232:     	jmp	0x180005242 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2cd2>
180005234:     	movb	$0x1, %r11b
180005237:     	xorpd	%xmm6, %xmm6
18000523b:     	xorpd	%xmm8, %xmm8
180005240:     	movb	$0x1, %dl
180005242:     	movq	0x28(%r9,%r12,8), %rax
180005247:     	testq	%rax, %rax
18000524a:     	js	0x1800052f3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2d83>
180005250:     	movl	%edx, %ebp
180005252:     	movq	0x8(%rdi), %rdx
180005256:     	leaq	0x1(%rdx), %r10
18000525a:     	movq	%r10, 0x8(%rdi)
18000525e:     	cmpq	0x10(%rdi), %rdx
180005262:     	jge	0x1800053b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2e40>
180005268:     	movb	%r11b, 0x58(%rsp)
18000526d:     	movq	%rcx, %rsi
180005270:     	movsd	%xmm7, 0x48(%rsp)
180005276:     	movq	%rbx, 0x40(%rsp)
18000527b:     	movq	%rax, 0x38(%rsp)
180005280:     	movq	%r15, 0x30(%rsp)
180005285:     	movq	%r14, 0x28(%rsp)
18000528a:     	movq	%rdi, 0x20(%rsp)
18000528f:     	leaq	0xa0(%rsp), %rcx
180005297:     	movq	%r8, 0x50(%rsp)
18000529c:     	movq	%r9, %r13
18000529f:     	callq	0x180004e60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28f0>
1800052a4:     	cmpb	$0x0, (%r14)
1800052a8:     	jne	0x180005482 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f12>
1800052ae:     	cmpb	$0x0, 0xb8(%rsp)
1800052b6:     	setne	%al
1800052b9:     	cmpb	$0x0, 0xa8(%rsp)
1800052c1:     	setne	%cl
1800052c4:     	addsd	0xa0(%rsp), %xmm6
1800052cd:     	addsd	0xb0(%rsp), %xmm8
1800052d7:     	decq	0x8(%rdi)
1800052db:     	movzbl	0x58(%rsp), %r11d
1800052e1:     	andb	%cl, %r11b
1800052e4:     	movl	%ebp, %edx
1800052e6:     	andb	%al, %dl
1800052e8:     	movq	%rsi, %rcx
1800052eb:     	movq	0x50(%rsp), %r8
1800052f0:     	movq	%r13, %r9
1800052f3:     	movq	0x38(%r9,%r12,8), %rax
1800052f8:     	testq	%rax, %rax
1800052fb:     	js	0x1800053c1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2e51>
180005301:     	movl	%edx, %r13d
180005304:     	movq	0x8(%rdi), %rdx
180005308:     	leaq	0x1(%rdx), %r10
18000530c:     	movq	%r10, 0x8(%rdi)
180005310:     	cmpq	0x10(%rdi), %rdx
180005314:     	jge	0x180005465 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2ef5>
18000531a:     	movl	%r11d, %ebp
18000531d:     	movq	%rcx, %rsi
180005320:     	movsd	%xmm7, 0x48(%rsp)
180005326:     	movq	%rbx, 0x40(%rsp)
18000532b:     	movq	%rax, 0x38(%rsp)
180005330:     	movq	%r15, 0x30(%rsp)
180005335:     	movq	%r14, 0x28(%rsp)
18000533a:     	movq	%rdi, 0x20(%rsp)
18000533f:     	leaq	0x80(%rsp), %rcx
180005347:     	movq	%r8, 0x50(%rsp)
18000534c:     	movq	%r9, 0x58(%rsp)
180005351:     	callq	0x180004e60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28f0>
180005356:     	cmpb	$0x0, (%r14)
18000535a:     	jne	0x180005482 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f12>
180005360:     	cmpb	$0x0, 0x98(%rsp)
180005368:     	setne	%al
18000536b:     	cmpb	$0x0, 0x88(%rsp)
180005373:     	setne	%cl
180005376:     	addsd	0x80(%rsp), %xmm6
18000537f:     	addsd	0x90(%rsp), %xmm8
180005389:     	decq	0x8(%rdi)
18000538d:     	movl	%ebp, %r11d
180005390:     	andb	%cl, %r11b
180005393:     	movl	%r13d, %edx
180005396:     	andb	%al, %dl
180005398:     	movq	0x58(%rsp), %r9
18000539d:     	jmp	0x1800053c9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2e59>
18000539f:     	movb	$0x1, (%r14)
1800053a3:     	movq	$0x3d0921, 0x18(%rdi)   # imm = 0x3D0921
1800053ab:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
1800053b0:     	movb	$0x1, (%r14)
1800053b4:     	movq	$0x3d0926, 0x18(%rdi)   # imm = 0x3D0926
1800053bc:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
1800053c1:     	movq	%r8, 0x50(%rsp)
1800053c6:     	movq	%rcx, %rsi
1800053c9:     	movq	0x40(%r9,%r12,8), %rax
1800053ce:     	testq	%rax, %rax
1800053d1:     	js	0x18000544f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2edf>
1800053d3:     	movl	%edx, %r12d
1800053d6:     	movq	0x8(%rdi), %rcx
1800053da:     	leaq	0x1(%rcx), %rdx
1800053de:     	movq	%rdx, 0x8(%rdi)
1800053e2:     	cmpq	0x10(%rdi), %rcx
1800053e6:     	jge	0x180005476 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f06>
1800053ec:     	movl	%r11d, %ebp
1800053ef:     	movsd	%xmm7, 0x48(%rsp)
1800053f5:     	movq	%rbx, 0x40(%rsp)
1800053fa:     	movq	%rax, 0x38(%rsp)
1800053ff:     	movq	%r15, 0x30(%rsp)
180005404:     	movq	%r14, 0x28(%rsp)
180005409:     	movq	%rdi, 0x20(%rsp)
18000540e:     	leaq	0x60(%rsp), %rcx
180005413:     	movq	0x50(%rsp), %r8
180005418:     	callq	0x180004e60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x28f0>
18000541d:     	cmpb	$0x0, (%r14)
180005421:     	jne	0x180005482 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f12>
180005423:     	cmpb	$0x0, 0x78(%rsp)
180005428:     	setne	%al
18000542b:     	cmpb	$0x0, 0x68(%rsp)
180005430:     	setne	%cl
180005433:     	addsd	0x60(%rsp), %xmm6
180005439:     	addsd	0x70(%rsp), %xmm8
180005440:     	decq	0x8(%rdi)
180005444:     	movl	%ebp, %r11d
180005447:     	andb	%cl, %r11b
18000544a:     	movl	%r12d, %edx
18000544d:     	andb	%al, %dl
18000544f:     	movb	%dl, 0x18(%rsi)
180005452:     	movsd	%xmm8, 0x10(%rsi)
180005458:     	movb	%r11b, 0x8(%rsi)
18000545c:     	movsd	%xmm6, (%rsi)
180005460:     	jmp	0x18000505a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2aea>
180005465:     	movb	$0x1, (%r14)
180005469:     	movq	$0x3d092b, 0x18(%rdi)   # imm = 0x3D092B
180005471:     	jmp	0x18000503b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2acb>
180005476:     	movb	$0x1, (%r14)
18000547a:     	movq	$0x3d0930, 0x18(%rdi)   # imm = 0x3D0930
180005482:     	movq	$0x0, 0x18(%rsi)
18000548a:     	movq	$0x0, 0x10(%rsi)
180005492:     	movq	$0x0, 0x8(%rsi)
18000549a:     	movq	$0x0, (%rsi)
1800054a1:     	jmp	0x18000505a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2aea>
1800054a6:     	nopw	%cs:(%rax,%rax)
1800054b0:     	pushq	%r15
1800054b2:     	pushq	%r14
1800054b4:     	pushq	%r13
1800054b6:     	pushq	%r12
1800054b8:     	pushq	%rsi
1800054b9:     	pushq	%rdi
1800054ba:     	pushq	%rbp
1800054bb:     	pushq	%rbx
1800054bc:     	subq	$0x158, %rsp            # imm = 0x158
1800054c3:     	movq	0x1d8(%rsp), %rax
1800054cb:     	movq	0x1d0(%rsp), %r13
1800054d3:     	movq	0x1c8(%rsp), %r15
1800054db:     	movq	0x1c0(%rsp), %r12
1800054e3:     	movb	$0x0, 0x6f(%rsp)
1800054e8:     	movq	$0x0, 0xe8(%rsp)
1800054f4:     	movb	$0x0, 0x5f(%rsp)
1800054f9:     	movq	$0x0, 0xe0(%rsp)
180005505:     	movb	$0x0, 0x5e(%rsp)
18000550a:     	movq	$0x0, 0xd8(%rsp)
180005516:     	movb	$0x0, 0x5d(%rsp)
18000551b:     	movq	$0x0, 0xd0(%rsp)
180005527:     	movb	$0x0, 0x5c(%rsp)
18000552c:     	movq	$0x0, 0xc8(%rsp)
180005538:     	movb	$0x0, 0x6e(%rsp)
18000553d:     	movq	$0x0, 0xc0(%rsp)
180005549:     	movb	$0x0, 0x6d(%rsp)
18000554e:     	movq	$0x0, 0xb8(%rsp)
18000555a:     	movb	$0x0, 0x6c(%rsp)
18000555f:     	movq	$0x0, 0xb0(%rsp)
18000556b:     	movb	$0x0, 0x6b(%rsp)
180005570:     	movq	$0x0, 0xa8(%rsp)
18000557c:     	cmpq	$0x1, %rax
180005580:     	je	0x180005628 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30b8>
180005586:     	testq	%rax, %rax
180005589:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000558f:     	movq	0x1e0(%rsp), %rbx
180005597:     	movq	(%r9,%rbx,8), %rax
18000559b:     	testq	%rax, %rax
18000559e:     	js	0x180005654 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30e4>
1800055a4:     	movq	0x1e8(%rsp), %r14
1800055ac:     	testq	%r14, %r14
1800055af:     	js	0x180005654 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30e4>
1800055b5:     	movq	0x10(%r9,%r14,8), %r11
1800055ba:     	testq	%r11, %r11
1800055bd:     	js	0x1800056e6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3176>
1800055c3:     	movsd	(%r8,%r11,8), %xmm0
1800055c9:     	movsd	0x8(%r8,%rax,8), %xmm2
1800055d0:     	movsd	0x10(%r8,%rax,8), %xmm1
1800055d7:     	movapd	%xmm1, %xmm3
1800055db:     	subsd	%xmm2, %xmm3
1800055df:     	xorl	%r10d, %r10d
1800055e2:     	ucomisd	%xmm3, %xmm0
1800055e6:     	jb	0x180005708 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3198>
1800055ec:     	addsd	%xmm2, %xmm1
1800055f0:     	ucomisd	%xmm0, %xmm1
1800055f4:     	jbe	0x180005708 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3198>
1800055fa:     	movsd	0x10(%r8,%r11,8), %xmm0
180005601:     	movsd	(%r8,%rax,8), %xmm1
180005607:     	movsd	0x18(%r8,%rax,8), %xmm2
18000560e:     	movapd	%xmm2, %xmm3
180005612:     	subsd	%xmm1, %xmm3
180005616:     	ucomisd	%xmm3, %xmm0
18000561a:     	jae	0x1800056fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x318c>
180005620:     	xorl	%r10d, %r10d
180005623:     	jmp	0x180005708 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3198>
180005628:     	movq	0x1f0(%rsp), %rbp
180005630:     	testq	%rbp, %rbp
180005633:     	js	0x180005666 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30f6>
180005635:     	movq	(%r9,%rbp,8), %rax
180005639:     	testq	%rax, %rax
18000563c:     	js	0x180005666 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30f6>
18000563e:     	movq	(%r12), %r10
180005642:     	leaq	0x4(%r10), %r11
180005646:     	cmpq	%r13, %r11
180005649:     	jle	0x180005678 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3108>
18000564b:     	movb	$0x2, (%r15)
18000564f:     	jmp	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005654:     	movb	$0x1, (%r15)
180005658:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
180005661:     	jmp	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005666:     	movb	$0x1, (%r15)
18000566a:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
180005673:     	jmp	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005678:     	movsd	0x10(%r8,%rax,8), %xmm2
18000567f:     	movsd	0x18(%r8,%rax,8), %xmm1
180005686:     	movsd	0x4d22(%rip), %xmm0     # 0x18000a3b0
18000568e:     	movsd	0x8(%r8,%rax,8), %xmm3
180005695:     	mulsd	%xmm0, %xmm3
180005699:     	mulsd	(%r8,%rax,8), %xmm0
18000569f:     	movq	%r11, (%r12)
1800056a3:     	cmpb	$0x0, (%r15)
1800056a7:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
1800056ad:     	movapd	%xmm2, %xmm4
1800056b1:     	addsd	%xmm3, %xmm4
1800056b5:     	movapd	%xmm1, %xmm5
1800056b9:     	subsd	%xmm0, %xmm5
1800056bd:     	testq	%r10, %r10
1800056c0:     	js	0x180005819 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x32a9>
1800056c6:     	movsd	%xmm4, 0x10(%r8,%r10,8)
1800056cd:     	movsd	%xmm5, 0x18(%r8,%r10,8)
1800056d4:     	movsd	%xmm3, 0x8(%r8,%r10,8)
1800056db:     	movsd	%xmm0, (%r8,%r10,8)
1800056e1:     	jmp	0x180005826 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x32b6>
1800056e6:     	movb	$0x1, (%r15)
1800056ea:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
1800056f3:     	cmpb	$0x0, (%r15)
1800056f7:     	jmp	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
1800056fc:     	addsd	%xmm1, %xmm2
180005700:     	ucomisd	%xmm0, %xmm2
180005704:     	seta	%r10b
180005708:     	cmpb	$0x0, (%r15)
18000570c:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005712:     	testb	%r10b, %r10b
180005715:     	je	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000571b:     	movq	0x18(%r9,%rbx,8), %r11
180005720:     	movq	0x30(%r9,%rbx,8), %r10
180005725:     	movq	%r10, %rsi
180005728:     	sarq	$0x3f, %rsi
18000572c:     	andq	%r13, %rsi
18000572f:     	leaq	(%r9,%r10,8), %rbp
180005733:     	movq	(%rbp,%rsi,8), %rdi
180005738:     	cmpq	0x8(%r9,%rbx,8), %rdi
18000573d:     	jge	0x180005940 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x33d0>
180005743:     	testq	%r11, %r11
180005746:     	jne	0x180005949 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x33d9>
18000574c:     	xorl	%eax, %eax
18000574e:     	cmpq	$-0x1, %r10
180005752:     	cmovlq	%r13, %rax
180005756:     	cmpq	0x8(%rbp,%rax,8), %rdi
18000575b:     	jne	0x180005e9b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x392b>
180005761:     	leaq	(%rdi,%rdi), %rdx
180005765:     	testq	%rdi, %rdi
180005768:     	movl	$0x4, %r11d
18000576e:     	cmovneq	%rdx, %r11
180005772:     	movq	(%r12), %rdx
180005776:     	movq	%rdx, 0x78(%rsp)
18000577b:     	movq	0x78(%rsp), %rdx
180005780:     	addq	%r11, %rdx
180005783:     	cmpq	%r13, %rdx
180005786:     	jg	0x18000564b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30db>
18000578c:     	movq	%rdx, (%r12)
180005790:     	cmpb	$0x0, (%r15)
180005794:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000579a:     	movq	%rbp, 0x90(%rsp)
1800057a2:     	movq	%r11, 0x100(%rsp)
1800057aa:     	movq	%rax, 0x108(%rsp)
1800057b2:     	xorl	%eax, %eax
1800057b4:     	movq	%r10, 0xf8(%rsp)
1800057bc:     	cmpq	$-0x2, %r10
1800057c0:     	cmovlq	%r13, %rax
1800057c4:     	movq	%rax, 0x98(%rsp)
1800057cc:     	testq	%rdi, %rdi
1800057cf:     	jle	0x180005e64 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x38f4>
1800057d5:     	movq	0x98(%rsp), %rax
1800057dd:     	movq	0x90(%rsp), %rdx
1800057e5:     	movq	0x10(%rdx,%rax,8), %r11
1800057ea:     	movl	%edi, %eax
1800057ec:     	andl	$0x7, %eax
1800057ef:     	movq	%rax, 0x80(%rsp)
1800057f7:     	cmpq	$0x7, %rdi
1800057fb:     	ja	0x180005b51 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35e1>
180005801:     	leaq	(,%r13,8), %rax
180005809:     	movq	%rax, 0xa0(%rsp)
180005811:     	xorl	%r10d, %r10d
180005814:     	jmp	0x180005e0d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x389d>
180005819:     	movb	$0x1, (%r15)
18000581d:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180005826:     	cmpb	$0x0, (%r15)
18000582a:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005830:     	movq	(%r12), %rax
180005834:     	leaq	0xb(%rax), %rsi
180005838:     	cmpq	%r13, %rsi
18000583b:     	jg	0x18000564b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30db>
180005841:     	movq	0x8(%r9,%rbp,8), %r11
180005846:     	movq	%rsi, (%r12)
18000584a:     	cmpb	$0x0, (%r15)
18000584e:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005854:     	movq	%r10, (%r9,%rax,8)
180005858:     	movq	%r11, 0x8(%r9,%rax,8)
18000585d:     	movq	(%r12), %r11
180005861:     	cmpq	%r13, %r11
180005864:     	movq	%r11, %r10
180005867:     	jle	0x180005874 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3304>
180005869:     	movb	$0x2, (%r15)
18000586d:     	movq	(%r12), %r11
180005871:     	xorl	%r10d, %r10d
180005874:     	leaq	0x3(%r11), %rsi
180005878:     	cmpq	%r13, %rsi
18000587b:     	jg	0x18000564b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30db>
180005881:     	movq	%rsi, (%r12)
180005885:     	cmpb	$0x0, (%r15)
180005889:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000588f:     	movq	%r11, %rsi
180005892:     	sarq	$0x3f, %rsi
180005896:     	andq	%r13, %rsi
180005899:     	leaq	(%r9,%r11,8), %rdi
18000589d:     	movq	$0x0, (%rdi,%rsi,8)
1800058a5:     	xorl	%esi, %esi
1800058a7:     	cmpq	$-0x1, %r11
1800058ab:     	movl	$0x0, %ebx
1800058b0:     	cmovlq	%r13, %rbx
1800058b4:     	movq	$0x0, 0x8(%rdi,%rbx,8)
1800058bd:     	cmpq	$-0x2, %r11
1800058c1:     	cmovlq	%r13, %rsi
1800058c5:     	movq	%r10, 0x10(%rdi,%rsi,8)
1800058ca:     	cmpb	$0x0, (%r15)
1800058ce:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
1800058d4:     	leaq	(%r9,%rax,8), %r10
1800058d8:     	movq	%r11, 0x30(%r10)
1800058dc:     	movq	$0x0, 0x18(%r10)
1800058e4:     	movq	(%r12), %r11
1800058e8:     	leaq	0x4(%r11), %rsi
1800058ec:     	cmpq	%r13, %rsi
1800058ef:     	jg	0x18000564b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x30db>
1800058f5:     	movq	%rsi, (%r12)
1800058f9:     	cmpb	$0x0, (%r15)
1800058fd:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005903:     	movq	%rdx, %r14
180005906:     	movq	%r8, %rdi
180005909:     	movq	%r9, %rsi
18000590c:     	movq	%rcx, %rbx
18000590f:     	testq	%r11, %r11
180005912:     	js	0x180006132 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3bc2>
180005918:     	movq	$0x0, (%rdi,%r11,8)
180005920:     	leaq	(%rsi,%r11,8), %rcx
180005924:     	movq	$0x1, 0x8(%rsi,%r11,8)
18000592d:     	movq	$0x0, 0x10(%rdi,%r11,8)
180005936:     	movl	$0x1, %edx
18000593b:     	jmp	0x18000613e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3bce>
180005940:     	testq	%r11, %r11
180005943:     	je	0x1800059dd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x346d>
180005949:     	movq	0x20(%r9,%rbx,8), %rax
18000594e:     	testq	%rax, %rax
180005951:     	js	0x180005a74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3504>
180005957:     	movq	0x8(%r12), %r10
18000595c:     	leaq	0x1(%r10), %r11
180005960:     	movq	%r11, 0x8(%r12)
180005965:     	cmpq	0x10(%r12), %r10
18000596a:     	jge	0x180005a74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3504>
180005970:     	movq	%rdx, 0x60(%rsp)
180005975:     	movq	%rcx, %rbp
180005978:     	movb	$0x0, 0x5f(%rsp)
18000597d:     	movq	%r14, 0x48(%rsp)
180005982:     	movq	%rax, 0x40(%rsp)
180005987:     	movq	%r13, 0x30(%rsp)
18000598c:     	movq	%r15, 0x28(%rsp)
180005991:     	movq	%r12, 0x20(%rsp)
180005996:     	movq	$-0x1, 0x50(%rsp)
18000599f:     	movq	$0x0, 0x38(%rsp)
1800059a8:     	leaq	0x5f(%rsp), %rcx
1800059ad:     	leaq	0xe0(%rsp), %rdx
1800059b5:     	movq	%r8, %rdi
1800059b8:     	movq	%r9, %rsi
1800059bb:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
1800059c0:     	testl	%eax, %eax
1800059c2:     	jne	0x18000606c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3afc>
1800059c8:     	cmpb	$0x0, (%r15)
1800059cc:     	movq	%rbp, %rax
1800059cf:     	je	0x180005aa9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3539>
1800059d5:     	movb	$0x0, (%rax)
1800059d8:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
1800059dd:     	movq	0x8(%r12), %rax
1800059e2:     	leaq	0x1(%rax), %r10
1800059e6:     	movq	%r10, 0x8(%r12)
1800059eb:     	cmpq	0x10(%r12), %rax
1800059f0:     	jge	0x180005a9a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x352a>
1800059f6:     	movq	%rdx, %rsi
1800059f9:     	movq	%rcx, %rdi
1800059fc:     	movq	%rbx, 0x50(%rsp)
180005a01:     	movq	%r13, 0x30(%rsp)
180005a06:     	movq	%r15, 0x28(%rsp)
180005a0b:     	movq	%r12, 0x20(%rsp)
180005a10:     	movq	$-0x1, 0x48(%rsp)
180005a19:     	movq	$-0x1, 0x40(%rsp)
180005a22:     	movq	$0x1, 0x38(%rsp)
180005a2b:     	leaq	0x6f(%rsp), %rcx
180005a30:     	leaq	0xe8(%rsp), %rdx
180005a38:     	movq	%r8, 0x60(%rsp)
180005a3d:     	movq	%r9, %rbp
180005a40:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
180005a45:     	testl	%eax, %eax
180005a47:     	jne	0x180006081 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3b11>
180005a4d:     	cmpb	$0x0, (%r15)
180005a51:     	movq	%rdi, %rcx
180005a54:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005a56:     	movq	%rsi, %rdx
180005a59:     	decq	0x8(%r12)
180005a5e:     	movq	%rbp, %r9
180005a61:     	movq	0x60(%rsp), %r8
180005a66:     	movq	0x20(%r9,%rbx,8), %rax
180005a6b:     	testq	%rax, %rax
180005a6e:     	jns	0x180005957 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x33e7>
180005a74:     	movb	$0x1, (%r15)
180005a78:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
180005a81:     	movb	$0x0, (%rcx)
180005a84:     	xorl	%eax, %eax
180005a86:     	addq	$0x158, %rsp            # imm = 0x158
180005a8d:     	popq	%rbx
180005a8e:     	popq	%rbp
180005a8f:     	popq	%rdi
180005a90:     	popq	%rsi
180005a91:     	popq	%r12
180005a93:     	popq	%r13
180005a95:     	popq	%r14
180005a97:     	popq	%r15
180005a99:     	retq
180005a9a:     	movb	$0x1, (%r15)
180005a9e:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
180005aa7:     	jmp	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005aa9:     	movzbl	0x5f(%rsp), %ecx
180005aae:     	movq	0x8(%r12), %rdx
180005ab3:     	leaq	-0x1(%rdx), %r8
180005ab7:     	movq	%r8, 0x8(%r12)
180005abc:     	testb	$0x1, %cl
180005abf:     	je	0x180005ac6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3556>
180005ac1:     	movb	$0x1, (%rax)
180005ac4:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
180005ac6:     	movq	0x28(%rsi,%rbx,8), %rcx
180005acb:     	testq	%rcx, %rcx
180005ace:     	js	0x180005adc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x356c>
180005ad0:     	movq	%rdx, 0x8(%r12)
180005ad5:     	cmpq	0x10(%r12), %rdx
180005ada:     	jle	0x180005aee <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x357e>
180005adc:     	movb	$0x1, (%r15)
180005ae0:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180005ae9:     	jmp	0x1800059d5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3465>
180005aee:     	movq	%rsi, %r9
180005af1:     	movb	$0x0, 0x5e(%rsp)
180005af6:     	movq	%r14, 0x48(%rsp)
180005afb:     	movq	%rcx, 0x40(%rsp)
180005b00:     	movq	%r13, 0x30(%rsp)
180005b05:     	movq	%r15, 0x28(%rsp)
180005b0a:     	movq	%r12, 0x20(%rsp)
180005b0f:     	movq	$-0x1, 0x50(%rsp)
180005b18:     	movq	$0x0, 0x38(%rsp)
180005b21:     	leaq	0x5e(%rsp), %rcx
180005b26:     	leaq	0xd8(%rsp), %rdx
180005b2e:     	movq	%rdi, %r8
180005b31:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
180005b36:     	testl	%eax, %eax
180005b38:     	jne	0x1800061a9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c39>
180005b3e:     	cmpb	$0x0, (%r15)
180005b42:     	je	0x180006005 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a95>
180005b48:     	movb	$0x0, (%rbp)
180005b4c:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
180005b51:     	movabsq	$0x7ffffffffffffff8, %r10 # imm = 0x7FFFFFFFFFFFFFF8
180005b5b:     	movq	%rdi, 0xf0(%rsp)
180005b63:     	andq	%rdi, %r10
180005b66:     	leaq	(%r9,%r11,8), %rax
180005b6a:     	movq	%rax, 0x60(%rsp)
180005b6f:     	movq	0x78(%rsp), %rax
180005b74:     	leaq	(%r9,%rax,8), %rax
180005b78:     	movq	%rax, 0x70(%rsp)
180005b7d:     	leaq	(,%r13,8), %rax
180005b85:     	movq	%rax, 0xa0(%rsp)
180005b8d:     	xorl	%edx, %edx
180005b8f:     	movq	%r11, 0x118(%rsp)
180005b97:     	movq	%r10, 0x110(%rsp)
180005b9f:     	leaq	(%r11,%rdx), %rbp
180005ba3:     	movq	%rbp, %r11
180005ba6:     	sarq	$0x3f, %r11
180005baa:     	leaq	(,%r13,8), %rax
180005bb2:     	andq	%rax, %r11
180005bb5:     	movq	0x60(%rsp), %r10
180005bba:     	addq	%r10, %r11
180005bbd:     	movq	(%r11,%rdx,8), %r11
180005bc1:     	movq	%r11, 0x88(%rsp)
180005bc9:     	movq	0x78(%rsp), %r11
180005bce:     	leaq	(%r11,%rdx), %rdi
180005bd2:     	movq	%rdi, %r11
180005bd5:     	sarq	$0x3f, %r11
180005bd9:     	andq	%rax, %r11
180005bdc:     	addq	0x70(%rsp), %r11
180005be1:     	movq	0x88(%rsp), %rax
180005be9:     	movq	%rax, (%r11,%rdx,8)
180005bed:     	movq	%rbp, %r11
180005bf0:     	incq	%r11
180005bf3:     	movl	$0x8, %r11d
180005bf9:     	leaq	0x8(,%r13,8), %rax
180005c01:     	movq	%rax, 0x148(%rsp)
180005c09:     	cmovsq	%rax, %r11
180005c0d:     	addq	%r10, %r11
180005c10:     	movq	(%r11,%rdx,8), %r11
180005c14:     	movq	%rdi, %rax
180005c17:     	incq	%rax
180005c1a:     	movl	$0x8, %eax
180005c1f:     	cmovsq	0x148(%rsp), %rax
180005c28:     	addq	0x70(%rsp), %rax
180005c2d:     	movq	%r11, (%rax,%rdx,8)
180005c31:     	movq	%rbp, %rax
180005c34:     	addq	$0x2, %rax
180005c38:     	movl	$0x10, %eax
180005c3d:     	leaq	0x10(,%r13,8), %r11
180005c45:     	movq	%r11, 0x140(%rsp)
180005c4d:     	cmovsq	%r11, %rax
180005c51:     	addq	%r10, %rax
180005c54:     	movq	(%rax,%rdx,8), %rax
180005c58:     	movq	%rdi, %r11
180005c5b:     	addq	$0x2, %r11
180005c5f:     	movl	$0x10, %r11d
180005c65:     	cmovsq	0x140(%rsp), %r11
180005c6e:     	movq	0x70(%rsp), %r10
180005c73:     	addq	%r10, %r11
180005c76:     	movq	%rax, (%r11,%rdx,8)
180005c7a:     	movq	%rbp, %rax
180005c7d:     	addq	$0x3, %rax
180005c81:     	movl	$0x18, %eax
180005c86:     	leaq	0x18(,%r13,8), %r11
180005c8e:     	movq	%r11, 0x138(%rsp)
180005c96:     	cmovsq	%r11, %rax
180005c9a:     	addq	0x60(%rsp), %rax
180005c9f:     	movq	(%rax,%rdx,8), %rax
180005ca3:     	movq	%rdi, %r11
180005ca6:     	addq	$0x3, %r11
180005caa:     	movl	$0x18, %r11d
180005cb0:     	cmovsq	0x138(%rsp), %r11
180005cb9:     	addq	%r10, %r11
180005cbc:     	movq	%rax, (%r11,%rdx,8)
180005cc0:     	movq	%rbp, %rax
180005cc3:     	addq	$0x4, %rax
180005cc7:     	movl	$0x20, %eax
180005ccc:     	leaq	0x20(,%r13,8), %r11
180005cd4:     	movq	%r11, 0x130(%rsp)
180005cdc:     	cmovsq	%r11, %rax
180005ce0:     	movq	0x60(%rsp), %r10
180005ce5:     	addq	%r10, %rax
180005ce8:     	movq	(%rax,%rdx,8), %rax
180005cec:     	movq	%rdi, %r11
180005cef:     	addq	$0x4, %r11
180005cf3:     	movl	$0x20, %r11d
180005cf9:     	cmovsq	0x130(%rsp), %r11
180005d02:     	addq	0x70(%rsp), %r11
180005d07:     	movq	%rax, (%r11,%rdx,8)
180005d0b:     	movq	%rbp, %rax
180005d0e:     	addq	$0x5, %rax
180005d12:     	movl	$0x28, %eax
180005d17:     	leaq	0x28(,%r13,8), %r11
180005d1f:     	movq	%r11, 0x128(%rsp)
180005d27:     	cmovsq	%r11, %rax
180005d2b:     	addq	%r10, %rax
180005d2e:     	movq	(%rax,%rdx,8), %rax
180005d32:     	movq	%rdi, %r11
180005d35:     	addq	$0x5, %r11
180005d39:     	movl	$0x28, %r11d
180005d3f:     	cmovsq	0x128(%rsp), %r11
180005d48:     	movq	0x70(%rsp), %r10
180005d4d:     	addq	%r10, %r11
180005d50:     	movq	%rax, (%r11,%rdx,8)
180005d54:     	movq	%rbp, %rax
180005d57:     	addq	$0x6, %rax
180005d5b:     	movl	$0x30, %eax
180005d60:     	leaq	0x30(,%r13,8), %r11
180005d68:     	movq	%r11, 0x120(%rsp)
180005d70:     	cmovsq	%r11, %rax
180005d74:     	addq	0x60(%rsp), %rax
180005d79:     	movq	(%rax,%rdx,8), %rax
180005d7d:     	movq	%rdi, %r11
180005d80:     	addq	$0x6, %r11
180005d84:     	movl	$0x30, %r11d
180005d8a:     	cmovsq	0x120(%rsp), %r11
180005d93:     	addq	%r10, %r11
180005d96:     	movq	%rax, (%r11,%rdx,8)
180005d9a:     	addq	$0x7, %rbp
180005d9e:     	movl	$0x38, %eax
180005da3:     	leaq	0x38(,%r13,8), %r11
180005dab:     	movq	%r11, 0x150(%rsp)
180005db3:     	cmovsq	%r11, %rax
180005db7:     	addq	0x60(%rsp), %rax
180005dbc:     	movq	0x110(%rsp), %rbp
180005dc4:     	movq	(%rax,%rdx,8), %rax
180005dc8:     	addq	$0x7, %rdi
180005dcc:     	movl	$0x38, %r11d
180005dd2:     	cmovsq	0x150(%rsp), %r11
180005ddb:     	addq	%r10, %r11
180005dde:     	movq	%rax, (%r11,%rdx,8)
180005de2:     	movq	0x118(%rsp), %r11
180005dea:     	addq	$0x8, %rdx
180005dee:     	cmpq	%rdx, %rbp
180005df1:     	jne	0x180005b9f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x362f>
180005df7:     	movq	%rbp, %r10
180005dfa:     	cmpq	$0x0, 0x80(%rsp)
180005e03:     	movq	0xf0(%rsp), %rdi
180005e0b:     	je	0x180005e64 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x38f4>
180005e0d:     	movq	0x78(%rsp), %rax
180005e12:     	leaq	(%r10,%rax), %rdx
180005e16:     	addq	%r10, %r11
180005e19:     	movq	0xa0(%rsp), %r10
180005e21:     	movq	%r11, %rax
180005e24:     	sarq	$0x3f, %rax
180005e28:     	andq	%r10, %rax
180005e2b:     	addq	%r9, %rax
180005e2e:     	movq	(%rax,%r11,8), %rax
180005e32:     	movq	%r11, %rbp
180005e35:     	movq	%rdx, %r11
180005e38:     	sarq	$0x3f, %r11
180005e3c:     	andq	%r10, %r11
180005e3f:     	addq	%r9, %r11
180005e42:     	movq	%rax, (%r11,%rdx,8)
180005e46:     	movq	%rbp, %r11
180005e49:     	movq	0x80(%rsp), %rax
180005e51:     	incq	%rdx
180005e54:     	incq	%r11
180005e57:     	decq	%rax
180005e5a:     	movq	%rax, 0x80(%rsp)
180005e62:     	jne	0x180005e21 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x38b1>
180005e64:     	movq	0x108(%rsp), %rax
180005e6c:     	movq	0x100(%rsp), %rdx
180005e74:     	movq	0x90(%rsp), %rbp
180005e7c:     	movq	%rdx, 0x8(%rbp,%rax,8)
180005e81:     	movq	0x78(%rsp), %rax
180005e86:     	movq	0x98(%rsp), %rdx
180005e8e:     	movq	%rax, 0x10(%rbp,%rdx,8)
180005e93:     	movq	0xf8(%rsp), %r10
180005e9b:     	leaq	0x1(%rdi), %rax
180005e9f:     	movq	%rax, (%rbp,%rsi,8)
180005ea4:     	cmpb	$0x0, (%r15)
180005ea8:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
180005eae:     	xorl	%eax, %eax
180005eb0:     	cmpq	$-0x2, %r10
180005eb4:     	cmovlq	%r13, %rax
180005eb8:     	addq	0x10(%rbp,%rax,8), %rdi
180005ebd:     	movq	%rdi, %rax
180005ec0:     	sarq	$0x3f, %rax
180005ec4:     	andq	%r13, %rax
180005ec7:     	leaq	(%r9,%rdi,8), %rdx
180005ecb:     	movq	%r14, (%rdx,%rax,8)
180005ecf:     	movsd	0x48(%r8,%rbx,8), %xmm1
180005ed6:     	movsd	0x8(%r8,%r14,8), %xmm2
180005edd:     	movapd	%xmm1, %xmm0
180005ee1:     	addsd	%xmm2, %xmm0
180005ee5:     	xorpd	%xmm3, %xmm3
180005ee9:     	ucomisd	%xmm3, %xmm0
180005eed:     	jbe	0x180005fe4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a74>
180005ef3:     	movq	0x10(%r9,%rbx,8), %rax
180005ef8:     	testq	%rax, %rax
180005efb:     	js	0x180005ff6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a86>
180005f01:     	cmpq	$0x0, 0x8(%r9,%rax,8)
180005f07:     	mulsd	(%r8,%rax,8), %xmm1
180005f0d:     	je	0x180005f39 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x39c9>
180005f0f:     	cmpq	$0x0, 0x50(%r9,%rbx,8)
180005f15:     	je	0x180005f39 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x39c9>
180005f17:     	movapd	0x44a1(%rip), %xmm3     # 0x18000a3c0
180005f1f:     	andpd	%xmm1, %xmm3
180005f23:     	ucomisd	0x44a5(%rip), %xmm3     # 0x18000a3d0
180005f2b:     	jae	0x180005ff6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a86>
180005f31:     	xorpd	%xmm3, %xmm3
180005f35:     	addsd	%xmm3, %xmm1
180005f39:     	movq	0x10(%r9,%r14,8), %rdx
180005f3e:     	testq	%rdx, %rdx
180005f41:     	js	0x180005ff6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a86>
180005f47:     	mulsd	(%r8,%rdx,8), %xmm2
180005f4d:     	addsd	%xmm2, %xmm1
180005f51:     	divsd	%xmm0, %xmm1
180005f55:     	movsd	%xmm1, (%r8,%rax,8)
180005f5b:     	movq	$0x0, 0x8(%r9,%rax,8)
180005f64:     	movq	0x10(%r9,%rbx,8), %rax
180005f69:     	testq	%rax, %rax
180005f6c:     	js	0x180006025 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ab5>
180005f72:     	movsd	0x10(%r8,%rax,8), %xmm1
180005f79:     	movq	%r9, %rdx
180005f7c:     	cmpq	$0x0, 0x18(%r9,%rax,8)
180005f82:     	mulsd	0x48(%r8,%rbx,8), %xmm1
180005f89:     	je	0x180005fb1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a41>
180005f8b:     	cmpq	$0x0, 0x50(%rdx,%rbx,8)
180005f91:     	je	0x180005fb1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3a41>
180005f93:     	movapd	0x4425(%rip), %xmm2     # 0x18000a3c0
180005f9b:     	andpd	%xmm1, %xmm2
180005f9f:     	ucomisd	0x4429(%rip), %xmm2     # 0x18000a3d0
180005fa7:     	jae	0x180006025 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ab5>
180005fa9:     	xorpd	%xmm2, %xmm2
180005fad:     	addsd	%xmm2, %xmm1
180005fb1:     	movq	0x10(%rdx,%r14,8), %r9
180005fb6:     	testq	%r9, %r9
180005fb9:     	js	0x180006025 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ab5>
180005fbb:     	movsd	0x10(%r8,%r9,8), %xmm2
180005fc2:     	mulsd	0x8(%r8,%r14,8), %xmm2
180005fc9:     	addsd	%xmm2, %xmm1
180005fcd:     	divsd	%xmm0, %xmm1
180005fd1:     	movsd	%xmm1, 0x10(%r8,%rax,8)
180005fd8:     	movq	%rdx, %r9
180005fdb:     	movq	$0x0, 0x18(%rdx,%rax,8)
180005fe4:     	movsd	%xmm0, 0x48(%r8,%rbx,8)
180005feb:     	movq	$0x0, 0x50(%r9,%rbx,8)
180005ff4:     	jmp	0x180006032 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ac2>
180005ff6:     	movb	$0x1, (%r15)
180005ffa:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
180006003:     	jmp	0x180006032 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ac2>
180006005:     	movzbl	0x5e(%rsp), %eax
18000600a:     	movq	0x8(%r12), %rcx
18000600f:     	leaq	-0x1(%rcx), %rdx
180006013:     	movq	%rdx, 0x8(%r12)
180006018:     	testb	$0x1, %al
18000601a:     	je	0x180006044 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ad4>
18000601c:     	movb	$0x1, (%rbp)
180006020:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
180006025:     	movb	$0x1, (%r15)
180006029:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180006032:     	cmpb	$0x0, (%r15)
180006036:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000603c:     	movb	$0x1, (%rcx)
18000603f:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
180006044:     	movq	0x38(%rsi,%rbx,8), %rax
180006049:     	testq	%rax, %rax
18000604c:     	js	0x18000605a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3aea>
18000604e:     	movq	%rcx, 0x8(%r12)
180006053:     	cmpq	0x10(%r12), %rcx
180006058:     	jle	0x180006091 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3b21>
18000605a:     	movb	$0x1, (%r15)
18000605e:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
180006067:     	jmp	0x180005b48 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35d8>
18000606c:     	movq	0xe0(%rsp), %rdx
180006074:     	movq	0x60(%rsp), %rcx
180006079:     	movq	%rdx, (%rcx)
18000607c:     	jmp	0x180005a86 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3516>
180006081:     	movq	0xe8(%rsp), %rcx
180006089:     	movq	%rcx, (%rsi)
18000608c:     	jmp	0x180005a86 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3516>
180006091:     	movb	$0x0, 0x5d(%rsp)
180006096:     	movq	%r14, 0x48(%rsp)
18000609b:     	movq	%rax, 0x40(%rsp)
1800060a0:     	movq	%r13, 0x30(%rsp)
1800060a5:     	movq	%r15, 0x28(%rsp)
1800060aa:     	movq	%r12, 0x20(%rsp)
1800060af:     	movq	$-0x1, 0x50(%rsp)
1800060b8:     	movq	$0x0, 0x38(%rsp)
1800060c1:     	leaq	0x5d(%rsp), %rcx
1800060c6:     	leaq	0xd0(%rsp), %rdx
1800060ce:     	movq	%rdi, %r8
1800060d1:     	movq	%rsi, %r9
1800060d4:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
1800060d9:     	testl	%eax, %eax
1800060db:     	jne	0x18000636d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3dfd>
1800060e1:     	cmpb	$0x0, (%r15)
1800060e5:     	jne	0x180005b48 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35d8>
1800060eb:     	movzbl	0x5d(%rsp), %eax
1800060f0:     	movq	0x8(%r12), %rcx
1800060f5:     	leaq	-0x1(%rcx), %rdx
1800060f9:     	movq	%rdx, 0x8(%r12)
1800060fe:     	testb	$0x1, %al
180006100:     	jne	0x18000601c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3aac>
180006106:     	movq	0x40(%rsi,%rbx,8), %rax
18000610b:     	testq	%rax, %rax
18000610e:     	js	0x180006120 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3bb0>
180006110:     	movq	%rcx, 0x8(%r12)
180006115:     	cmpq	0x10(%r12), %rcx
18000611a:     	jle	0x1800061ea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c7a>
180006120:     	movb	$0x1, (%r15)
180006124:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
18000612d:     	jmp	0x180005b48 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35d8>
180006132:     	movb	$0x1, (%r15)
180006136:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
18000613b:     	movq	%r12, %rcx
18000613e:     	movq	%rdx, 0x18(%rcx)
180006142:     	cmpb	$0x0, (%r15)
180006146:     	movq	%rbx, %rcx
180006149:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000614f:     	movq	%r11, 0x10(%r10)
180006153:     	movq	$0x0, 0x48(%rdi,%rax,8)
18000615c:     	movq	$0x1, 0x50(%r10)
180006164:     	movq	$-0x1, 0x20(%r10)
18000616c:     	movq	$-0x1, 0x28(%r10)
180006174:     	movq	$-0x1, 0x38(%r10)
18000617c:     	movq	$-0x1, 0x40(%r10)
180006184:     	cmpb	$0x0, (%r15)
180006188:     	jne	0x180005a81 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3511>
18000618e:     	movq	%rax, 0x20(%rsi,%rbp,8)
180006193:     	movq	(%r12), %rcx
180006197:     	leaq	0x4(%rcx), %rax
18000619b:     	cmpq	%r13, %rax
18000619e:     	jle	0x1800061b6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c46>
1800061a0:     	movb	$0x2, (%r15)
1800061a4:     	jmp	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800061a9:     	movq	0xd8(%rsp), %rdx
1800061b1:     	jmp	0x180006074 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3b04>
1800061b6:     	movq	%rax, (%r12)
1800061ba:     	cmpb	$0x0, (%r15)
1800061be:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800061c4:     	subsd	%xmm3, %xmm2
1800061c8:     	testq	%rcx, %rcx
1800061cb:     	js	0x18000625b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ceb>
1800061d1:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
1800061d7:     	movsd	%xmm5, 0x18(%rdi,%rcx,8)
1800061dd:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800061e3:     	movsd	%xmm0, (%rdi,%rcx,8)
1800061e8:     	jmp	0x180006268 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cf8>
1800061ea:     	movb	$0x0, 0x5c(%rsp)
1800061ef:     	movq	%r14, 0x48(%rsp)
1800061f4:     	movq	%rax, 0x40(%rsp)
1800061f9:     	movq	%r13, 0x30(%rsp)
1800061fe:     	movq	%r15, 0x28(%rsp)
180006203:     	movq	%r12, 0x20(%rsp)
180006208:     	movq	$-0x1, 0x50(%rsp)
180006211:     	movq	$0x0, 0x38(%rsp)
18000621a:     	leaq	0x5c(%rsp), %rcx
18000621f:     	leaq	0xc8(%rsp), %rdx
180006227:     	movq	%rdi, %r8
18000622a:     	movq	%rsi, %r9
18000622d:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
180006232:     	testl	%eax, %eax
180006234:     	jne	0x18000637a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3e0a>
18000623a:     	cmpb	$0x0, (%r15)
18000623e:     	jne	0x180005b48 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35d8>
180006244:     	movzbl	0x5c(%rsp), %eax
180006249:     	decq	0x8(%r12)
18000624e:     	testb	$0x1, %al
180006250:     	je	0x180005b48 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x35d8>
180006256:     	jmp	0x18000601c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3aac>
18000625b:     	movb	$0x1, (%r15)
18000625f:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180006268:     	cmpb	$0x0, (%r15)
18000626c:     	je	0x180006276 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3d06>
18000626e:     	movb	$0x0, (%rbx)
180006271:     	jmp	0x180005a84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3514>
180006276:     	movq	(%r12), %rax
18000627a:     	leaq	0xb(%rax), %r8
18000627e:     	cmpq	%r13, %r8
180006281:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006287:     	movq	0x8(%rsi,%rbp,8), %rdx
18000628c:     	movq	%r8, (%r12)
180006290:     	cmpb	$0x0, (%r15)
180006294:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006296:     	movq	%rcx, (%rsi,%rax,8)
18000629a:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000629f:     	movq	(%r12), %rdx
1800062a3:     	cmpq	%r13, %rdx
1800062a6:     	movq	%rdx, %rcx
1800062a9:     	jle	0x1800062b5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3d45>
1800062ab:     	movb	$0x2, (%r15)
1800062af:     	movq	(%r12), %rdx
1800062b3:     	xorl	%ecx, %ecx
1800062b5:     	leaq	0x3(%rdx), %r8
1800062b9:     	cmpq	%r13, %r8
1800062bc:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
1800062c2:     	movq	%r8, (%r12)
1800062c6:     	cmpb	$0x0, (%r15)
1800062ca:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800062cc:     	movq	%rdx, %r8
1800062cf:     	sarq	$0x3f, %r8
1800062d3:     	andq	%r13, %r8
1800062d6:     	leaq	(%rsi,%rdx,8), %r9
1800062da:     	movq	$0x0, (%r9,%r8,8)
1800062e2:     	xorl	%r8d, %r8d
1800062e5:     	cmpq	$-0x1, %rdx
1800062e9:     	movl	$0x0, %r10d
1800062ef:     	cmovlq	%r13, %r10
1800062f3:     	movq	$0x0, 0x8(%r9,%r10,8)
1800062fc:     	cmpq	$-0x2, %rdx
180006300:     	cmovlq	%r13, %r8
180006304:     	movq	%rcx, 0x10(%r9,%r8,8)
180006309:     	cmpb	$0x0, (%r15)
18000630d:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006313:     	leaq	(%rsi,%rax,8), %rcx
180006317:     	movq	%rdx, 0x30(%rcx)
18000631b:     	movq	$0x0, 0x18(%rcx)
180006323:     	movq	(%r12), %rdx
180006327:     	leaq	0x4(%rdx), %r8
18000632b:     	cmpq	%r13, %r8
18000632e:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006334:     	movq	%r8, (%r12)
180006338:     	cmpb	$0x0, (%r15)
18000633c:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006342:     	testq	%rdx, %rdx
180006345:     	js	0x180006387 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3e17>
180006347:     	movq	$0x0, (%rdi,%rdx,8)
18000634f:     	leaq	(%rsi,%rdx,8), %r8
180006353:     	movq	$0x1, 0x8(%rsi,%rdx,8)
18000635c:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180006365:     	movl	$0x1, %r9d
18000636b:     	jmp	0x180006394 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3e24>
18000636d:     	movq	0xd0(%rsp), %rdx
180006375:     	jmp	0x180006074 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3b04>
18000637a:     	movq	0xc8(%rsp), %rdx
180006382:     	jmp	0x180006074 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3b04>
180006387:     	movb	$0x1, (%r15)
18000638b:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180006391:     	movq	%r12, %r8
180006394:     	movq	%r9, 0x18(%r8)
180006398:     	cmpb	$0x0, (%r15)
18000639c:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800063a2:     	movq	%rdx, 0x10(%rcx)
1800063a6:     	movq	$0x0, 0x48(%rdi,%rax,8)
1800063af:     	movq	$0x1, 0x50(%rcx)
1800063b7:     	movq	$-0x1, 0x20(%rcx)
1800063bf:     	movq	$-0x1, 0x28(%rcx)
1800063c7:     	movq	$-0x1, 0x38(%rcx)
1800063cf:     	movq	$-0x1, 0x40(%rcx)
1800063d7:     	cmpb	$0x0, (%r15)
1800063db:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800063e1:     	movq	%rax, 0x28(%rsi,%rbp,8)
1800063e6:     	movq	(%r12), %rcx
1800063ea:     	leaq	0x4(%rcx), %rax
1800063ee:     	cmpq	%r13, %rax
1800063f1:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
1800063f7:     	movq	%rax, (%r12)
1800063fb:     	cmpb	$0x0, (%r15)
1800063ff:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006405:     	addsd	%xmm0, %xmm1
180006409:     	testq	%rcx, %rcx
18000640c:     	js	0x180006427 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3eb7>
18000640e:     	movsd	%xmm4, 0x10(%rdi,%rcx,8)
180006414:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
18000641a:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
180006420:     	movsd	%xmm0, (%rdi,%rcx,8)
180006425:     	jmp	0x180006434 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3ec4>
180006427:     	movb	$0x1, (%r15)
18000642b:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180006434:     	cmpb	$0x0, (%r15)
180006438:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
18000643e:     	movq	(%r12), %rax
180006442:     	leaq	0xb(%rax), %r8
180006446:     	cmpq	%r13, %r8
180006449:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
18000644f:     	movq	0x8(%rsi,%rbp,8), %rdx
180006454:     	movq	%r8, (%r12)
180006458:     	cmpb	$0x0, (%r15)
18000645c:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006462:     	movq	%rcx, (%rsi,%rax,8)
180006466:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000646b:     	movq	(%r12), %rdx
18000646f:     	cmpq	%r13, %rdx
180006472:     	movq	%rdx, %rcx
180006475:     	jle	0x180006481 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3f11>
180006477:     	movb	$0x2, (%r15)
18000647b:     	movq	(%r12), %rdx
18000647f:     	xorl	%ecx, %ecx
180006481:     	leaq	0x3(%rdx), %r8
180006485:     	cmpq	%r13, %r8
180006488:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
18000648e:     	movq	%r8, (%r12)
180006492:     	cmpb	$0x0, (%r15)
180006496:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
18000649c:     	movq	%rdx, %r8
18000649f:     	sarq	$0x3f, %r8
1800064a3:     	andq	%r13, %r8
1800064a6:     	leaq	(%rsi,%rdx,8), %r9
1800064aa:     	movq	$0x0, (%r9,%r8,8)
1800064b2:     	xorl	%r8d, %r8d
1800064b5:     	cmpq	$-0x1, %rdx
1800064b9:     	movl	$0x0, %r10d
1800064bf:     	cmovlq	%r13, %r10
1800064c3:     	movq	$0x0, 0x8(%r9,%r10,8)
1800064cc:     	cmpq	$-0x2, %rdx
1800064d0:     	cmovlq	%r13, %r8
1800064d4:     	movq	%rcx, 0x10(%r9,%r8,8)
1800064d9:     	cmpb	$0x0, (%r15)
1800064dd:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800064e3:     	leaq	(%rsi,%rax,8), %rcx
1800064e7:     	movq	%rdx, 0x30(%rcx)
1800064eb:     	movq	$0x0, 0x18(%rcx)
1800064f3:     	movq	(%r12), %rdx
1800064f7:     	leaq	0x4(%rdx), %r8
1800064fb:     	cmpq	%r13, %r8
1800064fe:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006504:     	movq	%r8, (%r12)
180006508:     	cmpb	$0x0, (%r15)
18000650c:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006512:     	testq	%rdx, %rdx
180006515:     	js	0x18000653d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3fcd>
180006517:     	movq	$0x0, (%rdi,%rdx,8)
18000651f:     	leaq	(%rsi,%rdx,8), %r8
180006523:     	movq	$0x1, 0x8(%rsi,%rdx,8)
18000652c:     	movq	$0x0, 0x10(%rdi,%rdx,8)
180006535:     	movl	$0x1, %r9d
18000653b:     	jmp	0x18000654a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3fda>
18000653d:     	movb	$0x1, (%r15)
180006541:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180006547:     	movq	%r12, %r8
18000654a:     	movq	%r9, 0x18(%r8)
18000654e:     	cmpb	$0x0, (%r15)
180006552:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006558:     	movq	%rdx, 0x10(%rcx)
18000655c:     	movq	$0x0, 0x48(%rdi,%rax,8)
180006565:     	movq	$0x1, 0x50(%rcx)
18000656d:     	movq	$-0x1, 0x20(%rcx)
180006575:     	movq	$-0x1, 0x28(%rcx)
18000657d:     	movq	$-0x1, 0x38(%rcx)
180006585:     	movq	$-0x1, 0x40(%rcx)
18000658d:     	cmpb	$0x0, (%r15)
180006591:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006597:     	movq	%rax, 0x38(%rsi,%rbp,8)
18000659c:     	movq	(%r12), %rcx
1800065a0:     	leaq	0x4(%rcx), %rax
1800065a4:     	cmpq	%r13, %rax
1800065a7:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
1800065ad:     	movq	%rax, (%r12)
1800065b1:     	cmpb	$0x0, (%r15)
1800065b5:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800065bb:     	testq	%rcx, %rcx
1800065be:     	js	0x1800065d9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4069>
1800065c0:     	movsd	%xmm2, 0x10(%rdi,%rcx,8)
1800065c6:     	movsd	%xmm1, 0x18(%rdi,%rcx,8)
1800065cc:     	movsd	%xmm3, 0x8(%rdi,%rcx,8)
1800065d2:     	movsd	%xmm0, (%rdi,%rcx,8)
1800065d7:     	jmp	0x1800065e6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4076>
1800065d9:     	movb	$0x1, (%r15)
1800065dd:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
1800065e6:     	cmpb	$0x0, (%r15)
1800065ea:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800065f0:     	movq	(%r12), %rax
1800065f4:     	leaq	0xb(%rax), %r8
1800065f8:     	cmpq	%r13, %r8
1800065fb:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006601:     	movq	0x8(%rsi,%rbp,8), %rdx
180006606:     	movq	%r8, (%r12)
18000660a:     	cmpb	$0x0, (%r15)
18000660e:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006614:     	movq	%rcx, (%rsi,%rax,8)
180006618:     	movq	%rdx, 0x8(%rsi,%rax,8)
18000661d:     	movq	(%r12), %rdx
180006621:     	cmpq	%r13, %rdx
180006624:     	movq	%rdx, %rcx
180006627:     	jle	0x180006633 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x40c3>
180006629:     	movb	$0x2, (%r15)
18000662d:     	movq	(%r12), %rdx
180006631:     	xorl	%ecx, %ecx
180006633:     	leaq	0x3(%rdx), %r8
180006637:     	cmpq	%r13, %r8
18000663a:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006640:     	movq	%r8, (%r12)
180006644:     	cmpb	$0x0, (%r15)
180006648:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
18000664e:     	movq	%rdx, %r8
180006651:     	sarq	$0x3f, %r8
180006655:     	andq	%r13, %r8
180006658:     	leaq	(%rsi,%rdx,8), %r9
18000665c:     	movq	$0x0, (%r9,%r8,8)
180006664:     	xorl	%r8d, %r8d
180006667:     	cmpq	$-0x1, %rdx
18000666b:     	movl	$0x0, %r10d
180006671:     	cmovlq	%r13, %r10
180006675:     	movq	$0x0, 0x8(%r9,%r10,8)
18000667e:     	cmpq	$-0x2, %rdx
180006682:     	cmovlq	%r13, %r8
180006686:     	movq	%rcx, 0x10(%r9,%r8,8)
18000668b:     	cmpb	$0x0, (%r15)
18000668f:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006695:     	leaq	(%rsi,%rax,8), %rcx
180006699:     	movq	%rdx, 0x30(%rcx)
18000669d:     	movq	$0x0, 0x18(%rcx)
1800066a5:     	movq	(%r12), %rdx
1800066a9:     	leaq	0x4(%rdx), %r8
1800066ad:     	cmpq	%r13, %r8
1800066b0:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
1800066b6:     	movq	%r8, (%r12)
1800066ba:     	cmpb	$0x0, (%r15)
1800066be:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800066c4:     	testq	%rdx, %rdx
1800066c7:     	js	0x1800066ef <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x417f>
1800066c9:     	movq	$0x0, (%rdi,%rdx,8)
1800066d1:     	leaq	(%rsi,%rdx,8), %r8
1800066d5:     	movq	$0x1, 0x8(%rsi,%rdx,8)
1800066de:     	movq	$0x0, 0x10(%rdi,%rdx,8)
1800066e7:     	movl	$0x1, %r9d
1800066ed:     	jmp	0x1800066fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x418c>
1800066ef:     	movb	$0x1, (%r15)
1800066f3:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
1800066f9:     	movq	%r12, %r8
1800066fc:     	movq	%r9, 0x18(%r8)
180006700:     	cmpb	$0x0, (%r15)
180006704:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
18000670a:     	movq	%rdx, 0x10(%rcx)
18000670e:     	movq	$0x0, 0x48(%rdi,%rax,8)
180006717:     	movq	$0x1, 0x50(%rcx)
18000671f:     	movq	$-0x1, 0x20(%rcx)
180006727:     	movq	$-0x1, 0x28(%rcx)
18000672f:     	movq	$-0x1, 0x38(%rcx)
180006737:     	movq	$-0x1, 0x40(%rcx)
18000673f:     	cmpb	$0x0, (%r15)
180006743:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006749:     	movq	%rax, 0x40(%rsi,%rbp,8)
18000674e:     	movq	$0x1, 0x18(%rsi,%rbp,8)
180006757:     	movq	0x30(%rsi,%rbp,8), %rax
18000675c:     	movq	%rax, %rdx
18000675f:     	sarq	$0x3f, %rdx
180006763:     	andq	%r13, %rdx
180006766:     	leaq	(%rsi,%rax,8), %rcx
18000676a:     	movq	%rdx, 0x78(%rsp)
18000676f:     	movq	%rcx, 0x80(%rsp)
180006777:     	cmpq	$0x0, (%rcx,%rdx,8)
18000677c:     	jle	0x180006a10 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x44a0>
180006782:     	leaq	(,%r13,8), %rcx
18000678a:     	xorl	%edx, %edx
18000678c:     	cmpq	$-0x2, %rax
180006790:     	movl	$0x0, %eax
180006795:     	movq	%rax, 0x70(%rsp)
18000679a:     	cmovgeq	%rdx, %rcx
18000679e:     	movq	%rcx, 0x88(%rsp)
1800067a6:     	movq	0x20(%rsi,%rbp,8), %rax
1800067ab:     	testq	%rax, %rax
1800067ae:     	js	0x180006a94 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4524>
1800067b4:     	movq	0x80(%rsp), %rcx
1800067bc:     	movq	0x88(%rsp), %rdx
1800067c4:     	movq	0x10(%rcx,%rdx), %rcx
1800067c9:     	addq	0x70(%rsp), %rcx
1800067ce:     	leaq	(%rsi,%rcx,8), %rdx
1800067d2:     	sarq	$0x3f, %rcx
1800067d6:     	andq	%r13, %rcx
1800067d9:     	movq	(%rdx,%rcx,8), %rcx
1800067dd:     	movq	%rcx, 0x60(%rsp)
1800067e2:     	movq	0x8(%r12), %rcx
1800067e7:     	leaq	0x1(%rcx), %rdx
1800067eb:     	movq	%rdx, 0x8(%r12)
1800067f0:     	cmpq	0x10(%r12), %rcx
1800067f5:     	jge	0x180006a94 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4524>
1800067fb:     	movq	0x60(%rsp), %rcx
180006800:     	movq	%rcx, 0x48(%rsp)
180006805:     	movq	%rax, 0x40(%rsp)
18000680a:     	movq	%r13, 0x30(%rsp)
18000680f:     	movq	%r15, 0x28(%rsp)
180006814:     	movq	%r12, 0x20(%rsp)
180006819:     	movq	$-0x1, 0x50(%rsp)
180006822:     	movq	$0x0, 0x38(%rsp)
18000682b:     	leaq	0x6e(%rsp), %rcx
180006830:     	leaq	0xc0(%rsp), %rdx
180006838:     	movq	%rdi, %r8
18000683b:     	movq	%rsi, %r9
18000683e:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
180006843:     	testl	%eax, %eax
180006845:     	jne	0x180006aa6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4536>
18000684b:     	cmpb	$0x0, (%r15)
18000684f:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006855:     	movq	0x8(%r12), %rcx
18000685a:     	leaq	-0x1(%rcx), %rax
18000685e:     	movq	%rax, 0x8(%r12)
180006863:     	movq	0x28(%rsi,%rbp,8), %rax
180006868:     	testq	%rax, %rax
18000686b:     	js	0x180006ab0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4540>
180006871:     	movq	%rcx, 0x8(%r12)
180006876:     	cmpq	0x10(%r12), %rcx
18000687b:     	jg	0x180006ab0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4540>
180006881:     	movq	0x60(%rsp), %rcx
180006886:     	movq	%rcx, 0x48(%rsp)
18000688b:     	movq	%rax, 0x40(%rsp)
180006890:     	movq	%r13, 0x30(%rsp)
180006895:     	movq	%r15, 0x28(%rsp)
18000689a:     	movq	%r12, 0x20(%rsp)
18000689f:     	movq	$-0x1, 0x50(%rsp)
1800068a8:     	movq	$0x0, 0x38(%rsp)
1800068b1:     	leaq	0x6d(%rsp), %rcx
1800068b6:     	leaq	0xb8(%rsp), %rdx
1800068be:     	movq	%rdi, %r8
1800068c1:     	movq	%rsi, %r9
1800068c4:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
1800068c9:     	testl	%eax, %eax
1800068cb:     	jne	0x180006ac2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4552>
1800068d1:     	cmpb	$0x0, (%r15)
1800068d5:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800068db:     	movq	0x8(%r12), %rcx
1800068e0:     	leaq	-0x1(%rcx), %rax
1800068e4:     	movq	%rax, 0x8(%r12)
1800068e9:     	movq	0x38(%rsi,%rbp,8), %rax
1800068ee:     	testq	%rax, %rax
1800068f1:     	js	0x180006acc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x455c>
1800068f7:     	movq	%rcx, 0x8(%r12)
1800068fc:     	cmpq	0x10(%r12), %rcx
180006901:     	jg	0x180006acc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x455c>
180006907:     	movq	0x60(%rsp), %rcx
18000690c:     	movq	%rcx, 0x48(%rsp)
180006911:     	movq	%rax, 0x40(%rsp)
180006916:     	movq	%r13, 0x30(%rsp)
18000691b:     	movq	%r15, 0x28(%rsp)
180006920:     	movq	%r12, 0x20(%rsp)
180006925:     	movq	$-0x1, 0x50(%rsp)
18000692e:     	movq	$0x0, 0x38(%rsp)
180006937:     	leaq	0x6c(%rsp), %rcx
18000693c:     	leaq	0xb0(%rsp), %rdx
180006944:     	movq	%rdi, %r8
180006947:     	movq	%rsi, %r9
18000694a:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
18000694f:     	testl	%eax, %eax
180006951:     	jne	0x180006ade <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x456e>
180006957:     	cmpb	$0x0, (%r15)
18000695b:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006961:     	movq	0x8(%r12), %rcx
180006966:     	leaq	-0x1(%rcx), %rax
18000696a:     	movq	%rax, 0x8(%r12)
18000696f:     	movq	0x40(%rsi,%rbp,8), %rax
180006974:     	testq	%rax, %rax
180006977:     	js	0x180006ae8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4578>
18000697d:     	movq	%rcx, 0x8(%r12)
180006982:     	cmpq	0x10(%r12), %rcx
180006987:     	jg	0x180006ae8 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4578>
18000698d:     	movq	0x60(%rsp), %rcx
180006992:     	movq	%rcx, 0x48(%rsp)
180006997:     	movq	%rax, 0x40(%rsp)
18000699c:     	movq	%r13, 0x30(%rsp)
1800069a1:     	movq	%r15, 0x28(%rsp)
1800069a6:     	movq	%r12, 0x20(%rsp)
1800069ab:     	movq	$-0x1, 0x50(%rsp)
1800069b4:     	movq	$0x0, 0x38(%rsp)
1800069bd:     	leaq	0x6b(%rsp), %rcx
1800069c2:     	leaq	0xa8(%rsp), %rdx
1800069ca:     	movq	%rdi, %r8
1800069cd:     	movq	%rsi, %r9
1800069d0:     	callq	0x1800054b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x2f40>
1800069d5:     	testl	%eax, %eax
1800069d7:     	jne	0x180006afa <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x458a>
1800069dd:     	cmpb	$0x0, (%r15)
1800069e1:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
1800069e7:     	movq	0x70(%rsp), %r8
1800069ec:     	incq	%r8
1800069ef:     	decq	0x8(%r12)
1800069f4:     	movq	0x78(%rsp), %rax
1800069f9:     	movq	0x80(%rsp), %rcx
180006a01:     	movq	%r8, 0x70(%rsp)
180006a06:     	cmpq	(%rcx,%rax,8), %r8
180006a0a:     	jl	0x1800067a6 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4236>
180006a10:     	movq	(%r12), %rcx
180006a14:     	cmpq	%r13, %rcx
180006a17:     	movq	%rcx, %rdx
180006a1a:     	jle	0x180006a26 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x44b6>
180006a1c:     	movb	$0x2, (%r15)
180006a20:     	movq	(%r12), %rcx
180006a24:     	xorl	%edx, %edx
180006a26:     	leaq	0x3(%rcx), %rax
180006a2a:     	cmpq	%r13, %rax
180006a2d:     	jg	0x1800061a0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3c30>
180006a33:     	movq	%rax, (%r12)
180006a37:     	cmpb	$0x0, (%r15)
180006a3b:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006a41:     	movq	%rcx, %rax
180006a44:     	sarq	$0x3f, %rax
180006a48:     	andq	%r13, %rax
180006a4b:     	leaq	(%rsi,%rcx,8), %r8
180006a4f:     	movq	$0x0, (%r8,%rax,8)
180006a57:     	xorl	%eax, %eax
180006a59:     	cmpq	$-0x1, %rcx
180006a5d:     	movl	$0x0, %r9d
180006a63:     	cmovlq	%r13, %r9
180006a67:     	movq	$0x0, 0x8(%r8,%r9,8)
180006a70:     	cmpq	$-0x2, %rcx
180006a74:     	cmovgeq	%rax, %r13
180006a78:     	movq	%rdx, 0x10(%r8,%r13,8)
180006a7d:     	cmpb	$0x0, (%r15)
180006a81:     	jne	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006a87:     	movq	%rcx, 0x30(%rsi,%rbp,8)
180006a8c:     	movb	$0x0, (%rbx)
180006a8f:     	jmp	0x180005a86 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3516>
180006a94:     	movb	$0x1, (%r15)
180006a98:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
180006aa1:     	jmp	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006aa6:     	movq	0xc0(%rsp), %rcx
180006aae:     	jmp	0x180006b02 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4592>
180006ab0:     	movb	$0x1, (%r15)
180006ab4:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
180006abd:     	jmp	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006ac2:     	movq	0xb8(%rsp), %rcx
180006aca:     	jmp	0x180006b02 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4592>
180006acc:     	movb	$0x1, (%r15)
180006ad0:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180006ad9:     	jmp	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006ade:     	movq	0xb0(%rsp), %rcx
180006ae6:     	jmp	0x180006b02 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4592>
180006ae8:     	movb	$0x1, (%r15)
180006aec:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
180006af5:     	jmp	0x18000626e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3cfe>
180006afa:     	movq	0xa8(%rsp), %rcx
180006b02:     	movq	%rcx, (%r14)
180006b05:     	jmp	0x180005a86 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x3516>
180006b0a:     	int3
180006b0b:     	int3
180006b0c:     	int3
180006b0d:     	int3
180006b0e:     	int3
180006b0f:     	int3
180006b10:     	pushq	%rbx
180006b12:     	subq	$0x20, %rsp
180006b16:     	movq	%rcx, %rbx
180006b19:     	callq	*0x35d1(%rip)           # 0x18000a0f0
180006b1f:     	movl	%eax, (%rbx)
180006b21:     	addq	$0x20, %rsp
180006b25:     	popq	%rbx
180006b26:     	retq
180006b27:     	int3
180006b28:     	int3
180006b29:     	int3
180006b2a:     	int3
180006b2b:     	int3
180006b2c:     	int3
180006b2d:     	int3
180006b2e:     	int3
180006b2f:     	int3
180006b30:     	movl	(%rcx), %ecx
180006b32:     	jmpq	*0x36d7(%rip)           # 0x18000a210
180006b39:     	int3
180006b3a:     	int3
180006b3b:     	int3
180006b3c:     	int3
180006b3d:     	int3
180006b3e:     	int3
180006b3f:     	int3
180006b40:     	pushq	%rbp
180006b42:     	pushq	%rbx
180006b43:     	pushq	%rsi
180006b44:     	pushq	%rdi
180006b45:     	pushq	%r14
180006b47:     	pushq	%r15
180006b49:     	movq	%rsp, %rbp
180006b4c:     	subq	$0x48, %rsp
180006b50:     	movq	0x3689(%rip), %rax      # 0x18000a1e0
180006b57:     	xorl	%r15d, %r15d
180006b5a:     	movq	%rcx, %rsi
180006b5d:     	movq	%r15, 0x38(%rbp)
180006b61:     	movl	%r15d, %r14d
180006b64:     	movq	%r15, 0x50(%rbp)
180006b68:     	movq	%r15, 0x48(%rbp)
180006b6c:     	cmpq	%rax, 0x8(%rcx)
180006b70:     	jne	0x180006cde <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x476e>
180006b76:     	leaq	0x48(%rbp), %rax
180006b7a:     	leaq	0x50(%rbp), %r9
180006b7e:     	movq	%rax, 0x20(%rsp)
180006b83:     	leaq	0x38(%rbp), %r8
180006b87:     	leaq	0x4596(%rip), %rdx      # 0x18000b124
180006b8e:     	callq	*0x359c(%rip)           # 0x18000a130
180006b94:     	testl	%eax, %eax
180006b96:     	jne	0x180006cd4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4764>
180006b9c:     	movq	0x48(%rbp), %rbx
180006ba0:     	testq	%rbx, %rbx
180006ba3:     	je	0x180006cc5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4755>
180006ba9:     	cmpq	0x3720(%rip), %rbx      # 0x18000a2d0
180006bb0:     	je	0x180006cc5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4755>
180006bb6:     	movq	0x8(%rbx), %rax
180006bba:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006bc4:     	je	0x180006cc5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4755>
180006bca:     	movq	0x20(%rbx), %rcx
180006bce:     	callq	*0x35ac(%rip)           # 0x18000a180
180006bd4:     	movq	0x28(%rbx), %rcx
180006bd8:     	movq	%rax, %rdi
180006bdb:     	callq	*0x359f(%rip)           # 0x18000a180
180006be1:     	movq	0x30(%rbx), %rcx
180006be5:     	movq	%rax, %r14
180006be8:     	callq	*0x35a2(%rip)           # 0x18000a190
180006bee:     	leaq	-0x10(%rbp), %r8
180006bf2:     	movl	%eax, %ebx
180006bf4:     	leaq	-0x18(%rbp), %rdx
180006bf8:     	leaq	0x40(%rbp), %rcx
180006bfc:     	callq	*0x359e(%rip)           # 0x18000a1a0
180006c02:     	callq	*0x3558(%rip)           # 0x18000a160
180006c08:     	movq	%rax, %rsi
180006c0b:     	testq	%rax, %rax
180006c0e:     	je	0x180006cbb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x474b>
180006c14:     	movl	%ebx, %r8d
180006c17:     	movq	%rdi, %rdx
180006c1a:     	movq	%r14, %rcx
180006c1d:     	callq	*0x3635(%rip)           # 0x18000a258
180006c23:     	movq	%rax, %rdi
180006c26:     	testq	%rax, %rax
180006c29:     	je	0x180006cbb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x474b>
180006c2f:     	callq	*0x3633(%rip)           # 0x18000a268
180006c35:     	xorl	%r9d, %r9d
180006c38:     	movq	%rsi, %r8
180006c3b:     	movq	%rax, %rcx
180006c3e:     	movq	%rdi, %rdx
180006c41:     	callq	*0x35f9(%rip)           # 0x18000a240
180006c47:     	movl	(%rsi), %ecx
180006c49:     	movq	%rax, %rbx
180006c4c:     	testl	%ecx, %ecx
180006c4e:     	js	0x180006c60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x46f0>
180006c50:     	subl	$0x1, %ecx
180006c53:     	movl	%ecx, (%rsi)
180006c55:     	jne	0x180006c60 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x46f0>
180006c57:     	movq	%rsi, %rcx
180006c5a:     	callq	*0x3568(%rip)           # 0x18000a1c8
180006c60:     	movl	(%rdi), %eax
180006c62:     	testl	%eax, %eax
180006c64:     	js	0x180006c76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4706>
180006c66:     	subl	$0x1, %eax
180006c69:     	movl	%eax, (%rdi)
180006c6b:     	jne	0x180006c76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4706>
180006c6d:     	movq	%rdi, %rcx
180006c70:     	callq	*0x3552(%rip)           # 0x18000a1c8
180006c76:     	testq	%rbx, %rbx
180006c79:     	je	0x180006cbb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x474b>
180006c7b:     	movq	-0x10(%rbp), %r8
180006c7f:     	movq	-0x18(%rbp), %rdx
180006c83:     	movq	0x40(%rbp), %rcx
180006c87:     	callq	*0x3543(%rip)           # 0x18000a1d0
180006c8d:     	movq	%rbx, %rcx
180006c90:     	callq	*0x3592(%rip)           # 0x18000a228
180006c96:     	movl	(%rbx), %eax
180006c98:     	testl	%eax, %eax
180006c9a:     	js	0x180006cc5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4755>
180006c9c:     	subl	$0x1, %eax
180006c9f:     	movl	%eax, (%rbx)
180006ca1:     	jne	0x180006cc5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4755>
180006ca3:     	movq	%rbx, %rcx
180006ca6:     	callq	*0x351c(%rip)           # 0x18000a1c8
180006cac:     	xorl	%eax, %eax
180006cae:     	addq	$0x48, %rsp
180006cb2:     	popq	%r15
180006cb4:     	popq	%r14
180006cb6:     	popq	%rdi
180006cb7:     	popq	%rsi
180006cb8:     	popq	%rbx
180006cb9:     	popq	%rbp
180006cba:     	retq
180006cbb:     	movq	0x40(%rbp), %rcx
180006cbf:     	callq	*0x353b(%rip)           # 0x18000a200
180006cc5:     	xorl	%eax, %eax
180006cc7:     	addq	$0x48, %rsp
180006ccb:     	popq	%r15
180006ccd:     	popq	%r14
180006ccf:     	popq	%rdi
180006cd0:     	popq	%rsi
180006cd1:     	popq	%rbx
180006cd2:     	popq	%rbp
180006cd3:     	retq
180006cd4:     	movq	0x38(%rbp), %rbx
180006cd8:     	movq	0x50(%rbp), %r14
180006cdc:     	jmp	0x180006ce5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4775>
180006cde:     	movq	%rsi, %rbx
180006ce1:     	movq	%rbx, 0x38(%rbp)
180006ce5:     	cmpq	0x35e4(%rip), %rbx      # 0x18000a2d0
180006cec:     	jne	0x180006d84 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4814>
180006cf2:     	leaq	-0x18(%rbp), %r8
180006cf6:     	leaq	-0x10(%rbp), %rdx
180006cfa:     	leaq	0x40(%rbp), %rcx
180006cfe:     	callq	*0x341c(%rip)           # 0x18000a120
180006d04:     	movq	0x35c5(%rip), %rax      # 0x18000a2d0
180006d0b:     	cmpq	%rax, 0x40(%rbp)
180006d0f:     	jne	0x180006d24 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47b4>
180006d11:     	movq	0x3598(%rip), %rcx      # 0x18000a2b0
180006d18:     	leaq	0x43b9(%rip), %rdx      # 0x18000b0d8
180006d1f:     	jmp	0x180006e45 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48d5>
180006d24:     	movq	0x40(%rbp), %rcx
180006d28:     	testq	%rcx, %rcx
180006d2b:     	je	0x180006d3a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47ca>
180006d2d:     	movl	(%rcx), %eax
180006d2f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d34:     	jae	0x180006d3a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47ca>
180006d36:     	incl	%eax
180006d38:     	movl	%eax, (%rcx)
180006d3a:     	movq	-0x10(%rbp), %rcx
180006d3e:     	testq	%rcx, %rcx
180006d41:     	je	0x180006d50 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47e0>
180006d43:     	movl	(%rcx), %eax
180006d45:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d4a:     	jae	0x180006d50 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47e0>
180006d4c:     	incl	%eax
180006d4e:     	movl	%eax, (%rcx)
180006d50:     	movq	-0x18(%rbp), %r8
180006d54:     	testq	%r8, %r8
180006d57:     	je	0x180006d6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47fc>
180006d59:     	movl	(%r8), %eax
180006d5c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d61:     	jae	0x180006d6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x47fc>
180006d63:     	incl	%eax
180006d65:     	movl	%eax, (%r8)
180006d68:     	movq	-0x18(%rbp), %r8
180006d6c:     	movq	-0x10(%rbp), %rdx
180006d70:     	movq	0x40(%rbp), %rcx
180006d74:     	callq	*0x3456(%rip)           # 0x18000a1d0
180006d7a:     	movl	$0x1, %ebx
180006d7f:     	jmp	0x180006e51 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48e1>
180006d84:     	movq	0x8(%rbx), %rcx
180006d88:     	movl	0xa8(%rcx), %eax
180006d8e:     	testl	%eax, %eax
180006d90:     	jns	0x180006e26 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48b6>
180006d96:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180006da0:     	je	0x180006e26 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48b6>
180006da6:     	movq	%r14, %rdx
180006da9:     	movq	%rbx, %rcx
180006dac:     	callq	*0x3336(%rip)           # 0x18000a0e8
180006db2:     	movq	%rax, %rdi
180006db5:     	testq	%rax, %rax
180006db8:     	je	0x180006e4e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48de>
180006dbe:     	movq	0x8(%rax), %rax
180006dc2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
180006dcc:     	jne	0x180006dfd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x488d>
180006dce:     	movq	0x34cb(%rip), %rcx      # 0x18000a2a0
180006dd5:     	leaq	0x431c(%rip), %rdx      # 0x18000b0f8
180006ddc:     	movq	(%rcx), %rcx
180006ddf:     	callq	*0x34c3(%rip)           # 0x18000a2a8
180006de5:     	movl	(%rdi), %eax
180006de7:     	testl	%eax, %eax
180006de9:     	js	0x180006e4e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48de>
180006deb:     	subl	$0x1, %eax
180006dee:     	movl	%eax, (%rdi)
180006df0:     	jne	0x180006e4e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48de>
180006df2:     	movq	%rdi, %rcx
180006df5:     	callq	*0x33cd(%rip)           # 0x18000a1c8
180006dfb:     	jmp	0x180006e4e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48de>
180006dfd:     	movl	(%rdi), %eax
180006dff:     	testl	%eax, %eax
180006e01:     	js	0x180006e13 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48a3>
180006e03:     	subl	$0x1, %eax
180006e06:     	movl	%eax, (%rdi)
180006e08:     	jne	0x180006e13 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48a3>
180006e0a:     	movq	%rdi, %rcx
180006e0d:     	callq	*0x33b5(%rip)           # 0x18000a1c8
180006e13:     	movq	%r14, %rdx
180006e16:     	movq	%rbx, %rcx
180006e19:     	callq	*0x3441(%rip)           # 0x18000a260
180006e1f:     	movl	$0x1, %ebx
180006e24:     	jmp	0x180006e51 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48e1>
180006e26:     	btl	$0x1e, %eax
180006e2a:     	jae	0x180006e37 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48c7>
180006e2c:     	movq	%rbx, %rdx
180006e2f:     	callq	*0x342b(%rip)           # 0x18000a260
180006e35:     	jmp	0x180006e4e <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x48de>
180006e37:     	movq	0x3462(%rip), %rcx      # 0x18000a2a0
180006e3e:     	leaq	0x42b3(%rip), %rdx      # 0x18000b0f8
180006e45:     	movq	(%rcx), %rcx
180006e48:     	callq	*0x345a(%rip)           # 0x18000a2a8
180006e4e:     	movl	%r15d, %ebx
180006e51:     	movq	0x48(%rbp), %rdi
180006e55:     	testq	%rdi, %rdi
180006e58:     	je	0x180006f7b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a0b>
180006e5e:     	cmpq	0x346b(%rip), %rdi      # 0x18000a2d0
180006e65:     	je	0x180006f7b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a0b>
180006e6b:     	movq	0x8(%rdi), %rax
180006e6f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006e79:     	je	0x180006f7b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a0b>
180006e7f:     	movq	0x20(%rdi), %rcx
180006e83:     	movq	%r12, 0x40(%rsp)
180006e88:     	callq	*0x32f2(%rip)           # 0x18000a180
180006e8e:     	movq	0x28(%rdi), %rcx
180006e92:     	movq	%rax, %r14
180006e95:     	callq	*0x32e5(%rip)           # 0x18000a180
180006e9b:     	movq	0x30(%rdi), %rcx
180006e9f:     	movq	%rax, %r12
180006ea2:     	callq	*0x32e8(%rip)           # 0x18000a190
180006ea8:     	leaq	-0x10(%rbp), %r8
180006eac:     	movl	%eax, %edi
180006eae:     	leaq	-0x18(%rbp), %rdx
180006eb2:     	leaq	0x40(%rbp), %rcx
180006eb6:     	callq	*0x32e4(%rip)           # 0x18000a1a0
180006ebc:     	callq	*0x329e(%rip)           # 0x18000a160
180006ec2:     	movq	%rax, %r15
180006ec5:     	testq	%rax, %rax
180006ec8:     	je	0x180006f6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49fc>
180006ece:     	movl	%edi, %r8d
180006ed1:     	movq	%r14, %rdx
180006ed4:     	movq	%r12, %rcx
180006ed7:     	callq	*0x337b(%rip)           # 0x18000a258
180006edd:     	movq	%rax, %r14
180006ee0:     	testq	%rax, %rax
180006ee3:     	je	0x180006f6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49fc>
180006ee9:     	callq	*0x3379(%rip)           # 0x18000a268
180006eef:     	xorl	%r9d, %r9d
180006ef2:     	movq	%r15, %r8
180006ef5:     	movq	%rax, %rcx
180006ef8:     	movq	%r14, %rdx
180006efb:     	callq	*0x333f(%rip)           # 0x18000a240
180006f01:     	movl	(%r15), %ecx
180006f04:     	movq	%rax, %rdi
180006f07:     	testl	%ecx, %ecx
180006f09:     	js	0x180006f1c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49ac>
180006f0b:     	subl	$0x1, %ecx
180006f0e:     	movl	%ecx, (%r15)
180006f11:     	jne	0x180006f1c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49ac>
180006f13:     	movq	%r15, %rcx
180006f16:     	callq	*0x32ac(%rip)           # 0x18000a1c8
180006f1c:     	movl	(%r14), %eax
180006f1f:     	testl	%eax, %eax
180006f21:     	js	0x180006f34 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49c4>
180006f23:     	subl	$0x1, %eax
180006f26:     	movl	%eax, (%r14)
180006f29:     	jne	0x180006f34 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49c4>
180006f2b:     	movq	%r14, %rcx
180006f2e:     	callq	*0x3294(%rip)           # 0x18000a1c8
180006f34:     	testq	%rdi, %rdi
180006f37:     	je	0x180006f6c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x49fc>
180006f39:     	movq	-0x10(%rbp), %r8
180006f3d:     	movq	-0x18(%rbp), %rdx
180006f41:     	movq	0x40(%rbp), %rcx
180006f45:     	callq	*0x3285(%rip)           # 0x18000a1d0
180006f4b:     	movq	%rdi, %rcx
180006f4e:     	callq	*0x32d4(%rip)           # 0x18000a228
180006f54:     	movl	(%rdi), %eax
180006f56:     	testl	%eax, %eax
180006f58:     	js	0x180006f76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a06>
180006f5a:     	subl	$0x1, %eax
180006f5d:     	movl	%eax, (%rdi)
180006f5f:     	jne	0x180006f76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a06>
180006f61:     	movq	%rdi, %rcx
180006f64:     	callq	*0x325e(%rip)           # 0x18000a1c8
180006f6a:     	jmp	0x180006f76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a06>
180006f6c:     	movq	0x40(%rbp), %rcx
180006f70:     	callq	*0x328a(%rip)           # 0x18000a200
180006f76:     	movq	0x40(%rsp), %r12
180006f7b:     	movl	(%rsi), %ecx
180006f7d:     	testl	%ecx, %ecx
180006f7f:     	js	0x180006f91 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a21>
180006f81:     	subl	$0x1, %ecx
180006f84:     	movl	%ecx, (%rsi)
180006f86:     	jne	0x180006f91 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a21>
180006f88:     	movq	%rsi, %rcx
180006f8b:     	callq	*0x3237(%rip)           # 0x18000a1c8
180006f91:     	movl	%ebx, %eax
180006f93:     	addq	$0x48, %rsp
180006f97:     	popq	%r15
180006f99:     	popq	%r14
180006f9b:     	popq	%rdi
180006f9c:     	popq	%rsi
180006f9d:     	popq	%rbx
180006f9e:     	popq	%rbp
180006f9f:     	retq
180006fa0:     	movq	%rbx, 0x8(%rsp)
180006fa5:     	movq	%rsi, 0x10(%rsp)
180006faa:     	pushq	%rdi
180006fab:     	subq	$0x20, %rsp
180006faf:     	cmpq	$0x0, 0xace1(%rip)      # 0x180011c98
180006fb7:     	movq	%rcx, %rsi
180006fba:     	movslq	%edx, %rdi
180006fbd:     	jne	0x18000700d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a9d>
180006fbf:     	leaq	0x4162(%rip), %rcx      # 0x18000b128
180006fc6:     	callq	*0x326c(%rip)           # 0x18000a238
180006fcc:     	movq	%rax, %rbx
180006fcf:     	testq	%rax, %rax
180006fd2:     	je	0x180007021 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4ab1>
180006fd4:     	leaq	0x4155(%rip), %rdx      # 0x18000b130
180006fdb:     	movq	%rax, %rcx
180006fde:     	callq	*0x3184(%rip)           # 0x18000a168
180006fe4:     	movl	(%rbx), %ecx
180006fe6:     	movq	%rax, 0xacab(%rip)      # 0x180011c98
180006fed:     	testl	%ecx, %ecx
180006fef:     	js	0x180007008 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a98>
180006ff1:     	subl	$0x1, %ecx
180006ff4:     	movl	%ecx, (%rbx)
180006ff6:     	jne	0x180007008 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4a98>
180006ff8:     	movq	%rbx, %rcx
180006ffb:     	callq	*0x31c7(%rip)           # 0x18000a1c8
180007001:     	movq	0xac90(%rip), %rax      # 0x180011c98
180007008:     	testq	%rax, %rax
18000700b:     	je	0x180007021 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4ab1>
18000700d:     	movq	%rdi, %rdx
180007010:     	movq	%rsi, %rcx
180007013:     	callq	*0x329f(%rip)           # 0x18000a2b8
180007019:     	movq	%rax, %rbx
18000701c:     	testq	%rax, %rax
18000701f:     	jne	0x180007033 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4ac3>
180007021:     	xorl	%eax, %eax
180007023:     	movq	0x30(%rsp), %rbx
180007028:     	movq	0x38(%rsp), %rsi
18000702d:     	addq	$0x20, %rsp
180007031:     	popq	%rdi
180007032:     	retq
180007033:     	movq	0xac5e(%rip), %rcx      # 0x180011c98
18000703a:     	xorl	%r8d, %r8d
18000703d:     	movq	%rbx, %rdx
180007040:     	callq	*0x3152(%rip)           # 0x18000a198
180007046:     	movl	(%rbx), %ecx
180007048:     	movq	%rax, %rdi
18000704b:     	testl	%ecx, %ecx
18000704d:     	js	0x18000705f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4aef>
18000704f:     	subl	$0x1, %ecx
180007052:     	movl	%ecx, (%rbx)
180007054:     	jne	0x18000705f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4aef>
180007056:     	movq	%rbx, %rcx
180007059:     	callq	*0x3169(%rip)           # 0x18000a1c8
18000705f:     	movq	0x30(%rsp), %rbx
180007064:     	movq	%rdi, %rax
180007067:     	movq	0x38(%rsp), %rsi
18000706c:     	addq	$0x20, %rsp
180007070:     	popq	%rdi
180007071:     	retq
180007072:     	int3
180007073:     	int3
180007074:     	int3
180007075:     	int3
180007076:     	int3
180007077:     	int3
180007078:     	int3
180007079:     	int3
18000707a:     	int3
18000707b:     	int3
18000707c:     	int3
18000707d:     	int3
18000707e:     	int3
18000707f:     	int3
180007080:     	movq	%rbx, 0x8(%rsp)
180007085:     	movq	%rsi, 0x10(%rsp)
18000708a:     	pushq	%rdi
18000708b:     	subq	$0x20, %rsp
18000708f:     	movq	0xabfa(%rip), %rax      # 0x180011c90
180007096:     	movq	%rdx, %rdi
180007099:     	movq	%rcx, %rsi
18000709c:     	testq	%rax, %rax
18000709f:     	jne	0x180007101 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b91>
1800070a1:     	leaq	0x4090(%rip), %rcx      # 0x18000b138
1800070a8:     	callq	*0x318a(%rip)           # 0x18000a238
1800070ae:     	movq	%rax, %rbx
1800070b1:     	testq	%rax, %rax
1800070b4:     	je	0x1800070ef <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b7f>
1800070b6:     	leaq	0x4093(%rip), %rdx      # 0x18000b150
1800070bd:     	movq	%rax, %rcx
1800070c0:     	callq	*0x30a2(%rip)           # 0x18000a168
1800070c6:     	movl	(%rbx), %ecx
1800070c8:     	movq	%rax, 0xabc1(%rip)      # 0x180011c90
1800070cf:     	testl	%ecx, %ecx
1800070d1:     	js	0x1800070ea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b7a>
1800070d3:     	subl	$0x1, %ecx
1800070d6:     	movl	%ecx, (%rbx)
1800070d8:     	jne	0x1800070ea <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b7a>
1800070da:     	movq	%rbx, %rcx
1800070dd:     	callq	*0x30e5(%rip)           # 0x18000a1c8
1800070e3:     	movq	0xaba6(%rip), %rax      # 0x180011c90
1800070ea:     	testq	%rax, %rax
1800070ed:     	jne	0x180007101 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4b91>
1800070ef:     	xorl	%eax, %eax
1800070f1:     	movq	0x30(%rsp), %rbx
1800070f6:     	movq	0x38(%rsp), %rsi
1800070fb:     	addq	$0x20, %rsp
1800070ff:     	popq	%rdi
180007100:     	retq
180007101:     	xorl	%r9d, %r9d
180007104:     	movq	%rdi, %r8
180007107:     	movq	%rsi, %rdx
18000710a:     	movq	%rax, %rcx
18000710d:     	movq	0x30(%rsp), %rbx
180007112:     	movq	0x38(%rsp), %rsi
180007117:     	addq	$0x20, %rsp
18000711b:     	popq	%rdi
18000711c:     	jmpq	*0x3075(%rip)           # 0x18000a198
180007123:     	int3
180007124:     	int3
180007125:     	int3
180007126:     	int3
180007127:     	int3
180007128:     	int3
180007129:     	int3
18000712a:     	int3
18000712b:     	int3
18000712c:     	int3
18000712d:     	int3
18000712e:     	int3
18000712f:     	int3
180007130:     	movq	%rbx, 0x8(%rsp)
180007135:     	movq	%rsi, 0x10(%rsp)
18000713a:     	pushq	%rdi
18000713b:     	subq	$0x20, %rsp
18000713f:     	movq	%rcx, %rbx
180007142:     	movq	%r8, %rdi
180007145:     	movq	0x10(%rcx), %rcx
180007149:     	movq	%rdx, %rsi
18000714c:     	testq	%rcx, %rcx
18000714f:     	je	0x18000715a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4bea>
180007151:     	movq	%r8, %rdx
180007154:     	callq	*%rsi
180007156:     	testl	%eax, %eax
180007158:     	jne	0x18000717d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c0d>
18000715a:     	movq	0x18(%rbx), %rcx
18000715e:     	testq	%rcx, %rcx
180007161:     	je	0x18000717b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c0b>
180007163:     	movq	%rdi, %rdx
180007166:     	movq	%rsi, %rax
180007169:     	movq	0x30(%rsp), %rbx
18000716e:     	movq	0x38(%rsp), %rsi
180007173:     	addq	$0x20, %rsp
180007177:     	popq	%rdi
180007178:     	jmpq	*%rax
18000717b:     	xorl	%eax, %eax
18000717d:     	movq	0x30(%rsp), %rbx
180007182:     	movq	0x38(%rsp), %rsi
180007187:     	addq	$0x20, %rsp
18000718b:     	popq	%rdi
18000718c:     	retq
18000718d:     	int3
18000718e:     	int3
18000718f:     	int3
180007190:     	pushq	%rbx
180007192:     	subq	$0x20, %rsp
180007196:     	movq	%rcx, %rbx
180007199:     	movq	0x10(%rcx), %rcx
18000719d:     	testq	%rcx, %rcx
1800071a0:     	je	0x1800071bd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c4d>
1800071a2:     	movq	$0x0, 0x10(%rbx)
1800071aa:     	movl	(%rcx), %eax
1800071ac:     	testl	%eax, %eax
1800071ae:     	js	0x1800071bd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c4d>
1800071b0:     	subl	$0x1, %eax
1800071b3:     	movl	%eax, (%rcx)
1800071b5:     	jne	0x1800071bd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c4d>
1800071b7:     	callq	*0x300b(%rip)           # 0x18000a1c8
1800071bd:     	movq	0x18(%rbx), %rcx
1800071c1:     	testq	%rcx, %rcx
1800071c4:     	je	0x1800071e1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c71>
1800071c6:     	movq	$0x0, 0x18(%rbx)
1800071ce:     	movl	(%rcx), %eax
1800071d0:     	testl	%eax, %eax
1800071d2:     	js	0x1800071e1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c71>
1800071d4:     	subl	$0x1, %eax
1800071d7:     	movl	%eax, (%rcx)
1800071d9:     	jne	0x1800071e1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4c71>
1800071db:     	callq	*0x2fe7(%rip)           # 0x18000a1c8
1800071e1:     	xorl	%eax, %eax
1800071e3:     	addq	$0x20, %rsp
1800071e7:     	popq	%rbx
1800071e8:     	retq
1800071e9:     	int3
1800071ea:     	int3
1800071eb:     	int3
1800071ec:     	int3
1800071ed:     	int3
1800071ee:     	int3
1800071ef:     	int3
1800071f0:     	pushq	%rbx
1800071f2:     	subq	$0x20, %rsp
1800071f6:     	movq	%rcx, %rbx
1800071f9:     	callq	*0x3019(%rip)           # 0x18000a218
1800071ff:     	movq	0x10(%rbx), %rcx
180007203:     	testq	%rcx, %rcx
180007206:     	je	0x180007223 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cb3>
180007208:     	movq	$0x0, 0x10(%rbx)
180007210:     	movl	(%rcx), %eax
180007212:     	testl	%eax, %eax
180007214:     	js	0x180007223 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cb3>
180007216:     	subl	$0x1, %eax
180007219:     	movl	%eax, (%rcx)
18000721b:     	jne	0x180007223 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cb3>
18000721d:     	callq	*0x2fa5(%rip)           # 0x18000a1c8
180007223:     	movq	0x18(%rbx), %rcx
180007227:     	testq	%rcx, %rcx
18000722a:     	je	0x180007247 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cd7>
18000722c:     	movq	$0x0, 0x18(%rbx)
180007234:     	movl	(%rcx), %eax
180007236:     	testl	%eax, %eax
180007238:     	js	0x180007247 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cd7>
18000723a:     	subl	$0x1, %eax
18000723d:     	movl	%eax, (%rcx)
18000723f:     	jne	0x180007247 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4cd7>
180007241:     	callq	*0x2f81(%rip)           # 0x18000a1c8
180007247:     	movq	0x8(%rbx), %rax
18000724b:     	movq	%rbx, %rcx
18000724e:     	addq	$0x20, %rsp
180007252:     	popq	%rbx
180007253:     	jmpq	*0x140(%rax)
18000725a:     	int3
18000725b:     	int3
18000725c:     	int3
18000725d:     	int3
18000725e:     	int3
18000725f:     	int3
180007260:     	pushq	%rbx
180007262:     	subq	$0x30, %rsp
180007266:     	movq	%r8, %r10
180007269:     	leaq	0x58(%rsp), %rax
18000726e:     	movq	%rax, 0x28(%rsp)
180007273:     	leaq	0xa756(%rip), %r9       # 0x1800119d0
18000727a:     	movq	0x2f67(%rip), %rax      # 0x18000a1e8
180007281:     	leaq	0x3ef8(%rip), %r8       # 0x18000b180
180007288:     	movq	%rdx, %r11
18000728b:     	movq	%rax, 0x20(%rsp)
180007290:     	movq	%rcx, %rbx
180007293:     	movq	%r10, %rdx
180007296:     	movq	%r11, %rcx
180007299:     	callq	*0x2e59(%rip)           # 0x18000a0f8
18000729f:     	testl	%eax, %eax
1800072a1:     	je	0x1800072fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d8c>
1800072a3:     	xorl	%r8d, %r8d
1800072a6:     	xorl	%edx, %edx
1800072a8:     	movq	%rbx, %rcx
1800072ab:     	callq	*0x2f97(%rip)           # 0x18000a248
1800072b1:     	movq	%rax, %rbx
1800072b4:     	testq	%rax, %rax
1800072b7:     	je	0x1800072fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d8c>
1800072b9:     	movq	0x58(%rsp), %rax
1800072be:     	movl	(%rax), %ecx
1800072c0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800072c6:     	jae	0x1800072d1 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d61>
1800072c8:     	incl	%ecx
1800072ca:     	movl	%ecx, (%rax)
1800072cc:     	movq	0x58(%rsp), %rax
1800072d1:     	xorl	%ecx, %ecx
1800072d3:     	movq	%rax, 0x10(%rbx)
1800072d7:     	callq	*0x2e9b(%rip)           # 0x18000a178
1800072dd:     	movq	%rax, 0x18(%rbx)
1800072e1:     	testq	%rax, %rax
1800072e4:     	jne	0x180007304 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d94>
1800072e6:     	movl	(%rbx), %eax
1800072e8:     	testl	%eax, %eax
1800072ea:     	js	0x1800072fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d8c>
1800072ec:     	subl	$0x1, %eax
1800072ef:     	movl	%eax, (%rbx)
1800072f1:     	jne	0x1800072fc <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4d8c>
1800072f3:     	movq	%rbx, %rcx
1800072f6:     	callq	*0x2ecc(%rip)           # 0x18000a1c8
1800072fc:     	xorl	%eax, %eax
1800072fe:     	addq	$0x30, %rsp
180007302:     	popq	%rbx
180007303:     	retq
180007304:     	movq	%rbx, %rax
180007307:     	addq	$0x30, %rsp
18000730b:     	popq	%rbx
18000730c:     	retq
18000730d:     	int3
18000730e:     	int3
18000730f:     	int3
180007310:     	movq	%rbx, 0x8(%rsp)
180007315:     	movq	%rsi, 0x10(%rsp)
18000731a:     	pushq	%rdi
18000731b:     	subq	$0x20, %rsp
18000731f:     	movq	%rcx, %rbx
180007322:     	movq	%r8, %rdi
180007325:     	movq	0x18(%rcx), %rcx
180007329:     	movq	%rdx, %rsi
18000732c:     	testq	%rcx, %rcx
18000732f:     	je	0x18000733a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4dca>
180007331:     	movq	%r8, %rdx
180007334:     	callq	*%rsi
180007336:     	testl	%eax, %eax
180007338:     	jne	0x18000735d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4ded>
18000733a:     	movq	0x40(%rbx), %rcx
18000733e:     	testq	%rcx, %rcx
180007341:     	je	0x18000735b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4deb>
180007343:     	movq	%rdi, %rdx
180007346:     	movq	%rsi, %rax
180007349:     	movq	0x30(%rsp), %rbx
18000734e:     	movq	0x38(%rsp), %rsi
180007353:     	addq	$0x20, %rsp
180007357:     	popq	%rdi
180007358:     	jmpq	*%rax
18000735b:     	xorl	%eax, %eax
18000735d:     	movq	0x30(%rsp), %rbx
180007362:     	movq	0x38(%rsp), %rsi
180007367:     	addq	$0x20, %rsp
18000736b:     	popq	%rdi
18000736c:     	retq
18000736d:     	int3
18000736e:     	int3
18000736f:     	int3
180007370:     	pushq	%rbx
180007372:     	subq	$0x20, %rsp
180007376:     	movq	%rcx, %rbx
180007379:     	callq	*0x2e99(%rip)           # 0x18000a218
18000737f:     	cmpq	$0x0, 0x48(%rbx)
180007384:     	je	0x18000738f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e1f>
180007386:     	movq	%rbx, %rcx
180007389:     	callq	*0x2df9(%rip)           # 0x18000a188
18000738f:     	movq	0x20(%rbx), %rcx
180007393:     	callq	*0x2e1f(%rip)           # 0x18000a1b8
180007399:     	movq	0x38(%rbx), %rcx
18000739d:     	callq	*0x2e15(%rip)           # 0x18000a1b8
1800073a3:     	movq	0x18(%rbx), %rcx
1800073a7:     	testq	%rcx, %rcx
1800073aa:     	je	0x1800073bf <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e4f>
1800073ac:     	movl	(%rcx), %eax
1800073ae:     	testl	%eax, %eax
1800073b0:     	js	0x1800073bf <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e4f>
1800073b2:     	subl	$0x1, %eax
1800073b5:     	movl	%eax, (%rcx)
1800073b7:     	jne	0x1800073bf <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e4f>
1800073b9:     	callq	*0x2e09(%rip)           # 0x18000a1c8
1800073bf:     	movq	0x40(%rbx), %rcx
1800073c3:     	testq	%rcx, %rcx
1800073c6:     	je	0x1800073db <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e6b>
1800073c8:     	movl	(%rcx), %eax
1800073ca:     	testl	%eax, %eax
1800073cc:     	js	0x1800073db <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e6b>
1800073ce:     	subl	$0x1, %eax
1800073d1:     	movl	%eax, (%rcx)
1800073d3:     	jne	0x1800073db <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e6b>
1800073d5:     	callq	*0x2ded(%rip)           # 0x18000a1c8
1800073db:     	movq	0x8(%rbx), %rax
1800073df:     	movq	%rbx, %rcx
1800073e2:     	addq	$0x20, %rsp
1800073e6:     	popq	%rbx
1800073e7:     	jmpq	*0x140(%rax)
1800073ee:     	int3
1800073ef:     	int3
1800073f0:     	pushq	%rbx
1800073f2:     	subq	$0x20, %rsp
1800073f6:     	callq	*0x2d84(%rip)           # 0x18000a180
1800073fc:     	movq	%rax, %rbx
1800073ff:     	testq	%rax, %rax
180007402:     	jne	0x18000740a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e9a>
180007404:     	addq	$0x20, %rsp
180007408:     	popq	%rbx
180007409:     	retq
18000740a:     	movq	%rbx, %rcx
18000740d:     	movq	%rdi, 0x30(%rsp)
180007412:     	callq	0x180009775 <numba_list_iter_next+0xed5>
180007417:     	leaq	0x1(%rax), %rcx
18000741b:     	callq	*0x2e2f(%rip)           # 0x18000a250
180007421:     	movq	%rax, %rdi
180007424:     	testq	%rax, %rax
180007427:     	jne	0x18000743c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4ecc>
180007429:     	callq	*0x2d11(%rip)           # 0x18000a140
18000742f:     	movq	0x30(%rsp), %rdi
180007434:     	xorl	%eax, %eax
180007436:     	addq	$0x20, %rsp
18000743a:     	popq	%rbx
18000743b:     	retq
18000743c:     	movq	%rbx, %rdx
18000743f:     	movq	%rdi, %rcx
180007442:     	callq	0x18000976f <numba_list_iter_next+0xecf>
180007447:     	movq	%rdi, %rax
18000744a:     	movq	0x30(%rsp), %rdi
18000744f:     	addq	$0x20, %rsp
180007453:     	popq	%rbx
180007454:     	retq
180007455:     	int3
180007456:     	int3
180007457:     	int3
180007458:     	int3
180007459:     	int3
18000745a:     	int3
18000745b:     	int3
18000745c:     	int3
18000745d:     	int3
18000745e:     	int3
18000745f:     	int3
180007460:     	movq	0x18(%rcx), %rcx
180007464:     	movq	%rdx, %rax
180007467:     	testq	%rcx, %rcx
18000746a:     	je	0x180007472 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f02>
18000746c:     	movq	%r8, %rdx
18000746f:     	jmpq	*%rax
180007472:     	xorl	%eax, %eax
180007474:     	retq
180007475:     	int3
180007476:     	int3
180007477:     	int3
180007478:     	int3
180007479:     	int3
18000747a:     	int3
18000747b:     	int3
18000747c:     	int3
18000747d:     	int3
18000747e:     	int3
18000747f:     	int3
180007480:     	movq	%rbx, 0x8(%rsp)
180007485:     	pushq	%rdi
180007486:     	subq	$0x20, %rsp
18000748a:     	movq	0x28(%rcx), %rax
18000748e:     	xorl	%edi, %edi
180007490:     	movq	%rcx, %rbx
180007493:     	testq	%rax, %rax
180007496:     	je	0x1800074a2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f32>
180007498:     	addq	$0x38, %rcx
18000749c:     	callq	*%rax
18000749e:     	movq	%rdi, 0x28(%rbx)
1800074a2:     	movq	0x18(%rbx), %rcx
1800074a6:     	testq	%rcx, %rcx
1800074a9:     	je	0x1800074c2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f52>
1800074ab:     	movq	%rdi, 0x18(%rbx)
1800074af:     	movl	(%rcx), %eax
1800074b1:     	testl	%eax, %eax
1800074b3:     	js	0x1800074c2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f52>
1800074b5:     	subl	$0x1, %eax
1800074b8:     	movl	%eax, (%rcx)
1800074ba:     	jne	0x1800074c2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f52>
1800074bc:     	callq	*0x2d06(%rip)           # 0x18000a1c8
1800074c2:     	movq	%rdi, 0x20(%rbx)
1800074c6:     	xorl	%eax, %eax
1800074c8:     	movq	0x30(%rsp), %rbx
1800074cd:     	addq	$0x20, %rsp
1800074d1:     	popq	%rdi
1800074d2:     	retq
1800074d3:     	int3
1800074d4:     	int3
1800074d5:     	int3
1800074d6:     	int3
1800074d7:     	int3
1800074d8:     	int3
1800074d9:     	int3
1800074da:     	int3
1800074db:     	int3
1800074dc:     	int3
1800074dd:     	int3
1800074de:     	int3
1800074df:     	int3
1800074e0:     	pushq	%rbx
1800074e2:     	subq	$0x20, %rsp
1800074e6:     	movq	%rcx, %rbx
1800074e9:     	callq	*0x2d29(%rip)           # 0x18000a218
1800074ef:     	cmpq	$0x0, 0x30(%rbx)
1800074f4:     	je	0x1800074ff <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4f8f>
1800074f6:     	movq	%rbx, %rcx
1800074f9:     	callq	*0x2c89(%rip)           # 0x18000a188
1800074ff:     	callq	*0x2c03(%rip)           # 0x18000a108
180007505:     	testl	%eax, %eax
180007507:     	jne	0x180007518 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4fa8>
180007509:     	movq	0x28(%rbx), %rax
18000750d:     	testq	%rax, %rax
180007510:     	je	0x180007518 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4fa8>
180007512:     	leaq	0x38(%rbx), %rcx
180007516:     	callq	*%rax
180007518:     	movq	0x18(%rbx), %rcx
18000751c:     	testq	%rcx, %rcx
18000751f:     	je	0x180007534 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4fc4>
180007521:     	movl	(%rcx), %eax
180007523:     	testl	%eax, %eax
180007525:     	js	0x180007534 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4fc4>
180007527:     	subl	$0x1, %eax
18000752a:     	movl	%eax, (%rcx)
18000752c:     	jne	0x180007534 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4fc4>
18000752e:     	callq	*0x2c94(%rip)           # 0x18000a1c8
180007534:     	movq	0x8(%rbx), %rax
180007538:     	movq	%rbx, %rcx
18000753b:     	addq	$0x20, %rsp
18000753f:     	popq	%rbx
180007540:     	jmpq	*0x140(%rax)
180007547:     	int3
180007548:     	int3
180007549:     	int3
18000754a:     	int3
18000754b:     	int3
18000754c:     	int3
18000754d:     	int3
18000754e:     	int3
18000754f:     	int3
180007550:     	pushq	%rdi
180007552:     	subq	$0x20, %rsp
180007556:     	cmpq	$0x0, 0x20(%rcx)
18000755b:     	movq	%rcx, %rdi
18000755e:     	jne	0x18000757f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x500f>
180007560:     	movq	0x2d49(%rip), %rcx      # 0x18000a2b0
180007567:     	leaq	0x3c62(%rip), %rdx      # 0x18000b1d0
18000756e:     	movq	(%rcx), %rcx
180007571:     	callq	*0x2d31(%rip)           # 0x18000a2a8
180007577:     	xorl	%eax, %eax
180007579:     	addq	$0x20, %rsp
18000757d:     	popq	%rdi
18000757e:     	retq
18000757f:     	movq	%rdi, %rdx
180007582:     	movq	%rbx, 0x30(%rsp)
180007587:     	movl	$0x1, %ecx
18000758c:     	callq	*0x2d76(%rip)           # 0x18000a308
180007592:     	movq	%rax, %rbx
180007595:     	testq	%rax, %rax
180007598:     	jne	0x1800075a5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5035>
18000759a:     	movq	0x30(%rsp), %rbx
18000759f:     	addq	$0x20, %rsp
1800075a3:     	popq	%rdi
1800075a4:     	retq
1800075a5:     	xorl	%r8d, %r8d
1800075a8:     	movq	%rbx, %rdx
1800075ab:     	movq	%rdi, %rcx
1800075ae:     	callq	*0x20(%rdi)
1800075b1:     	movl	(%rbx), %ecx
1800075b3:     	movq	%rax, %rdi
1800075b6:     	testl	%ecx, %ecx
1800075b8:     	js	0x1800075ca <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x505a>
1800075ba:     	subl	$0x1, %ecx
1800075bd:     	movl	%ecx, (%rbx)
1800075bf:     	jne	0x1800075ca <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x505a>
1800075c1:     	movq	%rbx, %rcx
1800075c4:     	callq	*0x2bfe(%rip)           # 0x18000a1c8
1800075ca:     	movq	0x30(%rsp), %rbx
1800075cf:     	movq	%rdi, %rax
1800075d2:     	addq	$0x20, %rsp
1800075d6:     	popq	%rdi
1800075d7:     	retq
1800075d8:     	int3
1800075d9:     	int3
1800075da:     	int3
1800075db:     	int3
1800075dc:     	int3
1800075dd:     	int3
1800075de:     	int3
1800075df:     	int3
1800075e0:     	movq	%rbx, 0x8(%rsp)
1800075e5:     	pushq	%rdi
1800075e6:     	subq	$0x20, %rsp
1800075ea:     	movq	%r8, %rbx
1800075ed:     	callq	*0x2afd(%rip)           # 0x18000a0f0
1800075f3:     	movl	(%rbx), %ecx
1800075f5:     	movl	%eax, %edi
1800075f7:     	testl	%ecx, %ecx
1800075f9:     	js	0x18000760b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x509b>
1800075fb:     	subl	$0x1, %ecx
1800075fe:     	movl	%ecx, (%rbx)
180007600:     	jne	0x18000760b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x509b>
180007602:     	movq	%rbx, %rcx
180007605:     	callq	*0x2bbd(%rip)           # 0x18000a1c8
18000760b:     	movl	%edi, %ecx
18000760d:     	movq	0x30(%rsp), %rbx
180007612:     	addq	$0x20, %rsp
180007616:     	popq	%rdi
180007617:     	jmpq	*0x2bf2(%rip)           # 0x18000a210
18000761e:     	int3
18000761f:     	int3
180007620:     	movq	%rbx, 0x8(%rsp)
180007625:     	pushq	%rdi
180007626:     	subq	$0x20, %rsp
18000762a:     	movl	(%rdx), %eax
18000762c:     	movq	%rdx, %rbx
18000762f:     	movq	%rcx, %rdi
180007632:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007637:     	jae	0x18000763d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x50cd>
180007639:     	incl	%eax
18000763b:     	movl	%eax, (%rdx)
18000763d:     	movl	$0x30, %ecx
180007642:     	callq	*0xa620(%rip)           # 0x180011c68
180007648:     	cmpb	$0x0, 0xa5f1(%rip)      # 0x180011c40
18000764f:     	je	0x180007659 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x50e9>
180007651:     	lock
180007652:     	incq	0xa5ef(%rip)            # 0x180011c48
180007659:     	testq	%rax, %rax
18000765c:     	je	0x180007693 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5123>
18000765e:     	movl	$0x1, %ecx
180007663:     	leaq	-0x8a(%rip), %rdx       # 0x1800075e0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5070>
18000766a:     	xchgq	%rcx, (%rax)
18000766d:     	xorl	%ecx, %ecx
18000766f:     	movq	%rdx, 0x8(%rax)
180007673:     	movq	%rcx, 0x20(%rax)
180007677:     	movq	%rcx, 0x28(%rax)
18000767b:     	movq	%rbx, 0x10(%rax)
18000767f:     	movq	%rdi, 0x18(%rax)
180007683:     	cmpb	%cl, 0xa5b7(%rip)       # 0x180011c40
180007689:     	je	0x180007693 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5123>
18000768b:     	lock
18000768c:     	incq	0xa5c5(%rip)            # 0x180011c58
180007693:     	movq	0x30(%rsp), %rbx
180007698:     	addq	$0x20, %rsp
18000769c:     	popq	%rdi
18000769d:     	retq
18000769e:     	int3
18000769f:     	int3
1800076a0:     	movq	%rbx, 0x8(%rsp)
1800076a5:     	pushq	%rdi
1800076a6:     	subq	$0x30, %rsp
1800076aa:     	movq	%rcx, %rdi
1800076ad:     	leaq	0xa30c(%rip), %r9       # 0x1800119c0
1800076b4:     	movq	%r8, %rax
1800076b7:     	leaq	0x58(%rsp), %rcx
1800076bc:     	movq	%rdx, %r10
1800076bf:     	movq	%rcx, 0x20(%rsp)
1800076c4:     	movq	%r10, %rcx
1800076c7:     	leaq	0x3b4a(%rip), %r8       # 0x18000b218
1800076ce:     	movq	%rax, %rdx
1800076d1:     	callq	*0x2a21(%rip)           # 0x18000a0f8
1800076d7:     	testl	%eax, %eax
1800076d9:     	je	0x180007703 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5193>
1800076db:     	movq	0x58(%rsp), %rcx
1800076e0:     	callq	*0x29fa(%rip)           # 0x18000a0e0
1800076e6:     	movq	%rax, %rbx
1800076e9:     	callq	*0x2bf9(%rip)           # 0x18000a2e8
1800076ef:     	testq	%rax, %rax
1800076f2:     	jne	0x180007703 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5193>
1800076f4:     	movq	%rbx, 0x10(%rdi)
1800076f8:     	movq	0x40(%rsp), %rbx
1800076fd:     	addq	$0x30, %rsp
180007701:     	popq	%rdi
180007702:     	retq
180007703:     	movq	0x40(%rsp), %rbx
180007708:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000770d:     	addq	$0x30, %rsp
180007711:     	popq	%rdi
180007712:     	retq
180007713:     	int3
180007714:     	int3
180007715:     	int3
180007716:     	int3
180007717:     	int3
180007718:     	int3
180007719:     	int3
18000771a:     	int3
18000771b:     	int3
18000771c:     	int3
18000771d:     	int3
18000771e:     	int3
18000771f:     	int3
180007720:     	subq	$0x38, %rsp
180007724:     	movl	%r8d, %eax
180007727:     	movq	%rdx, %r10
18000772a:     	movq	0x10(%rcx), %r8
18000772e:     	movq	%rcx, %rdx
180007731:     	movl	%eax, 0x28(%rsp)
180007735:     	movq	%r10, %rcx
180007738:     	movl	$0x0, 0x20(%rsp)
180007740:     	movq	0x20(%r8), %r9
180007744:     	movq	0x18(%r8), %r8
180007748:     	callq	*0x2aba(%rip)           # 0x18000a208
18000774e:     	addq	$0x38, %rsp
180007752:     	retq
180007753:     	int3
180007754:     	int3
180007755:     	int3
180007756:     	int3
180007757:     	int3
180007758:     	int3
180007759:     	int3
18000775a:     	int3
18000775b:     	int3
18000775c:     	int3
18000775d:     	int3
18000775e:     	int3
18000775f:     	int3
180007760:     	movq	0x10(%rcx), %rax
180007764:     	lock
180007765:     	incq	(%rax)
180007768:     	movq	0x2b61(%rip), %rax      # 0x18000a2d0
18000776f:     	retq
180007770:     	subq	$0x28, %rsp
180007774:     	movq	0x10(%rcx), %rcx
180007778:     	callq	0x180008a70 <numba_list_iter_next+0x1d0>
18000777d:     	movq	0x2b4c(%rip), %rax      # 0x18000a2d0
180007784:     	addq	$0x28, %rsp
180007788:     	retq
180007789:     	int3
18000778a:     	int3
18000778b:     	int3
18000778c:     	int3
18000778d:     	int3
18000778e:     	int3
18000778f:     	int3
180007790:     	movq	0x10(%rcx), %rcx
180007794:     	movq	0x18(%rcx), %rcx
180007798:     	jmpq	*0x29b9(%rip)           # 0x18000a158
18000779f:     	int3
1800077a0:     	subq	$0x28, %rsp
1800077a4:     	movq	0x10(%rcx), %rax
1800077a8:     	testq	%rax, %rax
1800077ab:     	je	0x1800077c9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5259>
1800077ad:     	cmpq	$0x0, 0x18(%rax)
1800077b2:     	je	0x1800077c9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5259>
1800077b4:     	movq	(%rax), %rcx
1800077b7:     	nop
1800077b8:     	cmpq	$-0x1, %rcx
1800077bc:     	je	0x1800077c9 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5259>
1800077be:     	addq	$0x28, %rsp
1800077c2:     	jmpq	*0x295f(%rip)           # 0x18000a128
1800077c9:     	movq	0x2a28(%rip), %rcx      # 0x18000a1f8
1800077d0:     	leaq	0x3a49(%rip), %rdx      # 0x18000b220
1800077d7:     	movq	(%rcx), %rcx
1800077da:     	callq	*0x2ac8(%rip)           # 0x18000a2a8
1800077e0:     	xorl	%eax, %eax
1800077e2:     	addq	$0x28, %rsp
1800077e6:     	retq
1800077e7:     	int3
1800077e8:     	int3
1800077e9:     	int3
1800077ea:     	int3
1800077eb:     	int3
1800077ec:     	int3
1800077ed:     	int3
1800077ee:     	int3
1800077ef:     	int3
1800077f0:     	movq	0x10(%rcx), %rcx
1800077f4:     	movq	0x28(%rcx), %rcx
1800077f8:     	jmpq	*0x2959(%rip)           # 0x18000a158
1800077ff:     	int3
180007800:     	movq	0x10(%rcx), %rax
180007804:     	movq	0x10(%rax), %rax
180007808:     	testq	%rax, %rax
18000780b:     	je	0x18000781c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x52ac>
18000780d:     	movl	(%rax), %ecx
18000780f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180007815:     	jae	0x18000783a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x52ca>
180007817:     	incl	%ecx
180007819:     	movl	%ecx, (%rax)
18000781b:     	retq
18000781c:     	movq	0x2aad(%rip), %rcx      # 0x18000a2d0
180007823:     	movl	(%rcx), %eax
180007825:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000782a:     	jae	0x180007837 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x52c7>
18000782c:     	incl	%eax
18000782e:     	movl	%eax, (%rcx)
180007830:     	movq	0x2a99(%rip), %rcx      # 0x18000a2d0
180007837:     	movq	%rcx, %rax
18000783a:     	retq
18000783b:     	int3
18000783c:     	int3
18000783d:     	int3
18000783e:     	int3
18000783f:     	int3
180007840:     	pushq	%rbx
180007842:     	subq	$0x20, %rsp
180007846:     	movq	%rcx, %rbx
180007849:     	movq	0x10(%rcx), %rcx
18000784d:     	callq	0x180008a70 <numba_list_iter_next+0x1d0>
180007852:     	movq	0x8(%rbx), %rax
180007856:     	movq	%rbx, %rcx
180007859:     	addq	$0x20, %rsp
18000785d:     	popq	%rbx
18000785e:     	jmpq	*0x140(%rax)
180007865:     	int3
180007866:     	int3
180007867:     	int3
180007868:     	int3
180007869:     	int3
18000786a:     	int3
18000786b:     	int3
18000786c:     	int3
18000786d:     	int3
18000786e:     	int3
18000786f:     	int3
180007870:     	movq	%rdi, 0x18(%rsp)
180007875:     	pushq	%r14
180007877:     	subq	$0x20, %rsp
18000787b:     	movq	0xa3fe(%rip), %rax      # 0x180011c80
180007882:     	movq	%rdx, %r14
180007885:     	movq	%rcx, %rdi
180007888:     	movq	0x8(%rcx), %rcx
18000788c:     	movq	0x10(%rax), %rdx
180007890:     	cmpq	%rdx, %rcx
180007893:     	je	0x1800078b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5340>
180007895:     	callq	*0x293d(%rip)           # 0x18000a1d8
18000789b:     	testl	%eax, %eax
18000789d:     	jne	0x1800078b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5340>
18000789f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800078a4:     	movq	0x40(%rsp), %rdi
1800078a9:     	addq	$0x20, %rsp
1800078ad:     	popq	%r14
1800078af:     	retq
1800078b0:     	movq	%rbx, 0x30(%rsp)
1800078b5:     	movq	%rdi, %rdx
1800078b8:     	movq	0x10(%rdi), %rbx
1800078bc:     	movq	%rbx, %rcx
1800078bf:     	movq	%rsi, 0x38(%rsp)
1800078c4:     	movl	0x18(%rdi), %esi
1800078c7:     	callq	0x180007620 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x50b0>
1800078cc:     	movq	%rax, (%r14)
1800078cf:     	movq	0xa3aa(%rip), %rax      # 0x180011c80
1800078d6:     	movq	%rbx, 0x20(%r14)
1800078da:     	movl	0x18(%rdi), %edx
1800078dd:     	movq	0x20(%rdi), %rcx
1800078e1:     	callq	*0x4f0(%rax)
1800078e7:     	cmpl	$0x12, 0xa39e(%rip)     # 0x180011c8c
1800078ee:     	movq	0x30(%rsp), %rbx
1800078f3:     	movq	%rax, 0x10(%r14)
1800078f7:     	movq	0x38(%rdi), %rax
1800078fb:     	jl	0x180007903 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5393>
1800078fd:     	movq	0x28(%rax), %rax
180007901:     	jmp	0x180007907 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5397>
180007903:     	movslq	0x20(%rax), %rax
180007907:     	xorl	%r8d, %r8d
18000790a:     	movq	%rax, 0x18(%r14)
18000790e:     	movq	%rdi, 0x8(%r14)
180007912:     	leaq	0x28(%r14), %rax
180007916:     	testl	%esi, %esi
180007918:     	jle	0x18000795b <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x53eb>
18000791a:     	nopw	(%rax,%rax)
180007920:     	movq	0x20(%rdi), %rcx
180007924:     	movq	(%rcx,%r8,8), %rdx
180007928:     	incl	%r8d
18000792b:     	movq	%rdx, (%rax)
18000792e:     	addq	$0x8, %rax
180007932:     	cmpl	%esi, %r8d
180007935:     	jl	0x180007920 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x53b0>
180007937:     	xorl	%r8d, %r8d
18000793a:     	nopw	(%rax,%rax)
180007940:     	movq	0x28(%rdi), %rcx
180007944:     	leaq	0x8(%rax), %rax
180007948:     	movslq	%r8d, %rdx
18000794b:     	incl	%r8d
18000794e:     	movq	(%rcx,%rdx,8), %rdx
180007952:     	movq	%rdx, -0x8(%rax)
180007956:     	cmpl	%esi, %r8d
180007959:     	jl	0x180007940 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x53d0>
18000795b:     	movq	0x38(%rsp), %rsi
180007960:     	xorl	%eax, %eax
180007962:     	movq	0x40(%rsp), %rdi
180007967:     	addq	$0x20, %rsp
18000796b:     	popq	%r14
18000796d:     	retq
18000796e:     	int3
18000796f:     	int3
180007970:     	pushq	%rbx
180007972:     	pushq	%rbp
180007973:     	pushq	%rsi
180007974:     	pushq	%rdi
180007975:     	subq	$0x28, %rsp
180007979:     	cmpq	$0x0, 0xa317(%rip)      # 0x180011c98
180007981:     	movq	%rcx, %rbp
180007984:     	movslq	0x8(%rdx), %rdi
180007988:     	movq	(%rdx), %rsi
18000798b:     	jne	0x1800079e3 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5473>
18000798d:     	leaq	0x3794(%rip), %rcx      # 0x18000b128
180007994:     	callq	*0x289e(%rip)           # 0x18000a238
18000799a:     	movq	%rax, %rbx
18000799d:     	testq	%rax, %rax
1800079a0:     	je	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
1800079a6:     	leaq	0x3783(%rip), %rdx      # 0x18000b130
1800079ad:     	movq	%rax, %rcx
1800079b0:     	callq	*0x27b2(%rip)           # 0x18000a168
1800079b6:     	movl	(%rbx), %edx
1800079b8:     	movq	%rax, 0xa2d9(%rip)      # 0x180011c98
1800079bf:     	testl	%edx, %edx
1800079c1:     	js	0x1800079da <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x546a>
1800079c3:     	subl	$0x1, %edx
1800079c6:     	movl	%edx, (%rbx)
1800079c8:     	jne	0x1800079da <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x546a>
1800079ca:     	movq	%rbx, %rcx
1800079cd:     	callq	*0x27f5(%rip)           # 0x18000a1c8
1800079d3:     	movq	0xa2be(%rip), %rax      # 0x180011c98
1800079da:     	testq	%rax, %rax
1800079dd:     	je	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
1800079e3:     	movq	%rdi, %rdx
1800079e6:     	movq	%rsi, %rcx
1800079e9:     	callq	*0x28c9(%rip)           # 0x18000a2b8
1800079ef:     	movq	%rax, %rdi
1800079f2:     	testq	%rax, %rax
1800079f5:     	je	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
1800079f7:     	movq	0xa29a(%rip), %rcx      # 0x180011c98
1800079fe:     	xorl	%r8d, %r8d
180007a01:     	movq	%rax, %rdx
180007a04:     	callq	*0x278e(%rip)           # 0x18000a198
180007a0a:     	movl	(%rdi), %ecx
180007a0c:     	movq	%rax, %rbx
180007a0f:     	testl	%ecx, %ecx
180007a11:     	js	0x180007a23 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54b3>
180007a13:     	subl	$0x1, %ecx
180007a16:     	movl	%ecx, (%rdi)
180007a18:     	jne	0x180007a23 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54b3>
180007a1a:     	movq	%rdi, %rcx
180007a1d:     	callq	*0x27a5(%rip)           # 0x18000a1c8
180007a23:     	testq	%rbx, %rbx
180007a26:     	je	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
180007a28:     	movq	0x8(%rbx), %r8
180007a2c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180007a37:     	jne	0x180007a75 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5505>
180007a39:     	movq	0x2860(%rip), %rcx      # 0x18000a2a0
180007a40:     	leaq	0x38e1(%rip), %rdx      # 0x18000b328
180007a47:     	movq	0x18(%r8), %r8
180007a4b:     	movq	(%rcx), %rcx
180007a4e:     	callq	*0x279c(%rip)           # 0x18000a1f0
180007a54:     	movl	(%rbx), %eax
180007a56:     	testl	%eax, %eax
180007a58:     	js	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
180007a5a:     	subl	$0x1, %eax
180007a5d:     	movl	%eax, (%rbx)
180007a5f:     	jne	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
180007a61:     	movq	%rbx, %rcx
180007a64:     	callq	*0x275e(%rip)           # 0x18000a1c8
180007a6a:     	xorl	%eax, %eax
180007a6c:     	addq	$0x28, %rsp
180007a70:     	popq	%rdi
180007a71:     	popq	%rsi
180007a72:     	popq	%rbp
180007a73:     	popq	%rbx
180007a74:     	retq
180007a75:     	xorl	%r8d, %r8d
180007a78:     	leaq	0x98c1(%rip), %rcx      # 0x180011340
180007a7f:     	xorl	%edx, %edx
180007a81:     	callq	*0x27c1(%rip)           # 0x18000a248
180007a87:     	movq	%rax, %rdi
180007a8a:     	testq	%rax, %rax
180007a8d:     	je	0x180007a54 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54e4>
180007a8f:     	movq	%rbp, %rcx
180007a92:     	movq	%rbx, 0x18(%rax)
180007a96:     	callq	*0x2724(%rip)           # 0x18000a1c0
180007a9c:     	movq	%rax, 0x10(%rdi)
180007aa0:     	movq	%rax, %rcx
180007aa3:     	testq	%rax, %rax
180007aa6:     	jne	0x180007aba <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x554a>
180007aa8:     	movl	(%rdi), %eax
180007aaa:     	testl	%eax, %eax
180007aac:     	js	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
180007aae:     	subl	$0x1, %eax
180007ab1:     	movl	%eax, (%rdi)
180007ab3:     	jne	0x180007a6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54fa>
180007ab5:     	movq	%rdi, %rcx
180007ab8:     	jmp	0x180007a64 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x54f4>
180007aba:     	movl	(%rax), %eax
180007abc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007ac1:     	jae	0x180007ac7 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5557>
180007ac3:     	incl	%eax
180007ac5:     	movl	%eax, (%rcx)
180007ac7:     	movq	%rdi, %rax
180007aca:     	addq	$0x28, %rsp
180007ace:     	popq	%rdi
180007acf:     	popq	%rsi
180007ad0:     	popq	%rbp
180007ad1:     	popq	%rbx
180007ad2:     	retq
180007ad3:     	int3
180007ad4:     	int3
180007ad5:     	int3
180007ad6:     	int3
180007ad7:     	int3
180007ad8:     	int3
180007ad9:     	int3
180007ada:     	int3
180007adb:     	int3
180007adc:     	int3
180007add:     	int3
180007ade:     	int3
180007adf:     	int3
180007ae0:     	movq	%r9, 0x20(%rsp)
180007ae5:     	movq	%r8, 0x18(%rsp)
180007aea:     	movq	%rdx, 0x10(%rsp)
180007aef:     	movq	%rcx, 0x8(%rsp)
180007af4:     	pushq	%rbx
180007af5:     	pushq	%rbp
180007af6:     	pushq	%rsi
180007af7:     	pushq	%rdi
180007af8:     	pushq	%r12
180007afa:     	pushq	%r13
180007afc:     	pushq	%r14
180007afe:     	pushq	%r15
180007b00:     	subq	$0x68, %rsp
180007b04:     	movq	%rcx, %r14
180007b07:     	movq	%r9, %r15
180007b0a:     	leaq	0x32cf(%rip), %rcx      # 0x18000ade0
180007b11:     	movq	%r8, %r13
180007b14:     	movq	%rdx, %rsi
180007b17:     	callq	*0x271b(%rip)           # 0x18000a238
180007b1d:     	movq	%rax, %rdi
180007b20:     	testq	%rax, %rax
180007b23:     	jne	0x180007b5c <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x55ec>
180007b25:     	movq	0x260c(%rip), %rcx      # 0x18000a138
180007b2c:     	movq	(%rcx), %rcx
180007b2f:     	callq	*0x267b(%rip)           # 0x18000a1b0
180007b35:     	testl	%eax, %eax
180007b37:     	je	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007b3d:     	callq	*0x277d(%rip)           # 0x18000a2c0
180007b43:     	leaq	0x32b6(%rip), %rcx      # 0x18000ae00
180007b4a:     	callq	*0x26e8(%rip)           # 0x18000a238
180007b50:     	movq	%rax, %rdi
180007b53:     	testq	%rax, %rax
180007b56:     	je	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007b5c:     	leaq	0x32bd(%rip), %rdx      # 0x18000ae20
180007b63:     	movq	%rdi, %rcx
180007b66:     	callq	*0x25fc(%rip)           # 0x18000a168
180007b6c:     	movl	(%rdi), %ecx
180007b6e:     	movq	%rax, %rbx
180007b71:     	testl	%ecx, %ecx
180007b73:     	js	0x180007b85 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5615>
180007b75:     	subl	$0x1, %ecx
180007b78:     	movl	%ecx, (%rdi)
180007b7a:     	jne	0x180007b85 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5615>
180007b7c:     	movq	%rdi, %rcx
180007b7f:     	callq	*0x2643(%rip)           # 0x18000a1c8
180007b85:     	testq	%rbx, %rbx
180007b88:     	je	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007b8e:     	movq	0x256b(%rip), %rax      # 0x18000a100
180007b95:     	cmpq	%rax, 0x8(%rbx)
180007b99:     	je	0x180007bd5 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5665>
180007b9b:     	movq	0x270e(%rip), %rcx      # 0x18000a2b0
180007ba2:     	leaq	0x3287(%rip), %rdx      # 0x18000ae30
180007ba9:     	movq	(%rcx), %rcx
180007bac:     	callq	*0x26f6(%rip)           # 0x18000a2a8
180007bb2:     	movl	(%rbx), %eax
180007bb4:     	testl	%eax, %eax
180007bb6:     	js	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007bbc:     	subl	$0x1, %eax
180007bbf:     	movl	%eax, (%rbx)
180007bc1:     	jne	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007bc7:     	movq	%rbx, %rcx
180007bca:     	callq	*0x25f8(%rip)           # 0x18000a1c8
180007bd0:     	jmp	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007bd5:     	xorl	%edx, %edx
180007bd7:     	movq	%rbx, %rcx
180007bda:     	callq	*0x25c8(%rip)           # 0x18000a1a8
180007be0:     	movl	(%rbx), %ecx
180007be2:     	movq	%rax, 0xa097(%rip)      # 0x180011c80
180007be9:     	testl	%ecx, %ecx
180007beb:     	js	0x180007c04 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5694>
180007bed:     	subl	$0x1, %ecx
180007bf0:     	movl	%ecx, (%rbx)
180007bf2:     	jne	0x180007c04 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5694>
180007bf4:     	movq	%rbx, %rcx
180007bf7:     	callq	*0x25cb(%rip)           # 0x18000a1c8
180007bfd:     	movq	0xa07c(%rip), %rax      # 0x180011c80
180007c04:     	testq	%rax, %rax
180007c07:     	jne	0x180007c22 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56b2>
180007c09:     	leaq	0x3248(%rip), %rdx      # 0x18000ae58
180007c10:     	movq	0x2699(%rip), %rcx      # 0x18000a2b0
180007c17:     	movq	(%rcx), %rcx
180007c1a:     	callq	*0x2688(%rip)           # 0x18000a2a8
180007c20:     	jmp	0x180007c57 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e7>
180007c22:     	callq	*(%rax)
180007c24:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180007c29:     	jbe	0x180007c8a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x571a>
180007c2b:     	movq	0x267e(%rip), %rax      # 0x18000a2b0
180007c32:     	movq	(%rax), %rbx
180007c35:     	movq	0xa044(%rip), %rax      # 0x180011c80
180007c3c:     	callq	*(%rax)
180007c3e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180007c44:     	leaq	0x3235(%rip), %rdx      # 0x18000ae80
180007c4b:     	movl	%eax, %r9d
180007c4e:     	movq	%rbx, %rcx
180007c51:     	callq	*0x2599(%rip)           # 0x18000a1f0
180007c57:     	callq	*0x24bb(%rip)           # 0x18000a118
180007c5d:     	movq	0x24ac(%rip), %rcx      # 0x18000a110
180007c64:     	leaq	0x343d(%rip), %rdx      # 0x18000b0a8
180007c6b:     	movq	(%rcx), %rcx
180007c6e:     	callq	*0x2634(%rip)           # 0x18000a2a8
180007c74:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007c79:     	addq	$0x68, %rsp
180007c7d:     	popq	%r15
180007c7f:     	popq	%r14
180007c81:     	popq	%r13
180007c83:     	popq	%r12
180007c85:     	popq	%rdi
180007c86:     	popq	%rsi
180007c87:     	popq	%rbp
180007c88:     	popq	%rbx
180007c89:     	retq
180007c8a:     	movq	0x9fef(%rip), %rax      # 0x180011c80
180007c91:     	callq	*0x698(%rax)
180007c97:     	movl	%eax, 0x9fef(%rip)      # 0x180011c8c
180007c9d:     	cmpl	$0x10, %eax
180007ca0:     	jge	0x180007cbe <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x574e>
180007ca2:     	movq	0x2607(%rip), %rcx      # 0x18000a2b0
180007ca9:     	leaq	0x3220(%rip), %rdx      # 0x18000aed0
180007cb0:     	movl	%eax, %r9d
180007cb3:     	movl	$0x10, %r8d
180007cb9:     	movq	(%rcx), %rcx
180007cbc:     	jmp	0x180007c51 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56e1>
180007cbe:     	movq	0x9fbb(%rip), %rax      # 0x180011c80
180007cc5:     	callq	*0x690(%rax)
180007ccb:     	testl	%eax, %eax
180007ccd:     	jne	0x180007cdb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x576b>
180007ccf:     	leaq	0x334a(%rip), %rdx      # 0x18000b020
180007cd6:     	jmp	0x180007c10 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56a0>
180007cdb:     	cmpl	$0x1, %eax
180007cde:     	je	0x180007cec <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x577c>
180007ce0:     	leaq	0x3369(%rip), %rdx      # 0x18000b050
180007ce7:     	jmp	0x180007c10 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x56a0>
180007cec:     	leaq	0x9b2d(%rip), %rcx      # 0x180011820
180007cf3:     	callq	*0x2477(%rip)           # 0x18000a170
180007cf9:     	testl	%eax, %eax
180007cfb:     	jne	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180007d01:     	leaq	0x9638(%rip), %rcx      # 0x180011340
180007d08:     	callq	*0x2462(%rip)           # 0x18000a170
180007d0e:     	testl	%eax, %eax
180007d10:     	jne	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180007d16:     	leaq	0x9963(%rip), %rcx      # 0x180011680
180007d1d:     	callq	*0x244d(%rip)           # 0x18000a170
180007d23:     	testl	%eax, %eax
180007d25:     	jne	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180007d2b:     	xorl	%ebx, %ebx
180007d2d:     	cmpl	%ebx, 0x9f55(%rip)      # 0x180011c88
180007d33:     	jne	0x180007d76 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5806>
180007d35:     	movq	%gs:0x58, %rax
180007d3e:     	movl	0x9f5c(%rip), %ecx      # 0x180011ca0
180007d44:     	movl	$0x1, 0x9f3a(%rip)      # 0x180011c88
180007d4e:     	movq	(%rax,%rcx,8), %rdx
180007d52:     	movl	$0x10, %eax
180007d57:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d5e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180007d63:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d6a:     	movl	$0x13d0, %eax           # imm = 0x13D0
180007d6f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007d76:     	movl	%ebx, 0x9ebc(%rip)      # 0x180011c38
180007d7c:     	movq	%rbx, %rax
180007d7f:     	movb	%bl, 0x9ebb(%rip)       # 0x180011c40
180007d85:     	movq	%rbx, %rcx
180007d88:     	xchgq	%rax, 0x9eb9(%rip)      # 0x180011c48
180007d8f:     	xchgq	%rcx, 0x9eba(%rip)      # 0x180011c50
180007d96:     	movq	%rbx, %rax
180007d99:     	movq	%rbx, %rcx
180007d9c:     	xchgq	%rax, 0x9eb5(%rip)      # 0x180011c58
180007da3:     	xchgq	%rcx, 0x9eb6(%rip)      # 0x180011c60
180007daa:     	movq	0x22af(%rip), %rax      # 0x18000a060
180007db1:     	leaq	0x9728(%rip), %rcx      # 0x1800114e0
180007db8:     	movq	%rax, 0x9ea9(%rip)      # 0x180011c68
180007dbf:     	movq	0x22aa(%rip), %rax      # 0x18000a070
180007dc6:     	movq	%rax, 0x9ea3(%rip)      # 0x180011c70
180007dcd:     	movq	0x2294(%rip), %rax      # 0x18000a068
180007dd4:     	movq	%rax, 0x9e9d(%rip)      # 0x180011c78
180007ddb:     	movq	0x2466(%rip), %rax      # 0x18000a248
180007de2:     	movq	%rax, 0x982f(%rip)      # 0x180011618
180007de9:     	callq	*0x2381(%rip)           # 0x18000a170
180007def:     	testl	%eax, %eax
180007df1:     	jne	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180007df7:     	leaq	0x33c2(%rip), %rdx      # 0x18000b1c0
180007dfe:     	movq	%r14, %rcx
180007e01:     	callq	*0x2361(%rip)           # 0x18000a168
180007e07:     	movq	%rax, 0x28(%rsp)
180007e0c:     	movq	%rax, %rdi
180007e0f:     	testq	%rax, %rax
180007e12:     	je	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180007e18:     	leaq	0x353a(%rip), %rcx      # 0x18000b359
180007e1f:     	callq	*0x245b(%rip)           # 0x18000a280
180007e25:     	movq	%rax, 0x20(%rsp)
180007e2a:     	movq	%rax, %r12
180007e2d:     	testq	%rax, %rax
180007e30:     	je	0x180008174 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5c04>
180007e36:     	movl	%ebx, %ebp
180007e38:     	cmpq	%rbx, (%rsi)
180007e3b:     	je	0x180007fe4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5a74>
180007e41:     	movslq	%ebp, %rbx
180007e44:     	leaq	0x30(%rsp), %rdx
180007e49:     	movq	%r14, %rcx
180007e4c:     	leaq	(%rbx,%rbx,4), %rax
180007e50:     	movups	(%r13,%rax,8), %xmm0
180007e56:     	movups	0x10(%r13,%rax,8), %xmm1
180007e5c:     	movaps	%xmm0, 0x30(%rsp)
180007e61:     	movsd	0x20(%r13,%rax,8), %xmm0
180007e68:     	movsd	%xmm0, 0x50(%rsp)
180007e6e:     	movaps	%xmm1, 0x40(%rsp)
180007e73:     	callq	0x180007970 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5400>
180007e78:     	movq	%rax, %r14
180007e7b:     	testq	%rax, %rax
180007e7e:     	je	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
180007e84:     	movq	(%rsi), %rcx
180007e87:     	callq	*0x23f3(%rip)           # 0x18000a280
180007e8d:     	movq	%rax, %r13
180007e90:     	testq	%rax, %rax
180007e93:     	je	0x180008197 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5c27>
180007e99:     	movq	(%r15,%rbx,8), %rcx
180007e9d:     	xorl	%edx, %edx
180007e9f:     	movq	%r14, (%rcx)
180007ea2:     	leaq	0x9977(%rip), %rcx      # 0x180011820
180007ea9:     	movq	0x8(%rsi), %r12
180007ead:     	callq	*0x229d(%rip)           # 0x18000a150
180007eb3:     	movq	%rax, %rbx
180007eb6:     	testq	%rax, %rax
180007eb9:     	je	0x180007f36 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c6>
180007ebb:     	movq	%r13, %rcx
180007ebe:     	callq	*0x22bc(%rip)           # 0x18000a180
180007ec4:     	movq	%rax, %rdi
180007ec7:     	testq	%rax, %rax
180007eca:     	je	0x180007eec <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x597c>
180007ecc:     	movq	%rax, %rcx
180007ecf:     	callq	0x180009775 <numba_list_iter_next+0xed5>
180007ed4:     	leaq	0x1(%rax), %rcx
180007ed8:     	callq	*0x2372(%rip)           # 0x18000a250
180007ede:     	movq	%rax, %rsi
180007ee1:     	testq	%rax, %rax
180007ee4:     	jne	0x180007ef4 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5984>
180007ee6:     	callq	*0x2254(%rip)           # 0x18000a140
180007eec:     	xorl	%eax, %eax
180007eee:     	movq	%rax, 0x20(%rbx)
180007ef2:     	jmp	0x180007f25 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59b5>
180007ef4:     	movq	%rdi, %rdx
180007ef7:     	movq	%rsi, %rcx
180007efa:     	callq	0x18000976f <numba_list_iter_next+0xecf>
180007eff:     	movq	0x20(%rsp), %rcx
180007f04:     	movq	%rsi, 0x20(%rbx)
180007f08:     	movq	%r12, 0x28(%rbx)
180007f0c:     	movl	$0x3, 0x30(%rbx)
180007f13:     	callq	0x1800073f0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x4e80>
180007f18:     	movq	%rax, 0x38(%rbx)
180007f1c:     	testq	%rax, %rax
180007f1f:     	jne	0x180008090 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b20>
180007f25:     	movl	(%rbx), %eax
180007f27:     	testl	%eax, %eax
180007f29:     	js	0x180007f36 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c6>
180007f2b:     	subl	$0x1, %eax
180007f2e:     	movl	%eax, (%rbx)
180007f30:     	je	0x1800080dd <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b6d>
180007f36:     	xorl	%edi, %edi
180007f38:     	movl	(%r14), %eax
180007f3b:     	testl	%eax, %eax
180007f3d:     	js	0x180007f50 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59e0>
180007f3f:     	subl	$0x1, %eax
180007f42:     	movl	%eax, (%r14)
180007f45:     	jne	0x180007f50 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59e0>
180007f47:     	movq	%r14, %rcx
180007f4a:     	callq	*0x2278(%rip)           # 0x18000a1c8
180007f50:     	movl	(%r13), %eax
180007f54:     	testl	%eax, %eax
180007f56:     	js	0x180007f6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59fa>
180007f58:     	subl	$0x1, %eax
180007f5b:     	movl	%eax, (%r13)
180007f5f:     	jne	0x180007f6a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59fa>
180007f61:     	movq	%r13, %rcx
180007f64:     	callq	*0x225e(%rip)           # 0x18000a1c8
180007f6a:     	testq	%rdi, %rdi
180007f6d:     	je	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
180007f73:     	movq	0xb8(%rsp), %rsi
180007f7b:     	movq	%rdi, %r8
180007f7e:     	movq	0xb0(%rsp), %r14
180007f86:     	movq	%r14, %rcx
180007f89:     	movq	(%rsi), %rdx
180007f8c:     	callq	*0x228e(%rip)           # 0x18000a220
180007f92:     	movl	(%rdi), %ecx
180007f94:     	testl	%eax, %eax
180007f96:     	jne	0x18000813a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5bca>
180007f9c:     	testl	%ecx, %ecx
180007f9e:     	js	0x180007fb2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5a42>
180007fa0:     	leal	-0x1(%rcx), %eax
180007fa3:     	movl	%eax, (%rdi)
180007fa5:     	testl	%eax, %eax
180007fa7:     	jne	0x180007fb2 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5a42>
180007fa9:     	movq	%rdi, %rcx
180007fac:     	callq	*0x2216(%rip)           # 0x18000a1c8
180007fb2:     	movq	0xc8(%rsp), %r15
180007fba:     	addq	$0x20, %rsi
180007fbe:     	movq	0xc0(%rsp), %r13
180007fc6:     	incl	%ebp
180007fc8:     	movq	%rsi, 0xb8(%rsp)
180007fd0:     	cmpq	$0x0, (%rsi)
180007fd4:     	jne	0x180007e41 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x58d1>
180007fda:     	movq	0x20(%rsp), %r12
180007fdf:     	movq	0x28(%rsp), %rdi
180007fe4:     	movslq	%ebp, %rax
180007fe7:     	cmpq	$0x0, (%r15,%rax,8)
180007fec:     	je	0x180008059 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5ae9>
180007fee:     	nop
180007ff0:     	movslq	%ebp, %rbx
180007ff3:     	leaq	0x30(%rsp), %rdx
180007ff8:     	movq	%r14, %rcx
180007ffb:     	leaq	(%rbx,%rbx,4), %rax
180007fff:     	movups	(%r13,%rax,8), %xmm0
180008005:     	movups	0x10(%r13,%rax,8), %xmm1
18000800b:     	movaps	%xmm0, 0x30(%rsp)
180008010:     	movsd	0x20(%r13,%rax,8), %xmm0
180008017:     	movsd	%xmm0, 0x50(%rsp)
18000801d:     	movaps	%xmm1, 0x40(%rsp)
180008022:     	callq	0x180007970 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5400>
180008027:     	testq	%rax, %rax
18000802a:     	je	0x180008155 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be5>
180008030:     	movq	(%r15,%rbx,8), %rcx
180008034:     	movq	%rax, (%rcx)
180008037:     	movl	(%rax), %ecx
180008039:     	testl	%ecx, %ecx
18000803b:     	js	0x18000804d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5add>
18000803d:     	subl	$0x1, %ecx
180008040:     	movl	%ecx, (%rax)
180008042:     	jne	0x18000804d <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5add>
180008044:     	movq	%rax, %rcx
180008047:     	callq	*0x217b(%rip)           # 0x18000a1c8
18000804d:     	incl	%ebp
18000804f:     	movslq	%ebp, %rax
180008052:     	cmpq	$0x0, (%r15,%rax,8)
180008057:     	jne	0x180007ff0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5a80>
180008059:     	movl	(%r12), %eax
18000805d:     	testl	%eax, %eax
18000805f:     	js	0x180008073 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b03>
180008061:     	subl	$0x1, %eax
180008064:     	movl	%eax, (%r12)
180008068:     	jne	0x180008073 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b03>
18000806a:     	movq	%r12, %rcx
18000806d:     	callq	*0x2155(%rip)           # 0x18000a1c8
180008073:     	movl	(%rdi), %eax
180008075:     	testl	%eax, %eax
180008077:     	js	0x180008089 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b19>
180008079:     	subl	$0x1, %eax
18000807c:     	movl	%eax, (%rdi)
18000807e:     	jne	0x180008089 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b19>
180008080:     	movq	%rdi, %rcx
180008083:     	callq	*0x213f(%rip)           # 0x18000a1c8
180008089:     	xorl	%eax, %eax
18000808b:     	jmp	0x180007c79 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5709>
180008090:     	movl	(%r14), %eax
180008093:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180008098:     	jae	0x18000809f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b2f>
18000809a:     	incl	%eax
18000809c:     	movl	%eax, (%r14)
18000809f:     	movq	0xb0(%rsp), %rcx
1800080a7:     	leaq	0x3112(%rip), %rdx      # 0x18000b1c0
1800080ae:     	movq	%r14, 0x18(%rbx)
1800080b2:     	movq	$0x0, 0x40(%rbx)
1800080ba:     	callq	*0x20a8(%rip)           # 0x18000a168
1800080c0:     	movq	%rax, %rsi
1800080c3:     	testq	%rax, %rax
1800080c6:     	jne	0x1800080eb <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5b7b>
1800080c8:     	movl	(%rbx), %eax
1800080ca:     	testl	%eax, %eax
1800080cc:     	js	0x180007f36 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c6>
1800080d2:     	subl	$0x1, %eax
1800080d5:     	movl	%eax, (%rbx)
1800080d7:     	jne	0x180007f36 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c6>
1800080dd:     	movq	%rbx, %rcx
1800080e0:     	callq	*0x20e2(%rip)           # 0x18000a1c8
1800080e6:     	jmp	0x180007f36 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c6>
1800080eb:     	xorl	%r9d, %r9d
1800080ee:     	leaq	0x20(%rbx), %rcx
1800080f2:     	movq	%rsi, %r8
1800080f5:     	movq	%rbx, %rdx
1800080f8:     	callq	*0x204a(%rip)           # 0x18000a148
1800080fe:     	movq	%rax, %rdi
180008101:     	movl	(%rbx), %eax
180008103:     	testl	%eax, %eax
180008105:     	js	0x180008117 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5ba7>
180008107:     	subl	$0x1, %eax
18000810a:     	movl	%eax, (%rbx)
18000810c:     	jne	0x180008117 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5ba7>
18000810e:     	movq	%rbx, %rcx
180008111:     	callq	*0x20b1(%rip)           # 0x18000a1c8
180008117:     	movl	(%rsi), %eax
180008119:     	testl	%eax, %eax
18000811b:     	js	0x180007f38 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c8>
180008121:     	subl	$0x1, %eax
180008124:     	movl	%eax, (%rsi)
180008126:     	jne	0x180007f38 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c8>
18000812c:     	movq	%rsi, %rcx
18000812f:     	callq	*0x2093(%rip)           # 0x18000a1c8
180008135:     	jmp	0x180007f38 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x59c8>
18000813a:     	testl	%ecx, %ecx
18000813c:     	js	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
18000813e:     	leal	-0x1(%rcx), %eax
180008141:     	movl	%eax, (%rdi)
180008143:     	testl	%eax, %eax
180008145:     	jne	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
180008147:     	movq	%rdi, %rcx
18000814a:     	callq	*0x2078(%rip)           # 0x18000a1c8
180008150:     	movq	0x20(%rsp), %r12
180008155:     	movl	(%r12), %eax
180008159:     	testl	%eax, %eax
18000815b:     	js	0x18000816f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5bff>
18000815d:     	subl	$0x1, %eax
180008160:     	movl	%eax, (%r12)
180008164:     	jne	0x18000816f <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5bff>
180008166:     	movq	%r12, %rcx
180008169:     	callq	*0x2059(%rip)           # 0x18000a1c8
18000816f:     	movq	0x28(%rsp), %rdi
180008174:     	movl	(%rdi), %eax
180008176:     	testl	%eax, %eax
180008178:     	js	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
18000817e:     	subl	$0x1, %eax
180008181:     	movl	%eax, (%rdi)
180008183:     	jne	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180008189:     	movq	%rdi, %rcx
18000818c:     	callq	*0x2036(%rip)           # 0x18000a1c8
180008192:     	jmp	0x180007c74 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5704>
180008197:     	movl	(%r14), %eax
18000819a:     	testl	%eax, %eax
18000819c:     	js	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
18000819e:     	subl	$0x1, %eax
1800081a1:     	movl	%eax, (%r14)
1800081a4:     	jne	0x180008150 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5be0>
1800081a6:     	movq	%r14, %rcx
1800081a9:     	jmp	0x18000814a <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5bda>
1800081ab:     	int3
1800081ac:     	int3
1800081ad:     	int3
1800081ae:     	int3
1800081af:     	int3
1800081b0:     	leaq	0x9b51(%rip), %rax      # 0x180011d08
1800081b7:     	retq
1800081b8:     	int3
1800081b9:     	int3
1800081ba:     	int3
1800081bb:     	int3
1800081bc:     	int3
1800081bd:     	int3
1800081be:     	int3
1800081bf:     	int3

00000001800081c0 <numba_list_set_method_table>:
1800081c0:     	movups	(%rdx), %xmm0
1800081c3:     	movups	%xmm0, 0x20(%rcx)
1800081c7:     	retq
1800081c8:     	int3
1800081c9:     	int3
1800081ca:     	int3
1800081cb:     	int3
1800081cc:     	int3
1800081cd:     	int3
1800081ce:     	int3
1800081cf:     	int3

00000001800081d0 <numba_list_new>:
1800081d0:     	pushq	%rbx
1800081d2:     	pushq	%rbp
1800081d3:     	pushq	%rsi
1800081d4:     	pushq	%rdi
1800081d5:     	subq	$0x28, %rsp
1800081d9:     	movq	%rcx, %rsi
1800081dc:     	movq	%r8, %rdi
1800081df:     	movl	$0x38, %ecx
1800081e4:     	movq	%rdx, %rbp
1800081e7:     	callq	*0x1e73(%rip)           # 0x18000a060
1800081ed:     	movq	%rax, %rbx
1800081f0:     	testq	%rax, %rax
1800081f3:     	je	0x18000825d <numba_list_new+0x8d>
1800081f5:     	movq	$0x0, (%rax)
1800081fc:     	xorps	%xmm0, %xmm0
1800081ff:     	movq	%rbp, 0x8(%rax)
180008203:     	movq	%rdi, 0x10(%rax)
180008207:     	movl	$0x1, 0x18(%rax)
18000820e:     	movups	%xmm0, 0x20(%rax)
180008212:     	testq	%rdi, %rdi
180008215:     	je	0x18000826b <numba_list_new+0x9b>
180008217:     	imulq	%rbp, %rdi
18000821b:     	movl	$0x8, %ecx
180008220:     	movq	%rdi, %rax
180008223:     	cqto
180008225:     	andl	$0x7, %edx
180008228:     	addq	%rdx, %rax
18000822b:     	andl	$0x7, %eax
18000822e:     	subq	%rdx, %rax
180008231:     	subq	%rax, %rcx
180008234:     	movq	%rcx, %rax
180008237:     	cqto
180008239:     	andl	$0x7, %edx
18000823c:     	leaq	(%rdx,%rax), %rcx
180008240:     	andl	$0x7, %ecx
180008243:     	subq	%rdx, %rcx
180008246:     	addq	%rdi, %rcx
180008249:     	callq	*0x1e11(%rip)           # 0x18000a060
18000824f:     	testq	%rax, %rax
180008252:     	jne	0x18000826d <numba_list_new+0x9d>
180008254:     	movq	%rbx, %rcx
180008257:     	callq	*0x1e0b(%rip)           # 0x18000a068
18000825d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180008262:     	addq	$0x28, %rsp
180008266:     	popq	%rdi
180008267:     	popq	%rsi
180008268:     	popq	%rbp
180008269:     	popq	%rbx
18000826a:     	retq
18000826b:     	xorl	%eax, %eax
18000826d:     	movq	%rax, 0x30(%rbx)
180008271:     	xorl	%eax, %eax
180008273:     	movq	%rbx, (%rsi)
180008276:     	addq	$0x28, %rsp
18000827a:     	popq	%rdi
18000827b:     	popq	%rsi
18000827c:     	popq	%rbp
18000827d:     	popq	%rbx
18000827e:     	retq
18000827f:     	int3

0000000180008280 <numba_list_free>:
180008280:     	pushq	%rbx
180008282:     	subq	$0x20, %rsp
180008286:     	cmpq	$0x0, 0x28(%rcx)
18000828b:     	movq	%rcx, %rbx
18000828e:     	je	0x1800082c4 <numba_list_free+0x44>
180008290:     	movq	%rdi, 0x30(%rsp)
180008295:     	xorl	%edi, %edi
180008297:     	cmpq	%rdi, (%rcx)
18000829a:     	jle	0x1800082bf <numba_list_free+0x3f>
18000829c:     	nopl	(%rax)
1800082a0:     	movq	0x28(%rbx), %rax
1800082a4:     	testq	%rax, %rax
1800082a7:     	je	0x1800082b7 <numba_list_free+0x37>
1800082a9:     	movq	%rdi, %rcx
1800082ac:     	imulq	0x8(%rbx), %rcx
1800082b1:     	addq	0x30(%rbx), %rcx
1800082b5:     	callq	*%rax
1800082b7:     	incq	%rdi
1800082ba:     	cmpq	(%rbx), %rdi
1800082bd:     	jl	0x1800082a0 <numba_list_free+0x20>
1800082bf:     	movq	0x30(%rsp), %rdi
1800082c4:     	movq	0x30(%rbx), %rcx
1800082c8:     	testq	%rcx, %rcx
1800082cb:     	je	0x1800082d3 <numba_list_free+0x53>
1800082cd:     	callq	*0x1d95(%rip)           # 0x18000a068
1800082d3:     	movq	%rbx, %rcx
1800082d6:     	addq	$0x20, %rsp
1800082da:     	popq	%rbx
1800082db:     	jmpq	*0x1d86(%rip)           # 0x18000a068
1800082e2:     	int3
1800082e3:     	int3
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

00000001800082f0 <numba_list_base_ptr>:
1800082f0:     	movq	0x30(%rcx), %rax
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

0000000180008300 <numba_list_size_address>:
180008300:     	movq	%rcx, %rax
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

0000000180008310 <numba_list_length>:
180008310:     	movq	(%rcx), %rax
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

0000000180008320 <numba_list_allocated>:
180008320:     	movq	0x10(%rcx), %rax
180008324:     	retq
180008325:     	int3
180008326:     	int3
180008327:     	int3
180008328:     	int3
180008329:     	int3
18000832a:     	int3
18000832b:     	int3
18000832c:     	int3
18000832d:     	int3
18000832e:     	int3
18000832f:     	int3

0000000180008330 <numba_list_is_mutable>:
180008330:     	movl	0x18(%rcx), %eax
180008333:     	retq
180008334:     	int3
180008335:     	int3
180008336:     	int3
180008337:     	int3
180008338:     	int3
180008339:     	int3
18000833a:     	int3
18000833b:     	int3
18000833c:     	int3
18000833d:     	int3
18000833e:     	int3
18000833f:     	int3

0000000180008340 <numba_list_set_is_mutable>:
180008340:     	movl	%edx, 0x18(%rcx)
180008343:     	retq
180008344:     	int3
180008345:     	int3
180008346:     	int3
180008347:     	int3
180008348:     	int3
180008349:     	int3
18000834a:     	int3
18000834b:     	int3
18000834c:     	int3
18000834d:     	int3
18000834e:     	int3
18000834f:     	int3

0000000180008350 <numba_list_setitem>:
180008350:     	movq	%rbx, 0x10(%rsp)
180008355:     	pushq	%rsi
180008356:     	subq	$0x20, %rsp
18000835a:     	cmpl	$0x0, 0x18(%rcx)
18000835e:     	movq	%r8, %rsi
180008361:     	movq	%rcx, %rbx
180008364:     	jne	0x180008376 <numba_list_setitem+0x26>
180008366:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000836b:     	movq	0x38(%rsp), %rbx
180008370:     	addq	$0x20, %rsp
180008374:     	popq	%rsi
180008375:     	retq
180008376:     	cmpq	(%rcx), %rdx
180008379:     	jb	0x18000838b <numba_list_setitem+0x3b>
18000837b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180008380:     	movq	0x38(%rsp), %rbx
180008385:     	addq	$0x20, %rsp
180008389:     	popq	%rsi
18000838a:     	retq
18000838b:     	imulq	0x8(%rcx), %rdx
180008390:     	movq	0x28(%rcx), %rax
180008394:     	movq	%rdi, 0x30(%rsp)
180008399:     	movq	0x30(%rcx), %rdi
18000839d:     	addq	%rdx, %rdi
1800083a0:     	testq	%rax, %rax
1800083a3:     	je	0x1800083aa <numba_list_setitem+0x5a>
1800083a5:     	movq	%rdi, %rcx
1800083a8:     	callq	*%rax
1800083aa:     	movq	0x8(%rbx), %r8
1800083ae:     	movq	%rsi, %rdx
1800083b1:     	movq	%rdi, %rcx
1800083b4:     	callq	0x180009763 <numba_list_iter_next+0xec3>
1800083b9:     	movq	0x20(%rbx), %rax
1800083bd:     	testq	%rax, %rax
1800083c0:     	je	0x1800083c7 <numba_list_setitem+0x77>
1800083c2:     	movq	%rdi, %rcx
1800083c5:     	callq	*%rax
1800083c7:     	movq	0x30(%rsp), %rdi
1800083cc:     	xorl	%eax, %eax
1800083ce:     	movq	0x38(%rsp), %rbx
1800083d3:     	addq	$0x20, %rsp
1800083d7:     	popq	%rsi
1800083d8:     	retq
1800083d9:     	int3
1800083da:     	int3
1800083db:     	int3
1800083dc:     	int3
1800083dd:     	int3
1800083de:     	int3
1800083df:     	int3

00000001800083e0 <numba_list_getitem>:
1800083e0:     	subq	$0x28, %rsp
1800083e4:     	movq	%r8, %r9
1800083e7:     	movq	%rdx, %rax
1800083ea:     	cmpq	(%rcx), %rdx
1800083ed:     	jb	0x1800083f9 <numba_list_getitem+0x19>
1800083ef:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800083f4:     	addq	$0x28, %rsp
1800083f8:     	retq
1800083f9:     	movq	0x8(%rcx), %r8
1800083fd:     	movq	%r8, %rdx
180008400:     	imulq	%rax, %rdx
180008404:     	addq	0x30(%rcx), %rdx
180008408:     	movq	%r9, %rcx
18000840b:     	callq	0x180009763 <numba_list_iter_next+0xec3>
180008410:     	xorl	%eax, %eax
180008412:     	addq	$0x28, %rsp
180008416:     	retq
180008417:     	int3
180008418:     	int3
180008419:     	int3
18000841a:     	int3
18000841b:     	int3
18000841c:     	int3
18000841d:     	int3
18000841e:     	int3
18000841f:     	int3

0000000180008420 <numba_list_append>:
180008420:     	movq	%rbx, 0x10(%rsp)
180008425:     	pushq	%rsi
180008426:     	subq	$0x20, %rsp
18000842a:     	cmpl	$0x0, 0x18(%rcx)
18000842e:     	movq	%rdx, %rsi
180008431:     	movq	%rcx, %rbx
180008434:     	jne	0x180008446 <numba_list_append+0x26>
180008436:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000843b:     	movq	0x38(%rsp), %rbx
180008440:     	addq	$0x20, %rsp
180008444:     	popq	%rsi
180008445:     	retq
180008446:     	movq	(%rcx), %rdx
180008449:     	incq	%rdx
18000844c:     	callq	0x1800084a0 <numba_list_resize>
180008451:     	testl	%eax, %eax
180008453:     	js	0x18000848c <numba_list_append+0x6c>
180008455:     	movq	0x8(%rbx), %r8
180008459:     	movq	%rsi, %rdx
18000845c:     	movq	%rdi, 0x30(%rsp)
180008461:     	movq	(%rbx), %rdi
180008464:     	decq	%rdi
180008467:     	imulq	%r8, %rdi
18000846b:     	addq	0x30(%rbx), %rdi
18000846f:     	movq	%rdi, %rcx
180008472:     	callq	0x180009763 <numba_list_iter_next+0xec3>
180008477:     	movq	0x20(%rbx), %rax
18000847b:     	testq	%rax, %rax
18000847e:     	je	0x180008485 <numba_list_append+0x65>
180008480:     	movq	%rdi, %rcx
180008483:     	callq	*%rax
180008485:     	movq	0x30(%rsp), %rdi
18000848a:     	xorl	%eax, %eax
18000848c:     	movq	0x38(%rsp), %rbx
180008491:     	addq	$0x20, %rsp
180008495:     	popq	%rsi
180008496:     	retq
180008497:     	int3
180008498:     	int3
180008499:     	int3
18000849a:     	int3
18000849b:     	int3
18000849c:     	int3
18000849d:     	int3
18000849e:     	int3
18000849f:     	int3

00000001800084a0 <numba_list_resize>:
1800084a0:     	movq	%rsi, 0x18(%rsp)
1800084a5:     	pushq	%rdi
1800084a6:     	subq	$0x20, %rsp
1800084aa:     	cmpl	$0x0, 0x18(%rcx)
1800084ae:     	movq	%rdx, %rsi
1800084b1:     	movq	%rcx, %rdi
1800084b4:     	jne	0x1800084c6 <numba_list_resize+0x26>
1800084b6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800084bb:     	movq	0x40(%rsp), %rsi
1800084c0:     	addq	$0x20, %rsp
1800084c4:     	popq	%rdi
1800084c5:     	retq
1800084c6:     	movq	0x10(%rcx), %rax
1800084ca:     	cmpq	%rsi, %rax
1800084cd:     	jl	0x1800084e7 <numba_list_resize+0x47>
1800084cf:     	sarq	%rax
1800084d2:     	cmpq	%rax, %rsi
1800084d5:     	jl	0x1800084e7 <numba_list_resize+0x47>
1800084d7:     	movq	%rsi, (%rcx)
1800084da:     	xorl	%eax, %eax
1800084dc:     	movq	0x40(%rsp), %rsi
1800084e1:     	addq	$0x20, %rsp
1800084e5:     	popq	%rdi
1800084e6:     	retq
1800084e7:     	cmpq	$0x9, %rsi
1800084eb:     	movq	%rbp, 0x38(%rsp)
1800084f0:     	movl	$0x3, %ecx
1800084f5:     	movl	$0x6, %eax
1800084fa:     	cmovll	%ecx, %eax
1800084fd:     	movq	%rsi, %r8
180008500:     	movq	0x8(%rdi), %rcx
180008504:     	addq	%rsi, %rax
180008507:     	sarq	$0x3, %r8
18000850b:     	xorl	%edx, %edx
18000850d:     	addq	%rax, %r8
180008510:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000851a:     	divq	%rcx
18000851d:     	cmpq	%rax, %r8
180008520:     	ja	0x18000859b <numba_list_resize+0xfb>
180008522:     	xorl	%ebp, %ebp
180008524:     	movq	%rbx, 0x30(%rsp)
180008529:     	testq	%rsi, %rsi
18000852c:     	cmovneq	%r8, %rbp
180008530:     	movq	%rbp, %rbx
180008533:     	imulq	%rcx, %rbx
180008537:     	movl	$0x8, %ecx
18000853c:     	movq	%rbx, %rax
18000853f:     	cqto
180008541:     	andl	$0x7, %edx
180008544:     	addq	%rdx, %rax
180008547:     	andl	$0x7, %eax
18000854a:     	subq	%rdx, %rax
18000854d:     	subq	%rax, %rcx
180008550:     	movq	%rcx, %rax
180008553:     	movq	0x30(%rdi), %rcx
180008557:     	cqto
180008559:     	andl	$0x7, %edx
18000855c:     	addq	%rdx, %rax
18000855f:     	andl	$0x7, %eax
180008562:     	subq	%rdx, %rax
180008565:     	leaq	(%rbx,%rax), %rdx
180008569:     	callq	*0x1b01(%rip)           # 0x18000a070
18000856f:     	testq	%rbx, %rbx
180008572:     	movq	0x30(%rsp), %rbx
180008577:     	je	0x18000857e <numba_list_resize+0xde>
180008579:     	testq	%rax, %rax
18000857c:     	je	0x18000859b <numba_list_resize+0xfb>
18000857e:     	movq	%rax, 0x30(%rdi)
180008582:     	xorl	%eax, %eax
180008584:     	movq	%rbp, 0x10(%rdi)
180008588:     	movq	0x38(%rsp), %rbp
18000858d:     	movq	%rsi, (%rdi)
180008590:     	movq	0x40(%rsp), %rsi
180008595:     	addq	$0x20, %rsp
180008599:     	popq	%rdi
18000859a:     	retq
18000859b:     	movq	0x38(%rsp), %rbp
1800085a0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800085a5:     	movq	0x40(%rsp), %rsi
1800085aa:     	addq	$0x20, %rsp
1800085ae:     	popq	%rdi
1800085af:     	retq

00000001800085b0 <numba_list_delitem>:
1800085b0:     	movq	%rbx, 0x10(%rsp)
1800085b5:     	pushq	%rdi
1800085b6:     	subq	$0x20, %rsp
1800085ba:     	cmpl	$0x0, 0x18(%rcx)
1800085be:     	movq	%rdx, %rdi
1800085c1:     	movq	%rcx, %rbx
1800085c4:     	jne	0x1800085d6 <numba_list_delitem+0x26>
1800085c6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800085cb:     	movq	0x38(%rsp), %rbx
1800085d0:     	addq	$0x20, %rsp
1800085d4:     	popq	%rdi
1800085d5:     	retq
1800085d6:     	cmpq	(%rcx), %rdi
1800085d9:     	jb	0x1800085eb <numba_list_delitem+0x3b>
1800085db:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800085e0:     	movq	0x38(%rsp), %rbx
1800085e5:     	addq	$0x20, %rsp
1800085e9:     	popq	%rdi
1800085ea:     	retq
1800085eb:     	movq	0x28(%rcx), %rax
1800085ef:     	movq	%rsi, 0x30(%rsp)
1800085f4:     	movq	%rdi, %rsi
1800085f7:     	imulq	0x8(%rcx), %rsi
1800085fc:     	addq	0x30(%rcx), %rsi
180008600:     	testq	%rax, %rax
180008603:     	je	0x18000860a <numba_list_delitem+0x5a>
180008605:     	movq	%rsi, %rcx
180008608:     	callq	*%rax
18000860a:     	movq	(%rbx), %r8
18000860d:     	leaq	-0x1(%r8), %rax
180008611:     	cmpq	%rax, %rdi
180008614:     	je	0x180008636 <numba_list_delitem+0x86>
180008616:     	subq	%rdi, %r8
180008619:     	leaq	0x1(%rdi), %rdx
18000861d:     	imulq	0x8(%rbx), %rdx
180008622:     	decq	%r8
180008625:     	movq	%rsi, %rcx
180008628:     	imulq	0x8(%rbx), %r8
18000862d:     	addq	0x30(%rbx), %rdx
180008631:     	callq	0x180009769 <numba_list_iter_next+0xec9>
180008636:     	movq	(%rbx), %rdx
180008639:     	movq	%rbx, %rcx
18000863c:     	decq	%rdx
18000863f:     	callq	0x1800084a0 <numba_list_resize>
180008644:     	movq	0x30(%rsp), %rsi
180008649:     	xorl	%ecx, %ecx
18000864b:     	movq	0x38(%rsp), %rbx
180008650:     	testl	%eax, %eax
180008652:     	cmovsl	%eax, %ecx
180008655:     	movl	%ecx, %eax
180008657:     	addq	$0x20, %rsp
18000865b:     	popq	%rdi
18000865c:     	retq
18000865d:     	int3
18000865e:     	int3
18000865f:     	int3

0000000180008660 <numba_list_delete_slice>:
180008660:     	pushq	%rbx
180008662:     	pushq	%rbp
180008663:     	pushq	%rdi
180008664:     	pushq	%r15
180008666:     	subq	$0x38, %rsp
18000866a:     	cmpl	$0x0, 0x18(%rcx)
18000866e:     	movq	%r9, %rdi
180008671:     	movq	%r8, %rbp
180008674:     	movq	%rdx, %r15
180008677:     	movq	%rcx, %rbx
18000867a:     	jne	0x18000868b <numba_list_delete_slice+0x2b>
18000867c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180008681:     	addq	$0x38, %rsp
180008685:     	popq	%r15
180008687:     	popq	%rdi
180008688:     	popq	%rbp
180008689:     	popq	%rbx
18000868a:     	retq
18000868b:     	movq	%r13, 0x78(%rsp)
180008690:     	testq	%rdi, %rdi
180008693:     	jle	0x1800086b2 <numba_list_delete_slice+0x52>
180008695:     	cmpq	%r8, %r15
180008698:     	jge	0x180008851 <numba_list_delete_slice+0x1f1>
18000869e:     	movq	%r8, %rax
1800086a1:     	subq	%r15, %rax
1800086a4:     	decq	%rax
1800086a7:     	cqto
1800086a9:     	idivq	%rdi
1800086ac:     	leal	0x1(%rax), %r13d
1800086b0:     	jmp	0x1800086d2 <numba_list_delete_slice+0x72>
1800086b2:     	cmpq	%r15, %r8
1800086b5:     	jge	0x180008851 <numba_list_delete_slice+0x1f1>
1800086bb:     	movq	%r15, %rax
1800086be:     	movl	$0x1, %r13d
1800086c4:     	subq	%r8, %rax
1800086c7:     	decq	%rax
1800086ca:     	cqto
1800086cc:     	idivq	%rdi
1800086cf:     	subl	%eax, %r13d
1800086d2:     	testl	%r13d, %r13d
1800086d5:     	jle	0x180008851 <numba_list_delete_slice+0x1f1>
1800086db:     	movq	%rsi, 0x68(%rsp)
1800086e0:     	movl	(%rcx), %esi
1800086e2:     	subl	%r13d, %esi
1800086e5:     	movl	%esi, 0x20(%rsp)
1800086e9:     	testq	%rdi, %rdi
1800086ec:     	jns	0x180008707 <numba_list_delete_slice+0xa7>
1800086ee:     	leaq	0x1(%r15), %rbp
1800086f2:     	leal	-0x1(%r13), %eax
1800086f6:     	movslq	%eax, %rcx
1800086f9:     	leaq	-0x1(%rbp), %r15
1800086fd:     	imulq	%rdi, %rcx
180008701:     	addq	%rcx, %r15
180008704:     	negq	%rdi
180008707:     	cmpq	$0x1, %rdi
18000870b:     	jne	0x180008757 <numba_list_delete_slice+0xf7>
18000870d:     	cmpq	$0x0, 0x28(%rbx)
180008712:     	je	0x180008739 <numba_list_delete_slice+0xd9>
180008714:     	movslq	%r15d, %rdi
180008717:     	cmpq	%rbp, %rdi
18000871a:     	jge	0x180008739 <numba_list_delete_slice+0xd9>
18000871c:     	nopl	(%rax)
180008720:     	movslq	%edi, %rcx
180008723:     	imulq	0x8(%rbx), %rcx
180008728:     	addq	0x30(%rbx), %rcx
18000872c:     	callq	*0x28(%rbx)
18000872f:     	incl	%edi
180008731:     	movslq	%edi, %rax
180008734:     	cmpq	%rbp, %rax
180008737:     	jl	0x180008720 <numba_list_delete_slice+0xc0>
180008739:     	movq	0x8(%rbx), %rcx
18000873d:     	movq	(%rbx), %r8
180008740:     	movq	%rcx, %rdx
180008743:     	subq	%rbp, %r8
180008746:     	imulq	%rcx, %r8
18000874a:     	imulq	%rbp, %rdx
18000874e:     	imulq	%r15, %rcx
180008752:     	jmp	0x18000881c <numba_list_delete_slice+0x1bc>
180008757:     	movq	%r14, 0x30(%rsp)
18000875c:     	movq	%r15, %r14
18000875f:     	movl	$0x0, 0x60(%rsp)
180008767:     	cmpq	%rbp, %r15
18000876a:     	jge	0x1800087e9 <numba_list_delete_slice+0x189>
18000876c:     	movq	%r12, 0x70(%rsp)
180008771:     	movq	(%rbx), %rax
180008774:     	leaq	(%r14,%rdi), %r12
180008778:     	cmpq	%rax, %r12
18000877b:     	jl	0x180008788 <numba_list_delete_slice+0x128>
18000877d:     	movq	%r14, %rsi
180008780:     	notq	%rsi
180008783:     	addq	%rax, %rsi
180008786:     	jmp	0x18000878c <numba_list_delete_slice+0x12c>
180008788:     	leaq	-0x1(%rdi), %rsi
18000878c:     	movq	0x28(%rbx), %rax
180008790:     	testq	%rax, %rax
180008793:     	je	0x1800087a3 <numba_list_delete_slice+0x143>
180008795:     	movq	%r14, %rcx
180008798:     	imulq	0x8(%rbx), %rcx
18000879d:     	addq	0x30(%rbx), %rcx
1800087a1:     	callq	*%rax
1800087a3:     	movq	0x8(%rbx), %r9
1800087a7:     	leaq	0x1(%r14), %rdx
1800087ab:     	movq	0x30(%rbx), %r10
1800087af:     	movq	%r9, %r8
1800087b2:     	imulq	%rsi, %r8
1800087b6:     	imulq	%r9, %rdx
1800087ba:     	movslq	0x60(%rsp), %rsi
1800087bf:     	subq	%rsi, %r14
1800087c2:     	imulq	%r9, %r14
1800087c6:     	addq	%r10, %rdx
1800087c9:     	leaq	(%r10,%r14), %rcx
1800087cd:     	callq	0x180009769 <numba_list_iter_next+0xec9>
1800087d2:     	incl	%esi
1800087d4:     	movq	%r12, %r14
1800087d7:     	movl	%esi, 0x60(%rsp)
1800087db:     	cmpq	%rbp, %r12
1800087de:     	jl	0x180008771 <numba_list_delete_slice+0x111>
1800087e0:     	movq	0x70(%rsp), %r12
1800087e5:     	movl	0x20(%rsp), %esi
1800087e9:     	movq	(%rbx), %r8
1800087ec:     	movq	0x30(%rsp), %r14
1800087f1:     	movslq	%r13d, %r10
1800087f4:     	movq	%r10, %rcx
1800087f7:     	imulq	%rdi, %rcx
1800087fb:     	addq	%r15, %rcx
1800087fe:     	cmpq	%r8, %rcx
180008801:     	jge	0x180008829 <numba_list_delete_slice+0x1c9>
180008803:     	movq	0x8(%rbx), %rax
180008807:     	subq	%rcx, %r8
18000880a:     	movq	%rax, %rdx
18000880d:     	imulq	%rcx, %rdx
180008811:     	imulq	%rax, %r8
180008815:     	subq	%r10, %rcx
180008818:     	imulq	%rax, %rcx
18000881c:     	addq	0x30(%rbx), %rdx
180008820:     	addq	0x30(%rbx), %rcx
180008824:     	callq	0x180009769 <numba_list_iter_next+0xec9>
180008829:     	movslq	%esi, %rdx
18000882c:     	movq	%rbx, %rcx
18000882f:     	callq	0x1800084a0 <numba_list_resize>
180008834:     	movq	0x68(%rsp), %rsi
180008839:     	xorl	%ecx, %ecx
18000883b:     	movq	0x78(%rsp), %r13
180008840:     	testl	%eax, %eax
180008842:     	cmovsl	%eax, %ecx
180008845:     	movl	%ecx, %eax
180008847:     	addq	$0x38, %rsp
18000884b:     	popq	%r15
18000884d:     	popq	%rdi
18000884e:     	popq	%rbp
18000884f:     	popq	%rbx
180008850:     	retq
180008851:     	movq	0x78(%rsp), %r13
180008856:     	xorl	%eax, %eax
180008858:     	addq	$0x38, %rsp
18000885c:     	popq	%r15
18000885e:     	popq	%rdi
18000885f:     	popq	%rbp
180008860:     	popq	%rbx
180008861:     	retq
180008862:     	int3
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

0000000180008870 <numba_list_iter_sizeof>:
180008870:     	movl	$0x18, %eax
180008875:     	retq
180008876:     	int3
180008877:     	int3
180008878:     	int3
180008879:     	int3
18000887a:     	int3
18000887b:     	int3
18000887c:     	int3
18000887d:     	int3
18000887e:     	int3
18000887f:     	int3

0000000180008880 <numba_list_iter>:
180008880:     	movq	%rdx, (%rcx)
180008883:     	movq	(%rdx), %rax
180008886:     	movq	%rax, 0x8(%rcx)
18000888a:     	movq	$0x0, 0x10(%rcx)
180008892:     	retq
180008893:     	int3
180008894:     	int3
180008895:     	int3
180008896:     	int3
180008897:     	int3
180008898:     	int3
180008899:     	int3
18000889a:     	int3
18000889b:     	int3
18000889c:     	int3
18000889d:     	int3
18000889e:     	int3
18000889f:     	int3

00000001800088a0 <numba_list_iter_next>:
1800088a0:     	movq	(%rcx), %r8
1800088a3:     	movq	(%r8), %r9
1800088a6:     	cmpq	0x8(%rcx), %r9
1800088aa:     	je	0x1800088b2 <numba_list_iter_next+0x12>
1800088ac:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
1800088b1:     	retq
1800088b2:     	movq	0x10(%rcx), %rax
1800088b6:     	cmpq	%r9, %rax
1800088b9:     	jge	0x1800088ce <numba_list_iter_next+0x2e>
1800088bb:     	imulq	0x8(%r8), %rax
1800088c0:     	addq	0x30(%r8), %rax
1800088c4:     	movq	%rax, (%rdx)
1800088c7:     	incq	0x10(%rcx)
1800088cb:     	xorl	%eax, %eax
1800088cd:     	retq
1800088ce:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
1800088d3:     	retq
1800088d4:     	int3
1800088d5:     	int3
1800088d6:     	int3
1800088d7:     	int3
1800088d8:     	int3
1800088d9:     	int3
1800088da:     	int3
1800088db:     	int3
1800088dc:     	int3
1800088dd:     	int3
1800088de:     	int3
1800088df:     	int3
1800088e0:     	pushq	%rbx
1800088e2:     	subq	$0x20, %rsp
1800088e6:     	movq	%rcx, %rbx
1800088e9:     	addq	$0x30, %rcx
1800088ed:     	callq	*0x9375(%rip)           # 0x180011c68
1800088f3:     	cmpb	$0x0, 0x9346(%rip)      # 0x180011c40
1800088fa:     	je	0x180008904 <numba_list_iter_next+0x64>
1800088fc:     	lock
1800088fd:     	incq	0x9344(%rip)            # 0x180011c48
180008904:     	testq	%rax, %rax
180008907:     	je	0x180008948 <numba_list_iter_next+0xa8>
180008909:     	leaq	0x30(%rax), %rdx
18000890d:     	testq	%rdx, %rdx
180008910:     	je	0x180008948 <numba_list_iter_next+0xa8>
180008912:     	xorl	%r8d, %r8d
180008915:     	movl	$0x1, %ecx
18000891a:     	xchgq	%rcx, (%rax)
18000891d:     	movq	%r8, 0x8(%rax)
180008921:     	movq	%r8, 0x10(%rax)
180008925:     	movq	%rdx, 0x18(%rax)
180008929:     	movq	%rbx, 0x20(%rax)
18000892d:     	movq	%r8, 0x28(%rax)
180008931:     	cmpb	%r8b, 0x9308(%rip)      # 0x180011c40
180008938:     	je	0x18000894a <numba_list_iter_next+0xaa>
18000893a:     	lock
18000893b:     	incq	0x9316(%rip)            # 0x180011c58
180008942:     	addq	$0x20, %rsp
180008946:     	popq	%rbx
180008947:     	retq
180008948:     	xorl	%eax, %eax
18000894a:     	addq	$0x20, %rsp
18000894e:     	popq	%rbx
18000894f:     	retq
180008950:     	movq	%rbx, 0x8(%rsp)
180008955:     	pushq	%rdi
180008956:     	subq	$0x20, %rsp
18000895a:     	movq	%rcx, %rdi
18000895d:     	movq	%rdx, %rbx
180008960:     	addq	$0x30, %rcx
180008964:     	testq	%rdx, %rdx
180008967:     	je	0x180008971 <numba_list_iter_next+0xd1>
180008969:     	movq	0x18(%rdx), %rdx
18000896d:     	callq	*(%rbx)
18000896f:     	jmp	0x180008977 <numba_list_iter_next+0xd7>
180008971:     	callq	*0x92f1(%rip)           # 0x180011c68
180008977:     	cmpb	$0x0, 0x92c2(%rip)      # 0x180011c40
18000897e:     	movq	%rax, %r8
180008981:     	je	0x18000898b <numba_list_iter_next+0xeb>
180008983:     	lock
180008984:     	incq	0x92bd(%rip)            # 0x180011c48
18000898b:     	xorl	%edx, %edx
18000898d:     	leaq	0x30(%r8), %rax
180008991:     	testq	%r8, %r8
180008994:     	movl	%edx, %ecx
180008996:     	cmovneq	%rax, %rcx
18000899a:     	testq	%rcx, %rcx
18000899d:     	jne	0x1800089ac <numba_list_iter_next+0x10c>
18000899f:     	xorl	%eax, %eax
1800089a1:     	movq	0x30(%rsp), %rbx
1800089a6:     	addq	$0x20, %rsp
1800089aa:     	popq	%rdi
1800089ab:     	retq
1800089ac:     	movl	$0x1, %eax
1800089b1:     	xchgq	%rax, (%r8)
1800089b4:     	movq	%rdx, 0x8(%r8)
1800089b8:     	movq	%rdx, 0x10(%r8)
1800089bc:     	movq	%rcx, 0x18(%r8)
1800089c0:     	movq	%rdi, 0x20(%r8)
1800089c4:     	movq	%rbx, 0x28(%r8)
1800089c8:     	cmpb	%dl, 0x9272(%rip)       # 0x180011c40
1800089ce:     	je	0x1800089d8 <numba_list_iter_next+0x138>
1800089d0:     	lock
1800089d1:     	incq	0x9280(%rip)            # 0x180011c58
1800089d8:     	movq	0x30(%rsp), %rbx
1800089dd:     	movq	%r8, %rax
1800089e0:     	addq	$0x20, %rsp
1800089e4:     	popq	%rdi
1800089e5:     	retq
1800089e6:     	int3
1800089e7:     	int3
1800089e8:     	int3
1800089e9:     	int3
1800089ea:     	int3
1800089eb:     	int3
1800089ec:     	int3
1800089ed:     	int3
1800089ee:     	int3
1800089ef:     	int3
1800089f0:     	lock
1800089f1:     	incq	(%rcx)
1800089f4:     	retq
1800089f5:     	int3
1800089f6:     	int3
1800089f7:     	int3
1800089f8:     	int3
1800089f9:     	int3
1800089fa:     	int3
1800089fb:     	int3
1800089fc:     	int3
1800089fd:     	int3
1800089fe:     	int3
1800089ff:     	int3
180008a00:     	pushq	%rbx
180008a02:     	subq	$0x20, %rsp
180008a06:     	movq	0x8(%rcx), %rax
180008a0a:     	movq	%rcx, %rbx
180008a0d:     	testq	%rax, %rax
180008a10:     	je	0x180008a29 <numba_list_iter_next+0x189>
180008a12:     	cmpl	$0x0, 0x921f(%rip)      # 0x180011c38
180008a19:     	jne	0x180008a29 <numba_list_iter_next+0x189>
180008a1b:     	movq	0x10(%rcx), %r8
180008a1f:     	movq	0x20(%rcx), %rdx
180008a23:     	movq	0x18(%rcx), %rcx
180008a27:     	callq	*%rax
180008a29:     	movq	0x28(%rbx), %rax
180008a2d:     	movq	%rbx, %rcx
180008a30:     	testq	%rax, %rax
180008a33:     	je	0x180008a3e <numba_list_iter_next+0x19e>
180008a35:     	movq	0x18(%rax), %rdx
180008a39:     	callq	*0x10(%rax)
180008a3c:     	jmp	0x180008a44 <numba_list_iter_next+0x1a4>
180008a3e:     	callq	*0x9234(%rip)           # 0x180011c78
180008a44:     	cmpb	$0x0, 0x91f5(%rip)      # 0x180011c40
180008a4b:     	je	0x180008a69 <numba_list_iter_next+0x1c9>
180008a4d:     	leaq	0x91fc(%rip), %rax      # 0x180011c50
180008a54:     	lock
180008a55:     	incq	(%rax)
180008a58:     	cmpb	$0x0, 0x91e1(%rip)      # 0x180011c40
180008a5f:     	je	0x180008a69 <numba_list_iter_next+0x1c9>
180008a61:     	lock
180008a62:     	incq	0x91f7(%rip)            # 0x180011c60
180008a69:     	addq	$0x20, %rsp
180008a6d:     	popq	%rbx
180008a6e:     	retq
180008a6f:     	int3
180008a70:     	pushq	%rbx
180008a72:     	subq	$0x20, %rsp
180008a76:     	movq	%rcx, %rbx
180008a79:     	movq	$-0x1, %rax
180008a80:     	lock
180008a81:     	xaddq	%rax, (%rcx)
180008a85:     	cmpq	$0x1, %rax
180008a89:     	jne	0x180008aeb <numba_list_iter_next+0x24b>
180008a8b:     	movq	0x8(%rcx), %rax
180008a8f:     	testq	%rax, %rax
180008a92:     	je	0x180008aab <numba_list_iter_next+0x20b>
180008a94:     	cmpl	$0x0, 0x919d(%rip)      # 0x180011c38
180008a9b:     	jne	0x180008aab <numba_list_iter_next+0x20b>
180008a9d:     	movq	0x10(%rcx), %r8
180008aa1:     	movq	0x20(%rcx), %rdx
180008aa5:     	movq	0x18(%rcx), %rcx
180008aa9:     	callq	*%rax
180008aab:     	movq	0x28(%rbx), %rax
180008aaf:     	movq	%rbx, %rcx
180008ab2:     	testq	%rax, %rax
180008ab5:     	je	0x180008ac0 <numba_list_iter_next+0x220>
180008ab7:     	movq	0x18(%rax), %rdx
180008abb:     	callq	*0x10(%rax)
180008abe:     	jmp	0x180008ac6 <numba_list_iter_next+0x226>
180008ac0:     	callq	*0x91b2(%rip)           # 0x180011c78
180008ac6:     	cmpb	$0x0, 0x9173(%rip)      # 0x180011c40
180008acd:     	je	0x180008aeb <numba_list_iter_next+0x24b>
180008acf:     	leaq	0x917a(%rip), %rax      # 0x180011c50
180008ad6:     	lock
180008ad7:     	incq	(%rax)
180008ada:     	cmpb	$0x0, 0x915f(%rip)      # 0x180011c40
180008ae1:     	je	0x180008aeb <numba_list_iter_next+0x24b>
180008ae3:     	lock
180008ae4:     	incq	0x9175(%rip)            # 0x180011c60
180008aeb:     	addq	$0x20, %rsp
180008aef:     	popq	%rbx
180008af0:     	retq
180008af1:     	int3
180008af2:     	int3
180008af3:     	int3
180008af4:     	int3
180008af5:     	int3
180008af6:     	int3
180008af7:     	int3
180008af8:     	int3
180008af9:     	int3
180008afa:     	int3
180008afb:     	int3
180008afc:     	int3
180008afd:     	int3
180008afe:     	int3
180008aff:     	int3
180008b00:     	movq	0x18(%rcx), %rax
180008b04:     	retq
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
180008b10:     	subq	$0x28, %rsp
180008b14:     	callq	*0x915e(%rip)           # 0x180011c78
180008b1a:     	cmpb	$0x0, 0x911f(%rip)      # 0x180011c40
180008b21:     	je	0x180008b2b <numba_list_iter_next+0x28b>
180008b23:     	lock
180008b24:     	incq	0x9125(%rip)            # 0x180011c50
180008b2b:     	addq	$0x28, %rsp
180008b2f:     	retq
180008b30:     	jmpq	*%r8
180008b33:     	int3
180008b34:     	int3
180008b35:     	int3
180008b36:     	int3
180008b37:     	int3
180008b38:     	int3
180008b39:     	int3
180008b3a:     	int3
180008b3b:     	int3
180008b3c:     	int3
180008b3d:     	int3
180008b3e:     	int3
180008b3f:     	int3
180008b40:     	movq	%rbx, 0x8(%rsp)
180008b45:     	pushq	%rdi
180008b46:     	subq	$0x20, %rsp
180008b4a:     	movq	%rcx, %rdi
180008b4d:     	movq	%rdx, %rbx
180008b50:     	movl	$0x30, %ecx
180008b55:     	callq	*0x910d(%rip)           # 0x180011c68
180008b5b:     	cmpb	$0x0, 0x90de(%rip)      # 0x180011c40
180008b62:     	je	0x180008b6c <numba_list_iter_next+0x2cc>
180008b64:     	lock
180008b65:     	incq	0x90dc(%rip)            # 0x180011c48
180008b6c:     	testq	%rax, %rax
180008b6f:     	je	0x180008ba6 <numba_list_iter_next+0x306>
180008b71:     	leaq	-0x48(%rip), %rcx       # 0x180008b30 <numba_list_iter_next+0x290>
180008b78:     	movl	$0x1, %edx
180008b7d:     	xchgq	%rdx, (%rax)
180008b80:     	movq	%rcx, 0x8(%rax)
180008b84:     	xorl	%ecx, %ecx
180008b86:     	movq	%rcx, 0x20(%rax)
180008b8a:     	movq	%rcx, 0x28(%rax)
180008b8e:     	movq	%rbx, 0x10(%rax)
180008b92:     	movq	%rdi, 0x18(%rax)
180008b96:     	cmpb	%cl, 0x90a4(%rip)       # 0x180011c40
180008b9c:     	je	0x180008ba6 <numba_list_iter_next+0x306>
180008b9e:     	lock
180008b9f:     	incq	0x90b2(%rip)            # 0x180011c58
180008ba6:     	movq	0x30(%rsp), %rbx
180008bab:     	addq	$0x20, %rsp
180008baf:     	popq	%rdi
180008bb0:     	retq
180008bb1:     	jmpq	*0x1759(%rip)           # 0x18000a310
180008bb7:     	jmpq	*0x1743(%rip)           # 0x18000a300
180008bbd:     	jmpq	*0x1735(%rip)           # 0x18000a2f8
180008bc3:     	jmpq	*0x1727(%rip)           # 0x18000a2f0
180008bc9:     	jmpq	*0x1719(%rip)           # 0x18000a2e8
180008bcf:     	jmpq	*0x170b(%rip)           # 0x18000a2e0
180008bd5:     	jmpq	*0x16fd(%rip)           # 0x18000a2d8
180008bdb:     	jmpq	*0x16e7(%rip)           # 0x18000a2c8
180008be1:     	jmpq	*0x16d9(%rip)           # 0x18000a2c0
180008be7:     	jmpq	*0x16cb(%rip)           # 0x18000a2b8
180008bed:     	jmpq	*0x16b5(%rip)           # 0x18000a2a8
180008bf3:     	jmpq	*0x168f(%rip)           # 0x18000a288
180008bf9:     	jmpq	*0x1681(%rip)           # 0x18000a280
180008bff:     	jmpq	*0x1673(%rip)           # 0x18000a278
180008c05:     	jmpq	*0x1665(%rip)           # 0x18000a270
180008c0b:     	jmpq	*0x161f(%rip)           # 0x18000a230
180008c11:     	int3
180008c12:     	int3
180008c13:     	int3
180008c14:     	int3
180008c15:     	int3
180008c16:     	int3
180008c17:     	int3
180008c18:     	int3
180008c19:     	int3
180008c1a:     	int3
180008c1b:     	int3
180008c1c:     	int3
180008c1d:     	int3
180008c1e:     	int3
180008c1f:     	int3
180008c20:     	int3
180008c21:     	int3
180008c22:     	int3
180008c23:     	int3
180008c24:     	int3
180008c25:     	int3
180008c26:     	nopw	(%rax,%rax)
180008c30:     	cmpq	0x84c9(%rip), %rcx      # 0x180011100
180008c37:     	jne	0x180008c49 <numba_list_iter_next+0x3a9>
180008c39:     	rolq	$0x10, %rcx
180008c3d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180008c42:     	jne	0x180008c45 <numba_list_iter_next+0x3a5>
180008c44:     	retq
180008c45:     	rorq	$0x10, %rcx
180008c49:     	jmp	0x180008fa4 <numba_list_iter_next+0x704>
180008c4e:     	int3
180008c4f:     	int3
180008c50:     	subq	$0x28, %rsp
180008c54:     	testl	%edx, %edx
180008c56:     	je	0x180008c91 <numba_list_iter_next+0x3f1>
180008c58:     	subl	$0x1, %edx
180008c5b:     	je	0x180008c85 <numba_list_iter_next+0x3e5>
180008c5d:     	subl	$0x1, %edx
180008c60:     	je	0x180008c78 <numba_list_iter_next+0x3d8>
180008c62:     	cmpl	$0x1, %edx
180008c65:     	je	0x180008c71 <numba_list_iter_next+0x3d1>
180008c67:     	movl	$0x1, %eax
180008c6c:     	addq	$0x28, %rsp
180008c70:     	retq
180008c71:     	callq	0x180009170 <numba_list_iter_next+0x8d0>
180008c76:     	jmp	0x180008c7d <numba_list_iter_next+0x3dd>
180008c78:     	callq	0x180009148 <numba_list_iter_next+0x8a8>
180008c7d:     	movzbl	%al, %eax
180008c80:     	addq	$0x28, %rsp
180008c84:     	retq
180008c85:     	movq	%r8, %rdx
180008c88:     	addq	$0x28, %rsp
180008c8c:     	jmp	0x180008ca0 <numba_list_iter_next+0x400>
180008c91:     	testq	%r8, %r8
180008c94:     	setne	%cl
180008c97:     	addq	$0x28, %rsp
180008c9b:     	jmp	0x180008db8 <numba_list_iter_next+0x518>
180008ca0:     	movq	%rbx, 0x8(%rsp)
180008ca5:     	movq	%rsi, 0x10(%rsp)
180008caa:     	movq	%rdi, 0x20(%rsp)
180008caf:     	pushq	%r14
180008cb1:     	subq	$0x20, %rsp
180008cb5:     	movq	%rdx, %rsi
180008cb8:     	movq	%rcx, %r14
180008cbb:     	xorl	%ecx, %ecx
180008cbd:     	callq	0x18000922c <numba_list_iter_next+0x98c>
180008cc2:     	testb	%al, %al
180008cc4:     	je	0x180008d92 <numba_list_iter_next+0x4f2>
180008cca:     	callq	0x1800090c0 <numba_list_iter_next+0x820>
180008ccf:     	movb	%al, %bl
180008cd1:     	movb	%al, 0x40(%rsp)
180008cd5:     	movb	$0x1, %dil
180008cd8:     	cmpl	$0x0, 0x8d29(%rip)      # 0x180011a08
180008cdf:     	jne	0x180008daa <numba_list_iter_next+0x50a>
180008ce5:     	movl	$0x1, 0x8d19(%rip)      # 0x180011a08
180008cef:     	callq	0x180009130 <numba_list_iter_next+0x890>
180008cf4:     	testb	%al, %al
180008cf6:     	je	0x180008d47 <numba_list_iter_next+0x4a7>
180008cf8:     	callq	0x1800093ec <numba_list_iter_next+0xb4c>
180008cfd:     	callq	0x180009080 <numba_list_iter_next+0x7e0>
180008d02:     	callq	0x1800090a4 <numba_list_iter_next+0x804>
180008d07:     	leaq	0x1662(%rip), %rdx      # 0x18000a370
180008d0e:     	leaq	0x1653(%rip), %rcx      # 0x18000a368
180008d15:     	callq	0x180009732 <numba_list_iter_next+0xe92>
180008d1a:     	testl	%eax, %eax
180008d1c:     	jne	0x180008d47 <numba_list_iter_next+0x4a7>
180008d1e:     	callq	0x1800090fc <numba_list_iter_next+0x85c>
180008d23:     	testb	%al, %al
180008d25:     	je	0x180008d47 <numba_list_iter_next+0x4a7>
180008d27:     	leaq	0x1632(%rip), %rdx      # 0x18000a360
180008d2e:     	leaq	0x1623(%rip), %rcx      # 0x18000a358
180008d35:     	callq	0x18000972c <numba_list_iter_next+0xe8c>
180008d3a:     	movl	$0x2, 0x8cc4(%rip)      # 0x180011a08
180008d44:     	xorb	%dil, %dil
180008d47:     	movb	%bl, %cl
180008d49:     	callq	0x18000938c <numba_list_iter_next+0xaec>
180008d4e:     	testb	%dil, %dil
180008d51:     	jne	0x180008d92 <numba_list_iter_next+0x4f2>
180008d53:     	callq	0x1800093dc <numba_list_iter_next+0xb3c>
180008d58:     	movq	%rax, %rbx
180008d5b:     	cmpq	$0x0, (%rax)
180008d5f:     	je	0x180008d85 <numba_list_iter_next+0x4e5>
180008d61:     	movq	%rax, %rcx
180008d64:     	callq	0x1800092f4 <numba_list_iter_next+0xa54>
180008d69:     	testb	%al, %al
180008d6b:     	je	0x180008d85 <numba_list_iter_next+0x4e5>
180008d6d:     	movq	%rsi, %r8
180008d70:     	movl	$0x2, %edx
180008d75:     	movq	%r14, %rcx
180008d78:     	movq	(%rbx), %rax
180008d7b:     	movq	0x15ae(%rip), %r9       # 0x18000a330
180008d82:     	callq	*%r9
180008d85:     	incl	0x8c55(%rip)            # 0x1800119e0
180008d8b:     	movl	$0x1, %eax
180008d90:     	jmp	0x180008d94 <numba_list_iter_next+0x4f4>
180008d92:     	xorl	%eax, %eax
180008d94:     	movq	0x30(%rsp), %rbx
180008d99:     	movq	0x38(%rsp), %rsi
180008d9e:     	movq	0x48(%rsp), %rdi
180008da3:     	addq	$0x20, %rsp
180008da7:     	popq	%r14
180008da9:     	retq
180008daa:     	movl	$0x7, %ecx
180008daf:     	callq	0x1800093e4 <numba_list_iter_next+0xb44>
180008db4:     	nop
180008db5:     	int3
180008db6:     	int3
180008db7:     	int3
180008db8:     	movq	%rbx, 0x8(%rsp)
180008dbd:     	pushq	%rdi
180008dbe:     	subq	$0x30, %rsp
180008dc2:     	movb	%cl, %dil
180008dc5:     	movl	0x8c15(%rip), %eax      # 0x1800119e0
180008dcb:     	testl	%eax, %eax
180008dcd:     	jg	0x180008ddc <numba_list_iter_next+0x53c>
180008dcf:     	xorl	%eax, %eax
180008dd1:     	movq	0x40(%rsp), %rbx
180008dd6:     	addq	$0x30, %rsp
180008dda:     	popq	%rdi
180008ddb:     	retq
180008ddc:     	decl	%eax
180008dde:     	movl	%eax, 0x8bfc(%rip)      # 0x1800119e0
180008de4:     	callq	0x1800090c0 <numba_list_iter_next+0x820>
180008de9:     	movb	%al, %bl
180008deb:     	movb	%al, 0x20(%rsp)
180008def:     	cmpl	$0x2, 0x8c12(%rip)      # 0x180011a08
180008df6:     	jne	0x180008e2e <numba_list_iter_next+0x58e>
180008df8:     	callq	0x1800091e8 <numba_list_iter_next+0x948>
180008dfd:     	callq	0x180009090 <numba_list_iter_next+0x7f0>
180008e02:     	callq	0x180009428 <numba_list_iter_next+0xb88>
180008e07:     	movl	$0x0, 0x8bf7(%rip)      # 0x180011a08
180008e11:     	movb	%bl, %cl
180008e13:     	callq	0x18000938c <numba_list_iter_next+0xaec>
180008e18:     	xorl	%edx, %edx
180008e1a:     	movb	%dil, %cl
180008e1d:     	callq	0x1800093b0 <numba_list_iter_next+0xb10>
180008e22:     	movzbl	%al, %ebx
180008e25:     	callq	0x180009218 <numba_list_iter_next+0x978>
180008e2a:     	movl	%ebx, %eax
180008e2c:     	jmp	0x180008dd1 <numba_list_iter_next+0x531>
180008e2e:     	movl	$0x7, %ecx
180008e33:     	callq	0x1800093e4 <numba_list_iter_next+0xb44>
180008e38:     	nop
180008e39:     	nop
180008e3a:     	int3
180008e3b:     	int3
180008e3c:     	movq	%rsp, %rax
180008e3f:     	movq	%rbx, 0x20(%rax)
180008e43:     	movq	%r8, 0x18(%rax)
180008e47:     	movl	%edx, 0x10(%rax)
180008e4a:     	movq	%rcx, 0x8(%rax)
180008e4e:     	pushq	%rsi
180008e4f:     	pushq	%rdi
180008e50:     	pushq	%r14
180008e52:     	subq	$0x40, %rsp
180008e56:     	movq	%r8, %rsi
180008e59:     	movl	%edx, %edi
180008e5b:     	movq	%rcx, %r14
180008e5e:     	testl	%edx, %edx
180008e60:     	jne	0x180008e71 <numba_list_iter_next+0x5d1>
180008e62:     	cmpl	%edx, 0x8b78(%rip)      # 0x1800119e0
180008e68:     	jg	0x180008e71 <numba_list_iter_next+0x5d1>
180008e6a:     	xorl	%eax, %eax
180008e6c:     	jmp	0x180008f56 <numba_list_iter_next+0x6b6>
180008e71:     	leal	-0x1(%rdx), %eax
180008e74:     	cmpl	$0x1, %eax
180008e77:     	ja	0x180008eb9 <numba_list_iter_next+0x619>
180008e79:     	movq	0x1f40(%rip), %rax      # 0x18000adc0
180008e80:     	testq	%rax, %rax
180008e83:     	jne	0x180008e8a <numba_list_iter_next+0x5ea>
180008e85:     	leal	0x1(%rax), %ebx
180008e88:     	jmp	0x180008e92 <numba_list_iter_next+0x5f2>
180008e8a:     	callq	*0x14a0(%rip)           # 0x18000a330
180008e90:     	movl	%eax, %ebx
180008e92:     	movl	%ebx, 0x30(%rsp)
180008e96:     	testl	%ebx, %ebx
180008e98:     	je	0x180008f4c <numba_list_iter_next+0x6ac>
180008e9e:     	movq	%rsi, %r8
180008ea1:     	movl	%edi, %edx
180008ea3:     	movq	%r14, %rcx
180008ea6:     	callq	0x180008c50 <numba_list_iter_next+0x3b0>
180008eab:     	movl	%eax, %ebx
180008ead:     	movl	%eax, 0x30(%rsp)
180008eb1:     	testl	%eax, %eax
180008eb3:     	je	0x180008f4c <numba_list_iter_next+0x6ac>
180008eb9:     	movq	%rsi, %r8
180008ebc:     	movl	%edi, %edx
180008ebe:     	movq	%r14, %rcx
180008ec1:     	callq	0x18000905c <numba_list_iter_next+0x7bc>
180008ec6:     	movl	%eax, %ebx
180008ec8:     	movl	%eax, 0x30(%rsp)
180008ecc:     	cmpl	$0x1, %edi
180008ecf:     	jne	0x180008f07 <numba_list_iter_next+0x667>
180008ed1:     	testl	%eax, %eax
180008ed3:     	jne	0x180008f07 <numba_list_iter_next+0x667>
180008ed5:     	movq	%rsi, %r8
180008ed8:     	xorl	%edx, %edx
180008eda:     	movq	%r14, %rcx
180008edd:     	callq	0x18000905c <numba_list_iter_next+0x7bc>
180008ee2:     	testq	%rsi, %rsi
180008ee5:     	setne	%cl
180008ee8:     	callq	0x180008db8 <numba_list_iter_next+0x518>
180008eed:     	movq	0x1ecc(%rip), %rax      # 0x18000adc0
180008ef4:     	testq	%rax, %rax
180008ef7:     	je	0x180008f07 <numba_list_iter_next+0x667>
180008ef9:     	movq	%rsi, %r8
180008efc:     	xorl	%edx, %edx
180008efe:     	movq	%r14, %rcx
180008f01:     	callq	*0x1429(%rip)           # 0x18000a330
180008f07:     	testl	%edi, %edi
180008f09:     	je	0x180008f10 <numba_list_iter_next+0x670>
180008f0b:     	cmpl	$0x3, %edi
180008f0e:     	jne	0x180008f4c <numba_list_iter_next+0x6ac>
180008f10:     	movq	%rsi, %r8
180008f13:     	movl	%edi, %edx
180008f15:     	movq	%r14, %rcx
180008f18:     	callq	0x180008c50 <numba_list_iter_next+0x3b0>
180008f1d:     	movl	%eax, %ebx
180008f1f:     	movl	%eax, 0x30(%rsp)
180008f23:     	testl	%eax, %eax
180008f25:     	je	0x180008f4c <numba_list_iter_next+0x6ac>
180008f27:     	movq	0x1e92(%rip), %rax      # 0x18000adc0
180008f2e:     	testq	%rax, %rax
180008f31:     	jne	0x180008f38 <numba_list_iter_next+0x698>
180008f33:     	leal	0x1(%rax), %ebx
180008f36:     	jmp	0x180008f48 <numba_list_iter_next+0x6a8>
180008f38:     	movq	%rsi, %r8
180008f3b:     	movl	%edi, %edx
180008f3d:     	movq	%r14, %rcx
180008f40:     	callq	*0x13ea(%rip)           # 0x18000a330
180008f46:     	movl	%eax, %ebx
180008f48:     	movl	%ebx, 0x30(%rsp)
180008f4c:     	jmp	0x180008f54 <numba_list_iter_next+0x6b4>
180008f4e:     	xorl	%ebx, %ebx
180008f50:     	movl	%ebx, 0x30(%rsp)
180008f54:     	movl	%ebx, %eax
180008f56:     	movq	0x78(%rsp), %rbx
180008f5b:     	addq	$0x40, %rsp
180008f5f:     	popq	%r14
180008f61:     	popq	%rdi
180008f62:     	popq	%rsi
180008f63:     	retq
180008f64:     	movq	%rbx, 0x8(%rsp)
180008f69:     	movq	%rsi, 0x10(%rsp)
180008f6e:     	pushq	%rdi
180008f6f:     	subq	$0x20, %rsp
180008f73:     	movq	%r8, %rdi
180008f76:     	movl	%edx, %ebx
180008f78:     	movq	%rcx, %rsi
180008f7b:     	cmpl	$0x1, %edx
180008f7e:     	jne	0x180008f85 <numba_list_iter_next+0x6e5>
180008f80:     	callq	0x180008fac <numba_list_iter_next+0x70c>
180008f85:     	movq	%rdi, %r8
180008f88:     	movl	%ebx, %edx
180008f8a:     	movq	%rsi, %rcx
180008f8d:     	movq	0x30(%rsp), %rbx
180008f92:     	movq	0x38(%rsp), %rsi
180008f97:     	addq	$0x20, %rsp
180008f9b:     	popq	%rdi
180008f9c:     	jmp	0x180008e3c <numba_list_iter_next+0x59c>
180008fa1:     	int3
180008fa2:     	int3
180008fa3:     	int3
180008fa4:     	movl	$0x2, %ecx
180008fa9:     	int	$0x29
180008fab:     	retq
180008fac:     	movq	%rbx, 0x18(%rsp)
180008fb1:     	pushq	%rbp
180008fb2:     	movq	%rsp, %rbp
180008fb5:     	subq	$0x30, %rsp
180008fb9:     	movq	0x8140(%rip), %rax      # 0x180011100
180008fc0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
180008fca:     	cmpq	%rbx, %rax
180008fcd:     	jne	0x180009046 <numba_list_iter_next+0x7a6>
180008fcf:     	leaq	0x10(%rbp), %rcx
180008fd3:     	movq	$0x0, 0x10(%rbp)
180008fdb:     	callq	*0x103f(%rip)           # 0x18000a020
180008fe1:     	movq	0x10(%rbp), %rax
180008fe5:     	movq	%rax, -0x10(%rbp)
180008fe9:     	callq	*0x1029(%rip)           # 0x18000a018
180008fef:     	movl	%eax, %eax
180008ff1:     	xorq	%rax, -0x10(%rbp)
180008ff5:     	callq	*0x1015(%rip)           # 0x18000a010
180008ffb:     	movl	%eax, %eax
180008ffd:     	leaq	0x18(%rbp), %rcx
180009001:     	xorq	%rax, -0x10(%rbp)
180009005:     	callq	*0xff5(%rip)            # 0x18000a000
18000900b:     	movl	0x18(%rbp), %eax
18000900e:     	leaq	-0x10(%rbp), %rcx
180009012:     	shlq	$0x20, %rax
180009016:     	xorq	0x18(%rbp), %rax
18000901a:     	xorq	-0x10(%rbp), %rax
18000901e:     	xorq	%rcx, %rax
180009021:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000902b:     	andq	%rcx, %rax
18000902e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180009038:     	cmpq	%rbx, %rax
18000903b:     	cmoveq	%rcx, %rax
18000903f:     	movq	%rax, 0x80ba(%rip)      # 0x180011100
180009046:     	movq	0x50(%rsp), %rbx
18000904b:     	notq	%rax
18000904e:     	movq	%rax, 0x80eb(%rip)      # 0x180011140
180009055:     	addq	$0x30, %rsp
180009059:     	popq	%rbp
18000905a:     	retq
18000905b:     	int3
18000905c:     	subq	$0x28, %rsp
180009060:     	cmpl	$0x1, %edx
180009063:     	jne	0x180009075 <numba_list_iter_next+0x7d5>
180009065:     	cmpq	$0x0, 0x1d53(%rip)      # 0x18000adc0
18000906d:     	jne	0x180009075 <numba_list_iter_next+0x7d5>
18000906f:     	callq	*0xfb3(%rip)            # 0x18000a028
180009075:     	movl	$0x1, %eax
18000907a:     	addq	$0x28, %rsp
18000907e:     	retq
18000907f:     	int3
180009080:     	leaq	0x8969(%rip), %rcx      # 0x1800119f0
180009087:     	jmpq	*0xf7a(%rip)            # 0x18000a008
18000908e:     	int3
18000908f:     	int3
180009090:     	leaq	0x8959(%rip), %rcx      # 0x1800119f0
180009097:     	jmp	0x180009726 <numba_list_iter_next+0xe86>
18000909c:     	leaq	0x895d(%rip), %rax      # 0x180011a00
1800090a3:     	retq
1800090a4:     	subq	$0x28, %rsp
1800090a8:     	callq	0x1800081b0 <PyInit_rcaotr_b767982c3d43c6022e2cef09+0x5c40>
1800090ad:     	orq	$0x24, (%rax)
1800090b1:     	callq	0x18000909c <numba_list_iter_next+0x7fc>
1800090b6:     	orq	$0x2, (%rax)
1800090ba:     	addq	$0x28, %rsp
1800090be:     	retq
1800090bf:     	int3
1800090c0:     	subq	$0x28, %rsp
1800090c4:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
1800090c9:     	testl	%eax, %eax
1800090cb:     	je	0x1800090ee <numba_list_iter_next+0x84e>
1800090cd:     	movq	%gs:0x30, %rax
1800090d6:     	movq	0x8(%rax), %rcx
1800090da:     	jmp	0x1800090e1 <numba_list_iter_next+0x841>
1800090dc:     	cmpq	%rax, %rcx
1800090df:     	je	0x1800090f5 <numba_list_iter_next+0x855>
1800090e1:     	xorl	%eax, %eax
1800090e3:     	lock
1800090e4:     	cmpxchgq	%rcx, 0x8924(%rip)      # 0x180011a10
1800090ec:     	jne	0x1800090dc <numba_list_iter_next+0x83c>
1800090ee:     	xorb	%al, %al
1800090f0:     	addq	$0x28, %rsp
1800090f4:     	retq
1800090f5:     	movb	$0x1, %al
1800090f7:     	jmp	0x1800090f0 <numba_list_iter_next+0x850>
1800090f9:     	int3
1800090fa:     	int3
1800090fb:     	int3
1800090fc:     	subq	$0x28, %rsp
180009100:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
180009105:     	testl	%eax, %eax
180009107:     	je	0x180009110 <numba_list_iter_next+0x870>
180009109:     	callq	0x180009468 <numba_list_iter_next+0xbc8>
18000910e:     	jmp	0x180009129 <numba_list_iter_next+0x889>
180009110:     	callq	0x180009704 <numba_list_iter_next+0xe64>
180009115:     	movl	%eax, %ecx
180009117:     	callq	0x18000973e <numba_list_iter_next+0xe9e>
18000911c:     	testl	%eax, %eax
18000911e:     	je	0x180009124 <numba_list_iter_next+0x884>
180009120:     	xorb	%al, %al
180009122:     	jmp	0x18000912b <numba_list_iter_next+0x88b>
180009124:     	callq	0x180009744 <numba_list_iter_next+0xea4>
180009129:     	movb	$0x1, %al
18000912b:     	addq	$0x28, %rsp
18000912f:     	retq
180009130:     	subq	$0x28, %rsp
180009134:     	xorl	%ecx, %ecx
180009136:     	callq	0x180009268 <numba_list_iter_next+0x9c8>
18000913b:     	testb	%al, %al
18000913d:     	setne	%al
180009140:     	addq	$0x28, %rsp
180009144:     	retq
180009145:     	int3
180009146:     	int3
180009147:     	int3
180009148:     	subq	$0x28, %rsp
18000914c:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009151:     	testb	%al, %al
180009153:     	jne	0x180009159 <numba_list_iter_next+0x8b9>
180009155:     	xorb	%al, %al
180009157:     	jmp	0x18000916b <numba_list_iter_next+0x8cb>
180009159:     	callq	0x18000975c <numba_list_iter_next+0xebc>
18000915e:     	testb	%al, %al
180009160:     	jne	0x180009169 <numba_list_iter_next+0x8c9>
180009162:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009167:     	jmp	0x180009155 <numba_list_iter_next+0x8b5>
180009169:     	movb	$0x1, %al
18000916b:     	addq	$0x28, %rsp
18000916f:     	retq
180009170:     	subq	$0x28, %rsp
180009174:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009179:     	callq	0x18000975c <numba_list_iter_next+0xebc>
18000917e:     	movb	$0x1, %al
180009180:     	addq	$0x28, %rsp
180009184:     	retq
180009185:     	int3
180009186:     	int3
180009187:     	int3
180009188:     	movq	%rbx, 0x8(%rsp)
18000918d:     	movq	%rbp, 0x10(%rsp)
180009192:     	movq	%rsi, 0x18(%rsp)
180009197:     	pushq	%rdi
180009198:     	subq	$0x20, %rsp
18000919c:     	movq	%r9, %rdi
18000919f:     	movq	%r8, %rsi
1800091a2:     	movl	%edx, %ebx
1800091a4:     	movq	%rcx, %rbp
1800091a7:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
1800091ac:     	testl	%eax, %eax
1800091ae:     	jne	0x1800091c6 <numba_list_iter_next+0x926>
1800091b0:     	cmpl	$0x1, %ebx
1800091b3:     	jne	0x1800091c6 <numba_list_iter_next+0x926>
1800091b5:     	movq	%rsi, %r8
1800091b8:     	xorl	%edx, %edx
1800091ba:     	movq	%rbp, %rcx
1800091bd:     	movq	%rdi, %rax
1800091c0:     	callq	*0x116a(%rip)           # 0x18000a330
1800091c6:     	movq	0x58(%rsp), %rdx
1800091cb:     	movl	0x50(%rsp), %ecx
1800091cf:     	movq	0x30(%rsp), %rbx
1800091d4:     	movq	0x38(%rsp), %rbp
1800091d9:     	movq	0x40(%rsp), %rsi
1800091de:     	addq	$0x20, %rsp
1800091e2:     	popq	%rdi
1800091e3:     	jmp	0x180009738 <numba_list_iter_next+0xe98>
1800091e8:     	subq	$0x28, %rsp
1800091ec:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
1800091f1:     	testl	%eax, %eax
1800091f3:     	je	0x180009205 <numba_list_iter_next+0x965>
1800091f5:     	leaq	0x8824(%rip), %rcx      # 0x180011a20
1800091fc:     	addq	$0x28, %rsp
180009200:     	jmp	0x180009750 <numba_list_iter_next+0xeb0>
180009205:     	callq	0x180009760 <numba_list_iter_next+0xec0>
18000920a:     	testl	%eax, %eax
18000920c:     	jne	0x180009213 <numba_list_iter_next+0x973>
18000920e:     	callq	0x180009756 <numba_list_iter_next+0xeb6>
180009213:     	addq	$0x28, %rsp
180009217:     	retq
180009218:     	subq	$0x28, %rsp
18000921c:     	xorl	%ecx, %ecx
18000921e:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009223:     	addq	$0x28, %rsp
180009227:     	jmp	0x18000975c <numba_list_iter_next+0xebc>
18000922c:     	subq	$0x28, %rsp
180009230:     	testl	%ecx, %ecx
180009232:     	jne	0x18000923b <numba_list_iter_next+0x99b>
180009234:     	movb	$0x1, 0x87dd(%rip)      # 0x180011a18
18000923b:     	callq	0x180009468 <numba_list_iter_next+0xbc8>
180009240:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009245:     	testb	%al, %al
180009247:     	jne	0x18000924d <numba_list_iter_next+0x9ad>
180009249:     	xorb	%al, %al
18000924b:     	jmp	0x180009261 <numba_list_iter_next+0x9c1>
18000924d:     	callq	0x18000975c <numba_list_iter_next+0xebc>
180009252:     	testb	%al, %al
180009254:     	jne	0x18000925f <numba_list_iter_next+0x9bf>
180009256:     	xorl	%ecx, %ecx
180009258:     	callq	0x18000975c <numba_list_iter_next+0xebc>
18000925d:     	jmp	0x180009249 <numba_list_iter_next+0x9a9>
18000925f:     	movb	$0x1, %al
180009261:     	addq	$0x28, %rsp
180009265:     	retq
180009266:     	int3
180009267:     	int3
180009268:     	pushq	%rbx
18000926a:     	subq	$0x20, %rsp
18000926e:     	cmpb	$0x0, 0x87a4(%rip)      # 0x180011a19
180009275:     	movl	%ecx, %ebx
180009277:     	jne	0x1800092e0 <numba_list_iter_next+0xa40>
180009279:     	cmpl	$0x1, %ecx
18000927c:     	ja	0x1800092e8 <numba_list_iter_next+0xa48>
18000927e:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
180009283:     	testl	%eax, %eax
180009285:     	je	0x1800092af <numba_list_iter_next+0xa0f>
180009287:     	testl	%ebx, %ebx
180009289:     	jne	0x1800092af <numba_list_iter_next+0xa0f>
18000928b:     	leaq	0x878e(%rip), %rcx      # 0x180011a20
180009292:     	callq	0x18000974a <numba_list_iter_next+0xeaa>
180009297:     	testl	%eax, %eax
180009299:     	jne	0x1800092ab <numba_list_iter_next+0xa0b>
18000929b:     	leaq	0x8796(%rip), %rcx      # 0x180011a38
1800092a2:     	callq	0x18000974a <numba_list_iter_next+0xeaa>
1800092a7:     	testl	%eax, %eax
1800092a9:     	je	0x1800092d9 <numba_list_iter_next+0xa39>
1800092ab:     	xorb	%al, %al
1800092ad:     	jmp	0x1800092e2 <numba_list_iter_next+0xa42>
1800092af:     	movdqa	0x1b19(%rip), %xmm0     # 0x18000add0
1800092b7:     	orq	$-0x1, %rax
1800092bb:     	movdqu	%xmm0, 0x875d(%rip)     # 0x180011a20
1800092c3:     	movq	%rax, 0x8766(%rip)      # 0x180011a30
1800092ca:     	movdqu	%xmm0, 0x8766(%rip)     # 0x180011a38
1800092d2:     	movq	%rax, 0x876f(%rip)      # 0x180011a48
1800092d9:     	movb	$0x1, 0x8739(%rip)      # 0x180011a19
1800092e0:     	movb	$0x1, %al
1800092e2:     	addq	$0x20, %rsp
1800092e6:     	popq	%rbx
1800092e7:     	retq
1800092e8:     	movl	$0x5, %ecx
1800092ed:     	callq	0x1800093e4 <numba_list_iter_next+0xb44>
1800092f2:     	int3
1800092f3:     	int3
1800092f4:     	subq	$0x18, %rsp
1800092f8:     	movq	%rcx, %r8
1800092fb:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180009300:     	cmpw	%ax, -0x9307(%rip)      # 0x180000000
180009307:     	jne	0x180009381 <numba_list_iter_next+0xae1>
180009309:     	movslq	-0x92d4(%rip), %rcx     # 0x18000003c
180009310:     	leaq	-0x9317(%rip), %rdx     # 0x180000000
180009317:     	addq	%rdx, %rcx
18000931a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180009320:     	jne	0x180009381 <numba_list_iter_next+0xae1>
180009322:     	movl	$0x20b, %eax            # imm = 0x20B
180009327:     	cmpw	%ax, 0x18(%rcx)
18000932b:     	jne	0x180009381 <numba_list_iter_next+0xae1>
18000932d:     	subq	%rdx, %r8
180009330:     	movzwl	0x14(%rcx), %edx
180009334:     	addq	$0x18, %rdx
180009338:     	addq	%rcx, %rdx
18000933b:     	movzwl	0x6(%rcx), %eax
18000933f:     	leaq	(%rax,%rax,4), %rcx
180009343:     	leaq	(%rdx,%rcx,8), %r9
180009347:     	movq	%rdx, (%rsp)
18000934b:     	cmpq	%r9, %rdx
18000934e:     	je	0x180009368 <numba_list_iter_next+0xac8>
180009350:     	movl	0xc(%rdx), %ecx
180009353:     	cmpq	%rcx, %r8
180009356:     	jb	0x180009362 <numba_list_iter_next+0xac2>
180009358:     	movl	0x8(%rdx), %eax
18000935b:     	addl	%ecx, %eax
18000935d:     	cmpq	%rax, %r8
180009360:     	jb	0x18000936a <numba_list_iter_next+0xaca>
180009362:     	addq	$0x28, %rdx
180009366:     	jmp	0x180009347 <numba_list_iter_next+0xaa7>
180009368:     	xorl	%edx, %edx
18000936a:     	testq	%rdx, %rdx
18000936d:     	jne	0x180009373 <numba_list_iter_next+0xad3>
18000936f:     	xorb	%al, %al
180009371:     	jmp	0x180009387 <numba_list_iter_next+0xae7>
180009373:     	cmpl	$0x0, 0x24(%rdx)
180009377:     	jge	0x18000937d <numba_list_iter_next+0xadd>
180009379:     	xorb	%al, %al
18000937b:     	jmp	0x180009387 <numba_list_iter_next+0xae7>
18000937d:     	movb	$0x1, %al
18000937f:     	jmp	0x180009387 <numba_list_iter_next+0xae7>
180009381:     	xorb	%al, %al
180009383:     	jmp	0x180009387 <numba_list_iter_next+0xae7>
180009385:     	xorb	%al, %al
180009387:     	addq	$0x18, %rsp
18000938b:     	retq
18000938c:     	pushq	%rbx
18000938e:     	subq	$0x20, %rsp
180009392:     	movb	%cl, %bl
180009394:     	callq	0x18000970c <numba_list_iter_next+0xe6c>
180009399:     	xorl	%edx, %edx
18000939b:     	testl	%eax, %eax
18000939d:     	je	0x1800093aa <numba_list_iter_next+0xb0a>
18000939f:     	testb	%bl, %bl
1800093a1:     	jne	0x1800093aa <numba_list_iter_next+0xb0a>
1800093a3:     	xchgq	%rdx, 0x8666(%rip)      # 0x180011a10
1800093aa:     	addq	$0x20, %rsp
1800093ae:     	popq	%rbx
1800093af:     	retq
1800093b0:     	pushq	%rbx
1800093b2:     	subq	$0x20, %rsp
1800093b6:     	cmpb	$0x0, 0x865b(%rip)      # 0x180011a18
1800093bd:     	movb	%cl, %bl
1800093bf:     	je	0x1800093c5 <numba_list_iter_next+0xb25>
1800093c1:     	testb	%dl, %dl
1800093c3:     	jne	0x1800093d1 <numba_list_iter_next+0xb31>
1800093c5:     	callq	0x18000975c <numba_list_iter_next+0xebc>
1800093ca:     	movb	%bl, %cl
1800093cc:     	callq	0x18000975c <numba_list_iter_next+0xebc>
1800093d1:     	movb	$0x1, %al
1800093d3:     	addq	$0x20, %rsp
1800093d7:     	popq	%rbx
1800093d8:     	retq
1800093d9:     	int3
1800093da:     	int3
1800093db:     	int3
1800093dc:     	leaq	0x891d(%rip), %rax      # 0x180011d00
1800093e3:     	retq
1800093e4:     	movl	%ecx, %ecx
1800093e6:     	int	$0x29
1800093e8:     	retq
1800093e9:     	int3
1800093ea:     	int3
1800093eb:     	int3
1800093ec:     	movq	%rbx, 0x8(%rsp)
1800093f1:     	pushq	%rdi
1800093f2:     	subq	$0x20, %rsp
1800093f6:     	leaq	0x43cb(%rip), %rbx      # 0x18000d7c8
1800093fd:     	leaq	0x43c4(%rip), %rdi      # 0x18000d7c8
180009404:     	jmp	0x180009418 <numba_list_iter_next+0xb78>
180009406:     	movq	(%rbx), %rax
180009409:     	testq	%rax, %rax
18000940c:     	je	0x180009414 <numba_list_iter_next+0xb74>
18000940e:     	callq	*0xf1c(%rip)            # 0x18000a330
180009414:     	addq	$0x8, %rbx
180009418:     	cmpq	%rdi, %rbx
18000941b:     	jb	0x180009406 <numba_list_iter_next+0xb66>
18000941d:     	movq	0x30(%rsp), %rbx
180009422:     	addq	$0x20, %rsp
180009426:     	popq	%rdi
180009427:     	retq
180009428:     	movq	%rbx, 0x8(%rsp)
18000942d:     	pushq	%rdi
18000942e:     	subq	$0x20, %rsp
180009432:     	leaq	0x439f(%rip), %rbx      # 0x18000d7d8
180009439:     	leaq	0x4398(%rip), %rdi      # 0x18000d7d8
180009440:     	jmp	0x180009454 <numba_list_iter_next+0xbb4>
180009442:     	movq	(%rbx), %rax
180009445:     	testq	%rax, %rax
180009448:     	je	0x180009450 <numba_list_iter_next+0xbb0>
18000944a:     	callq	*0xee0(%rip)            # 0x18000a330
180009450:     	addq	$0x8, %rbx
180009454:     	cmpq	%rdi, %rbx
180009457:     	jb	0x180009442 <numba_list_iter_next+0xba2>
180009459:     	movq	0x30(%rsp), %rbx
18000945e:     	addq	$0x20, %rsp
180009462:     	popq	%rdi
180009463:     	retq
180009464:     	retq	$0x0
180009467:     	int3
180009468:     	movq	%rbx, 0x10(%rsp)
18000946d:     	movq	%rbp, 0x18(%rsp)
180009472:     	movq	%rsi, 0x20(%rsp)
180009477:     	pushq	%rdi
180009478:     	subq	$0x10, %rsp
18000947c:     	xorl	%eax, %eax
18000947e:     	xorl	%ecx, %ecx
180009480:     	cpuid
180009482:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180009488:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000948e:     	orl	%ecx, %edx
180009490:     	movl	%eax, %ebp
180009492:     	movl	$0x1, %eax
180009497:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000949d:     	orl	%ebx, %edx
18000949f:     	leal	-0x1(%rax), %ecx
1800094a2:     	cpuid
1800094a4:     	movl	%ecx, %edi
1800094a6:     	jne	0x180009506 <numba_list_iter_next+0xc66>
1800094a8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
1800094ad:     	movq	$0x8000, 0x7ca0(%rip)   # imm = 0x8000
                                                # 0x180011158
1800094b8:     	movq	$-0x1, 0x7c9d(%rip)     # 0x180011160
1800094c3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
1800094c8:     	je	0x1800094f2 <numba_list_iter_next+0xc52>
1800094ca:     	cmpl	$0x20660, %eax          # imm = 0x20660
1800094cf:     	je	0x1800094f2 <numba_list_iter_next+0xc52>
1800094d1:     	cmpl	$0x20670, %eax          # imm = 0x20670
1800094d6:     	je	0x1800094f2 <numba_list_iter_next+0xc52>
1800094d8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
1800094dd:     	cmpl	$0x20, %eax
1800094e0:     	ja	0x180009506 <numba_list_iter_next+0xc66>
1800094e2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
1800094ec:     	btq	%rax, %rcx
1800094f0:     	jae	0x180009506 <numba_list_iter_next+0xc66>
1800094f2:     	movl	0x855b(%rip), %r8d      # 0x180011a54
1800094f9:     	orl	$0x1, %r8d
1800094fd:     	movl	%r8d, 0x8550(%rip)      # 0x180011a54
180009504:     	jmp	0x18000950d <numba_list_iter_next+0xc6d>
180009506:     	movl	0x8547(%rip), %r8d      # 0x180011a54
18000950d:     	xorl	%r9d, %r9d
180009510:     	movl	%r9d, %r11d
180009513:     	cmpl	$0x7, %ebp
180009516:     	jl	0x18000955a <numba_list_iter_next+0xcba>
180009518:     	xorl	%ecx, %ecx
18000951a:     	leal	0x7(%r9), %eax
18000951e:     	cpuid
180009520:     	movl	%edx, %esi
180009522:     	movl	%ebx, %r10d
180009525:     	btl	$0x9, %ebx
180009529:     	jae	0x180009536 <numba_list_iter_next+0xc96>
18000952b:     	orl	$0x2, %r8d
18000952f:     	movl	%r8d, 0x851e(%rip)      # 0x180011a54
180009536:     	cmpl	$0x1, %eax
180009539:     	jl	0x180009548 <numba_list_iter_next+0xca8>
18000953b:     	movl	$0x7, %eax
180009540:     	leal	-0x6(%rax), %ecx
180009543:     	cpuid
180009545:     	movl	%edx, %r9d
180009548:     	movl	$0x24, %eax
18000954d:     	cmpl	%eax, %ebp
18000954f:     	jl	0x180009560 <numba_list_iter_next+0xcc0>
180009551:     	xorl	%ecx, %ecx
180009553:     	cpuid
180009555:     	movl	%ebx, %r11d
180009558:     	jmp	0x180009560 <numba_list_iter_next+0xcc0>
18000955a:     	movl	%r9d, %r10d
18000955d:     	movl	%r9d, %esi
180009560:     	movq	0x7c01(%rip), %rax      # 0x180011168
180009567:     	andq	$-0x2, %rax
18000956b:     	movl	$0x1, 0x7bdb(%rip)      # 0x180011150
180009575:     	movl	$0x2, 0x7bd5(%rip)      # 0x180011154
18000957f:     	movq	%rax, 0x7be2(%rip)      # 0x180011168
180009586:     	btl	$0x14, %edi
18000958a:     	jae	0x1800095ab <numba_list_iter_next+0xd0b>
18000958c:     	andq	$-0x11, %rax
180009590:     	movl	$0x2, 0x7bb6(%rip)      # 0x180011150
18000959a:     	movq	%rax, 0x7bc7(%rip)      # 0x180011168
1800095a1:     	movl	$0x6, 0x7ba9(%rip)      # 0x180011154
1800095ab:     	btl	$0x1b, %edi
1800095af:     	jae	0x1800096ec <numba_list_iter_next+0xe4c>
1800095b5:     	xorl	%ecx, %ecx
1800095b7:     	xgetbv
1800095ba:     	shlq	$0x20, %rdx
1800095be:     	orq	%rax, %rdx
1800095c1:     	movq	%rdx, 0x20(%rsp)
1800095c6:     	btl	$0x1c, %edi
1800095ca:     	jae	0x1800096d0 <numba_list_iter_next+0xe30>
1800095d0:     	movq	0x20(%rsp), %rax
1800095d5:     	andb	$0x6, %al
1800095d7:     	cmpb	$0x6, %al
1800095d9:     	jne	0x1800096d0 <numba_list_iter_next+0xe30>
1800095df:     	movl	0x7b6f(%rip), %eax      # 0x180011154
1800095e5:     	movb	$-0x20, %dl
1800095e7:     	orl	$0x8, %eax
1800095ea:     	movl	$0x3, 0x7b5c(%rip)      # 0x180011150
1800095f4:     	movl	%eax, 0x7b5a(%rip)      # 0x180011154
1800095fa:     	testb	$0x20, %r10b
1800095fe:     	je	0x180009662 <numba_list_iter_next+0xdc2>
180009600:     	orl	$0x20, %eax
180009603:     	movl	$0x5, 0x7b43(%rip)      # 0x180011150
18000960d:     	movl	%eax, 0x7b41(%rip)      # 0x180011154
180009613:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180009618:     	movq	0x7b49(%rip), %rax      # 0x180011168
18000961f:     	andl	%ecx, %r10d
180009622:     	andq	$-0x3, %rax
180009626:     	movq	%rax, 0x7b3b(%rip)      # 0x180011168
18000962d:     	cmpl	%ecx, %r10d
180009630:     	jne	0x180009669 <numba_list_iter_next+0xdc9>
180009632:     	movq	0x20(%rsp), %rax
180009637:     	andb	%dl, %al
180009639:     	cmpb	%dl, %al
18000963b:     	jne	0x180009662 <numba_list_iter_next+0xdc2>
18000963d:     	movq	0x7b24(%rip), %rax      # 0x180011168
180009644:     	orl	$0x40, 0x7b09(%rip)     # 0x180011154
18000964b:     	andq	$-0x25, %rax
18000964f:     	movl	$0x6, 0x7af7(%rip)      # 0x180011150
180009659:     	movq	%rax, 0x7b08(%rip)      # 0x180011168
180009660:     	jmp	0x180009669 <numba_list_iter_next+0xdc9>
180009662:     	movq	0x7aff(%rip), %rax      # 0x180011168
180009669:     	btl	$0x17, %esi
18000966d:     	jae	0x18000967b <numba_list_iter_next+0xddb>
18000966f:     	btrq	$0x18, %rax
180009674:     	movq	%rax, 0x7aed(%rip)      # 0x180011168
18000967b:     	btl	$0x13, %r9d
180009680:     	jae	0x1800096d0 <numba_list_iter_next+0xe30>
180009682:     	movq	0x20(%rsp), %rax
180009687:     	andb	%dl, %al
180009689:     	cmpb	%dl, %al
18000968b:     	jne	0x1800096d0 <numba_list_iter_next+0xe30>
18000968d:     	movq	0x7ad4(%rip), %rdx      # 0x180011168
180009694:     	movl	%r11d, %eax
180009697:     	shrq	$0x10, %rax
18000969b:     	movl	%r11d, %ecx
18000969e:     	andl	$0x6, %eax
1800096a1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
1800096a7:     	orq	$0x1000029, %rax        # imm = 0x1000029
1800096ad:     	movl	%ecx, 0x83a5(%rip)      # 0x180011a58
1800096b3:     	notq	%rax
1800096b6:     	andq	%rax, %rdx
1800096b9:     	movq	%rdx, 0x7aa8(%rip)      # 0x180011168
1800096c0:     	cmpb	$0x1, %cl
1800096c3:     	jbe	0x1800096d0 <numba_list_iter_next+0xe30>
1800096c5:     	andq	$-0x41, %rdx
1800096c9:     	movq	%rdx, 0x7a98(%rip)      # 0x180011168
1800096d0:     	btl	$0x15, %r9d
1800096d5:     	jae	0x1800096ec <numba_list_iter_next+0xe4c>
1800096d7:     	movq	0x20(%rsp), %rax
1800096dc:     	btq	$0x13, %rax
1800096e1:     	jae	0x1800096ec <numba_list_iter_next+0xe4c>
1800096e3:     	btrq	$0x7, 0x7a7c(%rip)      # 0x180011168
1800096ec:     	movq	0x28(%rsp), %rbx
1800096f1:     	xorl	%eax, %eax
1800096f3:     	movq	0x30(%rsp), %rbp
1800096f8:     	movq	0x38(%rsp), %rsi
1800096fd:     	addq	$0x10, %rsp
180009701:     	popq	%rdi
180009702:     	retq
180009703:     	int3
180009704:     	movl	$0x1, %eax
180009709:     	retq
18000970a:     	int3
18000970b:     	int3
18000970c:     	xorl	%eax, %eax
18000970e:     	cmpl	%eax, 0x7a5c(%rip)      # 0x180011170
180009714:     	setne	%al
180009717:     	retq
180009718:     	int3
180009719:     	int3
18000971a:     	int3
18000971b:     	int3
18000971c:     	int3
18000971d:     	int3
18000971e:     	int3
18000971f:     	int3
180009720:     	jmpq	*0x922(%rip)            # 0x18000a048
180009726:     	jmpq	*0x924(%rip)            # 0x18000a050
18000972c:     	jmpq	*0x95e(%rip)            # 0x18000a090
180009732:     	jmpq	*0x960(%rip)            # 0x18000a098
180009738:     	jmpq	*0x962(%rip)            # 0x18000a0a0
18000973e:     	jmpq	*0x964(%rip)            # 0x18000a0a8
180009744:     	jmpq	*0x966(%rip)            # 0x18000a0b0
18000974a:     	jmpq	*0x930(%rip)            # 0x18000a080
180009750:     	jmpq	*0x962(%rip)            # 0x18000a0b8
180009756:     	jmpq	*0x92c(%rip)            # 0x18000a088
18000975c:     	movb	$0x1, %al
18000975e:     	retq
18000975f:     	int3
180009760:     	xorl	%eax, %eax
180009762:     	retq
180009763:     	jmpq	*0x8cf(%rip)            # 0x18000a038
180009769:     	jmpq	*0x8d1(%rip)            # 0x18000a040
18000976f:     	jmpq	*0x953(%rip)            # 0x18000a0c8
180009775:     	jmpq	*0x955(%rip)            # 0x18000a0d0
18000977b:     	int3
18000977c:     	int3
18000977d:     	int3
18000977e:     	int3
18000977f:     	int3
180009780:     	int3
180009781:     	int3
180009782:     	int3
180009783:     	int3
180009784:     	int3
180009785:     	int3
180009786:     	nopw	(%rax,%rax)
180009790:     	jmpq	*%rax
180009792:     	int3
180009793:     	int3
180009794:     	int3
180009795:     	int3
180009796:     	int3
180009797:     	int3
180009798:     	int3
180009799:     	int3
18000979a:     	int3
18000979b:     	int3
18000979c:     	int3
18000979d:     	int3
18000979e:     	int3
18000979f:     	int3
1800097a0:     	int3
1800097a1:     	int3
1800097a2:     	int3
1800097a3:     	int3
1800097a4:     	int3
1800097a5:     	int3
1800097a6:     	nopw	(%rax,%rax)
1800097b0:     	jmpq	*0xb7a(%rip)            # 0x18000a330
1800097b6:     	pushq	%rbp
1800097b8:     	subq	$0x20, %rsp
1800097bc:     	movq	%rdx, %rbp
1800097bf:     	movb	0x40(%rbp), %cl
1800097c2:     	addq	$0x20, %rsp
1800097c6:     	popq	%rbp
1800097c7:     	jmp	0x18000938c <numba_list_iter_next+0xaec>
1800097cc:     	int3
1800097cd:     	pushq	%rbp
1800097cf:     	subq	$0x20, %rsp
1800097d3:     	movq	%rdx, %rbp
1800097d6:     	movb	0x20(%rbp), %cl
1800097d9:     	callq	0x18000938c <numba_list_iter_next+0xaec>
1800097de:     	nop
1800097df:     	addq	$0x20, %rsp
1800097e3:     	popq	%rbp
1800097e4:     	retq
1800097e5:     	int3
1800097e6:     	pushq	%rbp
1800097e8:     	subq	$0x20, %rsp
1800097ec:     	movq	%rdx, %rbp
1800097ef:     	addq	$0x20, %rsp
1800097f3:     	popq	%rbp
1800097f4:     	jmp	0x180009218 <numba_list_iter_next+0x978>
1800097f9:     	int3
1800097fa:     	pushq	%rbp
1800097fc:     	subq	$0x30, %rsp
180009800:     	movq	%rdx, %rbp
180009803:     	movq	(%rcx), %rax
180009806:     	movl	(%rax), %edx
180009808:     	movq	%rcx, 0x28(%rsp)
18000980d:     	movl	%edx, 0x20(%rsp)
180009811:     	leaq	-0xbc8(%rip), %r9       # 0x180008c50 <numba_list_iter_next+0x3b0>
180009818:     	movq	0x70(%rbp), %r8
18000981c:     	movl	0x68(%rbp), %edx
18000981f:     	movq	0x60(%rbp), %rcx
180009823:     	callq	0x180009188 <numba_list_iter_next+0x8e8>
180009828:     	nop
180009829:     	addq	$0x30, %rsp
18000982d:     	popq	%rbp
18000982e:     	retq
18000982f:     	int3
180009830:     	pushq	%rbp
180009832:     	movq	%rdx, %rbp
180009835:     	movq	(%rcx), %rax
180009838:     	xorl	%ecx, %ecx
18000983a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180009840:     	sete	%cl
180009843:     	movl	%ecx, %eax
180009845:     	popq	%rbp
180009846:     	retq
180009847:     	int3
