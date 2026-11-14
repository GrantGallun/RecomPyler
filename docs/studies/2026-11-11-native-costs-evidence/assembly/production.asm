
D:\Code\Datathon\recompyler-codex-20261111\wave6-proof-study\results\cache\candidate\recompyler\rcaotr_d69a5295b7dfe3ae8e1e45a1.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x18000b680 <numba_list_iter_next+0x160>
180001071:     	nopw	%cs:(%rax,%rax)
18000107b:     	nopl	(%rax,%rax)
180001080:     	leaq	0xc3f9(%rip), %rax      # 0x18000d480
180001087:     	movq	%rax, (%rdx)
18000108a:     	movl	$0x1, %eax
18000108f:     	retq
180001090:     	pushq	%r15
180001092:     	pushq	%r14
180001094:     	pushq	%r13
180001096:     	pushq	%r12
180001098:     	pushq	%rsi
180001099:     	pushq	%rdi
18000109a:     	pushq	%rbp
18000109b:     	pushq	%rbx
18000109c:     	subq	$0x1b8, %rsp            # imm = 0x1B8
1800010a3:     	movapd	%xmm8, 0x1a0(%rsp)
1800010ad:     	movaps	%xmm7, 0x190(%rsp)
1800010b5:     	movapd	%xmm6, 0x180(%rsp)
1800010be:     	movq	0x308(%rsp), %r11
1800010c6:     	movq	0x2d8(%rsp), %r15
1800010ce:     	movq	0x2a0(%rsp), %rbx
1800010d6:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
1800010e0:     	movabsq	$-0x40000000000001, %r10 # imm = 0xFFBFFFFFFFFFFFFF
1800010ea:     	movq	$0x0, 0x150(%rsp)
1800010f6:     	movq	$0x0, 0x160(%rsp)
180001102:     	leaq	(%r11,%rax), %rsi
180001106:     	cmpq	%r10, %rsi
180001109:     	jb	0x18000111b <.text+0x11b>
18000110b:     	movq	0x310(%rsp), %rsi
180001113:     	addq	%rsi, %rax
180001116:     	cmpq	%r10, %rax
180001119:     	jae	0x18000115d <.text+0x15d>
18000111b:     	movb	$0x1, (%r15)
18000111f:     	movq	$0x4, 0x18(%rbx)
180001127:     	xorl	%eax, %eax
180001129:     	movq	$0x0, (%rcx)
180001130:     	movaps	0x180(%rsp), %xmm6
180001138:     	movaps	0x190(%rsp), %xmm7
180001140:     	movaps	0x1a0(%rsp), %xmm8
180001149:     	addq	$0x1b8, %rsp            # imm = 0x1B8
180001150:     	popq	%rbx
180001151:     	popq	%rbp
180001152:     	popq	%rdi
180001153:     	popq	%rsi
180001154:     	popq	%r12
180001156:     	popq	%r13
180001158:     	popq	%r14
18000115a:     	popq	%r15
18000115c:     	retq
18000115d:     	movq	0x270(%rsp), %r12
180001165:     	movq	(%rbx), %r10
180001168:     	leaq	0x4(%r10), %rax
18000116c:     	cmpq	%r12, %rax
18000116f:     	jle	0x180001177 <.text+0x177>
180001171:     	movb	$0x2, (%r15)
180001175:     	jmp	0x180001127 <.text+0x127>
180001177:     	movq	%rax, (%rbx)
18000117a:     	xorl	%eax, %eax
18000117c:     	cmpb	$0x0, (%r15)
180001180:     	jne	0x180001129 <.text+0x129>
180001182:     	movq	0x230(%rsp), %r13
18000118a:     	cvtsi2sd	%r11, %xmm0
18000118f:     	movsd	0xc219(%rip), %xmm1     # 0x18000d3b0
180001197:     	mulsd	%xmm1, %xmm0
18000119b:     	cvtsi2sd	%rsi, %xmm2
1800011a0:     	mulsd	%xmm1, %xmm2
1800011a4:     	movsd	%xmm0, 0x10(%r13,%r10,8)
1800011ab:     	movsd	%xmm2, 0x18(%r13,%r10,8)
1800011b2:     	movsd	%xmm0, 0x8(%r13,%r10,8)
1800011b9:     	movsd	%xmm2, (%r13,%r10,8)
1800011c0:     	cmpb	$0x0, (%r15)
1800011c4:     	jne	0x180001129 <.text+0x129>
1800011ca:     	movq	(%rbx), %r14
1800011cd:     	leaq	0xb(%r14), %r11
1800011d1:     	cmpq	%r12, %r11
1800011d4:     	jle	0x1800011df <.text+0x1df>
1800011d6:     	movb	$0x2, (%r15)
1800011da:     	jmp	0x180001129 <.text+0x129>
1800011df:     	movq	%r11, (%rbx)
1800011e2:     	cmpb	$0x0, (%r15)
1800011e6:     	jne	0x180001129 <.text+0x129>
1800011ec:     	movq	0x268(%rsp), %rdi
1800011f4:     	movq	%r10, (%rdi,%r14,8)
1800011f8:     	movq	$0x4, 0x8(%rdi,%r14,8)
180001201:     	movq	(%rbx), %r10
180001204:     	cmpq	%r12, %r10
180001207:     	movq	%r10, %r11
18000120a:     	jle	0x180001216 <.text+0x216>
18000120c:     	movb	$0x2, (%r15)
180001210:     	movq	(%rbx), %r10
180001213:     	xorl	%r11d, %r11d
180001216:     	leaq	0x3(%r10), %rsi
18000121a:     	cmpq	%r12, %rsi
18000121d:     	jg	0x1800011d6 <.text+0x1d6>
18000121f:     	movq	%rsi, (%rbx)
180001222:     	cmpb	$0x0, (%r15)
180001226:     	jne	0x180001129 <.text+0x129>
18000122c:     	movq	%r10, %rsi
18000122f:     	sarq	$0x3f, %rsi
180001233:     	andq	%r12, %rsi
180001236:     	leaq	(%rdi,%r10,8), %rdi
18000123a:     	movq	$0x0, (%rdi,%rsi,8)
180001242:     	xorl	%esi, %esi
180001244:     	cmpq	$-0x1, %r10
180001248:     	movl	$0x0, %ebp
18000124d:     	cmovlq	%r12, %rbp
180001251:     	movq	$0x0, 0x8(%rdi,%rbp,8)
18000125a:     	cmpq	$-0x2, %r10
18000125e:     	cmovlq	%r12, %rsi
180001262:     	movq	%r11, 0x10(%rdi,%rsi,8)
180001267:     	cmpb	$0x0, (%r15)
18000126b:     	jne	0x180001127 <.text+0x127>
180001271:     	movq	0x268(%rsp), %rdi
180001279:     	leaq	(%rdi,%r14,8), %r11
18000127d:     	movq	%r10, 0x30(%r11)
180001281:     	movq	$0x0, 0x18(%r11)
180001289:     	movq	(%rbx), %r10
18000128c:     	leaq	0x4(%r10), %rsi
180001290:     	cmpq	%r12, %rsi
180001293:     	jg	0x1800011d6 <.text+0x1d6>
180001299:     	movq	%r8, 0x140(%rsp)
1800012a1:     	movq	%r9, 0x148(%rsp)
1800012a9:     	movq	%rdx, 0x138(%rsp)
1800012b1:     	movq	%rsi, (%rbx)
1800012b4:     	cmpb	$0x0, (%r15)
1800012b8:     	jne	0x180001127 <.text+0x127>
1800012be:     	movq	%rcx, 0x118(%rsp)
1800012c6:     	movq	$0x0, (%r13,%r10,8)
1800012cf:     	movq	$0x1, 0x8(%rdi,%r10,8)
1800012d8:     	movq	$0x0, 0x10(%r13,%r10,8)
1800012e1:     	movq	$0x1, 0x18(%rdi,%r10,8)
1800012ea:     	cmpb	$0x0, (%r15)
1800012ee:     	jne	0x18000132b <.text+0x32b>
1800012f0:     	movq	%r10, 0x10(%r11)
1800012f4:     	movq	$0x0, 0x48(%r13,%r14,8)
1800012fd:     	movq	$0x1, 0x50(%r11)
180001305:     	movq	$-0x1, 0x20(%r11)
18000130d:     	movq	$-0x1, 0x28(%r11)
180001315:     	movq	$-0x1, 0x38(%r11)
18000131d:     	movq	$-0x1, 0x40(%r11)
180001325:     	cmpb	$0x0, (%r15)
180001329:     	je	0x18000133a <.text+0x33a>
18000132b:     	xorl	%eax, %eax
18000132d:     	movq	0x118(%rsp), %rcx
180001335:     	jmp	0x180001129 <.text+0x129>
18000133a:     	movq	0x2f0(%rsp), %rdx
180001342:     	movq	%rdx, %rax
180001345:     	sarq	$0x3f, %rax
180001349:     	andq	%r12, %rax
18000134c:     	movq	0x268(%rsp), %rcx
180001354:     	leaq	(%rcx,%rdx,8), %rcx
180001358:     	movq	%rax, 0x128(%rsp)
180001360:     	movq	%rcx, %rbp
180001363:     	cmpq	$0x0, (%rcx,%rax,8)
180001368:     	jle	0x180001593 <.text+0x593>
18000136e:     	xorl	%esi, %esi
180001370:     	cmpq	$-0x2, 0x2f0(%rsp)
180001379:     	movl	$0x0, %edi
18000137e:     	cmovlq	%r12, %rdi
180001382:     	movq	0x8(%rbx), %rax
180001386:     	movq	0x10(%rbp,%rdi,8), %rcx
18000138b:     	addq	%rsi, %rcx
18000138e:     	movq	0x268(%rsp), %rdx
180001396:     	leaq	(%rdx,%rcx,8), %rdx
18000139a:     	sarq	$0x3f, %rcx
18000139e:     	andq	%r12, %rcx
1800013a1:     	movq	(%rdx,%rcx,8), %rcx
1800013a5:     	leaq	0x1(%rax), %rdx
1800013a9:     	movq	%rdx, 0x8(%rbx)
1800013ad:     	cmpq	0x10(%rbx), %rax
1800013b1:     	jge	0x180001882 <.text+0x882>
1800013b7:     	movq	%rcx, 0x100(%rsp)
1800013bf:     	movq	%r14, 0xf8(%rsp)
1800013c7:     	movq	0x2e8(%rsp), %rax
1800013cf:     	movq	%rax, 0xe8(%rsp)
1800013d7:     	movq	0x2e0(%rsp), %rax
1800013df:     	movq	%rax, 0xe0(%rsp)
1800013e7:     	movq	%r15, 0xd8(%rsp)
1800013ef:     	movq	0x2d0(%rsp), %rax
1800013f7:     	movq	%rax, 0xd0(%rsp)
1800013ff:     	movq	0x2c8(%rsp), %rax
180001407:     	movq	%rax, 0xc8(%rsp)
18000140f:     	movq	0x2c0(%rsp), %rax
180001417:     	movq	%rax, 0xc0(%rsp)
18000141f:     	movq	0x2b8(%rsp), %rax
180001427:     	movq	%rax, 0xb8(%rsp)
18000142f:     	movq	0x2b0(%rsp), %rax
180001437:     	movq	%rax, 0xb0(%rsp)
18000143f:     	movq	0x2a8(%rsp), %rax
180001447:     	movq	%rax, 0xa8(%rsp)
18000144f:     	movq	%rbx, 0xa0(%rsp)
180001457:     	movq	0x298(%rsp), %rax
18000145f:     	movq	%rax, 0x98(%rsp)
180001467:     	movq	0x290(%rsp), %rax
18000146f:     	movq	%rax, 0x90(%rsp)
180001477:     	movq	0x288(%rsp), %rax
18000147f:     	movq	%rax, 0x88(%rsp)
180001487:     	movq	0x280(%rsp), %rax
18000148f:     	movq	%rax, 0x80(%rsp)
180001497:     	movq	0x278(%rsp), %rax
18000149f:     	movq	%rax, 0x78(%rsp)
1800014a4:     	movq	%r12, 0x70(%rsp)
1800014a9:     	movq	0x268(%rsp), %rax
1800014b1:     	movq	%rax, 0x68(%rsp)
1800014b6:     	movq	0x260(%rsp), %rax
1800014be:     	movq	%rax, 0x60(%rsp)
1800014c3:     	movq	0x258(%rsp), %rax
1800014cb:     	movq	%rax, 0x58(%rsp)
1800014d0:     	movq	0x250(%rsp), %rax
1800014d8:     	movq	%rax, 0x50(%rsp)
1800014dd:     	movq	0x248(%rsp), %rax
1800014e5:     	movq	%rax, 0x48(%rsp)
1800014ea:     	movq	0x240(%rsp), %rax
1800014f2:     	movq	%rax, 0x40(%rsp)
1800014f7:     	movq	0x238(%rsp), %rax
1800014ff:     	movq	%rax, 0x38(%rsp)
180001504:     	movq	%r13, 0x30(%rsp)
180001509:     	movq	0x228(%rsp), %rax
180001511:     	movq	%rax, 0x28(%rsp)
180001516:     	movq	0x220(%rsp), %rax
18000151e:     	movq	%rax, 0x20(%rsp)
180001523:     	movq	$-0x1, 0x108(%rsp)
18000152f:     	movq	$0x0, 0xf0(%rsp)
18000153b:     	leaq	0x127(%rsp), %rcx
180001543:     	leaq	0x170(%rsp), %rdx
18000154b:     	movq	0x140(%rsp), %r8
180001553:     	movq	0x148(%rsp), %r9
18000155b:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
180001560:     	testl	%eax, %eax
180001562:     	jne	0x180001875 <.text+0x875>
180001568:     	cmpb	$0x0, (%r15)
18000156c:     	jne	0x18000132b <.text+0x32b>
180001572:     	incq	%rsi
180001575:     	movq	0x8(%rbx), %rax
180001579:     	decq	%rax
18000157c:     	movq	%rax, 0x8(%rbx)
180001580:     	movq	0x128(%rsp), %rcx
180001588:     	cmpq	(%rbp,%rcx,8), %rsi
18000158d:     	jl	0x180001386 <.text+0x386>
180001593:     	movsd	0x300(%rsp), %xmm6
18000159c:     	movsd	0x2f8(%rsp), %xmm7
1800015a5:     	xorl	%esi, %esi
1800015a7:     	cmpq	$-0x2, 0x2f0(%rsp)
1800015b0:     	movl	$0x0, %eax
1800015b5:     	cmovlq	%r12, %rax
1800015b9:     	movq	%rax, 0x130(%rsp)
1800015c1:     	xorpd	%xmm8, %xmm8
1800015c6:     	jmp	0x1800015e1 <.text+0x5e1>
1800015c8:     	movb	$0x1, (%r15)
1800015cc:     	movq	$0x4c4b43, 0x18(%rbx)   # imm = 0x4C4B43
1800015d4:     	incq	%rsi
1800015d7:     	cmpb	$0x0, (%r15)
1800015db:     	jne	0x1800019b8 <.text+0x9b8>
1800015e1:     	movq	0x128(%rsp), %rax
1800015e9:     	cmpq	(%rbp,%rax,8), %rsi
1800015ee:     	jge	0x180001893 <.text+0x893>
1800015f4:     	movq	0x130(%rsp), %rax
1800015fc:     	movq	0x10(%rbp,%rax,8), %rax
180001601:     	addq	%rsi, %rax
180001604:     	movq	0x268(%rsp), %rcx
18000160c:     	leaq	(%rcx,%rax,8), %rcx
180001610:     	sarq	$0x3f, %rax
180001614:     	andq	%r12, %rax
180001617:     	movq	(%rcx,%rax,8), %rdi
18000161b:     	movq	0x8(%rbx), %rax
18000161f:     	leaq	0x1(%rax), %rcx
180001623:     	movq	%rcx, 0x8(%rbx)
180001627:     	cmpq	0x10(%rbx), %rax
18000162b:     	jge	0x1800019c5 <.text+0x9c5>
180001631:     	movsd	%xmm7, 0x100(%rsp)
18000163a:     	movq	%rdi, 0xf8(%rsp)
180001642:     	movq	%r14, 0xf0(%rsp)
18000164a:     	movq	0x2e8(%rsp), %rax
180001652:     	movq	%rax, 0xe8(%rsp)
18000165a:     	movq	0x2e0(%rsp), %rax
180001662:     	movq	%rax, 0xe0(%rsp)
18000166a:     	movq	%r15, 0xd8(%rsp)
180001672:     	movq	0x2d0(%rsp), %rax
18000167a:     	movq	%rax, 0xd0(%rsp)
180001682:     	movq	0x2c8(%rsp), %rax
18000168a:     	movq	%rax, 0xc8(%rsp)
180001692:     	movq	0x2c0(%rsp), %rax
18000169a:     	movq	%rax, 0xc0(%rsp)
1800016a2:     	movq	0x2b8(%rsp), %rax
1800016aa:     	movq	%rax, 0xb8(%rsp)
1800016b2:     	movq	0x2b0(%rsp), %rax
1800016ba:     	movq	%rax, 0xb0(%rsp)
1800016c2:     	movq	0x2a8(%rsp), %rax
1800016ca:     	movq	%rax, 0xa8(%rsp)
1800016d2:     	movq	%rbx, 0xa0(%rsp)
1800016da:     	movq	0x298(%rsp), %rax
1800016e2:     	movq	%rax, 0x98(%rsp)
1800016ea:     	movq	0x290(%rsp), %rax
1800016f2:     	movq	%rax, 0x90(%rsp)
1800016fa:     	movq	0x288(%rsp), %rax
180001702:     	movq	%rax, 0x88(%rsp)
18000170a:     	movq	0x280(%rsp), %rax
180001712:     	movq	%rax, 0x80(%rsp)
18000171a:     	movq	0x278(%rsp), %rax
180001722:     	movq	%rax, 0x78(%rsp)
180001727:     	movq	%r12, 0x70(%rsp)
18000172c:     	movq	0x268(%rsp), %rax
180001734:     	movq	%rax, 0x68(%rsp)
180001739:     	movq	0x260(%rsp), %rax
180001741:     	movq	%rax, 0x60(%rsp)
180001746:     	movq	0x258(%rsp), %rax
18000174e:     	movq	%rax, 0x58(%rsp)
180001753:     	movq	0x250(%rsp), %rax
18000175b:     	movq	%rax, 0x50(%rsp)
180001760:     	movq	0x248(%rsp), %rax
180001768:     	movq	%rax, 0x48(%rsp)
18000176d:     	movq	0x240(%rsp), %rax
180001775:     	movq	%rax, 0x40(%rsp)
18000177a:     	movq	0x238(%rsp), %rax
180001782:     	movq	%rax, 0x38(%rsp)
180001787:     	movq	%r13, 0x30(%rsp)
18000178c:     	movq	0x228(%rsp), %rax
180001794:     	movq	%rax, 0x28(%rsp)
180001799:     	movq	0x220(%rsp), %rax
1800017a1:     	movq	%rax, 0x20(%rsp)
1800017a6:     	leaq	0x150(%rsp), %rcx
1800017ae:     	leaq	0x178(%rsp), %rdx
1800017b6:     	movq	0x140(%rsp), %r8
1800017be:     	movq	0x148(%rsp), %r9
1800017c6:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
1800017cb:     	testl	%eax, %eax
1800017cd:     	jne	0x180001875 <.text+0x875>
1800017d3:     	xorl	%eax, %eax
1800017d5:     	cmpb	$0x0, (%r15)
1800017d9:     	jne	0x1800019b8 <.text+0x9b8>
1800017df:     	movsd	0x150(%rsp), %xmm1
1800017e8:     	movsd	0x160(%rsp), %xmm0
1800017f1:     	decq	0x8(%rbx)
1800017f5:     	movsd	0x8(%r13,%rdi,8), %xmm2
1800017fc:     	ucomisd	%xmm8, %xmm2
180001801:     	jne	0x180001809 <.text+0x809>
180001803:     	jnp	0x1800015c8 <.text+0x5c8>
180001809:     	movq	0x268(%rsp), %rdx
180001811:     	movq	(%rdx,%rdi,8), %rcx
180001815:     	divsd	%xmm2, %xmm1
180001819:     	addsd	(%r13,%rcx,8), %xmm1
180001820:     	movsd	%xmm1, (%r13,%rcx,8)
180001827:     	movq	$0x0, 0x8(%rdx,%rcx,8)
180001830:     	movsd	0x8(%r13,%rdi,8), %xmm1
180001837:     	ucomisd	%xmm8, %xmm1
18000183c:     	jne	0x180001851 <.text+0x851>
18000183e:     	jp	0x180001851 <.text+0x851>
180001840:     	movb	$0x1, (%r15)
180001844:     	movq	$0x4c4b44, 0x18(%rbx)   # imm = 0x4C4B44
18000184c:     	jmp	0x1800015d4 <.text+0x5d4>
180001851:     	movq	(%rdx,%rdi,8), %rcx
180001855:     	divsd	%xmm1, %xmm0
180001859:     	addsd	0x10(%r13,%rcx,8), %xmm0
180001860:     	movsd	%xmm0, 0x10(%r13,%rcx,8)
180001867:     	movq	$0x0, 0x18(%rdx,%rcx,8)
180001870:     	jmp	0x1800015d4 <.text+0x5d4>
180001875:     	movq	0x138(%rsp), %rcx
18000187d:     	jmp	0x180001129 <.text+0x129>
180001882:     	movb	$0x1, (%r15)
180001886:     	movq	$0x9, 0x18(%rbx)
18000188e:     	jmp	0x18000132b <.text+0x32b>
180001893:     	xorl	%eax, %eax
180001895:     	xorl	%ecx, %ecx
180001897:     	movq	0x128(%rsp), %rdx
18000189f:     	cmpq	(%rbp,%rdx,8), %rcx
1800018a4:     	jge	0x1800019b8 <.text+0x9b8>
1800018aa:     	movq	0x130(%rsp), %rdx
1800018b2:     	movq	0x10(%rbp,%rdx,8), %rdx
1800018b7:     	addq	%rcx, %rdx
1800018ba:     	movq	0x268(%rsp), %r10
1800018c2:     	leaq	(%r10,%rdx,8), %r8
1800018c6:     	sarq	$0x3f, %rdx
1800018ca:     	andq	%r12, %rdx
1800018cd:     	movq	(%r8,%rdx,8), %rdx
1800018d1:     	incq	%rcx
1800018d4:     	movq	(%r10,%rdx,8), %r8
1800018d8:     	movq	0x18(%r10,%rdx,8), %r9
1800018dd:     	movsd	(%r13,%r8,8), %xmm0
1800018e4:     	mulsd	%xmm6, %xmm0
1800018e8:     	addsd	(%r13,%r9,8), %xmm0
1800018ef:     	movsd	%xmm0, (%r13,%r9,8)
1800018f6:     	movq	$0x0, 0x8(%r10,%r9,8)
1800018ff:     	movq	(%r10,%rdx,8), %r8
180001903:     	movq	0x18(%r10,%rdx,8), %r9
180001908:     	movsd	0x10(%r13,%r8,8), %xmm0
18000190f:     	mulsd	%xmm6, %xmm0
180001913:     	addsd	0x10(%r13,%r9,8), %xmm0
18000191a:     	movsd	%xmm0, 0x10(%r13,%r9,8)
180001921:     	movq	$0x0, 0x18(%r10,%r9,8)
18000192a:     	movq	0x10(%r10,%rdx,8), %r8
18000192f:     	movq	0x18(%r10,%rdx,8), %r9
180001934:     	movsd	(%r13,%r9,8), %xmm0
18000193b:     	mulsd	%xmm6, %xmm0
18000193f:     	addsd	(%r13,%r8,8), %xmm0
180001946:     	movsd	%xmm0, (%r13,%r8,8)
18000194d:     	movq	$0x0, 0x8(%r10,%r8,8)
180001956:     	movq	0x10(%r10,%rdx,8), %r8
18000195b:     	movq	0x18(%r10,%rdx,8), %r9
180001960:     	movsd	0x10(%r13,%r9,8), %xmm0
180001967:     	mulsd	%xmm6, %xmm0
18000196b:     	addsd	0x10(%r13,%r8,8), %xmm0
180001972:     	movsd	%xmm0, 0x10(%r13,%r8,8)
180001979:     	movq	$0x0, 0x18(%r10,%r8,8)
180001982:     	movq	(%r10,%rdx,8), %r8
180001986:     	movq	$0x0, (%r13,%r8,8)
18000198f:     	movq	$0x1, 0x8(%r10,%r8,8)
180001998:     	movq	(%r10,%rdx,8), %rdx
18000199c:     	movq	$0x0, 0x10(%r13,%rdx,8)
1800019a5:     	movq	$0x1, 0x18(%r10,%rdx,8)
1800019ae:     	cmpb	$0x0, (%r15)
1800019b2:     	je	0x180001897 <.text+0x897>
1800019b8:     	movq	0x118(%rsp), %rcx
1800019c0:     	jmp	0x180001129 <.text+0x129>
1800019c5:     	movb	$0x1, (%r15)
1800019c9:     	movq	$0xd, 0x18(%rbx)
1800019d1:     	jmp	0x18000132b <.text+0x32b>
1800019d6:     	nopw	%cs:(%rax,%rax)
1800019e0:     	pushq	%r15
1800019e2:     	pushq	%r14
1800019e4:     	pushq	%r13
1800019e6:     	pushq	%r12
1800019e8:     	pushq	%rsi
1800019e9:     	pushq	%rdi
1800019ea:     	pushq	%rbp
1800019eb:     	pushq	%rbx
1800019ec:     	subq	$0x338, %rsp            # imm = 0x338
1800019f3:     	movaps	%xmm7, 0x320(%rsp)
1800019fb:     	movaps	%xmm6, 0x310(%rsp)
180001a03:     	movq	%rdx, %rcx
180001a06:     	leaq	0x1c8(%rsp), %rax
180001a0e:     	movq	%rax, 0x60(%rsp)
180001a13:     	leaq	0x1d0(%rsp), %rax
180001a1b:     	movq	%rax, 0x58(%rsp)
180001a20:     	leaq	0x1d8(%rsp), %rax
180001a28:     	movq	%rax, 0x50(%rsp)
180001a2d:     	leaq	0x1e0(%rsp), %rax
180001a35:     	movq	%rax, 0x48(%rsp)
180001a3a:     	leaq	0x1e8(%rsp), %rax
180001a42:     	movq	%rax, 0x40(%rsp)
180001a47:     	leaq	0x1f0(%rsp), %rax
180001a4f:     	movq	%rax, 0x38(%rsp)
180001a54:     	leaq	0x1f8(%rsp), %rax
180001a5c:     	movq	%rax, 0x30(%rsp)
180001a61:     	leaq	0x200(%rsp), %rax
180001a69:     	movq	%rax, 0x28(%rsp)
180001a6e:     	leaq	0x208(%rsp), %rax
180001a76:     	movq	%rax, 0x20(%rsp)
180001a7b:     	leaq	0xba2e(%rip), %rdx      # 0x18000d4b0
180001a82:     	movl	$0x9, %r8d
180001a88:     	movl	$0x9, %r9d
180001a8e:     	callq	0x18000b831 <numba_list_iter_next+0x311>
180001a93:     	testl	%eax, %eax
180001a95:     	movq	$0x0, 0x130(%rsp)
180001aa1:     	je	0x18000219c <.text+0x119c>
180001aa7:     	cmpq	$0x0, 0x13221(%rip)     # 0x180014cd0
180001aaf:     	je	0x1800020c4 <.text+0x10c4>
180001ab5:     	movq	0x208(%rsp), %rcx
180001abd:     	xorps	%xmm0, %xmm0
180001ac0:     	movaps	%xmm0, 0x2d0(%rsp)
180001ac8:     	movaps	%xmm0, 0x2e0(%rsp)
180001ad0:     	movaps	%xmm0, 0x2f0(%rsp)
180001ad8:     	movq	$0x0, 0x300(%rsp)
180001ae4:     	leaq	0x2d0(%rsp), %rdx
180001aec:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180001af1:     	testl	%eax, %eax
180001af3:     	jne	0x1800020dc <.text+0x10dc>
180001af9:     	cmpq	$0x8, 0x2e8(%rsp)
180001b02:     	jne	0x1800020dc <.text+0x10dc>
180001b08:     	movq	0x2d0(%rsp), %rbx
180001b10:     	movq	0x2d8(%rsp), %rbp
180001b18:     	movq	0x2e0(%rsp), %rsi
180001b20:     	movq	0x2f0(%rsp), %rdi
180001b28:     	movq	0x2f8(%rsp), %r15
180001b30:     	movq	0x300(%rsp), %r13
180001b38:     	movq	0x200(%rsp), %rcx
180001b40:     	xorps	%xmm0, %xmm0
180001b43:     	movaps	%xmm0, 0x290(%rsp)
180001b4b:     	movaps	%xmm0, 0x2a0(%rsp)
180001b53:     	movaps	%xmm0, 0x2b0(%rsp)
180001b5b:     	movq	$0x0, 0x2c0(%rsp)
180001b67:     	leaq	0x290(%rsp), %rdx
180001b6f:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180001b74:     	testl	%eax, %eax
180001b76:     	jne	0x1800020f4 <.text+0x10f4>
180001b7c:     	cmpq	$0x8, 0x2a8(%rsp)
180001b85:     	jne	0x1800020f4 <.text+0x10f4>
180001b8b:     	movq	0x290(%rsp), %r12
180001b93:     	movq	0x298(%rsp), %r14
180001b9b:     	movq	0x2a0(%rsp), %rax
180001ba3:     	movq	%rax, 0x1c0(%rsp)
180001bab:     	movq	0x2b0(%rsp), %rax
180001bb3:     	movq	%rax, 0x1b8(%rsp)
180001bbb:     	movq	0x2b8(%rsp), %rax
180001bc3:     	movq	%rax, 0x1b0(%rsp)
180001bcb:     	movq	0x2c0(%rsp), %rax
180001bd3:     	movq	%rax, 0x1a8(%rsp)
180001bdb:     	movq	0x1f8(%rsp), %rcx
180001be3:     	xorps	%xmm0, %xmm0
180001be6:     	movaps	%xmm0, 0x250(%rsp)
180001bee:     	movaps	%xmm0, 0x260(%rsp)
180001bf6:     	movaps	%xmm0, 0x270(%rsp)
180001bfe:     	movq	$0x0, 0x280(%rsp)
180001c0a:     	leaq	0x250(%rsp), %rdx
180001c12:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180001c17:     	testl	%eax, %eax
180001c19:     	jne	0x18000210c <.text+0x110c>
180001c1f:     	cmpq	$0x8, 0x268(%rsp)
180001c28:     	jne	0x18000210c <.text+0x110c>
180001c2e:     	movq	%r14, 0x1a0(%rsp)
180001c36:     	movq	0x250(%rsp), %r14
180001c3e:     	movq	0x258(%rsp), %rax
180001c46:     	movq	%rax, 0x198(%rsp)
180001c4e:     	movq	0x260(%rsp), %rax
180001c56:     	movq	%rax, 0x190(%rsp)
180001c5e:     	movq	0x270(%rsp), %rax
180001c66:     	movq	%rax, 0x188(%rsp)
180001c6e:     	movq	0x278(%rsp), %rax
180001c76:     	movq	%rax, 0x180(%rsp)
180001c7e:     	movq	0x280(%rsp), %rax
180001c86:     	movq	%rax, 0x178(%rsp)
180001c8e:     	movq	0x1f0(%rsp), %rcx
180001c96:     	xorps	%xmm0, %xmm0
180001c99:     	movaps	%xmm0, 0x210(%rsp)
180001ca1:     	movaps	%xmm0, 0x220(%rsp)
180001ca9:     	movaps	%xmm0, 0x230(%rsp)
180001cb1:     	movq	$0x0, 0x240(%rsp)
180001cbd:     	leaq	0x210(%rsp), %rdx
180001cc5:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180001cca:     	testl	%eax, %eax
180001ccc:     	jne	0x180002121 <.text+0x1121>
180001cd2:     	cmpq	$0x1, 0x228(%rsp)
180001cdb:     	jne	0x180002121 <.text+0x1121>
180001ce1:     	movq	%r13, 0x150(%rsp)
180001ce9:     	movq	%r15, 0x158(%rsp)
180001cf1:     	movq	%rdi, 0x160(%rsp)
180001cf9:     	movq	%rsi, 0x168(%rsp)
180001d01:     	movq	0x210(%rsp), %r15
180001d09:     	movq	0x218(%rsp), %rax
180001d11:     	movq	%rax, 0x148(%rsp)
180001d19:     	movq	0x220(%rsp), %rax
180001d21:     	movq	%rax, 0x140(%rsp)
180001d29:     	movq	0x230(%rsp), %rax
180001d31:     	movq	%rax, 0x138(%rsp)
180001d39:     	movq	0x238(%rsp), %rdi
180001d41:     	movq	0x240(%rsp), %rsi
180001d49:     	movq	0x1e8(%rsp), %rcx
180001d51:     	callq	0x18000b837 <numba_list_iter_next+0x317>
180001d56:     	testq	%rax, %rax
180001d59:     	movq	%rbx, 0x128(%rsp)
180001d61:     	movq	%r12, 0x120(%rsp)
180001d69:     	movq	%rbp, 0x170(%rsp)
180001d71:     	je	0x180002136 <.text+0x1136>
180001d77:     	movq	%rax, %r13
180001d7a:     	movq	%rax, %rcx
180001d7d:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
180001d82:     	movq	%rax, %r12
180001d85:     	movq	%r13, %rcx
180001d88:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180001d8d:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180001d92:     	testq	%rax, %rax
180001d95:     	jne	0x18000216c <.text+0x116c>
180001d9b:     	movq	0x1e0(%rsp), %rcx
180001da3:     	callq	0x18000b84f <numba_list_iter_next+0x32f>
180001da8:     	movq	%rax, %rbx
180001dab:     	movq	%rax, %rcx
180001dae:     	callq	0x18000b855 <numba_list_iter_next+0x335>
180001db3:     	movaps	%xmm0, %xmm6
180001db6:     	movq	%rbx, %rcx
180001db9:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180001dbe:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180001dc3:     	testq	%rax, %rax
180001dc6:     	jne	0x18000216c <.text+0x116c>
180001dcc:     	movq	0x1d8(%rsp), %rcx
180001dd4:     	callq	0x18000b84f <numba_list_iter_next+0x32f>
180001dd9:     	movq	%rax, %rbx
180001ddc:     	movq	%rax, %rcx
180001ddf:     	callq	0x18000b855 <numba_list_iter_next+0x335>
180001de4:     	movaps	%xmm0, %xmm7
180001de7:     	movq	%rbx, %rcx
180001dea:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180001def:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180001df4:     	testq	%rax, %rax
180001df7:     	jne	0x18000216c <.text+0x116c>
180001dfd:     	movq	0x1d0(%rsp), %rcx
180001e05:     	callq	0x18000b837 <numba_list_iter_next+0x317>
180001e0a:     	testq	%rax, %rax
180001e0d:     	je	0x180002149 <.text+0x1149>
180001e13:     	movq	%rax, %rbp
180001e16:     	movq	%rax, %rcx
180001e19:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
180001e1e:     	movq	%rax, %r13
180001e21:     	movq	%rbp, %rcx
180001e24:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180001e29:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180001e2e:     	testq	%rax, %rax
180001e31:     	jne	0x18000216c <.text+0x116c>
180001e37:     	movq	0x1c8(%rsp), %rcx
180001e3f:     	callq	0x18000b837 <numba_list_iter_next+0x317>
180001e44:     	testq	%rax, %rax
180001e47:     	je	0x18000215c <.text+0x115c>
180001e4d:     	movq	%rax, %rbx
180001e50:     	movq	%rax, %rcx
180001e53:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
180001e58:     	movq	%rax, %rbp
180001e5b:     	movq	%rbx, %rcx
180001e5e:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180001e63:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180001e68:     	testq	%rax, %rax
180001e6b:     	jne	0x18000216c <.text+0x116c>
180001e71:     	movq	%rbp, 0x110(%rsp)
180001e79:     	movq	%r13, 0x108(%rsp)
180001e81:     	movq	%r12, 0xf0(%rsp)
180001e89:     	movq	%rsi, 0xe8(%rsp)
180001e91:     	movq	%rdi, 0xe0(%rsp)
180001e99:     	movq	0x138(%rsp), %rax
180001ea1:     	movq	%rax, 0xd8(%rsp)
180001ea9:     	movq	0x140(%rsp), %rax
180001eb1:     	movq	%rax, 0xc8(%rsp)
180001eb9:     	movq	0x148(%rsp), %rax
180001ec1:     	movq	%rax, 0xc0(%rsp)
180001ec9:     	movq	0x178(%rsp), %rax
180001ed1:     	movq	%rax, 0xb0(%rsp)
180001ed9:     	movq	0x180(%rsp), %rax
180001ee1:     	movq	%rax, 0xa8(%rsp)
180001ee9:     	movq	0x188(%rsp), %rax
180001ef1:     	movq	%rax, 0xa0(%rsp)
180001ef9:     	movq	0x190(%rsp), %rax
180001f01:     	movq	%rax, 0x90(%rsp)
180001f09:     	movq	0x198(%rsp), %rax
180001f11:     	movq	%rax, 0x88(%rsp)
180001f19:     	movq	0x1a8(%rsp), %rax
180001f21:     	movq	%rax, 0x78(%rsp)
180001f26:     	movq	0x1b0(%rsp), %rax
180001f2e:     	movq	%rax, 0x70(%rsp)
180001f33:     	movq	0x1b8(%rsp), %rax
180001f3b:     	movq	%rax, 0x68(%rsp)
180001f40:     	movq	0x1c0(%rsp), %rax
180001f48:     	movq	%rax, 0x58(%rsp)
180001f4d:     	movq	0x1a0(%rsp), %rax
180001f55:     	movq	%rax, 0x50(%rsp)
180001f5a:     	movq	0x150(%rsp), %rax
180001f62:     	movq	%rax, 0x40(%rsp)
180001f67:     	movq	0x158(%rsp), %rax
180001f6f:     	movq	%rax, 0x38(%rsp)
180001f74:     	movsd	%xmm7, 0x100(%rsp)
180001f7d:     	movsd	%xmm6, 0xf8(%rsp)
180001f86:     	movq	%r15, 0xb8(%rsp)
180001f8e:     	movq	%r14, 0x80(%rsp)
180001f96:     	movq	0x120(%rsp), %rdi
180001f9e:     	movq	%rdi, 0x48(%rsp)
180001fa3:     	movq	0x160(%rsp), %rax
180001fab:     	movq	%rax, 0x30(%rsp)
180001fb0:     	movq	0x168(%rsp), %rax
180001fb8:     	movq	%rax, 0x20(%rsp)
180001fbd:     	movq	$0x1, 0xd0(%rsp)
180001fc9:     	movq	$0x8, 0x98(%rsp)
180001fd5:     	movq	$0x8, 0x60(%rsp)
180001fde:     	movq	$0x8, 0x28(%rsp)
180001fe7:     	leaq	0x308(%rsp), %rcx
180001fef:     	leaq	0x130(%rsp), %rdx
180001ff7:     	movq	0x170(%rsp), %r9
180001fff:     	movq	0x128(%rsp), %rsi
180002007:     	movq	%rsi, %r8
18000200a:     	callq	0x180001090 <.text+0x90>
18000200f:     	movl	%eax, %ebp
180002011:     	movq	0x130(%rsp), %rbx
180002019:     	movq	%rsi, %rcx
18000201c:     	callq	0x180001060 <.text+0x60>
180002021:     	movq	%rdi, %rcx
180002024:     	callq	0x180001060 <.text+0x60>
180002029:     	movq	%r14, %rcx
18000202c:     	callq	0x180001060 <.text+0x60>
180002031:     	movq	%r15, %rcx
180002034:     	callq	0x180001060 <.text+0x60>
180002039:     	testl	%ebp, %ebp
18000203b:     	jne	0x180002073 <.text+0x1073>
18000203d:     	movq	0xb28c(%rip), %rsi      # 0x18000d2d0
180002044:     	movq	%rsi, %rcx
180002047:     	callq	0x18000b85b <numba_list_iter_next+0x33b>
18000204c:     	movq	%rsi, %rax
18000204f:     	movaps	0x310(%rsp), %xmm6
180002057:     	movaps	0x320(%rsp), %xmm7
18000205f:     	addq	$0x338, %rsp            # imm = 0x338
180002066:     	popq	%rbx
180002067:     	popq	%rbp
180002068:     	popq	%rdi
180002069:     	popq	%rsi
18000206a:     	popq	%r12
18000206c:     	popq	%r13
18000206e:     	popq	%r14
180002070:     	popq	%r15
180002072:     	retq
180002073:     	jle	0x1800021a3 <.text+0x11a3>
180002079:     	callq	0x18000b861 <numba_list_iter_next+0x341>
18000207e:     	movl	0x8(%rbx), %edx
180002081:     	movq	(%rbx), %rcx
180002084:     	cmpl	$0x0, 0x20(%rbx)
180002088:     	jle	0x1800021c2 <.text+0x11c2>
18000208e:     	movslq	%edx, %rdx
180002091:     	callq	0x18000b867 <numba_list_iter_next+0x347>
180002096:     	movq	%rax, %rsi
180002099:     	movq	0x10(%rbx), %rcx
18000209d:     	callq	*0x18(%rbx)
1800020a0:     	testq	%rax, %rax
1800020a3:     	je	0x1800021eb <.text+0x11eb>
1800020a9:     	movq	%rsi, %rcx
1800020ac:     	movq	%rax, %rdx
1800020af:     	callq	0x180009d00 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6140>
1800020b4:     	movq	%rax, %rsi
1800020b7:     	movq	%rbx, %rcx
1800020ba:     	callq	0x18000b790 <numba_list_iter_next+0x270>
1800020bf:     	jmp	0x1800021ce <.text+0x11ce>
1800020c4:     	movq	0xb1e5(%rip), %rcx      # 0x18000d2b0
1800020cb:     	leaq	0xb3fe(%rip), %rdx      # 0x18000d4d0
1800020d2:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800020d7:     	jmp	0x18000219c <.text+0x119c>
1800020dc:     	movq	0xb1bd(%rip), %rcx      # 0x18000d2a0
1800020e3:     	leaq	0xb4e6(%rip), %rdx      # 0x18000d5d0
1800020ea:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800020ef:     	jmp	0x18000219c <.text+0x119c>
1800020f4:     	movq	0xb1a5(%rip), %rcx      # 0x18000d2a0
1800020fb:     	leaq	0xb4ce(%rip), %rdx      # 0x18000d5d0
180002102:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180002107:     	jmp	0x180002194 <.text+0x1194>
18000210c:     	movq	0xb18d(%rip), %rcx      # 0x18000d2a0
180002113:     	leaq	0xb4b6(%rip), %rdx      # 0x18000d5d0
18000211a:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
18000211f:     	jmp	0x18000218c <.text+0x118c>
180002121:     	movq	0xb178(%rip), %rcx      # 0x18000d2a0
180002128:     	leaq	0xb4a1(%rip), %rdx      # 0x18000d5d0
18000212f:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180002134:     	jmp	0x180002184 <.text+0x1184>
180002136:     	xorl	%r12d, %r12d
180002139:     	callq	0x18000b849 <numba_list_iter_next+0x329>
18000213e:     	testq	%rax, %rax
180002141:     	je	0x180001d9b <.text+0xd9b>
180002147:     	jmp	0x18000216c <.text+0x116c>
180002149:     	xorl	%r13d, %r13d
18000214c:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180002151:     	testq	%rax, %rax
180002154:     	je	0x180001e37 <.text+0xe37>
18000215a:     	jmp	0x18000216c <.text+0x116c>
18000215c:     	xorl	%ebp, %ebp
18000215e:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180002163:     	testq	%rax, %rax
180002166:     	je	0x180001e71 <.text+0xe71>
18000216c:     	movq	%r15, %rcx
18000216f:     	callq	0x180001060 <.text+0x60>
180002174:     	movq	0x128(%rsp), %rbx
18000217c:     	movq	0x120(%rsp), %r12
180002184:     	movq	%r14, %rcx
180002187:     	callq	0x180001060 <.text+0x60>
18000218c:     	movq	%r12, %rcx
18000218f:     	callq	0x180001060 <.text+0x60>
180002194:     	movq	%rbx, %rcx
180002197:     	callq	0x180001060 <.text+0x60>
18000219c:     	xorl	%esi, %esi
18000219e:     	jmp	0x18000204c <.text+0x104c>
1800021a3:     	cmpl	$-0x3, %ebp
1800021a6:     	je	0x1800021dd <.text+0x11dd>
1800021a8:     	cmpl	$-0x1, %ebp
1800021ab:     	je	0x18000219c <.text+0x119c>
1800021ad:     	movq	0xb0e4(%rip), %rcx      # 0x18000d298
1800021b4:     	leaq	0xb4b5(%rip), %rdx      # 0x18000d670
1800021bb:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800021c0:     	jmp	0x18000219c <.text+0x119c>
1800021c2:     	movq	0x10(%rbx), %r8
1800021c6:     	callq	0x180009c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6060>
1800021cb:     	movq	%rax, %rsi
1800021ce:     	testq	%rsi, %rsi
1800021d1:     	je	0x18000219c <.text+0x119c>
1800021d3:     	movq	%rsi, %rcx
1800021d6:     	callq	0x1800097c0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5c00>
1800021db:     	jmp	0x18000219c <.text+0x119c>
1800021dd:     	movq	0xb0ac(%rip), %rcx      # 0x18000d290
1800021e4:     	callq	0x18000b873 <numba_list_iter_next+0x353>
1800021e9:     	jmp	0x18000219c <.text+0x119c>
1800021eb:     	movq	0xb0be(%rip), %rcx      # 0x18000d2b0
1800021f2:     	leaq	0xb437(%rip), %rdx      # 0x18000d630
1800021f9:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800021fe:     	jmp	0x18000219c <.text+0x119c>
180002200:     	pushq	%r15
180002202:     	pushq	%r14
180002204:     	pushq	%r13
180002206:     	pushq	%r12
180002208:     	pushq	%rsi
180002209:     	pushq	%rdi
18000220a:     	pushq	%rbp
18000220b:     	pushq	%rbx
18000220c:     	subq	$0x148, %rsp            # imm = 0x148
180002213:     	movq	%r9, %r12
180002216:     	movq	%r8, %r13
180002219:     	movq	%rdx, 0x140(%rsp)
180002221:     	movq	%rcx, 0x138(%rsp)
180002229:     	movsd	0x278(%rsp), %xmm0
180002232:     	movsd	0x280(%rsp), %xmm1
18000223b:     	movq	$0x0, 0x130(%rsp)
180002247:     	movq	$0x0, 0x128(%rsp)
180002253:     	movq	0x220(%rsp), %rbp
18000225b:     	movq	0x228(%rsp), %r15
180002263:     	movq	0x230(%rsp), %r14
18000226b:     	movq	0x238(%rsp), %rbx
180002273:     	movq	0x240(%rsp), %rdi
18000227b:     	movq	0x248(%rsp), %rsi
180002283:     	movq	0x250(%rsp), %r11
18000228b:     	movq	0x258(%rsp), %r10
180002293:     	movq	0x260(%rsp), %r9
18000229b:     	movq	0x268(%rsp), %r8
1800022a3:     	movq	0x270(%rsp), %rdx
1800022ab:     	movq	0x288(%rsp), %rcx
1800022b3:     	movq	0x290(%rsp), %rax
1800022bb:     	movq	%rax, 0x110(%rsp)
1800022c3:     	movq	%rcx, 0x108(%rsp)
1800022cb:     	movq	%rdx, 0xf0(%rsp)
1800022d3:     	movq	%r8, 0xe8(%rsp)
1800022db:     	movq	%r9, 0xe0(%rsp)
1800022e3:     	movq	%r10, 0xd8(%rsp)
1800022eb:     	movq	%r11, 0xd0(%rsp)
1800022f3:     	movq	%rsi, 0xc8(%rsp)
1800022fb:     	movq	%rdi, 0xc0(%rsp)
180002303:     	movq	%rbx, 0xb8(%rsp)
18000230b:     	movq	%r14, 0xb0(%rsp)
180002313:     	movq	%r15, 0xa8(%rsp)
18000231b:     	movq	%rbp, 0xa0(%rsp)
180002323:     	movq	0x218(%rsp), %rax
18000232b:     	movq	%rax, 0x98(%rsp)
180002333:     	movq	0x210(%rsp), %rax
18000233b:     	movq	%rax, 0x90(%rsp)
180002343:     	movq	0x208(%rsp), %rax
18000234b:     	movq	%rax, 0x88(%rsp)
180002353:     	movq	0x200(%rsp), %rax
18000235b:     	movq	%rax, 0x80(%rsp)
180002363:     	movq	0x1f8(%rsp), %rax
18000236b:     	movq	%rax, 0x78(%rsp)
180002370:     	movq	0x1f0(%rsp), %rax
180002378:     	movq	%rax, 0x70(%rsp)
18000237d:     	movq	0x1e8(%rsp), %rax
180002385:     	movq	%rax, 0x68(%rsp)
18000238a:     	movq	0x1e0(%rsp), %rax
180002392:     	movq	%rax, 0x60(%rsp)
180002397:     	movq	0x1d8(%rsp), %rax
18000239f:     	movq	%rax, 0x58(%rsp)
1800023a4:     	movq	0x1d0(%rsp), %rax
1800023ac:     	movq	%rax, 0x50(%rsp)
1800023b1:     	movq	0x1c8(%rsp), %rax
1800023b9:     	movq	%rax, 0x48(%rsp)
1800023be:     	movq	0x1c0(%rsp), %rax
1800023c6:     	movq	%rax, 0x40(%rsp)
1800023cb:     	movq	0x1b8(%rsp), %rax
1800023d3:     	movq	%rax, 0x38(%rsp)
1800023d8:     	movq	0x1b0(%rsp), %rax
1800023e0:     	movq	%rax, 0x30(%rsp)
1800023e5:     	movsd	%xmm1, 0x100(%rsp)
1800023ee:     	movsd	%xmm0, 0xf8(%rsp)
1800023f7:     	movq	%r12, 0x28(%rsp)
1800023fc:     	movq	%r13, 0x20(%rsp)
180002401:     	leaq	0x130(%rsp), %rcx
180002409:     	leaq	0x128(%rsp), %rdx
180002411:     	movq	0x138(%rsp), %r8
180002419:     	movq	0x140(%rsp), %r9
180002421:     	callq	0x180001090 <.text+0x90>
180002426:     	movl	%eax, %edx
180002428:     	movq	0x128(%rsp), %rsi
180002430:     	movq	0x130(%rsp), %rax
180002438:     	movl	$0x0, 0x124(%rsp)
180002443:     	testl	%edx, %edx
180002445:     	jne	0x18000245b <.text+0x145b>
180002447:     	addq	$0x148, %rsp            # imm = 0x148
18000244e:     	popq	%rbx
18000244f:     	popq	%rbp
180002450:     	popq	%rdi
180002451:     	popq	%rsi
180002452:     	popq	%r12
180002454:     	popq	%r13
180002456:     	popq	%r14
180002458:     	popq	%r15
18000245a:     	retq
18000245b:     	movq	%rax, %rbx
18000245e:     	leaq	0x124(%rsp), %rcx
180002466:     	movl	%edx, %edi
180002468:     	callq	0x180009790 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bd0>
18000246d:     	testl	%edi, %edi
18000246f:     	jle	0x1800024b5 <.text+0x14b5>
180002471:     	callq	0x18000b861 <numba_list_iter_next+0x341>
180002476:     	movl	0x8(%rsi), %edx
180002479:     	movq	(%rsi), %rcx
18000247c:     	cmpl	$0x0, 0x20(%rsi)
180002480:     	jle	0x1800024d6 <.text+0x14d6>
180002482:     	movslq	%edx, %rdx
180002485:     	callq	0x18000b867 <numba_list_iter_next+0x347>
18000248a:     	movq	%rax, %rdi
18000248d:     	movq	0x10(%rsi), %rcx
180002491:     	callq	*0x18(%rsi)
180002494:     	testq	%rax, %rax
180002497:     	je	0x180002531 <.text+0x1531>
18000249d:     	movq	%rdi, %rcx
1800024a0:     	movq	%rax, %rdx
1800024a3:     	callq	0x180009d00 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6140>
1800024a8:     	movq	%rax, %rdi
1800024ab:     	movq	%rsi, %rcx
1800024ae:     	callq	0x18000b790 <numba_list_iter_next+0x270>
1800024b3:     	jmp	0x1800024e2 <.text+0x14e2>
1800024b5:     	movl	%edi, %eax
1800024b7:     	cmpl	$-0x3, %edi
1800024ba:     	je	0x180002523 <.text+0x1523>
1800024bc:     	cmpl	$-0x1, %eax
1800024bf:     	je	0x1800024ef <.text+0x14ef>
1800024c1:     	movq	0xadd0(%rip), %rcx      # 0x18000d298
1800024c8:     	leaq	0xb211(%rip), %rdx      # 0x18000d6e0
1800024cf:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800024d4:     	jmp	0x1800024ef <.text+0x14ef>
1800024d6:     	movq	0x10(%rsi), %r8
1800024da:     	callq	0x180009c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6060>
1800024df:     	movq	%rax, %rdi
1800024e2:     	testq	%rdi, %rdi
1800024e5:     	je	0x1800024ef <.text+0x14ef>
1800024e7:     	movq	%rdi, %rcx
1800024ea:     	callq	0x1800097c0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5c00>
1800024ef:     	leaq	0xb21a(%rip), %rcx      # 0x18000d710
1800024f6:     	callq	0x18000b879 <numba_list_iter_next+0x359>
1800024fb:     	movq	%rax, %rsi
1800024fe:     	movq	%rax, %rcx
180002501:     	callq	0x18000b87f <numba_list_iter_next+0x35f>
180002506:     	movq	%rsi, %rcx
180002509:     	callq	0x18000b843 <numba_list_iter_next+0x323>
18000250e:     	leaq	0x124(%rsp), %rcx
180002516:     	callq	0x1800097b0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bf0>
18000251b:     	movq	%rbx, %rax
18000251e:     	jmp	0x180002447 <.text+0x1447>
180002523:     	movq	0xad66(%rip), %rcx      # 0x18000d290
18000252a:     	callq	0x18000b873 <numba_list_iter_next+0x353>
18000252f:     	jmp	0x1800024ef <.text+0x14ef>
180002531:     	movq	0xad78(%rip), %rcx      # 0x18000d2b0
180002538:     	leaq	0xb161(%rip), %rdx      # 0x18000d6a0
18000253f:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180002544:     	xorl	%eax, %eax
180002546:     	jmp	0x180002447 <.text+0x1447>
18000254b:     	nopl	(%rax,%rax)
180002550:     	pushq	%r15
180002552:     	pushq	%r14
180002554:     	pushq	%r13
180002556:     	pushq	%r12
180002558:     	pushq	%rsi
180002559:     	pushq	%rdi
18000255a:     	pushq	%rbp
18000255b:     	pushq	%rbx
18000255c:     	subq	$0x1b8, %rsp            # imm = 0x1B8
180002563:     	movapd	%xmm7, 0x1a0(%rsp)
18000256c:     	movaps	%xmm6, 0x190(%rsp)
180002574:     	movq	0x308(%rsp), %r10
18000257c:     	movq	0x2d8(%rsp), %r15
180002584:     	movq	0x2a0(%rsp), %r14
18000258c:     	movabsq	$-0x20000000000001, %rax # imm = 0xFFDFFFFFFFFFFFFF
180002596:     	movabsq	$-0x40000000000001, %rsi # imm = 0xFFBFFFFFFFFFFFFF
1800025a0:     	movq	$0x0, 0x170(%rsp)
1800025ac:     	movb	$0x0, 0x178(%rsp)
1800025b4:     	movq	$0x0, 0x180(%rsp)
1800025c0:     	movb	$0x0, 0x188(%rsp)
1800025c8:     	movq	$0x0, 0x168(%rsp)
1800025d4:     	movb	$0x0, 0x127(%rsp)
1800025dc:     	movq	$0x0, 0x160(%rsp)
1800025e8:     	leaq	(%r10,%rax), %r11
1800025ec:     	cmpq	%rsi, %r11
1800025ef:     	jb	0x180002601 <.text+0x1601>
1800025f1:     	movq	0x310(%rsp), %r11
1800025f9:     	addq	%r11, %rax
1800025fc:     	cmpq	%rsi, %rax
1800025ff:     	jae	0x18000263a <.text+0x163a>
180002601:     	movb	$0x1, (%r15)
180002605:     	movq	$0x4, 0x18(%r14)
18000260d:     	movq	$0x0, (%rcx)
180002614:     	xorl	%eax, %eax
180002616:     	movaps	0x190(%rsp), %xmm6
18000261e:     	movaps	0x1a0(%rsp), %xmm7
180002626:     	addq	$0x1b8, %rsp            # imm = 0x1B8
18000262d:     	popq	%rbx
18000262e:     	popq	%rbp
18000262f:     	popq	%rdi
180002630:     	popq	%rsi
180002631:     	popq	%r12
180002633:     	popq	%r13
180002635:     	popq	%r14
180002637:     	popq	%r15
180002639:     	retq
18000263a:     	movq	0x270(%rsp), %r12
180002642:     	movq	(%r14), %rax
180002645:     	leaq	0x4(%rax), %rsi
180002649:     	cmpq	%r12, %rsi
18000264c:     	jle	0x180002654 <.text+0x1654>
18000264e:     	movb	$0x2, (%r15)
180002652:     	jmp	0x18000260d <.text+0x160d>
180002654:     	movq	%rsi, (%r14)
180002657:     	cmpb	$0x0, (%r15)
18000265b:     	jne	0x18000260d <.text+0x160d>
18000265d:     	movq	0x230(%rsp), %r13
180002665:     	testq	%rax, %rax
180002668:     	js	0x1800026ac <.text+0x16ac>
18000266a:     	cvtsi2sd	%r11, %xmm0
18000266f:     	movsd	0xad39(%rip), %xmm1     # 0x18000d3b0
180002677:     	mulsd	%xmm1, %xmm0
18000267b:     	cvtsi2sd	%r10, %xmm2
180002680:     	mulsd	%xmm1, %xmm2
180002684:     	movsd	%xmm2, 0x10(%r13,%rax,8)
18000268b:     	movsd	%xmm0, 0x18(%r13,%rax,8)
180002692:     	movsd	%xmm2, 0x8(%r13,%rax,8)
180002699:     	movsd	%xmm0, (%r13,%rax,8)
1800026a0:     	cmpb	$0x0, (%r15)
1800026a4:     	jne	0x18000260d <.text+0x160d>
1800026aa:     	jmp	0x1800026c2 <.text+0x16c2>
1800026ac:     	movb	$0x1, (%r15)
1800026b0:     	movq	$0xf4242, 0x18(%r14)    # imm = 0xF4242
1800026b8:     	cmpb	$0x0, (%r15)
1800026bc:     	jne	0x18000260d <.text+0x160d>
1800026c2:     	movq	(%r14), %rsi
1800026c5:     	leaq	0xb(%rsi), %r10
1800026c9:     	cmpq	%r12, %r10
1800026cc:     	jg	0x18000264e <.text+0x164e>
1800026ce:     	movq	%r10, (%r14)
1800026d1:     	cmpb	$0x0, (%r15)
1800026d5:     	jne	0x18000260d <.text+0x160d>
1800026db:     	movq	0x268(%rsp), %rbp
1800026e3:     	movq	%rax, (%rbp,%rsi,8)
1800026e8:     	movq	$0x4, 0x8(%rbp,%rsi,8)
1800026f1:     	movq	(%r14), %r10
1800026f4:     	cmpq	%r12, %r10
1800026f7:     	movq	%r10, %rax
1800026fa:     	jle	0x180002705 <.text+0x1705>
1800026fc:     	movb	$0x2, (%r15)
180002700:     	movq	(%r14), %r10
180002703:     	xorl	%eax, %eax
180002705:     	leaq	0x3(%r10), %r11
180002709:     	cmpq	%r12, %r11
18000270c:     	jg	0x18000264e <.text+0x164e>
180002712:     	movq	%r11, (%r14)
180002715:     	cmpb	$0x0, (%r15)
180002719:     	jne	0x18000260d <.text+0x160d>
18000271f:     	movq	%r10, %r11
180002722:     	sarq	$0x3f, %r11
180002726:     	andq	%r12, %r11
180002729:     	leaq	(%rbp,%r10,8), %rdi
18000272e:     	movq	$0x0, (%rdi,%r11,8)
180002736:     	xorl	%r11d, %r11d
180002739:     	cmpq	$-0x1, %r10
18000273d:     	movl	$0x0, %ebx
180002742:     	cmovlq	%r12, %rbx
180002746:     	movq	$0x0, 0x8(%rdi,%rbx,8)
18000274f:     	cmpq	$-0x2, %r10
180002753:     	cmovlq	%r12, %r11
180002757:     	movq	%rax, 0x10(%rdi,%r11,8)
18000275c:     	cmpb	$0x0, (%r15)
180002760:     	jne	0x18000260d <.text+0x160d>
180002766:     	leaq	(%rbp,%rsi,8), %rax
18000276b:     	movq	%r10, 0x30(%rax)
18000276f:     	movq	$0x0, 0x18(%rax)
180002777:     	movq	(%r14), %r10
18000277a:     	leaq	0x4(%r10), %r11
18000277e:     	cmpq	%r12, %r11
180002781:     	jg	0x18000264e <.text+0x164e>
180002787:     	movq	%r11, (%r14)
18000278a:     	cmpb	$0x0, (%r15)
18000278e:     	jne	0x18000260d <.text+0x160d>
180002794:     	movq	%r8, 0x158(%rsp)
18000279c:     	movq	%r9, 0x150(%rsp)
1800027a4:     	movq	%rdx, 0x148(%rsp)
1800027ac:     	movq	%rcx, 0x128(%rsp)
1800027b4:     	testq	%r10, %r10
1800027b7:     	js	0x1800027e0 <.text+0x17e0>
1800027b9:     	movq	$0x0, (%r13,%r10,8)
1800027c2:     	leaq	(%rbp,%r10,8), %rcx
1800027c7:     	movq	$0x1, 0x8(%rbp,%r10,8)
1800027d0:     	movq	$0x0, 0x10(%r13,%r10,8)
1800027d9:     	movl	$0x1, %edx
1800027de:     	jmp	0x1800027ec <.text+0x17ec>
1800027e0:     	movb	$0x1, (%r15)
1800027e4:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
1800027e9:     	movq	%r14, %rcx
1800027ec:     	movq	%rdx, 0x18(%rcx)
1800027f0:     	cmpb	$0x0, (%r15)
1800027f4:     	movq	0x128(%rsp), %rcx
1800027fc:     	jne	0x18000260d <.text+0x160d>
180002802:     	movq	%r10, 0x10(%rax)
180002806:     	movq	$0x0, 0x48(%r13,%rsi,8)
18000280f:     	movq	$0x1, 0x50(%rax)
180002817:     	movq	$-0x1, 0x20(%rax)
18000281f:     	movq	$-0x1, 0x28(%rax)
180002827:     	movq	$-0x1, 0x38(%rax)
18000282f:     	movq	$-0x1, 0x40(%rax)
180002837:     	cmpb	$0x0, (%r15)
18000283b:     	jne	0x18000260d <.text+0x160d>
180002841:     	movq	0x2f0(%rsp), %rax
180002849:     	movq	%rax, %rcx
18000284c:     	sarq	$0x3f, %rcx
180002850:     	andq	%r12, %rcx
180002853:     	xorl	%edx, %edx
180002855:     	cmpq	$-0x2, %rax
180002859:     	leaq	(%rbp,%rax,8), %rax
18000285e:     	cmovlq	%r12, %rdx
180002862:     	movq	%rdx, 0x140(%rsp)
18000286a:     	movq	%rcx, 0x138(%rsp)
180002872:     	movq	%rax, 0x130(%rsp)
18000287a:     	cmpq	$0x0, (%rax,%rcx,8)
18000287f:     	jle	0x180002aba <.text+0x1aba>
180002885:     	testq	%rsi, %rsi
180002888:     	js	0x180002d9a <.text+0x1d9a>
18000288e:     	movq	0x8(%r14), %rax
180002892:     	xorl	%edi, %edi
180002894:     	leaq	0x127(%rsp), %rbx
18000289c:     	movq	0x140(%rsp), %rcx
1800028a4:     	movq	0x130(%rsp), %rdx
1800028ac:     	movq	0x10(%rdx,%rcx,8), %rcx
1800028b1:     	addq	%rdi, %rcx
1800028b4:     	leaq	(%rbp,%rcx,8), %rdx
1800028b9:     	sarq	$0x3f, %rcx
1800028bd:     	andq	%r12, %rcx
1800028c0:     	movq	(%rdx,%rcx,8), %rcx
1800028c4:     	leaq	0x1(%rax), %rdx
1800028c8:     	movq	%rdx, 0x8(%r14)
1800028cc:     	cmpq	0x10(%r14), %rax
1800028d0:     	jge	0x180002d9a <.text+0x1d9a>
1800028d6:     	movq	%rcx, 0x100(%rsp)
1800028de:     	movq	%rsi, 0xf8(%rsp)
1800028e6:     	movq	0x2e8(%rsp), %rax
1800028ee:     	movq	%rax, 0xe8(%rsp)
1800028f6:     	movq	0x2e0(%rsp), %rax
1800028fe:     	movq	%rax, 0xe0(%rsp)
180002906:     	movq	%r15, 0xd8(%rsp)
18000290e:     	movq	0x2d0(%rsp), %rax
180002916:     	movq	%rax, 0xd0(%rsp)
18000291e:     	movq	0x2c8(%rsp), %rax
180002926:     	movq	%rax, 0xc8(%rsp)
18000292e:     	movq	0x2c0(%rsp), %rax
180002936:     	movq	%rax, 0xc0(%rsp)
18000293e:     	movq	0x2b8(%rsp), %rax
180002946:     	movq	%rax, 0xb8(%rsp)
18000294e:     	movq	0x2b0(%rsp), %rax
180002956:     	movq	%rax, 0xb0(%rsp)
18000295e:     	movq	0x2a8(%rsp), %rax
180002966:     	movq	%rax, 0xa8(%rsp)
18000296e:     	movq	%r14, 0xa0(%rsp)
180002976:     	movq	0x298(%rsp), %rax
18000297e:     	movq	%rax, 0x98(%rsp)
180002986:     	movq	0x290(%rsp), %rax
18000298e:     	movq	%rax, 0x90(%rsp)
180002996:     	movq	0x288(%rsp), %rax
18000299e:     	movq	%rax, 0x88(%rsp)
1800029a6:     	movq	0x280(%rsp), %rax
1800029ae:     	movq	%rax, 0x80(%rsp)
1800029b6:     	movq	0x278(%rsp), %rax
1800029be:     	movq	%rax, 0x78(%rsp)
1800029c3:     	movq	%r12, 0x70(%rsp)
1800029c8:     	movq	%rbp, 0x68(%rsp)
1800029cd:     	movq	0x260(%rsp), %rax
1800029d5:     	movq	%rax, 0x60(%rsp)
1800029da:     	movq	0x258(%rsp), %rax
1800029e2:     	movq	%rax, 0x58(%rsp)
1800029e7:     	movq	0x250(%rsp), %rax
1800029ef:     	movq	%rax, 0x50(%rsp)
1800029f4:     	movq	0x248(%rsp), %rax
1800029fc:     	movq	%rax, 0x48(%rsp)
180002a01:     	movq	0x240(%rsp), %rax
180002a09:     	movq	%rax, 0x40(%rsp)
180002a0e:     	movq	0x238(%rsp), %rax
180002a16:     	movq	%rax, 0x38(%rsp)
180002a1b:     	movq	%r13, 0x30(%rsp)
180002a20:     	movq	0x228(%rsp), %rax
180002a28:     	movq	%rax, 0x28(%rsp)
180002a2d:     	movq	0x220(%rsp), %rax
180002a35:     	movq	%rax, 0x20(%rsp)
180002a3a:     	movq	$-0x1, 0x108(%rsp)
180002a46:     	movq	$0x0, 0xf0(%rsp)
180002a52:     	movq	%rbx, %rcx
180002a55:     	leaq	0x160(%rsp), %rdx
180002a5d:     	movq	0x158(%rsp), %r8
180002a65:     	movq	0x150(%rsp), %r9
180002a6d:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180002a72:     	testl	%eax, %eax
180002a74:     	jne	0x180002fcf <.text+0x1fcf>
180002a7a:     	cmpb	$0x0, (%r15)
180002a7e:     	jne	0x180002da6 <.text+0x1da6>
180002a84:     	incq	%rdi
180002a87:     	movq	0x8(%r14), %rax
180002a8b:     	decq	%rax
180002a8e:     	movq	%rax, 0x8(%r14)
180002a92:     	movq	0x138(%rsp), %rcx
180002a9a:     	movq	0x130(%rsp), %rdx
180002aa2:     	cmpq	(%rdx,%rcx,8), %rdi
180002aa6:     	jl	0x18000289c <.text+0x189c>
180002aac:     	leaq	0x18(%r14), %rax
180002ab0:     	movq	%rax, 0x118(%rsp)
180002ab8:     	jmp	0x180002acf <.text+0x1acf>
180002aba:     	leaq	0x18(%r14), %rax
180002abe:     	movq	%rax, 0x118(%rsp)
180002ac6:     	testq	%rsi, %rsi
180002ac9:     	js	0x180002dba <.text+0x1dba>
180002acf:     	movsd	0x2f8(%rsp), %xmm6
180002ad8:     	xorl	%edi, %edi
180002ada:     	xorpd	%xmm7, %xmm7
180002ade:     	movq	0x138(%rsp), %rax
180002ae6:     	movq	0x130(%rsp), %rcx
180002aee:     	cmpq	(%rcx,%rax,8), %rdi
180002af2:     	jge	0x180002dba <.text+0x1dba>
180002af8:     	movq	0x140(%rsp), %rax
180002b00:     	movq	0x130(%rsp), %rcx
180002b08:     	movq	0x10(%rcx,%rax,8), %rax
180002b0d:     	addq	%rdi, %rax
180002b10:     	leaq	(%rbp,%rax,8), %rcx
180002b15:     	sarq	$0x3f, %rax
180002b19:     	andq	%r12, %rax
180002b1c:     	movq	(%rcx,%rax,8), %rbx
180002b20:     	movq	0x8(%r14), %rax
180002b24:     	leaq	0x1(%rax), %rcx
180002b28:     	movq	%rcx, 0x8(%r14)
180002b2c:     	cmpq	0x10(%r14), %rax
180002b30:     	jge	0x180002fff <.text+0x1fff>
180002b36:     	movsd	%xmm6, 0x100(%rsp)
180002b3f:     	movq	%rbx, 0xf8(%rsp)
180002b47:     	movq	%rsi, 0xf0(%rsp)
180002b4f:     	movq	0x2e8(%rsp), %rax
180002b57:     	movq	%rax, 0xe8(%rsp)
180002b5f:     	movq	0x2e0(%rsp), %rax
180002b67:     	movq	%rax, 0xe0(%rsp)
180002b6f:     	movq	%r15, 0xd8(%rsp)
180002b77:     	movq	0x2d0(%rsp), %rax
180002b7f:     	movq	%rax, 0xd0(%rsp)
180002b87:     	movq	0x2c8(%rsp), %rax
180002b8f:     	movq	%rax, 0xc8(%rsp)
180002b97:     	movq	0x2c0(%rsp), %rax
180002b9f:     	movq	%rax, 0xc0(%rsp)
180002ba7:     	movq	0x2b8(%rsp), %rax
180002baf:     	movq	%rax, 0xb8(%rsp)
180002bb7:     	movq	0x2b0(%rsp), %rax
180002bbf:     	movq	%rax, 0xb0(%rsp)
180002bc7:     	movq	0x2a8(%rsp), %rax
180002bcf:     	movq	%rax, 0xa8(%rsp)
180002bd7:     	movq	%r14, 0xa0(%rsp)
180002bdf:     	movq	0x298(%rsp), %rax
180002be7:     	movq	%rax, 0x98(%rsp)
180002bef:     	movq	0x290(%rsp), %rax
180002bf7:     	movq	%rax, 0x90(%rsp)
180002bff:     	movq	0x288(%rsp), %rax
180002c07:     	movq	%rax, 0x88(%rsp)
180002c0f:     	movq	0x280(%rsp), %rax
180002c17:     	movq	%rax, 0x80(%rsp)
180002c1f:     	movq	0x278(%rsp), %rax
180002c27:     	movq	%rax, 0x78(%rsp)
180002c2c:     	movq	%r12, 0x70(%rsp)
180002c31:     	movq	%rbp, 0x68(%rsp)
180002c36:     	movq	0x260(%rsp), %rax
180002c3e:     	movq	%rax, 0x60(%rsp)
180002c43:     	movq	0x258(%rsp), %rax
180002c4b:     	movq	%rax, 0x58(%rsp)
180002c50:     	movq	0x250(%rsp), %rax
180002c58:     	movq	%rax, 0x50(%rsp)
180002c5d:     	movq	0x248(%rsp), %rax
180002c65:     	movq	%rax, 0x48(%rsp)
180002c6a:     	movq	0x240(%rsp), %rax
180002c72:     	movq	%rax, 0x40(%rsp)
180002c77:     	movq	0x238(%rsp), %rax
180002c7f:     	movq	%rax, 0x38(%rsp)
180002c84:     	movq	%r13, 0x30(%rsp)
180002c89:     	movq	0x228(%rsp), %rax
180002c91:     	movq	%rax, 0x28(%rsp)
180002c96:     	movq	0x220(%rsp), %rax
180002c9e:     	movq	%rax, 0x20(%rsp)
180002ca3:     	leaq	0x170(%rsp), %rcx
180002cab:     	leaq	0x168(%rsp), %rdx
180002cb3:     	movq	0x158(%rsp), %r8
180002cbb:     	movq	0x150(%rsp), %r9
180002cc3:     	callq	0x180006840 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c80>
180002cc8:     	testl	%eax, %eax
180002cca:     	jne	0x18000302f <.text+0x202f>
180002cd0:     	cmpb	$0x0, (%r15)
180002cd4:     	jne	0x180002da6 <.text+0x1da6>
180002cda:     	movsd	0x170(%rsp), %xmm1
180002ce3:     	movsd	0x180(%rsp), %xmm0
180002cec:     	decq	0x8(%r14)
180002cf0:     	testq	%rbx, %rbx
180002cf3:     	js	0x180003017 <.text+0x2017>
180002cf9:     	movq	(%rbp,%rbx,8), %rax
180002cfe:     	testq	%rax, %rax
180002d01:     	js	0x180002d12 <.text+0x1d12>
180002d03:     	movsd	0x8(%r13,%rbx,8), %xmm2
180002d0a:     	ucomisd	%xmm7, %xmm2
180002d0e:     	jne	0x180002d34 <.text+0x1d34>
180002d10:     	jp	0x180002d34 <.text+0x1d34>
180002d12:     	movb	$0x1, (%r15)
180002d16:     	movq	0x118(%rsp), %rax
180002d1e:     	movq	$0x4c4b43, (%rax)       # imm = 0x4C4B43
180002d25:     	incq	%rdi
180002d28:     	cmpb	$0x0, (%r15)
180002d2c:     	je	0x180002ade <.text+0x1ade>
180002d32:     	jmp	0x180002da6 <.text+0x1da6>
180002d34:     	divsd	%xmm2, %xmm1
180002d38:     	addsd	(%r13,%rax,8), %xmm1
180002d3f:     	movsd	%xmm1, (%r13,%rax,8)
180002d46:     	movq	$0x0, 0x8(%rbp,%rax,8)
180002d4f:     	movq	(%rbp,%rbx,8), %rax
180002d54:     	testq	%rax, %rax
180002d57:     	js	0x180002d68 <.text+0x1d68>
180002d59:     	movsd	0x8(%r13,%rbx,8), %xmm1
180002d60:     	ucomisd	%xmm7, %xmm1
180002d64:     	jne	0x180002d7d <.text+0x1d7d>
180002d66:     	jp	0x180002d7d <.text+0x1d7d>
180002d68:     	movb	$0x1, (%r15)
180002d6c:     	movq	0x118(%rsp), %rax
180002d74:     	movq	$0x4c4b44, (%rax)       # imm = 0x4C4B44
180002d7b:     	jmp	0x180002d25 <.text+0x1d25>
180002d7d:     	divsd	%xmm1, %xmm0
180002d81:     	addsd	0x10(%r13,%rax,8), %xmm0
180002d88:     	movsd	%xmm0, 0x10(%r13,%rax,8)
180002d8f:     	movq	$0x0, 0x18(%rbp,%rax,8)
180002d98:     	jmp	0x180002d25 <.text+0x1d25>
180002d9a:     	movb	$0x1, (%r15)
180002d9e:     	movq	$0x9, 0x18(%r14)
180002da6:     	movq	0x128(%rsp), %rax
180002dae:     	movq	$0x0, (%rax)
180002db5:     	jmp	0x180002614 <.text+0x1614>
180002dba:     	movsd	0x300(%rsp), %xmm0
180002dc3:     	xorl	%eax, %eax
180002dc5:     	jmp	0x180002de3 <.text+0x1de3>
180002dc7:     	movb	$0x1, (%r15)
180002dcb:     	movq	0x118(%rsp), %rcx
180002dd3:     	movq	$0x5b8d83, (%rcx)       # imm = 0x5B8D83
180002dda:     	incq	%rax
180002ddd:     	cmpb	$0x0, (%r15)
180002de1:     	jne	0x180002da6 <.text+0x1da6>
180002de3:     	movq	0x138(%rsp), %rcx
180002deb:     	movq	0x130(%rsp), %rdx
180002df3:     	cmpq	(%rdx,%rcx,8), %rax
180002df7:     	jge	0x180002da6 <.text+0x1da6>
180002df9:     	movq	0x140(%rsp), %rcx
180002e01:     	movq	0x130(%rsp), %rdx
180002e09:     	movq	0x10(%rdx,%rcx,8), %rcx
180002e0e:     	addq	%rax, %rcx
180002e11:     	leaq	(%rbp,%rcx,8), %rdx
180002e16:     	sarq	$0x3f, %rcx
180002e1a:     	andq	%r12, %rcx
180002e1d:     	movq	(%rdx,%rcx,8), %rcx
180002e21:     	testq	%rcx, %rcx
180002e24:     	js	0x180002fe7 <.text+0x1fe7>
180002e2a:     	movq	0x18(%rbp,%rcx,8), %rdx
180002e2f:     	testq	%rdx, %rdx
180002e32:     	js	0x180002dc7 <.text+0x1dc7>
180002e34:     	movq	(%rbp,%rcx,8), %r8
180002e39:     	testq	%r8, %r8
180002e3c:     	js	0x180002dc7 <.text+0x1dc7>
180002e3e:     	movsd	(%r13,%r8,8), %xmm1
180002e45:     	mulsd	%xmm0, %xmm1
180002e49:     	addsd	(%r13,%rdx,8), %xmm1
180002e50:     	movsd	%xmm1, (%r13,%rdx,8)
180002e57:     	movq	$0x0, 0x8(%rbp,%rdx,8)
180002e60:     	movq	0x18(%rbp,%rcx,8), %rdx
180002e65:     	testq	%rdx, %rdx
180002e68:     	js	0x180002f57 <.text+0x1f57>
180002e6e:     	movq	(%rbp,%rcx,8), %r8
180002e73:     	testq	%r8, %r8
180002e76:     	js	0x180002f57 <.text+0x1f57>
180002e7c:     	movsd	0x10(%r13,%r8,8), %xmm1
180002e83:     	mulsd	%xmm0, %xmm1
180002e87:     	addsd	0x10(%r13,%rdx,8), %xmm1
180002e8e:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
180002e95:     	movq	$0x0, 0x18(%rbp,%rdx,8)
180002e9e:     	movq	0x10(%rbp,%rcx,8), %rdx
180002ea3:     	testq	%rdx, %rdx
180002ea6:     	js	0x180002f6f <.text+0x1f6f>
180002eac:     	movq	0x18(%rbp,%rcx,8), %r8
180002eb1:     	testq	%r8, %r8
180002eb4:     	js	0x180002f6f <.text+0x1f6f>
180002eba:     	movsd	(%r13,%r8,8), %xmm1
180002ec1:     	mulsd	%xmm0, %xmm1
180002ec5:     	addsd	(%r13,%rdx,8), %xmm1
180002ecc:     	movsd	%xmm1, (%r13,%rdx,8)
180002ed3:     	movq	$0x0, 0x8(%rbp,%rdx,8)
180002edc:     	movq	0x10(%rbp,%rcx,8), %rdx
180002ee1:     	testq	%rdx, %rdx
180002ee4:     	js	0x180002f87 <.text+0x1f87>
180002eea:     	movq	0x18(%rbp,%rcx,8), %r8
180002eef:     	testq	%r8, %r8
180002ef2:     	js	0x180002f87 <.text+0x1f87>
180002ef8:     	movsd	0x10(%r13,%r8,8), %xmm1
180002eff:     	mulsd	%xmm0, %xmm1
180002f03:     	addsd	0x10(%r13,%rdx,8), %xmm1
180002f0a:     	movsd	%xmm1, 0x10(%r13,%rdx,8)
180002f11:     	movq	$0x0, 0x18(%rbp,%rdx,8)
180002f1a:     	movq	(%rbp,%rcx,8), %rdx
180002f1f:     	testq	%rdx, %rdx
180002f22:     	js	0x180002f9f <.text+0x1f9f>
180002f24:     	movq	$0x0, (%r13,%rdx,8)
180002f2d:     	movq	$0x1, 0x8(%rbp,%rdx,8)
180002f36:     	movq	(%rbp,%rcx,8), %rcx
180002f3b:     	testq	%rcx, %rcx
180002f3e:     	js	0x180002fb7 <.text+0x1fb7>
180002f40:     	movq	$0x0, 0x10(%r13,%rcx,8)
180002f49:     	movq	$0x1, 0x18(%rbp,%rcx,8)
180002f52:     	jmp	0x180002dda <.text+0x1dda>
180002f57:     	movb	$0x1, (%r15)
180002f5b:     	movq	0x118(%rsp), %rcx
180002f63:     	movq	$0x5b8d84, (%rcx)       # imm = 0x5B8D84
180002f6a:     	jmp	0x180002dda <.text+0x1dda>
180002f6f:     	movb	$0x1, (%r15)
180002f73:     	movq	0x118(%rsp), %rcx
180002f7b:     	movq	$0x5b8d87, (%rcx)       # imm = 0x5B8D87
180002f82:     	jmp	0x180002dda <.text+0x1dda>
180002f87:     	movb	$0x1, (%r15)
180002f8b:     	movq	0x118(%rsp), %rcx
180002f93:     	movq	$0x5b8d88, (%rcx)       # imm = 0x5B8D88
180002f9a:     	jmp	0x180002dda <.text+0x1dda>
180002f9f:     	movb	$0x1, (%r15)
180002fa3:     	movq	0x118(%rsp), %rcx
180002fab:     	movq	$0x5b8d8b, (%rcx)       # imm = 0x5B8D8B
180002fb2:     	jmp	0x180002dda <.text+0x1dda>
180002fb7:     	movb	$0x1, (%r15)
180002fbb:     	movq	0x118(%rsp), %rcx
180002fc3:     	movq	$0x5b8d8c, (%rcx)       # imm = 0x5B8D8C
180002fca:     	jmp	0x180002dda <.text+0x1dda>
180002fcf:     	movq	0x160(%rsp), %rdx
180002fd7:     	movq	0x148(%rsp), %rcx
180002fdf:     	movq	%rdx, (%rcx)
180002fe2:     	jmp	0x180002616 <.text+0x1616>
180002fe7:     	movb	$0x1, (%r15)
180002feb:     	movq	0x118(%rsp), %rax
180002ff3:     	movq	$0x12, (%rax)
180002ffa:     	jmp	0x180002da6 <.text+0x1da6>
180002fff:     	movb	$0x1, (%r15)
180003003:     	movq	0x118(%rsp), %rax
18000300b:     	movq	$0xd, (%rax)
180003012:     	jmp	0x180002da6 <.text+0x1da6>
180003017:     	movb	$0x1, (%r15)
18000301b:     	movq	0x118(%rsp), %rax
180003023:     	movq	$0xe, (%rax)
18000302a:     	jmp	0x180002da6 <.text+0x1da6>
18000302f:     	movq	0x148(%rsp), %rcx
180003037:     	movq	$0x0, (%rcx)
18000303e:     	jmp	0x180002616 <.text+0x1616>
180003043:     	nopw	%cs:(%rax,%rax)
18000304d:     	nopl	(%rax)
180003050:     	pushq	%r15
180003052:     	pushq	%r14
180003054:     	pushq	%r13
180003056:     	pushq	%r12
180003058:     	pushq	%rsi
180003059:     	pushq	%rdi
18000305a:     	pushq	%rbp
18000305b:     	pushq	%rbx
18000305c:     	subq	$0x338, %rsp            # imm = 0x338
180003063:     	movaps	%xmm7, 0x320(%rsp)
18000306b:     	movaps	%xmm6, 0x310(%rsp)
180003073:     	movq	%rdx, %rcx
180003076:     	leaq	0x1c8(%rsp), %rax
18000307e:     	movq	%rax, 0x60(%rsp)
180003083:     	leaq	0x1d0(%rsp), %rax
18000308b:     	movq	%rax, 0x58(%rsp)
180003090:     	leaq	0x1d8(%rsp), %rax
180003098:     	movq	%rax, 0x50(%rsp)
18000309d:     	leaq	0x1e0(%rsp), %rax
1800030a5:     	movq	%rax, 0x48(%rsp)
1800030aa:     	leaq	0x1e8(%rsp), %rax
1800030b2:     	movq	%rax, 0x40(%rsp)
1800030b7:     	leaq	0x1f0(%rsp), %rax
1800030bf:     	movq	%rax, 0x38(%rsp)
1800030c4:     	leaq	0x1f8(%rsp), %rax
1800030cc:     	movq	%rax, 0x30(%rsp)
1800030d1:     	leaq	0x200(%rsp), %rax
1800030d9:     	movq	%rax, 0x28(%rsp)
1800030de:     	leaq	0x208(%rsp), %rax
1800030e6:     	movq	%rax, 0x20(%rsp)
1800030eb:     	leaq	0xa63e(%rip), %rdx      # 0x18000d730
1800030f2:     	movl	$0x9, %r8d
1800030f8:     	movl	$0x9, %r9d
1800030fe:     	callq	0x18000b831 <numba_list_iter_next+0x311>
180003103:     	testl	%eax, %eax
180003105:     	movq	$0x0, 0x130(%rsp)
180003111:     	je	0x18000380c <.text+0x280c>
180003117:     	cmpq	$0x0, 0x11ba9(%rip)     # 0x180014cc8
18000311f:     	je	0x180003734 <.text+0x2734>
180003125:     	movq	0x208(%rsp), %rcx
18000312d:     	xorps	%xmm0, %xmm0
180003130:     	movaps	%xmm0, 0x2d0(%rsp)
180003138:     	movaps	%xmm0, 0x2e0(%rsp)
180003140:     	movaps	%xmm0, 0x2f0(%rsp)
180003148:     	movq	$0x0, 0x300(%rsp)
180003154:     	leaq	0x2d0(%rsp), %rdx
18000315c:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180003161:     	testl	%eax, %eax
180003163:     	jne	0x18000374c <.text+0x274c>
180003169:     	cmpq	$0x8, 0x2e8(%rsp)
180003172:     	jne	0x18000374c <.text+0x274c>
180003178:     	movq	0x2d0(%rsp), %rbx
180003180:     	movq	0x2d8(%rsp), %rbp
180003188:     	movq	0x2e0(%rsp), %rsi
180003190:     	movq	0x2f0(%rsp), %rdi
180003198:     	movq	0x2f8(%rsp), %r15
1800031a0:     	movq	0x300(%rsp), %r13
1800031a8:     	movq	0x200(%rsp), %rcx
1800031b0:     	xorps	%xmm0, %xmm0
1800031b3:     	movaps	%xmm0, 0x290(%rsp)
1800031bb:     	movaps	%xmm0, 0x2a0(%rsp)
1800031c3:     	movaps	%xmm0, 0x2b0(%rsp)
1800031cb:     	movq	$0x0, 0x2c0(%rsp)
1800031d7:     	leaq	0x290(%rsp), %rdx
1800031df:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
1800031e4:     	testl	%eax, %eax
1800031e6:     	jne	0x180003764 <.text+0x2764>
1800031ec:     	cmpq	$0x8, 0x2a8(%rsp)
1800031f5:     	jne	0x180003764 <.text+0x2764>
1800031fb:     	movq	0x290(%rsp), %r12
180003203:     	movq	0x298(%rsp), %r14
18000320b:     	movq	0x2a0(%rsp), %rax
180003213:     	movq	%rax, 0x1c0(%rsp)
18000321b:     	movq	0x2b0(%rsp), %rax
180003223:     	movq	%rax, 0x1b8(%rsp)
18000322b:     	movq	0x2b8(%rsp), %rax
180003233:     	movq	%rax, 0x1b0(%rsp)
18000323b:     	movq	0x2c0(%rsp), %rax
180003243:     	movq	%rax, 0x1a8(%rsp)
18000324b:     	movq	0x1f8(%rsp), %rcx
180003253:     	xorps	%xmm0, %xmm0
180003256:     	movaps	%xmm0, 0x250(%rsp)
18000325e:     	movaps	%xmm0, 0x260(%rsp)
180003266:     	movaps	%xmm0, 0x270(%rsp)
18000326e:     	movq	$0x0, 0x280(%rsp)
18000327a:     	leaq	0x250(%rsp), %rdx
180003282:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
180003287:     	testl	%eax, %eax
180003289:     	jne	0x18000377c <.text+0x277c>
18000328f:     	cmpq	$0x8, 0x268(%rsp)
180003298:     	jne	0x18000377c <.text+0x277c>
18000329e:     	movq	%r14, 0x1a0(%rsp)
1800032a6:     	movq	0x250(%rsp), %r14
1800032ae:     	movq	0x258(%rsp), %rax
1800032b6:     	movq	%rax, 0x198(%rsp)
1800032be:     	movq	0x260(%rsp), %rax
1800032c6:     	movq	%rax, 0x190(%rsp)
1800032ce:     	movq	0x270(%rsp), %rax
1800032d6:     	movq	%rax, 0x188(%rsp)
1800032de:     	movq	0x278(%rsp), %rax
1800032e6:     	movq	%rax, 0x180(%rsp)
1800032ee:     	movq	0x280(%rsp), %rax
1800032f6:     	movq	%rax, 0x178(%rsp)
1800032fe:     	movq	0x1f0(%rsp), %rcx
180003306:     	xorps	%xmm0, %xmm0
180003309:     	movaps	%xmm0, 0x210(%rsp)
180003311:     	movaps	%xmm0, 0x220(%rsp)
180003319:     	movaps	%xmm0, 0x230(%rsp)
180003321:     	movq	$0x0, 0x240(%rsp)
18000332d:     	leaq	0x210(%rsp), %rdx
180003335:     	callq	0x18000a4f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6930>
18000333a:     	testl	%eax, %eax
18000333c:     	jne	0x180003791 <.text+0x2791>
180003342:     	cmpq	$0x1, 0x228(%rsp)
18000334b:     	jne	0x180003791 <.text+0x2791>
180003351:     	movq	%r13, 0x150(%rsp)
180003359:     	movq	%r15, 0x158(%rsp)
180003361:     	movq	%rdi, 0x160(%rsp)
180003369:     	movq	%rsi, 0x168(%rsp)
180003371:     	movq	0x210(%rsp), %r15
180003379:     	movq	0x218(%rsp), %rax
180003381:     	movq	%rax, 0x148(%rsp)
180003389:     	movq	0x220(%rsp), %rax
180003391:     	movq	%rax, 0x140(%rsp)
180003399:     	movq	0x230(%rsp), %rax
1800033a1:     	movq	%rax, 0x138(%rsp)
1800033a9:     	movq	0x238(%rsp), %rdi
1800033b1:     	movq	0x240(%rsp), %rsi
1800033b9:     	movq	0x1e8(%rsp), %rcx
1800033c1:     	callq	0x18000b837 <numba_list_iter_next+0x317>
1800033c6:     	testq	%rax, %rax
1800033c9:     	movq	%rbx, 0x128(%rsp)
1800033d1:     	movq	%r12, 0x120(%rsp)
1800033d9:     	movq	%rbp, 0x170(%rsp)
1800033e1:     	je	0x1800037a6 <.text+0x27a6>
1800033e7:     	movq	%rax, %r13
1800033ea:     	movq	%rax, %rcx
1800033ed:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
1800033f2:     	movq	%rax, %r12
1800033f5:     	movq	%r13, %rcx
1800033f8:     	callq	0x18000b843 <numba_list_iter_next+0x323>
1800033fd:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180003402:     	testq	%rax, %rax
180003405:     	jne	0x1800037dc <.text+0x27dc>
18000340b:     	movq	0x1e0(%rsp), %rcx
180003413:     	callq	0x18000b84f <numba_list_iter_next+0x32f>
180003418:     	movq	%rax, %rbx
18000341b:     	movq	%rax, %rcx
18000341e:     	callq	0x18000b855 <numba_list_iter_next+0x335>
180003423:     	movaps	%xmm0, %xmm6
180003426:     	movq	%rbx, %rcx
180003429:     	callq	0x18000b843 <numba_list_iter_next+0x323>
18000342e:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180003433:     	testq	%rax, %rax
180003436:     	jne	0x1800037dc <.text+0x27dc>
18000343c:     	movq	0x1d8(%rsp), %rcx
180003444:     	callq	0x18000b84f <numba_list_iter_next+0x32f>
180003449:     	movq	%rax, %rbx
18000344c:     	movq	%rax, %rcx
18000344f:     	callq	0x18000b855 <numba_list_iter_next+0x335>
180003454:     	movaps	%xmm0, %xmm7
180003457:     	movq	%rbx, %rcx
18000345a:     	callq	0x18000b843 <numba_list_iter_next+0x323>
18000345f:     	callq	0x18000b849 <numba_list_iter_next+0x329>
180003464:     	testq	%rax, %rax
180003467:     	jne	0x1800037dc <.text+0x27dc>
18000346d:     	movq	0x1d0(%rsp), %rcx
180003475:     	callq	0x18000b837 <numba_list_iter_next+0x317>
18000347a:     	testq	%rax, %rax
18000347d:     	je	0x1800037b9 <.text+0x27b9>
180003483:     	movq	%rax, %rbp
180003486:     	movq	%rax, %rcx
180003489:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
18000348e:     	movq	%rax, %r13
180003491:     	movq	%rbp, %rcx
180003494:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180003499:     	callq	0x18000b849 <numba_list_iter_next+0x329>
18000349e:     	testq	%rax, %rax
1800034a1:     	jne	0x1800037dc <.text+0x27dc>
1800034a7:     	movq	0x1c8(%rsp), %rcx
1800034af:     	callq	0x18000b837 <numba_list_iter_next+0x317>
1800034b4:     	testq	%rax, %rax
1800034b7:     	je	0x1800037cc <.text+0x27cc>
1800034bd:     	movq	%rax, %rbx
1800034c0:     	movq	%rax, %rcx
1800034c3:     	callq	0x18000b83d <numba_list_iter_next+0x31d>
1800034c8:     	movq	%rax, %rbp
1800034cb:     	movq	%rbx, %rcx
1800034ce:     	callq	0x18000b843 <numba_list_iter_next+0x323>
1800034d3:     	callq	0x18000b849 <numba_list_iter_next+0x329>
1800034d8:     	testq	%rax, %rax
1800034db:     	jne	0x1800037dc <.text+0x27dc>
1800034e1:     	movq	%rbp, 0x110(%rsp)
1800034e9:     	movq	%r13, 0x108(%rsp)
1800034f1:     	movq	%r12, 0xf0(%rsp)
1800034f9:     	movq	%rsi, 0xe8(%rsp)
180003501:     	movq	%rdi, 0xe0(%rsp)
180003509:     	movq	0x138(%rsp), %rax
180003511:     	movq	%rax, 0xd8(%rsp)
180003519:     	movq	0x140(%rsp), %rax
180003521:     	movq	%rax, 0xc8(%rsp)
180003529:     	movq	0x148(%rsp), %rax
180003531:     	movq	%rax, 0xc0(%rsp)
180003539:     	movq	0x178(%rsp), %rax
180003541:     	movq	%rax, 0xb0(%rsp)
180003549:     	movq	0x180(%rsp), %rax
180003551:     	movq	%rax, 0xa8(%rsp)
180003559:     	movq	0x188(%rsp), %rax
180003561:     	movq	%rax, 0xa0(%rsp)
180003569:     	movq	0x190(%rsp), %rax
180003571:     	movq	%rax, 0x90(%rsp)
180003579:     	movq	0x198(%rsp), %rax
180003581:     	movq	%rax, 0x88(%rsp)
180003589:     	movq	0x1a8(%rsp), %rax
180003591:     	movq	%rax, 0x78(%rsp)
180003596:     	movq	0x1b0(%rsp), %rax
18000359e:     	movq	%rax, 0x70(%rsp)
1800035a3:     	movq	0x1b8(%rsp), %rax
1800035ab:     	movq	%rax, 0x68(%rsp)
1800035b0:     	movq	0x1c0(%rsp), %rax
1800035b8:     	movq	%rax, 0x58(%rsp)
1800035bd:     	movq	0x1a0(%rsp), %rax
1800035c5:     	movq	%rax, 0x50(%rsp)
1800035ca:     	movq	0x150(%rsp), %rax
1800035d2:     	movq	%rax, 0x40(%rsp)
1800035d7:     	movq	0x158(%rsp), %rax
1800035df:     	movq	%rax, 0x38(%rsp)
1800035e4:     	movsd	%xmm7, 0x100(%rsp)
1800035ed:     	movsd	%xmm6, 0xf8(%rsp)
1800035f6:     	movq	%r15, 0xb8(%rsp)
1800035fe:     	movq	%r14, 0x80(%rsp)
180003606:     	movq	0x120(%rsp), %rdi
18000360e:     	movq	%rdi, 0x48(%rsp)
180003613:     	movq	0x160(%rsp), %rax
18000361b:     	movq	%rax, 0x30(%rsp)
180003620:     	movq	0x168(%rsp), %rax
180003628:     	movq	%rax, 0x20(%rsp)
18000362d:     	movq	$0x1, 0xd0(%rsp)
180003639:     	movq	$0x8, 0x98(%rsp)
180003645:     	movq	$0x8, 0x60(%rsp)
18000364e:     	movq	$0x8, 0x28(%rsp)
180003657:     	leaq	0x308(%rsp), %rcx
18000365f:     	leaq	0x130(%rsp), %rdx
180003667:     	movq	0x170(%rsp), %r9
18000366f:     	movq	0x128(%rsp), %rsi
180003677:     	movq	%rsi, %r8
18000367a:     	callq	0x180002550 <.text+0x1550>
18000367f:     	movl	%eax, %ebp
180003681:     	movq	0x130(%rsp), %rbx
180003689:     	movq	%rsi, %rcx
18000368c:     	callq	0x180001060 <.text+0x60>
180003691:     	movq	%rdi, %rcx
180003694:     	callq	0x180001060 <.text+0x60>
180003699:     	movq	%r14, %rcx
18000369c:     	callq	0x180001060 <.text+0x60>
1800036a1:     	movq	%r15, %rcx
1800036a4:     	callq	0x180001060 <.text+0x60>
1800036a9:     	testl	%ebp, %ebp
1800036ab:     	jne	0x1800036e3 <.text+0x26e3>
1800036ad:     	movq	0x9c1c(%rip), %rsi      # 0x18000d2d0
1800036b4:     	movq	%rsi, %rcx
1800036b7:     	callq	0x18000b85b <numba_list_iter_next+0x33b>
1800036bc:     	movq	%rsi, %rax
1800036bf:     	movaps	0x310(%rsp), %xmm6
1800036c7:     	movaps	0x320(%rsp), %xmm7
1800036cf:     	addq	$0x338, %rsp            # imm = 0x338
1800036d6:     	popq	%rbx
1800036d7:     	popq	%rbp
1800036d8:     	popq	%rdi
1800036d9:     	popq	%rsi
1800036da:     	popq	%r12
1800036dc:     	popq	%r13
1800036de:     	popq	%r14
1800036e0:     	popq	%r15
1800036e2:     	retq
1800036e3:     	jle	0x180003813 <.text+0x2813>
1800036e9:     	callq	0x18000b861 <numba_list_iter_next+0x341>
1800036ee:     	movl	0x8(%rbx), %edx
1800036f1:     	movq	(%rbx), %rcx
1800036f4:     	cmpl	$0x0, 0x20(%rbx)
1800036f8:     	jle	0x180003832 <.text+0x2832>
1800036fe:     	movslq	%edx, %rdx
180003701:     	callq	0x18000b867 <numba_list_iter_next+0x347>
180003706:     	movq	%rax, %rsi
180003709:     	movq	0x10(%rbx), %rcx
18000370d:     	callq	*0x18(%rbx)
180003710:     	testq	%rax, %rax
180003713:     	je	0x18000385b <.text+0x285b>
180003719:     	movq	%rsi, %rcx
18000371c:     	movq	%rax, %rdx
18000371f:     	callq	0x180009d00 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6140>
180003724:     	movq	%rax, %rsi
180003727:     	movq	%rbx, %rcx
18000372a:     	callq	0x18000b790 <numba_list_iter_next+0x270>
18000372f:     	jmp	0x18000383e <.text+0x283e>
180003734:     	movq	0x9b75(%rip), %rcx      # 0x18000d2b0
18000373b:     	leaq	0xa00e(%rip), %rdx      # 0x18000d750
180003742:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180003747:     	jmp	0x18000380c <.text+0x280c>
18000374c:     	movq	0x9b4d(%rip), %rcx      # 0x18000d2a0
180003753:     	leaq	0xa0f6(%rip), %rdx      # 0x18000d850
18000375a:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
18000375f:     	jmp	0x18000380c <.text+0x280c>
180003764:     	movq	0x9b35(%rip), %rcx      # 0x18000d2a0
18000376b:     	leaq	0xa0de(%rip), %rdx      # 0x18000d850
180003772:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180003777:     	jmp	0x180003804 <.text+0x2804>
18000377c:     	movq	0x9b1d(%rip), %rcx      # 0x18000d2a0
180003783:     	leaq	0xa0c6(%rip), %rdx      # 0x18000d850
18000378a:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
18000378f:     	jmp	0x1800037fc <.text+0x27fc>
180003791:     	movq	0x9b08(%rip), %rcx      # 0x18000d2a0
180003798:     	leaq	0xa0b1(%rip), %rdx      # 0x18000d850
18000379f:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
1800037a4:     	jmp	0x1800037f4 <.text+0x27f4>
1800037a6:     	xorl	%r12d, %r12d
1800037a9:     	callq	0x18000b849 <numba_list_iter_next+0x329>
1800037ae:     	testq	%rax, %rax
1800037b1:     	je	0x18000340b <.text+0x240b>
1800037b7:     	jmp	0x1800037dc <.text+0x27dc>
1800037b9:     	xorl	%r13d, %r13d
1800037bc:     	callq	0x18000b849 <numba_list_iter_next+0x329>
1800037c1:     	testq	%rax, %rax
1800037c4:     	je	0x1800034a7 <.text+0x24a7>
1800037ca:     	jmp	0x1800037dc <.text+0x27dc>
1800037cc:     	xorl	%ebp, %ebp
1800037ce:     	callq	0x18000b849 <numba_list_iter_next+0x329>
1800037d3:     	testq	%rax, %rax
1800037d6:     	je	0x1800034e1 <.text+0x24e1>
1800037dc:     	movq	%r15, %rcx
1800037df:     	callq	0x180001060 <.text+0x60>
1800037e4:     	movq	0x128(%rsp), %rbx
1800037ec:     	movq	0x120(%rsp), %r12
1800037f4:     	movq	%r14, %rcx
1800037f7:     	callq	0x180001060 <.text+0x60>
1800037fc:     	movq	%r12, %rcx
1800037ff:     	callq	0x180001060 <.text+0x60>
180003804:     	movq	%rbx, %rcx
180003807:     	callq	0x180001060 <.text+0x60>
18000380c:     	xorl	%esi, %esi
18000380e:     	jmp	0x1800036bc <.text+0x26bc>
180003813:     	cmpl	$-0x3, %ebp
180003816:     	je	0x18000384d <.text+0x284d>
180003818:     	cmpl	$-0x1, %ebp
18000381b:     	je	0x18000380c <.text+0x280c>
18000381d:     	movq	0x9a74(%rip), %rcx      # 0x18000d298
180003824:     	leaq	0xa0c5(%rip), %rdx      # 0x18000d8f0
18000382b:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180003830:     	jmp	0x18000380c <.text+0x280c>
180003832:     	movq	0x10(%rbx), %r8
180003836:     	callq	0x180009c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6060>
18000383b:     	movq	%rax, %rsi
18000383e:     	testq	%rsi, %rsi
180003841:     	je	0x18000380c <.text+0x280c>
180003843:     	movq	%rsi, %rcx
180003846:     	callq	0x1800097c0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5c00>
18000384b:     	jmp	0x18000380c <.text+0x280c>
18000384d:     	movq	0x9a3c(%rip), %rcx      # 0x18000d290
180003854:     	callq	0x18000b873 <numba_list_iter_next+0x353>
180003859:     	jmp	0x18000380c <.text+0x280c>
18000385b:     	movq	0x9a4e(%rip), %rcx      # 0x18000d2b0
180003862:     	leaq	0xa047(%rip), %rdx      # 0x18000d8b0
180003869:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
18000386e:     	jmp	0x18000380c <.text+0x280c>
180003870:     	pushq	%r15
180003872:     	pushq	%r14
180003874:     	pushq	%r13
180003876:     	pushq	%r12
180003878:     	pushq	%rsi
180003879:     	pushq	%rdi
18000387a:     	pushq	%rbp
18000387b:     	pushq	%rbx
18000387c:     	subq	$0x148, %rsp            # imm = 0x148
180003883:     	movq	%r9, %r12
180003886:     	movq	%r8, %r13
180003889:     	movq	%rdx, 0x140(%rsp)
180003891:     	movq	%rcx, 0x138(%rsp)
180003899:     	movsd	0x278(%rsp), %xmm0
1800038a2:     	movsd	0x280(%rsp), %xmm1
1800038ab:     	movq	$0x0, 0x130(%rsp)
1800038b7:     	movq	$0x0, 0x128(%rsp)
1800038c3:     	movq	0x220(%rsp), %rbp
1800038cb:     	movq	0x228(%rsp), %r15
1800038d3:     	movq	0x230(%rsp), %r14
1800038db:     	movq	0x238(%rsp), %rbx
1800038e3:     	movq	0x240(%rsp), %rdi
1800038eb:     	movq	0x248(%rsp), %rsi
1800038f3:     	movq	0x250(%rsp), %r11
1800038fb:     	movq	0x258(%rsp), %r10
180003903:     	movq	0x260(%rsp), %r9
18000390b:     	movq	0x268(%rsp), %r8
180003913:     	movq	0x270(%rsp), %rdx
18000391b:     	movq	0x288(%rsp), %rcx
180003923:     	movq	0x290(%rsp), %rax
18000392b:     	movq	%rax, 0x110(%rsp)
180003933:     	movq	%rcx, 0x108(%rsp)
18000393b:     	movq	%rdx, 0xf0(%rsp)
180003943:     	movq	%r8, 0xe8(%rsp)
18000394b:     	movq	%r9, 0xe0(%rsp)
180003953:     	movq	%r10, 0xd8(%rsp)
18000395b:     	movq	%r11, 0xd0(%rsp)
180003963:     	movq	%rsi, 0xc8(%rsp)
18000396b:     	movq	%rdi, 0xc0(%rsp)
180003973:     	movq	%rbx, 0xb8(%rsp)
18000397b:     	movq	%r14, 0xb0(%rsp)
180003983:     	movq	%r15, 0xa8(%rsp)
18000398b:     	movq	%rbp, 0xa0(%rsp)
180003993:     	movq	0x218(%rsp), %rax
18000399b:     	movq	%rax, 0x98(%rsp)
1800039a3:     	movq	0x210(%rsp), %rax
1800039ab:     	movq	%rax, 0x90(%rsp)
1800039b3:     	movq	0x208(%rsp), %rax
1800039bb:     	movq	%rax, 0x88(%rsp)
1800039c3:     	movq	0x200(%rsp), %rax
1800039cb:     	movq	%rax, 0x80(%rsp)
1800039d3:     	movq	0x1f8(%rsp), %rax
1800039db:     	movq	%rax, 0x78(%rsp)
1800039e0:     	movq	0x1f0(%rsp), %rax
1800039e8:     	movq	%rax, 0x70(%rsp)
1800039ed:     	movq	0x1e8(%rsp), %rax
1800039f5:     	movq	%rax, 0x68(%rsp)
1800039fa:     	movq	0x1e0(%rsp), %rax
180003a02:     	movq	%rax, 0x60(%rsp)
180003a07:     	movq	0x1d8(%rsp), %rax
180003a0f:     	movq	%rax, 0x58(%rsp)
180003a14:     	movq	0x1d0(%rsp), %rax
180003a1c:     	movq	%rax, 0x50(%rsp)
180003a21:     	movq	0x1c8(%rsp), %rax
180003a29:     	movq	%rax, 0x48(%rsp)
180003a2e:     	movq	0x1c0(%rsp), %rax
180003a36:     	movq	%rax, 0x40(%rsp)
180003a3b:     	movq	0x1b8(%rsp), %rax
180003a43:     	movq	%rax, 0x38(%rsp)
180003a48:     	movq	0x1b0(%rsp), %rax
180003a50:     	movq	%rax, 0x30(%rsp)
180003a55:     	movsd	%xmm1, 0x100(%rsp)
180003a5e:     	movsd	%xmm0, 0xf8(%rsp)
180003a67:     	movq	%r12, 0x28(%rsp)
180003a6c:     	movq	%r13, 0x20(%rsp)
180003a71:     	leaq	0x130(%rsp), %rcx
180003a79:     	leaq	0x128(%rsp), %rdx
180003a81:     	movq	0x138(%rsp), %r8
180003a89:     	movq	0x140(%rsp), %r9
180003a91:     	callq	0x180002550 <.text+0x1550>
180003a96:     	movl	%eax, %edx
180003a98:     	movq	0x128(%rsp), %rsi
180003aa0:     	movq	0x130(%rsp), %rax
180003aa8:     	movl	$0x0, 0x124(%rsp)
180003ab3:     	testl	%edx, %edx
180003ab5:     	jne	0x180003acb <.text+0x2acb>
180003ab7:     	addq	$0x148, %rsp            # imm = 0x148
180003abe:     	popq	%rbx
180003abf:     	popq	%rbp
180003ac0:     	popq	%rdi
180003ac1:     	popq	%rsi
180003ac2:     	popq	%r12
180003ac4:     	popq	%r13
180003ac6:     	popq	%r14
180003ac8:     	popq	%r15
180003aca:     	retq
180003acb:     	movq	%rax, %rbx
180003ace:     	leaq	0x124(%rsp), %rcx
180003ad6:     	movl	%edx, %edi
180003ad8:     	callq	0x180009790 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bd0>
180003add:     	testl	%edi, %edi
180003adf:     	jle	0x180003b25 <.text+0x2b25>
180003ae1:     	callq	0x18000b861 <numba_list_iter_next+0x341>
180003ae6:     	movl	0x8(%rsi), %edx
180003ae9:     	movq	(%rsi), %rcx
180003aec:     	cmpl	$0x0, 0x20(%rsi)
180003af0:     	jle	0x180003b46 <.text+0x2b46>
180003af2:     	movslq	%edx, %rdx
180003af5:     	callq	0x18000b867 <numba_list_iter_next+0x347>
180003afa:     	movq	%rax, %rdi
180003afd:     	movq	0x10(%rsi), %rcx
180003b01:     	callq	*0x18(%rsi)
180003b04:     	testq	%rax, %rax
180003b07:     	je	0x180003ba1 <.text+0x2ba1>
180003b0d:     	movq	%rdi, %rcx
180003b10:     	movq	%rax, %rdx
180003b13:     	callq	0x180009d00 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6140>
180003b18:     	movq	%rax, %rdi
180003b1b:     	movq	%rsi, %rcx
180003b1e:     	callq	0x18000b790 <numba_list_iter_next+0x270>
180003b23:     	jmp	0x180003b52 <.text+0x2b52>
180003b25:     	movl	%edi, %eax
180003b27:     	cmpl	$-0x3, %edi
180003b2a:     	je	0x180003b93 <.text+0x2b93>
180003b2c:     	cmpl	$-0x1, %eax
180003b2f:     	je	0x180003b5f <.text+0x2b5f>
180003b31:     	movq	0x9760(%rip), %rcx      # 0x18000d298
180003b38:     	leaq	0x9e21(%rip), %rdx      # 0x18000d960
180003b3f:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180003b44:     	jmp	0x180003b5f <.text+0x2b5f>
180003b46:     	movq	0x10(%rsi), %r8
180003b4a:     	callq	0x180009c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6060>
180003b4f:     	movq	%rax, %rdi
180003b52:     	testq	%rdi, %rdi
180003b55:     	je	0x180003b5f <.text+0x2b5f>
180003b57:     	movq	%rdi, %rcx
180003b5a:     	callq	0x1800097c0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5c00>
180003b5f:     	leaq	0x9e2a(%rip), %rcx      # 0x18000d990
180003b66:     	callq	0x18000b879 <numba_list_iter_next+0x359>
180003b6b:     	movq	%rax, %rsi
180003b6e:     	movq	%rax, %rcx
180003b71:     	callq	0x18000b87f <numba_list_iter_next+0x35f>
180003b76:     	movq	%rsi, %rcx
180003b79:     	callq	0x18000b843 <numba_list_iter_next+0x323>
180003b7e:     	leaq	0x124(%rsp), %rcx
180003b86:     	callq	0x1800097b0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bf0>
180003b8b:     	movq	%rbx, %rax
180003b8e:     	jmp	0x180003ab7 <.text+0x2ab7>
180003b93:     	movq	0x96f6(%rip), %rcx      # 0x18000d290
180003b9a:     	callq	0x18000b873 <numba_list_iter_next+0x353>
180003b9f:     	jmp	0x180003b5f <.text+0x2b5f>
180003ba1:     	movq	0x9708(%rip), %rcx      # 0x18000d2b0
180003ba8:     	leaq	0x9d71(%rip), %rdx      # 0x18000d920
180003baf:     	callq	0x18000b86d <numba_list_iter_next+0x34d>
180003bb4:     	xorl	%eax, %eax
180003bb6:     	jmp	0x180003ab7 <.text+0x2ab7>
180003bbb:     	nopl	(%rax,%rax)

0000000180003bc0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1>:
180003bc0:     	pushq	%rsi
180003bc1:     	subq	$0x20, %rsp
180003bc5:     	leaq	0x10494(%rip), %rcx     # 0x180014060
180003bcc:     	movl	$0x3f5, %edx            # imm = 0x3F5
180003bd1:     	callq	0x18000b885 <numba_list_iter_next+0x365>
180003bd6:     	testq	%rax, %rax
180003bd9:     	je	0x180003c0b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b>
180003bdb:     	leaq	0x1041e(%rip), %rdx     # 0x180014000
180003be2:     	leaq	0x9e17(%rip), %r8       # 0x18000da00
180003be9:     	leaq	0x9f00(%rip), %r9       # 0x18000daf0
180003bf0:     	movq	%rax, %rcx
180003bf3:     	movq	%rax, %rsi
180003bf6:     	callq	0x18000a760 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ba0>
180003bfb:     	movl	%eax, %ecx
180003bfd:     	xorl	%eax, %eax
180003bff:     	testl	%ecx, %ecx
180003c01:     	cmoveq	%rsi, %rax
180003c05:     	addq	$0x20, %rsp
180003c09:     	popq	%rsi
180003c0a:     	retq
180003c0b:     	xorl	%eax, %eax
180003c0d:     	addq	$0x20, %rsp
180003c11:     	popq	%rsi
180003c12:     	retq
180003c13:     	nopw	%cs:(%rax,%rax)
180003c1d:     	nopl	(%rax)
180003c20:     	pushq	%r15
180003c22:     	pushq	%r14
180003c24:     	pushq	%r13
180003c26:     	pushq	%r12
180003c28:     	pushq	%rsi
180003c29:     	pushq	%rdi
180003c2a:     	pushq	%rbp
180003c2b:     	pushq	%rbx
180003c2c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180003c33:     	movapd	%xmm8, 0x1d0(%rsp)
180003c3d:     	movapd	%xmm7, 0x1c0(%rsp)
180003c46:     	movapd	%xmm6, 0x1b0(%rsp)
180003c4f:     	movq	0x320(%rsp), %r13
180003c57:     	movq	0x260(%rsp), %rdi
180003c5f:     	movq	$0x0, 0x150(%rsp)
180003c6b:     	movb	$0x0, 0x158(%rsp)
180003c73:     	movq	$0x0, 0x160(%rsp)
180003c7f:     	movq	$0x0, 0x130(%rsp)
180003c8b:     	movb	$0x0, 0x138(%rsp)
180003c93:     	movq	$0x0, 0x140(%rsp)
180003c9f:     	movsd	0x48(%rdi,%r13,8), %xmm0
180003ca6:     	xorpd	%xmm1, %xmm1
180003caa:     	ucomisd	%xmm1, %xmm0
180003cae:     	jne	0x180003cc7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x107>
180003cb0:     	jp	0x180003cc7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x107>
180003cb2:     	movb	$0x1, 0x18(%rcx)
180003cb6:     	movq	$0x0, 0x10(%rcx)
180003cbe:     	movb	$0x1, 0x8(%rcx)
180003cc2:     	jmp	0x180003eda <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x31a>
180003cc7:     	movq	0x328(%rsp), %r12
180003ccf:     	movq	0x2a0(%rsp), %r15
180003cd7:     	movq	0x298(%rsp), %r14
180003cdf:     	movq	0x30(%r14,%r13,8), %rax
180003ce4:     	movq	%rax, %r10
180003ce7:     	sarq	$0x3f, %r10
180003ceb:     	andq	%r15, %r10
180003cee:     	leaq	(%r14,%rax,8), %rdx
180003cf2:     	cmpq	$0x1, (%rdx,%r10,8)
180003cf7:     	jne	0x180003d1a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x15a>
180003cf9:     	xorl	%r10d, %r10d
180003cfc:     	cmpq	$-0x2, %rax
180003d00:     	cmovlq	%r15, %r10
180003d04:     	movq	0x10(%rdx,%r10,8), %rax
180003d09:     	leaq	(%r14,%rax,8), %rdx
180003d0d:     	sarq	$0x3f, %rax
180003d11:     	andq	%r15, %rax
180003d14:     	cmpq	%r12, (%rdx,%rax,8)
180003d18:     	je	0x180003cb2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xf2>
180003d1a:     	movq	0x308(%rsp), %rbx
180003d22:     	movq	0x2d0(%rsp), %rsi
180003d2a:     	movq	0x10(%r14,%r13,8), %r10
180003d2f:     	movsd	(%rdi,%r10,8), %xmm1
180003d35:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003d3b:     	setne	%r11b
180003d3f:     	movq	0x10(%r14,%r12,8), %rdx
180003d44:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d4a:     	setne	%al
180003d4d:     	subsd	(%rdi,%rdx,8), %xmm1
180003d52:     	andb	%r11b, %al
180003d55:     	cmpb	$0x1, %al
180003d57:     	jne	0x180003d7b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1bb>
180003d59:     	movapd	0x965f(%rip), %xmm2     # 0x18000d3c0
180003d61:     	andpd	%xmm1, %xmm2
180003d65:     	ucomisd	0x9663(%rip), %xmm2     # 0x18000d3d0
180003d6d:     	jae	0x180003e21 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x261>
180003d73:     	xorpd	%xmm2, %xmm2
180003d77:     	addsd	%xmm2, %xmm1
180003d7b:     	movsd	0x10(%rdi,%r10,8), %xmm2
180003d82:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d88:     	subsd	0x10(%rdi,%rdx,8), %xmm2
180003d8e:     	je	0x180003df8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x238>
180003d90:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d96:     	je	0x180003df8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x238>
180003d98:     	movapd	0x9620(%rip), %xmm3     # 0x18000d3c0
180003da0:     	andpd	%xmm2, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	jae	0x180003e65 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2a5>
180003db2:     	movapd	%xmm1, %xmm3
180003db6:     	mulsd	%xmm1, %xmm3
180003dba:     	ucomisd	0x960e(%rip), %xmm3     # 0x18000d3d0
180003dc2:     	setae	%dl
180003dc5:     	testb	%dl, %al
180003dc7:     	jne	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003dc9:     	xorpd	%xmm4, %xmm4
180003dcd:     	addsd	%xmm4, %xmm2
180003dd1:     	movapd	%xmm2, %xmm4
180003dd5:     	mulsd	%xmm2, %xmm4
180003dd9:     	ucomisd	0x95ef(%rip), %xmm4     # 0x18000d3d0
180003de1:     	jae	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003de3:     	addsd	%xmm4, %xmm3
180003de7:     	ucomisd	0x95e1(%rip), %xmm3     # 0x18000d3d0
180003def:     	setae	%dl
180003df2:     	testb	%dl, %al
180003df4:     	jne	0x180003e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x251>
180003df6:     	jmp	0x180003e3d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x27d>
180003df8:     	movapd	%xmm1, %xmm3
180003dfc:     	mulsd	%xmm1, %xmm3
180003e00:     	ucomisd	0x95c8(%rip), %xmm3     # 0x18000d3d0
180003e08:     	setae	%dl
180003e0b:     	andb	%dl, %al
180003e0d:     	cmpb	$0x1, %al
180003e0f:     	jne	0x180003e31 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x271>
180003e11:     	movb	$0x1, (%rbx)
180003e14:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003e1c:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e21:     	movb	$0x1, (%rbx)
180003e24:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003e2c:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e31:     	movapd	%xmm2, %xmm4
180003e35:     	mulsd	%xmm2, %xmm4
180003e39:     	addsd	%xmm4, %xmm3
180003e3d:     	xorps	%xmm4, %xmm4
180003e40:     	sqrtsd	%xmm3, %xmm4
180003e44:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e4a:     	je	0x180003e97 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d7>
180003e4c:     	xorpd	%xmm5, %xmm5
180003e50:     	ucomisd	%xmm5, %xmm3
180003e54:     	jne	0x180003e72 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2b2>
180003e56:     	jp	0x180003e72 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2b2>
180003e58:     	movb	$0x1, (%rbx)
180003e5b:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e63:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e65:     	movb	$0x1, (%rbx)
180003e68:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e70:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180003e72:     	movsd	0x330(%rsp), %xmm6
180003e7b:     	movq	(%r14,%r13,8), %rax
180003e7f:     	movsd	0x8(%rdi,%rax,8), %xmm3
180003e85:     	addsd	%xmm3, %xmm3
180003e89:     	divsd	%xmm4, %xmm3
180003e8d:     	ucomisd	%xmm3, %xmm6
180003e91:     	jbe	0x180003f4a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38a>
180003e97:     	movsd	0x9539(%rip), %xmm3     # 0x18000d3d8
180003e9f:     	maxsd	%xmm4, %xmm3
180003ea3:     	movapd	%xmm3, %xmm4
180003ea7:     	mulsd	%xmm3, %xmm4
180003eab:     	xorpd	%xmm5, %xmm5
180003eaf:     	ucomisd	%xmm5, %xmm4
180003eb3:     	jne	0x180003f10 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x350>
180003eb5:     	jp	0x180003f10 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x350>
180003eb7:     	movb	$0x1, (%rbx)
180003eba:     	movq	$0x3d0915, 0x18(%rsi)   # imm = 0x3D0915
180003ec2:     	movq	$0x0, 0x18(%rcx)
180003eca:     	movq	$0x0, 0x10(%rcx)
180003ed2:     	movq	$0x0, 0x8(%rcx)
180003eda:     	movq	$0x0, (%rcx)
180003ee1:     	xorl	%eax, %eax
180003ee3:     	movaps	0x1b0(%rsp), %xmm6
180003eeb:     	movaps	0x1c0(%rsp), %xmm7
180003ef3:     	movaps	0x1d0(%rsp), %xmm8
180003efc:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180003f03:     	popq	%rbx
180003f04:     	popq	%rbp
180003f05:     	popq	%rdi
180003f06:     	popq	%rsi
180003f07:     	popq	%r12
180003f09:     	popq	%r13
180003f0b:     	popq	%r14
180003f0d:     	popq	%r15
180003f0f:     	retq
180003f10:     	movsd	0x8(%rdi,%r12,8), %xmm5
180003f17:     	mulsd	0x94c1(%rip), %xmm5     # 0x18000d3e0
180003f1f:     	mulsd	%xmm5, %xmm0
180003f23:     	divsd	%xmm4, %xmm0
180003f27:     	mulsd	%xmm0, %xmm1
180003f2b:     	divsd	%xmm3, %xmm1
180003f2f:     	mulsd	%xmm0, %xmm2
180003f33:     	divsd	%xmm3, %xmm2
180003f37:     	movsd	%xmm2, 0x10(%rcx)
180003f3c:     	movsd	%xmm1, (%rcx)
180003f40:     	movb	$0x0, 0x18(%rcx)
180003f44:     	movb	$0x0, 0x8(%rcx)
180003f48:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180003f4a:     	movq	0x318(%rsp), %rdx
180003f52:     	movq	0x2e0(%rsp), %rbp
180003f5a:     	movq	0x2c8(%rsp), %r11
180003f62:     	movq	0x20(%r14,%r13,8), %rax
180003f67:     	testq	%rax, %rax
180003f6a:     	js	0x180004176 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b6>
180003f70:     	movq	0x8(%rsi), %rdx
180003f74:     	leaq	0x1(%rdx), %r10
180003f78:     	movq	%r10, 0x8(%rsi)
180003f7c:     	cmpq	0x10(%rsi), %rdx
180003f80:     	jge	0x180004588 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9c8>
180003f86:     	movq	%rcx, 0x118(%rsp)
180003f8e:     	movsd	%xmm6, 0x100(%rsp)
180003f97:     	movq	%r12, 0xf8(%rsp)
180003f9f:     	movq	%rax, 0xf0(%rsp)
180003fa7:     	movq	0x318(%rsp), %rax
180003faf:     	movq	%rax, 0xe8(%rsp)
180003fb7:     	movq	0x310(%rsp), %rax
180003fbf:     	movq	%rax, 0xe0(%rsp)
180003fc7:     	movq	%rbx, 0xd8(%rsp)
180003fcf:     	movq	0x300(%rsp), %rax
180003fd7:     	movq	%rax, 0xd0(%rsp)
180003fdf:     	movq	0x2f8(%rsp), %rax
180003fe7:     	movq	%rax, 0xc8(%rsp)
180003fef:     	movq	0x2f0(%rsp), %rax
180003ff7:     	movq	%rax, 0xc0(%rsp)
180003fff:     	movq	0x2e8(%rsp), %rax
180004007:     	movq	%rax, 0xb8(%rsp)
18000400f:     	movq	%rbp, 0xb0(%rsp)
180004017:     	movq	0x2d8(%rsp), %rax
18000401f:     	movq	%rax, 0xa8(%rsp)
180004027:     	movq	%rsi, 0xa0(%rsp)
18000402f:     	movq	%r11, 0x98(%rsp)
180004037:     	movq	0x2c0(%rsp), %rax
18000403f:     	movq	%rax, 0x90(%rsp)
180004047:     	movq	0x2b8(%rsp), %rax
18000404f:     	movq	%rax, 0x88(%rsp)
180004057:     	movq	0x2b0(%rsp), %rax
18000405f:     	movq	%rax, 0x80(%rsp)
180004067:     	movq	0x2a8(%rsp), %rax
18000406f:     	movq	%rax, 0x78(%rsp)
180004074:     	movq	%r15, 0x70(%rsp)
180004079:     	movq	%r14, 0x68(%rsp)
18000407e:     	movq	0x290(%rsp), %rax
180004086:     	movq	%rax, 0x60(%rsp)
18000408b:     	movq	0x288(%rsp), %rax
180004093:     	movq	%rax, 0x58(%rsp)
180004098:     	movq	0x280(%rsp), %rax
1800040a0:     	movq	%rax, 0x50(%rsp)
1800040a5:     	movq	0x278(%rsp), %rax
1800040ad:     	movq	%rax, 0x48(%rsp)
1800040b2:     	movq	0x270(%rsp), %rax
1800040ba:     	movq	%rax, 0x40(%rsp)
1800040bf:     	movq	0x268(%rsp), %rax
1800040c7:     	movq	%rax, 0x38(%rsp)
1800040cc:     	movq	%rdi, 0x30(%rsp)
1800040d1:     	movq	0x258(%rsp), %rax
1800040d9:     	movq	%rax, 0x28(%rsp)
1800040de:     	movq	0x250(%rsp), %rax
1800040e6:     	movq	%rax, 0x20(%rsp)
1800040eb:     	leaq	0x190(%rsp), %rcx
1800040f3:     	movq	%r8, 0x120(%rsp)
1800040fb:     	movq	%r9, %rbp
1800040fe:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004103:     	cmpb	$0x0, (%rbx)
180004106:     	jne	0x18000455c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x99c>
18000410c:     	cmpb	$0x0, 0x1a8(%rsp)
180004114:     	setne	0x117(%rsp)
18000411c:     	cmpb	$0x0, 0x198(%rsp)
180004124:     	setne	%r10b
180004128:     	xorpd	%xmm8, %xmm8
18000412d:     	movsd	0x190(%rsp), %xmm7
180004136:     	addsd	%xmm8, %xmm7
18000413b:     	addsd	0x1a0(%rsp), %xmm8
180004145:     	decq	0x8(%rsi)
180004149:     	movq	0x118(%rsp), %rcx
180004151:     	movq	%rbp, %r9
180004154:     	movq	0x120(%rsp), %r8
18000415c:     	movq	0x2c8(%rsp), %r11
180004164:     	movq	0x2e0(%rsp), %rbp
18000416c:     	movq	0x318(%rsp), %rdx
180004174:     	jmp	0x18000418a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ca>
180004176:     	movb	$0x1, %r10b
180004179:     	xorpd	%xmm7, %xmm7
18000417d:     	xorpd	%xmm8, %xmm8
180004182:     	movb	$0x1, 0x117(%rsp)
18000418a:     	movq	0x28(%r14,%r13,8), %rax
18000418f:     	testq	%rax, %rax
180004192:     	js	0x1800043a9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7e9>
180004198:     	movb	%r10b, 0x116(%rsp)
1800041a0:     	movq	0x8(%rsi), %rdx
1800041a4:     	leaq	0x1(%rdx), %r10
1800041a8:     	movq	%r10, 0x8(%rsi)
1800041ac:     	cmpq	0x10(%rsi), %rdx
1800041b0:     	jge	0x180004598 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9d8>
1800041b6:     	movq	%rcx, 0x118(%rsp)
1800041be:     	movsd	%xmm6, 0x100(%rsp)
1800041c7:     	movq	%r12, 0xf8(%rsp)
1800041cf:     	movq	%rax, 0xf0(%rsp)
1800041d7:     	movq	0x318(%rsp), %rax
1800041df:     	movq	%rax, 0xe8(%rsp)
1800041e7:     	movq	0x310(%rsp), %rax
1800041ef:     	movq	%rax, 0xe0(%rsp)
1800041f7:     	movq	%rbx, 0xd8(%rsp)
1800041ff:     	movq	0x300(%rsp), %rax
180004207:     	movq	%rax, 0xd0(%rsp)
18000420f:     	movq	0x2f8(%rsp), %rax
180004217:     	movq	%rax, 0xc8(%rsp)
18000421f:     	movq	0x2f0(%rsp), %rax
180004227:     	movq	%rax, 0xc0(%rsp)
18000422f:     	movq	0x2e8(%rsp), %rax
180004237:     	movq	%rax, 0xb8(%rsp)
18000423f:     	movq	%rbp, 0xb0(%rsp)
180004247:     	movq	0x2d8(%rsp), %rax
18000424f:     	movq	%rax, 0xa8(%rsp)
180004257:     	movq	%rsi, 0xa0(%rsp)
18000425f:     	movq	%r11, 0x98(%rsp)
180004267:     	movq	0x2c0(%rsp), %rax
18000426f:     	movq	%rax, 0x90(%rsp)
180004277:     	movq	0x2b8(%rsp), %rax
18000427f:     	movq	%rax, 0x88(%rsp)
180004287:     	movq	0x2b0(%rsp), %rax
18000428f:     	movq	%rax, 0x80(%rsp)
180004297:     	movq	0x2a8(%rsp), %rax
18000429f:     	movq	%rax, 0x78(%rsp)
1800042a4:     	movq	%r15, 0x70(%rsp)
1800042a9:     	movq	%r14, 0x68(%rsp)
1800042ae:     	movq	0x290(%rsp), %rax
1800042b6:     	movq	%rax, 0x60(%rsp)
1800042bb:     	movq	0x288(%rsp), %rax
1800042c3:     	movq	%rax, 0x58(%rsp)
1800042c8:     	movq	0x280(%rsp), %rax
1800042d0:     	movq	%rax, 0x50(%rsp)
1800042d5:     	movq	0x278(%rsp), %rax
1800042dd:     	movq	%rax, 0x48(%rsp)
1800042e2:     	movq	0x270(%rsp), %rax
1800042ea:     	movq	%rax, 0x40(%rsp)
1800042ef:     	movq	0x268(%rsp), %rax
1800042f7:     	movq	%rax, 0x38(%rsp)
1800042fc:     	movq	%rdi, 0x30(%rsp)
180004301:     	movq	0x258(%rsp), %rax
180004309:     	movq	%rax, 0x28(%rsp)
18000430e:     	movq	0x250(%rsp), %rax
180004316:     	movq	%rax, 0x20(%rsp)
18000431b:     	leaq	0x170(%rsp), %rcx
180004323:     	movq	%r8, 0x120(%rsp)
18000432b:     	movq	%r9, 0x128(%rsp)
180004333:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004338:     	cmpb	$0x0, (%rbx)
18000433b:     	jne	0x18000455c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x99c>
180004341:     	cmpb	$0x0, 0x188(%rsp)
180004349:     	setne	%al
18000434c:     	cmpb	$0x0, 0x178(%rsp)
180004354:     	setne	%cl
180004357:     	addsd	0x170(%rsp), %xmm7
180004360:     	addsd	0x180(%rsp), %xmm8
18000436a:     	decq	0x8(%rsi)
18000436e:     	movzbl	0x116(%rsp), %r10d
180004377:     	andb	%cl, %r10b
18000437a:     	andb	%al, 0x117(%rsp)
180004381:     	movq	0x118(%rsp), %rcx
180004389:     	movq	0x128(%rsp), %r9
180004391:     	movq	0x120(%rsp), %r8
180004399:     	movq	0x2c8(%rsp), %r11
1800043a1:     	movq	0x318(%rsp), %rdx
1800043a9:     	movq	0x38(%r14,%r13,8), %rax
1800043ae:     	testq	%rax, %rax
1800043b1:     	js	0x180004620 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xa60>
1800043b7:     	movb	%r10b, 0x116(%rsp)
1800043bf:     	movq	0x8(%rsi), %rdx
1800043c3:     	leaq	0x1(%rdx), %r10
1800043c7:     	movq	%r10, 0x8(%rsi)
1800043cb:     	cmpq	0x10(%rsi), %rdx
1800043cf:     	jge	0x1800045a8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9e8>
1800043d5:     	movq	%rcx, 0x118(%rsp)
1800043dd:     	movsd	%xmm6, 0x100(%rsp)
1800043e6:     	movq	%r12, 0xf8(%rsp)
1800043ee:     	movq	%rax, 0xf0(%rsp)
1800043f6:     	movq	0x318(%rsp), %rax
1800043fe:     	movq	%rax, 0xe8(%rsp)
180004406:     	movq	0x310(%rsp), %rax
18000440e:     	movq	%rax, 0xe0(%rsp)
180004416:     	movq	%rbx, 0xd8(%rsp)
18000441e:     	movq	0x300(%rsp), %rax
180004426:     	movq	%rax, 0xd0(%rsp)
18000442e:     	movq	0x2f8(%rsp), %rax
180004436:     	movq	%rax, 0xc8(%rsp)
18000443e:     	movq	0x2f0(%rsp), %rax
180004446:     	movq	%rax, 0xc0(%rsp)
18000444e:     	movq	0x2e8(%rsp), %rax
180004456:     	movq	%rax, 0xb8(%rsp)
18000445e:     	movq	%rbp, 0xb0(%rsp)
180004466:     	movq	0x2d8(%rsp), %rax
18000446e:     	movq	%rax, 0xa8(%rsp)
180004476:     	movq	%rsi, 0xa0(%rsp)
18000447e:     	movq	%r11, 0x98(%rsp)
180004486:     	movq	0x2c0(%rsp), %rax
18000448e:     	movq	%rax, 0x90(%rsp)
180004496:     	movq	0x2b8(%rsp), %rax
18000449e:     	movq	%rax, 0x88(%rsp)
1800044a6:     	movq	0x2b0(%rsp), %rax
1800044ae:     	movq	%rax, 0x80(%rsp)
1800044b6:     	movq	0x2a8(%rsp), %rax
1800044be:     	movq	%rax, 0x78(%rsp)
1800044c3:     	movq	%r15, 0x70(%rsp)
1800044c8:     	movq	%r14, 0x68(%rsp)
1800044cd:     	movq	0x290(%rsp), %rax
1800044d5:     	movq	%rax, 0x60(%rsp)
1800044da:     	movq	0x288(%rsp), %rax
1800044e2:     	movq	%rax, 0x58(%rsp)
1800044e7:     	movq	0x280(%rsp), %rax
1800044ef:     	movq	%rax, 0x50(%rsp)
1800044f4:     	movq	0x278(%rsp), %rax
1800044fc:     	movq	%rax, 0x48(%rsp)
180004501:     	movq	0x270(%rsp), %rax
180004509:     	movq	%rax, 0x40(%rsp)
18000450e:     	movq	0x268(%rsp), %rax
180004516:     	movq	%rax, 0x38(%rsp)
18000451b:     	movq	%rdi, 0x30(%rsp)
180004520:     	movq	0x258(%rsp), %rax
180004528:     	movq	%rax, 0x28(%rsp)
18000452d:     	movq	0x250(%rsp), %rax
180004535:     	movq	%rax, 0x20(%rsp)
18000453a:     	leaq	0x150(%rsp), %rcx
180004542:     	movq	%r8, 0x120(%rsp)
18000454a:     	movq	%r9, 0x128(%rsp)
180004552:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
180004557:     	cmpb	$0x0, (%rbx)
18000455a:     	je	0x1800045b8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x9f8>
18000455c:     	movq	0x118(%rsp), %rax
180004564:     	movq	$0x0, 0x18(%rax)
18000456c:     	movq	$0x0, 0x10(%rax)
180004574:     	movq	$0x0, 0x8(%rax)
18000457c:     	movq	$0x0, (%rax)
180004583:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180004588:     	movb	$0x1, (%rbx)
18000458b:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004593:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180004598:     	movb	$0x1, (%rbx)
18000459b:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
1800045a3:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
1800045a8:     	movb	$0x1, (%rbx)
1800045ab:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800045b3:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
1800045b8:     	cmpb	$0x0, 0x168(%rsp)
1800045c0:     	setne	%al
1800045c3:     	cmpb	$0x0, 0x158(%rsp)
1800045cb:     	setne	%cl
1800045ce:     	addsd	0x150(%rsp), %xmm7
1800045d7:     	addsd	0x160(%rsp), %xmm8
1800045e1:     	decq	0x8(%rsi)
1800045e5:     	movzbl	0x116(%rsp), %r10d
1800045ee:     	andb	%cl, %r10b
1800045f1:     	andb	%al, 0x117(%rsp)
1800045f8:     	movq	0x118(%rsp), %rcx
180004600:     	movq	0x128(%rsp), %r9
180004608:     	movq	0x120(%rsp), %r8
180004610:     	movq	0x2c8(%rsp), %r11
180004618:     	movq	0x318(%rsp), %rdx
180004620:     	movq	0x40(%r14,%r13,8), %rax
180004625:     	testq	%rax, %rax
180004628:     	js	0x1800047eb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc2b>
18000462e:     	movb	%r10b, 0x116(%rsp)
180004636:     	movq	%rdx, %r13
180004639:     	movq	0x8(%rsi), %rdx
18000463d:     	leaq	0x1(%rdx), %r10
180004641:     	movq	%r10, 0x8(%rsi)
180004645:     	cmpq	0x10(%rsi), %rdx
180004649:     	jge	0x1800047f5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc35>
18000464f:     	movq	%rcx, 0x118(%rsp)
180004657:     	movq	%r12, 0xf8(%rsp)
18000465f:     	movq	%rax, 0xf0(%rsp)
180004667:     	movq	%r13, 0xe8(%rsp)
18000466f:     	movq	0x310(%rsp), %rax
180004677:     	movq	%rax, 0xe0(%rsp)
18000467f:     	movq	0x300(%rsp), %rax
180004687:     	movq	%rax, 0xd0(%rsp)
18000468f:     	movq	0x2f8(%rsp), %rax
180004697:     	movq	%rax, 0xc8(%rsp)
18000469f:     	movq	0x2f0(%rsp), %rax
1800046a7:     	movq	%rax, 0xc0(%rsp)
1800046af:     	movq	0x2e8(%rsp), %rax
1800046b7:     	movq	%rax, 0xb8(%rsp)
1800046bf:     	movq	%rbp, 0xb0(%rsp)
1800046c7:     	movq	0x2d8(%rsp), %rax
1800046cf:     	movq	%rax, 0xa8(%rsp)
1800046d7:     	movq	%r11, 0x98(%rsp)
1800046df:     	movq	0x2c0(%rsp), %rax
1800046e7:     	movq	%rax, 0x90(%rsp)
1800046ef:     	movq	0x2b8(%rsp), %rax
1800046f7:     	movq	%rax, 0x88(%rsp)
1800046ff:     	movq	0x2b0(%rsp), %rax
180004707:     	movq	%rax, 0x80(%rsp)
18000470f:     	movq	0x2a8(%rsp), %rax
180004717:     	movq	%rax, 0x78(%rsp)
18000471c:     	movq	%r15, 0x70(%rsp)
180004721:     	movq	%r14, 0x68(%rsp)
180004726:     	movq	0x290(%rsp), %rax
18000472e:     	movq	%rax, 0x60(%rsp)
180004733:     	movq	0x288(%rsp), %rax
18000473b:     	movq	%rax, 0x58(%rsp)
180004740:     	movq	0x280(%rsp), %rax
180004748:     	movq	%rax, 0x50(%rsp)
18000474d:     	movq	0x278(%rsp), %rax
180004755:     	movq	%rax, 0x48(%rsp)
18000475a:     	movq	0x270(%rsp), %rax
180004762:     	movq	%rax, 0x40(%rsp)
180004767:     	movq	0x268(%rsp), %rax
18000476f:     	movq	%rax, 0x38(%rsp)
180004774:     	movq	%rdi, 0x30(%rsp)
180004779:     	movq	0x258(%rsp), %rax
180004781:     	movq	%rax, 0x28(%rsp)
180004786:     	movsd	%xmm6, 0x100(%rsp)
18000478f:     	movq	%rbx, 0xd8(%rsp)
180004797:     	movq	%rsi, 0xa0(%rsp)
18000479f:     	movq	0x250(%rsp), %rax
1800047a7:     	movq	%rax, 0x20(%rsp)
1800047ac:     	leaq	0x130(%rsp), %rcx
1800047b4:     	callq	0x180003c20 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60>
1800047b9:     	cmpb	$0x0, (%rbx)
1800047bc:     	je	0x180004805 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc45>
1800047be:     	movq	0x118(%rsp), %r13
1800047c6:     	movq	$0x0, 0x18(%r13)
1800047ce:     	movq	$0x0, 0x10(%r13)
1800047d6:     	movq	$0x0, 0x8(%r13)
1800047de:     	movq	$0x0, (%r13)
1800047e6:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
1800047eb:     	movzbl	0x117(%rsp), %eax
1800047f3:     	jmp	0x180004852 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xc92>
1800047f5:     	movb	$0x1, (%rbx)
1800047f8:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
180004800:     	jmp	0x180003ec2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x302>
180004805:     	cmpb	$0x0, 0x148(%rsp)
18000480d:     	setne	%al
180004810:     	cmpb	$0x0, 0x138(%rsp)
180004818:     	setne	%cl
18000481b:     	addsd	0x130(%rsp), %xmm7
180004824:     	addsd	0x140(%rsp), %xmm8
18000482e:     	decq	0x8(%rsi)
180004832:     	movzbl	0x116(%rsp), %r10d
18000483b:     	andb	%cl, %r10b
18000483e:     	movzbl	0x117(%rsp), %ecx
180004846:     	andb	%al, %cl
180004848:     	movl	%ecx, %eax
18000484a:     	movq	0x118(%rsp), %rcx
180004852:     	movb	%al, 0x18(%rcx)
180004855:     	movsd	%xmm8, 0x10(%rcx)
18000485b:     	movb	%r10b, 0x8(%rcx)
18000485f:     	movsd	%xmm7, (%rcx)
180004863:     	jmp	0x180003ee1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x321>
180004868:     	nopl	(%rax,%rax)
180004870:     	pushq	%r15
180004872:     	pushq	%r14
180004874:     	pushq	%r13
180004876:     	pushq	%r12
180004878:     	pushq	%rsi
180004879:     	pushq	%rdi
18000487a:     	pushq	%rbp
18000487b:     	pushq	%rbx
18000487c:     	subq	$0x178, %rsp            # imm = 0x178
180004883:     	movq	0x2b0(%rsp), %rax
18000488b:     	movq	0x298(%rsp), %r13
180004893:     	movq	0x260(%rsp), %rbp
18000489b:     	movq	0x258(%rsp), %rdi
1800048a3:     	movb	$0x0, 0x137(%rsp)
1800048ab:     	movb	$0x0, 0x127(%rsp)
1800048b3:     	movb	$0x0, 0x126(%rsp)
1800048bb:     	movb	$0x0, 0x125(%rsp)
1800048c3:     	movb	$0x0, 0x124(%rsp)
1800048cb:     	movb	$0x0, 0x136(%rsp)
1800048d3:     	movb	$0x0, 0x135(%rsp)
1800048db:     	movb	$0x0, 0x134(%rsp)
1800048e3:     	movb	$0x0, 0x133(%rsp)
1800048eb:     	cmpq	$0x1, %rax
1800048ef:     	movq	0x230(%rsp), %r15
1800048f7:     	movq	0x228(%rsp), %rbx
1800048ff:     	movq	0x1f0(%rsp), %r14
180004907:     	je	0x180004aa2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xee2>
18000490d:     	testq	%rax, %rax
180004910:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004916:     	movq	0x2c0(%rsp), %rsi
18000491e:     	movq	0x2b8(%rsp), %rdi
180004926:     	movq	(%rbx,%rdi,8), %rax
18000492a:     	movq	0x10(%rbx,%rsi,8), %rdx
18000492f:     	movsd	(%r14,%rdx,8), %xmm0
180004935:     	movsd	0x8(%r14,%rax,8), %xmm2
18000493c:     	movsd	0x10(%r14,%rax,8), %xmm1
180004943:     	movapd	%xmm1, %xmm3
180004947:     	subsd	%xmm2, %xmm3
18000494b:     	xorl	%r12d, %r12d
18000494e:     	ucomisd	%xmm3, %xmm0
180004952:     	jb	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180004958:     	addsd	%xmm2, %xmm1
18000495c:     	ucomisd	%xmm0, %xmm1
180004960:     	jbe	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180004966:     	movsd	0x10(%r14,%rdx,8), %xmm0
18000496d:     	movsd	(%r14,%rax,8), %xmm2
180004973:     	movsd	0x18(%r14,%rax,8), %xmm1
18000497a:     	movapd	%xmm1, %xmm3
18000497e:     	subsd	%xmm2, %xmm3
180004982:     	ucomisd	%xmm3, %xmm0
180004986:     	jb	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
18000498c:     	addsd	%xmm2, %xmm1
180004990:     	xorl	%r12d, %r12d
180004993:     	ucomisd	%xmm0, %xmm1
180004997:     	jbe	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
18000499d:     	cmpb	$0x0, (%r13)
1800049a2:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800049a8:     	movq	0x18(%rbx,%rdi,8), %r12
1800049ad:     	movq	0x30(%rbx,%rdi,8), %rdx
1800049b2:     	movq	%rdx, %r11
1800049b5:     	sarq	$0x3f, %r11
1800049b9:     	andq	%r15, %r11
1800049bc:     	leaq	(%rbx,%rdx,8), %rax
1800049c0:     	movq	(%rax,%r11,8), %r10
1800049c4:     	cmpq	0x8(%rbx,%rdi,8), %r10
1800049c9:     	jge	0x180004cc0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1100>
1800049cf:     	testq	%r12, %r12
1800049d2:     	jne	0x180004cc9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1109>
1800049d8:     	xorl	%r9d, %r9d
1800049db:     	cmpq	$-0x1, %rdx
1800049df:     	cmovlq	%r15, %r9
1800049e3:     	cmpq	0x8(%rax,%r9,8), %r10
1800049e8:     	jne	0x18000555d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x199d>
1800049ee:     	leaq	(%r10,%r10), %r8
1800049f2:     	testq	%r10, %r10
1800049f5:     	movl	$0x4, %eax
1800049fa:     	cmovneq	%r8, %rax
1800049fe:     	movq	(%rbp), %r12
180004a02:     	leaq	(%r12,%rax), %r8
180004a06:     	cmpq	%r15, %r8
180004a09:     	jg	0x180004aaf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xeef>
180004a0f:     	movq	%r8, (%rbp)
180004a13:     	cmpb	$0x0, (%r13)
180004a18:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004a1e:     	movq	%r12, 0x128(%rsp)
180004a26:     	movq	%rax, 0x168(%rsp)
180004a2e:     	movq	%r9, 0x170(%rsp)
180004a36:     	xorl	%eax, %eax
180004a38:     	movq	%rdx, 0x158(%rsp)
180004a40:     	cmpq	$-0x2, %rdx
180004a44:     	cmovlq	%r15, %rax
180004a48:     	movq	%rax, 0x140(%rsp)
180004a50:     	movq	%r10, 0x148(%rsp)
180004a58:     	testq	%r10, %r10
180004a5b:     	jle	0x18000551f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x195f>
180004a61:     	movq	0x158(%rsp), %rax
180004a69:     	leaq	(%rbx,%rax,8), %rax
180004a6d:     	movq	0x140(%rsp), %r8
180004a75:     	movq	0x10(%rax,%r8,8), %r9
180004a7a:     	movq	0x148(%rsp), %rax
180004a82:     	movl	%eax, %r10d
180004a85:     	andl	$0x7, %r10d
180004a89:     	cmpq	$0x7, %rax
180004a8d:     	ja	0x1800052ee <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x172e>
180004a93:     	leaq	(,%r15,8), %r12
180004a9b:     	xorl	%edx, %edx
180004a9d:     	jmp	0x1800054dd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x191d>
180004aa2:     	movq	(%rbp), %rdx
180004aa6:     	leaq	0x4(%rdx), %rax
180004aaa:     	cmpq	%r15, %rax
180004aad:     	jle	0x180004ab9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xef9>
180004aaf:     	movb	$0x2, (%r13)
180004ab4:     	jmp	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004ab9:     	movq	0x2c8(%rsp), %rsi
180004ac1:     	movq	(%rbx,%rsi,8), %r10
180004ac5:     	movsd	0x10(%r14,%r10,8), %xmm1
180004acc:     	movsd	0x18(%r14,%r10,8), %xmm2
180004ad3:     	movsd	0x88d5(%rip), %xmm0     # 0x18000d3b0
180004adb:     	movsd	0x8(%r14,%r10,8), %xmm3
180004ae2:     	mulsd	%xmm0, %xmm3
180004ae6:     	mulsd	(%r14,%r10,8), %xmm0
180004aec:     	movq	%rax, (%rbp)
180004af0:     	cmpb	$0x0, (%r13)
180004af5:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004afb:     	movapd	%xmm1, %xmm4
180004aff:     	addsd	%xmm3, %xmm4
180004b03:     	movapd	%xmm2, %xmm5
180004b07:     	subsd	%xmm0, %xmm5
180004b0b:     	movsd	%xmm4, 0x10(%r14,%rdx,8)
180004b12:     	movsd	%xmm5, 0x18(%r14,%rdx,8)
180004b19:     	movsd	%xmm3, 0x8(%r14,%rdx,8)
180004b20:     	movsd	%xmm0, (%r14,%rdx,8)
180004b26:     	cmpb	$0x0, (%r13)
180004b2b:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004b31:     	movq	(%rbp), %rax
180004b35:     	leaq	0xb(%rax), %r11
180004b39:     	cmpq	%r15, %r11
180004b3c:     	jg	0x180004aaf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xeef>
180004b42:     	movq	0x8(%rbx,%rsi,8), %r10
180004b47:     	movq	%r11, (%rbp)
180004b4b:     	cmpb	$0x0, (%r13)
180004b50:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004b56:     	movq	%rdx, (%rbx,%rax,8)
180004b5a:     	movq	%r10, 0x8(%rbx,%rax,8)
180004b5f:     	movq	(%rbp), %rdx
180004b63:     	cmpq	%r15, %rdx
180004b66:     	movq	%rdx, %r10
180004b69:     	jle	0x180004b77 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xfb7>
180004b6b:     	movb	$0x2, (%r13)
180004b70:     	movq	(%rbp), %rdx
180004b74:     	xorl	%r10d, %r10d
180004b77:     	leaq	0x3(%rdx), %r11
180004b7b:     	cmpq	%r15, %r11
180004b7e:     	jg	0x180004aaf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xeef>
180004b84:     	movq	%r11, (%rbp)
180004b88:     	cmpb	$0x0, (%r13)
180004b8d:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004b93:     	movq	%rdx, %r11
180004b96:     	sarq	$0x3f, %r11
180004b9a:     	andq	%r15, %r11
180004b9d:     	leaq	(%rbx,%rdx,8), %rsi
180004ba1:     	movq	$0x0, (%rsi,%r11,8)
180004ba9:     	xorl	%r12d, %r12d
180004bac:     	cmpq	$-0x1, %rdx
180004bb0:     	movl	$0x0, %r11d
180004bb6:     	cmovlq	%r15, %r11
180004bba:     	movq	$0x0, 0x8(%rsi,%r11,8)
180004bc3:     	cmpq	$-0x2, %rdx
180004bc7:     	movl	$0x0, %r11d
180004bcd:     	cmovlq	%r15, %r11
180004bd1:     	movq	%r10, 0x10(%rsi,%r11,8)
180004bd6:     	cmpb	$0x0, (%r13)
180004bdb:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180004be1:     	leaq	(%rbx,%rax,8), %r10
180004be5:     	movq	%rdx, 0x30(%r10)
180004be9:     	movq	$0x0, 0x18(%r10)
180004bf1:     	movq	(%rbp), %rdx
180004bf5:     	leaq	0x4(%rdx), %r11
180004bf9:     	cmpq	%r15, %r11
180004bfc:     	jg	0x180004aaf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xeef>
180004c02:     	movq	%r11, (%rbp)
180004c06:     	cmpb	$0x0, (%r13)
180004c0b:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004c11:     	movq	%r8, 0x128(%rsp)
180004c19:     	movq	%r9, 0x138(%rsp)
180004c21:     	movq	%rcx, 0x118(%rsp)
180004c29:     	movq	$0x0, (%r14,%rdx,8)
180004c31:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180004c3a:     	movq	$0x0, 0x10(%r14,%rdx,8)
180004c43:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180004c4c:     	cmpb	$0x0, (%r13)
180004c51:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180004c57:     	movq	%r13, %rsi
180004c5a:     	movq	%rdx, 0x10(%r10)
180004c5e:     	movq	$0x0, 0x48(%r14,%rax,8)
180004c67:     	movq	$0x1, 0x50(%r10)
180004c6f:     	movq	$-0x1, 0x20(%r10)
180004c77:     	movq	$-0x1, 0x28(%r10)
180004c7f:     	movq	$-0x1, 0x38(%r10)
180004c87:     	movq	$-0x1, 0x40(%r10)
180004c8f:     	cmpb	$0x0, (%r13)
180004c94:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180004c9a:     	movq	0x2c8(%rsp), %rcx
180004ca2:     	movq	%rax, 0x20(%rbx,%rcx,8)
180004ca7:     	movq	(%rbp), %rcx
180004cab:     	leaq	0x4(%rcx), %rax
180004caf:     	cmpq	%r15, %rax
180004cb2:     	jle	0x180005903 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1d43>
180004cb8:     	movb	$0x2, (%rsi)
180004cbb:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180004cc0:     	testq	%r12, %r12
180004cc3:     	je	0x180004ef0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1330>
180004cc9:     	movq	0x20(%rbx,%rdi,8), %rax
180004cce:     	testq	%rax, %rax
180004cd1:     	js	0x1800050ee <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x152e>
180004cd7:     	movq	0x8(%rbp), %rdx
180004cdb:     	leaq	0x1(%rdx), %r10
180004cdf:     	movq	%r10, 0x8(%rbp)
180004ce3:     	cmpq	0x10(%rbp), %rdx
180004ce7:     	jge	0x1800050ee <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x152e>
180004ced:     	movq	%rcx, 0x118(%rsp)
180004cf5:     	movb	$0x0, 0x127(%rsp)
180004cfd:     	movq	%rsi, 0x100(%rsp)
180004d05:     	movq	%rax, 0xf8(%rsp)
180004d0d:     	movq	0x2a8(%rsp), %rax
180004d15:     	movq	%rax, 0xe8(%rsp)
180004d1d:     	movq	0x2a0(%rsp), %rax
180004d25:     	movq	%rax, 0xe0(%rsp)
180004d2d:     	movq	%r13, 0xd8(%rsp)
180004d35:     	movq	0x290(%rsp), %rax
180004d3d:     	movq	%rax, 0xd0(%rsp)
180004d45:     	movq	0x288(%rsp), %rax
180004d4d:     	movq	%rax, 0xc8(%rsp)
180004d55:     	movq	0x280(%rsp), %rax
180004d5d:     	movq	%rax, 0xc0(%rsp)
180004d65:     	movq	0x278(%rsp), %rax
180004d6d:     	movq	%rax, 0xb8(%rsp)
180004d75:     	movq	0x270(%rsp), %rax
180004d7d:     	movq	%rax, 0xb0(%rsp)
180004d85:     	movq	0x268(%rsp), %rax
180004d8d:     	movq	%rax, 0xa8(%rsp)
180004d95:     	movq	%rbp, 0xa0(%rsp)
180004d9d:     	movq	0x258(%rsp), %rax
180004da5:     	movq	%rax, 0x98(%rsp)
180004dad:     	movq	0x250(%rsp), %rax
180004db5:     	movq	%rax, 0x90(%rsp)
180004dbd:     	movq	0x248(%rsp), %rax
180004dc5:     	movq	%rax, 0x88(%rsp)
180004dcd:     	movq	0x240(%rsp), %rax
180004dd5:     	movq	%rax, 0x80(%rsp)
180004ddd:     	movq	0x238(%rsp), %rax
180004de5:     	movq	%rax, 0x78(%rsp)
180004dea:     	movq	%r15, 0x70(%rsp)
180004def:     	movq	%rbx, 0x68(%rsp)
180004df4:     	movq	0x220(%rsp), %rax
180004dfc:     	movq	%rax, 0x60(%rsp)
180004e01:     	movq	0x218(%rsp), %rax
180004e09:     	movq	%rax, 0x58(%rsp)
180004e0e:     	movq	0x210(%rsp), %rax
180004e16:     	movq	%rax, 0x50(%rsp)
180004e1b:     	movq	0x208(%rsp), %rax
180004e23:     	movq	%rax, 0x48(%rsp)
180004e28:     	movq	0x200(%rsp), %rax
180004e30:     	movq	%rax, 0x40(%rsp)
180004e35:     	movq	0x1f8(%rsp), %rax
180004e3d:     	movq	%rax, 0x38(%rsp)
180004e42:     	movq	%r14, 0x30(%rsp)
180004e47:     	movq	0x1e8(%rsp), %rax
180004e4f:     	movq	%rax, 0x28(%rsp)
180004e54:     	movq	0x1e0(%rsp), %rax
180004e5c:     	movq	%rax, 0x20(%rsp)
180004e61:     	movq	$-0x1, 0x108(%rsp)
180004e6d:     	movq	$0x0, 0xf0(%rsp)
180004e79:     	leaq	0x127(%rsp), %rcx
180004e81:     	movq	%r8, 0x128(%rsp)
180004e89:     	movq	%r9, 0x138(%rsp)
180004e91:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
180004e96:     	cmpb	$0x0, (%r13)
180004e9b:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180004ea1:     	movq	0x8(%rbp), %rdx
180004ea5:     	leaq	-0x1(%rdx), %rax
180004ea9:     	cmpb	$0x0, 0x127(%rsp)
180004eb1:     	movq	%rax, 0x8(%rbp)
180004eb5:     	movb	$0x1, %r12b
180004eb8:     	movq	0x118(%rsp), %rcx
180004ec0:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180004ec6:     	movq	0x28(%rbx,%rdi,8), %rax
180004ecb:     	testq	%rax, %rax
180004ece:     	js	0x180004ede <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x131e>
180004ed0:     	movq	%rdx, 0x8(%rbp)
180004ed4:     	cmpq	0x10(%rbp), %rdx
180004ed8:     	jle	0x18000511b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x155b>
180004ede:     	movb	$0x1, (%r13)
180004ee3:     	movq	$0x2dc6ce, 0x18(%rbp)   # imm = 0x2DC6CE
180004eeb:     	jmp	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180004ef0:     	movq	0x8(%rbp), %rax
180004ef4:     	leaq	0x1(%rax), %rdx
180004ef8:     	movq	%rdx, 0x8(%rbp)
180004efc:     	cmpq	0x10(%rbp), %rax
180004f00:     	jge	0x1800050ba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14fa>
180004f06:     	movq	%rcx, 0x118(%rsp)
180004f0e:     	movq	%rdi, 0x108(%rsp)
180004f16:     	movq	0x2a8(%rsp), %rax
180004f1e:     	movq	%rax, 0xe8(%rsp)
180004f26:     	movq	0x2a0(%rsp), %rax
180004f2e:     	movq	%rax, 0xe0(%rsp)
180004f36:     	movq	%r13, 0xd8(%rsp)
180004f3e:     	movq	0x290(%rsp), %rax
180004f46:     	movq	%rax, 0xd0(%rsp)
180004f4e:     	movq	0x288(%rsp), %rax
180004f56:     	movq	%rax, 0xc8(%rsp)
180004f5e:     	movq	0x280(%rsp), %rax
180004f66:     	movq	%rax, 0xc0(%rsp)
180004f6e:     	movq	0x278(%rsp), %rax
180004f76:     	movq	%rax, 0xb8(%rsp)
180004f7e:     	movq	0x270(%rsp), %rax
180004f86:     	movq	%rax, 0xb0(%rsp)
180004f8e:     	movq	0x268(%rsp), %rax
180004f96:     	movq	%rax, 0xa8(%rsp)
180004f9e:     	movq	%rbp, 0xa0(%rsp)
180004fa6:     	movq	0x258(%rsp), %rax
180004fae:     	movq	%rax, 0x98(%rsp)
180004fb6:     	movq	0x250(%rsp), %rax
180004fbe:     	movq	%rax, 0x90(%rsp)
180004fc6:     	movq	0x248(%rsp), %rax
180004fce:     	movq	%rax, 0x88(%rsp)
180004fd6:     	movq	0x240(%rsp), %rax
180004fde:     	movq	%rax, 0x80(%rsp)
180004fe6:     	movq	0x238(%rsp), %rax
180004fee:     	movq	%rax, 0x78(%rsp)
180004ff3:     	movq	%r15, 0x70(%rsp)
180004ff8:     	movq	%rbx, 0x68(%rsp)
180004ffd:     	movq	0x220(%rsp), %rax
180005005:     	movq	%rax, 0x60(%rsp)
18000500a:     	movq	0x218(%rsp), %rax
180005012:     	movq	%rax, 0x58(%rsp)
180005017:     	movq	0x210(%rsp), %rax
18000501f:     	movq	%rax, 0x50(%rsp)
180005024:     	movq	0x208(%rsp), %rax
18000502c:     	movq	%rax, 0x48(%rsp)
180005031:     	movq	0x200(%rsp), %rax
180005039:     	movq	%rax, 0x40(%rsp)
18000503e:     	movq	0x1f8(%rsp), %rax
180005046:     	movq	%rax, 0x38(%rsp)
18000504b:     	movq	%r14, 0x30(%rsp)
180005050:     	movq	0x1e8(%rsp), %rax
180005058:     	movq	%rax, 0x28(%rsp)
18000505d:     	movq	0x1e0(%rsp), %rax
180005065:     	movq	%rax, 0x20(%rsp)
18000506a:     	movq	$-0x1, 0x100(%rsp)
180005076:     	movq	$-0x1, 0xf8(%rsp)
180005082:     	movq	$0x1, 0xf0(%rsp)
18000508e:     	leaq	0x137(%rsp), %rcx
180005096:     	movq	%r8, 0x128(%rsp)
18000509e:     	movq	%r9, %r12
1800050a1:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800050a6:     	cmpb	$0x0, (%r13)
1800050ab:     	je	0x1800050c9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1509>
1800050ad:     	xorl	%r12d, %r12d
1800050b0:     	movq	0x118(%rsp), %rcx
1800050b8:     	jmp	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800050ba:     	movb	$0x1, (%r13)
1800050bf:     	movq	$0x2dc6cb, 0x18(%rbp)   # imm = 0x2DC6CB
1800050c7:     	jmp	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
1800050c9:     	decq	0x8(%rbp)
1800050cd:     	movq	0x118(%rsp), %rcx
1800050d5:     	movq	%r12, %r9
1800050d8:     	movq	0x128(%rsp), %r8
1800050e0:     	movq	0x20(%rbx,%rdi,8), %rax
1800050e5:     	testq	%rax, %rax
1800050e8:     	jns	0x180004cd7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1117>
1800050ee:     	movb	$0x1, (%r13)
1800050f3:     	movq	$0x2dc6cd, 0x18(%rbp)   # imm = 0x2DC6CD
1800050fb:     	xorl	%r12d, %r12d
1800050fe:     	andb	$0x1, %r12b
180005102:     	movb	%r12b, (%rcx)
180005105:     	xorl	%eax, %eax
180005107:     	addq	$0x178, %rsp            # imm = 0x178
18000510e:     	popq	%rbx
18000510f:     	popq	%rbp
180005110:     	popq	%rdi
180005111:     	popq	%rsi
180005112:     	popq	%r12
180005114:     	popq	%r13
180005116:     	popq	%r14
180005118:     	popq	%r15
18000511a:     	retq
18000511b:     	movb	$0x0, 0x126(%rsp)
180005123:     	movq	%rsi, 0x100(%rsp)
18000512b:     	movq	%rax, 0xf8(%rsp)
180005133:     	movq	0x2a8(%rsp), %rax
18000513b:     	movq	%rax, 0xe8(%rsp)
180005143:     	movq	0x2a0(%rsp), %rax
18000514b:     	movq	%rax, 0xe0(%rsp)
180005153:     	movq	%r13, 0xd8(%rsp)
18000515b:     	movq	0x290(%rsp), %rax
180005163:     	movq	%rax, 0xd0(%rsp)
18000516b:     	movq	0x288(%rsp), %rax
180005173:     	movq	%rax, 0xc8(%rsp)
18000517b:     	movq	0x280(%rsp), %rax
180005183:     	movq	%rax, 0xc0(%rsp)
18000518b:     	movq	0x278(%rsp), %rax
180005193:     	movq	%rax, 0xb8(%rsp)
18000519b:     	movq	0x270(%rsp), %rax
1800051a3:     	movq	%rax, 0xb0(%rsp)
1800051ab:     	movq	0x268(%rsp), %rax
1800051b3:     	movq	%rax, 0xa8(%rsp)
1800051bb:     	movq	%rbp, 0xa0(%rsp)
1800051c3:     	movq	0x258(%rsp), %rax
1800051cb:     	movq	%rax, 0x98(%rsp)
1800051d3:     	movq	0x250(%rsp), %rax
1800051db:     	movq	%rax, 0x90(%rsp)
1800051e3:     	movq	0x248(%rsp), %rax
1800051eb:     	movq	%rax, 0x88(%rsp)
1800051f3:     	movq	0x240(%rsp), %rax
1800051fb:     	movq	%rax, 0x80(%rsp)
180005203:     	movq	0x238(%rsp), %rax
18000520b:     	movq	%rax, 0x78(%rsp)
180005210:     	movq	%r15, 0x70(%rsp)
180005215:     	movq	%rbx, 0x68(%rsp)
18000521a:     	movq	0x220(%rsp), %rax
180005222:     	movq	%rax, 0x60(%rsp)
180005227:     	movq	0x218(%rsp), %rax
18000522f:     	movq	%rax, 0x58(%rsp)
180005234:     	movq	0x210(%rsp), %rax
18000523c:     	movq	%rax, 0x50(%rsp)
180005241:     	movq	0x208(%rsp), %rax
180005249:     	movq	%rax, 0x48(%rsp)
18000524e:     	movq	0x200(%rsp), %rax
180005256:     	movq	%rax, 0x40(%rsp)
18000525b:     	movq	0x1f8(%rsp), %rax
180005263:     	movq	%rax, 0x38(%rsp)
180005268:     	movq	%r14, 0x30(%rsp)
18000526d:     	movq	0x1e8(%rsp), %rax
180005275:     	movq	%rax, 0x28(%rsp)
18000527a:     	movq	0x1e0(%rsp), %rax
180005282:     	movq	%rax, 0x20(%rsp)
180005287:     	movq	$-0x1, 0x108(%rsp)
180005293:     	movq	$0x0, 0xf0(%rsp)
18000529f:     	leaq	0x126(%rsp), %rcx
1800052a7:     	movq	0x128(%rsp), %r8
1800052af:     	movq	0x138(%rsp), %r9
1800052b7:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800052bc:     	cmpb	$0x0, (%r13)
1800052c1:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800052c7:     	movq	0x8(%rbp), %rcx
1800052cb:     	leaq	-0x1(%rcx), %rax
1800052cf:     	cmpb	$0x0, 0x126(%rsp)
1800052d7:     	movq	%rax, 0x8(%rbp)
1800052db:     	je	0x1800056bf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1aff>
1800052e1:     	movq	0x118(%rsp), %rcx
1800052e9:     	jmp	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800052ee:     	movq	%r10, 0x160(%rsp)
1800052f6:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005300:     	andq	%rax, %rdx
180005303:     	movq	0x128(%rsp), %rax
18000530b:     	leaq	(%rbx,%rax,8), %rax
18000530f:     	movq	%rax, 0x150(%rsp)
180005317:     	leaq	(,%r15,8), %r12
18000531f:     	xorl	%r8d, %r8d
180005322:     	movq	%rdx, 0x138(%rsp)
18000532a:     	leaq	(%r9,%r8), %r10
18000532e:     	sarq	$0x3f, %r10
180005332:     	andq	%r12, %r10
180005335:     	leaq	(%rbx,%r9,8), %rsi
180005339:     	addq	%rsi, %r10
18000533c:     	movq	(%r10,%r8,8), %r10
180005340:     	movq	0x128(%rsp), %rax
180005348:     	addq	%r8, %rax
18000534b:     	sarq	$0x3f, %rax
18000534f:     	andq	%r12, %rax
180005352:     	movq	0x150(%rsp), %r13
18000535a:     	addq	%r13, %rax
18000535d:     	movq	%r10, (%rax,%r8,8)
180005361:     	leaq	0x1(%r9,%r8), %rax
180005366:     	sarq	$0x3f, %rax
18000536a:     	andq	%r12, %rax
18000536d:     	addq	%rsi, %rax
180005370:     	movq	0x8(%rax,%r8,8), %rax
180005375:     	movq	0x128(%rsp), %rdx
18000537d:     	leaq	0x1(%rdx,%r8), %r10
180005382:     	sarq	$0x3f, %r10
180005386:     	andq	%r12, %r10
180005389:     	addq	%r13, %r10
18000538c:     	movq	%rax, 0x8(%r10,%r8,8)
180005391:     	leaq	0x2(%r9,%r8), %rax
180005396:     	sarq	$0x3f, %rax
18000539a:     	andq	%r12, %rax
18000539d:     	movq	%rsi, 0x118(%rsp)
1800053a5:     	addq	%rsi, %rax
1800053a8:     	movq	0x10(%rax,%r8,8), %rax
1800053ad:     	leaq	0x2(%rdx,%r8), %r10
1800053b2:     	movq	%rdx, %rsi
1800053b5:     	sarq	$0x3f, %r10
1800053b9:     	andq	%r12, %r10
1800053bc:     	addq	%r13, %r10
1800053bf:     	movq	%rax, 0x10(%r10,%r8,8)
1800053c4:     	leaq	0x3(%r9,%r8), %rax
1800053c9:     	sarq	$0x3f, %rax
1800053cd:     	andq	%r12, %rax
1800053d0:     	addq	0x118(%rsp), %rax
1800053d8:     	movq	0x18(%rax,%r8,8), %rax
1800053dd:     	leaq	0x3(%rdx,%r8), %r10
1800053e2:     	sarq	$0x3f, %r10
1800053e6:     	andq	%r12, %r10
1800053e9:     	addq	%r13, %r10
1800053ec:     	movq	%rax, 0x18(%r10,%r8,8)
1800053f1:     	leaq	0x4(%r9,%r8), %rax
1800053f6:     	sarq	$0x3f, %rax
1800053fa:     	andq	%r12, %rax
1800053fd:     	addq	0x118(%rsp), %rax
180005405:     	movq	0x20(%rax,%r8,8), %rax
18000540a:     	leaq	0x4(%rsi,%r8), %r10
18000540f:     	sarq	$0x3f, %r10
180005413:     	andq	%r12, %r10
180005416:     	addq	%r13, %r10
180005419:     	movq	%r13, %rsi
18000541c:     	movq	%rax, 0x20(%r10,%r8,8)
180005421:     	leaq	0x5(%r9,%r8), %rax
180005426:     	sarq	$0x3f, %rax
18000542a:     	andq	%r12, %rax
18000542d:     	addq	0x118(%rsp), %rax
180005435:     	movq	0x28(%rax,%r8,8), %rax
18000543a:     	leaq	0x5(%rdx,%r8), %r10
18000543f:     	movq	%rdx, %r13
180005442:     	sarq	$0x3f, %r10
180005446:     	andq	%r12, %r10
180005449:     	addq	%rsi, %r10
18000544c:     	movq	%rax, 0x28(%r10,%r8,8)
180005451:     	leaq	0x6(%r9,%r8), %rax
180005456:     	sarq	$0x3f, %rax
18000545a:     	andq	%r12, %rax
18000545d:     	addq	0x118(%rsp), %rax
180005465:     	movq	0x30(%rax,%r8,8), %rax
18000546a:     	leaq	0x6(%rdx,%r8), %r10
18000546f:     	sarq	$0x3f, %r10
180005473:     	andq	%r12, %r10
180005476:     	addq	%rsi, %r10
180005479:     	movq	%rax, 0x30(%r10,%r8,8)
18000547e:     	leaq	0x7(%r9,%r8), %rax
180005483:     	sarq	$0x3f, %rax
180005487:     	andq	%r12, %rax
18000548a:     	addq	0x118(%rsp), %rax
180005492:     	movq	0x138(%rsp), %rdx
18000549a:     	movq	0x38(%rax,%r8,8), %rax
18000549f:     	leaq	0x7(%r13,%r8), %r10
1800054a4:     	sarq	$0x3f, %r10
1800054a8:     	andq	%r12, %r10
1800054ab:     	addq	%rsi, %r10
1800054ae:     	movq	%rax, 0x38(%r10,%r8,8)
1800054b3:     	addq	$0x8, %r8
1800054b7:     	cmpq	%r8, %rdx
1800054ba:     	jne	0x18000532a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x176a>
1800054c0:     	movq	0x160(%rsp), %r10
1800054c8:     	testq	%r10, %r10
1800054cb:     	movq	0x298(%rsp), %r13
1800054d3:     	movq	0x2c0(%rsp), %rsi
1800054db:     	je	0x18000551f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x195f>
1800054dd:     	movq	0x128(%rsp), %rax
1800054e5:     	leaq	(%rdx,%rax), %r8
1800054e9:     	addq	%rdx, %r9
1800054ec:     	movq	%r9, %rax
1800054ef:     	sarq	$0x3f, %rax
1800054f3:     	andq	%r12, %rax
1800054f6:     	addq	%rbx, %rax
1800054f9:     	movq	(%rax,%r9,8), %rax
1800054fd:     	movq	%r10, %rdx
180005500:     	movq	%r8, %r10
180005503:     	sarq	$0x3f, %r10
180005507:     	andq	%r12, %r10
18000550a:     	addq	%rbx, %r10
18000550d:     	movq	%rax, (%r10,%r8,8)
180005511:     	movq	%rdx, %r10
180005514:     	incq	%r8
180005517:     	incq	%r9
18000551a:     	decq	%r10
18000551d:     	jne	0x1800054ec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x192c>
18000551f:     	movq	0x158(%rsp), %rdx
180005527:     	leaq	(%rbx,%rdx,8), %rax
18000552b:     	movq	0x170(%rsp), %r8
180005533:     	movq	0x168(%rsp), %r9
18000553b:     	movq	%r9, 0x8(%rax,%r8,8)
180005540:     	movq	0x128(%rsp), %r8
180005548:     	movq	0x140(%rsp), %r9
180005550:     	movq	%r8, 0x10(%rax,%r9,8)
180005555:     	movq	0x148(%rsp), %r10
18000555d:     	movq	%rax, %r8
180005560:     	leaq	0x1(%r10), %rax
180005564:     	movq	%rax, (%r8,%r11,8)
180005568:     	cmpb	$0x0, (%r13)
18000556d:     	jne	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180005573:     	xorl	%eax, %eax
180005575:     	cmpq	$-0x2, %rdx
180005579:     	cmovlq	%r15, %rax
18000557d:     	addq	0x10(%r8,%rax,8), %r10
180005582:     	movq	%r10, %rax
180005585:     	sarq	$0x3f, %rax
180005589:     	andq	%r15, %rax
18000558c:     	leaq	(%rbx,%r10,8), %rdx
180005590:     	movq	%rsi, (%rdx,%rax,8)
180005594:     	movsd	0x48(%r14,%rdi,8), %xmm2
18000559b:     	movsd	0x8(%r14,%rsi,8), %xmm1
1800055a2:     	movapd	%xmm2, %xmm0
1800055a6:     	addsd	%xmm1, %xmm0
1800055aa:     	xorpd	%xmm3, %xmm3
1800055ae:     	ucomisd	%xmm3, %xmm0
1800055b2:     	jbe	0x180005683 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1ac3>
1800055b8:     	movq	0x10(%rbx,%rdi,8), %rax
1800055bd:     	cmpq	$0x0, 0x8(%rbx,%rax,8)
1800055c3:     	mulsd	(%r14,%rax,8), %xmm2
1800055c9:     	je	0x1800055f5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1a35>
1800055cb:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
1800055d1:     	je	0x1800055f5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1a35>
1800055d3:     	movapd	0x7de5(%rip), %xmm3     # 0x18000d3c0
1800055db:     	andpd	%xmm2, %xmm3
1800055df:     	ucomisd	0x7de9(%rip), %xmm3     # 0x18000d3d0
1800055e7:     	jae	0x1800056a1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1ae1>
1800055ed:     	xorpd	%xmm3, %xmm3
1800055f1:     	addsd	%xmm3, %xmm2
1800055f5:     	movq	0x10(%rbx,%rsi,8), %rdx
1800055fa:     	mulsd	(%r14,%rdx,8), %xmm1
180005600:     	addsd	%xmm2, %xmm1
180005604:     	divsd	%xmm0, %xmm1
180005608:     	movsd	%xmm1, (%r14,%rax,8)
18000560e:     	movq	$0x0, 0x8(%rbx,%rax,8)
180005617:     	movq	0x10(%rbx,%rdi,8), %rax
18000561c:     	movsd	0x10(%r14,%rax,8), %xmm1
180005623:     	cmpq	$0x0, 0x18(%rbx,%rax,8)
180005629:     	mulsd	0x48(%r14,%rdi,8), %xmm1
180005630:     	je	0x180005658 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1a98>
180005632:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
180005638:     	je	0x180005658 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1a98>
18000563a:     	movapd	0x7d7e(%rip), %xmm2     # 0x18000d3c0
180005642:     	andpd	%xmm1, %xmm2
180005646:     	ucomisd	0x7d82(%rip), %xmm2     # 0x18000d3d0
18000564e:     	jae	0x1800056b0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1af0>
180005650:     	xorpd	%xmm2, %xmm2
180005654:     	addsd	%xmm2, %xmm1
180005658:     	movq	0x10(%rbx,%rsi,8), %rdx
18000565d:     	movsd	0x10(%r14,%rdx,8), %xmm2
180005664:     	mulsd	0x8(%r14,%rsi,8), %xmm2
18000566b:     	addsd	%xmm1, %xmm2
18000566f:     	divsd	%xmm0, %xmm2
180005673:     	movsd	%xmm2, 0x10(%r14,%rax,8)
18000567a:     	movq	$0x0, 0x18(%rbx,%rax,8)
180005683:     	movsd	%xmm0, 0x48(%r14,%rdi,8)
18000568a:     	movq	$0x0, 0x50(%rbx,%rdi,8)
180005693:     	cmpb	$0x0, (%r13)
180005698:     	sete	%r12b
18000569c:     	jmp	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800056a1:     	movb	$0x1, (%r13)
1800056a6:     	movq	$0x895447, 0x18(%rbp)   # imm = 0x895447
1800056ae:     	jmp	0x180005693 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1ad3>
1800056b0:     	movb	$0x1, (%r13)
1800056b5:     	movq	$0x895449, 0x18(%rbp)   # imm = 0x895449
1800056bd:     	jmp	0x180005693 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1ad3>
1800056bf:     	movq	0x38(%rbx,%rdi,8), %rax
1800056c4:     	testq	%rax, %rax
1800056c7:     	js	0x1800056eb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1b2b>
1800056c9:     	movq	%rcx, 0x8(%rbp)
1800056cd:     	cmpq	0x10(%rbp), %rcx
1800056d1:     	jle	0x1800056fd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1b3d>
1800056d3:     	movq	0x298(%rsp), %rax
1800056db:     	movb	$0x1, (%rax)
1800056de:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
1800056e6:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800056eb:     	movb	$0x1, (%r13)
1800056f0:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
1800056f8:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800056fd:     	movb	$0x0, 0x125(%rsp)
180005705:     	movq	%rsi, 0x100(%rsp)
18000570d:     	movq	%rax, 0xf8(%rsp)
180005715:     	movq	0x2a8(%rsp), %rax
18000571d:     	movq	%rax, 0xe8(%rsp)
180005725:     	movq	0x2a0(%rsp), %rax
18000572d:     	movq	%rax, 0xe0(%rsp)
180005735:     	movq	0x298(%rsp), %r13
18000573d:     	movq	%r13, 0xd8(%rsp)
180005745:     	movq	0x290(%rsp), %rax
18000574d:     	movq	%rax, 0xd0(%rsp)
180005755:     	movq	0x288(%rsp), %rax
18000575d:     	movq	%rax, 0xc8(%rsp)
180005765:     	movq	0x280(%rsp), %rax
18000576d:     	movq	%rax, 0xc0(%rsp)
180005775:     	movq	0x278(%rsp), %rax
18000577d:     	movq	%rax, 0xb8(%rsp)
180005785:     	movq	0x270(%rsp), %rax
18000578d:     	movq	%rax, 0xb0(%rsp)
180005795:     	movq	0x268(%rsp), %rax
18000579d:     	movq	%rax, 0xa8(%rsp)
1800057a5:     	movq	%rbp, 0xa0(%rsp)
1800057ad:     	movq	0x258(%rsp), %rax
1800057b5:     	movq	%rax, 0x98(%rsp)
1800057bd:     	movq	0x250(%rsp), %rax
1800057c5:     	movq	%rax, 0x90(%rsp)
1800057cd:     	movq	0x248(%rsp), %rax
1800057d5:     	movq	%rax, 0x88(%rsp)
1800057dd:     	movq	0x240(%rsp), %rax
1800057e5:     	movq	%rax, 0x80(%rsp)
1800057ed:     	movq	0x238(%rsp), %rax
1800057f5:     	movq	%rax, 0x78(%rsp)
1800057fa:     	movq	%r15, 0x70(%rsp)
1800057ff:     	movq	%rbx, 0x68(%rsp)
180005804:     	movq	0x220(%rsp), %rax
18000580c:     	movq	%rax, 0x60(%rsp)
180005811:     	movq	0x218(%rsp), %rax
180005819:     	movq	%rax, 0x58(%rsp)
18000581e:     	movq	0x210(%rsp), %rax
180005826:     	movq	%rax, 0x50(%rsp)
18000582b:     	movq	0x208(%rsp), %rax
180005833:     	movq	%rax, 0x48(%rsp)
180005838:     	movq	0x200(%rsp), %rax
180005840:     	movq	%rax, 0x40(%rsp)
180005845:     	movq	0x1f8(%rsp), %rax
18000584d:     	movq	%rax, 0x38(%rsp)
180005852:     	movq	%r14, 0x30(%rsp)
180005857:     	movq	0x1e8(%rsp), %rax
18000585f:     	movq	%rax, 0x28(%rsp)
180005864:     	movq	0x1e0(%rsp), %rax
18000586c:     	movq	%rax, 0x20(%rsp)
180005871:     	movq	$-0x1, 0x108(%rsp)
18000587d:     	movq	$0x0, 0xf0(%rsp)
180005889:     	leaq	0x125(%rsp), %rcx
180005891:     	movq	0x128(%rsp), %r8
180005899:     	movq	0x138(%rsp), %r9
1800058a1:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800058a6:     	cmpb	$0x0, (%r13)
1800058ab:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800058b1:     	movq	0x8(%rbp), %rax
1800058b5:     	leaq	-0x1(%rax), %rcx
1800058b9:     	cmpb	$0x0, 0x125(%rsp)
1800058c1:     	movq	%rcx, 0x8(%rbp)
1800058c5:     	movq	0x118(%rsp), %rcx
1800058cd:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800058d3:     	movq	0x40(%rbx,%rdi,8), %rcx
1800058d8:     	testq	%rcx, %rcx
1800058db:     	js	0x1800058eb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1d2b>
1800058dd:     	movq	%rax, 0x8(%rbp)
1800058e1:     	cmpq	0x10(%rbp), %rax
1800058e5:     	jle	0x180006638 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2a78>
1800058eb:     	movq	0x298(%rsp), %rax
1800058f3:     	movb	$0x1, (%rax)
1800058f6:     	movq	$0x2dc6d0, 0x18(%rbp)   # imm = 0x2DC6D0
1800058fe:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005903:     	movq	%rax, (%rbp)
180005907:     	cmpb	$0x0, (%rsi)
18000590a:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005910:     	subsd	%xmm3, %xmm1
180005914:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
18000591b:     	movsd	%xmm5, 0x18(%r14,%rcx,8)
180005922:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005929:     	movsd	%xmm0, (%r14,%rcx,8)
18000592f:     	cmpb	$0x0, (%rsi)
180005932:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005938:     	movq	(%rbp), %rax
18000593c:     	leaq	0xb(%rax), %r8
180005940:     	cmpq	%r15, %r8
180005943:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005949:     	movq	0x2c8(%rsp), %rdx
180005951:     	movq	0x8(%rbx,%rdx,8), %rdx
180005956:     	movq	%r8, (%rbp)
18000595a:     	cmpb	$0x0, (%rsi)
18000595d:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005963:     	movq	%rcx, (%rbx,%rax,8)
180005967:     	movq	%rdx, 0x8(%rbx,%rax,8)
18000596c:     	movq	(%rbp), %rdx
180005970:     	cmpq	%r15, %rdx
180005973:     	movq	%rdx, %rcx
180005976:     	jle	0x180005981 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1dc1>
180005978:     	movb	$0x2, (%rsi)
18000597b:     	movq	(%rbp), %rdx
18000597f:     	xorl	%ecx, %ecx
180005981:     	leaq	0x3(%rdx), %r8
180005985:     	cmpq	%r15, %r8
180005988:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
18000598e:     	movq	%r8, (%rbp)
180005992:     	cmpb	$0x0, (%rsi)
180005995:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000599b:     	movq	%rdx, %r8
18000599e:     	sarq	$0x3f, %r8
1800059a2:     	andq	%r15, %r8
1800059a5:     	leaq	(%rbx,%rdx,8), %r9
1800059a9:     	movq	$0x0, (%r9,%r8,8)
1800059b1:     	xorl	%r12d, %r12d
1800059b4:     	cmpq	$-0x1, %rdx
1800059b8:     	movl	$0x0, %r8d
1800059be:     	cmovlq	%r15, %r8
1800059c2:     	movq	$0x0, 0x8(%r9,%r8,8)
1800059cb:     	cmpq	$-0x2, %rdx
1800059cf:     	movl	$0x0, %r8d
1800059d5:     	cmovlq	%r15, %r8
1800059d9:     	movq	%rcx, 0x10(%r9,%r8,8)
1800059de:     	cmpb	$0x0, (%rsi)
1800059e1:     	movq	0x118(%rsp), %rcx
1800059e9:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
1800059ef:     	leaq	(%rbx,%rax,8), %rcx
1800059f3:     	movq	%rdx, 0x30(%rcx)
1800059f7:     	movq	$0x0, 0x18(%rcx)
1800059ff:     	movq	(%rbp), %rdx
180005a03:     	leaq	0x4(%rdx), %r8
180005a07:     	cmpq	%r15, %r8
180005a0a:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005a10:     	movq	%r8, (%rbp)
180005a14:     	cmpb	$0x0, (%rsi)
180005a17:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005a1d:     	movq	$0x0, (%r14,%rdx,8)
180005a25:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005a2e:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005a37:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005a40:     	cmpb	$0x0, (%rsi)
180005a43:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005a49:     	movq	%rdx, 0x10(%rcx)
180005a4d:     	movq	$0x0, 0x48(%r14,%rax,8)
180005a56:     	movq	$0x1, 0x50(%rcx)
180005a5e:     	movq	$-0x1, 0x20(%rcx)
180005a66:     	movq	$-0x1, 0x28(%rcx)
180005a6e:     	movq	$-0x1, 0x38(%rcx)
180005a76:     	movq	$-0x1, 0x40(%rcx)
180005a7e:     	cmpb	$0x0, (%rsi)
180005a81:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005a87:     	movq	0x2c8(%rsp), %rcx
180005a8f:     	movq	%rax, 0x28(%rbx,%rcx,8)
180005a94:     	movq	(%rbp), %rcx
180005a98:     	leaq	0x4(%rcx), %rax
180005a9c:     	cmpq	%r15, %rax
180005a9f:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005aa5:     	movq	%rax, (%rbp)
180005aa9:     	cmpb	$0x0, (%rsi)
180005aac:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005ab2:     	addsd	%xmm0, %xmm2
180005ab6:     	movsd	%xmm4, 0x10(%r14,%rcx,8)
180005abd:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005ac4:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005acb:     	movsd	%xmm0, (%r14,%rcx,8)
180005ad1:     	cmpb	$0x0, (%rsi)
180005ad4:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005ada:     	movq	(%rbp), %rax
180005ade:     	leaq	0xb(%rax), %r8
180005ae2:     	cmpq	%r15, %r8
180005ae5:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005aeb:     	movq	0x2c8(%rsp), %rdx
180005af3:     	movq	0x8(%rbx,%rdx,8), %rdx
180005af8:     	movq	%r8, (%rbp)
180005afc:     	cmpb	$0x0, (%rsi)
180005aff:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005b05:     	movq	%rcx, (%rbx,%rax,8)
180005b09:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005b0e:     	movq	(%rbp), %rdx
180005b12:     	cmpq	%r15, %rdx
180005b15:     	movq	%rdx, %rcx
180005b18:     	jle	0x180005b23 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1f63>
180005b1a:     	movb	$0x2, (%rsi)
180005b1d:     	movq	(%rbp), %rdx
180005b21:     	xorl	%ecx, %ecx
180005b23:     	leaq	0x3(%rdx), %r8
180005b27:     	cmpq	%r15, %r8
180005b2a:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005b30:     	movq	%r8, (%rbp)
180005b34:     	cmpb	$0x0, (%rsi)
180005b37:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005b3d:     	movq	%rdx, %r8
180005b40:     	sarq	$0x3f, %r8
180005b44:     	andq	%r15, %r8
180005b47:     	leaq	(%rbx,%rdx,8), %r9
180005b4b:     	movq	$0x0, (%r9,%r8,8)
180005b53:     	xorl	%r12d, %r12d
180005b56:     	cmpq	$-0x1, %rdx
180005b5a:     	movl	$0x0, %r8d
180005b60:     	cmovlq	%r15, %r8
180005b64:     	movq	$0x0, 0x8(%r9,%r8,8)
180005b6d:     	cmpq	$-0x2, %rdx
180005b71:     	movl	$0x0, %r8d
180005b77:     	cmovlq	%r15, %r8
180005b7b:     	movq	%rcx, 0x10(%r9,%r8,8)
180005b80:     	cmpb	$0x0, (%rsi)
180005b83:     	movq	0x118(%rsp), %rcx
180005b8b:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180005b91:     	leaq	(%rbx,%rax,8), %rcx
180005b95:     	movq	%rdx, 0x30(%rcx)
180005b99:     	movq	$0x0, 0x18(%rcx)
180005ba1:     	movq	(%rbp), %rdx
180005ba5:     	leaq	0x4(%rdx), %r8
180005ba9:     	cmpq	%r15, %r8
180005bac:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005bb2:     	movq	%r8, (%rbp)
180005bb6:     	cmpb	$0x0, (%rsi)
180005bb9:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005bbf:     	movq	$0x0, (%r14,%rdx,8)
180005bc7:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005bd0:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005bd9:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005be2:     	cmpb	$0x0, (%rsi)
180005be5:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005beb:     	movq	%rdx, 0x10(%rcx)
180005bef:     	movq	$0x0, 0x48(%r14,%rax,8)
180005bf8:     	movq	$0x1, 0x50(%rcx)
180005c00:     	movq	$-0x1, 0x20(%rcx)
180005c08:     	movq	$-0x1, 0x28(%rcx)
180005c10:     	movq	$-0x1, 0x38(%rcx)
180005c18:     	movq	$-0x1, 0x40(%rcx)
180005c20:     	cmpb	$0x0, (%rsi)
180005c23:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005c29:     	movq	0x2c8(%rsp), %rcx
180005c31:     	movq	%rax, 0x38(%rbx,%rcx,8)
180005c36:     	movq	(%rbp), %rcx
180005c3a:     	leaq	0x4(%rcx), %rax
180005c3e:     	cmpq	%r15, %rax
180005c41:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005c47:     	movq	%rax, (%rbp)
180005c4b:     	cmpb	$0x0, (%rsi)
180005c4e:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005c54:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
180005c5b:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005c62:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005c69:     	movsd	%xmm0, (%r14,%rcx,8)
180005c6f:     	cmpb	$0x0, (%rsi)
180005c72:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005c78:     	movq	(%rbp), %rax
180005c7c:     	leaq	0xb(%rax), %r8
180005c80:     	cmpq	%r15, %r8
180005c83:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005c89:     	movq	0x2c8(%rsp), %rdx
180005c91:     	movq	0x8(%rbx,%rdx,8), %rdx
180005c96:     	movq	%r8, (%rbp)
180005c9a:     	cmpb	$0x0, (%rsi)
180005c9d:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005ca3:     	movq	%rcx, (%rbx,%rax,8)
180005ca7:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005cac:     	movq	(%rbp), %rdx
180005cb0:     	cmpq	%r15, %rdx
180005cb3:     	movq	%rdx, %rcx
180005cb6:     	jle	0x180005cc1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2101>
180005cb8:     	movb	$0x2, (%rsi)
180005cbb:     	movq	(%rbp), %rdx
180005cbf:     	xorl	%ecx, %ecx
180005cc1:     	leaq	0x3(%rdx), %r8
180005cc5:     	cmpq	%r15, %r8
180005cc8:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005cce:     	movq	%r8, (%rbp)
180005cd2:     	cmpb	$0x0, (%rsi)
180005cd5:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005cdb:     	movq	%rdx, %r8
180005cde:     	sarq	$0x3f, %r8
180005ce2:     	andq	%r15, %r8
180005ce5:     	leaq	(%rbx,%rdx,8), %r9
180005ce9:     	movq	$0x0, (%r9,%r8,8)
180005cf1:     	xorl	%r12d, %r12d
180005cf4:     	cmpq	$-0x1, %rdx
180005cf8:     	movl	$0x0, %r8d
180005cfe:     	cmovlq	%r15, %r8
180005d02:     	movq	$0x0, 0x8(%r9,%r8,8)
180005d0b:     	cmpq	$-0x2, %rdx
180005d0f:     	movl	$0x0, %r8d
180005d15:     	cmovlq	%r15, %r8
180005d19:     	movq	%rcx, 0x10(%r9,%r8,8)
180005d1e:     	cmpb	$0x0, (%rsi)
180005d21:     	movq	0x118(%rsp), %rcx
180005d29:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180005d2f:     	leaq	(%rbx,%rax,8), %rcx
180005d33:     	movq	%rdx, 0x30(%rcx)
180005d37:     	movq	$0x0, 0x18(%rcx)
180005d3f:     	movq	(%rbp), %rdx
180005d43:     	leaq	0x4(%rdx), %r8
180005d47:     	cmpq	%r15, %r8
180005d4a:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
180005d50:     	movq	%r8, (%rbp)
180005d54:     	cmpb	$0x0, (%rsi)
180005d57:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005d5d:     	movq	$0x0, (%r14,%rdx,8)
180005d65:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005d6e:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005d77:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005d80:     	cmpb	$0x0, (%rsi)
180005d83:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005d89:     	movq	%rdx, 0x10(%rcx)
180005d8d:     	movq	$0x0, 0x48(%r14,%rax,8)
180005d96:     	movq	$0x1, 0x50(%rcx)
180005d9e:     	movq	$-0x1, 0x20(%rcx)
180005da6:     	movq	$-0x1, 0x28(%rcx)
180005dae:     	movq	$-0x1, 0x38(%rcx)
180005db6:     	movq	$-0x1, 0x40(%rcx)
180005dbe:     	cmpb	$0x0, (%rsi)
180005dc1:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180005dc7:     	movq	0x2c8(%rsp), %rcx
180005dcf:     	movq	%rax, 0x40(%rbx,%rcx,8)
180005dd4:     	movq	$0x1, 0x18(%rbx,%rcx,8)
180005ddd:     	movq	0x30(%rbx,%rcx,8), %rax
180005de2:     	movq	%rax, %rcx
180005de5:     	sarq	$0x3f, %rcx
180005de9:     	andq	%r15, %rcx
180005dec:     	leaq	(%rbx,%rax,8), %rdx
180005df0:     	movq	%rcx, 0x148(%rsp)
180005df8:     	movq	%rdx, 0x150(%rsp)
180005e00:     	cmpq	$0x0, (%rdx,%rcx,8)
180005e05:     	jle	0x1800065aa <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x29ea>
180005e0b:     	leaq	(,%r15,8), %rcx
180005e13:     	xorl	%r13d, %r13d
180005e16:     	cmpq	$-0x2, %rax
180005e1a:     	cmovgeq	%r13, %rcx
180005e1e:     	movq	%rcx, 0x140(%rsp)
180005e26:     	movq	0x2c8(%rsp), %rax
180005e2e:     	movq	0x20(%rbx,%rax,8), %rax
180005e33:     	testq	%rax, %rax
180005e36:     	js	0x1800067fc <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c3c>
180005e3c:     	movq	0x150(%rsp), %rcx
180005e44:     	movq	0x140(%rsp), %rdx
180005e4c:     	movq	0x10(%rcx,%rdx), %rcx
180005e51:     	addq	%r13, %rcx
180005e54:     	leaq	(%rbx,%rcx,8), %rdx
180005e58:     	sarq	$0x3f, %rcx
180005e5c:     	andq	%r15, %rcx
180005e5f:     	movq	(%rdx,%rcx,8), %r12
180005e63:     	movq	0x8(%rbp), %rcx
180005e67:     	leaq	0x1(%rcx), %rdx
180005e6b:     	movq	%rdx, 0x8(%rbp)
180005e6f:     	cmpq	0x10(%rbp), %rcx
180005e73:     	jge	0x1800067fc <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c3c>
180005e79:     	movq	%r12, 0x100(%rsp)
180005e81:     	movq	%rax, 0xf8(%rsp)
180005e89:     	movq	0x2a8(%rsp), %rax
180005e91:     	movq	%rax, 0xe8(%rsp)
180005e99:     	movq	0x2a0(%rsp), %rax
180005ea1:     	movq	%rax, 0xe0(%rsp)
180005ea9:     	movq	%rsi, 0xd8(%rsp)
180005eb1:     	movq	0x290(%rsp), %rax
180005eb9:     	movq	%rax, 0xd0(%rsp)
180005ec1:     	movq	0x288(%rsp), %rax
180005ec9:     	movq	%rax, 0xc8(%rsp)
180005ed1:     	movq	0x280(%rsp), %rax
180005ed9:     	movq	%rax, 0xc0(%rsp)
180005ee1:     	movq	0x278(%rsp), %rax
180005ee9:     	movq	%rax, 0xb8(%rsp)
180005ef1:     	movq	0x270(%rsp), %rax
180005ef9:     	movq	%rax, 0xb0(%rsp)
180005f01:     	movq	0x268(%rsp), %rax
180005f09:     	movq	%rax, 0xa8(%rsp)
180005f11:     	movq	%rbp, 0xa0(%rsp)
180005f19:     	movq	%rdi, 0x98(%rsp)
180005f21:     	movq	0x250(%rsp), %rax
180005f29:     	movq	%rax, 0x90(%rsp)
180005f31:     	movq	0x248(%rsp), %rax
180005f39:     	movq	%rax, 0x88(%rsp)
180005f41:     	movq	0x240(%rsp), %rax
180005f49:     	movq	%rax, 0x80(%rsp)
180005f51:     	movq	0x238(%rsp), %rax
180005f59:     	movq	%rax, 0x78(%rsp)
180005f5e:     	movq	%r15, 0x70(%rsp)
180005f63:     	movq	%rbx, 0x68(%rsp)
180005f68:     	movq	0x220(%rsp), %rax
180005f70:     	movq	%rax, 0x60(%rsp)
180005f75:     	movq	0x218(%rsp), %rax
180005f7d:     	movq	%rax, 0x58(%rsp)
180005f82:     	movq	0x210(%rsp), %rax
180005f8a:     	movq	%rax, 0x50(%rsp)
180005f8f:     	movq	0x208(%rsp), %rax
180005f97:     	movq	%rax, 0x48(%rsp)
180005f9c:     	movq	0x200(%rsp), %rax
180005fa4:     	movq	%rax, 0x40(%rsp)
180005fa9:     	movq	0x1f8(%rsp), %rax
180005fb1:     	movq	%rax, 0x38(%rsp)
180005fb6:     	movq	%r14, 0x30(%rsp)
180005fbb:     	movq	0x1e8(%rsp), %rax
180005fc3:     	movq	%rax, 0x28(%rsp)
180005fc8:     	movq	0x1e0(%rsp), %rax
180005fd0:     	movq	%rax, 0x20(%rsp)
180005fd5:     	movq	$-0x1, 0x108(%rsp)
180005fe1:     	movq	$0x0, 0xf0(%rsp)
180005fed:     	leaq	0x136(%rsp), %rcx
180005ff5:     	movq	0x128(%rsp), %r8
180005ffd:     	movq	0x138(%rsp), %r9
180006005:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
18000600a:     	movq	0x298(%rsp), %rax
180006012:     	cmpb	$0x0, (%rax)
180006015:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000601b:     	movq	0x8(%rbp), %rcx
18000601f:     	leaq	-0x1(%rcx), %rax
180006023:     	movq	%rax, 0x8(%rbp)
180006027:     	movq	0x2c8(%rsp), %rax
18000602f:     	movq	0x28(%rbx,%rax,8), %rax
180006034:     	testq	%rax, %rax
180006037:     	js	0x18000680c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c4c>
18000603d:     	movq	%rcx, 0x8(%rbp)
180006041:     	cmpq	0x10(%rbp), %rcx
180006045:     	jg	0x18000680c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c4c>
18000604b:     	movq	%r12, 0x100(%rsp)
180006053:     	movq	%rax, 0xf8(%rsp)
18000605b:     	movq	0x2a8(%rsp), %rax
180006063:     	movq	%rax, 0xe8(%rsp)
18000606b:     	movq	0x2a0(%rsp), %rax
180006073:     	movq	%rax, 0xe0(%rsp)
18000607b:     	movq	%rsi, 0xd8(%rsp)
180006083:     	movq	0x290(%rsp), %rax
18000608b:     	movq	%rax, 0xd0(%rsp)
180006093:     	movq	0x288(%rsp), %rax
18000609b:     	movq	%rax, 0xc8(%rsp)
1800060a3:     	movq	0x280(%rsp), %rax
1800060ab:     	movq	%rax, 0xc0(%rsp)
1800060b3:     	movq	0x278(%rsp), %rax
1800060bb:     	movq	%rax, 0xb8(%rsp)
1800060c3:     	movq	0x270(%rsp), %rax
1800060cb:     	movq	%rax, 0xb0(%rsp)
1800060d3:     	movq	0x268(%rsp), %rax
1800060db:     	movq	%rax, 0xa8(%rsp)
1800060e3:     	movq	%rbp, 0xa0(%rsp)
1800060eb:     	movq	%rdi, 0x98(%rsp)
1800060f3:     	movq	0x250(%rsp), %rax
1800060fb:     	movq	%rax, 0x90(%rsp)
180006103:     	movq	0x248(%rsp), %rax
18000610b:     	movq	%rax, 0x88(%rsp)
180006113:     	movq	0x240(%rsp), %rax
18000611b:     	movq	%rax, 0x80(%rsp)
180006123:     	movq	0x238(%rsp), %rax
18000612b:     	movq	%rax, 0x78(%rsp)
180006130:     	movq	%r15, 0x70(%rsp)
180006135:     	movq	%rbx, 0x68(%rsp)
18000613a:     	movq	0x220(%rsp), %rax
180006142:     	movq	%rax, 0x60(%rsp)
180006147:     	movq	0x218(%rsp), %rax
18000614f:     	movq	%rax, 0x58(%rsp)
180006154:     	movq	0x210(%rsp), %rax
18000615c:     	movq	%rax, 0x50(%rsp)
180006161:     	movq	0x208(%rsp), %rax
180006169:     	movq	%rax, 0x48(%rsp)
18000616e:     	movq	0x200(%rsp), %rax
180006176:     	movq	%rax, 0x40(%rsp)
18000617b:     	movq	0x1f8(%rsp), %rax
180006183:     	movq	%rax, 0x38(%rsp)
180006188:     	movq	%r14, 0x30(%rsp)
18000618d:     	movq	0x1e8(%rsp), %rax
180006195:     	movq	%rax, 0x28(%rsp)
18000619a:     	movq	0x1e0(%rsp), %rax
1800061a2:     	movq	%rax, 0x20(%rsp)
1800061a7:     	movq	$-0x1, 0x108(%rsp)
1800061b3:     	movq	$0x0, 0xf0(%rsp)
1800061bf:     	leaq	0x135(%rsp), %rcx
1800061c7:     	movq	0x128(%rsp), %r8
1800061cf:     	movq	0x138(%rsp), %r9
1800061d7:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800061dc:     	movq	0x298(%rsp), %rax
1800061e4:     	cmpb	$0x0, (%rax)
1800061e7:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800061ed:     	movq	0x8(%rbp), %rcx
1800061f1:     	leaq	-0x1(%rcx), %rax
1800061f5:     	movq	%rax, 0x8(%rbp)
1800061f9:     	movq	0x2c8(%rsp), %rax
180006201:     	movq	0x38(%rbx,%rax,8), %rax
180006206:     	testq	%rax, %rax
180006209:     	js	0x18000681c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c5c>
18000620f:     	movq	%rcx, 0x8(%rbp)
180006213:     	cmpq	0x10(%rbp), %rcx
180006217:     	jg	0x18000681c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c5c>
18000621d:     	movq	%r12, 0x100(%rsp)
180006225:     	movq	%rax, 0xf8(%rsp)
18000622d:     	movq	0x2a8(%rsp), %rax
180006235:     	movq	%rax, 0xe8(%rsp)
18000623d:     	movq	0x2a0(%rsp), %rax
180006245:     	movq	%rax, 0xe0(%rsp)
18000624d:     	movq	%rsi, 0xd8(%rsp)
180006255:     	movq	0x290(%rsp), %rax
18000625d:     	movq	%rax, 0xd0(%rsp)
180006265:     	movq	0x288(%rsp), %rax
18000626d:     	movq	%rax, 0xc8(%rsp)
180006275:     	movq	0x280(%rsp), %rax
18000627d:     	movq	%rax, 0xc0(%rsp)
180006285:     	movq	0x278(%rsp), %rax
18000628d:     	movq	%rax, 0xb8(%rsp)
180006295:     	movq	0x270(%rsp), %rax
18000629d:     	movq	%rax, 0xb0(%rsp)
1800062a5:     	movq	0x268(%rsp), %rax
1800062ad:     	movq	%rax, 0xa8(%rsp)
1800062b5:     	movq	%rbp, 0xa0(%rsp)
1800062bd:     	movq	%rdi, 0x98(%rsp)
1800062c5:     	movq	0x250(%rsp), %rax
1800062cd:     	movq	%rax, 0x90(%rsp)
1800062d5:     	movq	0x248(%rsp), %rax
1800062dd:     	movq	%rax, 0x88(%rsp)
1800062e5:     	movq	0x240(%rsp), %rax
1800062ed:     	movq	%rax, 0x80(%rsp)
1800062f5:     	movq	0x238(%rsp), %rax
1800062fd:     	movq	%rax, 0x78(%rsp)
180006302:     	movq	%r15, 0x70(%rsp)
180006307:     	movq	%rbx, 0x68(%rsp)
18000630c:     	movq	0x220(%rsp), %rax
180006314:     	movq	%rax, 0x60(%rsp)
180006319:     	movq	0x218(%rsp), %rax
180006321:     	movq	%rax, 0x58(%rsp)
180006326:     	movq	0x210(%rsp), %rax
18000632e:     	movq	%rax, 0x50(%rsp)
180006333:     	movq	0x208(%rsp), %rax
18000633b:     	movq	%rax, 0x48(%rsp)
180006340:     	movq	0x200(%rsp), %rax
180006348:     	movq	%rax, 0x40(%rsp)
18000634d:     	movq	0x1f8(%rsp), %rax
180006355:     	movq	%rax, 0x38(%rsp)
18000635a:     	movq	%r14, 0x30(%rsp)
18000635f:     	movq	0x1e8(%rsp), %rax
180006367:     	movq	%rax, 0x28(%rsp)
18000636c:     	movq	0x1e0(%rsp), %rax
180006374:     	movq	%rax, 0x20(%rsp)
180006379:     	movq	$-0x1, 0x108(%rsp)
180006385:     	movq	$0x0, 0xf0(%rsp)
180006391:     	leaq	0x134(%rsp), %rcx
180006399:     	movq	0x128(%rsp), %r8
1800063a1:     	movq	0x138(%rsp), %r9
1800063a9:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800063ae:     	movq	0x298(%rsp), %rax
1800063b6:     	cmpb	$0x0, (%rax)
1800063b9:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800063bf:     	movq	0x8(%rbp), %rcx
1800063c3:     	leaq	-0x1(%rcx), %rax
1800063c7:     	movq	%rax, 0x8(%rbp)
1800063cb:     	movq	0x2c8(%rsp), %rax
1800063d3:     	movq	0x40(%rbx,%rax,8), %rax
1800063d8:     	testq	%rax, %rax
1800063db:     	js	0x18000682c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c6c>
1800063e1:     	movq	%rcx, 0x8(%rbp)
1800063e5:     	cmpq	0x10(%rbp), %rcx
1800063e9:     	jg	0x18000682c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c6c>
1800063ef:     	movq	%r12, 0x100(%rsp)
1800063f7:     	movq	%rax, 0xf8(%rsp)
1800063ff:     	movq	0x2a8(%rsp), %rax
180006407:     	movq	%rax, 0xe8(%rsp)
18000640f:     	movq	0x2a0(%rsp), %rax
180006417:     	movq	%rax, 0xe0(%rsp)
18000641f:     	movq	%rsi, 0xd8(%rsp)
180006427:     	movq	0x290(%rsp), %rax
18000642f:     	movq	%rax, 0xd0(%rsp)
180006437:     	movq	0x288(%rsp), %rax
18000643f:     	movq	%rax, 0xc8(%rsp)
180006447:     	movq	0x280(%rsp), %rax
18000644f:     	movq	%rax, 0xc0(%rsp)
180006457:     	movq	0x278(%rsp), %rax
18000645f:     	movq	%rax, 0xb8(%rsp)
180006467:     	movq	0x270(%rsp), %rax
18000646f:     	movq	%rax, 0xb0(%rsp)
180006477:     	movq	0x268(%rsp), %rax
18000647f:     	movq	%rax, 0xa8(%rsp)
180006487:     	movq	%rbp, 0xa0(%rsp)
18000648f:     	movq	%rdi, 0x98(%rsp)
180006497:     	movq	0x250(%rsp), %rax
18000649f:     	movq	%rax, 0x90(%rsp)
1800064a7:     	movq	0x248(%rsp), %rax
1800064af:     	movq	%rax, 0x88(%rsp)
1800064b7:     	movq	0x240(%rsp), %rax
1800064bf:     	movq	%rax, 0x80(%rsp)
1800064c7:     	movq	0x238(%rsp), %rax
1800064cf:     	movq	%rax, 0x78(%rsp)
1800064d4:     	movq	%r15, 0x70(%rsp)
1800064d9:     	movq	%rbx, 0x68(%rsp)
1800064de:     	movq	0x220(%rsp), %rax
1800064e6:     	movq	%rax, 0x60(%rsp)
1800064eb:     	movq	0x218(%rsp), %rax
1800064f3:     	movq	%rax, 0x58(%rsp)
1800064f8:     	movq	0x210(%rsp), %rax
180006500:     	movq	%rax, 0x50(%rsp)
180006505:     	movq	0x208(%rsp), %rax
18000650d:     	movq	%rax, 0x48(%rsp)
180006512:     	movq	0x200(%rsp), %rax
18000651a:     	movq	%rax, 0x40(%rsp)
18000651f:     	movq	0x1f8(%rsp), %rax
180006527:     	movq	%rax, 0x38(%rsp)
18000652c:     	movq	%r14, 0x30(%rsp)
180006531:     	movq	0x1e8(%rsp), %rax
180006539:     	movq	%rax, 0x28(%rsp)
18000653e:     	movq	0x1e0(%rsp), %rax
180006546:     	movq	%rax, 0x20(%rsp)
18000654b:     	movq	$-0x1, 0x108(%rsp)
180006557:     	movq	$0x0, 0xf0(%rsp)
180006563:     	leaq	0x133(%rsp), %rcx
18000656b:     	movq	0x128(%rsp), %r8
180006573:     	movq	0x138(%rsp), %r9
18000657b:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
180006580:     	cmpb	$0x0, (%rsi)
180006583:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
180006589:     	incq	%r13
18000658c:     	decq	0x8(%rbp)
180006590:     	movq	0x148(%rsp), %rax
180006598:     	movq	0x150(%rsp), %rcx
1800065a0:     	cmpq	(%rcx,%rax,8), %r13
1800065a4:     	jl	0x180005e26 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2266>
1800065aa:     	movq	(%rbp), %rax
1800065ae:     	cmpq	%r15, %rax
1800065b1:     	movq	%rax, %rcx
1800065b4:     	jle	0x1800065bf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x29ff>
1800065b6:     	movb	$0x2, (%rsi)
1800065b9:     	movq	(%rbp), %rax
1800065bd:     	xorl	%ecx, %ecx
1800065bf:     	leaq	0x3(%rax), %rdx
1800065c3:     	cmpq	%r15, %rdx
1800065c6:     	jg	0x180004cb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x10f8>
1800065cc:     	movq	%rdx, (%rbp)
1800065d0:     	cmpb	$0x0, (%rsi)
1800065d3:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800065d9:     	movq	%rax, %rdx
1800065dc:     	sarq	$0x3f, %rdx
1800065e0:     	andq	%r15, %rdx
1800065e3:     	leaq	(%rbx,%rax,8), %r8
1800065e7:     	movq	$0x0, (%r8,%rdx,8)
1800065ef:     	xorl	%r12d, %r12d
1800065f2:     	cmpq	$-0x1, %rax
1800065f6:     	movl	$0x0, %edx
1800065fb:     	cmovlq	%r15, %rdx
1800065ff:     	movq	$0x0, 0x8(%r8,%rdx,8)
180006608:     	cmpq	$-0x2, %rax
18000660c:     	cmovgeq	%r12, %r15
180006610:     	movq	%rcx, 0x10(%r8,%r15,8)
180006615:     	cmpb	$0x0, (%rsi)
180006618:     	movq	0x118(%rsp), %rcx
180006620:     	jne	0x1800050fe <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153e>
180006626:     	movq	0x2c8(%rsp), %rdx
18000662e:     	movq	%rax, 0x30(%rbx,%rdx,8)
180006633:     	jmp	0x1800050fb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x153b>
180006638:     	movb	$0x0, 0x124(%rsp)
180006640:     	movq	%rsi, 0x100(%rsp)
180006648:     	movq	%rcx, 0xf8(%rsp)
180006650:     	movq	0x2a8(%rsp), %rax
180006658:     	movq	%rax, 0xe8(%rsp)
180006660:     	movq	0x2a0(%rsp), %rax
180006668:     	movq	%rax, 0xe0(%rsp)
180006670:     	movq	0x290(%rsp), %rax
180006678:     	movq	%rax, 0xd0(%rsp)
180006680:     	movq	0x288(%rsp), %rax
180006688:     	movq	%rax, 0xc8(%rsp)
180006690:     	movq	0x280(%rsp), %rax
180006698:     	movq	%rax, 0xc0(%rsp)
1800066a0:     	movq	0x278(%rsp), %rax
1800066a8:     	movq	%rax, 0xb8(%rsp)
1800066b0:     	movq	0x270(%rsp), %rax
1800066b8:     	movq	%rax, 0xb0(%rsp)
1800066c0:     	movq	0x268(%rsp), %rax
1800066c8:     	movq	%rax, 0xa8(%rsp)
1800066d0:     	movq	0x258(%rsp), %rax
1800066d8:     	movq	%rax, 0x98(%rsp)
1800066e0:     	movq	0x250(%rsp), %rax
1800066e8:     	movq	%rax, 0x90(%rsp)
1800066f0:     	movq	0x248(%rsp), %rax
1800066f8:     	movq	%rax, 0x88(%rsp)
180006700:     	movq	0x240(%rsp), %rax
180006708:     	movq	%rax, 0x80(%rsp)
180006710:     	movq	0x238(%rsp), %rax
180006718:     	movq	%rax, 0x78(%rsp)
18000671d:     	movq	%r15, 0x70(%rsp)
180006722:     	movq	%rbx, 0x68(%rsp)
180006727:     	movq	0x220(%rsp), %rax
18000672f:     	movq	%rax, 0x60(%rsp)
180006734:     	movq	0x218(%rsp), %rax
18000673c:     	movq	%rax, 0x58(%rsp)
180006741:     	movq	0x210(%rsp), %rax
180006749:     	movq	%rax, 0x50(%rsp)
18000674e:     	movq	0x208(%rsp), %rax
180006756:     	movq	%rax, 0x48(%rsp)
18000675b:     	movq	0x200(%rsp), %rax
180006763:     	movq	%rax, 0x40(%rsp)
180006768:     	movq	0x1f8(%rsp), %rax
180006770:     	movq	%rax, 0x38(%rsp)
180006775:     	movq	%r14, 0x30(%rsp)
18000677a:     	movq	0x1e8(%rsp), %rax
180006782:     	movq	%rax, 0x28(%rsp)
180006787:     	movq	0x298(%rsp), %rsi
18000678f:     	movq	%rsi, 0xd8(%rsp)
180006797:     	movq	%rbp, 0xa0(%rsp)
18000679f:     	movq	0x1e0(%rsp), %rax
1800067a7:     	movq	%rax, 0x20(%rsp)
1800067ac:     	movq	$-0x1, 0x108(%rsp)
1800067b8:     	movq	$0x0, 0xf0(%rsp)
1800067c4:     	leaq	0x124(%rsp), %rcx
1800067cc:     	movq	0x128(%rsp), %r8
1800067d4:     	movq	0x138(%rsp), %r9
1800067dc:     	callq	0x180004870 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0xcb0>
1800067e1:     	cmpb	$0x0, (%rsi)
1800067e4:     	jne	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
1800067ea:     	movzbl	0x124(%rsp), %r12d
1800067f3:     	decq	0x8(%rbp)
1800067f7:     	jmp	0x1800052e1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x1721>
1800067fc:     	movb	$0x1, (%rsi)
1800067ff:     	movq	$0x989697, 0x18(%rbp)   # imm = 0x989697
180006807:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000680c:     	movb	$0x1, (%rsi)
18000680f:     	movq	$0x989698, 0x18(%rbp)   # imm = 0x989698
180006817:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000681c:     	movb	$0x1, (%rsi)
18000681f:     	movq	$0x989699, 0x18(%rbp)   # imm = 0x989699
180006827:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000682c:     	movb	$0x1, (%rsi)
18000682f:     	movq	$0x98969a, 0x18(%rbp)   # imm = 0x98969A
180006837:     	jmp	0x1800050ad <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x14ed>
18000683c:     	nopl	(%rax)
180006840:     	pushq	%r15
180006842:     	pushq	%r14
180006844:     	pushq	%r13
180006846:     	pushq	%r12
180006848:     	pushq	%rsi
180006849:     	pushq	%rdi
18000684a:     	pushq	%rbp
18000684b:     	pushq	%rbx
18000684c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180006853:     	movapd	%xmm8, 0x1d0(%rsp)
18000685d:     	movapd	%xmm7, 0x1c0(%rsp)
180006866:     	movapd	%xmm6, 0x1b0(%rsp)
18000686f:     	movq	0x320(%rsp), %rsi
180006877:     	movq	0x260(%rsp), %r14
18000687f:     	movq	$0x0, 0x150(%rsp)
18000688b:     	movb	$0x0, 0x158(%rsp)
180006893:     	movq	$0x0, 0x160(%rsp)
18000689f:     	movq	$0x0, 0x130(%rsp)
1800068ab:     	movb	$0x0, 0x138(%rsp)
1800068b3:     	movq	$0x0, 0x140(%rsp)
1800068bf:     	movsd	0x48(%r14,%rsi,8), %xmm0
1800068c6:     	xorpd	%xmm1, %xmm1
1800068ca:     	ucomisd	%xmm1, %xmm0
1800068ce:     	jne	0x1800068e7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d27>
1800068d0:     	jp	0x1800068e7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d27>
1800068d2:     	movb	$0x1, 0x18(%rcx)
1800068d6:     	movq	$0x0, 0x10(%rcx)
1800068de:     	movb	$0x1, 0x8(%rcx)
1800068e2:     	jmp	0x180006a6c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2eac>
1800068e7:     	movq	0x328(%rsp), %rbp
1800068ef:     	movq	0x2a0(%rsp), %r13
1800068f7:     	movq	0x298(%rsp), %r12
1800068ff:     	movq	0x30(%r12,%rsi,8), %rax
180006904:     	movq	%rax, %r10
180006907:     	sarq	$0x3f, %r10
18000690b:     	andq	%r13, %r10
18000690e:     	leaq	(%r12,%rax,8), %rdx
180006912:     	cmpq	$0x1, (%rdx,%r10,8)
180006917:     	jne	0x18000693a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d7a>
180006919:     	xorl	%r10d, %r10d
18000691c:     	cmpq	$-0x2, %rax
180006920:     	cmovlq	%r13, %r10
180006924:     	movq	0x10(%rdx,%r10,8), %rax
180006929:     	leaq	(%r12,%rax,8), %rdx
18000692d:     	sarq	$0x3f, %rax
180006931:     	andq	%r13, %rax
180006934:     	cmpq	%rbp, (%rdx,%rax,8)
180006938:     	je	0x1800068d2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2d12>
18000693a:     	movq	0x308(%rsp), %r15
180006942:     	movq	0x2d0(%rsp), %rbx
18000694a:     	movq	0x10(%r12,%rsi,8), %rdx
18000694f:     	testq	%rdx, %rdx
180006952:     	js	0x180006a48 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e88>
180006958:     	testq	%rbp, %rbp
18000695b:     	js	0x180006a48 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e88>
180006961:     	movq	0x10(%r12,%rbp,8), %r10
180006966:     	testq	%r10, %r10
180006969:     	js	0x180006a48 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e88>
18000696f:     	movsd	(%r14,%rdx,8), %xmm1
180006975:     	cmpq	$0x0, 0x8(%r12,%rdx,8)
18000697b:     	setne	%r11b
18000697f:     	cmpq	$0x0, 0x8(%r12,%r10,8)
180006985:     	setne	%al
180006988:     	subsd	(%r14,%r10,8), %xmm1
18000698e:     	andb	%r11b, %al
180006991:     	cmpb	$0x1, %al
180006993:     	jne	0x1800069b7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2df7>
180006995:     	movapd	0x6a23(%rip), %xmm2     # 0x18000d3c0
18000699d:     	andpd	%xmm1, %xmm2
1800069a1:     	ucomisd	0x6a27(%rip), %xmm2     # 0x18000d3d0
1800069a9:     	jae	0x180006a48 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e88>
1800069af:     	xorpd	%xmm2, %xmm2
1800069b3:     	addsd	%xmm2, %xmm1
1800069b7:     	movsd	0x10(%r14,%rdx,8), %xmm2
1800069be:     	cmpq	$0x0, 0x18(%r12,%rdx,8)
1800069c4:     	subsd	0x10(%r14,%r10,8), %xmm2
1800069cb:     	je	0x180006aa2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2ee2>
1800069d1:     	cmpq	$0x0, 0x18(%r12,%r10,8)
1800069d7:     	je	0x180006aa2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2ee2>
1800069dd:     	movapd	0x69db(%rip), %xmm3     # 0x18000d3c0
1800069e5:     	andpd	%xmm2, %xmm3
1800069e9:     	ucomisd	0x69df(%rip), %xmm3     # 0x18000d3d0
1800069f1:     	jae	0x180006b0a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f4a>
1800069f7:     	movapd	%xmm1, %xmm3
1800069fb:     	mulsd	%xmm1, %xmm3
1800069ff:     	ucomisd	0x69c9(%rip), %xmm3     # 0x18000d3d0
180006a07:     	setae	%dl
180006a0a:     	testb	%dl, %al
180006a0c:     	jne	0x180006abb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2efb>
180006a12:     	xorpd	%xmm4, %xmm4
180006a16:     	addsd	%xmm4, %xmm2
180006a1a:     	movapd	%xmm2, %xmm4
180006a1e:     	mulsd	%xmm2, %xmm4
180006a22:     	ucomisd	0x69a6(%rip), %xmm4     # 0x18000d3d0
180006a2a:     	jae	0x180006abb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2efb>
180006a30:     	addsd	%xmm4, %xmm3
180006a34:     	ucomisd	0x6994(%rip), %xmm3     # 0x18000d3d0
180006a3c:     	setae	%dl
180006a3f:     	testb	%dl, %al
180006a41:     	jne	0x180006abb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2efb>
180006a43:     	jmp	0x180006ad5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f15>
180006a48:     	movb	$0x1, (%r15)
180006a4c:     	movq	$0x3d090a, 0x18(%rbx)   # imm = 0x3D090A
180006a54:     	movq	$0x0, 0x18(%rcx)
180006a5c:     	movq	$0x0, 0x10(%rcx)
180006a64:     	movq	$0x0, 0x8(%rcx)
180006a6c:     	movq	$0x0, (%rcx)
180006a73:     	xorl	%eax, %eax
180006a75:     	movaps	0x1b0(%rsp), %xmm6
180006a7d:     	movaps	0x1c0(%rsp), %xmm7
180006a85:     	movaps	0x1d0(%rsp), %xmm8
180006a8e:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180006a95:     	popq	%rbx
180006a96:     	popq	%rbp
180006a97:     	popq	%rdi
180006a98:     	popq	%rsi
180006a99:     	popq	%r12
180006a9b:     	popq	%r13
180006a9d:     	popq	%r14
180006a9f:     	popq	%r15
180006aa1:     	retq
180006aa2:     	movapd	%xmm1, %xmm3
180006aa6:     	mulsd	%xmm1, %xmm3
180006aaa:     	ucomisd	0x691e(%rip), %xmm3     # 0x18000d3d0
180006ab2:     	setae	%dl
180006ab5:     	andb	%dl, %al
180006ab7:     	cmpb	$0x1, %al
180006ab9:     	jne	0x180006ac9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f09>
180006abb:     	movb	$0x1, (%r15)
180006abf:     	movq	$0x3d090c, 0x18(%rbx)   # imm = 0x3D090C
180006ac7:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180006ac9:     	movapd	%xmm2, %xmm4
180006acd:     	mulsd	%xmm2, %xmm4
180006ad1:     	addsd	%xmm4, %xmm3
180006ad5:     	xorps	%xmm4, %xmm4
180006ad8:     	sqrtsd	%xmm3, %xmm4
180006adc:     	cmpq	$0x0, 0x18(%r12,%rsi,8)
180006ae2:     	je	0x180006b39 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f79>
180006ae4:     	movq	(%r12,%rsi,8), %rax
180006ae8:     	testq	%rax, %rax
180006aeb:     	js	0x180006af9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f39>
180006aed:     	xorpd	%xmm5, %xmm5
180006af1:     	ucomisd	%xmm5, %xmm3
180006af5:     	jne	0x180006b1b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f5b>
180006af7:     	jp	0x180006b1b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2f5b>
180006af9:     	movb	$0x1, (%r15)
180006afd:     	movq	$0x3d090f, 0x18(%rbx)   # imm = 0x3D090F
180006b05:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180006b0a:     	movb	$0x1, (%r15)
180006b0e:     	movq	$0x3d090b, 0x18(%rbx)   # imm = 0x3D090B
180006b16:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180006b1b:     	movsd	0x330(%rsp), %xmm6
180006b24:     	movsd	0x8(%r14,%rax,8), %xmm3
180006b2b:     	addsd	%xmm3, %xmm3
180006b2f:     	divsd	%xmm4, %xmm3
180006b33:     	ucomisd	%xmm3, %xmm6
180006b37:     	jbe	0x180006ba7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2fe7>
180006b39:     	movsd	0x6897(%rip), %xmm3     # 0x18000d3d8
180006b41:     	maxsd	%xmm4, %xmm3
180006b45:     	movapd	%xmm3, %xmm4
180006b49:     	mulsd	%xmm3, %xmm4
180006b4d:     	xorpd	%xmm5, %xmm5
180006b51:     	ucomisd	%xmm5, %xmm4
180006b55:     	jne	0x180006b6a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2faa>
180006b57:     	jp	0x180006b6a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2faa>
180006b59:     	movb	$0x1, (%r15)
180006b5d:     	movq	$0x3d0915, 0x18(%rbx)   # imm = 0x3D0915
180006b65:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180006b6a:     	movsd	0x8(%r14,%rbp,8), %xmm5
180006b71:     	mulsd	0x6867(%rip), %xmm5     # 0x18000d3e0
180006b79:     	mulsd	%xmm5, %xmm0
180006b7d:     	divsd	%xmm4, %xmm0
180006b81:     	mulsd	%xmm0, %xmm1
180006b85:     	divsd	%xmm3, %xmm1
180006b89:     	mulsd	%xmm0, %xmm2
180006b8d:     	divsd	%xmm3, %xmm2
180006b91:     	movsd	%xmm2, 0x10(%rcx)
180006b96:     	movsd	%xmm1, (%rcx)
180006b9a:     	movb	$0x0, 0x18(%rcx)
180006b9e:     	movb	$0x0, 0x8(%rcx)
180006ba2:     	jmp	0x180006a73 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2eb3>
180006ba7:     	movq	0x2a8(%rsp), %rdi
180006baf:     	movq	0x290(%rsp), %r11
180006bb7:     	movq	0x20(%r12,%rsi,8), %rax
180006bbc:     	testq	%rax, %rax
180006bbf:     	js	0x180006dbf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x31ff>
180006bc5:     	movq	0x8(%rbx), %rdx
180006bc9:     	leaq	0x1(%rdx), %r10
180006bcd:     	movq	%r10, 0x8(%rbx)
180006bd1:     	cmpq	0x10(%rbx), %rdx
180006bd5:     	jge	0x1800071f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3634>
180006bdb:     	movq	%rcx, 0x118(%rsp)
180006be3:     	movsd	%xmm6, 0x100(%rsp)
180006bec:     	movq	%rbp, 0xf8(%rsp)
180006bf4:     	movq	%rax, 0xf0(%rsp)
180006bfc:     	movq	0x318(%rsp), %rax
180006c04:     	movq	%rax, 0xe8(%rsp)
180006c0c:     	movq	0x310(%rsp), %rax
180006c14:     	movq	%rax, 0xe0(%rsp)
180006c1c:     	movq	%r15, 0xd8(%rsp)
180006c24:     	movq	0x300(%rsp), %rax
180006c2c:     	movq	%rax, 0xd0(%rsp)
180006c34:     	movq	0x2f8(%rsp), %rax
180006c3c:     	movq	%rax, 0xc8(%rsp)
180006c44:     	movq	0x2f0(%rsp), %rax
180006c4c:     	movq	%rax, 0xc0(%rsp)
180006c54:     	movq	0x2e8(%rsp), %rax
180006c5c:     	movq	%rax, 0xb8(%rsp)
180006c64:     	movq	0x2e0(%rsp), %rax
180006c6c:     	movq	%rax, 0xb0(%rsp)
180006c74:     	movq	0x2d8(%rsp), %rax
180006c7c:     	movq	%rax, 0xa8(%rsp)
180006c84:     	movq	%rbx, 0xa0(%rsp)
180006c8c:     	movq	0x2c8(%rsp), %rax
180006c94:     	movq	%rax, 0x98(%rsp)
180006c9c:     	movq	0x2c0(%rsp), %rax
180006ca4:     	movq	%rax, 0x90(%rsp)
180006cac:     	movq	0x2b8(%rsp), %rax
180006cb4:     	movq	%rax, 0x88(%rsp)
180006cbc:     	movq	0x2b0(%rsp), %rax
180006cc4:     	movq	%rax, 0x80(%rsp)
180006ccc:     	movq	%rdi, 0x78(%rsp)
180006cd1:     	movq	%r13, 0x70(%rsp)
180006cd6:     	movq	%r12, 0x68(%rsp)
180006cdb:     	movq	%r11, 0x60(%rsp)
180006ce0:     	movq	0x288(%rsp), %rax
180006ce8:     	movq	%rax, 0x58(%rsp)
180006ced:     	movq	0x280(%rsp), %rax
180006cf5:     	movq	%rax, 0x50(%rsp)
180006cfa:     	movq	0x278(%rsp), %rax
180006d02:     	movq	%rax, 0x48(%rsp)
180006d07:     	movq	0x270(%rsp), %rax
180006d0f:     	movq	%rax, 0x40(%rsp)
180006d14:     	movq	0x268(%rsp), %rax
180006d1c:     	movq	%rax, 0x38(%rsp)
180006d21:     	movq	%r14, 0x30(%rsp)
180006d26:     	movq	0x258(%rsp), %rax
180006d2e:     	movq	%rax, 0x28(%rsp)
180006d33:     	movq	0x250(%rsp), %rax
180006d3b:     	movq	%rax, 0x20(%rsp)
180006d40:     	leaq	0x190(%rsp), %rcx
180006d48:     	movq	%r8, 0x120(%rsp)
180006d50:     	movq	%r9, %rdi
180006d53:     	callq	0x180006840 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c80>
180006d58:     	cmpb	$0x0, (%r15)
180006d5c:     	jne	0x18000745f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x389f>
180006d62:     	cmpb	$0x0, 0x1a8(%rsp)
180006d6a:     	setne	%r10b
180006d6e:     	cmpb	$0x0, 0x198(%rsp)
180006d76:     	setne	%dl
180006d79:     	xorpd	%xmm8, %xmm8
180006d7e:     	movsd	0x190(%rsp), %xmm7
180006d87:     	addsd	%xmm8, %xmm7
180006d8c:     	addsd	0x1a0(%rsp), %xmm8
180006d96:     	decq	0x8(%rbx)
180006d9a:     	movq	0x118(%rsp), %rcx
180006da2:     	movq	%rdi, %r9
180006da5:     	movq	0x120(%rsp), %r8
180006dad:     	movq	0x290(%rsp), %r11
180006db5:     	movq	0x2a8(%rsp), %rdi
180006dbd:     	jmp	0x180006dcd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x320d>
180006dbf:     	movb	$0x1, %dl
180006dc1:     	xorpd	%xmm7, %xmm7
180006dc5:     	xorpd	%xmm8, %xmm8
180006dca:     	movb	$0x1, %r10b
180006dcd:     	movq	0x28(%r12,%rsi,8), %rax
180006dd2:     	testq	%rax, %rax
180006dd5:     	js	0x180006fed <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x342d>
180006ddb:     	movb	%r10b, 0x116(%rsp)
180006de3:     	movb	%dl, 0x117(%rsp)
180006dea:     	movq	0x8(%rbx), %rdx
180006dee:     	leaq	0x1(%rdx), %r10
180006df2:     	movq	%r10, 0x8(%rbx)
180006df6:     	cmpq	0x10(%rbx), %rdx
180006dfa:     	jge	0x180007205 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3645>
180006e00:     	movq	%rcx, 0x118(%rsp)
180006e08:     	movsd	%xmm6, 0x100(%rsp)
180006e11:     	movq	%rbp, 0xf8(%rsp)
180006e19:     	movq	%rax, 0xf0(%rsp)
180006e21:     	movq	0x318(%rsp), %rax
180006e29:     	movq	%rax, 0xe8(%rsp)
180006e31:     	movq	0x310(%rsp), %rax
180006e39:     	movq	%rax, 0xe0(%rsp)
180006e41:     	movq	%r15, 0xd8(%rsp)
180006e49:     	movq	0x300(%rsp), %rax
180006e51:     	movq	%rax, 0xd0(%rsp)
180006e59:     	movq	0x2f8(%rsp), %rax
180006e61:     	movq	%rax, 0xc8(%rsp)
180006e69:     	movq	0x2f0(%rsp), %rax
180006e71:     	movq	%rax, 0xc0(%rsp)
180006e79:     	movq	0x2e8(%rsp), %rax
180006e81:     	movq	%rax, 0xb8(%rsp)
180006e89:     	movq	0x2e0(%rsp), %rax
180006e91:     	movq	%rax, 0xb0(%rsp)
180006e99:     	movq	0x2d8(%rsp), %rax
180006ea1:     	movq	%rax, 0xa8(%rsp)
180006ea9:     	movq	%rbx, 0xa0(%rsp)
180006eb1:     	movq	0x2c8(%rsp), %rax
180006eb9:     	movq	%rax, 0x98(%rsp)
180006ec1:     	movq	0x2c0(%rsp), %rax
180006ec9:     	movq	%rax, 0x90(%rsp)
180006ed1:     	movq	0x2b8(%rsp), %rax
180006ed9:     	movq	%rax, 0x88(%rsp)
180006ee1:     	movq	0x2b0(%rsp), %rax
180006ee9:     	movq	%rax, 0x80(%rsp)
180006ef1:     	movq	%rdi, 0x78(%rsp)
180006ef6:     	movq	%r13, 0x70(%rsp)
180006efb:     	movq	%r12, 0x68(%rsp)
180006f00:     	movq	%r11, 0x60(%rsp)
180006f05:     	movq	0x288(%rsp), %rax
180006f0d:     	movq	%rax, 0x58(%rsp)
180006f12:     	movq	0x280(%rsp), %rax
180006f1a:     	movq	%rax, 0x50(%rsp)
180006f1f:     	movq	0x278(%rsp), %rax
180006f27:     	movq	%rax, 0x48(%rsp)
180006f2c:     	movq	0x270(%rsp), %rax
180006f34:     	movq	%rax, 0x40(%rsp)
180006f39:     	movq	0x268(%rsp), %rax
180006f41:     	movq	%rax, 0x38(%rsp)
180006f46:     	movq	%r14, 0x30(%rsp)
180006f4b:     	movq	0x258(%rsp), %rax
180006f53:     	movq	%rax, 0x28(%rsp)
180006f58:     	movq	0x250(%rsp), %rax
180006f60:     	movq	%rax, 0x20(%rsp)
180006f65:     	leaq	0x170(%rsp), %rcx
180006f6d:     	movq	%r8, 0x120(%rsp)
180006f75:     	movq	%r9, %rdi
180006f78:     	callq	0x180006840 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c80>
180006f7d:     	cmpb	$0x0, (%r15)
180006f81:     	jne	0x18000745f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x389f>
180006f87:     	cmpb	$0x0, 0x188(%rsp)
180006f8f:     	setne	%al
180006f92:     	cmpb	$0x0, 0x178(%rsp)
180006f9a:     	setne	%cl
180006f9d:     	addsd	0x170(%rsp), %xmm7
180006fa6:     	addsd	0x180(%rsp), %xmm8
180006fb0:     	decq	0x8(%rbx)
180006fb4:     	movzbl	0x117(%rsp), %edx
180006fbc:     	andb	%cl, %dl
180006fbe:     	movzbl	0x116(%rsp), %r10d
180006fc7:     	andb	%al, %r10b
180006fca:     	movq	0x118(%rsp), %rcx
180006fd2:     	movq	%rdi, %r9
180006fd5:     	movq	0x120(%rsp), %r8
180006fdd:     	movq	0x290(%rsp), %r11
180006fe5:     	movq	0x2a8(%rsp), %rdi
180006fed:     	movq	0x38(%r12,%rsi,8), %rax
180006ff2:     	testq	%rax, %rax
180006ff5:     	js	0x180007216 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3656>
180006ffb:     	movb	%r10b, 0x116(%rsp)
180007003:     	movb	%dl, 0x117(%rsp)
18000700a:     	movq	0x8(%rbx), %rdx
18000700e:     	leaq	0x1(%rdx), %r10
180007012:     	movq	%r10, 0x8(%rbx)
180007016:     	cmpq	0x10(%rbx), %rdx
18000701a:     	jge	0x180007442 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3882>
180007020:     	movq	%rcx, 0x118(%rsp)
180007028:     	movsd	%xmm6, 0x100(%rsp)
180007031:     	movq	%rbp, 0xf8(%rsp)
180007039:     	movq	%rax, 0xf0(%rsp)
180007041:     	movq	0x318(%rsp), %rax
180007049:     	movq	%rax, 0xe8(%rsp)
180007051:     	movq	0x310(%rsp), %rax
180007059:     	movq	%rax, 0xe0(%rsp)
180007061:     	movq	%r15, 0xd8(%rsp)
180007069:     	movq	0x300(%rsp), %rax
180007071:     	movq	%rax, 0xd0(%rsp)
180007079:     	movq	0x2f8(%rsp), %rax
180007081:     	movq	%rax, 0xc8(%rsp)
180007089:     	movq	0x2f0(%rsp), %rax
180007091:     	movq	%rax, 0xc0(%rsp)
180007099:     	movq	0x2e8(%rsp), %rax
1800070a1:     	movq	%rax, 0xb8(%rsp)
1800070a9:     	movq	0x2e0(%rsp), %rax
1800070b1:     	movq	%rax, 0xb0(%rsp)
1800070b9:     	movq	0x2d8(%rsp), %rax
1800070c1:     	movq	%rax, 0xa8(%rsp)
1800070c9:     	movq	%rbx, 0xa0(%rsp)
1800070d1:     	movq	0x2c8(%rsp), %rax
1800070d9:     	movq	%rax, 0x98(%rsp)
1800070e1:     	movq	0x2c0(%rsp), %rax
1800070e9:     	movq	%rax, 0x90(%rsp)
1800070f1:     	movq	0x2b8(%rsp), %rax
1800070f9:     	movq	%rax, 0x88(%rsp)
180007101:     	movq	0x2b0(%rsp), %rax
180007109:     	movq	%rax, 0x80(%rsp)
180007111:     	movq	%rdi, 0x78(%rsp)
180007116:     	movq	%r13, 0x70(%rsp)
18000711b:     	movq	%r12, 0x68(%rsp)
180007120:     	movq	%r11, %rdi
180007123:     	movq	%r11, 0x60(%rsp)
180007128:     	movq	0x288(%rsp), %rax
180007130:     	movq	%rax, 0x58(%rsp)
180007135:     	movq	0x280(%rsp), %rax
18000713d:     	movq	%rax, 0x50(%rsp)
180007142:     	movq	0x278(%rsp), %rax
18000714a:     	movq	%rax, 0x48(%rsp)
18000714f:     	movq	0x270(%rsp), %rax
180007157:     	movq	%rax, 0x40(%rsp)
18000715c:     	movq	0x268(%rsp), %rax
180007164:     	movq	%rax, 0x38(%rsp)
180007169:     	movq	%r14, 0x30(%rsp)
18000716e:     	movq	0x258(%rsp), %rax
180007176:     	movq	%rax, 0x28(%rsp)
18000717b:     	movq	0x250(%rsp), %rax
180007183:     	movq	%rax, 0x20(%rsp)
180007188:     	leaq	0x150(%rsp), %rcx
180007190:     	movq	%r8, 0x120(%rsp)
180007198:     	movq	%r9, 0x128(%rsp)
1800071a0:     	callq	0x180006840 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c80>
1800071a5:     	cmpb	$0x0, (%r15)
1800071a9:     	jne	0x18000745f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x389f>
1800071af:     	cmpb	$0x0, 0x168(%rsp)
1800071b7:     	setne	%al
1800071ba:     	cmpb	$0x0, 0x158(%rsp)
1800071c2:     	setne	%cl
1800071c5:     	addsd	0x150(%rsp), %xmm7
1800071ce:     	addsd	0x160(%rsp), %xmm8
1800071d8:     	decq	0x8(%rbx)
1800071dc:     	movzbl	0x117(%rsp), %edx
1800071e4:     	andb	%cl, %dl
1800071e6:     	movzbl	0x116(%rsp), %r10d
1800071ef:     	andb	%al, %r10b
1800071f2:     	jmp	0x180007231 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3671>
1800071f4:     	movb	$0x1, (%r15)
1800071f8:     	movq	$0x3d0921, 0x18(%rbx)   # imm = 0x3D0921
180007200:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180007205:     	movb	$0x1, (%r15)
180007209:     	movq	$0x3d0926, 0x18(%rbx)   # imm = 0x3D0926
180007211:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180007216:     	movq	%r11, %rdi
180007219:     	movq	%r8, 0x120(%rsp)
180007221:     	movq	%r9, 0x128(%rsp)
180007229:     	movq	%rcx, 0x118(%rsp)
180007231:     	movq	0x40(%r12,%rsi,8), %rax
180007236:     	testq	%rax, %rax
180007239:     	js	0x180007424 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3864>
18000723f:     	movb	%r10b, 0x116(%rsp)
180007247:     	movl	%edx, %esi
180007249:     	movq	0x8(%rbx), %rcx
18000724d:     	leaq	0x1(%rcx), %rdx
180007251:     	movq	%rdx, 0x8(%rbx)
180007255:     	cmpq	0x10(%rbx), %rcx
180007259:     	jge	0x180007453 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3893>
18000725f:     	movq	%rbp, 0xf8(%rsp)
180007267:     	movq	%rax, 0xf0(%rsp)
18000726f:     	movq	0x318(%rsp), %rax
180007277:     	movq	%rax, 0xe8(%rsp)
18000727f:     	movq	0x310(%rsp), %rax
180007287:     	movq	%rax, 0xe0(%rsp)
18000728f:     	movq	0x300(%rsp), %rax
180007297:     	movq	%rax, 0xd0(%rsp)
18000729f:     	movq	0x2f8(%rsp), %rax
1800072a7:     	movq	%rax, 0xc8(%rsp)
1800072af:     	movq	0x2f0(%rsp), %rax
1800072b7:     	movq	%rax, 0xc0(%rsp)
1800072bf:     	movq	0x2e8(%rsp), %rax
1800072c7:     	movq	%rax, 0xb8(%rsp)
1800072cf:     	movq	0x2e0(%rsp), %rax
1800072d7:     	movq	%rax, 0xb0(%rsp)
1800072df:     	movq	0x2d8(%rsp), %rax
1800072e7:     	movq	%rax, 0xa8(%rsp)
1800072ef:     	movq	0x2c8(%rsp), %rax
1800072f7:     	movq	%rax, 0x98(%rsp)
1800072ff:     	movq	0x2c0(%rsp), %rax
180007307:     	movq	%rax, 0x90(%rsp)
18000730f:     	movq	0x2b8(%rsp), %rax
180007317:     	movq	%rax, 0x88(%rsp)
18000731f:     	movq	0x2b0(%rsp), %rax
180007327:     	movq	%rax, 0x80(%rsp)
18000732f:     	movq	0x2a8(%rsp), %rax
180007337:     	movq	%rax, 0x78(%rsp)
18000733c:     	movq	%r13, 0x70(%rsp)
180007341:     	movq	%r12, 0x68(%rsp)
180007346:     	movq	%rdi, 0x60(%rsp)
18000734b:     	movq	0x288(%rsp), %rax
180007353:     	movq	%rax, 0x58(%rsp)
180007358:     	movq	0x280(%rsp), %rax
180007360:     	movq	%rax, 0x50(%rsp)
180007365:     	movq	0x278(%rsp), %rax
18000736d:     	movq	%rax, 0x48(%rsp)
180007372:     	movq	0x270(%rsp), %rax
18000737a:     	movq	%rax, 0x40(%rsp)
18000737f:     	movq	0x268(%rsp), %rax
180007387:     	movq	%rax, 0x38(%rsp)
18000738c:     	movq	%r14, 0x30(%rsp)
180007391:     	movq	0x258(%rsp), %rax
180007399:     	movq	%rax, 0x28(%rsp)
18000739e:     	movsd	%xmm6, 0x100(%rsp)
1800073a7:     	movq	%r15, 0xd8(%rsp)
1800073af:     	movq	%rbx, 0xa0(%rsp)
1800073b7:     	movq	0x250(%rsp), %rax
1800073bf:     	movq	%rax, 0x20(%rsp)
1800073c4:     	leaq	0x130(%rsp), %rcx
1800073cc:     	movq	0x120(%rsp), %r8
1800073d4:     	movq	0x128(%rsp), %r9
1800073dc:     	callq	0x180006840 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2c80>
1800073e1:     	cmpb	$0x0, (%r15)
1800073e5:     	jne	0x18000745f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x389f>
1800073e7:     	cmpb	$0x0, 0x148(%rsp)
1800073ef:     	setne	%al
1800073f2:     	cmpb	$0x0, 0x138(%rsp)
1800073fa:     	setne	%cl
1800073fd:     	addsd	0x130(%rsp), %xmm7
180007406:     	addsd	0x140(%rsp), %xmm8
180007410:     	decq	0x8(%rbx)
180007414:     	movl	%esi, %edx
180007416:     	andb	%cl, %dl
180007418:     	movzbl	0x116(%rsp), %r10d
180007421:     	andb	%al, %r10b
180007424:     	movq	0x118(%rsp), %rax
18000742c:     	movb	%r10b, 0x18(%rax)
180007430:     	movsd	%xmm8, 0x10(%rax)
180007436:     	movb	%dl, 0x8(%rax)
180007439:     	movsd	%xmm7, (%rax)
18000743d:     	jmp	0x180006a73 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2eb3>
180007442:     	movb	$0x1, (%r15)
180007446:     	movq	$0x3d092b, 0x18(%rbx)   # imm = 0x3D092B
18000744e:     	jmp	0x180006a54 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2e94>
180007453:     	movb	$0x1, (%r15)
180007457:     	movq	$0x3d0930, 0x18(%rbx)   # imm = 0x3D0930
18000745f:     	movq	0x118(%rsp), %rax
180007467:     	movq	$0x0, 0x18(%rax)
18000746f:     	movq	$0x0, 0x10(%rax)
180007477:     	movq	$0x0, 0x8(%rax)
18000747f:     	movq	$0x0, (%rax)
180007486:     	jmp	0x180006a73 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x2eb3>
18000748b:     	nopl	(%rax,%rax)
180007490:     	pushq	%r15
180007492:     	pushq	%r14
180007494:     	pushq	%r13
180007496:     	pushq	%r12
180007498:     	pushq	%rsi
180007499:     	pushq	%rdi
18000749a:     	pushq	%rbp
18000749b:     	pushq	%rbx
18000749c:     	subq	$0x1c8, %rsp            # imm = 0x1C8
1800074a3:     	movq	0x300(%rsp), %rax
1800074ab:     	movq	0x2e8(%rsp), %r15
1800074b3:     	movq	0x2b0(%rsp), %r12
1800074bb:     	movb	$0x0, 0x12f(%rsp)
1800074c3:     	movq	$0x0, 0x1a8(%rsp)
1800074cf:     	movb	$0x0, 0x11f(%rsp)
1800074d7:     	movq	$0x0, 0x1a0(%rsp)
1800074e3:     	movb	$0x0, 0x11e(%rsp)
1800074eb:     	movq	$0x0, 0x198(%rsp)
1800074f7:     	movb	$0x0, 0x11d(%rsp)
1800074ff:     	movq	$0x0, 0x190(%rsp)
18000750b:     	movb	$0x0, 0x11c(%rsp)
180007513:     	movq	$0x0, 0x188(%rsp)
18000751f:     	movb	$0x0, 0x12e(%rsp)
180007527:     	movq	$0x0, 0x180(%rsp)
180007533:     	movb	$0x0, 0x12d(%rsp)
18000753b:     	movq	$0x0, 0x178(%rsp)
180007547:     	movb	$0x0, 0x12c(%rsp)
18000754f:     	movq	$0x0, 0x170(%rsp)
18000755b:     	movb	$0x0, 0x12b(%rsp)
180007563:     	movq	$0x0, 0x168(%rsp)
18000756f:     	cmpq	$0x1, %rax
180007573:     	movq	0x280(%rsp), %rbx
18000757b:     	movq	0x278(%rsp), %r13
180007583:     	movq	0x258(%rsp), %rdi
18000758b:     	movq	0x248(%rsp), %r14
180007593:     	movq	0x240(%rsp), %rbp
18000759b:     	je	0x180007642 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3a82>
1800075a1:     	testq	%rax, %rax
1800075a4:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800075aa:     	movq	0x308(%rsp), %rsi
1800075b2:     	movq	(%r13,%rsi,8), %rax
1800075b7:     	testq	%rax, %rax
1800075ba:     	js	0x18000766f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aaf>
1800075c0:     	movq	0x310(%rsp), %r10
1800075c8:     	testq	%r10, %r10
1800075cb:     	js	0x18000766f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aaf>
1800075d1:     	movq	0x10(%r13,%r10,8), %r11
1800075d6:     	testq	%r11, %r11
1800075d9:     	js	0x1800076ff <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3b3f>
1800075df:     	movsd	(%rbp,%r11,8), %xmm0
1800075e6:     	movsd	0x8(%rbp,%rax,8), %xmm2
1800075ec:     	movsd	0x10(%rbp,%rax,8), %xmm1
1800075f2:     	movapd	%xmm1, %xmm3
1800075f6:     	subsd	%xmm2, %xmm3
1800075fa:     	xorl	%r10d, %r10d
1800075fd:     	ucomisd	%xmm3, %xmm0
180007601:     	jb	0x180007721 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3b61>
180007607:     	addsd	%xmm2, %xmm1
18000760b:     	ucomisd	%xmm0, %xmm1
18000760f:     	jbe	0x180007721 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3b61>
180007615:     	movsd	0x10(%rbp,%r11,8), %xmm0
18000761c:     	movsd	(%rbp,%rax,8), %xmm1
180007622:     	movsd	0x18(%rbp,%rax,8), %xmm2
180007628:     	movapd	%xmm2, %xmm3
18000762c:     	subsd	%xmm1, %xmm3
180007630:     	ucomisd	%xmm3, %xmm0
180007634:     	jae	0x180007715 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3b55>
18000763a:     	xorl	%r10d, %r10d
18000763d:     	jmp	0x180007721 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3b61>
180007642:     	movq	0x318(%rsp), %rsi
18000764a:     	testq	%rsi, %rsi
18000764d:     	js	0x180007681 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3ac1>
18000764f:     	movq	(%r13,%rsi,8), %rax
180007654:     	testq	%rax, %rax
180007657:     	js	0x180007681 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3ac1>
180007659:     	movq	(%r12), %r10
18000765d:     	leaq	0x4(%r10), %r11
180007661:     	cmpq	%rbx, %r11
180007664:     	jle	0x180007693 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3ad3>
180007666:     	movb	$0x2, (%r15)
18000766a:     	jmp	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
18000766f:     	movb	$0x1, (%r15)
180007673:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
18000767c:     	jmp	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007681:     	movb	$0x1, (%r15)
180007685:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
18000768e:     	jmp	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007693:     	movsd	0x10(%rbp,%rax,8), %xmm1
180007699:     	movsd	0x18(%rbp,%rax,8), %xmm2
18000769f:     	movsd	0x5d09(%rip), %xmm0     # 0x18000d3b0
1800076a7:     	movsd	0x8(%rbp,%rax,8), %xmm3
1800076ad:     	mulsd	%xmm0, %xmm3
1800076b1:     	mulsd	(%rbp,%rax,8), %xmm0
1800076b7:     	movq	%r11, (%r12)
1800076bb:     	cmpb	$0x0, (%r15)
1800076bf:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800076c5:     	movapd	%xmm1, %xmm4
1800076c9:     	addsd	%xmm3, %xmm4
1800076cd:     	movapd	%xmm2, %xmm5
1800076d1:     	subsd	%xmm0, %xmm5
1800076d5:     	testq	%r10, %r10
1800076d8:     	js	0x18000783b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3c7b>
1800076de:     	movsd	%xmm4, 0x10(%rbp,%r10,8)
1800076e5:     	movsd	%xmm5, 0x18(%rbp,%r10,8)
1800076ec:     	movsd	%xmm3, 0x8(%rbp,%r10,8)
1800076f3:     	movsd	%xmm0, (%rbp,%r10,8)
1800076fa:     	jmp	0x180007848 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3c88>
1800076ff:     	movb	$0x1, (%r15)
180007703:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
18000770c:     	cmpb	$0x0, (%r15)
180007710:     	jmp	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007715:     	addsd	%xmm1, %xmm2
180007719:     	ucomisd	%xmm0, %xmm2
18000771d:     	seta	%r10b
180007721:     	cmpb	$0x0, (%r15)
180007725:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
18000772b:     	testb	%r10b, %r10b
18000772e:     	je	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007734:     	movq	0x18(%r13,%rsi,8), %rax
180007739:     	movq	0x30(%r13,%rsi,8), %rdi
18000773e:     	movq	%rdi, %r11
180007741:     	sarq	$0x3f, %r11
180007745:     	andq	%rbx, %r11
180007748:     	movq	%rdi, %r10
18000774b:     	leaq	(%r13,%rdi,8), %rdi
180007750:     	movq	%r11, 0x140(%rsp)
180007758:     	movq	(%rdi,%r11,8), %r11
18000775c:     	movq	%r11, 0x110(%rsp)
180007764:     	cmpq	0x8(%r13,%rsi,8), %r11
180007769:     	jge	0x1800079df <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3e1f>
18000776f:     	testq	%rax, %rax
180007772:     	jne	0x1800079e8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3e28>
180007778:     	movq	%rdi, %r14
18000777b:     	xorl	%r8d, %r8d
18000777e:     	cmpq	$-0x1, %r10
180007782:     	cmovlq	%rbx, %r8
180007786:     	movq	0x110(%rsp), %rdx
18000778e:     	cmpq	0x8(%rdi,%r8,8), %rdx
180007793:     	jne	0x180008290 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x46d0>
180007799:     	leaq	(%rdx,%rdx), %rax
18000779d:     	testq	%rdx, %rdx
1800077a0:     	movl	$0x4, %r9d
1800077a6:     	cmovneq	%rax, %r9
1800077aa:     	movq	(%r12), %r11
1800077ae:     	leaq	(%r11,%r9), %rax
1800077b2:     	cmpq	%rbx, %rax
1800077b5:     	jg	0x180007666 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aa6>
1800077bb:     	movq	%rax, (%r12)
1800077bf:     	cmpb	$0x0, (%r15)
1800077c3:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800077c9:     	movq	%r14, 0x150(%rsp)
1800077d1:     	movq	%r11, 0x148(%rsp)
1800077d9:     	movq	%r9, 0x158(%rsp)
1800077e1:     	movq	%r8, 0x160(%rsp)
1800077e9:     	xorl	%r11d, %r11d
1800077ec:     	movq	%r10, 0x1c0(%rsp)
1800077f4:     	cmpq	$-0x2, %r10
1800077f8:     	cmovlq	%rbx, %r11
1800077fc:     	testq	%rdx, %rdx
1800077ff:     	jle	0x180008256 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4696>
180007805:     	movq	0x150(%rsp), %rax
18000780d:     	movq	0x10(%rax,%r11,8), %r14
180007812:     	movq	0x110(%rsp), %rax
18000781a:     	movl	%eax, %r10d
18000781d:     	andl	$0x7, %r10d
180007821:     	cmpq	$0x7, %rax
180007825:     	ja	0x18000803e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x447e>
18000782b:     	leaq	(,%rbx,8), %r8
180007833:     	xorl	%r9d, %r9d
180007836:     	jmp	0x18000821a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x465a>
18000783b:     	movb	$0x1, (%r15)
18000783f:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180007848:     	cmpb	$0x0, (%r15)
18000784c:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007852:     	movq	(%r12), %r11
180007856:     	leaq	0xb(%r11), %rax
18000785a:     	cmpq	%rbx, %rax
18000785d:     	jg	0x180007666 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aa6>
180007863:     	movq	%r11, 0x140(%rsp)
18000786b:     	movq	0x8(%r13,%rsi,8), %r11
180007870:     	movq	%rax, (%r12)
180007874:     	cmpb	$0x0, (%r15)
180007878:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
18000787e:     	movq	0x140(%rsp), %rax
180007886:     	movq	%r10, (%r13,%rax,8)
18000788b:     	movq	%r11, 0x8(%r13,%rax,8)
180007890:     	movq	(%r12), %r11
180007894:     	cmpq	%rbx, %r11
180007897:     	movq	%r11, %r10
18000789a:     	jle	0x1800078a7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3ce7>
18000789c:     	movb	$0x2, (%r15)
1800078a0:     	movq	(%r12), %r11
1800078a4:     	xorl	%r10d, %r10d
1800078a7:     	leaq	0x3(%r11), %rax
1800078ab:     	cmpq	%rbx, %rax
1800078ae:     	jg	0x180007666 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aa6>
1800078b4:     	movq	%rax, (%r12)
1800078b8:     	cmpb	$0x0, (%r15)
1800078bc:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800078c2:     	movq	%r11, %rax
1800078c5:     	sarq	$0x3f, %rax
1800078c9:     	andq	%rbx, %rax
1800078cc:     	movq	%r10, 0x120(%rsp)
1800078d4:     	leaq	(%r13,%r11,8), %r10
1800078d9:     	movq	$0x0, (%r10,%rax,8)
1800078e1:     	movq	$0x0, 0x110(%rsp)
1800078ed:     	cmpq	$-0x1, %r11
1800078f1:     	movl	$0x0, %eax
1800078f6:     	cmovlq	%rbx, %rax
1800078fa:     	leaq	(%r13,%r11,8), %r10
1800078ff:     	movq	$0x0, 0x8(%r10,%rax,8)
180007908:     	cmpq	$-0x2, %r11
18000790c:     	movq	0x110(%rsp), %rax
180007914:     	cmovlq	%rbx, %rax
180007918:     	movq	%rax, 0x110(%rsp)
180007920:     	leaq	(%r13,%r11,8), %rax
180007925:     	movq	0x120(%rsp), %r10
18000792d:     	movq	%r11, 0x130(%rsp)
180007935:     	movq	0x110(%rsp), %r11
18000793d:     	movq	%r10, 0x10(%rax,%r11,8)
180007942:     	movq	0x130(%rsp), %r11
18000794a:     	cmpb	$0x0, (%r15)
18000794e:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007954:     	movq	0x140(%rsp), %rax
18000795c:     	leaq	(%r13,%rax,8), %r10
180007961:     	movq	%r11, 0x30(%r10)
180007965:     	movq	$0x0, 0x18(%r10)
18000796d:     	movq	(%r12), %r11
180007971:     	leaq	0x4(%r11), %rax
180007975:     	cmpq	%rbx, %rax
180007978:     	jg	0x180007666 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3aa6>
18000797e:     	movq	%rax, (%r12)
180007982:     	cmpb	$0x0, (%r15)
180007986:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
18000798c:     	movq	%r8, 0x130(%rsp)
180007994:     	movq	%r9, 0x138(%rsp)
18000799c:     	movq	%rdx, 0x120(%rsp)
1800079a4:     	movq	%rcx, 0x110(%rsp)
1800079ac:     	testq	%r11, %r11
1800079af:     	js	0x1800086ae <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4aee>
1800079b5:     	movq	$0x0, (%rbp,%r11,8)
1800079be:     	leaq	(%r13,%r11,8), %rcx
1800079c3:     	movq	$0x1, 0x8(%r13,%r11,8)
1800079cc:     	movq	$0x0, 0x10(%rbp,%r11,8)
1800079d5:     	movl	$0x1, %edx
1800079da:     	jmp	0x1800086ba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4afa>
1800079df:     	testq	%rax, %rax
1800079e2:     	je	0x180007bf2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4032>
1800079e8:     	movq	0x20(%r13,%rsi,8), %rax
1800079ed:     	testq	%rax, %rax
1800079f0:     	js	0x180007e01 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4241>
1800079f6:     	movq	0x8(%r12), %r10
1800079fb:     	leaq	0x1(%r10), %r11
1800079ff:     	movq	%r11, 0x8(%r12)
180007a04:     	cmpq	0x10(%r12), %r10
180007a09:     	jge	0x180007e01 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4241>
180007a0f:     	movq	%rdx, 0x120(%rsp)
180007a17:     	movq	%rcx, 0x110(%rsp)
180007a1f:     	movb	$0x0, 0x11f(%rsp)
180007a27:     	movq	0x310(%rsp), %rcx
180007a2f:     	movq	%rcx, 0x100(%rsp)
180007a37:     	movq	%rax, 0xf8(%rsp)
180007a3f:     	movq	0x2f8(%rsp), %rax
180007a47:     	movq	%rax, 0xe8(%rsp)
180007a4f:     	movq	0x2f0(%rsp), %rax
180007a57:     	movq	%rax, 0xe0(%rsp)
180007a5f:     	movq	%r15, 0xd8(%rsp)
180007a67:     	movq	0x2e0(%rsp), %rax
180007a6f:     	movq	%rax, 0xd0(%rsp)
180007a77:     	movq	0x2d8(%rsp), %rax
180007a7f:     	movq	%rax, 0xc8(%rsp)
180007a87:     	movq	0x2d0(%rsp), %rax
180007a8f:     	movq	%rax, 0xc0(%rsp)
180007a97:     	movq	0x2c8(%rsp), %rax
180007a9f:     	movq	%rax, 0xb8(%rsp)
180007aa7:     	movq	0x2c0(%rsp), %rax
180007aaf:     	movq	%rax, 0xb0(%rsp)
180007ab7:     	movq	0x2b8(%rsp), %rax
180007abf:     	movq	%rax, 0xa8(%rsp)
180007ac7:     	movq	%r12, 0xa0(%rsp)
180007acf:     	movq	0x2a8(%rsp), %rax
180007ad7:     	movq	%rax, 0x98(%rsp)
180007adf:     	movq	0x2a0(%rsp), %rax
180007ae7:     	movq	%rax, 0x90(%rsp)
180007aef:     	movq	0x298(%rsp), %rax
180007af7:     	movq	%rax, 0x88(%rsp)
180007aff:     	movq	0x290(%rsp), %rax
180007b07:     	movq	%rax, 0x80(%rsp)
180007b0f:     	movq	0x288(%rsp), %rax
180007b17:     	movq	%rax, 0x78(%rsp)
180007b1c:     	movq	%rbx, 0x70(%rsp)
180007b21:     	movq	%r13, 0x68(%rsp)
180007b26:     	movq	0x270(%rsp), %rax
180007b2e:     	movq	%rax, 0x60(%rsp)
180007b33:     	movq	0x268(%rsp), %rax
180007b3b:     	movq	%rax, 0x58(%rsp)
180007b40:     	movq	0x260(%rsp), %rax
180007b48:     	movq	%rax, 0x50(%rsp)
180007b4d:     	movq	0x258(%rsp), %rdi
180007b55:     	movq	%rdi, 0x48(%rsp)
180007b5a:     	movq	0x250(%rsp), %rax
180007b62:     	movq	%rax, 0x40(%rsp)
180007b67:     	movq	0x248(%rsp), %r14
180007b6f:     	movq	%r14, 0x38(%rsp)
180007b74:     	movq	%rbp, 0x30(%rsp)
180007b79:     	movq	0x238(%rsp), %rax
180007b81:     	movq	%rax, 0x28(%rsp)
180007b86:     	movq	0x230(%rsp), %rax
180007b8e:     	movq	%rax, 0x20(%rsp)
180007b93:     	movq	$-0x1, 0x108(%rsp)
180007b9f:     	movq	$0x0, 0xf0(%rsp)
180007bab:     	leaq	0x11f(%rsp), %rcx
180007bb3:     	leaq	0x1a0(%rsp), %rdx
180007bbb:     	movq	%r8, 0x130(%rsp)
180007bc3:     	movq	%r9, 0x138(%rsp)
180007bcb:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180007bd0:     	testl	%eax, %eax
180007bd2:     	jne	0x18000847f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48bf>
180007bd8:     	cmpb	$0x0, (%r15)
180007bdc:     	movq	0x110(%rsp), %rax
180007be4:     	je	0x180007e36 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4276>
180007bea:     	movb	$0x0, (%rax)
180007bed:     	jmp	0x180007e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4251>
180007bf2:     	movq	0x8(%r12), %rax
180007bf7:     	leaq	0x1(%rax), %r10
180007bfb:     	movq	%r10, 0x8(%r12)
180007c00:     	cmpq	0x10(%r12), %rax
180007c05:     	jge	0x180007e27 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4267>
180007c0b:     	movq	%rdx, 0x120(%rsp)
180007c13:     	movq	%rcx, 0x110(%rsp)
180007c1b:     	movq	%rsi, 0x108(%rsp)
180007c23:     	movq	0x2f8(%rsp), %rax
180007c2b:     	movq	%rax, 0xe8(%rsp)
180007c33:     	movq	0x2f0(%rsp), %rax
180007c3b:     	movq	%rax, 0xe0(%rsp)
180007c43:     	movq	%r15, 0xd8(%rsp)
180007c4b:     	movq	0x2e0(%rsp), %rax
180007c53:     	movq	%rax, 0xd0(%rsp)
180007c5b:     	movq	0x2d8(%rsp), %rax
180007c63:     	movq	%rax, 0xc8(%rsp)
180007c6b:     	movq	0x2d0(%rsp), %rax
180007c73:     	movq	%rax, 0xc0(%rsp)
180007c7b:     	movq	0x2c8(%rsp), %rax
180007c83:     	movq	%rax, 0xb8(%rsp)
180007c8b:     	movq	0x2c0(%rsp), %rax
180007c93:     	movq	%rax, 0xb0(%rsp)
180007c9b:     	movq	0x2b8(%rsp), %rax
180007ca3:     	movq	%rax, 0xa8(%rsp)
180007cab:     	movq	%r12, 0xa0(%rsp)
180007cb3:     	movq	0x2a8(%rsp), %rax
180007cbb:     	movq	%rax, 0x98(%rsp)
180007cc3:     	movq	0x2a0(%rsp), %rax
180007ccb:     	movq	%rax, 0x90(%rsp)
180007cd3:     	movq	0x298(%rsp), %rax
180007cdb:     	movq	%rax, 0x88(%rsp)
180007ce3:     	movq	0x290(%rsp), %rax
180007ceb:     	movq	%rax, 0x80(%rsp)
180007cf3:     	movq	0x288(%rsp), %rax
180007cfb:     	movq	%rax, 0x78(%rsp)
180007d00:     	movq	%rbx, 0x70(%rsp)
180007d05:     	movq	%r13, 0x68(%rsp)
180007d0a:     	movq	0x270(%rsp), %rax
180007d12:     	movq	%rax, 0x60(%rsp)
180007d17:     	movq	0x268(%rsp), %rax
180007d1f:     	movq	%rax, 0x58(%rsp)
180007d24:     	movq	0x260(%rsp), %rax
180007d2c:     	movq	%rax, 0x50(%rsp)
180007d31:     	movq	0x258(%rsp), %rax
180007d39:     	movq	%rax, 0x48(%rsp)
180007d3e:     	movq	0x250(%rsp), %rax
180007d46:     	movq	%rax, 0x40(%rsp)
180007d4b:     	movq	0x248(%rsp), %rax
180007d53:     	movq	%rax, 0x38(%rsp)
180007d58:     	movq	%rbp, 0x30(%rsp)
180007d5d:     	movq	0x238(%rsp), %rax
180007d65:     	movq	%rax, 0x28(%rsp)
180007d6a:     	movq	0x230(%rsp), %rax
180007d72:     	movq	%rax, 0x20(%rsp)
180007d77:     	movq	$-0x1, 0x100(%rsp)
180007d83:     	movq	$-0x1, 0xf8(%rsp)
180007d8f:     	movq	$0x1, 0xf0(%rsp)
180007d9b:     	leaq	0x12f(%rsp), %rcx
180007da3:     	leaq	0x1a8(%rsp), %rdx
180007dab:     	movq	%r8, 0x130(%rsp)
180007db3:     	movq	%r9, 0x138(%rsp)
180007dbb:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180007dc0:     	testl	%eax, %eax
180007dc2:     	jne	0x180008489 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48c9>
180007dc8:     	cmpb	$0x0, (%r15)
180007dcc:     	movq	0x110(%rsp), %rcx
180007dd4:     	movq	0x120(%rsp), %rdx
180007ddc:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007dde:     	decq	0x8(%r12)
180007de3:     	movq	0x138(%rsp), %r9
180007deb:     	movq	0x130(%rsp), %r8
180007df3:     	movq	0x20(%r13,%rsi,8), %rax
180007df8:     	testq	%rax, %rax
180007dfb:     	jns	0x1800079f6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x3e36>
180007e01:     	movb	$0x1, (%r15)
180007e05:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
180007e0e:     	movb	$0x0, (%rcx)
180007e11:     	xorl	%eax, %eax
180007e13:     	addq	$0x1c8, %rsp            # imm = 0x1C8
180007e1a:     	popq	%rbx
180007e1b:     	popq	%rbp
180007e1c:     	popq	%rdi
180007e1d:     	popq	%rsi
180007e1e:     	popq	%r12
180007e20:     	popq	%r13
180007e22:     	popq	%r14
180007e24:     	popq	%r15
180007e26:     	retq
180007e27:     	movb	$0x1, (%r15)
180007e2b:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
180007e34:     	jmp	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180007e36:     	movzbl	0x11f(%rsp), %ecx
180007e3e:     	movq	0x8(%r12), %rdx
180007e43:     	leaq	-0x1(%rdx), %r8
180007e47:     	movq	%r8, 0x8(%r12)
180007e4c:     	testb	$0x1, %cl
180007e4f:     	je	0x180007e56 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4296>
180007e51:     	movb	$0x1, (%rax)
180007e54:     	jmp	0x180007e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4251>
180007e56:     	movq	0x28(%r13,%rsi,8), %rcx
180007e5b:     	testq	%rcx, %rcx
180007e5e:     	js	0x180007e6c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x42ac>
180007e60:     	movq	%rdx, 0x8(%r12)
180007e65:     	cmpq	0x10(%r12), %rdx
180007e6a:     	jle	0x180007e7e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x42be>
180007e6c:     	movb	$0x1, (%r15)
180007e70:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180007e79:     	jmp	0x180007bea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x402a>
180007e7e:     	movb	$0x0, 0x11e(%rsp)
180007e86:     	movq	0x310(%rsp), %rax
180007e8e:     	movq	%rax, 0x100(%rsp)
180007e96:     	movq	%rcx, 0xf8(%rsp)
180007e9e:     	movq	0x2f8(%rsp), %rax
180007ea6:     	movq	%rax, 0xe8(%rsp)
180007eae:     	movq	0x2f0(%rsp), %rax
180007eb6:     	movq	%rax, 0xe0(%rsp)
180007ebe:     	movq	%r15, 0xd8(%rsp)
180007ec6:     	movq	0x2e0(%rsp), %rax
180007ece:     	movq	%rax, 0xd0(%rsp)
180007ed6:     	movq	0x2d8(%rsp), %rax
180007ede:     	movq	%rax, 0xc8(%rsp)
180007ee6:     	movq	0x2d0(%rsp), %rax
180007eee:     	movq	%rax, 0xc0(%rsp)
180007ef6:     	movq	0x2c8(%rsp), %rax
180007efe:     	movq	%rax, 0xb8(%rsp)
180007f06:     	movq	0x2c0(%rsp), %rax
180007f0e:     	movq	%rax, 0xb0(%rsp)
180007f16:     	movq	0x2b8(%rsp), %rax
180007f1e:     	movq	%rax, 0xa8(%rsp)
180007f26:     	movq	%r12, 0xa0(%rsp)
180007f2e:     	movq	0x2a8(%rsp), %rax
180007f36:     	movq	%rax, 0x98(%rsp)
180007f3e:     	movq	0x2a0(%rsp), %rax
180007f46:     	movq	%rax, 0x90(%rsp)
180007f4e:     	movq	0x298(%rsp), %rax
180007f56:     	movq	%rax, 0x88(%rsp)
180007f5e:     	movq	0x290(%rsp), %rax
180007f66:     	movq	%rax, 0x80(%rsp)
180007f6e:     	movq	0x288(%rsp), %rax
180007f76:     	movq	%rax, 0x78(%rsp)
180007f7b:     	movq	%rbx, 0x70(%rsp)
180007f80:     	movq	%r13, 0x68(%rsp)
180007f85:     	movq	0x270(%rsp), %rax
180007f8d:     	movq	%rax, 0x60(%rsp)
180007f92:     	movq	0x268(%rsp), %rax
180007f9a:     	movq	%rax, 0x58(%rsp)
180007f9f:     	movq	0x260(%rsp), %rax
180007fa7:     	movq	%rax, 0x50(%rsp)
180007fac:     	movq	%rdi, 0x48(%rsp)
180007fb1:     	movq	0x250(%rsp), %rax
180007fb9:     	movq	%rax, 0x40(%rsp)
180007fbe:     	movq	%r14, 0x38(%rsp)
180007fc3:     	movq	%rbp, 0x30(%rsp)
180007fc8:     	movq	0x238(%rsp), %rax
180007fd0:     	movq	%rax, 0x28(%rsp)
180007fd5:     	movq	0x230(%rsp), %rax
180007fdd:     	movq	%rax, 0x20(%rsp)
180007fe2:     	movq	$-0x1, 0x108(%rsp)
180007fee:     	movq	$0x0, 0xf0(%rsp)
180007ffa:     	leaq	0x11e(%rsp), %rcx
180008002:     	leaq	0x198(%rsp), %rdx
18000800a:     	movq	0x130(%rsp), %r8
180008012:     	movq	0x138(%rsp), %r9
18000801a:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
18000801f:     	testl	%eax, %eax
180008021:     	jne	0x18000873a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b7a>
180008027:     	cmpb	$0x0, (%r15)
18000802b:     	je	0x180008411 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4851>
180008031:     	movq	0x110(%rsp), %rax
180008039:     	jmp	0x180007bea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x402a>
18000803e:     	movq	%r10, 0x1b0(%rsp)
180008046:     	movq	%r11, 0x1b8(%rsp)
18000804e:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
180008058:     	andq	%rax, %r9
18000805b:     	movq	0x148(%rsp), %r11
180008063:     	leaq	(,%rbx,8), %r8
18000806b:     	xorl	%edx, %edx
18000806d:     	movq	%r9, 0x138(%rsp)
180008075:     	leaq	(%r14,%rdx), %rax
180008079:     	sarq	$0x3f, %rax
18000807d:     	andq	%r8, %rax
180008080:     	leaq	(%r13,%r14,8), %rdi
180008085:     	addq	%rdi, %rax
180008088:     	movq	(%rax,%rdx,8), %rax
18000808c:     	leaq	(%r11,%rdx), %r9
180008090:     	sarq	$0x3f, %r9
180008094:     	andq	%r8, %r9
180008097:     	leaq	(%r13,%r11,8), %r10
18000809c:     	movq	%r10, 0x120(%rsp)
1800080a4:     	addq	%r10, %r9
1800080a7:     	movq	%rax, (%r9,%rdx,8)
1800080ab:     	leaq	0x1(%r14,%rdx), %rax
1800080b0:     	sarq	$0x3f, %rax
1800080b4:     	andq	%r8, %rax
1800080b7:     	movq	%rdi, %r10
1800080ba:     	addq	%rdi, %rax
1800080bd:     	movq	0x8(%rax,%rdx,8), %rax
1800080c2:     	leaq	0x1(%r11,%rdx), %r9
1800080c7:     	sarq	$0x3f, %r9
1800080cb:     	andq	%r8, %r9
1800080ce:     	movq	0x120(%rsp), %rdi
1800080d6:     	addq	%rdi, %r9
1800080d9:     	movq	%rax, 0x8(%r9,%rdx,8)
1800080de:     	leaq	0x2(%r14,%rdx), %rax
1800080e3:     	sarq	$0x3f, %rax
1800080e7:     	andq	%r8, %rax
1800080ea:     	addq	%r10, %rax
1800080ed:     	movq	%r10, 0x130(%rsp)
1800080f5:     	movq	0x10(%rax,%rdx,8), %rax
1800080fa:     	leaq	0x2(%r11,%rdx), %r9
1800080ff:     	sarq	$0x3f, %r9
180008103:     	andq	%r8, %r9
180008106:     	addq	%rdi, %r9
180008109:     	movq	%rax, 0x10(%r9,%rdx,8)
18000810e:     	leaq	0x3(%r14,%rdx), %rax
180008113:     	sarq	$0x3f, %rax
180008117:     	andq	%r8, %rax
18000811a:     	addq	%r10, %rax
18000811d:     	movq	0x18(%rax,%rdx,8), %rax
180008122:     	leaq	0x3(%r11,%rdx), %r9
180008127:     	sarq	$0x3f, %r9
18000812b:     	andq	%r8, %r9
18000812e:     	addq	%rdi, %r9
180008131:     	movq	%rdi, %r10
180008134:     	movq	%rax, 0x18(%r9,%rdx,8)
180008139:     	leaq	0x4(%r14,%rdx), %rax
18000813e:     	sarq	$0x3f, %rax
180008142:     	andq	%r8, %rax
180008145:     	movq	0x130(%rsp), %rdi
18000814d:     	addq	%rdi, %rax
180008150:     	movq	0x20(%rax,%rdx,8), %rax
180008155:     	leaq	0x4(%r11,%rdx), %r9
18000815a:     	sarq	$0x3f, %r9
18000815e:     	andq	%r8, %r9
180008161:     	addq	%r10, %r9
180008164:     	movq	%rax, 0x20(%r9,%rdx,8)
180008169:     	leaq	0x5(%r14,%rdx), %rax
18000816e:     	sarq	$0x3f, %rax
180008172:     	andq	%r8, %rax
180008175:     	addq	%rdi, %rax
180008178:     	movq	0x28(%rax,%rdx,8), %rax
18000817d:     	leaq	0x5(%r11,%rdx), %r9
180008182:     	sarq	$0x3f, %r9
180008186:     	andq	%r8, %r9
180008189:     	addq	0x120(%rsp), %r9
180008191:     	movq	%rax, 0x28(%r9,%rdx,8)
180008196:     	leaq	0x6(%r14,%rdx), %rax
18000819b:     	sarq	$0x3f, %rax
18000819f:     	andq	%r8, %rax
1800081a2:     	addq	%rdi, %rax
1800081a5:     	movq	0x30(%rax,%rdx,8), %rax
1800081aa:     	leaq	0x6(%r11,%rdx), %r9
1800081af:     	sarq	$0x3f, %r9
1800081b3:     	andq	%r8, %r9
1800081b6:     	addq	0x120(%rsp), %r9
1800081be:     	movq	%rax, 0x30(%r9,%rdx,8)
1800081c3:     	leaq	0x7(%r14,%rdx), %rax
1800081c8:     	sarq	$0x3f, %rax
1800081cc:     	andq	%r8, %rax
1800081cf:     	addq	%rdi, %rax
1800081d2:     	movq	0x38(%rax,%rdx,8), %rax
1800081d7:     	leaq	0x7(%r11,%rdx), %r9
1800081dc:     	sarq	$0x3f, %r9
1800081e0:     	andq	%r8, %r9
1800081e3:     	addq	0x120(%rsp), %r9
1800081eb:     	movq	%rax, 0x38(%r9,%rdx,8)
1800081f0:     	movq	0x138(%rsp), %r9
1800081f8:     	addq	$0x8, %rdx
1800081fc:     	cmpq	%rdx, %r9
1800081ff:     	jne	0x180008075 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x44b5>
180008205:     	movq	0x1b0(%rsp), %r10
18000820d:     	testq	%r10, %r10
180008210:     	movq	0x1b8(%rsp), %r11
180008218:     	je	0x180008256 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4696>
18000821a:     	movq	0x148(%rsp), %rax
180008222:     	leaq	(%r9,%rax), %rdx
180008226:     	addq	%r9, %r14
180008229:     	movq	%r14, %rax
18000822c:     	sarq	$0x3f, %rax
180008230:     	andq	%r8, %rax
180008233:     	addq	%r13, %rax
180008236:     	movq	(%rax,%r14,8), %rax
18000823a:     	movq	%rdx, %r9
18000823d:     	sarq	$0x3f, %r9
180008241:     	andq	%r8, %r9
180008244:     	addq	%r13, %r9
180008247:     	movq	%rax, (%r9,%rdx,8)
18000824b:     	incq	%rdx
18000824e:     	incq	%r14
180008251:     	decq	%r10
180008254:     	jne	0x180008229 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4669>
180008256:     	movq	0x160(%rsp), %rax
18000825e:     	movq	0x158(%rsp), %rdx
180008266:     	movq	0x150(%rsp), %r14
18000826e:     	movq	%rdx, 0x8(%r14,%rax,8)
180008273:     	movq	0x148(%rsp), %rax
18000827b:     	movq	%rax, 0x10(%r14,%r11,8)
180008280:     	movq	0x110(%rsp), %rdx
180008288:     	movq	0x1c0(%rsp), %r10
180008290:     	leaq	0x1(%rdx), %rax
180008294:     	movq	0x140(%rsp), %r8
18000829c:     	movq	%rax, (%r14,%r8,8)
1800082a0:     	cmpb	$0x0, (%r15)
1800082a4:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800082aa:     	xorl	%eax, %eax
1800082ac:     	cmpq	$-0x2, %r10
1800082b0:     	cmovlq	%rbx, %rax
1800082b4:     	addq	0x10(%r14,%rax,8), %rdx
1800082b9:     	movq	%rdx, %rax
1800082bc:     	sarq	$0x3f, %rax
1800082c0:     	andq	%rbx, %rax
1800082c3:     	leaq	(%r13,%rdx,8), %rdx
1800082c8:     	movq	0x310(%rsp), %r8
1800082d0:     	movq	%r8, (%rdx,%rax,8)
1800082d4:     	movsd	0x48(%rbp,%rsi,8), %xmm1
1800082da:     	movsd	0x8(%rbp,%r8,8), %xmm2
1800082e1:     	movapd	%xmm1, %xmm0
1800082e5:     	addsd	%xmm2, %xmm0
1800082e9:     	xorpd	%xmm3, %xmm3
1800082ed:     	ucomisd	%xmm3, %xmm0
1800082f1:     	jbe	0x1800083f1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4831>
1800082f7:     	movq	0x10(%r13,%rsi,8), %rax
1800082fc:     	testq	%rax, %rax
1800082ff:     	js	0x180008402 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4842>
180008305:     	cmpq	$0x0, 0x8(%r13,%rax,8)
18000830b:     	mulsd	(%rbp,%rax,8), %xmm1
180008311:     	je	0x18000833d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x477d>
180008313:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
180008319:     	je	0x18000833d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x477d>
18000831b:     	movapd	0x509d(%rip), %xmm3     # 0x18000d3c0
180008323:     	andpd	%xmm1, %xmm3
180008327:     	ucomisd	0x50a1(%rip), %xmm3     # 0x18000d3d0
18000832f:     	jae	0x180008402 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4842>
180008335:     	xorpd	%xmm3, %xmm3
180008339:     	addsd	%xmm3, %xmm1
18000833d:     	movq	0x10(%r13,%r8,8), %rdx
180008342:     	testq	%rdx, %rdx
180008345:     	js	0x180008402 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4842>
18000834b:     	mulsd	(%rbp,%rdx,8), %xmm2
180008351:     	addsd	%xmm2, %xmm1
180008355:     	divsd	%xmm0, %xmm1
180008359:     	movsd	%xmm1, (%rbp,%rax,8)
18000835f:     	movq	$0x0, 0x8(%r13,%rax,8)
180008368:     	movq	0x10(%r13,%rsi,8), %rax
18000836d:     	testq	%rax, %rax
180008370:     	js	0x180008438 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4878>
180008376:     	movsd	0x10(%rbp,%rax,8), %xmm1
18000837c:     	cmpq	$0x0, 0x18(%r13,%rax,8)
180008382:     	mulsd	0x48(%rbp,%rsi,8), %xmm1
180008388:     	je	0x1800083b4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x47f4>
18000838a:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
180008390:     	je	0x1800083b4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x47f4>
180008392:     	movapd	0x5026(%rip), %xmm2     # 0x18000d3c0
18000839a:     	andpd	%xmm1, %xmm2
18000839e:     	ucomisd	0x502a(%rip), %xmm2     # 0x18000d3d0
1800083a6:     	jae	0x180008438 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4878>
1800083ac:     	xorpd	%xmm2, %xmm2
1800083b0:     	addsd	%xmm2, %xmm1
1800083b4:     	movq	0x310(%rsp), %rdx
1800083bc:     	movq	0x10(%r13,%rdx,8), %rdx
1800083c1:     	testq	%rdx, %rdx
1800083c4:     	js	0x180008438 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4878>
1800083c6:     	movsd	0x10(%rbp,%rdx,8), %xmm2
1800083cc:     	movq	0x310(%rsp), %rdx
1800083d4:     	mulsd	0x8(%rbp,%rdx,8), %xmm2
1800083da:     	addsd	%xmm2, %xmm1
1800083de:     	divsd	%xmm0, %xmm1
1800083e2:     	movsd	%xmm1, 0x10(%rbp,%rax,8)
1800083e8:     	movq	$0x0, 0x18(%r13,%rax,8)
1800083f1:     	movsd	%xmm0, 0x48(%rbp,%rsi,8)
1800083f7:     	movq	$0x0, 0x50(%r13,%rsi,8)
180008400:     	jmp	0x180008445 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4885>
180008402:     	movb	$0x1, (%r15)
180008406:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
18000840f:     	jmp	0x180008445 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4885>
180008411:     	movzbl	0x11e(%rsp), %eax
180008419:     	movq	0x8(%r12), %rcx
18000841e:     	leaq	-0x1(%rcx), %rdx
180008422:     	movq	%rdx, 0x8(%r12)
180008427:     	testb	$0x1, %al
180008429:     	je	0x180008457 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4897>
18000842b:     	movq	0x110(%rsp), %rax
180008433:     	jmp	0x180007e51 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4291>
180008438:     	movb	$0x1, (%r15)
18000843c:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
180008445:     	cmpb	$0x0, (%r15)
180008449:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
18000844f:     	movb	$0x1, (%rcx)
180008452:     	jmp	0x180007e11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4251>
180008457:     	movq	0x38(%r13,%rsi,8), %rax
18000845c:     	testq	%rax, %rax
18000845f:     	js	0x18000846d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48ad>
180008461:     	movq	%rcx, 0x8(%r12)
180008466:     	cmpq	0x10(%r12), %rcx
18000846b:     	jle	0x1800084a1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48e1>
18000846d:     	movb	$0x1, (%r15)
180008471:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
18000847a:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000847f:     	movq	0x1a0(%rsp), %rdx
180008487:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
180008489:     	movq	0x1a8(%rsp), %rdx
180008491:     	movq	0x120(%rsp), %rcx
180008499:     	movq	%rdx, (%rcx)
18000849c:     	jmp	0x180007e13 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4253>
1800084a1:     	movb	$0x0, 0x11d(%rsp)
1800084a9:     	movq	0x310(%rsp), %rcx
1800084b1:     	movq	%rcx, 0x100(%rsp)
1800084b9:     	movq	%rax, 0xf8(%rsp)
1800084c1:     	movq	0x2f8(%rsp), %rax
1800084c9:     	movq	%rax, 0xe8(%rsp)
1800084d1:     	movq	0x2f0(%rsp), %rax
1800084d9:     	movq	%rax, 0xe0(%rsp)
1800084e1:     	movq	%r15, 0xd8(%rsp)
1800084e9:     	movq	0x2e0(%rsp), %rax
1800084f1:     	movq	%rax, 0xd0(%rsp)
1800084f9:     	movq	0x2d8(%rsp), %rax
180008501:     	movq	%rax, 0xc8(%rsp)
180008509:     	movq	0x2d0(%rsp), %rax
180008511:     	movq	%rax, 0xc0(%rsp)
180008519:     	movq	0x2c8(%rsp), %rax
180008521:     	movq	%rax, 0xb8(%rsp)
180008529:     	movq	0x2c0(%rsp), %rax
180008531:     	movq	%rax, 0xb0(%rsp)
180008539:     	movq	0x2b8(%rsp), %rax
180008541:     	movq	%rax, 0xa8(%rsp)
180008549:     	movq	%r12, 0xa0(%rsp)
180008551:     	movq	0x2a8(%rsp), %rax
180008559:     	movq	%rax, 0x98(%rsp)
180008561:     	movq	0x2a0(%rsp), %rax
180008569:     	movq	%rax, 0x90(%rsp)
180008571:     	movq	0x298(%rsp), %rax
180008579:     	movq	%rax, 0x88(%rsp)
180008581:     	movq	0x290(%rsp), %rax
180008589:     	movq	%rax, 0x80(%rsp)
180008591:     	movq	0x288(%rsp), %rax
180008599:     	movq	%rax, 0x78(%rsp)
18000859e:     	movq	%rbx, 0x70(%rsp)
1800085a3:     	movq	%r13, 0x68(%rsp)
1800085a8:     	movq	0x270(%rsp), %rax
1800085b0:     	movq	%rax, 0x60(%rsp)
1800085b5:     	movq	0x268(%rsp), %rax
1800085bd:     	movq	%rax, 0x58(%rsp)
1800085c2:     	movq	0x260(%rsp), %rax
1800085ca:     	movq	%rax, 0x50(%rsp)
1800085cf:     	movq	0x258(%rsp), %rax
1800085d7:     	movq	%rax, 0x48(%rsp)
1800085dc:     	movq	0x250(%rsp), %rax
1800085e4:     	movq	%rax, 0x40(%rsp)
1800085e9:     	movq	0x248(%rsp), %rax
1800085f1:     	movq	%rax, 0x38(%rsp)
1800085f6:     	movq	%rbp, 0x30(%rsp)
1800085fb:     	movq	0x238(%rsp), %rax
180008603:     	movq	%rax, 0x28(%rsp)
180008608:     	movq	0x230(%rsp), %rax
180008610:     	movq	%rax, 0x20(%rsp)
180008615:     	movq	$-0x1, 0x108(%rsp)
180008621:     	movq	$0x0, 0xf0(%rsp)
18000862d:     	leaq	0x11d(%rsp), %rcx
180008635:     	leaq	0x190(%rsp), %rdx
18000863d:     	movq	0x130(%rsp), %r8
180008645:     	movq	0x138(%rsp), %r9
18000864d:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180008652:     	testl	%eax, %eax
180008654:     	jne	0x180008a77 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4eb7>
18000865a:     	cmpb	$0x0, (%r15)
18000865e:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008664:     	movzbl	0x11d(%rsp), %eax
18000866c:     	movq	0x8(%r12), %rcx
180008671:     	leaq	-0x1(%rcx), %rdx
180008675:     	movq	%rdx, 0x8(%r12)
18000867a:     	testb	$0x1, %al
18000867c:     	jne	0x18000842b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x486b>
180008682:     	movq	0x40(%r13,%rsi,8), %rax
180008687:     	testq	%rax, %rax
18000868a:     	js	0x18000869c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4adc>
18000868c:     	movq	%rcx, 0x8(%r12)
180008691:     	cmpq	0x10(%r12), %rcx
180008696:     	jle	0x18000877f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4bbf>
18000869c:     	movb	$0x1, (%r15)
1800086a0:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
1800086a9:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800086ae:     	movb	$0x1, (%r15)
1800086b2:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
1800086b7:     	movq	%r12, %rcx
1800086ba:     	movq	%rdx, 0x18(%rcx)
1800086be:     	cmpb	$0x0, (%r15)
1800086c2:     	movq	0x110(%rsp), %rcx
1800086ca:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
1800086d0:     	movq	%r11, 0x10(%r10)
1800086d4:     	movq	0x140(%rsp), %rax
1800086dc:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800086e5:     	movq	$0x1, 0x50(%r10)
1800086ed:     	movq	$-0x1, 0x20(%r10)
1800086f5:     	movq	$-0x1, 0x28(%r10)
1800086fd:     	movq	$-0x1, 0x38(%r10)
180008705:     	movq	$-0x1, 0x40(%r10)
18000870d:     	cmpb	$0x0, (%r15)
180008711:     	jne	0x180007e0e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x424e>
180008717:     	movq	0x140(%rsp), %rax
18000871f:     	movq	%rax, 0x20(%r13,%rsi,8)
180008724:     	movq	(%r12), %rcx
180008728:     	leaq	0x4(%rcx), %rax
18000872c:     	cmpq	%rbx, %rax
18000872f:     	jle	0x180008747 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b87>
180008731:     	movb	$0x2, (%r15)
180008735:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000873a:     	movq	0x198(%rsp), %rdx
180008742:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
180008747:     	movq	%rax, (%r12)
18000874b:     	cmpb	$0x0, (%r15)
18000874f:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008755:     	subsd	%xmm3, %xmm1
180008759:     	testq	%rcx, %rcx
18000875c:     	js	0x18000895c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4d9c>
180008762:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
180008768:     	movsd	%xmm5, 0x18(%rbp,%rcx,8)
18000876e:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008774:     	movsd	%xmm0, (%rbp,%rcx,8)
18000877a:     	jmp	0x180008969 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4da9>
18000877f:     	movb	$0x0, 0x11c(%rsp)
180008787:     	movq	0x310(%rsp), %rcx
18000878f:     	movq	%rcx, 0x100(%rsp)
180008797:     	movq	%rax, 0xf8(%rsp)
18000879f:     	movq	0x2f8(%rsp), %rax
1800087a7:     	movq	%rax, 0xe8(%rsp)
1800087af:     	movq	0x2f0(%rsp), %rax
1800087b7:     	movq	%rax, 0xe0(%rsp)
1800087bf:     	movq	0x2e0(%rsp), %rax
1800087c7:     	movq	%rax, 0xd0(%rsp)
1800087cf:     	movq	0x2d8(%rsp), %rax
1800087d7:     	movq	%rax, 0xc8(%rsp)
1800087df:     	movq	0x2d0(%rsp), %rax
1800087e7:     	movq	%rax, 0xc0(%rsp)
1800087ef:     	movq	0x2c8(%rsp), %rax
1800087f7:     	movq	%rax, 0xb8(%rsp)
1800087ff:     	movq	0x2c0(%rsp), %rax
180008807:     	movq	%rax, 0xb0(%rsp)
18000880f:     	movq	0x2b8(%rsp), %rax
180008817:     	movq	%rax, 0xa8(%rsp)
18000881f:     	movq	0x2a8(%rsp), %rax
180008827:     	movq	%rax, 0x98(%rsp)
18000882f:     	movq	0x2a0(%rsp), %rax
180008837:     	movq	%rax, 0x90(%rsp)
18000883f:     	movq	0x298(%rsp), %rax
180008847:     	movq	%rax, 0x88(%rsp)
18000884f:     	movq	0x290(%rsp), %rax
180008857:     	movq	%rax, 0x80(%rsp)
18000885f:     	movq	0x288(%rsp), %rax
180008867:     	movq	%rax, 0x78(%rsp)
18000886c:     	movq	%rbx, 0x70(%rsp)
180008871:     	movq	%r13, 0x68(%rsp)
180008876:     	movq	0x270(%rsp), %rax
18000887e:     	movq	%rax, 0x60(%rsp)
180008883:     	movq	0x268(%rsp), %rax
18000888b:     	movq	%rax, 0x58(%rsp)
180008890:     	movq	0x260(%rsp), %rax
180008898:     	movq	%rax, 0x50(%rsp)
18000889d:     	movq	0x258(%rsp), %rax
1800088a5:     	movq	%rax, 0x48(%rsp)
1800088aa:     	movq	0x250(%rsp), %rax
1800088b2:     	movq	%rax, 0x40(%rsp)
1800088b7:     	movq	0x248(%rsp), %rax
1800088bf:     	movq	%rax, 0x38(%rsp)
1800088c4:     	movq	%rbp, 0x30(%rsp)
1800088c9:     	movq	%r15, 0xd8(%rsp)
1800088d1:     	movq	%r12, 0xa0(%rsp)
1800088d9:     	movq	0x238(%rsp), %rax
1800088e1:     	movq	%rax, 0x28(%rsp)
1800088e6:     	movq	0x230(%rsp), %rax
1800088ee:     	movq	%rax, 0x20(%rsp)
1800088f3:     	movq	$-0x1, 0x108(%rsp)
1800088ff:     	movq	$0x0, 0xf0(%rsp)
18000890b:     	leaq	0x11c(%rsp), %rcx
180008913:     	leaq	0x188(%rsp), %rdx
18000891b:     	movq	0x130(%rsp), %r8
180008923:     	movq	0x138(%rsp), %r9
18000892b:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180008930:     	testl	%eax, %eax
180008932:     	jne	0x180008a84 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4ec4>
180008938:     	cmpb	$0x0, (%r15)
18000893c:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008942:     	movzbl	0x11c(%rsp), %eax
18000894a:     	decq	0x8(%r12)
18000894f:     	testb	$0x1, %al
180008951:     	je	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008957:     	jmp	0x18000842b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x486b>
18000895c:     	movb	$0x1, (%r15)
180008960:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008969:     	cmpb	$0x0, (%r15)
18000896d:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008973:     	movq	(%r12), %rax
180008977:     	leaq	0xb(%rax), %r8
18000897b:     	cmpq	%rbx, %r8
18000897e:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008984:     	movq	0x8(%r13,%rsi,8), %rdx
180008989:     	movq	%r8, (%r12)
18000898d:     	cmpb	$0x0, (%r15)
180008991:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008997:     	movq	%rcx, (%r13,%rax,8)
18000899c:     	movq	%rdx, 0x8(%r13,%rax,8)
1800089a1:     	movq	(%r12), %rdx
1800089a5:     	cmpq	%rbx, %rdx
1800089a8:     	movq	%rdx, %rcx
1800089ab:     	jle	0x1800089b7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4df7>
1800089ad:     	movb	$0x2, (%r15)
1800089b1:     	movq	(%r12), %rdx
1800089b5:     	xorl	%ecx, %ecx
1800089b7:     	leaq	0x3(%rdx), %r8
1800089bb:     	cmpq	%rbx, %r8
1800089be:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
1800089c4:     	movq	%r8, (%r12)
1800089c8:     	cmpb	$0x0, (%r15)
1800089cc:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800089d2:     	movq	%rdx, %r8
1800089d5:     	sarq	$0x3f, %r8
1800089d9:     	andq	%rbx, %r8
1800089dc:     	leaq	(%r13,%rdx,8), %r9
1800089e1:     	movq	$0x0, (%r9,%r8,8)
1800089e9:     	xorl	%r8d, %r8d
1800089ec:     	cmpq	$-0x1, %rdx
1800089f0:     	movl	$0x0, %r10d
1800089f6:     	cmovlq	%rbx, %r10
1800089fa:     	movq	$0x0, 0x8(%r9,%r10,8)
180008a03:     	cmpq	$-0x2, %rdx
180008a07:     	cmovlq	%rbx, %r8
180008a0b:     	movq	%rcx, 0x10(%r9,%r8,8)
180008a10:     	cmpb	$0x0, (%r15)
180008a14:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008a1a:     	leaq	(%r13,%rax,8), %rcx
180008a1f:     	movq	%rdx, 0x30(%rcx)
180008a23:     	movq	$0x0, 0x18(%rcx)
180008a2b:     	movq	(%r12), %rdx
180008a2f:     	leaq	0x4(%rdx), %r8
180008a33:     	cmpq	%rbx, %r8
180008a36:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008a3c:     	movq	%r8, (%r12)
180008a40:     	cmpb	$0x0, (%r15)
180008a44:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008a4a:     	testq	%rdx, %rdx
180008a4d:     	js	0x180008a91 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4ed1>
180008a4f:     	movq	$0x0, (%rbp,%rdx,8)
180008a58:     	leaq	(%r13,%rdx,8), %r8
180008a5d:     	movq	$0x1, 0x8(%r13,%rdx,8)
180008a66:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008a6f:     	movl	$0x1, %r9d
180008a75:     	jmp	0x180008a9e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4ede>
180008a77:     	movq	0x190(%rsp), %rdx
180008a7f:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
180008a84:     	movq	0x188(%rsp), %rdx
180008a8c:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
180008a91:     	movb	$0x1, (%r15)
180008a95:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008a9b:     	movq	%r12, %r8
180008a9e:     	movq	%r9, 0x18(%r8)
180008aa2:     	cmpb	$0x0, (%r15)
180008aa6:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008aac:     	movq	%rdx, 0x10(%rcx)
180008ab0:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008ab9:     	movq	$0x1, 0x50(%rcx)
180008ac1:     	movq	$-0x1, 0x20(%rcx)
180008ac9:     	movq	$-0x1, 0x28(%rcx)
180008ad1:     	movq	$-0x1, 0x38(%rcx)
180008ad9:     	movq	$-0x1, 0x40(%rcx)
180008ae1:     	cmpb	$0x0, (%r15)
180008ae5:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008aeb:     	movq	%rax, 0x28(%r13,%rsi,8)
180008af0:     	movq	(%r12), %rcx
180008af4:     	leaq	0x4(%rcx), %rax
180008af8:     	cmpq	%rbx, %rax
180008afb:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008b01:     	movq	%rax, (%r12)
180008b05:     	cmpb	$0x0, (%r15)
180008b09:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008b0f:     	addsd	%xmm0, %xmm2
180008b13:     	testq	%rcx, %rcx
180008b16:     	js	0x180008b32 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4f72>
180008b18:     	movsd	%xmm4, 0x10(%rbp,%rcx,8)
180008b1e:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008b24:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008b2a:     	movsd	%xmm0, (%rbp,%rcx,8)
180008b30:     	jmp	0x180008b3f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4f7f>
180008b32:     	movb	$0x1, (%r15)
180008b36:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008b3f:     	cmpb	$0x0, (%r15)
180008b43:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008b49:     	movq	(%r12), %rax
180008b4d:     	leaq	0xb(%rax), %r8
180008b51:     	cmpq	%rbx, %r8
180008b54:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008b5a:     	movq	0x8(%r13,%rsi,8), %rdx
180008b5f:     	movq	%r8, (%r12)
180008b63:     	cmpb	$0x0, (%r15)
180008b67:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008b6d:     	movq	%rcx, (%r13,%rax,8)
180008b72:     	movq	%rdx, 0x8(%r13,%rax,8)
180008b77:     	movq	(%r12), %rdx
180008b7b:     	cmpq	%rbx, %rdx
180008b7e:     	movq	%rdx, %rcx
180008b81:     	jle	0x180008b8d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4fcd>
180008b83:     	movb	$0x2, (%r15)
180008b87:     	movq	(%r12), %rdx
180008b8b:     	xorl	%ecx, %ecx
180008b8d:     	leaq	0x3(%rdx), %r8
180008b91:     	cmpq	%rbx, %r8
180008b94:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008b9a:     	movq	%r8, (%r12)
180008b9e:     	cmpb	$0x0, (%r15)
180008ba2:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008ba8:     	movq	%rdx, %r8
180008bab:     	sarq	$0x3f, %r8
180008baf:     	andq	%rbx, %r8
180008bb2:     	leaq	(%r13,%rdx,8), %r9
180008bb7:     	movq	$0x0, (%r9,%r8,8)
180008bbf:     	xorl	%r8d, %r8d
180008bc2:     	cmpq	$-0x1, %rdx
180008bc6:     	movl	$0x0, %r10d
180008bcc:     	cmovlq	%rbx, %r10
180008bd0:     	movq	$0x0, 0x8(%r9,%r10,8)
180008bd9:     	cmpq	$-0x2, %rdx
180008bdd:     	cmovlq	%rbx, %r8
180008be1:     	movq	%rcx, 0x10(%r9,%r8,8)
180008be6:     	cmpb	$0x0, (%r15)
180008bea:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008bf0:     	leaq	(%r13,%rax,8), %rcx
180008bf5:     	movq	%rdx, 0x30(%rcx)
180008bf9:     	movq	$0x0, 0x18(%rcx)
180008c01:     	movq	(%r12), %rdx
180008c05:     	leaq	0x4(%rdx), %r8
180008c09:     	cmpq	%rbx, %r8
180008c0c:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008c12:     	movq	%r8, (%r12)
180008c16:     	cmpb	$0x0, (%r15)
180008c1a:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008c20:     	testq	%rdx, %rdx
180008c23:     	js	0x180008c4d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x508d>
180008c25:     	movq	$0x0, (%rbp,%rdx,8)
180008c2e:     	leaq	(%r13,%rdx,8), %r8
180008c33:     	movq	$0x1, 0x8(%r13,%rdx,8)
180008c3c:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008c45:     	movl	$0x1, %r9d
180008c4b:     	jmp	0x180008c5a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x509a>
180008c4d:     	movb	$0x1, (%r15)
180008c51:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008c57:     	movq	%r12, %r8
180008c5a:     	movq	%r9, 0x18(%r8)
180008c5e:     	cmpb	$0x0, (%r15)
180008c62:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008c68:     	movq	%rdx, 0x10(%rcx)
180008c6c:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008c75:     	movq	$0x1, 0x50(%rcx)
180008c7d:     	movq	$-0x1, 0x20(%rcx)
180008c85:     	movq	$-0x1, 0x28(%rcx)
180008c8d:     	movq	$-0x1, 0x38(%rcx)
180008c95:     	movq	$-0x1, 0x40(%rcx)
180008c9d:     	cmpb	$0x0, (%r15)
180008ca1:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008ca7:     	movq	%rax, 0x38(%r13,%rsi,8)
180008cac:     	movq	(%r12), %rcx
180008cb0:     	leaq	0x4(%rcx), %rax
180008cb4:     	cmpq	%rbx, %rax
180008cb7:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008cbd:     	movq	%rax, (%r12)
180008cc1:     	cmpb	$0x0, (%r15)
180008cc5:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008ccb:     	testq	%rcx, %rcx
180008cce:     	js	0x180008cea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x512a>
180008cd0:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
180008cd6:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008cdc:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008ce2:     	movsd	%xmm0, (%rbp,%rcx,8)
180008ce8:     	jmp	0x180008cf7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5137>
180008cea:     	movb	$0x1, (%r15)
180008cee:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008cf7:     	cmpb	$0x0, (%r15)
180008cfb:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008d01:     	movq	(%r12), %rax
180008d05:     	leaq	0xb(%rax), %r8
180008d09:     	cmpq	%rbx, %r8
180008d0c:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008d12:     	movq	0x8(%r13,%rsi,8), %rdx
180008d17:     	movq	%r8, (%r12)
180008d1b:     	cmpb	$0x0, (%r15)
180008d1f:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008d25:     	movq	%rcx, (%r13,%rax,8)
180008d2a:     	movq	%rdx, 0x8(%r13,%rax,8)
180008d2f:     	movq	(%r12), %rdx
180008d33:     	cmpq	%rbx, %rdx
180008d36:     	movq	%rdx, %rcx
180008d39:     	jle	0x180008d45 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5185>
180008d3b:     	movb	$0x2, (%r15)
180008d3f:     	movq	(%r12), %rdx
180008d43:     	xorl	%ecx, %ecx
180008d45:     	leaq	0x3(%rdx), %r8
180008d49:     	cmpq	%rbx, %r8
180008d4c:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008d52:     	movq	%r8, (%r12)
180008d56:     	cmpb	$0x0, (%r15)
180008d5a:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008d60:     	movq	%rdx, %r8
180008d63:     	sarq	$0x3f, %r8
180008d67:     	andq	%rbx, %r8
180008d6a:     	leaq	(%r13,%rdx,8), %r9
180008d6f:     	movq	$0x0, (%r9,%r8,8)
180008d77:     	xorl	%r8d, %r8d
180008d7a:     	cmpq	$-0x1, %rdx
180008d7e:     	movl	$0x0, %r10d
180008d84:     	cmovlq	%rbx, %r10
180008d88:     	movq	$0x0, 0x8(%r9,%r10,8)
180008d91:     	cmpq	$-0x2, %rdx
180008d95:     	cmovlq	%rbx, %r8
180008d99:     	movq	%rcx, 0x10(%r9,%r8,8)
180008d9e:     	cmpb	$0x0, (%r15)
180008da2:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008da8:     	leaq	(%r13,%rax,8), %rcx
180008dad:     	movq	%rdx, 0x30(%rcx)
180008db1:     	movq	$0x0, 0x18(%rcx)
180008db9:     	movq	(%r12), %rdx
180008dbd:     	leaq	0x4(%rdx), %r8
180008dc1:     	cmpq	%rbx, %r8
180008dc4:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
180008dca:     	movq	%r8, (%r12)
180008dce:     	cmpb	$0x0, (%r15)
180008dd2:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008dd8:     	testq	%rdx, %rdx
180008ddb:     	js	0x180008e05 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5245>
180008ddd:     	movq	$0x0, (%rbp,%rdx,8)
180008de6:     	leaq	(%r13,%rdx,8), %r8
180008deb:     	movq	$0x1, 0x8(%r13,%rdx,8)
180008df4:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008dfd:     	movl	$0x1, %r9d
180008e03:     	jmp	0x180008e12 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5252>
180008e05:     	movb	$0x1, (%r15)
180008e09:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008e0f:     	movq	%r12, %r8
180008e12:     	movq	%r9, 0x18(%r8)
180008e16:     	cmpb	$0x0, (%r15)
180008e1a:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008e20:     	movq	%rdx, 0x10(%rcx)
180008e24:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008e2d:     	movq	$0x1, 0x50(%rcx)
180008e35:     	movq	$-0x1, 0x20(%rcx)
180008e3d:     	movq	$-0x1, 0x28(%rcx)
180008e45:     	movq	$-0x1, 0x38(%rcx)
180008e4d:     	movq	$-0x1, 0x40(%rcx)
180008e55:     	cmpb	$0x0, (%r15)
180008e59:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180008e5f:     	movq	%rax, 0x40(%r13,%rsi,8)
180008e64:     	movq	$0x1, 0x18(%r13,%rsi,8)
180008e6d:     	movq	0x30(%r13,%rsi,8), %rax
180008e72:     	movq	%rax, %rcx
180008e75:     	sarq	$0x3f, %rcx
180008e79:     	andq	%rbx, %rcx
180008e7c:     	leaq	(%r13,%rax,8), %rdx
180008e81:     	movq	%rcx, 0x160(%rsp)
180008e89:     	movq	%rdx, 0x150(%rsp)
180008e91:     	cmpq	$0x0, (%rdx,%rcx,8)
180008e96:     	jle	0x180009681 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ac1>
180008e9c:     	leaq	(,%rbx,8), %rcx
180008ea4:     	xorl	%edx, %edx
180008ea6:     	cmpq	$-0x2, %rax
180008eaa:     	movl	$0x0, %eax
180008eaf:     	movq	%rax, 0x148(%rsp)
180008eb7:     	cmovgeq	%rdx, %rcx
180008ebb:     	movq	%rcx, 0x158(%rsp)
180008ec3:     	movq	0x20(%r13,%rsi,8), %rax
180008ec8:     	testq	%rax, %rax
180008ecb:     	js	0x18000970e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b4e>
180008ed1:     	movq	0x150(%rsp), %rcx
180008ed9:     	movq	0x158(%rsp), %rdx
180008ee1:     	movq	0x10(%rcx,%rdx), %rcx
180008ee6:     	addq	0x148(%rsp), %rcx
180008eee:     	leaq	(%r13,%rcx,8), %rdx
180008ef3:     	sarq	$0x3f, %rcx
180008ef7:     	andq	%rbx, %rcx
180008efa:     	movq	(%rdx,%rcx,8), %rcx
180008efe:     	movq	%rcx, 0x140(%rsp)
180008f06:     	movq	0x8(%r12), %rcx
180008f0b:     	leaq	0x1(%rcx), %rdx
180008f0f:     	movq	%rdx, 0x8(%r12)
180008f14:     	cmpq	0x10(%r12), %rcx
180008f19:     	jge	0x18000970e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b4e>
180008f1f:     	movq	0x140(%rsp), %rcx
180008f27:     	movq	%rcx, 0x100(%rsp)
180008f2f:     	movq	%rax, 0xf8(%rsp)
180008f37:     	movq	0x2f8(%rsp), %rax
180008f3f:     	movq	%rax, 0xe8(%rsp)
180008f47:     	movq	0x2f0(%rsp), %rax
180008f4f:     	movq	%rax, 0xe0(%rsp)
180008f57:     	movq	%r15, 0xd8(%rsp)
180008f5f:     	movq	0x2e0(%rsp), %rax
180008f67:     	movq	%rax, 0xd0(%rsp)
180008f6f:     	movq	0x2d8(%rsp), %rax
180008f77:     	movq	%rax, 0xc8(%rsp)
180008f7f:     	movq	0x2d0(%rsp), %rax
180008f87:     	movq	%rax, 0xc0(%rsp)
180008f8f:     	movq	0x2c8(%rsp), %rax
180008f97:     	movq	%rax, 0xb8(%rsp)
180008f9f:     	movq	0x2c0(%rsp), %rax
180008fa7:     	movq	%rax, 0xb0(%rsp)
180008faf:     	movq	0x2b8(%rsp), %rax
180008fb7:     	movq	%rax, 0xa8(%rsp)
180008fbf:     	movq	%r12, 0xa0(%rsp)
180008fc7:     	movq	0x2a8(%rsp), %rax
180008fcf:     	movq	%rax, 0x98(%rsp)
180008fd7:     	movq	0x2a0(%rsp), %rax
180008fdf:     	movq	%rax, 0x90(%rsp)
180008fe7:     	movq	0x298(%rsp), %rax
180008fef:     	movq	%rax, 0x88(%rsp)
180008ff7:     	movq	0x290(%rsp), %rax
180008fff:     	movq	%rax, 0x80(%rsp)
180009007:     	movq	0x288(%rsp), %rax
18000900f:     	movq	%rax, 0x78(%rsp)
180009014:     	movq	%rbx, 0x70(%rsp)
180009019:     	movq	%r13, 0x68(%rsp)
18000901e:     	movq	0x270(%rsp), %rax
180009026:     	movq	%rax, 0x60(%rsp)
18000902b:     	movq	0x268(%rsp), %rax
180009033:     	movq	%rax, 0x58(%rsp)
180009038:     	movq	0x260(%rsp), %rax
180009040:     	movq	%rax, 0x50(%rsp)
180009045:     	movq	%rdi, 0x48(%rsp)
18000904a:     	movq	0x250(%rsp), %rax
180009052:     	movq	%rax, 0x40(%rsp)
180009057:     	movq	%r14, 0x38(%rsp)
18000905c:     	movq	%rbp, 0x30(%rsp)
180009061:     	movq	0x238(%rsp), %rax
180009069:     	movq	%rax, 0x28(%rsp)
18000906e:     	movq	0x230(%rsp), %rax
180009076:     	movq	%rax, 0x20(%rsp)
18000907b:     	movq	$-0x1, 0x108(%rsp)
180009087:     	movq	$0x0, 0xf0(%rsp)
180009093:     	leaq	0x12e(%rsp), %rcx
18000909b:     	leaq	0x180(%rsp), %rdx
1800090a3:     	movq	0x130(%rsp), %r8
1800090ab:     	movq	0x138(%rsp), %r9
1800090b3:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
1800090b8:     	testl	%eax, %eax
1800090ba:     	jne	0x180009720 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b60>
1800090c0:     	cmpb	$0x0, (%r15)
1800090c4:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800090ca:     	movq	0x8(%r12), %rcx
1800090cf:     	leaq	-0x1(%rcx), %rax
1800090d3:     	movq	%rax, 0x8(%r12)
1800090d8:     	movq	0x28(%r13,%rsi,8), %rax
1800090dd:     	testq	%rax, %rax
1800090e0:     	js	0x18000972d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b6d>
1800090e6:     	movq	%rcx, 0x8(%r12)
1800090eb:     	cmpq	0x10(%r12), %rcx
1800090f0:     	jg	0x18000972d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b6d>
1800090f6:     	movq	0x140(%rsp), %rcx
1800090fe:     	movq	%rcx, 0x100(%rsp)
180009106:     	movq	%rax, 0xf8(%rsp)
18000910e:     	movq	0x2f8(%rsp), %rax
180009116:     	movq	%rax, 0xe8(%rsp)
18000911e:     	movq	0x2f0(%rsp), %rax
180009126:     	movq	%rax, 0xe0(%rsp)
18000912e:     	movq	%r15, 0xd8(%rsp)
180009136:     	movq	0x2e0(%rsp), %rax
18000913e:     	movq	%rax, 0xd0(%rsp)
180009146:     	movq	0x2d8(%rsp), %rax
18000914e:     	movq	%rax, 0xc8(%rsp)
180009156:     	movq	0x2d0(%rsp), %rax
18000915e:     	movq	%rax, 0xc0(%rsp)
180009166:     	movq	0x2c8(%rsp), %rax
18000916e:     	movq	%rax, 0xb8(%rsp)
180009176:     	movq	0x2c0(%rsp), %rax
18000917e:     	movq	%rax, 0xb0(%rsp)
180009186:     	movq	0x2b8(%rsp), %rax
18000918e:     	movq	%rax, 0xa8(%rsp)
180009196:     	movq	%r12, 0xa0(%rsp)
18000919e:     	movq	0x2a8(%rsp), %rax
1800091a6:     	movq	%rax, 0x98(%rsp)
1800091ae:     	movq	0x2a0(%rsp), %rax
1800091b6:     	movq	%rax, 0x90(%rsp)
1800091be:     	movq	0x298(%rsp), %rax
1800091c6:     	movq	%rax, 0x88(%rsp)
1800091ce:     	movq	0x290(%rsp), %rax
1800091d6:     	movq	%rax, 0x80(%rsp)
1800091de:     	movq	0x288(%rsp), %rax
1800091e6:     	movq	%rax, 0x78(%rsp)
1800091eb:     	movq	%rbx, 0x70(%rsp)
1800091f0:     	movq	%r13, 0x68(%rsp)
1800091f5:     	movq	0x270(%rsp), %rax
1800091fd:     	movq	%rax, 0x60(%rsp)
180009202:     	movq	0x268(%rsp), %rax
18000920a:     	movq	%rax, 0x58(%rsp)
18000920f:     	movq	0x260(%rsp), %rax
180009217:     	movq	%rax, 0x50(%rsp)
18000921c:     	movq	%rdi, 0x48(%rsp)
180009221:     	movq	0x250(%rsp), %rax
180009229:     	movq	%rax, 0x40(%rsp)
18000922e:     	movq	%r14, 0x38(%rsp)
180009233:     	movq	%rbp, 0x30(%rsp)
180009238:     	movq	0x238(%rsp), %rax
180009240:     	movq	%rax, 0x28(%rsp)
180009245:     	movq	0x230(%rsp), %rax
18000924d:     	movq	%rax, 0x20(%rsp)
180009252:     	movq	$-0x1, 0x108(%rsp)
18000925e:     	movq	$0x0, 0xf0(%rsp)
18000926a:     	leaq	0x12d(%rsp), %rcx
180009272:     	leaq	0x178(%rsp), %rdx
18000927a:     	movq	0x130(%rsp), %r8
180009282:     	movq	0x138(%rsp), %r9
18000928a:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
18000928f:     	testl	%eax, %eax
180009291:     	jne	0x18000973f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b7f>
180009297:     	cmpb	$0x0, (%r15)
18000929b:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800092a1:     	movq	0x8(%r12), %rcx
1800092a6:     	leaq	-0x1(%rcx), %rax
1800092aa:     	movq	%rax, 0x8(%r12)
1800092af:     	movq	0x38(%r13,%rsi,8), %rax
1800092b4:     	testq	%rax, %rax
1800092b7:     	js	0x18000974c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b8c>
1800092bd:     	movq	%rcx, 0x8(%r12)
1800092c2:     	cmpq	0x10(%r12), %rcx
1800092c7:     	jg	0x18000974c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b8c>
1800092cd:     	movq	0x140(%rsp), %rcx
1800092d5:     	movq	%rcx, 0x100(%rsp)
1800092dd:     	movq	%rax, 0xf8(%rsp)
1800092e5:     	movq	0x2f8(%rsp), %rax
1800092ed:     	movq	%rax, 0xe8(%rsp)
1800092f5:     	movq	0x2f0(%rsp), %rax
1800092fd:     	movq	%rax, 0xe0(%rsp)
180009305:     	movq	%r15, 0xd8(%rsp)
18000930d:     	movq	0x2e0(%rsp), %rax
180009315:     	movq	%rax, 0xd0(%rsp)
18000931d:     	movq	0x2d8(%rsp), %rax
180009325:     	movq	%rax, 0xc8(%rsp)
18000932d:     	movq	0x2d0(%rsp), %rax
180009335:     	movq	%rax, 0xc0(%rsp)
18000933d:     	movq	0x2c8(%rsp), %rax
180009345:     	movq	%rax, 0xb8(%rsp)
18000934d:     	movq	0x2c0(%rsp), %rax
180009355:     	movq	%rax, 0xb0(%rsp)
18000935d:     	movq	0x2b8(%rsp), %rax
180009365:     	movq	%rax, 0xa8(%rsp)
18000936d:     	movq	%r12, 0xa0(%rsp)
180009375:     	movq	0x2a8(%rsp), %rax
18000937d:     	movq	%rax, 0x98(%rsp)
180009385:     	movq	0x2a0(%rsp), %rax
18000938d:     	movq	%rax, 0x90(%rsp)
180009395:     	movq	0x298(%rsp), %rax
18000939d:     	movq	%rax, 0x88(%rsp)
1800093a5:     	movq	0x290(%rsp), %rax
1800093ad:     	movq	%rax, 0x80(%rsp)
1800093b5:     	movq	0x288(%rsp), %rax
1800093bd:     	movq	%rax, 0x78(%rsp)
1800093c2:     	movq	%rbx, 0x70(%rsp)
1800093c7:     	movq	%r13, 0x68(%rsp)
1800093cc:     	movq	0x270(%rsp), %rax
1800093d4:     	movq	%rax, 0x60(%rsp)
1800093d9:     	movq	0x268(%rsp), %rax
1800093e1:     	movq	%rax, 0x58(%rsp)
1800093e6:     	movq	0x260(%rsp), %rax
1800093ee:     	movq	%rax, 0x50(%rsp)
1800093f3:     	movq	%rdi, 0x48(%rsp)
1800093f8:     	movq	0x250(%rsp), %rax
180009400:     	movq	%rax, 0x40(%rsp)
180009405:     	movq	%r14, 0x38(%rsp)
18000940a:     	movq	%rbp, 0x30(%rsp)
18000940f:     	movq	0x238(%rsp), %rax
180009417:     	movq	%rax, 0x28(%rsp)
18000941c:     	movq	0x230(%rsp), %rax
180009424:     	movq	%rax, 0x20(%rsp)
180009429:     	movq	$-0x1, 0x108(%rsp)
180009435:     	movq	$0x0, 0xf0(%rsp)
180009441:     	leaq	0x12c(%rsp), %rcx
180009449:     	leaq	0x170(%rsp), %rdx
180009451:     	movq	0x130(%rsp), %r8
180009459:     	movq	0x138(%rsp), %r9
180009461:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
180009466:     	testl	%eax, %eax
180009468:     	jne	0x18000975e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5b9e>
18000946e:     	cmpb	$0x0, (%r15)
180009472:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180009478:     	movq	0x8(%r12), %rcx
18000947d:     	leaq	-0x1(%rcx), %rax
180009481:     	movq	%rax, 0x8(%r12)
180009486:     	movq	0x40(%r13,%rsi,8), %rax
18000948b:     	testq	%rax, %rax
18000948e:     	js	0x18000976b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bab>
180009494:     	movq	%rcx, 0x8(%r12)
180009499:     	cmpq	0x10(%r12), %rcx
18000949e:     	jg	0x18000976b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bab>
1800094a4:     	movq	0x140(%rsp), %rcx
1800094ac:     	movq	%rcx, 0x100(%rsp)
1800094b4:     	movq	%rax, 0xf8(%rsp)
1800094bc:     	movq	0x2f8(%rsp), %rax
1800094c4:     	movq	%rax, 0xe8(%rsp)
1800094cc:     	movq	0x2f0(%rsp), %rax
1800094d4:     	movq	%rax, 0xe0(%rsp)
1800094dc:     	movq	%r15, 0xd8(%rsp)
1800094e4:     	movq	0x2e0(%rsp), %rax
1800094ec:     	movq	%rax, 0xd0(%rsp)
1800094f4:     	movq	0x2d8(%rsp), %rax
1800094fc:     	movq	%rax, 0xc8(%rsp)
180009504:     	movq	0x2d0(%rsp), %rax
18000950c:     	movq	%rax, 0xc0(%rsp)
180009514:     	movq	0x2c8(%rsp), %rax
18000951c:     	movq	%rax, 0xb8(%rsp)
180009524:     	movq	0x2c0(%rsp), %rax
18000952c:     	movq	%rax, 0xb0(%rsp)
180009534:     	movq	0x2b8(%rsp), %rax
18000953c:     	movq	%rax, 0xa8(%rsp)
180009544:     	movq	%r12, 0xa0(%rsp)
18000954c:     	movq	0x2a8(%rsp), %rax
180009554:     	movq	%rax, 0x98(%rsp)
18000955c:     	movq	0x2a0(%rsp), %rax
180009564:     	movq	%rax, 0x90(%rsp)
18000956c:     	movq	0x298(%rsp), %rax
180009574:     	movq	%rax, 0x88(%rsp)
18000957c:     	movq	0x290(%rsp), %rax
180009584:     	movq	%rax, 0x80(%rsp)
18000958c:     	movq	0x288(%rsp), %rax
180009594:     	movq	%rax, 0x78(%rsp)
180009599:     	movq	%rbx, 0x70(%rsp)
18000959e:     	movq	%r13, 0x68(%rsp)
1800095a3:     	movq	0x270(%rsp), %rax
1800095ab:     	movq	%rax, 0x60(%rsp)
1800095b0:     	movq	0x268(%rsp), %rax
1800095b8:     	movq	%rax, 0x58(%rsp)
1800095bd:     	movq	0x260(%rsp), %rax
1800095c5:     	movq	%rax, 0x50(%rsp)
1800095ca:     	movq	%rdi, 0x48(%rsp)
1800095cf:     	movq	0x250(%rsp), %rax
1800095d7:     	movq	%rax, 0x40(%rsp)
1800095dc:     	movq	%r14, 0x38(%rsp)
1800095e1:     	movq	%rbp, 0x30(%rsp)
1800095e6:     	movq	0x238(%rsp), %rax
1800095ee:     	movq	%rax, 0x28(%rsp)
1800095f3:     	movq	0x230(%rsp), %rax
1800095fb:     	movq	%rax, 0x20(%rsp)
180009600:     	movq	$-0x1, 0x108(%rsp)
18000960c:     	movq	$0x0, 0xf0(%rsp)
180009618:     	leaq	0x12b(%rsp), %rcx
180009620:     	leaq	0x168(%rsp), %rdx
180009628:     	movq	0x130(%rsp), %r8
180009630:     	movq	0x138(%rsp), %r9
180009638:     	callq	0x180007490 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x38d0>
18000963d:     	testl	%eax, %eax
18000963f:     	jne	0x18000977d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5bbd>
180009645:     	cmpb	$0x0, (%r15)
180009649:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000964f:     	movq	0x148(%rsp), %r8
180009657:     	incq	%r8
18000965a:     	decq	0x8(%r12)
18000965f:     	movq	0x160(%rsp), %rax
180009667:     	movq	0x150(%rsp), %rcx
18000966f:     	movq	%r8, 0x148(%rsp)
180009677:     	cmpq	(%rcx,%rax,8), %r8
18000967b:     	jl	0x180008ec3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5303>
180009681:     	movq	(%r12), %rcx
180009685:     	cmpq	%rbx, %rcx
180009688:     	movq	%rcx, %rdx
18000968b:     	jle	0x180009697 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ad7>
18000968d:     	movb	$0x2, (%r15)
180009691:     	movq	(%r12), %rcx
180009695:     	xorl	%edx, %edx
180009697:     	leaq	0x3(%rcx), %rax
18000969b:     	cmpq	%rbx, %rax
18000969e:     	jg	0x180008731 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4b71>
1800096a4:     	movq	%rax, (%r12)
1800096a8:     	cmpb	$0x0, (%r15)
1800096ac:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800096b2:     	movq	%rcx, %rax
1800096b5:     	sarq	$0x3f, %rax
1800096b9:     	andq	%rbx, %rax
1800096bc:     	leaq	(%r13,%rcx,8), %r8
1800096c1:     	movq	$0x0, (%r8,%rax,8)
1800096c9:     	xorl	%eax, %eax
1800096cb:     	cmpq	$-0x1, %rcx
1800096cf:     	movl	$0x0, %r9d
1800096d5:     	cmovlq	%rbx, %r9
1800096d9:     	movq	$0x0, 0x8(%r8,%r9,8)
1800096e2:     	cmpq	$-0x2, %rcx
1800096e6:     	cmovgeq	%rax, %rbx
1800096ea:     	movq	%rdx, 0x10(%r8,%rbx,8)
1800096ef:     	cmpb	$0x0, (%r15)
1800096f3:     	jne	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
1800096f9:     	movq	%rcx, 0x30(%r13,%rsi,8)
1800096fe:     	movq	0x110(%rsp), %rcx
180009706:     	movb	$0x0, (%rcx)
180009709:     	jmp	0x180007e13 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4253>
18000970e:     	movb	$0x1, (%r15)
180009712:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
18000971b:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
180009720:     	movq	0x180(%rsp), %rdx
180009728:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
18000972d:     	movb	$0x1, (%r15)
180009731:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
18000973a:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000973f:     	movq	0x178(%rsp), %rdx
180009747:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
18000974c:     	movb	$0x1, (%r15)
180009750:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180009759:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000975e:     	movq	0x170(%rsp), %rdx
180009766:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
18000976b:     	movb	$0x1, (%r15)
18000976f:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
180009778:     	jmp	0x180008031 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x4471>
18000977d:     	movq	0x168(%rsp), %rdx
180009785:     	jmp	0x180008491 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x48d1>
18000978a:     	int3
18000978b:     	int3
18000978c:     	int3
18000978d:     	int3
18000978e:     	int3
18000978f:     	int3
180009790:     	pushq	%rbx
180009792:     	subq	$0x20, %rsp
180009796:     	movq	%rcx, %rbx
180009799:     	callq	*0x3951(%rip)           # 0x18000d0f0
18000979f:     	movl	%eax, (%rbx)
1800097a1:     	addq	$0x20, %rsp
1800097a5:     	popq	%rbx
1800097a6:     	retq
1800097a7:     	int3
1800097a8:     	int3
1800097a9:     	int3
1800097aa:     	int3
1800097ab:     	int3
1800097ac:     	int3
1800097ad:     	int3
1800097ae:     	int3
1800097af:     	int3
1800097b0:     	movl	(%rcx), %ecx
1800097b2:     	jmpq	*0x3a57(%rip)           # 0x18000d210
1800097b9:     	int3
1800097ba:     	int3
1800097bb:     	int3
1800097bc:     	int3
1800097bd:     	int3
1800097be:     	int3
1800097bf:     	int3
1800097c0:     	pushq	%rbp
1800097c2:     	pushq	%rbx
1800097c3:     	pushq	%rsi
1800097c4:     	pushq	%rdi
1800097c5:     	pushq	%r14
1800097c7:     	pushq	%r15
1800097c9:     	movq	%rsp, %rbp
1800097cc:     	subq	$0x48, %rsp
1800097d0:     	movq	0x3a09(%rip), %rax      # 0x18000d1e0
1800097d7:     	xorl	%r15d, %r15d
1800097da:     	movq	%rcx, %rsi
1800097dd:     	movq	%r15, 0x38(%rbp)
1800097e1:     	movl	%r15d, %r14d
1800097e4:     	movq	%r15, 0x50(%rbp)
1800097e8:     	movq	%r15, 0x48(%rbp)
1800097ec:     	cmpq	%rax, 0x8(%rcx)
1800097f0:     	jne	0x18000995e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d9e>
1800097f6:     	leaq	0x48(%rbp), %rax
1800097fa:     	leaq	0x50(%rbp), %r9
1800097fe:     	movq	%rax, 0x20(%rsp)
180009803:     	leaq	0x38(%rbp), %r8
180009807:     	leaq	0x4676(%rip), %rdx      # 0x18000de84
18000980e:     	callq	*0x391c(%rip)           # 0x18000d130
180009814:     	testl	%eax, %eax
180009816:     	jne	0x180009954 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d94>
18000981c:     	movq	0x48(%rbp), %rbx
180009820:     	testq	%rbx, %rbx
180009823:     	je	0x180009945 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d85>
180009829:     	cmpq	0x3aa0(%rip), %rbx      # 0x18000d2d0
180009830:     	je	0x180009945 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d85>
180009836:     	movq	0x8(%rbx), %rax
18000983a:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009844:     	je	0x180009945 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d85>
18000984a:     	movq	0x20(%rbx), %rcx
18000984e:     	callq	*0x392c(%rip)           # 0x18000d180
180009854:     	movq	0x28(%rbx), %rcx
180009858:     	movq	%rax, %rdi
18000985b:     	callq	*0x391f(%rip)           # 0x18000d180
180009861:     	movq	0x30(%rbx), %rcx
180009865:     	movq	%rax, %r14
180009868:     	callq	*0x3922(%rip)           # 0x18000d190
18000986e:     	leaq	-0x10(%rbp), %r8
180009872:     	movl	%eax, %ebx
180009874:     	leaq	-0x18(%rbp), %rdx
180009878:     	leaq	0x40(%rbp), %rcx
18000987c:     	callq	*0x391e(%rip)           # 0x18000d1a0
180009882:     	callq	*0x38d8(%rip)           # 0x18000d160
180009888:     	movq	%rax, %rsi
18000988b:     	testq	%rax, %rax
18000988e:     	je	0x18000993b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d7b>
180009894:     	movl	%ebx, %r8d
180009897:     	movq	%rdi, %rdx
18000989a:     	movq	%r14, %rcx
18000989d:     	callq	*0x39b5(%rip)           # 0x18000d258
1800098a3:     	movq	%rax, %rdi
1800098a6:     	testq	%rax, %rax
1800098a9:     	je	0x18000993b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d7b>
1800098af:     	callq	*0x39b3(%rip)           # 0x18000d268
1800098b5:     	xorl	%r9d, %r9d
1800098b8:     	movq	%rsi, %r8
1800098bb:     	movq	%rax, %rcx
1800098be:     	movq	%rdi, %rdx
1800098c1:     	callq	*0x3979(%rip)           # 0x18000d240
1800098c7:     	movl	(%rsi), %ecx
1800098c9:     	movq	%rax, %rbx
1800098cc:     	testl	%ecx, %ecx
1800098ce:     	js	0x1800098e0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d20>
1800098d0:     	subl	$0x1, %ecx
1800098d3:     	movl	%ecx, (%rsi)
1800098d5:     	jne	0x1800098e0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d20>
1800098d7:     	movq	%rsi, %rcx
1800098da:     	callq	*0x38e8(%rip)           # 0x18000d1c8
1800098e0:     	movl	(%rdi), %eax
1800098e2:     	testl	%eax, %eax
1800098e4:     	js	0x1800098f6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d36>
1800098e6:     	subl	$0x1, %eax
1800098e9:     	movl	%eax, (%rdi)
1800098eb:     	jne	0x1800098f6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d36>
1800098ed:     	movq	%rdi, %rcx
1800098f0:     	callq	*0x38d2(%rip)           # 0x18000d1c8
1800098f6:     	testq	%rbx, %rbx
1800098f9:     	je	0x18000993b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d7b>
1800098fb:     	movq	-0x10(%rbp), %r8
1800098ff:     	movq	-0x18(%rbp), %rdx
180009903:     	movq	0x40(%rbp), %rcx
180009907:     	callq	*0x38c3(%rip)           # 0x18000d1d0
18000990d:     	movq	%rbx, %rcx
180009910:     	callq	*0x3912(%rip)           # 0x18000d228
180009916:     	movl	(%rbx), %eax
180009918:     	testl	%eax, %eax
18000991a:     	js	0x180009945 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d85>
18000991c:     	subl	$0x1, %eax
18000991f:     	movl	%eax, (%rbx)
180009921:     	jne	0x180009945 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5d85>
180009923:     	movq	%rbx, %rcx
180009926:     	callq	*0x389c(%rip)           # 0x18000d1c8
18000992c:     	xorl	%eax, %eax
18000992e:     	addq	$0x48, %rsp
180009932:     	popq	%r15
180009934:     	popq	%r14
180009936:     	popq	%rdi
180009937:     	popq	%rsi
180009938:     	popq	%rbx
180009939:     	popq	%rbp
18000993a:     	retq
18000993b:     	movq	0x40(%rbp), %rcx
18000993f:     	callq	*0x38bb(%rip)           # 0x18000d200
180009945:     	xorl	%eax, %eax
180009947:     	addq	$0x48, %rsp
18000994b:     	popq	%r15
18000994d:     	popq	%r14
18000994f:     	popq	%rdi
180009950:     	popq	%rsi
180009951:     	popq	%rbx
180009952:     	popq	%rbp
180009953:     	retq
180009954:     	movq	0x38(%rbp), %rbx
180009958:     	movq	0x50(%rbp), %r14
18000995c:     	jmp	0x180009965 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5da5>
18000995e:     	movq	%rsi, %rbx
180009961:     	movq	%rbx, 0x38(%rbp)
180009965:     	cmpq	0x3964(%rip), %rbx      # 0x18000d2d0
18000996c:     	jne	0x180009a04 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5e44>
180009972:     	leaq	-0x18(%rbp), %r8
180009976:     	leaq	-0x10(%rbp), %rdx
18000997a:     	leaq	0x40(%rbp), %rcx
18000997e:     	callq	*0x379c(%rip)           # 0x18000d120
180009984:     	movq	0x3945(%rip), %rax      # 0x18000d2d0
18000998b:     	cmpq	%rax, 0x40(%rbp)
18000998f:     	jne	0x1800099a4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5de4>
180009991:     	movq	0x3918(%rip), %rcx      # 0x18000d2b0
180009998:     	leaq	0x4499(%rip), %rdx      # 0x18000de38
18000999f:     	jmp	0x180009ac5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f05>
1800099a4:     	movq	0x40(%rbp), %rcx
1800099a8:     	testq	%rcx, %rcx
1800099ab:     	je	0x1800099ba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5dfa>
1800099ad:     	movl	(%rcx), %eax
1800099af:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800099b4:     	jae	0x1800099ba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5dfa>
1800099b6:     	incl	%eax
1800099b8:     	movl	%eax, (%rcx)
1800099ba:     	movq	-0x10(%rbp), %rcx
1800099be:     	testq	%rcx, %rcx
1800099c1:     	je	0x1800099d0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5e10>
1800099c3:     	movl	(%rcx), %eax
1800099c5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800099ca:     	jae	0x1800099d0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5e10>
1800099cc:     	incl	%eax
1800099ce:     	movl	%eax, (%rcx)
1800099d0:     	movq	-0x18(%rbp), %r8
1800099d4:     	testq	%r8, %r8
1800099d7:     	je	0x1800099ec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5e2c>
1800099d9:     	movl	(%r8), %eax
1800099dc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
1800099e1:     	jae	0x1800099ec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5e2c>
1800099e3:     	incl	%eax
1800099e5:     	movl	%eax, (%r8)
1800099e8:     	movq	-0x18(%rbp), %r8
1800099ec:     	movq	-0x10(%rbp), %rdx
1800099f0:     	movq	0x40(%rbp), %rcx
1800099f4:     	callq	*0x37d6(%rip)           # 0x18000d1d0
1800099fa:     	movl	$0x1, %ebx
1800099ff:     	jmp	0x180009ad1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f11>
180009a04:     	movq	0x8(%rbx), %rcx
180009a08:     	movl	0xa8(%rcx), %eax
180009a0e:     	testl	%eax, %eax
180009a10:     	jns	0x180009aa6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ee6>
180009a16:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180009a20:     	je	0x180009aa6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ee6>
180009a26:     	movq	%r14, %rdx
180009a29:     	movq	%rbx, %rcx
180009a2c:     	callq	*0x36b6(%rip)           # 0x18000d0e8
180009a32:     	movq	%rax, %rdi
180009a35:     	testq	%rax, %rax
180009a38:     	je	0x180009ace <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f0e>
180009a3e:     	movq	0x8(%rax), %rax
180009a42:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
180009a4c:     	jne	0x180009a7d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ebd>
180009a4e:     	movq	0x384b(%rip), %rcx      # 0x18000d2a0
180009a55:     	leaq	0x43fc(%rip), %rdx      # 0x18000de58
180009a5c:     	movq	(%rcx), %rcx
180009a5f:     	callq	*0x3843(%rip)           # 0x18000d2a8
180009a65:     	movl	(%rdi), %eax
180009a67:     	testl	%eax, %eax
180009a69:     	js	0x180009ace <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f0e>
180009a6b:     	subl	$0x1, %eax
180009a6e:     	movl	%eax, (%rdi)
180009a70:     	jne	0x180009ace <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f0e>
180009a72:     	movq	%rdi, %rcx
180009a75:     	callq	*0x374d(%rip)           # 0x18000d1c8
180009a7b:     	jmp	0x180009ace <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f0e>
180009a7d:     	movl	(%rdi), %eax
180009a7f:     	testl	%eax, %eax
180009a81:     	js	0x180009a93 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ed3>
180009a83:     	subl	$0x1, %eax
180009a86:     	movl	%eax, (%rdi)
180009a88:     	jne	0x180009a93 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ed3>
180009a8a:     	movq	%rdi, %rcx
180009a8d:     	callq	*0x3735(%rip)           # 0x18000d1c8
180009a93:     	movq	%r14, %rdx
180009a96:     	movq	%rbx, %rcx
180009a99:     	callq	*0x37c1(%rip)           # 0x18000d260
180009a9f:     	movl	$0x1, %ebx
180009aa4:     	jmp	0x180009ad1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f11>
180009aa6:     	btl	$0x1e, %eax
180009aaa:     	jae	0x180009ab7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ef7>
180009aac:     	movq	%rbx, %rdx
180009aaf:     	callq	*0x37ab(%rip)           # 0x18000d260
180009ab5:     	jmp	0x180009ace <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5f0e>
180009ab7:     	movq	0x37e2(%rip), %rcx      # 0x18000d2a0
180009abe:     	leaq	0x4393(%rip), %rdx      # 0x18000de58
180009ac5:     	movq	(%rcx), %rcx
180009ac8:     	callq	*0x37da(%rip)           # 0x18000d2a8
180009ace:     	movl	%r15d, %ebx
180009ad1:     	movq	0x48(%rbp), %rdi
180009ad5:     	testq	%rdi, %rdi
180009ad8:     	je	0x180009bfb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x603b>
180009ade:     	cmpq	0x37eb(%rip), %rdi      # 0x18000d2d0
180009ae5:     	je	0x180009bfb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x603b>
180009aeb:     	movq	0x8(%rdi), %rax
180009aef:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009af9:     	je	0x180009bfb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x603b>
180009aff:     	movq	0x20(%rdi), %rcx
180009b03:     	movq	%r12, 0x40(%rsp)
180009b08:     	callq	*0x3672(%rip)           # 0x18000d180
180009b0e:     	movq	0x28(%rdi), %rcx
180009b12:     	movq	%rax, %r14
180009b15:     	callq	*0x3665(%rip)           # 0x18000d180
180009b1b:     	movq	0x30(%rdi), %rcx
180009b1f:     	movq	%rax, %r12
180009b22:     	callq	*0x3668(%rip)           # 0x18000d190
180009b28:     	leaq	-0x10(%rbp), %r8
180009b2c:     	movl	%eax, %edi
180009b2e:     	leaq	-0x18(%rbp), %rdx
180009b32:     	leaq	0x40(%rbp), %rcx
180009b36:     	callq	*0x3664(%rip)           # 0x18000d1a0
180009b3c:     	callq	*0x361e(%rip)           # 0x18000d160
180009b42:     	movq	%rax, %r15
180009b45:     	testq	%rax, %rax
180009b48:     	je	0x180009bec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x602c>
180009b4e:     	movl	%edi, %r8d
180009b51:     	movq	%r14, %rdx
180009b54:     	movq	%r12, %rcx
180009b57:     	callq	*0x36fb(%rip)           # 0x18000d258
180009b5d:     	movq	%rax, %r14
180009b60:     	testq	%rax, %rax
180009b63:     	je	0x180009bec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x602c>
180009b69:     	callq	*0x36f9(%rip)           # 0x18000d268
180009b6f:     	xorl	%r9d, %r9d
180009b72:     	movq	%r15, %r8
180009b75:     	movq	%rax, %rcx
180009b78:     	movq	%r14, %rdx
180009b7b:     	callq	*0x36bf(%rip)           # 0x18000d240
180009b81:     	movl	(%r15), %ecx
180009b84:     	movq	%rax, %rdi
180009b87:     	testl	%ecx, %ecx
180009b89:     	js	0x180009b9c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5fdc>
180009b8b:     	subl	$0x1, %ecx
180009b8e:     	movl	%ecx, (%r15)
180009b91:     	jne	0x180009b9c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5fdc>
180009b93:     	movq	%r15, %rcx
180009b96:     	callq	*0x362c(%rip)           # 0x18000d1c8
180009b9c:     	movl	(%r14), %eax
180009b9f:     	testl	%eax, %eax
180009ba1:     	js	0x180009bb4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ff4>
180009ba3:     	subl	$0x1, %eax
180009ba6:     	movl	%eax, (%r14)
180009ba9:     	jne	0x180009bb4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x5ff4>
180009bab:     	movq	%r14, %rcx
180009bae:     	callq	*0x3614(%rip)           # 0x18000d1c8
180009bb4:     	testq	%rdi, %rdi
180009bb7:     	je	0x180009bec <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x602c>
180009bb9:     	movq	-0x10(%rbp), %r8
180009bbd:     	movq	-0x18(%rbp), %rdx
180009bc1:     	movq	0x40(%rbp), %rcx
180009bc5:     	callq	*0x3605(%rip)           # 0x18000d1d0
180009bcb:     	movq	%rdi, %rcx
180009bce:     	callq	*0x3654(%rip)           # 0x18000d228
180009bd4:     	movl	(%rdi), %eax
180009bd6:     	testl	%eax, %eax
180009bd8:     	js	0x180009bf6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6036>
180009bda:     	subl	$0x1, %eax
180009bdd:     	movl	%eax, (%rdi)
180009bdf:     	jne	0x180009bf6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6036>
180009be1:     	movq	%rdi, %rcx
180009be4:     	callq	*0x35de(%rip)           # 0x18000d1c8
180009bea:     	jmp	0x180009bf6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6036>
180009bec:     	movq	0x40(%rbp), %rcx
180009bf0:     	callq	*0x360a(%rip)           # 0x18000d200
180009bf6:     	movq	0x40(%rsp), %r12
180009bfb:     	movl	(%rsi), %ecx
180009bfd:     	testl	%ecx, %ecx
180009bff:     	js	0x180009c11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6051>
180009c01:     	subl	$0x1, %ecx
180009c04:     	movl	%ecx, (%rsi)
180009c06:     	jne	0x180009c11 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6051>
180009c08:     	movq	%rsi, %rcx
180009c0b:     	callq	*0x35b7(%rip)           # 0x18000d1c8
180009c11:     	movl	%ebx, %eax
180009c13:     	addq	$0x48, %rsp
180009c17:     	popq	%r15
180009c19:     	popq	%r14
180009c1b:     	popq	%rdi
180009c1c:     	popq	%rsi
180009c1d:     	popq	%rbx
180009c1e:     	popq	%rbp
180009c1f:     	retq
180009c20:     	movq	%rbx, 0x8(%rsp)
180009c25:     	movq	%rsi, 0x10(%rsp)
180009c2a:     	pushq	%rdi
180009c2b:     	subq	$0x20, %rsp
180009c2f:     	cmpq	$0x0, 0xb061(%rip)      # 0x180014c98
180009c37:     	movq	%rcx, %rsi
180009c3a:     	movslq	%edx, %rdi
180009c3d:     	jne	0x180009c8d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60cd>
180009c3f:     	leaq	0x4242(%rip), %rcx      # 0x18000de88
180009c46:     	callq	*0x35ec(%rip)           # 0x18000d238
180009c4c:     	movq	%rax, %rbx
180009c4f:     	testq	%rax, %rax
180009c52:     	je	0x180009ca1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60e1>
180009c54:     	leaq	0x4235(%rip), %rdx      # 0x18000de90
180009c5b:     	movq	%rax, %rcx
180009c5e:     	callq	*0x3504(%rip)           # 0x18000d168
180009c64:     	movl	(%rbx), %ecx
180009c66:     	movq	%rax, 0xb02b(%rip)      # 0x180014c98
180009c6d:     	testl	%ecx, %ecx
180009c6f:     	js	0x180009c88 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60c8>
180009c71:     	subl	$0x1, %ecx
180009c74:     	movl	%ecx, (%rbx)
180009c76:     	jne	0x180009c88 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60c8>
180009c78:     	movq	%rbx, %rcx
180009c7b:     	callq	*0x3547(%rip)           # 0x18000d1c8
180009c81:     	movq	0xb010(%rip), %rax      # 0x180014c98
180009c88:     	testq	%rax, %rax
180009c8b:     	je	0x180009ca1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60e1>
180009c8d:     	movq	%rdi, %rdx
180009c90:     	movq	%rsi, %rcx
180009c93:     	callq	*0x361f(%rip)           # 0x18000d2b8
180009c99:     	movq	%rax, %rbx
180009c9c:     	testq	%rax, %rax
180009c9f:     	jne	0x180009cb3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x60f3>
180009ca1:     	xorl	%eax, %eax
180009ca3:     	movq	0x30(%rsp), %rbx
180009ca8:     	movq	0x38(%rsp), %rsi
180009cad:     	addq	$0x20, %rsp
180009cb1:     	popq	%rdi
180009cb2:     	retq
180009cb3:     	movq	0xafde(%rip), %rcx      # 0x180014c98
180009cba:     	xorl	%r8d, %r8d
180009cbd:     	movq	%rbx, %rdx
180009cc0:     	callq	*0x34d2(%rip)           # 0x18000d198
180009cc6:     	movl	(%rbx), %ecx
180009cc8:     	movq	%rax, %rdi
180009ccb:     	testl	%ecx, %ecx
180009ccd:     	js	0x180009cdf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x611f>
180009ccf:     	subl	$0x1, %ecx
180009cd2:     	movl	%ecx, (%rbx)
180009cd4:     	jne	0x180009cdf <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x611f>
180009cd6:     	movq	%rbx, %rcx
180009cd9:     	callq	*0x34e9(%rip)           # 0x18000d1c8
180009cdf:     	movq	0x30(%rsp), %rbx
180009ce4:     	movq	%rdi, %rax
180009ce7:     	movq	0x38(%rsp), %rsi
180009cec:     	addq	$0x20, %rsp
180009cf0:     	popq	%rdi
180009cf1:     	retq
180009cf2:     	int3
180009cf3:     	int3
180009cf4:     	int3
180009cf5:     	int3
180009cf6:     	int3
180009cf7:     	int3
180009cf8:     	int3
180009cf9:     	int3
180009cfa:     	int3
180009cfb:     	int3
180009cfc:     	int3
180009cfd:     	int3
180009cfe:     	int3
180009cff:     	int3
180009d00:     	movq	%rbx, 0x8(%rsp)
180009d05:     	movq	%rsi, 0x10(%rsp)
180009d0a:     	pushq	%rdi
180009d0b:     	subq	$0x20, %rsp
180009d0f:     	movq	0xaf7a(%rip), %rax      # 0x180014c90
180009d16:     	movq	%rdx, %rdi
180009d19:     	movq	%rcx, %rsi
180009d1c:     	testq	%rax, %rax
180009d1f:     	jne	0x180009d81 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x61c1>
180009d21:     	leaq	0x4170(%rip), %rcx      # 0x18000de98
180009d28:     	callq	*0x350a(%rip)           # 0x18000d238
180009d2e:     	movq	%rax, %rbx
180009d31:     	testq	%rax, %rax
180009d34:     	je	0x180009d6f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x61af>
180009d36:     	leaq	0x4173(%rip), %rdx      # 0x18000deb0
180009d3d:     	movq	%rax, %rcx
180009d40:     	callq	*0x3422(%rip)           # 0x18000d168
180009d46:     	movl	(%rbx), %ecx
180009d48:     	movq	%rax, 0xaf41(%rip)      # 0x180014c90
180009d4f:     	testl	%ecx, %ecx
180009d51:     	js	0x180009d6a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x61aa>
180009d53:     	subl	$0x1, %ecx
180009d56:     	movl	%ecx, (%rbx)
180009d58:     	jne	0x180009d6a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x61aa>
180009d5a:     	movq	%rbx, %rcx
180009d5d:     	callq	*0x3465(%rip)           # 0x18000d1c8
180009d63:     	movq	0xaf26(%rip), %rax      # 0x180014c90
180009d6a:     	testq	%rax, %rax
180009d6d:     	jne	0x180009d81 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x61c1>
180009d6f:     	xorl	%eax, %eax
180009d71:     	movq	0x30(%rsp), %rbx
180009d76:     	movq	0x38(%rsp), %rsi
180009d7b:     	addq	$0x20, %rsp
180009d7f:     	popq	%rdi
180009d80:     	retq
180009d81:     	xorl	%r9d, %r9d
180009d84:     	movq	%rdi, %r8
180009d87:     	movq	%rsi, %rdx
180009d8a:     	movq	%rax, %rcx
180009d8d:     	movq	0x30(%rsp), %rbx
180009d92:     	movq	0x38(%rsp), %rsi
180009d97:     	addq	$0x20, %rsp
180009d9b:     	popq	%rdi
180009d9c:     	jmpq	*0x33f5(%rip)           # 0x18000d198
180009da3:     	int3
180009da4:     	int3
180009da5:     	int3
180009da6:     	int3
180009da7:     	int3
180009da8:     	int3
180009da9:     	int3
180009daa:     	int3
180009dab:     	int3
180009dac:     	int3
180009dad:     	int3
180009dae:     	int3
180009daf:     	int3
180009db0:     	movq	%rbx, 0x8(%rsp)
180009db5:     	movq	%rsi, 0x10(%rsp)
180009dba:     	pushq	%rdi
180009dbb:     	subq	$0x20, %rsp
180009dbf:     	movq	%rcx, %rbx
180009dc2:     	movq	%r8, %rdi
180009dc5:     	movq	0x10(%rcx), %rcx
180009dc9:     	movq	%rdx, %rsi
180009dcc:     	testq	%rcx, %rcx
180009dcf:     	je	0x180009dda <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x621a>
180009dd1:     	movq	%r8, %rdx
180009dd4:     	callq	*%rsi
180009dd6:     	testl	%eax, %eax
180009dd8:     	jne	0x180009dfd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x623d>
180009dda:     	movq	0x18(%rbx), %rcx
180009dde:     	testq	%rcx, %rcx
180009de1:     	je	0x180009dfb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x623b>
180009de3:     	movq	%rdi, %rdx
180009de6:     	movq	%rsi, %rax
180009de9:     	movq	0x30(%rsp), %rbx
180009dee:     	movq	0x38(%rsp), %rsi
180009df3:     	addq	$0x20, %rsp
180009df7:     	popq	%rdi
180009df8:     	jmpq	*%rax
180009dfb:     	xorl	%eax, %eax
180009dfd:     	movq	0x30(%rsp), %rbx
180009e02:     	movq	0x38(%rsp), %rsi
180009e07:     	addq	$0x20, %rsp
180009e0b:     	popq	%rdi
180009e0c:     	retq
180009e0d:     	int3
180009e0e:     	int3
180009e0f:     	int3
180009e10:     	pushq	%rbx
180009e12:     	subq	$0x20, %rsp
180009e16:     	movq	%rcx, %rbx
180009e19:     	movq	0x10(%rcx), %rcx
180009e1d:     	testq	%rcx, %rcx
180009e20:     	je	0x180009e3d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x627d>
180009e22:     	movq	$0x0, 0x10(%rbx)
180009e2a:     	movl	(%rcx), %eax
180009e2c:     	testl	%eax, %eax
180009e2e:     	js	0x180009e3d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x627d>
180009e30:     	subl	$0x1, %eax
180009e33:     	movl	%eax, (%rcx)
180009e35:     	jne	0x180009e3d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x627d>
180009e37:     	callq	*0x338b(%rip)           # 0x18000d1c8
180009e3d:     	movq	0x18(%rbx), %rcx
180009e41:     	testq	%rcx, %rcx
180009e44:     	je	0x180009e61 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62a1>
180009e46:     	movq	$0x0, 0x18(%rbx)
180009e4e:     	movl	(%rcx), %eax
180009e50:     	testl	%eax, %eax
180009e52:     	js	0x180009e61 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62a1>
180009e54:     	subl	$0x1, %eax
180009e57:     	movl	%eax, (%rcx)
180009e59:     	jne	0x180009e61 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62a1>
180009e5b:     	callq	*0x3367(%rip)           # 0x18000d1c8
180009e61:     	xorl	%eax, %eax
180009e63:     	addq	$0x20, %rsp
180009e67:     	popq	%rbx
180009e68:     	retq
180009e69:     	int3
180009e6a:     	int3
180009e6b:     	int3
180009e6c:     	int3
180009e6d:     	int3
180009e6e:     	int3
180009e6f:     	int3
180009e70:     	pushq	%rbx
180009e72:     	subq	$0x20, %rsp
180009e76:     	movq	%rcx, %rbx
180009e79:     	callq	*0x3399(%rip)           # 0x18000d218
180009e7f:     	movq	0x10(%rbx), %rcx
180009e83:     	testq	%rcx, %rcx
180009e86:     	je	0x180009ea3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62e3>
180009e88:     	movq	$0x0, 0x10(%rbx)
180009e90:     	movl	(%rcx), %eax
180009e92:     	testl	%eax, %eax
180009e94:     	js	0x180009ea3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62e3>
180009e96:     	subl	$0x1, %eax
180009e99:     	movl	%eax, (%rcx)
180009e9b:     	jne	0x180009ea3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x62e3>
180009e9d:     	callq	*0x3325(%rip)           # 0x18000d1c8
180009ea3:     	movq	0x18(%rbx), %rcx
180009ea7:     	testq	%rcx, %rcx
180009eaa:     	je	0x180009ec7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6307>
180009eac:     	movq	$0x0, 0x18(%rbx)
180009eb4:     	movl	(%rcx), %eax
180009eb6:     	testl	%eax, %eax
180009eb8:     	js	0x180009ec7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6307>
180009eba:     	subl	$0x1, %eax
180009ebd:     	movl	%eax, (%rcx)
180009ebf:     	jne	0x180009ec7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6307>
180009ec1:     	callq	*0x3301(%rip)           # 0x18000d1c8
180009ec7:     	movq	0x8(%rbx), %rax
180009ecb:     	movq	%rbx, %rcx
180009ece:     	addq	$0x20, %rsp
180009ed2:     	popq	%rbx
180009ed3:     	jmpq	*0x140(%rax)
180009eda:     	int3
180009edb:     	int3
180009edc:     	int3
180009edd:     	int3
180009ede:     	int3
180009edf:     	int3
180009ee0:     	pushq	%rbx
180009ee2:     	subq	$0x30, %rsp
180009ee6:     	movq	%r8, %r10
180009ee9:     	leaq	0x58(%rsp), %rax
180009eee:     	movq	%rax, 0x28(%rsp)
180009ef3:     	leaq	0xaad6(%rip), %r9       # 0x1800149d0
180009efa:     	movq	0x32e7(%rip), %rax      # 0x18000d1e8
180009f01:     	leaq	0x3fd8(%rip), %r8       # 0x18000dee0
180009f08:     	movq	%rdx, %r11
180009f0b:     	movq	%rax, 0x20(%rsp)
180009f10:     	movq	%rcx, %rbx
180009f13:     	movq	%r10, %rdx
180009f16:     	movq	%r11, %rcx
180009f19:     	callq	*0x31d9(%rip)           # 0x18000d0f8
180009f1f:     	testl	%eax, %eax
180009f21:     	je	0x180009f7c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63bc>
180009f23:     	xorl	%r8d, %r8d
180009f26:     	xorl	%edx, %edx
180009f28:     	movq	%rbx, %rcx
180009f2b:     	callq	*0x3317(%rip)           # 0x18000d248
180009f31:     	movq	%rax, %rbx
180009f34:     	testq	%rax, %rax
180009f37:     	je	0x180009f7c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63bc>
180009f39:     	movq	0x58(%rsp), %rax
180009f3e:     	movl	(%rax), %ecx
180009f40:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
180009f46:     	jae	0x180009f51 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6391>
180009f48:     	incl	%ecx
180009f4a:     	movl	%ecx, (%rax)
180009f4c:     	movq	0x58(%rsp), %rax
180009f51:     	xorl	%ecx, %ecx
180009f53:     	movq	%rax, 0x10(%rbx)
180009f57:     	callq	*0x321b(%rip)           # 0x18000d178
180009f5d:     	movq	%rax, 0x18(%rbx)
180009f61:     	testq	%rax, %rax
180009f64:     	jne	0x180009f84 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63c4>
180009f66:     	movl	(%rbx), %eax
180009f68:     	testl	%eax, %eax
180009f6a:     	js	0x180009f7c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63bc>
180009f6c:     	subl	$0x1, %eax
180009f6f:     	movl	%eax, (%rbx)
180009f71:     	jne	0x180009f7c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63bc>
180009f73:     	movq	%rbx, %rcx
180009f76:     	callq	*0x324c(%rip)           # 0x18000d1c8
180009f7c:     	xorl	%eax, %eax
180009f7e:     	addq	$0x30, %rsp
180009f82:     	popq	%rbx
180009f83:     	retq
180009f84:     	movq	%rbx, %rax
180009f87:     	addq	$0x30, %rsp
180009f8b:     	popq	%rbx
180009f8c:     	retq
180009f8d:     	int3
180009f8e:     	int3
180009f8f:     	int3
180009f90:     	movq	%rbx, 0x8(%rsp)
180009f95:     	movq	%rsi, 0x10(%rsp)
180009f9a:     	pushq	%rdi
180009f9b:     	subq	$0x20, %rsp
180009f9f:     	movq	%rcx, %rbx
180009fa2:     	movq	%r8, %rdi
180009fa5:     	movq	0x18(%rcx), %rcx
180009fa9:     	movq	%rdx, %rsi
180009fac:     	testq	%rcx, %rcx
180009faf:     	je	0x180009fba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x63fa>
180009fb1:     	movq	%r8, %rdx
180009fb4:     	callq	*%rsi
180009fb6:     	testl	%eax, %eax
180009fb8:     	jne	0x180009fdd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x641d>
180009fba:     	movq	0x40(%rbx), %rcx
180009fbe:     	testq	%rcx, %rcx
180009fc1:     	je	0x180009fdb <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x641b>
180009fc3:     	movq	%rdi, %rdx
180009fc6:     	movq	%rsi, %rax
180009fc9:     	movq	0x30(%rsp), %rbx
180009fce:     	movq	0x38(%rsp), %rsi
180009fd3:     	addq	$0x20, %rsp
180009fd7:     	popq	%rdi
180009fd8:     	jmpq	*%rax
180009fdb:     	xorl	%eax, %eax
180009fdd:     	movq	0x30(%rsp), %rbx
180009fe2:     	movq	0x38(%rsp), %rsi
180009fe7:     	addq	$0x20, %rsp
180009feb:     	popq	%rdi
180009fec:     	retq
180009fed:     	int3
180009fee:     	int3
180009fef:     	int3
180009ff0:     	pushq	%rbx
180009ff2:     	subq	$0x20, %rsp
180009ff6:     	movq	%rcx, %rbx
180009ff9:     	callq	*0x3219(%rip)           # 0x18000d218
180009fff:     	cmpq	$0x0, 0x48(%rbx)
18000a004:     	je	0x18000a00f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x644f>
18000a006:     	movq	%rbx, %rcx
18000a009:     	callq	*0x3179(%rip)           # 0x18000d188
18000a00f:     	movq	0x20(%rbx), %rcx
18000a013:     	callq	*0x319f(%rip)           # 0x18000d1b8
18000a019:     	movq	0x38(%rbx), %rcx
18000a01d:     	callq	*0x3195(%rip)           # 0x18000d1b8
18000a023:     	movq	0x18(%rbx), %rcx
18000a027:     	testq	%rcx, %rcx
18000a02a:     	je	0x18000a03f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x647f>
18000a02c:     	movl	(%rcx), %eax
18000a02e:     	testl	%eax, %eax
18000a030:     	js	0x18000a03f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x647f>
18000a032:     	subl	$0x1, %eax
18000a035:     	movl	%eax, (%rcx)
18000a037:     	jne	0x18000a03f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x647f>
18000a039:     	callq	*0x3189(%rip)           # 0x18000d1c8
18000a03f:     	movq	0x40(%rbx), %rcx
18000a043:     	testq	%rcx, %rcx
18000a046:     	je	0x18000a05b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x649b>
18000a048:     	movl	(%rcx), %eax
18000a04a:     	testl	%eax, %eax
18000a04c:     	js	0x18000a05b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x649b>
18000a04e:     	subl	$0x1, %eax
18000a051:     	movl	%eax, (%rcx)
18000a053:     	jne	0x18000a05b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x649b>
18000a055:     	callq	*0x316d(%rip)           # 0x18000d1c8
18000a05b:     	movq	0x8(%rbx), %rax
18000a05f:     	movq	%rbx, %rcx
18000a062:     	addq	$0x20, %rsp
18000a066:     	popq	%rbx
18000a067:     	jmpq	*0x140(%rax)
18000a06e:     	int3
18000a06f:     	int3
18000a070:     	pushq	%rbx
18000a072:     	subq	$0x20, %rsp
18000a076:     	callq	*0x3104(%rip)           # 0x18000d180
18000a07c:     	movq	%rax, %rbx
18000a07f:     	testq	%rax, %rax
18000a082:     	jne	0x18000a08a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x64ca>
18000a084:     	addq	$0x20, %rsp
18000a088:     	popq	%rbx
18000a089:     	retq
18000a08a:     	movq	%rbx, %rcx
18000a08d:     	movq	%rdi, 0x30(%rsp)
18000a092:     	callq	0x18000c3f5 <numba_list_iter_next+0xed5>
18000a097:     	leaq	0x1(%rax), %rcx
18000a09b:     	callq	*0x31af(%rip)           # 0x18000d250
18000a0a1:     	movq	%rax, %rdi
18000a0a4:     	testq	%rax, %rax
18000a0a7:     	jne	0x18000a0bc <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x64fc>
18000a0a9:     	callq	*0x3091(%rip)           # 0x18000d140
18000a0af:     	movq	0x30(%rsp), %rdi
18000a0b4:     	xorl	%eax, %eax
18000a0b6:     	addq	$0x20, %rsp
18000a0ba:     	popq	%rbx
18000a0bb:     	retq
18000a0bc:     	movq	%rbx, %rdx
18000a0bf:     	movq	%rdi, %rcx
18000a0c2:     	callq	0x18000c3ef <numba_list_iter_next+0xecf>
18000a0c7:     	movq	%rdi, %rax
18000a0ca:     	movq	0x30(%rsp), %rdi
18000a0cf:     	addq	$0x20, %rsp
18000a0d3:     	popq	%rbx
18000a0d4:     	retq
18000a0d5:     	int3
18000a0d6:     	int3
18000a0d7:     	int3
18000a0d8:     	int3
18000a0d9:     	int3
18000a0da:     	int3
18000a0db:     	int3
18000a0dc:     	int3
18000a0dd:     	int3
18000a0de:     	int3
18000a0df:     	int3
18000a0e0:     	movq	0x18(%rcx), %rcx
18000a0e4:     	movq	%rdx, %rax
18000a0e7:     	testq	%rcx, %rcx
18000a0ea:     	je	0x18000a0f2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6532>
18000a0ec:     	movq	%r8, %rdx
18000a0ef:     	jmpq	*%rax
18000a0f2:     	xorl	%eax, %eax
18000a0f4:     	retq
18000a0f5:     	int3
18000a0f6:     	int3
18000a0f7:     	int3
18000a0f8:     	int3
18000a0f9:     	int3
18000a0fa:     	int3
18000a0fb:     	int3
18000a0fc:     	int3
18000a0fd:     	int3
18000a0fe:     	int3
18000a0ff:     	int3
18000a100:     	movq	%rbx, 0x8(%rsp)
18000a105:     	pushq	%rdi
18000a106:     	subq	$0x20, %rsp
18000a10a:     	movq	0x28(%rcx), %rax
18000a10e:     	xorl	%edi, %edi
18000a110:     	movq	%rcx, %rbx
18000a113:     	testq	%rax, %rax
18000a116:     	je	0x18000a122 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6562>
18000a118:     	addq	$0x38, %rcx
18000a11c:     	callq	*%rax
18000a11e:     	movq	%rdi, 0x28(%rbx)
18000a122:     	movq	0x18(%rbx), %rcx
18000a126:     	testq	%rcx, %rcx
18000a129:     	je	0x18000a142 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6582>
18000a12b:     	movq	%rdi, 0x18(%rbx)
18000a12f:     	movl	(%rcx), %eax
18000a131:     	testl	%eax, %eax
18000a133:     	js	0x18000a142 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6582>
18000a135:     	subl	$0x1, %eax
18000a138:     	movl	%eax, (%rcx)
18000a13a:     	jne	0x18000a142 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6582>
18000a13c:     	callq	*0x3086(%rip)           # 0x18000d1c8
18000a142:     	movq	%rdi, 0x20(%rbx)
18000a146:     	xorl	%eax, %eax
18000a148:     	movq	0x30(%rsp), %rbx
18000a14d:     	addq	$0x20, %rsp
18000a151:     	popq	%rdi
18000a152:     	retq
18000a153:     	int3
18000a154:     	int3
18000a155:     	int3
18000a156:     	int3
18000a157:     	int3
18000a158:     	int3
18000a159:     	int3
18000a15a:     	int3
18000a15b:     	int3
18000a15c:     	int3
18000a15d:     	int3
18000a15e:     	int3
18000a15f:     	int3
18000a160:     	pushq	%rbx
18000a162:     	subq	$0x20, %rsp
18000a166:     	movq	%rcx, %rbx
18000a169:     	callq	*0x30a9(%rip)           # 0x18000d218
18000a16f:     	cmpq	$0x0, 0x30(%rbx)
18000a174:     	je	0x18000a17f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65bf>
18000a176:     	movq	%rbx, %rcx
18000a179:     	callq	*0x3009(%rip)           # 0x18000d188
18000a17f:     	callq	*0x2f83(%rip)           # 0x18000d108
18000a185:     	testl	%eax, %eax
18000a187:     	jne	0x18000a198 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65d8>
18000a189:     	movq	0x28(%rbx), %rax
18000a18d:     	testq	%rax, %rax
18000a190:     	je	0x18000a198 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65d8>
18000a192:     	leaq	0x38(%rbx), %rcx
18000a196:     	callq	*%rax
18000a198:     	movq	0x18(%rbx), %rcx
18000a19c:     	testq	%rcx, %rcx
18000a19f:     	je	0x18000a1b4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65f4>
18000a1a1:     	movl	(%rcx), %eax
18000a1a3:     	testl	%eax, %eax
18000a1a5:     	js	0x18000a1b4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65f4>
18000a1a7:     	subl	$0x1, %eax
18000a1aa:     	movl	%eax, (%rcx)
18000a1ac:     	jne	0x18000a1b4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x65f4>
18000a1ae:     	callq	*0x3014(%rip)           # 0x18000d1c8
18000a1b4:     	movq	0x8(%rbx), %rax
18000a1b8:     	movq	%rbx, %rcx
18000a1bb:     	addq	$0x20, %rsp
18000a1bf:     	popq	%rbx
18000a1c0:     	jmpq	*0x140(%rax)
18000a1c7:     	int3
18000a1c8:     	int3
18000a1c9:     	int3
18000a1ca:     	int3
18000a1cb:     	int3
18000a1cc:     	int3
18000a1cd:     	int3
18000a1ce:     	int3
18000a1cf:     	int3
18000a1d0:     	pushq	%rdi
18000a1d2:     	subq	$0x20, %rsp
18000a1d6:     	cmpq	$0x0, 0x20(%rcx)
18000a1db:     	movq	%rcx, %rdi
18000a1de:     	jne	0x18000a1ff <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x663f>
18000a1e0:     	movq	0x30c9(%rip), %rcx      # 0x18000d2b0
18000a1e7:     	leaq	0x3d42(%rip), %rdx      # 0x18000df30
18000a1ee:     	movq	(%rcx), %rcx
18000a1f1:     	callq	*0x30b1(%rip)           # 0x18000d2a8
18000a1f7:     	xorl	%eax, %eax
18000a1f9:     	addq	$0x20, %rsp
18000a1fd:     	popq	%rdi
18000a1fe:     	retq
18000a1ff:     	movq	%rdi, %rdx
18000a202:     	movq	%rbx, 0x30(%rsp)
18000a207:     	movl	$0x1, %ecx
18000a20c:     	callq	*0x30f6(%rip)           # 0x18000d308
18000a212:     	movq	%rax, %rbx
18000a215:     	testq	%rax, %rax
18000a218:     	jne	0x18000a225 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6665>
18000a21a:     	movq	0x30(%rsp), %rbx
18000a21f:     	addq	$0x20, %rsp
18000a223:     	popq	%rdi
18000a224:     	retq
18000a225:     	xorl	%r8d, %r8d
18000a228:     	movq	%rbx, %rdx
18000a22b:     	movq	%rdi, %rcx
18000a22e:     	callq	*0x20(%rdi)
18000a231:     	movl	(%rbx), %ecx
18000a233:     	movq	%rax, %rdi
18000a236:     	testl	%ecx, %ecx
18000a238:     	js	0x18000a24a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x668a>
18000a23a:     	subl	$0x1, %ecx
18000a23d:     	movl	%ecx, (%rbx)
18000a23f:     	jne	0x18000a24a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x668a>
18000a241:     	movq	%rbx, %rcx
18000a244:     	callq	*0x2f7e(%rip)           # 0x18000d1c8
18000a24a:     	movq	0x30(%rsp), %rbx
18000a24f:     	movq	%rdi, %rax
18000a252:     	addq	$0x20, %rsp
18000a256:     	popq	%rdi
18000a257:     	retq
18000a258:     	int3
18000a259:     	int3
18000a25a:     	int3
18000a25b:     	int3
18000a25c:     	int3
18000a25d:     	int3
18000a25e:     	int3
18000a25f:     	int3
18000a260:     	movq	%rbx, 0x8(%rsp)
18000a265:     	pushq	%rdi
18000a266:     	subq	$0x20, %rsp
18000a26a:     	movq	%r8, %rbx
18000a26d:     	callq	*0x2e7d(%rip)           # 0x18000d0f0
18000a273:     	movl	(%rbx), %ecx
18000a275:     	movl	%eax, %edi
18000a277:     	testl	%ecx, %ecx
18000a279:     	js	0x18000a28b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x66cb>
18000a27b:     	subl	$0x1, %ecx
18000a27e:     	movl	%ecx, (%rbx)
18000a280:     	jne	0x18000a28b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x66cb>
18000a282:     	movq	%rbx, %rcx
18000a285:     	callq	*0x2f3d(%rip)           # 0x18000d1c8
18000a28b:     	movl	%edi, %ecx
18000a28d:     	movq	0x30(%rsp), %rbx
18000a292:     	addq	$0x20, %rsp
18000a296:     	popq	%rdi
18000a297:     	jmpq	*0x2f72(%rip)           # 0x18000d210
18000a29e:     	int3
18000a29f:     	int3
18000a2a0:     	movq	%rbx, 0x8(%rsp)
18000a2a5:     	pushq	%rdi
18000a2a6:     	subq	$0x20, %rsp
18000a2aa:     	movl	(%rdx), %eax
18000a2ac:     	movq	%rdx, %rbx
18000a2af:     	movq	%rcx, %rdi
18000a2b2:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a2b7:     	jae	0x18000a2bd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x66fd>
18000a2b9:     	incl	%eax
18000a2bb:     	movl	%eax, (%rdx)
18000a2bd:     	movl	$0x30, %ecx
18000a2c2:     	callq	*0xa9a0(%rip)           # 0x180014c68
18000a2c8:     	cmpb	$0x0, 0xa971(%rip)      # 0x180014c40
18000a2cf:     	je	0x18000a2d9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6719>
18000a2d1:     	lock
18000a2d2:     	incq	0xa96f(%rip)            # 0x180014c48
18000a2d9:     	testq	%rax, %rax
18000a2dc:     	je	0x18000a313 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6753>
18000a2de:     	movl	$0x1, %ecx
18000a2e3:     	leaq	-0x8a(%rip), %rdx       # 0x18000a260 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x66a0>
18000a2ea:     	xchgq	%rcx, (%rax)
18000a2ed:     	xorl	%ecx, %ecx
18000a2ef:     	movq	%rdx, 0x8(%rax)
18000a2f3:     	movq	%rcx, 0x20(%rax)
18000a2f7:     	movq	%rcx, 0x28(%rax)
18000a2fb:     	movq	%rbx, 0x10(%rax)
18000a2ff:     	movq	%rdi, 0x18(%rax)
18000a303:     	cmpb	%cl, 0xa937(%rip)       # 0x180014c40
18000a309:     	je	0x18000a313 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6753>
18000a30b:     	lock
18000a30c:     	incq	0xa945(%rip)            # 0x180014c58
18000a313:     	movq	0x30(%rsp), %rbx
18000a318:     	addq	$0x20, %rsp
18000a31c:     	popq	%rdi
18000a31d:     	retq
18000a31e:     	int3
18000a31f:     	int3
18000a320:     	movq	%rbx, 0x8(%rsp)
18000a325:     	pushq	%rdi
18000a326:     	subq	$0x30, %rsp
18000a32a:     	movq	%rcx, %rdi
18000a32d:     	leaq	0xa68c(%rip), %r9       # 0x1800149c0
18000a334:     	movq	%r8, %rax
18000a337:     	leaq	0x58(%rsp), %rcx
18000a33c:     	movq	%rdx, %r10
18000a33f:     	movq	%rcx, 0x20(%rsp)
18000a344:     	movq	%r10, %rcx
18000a347:     	leaq	0x3c2a(%rip), %r8       # 0x18000df78
18000a34e:     	movq	%rax, %rdx
18000a351:     	callq	*0x2da1(%rip)           # 0x18000d0f8
18000a357:     	testl	%eax, %eax
18000a359:     	je	0x18000a383 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x67c3>
18000a35b:     	movq	0x58(%rsp), %rcx
18000a360:     	callq	*0x2d7a(%rip)           # 0x18000d0e0
18000a366:     	movq	%rax, %rbx
18000a369:     	callq	*0x2f79(%rip)           # 0x18000d2e8
18000a36f:     	testq	%rax, %rax
18000a372:     	jne	0x18000a383 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x67c3>
18000a374:     	movq	%rbx, 0x10(%rdi)
18000a378:     	movq	0x40(%rsp), %rbx
18000a37d:     	addq	$0x30, %rsp
18000a381:     	popq	%rdi
18000a382:     	retq
18000a383:     	movq	0x40(%rsp), %rbx
18000a388:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a38d:     	addq	$0x30, %rsp
18000a391:     	popq	%rdi
18000a392:     	retq
18000a393:     	int3
18000a394:     	int3
18000a395:     	int3
18000a396:     	int3
18000a397:     	int3
18000a398:     	int3
18000a399:     	int3
18000a39a:     	int3
18000a39b:     	int3
18000a39c:     	int3
18000a39d:     	int3
18000a39e:     	int3
18000a39f:     	int3
18000a3a0:     	subq	$0x38, %rsp
18000a3a4:     	movl	%r8d, %eax
18000a3a7:     	movq	%rdx, %r10
18000a3aa:     	movq	0x10(%rcx), %r8
18000a3ae:     	movq	%rcx, %rdx
18000a3b1:     	movl	%eax, 0x28(%rsp)
18000a3b5:     	movq	%r10, %rcx
18000a3b8:     	movl	$0x0, 0x20(%rsp)
18000a3c0:     	movq	0x20(%r8), %r9
18000a3c4:     	movq	0x18(%r8), %r8
18000a3c8:     	callq	*0x2e3a(%rip)           # 0x18000d208
18000a3ce:     	addq	$0x38, %rsp
18000a3d2:     	retq
18000a3d3:     	int3
18000a3d4:     	int3
18000a3d5:     	int3
18000a3d6:     	int3
18000a3d7:     	int3
18000a3d8:     	int3
18000a3d9:     	int3
18000a3da:     	int3
18000a3db:     	int3
18000a3dc:     	int3
18000a3dd:     	int3
18000a3de:     	int3
18000a3df:     	int3
18000a3e0:     	movq	0x10(%rcx), %rax
18000a3e4:     	lock
18000a3e5:     	incq	(%rax)
18000a3e8:     	movq	0x2ee1(%rip), %rax      # 0x18000d2d0
18000a3ef:     	retq
18000a3f0:     	subq	$0x28, %rsp
18000a3f4:     	movq	0x10(%rcx), %rcx
18000a3f8:     	callq	0x18000b6f0 <numba_list_iter_next+0x1d0>
18000a3fd:     	movq	0x2ecc(%rip), %rax      # 0x18000d2d0
18000a404:     	addq	$0x28, %rsp
18000a408:     	retq
18000a409:     	int3
18000a40a:     	int3
18000a40b:     	int3
18000a40c:     	int3
18000a40d:     	int3
18000a40e:     	int3
18000a40f:     	int3
18000a410:     	movq	0x10(%rcx), %rcx
18000a414:     	movq	0x18(%rcx), %rcx
18000a418:     	jmpq	*0x2d39(%rip)           # 0x18000d158
18000a41f:     	int3
18000a420:     	subq	$0x28, %rsp
18000a424:     	movq	0x10(%rcx), %rax
18000a428:     	testq	%rax, %rax
18000a42b:     	je	0x18000a449 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6889>
18000a42d:     	cmpq	$0x0, 0x18(%rax)
18000a432:     	je	0x18000a449 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6889>
18000a434:     	movq	(%rax), %rcx
18000a437:     	nop
18000a438:     	cmpq	$-0x1, %rcx
18000a43c:     	je	0x18000a449 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6889>
18000a43e:     	addq	$0x28, %rsp
18000a442:     	jmpq	*0x2cdf(%rip)           # 0x18000d128
18000a449:     	movq	0x2da8(%rip), %rcx      # 0x18000d1f8
18000a450:     	leaq	0x3b29(%rip), %rdx      # 0x18000df80
18000a457:     	movq	(%rcx), %rcx
18000a45a:     	callq	*0x2e48(%rip)           # 0x18000d2a8
18000a460:     	xorl	%eax, %eax
18000a462:     	addq	$0x28, %rsp
18000a466:     	retq
18000a467:     	int3
18000a468:     	int3
18000a469:     	int3
18000a46a:     	int3
18000a46b:     	int3
18000a46c:     	int3
18000a46d:     	int3
18000a46e:     	int3
18000a46f:     	int3
18000a470:     	movq	0x10(%rcx), %rcx
18000a474:     	movq	0x28(%rcx), %rcx
18000a478:     	jmpq	*0x2cd9(%rip)           # 0x18000d158
18000a47f:     	int3
18000a480:     	movq	0x10(%rcx), %rax
18000a484:     	movq	0x10(%rax), %rax
18000a488:     	testq	%rax, %rax
18000a48b:     	je	0x18000a49c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x68dc>
18000a48d:     	movl	(%rax), %ecx
18000a48f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000a495:     	jae	0x18000a4ba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x68fa>
18000a497:     	incl	%ecx
18000a499:     	movl	%ecx, (%rax)
18000a49b:     	retq
18000a49c:     	movq	0x2e2d(%rip), %rcx      # 0x18000d2d0
18000a4a3:     	movl	(%rcx), %eax
18000a4a5:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a4aa:     	jae	0x18000a4b7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x68f7>
18000a4ac:     	incl	%eax
18000a4ae:     	movl	%eax, (%rcx)
18000a4b0:     	movq	0x2e19(%rip), %rcx      # 0x18000d2d0
18000a4b7:     	movq	%rcx, %rax
18000a4ba:     	retq
18000a4bb:     	int3
18000a4bc:     	int3
18000a4bd:     	int3
18000a4be:     	int3
18000a4bf:     	int3
18000a4c0:     	pushq	%rbx
18000a4c2:     	subq	$0x20, %rsp
18000a4c6:     	movq	%rcx, %rbx
18000a4c9:     	movq	0x10(%rcx), %rcx
18000a4cd:     	callq	0x18000b6f0 <numba_list_iter_next+0x1d0>
18000a4d2:     	movq	0x8(%rbx), %rax
18000a4d6:     	movq	%rbx, %rcx
18000a4d9:     	addq	$0x20, %rsp
18000a4dd:     	popq	%rbx
18000a4de:     	jmpq	*0x140(%rax)
18000a4e5:     	int3
18000a4e6:     	int3
18000a4e7:     	int3
18000a4e8:     	int3
18000a4e9:     	int3
18000a4ea:     	int3
18000a4eb:     	int3
18000a4ec:     	int3
18000a4ed:     	int3
18000a4ee:     	int3
18000a4ef:     	int3
18000a4f0:     	movq	%rdi, 0x18(%rsp)
18000a4f5:     	pushq	%r14
18000a4f7:     	subq	$0x20, %rsp
18000a4fb:     	movq	0xa77e(%rip), %rax      # 0x180014c80
18000a502:     	movq	%rdx, %r14
18000a505:     	movq	%rcx, %rdi
18000a508:     	movq	0x8(%rcx), %rcx
18000a50c:     	movq	0x10(%rax), %rdx
18000a510:     	cmpq	%rdx, %rcx
18000a513:     	je	0x18000a530 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6970>
18000a515:     	callq	*0x2cbd(%rip)           # 0x18000d1d8
18000a51b:     	testl	%eax, %eax
18000a51d:     	jne	0x18000a530 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6970>
18000a51f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a524:     	movq	0x40(%rsp), %rdi
18000a529:     	addq	$0x20, %rsp
18000a52d:     	popq	%r14
18000a52f:     	retq
18000a530:     	movq	%rbx, 0x30(%rsp)
18000a535:     	movq	%rdi, %rdx
18000a538:     	movq	0x10(%rdi), %rbx
18000a53c:     	movq	%rbx, %rcx
18000a53f:     	movq	%rsi, 0x38(%rsp)
18000a544:     	movl	0x18(%rdi), %esi
18000a547:     	callq	0x18000a2a0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x66e0>
18000a54c:     	movq	%rax, (%r14)
18000a54f:     	movq	0xa72a(%rip), %rax      # 0x180014c80
18000a556:     	movq	%rbx, 0x20(%r14)
18000a55a:     	movl	0x18(%rdi), %edx
18000a55d:     	movq	0x20(%rdi), %rcx
18000a561:     	callq	*0x4f0(%rax)
18000a567:     	cmpl	$0x12, 0xa71e(%rip)     # 0x180014c8c
18000a56e:     	movq	0x30(%rsp), %rbx
18000a573:     	movq	%rax, 0x10(%r14)
18000a577:     	movq	0x38(%rdi), %rax
18000a57b:     	jl	0x18000a583 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x69c3>
18000a57d:     	movq	0x28(%rax), %rax
18000a581:     	jmp	0x18000a587 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x69c7>
18000a583:     	movslq	0x20(%rax), %rax
18000a587:     	xorl	%r8d, %r8d
18000a58a:     	movq	%rax, 0x18(%r14)
18000a58e:     	movq	%rdi, 0x8(%r14)
18000a592:     	leaq	0x28(%r14), %rax
18000a596:     	testl	%esi, %esi
18000a598:     	jle	0x18000a5db <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a1b>
18000a59a:     	nopw	(%rax,%rax)
18000a5a0:     	movq	0x20(%rdi), %rcx
18000a5a4:     	movq	(%rcx,%r8,8), %rdx
18000a5a8:     	incl	%r8d
18000a5ab:     	movq	%rdx, (%rax)
18000a5ae:     	addq	$0x8, %rax
18000a5b2:     	cmpl	%esi, %r8d
18000a5b5:     	jl	0x18000a5a0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x69e0>
18000a5b7:     	xorl	%r8d, %r8d
18000a5ba:     	nopw	(%rax,%rax)
18000a5c0:     	movq	0x28(%rdi), %rcx
18000a5c4:     	leaq	0x8(%rax), %rax
18000a5c8:     	movslq	%r8d, %rdx
18000a5cb:     	incl	%r8d
18000a5ce:     	movq	(%rcx,%rdx,8), %rdx
18000a5d2:     	movq	%rdx, -0x8(%rax)
18000a5d6:     	cmpl	%esi, %r8d
18000a5d9:     	jl	0x18000a5c0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a00>
18000a5db:     	movq	0x38(%rsp), %rsi
18000a5e0:     	xorl	%eax, %eax
18000a5e2:     	movq	0x40(%rsp), %rdi
18000a5e7:     	addq	$0x20, %rsp
18000a5eb:     	popq	%r14
18000a5ed:     	retq
18000a5ee:     	int3
18000a5ef:     	int3
18000a5f0:     	pushq	%rbx
18000a5f2:     	pushq	%rbp
18000a5f3:     	pushq	%rsi
18000a5f4:     	pushq	%rdi
18000a5f5:     	subq	$0x28, %rsp
18000a5f9:     	cmpq	$0x0, 0xa697(%rip)      # 0x180014c98
18000a601:     	movq	%rcx, %rbp
18000a604:     	movslq	0x8(%rdx), %rdi
18000a608:     	movq	(%rdx), %rsi
18000a60b:     	jne	0x18000a663 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6aa3>
18000a60d:     	leaq	0x3874(%rip), %rcx      # 0x18000de88
18000a614:     	callq	*0x2c1e(%rip)           # 0x18000d238
18000a61a:     	movq	%rax, %rbx
18000a61d:     	testq	%rax, %rax
18000a620:     	je	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a626:     	leaq	0x3863(%rip), %rdx      # 0x18000de90
18000a62d:     	movq	%rax, %rcx
18000a630:     	callq	*0x2b32(%rip)           # 0x18000d168
18000a636:     	movl	(%rbx), %edx
18000a638:     	movq	%rax, 0xa659(%rip)      # 0x180014c98
18000a63f:     	testl	%edx, %edx
18000a641:     	js	0x18000a65a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a9a>
18000a643:     	subl	$0x1, %edx
18000a646:     	movl	%edx, (%rbx)
18000a648:     	jne	0x18000a65a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a9a>
18000a64a:     	movq	%rbx, %rcx
18000a64d:     	callq	*0x2b75(%rip)           # 0x18000d1c8
18000a653:     	movq	0xa63e(%rip), %rax      # 0x180014c98
18000a65a:     	testq	%rax, %rax
18000a65d:     	je	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a663:     	movq	%rdi, %rdx
18000a666:     	movq	%rsi, %rcx
18000a669:     	callq	*0x2c49(%rip)           # 0x18000d2b8
18000a66f:     	movq	%rax, %rdi
18000a672:     	testq	%rax, %rax
18000a675:     	je	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a677:     	movq	0xa61a(%rip), %rcx      # 0x180014c98
18000a67e:     	xorl	%r8d, %r8d
18000a681:     	movq	%rax, %rdx
18000a684:     	callq	*0x2b0e(%rip)           # 0x18000d198
18000a68a:     	movl	(%rdi), %ecx
18000a68c:     	movq	%rax, %rbx
18000a68f:     	testl	%ecx, %ecx
18000a691:     	js	0x18000a6a3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ae3>
18000a693:     	subl	$0x1, %ecx
18000a696:     	movl	%ecx, (%rdi)
18000a698:     	jne	0x18000a6a3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ae3>
18000a69a:     	movq	%rdi, %rcx
18000a69d:     	callq	*0x2b25(%rip)           # 0x18000d1c8
18000a6a3:     	testq	%rbx, %rbx
18000a6a6:     	je	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a6a8:     	movq	0x8(%rbx), %r8
18000a6ac:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
18000a6b7:     	jne	0x18000a6f5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b35>
18000a6b9:     	movq	0x2be0(%rip), %rcx      # 0x18000d2a0
18000a6c0:     	leaq	0x39c1(%rip), %rdx      # 0x18000e088
18000a6c7:     	movq	0x18(%r8), %r8
18000a6cb:     	movq	(%rcx), %rcx
18000a6ce:     	callq	*0x2b1c(%rip)           # 0x18000d1f0
18000a6d4:     	movl	(%rbx), %eax
18000a6d6:     	testl	%eax, %eax
18000a6d8:     	js	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a6da:     	subl	$0x1, %eax
18000a6dd:     	movl	%eax, (%rbx)
18000a6df:     	jne	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a6e1:     	movq	%rbx, %rcx
18000a6e4:     	callq	*0x2ade(%rip)           # 0x18000d1c8
18000a6ea:     	xorl	%eax, %eax
18000a6ec:     	addq	$0x28, %rsp
18000a6f0:     	popq	%rdi
18000a6f1:     	popq	%rsi
18000a6f2:     	popq	%rbp
18000a6f3:     	popq	%rbx
18000a6f4:     	retq
18000a6f5:     	xorl	%r8d, %r8d
18000a6f8:     	leaq	0x9c41(%rip), %rcx      # 0x180014340
18000a6ff:     	xorl	%edx, %edx
18000a701:     	callq	*0x2b41(%rip)           # 0x18000d248
18000a707:     	movq	%rax, %rdi
18000a70a:     	testq	%rax, %rax
18000a70d:     	je	0x18000a6d4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b14>
18000a70f:     	movq	%rbp, %rcx
18000a712:     	movq	%rbx, 0x18(%rax)
18000a716:     	callq	*0x2aa4(%rip)           # 0x18000d1c0
18000a71c:     	movq	%rax, 0x10(%rdi)
18000a720:     	movq	%rax, %rcx
18000a723:     	testq	%rax, %rax
18000a726:     	jne	0x18000a73a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b7a>
18000a728:     	movl	(%rdi), %eax
18000a72a:     	testl	%eax, %eax
18000a72c:     	js	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a72e:     	subl	$0x1, %eax
18000a731:     	movl	%eax, (%rdi)
18000a733:     	jne	0x18000a6ea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b2a>
18000a735:     	movq	%rdi, %rcx
18000a738:     	jmp	0x18000a6e4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b24>
18000a73a:     	movl	(%rax), %eax
18000a73c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a741:     	jae	0x18000a747 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6b87>
18000a743:     	incl	%eax
18000a745:     	movl	%eax, (%rcx)
18000a747:     	movq	%rdi, %rax
18000a74a:     	addq	$0x28, %rsp
18000a74e:     	popq	%rdi
18000a74f:     	popq	%rsi
18000a750:     	popq	%rbp
18000a751:     	popq	%rbx
18000a752:     	retq
18000a753:     	int3
18000a754:     	int3
18000a755:     	int3
18000a756:     	int3
18000a757:     	int3
18000a758:     	int3
18000a759:     	int3
18000a75a:     	int3
18000a75b:     	int3
18000a75c:     	int3
18000a75d:     	int3
18000a75e:     	int3
18000a75f:     	int3
18000a760:     	movq	%r9, 0x20(%rsp)
18000a765:     	movq	%r8, 0x18(%rsp)
18000a76a:     	movq	%rdx, 0x10(%rsp)
18000a76f:     	movq	%rcx, 0x8(%rsp)
18000a774:     	pushq	%rbx
18000a775:     	pushq	%rbp
18000a776:     	pushq	%rsi
18000a777:     	pushq	%rdi
18000a778:     	pushq	%r12
18000a77a:     	pushq	%r13
18000a77c:     	pushq	%r14
18000a77e:     	pushq	%r15
18000a780:     	subq	$0x68, %rsp
18000a784:     	movq	%rcx, %r14
18000a787:     	movq	%r9, %r15
18000a78a:     	leaq	0x33af(%rip), %rcx      # 0x18000db40
18000a791:     	movq	%r8, %r13
18000a794:     	movq	%rdx, %rsi
18000a797:     	callq	*0x2a9b(%rip)           # 0x18000d238
18000a79d:     	movq	%rax, %rdi
18000a7a0:     	testq	%rax, %rax
18000a7a3:     	jne	0x18000a7dc <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6c1c>
18000a7a5:     	movq	0x298c(%rip), %rcx      # 0x18000d138
18000a7ac:     	movq	(%rcx), %rcx
18000a7af:     	callq	*0x29fb(%rip)           # 0x18000d1b0
18000a7b5:     	testl	%eax, %eax
18000a7b7:     	je	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a7bd:     	callq	*0x2afd(%rip)           # 0x18000d2c0
18000a7c3:     	leaq	0x3396(%rip), %rcx      # 0x18000db60
18000a7ca:     	callq	*0x2a68(%rip)           # 0x18000d238
18000a7d0:     	movq	%rax, %rdi
18000a7d3:     	testq	%rax, %rax
18000a7d6:     	je	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a7dc:     	leaq	0x339d(%rip), %rdx      # 0x18000db80
18000a7e3:     	movq	%rdi, %rcx
18000a7e6:     	callq	*0x297c(%rip)           # 0x18000d168
18000a7ec:     	movl	(%rdi), %ecx
18000a7ee:     	movq	%rax, %rbx
18000a7f1:     	testl	%ecx, %ecx
18000a7f3:     	js	0x18000a805 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6c45>
18000a7f5:     	subl	$0x1, %ecx
18000a7f8:     	movl	%ecx, (%rdi)
18000a7fa:     	jne	0x18000a805 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6c45>
18000a7fc:     	movq	%rdi, %rcx
18000a7ff:     	callq	*0x29c3(%rip)           # 0x18000d1c8
18000a805:     	testq	%rbx, %rbx
18000a808:     	je	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a80e:     	movq	0x28eb(%rip), %rax      # 0x18000d100
18000a815:     	cmpq	%rax, 0x8(%rbx)
18000a819:     	je	0x18000a855 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6c95>
18000a81b:     	movq	0x2a8e(%rip), %rcx      # 0x18000d2b0
18000a822:     	leaq	0x3367(%rip), %rdx      # 0x18000db90
18000a829:     	movq	(%rcx), %rcx
18000a82c:     	callq	*0x2a76(%rip)           # 0x18000d2a8
18000a832:     	movl	(%rbx), %eax
18000a834:     	testl	%eax, %eax
18000a836:     	js	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a83c:     	subl	$0x1, %eax
18000a83f:     	movl	%eax, (%rbx)
18000a841:     	jne	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a847:     	movq	%rbx, %rcx
18000a84a:     	callq	*0x2978(%rip)           # 0x18000d1c8
18000a850:     	jmp	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a855:     	xorl	%edx, %edx
18000a857:     	movq	%rbx, %rcx
18000a85a:     	callq	*0x2948(%rip)           # 0x18000d1a8
18000a860:     	movl	(%rbx), %ecx
18000a862:     	movq	%rax, 0xa417(%rip)      # 0x180014c80
18000a869:     	testl	%ecx, %ecx
18000a86b:     	js	0x18000a884 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6cc4>
18000a86d:     	subl	$0x1, %ecx
18000a870:     	movl	%ecx, (%rbx)
18000a872:     	jne	0x18000a884 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6cc4>
18000a874:     	movq	%rbx, %rcx
18000a877:     	callq	*0x294b(%rip)           # 0x18000d1c8
18000a87d:     	movq	0xa3fc(%rip), %rax      # 0x180014c80
18000a884:     	testq	%rax, %rax
18000a887:     	jne	0x18000a8a2 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ce2>
18000a889:     	leaq	0x3328(%rip), %rdx      # 0x18000dbb8
18000a890:     	movq	0x2a19(%rip), %rcx      # 0x18000d2b0
18000a897:     	movq	(%rcx), %rcx
18000a89a:     	callq	*0x2a08(%rip)           # 0x18000d2a8
18000a8a0:     	jmp	0x18000a8d7 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d17>
18000a8a2:     	callq	*(%rax)
18000a8a4:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
18000a8a9:     	jbe	0x18000a90a <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d4a>
18000a8ab:     	movq	0x29fe(%rip), %rax      # 0x18000d2b0
18000a8b2:     	movq	(%rax), %rbx
18000a8b5:     	movq	0xa3c4(%rip), %rax      # 0x180014c80
18000a8bc:     	callq	*(%rax)
18000a8be:     	movl	$0x2000000, %r8d        # imm = 0x2000000
18000a8c4:     	leaq	0x3315(%rip), %rdx      # 0x18000dbe0
18000a8cb:     	movl	%eax, %r9d
18000a8ce:     	movq	%rbx, %rcx
18000a8d1:     	callq	*0x2919(%rip)           # 0x18000d1f0
18000a8d7:     	callq	*0x283b(%rip)           # 0x18000d118
18000a8dd:     	movq	0x282c(%rip), %rcx      # 0x18000d110
18000a8e4:     	leaq	0x351d(%rip), %rdx      # 0x18000de08
18000a8eb:     	movq	(%rcx), %rcx
18000a8ee:     	callq	*0x29b4(%rip)           # 0x18000d2a8
18000a8f4:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a8f9:     	addq	$0x68, %rsp
18000a8fd:     	popq	%r15
18000a8ff:     	popq	%r14
18000a901:     	popq	%r13
18000a903:     	popq	%r12
18000a905:     	popq	%rdi
18000a906:     	popq	%rsi
18000a907:     	popq	%rbp
18000a908:     	popq	%rbx
18000a909:     	retq
18000a90a:     	movq	0xa36f(%rip), %rax      # 0x180014c80
18000a911:     	callq	*0x698(%rax)
18000a917:     	movl	%eax, 0xa36f(%rip)      # 0x180014c8c
18000a91d:     	cmpl	$0x10, %eax
18000a920:     	jge	0x18000a93e <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d7e>
18000a922:     	movq	0x2987(%rip), %rcx      # 0x18000d2b0
18000a929:     	leaq	0x3300(%rip), %rdx      # 0x18000dc30
18000a930:     	movl	%eax, %r9d
18000a933:     	movl	$0x10, %r8d
18000a939:     	movq	(%rcx), %rcx
18000a93c:     	jmp	0x18000a8d1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d11>
18000a93e:     	movq	0xa33b(%rip), %rax      # 0x180014c80
18000a945:     	callq	*0x690(%rax)
18000a94b:     	testl	%eax, %eax
18000a94d:     	jne	0x18000a95b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d9b>
18000a94f:     	leaq	0x342a(%rip), %rdx      # 0x18000dd80
18000a956:     	jmp	0x18000a890 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6cd0>
18000a95b:     	cmpl	$0x1, %eax
18000a95e:     	je	0x18000a96c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6dac>
18000a960:     	leaq	0x3449(%rip), %rdx      # 0x18000ddb0
18000a967:     	jmp	0x18000a890 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6cd0>
18000a96c:     	leaq	0x9ead(%rip), %rcx      # 0x180014820
18000a973:     	callq	*0x27f7(%rip)           # 0x18000d170
18000a979:     	testl	%eax, %eax
18000a97b:     	jne	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000a981:     	leaq	0x99b8(%rip), %rcx      # 0x180014340
18000a988:     	callq	*0x27e2(%rip)           # 0x18000d170
18000a98e:     	testl	%eax, %eax
18000a990:     	jne	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000a996:     	leaq	0x9ce3(%rip), %rcx      # 0x180014680
18000a99d:     	callq	*0x27cd(%rip)           # 0x18000d170
18000a9a3:     	testl	%eax, %eax
18000a9a5:     	jne	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000a9ab:     	xorl	%ebx, %ebx
18000a9ad:     	cmpl	%ebx, 0xa2d5(%rip)      # 0x180014c88
18000a9b3:     	jne	0x18000a9f6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6e36>
18000a9b5:     	movq	%gs:0x58, %rax
18000a9be:     	movl	0xa2dc(%rip), %ecx      # 0x180014ca0
18000a9c4:     	movl	$0x1, 0xa2ba(%rip)      # 0x180014c88
18000a9ce:     	movq	(%rax,%rcx,8), %rdx
18000a9d2:     	movl	$0x10, %eax
18000a9d7:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a9de:     	movl	$0x9f0, %eax            # imm = 0x9F0
18000a9e3:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a9ea:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000a9ef:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000a9f6:     	movl	%ebx, 0xa23c(%rip)      # 0x180014c38
18000a9fc:     	movq	%rbx, %rax
18000a9ff:     	movb	%bl, 0xa23b(%rip)       # 0x180014c40
18000aa05:     	movq	%rbx, %rcx
18000aa08:     	xchgq	%rax, 0xa239(%rip)      # 0x180014c48
18000aa0f:     	xchgq	%rcx, 0xa23a(%rip)      # 0x180014c50
18000aa16:     	movq	%rbx, %rax
18000aa19:     	movq	%rbx, %rcx
18000aa1c:     	xchgq	%rax, 0xa235(%rip)      # 0x180014c58
18000aa23:     	xchgq	%rcx, 0xa236(%rip)      # 0x180014c60
18000aa2a:     	movq	0x262f(%rip), %rax      # 0x18000d060
18000aa31:     	leaq	0x9aa8(%rip), %rcx      # 0x1800144e0
18000aa38:     	movq	%rax, 0xa229(%rip)      # 0x180014c68
18000aa3f:     	movq	0x262a(%rip), %rax      # 0x18000d070
18000aa46:     	movq	%rax, 0xa223(%rip)      # 0x180014c70
18000aa4d:     	movq	0x2614(%rip), %rax      # 0x18000d068
18000aa54:     	movq	%rax, 0xa21d(%rip)      # 0x180014c78
18000aa5b:     	movq	0x27e6(%rip), %rax      # 0x18000d248
18000aa62:     	movq	%rax, 0x9baf(%rip)      # 0x180014618
18000aa69:     	callq	*0x2701(%rip)           # 0x18000d170
18000aa6f:     	testl	%eax, %eax
18000aa71:     	jne	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000aa77:     	leaq	0x34a2(%rip), %rdx      # 0x18000df20
18000aa7e:     	movq	%r14, %rcx
18000aa81:     	callq	*0x26e1(%rip)           # 0x18000d168
18000aa87:     	movq	%rax, 0x28(%rsp)
18000aa8c:     	movq	%rax, %rdi
18000aa8f:     	testq	%rax, %rax
18000aa92:     	je	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000aa98:     	leaq	0x361a(%rip), %rcx      # 0x18000e0b9
18000aa9f:     	callq	*0x27db(%rip)           # 0x18000d280
18000aaa5:     	movq	%rax, 0x20(%rsp)
18000aaaa:     	movq	%rax, %r12
18000aaad:     	testq	%rax, %rax
18000aab0:     	je	0x18000adf4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7234>
18000aab6:     	movl	%ebx, %ebp
18000aab8:     	cmpq	%rbx, (%rsi)
18000aabb:     	je	0x18000ac64 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x70a4>
18000aac1:     	movslq	%ebp, %rbx
18000aac4:     	leaq	0x30(%rsp), %rdx
18000aac9:     	movq	%r14, %rcx
18000aacc:     	leaq	(%rbx,%rbx,4), %rax
18000aad0:     	movups	(%r13,%rax,8), %xmm0
18000aad6:     	movups	0x10(%r13,%rax,8), %xmm1
18000aadc:     	movaps	%xmm0, 0x30(%rsp)
18000aae1:     	movsd	0x20(%r13,%rax,8), %xmm0
18000aae8:     	movsd	%xmm0, 0x50(%rsp)
18000aaee:     	movaps	%xmm1, 0x40(%rsp)
18000aaf3:     	callq	0x18000a5f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a30>
18000aaf8:     	movq	%rax, %r14
18000aafb:     	testq	%rax, %rax
18000aafe:     	je	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000ab04:     	movq	(%rsi), %rcx
18000ab07:     	callq	*0x2773(%rip)           # 0x18000d280
18000ab0d:     	movq	%rax, %r13
18000ab10:     	testq	%rax, %rax
18000ab13:     	je	0x18000ae17 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7257>
18000ab19:     	movq	(%r15,%rbx,8), %rcx
18000ab1d:     	xorl	%edx, %edx
18000ab1f:     	movq	%r14, (%rcx)
18000ab22:     	leaq	0x9cf7(%rip), %rcx      # 0x180014820
18000ab29:     	movq	0x8(%rsi), %r12
18000ab2d:     	callq	*0x261d(%rip)           # 0x18000d150
18000ab33:     	movq	%rax, %rbx
18000ab36:     	testq	%rax, %rax
18000ab39:     	je	0x18000abb6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff6>
18000ab3b:     	movq	%r13, %rcx
18000ab3e:     	callq	*0x263c(%rip)           # 0x18000d180
18000ab44:     	movq	%rax, %rdi
18000ab47:     	testq	%rax, %rax
18000ab4a:     	je	0x18000ab6c <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6fac>
18000ab4c:     	movq	%rax, %rcx
18000ab4f:     	callq	0x18000c3f5 <numba_list_iter_next+0xed5>
18000ab54:     	leaq	0x1(%rax), %rcx
18000ab58:     	callq	*0x26f2(%rip)           # 0x18000d250
18000ab5e:     	movq	%rax, %rsi
18000ab61:     	testq	%rax, %rax
18000ab64:     	jne	0x18000ab74 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6fb4>
18000ab66:     	callq	*0x25d4(%rip)           # 0x18000d140
18000ab6c:     	xorl	%eax, %eax
18000ab6e:     	movq	%rax, 0x20(%rbx)
18000ab72:     	jmp	0x18000aba5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6fe5>
18000ab74:     	movq	%rdi, %rdx
18000ab77:     	movq	%rsi, %rcx
18000ab7a:     	callq	0x18000c3ef <numba_list_iter_next+0xecf>
18000ab7f:     	movq	0x20(%rsp), %rcx
18000ab84:     	movq	%rsi, 0x20(%rbx)
18000ab88:     	movq	%r12, 0x28(%rbx)
18000ab8c:     	movl	$0x3, 0x30(%rbx)
18000ab93:     	callq	0x18000a070 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x64b0>
18000ab98:     	movq	%rax, 0x38(%rbx)
18000ab9c:     	testq	%rax, %rax
18000ab9f:     	jne	0x18000ad10 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7150>
18000aba5:     	movl	(%rbx), %eax
18000aba7:     	testl	%eax, %eax
18000aba9:     	js	0x18000abb6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff6>
18000abab:     	subl	$0x1, %eax
18000abae:     	movl	%eax, (%rbx)
18000abb0:     	je	0x18000ad5d <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x719d>
18000abb6:     	xorl	%edi, %edi
18000abb8:     	movl	(%r14), %eax
18000abbb:     	testl	%eax, %eax
18000abbd:     	js	0x18000abd0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7010>
18000abbf:     	subl	$0x1, %eax
18000abc2:     	movl	%eax, (%r14)
18000abc5:     	jne	0x18000abd0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7010>
18000abc7:     	movq	%r14, %rcx
18000abca:     	callq	*0x25f8(%rip)           # 0x18000d1c8
18000abd0:     	movl	(%r13), %eax
18000abd4:     	testl	%eax, %eax
18000abd6:     	js	0x18000abea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x702a>
18000abd8:     	subl	$0x1, %eax
18000abdb:     	movl	%eax, (%r13)
18000abdf:     	jne	0x18000abea <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x702a>
18000abe1:     	movq	%r13, %rcx
18000abe4:     	callq	*0x25de(%rip)           # 0x18000d1c8
18000abea:     	testq	%rdi, %rdi
18000abed:     	je	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000abf3:     	movq	0xb8(%rsp), %rsi
18000abfb:     	movq	%rdi, %r8
18000abfe:     	movq	0xb0(%rsp), %r14
18000ac06:     	movq	%r14, %rcx
18000ac09:     	movq	(%rsi), %rdx
18000ac0c:     	callq	*0x260e(%rip)           # 0x18000d220
18000ac12:     	movl	(%rdi), %ecx
18000ac14:     	testl	%eax, %eax
18000ac16:     	jne	0x18000adba <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x71fa>
18000ac1c:     	testl	%ecx, %ecx
18000ac1e:     	js	0x18000ac32 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7072>
18000ac20:     	leal	-0x1(%rcx), %eax
18000ac23:     	movl	%eax, (%rdi)
18000ac25:     	testl	%eax, %eax
18000ac27:     	jne	0x18000ac32 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7072>
18000ac29:     	movq	%rdi, %rcx
18000ac2c:     	callq	*0x2596(%rip)           # 0x18000d1c8
18000ac32:     	movq	0xc8(%rsp), %r15
18000ac3a:     	addq	$0x20, %rsi
18000ac3e:     	movq	0xc0(%rsp), %r13
18000ac46:     	incl	%ebp
18000ac48:     	movq	%rsi, 0xb8(%rsp)
18000ac50:     	cmpq	$0x0, (%rsi)
18000ac54:     	jne	0x18000aac1 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6f01>
18000ac5a:     	movq	0x20(%rsp), %r12
18000ac5f:     	movq	0x28(%rsp), %rdi
18000ac64:     	movslq	%ebp, %rax
18000ac67:     	cmpq	$0x0, (%r15,%rax,8)
18000ac6c:     	je	0x18000acd9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7119>
18000ac6e:     	nop
18000ac70:     	movslq	%ebp, %rbx
18000ac73:     	leaq	0x30(%rsp), %rdx
18000ac78:     	movq	%r14, %rcx
18000ac7b:     	leaq	(%rbx,%rbx,4), %rax
18000ac7f:     	movups	(%r13,%rax,8), %xmm0
18000ac85:     	movups	0x10(%r13,%rax,8), %xmm1
18000ac8b:     	movaps	%xmm0, 0x30(%rsp)
18000ac90:     	movsd	0x20(%r13,%rax,8), %xmm0
18000ac97:     	movsd	%xmm0, 0x50(%rsp)
18000ac9d:     	movaps	%xmm1, 0x40(%rsp)
18000aca2:     	callq	0x18000a5f0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6a30>
18000aca7:     	testq	%rax, %rax
18000acaa:     	je	0x18000add5 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7215>
18000acb0:     	movq	(%r15,%rbx,8), %rcx
18000acb4:     	movq	%rax, (%rcx)
18000acb7:     	movl	(%rax), %ecx
18000acb9:     	testl	%ecx, %ecx
18000acbb:     	js	0x18000accd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x710d>
18000acbd:     	subl	$0x1, %ecx
18000acc0:     	movl	%ecx, (%rax)
18000acc2:     	jne	0x18000accd <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x710d>
18000acc4:     	movq	%rax, %rcx
18000acc7:     	callq	*0x24fb(%rip)           # 0x18000d1c8
18000accd:     	incl	%ebp
18000accf:     	movslq	%ebp, %rax
18000acd2:     	cmpq	$0x0, (%r15,%rax,8)
18000acd7:     	jne	0x18000ac70 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x70b0>
18000acd9:     	movl	(%r12), %eax
18000acdd:     	testl	%eax, %eax
18000acdf:     	js	0x18000acf3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7133>
18000ace1:     	subl	$0x1, %eax
18000ace4:     	movl	%eax, (%r12)
18000ace8:     	jne	0x18000acf3 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7133>
18000acea:     	movq	%r12, %rcx
18000aced:     	callq	*0x24d5(%rip)           # 0x18000d1c8
18000acf3:     	movl	(%rdi), %eax
18000acf5:     	testl	%eax, %eax
18000acf7:     	js	0x18000ad09 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7149>
18000acf9:     	subl	$0x1, %eax
18000acfc:     	movl	%eax, (%rdi)
18000acfe:     	jne	0x18000ad09 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7149>
18000ad00:     	movq	%rdi, %rcx
18000ad03:     	callq	*0x24bf(%rip)           # 0x18000d1c8
18000ad09:     	xorl	%eax, %eax
18000ad0b:     	jmp	0x18000a8f9 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d39>
18000ad10:     	movl	(%r14), %eax
18000ad13:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000ad18:     	jae	0x18000ad1f <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x715f>
18000ad1a:     	incl	%eax
18000ad1c:     	movl	%eax, (%r14)
18000ad1f:     	movq	0xb0(%rsp), %rcx
18000ad27:     	leaq	0x31f2(%rip), %rdx      # 0x18000df20
18000ad2e:     	movq	%r14, 0x18(%rbx)
18000ad32:     	movq	$0x0, 0x40(%rbx)
18000ad3a:     	callq	*0x2428(%rip)           # 0x18000d168
18000ad40:     	movq	%rax, %rsi
18000ad43:     	testq	%rax, %rax
18000ad46:     	jne	0x18000ad6b <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x71ab>
18000ad48:     	movl	(%rbx), %eax
18000ad4a:     	testl	%eax, %eax
18000ad4c:     	js	0x18000abb6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff6>
18000ad52:     	subl	$0x1, %eax
18000ad55:     	movl	%eax, (%rbx)
18000ad57:     	jne	0x18000abb6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff6>
18000ad5d:     	movq	%rbx, %rcx
18000ad60:     	callq	*0x2462(%rip)           # 0x18000d1c8
18000ad66:     	jmp	0x18000abb6 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff6>
18000ad6b:     	xorl	%r9d, %r9d
18000ad6e:     	leaq	0x20(%rbx), %rcx
18000ad72:     	movq	%rsi, %r8
18000ad75:     	movq	%rbx, %rdx
18000ad78:     	callq	*0x23ca(%rip)           # 0x18000d148
18000ad7e:     	movq	%rax, %rdi
18000ad81:     	movl	(%rbx), %eax
18000ad83:     	testl	%eax, %eax
18000ad85:     	js	0x18000ad97 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x71d7>
18000ad87:     	subl	$0x1, %eax
18000ad8a:     	movl	%eax, (%rbx)
18000ad8c:     	jne	0x18000ad97 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x71d7>
18000ad8e:     	movq	%rbx, %rcx
18000ad91:     	callq	*0x2431(%rip)           # 0x18000d1c8
18000ad97:     	movl	(%rsi), %eax
18000ad99:     	testl	%eax, %eax
18000ad9b:     	js	0x18000abb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff8>
18000ada1:     	subl	$0x1, %eax
18000ada4:     	movl	%eax, (%rsi)
18000ada6:     	jne	0x18000abb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff8>
18000adac:     	movq	%rsi, %rcx
18000adaf:     	callq	*0x2413(%rip)           # 0x18000d1c8
18000adb5:     	jmp	0x18000abb8 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6ff8>
18000adba:     	testl	%ecx, %ecx
18000adbc:     	js	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000adbe:     	leal	-0x1(%rcx), %eax
18000adc1:     	movl	%eax, (%rdi)
18000adc3:     	testl	%eax, %eax
18000adc5:     	jne	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000adc7:     	movq	%rdi, %rcx
18000adca:     	callq	*0x23f8(%rip)           # 0x18000d1c8
18000add0:     	movq	0x20(%rsp), %r12
18000add5:     	movl	(%r12), %eax
18000add9:     	testl	%eax, %eax
18000addb:     	js	0x18000adef <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x722f>
18000addd:     	subl	$0x1, %eax
18000ade0:     	movl	%eax, (%r12)
18000ade4:     	jne	0x18000adef <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x722f>
18000ade6:     	movq	%r12, %rcx
18000ade9:     	callq	*0x23d9(%rip)           # 0x18000d1c8
18000adef:     	movq	0x28(%rsp), %rdi
18000adf4:     	movl	(%rdi), %eax
18000adf6:     	testl	%eax, %eax
18000adf8:     	js	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000adfe:     	subl	$0x1, %eax
18000ae01:     	movl	%eax, (%rdi)
18000ae03:     	jne	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000ae09:     	movq	%rdi, %rcx
18000ae0c:     	callq	*0x23b6(%rip)           # 0x18000d1c8
18000ae12:     	jmp	0x18000a8f4 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x6d34>
18000ae17:     	movl	(%r14), %eax
18000ae1a:     	testl	%eax, %eax
18000ae1c:     	js	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000ae1e:     	subl	$0x1, %eax
18000ae21:     	movl	%eax, (%r14)
18000ae24:     	jne	0x18000add0 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7210>
18000ae26:     	movq	%r14, %rcx
18000ae29:     	jmp	0x18000adca <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x720a>
18000ae2b:     	int3
18000ae2c:     	int3
18000ae2d:     	int3
18000ae2e:     	int3
18000ae2f:     	int3
18000ae30:     	leaq	0x9ea9(%rip), %rax      # 0x180014ce0
18000ae37:     	retq
18000ae38:     	int3
18000ae39:     	int3
18000ae3a:     	int3
18000ae3b:     	int3
18000ae3c:     	int3
18000ae3d:     	int3
18000ae3e:     	int3
18000ae3f:     	int3

000000018000ae40 <numba_list_set_method_table>:
18000ae40:     	movups	(%rdx), %xmm0
18000ae43:     	movups	%xmm0, 0x20(%rcx)
18000ae47:     	retq
18000ae48:     	int3
18000ae49:     	int3
18000ae4a:     	int3
18000ae4b:     	int3
18000ae4c:     	int3
18000ae4d:     	int3
18000ae4e:     	int3
18000ae4f:     	int3

000000018000ae50 <numba_list_new>:
18000ae50:     	pushq	%rbx
18000ae52:     	pushq	%rbp
18000ae53:     	pushq	%rsi
18000ae54:     	pushq	%rdi
18000ae55:     	subq	$0x28, %rsp
18000ae59:     	movq	%rcx, %rsi
18000ae5c:     	movq	%r8, %rdi
18000ae5f:     	movl	$0x38, %ecx
18000ae64:     	movq	%rdx, %rbp
18000ae67:     	callq	*0x21f3(%rip)           # 0x18000d060
18000ae6d:     	movq	%rax, %rbx
18000ae70:     	testq	%rax, %rax
18000ae73:     	je	0x18000aedd <numba_list_new+0x8d>
18000ae75:     	movq	$0x0, (%rax)
18000ae7c:     	xorps	%xmm0, %xmm0
18000ae7f:     	movq	%rbp, 0x8(%rax)
18000ae83:     	movq	%rdi, 0x10(%rax)
18000ae87:     	movl	$0x1, 0x18(%rax)
18000ae8e:     	movups	%xmm0, 0x20(%rax)
18000ae92:     	testq	%rdi, %rdi
18000ae95:     	je	0x18000aeeb <numba_list_new+0x9b>
18000ae97:     	imulq	%rbp, %rdi
18000ae9b:     	movl	$0x8, %ecx
18000aea0:     	movq	%rdi, %rax
18000aea3:     	cqto
18000aea5:     	andl	$0x7, %edx
18000aea8:     	addq	%rdx, %rax
18000aeab:     	andl	$0x7, %eax
18000aeae:     	subq	%rdx, %rax
18000aeb1:     	subq	%rax, %rcx
18000aeb4:     	movq	%rcx, %rax
18000aeb7:     	cqto
18000aeb9:     	andl	$0x7, %edx
18000aebc:     	leaq	(%rdx,%rax), %rcx
18000aec0:     	andl	$0x7, %ecx
18000aec3:     	subq	%rdx, %rcx
18000aec6:     	addq	%rdi, %rcx
18000aec9:     	callq	*0x2191(%rip)           # 0x18000d060
18000aecf:     	testq	%rax, %rax
18000aed2:     	jne	0x18000aeed <numba_list_new+0x9d>
18000aed4:     	movq	%rbx, %rcx
18000aed7:     	callq	*0x218b(%rip)           # 0x18000d068
18000aedd:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000aee2:     	addq	$0x28, %rsp
18000aee6:     	popq	%rdi
18000aee7:     	popq	%rsi
18000aee8:     	popq	%rbp
18000aee9:     	popq	%rbx
18000aeea:     	retq
18000aeeb:     	xorl	%eax, %eax
18000aeed:     	movq	%rax, 0x30(%rbx)
18000aef1:     	xorl	%eax, %eax
18000aef3:     	movq	%rbx, (%rsi)
18000aef6:     	addq	$0x28, %rsp
18000aefa:     	popq	%rdi
18000aefb:     	popq	%rsi
18000aefc:     	popq	%rbp
18000aefd:     	popq	%rbx
18000aefe:     	retq
18000aeff:     	int3

000000018000af00 <numba_list_free>:
18000af00:     	pushq	%rbx
18000af02:     	subq	$0x20, %rsp
18000af06:     	cmpq	$0x0, 0x28(%rcx)
18000af0b:     	movq	%rcx, %rbx
18000af0e:     	je	0x18000af44 <numba_list_free+0x44>
18000af10:     	movq	%rdi, 0x30(%rsp)
18000af15:     	xorl	%edi, %edi
18000af17:     	cmpq	%rdi, (%rcx)
18000af1a:     	jle	0x18000af3f <numba_list_free+0x3f>
18000af1c:     	nopl	(%rax)
18000af20:     	movq	0x28(%rbx), %rax
18000af24:     	testq	%rax, %rax
18000af27:     	je	0x18000af37 <numba_list_free+0x37>
18000af29:     	movq	%rdi, %rcx
18000af2c:     	imulq	0x8(%rbx), %rcx
18000af31:     	addq	0x30(%rbx), %rcx
18000af35:     	callq	*%rax
18000af37:     	incq	%rdi
18000af3a:     	cmpq	(%rbx), %rdi
18000af3d:     	jl	0x18000af20 <numba_list_free+0x20>
18000af3f:     	movq	0x30(%rsp), %rdi
18000af44:     	movq	0x30(%rbx), %rcx
18000af48:     	testq	%rcx, %rcx
18000af4b:     	je	0x18000af53 <numba_list_free+0x53>
18000af4d:     	callq	*0x2115(%rip)           # 0x18000d068
18000af53:     	movq	%rbx, %rcx
18000af56:     	addq	$0x20, %rsp
18000af5a:     	popq	%rbx
18000af5b:     	jmpq	*0x2106(%rip)           # 0x18000d068
18000af62:     	int3
18000af63:     	int3
18000af64:     	int3
18000af65:     	int3
18000af66:     	int3
18000af67:     	int3
18000af68:     	int3
18000af69:     	int3
18000af6a:     	int3
18000af6b:     	int3
18000af6c:     	int3
18000af6d:     	int3
18000af6e:     	int3
18000af6f:     	int3

000000018000af70 <numba_list_base_ptr>:
18000af70:     	movq	0x30(%rcx), %rax
18000af74:     	retq
18000af75:     	int3
18000af76:     	int3
18000af77:     	int3
18000af78:     	int3
18000af79:     	int3
18000af7a:     	int3
18000af7b:     	int3
18000af7c:     	int3
18000af7d:     	int3
18000af7e:     	int3
18000af7f:     	int3

000000018000af80 <numba_list_size_address>:
18000af80:     	movq	%rcx, %rax
18000af83:     	retq
18000af84:     	int3
18000af85:     	int3
18000af86:     	int3
18000af87:     	int3
18000af88:     	int3
18000af89:     	int3
18000af8a:     	int3
18000af8b:     	int3
18000af8c:     	int3
18000af8d:     	int3
18000af8e:     	int3
18000af8f:     	int3

000000018000af90 <numba_list_length>:
18000af90:     	movq	(%rcx), %rax
18000af93:     	retq
18000af94:     	int3
18000af95:     	int3
18000af96:     	int3
18000af97:     	int3
18000af98:     	int3
18000af99:     	int3
18000af9a:     	int3
18000af9b:     	int3
18000af9c:     	int3
18000af9d:     	int3
18000af9e:     	int3
18000af9f:     	int3

000000018000afa0 <numba_list_allocated>:
18000afa0:     	movq	0x10(%rcx), %rax
18000afa4:     	retq
18000afa5:     	int3
18000afa6:     	int3
18000afa7:     	int3
18000afa8:     	int3
18000afa9:     	int3
18000afaa:     	int3
18000afab:     	int3
18000afac:     	int3
18000afad:     	int3
18000afae:     	int3
18000afaf:     	int3

000000018000afb0 <numba_list_is_mutable>:
18000afb0:     	movl	0x18(%rcx), %eax
18000afb3:     	retq
18000afb4:     	int3
18000afb5:     	int3
18000afb6:     	int3
18000afb7:     	int3
18000afb8:     	int3
18000afb9:     	int3
18000afba:     	int3
18000afbb:     	int3
18000afbc:     	int3
18000afbd:     	int3
18000afbe:     	int3
18000afbf:     	int3

000000018000afc0 <numba_list_set_is_mutable>:
18000afc0:     	movl	%edx, 0x18(%rcx)
18000afc3:     	retq
18000afc4:     	int3
18000afc5:     	int3
18000afc6:     	int3
18000afc7:     	int3
18000afc8:     	int3
18000afc9:     	int3
18000afca:     	int3
18000afcb:     	int3
18000afcc:     	int3
18000afcd:     	int3
18000afce:     	int3
18000afcf:     	int3

000000018000afd0 <numba_list_setitem>:
18000afd0:     	movq	%rbx, 0x10(%rsp)
18000afd5:     	pushq	%rsi
18000afd6:     	subq	$0x20, %rsp
18000afda:     	cmpl	$0x0, 0x18(%rcx)
18000afde:     	movq	%r8, %rsi
18000afe1:     	movq	%rcx, %rbx
18000afe4:     	jne	0x18000aff6 <numba_list_setitem+0x26>
18000afe6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000afeb:     	movq	0x38(%rsp), %rbx
18000aff0:     	addq	$0x20, %rsp
18000aff4:     	popq	%rsi
18000aff5:     	retq
18000aff6:     	cmpq	(%rcx), %rdx
18000aff9:     	jb	0x18000b00b <numba_list_setitem+0x3b>
18000affb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b000:     	movq	0x38(%rsp), %rbx
18000b005:     	addq	$0x20, %rsp
18000b009:     	popq	%rsi
18000b00a:     	retq
18000b00b:     	imulq	0x8(%rcx), %rdx
18000b010:     	movq	0x28(%rcx), %rax
18000b014:     	movq	%rdi, 0x30(%rsp)
18000b019:     	movq	0x30(%rcx), %rdi
18000b01d:     	addq	%rdx, %rdi
18000b020:     	testq	%rax, %rax
18000b023:     	je	0x18000b02a <numba_list_setitem+0x5a>
18000b025:     	movq	%rdi, %rcx
18000b028:     	callq	*%rax
18000b02a:     	movq	0x8(%rbx), %r8
18000b02e:     	movq	%rsi, %rdx
18000b031:     	movq	%rdi, %rcx
18000b034:     	callq	0x18000c3e3 <numba_list_iter_next+0xec3>
18000b039:     	movq	0x20(%rbx), %rax
18000b03d:     	testq	%rax, %rax
18000b040:     	je	0x18000b047 <numba_list_setitem+0x77>
18000b042:     	movq	%rdi, %rcx
18000b045:     	callq	*%rax
18000b047:     	movq	0x30(%rsp), %rdi
18000b04c:     	xorl	%eax, %eax
18000b04e:     	movq	0x38(%rsp), %rbx
18000b053:     	addq	$0x20, %rsp
18000b057:     	popq	%rsi
18000b058:     	retq
18000b059:     	int3
18000b05a:     	int3
18000b05b:     	int3
18000b05c:     	int3
18000b05d:     	int3
18000b05e:     	int3
18000b05f:     	int3

000000018000b060 <numba_list_getitem>:
18000b060:     	subq	$0x28, %rsp
18000b064:     	movq	%r8, %r9
18000b067:     	movq	%rdx, %rax
18000b06a:     	cmpq	(%rcx), %rdx
18000b06d:     	jb	0x18000b079 <numba_list_getitem+0x19>
18000b06f:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b074:     	addq	$0x28, %rsp
18000b078:     	retq
18000b079:     	movq	0x8(%rcx), %r8
18000b07d:     	movq	%r8, %rdx
18000b080:     	imulq	%rax, %rdx
18000b084:     	addq	0x30(%rcx), %rdx
18000b088:     	movq	%r9, %rcx
18000b08b:     	callq	0x18000c3e3 <numba_list_iter_next+0xec3>
18000b090:     	xorl	%eax, %eax
18000b092:     	addq	$0x28, %rsp
18000b096:     	retq
18000b097:     	int3
18000b098:     	int3
18000b099:     	int3
18000b09a:     	int3
18000b09b:     	int3
18000b09c:     	int3
18000b09d:     	int3
18000b09e:     	int3
18000b09f:     	int3

000000018000b0a0 <numba_list_append>:
18000b0a0:     	movq	%rbx, 0x10(%rsp)
18000b0a5:     	pushq	%rsi
18000b0a6:     	subq	$0x20, %rsp
18000b0aa:     	cmpl	$0x0, 0x18(%rcx)
18000b0ae:     	movq	%rdx, %rsi
18000b0b1:     	movq	%rcx, %rbx
18000b0b4:     	jne	0x18000b0c6 <numba_list_append+0x26>
18000b0b6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b0bb:     	movq	0x38(%rsp), %rbx
18000b0c0:     	addq	$0x20, %rsp
18000b0c4:     	popq	%rsi
18000b0c5:     	retq
18000b0c6:     	movq	(%rcx), %rdx
18000b0c9:     	incq	%rdx
18000b0cc:     	callq	0x18000b120 <numba_list_resize>
18000b0d1:     	testl	%eax, %eax
18000b0d3:     	js	0x18000b10c <numba_list_append+0x6c>
18000b0d5:     	movq	0x8(%rbx), %r8
18000b0d9:     	movq	%rsi, %rdx
18000b0dc:     	movq	%rdi, 0x30(%rsp)
18000b0e1:     	movq	(%rbx), %rdi
18000b0e4:     	decq	%rdi
18000b0e7:     	imulq	%r8, %rdi
18000b0eb:     	addq	0x30(%rbx), %rdi
18000b0ef:     	movq	%rdi, %rcx
18000b0f2:     	callq	0x18000c3e3 <numba_list_iter_next+0xec3>
18000b0f7:     	movq	0x20(%rbx), %rax
18000b0fb:     	testq	%rax, %rax
18000b0fe:     	je	0x18000b105 <numba_list_append+0x65>
18000b100:     	movq	%rdi, %rcx
18000b103:     	callq	*%rax
18000b105:     	movq	0x30(%rsp), %rdi
18000b10a:     	xorl	%eax, %eax
18000b10c:     	movq	0x38(%rsp), %rbx
18000b111:     	addq	$0x20, %rsp
18000b115:     	popq	%rsi
18000b116:     	retq
18000b117:     	int3
18000b118:     	int3
18000b119:     	int3
18000b11a:     	int3
18000b11b:     	int3
18000b11c:     	int3
18000b11d:     	int3
18000b11e:     	int3
18000b11f:     	int3

000000018000b120 <numba_list_resize>:
18000b120:     	movq	%rsi, 0x18(%rsp)
18000b125:     	pushq	%rdi
18000b126:     	subq	$0x20, %rsp
18000b12a:     	cmpl	$0x0, 0x18(%rcx)
18000b12e:     	movq	%rdx, %rsi
18000b131:     	movq	%rcx, %rdi
18000b134:     	jne	0x18000b146 <numba_list_resize+0x26>
18000b136:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b13b:     	movq	0x40(%rsp), %rsi
18000b140:     	addq	$0x20, %rsp
18000b144:     	popq	%rdi
18000b145:     	retq
18000b146:     	movq	0x10(%rcx), %rax
18000b14a:     	cmpq	%rsi, %rax
18000b14d:     	jl	0x18000b167 <numba_list_resize+0x47>
18000b14f:     	sarq	%rax
18000b152:     	cmpq	%rax, %rsi
18000b155:     	jl	0x18000b167 <numba_list_resize+0x47>
18000b157:     	movq	%rsi, (%rcx)
18000b15a:     	xorl	%eax, %eax
18000b15c:     	movq	0x40(%rsp), %rsi
18000b161:     	addq	$0x20, %rsp
18000b165:     	popq	%rdi
18000b166:     	retq
18000b167:     	cmpq	$0x9, %rsi
18000b16b:     	movq	%rbp, 0x38(%rsp)
18000b170:     	movl	$0x3, %ecx
18000b175:     	movl	$0x6, %eax
18000b17a:     	cmovll	%ecx, %eax
18000b17d:     	movq	%rsi, %r8
18000b180:     	movq	0x8(%rdi), %rcx
18000b184:     	addq	%rsi, %rax
18000b187:     	sarq	$0x3, %r8
18000b18b:     	xorl	%edx, %edx
18000b18d:     	addq	%rax, %r8
18000b190:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000b19a:     	divq	%rcx
18000b19d:     	cmpq	%rax, %r8
18000b1a0:     	ja	0x18000b21b <numba_list_resize+0xfb>
18000b1a2:     	xorl	%ebp, %ebp
18000b1a4:     	movq	%rbx, 0x30(%rsp)
18000b1a9:     	testq	%rsi, %rsi
18000b1ac:     	cmovneq	%r8, %rbp
18000b1b0:     	movq	%rbp, %rbx
18000b1b3:     	imulq	%rcx, %rbx
18000b1b7:     	movl	$0x8, %ecx
18000b1bc:     	movq	%rbx, %rax
18000b1bf:     	cqto
18000b1c1:     	andl	$0x7, %edx
18000b1c4:     	addq	%rdx, %rax
18000b1c7:     	andl	$0x7, %eax
18000b1ca:     	subq	%rdx, %rax
18000b1cd:     	subq	%rax, %rcx
18000b1d0:     	movq	%rcx, %rax
18000b1d3:     	movq	0x30(%rdi), %rcx
18000b1d7:     	cqto
18000b1d9:     	andl	$0x7, %edx
18000b1dc:     	addq	%rdx, %rax
18000b1df:     	andl	$0x7, %eax
18000b1e2:     	subq	%rdx, %rax
18000b1e5:     	leaq	(%rbx,%rax), %rdx
18000b1e9:     	callq	*0x1e81(%rip)           # 0x18000d070
18000b1ef:     	testq	%rbx, %rbx
18000b1f2:     	movq	0x30(%rsp), %rbx
18000b1f7:     	je	0x18000b1fe <numba_list_resize+0xde>
18000b1f9:     	testq	%rax, %rax
18000b1fc:     	je	0x18000b21b <numba_list_resize+0xfb>
18000b1fe:     	movq	%rax, 0x30(%rdi)
18000b202:     	xorl	%eax, %eax
18000b204:     	movq	%rbp, 0x10(%rdi)
18000b208:     	movq	0x38(%rsp), %rbp
18000b20d:     	movq	%rsi, (%rdi)
18000b210:     	movq	0x40(%rsp), %rsi
18000b215:     	addq	$0x20, %rsp
18000b219:     	popq	%rdi
18000b21a:     	retq
18000b21b:     	movq	0x38(%rsp), %rbp
18000b220:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000b225:     	movq	0x40(%rsp), %rsi
18000b22a:     	addq	$0x20, %rsp
18000b22e:     	popq	%rdi
18000b22f:     	retq

000000018000b230 <numba_list_delitem>:
18000b230:     	movq	%rbx, 0x10(%rsp)
18000b235:     	pushq	%rdi
18000b236:     	subq	$0x20, %rsp
18000b23a:     	cmpl	$0x0, 0x18(%rcx)
18000b23e:     	movq	%rdx, %rdi
18000b241:     	movq	%rcx, %rbx
18000b244:     	jne	0x18000b256 <numba_list_delitem+0x26>
18000b246:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b24b:     	movq	0x38(%rsp), %rbx
18000b250:     	addq	$0x20, %rsp
18000b254:     	popq	%rdi
18000b255:     	retq
18000b256:     	cmpq	(%rcx), %rdi
18000b259:     	jb	0x18000b26b <numba_list_delitem+0x3b>
18000b25b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b260:     	movq	0x38(%rsp), %rbx
18000b265:     	addq	$0x20, %rsp
18000b269:     	popq	%rdi
18000b26a:     	retq
18000b26b:     	movq	0x28(%rcx), %rax
18000b26f:     	movq	%rsi, 0x30(%rsp)
18000b274:     	movq	%rdi, %rsi
18000b277:     	imulq	0x8(%rcx), %rsi
18000b27c:     	addq	0x30(%rcx), %rsi
18000b280:     	testq	%rax, %rax
18000b283:     	je	0x18000b28a <numba_list_delitem+0x5a>
18000b285:     	movq	%rsi, %rcx
18000b288:     	callq	*%rax
18000b28a:     	movq	(%rbx), %r8
18000b28d:     	leaq	-0x1(%r8), %rax
18000b291:     	cmpq	%rax, %rdi
18000b294:     	je	0x18000b2b6 <numba_list_delitem+0x86>
18000b296:     	subq	%rdi, %r8
18000b299:     	leaq	0x1(%rdi), %rdx
18000b29d:     	imulq	0x8(%rbx), %rdx
18000b2a2:     	decq	%r8
18000b2a5:     	movq	%rsi, %rcx
18000b2a8:     	imulq	0x8(%rbx), %r8
18000b2ad:     	addq	0x30(%rbx), %rdx
18000b2b1:     	callq	0x18000c3e9 <numba_list_iter_next+0xec9>
18000b2b6:     	movq	(%rbx), %rdx
18000b2b9:     	movq	%rbx, %rcx
18000b2bc:     	decq	%rdx
18000b2bf:     	callq	0x18000b120 <numba_list_resize>
18000b2c4:     	movq	0x30(%rsp), %rsi
18000b2c9:     	xorl	%ecx, %ecx
18000b2cb:     	movq	0x38(%rsp), %rbx
18000b2d0:     	testl	%eax, %eax
18000b2d2:     	cmovsl	%eax, %ecx
18000b2d5:     	movl	%ecx, %eax
18000b2d7:     	addq	$0x20, %rsp
18000b2db:     	popq	%rdi
18000b2dc:     	retq
18000b2dd:     	int3
18000b2de:     	int3
18000b2df:     	int3

000000018000b2e0 <numba_list_delete_slice>:
18000b2e0:     	pushq	%rbx
18000b2e2:     	pushq	%rbp
18000b2e3:     	pushq	%rdi
18000b2e4:     	pushq	%r15
18000b2e6:     	subq	$0x38, %rsp
18000b2ea:     	cmpl	$0x0, 0x18(%rcx)
18000b2ee:     	movq	%r9, %rdi
18000b2f1:     	movq	%r8, %rbp
18000b2f4:     	movq	%rdx, %r15
18000b2f7:     	movq	%rcx, %rbx
18000b2fa:     	jne	0x18000b30b <numba_list_delete_slice+0x2b>
18000b2fc:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b301:     	addq	$0x38, %rsp
18000b305:     	popq	%r15
18000b307:     	popq	%rdi
18000b308:     	popq	%rbp
18000b309:     	popq	%rbx
18000b30a:     	retq
18000b30b:     	movq	%r13, 0x78(%rsp)
18000b310:     	testq	%rdi, %rdi
18000b313:     	jle	0x18000b332 <numba_list_delete_slice+0x52>
18000b315:     	cmpq	%r8, %r15
18000b318:     	jge	0x18000b4d1 <numba_list_delete_slice+0x1f1>
18000b31e:     	movq	%r8, %rax
18000b321:     	subq	%r15, %rax
18000b324:     	decq	%rax
18000b327:     	cqto
18000b329:     	idivq	%rdi
18000b32c:     	leal	0x1(%rax), %r13d
18000b330:     	jmp	0x18000b352 <numba_list_delete_slice+0x72>
18000b332:     	cmpq	%r15, %r8
18000b335:     	jge	0x18000b4d1 <numba_list_delete_slice+0x1f1>
18000b33b:     	movq	%r15, %rax
18000b33e:     	movl	$0x1, %r13d
18000b344:     	subq	%r8, %rax
18000b347:     	decq	%rax
18000b34a:     	cqto
18000b34c:     	idivq	%rdi
18000b34f:     	subl	%eax, %r13d
18000b352:     	testl	%r13d, %r13d
18000b355:     	jle	0x18000b4d1 <numba_list_delete_slice+0x1f1>
18000b35b:     	movq	%rsi, 0x68(%rsp)
18000b360:     	movl	(%rcx), %esi
18000b362:     	subl	%r13d, %esi
18000b365:     	movl	%esi, 0x20(%rsp)
18000b369:     	testq	%rdi, %rdi
18000b36c:     	jns	0x18000b387 <numba_list_delete_slice+0xa7>
18000b36e:     	leaq	0x1(%r15), %rbp
18000b372:     	leal	-0x1(%r13), %eax
18000b376:     	movslq	%eax, %rcx
18000b379:     	leaq	-0x1(%rbp), %r15
18000b37d:     	imulq	%rdi, %rcx
18000b381:     	addq	%rcx, %r15
18000b384:     	negq	%rdi
18000b387:     	cmpq	$0x1, %rdi
18000b38b:     	jne	0x18000b3d7 <numba_list_delete_slice+0xf7>
18000b38d:     	cmpq	$0x0, 0x28(%rbx)
18000b392:     	je	0x18000b3b9 <numba_list_delete_slice+0xd9>
18000b394:     	movslq	%r15d, %rdi
18000b397:     	cmpq	%rbp, %rdi
18000b39a:     	jge	0x18000b3b9 <numba_list_delete_slice+0xd9>
18000b39c:     	nopl	(%rax)
18000b3a0:     	movslq	%edi, %rcx
18000b3a3:     	imulq	0x8(%rbx), %rcx
18000b3a8:     	addq	0x30(%rbx), %rcx
18000b3ac:     	callq	*0x28(%rbx)
18000b3af:     	incl	%edi
18000b3b1:     	movslq	%edi, %rax
18000b3b4:     	cmpq	%rbp, %rax
18000b3b7:     	jl	0x18000b3a0 <numba_list_delete_slice+0xc0>
18000b3b9:     	movq	0x8(%rbx), %rcx
18000b3bd:     	movq	(%rbx), %r8
18000b3c0:     	movq	%rcx, %rdx
18000b3c3:     	subq	%rbp, %r8
18000b3c6:     	imulq	%rcx, %r8
18000b3ca:     	imulq	%rbp, %rdx
18000b3ce:     	imulq	%r15, %rcx
18000b3d2:     	jmp	0x18000b49c <numba_list_delete_slice+0x1bc>
18000b3d7:     	movq	%r14, 0x30(%rsp)
18000b3dc:     	movq	%r15, %r14
18000b3df:     	movl	$0x0, 0x60(%rsp)
18000b3e7:     	cmpq	%rbp, %r15
18000b3ea:     	jge	0x18000b469 <numba_list_delete_slice+0x189>
18000b3ec:     	movq	%r12, 0x70(%rsp)
18000b3f1:     	movq	(%rbx), %rax
18000b3f4:     	leaq	(%r14,%rdi), %r12
18000b3f8:     	cmpq	%rax, %r12
18000b3fb:     	jl	0x18000b408 <numba_list_delete_slice+0x128>
18000b3fd:     	movq	%r14, %rsi
18000b400:     	notq	%rsi
18000b403:     	addq	%rax, %rsi
18000b406:     	jmp	0x18000b40c <numba_list_delete_slice+0x12c>
18000b408:     	leaq	-0x1(%rdi), %rsi
18000b40c:     	movq	0x28(%rbx), %rax
18000b410:     	testq	%rax, %rax
18000b413:     	je	0x18000b423 <numba_list_delete_slice+0x143>
18000b415:     	movq	%r14, %rcx
18000b418:     	imulq	0x8(%rbx), %rcx
18000b41d:     	addq	0x30(%rbx), %rcx
18000b421:     	callq	*%rax
18000b423:     	movq	0x8(%rbx), %r9
18000b427:     	leaq	0x1(%r14), %rdx
18000b42b:     	movq	0x30(%rbx), %r10
18000b42f:     	movq	%r9, %r8
18000b432:     	imulq	%rsi, %r8
18000b436:     	imulq	%r9, %rdx
18000b43a:     	movslq	0x60(%rsp), %rsi
18000b43f:     	subq	%rsi, %r14
18000b442:     	imulq	%r9, %r14
18000b446:     	addq	%r10, %rdx
18000b449:     	leaq	(%r10,%r14), %rcx
18000b44d:     	callq	0x18000c3e9 <numba_list_iter_next+0xec9>
18000b452:     	incl	%esi
18000b454:     	movq	%r12, %r14
18000b457:     	movl	%esi, 0x60(%rsp)
18000b45b:     	cmpq	%rbp, %r12
18000b45e:     	jl	0x18000b3f1 <numba_list_delete_slice+0x111>
18000b460:     	movq	0x70(%rsp), %r12
18000b465:     	movl	0x20(%rsp), %esi
18000b469:     	movq	(%rbx), %r8
18000b46c:     	movq	0x30(%rsp), %r14
18000b471:     	movslq	%r13d, %r10
18000b474:     	movq	%r10, %rcx
18000b477:     	imulq	%rdi, %rcx
18000b47b:     	addq	%r15, %rcx
18000b47e:     	cmpq	%r8, %rcx
18000b481:     	jge	0x18000b4a9 <numba_list_delete_slice+0x1c9>
18000b483:     	movq	0x8(%rbx), %rax
18000b487:     	subq	%rcx, %r8
18000b48a:     	movq	%rax, %rdx
18000b48d:     	imulq	%rcx, %rdx
18000b491:     	imulq	%rax, %r8
18000b495:     	subq	%r10, %rcx
18000b498:     	imulq	%rax, %rcx
18000b49c:     	addq	0x30(%rbx), %rdx
18000b4a0:     	addq	0x30(%rbx), %rcx
18000b4a4:     	callq	0x18000c3e9 <numba_list_iter_next+0xec9>
18000b4a9:     	movslq	%esi, %rdx
18000b4ac:     	movq	%rbx, %rcx
18000b4af:     	callq	0x18000b120 <numba_list_resize>
18000b4b4:     	movq	0x68(%rsp), %rsi
18000b4b9:     	xorl	%ecx, %ecx
18000b4bb:     	movq	0x78(%rsp), %r13
18000b4c0:     	testl	%eax, %eax
18000b4c2:     	cmovsl	%eax, %ecx
18000b4c5:     	movl	%ecx, %eax
18000b4c7:     	addq	$0x38, %rsp
18000b4cb:     	popq	%r15
18000b4cd:     	popq	%rdi
18000b4ce:     	popq	%rbp
18000b4cf:     	popq	%rbx
18000b4d0:     	retq
18000b4d1:     	movq	0x78(%rsp), %r13
18000b4d6:     	xorl	%eax, %eax
18000b4d8:     	addq	$0x38, %rsp
18000b4dc:     	popq	%r15
18000b4de:     	popq	%rdi
18000b4df:     	popq	%rbp
18000b4e0:     	popq	%rbx
18000b4e1:     	retq
18000b4e2:     	int3
18000b4e3:     	int3
18000b4e4:     	int3
18000b4e5:     	int3
18000b4e6:     	int3
18000b4e7:     	int3
18000b4e8:     	int3
18000b4e9:     	int3
18000b4ea:     	int3
18000b4eb:     	int3
18000b4ec:     	int3
18000b4ed:     	int3
18000b4ee:     	int3
18000b4ef:     	int3

000000018000b4f0 <numba_list_iter_sizeof>:
18000b4f0:     	movl	$0x18, %eax
18000b4f5:     	retq
18000b4f6:     	int3
18000b4f7:     	int3
18000b4f8:     	int3
18000b4f9:     	int3
18000b4fa:     	int3
18000b4fb:     	int3
18000b4fc:     	int3
18000b4fd:     	int3
18000b4fe:     	int3
18000b4ff:     	int3

000000018000b500 <numba_list_iter>:
18000b500:     	movq	%rdx, (%rcx)
18000b503:     	movq	(%rdx), %rax
18000b506:     	movq	%rax, 0x8(%rcx)
18000b50a:     	movq	$0x0, 0x10(%rcx)
18000b512:     	retq
18000b513:     	int3
18000b514:     	int3
18000b515:     	int3
18000b516:     	int3
18000b517:     	int3
18000b518:     	int3
18000b519:     	int3
18000b51a:     	int3
18000b51b:     	int3
18000b51c:     	int3
18000b51d:     	int3
18000b51e:     	int3
18000b51f:     	int3

000000018000b520 <numba_list_iter_next>:
18000b520:     	movq	(%rcx), %r8
18000b523:     	movq	(%r8), %r9
18000b526:     	cmpq	0x8(%rcx), %r9
18000b52a:     	je	0x18000b532 <numba_list_iter_next+0x12>
18000b52c:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
18000b531:     	retq
18000b532:     	movq	0x10(%rcx), %rax
18000b536:     	cmpq	%r9, %rax
18000b539:     	jge	0x18000b54e <numba_list_iter_next+0x2e>
18000b53b:     	imulq	0x8(%r8), %rax
18000b540:     	addq	0x30(%r8), %rax
18000b544:     	movq	%rax, (%rdx)
18000b547:     	incq	0x10(%rcx)
18000b54b:     	xorl	%eax, %eax
18000b54d:     	retq
18000b54e:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
18000b553:     	retq
18000b554:     	int3
18000b555:     	int3
18000b556:     	int3
18000b557:     	int3
18000b558:     	int3
18000b559:     	int3
18000b55a:     	int3
18000b55b:     	int3
18000b55c:     	int3
18000b55d:     	int3
18000b55e:     	int3
18000b55f:     	int3
18000b560:     	pushq	%rbx
18000b562:     	subq	$0x20, %rsp
18000b566:     	movq	%rcx, %rbx
18000b569:     	addq	$0x30, %rcx
18000b56d:     	callq	*0x96f5(%rip)           # 0x180014c68
18000b573:     	cmpb	$0x0, 0x96c6(%rip)      # 0x180014c40
18000b57a:     	je	0x18000b584 <numba_list_iter_next+0x64>
18000b57c:     	lock
18000b57d:     	incq	0x96c4(%rip)            # 0x180014c48
18000b584:     	testq	%rax, %rax
18000b587:     	je	0x18000b5c8 <numba_list_iter_next+0xa8>
18000b589:     	leaq	0x30(%rax), %rdx
18000b58d:     	testq	%rdx, %rdx
18000b590:     	je	0x18000b5c8 <numba_list_iter_next+0xa8>
18000b592:     	xorl	%r8d, %r8d
18000b595:     	movl	$0x1, %ecx
18000b59a:     	xchgq	%rcx, (%rax)
18000b59d:     	movq	%r8, 0x8(%rax)
18000b5a1:     	movq	%r8, 0x10(%rax)
18000b5a5:     	movq	%rdx, 0x18(%rax)
18000b5a9:     	movq	%rbx, 0x20(%rax)
18000b5ad:     	movq	%r8, 0x28(%rax)
18000b5b1:     	cmpb	%r8b, 0x9688(%rip)      # 0x180014c40
18000b5b8:     	je	0x18000b5ca <numba_list_iter_next+0xaa>
18000b5ba:     	lock
18000b5bb:     	incq	0x9696(%rip)            # 0x180014c58
18000b5c2:     	addq	$0x20, %rsp
18000b5c6:     	popq	%rbx
18000b5c7:     	retq
18000b5c8:     	xorl	%eax, %eax
18000b5ca:     	addq	$0x20, %rsp
18000b5ce:     	popq	%rbx
18000b5cf:     	retq
18000b5d0:     	movq	%rbx, 0x8(%rsp)
18000b5d5:     	pushq	%rdi
18000b5d6:     	subq	$0x20, %rsp
18000b5da:     	movq	%rcx, %rdi
18000b5dd:     	movq	%rdx, %rbx
18000b5e0:     	addq	$0x30, %rcx
18000b5e4:     	testq	%rdx, %rdx
18000b5e7:     	je	0x18000b5f1 <numba_list_iter_next+0xd1>
18000b5e9:     	movq	0x18(%rdx), %rdx
18000b5ed:     	callq	*(%rbx)
18000b5ef:     	jmp	0x18000b5f7 <numba_list_iter_next+0xd7>
18000b5f1:     	callq	*0x9671(%rip)           # 0x180014c68
18000b5f7:     	cmpb	$0x0, 0x9642(%rip)      # 0x180014c40
18000b5fe:     	movq	%rax, %r8
18000b601:     	je	0x18000b60b <numba_list_iter_next+0xeb>
18000b603:     	lock
18000b604:     	incq	0x963d(%rip)            # 0x180014c48
18000b60b:     	xorl	%edx, %edx
18000b60d:     	leaq	0x30(%r8), %rax
18000b611:     	testq	%r8, %r8
18000b614:     	movl	%edx, %ecx
18000b616:     	cmovneq	%rax, %rcx
18000b61a:     	testq	%rcx, %rcx
18000b61d:     	jne	0x18000b62c <numba_list_iter_next+0x10c>
18000b61f:     	xorl	%eax, %eax
18000b621:     	movq	0x30(%rsp), %rbx
18000b626:     	addq	$0x20, %rsp
18000b62a:     	popq	%rdi
18000b62b:     	retq
18000b62c:     	movl	$0x1, %eax
18000b631:     	xchgq	%rax, (%r8)
18000b634:     	movq	%rdx, 0x8(%r8)
18000b638:     	movq	%rdx, 0x10(%r8)
18000b63c:     	movq	%rcx, 0x18(%r8)
18000b640:     	movq	%rdi, 0x20(%r8)
18000b644:     	movq	%rbx, 0x28(%r8)
18000b648:     	cmpb	%dl, 0x95f2(%rip)       # 0x180014c40
18000b64e:     	je	0x18000b658 <numba_list_iter_next+0x138>
18000b650:     	lock
18000b651:     	incq	0x9600(%rip)            # 0x180014c58
18000b658:     	movq	0x30(%rsp), %rbx
18000b65d:     	movq	%r8, %rax
18000b660:     	addq	$0x20, %rsp
18000b664:     	popq	%rdi
18000b665:     	retq
18000b666:     	int3
18000b667:     	int3
18000b668:     	int3
18000b669:     	int3
18000b66a:     	int3
18000b66b:     	int3
18000b66c:     	int3
18000b66d:     	int3
18000b66e:     	int3
18000b66f:     	int3
18000b670:     	lock
18000b671:     	incq	(%rcx)
18000b674:     	retq
18000b675:     	int3
18000b676:     	int3
18000b677:     	int3
18000b678:     	int3
18000b679:     	int3
18000b67a:     	int3
18000b67b:     	int3
18000b67c:     	int3
18000b67d:     	int3
18000b67e:     	int3
18000b67f:     	int3
18000b680:     	pushq	%rbx
18000b682:     	subq	$0x20, %rsp
18000b686:     	movq	0x8(%rcx), %rax
18000b68a:     	movq	%rcx, %rbx
18000b68d:     	testq	%rax, %rax
18000b690:     	je	0x18000b6a9 <numba_list_iter_next+0x189>
18000b692:     	cmpl	$0x0, 0x959f(%rip)      # 0x180014c38
18000b699:     	jne	0x18000b6a9 <numba_list_iter_next+0x189>
18000b69b:     	movq	0x10(%rcx), %r8
18000b69f:     	movq	0x20(%rcx), %rdx
18000b6a3:     	movq	0x18(%rcx), %rcx
18000b6a7:     	callq	*%rax
18000b6a9:     	movq	0x28(%rbx), %rax
18000b6ad:     	movq	%rbx, %rcx
18000b6b0:     	testq	%rax, %rax
18000b6b3:     	je	0x18000b6be <numba_list_iter_next+0x19e>
18000b6b5:     	movq	0x18(%rax), %rdx
18000b6b9:     	callq	*0x10(%rax)
18000b6bc:     	jmp	0x18000b6c4 <numba_list_iter_next+0x1a4>
18000b6be:     	callq	*0x95b4(%rip)           # 0x180014c78
18000b6c4:     	cmpb	$0x0, 0x9575(%rip)      # 0x180014c40
18000b6cb:     	je	0x18000b6e9 <numba_list_iter_next+0x1c9>
18000b6cd:     	leaq	0x957c(%rip), %rax      # 0x180014c50
18000b6d4:     	lock
18000b6d5:     	incq	(%rax)
18000b6d8:     	cmpb	$0x0, 0x9561(%rip)      # 0x180014c40
18000b6df:     	je	0x18000b6e9 <numba_list_iter_next+0x1c9>
18000b6e1:     	lock
18000b6e2:     	incq	0x9577(%rip)            # 0x180014c60
18000b6e9:     	addq	$0x20, %rsp
18000b6ed:     	popq	%rbx
18000b6ee:     	retq
18000b6ef:     	int3
18000b6f0:     	pushq	%rbx
18000b6f2:     	subq	$0x20, %rsp
18000b6f6:     	movq	%rcx, %rbx
18000b6f9:     	movq	$-0x1, %rax
18000b700:     	lock
18000b701:     	xaddq	%rax, (%rcx)
18000b705:     	cmpq	$0x1, %rax
18000b709:     	jne	0x18000b76b <numba_list_iter_next+0x24b>
18000b70b:     	movq	0x8(%rcx), %rax
18000b70f:     	testq	%rax, %rax
18000b712:     	je	0x18000b72b <numba_list_iter_next+0x20b>
18000b714:     	cmpl	$0x0, 0x951d(%rip)      # 0x180014c38
18000b71b:     	jne	0x18000b72b <numba_list_iter_next+0x20b>
18000b71d:     	movq	0x10(%rcx), %r8
18000b721:     	movq	0x20(%rcx), %rdx
18000b725:     	movq	0x18(%rcx), %rcx
18000b729:     	callq	*%rax
18000b72b:     	movq	0x28(%rbx), %rax
18000b72f:     	movq	%rbx, %rcx
18000b732:     	testq	%rax, %rax
18000b735:     	je	0x18000b740 <numba_list_iter_next+0x220>
18000b737:     	movq	0x18(%rax), %rdx
18000b73b:     	callq	*0x10(%rax)
18000b73e:     	jmp	0x18000b746 <numba_list_iter_next+0x226>
18000b740:     	callq	*0x9532(%rip)           # 0x180014c78
18000b746:     	cmpb	$0x0, 0x94f3(%rip)      # 0x180014c40
18000b74d:     	je	0x18000b76b <numba_list_iter_next+0x24b>
18000b74f:     	leaq	0x94fa(%rip), %rax      # 0x180014c50
18000b756:     	lock
18000b757:     	incq	(%rax)
18000b75a:     	cmpb	$0x0, 0x94df(%rip)      # 0x180014c40
18000b761:     	je	0x18000b76b <numba_list_iter_next+0x24b>
18000b763:     	lock
18000b764:     	incq	0x94f5(%rip)            # 0x180014c60
18000b76b:     	addq	$0x20, %rsp
18000b76f:     	popq	%rbx
18000b770:     	retq
18000b771:     	int3
18000b772:     	int3
18000b773:     	int3
18000b774:     	int3
18000b775:     	int3
18000b776:     	int3
18000b777:     	int3
18000b778:     	int3
18000b779:     	int3
18000b77a:     	int3
18000b77b:     	int3
18000b77c:     	int3
18000b77d:     	int3
18000b77e:     	int3
18000b77f:     	int3
18000b780:     	movq	0x18(%rcx), %rax
18000b784:     	retq
18000b785:     	int3
18000b786:     	int3
18000b787:     	int3
18000b788:     	int3
18000b789:     	int3
18000b78a:     	int3
18000b78b:     	int3
18000b78c:     	int3
18000b78d:     	int3
18000b78e:     	int3
18000b78f:     	int3
18000b790:     	subq	$0x28, %rsp
18000b794:     	callq	*0x94de(%rip)           # 0x180014c78
18000b79a:     	cmpb	$0x0, 0x949f(%rip)      # 0x180014c40
18000b7a1:     	je	0x18000b7ab <numba_list_iter_next+0x28b>
18000b7a3:     	lock
18000b7a4:     	incq	0x94a5(%rip)            # 0x180014c50
18000b7ab:     	addq	$0x28, %rsp
18000b7af:     	retq
18000b7b0:     	jmpq	*%r8
18000b7b3:     	int3
18000b7b4:     	int3
18000b7b5:     	int3
18000b7b6:     	int3
18000b7b7:     	int3
18000b7b8:     	int3
18000b7b9:     	int3
18000b7ba:     	int3
18000b7bb:     	int3
18000b7bc:     	int3
18000b7bd:     	int3
18000b7be:     	int3
18000b7bf:     	int3
18000b7c0:     	movq	%rbx, 0x8(%rsp)
18000b7c5:     	pushq	%rdi
18000b7c6:     	subq	$0x20, %rsp
18000b7ca:     	movq	%rcx, %rdi
18000b7cd:     	movq	%rdx, %rbx
18000b7d0:     	movl	$0x30, %ecx
18000b7d5:     	callq	*0x948d(%rip)           # 0x180014c68
18000b7db:     	cmpb	$0x0, 0x945e(%rip)      # 0x180014c40
18000b7e2:     	je	0x18000b7ec <numba_list_iter_next+0x2cc>
18000b7e4:     	lock
18000b7e5:     	incq	0x945c(%rip)            # 0x180014c48
18000b7ec:     	testq	%rax, %rax
18000b7ef:     	je	0x18000b826 <numba_list_iter_next+0x306>
18000b7f1:     	leaq	-0x48(%rip), %rcx       # 0x18000b7b0 <numba_list_iter_next+0x290>
18000b7f8:     	movl	$0x1, %edx
18000b7fd:     	xchgq	%rdx, (%rax)
18000b800:     	movq	%rcx, 0x8(%rax)
18000b804:     	xorl	%ecx, %ecx
18000b806:     	movq	%rcx, 0x20(%rax)
18000b80a:     	movq	%rcx, 0x28(%rax)
18000b80e:     	movq	%rbx, 0x10(%rax)
18000b812:     	movq	%rdi, 0x18(%rax)
18000b816:     	cmpb	%cl, 0x9424(%rip)       # 0x180014c40
18000b81c:     	je	0x18000b826 <numba_list_iter_next+0x306>
18000b81e:     	lock
18000b81f:     	incq	0x9432(%rip)            # 0x180014c58
18000b826:     	movq	0x30(%rsp), %rbx
18000b82b:     	addq	$0x20, %rsp
18000b82f:     	popq	%rdi
18000b830:     	retq
18000b831:     	jmpq	*0x1ad9(%rip)           # 0x18000d310
18000b837:     	jmpq	*0x1ac3(%rip)           # 0x18000d300
18000b83d:     	jmpq	*0x1ab5(%rip)           # 0x18000d2f8
18000b843:     	jmpq	*0x1aa7(%rip)           # 0x18000d2f0
18000b849:     	jmpq	*0x1a99(%rip)           # 0x18000d2e8
18000b84f:     	jmpq	*0x1a8b(%rip)           # 0x18000d2e0
18000b855:     	jmpq	*0x1a7d(%rip)           # 0x18000d2d8
18000b85b:     	jmpq	*0x1a67(%rip)           # 0x18000d2c8
18000b861:     	jmpq	*0x1a59(%rip)           # 0x18000d2c0
18000b867:     	jmpq	*0x1a4b(%rip)           # 0x18000d2b8
18000b86d:     	jmpq	*0x1a35(%rip)           # 0x18000d2a8
18000b873:     	jmpq	*0x1a0f(%rip)           # 0x18000d288
18000b879:     	jmpq	*0x1a01(%rip)           # 0x18000d280
18000b87f:     	jmpq	*0x19f3(%rip)           # 0x18000d278
18000b885:     	jmpq	*0x19e5(%rip)           # 0x18000d270
18000b88b:     	jmpq	*0x199f(%rip)           # 0x18000d230
18000b891:     	int3
18000b892:     	int3
18000b893:     	int3
18000b894:     	int3
18000b895:     	int3
18000b896:     	int3
18000b897:     	int3
18000b898:     	int3
18000b899:     	int3
18000b89a:     	int3
18000b89b:     	int3
18000b89c:     	int3
18000b89d:     	int3
18000b89e:     	int3
18000b89f:     	int3
18000b8a0:     	int3
18000b8a1:     	int3
18000b8a2:     	int3
18000b8a3:     	int3
18000b8a4:     	int3
18000b8a5:     	int3
18000b8a6:     	nopw	(%rax,%rax)
18000b8b0:     	cmpq	0x8849(%rip), %rcx      # 0x180014100
18000b8b7:     	jne	0x18000b8c9 <numba_list_iter_next+0x3a9>
18000b8b9:     	rolq	$0x10, %rcx
18000b8bd:     	testw	$0xffff, %cx            # imm = 0xFFFF
18000b8c2:     	jne	0x18000b8c5 <numba_list_iter_next+0x3a5>
18000b8c4:     	retq
18000b8c5:     	rorq	$0x10, %rcx
18000b8c9:     	jmp	0x18000bc24 <numba_list_iter_next+0x704>
18000b8ce:     	int3
18000b8cf:     	int3
18000b8d0:     	subq	$0x28, %rsp
18000b8d4:     	testl	%edx, %edx
18000b8d6:     	je	0x18000b911 <numba_list_iter_next+0x3f1>
18000b8d8:     	subl	$0x1, %edx
18000b8db:     	je	0x18000b905 <numba_list_iter_next+0x3e5>
18000b8dd:     	subl	$0x1, %edx
18000b8e0:     	je	0x18000b8f8 <numba_list_iter_next+0x3d8>
18000b8e2:     	cmpl	$0x1, %edx
18000b8e5:     	je	0x18000b8f1 <numba_list_iter_next+0x3d1>
18000b8e7:     	movl	$0x1, %eax
18000b8ec:     	addq	$0x28, %rsp
18000b8f0:     	retq
18000b8f1:     	callq	0x18000bdf0 <numba_list_iter_next+0x8d0>
18000b8f6:     	jmp	0x18000b8fd <numba_list_iter_next+0x3dd>
18000b8f8:     	callq	0x18000bdc8 <numba_list_iter_next+0x8a8>
18000b8fd:     	movzbl	%al, %eax
18000b900:     	addq	$0x28, %rsp
18000b904:     	retq
18000b905:     	movq	%r8, %rdx
18000b908:     	addq	$0x28, %rsp
18000b90c:     	jmp	0x18000b920 <numba_list_iter_next+0x400>
18000b911:     	testq	%r8, %r8
18000b914:     	setne	%cl
18000b917:     	addq	$0x28, %rsp
18000b91b:     	jmp	0x18000ba38 <numba_list_iter_next+0x518>
18000b920:     	movq	%rbx, 0x8(%rsp)
18000b925:     	movq	%rsi, 0x10(%rsp)
18000b92a:     	movq	%rdi, 0x20(%rsp)
18000b92f:     	pushq	%r14
18000b931:     	subq	$0x20, %rsp
18000b935:     	movq	%rdx, %rsi
18000b938:     	movq	%rcx, %r14
18000b93b:     	xorl	%ecx, %ecx
18000b93d:     	callq	0x18000beac <numba_list_iter_next+0x98c>
18000b942:     	testb	%al, %al
18000b944:     	je	0x18000ba12 <numba_list_iter_next+0x4f2>
18000b94a:     	callq	0x18000bd40 <numba_list_iter_next+0x820>
18000b94f:     	movb	%al, %bl
18000b951:     	movb	%al, 0x40(%rsp)
18000b955:     	movb	$0x1, %dil
18000b958:     	cmpl	$0x0, 0x90a9(%rip)      # 0x180014a08
18000b95f:     	jne	0x18000ba2a <numba_list_iter_next+0x50a>
18000b965:     	movl	$0x1, 0x9099(%rip)      # 0x180014a08
18000b96f:     	callq	0x18000bdb0 <numba_list_iter_next+0x890>
18000b974:     	testb	%al, %al
18000b976:     	je	0x18000b9c7 <numba_list_iter_next+0x4a7>
18000b978:     	callq	0x18000c06c <numba_list_iter_next+0xb4c>
18000b97d:     	callq	0x18000bd00 <numba_list_iter_next+0x7e0>
18000b982:     	callq	0x18000bd24 <numba_list_iter_next+0x804>
18000b987:     	leaq	0x19e2(%rip), %rdx      # 0x18000d370
18000b98e:     	leaq	0x19d3(%rip), %rcx      # 0x18000d368
18000b995:     	callq	0x18000c3b2 <numba_list_iter_next+0xe92>
18000b99a:     	testl	%eax, %eax
18000b99c:     	jne	0x18000b9c7 <numba_list_iter_next+0x4a7>
18000b99e:     	callq	0x18000bd7c <numba_list_iter_next+0x85c>
18000b9a3:     	testb	%al, %al
18000b9a5:     	je	0x18000b9c7 <numba_list_iter_next+0x4a7>
18000b9a7:     	leaq	0x19b2(%rip), %rdx      # 0x18000d360
18000b9ae:     	leaq	0x19a3(%rip), %rcx      # 0x18000d358
18000b9b5:     	callq	0x18000c3ac <numba_list_iter_next+0xe8c>
18000b9ba:     	movl	$0x2, 0x9044(%rip)      # 0x180014a08
18000b9c4:     	xorb	%dil, %dil
18000b9c7:     	movb	%bl, %cl
18000b9c9:     	callq	0x18000c00c <numba_list_iter_next+0xaec>
18000b9ce:     	testb	%dil, %dil
18000b9d1:     	jne	0x18000ba12 <numba_list_iter_next+0x4f2>
18000b9d3:     	callq	0x18000c05c <numba_list_iter_next+0xb3c>
18000b9d8:     	movq	%rax, %rbx
18000b9db:     	cmpq	$0x0, (%rax)
18000b9df:     	je	0x18000ba05 <numba_list_iter_next+0x4e5>
18000b9e1:     	movq	%rax, %rcx
18000b9e4:     	callq	0x18000bf74 <numba_list_iter_next+0xa54>
18000b9e9:     	testb	%al, %al
18000b9eb:     	je	0x18000ba05 <numba_list_iter_next+0x4e5>
18000b9ed:     	movq	%rsi, %r8
18000b9f0:     	movl	$0x2, %edx
18000b9f5:     	movq	%r14, %rcx
18000b9f8:     	movq	(%rbx), %rax
18000b9fb:     	movq	0x192e(%rip), %r9       # 0x18000d330
18000ba02:     	callq	*%r9
18000ba05:     	incl	0x8fd5(%rip)            # 0x1800149e0
18000ba0b:     	movl	$0x1, %eax
18000ba10:     	jmp	0x18000ba14 <numba_list_iter_next+0x4f4>
18000ba12:     	xorl	%eax, %eax
18000ba14:     	movq	0x30(%rsp), %rbx
18000ba19:     	movq	0x38(%rsp), %rsi
18000ba1e:     	movq	0x48(%rsp), %rdi
18000ba23:     	addq	$0x20, %rsp
18000ba27:     	popq	%r14
18000ba29:     	retq
18000ba2a:     	movl	$0x7, %ecx
18000ba2f:     	callq	0x18000c064 <numba_list_iter_next+0xb44>
18000ba34:     	nop
18000ba35:     	int3
18000ba36:     	int3
18000ba37:     	int3
18000ba38:     	movq	%rbx, 0x8(%rsp)
18000ba3d:     	pushq	%rdi
18000ba3e:     	subq	$0x30, %rsp
18000ba42:     	movb	%cl, %dil
18000ba45:     	movl	0x8f95(%rip), %eax      # 0x1800149e0
18000ba4b:     	testl	%eax, %eax
18000ba4d:     	jg	0x18000ba5c <numba_list_iter_next+0x53c>
18000ba4f:     	xorl	%eax, %eax
18000ba51:     	movq	0x40(%rsp), %rbx
18000ba56:     	addq	$0x30, %rsp
18000ba5a:     	popq	%rdi
18000ba5b:     	retq
18000ba5c:     	decl	%eax
18000ba5e:     	movl	%eax, 0x8f7c(%rip)      # 0x1800149e0
18000ba64:     	callq	0x18000bd40 <numba_list_iter_next+0x820>
18000ba69:     	movb	%al, %bl
18000ba6b:     	movb	%al, 0x20(%rsp)
18000ba6f:     	cmpl	$0x2, 0x8f92(%rip)      # 0x180014a08
18000ba76:     	jne	0x18000baae <numba_list_iter_next+0x58e>
18000ba78:     	callq	0x18000be68 <numba_list_iter_next+0x948>
18000ba7d:     	callq	0x18000bd10 <numba_list_iter_next+0x7f0>
18000ba82:     	callq	0x18000c0a8 <numba_list_iter_next+0xb88>
18000ba87:     	movl	$0x0, 0x8f77(%rip)      # 0x180014a08
18000ba91:     	movb	%bl, %cl
18000ba93:     	callq	0x18000c00c <numba_list_iter_next+0xaec>
18000ba98:     	xorl	%edx, %edx
18000ba9a:     	movb	%dil, %cl
18000ba9d:     	callq	0x18000c030 <numba_list_iter_next+0xb10>
18000baa2:     	movzbl	%al, %ebx
18000baa5:     	callq	0x18000be98 <numba_list_iter_next+0x978>
18000baaa:     	movl	%ebx, %eax
18000baac:     	jmp	0x18000ba51 <numba_list_iter_next+0x531>
18000baae:     	movl	$0x7, %ecx
18000bab3:     	callq	0x18000c064 <numba_list_iter_next+0xb44>
18000bab8:     	nop
18000bab9:     	nop
18000baba:     	int3
18000babb:     	int3
18000babc:     	movq	%rsp, %rax
18000babf:     	movq	%rbx, 0x20(%rax)
18000bac3:     	movq	%r8, 0x18(%rax)
18000bac7:     	movl	%edx, 0x10(%rax)
18000baca:     	movq	%rcx, 0x8(%rax)
18000bace:     	pushq	%rsi
18000bacf:     	pushq	%rdi
18000bad0:     	pushq	%r14
18000bad2:     	subq	$0x40, %rsp
18000bad6:     	movq	%r8, %rsi
18000bad9:     	movl	%edx, %edi
18000badb:     	movq	%rcx, %r14
18000bade:     	testl	%edx, %edx
18000bae0:     	jne	0x18000baf1 <numba_list_iter_next+0x5d1>
18000bae2:     	cmpl	%edx, 0x8ef8(%rip)      # 0x1800149e0
18000bae8:     	jg	0x18000baf1 <numba_list_iter_next+0x5d1>
18000baea:     	xorl	%eax, %eax
18000baec:     	jmp	0x18000bbd6 <numba_list_iter_next+0x6b6>
18000baf1:     	leal	-0x1(%rdx), %eax
18000baf4:     	cmpl	$0x1, %eax
18000baf7:     	ja	0x18000bb39 <numba_list_iter_next+0x619>
18000baf9:     	movq	0x2028(%rip), %rax      # 0x18000db28
18000bb00:     	testq	%rax, %rax
18000bb03:     	jne	0x18000bb0a <numba_list_iter_next+0x5ea>
18000bb05:     	leal	0x1(%rax), %ebx
18000bb08:     	jmp	0x18000bb12 <numba_list_iter_next+0x5f2>
18000bb0a:     	callq	*0x1820(%rip)           # 0x18000d330
18000bb10:     	movl	%eax, %ebx
18000bb12:     	movl	%ebx, 0x30(%rsp)
18000bb16:     	testl	%ebx, %ebx
18000bb18:     	je	0x18000bbcc <numba_list_iter_next+0x6ac>
18000bb1e:     	movq	%rsi, %r8
18000bb21:     	movl	%edi, %edx
18000bb23:     	movq	%r14, %rcx
18000bb26:     	callq	0x18000b8d0 <numba_list_iter_next+0x3b0>
18000bb2b:     	movl	%eax, %ebx
18000bb2d:     	movl	%eax, 0x30(%rsp)
18000bb31:     	testl	%eax, %eax
18000bb33:     	je	0x18000bbcc <numba_list_iter_next+0x6ac>
18000bb39:     	movq	%rsi, %r8
18000bb3c:     	movl	%edi, %edx
18000bb3e:     	movq	%r14, %rcx
18000bb41:     	callq	0x18000bcdc <numba_list_iter_next+0x7bc>
18000bb46:     	movl	%eax, %ebx
18000bb48:     	movl	%eax, 0x30(%rsp)
18000bb4c:     	cmpl	$0x1, %edi
18000bb4f:     	jne	0x18000bb87 <numba_list_iter_next+0x667>
18000bb51:     	testl	%eax, %eax
18000bb53:     	jne	0x18000bb87 <numba_list_iter_next+0x667>
18000bb55:     	movq	%rsi, %r8
18000bb58:     	xorl	%edx, %edx
18000bb5a:     	movq	%r14, %rcx
18000bb5d:     	callq	0x18000bcdc <numba_list_iter_next+0x7bc>
18000bb62:     	testq	%rsi, %rsi
18000bb65:     	setne	%cl
18000bb68:     	callq	0x18000ba38 <numba_list_iter_next+0x518>
18000bb6d:     	movq	0x1fb4(%rip), %rax      # 0x18000db28
18000bb74:     	testq	%rax, %rax
18000bb77:     	je	0x18000bb87 <numba_list_iter_next+0x667>
18000bb79:     	movq	%rsi, %r8
18000bb7c:     	xorl	%edx, %edx
18000bb7e:     	movq	%r14, %rcx
18000bb81:     	callq	*0x17a9(%rip)           # 0x18000d330
18000bb87:     	testl	%edi, %edi
18000bb89:     	je	0x18000bb90 <numba_list_iter_next+0x670>
18000bb8b:     	cmpl	$0x3, %edi
18000bb8e:     	jne	0x18000bbcc <numba_list_iter_next+0x6ac>
18000bb90:     	movq	%rsi, %r8
18000bb93:     	movl	%edi, %edx
18000bb95:     	movq	%r14, %rcx
18000bb98:     	callq	0x18000b8d0 <numba_list_iter_next+0x3b0>
18000bb9d:     	movl	%eax, %ebx
18000bb9f:     	movl	%eax, 0x30(%rsp)
18000bba3:     	testl	%eax, %eax
18000bba5:     	je	0x18000bbcc <numba_list_iter_next+0x6ac>
18000bba7:     	movq	0x1f7a(%rip), %rax      # 0x18000db28
18000bbae:     	testq	%rax, %rax
18000bbb1:     	jne	0x18000bbb8 <numba_list_iter_next+0x698>
18000bbb3:     	leal	0x1(%rax), %ebx
18000bbb6:     	jmp	0x18000bbc8 <numba_list_iter_next+0x6a8>
18000bbb8:     	movq	%rsi, %r8
18000bbbb:     	movl	%edi, %edx
18000bbbd:     	movq	%r14, %rcx
18000bbc0:     	callq	*0x176a(%rip)           # 0x18000d330
18000bbc6:     	movl	%eax, %ebx
18000bbc8:     	movl	%ebx, 0x30(%rsp)
18000bbcc:     	jmp	0x18000bbd4 <numba_list_iter_next+0x6b4>
18000bbce:     	xorl	%ebx, %ebx
18000bbd0:     	movl	%ebx, 0x30(%rsp)
18000bbd4:     	movl	%ebx, %eax
18000bbd6:     	movq	0x78(%rsp), %rbx
18000bbdb:     	addq	$0x40, %rsp
18000bbdf:     	popq	%r14
18000bbe1:     	popq	%rdi
18000bbe2:     	popq	%rsi
18000bbe3:     	retq
18000bbe4:     	movq	%rbx, 0x8(%rsp)
18000bbe9:     	movq	%rsi, 0x10(%rsp)
18000bbee:     	pushq	%rdi
18000bbef:     	subq	$0x20, %rsp
18000bbf3:     	movq	%r8, %rdi
18000bbf6:     	movl	%edx, %ebx
18000bbf8:     	movq	%rcx, %rsi
18000bbfb:     	cmpl	$0x1, %edx
18000bbfe:     	jne	0x18000bc05 <numba_list_iter_next+0x6e5>
18000bc00:     	callq	0x18000bc2c <numba_list_iter_next+0x70c>
18000bc05:     	movq	%rdi, %r8
18000bc08:     	movl	%ebx, %edx
18000bc0a:     	movq	%rsi, %rcx
18000bc0d:     	movq	0x30(%rsp), %rbx
18000bc12:     	movq	0x38(%rsp), %rsi
18000bc17:     	addq	$0x20, %rsp
18000bc1b:     	popq	%rdi
18000bc1c:     	jmp	0x18000babc <numba_list_iter_next+0x59c>
18000bc21:     	int3
18000bc22:     	int3
18000bc23:     	int3
18000bc24:     	movl	$0x2, %ecx
18000bc29:     	int	$0x29
18000bc2b:     	retq
18000bc2c:     	movq	%rbx, 0x18(%rsp)
18000bc31:     	pushq	%rbp
18000bc32:     	movq	%rsp, %rbp
18000bc35:     	subq	$0x30, %rsp
18000bc39:     	movq	0x84c0(%rip), %rax      # 0x180014100
18000bc40:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000bc4a:     	cmpq	%rbx, %rax
18000bc4d:     	jne	0x18000bcc6 <numba_list_iter_next+0x7a6>
18000bc4f:     	leaq	0x10(%rbp), %rcx
18000bc53:     	movq	$0x0, 0x10(%rbp)
18000bc5b:     	callq	*0x13bf(%rip)           # 0x18000d020
18000bc61:     	movq	0x10(%rbp), %rax
18000bc65:     	movq	%rax, -0x10(%rbp)
18000bc69:     	callq	*0x13a9(%rip)           # 0x18000d018
18000bc6f:     	movl	%eax, %eax
18000bc71:     	xorq	%rax, -0x10(%rbp)
18000bc75:     	callq	*0x1395(%rip)           # 0x18000d010
18000bc7b:     	movl	%eax, %eax
18000bc7d:     	leaq	0x18(%rbp), %rcx
18000bc81:     	xorq	%rax, -0x10(%rbp)
18000bc85:     	callq	*0x1375(%rip)           # 0x18000d000
18000bc8b:     	movl	0x18(%rbp), %eax
18000bc8e:     	leaq	-0x10(%rbp), %rcx
18000bc92:     	shlq	$0x20, %rax
18000bc96:     	xorq	0x18(%rbp), %rax
18000bc9a:     	xorq	-0x10(%rbp), %rax
18000bc9e:     	xorq	%rcx, %rax
18000bca1:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000bcab:     	andq	%rcx, %rax
18000bcae:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
18000bcb8:     	cmpq	%rbx, %rax
18000bcbb:     	cmoveq	%rcx, %rax
18000bcbf:     	movq	%rax, 0x843a(%rip)      # 0x180014100
18000bcc6:     	movq	0x50(%rsp), %rbx
18000bccb:     	notq	%rax
18000bcce:     	movq	%rax, 0x846b(%rip)      # 0x180014140
18000bcd5:     	addq	$0x30, %rsp
18000bcd9:     	popq	%rbp
18000bcda:     	retq
18000bcdb:     	int3
18000bcdc:     	subq	$0x28, %rsp
18000bce0:     	cmpl	$0x1, %edx
18000bce3:     	jne	0x18000bcf5 <numba_list_iter_next+0x7d5>
18000bce5:     	cmpq	$0x0, 0x1e3b(%rip)      # 0x18000db28
18000bced:     	jne	0x18000bcf5 <numba_list_iter_next+0x7d5>
18000bcef:     	callq	*0x1333(%rip)           # 0x18000d028
18000bcf5:     	movl	$0x1, %eax
18000bcfa:     	addq	$0x28, %rsp
18000bcfe:     	retq
18000bcff:     	int3
18000bd00:     	leaq	0x8ce9(%rip), %rcx      # 0x1800149f0
18000bd07:     	jmpq	*0x12fa(%rip)           # 0x18000d008
18000bd0e:     	int3
18000bd0f:     	int3
18000bd10:     	leaq	0x8cd9(%rip), %rcx      # 0x1800149f0
18000bd17:     	jmp	0x18000c3a6 <numba_list_iter_next+0xe86>
18000bd1c:     	leaq	0x8cdd(%rip), %rax      # 0x180014a00
18000bd23:     	retq
18000bd24:     	subq	$0x28, %rsp
18000bd28:     	callq	0x18000ae30 <PyInit_rcaotr_d69a5295b7dfe3ae8e1e45a1+0x7270>
18000bd2d:     	orq	$0x24, (%rax)
18000bd31:     	callq	0x18000bd1c <numba_list_iter_next+0x7fc>
18000bd36:     	orq	$0x2, (%rax)
18000bd3a:     	addq	$0x28, %rsp
18000bd3e:     	retq
18000bd3f:     	int3
18000bd40:     	subq	$0x28, %rsp
18000bd44:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000bd49:     	testl	%eax, %eax
18000bd4b:     	je	0x18000bd6e <numba_list_iter_next+0x84e>
18000bd4d:     	movq	%gs:0x30, %rax
18000bd56:     	movq	0x8(%rax), %rcx
18000bd5a:     	jmp	0x18000bd61 <numba_list_iter_next+0x841>
18000bd5c:     	cmpq	%rax, %rcx
18000bd5f:     	je	0x18000bd75 <numba_list_iter_next+0x855>
18000bd61:     	xorl	%eax, %eax
18000bd63:     	lock
18000bd64:     	cmpxchgq	%rcx, 0x8ca4(%rip)      # 0x180014a10
18000bd6c:     	jne	0x18000bd5c <numba_list_iter_next+0x83c>
18000bd6e:     	xorb	%al, %al
18000bd70:     	addq	$0x28, %rsp
18000bd74:     	retq
18000bd75:     	movb	$0x1, %al
18000bd77:     	jmp	0x18000bd70 <numba_list_iter_next+0x850>
18000bd79:     	int3
18000bd7a:     	int3
18000bd7b:     	int3
18000bd7c:     	subq	$0x28, %rsp
18000bd80:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000bd85:     	testl	%eax, %eax
18000bd87:     	je	0x18000bd90 <numba_list_iter_next+0x870>
18000bd89:     	callq	0x18000c0e8 <numba_list_iter_next+0xbc8>
18000bd8e:     	jmp	0x18000bda9 <numba_list_iter_next+0x889>
18000bd90:     	callq	0x18000c384 <numba_list_iter_next+0xe64>
18000bd95:     	movl	%eax, %ecx
18000bd97:     	callq	0x18000c3be <numba_list_iter_next+0xe9e>
18000bd9c:     	testl	%eax, %eax
18000bd9e:     	je	0x18000bda4 <numba_list_iter_next+0x884>
18000bda0:     	xorb	%al, %al
18000bda2:     	jmp	0x18000bdab <numba_list_iter_next+0x88b>
18000bda4:     	callq	0x18000c3c4 <numba_list_iter_next+0xea4>
18000bda9:     	movb	$0x1, %al
18000bdab:     	addq	$0x28, %rsp
18000bdaf:     	retq
18000bdb0:     	subq	$0x28, %rsp
18000bdb4:     	xorl	%ecx, %ecx
18000bdb6:     	callq	0x18000bee8 <numba_list_iter_next+0x9c8>
18000bdbb:     	testb	%al, %al
18000bdbd:     	setne	%al
18000bdc0:     	addq	$0x28, %rsp
18000bdc4:     	retq
18000bdc5:     	int3
18000bdc6:     	int3
18000bdc7:     	int3
18000bdc8:     	subq	$0x28, %rsp
18000bdcc:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bdd1:     	testb	%al, %al
18000bdd3:     	jne	0x18000bdd9 <numba_list_iter_next+0x8b9>
18000bdd5:     	xorb	%al, %al
18000bdd7:     	jmp	0x18000bdeb <numba_list_iter_next+0x8cb>
18000bdd9:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bdde:     	testb	%al, %al
18000bde0:     	jne	0x18000bde9 <numba_list_iter_next+0x8c9>
18000bde2:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bde7:     	jmp	0x18000bdd5 <numba_list_iter_next+0x8b5>
18000bde9:     	movb	$0x1, %al
18000bdeb:     	addq	$0x28, %rsp
18000bdef:     	retq
18000bdf0:     	subq	$0x28, %rsp
18000bdf4:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bdf9:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bdfe:     	movb	$0x1, %al
18000be00:     	addq	$0x28, %rsp
18000be04:     	retq
18000be05:     	int3
18000be06:     	int3
18000be07:     	int3
18000be08:     	movq	%rbx, 0x8(%rsp)
18000be0d:     	movq	%rbp, 0x10(%rsp)
18000be12:     	movq	%rsi, 0x18(%rsp)
18000be17:     	pushq	%rdi
18000be18:     	subq	$0x20, %rsp
18000be1c:     	movq	%r9, %rdi
18000be1f:     	movq	%r8, %rsi
18000be22:     	movl	%edx, %ebx
18000be24:     	movq	%rcx, %rbp
18000be27:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000be2c:     	testl	%eax, %eax
18000be2e:     	jne	0x18000be46 <numba_list_iter_next+0x926>
18000be30:     	cmpl	$0x1, %ebx
18000be33:     	jne	0x18000be46 <numba_list_iter_next+0x926>
18000be35:     	movq	%rsi, %r8
18000be38:     	xorl	%edx, %edx
18000be3a:     	movq	%rbp, %rcx
18000be3d:     	movq	%rdi, %rax
18000be40:     	callq	*0x14ea(%rip)           # 0x18000d330
18000be46:     	movq	0x58(%rsp), %rdx
18000be4b:     	movl	0x50(%rsp), %ecx
18000be4f:     	movq	0x30(%rsp), %rbx
18000be54:     	movq	0x38(%rsp), %rbp
18000be59:     	movq	0x40(%rsp), %rsi
18000be5e:     	addq	$0x20, %rsp
18000be62:     	popq	%rdi
18000be63:     	jmp	0x18000c3b8 <numba_list_iter_next+0xe98>
18000be68:     	subq	$0x28, %rsp
18000be6c:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000be71:     	testl	%eax, %eax
18000be73:     	je	0x18000be85 <numba_list_iter_next+0x965>
18000be75:     	leaq	0x8ba4(%rip), %rcx      # 0x180014a20
18000be7c:     	addq	$0x28, %rsp
18000be80:     	jmp	0x18000c3d0 <numba_list_iter_next+0xeb0>
18000be85:     	callq	0x18000c3e0 <numba_list_iter_next+0xec0>
18000be8a:     	testl	%eax, %eax
18000be8c:     	jne	0x18000be93 <numba_list_iter_next+0x973>
18000be8e:     	callq	0x18000c3d6 <numba_list_iter_next+0xeb6>
18000be93:     	addq	$0x28, %rsp
18000be97:     	retq
18000be98:     	subq	$0x28, %rsp
18000be9c:     	xorl	%ecx, %ecx
18000be9e:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bea3:     	addq	$0x28, %rsp
18000bea7:     	jmp	0x18000c3dc <numba_list_iter_next+0xebc>
18000beac:     	subq	$0x28, %rsp
18000beb0:     	testl	%ecx, %ecx
18000beb2:     	jne	0x18000bebb <numba_list_iter_next+0x99b>
18000beb4:     	movb	$0x1, 0x8b5d(%rip)      # 0x180014a18
18000bebb:     	callq	0x18000c0e8 <numba_list_iter_next+0xbc8>
18000bec0:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bec5:     	testb	%al, %al
18000bec7:     	jne	0x18000becd <numba_list_iter_next+0x9ad>
18000bec9:     	xorb	%al, %al
18000becb:     	jmp	0x18000bee1 <numba_list_iter_next+0x9c1>
18000becd:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bed2:     	testb	%al, %al
18000bed4:     	jne	0x18000bedf <numba_list_iter_next+0x9bf>
18000bed6:     	xorl	%ecx, %ecx
18000bed8:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000bedd:     	jmp	0x18000bec9 <numba_list_iter_next+0x9a9>
18000bedf:     	movb	$0x1, %al
18000bee1:     	addq	$0x28, %rsp
18000bee5:     	retq
18000bee6:     	int3
18000bee7:     	int3
18000bee8:     	pushq	%rbx
18000beea:     	subq	$0x20, %rsp
18000beee:     	cmpb	$0x0, 0x8b24(%rip)      # 0x180014a19
18000bef5:     	movl	%ecx, %ebx
18000bef7:     	jne	0x18000bf60 <numba_list_iter_next+0xa40>
18000bef9:     	cmpl	$0x1, %ecx
18000befc:     	ja	0x18000bf68 <numba_list_iter_next+0xa48>
18000befe:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000bf03:     	testl	%eax, %eax
18000bf05:     	je	0x18000bf2f <numba_list_iter_next+0xa0f>
18000bf07:     	testl	%ebx, %ebx
18000bf09:     	jne	0x18000bf2f <numba_list_iter_next+0xa0f>
18000bf0b:     	leaq	0x8b0e(%rip), %rcx      # 0x180014a20
18000bf12:     	callq	0x18000c3ca <numba_list_iter_next+0xeaa>
18000bf17:     	testl	%eax, %eax
18000bf19:     	jne	0x18000bf2b <numba_list_iter_next+0xa0b>
18000bf1b:     	leaq	0x8b16(%rip), %rcx      # 0x180014a38
18000bf22:     	callq	0x18000c3ca <numba_list_iter_next+0xeaa>
18000bf27:     	testl	%eax, %eax
18000bf29:     	je	0x18000bf59 <numba_list_iter_next+0xa39>
18000bf2b:     	xorb	%al, %al
18000bf2d:     	jmp	0x18000bf62 <numba_list_iter_next+0xa42>
18000bf2f:     	movdqa	0x1bf9(%rip), %xmm0     # 0x18000db30
18000bf37:     	orq	$-0x1, %rax
18000bf3b:     	movdqu	%xmm0, 0x8add(%rip)     # 0x180014a20
18000bf43:     	movq	%rax, 0x8ae6(%rip)      # 0x180014a30
18000bf4a:     	movdqu	%xmm0, 0x8ae6(%rip)     # 0x180014a38
18000bf52:     	movq	%rax, 0x8aef(%rip)      # 0x180014a48
18000bf59:     	movb	$0x1, 0x8ab9(%rip)      # 0x180014a19
18000bf60:     	movb	$0x1, %al
18000bf62:     	addq	$0x20, %rsp
18000bf66:     	popq	%rbx
18000bf67:     	retq
18000bf68:     	movl	$0x5, %ecx
18000bf6d:     	callq	0x18000c064 <numba_list_iter_next+0xb44>
18000bf72:     	int3
18000bf73:     	int3
18000bf74:     	subq	$0x18, %rsp
18000bf78:     	movq	%rcx, %r8
18000bf7b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
18000bf80:     	cmpw	%ax, -0xbf87(%rip)      # 0x180000000
18000bf87:     	jne	0x18000c001 <numba_list_iter_next+0xae1>
18000bf89:     	movslq	-0xbf54(%rip), %rcx     # 0x18000003c
18000bf90:     	leaq	-0xbf97(%rip), %rdx     # 0x180000000
18000bf97:     	addq	%rdx, %rcx
18000bf9a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
18000bfa0:     	jne	0x18000c001 <numba_list_iter_next+0xae1>
18000bfa2:     	movl	$0x20b, %eax            # imm = 0x20B
18000bfa7:     	cmpw	%ax, 0x18(%rcx)
18000bfab:     	jne	0x18000c001 <numba_list_iter_next+0xae1>
18000bfad:     	subq	%rdx, %r8
18000bfb0:     	movzwl	0x14(%rcx), %edx
18000bfb4:     	addq	$0x18, %rdx
18000bfb8:     	addq	%rcx, %rdx
18000bfbb:     	movzwl	0x6(%rcx), %eax
18000bfbf:     	leaq	(%rax,%rax,4), %rcx
18000bfc3:     	leaq	(%rdx,%rcx,8), %r9
18000bfc7:     	movq	%rdx, (%rsp)
18000bfcb:     	cmpq	%r9, %rdx
18000bfce:     	je	0x18000bfe8 <numba_list_iter_next+0xac8>
18000bfd0:     	movl	0xc(%rdx), %ecx
18000bfd3:     	cmpq	%rcx, %r8
18000bfd6:     	jb	0x18000bfe2 <numba_list_iter_next+0xac2>
18000bfd8:     	movl	0x8(%rdx), %eax
18000bfdb:     	addl	%ecx, %eax
18000bfdd:     	cmpq	%rax, %r8
18000bfe0:     	jb	0x18000bfea <numba_list_iter_next+0xaca>
18000bfe2:     	addq	$0x28, %rdx
18000bfe6:     	jmp	0x18000bfc7 <numba_list_iter_next+0xaa7>
18000bfe8:     	xorl	%edx, %edx
18000bfea:     	testq	%rdx, %rdx
18000bfed:     	jne	0x18000bff3 <numba_list_iter_next+0xad3>
18000bfef:     	xorb	%al, %al
18000bff1:     	jmp	0x18000c007 <numba_list_iter_next+0xae7>
18000bff3:     	cmpl	$0x0, 0x24(%rdx)
18000bff7:     	jge	0x18000bffd <numba_list_iter_next+0xadd>
18000bff9:     	xorb	%al, %al
18000bffb:     	jmp	0x18000c007 <numba_list_iter_next+0xae7>
18000bffd:     	movb	$0x1, %al
18000bfff:     	jmp	0x18000c007 <numba_list_iter_next+0xae7>
18000c001:     	xorb	%al, %al
18000c003:     	jmp	0x18000c007 <numba_list_iter_next+0xae7>
18000c005:     	xorb	%al, %al
18000c007:     	addq	$0x18, %rsp
18000c00b:     	retq
18000c00c:     	pushq	%rbx
18000c00e:     	subq	$0x20, %rsp
18000c012:     	movb	%cl, %bl
18000c014:     	callq	0x18000c38c <numba_list_iter_next+0xe6c>
18000c019:     	xorl	%edx, %edx
18000c01b:     	testl	%eax, %eax
18000c01d:     	je	0x18000c02a <numba_list_iter_next+0xb0a>
18000c01f:     	testb	%bl, %bl
18000c021:     	jne	0x18000c02a <numba_list_iter_next+0xb0a>
18000c023:     	xchgq	%rdx, 0x89e6(%rip)      # 0x180014a10
18000c02a:     	addq	$0x20, %rsp
18000c02e:     	popq	%rbx
18000c02f:     	retq
18000c030:     	pushq	%rbx
18000c032:     	subq	$0x20, %rsp
18000c036:     	cmpb	$0x0, 0x89db(%rip)      # 0x180014a18
18000c03d:     	movb	%cl, %bl
18000c03f:     	je	0x18000c045 <numba_list_iter_next+0xb25>
18000c041:     	testb	%dl, %dl
18000c043:     	jne	0x18000c051 <numba_list_iter_next+0xb31>
18000c045:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000c04a:     	movb	%bl, %cl
18000c04c:     	callq	0x18000c3dc <numba_list_iter_next+0xebc>
18000c051:     	movb	$0x1, %al
18000c053:     	addq	$0x20, %rsp
18000c057:     	popq	%rbx
18000c058:     	retq
18000c059:     	int3
18000c05a:     	int3
18000c05b:     	int3
18000c05c:     	leaq	0x8c75(%rip), %rax      # 0x180014cd8
18000c063:     	retq
18000c064:     	movl	%ecx, %ecx
18000c066:     	int	$0x29
18000c068:     	retq
18000c069:     	int3
18000c06a:     	int3
18000c06b:     	int3
18000c06c:     	movq	%rbx, 0x8(%rsp)
18000c071:     	pushq	%rdi
18000c072:     	subq	$0x20, %rsp
18000c076:     	leaq	0x44cb(%rip), %rbx      # 0x180010548
18000c07d:     	leaq	0x44c4(%rip), %rdi      # 0x180010548
18000c084:     	jmp	0x18000c098 <numba_list_iter_next+0xb78>
18000c086:     	movq	(%rbx), %rax
18000c089:     	testq	%rax, %rax
18000c08c:     	je	0x18000c094 <numba_list_iter_next+0xb74>
18000c08e:     	callq	*0x129c(%rip)           # 0x18000d330
18000c094:     	addq	$0x8, %rbx
18000c098:     	cmpq	%rdi, %rbx
18000c09b:     	jb	0x18000c086 <numba_list_iter_next+0xb66>
18000c09d:     	movq	0x30(%rsp), %rbx
18000c0a2:     	addq	$0x20, %rsp
18000c0a6:     	popq	%rdi
18000c0a7:     	retq
18000c0a8:     	movq	%rbx, 0x8(%rsp)
18000c0ad:     	pushq	%rdi
18000c0ae:     	subq	$0x20, %rsp
18000c0b2:     	leaq	0x449f(%rip), %rbx      # 0x180010558
18000c0b9:     	leaq	0x4498(%rip), %rdi      # 0x180010558
18000c0c0:     	jmp	0x18000c0d4 <numba_list_iter_next+0xbb4>
18000c0c2:     	movq	(%rbx), %rax
18000c0c5:     	testq	%rax, %rax
18000c0c8:     	je	0x18000c0d0 <numba_list_iter_next+0xbb0>
18000c0ca:     	callq	*0x1260(%rip)           # 0x18000d330
18000c0d0:     	addq	$0x8, %rbx
18000c0d4:     	cmpq	%rdi, %rbx
18000c0d7:     	jb	0x18000c0c2 <numba_list_iter_next+0xba2>
18000c0d9:     	movq	0x30(%rsp), %rbx
18000c0de:     	addq	$0x20, %rsp
18000c0e2:     	popq	%rdi
18000c0e3:     	retq
18000c0e4:     	retq	$0x0
18000c0e7:     	int3
18000c0e8:     	movq	%rbx, 0x10(%rsp)
18000c0ed:     	movq	%rbp, 0x18(%rsp)
18000c0f2:     	movq	%rsi, 0x20(%rsp)
18000c0f7:     	pushq	%rdi
18000c0f8:     	subq	$0x10, %rsp
18000c0fc:     	xorl	%eax, %eax
18000c0fe:     	xorl	%ecx, %ecx
18000c100:     	cpuid
18000c102:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
18000c108:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000c10e:     	orl	%ecx, %edx
18000c110:     	movl	%eax, %ebp
18000c112:     	movl	$0x1, %eax
18000c117:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000c11d:     	orl	%ebx, %edx
18000c11f:     	leal	-0x1(%rax), %ecx
18000c122:     	cpuid
18000c124:     	movl	%ecx, %edi
18000c126:     	jne	0x18000c186 <numba_list_iter_next+0xc66>
18000c128:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000c12d:     	movq	$0x8000, 0x8020(%rip)   # imm = 0x8000
                                                # 0x180014158
18000c138:     	movq	$-0x1, 0x801d(%rip)     # 0x180014160
18000c143:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
18000c148:     	je	0x18000c172 <numba_list_iter_next+0xc52>
18000c14a:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000c14f:     	je	0x18000c172 <numba_list_iter_next+0xc52>
18000c151:     	cmpl	$0x20670, %eax          # imm = 0x20670
18000c156:     	je	0x18000c172 <numba_list_iter_next+0xc52>
18000c158:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000c15d:     	cmpl	$0x20, %eax
18000c160:     	ja	0x18000c186 <numba_list_iter_next+0xc66>
18000c162:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000c16c:     	btq	%rax, %rcx
18000c170:     	jae	0x18000c186 <numba_list_iter_next+0xc66>
18000c172:     	movl	0x88db(%rip), %r8d      # 0x180014a54
18000c179:     	orl	$0x1, %r8d
18000c17d:     	movl	%r8d, 0x88d0(%rip)      # 0x180014a54
18000c184:     	jmp	0x18000c18d <numba_list_iter_next+0xc6d>
18000c186:     	movl	0x88c7(%rip), %r8d      # 0x180014a54
18000c18d:     	xorl	%r9d, %r9d
18000c190:     	movl	%r9d, %r11d
18000c193:     	cmpl	$0x7, %ebp
18000c196:     	jl	0x18000c1da <numba_list_iter_next+0xcba>
18000c198:     	xorl	%ecx, %ecx
18000c19a:     	leal	0x7(%r9), %eax
18000c19e:     	cpuid
18000c1a0:     	movl	%edx, %esi
18000c1a2:     	movl	%ebx, %r10d
18000c1a5:     	btl	$0x9, %ebx
18000c1a9:     	jae	0x18000c1b6 <numba_list_iter_next+0xc96>
18000c1ab:     	orl	$0x2, %r8d
18000c1af:     	movl	%r8d, 0x889e(%rip)      # 0x180014a54
18000c1b6:     	cmpl	$0x1, %eax
18000c1b9:     	jl	0x18000c1c8 <numba_list_iter_next+0xca8>
18000c1bb:     	movl	$0x7, %eax
18000c1c0:     	leal	-0x6(%rax), %ecx
18000c1c3:     	cpuid
18000c1c5:     	movl	%edx, %r9d
18000c1c8:     	movl	$0x24, %eax
18000c1cd:     	cmpl	%eax, %ebp
18000c1cf:     	jl	0x18000c1e0 <numba_list_iter_next+0xcc0>
18000c1d1:     	xorl	%ecx, %ecx
18000c1d3:     	cpuid
18000c1d5:     	movl	%ebx, %r11d
18000c1d8:     	jmp	0x18000c1e0 <numba_list_iter_next+0xcc0>
18000c1da:     	movl	%r9d, %r10d
18000c1dd:     	movl	%r9d, %esi
18000c1e0:     	movq	0x7f81(%rip), %rax      # 0x180014168
18000c1e7:     	andq	$-0x2, %rax
18000c1eb:     	movl	$0x1, 0x7f5b(%rip)      # 0x180014150
18000c1f5:     	movl	$0x2, 0x7f55(%rip)      # 0x180014154
18000c1ff:     	movq	%rax, 0x7f62(%rip)      # 0x180014168
18000c206:     	btl	$0x14, %edi
18000c20a:     	jae	0x18000c22b <numba_list_iter_next+0xd0b>
18000c20c:     	andq	$-0x11, %rax
18000c210:     	movl	$0x2, 0x7f36(%rip)      # 0x180014150
18000c21a:     	movq	%rax, 0x7f47(%rip)      # 0x180014168
18000c221:     	movl	$0x6, 0x7f29(%rip)      # 0x180014154
18000c22b:     	btl	$0x1b, %edi
18000c22f:     	jae	0x18000c36c <numba_list_iter_next+0xe4c>
18000c235:     	xorl	%ecx, %ecx
18000c237:     	xgetbv
18000c23a:     	shlq	$0x20, %rdx
18000c23e:     	orq	%rax, %rdx
18000c241:     	movq	%rdx, 0x20(%rsp)
18000c246:     	btl	$0x1c, %edi
18000c24a:     	jae	0x18000c350 <numba_list_iter_next+0xe30>
18000c250:     	movq	0x20(%rsp), %rax
18000c255:     	andb	$0x6, %al
18000c257:     	cmpb	$0x6, %al
18000c259:     	jne	0x18000c350 <numba_list_iter_next+0xe30>
18000c25f:     	movl	0x7eef(%rip), %eax      # 0x180014154
18000c265:     	movb	$-0x20, %dl
18000c267:     	orl	$0x8, %eax
18000c26a:     	movl	$0x3, 0x7edc(%rip)      # 0x180014150
18000c274:     	movl	%eax, 0x7eda(%rip)      # 0x180014154
18000c27a:     	testb	$0x20, %r10b
18000c27e:     	je	0x18000c2e2 <numba_list_iter_next+0xdc2>
18000c280:     	orl	$0x20, %eax
18000c283:     	movl	$0x5, 0x7ec3(%rip)      # 0x180014150
18000c28d:     	movl	%eax, 0x7ec1(%rip)      # 0x180014154
18000c293:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
18000c298:     	movq	0x7ec9(%rip), %rax      # 0x180014168
18000c29f:     	andl	%ecx, %r10d
18000c2a2:     	andq	$-0x3, %rax
18000c2a6:     	movq	%rax, 0x7ebb(%rip)      # 0x180014168
18000c2ad:     	cmpl	%ecx, %r10d
18000c2b0:     	jne	0x18000c2e9 <numba_list_iter_next+0xdc9>
18000c2b2:     	movq	0x20(%rsp), %rax
18000c2b7:     	andb	%dl, %al
18000c2b9:     	cmpb	%dl, %al
18000c2bb:     	jne	0x18000c2e2 <numba_list_iter_next+0xdc2>
18000c2bd:     	movq	0x7ea4(%rip), %rax      # 0x180014168
18000c2c4:     	orl	$0x40, 0x7e89(%rip)     # 0x180014154
18000c2cb:     	andq	$-0x25, %rax
18000c2cf:     	movl	$0x6, 0x7e77(%rip)      # 0x180014150
18000c2d9:     	movq	%rax, 0x7e88(%rip)      # 0x180014168
18000c2e0:     	jmp	0x18000c2e9 <numba_list_iter_next+0xdc9>
18000c2e2:     	movq	0x7e7f(%rip), %rax      # 0x180014168
18000c2e9:     	btl	$0x17, %esi
18000c2ed:     	jae	0x18000c2fb <numba_list_iter_next+0xddb>
18000c2ef:     	btrq	$0x18, %rax
18000c2f4:     	movq	%rax, 0x7e6d(%rip)      # 0x180014168
18000c2fb:     	btl	$0x13, %r9d
18000c300:     	jae	0x18000c350 <numba_list_iter_next+0xe30>
18000c302:     	movq	0x20(%rsp), %rax
18000c307:     	andb	%dl, %al
18000c309:     	cmpb	%dl, %al
18000c30b:     	jne	0x18000c350 <numba_list_iter_next+0xe30>
18000c30d:     	movq	0x7e54(%rip), %rdx      # 0x180014168
18000c314:     	movl	%r11d, %eax
18000c317:     	shrq	$0x10, %rax
18000c31b:     	movl	%r11d, %ecx
18000c31e:     	andl	$0x6, %eax
18000c321:     	andl	$0x400ff, %ecx          # imm = 0x400FF
18000c327:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000c32d:     	movl	%ecx, 0x8725(%rip)      # 0x180014a58
18000c333:     	notq	%rax
18000c336:     	andq	%rax, %rdx
18000c339:     	movq	%rdx, 0x7e28(%rip)      # 0x180014168
18000c340:     	cmpb	$0x1, %cl
18000c343:     	jbe	0x18000c350 <numba_list_iter_next+0xe30>
18000c345:     	andq	$-0x41, %rdx
18000c349:     	movq	%rdx, 0x7e18(%rip)      # 0x180014168
18000c350:     	btl	$0x15, %r9d
18000c355:     	jae	0x18000c36c <numba_list_iter_next+0xe4c>
18000c357:     	movq	0x20(%rsp), %rax
18000c35c:     	btq	$0x13, %rax
18000c361:     	jae	0x18000c36c <numba_list_iter_next+0xe4c>
18000c363:     	btrq	$0x7, 0x7dfc(%rip)      # 0x180014168
18000c36c:     	movq	0x28(%rsp), %rbx
18000c371:     	xorl	%eax, %eax
18000c373:     	movq	0x30(%rsp), %rbp
18000c378:     	movq	0x38(%rsp), %rsi
18000c37d:     	addq	$0x10, %rsp
18000c381:     	popq	%rdi
18000c382:     	retq
18000c383:     	int3
18000c384:     	movl	$0x1, %eax
18000c389:     	retq
18000c38a:     	int3
18000c38b:     	int3
18000c38c:     	xorl	%eax, %eax
18000c38e:     	cmpl	%eax, 0x7ddc(%rip)      # 0x180014170
18000c394:     	setne	%al
18000c397:     	retq
18000c398:     	int3
18000c399:     	int3
18000c39a:     	int3
18000c39b:     	int3
18000c39c:     	int3
18000c39d:     	int3
18000c39e:     	int3
18000c39f:     	int3
18000c3a0:     	jmpq	*0xca2(%rip)            # 0x18000d048
18000c3a6:     	jmpq	*0xca4(%rip)            # 0x18000d050
18000c3ac:     	jmpq	*0xcde(%rip)            # 0x18000d090
18000c3b2:     	jmpq	*0xce0(%rip)            # 0x18000d098
18000c3b8:     	jmpq	*0xce2(%rip)            # 0x18000d0a0
18000c3be:     	jmpq	*0xce4(%rip)            # 0x18000d0a8
18000c3c4:     	jmpq	*0xce6(%rip)            # 0x18000d0b0
18000c3ca:     	jmpq	*0xcb0(%rip)            # 0x18000d080
18000c3d0:     	jmpq	*0xce2(%rip)            # 0x18000d0b8
18000c3d6:     	jmpq	*0xcac(%rip)            # 0x18000d088
18000c3dc:     	movb	$0x1, %al
18000c3de:     	retq
18000c3df:     	int3
18000c3e0:     	xorl	%eax, %eax
18000c3e2:     	retq
18000c3e3:     	jmpq	*0xc4f(%rip)            # 0x18000d038
18000c3e9:     	jmpq	*0xc51(%rip)            # 0x18000d040
18000c3ef:     	jmpq	*0xcd3(%rip)            # 0x18000d0c8
18000c3f5:     	jmpq	*0xcd5(%rip)            # 0x18000d0d0
18000c3fb:     	int3
18000c3fc:     	int3
18000c3fd:     	int3
18000c3fe:     	int3
18000c3ff:     	int3
18000c400:     	int3
18000c401:     	int3
18000c402:     	int3
18000c403:     	int3
18000c404:     	int3
18000c405:     	int3
18000c406:     	nopw	(%rax,%rax)
18000c410:     	jmpq	*%rax
18000c412:     	int3
18000c413:     	int3
18000c414:     	int3
18000c415:     	int3
18000c416:     	int3
18000c417:     	int3
18000c418:     	int3
18000c419:     	int3
18000c41a:     	int3
18000c41b:     	int3
18000c41c:     	int3
18000c41d:     	int3
18000c41e:     	int3
18000c41f:     	int3
18000c420:     	int3
18000c421:     	int3
18000c422:     	int3
18000c423:     	int3
18000c424:     	int3
18000c425:     	int3
18000c426:     	nopw	(%rax,%rax)
18000c430:     	jmpq	*0xefa(%rip)            # 0x18000d330
18000c436:     	pushq	%rbp
18000c438:     	subq	$0x20, %rsp
18000c43c:     	movq	%rdx, %rbp
18000c43f:     	movb	0x40(%rbp), %cl
18000c442:     	addq	$0x20, %rsp
18000c446:     	popq	%rbp
18000c447:     	jmp	0x18000c00c <numba_list_iter_next+0xaec>
18000c44c:     	int3
18000c44d:     	pushq	%rbp
18000c44f:     	subq	$0x20, %rsp
18000c453:     	movq	%rdx, %rbp
18000c456:     	movb	0x20(%rbp), %cl
18000c459:     	callq	0x18000c00c <numba_list_iter_next+0xaec>
18000c45e:     	nop
18000c45f:     	addq	$0x20, %rsp
18000c463:     	popq	%rbp
18000c464:     	retq
18000c465:     	int3
18000c466:     	pushq	%rbp
18000c468:     	subq	$0x20, %rsp
18000c46c:     	movq	%rdx, %rbp
18000c46f:     	addq	$0x20, %rsp
18000c473:     	popq	%rbp
18000c474:     	jmp	0x18000be98 <numba_list_iter_next+0x978>
18000c479:     	int3
18000c47a:     	pushq	%rbp
18000c47c:     	subq	$0x30, %rsp
18000c480:     	movq	%rdx, %rbp
18000c483:     	movq	(%rcx), %rax
18000c486:     	movl	(%rax), %edx
18000c488:     	movq	%rcx, 0x28(%rsp)
18000c48d:     	movl	%edx, 0x20(%rsp)
18000c491:     	leaq	-0xbc8(%rip), %r9       # 0x18000b8d0 <numba_list_iter_next+0x3b0>
18000c498:     	movq	0x70(%rbp), %r8
18000c49c:     	movl	0x68(%rbp), %edx
18000c49f:     	movq	0x60(%rbp), %rcx
18000c4a3:     	callq	0x18000be08 <numba_list_iter_next+0x8e8>
18000c4a8:     	nop
18000c4a9:     	addq	$0x30, %rsp
18000c4ad:     	popq	%rbp
18000c4ae:     	retq
18000c4af:     	int3
18000c4b0:     	pushq	%rbp
18000c4b2:     	movq	%rdx, %rbp
18000c4b5:     	movq	(%rcx), %rax
18000c4b8:     	xorl	%ecx, %ecx
18000c4ba:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
18000c4c0:     	sete	%cl
18000c4c3:     	movl	%ecx, %eax
18000c4c5:     	popq	%rbp
18000c4c6:     	retq
18000c4c7:     	int3
