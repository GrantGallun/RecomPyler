
D:\Code\Datathon\recompyler-codex-20261111\wave10-measurements\results-binding-final\aot\unchecked-int64\recurrence_1\rcnumeric_c6a048f0e997a3016910f788.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180002de0 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x3319(%rip), %rax      # 0x1800043a0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	imulq	%r8, %rdx
180001094:     	addq	%r9, %rdx
180001097:     	movq	%rdx, (%rcx)
18000109a:     	retq
18000109b:     	nopl	(%rax,%rax)
1800010a0:     	pushq	%r15
1800010a2:     	pushq	%r14
1800010a4:     	pushq	%r13
1800010a6:     	pushq	%r12
1800010a8:     	pushq	%rsi
1800010a9:     	pushq	%rdi
1800010aa:     	pushq	%rbp
1800010ab:     	pushq	%rbx
1800010ac:     	subq	$0x198, %rsp            # imm = 0x198
1800010b3:     	movq	%rdx, %rcx
1800010b6:     	leaq	0x68(%rsp), %rax
1800010bb:     	movq	%rax, 0x50(%rsp)
1800010c0:     	leaq	0x70(%rsp), %rax
1800010c5:     	movq	%rax, 0x48(%rsp)
1800010ca:     	leaq	0x78(%rsp), %rax
1800010cf:     	movq	%rax, 0x40(%rsp)
1800010d4:     	leaq	0x80(%rsp), %rax
1800010dc:     	movq	%rax, 0x38(%rsp)
1800010e1:     	leaq	0x88(%rsp), %rax
1800010e9:     	movq	%rax, 0x30(%rsp)
1800010ee:     	leaq	0x90(%rsp), %rax
1800010f6:     	movq	%rax, 0x28(%rsp)
1800010fb:     	leaq	0x98(%rsp), %rax
180001103:     	movq	%rax, 0x20(%rsp)
180001108:     	leaq	0x32b9(%rip), %rdx      # 0x1800043c8
18000110f:     	movl	$0x7, %r8d
180001115:     	movl	$0x7, %r9d
18000111b:     	callq	0x180002f71 <numba_list_iter_next+0x2f1>
180001120:     	testl	%eax, %eax
180001122:     	movq	$0x0, 0x60(%rsp)
18000112b:     	je	0x18000146b <.text+0x46b>
180001131:     	cmpq	$0x0, 0x9b27(%rip)      # 0x18000ac60
180001139:     	je	0x1800013a5 <.text+0x3a5>
18000113f:     	movq	0x98(%rsp), %rcx
180001147:     	xorps	%xmm0, %xmm0
18000114a:     	movaps	%xmm0, 0x160(%rsp)
180001152:     	movaps	%xmm0, 0x170(%rsp)
18000115a:     	movaps	%xmm0, 0x180(%rsp)
180001162:     	movq	$0x0, 0x190(%rsp)
18000116e:     	leaq	0x160(%rsp), %rdx
180001176:     	callq	0x180001c50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7a0>
18000117b:     	testl	%eax, %eax
18000117d:     	jne	0x1800013bd <.text+0x3bd>
180001183:     	cmpq	$0x8, 0x178(%rsp)
18000118c:     	jne	0x1800013bd <.text+0x3bd>
180001192:     	movq	0x160(%rsp), %rsi
18000119a:     	movq	0x90(%rsp), %rcx
1800011a2:     	xorps	%xmm0, %xmm0
1800011a5:     	movaps	%xmm0, 0x120(%rsp)
1800011ad:     	movaps	%xmm0, 0x130(%rsp)
1800011b5:     	movaps	%xmm0, 0x140(%rsp)
1800011bd:     	movq	$0x0, 0x150(%rsp)
1800011c9:     	leaq	0x120(%rsp), %rdx
1800011d1:     	callq	0x180001c50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7a0>
1800011d6:     	testl	%eax, %eax
1800011d8:     	jne	0x1800013d5 <.text+0x3d5>
1800011de:     	cmpq	$0x8, 0x138(%rsp)
1800011e7:     	jne	0x1800013d5 <.text+0x3d5>
1800011ed:     	movq	0x120(%rsp), %rdi
1800011f5:     	movq	0x88(%rsp), %rcx
1800011fd:     	xorps	%xmm0, %xmm0
180001200:     	movaps	%xmm0, 0xe0(%rsp)
180001208:     	movaps	%xmm0, 0xf0(%rsp)
180001210:     	movaps	%xmm0, 0x100(%rsp)
180001218:     	movq	$0x0, 0x110(%rsp)
180001224:     	leaq	0xe0(%rsp), %rdx
18000122c:     	callq	0x180001c50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7a0>
180001231:     	testl	%eax, %eax
180001233:     	jne	0x1800013ea <.text+0x3ea>
180001239:     	cmpq	$0x8, 0xf8(%rsp)
180001242:     	jne	0x1800013ea <.text+0x3ea>
180001248:     	movq	0xe0(%rsp), %rbx
180001250:     	movq	0x80(%rsp), %rcx
180001258:     	xorps	%xmm0, %xmm0
18000125b:     	movaps	%xmm0, 0xa0(%rsp)
180001263:     	movaps	%xmm0, 0xb0(%rsp)
18000126b:     	movaps	%xmm0, 0xc0(%rsp)
180001273:     	movq	$0x0, 0xd0(%rsp)
18000127f:     	leaq	0xa0(%rsp), %rdx
180001287:     	callq	0x180001c50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7a0>
18000128c:     	testl	%eax, %eax
18000128e:     	jne	0x1800013ff <.text+0x3ff>
180001294:     	cmpq	$0x1, 0xb8(%rsp)
18000129d:     	jne	0x1800013ff <.text+0x3ff>
1800012a3:     	movq	0xa0(%rsp), %r14
1800012ab:     	movq	0x78(%rsp), %rcx
1800012b0:     	callq	0x180002f77 <numba_list_iter_next+0x2f7>
1800012b5:     	testq	%rax, %rax
1800012b8:     	je	0x180001414 <.text+0x414>
1800012be:     	movq	%rax, %r12
1800012c1:     	movq	%rax, %rcx
1800012c4:     	callq	0x180002f7d <numba_list_iter_next+0x2fd>
1800012c9:     	movq	%rax, %r15
1800012cc:     	movq	%r12, %rcx
1800012cf:     	callq	0x180002f83 <numba_list_iter_next+0x303>
1800012d4:     	callq	0x180002f89 <numba_list_iter_next+0x309>
1800012d9:     	testq	%rax, %rax
1800012dc:     	jne	0x18000144b <.text+0x44b>
1800012e2:     	movq	0x70(%rsp), %rcx
1800012e7:     	callq	0x180002f77 <numba_list_iter_next+0x2f7>
1800012ec:     	testq	%rax, %rax
1800012ef:     	je	0x180001427 <.text+0x427>
1800012f5:     	movq	%rax, %r13
1800012f8:     	movq	%rax, %rcx
1800012fb:     	callq	0x180002f7d <numba_list_iter_next+0x2fd>
180001300:     	movq	%rax, %r12
180001303:     	movq	%r13, %rcx
180001306:     	callq	0x180002f83 <numba_list_iter_next+0x303>
18000130b:     	callq	0x180002f89 <numba_list_iter_next+0x309>
180001310:     	testq	%rax, %rax
180001313:     	jne	0x18000144b <.text+0x44b>
180001319:     	movq	0x68(%rsp), %rcx
18000131e:     	callq	0x180002f77 <numba_list_iter_next+0x2f7>
180001323:     	testq	%rax, %rax
180001326:     	je	0x18000143a <.text+0x43a>
18000132c:     	movq	%rax, %rbp
18000132f:     	movq	%rax, %rcx
180001332:     	callq	0x180002f7d <numba_list_iter_next+0x2fd>
180001337:     	movq	%rax, %r13
18000133a:     	movq	%rbp, %rcx
18000133d:     	callq	0x180002f83 <numba_list_iter_next+0x303>
180001342:     	callq	0x180002f89 <numba_list_iter_next+0x309>
180001347:     	testq	%rax, %rax
18000134a:     	jne	0x18000144b <.text+0x44b>
180001350:     	leaq	0x60(%rsp), %rcx
180001355:     	movq	%r15, %rdx
180001358:     	movq	%r12, %r8
18000135b:     	movq	%r13, %r9
18000135e:     	callq	0x180001090 <.text+0x90>
180001363:     	movq	0x60(%rsp), %r15
180001368:     	movq	%rsi, %rcx
18000136b:     	callq	0x180001060 <.text+0x60>
180001370:     	movq	%rdi, %rcx
180001373:     	callq	0x180001060 <.text+0x60>
180001378:     	movq	%rbx, %rcx
18000137b:     	callq	0x180001060 <.text+0x60>
180001380:     	movq	%r14, %rcx
180001383:     	callq	0x180001060 <.text+0x60>
180001388:     	movq	%r15, %rcx
18000138b:     	callq	0x180002f8f <numba_list_iter_next+0x30f>
180001390:     	nop
180001391:     	addq	$0x198, %rsp            # imm = 0x198
180001398:     	popq	%rbx
180001399:     	popq	%rbp
18000139a:     	popq	%rdi
18000139b:     	popq	%rsi
18000139c:     	popq	%r12
18000139e:     	popq	%r13
1800013a0:     	popq	%r14
1800013a2:     	popq	%r15
1800013a4:     	retq
1800013a5:     	movq	0x2e8c(%rip), %rcx      # 0x180004238
1800013ac:     	leaq	0x302d(%rip), %rdx      # 0x1800043e0
1800013b3:     	callq	0x180002f95 <numba_list_iter_next+0x315>
1800013b8:     	jmp	0x18000146b <.text+0x46b>
1800013bd:     	movq	0x2e64(%rip), %rcx      # 0x180004228
1800013c4:     	leaq	0x3105(%rip), %rdx      # 0x1800044d0
1800013cb:     	callq	0x180002f95 <numba_list_iter_next+0x315>
1800013d0:     	jmp	0x18000146b <.text+0x46b>
1800013d5:     	movq	0x2e4c(%rip), %rcx      # 0x180004228
1800013dc:     	leaq	0x30ed(%rip), %rdx      # 0x1800044d0
1800013e3:     	callq	0x180002f95 <numba_list_iter_next+0x315>
1800013e8:     	jmp	0x180001463 <.text+0x463>
1800013ea:     	movq	0x2e37(%rip), %rcx      # 0x180004228
1800013f1:     	leaq	0x30d8(%rip), %rdx      # 0x1800044d0
1800013f8:     	callq	0x180002f95 <numba_list_iter_next+0x315>
1800013fd:     	jmp	0x18000145b <.text+0x45b>
1800013ff:     	movq	0x2e22(%rip), %rcx      # 0x180004228
180001406:     	leaq	0x30c3(%rip), %rdx      # 0x1800044d0
18000140d:     	callq	0x180002f95 <numba_list_iter_next+0x315>
180001412:     	jmp	0x180001453 <.text+0x453>
180001414:     	xorl	%r15d, %r15d
180001417:     	callq	0x180002f89 <numba_list_iter_next+0x309>
18000141c:     	testq	%rax, %rax
18000141f:     	je	0x1800012e2 <.text+0x2e2>
180001425:     	jmp	0x18000144b <.text+0x44b>
180001427:     	xorl	%r12d, %r12d
18000142a:     	callq	0x180002f89 <numba_list_iter_next+0x309>
18000142f:     	testq	%rax, %rax
180001432:     	je	0x180001319 <.text+0x319>
180001438:     	jmp	0x18000144b <.text+0x44b>
18000143a:     	xorl	%r13d, %r13d
18000143d:     	callq	0x180002f89 <numba_list_iter_next+0x309>
180001442:     	testq	%rax, %rax
180001445:     	je	0x180001350 <.text+0x350>
18000144b:     	movq	%r14, %rcx
18000144e:     	callq	0x180001060 <.text+0x60>
180001453:     	movq	%rbx, %rcx
180001456:     	callq	0x180001060 <.text+0x60>
18000145b:     	movq	%rdi, %rcx
18000145e:     	callq	0x180001060 <.text+0x60>
180001463:     	movq	%rsi, %rcx
180001466:     	callq	0x180001060 <.text+0x60>
18000146b:     	xorl	%eax, %eax
18000146d:     	jmp	0x180001391 <.text+0x391>
180001472:     	nopw	%cs:(%rax,%rax)
18000147c:     	nopl	(%rax)
180001480:     	subq	$0x28, %rsp
180001484:     	movq	0x110(%rsp), %rdx
18000148c:     	movq	0x118(%rsp), %r8
180001494:     	movq	0x120(%rsp), %r9
18000149c:     	leaq	0x20(%rsp), %rcx
1800014a1:     	callq	0x180001090 <.text+0x90>
1800014a6:     	movq	0x20(%rsp), %rax
1800014ab:     	addq	$0x28, %rsp
1800014af:     	retq

00000001800014b0 <PyInit_rcnumeric_c6a048f0e997a3016910f788>:
1800014b0:     	pushq	%rsi
1800014b1:     	subq	$0x20, %rsp
1800014b5:     	leaq	0x8b84(%rip), %rcx      # 0x18000a040
1800014bc:     	movl	$0x3f5, %edx            # imm = 0x3F5
1800014c1:     	callq	0x180002f9b <numba_list_iter_next+0x31b>
1800014c6:     	testq	%rax, %rax
1800014c9:     	je	0x1800014fb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x4b>
1800014cb:     	leaq	0x8b2e(%rip), %rdx      # 0x18000a000
1800014d2:     	leaq	0x30a7(%rip), %r8       # 0x180004580
1800014d9:     	leaq	0x30c8(%rip), %r9       # 0x1800045a8
1800014e0:     	movq	%rax, %rcx
1800014e3:     	movq	%rax, %rsi
1800014e6:     	callq	0x180001ec0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xa10>
1800014eb:     	movl	%eax, %ecx
1800014ed:     	xorl	%eax, %eax
1800014ef:     	testl	%ecx, %ecx
1800014f1:     	cmoveq	%rsi, %rax
1800014f5:     	addq	$0x20, %rsp
1800014f9:     	popq	%rsi
1800014fa:     	retq
1800014fb:     	xorl	%eax, %eax
1800014fd:     	addq	$0x20, %rsp
180001501:     	popq	%rsi
180001502:     	retq
180001503:     	int3
180001504:     	int3
180001505:     	int3
180001506:     	int3
180001507:     	int3
180001508:     	int3
180001509:     	int3
18000150a:     	int3
18000150b:     	int3
18000150c:     	int3
18000150d:     	int3
18000150e:     	int3
18000150f:     	int3
180001510:     	movq	%rbx, 0x8(%rsp)
180001515:     	movq	%rsi, 0x10(%rsp)
18000151a:     	pushq	%rdi
18000151b:     	subq	$0x20, %rsp
18000151f:     	movq	%rcx, %rbx
180001522:     	movq	%r8, %rdi
180001525:     	movq	0x10(%rcx), %rcx
180001529:     	movq	%rdx, %rsi
18000152c:     	testq	%rcx, %rcx
18000152f:     	je	0x18000153a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x8a>
180001531:     	movq	%r8, %rdx
180001534:     	callq	*%rsi
180001536:     	testl	%eax, %eax
180001538:     	jne	0x18000155d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xad>
18000153a:     	movq	0x18(%rbx), %rcx
18000153e:     	testq	%rcx, %rcx
180001541:     	je	0x18000155b <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xab>
180001543:     	movq	%rdi, %rdx
180001546:     	movq	%rsi, %rax
180001549:     	movq	0x30(%rsp), %rbx
18000154e:     	movq	0x38(%rsp), %rsi
180001553:     	addq	$0x20, %rsp
180001557:     	popq	%rdi
180001558:     	jmpq	*%rax
18000155b:     	xorl	%eax, %eax
18000155d:     	movq	0x30(%rsp), %rbx
180001562:     	movq	0x38(%rsp), %rsi
180001567:     	addq	$0x20, %rsp
18000156b:     	popq	%rdi
18000156c:     	retq
18000156d:     	int3
18000156e:     	int3
18000156f:     	int3
180001570:     	pushq	%rbx
180001572:     	subq	$0x20, %rsp
180001576:     	movq	%rcx, %rbx
180001579:     	movq	0x10(%rcx), %rcx
18000157d:     	testq	%rcx, %rcx
180001580:     	je	0x18000159d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xed>
180001582:     	movq	$0x0, 0x10(%rbx)
18000158a:     	movl	(%rcx), %eax
18000158c:     	testl	%eax, %eax
18000158e:     	js	0x18000159d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xed>
180001590:     	subl	$0x1, %eax
180001593:     	movl	%eax, (%rcx)
180001595:     	jne	0x18000159d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xed>
180001597:     	callq	*0x2c13(%rip)           # 0x1800041b0
18000159d:     	movq	0x18(%rbx), %rcx
1800015a1:     	testq	%rcx, %rcx
1800015a4:     	je	0x1800015c1 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x111>
1800015a6:     	movq	$0x0, 0x18(%rbx)
1800015ae:     	movl	(%rcx), %eax
1800015b0:     	testl	%eax, %eax
1800015b2:     	js	0x1800015c1 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x111>
1800015b4:     	subl	$0x1, %eax
1800015b7:     	movl	%eax, (%rcx)
1800015b9:     	jne	0x1800015c1 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x111>
1800015bb:     	callq	*0x2bef(%rip)           # 0x1800041b0
1800015c1:     	xorl	%eax, %eax
1800015c3:     	addq	$0x20, %rsp
1800015c7:     	popq	%rbx
1800015c8:     	retq
1800015c9:     	int3
1800015ca:     	int3
1800015cb:     	int3
1800015cc:     	int3
1800015cd:     	int3
1800015ce:     	int3
1800015cf:     	int3
1800015d0:     	pushq	%rbx
1800015d2:     	subq	$0x20, %rsp
1800015d6:     	movq	%rcx, %rbx
1800015d9:     	callq	*0x2c11(%rip)           # 0x1800041f0
1800015df:     	movq	0x10(%rbx), %rcx
1800015e3:     	testq	%rcx, %rcx
1800015e6:     	je	0x180001603 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x153>
1800015e8:     	movq	$0x0, 0x10(%rbx)
1800015f0:     	movl	(%rcx), %eax
1800015f2:     	testl	%eax, %eax
1800015f4:     	js	0x180001603 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x153>
1800015f6:     	subl	$0x1, %eax
1800015f9:     	movl	%eax, (%rcx)
1800015fb:     	jne	0x180001603 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x153>
1800015fd:     	callq	*0x2bad(%rip)           # 0x1800041b0
180001603:     	movq	0x18(%rbx), %rcx
180001607:     	testq	%rcx, %rcx
18000160a:     	je	0x180001627 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x177>
18000160c:     	movq	$0x0, 0x18(%rbx)
180001614:     	movl	(%rcx), %eax
180001616:     	testl	%eax, %eax
180001618:     	js	0x180001627 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x177>
18000161a:     	subl	$0x1, %eax
18000161d:     	movl	%eax, (%rcx)
18000161f:     	jne	0x180001627 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x177>
180001621:     	callq	*0x2b89(%rip)           # 0x1800041b0
180001627:     	movq	0x8(%rbx), %rax
18000162b:     	movq	%rbx, %rcx
18000162e:     	addq	$0x20, %rsp
180001632:     	popq	%rbx
180001633:     	jmpq	*0x140(%rax)
18000163a:     	int3
18000163b:     	int3
18000163c:     	int3
18000163d:     	int3
18000163e:     	int3
18000163f:     	int3
180001640:     	pushq	%rbx
180001642:     	subq	$0x30, %rsp
180001646:     	movq	%r8, %r10
180001649:     	leaq	0x58(%rsp), %rax
18000164e:     	movq	%rax, 0x28(%rsp)
180001653:     	leaq	0x9336(%rip), %r9       # 0x18000a990
18000165a:     	movq	0x2b5f(%rip), %rax      # 0x1800041c0
180001661:     	leaq	0x3280(%rip), %r8       # 0x1800048e8
180001668:     	movq	%rdx, %r11
18000166b:     	movq	%rax, 0x20(%rsp)
180001670:     	movq	%rcx, %rbx
180001673:     	movq	%r10, %rdx
180001676:     	movq	%r11, %rcx
180001679:     	callq	*0x2a61(%rip)           # 0x1800040e0
18000167f:     	testl	%eax, %eax
180001681:     	je	0x1800016dc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x22c>
180001683:     	xorl	%r8d, %r8d
180001686:     	xorl	%edx, %edx
180001688:     	movq	%rbx, %rcx
18000168b:     	callq	*0x2b7f(%rip)           # 0x180004210
180001691:     	movq	%rax, %rbx
180001694:     	testq	%rax, %rax
180001697:     	je	0x1800016dc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x22c>
180001699:     	movq	0x58(%rsp), %rax
18000169e:     	movl	(%rax), %ecx
1800016a0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800016a6:     	jae	0x1800016b1 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x201>
1800016a8:     	incl	%ecx
1800016aa:     	movl	%ecx, (%rax)
1800016ac:     	movq	0x58(%rsp), %rax
1800016b1:     	xorl	%ecx, %ecx
1800016b3:     	movq	%rax, 0x10(%rbx)
1800016b7:     	callq	*0x2ab3(%rip)           # 0x180004170
1800016bd:     	movq	%rax, 0x18(%rbx)
1800016c1:     	testq	%rax, %rax
1800016c4:     	jne	0x1800016e4 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x234>
1800016c6:     	movl	(%rbx), %eax
1800016c8:     	testl	%eax, %eax
1800016ca:     	js	0x1800016dc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x22c>
1800016cc:     	subl	$0x1, %eax
1800016cf:     	movl	%eax, (%rbx)
1800016d1:     	jne	0x1800016dc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x22c>
1800016d3:     	movq	%rbx, %rcx
1800016d6:     	callq	*0x2ad4(%rip)           # 0x1800041b0
1800016dc:     	xorl	%eax, %eax
1800016de:     	addq	$0x30, %rsp
1800016e2:     	popq	%rbx
1800016e3:     	retq
1800016e4:     	movq	%rbx, %rax
1800016e7:     	addq	$0x30, %rsp
1800016eb:     	popq	%rbx
1800016ec:     	retq
1800016ed:     	int3
1800016ee:     	int3
1800016ef:     	int3
1800016f0:     	movq	%rbx, 0x8(%rsp)
1800016f5:     	movq	%rsi, 0x10(%rsp)
1800016fa:     	pushq	%rdi
1800016fb:     	subq	$0x20, %rsp
1800016ff:     	movq	%rcx, %rbx
180001702:     	movq	%r8, %rdi
180001705:     	movq	0x18(%rcx), %rcx
180001709:     	movq	%rdx, %rsi
18000170c:     	testq	%rcx, %rcx
18000170f:     	je	0x18000171a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x26a>
180001711:     	movq	%r8, %rdx
180001714:     	callq	*%rsi
180001716:     	testl	%eax, %eax
180001718:     	jne	0x18000173d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x28d>
18000171a:     	movq	0x40(%rbx), %rcx
18000171e:     	testq	%rcx, %rcx
180001721:     	je	0x18000173b <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x28b>
180001723:     	movq	%rdi, %rdx
180001726:     	movq	%rsi, %rax
180001729:     	movq	0x30(%rsp), %rbx
18000172e:     	movq	0x38(%rsp), %rsi
180001733:     	addq	$0x20, %rsp
180001737:     	popq	%rdi
180001738:     	jmpq	*%rax
18000173b:     	xorl	%eax, %eax
18000173d:     	movq	0x30(%rsp), %rbx
180001742:     	movq	0x38(%rsp), %rsi
180001747:     	addq	$0x20, %rsp
18000174b:     	popq	%rdi
18000174c:     	retq
18000174d:     	int3
18000174e:     	int3
18000174f:     	int3
180001750:     	pushq	%rbx
180001752:     	subq	$0x20, %rsp
180001756:     	movq	%rcx, %rbx
180001759:     	callq	*0x2a91(%rip)           # 0x1800041f0
18000175f:     	cmpq	$0x0, 0x48(%rbx)
180001764:     	je	0x18000176f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x2bf>
180001766:     	movq	%rbx, %rcx
180001769:     	callq	*0x2a11(%rip)           # 0x180004180
18000176f:     	movq	0x20(%rbx), %rcx
180001773:     	callq	*0x2a27(%rip)           # 0x1800041a0
180001779:     	movq	0x38(%rbx), %rcx
18000177d:     	callq	*0x2a1d(%rip)           # 0x1800041a0
180001783:     	movq	0x18(%rbx), %rcx
180001787:     	testq	%rcx, %rcx
18000178a:     	je	0x18000179f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x2ef>
18000178c:     	movl	(%rcx), %eax
18000178e:     	testl	%eax, %eax
180001790:     	js	0x18000179f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x2ef>
180001792:     	subl	$0x1, %eax
180001795:     	movl	%eax, (%rcx)
180001797:     	jne	0x18000179f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x2ef>
180001799:     	callq	*0x2a11(%rip)           # 0x1800041b0
18000179f:     	movq	0x40(%rbx), %rcx
1800017a3:     	testq	%rcx, %rcx
1800017a6:     	je	0x1800017bb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x30b>
1800017a8:     	movl	(%rcx), %eax
1800017aa:     	testl	%eax, %eax
1800017ac:     	js	0x1800017bb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x30b>
1800017ae:     	subl	$0x1, %eax
1800017b1:     	movl	%eax, (%rcx)
1800017b3:     	jne	0x1800017bb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x30b>
1800017b5:     	callq	*0x29f5(%rip)           # 0x1800041b0
1800017bb:     	movq	0x8(%rbx), %rax
1800017bf:     	movq	%rbx, %rcx
1800017c2:     	addq	$0x20, %rsp
1800017c6:     	popq	%rbx
1800017c7:     	jmpq	*0x140(%rax)
1800017ce:     	int3
1800017cf:     	int3
1800017d0:     	pushq	%rbx
1800017d2:     	subq	$0x20, %rsp
1800017d6:     	callq	*0x299c(%rip)           # 0x180004178
1800017dc:     	movq	%rax, %rbx
1800017df:     	testq	%rax, %rax
1800017e2:     	jne	0x1800017ea <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x33a>
1800017e4:     	addq	$0x20, %rsp
1800017e8:     	popq	%rbx
1800017e9:     	retq
1800017ea:     	movq	%rbx, %rcx
1800017ed:     	movq	%rdi, 0x30(%rsp)
1800017f2:     	callq	0x180003b05 <numba_list_iter_next+0xe85>
1800017f7:     	leaq	0x1(%rax), %rcx
1800017fb:     	callq	*0x2a17(%rip)           # 0x180004218
180001801:     	movq	%rax, %rdi
180001804:     	testq	%rax, %rax
180001807:     	jne	0x18000181c <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x36c>
180001809:     	callq	*0x2929(%rip)           # 0x180004138
18000180f:     	movq	0x30(%rsp), %rdi
180001814:     	xorl	%eax, %eax
180001816:     	addq	$0x20, %rsp
18000181a:     	popq	%rbx
18000181b:     	retq
18000181c:     	movq	%rbx, %rdx
18000181f:     	movq	%rdi, %rcx
180001822:     	callq	0x180003aff <numba_list_iter_next+0xe7f>
180001827:     	movq	%rdi, %rax
18000182a:     	movq	0x30(%rsp), %rdi
18000182f:     	addq	$0x20, %rsp
180001833:     	popq	%rbx
180001834:     	retq
180001835:     	int3
180001836:     	int3
180001837:     	int3
180001838:     	int3
180001839:     	int3
18000183a:     	int3
18000183b:     	int3
18000183c:     	int3
18000183d:     	int3
18000183e:     	int3
18000183f:     	int3
180001840:     	movq	0x18(%rcx), %rcx
180001844:     	movq	%rdx, %rax
180001847:     	testq	%rcx, %rcx
18000184a:     	je	0x180001852 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x3a2>
18000184c:     	movq	%r8, %rdx
18000184f:     	jmpq	*%rax
180001852:     	xorl	%eax, %eax
180001854:     	retq
180001855:     	int3
180001856:     	int3
180001857:     	int3
180001858:     	int3
180001859:     	int3
18000185a:     	int3
18000185b:     	int3
18000185c:     	int3
18000185d:     	int3
18000185e:     	int3
18000185f:     	int3
180001860:     	movq	%rbx, 0x8(%rsp)
180001865:     	pushq	%rdi
180001866:     	subq	$0x20, %rsp
18000186a:     	movq	0x28(%rcx), %rax
18000186e:     	xorl	%edi, %edi
180001870:     	movq	%rcx, %rbx
180001873:     	testq	%rax, %rax
180001876:     	je	0x180001882 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x3d2>
180001878:     	addq	$0x38, %rcx
18000187c:     	callq	*%rax
18000187e:     	movq	%rdi, 0x28(%rbx)
180001882:     	movq	0x18(%rbx), %rcx
180001886:     	testq	%rcx, %rcx
180001889:     	je	0x1800018a2 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x3f2>
18000188b:     	movq	%rdi, 0x18(%rbx)
18000188f:     	movl	(%rcx), %eax
180001891:     	testl	%eax, %eax
180001893:     	js	0x1800018a2 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x3f2>
180001895:     	subl	$0x1, %eax
180001898:     	movl	%eax, (%rcx)
18000189a:     	jne	0x1800018a2 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x3f2>
18000189c:     	callq	*0x290e(%rip)           # 0x1800041b0
1800018a2:     	movq	%rdi, 0x20(%rbx)
1800018a6:     	xorl	%eax, %eax
1800018a8:     	movq	0x30(%rsp), %rbx
1800018ad:     	addq	$0x20, %rsp
1800018b1:     	popq	%rdi
1800018b2:     	retq
1800018b3:     	int3
1800018b4:     	int3
1800018b5:     	int3
1800018b6:     	int3
1800018b7:     	int3
1800018b8:     	int3
1800018b9:     	int3
1800018ba:     	int3
1800018bb:     	int3
1800018bc:     	int3
1800018bd:     	int3
1800018be:     	int3
1800018bf:     	int3
1800018c0:     	pushq	%rbx
1800018c2:     	subq	$0x20, %rsp
1800018c6:     	movq	%rcx, %rbx
1800018c9:     	callq	*0x2921(%rip)           # 0x1800041f0
1800018cf:     	cmpq	$0x0, 0x30(%rbx)
1800018d4:     	je	0x1800018df <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x42f>
1800018d6:     	movq	%rbx, %rcx
1800018d9:     	callq	*0x28a1(%rip)           # 0x180004180
1800018df:     	callq	*0x284b(%rip)           # 0x180004130
1800018e5:     	testl	%eax, %eax
1800018e7:     	jne	0x1800018f8 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x448>
1800018e9:     	movq	0x28(%rbx), %rax
1800018ed:     	testq	%rax, %rax
1800018f0:     	je	0x1800018f8 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x448>
1800018f2:     	leaq	0x38(%rbx), %rcx
1800018f6:     	callq	*%rax
1800018f8:     	movq	0x18(%rbx), %rcx
1800018fc:     	testq	%rcx, %rcx
1800018ff:     	je	0x180001914 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x464>
180001901:     	movl	(%rcx), %eax
180001903:     	testl	%eax, %eax
180001905:     	js	0x180001914 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x464>
180001907:     	subl	$0x1, %eax
18000190a:     	movl	%eax, (%rcx)
18000190c:     	jne	0x180001914 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x464>
18000190e:     	callq	*0x289c(%rip)           # 0x1800041b0
180001914:     	movq	0x8(%rbx), %rax
180001918:     	movq	%rbx, %rcx
18000191b:     	addq	$0x20, %rsp
18000191f:     	popq	%rbx
180001920:     	jmpq	*0x140(%rax)
180001927:     	int3
180001928:     	int3
180001929:     	int3
18000192a:     	int3
18000192b:     	int3
18000192c:     	int3
18000192d:     	int3
18000192e:     	int3
18000192f:     	int3
180001930:     	pushq	%rdi
180001932:     	subq	$0x20, %rsp
180001936:     	cmpq	$0x0, 0x20(%rcx)
18000193b:     	movq	%rcx, %rdi
18000193e:     	jne	0x18000195f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x4af>
180001940:     	movq	0x28f1(%rip), %rcx      # 0x180004238
180001947:     	leaq	0x2fea(%rip), %rdx      # 0x180004938
18000194e:     	movq	(%rcx), %rcx
180001951:     	callq	*0x28d9(%rip)           # 0x180004230
180001957:     	xorl	%eax, %eax
180001959:     	addq	$0x20, %rsp
18000195d:     	popq	%rdi
18000195e:     	retq
18000195f:     	movq	%rdi, %rdx
180001962:     	movq	%rbx, 0x30(%rsp)
180001967:     	movl	$0x1, %ecx
18000196c:     	callq	*0x277e(%rip)           # 0x1800040f0
180001972:     	movq	%rax, %rbx
180001975:     	testq	%rax, %rax
180001978:     	jne	0x180001985 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x4d5>
18000197a:     	movq	0x30(%rsp), %rbx
18000197f:     	addq	$0x20, %rsp
180001983:     	popq	%rdi
180001984:     	retq
180001985:     	xorl	%r8d, %r8d
180001988:     	movq	%rbx, %rdx
18000198b:     	movq	%rdi, %rcx
18000198e:     	callq	*0x20(%rdi)
180001991:     	movl	(%rbx), %ecx
180001993:     	movq	%rax, %rdi
180001996:     	testl	%ecx, %ecx
180001998:     	js	0x1800019aa <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x4fa>
18000199a:     	subl	$0x1, %ecx
18000199d:     	movl	%ecx, (%rbx)
18000199f:     	jne	0x1800019aa <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x4fa>
1800019a1:     	movq	%rbx, %rcx
1800019a4:     	callq	*0x2806(%rip)           # 0x1800041b0
1800019aa:     	movq	0x30(%rsp), %rbx
1800019af:     	movq	%rdi, %rax
1800019b2:     	addq	$0x20, %rsp
1800019b6:     	popq	%rdi
1800019b7:     	retq
1800019b8:     	int3
1800019b9:     	int3
1800019ba:     	int3
1800019bb:     	int3
1800019bc:     	int3
1800019bd:     	int3
1800019be:     	int3
1800019bf:     	int3
1800019c0:     	movq	%rbx, 0x8(%rsp)
1800019c5:     	pushq	%rdi
1800019c6:     	subq	$0x20, %rsp
1800019ca:     	movq	%r8, %rbx
1800019cd:     	callq	*0x2745(%rip)           # 0x180004118
1800019d3:     	movl	(%rbx), %ecx
1800019d5:     	movl	%eax, %edi
1800019d7:     	testl	%ecx, %ecx
1800019d9:     	js	0x1800019eb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x53b>
1800019db:     	subl	$0x1, %ecx
1800019de:     	movl	%ecx, (%rbx)
1800019e0:     	jne	0x1800019eb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x53b>
1800019e2:     	movq	%rbx, %rcx
1800019e5:     	callq	*0x27c5(%rip)           # 0x1800041b0
1800019eb:     	movl	%edi, %ecx
1800019ed:     	movq	0x30(%rsp), %rbx
1800019f2:     	addq	$0x20, %rsp
1800019f6:     	popq	%rdi
1800019f7:     	jmpq	*0x27ea(%rip)           # 0x1800041e8
1800019fe:     	int3
1800019ff:     	int3
180001a00:     	movq	%rbx, 0x8(%rsp)
180001a05:     	pushq	%rdi
180001a06:     	subq	$0x20, %rsp
180001a0a:     	movl	(%rdx), %eax
180001a0c:     	movq	%rdx, %rbx
180001a0f:     	movq	%rcx, %rdi
180001a12:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001a17:     	jae	0x180001a1d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x56d>
180001a19:     	incl	%eax
180001a1b:     	movl	%eax, (%rdx)
180001a1d:     	movl	$0x30, %ecx
180001a22:     	callq	*0x9200(%rip)           # 0x18000ac28
180001a28:     	cmpb	$0x0, 0x91d1(%rip)      # 0x18000ac00
180001a2f:     	je	0x180001a39 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x589>
180001a31:     	lock
180001a32:     	incq	0x91cf(%rip)            # 0x18000ac08
180001a39:     	testq	%rax, %rax
180001a3c:     	je	0x180001a73 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x5c3>
180001a3e:     	movl	$0x1, %ecx
180001a43:     	leaq	-0x8a(%rip), %rdx       # 0x1800019c0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x510>
180001a4a:     	xchgq	%rcx, (%rax)
180001a4d:     	xorl	%ecx, %ecx
180001a4f:     	movq	%rdx, 0x8(%rax)
180001a53:     	movq	%rcx, 0x20(%rax)
180001a57:     	movq	%rcx, 0x28(%rax)
180001a5b:     	movq	%rbx, 0x10(%rax)
180001a5f:     	movq	%rdi, 0x18(%rax)
180001a63:     	cmpb	%cl, 0x9197(%rip)       # 0x18000ac00
180001a69:     	je	0x180001a73 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x5c3>
180001a6b:     	lock
180001a6c:     	incq	0x91a5(%rip)            # 0x18000ac18
180001a73:     	movq	0x30(%rsp), %rbx
180001a78:     	addq	$0x20, %rsp
180001a7c:     	popq	%rdi
180001a7d:     	retq
180001a7e:     	int3
180001a7f:     	int3
180001a80:     	movq	%rbx, 0x8(%rsp)
180001a85:     	pushq	%rdi
180001a86:     	subq	$0x30, %rsp
180001a8a:     	movq	%rcx, %rdi
180001a8d:     	leaq	0x8eec(%rip), %r9       # 0x18000a980
180001a94:     	movq	%r8, %rax
180001a97:     	leaq	0x58(%rsp), %rcx
180001a9c:     	movq	%rdx, %r10
180001a9f:     	movq	%rcx, 0x20(%rsp)
180001aa4:     	movq	%r10, %rcx
180001aa7:     	leaq	0x2ed2(%rip), %r8       # 0x180004980
180001aae:     	movq	%rax, %rdx
180001ab1:     	callq	*0x2629(%rip)           # 0x1800040e0
180001ab7:     	testl	%eax, %eax
180001ab9:     	je	0x180001ae3 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x633>
180001abb:     	movq	0x58(%rsp), %rcx
180001ac0:     	callq	*0x2662(%rip)           # 0x180004128
180001ac6:     	movq	%rax, %rbx
180001ac9:     	callq	*0x2779(%rip)           # 0x180004248
180001acf:     	testq	%rax, %rax
180001ad2:     	jne	0x180001ae3 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x633>
180001ad4:     	movq	%rbx, 0x10(%rdi)
180001ad8:     	movq	0x40(%rsp), %rbx
180001add:     	addq	$0x30, %rsp
180001ae1:     	popq	%rdi
180001ae2:     	retq
180001ae3:     	movq	0x40(%rsp), %rbx
180001ae8:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001aed:     	addq	$0x30, %rsp
180001af1:     	popq	%rdi
180001af2:     	retq
180001af3:     	int3
180001af4:     	int3
180001af5:     	int3
180001af6:     	int3
180001af7:     	int3
180001af8:     	int3
180001af9:     	int3
180001afa:     	int3
180001afb:     	int3
180001afc:     	int3
180001afd:     	int3
180001afe:     	int3
180001aff:     	int3
180001b00:     	subq	$0x38, %rsp
180001b04:     	movl	%r8d, %eax
180001b07:     	movq	%rdx, %r10
180001b0a:     	movq	0x10(%rcx), %r8
180001b0e:     	movq	%rcx, %rdx
180001b11:     	movl	%eax, 0x28(%rsp)
180001b15:     	movq	%r10, %rcx
180001b18:     	movl	$0x0, 0x20(%rsp)
180001b20:     	movq	0x20(%r8), %r9
180001b24:     	movq	0x18(%r8), %r8
180001b28:     	callq	*0x26aa(%rip)           # 0x1800041d8
180001b2e:     	addq	$0x38, %rsp
180001b32:     	retq
180001b33:     	int3
180001b34:     	int3
180001b35:     	int3
180001b36:     	int3
180001b37:     	int3
180001b38:     	int3
180001b39:     	int3
180001b3a:     	int3
180001b3b:     	int3
180001b3c:     	int3
180001b3d:     	int3
180001b3e:     	int3
180001b3f:     	int3
180001b40:     	movq	0x10(%rcx), %rax
180001b44:     	lock
180001b45:     	incq	(%rax)
180001b48:     	movq	0x2691(%rip), %rax      # 0x1800041e0
180001b4f:     	retq
180001b50:     	subq	$0x28, %rsp
180001b54:     	movq	0x10(%rcx), %rcx
180001b58:     	callq	0x180002e50 <numba_list_iter_next+0x1d0>
180001b5d:     	movq	0x267c(%rip), %rax      # 0x1800041e0
180001b64:     	addq	$0x28, %rsp
180001b68:     	retq
180001b69:     	int3
180001b6a:     	int3
180001b6b:     	int3
180001b6c:     	int3
180001b6d:     	int3
180001b6e:     	int3
180001b6f:     	int3
180001b70:     	movq	0x10(%rcx), %rcx
180001b74:     	movq	0x18(%rcx), %rcx
180001b78:     	jmpq	*0x25d1(%rip)           # 0x180004150
180001b7f:     	int3
180001b80:     	subq	$0x28, %rsp
180001b84:     	movq	0x10(%rcx), %rax
180001b88:     	testq	%rax, %rax
180001b8b:     	je	0x180001ba9 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x6f9>
180001b8d:     	cmpq	$0x0, 0x18(%rax)
180001b92:     	je	0x180001ba9 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x6f9>
180001b94:     	movq	(%rax), %rcx
180001b97:     	nop
180001b98:     	cmpq	$-0x1, %rcx
180001b9c:     	je	0x180001ba9 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x6f9>
180001b9e:     	addq	$0x28, %rsp
180001ba2:     	jmpq	*0x255f(%rip)           # 0x180004108
180001ba9:     	movq	0x2620(%rip), %rcx      # 0x1800041d0
180001bb0:     	leaq	0x2dd1(%rip), %rdx      # 0x180004988
180001bb7:     	movq	(%rcx), %rcx
180001bba:     	callq	*0x2670(%rip)           # 0x180004230
180001bc0:     	xorl	%eax, %eax
180001bc2:     	addq	$0x28, %rsp
180001bc6:     	retq
180001bc7:     	int3
180001bc8:     	int3
180001bc9:     	int3
180001bca:     	int3
180001bcb:     	int3
180001bcc:     	int3
180001bcd:     	int3
180001bce:     	int3
180001bcf:     	int3
180001bd0:     	movq	0x10(%rcx), %rcx
180001bd4:     	movq	0x28(%rcx), %rcx
180001bd8:     	jmpq	*0x2571(%rip)           # 0x180004150
180001bdf:     	int3
180001be0:     	movq	0x10(%rcx), %rax
180001be4:     	movq	0x10(%rax), %rax
180001be8:     	testq	%rax, %rax
180001beb:     	je	0x180001bfc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x74c>
180001bed:     	movl	(%rax), %ecx
180001bef:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180001bf5:     	jae	0x180001c1a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x76a>
180001bf7:     	incl	%ecx
180001bf9:     	movl	%ecx, (%rax)
180001bfb:     	retq
180001bfc:     	movq	0x25dd(%rip), %rcx      # 0x1800041e0
180001c03:     	movl	(%rcx), %eax
180001c05:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001c0a:     	jae	0x180001c17 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x767>
180001c0c:     	incl	%eax
180001c0e:     	movl	%eax, (%rcx)
180001c10:     	movq	0x25c9(%rip), %rcx      # 0x1800041e0
180001c17:     	movq	%rcx, %rax
180001c1a:     	retq
180001c1b:     	int3
180001c1c:     	int3
180001c1d:     	int3
180001c1e:     	int3
180001c1f:     	int3
180001c20:     	pushq	%rbx
180001c22:     	subq	$0x20, %rsp
180001c26:     	movq	%rcx, %rbx
180001c29:     	movq	0x10(%rcx), %rcx
180001c2d:     	callq	0x180002e50 <numba_list_iter_next+0x1d0>
180001c32:     	movq	0x8(%rbx), %rax
180001c36:     	movq	%rbx, %rcx
180001c39:     	addq	$0x20, %rsp
180001c3d:     	popq	%rbx
180001c3e:     	jmpq	*0x140(%rax)
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
180001c50:     	movq	%rdi, 0x18(%rsp)
180001c55:     	pushq	%r14
180001c57:     	subq	$0x20, %rsp
180001c5b:     	movq	0x8fde(%rip), %rax      # 0x18000ac40
180001c62:     	movq	%rdx, %r14
180001c65:     	movq	%rcx, %rdi
180001c68:     	movq	0x8(%rcx), %rcx
180001c6c:     	movq	0x10(%rax), %rdx
180001c70:     	cmpq	%rdx, %rcx
180001c73:     	je	0x180001c90 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7e0>
180001c75:     	callq	*0x253d(%rip)           # 0x1800041b8
180001c7b:     	testl	%eax, %eax
180001c7d:     	jne	0x180001c90 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x7e0>
180001c7f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180001c84:     	movq	0x40(%rsp), %rdi
180001c89:     	addq	$0x20, %rsp
180001c8d:     	popq	%r14
180001c8f:     	retq
180001c90:     	movq	%rbx, 0x30(%rsp)
180001c95:     	movq	%rdi, %rdx
180001c98:     	movq	0x10(%rdi), %rbx
180001c9c:     	movq	%rbx, %rcx
180001c9f:     	movq	%rsi, 0x38(%rsp)
180001ca4:     	movl	0x18(%rdi), %esi
180001ca7:     	callq	0x180001a00 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x550>
180001cac:     	movq	%rax, (%r14)
180001caf:     	movq	0x8f8a(%rip), %rax      # 0x18000ac40
180001cb6:     	movq	%rbx, 0x20(%r14)
180001cba:     	movl	0x18(%rdi), %edx
180001cbd:     	movq	0x20(%rdi), %rcx
180001cc1:     	callq	*0x4f0(%rax)
180001cc7:     	cmpl	$0x12, 0x8f7e(%rip)     # 0x18000ac4c
180001cce:     	movq	0x30(%rsp), %rbx
180001cd3:     	movq	%rax, 0x10(%r14)
180001cd7:     	movq	0x38(%rdi), %rax
180001cdb:     	jl	0x180001ce3 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x833>
180001cdd:     	movq	0x28(%rax), %rax
180001ce1:     	jmp	0x180001ce7 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x837>
180001ce3:     	movslq	0x20(%rax), %rax
180001ce7:     	xorl	%r8d, %r8d
180001cea:     	movq	%rax, 0x18(%r14)
180001cee:     	movq	%rdi, 0x8(%r14)
180001cf2:     	leaq	0x28(%r14), %rax
180001cf6:     	testl	%esi, %esi
180001cf8:     	jle	0x180001d3b <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x88b>
180001cfa:     	nopw	(%rax,%rax)
180001d00:     	movq	0x20(%rdi), %rcx
180001d04:     	movq	(%rcx,%r8,8), %rdx
180001d08:     	incl	%r8d
180001d0b:     	movq	%rdx, (%rax)
180001d0e:     	addq	$0x8, %rax
180001d12:     	cmpl	%esi, %r8d
180001d15:     	jl	0x180001d00 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x850>
180001d17:     	xorl	%r8d, %r8d
180001d1a:     	nopw	(%rax,%rax)
180001d20:     	movq	0x28(%rdi), %rcx
180001d24:     	leaq	0x8(%rax), %rax
180001d28:     	movslq	%r8d, %rdx
180001d2b:     	incl	%r8d
180001d2e:     	movq	(%rcx,%rdx,8), %rdx
180001d32:     	movq	%rdx, -0x8(%rax)
180001d36:     	cmpl	%esi, %r8d
180001d39:     	jl	0x180001d20 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x870>
180001d3b:     	movq	0x38(%rsp), %rsi
180001d40:     	xorl	%eax, %eax
180001d42:     	movq	0x40(%rsp), %rdi
180001d47:     	addq	$0x20, %rsp
180001d4b:     	popq	%r14
180001d4d:     	retq
180001d4e:     	int3
180001d4f:     	int3
180001d50:     	pushq	%rbx
180001d52:     	pushq	%rbp
180001d53:     	pushq	%rsi
180001d54:     	pushq	%rdi
180001d55:     	subq	$0x28, %rsp
180001d59:     	cmpq	$0x0, 0x8eef(%rip)      # 0x18000ac50
180001d61:     	movq	%rcx, %rbp
180001d64:     	movslq	0x8(%rdx), %rdi
180001d68:     	movq	(%rdx), %rsi
180001d6b:     	jne	0x180001dc3 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x913>
180001d6d:     	leaq	0x2b54(%rip), %rcx      # 0x1800048c8
180001d74:     	callq	*0x248e(%rip)           # 0x180004208
180001d7a:     	movq	%rax, %rbx
180001d7d:     	testq	%rax, %rax
180001d80:     	je	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001d86:     	leaq	0x2b43(%rip), %rdx      # 0x1800048d0
180001d8d:     	movq	%rax, %rcx
180001d90:     	callq	*0x23ca(%rip)           # 0x180004160
180001d96:     	movl	(%rbx), %edx
180001d98:     	movq	%rax, 0x8eb1(%rip)      # 0x18000ac50
180001d9f:     	testl	%edx, %edx
180001da1:     	js	0x180001dba <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x90a>
180001da3:     	subl	$0x1, %edx
180001da6:     	movl	%edx, (%rbx)
180001da8:     	jne	0x180001dba <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x90a>
180001daa:     	movq	%rbx, %rcx
180001dad:     	callq	*0x23fd(%rip)           # 0x1800041b0
180001db3:     	movq	0x8e96(%rip), %rax      # 0x18000ac50
180001dba:     	testq	%rax, %rax
180001dbd:     	je	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001dc3:     	movq	%rdi, %rdx
180001dc6:     	movq	%rsi, %rcx
180001dc9:     	callq	*0x2351(%rip)           # 0x180004120
180001dcf:     	movq	%rax, %rdi
180001dd2:     	testq	%rax, %rax
180001dd5:     	je	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001dd7:     	movq	0x8e72(%rip), %rcx      # 0x18000ac50
180001dde:     	xorl	%r8d, %r8d
180001de1:     	movq	%rax, %rdx
180001de4:     	callq	*0x239e(%rip)           # 0x180004188
180001dea:     	movl	(%rdi), %ecx
180001dec:     	movq	%rax, %rbx
180001def:     	testl	%ecx, %ecx
180001df1:     	js	0x180001e03 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x953>
180001df3:     	subl	$0x1, %ecx
180001df6:     	movl	%ecx, (%rdi)
180001df8:     	jne	0x180001e03 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x953>
180001dfa:     	movq	%rdi, %rcx
180001dfd:     	callq	*0x23ad(%rip)           # 0x1800041b0
180001e03:     	testq	%rbx, %rbx
180001e06:     	je	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001e08:     	movq	0x8(%rbx), %r8
180001e0c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180001e17:     	jne	0x180001e55 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x9a5>
180001e19:     	movq	0x2408(%rip), %rcx      # 0x180004228
180001e20:     	leaq	0x2c69(%rip), %rdx      # 0x180004a90
180001e27:     	movq	0x18(%r8), %r8
180001e2b:     	movq	(%rcx), %rcx
180001e2e:     	callq	*0x2394(%rip)           # 0x1800041c8
180001e34:     	movl	(%rbx), %eax
180001e36:     	testl	%eax, %eax
180001e38:     	js	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001e3a:     	subl	$0x1, %eax
180001e3d:     	movl	%eax, (%rbx)
180001e3f:     	jne	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001e41:     	movq	%rbx, %rcx
180001e44:     	callq	*0x2366(%rip)           # 0x1800041b0
180001e4a:     	xorl	%eax, %eax
180001e4c:     	addq	$0x28, %rsp
180001e50:     	popq	%rdi
180001e51:     	popq	%rsi
180001e52:     	popq	%rbp
180001e53:     	popq	%rbx
180001e54:     	retq
180001e55:     	xorl	%r8d, %r8d
180001e58:     	leaq	0x84a1(%rip), %rcx      # 0x18000a300
180001e5f:     	xorl	%edx, %edx
180001e61:     	callq	*0x23a9(%rip)           # 0x180004210
180001e67:     	movq	%rax, %rdi
180001e6a:     	testq	%rax, %rax
180001e6d:     	je	0x180001e34 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x984>
180001e6f:     	movq	%rbp, %rcx
180001e72:     	movq	%rbx, 0x18(%rax)
180001e76:     	callq	*0x232c(%rip)           # 0x1800041a8
180001e7c:     	movq	%rax, 0x10(%rdi)
180001e80:     	movq	%rax, %rcx
180001e83:     	testq	%rax, %rax
180001e86:     	jne	0x180001e9a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x9ea>
180001e88:     	movl	(%rdi), %eax
180001e8a:     	testl	%eax, %eax
180001e8c:     	js	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001e8e:     	subl	$0x1, %eax
180001e91:     	movl	%eax, (%rdi)
180001e93:     	jne	0x180001e4a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x99a>
180001e95:     	movq	%rdi, %rcx
180001e98:     	jmp	0x180001e44 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x994>
180001e9a:     	movl	(%rax), %eax
180001e9c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180001ea1:     	jae	0x180001ea7 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x9f7>
180001ea3:     	incl	%eax
180001ea5:     	movl	%eax, (%rcx)
180001ea7:     	movq	%rdi, %rax
180001eaa:     	addq	$0x28, %rsp
180001eae:     	popq	%rdi
180001eaf:     	popq	%rsi
180001eb0:     	popq	%rbp
180001eb1:     	popq	%rbx
180001eb2:     	retq
180001eb3:     	int3
180001eb4:     	int3
180001eb5:     	int3
180001eb6:     	int3
180001eb7:     	int3
180001eb8:     	int3
180001eb9:     	int3
180001eba:     	int3
180001ebb:     	int3
180001ebc:     	int3
180001ebd:     	int3
180001ebe:     	int3
180001ebf:     	int3
180001ec0:     	movq	%r9, 0x20(%rsp)
180001ec5:     	movq	%r8, 0x18(%rsp)
180001eca:     	movq	%rdx, 0x10(%rsp)
180001ecf:     	movq	%rcx, 0x8(%rsp)
180001ed4:     	pushq	%rbx
180001ed5:     	pushq	%rbp
180001ed6:     	pushq	%rsi
180001ed7:     	pushq	%rdi
180001ed8:     	pushq	%r12
180001eda:     	pushq	%r13
180001edc:     	pushq	%r14
180001ede:     	pushq	%r15
180001ee0:     	subq	$0x68, %rsp
180001ee4:     	movq	%rcx, %r14
180001ee7:     	movq	%r9, %r15
180001eea:     	leaq	0x26df(%rip), %rcx      # 0x1800045d0
180001ef1:     	movq	%r8, %r13
180001ef4:     	movq	%rdx, %rsi
180001ef7:     	callq	*0x230b(%rip)           # 0x180004208
180001efd:     	movq	%rax, %rdi
180001f00:     	testq	%rax, %rax
180001f03:     	jne	0x180001f3c <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xa8c>
180001f05:     	movq	0x2204(%rip), %rcx      # 0x180004110
180001f0c:     	movq	(%rcx), %rcx
180001f0f:     	callq	*0x2283(%rip)           # 0x180004198
180001f15:     	testl	%eax, %eax
180001f17:     	je	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001f1d:     	callq	*0x2235(%rip)           # 0x180004158
180001f23:     	leaq	0x26c6(%rip), %rcx      # 0x1800045f0
180001f2a:     	callq	*0x22d8(%rip)           # 0x180004208
180001f30:     	movq	%rax, %rdi
180001f33:     	testq	%rax, %rax
180001f36:     	je	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001f3c:     	leaq	0x26cd(%rip), %rdx      # 0x180004610
180001f43:     	movq	%rdi, %rcx
180001f46:     	callq	*0x2214(%rip)           # 0x180004160
180001f4c:     	movl	(%rdi), %ecx
180001f4e:     	movq	%rax, %rbx
180001f51:     	testl	%ecx, %ecx
180001f53:     	js	0x180001f65 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xab5>
180001f55:     	subl	$0x1, %ecx
180001f58:     	movl	%ecx, (%rdi)
180001f5a:     	jne	0x180001f65 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xab5>
180001f5c:     	movq	%rdi, %rcx
180001f5f:     	callq	*0x224b(%rip)           # 0x1800041b0
180001f65:     	testq	%rbx, %rbx
180001f68:     	je	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001f6e:     	movq	0x2173(%rip), %rax      # 0x1800040e8
180001f75:     	cmpq	%rax, 0x8(%rbx)
180001f79:     	je	0x180001fb5 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb05>
180001f7b:     	movq	0x22b6(%rip), %rcx      # 0x180004238
180001f82:     	leaq	0x2697(%rip), %rdx      # 0x180004620
180001f89:     	movq	(%rcx), %rcx
180001f8c:     	callq	*0x229e(%rip)           # 0x180004230
180001f92:     	movl	(%rbx), %eax
180001f94:     	testl	%eax, %eax
180001f96:     	js	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001f9c:     	subl	$0x1, %eax
180001f9f:     	movl	%eax, (%rbx)
180001fa1:     	jne	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001fa7:     	movq	%rbx, %rcx
180001faa:     	callq	*0x2200(%rip)           # 0x1800041b0
180001fb0:     	jmp	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180001fb5:     	xorl	%edx, %edx
180001fb7:     	movq	%rbx, %rcx
180001fba:     	callq	*0x21d0(%rip)           # 0x180004190
180001fc0:     	movl	(%rbx), %ecx
180001fc2:     	movq	%rax, 0x8c77(%rip)      # 0x18000ac40
180001fc9:     	testl	%ecx, %ecx
180001fcb:     	js	0x180001fe4 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb34>
180001fcd:     	subl	$0x1, %ecx
180001fd0:     	movl	%ecx, (%rbx)
180001fd2:     	jne	0x180001fe4 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb34>
180001fd4:     	movq	%rbx, %rcx
180001fd7:     	callq	*0x21d3(%rip)           # 0x1800041b0
180001fdd:     	movq	0x8c5c(%rip), %rax      # 0x18000ac40
180001fe4:     	testq	%rax, %rax
180001fe7:     	jne	0x180002002 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb52>
180001fe9:     	leaq	0x2658(%rip), %rdx      # 0x180004648
180001ff0:     	movq	0x2241(%rip), %rcx      # 0x180004238
180001ff7:     	movq	(%rcx), %rcx
180001ffa:     	callq	*0x2230(%rip)           # 0x180004230
180002000:     	jmp	0x180002037 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb87>
180002002:     	callq	*(%rax)
180002004:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180002009:     	jbe	0x18000206a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xbba>
18000200b:     	movq	0x2226(%rip), %rax      # 0x180004238
180002012:     	movq	(%rax), %rbx
180002015:     	movq	0x8c24(%rip), %rax      # 0x18000ac40
18000201c:     	callq	*(%rax)
18000201e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180002024:     	leaq	0x2645(%rip), %rdx      # 0x180004670
18000202b:     	movl	%eax, %r9d
18000202e:     	movq	%rbx, %rcx
180002031:     	callq	*0x2191(%rip)           # 0x1800041c8
180002037:     	callq	*0x222b(%rip)           # 0x180004268
18000203d:     	movq	0x20b4(%rip), %rcx      # 0x1800040f8
180002044:     	leaq	0x284d(%rip), %rdx      # 0x180004898
18000204b:     	movq	(%rcx), %rcx
18000204e:     	callq	*0x21dc(%rip)           # 0x180004230
180002054:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002059:     	addq	$0x68, %rsp
18000205d:     	popq	%r15
18000205f:     	popq	%r14
180002061:     	popq	%r13
180002063:     	popq	%r12
180002065:     	popq	%rdi
180002066:     	popq	%rsi
180002067:     	popq	%rbp
180002068:     	popq	%rbx
180002069:     	retq
18000206a:     	movq	0x8bcf(%rip), %rax      # 0x18000ac40
180002071:     	callq	*0x698(%rax)
180002077:     	movl	%eax, 0x8bcf(%rip)      # 0x18000ac4c
18000207d:     	cmpl	$0x10, %eax
180002080:     	jge	0x18000209e <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xbee>
180002082:     	movq	0x21af(%rip), %rcx      # 0x180004238
180002089:     	leaq	0x2630(%rip), %rdx      # 0x1800046c0
180002090:     	movl	%eax, %r9d
180002093:     	movl	$0x10, %r8d
180002099:     	movq	(%rcx), %rcx
18000209c:     	jmp	0x180002031 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb81>
18000209e:     	movq	0x8b9b(%rip), %rax      # 0x18000ac40
1800020a5:     	callq	*0x690(%rax)
1800020ab:     	testl	%eax, %eax
1800020ad:     	jne	0x1800020bb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xc0b>
1800020af:     	leaq	0x275a(%rip), %rdx      # 0x180004810
1800020b6:     	jmp	0x180001ff0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb40>
1800020bb:     	cmpl	$0x1, %eax
1800020be:     	je	0x1800020cc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xc1c>
1800020c0:     	leaq	0x2779(%rip), %rdx      # 0x180004840
1800020c7:     	jmp	0x180001ff0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xb40>
1800020cc:     	leaq	0x870d(%rip), %rcx      # 0x18000a7e0
1800020d3:     	callq	*0x208f(%rip)           # 0x180004168
1800020d9:     	testl	%eax, %eax
1800020db:     	jne	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
1800020e1:     	leaq	0x8218(%rip), %rcx      # 0x18000a300
1800020e8:     	callq	*0x207a(%rip)           # 0x180004168
1800020ee:     	testl	%eax, %eax
1800020f0:     	jne	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
1800020f6:     	leaq	0x8543(%rip), %rcx      # 0x18000a640
1800020fd:     	callq	*0x2065(%rip)           # 0x180004168
180002103:     	testl	%eax, %eax
180002105:     	jne	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
18000210b:     	xorl	%ebx, %ebx
18000210d:     	cmpl	%ebx, 0x8b35(%rip)      # 0x18000ac48
180002113:     	jne	0x180002156 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xca6>
180002115:     	movq	%gs:0x58, %rax
18000211e:     	movl	0x8b34(%rip), %ecx      # 0x18000ac58
180002124:     	movl	$0x1, 0x8b1a(%rip)      # 0x18000ac48
18000212e:     	movq	(%rax,%rcx,8), %rdx
180002132:     	movl	$0x10, %eax
180002137:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000213e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180002143:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000214a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000214f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180002156:     	movl	%ebx, 0x8a9c(%rip)      # 0x18000abf8
18000215c:     	movq	%rbx, %rax
18000215f:     	movb	%bl, 0x8a9b(%rip)       # 0x18000ac00
180002165:     	movq	%rbx, %rcx
180002168:     	xchgq	%rax, 0x8a99(%rip)      # 0x18000ac08
18000216f:     	xchgq	%rcx, 0x8a9a(%rip)      # 0x18000ac10
180002176:     	movq	%rbx, %rax
180002179:     	movq	%rbx, %rcx
18000217c:     	xchgq	%rax, 0x8a95(%rip)      # 0x18000ac18
180002183:     	xchgq	%rcx, 0x8a96(%rip)      # 0x18000ac20
18000218a:     	movq	0x1ecf(%rip), %rax      # 0x180004060
180002191:     	leaq	0x8308(%rip), %rcx      # 0x18000a4a0
180002198:     	movq	%rax, 0x8a89(%rip)      # 0x18000ac28
18000219f:     	movq	0x1eca(%rip), %rax      # 0x180004070
1800021a6:     	movq	%rax, 0x8a83(%rip)      # 0x18000ac30
1800021ad:     	movq	0x1eb4(%rip), %rax      # 0x180004068
1800021b4:     	movq	%rax, 0x8a7d(%rip)      # 0x18000ac38
1800021bb:     	movq	0x204e(%rip), %rax      # 0x180004210
1800021c2:     	movq	%rax, 0x840f(%rip)      # 0x18000a5d8
1800021c9:     	callq	*0x1f99(%rip)           # 0x180004168
1800021cf:     	testl	%eax, %eax
1800021d1:     	jne	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
1800021d7:     	leaq	0x274a(%rip), %rdx      # 0x180004928
1800021de:     	movq	%r14, %rcx
1800021e1:     	callq	*0x1f79(%rip)           # 0x180004160
1800021e7:     	movq	%rax, 0x28(%rsp)
1800021ec:     	movq	%rax, %rdi
1800021ef:     	testq	%rax, %rax
1800021f2:     	je	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
1800021f8:     	leaq	0x28c2(%rip), %rcx      # 0x180004ac1
1800021ff:     	callq	*0x1efb(%rip)           # 0x180004100
180002205:     	movq	%rax, 0x20(%rsp)
18000220a:     	movq	%rax, %r12
18000220d:     	testq	%rax, %rax
180002210:     	je	0x180002554 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x10a4>
180002216:     	movl	%ebx, %ebp
180002218:     	cmpq	%rbx, (%rsi)
18000221b:     	je	0x1800023c4 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xf14>
180002221:     	movslq	%ebp, %rbx
180002224:     	leaq	0x30(%rsp), %rdx
180002229:     	movq	%r14, %rcx
18000222c:     	leaq	(%rbx,%rbx,4), %rax
180002230:     	movups	(%r13,%rax,8), %xmm0
180002236:     	movups	0x10(%r13,%rax,8), %xmm1
18000223c:     	movaps	%xmm0, 0x30(%rsp)
180002241:     	movsd	0x20(%r13,%rax,8), %xmm0
180002248:     	movsd	%xmm0, 0x50(%rsp)
18000224e:     	movaps	%xmm1, 0x40(%rsp)
180002253:     	callq	0x180001d50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x8a0>
180002258:     	movq	%rax, %r14
18000225b:     	testq	%rax, %rax
18000225e:     	je	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
180002264:     	movq	(%rsi), %rcx
180002267:     	callq	*0x1e93(%rip)           # 0x180004100
18000226d:     	movq	%rax, %r13
180002270:     	testq	%rax, %rax
180002273:     	je	0x180002577 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x10c7>
180002279:     	movq	(%r15,%rbx,8), %rcx
18000227d:     	xorl	%edx, %edx
18000227f:     	movq	%r14, (%rcx)
180002282:     	leaq	0x8557(%rip), %rcx      # 0x18000a7e0
180002289:     	movq	0x8(%rsi), %r12
18000228d:     	callq	*0x1eb5(%rip)           # 0x180004148
180002293:     	movq	%rax, %rbx
180002296:     	testq	%rax, %rax
180002299:     	je	0x180002316 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe66>
18000229b:     	movq	%r13, %rcx
18000229e:     	callq	*0x1ed4(%rip)           # 0x180004178
1800022a4:     	movq	%rax, %rdi
1800022a7:     	testq	%rax, %rax
1800022aa:     	je	0x1800022cc <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe1c>
1800022ac:     	movq	%rax, %rcx
1800022af:     	callq	0x180003b05 <numba_list_iter_next+0xe85>
1800022b4:     	leaq	0x1(%rax), %rcx
1800022b8:     	callq	*0x1f5a(%rip)           # 0x180004218
1800022be:     	movq	%rax, %rsi
1800022c1:     	testq	%rax, %rax
1800022c4:     	jne	0x1800022d4 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe24>
1800022c6:     	callq	*0x1e6c(%rip)           # 0x180004138
1800022cc:     	xorl	%eax, %eax
1800022ce:     	movq	%rax, 0x20(%rbx)
1800022d2:     	jmp	0x180002305 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe55>
1800022d4:     	movq	%rdi, %rdx
1800022d7:     	movq	%rsi, %rcx
1800022da:     	callq	0x180003aff <numba_list_iter_next+0xe7f>
1800022df:     	movq	0x20(%rsp), %rcx
1800022e4:     	movq	%rsi, 0x20(%rbx)
1800022e8:     	movq	%r12, 0x28(%rbx)
1800022ec:     	movl	$0x3, 0x30(%rbx)
1800022f3:     	callq	0x1800017d0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x320>
1800022f8:     	movq	%rax, 0x38(%rbx)
1800022fc:     	testq	%rax, %rax
1800022ff:     	jne	0x180002470 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfc0>
180002305:     	movl	(%rbx), %eax
180002307:     	testl	%eax, %eax
180002309:     	js	0x180002316 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe66>
18000230b:     	subl	$0x1, %eax
18000230e:     	movl	%eax, (%rbx)
180002310:     	je	0x1800024bd <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x100d>
180002316:     	xorl	%edi, %edi
180002318:     	movl	(%r14), %eax
18000231b:     	testl	%eax, %eax
18000231d:     	js	0x180002330 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe80>
18000231f:     	subl	$0x1, %eax
180002322:     	movl	%eax, (%r14)
180002325:     	jne	0x180002330 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe80>
180002327:     	movq	%r14, %rcx
18000232a:     	callq	*0x1e80(%rip)           # 0x1800041b0
180002330:     	movl	(%r13), %eax
180002334:     	testl	%eax, %eax
180002336:     	js	0x18000234a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe9a>
180002338:     	subl	$0x1, %eax
18000233b:     	movl	%eax, (%r13)
18000233f:     	jne	0x18000234a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe9a>
180002341:     	movq	%r13, %rcx
180002344:     	callq	*0x1e66(%rip)           # 0x1800041b0
18000234a:     	testq	%rdi, %rdi
18000234d:     	je	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
180002353:     	movq	0xb8(%rsp), %rsi
18000235b:     	movq	%rdi, %r8
18000235e:     	movq	0xb0(%rsp), %r14
180002366:     	movq	%r14, %rcx
180002369:     	movq	(%rsi), %rdx
18000236c:     	callq	*0x1e86(%rip)           # 0x1800041f8
180002372:     	movl	(%rdi), %ecx
180002374:     	testl	%eax, %eax
180002376:     	jne	0x18000251a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x106a>
18000237c:     	testl	%ecx, %ecx
18000237e:     	js	0x180002392 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xee2>
180002380:     	leal	-0x1(%rcx), %eax
180002383:     	movl	%eax, (%rdi)
180002385:     	testl	%eax, %eax
180002387:     	jne	0x180002392 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xee2>
180002389:     	movq	%rdi, %rcx
18000238c:     	callq	*0x1e1e(%rip)           # 0x1800041b0
180002392:     	movq	0xc8(%rsp), %r15
18000239a:     	addq	$0x20, %rsi
18000239e:     	movq	0xc0(%rsp), %r13
1800023a6:     	incl	%ebp
1800023a8:     	movq	%rsi, 0xb8(%rsp)
1800023b0:     	cmpq	$0x0, (%rsi)
1800023b4:     	jne	0x180002221 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xd71>
1800023ba:     	movq	0x20(%rsp), %r12
1800023bf:     	movq	0x28(%rsp), %rdi
1800023c4:     	movslq	%ebp, %rax
1800023c7:     	cmpq	$0x0, (%r15,%rax,8)
1800023cc:     	je	0x180002439 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xf89>
1800023ce:     	nop
1800023d0:     	movslq	%ebp, %rbx
1800023d3:     	leaq	0x30(%rsp), %rdx
1800023d8:     	movq	%r14, %rcx
1800023db:     	leaq	(%rbx,%rbx,4), %rax
1800023df:     	movups	(%r13,%rax,8), %xmm0
1800023e5:     	movups	0x10(%r13,%rax,8), %xmm1
1800023eb:     	movaps	%xmm0, 0x30(%rsp)
1800023f0:     	movsd	0x20(%r13,%rax,8), %xmm0
1800023f7:     	movsd	%xmm0, 0x50(%rsp)
1800023fd:     	movaps	%xmm1, 0x40(%rsp)
180002402:     	callq	0x180001d50 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x8a0>
180002407:     	testq	%rax, %rax
18000240a:     	je	0x180002535 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1085>
180002410:     	movq	(%r15,%rbx,8), %rcx
180002414:     	movq	%rax, (%rcx)
180002417:     	movl	(%rax), %ecx
180002419:     	testl	%ecx, %ecx
18000241b:     	js	0x18000242d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xf7d>
18000241d:     	subl	$0x1, %ecx
180002420:     	movl	%ecx, (%rax)
180002422:     	jne	0x18000242d <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xf7d>
180002424:     	movq	%rax, %rcx
180002427:     	callq	*0x1d83(%rip)           # 0x1800041b0
18000242d:     	incl	%ebp
18000242f:     	movslq	%ebp, %rax
180002432:     	cmpq	$0x0, (%r15,%rax,8)
180002437:     	jne	0x1800023d0 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xf20>
180002439:     	movl	(%r12), %eax
18000243d:     	testl	%eax, %eax
18000243f:     	js	0x180002453 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfa3>
180002441:     	subl	$0x1, %eax
180002444:     	movl	%eax, (%r12)
180002448:     	jne	0x180002453 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfa3>
18000244a:     	movq	%r12, %rcx
18000244d:     	callq	*0x1d5d(%rip)           # 0x1800041b0
180002453:     	movl	(%rdi), %eax
180002455:     	testl	%eax, %eax
180002457:     	js	0x180002469 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfb9>
180002459:     	subl	$0x1, %eax
18000245c:     	movl	%eax, (%rdi)
18000245e:     	jne	0x180002469 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfb9>
180002460:     	movq	%rdi, %rcx
180002463:     	callq	*0x1d47(%rip)           # 0x1800041b0
180002469:     	xorl	%eax, %eax
18000246b:     	jmp	0x180002059 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba9>
180002470:     	movl	(%r14), %eax
180002473:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180002478:     	jae	0x18000247f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xfcf>
18000247a:     	incl	%eax
18000247c:     	movl	%eax, (%r14)
18000247f:     	movq	0xb0(%rsp), %rcx
180002487:     	leaq	0x249a(%rip), %rdx      # 0x180004928
18000248e:     	movq	%r14, 0x18(%rbx)
180002492:     	movq	$0x0, 0x40(%rbx)
18000249a:     	callq	*0x1cc0(%rip)           # 0x180004160
1800024a0:     	movq	%rax, %rsi
1800024a3:     	testq	%rax, %rax
1800024a6:     	jne	0x1800024cb <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x101b>
1800024a8:     	movl	(%rbx), %eax
1800024aa:     	testl	%eax, %eax
1800024ac:     	js	0x180002316 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe66>
1800024b2:     	subl	$0x1, %eax
1800024b5:     	movl	%eax, (%rbx)
1800024b7:     	jne	0x180002316 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe66>
1800024bd:     	movq	%rbx, %rcx
1800024c0:     	callq	*0x1cea(%rip)           # 0x1800041b0
1800024c6:     	jmp	0x180002316 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe66>
1800024cb:     	xorl	%r9d, %r9d
1800024ce:     	leaq	0x20(%rbx), %rcx
1800024d2:     	movq	%rsi, %r8
1800024d5:     	movq	%rbx, %rdx
1800024d8:     	callq	*0x1c62(%rip)           # 0x180004140
1800024de:     	movq	%rax, %rdi
1800024e1:     	movl	(%rbx), %eax
1800024e3:     	testl	%eax, %eax
1800024e5:     	js	0x1800024f7 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1047>
1800024e7:     	subl	$0x1, %eax
1800024ea:     	movl	%eax, (%rbx)
1800024ec:     	jne	0x1800024f7 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1047>
1800024ee:     	movq	%rbx, %rcx
1800024f1:     	callq	*0x1cb9(%rip)           # 0x1800041b0
1800024f7:     	movl	(%rsi), %eax
1800024f9:     	testl	%eax, %eax
1800024fb:     	js	0x180002318 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe68>
180002501:     	subl	$0x1, %eax
180002504:     	movl	%eax, (%rsi)
180002506:     	jne	0x180002318 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe68>
18000250c:     	movq	%rsi, %rcx
18000250f:     	callq	*0x1c9b(%rip)           # 0x1800041b0
180002515:     	jmp	0x180002318 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xe68>
18000251a:     	testl	%ecx, %ecx
18000251c:     	js	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
18000251e:     	leal	-0x1(%rcx), %eax
180002521:     	movl	%eax, (%rdi)
180002523:     	testl	%eax, %eax
180002525:     	jne	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
180002527:     	movq	%rdi, %rcx
18000252a:     	callq	*0x1c80(%rip)           # 0x1800041b0
180002530:     	movq	0x20(%rsp), %r12
180002535:     	movl	(%r12), %eax
180002539:     	testl	%eax, %eax
18000253b:     	js	0x18000254f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x109f>
18000253d:     	subl	$0x1, %eax
180002540:     	movl	%eax, (%r12)
180002544:     	jne	0x18000254f <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x109f>
180002546:     	movq	%r12, %rcx
180002549:     	callq	*0x1c61(%rip)           # 0x1800041b0
18000254f:     	movq	0x28(%rsp), %rdi
180002554:     	movl	(%rdi), %eax
180002556:     	testl	%eax, %eax
180002558:     	js	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
18000255e:     	subl	$0x1, %eax
180002561:     	movl	%eax, (%rdi)
180002563:     	jne	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
180002569:     	movq	%rdi, %rcx
18000256c:     	callq	*0x1c3e(%rip)           # 0x1800041b0
180002572:     	jmp	0x180002054 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0xba4>
180002577:     	movl	(%r14), %eax
18000257a:     	testl	%eax, %eax
18000257c:     	js	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
18000257e:     	subl	$0x1, %eax
180002581:     	movl	%eax, (%r14)
180002584:     	jne	0x180002530 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x1080>
180002586:     	movq	%r14, %rcx
180002589:     	jmp	0x18000252a <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x107a>
18000258b:     	int3
18000258c:     	int3
18000258d:     	int3
18000258e:     	int3
18000258f:     	int3
180002590:     	leaq	0x86d9(%rip), %rax      # 0x18000ac70
180002597:     	retq
180002598:     	int3
180002599:     	int3
18000259a:     	int3
18000259b:     	int3
18000259c:     	int3
18000259d:     	int3
18000259e:     	int3
18000259f:     	int3

00000001800025a0 <numba_list_set_method_table>:
1800025a0:     	movups	(%rdx), %xmm0
1800025a3:     	movups	%xmm0, 0x20(%rcx)
1800025a7:     	retq
1800025a8:     	int3
1800025a9:     	int3
1800025aa:     	int3
1800025ab:     	int3
1800025ac:     	int3
1800025ad:     	int3
1800025ae:     	int3
1800025af:     	int3

00000001800025b0 <numba_list_new>:
1800025b0:     	pushq	%rbx
1800025b2:     	pushq	%rbp
1800025b3:     	pushq	%rsi
1800025b4:     	pushq	%rdi
1800025b5:     	subq	$0x28, %rsp
1800025b9:     	movq	%rcx, %rsi
1800025bc:     	movq	%r8, %rdi
1800025bf:     	movl	$0x38, %ecx
1800025c4:     	movq	%rdx, %rbp
1800025c7:     	callq	*0x1a93(%rip)           # 0x180004060
1800025cd:     	movq	%rax, %rbx
1800025d0:     	testq	%rax, %rax
1800025d3:     	je	0x18000263d <numba_list_new+0x8d>
1800025d5:     	movq	$0x0, (%rax)
1800025dc:     	xorps	%xmm0, %xmm0
1800025df:     	movq	%rbp, 0x8(%rax)
1800025e3:     	movq	%rdi, 0x10(%rax)
1800025e7:     	movl	$0x1, 0x18(%rax)
1800025ee:     	movups	%xmm0, 0x20(%rax)
1800025f2:     	testq	%rdi, %rdi
1800025f5:     	je	0x18000264b <numba_list_new+0x9b>
1800025f7:     	imulq	%rbp, %rdi
1800025fb:     	movl	$0x8, %ecx
180002600:     	movq	%rdi, %rax
180002603:     	cqto
180002605:     	andl	$0x7, %edx
180002608:     	addq	%rdx, %rax
18000260b:     	andl	$0x7, %eax
18000260e:     	subq	%rdx, %rax
180002611:     	subq	%rax, %rcx
180002614:     	movq	%rcx, %rax
180002617:     	cqto
180002619:     	andl	$0x7, %edx
18000261c:     	leaq	(%rdx,%rax), %rcx
180002620:     	andl	$0x7, %ecx
180002623:     	subq	%rdx, %rcx
180002626:     	addq	%rdi, %rcx
180002629:     	callq	*0x1a31(%rip)           # 0x180004060
18000262f:     	testq	%rax, %rax
180002632:     	jne	0x18000264d <numba_list_new+0x9d>
180002634:     	movq	%rbx, %rcx
180002637:     	callq	*0x1a2b(%rip)           # 0x180004068
18000263d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002642:     	addq	$0x28, %rsp
180002646:     	popq	%rdi
180002647:     	popq	%rsi
180002648:     	popq	%rbp
180002649:     	popq	%rbx
18000264a:     	retq
18000264b:     	xorl	%eax, %eax
18000264d:     	movq	%rax, 0x30(%rbx)
180002651:     	xorl	%eax, %eax
180002653:     	movq	%rbx, (%rsi)
180002656:     	addq	$0x28, %rsp
18000265a:     	popq	%rdi
18000265b:     	popq	%rsi
18000265c:     	popq	%rbp
18000265d:     	popq	%rbx
18000265e:     	retq
18000265f:     	int3

0000000180002660 <numba_list_free>:
180002660:     	pushq	%rbx
180002662:     	subq	$0x20, %rsp
180002666:     	cmpq	$0x0, 0x28(%rcx)
18000266b:     	movq	%rcx, %rbx
18000266e:     	je	0x1800026a4 <numba_list_free+0x44>
180002670:     	movq	%rdi, 0x30(%rsp)
180002675:     	xorl	%edi, %edi
180002677:     	cmpq	%rdi, (%rcx)
18000267a:     	jle	0x18000269f <numba_list_free+0x3f>
18000267c:     	nopl	(%rax)
180002680:     	movq	0x28(%rbx), %rax
180002684:     	testq	%rax, %rax
180002687:     	je	0x180002697 <numba_list_free+0x37>
180002689:     	movq	%rdi, %rcx
18000268c:     	imulq	0x8(%rbx), %rcx
180002691:     	addq	0x30(%rbx), %rcx
180002695:     	callq	*%rax
180002697:     	incq	%rdi
18000269a:     	cmpq	(%rbx), %rdi
18000269d:     	jl	0x180002680 <numba_list_free+0x20>
18000269f:     	movq	0x30(%rsp), %rdi
1800026a4:     	movq	0x30(%rbx), %rcx
1800026a8:     	testq	%rcx, %rcx
1800026ab:     	je	0x1800026b3 <numba_list_free+0x53>
1800026ad:     	callq	*0x19b5(%rip)           # 0x180004068
1800026b3:     	movq	%rbx, %rcx
1800026b6:     	addq	$0x20, %rsp
1800026ba:     	popq	%rbx
1800026bb:     	jmpq	*0x19a6(%rip)           # 0x180004068
1800026c2:     	int3
1800026c3:     	int3
1800026c4:     	int3
1800026c5:     	int3
1800026c6:     	int3
1800026c7:     	int3
1800026c8:     	int3
1800026c9:     	int3
1800026ca:     	int3
1800026cb:     	int3
1800026cc:     	int3
1800026cd:     	int3
1800026ce:     	int3
1800026cf:     	int3

00000001800026d0 <numba_list_base_ptr>:
1800026d0:     	movq	0x30(%rcx), %rax
1800026d4:     	retq
1800026d5:     	int3
1800026d6:     	int3
1800026d7:     	int3
1800026d8:     	int3
1800026d9:     	int3
1800026da:     	int3
1800026db:     	int3
1800026dc:     	int3
1800026dd:     	int3
1800026de:     	int3
1800026df:     	int3

00000001800026e0 <numba_list_size_address>:
1800026e0:     	movq	%rcx, %rax
1800026e3:     	retq
1800026e4:     	int3
1800026e5:     	int3
1800026e6:     	int3
1800026e7:     	int3
1800026e8:     	int3
1800026e9:     	int3
1800026ea:     	int3
1800026eb:     	int3
1800026ec:     	int3
1800026ed:     	int3
1800026ee:     	int3
1800026ef:     	int3

00000001800026f0 <numba_list_length>:
1800026f0:     	movq	(%rcx), %rax
1800026f3:     	retq
1800026f4:     	int3
1800026f5:     	int3
1800026f6:     	int3
1800026f7:     	int3
1800026f8:     	int3
1800026f9:     	int3
1800026fa:     	int3
1800026fb:     	int3
1800026fc:     	int3
1800026fd:     	int3
1800026fe:     	int3
1800026ff:     	int3

0000000180002700 <numba_list_allocated>:
180002700:     	movq	0x10(%rcx), %rax
180002704:     	retq
180002705:     	int3
180002706:     	int3
180002707:     	int3
180002708:     	int3
180002709:     	int3
18000270a:     	int3
18000270b:     	int3
18000270c:     	int3
18000270d:     	int3
18000270e:     	int3
18000270f:     	int3

0000000180002710 <numba_list_is_mutable>:
180002710:     	movl	0x18(%rcx), %eax
180002713:     	retq
180002714:     	int3
180002715:     	int3
180002716:     	int3
180002717:     	int3
180002718:     	int3
180002719:     	int3
18000271a:     	int3
18000271b:     	int3
18000271c:     	int3
18000271d:     	int3
18000271e:     	int3
18000271f:     	int3

0000000180002720 <numba_list_set_is_mutable>:
180002720:     	movl	%edx, 0x18(%rcx)
180002723:     	retq
180002724:     	int3
180002725:     	int3
180002726:     	int3
180002727:     	int3
180002728:     	int3
180002729:     	int3
18000272a:     	int3
18000272b:     	int3
18000272c:     	int3
18000272d:     	int3
18000272e:     	int3
18000272f:     	int3

0000000180002730 <numba_list_setitem>:
180002730:     	movq	%rbx, 0x10(%rsp)
180002735:     	pushq	%rsi
180002736:     	subq	$0x20, %rsp
18000273a:     	cmpl	$0x0, 0x18(%rcx)
18000273e:     	movq	%r8, %rsi
180002741:     	movq	%rcx, %rbx
180002744:     	jne	0x180002756 <numba_list_setitem+0x26>
180002746:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000274b:     	movq	0x38(%rsp), %rbx
180002750:     	addq	$0x20, %rsp
180002754:     	popq	%rsi
180002755:     	retq
180002756:     	cmpq	(%rcx), %rdx
180002759:     	jb	0x18000276b <numba_list_setitem+0x3b>
18000275b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180002760:     	movq	0x38(%rsp), %rbx
180002765:     	addq	$0x20, %rsp
180002769:     	popq	%rsi
18000276a:     	retq
18000276b:     	imulq	0x8(%rcx), %rdx
180002770:     	movq	0x28(%rcx), %rax
180002774:     	movq	%rdi, 0x30(%rsp)
180002779:     	movq	0x30(%rcx), %rdi
18000277d:     	addq	%rdx, %rdi
180002780:     	testq	%rax, %rax
180002783:     	je	0x18000278a <numba_list_setitem+0x5a>
180002785:     	movq	%rdi, %rcx
180002788:     	callq	*%rax
18000278a:     	movq	0x8(%rbx), %r8
18000278e:     	movq	%rsi, %rdx
180002791:     	movq	%rdi, %rcx
180002794:     	callq	0x180003af3 <numba_list_iter_next+0xe73>
180002799:     	movq	0x20(%rbx), %rax
18000279d:     	testq	%rax, %rax
1800027a0:     	je	0x1800027a7 <numba_list_setitem+0x77>
1800027a2:     	movq	%rdi, %rcx
1800027a5:     	callq	*%rax
1800027a7:     	movq	0x30(%rsp), %rdi
1800027ac:     	xorl	%eax, %eax
1800027ae:     	movq	0x38(%rsp), %rbx
1800027b3:     	addq	$0x20, %rsp
1800027b7:     	popq	%rsi
1800027b8:     	retq
1800027b9:     	int3
1800027ba:     	int3
1800027bb:     	int3
1800027bc:     	int3
1800027bd:     	int3
1800027be:     	int3
1800027bf:     	int3

00000001800027c0 <numba_list_getitem>:
1800027c0:     	subq	$0x28, %rsp
1800027c4:     	movq	%r8, %r9
1800027c7:     	movq	%rdx, %rax
1800027ca:     	cmpq	(%rcx), %rdx
1800027cd:     	jb	0x1800027d9 <numba_list_getitem+0x19>
1800027cf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800027d4:     	addq	$0x28, %rsp
1800027d8:     	retq
1800027d9:     	movq	0x8(%rcx), %r8
1800027dd:     	movq	%r8, %rdx
1800027e0:     	imulq	%rax, %rdx
1800027e4:     	addq	0x30(%rcx), %rdx
1800027e8:     	movq	%r9, %rcx
1800027eb:     	callq	0x180003af3 <numba_list_iter_next+0xe73>
1800027f0:     	xorl	%eax, %eax
1800027f2:     	addq	$0x28, %rsp
1800027f6:     	retq
1800027f7:     	int3
1800027f8:     	int3
1800027f9:     	int3
1800027fa:     	int3
1800027fb:     	int3
1800027fc:     	int3
1800027fd:     	int3
1800027fe:     	int3
1800027ff:     	int3

0000000180002800 <numba_list_append>:
180002800:     	movq	%rbx, 0x10(%rsp)
180002805:     	pushq	%rsi
180002806:     	subq	$0x20, %rsp
18000280a:     	cmpl	$0x0, 0x18(%rcx)
18000280e:     	movq	%rdx, %rsi
180002811:     	movq	%rcx, %rbx
180002814:     	jne	0x180002826 <numba_list_append+0x26>
180002816:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000281b:     	movq	0x38(%rsp), %rbx
180002820:     	addq	$0x20, %rsp
180002824:     	popq	%rsi
180002825:     	retq
180002826:     	movq	(%rcx), %rdx
180002829:     	incq	%rdx
18000282c:     	callq	0x180002880 <numba_list_resize>
180002831:     	testl	%eax, %eax
180002833:     	js	0x18000286c <numba_list_append+0x6c>
180002835:     	movq	0x8(%rbx), %r8
180002839:     	movq	%rsi, %rdx
18000283c:     	movq	%rdi, 0x30(%rsp)
180002841:     	movq	(%rbx), %rdi
180002844:     	decq	%rdi
180002847:     	imulq	%r8, %rdi
18000284b:     	addq	0x30(%rbx), %rdi
18000284f:     	movq	%rdi, %rcx
180002852:     	callq	0x180003af3 <numba_list_iter_next+0xe73>
180002857:     	movq	0x20(%rbx), %rax
18000285b:     	testq	%rax, %rax
18000285e:     	je	0x180002865 <numba_list_append+0x65>
180002860:     	movq	%rdi, %rcx
180002863:     	callq	*%rax
180002865:     	movq	0x30(%rsp), %rdi
18000286a:     	xorl	%eax, %eax
18000286c:     	movq	0x38(%rsp), %rbx
180002871:     	addq	$0x20, %rsp
180002875:     	popq	%rsi
180002876:     	retq
180002877:     	int3
180002878:     	int3
180002879:     	int3
18000287a:     	int3
18000287b:     	int3
18000287c:     	int3
18000287d:     	int3
18000287e:     	int3
18000287f:     	int3

0000000180002880 <numba_list_resize>:
180002880:     	movq	%rsi, 0x18(%rsp)
180002885:     	pushq	%rdi
180002886:     	subq	$0x20, %rsp
18000288a:     	cmpl	$0x0, 0x18(%rcx)
18000288e:     	movq	%rdx, %rsi
180002891:     	movq	%rcx, %rdi
180002894:     	jne	0x1800028a6 <numba_list_resize+0x26>
180002896:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000289b:     	movq	0x40(%rsp), %rsi
1800028a0:     	addq	$0x20, %rsp
1800028a4:     	popq	%rdi
1800028a5:     	retq
1800028a6:     	movq	0x10(%rcx), %rax
1800028aa:     	cmpq	%rsi, %rax
1800028ad:     	jl	0x1800028c7 <numba_list_resize+0x47>
1800028af:     	sarq	%rax
1800028b2:     	cmpq	%rax, %rsi
1800028b5:     	jl	0x1800028c7 <numba_list_resize+0x47>
1800028b7:     	movq	%rsi, (%rcx)
1800028ba:     	xorl	%eax, %eax
1800028bc:     	movq	0x40(%rsp), %rsi
1800028c1:     	addq	$0x20, %rsp
1800028c5:     	popq	%rdi
1800028c6:     	retq
1800028c7:     	cmpq	$0x9, %rsi
1800028cb:     	movq	%rbp, 0x38(%rsp)
1800028d0:     	movl	$0x3, %ecx
1800028d5:     	movl	$0x6, %eax
1800028da:     	cmovll	%ecx, %eax
1800028dd:     	movq	%rsi, %r8
1800028e0:     	movq	0x8(%rdi), %rcx
1800028e4:     	addq	%rsi, %rax
1800028e7:     	sarq	$0x3, %r8
1800028eb:     	xorl	%edx, %edx
1800028ed:     	addq	%rax, %r8
1800028f0:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
1800028fa:     	divq	%rcx
1800028fd:     	cmpq	%rax, %r8
180002900:     	ja	0x18000297b <numba_list_resize+0xfb>
180002902:     	xorl	%ebp, %ebp
180002904:     	movq	%rbx, 0x30(%rsp)
180002909:     	testq	%rsi, %rsi
18000290c:     	cmovneq	%r8, %rbp
180002910:     	movq	%rbp, %rbx
180002913:     	imulq	%rcx, %rbx
180002917:     	movl	$0x8, %ecx
18000291c:     	movq	%rbx, %rax
18000291f:     	cqto
180002921:     	andl	$0x7, %edx
180002924:     	addq	%rdx, %rax
180002927:     	andl	$0x7, %eax
18000292a:     	subq	%rdx, %rax
18000292d:     	subq	%rax, %rcx
180002930:     	movq	%rcx, %rax
180002933:     	movq	0x30(%rdi), %rcx
180002937:     	cqto
180002939:     	andl	$0x7, %edx
18000293c:     	addq	%rdx, %rax
18000293f:     	andl	$0x7, %eax
180002942:     	subq	%rdx, %rax
180002945:     	leaq	(%rbx,%rax), %rdx
180002949:     	callq	*0x1721(%rip)           # 0x180004070
18000294f:     	testq	%rbx, %rbx
180002952:     	movq	0x30(%rsp), %rbx
180002957:     	je	0x18000295e <numba_list_resize+0xde>
180002959:     	testq	%rax, %rax
18000295c:     	je	0x18000297b <numba_list_resize+0xfb>
18000295e:     	movq	%rax, 0x30(%rdi)
180002962:     	xorl	%eax, %eax
180002964:     	movq	%rbp, 0x10(%rdi)
180002968:     	movq	0x38(%rsp), %rbp
18000296d:     	movq	%rsi, (%rdi)
180002970:     	movq	0x40(%rsp), %rsi
180002975:     	addq	$0x20, %rsp
180002979:     	popq	%rdi
18000297a:     	retq
18000297b:     	movq	0x38(%rsp), %rbp
180002980:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180002985:     	movq	0x40(%rsp), %rsi
18000298a:     	addq	$0x20, %rsp
18000298e:     	popq	%rdi
18000298f:     	retq

0000000180002990 <numba_list_delitem>:
180002990:     	movq	%rbx, 0x10(%rsp)
180002995:     	pushq	%rdi
180002996:     	subq	$0x20, %rsp
18000299a:     	cmpl	$0x0, 0x18(%rcx)
18000299e:     	movq	%rdx, %rdi
1800029a1:     	movq	%rcx, %rbx
1800029a4:     	jne	0x1800029b6 <numba_list_delitem+0x26>
1800029a6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800029ab:     	movq	0x38(%rsp), %rbx
1800029b0:     	addq	$0x20, %rsp
1800029b4:     	popq	%rdi
1800029b5:     	retq
1800029b6:     	cmpq	(%rcx), %rdi
1800029b9:     	jb	0x1800029cb <numba_list_delitem+0x3b>
1800029bb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800029c0:     	movq	0x38(%rsp), %rbx
1800029c5:     	addq	$0x20, %rsp
1800029c9:     	popq	%rdi
1800029ca:     	retq
1800029cb:     	movq	0x28(%rcx), %rax
1800029cf:     	movq	%rsi, 0x30(%rsp)
1800029d4:     	movq	%rdi, %rsi
1800029d7:     	imulq	0x8(%rcx), %rsi
1800029dc:     	addq	0x30(%rcx), %rsi
1800029e0:     	testq	%rax, %rax
1800029e3:     	je	0x1800029ea <numba_list_delitem+0x5a>
1800029e5:     	movq	%rsi, %rcx
1800029e8:     	callq	*%rax
1800029ea:     	movq	(%rbx), %r8
1800029ed:     	leaq	-0x1(%r8), %rax
1800029f1:     	cmpq	%rax, %rdi
1800029f4:     	je	0x180002a16 <numba_list_delitem+0x86>
1800029f6:     	subq	%rdi, %r8
1800029f9:     	leaq	0x1(%rdi), %rdx
1800029fd:     	imulq	0x8(%rbx), %rdx
180002a02:     	decq	%r8
180002a05:     	movq	%rsi, %rcx
180002a08:     	imulq	0x8(%rbx), %r8
180002a0d:     	addq	0x30(%rbx), %rdx
180002a11:     	callq	0x180003af9 <numba_list_iter_next+0xe79>
180002a16:     	movq	(%rbx), %rdx
180002a19:     	movq	%rbx, %rcx
180002a1c:     	decq	%rdx
180002a1f:     	callq	0x180002880 <numba_list_resize>
180002a24:     	movq	0x30(%rsp), %rsi
180002a29:     	xorl	%ecx, %ecx
180002a2b:     	movq	0x38(%rsp), %rbx
180002a30:     	testl	%eax, %eax
180002a32:     	cmovsl	%eax, %ecx
180002a35:     	movl	%ecx, %eax
180002a37:     	addq	$0x20, %rsp
180002a3b:     	popq	%rdi
180002a3c:     	retq
180002a3d:     	int3
180002a3e:     	int3
180002a3f:     	int3

0000000180002a40 <numba_list_delete_slice>:
180002a40:     	pushq	%rbx
180002a42:     	pushq	%rbp
180002a43:     	pushq	%rdi
180002a44:     	pushq	%r15
180002a46:     	subq	$0x38, %rsp
180002a4a:     	cmpl	$0x0, 0x18(%rcx)
180002a4e:     	movq	%r9, %rdi
180002a51:     	movq	%r8, %rbp
180002a54:     	movq	%rdx, %r15
180002a57:     	movq	%rcx, %rbx
180002a5a:     	jne	0x180002a6b <numba_list_delete_slice+0x2b>
180002a5c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180002a61:     	addq	$0x38, %rsp
180002a65:     	popq	%r15
180002a67:     	popq	%rdi
180002a68:     	popq	%rbp
180002a69:     	popq	%rbx
180002a6a:     	retq
180002a6b:     	movq	%r13, 0x78(%rsp)
180002a70:     	testq	%rdi, %rdi
180002a73:     	jle	0x180002a92 <numba_list_delete_slice+0x52>
180002a75:     	cmpq	%r8, %r15
180002a78:     	jge	0x180002c31 <numba_list_delete_slice+0x1f1>
180002a7e:     	movq	%r8, %rax
180002a81:     	subq	%r15, %rax
180002a84:     	decq	%rax
180002a87:     	cqto
180002a89:     	idivq	%rdi
180002a8c:     	leal	0x1(%rax), %r13d
180002a90:     	jmp	0x180002ab2 <numba_list_delete_slice+0x72>
180002a92:     	cmpq	%r15, %r8
180002a95:     	jge	0x180002c31 <numba_list_delete_slice+0x1f1>
180002a9b:     	movq	%r15, %rax
180002a9e:     	movl	$0x1, %r13d
180002aa4:     	subq	%r8, %rax
180002aa7:     	decq	%rax
180002aaa:     	cqto
180002aac:     	idivq	%rdi
180002aaf:     	subl	%eax, %r13d
180002ab2:     	testl	%r13d, %r13d
180002ab5:     	jle	0x180002c31 <numba_list_delete_slice+0x1f1>
180002abb:     	movq	%rsi, 0x68(%rsp)
180002ac0:     	movl	(%rcx), %esi
180002ac2:     	subl	%r13d, %esi
180002ac5:     	movl	%esi, 0x20(%rsp)
180002ac9:     	testq	%rdi, %rdi
180002acc:     	jns	0x180002ae7 <numba_list_delete_slice+0xa7>
180002ace:     	leaq	0x1(%r15), %rbp
180002ad2:     	leal	-0x1(%r13), %eax
180002ad6:     	movslq	%eax, %rcx
180002ad9:     	leaq	-0x1(%rbp), %r15
180002add:     	imulq	%rdi, %rcx
180002ae1:     	addq	%rcx, %r15
180002ae4:     	negq	%rdi
180002ae7:     	cmpq	$0x1, %rdi
180002aeb:     	jne	0x180002b37 <numba_list_delete_slice+0xf7>
180002aed:     	cmpq	$0x0, 0x28(%rbx)
180002af2:     	je	0x180002b19 <numba_list_delete_slice+0xd9>
180002af4:     	movslq	%r15d, %rdi
180002af7:     	cmpq	%rbp, %rdi
180002afa:     	jge	0x180002b19 <numba_list_delete_slice+0xd9>
180002afc:     	nopl	(%rax)
180002b00:     	movslq	%edi, %rcx
180002b03:     	imulq	0x8(%rbx), %rcx
180002b08:     	addq	0x30(%rbx), %rcx
180002b0c:     	callq	*0x28(%rbx)
180002b0f:     	incl	%edi
180002b11:     	movslq	%edi, %rax
180002b14:     	cmpq	%rbp, %rax
180002b17:     	jl	0x180002b00 <numba_list_delete_slice+0xc0>
180002b19:     	movq	0x8(%rbx), %rcx
180002b1d:     	movq	(%rbx), %r8
180002b20:     	movq	%rcx, %rdx
180002b23:     	subq	%rbp, %r8
180002b26:     	imulq	%rcx, %r8
180002b2a:     	imulq	%rbp, %rdx
180002b2e:     	imulq	%r15, %rcx
180002b32:     	jmp	0x180002bfc <numba_list_delete_slice+0x1bc>
180002b37:     	movq	%r14, 0x30(%rsp)
180002b3c:     	movq	%r15, %r14
180002b3f:     	movl	$0x0, 0x60(%rsp)
180002b47:     	cmpq	%rbp, %r15
180002b4a:     	jge	0x180002bc9 <numba_list_delete_slice+0x189>
180002b4c:     	movq	%r12, 0x70(%rsp)
180002b51:     	movq	(%rbx), %rax
180002b54:     	leaq	(%r14,%rdi), %r12
180002b58:     	cmpq	%rax, %r12
180002b5b:     	jl	0x180002b68 <numba_list_delete_slice+0x128>
180002b5d:     	movq	%r14, %rsi
180002b60:     	notq	%rsi
180002b63:     	addq	%rax, %rsi
180002b66:     	jmp	0x180002b6c <numba_list_delete_slice+0x12c>
180002b68:     	leaq	-0x1(%rdi), %rsi
180002b6c:     	movq	0x28(%rbx), %rax
180002b70:     	testq	%rax, %rax
180002b73:     	je	0x180002b83 <numba_list_delete_slice+0x143>
180002b75:     	movq	%r14, %rcx
180002b78:     	imulq	0x8(%rbx), %rcx
180002b7d:     	addq	0x30(%rbx), %rcx
180002b81:     	callq	*%rax
180002b83:     	movq	0x8(%rbx), %r9
180002b87:     	leaq	0x1(%r14), %rdx
180002b8b:     	movq	0x30(%rbx), %r10
180002b8f:     	movq	%r9, %r8
180002b92:     	imulq	%rsi, %r8
180002b96:     	imulq	%r9, %rdx
180002b9a:     	movslq	0x60(%rsp), %rsi
180002b9f:     	subq	%rsi, %r14
180002ba2:     	imulq	%r9, %r14
180002ba6:     	addq	%r10, %rdx
180002ba9:     	leaq	(%r10,%r14), %rcx
180002bad:     	callq	0x180003af9 <numba_list_iter_next+0xe79>
180002bb2:     	incl	%esi
180002bb4:     	movq	%r12, %r14
180002bb7:     	movl	%esi, 0x60(%rsp)
180002bbb:     	cmpq	%rbp, %r12
180002bbe:     	jl	0x180002b51 <numba_list_delete_slice+0x111>
180002bc0:     	movq	0x70(%rsp), %r12
180002bc5:     	movl	0x20(%rsp), %esi
180002bc9:     	movq	(%rbx), %r8
180002bcc:     	movq	0x30(%rsp), %r14
180002bd1:     	movslq	%r13d, %r10
180002bd4:     	movq	%r10, %rcx
180002bd7:     	imulq	%rdi, %rcx
180002bdb:     	addq	%r15, %rcx
180002bde:     	cmpq	%r8, %rcx
180002be1:     	jge	0x180002c09 <numba_list_delete_slice+0x1c9>
180002be3:     	movq	0x8(%rbx), %rax
180002be7:     	subq	%rcx, %r8
180002bea:     	movq	%rax, %rdx
180002bed:     	imulq	%rcx, %rdx
180002bf1:     	imulq	%rax, %r8
180002bf5:     	subq	%r10, %rcx
180002bf8:     	imulq	%rax, %rcx
180002bfc:     	addq	0x30(%rbx), %rdx
180002c00:     	addq	0x30(%rbx), %rcx
180002c04:     	callq	0x180003af9 <numba_list_iter_next+0xe79>
180002c09:     	movslq	%esi, %rdx
180002c0c:     	movq	%rbx, %rcx
180002c0f:     	callq	0x180002880 <numba_list_resize>
180002c14:     	movq	0x68(%rsp), %rsi
180002c19:     	xorl	%ecx, %ecx
180002c1b:     	movq	0x78(%rsp), %r13
180002c20:     	testl	%eax, %eax
180002c22:     	cmovsl	%eax, %ecx
180002c25:     	movl	%ecx, %eax
180002c27:     	addq	$0x38, %rsp
180002c2b:     	popq	%r15
180002c2d:     	popq	%rdi
180002c2e:     	popq	%rbp
180002c2f:     	popq	%rbx
180002c30:     	retq
180002c31:     	movq	0x78(%rsp), %r13
180002c36:     	xorl	%eax, %eax
180002c38:     	addq	$0x38, %rsp
180002c3c:     	popq	%r15
180002c3e:     	popq	%rdi
180002c3f:     	popq	%rbp
180002c40:     	popq	%rbx
180002c41:     	retq
180002c42:     	int3
180002c43:     	int3
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

0000000180002c50 <numba_list_iter_sizeof>:
180002c50:     	movl	$0x18, %eax
180002c55:     	retq
180002c56:     	int3
180002c57:     	int3
180002c58:     	int3
180002c59:     	int3
180002c5a:     	int3
180002c5b:     	int3
180002c5c:     	int3
180002c5d:     	int3
180002c5e:     	int3
180002c5f:     	int3

0000000180002c60 <numba_list_iter>:
180002c60:     	movq	%rdx, (%rcx)
180002c63:     	movq	(%rdx), %rax
180002c66:     	movq	%rax, 0x8(%rcx)
180002c6a:     	movq	$0x0, 0x10(%rcx)
180002c72:     	retq
180002c73:     	int3
180002c74:     	int3
180002c75:     	int3
180002c76:     	int3
180002c77:     	int3
180002c78:     	int3
180002c79:     	int3
180002c7a:     	int3
180002c7b:     	int3
180002c7c:     	int3
180002c7d:     	int3
180002c7e:     	int3
180002c7f:     	int3

0000000180002c80 <numba_list_iter_next>:
180002c80:     	movq	(%rcx), %r8
180002c83:     	movq	(%r8), %r9
180002c86:     	cmpq	0x8(%rcx), %r9
180002c8a:     	je	0x180002c92 <numba_list_iter_next+0x12>
180002c8c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180002c91:     	retq
180002c92:     	movq	0x10(%rcx), %rax
180002c96:     	cmpq	%r9, %rax
180002c99:     	jge	0x180002cae <numba_list_iter_next+0x2e>
180002c9b:     	imulq	0x8(%r8), %rax
180002ca0:     	addq	0x30(%r8), %rax
180002ca4:     	movq	%rax, (%rdx)
180002ca7:     	incq	0x10(%rcx)
180002cab:     	xorl	%eax, %eax
180002cad:     	retq
180002cae:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180002cb3:     	retq
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
180002cc0:     	pushq	%rbx
180002cc2:     	subq	$0x20, %rsp
180002cc6:     	movq	%rcx, %rbx
180002cc9:     	addq	$0x30, %rcx
180002ccd:     	callq	*0x7f55(%rip)           # 0x18000ac28
180002cd3:     	cmpb	$0x0, 0x7f26(%rip)      # 0x18000ac00
180002cda:     	je	0x180002ce4 <numba_list_iter_next+0x64>
180002cdc:     	lock
180002cdd:     	incq	0x7f24(%rip)            # 0x18000ac08
180002ce4:     	testq	%rax, %rax
180002ce7:     	je	0x180002d28 <numba_list_iter_next+0xa8>
180002ce9:     	leaq	0x30(%rax), %rdx
180002ced:     	testq	%rdx, %rdx
180002cf0:     	je	0x180002d28 <numba_list_iter_next+0xa8>
180002cf2:     	xorl	%r8d, %r8d
180002cf5:     	movl	$0x1, %ecx
180002cfa:     	xchgq	%rcx, (%rax)
180002cfd:     	movq	%r8, 0x8(%rax)
180002d01:     	movq	%r8, 0x10(%rax)
180002d05:     	movq	%rdx, 0x18(%rax)
180002d09:     	movq	%rbx, 0x20(%rax)
180002d0d:     	movq	%r8, 0x28(%rax)
180002d11:     	cmpb	%r8b, 0x7ee8(%rip)      # 0x18000ac00
180002d18:     	je	0x180002d2a <numba_list_iter_next+0xaa>
180002d1a:     	lock
180002d1b:     	incq	0x7ef6(%rip)            # 0x18000ac18
180002d22:     	addq	$0x20, %rsp
180002d26:     	popq	%rbx
180002d27:     	retq
180002d28:     	xorl	%eax, %eax
180002d2a:     	addq	$0x20, %rsp
180002d2e:     	popq	%rbx
180002d2f:     	retq
180002d30:     	movq	%rbx, 0x8(%rsp)
180002d35:     	pushq	%rdi
180002d36:     	subq	$0x20, %rsp
180002d3a:     	movq	%rcx, %rdi
180002d3d:     	movq	%rdx, %rbx
180002d40:     	addq	$0x30, %rcx
180002d44:     	testq	%rdx, %rdx
180002d47:     	je	0x180002d51 <numba_list_iter_next+0xd1>
180002d49:     	movq	0x18(%rdx), %rdx
180002d4d:     	callq	*(%rbx)
180002d4f:     	jmp	0x180002d57 <numba_list_iter_next+0xd7>
180002d51:     	callq	*0x7ed1(%rip)           # 0x18000ac28
180002d57:     	cmpb	$0x0, 0x7ea2(%rip)      # 0x18000ac00
180002d5e:     	movq	%rax, %r8
180002d61:     	je	0x180002d6b <numba_list_iter_next+0xeb>
180002d63:     	lock
180002d64:     	incq	0x7e9d(%rip)            # 0x18000ac08
180002d6b:     	xorl	%edx, %edx
180002d6d:     	leaq	0x30(%r8), %rax
180002d71:     	testq	%r8, %r8
180002d74:     	movl	%edx, %ecx
180002d76:     	cmovneq	%rax, %rcx
180002d7a:     	testq	%rcx, %rcx
180002d7d:     	jne	0x180002d8c <numba_list_iter_next+0x10c>
180002d7f:     	xorl	%eax, %eax
180002d81:     	movq	0x30(%rsp), %rbx
180002d86:     	addq	$0x20, %rsp
180002d8a:     	popq	%rdi
180002d8b:     	retq
180002d8c:     	movl	$0x1, %eax
180002d91:     	xchgq	%rax, (%r8)
180002d94:     	movq	%rdx, 0x8(%r8)
180002d98:     	movq	%rdx, 0x10(%r8)
180002d9c:     	movq	%rcx, 0x18(%r8)
180002da0:     	movq	%rdi, 0x20(%r8)
180002da4:     	movq	%rbx, 0x28(%r8)
180002da8:     	cmpb	%dl, 0x7e52(%rip)       # 0x18000ac00
180002dae:     	je	0x180002db8 <numba_list_iter_next+0x138>
180002db0:     	lock
180002db1:     	incq	0x7e60(%rip)            # 0x18000ac18
180002db8:     	movq	0x30(%rsp), %rbx
180002dbd:     	movq	%r8, %rax
180002dc0:     	addq	$0x20, %rsp
180002dc4:     	popq	%rdi
180002dc5:     	retq
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
180002dd0:     	lock
180002dd1:     	incq	(%rcx)
180002dd4:     	retq
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
180002de0:     	pushq	%rbx
180002de2:     	subq	$0x20, %rsp
180002de6:     	movq	0x8(%rcx), %rax
180002dea:     	movq	%rcx, %rbx
180002ded:     	testq	%rax, %rax
180002df0:     	je	0x180002e09 <numba_list_iter_next+0x189>
180002df2:     	cmpl	$0x0, 0x7dff(%rip)      # 0x18000abf8
180002df9:     	jne	0x180002e09 <numba_list_iter_next+0x189>
180002dfb:     	movq	0x10(%rcx), %r8
180002dff:     	movq	0x20(%rcx), %rdx
180002e03:     	movq	0x18(%rcx), %rcx
180002e07:     	callq	*%rax
180002e09:     	movq	0x28(%rbx), %rax
180002e0d:     	movq	%rbx, %rcx
180002e10:     	testq	%rax, %rax
180002e13:     	je	0x180002e1e <numba_list_iter_next+0x19e>
180002e15:     	movq	0x18(%rax), %rdx
180002e19:     	callq	*0x10(%rax)
180002e1c:     	jmp	0x180002e24 <numba_list_iter_next+0x1a4>
180002e1e:     	callq	*0x7e14(%rip)           # 0x18000ac38
180002e24:     	cmpb	$0x0, 0x7dd5(%rip)      # 0x18000ac00
180002e2b:     	je	0x180002e49 <numba_list_iter_next+0x1c9>
180002e2d:     	leaq	0x7ddc(%rip), %rax      # 0x18000ac10
180002e34:     	lock
180002e35:     	incq	(%rax)
180002e38:     	cmpb	$0x0, 0x7dc1(%rip)      # 0x18000ac00
180002e3f:     	je	0x180002e49 <numba_list_iter_next+0x1c9>
180002e41:     	lock
180002e42:     	incq	0x7dd7(%rip)            # 0x18000ac20
180002e49:     	addq	$0x20, %rsp
180002e4d:     	popq	%rbx
180002e4e:     	retq
180002e4f:     	int3
180002e50:     	pushq	%rbx
180002e52:     	subq	$0x20, %rsp
180002e56:     	movq	%rcx, %rbx
180002e59:     	movq	$-0x1, %rax
180002e60:     	lock
180002e61:     	xaddq	%rax, (%rcx)
180002e65:     	cmpq	$0x1, %rax
180002e69:     	jne	0x180002ecb <numba_list_iter_next+0x24b>
180002e6b:     	movq	0x8(%rcx), %rax
180002e6f:     	testq	%rax, %rax
180002e72:     	je	0x180002e8b <numba_list_iter_next+0x20b>
180002e74:     	cmpl	$0x0, 0x7d7d(%rip)      # 0x18000abf8
180002e7b:     	jne	0x180002e8b <numba_list_iter_next+0x20b>
180002e7d:     	movq	0x10(%rcx), %r8
180002e81:     	movq	0x20(%rcx), %rdx
180002e85:     	movq	0x18(%rcx), %rcx
180002e89:     	callq	*%rax
180002e8b:     	movq	0x28(%rbx), %rax
180002e8f:     	movq	%rbx, %rcx
180002e92:     	testq	%rax, %rax
180002e95:     	je	0x180002ea0 <numba_list_iter_next+0x220>
180002e97:     	movq	0x18(%rax), %rdx
180002e9b:     	callq	*0x10(%rax)
180002e9e:     	jmp	0x180002ea6 <numba_list_iter_next+0x226>
180002ea0:     	callq	*0x7d92(%rip)           # 0x18000ac38
180002ea6:     	cmpb	$0x0, 0x7d53(%rip)      # 0x18000ac00
180002ead:     	je	0x180002ecb <numba_list_iter_next+0x24b>
180002eaf:     	leaq	0x7d5a(%rip), %rax      # 0x18000ac10
180002eb6:     	lock
180002eb7:     	incq	(%rax)
180002eba:     	cmpb	$0x0, 0x7d3f(%rip)      # 0x18000ac00
180002ec1:     	je	0x180002ecb <numba_list_iter_next+0x24b>
180002ec3:     	lock
180002ec4:     	incq	0x7d55(%rip)            # 0x18000ac20
180002ecb:     	addq	$0x20, %rsp
180002ecf:     	popq	%rbx
180002ed0:     	retq
180002ed1:     	int3
180002ed2:     	int3
180002ed3:     	int3
180002ed4:     	int3
180002ed5:     	int3
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
180002ee0:     	movq	0x18(%rcx), %rax
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
180002ef0:     	jmpq	*%r8
180002ef3:     	int3
180002ef4:     	int3
180002ef5:     	int3
180002ef6:     	int3
180002ef7:     	int3
180002ef8:     	int3
180002ef9:     	int3
180002efa:     	int3
180002efb:     	int3
180002efc:     	int3
180002efd:     	int3
180002efe:     	int3
180002eff:     	int3
180002f00:     	movq	%rbx, 0x8(%rsp)
180002f05:     	pushq	%rdi
180002f06:     	subq	$0x20, %rsp
180002f0a:     	movq	%rcx, %rdi
180002f0d:     	movq	%rdx, %rbx
180002f10:     	movl	$0x30, %ecx
180002f15:     	callq	*0x7d0d(%rip)           # 0x18000ac28
180002f1b:     	cmpb	$0x0, 0x7cde(%rip)      # 0x18000ac00
180002f22:     	je	0x180002f2c <numba_list_iter_next+0x2ac>
180002f24:     	lock
180002f25:     	incq	0x7cdc(%rip)            # 0x18000ac08
180002f2c:     	testq	%rax, %rax
180002f2f:     	je	0x180002f66 <numba_list_iter_next+0x2e6>
180002f31:     	leaq	-0x48(%rip), %rcx       # 0x180002ef0 <numba_list_iter_next+0x270>
180002f38:     	movl	$0x1, %edx
180002f3d:     	xchgq	%rdx, (%rax)
180002f40:     	movq	%rcx, 0x8(%rax)
180002f44:     	xorl	%ecx, %ecx
180002f46:     	movq	%rcx, 0x20(%rax)
180002f4a:     	movq	%rcx, 0x28(%rax)
180002f4e:     	movq	%rbx, 0x10(%rax)
180002f52:     	movq	%rdi, 0x18(%rax)
180002f56:     	cmpb	%cl, 0x7ca4(%rip)       # 0x18000ac00
180002f5c:     	je	0x180002f66 <numba_list_iter_next+0x2e6>
180002f5e:     	lock
180002f5f:     	incq	0x7cb2(%rip)            # 0x18000ac18
180002f66:     	movq	0x30(%rsp), %rbx
180002f6b:     	addq	$0x20, %rsp
180002f6f:     	popq	%rdi
180002f70:     	retq
180002f71:     	jmpq	*0x12f9(%rip)           # 0x180004270
180002f77:     	jmpq	*0x12e3(%rip)           # 0x180004260
180002f7d:     	jmpq	*0x12d5(%rip)           # 0x180004258
180002f83:     	jmpq	*0x12c7(%rip)           # 0x180004250
180002f89:     	jmpq	*0x12b9(%rip)           # 0x180004248
180002f8f:     	jmpq	*0x12ab(%rip)           # 0x180004240
180002f95:     	jmpq	*0x1295(%rip)           # 0x180004230
180002f9b:     	jmpq	*0x127f(%rip)           # 0x180004220
180002fa1:     	jmpq	*0x1259(%rip)           # 0x180004200
180002fa7:     	int3
180002fa8:     	int3
180002fa9:     	int3
180002faa:     	int3
180002fab:     	int3
180002fac:     	int3
180002fad:     	int3
180002fae:     	int3
180002faf:     	int3
180002fb0:     	int3
180002fb1:     	int3
180002fb2:     	int3
180002fb3:     	int3
180002fb4:     	int3
180002fb5:     	int3
180002fb6:     	nopw	(%rax,%rax)
180002fc0:     	cmpq	0x70f9(%rip), %rcx      # 0x18000a0c0
180002fc7:     	jne	0x180002fd9 <numba_list_iter_next+0x359>
180002fc9:     	rolq	$0x10, %rcx
180002fcd:     	testw	$0xffff, %cx            # imm = 0xFFFF
180002fd2:     	jne	0x180002fd5 <numba_list_iter_next+0x355>
180002fd4:     	retq
180002fd5:     	rorq	$0x10, %rcx
180002fd9:     	jmp	0x180003334 <numba_list_iter_next+0x6b4>
180002fde:     	int3
180002fdf:     	int3
180002fe0:     	subq	$0x28, %rsp
180002fe4:     	testl	%edx, %edx
180002fe6:     	je	0x180003021 <numba_list_iter_next+0x3a1>
180002fe8:     	subl	$0x1, %edx
180002feb:     	je	0x180003015 <numba_list_iter_next+0x395>
180002fed:     	subl	$0x1, %edx
180002ff0:     	je	0x180003008 <numba_list_iter_next+0x388>
180002ff2:     	cmpl	$0x1, %edx
180002ff5:     	je	0x180003001 <numba_list_iter_next+0x381>
180002ff7:     	movl	$0x1, %eax
180002ffc:     	addq	$0x28, %rsp
180003000:     	retq
180003001:     	callq	0x180003500 <numba_list_iter_next+0x880>
180003006:     	jmp	0x18000300d <numba_list_iter_next+0x38d>
180003008:     	callq	0x1800034d8 <numba_list_iter_next+0x858>
18000300d:     	movzbl	%al, %eax
180003010:     	addq	$0x28, %rsp
180003014:     	retq
180003015:     	movq	%r8, %rdx
180003018:     	addq	$0x28, %rsp
18000301c:     	jmp	0x180003030 <numba_list_iter_next+0x3b0>
180003021:     	testq	%r8, %r8
180003024:     	setne	%cl
180003027:     	addq	$0x28, %rsp
18000302b:     	jmp	0x180003148 <numba_list_iter_next+0x4c8>
180003030:     	movq	%rbx, 0x8(%rsp)
180003035:     	movq	%rsi, 0x10(%rsp)
18000303a:     	movq	%rdi, 0x20(%rsp)
18000303f:     	pushq	%r14
180003041:     	subq	$0x20, %rsp
180003045:     	movq	%rdx, %rsi
180003048:     	movq	%rcx, %r14
18000304b:     	xorl	%ecx, %ecx
18000304d:     	callq	0x1800035bc <numba_list_iter_next+0x93c>
180003052:     	testb	%al, %al
180003054:     	je	0x180003122 <numba_list_iter_next+0x4a2>
18000305a:     	callq	0x180003450 <numba_list_iter_next+0x7d0>
18000305f:     	movb	%al, %bl
180003061:     	movb	%al, 0x40(%rsp)
180003065:     	movb	$0x1, %dil
180003068:     	cmpl	$0x0, 0x7959(%rip)      # 0x18000a9c8
18000306f:     	jne	0x18000313a <numba_list_iter_next+0x4ba>
180003075:     	movl	$0x1, 0x7949(%rip)      # 0x18000a9c8
18000307f:     	callq	0x1800034c0 <numba_list_iter_next+0x840>
180003084:     	testb	%al, %al
180003086:     	je	0x1800030d7 <numba_list_iter_next+0x457>
180003088:     	callq	0x18000377c <numba_list_iter_next+0xafc>
18000308d:     	callq	0x180003410 <numba_list_iter_next+0x790>
180003092:     	callq	0x180003434 <numba_list_iter_next+0x7b4>
180003097:     	leaq	0x1232(%rip), %rdx      # 0x1800042d0
18000309e:     	leaq	0x1223(%rip), %rcx      # 0x1800042c8
1800030a5:     	callq	0x180003ac2 <numba_list_iter_next+0xe42>
1800030aa:     	testl	%eax, %eax
1800030ac:     	jne	0x1800030d7 <numba_list_iter_next+0x457>
1800030ae:     	callq	0x18000348c <numba_list_iter_next+0x80c>
1800030b3:     	testb	%al, %al
1800030b5:     	je	0x1800030d7 <numba_list_iter_next+0x457>
1800030b7:     	leaq	0x1202(%rip), %rdx      # 0x1800042c0
1800030be:     	leaq	0x11f3(%rip), %rcx      # 0x1800042b8
1800030c5:     	callq	0x180003abc <numba_list_iter_next+0xe3c>
1800030ca:     	movl	$0x2, 0x78f4(%rip)      # 0x18000a9c8
1800030d4:     	xorb	%dil, %dil
1800030d7:     	movb	%bl, %cl
1800030d9:     	callq	0x18000371c <numba_list_iter_next+0xa9c>
1800030de:     	testb	%dil, %dil
1800030e1:     	jne	0x180003122 <numba_list_iter_next+0x4a2>
1800030e3:     	callq	0x18000376c <numba_list_iter_next+0xaec>
1800030e8:     	movq	%rax, %rbx
1800030eb:     	cmpq	$0x0, (%rax)
1800030ef:     	je	0x180003115 <numba_list_iter_next+0x495>
1800030f1:     	movq	%rax, %rcx
1800030f4:     	callq	0x180003684 <numba_list_iter_next+0xa04>
1800030f9:     	testb	%al, %al
1800030fb:     	je	0x180003115 <numba_list_iter_next+0x495>
1800030fd:     	movq	%rsi, %r8
180003100:     	movl	$0x2, %edx
180003105:     	movq	%r14, %rcx
180003108:     	movq	(%rbx), %rax
18000310b:     	movq	0x117e(%rip), %r9       # 0x180004290
180003112:     	callq	*%r9
180003115:     	incl	0x7885(%rip)            # 0x18000a9a0
18000311b:     	movl	$0x1, %eax
180003120:     	jmp	0x180003124 <numba_list_iter_next+0x4a4>
180003122:     	xorl	%eax, %eax
180003124:     	movq	0x30(%rsp), %rbx
180003129:     	movq	0x38(%rsp), %rsi
18000312e:     	movq	0x48(%rsp), %rdi
180003133:     	addq	$0x20, %rsp
180003137:     	popq	%r14
180003139:     	retq
18000313a:     	movl	$0x7, %ecx
18000313f:     	callq	0x180003774 <numba_list_iter_next+0xaf4>
180003144:     	nop
180003145:     	int3
180003146:     	int3
180003147:     	int3
180003148:     	movq	%rbx, 0x8(%rsp)
18000314d:     	pushq	%rdi
18000314e:     	subq	$0x30, %rsp
180003152:     	movb	%cl, %dil
180003155:     	movl	0x7845(%rip), %eax      # 0x18000a9a0
18000315b:     	testl	%eax, %eax
18000315d:     	jg	0x18000316c <numba_list_iter_next+0x4ec>
18000315f:     	xorl	%eax, %eax
180003161:     	movq	0x40(%rsp), %rbx
180003166:     	addq	$0x30, %rsp
18000316a:     	popq	%rdi
18000316b:     	retq
18000316c:     	decl	%eax
18000316e:     	movl	%eax, 0x782c(%rip)      # 0x18000a9a0
180003174:     	callq	0x180003450 <numba_list_iter_next+0x7d0>
180003179:     	movb	%al, %bl
18000317b:     	movb	%al, 0x20(%rsp)
18000317f:     	cmpl	$0x2, 0x7842(%rip)      # 0x18000a9c8
180003186:     	jne	0x1800031be <numba_list_iter_next+0x53e>
180003188:     	callq	0x180003578 <numba_list_iter_next+0x8f8>
18000318d:     	callq	0x180003420 <numba_list_iter_next+0x7a0>
180003192:     	callq	0x1800037b8 <numba_list_iter_next+0xb38>
180003197:     	movl	$0x0, 0x7827(%rip)      # 0x18000a9c8
1800031a1:     	movb	%bl, %cl
1800031a3:     	callq	0x18000371c <numba_list_iter_next+0xa9c>
1800031a8:     	xorl	%edx, %edx
1800031aa:     	movb	%dil, %cl
1800031ad:     	callq	0x180003740 <numba_list_iter_next+0xac0>
1800031b2:     	movzbl	%al, %ebx
1800031b5:     	callq	0x1800035a8 <numba_list_iter_next+0x928>
1800031ba:     	movl	%ebx, %eax
1800031bc:     	jmp	0x180003161 <numba_list_iter_next+0x4e1>
1800031be:     	movl	$0x7, %ecx
1800031c3:     	callq	0x180003774 <numba_list_iter_next+0xaf4>
1800031c8:     	nop
1800031c9:     	nop
1800031ca:     	int3
1800031cb:     	int3
1800031cc:     	movq	%rsp, %rax
1800031cf:     	movq	%rbx, 0x20(%rax)
1800031d3:     	movq	%r8, 0x18(%rax)
1800031d7:     	movl	%edx, 0x10(%rax)
1800031da:     	movq	%rcx, 0x8(%rax)
1800031de:     	pushq	%rsi
1800031df:     	pushq	%rdi
1800031e0:     	pushq	%r14
1800031e2:     	subq	$0x40, %rsp
1800031e6:     	movq	%r8, %rsi
1800031e9:     	movl	%edx, %edi
1800031eb:     	movq	%rcx, %r14
1800031ee:     	testl	%edx, %edx
1800031f0:     	jne	0x180003201 <numba_list_iter_next+0x581>
1800031f2:     	cmpl	%edx, 0x77a8(%rip)      # 0x18000a9a0
1800031f8:     	jg	0x180003201 <numba_list_iter_next+0x581>
1800031fa:     	xorl	%eax, %eax
1800031fc:     	jmp	0x1800032e6 <numba_list_iter_next+0x666>
180003201:     	leal	-0x1(%rdx), %eax
180003204:     	cmpl	$0x1, %eax
180003207:     	ja	0x180003249 <numba_list_iter_next+0x5c9>
180003209:     	movq	0x13a8(%rip), %rax      # 0x1800045b8
180003210:     	testq	%rax, %rax
180003213:     	jne	0x18000321a <numba_list_iter_next+0x59a>
180003215:     	leal	0x1(%rax), %ebx
180003218:     	jmp	0x180003222 <numba_list_iter_next+0x5a2>
18000321a:     	callq	*0x1070(%rip)           # 0x180004290
180003220:     	movl	%eax, %ebx
180003222:     	movl	%ebx, 0x30(%rsp)
180003226:     	testl	%ebx, %ebx
180003228:     	je	0x1800032dc <numba_list_iter_next+0x65c>
18000322e:     	movq	%rsi, %r8
180003231:     	movl	%edi, %edx
180003233:     	movq	%r14, %rcx
180003236:     	callq	0x180002fe0 <numba_list_iter_next+0x360>
18000323b:     	movl	%eax, %ebx
18000323d:     	movl	%eax, 0x30(%rsp)
180003241:     	testl	%eax, %eax
180003243:     	je	0x1800032dc <numba_list_iter_next+0x65c>
180003249:     	movq	%rsi, %r8
18000324c:     	movl	%edi, %edx
18000324e:     	movq	%r14, %rcx
180003251:     	callq	0x1800033ec <numba_list_iter_next+0x76c>
180003256:     	movl	%eax, %ebx
180003258:     	movl	%eax, 0x30(%rsp)
18000325c:     	cmpl	$0x1, %edi
18000325f:     	jne	0x180003297 <numba_list_iter_next+0x617>
180003261:     	testl	%eax, %eax
180003263:     	jne	0x180003297 <numba_list_iter_next+0x617>
180003265:     	movq	%rsi, %r8
180003268:     	xorl	%edx, %edx
18000326a:     	movq	%r14, %rcx
18000326d:     	callq	0x1800033ec <numba_list_iter_next+0x76c>
180003272:     	testq	%rsi, %rsi
180003275:     	setne	%cl
180003278:     	callq	0x180003148 <numba_list_iter_next+0x4c8>
18000327d:     	movq	0x1334(%rip), %rax      # 0x1800045b8
180003284:     	testq	%rax, %rax
180003287:     	je	0x180003297 <numba_list_iter_next+0x617>
180003289:     	movq	%rsi, %r8
18000328c:     	xorl	%edx, %edx
18000328e:     	movq	%r14, %rcx
180003291:     	callq	*0xff9(%rip)            # 0x180004290
180003297:     	testl	%edi, %edi
180003299:     	je	0x1800032a0 <numba_list_iter_next+0x620>
18000329b:     	cmpl	$0x3, %edi
18000329e:     	jne	0x1800032dc <numba_list_iter_next+0x65c>
1800032a0:     	movq	%rsi, %r8
1800032a3:     	movl	%edi, %edx
1800032a5:     	movq	%r14, %rcx
1800032a8:     	callq	0x180002fe0 <numba_list_iter_next+0x360>
1800032ad:     	movl	%eax, %ebx
1800032af:     	movl	%eax, 0x30(%rsp)
1800032b3:     	testl	%eax, %eax
1800032b5:     	je	0x1800032dc <numba_list_iter_next+0x65c>
1800032b7:     	movq	0x12fa(%rip), %rax      # 0x1800045b8
1800032be:     	testq	%rax, %rax
1800032c1:     	jne	0x1800032c8 <numba_list_iter_next+0x648>
1800032c3:     	leal	0x1(%rax), %ebx
1800032c6:     	jmp	0x1800032d8 <numba_list_iter_next+0x658>
1800032c8:     	movq	%rsi, %r8
1800032cb:     	movl	%edi, %edx
1800032cd:     	movq	%r14, %rcx
1800032d0:     	callq	*0xfba(%rip)            # 0x180004290
1800032d6:     	movl	%eax, %ebx
1800032d8:     	movl	%ebx, 0x30(%rsp)
1800032dc:     	jmp	0x1800032e4 <numba_list_iter_next+0x664>
1800032de:     	xorl	%ebx, %ebx
1800032e0:     	movl	%ebx, 0x30(%rsp)
1800032e4:     	movl	%ebx, %eax
1800032e6:     	movq	0x78(%rsp), %rbx
1800032eb:     	addq	$0x40, %rsp
1800032ef:     	popq	%r14
1800032f1:     	popq	%rdi
1800032f2:     	popq	%rsi
1800032f3:     	retq
1800032f4:     	movq	%rbx, 0x8(%rsp)
1800032f9:     	movq	%rsi, 0x10(%rsp)
1800032fe:     	pushq	%rdi
1800032ff:     	subq	$0x20, %rsp
180003303:     	movq	%r8, %rdi
180003306:     	movl	%edx, %ebx
180003308:     	movq	%rcx, %rsi
18000330b:     	cmpl	$0x1, %edx
18000330e:     	jne	0x180003315 <numba_list_iter_next+0x695>
180003310:     	callq	0x18000333c <numba_list_iter_next+0x6bc>
180003315:     	movq	%rdi, %r8
180003318:     	movl	%ebx, %edx
18000331a:     	movq	%rsi, %rcx
18000331d:     	movq	0x30(%rsp), %rbx
180003322:     	movq	0x38(%rsp), %rsi
180003327:     	addq	$0x20, %rsp
18000332b:     	popq	%rdi
18000332c:     	jmp	0x1800031cc <numba_list_iter_next+0x54c>
180003331:     	int3
180003332:     	int3
180003333:     	int3
180003334:     	movl	$0x2, %ecx
180003339:     	int	$0x29
18000333b:     	retq
18000333c:     	movq	%rbx, 0x18(%rsp)
180003341:     	pushq	%rbp
180003342:     	movq	%rsp, %rbp
180003345:     	subq	$0x30, %rsp
180003349:     	movq	0x6d70(%rip), %rax      # 0x18000a0c0
180003350:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000335a:     	cmpq	%rbx, %rax
18000335d:     	jne	0x1800033d6 <numba_list_iter_next+0x756>
18000335f:     	leaq	0x10(%rbp), %rcx
180003363:     	movq	$0x0, 0x10(%rbp)
18000336b:     	callq	*0xcaf(%rip)            # 0x180004020
180003371:     	movq	0x10(%rbp), %rax
180003375:     	movq	%rax, -0x10(%rbp)
180003379:     	callq	*0xc99(%rip)            # 0x180004018
18000337f:     	movl	%eax, %eax
180003381:     	xorq	%rax, -0x10(%rbp)
180003385:     	callq	*0xc85(%rip)            # 0x180004010
18000338b:     	movl	%eax, %eax
18000338d:     	leaq	0x18(%rbp), %rcx
180003391:     	xorq	%rax, -0x10(%rbp)
180003395:     	callq	*0xc65(%rip)            # 0x180004000
18000339b:     	movl	0x18(%rbp), %eax
18000339e:     	leaq	-0x10(%rbp), %rcx
1800033a2:     	shlq	$0x20, %rax
1800033a6:     	xorq	0x18(%rbp), %rax
1800033aa:     	xorq	-0x10(%rbp), %rax
1800033ae:     	xorq	%rcx, %rax
1800033b1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
1800033bb:     	andq	%rcx, %rax
1800033be:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
1800033c8:     	cmpq	%rbx, %rax
1800033cb:     	cmoveq	%rcx, %rax
1800033cf:     	movq	%rax, 0x6cea(%rip)      # 0x18000a0c0
1800033d6:     	movq	0x50(%rsp), %rbx
1800033db:     	notq	%rax
1800033de:     	movq	%rax, 0x6d1b(%rip)      # 0x18000a100
1800033e5:     	addq	$0x30, %rsp
1800033e9:     	popq	%rbp
1800033ea:     	retq
1800033eb:     	int3
1800033ec:     	subq	$0x28, %rsp
1800033f0:     	cmpl	$0x1, %edx
1800033f3:     	jne	0x180003405 <numba_list_iter_next+0x785>
1800033f5:     	cmpq	$0x0, 0x11bb(%rip)      # 0x1800045b8
1800033fd:     	jne	0x180003405 <numba_list_iter_next+0x785>
1800033ff:     	callq	*0xc23(%rip)            # 0x180004028
180003405:     	movl	$0x1, %eax
18000340a:     	addq	$0x28, %rsp
18000340e:     	retq
18000340f:     	int3
180003410:     	leaq	0x7599(%rip), %rcx      # 0x18000a9b0
180003417:     	jmpq	*0xbea(%rip)            # 0x180004008
18000341e:     	int3
18000341f:     	int3
180003420:     	leaq	0x7589(%rip), %rcx      # 0x18000a9b0
180003427:     	jmp	0x180003ab6 <numba_list_iter_next+0xe36>
18000342c:     	leaq	0x758d(%rip), %rax      # 0x18000a9c0
180003433:     	retq
180003434:     	subq	$0x28, %rsp
180003438:     	callq	0x180002590 <PyInit_rcnumeric_c6a048f0e997a3016910f788+0x10e0>
18000343d:     	orq	$0x24, (%rax)
180003441:     	callq	0x18000342c <numba_list_iter_next+0x7ac>
180003446:     	orq	$0x2, (%rax)
18000344a:     	addq	$0x28, %rsp
18000344e:     	retq
18000344f:     	int3
180003450:     	subq	$0x28, %rsp
180003454:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
180003459:     	testl	%eax, %eax
18000345b:     	je	0x18000347e <numba_list_iter_next+0x7fe>
18000345d:     	movq	%gs:0x30, %rax
180003466:     	movq	0x8(%rax), %rcx
18000346a:     	jmp	0x180003471 <numba_list_iter_next+0x7f1>
18000346c:     	cmpq	%rax, %rcx
18000346f:     	je	0x180003485 <numba_list_iter_next+0x805>
180003471:     	xorl	%eax, %eax
180003473:     	lock
180003474:     	cmpxchgq	%rcx, 0x7554(%rip)      # 0x18000a9d0
18000347c:     	jne	0x18000346c <numba_list_iter_next+0x7ec>
18000347e:     	xorb	%al, %al
180003480:     	addq	$0x28, %rsp
180003484:     	retq
180003485:     	movb	$0x1, %al
180003487:     	jmp	0x180003480 <numba_list_iter_next+0x800>
180003489:     	int3
18000348a:     	int3
18000348b:     	int3
18000348c:     	subq	$0x28, %rsp
180003490:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
180003495:     	testl	%eax, %eax
180003497:     	je	0x1800034a0 <numba_list_iter_next+0x820>
180003499:     	callq	0x1800037f8 <numba_list_iter_next+0xb78>
18000349e:     	jmp	0x1800034b9 <numba_list_iter_next+0x839>
1800034a0:     	callq	0x180003a94 <numba_list_iter_next+0xe14>
1800034a5:     	movl	%eax, %ecx
1800034a7:     	callq	0x180003ace <numba_list_iter_next+0xe4e>
1800034ac:     	testl	%eax, %eax
1800034ae:     	je	0x1800034b4 <numba_list_iter_next+0x834>
1800034b0:     	xorb	%al, %al
1800034b2:     	jmp	0x1800034bb <numba_list_iter_next+0x83b>
1800034b4:     	callq	0x180003ad4 <numba_list_iter_next+0xe54>
1800034b9:     	movb	$0x1, %al
1800034bb:     	addq	$0x28, %rsp
1800034bf:     	retq
1800034c0:     	subq	$0x28, %rsp
1800034c4:     	xorl	%ecx, %ecx
1800034c6:     	callq	0x1800035f8 <numba_list_iter_next+0x978>
1800034cb:     	testb	%al, %al
1800034cd:     	setne	%al
1800034d0:     	addq	$0x28, %rsp
1800034d4:     	retq
1800034d5:     	int3
1800034d6:     	int3
1800034d7:     	int3
1800034d8:     	subq	$0x28, %rsp
1800034dc:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800034e1:     	testb	%al, %al
1800034e3:     	jne	0x1800034e9 <numba_list_iter_next+0x869>
1800034e5:     	xorb	%al, %al
1800034e7:     	jmp	0x1800034fb <numba_list_iter_next+0x87b>
1800034e9:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800034ee:     	testb	%al, %al
1800034f0:     	jne	0x1800034f9 <numba_list_iter_next+0x879>
1800034f2:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800034f7:     	jmp	0x1800034e5 <numba_list_iter_next+0x865>
1800034f9:     	movb	$0x1, %al
1800034fb:     	addq	$0x28, %rsp
1800034ff:     	retq
180003500:     	subq	$0x28, %rsp
180003504:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
180003509:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
18000350e:     	movb	$0x1, %al
180003510:     	addq	$0x28, %rsp
180003514:     	retq
180003515:     	int3
180003516:     	int3
180003517:     	int3
180003518:     	movq	%rbx, 0x8(%rsp)
18000351d:     	movq	%rbp, 0x10(%rsp)
180003522:     	movq	%rsi, 0x18(%rsp)
180003527:     	pushq	%rdi
180003528:     	subq	$0x20, %rsp
18000352c:     	movq	%r9, %rdi
18000352f:     	movq	%r8, %rsi
180003532:     	movl	%edx, %ebx
180003534:     	movq	%rcx, %rbp
180003537:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
18000353c:     	testl	%eax, %eax
18000353e:     	jne	0x180003556 <numba_list_iter_next+0x8d6>
180003540:     	cmpl	$0x1, %ebx
180003543:     	jne	0x180003556 <numba_list_iter_next+0x8d6>
180003545:     	movq	%rsi, %r8
180003548:     	xorl	%edx, %edx
18000354a:     	movq	%rbp, %rcx
18000354d:     	movq	%rdi, %rax
180003550:     	callq	*0xd3a(%rip)            # 0x180004290
180003556:     	movq	0x58(%rsp), %rdx
18000355b:     	movl	0x50(%rsp), %ecx
18000355f:     	movq	0x30(%rsp), %rbx
180003564:     	movq	0x38(%rsp), %rbp
180003569:     	movq	0x40(%rsp), %rsi
18000356e:     	addq	$0x20, %rsp
180003572:     	popq	%rdi
180003573:     	jmp	0x180003ac8 <numba_list_iter_next+0xe48>
180003578:     	subq	$0x28, %rsp
18000357c:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
180003581:     	testl	%eax, %eax
180003583:     	je	0x180003595 <numba_list_iter_next+0x915>
180003585:     	leaq	0x7454(%rip), %rcx      # 0x18000a9e0
18000358c:     	addq	$0x28, %rsp
180003590:     	jmp	0x180003ae0 <numba_list_iter_next+0xe60>
180003595:     	callq	0x180003af0 <numba_list_iter_next+0xe70>
18000359a:     	testl	%eax, %eax
18000359c:     	jne	0x1800035a3 <numba_list_iter_next+0x923>
18000359e:     	callq	0x180003ae6 <numba_list_iter_next+0xe66>
1800035a3:     	addq	$0x28, %rsp
1800035a7:     	retq
1800035a8:     	subq	$0x28, %rsp
1800035ac:     	xorl	%ecx, %ecx
1800035ae:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800035b3:     	addq	$0x28, %rsp
1800035b7:     	jmp	0x180003aec <numba_list_iter_next+0xe6c>
1800035bc:     	subq	$0x28, %rsp
1800035c0:     	testl	%ecx, %ecx
1800035c2:     	jne	0x1800035cb <numba_list_iter_next+0x94b>
1800035c4:     	movb	$0x1, 0x740d(%rip)      # 0x18000a9d8
1800035cb:     	callq	0x1800037f8 <numba_list_iter_next+0xb78>
1800035d0:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800035d5:     	testb	%al, %al
1800035d7:     	jne	0x1800035dd <numba_list_iter_next+0x95d>
1800035d9:     	xorb	%al, %al
1800035db:     	jmp	0x1800035f1 <numba_list_iter_next+0x971>
1800035dd:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800035e2:     	testb	%al, %al
1800035e4:     	jne	0x1800035ef <numba_list_iter_next+0x96f>
1800035e6:     	xorl	%ecx, %ecx
1800035e8:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
1800035ed:     	jmp	0x1800035d9 <numba_list_iter_next+0x959>
1800035ef:     	movb	$0x1, %al
1800035f1:     	addq	$0x28, %rsp
1800035f5:     	retq
1800035f6:     	int3
1800035f7:     	int3
1800035f8:     	pushq	%rbx
1800035fa:     	subq	$0x20, %rsp
1800035fe:     	cmpb	$0x0, 0x73d4(%rip)      # 0x18000a9d9
180003605:     	movl	%ecx, %ebx
180003607:     	jne	0x180003670 <numba_list_iter_next+0x9f0>
180003609:     	cmpl	$0x1, %ecx
18000360c:     	ja	0x180003678 <numba_list_iter_next+0x9f8>
18000360e:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
180003613:     	testl	%eax, %eax
180003615:     	je	0x18000363f <numba_list_iter_next+0x9bf>
180003617:     	testl	%ebx, %ebx
180003619:     	jne	0x18000363f <numba_list_iter_next+0x9bf>
18000361b:     	leaq	0x73be(%rip), %rcx      # 0x18000a9e0
180003622:     	callq	0x180003ada <numba_list_iter_next+0xe5a>
180003627:     	testl	%eax, %eax
180003629:     	jne	0x18000363b <numba_list_iter_next+0x9bb>
18000362b:     	leaq	0x73c6(%rip), %rcx      # 0x18000a9f8
180003632:     	callq	0x180003ada <numba_list_iter_next+0xe5a>
180003637:     	testl	%eax, %eax
180003639:     	je	0x180003669 <numba_list_iter_next+0x9e9>
18000363b:     	xorb	%al, %al
18000363d:     	jmp	0x180003672 <numba_list_iter_next+0x9f2>
18000363f:     	movdqa	0xf79(%rip), %xmm0      # 0x1800045c0
180003647:     	orq	$-0x1, %rax
18000364b:     	movdqu	%xmm0, 0x738d(%rip)     # 0x18000a9e0
180003653:     	movq	%rax, 0x7396(%rip)      # 0x18000a9f0
18000365a:     	movdqu	%xmm0, 0x7396(%rip)     # 0x18000a9f8
180003662:     	movq	%rax, 0x739f(%rip)      # 0x18000aa08
180003669:     	movb	$0x1, 0x7369(%rip)      # 0x18000a9d9
180003670:     	movb	$0x1, %al
180003672:     	addq	$0x20, %rsp
180003676:     	popq	%rbx
180003677:     	retq
180003678:     	movl	$0x5, %ecx
18000367d:     	callq	0x180003774 <numba_list_iter_next+0xaf4>
180003682:     	int3
180003683:     	int3
180003684:     	subq	$0x18, %rsp
180003688:     	movq	%rcx, %r8
18000368b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180003690:     	cmpw	%ax, -0x3697(%rip)      # 0x180000000
180003697:     	jne	0x180003711 <numba_list_iter_next+0xa91>
180003699:     	movslq	-0x3664(%rip), %rcx     # 0x18000003c
1800036a0:     	leaq	-0x36a7(%rip), %rdx     # 0x180000000
1800036a7:     	addq	%rdx, %rcx
1800036aa:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
1800036b0:     	jne	0x180003711 <numba_list_iter_next+0xa91>
1800036b2:     	movl	$0x20b, %eax            # imm = 0x20B
1800036b7:     	cmpw	%ax, 0x18(%rcx)
1800036bb:     	jne	0x180003711 <numba_list_iter_next+0xa91>
1800036bd:     	subq	%rdx, %r8
1800036c0:     	movzwl	0x14(%rcx), %edx
1800036c4:     	addq	$0x18, %rdx
1800036c8:     	addq	%rcx, %rdx
1800036cb:     	movzwl	0x6(%rcx), %eax
1800036cf:     	leaq	(%rax,%rax,4), %rcx
1800036d3:     	leaq	(%rdx,%rcx,8), %r9
1800036d7:     	movq	%rdx, (%rsp)
1800036db:     	cmpq	%r9, %rdx
1800036de:     	je	0x1800036f8 <numba_list_iter_next+0xa78>
1800036e0:     	movl	0xc(%rdx), %ecx
1800036e3:     	cmpq	%rcx, %r8
1800036e6:     	jb	0x1800036f2 <numba_list_iter_next+0xa72>
1800036e8:     	movl	0x8(%rdx), %eax
1800036eb:     	addl	%ecx, %eax
1800036ed:     	cmpq	%rax, %r8
1800036f0:     	jb	0x1800036fa <numba_list_iter_next+0xa7a>
1800036f2:     	addq	$0x28, %rdx
1800036f6:     	jmp	0x1800036d7 <numba_list_iter_next+0xa57>
1800036f8:     	xorl	%edx, %edx
1800036fa:     	testq	%rdx, %rdx
1800036fd:     	jne	0x180003703 <numba_list_iter_next+0xa83>
1800036ff:     	xorb	%al, %al
180003701:     	jmp	0x180003717 <numba_list_iter_next+0xa97>
180003703:     	cmpl	$0x0, 0x24(%rdx)
180003707:     	jge	0x18000370d <numba_list_iter_next+0xa8d>
180003709:     	xorb	%al, %al
18000370b:     	jmp	0x180003717 <numba_list_iter_next+0xa97>
18000370d:     	movb	$0x1, %al
18000370f:     	jmp	0x180003717 <numba_list_iter_next+0xa97>
180003711:     	xorb	%al, %al
180003713:     	jmp	0x180003717 <numba_list_iter_next+0xa97>
180003715:     	xorb	%al, %al
180003717:     	addq	$0x18, %rsp
18000371b:     	retq
18000371c:     	pushq	%rbx
18000371e:     	subq	$0x20, %rsp
180003722:     	movb	%cl, %bl
180003724:     	callq	0x180003a9c <numba_list_iter_next+0xe1c>
180003729:     	xorl	%edx, %edx
18000372b:     	testl	%eax, %eax
18000372d:     	je	0x18000373a <numba_list_iter_next+0xaba>
18000372f:     	testb	%bl, %bl
180003731:     	jne	0x18000373a <numba_list_iter_next+0xaba>
180003733:     	xchgq	%rdx, 0x7296(%rip)      # 0x18000a9d0
18000373a:     	addq	$0x20, %rsp
18000373e:     	popq	%rbx
18000373f:     	retq
180003740:     	pushq	%rbx
180003742:     	subq	$0x20, %rsp
180003746:     	cmpb	$0x0, 0x728b(%rip)      # 0x18000a9d8
18000374d:     	movb	%cl, %bl
18000374f:     	je	0x180003755 <numba_list_iter_next+0xad5>
180003751:     	testb	%dl, %dl
180003753:     	jne	0x180003761 <numba_list_iter_next+0xae1>
180003755:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
18000375a:     	movb	%bl, %cl
18000375c:     	callq	0x180003aec <numba_list_iter_next+0xe6c>
180003761:     	movb	$0x1, %al
180003763:     	addq	$0x20, %rsp
180003767:     	popq	%rbx
180003768:     	retq
180003769:     	int3
18000376a:     	int3
18000376b:     	int3
18000376c:     	leaq	0x74f5(%rip), %rax      # 0x18000ac68
180003773:     	retq
180003774:     	movl	%ecx, %ecx
180003776:     	int	$0x29
180003778:     	retq
180003779:     	int3
18000377a:     	int3
18000377b:     	int3
18000377c:     	movq	%rbx, 0x8(%rsp)
180003781:     	pushq	%rdi
180003782:     	subq	$0x20, %rsp
180003786:     	leaq	0x37b3(%rip), %rbx      # 0x180006f40
18000378d:     	leaq	0x37ac(%rip), %rdi      # 0x180006f40
180003794:     	jmp	0x1800037a8 <numba_list_iter_next+0xb28>
180003796:     	movq	(%rbx), %rax
180003799:     	testq	%rax, %rax
18000379c:     	je	0x1800037a4 <numba_list_iter_next+0xb24>
18000379e:     	callq	*0xaec(%rip)            # 0x180004290
1800037a4:     	addq	$0x8, %rbx
1800037a8:     	cmpq	%rdi, %rbx
1800037ab:     	jb	0x180003796 <numba_list_iter_next+0xb16>
1800037ad:     	movq	0x30(%rsp), %rbx
1800037b2:     	addq	$0x20, %rsp
1800037b6:     	popq	%rdi
1800037b7:     	retq
1800037b8:     	movq	%rbx, 0x8(%rsp)
1800037bd:     	pushq	%rdi
1800037be:     	subq	$0x20, %rsp
1800037c2:     	leaq	0x3787(%rip), %rbx      # 0x180006f50
1800037c9:     	leaq	0x3780(%rip), %rdi      # 0x180006f50
1800037d0:     	jmp	0x1800037e4 <numba_list_iter_next+0xb64>
1800037d2:     	movq	(%rbx), %rax
1800037d5:     	testq	%rax, %rax
1800037d8:     	je	0x1800037e0 <numba_list_iter_next+0xb60>
1800037da:     	callq	*0xab0(%rip)            # 0x180004290
1800037e0:     	addq	$0x8, %rbx
1800037e4:     	cmpq	%rdi, %rbx
1800037e7:     	jb	0x1800037d2 <numba_list_iter_next+0xb52>
1800037e9:     	movq	0x30(%rsp), %rbx
1800037ee:     	addq	$0x20, %rsp
1800037f2:     	popq	%rdi
1800037f3:     	retq
1800037f4:     	retq	$0x0
1800037f7:     	int3
1800037f8:     	movq	%rbx, 0x10(%rsp)
1800037fd:     	movq	%rbp, 0x18(%rsp)
180003802:     	movq	%rsi, 0x20(%rsp)
180003807:     	pushq	%rdi
180003808:     	subq	$0x10, %rsp
18000380c:     	xorl	%eax, %eax
18000380e:     	xorl	%ecx, %ecx
180003810:     	cpuid
180003812:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180003818:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000381e:     	orl	%ecx, %edx
180003820:     	movl	%eax, %ebp
180003822:     	movl	$0x1, %eax
180003827:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000382d:     	orl	%ebx, %edx
18000382f:     	leal	-0x1(%rax), %ecx
180003832:     	cpuid
180003834:     	movl	%ecx, %edi
180003836:     	jne	0x180003896 <numba_list_iter_next+0xc16>
180003838:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000383d:     	movq	$0x8000, 0x68d0(%rip)   # imm = 0x8000
                                                # 0x18000a118
180003848:     	movq	$-0x1, 0x68cd(%rip)     # 0x18000a120
180003853:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180003858:     	je	0x180003882 <numba_list_iter_next+0xc02>
18000385a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000385f:     	je	0x180003882 <numba_list_iter_next+0xc02>
180003861:     	cmpl	$0x20670, %eax          # imm = 0x20670
180003866:     	je	0x180003882 <numba_list_iter_next+0xc02>
180003868:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000386d:     	cmpl	$0x20, %eax
180003870:     	ja	0x180003896 <numba_list_iter_next+0xc16>
180003872:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000387c:     	btq	%rax, %rcx
180003880:     	jae	0x180003896 <numba_list_iter_next+0xc16>
180003882:     	movl	0x718b(%rip), %r8d      # 0x18000aa14
180003889:     	orl	$0x1, %r8d
18000388d:     	movl	%r8d, 0x7180(%rip)      # 0x18000aa14
180003894:     	jmp	0x18000389d <numba_list_iter_next+0xc1d>
180003896:     	movl	0x7177(%rip), %r8d      # 0x18000aa14
18000389d:     	xorl	%r9d, %r9d
1800038a0:     	movl	%r9d, %r11d
1800038a3:     	cmpl	$0x7, %ebp
1800038a6:     	jl	0x1800038ea <numba_list_iter_next+0xc6a>
1800038a8:     	xorl	%ecx, %ecx
1800038aa:     	leal	0x7(%r9), %eax
1800038ae:     	cpuid
1800038b0:     	movl	%edx, %esi
1800038b2:     	movl	%ebx, %r10d
1800038b5:     	btl	$0x9, %ebx
1800038b9:     	jae	0x1800038c6 <numba_list_iter_next+0xc46>
1800038bb:     	orl	$0x2, %r8d
1800038bf:     	movl	%r8d, 0x714e(%rip)      # 0x18000aa14
1800038c6:     	cmpl	$0x1, %eax
1800038c9:     	jl	0x1800038d8 <numba_list_iter_next+0xc58>
1800038cb:     	movl	$0x7, %eax
1800038d0:     	leal	-0x6(%rax), %ecx
1800038d3:     	cpuid
1800038d5:     	movl	%edx, %r9d
1800038d8:     	movl	$0x24, %eax
1800038dd:     	cmpl	%eax, %ebp
1800038df:     	jl	0x1800038f0 <numba_list_iter_next+0xc70>
1800038e1:     	xorl	%ecx, %ecx
1800038e3:     	cpuid
1800038e5:     	movl	%ebx, %r11d
1800038e8:     	jmp	0x1800038f0 <numba_list_iter_next+0xc70>
1800038ea:     	movl	%r9d, %r10d
1800038ed:     	movl	%r9d, %esi
1800038f0:     	movq	0x6831(%rip), %rax      # 0x18000a128
1800038f7:     	andq	$-0x2, %rax
1800038fb:     	movl	$0x1, 0x680b(%rip)      # 0x18000a110
180003905:     	movl	$0x2, 0x6805(%rip)      # 0x18000a114
18000390f:     	movq	%rax, 0x6812(%rip)      # 0x18000a128
180003916:     	btl	$0x14, %edi
18000391a:     	jae	0x18000393b <numba_list_iter_next+0xcbb>
18000391c:     	andq	$-0x11, %rax
180003920:     	movl	$0x2, 0x67e6(%rip)      # 0x18000a110
18000392a:     	movq	%rax, 0x67f7(%rip)      # 0x18000a128
180003931:     	movl	$0x6, 0x67d9(%rip)      # 0x18000a114
18000393b:     	btl	$0x1b, %edi
18000393f:     	jae	0x180003a7c <numba_list_iter_next+0xdfc>
180003945:     	xorl	%ecx, %ecx
180003947:     	xgetbv
18000394a:     	shlq	$0x20, %rdx
18000394e:     	orq	%rax, %rdx
180003951:     	movq	%rdx, 0x20(%rsp)
180003956:     	btl	$0x1c, %edi
18000395a:     	jae	0x180003a60 <numba_list_iter_next+0xde0>
180003960:     	movq	0x20(%rsp), %rax
180003965:     	andb	$0x6, %al
180003967:     	cmpb	$0x6, %al
180003969:     	jne	0x180003a60 <numba_list_iter_next+0xde0>
18000396f:     	movl	0x679f(%rip), %eax      # 0x18000a114
180003975:     	movb	$-0x20, %dl
180003977:     	orl	$0x8, %eax
18000397a:     	movl	$0x3, 0x678c(%rip)      # 0x18000a110
180003984:     	movl	%eax, 0x678a(%rip)      # 0x18000a114
18000398a:     	testb	$0x20, %r10b
18000398e:     	je	0x1800039f2 <numba_list_iter_next+0xd72>
180003990:     	orl	$0x20, %eax
180003993:     	movl	$0x5, 0x6773(%rip)      # 0x18000a110
18000399d:     	movl	%eax, 0x6771(%rip)      # 0x18000a114
1800039a3:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
1800039a8:     	movq	0x6779(%rip), %rax      # 0x18000a128
1800039af:     	andl	%ecx, %r10d
1800039b2:     	andq	$-0x3, %rax
1800039b6:     	movq	%rax, 0x676b(%rip)      # 0x18000a128
1800039bd:     	cmpl	%ecx, %r10d
1800039c0:     	jne	0x1800039f9 <numba_list_iter_next+0xd79>
1800039c2:     	movq	0x20(%rsp), %rax
1800039c7:     	andb	%dl, %al
1800039c9:     	cmpb	%dl, %al
1800039cb:     	jne	0x1800039f2 <numba_list_iter_next+0xd72>
1800039cd:     	movq	0x6754(%rip), %rax      # 0x18000a128
1800039d4:     	orl	$0x40, 0x6739(%rip)     # 0x18000a114
1800039db:     	andq	$-0x25, %rax
1800039df:     	movl	$0x6, 0x6727(%rip)      # 0x18000a110
1800039e9:     	movq	%rax, 0x6738(%rip)      # 0x18000a128
1800039f0:     	jmp	0x1800039f9 <numba_list_iter_next+0xd79>
1800039f2:     	movq	0x672f(%rip), %rax      # 0x18000a128
1800039f9:     	btl	$0x17, %esi
1800039fd:     	jae	0x180003a0b <numba_list_iter_next+0xd8b>
1800039ff:     	btrq	$0x18, %rax
180003a04:     	movq	%rax, 0x671d(%rip)      # 0x18000a128
180003a0b:     	btl	$0x13, %r9d
180003a10:     	jae	0x180003a60 <numba_list_iter_next+0xde0>
180003a12:     	movq	0x20(%rsp), %rax
180003a17:     	andb	%dl, %al
180003a19:     	cmpb	%dl, %al
180003a1b:     	jne	0x180003a60 <numba_list_iter_next+0xde0>
180003a1d:     	movq	0x6704(%rip), %rdx      # 0x18000a128
180003a24:     	movl	%r11d, %eax
180003a27:     	shrq	$0x10, %rax
180003a2b:     	movl	%r11d, %ecx
180003a2e:     	andl	$0x6, %eax
180003a31:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180003a37:     	orq	$0x1000029, %rax        # imm = 0x1000029
180003a3d:     	movl	%ecx, 0x6fd5(%rip)      # 0x18000aa18
180003a43:     	notq	%rax
180003a46:     	andq	%rax, %rdx
180003a49:     	movq	%rdx, 0x66d8(%rip)      # 0x18000a128
180003a50:     	cmpb	$0x1, %cl
180003a53:     	jbe	0x180003a60 <numba_list_iter_next+0xde0>
180003a55:     	andq	$-0x41, %rdx
180003a59:     	movq	%rdx, 0x66c8(%rip)      # 0x18000a128
180003a60:     	btl	$0x15, %r9d
180003a65:     	jae	0x180003a7c <numba_list_iter_next+0xdfc>
180003a67:     	movq	0x20(%rsp), %rax
180003a6c:     	btq	$0x13, %rax
180003a71:     	jae	0x180003a7c <numba_list_iter_next+0xdfc>
180003a73:     	btrq	$0x7, 0x66ac(%rip)      # 0x18000a128
180003a7c:     	movq	0x28(%rsp), %rbx
180003a81:     	xorl	%eax, %eax
180003a83:     	movq	0x30(%rsp), %rbp
180003a88:     	movq	0x38(%rsp), %rsi
180003a8d:     	addq	$0x10, %rsp
180003a91:     	popq	%rdi
180003a92:     	retq
180003a93:     	int3
180003a94:     	movl	$0x1, %eax
180003a99:     	retq
180003a9a:     	int3
180003a9b:     	int3
180003a9c:     	xorl	%eax, %eax
180003a9e:     	cmpl	%eax, 0x668c(%rip)      # 0x18000a130
180003aa4:     	setne	%al
180003aa7:     	retq
180003aa8:     	int3
180003aa9:     	int3
180003aaa:     	int3
180003aab:     	int3
180003aac:     	int3
180003aad:     	int3
180003aae:     	int3
180003aaf:     	int3
180003ab0:     	jmpq	*0x592(%rip)            # 0x180004048
180003ab6:     	jmpq	*0x594(%rip)            # 0x180004050
180003abc:     	jmpq	*0x5ce(%rip)            # 0x180004090
180003ac2:     	jmpq	*0x5d0(%rip)            # 0x180004098
180003ac8:     	jmpq	*0x5d2(%rip)            # 0x1800040a0
180003ace:     	jmpq	*0x5d4(%rip)            # 0x1800040a8
180003ad4:     	jmpq	*0x5d6(%rip)            # 0x1800040b0
180003ada:     	jmpq	*0x5a0(%rip)            # 0x180004080
180003ae0:     	jmpq	*0x5d2(%rip)            # 0x1800040b8
180003ae6:     	jmpq	*0x59c(%rip)            # 0x180004088
180003aec:     	movb	$0x1, %al
180003aee:     	retq
180003aef:     	int3
180003af0:     	xorl	%eax, %eax
180003af2:     	retq
180003af3:     	jmpq	*0x53f(%rip)            # 0x180004038
180003af9:     	jmpq	*0x541(%rip)            # 0x180004040
180003aff:     	jmpq	*0x5c3(%rip)            # 0x1800040c8
180003b05:     	jmpq	*0x5c5(%rip)            # 0x1800040d0
180003b0b:     	int3
180003b0c:     	int3
180003b0d:     	int3
180003b0e:     	int3
180003b0f:     	int3
180003b10:     	int3
180003b11:     	int3
180003b12:     	int3
180003b13:     	int3
180003b14:     	int3
180003b15:     	int3
180003b16:     	nopw	(%rax,%rax)
180003b20:     	jmpq	*%rax
180003b22:     	int3
180003b23:     	int3
180003b24:     	int3
180003b25:     	int3
180003b26:     	int3
180003b27:     	int3
180003b28:     	int3
180003b29:     	int3
180003b2a:     	int3
180003b2b:     	int3
180003b2c:     	int3
180003b2d:     	int3
180003b2e:     	int3
180003b2f:     	int3
180003b30:     	int3
180003b31:     	int3
180003b32:     	int3
180003b33:     	int3
180003b34:     	int3
180003b35:     	int3
180003b36:     	nopw	(%rax,%rax)
180003b40:     	jmpq	*0x74a(%rip)            # 0x180004290
180003b46:     	pushq	%rbp
180003b48:     	subq	$0x20, %rsp
180003b4c:     	movq	%rdx, %rbp
180003b4f:     	movb	0x40(%rbp), %cl
180003b52:     	addq	$0x20, %rsp
180003b56:     	popq	%rbp
180003b57:     	jmp	0x18000371c <numba_list_iter_next+0xa9c>
180003b5c:     	int3
180003b5d:     	pushq	%rbp
180003b5f:     	subq	$0x20, %rsp
180003b63:     	movq	%rdx, %rbp
180003b66:     	movb	0x20(%rbp), %cl
180003b69:     	callq	0x18000371c <numba_list_iter_next+0xa9c>
180003b6e:     	nop
180003b6f:     	addq	$0x20, %rsp
180003b73:     	popq	%rbp
180003b74:     	retq
180003b75:     	int3
180003b76:     	pushq	%rbp
180003b78:     	subq	$0x20, %rsp
180003b7c:     	movq	%rdx, %rbp
180003b7f:     	addq	$0x20, %rsp
180003b83:     	popq	%rbp
180003b84:     	jmp	0x1800035a8 <numba_list_iter_next+0x928>
180003b89:     	int3
180003b8a:     	pushq	%rbp
180003b8c:     	subq	$0x30, %rsp
180003b90:     	movq	%rdx, %rbp
180003b93:     	movq	(%rcx), %rax
180003b96:     	movl	(%rax), %edx
180003b98:     	movq	%rcx, 0x28(%rsp)
180003b9d:     	movl	%edx, 0x20(%rsp)
180003ba1:     	leaq	-0xbc8(%rip), %r9       # 0x180002fe0 <numba_list_iter_next+0x360>
180003ba8:     	movq	0x70(%rbp), %r8
180003bac:     	movl	0x68(%rbp), %edx
180003baf:     	movq	0x60(%rbp), %rcx
180003bb3:     	callq	0x180003518 <numba_list_iter_next+0x898>
180003bb8:     	nop
180003bb9:     	addq	$0x30, %rsp
180003bbd:     	popq	%rbp
180003bbe:     	retq
180003bbf:     	int3
180003bc0:     	pushq	%rbp
180003bc2:     	movq	%rdx, %rbp
180003bc5:     	movq	(%rcx), %rax
180003bc8:     	xorl	%ecx, %ecx
180003bca:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180003bd0:     	sete	%cl
180003bd3:     	movl	%ecx, %eax
180003bd5:     	popq	%rbp
180003bd6:     	retq
180003bd7:     	int3
