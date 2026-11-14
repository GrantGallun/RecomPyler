
D:\Code\Datathon\recompyler-codex-20261111\wave8-native\results\cache\raytrace\final\recompyler\rcaotr_bee84dfb472143a382ca4af1.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x180008070 <numba_list_iter_next+0x160>
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
180001166:     	callq	0x1800019d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x60>
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
180001217:     	callq	0x180008221 <numba_list_iter_next+0x311>
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
180001275:     	callq	0x180006ee0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5570>
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
1800012e8:     	callq	0x180006ee0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5570>
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
18000135b:     	callq	0x180006ee0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5570>
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
1800013ee:     	callq	0x180006ee0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5570>
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
180001462:     	callq	0x180008227 <numba_list_iter_next+0x317>
180001467:     	testq	%rax, %rax
18000146a:     	movq	%r14, 0x90(%rsp)
180001472:     	je	0x180001699 <.text+0x699>
180001478:     	movq	%rax, %rbp
18000147b:     	movq	%rax, %rcx
18000147e:     	callq	0x18000822d <numba_list_iter_next+0x31d>
180001483:     	movq	%rax, %r13
180001486:     	movq	%rbp, %rcx
180001489:     	callq	0x180008233 <numba_list_iter_next+0x323>
18000148e:     	movq	%rbx, %r14
180001491:     	callq	0x180008239 <numba_list_iter_next+0x329>
180001496:     	testq	%rax, %rax
180001499:     	jne	0x1800016c2 <.text+0x6c2>
18000149f:     	movq	%rsi, %rbx
1800014a2:     	movq	0xe0(%rsp), %rcx
1800014aa:     	callq	0x180008227 <numba_list_iter_next+0x317>
1800014af:     	testq	%rax, %rax
1800014b2:     	je	0x1800016af <.text+0x6af>
1800014b8:     	movq	%rax, %rsi
1800014bb:     	movq	%rax, %rcx
1800014be:     	callq	0x18000822d <numba_list_iter_next+0x31d>
1800014c3:     	movq	%rax, %rbp
1800014c6:     	movq	%rsi, %rcx
1800014c9:     	callq	0x180008233 <numba_list_iter_next+0x323>
1800014ce:     	callq	0x180008239 <numba_list_iter_next+0x329>
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
1800015ba:     	callq	0x18000823f <numba_list_iter_next+0x32f>
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
1800015dc:     	callq	0x180008245 <numba_list_iter_next+0x335>
1800015e1:     	movl	0x8(%rbx), %edx
1800015e4:     	movq	(%rbx), %rcx
1800015e7:     	cmpl	$0x0, 0x20(%rbx)
1800015eb:     	jle	0x18000171d <.text+0x71d>
1800015f1:     	movslq	%edx, %rdx
1800015f4:     	callq	0x18000824b <numba_list_iter_next+0x33b>
1800015f9:     	movq	%rax, %rsi
1800015fc:     	movq	0x10(%rbx), %rcx
180001600:     	callq	*0x18(%rbx)
180001603:     	testq	%rax, %rax
180001606:     	je	0x180001746 <.text+0x746>
18000160c:     	movq	%rsi, %rcx
18000160f:     	movq	%rax, %rdx
180001612:     	callq	0x1800066f0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d80>
180001617:     	movq	%rax, %rsi
18000161a:     	movq	%rbx, %rcx
18000161d:     	callq	0x180008180 <numba_list_iter_next+0x270>
180001622:     	jmp	0x180001729 <.text+0x729>
180001627:     	movq	0x7c92(%rip), %rcx      # 0x1800092c0
18000162e:     	leaq	0x7f8b(%rip), %rdx      # 0x1800095c0
180001635:     	callq	0x180008251 <numba_list_iter_next+0x341>
18000163a:     	jmp	0x1800016f7 <.text+0x6f7>
18000163f:     	movq	0x7c6a(%rip), %rcx      # 0x1800092b0
180001646:     	leaq	0x8063(%rip), %rdx      # 0x1800096b0
18000164d:     	callq	0x180008251 <numba_list_iter_next+0x341>
180001652:     	jmp	0x1800016f7 <.text+0x6f7>
180001657:     	movq	0x7c52(%rip), %rcx      # 0x1800092b0
18000165e:     	leaq	0x804b(%rip), %rdx      # 0x1800096b0
180001665:     	callq	0x180008251 <numba_list_iter_next+0x341>
18000166a:     	jmp	0x1800016ef <.text+0x6ef>
18000166f:     	movq	0x7c3a(%rip), %rcx      # 0x1800092b0
180001676:     	leaq	0x8033(%rip), %rdx      # 0x1800096b0
18000167d:     	callq	0x180008251 <numba_list_iter_next+0x341>
180001682:     	jmp	0x1800016e7 <.text+0x6e7>
180001684:     	movq	0x7c25(%rip), %rcx      # 0x1800092b0
18000168b:     	leaq	0x801e(%rip), %rdx      # 0x1800096b0
180001692:     	callq	0x180008251 <numba_list_iter_next+0x341>
180001697:     	jmp	0x1800016df <.text+0x6df>
180001699:     	xorl	%r13d, %r13d
18000169c:     	movq	%rbx, %r14
18000169f:     	callq	0x180008239 <numba_list_iter_next+0x329>
1800016a4:     	testq	%rax, %rax
1800016a7:     	je	0x18000149f <.text+0x49f>
1800016ad:     	jmp	0x1800016c2 <.text+0x6c2>
1800016af:     	xorl	%ebp, %ebp
1800016b1:     	callq	0x180008239 <numba_list_iter_next+0x329>
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
180001716:     	callq	0x180008251 <numba_list_iter_next+0x341>
18000171b:     	jmp	0x1800016f7 <.text+0x6f7>
18000171d:     	movq	0x10(%rbx), %r8
180001721:     	callq	0x180006610 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ca0>
180001726:     	movq	%rax, %rsi
180001729:     	testq	%rsi, %rsi
18000172c:     	je	0x1800016f7 <.text+0x6f7>
18000172e:     	movq	%rsi, %rcx
180001731:     	callq	0x1800061b0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4840>
180001736:     	jmp	0x1800016f7 <.text+0x6f7>
180001738:     	movq	0x7b61(%rip), %rcx      # 0x1800092a0
18000173f:     	callq	0x180008257 <numba_list_iter_next+0x347>
180001744:     	jmp	0x1800016f7 <.text+0x6f7>
180001746:     	movq	0x7b73(%rip), %rcx      # 0x1800092c0
18000174d:     	leaq	0x7fbc(%rip), %rdx      # 0x180009710
180001754:     	callq	0x180008251 <numba_list_iter_next+0x341>
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
18000188c:     	callq	0x180006180 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4810>
180001891:     	testl	%edi, %edi
180001893:     	jle	0x1800018d9 <.text+0x8d9>
180001895:     	callq	0x180008245 <numba_list_iter_next+0x335>
18000189a:     	movl	0x8(%rsi), %edx
18000189d:     	movq	(%rsi), %rcx
1800018a0:     	cmpl	$0x0, 0x20(%rsi)
1800018a4:     	jle	0x1800018fa <.text+0x8fa>
1800018a6:     	movslq	%edx, %rdx
1800018a9:     	callq	0x18000824b <numba_list_iter_next+0x33b>
1800018ae:     	movq	%rax, %rdi
1800018b1:     	movq	0x10(%rsi), %rcx
1800018b5:     	callq	*0x18(%rsi)
1800018b8:     	testq	%rax, %rax
1800018bb:     	je	0x180001955 <.text+0x955>
1800018c1:     	movq	%rdi, %rcx
1800018c4:     	movq	%rax, %rdx
1800018c7:     	callq	0x1800066f0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d80>
1800018cc:     	movq	%rax, %rdi
1800018cf:     	movq	%rsi, %rcx
1800018d2:     	callq	0x180008180 <numba_list_iter_next+0x270>
1800018d7:     	jmp	0x180001906 <.text+0x906>
1800018d9:     	movl	%edi, %eax
1800018db:     	cmpl	$-0x3, %edi
1800018de:     	je	0x180001947 <.text+0x947>
1800018e0:     	cmpl	$-0x1, %eax
1800018e3:     	je	0x180001913 <.text+0x913>
1800018e5:     	movq	0x79bc(%rip), %rcx      # 0x1800092a8
1800018ec:     	leaq	0x7ecd(%rip), %rdx      # 0x1800097c0
1800018f3:     	callq	0x180008251 <numba_list_iter_next+0x341>
1800018f8:     	jmp	0x180001913 <.text+0x913>
1800018fa:     	movq	0x10(%rsi), %r8
1800018fe:     	callq	0x180006610 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ca0>
180001903:     	movq	%rax, %rdi
180001906:     	testq	%rdi, %rdi
180001909:     	je	0x180001913 <.text+0x913>
18000190b:     	movq	%rdi, %rcx
18000190e:     	callq	0x1800061b0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4840>
180001913:     	leaq	0x7ed6(%rip), %rcx      # 0x1800097f0
18000191a:     	callq	0x18000825d <numba_list_iter_next+0x34d>
18000191f:     	movq	%rax, %rsi
180001922:     	movq	%rax, %rcx
180001925:     	callq	0x180008263 <numba_list_iter_next+0x353>
18000192a:     	movq	%rsi, %rcx
18000192d:     	callq	0x180008233 <numba_list_iter_next+0x323>
180001932:     	leaq	0x8c(%rsp), %rcx
18000193a:     	callq	0x1800061a0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4830>
18000193f:     	movq	%rbx, %rax
180001942:     	jmp	0x18000186c <.text+0x86c>
180001947:     	movq	0x7952(%rip), %rcx      # 0x1800092a0
18000194e:     	callq	0x180008257 <numba_list_iter_next+0x347>
180001953:     	jmp	0x180001913 <.text+0x913>
180001955:     	movq	0x7964(%rip), %rcx      # 0x1800092c0
18000195c:     	leaq	0x7e1d(%rip), %rdx      # 0x180009780
180001963:     	callq	0x180008251 <numba_list_iter_next+0x341>
180001968:     	xorl	%eax, %eax
18000196a:     	jmp	0x18000186c <.text+0x86c>
18000196f:     	nop

0000000180001970 <PyInit_rcaotr_bee84dfb472143a382ca4af1>:
180001970:     	pushq	%rsi
180001971:     	subq	$0x20, %rsp
180001975:     	leaq	0xe6c4(%rip), %rcx      # 0x180010040
18000197c:     	movl	$0x3f5, %edx            # imm = 0x3F5
180001981:     	callq	0x180008269 <numba_list_iter_next+0x359>
180001986:     	testq	%rax, %rax
180001989:     	je	0x1800019bb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b>
18000198b:     	leaq	0xe66e(%rip), %rdx      # 0x180010000
180001992:     	leaq	0x7ec7(%rip), %r8       # 0x180009860
180001999:     	leaq	0x7fb0(%rip), %r9       # 0x180009950
1800019a0:     	movq	%rax, %rcx
1800019a3:     	movq	%rax, %rsi
1800019a6:     	callq	0x180007150 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x57e0>
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
1800019dc:     	subq	$0x1d8, %rsp            # imm = 0x1D8
1800019e3:     	movapd	%xmm15, 0x1c0(%rsp)
1800019ed:     	movapd	%xmm14, 0x1b0(%rsp)
1800019f7:     	movapd	%xmm13, 0x1a0(%rsp)
180001a01:     	movapd	%xmm12, 0x190(%rsp)
180001a0b:     	movapd	%xmm11, 0x180(%rsp)
180001a15:     	movapd	%xmm10, 0x170(%rsp)
180001a1f:     	movapd	%xmm9, 0x160(%rsp)
180001a29:     	movapd	%xmm8, 0x150(%rsp)
180001a33:     	movapd	%xmm7, 0x140(%rsp)
180001a3c:     	movaps	%xmm6, 0x130(%rsp)
180001a44:     	movq	%r9, %rbx
180001a47:     	movq	%r8, %r14
180001a4a:     	movq	%rdx, %rdi
180001a4d:     	movq	%rcx, %rsi
180001a50:     	movq	0x258(%rsp), %r15
180001a58:     	movq	0x248(%rsp), %r13
180001a60:     	movq	0x240(%rsp), %rbp
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
180001ae0:     	movq	$0x0, 0x128(%rsp)
180001aec:     	xorps	%xmm6, %xmm6
180001aef:     	cvtsi2sdq	(%r9,%r15,8), %xmm6
180001af5:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b0
180001afd:     	mulsd	0x78b3(%rip), %xmm6     # 0x1800093b8
180001b05:     	divsd	0x78b3(%rip), %xmm6     # 0x1800093c0
180001b0d:     	movapd	%xmm6, %xmm0
180001b11:     	callq	0x180008d8c <numba_list_iter_next+0xe7c>
180001b16:     	ucomisd	%xmm0, %xmm0
180001b1a:     	jp	0x180001b70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x200>
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
180001b4e:     	je	0x180001b70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x200>
180001b50:     	movq	0x260(%rsp), %r12
180001b58:     	movq	0x10(%rbx,%r12,8), %rcx
180001b5d:     	movq	%rcx, %rax
180001b60:     	negq	%rax
180001b63:     	jno	0x180001bf2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x282>
180001b69:     	movb	$0x1, (%r13)
180001b6e:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001b70:     	movb	$0x1, (%r13)
180001b75:     	movq	$0x3, 0x18(%rbp)
180001b7d:     	xorl	%eax, %eax
180001b7f:     	movq	$0x0, (%rsi)
180001b86:     	movaps	0x130(%rsp), %xmm6
180001b8e:     	movaps	0x140(%rsp), %xmm7
180001b96:     	movaps	0x150(%rsp), %xmm8
180001b9f:     	movaps	0x160(%rsp), %xmm9
180001ba8:     	movaps	0x170(%rsp), %xmm10
180001bb1:     	movaps	0x180(%rsp), %xmm11
180001bba:     	movaps	0x190(%rsp), %xmm12
180001bc3:     	movaps	0x1a0(%rsp), %xmm13
180001bcc:     	movaps	0x1b0(%rsp), %xmm14
180001bd5:     	movaps	0x1c0(%rsp), %xmm15
180001bde:     	addq	$0x1d8, %rsp            # imm = 0x1D8
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
180001bf9:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001bfb:     	decq	%rcx
180001bfe:     	je	0x180001c1e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2ae>
180001c00:     	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
180001c0a:     	movq	0x8(%rbx,%r12,8), %rdx
180001c0f:     	cmpq	%r8, %rdx
180001c12:     	jne	0x180001c30 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c0>
180001c14:     	movb	$0x1, (%r13)
180001c19:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001c1e:     	movb	$0x1, (%r13)
180001c23:     	movq	$0x7, 0x18(%rbp)
180001c2b:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001c30:     	decq	%rdx
180001c33:     	je	0x180001d6e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3fe>
180001c39:     	movq	0x250(%rsp), %r11
180001c41:     	movq	0x10(%rbx,%r15,8), %r8
180001c46:     	movq	0x20(%rbx,%r15,8), %r9
180001c4b:     	movsd	(%r14,%r8,8), %xmm1
180001c51:     	subsd	(%r14,%r9,8), %xmm1
180001c57:     	movapd	0x7771(%rip), %xmm2     # 0x1800093d0
180001c5f:     	andpd	%xmm1, %xmm2
180001c63:     	ucomisd	0x7775(%rip), %xmm2     # 0x1800093e0
180001c6b:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001c71:     	movsd	0x10(%r14,%r8,8), %xmm2
180001c78:     	subsd	0x10(%r14,%r9,8), %xmm2
180001c7f:     	movapd	0x7749(%rip), %xmm3     # 0x1800093d0
180001c87:     	andpd	%xmm2, %xmm3
180001c8b:     	ucomisd	0x774d(%rip), %xmm3     # 0x1800093e0
180001c93:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001c99:     	movsd	0x20(%r14,%r8,8), %xmm3
180001ca0:     	subsd	0x20(%r14,%r9,8), %xmm3
180001ca7:     	movapd	0x7721(%rip), %xmm4     # 0x1800093d0
180001caf:     	andpd	%xmm3, %xmm4
180001cb3:     	ucomisd	0x7725(%rip), %xmm4     # 0x1800093e0
180001cbb:     	jae	0x180001d25 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b5>
180001cbd:     	movq	(%rbp), %r10
180001cc1:     	leaq	0x6(%r10), %r8
180001cc5:     	cmpq	%r11, %r8
180001cc8:     	jg	0x180001d64 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f4>
180001cce:     	movq	%r8, (%rbp)
180001cd2:     	cmpb	$0x0, (%r13)
180001cd7:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001cdd:     	movsd	%xmm1, (%r14,%r10,8)
180001ce3:     	movsd	%xmm2, 0x10(%r14,%r10,8)
180001cea:     	movsd	%xmm3, 0x20(%r14,%r10,8)
180001cf1:     	movq	%r10, 0x80(%rsp)
180001cf9:     	movzbl	(%r13), %r10d
180001cfe:     	xorl	%r8d, %r8d
180001d01:     	movl	%r10d, %r11d
180001d04:     	negb	%r11b
180001d07:     	movq	0x250(%rsp), %r11
180001d0f:     	sbbq	%r8, %r8
180001d12:     	orq	0x80(%rsp), %r8
180001d1a:     	testb	%r10b, %r10b
180001d1d:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d23:     	jmp	0x180001d47 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d7>
180001d25:     	movb	$0x1, (%r13)
180001d2a:     	movq	$0xf4243, 0x18(%rbp)    # imm = 0xF4243
180001d32:     	movzbl	(%r13), %r10d
180001d37:     	movq	$-0x1, %r8
180001d3e:     	testb	%r10b, %r10b
180001d41:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d47:     	movq	%r8, 0x80(%rsp)
180001d4f:     	movq	(%rbp), %r8
180001d53:     	movq	%r8, 0x88(%rsp)
180001d5b:     	leaq	0x2(%r8), %r10
180001d5f:     	cmpq	%r11, %r10
180001d62:     	jle	0x180001d80 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x410>
180001d64:     	movb	$0x2, (%r13)
180001d69:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d6e:     	movb	$0x1, (%r13)
180001d73:     	movq	$0x8, 0x18(%rbp)
180001d7b:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d80:     	movq	%r10, (%rbp)
180001d84:     	cmpb	$0x0, (%r13)
180001d89:     	movq	0x80(%rsp), %r8
180001d91:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001d97:     	movq	0x88(%rsp), %r10
180001d9f:     	movq	%r9, (%rbx,%r10,8)
180001da3:     	cmpb	$0x0, (%r13)
180001da8:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001dae:     	movsd	(%r14,%r8,8), %xmm1
180001db4:     	mulsd	%xmm1, %xmm1
180001db8:     	movapd	0x7610(%rip), %xmm2     # 0x1800093d0
180001dc0:     	andpd	%xmm1, %xmm2
180001dc4:     	ucomisd	0x7614(%rip), %xmm2     # 0x1800093e0
180001dcc:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001dce:     	movsd	0x10(%r14,%r8,8), %xmm2
180001dd5:     	mulsd	%xmm2, %xmm2
180001dd9:     	movapd	0x75ef(%rip), %xmm3     # 0x1800093d0
180001de1:     	andpd	%xmm2, %xmm3
180001de5:     	ucomisd	0x75f3(%rip), %xmm3     # 0x1800093e0
180001ded:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001def:     	addsd	%xmm2, %xmm1
180001df3:     	movapd	0x75d5(%rip), %xmm2     # 0x1800093d0
180001dfb:     	andpd	%xmm1, %xmm2
180001dff:     	ucomisd	0x75d9(%rip), %xmm2     # 0x1800093e0
180001e07:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001e09:     	movsd	0x20(%r14,%r8,8), %xmm2
180001e10:     	mulsd	%xmm2, %xmm2
180001e14:     	movapd	0x75b4(%rip), %xmm3     # 0x1800093d0
180001e1c:     	andpd	%xmm2, %xmm3
180001e20:     	ucomisd	0x75b8(%rip), %xmm3     # 0x1800093e0
180001e28:     	jae	0x180001e44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d4>
180001e2a:     	addsd	%xmm2, %xmm1
180001e2e:     	movapd	0x759a(%rip), %xmm2     # 0x1800093d0
180001e36:     	andpd	%xmm1, %xmm2
180001e3a:     	ucomisd	0x759e(%rip), %xmm2     # 0x1800093e0
180001e42:     	jb	0x180001e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e5>
180001e44:     	movb	$0x1, (%r13)
180001e49:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
180001e51:     	xorpd	%xmm1, %xmm1
180001e55:     	cmpb	$0x0, (%r13)
180001e5a:     	jne	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180001e60:     	sqrtsd	%xmm1, %xmm1
180001e64:     	xorpd	%xmm2, %xmm2
180001e68:     	ucomisd	%xmm2, %xmm1
180001e6c:     	jne	0x180002050 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6e0>
180001e72:     	jp	0x180002050 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6e0>
180001e78:     	movb	$0x1, (%r13)
180001e7d:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180001e85:     	movzbl	(%r13), %r8d
180001e8a:     	movq	$-0x1, %r9
180001e91:     	testb	%r8b, %r8b
180001e94:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001e9a:     	movq	0x88(%rsp), %rax
180001ea2:     	movq	%r9, 0x8(%rbx,%rax,8)
180001ea7:     	cmpb	$0x0, (%r13)
180001eac:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180001eb2:     	movq	0x88(%rsp), %rax
180001eba:     	movq	0x8(%rbx,%rax,8), %rax
180001ebf:     	movq	(%rbx), %r8
180001ec2:     	movsd	0x10(%r14,%rax,8), %xmm4
180001ec9:     	movsd	0x20(%r14,%r8,8), %xmm5
180001ed0:     	movapd	%xmm4, %xmm1
180001ed4:     	mulsd	%xmm5, %xmm1
180001ed8:     	movapd	0x74f0(%rip), %xmm2     # 0x1800093d0
180001ee0:     	andpd	%xmm1, %xmm2
180001ee4:     	ucomisd	0x74f4(%rip), %xmm2     # 0x1800093e0
180001eec:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001ef2:     	movsd	0x20(%r14,%rax,8), %xmm2
180001ef9:     	movsd	0x10(%r14,%r8,8), %xmm3
180001f00:     	movapd	%xmm2, %xmm6
180001f04:     	mulsd	%xmm3, %xmm6
180001f08:     	movapd	0x74c0(%rip), %xmm7     # 0x1800093d0
180001f10:     	andpd	%xmm6, %xmm7
180001f14:     	ucomisd	0x74c4(%rip), %xmm7     # 0x1800093e0
180001f1c:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f22:     	subsd	%xmm6, %xmm1
180001f26:     	movapd	0x74a2(%rip), %xmm6     # 0x1800093d0
180001f2e:     	andpd	%xmm1, %xmm6
180001f32:     	ucomisd	0x74a6(%rip), %xmm6     # 0x1800093e0
180001f3a:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f40:     	movsd	(%r14,%r8,8), %xmm6
180001f46:     	mulsd	%xmm6, %xmm2
180001f4a:     	movapd	0x747e(%rip), %xmm7     # 0x1800093d0
180001f52:     	andpd	%xmm2, %xmm7
180001f56:     	ucomisd	0x7482(%rip), %xmm7     # 0x1800093e0
180001f5e:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f64:     	movsd	(%r14,%rax,8), %xmm7
180001f6a:     	mulsd	%xmm7, %xmm5
180001f6e:     	movapd	0x7459(%rip), %xmm8     # 0x1800093d0
180001f77:     	andpd	%xmm5, %xmm8
180001f7c:     	ucomisd	0x745b(%rip), %xmm8     # 0x1800093e0
180001f85:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001f8b:     	subsd	%xmm5, %xmm2
180001f8f:     	movapd	0x7439(%rip), %xmm5     # 0x1800093d0
180001f97:     	andpd	%xmm2, %xmm5
180001f9b:     	ucomisd	0x743d(%rip), %xmm5     # 0x1800093e0
180001fa3:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fa9:     	mulsd	%xmm7, %xmm3
180001fad:     	movapd	0x741b(%rip), %xmm5     # 0x1800093d0
180001fb5:     	andpd	%xmm3, %xmm5
180001fb9:     	ucomisd	0x741f(%rip), %xmm5     # 0x1800093e0
180001fc1:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fc7:     	mulsd	%xmm6, %xmm4
180001fcb:     	movapd	0x73fd(%rip), %xmm5     # 0x1800093d0
180001fd3:     	andpd	%xmm4, %xmm5
180001fd7:     	ucomisd	0x7401(%rip), %xmm5     # 0x1800093e0
180001fdf:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180001fe5:     	subsd	%xmm4, %xmm3
180001fe9:     	movapd	0x73df(%rip), %xmm4     # 0x1800093d0
180001ff1:     	andpd	%xmm3, %xmm4
180001ff5:     	ucomisd	0x73e3(%rip), %xmm4     # 0x1800093e0
180001ffd:     	jae	0x1800020e0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x770>
180002003:     	movq	(%rbp), %r8
180002007:     	leaq	0x6(%r8), %rax
18000200b:     	cmpq	0x250(%rsp), %rax
180002013:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002015:     	movq	%rax, (%rbp)
180002019:     	cmpb	$0x0, (%r13)
18000201e:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002024:     	movsd	%xmm1, (%r14,%r8,8)
18000202a:     	movsd	%xmm2, 0x10(%r14,%r8,8)
180002031:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002038:     	movzbl	(%r13), %r9d
18000203d:     	xorl	%eax, %eax
18000203f:     	movl	%r9d, %r10d
180002042:     	negb	%r10b
180002045:     	sbbq	%rax, %rax
180002048:     	orq	%r8, %rax
18000204b:     	jmp	0x1800020f9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x789>
180002050:     	movq	(%rbp), %rax
180002054:     	leaq	0x6(%rax), %r9
180002058:     	cmpq	%r11, %r9
18000205b:     	jle	0x180002067 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6f7>
18000205d:     	movb	$0x2, (%r13)
180002062:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002067:     	movq	0x80(%rsp), %r8
18000206f:     	movsd	(%r14,%r8,8), %xmm2
180002075:     	movsd	0x10(%r14,%r8,8), %xmm3
18000207c:     	movsd	0x20(%r14,%r8,8), %xmm4
180002083:     	movq	%r9, (%rbp)
180002087:     	cmpb	$0x0, (%r13)
18000208c:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002092:     	movsd	0x734e(%rip), %xmm5     # 0x1800093e8
18000209a:     	divsd	%xmm1, %xmm5
18000209e:     	mulsd	%xmm5, %xmm2
1800020a2:     	mulsd	%xmm5, %xmm3
1800020a6:     	mulsd	%xmm4, %xmm5
1800020aa:     	movsd	%xmm2, (%r14,%rax,8)
1800020b0:     	movsd	%xmm3, 0x10(%r14,%rax,8)
1800020b7:     	movsd	%xmm5, 0x20(%r14,%rax,8)
1800020be:     	movzbl	(%r13), %r8d
1800020c3:     	xorl	%r9d, %r9d
1800020c6:     	movl	%r8d, %r10d
1800020c9:     	negb	%r10b
1800020cc:     	sbbq	%r9, %r9
1800020cf:     	orq	%rax, %r9
1800020d2:     	testb	%r8b, %r8b
1800020d5:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800020db:     	jmp	0x180001e9a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52a>
1800020e0:     	movb	$0x1, (%r13)
1800020e5:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
1800020ed:     	movzbl	(%r13), %r9d
1800020f2:     	movq	$-0x1, %rax
1800020f9:     	testb	%r9b, %r9b
1800020fc:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002102:     	movsd	(%r14,%rax,8), %xmm1
180002108:     	mulsd	%xmm1, %xmm1
18000210c:     	movapd	0x72bc(%rip), %xmm2     # 0x1800093d0
180002114:     	andpd	%xmm1, %xmm2
180002118:     	ucomisd	0x72c0(%rip), %xmm2     # 0x1800093e0
180002120:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
180002122:     	movsd	0x10(%r14,%rax,8), %xmm2
180002129:     	mulsd	%xmm2, %xmm2
18000212d:     	movapd	0x729b(%rip), %xmm3     # 0x1800093d0
180002135:     	andpd	%xmm2, %xmm3
180002139:     	ucomisd	0x729f(%rip), %xmm3     # 0x1800093e0
180002141:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
180002143:     	addsd	%xmm2, %xmm1
180002147:     	movapd	0x7281(%rip), %xmm2     # 0x1800093d0
18000214f:     	andpd	%xmm1, %xmm2
180002153:     	ucomisd	0x7285(%rip), %xmm2     # 0x1800093e0
18000215b:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
18000215d:     	movsd	0x20(%r14,%rax,8), %xmm2
180002164:     	mulsd	%xmm2, %xmm2
180002168:     	movapd	0x7260(%rip), %xmm3     # 0x1800093d0
180002170:     	andpd	%xmm2, %xmm3
180002174:     	ucomisd	0x7264(%rip), %xmm3     # 0x1800093e0
18000217c:     	jae	0x180002198 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x828>
18000217e:     	addsd	%xmm2, %xmm1
180002182:     	movapd	0x7246(%rip), %xmm2     # 0x1800093d0
18000218a:     	andpd	%xmm1, %xmm2
18000218e:     	ucomisd	0x724a(%rip), %xmm2     # 0x1800093e0
180002196:     	jb	0x1800021a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x839>
180002198:     	movb	$0x1, (%r13)
18000219d:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800021a5:     	xorpd	%xmm1, %xmm1
1800021a9:     	cmpb	$0x0, (%r13)
1800021ae:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800021b4:     	sqrtsd	%xmm1, %xmm1
1800021b8:     	xorpd	%xmm2, %xmm2
1800021bc:     	ucomisd	%xmm2, %xmm1
1800021c0:     	jne	0x1800023a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xa39>
1800021c6:     	jp	0x1800023a9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xa39>
1800021cc:     	movb	$0x1, (%r13)
1800021d1:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800021d9:     	movzbl	(%r13), %eax
1800021de:     	movq	$-0x1, 0x80(%rsp)
1800021ea:     	testb	%al, %al
1800021ec:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800021f2:     	movq	0x88(%rsp), %rax
1800021fa:     	movq	0x8(%rbx,%rax,8), %rax
1800021ff:     	movq	0x80(%rsp), %r8
180002207:     	movsd	0x10(%r14,%r8,8), %xmm4
18000220e:     	movsd	0x20(%r14,%rax,8), %xmm5
180002215:     	movapd	%xmm4, %xmm1
180002219:     	mulsd	%xmm5, %xmm1
18000221d:     	movapd	0x71ab(%rip), %xmm2     # 0x1800093d0
180002225:     	andpd	%xmm1, %xmm2
180002229:     	ucomisd	0x71af(%rip), %xmm2     # 0x1800093e0
180002231:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
180002237:     	movq	0x80(%rsp), %r8
18000223f:     	movsd	0x20(%r14,%r8,8), %xmm2
180002246:     	movsd	0x10(%r14,%rax,8), %xmm3
18000224d:     	movapd	%xmm2, %xmm6
180002251:     	mulsd	%xmm3, %xmm6
180002255:     	movapd	0x7173(%rip), %xmm7     # 0x1800093d0
18000225d:     	andpd	%xmm6, %xmm7
180002261:     	ucomisd	0x7177(%rip), %xmm7     # 0x1800093e0
180002269:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000226f:     	subsd	%xmm6, %xmm1
180002273:     	movapd	0x7155(%rip), %xmm6     # 0x1800093d0
18000227b:     	andpd	%xmm1, %xmm6
18000227f:     	ucomisd	0x7159(%rip), %xmm6     # 0x1800093e0
180002287:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000228d:     	movsd	(%r14,%rax,8), %xmm6
180002293:     	mulsd	%xmm6, %xmm2
180002297:     	movapd	0x7131(%rip), %xmm7     # 0x1800093d0
18000229f:     	andpd	%xmm2, %xmm7
1800022a3:     	ucomisd	0x7135(%rip), %xmm7     # 0x1800093e0
1800022ab:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022b1:     	movq	0x80(%rsp), %rax
1800022b9:     	movsd	(%r14,%rax,8), %xmm7
1800022bf:     	mulsd	%xmm7, %xmm5
1800022c3:     	movapd	0x7104(%rip), %xmm8     # 0x1800093d0
1800022cc:     	andpd	%xmm5, %xmm8
1800022d1:     	ucomisd	0x7106(%rip), %xmm8     # 0x1800093e0
1800022da:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022e0:     	subsd	%xmm5, %xmm2
1800022e4:     	movapd	0x70e4(%rip), %xmm5     # 0x1800093d0
1800022ec:     	andpd	%xmm2, %xmm5
1800022f0:     	ucomisd	0x70e8(%rip), %xmm5     # 0x1800093e0
1800022f8:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
1800022fe:     	mulsd	%xmm7, %xmm3
180002302:     	movapd	0x70c6(%rip), %xmm5     # 0x1800093d0
18000230a:     	andpd	%xmm3, %xmm5
18000230e:     	ucomisd	0x70ca(%rip), %xmm5     # 0x1800093e0
180002316:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000231c:     	mulsd	%xmm6, %xmm4
180002320:     	movapd	0x70a8(%rip), %xmm5     # 0x1800093d0
180002328:     	andpd	%xmm4, %xmm5
18000232c:     	ucomisd	0x70ac(%rip), %xmm5     # 0x1800093e0
180002334:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
18000233a:     	subsd	%xmm4, %xmm3
18000233e:     	movapd	0x708a(%rip), %xmm4     # 0x1800093d0
180002346:     	andpd	%xmm3, %xmm4
18000234a:     	ucomisd	0x708e(%rip), %xmm4     # 0x1800093e0
180002352:     	jae	0x180002437 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xac7>
180002358:     	movq	(%rbp), %r8
18000235c:     	leaq	0x6(%r8), %rax
180002360:     	cmpq	0x250(%rsp), %rax
180002368:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
18000236e:     	movq	%rax, (%rbp)
180002372:     	cmpb	$0x0, (%r13)
180002377:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000237d:     	movsd	%xmm1, (%r14,%r8,8)
180002383:     	movsd	%xmm2, 0x10(%r14,%r8,8)
18000238a:     	movsd	%xmm3, 0x20(%r14,%r8,8)
180002391:     	movzbl	(%r13), %r9d
180002396:     	xorl	%eax, %eax
180002398:     	movl	%r9d, %r10d
18000239b:     	negb	%r10b
18000239e:     	sbbq	%rax, %rax
1800023a1:     	orq	%r8, %rax
1800023a4:     	jmp	0x180002450 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xae0>
1800023a9:     	movq	(%rbp), %r8
1800023ad:     	leaq	0x6(%r8), %r9
1800023b1:     	cmpq	0x250(%rsp), %r9
1800023b9:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800023bf:     	movsd	(%r14,%rax,8), %xmm2
1800023c5:     	movsd	0x10(%r14,%rax,8), %xmm3
1800023cc:     	movsd	0x20(%r14,%rax,8), %xmm4
1800023d3:     	movq	%r9, (%rbp)
1800023d7:     	cmpb	$0x0, (%r13)
1800023dc:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800023e2:     	movsd	0x6ffe(%rip), %xmm5     # 0x1800093e8
1800023ea:     	divsd	%xmm1, %xmm5
1800023ee:     	mulsd	%xmm5, %xmm2
1800023f2:     	mulsd	%xmm5, %xmm3
1800023f6:     	mulsd	%xmm4, %xmm5
1800023fa:     	movsd	%xmm2, (%r14,%r8,8)
180002400:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002407:     	movsd	%xmm5, 0x20(%r14,%r8,8)
18000240e:     	movzbl	(%r13), %eax
180002413:     	xorl	%r10d, %r10d
180002416:     	movl	%eax, %r9d
180002419:     	negb	%r9b
18000241c:     	sbbq	%r10, %r10
18000241f:     	orq	%r8, %r10
180002422:     	movq	%r10, 0x80(%rsp)
18000242a:     	testb	%al, %al
18000242c:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002432:     	jmp	0x1800021f2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x882>
180002437:     	movb	$0x1, (%r13)
18000243c:     	movq	$0x2dc6c3, 0x18(%rbp)   # imm = 0x2DC6C3
180002444:     	movzbl	(%r13), %r9d
180002449:     	movq	$-0x1, %rax
180002450:     	testb	%r9b, %r9b
180002453:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002459:     	movsd	(%r14,%rax,8), %xmm1
18000245f:     	mulsd	%xmm1, %xmm1
180002463:     	movapd	0x6f65(%rip), %xmm2     # 0x1800093d0
18000246b:     	andpd	%xmm1, %xmm2
18000246f:     	ucomisd	0x6f69(%rip), %xmm2     # 0x1800093e0
180002477:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
180002479:     	movsd	0x10(%r14,%rax,8), %xmm2
180002480:     	mulsd	%xmm2, %xmm2
180002484:     	movapd	0x6f44(%rip), %xmm3     # 0x1800093d0
18000248c:     	andpd	%xmm2, %xmm3
180002490:     	ucomisd	0x6f48(%rip), %xmm3     # 0x1800093e0
180002498:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
18000249a:     	addsd	%xmm2, %xmm1
18000249e:     	movapd	0x6f2a(%rip), %xmm2     # 0x1800093d0
1800024a6:     	andpd	%xmm1, %xmm2
1800024aa:     	ucomisd	0x6f2e(%rip), %xmm2     # 0x1800093e0
1800024b2:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
1800024b4:     	movsd	0x20(%r14,%rax,8), %xmm2
1800024bb:     	mulsd	%xmm2, %xmm2
1800024bf:     	movapd	0x6f09(%rip), %xmm3     # 0x1800093d0
1800024c7:     	andpd	%xmm2, %xmm3
1800024cb:     	ucomisd	0x6f0d(%rip), %xmm3     # 0x1800093e0
1800024d3:     	jae	0x1800024ef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb7f>
1800024d5:     	addsd	%xmm2, %xmm1
1800024d9:     	movapd	0x6eef(%rip), %xmm2     # 0x1800093d0
1800024e1:     	andpd	%xmm1, %xmm2
1800024e5:     	ucomisd	0x6ef3(%rip), %xmm2     # 0x1800093e0
1800024ed:     	jb	0x180002500 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xb90>
1800024ef:     	movb	$0x1, (%r13)
1800024f4:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
1800024fc:     	xorpd	%xmm1, %xmm1
180002500:     	cmpb	$0x0, (%r13)
180002505:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000250b:     	sqrtsd	%xmm1, %xmm1
18000250f:     	xorpd	%xmm2, %xmm2
180002513:     	ucomisd	%xmm2, %xmm1
180002517:     	jne	0x180002e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14e5>
18000251d:     	jp	0x180002e55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14e5>
180002523:     	movb	$0x1, (%r13)
180002528:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
180002530:     	movzbl	(%r13), %eax
180002535:     	movq	$-0x8, 0xa8(%rsp)
180002541:     	testb	%al, %al
180002543:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002549:     	movq	0x8(%rbx,%r12,8), %rax
18000254e:     	movq	%rax, 0x110(%rsp)
180002556:     	testq	%rax, %rax
180002559:     	jle	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
18000255f:     	movsd	0x6e61(%rip), %xmm6     # 0x1800093c8
180002567:     	movapd	%xmm0, %xmm8
18000256c:     	mulsd	%xmm0, %xmm6
180002570:     	movapd	%xmm0, %xmm7
180002574:     	addsd	%xmm0, %xmm8
180002579:     	cvtsi2sd	%rcx, %xmm0
18000257e:     	divsd	%xmm0, %xmm8
180002583:     	movapd	%xmm6, %xmm9
180002588:     	addsd	%xmm6, %xmm9
18000258d:     	xorps	%xmm0, %xmm0
180002590:     	cvtsi2sd	%rdx, %xmm0
180002595:     	divsd	%xmm0, %xmm9
18000259a:     	movq	$-0x1, 0xa0(%rsp)
1800025a6:     	movapd	0x6e21(%rip), %xmm10    # 0x1800093d0
1800025af:     	movsd	0x6e28(%rip), %xmm11    # 0x1800093e0
1800025b8:     	xorpd	%xmm12, %xmm12
1800025bd:     	movsd	0x6e2a(%rip), %xmm13    # 0x1800093f0
1800025c6:     	movsd	0x6e31(%rip), %xmm15    # 0x180009400
1800025cf:     	movq	$0x0, 0x98(%rsp)
1800025db:     	movq	0x98(%rsp), %rcx
1800025e3:     	leaq	0x1(%rcx), %rax
1800025e7:     	movq	%rax, 0x98(%rsp)
1800025ef:     	movq	0x10(%rbx,%r12,8), %rdx
1800025f4:     	testq	%rdx, %rdx
1800025f7:     	movl	$0x0, %eax
1800025fc:     	cmovleq	%rax, %rdx
180002600:     	movq	%rdx, 0x120(%rsp)
180002608:     	movq	%rcx, 0x118(%rsp)
180002610:     	xorps	%xmm14, %xmm14
180002614:     	cvtsi2sd	%rcx, %xmm14
180002619:     	mulsd	%xmm9, %xmm14
18000261e:     	subsd	%xmm6, %xmm14
180002623:     	movq	$0x0, 0x90(%rsp)
18000262f:     	movq	0x90(%rsp), %rax
180002637:     	cmpq	%rax, 0x120(%rsp)
18000263f:     	je	0x180002e32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14c2>
180002645:     	movq	(%rbp), %rdx
180002649:     	leaq	0x6(%rdx), %rax
18000264d:     	cmpq	0x250(%rsp), %rax
180002655:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
18000265b:     	movq	0x80(%rsp), %rcx
180002663:     	movsd	(%r14,%rcx,8), %xmm0
180002669:     	movsd	0x10(%r14,%rcx,8), %xmm1
180002670:     	movsd	0x20(%r14,%rcx,8), %xmm2
180002677:     	movq	%rax, (%rbp)
18000267b:     	cmpb	$0x0, (%r13)
180002680:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002686:     	xorps	%xmm3, %xmm3
180002689:     	cvtsi2sdq	0x90(%rsp), %xmm3
180002693:     	mulsd	%xmm8, %xmm3
180002698:     	subsd	%xmm7, %xmm3
18000269c:     	mulsd	%xmm3, %xmm0
1800026a0:     	mulsd	%xmm3, %xmm1
1800026a4:     	mulsd	%xmm2, %xmm3
1800026a8:     	movsd	%xmm0, (%r14,%rdx,8)
1800026ae:     	movsd	%xmm1, 0x10(%r14,%rdx,8)
1800026b5:     	movsd	%xmm3, 0x20(%r14,%rdx,8)
1800026bc:     	cmpb	$0x0, (%r13)
1800026c1:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800026c7:     	movq	(%rbp), %rax
1800026cb:     	leaq	0x6(%rax), %rcx
1800026cf:     	cmpq	0x250(%rsp), %rcx
1800026d7:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800026dd:     	movq	0xa8(%rsp), %r8
1800026e5:     	movsd	(%r14,%r8), %xmm0
1800026eb:     	movsd	0x10(%r14,%r8), %xmm1
1800026f2:     	movsd	0x20(%r14,%r8), %xmm2
1800026f9:     	movq	%rcx, (%rbp)
1800026fd:     	cmpb	$0x0, (%r13)
180002702:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002708:     	mulsd	%xmm14, %xmm0
18000270d:     	mulsd	%xmm14, %xmm1
180002712:     	mulsd	%xmm14, %xmm2
180002717:     	movsd	%xmm0, (%r14,%rax,8)
18000271d:     	movsd	%xmm1, 0x10(%r14,%rax,8)
180002724:     	movsd	%xmm2, 0x20(%r14,%rax,8)
18000272b:     	cmpb	$0x0, (%r13)
180002730:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002736:     	movq	0x88(%rsp), %r8
18000273e:     	movq	(%rbx,%r8,8), %rcx
180002742:     	movq	0x8(%rbx,%r8,8), %r8
180002747:     	movsd	(%r14,%r8,8), %xmm0
18000274d:     	addsd	(%r14,%rdx,8), %xmm0
180002753:     	movapd	%xmm0, %xmm1
180002757:     	andpd	%xmm10, %xmm1
18000275c:     	ucomisd	%xmm11, %xmm1
180002761:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
180002767:     	movsd	0x10(%r14,%r8,8), %xmm1
18000276e:     	addsd	0x10(%r14,%rdx,8), %xmm1
180002775:     	movapd	%xmm1, %xmm2
180002779:     	andpd	%xmm10, %xmm2
18000277e:     	ucomisd	%xmm11, %xmm2
180002783:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
180002785:     	movsd	0x20(%r14,%r8,8), %xmm2
18000278c:     	addsd	0x20(%r14,%rdx,8), %xmm2
180002793:     	movapd	%xmm2, %xmm3
180002797:     	andpd	%xmm10, %xmm3
18000279c:     	ucomisd	%xmm11, %xmm3
1800027a1:     	jae	0x1800027f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe83>
1800027a3:     	movq	(%rbp), %r8
1800027a7:     	leaq	0x6(%r8), %rdx
1800027ab:     	cmpq	0x250(%rsp), %rdx
1800027b3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800027b9:     	movq	%rdx, (%rbp)
1800027bd:     	cmpb	$0x0, (%r13)
1800027c2:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800027c8:     	movsd	%xmm0, (%r14,%r8,8)
1800027ce:     	movsd	%xmm1, 0x10(%r14,%r8,8)
1800027d5:     	movsd	%xmm2, 0x20(%r14,%r8,8)
1800027dc:     	movzbl	(%r13), %r9d
1800027e1:     	movl	%r9d, %edx
1800027e4:     	negb	%dl
1800027e6:     	movl	$0x0, %edx
1800027eb:     	sbbq	%rdx, %rdx
1800027ee:     	orq	%r8, %rdx
1800027f1:     	jmp	0x18000280c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xe9c>
1800027f3:     	movb	$0x1, (%r13)
1800027f8:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
180002800:     	movzbl	(%r13), %r9d
180002805:     	movq	$-0x1, %rdx
18000280c:     	testb	%r9b, %r9b
18000280f:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002815:     	movsd	(%r14,%rdx,8), %xmm0
18000281b:     	addsd	(%r14,%rax,8), %xmm0
180002821:     	movapd	%xmm0, %xmm1
180002825:     	andpd	%xmm10, %xmm1
18000282a:     	ucomisd	%xmm11, %xmm1
18000282f:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002835:     	movsd	0x10(%r14,%rdx,8), %xmm1
18000283c:     	addsd	0x10(%r14,%rax,8), %xmm1
180002843:     	movapd	%xmm1, %xmm2
180002847:     	andpd	%xmm10, %xmm2
18000284c:     	ucomisd	%xmm11, %xmm2
180002851:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002853:     	movsd	0x20(%r14,%rdx,8), %xmm2
18000285a:     	addsd	0x20(%r14,%rax,8), %xmm2
180002861:     	movapd	%xmm2, %xmm3
180002865:     	andpd	%xmm10, %xmm3
18000286a:     	ucomisd	%xmm11, %xmm3
18000286f:     	jae	0x1800028c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf51>
180002871:     	movq	(%rbp), %rax
180002875:     	leaq	0x6(%rax), %rdx
180002879:     	cmpq	0x250(%rsp), %rdx
180002881:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002887:     	movq	%rdx, (%rbp)
18000288b:     	cmpb	$0x0, (%r13)
180002890:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002896:     	movsd	%xmm0, (%r14,%rax,8)
18000289c:     	movsd	%xmm1, 0x10(%r14,%rax,8)
1800028a3:     	movsd	%xmm2, 0x20(%r14,%rax,8)
1800028aa:     	movzbl	(%r13), %r8d
1800028af:     	movl	%r8d, %edx
1800028b2:     	negb	%dl
1800028b4:     	movl	$0x0, %edx
1800028b9:     	sbbq	%rdx, %rdx
1800028bc:     	orq	%rax, %rdx
1800028bf:     	jmp	0x1800028da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xf6a>
1800028c1:     	movb	$0x1, (%r13)
1800028c6:     	movq	$0x5b8d85, 0x18(%rbp)   # imm = 0x5B8D85
1800028ce:     	movzbl	(%r13), %r8d
1800028d3:     	movq	$-0x1, %rdx
1800028da:     	testb	%r8b, %r8b
1800028dd:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800028e3:     	movq	(%rbp), %rax
1800028e7:     	leaq	0x2(%rax), %r8
1800028eb:     	cmpq	0x250(%rsp), %r8
1800028f3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800028f9:     	movq	%r8, (%rbp)
1800028fd:     	cmpb	$0x0, (%r13)
180002902:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002908:     	movq	%rcx, (%rbx,%rax,8)
18000290c:     	cmpb	$0x0, (%r13)
180002911:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002917:     	movsd	(%r14,%rdx,8), %xmm0
18000291d:     	mulsd	%xmm0, %xmm0
180002921:     	movapd	%xmm0, %xmm1
180002925:     	andpd	%xmm10, %xmm1
18000292a:     	ucomisd	%xmm11, %xmm1
18000292f:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
180002931:     	movsd	0x10(%r14,%rdx,8), %xmm1
180002938:     	mulsd	%xmm1, %xmm1
18000293c:     	movapd	%xmm1, %xmm2
180002940:     	andpd	%xmm10, %xmm2
180002945:     	ucomisd	%xmm11, %xmm2
18000294a:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
18000294c:     	addsd	%xmm1, %xmm0
180002950:     	movapd	%xmm0, %xmm1
180002954:     	andpd	%xmm10, %xmm1
180002959:     	ucomisd	%xmm11, %xmm1
18000295e:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
180002960:     	movsd	0x20(%r14,%rdx,8), %xmm1
180002967:     	mulsd	%xmm1, %xmm1
18000296b:     	movapd	%xmm1, %xmm2
18000296f:     	andpd	%xmm10, %xmm2
180002974:     	ucomisd	%xmm11, %xmm2
180002979:     	jae	0x18000298f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x101f>
18000297b:     	addsd	%xmm1, %xmm0
18000297f:     	movapd	%xmm0, %xmm1
180002983:     	andpd	%xmm10, %xmm1
180002988:     	ucomisd	%xmm11, %xmm1
18000298d:     	jb	0x1800029a0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1030>
18000298f:     	movb	$0x1, (%r13)
180002994:     	movq	$0x14fb183, 0x18(%rbp)  # imm = 0x14FB183
18000299c:     	xorpd	%xmm0, %xmm0
1800029a0:     	cmpb	$0x0, (%r13)
1800029a5:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
1800029ab:     	sqrtsd	%xmm0, %xmm0
1800029af:     	ucomisd	%xmm12, %xmm0
1800029b4:     	jne	0x1800029d3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1063>
1800029b6:     	jp	0x1800029d3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1063>
1800029b8:     	movb	$0x1, (%r13)
1800029bd:     	movq	$0x3d0902, 0x18(%rbp)   # imm = 0x3D0902
1800029c5:     	movzbl	(%r13), %edx
1800029ca:     	movq	$-0x1, %r8
1800029d1:     	jmp	0x180002a4f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x10df>
1800029d3:     	movq	(%rbp), %rcx
1800029d7:     	leaq	0x6(%rcx), %r8
1800029db:     	cmpq	0x250(%rsp), %r8
1800029e3:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
1800029e9:     	movsd	(%r14,%rdx,8), %xmm1
1800029ef:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800029f6:     	movsd	0x20(%r14,%rdx,8), %xmm3
1800029fd:     	movq	%r8, (%rbp)
180002a01:     	cmpb	$0x0, (%r13)
180002a06:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a0c:     	movsd	0x69d4(%rip), %xmm4     # 0x1800093e8
180002a14:     	divsd	%xmm0, %xmm4
180002a18:     	mulsd	%xmm4, %xmm1
180002a1c:     	mulsd	%xmm4, %xmm2
180002a20:     	mulsd	%xmm3, %xmm4
180002a24:     	movsd	%xmm1, (%r14,%rcx,8)
180002a2a:     	movsd	%xmm2, 0x10(%r14,%rcx,8)
180002a31:     	movsd	%xmm4, 0x20(%r14,%rcx,8)
180002a38:     	movzbl	(%r13), %edx
180002a3d:     	movl	%edx, %r8d
180002a40:     	negb	%r8b
180002a43:     	movl	$0x0, %r8d
180002a49:     	sbbq	%r8, %r8
180002a4c:     	orq	%rcx, %r8
180002a4f:     	testb	%dl, %dl
180002a51:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a57:     	movq	%r8, 0x8(%rbx,%rax,8)
180002a5c:     	cmpb	$0x0, (%r13)
180002a61:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002a67:     	movq	0x8(%rbp), %rcx
180002a6b:     	leaq	0x1(%rcx), %rdx
180002a6f:     	movq	%rdx, 0x8(%rbp)
180002a73:     	cmpq	0x10(%rbp), %rcx
180002a77:     	jge	0x180002ee9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1579>
180002a7d:     	movq	$0x0, 0xb0(%rsp)
180002a89:     	movb	$0x0, 0xb8(%rsp)
180002a91:     	movq	$0x0, 0xc0(%rsp)
180002a9d:     	movb	$0x0, 0xc8(%rsp)
180002aa5:     	movq	$0x0, 0xd0(%rsp)
180002ab1:     	movb	$0x0, 0xd8(%rsp)
180002ab9:     	movq	$0x0, 0xe0(%rsp)
180002ac5:     	movb	$0x0, 0xe8(%rsp)
180002acd:     	movq	$0x0, 0xf0(%rsp)
180002ad9:     	movb	$0x0, 0xf8(%rsp)
180002ae1:     	movq	$0x0, 0x100(%rsp)
180002aed:     	movb	$0x0, 0x108(%rsp)
180002af5:     	movq	%rax, 0x48(%rsp)
180002afa:     	movq	%r15, 0x40(%rsp)
180002aff:     	movq	0x250(%rsp), %rax
180002b07:     	movq	%rax, 0x30(%rsp)
180002b0c:     	movq	%r13, 0x28(%rsp)
180002b11:     	movq	%rbp, 0x20(%rsp)
180002b16:     	movq	$-0x1, 0x70(%rsp)
180002b1f:     	movq	$-0x1, 0x68(%rsp)
180002b28:     	movq	$-0x1, 0x60(%rsp)
180002b31:     	movq	$-0x1, 0x58(%rsp)
180002b3a:     	movq	$-0x1, 0x50(%rsp)
180002b43:     	movq	$0x0, 0x38(%rsp)
180002b4c:     	leaq	0xb0(%rsp), %rcx
180002b54:     	leaq	0x128(%rsp), %rdx
180002b5c:     	movq	%r14, %r8
180002b5f:     	movq	%rbx, %r9
180002b62:     	callq	0x180002f10 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x15a0>
180002b67:     	testl	%eax, %eax
180002b69:     	jne	0x180002efb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x158b>
180002b6f:     	cmpb	$0x0, (%r13)
180002b74:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002b7a:     	movsd	0xb0(%rsp), %xmm2
180002b83:     	movsd	0xc0(%rsp), %xmm1
180002b8c:     	movsd	0xd0(%rsp), %xmm0
180002b95:     	decq	0x8(%rbp)
180002b99:     	movq	0x8(%rbx,%r12,8), %rax
180002b9e:     	movq	%rax, %rcx
180002ba1:     	subq	0x118(%rsp), %rcx
180002ba9:     	movq	%rcx, %rdx
180002bac:     	notq	%rdx
180002baf:     	testq	%rdx, %rax
180002bb2:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bb8:     	cmpb	$0x0, (%r13)
180002bbd:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002bc3:     	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
180002bcd:     	cmpq	%rdx, %rcx
180002bd0:     	je	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bd6:     	decq	%rcx
180002bd9:     	movq	0x10(%rbx,%r12,8), %rdx
180002bde:     	cvtsi2sd	%rcx, %xmm3
180002be3:     	cvtsi2sd	%rdx, %xmm4
180002be8:     	mulsd	%xmm3, %xmm4
180002bec:     	andpd	%xmm10, %xmm4
180002bf1:     	ucomisd	%xmm13, %xmm4
180002bf6:     	jae	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002bfc:     	imulq	%rdx, %rcx
180002c00:     	addq	0xa0(%rsp), %rax
180002c08:     	imulq	%rdx, %rax
180002c0c:     	movq	0x90(%rsp), %r8
180002c14:     	addq	%r8, %rax
180002c17:     	xorq	%rax, %rcx
180002c1a:     	movq	%rax, %rdx
180002c1d:     	xorq	%r8, %rdx
180002c20:     	testq	%rdx, %rcx
180002c23:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002c29:     	xorps	%xmm3, %xmm3
180002c2c:     	cvtsi2sd	%rax, %xmm3
180002c31:     	mulsd	0x67bf(%rip), %xmm3     # 0x1800093f8
180002c39:     	andpd	%xmm10, %xmm3
180002c3e:     	ucomisd	%xmm13, %xmm3
180002c43:     	jae	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002c49:     	mulsd	%xmm15, %xmm2
180002c4e:     	movapd	%xmm2, %xmm3
180002c52:     	andpd	%xmm10, %xmm3
180002c57:     	ucomisd	%xmm11, %xmm3
180002c5c:     	jae	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002c62:     	movsd	0x679e(%rip), %xmm4     # 0x180009408
180002c6a:     	ucomisd	%xmm3, %xmm4
180002c6e:     	jbe	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002c74:     	leaq	(%rax,%rax,2), %rcx
180002c78:     	cvttsd2si	%xmm2, %rdx
180002c7d:     	testq	%rdx, %rdx
180002c80:     	movl	$0x0, %r8d
180002c86:     	cmovleq	%r8, %rdx
180002c8a:     	cmpq	$0xff, %rdx
180002c91:     	movl	$0xff, %r8d
180002c97:     	cmovgeq	%r8, %rdx
180002c9b:     	movq	(%rbx,%r12,8), %r8
180002c9f:     	movq	(%rbx,%r8,8), %r10
180002ca3:     	testq	%rax, %rax
180002ca6:     	movq	%rcx, %r9
180002ca9:     	jns	0x180002cb7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1347>
180002cab:     	movq	%r10, %r9
180002cae:     	addq	%rcx, %r9
180002cb1:     	js	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002cb7:     	cmpq	%r10, %r9
180002cba:     	jge	0x180002def <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x147f>
180002cc0:     	movq	0x10(%rbx,%r8,8), %r8
180002cc5:     	leaq	(%rbx,%r8,8), %r8
180002cc9:     	movq	%rdx, (%r8,%r9,8)
180002ccd:     	mulsd	%xmm15, %xmm1
180002cd2:     	movapd	%xmm1, %xmm2
180002cd6:     	andpd	%xmm10, %xmm2
180002cdb:     	ucomisd	%xmm11, %xmm2
180002ce0:     	jae	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002ce6:     	movsd	0x671a(%rip), %xmm3     # 0x180009408
180002cee:     	ucomisd	%xmm2, %xmm3
180002cf2:     	jbe	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002cf8:     	cvttsd2si	%xmm1, %r8
180002cfd:     	testq	%r8, %r8
180002d00:     	movl	$0x0, %edx
180002d05:     	cmovleq	%rdx, %r8
180002d09:     	cmpq	$0xff, %r8
180002d10:     	movl	$0xff, %edx
180002d15:     	cmovgeq	%rdx, %r8
180002d19:     	leaq	0x1(%rcx), %r9
180002d1d:     	movq	%rcx, %rdx
180002d20:     	notq	%rdx
180002d23:     	testq	%rdx, %r9
180002d26:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002d2c:     	cmpb	$0x0, (%r13)
180002d31:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002d37:     	movq	(%rbx,%r12,8), %r10
180002d3b:     	testq	%rax, %rax
180002d3e:     	movq	(%rbx,%r10,8), %r11
180002d42:     	jns	0x180002d4d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x13dd>
180002d44:     	addq	%r11, %r9
180002d47:     	js	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002d4d:     	cmpq	%r11, %r9
180002d50:     	jge	0x180002e14 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14a4>
180002d56:     	movq	0x10(%rbx,%r10,8), %r10
180002d5b:     	leaq	(%rbx,%r10,8), %r10
180002d5f:     	movq	%r8, (%r10,%r9,8)
180002d63:     	mulsd	%xmm15, %xmm0
180002d68:     	movapd	%xmm0, %xmm1
180002d6c:     	andpd	%xmm10, %xmm1
180002d71:     	ucomisd	%xmm11, %xmm1
180002d76:     	jae	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002d7c:     	movsd	0x6684(%rip), %xmm2     # 0x180009408
180002d84:     	ucomisd	%xmm1, %xmm2
180002d88:     	jbe	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002d8e:     	cvttsd2si	%xmm0, %r8
180002d93:     	testq	%r8, %r8
180002d96:     	movl	$0x0, %r9d
180002d9c:     	cmovleq	%r9, %r8
180002da0:     	cmpq	$0xff, %r8
180002da7:     	movl	$0xff, %r9d
180002dad:     	cmovgeq	%r9, %r8
180002db1:     	addq	$0x2, %rcx
180002db5:     	testq	%rdx, %rcx
180002db8:     	js	0x180001b69 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f9>
180002dbe:     	cmpb	$0x0, (%r13)
180002dc3:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002dc9:     	movq	(%rbx,%r12,8), %rdx
180002dcd:     	testq	%rax, %rax
180002dd0:     	movq	(%rbx,%rdx,8), %rax
180002dd4:     	jns	0x180002ddb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x146b>
180002dd6:     	addq	%rax, %rcx
180002dd9:     	js	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002ddb:     	cmpq	%rax, %rcx
180002dde:     	jge	0x180002e23 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x14b3>
180002de0:     	movq	0x10(%rbx,%rdx,8), %rax
180002de5:     	leaq	(%rbx,%rax,8), %rax
180002de9:     	movq	%r8, (%rax,%rcx,8)
180002ded:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002def:     	movb	$0x1, (%r13)
180002df4:     	movq	$0x7a1203, 0x18(%rbp)   # imm = 0x7A1203
180002dfc:     	incq	0x90(%rsp)
180002e04:     	cmpb	$0x0, (%r13)
180002e09:     	je	0x18000262f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xcbf>
180002e0f:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e14:     	movb	$0x1, (%r13)
180002e19:     	movq	$0x7a1204, 0x18(%rbp)   # imm = 0x7A1204
180002e21:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002e23:     	movb	$0x1, (%r13)
180002e28:     	movq	$0x7a1205, 0x18(%rbp)   # imm = 0x7A1205
180002e30:     	jmp	0x180002dfc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x148c>
180002e32:     	decq	0xa0(%rsp)
180002e3a:     	movq	0x98(%rsp), %rax
180002e42:     	cmpq	0x110(%rsp), %rax
180002e4a:     	jne	0x1800025db <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xc6b>
180002e50:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e55:     	movq	(%rbp), %r8
180002e59:     	leaq	0x6(%r8), %r9
180002e5d:     	cmpq	0x250(%rsp), %r9
180002e65:     	jg	0x18000205d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x6ed>
180002e6b:     	movsd	(%r14,%rax,8), %xmm2
180002e71:     	movsd	0x10(%r14,%rax,8), %xmm3
180002e78:     	movsd	0x20(%r14,%rax,8), %xmm4
180002e7f:     	movq	%r9, (%rbp)
180002e83:     	cmpb	$0x0, (%r13)
180002e88:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002e8e:     	movsd	0x6552(%rip), %xmm5     # 0x1800093e8
180002e96:     	divsd	%xmm1, %xmm5
180002e9a:     	mulsd	%xmm5, %xmm2
180002e9e:     	mulsd	%xmm5, %xmm3
180002ea2:     	mulsd	%xmm4, %xmm5
180002ea6:     	leaq	(,%r8,8), %r9
180002eae:     	movsd	%xmm2, (%r14,%r8,8)
180002eb4:     	movsd	%xmm3, 0x10(%r14,%r8,8)
180002ebb:     	movsd	%xmm5, 0x20(%r14,%r8,8)
180002ec2:     	movzbl	(%r13), %eax
180002ec7:     	testb	%al, %al
180002ec9:     	movq	$-0x8, %r8
180002ed0:     	cmoveq	%r9, %r8
180002ed4:     	movq	%r8, 0xa8(%rsp)
180002edc:     	testb	%al, %al
180002ede:     	jne	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002ee4:     	jmp	0x180002549 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0xbd9>
180002ee9:     	movb	$0x1, (%r13)
180002eee:     	movq	$0x13, 0x18(%rbp)
180002ef6:     	jmp	0x180001b7d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20d>
180002efb:     	movq	%rdi, %rsi
180002efe:     	jmp	0x180001b7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x20f>
180002f03:     	nopw	%cs:(%rax,%rax)
180002f0d:     	nopl	(%rax)
180002f10:     	pushq	%r15
180002f12:     	pushq	%r14
180002f14:     	pushq	%r13
180002f16:     	pushq	%r12
180002f18:     	pushq	%rsi
180002f19:     	pushq	%rdi
180002f1a:     	pushq	%rbp
180002f1b:     	pushq	%rbx
180002f1c:     	subq	$0x2a8, %rsp            # imm = 0x2A8
180002f23:     	movapd	%xmm15, 0x290(%rsp)
180002f2d:     	movapd	%xmm14, 0x280(%rsp)
180002f37:     	movapd	%xmm13, 0x270(%rsp)
180002f41:     	movapd	%xmm12, 0x260(%rsp)
180002f4b:     	movapd	%xmm11, 0x250(%rsp)
180002f55:     	movapd	%xmm10, 0x240(%rsp)
180002f5f:     	movapd	%xmm9, 0x230(%rsp)
180002f69:     	movapd	%xmm8, 0x220(%rsp)
180002f73:     	movapd	%xmm7, 0x210(%rsp)
180002f7c:     	movapd	%xmm6, 0x200(%rsp)
180002f85:     	movq	0x328(%rsp), %rax
180002f8d:     	movq	0x320(%rsp), %r15
180002f95:     	movq	0x318(%rsp), %rbx
180002f9d:     	movq	0x310(%rsp), %r14
180002fa5:     	movq	$0x0, 0x198(%rsp)
180002fb1:     	movb	$0x0, 0x1a0(%rsp)
180002fb9:     	movq	$0x0, 0x1a8(%rsp)
180002fc5:     	movb	$0x0, 0x1b0(%rsp)
180002fcd:     	movq	$0x0, 0x1b8(%rsp)
180002fd9:     	movb	$0x0, 0x1c0(%rsp)
180002fe1:     	movq	$0x0, 0x1c8(%rsp)
180002fed:     	movb	$0x0, 0x1d0(%rsp)
180002ff5:     	movq	$0x0, 0x1d8(%rsp)
180003001:     	movb	$0x0, 0x1e0(%rsp)
180003009:     	movq	$0x0, 0x1e8(%rsp)
180003015:     	movb	$0x0, 0x1f0(%rsp)
18000301d:     	movq	$0x0, 0x138(%rsp)
180003029:     	movb	$0x0, 0x140(%rsp)
180003031:     	movq	$0x0, 0x148(%rsp)
18000303d:     	movb	$0x0, 0x150(%rsp)
180003045:     	movq	$0x0, 0x158(%rsp)
180003051:     	movb	$0x0, 0x160(%rsp)
180003059:     	movq	$0x0, 0x168(%rsp)
180003065:     	movb	$0x0, 0x170(%rsp)
18000306d:     	movq	$0x0, 0x178(%rsp)
180003079:     	movb	$0x0, 0x180(%rsp)
180003081:     	movq	$0x0, 0x188(%rsp)
18000308d:     	movb	$0x0, 0x190(%rsp)
180003095:     	cmpq	$0x1, %rax
180003099:     	je	0x180003100 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1790>
18000309b:     	testq	%rax, %rax
18000309e:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800030a4:     	movq	0x330(%rsp), %rdi
1800030ac:     	movq	0x28(%r9,%rdi,8), %rdx
1800030b1:     	cmpq	$0x3, %rdx
1800030b5:     	jle	0x180003202 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1892>
1800030bb:     	movb	$0x0, 0x58(%rcx)
1800030bf:     	movq	$0x0, 0x50(%rcx)
1800030c7:     	movb	$0x0, 0x48(%rcx)
1800030cb:     	movq	$0x0, 0x40(%rcx)
1800030d3:     	movb	$0x0, 0x38(%rcx)
1800030d7:     	movq	$0x0, 0x30(%rcx)
1800030df:     	movb	$0x1, 0x28(%rcx)
1800030e3:     	movq	$0x0, 0x20(%rcx)
1800030eb:     	movb	$0x1, 0x18(%rcx)
1800030ef:     	movq	$0x0, 0x10(%rcx)
1800030f7:     	movb	$0x1, 0x8(%rcx)
1800030fb:     	jmp	0x1800057d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e60>
180003100:     	movq	0x358(%rsp), %r13
180003108:     	movq	0x340(%rsp), %r12
180003110:     	movq	%r12, %rdx
180003113:     	sarq	$0x3f, %rdx
180003117:     	andq	%r15, %rdx
18000311a:     	leaq	(%r9,%r12,8), %rax
18000311e:     	movq	(%rax,%rdx,8), %rdx
180003122:     	testq	%rdx, %rdx
180003125:     	je	0x180003be9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2279>
18000312b:     	cmpq	$0x1, %rdx
18000312f:     	jne	0x180003c2f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22bf>
180003135:     	cmpb	$0x0, (%rbx)
180003138:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000313e:     	movq	0x8(%r9), %rdx
180003142:     	movsd	(%r8,%r13,8), %xmm0
180003148:     	subsd	(%r8,%rdx,8), %xmm0
18000314e:     	movapd	0x627a(%rip), %xmm1     # 0x1800093d0
180003156:     	andpd	%xmm0, %xmm1
18000315a:     	ucomisd	0x627e(%rip), %xmm1     # 0x1800093e0
180003162:     	jae	0x180003c3f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22cf>
180003168:     	movsd	0x10(%r8,%r13,8), %xmm1
18000316f:     	subsd	0x10(%r8,%rdx,8), %xmm1
180003176:     	movapd	0x6252(%rip), %xmm2     # 0x1800093d0
18000317e:     	andpd	%xmm1, %xmm2
180003182:     	ucomisd	0x6256(%rip), %xmm2     # 0x1800093e0
18000318a:     	jae	0x180003c3f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22cf>
180003190:     	movsd	0x20(%r8,%r13,8), %xmm2
180003197:     	subsd	0x20(%r8,%rdx,8), %xmm2
18000319e:     	movapd	0x622a(%rip), %xmm3     # 0x1800093d0
1800031a6:     	andpd	%xmm2, %xmm3
1800031aa:     	ucomisd	0x622e(%rip), %xmm3     # 0x1800093e0
1800031b2:     	jae	0x180003c3f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22cf>
1800031b8:     	movq	(%r14), %r11
1800031bb:     	leaq	0x6(%r11), %rdx
1800031bf:     	movb	$0x2, %r10b
1800031c2:     	cmpq	%r15, %rdx
1800031c5:     	jg	0x180003e77 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2507>
1800031cb:     	movq	%rdx, (%r14)
1800031ce:     	cmpb	$0x0, (%rbx)
1800031d1:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800031d7:     	movsd	%xmm0, (%r8,%r11,8)
1800031dd:     	movsd	%xmm1, 0x10(%r8,%r11,8)
1800031e4:     	movsd	%xmm2, 0x20(%r8,%r11,8)
1800031eb:     	movzbl	(%rbx), %r10d
1800031ef:     	xorl	%edx, %edx
1800031f1:     	movl	%r10d, %esi
1800031f4:     	negb	%sil
1800031f7:     	sbbq	%rdx, %rdx
1800031fa:     	orq	%r11, %rdx
1800031fd:     	jmp	0x180003c55 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22e5>
180003202:     	leaq	0x1(%rdx), %rax
180003206:     	notq	%rdx
180003209:     	testq	%rdx, %rax
18000320c:     	js	0x180005775 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e05>
180003212:     	cmpb	$0x0, (%rbx)
180003215:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000321b:     	movq	%rax, 0x28(%r9,%rdi,8)
180003220:     	movq	(%r14), %rax
180003223:     	cmpq	%r15, %rax
180003226:     	movq	%rax, %rdx
180003229:     	jle	0x180003233 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x18c3>
18000322b:     	movb	$0x2, (%rbx)
18000322e:     	movq	(%r14), %rax
180003231:     	xorl	%edx, %edx
180003233:     	leaq	0x3(%rax), %r10
180003237:     	cmpq	%r15, %r10
18000323a:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180003240:     	movq	%r10, (%r14)
180003243:     	cmpb	$0x0, (%rbx)
180003246:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000324c:     	movq	%rax, %r12
18000324f:     	sarq	$0x3f, %r12
180003253:     	andq	%r15, %r12
180003256:     	leaq	(%r9,%rax,8), %r10
18000325a:     	movq	$0x0, (%r10,%r12,8)
180003262:     	xorl	%r11d, %r11d
180003265:     	cmpq	$-0x1, %rax
180003269:     	movl	$0x0, %esi
18000326e:     	cmovlq	%r15, %rsi
180003272:     	movq	$0x0, 0x8(%r10,%rsi,8)
18000327b:     	cmpq	$-0x2, %rax
18000327f:     	cmovlq	%r15, %r11
180003283:     	movq	%rdx, 0x10(%r10,%r11,8)
180003288:     	cmpb	$0x0, (%rbx)
18000328b:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003291:     	movq	%r10, 0xc0(%rsp)
180003299:     	movq	0x18(%r9,%rdi,8), %rax
18000329e:     	movq	%rax, %rdx
1800032a1:     	sarq	$0x3f, %rdx
1800032a5:     	andq	%r15, %rdx
1800032a8:     	leaq	(%r9,%rax,8), %r10
1800032ac:     	movq	%rdx, 0x118(%rsp)
1800032b4:     	cmpq	$0x0, (%r10,%rdx,8)
1800032b9:     	jle	0x180005232 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x38c2>
1800032bf:     	movq	%r11, 0xb8(%rsp)
1800032c7:     	leaq	(,%r15,8), %rdx
1800032cf:     	cmpq	$-0x2, %rax
1800032d3:     	movl	$0x0, %eax
1800032d8:     	cmovlq	%rdx, %rax
1800032dc:     	movq	%rax, 0x120(%rsp)
1800032e4:     	xorl	%edx, %edx
1800032e6:     	shlq	$0x3, %r12
1800032ea:     	leaq	0x8(,%r15,8), %r11
1800032f2:     	leaq	0x10(,%r15,8), %r13
1800032fa:     	leaq	0x18(,%r15,8), %rax
180003302:     	movq	%rax, 0x90(%rsp)
18000330a:     	leaq	0x20(,%r15,8), %rax
180003312:     	movq	%rax, 0xa0(%rsp)
18000331a:     	leaq	0x28(,%r15,8), %rax
180003322:     	movq	%rax, 0xd0(%rsp)
18000332a:     	leaq	0x30(,%r15,8), %rax
180003332:     	movq	%rax, 0xf8(%rsp)
18000333a:     	leaq	0x38(,%r15,8), %rax
180003342:     	movq	%rax, 0xe0(%rsp)
18000334a:     	movapd	0x607e(%rip), %xmm0     # 0x1800093d0
180003352:     	movsd	0x6086(%rip), %xmm1     # 0x1800093e0
18000335a:     	movsd	0x60ae(%rip), %xmm2     # 0x180009410
180003362:     	movq	%rsi, 0xf0(%rsp)
18000336a:     	movq	%r12, 0x100(%rsp)
180003372:     	movq	%r10, 0x110(%rsp)
18000337a:     	movq	%r11, 0xd8(%rsp)
180003382:     	movq	0x120(%rsp), %rax
18000338a:     	movq	0x10(%r10,%rax), %rax
18000338f:     	movq	%rdx, 0x130(%rsp)
180003397:     	addq	%rdx, %rax
18000339a:     	leaq	(%r9,%rax,8), %rdx
18000339e:     	sarq	$0x3f, %rax
1800033a2:     	andq	%r15, %rax
1800033a5:     	movq	(%rdx,%rax,8), %rax
1800033a9:     	movq	%rax, %rdx
1800033ac:     	sarq	$0x3f, %rdx
1800033b0:     	andq	%r15, %rdx
1800033b3:     	leaq	(%r9,%rax,8), %r10
1800033b7:     	movq	(%r10,%rdx,8), %rsi
1800033bb:     	cmpq	$-0x1, %rax
1800033bf:     	movl	$0x0, %eax
1800033c4:     	cmovlq	%r15, %rax
1800033c8:     	movq	0x8(%r10,%rax,8), %rax
1800033cd:     	movq	%rax, 0x128(%rsp)
1800033d5:     	movq	%rsi, %rdx
1800033d8:     	sarq	$0x3f, %rdx
1800033dc:     	andq	%r15, %rdx
1800033df:     	leaq	(%r9,%rsi,8), %rax
1800033e3:     	movq	(%rax,%rdx,8), %rdx
1800033e7:     	testq	%rdx, %rdx
1800033ea:     	je	0x1800034d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1b60>
1800033f0:     	cmpq	$0x1, %rdx
1800033f4:     	movq	0xb8(%rsp), %r11
1800033fc:     	jne	0x1800058ed <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f7d>
180003402:     	cmpb	$0x0, (%rbx)
180003405:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000340b:     	movq	0x338(%rsp), %rdx
180003413:     	movq	0x8(%r9,%rdx,8), %rdx
180003418:     	movq	0x20(%rax), %rax
18000341c:     	movsd	(%r8,%rdx,8), %xmm4
180003422:     	mulsd	(%r8,%rax,8), %xmm4
180003428:     	movapd	%xmm4, %xmm3
18000342c:     	andpd	%xmm0, %xmm3
180003430:     	ucomisd	%xmm1, %xmm3
180003434:     	jae	0x180003591 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c21>
18000343a:     	movsd	0x10(%r8,%rdx,8), %xmm3
180003441:     	mulsd	0x10(%r8,%rax,8), %xmm3
180003448:     	movapd	%xmm3, %xmm5
18000344c:     	andpd	%xmm0, %xmm5
180003450:     	ucomisd	%xmm1, %xmm5
180003454:     	jae	0x180003591 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c21>
18000345a:     	addsd	%xmm3, %xmm4
18000345e:     	movapd	%xmm4, %xmm3
180003462:     	andpd	%xmm0, %xmm3
180003466:     	ucomisd	%xmm1, %xmm3
18000346a:     	jae	0x180003591 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c21>
180003470:     	movsd	0x20(%r8,%rdx,8), %xmm3
180003477:     	mulsd	0x20(%r8,%rax,8), %xmm3
18000347e:     	movapd	%xmm3, %xmm5
180003482:     	andpd	%xmm0, %xmm5
180003486:     	ucomisd	%xmm1, %xmm5
18000348a:     	jae	0x180003591 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c21>
180003490:     	addsd	%xmm3, %xmm4
180003494:     	movapd	%xmm4, %xmm3
180003498:     	andpd	%xmm0, %xmm3
18000349c:     	ucomisd	%xmm1, %xmm3
1800034a0:     	jae	0x180003591 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c21>
1800034a6:     	xorpd	%xmm3, %xmm3
1800034aa:     	ucomisd	%xmm3, %xmm4
1800034ae:     	jne	0x1800034b6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1b46>
1800034b0:     	jnp	0x180003bd8 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2268>
1800034b6:     	movapd	%xmm2, %xmm3
1800034ba:     	divsd	%xmm4, %xmm3
1800034be:     	movl	$0x1, %eax
1800034c3:     	movq	%rax, 0x80(%rsp)
1800034cb:     	jmp	0x1800037c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e54>
1800034d0:     	cmpb	$0x0, (%rbx)
1800034d3:     	movq	0xb8(%rsp), %r11
1800034db:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800034e1:     	movq	0x8(%rax), %rdx
1800034e5:     	movq	0x338(%rsp), %rax
1800034ed:     	movq	(%r9,%rax,8), %rax
1800034f1:     	movsd	(%r8,%rdx,8), %xmm3
1800034f7:     	subsd	(%r8,%rax,8), %xmm3
1800034fd:     	movapd	%xmm3, %xmm4
180003501:     	andpd	%xmm0, %xmm4
180003505:     	ucomisd	%xmm1, %xmm4
180003509:     	jae	0x1800035ba <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c4a>
18000350f:     	movsd	0x10(%r8,%rdx,8), %xmm4
180003516:     	subsd	0x10(%r8,%rax,8), %xmm4
18000351d:     	movapd	%xmm4, %xmm5
180003521:     	andpd	%xmm0, %xmm5
180003525:     	ucomisd	%xmm1, %xmm5
180003529:     	jae	0x1800035ba <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c4a>
18000352f:     	movsd	0x20(%r8,%rdx,8), %xmm5
180003536:     	subsd	0x20(%r8,%rax,8), %xmm5
18000353d:     	movapd	%xmm5, %xmm6
180003541:     	andpd	%xmm0, %xmm6
180003545:     	ucomisd	%xmm1, %xmm6
180003549:     	jae	0x1800035ba <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c4a>
18000354b:     	movq	(%r14), %rdx
18000354e:     	leaq	0x6(%rdx), %rax
180003552:     	cmpq	%r15, %rax
180003555:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
18000355b:     	movq	%rax, (%r14)
18000355e:     	cmpb	$0x0, (%rbx)
180003561:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003567:     	movsd	%xmm3, (%r8,%rdx,8)
18000356d:     	movsd	%xmm4, 0x10(%r8,%rdx,8)
180003574:     	movsd	%xmm5, 0x20(%r8,%rdx,8)
18000357b:     	movzbl	(%rbx), %r10d
18000357f:     	movl	%r10d, %eax
180003582:     	negb	%al
180003584:     	movl	$0x0, %eax
180003589:     	sbbq	%rax, %rax
18000358c:     	orq	%rdx, %rax
18000358f:     	jmp	0x1800035d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c60>
180003591:     	movb	$0x1, (%rbx)
180003594:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
18000359c:     	cmpb	$0x0, (%rbx)
18000359f:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800035a5:     	xorpd	%xmm3, %xmm3
1800035a9:     	movq	$0x0, 0x80(%rsp)
1800035b5:     	jmp	0x1800037c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e54>
1800035ba:     	movb	$0x1, (%rbx)
1800035bd:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
1800035c5:     	movzbl	(%rbx), %r10d
1800035c9:     	movq	$-0x1, %rax
1800035d0:     	xorpd	%xmm3, %xmm3
1800035d4:     	testb	%r10b, %r10b
1800035d7:     	je	0x1800035f3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c83>
1800035d9:     	movq	$0x0, 0x80(%rsp)
1800035e5:     	cmpb	$0x0, (%rbx)
1800035e8:     	je	0x1800037c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e54>
1800035ee:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800035f3:     	movq	0x338(%rsp), %rdx
1800035fb:     	movq	0x8(%r9,%rdx,8), %rdx
180003600:     	movsd	(%r8,%rax,8), %xmm4
180003606:     	mulsd	(%r8,%rdx,8), %xmm4
18000360c:     	movapd	%xmm4, %xmm5
180003610:     	andpd	%xmm0, %xmm5
180003614:     	ucomisd	%xmm1, %xmm5
180003618:     	jae	0x180003676 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1d06>
18000361a:     	movsd	0x10(%r8,%rax,8), %xmm5
180003621:     	mulsd	0x10(%r8,%rdx,8), %xmm5
180003628:     	movapd	%xmm5, %xmm6
18000362c:     	andpd	%xmm0, %xmm6
180003630:     	ucomisd	%xmm1, %xmm6
180003634:     	jae	0x180003676 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1d06>
180003636:     	addsd	%xmm5, %xmm4
18000363a:     	movapd	%xmm4, %xmm5
18000363e:     	andpd	%xmm0, %xmm5
180003642:     	ucomisd	%xmm1, %xmm5
180003646:     	jae	0x180003676 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1d06>
180003648:     	movsd	0x20(%r8,%rax,8), %xmm5
18000364f:     	mulsd	0x20(%r8,%rdx,8), %xmm5
180003656:     	movapd	%xmm5, %xmm6
18000365a:     	andpd	%xmm0, %xmm6
18000365e:     	ucomisd	%xmm1, %xmm6
180003662:     	jae	0x180003676 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1d06>
180003664:     	addsd	%xmm5, %xmm4
180003668:     	movapd	%xmm4, %xmm5
18000366c:     	andpd	%xmm0, %xmm5
180003670:     	ucomisd	%xmm1, %xmm5
180003674:     	jb	0x18000368e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1d1e>
180003676:     	movb	$0x1, (%rbx)
180003679:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003681:     	xorpd	%xmm4, %xmm4
180003685:     	cmpb	$0x0, (%rbx)
180003688:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000368e:     	movsd	0x10(%r8,%rsi,8), %xmm5
180003695:     	mulsd	%xmm5, %xmm5
180003699:     	movapd	%xmm5, %xmm6
18000369d:     	andpd	%xmm0, %xmm6
1800036a1:     	ucomisd	%xmm1, %xmm6
1800036a5:     	jae	0x1800037a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e34>
1800036ab:     	movsd	(%r8,%rax,8), %xmm6
1800036b1:     	mulsd	%xmm6, %xmm6
1800036b5:     	movapd	%xmm6, %xmm7
1800036b9:     	andpd	%xmm0, %xmm7
1800036bd:     	ucomisd	%xmm1, %xmm7
1800036c1:     	jae	0x18000371f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1daf>
1800036c3:     	movsd	0x10(%r8,%rax,8), %xmm7
1800036ca:     	mulsd	%xmm7, %xmm7
1800036ce:     	movapd	%xmm7, %xmm8
1800036d3:     	andpd	%xmm0, %xmm8
1800036d8:     	ucomisd	%xmm1, %xmm8
1800036dd:     	jae	0x18000371f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1daf>
1800036df:     	addsd	%xmm7, %xmm6
1800036e3:     	movapd	%xmm6, %xmm7
1800036e7:     	andpd	%xmm0, %xmm7
1800036eb:     	ucomisd	%xmm1, %xmm7
1800036ef:     	jae	0x18000371f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1daf>
1800036f1:     	movsd	0x20(%r8,%rax,8), %xmm7
1800036f8:     	mulsd	%xmm7, %xmm7
1800036fc:     	movapd	%xmm7, %xmm8
180003701:     	andpd	%xmm0, %xmm8
180003706:     	ucomisd	%xmm1, %xmm8
18000370b:     	jae	0x18000371f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1daf>
18000370d:     	addsd	%xmm7, %xmm6
180003711:     	movapd	%xmm6, %xmm7
180003715:     	andpd	%xmm0, %xmm7
180003719:     	ucomisd	%xmm1, %xmm7
18000371d:     	jb	0x180003737 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1dc7>
18000371f:     	movb	$0x1, (%rbx)
180003722:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
18000372a:     	xorpd	%xmm6, %xmm6
18000372e:     	cmpb	$0x0, (%rbx)
180003731:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003737:     	movapd	%xmm4, %xmm7
18000373b:     	mulsd	%xmm4, %xmm7
18000373f:     	movapd	%xmm7, %xmm8
180003744:     	andpd	%xmm0, %xmm8
180003749:     	ucomisd	%xmm1, %xmm8
18000374e:     	jae	0x1800037a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e34>
180003750:     	subsd	%xmm7, %xmm6
180003754:     	movapd	%xmm6, %xmm7
180003758:     	andpd	%xmm0, %xmm7
18000375c:     	ucomisd	%xmm1, %xmm7
180003760:     	jae	0x1800037a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e34>
180003762:     	subsd	%xmm6, %xmm5
180003766:     	movapd	%xmm5, %xmm6
18000376a:     	andpd	%xmm0, %xmm6
18000376e:     	ucomisd	%xmm1, %xmm6
180003772:     	jae	0x1800037a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e34>
180003774:     	ucomisd	%xmm5, %xmm3
180003778:     	ja	0x1800035d9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1c69>
18000377e:     	xorps	%xmm3, %xmm3
180003781:     	sqrtsd	%xmm5, %xmm3
180003785:     	subsd	%xmm3, %xmm4
180003789:     	movl	$0x1, %eax
18000378e:     	movq	%rax, 0x80(%rsp)
180003796:     	movapd	%xmm4, %xmm3
18000379a:     	cmpb	$0x0, (%rbx)
18000379d:     	je	0x1800037c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e54>
18000379f:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800037a4:     	movb	$0x1, (%rbx)
1800037a7:     	movq	$0xe4e1c4, 0x18(%r14)   # imm = 0xE4E1C4
1800037af:     	movq	$0x0, 0x80(%rsp)
1800037bb:     	cmpb	$0x0, (%rbx)
1800037be:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800037c4:     	movq	0xc0(%rsp), %rax
1800037cc:     	movq	(%rax,%r12), %r10
1800037d0:     	movq	0xf0(%rsp), %rdx
1800037d8:     	cmpq	0x8(%rax,%rdx,8), %r10
1800037dd:     	movq	%r10, 0xc8(%rsp)
1800037e5:     	jne	0x180003af5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2185>
1800037eb:     	leaq	(%r10,%r10), %rdi
1800037ef:     	testq	%r10, %r10
1800037f2:     	movl	$0x4, %eax
1800037f7:     	cmoveq	%rax, %rdi
1800037fb:     	movq	(%r14), %rbp
1800037fe:     	leaq	(%rbp,%rdi), %rdx
180003803:     	cmpq	%r15, %rdx
180003806:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
18000380c:     	movq	%rdx, (%r14)
18000380f:     	cmpb	$0x0, (%rbx)
180003812:     	movq	0xc0(%rsp), %rax
18000381a:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003820:     	movq	%rsi, 0x108(%rsp)
180003828:     	testq	%r10, %r10
18000382b:     	jle	0x180003abb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x214b>
180003831:     	movq	0xb8(%rsp), %rdx
180003839:     	movq	0x10(%rax,%rdx,8), %r11
18000383e:     	movq	0xc8(%rsp), %rdx
180003846:     	movl	%edx, %r12d
180003849:     	andl	$0x7, %r12d
18000384d:     	cmpq	$0x8, %rdx
180003851:     	jae	0x180003862 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1ef2>
180003853:     	xorl	%esi, %esi
180003855:     	leaq	(,%r15,8), %rbx
18000385d:     	jmp	0x180003a87 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2117>
180003862:     	movq	%rdi, 0x88(%rsp)
18000386a:     	movq	%rdx, %rsi
18000386d:     	movabsq	$0x7ffffffffffffff8, %rax # imm = 0x7FFFFFFFFFFFFFF8
180003877:     	andq	%rax, %rsi
18000387a:     	leaq	(%r9,%r11,8), %rdx
18000387e:     	movq	%r13, 0xa8(%rsp)
180003886:     	movq	%rbp, 0x78(%rsp)
18000388b:     	leaq	(%r9,%rbp,8), %rbp
18000388f:     	xorl	%r13d, %r13d
180003892:     	leaq	(,%r15,8), %rbx
18000389a:     	leaq	(%r11,%r13), %r14
18000389e:     	movq	%rsi, %rax
1800038a1:     	movq	%r14, %rsi
1800038a4:     	sarq	$0x3f, %rsi
1800038a8:     	andq	%rbx, %rsi
1800038ab:     	addq	%rdx, %rsi
1800038ae:     	movq	(%rsi,%r13,8), %r10
1800038b2:     	movq	0x78(%rsp), %rsi
1800038b7:     	leaq	(%rsi,%r13), %rdi
1800038bb:     	movq	%rdi, %rsi
1800038be:     	sarq	$0x3f, %rsi
1800038c2:     	andq	%rbx, %rsi
1800038c5:     	addq	%rbp, %rsi
1800038c8:     	movq	%r10, (%rsi,%r13,8)
1800038cc:     	movq	%r14, %r10
1800038cf:     	incq	%r10
1800038d2:     	movl	$0x8, %r10d
1800038d8:     	movq	0xd8(%rsp), %r15
1800038e0:     	cmovsq	%r15, %r10
1800038e4:     	addq	%rdx, %r10
1800038e7:     	movq	(%r10,%r13,8), %r10
1800038eb:     	movq	%rdi, %rsi
1800038ee:     	incq	%rsi
1800038f1:     	movl	$0x8, %esi
1800038f6:     	cmovsq	%r15, %rsi
1800038fa:     	addq	%rbp, %rsi
1800038fd:     	movq	%r10, (%rsi,%r13,8)
180003901:     	movq	%r14, %r10
180003904:     	addq	$0x2, %r10
180003908:     	movl	$0x10, %r10d
18000390e:     	movq	0xa8(%rsp), %r15
180003916:     	cmovsq	%r15, %r10
18000391a:     	addq	%rdx, %r10
18000391d:     	movq	(%r10,%r13,8), %r10
180003921:     	movq	%rdi, %rsi
180003924:     	addq	$0x2, %rsi
180003928:     	movl	$0x10, %esi
18000392d:     	cmovsq	%r15, %rsi
180003931:     	addq	%rbp, %rsi
180003934:     	movq	%r10, (%rsi,%r13,8)
180003938:     	movq	%r14, %r10
18000393b:     	addq	$0x3, %r10
18000393f:     	movl	$0x18, %r10d
180003945:     	movq	0x90(%rsp), %r15
18000394d:     	cmovsq	%r15, %r10
180003951:     	addq	%rdx, %r10
180003954:     	movq	(%r10,%r13,8), %r10
180003958:     	movq	%rdi, %rsi
18000395b:     	addq	$0x3, %rsi
18000395f:     	movl	$0x18, %esi
180003964:     	cmovsq	%r15, %rsi
180003968:     	addq	%rbp, %rsi
18000396b:     	movq	%r10, (%rsi,%r13,8)
18000396f:     	movq	%r14, %r10
180003972:     	addq	$0x4, %r10
180003976:     	movl	$0x20, %r10d
18000397c:     	movq	0xa0(%rsp), %r15
180003984:     	cmovsq	%r15, %r10
180003988:     	addq	%rdx, %r10
18000398b:     	movq	(%r10,%r13,8), %r10
18000398f:     	movq	%rdi, %rsi
180003992:     	addq	$0x4, %rsi
180003996:     	movl	$0x20, %esi
18000399b:     	cmovsq	%r15, %rsi
18000399f:     	addq	%rbp, %rsi
1800039a2:     	movq	%r10, (%rsi,%r13,8)
1800039a6:     	movq	%r14, %r10
1800039a9:     	addq	$0x5, %r10
1800039ad:     	movl	$0x28, %r10d
1800039b3:     	movq	0xd0(%rsp), %r15
1800039bb:     	cmovsq	%r15, %r10
1800039bf:     	addq	%rdx, %r10
1800039c2:     	movq	(%r10,%r13,8), %r10
1800039c6:     	movq	%rdi, %rsi
1800039c9:     	addq	$0x5, %rsi
1800039cd:     	movl	$0x28, %esi
1800039d2:     	cmovsq	%r15, %rsi
1800039d6:     	addq	%rbp, %rsi
1800039d9:     	movq	%r10, (%rsi,%r13,8)
1800039dd:     	movq	%r14, %r10
1800039e0:     	addq	$0x6, %r10
1800039e4:     	movl	$0x30, %r10d
1800039ea:     	movq	0xf8(%rsp), %r15
1800039f2:     	cmovsq	%r15, %r10
1800039f6:     	addq	%rdx, %r10
1800039f9:     	movq	(%r10,%r13,8), %r10
1800039fd:     	movq	%rdi, %rsi
180003a00:     	addq	$0x6, %rsi
180003a04:     	movl	$0x30, %esi
180003a09:     	cmovsq	%r15, %rsi
180003a0d:     	addq	%rbp, %rsi
180003a10:     	movq	%r10, (%rsi,%r13,8)
180003a14:     	addq	$0x7, %r14
180003a18:     	movl	$0x38, %r10d
180003a1e:     	movq	0xe0(%rsp), %r14
180003a26:     	cmovsq	%r14, %r10
180003a2a:     	addq	%rdx, %r10
180003a2d:     	movq	(%r10,%r13,8), %r10
180003a31:     	addq	$0x7, %rdi
180003a35:     	movl	$0x38, %esi
180003a3a:     	cmovsq	%r14, %rsi
180003a3e:     	addq	%rbp, %rsi
180003a41:     	movq	%r10, (%rsi,%r13,8)
180003a45:     	movq	%rax, %rsi
180003a48:     	addq	$0x8, %r13
180003a4c:     	cmpq	%r13, %rax
180003a4f:     	jne	0x18000389a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1f2a>
180003a55:     	testq	%r12, %r12
180003a58:     	movq	0x310(%rsp), %r14
180003a60:     	movq	0xc0(%rsp), %rax
180003a68:     	movq	0x320(%rsp), %r15
180003a70:     	movq	0xa8(%rsp), %r13
180003a78:     	movq	0x88(%rsp), %rdi
180003a80:     	movq	0x78(%rsp), %rbp
180003a85:     	je	0x180003abb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x214b>
180003a87:     	leaq	(%rsi,%rbp), %rdx
180003a8b:     	addq	%rsi, %r11
180003a8e:     	movq	%r11, %r10
180003a91:     	sarq	$0x3f, %r10
180003a95:     	andq	%rbx, %r10
180003a98:     	addq	%r9, %r10
180003a9b:     	movq	(%r10,%r11,8), %r10
180003a9f:     	movq	%rdx, %rsi
180003aa2:     	sarq	$0x3f, %rsi
180003aa6:     	andq	%rbx, %rsi
180003aa9:     	addq	%r9, %rsi
180003aac:     	movq	%r10, (%rsi,%rdx,8)
180003ab0:     	incq	%rdx
180003ab3:     	incq	%r11
180003ab6:     	decq	%r12
180003ab9:     	jne	0x180003a8e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x211e>
180003abb:     	movq	0xf0(%rsp), %rdx
180003ac3:     	movq	%rdi, 0x8(%rax,%rdx,8)
180003ac8:     	movq	0xb8(%rsp), %r11
180003ad0:     	movq	%rbp, 0x10(%rax,%r11,8)
180003ad5:     	movq	0x100(%rsp), %r12
180003add:     	movq	0x318(%rsp), %rbx
180003ae5:     	movq	0x108(%rsp), %rsi
180003aed:     	movq	0xc8(%rsp), %r10
180003af5:     	leaq	0x1(%r10), %rdx
180003af9:     	movq	%rdx, (%rax,%r12)
180003afd:     	cmpb	$0x0, (%rbx)
180003b00:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003b06:     	movq	(%r14), %rdx
180003b09:     	leaq	0x4(%rdx), %r10
180003b0d:     	cmpq	%r15, %r10
180003b10:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180003b16:     	movq	%r12, %rbp
180003b19:     	movq	0xc8(%rsp), %r12
180003b21:     	addq	0x10(%rax,%r11,8), %r12
180003b26:     	movq	%r10, (%r14)
180003b29:     	cmpb	$0x0, (%rbx)
180003b2c:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003b32:     	movq	%r13, %rax
180003b35:     	movq	0x130(%rsp), %r13
180003b3d:     	incq	%r13
180003b40:     	movq	%rdx, %r10
180003b43:     	sarq	$0x3f, %r10
180003b47:     	andq	%r15, %r10
180003b4a:     	leaq	(%r9,%rdx,8), %r11
180003b4e:     	movq	%rsi, (%r11,%r10,8)
180003b52:     	cmpq	$-0x1, %rdx
180003b56:     	movl	$0x0, %r10d
180003b5c:     	cmovlq	%r15, %r10
180003b60:     	leaq	(%r8,%rdx,8), %rsi
180003b64:     	movsd	%xmm3, 0x8(%rsi,%r10,8)
180003b6b:     	cmpq	$-0x2, %rdx
180003b6f:     	movl	$0x0, %r10d
180003b75:     	cmovlq	%r15, %r10
180003b79:     	movq	0x80(%rsp), %rsi
180003b81:     	movq	%rsi, 0x10(%r11,%r10,8)
180003b86:     	cmpq	$-0x3, %rdx
180003b8a:     	movl	$0x0, %r10d
180003b90:     	cmovlq	%r15, %r10
180003b94:     	movq	0x128(%rsp), %rsi
180003b9c:     	movq	%rsi, 0x18(%r11,%r10,8)
180003ba1:     	leaq	(%r9,%r12,8), %r10
180003ba5:     	sarq	$0x3f, %r12
180003ba9:     	andq	%r15, %r12
180003bac:     	movq	%rdx, (%r10,%r12,8)
180003bb0:     	movq	%r13, %rdx
180003bb3:     	movq	%rax, %r13
180003bb6:     	movq	0x118(%rsp), %rax
180003bbe:     	movq	0x110(%rsp), %r10
180003bc6:     	cmpq	(%r10,%rax,8), %rdx
180003bca:     	movq	%rbp, %r12
180003bcd:     	jl	0x180003382 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1a12>
180003bd3:     	jmp	0x18000571a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3daa>
180003bd8:     	movq	$0x0, 0x80(%rsp)
180003be4:     	jmp	0x1800037c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x1e54>
180003be9:     	movq	0x10(%rax), %rdx
180003bed:     	xorl	%eax, %eax
180003bef:     	cmpq	$-0x2, %rdx
180003bf3:     	movl	$0x0, %r10d
180003bf9:     	cmovlq	%r15, %r10
180003bfd:     	cmpq	$-0x4, %rdx
180003c01:     	cmovlq	%r15, %rax
180003c05:     	cmpb	$0x0, (%rbx)
180003c08:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003c0e:     	leaq	(%r8,%rdx,8), %r11
180003c12:     	sarq	$0x3f, %rdx
180003c16:     	andq	%r15, %rdx
180003c19:     	movsd	(%r11,%rdx,8), %xmm8
180003c1f:     	movsd	0x10(%r11,%r10,8), %xmm7
180003c26:     	movsd	0x20(%r11,%rax,8), %xmm6
180003c2d:     	jmp	0x180003c74 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2304>
180003c2f:     	movb	$0x1, (%rbx)
180003c32:     	movq	$0x1406f42, 0x18(%r14)  # imm = 0x1406F42
180003c3a:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003c3f:     	movb	$0x1, (%rbx)
180003c42:     	movq	$0xf4243, 0x18(%r14)    # imm = 0xF4243
180003c4a:     	movzbl	(%rbx), %r10d
180003c4e:     	movq	$-0x1, %rdx
180003c55:     	xorpd	%xmm6, %xmm6
180003c59:     	testb	%r10b, %r10b
180003c5c:     	je	0x180003e57 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x24e7>
180003c62:     	xorpd	%xmm7, %xmm7
180003c66:     	xorpd	%xmm8, %xmm8
180003c6b:     	cmpb	$0x0, (%rbx)
180003c6e:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003c74:     	movq	0x360(%rsp), %rbp
180003c7c:     	movq	0x348(%rsp), %rsi
180003c84:     	movsd	0x20(%r8,%r12,8), %xmm1
180003c8b:     	xorpd	%xmm0, %xmm0
180003c8f:     	ucomisd	%xmm0, %xmm1
180003c93:     	setbe	%dil
180003c97:     	ja	0x180003ce2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2372>
180003c99:     	shlq	$0x3, %r12
180003c9d:     	xorpd	%xmm1, %xmm1
180003ca1:     	xorpd	%xmm2, %xmm2
180003ca5:     	movsd	0x18(%r8,%r12), %xmm4
180003cac:     	xorpd	%xmm3, %xmm3
180003cb0:     	ucomisd	%xmm3, %xmm4
180003cb4:     	jbe	0x180005888 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f18>
180003cba:     	movq	(%r14), %r10
180003cbd:     	cmpq	%r15, %r10
180003cc0:     	movq	%r10, %rdx
180003cc3:     	jle	0x180003ccd <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x235d>
180003cc5:     	movb	$0x2, (%rbx)
180003cc8:     	movq	(%r14), %r10
180003ccb:     	xorl	%edx, %edx
180003ccd:     	leaq	0x3(%r10), %rax
180003cd1:     	cmpq	%r15, %rax
180003cd4:     	jle	0x180003f5b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x25eb>
180003cda:     	movb	$0x2, (%rbx)
180003cdd:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003ce2:     	movq	0x350(%rsp), %rax
180003cea:     	movq	0x8(%r9,%rax,8), %rax
180003cef:     	movsd	(%r8,%rax,8), %xmm0
180003cf5:     	mulsd	(%r8,%rbp,8), %xmm0
180003cfb:     	movapd	0x56cd(%rip), %xmm1     # 0x1800093d0
180003d03:     	andpd	%xmm0, %xmm1
180003d07:     	ucomisd	0x56d1(%rip), %xmm1     # 0x1800093e0
180003d0f:     	jae	0x180003d8d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x241d>
180003d11:     	movsd	0x10(%r8,%rax,8), %xmm1
180003d18:     	mulsd	0x10(%r8,%rbp,8), %xmm1
180003d1f:     	movapd	0x56a9(%rip), %xmm2     # 0x1800093d0
180003d27:     	andpd	%xmm1, %xmm2
180003d2b:     	ucomisd	0x56ad(%rip), %xmm2     # 0x1800093e0
180003d33:     	jae	0x180003d8d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x241d>
180003d35:     	addsd	%xmm1, %xmm0
180003d39:     	movapd	0x568f(%rip), %xmm1     # 0x1800093d0
180003d41:     	andpd	%xmm0, %xmm1
180003d45:     	ucomisd	0x5693(%rip), %xmm1     # 0x1800093e0
180003d4d:     	jae	0x180003d8d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x241d>
180003d4f:     	movsd	0x20(%r8,%rax,8), %xmm1
180003d56:     	mulsd	0x20(%r8,%rbp,8), %xmm1
180003d5d:     	movapd	0x566b(%rip), %xmm2     # 0x1800093d0
180003d65:     	andpd	%xmm1, %xmm2
180003d69:     	ucomisd	0x566f(%rip), %xmm2     # 0x1800093e0
180003d71:     	jae	0x180003d8d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x241d>
180003d73:     	addsd	%xmm1, %xmm0
180003d77:     	movapd	0x5651(%rip), %xmm1     # 0x1800093d0
180003d7f:     	andpd	%xmm0, %xmm1
180003d83:     	ucomisd	0x5655(%rip), %xmm1     # 0x1800093e0
180003d8b:     	jb	0x180003da5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2435>
180003d8d:     	movb	$0x1, (%rbx)
180003d90:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180003d98:     	cmpb	$0x0, (%rbx)
180003d9b:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003da1:     	xorpd	%xmm0, %xmm0
180003da5:     	movsd	(%r8,%rbp,8), %xmm1
180003dab:     	mulsd	%xmm0, %xmm1
180003daf:     	movapd	0x5619(%rip), %xmm2     # 0x1800093d0
180003db7:     	andpd	%xmm1, %xmm2
180003dbb:     	ucomisd	0x561d(%rip), %xmm2     # 0x1800093e0
180003dc3:     	jae	0x180003e7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x250f>
180003dc9:     	movsd	0x10(%r8,%rbp,8), %xmm2
180003dd0:     	mulsd	%xmm0, %xmm2
180003dd4:     	movapd	0x55f4(%rip), %xmm3     # 0x1800093d0
180003ddc:     	andpd	%xmm2, %xmm3
180003de0:     	ucomisd	0x55f8(%rip), %xmm3     # 0x1800093e0
180003de8:     	jae	0x180003e7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x250f>
180003dee:     	mulsd	0x20(%r8,%rbp,8), %xmm0
180003df5:     	movapd	0x55d3(%rip), %xmm3     # 0x1800093d0
180003dfd:     	andpd	%xmm0, %xmm3
180003e01:     	ucomisd	0x55d7(%rip), %xmm3     # 0x1800093e0
180003e09:     	jae	0x180003e7f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x250f>
180003e0b:     	movq	(%r14), %r10
180003e0e:     	leaq	0x6(%r10), %rdx
180003e12:     	cmpq	%r15, %rdx
180003e15:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180003e1b:     	movq	%rdx, (%r14)
180003e1e:     	cmpb	$0x0, (%rbx)
180003e21:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003e27:     	movsd	%xmm1, (%r8,%r10,8)
180003e2d:     	movsd	%xmm2, 0x10(%r8,%r10,8)
180003e34:     	movsd	%xmm0, 0x20(%r8,%r10,8)
180003e3b:     	movzbl	(%rbx), %r11d
180003e3f:     	xorl	%edx, %edx
180003e41:     	movl	%r11d, %r14d
180003e44:     	negb	%r14b
180003e47:     	movq	0x310(%rsp), %r14
180003e4f:     	sbbq	%rdx, %rdx
180003e52:     	orq	%r10, %rdx
180003e55:     	jmp	0x180003e95 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2525>
180003e57:     	movq	0x28(%rax), %rsi
180003e5b:     	testq	%rsi, %rsi
180003e5e:     	je	0x180004cc2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3352>
180003e64:     	movq	(%r14), %r11
180003e67:     	leaq	0x6(%r11), %rdi
180003e6b:     	movb	$0x2, %r10b
180003e6e:     	cmpq	%r15, %rdi
180003e71:     	jle	0x180004cd2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3362>
180003e77:     	movb	%r10b, (%rbx)
180003e7a:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003e7f:     	movb	$0x1, (%rbx)
180003e82:     	movq	$0x1d905c2, 0x18(%r14)  # imm = 0x1D905C2
180003e8a:     	movzbl	(%rbx), %r11d
180003e8e:     	movq	$-0x1, %rdx
180003e95:     	testb	%r11b, %r11b
180003e98:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003e9e:     	movsd	(%r8,%rdx,8), %xmm0
180003ea4:     	addsd	%xmm0, %xmm0
180003ea8:     	movapd	0x5520(%rip), %xmm1     # 0x1800093d0
180003eb0:     	andpd	%xmm0, %xmm1
180003eb4:     	ucomisd	0x5524(%rip), %xmm1     # 0x1800093e0
180003ebc:     	jae	0x180004e33 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x34c3>
180003ec2:     	movsd	0x10(%r8,%rdx,8), %xmm1
180003ec9:     	addsd	%xmm1, %xmm1
180003ecd:     	movapd	0x54fb(%rip), %xmm2     # 0x1800093d0
180003ed5:     	andpd	%xmm1, %xmm2
180003ed9:     	ucomisd	0x54ff(%rip), %xmm2     # 0x1800093e0
180003ee1:     	jae	0x180004e33 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x34c3>
180003ee7:     	movsd	0x20(%r8,%rdx,8), %xmm2
180003eee:     	addsd	%xmm2, %xmm2
180003ef2:     	movapd	0x54d6(%rip), %xmm3     # 0x1800093d0
180003efa:     	andpd	%xmm2, %xmm3
180003efe:     	ucomisd	0x54da(%rip), %xmm3     # 0x1800093e0
180003f06:     	jae	0x180004e33 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x34c3>
180003f0c:     	movq	(%r14), %r10
180003f0f:     	leaq	0x6(%r10), %rdx
180003f13:     	cmpq	%r15, %rdx
180003f16:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180003f1c:     	movq	%rdx, (%r14)
180003f1f:     	cmpb	$0x0, (%rbx)
180003f22:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003f28:     	movsd	%xmm0, (%r8,%r10,8)
180003f2e:     	movsd	%xmm1, 0x10(%r8,%r10,8)
180003f35:     	movsd	%xmm2, 0x20(%r8,%r10,8)
180003f3c:     	movzbl	(%rbx), %r11d
180003f40:     	xorl	%edx, %edx
180003f42:     	movl	%r11d, %r14d
180003f45:     	negb	%r14b
180003f48:     	movq	0x310(%rsp), %r14
180003f50:     	sbbq	%rdx, %rdx
180003f53:     	orq	%r10, %rdx
180003f56:     	jmp	0x180004e49 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x34d9>
180003f5b:     	movq	0x310(%rsp), %r11
180003f63:     	movq	%rax, (%r11)
180003f66:     	cmpb	$0x0, (%rbx)
180003f69:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003f6f:     	movq	%r10, %rax
180003f72:     	sarq	$0x3f, %rax
180003f76:     	andq	%r15, %rax
180003f79:     	leaq	(%r9,%r10,8), %r11
180003f7d:     	movq	%rax, 0xa0(%rsp)
180003f85:     	movq	$0x0, (%r11,%rax,8)
180003f8d:     	xorl	%eax, %eax
180003f8f:     	cmpq	$-0x1, %r10
180003f93:     	movl	$0x0, %edi
180003f98:     	cmovlq	%r15, %rdi
180003f9c:     	movq	%rdi, 0xc8(%rsp)
180003fa4:     	movq	$0x0, 0x8(%r11,%rdi,8)
180003fad:     	cmpq	$-0x2, %r10
180003fb1:     	cmovlq	%r15, %rax
180003fb5:     	movq	%r11, 0x90(%rsp)
180003fbd:     	movq	%rax, 0xd8(%rsp)
180003fc5:     	movq	%rdx, 0x10(%r11,%rax,8)
180003fca:     	cmpb	$0x0, (%rbx)
180003fcd:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180003fd3:     	movq	0x8(%r9,%rsi,8), %rax
180003fd8:     	movq	%rax, %rdx
180003fdb:     	sarq	$0x3f, %rdx
180003fdf:     	andq	%r15, %rdx
180003fe2:     	leaq	(%r9,%rax,8), %r11
180003fe6:     	cmpq	$0x0, (%r11,%rdx,8)
180003feb:     	jle	0x180005388 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a18>
180003ff1:     	movq	%rdx, 0xb8(%rsp)
180003ff9:     	leaq	(,%r15,8), %rdi
180004001:     	xorl	%r14d, %r14d
180004004:     	cmpq	$-0x2, %rax
180004008:     	movl	$0x0, %eax
18000400d:     	cmovlq	%rdi, %rax
180004011:     	shlq	$0x3, 0xa0(%rsp)
18000401a:     	movapd	0x53ae(%rip), %xmm4     # 0x1800093d0
180004022:     	movsd	0x53b6(%rip), %xmm5     # 0x1800093e0
18000402a:     	xorpd	%xmm9, %xmm9
18000402f:     	movq	%r11, 0x130(%rsp)
180004037:     	movq	%rax, 0x128(%rsp)
18000403f:     	movq	0x10(%r11,%rax), %rax
180004044:     	addq	%r14, %rax
180004047:     	leaq	(%r9,%rax,8), %rdx
18000404b:     	sarq	$0x3f, %rax
18000404f:     	andq	%r15, %rax
180004052:     	movq	(%rdx,%rax,8), %rax
180004056:     	movq	%rax, 0xf8(%rsp)
18000405e:     	incq	%r14
180004061:     	movq	%r14, 0xc0(%rsp)
180004069:     	movq	0x18(%r9,%rsi,8), %rax
18000406e:     	leaq	(%r9,%rax,8), %rdx
180004072:     	movq	%rdx, 0xa8(%rsp)
18000407a:     	movq	%rax, %rdx
18000407d:     	sarq	$0x3f, %rdx
180004081:     	andq	%rdi, %rdx
180004084:     	movq	%rdx, 0xd0(%rsp)
18000408c:     	cmpq	$-0x2, %rax
180004090:     	movl	$0x0, %eax
180004095:     	cmovlq	%rdi, %rax
180004099:     	movq	%rax, 0xe0(%rsp)
1800040a1:     	movq	$0x0, 0x78(%rsp)
1800040aa:     	movq	0xa8(%rsp), %rax
1800040b2:     	movq	0xd0(%rsp), %rdx
1800040ba:     	movq	0x78(%rsp), %r11
1800040bf:     	cmpq	(%rax,%rdx), %r11
1800040c3:     	jge	0x1800047e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e76>
1800040c9:     	cmpb	$0x0, (%rbx)
1800040cc:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800040d2:     	movq	0xa8(%rsp), %rax
1800040da:     	movq	0xe0(%rsp), %rdx
1800040e2:     	movq	0x10(%rax,%rdx), %rax
1800040e7:     	addq	0x78(%rsp), %rax
1800040ec:     	leaq	(%r9,%rax,8), %rdx
1800040f0:     	sarq	$0x3f, %rax
1800040f4:     	andq	%r15, %rax
1800040f7:     	movq	(%rdx,%rax,8), %rax
1800040fb:     	leaq	(%r9,%rax,8), %rdx
1800040ff:     	sarq	$0x3f, %rax
180004103:     	andq	%r15, %rax
180004106:     	movq	(%rdx,%rax,8), %r11
18000410a:     	movq	0xf8(%rsp), %rax
180004112:     	movsd	(%r8,%rax,8), %xmm11
180004118:     	subsd	(%r8,%r13,8), %xmm11
18000411e:     	movapd	%xmm11, %xmm12
180004123:     	andpd	%xmm4, %xmm12
180004128:     	ucomisd	%xmm5, %xmm12
18000412d:     	jae	0x1800041c5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2855>
180004133:     	movsd	0x10(%r8,%rax,8), %xmm13
18000413a:     	subsd	0x10(%r8,%r13,8), %xmm13
180004141:     	movapd	%xmm13, %xmm12
180004146:     	andpd	%xmm4, %xmm12
18000414b:     	ucomisd	%xmm5, %xmm12
180004150:     	jae	0x1800041c5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2855>
180004152:     	movsd	0x20(%r8,%rax,8), %xmm14
180004159:     	subsd	0x20(%r8,%r13,8), %xmm14
180004160:     	movapd	%xmm14, %xmm12
180004165:     	andpd	%xmm4, %xmm12
18000416a:     	ucomisd	%xmm5, %xmm12
18000416f:     	jae	0x1800041c5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2855>
180004171:     	movq	0x310(%rsp), %rax
180004179:     	movq	(%rax), %rdi
18000417c:     	leaq	0x6(%rdi), %rax
180004180:     	cmpq	%r15, %rax
180004183:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004189:     	movq	0x310(%rsp), %rdx
180004191:     	movq	%rax, (%rdx)
180004194:     	cmpb	$0x0, (%rbx)
180004197:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000419d:     	movsd	%xmm11, (%r8,%rdi,8)
1800041a3:     	movsd	%xmm13, 0x10(%r8,%rdi,8)
1800041aa:     	movsd	%xmm14, 0x20(%r8,%rdi,8)
1800041b1:     	movzbl	(%rbx), %eax
1800041b4:     	movl	%eax, %edx
1800041b6:     	negb	%dl
1800041b8:     	movl	$0x0, %edx
1800041bd:     	sbbq	%rdx, %rdx
1800041c0:     	orq	%rdi, %rdx
1800041c3:     	jmp	0x1800041e2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2872>
1800041c5:     	movb	$0x1, (%rbx)
1800041c8:     	movq	0x310(%rsp), %rax
1800041d0:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
1800041d8:     	movzbl	(%rbx), %eax
1800041db:     	movq	$-0x1, %rdx
1800041e2:     	testb	%al, %al
1800041e4:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800041ea:     	movq	0x310(%rsp), %rax
1800041f2:     	movq	(%rax), %rdi
1800041f5:     	leaq	0x2(%rdi), %rax
1800041f9:     	cmpq	%r15, %rax
1800041fc:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004202:     	movq	0x310(%rsp), %r14
18000420a:     	movq	%rax, (%r14)
18000420d:     	cmpb	$0x0, (%rbx)
180004210:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004216:     	movq	%r13, (%r9,%rdi,8)
18000421a:     	cmpb	$0x0, (%rbx)
18000421d:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004223:     	movsd	(%r8,%rdx,8), %xmm11
180004229:     	mulsd	%xmm11, %xmm11
18000422e:     	movapd	%xmm11, %xmm12
180004233:     	andpd	%xmm4, %xmm12
180004238:     	ucomisd	%xmm5, %xmm12
18000423d:     	jae	0x1800042a5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2935>
18000423f:     	movsd	0x10(%r8,%rdx,8), %xmm13
180004246:     	mulsd	%xmm13, %xmm13
18000424b:     	movapd	%xmm13, %xmm12
180004250:     	andpd	%xmm4, %xmm12
180004255:     	ucomisd	%xmm5, %xmm12
18000425a:     	jae	0x1800042a5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2935>
18000425c:     	addsd	%xmm13, %xmm11
180004261:     	movapd	%xmm11, %xmm12
180004266:     	andpd	%xmm4, %xmm12
18000426b:     	ucomisd	%xmm5, %xmm12
180004270:     	jae	0x1800042a5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2935>
180004272:     	movsd	0x20(%r8,%rdx,8), %xmm13
180004279:     	mulsd	%xmm13, %xmm13
18000427e:     	movapd	%xmm13, %xmm12
180004283:     	andpd	%xmm4, %xmm12
180004288:     	ucomisd	%xmm5, %xmm12
18000428d:     	jae	0x1800042a5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2935>
18000428f:     	addsd	%xmm13, %xmm11
180004294:     	movapd	%xmm11, %xmm12
180004299:     	andpd	%xmm4, %xmm12
18000429e:     	ucomisd	%xmm5, %xmm12
1800042a3:     	jb	0x1800042c6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2956>
1800042a5:     	movb	$0x1, (%rbx)
1800042a8:     	movq	0x310(%rsp), %rax
1800042b0:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
1800042b8:     	xorpd	%xmm11, %xmm11
1800042bd:     	cmpb	$0x0, (%rbx)
1800042c0:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800042c6:     	sqrtsd	%xmm11, %xmm11
1800042cb:     	ucomisd	%xmm9, %xmm11
1800042d0:     	jne	0x1800042f6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2986>
1800042d2:     	jp	0x1800042f6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2986>
1800042d4:     	movb	$0x1, (%rbx)
1800042d7:     	movq	0x310(%rsp), %rax
1800042df:     	movq	$0x3d0902, 0x18(%rax)   # imm = 0x3D0902
1800042e7:     	movzbl	(%rbx), %eax
1800042ea:     	movq	$-0x1, %rdx
1800042f1:     	jmp	0x180004379 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2a09>
1800042f6:     	movq	0x310(%rsp), %rax
1800042fe:     	movq	(%rax), %r14
180004301:     	leaq	0x6(%r14), %rax
180004305:     	cmpq	%r15, %rax
180004308:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
18000430e:     	movsd	(%r8,%rdx,8), %xmm13
180004314:     	movsd	0x10(%r8,%rdx,8), %xmm14
18000431b:     	movsd	0x20(%r8,%rdx,8), %xmm15
180004322:     	movq	0x310(%rsp), %rdx
18000432a:     	movq	%rax, (%rdx)
18000432d:     	cmpb	$0x0, (%rbx)
180004330:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004336:     	movsd	0x50a9(%rip), %xmm12    # 0x1800093e8
18000433f:     	divsd	%xmm11, %xmm12
180004344:     	mulsd	%xmm12, %xmm13
180004349:     	mulsd	%xmm12, %xmm14
18000434e:     	mulsd	%xmm15, %xmm12
180004353:     	movsd	%xmm13, (%r8,%r14,8)
180004359:     	movsd	%xmm14, 0x10(%r8,%r14,8)
180004360:     	movsd	%xmm12, 0x20(%r8,%r14,8)
180004367:     	movzbl	(%rbx), %eax
18000436a:     	movl	%eax, %edx
18000436c:     	negb	%dl
18000436e:     	movl	$0x0, %edx
180004373:     	sbbq	%rdx, %rdx
180004376:     	orq	%r14, %rdx
180004379:     	testb	%al, %al
18000437b:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004381:     	movq	%rdx, 0x8(%r9,%rdi,8)
180004386:     	cmpb	$0x0, (%rbx)
180004389:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000438f:     	movq	%r11, %r14
180004392:     	sarq	$0x3f, %r14
180004396:     	andq	%r15, %r14
180004399:     	leaq	(%r9,%r11,8), %rax
18000439d:     	movq	(%rax,%r14,8), %r14
1800043a1:     	testq	%r14, %r14
1800043a4:     	je	0x18000448f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2b1f>
1800043aa:     	cmpq	$0x1, %r14
1800043ae:     	jne	0x1800048d7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2f67>
1800043b4:     	movq	0x20(%rax), %r11
1800043b8:     	movsd	(%r8,%rdx,8), %xmm11
1800043be:     	mulsd	(%r8,%r11,8), %xmm11
1800043c4:     	movapd	%xmm11, %xmm10
1800043c9:     	andpd	%xmm4, %xmm10
1800043ce:     	ucomisd	%xmm5, %xmm10
1800043d3:     	movq	0x310(%rsp), %rax
1800043db:     	jae	0x180004552 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2be2>
1800043e1:     	movsd	0x10(%r8,%rdx,8), %xmm12
1800043e8:     	mulsd	0x10(%r8,%r11,8), %xmm12
1800043ef:     	movapd	%xmm12, %xmm10
1800043f4:     	andpd	%xmm4, %xmm10
1800043f9:     	ucomisd	%xmm5, %xmm10
1800043fe:     	jae	0x180004552 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2be2>
180004404:     	addsd	%xmm12, %xmm11
180004409:     	movapd	%xmm11, %xmm10
18000440e:     	andpd	%xmm4, %xmm10
180004413:     	ucomisd	%xmm5, %xmm10
180004418:     	jae	0x180004552 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2be2>
18000441e:     	movsd	0x20(%r8,%rdx,8), %xmm12
180004425:     	mulsd	0x20(%r8,%r11,8), %xmm12
18000442c:     	movapd	%xmm12, %xmm10
180004431:     	andpd	%xmm4, %xmm10
180004436:     	ucomisd	%xmm5, %xmm10
18000443b:     	jae	0x180004552 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2be2>
180004441:     	addsd	%xmm12, %xmm11
180004446:     	movapd	%xmm11, %xmm10
18000444b:     	andpd	%xmm4, %xmm10
180004450:     	ucomisd	%xmm5, %xmm10
180004455:     	jae	0x180004552 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2be2>
18000445b:     	xorpd	%xmm13, %xmm13
180004460:     	ucomisd	%xmm13, %xmm11
180004465:     	jne	0x18000446d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2afd>
180004467:     	jnp	0x1800047d6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e66>
18000446d:     	movsd	0x4f9a(%rip), %xmm13    # 0x180009410
180004476:     	divsd	%xmm11, %xmm13
18000447b:     	movb	$0x1, %dl
18000447d:     	incq	0x78(%rsp)
180004482:     	testb	%dl, %dl
180004484:     	jne	0x1800047c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e52>
18000448a:     	jmp	0x1800040aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x273a>
18000448f:     	movq	0x8(%rax), %r14
180004493:     	movq	(%r9,%rdi,8), %rdx
180004497:     	movsd	(%r8,%r14,8), %xmm11
18000449d:     	subsd	(%r8,%rdx,8), %xmm11
1800044a3:     	movapd	%xmm11, %xmm10
1800044a8:     	andpd	%xmm4, %xmm10
1800044ad:     	ucomisd	%xmm5, %xmm10
1800044b2:     	jae	0x18000457f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c0f>
1800044b8:     	movsd	0x10(%r8,%r14,8), %xmm13
1800044bf:     	subsd	0x10(%r8,%rdx,8), %xmm13
1800044c6:     	movapd	%xmm13, %xmm12
1800044cb:     	andpd	%xmm4, %xmm12
1800044d0:     	ucomisd	%xmm5, %xmm12
1800044d5:     	jae	0x18000457f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c0f>
1800044db:     	movsd	0x20(%r8,%r14,8), %xmm14
1800044e2:     	subsd	0x20(%r8,%rdx,8), %xmm14
1800044e9:     	movapd	%xmm14, %xmm12
1800044ee:     	andpd	%xmm4, %xmm12
1800044f3:     	ucomisd	%xmm5, %xmm12
1800044f8:     	jae	0x18000457f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c0f>
1800044fe:     	movq	0x310(%rsp), %rax
180004506:     	movq	(%rax), %r14
180004509:     	leaq	0x6(%r14), %rax
18000450d:     	cmpq	%r15, %rax
180004510:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004516:     	movq	0x310(%rsp), %rdx
18000451e:     	movq	%rax, (%rdx)
180004521:     	cmpb	$0x0, (%rbx)
180004524:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000452a:     	movsd	%xmm11, (%r8,%r14,8)
180004530:     	movsd	%xmm13, 0x10(%r8,%r14,8)
180004537:     	movsd	%xmm14, 0x20(%r8,%r14,8)
18000453e:     	movzbl	(%rbx), %eax
180004541:     	movl	%eax, %edx
180004543:     	negb	%dl
180004545:     	movl	$0x0, %edx
18000454a:     	sbbq	%rdx, %rdx
18000454d:     	orq	%r14, %rdx
180004550:     	jmp	0x18000459c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c2c>
180004552:     	movb	$0x1, (%rbx)
180004555:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
18000455d:     	cmpb	$0x0, (%rbx)
180004560:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004566:     	xorpd	%xmm13, %xmm13
18000456b:     	xorl	%edx, %edx
18000456d:     	incq	0x78(%rsp)
180004572:     	testb	%dl, %dl
180004574:     	jne	0x1800047c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e52>
18000457a:     	jmp	0x1800040aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x273a>
18000457f:     	movb	$0x1, (%rbx)
180004582:     	movq	0x310(%rsp), %rax
18000458a:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
180004592:     	movzbl	(%rbx), %eax
180004595:     	movq	$-0x1, %rdx
18000459c:     	xorpd	%xmm13, %xmm13
1800045a1:     	testb	%al, %al
1800045a3:     	je	0x1800045b5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c45>
1800045a5:     	xorl	%edx, %edx
1800045a7:     	cmpb	$0x0, (%rbx)
1800045aa:     	je	0x1800047b5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e45>
1800045b0:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800045b5:     	movq	0x8(%r9,%rdi,8), %rdi
1800045ba:     	movsd	(%r8,%rdx,8), %xmm14
1800045c0:     	mulsd	(%r8,%rdi,8), %xmm14
1800045c6:     	movapd	%xmm14, %xmm11
1800045cb:     	andpd	%xmm4, %xmm11
1800045d0:     	ucomisd	%xmm5, %xmm11
1800045d5:     	jae	0x180004641 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2cd1>
1800045d7:     	movsd	0x10(%r8,%rdx,8), %xmm11
1800045de:     	mulsd	0x10(%r8,%rdi,8), %xmm11
1800045e5:     	movapd	%xmm11, %xmm12
1800045ea:     	andpd	%xmm4, %xmm12
1800045ef:     	ucomisd	%xmm5, %xmm12
1800045f4:     	jae	0x180004641 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2cd1>
1800045f6:     	addsd	%xmm11, %xmm14
1800045fb:     	movapd	%xmm14, %xmm11
180004600:     	andpd	%xmm4, %xmm11
180004605:     	ucomisd	%xmm5, %xmm11
18000460a:     	jae	0x180004641 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2cd1>
18000460c:     	movsd	0x20(%r8,%rdx,8), %xmm11
180004613:     	mulsd	0x20(%r8,%rdi,8), %xmm11
18000461a:     	movapd	%xmm11, %xmm12
18000461f:     	andpd	%xmm4, %xmm12
180004624:     	ucomisd	%xmm5, %xmm12
180004629:     	jae	0x180004641 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2cd1>
18000462b:     	addsd	%xmm11, %xmm14
180004630:     	movapd	%xmm14, %xmm11
180004635:     	andpd	%xmm4, %xmm11
18000463a:     	ucomisd	%xmm5, %xmm11
18000463f:     	jb	0x180004662 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2cf2>
180004641:     	movb	$0x1, (%rbx)
180004644:     	movq	0x310(%rsp), %rax
18000464c:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180004654:     	xorpd	%xmm14, %xmm14
180004659:     	cmpb	$0x0, (%rbx)
18000465c:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004662:     	movsd	0x10(%r8,%r11,8), %xmm15
180004669:     	mulsd	%xmm15, %xmm15
18000466e:     	movapd	%xmm15, %xmm11
180004673:     	andpd	%xmm4, %xmm11
180004678:     	ucomisd	%xmm5, %xmm11
18000467d:     	jae	0x180004797 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e27>
180004683:     	movsd	(%r8,%rdx,8), %xmm11
180004689:     	mulsd	%xmm11, %xmm11
18000468e:     	movapd	%xmm11, %xmm10
180004693:     	andpd	%xmm4, %xmm10
180004698:     	ucomisd	%xmm5, %xmm10
18000469d:     	jae	0x180004705 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2d95>
18000469f:     	movsd	0x10(%r8,%rdx,8), %xmm10
1800046a6:     	mulsd	%xmm10, %xmm10
1800046ab:     	movapd	%xmm10, %xmm12
1800046b0:     	andpd	%xmm4, %xmm12
1800046b5:     	ucomisd	%xmm5, %xmm12
1800046ba:     	jae	0x180004705 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2d95>
1800046bc:     	addsd	%xmm10, %xmm11
1800046c1:     	movapd	%xmm11, %xmm10
1800046c6:     	andpd	%xmm4, %xmm10
1800046cb:     	ucomisd	%xmm5, %xmm10
1800046d0:     	jae	0x180004705 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2d95>
1800046d2:     	movsd	0x20(%r8,%rdx,8), %xmm12
1800046d9:     	mulsd	%xmm12, %xmm12
1800046de:     	movapd	%xmm12, %xmm10
1800046e3:     	andpd	%xmm4, %xmm10
1800046e8:     	ucomisd	%xmm5, %xmm10
1800046ed:     	jae	0x180004705 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2d95>
1800046ef:     	addsd	%xmm12, %xmm11
1800046f4:     	movapd	%xmm11, %xmm10
1800046f9:     	andpd	%xmm4, %xmm10
1800046fe:     	ucomisd	%xmm5, %xmm10
180004703:     	jb	0x180004726 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2db6>
180004705:     	movb	$0x1, (%rbx)
180004708:     	movq	0x310(%rsp), %rax
180004710:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180004718:     	xorpd	%xmm11, %xmm11
18000471d:     	cmpb	$0x0, (%rbx)
180004720:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004726:     	movapd	%xmm14, %xmm12
18000472b:     	mulsd	%xmm14, %xmm12
180004730:     	movapd	%xmm12, %xmm10
180004735:     	andpd	%xmm4, %xmm10
18000473a:     	ucomisd	%xmm5, %xmm10
18000473f:     	jae	0x180004797 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e27>
180004741:     	subsd	%xmm12, %xmm11
180004746:     	movapd	%xmm11, %xmm10
18000474b:     	andpd	%xmm4, %xmm10
180004750:     	ucomisd	%xmm5, %xmm10
180004755:     	jae	0x180004797 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e27>
180004757:     	subsd	%xmm11, %xmm15
18000475c:     	movapd	%xmm15, %xmm10
180004761:     	andpd	%xmm4, %xmm10
180004766:     	ucomisd	%xmm5, %xmm10
18000476b:     	jae	0x180004797 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e27>
18000476d:     	ucomisd	%xmm15, %xmm13
180004772:     	ja	0x1800045a5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2c35>
180004778:     	xorps	%xmm10, %xmm10
18000477c:     	sqrtsd	%xmm15, %xmm10
180004781:     	subsd	%xmm10, %xmm14
180004786:     	movb	$0x1, %dl
180004788:     	movapd	%xmm14, %xmm13
18000478d:     	cmpb	$0x0, (%rbx)
180004790:     	je	0x1800047b5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e45>
180004792:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004797:     	movb	$0x1, (%rbx)
18000479a:     	movq	0x310(%rsp), %rax
1800047a2:     	movq	$0xe4e1c4, 0x18(%rax)   # imm = 0xE4E1C4
1800047aa:     	xorl	%edx, %edx
1800047ac:     	cmpb	$0x0, (%rbx)
1800047af:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800047b5:     	incq	0x78(%rsp)
1800047ba:     	testb	%dl, %dl
1800047bc:     	je	0x1800040aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x273a>
1800047c2:     	ucomisd	0x4c4d(%rip), %xmm13    # 0x180009418
1800047cb:     	jbe	0x1800040aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x273a>
1800047d1:     	jmp	0x180004c82 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3312>
1800047d6:     	xorl	%edx, %edx
1800047d8:     	incq	0x78(%rsp)
1800047dd:     	testb	%dl, %dl
1800047df:     	jne	0x1800047c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2e52>
1800047e1:     	jmp	0x1800040aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x273a>
1800047e6:     	cmpb	$0x0, (%rbx)
1800047e9:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800047ef:     	movq	0xa0(%rsp), %rax
1800047f7:     	movq	0x90(%rsp), %rdx
1800047ff:     	movq	(%rdx,%rax), %rdi
180004803:     	movq	0xc8(%rsp), %rax
18000480b:     	cmpq	0x8(%rdx,%rax,8), %rdi
180004810:     	jne	0x180004c32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x32c2>
180004816:     	leaq	(%rdi,%rdi), %rdx
18000481a:     	movq	%rdi, 0xe8(%rsp)
180004822:     	testq	%rdi, %rdi
180004825:     	movl	$0x4, %eax
18000482a:     	cmoveq	%rax, %rdx
18000482e:     	movq	0x310(%rsp), %rax
180004836:     	movq	(%rax), %r11
180004839:     	movq	%rdx, 0x1f8(%rsp)
180004841:     	movq	%r11, 0x78(%rsp)
180004846:     	leaq	(%r11,%rdx), %rax
18000484a:     	cmpq	%r15, %rax
18000484d:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004853:     	movq	0x310(%rsp), %rdx
18000485b:     	movq	%rax, (%rdx)
18000485e:     	cmpb	$0x0, (%rbx)
180004861:     	movq	0xe8(%rsp), %rax
180004869:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000486f:     	movq	%r8, 0x88(%rsp)
180004877:     	movq	%rcx, 0x98(%rsp)
18000487f:     	testq	%rax, %rax
180004882:     	jle	0x180004bdb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x326b>
180004888:     	movq	%r9, 0xb0(%rsp)
180004890:     	movq	0x90(%rsp), %rax
180004898:     	movq	0xd8(%rsp), %rcx
1800048a0:     	movq	0x10(%rax,%rcx,8), %r11
1800048a5:     	movq	0xe8(%rsp), %rax
1800048ad:     	movl	%eax, %edx
1800048af:     	andl	$0x7, %edx
1800048b2:     	cmpq	$0x8, %rax
1800048b6:     	jae	0x1800048f8 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2f88>
1800048b8:     	xorl	%ebx, %ebx
1800048ba:     	movq	0xb0(%rsp), %r9
1800048c2:     	movq	0x320(%rsp), %rax
1800048ca:     	leaq	(,%rax,8), %rdi
1800048d2:     	jmp	0x180004ba2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3232>
1800048d7:     	movb	$0x1, (%rbx)
1800048da:     	movq	0x310(%rsp), %rax
1800048e2:     	movq	$0x206cc83, 0x18(%rax)  # imm = 0x206CC83
1800048ea:     	cmpb	$0x0, (%rbx)
1800048ed:     	je	0x180004c82 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3312>
1800048f3:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800048f8:     	movq	0xe8(%rsp), %rcx
180004900:     	movabsq	$0x7ffffffffffffff8, %rax # imm = 0x7FFFFFFFFFFFFFF8
18000490a:     	andq	%rax, %rcx
18000490d:     	movq	%rcx, 0xd0(%rsp)
180004915:     	movq	0xb0(%rsp), %rax
18000491d:     	leaq	(%rax,%r11,8), %rcx
180004921:     	movq	%rcx, 0xe0(%rsp)
180004929:     	movq	0x78(%rsp), %rcx
18000492e:     	leaq	(%rax,%rcx,8), %rbx
180004932:     	xorl	%edi, %edi
180004934:     	movq	0x320(%rsp), %r8
18000493c:     	leaq	(,%r8,8), %rax
180004944:     	movq	%rax, 0xa8(%rsp)
18000494c:     	leaq	0x8(,%r8,8), %rax
180004954:     	movq	%rax, 0x80(%rsp)
18000495c:     	leaq	0x10(,%r8,8), %rax
180004964:     	movq	%rax, 0xf0(%rsp)
18000496c:     	leaq	0x18(,%r8,8), %rax
180004974:     	movq	%rax, 0x120(%rsp)
18000497c:     	leaq	0x20(,%r8,8), %rax
180004984:     	movq	%rax, 0x118(%rsp)
18000498c:     	leaq	0x28(,%r8,8), %rax
180004994:     	movq	%rax, 0x110(%rsp)
18000499c:     	leaq	0x30(,%r8,8), %rax
1800049a4:     	movq	%rax, 0x108(%rsp)
1800049ac:     	leaq	0x38(,%r8,8), %rax
1800049b4:     	movq	%rax, 0x100(%rsp)
1800049bc:     	leaq	(%r11,%rdi), %r8
1800049c0:     	movq	%r8, %rax
1800049c3:     	sarq	$0x3f, %rax
1800049c7:     	movq	0xa8(%rsp), %rcx
1800049cf:     	andq	%rcx, %rax
1800049d2:     	movq	0xe0(%rsp), %r15
1800049da:     	addq	%r15, %rax
1800049dd:     	movq	(%rax,%rdi,8), %rax
1800049e1:     	movq	0x78(%rsp), %r9
1800049e6:     	addq	%rdi, %r9
1800049e9:     	movq	%r9, %r14
1800049ec:     	sarq	$0x3f, %r14
1800049f0:     	andq	%rcx, %r14
1800049f3:     	addq	%rbx, %r14
1800049f6:     	movq	%rax, (%r14,%rdi,8)
1800049fa:     	movq	%r8, %rax
1800049fd:     	incq	%rax
180004a00:     	movl	$0x8, %eax
180004a05:     	movq	0x80(%rsp), %rcx
180004a0d:     	cmovsq	%rcx, %rax
180004a11:     	addq	%r15, %rax
180004a14:     	movq	(%rax,%rdi,8), %rax
180004a18:     	movq	%r9, %r14
180004a1b:     	incq	%r14
180004a1e:     	movl	$0x8, %r14d
180004a24:     	cmovsq	%rcx, %r14
180004a28:     	addq	%rbx, %r14
180004a2b:     	movq	%rax, (%r14,%rdi,8)
180004a2f:     	movq	%r8, %rax
180004a32:     	addq	$0x2, %rax
180004a36:     	movl	$0x10, %eax
180004a3b:     	movq	0xf0(%rsp), %rcx
180004a43:     	cmovsq	%rcx, %rax
180004a47:     	addq	%r15, %rax
180004a4a:     	movq	(%rax,%rdi,8), %rax
180004a4e:     	movq	%r9, %r14
180004a51:     	addq	$0x2, %r14
180004a55:     	movl	$0x10, %r14d
180004a5b:     	cmovsq	%rcx, %r14
180004a5f:     	addq	%rbx, %r14
180004a62:     	movq	%rax, (%r14,%rdi,8)
180004a66:     	movq	%r8, %rax
180004a69:     	addq	$0x3, %rax
180004a6d:     	movl	$0x18, %eax
180004a72:     	movq	0x120(%rsp), %rcx
180004a7a:     	cmovsq	%rcx, %rax
180004a7e:     	addq	%r15, %rax
180004a81:     	movq	(%rax,%rdi,8), %rax
180004a85:     	movq	%r9, %r14
180004a88:     	addq	$0x3, %r14
180004a8c:     	movl	$0x18, %r14d
180004a92:     	cmovsq	%rcx, %r14
180004a96:     	addq	%rbx, %r14
180004a99:     	movq	%rax, (%r14,%rdi,8)
180004a9d:     	movq	%r8, %rax
180004aa0:     	addq	$0x4, %rax
180004aa4:     	movl	$0x20, %eax
180004aa9:     	movq	0x118(%rsp), %rcx
180004ab1:     	cmovsq	%rcx, %rax
180004ab5:     	addq	%r15, %rax
180004ab8:     	movq	(%rax,%rdi,8), %rax
180004abc:     	movq	%r9, %r14
180004abf:     	addq	$0x4, %r14
180004ac3:     	movl	$0x20, %r14d
180004ac9:     	cmovsq	%rcx, %r14
180004acd:     	addq	%rbx, %r14
180004ad0:     	movq	%rax, (%r14,%rdi,8)
180004ad4:     	movq	%r8, %rax
180004ad7:     	addq	$0x5, %rax
180004adb:     	movl	$0x28, %eax
180004ae0:     	movq	0x110(%rsp), %rcx
180004ae8:     	cmovsq	%rcx, %rax
180004aec:     	addq	%r15, %rax
180004aef:     	movq	(%rax,%rdi,8), %rax
180004af3:     	movq	%r9, %r14
180004af6:     	addq	$0x5, %r14
180004afa:     	movl	$0x28, %r14d
180004b00:     	cmovsq	%rcx, %r14
180004b04:     	addq	%rbx, %r14
180004b07:     	movq	%rax, (%r14,%rdi,8)
180004b0b:     	movq	%r8, %rax
180004b0e:     	addq	$0x6, %rax
180004b12:     	movl	$0x30, %eax
180004b17:     	movq	0x108(%rsp), %rcx
180004b1f:     	cmovsq	%rcx, %rax
180004b23:     	addq	%r15, %rax
180004b26:     	movq	(%rax,%rdi,8), %rax
180004b2a:     	movq	%r9, %r14
180004b2d:     	addq	$0x6, %r14
180004b31:     	movl	$0x30, %r14d
180004b37:     	cmovsq	%rcx, %r14
180004b3b:     	addq	%rbx, %r14
180004b3e:     	movq	%rax, (%r14,%rdi,8)
180004b42:     	addq	$0x7, %r8
180004b46:     	movl	$0x38, %eax
180004b4b:     	movq	0x100(%rsp), %rcx
180004b53:     	cmovsq	%rcx, %rax
180004b57:     	addq	%r15, %rax
180004b5a:     	movq	(%rax,%rdi,8), %rax
180004b5e:     	addq	$0x7, %r9
180004b62:     	movl	$0x38, %r8d
180004b68:     	cmovsq	%rcx, %r8
180004b6c:     	addq	%rbx, %r8
180004b6f:     	movq	%rax, (%r8,%rdi,8)
180004b73:     	addq	$0x8, %rdi
180004b77:     	cmpq	%rdi, 0xd0(%rsp)
180004b7f:     	jne	0x1800049bc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x304c>
180004b85:     	movq	0xd0(%rsp), %rbx
180004b8d:     	testq	%rdx, %rdx
180004b90:     	movq	0xb0(%rsp), %r9
180004b98:     	movq	0xa8(%rsp), %rdi
180004ba0:     	je	0x180004bdb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x326b>
180004ba2:     	movq	0x78(%rsp), %rax
180004ba7:     	leaq	(%rbx,%rax), %rcx
180004bab:     	addq	%rbx, %r11
180004bae:     	movq	%r11, %rax
180004bb1:     	sarq	$0x3f, %rax
180004bb5:     	andq	%rdi, %rax
180004bb8:     	addq	%r9, %rax
180004bbb:     	movq	(%rax,%r11,8), %rax
180004bbf:     	movq	%rcx, %r8
180004bc2:     	sarq	$0x3f, %r8
180004bc6:     	andq	%rdi, %r8
180004bc9:     	addq	%r9, %r8
180004bcc:     	movq	%rax, (%r8,%rcx,8)
180004bd0:     	incq	%rcx
180004bd3:     	incq	%r11
180004bd6:     	decq	%rdx
180004bd9:     	jne	0x180004bae <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x323e>
180004bdb:     	movq	0x90(%rsp), %rax
180004be3:     	movq	0xc8(%rsp), %rcx
180004beb:     	movq	0x1f8(%rsp), %rdx
180004bf3:     	movq	%rdx, 0x8(%rax,%rcx,8)
180004bf8:     	movq	0xd8(%rsp), %rcx
180004c00:     	movq	0x78(%rsp), %rdx
180004c05:     	movq	%rdx, 0x10(%rax,%rcx,8)
180004c0a:     	movq	0x98(%rsp), %rcx
180004c12:     	movq	0x88(%rsp), %r8
180004c1a:     	movq	0x318(%rsp), %rbx
180004c22:     	movq	0x320(%rsp), %r15
180004c2a:     	movq	0xe8(%rsp), %rdi
180004c32:     	leaq	0x1(%rdi), %rax
180004c36:     	movq	0xa0(%rsp), %rdx
180004c3e:     	movq	0x90(%rsp), %r11
180004c46:     	movq	%rax, (%r11,%rdx)
180004c4a:     	cmpb	$0x0, (%rbx)
180004c4d:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004c53:     	movq	0x90(%rsp), %rax
180004c5b:     	movq	0xd8(%rsp), %rdx
180004c63:     	addq	0x10(%rax,%rdx,8), %rdi
180004c68:     	movq	%rdi, %rax
180004c6b:     	sarq	$0x3f, %rax
180004c6f:     	andq	%r15, %rax
180004c72:     	leaq	(%r9,%rdi,8), %rdx
180004c76:     	movq	0xf8(%rsp), %r11
180004c7e:     	movq	%r11, (%rdx,%rax,8)
180004c82:     	movq	0xb8(%rsp), %rax
180004c8a:     	movq	0x130(%rsp), %r11
180004c92:     	movq	0xc0(%rsp), %r14
180004c9a:     	cmpq	(%r11,%rax,8), %r14
180004c9e:     	leaq	(,%r15,8), %rdi
180004ca6:     	movq	0x128(%rsp), %rax
180004cae:     	jl	0x18000403f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x26cf>
180004cb4:     	cmpb	$0x0, (%rbx)
180004cb7:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004cbd:     	jmp	0x180005391 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a21>
180004cc2:     	movb	$0x1, (%rbx)
180004cc5:     	movq	$0x18cba83, 0x18(%r14)  # imm = 0x18CBA83
180004ccd:     	jmp	0x180003c62 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22f2>
180004cd2:     	movsd	(%r8,%rdx,8), %xmm0
180004cd8:     	movsd	0x10(%r8,%rdx,8), %xmm1
180004cdf:     	movsd	0x20(%r8,%rdx,8), %xmm2
180004ce6:     	movq	%rdi, (%r14)
180004ce9:     	cmpb	$0x0, (%rbx)
180004cec:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004cf2:     	xorps	%xmm3, %xmm3
180004cf5:     	cvtsi2sd	%rsi, %xmm3
180004cfa:     	movsd	0x46e6(%rip), %xmm4     # 0x1800093e8
180004d02:     	divsd	%xmm3, %xmm4
180004d06:     	mulsd	%xmm4, %xmm0
180004d0a:     	mulsd	%xmm4, %xmm1
180004d0e:     	mulsd	%xmm2, %xmm4
180004d12:     	movsd	%xmm0, (%r8,%r11,8)
180004d18:     	movsd	%xmm1, 0x10(%r8,%r11,8)
180004d1f:     	movsd	%xmm4, 0x20(%r8,%r11,8)
180004d26:     	cmpb	$0x0, (%rbx)
180004d29:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004d2f:     	movsd	(%r8,%rdx,8), %xmm2
180004d35:     	movapd	0x4693(%rip), %xmm0     # 0x1800093d0
180004d3d:     	andpd	%xmm0, %xmm2
180004d41:     	addsd	0x4667(%rip), %xmm2     # 0x1800093b0
180004d49:     	movapd	%xmm2, %xmm3
180004d4d:     	andpd	%xmm0, %xmm3
180004d51:     	movsd	0x46af(%rip), %xmm1     # 0x180009408
180004d59:     	ucomisd	%xmm3, %xmm1
180004d5d:     	jbe	0x180005378 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a08>
180004d63:     	movsd	0x10(%r8,%rdx,8), %xmm3
180004d6a:     	andpd	%xmm0, %xmm3
180004d6e:     	addsd	0x463a(%rip), %xmm3     # 0x1800093b0
180004d76:     	movapd	%xmm3, %xmm4
180004d7a:     	andpd	%xmm0, %xmm4
180004d7e:     	ucomisd	%xmm4, %xmm1
180004d82:     	jbe	0x180005378 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a08>
180004d88:     	cvttsd2si	%xmm2, %rsi
180004d8d:     	cvttsd2si	%xmm3, %rdi
180004d92:     	leaq	(%rdi,%rsi), %r11
180004d96:     	xorq	%r11, %rsi
180004d99:     	xorq	%r11, %rdi
180004d9c:     	movb	$0x1, %r10b
180004d9f:     	testq	%rdi, %rsi
180004da2:     	js	0x180003e77 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2507>
180004da8:     	movsd	0x20(%r8,%rdx,8), %xmm2
180004daf:     	andpd	%xmm0, %xmm2
180004db3:     	addsd	0x45f5(%rip), %xmm2     # 0x1800093b0
180004dbb:     	andpd	%xmm2, %xmm0
180004dbf:     	ucomisd	%xmm0, %xmm1
180004dc3:     	jbe	0x180005378 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a08>
180004dc9:     	cvttsd2si	%xmm2, %rsi
180004dce:     	leaq	(%r11,%rsi), %rdx
180004dd2:     	xorq	%rdx, %r11
180004dd5:     	xorq	%rdx, %rsi
180004dd8:     	testq	%rsi, %r11
180004ddb:     	js	0x180003e77 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x2507>
180004de1:     	movq	%r15, %rbp
180004de4:     	testb	$0x1, %dl
180004de7:     	jne	0x180005b8b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x421b>
180004ded:     	movq	0x10(%rax), %rax
180004df1:     	movq	%rax, %rdx
180004df4:     	sarq	$0x3f, %rdx
180004df8:     	movq	%rbp, %r15
180004dfb:     	andq	%rbp, %rdx
180004dfe:     	leaq	(%r8,%rax,8), %r10
180004e02:     	movsd	(%r10,%rdx,8), %xmm8
180004e08:     	xorl	%edx, %edx
180004e0a:     	cmpq	$-0x2, %rax
180004e0e:     	movl	$0x0, %r11d
180004e14:     	cmovlq	%rbp, %r11
180004e18:     	movsd	0x10(%r10,%r11,8), %xmm7
180004e1f:     	cmpq	$-0x4, %rax
180004e23:     	cmovlq	%rbp, %rdx
180004e27:     	movsd	0x20(%r10,%rdx,8), %xmm6
180004e2e:     	jmp	0x180003c6b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22fb>
180004e33:     	movb	$0x1, (%rbx)
180004e36:     	movq	$0x1e84802, 0x18(%r14)  # imm = 0x1E84802
180004e3e:     	movzbl	(%rbx), %r11d
180004e42:     	movq	$-0x1, %rdx
180004e49:     	testb	%r11b, %r11b
180004e4c:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004e52:     	movsd	(%r8,%rax,8), %xmm0
180004e58:     	subsd	(%r8,%rdx,8), %xmm0
180004e5e:     	movapd	0x456a(%rip), %xmm1     # 0x1800093d0
180004e66:     	andpd	%xmm0, %xmm1
180004e6a:     	ucomisd	0x456e(%rip), %xmm1     # 0x1800093e0
180004e72:     	jae	0x180004f04 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3594>
180004e78:     	movsd	0x10(%r8,%rax,8), %xmm1
180004e7f:     	subsd	0x10(%r8,%rdx,8), %xmm1
180004e86:     	movapd	0x4542(%rip), %xmm2     # 0x1800093d0
180004e8e:     	andpd	%xmm1, %xmm2
180004e92:     	ucomisd	0x4546(%rip), %xmm2     # 0x1800093e0
180004e9a:     	jae	0x180004f04 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3594>
180004e9c:     	movsd	0x20(%r8,%rax,8), %xmm2
180004ea3:     	subsd	0x20(%r8,%rdx,8), %xmm2
180004eaa:     	movapd	0x451e(%rip), %xmm3     # 0x1800093d0
180004eb2:     	andpd	%xmm2, %xmm3
180004eb6:     	ucomisd	0x4522(%rip), %xmm3     # 0x1800093e0
180004ebe:     	jae	0x180004f04 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3594>
180004ec0:     	movq	(%r14), %rax
180004ec3:     	leaq	0x6(%rax), %rdx
180004ec7:     	cmpq	%r15, %rdx
180004eca:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004ed0:     	movq	%rdx, (%r14)
180004ed3:     	cmpb	$0x0, (%rbx)
180004ed6:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004edc:     	movsd	%xmm0, (%r8,%rax,8)
180004ee2:     	movsd	%xmm1, 0x10(%r8,%rax,8)
180004ee9:     	movsd	%xmm2, 0x20(%r8,%rax,8)
180004ef0:     	movzbl	(%rbx), %r10d
180004ef4:     	xorl	%edx, %edx
180004ef6:     	movl	%r10d, %r11d
180004ef9:     	negb	%r11b
180004efc:     	sbbq	%rdx, %rdx
180004eff:     	orq	%rax, %rdx
180004f02:     	jmp	0x180004f1a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x35aa>
180004f04:     	movb	$0x1, (%rbx)
180004f07:     	movq	$0x1f78a43, 0x18(%r14)  # imm = 0x1F78A43
180004f0f:     	movzbl	(%rbx), %r10d
180004f13:     	movq	$-0x1, %rdx
180004f1a:     	testb	%r10b, %r10b
180004f1d:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004f23:     	movq	(%r14), %rax
180004f26:     	leaq	0x2(%rax), %r10
180004f2a:     	cmpq	%r15, %r10
180004f2d:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180004f33:     	movq	%r10, (%r14)
180004f36:     	cmpb	$0x0, (%rbx)
180004f39:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004f3f:     	movq	%r8, 0x88(%rsp)
180004f47:     	movq	%r9, 0xb0(%rsp)
180004f4f:     	movq	%r13, (%r9,%rax,8)
180004f53:     	cmpb	$0x0, (%rbx)
180004f56:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180004f5c:     	movq	%rcx, 0x98(%rsp)
180004f64:     	movq	0x88(%rsp), %rcx
180004f6c:     	movsd	(%rcx,%rdx,8), %xmm0
180004f71:     	mulsd	%xmm0, %xmm0
180004f75:     	movapd	0x4453(%rip), %xmm1     # 0x1800093d0
180004f7d:     	andpd	%xmm0, %xmm1
180004f81:     	ucomisd	0x4457(%rip), %xmm1     # 0x1800093e0
180004f89:     	jae	0x180005013 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x36a3>
180004f8f:     	movq	0x88(%rsp), %rcx
180004f97:     	movsd	0x10(%rcx,%rdx,8), %xmm1
180004f9d:     	mulsd	%xmm1, %xmm1
180004fa1:     	movapd	0x4427(%rip), %xmm2     # 0x1800093d0
180004fa9:     	andpd	%xmm1, %xmm2
180004fad:     	ucomisd	0x442b(%rip), %xmm2     # 0x1800093e0
180004fb5:     	jae	0x180005013 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x36a3>
180004fb7:     	addsd	%xmm1, %xmm0
180004fbb:     	movapd	0x440d(%rip), %xmm1     # 0x1800093d0
180004fc3:     	andpd	%xmm0, %xmm1
180004fc7:     	ucomisd	0x4411(%rip), %xmm1     # 0x1800093e0
180004fcf:     	jae	0x180005013 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x36a3>
180004fd1:     	movq	0x88(%rsp), %rcx
180004fd9:     	movsd	0x20(%rcx,%rdx,8), %xmm1
180004fdf:     	mulsd	%xmm1, %xmm1
180004fe3:     	movapd	0x43e5(%rip), %xmm2     # 0x1800093d0
180004feb:     	andpd	%xmm1, %xmm2
180004fef:     	ucomisd	0x43e9(%rip), %xmm2     # 0x1800093e0
180004ff7:     	jae	0x180005013 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x36a3>
180004ff9:     	addsd	%xmm1, %xmm0
180004ffd:     	movapd	0x43cb(%rip), %xmm1     # 0x1800093d0
180005005:     	andpd	%xmm0, %xmm1
180005009:     	ucomisd	0x43cf(%rip), %xmm1     # 0x1800093e0
180005011:     	jb	0x18000503b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x36cb>
180005013:     	movq	0x318(%rsp), %rcx
18000501b:     	movb	$0x1, (%rcx)
18000501e:     	movq	$0x14fb183, 0x18(%r14)  # imm = 0x14FB183
180005026:     	cmpb	$0x0, (%rcx)
180005029:     	movq	0x98(%rsp), %rcx
180005031:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005037:     	xorpd	%xmm0, %xmm0
18000503b:     	sqrtsd	%xmm0, %xmm0
18000503f:     	xorpd	%xmm1, %xmm1
180005043:     	ucomisd	%xmm1, %xmm0
180005047:     	jne	0x180005c18 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x42a8>
18000504d:     	jp	0x180005c18 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x42a8>
180005053:     	movq	0x318(%rsp), %rcx
18000505b:     	movb	$0x1, (%rcx)
18000505e:     	movq	$0x3d0902, 0x18(%r14)   # imm = 0x3D0902
180005066:     	movzbl	(%rcx), %ecx
180005069:     	movq	$-0x1, %rdx
180005070:     	testb	%cl, %cl
180005072:     	movq	0x98(%rsp), %rcx
18000507a:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005080:     	movq	0xb0(%rsp), %r8
180005088:     	movq	%rdx, 0x8(%r8,%rax,8)
18000508d:     	movq	0x318(%rsp), %rdx
180005095:     	cmpb	$0x0, (%rdx)
180005098:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000509e:     	movq	0x8(%r14), %rcx
1800050a2:     	leaq	0x1(%rcx), %rdx
1800050a6:     	movq	%rdx, 0x8(%r14)
1800050aa:     	cmpq	0x10(%r14), %rcx
1800050ae:     	jge	0x180005f8e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x461e>
1800050b4:     	movq	$0x0, 0x138(%rsp)
1800050c0:     	movb	$0x0, 0x140(%rsp)
1800050c8:     	movq	$0x0, 0x148(%rsp)
1800050d4:     	movb	$0x0, 0x150(%rsp)
1800050dc:     	movq	$0x0, 0x158(%rsp)
1800050e8:     	movb	$0x0, 0x160(%rsp)
1800050f0:     	movq	$0x0, 0x168(%rsp)
1800050fc:     	movb	$0x0, 0x170(%rsp)
180005104:     	movq	$0x0, 0x178(%rsp)
180005110:     	movb	$0x0, 0x180(%rsp)
180005118:     	movq	$0x0, 0x188(%rsp)
180005124:     	movb	$0x0, 0x190(%rsp)
18000512c:     	movq	%rax, 0x48(%rsp)
180005131:     	movq	%rsi, 0x40(%rsp)
180005136:     	movq	%r15, 0x30(%rsp)
18000513b:     	movq	%rbx, 0x28(%rsp)
180005140:     	movq	%r14, 0x20(%rsp)
180005145:     	movq	$-0x1, 0x70(%rsp)
18000514e:     	movq	$-0x1, 0x68(%rsp)
180005157:     	movq	$-0x1, 0x60(%rsp)
180005160:     	movq	$-0x1, 0x58(%rsp)
180005169:     	movq	$-0x1, 0x50(%rsp)
180005172:     	movq	$0x0, 0x38(%rsp)
18000517b:     	leaq	0x138(%rsp), %rcx
180005183:     	movq	0x88(%rsp), %r8
18000518b:     	movq	0xb0(%rsp), %r9
180005193:     	callq	0x180002f10 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x15a0>
180005198:     	cmpb	$0x0, (%rbx)
18000519b:     	jne	0x180005fa1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4631>
1800051a1:     	movsd	0x158(%rsp), %xmm2
1800051aa:     	movsd	0x138(%rsp), %xmm0
1800051b3:     	movsd	0x148(%rsp), %xmm1
1800051bc:     	decq	0x8(%r14)
1800051c0:     	movq	0x318(%rsp), %rax
1800051c8:     	cmpb	$0x0, (%rax)
1800051cb:     	jne	0x180005fa1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4631>
1800051d1:     	movq	0x88(%rsp), %r8
1800051d9:     	movsd	0x20(%r8,%r12,8), %xmm3
1800051e0:     	shlq	$0x3, %r12
1800051e4:     	mulsd	%xmm3, %xmm0
1800051e8:     	xorpd	%xmm4, %xmm4
1800051ec:     	addsd	%xmm4, %xmm0
1800051f0:     	mulsd	%xmm3, %xmm1
1800051f4:     	addsd	%xmm4, %xmm1
1800051f8:     	mulsd	%xmm3, %xmm2
1800051fc:     	addsd	%xmm4, %xmm2
180005200:     	movq	0x98(%rsp), %rcx
180005208:     	movq	0xb0(%rsp), %r9
180005210:     	movq	0x318(%rsp), %rbx
180005218:     	movsd	0x18(%r8,%r12), %xmm4
18000521f:     	xorpd	%xmm3, %xmm3
180005223:     	ucomisd	%xmm3, %xmm4
180005227:     	ja	0x180003cba <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x234a>
18000522d:     	jmp	0x180005888 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f18>
180005232:     	shlq	$0x3, %r12
180005236:     	movq	0xc0(%rsp), %rax
18000523e:     	movq	(%rax,%r12), %r10
180005242:     	testq	%r10, %r10
180005245:     	jle	0x18000574c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ddc>
18000524b:     	movq	0x10(%rax,%r11,8), %r11
180005250:     	xorpd	%xmm0, %xmm0
180005254:     	movq	$-0x1, 0x78(%rsp)
18000525d:     	xorl	%r14d, %r14d
180005260:     	movsd	0x41b8(%rip), %xmm1     # 0x180009420
180005268:     	xorl	%r13d, %r13d
18000526b:     	movq	$-0x1, %rdi
180005272:     	jmp	0x180005292 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3922>
180005274:     	movq	%rdx, %rdi
180005277:     	movapd	%xmm2, %xmm0
18000527b:     	movb	$0x1, %r13b
18000527e:     	movq	%r12, 0x78(%rsp)
180005283:     	movb	$0x1, %r14b
180005286:     	incq	%r11
180005289:     	decq	%r10
18000528c:     	je	0x180005325 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x39b5>
180005292:     	movq	%r11, %rax
180005295:     	sarq	$0x3f, %rax
180005299:     	leaq	(,%r15,8), %rdx
1800052a1:     	andq	%rdx, %rax
1800052a4:     	addq	%r9, %rax
1800052a7:     	movq	(%rax,%r11,8), %r12
1800052ab:     	leaq	(%r9,%r12,8), %rbp
1800052af:     	cmpq	$-0x1, %r12
1800052b3:     	movl	$0x0, %edx
1800052b8:     	cmovlq	%r15, %rdx
1800052bc:     	cmpq	$-0x2, %r12
1800052c0:     	movl	$0x0, %esi
1800052c5:     	cmovlq	%r15, %rsi
1800052c9:     	cmpq	$-0x3, %r12
1800052cd:     	movl	$0x0, %eax
1800052d2:     	cmovlq	%r15, %rax
1800052d6:     	cmpq	$0x0, 0x10(%rbp,%rsi,8)
1800052dc:     	je	0x180005286 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3916>
1800052de:     	leaq	(%r8,%r12,8), %rsi
1800052e2:     	movsd	0x8(%rsi,%rdx,8), %xmm2
1800052e8:     	ucomisd	%xmm1, %xmm2
1800052ec:     	jbe	0x180005286 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3916>
1800052ee:     	sarq	$0x3f, %r12
1800052f2:     	andq	%r15, %r12
1800052f5:     	movq	(%rbp,%r12,8), %rdx
1800052fa:     	movq	0x18(%rbp,%rax,8), %r12
1800052ff:     	testb	$0x1, %r14b
180005303:     	je	0x180005274 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3904>
180005309:     	testb	$0x1, %r13b
18000530d:     	je	0x180005739 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3dc9>
180005313:     	ucomisd	%xmm2, %xmm0
180005317:     	ja	0x180005274 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3904>
18000531d:     	movb	$0x1, %r13b
180005320:     	jmp	0x180005283 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3913>
180005325:     	cmpb	$0x0, (%rbx)
180005328:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
18000532e:     	testb	$0x1, %r14b
180005332:     	je	0x180005751 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3de1>
180005338:     	movq	%rcx, %r12
18000533b:     	movq	%r9, %rsi
18000533e:     	movq	0x338(%rsp), %rax
180005346:     	movq	(%r9,%rax,8), %rcx
18000534a:     	testb	$0x1, %r13b
18000534e:     	je	0x1800058fd <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f8d>
180005354:     	movq	%rbx, %r14
180005357:     	movq	0x310(%rsp), %rax
18000535f:     	movq	(%rax), %r10
180005362:     	leaq	0x6(%r10), %rax
180005366:     	cmpq	%r15, %rax
180005369:     	jle	0x1800059f7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4087>
18000536f:     	movb	$0x2, (%r14)
180005373:     	jmp	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005378:     	movb	$0x1, (%rbx)
18000537b:     	movq	$0x18cba84, 0x18(%r14)  # imm = 0x18CBA84
180005383:     	jmp	0x180003c62 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22f2>
180005388:     	shlq	$0x3, 0xa0(%rsp)
180005391:     	movq	0xa0(%rsp), %r14
180005399:     	movq	0x90(%rsp), %rax
1800053a1:     	cmpq	$0x0, (%rax,%r14)
1800053a6:     	jle	0x180005852 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ee2>
1800053ac:     	leaq	(,%r15,8), %rdx
1800053b4:     	xorl	%r11d, %r11d
1800053b7:     	cmpq	$-0x2, %r10
1800053bb:     	cmovgeq	%r11, %rdx
1800053bf:     	xorpd	%xmm5, %xmm5
1800053c3:     	movapd	0x4004(%rip), %xmm9     # 0x1800093d0
1800053cc:     	movsd	0x400b(%rip), %xmm10    # 0x1800093e0
1800053d5:     	xorpd	%xmm4, %xmm4
1800053d9:     	movq	0x310(%rsp), %rdi
1800053e1:     	movq	0x10(%rax,%rdx), %rax
1800053e6:     	addq	%r11, %rax
1800053e9:     	leaq	(%r9,%rax,8), %r10
1800053ed:     	sarq	$0x3f, %rax
1800053f1:     	andq	%r15, %rax
1800053f4:     	movq	(%r10,%rax,8), %r10
1800053f8:     	movsd	(%r8,%r10,8), %xmm12
1800053fe:     	subsd	(%r8,%r13,8), %xmm12
180005404:     	movapd	%xmm12, %xmm13
180005409:     	andpd	%xmm9, %xmm13
18000540e:     	ucomisd	%xmm10, %xmm13
180005413:     	jae	0x18000549e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b2e>
180005419:     	movsd	0x10(%r8,%r10,8), %xmm13
180005420:     	subsd	0x10(%r8,%r13,8), %xmm13
180005427:     	movapd	%xmm13, %xmm14
18000542c:     	andpd	%xmm9, %xmm14
180005431:     	ucomisd	%xmm10, %xmm14
180005436:     	jae	0x18000549e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b2e>
180005438:     	movsd	0x20(%r8,%r10,8), %xmm14
18000543f:     	subsd	0x20(%r8,%r13,8), %xmm14
180005446:     	movapd	%xmm14, %xmm15
18000544b:     	andpd	%xmm9, %xmm15
180005450:     	ucomisd	%xmm10, %xmm15
180005455:     	jae	0x18000549e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b2e>
180005457:     	movq	(%rdi), %rsi
18000545a:     	leaq	0x6(%rsi), %rax
18000545e:     	cmpq	%r15, %rax
180005461:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
180005467:     	movq	%rax, (%rdi)
18000546a:     	cmpb	$0x0, (%rbx)
18000546d:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005473:     	movsd	%xmm12, (%r8,%rsi,8)
180005479:     	movsd	%xmm13, 0x10(%r8,%rsi,8)
180005480:     	movsd	%xmm14, 0x20(%r8,%rsi,8)
180005487:     	movzbl	(%rbx), %eax
18000548a:     	movl	%eax, %r10d
18000548d:     	negb	%r10b
180005490:     	movl	$0x0, %r10d
180005496:     	sbbq	%r10, %r10
180005499:     	orq	%rsi, %r10
18000549c:     	jmp	0x1800054b3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3b43>
18000549e:     	movb	$0x1, (%rbx)
1800054a1:     	movq	$0xf4243, 0x18(%rdi)    # imm = 0xF4243
1800054a9:     	movzbl	(%rbx), %eax
1800054ac:     	movq	$-0x1, %r10
1800054b3:     	testb	%al, %al
1800054b5:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800054bb:     	movsd	(%r8,%r10,8), %xmm12
1800054c1:     	mulsd	%xmm12, %xmm12
1800054c6:     	movapd	%xmm12, %xmm13
1800054cb:     	andpd	%xmm9, %xmm13
1800054d0:     	ucomisd	%xmm10, %xmm13
1800054d5:     	jae	0x18000553d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3bcd>
1800054d7:     	movsd	0x10(%r8,%r10,8), %xmm13
1800054de:     	mulsd	%xmm13, %xmm13
1800054e3:     	movapd	%xmm13, %xmm14
1800054e8:     	andpd	%xmm9, %xmm14
1800054ed:     	ucomisd	%xmm10, %xmm14
1800054f2:     	jae	0x18000553d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3bcd>
1800054f4:     	addsd	%xmm13, %xmm12
1800054f9:     	movapd	%xmm12, %xmm13
1800054fe:     	andpd	%xmm9, %xmm13
180005503:     	ucomisd	%xmm10, %xmm13
180005508:     	jae	0x18000553d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3bcd>
18000550a:     	movsd	0x20(%r8,%r10,8), %xmm13
180005511:     	mulsd	%xmm13, %xmm13
180005516:     	movapd	%xmm13, %xmm14
18000551b:     	andpd	%xmm9, %xmm14
180005520:     	ucomisd	%xmm10, %xmm14
180005525:     	jae	0x18000553d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3bcd>
180005527:     	addsd	%xmm13, %xmm12
18000552c:     	movapd	%xmm12, %xmm13
180005531:     	andpd	%xmm9, %xmm13
180005536:     	ucomisd	%xmm10, %xmm13
18000553b:     	jb	0x180005556 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3be6>
18000553d:     	movb	$0x1, (%rbx)
180005540:     	movq	$0x14fb183, 0x18(%rdi)  # imm = 0x14FB183
180005548:     	xorpd	%xmm12, %xmm12
18000554d:     	cmpb	$0x0, (%rbx)
180005550:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005556:     	sqrtsd	%xmm12, %xmm12
18000555b:     	ucomisd	%xmm5, %xmm12
180005560:     	jne	0x18000557b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3c0b>
180005562:     	jp	0x18000557b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3c0b>
180005564:     	movb	$0x1, (%rbx)
180005567:     	movq	$0x3d0902, 0x18(%rdi)   # imm = 0x3D0902
18000556f:     	movzbl	(%rbx), %eax
180005572:     	movq	$-0x1, %r10
180005579:     	jmp	0x1800055f1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3c81>
18000557b:     	movq	(%rdi), %rsi
18000557e:     	leaq	0x6(%rsi), %rax
180005582:     	cmpq	%r15, %rax
180005585:     	jg	0x180003cda <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x236a>
18000558b:     	movsd	(%r8,%r10,8), %xmm13
180005591:     	movsd	0x10(%r8,%r10,8), %xmm14
180005598:     	movsd	0x20(%r8,%r10,8), %xmm15
18000559f:     	movq	%rax, (%rdi)
1800055a2:     	cmpb	$0x0, (%rbx)
1800055a5:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800055ab:     	movsd	0x3e34(%rip), %xmm11    # 0x1800093e8
1800055b4:     	divsd	%xmm12, %xmm11
1800055b9:     	mulsd	%xmm11, %xmm13
1800055be:     	mulsd	%xmm11, %xmm14
1800055c3:     	mulsd	%xmm15, %xmm11
1800055c8:     	movsd	%xmm13, (%r8,%rsi,8)
1800055ce:     	movsd	%xmm14, 0x10(%r8,%rsi,8)
1800055d5:     	movsd	%xmm11, 0x20(%r8,%rsi,8)
1800055dc:     	movzbl	(%rbx), %eax
1800055df:     	movl	%eax, %r10d
1800055e2:     	negb	%r10b
1800055e5:     	movl	$0x0, %r10d
1800055eb:     	sbbq	%r10, %r10
1800055ee:     	orq	%rsi, %r10
1800055f1:     	testb	%al, %al
1800055f3:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800055f9:     	movsd	(%r8,%r10,8), %xmm12
1800055ff:     	mulsd	(%r8,%rbp,8), %xmm12
180005605:     	movapd	%xmm12, %xmm11
18000560a:     	andpd	%xmm9, %xmm11
18000560f:     	ucomisd	%xmm10, %xmm11
180005614:     	jae	0x1800056c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d52>
18000561a:     	movsd	0x10(%r8,%r10,8), %xmm13
180005621:     	mulsd	0x10(%r8,%rbp,8), %xmm13
180005628:     	movapd	%xmm13, %xmm11
18000562d:     	andpd	%xmm9, %xmm11
180005632:     	ucomisd	%xmm10, %xmm11
180005637:     	jae	0x1800056c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d52>
18000563d:     	addsd	%xmm13, %xmm12
180005642:     	movapd	%xmm12, %xmm11
180005647:     	andpd	%xmm9, %xmm11
18000564c:     	ucomisd	%xmm10, %xmm11
180005651:     	jae	0x1800056c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d52>
180005653:     	movsd	0x20(%r8,%r10,8), %xmm13
18000565a:     	mulsd	0x20(%r8,%rbp,8), %xmm13
180005661:     	movapd	%xmm13, %xmm11
180005666:     	andpd	%xmm9, %xmm11
18000566b:     	ucomisd	%xmm10, %xmm11
180005670:     	jae	0x1800056c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d52>
180005672:     	addsd	%xmm13, %xmm12
180005677:     	movapd	%xmm12, %xmm11
18000567c:     	andpd	%xmm9, %xmm11
180005681:     	ucomisd	%xmm10, %xmm11
180005686:     	jae	0x1800056c2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d52>
180005688:     	ucomisd	%xmm5, %xmm12
18000568d:     	jbe	0x1800056f0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d80>
18000568f:     	addsd	%xmm12, %xmm4
180005694:     	movapd	%xmm4, %xmm11
180005699:     	andpd	%xmm9, %xmm11
18000569e:     	ucomisd	%xmm10, %xmm11
1800056a3:     	movq	0x310(%rsp), %rdi
1800056ab:     	movq	0xa0(%rsp), %r14
1800056b3:     	movq	0x90(%rsp), %rax
1800056bb:     	jb	0x1800056de <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3d6e>
1800056bd:     	jmp	0x180005f7e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x460e>
1800056c2:     	movb	$0x1, (%rbx)
1800056c5:     	movq	$0x14fb183, 0x18(%rdi)  # imm = 0x14FB183
1800056cd:     	cmpb	$0x0, (%rbx)
1800056d0:     	movq	0x90(%rsp), %rax
1800056d8:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800056de:     	incq	%r11
1800056e1:     	cmpq	(%rax,%r14), %r11
1800056e5:     	jl	0x1800053e1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a71>
1800056eb:     	jmp	0x180005856 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ee6>
1800056f0:     	movq	0x310(%rsp), %rdi
1800056f8:     	movq	0xa0(%rsp), %r14
180005700:     	movq	0x90(%rsp), %rax
180005708:     	incq	%r11
18000570b:     	cmpq	(%rax,%r14), %r11
18000570f:     	jl	0x1800053e1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3a71>
180005715:     	jmp	0x180005856 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ee6>
18000571a:     	movq	0xb8(%rsp), %r11
180005722:     	movq	0xc0(%rsp), %rax
18000572a:     	movq	(%rax,%r12), %r10
18000572e:     	testq	%r10, %r10
180005731:     	jg	0x18000524b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x38db>
180005737:     	jmp	0x18000574c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ddc>
180005739:     	movb	$0x1, (%rbx)
18000573c:     	movq	0x310(%rsp), %rax
180005744:     	movq	$0x1036646, 0x18(%rax)  # imm = 0x1036646
18000574c:     	cmpb	$0x0, (%rbx)
18000574f:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005751:     	movq	0x330(%rsp), %rdi
180005759:     	movq	0x28(%r9,%rdi,8), %rax
18000575e:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005768:     	addq	$0x8, %rdx
18000576c:     	cmpq	%rdx, %rax
18000576f:     	jne	0x180005845 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3ed5>
180005775:     	movb	$0x1, (%rbx)
180005778:     	movq	$0x0, 0x58(%rcx)
180005780:     	movq	$0x0, 0x50(%rcx)
180005788:     	movq	$0x0, 0x48(%rcx)
180005790:     	movq	$0x0, 0x40(%rcx)
180005798:     	movq	$0x0, 0x38(%rcx)
1800057a0:     	movq	$0x0, 0x30(%rcx)
1800057a8:     	movq	$0x0, 0x28(%rcx)
1800057b0:     	movq	$0x0, 0x20(%rcx)
1800057b8:     	movq	$0x0, 0x18(%rcx)
1800057c0:     	movq	$0x0, 0x10(%rcx)
1800057c8:     	movq	$0x0, 0x8(%rcx)
1800057d0:     	movq	$0x0, (%rcx)
1800057d7:     	xorl	%eax, %eax
1800057d9:     	movaps	0x200(%rsp), %xmm6
1800057e1:     	movaps	0x210(%rsp), %xmm7
1800057e9:     	movaps	0x220(%rsp), %xmm8
1800057f2:     	movaps	0x230(%rsp), %xmm9
1800057fb:     	movaps	0x240(%rsp), %xmm10
180005804:     	movaps	0x250(%rsp), %xmm11
18000580d:     	movaps	0x260(%rsp), %xmm12
180005816:     	movaps	0x270(%rsp), %xmm13
18000581f:     	movaps	0x280(%rsp), %xmm14
180005828:     	movaps	0x290(%rsp), %xmm15
180005831:     	addq	$0x2a8, %rsp            # imm = 0x2A8
180005838:     	popq	%rbx
180005839:     	popq	%rbp
18000583a:     	popq	%rdi
18000583b:     	popq	%rsi
18000583c:     	popq	%r12
18000583e:     	popq	%r13
180005840:     	popq	%r14
180005842:     	popq	%r15
180005844:     	retq
180005845:     	decq	%rax
180005848:     	movq	%rax, 0x28(%r9,%rdi,8)
18000584d:     	jmp	0x1800030bb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x174b>
180005852:     	xorpd	%xmm4, %xmm4
180005856:     	minsd	0x3b8a(%rip), %xmm4     # 0x1800093e8
18000585e:     	mulsd	0x18(%r8,%r12), %xmm4
180005865:     	movapd	%xmm8, %xmm5
18000586a:     	mulsd	%xmm4, %xmm5
18000586e:     	addsd	%xmm5, %xmm0
180005872:     	movapd	%xmm7, %xmm5
180005876:     	mulsd	%xmm4, %xmm5
18000587a:     	addsd	%xmm5, %xmm1
18000587e:     	mulsd	%xmm6, %xmm4
180005882:     	addsd	%xmm4, %xmm2
180005886:     	xorl	%edi, %edi
180005888:     	movsd	0x8(%r8,%r12), %xmm4
18000588f:     	ucomisd	%xmm3, %xmm4
180005893:     	jbe	0x1800058b1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3f41>
180005895:     	mulsd	%xmm4, %xmm8
18000589a:     	addsd	%xmm8, %xmm0
18000589f:     	mulsd	%xmm4, %xmm7
1800058a3:     	addsd	%xmm7, %xmm1
1800058a7:     	mulsd	%xmm4, %xmm6
1800058ab:     	addsd	%xmm6, %xmm2
1800058af:     	xorl	%edi, %edi
1800058b1:     	movb	%dil, 0x58(%rcx)
1800058b5:     	movsd	%xmm2, 0x50(%rcx)
1800058ba:     	movb	%dil, 0x48(%rcx)
1800058be:     	movsd	%xmm1, 0x40(%rcx)
1800058c3:     	movb	%dil, 0x38(%rcx)
1800058c7:     	movsd	%xmm0, 0x30(%rcx)
1800058cc:     	movb	$0x0, 0x28(%rcx)
1800058d0:     	movq	$0x0, 0x20(%rcx)
1800058d8:     	movb	$0x0, 0x18(%rcx)
1800058dc:     	movq	$0x0, 0x10(%rcx)
1800058e4:     	movb	$0x0, 0x8(%rcx)
1800058e8:     	jmp	0x1800057d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e60>
1800058ed:     	movb	$0x1, (%rbx)
1800058f0:     	movq	$0x6acfc6, 0x18(%r14)   # imm = 0x6ACFC6
1800058f8:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
1800058fd:     	movq	%r15, %r13
180005900:     	movb	$0x1, (%rbx)
180005903:     	movq	0x310(%rsp), %rax
18000590b:     	movq	$0x15ef3c2, 0x18(%rax)  # imm = 0x15EF3C2
180005913:     	movq	%rbx, %r14
180005916:     	movzbl	(%rbx), %r11d
18000591a:     	movq	$-0x1, %r9
180005921:     	testb	%r11b, %r11b
180005924:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
18000592a:     	movsd	(%r8,%rcx,8), %xmm0
180005930:     	addsd	(%r8,%r9,8), %xmm0
180005936:     	movapd	0x3a92(%rip), %xmm1     # 0x1800093d0
18000593e:     	andpd	%xmm0, %xmm1
180005942:     	ucomisd	0x3a96(%rip), %xmm1     # 0x1800093e0
18000594a:     	jae	0x180005a70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4100>
180005950:     	movsd	0x10(%r8,%rcx,8), %xmm1
180005957:     	addsd	0x10(%r8,%r9,8), %xmm1
18000595e:     	movapd	0x3a6a(%rip), %xmm2     # 0x1800093d0
180005966:     	andpd	%xmm1, %xmm2
18000596a:     	ucomisd	0x3a6e(%rip), %xmm2     # 0x1800093e0
180005972:     	jae	0x180005a70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4100>
180005978:     	movsd	0x20(%r8,%rcx,8), %xmm2
18000597f:     	addsd	0x20(%r8,%r9,8), %xmm2
180005986:     	movapd	0x3a42(%rip), %xmm3     # 0x1800093d0
18000598e:     	andpd	%xmm2, %xmm3
180005992:     	ucomisd	0x3a46(%rip), %xmm3     # 0x1800093e0
18000599a:     	jae	0x180005a70 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4100>
1800059a0:     	movq	0x310(%rsp), %rax
1800059a8:     	movq	(%rax), %r9
1800059ab:     	leaq	0x6(%r9), %rax
1800059af:     	cmpq	%r13, %rax
1800059b2:     	jg	0x18000536f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x39ff>
1800059b8:     	movq	0x310(%rsp), %rcx
1800059c0:     	movq	%rax, (%rcx)
1800059c3:     	cmpb	$0x0, (%r14)
1800059c7:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
1800059cd:     	movsd	%xmm0, (%r8,%r9,8)
1800059d3:     	movsd	%xmm1, 0x10(%r8,%r9,8)
1800059da:     	movsd	%xmm2, 0x20(%r8,%r9,8)
1800059e1:     	movzbl	(%r14), %r10d
1800059e5:     	xorl	%ecx, %ecx
1800059e7:     	movl	%r10d, %eax
1800059ea:     	negb	%al
1800059ec:     	sbbq	%rcx, %rcx
1800059ef:     	orq	%r9, %rcx
1800059f2:     	jmp	0x180005a8f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x411f>
1800059f7:     	movq	0x338(%rsp), %rdx
1800059ff:     	movq	0x8(%rsi,%rdx,8), %rdx
180005a04:     	movsd	(%r8,%rdx,8), %xmm1
180005a0a:     	movsd	0x10(%r8,%rdx,8), %xmm2
180005a11:     	movsd	0x20(%r8,%rdx,8), %xmm3
180005a18:     	movq	0x310(%rsp), %rdx
180005a20:     	movq	%rax, (%rdx)
180005a23:     	cmpb	$0x0, (%r14)
180005a27:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005a2d:     	movq	%r15, %r13
180005a30:     	mulsd	%xmm0, %xmm1
180005a34:     	mulsd	%xmm0, %xmm2
180005a38:     	mulsd	%xmm0, %xmm3
180005a3c:     	movsd	%xmm1, (%r8,%r10,8)
180005a42:     	movsd	%xmm2, 0x10(%r8,%r10,8)
180005a49:     	movsd	%xmm3, 0x20(%r8,%r10,8)
180005a50:     	movzbl	(%r14), %r11d
180005a54:     	xorl	%r9d, %r9d
180005a57:     	movl	%r11d, %eax
180005a5a:     	negb	%al
180005a5c:     	sbbq	%r9, %r9
180005a5f:     	orq	%r10, %r9
180005a62:     	testb	%r11b, %r11b
180005a65:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005a6b:     	jmp	0x18000592a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3fba>
180005a70:     	movb	$0x1, (%r14)
180005a74:     	movq	0x310(%rsp), %rax
180005a7c:     	movq	$0x16e3603, 0x18(%rax)  # imm = 0x16E3603
180005a84:     	movzbl	(%r14), %r10d
180005a88:     	movq	$-0x1, %rcx
180005a8f:     	testb	%r10b, %r10b
180005a92:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005a98:     	leaq	(%rsi,%rdi,8), %r9
180005a9c:     	sarq	$0x3f, %rdi
180005aa0:     	andq	%r13, %rdi
180005aa3:     	movq	(%r9,%rdi,8), %rax
180005aa7:     	cmpq	$0x1, %rax
180005aab:     	je	0x180005c40 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x42d0>
180005ab1:     	testq	%rax, %rax
180005ab4:     	jne	0x180005d87 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4417>
180005aba:     	movq	0x8(%r9), %rdx
180005abe:     	movsd	(%r8,%rcx,8), %xmm0
180005ac4:     	subsd	(%r8,%rdx,8), %xmm0
180005aca:     	movapd	0x38fe(%rip), %xmm1     # 0x1800093d0
180005ad2:     	andpd	%xmm0, %xmm1
180005ad6:     	ucomisd	0x3902(%rip), %xmm1     # 0x1800093e0
180005ade:     	jae	0x180005da0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4430>
180005ae4:     	movsd	0x10(%r8,%rcx,8), %xmm1
180005aeb:     	subsd	0x10(%r8,%rdx,8), %xmm1
180005af2:     	movapd	0x38d6(%rip), %xmm2     # 0x1800093d0
180005afa:     	andpd	%xmm1, %xmm2
180005afe:     	ucomisd	0x38da(%rip), %xmm2     # 0x1800093e0
180005b06:     	jae	0x180005da0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4430>
180005b0c:     	movsd	0x20(%r8,%rcx,8), %xmm2
180005b13:     	subsd	0x20(%r8,%rdx,8), %xmm2
180005b1a:     	movapd	0x38ae(%rip), %xmm3     # 0x1800093d0
180005b22:     	andpd	%xmm2, %xmm3
180005b26:     	ucomisd	0x38b2(%rip), %xmm3     # 0x1800093e0
180005b2e:     	jae	0x180005da0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4430>
180005b34:     	movq	0x310(%rsp), %rax
180005b3c:     	movq	(%rax), %r9
180005b3f:     	leaq	0x6(%r9), %rax
180005b43:     	cmpq	%r13, %rax
180005b46:     	jg	0x18000536f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x39ff>
180005b4c:     	movq	0x310(%rsp), %rdx
180005b54:     	movq	%rax, (%rdx)
180005b57:     	cmpb	$0x0, (%r14)
180005b5b:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005b61:     	movsd	%xmm0, (%r8,%r9,8)
180005b67:     	movsd	%xmm1, 0x10(%r8,%r9,8)
180005b6e:     	movsd	%xmm2, 0x20(%r8,%r9,8)
180005b75:     	movzbl	(%r14), %r10d
180005b79:     	xorl	%edx, %edx
180005b7b:     	movl	%r10d, %eax
180005b7e:     	negb	%al
180005b80:     	sbbq	%rdx, %rdx
180005b83:     	orq	%r9, %rdx
180005b86:     	jmp	0x180005dbf <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x444f>
180005b8b:     	movabsq	$-0x20000000000001, %rdx # imm = 0xFFDFFFFFFFFFFFFF
180005b95:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
180005b9f:     	movq	0x30(%rax), %r14
180005ba3:     	movq	%r14, %rax
180005ba6:     	sarq	$0x3f, %rax
180005baa:     	andq	%rbp, %rax
180005bad:     	leaq	(%r9,%r14,8), %r11
180005bb1:     	movq	(%r11,%rax,8), %rax
180005bb5:     	xorl	%esi, %esi
180005bb7:     	cmpq	$-0x1, %r14
180005bbb:     	movl	$0x0, %edi
180005bc0:     	cmovlq	%rbp, %rdi
180005bc4:     	cmpq	$-0x2, %r14
180005bc8:     	cmovlq	%rbp, %rsi
180005bcc:     	leaq	(%rax,%rdx), %r14
180005bd0:     	cmpq	%r10, %r14
180005bd3:     	jb	0x180005bf4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4284>
180005bd5:     	movq	0x8(%r11,%rdi,8), %rdi
180005bda:     	leaq	(%rdi,%rdx), %r14
180005bde:     	cmpq	%r10, %r14
180005be1:     	jb	0x180005bf4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4284>
180005be3:     	movq	0x10(%r11,%rsi,8), %r11
180005be8:     	addq	%r11, %rdx
180005beb:     	cmpq	%r10, %rdx
180005bee:     	jae	0x180005f5f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x45ef>
180005bf4:     	movb	$0x1, (%rbx)
180005bf7:     	movq	0x310(%rsp), %r14
180005bff:     	movq	$0x18cba87, 0x18(%r14)  # imm = 0x18CBA87
180005c07:     	xorpd	%xmm7, %xmm7
180005c0b:     	xorpd	%xmm8, %xmm8
180005c10:     	movq	%rbp, %r15
180005c13:     	jmp	0x180003c6b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22fb>
180005c18:     	movq	(%r14), %r8
180005c1b:     	leaq	0x6(%r8), %rcx
180005c1f:     	cmpq	%r15, %rcx
180005c22:     	jle	0x180005ec5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4555>
180005c28:     	movq	0x318(%rsp), %rax
180005c30:     	movb	$0x2, (%rax)
180005c33:     	movq	0x98(%rsp), %rcx
180005c3b:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005c40:     	movq	0x20(%r9), %rdx
180005c44:     	movq	0x310(%rsp), %r10
180005c4c:     	movq	0x8(%r10), %rax
180005c50:     	leaq	0x1(%rax), %r9
180005c54:     	movq	%r9, 0x8(%r10)
180005c58:     	cmpq	0x10(%r10), %rax
180005c5c:     	jge	0x180005d87 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4417>
180005c62:     	movq	$0x0, 0x1c8(%rsp)
180005c6e:     	movb	$0x0, 0x1d0(%rsp)
180005c76:     	movq	$0x0, 0x1d8(%rsp)
180005c82:     	movb	$0x0, 0x1e0(%rsp)
180005c8a:     	movq	$0x0, 0x1e8(%rsp)
180005c96:     	movb	$0x0, 0x1f0(%rsp)
180005c9e:     	movq	%rdx, 0x70(%rsp)
180005ca3:     	movq	%rcx, 0x68(%rsp)
180005ca8:     	movq	0x338(%rsp), %rax
180005cb0:     	movq	%rax, 0x60(%rsp)
180005cb5:     	movq	0x330(%rsp), %rax
180005cbd:     	movq	%rax, 0x58(%rsp)
180005cc2:     	movq	0x78(%rsp), %rax
180005cc7:     	movq	%rax, 0x50(%rsp)
180005ccc:     	movq	%r13, 0x30(%rsp)
180005cd1:     	movq	%r14, 0x28(%rsp)
180005cd6:     	movq	0x310(%rsp), %rax
180005cde:     	movq	%rax, 0x20(%rsp)
180005ce3:     	movq	$-0x1, 0x48(%rsp)
180005cec:     	movq	$-0x1, 0x40(%rsp)
180005cf5:     	movq	$0x1, 0x38(%rsp)
180005cfe:     	leaq	0x198(%rsp), %rcx
180005d06:     	movq	%rsi, %r9
180005d09:     	callq	0x180002f10 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x15a0>
180005d0e:     	cmpb	$0x0, (%r14)
180005d12:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005d18:     	movq	%r14, %r10
180005d1b:     	movsd	0x1c8(%rsp), %xmm0
180005d24:     	movzbl	0x1d0(%rsp), %eax
180005d2c:     	movsd	0x1d8(%rsp), %xmm1
180005d35:     	movzbl	0x1e0(%rsp), %edx
180005d3d:     	movsd	0x1e8(%rsp), %xmm2
180005d46:     	movzbl	0x1f0(%rsp), %ecx
180005d4e:     	movq	0x310(%rsp), %r8
180005d56:     	decq	0x8(%r8)
180005d5a:     	movq	0x330(%rsp), %r8
180005d62:     	movq	0x28(%rsi,%r8,8), %r8
180005d67:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180005d71:     	addq	$0x8, %r9
180005d75:     	cmpq	%r9, %r8
180005d78:     	jne	0x18000600d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x469d>
180005d7e:     	movb	$0x1, (%r10)
180005d82:     	jmp	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005d87:     	movb	$0x1, (%r14)
180005d8b:     	movq	0x310(%rsp), %rax
180005d93:     	movq	$0x6acfce, 0x18(%rax)   # imm = 0x6ACFCE
180005d9b:     	jmp	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005da0:     	movb	$0x1, (%r14)
180005da4:     	movq	0x310(%rsp), %rax
180005dac:     	movq	$0xf4243, 0x18(%rax)    # imm = 0xF4243
180005db4:     	movzbl	(%r14), %r10d
180005db8:     	movq	$-0x1, %rdx
180005dbf:     	testb	%r10b, %r10b
180005dc2:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005dc8:     	movsd	(%r8,%rdx,8), %xmm0
180005dce:     	mulsd	%xmm0, %xmm0
180005dd2:     	movapd	0x35f6(%rip), %xmm1     # 0x1800093d0
180005dda:     	andpd	%xmm0, %xmm1
180005dde:     	ucomisd	0x35fa(%rip), %xmm1     # 0x1800093e0
180005de6:     	jae	0x180005e5e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x44ee>
180005de8:     	movsd	0x10(%r8,%rdx,8), %xmm1
180005def:     	mulsd	%xmm1, %xmm1
180005df3:     	movapd	0x35d5(%rip), %xmm2     # 0x1800093d0
180005dfb:     	andpd	%xmm1, %xmm2
180005dff:     	ucomisd	0x35d9(%rip), %xmm2     # 0x1800093e0
180005e07:     	jae	0x180005e5e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x44ee>
180005e09:     	addsd	%xmm1, %xmm0
180005e0d:     	movapd	0x35bb(%rip), %xmm1     # 0x1800093d0
180005e15:     	andpd	%xmm0, %xmm1
180005e19:     	ucomisd	0x35bf(%rip), %xmm1     # 0x1800093e0
180005e21:     	jae	0x180005e5e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x44ee>
180005e23:     	movsd	0x20(%r8,%rdx,8), %xmm1
180005e2a:     	mulsd	%xmm1, %xmm1
180005e2e:     	movapd	0x359a(%rip), %xmm2     # 0x1800093d0
180005e36:     	andpd	%xmm1, %xmm2
180005e3a:     	ucomisd	0x359e(%rip), %xmm2     # 0x1800093e0
180005e42:     	jae	0x180005e5e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x44ee>
180005e44:     	addsd	%xmm1, %xmm0
180005e48:     	movapd	0x3580(%rip), %xmm1     # 0x1800093d0
180005e50:     	andpd	%xmm0, %xmm1
180005e54:     	ucomisd	0x3584(%rip), %xmm1     # 0x1800093e0
180005e5c:     	jb	0x180005e80 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4510>
180005e5e:     	movb	$0x1, (%r14)
180005e62:     	movq	0x310(%rsp), %rax
180005e6a:     	movq	$0x14fb183, 0x18(%rax)  # imm = 0x14FB183
180005e72:     	cmpb	$0x0, (%r14)
180005e76:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005e7c:     	xorpd	%xmm0, %xmm0
180005e80:     	sqrtsd	%xmm0, %xmm0
180005e84:     	xorpd	%xmm1, %xmm1
180005e88:     	ucomisd	%xmm1, %xmm0
180005e8c:     	jne	0x180006085 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4715>
180005e92:     	jp	0x180006085 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4715>
180005e98:     	movb	$0x1, (%r14)
180005e9c:     	movq	0x310(%rsp), %rax
180005ea4:     	movq	$0x3d0902, 0x18(%rax)   # imm = 0x3D0902
180005eac:     	movzbl	(%r14), %r10d
180005eb0:     	movq	$-0x1, %rdx
180005eb7:     	testb	%r10b, %r10b
180005eba:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180005ec0:     	jmp	0x180005c44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x42d4>
180005ec5:     	movq	0x88(%rsp), %r9
180005ecd:     	movsd	(%r9,%rdx,8), %xmm1
180005ed3:     	movsd	0x10(%r9,%rdx,8), %xmm2
180005eda:     	movsd	0x20(%r9,%rdx,8), %xmm3
180005ee1:     	movq	%rcx, (%r14)
180005ee4:     	movq	0x318(%rsp), %rcx
180005eec:     	cmpb	$0x0, (%rcx)
180005eef:     	movq	0x98(%rsp), %rcx
180005ef7:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005efd:     	movsd	0x34e3(%rip), %xmm4     # 0x1800093e8
180005f05:     	divsd	%xmm0, %xmm4
180005f09:     	mulsd	%xmm4, %xmm1
180005f0d:     	mulsd	%xmm4, %xmm2
180005f11:     	mulsd	%xmm3, %xmm4
180005f15:     	movq	0x88(%rsp), %rcx
180005f1d:     	movsd	%xmm1, (%rcx,%r8,8)
180005f23:     	movsd	%xmm2, 0x10(%rcx,%r8,8)
180005f2a:     	movsd	%xmm4, 0x20(%rcx,%r8,8)
180005f31:     	movq	0x318(%rsp), %rcx
180005f39:     	movzbl	(%rcx), %ecx
180005f3c:     	xorl	%edx, %edx
180005f3e:     	movl	%ecx, %r9d
180005f41:     	negb	%r9b
180005f44:     	sbbq	%rdx, %rdx
180005f47:     	orq	%r8, %rdx
180005f4a:     	testb	%cl, %cl
180005f4c:     	movq	0x98(%rsp), %rcx
180005f54:     	jne	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005f5a:     	jmp	0x180005080 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3710>
180005f5f:     	cvtsi2sd	%rax, %xmm8
180005f64:     	cvtsi2sd	%rdi, %xmm7
180005f69:     	cvtsi2sd	%r11, %xmm6
180005f6e:     	movq	0x310(%rsp), %r14
180005f76:     	movq	%rbp, %r15
180005f79:     	jmp	0x180003c6b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x22fb>
180005f7e:     	movb	$0x1, (%rbx)
180005f81:     	movq	$0x1406f4f, 0x18(%rdi)  # imm = 0x1406F4F
180005f89:     	jmp	0x180005778 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e08>
180005f8e:     	movq	0x318(%rsp), %rax
180005f96:     	movb	$0x1, (%rax)
180005f99:     	movq	$0x1406f47, 0x18(%r14)  # imm = 0x1406F47
180005fa1:     	movq	0x98(%rsp), %rax
180005fa9:     	movq	$0x0, 0x58(%rax)
180005fb1:     	movq	$0x0, 0x50(%rax)
180005fb9:     	movq	$0x0, 0x48(%rax)
180005fc1:     	movq	$0x0, 0x40(%rax)
180005fc9:     	movq	$0x0, 0x38(%rax)
180005fd1:     	movq	$0x0, 0x30(%rax)
180005fd9:     	movq	$0x0, 0x28(%rax)
180005fe1:     	movq	$0x0, 0x20(%rax)
180005fe9:     	movq	$0x0, 0x18(%rax)
180005ff1:     	movq	$0x0, 0x10(%rax)
180005ff9:     	movq	$0x0, 0x8(%rax)
180006001:     	movq	$0x0, (%rax)
180006008:     	jmp	0x1800057d7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e67>
18000600d:     	cmpb	$0x0, (%r10)
180006011:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
180006017:     	decq	%r8
18000601a:     	testb	%dl, %dl
18000601c:     	movq	0x330(%rsp), %rdx
180006024:     	movq	%r8, 0x28(%rsi,%rdx,8)
180006029:     	setne	0x18(%r12)
18000602f:     	testb	%cl, %cl
180006031:     	setne	0x28(%r12)
180006037:     	testb	%al, %al
180006039:     	movsd	%xmm2, 0x20(%r12)
180006040:     	movsd	%xmm1, 0x10(%r12)
180006047:     	setne	0x8(%r12)
18000604d:     	movsd	%xmm0, (%r12)
180006053:     	movb	$0x0, 0x58(%r12)
180006059:     	movq	$0x0, 0x50(%r12)
180006062:     	movb	$0x0, 0x48(%r12)
180006068:     	movq	$0x0, 0x40(%r12)
180006071:     	movb	$0x0, 0x38(%r12)
180006077:     	movq	$0x0, 0x30(%r12)
180006080:     	jmp	0x1800057d7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e67>
180006085:     	movq	0x310(%rsp), %rax
18000608d:     	movq	(%rax), %r9
180006090:     	leaq	0x6(%r9), %rax
180006094:     	cmpq	%r13, %rax
180006097:     	jg	0x18000536f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x39ff>
18000609d:     	movsd	(%r8,%rdx,8), %xmm1
1800060a3:     	movsd	0x10(%r8,%rdx,8), %xmm2
1800060aa:     	movsd	0x20(%r8,%rdx,8), %xmm3
1800060b1:     	movq	0x310(%rsp), %rdx
1800060b9:     	movq	%rax, (%rdx)
1800060bc:     	cmpb	$0x0, (%r14)
1800060c0:     	jne	0x180006108 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4798>
1800060c2:     	movsd	0x331e(%rip), %xmm4     # 0x1800093e8
1800060ca:     	divsd	%xmm0, %xmm4
1800060ce:     	mulsd	%xmm4, %xmm1
1800060d2:     	mulsd	%xmm4, %xmm2
1800060d6:     	mulsd	%xmm3, %xmm4
1800060da:     	movsd	%xmm1, (%r8,%r9,8)
1800060e0:     	movsd	%xmm2, 0x10(%r8,%r9,8)
1800060e7:     	movsd	%xmm4, 0x20(%r8,%r9,8)
1800060ee:     	movzbl	(%r14), %r10d
1800060f2:     	xorl	%edx, %edx
1800060f4:     	movl	%r10d, %eax
1800060f7:     	negb	%al
1800060f9:     	sbbq	%rdx, %rdx
1800060fc:     	orq	%r9, %rdx
1800060ff:     	testb	%r10b, %r10b
180006102:     	je	0x180005c44 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x42d4>
180006108:     	movq	$0x0, 0x58(%r12)
180006111:     	movq	$0x0, 0x50(%r12)
18000611a:     	movq	$0x0, 0x48(%r12)
180006123:     	movq	$0x0, 0x40(%r12)
18000612c:     	movq	$0x0, 0x38(%r12)
180006135:     	movq	$0x0, 0x30(%r12)
18000613e:     	movq	$0x0, 0x28(%r12)
180006147:     	movq	$0x0, 0x20(%r12)
180006150:     	movq	$0x0, 0x18(%r12)
180006159:     	movq	$0x0, 0x10(%r12)
180006162:     	movq	$0x0, 0x8(%r12)
18000616b:     	movq	$0x0, (%r12)
180006173:     	jmp	0x1800057d7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x3e67>
180006178:     	int3
180006179:     	int3
18000617a:     	int3
18000617b:     	int3
18000617c:     	int3
18000617d:     	int3
18000617e:     	int3
18000617f:     	int3
180006180:     	pushq	%rbx
180006182:     	subq	$0x20, %rsp
180006186:     	movq	%rcx, %rbx
180006189:     	callq	*0x2f61(%rip)           # 0x1800090f0
18000618f:     	movl	%eax, (%rbx)
180006191:     	addq	$0x20, %rsp
180006195:     	popq	%rbx
180006196:     	retq
180006197:     	int3
180006198:     	int3
180006199:     	int3
18000619a:     	int3
18000619b:     	int3
18000619c:     	int3
18000619d:     	int3
18000619e:     	int3
18000619f:     	int3
1800061a0:     	movl	(%rcx), %ecx
1800061a2:     	jmpq	*0x3077(%rip)           # 0x180009220
1800061a9:     	int3
1800061aa:     	int3
1800061ab:     	int3
1800061ac:     	int3
1800061ad:     	int3
1800061ae:     	int3
1800061af:     	int3
1800061b0:     	pushq	%rbp
1800061b2:     	pushq	%rbx
1800061b3:     	pushq	%rsi
1800061b4:     	pushq	%rdi
1800061b5:     	pushq	%r14
1800061b7:     	pushq	%r15
1800061b9:     	movq	%rsp, %rbp
1800061bc:     	subq	$0x48, %rsp
1800061c0:     	movq	0x3029(%rip), %rax      # 0x1800091f0
1800061c7:     	xorl	%r15d, %r15d
1800061ca:     	movq	%rcx, %rsi
1800061cd:     	movq	%r15, 0x38(%rbp)
1800061d1:     	movl	%r15d, %r14d
1800061d4:     	movq	%r15, 0x50(%rbp)
1800061d8:     	movq	%r15, 0x48(%rbp)
1800061dc:     	cmpq	%rax, 0x8(%rcx)
1800061e0:     	jne	0x18000634e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49de>
1800061e6:     	leaq	0x48(%rbp), %rax
1800061ea:     	leaq	0x50(%rbp), %r9
1800061ee:     	movq	%rax, 0x20(%rsp)
1800061f3:     	leaq	0x38(%rbp), %r8
1800061f7:     	leaq	0x3ae6(%rip), %rdx      # 0x180009ce4
1800061fe:     	callq	*0x2f2c(%rip)           # 0x180009130
180006204:     	testl	%eax, %eax
180006206:     	jne	0x180006344 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49d4>
18000620c:     	movq	0x48(%rbp), %rbx
180006210:     	testq	%rbx, %rbx
180006213:     	je	0x180006335 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49c5>
180006219:     	cmpq	0x30c0(%rip), %rbx      # 0x1800092e0
180006220:     	je	0x180006335 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49c5>
180006226:     	movq	0x8(%rbx), %rax
18000622a:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180006234:     	je	0x180006335 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49c5>
18000623a:     	movq	0x20(%rbx), %rcx
18000623e:     	callq	*0x2f4c(%rip)           # 0x180009190
180006244:     	movq	0x28(%rbx), %rcx
180006248:     	movq	%rax, %rdi
18000624b:     	callq	*0x2f3f(%rip)           # 0x180009190
180006251:     	movq	0x30(%rbx), %rcx
180006255:     	movq	%rax, %r14
180006258:     	callq	*0x2f42(%rip)           # 0x1800091a0
18000625e:     	leaq	-0x10(%rbp), %r8
180006262:     	movl	%eax, %ebx
180006264:     	leaq	-0x18(%rbp), %rdx
180006268:     	leaq	0x40(%rbp), %rcx
18000626c:     	callq	*0x2f3e(%rip)           # 0x1800091b0
180006272:     	callq	*0x2ef8(%rip)           # 0x180009170
180006278:     	movq	%rax, %rsi
18000627b:     	testq	%rax, %rax
18000627e:     	je	0x18000632b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49bb>
180006284:     	movl	%ebx, %r8d
180006287:     	movq	%rdi, %rdx
18000628a:     	movq	%r14, %rcx
18000628d:     	callq	*0x2fd5(%rip)           # 0x180009268
180006293:     	movq	%rax, %rdi
180006296:     	testq	%rax, %rax
180006299:     	je	0x18000632b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49bb>
18000629f:     	callq	*0x2fd3(%rip)           # 0x180009278
1800062a5:     	xorl	%r9d, %r9d
1800062a8:     	movq	%rsi, %r8
1800062ab:     	movq	%rax, %rcx
1800062ae:     	movq	%rdi, %rdx
1800062b1:     	callq	*0x2f99(%rip)           # 0x180009250
1800062b7:     	movl	(%rsi), %ecx
1800062b9:     	movq	%rax, %rbx
1800062bc:     	testl	%ecx, %ecx
1800062be:     	js	0x1800062d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4960>
1800062c0:     	subl	$0x1, %ecx
1800062c3:     	movl	%ecx, (%rsi)
1800062c5:     	jne	0x1800062d0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4960>
1800062c7:     	movq	%rsi, %rcx
1800062ca:     	callq	*0x2f08(%rip)           # 0x1800091d8
1800062d0:     	movl	(%rdi), %eax
1800062d2:     	testl	%eax, %eax
1800062d4:     	js	0x1800062e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4976>
1800062d6:     	subl	$0x1, %eax
1800062d9:     	movl	%eax, (%rdi)
1800062db:     	jne	0x1800062e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4976>
1800062dd:     	movq	%rdi, %rcx
1800062e0:     	callq	*0x2ef2(%rip)           # 0x1800091d8
1800062e6:     	testq	%rbx, %rbx
1800062e9:     	je	0x18000632b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49bb>
1800062eb:     	movq	-0x10(%rbp), %r8
1800062ef:     	movq	-0x18(%rbp), %rdx
1800062f3:     	movq	0x40(%rbp), %rcx
1800062f7:     	callq	*0x2ee3(%rip)           # 0x1800091e0
1800062fd:     	movq	%rbx, %rcx
180006300:     	callq	*0x2f32(%rip)           # 0x180009238
180006306:     	movl	(%rbx), %eax
180006308:     	testl	%eax, %eax
18000630a:     	js	0x180006335 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49c5>
18000630c:     	subl	$0x1, %eax
18000630f:     	movl	%eax, (%rbx)
180006311:     	jne	0x180006335 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49c5>
180006313:     	movq	%rbx, %rcx
180006316:     	callq	*0x2ebc(%rip)           # 0x1800091d8
18000631c:     	xorl	%eax, %eax
18000631e:     	addq	$0x48, %rsp
180006322:     	popq	%r15
180006324:     	popq	%r14
180006326:     	popq	%rdi
180006327:     	popq	%rsi
180006328:     	popq	%rbx
180006329:     	popq	%rbp
18000632a:     	retq
18000632b:     	movq	0x40(%rbp), %rcx
18000632f:     	callq	*0x2edb(%rip)           # 0x180009210
180006335:     	xorl	%eax, %eax
180006337:     	addq	$0x48, %rsp
18000633b:     	popq	%r15
18000633d:     	popq	%r14
18000633f:     	popq	%rdi
180006340:     	popq	%rsi
180006341:     	popq	%rbx
180006342:     	popq	%rbp
180006343:     	retq
180006344:     	movq	0x38(%rbp), %rbx
180006348:     	movq	0x50(%rbp), %r14
18000634c:     	jmp	0x180006355 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x49e5>
18000634e:     	movq	%rsi, %rbx
180006351:     	movq	%rbx, 0x38(%rbp)
180006355:     	cmpq	0x2f84(%rip), %rbx      # 0x1800092e0
18000635c:     	jne	0x1800063f4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a84>
180006362:     	leaq	-0x18(%rbp), %r8
180006366:     	leaq	-0x10(%rbp), %rdx
18000636a:     	leaq	0x40(%rbp), %rcx
18000636e:     	callq	*0x2dac(%rip)           # 0x180009120
180006374:     	movq	0x2f65(%rip), %rax      # 0x1800092e0
18000637b:     	cmpq	%rax, 0x40(%rbp)
18000637f:     	jne	0x180006394 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a24>
180006381:     	movq	0x2f38(%rip), %rcx      # 0x1800092c0
180006388:     	leaq	0x3909(%rip), %rdx      # 0x180009c98
18000638f:     	jmp	0x1800064b5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b45>
180006394:     	movq	0x40(%rbp), %rcx
180006398:     	testq	%rcx, %rcx
18000639b:     	je	0x1800063aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a3a>
18000639d:     	movl	(%rcx), %eax
18000639f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800063a4:     	jae	0x1800063aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a3a>
1800063a6:     	incl	%eax
1800063a8:     	movl	%eax, (%rcx)
1800063aa:     	movq	-0x10(%rbp), %rcx
1800063ae:     	testq	%rcx, %rcx
1800063b1:     	je	0x1800063c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a50>
1800063b3:     	movl	(%rcx), %eax
1800063b5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800063ba:     	jae	0x1800063c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a50>
1800063bc:     	incl	%eax
1800063be:     	movl	%eax, (%rcx)
1800063c0:     	movq	-0x18(%rbp), %r8
1800063c4:     	testq	%r8, %r8
1800063c7:     	je	0x1800063dc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a6c>
1800063c9:     	movl	(%r8), %eax
1800063cc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800063d1:     	jae	0x1800063dc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4a6c>
1800063d3:     	incl	%eax
1800063d5:     	movl	%eax, (%r8)
1800063d8:     	movq	-0x18(%rbp), %r8
1800063dc:     	movq	-0x10(%rbp), %rdx
1800063e0:     	movq	0x40(%rbp), %rcx
1800063e4:     	callq	*0x2df6(%rip)           # 0x1800091e0
1800063ea:     	movl	$0x1, %ebx
1800063ef:     	jmp	0x1800064c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b51>
1800063f4:     	movq	0x8(%rbx), %rcx
1800063f8:     	movl	0xa8(%rcx), %eax
1800063fe:     	testl	%eax, %eax
180006400:     	jns	0x180006496 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b26>
180006406:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180006410:     	je	0x180006496 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b26>
180006416:     	movq	%r14, %rdx
180006419:     	movq	%rbx, %rcx
18000641c:     	callq	*0x2cee(%rip)           # 0x180009110
180006422:     	movq	%rax, %rdi
180006425:     	testq	%rax, %rax
180006428:     	je	0x1800064be <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b4e>
18000642e:     	movq	0x8(%rax), %rax
180006432:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
18000643c:     	jne	0x18000646d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4afd>
18000643e:     	movq	0x2e6b(%rip), %rcx      # 0x1800092b0
180006445:     	leaq	0x386c(%rip), %rdx      # 0x180009cb8
18000644c:     	movq	(%rcx), %rcx
18000644f:     	callq	*0x2e63(%rip)           # 0x1800092b8
180006455:     	movl	(%rdi), %eax
180006457:     	testl	%eax, %eax
180006459:     	js	0x1800064be <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b4e>
18000645b:     	subl	$0x1, %eax
18000645e:     	movl	%eax, (%rdi)
180006460:     	jne	0x1800064be <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b4e>
180006462:     	movq	%rdi, %rcx
180006465:     	callq	*0x2d6d(%rip)           # 0x1800091d8
18000646b:     	jmp	0x1800064be <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b4e>
18000646d:     	movl	(%rdi), %eax
18000646f:     	testl	%eax, %eax
180006471:     	js	0x180006483 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b13>
180006473:     	subl	$0x1, %eax
180006476:     	movl	%eax, (%rdi)
180006478:     	jne	0x180006483 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b13>
18000647a:     	movq	%rdi, %rcx
18000647d:     	callq	*0x2d55(%rip)           # 0x1800091d8
180006483:     	movq	%r14, %rdx
180006486:     	movq	%rbx, %rcx
180006489:     	callq	*0x2de1(%rip)           # 0x180009270
18000648f:     	movl	$0x1, %ebx
180006494:     	jmp	0x1800064c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b51>
180006496:     	btl	$0x1e, %eax
18000649a:     	jae	0x1800064a7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b37>
18000649c:     	movq	%rbx, %rdx
18000649f:     	callq	*0x2dcb(%rip)           # 0x180009270
1800064a5:     	jmp	0x1800064be <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4b4e>
1800064a7:     	movq	0x2e02(%rip), %rcx      # 0x1800092b0
1800064ae:     	leaq	0x3803(%rip), %rdx      # 0x180009cb8
1800064b5:     	movq	(%rcx), %rcx
1800064b8:     	callq	*0x2dfa(%rip)           # 0x1800092b8
1800064be:     	movl	%r15d, %ebx
1800064c1:     	movq	0x48(%rbp), %rdi
1800064c5:     	testq	%rdi, %rdi
1800064c8:     	je	0x1800065eb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c7b>
1800064ce:     	cmpq	0x2e0b(%rip), %rdi      # 0x1800092e0
1800064d5:     	je	0x1800065eb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c7b>
1800064db:     	movq	0x8(%rdi), %rax
1800064df:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
1800064e9:     	je	0x1800065eb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c7b>
1800064ef:     	movq	0x20(%rdi), %rcx
1800064f3:     	movq	%r12, 0x40(%rsp)
1800064f8:     	callq	*0x2c92(%rip)           # 0x180009190
1800064fe:     	movq	0x28(%rdi), %rcx
180006502:     	movq	%rax, %r14
180006505:     	callq	*0x2c85(%rip)           # 0x180009190
18000650b:     	movq	0x30(%rdi), %rcx
18000650f:     	movq	%rax, %r12
180006512:     	callq	*0x2c88(%rip)           # 0x1800091a0
180006518:     	leaq	-0x10(%rbp), %r8
18000651c:     	movl	%eax, %edi
18000651e:     	leaq	-0x18(%rbp), %rdx
180006522:     	leaq	0x40(%rbp), %rcx
180006526:     	callq	*0x2c84(%rip)           # 0x1800091b0
18000652c:     	callq	*0x2c3e(%rip)           # 0x180009170
180006532:     	movq	%rax, %r15
180006535:     	testq	%rax, %rax
180006538:     	je	0x1800065dc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c6c>
18000653e:     	movl	%edi, %r8d
180006541:     	movq	%r14, %rdx
180006544:     	movq	%r12, %rcx
180006547:     	callq	*0x2d1b(%rip)           # 0x180009268
18000654d:     	movq	%rax, %r14
180006550:     	testq	%rax, %rax
180006553:     	je	0x1800065dc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c6c>
180006559:     	callq	*0x2d19(%rip)           # 0x180009278
18000655f:     	xorl	%r9d, %r9d
180006562:     	movq	%r15, %r8
180006565:     	movq	%rax, %rcx
180006568:     	movq	%r14, %rdx
18000656b:     	callq	*0x2cdf(%rip)           # 0x180009250
180006571:     	movl	(%r15), %ecx
180006574:     	movq	%rax, %rdi
180006577:     	testl	%ecx, %ecx
180006579:     	js	0x18000658c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c1c>
18000657b:     	subl	$0x1, %ecx
18000657e:     	movl	%ecx, (%r15)
180006581:     	jne	0x18000658c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c1c>
180006583:     	movq	%r15, %rcx
180006586:     	callq	*0x2c4c(%rip)           # 0x1800091d8
18000658c:     	movl	(%r14), %eax
18000658f:     	testl	%eax, %eax
180006591:     	js	0x1800065a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c34>
180006593:     	subl	$0x1, %eax
180006596:     	movl	%eax, (%r14)
180006599:     	jne	0x1800065a4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c34>
18000659b:     	movq	%r14, %rcx
18000659e:     	callq	*0x2c34(%rip)           # 0x1800091d8
1800065a4:     	testq	%rdi, %rdi
1800065a7:     	je	0x1800065dc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c6c>
1800065a9:     	movq	-0x10(%rbp), %r8
1800065ad:     	movq	-0x18(%rbp), %rdx
1800065b1:     	movq	0x40(%rbp), %rcx
1800065b5:     	callq	*0x2c25(%rip)           # 0x1800091e0
1800065bb:     	movq	%rdi, %rcx
1800065be:     	callq	*0x2c74(%rip)           # 0x180009238
1800065c4:     	movl	(%rdi), %eax
1800065c6:     	testl	%eax, %eax
1800065c8:     	js	0x1800065e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c76>
1800065ca:     	subl	$0x1, %eax
1800065cd:     	movl	%eax, (%rdi)
1800065cf:     	jne	0x1800065e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c76>
1800065d1:     	movq	%rdi, %rcx
1800065d4:     	callq	*0x2bfe(%rip)           # 0x1800091d8
1800065da:     	jmp	0x1800065e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c76>
1800065dc:     	movq	0x40(%rbp), %rcx
1800065e0:     	callq	*0x2c2a(%rip)           # 0x180009210
1800065e6:     	movq	0x40(%rsp), %r12
1800065eb:     	movl	(%rsi), %ecx
1800065ed:     	testl	%ecx, %ecx
1800065ef:     	js	0x180006601 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c91>
1800065f1:     	subl	$0x1, %ecx
1800065f4:     	movl	%ecx, (%rsi)
1800065f6:     	jne	0x180006601 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4c91>
1800065f8:     	movq	%rsi, %rcx
1800065fb:     	callq	*0x2bd7(%rip)           # 0x1800091d8
180006601:     	movl	%ebx, %eax
180006603:     	addq	$0x48, %rsp
180006607:     	popq	%r15
180006609:     	popq	%r14
18000660b:     	popq	%rdi
18000660c:     	popq	%rsi
18000660d:     	popq	%rbx
18000660e:     	popq	%rbp
18000660f:     	retq
180006610:     	movq	%rbx, 0x8(%rsp)
180006615:     	movq	%rsi, 0x10(%rsp)
18000661a:     	pushq	%rdi
18000661b:     	subq	$0x20, %rsp
18000661f:     	cmpq	$0x0, 0xa631(%rip)      # 0x180010c58
180006627:     	movq	%rcx, %rsi
18000662a:     	movslq	%edx, %rdi
18000662d:     	jne	0x18000667d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d0d>
18000662f:     	leaq	0x36b2(%rip), %rcx      # 0x180009ce8
180006636:     	callq	*0x2c0c(%rip)           # 0x180009248
18000663c:     	movq	%rax, %rbx
18000663f:     	testq	%rax, %rax
180006642:     	je	0x180006691 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d21>
180006644:     	leaq	0x36a5(%rip), %rdx      # 0x180009cf0
18000664b:     	movq	%rax, %rcx
18000664e:     	callq	*0x2b24(%rip)           # 0x180009178
180006654:     	movl	(%rbx), %ecx
180006656:     	movq	%rax, 0xa5fb(%rip)      # 0x180010c58
18000665d:     	testl	%ecx, %ecx
18000665f:     	js	0x180006678 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d08>
180006661:     	subl	$0x1, %ecx
180006664:     	movl	%ecx, (%rbx)
180006666:     	jne	0x180006678 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d08>
180006668:     	movq	%rbx, %rcx
18000666b:     	callq	*0x2b67(%rip)           # 0x1800091d8
180006671:     	movq	0xa5e0(%rip), %rax      # 0x180010c58
180006678:     	testq	%rax, %rax
18000667b:     	je	0x180006691 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d21>
18000667d:     	movq	%rdi, %rdx
180006680:     	movq	%rsi, %rcx
180006683:     	callq	*0x2c3f(%rip)           # 0x1800092c8
180006689:     	movq	%rax, %rbx
18000668c:     	testq	%rax, %rax
18000668f:     	jne	0x1800066a3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d33>
180006691:     	xorl	%eax, %eax
180006693:     	movq	0x30(%rsp), %rbx
180006698:     	movq	0x38(%rsp), %rsi
18000669d:     	addq	$0x20, %rsp
1800066a1:     	popq	%rdi
1800066a2:     	retq
1800066a3:     	movq	0xa5ae(%rip), %rcx      # 0x180010c58
1800066aa:     	xorl	%r8d, %r8d
1800066ad:     	movq	%rbx, %rdx
1800066b0:     	callq	*0x2af2(%rip)           # 0x1800091a8
1800066b6:     	movl	(%rbx), %ecx
1800066b8:     	movq	%rax, %rdi
1800066bb:     	testl	%ecx, %ecx
1800066bd:     	js	0x1800066cf <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d5f>
1800066bf:     	subl	$0x1, %ecx
1800066c2:     	movl	%ecx, (%rbx)
1800066c4:     	jne	0x1800066cf <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4d5f>
1800066c6:     	movq	%rbx, %rcx
1800066c9:     	callq	*0x2b09(%rip)           # 0x1800091d8
1800066cf:     	movq	0x30(%rsp), %rbx
1800066d4:     	movq	%rdi, %rax
1800066d7:     	movq	0x38(%rsp), %rsi
1800066dc:     	addq	$0x20, %rsp
1800066e0:     	popq	%rdi
1800066e1:     	retq
1800066e2:     	int3
1800066e3:     	int3
1800066e4:     	int3
1800066e5:     	int3
1800066e6:     	int3
1800066e7:     	int3
1800066e8:     	int3
1800066e9:     	int3
1800066ea:     	int3
1800066eb:     	int3
1800066ec:     	int3
1800066ed:     	int3
1800066ee:     	int3
1800066ef:     	int3
1800066f0:     	movq	%rbx, 0x8(%rsp)
1800066f5:     	movq	%rsi, 0x10(%rsp)
1800066fa:     	pushq	%rdi
1800066fb:     	subq	$0x20, %rsp
1800066ff:     	movq	0xa54a(%rip), %rax      # 0x180010c50
180006706:     	movq	%rdx, %rdi
180006709:     	movq	%rcx, %rsi
18000670c:     	testq	%rax, %rax
18000670f:     	jne	0x180006771 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e01>
180006711:     	leaq	0x35e0(%rip), %rcx      # 0x180009cf8
180006718:     	callq	*0x2b2a(%rip)           # 0x180009248
18000671e:     	movq	%rax, %rbx
180006721:     	testq	%rax, %rax
180006724:     	je	0x18000675f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4def>
180006726:     	leaq	0x35e3(%rip), %rdx      # 0x180009d10
18000672d:     	movq	%rax, %rcx
180006730:     	callq	*0x2a42(%rip)           # 0x180009178
180006736:     	movl	(%rbx), %ecx
180006738:     	movq	%rax, 0xa511(%rip)      # 0x180010c50
18000673f:     	testl	%ecx, %ecx
180006741:     	js	0x18000675a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4dea>
180006743:     	subl	$0x1, %ecx
180006746:     	movl	%ecx, (%rbx)
180006748:     	jne	0x18000675a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4dea>
18000674a:     	movq	%rbx, %rcx
18000674d:     	callq	*0x2a85(%rip)           # 0x1800091d8
180006753:     	movq	0xa4f6(%rip), %rax      # 0x180010c50
18000675a:     	testq	%rax, %rax
18000675d:     	jne	0x180006771 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e01>
18000675f:     	xorl	%eax, %eax
180006761:     	movq	0x30(%rsp), %rbx
180006766:     	movq	0x38(%rsp), %rsi
18000676b:     	addq	$0x20, %rsp
18000676f:     	popq	%rdi
180006770:     	retq
180006771:     	xorl	%r9d, %r9d
180006774:     	movq	%rdi, %r8
180006777:     	movq	%rsi, %rdx
18000677a:     	movq	%rax, %rcx
18000677d:     	movq	0x30(%rsp), %rbx
180006782:     	movq	0x38(%rsp), %rsi
180006787:     	addq	$0x20, %rsp
18000678b:     	popq	%rdi
18000678c:     	jmpq	*0x2a15(%rip)           # 0x1800091a8
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
1800067af:     	movq	%rcx, %rbx
1800067b2:     	movq	%r8, %rdi
1800067b5:     	movq	0x10(%rcx), %rcx
1800067b9:     	movq	%rdx, %rsi
1800067bc:     	testq	%rcx, %rcx
1800067bf:     	je	0x1800067ca <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e5a>
1800067c1:     	movq	%r8, %rdx
1800067c4:     	callq	*%rsi
1800067c6:     	testl	%eax, %eax
1800067c8:     	jne	0x1800067ed <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e7d>
1800067ca:     	movq	0x18(%rbx), %rcx
1800067ce:     	testq	%rcx, %rcx
1800067d1:     	je	0x1800067eb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4e7b>
1800067d3:     	movq	%rdi, %rdx
1800067d6:     	movq	%rsi, %rax
1800067d9:     	movq	0x30(%rsp), %rbx
1800067de:     	movq	0x38(%rsp), %rsi
1800067e3:     	addq	$0x20, %rsp
1800067e7:     	popq	%rdi
1800067e8:     	jmpq	*%rax
1800067eb:     	xorl	%eax, %eax
1800067ed:     	movq	0x30(%rsp), %rbx
1800067f2:     	movq	0x38(%rsp), %rsi
1800067f7:     	addq	$0x20, %rsp
1800067fb:     	popq	%rdi
1800067fc:     	retq
1800067fd:     	int3
1800067fe:     	int3
1800067ff:     	int3
180006800:     	pushq	%rbx
180006802:     	subq	$0x20, %rsp
180006806:     	movq	%rcx, %rbx
180006809:     	movq	0x10(%rcx), %rcx
18000680d:     	testq	%rcx, %rcx
180006810:     	je	0x18000682d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ebd>
180006812:     	movq	$0x0, 0x10(%rbx)
18000681a:     	movl	(%rcx), %eax
18000681c:     	testl	%eax, %eax
18000681e:     	js	0x18000682d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ebd>
180006820:     	subl	$0x1, %eax
180006823:     	movl	%eax, (%rcx)
180006825:     	jne	0x18000682d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ebd>
180006827:     	callq	*0x29ab(%rip)           # 0x1800091d8
18000682d:     	movq	0x18(%rbx), %rcx
180006831:     	testq	%rcx, %rcx
180006834:     	je	0x180006851 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ee1>
180006836:     	movq	$0x0, 0x18(%rbx)
18000683e:     	movl	(%rcx), %eax
180006840:     	testl	%eax, %eax
180006842:     	js	0x180006851 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ee1>
180006844:     	subl	$0x1, %eax
180006847:     	movl	%eax, (%rcx)
180006849:     	jne	0x180006851 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ee1>
18000684b:     	callq	*0x2987(%rip)           # 0x1800091d8
180006851:     	xorl	%eax, %eax
180006853:     	addq	$0x20, %rsp
180006857:     	popq	%rbx
180006858:     	retq
180006859:     	int3
18000685a:     	int3
18000685b:     	int3
18000685c:     	int3
18000685d:     	int3
18000685e:     	int3
18000685f:     	int3
180006860:     	pushq	%rbx
180006862:     	subq	$0x20, %rsp
180006866:     	movq	%rcx, %rbx
180006869:     	callq	*0x29b9(%rip)           # 0x180009228
18000686f:     	movq	0x10(%rbx), %rcx
180006873:     	testq	%rcx, %rcx
180006876:     	je	0x180006893 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f23>
180006878:     	movq	$0x0, 0x10(%rbx)
180006880:     	movl	(%rcx), %eax
180006882:     	testl	%eax, %eax
180006884:     	js	0x180006893 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f23>
180006886:     	subl	$0x1, %eax
180006889:     	movl	%eax, (%rcx)
18000688b:     	jne	0x180006893 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f23>
18000688d:     	callq	*0x2945(%rip)           # 0x1800091d8
180006893:     	movq	0x18(%rbx), %rcx
180006897:     	testq	%rcx, %rcx
18000689a:     	je	0x1800068b7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f47>
18000689c:     	movq	$0x0, 0x18(%rbx)
1800068a4:     	movl	(%rcx), %eax
1800068a6:     	testl	%eax, %eax
1800068a8:     	js	0x1800068b7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f47>
1800068aa:     	subl	$0x1, %eax
1800068ad:     	movl	%eax, (%rcx)
1800068af:     	jne	0x1800068b7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4f47>
1800068b1:     	callq	*0x2921(%rip)           # 0x1800091d8
1800068b7:     	movq	0x8(%rbx), %rax
1800068bb:     	movq	%rbx, %rcx
1800068be:     	addq	$0x20, %rsp
1800068c2:     	popq	%rbx
1800068c3:     	jmpq	*0x140(%rax)
1800068ca:     	int3
1800068cb:     	int3
1800068cc:     	int3
1800068cd:     	int3
1800068ce:     	int3
1800068cf:     	int3
1800068d0:     	pushq	%rbx
1800068d2:     	subq	$0x30, %rsp
1800068d6:     	movq	%r8, %r10
1800068d9:     	leaq	0x58(%rsp), %rax
1800068de:     	movq	%rax, 0x28(%rsp)
1800068e3:     	leaq	0xa0a6(%rip), %r9       # 0x180010990
1800068ea:     	movq	0x2907(%rip), %rax      # 0x1800091f8
1800068f1:     	leaq	0x3448(%rip), %r8       # 0x180009d40
1800068f8:     	movq	%rdx, %r11
1800068fb:     	movq	%rax, 0x20(%rsp)
180006900:     	movq	%rcx, %rbx
180006903:     	movq	%r10, %rdx
180006906:     	movq	%r11, %rcx
180006909:     	callq	*0x27e9(%rip)           # 0x1800090f8
18000690f:     	testl	%eax, %eax
180006911:     	je	0x18000696c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ffc>
180006913:     	xorl	%r8d, %r8d
180006916:     	xorl	%edx, %edx
180006918:     	movq	%rbx, %rcx
18000691b:     	callq	*0x2937(%rip)           # 0x180009258
180006921:     	movq	%rax, %rbx
180006924:     	testq	%rax, %rax
180006927:     	je	0x18000696c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ffc>
180006929:     	movq	0x58(%rsp), %rax
18000692e:     	movl	(%rax), %ecx
180006930:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180006936:     	jae	0x180006941 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4fd1>
180006938:     	incl	%ecx
18000693a:     	movl	%ecx, (%rax)
18000693c:     	movq	0x58(%rsp), %rax
180006941:     	xorl	%ecx, %ecx
180006943:     	movq	%rax, 0x10(%rbx)
180006947:     	callq	*0x283b(%rip)           # 0x180009188
18000694d:     	movq	%rax, 0x18(%rbx)
180006951:     	testq	%rax, %rax
180006954:     	jne	0x180006974 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5004>
180006956:     	movl	(%rbx), %eax
180006958:     	testl	%eax, %eax
18000695a:     	js	0x18000696c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ffc>
18000695c:     	subl	$0x1, %eax
18000695f:     	movl	%eax, (%rbx)
180006961:     	jne	0x18000696c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x4ffc>
180006963:     	movq	%rbx, %rcx
180006966:     	callq	*0x286c(%rip)           # 0x1800091d8
18000696c:     	xorl	%eax, %eax
18000696e:     	addq	$0x30, %rsp
180006972:     	popq	%rbx
180006973:     	retq
180006974:     	movq	%rbx, %rax
180006977:     	addq	$0x30, %rsp
18000697b:     	popq	%rbx
18000697c:     	retq
18000697d:     	int3
18000697e:     	int3
18000697f:     	int3
180006980:     	movq	%rbx, 0x8(%rsp)
180006985:     	movq	%rsi, 0x10(%rsp)
18000698a:     	pushq	%rdi
18000698b:     	subq	$0x20, %rsp
18000698f:     	movq	%rcx, %rbx
180006992:     	movq	%r8, %rdi
180006995:     	movq	0x18(%rcx), %rcx
180006999:     	movq	%rdx, %rsi
18000699c:     	testq	%rcx, %rcx
18000699f:     	je	0x1800069aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x503a>
1800069a1:     	movq	%r8, %rdx
1800069a4:     	callq	*%rsi
1800069a6:     	testl	%eax, %eax
1800069a8:     	jne	0x1800069cd <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x505d>
1800069aa:     	movq	0x40(%rbx), %rcx
1800069ae:     	testq	%rcx, %rcx
1800069b1:     	je	0x1800069cb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x505b>
1800069b3:     	movq	%rdi, %rdx
1800069b6:     	movq	%rsi, %rax
1800069b9:     	movq	0x30(%rsp), %rbx
1800069be:     	movq	0x38(%rsp), %rsi
1800069c3:     	addq	$0x20, %rsp
1800069c7:     	popq	%rdi
1800069c8:     	jmpq	*%rax
1800069cb:     	xorl	%eax, %eax
1800069cd:     	movq	0x30(%rsp), %rbx
1800069d2:     	movq	0x38(%rsp), %rsi
1800069d7:     	addq	$0x20, %rsp
1800069db:     	popq	%rdi
1800069dc:     	retq
1800069dd:     	int3
1800069de:     	int3
1800069df:     	int3
1800069e0:     	pushq	%rbx
1800069e2:     	subq	$0x20, %rsp
1800069e6:     	movq	%rcx, %rbx
1800069e9:     	callq	*0x2839(%rip)           # 0x180009228
1800069ef:     	cmpq	$0x0, 0x48(%rbx)
1800069f4:     	je	0x1800069ff <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x508f>
1800069f6:     	movq	%rbx, %rcx
1800069f9:     	callq	*0x2799(%rip)           # 0x180009198
1800069ff:     	movq	0x20(%rbx), %rcx
180006a03:     	callq	*0x27bf(%rip)           # 0x1800091c8
180006a09:     	movq	0x38(%rbx), %rcx
180006a0d:     	callq	*0x27b5(%rip)           # 0x1800091c8
180006a13:     	movq	0x18(%rbx), %rcx
180006a17:     	testq	%rcx, %rcx
180006a1a:     	je	0x180006a2f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50bf>
180006a1c:     	movl	(%rcx), %eax
180006a1e:     	testl	%eax, %eax
180006a20:     	js	0x180006a2f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50bf>
180006a22:     	subl	$0x1, %eax
180006a25:     	movl	%eax, (%rcx)
180006a27:     	jne	0x180006a2f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50bf>
180006a29:     	callq	*0x27a9(%rip)           # 0x1800091d8
180006a2f:     	movq	0x40(%rbx), %rcx
180006a33:     	testq	%rcx, %rcx
180006a36:     	je	0x180006a4b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50db>
180006a38:     	movl	(%rcx), %eax
180006a3a:     	testl	%eax, %eax
180006a3c:     	js	0x180006a4b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50db>
180006a3e:     	subl	$0x1, %eax
180006a41:     	movl	%eax, (%rcx)
180006a43:     	jne	0x180006a4b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50db>
180006a45:     	callq	*0x278d(%rip)           # 0x1800091d8
180006a4b:     	movq	0x8(%rbx), %rax
180006a4f:     	movq	%rbx, %rcx
180006a52:     	addq	$0x20, %rsp
180006a56:     	popq	%rbx
180006a57:     	jmpq	*0x140(%rax)
180006a5e:     	int3
180006a5f:     	int3
180006a60:     	pushq	%rbx
180006a62:     	subq	$0x20, %rsp
180006a66:     	callq	*0x2724(%rip)           # 0x180009190
180006a6c:     	movq	%rax, %rbx
180006a6f:     	testq	%rax, %rax
180006a72:     	jne	0x180006a7a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x510a>
180006a74:     	addq	$0x20, %rsp
180006a78:     	popq	%rbx
180006a79:     	retq
180006a7a:     	movq	%rbx, %rcx
180006a7d:     	movq	%rdi, 0x30(%rsp)
180006a82:     	callq	0x180008ddd <numba_list_iter_next+0xecd>
180006a87:     	leaq	0x1(%rax), %rcx
180006a8b:     	callq	*0x27cf(%rip)           # 0x180009260
180006a91:     	movq	%rax, %rdi
180006a94:     	testq	%rax, %rax
180006a97:     	jne	0x180006aac <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x513c>
180006a99:     	callq	*0x26b1(%rip)           # 0x180009150
180006a9f:     	movq	0x30(%rsp), %rdi
180006aa4:     	xorl	%eax, %eax
180006aa6:     	addq	$0x20, %rsp
180006aaa:     	popq	%rbx
180006aab:     	retq
180006aac:     	movq	%rbx, %rdx
180006aaf:     	movq	%rdi, %rcx
180006ab2:     	callq	0x180008dd7 <numba_list_iter_next+0xec7>
180006ab7:     	movq	%rdi, %rax
180006aba:     	movq	0x30(%rsp), %rdi
180006abf:     	addq	$0x20, %rsp
180006ac3:     	popq	%rbx
180006ac4:     	retq
180006ac5:     	int3
180006ac6:     	int3
180006ac7:     	int3
180006ac8:     	int3
180006ac9:     	int3
180006aca:     	int3
180006acb:     	int3
180006acc:     	int3
180006acd:     	int3
180006ace:     	int3
180006acf:     	int3
180006ad0:     	movq	0x18(%rcx), %rcx
180006ad4:     	movq	%rdx, %rax
180006ad7:     	testq	%rcx, %rcx
180006ada:     	je	0x180006ae2 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5172>
180006adc:     	movq	%r8, %rdx
180006adf:     	jmpq	*%rax
180006ae2:     	xorl	%eax, %eax
180006ae4:     	retq
180006ae5:     	int3
180006ae6:     	int3
180006ae7:     	int3
180006ae8:     	int3
180006ae9:     	int3
180006aea:     	int3
180006aeb:     	int3
180006aec:     	int3
180006aed:     	int3
180006aee:     	int3
180006aef:     	int3
180006af0:     	movq	%rbx, 0x8(%rsp)
180006af5:     	pushq	%rdi
180006af6:     	subq	$0x20, %rsp
180006afa:     	movq	0x28(%rcx), %rax
180006afe:     	xorl	%edi, %edi
180006b00:     	movq	%rcx, %rbx
180006b03:     	testq	%rax, %rax
180006b06:     	je	0x180006b12 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x51a2>
180006b08:     	addq	$0x38, %rcx
180006b0c:     	callq	*%rax
180006b0e:     	movq	%rdi, 0x28(%rbx)
180006b12:     	movq	0x18(%rbx), %rcx
180006b16:     	testq	%rcx, %rcx
180006b19:     	je	0x180006b32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x51c2>
180006b1b:     	movq	%rdi, 0x18(%rbx)
180006b1f:     	movl	(%rcx), %eax
180006b21:     	testl	%eax, %eax
180006b23:     	js	0x180006b32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x51c2>
180006b25:     	subl	$0x1, %eax
180006b28:     	movl	%eax, (%rcx)
180006b2a:     	jne	0x180006b32 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x51c2>
180006b2c:     	callq	*0x26a6(%rip)           # 0x1800091d8
180006b32:     	movq	%rdi, 0x20(%rbx)
180006b36:     	xorl	%eax, %eax
180006b38:     	movq	0x30(%rsp), %rbx
180006b3d:     	addq	$0x20, %rsp
180006b41:     	popq	%rdi
180006b42:     	retq
180006b43:     	int3
180006b44:     	int3
180006b45:     	int3
180006b46:     	int3
180006b47:     	int3
180006b48:     	int3
180006b49:     	int3
180006b4a:     	int3
180006b4b:     	int3
180006b4c:     	int3
180006b4d:     	int3
180006b4e:     	int3
180006b4f:     	int3
180006b50:     	pushq	%rbx
180006b52:     	subq	$0x20, %rsp
180006b56:     	movq	%rcx, %rbx
180006b59:     	callq	*0x26c9(%rip)           # 0x180009228
180006b5f:     	cmpq	$0x0, 0x30(%rbx)
180006b64:     	je	0x180006b6f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x51ff>
180006b66:     	movq	%rbx, %rcx
180006b69:     	callq	*0x2629(%rip)           # 0x180009198
180006b6f:     	callq	*0x25d3(%rip)           # 0x180009148
180006b75:     	testl	%eax, %eax
180006b77:     	jne	0x180006b88 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5218>
180006b79:     	movq	0x28(%rbx), %rax
180006b7d:     	testq	%rax, %rax
180006b80:     	je	0x180006b88 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5218>
180006b82:     	leaq	0x38(%rbx), %rcx
180006b86:     	callq	*%rax
180006b88:     	movq	0x18(%rbx), %rcx
180006b8c:     	testq	%rcx, %rcx
180006b8f:     	je	0x180006ba4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5234>
180006b91:     	movl	(%rcx), %eax
180006b93:     	testl	%eax, %eax
180006b95:     	js	0x180006ba4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5234>
180006b97:     	subl	$0x1, %eax
180006b9a:     	movl	%eax, (%rcx)
180006b9c:     	jne	0x180006ba4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5234>
180006b9e:     	callq	*0x2634(%rip)           # 0x1800091d8
180006ba4:     	movq	0x8(%rbx), %rax
180006ba8:     	movq	%rbx, %rcx
180006bab:     	addq	$0x20, %rsp
180006baf:     	popq	%rbx
180006bb0:     	jmpq	*0x140(%rax)
180006bb7:     	int3
180006bb8:     	int3
180006bb9:     	int3
180006bba:     	int3
180006bbb:     	int3
180006bbc:     	int3
180006bbd:     	int3
180006bbe:     	int3
180006bbf:     	int3
180006bc0:     	pushq	%rdi
180006bc2:     	subq	$0x20, %rsp
180006bc6:     	cmpq	$0x0, 0x20(%rcx)
180006bcb:     	movq	%rcx, %rdi
180006bce:     	jne	0x180006bef <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x527f>
180006bd0:     	movq	0x26e9(%rip), %rcx      # 0x1800092c0
180006bd7:     	leaq	0x31b2(%rip), %rdx      # 0x180009d90
180006bde:     	movq	(%rcx), %rcx
180006be1:     	callq	*0x26d1(%rip)           # 0x1800092b8
180006be7:     	xorl	%eax, %eax
180006be9:     	addq	$0x20, %rsp
180006bed:     	popq	%rdi
180006bee:     	retq
180006bef:     	movq	%rdi, %rdx
180006bf2:     	movq	%rbx, 0x30(%rsp)
180006bf7:     	movl	$0x1, %ecx
180006bfc:     	callq	*0x2506(%rip)           # 0x180009108
180006c02:     	movq	%rax, %rbx
180006c05:     	testq	%rax, %rax
180006c08:     	jne	0x180006c15 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52a5>
180006c0a:     	movq	0x30(%rsp), %rbx
180006c0f:     	addq	$0x20, %rsp
180006c13:     	popq	%rdi
180006c14:     	retq
180006c15:     	xorl	%r8d, %r8d
180006c18:     	movq	%rbx, %rdx
180006c1b:     	movq	%rdi, %rcx
180006c1e:     	callq	*0x20(%rdi)
180006c21:     	movl	(%rbx), %ecx
180006c23:     	movq	%rax, %rdi
180006c26:     	testl	%ecx, %ecx
180006c28:     	js	0x180006c3a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52ca>
180006c2a:     	subl	$0x1, %ecx
180006c2d:     	movl	%ecx, (%rbx)
180006c2f:     	jne	0x180006c3a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52ca>
180006c31:     	movq	%rbx, %rcx
180006c34:     	callq	*0x259e(%rip)           # 0x1800091d8
180006c3a:     	movq	0x30(%rsp), %rbx
180006c3f:     	movq	%rdi, %rax
180006c42:     	addq	$0x20, %rsp
180006c46:     	popq	%rdi
180006c47:     	retq
180006c48:     	int3
180006c49:     	int3
180006c4a:     	int3
180006c4b:     	int3
180006c4c:     	int3
180006c4d:     	int3
180006c4e:     	int3
180006c4f:     	int3
180006c50:     	movq	%rbx, 0x8(%rsp)
180006c55:     	pushq	%rdi
180006c56:     	subq	$0x20, %rsp
180006c5a:     	movq	%r8, %rbx
180006c5d:     	callq	*0x248d(%rip)           # 0x1800090f0
180006c63:     	movl	(%rbx), %ecx
180006c65:     	movl	%eax, %edi
180006c67:     	testl	%ecx, %ecx
180006c69:     	js	0x180006c7b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x530b>
180006c6b:     	subl	$0x1, %ecx
180006c6e:     	movl	%ecx, (%rbx)
180006c70:     	jne	0x180006c7b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x530b>
180006c72:     	movq	%rbx, %rcx
180006c75:     	callq	*0x255d(%rip)           # 0x1800091d8
180006c7b:     	movl	%edi, %ecx
180006c7d:     	movq	0x30(%rsp), %rbx
180006c82:     	addq	$0x20, %rsp
180006c86:     	popq	%rdi
180006c87:     	jmpq	*0x2592(%rip)           # 0x180009220
180006c8e:     	int3
180006c8f:     	int3
180006c90:     	movq	%rbx, 0x8(%rsp)
180006c95:     	pushq	%rdi
180006c96:     	subq	$0x20, %rsp
180006c9a:     	movl	(%rdx), %eax
180006c9c:     	movq	%rdx, %rbx
180006c9f:     	movq	%rcx, %rdi
180006ca2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006ca7:     	jae	0x180006cad <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x533d>
180006ca9:     	incl	%eax
180006cab:     	movl	%eax, (%rdx)
180006cad:     	movl	$0x30, %ecx
180006cb2:     	callq	*0x9f70(%rip)           # 0x180010c28
180006cb8:     	cmpb	$0x0, 0x9f41(%rip)      # 0x180010c00
180006cbf:     	je	0x180006cc9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5359>
180006cc1:     	lock
180006cc2:     	incq	0x9f3f(%rip)            # 0x180010c08
180006cc9:     	testq	%rax, %rax
180006ccc:     	je	0x180006d03 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5393>
180006cce:     	movl	$0x1, %ecx
180006cd3:     	leaq	-0x8a(%rip), %rdx       # 0x180006c50 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x52e0>
180006cda:     	xchgq	%rcx, (%rax)
180006cdd:     	xorl	%ecx, %ecx
180006cdf:     	movq	%rdx, 0x8(%rax)
180006ce3:     	movq	%rcx, 0x20(%rax)
180006ce7:     	movq	%rcx, 0x28(%rax)
180006ceb:     	movq	%rbx, 0x10(%rax)
180006cef:     	movq	%rdi, 0x18(%rax)
180006cf3:     	cmpb	%cl, 0x9f07(%rip)       # 0x180010c00
180006cf9:     	je	0x180006d03 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5393>
180006cfb:     	lock
180006cfc:     	incq	0x9f15(%rip)            # 0x180010c18
180006d03:     	movq	0x30(%rsp), %rbx
180006d08:     	addq	$0x20, %rsp
180006d0c:     	popq	%rdi
180006d0d:     	retq
180006d0e:     	int3
180006d0f:     	int3
180006d10:     	movq	%rbx, 0x8(%rsp)
180006d15:     	pushq	%rdi
180006d16:     	subq	$0x30, %rsp
180006d1a:     	movq	%rcx, %rdi
180006d1d:     	leaq	0x9c5c(%rip), %r9       # 0x180010980
180006d24:     	movq	%r8, %rax
180006d27:     	leaq	0x58(%rsp), %rcx
180006d2c:     	movq	%rdx, %r10
180006d2f:     	movq	%rcx, 0x20(%rsp)
180006d34:     	movq	%r10, %rcx
180006d37:     	leaq	0x309a(%rip), %r8       # 0x180009dd8
180006d3e:     	movq	%rax, %rdx
180006d41:     	callq	*0x23b1(%rip)           # 0x1800090f8
180006d47:     	testl	%eax, %eax
180006d49:     	je	0x180006d73 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5403>
180006d4b:     	movq	0x58(%rsp), %rcx
180006d50:     	callq	*0x23ea(%rip)           # 0x180009140
180006d56:     	movq	%rax, %rbx
180006d59:     	callq	*0x2589(%rip)           # 0x1800092e8
180006d5f:     	testq	%rax, %rax
180006d62:     	jne	0x180006d73 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5403>
180006d64:     	movq	%rbx, 0x10(%rdi)
180006d68:     	movq	0x40(%rsp), %rbx
180006d6d:     	addq	$0x30, %rsp
180006d71:     	popq	%rdi
180006d72:     	retq
180006d73:     	movq	0x40(%rsp), %rbx
180006d78:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180006d7d:     	addq	$0x30, %rsp
180006d81:     	popq	%rdi
180006d82:     	retq
180006d83:     	int3
180006d84:     	int3
180006d85:     	int3
180006d86:     	int3
180006d87:     	int3
180006d88:     	int3
180006d89:     	int3
180006d8a:     	int3
180006d8b:     	int3
180006d8c:     	int3
180006d8d:     	int3
180006d8e:     	int3
180006d8f:     	int3
180006d90:     	subq	$0x38, %rsp
180006d94:     	movl	%r8d, %eax
180006d97:     	movq	%rdx, %r10
180006d9a:     	movq	0x10(%rcx), %r8
180006d9e:     	movq	%rcx, %rdx
180006da1:     	movl	%eax, 0x28(%rsp)
180006da5:     	movq	%r10, %rcx
180006da8:     	movl	$0x0, 0x20(%rsp)
180006db0:     	movq	0x20(%r8), %r9
180006db4:     	movq	0x18(%r8), %r8
180006db8:     	callq	*0x245a(%rip)           # 0x180009218
180006dbe:     	addq	$0x38, %rsp
180006dc2:     	retq
180006dc3:     	int3
180006dc4:     	int3
180006dc5:     	int3
180006dc6:     	int3
180006dc7:     	int3
180006dc8:     	int3
180006dc9:     	int3
180006dca:     	int3
180006dcb:     	int3
180006dcc:     	int3
180006dcd:     	int3
180006dce:     	int3
180006dcf:     	int3
180006dd0:     	movq	0x10(%rcx), %rax
180006dd4:     	lock
180006dd5:     	incq	(%rax)
180006dd8:     	movq	0x2501(%rip), %rax      # 0x1800092e0
180006ddf:     	retq
180006de0:     	subq	$0x28, %rsp
180006de4:     	movq	0x10(%rcx), %rcx
180006de8:     	callq	0x1800080e0 <numba_list_iter_next+0x1d0>
180006ded:     	movq	0x24ec(%rip), %rax      # 0x1800092e0
180006df4:     	addq	$0x28, %rsp
180006df8:     	retq
180006df9:     	int3
180006dfa:     	int3
180006dfb:     	int3
180006dfc:     	int3
180006dfd:     	int3
180006dfe:     	int3
180006dff:     	int3
180006e00:     	movq	0x10(%rcx), %rcx
180006e04:     	movq	0x18(%rcx), %rcx
180006e08:     	jmpq	*0x2359(%rip)           # 0x180009168
180006e0f:     	int3
180006e10:     	subq	$0x28, %rsp
180006e14:     	movq	0x10(%rcx), %rax
180006e18:     	testq	%rax, %rax
180006e1b:     	je	0x180006e39 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x54c9>
180006e1d:     	cmpq	$0x0, 0x18(%rax)
180006e22:     	je	0x180006e39 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x54c9>
180006e24:     	movq	(%rax), %rcx
180006e27:     	nop
180006e28:     	cmpq	$-0x1, %rcx
180006e2c:     	je	0x180006e39 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x54c9>
180006e2e:     	addq	$0x28, %rsp
180006e32:     	jmpq	*0x22ef(%rip)           # 0x180009128
180006e39:     	movq	0x23c8(%rip), %rcx      # 0x180009208
180006e40:     	leaq	0x2f99(%rip), %rdx      # 0x180009de0
180006e47:     	movq	(%rcx), %rcx
180006e4a:     	callq	*0x2468(%rip)           # 0x1800092b8
180006e50:     	xorl	%eax, %eax
180006e52:     	addq	$0x28, %rsp
180006e56:     	retq
180006e57:     	int3
180006e58:     	int3
180006e59:     	int3
180006e5a:     	int3
180006e5b:     	int3
180006e5c:     	int3
180006e5d:     	int3
180006e5e:     	int3
180006e5f:     	int3
180006e60:     	movq	0x10(%rcx), %rcx
180006e64:     	movq	0x28(%rcx), %rcx
180006e68:     	jmpq	*0x22f9(%rip)           # 0x180009168
180006e6f:     	int3
180006e70:     	movq	0x10(%rcx), %rax
180006e74:     	movq	0x10(%rax), %rax
180006e78:     	testq	%rax, %rax
180006e7b:     	je	0x180006e8c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x551c>
180006e7d:     	movl	(%rax), %ecx
180006e7f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180006e85:     	jae	0x180006eaa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x553a>
180006e87:     	incl	%ecx
180006e89:     	movl	%ecx, (%rax)
180006e8b:     	retq
180006e8c:     	movq	0x244d(%rip), %rcx      # 0x1800092e0
180006e93:     	movl	(%rcx), %eax
180006e95:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180006e9a:     	jae	0x180006ea7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5537>
180006e9c:     	incl	%eax
180006e9e:     	movl	%eax, (%rcx)
180006ea0:     	movq	0x2439(%rip), %rcx      # 0x1800092e0
180006ea7:     	movq	%rcx, %rax
180006eaa:     	retq
180006eab:     	int3
180006eac:     	int3
180006ead:     	int3
180006eae:     	int3
180006eaf:     	int3
180006eb0:     	pushq	%rbx
180006eb2:     	subq	$0x20, %rsp
180006eb6:     	movq	%rcx, %rbx
180006eb9:     	movq	0x10(%rcx), %rcx
180006ebd:     	callq	0x1800080e0 <numba_list_iter_next+0x1d0>
180006ec2:     	movq	0x8(%rbx), %rax
180006ec6:     	movq	%rbx, %rcx
180006ec9:     	addq	$0x20, %rsp
180006ecd:     	popq	%rbx
180006ece:     	jmpq	*0x140(%rax)
180006ed5:     	int3
180006ed6:     	int3
180006ed7:     	int3
180006ed8:     	int3
180006ed9:     	int3
180006eda:     	int3
180006edb:     	int3
180006edc:     	int3
180006edd:     	int3
180006ede:     	int3
180006edf:     	int3
180006ee0:     	movq	%rdi, 0x18(%rsp)
180006ee5:     	pushq	%r14
180006ee7:     	subq	$0x20, %rsp
180006eeb:     	movq	0x9d4e(%rip), %rax      # 0x180010c40
180006ef2:     	movq	%rdx, %r14
180006ef5:     	movq	%rcx, %rdi
180006ef8:     	movq	0x8(%rcx), %rcx
180006efc:     	movq	0x10(%rax), %rdx
180006f00:     	cmpq	%rdx, %rcx
180006f03:     	je	0x180006f20 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x55b0>
180006f05:     	callq	*0x22dd(%rip)           # 0x1800091e8
180006f0b:     	testl	%eax, %eax
180006f0d:     	jne	0x180006f20 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x55b0>
180006f0f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180006f14:     	movq	0x40(%rsp), %rdi
180006f19:     	addq	$0x20, %rsp
180006f1d:     	popq	%r14
180006f1f:     	retq
180006f20:     	movq	%rbx, 0x30(%rsp)
180006f25:     	movq	%rdi, %rdx
180006f28:     	movq	0x10(%rdi), %rbx
180006f2c:     	movq	%rbx, %rcx
180006f2f:     	movq	%rsi, 0x38(%rsp)
180006f34:     	movl	0x18(%rdi), %esi
180006f37:     	callq	0x180006c90 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5320>
180006f3c:     	movq	%rax, (%r14)
180006f3f:     	movq	0x9cfa(%rip), %rax      # 0x180010c40
180006f46:     	movq	%rbx, 0x20(%r14)
180006f4a:     	movl	0x18(%rdi), %edx
180006f4d:     	movq	0x20(%rdi), %rcx
180006f51:     	callq	*0x4f0(%rax)
180006f57:     	cmpl	$0x12, 0x9cee(%rip)     # 0x180010c4c
180006f5e:     	movq	0x30(%rsp), %rbx
180006f63:     	movq	%rax, 0x10(%r14)
180006f67:     	movq	0x38(%rdi), %rax
180006f6b:     	jl	0x180006f73 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5603>
180006f6d:     	movq	0x28(%rax), %rax
180006f71:     	jmp	0x180006f77 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5607>
180006f73:     	movslq	0x20(%rax), %rax
180006f77:     	xorl	%r8d, %r8d
180006f7a:     	movq	%rax, 0x18(%r14)
180006f7e:     	movq	%rdi, 0x8(%r14)
180006f82:     	leaq	0x28(%r14), %rax
180006f86:     	testl	%esi, %esi
180006f88:     	jle	0x180006fcb <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x565b>
180006f8a:     	nopw	(%rax,%rax)
180006f90:     	movq	0x20(%rdi), %rcx
180006f94:     	movq	(%rcx,%r8,8), %rdx
180006f98:     	incl	%r8d
180006f9b:     	movq	%rdx, (%rax)
180006f9e:     	addq	$0x8, %rax
180006fa2:     	cmpl	%esi, %r8d
180006fa5:     	jl	0x180006f90 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5620>
180006fa7:     	xorl	%r8d, %r8d
180006faa:     	nopw	(%rax,%rax)
180006fb0:     	movq	0x28(%rdi), %rcx
180006fb4:     	leaq	0x8(%rax), %rax
180006fb8:     	movslq	%r8d, %rdx
180006fbb:     	incl	%r8d
180006fbe:     	movq	(%rcx,%rdx,8), %rdx
180006fc2:     	movq	%rdx, -0x8(%rax)
180006fc6:     	cmpl	%esi, %r8d
180006fc9:     	jl	0x180006fb0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5640>
180006fcb:     	movq	0x38(%rsp), %rsi
180006fd0:     	xorl	%eax, %eax
180006fd2:     	movq	0x40(%rsp), %rdi
180006fd7:     	addq	$0x20, %rsp
180006fdb:     	popq	%r14
180006fdd:     	retq
180006fde:     	int3
180006fdf:     	int3
180006fe0:     	pushq	%rbx
180006fe2:     	pushq	%rbp
180006fe3:     	pushq	%rsi
180006fe4:     	pushq	%rdi
180006fe5:     	subq	$0x28, %rsp
180006fe9:     	cmpq	$0x0, 0x9c67(%rip)      # 0x180010c58
180006ff1:     	movq	%rcx, %rbp
180006ff4:     	movslq	0x8(%rdx), %rdi
180006ff8:     	movq	(%rdx), %rsi
180006ffb:     	jne	0x180007053 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x56e3>
180006ffd:     	leaq	0x2ce4(%rip), %rcx      # 0x180009ce8
180007004:     	callq	*0x223e(%rip)           # 0x180009248
18000700a:     	movq	%rax, %rbx
18000700d:     	testq	%rax, %rax
180007010:     	je	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
180007016:     	leaq	0x2cd3(%rip), %rdx      # 0x180009cf0
18000701d:     	movq	%rax, %rcx
180007020:     	callq	*0x2152(%rip)           # 0x180009178
180007026:     	movl	(%rbx), %edx
180007028:     	movq	%rax, 0x9c29(%rip)      # 0x180010c58
18000702f:     	testl	%edx, %edx
180007031:     	js	0x18000704a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x56da>
180007033:     	subl	$0x1, %edx
180007036:     	movl	%edx, (%rbx)
180007038:     	jne	0x18000704a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x56da>
18000703a:     	movq	%rbx, %rcx
18000703d:     	callq	*0x2195(%rip)           # 0x1800091d8
180007043:     	movq	0x9c0e(%rip), %rax      # 0x180010c58
18000704a:     	testq	%rax, %rax
18000704d:     	je	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
180007053:     	movq	%rdi, %rdx
180007056:     	movq	%rsi, %rcx
180007059:     	callq	*0x2269(%rip)           # 0x1800092c8
18000705f:     	movq	%rax, %rdi
180007062:     	testq	%rax, %rax
180007065:     	je	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
180007067:     	movq	0x9bea(%rip), %rcx      # 0x180010c58
18000706e:     	xorl	%r8d, %r8d
180007071:     	movq	%rax, %rdx
180007074:     	callq	*0x212e(%rip)           # 0x1800091a8
18000707a:     	movl	(%rdi), %ecx
18000707c:     	movq	%rax, %rbx
18000707f:     	testl	%ecx, %ecx
180007081:     	js	0x180007093 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5723>
180007083:     	subl	$0x1, %ecx
180007086:     	movl	%ecx, (%rdi)
180007088:     	jne	0x180007093 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5723>
18000708a:     	movq	%rdi, %rcx
18000708d:     	callq	*0x2145(%rip)           # 0x1800091d8
180007093:     	testq	%rbx, %rbx
180007096:     	je	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
180007098:     	movq	0x8(%rbx), %r8
18000709c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
1800070a7:     	jne	0x1800070e5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5775>
1800070a9:     	movq	0x2200(%rip), %rcx      # 0x1800092b0
1800070b0:     	leaq	0x2e31(%rip), %rdx      # 0x180009ee8
1800070b7:     	movq	0x18(%r8), %r8
1800070bb:     	movq	(%rcx), %rcx
1800070be:     	callq	*0x213c(%rip)           # 0x180009200
1800070c4:     	movl	(%rbx), %eax
1800070c6:     	testl	%eax, %eax
1800070c8:     	js	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
1800070ca:     	subl	$0x1, %eax
1800070cd:     	movl	%eax, (%rbx)
1800070cf:     	jne	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
1800070d1:     	movq	%rbx, %rcx
1800070d4:     	callq	*0x20fe(%rip)           # 0x1800091d8
1800070da:     	xorl	%eax, %eax
1800070dc:     	addq	$0x28, %rsp
1800070e0:     	popq	%rdi
1800070e1:     	popq	%rsi
1800070e2:     	popq	%rbp
1800070e3:     	popq	%rbx
1800070e4:     	retq
1800070e5:     	xorl	%r8d, %r8d
1800070e8:     	leaq	0x9211(%rip), %rcx      # 0x180010300
1800070ef:     	xorl	%edx, %edx
1800070f1:     	callq	*0x2161(%rip)           # 0x180009258
1800070f7:     	movq	%rax, %rdi
1800070fa:     	testq	%rax, %rax
1800070fd:     	je	0x1800070c4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5754>
1800070ff:     	movq	%rbp, %rcx
180007102:     	movq	%rbx, 0x18(%rax)
180007106:     	callq	*0x20c4(%rip)           # 0x1800091d0
18000710c:     	movq	%rax, 0x10(%rdi)
180007110:     	movq	%rax, %rcx
180007113:     	testq	%rax, %rax
180007116:     	jne	0x18000712a <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x57ba>
180007118:     	movl	(%rdi), %eax
18000711a:     	testl	%eax, %eax
18000711c:     	js	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
18000711e:     	subl	$0x1, %eax
180007121:     	movl	%eax, (%rdi)
180007123:     	jne	0x1800070da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x576a>
180007125:     	movq	%rdi, %rcx
180007128:     	jmp	0x1800070d4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5764>
18000712a:     	movl	(%rax), %eax
18000712c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007131:     	jae	0x180007137 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x57c7>
180007133:     	incl	%eax
180007135:     	movl	%eax, (%rcx)
180007137:     	movq	%rdi, %rax
18000713a:     	addq	$0x28, %rsp
18000713e:     	popq	%rdi
18000713f:     	popq	%rsi
180007140:     	popq	%rbp
180007141:     	popq	%rbx
180007142:     	retq
180007143:     	int3
180007144:     	int3
180007145:     	int3
180007146:     	int3
180007147:     	int3
180007148:     	int3
180007149:     	int3
18000714a:     	int3
18000714b:     	int3
18000714c:     	int3
18000714d:     	int3
18000714e:     	int3
18000714f:     	int3
180007150:     	movq	%r9, 0x20(%rsp)
180007155:     	movq	%r8, 0x18(%rsp)
18000715a:     	movq	%rdx, 0x10(%rsp)
18000715f:     	movq	%rcx, 0x8(%rsp)
180007164:     	pushq	%rbx
180007165:     	pushq	%rbp
180007166:     	pushq	%rsi
180007167:     	pushq	%rdi
180007168:     	pushq	%r12
18000716a:     	pushq	%r13
18000716c:     	pushq	%r14
18000716e:     	pushq	%r15
180007170:     	subq	$0x68, %rsp
180007174:     	movq	%rcx, %r14
180007177:     	movq	%r9, %r15
18000717a:     	leaq	0x281f(%rip), %rcx      # 0x1800099a0
180007181:     	movq	%r8, %r13
180007184:     	movq	%rdx, %rsi
180007187:     	callq	*0x20bb(%rip)           # 0x180009248
18000718d:     	movq	%rax, %rdi
180007190:     	testq	%rax, %rax
180007193:     	jne	0x1800071cc <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x585c>
180007195:     	movq	0x1f9c(%rip), %rcx      # 0x180009138
18000719c:     	movq	(%rcx), %rcx
18000719f:     	callq	*0x201b(%rip)           # 0x1800091c0
1800071a5:     	testl	%eax, %eax
1800071a7:     	je	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
1800071ad:     	callq	*0x211d(%rip)           # 0x1800092d0
1800071b3:     	leaq	0x2806(%rip), %rcx      # 0x1800099c0
1800071ba:     	callq	*0x2088(%rip)           # 0x180009248
1800071c0:     	movq	%rax, %rdi
1800071c3:     	testq	%rax, %rax
1800071c6:     	je	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
1800071cc:     	leaq	0x280d(%rip), %rdx      # 0x1800099e0
1800071d3:     	movq	%rdi, %rcx
1800071d6:     	callq	*0x1f9c(%rip)           # 0x180009178
1800071dc:     	movl	(%rdi), %ecx
1800071de:     	movq	%rax, %rbx
1800071e1:     	testl	%ecx, %ecx
1800071e3:     	js	0x1800071f5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5885>
1800071e5:     	subl	$0x1, %ecx
1800071e8:     	movl	%ecx, (%rdi)
1800071ea:     	jne	0x1800071f5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5885>
1800071ec:     	movq	%rdi, %rcx
1800071ef:     	callq	*0x1fe3(%rip)           # 0x1800091d8
1800071f5:     	testq	%rbx, %rbx
1800071f8:     	je	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
1800071fe:     	movq	0x1efb(%rip), %rax      # 0x180009100
180007205:     	cmpq	%rax, 0x8(%rbx)
180007209:     	je	0x180007245 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x58d5>
18000720b:     	movq	0x20ae(%rip), %rcx      # 0x1800092c0
180007212:     	leaq	0x27d7(%rip), %rdx      # 0x1800099f0
180007219:     	movq	(%rcx), %rcx
18000721c:     	callq	*0x2096(%rip)           # 0x1800092b8
180007222:     	movl	(%rbx), %eax
180007224:     	testl	%eax, %eax
180007226:     	js	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
18000722c:     	subl	$0x1, %eax
18000722f:     	movl	%eax, (%rbx)
180007231:     	jne	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
180007237:     	movq	%rbx, %rcx
18000723a:     	callq	*0x1f98(%rip)           # 0x1800091d8
180007240:     	jmp	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
180007245:     	xorl	%edx, %edx
180007247:     	movq	%rbx, %rcx
18000724a:     	callq	*0x1f68(%rip)           # 0x1800091b8
180007250:     	movl	(%rbx), %ecx
180007252:     	movq	%rax, 0x99e7(%rip)      # 0x180010c40
180007259:     	testl	%ecx, %ecx
18000725b:     	js	0x180007274 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5904>
18000725d:     	subl	$0x1, %ecx
180007260:     	movl	%ecx, (%rbx)
180007262:     	jne	0x180007274 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5904>
180007264:     	movq	%rbx, %rcx
180007267:     	callq	*0x1f6b(%rip)           # 0x1800091d8
18000726d:     	movq	0x99cc(%rip), %rax      # 0x180010c40
180007274:     	testq	%rax, %rax
180007277:     	jne	0x180007292 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5922>
180007279:     	leaq	0x2798(%rip), %rdx      # 0x180009a18
180007280:     	movq	0x2039(%rip), %rcx      # 0x1800092c0
180007287:     	movq	(%rcx), %rcx
18000728a:     	callq	*0x2028(%rip)           # 0x1800092b8
180007290:     	jmp	0x1800072c7 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5957>
180007292:     	callq	*(%rax)
180007294:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
180007299:     	jbe	0x1800072fa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x598a>
18000729b:     	movq	0x201e(%rip), %rax      # 0x1800092c0
1800072a2:     	movq	(%rax), %rbx
1800072a5:     	movq	0x9994(%rip), %rax      # 0x180010c40
1800072ac:     	callq	*(%rax)
1800072ae:     	movl	$0x2000000, %r8d        # imm = 0x2000000
1800072b4:     	leaq	0x2785(%rip), %rdx      # 0x180009a40
1800072bb:     	movl	%eax, %r9d
1800072be:     	movq	%rbx, %rcx
1800072c1:     	callq	*0x1f39(%rip)           # 0x180009200
1800072c7:     	callq	*0x1e4b(%rip)           # 0x180009118
1800072cd:     	movq	0x2034(%rip), %rcx      # 0x180009308
1800072d4:     	leaq	0x298d(%rip), %rdx      # 0x180009c68
1800072db:     	movq	(%rcx), %rcx
1800072de:     	callq	*0x1fd4(%rip)           # 0x1800092b8
1800072e4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800072e9:     	addq	$0x68, %rsp
1800072ed:     	popq	%r15
1800072ef:     	popq	%r14
1800072f1:     	popq	%r13
1800072f3:     	popq	%r12
1800072f5:     	popq	%rdi
1800072f6:     	popq	%rsi
1800072f7:     	popq	%rbp
1800072f8:     	popq	%rbx
1800072f9:     	retq
1800072fa:     	movq	0x993f(%rip), %rax      # 0x180010c40
180007301:     	callq	*0x698(%rax)
180007307:     	movl	%eax, 0x993f(%rip)      # 0x180010c4c
18000730d:     	cmpl	$0x10, %eax
180007310:     	jge	0x18000732e <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x59be>
180007312:     	movq	0x1fa7(%rip), %rcx      # 0x1800092c0
180007319:     	leaq	0x2770(%rip), %rdx      # 0x180009a90
180007320:     	movl	%eax, %r9d
180007323:     	movl	$0x10, %r8d
180007329:     	movq	(%rcx), %rcx
18000732c:     	jmp	0x1800072c1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5951>
18000732e:     	movq	0x990b(%rip), %rax      # 0x180010c40
180007335:     	callq	*0x690(%rax)
18000733b:     	testl	%eax, %eax
18000733d:     	jne	0x18000734b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x59db>
18000733f:     	leaq	0x289a(%rip), %rdx      # 0x180009be0
180007346:     	jmp	0x180007280 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5910>
18000734b:     	cmpl	$0x1, %eax
18000734e:     	je	0x18000735c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x59ec>
180007350:     	leaq	0x28b9(%rip), %rdx      # 0x180009c10
180007357:     	jmp	0x180007280 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5910>
18000735c:     	leaq	0x947d(%rip), %rcx      # 0x1800107e0
180007363:     	callq	*0x1e17(%rip)           # 0x180009180
180007369:     	testl	%eax, %eax
18000736b:     	jne	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
180007371:     	leaq	0x8f88(%rip), %rcx      # 0x180010300
180007378:     	callq	*0x1e02(%rip)           # 0x180009180
18000737e:     	testl	%eax, %eax
180007380:     	jne	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
180007386:     	leaq	0x92b3(%rip), %rcx      # 0x180010640
18000738d:     	callq	*0x1ded(%rip)           # 0x180009180
180007393:     	testl	%eax, %eax
180007395:     	jne	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
18000739b:     	xorl	%ebx, %ebx
18000739d:     	cmpl	%ebx, 0x98a5(%rip)      # 0x180010c48
1800073a3:     	jne	0x1800073e6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5a76>
1800073a5:     	movq	%gs:0x58, %rax
1800073ae:     	movl	0x98ac(%rip), %ecx      # 0x180010c60
1800073b4:     	movl	$0x1, 0x988a(%rip)      # 0x180010c48
1800073be:     	movq	(%rax,%rcx,8), %rdx
1800073c2:     	movl	$0x10, %eax
1800073c7:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800073ce:     	movl	$0x9f0, %eax            # imm = 0x9F0
1800073d3:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800073da:     	movl	$0x13d0, %eax           # imm = 0x13D0
1800073df:     	movl	%ebx, 0x9d0(%rax,%rdx)
1800073e6:     	movl	%ebx, 0x980c(%rip)      # 0x180010bf8
1800073ec:     	movq	%rbx, %rax
1800073ef:     	movb	%bl, 0x980b(%rip)       # 0x180010c00
1800073f5:     	movq	%rbx, %rcx
1800073f8:     	xchgq	%rax, 0x9809(%rip)      # 0x180010c08
1800073ff:     	xchgq	%rcx, 0x980a(%rip)      # 0x180010c10
180007406:     	movq	%rbx, %rax
180007409:     	movq	%rbx, %rcx
18000740c:     	xchgq	%rax, 0x9805(%rip)      # 0x180010c18
180007413:     	xchgq	%rcx, 0x9806(%rip)      # 0x180010c20
18000741a:     	movq	0x1c47(%rip), %rax      # 0x180009068
180007421:     	leaq	0x9078(%rip), %rcx      # 0x1800104a0
180007428:     	movq	%rax, 0x97f9(%rip)      # 0x180010c28
18000742f:     	movq	0x1c2a(%rip), %rax      # 0x180009060
180007436:     	movq	%rax, 0x97f3(%rip)      # 0x180010c30
18000743d:     	movq	0x1c2c(%rip), %rax      # 0x180009070
180007444:     	movq	%rax, 0x97ed(%rip)      # 0x180010c38
18000744b:     	movq	0x1e06(%rip), %rax      # 0x180009258
180007452:     	movq	%rax, 0x917f(%rip)      # 0x1800105d8
180007459:     	callq	*0x1d21(%rip)           # 0x180009180
18000745f:     	testl	%eax, %eax
180007461:     	jne	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
180007467:     	leaq	0x2912(%rip), %rdx      # 0x180009d80
18000746e:     	movq	%r14, %rcx
180007471:     	callq	*0x1d01(%rip)           # 0x180009178
180007477:     	movq	%rax, 0x28(%rsp)
18000747c:     	movq	%rax, %rdi
18000747f:     	testq	%rax, %rax
180007482:     	je	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
180007488:     	leaq	0x2a8a(%rip), %rcx      # 0x180009f19
18000748f:     	callq	*0x1dfb(%rip)           # 0x180009290
180007495:     	movq	%rax, 0x20(%rsp)
18000749a:     	movq	%rax, %r12
18000749d:     	testq	%rax, %rax
1800074a0:     	je	0x1800077e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e74>
1800074a6:     	movl	%ebx, %ebp
1800074a8:     	cmpq	%rbx, (%rsi)
1800074ab:     	je	0x180007654 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5ce4>
1800074b1:     	movslq	%ebp, %rbx
1800074b4:     	leaq	0x30(%rsp), %rdx
1800074b9:     	movq	%r14, %rcx
1800074bc:     	leaq	(%rbx,%rbx,4), %rax
1800074c0:     	movups	(%r13,%rax,8), %xmm0
1800074c6:     	movups	0x10(%r13,%rax,8), %xmm1
1800074cc:     	movaps	%xmm0, 0x30(%rsp)
1800074d1:     	movsd	0x20(%r13,%rax,8), %xmm0
1800074d8:     	movsd	%xmm0, 0x50(%rsp)
1800074de:     	movaps	%xmm1, 0x40(%rsp)
1800074e3:     	callq	0x180006fe0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5670>
1800074e8:     	movq	%rax, %r14
1800074eb:     	testq	%rax, %rax
1800074ee:     	je	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
1800074f4:     	movq	(%rsi), %rcx
1800074f7:     	callq	*0x1d93(%rip)           # 0x180009290
1800074fd:     	movq	%rax, %r13
180007500:     	testq	%rax, %rax
180007503:     	je	0x180007807 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e97>
180007509:     	movq	(%r15,%rbx,8), %rcx
18000750d:     	xorl	%edx, %edx
18000750f:     	movq	%r14, (%rcx)
180007512:     	leaq	0x92c7(%rip), %rcx      # 0x1800107e0
180007519:     	movq	0x8(%rsi), %r12
18000751d:     	callq	*0x1c3d(%rip)           # 0x180009160
180007523:     	movq	%rax, %rbx
180007526:     	testq	%rax, %rax
180007529:     	je	0x1800075a6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c36>
18000752b:     	movq	%r13, %rcx
18000752e:     	callq	*0x1c5c(%rip)           # 0x180009190
180007534:     	movq	%rax, %rdi
180007537:     	testq	%rax, %rax
18000753a:     	je	0x18000755c <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5bec>
18000753c:     	movq	%rax, %rcx
18000753f:     	callq	0x180008ddd <numba_list_iter_next+0xecd>
180007544:     	leaq	0x1(%rax), %rcx
180007548:     	callq	*0x1d12(%rip)           # 0x180009260
18000754e:     	movq	%rax, %rsi
180007551:     	testq	%rax, %rax
180007554:     	jne	0x180007564 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5bf4>
180007556:     	callq	*0x1bf4(%rip)           # 0x180009150
18000755c:     	xorl	%eax, %eax
18000755e:     	movq	%rax, 0x20(%rbx)
180007562:     	jmp	0x180007595 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c25>
180007564:     	movq	%rdi, %rdx
180007567:     	movq	%rsi, %rcx
18000756a:     	callq	0x180008dd7 <numba_list_iter_next+0xec7>
18000756f:     	movq	0x20(%rsp), %rcx
180007574:     	movq	%rsi, 0x20(%rbx)
180007578:     	movq	%r12, 0x28(%rbx)
18000757c:     	movl	$0x3, 0x30(%rbx)
180007583:     	callq	0x180006a60 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x50f0>
180007588:     	movq	%rax, 0x38(%rbx)
18000758c:     	testq	%rax, %rax
18000758f:     	jne	0x180007700 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d90>
180007595:     	movl	(%rbx), %eax
180007597:     	testl	%eax, %eax
180007599:     	js	0x1800075a6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c36>
18000759b:     	subl	$0x1, %eax
18000759e:     	movl	%eax, (%rbx)
1800075a0:     	je	0x18000774d <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5ddd>
1800075a6:     	xorl	%edi, %edi
1800075a8:     	movl	(%r14), %eax
1800075ab:     	testl	%eax, %eax
1800075ad:     	js	0x1800075c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c50>
1800075af:     	subl	$0x1, %eax
1800075b2:     	movl	%eax, (%r14)
1800075b5:     	jne	0x1800075c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c50>
1800075b7:     	movq	%r14, %rcx
1800075ba:     	callq	*0x1c18(%rip)           # 0x1800091d8
1800075c0:     	movl	(%r13), %eax
1800075c4:     	testl	%eax, %eax
1800075c6:     	js	0x1800075da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c6a>
1800075c8:     	subl	$0x1, %eax
1800075cb:     	movl	%eax, (%r13)
1800075cf:     	jne	0x1800075da <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c6a>
1800075d1:     	movq	%r13, %rcx
1800075d4:     	callq	*0x1bfe(%rip)           # 0x1800091d8
1800075da:     	testq	%rdi, %rdi
1800075dd:     	je	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
1800075e3:     	movq	0xb8(%rsp), %rsi
1800075eb:     	movq	%rdi, %r8
1800075ee:     	movq	0xb0(%rsp), %r14
1800075f6:     	movq	%r14, %rcx
1800075f9:     	movq	(%rsi), %rdx
1800075fc:     	callq	*0x1c2e(%rip)           # 0x180009230
180007602:     	movl	(%rdi), %ecx
180007604:     	testl	%eax, %eax
180007606:     	jne	0x1800077aa <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e3a>
18000760c:     	testl	%ecx, %ecx
18000760e:     	js	0x180007622 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5cb2>
180007610:     	leal	-0x1(%rcx), %eax
180007613:     	movl	%eax, (%rdi)
180007615:     	testl	%eax, %eax
180007617:     	jne	0x180007622 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5cb2>
180007619:     	movq	%rdi, %rcx
18000761c:     	callq	*0x1bb6(%rip)           # 0x1800091d8
180007622:     	movq	0xc8(%rsp), %r15
18000762a:     	addq	$0x20, %rsi
18000762e:     	movq	0xc0(%rsp), %r13
180007636:     	incl	%ebp
180007638:     	movq	%rsi, 0xb8(%rsp)
180007640:     	cmpq	$0x0, (%rsi)
180007644:     	jne	0x1800074b1 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5b41>
18000764a:     	movq	0x20(%rsp), %r12
18000764f:     	movq	0x28(%rsp), %rdi
180007654:     	movslq	%ebp, %rax
180007657:     	cmpq	$0x0, (%r15,%rax,8)
18000765c:     	je	0x1800076c9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d59>
18000765e:     	nop
180007660:     	movslq	%ebp, %rbx
180007663:     	leaq	0x30(%rsp), %rdx
180007668:     	movq	%r14, %rcx
18000766b:     	leaq	(%rbx,%rbx,4), %rax
18000766f:     	movups	(%r13,%rax,8), %xmm0
180007675:     	movups	0x10(%r13,%rax,8), %xmm1
18000767b:     	movaps	%xmm0, 0x30(%rsp)
180007680:     	movsd	0x20(%r13,%rax,8), %xmm0
180007687:     	movsd	%xmm0, 0x50(%rsp)
18000768d:     	movaps	%xmm1, 0x40(%rsp)
180007692:     	callq	0x180006fe0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5670>
180007697:     	testq	%rax, %rax
18000769a:     	je	0x1800077c5 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e55>
1800076a0:     	movq	(%r15,%rbx,8), %rcx
1800076a4:     	movq	%rax, (%rcx)
1800076a7:     	movl	(%rax), %ecx
1800076a9:     	testl	%ecx, %ecx
1800076ab:     	js	0x1800076bd <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d4d>
1800076ad:     	subl	$0x1, %ecx
1800076b0:     	movl	%ecx, (%rax)
1800076b2:     	jne	0x1800076bd <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d4d>
1800076b4:     	movq	%rax, %rcx
1800076b7:     	callq	*0x1b1b(%rip)           # 0x1800091d8
1800076bd:     	incl	%ebp
1800076bf:     	movslq	%ebp, %rax
1800076c2:     	cmpq	$0x0, (%r15,%rax,8)
1800076c7:     	jne	0x180007660 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5cf0>
1800076c9:     	movl	(%r12), %eax
1800076cd:     	testl	%eax, %eax
1800076cf:     	js	0x1800076e3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d73>
1800076d1:     	subl	$0x1, %eax
1800076d4:     	movl	%eax, (%r12)
1800076d8:     	jne	0x1800076e3 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d73>
1800076da:     	movq	%r12, %rcx
1800076dd:     	callq	*0x1af5(%rip)           # 0x1800091d8
1800076e3:     	movl	(%rdi), %eax
1800076e5:     	testl	%eax, %eax
1800076e7:     	js	0x1800076f9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d89>
1800076e9:     	subl	$0x1, %eax
1800076ec:     	movl	%eax, (%rdi)
1800076ee:     	jne	0x1800076f9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d89>
1800076f0:     	movq	%rdi, %rcx
1800076f3:     	callq	*0x1adf(%rip)           # 0x1800091d8
1800076f9:     	xorl	%eax, %eax
1800076fb:     	jmp	0x1800072e9 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5979>
180007700:     	movl	(%r14), %eax
180007703:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180007708:     	jae	0x18000770f <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5d9f>
18000770a:     	incl	%eax
18000770c:     	movl	%eax, (%r14)
18000770f:     	movq	0xb0(%rsp), %rcx
180007717:     	leaq	0x2662(%rip), %rdx      # 0x180009d80
18000771e:     	movq	%r14, 0x18(%rbx)
180007722:     	movq	$0x0, 0x40(%rbx)
18000772a:     	callq	*0x1a48(%rip)           # 0x180009178
180007730:     	movq	%rax, %rsi
180007733:     	testq	%rax, %rax
180007736:     	jne	0x18000775b <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5deb>
180007738:     	movl	(%rbx), %eax
18000773a:     	testl	%eax, %eax
18000773c:     	js	0x1800075a6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c36>
180007742:     	subl	$0x1, %eax
180007745:     	movl	%eax, (%rbx)
180007747:     	jne	0x1800075a6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c36>
18000774d:     	movq	%rbx, %rcx
180007750:     	callq	*0x1a82(%rip)           # 0x1800091d8
180007756:     	jmp	0x1800075a6 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c36>
18000775b:     	xorl	%r9d, %r9d
18000775e:     	leaq	0x20(%rbx), %rcx
180007762:     	movq	%rsi, %r8
180007765:     	movq	%rbx, %rdx
180007768:     	callq	*0x19ea(%rip)           # 0x180009158
18000776e:     	movq	%rax, %rdi
180007771:     	movl	(%rbx), %eax
180007773:     	testl	%eax, %eax
180007775:     	js	0x180007787 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e17>
180007777:     	subl	$0x1, %eax
18000777a:     	movl	%eax, (%rbx)
18000777c:     	jne	0x180007787 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e17>
18000777e:     	movq	%rbx, %rcx
180007781:     	callq	*0x1a51(%rip)           # 0x1800091d8
180007787:     	movl	(%rsi), %eax
180007789:     	testl	%eax, %eax
18000778b:     	js	0x1800075a8 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c38>
180007791:     	subl	$0x1, %eax
180007794:     	movl	%eax, (%rsi)
180007796:     	jne	0x1800075a8 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c38>
18000779c:     	movq	%rsi, %rcx
18000779f:     	callq	*0x1a33(%rip)           # 0x1800091d8
1800077a5:     	jmp	0x1800075a8 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5c38>
1800077aa:     	testl	%ecx, %ecx
1800077ac:     	js	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
1800077ae:     	leal	-0x1(%rcx), %eax
1800077b1:     	movl	%eax, (%rdi)
1800077b3:     	testl	%eax, %eax
1800077b5:     	jne	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
1800077b7:     	movq	%rdi, %rcx
1800077ba:     	callq	*0x1a18(%rip)           # 0x1800091d8
1800077c0:     	movq	0x20(%rsp), %r12
1800077c5:     	movl	(%r12), %eax
1800077c9:     	testl	%eax, %eax
1800077cb:     	js	0x1800077df <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e6f>
1800077cd:     	subl	$0x1, %eax
1800077d0:     	movl	%eax, (%r12)
1800077d4:     	jne	0x1800077df <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e6f>
1800077d6:     	movq	%r12, %rcx
1800077d9:     	callq	*0x19f9(%rip)           # 0x1800091d8
1800077df:     	movq	0x28(%rsp), %rdi
1800077e4:     	movl	(%rdi), %eax
1800077e6:     	testl	%eax, %eax
1800077e8:     	js	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
1800077ee:     	subl	$0x1, %eax
1800077f1:     	movl	%eax, (%rdi)
1800077f3:     	jne	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
1800077f9:     	movq	%rdi, %rcx
1800077fc:     	callq	*0x19d6(%rip)           # 0x1800091d8
180007802:     	jmp	0x1800072e4 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5974>
180007807:     	movl	(%r14), %eax
18000780a:     	testl	%eax, %eax
18000780c:     	js	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
18000780e:     	subl	$0x1, %eax
180007811:     	movl	%eax, (%r14)
180007814:     	jne	0x1800077c0 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e50>
180007816:     	movq	%r14, %rcx
180007819:     	jmp	0x1800077ba <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5e4a>
18000781b:     	int3
18000781c:     	int3
18000781d:     	int3
18000781e:     	int3
18000781f:     	int3
180007820:     	leaq	0x9479(%rip), %rax      # 0x180010ca0
180007827:     	retq
180007828:     	int3
180007829:     	int3
18000782a:     	int3
18000782b:     	int3
18000782c:     	int3
18000782d:     	int3
18000782e:     	int3
18000782f:     	int3

0000000180007830 <numba_list_set_method_table>:
180007830:     	movups	(%rdx), %xmm0
180007833:     	movups	%xmm0, 0x20(%rcx)
180007837:     	retq
180007838:     	int3
180007839:     	int3
18000783a:     	int3
18000783b:     	int3
18000783c:     	int3
18000783d:     	int3
18000783e:     	int3
18000783f:     	int3

0000000180007840 <numba_list_new>:
180007840:     	pushq	%rbx
180007842:     	pushq	%rbp
180007843:     	pushq	%rsi
180007844:     	pushq	%rdi
180007845:     	subq	$0x28, %rsp
180007849:     	movq	%rcx, %rsi
18000784c:     	movq	%r8, %rdi
18000784f:     	movl	$0x38, %ecx
180007854:     	movq	%rdx, %rbp
180007857:     	callq	*0x180b(%rip)           # 0x180009068
18000785d:     	movq	%rax, %rbx
180007860:     	testq	%rax, %rax
180007863:     	je	0x1800078cd <numba_list_new+0x8d>
180007865:     	movq	$0x0, (%rax)
18000786c:     	xorps	%xmm0, %xmm0
18000786f:     	movq	%rbp, 0x8(%rax)
180007873:     	movq	%rdi, 0x10(%rax)
180007877:     	movl	$0x1, 0x18(%rax)
18000787e:     	movups	%xmm0, 0x20(%rax)
180007882:     	testq	%rdi, %rdi
180007885:     	je	0x1800078db <numba_list_new+0x9b>
180007887:     	imulq	%rbp, %rdi
18000788b:     	movl	$0x8, %ecx
180007890:     	movq	%rdi, %rax
180007893:     	cqto
180007895:     	andl	$0x7, %edx
180007898:     	addq	%rdx, %rax
18000789b:     	andl	$0x7, %eax
18000789e:     	subq	%rdx, %rax
1800078a1:     	subq	%rax, %rcx
1800078a4:     	movq	%rcx, %rax
1800078a7:     	cqto
1800078a9:     	andl	$0x7, %edx
1800078ac:     	leaq	(%rdx,%rax), %rcx
1800078b0:     	andl	$0x7, %ecx
1800078b3:     	subq	%rdx, %rcx
1800078b6:     	addq	%rdi, %rcx
1800078b9:     	callq	*0x17a9(%rip)           # 0x180009068
1800078bf:     	testq	%rax, %rax
1800078c2:     	jne	0x1800078dd <numba_list_new+0x9d>
1800078c4:     	movq	%rbx, %rcx
1800078c7:     	callq	*0x17a3(%rip)           # 0x180009070
1800078cd:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
1800078d2:     	addq	$0x28, %rsp
1800078d6:     	popq	%rdi
1800078d7:     	popq	%rsi
1800078d8:     	popq	%rbp
1800078d9:     	popq	%rbx
1800078da:     	retq
1800078db:     	xorl	%eax, %eax
1800078dd:     	movq	%rax, 0x30(%rbx)
1800078e1:     	xorl	%eax, %eax
1800078e3:     	movq	%rbx, (%rsi)
1800078e6:     	addq	$0x28, %rsp
1800078ea:     	popq	%rdi
1800078eb:     	popq	%rsi
1800078ec:     	popq	%rbp
1800078ed:     	popq	%rbx
1800078ee:     	retq
1800078ef:     	int3

00000001800078f0 <numba_list_free>:
1800078f0:     	pushq	%rbx
1800078f2:     	subq	$0x20, %rsp
1800078f6:     	cmpq	$0x0, 0x28(%rcx)
1800078fb:     	movq	%rcx, %rbx
1800078fe:     	je	0x180007934 <numba_list_free+0x44>
180007900:     	movq	%rdi, 0x30(%rsp)
180007905:     	xorl	%edi, %edi
180007907:     	cmpq	%rdi, (%rcx)
18000790a:     	jle	0x18000792f <numba_list_free+0x3f>
18000790c:     	nopl	(%rax)
180007910:     	movq	0x28(%rbx), %rax
180007914:     	testq	%rax, %rax
180007917:     	je	0x180007927 <numba_list_free+0x37>
180007919:     	movq	%rdi, %rcx
18000791c:     	imulq	0x8(%rbx), %rcx
180007921:     	addq	0x30(%rbx), %rcx
180007925:     	callq	*%rax
180007927:     	incq	%rdi
18000792a:     	cmpq	(%rbx), %rdi
18000792d:     	jl	0x180007910 <numba_list_free+0x20>
18000792f:     	movq	0x30(%rsp), %rdi
180007934:     	movq	0x30(%rbx), %rcx
180007938:     	testq	%rcx, %rcx
18000793b:     	je	0x180007943 <numba_list_free+0x53>
18000793d:     	callq	*0x172d(%rip)           # 0x180009070
180007943:     	movq	%rbx, %rcx
180007946:     	addq	$0x20, %rsp
18000794a:     	popq	%rbx
18000794b:     	jmpq	*0x171e(%rip)           # 0x180009070
180007952:     	int3
180007953:     	int3
180007954:     	int3
180007955:     	int3
180007956:     	int3
180007957:     	int3
180007958:     	int3
180007959:     	int3
18000795a:     	int3
18000795b:     	int3
18000795c:     	int3
18000795d:     	int3
18000795e:     	int3
18000795f:     	int3

0000000180007960 <numba_list_base_ptr>:
180007960:     	movq	0x30(%rcx), %rax
180007964:     	retq
180007965:     	int3
180007966:     	int3
180007967:     	int3
180007968:     	int3
180007969:     	int3
18000796a:     	int3
18000796b:     	int3
18000796c:     	int3
18000796d:     	int3
18000796e:     	int3
18000796f:     	int3

0000000180007970 <numba_list_size_address>:
180007970:     	movq	%rcx, %rax
180007973:     	retq
180007974:     	int3
180007975:     	int3
180007976:     	int3
180007977:     	int3
180007978:     	int3
180007979:     	int3
18000797a:     	int3
18000797b:     	int3
18000797c:     	int3
18000797d:     	int3
18000797e:     	int3
18000797f:     	int3

0000000180007980 <numba_list_length>:
180007980:     	movq	(%rcx), %rax
180007983:     	retq
180007984:     	int3
180007985:     	int3
180007986:     	int3
180007987:     	int3
180007988:     	int3
180007989:     	int3
18000798a:     	int3
18000798b:     	int3
18000798c:     	int3
18000798d:     	int3
18000798e:     	int3
18000798f:     	int3

0000000180007990 <numba_list_allocated>:
180007990:     	movq	0x10(%rcx), %rax
180007994:     	retq
180007995:     	int3
180007996:     	int3
180007997:     	int3
180007998:     	int3
180007999:     	int3
18000799a:     	int3
18000799b:     	int3
18000799c:     	int3
18000799d:     	int3
18000799e:     	int3
18000799f:     	int3

00000001800079a0 <numba_list_is_mutable>:
1800079a0:     	movl	0x18(%rcx), %eax
1800079a3:     	retq
1800079a4:     	int3
1800079a5:     	int3
1800079a6:     	int3
1800079a7:     	int3
1800079a8:     	int3
1800079a9:     	int3
1800079aa:     	int3
1800079ab:     	int3
1800079ac:     	int3
1800079ad:     	int3
1800079ae:     	int3
1800079af:     	int3

00000001800079b0 <numba_list_set_is_mutable>:
1800079b0:     	movl	%edx, 0x18(%rcx)
1800079b3:     	retq
1800079b4:     	int3
1800079b5:     	int3
1800079b6:     	int3
1800079b7:     	int3
1800079b8:     	int3
1800079b9:     	int3
1800079ba:     	int3
1800079bb:     	int3
1800079bc:     	int3
1800079bd:     	int3
1800079be:     	int3
1800079bf:     	int3

00000001800079c0 <numba_list_setitem>:
1800079c0:     	movq	%rbx, 0x10(%rsp)
1800079c5:     	pushq	%rsi
1800079c6:     	subq	$0x20, %rsp
1800079ca:     	cmpl	$0x0, 0x18(%rcx)
1800079ce:     	movq	%r8, %rsi
1800079d1:     	movq	%rcx, %rbx
1800079d4:     	jne	0x1800079e6 <numba_list_setitem+0x26>
1800079d6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
1800079db:     	movq	0x38(%rsp), %rbx
1800079e0:     	addq	$0x20, %rsp
1800079e4:     	popq	%rsi
1800079e5:     	retq
1800079e6:     	cmpq	(%rcx), %rdx
1800079e9:     	jb	0x1800079fb <numba_list_setitem+0x3b>
1800079eb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
1800079f0:     	movq	0x38(%rsp), %rbx
1800079f5:     	addq	$0x20, %rsp
1800079f9:     	popq	%rsi
1800079fa:     	retq
1800079fb:     	imulq	0x8(%rcx), %rdx
180007a00:     	movq	0x28(%rcx), %rax
180007a04:     	movq	%rdi, 0x30(%rsp)
180007a09:     	movq	0x30(%rcx), %rdi
180007a0d:     	addq	%rdx, %rdi
180007a10:     	testq	%rax, %rax
180007a13:     	je	0x180007a1a <numba_list_setitem+0x5a>
180007a15:     	movq	%rdi, %rcx
180007a18:     	callq	*%rax
180007a1a:     	movq	0x8(%rbx), %r8
180007a1e:     	movq	%rsi, %rdx
180007a21:     	movq	%rdi, %rcx
180007a24:     	callq	0x180008dcb <numba_list_iter_next+0xebb>
180007a29:     	movq	0x20(%rbx), %rax
180007a2d:     	testq	%rax, %rax
180007a30:     	je	0x180007a37 <numba_list_setitem+0x77>
180007a32:     	movq	%rdi, %rcx
180007a35:     	callq	*%rax
180007a37:     	movq	0x30(%rsp), %rdi
180007a3c:     	xorl	%eax, %eax
180007a3e:     	movq	0x38(%rsp), %rbx
180007a43:     	addq	$0x20, %rsp
180007a47:     	popq	%rsi
180007a48:     	retq
180007a49:     	int3
180007a4a:     	int3
180007a4b:     	int3
180007a4c:     	int3
180007a4d:     	int3
180007a4e:     	int3
180007a4f:     	int3

0000000180007a50 <numba_list_getitem>:
180007a50:     	subq	$0x28, %rsp
180007a54:     	movq	%r8, %r9
180007a57:     	movq	%rdx, %rax
180007a5a:     	cmpq	(%rcx), %rdx
180007a5d:     	jb	0x180007a69 <numba_list_getitem+0x19>
180007a5f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007a64:     	addq	$0x28, %rsp
180007a68:     	retq
180007a69:     	movq	0x8(%rcx), %r8
180007a6d:     	movq	%r8, %rdx
180007a70:     	imulq	%rax, %rdx
180007a74:     	addq	0x30(%rcx), %rdx
180007a78:     	movq	%r9, %rcx
180007a7b:     	callq	0x180008dcb <numba_list_iter_next+0xebb>
180007a80:     	xorl	%eax, %eax
180007a82:     	addq	$0x28, %rsp
180007a86:     	retq
180007a87:     	int3
180007a88:     	int3
180007a89:     	int3
180007a8a:     	int3
180007a8b:     	int3
180007a8c:     	int3
180007a8d:     	int3
180007a8e:     	int3
180007a8f:     	int3

0000000180007a90 <numba_list_append>:
180007a90:     	movq	%rbx, 0x10(%rsp)
180007a95:     	pushq	%rsi
180007a96:     	subq	$0x20, %rsp
180007a9a:     	cmpl	$0x0, 0x18(%rcx)
180007a9e:     	movq	%rdx, %rsi
180007aa1:     	movq	%rcx, %rbx
180007aa4:     	jne	0x180007ab6 <numba_list_append+0x26>
180007aa6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007aab:     	movq	0x38(%rsp), %rbx
180007ab0:     	addq	$0x20, %rsp
180007ab4:     	popq	%rsi
180007ab5:     	retq
180007ab6:     	movq	(%rcx), %rdx
180007ab9:     	incq	%rdx
180007abc:     	callq	0x180007b10 <numba_list_resize>
180007ac1:     	testl	%eax, %eax
180007ac3:     	js	0x180007afc <numba_list_append+0x6c>
180007ac5:     	movq	0x8(%rbx), %r8
180007ac9:     	movq	%rsi, %rdx
180007acc:     	movq	%rdi, 0x30(%rsp)
180007ad1:     	movq	(%rbx), %rdi
180007ad4:     	decq	%rdi
180007ad7:     	imulq	%r8, %rdi
180007adb:     	addq	0x30(%rbx), %rdi
180007adf:     	movq	%rdi, %rcx
180007ae2:     	callq	0x180008dcb <numba_list_iter_next+0xebb>
180007ae7:     	movq	0x20(%rbx), %rax
180007aeb:     	testq	%rax, %rax
180007aee:     	je	0x180007af5 <numba_list_append+0x65>
180007af0:     	movq	%rdi, %rcx
180007af3:     	callq	*%rax
180007af5:     	movq	0x30(%rsp), %rdi
180007afa:     	xorl	%eax, %eax
180007afc:     	movq	0x38(%rsp), %rbx
180007b01:     	addq	$0x20, %rsp
180007b05:     	popq	%rsi
180007b06:     	retq
180007b07:     	int3
180007b08:     	int3
180007b09:     	int3
180007b0a:     	int3
180007b0b:     	int3
180007b0c:     	int3
180007b0d:     	int3
180007b0e:     	int3
180007b0f:     	int3

0000000180007b10 <numba_list_resize>:
180007b10:     	movq	%rsi, 0x18(%rsp)
180007b15:     	pushq	%rdi
180007b16:     	subq	$0x20, %rsp
180007b1a:     	cmpl	$0x0, 0x18(%rcx)
180007b1e:     	movq	%rdx, %rsi
180007b21:     	movq	%rcx, %rdi
180007b24:     	jne	0x180007b36 <numba_list_resize+0x26>
180007b26:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007b2b:     	movq	0x40(%rsp), %rsi
180007b30:     	addq	$0x20, %rsp
180007b34:     	popq	%rdi
180007b35:     	retq
180007b36:     	movq	0x10(%rcx), %rax
180007b3a:     	cmpq	%rsi, %rax
180007b3d:     	jl	0x180007b57 <numba_list_resize+0x47>
180007b3f:     	sarq	%rax
180007b42:     	cmpq	%rax, %rsi
180007b45:     	jl	0x180007b57 <numba_list_resize+0x47>
180007b47:     	movq	%rsi, (%rcx)
180007b4a:     	xorl	%eax, %eax
180007b4c:     	movq	0x40(%rsp), %rsi
180007b51:     	addq	$0x20, %rsp
180007b55:     	popq	%rdi
180007b56:     	retq
180007b57:     	cmpq	$0x9, %rsi
180007b5b:     	movq	%rbp, 0x38(%rsp)
180007b60:     	movl	$0x3, %ecx
180007b65:     	movl	$0x6, %eax
180007b6a:     	cmovll	%ecx, %eax
180007b6d:     	movq	%rsi, %r8
180007b70:     	movq	0x8(%rdi), %rcx
180007b74:     	addq	%rsi, %rax
180007b77:     	sarq	$0x3, %r8
180007b7b:     	xorl	%edx, %edx
180007b7d:     	addq	%rax, %r8
180007b80:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
180007b8a:     	divq	%rcx
180007b8d:     	cmpq	%rax, %r8
180007b90:     	ja	0x180007c0b <numba_list_resize+0xfb>
180007b92:     	xorl	%ebp, %ebp
180007b94:     	movq	%rbx, 0x30(%rsp)
180007b99:     	testq	%rsi, %rsi
180007b9c:     	cmovneq	%r8, %rbp
180007ba0:     	movq	%rbp, %rbx
180007ba3:     	imulq	%rcx, %rbx
180007ba7:     	movl	$0x8, %ecx
180007bac:     	movq	%rbx, %rax
180007baf:     	cqto
180007bb1:     	andl	$0x7, %edx
180007bb4:     	addq	%rdx, %rax
180007bb7:     	andl	$0x7, %eax
180007bba:     	subq	%rdx, %rax
180007bbd:     	subq	%rax, %rcx
180007bc0:     	movq	%rcx, %rax
180007bc3:     	movq	0x30(%rdi), %rcx
180007bc7:     	cqto
180007bc9:     	andl	$0x7, %edx
180007bcc:     	addq	%rdx, %rax
180007bcf:     	andl	$0x7, %eax
180007bd2:     	subq	%rdx, %rax
180007bd5:     	leaq	(%rbx,%rax), %rdx
180007bd9:     	callq	*0x1481(%rip)           # 0x180009060
180007bdf:     	testq	%rbx, %rbx
180007be2:     	movq	0x30(%rsp), %rbx
180007be7:     	je	0x180007bee <numba_list_resize+0xde>
180007be9:     	testq	%rax, %rax
180007bec:     	je	0x180007c0b <numba_list_resize+0xfb>
180007bee:     	movq	%rax, 0x30(%rdi)
180007bf2:     	xorl	%eax, %eax
180007bf4:     	movq	%rbp, 0x10(%rdi)
180007bf8:     	movq	0x38(%rsp), %rbp
180007bfd:     	movq	%rsi, (%rdi)
180007c00:     	movq	0x40(%rsp), %rsi
180007c05:     	addq	$0x20, %rsp
180007c09:     	popq	%rdi
180007c0a:     	retq
180007c0b:     	movq	0x38(%rsp), %rbp
180007c10:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
180007c15:     	movq	0x40(%rsp), %rsi
180007c1a:     	addq	$0x20, %rsp
180007c1e:     	popq	%rdi
180007c1f:     	retq

0000000180007c20 <numba_list_delitem>:
180007c20:     	movq	%rbx, 0x10(%rsp)
180007c25:     	pushq	%rdi
180007c26:     	subq	$0x20, %rsp
180007c2a:     	cmpl	$0x0, 0x18(%rcx)
180007c2e:     	movq	%rdx, %rdi
180007c31:     	movq	%rcx, %rbx
180007c34:     	jne	0x180007c46 <numba_list_delitem+0x26>
180007c36:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007c3b:     	movq	0x38(%rsp), %rbx
180007c40:     	addq	$0x20, %rsp
180007c44:     	popq	%rdi
180007c45:     	retq
180007c46:     	cmpq	(%rcx), %rdi
180007c49:     	jb	0x180007c5b <numba_list_delitem+0x3b>
180007c4b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
180007c50:     	movq	0x38(%rsp), %rbx
180007c55:     	addq	$0x20, %rsp
180007c59:     	popq	%rdi
180007c5a:     	retq
180007c5b:     	movq	0x28(%rcx), %rax
180007c5f:     	movq	%rsi, 0x30(%rsp)
180007c64:     	movq	%rdi, %rsi
180007c67:     	imulq	0x8(%rcx), %rsi
180007c6c:     	addq	0x30(%rcx), %rsi
180007c70:     	testq	%rax, %rax
180007c73:     	je	0x180007c7a <numba_list_delitem+0x5a>
180007c75:     	movq	%rsi, %rcx
180007c78:     	callq	*%rax
180007c7a:     	movq	(%rbx), %r8
180007c7d:     	leaq	-0x1(%r8), %rax
180007c81:     	cmpq	%rax, %rdi
180007c84:     	je	0x180007ca6 <numba_list_delitem+0x86>
180007c86:     	subq	%rdi, %r8
180007c89:     	leaq	0x1(%rdi), %rdx
180007c8d:     	imulq	0x8(%rbx), %rdx
180007c92:     	decq	%r8
180007c95:     	movq	%rsi, %rcx
180007c98:     	imulq	0x8(%rbx), %r8
180007c9d:     	addq	0x30(%rbx), %rdx
180007ca1:     	callq	0x180008dd1 <numba_list_iter_next+0xec1>
180007ca6:     	movq	(%rbx), %rdx
180007ca9:     	movq	%rbx, %rcx
180007cac:     	decq	%rdx
180007caf:     	callq	0x180007b10 <numba_list_resize>
180007cb4:     	movq	0x30(%rsp), %rsi
180007cb9:     	xorl	%ecx, %ecx
180007cbb:     	movq	0x38(%rsp), %rbx
180007cc0:     	testl	%eax, %eax
180007cc2:     	cmovsl	%eax, %ecx
180007cc5:     	movl	%ecx, %eax
180007cc7:     	addq	$0x20, %rsp
180007ccb:     	popq	%rdi
180007ccc:     	retq
180007ccd:     	int3
180007cce:     	int3
180007ccf:     	int3

0000000180007cd0 <numba_list_delete_slice>:
180007cd0:     	pushq	%rbx
180007cd2:     	pushq	%rbp
180007cd3:     	pushq	%rdi
180007cd4:     	pushq	%r15
180007cd6:     	subq	$0x38, %rsp
180007cda:     	cmpl	$0x0, 0x18(%rcx)
180007cde:     	movq	%r9, %rdi
180007ce1:     	movq	%r8, %rbp
180007ce4:     	movq	%rdx, %r15
180007ce7:     	movq	%rcx, %rbx
180007cea:     	jne	0x180007cfb <numba_list_delete_slice+0x2b>
180007cec:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
180007cf1:     	addq	$0x38, %rsp
180007cf5:     	popq	%r15
180007cf7:     	popq	%rdi
180007cf8:     	popq	%rbp
180007cf9:     	popq	%rbx
180007cfa:     	retq
180007cfb:     	movq	%r13, 0x78(%rsp)
180007d00:     	testq	%rdi, %rdi
180007d03:     	jle	0x180007d22 <numba_list_delete_slice+0x52>
180007d05:     	cmpq	%r8, %r15
180007d08:     	jge	0x180007ec1 <numba_list_delete_slice+0x1f1>
180007d0e:     	movq	%r8, %rax
180007d11:     	subq	%r15, %rax
180007d14:     	decq	%rax
180007d17:     	cqto
180007d19:     	idivq	%rdi
180007d1c:     	leal	0x1(%rax), %r13d
180007d20:     	jmp	0x180007d42 <numba_list_delete_slice+0x72>
180007d22:     	cmpq	%r15, %r8
180007d25:     	jge	0x180007ec1 <numba_list_delete_slice+0x1f1>
180007d2b:     	movq	%r15, %rax
180007d2e:     	movl	$0x1, %r13d
180007d34:     	subq	%r8, %rax
180007d37:     	decq	%rax
180007d3a:     	cqto
180007d3c:     	idivq	%rdi
180007d3f:     	subl	%eax, %r13d
180007d42:     	testl	%r13d, %r13d
180007d45:     	jle	0x180007ec1 <numba_list_delete_slice+0x1f1>
180007d4b:     	movq	%rsi, 0x68(%rsp)
180007d50:     	movl	(%rcx), %esi
180007d52:     	subl	%r13d, %esi
180007d55:     	movl	%esi, 0x20(%rsp)
180007d59:     	testq	%rdi, %rdi
180007d5c:     	jns	0x180007d77 <numba_list_delete_slice+0xa7>
180007d5e:     	leaq	0x1(%r15), %rbp
180007d62:     	leal	-0x1(%r13), %eax
180007d66:     	movslq	%eax, %rcx
180007d69:     	leaq	-0x1(%rbp), %r15
180007d6d:     	imulq	%rdi, %rcx
180007d71:     	addq	%rcx, %r15
180007d74:     	negq	%rdi
180007d77:     	cmpq	$0x1, %rdi
180007d7b:     	jne	0x180007dc7 <numba_list_delete_slice+0xf7>
180007d7d:     	cmpq	$0x0, 0x28(%rbx)
180007d82:     	je	0x180007da9 <numba_list_delete_slice+0xd9>
180007d84:     	movslq	%r15d, %rdi
180007d87:     	cmpq	%rbp, %rdi
180007d8a:     	jge	0x180007da9 <numba_list_delete_slice+0xd9>
180007d8c:     	nopl	(%rax)
180007d90:     	movslq	%edi, %rcx
180007d93:     	imulq	0x8(%rbx), %rcx
180007d98:     	addq	0x30(%rbx), %rcx
180007d9c:     	callq	*0x28(%rbx)
180007d9f:     	incl	%edi
180007da1:     	movslq	%edi, %rax
180007da4:     	cmpq	%rbp, %rax
180007da7:     	jl	0x180007d90 <numba_list_delete_slice+0xc0>
180007da9:     	movq	0x8(%rbx), %rcx
180007dad:     	movq	(%rbx), %r8
180007db0:     	movq	%rcx, %rdx
180007db3:     	subq	%rbp, %r8
180007db6:     	imulq	%rcx, %r8
180007dba:     	imulq	%rbp, %rdx
180007dbe:     	imulq	%r15, %rcx
180007dc2:     	jmp	0x180007e8c <numba_list_delete_slice+0x1bc>
180007dc7:     	movq	%r14, 0x30(%rsp)
180007dcc:     	movq	%r15, %r14
180007dcf:     	movl	$0x0, 0x60(%rsp)
180007dd7:     	cmpq	%rbp, %r15
180007dda:     	jge	0x180007e59 <numba_list_delete_slice+0x189>
180007ddc:     	movq	%r12, 0x70(%rsp)
180007de1:     	movq	(%rbx), %rax
180007de4:     	leaq	(%r14,%rdi), %r12
180007de8:     	cmpq	%rax, %r12
180007deb:     	jl	0x180007df8 <numba_list_delete_slice+0x128>
180007ded:     	movq	%r14, %rsi
180007df0:     	notq	%rsi
180007df3:     	addq	%rax, %rsi
180007df6:     	jmp	0x180007dfc <numba_list_delete_slice+0x12c>
180007df8:     	leaq	-0x1(%rdi), %rsi
180007dfc:     	movq	0x28(%rbx), %rax
180007e00:     	testq	%rax, %rax
180007e03:     	je	0x180007e13 <numba_list_delete_slice+0x143>
180007e05:     	movq	%r14, %rcx
180007e08:     	imulq	0x8(%rbx), %rcx
180007e0d:     	addq	0x30(%rbx), %rcx
180007e11:     	callq	*%rax
180007e13:     	movq	0x8(%rbx), %r9
180007e17:     	leaq	0x1(%r14), %rdx
180007e1b:     	movq	0x30(%rbx), %r10
180007e1f:     	movq	%r9, %r8
180007e22:     	imulq	%rsi, %r8
180007e26:     	imulq	%r9, %rdx
180007e2a:     	movslq	0x60(%rsp), %rsi
180007e2f:     	subq	%rsi, %r14
180007e32:     	imulq	%r9, %r14
180007e36:     	addq	%r10, %rdx
180007e39:     	leaq	(%r10,%r14), %rcx
180007e3d:     	callq	0x180008dd1 <numba_list_iter_next+0xec1>
180007e42:     	incl	%esi
180007e44:     	movq	%r12, %r14
180007e47:     	movl	%esi, 0x60(%rsp)
180007e4b:     	cmpq	%rbp, %r12
180007e4e:     	jl	0x180007de1 <numba_list_delete_slice+0x111>
180007e50:     	movq	0x70(%rsp), %r12
180007e55:     	movl	0x20(%rsp), %esi
180007e59:     	movq	(%rbx), %r8
180007e5c:     	movq	0x30(%rsp), %r14
180007e61:     	movslq	%r13d, %r10
180007e64:     	movq	%r10, %rcx
180007e67:     	imulq	%rdi, %rcx
180007e6b:     	addq	%r15, %rcx
180007e6e:     	cmpq	%r8, %rcx
180007e71:     	jge	0x180007e99 <numba_list_delete_slice+0x1c9>
180007e73:     	movq	0x8(%rbx), %rax
180007e77:     	subq	%rcx, %r8
180007e7a:     	movq	%rax, %rdx
180007e7d:     	imulq	%rcx, %rdx
180007e81:     	imulq	%rax, %r8
180007e85:     	subq	%r10, %rcx
180007e88:     	imulq	%rax, %rcx
180007e8c:     	addq	0x30(%rbx), %rdx
180007e90:     	addq	0x30(%rbx), %rcx
180007e94:     	callq	0x180008dd1 <numba_list_iter_next+0xec1>
180007e99:     	movslq	%esi, %rdx
180007e9c:     	movq	%rbx, %rcx
180007e9f:     	callq	0x180007b10 <numba_list_resize>
180007ea4:     	movq	0x68(%rsp), %rsi
180007ea9:     	xorl	%ecx, %ecx
180007eab:     	movq	0x78(%rsp), %r13
180007eb0:     	testl	%eax, %eax
180007eb2:     	cmovsl	%eax, %ecx
180007eb5:     	movl	%ecx, %eax
180007eb7:     	addq	$0x38, %rsp
180007ebb:     	popq	%r15
180007ebd:     	popq	%rdi
180007ebe:     	popq	%rbp
180007ebf:     	popq	%rbx
180007ec0:     	retq
180007ec1:     	movq	0x78(%rsp), %r13
180007ec6:     	xorl	%eax, %eax
180007ec8:     	addq	$0x38, %rsp
180007ecc:     	popq	%r15
180007ece:     	popq	%rdi
180007ecf:     	popq	%rbp
180007ed0:     	popq	%rbx
180007ed1:     	retq
180007ed2:     	int3
180007ed3:     	int3
180007ed4:     	int3
180007ed5:     	int3
180007ed6:     	int3
180007ed7:     	int3
180007ed8:     	int3
180007ed9:     	int3
180007eda:     	int3
180007edb:     	int3
180007edc:     	int3
180007edd:     	int3
180007ede:     	int3
180007edf:     	int3

0000000180007ee0 <numba_list_iter_sizeof>:
180007ee0:     	movl	$0x18, %eax
180007ee5:     	retq
180007ee6:     	int3
180007ee7:     	int3
180007ee8:     	int3
180007ee9:     	int3
180007eea:     	int3
180007eeb:     	int3
180007eec:     	int3
180007eed:     	int3
180007eee:     	int3
180007eef:     	int3

0000000180007ef0 <numba_list_iter>:
180007ef0:     	movq	%rdx, (%rcx)
180007ef3:     	movq	(%rdx), %rax
180007ef6:     	movq	%rax, 0x8(%rcx)
180007efa:     	movq	$0x0, 0x10(%rcx)
180007f02:     	retq
180007f03:     	int3
180007f04:     	int3
180007f05:     	int3
180007f06:     	int3
180007f07:     	int3
180007f08:     	int3
180007f09:     	int3
180007f0a:     	int3
180007f0b:     	int3
180007f0c:     	int3
180007f0d:     	int3
180007f0e:     	int3
180007f0f:     	int3

0000000180007f10 <numba_list_iter_next>:
180007f10:     	movq	(%rcx), %r8
180007f13:     	movq	(%r8), %r9
180007f16:     	cmpq	0x8(%rcx), %r9
180007f1a:     	je	0x180007f22 <numba_list_iter_next+0x12>
180007f1c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
180007f21:     	retq
180007f22:     	movq	0x10(%rcx), %rax
180007f26:     	cmpq	%r9, %rax
180007f29:     	jge	0x180007f3e <numba_list_iter_next+0x2e>
180007f2b:     	imulq	0x8(%r8), %rax
180007f30:     	addq	0x30(%r8), %rax
180007f34:     	movq	%rax, (%rdx)
180007f37:     	incq	0x10(%rcx)
180007f3b:     	xorl	%eax, %eax
180007f3d:     	retq
180007f3e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
180007f43:     	retq
180007f44:     	int3
180007f45:     	int3
180007f46:     	int3
180007f47:     	int3
180007f48:     	int3
180007f49:     	int3
180007f4a:     	int3
180007f4b:     	int3
180007f4c:     	int3
180007f4d:     	int3
180007f4e:     	int3
180007f4f:     	int3
180007f50:     	pushq	%rbx
180007f52:     	subq	$0x20, %rsp
180007f56:     	movq	%rcx, %rbx
180007f59:     	addq	$0x30, %rcx
180007f5d:     	callq	*0x8cc5(%rip)           # 0x180010c28
180007f63:     	cmpb	$0x0, 0x8c96(%rip)      # 0x180010c00
180007f6a:     	je	0x180007f74 <numba_list_iter_next+0x64>
180007f6c:     	lock
180007f6d:     	incq	0x8c94(%rip)            # 0x180010c08
180007f74:     	testq	%rax, %rax
180007f77:     	je	0x180007fb8 <numba_list_iter_next+0xa8>
180007f79:     	leaq	0x30(%rax), %rdx
180007f7d:     	testq	%rdx, %rdx
180007f80:     	je	0x180007fb8 <numba_list_iter_next+0xa8>
180007f82:     	xorl	%r8d, %r8d
180007f85:     	movl	$0x1, %ecx
180007f8a:     	xchgq	%rcx, (%rax)
180007f8d:     	movq	%r8, 0x8(%rax)
180007f91:     	movq	%r8, 0x10(%rax)
180007f95:     	movq	%rdx, 0x18(%rax)
180007f99:     	movq	%rbx, 0x20(%rax)
180007f9d:     	movq	%r8, 0x28(%rax)
180007fa1:     	cmpb	%r8b, 0x8c58(%rip)      # 0x180010c00
180007fa8:     	je	0x180007fba <numba_list_iter_next+0xaa>
180007faa:     	lock
180007fab:     	incq	0x8c66(%rip)            # 0x180010c18
180007fb2:     	addq	$0x20, %rsp
180007fb6:     	popq	%rbx
180007fb7:     	retq
180007fb8:     	xorl	%eax, %eax
180007fba:     	addq	$0x20, %rsp
180007fbe:     	popq	%rbx
180007fbf:     	retq
180007fc0:     	movq	%rbx, 0x8(%rsp)
180007fc5:     	pushq	%rdi
180007fc6:     	subq	$0x20, %rsp
180007fca:     	movq	%rcx, %rdi
180007fcd:     	movq	%rdx, %rbx
180007fd0:     	addq	$0x30, %rcx
180007fd4:     	testq	%rdx, %rdx
180007fd7:     	je	0x180007fe1 <numba_list_iter_next+0xd1>
180007fd9:     	movq	0x18(%rdx), %rdx
180007fdd:     	callq	*(%rbx)
180007fdf:     	jmp	0x180007fe7 <numba_list_iter_next+0xd7>
180007fe1:     	callq	*0x8c41(%rip)           # 0x180010c28
180007fe7:     	cmpb	$0x0, 0x8c12(%rip)      # 0x180010c00
180007fee:     	movq	%rax, %r8
180007ff1:     	je	0x180007ffb <numba_list_iter_next+0xeb>
180007ff3:     	lock
180007ff4:     	incq	0x8c0d(%rip)            # 0x180010c08
180007ffb:     	xorl	%edx, %edx
180007ffd:     	leaq	0x30(%r8), %rax
180008001:     	testq	%r8, %r8
180008004:     	movl	%edx, %ecx
180008006:     	cmovneq	%rax, %rcx
18000800a:     	testq	%rcx, %rcx
18000800d:     	jne	0x18000801c <numba_list_iter_next+0x10c>
18000800f:     	xorl	%eax, %eax
180008011:     	movq	0x30(%rsp), %rbx
180008016:     	addq	$0x20, %rsp
18000801a:     	popq	%rdi
18000801b:     	retq
18000801c:     	movl	$0x1, %eax
180008021:     	xchgq	%rax, (%r8)
180008024:     	movq	%rdx, 0x8(%r8)
180008028:     	movq	%rdx, 0x10(%r8)
18000802c:     	movq	%rcx, 0x18(%r8)
180008030:     	movq	%rdi, 0x20(%r8)
180008034:     	movq	%rbx, 0x28(%r8)
180008038:     	cmpb	%dl, 0x8bc2(%rip)       # 0x180010c00
18000803e:     	je	0x180008048 <numba_list_iter_next+0x138>
180008040:     	lock
180008041:     	incq	0x8bd0(%rip)            # 0x180010c18
180008048:     	movq	0x30(%rsp), %rbx
18000804d:     	movq	%r8, %rax
180008050:     	addq	$0x20, %rsp
180008054:     	popq	%rdi
180008055:     	retq
180008056:     	int3
180008057:     	int3
180008058:     	int3
180008059:     	int3
18000805a:     	int3
18000805b:     	int3
18000805c:     	int3
18000805d:     	int3
18000805e:     	int3
18000805f:     	int3
180008060:     	lock
180008061:     	incq	(%rcx)
180008064:     	retq
180008065:     	int3
180008066:     	int3
180008067:     	int3
180008068:     	int3
180008069:     	int3
18000806a:     	int3
18000806b:     	int3
18000806c:     	int3
18000806d:     	int3
18000806e:     	int3
18000806f:     	int3
180008070:     	pushq	%rbx
180008072:     	subq	$0x20, %rsp
180008076:     	movq	0x8(%rcx), %rax
18000807a:     	movq	%rcx, %rbx
18000807d:     	testq	%rax, %rax
180008080:     	je	0x180008099 <numba_list_iter_next+0x189>
180008082:     	cmpl	$0x0, 0x8b6f(%rip)      # 0x180010bf8
180008089:     	jne	0x180008099 <numba_list_iter_next+0x189>
18000808b:     	movq	0x10(%rcx), %r8
18000808f:     	movq	0x20(%rcx), %rdx
180008093:     	movq	0x18(%rcx), %rcx
180008097:     	callq	*%rax
180008099:     	movq	0x28(%rbx), %rax
18000809d:     	movq	%rbx, %rcx
1800080a0:     	testq	%rax, %rax
1800080a3:     	je	0x1800080ae <numba_list_iter_next+0x19e>
1800080a5:     	movq	0x18(%rax), %rdx
1800080a9:     	callq	*0x10(%rax)
1800080ac:     	jmp	0x1800080b4 <numba_list_iter_next+0x1a4>
1800080ae:     	callq	*0x8b84(%rip)           # 0x180010c38
1800080b4:     	cmpb	$0x0, 0x8b45(%rip)      # 0x180010c00
1800080bb:     	je	0x1800080d9 <numba_list_iter_next+0x1c9>
1800080bd:     	leaq	0x8b4c(%rip), %rax      # 0x180010c10
1800080c4:     	lock
1800080c5:     	incq	(%rax)
1800080c8:     	cmpb	$0x0, 0x8b31(%rip)      # 0x180010c00
1800080cf:     	je	0x1800080d9 <numba_list_iter_next+0x1c9>
1800080d1:     	lock
1800080d2:     	incq	0x8b47(%rip)            # 0x180010c20
1800080d9:     	addq	$0x20, %rsp
1800080dd:     	popq	%rbx
1800080de:     	retq
1800080df:     	int3
1800080e0:     	pushq	%rbx
1800080e2:     	subq	$0x20, %rsp
1800080e6:     	movq	%rcx, %rbx
1800080e9:     	movq	$-0x1, %rax
1800080f0:     	lock
1800080f1:     	xaddq	%rax, (%rcx)
1800080f5:     	cmpq	$0x1, %rax
1800080f9:     	jne	0x18000815b <numba_list_iter_next+0x24b>
1800080fb:     	movq	0x8(%rcx), %rax
1800080ff:     	testq	%rax, %rax
180008102:     	je	0x18000811b <numba_list_iter_next+0x20b>
180008104:     	cmpl	$0x0, 0x8aed(%rip)      # 0x180010bf8
18000810b:     	jne	0x18000811b <numba_list_iter_next+0x20b>
18000810d:     	movq	0x10(%rcx), %r8
180008111:     	movq	0x20(%rcx), %rdx
180008115:     	movq	0x18(%rcx), %rcx
180008119:     	callq	*%rax
18000811b:     	movq	0x28(%rbx), %rax
18000811f:     	movq	%rbx, %rcx
180008122:     	testq	%rax, %rax
180008125:     	je	0x180008130 <numba_list_iter_next+0x220>
180008127:     	movq	0x18(%rax), %rdx
18000812b:     	callq	*0x10(%rax)
18000812e:     	jmp	0x180008136 <numba_list_iter_next+0x226>
180008130:     	callq	*0x8b02(%rip)           # 0x180010c38
180008136:     	cmpb	$0x0, 0x8ac3(%rip)      # 0x180010c00
18000813d:     	je	0x18000815b <numba_list_iter_next+0x24b>
18000813f:     	leaq	0x8aca(%rip), %rax      # 0x180010c10
180008146:     	lock
180008147:     	incq	(%rax)
18000814a:     	cmpb	$0x0, 0x8aaf(%rip)      # 0x180010c00
180008151:     	je	0x18000815b <numba_list_iter_next+0x24b>
180008153:     	lock
180008154:     	incq	0x8ac5(%rip)            # 0x180010c20
18000815b:     	addq	$0x20, %rsp
18000815f:     	popq	%rbx
180008160:     	retq
180008161:     	int3
180008162:     	int3
180008163:     	int3
180008164:     	int3
180008165:     	int3
180008166:     	int3
180008167:     	int3
180008168:     	int3
180008169:     	int3
18000816a:     	int3
18000816b:     	int3
18000816c:     	int3
18000816d:     	int3
18000816e:     	int3
18000816f:     	int3
180008170:     	movq	0x18(%rcx), %rax
180008174:     	retq
180008175:     	int3
180008176:     	int3
180008177:     	int3
180008178:     	int3
180008179:     	int3
18000817a:     	int3
18000817b:     	int3
18000817c:     	int3
18000817d:     	int3
18000817e:     	int3
18000817f:     	int3
180008180:     	subq	$0x28, %rsp
180008184:     	callq	*0x8aae(%rip)           # 0x180010c38
18000818a:     	cmpb	$0x0, 0x8a6f(%rip)      # 0x180010c00
180008191:     	je	0x18000819b <numba_list_iter_next+0x28b>
180008193:     	lock
180008194:     	incq	0x8a75(%rip)            # 0x180010c10
18000819b:     	addq	$0x28, %rsp
18000819f:     	retq
1800081a0:     	jmpq	*%r8
1800081a3:     	int3
1800081a4:     	int3
1800081a5:     	int3
1800081a6:     	int3
1800081a7:     	int3
1800081a8:     	int3
1800081a9:     	int3
1800081aa:     	int3
1800081ab:     	int3
1800081ac:     	int3
1800081ad:     	int3
1800081ae:     	int3
1800081af:     	int3
1800081b0:     	movq	%rbx, 0x8(%rsp)
1800081b5:     	pushq	%rdi
1800081b6:     	subq	$0x20, %rsp
1800081ba:     	movq	%rcx, %rdi
1800081bd:     	movq	%rdx, %rbx
1800081c0:     	movl	$0x30, %ecx
1800081c5:     	callq	*0x8a5d(%rip)           # 0x180010c28
1800081cb:     	cmpb	$0x0, 0x8a2e(%rip)      # 0x180010c00
1800081d2:     	je	0x1800081dc <numba_list_iter_next+0x2cc>
1800081d4:     	lock
1800081d5:     	incq	0x8a2c(%rip)            # 0x180010c08
1800081dc:     	testq	%rax, %rax
1800081df:     	je	0x180008216 <numba_list_iter_next+0x306>
1800081e1:     	leaq	-0x48(%rip), %rcx       # 0x1800081a0 <numba_list_iter_next+0x290>
1800081e8:     	movl	$0x1, %edx
1800081ed:     	xchgq	%rdx, (%rax)
1800081f0:     	movq	%rcx, 0x8(%rax)
1800081f4:     	xorl	%ecx, %ecx
1800081f6:     	movq	%rcx, 0x20(%rax)
1800081fa:     	movq	%rcx, 0x28(%rax)
1800081fe:     	movq	%rbx, 0x10(%rax)
180008202:     	movq	%rdi, 0x18(%rax)
180008206:     	cmpb	%cl, 0x89f4(%rip)       # 0x180010c00
18000820c:     	je	0x180008216 <numba_list_iter_next+0x306>
18000820e:     	lock
18000820f:     	incq	0x8a02(%rip)            # 0x180010c18
180008216:     	movq	0x30(%rsp), %rbx
18000821b:     	addq	$0x20, %rsp
18000821f:     	popq	%rdi
180008220:     	retq
180008221:     	jmpq	*0x10e9(%rip)           # 0x180009310
180008227:     	jmpq	*0x10d3(%rip)           # 0x180009300
18000822d:     	jmpq	*0x10c5(%rip)           # 0x1800092f8
180008233:     	jmpq	*0x10b7(%rip)           # 0x1800092f0
180008239:     	jmpq	*0x10a9(%rip)           # 0x1800092e8
18000823f:     	jmpq	*0x1093(%rip)           # 0x1800092d8
180008245:     	jmpq	*0x1085(%rip)           # 0x1800092d0
18000824b:     	jmpq	*0x1077(%rip)           # 0x1800092c8
180008251:     	jmpq	*0x1061(%rip)           # 0x1800092b8
180008257:     	jmpq	*0x103b(%rip)           # 0x180009298
18000825d:     	jmpq	*0x102d(%rip)           # 0x180009290
180008263:     	jmpq	*0x101f(%rip)           # 0x180009288
180008269:     	jmpq	*0x1011(%rip)           # 0x180009280
18000826f:     	jmpq	*0xfcb(%rip)            # 0x180009240
180008275:     	int3
180008276:     	int3
180008277:     	int3
180008278:     	int3
180008279:     	int3
18000827a:     	int3
18000827b:     	int3
18000827c:     	int3
18000827d:     	int3
18000827e:     	int3
18000827f:     	int3
180008280:     	int3
180008281:     	int3
180008282:     	int3
180008283:     	int3
180008284:     	int3
180008285:     	int3
180008286:     	nopw	(%rax,%rax)
180008290:     	cmpq	0x7e29(%rip), %rcx      # 0x1800100c0
180008297:     	jne	0x1800082a9 <numba_list_iter_next+0x399>
180008299:     	rolq	$0x10, %rcx
18000829d:     	testw	$0xffff, %cx            # imm = 0xFFFF
1800082a2:     	jne	0x1800082a5 <numba_list_iter_next+0x395>
1800082a4:     	retq
1800082a5:     	rorq	$0x10, %rcx
1800082a9:     	jmp	0x180008604 <numba_list_iter_next+0x6f4>
1800082ae:     	int3
1800082af:     	int3
1800082b0:     	subq	$0x28, %rsp
1800082b4:     	testl	%edx, %edx
1800082b6:     	je	0x1800082f1 <numba_list_iter_next+0x3e1>
1800082b8:     	subl	$0x1, %edx
1800082bb:     	je	0x1800082e5 <numba_list_iter_next+0x3d5>
1800082bd:     	subl	$0x1, %edx
1800082c0:     	je	0x1800082d8 <numba_list_iter_next+0x3c8>
1800082c2:     	cmpl	$0x1, %edx
1800082c5:     	je	0x1800082d1 <numba_list_iter_next+0x3c1>
1800082c7:     	movl	$0x1, %eax
1800082cc:     	addq	$0x28, %rsp
1800082d0:     	retq
1800082d1:     	callq	0x1800087d0 <numba_list_iter_next+0x8c0>
1800082d6:     	jmp	0x1800082dd <numba_list_iter_next+0x3cd>
1800082d8:     	callq	0x1800087a8 <numba_list_iter_next+0x898>
1800082dd:     	movzbl	%al, %eax
1800082e0:     	addq	$0x28, %rsp
1800082e4:     	retq
1800082e5:     	movq	%r8, %rdx
1800082e8:     	addq	$0x28, %rsp
1800082ec:     	jmp	0x180008300 <numba_list_iter_next+0x3f0>
1800082f1:     	testq	%r8, %r8
1800082f4:     	setne	%cl
1800082f7:     	addq	$0x28, %rsp
1800082fb:     	jmp	0x180008418 <numba_list_iter_next+0x508>
180008300:     	movq	%rbx, 0x8(%rsp)
180008305:     	movq	%rsi, 0x10(%rsp)
18000830a:     	movq	%rdi, 0x20(%rsp)
18000830f:     	pushq	%r14
180008311:     	subq	$0x20, %rsp
180008315:     	movq	%rdx, %rsi
180008318:     	movq	%rcx, %r14
18000831b:     	xorl	%ecx, %ecx
18000831d:     	callq	0x18000888c <numba_list_iter_next+0x97c>
180008322:     	testb	%al, %al
180008324:     	je	0x1800083f2 <numba_list_iter_next+0x4e2>
18000832a:     	callq	0x180008720 <numba_list_iter_next+0x810>
18000832f:     	movb	%al, %bl
180008331:     	movb	%al, 0x40(%rsp)
180008335:     	movb	$0x1, %dil
180008338:     	cmpl	$0x0, 0x8689(%rip)      # 0x1800109c8
18000833f:     	jne	0x18000840a <numba_list_iter_next+0x4fa>
180008345:     	movl	$0x1, 0x8679(%rip)      # 0x1800109c8
18000834f:     	callq	0x180008790 <numba_list_iter_next+0x880>
180008354:     	testb	%al, %al
180008356:     	je	0x1800083a7 <numba_list_iter_next+0x497>
180008358:     	callq	0x180008a4c <numba_list_iter_next+0xb3c>
18000835d:     	callq	0x1800086e0 <numba_list_iter_next+0x7d0>
180008362:     	callq	0x180008704 <numba_list_iter_next+0x7f4>
180008367:     	leaq	0x1002(%rip), %rdx      # 0x180009370
18000836e:     	leaq	0xff3(%rip), %rcx       # 0x180009368
180008375:     	callq	0x180008d98 <numba_list_iter_next+0xe88>
18000837a:     	testl	%eax, %eax
18000837c:     	jne	0x1800083a7 <numba_list_iter_next+0x497>
18000837e:     	callq	0x18000875c <numba_list_iter_next+0x84c>
180008383:     	testb	%al, %al
180008385:     	je	0x1800083a7 <numba_list_iter_next+0x497>
180008387:     	leaq	0xfd2(%rip), %rdx       # 0x180009360
18000838e:     	leaq	0xfc3(%rip), %rcx       # 0x180009358
180008395:     	callq	0x180008d92 <numba_list_iter_next+0xe82>
18000839a:     	movl	$0x2, 0x8624(%rip)      # 0x1800109c8
1800083a4:     	xorb	%dil, %dil
1800083a7:     	movb	%bl, %cl
1800083a9:     	callq	0x1800089ec <numba_list_iter_next+0xadc>
1800083ae:     	testb	%dil, %dil
1800083b1:     	jne	0x1800083f2 <numba_list_iter_next+0x4e2>
1800083b3:     	callq	0x180008a3c <numba_list_iter_next+0xb2c>
1800083b8:     	movq	%rax, %rbx
1800083bb:     	cmpq	$0x0, (%rax)
1800083bf:     	je	0x1800083e5 <numba_list_iter_next+0x4d5>
1800083c1:     	movq	%rax, %rcx
1800083c4:     	callq	0x180008954 <numba_list_iter_next+0xa44>
1800083c9:     	testb	%al, %al
1800083cb:     	je	0x1800083e5 <numba_list_iter_next+0x4d5>
1800083cd:     	movq	%rsi, %r8
1800083d0:     	movl	$0x2, %edx
1800083d5:     	movq	%r14, %rcx
1800083d8:     	movq	(%rbx), %rax
1800083db:     	movq	0xf4e(%rip), %r9        # 0x180009330
1800083e2:     	callq	*%r9
1800083e5:     	incl	0x85b5(%rip)            # 0x1800109a0
1800083eb:     	movl	$0x1, %eax
1800083f0:     	jmp	0x1800083f4 <numba_list_iter_next+0x4e4>
1800083f2:     	xorl	%eax, %eax
1800083f4:     	movq	0x30(%rsp), %rbx
1800083f9:     	movq	0x38(%rsp), %rsi
1800083fe:     	movq	0x48(%rsp), %rdi
180008403:     	addq	$0x20, %rsp
180008407:     	popq	%r14
180008409:     	retq
18000840a:     	movl	$0x7, %ecx
18000840f:     	callq	0x180008a44 <numba_list_iter_next+0xb34>
180008414:     	nop
180008415:     	int3
180008416:     	int3
180008417:     	int3
180008418:     	movq	%rbx, 0x8(%rsp)
18000841d:     	pushq	%rdi
18000841e:     	subq	$0x30, %rsp
180008422:     	movb	%cl, %dil
180008425:     	movl	0x8575(%rip), %eax      # 0x1800109a0
18000842b:     	testl	%eax, %eax
18000842d:     	jg	0x18000843c <numba_list_iter_next+0x52c>
18000842f:     	xorl	%eax, %eax
180008431:     	movq	0x40(%rsp), %rbx
180008436:     	addq	$0x30, %rsp
18000843a:     	popq	%rdi
18000843b:     	retq
18000843c:     	decl	%eax
18000843e:     	movl	%eax, 0x855c(%rip)      # 0x1800109a0
180008444:     	callq	0x180008720 <numba_list_iter_next+0x810>
180008449:     	movb	%al, %bl
18000844b:     	movb	%al, 0x20(%rsp)
18000844f:     	cmpl	$0x2, 0x8572(%rip)      # 0x1800109c8
180008456:     	jne	0x18000848e <numba_list_iter_next+0x57e>
180008458:     	callq	0x180008848 <numba_list_iter_next+0x938>
18000845d:     	callq	0x1800086f0 <numba_list_iter_next+0x7e0>
180008462:     	callq	0x180008a88 <numba_list_iter_next+0xb78>
180008467:     	movl	$0x0, 0x8557(%rip)      # 0x1800109c8
180008471:     	movb	%bl, %cl
180008473:     	callq	0x1800089ec <numba_list_iter_next+0xadc>
180008478:     	xorl	%edx, %edx
18000847a:     	movb	%dil, %cl
18000847d:     	callq	0x180008a10 <numba_list_iter_next+0xb00>
180008482:     	movzbl	%al, %ebx
180008485:     	callq	0x180008878 <numba_list_iter_next+0x968>
18000848a:     	movl	%ebx, %eax
18000848c:     	jmp	0x180008431 <numba_list_iter_next+0x521>
18000848e:     	movl	$0x7, %ecx
180008493:     	callq	0x180008a44 <numba_list_iter_next+0xb34>
180008498:     	nop
180008499:     	nop
18000849a:     	int3
18000849b:     	int3
18000849c:     	movq	%rsp, %rax
18000849f:     	movq	%rbx, 0x20(%rax)
1800084a3:     	movq	%r8, 0x18(%rax)
1800084a7:     	movl	%edx, 0x10(%rax)
1800084aa:     	movq	%rcx, 0x8(%rax)
1800084ae:     	pushq	%rsi
1800084af:     	pushq	%rdi
1800084b0:     	pushq	%r14
1800084b2:     	subq	$0x40, %rsp
1800084b6:     	movq	%r8, %rsi
1800084b9:     	movl	%edx, %edi
1800084bb:     	movq	%rcx, %r14
1800084be:     	testl	%edx, %edx
1800084c0:     	jne	0x1800084d1 <numba_list_iter_next+0x5c1>
1800084c2:     	cmpl	%edx, 0x84d8(%rip)      # 0x1800109a0
1800084c8:     	jg	0x1800084d1 <numba_list_iter_next+0x5c1>
1800084ca:     	xorl	%eax, %eax
1800084cc:     	jmp	0x1800085b6 <numba_list_iter_next+0x6a6>
1800084d1:     	leal	-0x1(%rdx), %eax
1800084d4:     	cmpl	$0x1, %eax
1800084d7:     	ja	0x180008519 <numba_list_iter_next+0x609>
1800084d9:     	movq	0x14a8(%rip), %rax      # 0x180009988
1800084e0:     	testq	%rax, %rax
1800084e3:     	jne	0x1800084ea <numba_list_iter_next+0x5da>
1800084e5:     	leal	0x1(%rax), %ebx
1800084e8:     	jmp	0x1800084f2 <numba_list_iter_next+0x5e2>
1800084ea:     	callq	*0xe40(%rip)            # 0x180009330
1800084f0:     	movl	%eax, %ebx
1800084f2:     	movl	%ebx, 0x30(%rsp)
1800084f6:     	testl	%ebx, %ebx
1800084f8:     	je	0x1800085ac <numba_list_iter_next+0x69c>
1800084fe:     	movq	%rsi, %r8
180008501:     	movl	%edi, %edx
180008503:     	movq	%r14, %rcx
180008506:     	callq	0x1800082b0 <numba_list_iter_next+0x3a0>
18000850b:     	movl	%eax, %ebx
18000850d:     	movl	%eax, 0x30(%rsp)
180008511:     	testl	%eax, %eax
180008513:     	je	0x1800085ac <numba_list_iter_next+0x69c>
180008519:     	movq	%rsi, %r8
18000851c:     	movl	%edi, %edx
18000851e:     	movq	%r14, %rcx
180008521:     	callq	0x1800086bc <numba_list_iter_next+0x7ac>
180008526:     	movl	%eax, %ebx
180008528:     	movl	%eax, 0x30(%rsp)
18000852c:     	cmpl	$0x1, %edi
18000852f:     	jne	0x180008567 <numba_list_iter_next+0x657>
180008531:     	testl	%eax, %eax
180008533:     	jne	0x180008567 <numba_list_iter_next+0x657>
180008535:     	movq	%rsi, %r8
180008538:     	xorl	%edx, %edx
18000853a:     	movq	%r14, %rcx
18000853d:     	callq	0x1800086bc <numba_list_iter_next+0x7ac>
180008542:     	testq	%rsi, %rsi
180008545:     	setne	%cl
180008548:     	callq	0x180008418 <numba_list_iter_next+0x508>
18000854d:     	movq	0x1434(%rip), %rax      # 0x180009988
180008554:     	testq	%rax, %rax
180008557:     	je	0x180008567 <numba_list_iter_next+0x657>
180008559:     	movq	%rsi, %r8
18000855c:     	xorl	%edx, %edx
18000855e:     	movq	%r14, %rcx
180008561:     	callq	*0xdc9(%rip)            # 0x180009330
180008567:     	testl	%edi, %edi
180008569:     	je	0x180008570 <numba_list_iter_next+0x660>
18000856b:     	cmpl	$0x3, %edi
18000856e:     	jne	0x1800085ac <numba_list_iter_next+0x69c>
180008570:     	movq	%rsi, %r8
180008573:     	movl	%edi, %edx
180008575:     	movq	%r14, %rcx
180008578:     	callq	0x1800082b0 <numba_list_iter_next+0x3a0>
18000857d:     	movl	%eax, %ebx
18000857f:     	movl	%eax, 0x30(%rsp)
180008583:     	testl	%eax, %eax
180008585:     	je	0x1800085ac <numba_list_iter_next+0x69c>
180008587:     	movq	0x13fa(%rip), %rax      # 0x180009988
18000858e:     	testq	%rax, %rax
180008591:     	jne	0x180008598 <numba_list_iter_next+0x688>
180008593:     	leal	0x1(%rax), %ebx
180008596:     	jmp	0x1800085a8 <numba_list_iter_next+0x698>
180008598:     	movq	%rsi, %r8
18000859b:     	movl	%edi, %edx
18000859d:     	movq	%r14, %rcx
1800085a0:     	callq	*0xd8a(%rip)            # 0x180009330
1800085a6:     	movl	%eax, %ebx
1800085a8:     	movl	%ebx, 0x30(%rsp)
1800085ac:     	jmp	0x1800085b4 <numba_list_iter_next+0x6a4>
1800085ae:     	xorl	%ebx, %ebx
1800085b0:     	movl	%ebx, 0x30(%rsp)
1800085b4:     	movl	%ebx, %eax
1800085b6:     	movq	0x78(%rsp), %rbx
1800085bb:     	addq	$0x40, %rsp
1800085bf:     	popq	%r14
1800085c1:     	popq	%rdi
1800085c2:     	popq	%rsi
1800085c3:     	retq
1800085c4:     	movq	%rbx, 0x8(%rsp)
1800085c9:     	movq	%rsi, 0x10(%rsp)
1800085ce:     	pushq	%rdi
1800085cf:     	subq	$0x20, %rsp
1800085d3:     	movq	%r8, %rdi
1800085d6:     	movl	%edx, %ebx
1800085d8:     	movq	%rcx, %rsi
1800085db:     	cmpl	$0x1, %edx
1800085de:     	jne	0x1800085e5 <numba_list_iter_next+0x6d5>
1800085e0:     	callq	0x18000860c <numba_list_iter_next+0x6fc>
1800085e5:     	movq	%rdi, %r8
1800085e8:     	movl	%ebx, %edx
1800085ea:     	movq	%rsi, %rcx
1800085ed:     	movq	0x30(%rsp), %rbx
1800085f2:     	movq	0x38(%rsp), %rsi
1800085f7:     	addq	$0x20, %rsp
1800085fb:     	popq	%rdi
1800085fc:     	jmp	0x18000849c <numba_list_iter_next+0x58c>
180008601:     	int3
180008602:     	int3
180008603:     	int3
180008604:     	movl	$0x2, %ecx
180008609:     	int	$0x29
18000860b:     	retq
18000860c:     	movq	%rbx, 0x18(%rsp)
180008611:     	pushq	%rbp
180008612:     	movq	%rsp, %rbp
180008615:     	subq	$0x30, %rsp
180008619:     	movq	0x7aa0(%rip), %rax      # 0x1800100c0
180008620:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000862a:     	cmpq	%rbx, %rax
18000862d:     	jne	0x1800086a6 <numba_list_iter_next+0x796>
18000862f:     	leaq	0x10(%rbp), %rcx
180008633:     	movq	$0x0, 0x10(%rbp)
18000863b:     	callq	*0x9e7(%rip)            # 0x180009028
180008641:     	movq	0x10(%rbp), %rax
180008645:     	movq	%rax, -0x10(%rbp)
180008649:     	callq	*0x9c1(%rip)            # 0x180009010
18000864f:     	movl	%eax, %eax
180008651:     	xorq	%rax, -0x10(%rbp)
180008655:     	callq	*0x9ad(%rip)            # 0x180009008
18000865b:     	movl	%eax, %eax
18000865d:     	leaq	0x18(%rbp), %rcx
180008661:     	xorq	%rax, -0x10(%rbp)
180008665:     	callq	*0x995(%rip)            # 0x180009000
18000866b:     	movl	0x18(%rbp), %eax
18000866e:     	leaq	-0x10(%rbp), %rcx
180008672:     	shlq	$0x20, %rax
180008676:     	xorq	0x18(%rbp), %rax
18000867a:     	xorq	-0x10(%rbp), %rax
18000867e:     	xorq	%rcx, %rax
180008681:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000868b:     	andq	%rcx, %rax
18000868e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
180008698:     	cmpq	%rbx, %rax
18000869b:     	cmoveq	%rcx, %rax
18000869f:     	movq	%rax, 0x7a1a(%rip)      # 0x1800100c0
1800086a6:     	movq	0x50(%rsp), %rbx
1800086ab:     	notq	%rax
1800086ae:     	movq	%rax, 0x7a4b(%rip)      # 0x180010100
1800086b5:     	addq	$0x30, %rsp
1800086b9:     	popq	%rbp
1800086ba:     	retq
1800086bb:     	int3
1800086bc:     	subq	$0x28, %rsp
1800086c0:     	cmpl	$0x1, %edx
1800086c3:     	jne	0x1800086d5 <numba_list_iter_next+0x7c5>
1800086c5:     	cmpq	$0x0, 0x12bb(%rip)      # 0x180009988
1800086cd:     	jne	0x1800086d5 <numba_list_iter_next+0x7c5>
1800086cf:     	callq	*0x94b(%rip)            # 0x180009020
1800086d5:     	movl	$0x1, %eax
1800086da:     	addq	$0x28, %rsp
1800086de:     	retq
1800086df:     	int3
1800086e0:     	leaq	0x82c9(%rip), %rcx      # 0x1800109b0
1800086e7:     	jmpq	*0x92a(%rip)            # 0x180009018
1800086ee:     	int3
1800086ef:     	int3
1800086f0:     	leaq	0x82b9(%rip), %rcx      # 0x1800109b0
1800086f7:     	jmp	0x180008d86 <numba_list_iter_next+0xe76>
1800086fc:     	leaq	0x82bd(%rip), %rax      # 0x1800109c0
180008703:     	retq
180008704:     	subq	$0x28, %rsp
180008708:     	callq	0x180007820 <PyInit_rcaotr_bee84dfb472143a382ca4af1+0x5eb0>
18000870d:     	orq	$0x24, (%rax)
180008711:     	callq	0x1800086fc <numba_list_iter_next+0x7ec>
180008716:     	orq	$0x2, (%rax)
18000871a:     	addq	$0x28, %rsp
18000871e:     	retq
18000871f:     	int3
180008720:     	subq	$0x28, %rsp
180008724:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
180008729:     	testl	%eax, %eax
18000872b:     	je	0x18000874e <numba_list_iter_next+0x83e>
18000872d:     	movq	%gs:0x30, %rax
180008736:     	movq	0x8(%rax), %rcx
18000873a:     	jmp	0x180008741 <numba_list_iter_next+0x831>
18000873c:     	cmpq	%rax, %rcx
18000873f:     	je	0x180008755 <numba_list_iter_next+0x845>
180008741:     	xorl	%eax, %eax
180008743:     	lock
180008744:     	cmpxchgq	%rcx, 0x8284(%rip)      # 0x1800109d0
18000874c:     	jne	0x18000873c <numba_list_iter_next+0x82c>
18000874e:     	xorb	%al, %al
180008750:     	addq	$0x28, %rsp
180008754:     	retq
180008755:     	movb	$0x1, %al
180008757:     	jmp	0x180008750 <numba_list_iter_next+0x840>
180008759:     	int3
18000875a:     	int3
18000875b:     	int3
18000875c:     	subq	$0x28, %rsp
180008760:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
180008765:     	testl	%eax, %eax
180008767:     	je	0x180008770 <numba_list_iter_next+0x860>
180008769:     	callq	0x180008ac8 <numba_list_iter_next+0xbb8>
18000876e:     	jmp	0x180008789 <numba_list_iter_next+0x879>
180008770:     	callq	0x180008d64 <numba_list_iter_next+0xe54>
180008775:     	movl	%eax, %ecx
180008777:     	callq	0x180008da4 <numba_list_iter_next+0xe94>
18000877c:     	testl	%eax, %eax
18000877e:     	je	0x180008784 <numba_list_iter_next+0x874>
180008780:     	xorb	%al, %al
180008782:     	jmp	0x18000878b <numba_list_iter_next+0x87b>
180008784:     	callq	0x180008daa <numba_list_iter_next+0xe9a>
180008789:     	movb	$0x1, %al
18000878b:     	addq	$0x28, %rsp
18000878f:     	retq
180008790:     	subq	$0x28, %rsp
180008794:     	xorl	%ecx, %ecx
180008796:     	callq	0x1800088c8 <numba_list_iter_next+0x9b8>
18000879b:     	testb	%al, %al
18000879d:     	setne	%al
1800087a0:     	addq	$0x28, %rsp
1800087a4:     	retq
1800087a5:     	int3
1800087a6:     	int3
1800087a7:     	int3
1800087a8:     	subq	$0x28, %rsp
1800087ac:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800087b1:     	testb	%al, %al
1800087b3:     	jne	0x1800087b9 <numba_list_iter_next+0x8a9>
1800087b5:     	xorb	%al, %al
1800087b7:     	jmp	0x1800087cb <numba_list_iter_next+0x8bb>
1800087b9:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800087be:     	testb	%al, %al
1800087c0:     	jne	0x1800087c9 <numba_list_iter_next+0x8b9>
1800087c2:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800087c7:     	jmp	0x1800087b5 <numba_list_iter_next+0x8a5>
1800087c9:     	movb	$0x1, %al
1800087cb:     	addq	$0x28, %rsp
1800087cf:     	retq
1800087d0:     	subq	$0x28, %rsp
1800087d4:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800087d9:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800087de:     	movb	$0x1, %al
1800087e0:     	addq	$0x28, %rsp
1800087e4:     	retq
1800087e5:     	int3
1800087e6:     	int3
1800087e7:     	int3
1800087e8:     	movq	%rbx, 0x8(%rsp)
1800087ed:     	movq	%rbp, 0x10(%rsp)
1800087f2:     	movq	%rsi, 0x18(%rsp)
1800087f7:     	pushq	%rdi
1800087f8:     	subq	$0x20, %rsp
1800087fc:     	movq	%r9, %rdi
1800087ff:     	movq	%r8, %rsi
180008802:     	movl	%edx, %ebx
180008804:     	movq	%rcx, %rbp
180008807:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
18000880c:     	testl	%eax, %eax
18000880e:     	jne	0x180008826 <numba_list_iter_next+0x916>
180008810:     	cmpl	$0x1, %ebx
180008813:     	jne	0x180008826 <numba_list_iter_next+0x916>
180008815:     	movq	%rsi, %r8
180008818:     	xorl	%edx, %edx
18000881a:     	movq	%rbp, %rcx
18000881d:     	movq	%rdi, %rax
180008820:     	callq	*0xb0a(%rip)            # 0x180009330
180008826:     	movq	0x58(%rsp), %rdx
18000882b:     	movl	0x50(%rsp), %ecx
18000882f:     	movq	0x30(%rsp), %rbx
180008834:     	movq	0x38(%rsp), %rbp
180008839:     	movq	0x40(%rsp), %rsi
18000883e:     	addq	$0x20, %rsp
180008842:     	popq	%rdi
180008843:     	jmp	0x180008d9e <numba_list_iter_next+0xe8e>
180008848:     	subq	$0x28, %rsp
18000884c:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
180008851:     	testl	%eax, %eax
180008853:     	je	0x180008865 <numba_list_iter_next+0x955>
180008855:     	leaq	0x8184(%rip), %rcx      # 0x1800109e0
18000885c:     	addq	$0x28, %rsp
180008860:     	jmp	0x180008db6 <numba_list_iter_next+0xea6>
180008865:     	callq	0x180008dc8 <numba_list_iter_next+0xeb8>
18000886a:     	testl	%eax, %eax
18000886c:     	jne	0x180008873 <numba_list_iter_next+0x963>
18000886e:     	callq	0x180008dbc <numba_list_iter_next+0xeac>
180008873:     	addq	$0x28, %rsp
180008877:     	retq
180008878:     	subq	$0x28, %rsp
18000887c:     	xorl	%ecx, %ecx
18000887e:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
180008883:     	addq	$0x28, %rsp
180008887:     	jmp	0x180008dc4 <numba_list_iter_next+0xeb4>
18000888c:     	subq	$0x28, %rsp
180008890:     	testl	%ecx, %ecx
180008892:     	jne	0x18000889b <numba_list_iter_next+0x98b>
180008894:     	movb	$0x1, 0x813d(%rip)      # 0x1800109d8
18000889b:     	callq	0x180008ac8 <numba_list_iter_next+0xbb8>
1800088a0:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800088a5:     	testb	%al, %al
1800088a7:     	jne	0x1800088ad <numba_list_iter_next+0x99d>
1800088a9:     	xorb	%al, %al
1800088ab:     	jmp	0x1800088c1 <numba_list_iter_next+0x9b1>
1800088ad:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800088b2:     	testb	%al, %al
1800088b4:     	jne	0x1800088bf <numba_list_iter_next+0x9af>
1800088b6:     	xorl	%ecx, %ecx
1800088b8:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
1800088bd:     	jmp	0x1800088a9 <numba_list_iter_next+0x999>
1800088bf:     	movb	$0x1, %al
1800088c1:     	addq	$0x28, %rsp
1800088c5:     	retq
1800088c6:     	int3
1800088c7:     	int3
1800088c8:     	pushq	%rbx
1800088ca:     	subq	$0x20, %rsp
1800088ce:     	cmpb	$0x0, 0x8104(%rip)      # 0x1800109d9
1800088d5:     	movl	%ecx, %ebx
1800088d7:     	jne	0x180008940 <numba_list_iter_next+0xa30>
1800088d9:     	cmpl	$0x1, %ecx
1800088dc:     	ja	0x180008948 <numba_list_iter_next+0xa38>
1800088de:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
1800088e3:     	testl	%eax, %eax
1800088e5:     	je	0x18000890f <numba_list_iter_next+0x9ff>
1800088e7:     	testl	%ebx, %ebx
1800088e9:     	jne	0x18000890f <numba_list_iter_next+0x9ff>
1800088eb:     	leaq	0x80ee(%rip), %rcx      # 0x1800109e0
1800088f2:     	callq	0x180008db0 <numba_list_iter_next+0xea0>
1800088f7:     	testl	%eax, %eax
1800088f9:     	jne	0x18000890b <numba_list_iter_next+0x9fb>
1800088fb:     	leaq	0x80f6(%rip), %rcx      # 0x1800109f8
180008902:     	callq	0x180008db0 <numba_list_iter_next+0xea0>
180008907:     	testl	%eax, %eax
180008909:     	je	0x180008939 <numba_list_iter_next+0xa29>
18000890b:     	xorb	%al, %al
18000890d:     	jmp	0x180008942 <numba_list_iter_next+0xa32>
18000890f:     	movdqa	0x1079(%rip), %xmm0     # 0x180009990
180008917:     	orq	$-0x1, %rax
18000891b:     	movdqu	%xmm0, 0x80bd(%rip)     # 0x1800109e0
180008923:     	movq	%rax, 0x80c6(%rip)      # 0x1800109f0
18000892a:     	movdqu	%xmm0, 0x80c6(%rip)     # 0x1800109f8
180008932:     	movq	%rax, 0x80cf(%rip)      # 0x180010a08
180008939:     	movb	$0x1, 0x8099(%rip)      # 0x1800109d9
180008940:     	movb	$0x1, %al
180008942:     	addq	$0x20, %rsp
180008946:     	popq	%rbx
180008947:     	retq
180008948:     	movl	$0x5, %ecx
18000894d:     	callq	0x180008a44 <numba_list_iter_next+0xb34>
180008952:     	int3
180008953:     	int3
180008954:     	subq	$0x18, %rsp
180008958:     	movq	%rcx, %r8
18000895b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
180008960:     	cmpw	%ax, -0x8967(%rip)      # 0x180000000
180008967:     	jne	0x1800089e1 <numba_list_iter_next+0xad1>
180008969:     	movslq	-0x8934(%rip), %rcx     # 0x18000003c
180008970:     	leaq	-0x8977(%rip), %rdx     # 0x180000000
180008977:     	addq	%rdx, %rcx
18000897a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
180008980:     	jne	0x1800089e1 <numba_list_iter_next+0xad1>
180008982:     	movl	$0x20b, %eax            # imm = 0x20B
180008987:     	cmpw	%ax, 0x18(%rcx)
18000898b:     	jne	0x1800089e1 <numba_list_iter_next+0xad1>
18000898d:     	subq	%rdx, %r8
180008990:     	movzwl	0x14(%rcx), %edx
180008994:     	addq	$0x18, %rdx
180008998:     	addq	%rcx, %rdx
18000899b:     	movzwl	0x6(%rcx), %eax
18000899f:     	leaq	(%rax,%rax,4), %rcx
1800089a3:     	leaq	(%rdx,%rcx,8), %r9
1800089a7:     	movq	%rdx, (%rsp)
1800089ab:     	cmpq	%r9, %rdx
1800089ae:     	je	0x1800089c8 <numba_list_iter_next+0xab8>
1800089b0:     	movl	0xc(%rdx), %ecx
1800089b3:     	cmpq	%rcx, %r8
1800089b6:     	jb	0x1800089c2 <numba_list_iter_next+0xab2>
1800089b8:     	movl	0x8(%rdx), %eax
1800089bb:     	addl	%ecx, %eax
1800089bd:     	cmpq	%rax, %r8
1800089c0:     	jb	0x1800089ca <numba_list_iter_next+0xaba>
1800089c2:     	addq	$0x28, %rdx
1800089c6:     	jmp	0x1800089a7 <numba_list_iter_next+0xa97>
1800089c8:     	xorl	%edx, %edx
1800089ca:     	testq	%rdx, %rdx
1800089cd:     	jne	0x1800089d3 <numba_list_iter_next+0xac3>
1800089cf:     	xorb	%al, %al
1800089d1:     	jmp	0x1800089e7 <numba_list_iter_next+0xad7>
1800089d3:     	cmpl	$0x0, 0x24(%rdx)
1800089d7:     	jge	0x1800089dd <numba_list_iter_next+0xacd>
1800089d9:     	xorb	%al, %al
1800089db:     	jmp	0x1800089e7 <numba_list_iter_next+0xad7>
1800089dd:     	movb	$0x1, %al
1800089df:     	jmp	0x1800089e7 <numba_list_iter_next+0xad7>
1800089e1:     	xorb	%al, %al
1800089e3:     	jmp	0x1800089e7 <numba_list_iter_next+0xad7>
1800089e5:     	xorb	%al, %al
1800089e7:     	addq	$0x18, %rsp
1800089eb:     	retq
1800089ec:     	pushq	%rbx
1800089ee:     	subq	$0x20, %rsp
1800089f2:     	movb	%cl, %bl
1800089f4:     	callq	0x180008d6c <numba_list_iter_next+0xe5c>
1800089f9:     	xorl	%edx, %edx
1800089fb:     	testl	%eax, %eax
1800089fd:     	je	0x180008a0a <numba_list_iter_next+0xafa>
1800089ff:     	testb	%bl, %bl
180008a01:     	jne	0x180008a0a <numba_list_iter_next+0xafa>
180008a03:     	xchgq	%rdx, 0x7fc6(%rip)      # 0x1800109d0
180008a0a:     	addq	$0x20, %rsp
180008a0e:     	popq	%rbx
180008a0f:     	retq
180008a10:     	pushq	%rbx
180008a12:     	subq	$0x20, %rsp
180008a16:     	cmpb	$0x0, 0x7fbb(%rip)      # 0x1800109d8
180008a1d:     	movb	%cl, %bl
180008a1f:     	je	0x180008a25 <numba_list_iter_next+0xb15>
180008a21:     	testb	%dl, %dl
180008a23:     	jne	0x180008a31 <numba_list_iter_next+0xb21>
180008a25:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
180008a2a:     	movb	%bl, %cl
180008a2c:     	callq	0x180008dc4 <numba_list_iter_next+0xeb4>
180008a31:     	movb	$0x1, %al
180008a33:     	addq	$0x20, %rsp
180008a37:     	popq	%rbx
180008a38:     	retq
180008a39:     	int3
180008a3a:     	int3
180008a3b:     	int3
180008a3c:     	leaq	0x8255(%rip), %rax      # 0x180010c98
180008a43:     	retq
180008a44:     	movl	%ecx, %ecx
180008a46:     	int	$0x29
180008a48:     	retq
180008a49:     	int3
180008a4a:     	int3
180008a4b:     	int3
180008a4c:     	movq	%rbx, 0x8(%rsp)
180008a51:     	pushq	%rdi
180008a52:     	subq	$0x20, %rsp
180008a56:     	leaq	0x396b(%rip), %rbx      # 0x18000c3c8
180008a5d:     	leaq	0x3964(%rip), %rdi      # 0x18000c3c8
180008a64:     	jmp	0x180008a78 <numba_list_iter_next+0xb68>
180008a66:     	movq	(%rbx), %rax
180008a69:     	testq	%rax, %rax
180008a6c:     	je	0x180008a74 <numba_list_iter_next+0xb64>
180008a6e:     	callq	*0x8bc(%rip)            # 0x180009330
180008a74:     	addq	$0x8, %rbx
180008a78:     	cmpq	%rdi, %rbx
180008a7b:     	jb	0x180008a66 <numba_list_iter_next+0xb56>
180008a7d:     	movq	0x30(%rsp), %rbx
180008a82:     	addq	$0x20, %rsp
180008a86:     	popq	%rdi
180008a87:     	retq
180008a88:     	movq	%rbx, 0x8(%rsp)
180008a8d:     	pushq	%rdi
180008a8e:     	subq	$0x20, %rsp
180008a92:     	leaq	0x393f(%rip), %rbx      # 0x18000c3d8
180008a99:     	leaq	0x3938(%rip), %rdi      # 0x18000c3d8
180008aa0:     	jmp	0x180008ab4 <numba_list_iter_next+0xba4>
180008aa2:     	movq	(%rbx), %rax
180008aa5:     	testq	%rax, %rax
180008aa8:     	je	0x180008ab0 <numba_list_iter_next+0xba0>
180008aaa:     	callq	*0x880(%rip)            # 0x180009330
180008ab0:     	addq	$0x8, %rbx
180008ab4:     	cmpq	%rdi, %rbx
180008ab7:     	jb	0x180008aa2 <numba_list_iter_next+0xb92>
180008ab9:     	movq	0x30(%rsp), %rbx
180008abe:     	addq	$0x20, %rsp
180008ac2:     	popq	%rdi
180008ac3:     	retq
180008ac4:     	retq	$0x0
180008ac7:     	int3
180008ac8:     	movq	%rbx, 0x10(%rsp)
180008acd:     	movq	%rbp, 0x18(%rsp)
180008ad2:     	movq	%rsi, 0x20(%rsp)
180008ad7:     	pushq	%rdi
180008ad8:     	subq	$0x10, %rsp
180008adc:     	xorl	%eax, %eax
180008ade:     	xorl	%ecx, %ecx
180008ae0:     	cpuid
180008ae2:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
180008ae8:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
180008aee:     	orl	%ecx, %edx
180008af0:     	movl	%eax, %ebp
180008af2:     	movl	$0x1, %eax
180008af7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
180008afd:     	orl	%ebx, %edx
180008aff:     	leal	-0x1(%rax), %ecx
180008b02:     	cpuid
180008b04:     	movl	%ecx, %edi
180008b06:     	jne	0x180008b66 <numba_list_iter_next+0xc56>
180008b08:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
180008b0d:     	movq	$0x8000, 0x7600(%rip)   # imm = 0x8000
                                                # 0x180010118
180008b18:     	movq	$-0x1, 0x75fd(%rip)     # 0x180010120
180008b23:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
180008b28:     	je	0x180008b52 <numba_list_iter_next+0xc42>
180008b2a:     	cmpl	$0x20660, %eax          # imm = 0x20660
180008b2f:     	je	0x180008b52 <numba_list_iter_next+0xc42>
180008b31:     	cmpl	$0x20670, %eax          # imm = 0x20670
180008b36:     	je	0x180008b52 <numba_list_iter_next+0xc42>
180008b38:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
180008b3d:     	cmpl	$0x20, %eax
180008b40:     	ja	0x180008b66 <numba_list_iter_next+0xc56>
180008b42:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
180008b4c:     	btq	%rax, %rcx
180008b50:     	jae	0x180008b66 <numba_list_iter_next+0xc56>
180008b52:     	movl	0x7ebb(%rip), %r8d      # 0x180010a14
180008b59:     	orl	$0x1, %r8d
180008b5d:     	movl	%r8d, 0x7eb0(%rip)      # 0x180010a14
180008b64:     	jmp	0x180008b6d <numba_list_iter_next+0xc5d>
180008b66:     	movl	0x7ea7(%rip), %r8d      # 0x180010a14
180008b6d:     	xorl	%r9d, %r9d
180008b70:     	movl	%r9d, %r11d
180008b73:     	cmpl	$0x7, %ebp
180008b76:     	jl	0x180008bba <numba_list_iter_next+0xcaa>
180008b78:     	xorl	%ecx, %ecx
180008b7a:     	leal	0x7(%r9), %eax
180008b7e:     	cpuid
180008b80:     	movl	%edx, %esi
180008b82:     	movl	%ebx, %r10d
180008b85:     	btl	$0x9, %ebx
180008b89:     	jae	0x180008b96 <numba_list_iter_next+0xc86>
180008b8b:     	orl	$0x2, %r8d
180008b8f:     	movl	%r8d, 0x7e7e(%rip)      # 0x180010a14
180008b96:     	cmpl	$0x1, %eax
180008b99:     	jl	0x180008ba8 <numba_list_iter_next+0xc98>
180008b9b:     	movl	$0x7, %eax
180008ba0:     	leal	-0x6(%rax), %ecx
180008ba3:     	cpuid
180008ba5:     	movl	%edx, %r9d
180008ba8:     	movl	$0x24, %eax
180008bad:     	cmpl	%eax, %ebp
180008baf:     	jl	0x180008bc0 <numba_list_iter_next+0xcb0>
180008bb1:     	xorl	%ecx, %ecx
180008bb3:     	cpuid
180008bb5:     	movl	%ebx, %r11d
180008bb8:     	jmp	0x180008bc0 <numba_list_iter_next+0xcb0>
180008bba:     	movl	%r9d, %r10d
180008bbd:     	movl	%r9d, %esi
180008bc0:     	movq	0x7561(%rip), %rax      # 0x180010128
180008bc7:     	andq	$-0x2, %rax
180008bcb:     	movl	$0x1, 0x753b(%rip)      # 0x180010110
180008bd5:     	movl	$0x2, 0x7535(%rip)      # 0x180010114
180008bdf:     	movq	%rax, 0x7542(%rip)      # 0x180010128
180008be6:     	btl	$0x14, %edi
180008bea:     	jae	0x180008c0b <numba_list_iter_next+0xcfb>
180008bec:     	andq	$-0x11, %rax
180008bf0:     	movl	$0x2, 0x7516(%rip)      # 0x180010110
180008bfa:     	movq	%rax, 0x7527(%rip)      # 0x180010128
180008c01:     	movl	$0x6, 0x7509(%rip)      # 0x180010114
180008c0b:     	btl	$0x1b, %edi
180008c0f:     	jae	0x180008d4c <numba_list_iter_next+0xe3c>
180008c15:     	xorl	%ecx, %ecx
180008c17:     	xgetbv
180008c1a:     	shlq	$0x20, %rdx
180008c1e:     	orq	%rax, %rdx
180008c21:     	movq	%rdx, 0x20(%rsp)
180008c26:     	btl	$0x1c, %edi
180008c2a:     	jae	0x180008d30 <numba_list_iter_next+0xe20>
180008c30:     	movq	0x20(%rsp), %rax
180008c35:     	andb	$0x6, %al
180008c37:     	cmpb	$0x6, %al
180008c39:     	jne	0x180008d30 <numba_list_iter_next+0xe20>
180008c3f:     	movl	0x74cf(%rip), %eax      # 0x180010114
180008c45:     	movb	$-0x20, %dl
180008c47:     	orl	$0x8, %eax
180008c4a:     	movl	$0x3, 0x74bc(%rip)      # 0x180010110
180008c54:     	movl	%eax, 0x74ba(%rip)      # 0x180010114
180008c5a:     	testb	$0x20, %r10b
180008c5e:     	je	0x180008cc2 <numba_list_iter_next+0xdb2>
180008c60:     	orl	$0x20, %eax
180008c63:     	movl	$0x5, 0x74a3(%rip)      # 0x180010110
180008c6d:     	movl	%eax, 0x74a1(%rip)      # 0x180010114
180008c73:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
180008c78:     	movq	0x74a9(%rip), %rax      # 0x180010128
180008c7f:     	andl	%ecx, %r10d
180008c82:     	andq	$-0x3, %rax
180008c86:     	movq	%rax, 0x749b(%rip)      # 0x180010128
180008c8d:     	cmpl	%ecx, %r10d
180008c90:     	jne	0x180008cc9 <numba_list_iter_next+0xdb9>
180008c92:     	movq	0x20(%rsp), %rax
180008c97:     	andb	%dl, %al
180008c99:     	cmpb	%dl, %al
180008c9b:     	jne	0x180008cc2 <numba_list_iter_next+0xdb2>
180008c9d:     	movq	0x7484(%rip), %rax      # 0x180010128
180008ca4:     	orl	$0x40, 0x7469(%rip)     # 0x180010114
180008cab:     	andq	$-0x25, %rax
180008caf:     	movl	$0x6, 0x7457(%rip)      # 0x180010110
180008cb9:     	movq	%rax, 0x7468(%rip)      # 0x180010128
180008cc0:     	jmp	0x180008cc9 <numba_list_iter_next+0xdb9>
180008cc2:     	movq	0x745f(%rip), %rax      # 0x180010128
180008cc9:     	btl	$0x17, %esi
180008ccd:     	jae	0x180008cdb <numba_list_iter_next+0xdcb>
180008ccf:     	btrq	$0x18, %rax
180008cd4:     	movq	%rax, 0x744d(%rip)      # 0x180010128
180008cdb:     	btl	$0x13, %r9d
180008ce0:     	jae	0x180008d30 <numba_list_iter_next+0xe20>
180008ce2:     	movq	0x20(%rsp), %rax
180008ce7:     	andb	%dl, %al
180008ce9:     	cmpb	%dl, %al
180008ceb:     	jne	0x180008d30 <numba_list_iter_next+0xe20>
180008ced:     	movq	0x7434(%rip), %rdx      # 0x180010128
180008cf4:     	movl	%r11d, %eax
180008cf7:     	shrq	$0x10, %rax
180008cfb:     	movl	%r11d, %ecx
180008cfe:     	andl	$0x6, %eax
180008d01:     	andl	$0x400ff, %ecx          # imm = 0x400FF
180008d07:     	orq	$0x1000029, %rax        # imm = 0x1000029
180008d0d:     	movl	%ecx, 0x7d05(%rip)      # 0x180010a18
180008d13:     	notq	%rax
180008d16:     	andq	%rax, %rdx
180008d19:     	movq	%rdx, 0x7408(%rip)      # 0x180010128
180008d20:     	cmpb	$0x1, %cl
180008d23:     	jbe	0x180008d30 <numba_list_iter_next+0xe20>
180008d25:     	andq	$-0x41, %rdx
180008d29:     	movq	%rdx, 0x73f8(%rip)      # 0x180010128
180008d30:     	btl	$0x15, %r9d
180008d35:     	jae	0x180008d4c <numba_list_iter_next+0xe3c>
180008d37:     	movq	0x20(%rsp), %rax
180008d3c:     	btq	$0x13, %rax
180008d41:     	jae	0x180008d4c <numba_list_iter_next+0xe3c>
180008d43:     	btrq	$0x7, 0x73dc(%rip)      # 0x180010128
180008d4c:     	movq	0x28(%rsp), %rbx
180008d51:     	xorl	%eax, %eax
180008d53:     	movq	0x30(%rsp), %rbp
180008d58:     	movq	0x38(%rsp), %rsi
180008d5d:     	addq	$0x10, %rsp
180008d61:     	popq	%rdi
180008d62:     	retq
180008d63:     	int3
180008d64:     	movl	$0x1, %eax
180008d69:     	retq
180008d6a:     	int3
180008d6b:     	int3
180008d6c:     	xorl	%eax, %eax
180008d6e:     	cmpl	%eax, 0x73bc(%rip)      # 0x180010130
180008d74:     	setne	%al
180008d77:     	retq
180008d78:     	int3
180008d79:     	int3
180008d7a:     	int3
180008d7b:     	int3
180008d7c:     	int3
180008d7d:     	int3
180008d7e:     	int3
180008d7f:     	int3
180008d80:     	jmpq	*0x2c2(%rip)            # 0x180009048
180008d86:     	jmpq	*0x2c4(%rip)            # 0x180009050
180008d8c:     	jmpq	*0x2ee(%rip)            # 0x180009080
180008d92:     	jmpq	*0x300(%rip)            # 0x180009098
180008d98:     	jmpq	*0x302(%rip)            # 0x1800090a0
180008d9e:     	jmpq	*0x304(%rip)            # 0x1800090a8
180008da4:     	jmpq	*0x306(%rip)            # 0x1800090b0
180008daa:     	jmpq	*0x308(%rip)            # 0x1800090b8
180008db0:     	jmpq	*0x30a(%rip)            # 0x1800090c0
180008db6:     	jmpq	*0x30c(%rip)            # 0x1800090c8
180008dbc:     	jmpq	*0x2ce(%rip)            # 0x180009090
180008dc2:     	int3
180008dc3:     	int3
180008dc4:     	movb	$0x1, %al
180008dc6:     	retq
180008dc7:     	int3
180008dc8:     	xorl	%eax, %eax
180008dca:     	retq
180008dcb:     	jmpq	*0x26f(%rip)            # 0x180009040
180008dd1:     	jmpq	*0x261(%rip)            # 0x180009038
180008dd7:     	jmpq	*0x2fb(%rip)            # 0x1800090d8
180008ddd:     	jmpq	*0x2fd(%rip)            # 0x1800090e0
180008de3:     	int3
180008de4:     	int3
180008de5:     	int3
180008de6:     	int3
180008de7:     	int3
180008de8:     	int3
180008de9:     	int3
180008dea:     	int3
180008deb:     	int3
180008dec:     	int3
180008ded:     	int3
180008dee:     	int3
180008def:     	int3
180008df0:     	int3
180008df1:     	int3
180008df2:     	int3
180008df3:     	int3
180008df4:     	int3
180008df5:     	int3
180008df6:     	nopw	(%rax,%rax)
180008e00:     	jmpq	*%rax
180008e02:     	int3
180008e03:     	int3
180008e04:     	int3
180008e05:     	int3
180008e06:     	int3
180008e07:     	int3
180008e08:     	int3
180008e09:     	int3
180008e0a:     	int3
180008e0b:     	int3
180008e0c:     	int3
180008e0d:     	int3
180008e0e:     	int3
180008e0f:     	int3
180008e10:     	int3
180008e11:     	int3
180008e12:     	int3
180008e13:     	int3
180008e14:     	int3
180008e15:     	int3
180008e16:     	nopw	(%rax,%rax)
180008e20:     	jmpq	*0x50a(%rip)            # 0x180009330
180008e26:     	pushq	%rbp
180008e28:     	subq	$0x20, %rsp
180008e2c:     	movq	%rdx, %rbp
180008e2f:     	movb	0x40(%rbp), %cl
180008e32:     	addq	$0x20, %rsp
180008e36:     	popq	%rbp
180008e37:     	jmp	0x1800089ec <numba_list_iter_next+0xadc>
180008e3c:     	int3
180008e3d:     	pushq	%rbp
180008e3f:     	subq	$0x20, %rsp
180008e43:     	movq	%rdx, %rbp
180008e46:     	movb	0x20(%rbp), %cl
180008e49:     	callq	0x1800089ec <numba_list_iter_next+0xadc>
180008e4e:     	nop
180008e4f:     	addq	$0x20, %rsp
180008e53:     	popq	%rbp
180008e54:     	retq
180008e55:     	int3
180008e56:     	pushq	%rbp
180008e58:     	subq	$0x20, %rsp
180008e5c:     	movq	%rdx, %rbp
180008e5f:     	addq	$0x20, %rsp
180008e63:     	popq	%rbp
180008e64:     	jmp	0x180008878 <numba_list_iter_next+0x968>
180008e69:     	int3
180008e6a:     	pushq	%rbp
180008e6c:     	subq	$0x30, %rsp
180008e70:     	movq	%rdx, %rbp
180008e73:     	movq	(%rcx), %rax
180008e76:     	movl	(%rax), %edx
180008e78:     	movq	%rcx, 0x28(%rsp)
180008e7d:     	movl	%edx, 0x20(%rsp)
180008e81:     	leaq	-0xbd8(%rip), %r9       # 0x1800082b0 <numba_list_iter_next+0x3a0>
180008e88:     	movq	0x70(%rbp), %r8
180008e8c:     	movl	0x68(%rbp), %edx
180008e8f:     	movq	0x60(%rbp), %rcx
180008e93:     	callq	0x1800087e8 <numba_list_iter_next+0x8d8>
180008e98:     	nop
180008e99:     	addq	$0x30, %rsp
180008e9d:     	popq	%rbp
180008e9e:     	retq
180008e9f:     	int3
180008ea0:     	pushq	%rbp
180008ea2:     	movq	%rdx, %rbp
180008ea5:     	movq	(%rcx), %rax
180008ea8:     	xorl	%ecx, %ecx
180008eaa:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
180008eb0:     	sete	%cl
180008eb3:     	movl	%ecx, %eax
180008eb5:     	popq	%rbp
180008eb6:     	retq
180008eb7:     	int3
