
D:\Code\Datathon\recompyler-codex-20261111\wave8-native\results\cache\raytrace\current\recompyler\rcaotr_61fae00d4878711302f71448.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180008120 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0x8439(%rip), %rax      # 0x1800094c0
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	pushq	%r14
180001092:     	pushq	%rsi
180001093:     	pushq	%rdi
180001094:     	pushq	%rbx
180001095:     	subq	$0x58, %rsp
180001099:     	movq	%rcx, %rsi
18000109c:     	movq	0xe8(%rsp), %rax
1800010a4:     	movq	0xd0(%rsp), %rcx
1800010ac:     	movq	0xb8(%rsp), %r10
1800010b4:     	movq	0xa0(%rsp), %r11
1800010bc:     	movq	0xe0(%rsp), %rdi
1800010c4:     	movq	0xc8(%rsp), %rbx
1800010cc:     	movq	$0x0, 0x48(%rsp)
1800010d5:     	movq	0xb0(%rsp), %r14
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
18000110a:     	jne	0x18000117b <.text+0x17b>
18000110c:     	movq	%rdx, %rdi
18000110f:     	movq	0xf8(%rsp), %rcx
180001117:     	movq	0xf0(%rsp), %rdx
18000111f:     	movq	0xd8(%rsp), %r10
180001127:     	movq	0xc0(%rsp), %r11
18000112f:     	movq	0xa8(%rsp), %rax
180001137:     	movq	$0x0, 0x50(%rsp)
180001140:     	movq	%rcx, 0x40(%rsp)
180001145:     	movq	%rdx, 0x38(%rsp)
18000114a:     	movq	%r9, 0x30(%rsp)
18000114f:     	movq	%r10, 0x28(%rsp)
180001154:     	movq	%r11, 0x20(%rsp)
180001159:     	leaq	0x50(%rsp), %rcx
18000115e:     	leaq	0x48(%rsp), %rdx
180001163:     	movq	%rax, %r9
180001166:     	callq	0x1800019d0 <PyInit_rcaotr_61fae00d4878711302f71448+0x60>
18000116b:     	testl	%eax, %eax
18000116d:     	jne	0x180001194 <.text+0x194>
18000116f:     	movq	0x50(%rsp), %rax
180001174:     	movq	%rax, (%rsi)
180001177:     	xorl	%eax, %eax
180001179:     	jmp	0x18000118a <.text+0x18a>
18000117b:     	leaq	0x83fe(%rip), %rax      # 0x180009580
180001182:     	movq	%rax, (%rdx)
180001185:     	movl	$0x1, %eax
18000118a:     	addq	$0x58, %rsp
18000118e:     	popq	%rbx
18000118f:     	popq	%rdi
180001190:     	popq	%rsi
180001191:     	popq	%r14
180001193:     	retq
180001194:     	movq	0x48(%rsp), %rcx
180001199:     	movq	%rcx, (%rdi)
18000119c:     	jmp	0x18000118a <.text+0x18a>
18000119e:     	nop
1800011a0:     	pushq	%r15
1800011a2:     	pushq	%r14
1800011a4:     	pushq	%r13
1800011a6:     	pushq	%r12
1800011a8:     	pushq	%rsi
1800011a9:     	pushq	%rdi
1800011aa:     	pushq	%rbp
1800011ab:     	pushq	%rbx
1800011ac:     	subq	$0x218, %rsp            # imm = 0x218
1800011b3:     	movq	%rdx, %rcx
1800011b6:     	leaq	0xe0(%rsp), %rax
1800011be:     	movq	%rax, 0x48(%rsp)
1800011c3:     	leaq	0xe8(%rsp), %rax
1800011cb:     	movq	%rax, 0x40(%rsp)
1800011d0:     	leaq	0xf0(%rsp), %rax
1800011d8:     	movq	%rax, 0x38(%rsp)
1800011dd:     	leaq	0xf8(%rsp), %rax
1800011e5:     	movq	%rax, 0x30(%rsp)
1800011ea:     	leaq	0x100(%rsp), %rax
1800011f2:     	movq	%rax, 0x28(%rsp)
1800011f7:     	leaq	0x108(%rsp), %rax
1800011ff:     	movq	%rax, 0x20(%rsp)
180001204:     	leaq	0x839d(%rip), %rdx      # 0x1800095a8
18000120b:     	movl	$0x6, %r8d
180001211:     	movl	$0x6, %r9d
180001217:     	callq	0x1800082d1 <numba_list_iter_next+0x311>
18000121c:     	testl	%eax, %eax
18000121e:     	movq	$0x0, 0x98(%rsp)
18000122a:     	je	0x1800016f7 <.text+0x6f7>
180001230:     	cmpq	$0x0, 0xfa58(%rip)      # 0x180010c90
180001238:     	je	0x180001627 <.text+0x627>
18000123e:     	movq	0x108(%rsp), %rcx
180001246:     	xorps	%xmm0, %xmm0
180001249:     	movaps	%xmm0, 0x1d0(%rsp)
180001251:     	movaps	%xmm0, 0x1e0(%rsp)
180001259:     	movaps	%xmm0, 0x1f0(%rsp)
180001261:     	movq	$0x0, 0x200(%rsp)
18000126d:     	leaq	0x1d0(%rsp), %rdx
180001275:     	callq	0x180006f90 <PyInit_rcaotr_61fae00d4878711302f71448+0x5620>
18000127a:     	testl	%eax, %eax
18000127c:     	jne	0x18000163f <.text+0x63f>
180001282:     	cmpq	$0x8, 0x1e8(%rsp)
18000128b:     	jne	0x18000163f <.text+0x63f>
180001291:     	movq	0x1d0(%rsp), %rsi
180001299:     	movq	0x1f0(%rsp), %rdi
1800012a1:     	movq	0x1f8(%rsp), %rbx
1800012a9:     	movq	0x200(%rsp), %r15
1800012b1:     	movq	0x100(%rsp), %rcx
1800012b9:     	xorps	%xmm0, %xmm0
1800012bc:     	movaps	%xmm0, 0x190(%rsp)
1800012c4:     	movaps	%xmm0, 0x1a0(%rsp)
1800012cc:     	movaps	%xmm0, 0x1b0(%rsp)
1800012d4:     	movq	$0x0, 0x1c0(%rsp)
1800012e0:     	leaq	0x190(%rsp), %rdx
1800012e8:     	callq	0x180006f90 <PyInit_rcaotr_61fae00d4878711302f71448+0x5620>
1800012ed:     	testl	%eax, %eax
1800012ef:     	jne	0x180001657 <.text+0x657>
1800012f5:     	cmpq	$0x8, 0x1a8(%rsp)
1800012fe:     	jne	0x180001657 <.text+0x657>
180001304:     	movq	0x190(%rsp), %r14
18000130c:     	movq	0x1b0(%rsp), %r13
180001314:     	movq	0x1b8(%rsp), %rbp
18000131c:     	movq	0x1c0(%rsp), %r12
180001324:     	movq	0xf8(%rsp), %rcx
18000132c:     	xorps	%xmm0, %xmm0
18000132f:     	movaps	%xmm0, 0x150(%rsp)
180001337:     	movaps	%xmm0, 0x160(%rsp)
18000133f:     	movaps	%xmm0, 0x170(%rsp)
180001347:     	movq	$0x0, 0x180(%rsp)
180001353:     	leaq	0x150(%rsp), %rdx
18000135b:     	callq	0x180006f90 <PyInit_rcaotr_61fae00d4878711302f71448+0x5620>
180001360:     	testl	%eax, %eax
180001362:     	jne	0x18000166f <.text+0x66f>
180001368:     	cmpq	$0x8, 0x168(%rsp)
180001371:     	jne	0x18000166f <.text+0x66f>
180001377:     	movq	%r12, 0xd8(%rsp)
18000137f:     	movq	0x150(%rsp), %r12
180001387:     	movq	0x170(%rsp), %rax
18000138f:     	movq	%rax, 0xd0(%rsp)
180001397:     	movq	0x178(%rsp), %rax
18000139f:     	movq	%rax, 0xc8(%rsp)
1800013a7:     	movq	0x180(%rsp), %rax
1800013af:     	movq	%rax, 0xc0(%rsp)
1800013b7:     	movq	0xf0(%rsp), %rcx
1800013bf:     	xorps	%xmm0, %xmm0
1800013c2:     	movaps	%xmm0, 0x110(%rsp)
1800013ca:     	movaps	%xmm0, 0x120(%rsp)
1800013d2:     	movaps	%xmm0, 0x130(%rsp)
1800013da:     	movq	$0x0, 0x140(%rsp)
1800013e6:     	leaq	0x110(%rsp), %rdx
1800013ee:     	callq	0x180006f90 <PyInit_rcaotr_61fae00d4878711302f71448+0x5620>
1800013f3:     	testl	%eax, %eax
1800013f5:     	jne	0x180001684 <.text+0x684>
1800013fb:     	cmpq	$0x1, 0x128(%rsp)
180001404:     	jne	0x180001684 <.text+0x684>
18000140a:     	movq	%rbp, 0xa0(%rsp)
180001412:     	movq	%r13, 0xa8(%rsp)
18000141a:     	movq	%r12, 0x88(%rsp)
180001422:     	movq	%r15, 0xb0(%rsp)
18000142a:     	movq	%rdi, 0xb8(%rsp)
180001432:     	movq	0x110(%rsp), %rax
18000143a:     	movq	%rax, 0x80(%rsp)
180001442:     	movq	0x130(%rsp), %rdi
18000144a:     	movq	0x138(%rsp), %r12
180001452:     	movq	0x140(%rsp), %r15
18000145a:     	movq	0xe8(%rsp), %rcx
180001462:     	callq	0x1800082d7 <numba_list_iter_next+0x317>
180001467:     	testq	%rax, %rax
18000146a:     	movq	%r14, 0x90(%rsp)
180001472:     	je	0x180001699 <.text+0x699>
180001478:     	movq	%rax, %rbp
18000147b:     	movq	%rax, %rcx
18000147e:     	callq	0x1800082dd <numba_list_iter_next+0x31d>
180001483:     	movq	%rax, %r13
180001486:     	movq	%rbp, %rcx
180001489:     	callq	0x1800082e3 <numba_list_iter_next+0x323>
18000148e:     	movq	%rbx, %r14
180001491:     	callq	0x1800082e9 <numba_list_iter_next+0x329>
180001496:     	testq	%rax, %rax
180001499:     	jne	0x1800016c2 <.text+0x6c2>
18000149f:     	movq	%rsi, %rbx
1800014a2:     	movq	0xe0(%rsp), %rcx
1800014aa:     	callq	0x1800082d7 <numba_list_iter_next+0x317>
1800014af:     	testq	%rax, %rax
1800014b2:     	je	0x1800016af <.text+0x6af>
1800014b8:     	movq	%rax, %rsi
1800014bb:     	movq	%rax, %rcx
1800014be:     	callq	0x1800082dd <numba_list_iter_next+0x31d>
1800014c3:     	movq	%rax, %rbp
1800014c6:     	movq	%rsi, %rcx
1800014c9:     	callq	0x1800082e3 <numba_list_iter_next+0x323>
1800014ce:     	callq	0x1800082e9 <numba_list_iter_next+0x329>
1800014d3:     	testq	%rax, %rax
1800014d6:     	movq	%rbx, %rsi
1800014d9:     	jne	0x1800016c2 <.text+0x6c2>
1800014df:     	movq	%rbp, 0x78(%rsp)
1800014e4:     	movq	%r13, 0x70(%rsp)
1800014e9:     	movq	%r15, 0x68(%rsp)
1800014ee:     	movq	%r12, 0x60(%rsp)
1800014f3:     	movq	%rdi, 0x58(%rsp)
1800014f8:     	movq	0xc0(%rsp), %rax
180001500:     	movq	%rax, 0x50(%rsp)
180001505:     	movq	0xc8(%rsp), %rax
18000150d:     	movq	%rax, 0x48(%rsp)
180001512:     	movq	0xd0(%rsp), %rax
18000151a:     	movq	%rax, 0x40(%rsp)
18000151f:     	movq	0xd8(%rsp), %rax
180001527:     	movq	%rax, 0x38(%rsp)
18000152c:     	movq	0xa0(%rsp), %rax
180001534:     	movq	%rax, 0x30(%rsp)
180001539:     	movq	0xa8(%rsp), %rax
180001541:     	movq	%rax, 0x28(%rsp)
180001546:     	movq	0xb0(%rsp), %rax
18000154e:     	movq	%rax, 0x20(%rsp)
180001553:     	leaq	0x210(%rsp), %rcx
18000155b:     	leaq	0x98(%rsp), %rdx
180001563:     	movq	0xb8(%rsp), %r8
18000156b:     	movq	%r14, %r9
18000156e:     	callq	0x180001090 <.text+0x90>
180001573:     	movl	%eax, %ebp
180001575:     	movq	0x98(%rsp), %rbx
18000157d:     	movq	%rsi, %rcx
180001580:     	callq	0x180001060 <.text+0x60>
180001585:     	movq	0x90(%rsp), %rcx
18000158d:     	callq	0x180001060 <.text+0x60>
180001592:     	movq	0x88(%rsp), %rcx
18000159a:     	callq	0x180001060 <.text+0x60>
18000159f:     	movq	0x80(%rsp), %rcx
1800015a7:     	callq	0x180001060 <.text+0x60>
1800015ac:     	testl	%ebp, %ebp
1800015ae:     	jne	0x1800015d6 <.text+0x5d6>
1800015b0:     	movq	0x7d29(%rip), %rsi      # 0x1800092e0
1800015b7:     	movq	%rsi, %rcx
1800015ba:     	callq	0x1800082ef <numba_list_iter_next+0x32f>
1800015bf:     	movq	%rsi, %rax
1800015c2:     	addq	$0x218, %rsp            # imm = 0x218
1800015c9:     	popq	%rbx
1800015ca:     	popq	%rbp
1800015cb:     	popq	%rdi
1800015cc:     	popq	%rsi
1800015cd:     	popq	%r12
1800015cf:     	popq	%r13
1800015d1:     	popq	%r14
1800015d3:     	popq	%r15
1800015d5:     	retq
1800015d6:     	jle	0x1800016fe <.text+0x6fe>
1800015dc:     	callq	0x1800082f5 <numba_list_iter_next+0x335>
1800015e1:     	movl	0x8(%rbx), %edx
1800015e4:     	movq	(%rbx), %rcx
1800015e7:     	cmpl	$0x0, 0x20(%rbx)
1800015eb:     	jle	0x18000171d <.text+0x71d>
1800015f1:     	movslq	%edx, %rdx
1800015f4:     	callq	0x1800082fb <numba_list_iter_next+0x33b>
1800015f9:     	movq	%rax, %rsi
1800015fc:     	movq	0x10(%rbx), %rcx
180001600:     	callq	*0x18(%rbx)
180001603:     	testq	%rax, %rax
180001606:     	je	0x180001746 <.text+0x746>
18000160c:     	movq	%rsi, %rcx
18000160f:     	movq	%rax, %rdx
180001612:     	callq	0x1800067a0 <PyInit_rcaotr_61fae00d4878711302f71448+0x4e30>
180001617:     	movq	%rax, %rsi
18000161a:     	movq	%rbx, %rcx
18000161d:     	callq	0x180008230 <numba_list_iter_next+0x270>
180001622:     	jmp	0x180001729 <.text+0x729>
180001627:     	movq	0x7c92(%rip), %rcx      # 0x1800092c0
18000162e:     	leaq	0x7f8b(%rip), %rdx      # 0x1800095c0
180001635:     	callq	0x180008301 <numba_list_iter_next+0x341>
18000163a:     	jmp	0x1800016f7 <.text+0x6f7>
18000163f:     	movq	0x7c6a(%rip), %rcx      # 0x1800092b0
180001646:     	leaq	0x8063(%rip), %rdx      # 0x1800096b0
18000164d:     	callq	0x180008301 <numba_list_iter_next+0x341>
180001652:     	jmp	0x1800016f7 <.text+0x6f7>
180001657:     	movq	0x7c52(%rip), %rcx      # 0x1800092b0
18000165e:     	leaq	0x804b(%rip), %rdx      # 0x1800096b0
180001665:     	callq	0x180008301 <numba_list_iter_next+0x341>
18000166a:     	jmp	0x1800016ef <.text+0x6ef>
18000166f:     	movq	0x7c3a(%rip), %rcx      # 0x1800092b0
180001676:     	leaq	0x8033(%rip), %rdx      # 0x1800096b0
18000167d:     	callq	0x180008301 <numba_list_iter_next+0x341>
180001682:     	jmp	0x1800016e7 <.text+0x6e7>
180001684:     	movq	0x7c25(%rip), %rcx      # 0x1800092b0
18000168b:     	leaq	0x801e(%rip), %rdx      # 0x1800096b0
180001692:     	callq	0x180008301 <numba_list_iter_next+0x341>
180001697:     	jmp	0x1800016df <.text+0x6df>
180001699:     	xorl	%r13d, %r13d
18000169c:     	movq	%rbx, %r14
18000169f:     	callq	0x1800082e9 <numba_list_iter_next+0x329>
1800016a4:     	testq	%rax, %rax
1800016a7:     	je	0x18000149f <.text+0x49f>
1800016ad:     	jmp	0x1800016c2 <.text+0x6c2>
1800016af:     	xorl	%ebp, %ebp
1800016b1:     	callq	0x1800082e9 <numba_list_iter_next+0x329>
1800016b6:     	testq	%rax, %rax
1800016b9:     	movq	%rbx, %rsi
1800016bc:     	je	0x1800014df <.text+0x4df>
1800016c2:     	movq	0x80(%rsp), %rcx
1800016ca:     	callq	0x180001060 <.text+0x60>
1800016cf:     	movq	0x90(%rsp), %r14
1800016d7:     	movq	0x88(%rsp), %r12
1800016df:     	movq	%r12, %rcx
1800016e2:     	callq	0x180001060 <.text+0x60>
1800016e7:     	movq	%r14, %rcx
1800016ea:     	callq	0x180001060 <.text+0x60>
1800016ef:     	movq	%rsi, %rcx
1800016f2:     	callq	0x180001060 <.text+0x60>
1800016f7:     	xorl	%esi, %esi
1800016f9:     	jmp	0x1800015bf <.text+0x5bf>
1800016fe:     	cmpl	$-0x3, %ebp
180001701:     	je	0x180001738 <.text+0x738>
180001703:     	cmpl	$-0x1, %ebp
180001706:     	je	0x1800016f7 <.text+0x6f7>
180001708:     	movq	0x7b99(%rip), %rcx      # 0x1800092a8
18000170f:     	leaq	0x803a(%rip), %rdx      # 0x180009750
180001716:     	callq	0x180008301 <numba_list_iter_next+0x341>
18000171b:     	jmp	0x1800016f7 <.text+0x6f7>
18000171d:     	movq	0x10(%rbx), %r8
180001721:     	callq	0x1800066c0 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d50>
180001726:     	movq	%rax, %rsi
180001729:     	testq	%rsi, %rsi
18000172c:     	je	0x1800016f7 <.text+0x6f7>
18000172e:     	movq	%rsi, %rcx
180001731:     	callq	0x180006260 <PyInit_rcaotr_61fae00d4878711302f71448+0x48f0>
180001736:     	jmp	0x1800016f7 <.text+0x6f7>
180001738:     	movq	0x7b61(%rip), %rcx      # 0x1800092a0
18000173f:     	callq	0x180008307 <numba_list_iter_next+0x347>
180001744:     	jmp	0x1800016f7 <.text+0x6f7>
180001746:     	movq	0x7b73(%rip), %rcx      # 0x1800092c0
18000174d:     	leaq	0x7fbc(%rip), %rdx      # 0x180009710
180001754:     	callq	0x180008301 <numba_list_iter_next+0x341>
180001759:     	jmp	0x1800016f7 <.text+0x6f7>
18000175b:     	nopl	(%rax,%rax)
180001760:     	pushq	%r15
180001762:     	pushq	%r14
180001764:     	pushq	%r13
180001766:     	pushq	%r12
180001768:     	pushq	%rsi
180001769:     	pushq	%rdi
18000176a:     	pushq	%rbx
18000176b:     	subq	$0xa0, %rsp
180001772:     	movq	0x100(%rsp), %r8
18000177a:     	movq	0x108(%rsp), %r9
180001782:     	movq	0x110(%rsp), %rax
18000178a:     	movq	0x138(%rsp), %rcx
180001792:     	movq	0x140(%rsp), %rdx
18000179a:     	movq	0x148(%rsp), %r10
1800017a2:     	movq	0x170(%rsp), %r11
1800017aa:     	movq	0x178(%rsp), %rsi
1800017b2:     	movq	0x180(%rsp), %rdi
1800017ba:     	movq	0x1a8(%rsp), %rbx
1800017c2:     	movq	0x1b0(%rsp), %r14
1800017ca:     	movq	0x1b8(%rsp), %r15
1800017d2:     	movq	0x1c0(%rsp), %r12
1800017da:     	movq	0x1c8(%rsp), %r13
1800017e2:     	movq	$0x0, 0x98(%rsp)
1800017ee:     	movq	$0x0, 0x90(%rsp)
1800017fa:     	movq	%r13, 0x78(%rsp)
1800017ff:     	movq	%r12, 0x70(%rsp)
180001804:     	movq	%r15, 0x68(%rsp)
180001809:     	movq	%r14, 0x60(%rsp)
18000180e:     	movq	%rbx, 0x58(%rsp)
180001813:     	movq	%rdi, 0x50(%rsp)
180001818:     	movq	%rsi, 0x48(%rsp)
18000181d:     	movq	%r11, 0x40(%rsp)
180001822:     	movq	%r10, 0x38(%rsp)
180001827:     	movq	%rdx, 0x30(%rsp)
18000182c:     	movq	%rcx, 0x28(%rsp)
180001831:     	movq	%rax, 0x20(%rsp)
180001836:     	leaq	0x98(%rsp), %rcx
18000183e:     	leaq	0x90(%rsp), %rdx
180001846:     	callq	0x180001090 <.text+0x90>
18000184b:     	movl	%eax, %edx
18000184d:     	movq	0x90(%rsp), %rsi
180001855:     	movq	0x98(%rsp), %rax
18000185d:     	movl	$0x0, 0x8c(%rsp)
180001868:     	testl	%edx, %edx
18000186a:     	jne	0x18000187f <.text+0x87f>
18000186c:     	addq	$0xa0, %rsp
180001873:     	popq	%rbx
180001874:     	popq	%rdi
180001875:     	popq	%rsi
180001876:     	popq	%r12
180001878:     	popq	%r13
18000187a:     	popq	%r14
18000187c:     	popq	%r15
18000187e:     	retq
18000187f:     	movq	%rax, %rbx
180001882:     	leaq	0x8c(%rsp), %rcx
18000188a:     	movl	%edx, %edi
18000188c:     	callq	0x180006230 <PyInit_rcaotr_61fae00d4878711302f71448+0x48c0>
180001891:     	testl	%edi, %edi
180001893:     	jle	0x1800018d9 <.text+0x8d9>
180001895:     	callq	0x1800082f5 <numba_list_iter_next+0x335>
18000189a:     	movl	0x8(%rsi), %edx
18000189d:     	movq	(%rsi), %rcx
1800018a0:     	cmpl	$0x0, 0x20(%rsi)
1800018a4:     	jle	0x1800018fa <.text+0x8fa>
1800018a6:     	movslq	%edx, %rdx
1800018a9:     	callq	0x1800082fb <numba_list_iter_next+0x33b>
1800018ae:     	movq	%rax, %rdi
1800018b1:     	movq	0x10(%rsi), %rcx
1800018b5:     	callq	*0x18(%rsi)
1800018b8:     	testq	%rax, %rax
1800018bb:     	je	0x180001955 <.text+0x955>
1800018c1:     	movq	%rdi, %rcx
1800018c4:     	movq	%rax, %rdx
1800018c7:     	callq	0x1800067a0 <PyInit_rcaotr_61fae00d4878711302f71448+0x4e30>
1800018cc:     	movq	%rax, %rdi
1800018cf:     	movq	%rsi, %rcx
1800018d2:     	callq	0x180008230 <numba_list_iter_next+0x270>
1800018d7:     	jmp	0x180001906 <.text+0x906>
1800018d9:     	movl	%edi, %eax
1800018db:     	cmpl	$-0x3, %edi
1800018de:     	je	0x180001947 <.text+0x947>
1800018e0:     	cmpl	$-0x1, %eax
1800018e3:     	je	0x180001913 <.text+0x913>
1800018e5:     	movq	0x79bc(%rip), %rcx      # 0x1800092a8
1800018ec:     	leaq	0x7ecd(%rip), %rdx      # 0x1800097c0
1800018f3:     	callq	0x180008301 <numba_list_iter_next+0x341>
1800018f8:     	jmp	0x180001913 <.text+0x913>
1800018fa:     	movq	0x10(%rsi), %r8
1800018fe:     	callq	0x1800066c0 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d50>
180001903:     	movq	%rax, %rdi
180001906:     	testq	%rdi, %rdi
180001909:     	je	0x180001913 <.text+0x913>
18000190b:     	movq	%rdi, %rcx
18000190e:     	callq	0x180006260 <PyInit_rcaotr_61fae00d4878711302f71448+0x48f0>
180001913:     	leaq	0x7ed6(%rip), %rcx      # 0x1800097f0
18000191a:     	callq	0x18000830d <numba_list_iter_next+0x34d>
18000191f:     	movq	%rax, %rsi
180001922:     	movq	%rax, %rcx
180001925:     	callq	0x180008313 <numba_list_iter_next+0x353>
18000192a:     	movq	%rsi, %rcx
18000192d:     	callq	0x1800082e3 <numba_list_iter_next+0x323>
180001932:     	leaq	0x8c(%rsp), %rcx
18000193a:     	callq	0x180006250 <PyInit_rcaotr_61fae00d4878711302f71448+0x48e0>
18000193f:     	movq	%rbx, %rax
180001942:     	jmp	0x18000186c <.text+0x86c>
180001947:     	movq	0x7952(%rip), %rcx      # 0x1800092a0
18000194e:     	callq	0x180008307 <numba_list_iter_next+0x347>
180001953:     	jmp	0x180001913 <.text+0x913>
180001955:     	movq	0x7964(%rip), %rcx      # 0x1800092c0
18000195c:     	leaq	0x7e1d(%rip), %rdx      # 0x180009780
180001963:     	callq	0x180008301 <numba_list_iter_next+0x341>
180001968:     	xorl	%eax, %eax
18000196a:     	jmp	0x18000186c <.text+0x86c>
18000196f:     	nop

0000000180001970 <PyInit_rcaotr_61fae00d4878711302f71448>:
180001970:     	pushq	%rsi
180001971:     	subq	$0x20, %rsp
180001975:     	leaq	0xe6c4(%rip), %rcx      # 0x180010040
18000197c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001981:     	callq	0x180008319 <numba_list_iter_next+0x359>
180001986:     	testq	%rax, %rax
180001989:     	je	0x1800019bb <PyInit_rcaotr_61fae00d4878711302f71448+0x4b>
18000198b:     	leaq	0xe66e(%rip), %rdx      # 0x180010000
180001992:     	leaq	0x7ec7(%rip), %r8       # 0x180009860
180001999:     	leaq	0x7fb0(%rip), %r9       # 0x180009950
1800019a0:     	movq	%rax, %rcx
1800019a3:     	movq	%rax, %rsi
1800019a6:     	callq	0x180007200 <PyInit_rcaotr_61fae00d4878711302f71448+0x5890>
1800019ab:     	movl	%eax, %ecx
1800019ad:     	xorl	%eax, %eax
1800019af:     	testl	%ecx, %ecx
1800019b1:     	cmoveq	%rsi, %rax
1800019b5:     	addq	$0x20, %rsp
1800019b9:     	popq	%rsi
1800019ba:     	retq
1800019bb:     	xorl	%eax, %eax
1800019bd:     	addq	$0x20, %rsp
1800019c1:     	popq	%rsi
1800019c2:     	retq
1800019c3:     	nopw	%cs:(%rax,%rax)
1800019cd:     	nopl	(%rax)
1800019d0:     	pushq	%r15
1800019d2:     	pushq	%r14
1800019d4:     	pushq	%r13
1800019d6:     	pushq	%r12
1800019d8:     	pushq	%rsi
1800019d9:     	pushq	%rdi
1800019da:     	pushq	%rbp
1800019db:     	pushq	%rbx
1800019dc:     	subq	$0x1e8, %rsp            # imm = 0x1E8
1800019e3:     	movapd	%xmm15, 0x1d0(%rsp)
1800019ed:     	movapd	%xmm14, 0x1c0(%rsp)
1800019f7:     	movapd	%xmm13, 0x1b0(%rsp)
180001a01:     	movapd	%xmm12, 0x1a0(%rsp)
180001a0b:     	movapd	%xmm11, 0x190(%rsp)
180001a15:     	movapd	%xmm10, 0x180(%rsp)
180001a1f:     	movapd	%xmm9, 0x170(%rsp)
180001a29:     	movapd	%xmm8, 0x160(%rsp)
180001a33:     	movapd	%xmm7, 0x150(%rsp)
180001a3c:     	movaps	%xmm6, 0x140(%rsp)
180001a44:     	movq	%r9, %rbx
180001a47:     	movq	%r8, %r14
180001a4a:     	movq	%rdx, %rdi
180001a4d:     	movq	%rcx, %rsi
180001a50:     	movq	0x268(%rsp), %r15
180001a58:     	movq	0x258(%rsp), %r13
180001a60:     	movq	0x250(%rsp), %rbp
180001a68:     	movq	$0x0, 0xb0(%rsp)
180001a74:     	movb	$0x0, 0xb8(%rsp)
180001a7c:     	movq	$0x0, 0xc0(%rsp)
180001a88:     	movb	$0x0, 0xc8(%rsp)
180001a90:     	movq	$0x0, 0xd0(%rsp)
180001a9c:     	movb	$0x0, 0xd8(%rsp)
180001aa4:     	movq	$0x0, 0xe0(%rsp)
180001ab0:     	movb	$0x0, 0xe8(%rsp)
180001ab8:     	movq	$0x0, 0xf0(%rsp)
180001ac4:     	movb	$0x0, 0xf8(%rsp)
180001acc:     	movq	$0x0, 0x100(%rsp)
180001ad8:     	movb	$0x0, 0x108(%rsp)
180001ae0:     	movq	$0x0, 0x138(%rsp)
180001aec:     	xorps	%xmm6, %xmm6
180001aef:     	cvtsi2sdq	(%r9,%r15,8), %xmm6
180001af5:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b0
180001afd:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b8
180001b05:     	divsd	0x78b3(%rip), %xmm6     # 0x1800093c0
180001b0d:     	movapd	%xmm6, %xmm0
180001b11:     	callq	0x180008e3c <numba_list_iter_next+0xe7c>
180001b16:     	ucomisd	%xmm0, %xmm0
180001b1a:     	jp	0x180001b70 <PyInit_rcaotr_61fae00d4878711302f71448+0x200>
180001b1c:     	movq	%xmm0, %rax
180001b21:     	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
180001b2b:     	andq	%rcx, %rax
180001b2e:     	movabsq	$0x7ff0000000000000, %rdx # imm = 0x7FF0000000000000
180001b38:     	cmpq	%rdx, %rax
180001b3b:     	setne	%al
180001b3e:     	movq	%xmm6, %r8
180001b43:     	andq	%rcx, %r8
180001b46:     	cmpq	%rdx, %r8
180001b49:     	sete	%cl
180001b4c:     	orb	%al, %cl
180001b4e:     	je	0x180001b70 <PyInit_rcaotr_61fae00d4878711302f71448+0x200>
180001b50:     	movq	0x270(%rsp), %r12
180001b58:     	movq	0x10(%rbx,%r12,8), %rcx
180001b5d:     	movq	%rcx, %rax
180001b60:     	negq	%rax
180001b63:     	jno	0x180001bf2 <PyInit_rcaotr_61fae00d4878711302f71448+0x282>
180001b69:     	movb	$0x1, (%r13)
180001b6e:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001b70:     	movb	$0x1, (%r13)
180001b75:     	movq	$0x3, 0x18(%rbp)
180001b7d:     	xorl	%eax, %eax
180001b7f:     	movq	$0x0, (%rsi)
180001b86:     	movaps	0x140(%rsp), %xmm6
180001b8e:     	movaps	0x150(%rsp), %xmm7
180001b96:     	movaps	0x160(%rsp), %xmm8
180001b9f:     	movaps	0x170(%rsp), %xmm9
180001ba8:     	movaps	0x180(%rsp), %xmm10
180001bb1:     	movaps	0x190(%rsp), %xmm11
180001bba:     	movaps	0x1a0(%rsp), %xmm12
180001bc3:     	movaps	0x1b0(%rsp), %xmm13
180001bcc:     	movaps	0x1c0(%rsp), %xmm14
180001bd5:     	movaps	0x1d0(%rsp), %xmm15
180001bde:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180001be5:     	popq	%rbx
180001be6:     	popq	%rbp
180001be7:     	popq	%rdi
180001be8:     	popq	%rsi
180001be9:     	popq	%r12
180001beb:     	popq	%r13
180001bed:     	popq	%r14
180001bef:     	popq	%r15
180001bf1:     	retq
180001bf2:     	xorl	%eax, %eax
180001bf4:     	cmpb	$0x0, (%r13)
180001bf9:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001bfb:     	decq	%rcx
180001bfe:     	je	0x180001c1e <PyInit_rcaotr_61fae00d4878711302f71448+0x2ae>
180001c00:     	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
180001c0a:     	movq	0x8(%rbx,%r12,8), %rdx
180001c0f:     	cmpq	%r8, %rdx
180001c12:     	jne	0x180001c30 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c0>
180001c14:     	movb	$0x1, (%r13)
180001c19:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001c1e:     	movb	$0x1, (%r13)
180001c23:     	movq	$0x7, 0x18(%rbp)
180001c2b:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001c30:     	decq	%rdx
180001c33:     	je	0x180001d65 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f5>
180001c39:     	movq	0x260(%rsp), %r11
180001c41:     	movq	0x10(%rbx,%r15,8), %r8
180001c46:     	movq	0x20(%rbx,%r15,8), %r9
180001c4b:     	movsd	(%r14,%r8,8), %xmm1
180001c51:     	subsd	(%r14,%r9,8), %xmm1
180001c57:     	movapd	0x7771(%rip), %xmm2     # 0x1800093d0
180001c5f:     	andpd	%xmm1, %xmm2
180001c63:     	ucomisd	0x7775(%rip), %xmm2     # 0x1800093e0
180001c6b:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001c71:     	movsd	0x10(%r14,%r8,8), %xmm2
180001c78:     	subsd	0x10(%r14,%r9,8), %xmm2
180001c7f:     	movapd	0x7749(%rip), %xmm3     # 0x1800093d0
180001c87:     	andpd	%xmm2, %xmm3
180001c8b:     	ucomisd	0x774d(%rip), %xmm3     # 0x1800093e0
180001c93:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001c99:     	movsd	0x20(%r14,%r8,8), %xmm3
180001ca0:     	subsd	0x20(%r14,%r9,8), %xmm3
180001ca7:     	movapd	0x7721(%rip), %xmm4     # 0x1800093d0
180001caf:     	andpd	%xmm3, %xmm4
180001cb3:     	ucomisd	0x7725(%rip), %xmm4     # 0x1800093e0
180001cbb:     	jae	0x180001d1f <PyInit_rcaotr_61fae00d4878711302f71448+0x3af>
180001cbd:     	movq	(%rbp), %r10
180001cc1:     	leaq	0x6(%r10), %r8
180001cc5:     	cmpq	%r11, %r8
180001cc8:     	jg	0x180001d5b <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb>
180001cce:     	movq	%r8, (%rbp)
180001cd2:     	cmpb	$0x0, (%r13)
180001cd7:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001cdd:     	movsd	%xmm1, (%r14,%r10,8)
180001ce3:     	movsd	%xmm2, 0x10(%r14,%r10,8)
180001cea:     	movsd	%xmm3, 0x20(%r14,%r10,8)
180001cf1:     	movq	%r10, 0x78(%rsp)
180001cf6:     	movzbl	(%r13), %r10d
180001cfb:     	xorl	%r8d, %r8d
180001cfe:     	movl	%r10d, %r11d
180001d01:     	negb	%r11b
180001d04:     	movq	0x260(%rsp), %r11
180001d0c:     	sbbq	%r8, %r8
180001d0f:     	orq	0x78(%rsp), %r8
180001d14:     	testb	%r10b, %r10b
180001d17:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d1d:     	jmp	0x180001d41 <PyInit_rcaotr_61fae00d4878711302f71448+0x3d1>
180001d1f:     	movb	$0x1, (%r13)
180001d24:     	movq	$0xf4243, 0x18(%rbp)    # imm = 0xF4243
180001d2c:     	movzbl	(%r13), %r10d
180001d31:     	movq	$-0x1, %r8
180001d38:     	testb	%r10b, %r10b
180001d3b:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d41:     	movq	%r8, 0x78(%rsp)
180001d46:     	movq	(%rbp), %r8
180001d4a:     	movq	%r8, 0x80(%rsp)
180001d52:     	leaq	0x2(%r8), %r10
180001d56:     	cmpq	%r11, %r10
180001d59:     	jle	0x180001d77 <PyInit_rcaotr_61fae00d4878711302f71448+0x407>
180001d5b:     	movb	$0x2, (%r13)
180001d60:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d65:     	movb	$0x1, (%r13)
180001d6a:     	movq	$0x8, 0x18(%rbp)
180001d72:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d77:     	movq	%r10, (%rbp)
180001d7b:     	cmpb	$0x0, (%r13)
180001d80:     	movq	0x78(%rsp), %r8
180001d85:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001d8b:     	movq	0x80(%rsp), %r10
180001d93:     	movq	%r9, (%rbx,%r10,8)
180001d97:     	cmpb	$0x0, (%r13)
180001d9c:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001da2:     	movsd	(%r14,%r8,8), %xmm1
180001da8:     	mulsd	%xmm1, %xmm1
180001dac:     	movapd	0x761c(%rip), %xmm2     # 0x1800093d0
180001db4:     	andpd	%xmm1, %xmm2
180001db8:     	ucomisd	0x7620(%rip), %xmm2     # 0x1800093e0
180001dc0:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001dc2:     	movsd	0x10(%r14,%r8,8), %xmm2
180001dc9:     	mulsd	%xmm2, %xmm2
180001dcd:     	movapd	0x75fb(%rip), %xmm3     # 0x1800093d0
180001dd5:     	andpd	%xmm2, %xmm3
180001dd9:     	ucomisd	0x75ff(%rip), %xmm3     # 0x1800093e0
180001de1:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001de3:     	addsd	%xmm2, %xmm1
180001de7:     	movapd	0x75e1(%rip), %xmm2     # 0x1800093d0
180001def:     	andpd	%xmm1, %xmm2
180001df3:     	ucomisd	0x75e5(%rip), %xmm2     # 0x1800093e0
180001dfb:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001dfd:     	movsd	0x20(%r14,%r8,8), %xmm2
180001e04:     	mulsd	%xmm2, %xmm2
180001e08:     	movapd	0x75c0(%rip), %xmm3     # 0x1800093d0
180001e10:     	andpd	%xmm2, %xmm3
180001e14:     	ucomisd	0x75c4(%rip), %xmm3     # 0x1800093e0
180001e1c:     	jae	0x180001e38 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c8>
180001e1e:     	addsd	%xmm2, %xmm1
180001e22:     	movapd	0x75a6(%rip), %xmm2     # 0x1800093d0
180001e2a:     	andpd	%xmm1, %xmm2
180001e2e:     	ucomisd	0x75aa(%rip), %xmm2     # 0x1800093e0
180001e36:     	jb	0x180001e49 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d9>
180001e38:     	movb	$0x1, (%r13)
180001e3d:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001e45:     	xorpd	%xmm1, %xmm1
180001e49:     	cmpb	$0x0, (%r13)
180001e4e:     	jne	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180001e54:     	sqrtsd	%xmm1, %xmm1
180001e58:     	xorpd	%xmm2, %xmm2
180001e5c:     	ucomisd	%xmm2, %xmm1
180001e60:     	jne	0x180002044 <PyInit_rcaotr_61fae00d4878711302f71448+0x6d4>
180001e66:     	jp	0x180002044 <PyInit_rcaotr_61fae00d4878711302f71448+0x6d4>
180001e6c:     	movb	$0x1, (%r13)
180001e71:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001e79:     	movzbl	(%r13), %r8d
180001e7e:     	movq	$-0x1, %r9
180001e85:     	testb	%r8b, %r8b
180001e88:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001e8e:     	movq	0x80(%rsp), %rax
180001e96:     	movq	%r9, 0x8(%rbx,%rax,8)
180001e9b:     	cmpb	$0x0, (%r13)
180001ea0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180001ea6:     	movq	0x80(%rsp), %rax
180001eae:     	movq	0x8(%rbx,%rax,8), %rax
180001eb3:     	movq	(%rbx), %r8
180001eb6:     	movsd	0x10(%r14,%rax,8), %xmm4
180001ebd:     	movsd	0x20(%r14,%r8,8), %xmm5
180001ec4:     	movapd	%xmm4, %xmm1
180001ec8:     	mulsd	%xmm5, %xmm1
180001ecc:     	movapd	0x74fc(%rip), %xmm2     # 0x1800093d0
180001ed4:     	andpd	%xmm1, %xmm2
180001ed8:     	ucomisd	0x7500(%rip), %xmm2     # 0x1800093e0
180001ee0:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001ee6:     	movsd	0x20(%r14,%rax,8), %xmm2
180001eed:     	movsd	0x10(%r14,%r8,8), %xmm3
180001ef4:     	movapd	%xmm2, %xmm6
180001ef8:     	mulsd	%xmm3, %xmm6
180001efc:     	movapd	0x74cc(%rip), %xmm7     # 0x1800093d0
180001f04:     	andpd	%xmm6, %xmm7
180001f08:     	ucomisd	0x74d0(%rip), %xmm7     # 0x1800093e0
180001f10:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f16:     	subsd	%xmm6, %xmm1
180001f1a:     	movapd	0x74ae(%rip), %xmm6     # 0x1800093d0
180001f22:     	andpd	%xmm1, %xmm6
180001f26:     	ucomisd	0x74b2(%rip), %xmm6     # 0x1800093e0
180001f2e:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f34:     	movsd	(%r14,%r8,8), %xmm6
180001f3a:     	mulsd	%xmm6, %xmm2
180001f3e:     	movapd	0x748a(%rip), %xmm7     # 0x1800093d0
180001f46:     	andpd	%xmm2, %xmm7
180001f4a:     	ucomisd	0x748e(%rip), %xmm7     # 0x1800093e0
180001f52:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f58:     	movsd	(%r14,%rax,8), %xmm7
180001f5e:     	mulsd	%xmm7, %xmm5
180001f62:     	movapd	0x7465(%rip), %xmm8     # 0x1800093d0
180001f6b:     	andpd	%xmm5, %xmm8
180001f70:     	ucomisd	0x7467(%rip), %xmm8     # 0x1800093e0
180001f79:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f7f:     	subsd	%xmm5, %xmm2
180001f83:     	movapd	0x7445(%rip), %xmm5     # 0x1800093d0
180001f8b:     	andpd	%xmm2, %xmm5
180001f8f:     	ucomisd	0x7449(%rip), %xmm5     # 0x1800093e0
180001f97:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001f9d:     	mulsd	%xmm7, %xmm3
180001fa1:     	movapd	0x7427(%rip), %xmm5     # 0x1800093d0
180001fa9:     	andpd	%xmm3, %xmm5
180001fad:     	ucomisd	0x742b(%rip), %xmm5     # 0x1800093e0
180001fb5:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001fbb:     	mulsd	%xmm6, %xmm4
180001fbf:     	movapd	0x7409(%rip), %xmm5     # 0x1800093d0
180001fc7:     	andpd	%xmm4, %xmm5
180001fcb:     	ucomisd	0x740d(%rip), %xmm5     # 0x1800093e0
180001fd3:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001fd9:     	subsd	%xmm4, %xmm3
180001fdd:     	movapd	0x73eb(%rip), %xmm4     # 0x1800093d0
180001fe5:     	andpd	%xmm3, %xmm4
180001fe9:     	ucomisd	0x73ef(%rip), %xmm4     # 0x1800093e0
180001ff1:     	jae	0x1800020d1 <PyInit_rcaotr_61fae00d4878711302f71448+0x761>
180001ff7:     	movq	(%rbp), %r8
180001ffb:     	leaq	0x6(%r8), %rax
180001fff:     	cmpq	0x260(%rsp), %rax
180002007:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002009:     	movq	%rax, (%rbp)
18000200d:     	cmpb	$0x0, (%r13)
180002012:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002018:     	movsd	%xmm1, (%r14,%r8,8)
18000201e:     	movsd	%xmm2, 0x10(%r14,%r8,8)
180002025:     	movsd	%xmm3, 0x20(%r14,%r8,8)
18000202c:     	movzbl	(%r13), %r9d
180002031:     	xorl	%eax, %eax
180002033:     	movl	%r9d, %r10d
180002036:     	negb	%r10b
180002039:     	sbbq	%rax, %rax
18000203c:     	orq	%r8, %rax
18000203f:     	jmp	0x1800020ea <PyInit_rcaotr_61fae00d4878711302f71448+0x77a>
180002044:     	movq	(%rbp), %rax
180002048:     	leaq	0x6(%rax), %r9
18000204c:     	cmpq	%r11, %r9
18000204f:     	jle	0x18000205b <PyInit_rcaotr_61fae00d4878711302f71448+0x6eb>
180002051:     	movb	$0x2, (%r13)
180002056:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000205b:     	movq	0x78(%rsp), %r8
180002060:     	movsd	(%r14,%r8,8), %xmm2
180002066:     	movsd	0x10(%r14,%r8,8), %xmm3
18000206d:     	movsd	0x20(%r14,%r8,8), %xmm4
180002074:     	movq	%r9, (%rbp)
180002078:     	cmpb	$0x0, (%r13)
18000207d:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002083:     	movsd	0x735d(%rip), %xmm5     # 0x1800093e8
18000208b:     	divsd	%xmm1, %xmm5
18000208f:     	mulsd	%xmm5, %xmm2
180002093:     	mulsd	%xmm5, %xmm3
180002097:     	mulsd	%xmm4, %xmm5
18000209b:     	movsd	%xmm2, (%r14,%rax,8)
1800020a1:     	movsd	%xmm3, 0x10(%r14,%rax,8)
1800020a8:     	movsd	%xmm5, 0x20(%r14,%rax,8)
1800020af:     	movzbl	(%r13), %r8d
1800020b4:     	xorl	%r9d, %r9d
1800020b7:     	movl	%r8d, %r10d
1800020ba:     	negb	%r10b
1800020bd:     	sbbq	%r9, %r9
1800020c0:     	orq	%rax, %r9
1800020c3:     	testb	%r8b, %r8b
1800020c6:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800020cc:     	jmp	0x180001e8e <PyInit_rcaotr_61fae00d4878711302f71448+0x51e>
1800020d1:     	movb	$0x1, (%r13)
1800020d6:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
1800020de:     	movzbl	(%r13), %r9d
1800020e3:     	movq	$-0x1, %rax
1800020ea:     	testb	%r9b, %r9b
1800020ed:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800020f3:     	movsd	(%r14,%rax,8), %xmm1
1800020f9:     	mulsd	%xmm1, %xmm1
1800020fd:     	movapd	0x72cb(%rip), %xmm2     # 0x1800093d0
180002105:     	andpd	%xmm1, %xmm2
180002109:     	ucomisd	0x72cf(%rip), %xmm2     # 0x1800093e0
180002111:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
180002113:     	movsd	0x10(%r14,%rax,8), %xmm2
18000211a:     	mulsd	%xmm2, %xmm2
18000211e:     	movapd	0x72aa(%rip), %xmm3     # 0x1800093d0
180002126:     	andpd	%xmm2, %xmm3
18000212a:     	ucomisd	0x72ae(%rip), %xmm3     # 0x1800093e0
180002132:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
180002134:     	addsd	%xmm2, %xmm1
180002138:     	movapd	0x7290(%rip), %xmm2     # 0x1800093d0
180002140:     	andpd	%xmm1, %xmm2
180002144:     	ucomisd	0x7294(%rip), %xmm2     # 0x1800093e0
18000214c:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
18000214e:     	movsd	0x20(%r14,%rax,8), %xmm2
180002155:     	mulsd	%xmm2, %xmm2
180002159:     	movapd	0x726f(%rip), %xmm3     # 0x1800093d0
180002161:     	andpd	%xmm2, %xmm3
180002165:     	ucomisd	0x7273(%rip), %xmm3     # 0x1800093e0
18000216d:     	jae	0x180002189 <PyInit_rcaotr_61fae00d4878711302f71448+0x819>
18000216f:     	addsd	%xmm2, %xmm1
180002173:     	movapd	0x7255(%rip), %xmm2     # 0x1800093d0
18000217b:     	andpd	%xmm1, %xmm2
18000217f:     	ucomisd	0x7259(%rip), %xmm2     # 0x1800093e0
180002187:     	jb	0x18000219a <PyInit_rcaotr_61fae00d4878711302f71448+0x82a>
180002189:     	movb	$0x1, (%r13)
18000218e:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180002196:     	xorpd	%xmm1, %xmm1
18000219a:     	cmpb	$0x0, (%r13)
18000219f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800021a5:     	sqrtsd	%xmm1, %xmm1
1800021a9:     	xorpd	%xmm2, %xmm2
1800021ad:     	ucomisd	%xmm2, %xmm1
1800021b1:     	jne	0x18000238e <PyInit_rcaotr_61fae00d4878711302f71448+0xa1e>
1800021b7:     	jp	0x18000238e <PyInit_rcaotr_61fae00d4878711302f71448+0xa1e>
1800021bd:     	movb	$0x1, (%r13)
1800021c2:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800021ca:     	movzbl	(%r13), %eax
1800021cf:     	movq	$-0x1, 0x78(%rsp)
1800021d8:     	testb	%al, %al
1800021da:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800021e0:     	movq	0x80(%rsp), %rax
1800021e8:     	movq	0x8(%rbx,%rax,8), %rax
1800021ed:     	movq	0x78(%rsp), %r8
1800021f2:     	movsd	0x10(%r14,%r8,8), %xmm4
1800021f9:     	movsd	0x20(%r14,%rax,8), %xmm5
180002200:     	movapd	%xmm4, %xmm1
180002204:     	mulsd	%xmm5, %xmm1
180002208:     	movapd	0x71c0(%rip), %xmm2     # 0x1800093d0
180002210:     	andpd	%xmm1, %xmm2
180002214:     	ucomisd	0x71c4(%rip), %xmm2     # 0x1800093e0
18000221c:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002222:     	movq	0x78(%rsp), %r8
180002227:     	movsd	0x20(%r14,%r8,8), %xmm2
18000222e:     	movsd	0x10(%r14,%rax,8), %xmm3
180002235:     	movapd	%xmm2, %xmm6
180002239:     	mulsd	%xmm3, %xmm6
18000223d:     	movapd	0x718b(%rip), %xmm7     # 0x1800093d0
180002245:     	andpd	%xmm6, %xmm7
180002249:     	ucomisd	0x718f(%rip), %xmm7     # 0x1800093e0
180002251:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002257:     	subsd	%xmm6, %xmm1
18000225b:     	movapd	0x716d(%rip), %xmm6     # 0x1800093d0
180002263:     	andpd	%xmm1, %xmm6
180002267:     	ucomisd	0x7171(%rip), %xmm6     # 0x1800093e0
18000226f:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002275:     	movsd	(%r14,%rax,8), %xmm6
18000227b:     	mulsd	%xmm6, %xmm2
18000227f:     	movapd	0x7149(%rip), %xmm7     # 0x1800093d0
180002287:     	andpd	%xmm2, %xmm7
18000228b:     	ucomisd	0x714d(%rip), %xmm7     # 0x1800093e0
180002293:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002299:     	movq	0x78(%rsp), %rax
18000229e:     	movsd	(%r14,%rax,8), %xmm7
1800022a4:     	mulsd	%xmm7, %xmm5
1800022a8:     	movapd	0x711f(%rip), %xmm8     # 0x1800093d0
1800022b1:     	andpd	%xmm5, %xmm8
1800022b6:     	ucomisd	0x7121(%rip), %xmm8     # 0x1800093e0
1800022bf:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
1800022c5:     	subsd	%xmm5, %xmm2
1800022c9:     	movapd	0x70ff(%rip), %xmm5     # 0x1800093d0
1800022d1:     	andpd	%xmm2, %xmm5
1800022d5:     	ucomisd	0x7103(%rip), %xmm5     # 0x1800093e0
1800022dd:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
1800022e3:     	mulsd	%xmm7, %xmm3
1800022e7:     	movapd	0x70e1(%rip), %xmm5     # 0x1800093d0
1800022ef:     	andpd	%xmm3, %xmm5
1800022f3:     	ucomisd	0x70e5(%rip), %xmm5     # 0x1800093e0
1800022fb:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
180002301:     	mulsd	%xmm6, %xmm4
180002305:     	movapd	0x70c3(%rip), %xmm5     # 0x1800093d0
18000230d:     	andpd	%xmm4, %xmm5
180002311:     	ucomisd	0x70c7(%rip), %xmm5     # 0x1800093e0
180002319:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
18000231f:     	subsd	%xmm4, %xmm3
180002323:     	movapd	0x70a5(%rip), %xmm4     # 0x1800093d0
18000232b:     	andpd	%xmm3, %xmm4
18000232f:     	ucomisd	0x70a9(%rip), %xmm4     # 0x1800093e0
180002337:     	jae	0x180002419 <PyInit_rcaotr_61fae00d4878711302f71448+0xaa9>
18000233d:     	movq	(%rbp), %r8
180002341:     	leaq	0x6(%r8), %rax
180002345:     	cmpq	0x260(%rsp), %rax
18000234d:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002353:     	movq	%rax, (%rbp)
180002357:     	cmpb	$0x0, (%r13)
18000235c:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002362:     	movsd	%xmm1, (%r14,%r8,8)
180002368:     	movsd	%xmm2, 0x10(%r14,%r8,8)
18000236f:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002376:     	movzbl	(%r13), %r9d
18000237b:     	xorl	%eax, %eax
18000237d:     	movl	%r9d, %r10d
180002380:     	negb	%r10b
180002383:     	sbbq	%rax, %rax
180002386:     	orq	%r8, %rax
180002389:     	jmp	0x180002432 <PyInit_rcaotr_61fae00d4878711302f71448+0xac2>
18000238e:     	movq	(%rbp), %r8
180002392:     	leaq	0x6(%r8), %r9
180002396:     	cmpq	0x260(%rsp), %r9
18000239e:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800023a4:     	movsd	(%r14,%rax,8), %xmm2
1800023aa:     	movsd	0x10(%r14,%rax,8), %xmm3
1800023b1:     	movsd	0x20(%r14,%rax,8), %xmm4
1800023b8:     	movq	%r9, (%rbp)
1800023bc:     	cmpb	$0x0, (%r13)
1800023c1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800023c7:     	movsd	0x7019(%rip), %xmm5     # 0x1800093e8
1800023cf:     	divsd	%xmm1, %xmm5
1800023d3:     	mulsd	%xmm5, %xmm2
1800023d7:     	mulsd	%xmm5, %xmm3
1800023db:     	mulsd	%xmm4, %xmm5
1800023df:     	movsd	%xmm2, (%r14,%r8,8)
1800023e5:     	movsd	%xmm3, 0x10(%r14,%r8,8)
1800023ec:     	movsd	%xmm5, 0x20(%r14,%r8,8)
1800023f3:     	movzbl	(%r13), %eax
1800023f8:     	xorl	%r10d, %r10d
1800023fb:     	movl	%eax, %r9d
1800023fe:     	negb	%r9b
180002401:     	sbbq	%r10, %r10
180002404:     	orq	%r8, %r10
180002407:     	movq	%r10, 0x78(%rsp)
18000240c:     	testb	%al, %al
18000240e:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002414:     	jmp	0x1800021e0 <PyInit_rcaotr_61fae00d4878711302f71448+0x870>
180002419:     	movb	$0x1, (%r13)
18000241e:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
180002426:     	movzbl	(%r13), %r9d
18000242b:     	movq	$-0x1, %rax
180002432:     	testb	%r9b, %r9b
180002435:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000243b:     	movsd	(%r14,%rax,8), %xmm1
180002441:     	mulsd	%xmm1, %xmm1
180002445:     	movapd	0x6f83(%rip), %xmm2     # 0x1800093d0
18000244d:     	andpd	%xmm1, %xmm2
180002451:     	ucomisd	0x6f87(%rip), %xmm2     # 0x1800093e0
180002459:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
18000245b:     	movsd	0x10(%r14,%rax,8), %xmm2
180002462:     	mulsd	%xmm2, %xmm2
180002466:     	movapd	0x6f62(%rip), %xmm3     # 0x1800093d0
18000246e:     	andpd	%xmm2, %xmm3
180002472:     	ucomisd	0x6f66(%rip), %xmm3     # 0x1800093e0
18000247a:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
18000247c:     	addsd	%xmm2, %xmm1
180002480:     	movapd	0x6f48(%rip), %xmm2     # 0x1800093d0
180002488:     	andpd	%xmm1, %xmm2
18000248c:     	ucomisd	0x6f4c(%rip), %xmm2     # 0x1800093e0
180002494:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
180002496:     	movsd	0x20(%r14,%rax,8), %xmm2
18000249d:     	mulsd	%xmm2, %xmm2
1800024a1:     	movapd	0x6f27(%rip), %xmm3     # 0x1800093d0
1800024a9:     	andpd	%xmm2, %xmm3
1800024ad:     	ucomisd	0x6f2b(%rip), %xmm3     # 0x1800093e0
1800024b5:     	jae	0x1800024d1 <PyInit_rcaotr_61fae00d4878711302f71448+0xb61>
1800024b7:     	addsd	%xmm2, %xmm1
1800024bb:     	movapd	0x6f0d(%rip), %xmm2     # 0x1800093d0
1800024c3:     	andpd	%xmm1, %xmm2
1800024c7:     	ucomisd	0x6f11(%rip), %xmm2     # 0x1800093e0
1800024cf:     	jb	0x1800024e2 <PyInit_rcaotr_61fae00d4878711302f71448+0xb72>
1800024d1:     	movb	$0x1, (%r13)
1800024d6:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800024de:     	xorpd	%xmm1, %xmm1
1800024e2:     	cmpb	$0x0, (%r13)
1800024e7:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800024ed:     	sqrtsd	%xmm1, %xmm1
1800024f1:     	xorpd	%xmm2, %xmm2
1800024f5:     	ucomisd	%xmm2, %xmm1
1800024f9:     	jne	0x180002f0c <PyInit_rcaotr_61fae00d4878711302f71448+0x159c>
1800024ff:     	jp	0x180002f0c <PyInit_rcaotr_61fae00d4878711302f71448+0x159c>
180002505:     	movb	$0x1, (%r13)
18000250a:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180002512:     	movzbl	(%r13), %eax
180002517:     	movq	$-0x8, 0xa8(%rsp)
180002523:     	testb	%al, %al
180002525:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000252b:     	movq	0x8(%rbx,%r12,8), %rax
180002530:     	movq	%rax, 0x120(%rsp)
180002538:     	testq	%rax, %rax
18000253b:     	jle	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002541:     	movsd	0x6e7f(%rip), %xmm6     # 0x1800093c8
180002549:     	movapd	%xmm0, %xmm8
18000254e:     	mulsd	%xmm0, %xmm6
180002552:     	movapd	%xmm0, %xmm7
180002556:     	addsd	%xmm0, %xmm8
18000255b:     	cvtsi2sd	%rcx, %xmm0
180002560:     	divsd	%xmm0, %xmm8
180002565:     	movapd	%xmm6, %xmm9
18000256a:     	addsd	%xmm6, %xmm9
18000256f:     	xorps	%xmm0, %xmm0
180002572:     	cvtsi2sd	%rdx, %xmm0
180002577:     	divsd	%xmm0, %xmm9
18000257c:     	movq	$-0x1, 0xa0(%rsp)
180002588:     	movapd	0x6e3f(%rip), %xmm10    # 0x1800093d0
180002591:     	movsd	0x6e46(%rip), %xmm11    # 0x1800093e0
18000259a:     	xorpd	%xmm12, %xmm12
18000259f:     	movsd	0x6e48(%rip), %xmm13    # 0x1800093f0
1800025a8:     	movsd	0x6e4f(%rip), %xmm15    # 0x180009400
1800025b1:     	movq	$0x0, 0x98(%rsp)
1800025bd:     	movq	0x98(%rsp), %rcx
1800025c5:     	leaq	0x1(%rcx), %rax
1800025c9:     	movq	%rax, 0x98(%rsp)
1800025d1:     	movq	0x10(%rbx,%r12,8), %rdx
1800025d6:     	testq	%rdx, %rdx
1800025d9:     	movl	$0x0, %eax
1800025de:     	cmovleq	%rax, %rdx
1800025e2:     	movq	%rdx, 0x130(%rsp)
1800025ea:     	movq	%rcx, 0x128(%rsp)
1800025f2:     	xorps	%xmm14, %xmm14
1800025f6:     	cvtsi2sd	%rcx, %xmm14
1800025fb:     	mulsd	%xmm9, %xmm14
180002600:     	subsd	%xmm6, %xmm14
180002605:     	movq	$0x0, 0x88(%rsp)
180002611:     	movq	0x88(%rsp), %rax
180002619:     	cmpq	%rax, 0x130(%rsp)
180002621:     	je	0x180002ee9 <PyInit_rcaotr_61fae00d4878711302f71448+0x1579>
180002627:     	movq	(%rbp), %rdx
18000262b:     	leaq	0x6(%rdx), %rax
18000262f:     	cmpq	0x260(%rsp), %rax
180002637:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
18000263d:     	movq	0x78(%rsp), %rcx
180002642:     	movsd	(%r14,%rcx,8), %xmm0
180002648:     	movsd	0x10(%r14,%rcx,8), %xmm1
18000264f:     	movsd	0x20(%r14,%rcx,8), %xmm2
180002656:     	movq	%rax, (%rbp)
18000265a:     	cmpb	$0x0, (%r13)
18000265f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002665:     	xorps	%xmm3, %xmm3
180002668:     	cvtsi2sdq	0x88(%rsp), %xmm3
180002672:     	mulsd	%xmm8, %xmm3
180002677:     	subsd	%xmm7, %xmm3
18000267b:     	mulsd	%xmm3, %xmm0
18000267f:     	mulsd	%xmm3, %xmm1
180002683:     	mulsd	%xmm2, %xmm3
180002687:     	movsd	%xmm0, (%r14,%rdx,8)
18000268d:     	movsd	%xmm1, 0x10(%r14,%rdx,8)
180002694:     	movsd	%xmm3, 0x20(%r14,%rdx,8)
18000269b:     	cmpb	$0x0, (%r13)
1800026a0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800026a6:     	movq	(%rbp), %rax
1800026aa:     	leaq	0x6(%rax), %rcx
1800026ae:     	cmpq	0x260(%rsp), %rcx
1800026b6:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800026bc:     	movq	0xa8(%rsp), %r8
1800026c4:     	movsd	(%r14,%r8), %xmm0
1800026ca:     	movsd	0x10(%r14,%r8), %xmm1
1800026d1:     	movsd	0x20(%r14,%r8), %xmm2
1800026d8:     	movq	%rcx, (%rbp)
1800026dc:     	cmpb	$0x0, (%r13)
1800026e1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800026e7:     	mulsd	%xmm14, %xmm0
1800026ec:     	mulsd	%xmm14, %xmm1
1800026f1:     	mulsd	%xmm14, %xmm2
1800026f6:     	movsd	%xmm0, (%r14,%rax,8)
1800026fc:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002703:     	movsd	%xmm2, 0x20(%r14,%rax,8)
18000270a:     	cmpb	$0x0, (%r13)
18000270f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002715:     	movq	0x80(%rsp), %r8
18000271d:     	movq	(%rbx,%r8,8), %rcx
180002721:     	movq	0x8(%rbx,%r8,8), %r8
180002726:     	movsd	(%r14,%r8,8), %xmm0
18000272c:     	addsd	(%r14,%rdx,8), %xmm0
180002732:     	movapd	%xmm0, %xmm1
180002736:     	andpd	%xmm10, %xmm1
18000273b:     	ucomisd	%xmm11, %xmm1
180002740:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002746:     	movsd	0x10(%r14,%r8,8), %xmm1
18000274d:     	addsd	0x10(%r14,%rdx,8), %xmm1
180002754:     	movapd	%xmm1, %xmm2
180002758:     	andpd	%xmm10, %xmm2
18000275d:     	ucomisd	%xmm11, %xmm2
180002762:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002764:     	movsd	0x20(%r14,%r8,8), %xmm2
18000276b:     	addsd	0x20(%r14,%rdx,8), %xmm2
180002772:     	movapd	%xmm2, %xmm3
180002776:     	andpd	%xmm10, %xmm3
18000277b:     	ucomisd	%xmm11, %xmm3
180002780:     	jae	0x1800027d2 <PyInit_rcaotr_61fae00d4878711302f71448+0xe62>
180002782:     	movq	(%rbp), %r8
180002786:     	leaq	0x6(%r8), %rdx
18000278a:     	cmpq	0x260(%rsp), %rdx
180002792:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002798:     	movq	%rdx, (%rbp)
18000279c:     	cmpb	$0x0, (%r13)
1800027a1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800027a7:     	movsd	%xmm0, (%r14,%r8,8)
1800027ad:     	movsd	%xmm1, 0x10(%r14,%r8,8)
1800027b4:     	movsd	%xmm2, 0x20(%r14,%r8,8)
1800027bb:     	movzbl	(%r13), %r9d
1800027c0:     	movl	%r9d, %edx
1800027c3:     	negb	%dl
1800027c5:     	movl	$0x0, %edx
1800027ca:     	sbbq	%rdx, %rdx
1800027cd:     	orq	%r8, %rdx
1800027d0:     	jmp	0x1800027eb <PyInit_rcaotr_61fae00d4878711302f71448+0xe7b>
1800027d2:     	movb	$0x1, (%r13)
1800027d7:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800027df:     	movzbl	(%r13), %r9d
1800027e4:     	movq	$-0x1, %rdx
1800027eb:     	testb	%r9b, %r9b
1800027ee:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800027f4:     	movsd	(%r14,%rdx,8), %xmm0
1800027fa:     	addsd	(%r14,%rax,8), %xmm0
180002800:     	movapd	%xmm0, %xmm1
180002804:     	andpd	%xmm10, %xmm1
180002809:     	ucomisd	%xmm11, %xmm1
18000280e:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002814:     	movsd	0x10(%r14,%rdx,8), %xmm1
18000281b:     	addsd	0x10(%r14,%rax,8), %xmm1
180002822:     	movapd	%xmm1, %xmm2
180002826:     	andpd	%xmm10, %xmm2
18000282b:     	ucomisd	%xmm11, %xmm2
180002830:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002832:     	movsd	0x20(%r14,%rdx,8), %xmm2
180002839:     	addsd	0x20(%r14,%rax,8), %xmm2
180002840:     	movapd	%xmm2, %xmm3
180002844:     	andpd	%xmm10, %xmm3
180002849:     	ucomisd	%xmm11, %xmm3
18000284e:     	jae	0x1800028a0 <PyInit_rcaotr_61fae00d4878711302f71448+0xf30>
180002850:     	movq	(%rbp), %rax
180002854:     	leaq	0x6(%rax), %rdx
180002858:     	cmpq	0x260(%rsp), %rdx
180002860:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002866:     	movq	%rdx, (%rbp)
18000286a:     	cmpb	$0x0, (%r13)
18000286f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002875:     	movsd	%xmm0, (%r14,%rax,8)
18000287b:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002882:     	movsd	%xmm2, 0x20(%r14,%rax,8)
180002889:     	movzbl	(%r13), %r8d
18000288e:     	movl	%r8d, %edx
180002891:     	negb	%dl
180002893:     	movl	$0x0, %edx
180002898:     	sbbq	%rdx, %rdx
18000289b:     	orq	%rax, %rdx
18000289e:     	jmp	0x1800028b9 <PyInit_rcaotr_61fae00d4878711302f71448+0xf49>
1800028a0:     	movb	$0x1, (%r13)
1800028a5:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800028ad:     	movzbl	(%r13), %r8d
1800028b2:     	movq	$-0x1, %rdx
1800028b9:     	testb	%r8b, %r8b
1800028bc:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028c2:     	movq	(%rbp), %rax
1800028c6:     	leaq	0x2(%rax), %r8
1800028ca:     	cmpq	0x260(%rsp), %r8
1800028d2:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800028d8:     	movq	%r8, (%rbp)
1800028dc:     	cmpb	$0x0, (%r13)
1800028e1:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028e7:     	movq	%rcx, (%rbx,%rax,8)
1800028eb:     	cmpb	$0x0, (%r13)
1800028f0:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800028f6:     	movsd	(%r14,%rdx,8), %xmm0
1800028fc:     	mulsd	%xmm0, %xmm0
180002900:     	movapd	%xmm0, %xmm1
180002904:     	andpd	%xmm10, %xmm1
180002909:     	ucomisd	%xmm11, %xmm1
18000290e:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
180002910:     	movsd	0x10(%r14,%rdx,8), %xmm1
180002917:     	mulsd	%xmm1, %xmm1
18000291b:     	movapd	%xmm1, %xmm2
18000291f:     	andpd	%xmm10, %xmm2
180002924:     	ucomisd	%xmm11, %xmm2
180002929:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000292b:     	addsd	%xmm1, %xmm0
18000292f:     	movapd	%xmm0, %xmm1
180002933:     	andpd	%xmm10, %xmm1
180002938:     	ucomisd	%xmm11, %xmm1
18000293d:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000293f:     	movsd	0x20(%r14,%rdx,8), %xmm1
180002946:     	mulsd	%xmm1, %xmm1
18000294a:     	movapd	%xmm1, %xmm2
18000294e:     	andpd	%xmm10, %xmm2
180002953:     	ucomisd	%xmm11, %xmm2
180002958:     	jae	0x18000296e <PyInit_rcaotr_61fae00d4878711302f71448+0xffe>
18000295a:     	addsd	%xmm1, %xmm0
18000295e:     	movapd	%xmm0, %xmm1
180002962:     	andpd	%xmm10, %xmm1
180002967:     	ucomisd	%xmm11, %xmm1
18000296c:     	jb	0x18000297f <PyInit_rcaotr_61fae00d4878711302f71448+0x100f>
18000296e:     	movb	$0x1, (%r13)
180002973:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
18000297b:     	xorpd	%xmm0, %xmm0
18000297f:     	cmpb	$0x0, (%r13)
180002984:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
18000298a:     	sqrtsd	%xmm0, %xmm0
18000298e:     	ucomisd	%xmm12, %xmm0
180002993:     	jne	0x1800029b2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1042>
180002995:     	jp	0x1800029b2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1042>
180002997:     	movb	$0x1, (%r13)
18000299c:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800029a4:     	movzbl	(%r13), %edx
1800029a9:     	movq	$-0x1, %r8
1800029b0:     	jmp	0x180002a2e <PyInit_rcaotr_61fae00d4878711302f71448+0x10be>
1800029b2:     	movq	(%rbp), %rcx
1800029b6:     	leaq	0x6(%rcx), %r8
1800029ba:     	cmpq	0x260(%rsp), %r8
1800029c2:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
1800029c8:     	movsd	(%r14,%rdx,8), %xmm1
1800029ce:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800029d5:     	movsd	0x20(%r14,%rdx,8), %xmm3
1800029dc:     	movq	%r8, (%rbp)
1800029e0:     	cmpb	$0x0, (%r13)
1800029e5:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
1800029eb:     	movsd	0x69f5(%rip), %xmm4     # 0x1800093e8
1800029f3:     	divsd	%xmm0, %xmm4
1800029f7:     	mulsd	%xmm4, %xmm1
1800029fb:     	mulsd	%xmm4, %xmm2
1800029ff:     	mulsd	%xmm3, %xmm4
180002a03:     	movsd	%xmm1, (%r14,%rcx,8)
180002a09:     	movsd	%xmm2, 0x10(%r14,%rcx,8)
180002a10:     	movsd	%xmm4, 0x20(%r14,%rcx,8)
180002a17:     	movzbl	(%r13), %edx
180002a1c:     	movl	%edx, %r8d
180002a1f:     	negb	%r8b
180002a22:     	movl	$0x0, %r8d
180002a28:     	sbbq	%r8, %r8
180002a2b:     	orq	%rcx, %r8
180002a2e:     	testb	%dl, %dl
180002a30:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002a36:     	movq	%r8, 0x8(%rbx,%rax,8)
180002a3b:     	cmpb	$0x0, (%r13)
180002a40:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002a46:     	movq	0x8(%rbp), %rcx
180002a4a:     	leaq	0x1(%rcx), %rdx
180002a4e:     	movq	%rdx, 0x8(%rbp)
180002a52:     	cmpq	0x10(%rbp), %rcx
180002a56:     	jge	0x180002fa0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1630>
180002a5c:     	movq	$0x0, 0xb0(%rsp)
180002a68:     	movb	$0x0, 0xb8(%rsp)
180002a70:     	movq	$0x0, 0xc0(%rsp)
180002a7c:     	movb	$0x0, 0xc8(%rsp)
180002a84:     	movq	$0x0, 0xd0(%rsp)
180002a90:     	movb	$0x0, 0xd8(%rsp)
180002a98:     	movq	$0x0, 0xe0(%rsp)
180002aa4:     	movb	$0x0, 0xe8(%rsp)
180002aac:     	movq	$0x0, 0xf0(%rsp)
180002ab8:     	movb	$0x0, 0xf8(%rsp)
180002ac0:     	movq	$0x0, 0x100(%rsp)
180002acc:     	movb	$0x0, 0x108(%rsp)
180002ad4:     	movq	%rax, 0x48(%rsp)
180002ad9:     	movq	%r15, 0x40(%rsp)
180002ade:     	movq	0x260(%rsp), %rax
180002ae6:     	movq	%rax, 0x30(%rsp)
180002aeb:     	movq	%r13, 0x28(%rsp)
180002af0:     	movq	%rbp, 0x20(%rsp)
180002af5:     	movq	$-0x1, 0x70(%rsp)
180002afe:     	movq	$-0x1, 0x68(%rsp)
180002b07:     	movq	$-0x1, 0x60(%rsp)
180002b10:     	movq	$-0x1, 0x58(%rsp)
180002b19:     	movq	$-0x1, 0x50(%rsp)
180002b22:     	movq	$0x0, 0x38(%rsp)
180002b2b:     	leaq	0xb0(%rsp), %rcx
180002b33:     	leaq	0x138(%rsp), %rdx
180002b3b:     	movq	%r14, %r8
180002b3e:     	movq	%rbx, %r9
180002b41:     	callq	0x180002fc0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1650>
180002b46:     	testl	%eax, %eax
180002b48:     	jne	0x180002fb2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1642>
180002b4e:     	cmpb	$0x0, (%r13)
180002b53:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002b59:     	movsd	0xb0(%rsp), %xmm2
180002b62:     	movsd	0xc0(%rsp), %xmm1
180002b6b:     	movsd	0xd0(%rsp), %xmm0
180002b74:     	decq	0x8(%rbp)
180002b78:     	movq	0x8(%rbx,%r12,8), %rax
180002b7d:     	movq	%rax, %rcx
180002b80:     	subq	0x128(%rsp), %rcx
180002b88:     	movq	%rcx, %rdx
180002b8b:     	notq	%rdx
180002b8e:     	testq	%rdx, %rax
180002b91:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002b97:     	cmpb	$0x0, (%r13)
180002b9c:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002ba2:     	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
180002bac:     	cmpq	%rdx, %rcx
180002baf:     	je	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002bb5:     	decq	%rcx
180002bb8:     	movq	0x10(%rbx,%r12,8), %rdx
180002bbd:     	cvtsi2sd	%rcx, %xmm3
180002bc2:     	cvtsi2sd	%rdx, %xmm4
180002bc7:     	mulsd	%xmm3, %xmm4
180002bcb:     	andpd	%xmm10, %xmm4
180002bd0:     	ucomisd	%xmm13, %xmm4
180002bd5:     	jae	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002bdb:     	imulq	%rdx, %rcx
180002bdf:     	addq	0xa0(%rsp), %rax
180002be7:     	imulq	%rdx, %rax
180002beb:     	movq	0x88(%rsp), %r8
180002bf3:     	addq	%r8, %rax
180002bf6:     	xorq	%rax, %rcx
180002bf9:     	movq	%rax, %rdx
180002bfc:     	xorq	%r8, %rdx
180002bff:     	testq	%rdx, %rcx
180002c02:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002c08:     	xorps	%xmm3, %xmm3
180002c0b:     	cvtsi2sd	%rax, %xmm3
180002c10:     	mulsd	0x67e0(%rip), %xmm3     # 0x1800093f8
180002c18:     	andpd	%xmm10, %xmm3
180002c1d:     	ucomisd	%xmm13, %xmm3
180002c22:     	jae	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002c28:     	mulsd	%xmm15, %xmm2
180002c2d:     	movapd	%xmm2, %xmm3
180002c31:     	andpd	%xmm10, %xmm3
180002c36:     	ucomisd	%xmm11, %xmm3
180002c3b:     	jae	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002c41:     	movsd	0x67bf(%rip), %xmm4     # 0x180009408
180002c49:     	ucomisd	%xmm3, %xmm4
180002c4d:     	jbe	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002c53:     	leaq	(%rax,%rax,2), %rcx
180002c57:     	cvttsd2si	%xmm2, %rdx
180002c5c:     	testq	%rdx, %rdx
180002c5f:     	movl	$0x0, %r8d
180002c65:     	cmovleq	%r8, %rdx
180002c69:     	cmpq	$0xff, %rdx
180002c70:     	movl	$0xff, %r8d
180002c76:     	cmovgeq	%r8, %rdx
180002c7a:     	movq	(%rbx,%r12,8), %r9
180002c7e:     	movq	%r9, %r8
180002c81:     	sarq	$0x3f, %r8
180002c85:     	andq	0x260(%rsp), %r8
180002c8d:     	leaq	(%rbx,%r9,8), %r10
180002c91:     	movq	(%r10,%r8,8), %r11
180002c95:     	testq	%rax, %rax
180002c98:     	movq	%rcx, %r8
180002c9b:     	jns	0x180002ca9 <PyInit_rcaotr_61fae00d4878711302f71448+0x1339>
180002c9d:     	movq	%r11, %r8
180002ca0:     	addq	%rcx, %r8
180002ca3:     	js	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002ca9:     	cmpq	%r11, %r8
180002cac:     	jge	0x180002ea6 <PyInit_rcaotr_61fae00d4878711302f71448+0x1536>
180002cb2:     	cmpq	$-0x2, %r9
180002cb6:     	movl	$0x0, %r9d
180002cbc:     	movq	0x260(%rsp), %r11
180002cc4:     	cmovlq	%r11, %r9
180002cc8:     	addq	0x10(%r10,%r9,8), %r8
180002ccd:     	movq	%r8, %r9
180002cd0:     	sarq	$0x3f, %r9
180002cd4:     	andq	%r11, %r9
180002cd7:     	leaq	(%rbx,%r8,8), %r8
180002cdb:     	movq	%rdx, (%r8,%r9,8)
180002cdf:     	mulsd	%xmm15, %xmm1
180002ce4:     	movapd	%xmm1, %xmm2
180002ce8:     	andpd	%xmm10, %xmm2
180002ced:     	ucomisd	%xmm11, %xmm2
180002cf2:     	jae	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002cf8:     	movsd	0x6708(%rip), %xmm3     # 0x180009408
180002d00:     	ucomisd	%xmm2, %xmm3
180002d04:     	jbe	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002d0a:     	cvttsd2si	%xmm1, %r8
180002d0f:     	testq	%r8, %r8
180002d12:     	movl	$0x0, %edx
180002d17:     	cmovleq	%rdx, %r8
180002d1b:     	cmpq	$0xff, %r8
180002d22:     	movl	$0xff, %edx
180002d27:     	cmovgeq	%rdx, %r8
180002d2b:     	leaq	0x1(%rcx), %r9
180002d2f:     	movq	%rcx, %rdx
180002d32:     	notq	%rdx
180002d35:     	movq	%r9, 0x90(%rsp)
180002d3d:     	testq	%rdx, %r9
180002d40:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002d46:     	cmpb	$0x0, (%r13)
180002d4b:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002d51:     	movq	(%rbx,%r12,8), %r9
180002d55:     	movq	%r9, %r11
180002d58:     	sarq	$0x3f, %r11
180002d5c:     	andq	0x260(%rsp), %r11
180002d64:     	testq	%rax, %rax
180002d67:     	leaq	(%rbx,%r9,8), %r10
180002d6b:     	movq	%r10, 0x118(%rsp)
180002d73:     	movq	%r9, 0x110(%rsp)
180002d7b:     	leaq	(%rbx,%r9,8), %r10
180002d7f:     	movq	(%r10,%r11,8), %r11
180002d83:     	jns	0x180002d93 <PyInit_rcaotr_61fae00d4878711302f71448+0x1423>
180002d85:     	addq	%r11, 0x90(%rsp)
180002d8d:     	js	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002d93:     	cmpq	%r11, 0x90(%rsp)
180002d9b:     	jge	0x180002ecb <PyInit_rcaotr_61fae00d4878711302f71448+0x155b>
180002da1:     	cmpq	$-0x2, 0x110(%rsp)
180002daa:     	movl	$0x0, %r10d
180002db0:     	movq	0x260(%rsp), %r11
180002db8:     	cmovlq	%r11, %r10
180002dbc:     	movq	0x118(%rsp), %r11
180002dc4:     	movq	0x90(%rsp), %r9
180002dcc:     	addq	0x10(%r11,%r10,8), %r9
180002dd1:     	movq	%r9, %r10
180002dd4:     	sarq	$0x3f, %r10
180002dd8:     	andq	0x260(%rsp), %r10
180002de0:     	leaq	(%rbx,%r9,8), %r9
180002de4:     	movq	%r8, (%r9,%r10,8)
180002de8:     	mulsd	%xmm15, %xmm0
180002ded:     	movapd	%xmm0, %xmm1
180002df1:     	andpd	%xmm10, %xmm1
180002df6:     	ucomisd	%xmm11, %xmm1
180002dfb:     	jae	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e01:     	movsd	0x65ff(%rip), %xmm2     # 0x180009408
180002e09:     	ucomisd	%xmm1, %xmm2
180002e0d:     	jbe	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e13:     	cvttsd2si	%xmm0, %r8
180002e18:     	testq	%r8, %r8
180002e1b:     	movl	$0x0, %r9d
180002e21:     	cmovleq	%r9, %r8
180002e25:     	cmpq	$0xff, %r8
180002e2c:     	movl	$0xff, %r9d
180002e32:     	cmovgeq	%r9, %r8
180002e36:     	addq	$0x2, %rcx
180002e3a:     	testq	%rdx, %rcx
180002e3d:     	js	0x180001b69 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f9>
180002e43:     	cmpb	$0x0, (%r13)
180002e48:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002e4e:     	movq	(%rbx,%r12,8), %rdx
180002e52:     	movq	%rdx, %r9
180002e55:     	sarq	$0x3f, %r9
180002e59:     	andq	0x260(%rsp), %r9
180002e61:     	testq	%rax, %rax
180002e64:     	leaq	(%rbx,%rdx,8), %rax
180002e68:     	movq	(%rax,%r9,8), %r9
180002e6c:     	jns	0x180002e73 <PyInit_rcaotr_61fae00d4878711302f71448+0x1503>
180002e6e:     	addq	%r9, %rcx
180002e71:     	js	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e73:     	cmpq	%r9, %rcx
180002e76:     	jge	0x180002eda <PyInit_rcaotr_61fae00d4878711302f71448+0x156a>
180002e78:     	cmpq	$-0x2, %rdx
180002e7c:     	movl	$0x0, %edx
180002e81:     	movq	0x260(%rsp), %r9
180002e89:     	cmovlq	%r9, %rdx
180002e8d:     	addq	0x10(%rax,%rdx,8), %rcx
180002e92:     	movq	%rcx, %rax
180002e95:     	sarq	$0x3f, %rax
180002e99:     	andq	%r9, %rax
180002e9c:     	leaq	(%rbx,%rcx,8), %rcx
180002ea0:     	movq	%r8, (%rcx,%rax,8)
180002ea4:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002ea6:     	movb	$0x1, (%r13)
180002eab:     	movq	$0x7a1203, 0x18(%rbp)   # imm = 0x7A1203
180002eb3:     	incq	0x88(%rsp)
180002ebb:     	cmpb	$0x0, (%r13)
180002ec0:     	je	0x180002611 <PyInit_rcaotr_61fae00d4878711302f71448+0xca1>
180002ec6:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002ecb:     	movb	$0x1, (%r13)
180002ed0:     	movq	$0x7a1204, 0x18(%rbp)   # imm = 0x7A1204
180002ed8:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002eda:     	movb	$0x1, (%r13)
180002edf:     	movq	$0x7a1205, 0x18(%rbp)   # imm = 0x7A1205
180002ee7:     	jmp	0x180002eb3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1543>
180002ee9:     	decq	0xa0(%rsp)
180002ef1:     	movq	0x98(%rsp), %rax
180002ef9:     	cmpq	0x120(%rsp), %rax
180002f01:     	jne	0x1800025bd <PyInit_rcaotr_61fae00d4878711302f71448+0xc4d>
180002f07:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f0c:     	movq	(%rbp), %r8
180002f10:     	leaq	0x6(%r8), %r9
180002f14:     	cmpq	0x260(%rsp), %r9
180002f1c:     	jg	0x180002051 <PyInit_rcaotr_61fae00d4878711302f71448+0x6e1>
180002f22:     	movsd	(%r14,%rax,8), %xmm2
180002f28:     	movsd	0x10(%r14,%rax,8), %xmm3
180002f2f:     	movsd	0x20(%r14,%rax,8), %xmm4
180002f36:     	movq	%r9, (%rbp)
180002f3a:     	cmpb	$0x0, (%r13)
180002f3f:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f45:     	movsd	0x649b(%rip), %xmm5     # 0x1800093e8
180002f4d:     	divsd	%xmm1, %xmm5
180002f51:     	mulsd	%xmm5, %xmm2
180002f55:     	mulsd	%xmm5, %xmm3
180002f59:     	mulsd	%xmm4, %xmm5
180002f5d:     	leaq	(,%r8,8), %r9
180002f65:     	movsd	%xmm2, (%r14,%r8,8)
180002f6b:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002f72:     	movsd	%xmm5, 0x20(%r14,%r8,8)
180002f79:     	movzbl	(%r13), %eax
180002f7e:     	testb	%al, %al
180002f80:     	movq	$-0x8, %r8
180002f87:     	cmoveq	%r9, %r8
180002f8b:     	movq	%r8, 0xa8(%rsp)
180002f93:     	testb	%al, %al
180002f95:     	jne	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002f9b:     	jmp	0x18000252b <PyInit_rcaotr_61fae00d4878711302f71448+0xbbb>
180002fa0:     	movb	$0x1, (%r13)
180002fa5:     	movq	$0x13, 0x18(%rbp)
180002fad:     	jmp	0x180001b7d <PyInit_rcaotr_61fae00d4878711302f71448+0x20d>
180002fb2:     	movq	%rdi, %rsi
180002fb5:     	jmp	0x180001b7f <PyInit_rcaotr_61fae00d4878711302f71448+0x20f>
180002fba:     	nopw	(%rax,%rax)
180002fc0:     	pushq	%r15
180002fc2:     	pushq	%r14
180002fc4:     	pushq	%r13
180002fc6:     	pushq	%r12
180002fc8:     	pushq	%rsi
180002fc9:     	pushq	%rdi
180002fca:     	pushq	%rbp
180002fcb:     	pushq	%rbx
180002fcc:     	subq	$0x2a8, %rsp            # imm = 0x2A8
180002fd3:     	movapd	%xmm15, 0x290(%rsp)
180002fdd:     	movapd	%xmm14, 0x280(%rsp)
180002fe7:     	movapd	%xmm13, 0x270(%rsp)
180002ff1:     	movapd	%xmm12, 0x260(%rsp)
180002ffb:     	movapd	%xmm11, 0x250(%rsp)
180003005:     	movapd	%xmm10, 0x240(%rsp)
18000300f:     	movapd	%xmm9, 0x230(%rsp)
180003019:     	movapd	%xmm8, 0x220(%rsp)
180003023:     	movapd	%xmm7, 0x210(%rsp)
18000302c:     	movapd	%xmm6, 0x200(%rsp)
180003035:     	movq	0x328(%rsp), %rax
18000303d:     	movq	0x320(%rsp), %r15
180003045:     	movq	0x318(%rsp), %rbx
18000304d:     	movq	0x310(%rsp), %r14
180003055:     	movq	$0x0, 0x198(%rsp)
180003061:     	movb	$0x0, 0x1a0(%rsp)
180003069:     	movq	$0x0, 0x1a8(%rsp)
180003075:     	movb	$0x0, 0x1b0(%rsp)
18000307d:     	movq	$0x0, 0x1b8(%rsp)
180003089:     	movb	$0x0, 0x1c0(%rsp)
180003091:     	movq	$0x0, 0x1c8(%rsp)
18000309d:     	movb	$0x0, 0x1d0(%rsp)
1800030a5:     	movq	$0x0, 0x1d8(%rsp)
1800030b1:     	movb	$0x0, 0x1e0(%rsp)
1800030b9:     	movq	$0x0, 0x1e8(%rsp)
1800030c5:     	movb	$0x0, 0x1f0(%rsp)
1800030cd:     	movq	$0x0, 0x138(%rsp)
1800030d9:     	movb	$0x0, 0x140(%rsp)
1800030e1:     	movq	$0x0, 0x148(%rsp)
1800030ed:     	movb	$0x0, 0x150(%rsp)
1800030f5:     	movq	$0x0, 0x158(%rsp)
180003101:     	movb	$0x0, 0x160(%rsp)
180003109:     	movq	$0x0, 0x168(%rsp)
180003115:     	movb	$0x0, 0x170(%rsp)
18000311d:     	movq	$0x0, 0x178(%rsp)
180003129:     	movb	$0x0, 0x180(%rsp)
180003131:     	movq	$0x0, 0x188(%rsp)
18000313d:     	movb	$0x0, 0x190(%rsp)
180003145:     	cmpq	$0x1, %rax
180003149:     	je	0x1800031b0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1840>
18000314b:     	testq	%rax, %rax
18000314e:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003154:     	movq	0x330(%rsp), %rdi
18000315c:     	movq	0x28(%r9,%rdi,8), %rdx
180003161:     	cmpq	$0x3, %rdx
180003165:     	jle	0x1800032b2 <PyInit_rcaotr_61fae00d4878711302f71448+0x1942>
18000316b:     	movb	$0x0, 0x58(%rcx)
18000316f:     	movq	$0x0, 0x50(%rcx)
180003177:     	movb	$0x0, 0x48(%rcx)
18000317b:     	movq	$0x0, 0x40(%rcx)
180003183:     	movb	$0x0, 0x38(%rcx)
180003187:     	movq	$0x0, 0x30(%rcx)
18000318f:     	movb	$0x1, 0x28(%rcx)
180003193:     	movq	$0x0, 0x20(%rcx)
18000319b:     	movb	$0x1, 0x18(%rcx)
18000319f:     	movq	$0x0, 0x10(%rcx)
1800031a7:     	movb	$0x1, 0x8(%rcx)
1800031ab:     	jmp	0x180005880 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f10>
1800031b0:     	movq	0x358(%rsp), %r13
1800031b8:     	movq	0x340(%rsp), %r12
1800031c0:     	movq	%r12, %rdx
1800031c3:     	sarq	$0x3f, %rdx
1800031c7:     	andq	%r15, %rdx
1800031ca:     	leaq	(%r9,%r12,8), %rax
1800031ce:     	movq	(%rax,%rdx,8), %rdx
1800031d2:     	testq	%rdx, %rdx
1800031d5:     	je	0x180003c99 <PyInit_rcaotr_61fae00d4878711302f71448+0x2329>
1800031db:     	cmpq	$0x1, %rdx
1800031df:     	jne	0x180003cdf <PyInit_rcaotr_61fae00d4878711302f71448+0x236f>
1800031e5:     	cmpb	$0x0, (%rbx)
1800031e8:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800031ee:     	movq	0x8(%r9), %rdx
1800031f2:     	movsd	(%r8,%r13,8), %xmm0
1800031f8:     	subsd	(%r8,%rdx,8), %xmm0
1800031fe:     	movapd	0x61ca(%rip), %xmm1     # 0x1800093d0
180003206:     	andpd	%xmm0, %xmm1
18000320a:     	ucomisd	0x61ce(%rip), %xmm1     # 0x1800093e0
180003212:     	jae	0x180003cef <PyInit_rcaotr_61fae00d4878711302f71448+0x237f>
180003218:     	movsd	0x10(%r8,%r13,8), %xmm1
18000321f:     	subsd	0x10(%r8,%rdx,8), %xmm1
180003226:     	movapd	0x61a2(%rip), %xmm2     # 0x1800093d0
18000322e:     	andpd	%xmm1, %xmm2
180003232:     	ucomisd	0x61a6(%rip), %xmm2     # 0x1800093e0
18000323a:     	jae	0x180003cef <PyInit_rcaotr_61fae00d4878711302f71448+0x237f>
180003240:     	movsd	0x20(%r8,%r13,8), %xmm2
180003247:     	subsd	0x20(%r8,%rdx,8), %xmm2
18000324e:     	movapd	0x617a(%rip), %xmm3     # 0x1800093d0
180003256:     	andpd	%xmm2, %xmm3
18000325a:     	ucomisd	0x617e(%rip), %xmm3     # 0x1800093e0
180003262:     	jae	0x180003cef <PyInit_rcaotr_61fae00d4878711302f71448+0x237f>
180003268:     	movq	(%r14), %r11
18000326b:     	leaq	0x6(%r11), %rdx
18000326f:     	movb	$0x2, %r10b
180003272:     	cmpq	%r15, %rdx
180003275:     	jg	0x180003f27 <PyInit_rcaotr_61fae00d4878711302f71448+0x25b7>
18000327b:     	movq	%rdx, (%r14)
18000327e:     	cmpb	$0x0, (%rbx)
180003281:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003287:     	movsd	%xmm0, (%r8,%r11,8)
18000328d:     	movsd	%xmm1, 0x10(%r8,%r11,8)
180003294:     	movsd	%xmm2, 0x20(%r8,%r11,8)
18000329b:     	movzbl	(%rbx), %r10d
18000329f:     	xorl	%edx, %edx
1800032a1:     	movl	%r10d, %esi
1800032a4:     	negb	%sil
1800032a7:     	sbbq	%rdx, %rdx
1800032aa:     	orq	%r11, %rdx
1800032ad:     	jmp	0x180003d05 <PyInit_rcaotr_61fae00d4878711302f71448+0x2395>
1800032b2:     	leaq	0x1(%rdx), %rax
1800032b6:     	notq	%rdx
1800032b9:     	testq	%rdx, %rax
1800032bc:     	js	0x180005825 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb5>
1800032c2:     	cmpb	$0x0, (%rbx)
1800032c5:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800032cb:     	movq	%rax, 0x28(%r9,%rdi,8)
1800032d0:     	movq	(%r14), %rax
1800032d3:     	cmpq	%r15, %rax
1800032d6:     	movq	%rax, %rdx
1800032d9:     	jle	0x1800032e3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1973>
1800032db:     	movb	$0x2, (%rbx)
1800032de:     	movq	(%r14), %rax
1800032e1:     	xorl	%edx, %edx
1800032e3:     	leaq	0x3(%rax), %r10
1800032e7:     	cmpq	%r15, %r10
1800032ea:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
1800032f0:     	movq	%r10, (%r14)
1800032f3:     	cmpb	$0x0, (%rbx)
1800032f6:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800032fc:     	movq	%rax, %r12
1800032ff:     	sarq	$0x3f, %r12
180003303:     	andq	%r15, %r12
180003306:     	leaq	(%r9,%rax,8), %r10
18000330a:     	movq	$0x0, (%r10,%r12,8)
180003312:     	xorl	%r11d, %r11d
180003315:     	cmpq	$-0x1, %rax
180003319:     	movl	$0x0, %esi
18000331e:     	cmovlq	%r15, %rsi
180003322:     	movq	$0x0, 0x8(%r10,%rsi,8)
18000332b:     	cmpq	$-0x2, %rax
18000332f:     	cmovlq	%r15, %r11
180003333:     	movq	%rdx, 0x10(%r10,%r11,8)
180003338:     	cmpb	$0x0, (%rbx)
18000333b:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003341:     	movq	%r10, 0xc0(%rsp)
180003349:     	movq	0x18(%r9,%rdi,8), %rax
18000334e:     	movq	%rax, %rdx
180003351:     	sarq	$0x3f, %rdx
180003355:     	andq	%r15, %rdx
180003358:     	leaq	(%r9,%rax,8), %r10
18000335c:     	movq	%rdx, 0x118(%rsp)
180003364:     	cmpq	$0x0, (%r10,%rdx,8)
180003369:     	jle	0x1800052e2 <PyInit_rcaotr_61fae00d4878711302f71448+0x3972>
18000336f:     	movq	%r11, 0xb8(%rsp)
180003377:     	leaq	(,%r15,8), %rdx
18000337f:     	cmpq	$-0x2, %rax
180003383:     	movl	$0x0, %eax
180003388:     	cmovlq	%rdx, %rax
18000338c:     	movq	%rax, 0x120(%rsp)
180003394:     	xorl	%edx, %edx
180003396:     	shlq	$0x3, %r12
18000339a:     	leaq	0x8(,%r15,8), %r11
1800033a2:     	leaq	0x10(,%r15,8), %r13
1800033aa:     	leaq	0x18(,%r15,8), %rax
1800033b2:     	movq	%rax, 0x90(%rsp)
1800033ba:     	leaq	0x20(,%r15,8), %rax
1800033c2:     	movq	%rax, 0xa0(%rsp)
1800033ca:     	leaq	0x28(,%r15,8), %rax
1800033d2:     	movq	%rax, 0xd0(%rsp)
1800033da:     	leaq	0x30(,%r15,8), %rax
1800033e2:     	movq	%rax, 0xf8(%rsp)
1800033ea:     	leaq	0x38(,%r15,8), %rax
1800033f2:     	movq	%rax, 0xe0(%rsp)
1800033fa:     	movapd	0x5fce(%rip), %xmm0     # 0x1800093d0
180003402:     	movsd	0x5fd6(%rip), %xmm1     # 0x1800093e0
18000340a:     	movsd	0x5ffe(%rip), %xmm2     # 0x180009410
180003412:     	movq	%rsi, 0xf0(%rsp)
18000341a:     	movq	%r12, 0x100(%rsp)
180003422:     	movq	%r10, 0x110(%rsp)
18000342a:     	movq	%r11, 0xd8(%rsp)
180003432:     	movq	0x120(%rsp), %rax
18000343a:     	movq	0x10(%r10,%rax), %rax
18000343f:     	movq	%rdx, 0x130(%rsp)
180003447:     	addq	%rdx, %rax
18000344a:     	leaq	(%r9,%rax,8), %rdx
18000344e:     	sarq	$0x3f, %rax
180003452:     	andq	%r15, %rax
180003455:     	movq	(%rdx,%rax,8), %rax
180003459:     	movq	%rax, %rdx
18000345c:     	sarq	$0x3f, %rdx
180003460:     	andq	%r15, %rdx
180003463:     	leaq	(%r9,%rax,8), %r10
180003467:     	movq	(%r10,%rdx,8), %rsi
18000346b:     	cmpq	$-0x1, %rax
18000346f:     	movl	$0x0, %eax
180003474:     	cmovlq	%r15, %rax
180003478:     	movq	0x8(%r10,%rax,8), %rax
18000347d:     	movq	%rax, 0x128(%rsp)
180003485:     	movq	%rsi, %rdx
180003488:     	sarq	$0x3f, %rdx
18000348c:     	andq	%r15, %rdx
18000348f:     	leaq	(%r9,%rsi,8), %rax
180003493:     	movq	(%rax,%rdx,8), %rdx
180003497:     	testq	%rdx, %rdx
18000349a:     	je	0x180003580 <PyInit_rcaotr_61fae00d4878711302f71448+0x1c10>
1800034a0:     	cmpq	$0x1, %rdx
1800034a4:     	movq	0xb8(%rsp), %r11
1800034ac:     	jne	0x18000599d <PyInit_rcaotr_61fae00d4878711302f71448+0x402d>
1800034b2:     	cmpb	$0x0, (%rbx)
1800034b5:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800034bb:     	movq	0x338(%rsp), %rdx
1800034c3:     	movq	0x8(%r9,%rdx,8), %rdx
1800034c8:     	movq	0x20(%rax), %rax
1800034cc:     	movsd	(%r8,%rdx,8), %xmm4
1800034d2:     	mulsd	(%r8,%rax,8), %xmm4
1800034d8:     	movapd	%xmm4, %xmm3
1800034dc:     	andpd	%xmm0, %xmm3
1800034e0:     	ucomisd	%xmm1, %xmm3
1800034e4:     	jae	0x180003641 <PyInit_rcaotr_61fae00d4878711302f71448+0x1cd1>
1800034ea:     	movsd	0x10(%r8,%rdx,8), %xmm3
1800034f1:     	mulsd	0x10(%r8,%rax,8), %xmm3
1800034f8:     	movapd	%xmm3, %xmm5
1800034fc:     	andpd	%xmm0, %xmm5
180003500:     	ucomisd	%xmm1, %xmm5
180003504:     	jae	0x180003641 <PyInit_rcaotr_61fae00d4878711302f71448+0x1cd1>
18000350a:     	addsd	%xmm3, %xmm4
18000350e:     	movapd	%xmm4, %xmm3
180003512:     	andpd	%xmm0, %xmm3
180003516:     	ucomisd	%xmm1, %xmm3
18000351a:     	jae	0x180003641 <PyInit_rcaotr_61fae00d4878711302f71448+0x1cd1>
180003520:     	movsd	0x20(%r8,%rdx,8), %xmm3
180003527:     	mulsd	0x20(%r8,%rax,8), %xmm3
18000352e:     	movapd	%xmm3, %xmm5
180003532:     	andpd	%xmm0, %xmm5
180003536:     	ucomisd	%xmm1, %xmm5
18000353a:     	jae	0x180003641 <PyInit_rcaotr_61fae00d4878711302f71448+0x1cd1>
180003540:     	addsd	%xmm3, %xmm4
180003544:     	movapd	%xmm4, %xmm3
180003548:     	andpd	%xmm0, %xmm3
18000354c:     	ucomisd	%xmm1, %xmm3
180003550:     	jae	0x180003641 <PyInit_rcaotr_61fae00d4878711302f71448+0x1cd1>
180003556:     	xorpd	%xmm3, %xmm3
18000355a:     	ucomisd	%xmm3, %xmm4
18000355e:     	jne	0x180003566 <PyInit_rcaotr_61fae00d4878711302f71448+0x1bf6>
180003560:     	jnp	0x180003c88 <PyInit_rcaotr_61fae00d4878711302f71448+0x2318>
180003566:     	movapd	%xmm2, %xmm3
18000356a:     	divsd	%xmm4, %xmm3
18000356e:     	movl	$0x1, %eax
180003573:     	movq	%rax, 0x80(%rsp)
18000357b:     	jmp	0x180003874 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f04>
180003580:     	cmpb	$0x0, (%rbx)
180003583:     	movq	0xb8(%rsp), %r11
18000358b:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003591:     	movq	0x8(%rax), %rdx
180003595:     	movq	0x338(%rsp), %rax
18000359d:     	movq	(%r9,%rax,8), %rax
1800035a1:     	movsd	(%r8,%rdx,8), %xmm3
1800035a7:     	subsd	(%r8,%rax,8), %xmm3
1800035ad:     	movapd	%xmm3, %xmm4
1800035b1:     	andpd	%xmm0, %xmm4
1800035b5:     	ucomisd	%xmm1, %xmm4
1800035b9:     	jae	0x18000366a <PyInit_rcaotr_61fae00d4878711302f71448+0x1cfa>
1800035bf:     	movsd	0x10(%r8,%rdx,8), %xmm4
1800035c6:     	subsd	0x10(%r8,%rax,8), %xmm4
1800035cd:     	movapd	%xmm4, %xmm5
1800035d1:     	andpd	%xmm0, %xmm5
1800035d5:     	ucomisd	%xmm1, %xmm5
1800035d9:     	jae	0x18000366a <PyInit_rcaotr_61fae00d4878711302f71448+0x1cfa>
1800035df:     	movsd	0x20(%r8,%rdx,8), %xmm5
1800035e6:     	subsd	0x20(%r8,%rax,8), %xmm5
1800035ed:     	movapd	%xmm5, %xmm6
1800035f1:     	andpd	%xmm0, %xmm6
1800035f5:     	ucomisd	%xmm1, %xmm6
1800035f9:     	jae	0x18000366a <PyInit_rcaotr_61fae00d4878711302f71448+0x1cfa>
1800035fb:     	movq	(%r14), %rdx
1800035fe:     	leaq	0x6(%rdx), %rax
180003602:     	cmpq	%r15, %rax
180003605:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
18000360b:     	movq	%rax, (%r14)
18000360e:     	cmpb	$0x0, (%rbx)
180003611:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003617:     	movsd	%xmm3, (%r8,%rdx,8)
18000361d:     	movsd	%xmm4, 0x10(%r8,%rdx,8)
180003624:     	movsd	%xmm5, 0x20(%r8,%rdx,8)
18000362b:     	movzbl	(%rbx), %r10d
18000362f:     	movl	%r10d, %eax
180003632:     	negb	%al
180003634:     	movl	$0x0, %eax
180003639:     	sbbq	%rax, %rax
18000363c:     	orq	%rdx, %rax
18000363f:     	jmp	0x180003680 <PyInit_rcaotr_61fae00d4878711302f71448+0x1d10>
180003641:     	movb	$0x1, (%rbx)
180003644:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
18000364c:     	cmpb	$0x0, (%rbx)
18000364f:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003655:     	xorpd	%xmm3, %xmm3
180003659:     	movq	$0x0, 0x80(%rsp)
180003665:     	jmp	0x180003874 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f04>
18000366a:     	movb	$0x1, (%rbx)
18000366d:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
180003675:     	movzbl	(%rbx), %r10d
180003679:     	movq	$-0x1, %rax
180003680:     	xorpd	%xmm3, %xmm3
180003684:     	testb	%r10b, %r10b
180003687:     	je	0x1800036a3 <PyInit_rcaotr_61fae00d4878711302f71448+0x1d33>
180003689:     	movq	$0x0, 0x80(%rsp)
180003695:     	cmpb	$0x0, (%rbx)
180003698:     	je	0x180003874 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f04>
18000369e:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800036a3:     	movq	0x338(%rsp), %rdx
1800036ab:     	movq	0x8(%r9,%rdx,8), %rdx
1800036b0:     	movsd	(%r8,%rax,8), %xmm4
1800036b6:     	mulsd	(%r8,%rdx,8), %xmm4
1800036bc:     	movapd	%xmm4, %xmm5
1800036c0:     	andpd	%xmm0, %xmm5
1800036c4:     	ucomisd	%xmm1, %xmm5
1800036c8:     	jae	0x180003726 <PyInit_rcaotr_61fae00d4878711302f71448+0x1db6>
1800036ca:     	movsd	0x10(%r8,%rax,8), %xmm5
1800036d1:     	mulsd	0x10(%r8,%rdx,8), %xmm5
1800036d8:     	movapd	%xmm5, %xmm6
1800036dc:     	andpd	%xmm0, %xmm6
1800036e0:     	ucomisd	%xmm1, %xmm6
1800036e4:     	jae	0x180003726 <PyInit_rcaotr_61fae00d4878711302f71448+0x1db6>
1800036e6:     	addsd	%xmm5, %xmm4
1800036ea:     	movapd	%xmm4, %xmm5
1800036ee:     	andpd	%xmm0, %xmm5
1800036f2:     	ucomisd	%xmm1, %xmm5
1800036f6:     	jae	0x180003726 <PyInit_rcaotr_61fae00d4878711302f71448+0x1db6>
1800036f8:     	movsd	0x20(%r8,%rax,8), %xmm5
1800036ff:     	mulsd	0x20(%r8,%rdx,8), %xmm5
180003706:     	movapd	%xmm5, %xmm6
18000370a:     	andpd	%xmm0, %xmm6
18000370e:     	ucomisd	%xmm1, %xmm6
180003712:     	jae	0x180003726 <PyInit_rcaotr_61fae00d4878711302f71448+0x1db6>
180003714:     	addsd	%xmm5, %xmm4
180003718:     	movapd	%xmm4, %xmm5
18000371c:     	andpd	%xmm0, %xmm5
180003720:     	ucomisd	%xmm1, %xmm5
180003724:     	jb	0x18000373e <PyInit_rcaotr_61fae00d4878711302f71448+0x1dce>
180003726:     	movb	$0x1, (%rbx)
180003729:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003731:     	xorpd	%xmm4, %xmm4
180003735:     	cmpb	$0x0, (%rbx)
180003738:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000373e:     	movsd	0x10(%r8,%rsi,8), %xmm5
180003745:     	mulsd	%xmm5, %xmm5
180003749:     	movapd	%xmm5, %xmm6
18000374d:     	andpd	%xmm0, %xmm6
180003751:     	ucomisd	%xmm1, %xmm6
180003755:     	jae	0x180003854 <PyInit_rcaotr_61fae00d4878711302f71448+0x1ee4>
18000375b:     	movsd	(%r8,%rax,8), %xmm6
180003761:     	mulsd	%xmm6, %xmm6
180003765:     	movapd	%xmm6, %xmm7
180003769:     	andpd	%xmm0, %xmm7
18000376d:     	ucomisd	%xmm1, %xmm7
180003771:     	jae	0x1800037cf <PyInit_rcaotr_61fae00d4878711302f71448+0x1e5f>
180003773:     	movsd	0x10(%r8,%rax,8), %xmm7
18000377a:     	mulsd	%xmm7, %xmm7
18000377e:     	movapd	%xmm7, %xmm8
180003783:     	andpd	%xmm0, %xmm8
180003788:     	ucomisd	%xmm1, %xmm8
18000378d:     	jae	0x1800037cf <PyInit_rcaotr_61fae00d4878711302f71448+0x1e5f>
18000378f:     	addsd	%xmm7, %xmm6
180003793:     	movapd	%xmm6, %xmm7
180003797:     	andpd	%xmm0, %xmm7
18000379b:     	ucomisd	%xmm1, %xmm7
18000379f:     	jae	0x1800037cf <PyInit_rcaotr_61fae00d4878711302f71448+0x1e5f>
1800037a1:     	movsd	0x20(%r8,%rax,8), %xmm7
1800037a8:     	mulsd	%xmm7, %xmm7
1800037ac:     	movapd	%xmm7, %xmm8
1800037b1:     	andpd	%xmm0, %xmm8
1800037b6:     	ucomisd	%xmm1, %xmm8
1800037bb:     	jae	0x1800037cf <PyInit_rcaotr_61fae00d4878711302f71448+0x1e5f>
1800037bd:     	addsd	%xmm7, %xmm6
1800037c1:     	movapd	%xmm6, %xmm7
1800037c5:     	andpd	%xmm0, %xmm7
1800037c9:     	ucomisd	%xmm1, %xmm7
1800037cd:     	jb	0x1800037e7 <PyInit_rcaotr_61fae00d4878711302f71448+0x1e77>
1800037cf:     	movb	$0x1, (%rbx)
1800037d2:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
1800037da:     	xorpd	%xmm6, %xmm6
1800037de:     	cmpb	$0x0, (%rbx)
1800037e1:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800037e7:     	movapd	%xmm4, %xmm7
1800037eb:     	mulsd	%xmm4, %xmm7
1800037ef:     	movapd	%xmm7, %xmm8
1800037f4:     	andpd	%xmm0, %xmm8
1800037f9:     	ucomisd	%xmm1, %xmm8
1800037fe:     	jae	0x180003854 <PyInit_rcaotr_61fae00d4878711302f71448+0x1ee4>
180003800:     	subsd	%xmm7, %xmm6
180003804:     	movapd	%xmm6, %xmm7
180003808:     	andpd	%xmm0, %xmm7
18000380c:     	ucomisd	%xmm1, %xmm7
180003810:     	jae	0x180003854 <PyInit_rcaotr_61fae00d4878711302f71448+0x1ee4>
180003812:     	subsd	%xmm6, %xmm5
180003816:     	movapd	%xmm5, %xmm6
18000381a:     	andpd	%xmm0, %xmm6
18000381e:     	ucomisd	%xmm1, %xmm6
180003822:     	jae	0x180003854 <PyInit_rcaotr_61fae00d4878711302f71448+0x1ee4>
180003824:     	ucomisd	%xmm5, %xmm3
180003828:     	ja	0x180003689 <PyInit_rcaotr_61fae00d4878711302f71448+0x1d19>
18000382e:     	xorps	%xmm3, %xmm3
180003831:     	sqrtsd	%xmm5, %xmm3
180003835:     	subsd	%xmm3, %xmm4
180003839:     	movl	$0x1, %eax
18000383e:     	movq	%rax, 0x80(%rsp)
180003846:     	movapd	%xmm4, %xmm3
18000384a:     	cmpb	$0x0, (%rbx)
18000384d:     	je	0x180003874 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f04>
18000384f:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003854:     	movb	$0x1, (%rbx)
180003857:     	movq	$0xe4e1c4, 0x18(%r14)   # imm = 0xE4E1C4
18000385f:     	movq	$0x0, 0x80(%rsp)
18000386b:     	cmpb	$0x0, (%rbx)
18000386e:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003874:     	movq	0xc0(%rsp), %rax
18000387c:     	movq	(%rax,%r12), %r10
180003880:     	movq	0xf0(%rsp), %rdx
180003888:     	cmpq	0x8(%rax,%rdx,8), %r10
18000388d:     	movq	%r10, 0xc8(%rsp)
180003895:     	jne	0x180003ba5 <PyInit_rcaotr_61fae00d4878711302f71448+0x2235>
18000389b:     	leaq	(%r10,%r10), %rdi
18000389f:     	testq	%r10, %r10
1800038a2:     	movl	$0x4, %eax
1800038a7:     	cmoveq	%rax, %rdi
1800038ab:     	movq	(%r14), %rbp
1800038ae:     	leaq	(%rbp,%rdi), %rdx
1800038b3:     	cmpq	%r15, %rdx
1800038b6:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
1800038bc:     	movq	%rdx, (%r14)
1800038bf:     	cmpb	$0x0, (%rbx)
1800038c2:     	movq	0xc0(%rsp), %rax
1800038ca:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800038d0:     	movq	%rsi, 0x108(%rsp)
1800038d8:     	testq	%r10, %r10
1800038db:     	jle	0x180003b6b <PyInit_rcaotr_61fae00d4878711302f71448+0x21fb>
1800038e1:     	movq	0xb8(%rsp), %rdx
1800038e9:     	movq	0x10(%rax,%rdx,8), %r11
1800038ee:     	movq	0xc8(%rsp), %rdx
1800038f6:     	movl	%edx, %r12d
1800038f9:     	andl	$0x7, %r12d
1800038fd:     	cmpq	$0x8, %rdx
180003901:     	jae	0x180003912 <PyInit_rcaotr_61fae00d4878711302f71448+0x1fa2>
180003903:     	xorl	%esi, %esi
180003905:     	leaq	(,%r15,8), %rbx
18000390d:     	jmp	0x180003b37 <PyInit_rcaotr_61fae00d4878711302f71448+0x21c7>
180003912:     	movq	%rdi, 0x88(%rsp)
18000391a:     	movq	%rdx, %rsi
18000391d:     	movabsq	$0x7ffffffffffffff8, %rax # imm = 0x7FFFFFFFFFFFFFF8
180003927:     	andq	%rax, %rsi
18000392a:     	leaq	(%r9,%r11,8), %rdx
18000392e:     	movq	%r13, 0xa8(%rsp)
180003936:     	movq	%rbp, 0x78(%rsp)
18000393b:     	leaq	(%r9,%rbp,8), %rbp
18000393f:     	xorl	%r13d, %r13d
180003942:     	leaq	(,%r15,8), %rbx
18000394a:     	leaq	(%r11,%r13), %r14
18000394e:     	movq	%rsi, %rax
180003951:     	movq	%r14, %rsi
180003954:     	sarq	$0x3f, %rsi
180003958:     	andq	%rbx, %rsi
18000395b:     	addq	%rdx, %rsi
18000395e:     	movq	(%rsi,%r13,8), %r10
180003962:     	movq	0x78(%rsp), %rsi
180003967:     	leaq	(%rsi,%r13), %rdi
18000396b:     	movq	%rdi, %rsi
18000396e:     	sarq	$0x3f, %rsi
180003972:     	andq	%rbx, %rsi
180003975:     	addq	%rbp, %rsi
180003978:     	movq	%r10, (%rsi,%r13,8)
18000397c:     	movq	%r14, %r10
18000397f:     	incq	%r10
180003982:     	movl	$0x8, %r10d
180003988:     	movq	0xd8(%rsp), %r15
180003990:     	cmovsq	%r15, %r10
180003994:     	addq	%rdx, %r10
180003997:     	movq	(%r10,%r13,8), %r10
18000399b:     	movq	%rdi, %rsi
18000399e:     	incq	%rsi
1800039a1:     	movl	$0x8, %esi
1800039a6:     	cmovsq	%r15, %rsi
1800039aa:     	addq	%rbp, %rsi
1800039ad:     	movq	%r10, (%rsi,%r13,8)
1800039b1:     	movq	%r14, %r10
1800039b4:     	addq	$0x2, %r10
1800039b8:     	movl	$0x10, %r10d
1800039be:     	movq	0xa8(%rsp), %r15
1800039c6:     	cmovsq	%r15, %r10
1800039ca:     	addq	%rdx, %r10
1800039cd:     	movq	(%r10,%r13,8), %r10
1800039d1:     	movq	%rdi, %rsi
1800039d4:     	addq	$0x2, %rsi
1800039d8:     	movl	$0x10, %esi
1800039dd:     	cmovsq	%r15, %rsi
1800039e1:     	addq	%rbp, %rsi
1800039e4:     	movq	%r10, (%rsi,%r13,8)
1800039e8:     	movq	%r14, %r10
1800039eb:     	addq	$0x3, %r10
1800039ef:     	movl	$0x18, %r10d
1800039f5:     	movq	0x90(%rsp), %r15
1800039fd:     	cmovsq	%r15, %r10
180003a01:     	addq	%rdx, %r10
180003a04:     	movq	(%r10,%r13,8), %r10
180003a08:     	movq	%rdi, %rsi
180003a0b:     	addq	$0x3, %rsi
180003a0f:     	movl	$0x18, %esi
180003a14:     	cmovsq	%r15, %rsi
180003a18:     	addq	%rbp, %rsi
180003a1b:     	movq	%r10, (%rsi,%r13,8)
180003a1f:     	movq	%r14, %r10
180003a22:     	addq	$0x4, %r10
180003a26:     	movl	$0x20, %r10d
180003a2c:     	movq	0xa0(%rsp), %r15
180003a34:     	cmovsq	%r15, %r10
180003a38:     	addq	%rdx, %r10
180003a3b:     	movq	(%r10,%r13,8), %r10
180003a3f:     	movq	%rdi, %rsi
180003a42:     	addq	$0x4, %rsi
180003a46:     	movl	$0x20, %esi
180003a4b:     	cmovsq	%r15, %rsi
180003a4f:     	addq	%rbp, %rsi
180003a52:     	movq	%r10, (%rsi,%r13,8)
180003a56:     	movq	%r14, %r10
180003a59:     	addq	$0x5, %r10
180003a5d:     	movl	$0x28, %r10d
180003a63:     	movq	0xd0(%rsp), %r15
180003a6b:     	cmovsq	%r15, %r10
180003a6f:     	addq	%rdx, %r10
180003a72:     	movq	(%r10,%r13,8), %r10
180003a76:     	movq	%rdi, %rsi
180003a79:     	addq	$0x5, %rsi
180003a7d:     	movl	$0x28, %esi
180003a82:     	cmovsq	%r15, %rsi
180003a86:     	addq	%rbp, %rsi
180003a89:     	movq	%r10, (%rsi,%r13,8)
180003a8d:     	movq	%r14, %r10
180003a90:     	addq	$0x6, %r10
180003a94:     	movl	$0x30, %r10d
180003a9a:     	movq	0xf8(%rsp), %r15
180003aa2:     	cmovsq	%r15, %r10
180003aa6:     	addq	%rdx, %r10
180003aa9:     	movq	(%r10,%r13,8), %r10
180003aad:     	movq	%rdi, %rsi
180003ab0:     	addq	$0x6, %rsi
180003ab4:     	movl	$0x30, %esi
180003ab9:     	cmovsq	%r15, %rsi
180003abd:     	addq	%rbp, %rsi
180003ac0:     	movq	%r10, (%rsi,%r13,8)
180003ac4:     	addq	$0x7, %r14
180003ac8:     	movl	$0x38, %r10d
180003ace:     	movq	0xe0(%rsp), %r14
180003ad6:     	cmovsq	%r14, %r10
180003ada:     	addq	%rdx, %r10
180003add:     	movq	(%r10,%r13,8), %r10
180003ae1:     	addq	$0x7, %rdi
180003ae5:     	movl	$0x38, %esi
180003aea:     	cmovsq	%r14, %rsi
180003aee:     	addq	%rbp, %rsi
180003af1:     	movq	%r10, (%rsi,%r13,8)
180003af5:     	movq	%rax, %rsi
180003af8:     	addq	$0x8, %r13
180003afc:     	cmpq	%r13, %rax
180003aff:     	jne	0x18000394a <PyInit_rcaotr_61fae00d4878711302f71448+0x1fda>
180003b05:     	testq	%r12, %r12
180003b08:     	movq	0x310(%rsp), %r14
180003b10:     	movq	0xc0(%rsp), %rax
180003b18:     	movq	0x320(%rsp), %r15
180003b20:     	movq	0xa8(%rsp), %r13
180003b28:     	movq	0x88(%rsp), %rdi
180003b30:     	movq	0x78(%rsp), %rbp
180003b35:     	je	0x180003b6b <PyInit_rcaotr_61fae00d4878711302f71448+0x21fb>
180003b37:     	leaq	(%rsi,%rbp), %rdx
180003b3b:     	addq	%rsi, %r11
180003b3e:     	movq	%r11, %r10
180003b41:     	sarq	$0x3f, %r10
180003b45:     	andq	%rbx, %r10
180003b48:     	addq	%r9, %r10
180003b4b:     	movq	(%r10,%r11,8), %r10
180003b4f:     	movq	%rdx, %rsi
180003b52:     	sarq	$0x3f, %rsi
180003b56:     	andq	%rbx, %rsi
180003b59:     	addq	%r9, %rsi
180003b5c:     	movq	%r10, (%rsi,%rdx,8)
180003b60:     	incq	%rdx
180003b63:     	incq	%r11
180003b66:     	decq	%r12
180003b69:     	jne	0x180003b3e <PyInit_rcaotr_61fae00d4878711302f71448+0x21ce>
180003b6b:     	movq	0xf0(%rsp), %rdx
180003b73:     	movq	%rdi, 0x8(%rax,%rdx,8)
180003b78:     	movq	0xb8(%rsp), %r11
180003b80:     	movq	%rbp, 0x10(%rax,%r11,8)
180003b85:     	movq	0x100(%rsp), %r12
180003b8d:     	movq	0x318(%rsp), %rbx
180003b95:     	movq	0x108(%rsp), %rsi
180003b9d:     	movq	0xc8(%rsp), %r10
180003ba5:     	leaq	0x1(%r10), %rdx
180003ba9:     	movq	%rdx, (%rax,%r12)
180003bad:     	cmpb	$0x0, (%rbx)
180003bb0:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003bb6:     	movq	(%r14), %rdx
180003bb9:     	leaq	0x4(%rdx), %r10
180003bbd:     	cmpq	%r15, %r10
180003bc0:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180003bc6:     	movq	%r12, %rbp
180003bc9:     	movq	0xc8(%rsp), %r12
180003bd1:     	addq	0x10(%rax,%r11,8), %r12
180003bd6:     	movq	%r10, (%r14)
180003bd9:     	cmpb	$0x0, (%rbx)
180003bdc:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003be2:     	movq	%r13, %rax
180003be5:     	movq	0x130(%rsp), %r13
180003bed:     	incq	%r13
180003bf0:     	movq	%rdx, %r10
180003bf3:     	sarq	$0x3f, %r10
180003bf7:     	andq	%r15, %r10
180003bfa:     	leaq	(%r9,%rdx,8), %r11
180003bfe:     	movq	%rsi, (%r11,%r10,8)
180003c02:     	cmpq	$-0x1, %rdx
180003c06:     	movl	$0x0, %r10d
180003c0c:     	cmovlq	%r15, %r10
180003c10:     	leaq	(%r8,%rdx,8), %rsi
180003c14:     	movsd	%xmm3, 0x8(%rsi,%r10,8)
180003c1b:     	cmpq	$-0x2, %rdx
180003c1f:     	movl	$0x0, %r10d
180003c25:     	cmovlq	%r15, %r10
180003c29:     	movq	0x80(%rsp), %rsi
180003c31:     	movq	%rsi, 0x10(%r11,%r10,8)
180003c36:     	cmpq	$-0x3, %rdx
180003c3a:     	movl	$0x0, %r10d
180003c40:     	cmovlq	%r15, %r10
180003c44:     	movq	0x128(%rsp), %rsi
180003c4c:     	movq	%rsi, 0x18(%r11,%r10,8)
180003c51:     	leaq	(%r9,%r12,8), %r10
180003c55:     	sarq	$0x3f, %r12
180003c59:     	andq	%r15, %r12
180003c5c:     	movq	%rdx, (%r10,%r12,8)
180003c60:     	movq	%r13, %rdx
180003c63:     	movq	%rax, %r13
180003c66:     	movq	0x118(%rsp), %rax
180003c6e:     	movq	0x110(%rsp), %r10
180003c76:     	cmpq	(%r10,%rax,8), %rdx
180003c7a:     	movq	%rbp, %r12
180003c7d:     	jl	0x180003432 <PyInit_rcaotr_61fae00d4878711302f71448+0x1ac2>
180003c83:     	jmp	0x1800057ca <PyInit_rcaotr_61fae00d4878711302f71448+0x3e5a>
180003c88:     	movq	$0x0, 0x80(%rsp)
180003c94:     	jmp	0x180003874 <PyInit_rcaotr_61fae00d4878711302f71448+0x1f04>
180003c99:     	movq	0x10(%rax), %rdx
180003c9d:     	xorl	%eax, %eax
180003c9f:     	cmpq	$-0x2, %rdx
180003ca3:     	movl	$0x0, %r10d
180003ca9:     	cmovlq	%r15, %r10
180003cad:     	cmpq	$-0x4, %rdx
180003cb1:     	cmovlq	%r15, %rax
180003cb5:     	cmpb	$0x0, (%rbx)
180003cb8:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003cbe:     	leaq	(%r8,%rdx,8), %r11
180003cc2:     	sarq	$0x3f, %rdx
180003cc6:     	andq	%r15, %rdx
180003cc9:     	movsd	(%r11,%rdx,8), %xmm8
180003ccf:     	movsd	0x10(%r11,%r10,8), %xmm7
180003cd6:     	movsd	0x20(%r11,%rax,8), %xmm6
180003cdd:     	jmp	0x180003d24 <PyInit_rcaotr_61fae00d4878711302f71448+0x23b4>
180003cdf:     	movb	$0x1, (%rbx)
180003ce2:     	movq	$0x1406f42, 0x18(%r14)  # imm = 0x1406F42
180003cea:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003cef:     	movb	$0x1, (%rbx)
180003cf2:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
180003cfa:     	movzbl	(%rbx), %r10d
180003cfe:     	movq	$-0x1, %rdx
180003d05:     	xorpd	%xmm6, %xmm6
180003d09:     	testb	%r10b, %r10b
180003d0c:     	je	0x180003f07 <PyInit_rcaotr_61fae00d4878711302f71448+0x2597>
180003d12:     	xorpd	%xmm7, %xmm7
180003d16:     	xorpd	%xmm8, %xmm8
180003d1b:     	cmpb	$0x0, (%rbx)
180003d1e:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003d24:     	movq	0x360(%rsp), %rbp
180003d2c:     	movq	0x348(%rsp), %rsi
180003d34:     	movsd	0x20(%r8,%r12,8), %xmm1
180003d3b:     	xorpd	%xmm0, %xmm0
180003d3f:     	ucomisd	%xmm0, %xmm1
180003d43:     	setbe	%dil
180003d47:     	ja	0x180003d92 <PyInit_rcaotr_61fae00d4878711302f71448+0x2422>
180003d49:     	shlq	$0x3, %r12
180003d4d:     	xorpd	%xmm1, %xmm1
180003d51:     	xorpd	%xmm2, %xmm2
180003d55:     	movsd	0x18(%r8,%r12), %xmm4
180003d5c:     	xorpd	%xmm3, %xmm3
180003d60:     	ucomisd	%xmm3, %xmm4
180003d64:     	jbe	0x180005938 <PyInit_rcaotr_61fae00d4878711302f71448+0x3fc8>
180003d6a:     	movq	(%r14), %r10
180003d6d:     	cmpq	%r15, %r10
180003d70:     	movq	%r10, %rdx
180003d73:     	jle	0x180003d7d <PyInit_rcaotr_61fae00d4878711302f71448+0x240d>
180003d75:     	movb	$0x2, (%rbx)
180003d78:     	movq	(%r14), %r10
180003d7b:     	xorl	%edx, %edx
180003d7d:     	leaq	0x3(%r10), %rax
180003d81:     	cmpq	%r15, %rax
180003d84:     	jle	0x18000400b <PyInit_rcaotr_61fae00d4878711302f71448+0x269b>
180003d8a:     	movb	$0x2, (%rbx)
180003d8d:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003d92:     	movq	0x350(%rsp), %rax
180003d9a:     	movq	0x8(%r9,%rax,8), %rax
180003d9f:     	movsd	(%r8,%rax,8), %xmm0
180003da5:     	mulsd	(%r8,%rbp,8), %xmm0
180003dab:     	movapd	0x561d(%rip), %xmm1     # 0x1800093d0
180003db3:     	andpd	%xmm0, %xmm1
180003db7:     	ucomisd	0x5621(%rip), %xmm1     # 0x1800093e0
180003dbf:     	jae	0x180003e3d <PyInit_rcaotr_61fae00d4878711302f71448+0x24cd>
180003dc1:     	movsd	0x10(%r8,%rax,8), %xmm1
180003dc8:     	mulsd	0x10(%r8,%rbp,8), %xmm1
180003dcf:     	movapd	0x55f9(%rip), %xmm2     # 0x1800093d0
180003dd7:     	andpd	%xmm1, %xmm2
180003ddb:     	ucomisd	0x55fd(%rip), %xmm2     # 0x1800093e0
180003de3:     	jae	0x180003e3d <PyInit_rcaotr_61fae00d4878711302f71448+0x24cd>
180003de5:     	addsd	%xmm1, %xmm0
180003de9:     	movapd	0x55df(%rip), %xmm1     # 0x1800093d0
180003df1:     	andpd	%xmm0, %xmm1
180003df5:     	ucomisd	0x55e3(%rip), %xmm1     # 0x1800093e0
180003dfd:     	jae	0x180003e3d <PyInit_rcaotr_61fae00d4878711302f71448+0x24cd>
180003dff:     	movsd	0x20(%r8,%rax,8), %xmm1
180003e06:     	mulsd	0x20(%r8,%rbp,8), %xmm1
180003e0d:     	movapd	0x55bb(%rip), %xmm2     # 0x1800093d0
180003e15:     	andpd	%xmm1, %xmm2
180003e19:     	ucomisd	0x55bf(%rip), %xmm2     # 0x1800093e0
180003e21:     	jae	0x180003e3d <PyInit_rcaotr_61fae00d4878711302f71448+0x24cd>
180003e23:     	addsd	%xmm1, %xmm0
180003e27:     	movapd	0x55a1(%rip), %xmm1     # 0x1800093d0
180003e2f:     	andpd	%xmm0, %xmm1
180003e33:     	ucomisd	0x55a5(%rip), %xmm1     # 0x1800093e0
180003e3b:     	jb	0x180003e55 <PyInit_rcaotr_61fae00d4878711302f71448+0x24e5>
180003e3d:     	movb	$0x1, (%rbx)
180003e40:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003e48:     	cmpb	$0x0, (%rbx)
180003e4b:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003e51:     	xorpd	%xmm0, %xmm0
180003e55:     	movsd	(%r8,%rbp,8), %xmm1
180003e5b:     	mulsd	%xmm0, %xmm1
180003e5f:     	movapd	0x5569(%rip), %xmm2     # 0x1800093d0
180003e67:     	andpd	%xmm1, %xmm2
180003e6b:     	ucomisd	0x556d(%rip), %xmm2     # 0x1800093e0
180003e73:     	jae	0x180003f2f <PyInit_rcaotr_61fae00d4878711302f71448+0x25bf>
180003e79:     	movsd	0x10(%r8,%rbp,8), %xmm2
180003e80:     	mulsd	%xmm0, %xmm2
180003e84:     	movapd	0x5544(%rip), %xmm3     # 0x1800093d0
180003e8c:     	andpd	%xmm2, %xmm3
180003e90:     	ucomisd	0x5548(%rip), %xmm3     # 0x1800093e0
180003e98:     	jae	0x180003f2f <PyInit_rcaotr_61fae00d4878711302f71448+0x25bf>
180003e9e:     	mulsd	0x20(%r8,%rbp,8), %xmm0
180003ea5:     	movapd	0x5523(%rip), %xmm3     # 0x1800093d0
180003ead:     	andpd	%xmm0, %xmm3
180003eb1:     	ucomisd	0x5527(%rip), %xmm3     # 0x1800093e0
180003eb9:     	jae	0x180003f2f <PyInit_rcaotr_61fae00d4878711302f71448+0x25bf>
180003ebb:     	movq	(%r14), %r10
180003ebe:     	leaq	0x6(%r10), %rdx
180003ec2:     	cmpq	%r15, %rdx
180003ec5:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180003ecb:     	movq	%rdx, (%r14)
180003ece:     	cmpb	$0x0, (%rbx)
180003ed1:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003ed7:     	movsd	%xmm1, (%r8,%r10,8)
180003edd:     	movsd	%xmm2, 0x10(%r8,%r10,8)
180003ee4:     	movsd	%xmm0, 0x20(%r8,%r10,8)
180003eeb:     	movzbl	(%rbx), %r11d
180003eef:     	xorl	%edx, %edx
180003ef1:     	movl	%r11d, %r14d
180003ef4:     	negb	%r14b
180003ef7:     	movq	0x310(%rsp), %r14
180003eff:     	sbbq	%rdx, %rdx
180003f02:     	orq	%r10, %rdx
180003f05:     	jmp	0x180003f45 <PyInit_rcaotr_61fae00d4878711302f71448+0x25d5>
180003f07:     	movq	0x28(%rax), %rsi
180003f0b:     	testq	%rsi, %rsi
180003f0e:     	je	0x180004d72 <PyInit_rcaotr_61fae00d4878711302f71448+0x3402>
180003f14:     	movq	(%r14), %r11
180003f17:     	leaq	0x6(%r11), %rdi
180003f1b:     	movb	$0x2, %r10b
180003f1e:     	cmpq	%r15, %rdi
180003f21:     	jle	0x180004d82 <PyInit_rcaotr_61fae00d4878711302f71448+0x3412>
180003f27:     	movb	%r10b, (%rbx)
180003f2a:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003f2f:     	movb	$0x1, (%rbx)
180003f32:     	movq	$0x1d905c2, 0x18(%r14)  # imm = 0x1D905C2
180003f3a:     	movzbl	(%rbx), %r11d
180003f3e:     	movq	$-0x1, %rdx
180003f45:     	testb	%r11b, %r11b
180003f48:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003f4e:     	movsd	(%r8,%rdx,8), %xmm0
180003f54:     	addsd	%xmm0, %xmm0
180003f58:     	movapd	0x5470(%rip), %xmm1     # 0x1800093d0
180003f60:     	andpd	%xmm0, %xmm1
180003f64:     	ucomisd	0x5474(%rip), %xmm1     # 0x1800093e0
180003f6c:     	jae	0x180004ee3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3573>
180003f72:     	movsd	0x10(%r8,%rdx,8), %xmm1
180003f79:     	addsd	%xmm1, %xmm1
180003f7d:     	movapd	0x544b(%rip), %xmm2     # 0x1800093d0
180003f85:     	andpd	%xmm1, %xmm2
180003f89:     	ucomisd	0x544f(%rip), %xmm2     # 0x1800093e0
180003f91:     	jae	0x180004ee3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3573>
180003f97:     	movsd	0x20(%r8,%rdx,8), %xmm2
180003f9e:     	addsd	%xmm2, %xmm2
180003fa2:     	movapd	0x5426(%rip), %xmm3     # 0x1800093d0
180003faa:     	andpd	%xmm2, %xmm3
180003fae:     	ucomisd	0x542a(%rip), %xmm3     # 0x1800093e0
180003fb6:     	jae	0x180004ee3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3573>
180003fbc:     	movq	(%r14), %r10
180003fbf:     	leaq	0x6(%r10), %rdx
180003fc3:     	cmpq	%r15, %rdx
180003fc6:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180003fcc:     	movq	%rdx, (%r14)
180003fcf:     	cmpb	$0x0, (%rbx)
180003fd2:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180003fd8:     	movsd	%xmm0, (%r8,%r10,8)
180003fde:     	movsd	%xmm1, 0x10(%r8,%r10,8)
180003fe5:     	movsd	%xmm2, 0x20(%r8,%r10,8)
180003fec:     	movzbl	(%rbx), %r11d
180003ff0:     	xorl	%edx, %edx
180003ff2:     	movl	%r11d, %r14d
180003ff5:     	negb	%r14b
180003ff8:     	movq	0x310(%rsp), %r14
180004000:     	sbbq	%rdx, %rdx
180004003:     	orq	%r10, %rdx
180004006:     	jmp	0x180004ef9 <PyInit_rcaotr_61fae00d4878711302f71448+0x3589>
18000400b:     	movq	0x310(%rsp), %r11
180004013:     	movq	%rax, (%r11)
180004016:     	cmpb	$0x0, (%rbx)
180004019:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000401f:     	movq	%r10, %rax
180004022:     	sarq	$0x3f, %rax
180004026:     	andq	%r15, %rax
180004029:     	leaq	(%r9,%r10,8), %r11
18000402d:     	movq	%rax, 0xa0(%rsp)
180004035:     	movq	$0x0, (%r11,%rax,8)
18000403d:     	xorl	%eax, %eax
18000403f:     	cmpq	$-0x1, %r10
180004043:     	movl	$0x0, %edi
180004048:     	cmovlq	%r15, %rdi
18000404c:     	movq	%rdi, 0xc8(%rsp)
180004054:     	movq	$0x0, 0x8(%r11,%rdi,8)
18000405d:     	cmpq	$-0x2, %r10
180004061:     	cmovlq	%r15, %rax
180004065:     	movq	%r11, 0x90(%rsp)
18000406d:     	movq	%rax, 0xd8(%rsp)
180004075:     	movq	%rdx, 0x10(%r11,%rax,8)
18000407a:     	cmpb	$0x0, (%rbx)
18000407d:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004083:     	movq	0x8(%r9,%rsi,8), %rax
180004088:     	movq	%rax, %rdx
18000408b:     	sarq	$0x3f, %rdx
18000408f:     	andq	%r15, %rdx
180004092:     	leaq	(%r9,%rax,8), %r11
180004096:     	cmpq	$0x0, (%r11,%rdx,8)
18000409b:     	jle	0x180005438 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ac8>
1800040a1:     	movq	%rdx, 0xb8(%rsp)
1800040a9:     	leaq	(,%r15,8), %rdi
1800040b1:     	xorl	%r14d, %r14d
1800040b4:     	cmpq	$-0x2, %rax
1800040b8:     	movl	$0x0, %eax
1800040bd:     	cmovlq	%rdi, %rax
1800040c1:     	shlq	$0x3, 0xa0(%rsp)
1800040ca:     	movapd	0x52fe(%rip), %xmm4     # 0x1800093d0
1800040d2:     	movsd	0x5306(%rip), %xmm5     # 0x1800093e0
1800040da:     	xorpd	%xmm9, %xmm9
1800040df:     	movq	%r11, 0x130(%rsp)
1800040e7:     	movq	%rax, 0x128(%rsp)
1800040ef:     	movq	0x10(%r11,%rax), %rax
1800040f4:     	addq	%r14, %rax
1800040f7:     	leaq	(%r9,%rax,8), %rdx
1800040fb:     	sarq	$0x3f, %rax
1800040ff:     	andq	%r15, %rax
180004102:     	movq	(%rdx,%rax,8), %rax
180004106:     	movq	%rax, 0xf8(%rsp)
18000410e:     	incq	%r14
180004111:     	movq	%r14, 0xc0(%rsp)
180004119:     	movq	0x18(%r9,%rsi,8), %rax
18000411e:     	leaq	(%r9,%rax,8), %rdx
180004122:     	movq	%rdx, 0xa8(%rsp)
18000412a:     	movq	%rax, %rdx
18000412d:     	sarq	$0x3f, %rdx
180004131:     	andq	%rdi, %rdx
180004134:     	movq	%rdx, 0xd0(%rsp)
18000413c:     	cmpq	$-0x2, %rax
180004140:     	movl	$0x0, %eax
180004145:     	cmovlq	%rdi, %rax
180004149:     	movq	%rax, 0xe0(%rsp)
180004151:     	movq	$0x0, 0x78(%rsp)
18000415a:     	movq	0xa8(%rsp), %rax
180004162:     	movq	0xd0(%rsp), %rdx
18000416a:     	movq	0x78(%rsp), %r11
18000416f:     	cmpq	(%rax,%rdx), %r11
180004173:     	jge	0x180004896 <PyInit_rcaotr_61fae00d4878711302f71448+0x2f26>
180004179:     	cmpb	$0x0, (%rbx)
18000417c:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004182:     	movq	0xa8(%rsp), %rax
18000418a:     	movq	0xe0(%rsp), %rdx
180004192:     	movq	0x10(%rax,%rdx), %rax
180004197:     	addq	0x78(%rsp), %rax
18000419c:     	leaq	(%r9,%rax,8), %rdx
1800041a0:     	sarq	$0x3f, %rax
1800041a4:     	andq	%r15, %rax
1800041a7:     	movq	(%rdx,%rax,8), %rax
1800041ab:     	leaq	(%r9,%rax,8), %rdx
1800041af:     	sarq	$0x3f, %rax
1800041b3:     	andq	%r15, %rax
1800041b6:     	movq	(%rdx,%rax,8), %r11
1800041ba:     	movq	0xf8(%rsp), %rax
1800041c2:     	movsd	(%r8,%rax,8), %xmm11
1800041c8:     	subsd	(%r8,%r13,8), %xmm11
1800041ce:     	movapd	%xmm11, %xmm12
1800041d3:     	andpd	%xmm4, %xmm12
1800041d8:     	ucomisd	%xmm5, %xmm12
1800041dd:     	jae	0x180004275 <PyInit_rcaotr_61fae00d4878711302f71448+0x2905>
1800041e3:     	movsd	0x10(%r8,%rax,8), %xmm13
1800041ea:     	subsd	0x10(%r8,%r13,8), %xmm13
1800041f1:     	movapd	%xmm13, %xmm12
1800041f6:     	andpd	%xmm4, %xmm12
1800041fb:     	ucomisd	%xmm5, %xmm12
180004200:     	jae	0x180004275 <PyInit_rcaotr_61fae00d4878711302f71448+0x2905>
180004202:     	movsd	0x20(%r8,%rax,8), %xmm14
180004209:     	subsd	0x20(%r8,%r13,8), %xmm14
180004210:     	movapd	%xmm14, %xmm12
180004215:     	andpd	%xmm4, %xmm12
18000421a:     	ucomisd	%xmm5, %xmm12
18000421f:     	jae	0x180004275 <PyInit_rcaotr_61fae00d4878711302f71448+0x2905>
180004221:     	movq	0x310(%rsp), %rax
180004229:     	movq	(%rax), %rdi
18000422c:     	leaq	0x6(%rdi), %rax
180004230:     	cmpq	%r15, %rax
180004233:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180004239:     	movq	0x310(%rsp), %rdx
180004241:     	movq	%rax, (%rdx)
180004244:     	cmpb	$0x0, (%rbx)
180004247:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000424d:     	movsd	%xmm11, (%r8,%rdi,8)
180004253:     	movsd	%xmm13, 0x10(%r8,%rdi,8)
18000425a:     	movsd	%xmm14, 0x20(%r8,%rdi,8)
180004261:     	movzbl	(%rbx), %eax
180004264:     	movl	%eax, %edx
180004266:     	negb	%dl
180004268:     	movl	$0x0, %edx
18000426d:     	sbbq	%rdx, %rdx
180004270:     	orq	%rdi, %rdx
180004273:     	jmp	0x180004292 <PyInit_rcaotr_61fae00d4878711302f71448+0x2922>
180004275:     	movb	$0x1, (%rbx)
180004278:     	movq	0x310(%rsp), %rax
180004280:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
180004288:     	movzbl	(%rbx), %eax
18000428b:     	movq	$-0x1, %rdx
180004292:     	testb	%al, %al
180004294:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000429a:     	movq	0x310(%rsp), %rax
1800042a2:     	movq	(%rax), %rdi
1800042a5:     	leaq	0x2(%rdi), %rax
1800042a9:     	cmpq	%r15, %rax
1800042ac:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
1800042b2:     	movq	0x310(%rsp), %r14
1800042ba:     	movq	%rax, (%r14)
1800042bd:     	cmpb	$0x0, (%rbx)
1800042c0:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800042c6:     	movq	%r13, (%r9,%rdi,8)
1800042ca:     	cmpb	$0x0, (%rbx)
1800042cd:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800042d3:     	movsd	(%r8,%rdx,8), %xmm11
1800042d9:     	mulsd	%xmm11, %xmm11
1800042de:     	movapd	%xmm11, %xmm12
1800042e3:     	andpd	%xmm4, %xmm12
1800042e8:     	ucomisd	%xmm5, %xmm12
1800042ed:     	jae	0x180004355 <PyInit_rcaotr_61fae00d4878711302f71448+0x29e5>
1800042ef:     	movsd	0x10(%r8,%rdx,8), %xmm13
1800042f6:     	mulsd	%xmm13, %xmm13
1800042fb:     	movapd	%xmm13, %xmm12
180004300:     	andpd	%xmm4, %xmm12
180004305:     	ucomisd	%xmm5, %xmm12
18000430a:     	jae	0x180004355 <PyInit_rcaotr_61fae00d4878711302f71448+0x29e5>
18000430c:     	addsd	%xmm13, %xmm11
180004311:     	movapd	%xmm11, %xmm12
180004316:     	andpd	%xmm4, %xmm12
18000431b:     	ucomisd	%xmm5, %xmm12
180004320:     	jae	0x180004355 <PyInit_rcaotr_61fae00d4878711302f71448+0x29e5>
180004322:     	movsd	0x20(%r8,%rdx,8), %xmm13
180004329:     	mulsd	%xmm13, %xmm13
18000432e:     	movapd	%xmm13, %xmm12
180004333:     	andpd	%xmm4, %xmm12
180004338:     	ucomisd	%xmm5, %xmm12
18000433d:     	jae	0x180004355 <PyInit_rcaotr_61fae00d4878711302f71448+0x29e5>
18000433f:     	addsd	%xmm13, %xmm11
180004344:     	movapd	%xmm11, %xmm12
180004349:     	andpd	%xmm4, %xmm12
18000434e:     	ucomisd	%xmm5, %xmm12
180004353:     	jb	0x180004376 <PyInit_rcaotr_61fae00d4878711302f71448+0x2a06>
180004355:     	movb	$0x1, (%rbx)
180004358:     	movq	0x310(%rsp), %rax
180004360:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180004368:     	xorpd	%xmm11, %xmm11
18000436d:     	cmpb	$0x0, (%rbx)
180004370:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004376:     	sqrtsd	%xmm11, %xmm11
18000437b:     	ucomisd	%xmm9, %xmm11
180004380:     	jne	0x1800043a6 <PyInit_rcaotr_61fae00d4878711302f71448+0x2a36>
180004382:     	jp	0x1800043a6 <PyInit_rcaotr_61fae00d4878711302f71448+0x2a36>
180004384:     	movb	$0x1, (%rbx)
180004387:     	movq	0x310(%rsp), %rax
18000438f:     	movq	$0x3d0902, 0x18(%rax)   # imm = 0x3D0902
180004397:     	movzbl	(%rbx), %eax
18000439a:     	movq	$-0x1, %rdx
1800043a1:     	jmp	0x180004429 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ab9>
1800043a6:     	movq	0x310(%rsp), %rax
1800043ae:     	movq	(%rax), %r14
1800043b1:     	leaq	0x6(%r14), %rax
1800043b5:     	cmpq	%r15, %rax
1800043b8:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
1800043be:     	movsd	(%r8,%rdx,8), %xmm13
1800043c4:     	movsd	0x10(%r8,%rdx,8), %xmm14
1800043cb:     	movsd	0x20(%r8,%rdx,8), %xmm15
1800043d2:     	movq	0x310(%rsp), %rdx
1800043da:     	movq	%rax, (%rdx)
1800043dd:     	cmpb	$0x0, (%rbx)
1800043e0:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800043e6:     	movsd	0x4ff9(%rip), %xmm12    # 0x1800093e8
1800043ef:     	divsd	%xmm11, %xmm12
1800043f4:     	mulsd	%xmm12, %xmm13
1800043f9:     	mulsd	%xmm12, %xmm14
1800043fe:     	mulsd	%xmm15, %xmm12
180004403:     	movsd	%xmm13, (%r8,%r14,8)
180004409:     	movsd	%xmm14, 0x10(%r8,%r14,8)
180004410:     	movsd	%xmm12, 0x20(%r8,%r14,8)
180004417:     	movzbl	(%rbx), %eax
18000441a:     	movl	%eax, %edx
18000441c:     	negb	%dl
18000441e:     	movl	$0x0, %edx
180004423:     	sbbq	%rdx, %rdx
180004426:     	orq	%r14, %rdx
180004429:     	testb	%al, %al
18000442b:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004431:     	movq	%rdx, 0x8(%r9,%rdi,8)
180004436:     	cmpb	$0x0, (%rbx)
180004439:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000443f:     	movq	%r11, %r14
180004442:     	sarq	$0x3f, %r14
180004446:     	andq	%r15, %r14
180004449:     	leaq	(%r9,%r11,8), %rax
18000444d:     	movq	(%rax,%r14,8), %r14
180004451:     	testq	%r14, %r14
180004454:     	je	0x18000453f <PyInit_rcaotr_61fae00d4878711302f71448+0x2bcf>
18000445a:     	cmpq	$0x1, %r14
18000445e:     	jne	0x180004987 <PyInit_rcaotr_61fae00d4878711302f71448+0x3017>
180004464:     	movq	0x20(%rax), %r11
180004468:     	movsd	(%r8,%rdx,8), %xmm11
18000446e:     	mulsd	(%r8,%r11,8), %xmm11
180004474:     	movapd	%xmm11, %xmm10
180004479:     	andpd	%xmm4, %xmm10
18000447e:     	ucomisd	%xmm5, %xmm10
180004483:     	movq	0x310(%rsp), %rax
18000448b:     	jae	0x180004602 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c92>
180004491:     	movsd	0x10(%r8,%rdx,8), %xmm12
180004498:     	mulsd	0x10(%r8,%r11,8), %xmm12
18000449f:     	movapd	%xmm12, %xmm10
1800044a4:     	andpd	%xmm4, %xmm10
1800044a9:     	ucomisd	%xmm5, %xmm10
1800044ae:     	jae	0x180004602 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c92>
1800044b4:     	addsd	%xmm12, %xmm11
1800044b9:     	movapd	%xmm11, %xmm10
1800044be:     	andpd	%xmm4, %xmm10
1800044c3:     	ucomisd	%xmm5, %xmm10
1800044c8:     	jae	0x180004602 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c92>
1800044ce:     	movsd	0x20(%r8,%rdx,8), %xmm12
1800044d5:     	mulsd	0x20(%r8,%r11,8), %xmm12
1800044dc:     	movapd	%xmm12, %xmm10
1800044e1:     	andpd	%xmm4, %xmm10
1800044e6:     	ucomisd	%xmm5, %xmm10
1800044eb:     	jae	0x180004602 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c92>
1800044f1:     	addsd	%xmm12, %xmm11
1800044f6:     	movapd	%xmm11, %xmm10
1800044fb:     	andpd	%xmm4, %xmm10
180004500:     	ucomisd	%xmm5, %xmm10
180004505:     	jae	0x180004602 <PyInit_rcaotr_61fae00d4878711302f71448+0x2c92>
18000450b:     	xorpd	%xmm13, %xmm13
180004510:     	ucomisd	%xmm13, %xmm11
180004515:     	jne	0x18000451d <PyInit_rcaotr_61fae00d4878711302f71448+0x2bad>
180004517:     	jnp	0x180004886 <PyInit_rcaotr_61fae00d4878711302f71448+0x2f16>
18000451d:     	movsd	0x4eea(%rip), %xmm13    # 0x180009410
180004526:     	divsd	%xmm11, %xmm13
18000452b:     	movb	$0x1, %dl
18000452d:     	incq	0x78(%rsp)
180004532:     	testb	%dl, %dl
180004534:     	jne	0x180004872 <PyInit_rcaotr_61fae00d4878711302f71448+0x2f02>
18000453a:     	jmp	0x18000415a <PyInit_rcaotr_61fae00d4878711302f71448+0x27ea>
18000453f:     	movq	0x8(%rax), %r14
180004543:     	movq	(%r9,%rdi,8), %rdx
180004547:     	movsd	(%r8,%r14,8), %xmm11
18000454d:     	subsd	(%r8,%rdx,8), %xmm11
180004553:     	movapd	%xmm11, %xmm10
180004558:     	andpd	%xmm4, %xmm10
18000455d:     	ucomisd	%xmm5, %xmm10
180004562:     	jae	0x18000462f <PyInit_rcaotr_61fae00d4878711302f71448+0x2cbf>
180004568:     	movsd	0x10(%r8,%r14,8), %xmm13
18000456f:     	subsd	0x10(%r8,%rdx,8), %xmm13
180004576:     	movapd	%xmm13, %xmm12
18000457b:     	andpd	%xmm4, %xmm12
180004580:     	ucomisd	%xmm5, %xmm12
180004585:     	jae	0x18000462f <PyInit_rcaotr_61fae00d4878711302f71448+0x2cbf>
18000458b:     	movsd	0x20(%r8,%r14,8), %xmm14
180004592:     	subsd	0x20(%r8,%rdx,8), %xmm14
180004599:     	movapd	%xmm14, %xmm12
18000459e:     	andpd	%xmm4, %xmm12
1800045a3:     	ucomisd	%xmm5, %xmm12
1800045a8:     	jae	0x18000462f <PyInit_rcaotr_61fae00d4878711302f71448+0x2cbf>
1800045ae:     	movq	0x310(%rsp), %rax
1800045b6:     	movq	(%rax), %r14
1800045b9:     	leaq	0x6(%r14), %rax
1800045bd:     	cmpq	%r15, %rax
1800045c0:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
1800045c6:     	movq	0x310(%rsp), %rdx
1800045ce:     	movq	%rax, (%rdx)
1800045d1:     	cmpb	$0x0, (%rbx)
1800045d4:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800045da:     	movsd	%xmm11, (%r8,%r14,8)
1800045e0:     	movsd	%xmm13, 0x10(%r8,%r14,8)
1800045e7:     	movsd	%xmm14, 0x20(%r8,%r14,8)
1800045ee:     	movzbl	(%rbx), %eax
1800045f1:     	movl	%eax, %edx
1800045f3:     	negb	%dl
1800045f5:     	movl	$0x0, %edx
1800045fa:     	sbbq	%rdx, %rdx
1800045fd:     	orq	%r14, %rdx
180004600:     	jmp	0x18000464c <PyInit_rcaotr_61fae00d4878711302f71448+0x2cdc>
180004602:     	movb	$0x1, (%rbx)
180004605:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
18000460d:     	cmpb	$0x0, (%rbx)
180004610:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004616:     	xorpd	%xmm13, %xmm13
18000461b:     	xorl	%edx, %edx
18000461d:     	incq	0x78(%rsp)
180004622:     	testb	%dl, %dl
180004624:     	jne	0x180004872 <PyInit_rcaotr_61fae00d4878711302f71448+0x2f02>
18000462a:     	jmp	0x18000415a <PyInit_rcaotr_61fae00d4878711302f71448+0x27ea>
18000462f:     	movb	$0x1, (%rbx)
180004632:     	movq	0x310(%rsp), %rax
18000463a:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
180004642:     	movzbl	(%rbx), %eax
180004645:     	movq	$-0x1, %rdx
18000464c:     	xorpd	%xmm13, %xmm13
180004651:     	testb	%al, %al
180004653:     	je	0x180004665 <PyInit_rcaotr_61fae00d4878711302f71448+0x2cf5>
180004655:     	xorl	%edx, %edx
180004657:     	cmpb	$0x0, (%rbx)
18000465a:     	je	0x180004865 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ef5>
180004660:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004665:     	movq	0x8(%r9,%rdi,8), %rdi
18000466a:     	movsd	(%r8,%rdx,8), %xmm14
180004670:     	mulsd	(%r8,%rdi,8), %xmm14
180004676:     	movapd	%xmm14, %xmm11
18000467b:     	andpd	%xmm4, %xmm11
180004680:     	ucomisd	%xmm5, %xmm11
180004685:     	jae	0x1800046f1 <PyInit_rcaotr_61fae00d4878711302f71448+0x2d81>
180004687:     	movsd	0x10(%r8,%rdx,8), %xmm11
18000468e:     	mulsd	0x10(%r8,%rdi,8), %xmm11
180004695:     	movapd	%xmm11, %xmm12
18000469a:     	andpd	%xmm4, %xmm12
18000469f:     	ucomisd	%xmm5, %xmm12
1800046a4:     	jae	0x1800046f1 <PyInit_rcaotr_61fae00d4878711302f71448+0x2d81>
1800046a6:     	addsd	%xmm11, %xmm14
1800046ab:     	movapd	%xmm14, %xmm11
1800046b0:     	andpd	%xmm4, %xmm11
1800046b5:     	ucomisd	%xmm5, %xmm11
1800046ba:     	jae	0x1800046f1 <PyInit_rcaotr_61fae00d4878711302f71448+0x2d81>
1800046bc:     	movsd	0x20(%r8,%rdx,8), %xmm11
1800046c3:     	mulsd	0x20(%r8,%rdi,8), %xmm11
1800046ca:     	movapd	%xmm11, %xmm12
1800046cf:     	andpd	%xmm4, %xmm12
1800046d4:     	ucomisd	%xmm5, %xmm12
1800046d9:     	jae	0x1800046f1 <PyInit_rcaotr_61fae00d4878711302f71448+0x2d81>
1800046db:     	addsd	%xmm11, %xmm14
1800046e0:     	movapd	%xmm14, %xmm11
1800046e5:     	andpd	%xmm4, %xmm11
1800046ea:     	ucomisd	%xmm5, %xmm11
1800046ef:     	jb	0x180004712 <PyInit_rcaotr_61fae00d4878711302f71448+0x2da2>
1800046f1:     	movb	$0x1, (%rbx)
1800046f4:     	movq	0x310(%rsp), %rax
1800046fc:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180004704:     	xorpd	%xmm14, %xmm14
180004709:     	cmpb	$0x0, (%rbx)
18000470c:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004712:     	movsd	0x10(%r8,%r11,8), %xmm15
180004719:     	mulsd	%xmm15, %xmm15
18000471e:     	movapd	%xmm15, %xmm11
180004723:     	andpd	%xmm4, %xmm11
180004728:     	ucomisd	%xmm5, %xmm11
18000472d:     	jae	0x180004847 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ed7>
180004733:     	movsd	(%r8,%rdx,8), %xmm11
180004739:     	mulsd	%xmm11, %xmm11
18000473e:     	movapd	%xmm11, %xmm10
180004743:     	andpd	%xmm4, %xmm10
180004748:     	ucomisd	%xmm5, %xmm10
18000474d:     	jae	0x1800047b5 <PyInit_rcaotr_61fae00d4878711302f71448+0x2e45>
18000474f:     	movsd	0x10(%r8,%rdx,8), %xmm10
180004756:     	mulsd	%xmm10, %xmm10
18000475b:     	movapd	%xmm10, %xmm12
180004760:     	andpd	%xmm4, %xmm12
180004765:     	ucomisd	%xmm5, %xmm12
18000476a:     	jae	0x1800047b5 <PyInit_rcaotr_61fae00d4878711302f71448+0x2e45>
18000476c:     	addsd	%xmm10, %xmm11
180004771:     	movapd	%xmm11, %xmm10
180004776:     	andpd	%xmm4, %xmm10
18000477b:     	ucomisd	%xmm5, %xmm10
180004780:     	jae	0x1800047b5 <PyInit_rcaotr_61fae00d4878711302f71448+0x2e45>
180004782:     	movsd	0x20(%r8,%rdx,8), %xmm12
180004789:     	mulsd	%xmm12, %xmm12
18000478e:     	movapd	%xmm12, %xmm10
180004793:     	andpd	%xmm4, %xmm10
180004798:     	ucomisd	%xmm5, %xmm10
18000479d:     	jae	0x1800047b5 <PyInit_rcaotr_61fae00d4878711302f71448+0x2e45>
18000479f:     	addsd	%xmm12, %xmm11
1800047a4:     	movapd	%xmm11, %xmm10
1800047a9:     	andpd	%xmm4, %xmm10
1800047ae:     	ucomisd	%xmm5, %xmm10
1800047b3:     	jb	0x1800047d6 <PyInit_rcaotr_61fae00d4878711302f71448+0x2e66>
1800047b5:     	movb	$0x1, (%rbx)
1800047b8:     	movq	0x310(%rsp), %rax
1800047c0:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
1800047c8:     	xorpd	%xmm11, %xmm11
1800047cd:     	cmpb	$0x0, (%rbx)
1800047d0:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800047d6:     	movapd	%xmm14, %xmm12
1800047db:     	mulsd	%xmm14, %xmm12
1800047e0:     	movapd	%xmm12, %xmm10
1800047e5:     	andpd	%xmm4, %xmm10
1800047ea:     	ucomisd	%xmm5, %xmm10
1800047ef:     	jae	0x180004847 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ed7>
1800047f1:     	subsd	%xmm12, %xmm11
1800047f6:     	movapd	%xmm11, %xmm10
1800047fb:     	andpd	%xmm4, %xmm10
180004800:     	ucomisd	%xmm5, %xmm10
180004805:     	jae	0x180004847 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ed7>
180004807:     	subsd	%xmm11, %xmm15
18000480c:     	movapd	%xmm15, %xmm10
180004811:     	andpd	%xmm4, %xmm10
180004816:     	ucomisd	%xmm5, %xmm10
18000481b:     	jae	0x180004847 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ed7>
18000481d:     	ucomisd	%xmm15, %xmm13
180004822:     	ja	0x180004655 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ce5>
180004828:     	xorps	%xmm10, %xmm10
18000482c:     	sqrtsd	%xmm15, %xmm10
180004831:     	subsd	%xmm10, %xmm14
180004836:     	movb	$0x1, %dl
180004838:     	movapd	%xmm14, %xmm13
18000483d:     	cmpb	$0x0, (%rbx)
180004840:     	je	0x180004865 <PyInit_rcaotr_61fae00d4878711302f71448+0x2ef5>
180004842:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004847:     	movb	$0x1, (%rbx)
18000484a:     	movq	0x310(%rsp), %rax
180004852:     	movq	$0xe4e1c4, 0x18(%rax)   # imm = 0xE4E1C4
18000485a:     	xorl	%edx, %edx
18000485c:     	cmpb	$0x0, (%rbx)
18000485f:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004865:     	incq	0x78(%rsp)
18000486a:     	testb	%dl, %dl
18000486c:     	je	0x18000415a <PyInit_rcaotr_61fae00d4878711302f71448+0x27ea>
180004872:     	ucomisd	0x4b9d(%rip), %xmm13    # 0x180009418
18000487b:     	jbe	0x18000415a <PyInit_rcaotr_61fae00d4878711302f71448+0x27ea>
180004881:     	jmp	0x180004d32 <PyInit_rcaotr_61fae00d4878711302f71448+0x33c2>
180004886:     	xorl	%edx, %edx
180004888:     	incq	0x78(%rsp)
18000488d:     	testb	%dl, %dl
18000488f:     	jne	0x180004872 <PyInit_rcaotr_61fae00d4878711302f71448+0x2f02>
180004891:     	jmp	0x18000415a <PyInit_rcaotr_61fae00d4878711302f71448+0x27ea>
180004896:     	cmpb	$0x0, (%rbx)
180004899:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000489f:     	movq	0xa0(%rsp), %rax
1800048a7:     	movq	0x90(%rsp), %rdx
1800048af:     	movq	(%rdx,%rax), %rdi
1800048b3:     	movq	0xc8(%rsp), %rax
1800048bb:     	cmpq	0x8(%rdx,%rax,8), %rdi
1800048c0:     	jne	0x180004ce2 <PyInit_rcaotr_61fae00d4878711302f71448+0x3372>
1800048c6:     	leaq	(%rdi,%rdi), %rdx
1800048ca:     	movq	%rdi, 0xe8(%rsp)
1800048d2:     	testq	%rdi, %rdi
1800048d5:     	movl	$0x4, %eax
1800048da:     	cmoveq	%rax, %rdx
1800048de:     	movq	0x310(%rsp), %rax
1800048e6:     	movq	(%rax), %r11
1800048e9:     	movq	%rdx, 0x1f8(%rsp)
1800048f1:     	movq	%r11, 0x78(%rsp)
1800048f6:     	leaq	(%r11,%rdx), %rax
1800048fa:     	cmpq	%r15, %rax
1800048fd:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180004903:     	movq	0x310(%rsp), %rdx
18000490b:     	movq	%rax, (%rdx)
18000490e:     	cmpb	$0x0, (%rbx)
180004911:     	movq	0xe8(%rsp), %rax
180004919:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000491f:     	movq	%r8, 0x88(%rsp)
180004927:     	movq	%rcx, 0x98(%rsp)
18000492f:     	testq	%rax, %rax
180004932:     	jle	0x180004c8b <PyInit_rcaotr_61fae00d4878711302f71448+0x331b>
180004938:     	movq	%r9, 0xb0(%rsp)
180004940:     	movq	0x90(%rsp), %rax
180004948:     	movq	0xd8(%rsp), %rcx
180004950:     	movq	0x10(%rax,%rcx,8), %r11
180004955:     	movq	0xe8(%rsp), %rax
18000495d:     	movl	%eax, %edx
18000495f:     	andl	$0x7, %edx
180004962:     	cmpq	$0x8, %rax
180004966:     	jae	0x1800049a8 <PyInit_rcaotr_61fae00d4878711302f71448+0x3038>
180004968:     	xorl	%ebx, %ebx
18000496a:     	movq	0xb0(%rsp), %r9
180004972:     	movq	0x320(%rsp), %rax
18000497a:     	leaq	(,%rax,8), %rdi
180004982:     	jmp	0x180004c52 <PyInit_rcaotr_61fae00d4878711302f71448+0x32e2>
180004987:     	movb	$0x1, (%rbx)
18000498a:     	movq	0x310(%rsp), %rax
180004992:     	movq	$0x206cc83, 0x18(%rax)  # imm = 0x206CC83
18000499a:     	cmpb	$0x0, (%rbx)
18000499d:     	je	0x180004d32 <PyInit_rcaotr_61fae00d4878711302f71448+0x33c2>
1800049a3:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800049a8:     	movq	0xe8(%rsp), %rcx
1800049b0:     	movabsq	$0x7ffffffffffffff8, %rax # imm = 0x7FFFFFFFFFFFFFF8
1800049ba:     	andq	%rax, %rcx
1800049bd:     	movq	%rcx, 0xd0(%rsp)
1800049c5:     	movq	0xb0(%rsp), %rax
1800049cd:     	leaq	(%rax,%r11,8), %rcx
1800049d1:     	movq	%rcx, 0xe0(%rsp)
1800049d9:     	movq	0x78(%rsp), %rcx
1800049de:     	leaq	(%rax,%rcx,8), %rbx
1800049e2:     	xorl	%edi, %edi
1800049e4:     	movq	0x320(%rsp), %r8
1800049ec:     	leaq	(,%r8,8), %rax
1800049f4:     	movq	%rax, 0xa8(%rsp)
1800049fc:     	leaq	0x8(,%r8,8), %rax
180004a04:     	movq	%rax, 0x80(%rsp)
180004a0c:     	leaq	0x10(,%r8,8), %rax
180004a14:     	movq	%rax, 0xf0(%rsp)
180004a1c:     	leaq	0x18(,%r8,8), %rax
180004a24:     	movq	%rax, 0x120(%rsp)
180004a2c:     	leaq	0x20(,%r8,8), %rax
180004a34:     	movq	%rax, 0x118(%rsp)
180004a3c:     	leaq	0x28(,%r8,8), %rax
180004a44:     	movq	%rax, 0x110(%rsp)
180004a4c:     	leaq	0x30(,%r8,8), %rax
180004a54:     	movq	%rax, 0x108(%rsp)
180004a5c:     	leaq	0x38(,%r8,8), %rax
180004a64:     	movq	%rax, 0x100(%rsp)
180004a6c:     	leaq	(%r11,%rdi), %r8
180004a70:     	movq	%r8, %rax
180004a73:     	sarq	$0x3f, %rax
180004a77:     	movq	0xa8(%rsp), %rcx
180004a7f:     	andq	%rcx, %rax
180004a82:     	movq	0xe0(%rsp), %r15
180004a8a:     	addq	%r15, %rax
180004a8d:     	movq	(%rax,%rdi,8), %rax
180004a91:     	movq	0x78(%rsp), %r9
180004a96:     	addq	%rdi, %r9
180004a99:     	movq	%r9, %r14
180004a9c:     	sarq	$0x3f, %r14
180004aa0:     	andq	%rcx, %r14
180004aa3:     	addq	%rbx, %r14
180004aa6:     	movq	%rax, (%r14,%rdi,8)
180004aaa:     	movq	%r8, %rax
180004aad:     	incq	%rax
180004ab0:     	movl	$0x8, %eax
180004ab5:     	movq	0x80(%rsp), %rcx
180004abd:     	cmovsq	%rcx, %rax
180004ac1:     	addq	%r15, %rax
180004ac4:     	movq	(%rax,%rdi,8), %rax
180004ac8:     	movq	%r9, %r14
180004acb:     	incq	%r14
180004ace:     	movl	$0x8, %r14d
180004ad4:     	cmovsq	%rcx, %r14
180004ad8:     	addq	%rbx, %r14
180004adb:     	movq	%rax, (%r14,%rdi,8)
180004adf:     	movq	%r8, %rax
180004ae2:     	addq	$0x2, %rax
180004ae6:     	movl	$0x10, %eax
180004aeb:     	movq	0xf0(%rsp), %rcx
180004af3:     	cmovsq	%rcx, %rax
180004af7:     	addq	%r15, %rax
180004afa:     	movq	(%rax,%rdi,8), %rax
180004afe:     	movq	%r9, %r14
180004b01:     	addq	$0x2, %r14
180004b05:     	movl	$0x10, %r14d
180004b0b:     	cmovsq	%rcx, %r14
180004b0f:     	addq	%rbx, %r14
180004b12:     	movq	%rax, (%r14,%rdi,8)
180004b16:     	movq	%r8, %rax
180004b19:     	addq	$0x3, %rax
180004b1d:     	movl	$0x18, %eax
180004b22:     	movq	0x120(%rsp), %rcx
180004b2a:     	cmovsq	%rcx, %rax
180004b2e:     	addq	%r15, %rax
180004b31:     	movq	(%rax,%rdi,8), %rax
180004b35:     	movq	%r9, %r14
180004b38:     	addq	$0x3, %r14
180004b3c:     	movl	$0x18, %r14d
180004b42:     	cmovsq	%rcx, %r14
180004b46:     	addq	%rbx, %r14
180004b49:     	movq	%rax, (%r14,%rdi,8)
180004b4d:     	movq	%r8, %rax
180004b50:     	addq	$0x4, %rax
180004b54:     	movl	$0x20, %eax
180004b59:     	movq	0x118(%rsp), %rcx
180004b61:     	cmovsq	%rcx, %rax
180004b65:     	addq	%r15, %rax
180004b68:     	movq	(%rax,%rdi,8), %rax
180004b6c:     	movq	%r9, %r14
180004b6f:     	addq	$0x4, %r14
180004b73:     	movl	$0x20, %r14d
180004b79:     	cmovsq	%rcx, %r14
180004b7d:     	addq	%rbx, %r14
180004b80:     	movq	%rax, (%r14,%rdi,8)
180004b84:     	movq	%r8, %rax
180004b87:     	addq	$0x5, %rax
180004b8b:     	movl	$0x28, %eax
180004b90:     	movq	0x110(%rsp), %rcx
180004b98:     	cmovsq	%rcx, %rax
180004b9c:     	addq	%r15, %rax
180004b9f:     	movq	(%rax,%rdi,8), %rax
180004ba3:     	movq	%r9, %r14
180004ba6:     	addq	$0x5, %r14
180004baa:     	movl	$0x28, %r14d
180004bb0:     	cmovsq	%rcx, %r14
180004bb4:     	addq	%rbx, %r14
180004bb7:     	movq	%rax, (%r14,%rdi,8)
180004bbb:     	movq	%r8, %rax
180004bbe:     	addq	$0x6, %rax
180004bc2:     	movl	$0x30, %eax
180004bc7:     	movq	0x108(%rsp), %rcx
180004bcf:     	cmovsq	%rcx, %rax
180004bd3:     	addq	%r15, %rax
180004bd6:     	movq	(%rax,%rdi,8), %rax
180004bda:     	movq	%r9, %r14
180004bdd:     	addq	$0x6, %r14
180004be1:     	movl	$0x30, %r14d
180004be7:     	cmovsq	%rcx, %r14
180004beb:     	addq	%rbx, %r14
180004bee:     	movq	%rax, (%r14,%rdi,8)
180004bf2:     	addq	$0x7, %r8
180004bf6:     	movl	$0x38, %eax
180004bfb:     	movq	0x100(%rsp), %rcx
180004c03:     	cmovsq	%rcx, %rax
180004c07:     	addq	%r15, %rax
180004c0a:     	movq	(%rax,%rdi,8), %rax
180004c0e:     	addq	$0x7, %r9
180004c12:     	movl	$0x38, %r8d
180004c18:     	cmovsq	%rcx, %r8
180004c1c:     	addq	%rbx, %r8
180004c1f:     	movq	%rax, (%r8,%rdi,8)
180004c23:     	addq	$0x8, %rdi
180004c27:     	cmpq	%rdi, 0xd0(%rsp)
180004c2f:     	jne	0x180004a6c <PyInit_rcaotr_61fae00d4878711302f71448+0x30fc>
180004c35:     	movq	0xd0(%rsp), %rbx
180004c3d:     	testq	%rdx, %rdx
180004c40:     	movq	0xb0(%rsp), %r9
180004c48:     	movq	0xa8(%rsp), %rdi
180004c50:     	je	0x180004c8b <PyInit_rcaotr_61fae00d4878711302f71448+0x331b>
180004c52:     	movq	0x78(%rsp), %rax
180004c57:     	leaq	(%rbx,%rax), %rcx
180004c5b:     	addq	%rbx, %r11
180004c5e:     	movq	%r11, %rax
180004c61:     	sarq	$0x3f, %rax
180004c65:     	andq	%rdi, %rax
180004c68:     	addq	%r9, %rax
180004c6b:     	movq	(%rax,%r11,8), %rax
180004c6f:     	movq	%rcx, %r8
180004c72:     	sarq	$0x3f, %r8
180004c76:     	andq	%rdi, %r8
180004c79:     	addq	%r9, %r8
180004c7c:     	movq	%rax, (%r8,%rcx,8)
180004c80:     	incq	%rcx
180004c83:     	incq	%r11
180004c86:     	decq	%rdx
180004c89:     	jne	0x180004c5e <PyInit_rcaotr_61fae00d4878711302f71448+0x32ee>
180004c8b:     	movq	0x90(%rsp), %rax
180004c93:     	movq	0xc8(%rsp), %rcx
180004c9b:     	movq	0x1f8(%rsp), %rdx
180004ca3:     	movq	%rdx, 0x8(%rax,%rcx,8)
180004ca8:     	movq	0xd8(%rsp), %rcx
180004cb0:     	movq	0x78(%rsp), %rdx
180004cb5:     	movq	%rdx, 0x10(%rax,%rcx,8)
180004cba:     	movq	0x98(%rsp), %rcx
180004cc2:     	movq	0x88(%rsp), %r8
180004cca:     	movq	0x318(%rsp), %rbx
180004cd2:     	movq	0x320(%rsp), %r15
180004cda:     	movq	0xe8(%rsp), %rdi
180004ce2:     	leaq	0x1(%rdi), %rax
180004ce6:     	movq	0xa0(%rsp), %rdx
180004cee:     	movq	0x90(%rsp), %r11
180004cf6:     	movq	%rax, (%r11,%rdx)
180004cfa:     	cmpb	$0x0, (%rbx)
180004cfd:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004d03:     	movq	0x90(%rsp), %rax
180004d0b:     	movq	0xd8(%rsp), %rdx
180004d13:     	addq	0x10(%rax,%rdx,8), %rdi
180004d18:     	movq	%rdi, %rax
180004d1b:     	sarq	$0x3f, %rax
180004d1f:     	andq	%r15, %rax
180004d22:     	leaq	(%r9,%rdi,8), %rdx
180004d26:     	movq	0xf8(%rsp), %r11
180004d2e:     	movq	%r11, (%rdx,%rax,8)
180004d32:     	movq	0xb8(%rsp), %rax
180004d3a:     	movq	0x130(%rsp), %r11
180004d42:     	movq	0xc0(%rsp), %r14
180004d4a:     	cmpq	(%r11,%rax,8), %r14
180004d4e:     	leaq	(,%r15,8), %rdi
180004d56:     	movq	0x128(%rsp), %rax
180004d5e:     	jl	0x1800040ef <PyInit_rcaotr_61fae00d4878711302f71448+0x277f>
180004d64:     	cmpb	$0x0, (%rbx)
180004d67:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004d6d:     	jmp	0x180005441 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ad1>
180004d72:     	movb	$0x1, (%rbx)
180004d75:     	movq	$0x18cba83, 0x18(%r14)  # imm = 0x18CBA83
180004d7d:     	jmp	0x180003d12 <PyInit_rcaotr_61fae00d4878711302f71448+0x23a2>
180004d82:     	movsd	(%r8,%rdx,8), %xmm0
180004d88:     	movsd	0x10(%r8,%rdx,8), %xmm1
180004d8f:     	movsd	0x20(%r8,%rdx,8), %xmm2
180004d96:     	movq	%rdi, (%r14)
180004d99:     	cmpb	$0x0, (%rbx)
180004d9c:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004da2:     	xorps	%xmm3, %xmm3
180004da5:     	cvtsi2sd	%rsi, %xmm3
180004daa:     	movsd	0x4636(%rip), %xmm4     # 0x1800093e8
180004db2:     	divsd	%xmm3, %xmm4
180004db6:     	mulsd	%xmm4, %xmm0
180004dba:     	mulsd	%xmm4, %xmm1
180004dbe:     	mulsd	%xmm2, %xmm4
180004dc2:     	movsd	%xmm0, (%r8,%r11,8)
180004dc8:     	movsd	%xmm1, 0x10(%r8,%r11,8)
180004dcf:     	movsd	%xmm4, 0x20(%r8,%r11,8)
180004dd6:     	cmpb	$0x0, (%rbx)
180004dd9:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004ddf:     	movsd	(%r8,%rdx,8), %xmm2
180004de5:     	movapd	0x45e3(%rip), %xmm0     # 0x1800093d0
180004ded:     	andpd	%xmm0, %xmm2
180004df1:     	addsd	0x45b7(%rip), %xmm2     # 0x1800093b0
180004df9:     	movapd	%xmm2, %xmm3
180004dfd:     	andpd	%xmm0, %xmm3
180004e01:     	movsd	0x45ff(%rip), %xmm1     # 0x180009408
180004e09:     	ucomisd	%xmm3, %xmm1
180004e0d:     	jbe	0x180005428 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ab8>
180004e13:     	movsd	0x10(%r8,%rdx,8), %xmm3
180004e1a:     	andpd	%xmm0, %xmm3
180004e1e:     	addsd	0x458a(%rip), %xmm3     # 0x1800093b0
180004e26:     	movapd	%xmm3, %xmm4
180004e2a:     	andpd	%xmm0, %xmm4
180004e2e:     	ucomisd	%xmm4, %xmm1
180004e32:     	jbe	0x180005428 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ab8>
180004e38:     	cvttsd2si	%xmm2, %rsi
180004e3d:     	cvttsd2si	%xmm3, %rdi
180004e42:     	leaq	(%rdi,%rsi), %r11
180004e46:     	xorq	%r11, %rsi
180004e49:     	xorq	%r11, %rdi
180004e4c:     	movb	$0x1, %r10b
180004e4f:     	testq	%rdi, %rsi
180004e52:     	js	0x180003f27 <PyInit_rcaotr_61fae00d4878711302f71448+0x25b7>
180004e58:     	movsd	0x20(%r8,%rdx,8), %xmm2
180004e5f:     	andpd	%xmm0, %xmm2
180004e63:     	addsd	0x4545(%rip), %xmm2     # 0x1800093b0
180004e6b:     	andpd	%xmm2, %xmm0
180004e6f:     	ucomisd	%xmm0, %xmm1
180004e73:     	jbe	0x180005428 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ab8>
180004e79:     	cvttsd2si	%xmm2, %rsi
180004e7e:     	leaq	(%r11,%rsi), %rdx
180004e82:     	xorq	%rdx, %r11
180004e85:     	xorq	%rdx, %rsi
180004e88:     	testq	%rsi, %r11
180004e8b:     	js	0x180003f27 <PyInit_rcaotr_61fae00d4878711302f71448+0x25b7>
180004e91:     	movq	%r15, %rbp
180004e94:     	testb	$0x1, %dl
180004e97:     	jne	0x180005c3b <PyInit_rcaotr_61fae00d4878711302f71448+0x42cb>
180004e9d:     	movq	0x10(%rax), %rax
180004ea1:     	movq	%rax, %rdx
180004ea4:     	sarq	$0x3f, %rdx
180004ea8:     	movq	%rbp, %r15
180004eab:     	andq	%rbp, %rdx
180004eae:     	leaq	(%r8,%rax,8), %r10
180004eb2:     	movsd	(%r10,%rdx,8), %xmm8
180004eb8:     	xorl	%edx, %edx
180004eba:     	cmpq	$-0x2, %rax
180004ebe:     	movl	$0x0, %r11d
180004ec4:     	cmovlq	%rbp, %r11
180004ec8:     	movsd	0x10(%r10,%r11,8), %xmm7
180004ecf:     	cmpq	$-0x4, %rax
180004ed3:     	cmovlq	%rbp, %rdx
180004ed7:     	movsd	0x20(%r10,%rdx,8), %xmm6
180004ede:     	jmp	0x180003d1b <PyInit_rcaotr_61fae00d4878711302f71448+0x23ab>
180004ee3:     	movb	$0x1, (%rbx)
180004ee6:     	movq	$0x1e84802, 0x18(%r14)  # imm = 0x1E84802
180004eee:     	movzbl	(%rbx), %r11d
180004ef2:     	movq	$-0x1, %rdx
180004ef9:     	testb	%r11b, %r11b
180004efc:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004f02:     	movsd	(%r8,%rax,8), %xmm0
180004f08:     	subsd	(%r8,%rdx,8), %xmm0
180004f0e:     	movapd	0x44ba(%rip), %xmm1     # 0x1800093d0
180004f16:     	andpd	%xmm0, %xmm1
180004f1a:     	ucomisd	0x44be(%rip), %xmm1     # 0x1800093e0
180004f22:     	jae	0x180004fb4 <PyInit_rcaotr_61fae00d4878711302f71448+0x3644>
180004f28:     	movsd	0x10(%r8,%rax,8), %xmm1
180004f2f:     	subsd	0x10(%r8,%rdx,8), %xmm1
180004f36:     	movapd	0x4492(%rip), %xmm2     # 0x1800093d0
180004f3e:     	andpd	%xmm1, %xmm2
180004f42:     	ucomisd	0x4496(%rip), %xmm2     # 0x1800093e0
180004f4a:     	jae	0x180004fb4 <PyInit_rcaotr_61fae00d4878711302f71448+0x3644>
180004f4c:     	movsd	0x20(%r8,%rax,8), %xmm2
180004f53:     	subsd	0x20(%r8,%rdx,8), %xmm2
180004f5a:     	movapd	0x446e(%rip), %xmm3     # 0x1800093d0
180004f62:     	andpd	%xmm2, %xmm3
180004f66:     	ucomisd	0x4472(%rip), %xmm3     # 0x1800093e0
180004f6e:     	jae	0x180004fb4 <PyInit_rcaotr_61fae00d4878711302f71448+0x3644>
180004f70:     	movq	(%r14), %rax
180004f73:     	leaq	0x6(%rax), %rdx
180004f77:     	cmpq	%r15, %rdx
180004f7a:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180004f80:     	movq	%rdx, (%r14)
180004f83:     	cmpb	$0x0, (%rbx)
180004f86:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004f8c:     	movsd	%xmm0, (%r8,%rax,8)
180004f92:     	movsd	%xmm1, 0x10(%r8,%rax,8)
180004f99:     	movsd	%xmm2, 0x20(%r8,%rax,8)
180004fa0:     	movzbl	(%rbx), %r10d
180004fa4:     	xorl	%edx, %edx
180004fa6:     	movl	%r10d, %r11d
180004fa9:     	negb	%r11b
180004fac:     	sbbq	%rdx, %rdx
180004faf:     	orq	%rax, %rdx
180004fb2:     	jmp	0x180004fca <PyInit_rcaotr_61fae00d4878711302f71448+0x365a>
180004fb4:     	movb	$0x1, (%rbx)
180004fb7:     	movq	$0x1f78a43, 0x18(%r14)  # imm = 0x1F78A43
180004fbf:     	movzbl	(%rbx), %r10d
180004fc3:     	movq	$-0x1, %rdx
180004fca:     	testb	%r10b, %r10b
180004fcd:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004fd3:     	movq	(%r14), %rax
180004fd6:     	leaq	0x2(%rax), %r10
180004fda:     	cmpq	%r15, %r10
180004fdd:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180004fe3:     	movq	%r10, (%r14)
180004fe6:     	cmpb	$0x0, (%rbx)
180004fe9:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180004fef:     	movq	%r8, 0x88(%rsp)
180004ff7:     	movq	%r9, 0xb0(%rsp)
180004fff:     	movq	%r13, (%r9,%rax,8)
180005003:     	cmpb	$0x0, (%rbx)
180005006:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000500c:     	movq	%rcx, 0x98(%rsp)
180005014:     	movq	0x88(%rsp), %rcx
18000501c:     	movsd	(%rcx,%rdx,8), %xmm0
180005021:     	mulsd	%xmm0, %xmm0
180005025:     	movapd	0x43a3(%rip), %xmm1     # 0x1800093d0
18000502d:     	andpd	%xmm0, %xmm1
180005031:     	ucomisd	0x43a7(%rip), %xmm1     # 0x1800093e0
180005039:     	jae	0x1800050c3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3753>
18000503f:     	movq	0x88(%rsp), %rcx
180005047:     	movsd	0x10(%rcx,%rdx,8), %xmm1
18000504d:     	mulsd	%xmm1, %xmm1
180005051:     	movapd	0x4377(%rip), %xmm2     # 0x1800093d0
180005059:     	andpd	%xmm1, %xmm2
18000505d:     	ucomisd	0x437b(%rip), %xmm2     # 0x1800093e0
180005065:     	jae	0x1800050c3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3753>
180005067:     	addsd	%xmm1, %xmm0
18000506b:     	movapd	0x435d(%rip), %xmm1     # 0x1800093d0
180005073:     	andpd	%xmm0, %xmm1
180005077:     	ucomisd	0x4361(%rip), %xmm1     # 0x1800093e0
18000507f:     	jae	0x1800050c3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3753>
180005081:     	movq	0x88(%rsp), %rcx
180005089:     	movsd	0x20(%rcx,%rdx,8), %xmm1
18000508f:     	mulsd	%xmm1, %xmm1
180005093:     	movapd	0x4335(%rip), %xmm2     # 0x1800093d0
18000509b:     	andpd	%xmm1, %xmm2
18000509f:     	ucomisd	0x4339(%rip), %xmm2     # 0x1800093e0
1800050a7:     	jae	0x1800050c3 <PyInit_rcaotr_61fae00d4878711302f71448+0x3753>
1800050a9:     	addsd	%xmm1, %xmm0
1800050ad:     	movapd	0x431b(%rip), %xmm1     # 0x1800093d0
1800050b5:     	andpd	%xmm0, %xmm1
1800050b9:     	ucomisd	0x431f(%rip), %xmm1     # 0x1800093e0
1800050c1:     	jb	0x1800050eb <PyInit_rcaotr_61fae00d4878711302f71448+0x377b>
1800050c3:     	movq	0x318(%rsp), %rcx
1800050cb:     	movb	$0x1, (%rcx)
1800050ce:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
1800050d6:     	cmpb	$0x0, (%rcx)
1800050d9:     	movq	0x98(%rsp), %rcx
1800050e1:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800050e7:     	xorpd	%xmm0, %xmm0
1800050eb:     	sqrtsd	%xmm0, %xmm0
1800050ef:     	xorpd	%xmm1, %xmm1
1800050f3:     	ucomisd	%xmm1, %xmm0
1800050f7:     	jne	0x180005cc8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4358>
1800050fd:     	jp	0x180005cc8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4358>
180005103:     	movq	0x318(%rsp), %rcx
18000510b:     	movb	$0x1, (%rcx)
18000510e:     	movq	$0x3d0902, 0x18(%r14)   # imm = 0x3D0902
180005116:     	movzbl	(%rcx), %ecx
180005119:     	movq	$-0x1, %rdx
180005120:     	testb	%cl, %cl
180005122:     	movq	0x98(%rsp), %rcx
18000512a:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005130:     	movq	0xb0(%rsp), %r8
180005138:     	movq	%rdx, 0x8(%r8,%rax,8)
18000513d:     	movq	0x318(%rsp), %rdx
180005145:     	cmpb	$0x0, (%rdx)
180005148:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000514e:     	movq	0x8(%r14), %rcx
180005152:     	leaq	0x1(%rcx), %rdx
180005156:     	movq	%rdx, 0x8(%r14)
18000515a:     	cmpq	0x10(%r14), %rcx
18000515e:     	jge	0x18000603e <PyInit_rcaotr_61fae00d4878711302f71448+0x46ce>
180005164:     	movq	$0x0, 0x138(%rsp)
180005170:     	movb	$0x0, 0x140(%rsp)
180005178:     	movq	$0x0, 0x148(%rsp)
180005184:     	movb	$0x0, 0x150(%rsp)
18000518c:     	movq	$0x0, 0x158(%rsp)
180005198:     	movb	$0x0, 0x160(%rsp)
1800051a0:     	movq	$0x0, 0x168(%rsp)
1800051ac:     	movb	$0x0, 0x170(%rsp)
1800051b4:     	movq	$0x0, 0x178(%rsp)
1800051c0:     	movb	$0x0, 0x180(%rsp)
1800051c8:     	movq	$0x0, 0x188(%rsp)
1800051d4:     	movb	$0x0, 0x190(%rsp)
1800051dc:     	movq	%rax, 0x48(%rsp)
1800051e1:     	movq	%rsi, 0x40(%rsp)
1800051e6:     	movq	%r15, 0x30(%rsp)
1800051eb:     	movq	%rbx, 0x28(%rsp)
1800051f0:     	movq	%r14, 0x20(%rsp)
1800051f5:     	movq	$-0x1, 0x70(%rsp)
1800051fe:     	movq	$-0x1, 0x68(%rsp)
180005207:     	movq	$-0x1, 0x60(%rsp)
180005210:     	movq	$-0x1, 0x58(%rsp)
180005219:     	movq	$-0x1, 0x50(%rsp)
180005222:     	movq	$0x0, 0x38(%rsp)
18000522b:     	leaq	0x138(%rsp), %rcx
180005233:     	movq	0x88(%rsp), %r8
18000523b:     	movq	0xb0(%rsp), %r9
180005243:     	callq	0x180002fc0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1650>
180005248:     	cmpb	$0x0, (%rbx)
18000524b:     	jne	0x180006051 <PyInit_rcaotr_61fae00d4878711302f71448+0x46e1>
180005251:     	movsd	0x158(%rsp), %xmm2
18000525a:     	movsd	0x138(%rsp), %xmm0
180005263:     	movsd	0x148(%rsp), %xmm1
18000526c:     	decq	0x8(%r14)
180005270:     	movq	0x318(%rsp), %rax
180005278:     	cmpb	$0x0, (%rax)
18000527b:     	jne	0x180006051 <PyInit_rcaotr_61fae00d4878711302f71448+0x46e1>
180005281:     	movq	0x88(%rsp), %r8
180005289:     	movsd	0x20(%r8,%r12,8), %xmm3
180005290:     	shlq	$0x3, %r12
180005294:     	mulsd	%xmm3, %xmm0
180005298:     	xorpd	%xmm4, %xmm4
18000529c:     	addsd	%xmm4, %xmm0
1800052a0:     	mulsd	%xmm3, %xmm1
1800052a4:     	addsd	%xmm4, %xmm1
1800052a8:     	mulsd	%xmm3, %xmm2
1800052ac:     	addsd	%xmm4, %xmm2
1800052b0:     	movq	0x98(%rsp), %rcx
1800052b8:     	movq	0xb0(%rsp), %r9
1800052c0:     	movq	0x318(%rsp), %rbx
1800052c8:     	movsd	0x18(%r8,%r12), %xmm4
1800052cf:     	xorpd	%xmm3, %xmm3
1800052d3:     	ucomisd	%xmm3, %xmm4
1800052d7:     	ja	0x180003d6a <PyInit_rcaotr_61fae00d4878711302f71448+0x23fa>
1800052dd:     	jmp	0x180005938 <PyInit_rcaotr_61fae00d4878711302f71448+0x3fc8>
1800052e2:     	shlq	$0x3, %r12
1800052e6:     	movq	0xc0(%rsp), %rax
1800052ee:     	movq	(%rax,%r12), %r10
1800052f2:     	testq	%r10, %r10
1800052f5:     	jle	0x1800057fc <PyInit_rcaotr_61fae00d4878711302f71448+0x3e8c>
1800052fb:     	movq	0x10(%rax,%r11,8), %r11
180005300:     	xorpd	%xmm0, %xmm0
180005304:     	movq	$-0x1, 0x78(%rsp)
18000530d:     	xorl	%r14d, %r14d
180005310:     	movsd	0x4108(%rip), %xmm1     # 0x180009420
180005318:     	xorl	%r13d, %r13d
18000531b:     	movq	$-0x1, %rdi
180005322:     	jmp	0x180005342 <PyInit_rcaotr_61fae00d4878711302f71448+0x39d2>
180005324:     	movq	%rdx, %rdi
180005327:     	movapd	%xmm2, %xmm0
18000532b:     	movb	$0x1, %r13b
18000532e:     	movq	%r12, 0x78(%rsp)
180005333:     	movb	$0x1, %r14b
180005336:     	incq	%r11
180005339:     	decq	%r10
18000533c:     	je	0x1800053d5 <PyInit_rcaotr_61fae00d4878711302f71448+0x3a65>
180005342:     	movq	%r11, %rax
180005345:     	sarq	$0x3f, %rax
180005349:     	leaq	(,%r15,8), %rdx
180005351:     	andq	%rdx, %rax
180005354:     	addq	%r9, %rax
180005357:     	movq	(%rax,%r11,8), %r12
18000535b:     	leaq	(%r9,%r12,8), %rbp
18000535f:     	cmpq	$-0x1, %r12
180005363:     	movl	$0x0, %edx
180005368:     	cmovlq	%r15, %rdx
18000536c:     	cmpq	$-0x2, %r12
180005370:     	movl	$0x0, %esi
180005375:     	cmovlq	%r15, %rsi
180005379:     	cmpq	$-0x3, %r12
18000537d:     	movl	$0x0, %eax
180005382:     	cmovlq	%r15, %rax
180005386:     	cmpq	$0x0, 0x10(%rbp,%rsi,8)
18000538c:     	je	0x180005336 <PyInit_rcaotr_61fae00d4878711302f71448+0x39c6>
18000538e:     	leaq	(%r8,%r12,8), %rsi
180005392:     	movsd	0x8(%rsi,%rdx,8), %xmm2
180005398:     	ucomisd	%xmm1, %xmm2
18000539c:     	jbe	0x180005336 <PyInit_rcaotr_61fae00d4878711302f71448+0x39c6>
18000539e:     	sarq	$0x3f, %r12
1800053a2:     	andq	%r15, %r12
1800053a5:     	movq	(%rbp,%r12,8), %rdx
1800053aa:     	movq	0x18(%rbp,%rax,8), %r12
1800053af:     	testb	$0x1, %r14b
1800053b3:     	je	0x180005324 <PyInit_rcaotr_61fae00d4878711302f71448+0x39b4>
1800053b9:     	testb	$0x1, %r13b
1800053bd:     	je	0x1800057e9 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e79>
1800053c3:     	ucomisd	%xmm2, %xmm0
1800053c7:     	ja	0x180005324 <PyInit_rcaotr_61fae00d4878711302f71448+0x39b4>
1800053cd:     	movb	$0x1, %r13b
1800053d0:     	jmp	0x180005333 <PyInit_rcaotr_61fae00d4878711302f71448+0x39c3>
1800053d5:     	cmpb	$0x0, (%rbx)
1800053d8:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800053de:     	testb	$0x1, %r14b
1800053e2:     	je	0x180005801 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e91>
1800053e8:     	movq	%rcx, %r12
1800053eb:     	movq	%r9, %rsi
1800053ee:     	movq	0x338(%rsp), %rax
1800053f6:     	movq	(%r9,%rax,8), %rcx
1800053fa:     	testb	$0x1, %r13b
1800053fe:     	je	0x1800059ad <PyInit_rcaotr_61fae00d4878711302f71448+0x403d>
180005404:     	movq	%rbx, %r14
180005407:     	movq	0x310(%rsp), %rax
18000540f:     	movq	(%rax), %r10
180005412:     	leaq	0x6(%r10), %rax
180005416:     	cmpq	%r15, %rax
180005419:     	jle	0x180005aa7 <PyInit_rcaotr_61fae00d4878711302f71448+0x4137>
18000541f:     	movb	$0x2, (%r14)
180005423:     	jmp	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005428:     	movb	$0x1, (%rbx)
18000542b:     	movq	$0x18cba84, 0x18(%r14)  # imm = 0x18CBA84
180005433:     	jmp	0x180003d12 <PyInit_rcaotr_61fae00d4878711302f71448+0x23a2>
180005438:     	shlq	$0x3, 0xa0(%rsp)
180005441:     	movq	0xa0(%rsp), %r14
180005449:     	movq	0x90(%rsp), %rax
180005451:     	cmpq	$0x0, (%rax,%r14)
180005456:     	jle	0x180005902 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f92>
18000545c:     	leaq	(,%r15,8), %rdx
180005464:     	xorl	%r11d, %r11d
180005467:     	cmpq	$-0x2, %r10
18000546b:     	cmovgeq	%r11, %rdx
18000546f:     	xorpd	%xmm5, %xmm5
180005473:     	movapd	0x3f54(%rip), %xmm9     # 0x1800093d0
18000547c:     	movsd	0x3f5b(%rip), %xmm10    # 0x1800093e0
180005485:     	xorpd	%xmm4, %xmm4
180005489:     	movq	0x310(%rsp), %rdi
180005491:     	movq	0x10(%rax,%rdx), %rax
180005496:     	addq	%r11, %rax
180005499:     	leaq	(%r9,%rax,8), %r10
18000549d:     	sarq	$0x3f, %rax
1800054a1:     	andq	%r15, %rax
1800054a4:     	movq	(%r10,%rax,8), %r10
1800054a8:     	movsd	(%r8,%r10,8), %xmm12
1800054ae:     	subsd	(%r8,%r13,8), %xmm12
1800054b4:     	movapd	%xmm12, %xmm13
1800054b9:     	andpd	%xmm9, %xmm13
1800054be:     	ucomisd	%xmm10, %xmm13
1800054c3:     	jae	0x18000554e <PyInit_rcaotr_61fae00d4878711302f71448+0x3bde>
1800054c9:     	movsd	0x10(%r8,%r10,8), %xmm13
1800054d0:     	subsd	0x10(%r8,%r13,8), %xmm13
1800054d7:     	movapd	%xmm13, %xmm14
1800054dc:     	andpd	%xmm9, %xmm14
1800054e1:     	ucomisd	%xmm10, %xmm14
1800054e6:     	jae	0x18000554e <PyInit_rcaotr_61fae00d4878711302f71448+0x3bde>
1800054e8:     	movsd	0x20(%r8,%r10,8), %xmm14
1800054ef:     	subsd	0x20(%r8,%r13,8), %xmm14
1800054f6:     	movapd	%xmm14, %xmm15
1800054fb:     	andpd	%xmm9, %xmm15
180005500:     	ucomisd	%xmm10, %xmm15
180005505:     	jae	0x18000554e <PyInit_rcaotr_61fae00d4878711302f71448+0x3bde>
180005507:     	movq	(%rdi), %rsi
18000550a:     	leaq	0x6(%rsi), %rax
18000550e:     	cmpq	%r15, %rax
180005511:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
180005517:     	movq	%rax, (%rdi)
18000551a:     	cmpb	$0x0, (%rbx)
18000551d:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005523:     	movsd	%xmm12, (%r8,%rsi,8)
180005529:     	movsd	%xmm13, 0x10(%r8,%rsi,8)
180005530:     	movsd	%xmm14, 0x20(%r8,%rsi,8)
180005537:     	movzbl	(%rbx), %eax
18000553a:     	movl	%eax, %r10d
18000553d:     	negb	%r10b
180005540:     	movl	$0x0, %r10d
180005546:     	sbbq	%r10, %r10
180005549:     	orq	%rsi, %r10
18000554c:     	jmp	0x180005563 <PyInit_rcaotr_61fae00d4878711302f71448+0x3bf3>
18000554e:     	movb	$0x1, (%rbx)
180005551:     	movq	$0xf4243, 0x18(%rdi)    # imm = 0xF4243
180005559:     	movzbl	(%rbx), %eax
18000555c:     	movq	$-0x1, %r10
180005563:     	testb	%al, %al
180005565:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000556b:     	movsd	(%r8,%r10,8), %xmm12
180005571:     	mulsd	%xmm12, %xmm12
180005576:     	movapd	%xmm12, %xmm13
18000557b:     	andpd	%xmm9, %xmm13
180005580:     	ucomisd	%xmm10, %xmm13
180005585:     	jae	0x1800055ed <PyInit_rcaotr_61fae00d4878711302f71448+0x3c7d>
180005587:     	movsd	0x10(%r8,%r10,8), %xmm13
18000558e:     	mulsd	%xmm13, %xmm13
180005593:     	movapd	%xmm13, %xmm14
180005598:     	andpd	%xmm9, %xmm14
18000559d:     	ucomisd	%xmm10, %xmm14
1800055a2:     	jae	0x1800055ed <PyInit_rcaotr_61fae00d4878711302f71448+0x3c7d>
1800055a4:     	addsd	%xmm13, %xmm12
1800055a9:     	movapd	%xmm12, %xmm13
1800055ae:     	andpd	%xmm9, %xmm13
1800055b3:     	ucomisd	%xmm10, %xmm13
1800055b8:     	jae	0x1800055ed <PyInit_rcaotr_61fae00d4878711302f71448+0x3c7d>
1800055ba:     	movsd	0x20(%r8,%r10,8), %xmm13
1800055c1:     	mulsd	%xmm13, %xmm13
1800055c6:     	movapd	%xmm13, %xmm14
1800055cb:     	andpd	%xmm9, %xmm14
1800055d0:     	ucomisd	%xmm10, %xmm14
1800055d5:     	jae	0x1800055ed <PyInit_rcaotr_61fae00d4878711302f71448+0x3c7d>
1800055d7:     	addsd	%xmm13, %xmm12
1800055dc:     	movapd	%xmm12, %xmm13
1800055e1:     	andpd	%xmm9, %xmm13
1800055e6:     	ucomisd	%xmm10, %xmm13
1800055eb:     	jb	0x180005606 <PyInit_rcaotr_61fae00d4878711302f71448+0x3c96>
1800055ed:     	movb	$0x1, (%rbx)
1800055f0:     	movq	$0x14fb183, 0x18(%rdi)  # imm = 0x14FB183
1800055f8:     	xorpd	%xmm12, %xmm12
1800055fd:     	cmpb	$0x0, (%rbx)
180005600:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005606:     	sqrtsd	%xmm12, %xmm12
18000560b:     	ucomisd	%xmm5, %xmm12
180005610:     	jne	0x18000562b <PyInit_rcaotr_61fae00d4878711302f71448+0x3cbb>
180005612:     	jp	0x18000562b <PyInit_rcaotr_61fae00d4878711302f71448+0x3cbb>
180005614:     	movb	$0x1, (%rbx)
180005617:     	movq	$0x3d0902, 0x18(%rdi)   # imm = 0x3D0902
18000561f:     	movzbl	(%rbx), %eax
180005622:     	movq	$-0x1, %r10
180005629:     	jmp	0x1800056a1 <PyInit_rcaotr_61fae00d4878711302f71448+0x3d31>
18000562b:     	movq	(%rdi), %rsi
18000562e:     	leaq	0x6(%rsi), %rax
180005632:     	cmpq	%r15, %rax
180005635:     	jg	0x180003d8a <PyInit_rcaotr_61fae00d4878711302f71448+0x241a>
18000563b:     	movsd	(%r8,%r10,8), %xmm13
180005641:     	movsd	0x10(%r8,%r10,8), %xmm14
180005648:     	movsd	0x20(%r8,%r10,8), %xmm15
18000564f:     	movq	%rax, (%rdi)
180005652:     	cmpb	$0x0, (%rbx)
180005655:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000565b:     	movsd	0x3d84(%rip), %xmm11    # 0x1800093e8
180005664:     	divsd	%xmm12, %xmm11
180005669:     	mulsd	%xmm11, %xmm13
18000566e:     	mulsd	%xmm11, %xmm14
180005673:     	mulsd	%xmm15, %xmm11
180005678:     	movsd	%xmm13, (%r8,%rsi,8)
18000567e:     	movsd	%xmm14, 0x10(%r8,%rsi,8)
180005685:     	movsd	%xmm11, 0x20(%r8,%rsi,8)
18000568c:     	movzbl	(%rbx), %eax
18000568f:     	movl	%eax, %r10d
180005692:     	negb	%r10b
180005695:     	movl	$0x0, %r10d
18000569b:     	sbbq	%r10, %r10
18000569e:     	orq	%rsi, %r10
1800056a1:     	testb	%al, %al
1800056a3:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800056a9:     	movsd	(%r8,%r10,8), %xmm12
1800056af:     	mulsd	(%r8,%rbp,8), %xmm12
1800056b5:     	movapd	%xmm12, %xmm11
1800056ba:     	andpd	%xmm9, %xmm11
1800056bf:     	ucomisd	%xmm10, %xmm11
1800056c4:     	jae	0x180005772 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e02>
1800056ca:     	movsd	0x10(%r8,%r10,8), %xmm13
1800056d1:     	mulsd	0x10(%r8,%rbp,8), %xmm13
1800056d8:     	movapd	%xmm13, %xmm11
1800056dd:     	andpd	%xmm9, %xmm11
1800056e2:     	ucomisd	%xmm10, %xmm11
1800056e7:     	jae	0x180005772 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e02>
1800056ed:     	addsd	%xmm13, %xmm12
1800056f2:     	movapd	%xmm12, %xmm11
1800056f7:     	andpd	%xmm9, %xmm11
1800056fc:     	ucomisd	%xmm10, %xmm11
180005701:     	jae	0x180005772 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e02>
180005703:     	movsd	0x20(%r8,%r10,8), %xmm13
18000570a:     	mulsd	0x20(%r8,%rbp,8), %xmm13
180005711:     	movapd	%xmm13, %xmm11
180005716:     	andpd	%xmm9, %xmm11
18000571b:     	ucomisd	%xmm10, %xmm11
180005720:     	jae	0x180005772 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e02>
180005722:     	addsd	%xmm13, %xmm12
180005727:     	movapd	%xmm12, %xmm11
18000572c:     	andpd	%xmm9, %xmm11
180005731:     	ucomisd	%xmm10, %xmm11
180005736:     	jae	0x180005772 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e02>
180005738:     	ucomisd	%xmm5, %xmm12
18000573d:     	jbe	0x1800057a0 <PyInit_rcaotr_61fae00d4878711302f71448+0x3e30>
18000573f:     	addsd	%xmm12, %xmm4
180005744:     	movapd	%xmm4, %xmm11
180005749:     	andpd	%xmm9, %xmm11
18000574e:     	ucomisd	%xmm10, %xmm11
180005753:     	movq	0x310(%rsp), %rdi
18000575b:     	movq	0xa0(%rsp), %r14
180005763:     	movq	0x90(%rsp), %rax
18000576b:     	jb	0x18000578e <PyInit_rcaotr_61fae00d4878711302f71448+0x3e1e>
18000576d:     	jmp	0x18000602e <PyInit_rcaotr_61fae00d4878711302f71448+0x46be>
180005772:     	movb	$0x1, (%rbx)
180005775:     	movq	$0x14fb183, 0x18(%rdi)  # imm = 0x14FB183
18000577d:     	cmpb	$0x0, (%rbx)
180005780:     	movq	0x90(%rsp), %rax
180005788:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000578e:     	incq	%r11
180005791:     	cmpq	(%rax,%r14), %r11
180005795:     	jl	0x180005491 <PyInit_rcaotr_61fae00d4878711302f71448+0x3b21>
18000579b:     	jmp	0x180005906 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f96>
1800057a0:     	movq	0x310(%rsp), %rdi
1800057a8:     	movq	0xa0(%rsp), %r14
1800057b0:     	movq	0x90(%rsp), %rax
1800057b8:     	incq	%r11
1800057bb:     	cmpq	(%rax,%r14), %r11
1800057bf:     	jl	0x180005491 <PyInit_rcaotr_61fae00d4878711302f71448+0x3b21>
1800057c5:     	jmp	0x180005906 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f96>
1800057ca:     	movq	0xb8(%rsp), %r11
1800057d2:     	movq	0xc0(%rsp), %rax
1800057da:     	movq	(%rax,%r12), %r10
1800057de:     	testq	%r10, %r10
1800057e1:     	jg	0x1800052fb <PyInit_rcaotr_61fae00d4878711302f71448+0x398b>
1800057e7:     	jmp	0x1800057fc <PyInit_rcaotr_61fae00d4878711302f71448+0x3e8c>
1800057e9:     	movb	$0x1, (%rbx)
1800057ec:     	movq	0x310(%rsp), %rax
1800057f4:     	movq	$0x1036646, 0x18(%rax)  # imm = 0x1036646
1800057fc:     	cmpb	$0x0, (%rbx)
1800057ff:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005801:     	movq	0x330(%rsp), %rdi
180005809:     	movq	0x28(%r9,%rdi,8), %rax
18000580e:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005818:     	addq	$0x8, %rdx
18000581c:     	cmpq	%rdx, %rax
18000581f:     	jne	0x1800058f5 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f85>
180005825:     	movb	$0x1, (%rbx)
180005828:     	movq	$0x0, 0x58(%rcx)
180005830:     	movq	$0x0, 0x50(%rcx)
180005838:     	movq	$0x0, 0x48(%rcx)
180005840:     	movq	$0x0, 0x40(%rcx)
180005848:     	movq	$0x0, 0x38(%rcx)
180005850:     	movq	$0x0, 0x30(%rcx)
180005858:     	movq	$0x0, 0x28(%rcx)
180005860:     	movq	$0x0, 0x20(%rcx)
180005868:     	movq	$0x0, 0x18(%rcx)
180005870:     	movq	$0x0, 0x10(%rcx)
180005878:     	movq	$0x0, 0x8(%rcx)
180005880:     	movq	$0x0, (%rcx)
180005887:     	xorl	%eax, %eax
180005889:     	movaps	0x200(%rsp), %xmm6
180005891:     	movaps	0x210(%rsp), %xmm7
180005899:     	movaps	0x220(%rsp), %xmm8
1800058a2:     	movaps	0x230(%rsp), %xmm9
1800058ab:     	movaps	0x240(%rsp), %xmm10
1800058b4:     	movaps	0x250(%rsp), %xmm11
1800058bd:     	movaps	0x260(%rsp), %xmm12
1800058c6:     	movaps	0x270(%rsp), %xmm13
1800058cf:     	movaps	0x280(%rsp), %xmm14
1800058d8:     	movaps	0x290(%rsp), %xmm15
1800058e1:     	addq	$0x2a8, %rsp            # imm = 0x2A8
1800058e8:     	popq	%rbx
1800058e9:     	popq	%rbp
1800058ea:     	popq	%rdi
1800058eb:     	popq	%rsi
1800058ec:     	popq	%r12
1800058ee:     	popq	%r13
1800058f0:     	popq	%r14
1800058f2:     	popq	%r15
1800058f4:     	retq
1800058f5:     	decq	%rax
1800058f8:     	movq	%rax, 0x28(%r9,%rdi,8)
1800058fd:     	jmp	0x18000316b <PyInit_rcaotr_61fae00d4878711302f71448+0x17fb>
180005902:     	xorpd	%xmm4, %xmm4
180005906:     	minsd	0x3ada(%rip), %xmm4     # 0x1800093e8
18000590e:     	mulsd	0x18(%r8,%r12), %xmm4
180005915:     	movapd	%xmm8, %xmm5
18000591a:     	mulsd	%xmm4, %xmm5
18000591e:     	addsd	%xmm5, %xmm0
180005922:     	movapd	%xmm7, %xmm5
180005926:     	mulsd	%xmm4, %xmm5
18000592a:     	addsd	%xmm5, %xmm1
18000592e:     	mulsd	%xmm6, %xmm4
180005932:     	addsd	%xmm4, %xmm2
180005936:     	xorl	%edi, %edi
180005938:     	movsd	0x8(%r8,%r12), %xmm4
18000593f:     	ucomisd	%xmm3, %xmm4
180005943:     	jbe	0x180005961 <PyInit_rcaotr_61fae00d4878711302f71448+0x3ff1>
180005945:     	mulsd	%xmm4, %xmm8
18000594a:     	addsd	%xmm8, %xmm0
18000594f:     	mulsd	%xmm4, %xmm7
180005953:     	addsd	%xmm7, %xmm1
180005957:     	mulsd	%xmm4, %xmm6
18000595b:     	addsd	%xmm6, %xmm2
18000595f:     	xorl	%edi, %edi
180005961:     	movb	%dil, 0x58(%rcx)
180005965:     	movsd	%xmm2, 0x50(%rcx)
18000596a:     	movb	%dil, 0x48(%rcx)
18000596e:     	movsd	%xmm1, 0x40(%rcx)
180005973:     	movb	%dil, 0x38(%rcx)
180005977:     	movsd	%xmm0, 0x30(%rcx)
18000597c:     	movb	$0x0, 0x28(%rcx)
180005980:     	movq	$0x0, 0x20(%rcx)
180005988:     	movb	$0x0, 0x18(%rcx)
18000598c:     	movq	$0x0, 0x10(%rcx)
180005994:     	movb	$0x0, 0x8(%rcx)
180005998:     	jmp	0x180005880 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f10>
18000599d:     	movb	$0x1, (%rbx)
1800059a0:     	movq	$0x6acfc6, 0x18(%r14)   # imm = 0x6ACFC6
1800059a8:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
1800059ad:     	movq	%r15, %r13
1800059b0:     	movb	$0x1, (%rbx)
1800059b3:     	movq	0x310(%rsp), %rax
1800059bb:     	movq	$0x15ef3c2, 0x18(%rax)  # imm = 0x15EF3C2
1800059c3:     	movq	%rbx, %r14
1800059c6:     	movzbl	(%rbx), %r11d
1800059ca:     	movq	$-0x1, %r9
1800059d1:     	testb	%r11b, %r11b
1800059d4:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
1800059da:     	movsd	(%r8,%rcx,8), %xmm0
1800059e0:     	addsd	(%r8,%r9,8), %xmm0
1800059e6:     	movapd	0x39e2(%rip), %xmm1     # 0x1800093d0
1800059ee:     	andpd	%xmm0, %xmm1
1800059f2:     	ucomisd	0x39e6(%rip), %xmm1     # 0x1800093e0
1800059fa:     	jae	0x180005b20 <PyInit_rcaotr_61fae00d4878711302f71448+0x41b0>
180005a00:     	movsd	0x10(%r8,%rcx,8), %xmm1
180005a07:     	addsd	0x10(%r8,%r9,8), %xmm1
180005a0e:     	movapd	0x39ba(%rip), %xmm2     # 0x1800093d0
180005a16:     	andpd	%xmm1, %xmm2
180005a1a:     	ucomisd	0x39be(%rip), %xmm2     # 0x1800093e0
180005a22:     	jae	0x180005b20 <PyInit_rcaotr_61fae00d4878711302f71448+0x41b0>
180005a28:     	movsd	0x20(%r8,%rcx,8), %xmm2
180005a2f:     	addsd	0x20(%r8,%r9,8), %xmm2
180005a36:     	movapd	0x3992(%rip), %xmm3     # 0x1800093d0
180005a3e:     	andpd	%xmm2, %xmm3
180005a42:     	ucomisd	0x3996(%rip), %xmm3     # 0x1800093e0
180005a4a:     	jae	0x180005b20 <PyInit_rcaotr_61fae00d4878711302f71448+0x41b0>
180005a50:     	movq	0x310(%rsp), %rax
180005a58:     	movq	(%rax), %r9
180005a5b:     	leaq	0x6(%r9), %rax
180005a5f:     	cmpq	%r13, %rax
180005a62:     	jg	0x18000541f <PyInit_rcaotr_61fae00d4878711302f71448+0x3aaf>
180005a68:     	movq	0x310(%rsp), %rcx
180005a70:     	movq	%rax, (%rcx)
180005a73:     	cmpb	$0x0, (%r14)
180005a77:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005a7d:     	movsd	%xmm0, (%r8,%r9,8)
180005a83:     	movsd	%xmm1, 0x10(%r8,%r9,8)
180005a8a:     	movsd	%xmm2, 0x20(%r8,%r9,8)
180005a91:     	movzbl	(%r14), %r10d
180005a95:     	xorl	%ecx, %ecx
180005a97:     	movl	%r10d, %eax
180005a9a:     	negb	%al
180005a9c:     	sbbq	%rcx, %rcx
180005a9f:     	orq	%r9, %rcx
180005aa2:     	jmp	0x180005b3f <PyInit_rcaotr_61fae00d4878711302f71448+0x41cf>
180005aa7:     	movq	0x338(%rsp), %rdx
180005aaf:     	movq	0x8(%rsi,%rdx,8), %rdx
180005ab4:     	movsd	(%r8,%rdx,8), %xmm1
180005aba:     	movsd	0x10(%r8,%rdx,8), %xmm2
180005ac1:     	movsd	0x20(%r8,%rdx,8), %xmm3
180005ac8:     	movq	0x310(%rsp), %rdx
180005ad0:     	movq	%rax, (%rdx)
180005ad3:     	cmpb	$0x0, (%r14)
180005ad7:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005add:     	movq	%r15, %r13
180005ae0:     	mulsd	%xmm0, %xmm1
180005ae4:     	mulsd	%xmm0, %xmm2
180005ae8:     	mulsd	%xmm0, %xmm3
180005aec:     	movsd	%xmm1, (%r8,%r10,8)
180005af2:     	movsd	%xmm2, 0x10(%r8,%r10,8)
180005af9:     	movsd	%xmm3, 0x20(%r8,%r10,8)
180005b00:     	movzbl	(%r14), %r11d
180005b04:     	xorl	%r9d, %r9d
180005b07:     	movl	%r11d, %eax
180005b0a:     	negb	%al
180005b0c:     	sbbq	%r9, %r9
180005b0f:     	orq	%r10, %r9
180005b12:     	testb	%r11b, %r11b
180005b15:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005b1b:     	jmp	0x1800059da <PyInit_rcaotr_61fae00d4878711302f71448+0x406a>
180005b20:     	movb	$0x1, (%r14)
180005b24:     	movq	0x310(%rsp), %rax
180005b2c:     	movq	$0x16e3603, 0x18(%rax)  # imm = 0x16E3603
180005b34:     	movzbl	(%r14), %r10d
180005b38:     	movq	$-0x1, %rcx
180005b3f:     	testb	%r10b, %r10b
180005b42:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005b48:     	leaq	(%rsi,%rdi,8), %r9
180005b4c:     	sarq	$0x3f, %rdi
180005b50:     	andq	%r13, %rdi
180005b53:     	movq	(%r9,%rdi,8), %rax
180005b57:     	cmpq	$0x1, %rax
180005b5b:     	je	0x180005cf0 <PyInit_rcaotr_61fae00d4878711302f71448+0x4380>
180005b61:     	testq	%rax, %rax
180005b64:     	jne	0x180005e37 <PyInit_rcaotr_61fae00d4878711302f71448+0x44c7>
180005b6a:     	movq	0x8(%r9), %rdx
180005b6e:     	movsd	(%r8,%rcx,8), %xmm0
180005b74:     	subsd	(%r8,%rdx,8), %xmm0
180005b7a:     	movapd	0x384e(%rip), %xmm1     # 0x1800093d0
180005b82:     	andpd	%xmm0, %xmm1
180005b86:     	ucomisd	0x3852(%rip), %xmm1     # 0x1800093e0
180005b8e:     	jae	0x180005e50 <PyInit_rcaotr_61fae00d4878711302f71448+0x44e0>
180005b94:     	movsd	0x10(%r8,%rcx,8), %xmm1
180005b9b:     	subsd	0x10(%r8,%rdx,8), %xmm1
180005ba2:     	movapd	0x3826(%rip), %xmm2     # 0x1800093d0
180005baa:     	andpd	%xmm1, %xmm2
180005bae:     	ucomisd	0x382a(%rip), %xmm2     # 0x1800093e0
180005bb6:     	jae	0x180005e50 <PyInit_rcaotr_61fae00d4878711302f71448+0x44e0>
180005bbc:     	movsd	0x20(%r8,%rcx,8), %xmm2
180005bc3:     	subsd	0x20(%r8,%rdx,8), %xmm2
180005bca:     	movapd	0x37fe(%rip), %xmm3     # 0x1800093d0
180005bd2:     	andpd	%xmm2, %xmm3
180005bd6:     	ucomisd	0x3802(%rip), %xmm3     # 0x1800093e0
180005bde:     	jae	0x180005e50 <PyInit_rcaotr_61fae00d4878711302f71448+0x44e0>
180005be4:     	movq	0x310(%rsp), %rax
180005bec:     	movq	(%rax), %r9
180005bef:     	leaq	0x6(%r9), %rax
180005bf3:     	cmpq	%r13, %rax
180005bf6:     	jg	0x18000541f <PyInit_rcaotr_61fae00d4878711302f71448+0x3aaf>
180005bfc:     	movq	0x310(%rsp), %rdx
180005c04:     	movq	%rax, (%rdx)
180005c07:     	cmpb	$0x0, (%r14)
180005c0b:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005c11:     	movsd	%xmm0, (%r8,%r9,8)
180005c17:     	movsd	%xmm1, 0x10(%r8,%r9,8)
180005c1e:     	movsd	%xmm2, 0x20(%r8,%r9,8)
180005c25:     	movzbl	(%r14), %r10d
180005c29:     	xorl	%edx, %edx
180005c2b:     	movl	%r10d, %eax
180005c2e:     	negb	%al
180005c30:     	sbbq	%rdx, %rdx
180005c33:     	orq	%r9, %rdx
180005c36:     	jmp	0x180005e6f <PyInit_rcaotr_61fae00d4878711302f71448+0x44ff>
180005c3b:     	movabsq	$-0x20000000000001, %rdx # imm = 0xFFDFFFFFFFFFFFFF
180005c45:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
180005c4f:     	movq	0x30(%rax), %r14
180005c53:     	movq	%r14, %rax
180005c56:     	sarq	$0x3f, %rax
180005c5a:     	andq	%rbp, %rax
180005c5d:     	leaq	(%r9,%r14,8), %r11
180005c61:     	movq	(%r11,%rax,8), %rax
180005c65:     	xorl	%esi, %esi
180005c67:     	cmpq	$-0x1, %r14
180005c6b:     	movl	$0x0, %edi
180005c70:     	cmovlq	%rbp, %rdi
180005c74:     	cmpq	$-0x2, %r14
180005c78:     	cmovlq	%rbp, %rsi
180005c7c:     	leaq	(%rax,%rdx), %r14
180005c80:     	cmpq	%r10, %r14
180005c83:     	jb	0x180005ca4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4334>
180005c85:     	movq	0x8(%r11,%rdi,8), %rdi
180005c8a:     	leaq	(%rdi,%rdx), %r14
180005c8e:     	cmpq	%r10, %r14
180005c91:     	jb	0x180005ca4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4334>
180005c93:     	movq	0x10(%r11,%rsi,8), %r11
180005c98:     	addq	%r11, %rdx
180005c9b:     	cmpq	%r10, %rdx
180005c9e:     	jae	0x18000600f <PyInit_rcaotr_61fae00d4878711302f71448+0x469f>
180005ca4:     	movb	$0x1, (%rbx)
180005ca7:     	movq	0x310(%rsp), %r14
180005caf:     	movq	$0x18cba87, 0x18(%r14)  # imm = 0x18CBA87
180005cb7:     	xorpd	%xmm7, %xmm7
180005cbb:     	xorpd	%xmm8, %xmm8
180005cc0:     	movq	%rbp, %r15
180005cc3:     	jmp	0x180003d1b <PyInit_rcaotr_61fae00d4878711302f71448+0x23ab>
180005cc8:     	movq	(%r14), %r8
180005ccb:     	leaq	0x6(%r8), %rcx
180005ccf:     	cmpq	%r15, %rcx
180005cd2:     	jle	0x180005f75 <PyInit_rcaotr_61fae00d4878711302f71448+0x4605>
180005cd8:     	movq	0x318(%rsp), %rax
180005ce0:     	movb	$0x2, (%rax)
180005ce3:     	movq	0x98(%rsp), %rcx
180005ceb:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005cf0:     	movq	0x20(%r9), %rdx
180005cf4:     	movq	0x310(%rsp), %r10
180005cfc:     	movq	0x8(%r10), %rax
180005d00:     	leaq	0x1(%rax), %r9
180005d04:     	movq	%r9, 0x8(%r10)
180005d08:     	cmpq	0x10(%r10), %rax
180005d0c:     	jge	0x180005e37 <PyInit_rcaotr_61fae00d4878711302f71448+0x44c7>
180005d12:     	movq	$0x0, 0x1c8(%rsp)
180005d1e:     	movb	$0x0, 0x1d0(%rsp)
180005d26:     	movq	$0x0, 0x1d8(%rsp)
180005d32:     	movb	$0x0, 0x1e0(%rsp)
180005d3a:     	movq	$0x0, 0x1e8(%rsp)
180005d46:     	movb	$0x0, 0x1f0(%rsp)
180005d4e:     	movq	%rdx, 0x70(%rsp)
180005d53:     	movq	%rcx, 0x68(%rsp)
180005d58:     	movq	0x338(%rsp), %rax
180005d60:     	movq	%rax, 0x60(%rsp)
180005d65:     	movq	0x330(%rsp), %rax
180005d6d:     	movq	%rax, 0x58(%rsp)
180005d72:     	movq	0x78(%rsp), %rax
180005d77:     	movq	%rax, 0x50(%rsp)
180005d7c:     	movq	%r13, 0x30(%rsp)
180005d81:     	movq	%r14, 0x28(%rsp)
180005d86:     	movq	0x310(%rsp), %rax
180005d8e:     	movq	%rax, 0x20(%rsp)
180005d93:     	movq	$-0x1, 0x48(%rsp)
180005d9c:     	movq	$-0x1, 0x40(%rsp)
180005da5:     	movq	$0x1, 0x38(%rsp)
180005dae:     	leaq	0x198(%rsp), %rcx
180005db6:     	movq	%rsi, %r9
180005db9:     	callq	0x180002fc0 <PyInit_rcaotr_61fae00d4878711302f71448+0x1650>
180005dbe:     	cmpb	$0x0, (%r14)
180005dc2:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005dc8:     	movq	%r14, %r10
180005dcb:     	movsd	0x1c8(%rsp), %xmm0
180005dd4:     	movzbl	0x1d0(%rsp), %eax
180005ddc:     	movsd	0x1d8(%rsp), %xmm1
180005de5:     	movzbl	0x1e0(%rsp), %edx
180005ded:     	movsd	0x1e8(%rsp), %xmm2
180005df6:     	movzbl	0x1f0(%rsp), %ecx
180005dfe:     	movq	0x310(%rsp), %r8
180005e06:     	decq	0x8(%r8)
180005e0a:     	movq	0x330(%rsp), %r8
180005e12:     	movq	0x28(%rsi,%r8,8), %r8
180005e17:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180005e21:     	addq	$0x8, %r9
180005e25:     	cmpq	%r9, %r8
180005e28:     	jne	0x1800060bd <PyInit_rcaotr_61fae00d4878711302f71448+0x474d>
180005e2e:     	movb	$0x1, (%r10)
180005e32:     	jmp	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005e37:     	movb	$0x1, (%r14)
180005e3b:     	movq	0x310(%rsp), %rax
180005e43:     	movq	$0x6acfce, 0x18(%rax)   # imm = 0x6ACFCE
180005e4b:     	jmp	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005e50:     	movb	$0x1, (%r14)
180005e54:     	movq	0x310(%rsp), %rax
180005e5c:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
180005e64:     	movzbl	(%r14), %r10d
180005e68:     	movq	$-0x1, %rdx
180005e6f:     	testb	%r10b, %r10b
180005e72:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005e78:     	movsd	(%r8,%rdx,8), %xmm0
180005e7e:     	mulsd	%xmm0, %xmm0
180005e82:     	movapd	0x3546(%rip), %xmm1     # 0x1800093d0
180005e8a:     	andpd	%xmm0, %xmm1
180005e8e:     	ucomisd	0x354a(%rip), %xmm1     # 0x1800093e0
180005e96:     	jae	0x180005f0e <PyInit_rcaotr_61fae00d4878711302f71448+0x459e>
180005e98:     	movsd	0x10(%r8,%rdx,8), %xmm1
180005e9f:     	mulsd	%xmm1, %xmm1
180005ea3:     	movapd	0x3525(%rip), %xmm2     # 0x1800093d0
180005eab:     	andpd	%xmm1, %xmm2
180005eaf:     	ucomisd	0x3529(%rip), %xmm2     # 0x1800093e0
180005eb7:     	jae	0x180005f0e <PyInit_rcaotr_61fae00d4878711302f71448+0x459e>
180005eb9:     	addsd	%xmm1, %xmm0
180005ebd:     	movapd	0x350b(%rip), %xmm1     # 0x1800093d0
180005ec5:     	andpd	%xmm0, %xmm1
180005ec9:     	ucomisd	0x350f(%rip), %xmm1     # 0x1800093e0
180005ed1:     	jae	0x180005f0e <PyInit_rcaotr_61fae00d4878711302f71448+0x459e>
180005ed3:     	movsd	0x20(%r8,%rdx,8), %xmm1
180005eda:     	mulsd	%xmm1, %xmm1
180005ede:     	movapd	0x34ea(%rip), %xmm2     # 0x1800093d0
180005ee6:     	andpd	%xmm1, %xmm2
180005eea:     	ucomisd	0x34ee(%rip), %xmm2     # 0x1800093e0
180005ef2:     	jae	0x180005f0e <PyInit_rcaotr_61fae00d4878711302f71448+0x459e>
180005ef4:     	addsd	%xmm1, %xmm0
180005ef8:     	movapd	0x34d0(%rip), %xmm1     # 0x1800093d0
180005f00:     	andpd	%xmm0, %xmm1
180005f04:     	ucomisd	0x34d4(%rip), %xmm1     # 0x1800093e0
180005f0c:     	jb	0x180005f30 <PyInit_rcaotr_61fae00d4878711302f71448+0x45c0>
180005f0e:     	movb	$0x1, (%r14)
180005f12:     	movq	0x310(%rsp), %rax
180005f1a:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180005f22:     	cmpb	$0x0, (%r14)
180005f26:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005f2c:     	xorpd	%xmm0, %xmm0
180005f30:     	sqrtsd	%xmm0, %xmm0
180005f34:     	xorpd	%xmm1, %xmm1
180005f38:     	ucomisd	%xmm1, %xmm0
180005f3c:     	jne	0x180006135 <PyInit_rcaotr_61fae00d4878711302f71448+0x47c5>
180005f42:     	jp	0x180006135 <PyInit_rcaotr_61fae00d4878711302f71448+0x47c5>
180005f48:     	movb	$0x1, (%r14)
180005f4c:     	movq	0x310(%rsp), %rax
180005f54:     	movq	$0x3d0902, 0x18(%rax)   # imm = 0x3D0902
180005f5c:     	movzbl	(%r14), %r10d
180005f60:     	movq	$-0x1, %rdx
180005f67:     	testb	%r10b, %r10b
180005f6a:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180005f70:     	jmp	0x180005cf4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4384>
180005f75:     	movq	0x88(%rsp), %r9
180005f7d:     	movsd	(%r9,%rdx,8), %xmm1
180005f83:     	movsd	0x10(%r9,%rdx,8), %xmm2
180005f8a:     	movsd	0x20(%r9,%rdx,8), %xmm3
180005f91:     	movq	%rcx, (%r14)
180005f94:     	movq	0x318(%rsp), %rcx
180005f9c:     	cmpb	$0x0, (%rcx)
180005f9f:     	movq	0x98(%rsp), %rcx
180005fa7:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
180005fad:     	movsd	0x3433(%rip), %xmm4     # 0x1800093e8
180005fb5:     	divsd	%xmm0, %xmm4
180005fb9:     	mulsd	%xmm4, %xmm1
180005fbd:     	mulsd	%xmm4, %xmm2
180005fc1:     	mulsd	%xmm3, %xmm4
180005fc5:     	movq	0x88(%rsp), %rcx
180005fcd:     	movsd	%xmm1, (%rcx,%r8,8)
180005fd3:     	movsd	%xmm2, 0x10(%rcx,%r8,8)
180005fda:     	movsd	%xmm4, 0x20(%rcx,%r8,8)
180005fe1:     	movq	0x318(%rsp), %rcx
180005fe9:     	movzbl	(%rcx), %ecx
180005fec:     	xorl	%edx, %edx
180005fee:     	movl	%ecx, %r9d
180005ff1:     	negb	%r9b
180005ff4:     	sbbq	%rdx, %rdx
180005ff7:     	orq	%r8, %rdx
180005ffa:     	testb	%cl, %cl
180005ffc:     	movq	0x98(%rsp), %rcx
180006004:     	jne	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000600a:     	jmp	0x180005130 <PyInit_rcaotr_61fae00d4878711302f71448+0x37c0>
18000600f:     	cvtsi2sd	%rax, %xmm8
180006014:     	cvtsi2sd	%rdi, %xmm7
180006019:     	cvtsi2sd	%r11, %xmm6
18000601e:     	movq	0x310(%rsp), %r14
180006026:     	movq	%rbp, %r15
180006029:     	jmp	0x180003d1b <PyInit_rcaotr_61fae00d4878711302f71448+0x23ab>
18000602e:     	movb	$0x1, (%rbx)
180006031:     	movq	$0x1406f4f, 0x18(%rdi)  # imm = 0x1406F4F
180006039:     	jmp	0x180005828 <PyInit_rcaotr_61fae00d4878711302f71448+0x3eb8>
18000603e:     	movq	0x318(%rsp), %rax
180006046:     	movb	$0x1, (%rax)
180006049:     	movq	$0x1406f47, 0x18(%r14)  # imm = 0x1406F47
180006051:     	movq	0x98(%rsp), %rax
180006059:     	movq	$0x0, 0x58(%rax)
180006061:     	movq	$0x0, 0x50(%rax)
180006069:     	movq	$0x0, 0x48(%rax)
180006071:     	movq	$0x0, 0x40(%rax)
180006079:     	movq	$0x0, 0x38(%rax)
180006081:     	movq	$0x0, 0x30(%rax)
180006089:     	movq	$0x0, 0x28(%rax)
180006091:     	movq	$0x0, 0x20(%rax)
180006099:     	movq	$0x0, 0x18(%rax)
1800060a1:     	movq	$0x0, 0x10(%rax)
1800060a9:     	movq	$0x0, 0x8(%rax)
1800060b1:     	movq	$0x0, (%rax)
1800060b8:     	jmp	0x180005887 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f17>
1800060bd:     	cmpb	$0x0, (%r10)
1800060c1:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
1800060c7:     	decq	%r8
1800060ca:     	testb	%dl, %dl
1800060cc:     	movq	0x330(%rsp), %rdx
1800060d4:     	movq	%r8, 0x28(%rsi,%rdx,8)
1800060d9:     	setne	0x18(%r12)
1800060df:     	testb	%cl, %cl
1800060e1:     	setne	0x28(%r12)
1800060e7:     	testb	%al, %al
1800060e9:     	movsd	%xmm2, 0x20(%r12)
1800060f0:     	movsd	%xmm1, 0x10(%r12)
1800060f7:     	setne	0x8(%r12)
1800060fd:     	movsd	%xmm0, (%r12)
180006103:     	movb	$0x0, 0x58(%r12)
180006109:     	movq	$0x0, 0x50(%r12)
180006112:     	movb	$0x0, 0x48(%r12)
180006118:     	movq	$0x0, 0x40(%r12)
180006121:     	movb	$0x0, 0x38(%r12)
180006127:     	movq	$0x0, 0x30(%r12)
180006130:     	jmp	0x180005887 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f17>
180006135:     	movq	0x310(%rsp), %rax
18000613d:     	movq	(%rax), %r9
180006140:     	leaq	0x6(%r9), %rax
180006144:     	cmpq	%r13, %rax
180006147:     	jg	0x18000541f <PyInit_rcaotr_61fae00d4878711302f71448+0x3aaf>
18000614d:     	movsd	(%r8,%rdx,8), %xmm1
180006153:     	movsd	0x10(%r8,%rdx,8), %xmm2
18000615a:     	movsd	0x20(%r8,%rdx,8), %xmm3
180006161:     	movq	0x310(%rsp), %rdx
180006169:     	movq	%rax, (%rdx)
18000616c:     	cmpb	$0x0, (%r14)
180006170:     	jne	0x1800061b8 <PyInit_rcaotr_61fae00d4878711302f71448+0x4848>
180006172:     	movsd	0x326e(%rip), %xmm4     # 0x1800093e8
18000617a:     	divsd	%xmm0, %xmm4
18000617e:     	mulsd	%xmm4, %xmm1
180006182:     	mulsd	%xmm4, %xmm2
180006186:     	mulsd	%xmm3, %xmm4
18000618a:     	movsd	%xmm1, (%r8,%r9,8)
180006190:     	movsd	%xmm2, 0x10(%r8,%r9,8)
180006197:     	movsd	%xmm4, 0x20(%r8,%r9,8)
18000619e:     	movzbl	(%r14), %r10d
1800061a2:     	xorl	%edx, %edx
1800061a4:     	movl	%r10d, %eax
1800061a7:     	negb	%al
1800061a9:     	sbbq	%rdx, %rdx
1800061ac:     	orq	%r9, %rdx
1800061af:     	testb	%r10b, %r10b
1800061b2:     	je	0x180005cf4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4384>
1800061b8:     	movq	$0x0, 0x58(%r12)
1800061c1:     	movq	$0x0, 0x50(%r12)
1800061ca:     	movq	$0x0, 0x48(%r12)
1800061d3:     	movq	$0x0, 0x40(%r12)
1800061dc:     	movq	$0x0, 0x38(%r12)
1800061e5:     	movq	$0x0, 0x30(%r12)
1800061ee:     	movq	$0x0, 0x28(%r12)
1800061f7:     	movq	$0x0, 0x20(%r12)
180006200:     	movq	$0x0, 0x18(%r12)
180006209:     	movq	$0x0, 0x10(%r12)
180006212:     	movq	$0x0, 0x8(%r12)
18000621b:     	movq	$0x0, (%r12)
180006223:     	jmp	0x180005887 <PyInit_rcaotr_61fae00d4878711302f71448+0x3f17>
180006228:     	int3
180006229:     	int3
18000622a:     	int3
18000622b:     	int3
18000622c:     	int3
18000622d:     	int3
18000622e:     	int3
18000622f:     	int3
180006230:     	pushq	%rbx
180006232:     	subq	$0x20, %rsp
180006236:     	movq	%rcx, %rbx
180006239:     	callq	*0x2eb1(%rip)           # 0x1800090f0
18000623f:     	movl	%eax, (%rbx)
180006241:     	addq	$0x20, %rsp
180006245:     	popq	%rbx
180006246:     	retq
180006247:     	int3
180006248:     	int3
180006249:     	int3
18000624a:     	int3
18000624b:     	int3
18000624c:     	int3
18000624d:     	int3
18000624e:     	int3
18000624f:     	int3
180006250:     	movl	(%rcx), %ecx
180006252:     	jmpq	*0x2fc7(%rip)           # 0x180009220
180006259:     	int3
18000625a:     	int3
18000625b:     	int3
18000625c:     	int3
18000625d:     	int3
18000625e:     	int3
18000625f:     	int3
180006260:     	pushq	%rbp
180006262:     	pushq	%rbx
180006263:     	pushq	%rsi
180006264:     	pushq	%rdi
180006265:     	pushq	%r14
180006267:     	pushq	%r15
180006269:     	movq	%rsp, %rbp
18000626c:     	subq	$0x48, %rsp
180006270:     	movq	0x2f79(%rip), %rax      # 0x1800091f0
180006277:     	xorl	%r15d, %r15d
18000627a:     	movq	%rcx, %rsi
18000627d:     	movq	%r15, 0x38(%rbp)
180006281:     	movl	%r15d, %r14d
180006284:     	movq	%r15, 0x50(%rbp)
180006288:     	movq	%r15, 0x48(%rbp)
18000628c:     	cmpq	%rax, 0x8(%rcx)
180006290:     	jne	0x1800063fe <PyInit_rcaotr_61fae00d4878711302f71448+0x4a8e>
180006296:     	leaq	0x48(%rbp), %rax
18000629a:     	leaq	0x50(%rbp), %r9
18000629e:     	movq	%rax, 0x20(%rsp)
1800062a3:     	leaq	0x38(%rbp), %r8
1800062a7:     	leaq	0x3a36(%rip), %rdx      # 0x180009ce4
1800062ae:     	callq	*0x2e7c(%rip)           # 0x180009130
1800062b4:     	testl	%eax, %eax
1800062b6:     	jne	0x1800063f4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a84>
1800062bc:     	movq	0x48(%rbp), %rbx
1800062c0:     	testq	%rbx, %rbx
1800062c3:     	je	0x1800063e5 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a75>
1800062c9:     	cmpq	0x3010(%rip), %rbx      # 0x1800092e0
1800062d0:     	je	0x1800063e5 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a75>
1800062d6:     	movq	0x8(%rbx), %rax
1800062da:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
1800062e4:     	je	0x1800063e5 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a75>
1800062ea:     	movq	0x20(%rbx), %rcx
1800062ee:     	callq	*0x2e9c(%rip)           # 0x180009190
1800062f4:     	movq	0x28(%rbx), %rcx
1800062f8:     	movq	%rax, %rdi
1800062fb:     	callq	*0x2e8f(%rip)           # 0x180009190
180006301:     	movq	0x30(%rbx), %rcx
180006305:     	movq	%rax, %r14
180006308:     	callq	*0x2e92(%rip)           # 0x1800091a0
18000630e:     	leaq	-0x10(%rbp), %r8
180006312:     	movl	%eax, %ebx
180006314:     	leaq	-0x18(%rbp), %rdx
180006318:     	leaq	0x40(%rbp), %rcx
18000631c:     	callq	*0x2e8e(%rip)           # 0x1800091b0
180006322:     	callq	*0x2e48(%rip)           # 0x180009170
180006328:     	movq	%rax, %rsi
18000632b:     	testq	%rax, %rax
18000632e:     	je	0x1800063db <PyInit_rcaotr_61fae00d4878711302f71448+0x4a6b>
180006334:     	movl	%ebx, %r8d
180006337:     	movq	%rdi, %rdx
18000633a:     	movq	%r14, %rcx
18000633d:     	callq	*0x2f25(%rip)           # 0x180009268
180006343:     	movq	%rax, %rdi
180006346:     	testq	%rax, %rax
180006349:     	je	0x1800063db <PyInit_rcaotr_61fae00d4878711302f71448+0x4a6b>
18000634f:     	callq	*0x2f23(%rip)           # 0x180009278
180006355:     	xorl	%r9d, %r9d
180006358:     	movq	%rsi, %r8
18000635b:     	movq	%rax, %rcx
18000635e:     	movq	%rdi, %rdx
180006361:     	callq	*0x2ee9(%rip)           # 0x180009250
180006367:     	movl	(%rsi), %ecx
180006369:     	movq	%rax, %rbx
18000636c:     	testl	%ecx, %ecx
18000636e:     	js	0x180006380 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a10>
180006370:     	subl	$0x1, %ecx
180006373:     	movl	%ecx, (%rsi)
180006375:     	jne	0x180006380 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a10>
180006377:     	movq	%rsi, %rcx
18000637a:     	callq	*0x2e58(%rip)           # 0x1800091d8
180006380:     	movl	(%rdi), %eax
180006382:     	testl	%eax, %eax
180006384:     	js	0x180006396 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a26>
180006386:     	subl	$0x1, %eax
180006389:     	movl	%eax, (%rdi)
18000638b:     	jne	0x180006396 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a26>
18000638d:     	movq	%rdi, %rcx
180006390:     	callq	*0x2e42(%rip)           # 0x1800091d8
180006396:     	testq	%rbx, %rbx
180006399:     	je	0x1800063db <PyInit_rcaotr_61fae00d4878711302f71448+0x4a6b>
18000639b:     	movq	-0x10(%rbp), %r8
18000639f:     	movq	-0x18(%rbp), %rdx
1800063a3:     	movq	0x40(%rbp), %rcx
1800063a7:     	callq	*0x2e33(%rip)           # 0x1800091e0
1800063ad:     	movq	%rbx, %rcx
1800063b0:     	callq	*0x2e82(%rip)           # 0x180009238
1800063b6:     	movl	(%rbx), %eax
1800063b8:     	testl	%eax, %eax
1800063ba:     	js	0x1800063e5 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a75>
1800063bc:     	subl	$0x1, %eax
1800063bf:     	movl	%eax, (%rbx)
1800063c1:     	jne	0x1800063e5 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a75>
1800063c3:     	movq	%rbx, %rcx
1800063c6:     	callq	*0x2e0c(%rip)           # 0x1800091d8
1800063cc:     	xorl	%eax, %eax
1800063ce:     	addq	$0x48, %rsp
1800063d2:     	popq	%r15
1800063d4:     	popq	%r14
1800063d6:     	popq	%rdi
1800063d7:     	popq	%rsi
1800063d8:     	popq	%rbx
1800063d9:     	popq	%rbp
1800063da:     	retq
1800063db:     	movq	0x40(%rbp), %rcx
1800063df:     	callq	*0x2e2b(%rip)           # 0x180009210
1800063e5:     	xorl	%eax, %eax
1800063e7:     	addq	$0x48, %rsp
1800063eb:     	popq	%r15
1800063ed:     	popq	%r14
1800063ef:     	popq	%rdi
1800063f0:     	popq	%rsi
1800063f1:     	popq	%rbx
1800063f2:     	popq	%rbp
1800063f3:     	retq
1800063f4:     	movq	0x38(%rbp), %rbx
1800063f8:     	movq	0x50(%rbp), %r14
1800063fc:     	jmp	0x180006405 <PyInit_rcaotr_61fae00d4878711302f71448+0x4a95>
1800063fe:     	movq	%rsi, %rbx
180006401:     	movq	%rbx, 0x38(%rbp)
180006405:     	cmpq	0x2ed4(%rip), %rbx      # 0x1800092e0
18000640c:     	jne	0x1800064a4 <PyInit_rcaotr_61fae00d4878711302f71448+0x4b34>
180006412:     	leaq	-0x18(%rbp), %r8
180006416:     	leaq	-0x10(%rbp), %rdx
18000641a:     	leaq	0x40(%rbp), %rcx
18000641e:     	callq	*0x2cfc(%rip)           # 0x180009120
180006424:     	movq	0x2eb5(%rip), %rax      # 0x1800092e0
18000642b:     	cmpq	%rax, 0x40(%rbp)
18000642f:     	jne	0x180006444 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ad4>
180006431:     	movq	0x2e88(%rip), %rcx      # 0x1800092c0
180006438:     	leaq	0x3859(%rip), %rdx      # 0x180009c98
18000643f:     	jmp	0x180006565 <PyInit_rcaotr_61fae00d4878711302f71448+0x4bf5>
180006444:     	movq	0x40(%rbp), %rcx
180006448:     	testq	%rcx, %rcx
18000644b:     	je	0x18000645a <PyInit_rcaotr_61fae00d4878711302f71448+0x4aea>
18000644d:     	movl	(%rcx), %eax
18000644f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006454:     	jae	0x18000645a <PyInit_rcaotr_61fae00d4878711302f71448+0x4aea>
180006456:     	incl	%eax
180006458:     	movl	%eax, (%rcx)
18000645a:     	movq	-0x10(%rbp), %rcx
18000645e:     	testq	%rcx, %rcx
180006461:     	je	0x180006470 <PyInit_rcaotr_61fae00d4878711302f71448+0x4b00>
180006463:     	movl	(%rcx), %eax
180006465:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000646a:     	jae	0x180006470 <PyInit_rcaotr_61fae00d4878711302f71448+0x4b00>
18000646c:     	incl	%eax
18000646e:     	movl	%eax, (%rcx)
180006470:     	movq	-0x18(%rbp), %r8
180006474:     	testq	%r8, %r8
180006477:     	je	0x18000648c <PyInit_rcaotr_61fae00d4878711302f71448+0x4b1c>
180006479:     	movl	(%r8), %eax
18000647c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006481:     	jae	0x18000648c <PyInit_rcaotr_61fae00d4878711302f71448+0x4b1c>
180006483:     	incl	%eax
180006485:     	movl	%eax, (%r8)
180006488:     	movq	-0x18(%rbp), %r8
18000648c:     	movq	-0x10(%rbp), %rdx
180006490:     	movq	0x40(%rbp), %rcx
180006494:     	callq	*0x2d46(%rip)           # 0x1800091e0
18000649a:     	movl	$0x1, %ebx
18000649f:     	jmp	0x180006571 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c01>
1800064a4:     	movq	0x8(%rbx), %rcx
1800064a8:     	movl	0xa8(%rcx), %eax
1800064ae:     	testl	%eax, %eax
1800064b0:     	jns	0x180006546 <PyInit_rcaotr_61fae00d4878711302f71448+0x4bd6>
1800064b6:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
1800064c0:     	je	0x180006546 <PyInit_rcaotr_61fae00d4878711302f71448+0x4bd6>
1800064c6:     	movq	%r14, %rdx
1800064c9:     	movq	%rbx, %rcx
1800064cc:     	callq	*0x2c3e(%rip)           # 0x180009110
1800064d2:     	movq	%rax, %rdi
1800064d5:     	testq	%rax, %rax
1800064d8:     	je	0x18000656e <PyInit_rcaotr_61fae00d4878711302f71448+0x4bfe>
1800064de:     	movq	0x8(%rax), %rax
1800064e2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
1800064ec:     	jne	0x18000651d <PyInit_rcaotr_61fae00d4878711302f71448+0x4bad>
1800064ee:     	movq	0x2dbb(%rip), %rcx      # 0x1800092b0
1800064f5:     	leaq	0x37bc(%rip), %rdx      # 0x180009cb8
1800064fc:     	movq	(%rcx), %rcx
1800064ff:     	callq	*0x2db3(%rip)           # 0x1800092b8
180006505:     	movl	(%rdi), %eax
180006507:     	testl	%eax, %eax
180006509:     	js	0x18000656e <PyInit_rcaotr_61fae00d4878711302f71448+0x4bfe>
18000650b:     	subl	$0x1, %eax
18000650e:     	movl	%eax, (%rdi)
180006510:     	jne	0x18000656e <PyInit_rcaotr_61fae00d4878711302f71448+0x4bfe>
180006512:     	movq	%rdi, %rcx
180006515:     	callq	*0x2cbd(%rip)           # 0x1800091d8
18000651b:     	jmp	0x18000656e <PyInit_rcaotr_61fae00d4878711302f71448+0x4bfe>
18000651d:     	movl	(%rdi), %eax
18000651f:     	testl	%eax, %eax
180006521:     	js	0x180006533 <PyInit_rcaotr_61fae00d4878711302f71448+0x4bc3>
180006523:     	subl	$0x1, %eax
180006526:     	movl	%eax, (%rdi)
180006528:     	jne	0x180006533 <PyInit_rcaotr_61fae00d4878711302f71448+0x4bc3>
18000652a:     	movq	%rdi, %rcx
18000652d:     	callq	*0x2ca5(%rip)           # 0x1800091d8
180006533:     	movq	%r14, %rdx
180006536:     	movq	%rbx, %rcx
180006539:     	callq	*0x2d31(%rip)           # 0x180009270
18000653f:     	movl	$0x1, %ebx
180006544:     	jmp	0x180006571 <PyInit_rcaotr_61fae00d4878711302f71448+0x4c01>
180006546:     	btl	$0x1e, %eax
18000654a:     	jae	0x180006557 <PyInit_rcaotr_61fae00d4878711302f71448+0x4be7>
18000654c:     	movq	%rbx, %rdx
18000654f:     	callq	*0x2d1b(%rip)           # 0x180009270
180006555:     	jmp	0x18000656e <PyInit_rcaotr_61fae00d4878711302f71448+0x4bfe>
180006557:     	movq	0x2d52(%rip), %rcx      # 0x1800092b0
18000655e:     	leaq	0x3753(%rip), %rdx      # 0x180009cb8
180006565:     	movq	(%rcx), %rcx
180006568:     	callq	*0x2d4a(%rip)           # 0x1800092b8
18000656e:     	movl	%r15d, %ebx
180006571:     	movq	0x48(%rbp), %rdi
180006575:     	testq	%rdi, %rdi
180006578:     	je	0x18000669b <PyInit_rcaotr_61fae00d4878711302f71448+0x4d2b>
18000657e:     	cmpq	0x2d5b(%rip), %rdi      # 0x1800092e0
180006585:     	je	0x18000669b <PyInit_rcaotr_61fae00d4878711302f71448+0x4d2b>
18000658b:     	movq	0x8(%rdi), %rax
18000658f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006599:     	je	0x18000669b <PyInit_rcaotr_61fae00d4878711302f71448+0x4d2b>
18000659f:     	movq	0x20(%rdi), %rcx
1800065a3:     	movq	%r12, 0x40(%rsp)
1800065a8:     	callq	*0x2be2(%rip)           # 0x180009190
1800065ae:     	movq	0x28(%rdi), %rcx
1800065b2:     	movq	%rax, %r14
1800065b5:     	callq	*0x2bd5(%rip)           # 0x180009190
1800065bb:     	movq	0x30(%rdi), %rcx
1800065bf:     	movq	%rax, %r12
1800065c2:     	callq	*0x2bd8(%rip)           # 0x1800091a0
1800065c8:     	leaq	-0x10(%rbp), %r8
1800065cc:     	movl	%eax, %edi
1800065ce:     	leaq	-0x18(%rbp), %rdx
1800065d2:     	leaq	0x40(%rbp), %rcx
1800065d6:     	callq	*0x2bd4(%rip)           # 0x1800091b0
1800065dc:     	callq	*0x2b8e(%rip)           # 0x180009170
1800065e2:     	movq	%rax, %r15
1800065e5:     	testq	%rax, %rax
1800065e8:     	je	0x18000668c <PyInit_rcaotr_61fae00d4878711302f71448+0x4d1c>
1800065ee:     	movl	%edi, %r8d
1800065f1:     	movq	%r14, %rdx
1800065f4:     	movq	%r12, %rcx
1800065f7:     	callq	*0x2c6b(%rip)           # 0x180009268
1800065fd:     	movq	%rax, %r14
180006600:     	testq	%rax, %rax
180006603:     	je	0x18000668c <PyInit_rcaotr_61fae00d4878711302f71448+0x4d1c>
180006609:     	callq	*0x2c69(%rip)           # 0x180009278
18000660f:     	xorl	%r9d, %r9d
180006612:     	movq	%r15, %r8
180006615:     	movq	%rax, %rcx
180006618:     	movq	%r14, %rdx
18000661b:     	callq	*0x2c2f(%rip)           # 0x180009250
180006621:     	movl	(%r15), %ecx
180006624:     	movq	%rax, %rdi
180006627:     	testl	%ecx, %ecx
180006629:     	js	0x18000663c <PyInit_rcaotr_61fae00d4878711302f71448+0x4ccc>
18000662b:     	subl	$0x1, %ecx
18000662e:     	movl	%ecx, (%r15)
180006631:     	jne	0x18000663c <PyInit_rcaotr_61fae00d4878711302f71448+0x4ccc>
180006633:     	movq	%r15, %rcx
180006636:     	callq	*0x2b9c(%rip)           # 0x1800091d8
18000663c:     	movl	(%r14), %eax
18000663f:     	testl	%eax, %eax
180006641:     	js	0x180006654 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ce4>
180006643:     	subl	$0x1, %eax
180006646:     	movl	%eax, (%r14)
180006649:     	jne	0x180006654 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ce4>
18000664b:     	movq	%r14, %rcx
18000664e:     	callq	*0x2b84(%rip)           # 0x1800091d8
180006654:     	testq	%rdi, %rdi
180006657:     	je	0x18000668c <PyInit_rcaotr_61fae00d4878711302f71448+0x4d1c>
180006659:     	movq	-0x10(%rbp), %r8
18000665d:     	movq	-0x18(%rbp), %rdx
180006661:     	movq	0x40(%rbp), %rcx
180006665:     	callq	*0x2b75(%rip)           # 0x1800091e0
18000666b:     	movq	%rdi, %rcx
18000666e:     	callq	*0x2bc4(%rip)           # 0x180009238
180006674:     	movl	(%rdi), %eax
180006676:     	testl	%eax, %eax
180006678:     	js	0x180006696 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d26>
18000667a:     	subl	$0x1, %eax
18000667d:     	movl	%eax, (%rdi)
18000667f:     	jne	0x180006696 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d26>
180006681:     	movq	%rdi, %rcx
180006684:     	callq	*0x2b4e(%rip)           # 0x1800091d8
18000668a:     	jmp	0x180006696 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d26>
18000668c:     	movq	0x40(%rbp), %rcx
180006690:     	callq	*0x2b7a(%rip)           # 0x180009210
180006696:     	movq	0x40(%rsp), %r12
18000669b:     	movl	(%rsi), %ecx
18000669d:     	testl	%ecx, %ecx
18000669f:     	js	0x1800066b1 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d41>
1800066a1:     	subl	$0x1, %ecx
1800066a4:     	movl	%ecx, (%rsi)
1800066a6:     	jne	0x1800066b1 <PyInit_rcaotr_61fae00d4878711302f71448+0x4d41>
1800066a8:     	movq	%rsi, %rcx
1800066ab:     	callq	*0x2b27(%rip)           # 0x1800091d8
1800066b1:     	movl	%ebx, %eax
1800066b3:     	addq	$0x48, %rsp
1800066b7:     	popq	%r15
1800066b9:     	popq	%r14
1800066bb:     	popq	%rdi
1800066bc:     	popq	%rsi
1800066bd:     	popq	%rbx
1800066be:     	popq	%rbp
1800066bf:     	retq
1800066c0:     	movq	%rbx, 0x8(%rsp)
1800066c5:     	movq	%rsi, 0x10(%rsp)
1800066ca:     	pushq	%rdi
1800066cb:     	subq	$0x20, %rsp
1800066cf:     	cmpq	$0x0, 0xa581(%rip)      # 0x180010c58
1800066d7:     	movq	%rcx, %rsi
1800066da:     	movslq	%edx, %rdi
1800066dd:     	jne	0x18000672d <PyInit_rcaotr_61fae00d4878711302f71448+0x4dbd>
1800066df:     	leaq	0x3602(%rip), %rcx      # 0x180009ce8
1800066e6:     	callq	*0x2b5c(%rip)           # 0x180009248
1800066ec:     	movq	%rax, %rbx
1800066ef:     	testq	%rax, %rax
1800066f2:     	je	0x180006741 <PyInit_rcaotr_61fae00d4878711302f71448+0x4dd1>
1800066f4:     	leaq	0x35f5(%rip), %rdx      # 0x180009cf0
1800066fb:     	movq	%rax, %rcx
1800066fe:     	callq	*0x2a74(%rip)           # 0x180009178
180006704:     	movl	(%rbx), %ecx
180006706:     	movq	%rax, 0xa54b(%rip)      # 0x180010c58
18000670d:     	testl	%ecx, %ecx
18000670f:     	js	0x180006728 <PyInit_rcaotr_61fae00d4878711302f71448+0x4db8>
180006711:     	subl	$0x1, %ecx
180006714:     	movl	%ecx, (%rbx)
180006716:     	jne	0x180006728 <PyInit_rcaotr_61fae00d4878711302f71448+0x4db8>
180006718:     	movq	%rbx, %rcx
18000671b:     	callq	*0x2ab7(%rip)           # 0x1800091d8
180006721:     	movq	0xa530(%rip), %rax      # 0x180010c58
180006728:     	testq	%rax, %rax
18000672b:     	je	0x180006741 <PyInit_rcaotr_61fae00d4878711302f71448+0x4dd1>
18000672d:     	movq	%rdi, %rdx
180006730:     	movq	%rsi, %rcx
180006733:     	callq	*0x2b8f(%rip)           # 0x1800092c8
180006739:     	movq	%rax, %rbx
18000673c:     	testq	%rax, %rax
18000673f:     	jne	0x180006753 <PyInit_rcaotr_61fae00d4878711302f71448+0x4de3>
180006741:     	xorl	%eax, %eax
180006743:     	movq	0x30(%rsp), %rbx
180006748:     	movq	0x38(%rsp), %rsi
18000674d:     	addq	$0x20, %rsp
180006751:     	popq	%rdi
180006752:     	retq
180006753:     	movq	0xa4fe(%rip), %rcx      # 0x180010c58
18000675a:     	xorl	%r8d, %r8d
18000675d:     	movq	%rbx, %rdx
180006760:     	callq	*0x2a42(%rip)           # 0x1800091a8
180006766:     	movl	(%rbx), %ecx
180006768:     	movq	%rax, %rdi
18000676b:     	testl	%ecx, %ecx
18000676d:     	js	0x18000677f <PyInit_rcaotr_61fae00d4878711302f71448+0x4e0f>
18000676f:     	subl	$0x1, %ecx
180006772:     	movl	%ecx, (%rbx)
180006774:     	jne	0x18000677f <PyInit_rcaotr_61fae00d4878711302f71448+0x4e0f>
180006776:     	movq	%rbx, %rcx
180006779:     	callq	*0x2a59(%rip)           # 0x1800091d8
18000677f:     	movq	0x30(%rsp), %rbx
180006784:     	movq	%rdi, %rax
180006787:     	movq	0x38(%rsp), %rsi
18000678c:     	addq	$0x20, %rsp
180006790:     	popq	%rdi
180006791:     	retq
180006792:     	int3
180006793:     	int3
180006794:     	int3
180006795:     	int3
180006796:     	int3
180006797:     	int3
180006798:     	int3
180006799:     	int3
18000679a:     	int3
18000679b:     	int3
18000679c:     	int3
18000679d:     	int3
18000679e:     	int3
18000679f:     	int3
1800067a0:     	movq	%rbx, 0x8(%rsp)
1800067a5:     	movq	%rsi, 0x10(%rsp)
1800067aa:     	pushq	%rdi
1800067ab:     	subq	$0x20, %rsp
1800067af:     	movq	0xa49a(%rip), %rax      # 0x180010c50
1800067b6:     	movq	%rdx, %rdi
1800067b9:     	movq	%rcx, %rsi
1800067bc:     	testq	%rax, %rax
1800067bf:     	jne	0x180006821 <PyInit_rcaotr_61fae00d4878711302f71448+0x4eb1>
1800067c1:     	leaq	0x3530(%rip), %rcx      # 0x180009cf8
1800067c8:     	callq	*0x2a7a(%rip)           # 0x180009248
1800067ce:     	movq	%rax, %rbx
1800067d1:     	testq	%rax, %rax
1800067d4:     	je	0x18000680f <PyInit_rcaotr_61fae00d4878711302f71448+0x4e9f>
1800067d6:     	leaq	0x3533(%rip), %rdx      # 0x180009d10
1800067dd:     	movq	%rax, %rcx
1800067e0:     	callq	*0x2992(%rip)           # 0x180009178
1800067e6:     	movl	(%rbx), %ecx
1800067e8:     	movq	%rax, 0xa461(%rip)      # 0x180010c50
1800067ef:     	testl	%ecx, %ecx
1800067f1:     	js	0x18000680a <PyInit_rcaotr_61fae00d4878711302f71448+0x4e9a>
1800067f3:     	subl	$0x1, %ecx
1800067f6:     	movl	%ecx, (%rbx)
1800067f8:     	jne	0x18000680a <PyInit_rcaotr_61fae00d4878711302f71448+0x4e9a>
1800067fa:     	movq	%rbx, %rcx
1800067fd:     	callq	*0x29d5(%rip)           # 0x1800091d8
180006803:     	movq	0xa446(%rip), %rax      # 0x180010c50
18000680a:     	testq	%rax, %rax
18000680d:     	jne	0x180006821 <PyInit_rcaotr_61fae00d4878711302f71448+0x4eb1>
18000680f:     	xorl	%eax, %eax
180006811:     	movq	0x30(%rsp), %rbx
180006816:     	movq	0x38(%rsp), %rsi
18000681b:     	addq	$0x20, %rsp
18000681f:     	popq	%rdi
180006820:     	retq
180006821:     	xorl	%r9d, %r9d
180006824:     	movq	%rdi, %r8
180006827:     	movq	%rsi, %rdx
18000682a:     	movq	%rax, %rcx
18000682d:     	movq	0x30(%rsp), %rbx
180006832:     	movq	0x38(%rsp), %rsi
180006837:     	addq	$0x20, %rsp
18000683b:     	popq	%rdi
18000683c:     	jmpq	*0x2965(%rip)           # 0x1800091a8
180006843:     	int3
180006844:     	int3
180006845:     	int3
180006846:     	int3
180006847:     	int3
180006848:     	int3
180006849:     	int3
18000684a:     	int3
18000684b:     	int3
18000684c:     	int3
18000684d:     	int3
18000684e:     	int3
18000684f:     	int3
180006850:     	movq	%rbx, 0x8(%rsp)
180006855:     	movq	%rsi, 0x10(%rsp)
18000685a:     	pushq	%rdi
18000685b:     	subq	$0x20, %rsp
18000685f:     	movq	%rcx, %rbx
180006862:     	movq	%r8, %rdi
180006865:     	movq	0x10(%rcx), %rcx
180006869:     	movq	%rdx, %rsi
18000686c:     	testq	%rcx, %rcx
18000686f:     	je	0x18000687a <PyInit_rcaotr_61fae00d4878711302f71448+0x4f0a>
180006871:     	movq	%r8, %rdx
180006874:     	callq	*%rsi
180006876:     	testl	%eax, %eax
180006878:     	jne	0x18000689d <PyInit_rcaotr_61fae00d4878711302f71448+0x4f2d>
18000687a:     	movq	0x18(%rbx), %rcx
18000687e:     	testq	%rcx, %rcx
180006881:     	je	0x18000689b <PyInit_rcaotr_61fae00d4878711302f71448+0x4f2b>
180006883:     	movq	%rdi, %rdx
180006886:     	movq	%rsi, %rax
180006889:     	movq	0x30(%rsp), %rbx
18000688e:     	movq	0x38(%rsp), %rsi
180006893:     	addq	$0x20, %rsp
180006897:     	popq	%rdi
180006898:     	jmpq	*%rax
18000689b:     	xorl	%eax, %eax
18000689d:     	movq	0x30(%rsp), %rbx
1800068a2:     	movq	0x38(%rsp), %rsi
1800068a7:     	addq	$0x20, %rsp
1800068ab:     	popq	%rdi
1800068ac:     	retq
1800068ad:     	int3
1800068ae:     	int3
1800068af:     	int3
1800068b0:     	pushq	%rbx
1800068b2:     	subq	$0x20, %rsp
1800068b6:     	movq	%rcx, %rbx
1800068b9:     	movq	0x10(%rcx), %rcx
1800068bd:     	testq	%rcx, %rcx
1800068c0:     	je	0x1800068dd <PyInit_rcaotr_61fae00d4878711302f71448+0x4f6d>
1800068c2:     	movq	$0x0, 0x10(%rbx)
1800068ca:     	movl	(%rcx), %eax
1800068cc:     	testl	%eax, %eax
1800068ce:     	js	0x1800068dd <PyInit_rcaotr_61fae00d4878711302f71448+0x4f6d>
1800068d0:     	subl	$0x1, %eax
1800068d3:     	movl	%eax, (%rcx)
1800068d5:     	jne	0x1800068dd <PyInit_rcaotr_61fae00d4878711302f71448+0x4f6d>
1800068d7:     	callq	*0x28fb(%rip)           # 0x1800091d8
1800068dd:     	movq	0x18(%rbx), %rcx
1800068e1:     	testq	%rcx, %rcx
1800068e4:     	je	0x180006901 <PyInit_rcaotr_61fae00d4878711302f71448+0x4f91>
1800068e6:     	movq	$0x0, 0x18(%rbx)
1800068ee:     	movl	(%rcx), %eax
1800068f0:     	testl	%eax, %eax
1800068f2:     	js	0x180006901 <PyInit_rcaotr_61fae00d4878711302f71448+0x4f91>
1800068f4:     	subl	$0x1, %eax
1800068f7:     	movl	%eax, (%rcx)
1800068f9:     	jne	0x180006901 <PyInit_rcaotr_61fae00d4878711302f71448+0x4f91>
1800068fb:     	callq	*0x28d7(%rip)           # 0x1800091d8
180006901:     	xorl	%eax, %eax
180006903:     	addq	$0x20, %rsp
180006907:     	popq	%rbx
180006908:     	retq
180006909:     	int3
18000690a:     	int3
18000690b:     	int3
18000690c:     	int3
18000690d:     	int3
18000690e:     	int3
18000690f:     	int3
180006910:     	pushq	%rbx
180006912:     	subq	$0x20, %rsp
180006916:     	movq	%rcx, %rbx
180006919:     	callq	*0x2909(%rip)           # 0x180009228
18000691f:     	movq	0x10(%rbx), %rcx
180006923:     	testq	%rcx, %rcx
180006926:     	je	0x180006943 <PyInit_rcaotr_61fae00d4878711302f71448+0x4fd3>
180006928:     	movq	$0x0, 0x10(%rbx)
180006930:     	movl	(%rcx), %eax
180006932:     	testl	%eax, %eax
180006934:     	js	0x180006943 <PyInit_rcaotr_61fae00d4878711302f71448+0x4fd3>
180006936:     	subl	$0x1, %eax
180006939:     	movl	%eax, (%rcx)
18000693b:     	jne	0x180006943 <PyInit_rcaotr_61fae00d4878711302f71448+0x4fd3>
18000693d:     	callq	*0x2895(%rip)           # 0x1800091d8
180006943:     	movq	0x18(%rbx), %rcx
180006947:     	testq	%rcx, %rcx
18000694a:     	je	0x180006967 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ff7>
18000694c:     	movq	$0x0, 0x18(%rbx)
180006954:     	movl	(%rcx), %eax
180006956:     	testl	%eax, %eax
180006958:     	js	0x180006967 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ff7>
18000695a:     	subl	$0x1, %eax
18000695d:     	movl	%eax, (%rcx)
18000695f:     	jne	0x180006967 <PyInit_rcaotr_61fae00d4878711302f71448+0x4ff7>
180006961:     	callq	*0x2871(%rip)           # 0x1800091d8
180006967:     	movq	0x8(%rbx), %rax
18000696b:     	movq	%rbx, %rcx
18000696e:     	addq	$0x20, %rsp
180006972:     	popq	%rbx
180006973:     	jmpq	*0x140(%rax)
18000697a:     	int3
18000697b:     	int3
18000697c:     	int3
18000697d:     	int3
18000697e:     	int3
18000697f:     	int3
180006980:     	pushq	%rbx
180006982:     	subq	$0x30, %rsp
180006986:     	movq	%r8, %r10
180006989:     	leaq	0x58(%rsp), %rax
18000698e:     	movq	%rax, 0x28(%rsp)
180006993:     	leaq	0x9ff6(%rip), %r9       # 0x180010990
18000699a:     	movq	0x2857(%rip), %rax      # 0x1800091f8
1800069a1:     	leaq	0x3398(%rip), %r8       # 0x180009d40
1800069a8:     	movq	%rdx, %r11
1800069ab:     	movq	%rax, 0x20(%rsp)
1800069b0:     	movq	%rcx, %rbx
1800069b3:     	movq	%r10, %rdx
1800069b6:     	movq	%r11, %rcx
1800069b9:     	callq	*0x2739(%rip)           # 0x1800090f8
1800069bf:     	testl	%eax, %eax
1800069c1:     	je	0x180006a1c <PyInit_rcaotr_61fae00d4878711302f71448+0x50ac>
1800069c3:     	xorl	%r8d, %r8d
1800069c6:     	xorl	%edx, %edx
1800069c8:     	movq	%rbx, %rcx
1800069cb:     	callq	*0x2887(%rip)           # 0x180009258
1800069d1:     	movq	%rax, %rbx
1800069d4:     	testq	%rax, %rax
1800069d7:     	je	0x180006a1c <PyInit_rcaotr_61fae00d4878711302f71448+0x50ac>
1800069d9:     	movq	0x58(%rsp), %rax
1800069de:     	movl	(%rax), %ecx
1800069e0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
1800069e6:     	jae	0x1800069f1 <PyInit_rcaotr_61fae00d4878711302f71448+0x5081>
1800069e8:     	incl	%ecx
1800069ea:     	movl	%ecx, (%rax)
1800069ec:     	movq	0x58(%rsp), %rax
1800069f1:     	xorl	%ecx, %ecx
1800069f3:     	movq	%rax, 0x10(%rbx)
1800069f7:     	callq	*0x278b(%rip)           # 0x180009188
1800069fd:     	movq	%rax, 0x18(%rbx)
180006a01:     	testq	%rax, %rax
180006a04:     	jne	0x180006a24 <PyInit_rcaotr_61fae00d4878711302f71448+0x50b4>
180006a06:     	movl	(%rbx), %eax
180006a08:     	testl	%eax, %eax
180006a0a:     	js	0x180006a1c <PyInit_rcaotr_61fae00d4878711302f71448+0x50ac>
180006a0c:     	subl	$0x1, %eax
180006a0f:     	movl	%eax, (%rbx)
180006a11:     	jne	0x180006a1c <PyInit_rcaotr_61fae00d4878711302f71448+0x50ac>
180006a13:     	movq	%rbx, %rcx
180006a16:     	callq	*0x27bc(%rip)           # 0x1800091d8
180006a1c:     	xorl	%eax, %eax
180006a1e:     	addq	$0x30, %rsp
180006a22:     	popq	%rbx
180006a23:     	retq
180006a24:     	movq	%rbx, %rax
180006a27:     	addq	$0x30, %rsp
180006a2b:     	popq	%rbx
180006a2c:     	retq
180006a2d:     	int3
180006a2e:     	int3
180006a2f:     	int3
180006a30:     	movq	%rbx, 0x8(%rsp)
180006a35:     	movq	%rsi, 0x10(%rsp)
180006a3a:     	pushq	%rdi
180006a3b:     	subq	$0x20, %rsp
180006a3f:     	movq	%rcx, %rbx
180006a42:     	movq	%r8, %rdi
180006a45:     	movq	0x18(%rcx), %rcx
180006a49:     	movq	%rdx, %rsi
180006a4c:     	testq	%rcx, %rcx
180006a4f:     	je	0x180006a5a <PyInit_rcaotr_61fae00d4878711302f71448+0x50ea>
180006a51:     	movq	%r8, %rdx
180006a54:     	callq	*%rsi
180006a56:     	testl	%eax, %eax
180006a58:     	jne	0x180006a7d <PyInit_rcaotr_61fae00d4878711302f71448+0x510d>
180006a5a:     	movq	0x40(%rbx), %rcx
180006a5e:     	testq	%rcx, %rcx
180006a61:     	je	0x180006a7b <PyInit_rcaotr_61fae00d4878711302f71448+0x510b>
180006a63:     	movq	%rdi, %rdx
180006a66:     	movq	%rsi, %rax
180006a69:     	movq	0x30(%rsp), %rbx
180006a6e:     	movq	0x38(%rsp), %rsi
180006a73:     	addq	$0x20, %rsp
180006a77:     	popq	%rdi
180006a78:     	jmpq	*%rax
180006a7b:     	xorl	%eax, %eax
180006a7d:     	movq	0x30(%rsp), %rbx
180006a82:     	movq	0x38(%rsp), %rsi
180006a87:     	addq	$0x20, %rsp
180006a8b:     	popq	%rdi
180006a8c:     	retq
180006a8d:     	int3
180006a8e:     	int3
180006a8f:     	int3
180006a90:     	pushq	%rbx
180006a92:     	subq	$0x20, %rsp
180006a96:     	movq	%rcx, %rbx
180006a99:     	callq	*0x2789(%rip)           # 0x180009228
180006a9f:     	cmpq	$0x0, 0x48(%rbx)
180006aa4:     	je	0x180006aaf <PyInit_rcaotr_61fae00d4878711302f71448+0x513f>
180006aa6:     	movq	%rbx, %rcx
180006aa9:     	callq	*0x26e9(%rip)           # 0x180009198
180006aaf:     	movq	0x20(%rbx), %rcx
180006ab3:     	callq	*0x270f(%rip)           # 0x1800091c8
180006ab9:     	movq	0x38(%rbx), %rcx
180006abd:     	callq	*0x2705(%rip)           # 0x1800091c8
180006ac3:     	movq	0x18(%rbx), %rcx
180006ac7:     	testq	%rcx, %rcx
180006aca:     	je	0x180006adf <PyInit_rcaotr_61fae00d4878711302f71448+0x516f>
180006acc:     	movl	(%rcx), %eax
180006ace:     	testl	%eax, %eax
180006ad0:     	js	0x180006adf <PyInit_rcaotr_61fae00d4878711302f71448+0x516f>
180006ad2:     	subl	$0x1, %eax
180006ad5:     	movl	%eax, (%rcx)
180006ad7:     	jne	0x180006adf <PyInit_rcaotr_61fae00d4878711302f71448+0x516f>
180006ad9:     	callq	*0x26f9(%rip)           # 0x1800091d8
180006adf:     	movq	0x40(%rbx), %rcx
180006ae3:     	testq	%rcx, %rcx
180006ae6:     	je	0x180006afb <PyInit_rcaotr_61fae00d4878711302f71448+0x518b>
180006ae8:     	movl	(%rcx), %eax
180006aea:     	testl	%eax, %eax
180006aec:     	js	0x180006afb <PyInit_rcaotr_61fae00d4878711302f71448+0x518b>
180006aee:     	subl	$0x1, %eax
180006af1:     	movl	%eax, (%rcx)
180006af3:     	jne	0x180006afb <PyInit_rcaotr_61fae00d4878711302f71448+0x518b>
180006af5:     	callq	*0x26dd(%rip)           # 0x1800091d8
180006afb:     	movq	0x8(%rbx), %rax
180006aff:     	movq	%rbx, %rcx
180006b02:     	addq	$0x20, %rsp
180006b06:     	popq	%rbx
180006b07:     	jmpq	*0x140(%rax)
180006b0e:     	int3
180006b0f:     	int3
180006b10:     	pushq	%rbx
180006b12:     	subq	$0x20, %rsp
180006b16:     	callq	*0x2674(%rip)           # 0x180009190
180006b1c:     	movq	%rax, %rbx
180006b1f:     	testq	%rax, %rax
180006b22:     	jne	0x180006b2a <PyInit_rcaotr_61fae00d4878711302f71448+0x51ba>
180006b24:     	addq	$0x20, %rsp
180006b28:     	popq	%rbx
180006b29:     	retq
180006b2a:     	movq	%rbx, %rcx
180006b2d:     	movq	%rdi, 0x30(%rsp)
180006b32:     	callq	0x180008e8d <numba_list_iter_next+0xecd>
180006b37:     	leaq	0x1(%rax), %rcx
180006b3b:     	callq	*0x271f(%rip)           # 0x180009260
180006b41:     	movq	%rax, %rdi
180006b44:     	testq	%rax, %rax
180006b47:     	jne	0x180006b5c <PyInit_rcaotr_61fae00d4878711302f71448+0x51ec>
180006b49:     	callq	*0x2601(%rip)           # 0x180009150
180006b4f:     	movq	0x30(%rsp), %rdi
180006b54:     	xorl	%eax, %eax
180006b56:     	addq	$0x20, %rsp
180006b5a:     	popq	%rbx
180006b5b:     	retq
180006b5c:     	movq	%rbx, %rdx
180006b5f:     	movq	%rdi, %rcx
180006b62:     	callq	0x180008e87 <numba_list_iter_next+0xec7>
180006b67:     	movq	%rdi, %rax
180006b6a:     	movq	0x30(%rsp), %rdi
180006b6f:     	addq	$0x20, %rsp
180006b73:     	popq	%rbx
180006b74:     	retq
180006b75:     	int3
180006b76:     	int3
180006b77:     	int3
180006b78:     	int3
180006b79:     	int3
180006b7a:     	int3
180006b7b:     	int3
180006b7c:     	int3
180006b7d:     	int3
180006b7e:     	int3
180006b7f:     	int3
180006b80:     	movq	0x18(%rcx), %rcx
180006b84:     	movq	%rdx, %rax
180006b87:     	testq	%rcx, %rcx
180006b8a:     	je	0x180006b92 <PyInit_rcaotr_61fae00d4878711302f71448+0x5222>
180006b8c:     	movq	%r8, %rdx
180006b8f:     	jmpq	*%rax
180006b92:     	xorl	%eax, %eax
180006b94:     	retq
180006b95:     	int3
180006b96:     	int3
180006b97:     	int3
180006b98:     	int3
180006b99:     	int3
180006b9a:     	int3
180006b9b:     	int3
180006b9c:     	int3
180006b9d:     	int3
180006b9e:     	int3
180006b9f:     	int3
180006ba0:     	movq	%rbx, 0x8(%rsp)
180006ba5:     	pushq	%rdi
180006ba6:     	subq	$0x20, %rsp
180006baa:     	movq	0x28(%rcx), %rax
180006bae:     	xorl	%edi, %edi
180006bb0:     	movq	%rcx, %rbx
180006bb3:     	testq	%rax, %rax
180006bb6:     	je	0x180006bc2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5252>
180006bb8:     	addq	$0x38, %rcx
180006bbc:     	callq	*%rax
180006bbe:     	movq	%rdi, 0x28(%rbx)
180006bc2:     	movq	0x18(%rbx), %rcx
180006bc6:     	testq	%rcx, %rcx
180006bc9:     	je	0x180006be2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5272>
180006bcb:     	movq	%rdi, 0x18(%rbx)
180006bcf:     	movl	(%rcx), %eax
180006bd1:     	testl	%eax, %eax
180006bd3:     	js	0x180006be2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5272>
180006bd5:     	subl	$0x1, %eax
180006bd8:     	movl	%eax, (%rcx)
180006bda:     	jne	0x180006be2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5272>
180006bdc:     	callq	*0x25f6(%rip)           # 0x1800091d8
180006be2:     	movq	%rdi, 0x20(%rbx)
180006be6:     	xorl	%eax, %eax
180006be8:     	movq	0x30(%rsp), %rbx
180006bed:     	addq	$0x20, %rsp
180006bf1:     	popq	%rdi
180006bf2:     	retq
180006bf3:     	int3
180006bf4:     	int3
180006bf5:     	int3
180006bf6:     	int3
180006bf7:     	int3
180006bf8:     	int3
180006bf9:     	int3
180006bfa:     	int3
180006bfb:     	int3
180006bfc:     	int3
180006bfd:     	int3
180006bfe:     	int3
180006bff:     	int3
180006c00:     	pushq	%rbx
180006c02:     	subq	$0x20, %rsp
180006c06:     	movq	%rcx, %rbx
180006c09:     	callq	*0x2619(%rip)           # 0x180009228
180006c0f:     	cmpq	$0x0, 0x30(%rbx)
180006c14:     	je	0x180006c1f <PyInit_rcaotr_61fae00d4878711302f71448+0x52af>
180006c16:     	movq	%rbx, %rcx
180006c19:     	callq	*0x2579(%rip)           # 0x180009198
180006c1f:     	callq	*0x2523(%rip)           # 0x180009148
180006c25:     	testl	%eax, %eax
180006c27:     	jne	0x180006c38 <PyInit_rcaotr_61fae00d4878711302f71448+0x52c8>
180006c29:     	movq	0x28(%rbx), %rax
180006c2d:     	testq	%rax, %rax
180006c30:     	je	0x180006c38 <PyInit_rcaotr_61fae00d4878711302f71448+0x52c8>
180006c32:     	leaq	0x38(%rbx), %rcx
180006c36:     	callq	*%rax
180006c38:     	movq	0x18(%rbx), %rcx
180006c3c:     	testq	%rcx, %rcx
180006c3f:     	je	0x180006c54 <PyInit_rcaotr_61fae00d4878711302f71448+0x52e4>
180006c41:     	movl	(%rcx), %eax
180006c43:     	testl	%eax, %eax
180006c45:     	js	0x180006c54 <PyInit_rcaotr_61fae00d4878711302f71448+0x52e4>
180006c47:     	subl	$0x1, %eax
180006c4a:     	movl	%eax, (%rcx)
180006c4c:     	jne	0x180006c54 <PyInit_rcaotr_61fae00d4878711302f71448+0x52e4>
180006c4e:     	callq	*0x2584(%rip)           # 0x1800091d8
180006c54:     	movq	0x8(%rbx), %rax
180006c58:     	movq	%rbx, %rcx
180006c5b:     	addq	$0x20, %rsp
180006c5f:     	popq	%rbx
180006c60:     	jmpq	*0x140(%rax)
180006c67:     	int3
180006c68:     	int3
180006c69:     	int3
180006c6a:     	int3
180006c6b:     	int3
180006c6c:     	int3
180006c6d:     	int3
180006c6e:     	int3
180006c6f:     	int3
180006c70:     	pushq	%rdi
180006c72:     	subq	$0x20, %rsp
180006c76:     	cmpq	$0x0, 0x20(%rcx)
180006c7b:     	movq	%rcx, %rdi
180006c7e:     	jne	0x180006c9f <PyInit_rcaotr_61fae00d4878711302f71448+0x532f>
180006c80:     	movq	0x2639(%rip), %rcx      # 0x1800092c0
180006c87:     	leaq	0x3102(%rip), %rdx      # 0x180009d90
180006c8e:     	movq	(%rcx), %rcx
180006c91:     	callq	*0x2621(%rip)           # 0x1800092b8
180006c97:     	xorl	%eax, %eax
180006c99:     	addq	$0x20, %rsp
180006c9d:     	popq	%rdi
180006c9e:     	retq
180006c9f:     	movq	%rdi, %rdx
180006ca2:     	movq	%rbx, 0x30(%rsp)
180006ca7:     	movl	$0x1, %ecx
180006cac:     	callq	*0x2456(%rip)           # 0x180009108
180006cb2:     	movq	%rax, %rbx
180006cb5:     	testq	%rax, %rax
180006cb8:     	jne	0x180006cc5 <PyInit_rcaotr_61fae00d4878711302f71448+0x5355>
180006cba:     	movq	0x30(%rsp), %rbx
180006cbf:     	addq	$0x20, %rsp
180006cc3:     	popq	%rdi
180006cc4:     	retq
180006cc5:     	xorl	%r8d, %r8d
180006cc8:     	movq	%rbx, %rdx
180006ccb:     	movq	%rdi, %rcx
180006cce:     	callq	*0x20(%rdi)
180006cd1:     	movl	(%rbx), %ecx
180006cd3:     	movq	%rax, %rdi
180006cd6:     	testl	%ecx, %ecx
180006cd8:     	js	0x180006cea <PyInit_rcaotr_61fae00d4878711302f71448+0x537a>
180006cda:     	subl	$0x1, %ecx
180006cdd:     	movl	%ecx, (%rbx)
180006cdf:     	jne	0x180006cea <PyInit_rcaotr_61fae00d4878711302f71448+0x537a>
180006ce1:     	movq	%rbx, %rcx
180006ce4:     	callq	*0x24ee(%rip)           # 0x1800091d8
180006cea:     	movq	0x30(%rsp), %rbx
180006cef:     	movq	%rdi, %rax
180006cf2:     	addq	$0x20, %rsp
180006cf6:     	popq	%rdi
180006cf7:     	retq
180006cf8:     	int3
180006cf9:     	int3
180006cfa:     	int3
180006cfb:     	int3
180006cfc:     	int3
180006cfd:     	int3
180006cfe:     	int3
180006cff:     	int3
180006d00:     	movq	%rbx, 0x8(%rsp)
180006d05:     	pushq	%rdi
180006d06:     	subq	$0x20, %rsp
180006d0a:     	movq	%r8, %rbx
180006d0d:     	callq	*0x23dd(%rip)           # 0x1800090f0
180006d13:     	movl	(%rbx), %ecx
180006d15:     	movl	%eax, %edi
180006d17:     	testl	%ecx, %ecx
180006d19:     	js	0x180006d2b <PyInit_rcaotr_61fae00d4878711302f71448+0x53bb>
180006d1b:     	subl	$0x1, %ecx
180006d1e:     	movl	%ecx, (%rbx)
180006d20:     	jne	0x180006d2b <PyInit_rcaotr_61fae00d4878711302f71448+0x53bb>
180006d22:     	movq	%rbx, %rcx
180006d25:     	callq	*0x24ad(%rip)           # 0x1800091d8
180006d2b:     	movl	%edi, %ecx
180006d2d:     	movq	0x30(%rsp), %rbx
180006d32:     	addq	$0x20, %rsp
180006d36:     	popq	%rdi
180006d37:     	jmpq	*0x24e2(%rip)           # 0x180009220
180006d3e:     	int3
180006d3f:     	int3
180006d40:     	movq	%rbx, 0x8(%rsp)
180006d45:     	pushq	%rdi
180006d46:     	subq	$0x20, %rsp
180006d4a:     	movl	(%rdx), %eax
180006d4c:     	movq	%rdx, %rbx
180006d4f:     	movq	%rcx, %rdi
180006d52:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006d57:     	jae	0x180006d5d <PyInit_rcaotr_61fae00d4878711302f71448+0x53ed>
180006d59:     	incl	%eax
180006d5b:     	movl	%eax, (%rdx)
180006d5d:     	movl	$0x30, %ecx
180006d62:     	callq	*0x9ec0(%rip)           # 0x180010c28
180006d68:     	cmpb	$0x0, 0x9e91(%rip)      # 0x180010c00
180006d6f:     	je	0x180006d79 <PyInit_rcaotr_61fae00d4878711302f71448+0x5409>
180006d71:     	lock
180006d72:     	incq	0x9e8f(%rip)            # 0x180010c08
180006d79:     	testq	%rax, %rax
180006d7c:     	je	0x180006db3 <PyInit_rcaotr_61fae00d4878711302f71448+0x5443>
180006d7e:     	movl	$0x1, %ecx
180006d83:     	leaq	-0x8a(%rip), %rdx       # 0x180006d00 <PyInit_rcaotr_61fae00d4878711302f71448+0x5390>
180006d8a:     	xchgq	%rcx, (%rax)
180006d8d:     	xorl	%ecx, %ecx
180006d8f:     	movq	%rdx, 0x8(%rax)
180006d93:     	movq	%rcx, 0x20(%rax)
180006d97:     	movq	%rcx, 0x28(%rax)
180006d9b:     	movq	%rbx, 0x10(%rax)
180006d9f:     	movq	%rdi, 0x18(%rax)
180006da3:     	cmpb	%cl, 0x9e57(%rip)       # 0x180010c00
180006da9:     	je	0x180006db3 <PyInit_rcaotr_61fae00d4878711302f71448+0x5443>
180006dab:     	lock
180006dac:     	incq	0x9e65(%rip)            # 0x180010c18
180006db3:     	movq	0x30(%rsp), %rbx
180006db8:     	addq	$0x20, %rsp
180006dbc:     	popq	%rdi
180006dbd:     	retq
180006dbe:     	int3
180006dbf:     	int3
180006dc0:     	movq	%rbx, 0x8(%rsp)
180006dc5:     	pushq	%rdi
180006dc6:     	subq	$0x30, %rsp
180006dca:     	movq	%rcx, %rdi
180006dcd:     	leaq	0x9bac(%rip), %r9       # 0x180010980
180006dd4:     	movq	%r8, %rax
180006dd7:     	leaq	0x58(%rsp), %rcx
180006ddc:     	movq	%rdx, %r10
180006ddf:     	movq	%rcx, 0x20(%rsp)
180006de4:     	movq	%r10, %rcx
180006de7:     	leaq	0x2fea(%rip), %r8       # 0x180009dd8
180006dee:     	movq	%rax, %rdx
180006df1:     	callq	*0x2301(%rip)           # 0x1800090f8
180006df7:     	testl	%eax, %eax
180006df9:     	je	0x180006e23 <PyInit_rcaotr_61fae00d4878711302f71448+0x54b3>
180006dfb:     	movq	0x58(%rsp), %rcx
180006e00:     	callq	*0x233a(%rip)           # 0x180009140
180006e06:     	movq	%rax, %rbx
180006e09:     	callq	*0x24d9(%rip)           # 0x1800092e8
180006e0f:     	testq	%rax, %rax
180006e12:     	jne	0x180006e23 <PyInit_rcaotr_61fae00d4878711302f71448+0x54b3>
180006e14:     	movq	%rbx, 0x10(%rdi)
180006e18:     	movq	0x40(%rsp), %rbx
180006e1d:     	addq	$0x30, %rsp
180006e21:     	popq	%rdi
180006e22:     	retq
180006e23:     	movq	0x40(%rsp), %rbx
180006e28:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180006e2d:     	addq	$0x30, %rsp
180006e31:     	popq	%rdi
180006e32:     	retq
180006e33:     	int3
180006e34:     	int3
180006e35:     	int3
180006e36:     	int3
180006e37:     	int3
180006e38:     	int3
180006e39:     	int3
180006e3a:     	int3
180006e3b:     	int3
180006e3c:     	int3
180006e3d:     	int3
180006e3e:     	int3
180006e3f:     	int3
180006e40:     	subq	$0x38, %rsp
180006e44:     	movl	%r8d, %eax
180006e47:     	movq	%rdx, %r10
180006e4a:     	movq	0x10(%rcx), %r8
180006e4e:     	movq	%rcx, %rdx
180006e51:     	movl	%eax, 0x28(%rsp)
180006e55:     	movq	%r10, %rcx
180006e58:     	movl	$0x0, 0x20(%rsp)
180006e60:     	movq	0x20(%r8), %r9
180006e64:     	movq	0x18(%r8), %r8
180006e68:     	callq	*0x23aa(%rip)           # 0x180009218
180006e6e:     	addq	$0x38, %rsp
180006e72:     	retq
180006e73:     	int3
180006e74:     	int3
180006e75:     	int3
180006e76:     	int3
180006e77:     	int3
180006e78:     	int3
180006e79:     	int3
180006e7a:     	int3
180006e7b:     	int3
180006e7c:     	int3
180006e7d:     	int3
180006e7e:     	int3
180006e7f:     	int3
180006e80:     	movq	0x10(%rcx), %rax
180006e84:     	lock
180006e85:     	incq	(%rax)
180006e88:     	movq	0x2451(%rip), %rax      # 0x1800092e0
180006e8f:     	retq
180006e90:     	subq	$0x28, %rsp
180006e94:     	movq	0x10(%rcx), %rcx
180006e98:     	callq	0x180008190 <numba_list_iter_next+0x1d0>
180006e9d:     	movq	0x243c(%rip), %rax      # 0x1800092e0
180006ea4:     	addq	$0x28, %rsp
180006ea8:     	retq
180006ea9:     	int3
180006eaa:     	int3
180006eab:     	int3
180006eac:     	int3
180006ead:     	int3
180006eae:     	int3
180006eaf:     	int3
180006eb0:     	movq	0x10(%rcx), %rcx
180006eb4:     	movq	0x18(%rcx), %rcx
180006eb8:     	jmpq	*0x22a9(%rip)           # 0x180009168
180006ebf:     	int3
180006ec0:     	subq	$0x28, %rsp
180006ec4:     	movq	0x10(%rcx), %rax
180006ec8:     	testq	%rax, %rax
180006ecb:     	je	0x180006ee9 <PyInit_rcaotr_61fae00d4878711302f71448+0x5579>
180006ecd:     	cmpq	$0x0, 0x18(%rax)
180006ed2:     	je	0x180006ee9 <PyInit_rcaotr_61fae00d4878711302f71448+0x5579>
180006ed4:     	movq	(%rax), %rcx
180006ed7:     	nop
180006ed8:     	cmpq	$-0x1, %rcx
180006edc:     	je	0x180006ee9 <PyInit_rcaotr_61fae00d4878711302f71448+0x5579>
180006ede:     	addq	$0x28, %rsp
180006ee2:     	jmpq	*0x223f(%rip)           # 0x180009128
180006ee9:     	movq	0x2318(%rip), %rcx      # 0x180009208
180006ef0:     	leaq	0x2ee9(%rip), %rdx      # 0x180009de0
180006ef7:     	movq	(%rcx), %rcx
180006efa:     	callq	*0x23b8(%rip)           # 0x1800092b8
180006f00:     	xorl	%eax, %eax
180006f02:     	addq	$0x28, %rsp
180006f06:     	retq
180006f07:     	int3
180006f08:     	int3
180006f09:     	int3
180006f0a:     	int3
180006f0b:     	int3
180006f0c:     	int3
180006f0d:     	int3
180006f0e:     	int3
180006f0f:     	int3
180006f10:     	movq	0x10(%rcx), %rcx
180006f14:     	movq	0x28(%rcx), %rcx
180006f18:     	jmpq	*0x2249(%rip)           # 0x180009168
180006f1f:     	int3
180006f20:     	movq	0x10(%rcx), %rax
180006f24:     	movq	0x10(%rax), %rax
180006f28:     	testq	%rax, %rax
180006f2b:     	je	0x180006f3c <PyInit_rcaotr_61fae00d4878711302f71448+0x55cc>
180006f2d:     	movl	(%rax), %ecx
180006f2f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180006f35:     	jae	0x180006f5a <PyInit_rcaotr_61fae00d4878711302f71448+0x55ea>
180006f37:     	incl	%ecx
180006f39:     	movl	%ecx, (%rax)
180006f3b:     	retq
180006f3c:     	movq	0x239d(%rip), %rcx      # 0x1800092e0
180006f43:     	movl	(%rcx), %eax
180006f45:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006f4a:     	jae	0x180006f57 <PyInit_rcaotr_61fae00d4878711302f71448+0x55e7>
180006f4c:     	incl	%eax
180006f4e:     	movl	%eax, (%rcx)
180006f50:     	movq	0x2389(%rip), %rcx      # 0x1800092e0
180006f57:     	movq	%rcx, %rax
180006f5a:     	retq
180006f5b:     	int3
180006f5c:     	int3
180006f5d:     	int3
180006f5e:     	int3
180006f5f:     	int3
180006f60:     	pushq	%rbx
180006f62:     	subq	$0x20, %rsp
180006f66:     	movq	%rcx, %rbx
180006f69:     	movq	0x10(%rcx), %rcx
180006f6d:     	callq	0x180008190 <numba_list_iter_next+0x1d0>
180006f72:     	movq	0x8(%rbx), %rax
180006f76:     	movq	%rbx, %rcx
180006f79:     	addq	$0x20, %rsp
180006f7d:     	popq	%rbx
180006f7e:     	jmpq	*0x140(%rax)
180006f85:     	int3
180006f86:     	int3
180006f87:     	int3
180006f88:     	int3
180006f89:     	int3
180006f8a:     	int3
180006f8b:     	int3
180006f8c:     	int3
180006f8d:     	int3
180006f8e:     	int3
180006f8f:     	int3
180006f90:     	movq	%rdi, 0x18(%rsp)
180006f95:     	pushq	%r14
180006f97:     	subq	$0x20, %rsp
180006f9b:     	movq	0x9c9e(%rip), %rax      # 0x180010c40
180006fa2:     	movq	%rdx, %r14
180006fa5:     	movq	%rcx, %rdi
180006fa8:     	movq	0x8(%rcx), %rcx
180006fac:     	movq	0x10(%rax), %rdx
180006fb0:     	cmpq	%rdx, %rcx
180006fb3:     	je	0x180006fd0 <PyInit_rcaotr_61fae00d4878711302f71448+0x5660>
180006fb5:     	callq	*0x222d(%rip)           # 0x1800091e8
180006fbb:     	testl	%eax, %eax
180006fbd:     	jne	0x180006fd0 <PyInit_rcaotr_61fae00d4878711302f71448+0x5660>
180006fbf:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180006fc4:     	movq	0x40(%rsp), %rdi
180006fc9:     	addq	$0x20, %rsp
180006fcd:     	popq	%r14
180006fcf:     	retq
180006fd0:     	movq	%rbx, 0x30(%rsp)
180006fd5:     	movq	%rdi, %rdx
180006fd8:     	movq	0x10(%rdi), %rbx
180006fdc:     	movq	%rbx, %rcx
180006fdf:     	movq	%rsi, 0x38(%rsp)
180006fe4:     	movl	0x18(%rdi), %esi
180006fe7:     	callq	0x180006d40 <PyInit_rcaotr_61fae00d4878711302f71448+0x53d0>
180006fec:     	movq	%rax, (%r14)
180006fef:     	movq	0x9c4a(%rip), %rax      # 0x180010c40
180006ff6:     	movq	%rbx, 0x20(%r14)
180006ffa:     	movl	0x18(%rdi), %edx
180006ffd:     	movq	0x20(%rdi), %rcx
180007001:     	callq	*0x4f0(%rax)
180007007:     	cmpl	$0x12, 0x9c3e(%rip)     # 0x180010c4c
18000700e:     	movq	0x30(%rsp), %rbx
180007013:     	movq	%rax, 0x10(%r14)
180007017:     	movq	0x38(%rdi), %rax
18000701b:     	jl	0x180007023 <PyInit_rcaotr_61fae00d4878711302f71448+0x56b3>
18000701d:     	movq	0x28(%rax), %rax
180007021:     	jmp	0x180007027 <PyInit_rcaotr_61fae00d4878711302f71448+0x56b7>
180007023:     	movslq	0x20(%rax), %rax
180007027:     	xorl	%r8d, %r8d
18000702a:     	movq	%rax, 0x18(%r14)
18000702e:     	movq	%rdi, 0x8(%r14)
180007032:     	leaq	0x28(%r14), %rax
180007036:     	testl	%esi, %esi
180007038:     	jle	0x18000707b <PyInit_rcaotr_61fae00d4878711302f71448+0x570b>
18000703a:     	nopw	(%rax,%rax)
180007040:     	movq	0x20(%rdi), %rcx
180007044:     	movq	(%rcx,%r8,8), %rdx
180007048:     	incl	%r8d
18000704b:     	movq	%rdx, (%rax)
18000704e:     	addq	$0x8, %rax
180007052:     	cmpl	%esi, %r8d
180007055:     	jl	0x180007040 <PyInit_rcaotr_61fae00d4878711302f71448+0x56d0>
180007057:     	xorl	%r8d, %r8d
18000705a:     	nopw	(%rax,%rax)
180007060:     	movq	0x28(%rdi), %rcx
180007064:     	leaq	0x8(%rax), %rax
180007068:     	movslq	%r8d, %rdx
18000706b:     	incl	%r8d
18000706e:     	movq	(%rcx,%rdx,8), %rdx
180007072:     	movq	%rdx, -0x8(%rax)
180007076:     	cmpl	%esi, %r8d
180007079:     	jl	0x180007060 <PyInit_rcaotr_61fae00d4878711302f71448+0x56f0>
18000707b:     	movq	0x38(%rsp), %rsi
180007080:     	xorl	%eax, %eax
180007082:     	movq	0x40(%rsp), %rdi
180007087:     	addq	$0x20, %rsp
18000708b:     	popq	%r14
18000708d:     	retq
18000708e:     	int3
18000708f:     	int3
180007090:     	pushq	%rbx
180007092:     	pushq	%rbp
180007093:     	pushq	%rsi
180007094:     	pushq	%rdi
180007095:     	subq	$0x28, %rsp
180007099:     	cmpq	$0x0, 0x9bb7(%rip)      # 0x180010c58
1800070a1:     	movq	%rcx, %rbp
1800070a4:     	movslq	0x8(%rdx), %rdi
1800070a8:     	movq	(%rdx), %rsi
1800070ab:     	jne	0x180007103 <PyInit_rcaotr_61fae00d4878711302f71448+0x5793>
1800070ad:     	leaq	0x2c34(%rip), %rcx      # 0x180009ce8
1800070b4:     	callq	*0x218e(%rip)           # 0x180009248
1800070ba:     	movq	%rax, %rbx
1800070bd:     	testq	%rax, %rax
1800070c0:     	je	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
1800070c6:     	leaq	0x2c23(%rip), %rdx      # 0x180009cf0
1800070cd:     	movq	%rax, %rcx
1800070d0:     	callq	*0x20a2(%rip)           # 0x180009178
1800070d6:     	movl	(%rbx), %edx
1800070d8:     	movq	%rax, 0x9b79(%rip)      # 0x180010c58
1800070df:     	testl	%edx, %edx
1800070e1:     	js	0x1800070fa <PyInit_rcaotr_61fae00d4878711302f71448+0x578a>
1800070e3:     	subl	$0x1, %edx
1800070e6:     	movl	%edx, (%rbx)
1800070e8:     	jne	0x1800070fa <PyInit_rcaotr_61fae00d4878711302f71448+0x578a>
1800070ea:     	movq	%rbx, %rcx
1800070ed:     	callq	*0x20e5(%rip)           # 0x1800091d8
1800070f3:     	movq	0x9b5e(%rip), %rax      # 0x180010c58
1800070fa:     	testq	%rax, %rax
1800070fd:     	je	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
180007103:     	movq	%rdi, %rdx
180007106:     	movq	%rsi, %rcx
180007109:     	callq	*0x21b9(%rip)           # 0x1800092c8
18000710f:     	movq	%rax, %rdi
180007112:     	testq	%rax, %rax
180007115:     	je	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
180007117:     	movq	0x9b3a(%rip), %rcx      # 0x180010c58
18000711e:     	xorl	%r8d, %r8d
180007121:     	movq	%rax, %rdx
180007124:     	callq	*0x207e(%rip)           # 0x1800091a8
18000712a:     	movl	(%rdi), %ecx
18000712c:     	movq	%rax, %rbx
18000712f:     	testl	%ecx, %ecx
180007131:     	js	0x180007143 <PyInit_rcaotr_61fae00d4878711302f71448+0x57d3>
180007133:     	subl	$0x1, %ecx
180007136:     	movl	%ecx, (%rdi)
180007138:     	jne	0x180007143 <PyInit_rcaotr_61fae00d4878711302f71448+0x57d3>
18000713a:     	movq	%rdi, %rcx
18000713d:     	callq	*0x2095(%rip)           # 0x1800091d8
180007143:     	testq	%rbx, %rbx
180007146:     	je	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
180007148:     	movq	0x8(%rbx), %r8
18000714c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
180007157:     	jne	0x180007195 <PyInit_rcaotr_61fae00d4878711302f71448+0x5825>
180007159:     	movq	0x2150(%rip), %rcx      # 0x1800092b0
180007160:     	leaq	0x2d81(%rip), %rdx      # 0x180009ee8
180007167:     	movq	0x18(%r8), %r8
18000716b:     	movq	(%rcx), %rcx
18000716e:     	callq	*0x208c(%rip)           # 0x180009200
180007174:     	movl	(%rbx), %eax
180007176:     	testl	%eax, %eax
180007178:     	js	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
18000717a:     	subl	$0x1, %eax
18000717d:     	movl	%eax, (%rbx)
18000717f:     	jne	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
180007181:     	movq	%rbx, %rcx
180007184:     	callq	*0x204e(%rip)           # 0x1800091d8
18000718a:     	xorl	%eax, %eax
18000718c:     	addq	$0x28, %rsp
180007190:     	popq	%rdi
180007191:     	popq	%rsi
180007192:     	popq	%rbp
180007193:     	popq	%rbx
180007194:     	retq
180007195:     	xorl	%r8d, %r8d
180007198:     	leaq	0x9161(%rip), %rcx      # 0x180010300
18000719f:     	xorl	%edx, %edx
1800071a1:     	callq	*0x20b1(%rip)           # 0x180009258
1800071a7:     	movq	%rax, %rdi
1800071aa:     	testq	%rax, %rax
1800071ad:     	je	0x180007174 <PyInit_rcaotr_61fae00d4878711302f71448+0x5804>
1800071af:     	movq	%rbp, %rcx
1800071b2:     	movq	%rbx, 0x18(%rax)
1800071b6:     	callq	*0x2014(%rip)           # 0x1800091d0
1800071bc:     	movq	%rax, 0x10(%rdi)
1800071c0:     	movq	%rax, %rcx
1800071c3:     	testq	%rax, %rax
1800071c6:     	jne	0x1800071da <PyInit_rcaotr_61fae00d4878711302f71448+0x586a>
1800071c8:     	movl	(%rdi), %eax
1800071ca:     	testl	%eax, %eax
1800071cc:     	js	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
1800071ce:     	subl	$0x1, %eax
1800071d1:     	movl	%eax, (%rdi)
1800071d3:     	jne	0x18000718a <PyInit_rcaotr_61fae00d4878711302f71448+0x581a>
1800071d5:     	movq	%rdi, %rcx
1800071d8:     	jmp	0x180007184 <PyInit_rcaotr_61fae00d4878711302f71448+0x5814>
1800071da:     	movl	(%rax), %eax
1800071dc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800071e1:     	jae	0x1800071e7 <PyInit_rcaotr_61fae00d4878711302f71448+0x5877>
1800071e3:     	incl	%eax
1800071e5:     	movl	%eax, (%rcx)
1800071e7:     	movq	%rdi, %rax
1800071ea:     	addq	$0x28, %rsp
1800071ee:     	popq	%rdi
1800071ef:     	popq	%rsi
1800071f0:     	popq	%rbp
1800071f1:     	popq	%rbx
1800071f2:     	retq
1800071f3:     	int3
1800071f4:     	int3
1800071f5:     	int3
1800071f6:     	int3
1800071f7:     	int3
1800071f8:     	int3
1800071f9:     	int3
1800071fa:     	int3
1800071fb:     	int3
1800071fc:     	int3
1800071fd:     	int3
1800071fe:     	int3
1800071ff:     	int3
180007200:     	movq	%r9, 0x20(%rsp)
180007205:     	movq	%r8, 0x18(%rsp)
18000720a:     	movq	%rdx, 0x10(%rsp)
18000720f:     	movq	%rcx, 0x8(%rsp)
180007214:     	pushq	%rbx
180007215:     	pushq	%rbp
180007216:     	pushq	%rsi
180007217:     	pushq	%rdi
180007218:     	pushq	%r12
18000721a:     	pushq	%r13
18000721c:     	pushq	%r14
18000721e:     	pushq	%r15
180007220:     	subq	$0x68, %rsp
180007224:     	movq	%rcx, %r14
180007227:     	movq	%r9, %r15
18000722a:     	leaq	0x276f(%rip), %rcx      # 0x1800099a0
180007231:     	movq	%r8, %r13
180007234:     	movq	%rdx, %rsi
180007237:     	callq	*0x200b(%rip)           # 0x180009248
18000723d:     	movq	%rax, %rdi
180007240:     	testq	%rax, %rax
180007243:     	jne	0x18000727c <PyInit_rcaotr_61fae00d4878711302f71448+0x590c>
180007245:     	movq	0x1eec(%rip), %rcx      # 0x180009138
18000724c:     	movq	(%rcx), %rcx
18000724f:     	callq	*0x1f6b(%rip)           # 0x1800091c0
180007255:     	testl	%eax, %eax
180007257:     	je	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
18000725d:     	callq	*0x206d(%rip)           # 0x1800092d0
180007263:     	leaq	0x2756(%rip), %rcx      # 0x1800099c0
18000726a:     	callq	*0x1fd8(%rip)           # 0x180009248
180007270:     	movq	%rax, %rdi
180007273:     	testq	%rax, %rax
180007276:     	je	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
18000727c:     	leaq	0x275d(%rip), %rdx      # 0x1800099e0
180007283:     	movq	%rdi, %rcx
180007286:     	callq	*0x1eec(%rip)           # 0x180009178
18000728c:     	movl	(%rdi), %ecx
18000728e:     	movq	%rax, %rbx
180007291:     	testl	%ecx, %ecx
180007293:     	js	0x1800072a5 <PyInit_rcaotr_61fae00d4878711302f71448+0x5935>
180007295:     	subl	$0x1, %ecx
180007298:     	movl	%ecx, (%rdi)
18000729a:     	jne	0x1800072a5 <PyInit_rcaotr_61fae00d4878711302f71448+0x5935>
18000729c:     	movq	%rdi, %rcx
18000729f:     	callq	*0x1f33(%rip)           # 0x1800091d8
1800072a5:     	testq	%rbx, %rbx
1800072a8:     	je	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
1800072ae:     	movq	0x1e4b(%rip), %rax      # 0x180009100
1800072b5:     	cmpq	%rax, 0x8(%rbx)
1800072b9:     	je	0x1800072f5 <PyInit_rcaotr_61fae00d4878711302f71448+0x5985>
1800072bb:     	movq	0x1ffe(%rip), %rcx      # 0x1800092c0
1800072c2:     	leaq	0x2727(%rip), %rdx      # 0x1800099f0
1800072c9:     	movq	(%rcx), %rcx
1800072cc:     	callq	*0x1fe6(%rip)           # 0x1800092b8
1800072d2:     	movl	(%rbx), %eax
1800072d4:     	testl	%eax, %eax
1800072d6:     	js	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
1800072dc:     	subl	$0x1, %eax
1800072df:     	movl	%eax, (%rbx)
1800072e1:     	jne	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
1800072e7:     	movq	%rbx, %rcx
1800072ea:     	callq	*0x1ee8(%rip)           # 0x1800091d8
1800072f0:     	jmp	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
1800072f5:     	xorl	%edx, %edx
1800072f7:     	movq	%rbx, %rcx
1800072fa:     	callq	*0x1eb8(%rip)           # 0x1800091b8
180007300:     	movl	(%rbx), %ecx
180007302:     	movq	%rax, 0x9937(%rip)      # 0x180010c40
180007309:     	testl	%ecx, %ecx
18000730b:     	js	0x180007324 <PyInit_rcaotr_61fae00d4878711302f71448+0x59b4>
18000730d:     	subl	$0x1, %ecx
180007310:     	movl	%ecx, (%rbx)
180007312:     	jne	0x180007324 <PyInit_rcaotr_61fae00d4878711302f71448+0x59b4>
180007314:     	movq	%rbx, %rcx
180007317:     	callq	*0x1ebb(%rip)           # 0x1800091d8
18000731d:     	movq	0x991c(%rip), %rax      # 0x180010c40
180007324:     	testq	%rax, %rax
180007327:     	jne	0x180007342 <PyInit_rcaotr_61fae00d4878711302f71448+0x59d2>
180007329:     	leaq	0x26e8(%rip), %rdx      # 0x180009a18
180007330:     	movq	0x1f89(%rip), %rcx      # 0x1800092c0
180007337:     	movq	(%rcx), %rcx
18000733a:     	callq	*0x1f78(%rip)           # 0x1800092b8
180007340:     	jmp	0x180007377 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a07>
180007342:     	callq	*(%rax)
180007344:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180007349:     	jbe	0x1800073aa <PyInit_rcaotr_61fae00d4878711302f71448+0x5a3a>
18000734b:     	movq	0x1f6e(%rip), %rax      # 0x1800092c0
180007352:     	movq	(%rax), %rbx
180007355:     	movq	0x98e4(%rip), %rax      # 0x180010c40
18000735c:     	callq	*(%rax)
18000735e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
180007364:     	leaq	0x26d5(%rip), %rdx      # 0x180009a40
18000736b:     	movl	%eax, %r9d
18000736e:     	movq	%rbx, %rcx
180007371:     	callq	*0x1e89(%rip)           # 0x180009200
180007377:     	callq	*0x1d9b(%rip)           # 0x180009118
18000737d:     	movq	0x1f84(%rip), %rcx      # 0x180009308
180007384:     	leaq	0x28dd(%rip), %rdx      # 0x180009c68
18000738b:     	movq	(%rcx), %rcx
18000738e:     	callq	*0x1f24(%rip)           # 0x1800092b8
180007394:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007399:     	addq	$0x68, %rsp
18000739d:     	popq	%r15
18000739f:     	popq	%r14
1800073a1:     	popq	%r13
1800073a3:     	popq	%r12
1800073a5:     	popq	%rdi
1800073a6:     	popq	%rsi
1800073a7:     	popq	%rbp
1800073a8:     	popq	%rbx
1800073a9:     	retq
1800073aa:     	movq	0x988f(%rip), %rax      # 0x180010c40
1800073b1:     	callq	*0x698(%rax)
1800073b7:     	movl	%eax, 0x988f(%rip)      # 0x180010c4c
1800073bd:     	cmpl	$0x10, %eax
1800073c0:     	jge	0x1800073de <PyInit_rcaotr_61fae00d4878711302f71448+0x5a6e>
1800073c2:     	movq	0x1ef7(%rip), %rcx      # 0x1800092c0
1800073c9:     	leaq	0x26c0(%rip), %rdx      # 0x180009a90
1800073d0:     	movl	%eax, %r9d
1800073d3:     	movl	$0x10, %r8d
1800073d9:     	movq	(%rcx), %rcx
1800073dc:     	jmp	0x180007371 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a01>
1800073de:     	movq	0x985b(%rip), %rax      # 0x180010c40
1800073e5:     	callq	*0x690(%rax)
1800073eb:     	testl	%eax, %eax
1800073ed:     	jne	0x1800073fb <PyInit_rcaotr_61fae00d4878711302f71448+0x5a8b>
1800073ef:     	leaq	0x27ea(%rip), %rdx      # 0x180009be0
1800073f6:     	jmp	0x180007330 <PyInit_rcaotr_61fae00d4878711302f71448+0x59c0>
1800073fb:     	cmpl	$0x1, %eax
1800073fe:     	je	0x18000740c <PyInit_rcaotr_61fae00d4878711302f71448+0x5a9c>
180007400:     	leaq	0x2809(%rip), %rdx      # 0x180009c10
180007407:     	jmp	0x180007330 <PyInit_rcaotr_61fae00d4878711302f71448+0x59c0>
18000740c:     	leaq	0x93cd(%rip), %rcx      # 0x1800107e0
180007413:     	callq	*0x1d67(%rip)           # 0x180009180
180007419:     	testl	%eax, %eax
18000741b:     	jne	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
180007421:     	leaq	0x8ed8(%rip), %rcx      # 0x180010300
180007428:     	callq	*0x1d52(%rip)           # 0x180009180
18000742e:     	testl	%eax, %eax
180007430:     	jne	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
180007436:     	leaq	0x9203(%rip), %rcx      # 0x180010640
18000743d:     	callq	*0x1d3d(%rip)           # 0x180009180
180007443:     	testl	%eax, %eax
180007445:     	jne	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
18000744b:     	xorl	%ebx, %ebx
18000744d:     	cmpl	%ebx, 0x97f5(%rip)      # 0x180010c48
180007453:     	jne	0x180007496 <PyInit_rcaotr_61fae00d4878711302f71448+0x5b26>
180007455:     	movq	%gs:0x58, %rax
18000745e:     	movl	0x97fc(%rip), %ecx      # 0x180010c60
180007464:     	movl	$0x1, 0x97da(%rip)      # 0x180010c48
18000746e:     	movq	(%rax,%rcx,8), %rdx
180007472:     	movl	$0x10, %eax
180007477:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000747e:     	movl	$0x9f0, %eax            # imm = 0x9F0
180007483:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000748a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000748f:     	movl	%ebx, 0x9d0(%rax,%rdx)
180007496:     	movl	%ebx, 0x975c(%rip)      # 0x180010bf8
18000749c:     	movq	%rbx, %rax
18000749f:     	movb	%bl, 0x975b(%rip)       # 0x180010c00
1800074a5:     	movq	%rbx, %rcx
1800074a8:     	xchgq	%rax, 0x9759(%rip)      # 0x180010c08
1800074af:     	xchgq	%rcx, 0x975a(%rip)      # 0x180010c10
1800074b6:     	movq	%rbx, %rax
1800074b9:     	movq	%rbx, %rcx
1800074bc:     	xchgq	%rax, 0x9755(%rip)      # 0x180010c18
1800074c3:     	xchgq	%rcx, 0x9756(%rip)      # 0x180010c20
1800074ca:     	movq	0x1b97(%rip), %rax      # 0x180009068
1800074d1:     	leaq	0x8fc8(%rip), %rcx      # 0x1800104a0
1800074d8:     	movq	%rax, 0x9749(%rip)      # 0x180010c28
1800074df:     	movq	0x1b7a(%rip), %rax      # 0x180009060
1800074e6:     	movq	%rax, 0x9743(%rip)      # 0x180010c30
1800074ed:     	movq	0x1b7c(%rip), %rax      # 0x180009070
1800074f4:     	movq	%rax, 0x973d(%rip)      # 0x180010c38
1800074fb:     	movq	0x1d56(%rip), %rax      # 0x180009258
180007502:     	movq	%rax, 0x90cf(%rip)      # 0x1800105d8
180007509:     	callq	*0x1c71(%rip)           # 0x180009180
18000750f:     	testl	%eax, %eax
180007511:     	jne	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
180007517:     	leaq	0x2862(%rip), %rdx      # 0x180009d80
18000751e:     	movq	%r14, %rcx
180007521:     	callq	*0x1c51(%rip)           # 0x180009178
180007527:     	movq	%rax, 0x28(%rsp)
18000752c:     	movq	%rax, %rdi
18000752f:     	testq	%rax, %rax
180007532:     	je	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
180007538:     	leaq	0x29da(%rip), %rcx      # 0x180009f19
18000753f:     	callq	*0x1d4b(%rip)           # 0x180009290
180007545:     	movq	%rax, 0x20(%rsp)
18000754a:     	movq	%rax, %r12
18000754d:     	testq	%rax, %rax
180007550:     	je	0x180007894 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f24>
180007556:     	movl	%ebx, %ebp
180007558:     	cmpq	%rbx, (%rsi)
18000755b:     	je	0x180007704 <PyInit_rcaotr_61fae00d4878711302f71448+0x5d94>
180007561:     	movslq	%ebp, %rbx
180007564:     	leaq	0x30(%rsp), %rdx
180007569:     	movq	%r14, %rcx
18000756c:     	leaq	(%rbx,%rbx,4), %rax
180007570:     	movups	(%r13,%rax,8), %xmm0
180007576:     	movups	0x10(%r13,%rax,8), %xmm1
18000757c:     	movaps	%xmm0, 0x30(%rsp)
180007581:     	movsd	0x20(%r13,%rax,8), %xmm0
180007588:     	movsd	%xmm0, 0x50(%rsp)
18000758e:     	movaps	%xmm1, 0x40(%rsp)
180007593:     	callq	0x180007090 <PyInit_rcaotr_61fae00d4878711302f71448+0x5720>
180007598:     	movq	%rax, %r14
18000759b:     	testq	%rax, %rax
18000759e:     	je	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
1800075a4:     	movq	(%rsi), %rcx
1800075a7:     	callq	*0x1ce3(%rip)           # 0x180009290
1800075ad:     	movq	%rax, %r13
1800075b0:     	testq	%rax, %rax
1800075b3:     	je	0x1800078b7 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f47>
1800075b9:     	movq	(%r15,%rbx,8), %rcx
1800075bd:     	xorl	%edx, %edx
1800075bf:     	movq	%r14, (%rcx)
1800075c2:     	leaq	0x9217(%rip), %rcx      # 0x1800107e0
1800075c9:     	movq	0x8(%rsi), %r12
1800075cd:     	callq	*0x1b8d(%rip)           # 0x180009160
1800075d3:     	movq	%rax, %rbx
1800075d6:     	testq	%rax, %rax
1800075d9:     	je	0x180007656 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce6>
1800075db:     	movq	%r13, %rcx
1800075de:     	callq	*0x1bac(%rip)           # 0x180009190
1800075e4:     	movq	%rax, %rdi
1800075e7:     	testq	%rax, %rax
1800075ea:     	je	0x18000760c <PyInit_rcaotr_61fae00d4878711302f71448+0x5c9c>
1800075ec:     	movq	%rax, %rcx
1800075ef:     	callq	0x180008e8d <numba_list_iter_next+0xecd>
1800075f4:     	leaq	0x1(%rax), %rcx
1800075f8:     	callq	*0x1c62(%rip)           # 0x180009260
1800075fe:     	movq	%rax, %rsi
180007601:     	testq	%rax, %rax
180007604:     	jne	0x180007614 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ca4>
180007606:     	callq	*0x1b44(%rip)           # 0x180009150
18000760c:     	xorl	%eax, %eax
18000760e:     	movq	%rax, 0x20(%rbx)
180007612:     	jmp	0x180007645 <PyInit_rcaotr_61fae00d4878711302f71448+0x5cd5>
180007614:     	movq	%rdi, %rdx
180007617:     	movq	%rsi, %rcx
18000761a:     	callq	0x180008e87 <numba_list_iter_next+0xec7>
18000761f:     	movq	0x20(%rsp), %rcx
180007624:     	movq	%rsi, 0x20(%rbx)
180007628:     	movq	%r12, 0x28(%rbx)
18000762c:     	movl	$0x3, 0x30(%rbx)
180007633:     	callq	0x180006b10 <PyInit_rcaotr_61fae00d4878711302f71448+0x51a0>
180007638:     	movq	%rax, 0x38(%rbx)
18000763c:     	testq	%rax, %rax
18000763f:     	jne	0x1800077b0 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e40>
180007645:     	movl	(%rbx), %eax
180007647:     	testl	%eax, %eax
180007649:     	js	0x180007656 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce6>
18000764b:     	subl	$0x1, %eax
18000764e:     	movl	%eax, (%rbx)
180007650:     	je	0x1800077fd <PyInit_rcaotr_61fae00d4878711302f71448+0x5e8d>
180007656:     	xorl	%edi, %edi
180007658:     	movl	(%r14), %eax
18000765b:     	testl	%eax, %eax
18000765d:     	js	0x180007670 <PyInit_rcaotr_61fae00d4878711302f71448+0x5d00>
18000765f:     	subl	$0x1, %eax
180007662:     	movl	%eax, (%r14)
180007665:     	jne	0x180007670 <PyInit_rcaotr_61fae00d4878711302f71448+0x5d00>
180007667:     	movq	%r14, %rcx
18000766a:     	callq	*0x1b68(%rip)           # 0x1800091d8
180007670:     	movl	(%r13), %eax
180007674:     	testl	%eax, %eax
180007676:     	js	0x18000768a <PyInit_rcaotr_61fae00d4878711302f71448+0x5d1a>
180007678:     	subl	$0x1, %eax
18000767b:     	movl	%eax, (%r13)
18000767f:     	jne	0x18000768a <PyInit_rcaotr_61fae00d4878711302f71448+0x5d1a>
180007681:     	movq	%r13, %rcx
180007684:     	callq	*0x1b4e(%rip)           # 0x1800091d8
18000768a:     	testq	%rdi, %rdi
18000768d:     	je	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
180007693:     	movq	0xb8(%rsp), %rsi
18000769b:     	movq	%rdi, %r8
18000769e:     	movq	0xb0(%rsp), %r14
1800076a6:     	movq	%r14, %rcx
1800076a9:     	movq	(%rsi), %rdx
1800076ac:     	callq	*0x1b7e(%rip)           # 0x180009230
1800076b2:     	movl	(%rdi), %ecx
1800076b4:     	testl	%eax, %eax
1800076b6:     	jne	0x18000785a <PyInit_rcaotr_61fae00d4878711302f71448+0x5eea>
1800076bc:     	testl	%ecx, %ecx
1800076be:     	js	0x1800076d2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5d62>
1800076c0:     	leal	-0x1(%rcx), %eax
1800076c3:     	movl	%eax, (%rdi)
1800076c5:     	testl	%eax, %eax
1800076c7:     	jne	0x1800076d2 <PyInit_rcaotr_61fae00d4878711302f71448+0x5d62>
1800076c9:     	movq	%rdi, %rcx
1800076cc:     	callq	*0x1b06(%rip)           # 0x1800091d8
1800076d2:     	movq	0xc8(%rsp), %r15
1800076da:     	addq	$0x20, %rsi
1800076de:     	movq	0xc0(%rsp), %r13
1800076e6:     	incl	%ebp
1800076e8:     	movq	%rsi, 0xb8(%rsp)
1800076f0:     	cmpq	$0x0, (%rsi)
1800076f4:     	jne	0x180007561 <PyInit_rcaotr_61fae00d4878711302f71448+0x5bf1>
1800076fa:     	movq	0x20(%rsp), %r12
1800076ff:     	movq	0x28(%rsp), %rdi
180007704:     	movslq	%ebp, %rax
180007707:     	cmpq	$0x0, (%r15,%rax,8)
18000770c:     	je	0x180007779 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e09>
18000770e:     	nop
180007710:     	movslq	%ebp, %rbx
180007713:     	leaq	0x30(%rsp), %rdx
180007718:     	movq	%r14, %rcx
18000771b:     	leaq	(%rbx,%rbx,4), %rax
18000771f:     	movups	(%r13,%rax,8), %xmm0
180007725:     	movups	0x10(%r13,%rax,8), %xmm1
18000772b:     	movaps	%xmm0, 0x30(%rsp)
180007730:     	movsd	0x20(%r13,%rax,8), %xmm0
180007737:     	movsd	%xmm0, 0x50(%rsp)
18000773d:     	movaps	%xmm1, 0x40(%rsp)
180007742:     	callq	0x180007090 <PyInit_rcaotr_61fae00d4878711302f71448+0x5720>
180007747:     	testq	%rax, %rax
18000774a:     	je	0x180007875 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f05>
180007750:     	movq	(%r15,%rbx,8), %rcx
180007754:     	movq	%rax, (%rcx)
180007757:     	movl	(%rax), %ecx
180007759:     	testl	%ecx, %ecx
18000775b:     	js	0x18000776d <PyInit_rcaotr_61fae00d4878711302f71448+0x5dfd>
18000775d:     	subl	$0x1, %ecx
180007760:     	movl	%ecx, (%rax)
180007762:     	jne	0x18000776d <PyInit_rcaotr_61fae00d4878711302f71448+0x5dfd>
180007764:     	movq	%rax, %rcx
180007767:     	callq	*0x1a6b(%rip)           # 0x1800091d8
18000776d:     	incl	%ebp
18000776f:     	movslq	%ebp, %rax
180007772:     	cmpq	$0x0, (%r15,%rax,8)
180007777:     	jne	0x180007710 <PyInit_rcaotr_61fae00d4878711302f71448+0x5da0>
180007779:     	movl	(%r12), %eax
18000777d:     	testl	%eax, %eax
18000777f:     	js	0x180007793 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e23>
180007781:     	subl	$0x1, %eax
180007784:     	movl	%eax, (%r12)
180007788:     	jne	0x180007793 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e23>
18000778a:     	movq	%r12, %rcx
18000778d:     	callq	*0x1a45(%rip)           # 0x1800091d8
180007793:     	movl	(%rdi), %eax
180007795:     	testl	%eax, %eax
180007797:     	js	0x1800077a9 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e39>
180007799:     	subl	$0x1, %eax
18000779c:     	movl	%eax, (%rdi)
18000779e:     	jne	0x1800077a9 <PyInit_rcaotr_61fae00d4878711302f71448+0x5e39>
1800077a0:     	movq	%rdi, %rcx
1800077a3:     	callq	*0x1a2f(%rip)           # 0x1800091d8
1800077a9:     	xorl	%eax, %eax
1800077ab:     	jmp	0x180007399 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a29>
1800077b0:     	movl	(%r14), %eax
1800077b3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800077b8:     	jae	0x1800077bf <PyInit_rcaotr_61fae00d4878711302f71448+0x5e4f>
1800077ba:     	incl	%eax
1800077bc:     	movl	%eax, (%r14)
1800077bf:     	movq	0xb0(%rsp), %rcx
1800077c7:     	leaq	0x25b2(%rip), %rdx      # 0x180009d80
1800077ce:     	movq	%r14, 0x18(%rbx)
1800077d2:     	movq	$0x0, 0x40(%rbx)
1800077da:     	callq	*0x1998(%rip)           # 0x180009178
1800077e0:     	movq	%rax, %rsi
1800077e3:     	testq	%rax, %rax
1800077e6:     	jne	0x18000780b <PyInit_rcaotr_61fae00d4878711302f71448+0x5e9b>
1800077e8:     	movl	(%rbx), %eax
1800077ea:     	testl	%eax, %eax
1800077ec:     	js	0x180007656 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce6>
1800077f2:     	subl	$0x1, %eax
1800077f5:     	movl	%eax, (%rbx)
1800077f7:     	jne	0x180007656 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce6>
1800077fd:     	movq	%rbx, %rcx
180007800:     	callq	*0x19d2(%rip)           # 0x1800091d8
180007806:     	jmp	0x180007656 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce6>
18000780b:     	xorl	%r9d, %r9d
18000780e:     	leaq	0x20(%rbx), %rcx
180007812:     	movq	%rsi, %r8
180007815:     	movq	%rbx, %rdx
180007818:     	callq	*0x193a(%rip)           # 0x180009158
18000781e:     	movq	%rax, %rdi
180007821:     	movl	(%rbx), %eax
180007823:     	testl	%eax, %eax
180007825:     	js	0x180007837 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ec7>
180007827:     	subl	$0x1, %eax
18000782a:     	movl	%eax, (%rbx)
18000782c:     	jne	0x180007837 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ec7>
18000782e:     	movq	%rbx, %rcx
180007831:     	callq	*0x19a1(%rip)           # 0x1800091d8
180007837:     	movl	(%rsi), %eax
180007839:     	testl	%eax, %eax
18000783b:     	js	0x180007658 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce8>
180007841:     	subl	$0x1, %eax
180007844:     	movl	%eax, (%rsi)
180007846:     	jne	0x180007658 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce8>
18000784c:     	movq	%rsi, %rcx
18000784f:     	callq	*0x1983(%rip)           # 0x1800091d8
180007855:     	jmp	0x180007658 <PyInit_rcaotr_61fae00d4878711302f71448+0x5ce8>
18000785a:     	testl	%ecx, %ecx
18000785c:     	js	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
18000785e:     	leal	-0x1(%rcx), %eax
180007861:     	movl	%eax, (%rdi)
180007863:     	testl	%eax, %eax
180007865:     	jne	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
180007867:     	movq	%rdi, %rcx
18000786a:     	callq	*0x1968(%rip)           # 0x1800091d8
180007870:     	movq	0x20(%rsp), %r12
180007875:     	movl	(%r12), %eax
180007879:     	testl	%eax, %eax
18000787b:     	js	0x18000788f <PyInit_rcaotr_61fae00d4878711302f71448+0x5f1f>
18000787d:     	subl	$0x1, %eax
180007880:     	movl	%eax, (%r12)
180007884:     	jne	0x18000788f <PyInit_rcaotr_61fae00d4878711302f71448+0x5f1f>
180007886:     	movq	%r12, %rcx
180007889:     	callq	*0x1949(%rip)           # 0x1800091d8
18000788f:     	movq	0x28(%rsp), %rdi
180007894:     	movl	(%rdi), %eax
180007896:     	testl	%eax, %eax
180007898:     	js	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
18000789e:     	subl	$0x1, %eax
1800078a1:     	movl	%eax, (%rdi)
1800078a3:     	jne	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
1800078a9:     	movq	%rdi, %rcx
1800078ac:     	callq	*0x1926(%rip)           # 0x1800091d8
1800078b2:     	jmp	0x180007394 <PyInit_rcaotr_61fae00d4878711302f71448+0x5a24>
1800078b7:     	movl	(%r14), %eax
1800078ba:     	testl	%eax, %eax
1800078bc:     	js	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
1800078be:     	subl	$0x1, %eax
1800078c1:     	movl	%eax, (%r14)
1800078c4:     	jne	0x180007870 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f00>
1800078c6:     	movq	%r14, %rcx
1800078c9:     	jmp	0x18000786a <PyInit_rcaotr_61fae00d4878711302f71448+0x5efa>
1800078cb:     	int3
1800078cc:     	int3
1800078cd:     	int3
1800078ce:     	int3
1800078cf:     	int3
1800078d0:     	leaq	0x93c9(%rip), %rax      # 0x180010ca0
1800078d7:     	retq
1800078d8:     	int3
1800078d9:     	int3
1800078da:     	int3
1800078db:     	int3
1800078dc:     	int3
1800078dd:     	int3
1800078de:     	int3
1800078df:     	int3

00000001800078e0 <numba_list_set_method_table>:
1800078e0:     	movups	(%rdx), %xmm0
1800078e3:     	movups	%xmm0, 0x20(%rcx)
1800078e7:     	retq
1800078e8:     	int3
1800078e9:     	int3
1800078ea:     	int3
1800078eb:     	int3
1800078ec:     	int3
1800078ed:     	int3
1800078ee:     	int3
1800078ef:     	int3

00000001800078f0 <numba_list_new>:
1800078f0:     	pushq	%rbx
1800078f2:     	pushq	%rbp
1800078f3:     	pushq	%rsi
1800078f4:     	pushq	%rdi
1800078f5:     	subq	$0x28, %rsp
1800078f9:     	movq	%rcx, %rsi
1800078fc:     	movq	%r8, %rdi
1800078ff:     	movl	$0x38, %ecx
180007904:     	movq	%rdx, %rbp
180007907:     	callq	*0x175b(%rip)           # 0x180009068
18000790d:     	movq	%rax, %rbx
180007910:     	testq	%rax, %rax
180007913:     	je	0x18000797d <numba_list_new+0x8d>
180007915:     	movq	$0x0, (%rax)
18000791c:     	xorps	%xmm0, %xmm0
18000791f:     	movq	%rbp, 0x8(%rax)
180007923:     	movq	%rdi, 0x10(%rax)
180007927:     	movl	$0x1, 0x18(%rax)
18000792e:     	movups	%xmm0, 0x20(%rax)
180007932:     	testq	%rdi, %rdi
180007935:     	je	0x18000798b <numba_list_new+0x9b>
180007937:     	imulq	%rbp, %rdi
18000793b:     	movl	$0x8, %ecx
180007940:     	movq	%rdi, %rax
180007943:     	cqto
180007945:     	andl	$0x7, %edx
180007948:     	addq	%rdx, %rax
18000794b:     	andl	$0x7, %eax
18000794e:     	subq	%rdx, %rax
180007951:     	subq	%rax, %rcx
180007954:     	movq	%rcx, %rax
180007957:     	cqto
180007959:     	andl	$0x7, %edx
18000795c:     	leaq	(%rdx,%rax), %rcx
180007960:     	andl	$0x7, %ecx
180007963:     	subq	%rdx, %rcx
180007966:     	addq	%rdi, %rcx
180007969:     	callq	*0x16f9(%rip)           # 0x180009068
18000796f:     	testq	%rax, %rax
180007972:     	jne	0x18000798d <numba_list_new+0x9d>
180007974:     	movq	%rbx, %rcx
180007977:     	callq	*0x16f3(%rip)           # 0x180009070
18000797d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180007982:     	addq	$0x28, %rsp
180007986:     	popq	%rdi
180007987:     	popq	%rsi
180007988:     	popq	%rbp
180007989:     	popq	%rbx
18000798a:     	retq
18000798b:     	xorl	%eax, %eax
18000798d:     	movq	%rax, 0x30(%rbx)
180007991:     	xorl	%eax, %eax
180007993:     	movq	%rbx, (%rsi)
180007996:     	addq	$0x28, %rsp
18000799a:     	popq	%rdi
18000799b:     	popq	%rsi
18000799c:     	popq	%rbp
18000799d:     	popq	%rbx
18000799e:     	retq
18000799f:     	int3

00000001800079a0 <numba_list_free>:
1800079a0:     	pushq	%rbx
1800079a2:     	subq	$0x20, %rsp
1800079a6:     	cmpq	$0x0, 0x28(%rcx)
1800079ab:     	movq	%rcx, %rbx
1800079ae:     	je	0x1800079e4 <numba_list_free+0x44>
1800079b0:     	movq	%rdi, 0x30(%rsp)
1800079b5:     	xorl	%edi, %edi
1800079b7:     	cmpq	%rdi, (%rcx)
1800079ba:     	jle	0x1800079df <numba_list_free+0x3f>
1800079bc:     	nopl	(%rax)
1800079c0:     	movq	0x28(%rbx), %rax
1800079c4:     	testq	%rax, %rax
1800079c7:     	je	0x1800079d7 <numba_list_free+0x37>
1800079c9:     	movq	%rdi, %rcx
1800079cc:     	imulq	0x8(%rbx), %rcx
1800079d1:     	addq	0x30(%rbx), %rcx
1800079d5:     	callq	*%rax
1800079d7:     	incq	%rdi
1800079da:     	cmpq	(%rbx), %rdi
1800079dd:     	jl	0x1800079c0 <numba_list_free+0x20>
1800079df:     	movq	0x30(%rsp), %rdi
1800079e4:     	movq	0x30(%rbx), %rcx
1800079e8:     	testq	%rcx, %rcx
1800079eb:     	je	0x1800079f3 <numba_list_free+0x53>
1800079ed:     	callq	*0x167d(%rip)           # 0x180009070
1800079f3:     	movq	%rbx, %rcx
1800079f6:     	addq	$0x20, %rsp
1800079fa:     	popq	%rbx
1800079fb:     	jmpq	*0x166e(%rip)           # 0x180009070
180007a02:     	int3
180007a03:     	int3
180007a04:     	int3
180007a05:     	int3
180007a06:     	int3
180007a07:     	int3
180007a08:     	int3
180007a09:     	int3
180007a0a:     	int3
180007a0b:     	int3
180007a0c:     	int3
180007a0d:     	int3
180007a0e:     	int3
180007a0f:     	int3

0000000180007a10 <numba_list_base_ptr>:
180007a10:     	movq	0x30(%rcx), %rax
180007a14:     	retq
180007a15:     	int3
180007a16:     	int3
180007a17:     	int3
180007a18:     	int3
180007a19:     	int3
180007a1a:     	int3
180007a1b:     	int3
180007a1c:     	int3
180007a1d:     	int3
180007a1e:     	int3
180007a1f:     	int3

0000000180007a20 <numba_list_size_address>:
180007a20:     	movq	%rcx, %rax
180007a23:     	retq
180007a24:     	int3
180007a25:     	int3
180007a26:     	int3
180007a27:     	int3
180007a28:     	int3
180007a29:     	int3
180007a2a:     	int3
180007a2b:     	int3
180007a2c:     	int3
180007a2d:     	int3
180007a2e:     	int3
180007a2f:     	int3

0000000180007a30 <numba_list_length>:
180007a30:     	movq	(%rcx), %rax
180007a33:     	retq
180007a34:     	int3
180007a35:     	int3
180007a36:     	int3
180007a37:     	int3
180007a38:     	int3
180007a39:     	int3
180007a3a:     	int3
180007a3b:     	int3
180007a3c:     	int3
180007a3d:     	int3
180007a3e:     	int3
180007a3f:     	int3

0000000180007a40 <numba_list_allocated>:
180007a40:     	movq	0x10(%rcx), %rax
180007a44:     	retq
180007a45:     	int3
180007a46:     	int3
180007a47:     	int3
180007a48:     	int3
180007a49:     	int3
180007a4a:     	int3
180007a4b:     	int3
180007a4c:     	int3
180007a4d:     	int3
180007a4e:     	int3
180007a4f:     	int3

0000000180007a50 <numba_list_is_mutable>:
180007a50:     	movl	0x18(%rcx), %eax
180007a53:     	retq
180007a54:     	int3
180007a55:     	int3
180007a56:     	int3
180007a57:     	int3
180007a58:     	int3
180007a59:     	int3
180007a5a:     	int3
180007a5b:     	int3
180007a5c:     	int3
180007a5d:     	int3
180007a5e:     	int3
180007a5f:     	int3

0000000180007a60 <numba_list_set_is_mutable>:
180007a60:     	movl	%edx, 0x18(%rcx)
180007a63:     	retq
180007a64:     	int3
180007a65:     	int3
180007a66:     	int3
180007a67:     	int3
180007a68:     	int3
180007a69:     	int3
180007a6a:     	int3
180007a6b:     	int3
180007a6c:     	int3
180007a6d:     	int3
180007a6e:     	int3
180007a6f:     	int3

0000000180007a70 <numba_list_setitem>:
180007a70:     	movq	%rbx, 0x10(%rsp)
180007a75:     	pushq	%rsi
180007a76:     	subq	$0x20, %rsp
180007a7a:     	cmpl	$0x0, 0x18(%rcx)
180007a7e:     	movq	%r8, %rsi
180007a81:     	movq	%rcx, %rbx
180007a84:     	jne	0x180007a96 <numba_list_setitem+0x26>
180007a86:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007a8b:     	movq	0x38(%rsp), %rbx
180007a90:     	addq	$0x20, %rsp
180007a94:     	popq	%rsi
180007a95:     	retq
180007a96:     	cmpq	(%rcx), %rdx
180007a99:     	jb	0x180007aab <numba_list_setitem+0x3b>
180007a9b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007aa0:     	movq	0x38(%rsp), %rbx
180007aa5:     	addq	$0x20, %rsp
180007aa9:     	popq	%rsi
180007aaa:     	retq
180007aab:     	imulq	0x8(%rcx), %rdx
180007ab0:     	movq	0x28(%rcx), %rax
180007ab4:     	movq	%rdi, 0x30(%rsp)
180007ab9:     	movq	0x30(%rcx), %rdi
180007abd:     	addq	%rdx, %rdi
180007ac0:     	testq	%rax, %rax
180007ac3:     	je	0x180007aca <numba_list_setitem+0x5a>
180007ac5:     	movq	%rdi, %rcx
180007ac8:     	callq	*%rax
180007aca:     	movq	0x8(%rbx), %r8
180007ace:     	movq	%rsi, %rdx
180007ad1:     	movq	%rdi, %rcx
180007ad4:     	callq	0x180008e7b <numba_list_iter_next+0xebb>
180007ad9:     	movq	0x20(%rbx), %rax
180007add:     	testq	%rax, %rax
180007ae0:     	je	0x180007ae7 <numba_list_setitem+0x77>
180007ae2:     	movq	%rdi, %rcx
180007ae5:     	callq	*%rax
180007ae7:     	movq	0x30(%rsp), %rdi
180007aec:     	xorl	%eax, %eax
180007aee:     	movq	0x38(%rsp), %rbx
180007af3:     	addq	$0x20, %rsp
180007af7:     	popq	%rsi
180007af8:     	retq
180007af9:     	int3
180007afa:     	int3
180007afb:     	int3
180007afc:     	int3
180007afd:     	int3
180007afe:     	int3
180007aff:     	int3

0000000180007b00 <numba_list_getitem>:
180007b00:     	subq	$0x28, %rsp
180007b04:     	movq	%r8, %r9
180007b07:     	movq	%rdx, %rax
180007b0a:     	cmpq	(%rcx), %rdx
180007b0d:     	jb	0x180007b19 <numba_list_getitem+0x19>
180007b0f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007b14:     	addq	$0x28, %rsp
180007b18:     	retq
180007b19:     	movq	0x8(%rcx), %r8
180007b1d:     	movq	%r8, %rdx
180007b20:     	imulq	%rax, %rdx
180007b24:     	addq	0x30(%rcx), %rdx
180007b28:     	movq	%r9, %rcx
180007b2b:     	callq	0x180008e7b <numba_list_iter_next+0xebb>
180007b30:     	xorl	%eax, %eax
180007b32:     	addq	$0x28, %rsp
180007b36:     	retq
180007b37:     	int3
180007b38:     	int3
180007b39:     	int3
180007b3a:     	int3
180007b3b:     	int3
180007b3c:     	int3
180007b3d:     	int3
180007b3e:     	int3
180007b3f:     	int3

0000000180007b40 <numba_list_append>:
180007b40:     	movq	%rbx, 0x10(%rsp)
180007b45:     	pushq	%rsi
180007b46:     	subq	$0x20, %rsp
180007b4a:     	cmpl	$0x0, 0x18(%rcx)
180007b4e:     	movq	%rdx, %rsi
180007b51:     	movq	%rcx, %rbx
180007b54:     	jne	0x180007b66 <numba_list_append+0x26>
180007b56:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007b5b:     	movq	0x38(%rsp), %rbx
180007b60:     	addq	$0x20, %rsp
180007b64:     	popq	%rsi
180007b65:     	retq
180007b66:     	movq	(%rcx), %rdx
180007b69:     	incq	%rdx
180007b6c:     	callq	0x180007bc0 <numba_list_resize>
180007b71:     	testl	%eax, %eax
180007b73:     	js	0x180007bac <numba_list_append+0x6c>
180007b75:     	movq	0x8(%rbx), %r8
180007b79:     	movq	%rsi, %rdx
180007b7c:     	movq	%rdi, 0x30(%rsp)
180007b81:     	movq	(%rbx), %rdi
180007b84:     	decq	%rdi
180007b87:     	imulq	%r8, %rdi
180007b8b:     	addq	0x30(%rbx), %rdi
180007b8f:     	movq	%rdi, %rcx
180007b92:     	callq	0x180008e7b <numba_list_iter_next+0xebb>
180007b97:     	movq	0x20(%rbx), %rax
180007b9b:     	testq	%rax, %rax
180007b9e:     	je	0x180007ba5 <numba_list_append+0x65>
180007ba0:     	movq	%rdi, %rcx
180007ba3:     	callq	*%rax
180007ba5:     	movq	0x30(%rsp), %rdi
180007baa:     	xorl	%eax, %eax
180007bac:     	movq	0x38(%rsp), %rbx
180007bb1:     	addq	$0x20, %rsp
180007bb5:     	popq	%rsi
180007bb6:     	retq
180007bb7:     	int3
180007bb8:     	int3
180007bb9:     	int3
180007bba:     	int3
180007bbb:     	int3
180007bbc:     	int3
180007bbd:     	int3
180007bbe:     	int3
180007bbf:     	int3

0000000180007bc0 <numba_list_resize>:
180007bc0:     	movq	%rsi, 0x18(%rsp)
180007bc5:     	pushq	%rdi
180007bc6:     	subq	$0x20, %rsp
180007bca:     	cmpl	$0x0, 0x18(%rcx)
180007bce:     	movq	%rdx, %rsi
180007bd1:     	movq	%rcx, %rdi
180007bd4:     	jne	0x180007be6 <numba_list_resize+0x26>
180007bd6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007bdb:     	movq	0x40(%rsp), %rsi
180007be0:     	addq	$0x20, %rsp
180007be4:     	popq	%rdi
180007be5:     	retq
180007be6:     	movq	0x10(%rcx), %rax
180007bea:     	cmpq	%rsi, %rax
180007bed:     	jl	0x180007c07 <numba_list_resize+0x47>
180007bef:     	sarq	%rax
180007bf2:     	cmpq	%rax, %rsi
180007bf5:     	jl	0x180007c07 <numba_list_resize+0x47>
180007bf7:     	movq	%rsi, (%rcx)
180007bfa:     	xorl	%eax, %eax
180007bfc:     	movq	0x40(%rsp), %rsi
180007c01:     	addq	$0x20, %rsp
180007c05:     	popq	%rdi
180007c06:     	retq
180007c07:     	cmpq	$0x9, %rsi
180007c0b:     	movq	%rbp, 0x38(%rsp)
180007c10:     	movl	$0x3, %ecx
180007c15:     	movl	$0x6, %eax
180007c1a:     	cmovll	%ecx, %eax
180007c1d:     	movq	%rsi, %r8
180007c20:     	movq	0x8(%rdi), %rcx
180007c24:     	addq	%rsi, %rax
180007c27:     	sarq	$0x3, %r8
180007c2b:     	xorl	%edx, %edx
180007c2d:     	addq	%rax, %r8
180007c30:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180007c3a:     	divq	%rcx
180007c3d:     	cmpq	%rax, %r8
180007c40:     	ja	0x180007cbb <numba_list_resize+0xfb>
180007c42:     	xorl	%ebp, %ebp
180007c44:     	movq	%rbx, 0x30(%rsp)
180007c49:     	testq	%rsi, %rsi
180007c4c:     	cmovneq	%r8, %rbp
180007c50:     	movq	%rbp, %rbx
180007c53:     	imulq	%rcx, %rbx
180007c57:     	movl	$0x8, %ecx
180007c5c:     	movq	%rbx, %rax
180007c5f:     	cqto
180007c61:     	andl	$0x7, %edx
180007c64:     	addq	%rdx, %rax
180007c67:     	andl	$0x7, %eax
180007c6a:     	subq	%rdx, %rax
180007c6d:     	subq	%rax, %rcx
180007c70:     	movq	%rcx, %rax
180007c73:     	movq	0x30(%rdi), %rcx
180007c77:     	cqto
180007c79:     	andl	$0x7, %edx
180007c7c:     	addq	%rdx, %rax
180007c7f:     	andl	$0x7, %eax
180007c82:     	subq	%rdx, %rax
180007c85:     	leaq	(%rbx,%rax), %rdx
180007c89:     	callq	*0x13d1(%rip)           # 0x180009060
180007c8f:     	testq	%rbx, %rbx
180007c92:     	movq	0x30(%rsp), %rbx
180007c97:     	je	0x180007c9e <numba_list_resize+0xde>
180007c99:     	testq	%rax, %rax
180007c9c:     	je	0x180007cbb <numba_list_resize+0xfb>
180007c9e:     	movq	%rax, 0x30(%rdi)
180007ca2:     	xorl	%eax, %eax
180007ca4:     	movq	%rbp, 0x10(%rdi)
180007ca8:     	movq	0x38(%rsp), %rbp
180007cad:     	movq	%rsi, (%rdi)
180007cb0:     	movq	0x40(%rsp), %rsi
180007cb5:     	addq	$0x20, %rsp
180007cb9:     	popq	%rdi
180007cba:     	retq
180007cbb:     	movq	0x38(%rsp), %rbp
180007cc0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180007cc5:     	movq	0x40(%rsp), %rsi
180007cca:     	addq	$0x20, %rsp
180007cce:     	popq	%rdi
180007ccf:     	retq

0000000180007cd0 <numba_list_delitem>:
180007cd0:     	movq	%rbx, 0x10(%rsp)
180007cd5:     	pushq	%rdi
180007cd6:     	subq	$0x20, %rsp
180007cda:     	cmpl	$0x0, 0x18(%rcx)
180007cde:     	movq	%rdx, %rdi
180007ce1:     	movq	%rcx, %rbx
180007ce4:     	jne	0x180007cf6 <numba_list_delitem+0x26>
180007ce6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007ceb:     	movq	0x38(%rsp), %rbx
180007cf0:     	addq	$0x20, %rsp
180007cf4:     	popq	%rdi
180007cf5:     	retq
180007cf6:     	cmpq	(%rcx), %rdi
180007cf9:     	jb	0x180007d0b <numba_list_delitem+0x3b>
180007cfb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007d00:     	movq	0x38(%rsp), %rbx
180007d05:     	addq	$0x20, %rsp
180007d09:     	popq	%rdi
180007d0a:     	retq
180007d0b:     	movq	0x28(%rcx), %rax
180007d0f:     	movq	%rsi, 0x30(%rsp)
180007d14:     	movq	%rdi, %rsi
180007d17:     	imulq	0x8(%rcx), %rsi
180007d1c:     	addq	0x30(%rcx), %rsi
180007d20:     	testq	%rax, %rax
180007d23:     	je	0x180007d2a <numba_list_delitem+0x5a>
180007d25:     	movq	%rsi, %rcx
180007d28:     	callq	*%rax
180007d2a:     	movq	(%rbx), %r8
180007d2d:     	leaq	-0x1(%r8), %rax
180007d31:     	cmpq	%rax, %rdi
180007d34:     	je	0x180007d56 <numba_list_delitem+0x86>
180007d36:     	subq	%rdi, %r8
180007d39:     	leaq	0x1(%rdi), %rdx
180007d3d:     	imulq	0x8(%rbx), %rdx
180007d42:     	decq	%r8
180007d45:     	movq	%rsi, %rcx
180007d48:     	imulq	0x8(%rbx), %r8
180007d4d:     	addq	0x30(%rbx), %rdx
180007d51:     	callq	0x180008e81 <numba_list_iter_next+0xec1>
180007d56:     	movq	(%rbx), %rdx
180007d59:     	movq	%rbx, %rcx
180007d5c:     	decq	%rdx
180007d5f:     	callq	0x180007bc0 <numba_list_resize>
180007d64:     	movq	0x30(%rsp), %rsi
180007d69:     	xorl	%ecx, %ecx
180007d6b:     	movq	0x38(%rsp), %rbx
180007d70:     	testl	%eax, %eax
180007d72:     	cmovsl	%eax, %ecx
180007d75:     	movl	%ecx, %eax
180007d77:     	addq	$0x20, %rsp
180007d7b:     	popq	%rdi
180007d7c:     	retq
180007d7d:     	int3
180007d7e:     	int3
180007d7f:     	int3

0000000180007d80 <numba_list_delete_slice>:
180007d80:     	pushq	%rbx
180007d82:     	pushq	%rbp
180007d83:     	pushq	%rdi
180007d84:     	pushq	%r15
180007d86:     	subq	$0x38, %rsp
180007d8a:     	cmpl	$0x0, 0x18(%rcx)
180007d8e:     	movq	%r9, %rdi
180007d91:     	movq	%r8, %rbp
180007d94:     	movq	%rdx, %r15
180007d97:     	movq	%rcx, %rbx
180007d9a:     	jne	0x180007dab <numba_list_delete_slice+0x2b>
180007d9c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007da1:     	addq	$0x38, %rsp
180007da5:     	popq	%r15
180007da7:     	popq	%rdi
180007da8:     	popq	%rbp
180007da9:     	popq	%rbx
180007daa:     	retq
180007dab:     	movq	%r13, 0x78(%rsp)
180007db0:     	testq	%rdi, %rdi
180007db3:     	jle	0x180007dd2 <numba_list_delete_slice+0x52>
180007db5:     	cmpq	%r8, %r15
180007db8:     	jge	0x180007f71 <numba_list_delete_slice+0x1f1>
180007dbe:     	movq	%r8, %rax
180007dc1:     	subq	%r15, %rax
180007dc4:     	decq	%rax
180007dc7:     	cqto
180007dc9:     	idivq	%rdi
180007dcc:     	leal	0x1(%rax), %r13d
180007dd0:     	jmp	0x180007df2 <numba_list_delete_slice+0x72>
180007dd2:     	cmpq	%r15, %r8
180007dd5:     	jge	0x180007f71 <numba_list_delete_slice+0x1f1>
180007ddb:     	movq	%r15, %rax
180007dde:     	movl	$0x1, %r13d
180007de4:     	subq	%r8, %rax
180007de7:     	decq	%rax
180007dea:     	cqto
180007dec:     	idivq	%rdi
180007def:     	subl	%eax, %r13d
180007df2:     	testl	%r13d, %r13d
180007df5:     	jle	0x180007f71 <numba_list_delete_slice+0x1f1>
180007dfb:     	movq	%rsi, 0x68(%rsp)
180007e00:     	movl	(%rcx), %esi
180007e02:     	subl	%r13d, %esi
180007e05:     	movl	%esi, 0x20(%rsp)
180007e09:     	testq	%rdi, %rdi
180007e0c:     	jns	0x180007e27 <numba_list_delete_slice+0xa7>
180007e0e:     	leaq	0x1(%r15), %rbp
180007e12:     	leal	-0x1(%r13), %eax
180007e16:     	movslq	%eax, %rcx
180007e19:     	leaq	-0x1(%rbp), %r15
180007e1d:     	imulq	%rdi, %rcx
180007e21:     	addq	%rcx, %r15
180007e24:     	negq	%rdi
180007e27:     	cmpq	$0x1, %rdi
180007e2b:     	jne	0x180007e77 <numba_list_delete_slice+0xf7>
180007e2d:     	cmpq	$0x0, 0x28(%rbx)
180007e32:     	je	0x180007e59 <numba_list_delete_slice+0xd9>
180007e34:     	movslq	%r15d, %rdi
180007e37:     	cmpq	%rbp, %rdi
180007e3a:     	jge	0x180007e59 <numba_list_delete_slice+0xd9>
180007e3c:     	nopl	(%rax)
180007e40:     	movslq	%edi, %rcx
180007e43:     	imulq	0x8(%rbx), %rcx
180007e48:     	addq	0x30(%rbx), %rcx
180007e4c:     	callq	*0x28(%rbx)
180007e4f:     	incl	%edi
180007e51:     	movslq	%edi, %rax
180007e54:     	cmpq	%rbp, %rax
180007e57:     	jl	0x180007e40 <numba_list_delete_slice+0xc0>
180007e59:     	movq	0x8(%rbx), %rcx
180007e5d:     	movq	(%rbx), %r8
180007e60:     	movq	%rcx, %rdx
180007e63:     	subq	%rbp, %r8
180007e66:     	imulq	%rcx, %r8
180007e6a:     	imulq	%rbp, %rdx
180007e6e:     	imulq	%r15, %rcx
180007e72:     	jmp	0x180007f3c <numba_list_delete_slice+0x1bc>
180007e77:     	movq	%r14, 0x30(%rsp)
180007e7c:     	movq	%r15, %r14
180007e7f:     	movl	$0x0, 0x60(%rsp)
180007e87:     	cmpq	%rbp, %r15
180007e8a:     	jge	0x180007f09 <numba_list_delete_slice+0x189>
180007e8c:     	movq	%r12, 0x70(%rsp)
180007e91:     	movq	(%rbx), %rax
180007e94:     	leaq	(%r14,%rdi), %r12
180007e98:     	cmpq	%rax, %r12
180007e9b:     	jl	0x180007ea8 <numba_list_delete_slice+0x128>
180007e9d:     	movq	%r14, %rsi
180007ea0:     	notq	%rsi
180007ea3:     	addq	%rax, %rsi
180007ea6:     	jmp	0x180007eac <numba_list_delete_slice+0x12c>
180007ea8:     	leaq	-0x1(%rdi), %rsi
180007eac:     	movq	0x28(%rbx), %rax
180007eb0:     	testq	%rax, %rax
180007eb3:     	je	0x180007ec3 <numba_list_delete_slice+0x143>
180007eb5:     	movq	%r14, %rcx
180007eb8:     	imulq	0x8(%rbx), %rcx
180007ebd:     	addq	0x30(%rbx), %rcx
180007ec1:     	callq	*%rax
180007ec3:     	movq	0x8(%rbx), %r9
180007ec7:     	leaq	0x1(%r14), %rdx
180007ecb:     	movq	0x30(%rbx), %r10
180007ecf:     	movq	%r9, %r8
180007ed2:     	imulq	%rsi, %r8
180007ed6:     	imulq	%r9, %rdx
180007eda:     	movslq	0x60(%rsp), %rsi
180007edf:     	subq	%rsi, %r14
180007ee2:     	imulq	%r9, %r14
180007ee6:     	addq	%r10, %rdx
180007ee9:     	leaq	(%r10,%r14), %rcx
180007eed:     	callq	0x180008e81 <numba_list_iter_next+0xec1>
180007ef2:     	incl	%esi
180007ef4:     	movq	%r12, %r14
180007ef7:     	movl	%esi, 0x60(%rsp)
180007efb:     	cmpq	%rbp, %r12
180007efe:     	jl	0x180007e91 <numba_list_delete_slice+0x111>
180007f00:     	movq	0x70(%rsp), %r12
180007f05:     	movl	0x20(%rsp), %esi
180007f09:     	movq	(%rbx), %r8
180007f0c:     	movq	0x30(%rsp), %r14
180007f11:     	movslq	%r13d, %r10
180007f14:     	movq	%r10, %rcx
180007f17:     	imulq	%rdi, %rcx
180007f1b:     	addq	%r15, %rcx
180007f1e:     	cmpq	%r8, %rcx
180007f21:     	jge	0x180007f49 <numba_list_delete_slice+0x1c9>
180007f23:     	movq	0x8(%rbx), %rax
180007f27:     	subq	%rcx, %r8
180007f2a:     	movq	%rax, %rdx
180007f2d:     	imulq	%rcx, %rdx
180007f31:     	imulq	%rax, %r8
180007f35:     	subq	%r10, %rcx
180007f38:     	imulq	%rax, %rcx
180007f3c:     	addq	0x30(%rbx), %rdx
180007f40:     	addq	0x30(%rbx), %rcx
180007f44:     	callq	0x180008e81 <numba_list_iter_next+0xec1>
180007f49:     	movslq	%esi, %rdx
180007f4c:     	movq	%rbx, %rcx
180007f4f:     	callq	0x180007bc0 <numba_list_resize>
180007f54:     	movq	0x68(%rsp), %rsi
180007f59:     	xorl	%ecx, %ecx
180007f5b:     	movq	0x78(%rsp), %r13
180007f60:     	testl	%eax, %eax
180007f62:     	cmovsl	%eax, %ecx
180007f65:     	movl	%ecx, %eax
180007f67:     	addq	$0x38, %rsp
180007f6b:     	popq	%r15
180007f6d:     	popq	%rdi
180007f6e:     	popq	%rbp
180007f6f:     	popq	%rbx
180007f70:     	retq
180007f71:     	movq	0x78(%rsp), %r13
180007f76:     	xorl	%eax, %eax
180007f78:     	addq	$0x38, %rsp
180007f7c:     	popq	%r15
180007f7e:     	popq	%rdi
180007f7f:     	popq	%rbp
180007f80:     	popq	%rbx
180007f81:     	retq
180007f82:     	int3
180007f83:     	int3
180007f84:     	int3
180007f85:     	int3
180007f86:     	int3
180007f87:     	int3
180007f88:     	int3
180007f89:     	int3
180007f8a:     	int3
180007f8b:     	int3
180007f8c:     	int3
180007f8d:     	int3
180007f8e:     	int3
180007f8f:     	int3

0000000180007f90 <numba_list_iter_sizeof>:
180007f90:     	movl	$0x18, %eax
180007f95:     	retq
180007f96:     	int3
180007f97:     	int3
180007f98:     	int3
180007f99:     	int3
180007f9a:     	int3
180007f9b:     	int3
180007f9c:     	int3
180007f9d:     	int3
180007f9e:     	int3
180007f9f:     	int3

0000000180007fa0 <numba_list_iter>:
180007fa0:     	movq	%rdx, (%rcx)
180007fa3:     	movq	(%rdx), %rax
180007fa6:     	movq	%rax, 0x8(%rcx)
180007faa:     	movq	$0x0, 0x10(%rcx)
180007fb2:     	retq
180007fb3:     	int3
180007fb4:     	int3
180007fb5:     	int3
180007fb6:     	int3
180007fb7:     	int3
180007fb8:     	int3
180007fb9:     	int3
180007fba:     	int3
180007fbb:     	int3
180007fbc:     	int3
180007fbd:     	int3
180007fbe:     	int3
180007fbf:     	int3

0000000180007fc0 <numba_list_iter_next>:
180007fc0:     	movq	(%rcx), %r8
180007fc3:     	movq	(%r8), %r9
180007fc6:     	cmpq	0x8(%rcx), %r9
180007fca:     	je	0x180007fd2 <numba_list_iter_next+0x12>
180007fcc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180007fd1:     	retq
180007fd2:     	movq	0x10(%rcx), %rax
180007fd6:     	cmpq	%r9, %rax
180007fd9:     	jge	0x180007fee <numba_list_iter_next+0x2e>
180007fdb:     	imulq	0x8(%r8), %rax
180007fe0:     	addq	0x30(%r8), %rax
180007fe4:     	movq	%rax, (%rdx)
180007fe7:     	incq	0x10(%rcx)
180007feb:     	xorl	%eax, %eax
180007fed:     	retq
180007fee:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180007ff3:     	retq
180007ff4:     	int3
180007ff5:     	int3
180007ff6:     	int3
180007ff7:     	int3
180007ff8:     	int3
180007ff9:     	int3
180007ffa:     	int3
180007ffb:     	int3
180007ffc:     	int3
180007ffd:     	int3
180007ffe:     	int3
180007fff:     	int3
180008000:     	pushq	%rbx
180008002:     	subq	$0x20, %rsp
180008006:     	movq	%rcx, %rbx
180008009:     	addq	$0x30, %rcx
18000800d:     	callq	*0x8c15(%rip)           # 0x180010c28
180008013:     	cmpb	$0x0, 0x8be6(%rip)      # 0x180010c00
18000801a:     	je	0x180008024 <numba_list_iter_next+0x64>
18000801c:     	lock
18000801d:     	incq	0x8be4(%rip)            # 0x180010c08
180008024:     	testq	%rax, %rax
180008027:     	je	0x180008068 <numba_list_iter_next+0xa8>
180008029:     	leaq	0x30(%rax), %rdx
18000802d:     	testq	%rdx, %rdx
180008030:     	je	0x180008068 <numba_list_iter_next+0xa8>
180008032:     	xorl	%r8d, %r8d
180008035:     	movl	$0x1, %ecx
18000803a:     	xchgq	%rcx, (%rax)
18000803d:     	movq	%r8, 0x8(%rax)
180008041:     	movq	%r8, 0x10(%rax)
180008045:     	movq	%rdx, 0x18(%rax)
180008049:     	movq	%rbx, 0x20(%rax)
18000804d:     	movq	%r8, 0x28(%rax)
180008051:     	cmpb	%r8b, 0x8ba8(%rip)      # 0x180010c00
180008058:     	je	0x18000806a <numba_list_iter_next+0xaa>
18000805a:     	lock
18000805b:     	incq	0x8bb6(%rip)            # 0x180010c18
180008062:     	addq	$0x20, %rsp
180008066:     	popq	%rbx
180008067:     	retq
180008068:     	xorl	%eax, %eax
18000806a:     	addq	$0x20, %rsp
18000806e:     	popq	%rbx
18000806f:     	retq
180008070:     	movq	%rbx, 0x8(%rsp)
180008075:     	pushq	%rdi
180008076:     	subq	$0x20, %rsp
18000807a:     	movq	%rcx, %rdi
18000807d:     	movq	%rdx, %rbx
180008080:     	addq	$0x30, %rcx
180008084:     	testq	%rdx, %rdx
180008087:     	je	0x180008091 <numba_list_iter_next+0xd1>
180008089:     	movq	0x18(%rdx), %rdx
18000808d:     	callq	*(%rbx)
18000808f:     	jmp	0x180008097 <numba_list_iter_next+0xd7>
180008091:     	callq	*0x8b91(%rip)           # 0x180010c28
180008097:     	cmpb	$0x0, 0x8b62(%rip)      # 0x180010c00
18000809e:     	movq	%rax, %r8
1800080a1:     	je	0x1800080ab <numba_list_iter_next+0xeb>
1800080a3:     	lock
1800080a4:     	incq	0x8b5d(%rip)            # 0x180010c08
1800080ab:     	xorl	%edx, %edx
1800080ad:     	leaq	0x30(%r8), %rax
1800080b1:     	testq	%r8, %r8
1800080b4:     	movl	%edx, %ecx
1800080b6:     	cmovneq	%rax, %rcx
1800080ba:     	testq	%rcx, %rcx
1800080bd:     	jne	0x1800080cc <numba_list_iter_next+0x10c>
1800080bf:     	xorl	%eax, %eax
1800080c1:     	movq	0x30(%rsp), %rbx
1800080c6:     	addq	$0x20, %rsp
1800080ca:     	popq	%rdi
1800080cb:     	retq
1800080cc:     	movl	$0x1, %eax
1800080d1:     	xchgq	%rax, (%r8)
1800080d4:     	movq	%rdx, 0x8(%r8)
1800080d8:     	movq	%rdx, 0x10(%r8)
1800080dc:     	movq	%rcx, 0x18(%r8)
1800080e0:     	movq	%rdi, 0x20(%r8)
1800080e4:     	movq	%rbx, 0x28(%r8)
1800080e8:     	cmpb	%dl, 0x8b12(%rip)       # 0x180010c00
1800080ee:     	je	0x1800080f8 <numba_list_iter_next+0x138>
1800080f0:     	lock
1800080f1:     	incq	0x8b20(%rip)            # 0x180010c18
1800080f8:     	movq	0x30(%rsp), %rbx
1800080fd:     	movq	%r8, %rax
180008100:     	addq	$0x20, %rsp
180008104:     	popq	%rdi
180008105:     	retq
180008106:     	int3
180008107:     	int3
180008108:     	int3
180008109:     	int3
18000810a:     	int3
18000810b:     	int3
18000810c:     	int3
18000810d:     	int3
18000810e:     	int3
18000810f:     	int3
180008110:     	lock
180008111:     	incq	(%rcx)
180008114:     	retq
180008115:     	int3
180008116:     	int3
180008117:     	int3
180008118:     	int3
180008119:     	int3
18000811a:     	int3
18000811b:     	int3
18000811c:     	int3
18000811d:     	int3
18000811e:     	int3
18000811f:     	int3
180008120:     	pushq	%rbx
180008122:     	subq	$0x20, %rsp
180008126:     	movq	0x8(%rcx), %rax
18000812a:     	movq	%rcx, %rbx
18000812d:     	testq	%rax, %rax
180008130:     	je	0x180008149 <numba_list_iter_next+0x189>
180008132:     	cmpl	$0x0, 0x8abf(%rip)      # 0x180010bf8
180008139:     	jne	0x180008149 <numba_list_iter_next+0x189>
18000813b:     	movq	0x10(%rcx), %r8
18000813f:     	movq	0x20(%rcx), %rdx
180008143:     	movq	0x18(%rcx), %rcx
180008147:     	callq	*%rax
180008149:     	movq	0x28(%rbx), %rax
18000814d:     	movq	%rbx, %rcx
180008150:     	testq	%rax, %rax
180008153:     	je	0x18000815e <numba_list_iter_next+0x19e>
180008155:     	movq	0x18(%rax), %rdx
180008159:     	callq	*0x10(%rax)
18000815c:     	jmp	0x180008164 <numba_list_iter_next+0x1a4>
18000815e:     	callq	*0x8ad4(%rip)           # 0x180010c38
180008164:     	cmpb	$0x0, 0x8a95(%rip)      # 0x180010c00
18000816b:     	je	0x180008189 <numba_list_iter_next+0x1c9>
18000816d:     	leaq	0x8a9c(%rip), %rax      # 0x180010c10
180008174:     	lock
180008175:     	incq	(%rax)
180008178:     	cmpb	$0x0, 0x8a81(%rip)      # 0x180010c00
18000817f:     	je	0x180008189 <numba_list_iter_next+0x1c9>
180008181:     	lock
180008182:     	incq	0x8a97(%rip)            # 0x180010c20
180008189:     	addq	$0x20, %rsp
18000818d:     	popq	%rbx
18000818e:     	retq
18000818f:     	int3
180008190:     	pushq	%rbx
180008192:     	subq	$0x20, %rsp
180008196:     	movq	%rcx, %rbx
180008199:     	movq	$-0x1, %rax
1800081a0:     	lock
1800081a1:     	xaddq	%rax, (%rcx)
1800081a5:     	cmpq	$0x1, %rax
1800081a9:     	jne	0x18000820b <numba_list_iter_next+0x24b>
1800081ab:     	movq	0x8(%rcx), %rax
1800081af:     	testq	%rax, %rax
1800081b2:     	je	0x1800081cb <numba_list_iter_next+0x20b>
1800081b4:     	cmpl	$0x0, 0x8a3d(%rip)      # 0x180010bf8
1800081bb:     	jne	0x1800081cb <numba_list_iter_next+0x20b>
1800081bd:     	movq	0x10(%rcx), %r8
1800081c1:     	movq	0x20(%rcx), %rdx
1800081c5:     	movq	0x18(%rcx), %rcx
1800081c9:     	callq	*%rax
1800081cb:     	movq	0x28(%rbx), %rax
1800081cf:     	movq	%rbx, %rcx
1800081d2:     	testq	%rax, %rax
1800081d5:     	je	0x1800081e0 <numba_list_iter_next+0x220>
1800081d7:     	movq	0x18(%rax), %rdx
1800081db:     	callq	*0x10(%rax)
1800081de:     	jmp	0x1800081e6 <numba_list_iter_next+0x226>
1800081e0:     	callq	*0x8a52(%rip)           # 0x180010c38
1800081e6:     	cmpb	$0x0, 0x8a13(%rip)      # 0x180010c00
1800081ed:     	je	0x18000820b <numba_list_iter_next+0x24b>
1800081ef:     	leaq	0x8a1a(%rip), %rax      # 0x180010c10
1800081f6:     	lock
1800081f7:     	incq	(%rax)
1800081fa:     	cmpb	$0x0, 0x89ff(%rip)      # 0x180010c00
180008201:     	je	0x18000820b <numba_list_iter_next+0x24b>
180008203:     	lock
180008204:     	incq	0x8a15(%rip)            # 0x180010c20
18000820b:     	addq	$0x20, %rsp
18000820f:     	popq	%rbx
180008210:     	retq
180008211:     	int3
180008212:     	int3
180008213:     	int3
180008214:     	int3
180008215:     	int3
180008216:     	int3
180008217:     	int3
180008218:     	int3
180008219:     	int3
18000821a:     	int3
18000821b:     	int3
18000821c:     	int3
18000821d:     	int3
18000821e:     	int3
18000821f:     	int3
180008220:     	movq	0x18(%rcx), %rax
180008224:     	retq
180008225:     	int3
180008226:     	int3
180008227:     	int3
180008228:     	int3
180008229:     	int3
18000822a:     	int3
18000822b:     	int3
18000822c:     	int3
18000822d:     	int3
18000822e:     	int3
18000822f:     	int3
180008230:     	subq	$0x28, %rsp
180008234:     	callq	*0x89fe(%rip)           # 0x180010c38
18000823a:     	cmpb	$0x0, 0x89bf(%rip)      # 0x180010c00
180008241:     	je	0x18000824b <numba_list_iter_next+0x28b>
180008243:     	lock
180008244:     	incq	0x89c5(%rip)            # 0x180010c10
18000824b:     	addq	$0x28, %rsp
18000824f:     	retq
180008250:     	jmpq	*%r8
180008253:     	int3
180008254:     	int3
180008255:     	int3
180008256:     	int3
180008257:     	int3
180008258:     	int3
180008259:     	int3
18000825a:     	int3
18000825b:     	int3
18000825c:     	int3
18000825d:     	int3
18000825e:     	int3
18000825f:     	int3
180008260:     	movq	%rbx, 0x8(%rsp)
180008265:     	pushq	%rdi
180008266:     	subq	$0x20, %rsp
18000826a:     	movq	%rcx, %rdi
18000826d:     	movq	%rdx, %rbx
180008270:     	movl	$0x30, %ecx
180008275:     	callq	*0x89ad(%rip)           # 0x180010c28
18000827b:     	cmpb	$0x0, 0x897e(%rip)      # 0x180010c00
180008282:     	je	0x18000828c <numba_list_iter_next+0x2cc>
180008284:     	lock
180008285:     	incq	0x897c(%rip)            # 0x180010c08
18000828c:     	testq	%rax, %rax
18000828f:     	je	0x1800082c6 <numba_list_iter_next+0x306>
180008291:     	leaq	-0x48(%rip), %rcx       # 0x180008250 <numba_list_iter_next+0x290>
180008298:     	movl	$0x1, %edx
18000829d:     	xchgq	%rdx, (%rax)
1800082a0:     	movq	%rcx, 0x8(%rax)
1800082a4:     	xorl	%ecx, %ecx
1800082a6:     	movq	%rcx, 0x20(%rax)
1800082aa:     	movq	%rcx, 0x28(%rax)
1800082ae:     	movq	%rbx, 0x10(%rax)
1800082b2:     	movq	%rdi, 0x18(%rax)
1800082b6:     	cmpb	%cl, 0x8944(%rip)       # 0x180010c00
1800082bc:     	je	0x1800082c6 <numba_list_iter_next+0x306>
1800082be:     	lock
1800082bf:     	incq	0x8952(%rip)            # 0x180010c18
1800082c6:     	movq	0x30(%rsp), %rbx
1800082cb:     	addq	$0x20, %rsp
1800082cf:     	popq	%rdi
1800082d0:     	retq
1800082d1:     	jmpq	*0x1039(%rip)           # 0x180009310
1800082d7:     	jmpq	*0x1023(%rip)           # 0x180009300
1800082dd:     	jmpq	*0x1015(%rip)           # 0x1800092f8
1800082e3:     	jmpq	*0x1007(%rip)           # 0x1800092f0
1800082e9:     	jmpq	*0xff9(%rip)            # 0x1800092e8
1800082ef:     	jmpq	*0xfe3(%rip)            # 0x1800092d8
1800082f5:     	jmpq	*0xfd5(%rip)            # 0x1800092d0
1800082fb:     	jmpq	*0xfc7(%rip)            # 0x1800092c8
180008301:     	jmpq	*0xfb1(%rip)            # 0x1800092b8
180008307:     	jmpq	*0xf8b(%rip)            # 0x180009298
18000830d:     	jmpq	*0xf7d(%rip)            # 0x180009290
180008313:     	jmpq	*0xf6f(%rip)            # 0x180009288
180008319:     	jmpq	*0xf61(%rip)            # 0x180009280
18000831f:     	jmpq	*0xf1b(%rip)            # 0x180009240
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
180008330:     	int3
180008331:     	int3
180008332:     	int3
180008333:     	int3
180008334:     	int3
180008335:     	int3
180008336:     	nopw	(%rax,%rax)
180008340:     	cmpq	0x7d79(%rip), %rcx      # 0x1800100c0
180008347:     	jne	0x180008359 <numba_list_iter_next+0x399>
180008349:     	rolq	$0x10, %rcx
18000834d:     	testw	$0xffff, %cx            # imm = 0xFFFF
180008352:     	jne	0x180008355 <numba_list_iter_next+0x395>
180008354:     	retq
180008355:     	rorq	$0x10, %rcx
180008359:     	jmp	0x1800086b4 <numba_list_iter_next+0x6f4>
18000835e:     	int3
18000835f:     	int3
180008360:     	subq	$0x28, %rsp
180008364:     	testl	%edx, %edx
180008366:     	je	0x1800083a1 <numba_list_iter_next+0x3e1>
180008368:     	subl	$0x1, %edx
18000836b:     	je	0x180008395 <numba_list_iter_next+0x3d5>
18000836d:     	subl	$0x1, %edx
180008370:     	je	0x180008388 <numba_list_iter_next+0x3c8>
180008372:     	cmpl	$0x1, %edx
180008375:     	je	0x180008381 <numba_list_iter_next+0x3c1>
180008377:     	movl	$0x1, %eax
18000837c:     	addq	$0x28, %rsp
180008380:     	retq
180008381:     	callq	0x180008880 <numba_list_iter_next+0x8c0>
180008386:     	jmp	0x18000838d <numba_list_iter_next+0x3cd>
180008388:     	callq	0x180008858 <numba_list_iter_next+0x898>
18000838d:     	movzbl	%al, %eax
180008390:     	addq	$0x28, %rsp
180008394:     	retq
180008395:     	movq	%r8, %rdx
180008398:     	addq	$0x28, %rsp
18000839c:     	jmp	0x1800083b0 <numba_list_iter_next+0x3f0>
1800083a1:     	testq	%r8, %r8
1800083a4:     	setne	%cl
1800083a7:     	addq	$0x28, %rsp
1800083ab:     	jmp	0x1800084c8 <numba_list_iter_next+0x508>
1800083b0:     	movq	%rbx, 0x8(%rsp)
1800083b5:     	movq	%rsi, 0x10(%rsp)
1800083ba:     	movq	%rdi, 0x20(%rsp)
1800083bf:     	pushq	%r14
1800083c1:     	subq	$0x20, %rsp
1800083c5:     	movq	%rdx, %rsi
1800083c8:     	movq	%rcx, %r14
1800083cb:     	xorl	%ecx, %ecx
1800083cd:     	callq	0x18000893c <numba_list_iter_next+0x97c>
1800083d2:     	testb	%al, %al
1800083d4:     	je	0x1800084a2 <numba_list_iter_next+0x4e2>
1800083da:     	callq	0x1800087d0 <numba_list_iter_next+0x810>
1800083df:     	movb	%al, %bl
1800083e1:     	movb	%al, 0x40(%rsp)
1800083e5:     	movb	$0x1, %dil
1800083e8:     	cmpl	$0x0, 0x85d9(%rip)      # 0x1800109c8
1800083ef:     	jne	0x1800084ba <numba_list_iter_next+0x4fa>
1800083f5:     	movl	$0x1, 0x85c9(%rip)      # 0x1800109c8
1800083ff:     	callq	0x180008840 <numba_list_iter_next+0x880>
180008404:     	testb	%al, %al
180008406:     	je	0x180008457 <numba_list_iter_next+0x497>
180008408:     	callq	0x180008afc <numba_list_iter_next+0xb3c>
18000840d:     	callq	0x180008790 <numba_list_iter_next+0x7d0>
180008412:     	callq	0x1800087b4 <numba_list_iter_next+0x7f4>
180008417:     	leaq	0xf52(%rip), %rdx       # 0x180009370
18000841e:     	leaq	0xf43(%rip), %rcx       # 0x180009368
180008425:     	callq	0x180008e48 <numba_list_iter_next+0xe88>
18000842a:     	testl	%eax, %eax
18000842c:     	jne	0x180008457 <numba_list_iter_next+0x497>
18000842e:     	callq	0x18000880c <numba_list_iter_next+0x84c>
180008433:     	testb	%al, %al
180008435:     	je	0x180008457 <numba_list_iter_next+0x497>
180008437:     	leaq	0xf22(%rip), %rdx       # 0x180009360
18000843e:     	leaq	0xf13(%rip), %rcx       # 0x180009358
180008445:     	callq	0x180008e42 <numba_list_iter_next+0xe82>
18000844a:     	movl	$0x2, 0x8574(%rip)      # 0x1800109c8
180008454:     	xorb	%dil, %dil
180008457:     	movb	%bl, %cl
180008459:     	callq	0x180008a9c <numba_list_iter_next+0xadc>
18000845e:     	testb	%dil, %dil
180008461:     	jne	0x1800084a2 <numba_list_iter_next+0x4e2>
180008463:     	callq	0x180008aec <numba_list_iter_next+0xb2c>
180008468:     	movq	%rax, %rbx
18000846b:     	cmpq	$0x0, (%rax)
18000846f:     	je	0x180008495 <numba_list_iter_next+0x4d5>
180008471:     	movq	%rax, %rcx
180008474:     	callq	0x180008a04 <numba_list_iter_next+0xa44>
180008479:     	testb	%al, %al
18000847b:     	je	0x180008495 <numba_list_iter_next+0x4d5>
18000847d:     	movq	%rsi, %r8
180008480:     	movl	$0x2, %edx
180008485:     	movq	%r14, %rcx
180008488:     	movq	(%rbx), %rax
18000848b:     	movq	0xe9e(%rip), %r9        # 0x180009330
180008492:     	callq	*%r9
180008495:     	incl	0x8505(%rip)            # 0x1800109a0
18000849b:     	movl	$0x1, %eax
1800084a0:     	jmp	0x1800084a4 <numba_list_iter_next+0x4e4>
1800084a2:     	xorl	%eax, %eax
1800084a4:     	movq	0x30(%rsp), %rbx
1800084a9:     	movq	0x38(%rsp), %rsi
1800084ae:     	movq	0x48(%rsp), %rdi
1800084b3:     	addq	$0x20, %rsp
1800084b7:     	popq	%r14
1800084b9:     	retq
1800084ba:     	movl	$0x7, %ecx
1800084bf:     	callq	0x180008af4 <numba_list_iter_next+0xb34>
1800084c4:     	nop
1800084c5:     	int3
1800084c6:     	int3
1800084c7:     	int3
1800084c8:     	movq	%rbx, 0x8(%rsp)
1800084cd:     	pushq	%rdi
1800084ce:     	subq	$0x30, %rsp
1800084d2:     	movb	%cl, %dil
1800084d5:     	movl	0x84c5(%rip), %eax      # 0x1800109a0
1800084db:     	testl	%eax, %eax
1800084dd:     	jg	0x1800084ec <numba_list_iter_next+0x52c>
1800084df:     	xorl	%eax, %eax
1800084e1:     	movq	0x40(%rsp), %rbx
1800084e6:     	addq	$0x30, %rsp
1800084ea:     	popq	%rdi
1800084eb:     	retq
1800084ec:     	decl	%eax
1800084ee:     	movl	%eax, 0x84ac(%rip)      # 0x1800109a0
1800084f4:     	callq	0x1800087d0 <numba_list_iter_next+0x810>
1800084f9:     	movb	%al, %bl
1800084fb:     	movb	%al, 0x20(%rsp)
1800084ff:     	cmpl	$0x2, 0x84c2(%rip)      # 0x1800109c8
180008506:     	jne	0x18000853e <numba_list_iter_next+0x57e>
180008508:     	callq	0x1800088f8 <numba_list_iter_next+0x938>
18000850d:     	callq	0x1800087a0 <numba_list_iter_next+0x7e0>
180008512:     	callq	0x180008b38 <numba_list_iter_next+0xb78>
180008517:     	movl	$0x0, 0x84a7(%rip)      # 0x1800109c8
180008521:     	movb	%bl, %cl
180008523:     	callq	0x180008a9c <numba_list_iter_next+0xadc>
180008528:     	xorl	%edx, %edx
18000852a:     	movb	%dil, %cl
18000852d:     	callq	0x180008ac0 <numba_list_iter_next+0xb00>
180008532:     	movzbl	%al, %ebx
180008535:     	callq	0x180008928 <numba_list_iter_next+0x968>
18000853a:     	movl	%ebx, %eax
18000853c:     	jmp	0x1800084e1 <numba_list_iter_next+0x521>
18000853e:     	movl	$0x7, %ecx
180008543:     	callq	0x180008af4 <numba_list_iter_next+0xb34>
180008548:     	nop
180008549:     	nop
18000854a:     	int3
18000854b:     	int3
18000854c:     	movq	%rsp, %rax
18000854f:     	movq	%rbx, 0x20(%rax)
180008553:     	movq	%r8, 0x18(%rax)
180008557:     	movl	%edx, 0x10(%rax)
18000855a:     	movq	%rcx, 0x8(%rax)
18000855e:     	pushq	%rsi
18000855f:     	pushq	%rdi
180008560:     	pushq	%r14
180008562:     	subq	$0x40, %rsp
180008566:     	movq	%r8, %rsi
180008569:     	movl	%edx, %edi
18000856b:     	movq	%rcx, %r14
18000856e:     	testl	%edx, %edx
180008570:     	jne	0x180008581 <numba_list_iter_next+0x5c1>
180008572:     	cmpl	%edx, 0x8428(%rip)      # 0x1800109a0
180008578:     	jg	0x180008581 <numba_list_iter_next+0x5c1>
18000857a:     	xorl	%eax, %eax
18000857c:     	jmp	0x180008666 <numba_list_iter_next+0x6a6>
180008581:     	leal	-0x1(%rdx), %eax
180008584:     	cmpl	$0x1, %eax
180008587:     	ja	0x1800085c9 <numba_list_iter_next+0x609>
180008589:     	movq	0x13f8(%rip), %rax      # 0x180009988
180008590:     	testq	%rax, %rax
180008593:     	jne	0x18000859a <numba_list_iter_next+0x5da>
180008595:     	leal	0x1(%rax), %ebx
180008598:     	jmp	0x1800085a2 <numba_list_iter_next+0x5e2>
18000859a:     	callq	*0xd90(%rip)            # 0x180009330
1800085a0:     	movl	%eax, %ebx
1800085a2:     	movl	%ebx, 0x30(%rsp)
1800085a6:     	testl	%ebx, %ebx
1800085a8:     	je	0x18000865c <numba_list_iter_next+0x69c>
1800085ae:     	movq	%rsi, %r8
1800085b1:     	movl	%edi, %edx
1800085b3:     	movq	%r14, %rcx
1800085b6:     	callq	0x180008360 <numba_list_iter_next+0x3a0>
1800085bb:     	movl	%eax, %ebx
1800085bd:     	movl	%eax, 0x30(%rsp)
1800085c1:     	testl	%eax, %eax
1800085c3:     	je	0x18000865c <numba_list_iter_next+0x69c>
1800085c9:     	movq	%rsi, %r8
1800085cc:     	movl	%edi, %edx
1800085ce:     	movq	%r14, %rcx
1800085d1:     	callq	0x18000876c <numba_list_iter_next+0x7ac>
1800085d6:     	movl	%eax, %ebx
1800085d8:     	movl	%eax, 0x30(%rsp)
1800085dc:     	cmpl	$0x1, %edi
1800085df:     	jne	0x180008617 <numba_list_iter_next+0x657>
1800085e1:     	testl	%eax, %eax
1800085e3:     	jne	0x180008617 <numba_list_iter_next+0x657>
1800085e5:     	movq	%rsi, %r8
1800085e8:     	xorl	%edx, %edx
1800085ea:     	movq	%r14, %rcx
1800085ed:     	callq	0x18000876c <numba_list_iter_next+0x7ac>
1800085f2:     	testq	%rsi, %rsi
1800085f5:     	setne	%cl
1800085f8:     	callq	0x1800084c8 <numba_list_iter_next+0x508>
1800085fd:     	movq	0x1384(%rip), %rax      # 0x180009988
180008604:     	testq	%rax, %rax
180008607:     	je	0x180008617 <numba_list_iter_next+0x657>
180008609:     	movq	%rsi, %r8
18000860c:     	xorl	%edx, %edx
18000860e:     	movq	%r14, %rcx
180008611:     	callq	*0xd19(%rip)            # 0x180009330
180008617:     	testl	%edi, %edi
180008619:     	je	0x180008620 <numba_list_iter_next+0x660>
18000861b:     	cmpl	$0x3, %edi
18000861e:     	jne	0x18000865c <numba_list_iter_next+0x69c>
180008620:     	movq	%rsi, %r8
180008623:     	movl	%edi, %edx
180008625:     	movq	%r14, %rcx
180008628:     	callq	0x180008360 <numba_list_iter_next+0x3a0>
18000862d:     	movl	%eax, %ebx
18000862f:     	movl	%eax, 0x30(%rsp)
180008633:     	testl	%eax, %eax
180008635:     	je	0x18000865c <numba_list_iter_next+0x69c>
180008637:     	movq	0x134a(%rip), %rax      # 0x180009988
18000863e:     	testq	%rax, %rax
180008641:     	jne	0x180008648 <numba_list_iter_next+0x688>
180008643:     	leal	0x1(%rax), %ebx
180008646:     	jmp	0x180008658 <numba_list_iter_next+0x698>
180008648:     	movq	%rsi, %r8
18000864b:     	movl	%edi, %edx
18000864d:     	movq	%r14, %rcx
180008650:     	callq	*0xcda(%rip)            # 0x180009330
180008656:     	movl	%eax, %ebx
180008658:     	movl	%ebx, 0x30(%rsp)
18000865c:     	jmp	0x180008664 <numba_list_iter_next+0x6a4>
18000865e:     	xorl	%ebx, %ebx
180008660:     	movl	%ebx, 0x30(%rsp)
180008664:     	movl	%ebx, %eax
180008666:     	movq	0x78(%rsp), %rbx
18000866b:     	addq	$0x40, %rsp
18000866f:     	popq	%r14
180008671:     	popq	%rdi
180008672:     	popq	%rsi
180008673:     	retq
180008674:     	movq	%rbx, 0x8(%rsp)
180008679:     	movq	%rsi, 0x10(%rsp)
18000867e:     	pushq	%rdi
18000867f:     	subq	$0x20, %rsp
180008683:     	movq	%r8, %rdi
180008686:     	movl	%edx, %ebx
180008688:     	movq	%rcx, %rsi
18000868b:     	cmpl	$0x1, %edx
18000868e:     	jne	0x180008695 <numba_list_iter_next+0x6d5>
180008690:     	callq	0x1800086bc <numba_list_iter_next+0x6fc>
180008695:     	movq	%rdi, %r8
180008698:     	movl	%ebx, %edx
18000869a:     	movq	%rsi, %rcx
18000869d:     	movq	0x30(%rsp), %rbx
1800086a2:     	movq	0x38(%rsp), %rsi
1800086a7:     	addq	$0x20, %rsp
1800086ab:     	popq	%rdi
1800086ac:     	jmp	0x18000854c <numba_list_iter_next+0x58c>
1800086b1:     	int3
1800086b2:     	int3
1800086b3:     	int3
1800086b4:     	movl	$0x2, %ecx
1800086b9:     	int	$0x29
1800086bb:     	retq
1800086bc:     	movq	%rbx, 0x18(%rsp)
1800086c1:     	pushq	%rbp
1800086c2:     	movq	%rsp, %rbp
1800086c5:     	subq	$0x30, %rsp
1800086c9:     	movq	0x79f0(%rip), %rax      # 0x1800100c0
1800086d0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
1800086da:     	cmpq	%rbx, %rax
1800086dd:     	jne	0x180008756 <numba_list_iter_next+0x796>
1800086df:     	leaq	0x10(%rbp), %rcx
1800086e3:     	movq	$0x0, 0x10(%rbp)
1800086eb:     	callq	*0x937(%rip)            # 0x180009028
1800086f1:     	movq	0x10(%rbp), %rax
1800086f5:     	movq	%rax, -0x10(%rbp)
1800086f9:     	callq	*0x911(%rip)            # 0x180009010
1800086ff:     	movl	%eax, %eax
180008701:     	xorq	%rax, -0x10(%rbp)
180008705:     	callq	*0x8fd(%rip)            # 0x180009008
18000870b:     	movl	%eax, %eax
18000870d:     	leaq	0x18(%rbp), %rcx
180008711:     	xorq	%rax, -0x10(%rbp)
180008715:     	callq	*0x8e5(%rip)            # 0x180009000
18000871b:     	movl	0x18(%rbp), %eax
18000871e:     	leaq	-0x10(%rbp), %rcx
180008722:     	shlq	$0x20, %rax
180008726:     	xorq	0x18(%rbp), %rax
18000872a:     	xorq	-0x10(%rbp), %rax
18000872e:     	xorq	%rcx, %rax
180008731:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000873b:     	andq	%rcx, %rax
18000873e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180008748:     	cmpq	%rbx, %rax
18000874b:     	cmoveq	%rcx, %rax
18000874f:     	movq	%rax, 0x796a(%rip)      # 0x1800100c0
180008756:     	movq	0x50(%rsp), %rbx
18000875b:     	notq	%rax
18000875e:     	movq	%rax, 0x799b(%rip)      # 0x180010100
180008765:     	addq	$0x30, %rsp
180008769:     	popq	%rbp
18000876a:     	retq
18000876b:     	int3
18000876c:     	subq	$0x28, %rsp
180008770:     	cmpl	$0x1, %edx
180008773:     	jne	0x180008785 <numba_list_iter_next+0x7c5>
180008775:     	cmpq	$0x0, 0x120b(%rip)      # 0x180009988
18000877d:     	jne	0x180008785 <numba_list_iter_next+0x7c5>
18000877f:     	callq	*0x89b(%rip)            # 0x180009020
180008785:     	movl	$0x1, %eax
18000878a:     	addq	$0x28, %rsp
18000878e:     	retq
18000878f:     	int3
180008790:     	leaq	0x8219(%rip), %rcx      # 0x1800109b0
180008797:     	jmpq	*0x87a(%rip)            # 0x180009018
18000879e:     	int3
18000879f:     	int3
1800087a0:     	leaq	0x8209(%rip), %rcx      # 0x1800109b0
1800087a7:     	jmp	0x180008e36 <numba_list_iter_next+0xe76>
1800087ac:     	leaq	0x820d(%rip), %rax      # 0x1800109c0
1800087b3:     	retq
1800087b4:     	subq	$0x28, %rsp
1800087b8:     	callq	0x1800078d0 <PyInit_rcaotr_61fae00d4878711302f71448+0x5f60>
1800087bd:     	orq	$0x24, (%rax)
1800087c1:     	callq	0x1800087ac <numba_list_iter_next+0x7ec>
1800087c6:     	orq	$0x2, (%rax)
1800087ca:     	addq	$0x28, %rsp
1800087ce:     	retq
1800087cf:     	int3
1800087d0:     	subq	$0x28, %rsp
1800087d4:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
1800087d9:     	testl	%eax, %eax
1800087db:     	je	0x1800087fe <numba_list_iter_next+0x83e>
1800087dd:     	movq	%gs:0x30, %rax
1800087e6:     	movq	0x8(%rax), %rcx
1800087ea:     	jmp	0x1800087f1 <numba_list_iter_next+0x831>
1800087ec:     	cmpq	%rax, %rcx
1800087ef:     	je	0x180008805 <numba_list_iter_next+0x845>
1800087f1:     	xorl	%eax, %eax
1800087f3:     	lock
1800087f4:     	cmpxchgq	%rcx, 0x81d4(%rip)      # 0x1800109d0
1800087fc:     	jne	0x1800087ec <numba_list_iter_next+0x82c>
1800087fe:     	xorb	%al, %al
180008800:     	addq	$0x28, %rsp
180008804:     	retq
180008805:     	movb	$0x1, %al
180008807:     	jmp	0x180008800 <numba_list_iter_next+0x840>
180008809:     	int3
18000880a:     	int3
18000880b:     	int3
18000880c:     	subq	$0x28, %rsp
180008810:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
180008815:     	testl	%eax, %eax
180008817:     	je	0x180008820 <numba_list_iter_next+0x860>
180008819:     	callq	0x180008b78 <numba_list_iter_next+0xbb8>
18000881e:     	jmp	0x180008839 <numba_list_iter_next+0x879>
180008820:     	callq	0x180008e14 <numba_list_iter_next+0xe54>
180008825:     	movl	%eax, %ecx
180008827:     	callq	0x180008e54 <numba_list_iter_next+0xe94>
18000882c:     	testl	%eax, %eax
18000882e:     	je	0x180008834 <numba_list_iter_next+0x874>
180008830:     	xorb	%al, %al
180008832:     	jmp	0x18000883b <numba_list_iter_next+0x87b>
180008834:     	callq	0x180008e5a <numba_list_iter_next+0xe9a>
180008839:     	movb	$0x1, %al
18000883b:     	addq	$0x28, %rsp
18000883f:     	retq
180008840:     	subq	$0x28, %rsp
180008844:     	xorl	%ecx, %ecx
180008846:     	callq	0x180008978 <numba_list_iter_next+0x9b8>
18000884b:     	testb	%al, %al
18000884d:     	setne	%al
180008850:     	addq	$0x28, %rsp
180008854:     	retq
180008855:     	int3
180008856:     	int3
180008857:     	int3
180008858:     	subq	$0x28, %rsp
18000885c:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008861:     	testb	%al, %al
180008863:     	jne	0x180008869 <numba_list_iter_next+0x8a9>
180008865:     	xorb	%al, %al
180008867:     	jmp	0x18000887b <numba_list_iter_next+0x8bb>
180008869:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
18000886e:     	testb	%al, %al
180008870:     	jne	0x180008879 <numba_list_iter_next+0x8b9>
180008872:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008877:     	jmp	0x180008865 <numba_list_iter_next+0x8a5>
180008879:     	movb	$0x1, %al
18000887b:     	addq	$0x28, %rsp
18000887f:     	retq
180008880:     	subq	$0x28, %rsp
180008884:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008889:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
18000888e:     	movb	$0x1, %al
180008890:     	addq	$0x28, %rsp
180008894:     	retq
180008895:     	int3
180008896:     	int3
180008897:     	int3
180008898:     	movq	%rbx, 0x8(%rsp)
18000889d:     	movq	%rbp, 0x10(%rsp)
1800088a2:     	movq	%rsi, 0x18(%rsp)
1800088a7:     	pushq	%rdi
1800088a8:     	subq	$0x20, %rsp
1800088ac:     	movq	%r9, %rdi
1800088af:     	movq	%r8, %rsi
1800088b2:     	movl	%edx, %ebx
1800088b4:     	movq	%rcx, %rbp
1800088b7:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
1800088bc:     	testl	%eax, %eax
1800088be:     	jne	0x1800088d6 <numba_list_iter_next+0x916>
1800088c0:     	cmpl	$0x1, %ebx
1800088c3:     	jne	0x1800088d6 <numba_list_iter_next+0x916>
1800088c5:     	movq	%rsi, %r8
1800088c8:     	xorl	%edx, %edx
1800088ca:     	movq	%rbp, %rcx
1800088cd:     	movq	%rdi, %rax
1800088d0:     	callq	*0xa5a(%rip)            # 0x180009330
1800088d6:     	movq	0x58(%rsp), %rdx
1800088db:     	movl	0x50(%rsp), %ecx
1800088df:     	movq	0x30(%rsp), %rbx
1800088e4:     	movq	0x38(%rsp), %rbp
1800088e9:     	movq	0x40(%rsp), %rsi
1800088ee:     	addq	$0x20, %rsp
1800088f2:     	popq	%rdi
1800088f3:     	jmp	0x180008e4e <numba_list_iter_next+0xe8e>
1800088f8:     	subq	$0x28, %rsp
1800088fc:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
180008901:     	testl	%eax, %eax
180008903:     	je	0x180008915 <numba_list_iter_next+0x955>
180008905:     	leaq	0x80d4(%rip), %rcx      # 0x1800109e0
18000890c:     	addq	$0x28, %rsp
180008910:     	jmp	0x180008e66 <numba_list_iter_next+0xea6>
180008915:     	callq	0x180008e78 <numba_list_iter_next+0xeb8>
18000891a:     	testl	%eax, %eax
18000891c:     	jne	0x180008923 <numba_list_iter_next+0x963>
18000891e:     	callq	0x180008e6c <numba_list_iter_next+0xeac>
180008923:     	addq	$0x28, %rsp
180008927:     	retq
180008928:     	subq	$0x28, %rsp
18000892c:     	xorl	%ecx, %ecx
18000892e:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008933:     	addq	$0x28, %rsp
180008937:     	jmp	0x180008e74 <numba_list_iter_next+0xeb4>
18000893c:     	subq	$0x28, %rsp
180008940:     	testl	%ecx, %ecx
180008942:     	jne	0x18000894b <numba_list_iter_next+0x98b>
180008944:     	movb	$0x1, 0x808d(%rip)      # 0x1800109d8
18000894b:     	callq	0x180008b78 <numba_list_iter_next+0xbb8>
180008950:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008955:     	testb	%al, %al
180008957:     	jne	0x18000895d <numba_list_iter_next+0x99d>
180008959:     	xorb	%al, %al
18000895b:     	jmp	0x180008971 <numba_list_iter_next+0x9b1>
18000895d:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008962:     	testb	%al, %al
180008964:     	jne	0x18000896f <numba_list_iter_next+0x9af>
180008966:     	xorl	%ecx, %ecx
180008968:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
18000896d:     	jmp	0x180008959 <numba_list_iter_next+0x999>
18000896f:     	movb	$0x1, %al
180008971:     	addq	$0x28, %rsp
180008975:     	retq
180008976:     	int3
180008977:     	int3
180008978:     	pushq	%rbx
18000897a:     	subq	$0x20, %rsp
18000897e:     	cmpb	$0x0, 0x8054(%rip)      # 0x1800109d9
180008985:     	movl	%ecx, %ebx
180008987:     	jne	0x1800089f0 <numba_list_iter_next+0xa30>
180008989:     	cmpl	$0x1, %ecx
18000898c:     	ja	0x1800089f8 <numba_list_iter_next+0xa38>
18000898e:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
180008993:     	testl	%eax, %eax
180008995:     	je	0x1800089bf <numba_list_iter_next+0x9ff>
180008997:     	testl	%ebx, %ebx
180008999:     	jne	0x1800089bf <numba_list_iter_next+0x9ff>
18000899b:     	leaq	0x803e(%rip), %rcx      # 0x1800109e0
1800089a2:     	callq	0x180008e60 <numba_list_iter_next+0xea0>
1800089a7:     	testl	%eax, %eax
1800089a9:     	jne	0x1800089bb <numba_list_iter_next+0x9fb>
1800089ab:     	leaq	0x8046(%rip), %rcx      # 0x1800109f8
1800089b2:     	callq	0x180008e60 <numba_list_iter_next+0xea0>
1800089b7:     	testl	%eax, %eax
1800089b9:     	je	0x1800089e9 <numba_list_iter_next+0xa29>
1800089bb:     	xorb	%al, %al
1800089bd:     	jmp	0x1800089f2 <numba_list_iter_next+0xa32>
1800089bf:     	movdqa	0xfc9(%rip), %xmm0      # 0x180009990
1800089c7:     	orq	$-0x1, %rax
1800089cb:     	movdqu	%xmm0, 0x800d(%rip)     # 0x1800109e0
1800089d3:     	movq	%rax, 0x8016(%rip)      # 0x1800109f0
1800089da:     	movdqu	%xmm0, 0x8016(%rip)     # 0x1800109f8
1800089e2:     	movq	%rax, 0x801f(%rip)      # 0x180010a08
1800089e9:     	movb	$0x1, 0x7fe9(%rip)      # 0x1800109d9
1800089f0:     	movb	$0x1, %al
1800089f2:     	addq	$0x20, %rsp
1800089f6:     	popq	%rbx
1800089f7:     	retq
1800089f8:     	movl	$0x5, %ecx
1800089fd:     	callq	0x180008af4 <numba_list_iter_next+0xb34>
180008a02:     	int3
180008a03:     	int3
180008a04:     	subq	$0x18, %rsp
180008a08:     	movq	%rcx, %r8
180008a0b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180008a10:     	cmpw	%ax, -0x8a17(%rip)      # 0x180000000
180008a17:     	jne	0x180008a91 <numba_list_iter_next+0xad1>
180008a19:     	movslq	-0x89e4(%rip), %rcx     # 0x18000003c
180008a20:     	leaq	-0x8a27(%rip), %rdx     # 0x180000000
180008a27:     	addq	%rdx, %rcx
180008a2a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180008a30:     	jne	0x180008a91 <numba_list_iter_next+0xad1>
180008a32:     	movl	$0x20b, %eax            # imm = 0x20B
180008a37:     	cmpw	%ax, 0x18(%rcx)
180008a3b:     	jne	0x180008a91 <numba_list_iter_next+0xad1>
180008a3d:     	subq	%rdx, %r8
180008a40:     	movzwl	0x14(%rcx), %edx
180008a44:     	addq	$0x18, %rdx
180008a48:     	addq	%rcx, %rdx
180008a4b:     	movzwl	0x6(%rcx), %eax
180008a4f:     	leaq	(%rax,%rax,4), %rcx
180008a53:     	leaq	(%rdx,%rcx,8), %r9
180008a57:     	movq	%rdx, (%rsp)
180008a5b:     	cmpq	%r9, %rdx
180008a5e:     	je	0x180008a78 <numba_list_iter_next+0xab8>
180008a60:     	movl	0xc(%rdx), %ecx
180008a63:     	cmpq	%rcx, %r8
180008a66:     	jb	0x180008a72 <numba_list_iter_next+0xab2>
180008a68:     	movl	0x8(%rdx), %eax
180008a6b:     	addl	%ecx, %eax
180008a6d:     	cmpq	%rax, %r8
180008a70:     	jb	0x180008a7a <numba_list_iter_next+0xaba>
180008a72:     	addq	$0x28, %rdx
180008a76:     	jmp	0x180008a57 <numba_list_iter_next+0xa97>
180008a78:     	xorl	%edx, %edx
180008a7a:     	testq	%rdx, %rdx
180008a7d:     	jne	0x180008a83 <numba_list_iter_next+0xac3>
180008a7f:     	xorb	%al, %al
180008a81:     	jmp	0x180008a97 <numba_list_iter_next+0xad7>
180008a83:     	cmpl	$0x0, 0x24(%rdx)
180008a87:     	jge	0x180008a8d <numba_list_iter_next+0xacd>
180008a89:     	xorb	%al, %al
180008a8b:     	jmp	0x180008a97 <numba_list_iter_next+0xad7>
180008a8d:     	movb	$0x1, %al
180008a8f:     	jmp	0x180008a97 <numba_list_iter_next+0xad7>
180008a91:     	xorb	%al, %al
180008a93:     	jmp	0x180008a97 <numba_list_iter_next+0xad7>
180008a95:     	xorb	%al, %al
180008a97:     	addq	$0x18, %rsp
180008a9b:     	retq
180008a9c:     	pushq	%rbx
180008a9e:     	subq	$0x20, %rsp
180008aa2:     	movb	%cl, %bl
180008aa4:     	callq	0x180008e1c <numba_list_iter_next+0xe5c>
180008aa9:     	xorl	%edx, %edx
180008aab:     	testl	%eax, %eax
180008aad:     	je	0x180008aba <numba_list_iter_next+0xafa>
180008aaf:     	testb	%bl, %bl
180008ab1:     	jne	0x180008aba <numba_list_iter_next+0xafa>
180008ab3:     	xchgq	%rdx, 0x7f16(%rip)      # 0x1800109d0
180008aba:     	addq	$0x20, %rsp
180008abe:     	popq	%rbx
180008abf:     	retq
180008ac0:     	pushq	%rbx
180008ac2:     	subq	$0x20, %rsp
180008ac6:     	cmpb	$0x0, 0x7f0b(%rip)      # 0x1800109d8
180008acd:     	movb	%cl, %bl
180008acf:     	je	0x180008ad5 <numba_list_iter_next+0xb15>
180008ad1:     	testb	%dl, %dl
180008ad3:     	jne	0x180008ae1 <numba_list_iter_next+0xb21>
180008ad5:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008ada:     	movb	%bl, %cl
180008adc:     	callq	0x180008e74 <numba_list_iter_next+0xeb4>
180008ae1:     	movb	$0x1, %al
180008ae3:     	addq	$0x20, %rsp
180008ae7:     	popq	%rbx
180008ae8:     	retq
180008ae9:     	int3
180008aea:     	int3
180008aeb:     	int3
180008aec:     	leaq	0x81a5(%rip), %rax      # 0x180010c98
180008af3:     	retq
180008af4:     	movl	%ecx, %ecx
180008af6:     	int	$0x29
180008af8:     	retq
180008af9:     	int3
180008afa:     	int3
180008afb:     	int3
180008afc:     	movq	%rbx, 0x8(%rsp)
180008b01:     	pushq	%rdi
180008b02:     	subq	$0x20, %rsp
180008b06:     	leaq	0x38bb(%rip), %rbx      # 0x18000c3c8
180008b0d:     	leaq	0x38b4(%rip), %rdi      # 0x18000c3c8
180008b14:     	jmp	0x180008b28 <numba_list_iter_next+0xb68>
180008b16:     	movq	(%rbx), %rax
180008b19:     	testq	%rax, %rax
180008b1c:     	je	0x180008b24 <numba_list_iter_next+0xb64>
180008b1e:     	callq	*0x80c(%rip)            # 0x180009330
180008b24:     	addq	$0x8, %rbx
180008b28:     	cmpq	%rdi, %rbx
180008b2b:     	jb	0x180008b16 <numba_list_iter_next+0xb56>
180008b2d:     	movq	0x30(%rsp), %rbx
180008b32:     	addq	$0x20, %rsp
180008b36:     	popq	%rdi
180008b37:     	retq
180008b38:     	movq	%rbx, 0x8(%rsp)
180008b3d:     	pushq	%rdi
180008b3e:     	subq	$0x20, %rsp
180008b42:     	leaq	0x388f(%rip), %rbx      # 0x18000c3d8
180008b49:     	leaq	0x3888(%rip), %rdi      # 0x18000c3d8
180008b50:     	jmp	0x180008b64 <numba_list_iter_next+0xba4>
180008b52:     	movq	(%rbx), %rax
180008b55:     	testq	%rax, %rax
180008b58:     	je	0x180008b60 <numba_list_iter_next+0xba0>
180008b5a:     	callq	*0x7d0(%rip)            # 0x180009330
180008b60:     	addq	$0x8, %rbx
180008b64:     	cmpq	%rdi, %rbx
180008b67:     	jb	0x180008b52 <numba_list_iter_next+0xb92>
180008b69:     	movq	0x30(%rsp), %rbx
180008b6e:     	addq	$0x20, %rsp
180008b72:     	popq	%rdi
180008b73:     	retq
180008b74:     	retq	$0x0
180008b77:     	int3
180008b78:     	movq	%rbx, 0x10(%rsp)
180008b7d:     	movq	%rbp, 0x18(%rsp)
180008b82:     	movq	%rsi, 0x20(%rsp)
180008b87:     	pushq	%rdi
180008b88:     	subq	$0x10, %rsp
180008b8c:     	xorl	%eax, %eax
180008b8e:     	xorl	%ecx, %ecx
180008b90:     	cpuid
180008b92:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180008b98:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
180008b9e:     	orl	%ecx, %edx
180008ba0:     	movl	%eax, %ebp
180008ba2:     	movl	$0x1, %eax
180008ba7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
180008bad:     	orl	%ebx, %edx
180008baf:     	leal	-0x1(%rax), %ecx
180008bb2:     	cpuid
180008bb4:     	movl	%ecx, %edi
180008bb6:     	jne	0x180008c16 <numba_list_iter_next+0xc56>
180008bb8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
180008bbd:     	movq	$0x8000, 0x7550(%rip)   # imm = 0x8000
                                                # 0x180010118
180008bc8:     	movq	$-0x1, 0x754d(%rip)     # 0x180010120
180008bd3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180008bd8:     	je	0x180008c02 <numba_list_iter_next+0xc42>
180008bda:     	cmpl	$0x20660, %eax          # imm = 0x20660
180008bdf:     	je	0x180008c02 <numba_list_iter_next+0xc42>
180008be1:     	cmpl	$0x20670, %eax          # imm = 0x20670
180008be6:     	je	0x180008c02 <numba_list_iter_next+0xc42>
180008be8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180008bed:     	cmpl	$0x20, %eax
180008bf0:     	ja	0x180008c16 <numba_list_iter_next+0xc56>
180008bf2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180008bfc:     	btq	%rax, %rcx
180008c00:     	jae	0x180008c16 <numba_list_iter_next+0xc56>
180008c02:     	movl	0x7e0b(%rip), %r8d      # 0x180010a14
180008c09:     	orl	$0x1, %r8d
180008c0d:     	movl	%r8d, 0x7e00(%rip)      # 0x180010a14
180008c14:     	jmp	0x180008c1d <numba_list_iter_next+0xc5d>
180008c16:     	movl	0x7df7(%rip), %r8d      # 0x180010a14
180008c1d:     	xorl	%r9d, %r9d
180008c20:     	movl	%r9d, %r11d
180008c23:     	cmpl	$0x7, %ebp
180008c26:     	jl	0x180008c6a <numba_list_iter_next+0xcaa>
180008c28:     	xorl	%ecx, %ecx
180008c2a:     	leal	0x7(%r9), %eax
180008c2e:     	cpuid
180008c30:     	movl	%edx, %esi
180008c32:     	movl	%ebx, %r10d
180008c35:     	btl	$0x9, %ebx
180008c39:     	jae	0x180008c46 <numba_list_iter_next+0xc86>
180008c3b:     	orl	$0x2, %r8d
180008c3f:     	movl	%r8d, 0x7dce(%rip)      # 0x180010a14
180008c46:     	cmpl	$0x1, %eax
180008c49:     	jl	0x180008c58 <numba_list_iter_next+0xc98>
180008c4b:     	movl	$0x7, %eax
180008c50:     	leal	-0x6(%rax), %ecx
180008c53:     	cpuid
180008c55:     	movl	%edx, %r9d
180008c58:     	movl	$0x24, %eax
180008c5d:     	cmpl	%eax, %ebp
180008c5f:     	jl	0x180008c70 <numba_list_iter_next+0xcb0>
180008c61:     	xorl	%ecx, %ecx
180008c63:     	cpuid
180008c65:     	movl	%ebx, %r11d
180008c68:     	jmp	0x180008c70 <numba_list_iter_next+0xcb0>
180008c6a:     	movl	%r9d, %r10d
180008c6d:     	movl	%r9d, %esi
180008c70:     	movq	0x74b1(%rip), %rax      # 0x180010128
180008c77:     	andq	$-0x2, %rax
180008c7b:     	movl	$0x1, 0x748b(%rip)      # 0x180010110
180008c85:     	movl	$0x2, 0x7485(%rip)      # 0x180010114
180008c8f:     	movq	%rax, 0x7492(%rip)      # 0x180010128
180008c96:     	btl	$0x14, %edi
180008c9a:     	jae	0x180008cbb <numba_list_iter_next+0xcfb>
180008c9c:     	andq	$-0x11, %rax
180008ca0:     	movl	$0x2, 0x7466(%rip)      # 0x180010110
180008caa:     	movq	%rax, 0x7477(%rip)      # 0x180010128
180008cb1:     	movl	$0x6, 0x7459(%rip)      # 0x180010114
180008cbb:     	btl	$0x1b, %edi
180008cbf:     	jae	0x180008dfc <numba_list_iter_next+0xe3c>
180008cc5:     	xorl	%ecx, %ecx
180008cc7:     	xgetbv
180008cca:     	shlq	$0x20, %rdx
180008cce:     	orq	%rax, %rdx
180008cd1:     	movq	%rdx, 0x20(%rsp)
180008cd6:     	btl	$0x1c, %edi
180008cda:     	jae	0x180008de0 <numba_list_iter_next+0xe20>
180008ce0:     	movq	0x20(%rsp), %rax
180008ce5:     	andb	$0x6, %al
180008ce7:     	cmpb	$0x6, %al
180008ce9:     	jne	0x180008de0 <numba_list_iter_next+0xe20>
180008cef:     	movl	0x741f(%rip), %eax      # 0x180010114
180008cf5:     	movb	$-0x20, %dl
180008cf7:     	orl	$0x8, %eax
180008cfa:     	movl	$0x3, 0x740c(%rip)      # 0x180010110
180008d04:     	movl	%eax, 0x740a(%rip)      # 0x180010114
180008d0a:     	testb	$0x20, %r10b
180008d0e:     	je	0x180008d72 <numba_list_iter_next+0xdb2>
180008d10:     	orl	$0x20, %eax
180008d13:     	movl	$0x5, 0x73f3(%rip)      # 0x180010110
180008d1d:     	movl	%eax, 0x73f1(%rip)      # 0x180010114
180008d23:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180008d28:     	movq	0x73f9(%rip), %rax      # 0x180010128
180008d2f:     	andl	%ecx, %r10d
180008d32:     	andq	$-0x3, %rax
180008d36:     	movq	%rax, 0x73eb(%rip)      # 0x180010128
180008d3d:     	cmpl	%ecx, %r10d
180008d40:     	jne	0x180008d79 <numba_list_iter_next+0xdb9>
180008d42:     	movq	0x20(%rsp), %rax
180008d47:     	andb	%dl, %al
180008d49:     	cmpb	%dl, %al
180008d4b:     	jne	0x180008d72 <numba_list_iter_next+0xdb2>
180008d4d:     	movq	0x73d4(%rip), %rax      # 0x180010128
180008d54:     	orl	$0x40, 0x73b9(%rip)     # 0x180010114
180008d5b:     	andq	$-0x25, %rax
180008d5f:     	movl	$0x6, 0x73a7(%rip)      # 0x180010110
180008d69:     	movq	%rax, 0x73b8(%rip)      # 0x180010128
180008d70:     	jmp	0x180008d79 <numba_list_iter_next+0xdb9>
180008d72:     	movq	0x73af(%rip), %rax      # 0x180010128
180008d79:     	btl	$0x17, %esi
180008d7d:     	jae	0x180008d8b <numba_list_iter_next+0xdcb>
180008d7f:     	btrq	$0x18, %rax
180008d84:     	movq	%rax, 0x739d(%rip)      # 0x180010128
180008d8b:     	btl	$0x13, %r9d
180008d90:     	jae	0x180008de0 <numba_list_iter_next+0xe20>
180008d92:     	movq	0x20(%rsp), %rax
180008d97:     	andb	%dl, %al
180008d99:     	cmpb	%dl, %al
180008d9b:     	jne	0x180008de0 <numba_list_iter_next+0xe20>
180008d9d:     	movq	0x7384(%rip), %rdx      # 0x180010128
180008da4:     	movl	%r11d, %eax
180008da7:     	shrq	$0x10, %rax
180008dab:     	movl	%r11d, %ecx
180008dae:     	andl	$0x6, %eax
180008db1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180008db7:     	orq	$0x1000029, %rax        # imm = 0x1000029
180008dbd:     	movl	%ecx, 0x7c55(%rip)      # 0x180010a18
180008dc3:     	notq	%rax
180008dc6:     	andq	%rax, %rdx
180008dc9:     	movq	%rdx, 0x7358(%rip)      # 0x180010128
180008dd0:     	cmpb	$0x1, %cl
180008dd3:     	jbe	0x180008de0 <numba_list_iter_next+0xe20>
180008dd5:     	andq	$-0x41, %rdx
180008dd9:     	movq	%rdx, 0x7348(%rip)      # 0x180010128
180008de0:     	btl	$0x15, %r9d
180008de5:     	jae	0x180008dfc <numba_list_iter_next+0xe3c>
180008de7:     	movq	0x20(%rsp), %rax
180008dec:     	btq	$0x13, %rax
180008df1:     	jae	0x180008dfc <numba_list_iter_next+0xe3c>
180008df3:     	btrq	$0x7, 0x732c(%rip)      # 0x180010128
180008dfc:     	movq	0x28(%rsp), %rbx
180008e01:     	xorl	%eax, %eax
180008e03:     	movq	0x30(%rsp), %rbp
180008e08:     	movq	0x38(%rsp), %rsi
180008e0d:     	addq	$0x10, %rsp
180008e11:     	popq	%rdi
180008e12:     	retq
180008e13:     	int3
180008e14:     	movl	$0x1, %eax
180008e19:     	retq
180008e1a:     	int3
180008e1b:     	int3
180008e1c:     	xorl	%eax, %eax
180008e1e:     	cmpl	%eax, 0x730c(%rip)      # 0x180010130
180008e24:     	setne	%al
180008e27:     	retq
180008e28:     	int3
180008e29:     	int3
180008e2a:     	int3
180008e2b:     	int3
180008e2c:     	int3
180008e2d:     	int3
180008e2e:     	int3
180008e2f:     	int3
180008e30:     	jmpq	*0x212(%rip)            # 0x180009048
180008e36:     	jmpq	*0x214(%rip)            # 0x180009050
180008e3c:     	jmpq	*0x23e(%rip)            # 0x180009080
180008e42:     	jmpq	*0x250(%rip)            # 0x180009098
180008e48:     	jmpq	*0x252(%rip)            # 0x1800090a0
180008e4e:     	jmpq	*0x254(%rip)            # 0x1800090a8
180008e54:     	jmpq	*0x256(%rip)            # 0x1800090b0
180008e5a:     	jmpq	*0x258(%rip)            # 0x1800090b8
180008e60:     	jmpq	*0x25a(%rip)            # 0x1800090c0
180008e66:     	jmpq	*0x25c(%rip)            # 0x1800090c8
180008e6c:     	jmpq	*0x21e(%rip)            # 0x180009090
180008e72:     	int3
180008e73:     	int3
180008e74:     	movb	$0x1, %al
180008e76:     	retq
180008e77:     	int3
180008e78:     	xorl	%eax, %eax
180008e7a:     	retq
180008e7b:     	jmpq	*0x1bf(%rip)            # 0x180009040
180008e81:     	jmpq	*0x1b1(%rip)            # 0x180009038
180008e87:     	jmpq	*0x24b(%rip)            # 0x1800090d8
180008e8d:     	jmpq	*0x24d(%rip)            # 0x1800090e0
180008e93:     	int3
180008e94:     	int3
180008e95:     	int3
180008e96:     	int3
180008e97:     	int3
180008e98:     	int3
180008e99:     	int3
180008e9a:     	int3
180008e9b:     	int3
180008e9c:     	int3
180008e9d:     	int3
180008e9e:     	int3
180008e9f:     	int3
180008ea0:     	int3
180008ea1:     	int3
180008ea2:     	int3
180008ea3:     	int3
180008ea4:     	int3
180008ea5:     	int3
180008ea6:     	nopw	(%rax,%rax)
180008eb0:     	jmpq	*%rax
180008eb2:     	int3
180008eb3:     	int3
180008eb4:     	int3
180008eb5:     	int3
180008eb6:     	int3
180008eb7:     	int3
180008eb8:     	int3
180008eb9:     	int3
180008eba:     	int3
180008ebb:     	int3
180008ebc:     	int3
180008ebd:     	int3
180008ebe:     	int3
180008ebf:     	int3
180008ec0:     	int3
180008ec1:     	int3
180008ec2:     	int3
180008ec3:     	int3
180008ec4:     	int3
180008ec5:     	int3
180008ec6:     	nopw	(%rax,%rax)
180008ed0:     	jmpq	*0x45a(%rip)            # 0x180009330
180008ed6:     	pushq	%rbp
180008ed8:     	subq	$0x20, %rsp
180008edc:     	movq	%rdx, %rbp
180008edf:     	movb	0x40(%rbp), %cl
180008ee2:     	addq	$0x20, %rsp
180008ee6:     	popq	%rbp
180008ee7:     	jmp	0x180008a9c <numba_list_iter_next+0xadc>
180008eec:     	int3
180008eed:     	pushq	%rbp
180008eef:     	subq	$0x20, %rsp
180008ef3:     	movq	%rdx, %rbp
180008ef6:     	movb	0x20(%rbp), %cl
180008ef9:     	callq	0x180008a9c <numba_list_iter_next+0xadc>
180008efe:     	nop
180008eff:     	addq	$0x20, %rsp
180008f03:     	popq	%rbp
180008f04:     	retq
180008f05:     	int3
180008f06:     	pushq	%rbp
180008f08:     	subq	$0x20, %rsp
180008f0c:     	movq	%rdx, %rbp
180008f0f:     	addq	$0x20, %rsp
180008f13:     	popq	%rbp
180008f14:     	jmp	0x180008928 <numba_list_iter_next+0x968>
180008f19:     	int3
180008f1a:     	pushq	%rbp
180008f1c:     	subq	$0x30, %rsp
180008f20:     	movq	%rdx, %rbp
180008f23:     	movq	(%rcx), %rax
180008f26:     	movl	(%rax), %edx
180008f28:     	movq	%rcx, 0x28(%rsp)
180008f2d:     	movl	%edx, 0x20(%rsp)
180008f31:     	leaq	-0xbd8(%rip), %r9       # 0x180008360 <numba_list_iter_next+0x3a0>
180008f38:     	movq	0x70(%rbp), %r8
180008f3c:     	movl	0x68(%rbp), %edx
180008f3f:     	movq	0x60(%rbp), %rcx
180008f43:     	callq	0x180008898 <numba_list_iter_next+0x8d8>
180008f48:     	nop
180008f49:     	addq	$0x30, %rsp
180008f4d:     	popq	%rbp
180008f4e:     	retq
180008f4f:     	int3
180008f50:     	pushq	%rbp
180008f52:     	movq	%rdx, %rbp
180008f55:     	movq	(%rcx), %rax
180008f58:     	xorl	%ecx, %ecx
180008f5a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180008f60:     	sete	%cl
180008f63:     	movl	%ecx, %eax
180008f65:     	popq	%rbp
180008f66:     	retq
180008f67:     	int3
