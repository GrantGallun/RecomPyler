
D:\Code\Datathon\recompyler-codex-20261111\wave5-study\results\cache\barnes_hut\candidate\recompyler\rcaotr_2fe5e05e91a653421cd9997e.cp314-win_amd64.pyd:	file format coff-x86-64

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
18000106c:     	jmp	0x18000bb10 <numba_list_iter_next+0x160>
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
18000155b:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
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
1800017c6:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
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
180001a8e:     	callq	0x18000bcc1 <numba_list_iter_next+0x311>
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
180001aec:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180001b6f:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180001c12:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180001cc5:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180001d51:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
180001d56:     	testq	%rax, %rax
180001d59:     	movq	%rbx, 0x128(%rsp)
180001d61:     	movq	%r12, 0x120(%rsp)
180001d69:     	movq	%rbp, 0x170(%rsp)
180001d71:     	je	0x180002136 <.text+0x1136>
180001d77:     	movq	%rax, %r13
180001d7a:     	movq	%rax, %rcx
180001d7d:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
180001d82:     	movq	%rax, %r12
180001d85:     	movq	%r13, %rcx
180001d88:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180001d8d:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180001d92:     	testq	%rax, %rax
180001d95:     	jne	0x18000216c <.text+0x116c>
180001d9b:     	movq	0x1e0(%rsp), %rcx
180001da3:     	callq	0x18000bcdf <numba_list_iter_next+0x32f>
180001da8:     	movq	%rax, %rbx
180001dab:     	movq	%rax, %rcx
180001dae:     	callq	0x18000bce5 <numba_list_iter_next+0x335>
180001db3:     	movaps	%xmm0, %xmm6
180001db6:     	movq	%rbx, %rcx
180001db9:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180001dbe:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180001dc3:     	testq	%rax, %rax
180001dc6:     	jne	0x18000216c <.text+0x116c>
180001dcc:     	movq	0x1d8(%rsp), %rcx
180001dd4:     	callq	0x18000bcdf <numba_list_iter_next+0x32f>
180001dd9:     	movq	%rax, %rbx
180001ddc:     	movq	%rax, %rcx
180001ddf:     	callq	0x18000bce5 <numba_list_iter_next+0x335>
180001de4:     	movaps	%xmm0, %xmm7
180001de7:     	movq	%rbx, %rcx
180001dea:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180001def:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180001df4:     	testq	%rax, %rax
180001df7:     	jne	0x18000216c <.text+0x116c>
180001dfd:     	movq	0x1d0(%rsp), %rcx
180001e05:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
180001e0a:     	testq	%rax, %rax
180001e0d:     	je	0x180002149 <.text+0x1149>
180001e13:     	movq	%rax, %rbp
180001e16:     	movq	%rax, %rcx
180001e19:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
180001e1e:     	movq	%rax, %r13
180001e21:     	movq	%rbp, %rcx
180001e24:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180001e29:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180001e2e:     	testq	%rax, %rax
180001e31:     	jne	0x18000216c <.text+0x116c>
180001e37:     	movq	0x1c8(%rsp), %rcx
180001e3f:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
180001e44:     	testq	%rax, %rax
180001e47:     	je	0x18000215c <.text+0x115c>
180001e4d:     	movq	%rax, %rbx
180001e50:     	movq	%rax, %rcx
180001e53:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
180001e58:     	movq	%rax, %rbp
180001e5b:     	movq	%rbx, %rcx
180001e5e:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180001e63:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
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
180002047:     	callq	0x18000bceb <numba_list_iter_next+0x33b>
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
180002079:     	callq	0x18000bcf1 <numba_list_iter_next+0x341>
18000207e:     	movl	0x8(%rbx), %edx
180002081:     	movq	(%rbx), %rcx
180002084:     	cmpl	$0x0, 0x20(%rbx)
180002088:     	jle	0x1800021c2 <.text+0x11c2>
18000208e:     	movslq	%edx, %rdx
180002091:     	callq	0x18000bcf7 <numba_list_iter_next+0x347>
180002096:     	movq	%rax, %rsi
180002099:     	movq	0x10(%rbx), %rcx
18000209d:     	callq	*0x18(%rbx)
1800020a0:     	testq	%rax, %rax
1800020a3:     	je	0x1800021eb <.text+0x11eb>
1800020a9:     	movq	%rsi, %rcx
1800020ac:     	movq	%rax, %rdx
1800020af:     	callq	0x18000a190 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65d0>
1800020b4:     	movq	%rax, %rsi
1800020b7:     	movq	%rbx, %rcx
1800020ba:     	callq	0x18000bc20 <numba_list_iter_next+0x270>
1800020bf:     	jmp	0x1800021ce <.text+0x11ce>
1800020c4:     	movq	0xb1e5(%rip), %rcx      # 0x18000d2b0
1800020cb:     	leaq	0xb3fe(%rip), %rdx      # 0x18000d4d0
1800020d2:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
1800020d7:     	jmp	0x18000219c <.text+0x119c>
1800020dc:     	movq	0xb1bd(%rip), %rcx      # 0x18000d2a0
1800020e3:     	leaq	0xb4e6(%rip), %rdx      # 0x18000d5d0
1800020ea:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
1800020ef:     	jmp	0x18000219c <.text+0x119c>
1800020f4:     	movq	0xb1a5(%rip), %rcx      # 0x18000d2a0
1800020fb:     	leaq	0xb4ce(%rip), %rdx      # 0x18000d5d0
180002102:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180002107:     	jmp	0x180002194 <.text+0x1194>
18000210c:     	movq	0xb18d(%rip), %rcx      # 0x18000d2a0
180002113:     	leaq	0xb4b6(%rip), %rdx      # 0x18000d5d0
18000211a:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
18000211f:     	jmp	0x18000218c <.text+0x118c>
180002121:     	movq	0xb178(%rip), %rcx      # 0x18000d2a0
180002128:     	leaq	0xb4a1(%rip), %rdx      # 0x18000d5d0
18000212f:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180002134:     	jmp	0x180002184 <.text+0x1184>
180002136:     	xorl	%r12d, %r12d
180002139:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
18000213e:     	testq	%rax, %rax
180002141:     	je	0x180001d9b <.text+0xd9b>
180002147:     	jmp	0x18000216c <.text+0x116c>
180002149:     	xorl	%r13d, %r13d
18000214c:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180002151:     	testq	%rax, %rax
180002154:     	je	0x180001e37 <.text+0xe37>
18000215a:     	jmp	0x18000216c <.text+0x116c>
18000215c:     	xorl	%ebp, %ebp
18000215e:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
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
1800021bb:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
1800021c0:     	jmp	0x18000219c <.text+0x119c>
1800021c2:     	movq	0x10(%rbx), %r8
1800021c6:     	callq	0x18000a0b0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64f0>
1800021cb:     	movq	%rax, %rsi
1800021ce:     	testq	%rsi, %rsi
1800021d1:     	je	0x18000219c <.text+0x119c>
1800021d3:     	movq	%rsi, %rcx
1800021d6:     	callq	0x180009c50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6090>
1800021db:     	jmp	0x18000219c <.text+0x119c>
1800021dd:     	movq	0xb0ac(%rip), %rcx      # 0x18000d290
1800021e4:     	callq	0x18000bd03 <numba_list_iter_next+0x353>
1800021e9:     	jmp	0x18000219c <.text+0x119c>
1800021eb:     	movq	0xb0be(%rip), %rcx      # 0x18000d2b0
1800021f2:     	leaq	0xb437(%rip), %rdx      # 0x18000d630
1800021f9:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
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
180002468:     	callq	0x180009c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6060>
18000246d:     	testl	%edi, %edi
18000246f:     	jle	0x1800024b5 <.text+0x14b5>
180002471:     	callq	0x18000bcf1 <numba_list_iter_next+0x341>
180002476:     	movl	0x8(%rsi), %edx
180002479:     	movq	(%rsi), %rcx
18000247c:     	cmpl	$0x0, 0x20(%rsi)
180002480:     	jle	0x1800024d6 <.text+0x14d6>
180002482:     	movslq	%edx, %rdx
180002485:     	callq	0x18000bcf7 <numba_list_iter_next+0x347>
18000248a:     	movq	%rax, %rdi
18000248d:     	movq	0x10(%rsi), %rcx
180002491:     	callq	*0x18(%rsi)
180002494:     	testq	%rax, %rax
180002497:     	je	0x180002531 <.text+0x1531>
18000249d:     	movq	%rdi, %rcx
1800024a0:     	movq	%rax, %rdx
1800024a3:     	callq	0x18000a190 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65d0>
1800024a8:     	movq	%rax, %rdi
1800024ab:     	movq	%rsi, %rcx
1800024ae:     	callq	0x18000bc20 <numba_list_iter_next+0x270>
1800024b3:     	jmp	0x1800024e2 <.text+0x14e2>
1800024b5:     	movl	%edi, %eax
1800024b7:     	cmpl	$-0x3, %edi
1800024ba:     	je	0x180002523 <.text+0x1523>
1800024bc:     	cmpl	$-0x1, %eax
1800024bf:     	je	0x1800024ef <.text+0x14ef>
1800024c1:     	movq	0xadd0(%rip), %rcx      # 0x18000d298
1800024c8:     	leaq	0xb211(%rip), %rdx      # 0x18000d6e0
1800024cf:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
1800024d4:     	jmp	0x1800024ef <.text+0x14ef>
1800024d6:     	movq	0x10(%rsi), %r8
1800024da:     	callq	0x18000a0b0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64f0>
1800024df:     	movq	%rax, %rdi
1800024e2:     	testq	%rdi, %rdi
1800024e5:     	je	0x1800024ef <.text+0x14ef>
1800024e7:     	movq	%rdi, %rcx
1800024ea:     	callq	0x180009c50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6090>
1800024ef:     	leaq	0xb21a(%rip), %rcx      # 0x18000d710
1800024f6:     	callq	0x18000bd09 <numba_list_iter_next+0x359>
1800024fb:     	movq	%rax, %rsi
1800024fe:     	movq	%rax, %rcx
180002501:     	callq	0x18000bd0f <numba_list_iter_next+0x35f>
180002506:     	movq	%rsi, %rcx
180002509:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
18000250e:     	leaq	0x124(%rsp), %rcx
180002516:     	callq	0x180009c40 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6080>
18000251b:     	movq	%rbx, %rax
18000251e:     	jmp	0x180002447 <.text+0x1447>
180002523:     	movq	0xad66(%rip), %rcx      # 0x18000d290
18000252a:     	callq	0x18000bd03 <numba_list_iter_next+0x353>
18000252f:     	jmp	0x1800024ef <.text+0x14ef>
180002531:     	movq	0xad78(%rip), %rcx      # 0x18000d2b0
180002538:     	leaq	0xb161(%rip), %rdx      # 0x18000d6a0
18000253f:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
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
180002a6d:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
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
180002cc3:     	callq	0x180006a50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e90>
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
1800030fe:     	callq	0x18000bcc1 <numba_list_iter_next+0x311>
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
18000315c:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
1800031df:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180003282:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
180003335:     	callq	0x18000a980 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6dc0>
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
1800033c1:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
1800033c6:     	testq	%rax, %rax
1800033c9:     	movq	%rbx, 0x128(%rsp)
1800033d1:     	movq	%r12, 0x120(%rsp)
1800033d9:     	movq	%rbp, 0x170(%rsp)
1800033e1:     	je	0x1800037a6 <.text+0x27a6>
1800033e7:     	movq	%rax, %r13
1800033ea:     	movq	%rax, %rcx
1800033ed:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
1800033f2:     	movq	%rax, %r12
1800033f5:     	movq	%r13, %rcx
1800033f8:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
1800033fd:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180003402:     	testq	%rax, %rax
180003405:     	jne	0x1800037dc <.text+0x27dc>
18000340b:     	movq	0x1e0(%rsp), %rcx
180003413:     	callq	0x18000bcdf <numba_list_iter_next+0x32f>
180003418:     	movq	%rax, %rbx
18000341b:     	movq	%rax, %rcx
18000341e:     	callq	0x18000bce5 <numba_list_iter_next+0x335>
180003423:     	movaps	%xmm0, %xmm6
180003426:     	movq	%rbx, %rcx
180003429:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
18000342e:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180003433:     	testq	%rax, %rax
180003436:     	jne	0x1800037dc <.text+0x27dc>
18000343c:     	movq	0x1d8(%rsp), %rcx
180003444:     	callq	0x18000bcdf <numba_list_iter_next+0x32f>
180003449:     	movq	%rax, %rbx
18000344c:     	movq	%rax, %rcx
18000344f:     	callq	0x18000bce5 <numba_list_iter_next+0x335>
180003454:     	movaps	%xmm0, %xmm7
180003457:     	movq	%rbx, %rcx
18000345a:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
18000345f:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
180003464:     	testq	%rax, %rax
180003467:     	jne	0x1800037dc <.text+0x27dc>
18000346d:     	movq	0x1d0(%rsp), %rcx
180003475:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
18000347a:     	testq	%rax, %rax
18000347d:     	je	0x1800037b9 <.text+0x27b9>
180003483:     	movq	%rax, %rbp
180003486:     	movq	%rax, %rcx
180003489:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
18000348e:     	movq	%rax, %r13
180003491:     	movq	%rbp, %rcx
180003494:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180003499:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
18000349e:     	testq	%rax, %rax
1800034a1:     	jne	0x1800037dc <.text+0x27dc>
1800034a7:     	movq	0x1c8(%rsp), %rcx
1800034af:     	callq	0x18000bcc7 <numba_list_iter_next+0x317>
1800034b4:     	testq	%rax, %rax
1800034b7:     	je	0x1800037cc <.text+0x27cc>
1800034bd:     	movq	%rax, %rbx
1800034c0:     	movq	%rax, %rcx
1800034c3:     	callq	0x18000bccd <numba_list_iter_next+0x31d>
1800034c8:     	movq	%rax, %rbp
1800034cb:     	movq	%rbx, %rcx
1800034ce:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
1800034d3:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
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
1800036b7:     	callq	0x18000bceb <numba_list_iter_next+0x33b>
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
1800036e9:     	callq	0x18000bcf1 <numba_list_iter_next+0x341>
1800036ee:     	movl	0x8(%rbx), %edx
1800036f1:     	movq	(%rbx), %rcx
1800036f4:     	cmpl	$0x0, 0x20(%rbx)
1800036f8:     	jle	0x180003832 <.text+0x2832>
1800036fe:     	movslq	%edx, %rdx
180003701:     	callq	0x18000bcf7 <numba_list_iter_next+0x347>
180003706:     	movq	%rax, %rsi
180003709:     	movq	0x10(%rbx), %rcx
18000370d:     	callq	*0x18(%rbx)
180003710:     	testq	%rax, %rax
180003713:     	je	0x18000385b <.text+0x285b>
180003719:     	movq	%rsi, %rcx
18000371c:     	movq	%rax, %rdx
18000371f:     	callq	0x18000a190 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65d0>
180003724:     	movq	%rax, %rsi
180003727:     	movq	%rbx, %rcx
18000372a:     	callq	0x18000bc20 <numba_list_iter_next+0x270>
18000372f:     	jmp	0x18000383e <.text+0x283e>
180003734:     	movq	0x9b75(%rip), %rcx      # 0x18000d2b0
18000373b:     	leaq	0xa00e(%rip), %rdx      # 0x18000d750
180003742:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180003747:     	jmp	0x18000380c <.text+0x280c>
18000374c:     	movq	0x9b4d(%rip), %rcx      # 0x18000d2a0
180003753:     	leaq	0xa0f6(%rip), %rdx      # 0x18000d850
18000375a:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
18000375f:     	jmp	0x18000380c <.text+0x280c>
180003764:     	movq	0x9b35(%rip), %rcx      # 0x18000d2a0
18000376b:     	leaq	0xa0de(%rip), %rdx      # 0x18000d850
180003772:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180003777:     	jmp	0x180003804 <.text+0x2804>
18000377c:     	movq	0x9b1d(%rip), %rcx      # 0x18000d2a0
180003783:     	leaq	0xa0c6(%rip), %rdx      # 0x18000d850
18000378a:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
18000378f:     	jmp	0x1800037fc <.text+0x27fc>
180003791:     	movq	0x9b08(%rip), %rcx      # 0x18000d2a0
180003798:     	leaq	0xa0b1(%rip), %rdx      # 0x18000d850
18000379f:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
1800037a4:     	jmp	0x1800037f4 <.text+0x27f4>
1800037a6:     	xorl	%r12d, %r12d
1800037a9:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
1800037ae:     	testq	%rax, %rax
1800037b1:     	je	0x18000340b <.text+0x240b>
1800037b7:     	jmp	0x1800037dc <.text+0x27dc>
1800037b9:     	xorl	%r13d, %r13d
1800037bc:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
1800037c1:     	testq	%rax, %rax
1800037c4:     	je	0x1800034a7 <.text+0x24a7>
1800037ca:     	jmp	0x1800037dc <.text+0x27dc>
1800037cc:     	xorl	%ebp, %ebp
1800037ce:     	callq	0x18000bcd9 <numba_list_iter_next+0x329>
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
18000382b:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180003830:     	jmp	0x18000380c <.text+0x280c>
180003832:     	movq	0x10(%rbx), %r8
180003836:     	callq	0x18000a0b0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64f0>
18000383b:     	movq	%rax, %rsi
18000383e:     	testq	%rsi, %rsi
180003841:     	je	0x18000380c <.text+0x280c>
180003843:     	movq	%rsi, %rcx
180003846:     	callq	0x180009c50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6090>
18000384b:     	jmp	0x18000380c <.text+0x280c>
18000384d:     	movq	0x9a3c(%rip), %rcx      # 0x18000d290
180003854:     	callq	0x18000bd03 <numba_list_iter_next+0x353>
180003859:     	jmp	0x18000380c <.text+0x280c>
18000385b:     	movq	0x9a4e(%rip), %rcx      # 0x18000d2b0
180003862:     	leaq	0xa047(%rip), %rdx      # 0x18000d8b0
180003869:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
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
180003ad8:     	callq	0x180009c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6060>
180003add:     	testl	%edi, %edi
180003adf:     	jle	0x180003b25 <.text+0x2b25>
180003ae1:     	callq	0x18000bcf1 <numba_list_iter_next+0x341>
180003ae6:     	movl	0x8(%rsi), %edx
180003ae9:     	movq	(%rsi), %rcx
180003aec:     	cmpl	$0x0, 0x20(%rsi)
180003af0:     	jle	0x180003b46 <.text+0x2b46>
180003af2:     	movslq	%edx, %rdx
180003af5:     	callq	0x18000bcf7 <numba_list_iter_next+0x347>
180003afa:     	movq	%rax, %rdi
180003afd:     	movq	0x10(%rsi), %rcx
180003b01:     	callq	*0x18(%rsi)
180003b04:     	testq	%rax, %rax
180003b07:     	je	0x180003ba1 <.text+0x2ba1>
180003b0d:     	movq	%rdi, %rcx
180003b10:     	movq	%rax, %rdx
180003b13:     	callq	0x18000a190 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65d0>
180003b18:     	movq	%rax, %rdi
180003b1b:     	movq	%rsi, %rcx
180003b1e:     	callq	0x18000bc20 <numba_list_iter_next+0x270>
180003b23:     	jmp	0x180003b52 <.text+0x2b52>
180003b25:     	movl	%edi, %eax
180003b27:     	cmpl	$-0x3, %edi
180003b2a:     	je	0x180003b93 <.text+0x2b93>
180003b2c:     	cmpl	$-0x1, %eax
180003b2f:     	je	0x180003b5f <.text+0x2b5f>
180003b31:     	movq	0x9760(%rip), %rcx      # 0x18000d298
180003b38:     	leaq	0x9e21(%rip), %rdx      # 0x18000d960
180003b3f:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180003b44:     	jmp	0x180003b5f <.text+0x2b5f>
180003b46:     	movq	0x10(%rsi), %r8
180003b4a:     	callq	0x18000a0b0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64f0>
180003b4f:     	movq	%rax, %rdi
180003b52:     	testq	%rdi, %rdi
180003b55:     	je	0x180003b5f <.text+0x2b5f>
180003b57:     	movq	%rdi, %rcx
180003b5a:     	callq	0x180009c50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6090>
180003b5f:     	leaq	0x9e2a(%rip), %rcx      # 0x18000d990
180003b66:     	callq	0x18000bd09 <numba_list_iter_next+0x359>
180003b6b:     	movq	%rax, %rsi
180003b6e:     	movq	%rax, %rcx
180003b71:     	callq	0x18000bd0f <numba_list_iter_next+0x35f>
180003b76:     	movq	%rsi, %rcx
180003b79:     	callq	0x18000bcd3 <numba_list_iter_next+0x323>
180003b7e:     	leaq	0x124(%rsp), %rcx
180003b86:     	callq	0x180009c40 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6080>
180003b8b:     	movq	%rbx, %rax
180003b8e:     	jmp	0x180003ab7 <.text+0x2ab7>
180003b93:     	movq	0x96f6(%rip), %rcx      # 0x18000d290
180003b9a:     	callq	0x18000bd03 <numba_list_iter_next+0x353>
180003b9f:     	jmp	0x180003b5f <.text+0x2b5f>
180003ba1:     	movq	0x9708(%rip), %rcx      # 0x18000d2b0
180003ba8:     	leaq	0x9d71(%rip), %rdx      # 0x18000d920
180003baf:     	callq	0x18000bcfd <numba_list_iter_next+0x34d>
180003bb4:     	xorl	%eax, %eax
180003bb6:     	jmp	0x180003ab7 <.text+0x2ab7>
180003bbb:     	nopl	(%rax,%rax)

0000000180003bc0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e>:
180003bc0:     	pushq	%rsi
180003bc1:     	subq	$0x20, %rsp
180003bc5:     	leaq	0x10494(%rip), %rcx     # 0x180014060
180003bcc:     	movl	$0x3f5, %edx            # imm = 0x3F5
180003bd1:     	callq	0x18000bd15 <numba_list_iter_next+0x365>
180003bd6:     	testq	%rax, %rax
180003bd9:     	je	0x180003c0b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4b>
180003bdb:     	leaq	0x1041e(%rip), %rdx     # 0x180014000
180003be2:     	leaq	0x9e17(%rip), %r8       # 0x18000da00
180003be9:     	leaq	0x9f00(%rip), %r9       # 0x18000daf0
180003bf0:     	movq	%rax, %rcx
180003bf3:     	movq	%rax, %rsi
180003bf6:     	callq	0x18000abf0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7030>
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
180003c57:     	movq	0x260(%rsp), %rbx
180003c5f:     	movq	$0x0, 0x150(%rsp)
180003c6b:     	movb	$0x0, 0x158(%rsp)
180003c73:     	movq	$0x0, 0x160(%rsp)
180003c7f:     	movq	$0x0, 0x130(%rsp)
180003c8b:     	movb	$0x0, 0x138(%rsp)
180003c93:     	movq	$0x0, 0x140(%rsp)
180003c9f:     	movsd	0x48(%rbx,%r13,8), %xmm0
180003ca6:     	xorpd	%xmm1, %xmm1
180003caa:     	ucomisd	%xmm1, %xmm0
180003cae:     	jne	0x180003cc7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x107>
180003cb0:     	jp	0x180003cc7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x107>
180003cb2:     	movb	$0x1, 0x18(%rcx)
180003cb6:     	movq	$0x0, 0x10(%rcx)
180003cbe:     	movb	$0x1, 0x8(%rcx)
180003cc2:     	jmp	0x180003eda <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31a>
180003cc7:     	movq	0x328(%rsp), %r12
180003ccf:     	movq	0x2a0(%rsp), %r15
180003cd7:     	movq	0x298(%rsp), %r14
180003cdf:     	movq	0x30(%r14,%r13,8), %rax
180003ce4:     	movq	%rax, %r10
180003ce7:     	sarq	$0x3f, %r10
180003ceb:     	andq	%r15, %r10
180003cee:     	leaq	(%r14,%rax,8), %rdx
180003cf2:     	cmpq	$0x1, (%rdx,%r10,8)
180003cf7:     	jne	0x180003d1a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x15a>
180003cf9:     	xorl	%r10d, %r10d
180003cfc:     	cmpq	$-0x2, %rax
180003d00:     	cmovlq	%r15, %r10
180003d04:     	movq	0x10(%rdx,%r10,8), %rax
180003d09:     	leaq	(%r14,%rax,8), %rdx
180003d0d:     	sarq	$0x3f, %rax
180003d11:     	andq	%r15, %rax
180003d14:     	cmpq	%r12, (%rdx,%rax,8)
180003d18:     	je	0x180003cb2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xf2>
180003d1a:     	movq	0x308(%rsp), %rdi
180003d22:     	movq	0x2d0(%rsp), %rsi
180003d2a:     	movq	0x10(%r14,%r13,8), %r10
180003d2f:     	movsd	(%rbx,%r10,8), %xmm1
180003d35:     	cmpq	$0x0, 0x8(%r14,%r10,8)
180003d3b:     	setne	%r11b
180003d3f:     	movq	0x10(%r14,%r12,8), %rdx
180003d44:     	cmpq	$0x0, 0x8(%r14,%rdx,8)
180003d4a:     	setne	%al
180003d4d:     	subsd	(%rbx,%rdx,8), %xmm1
180003d52:     	andb	%r11b, %al
180003d55:     	cmpb	$0x1, %al
180003d57:     	jne	0x180003d7b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1bb>
180003d59:     	movapd	0x965f(%rip), %xmm2     # 0x18000d3c0
180003d61:     	andpd	%xmm1, %xmm2
180003d65:     	ucomisd	0x9663(%rip), %xmm2     # 0x18000d3d0
180003d6d:     	jae	0x180003e21 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x261>
180003d73:     	xorpd	%xmm2, %xmm2
180003d77:     	addsd	%xmm2, %xmm1
180003d7b:     	movsd	0x10(%rbx,%r10,8), %xmm2
180003d82:     	cmpq	$0x0, 0x18(%r14,%r10,8)
180003d88:     	subsd	0x10(%rbx,%rdx,8), %xmm2
180003d8e:     	je	0x180003df8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x238>
180003d90:     	cmpq	$0x0, 0x18(%r14,%rdx,8)
180003d96:     	je	0x180003df8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x238>
180003d98:     	movapd	0x9620(%rip), %xmm3     # 0x18000d3c0
180003da0:     	andpd	%xmm2, %xmm3
180003da4:     	ucomisd	0x9624(%rip), %xmm3     # 0x18000d3d0
180003dac:     	jae	0x180003e65 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2a5>
180003db2:     	movapd	%xmm1, %xmm3
180003db6:     	mulsd	%xmm1, %xmm3
180003dba:     	ucomisd	0x960e(%rip), %xmm3     # 0x18000d3d0
180003dc2:     	setae	%dl
180003dc5:     	testb	%dl, %al
180003dc7:     	jne	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003dc9:     	xorpd	%xmm4, %xmm4
180003dcd:     	addsd	%xmm4, %xmm2
180003dd1:     	movapd	%xmm2, %xmm4
180003dd5:     	mulsd	%xmm2, %xmm4
180003dd9:     	ucomisd	0x95ef(%rip), %xmm4     # 0x18000d3d0
180003de1:     	jae	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003de3:     	addsd	%xmm4, %xmm3
180003de7:     	ucomisd	0x95e1(%rip), %xmm3     # 0x18000d3d0
180003def:     	setae	%dl
180003df2:     	testb	%dl, %al
180003df4:     	jne	0x180003e11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x251>
180003df6:     	jmp	0x180003e3d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x27d>
180003df8:     	movapd	%xmm1, %xmm3
180003dfc:     	mulsd	%xmm1, %xmm3
180003e00:     	ucomisd	0x95c8(%rip), %xmm3     # 0x18000d3d0
180003e08:     	setae	%dl
180003e0b:     	andb	%dl, %al
180003e0d:     	cmpb	$0x1, %al
180003e0f:     	jne	0x180003e31 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x271>
180003e11:     	movb	$0x1, (%rdi)
180003e14:     	movq	$0x3d090c, 0x18(%rsi)   # imm = 0x3D090C
180003e1c:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e21:     	movb	$0x1, (%rdi)
180003e24:     	movq	$0x3d090a, 0x18(%rsi)   # imm = 0x3D090A
180003e2c:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e31:     	movapd	%xmm2, %xmm4
180003e35:     	mulsd	%xmm2, %xmm4
180003e39:     	addsd	%xmm4, %xmm3
180003e3d:     	xorps	%xmm4, %xmm4
180003e40:     	sqrtsd	%xmm3, %xmm4
180003e44:     	cmpq	$0x0, 0x18(%r14,%r13,8)
180003e4a:     	je	0x180003e97 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2d7>
180003e4c:     	xorpd	%xmm5, %xmm5
180003e50:     	ucomisd	%xmm5, %xmm3
180003e54:     	jne	0x180003e72 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2b2>
180003e56:     	jp	0x180003e72 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2b2>
180003e58:     	movb	$0x1, (%rdi)
180003e5b:     	movq	$0x3d090f, 0x18(%rsi)   # imm = 0x3D090F
180003e63:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e65:     	movb	$0x1, (%rdi)
180003e68:     	movq	$0x3d090b, 0x18(%rsi)   # imm = 0x3D090B
180003e70:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180003e72:     	movsd	0x330(%rsp), %xmm6
180003e7b:     	movq	(%r14,%r13,8), %rax
180003e7f:     	movsd	0x8(%rbx,%rax,8), %xmm3
180003e85:     	addsd	%xmm3, %xmm3
180003e89:     	divsd	%xmm4, %xmm3
180003e8d:     	ucomisd	%xmm3, %xmm6
180003e91:     	jbe	0x180003f4a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x38a>
180003e97:     	movsd	0x9539(%rip), %xmm3     # 0x18000d3d8
180003e9f:     	maxsd	%xmm4, %xmm3
180003ea3:     	movapd	%xmm3, %xmm4
180003ea7:     	mulsd	%xmm3, %xmm4
180003eab:     	xorpd	%xmm5, %xmm5
180003eaf:     	ucomisd	%xmm5, %xmm4
180003eb3:     	jne	0x180003f10 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x350>
180003eb5:     	jp	0x180003f10 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x350>
180003eb7:     	movb	$0x1, (%rdi)
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
180003f10:     	movsd	0x8(%rbx,%r12,8), %xmm5
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
180003f48:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
180003f4a:     	movq	0x318(%rsp), %rdx
180003f52:     	movq	0x290(%rsp), %r11
180003f5a:     	movq	0x20(%r14,%r13,8), %rax
180003f5f:     	testq	%rax, %rax
180003f62:     	movb	$0x1, %bpl
180003f65:     	js	0x180004170 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5b0>
180003f6b:     	movq	0x8(%rsi), %rdx
180003f6f:     	leaq	0x1(%rdx), %r10
180003f73:     	movq	%r10, 0x8(%rsi)
180003f77:     	cmpq	0x10(%rsi), %rdx
180003f7b:     	jge	0x18000436a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7aa>
180003f81:     	movq	%rcx, %rbp
180003f84:     	movsd	%xmm6, 0x100(%rsp)
180003f8d:     	movq	%r12, 0xf8(%rsp)
180003f95:     	movq	%rax, 0xf0(%rsp)
180003f9d:     	movq	0x318(%rsp), %rax
180003fa5:     	movq	%rax, 0xe8(%rsp)
180003fad:     	movq	0x310(%rsp), %rax
180003fb5:     	movq	%rax, 0xe0(%rsp)
180003fbd:     	movq	%rdi, 0xd8(%rsp)
180003fc5:     	movq	0x300(%rsp), %rax
180003fcd:     	movq	%rax, 0xd0(%rsp)
180003fd5:     	movq	0x2f8(%rsp), %rax
180003fdd:     	movq	%rax, 0xc8(%rsp)
180003fe5:     	movq	0x2f0(%rsp), %rax
180003fed:     	movq	%rax, 0xc0(%rsp)
180003ff5:     	movq	0x2e8(%rsp), %rax
180003ffd:     	movq	%rax, 0xb8(%rsp)
180004005:     	movq	0x2e0(%rsp), %rax
18000400d:     	movq	%rax, 0xb0(%rsp)
180004015:     	movq	0x2d8(%rsp), %rax
18000401d:     	movq	%rax, 0xa8(%rsp)
180004025:     	movq	%rsi, 0xa0(%rsp)
18000402d:     	movq	0x2c8(%rsp), %rax
180004035:     	movq	%rax, 0x98(%rsp)
18000403d:     	movq	0x2c0(%rsp), %rax
180004045:     	movq	%rax, 0x90(%rsp)
18000404d:     	movq	0x2b8(%rsp), %rax
180004055:     	movq	%rax, 0x88(%rsp)
18000405d:     	movq	0x2b0(%rsp), %rax
180004065:     	movq	%rax, 0x80(%rsp)
18000406d:     	movq	0x2a8(%rsp), %rax
180004075:     	movq	%rax, 0x78(%rsp)
18000407a:     	movq	%r15, 0x70(%rsp)
18000407f:     	movq	%r14, 0x68(%rsp)
180004084:     	movq	%r11, 0x60(%rsp)
180004089:     	movq	0x288(%rsp), %rax
180004091:     	movq	%rax, 0x58(%rsp)
180004096:     	movq	0x280(%rsp), %rax
18000409e:     	movq	%rax, 0x50(%rsp)
1800040a3:     	movq	0x278(%rsp), %rax
1800040ab:     	movq	%rax, 0x48(%rsp)
1800040b0:     	movq	0x270(%rsp), %rax
1800040b8:     	movq	%rax, 0x40(%rsp)
1800040bd:     	movq	0x268(%rsp), %rax
1800040c5:     	movq	%rax, 0x38(%rsp)
1800040ca:     	movq	%rbx, 0x30(%rsp)
1800040cf:     	movq	0x258(%rsp), %rax
1800040d7:     	movq	%rax, 0x28(%rsp)
1800040dc:     	movq	0x250(%rsp), %rax
1800040e4:     	movq	%rax, 0x20(%rsp)
1800040e9:     	leaq	0x190(%rsp), %rcx
1800040f1:     	movq	%r8, 0x128(%rsp)
1800040f9:     	movq	%r9, 0x120(%rsp)
180004101:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
180004106:     	movzbl	0x198(%rsp), %ecx
18000410e:     	testb	%cl, %cl
180004110:     	setne	%r11b
180004114:     	cmpb	$0x0, (%rdi)
180004117:     	jne	0x180004345 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x785>
18000411d:     	movsd	0x1a0(%rsp), %xmm0
180004126:     	movzbl	0x1a8(%rsp), %eax
18000412e:     	movsd	0x190(%rsp), %xmm7
180004137:     	decq	0x8(%rsi)
18000413b:     	testb	%cl, %cl
18000413d:     	movq	%rbp, %rcx
180004140:     	je	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004146:     	movapd	0x9272(%rip), %xmm1     # 0x18000d3c0
18000414e:     	andpd	%xmm7, %xmm1
180004152:     	ucomisd	0x9276(%rip), %xmm1     # 0x18000d3d0
18000415a:     	jb	0x18000438a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ca>
180004160:     	movb	$0x1, (%rdi)
180004163:     	movq	$0x3d0922, 0x18(%rsi)   # imm = 0x3D0922
18000416b:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180004170:     	xorpd	%xmm7, %xmm7
180004174:     	movb	$0x1, %r11b
180004177:     	xorpd	%xmm8, %xmm8
18000417c:     	movq	0x28(%r14,%r13,8), %rax
180004181:     	testq	%rax, %rax
180004184:     	js	0x1800044d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x919>
18000418a:     	movq	0x8(%rsi), %rdx
18000418e:     	leaq	0x1(%rdx), %r10
180004192:     	movq	%r10, 0x8(%rsi)
180004196:     	cmpq	0x10(%rsi), %rdx
18000419a:     	jge	0x18000437a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7ba>
1800041a0:     	movb	%r11b, 0x117(%rsp)
1800041a8:     	movl	%ebp, 0x118(%rsp)
1800041af:     	movq	%rcx, %rbp
1800041b2:     	movsd	%xmm6, 0x100(%rsp)
1800041bb:     	movq	%r12, 0xf8(%rsp)
1800041c3:     	movq	%rax, 0xf0(%rsp)
1800041cb:     	movq	0x318(%rsp), %rax
1800041d3:     	movq	%rax, 0xe8(%rsp)
1800041db:     	movq	0x310(%rsp), %rax
1800041e3:     	movq	%rax, 0xe0(%rsp)
1800041eb:     	movq	%rdi, 0xd8(%rsp)
1800041f3:     	movq	0x300(%rsp), %rax
1800041fb:     	movq	%rax, 0xd0(%rsp)
180004203:     	movq	0x2f8(%rsp), %rax
18000420b:     	movq	%rax, 0xc8(%rsp)
180004213:     	movq	0x2f0(%rsp), %rax
18000421b:     	movq	%rax, 0xc0(%rsp)
180004223:     	movq	0x2e8(%rsp), %rax
18000422b:     	movq	%rax, 0xb8(%rsp)
180004233:     	movq	0x2e0(%rsp), %rax
18000423b:     	movq	%rax, 0xb0(%rsp)
180004243:     	movq	0x2d8(%rsp), %rax
18000424b:     	movq	%rax, 0xa8(%rsp)
180004253:     	movq	%rsi, 0xa0(%rsp)
18000425b:     	movq	0x2c8(%rsp), %rax
180004263:     	movq	%rax, 0x98(%rsp)
18000426b:     	movq	0x2c0(%rsp), %rax
180004273:     	movq	%rax, 0x90(%rsp)
18000427b:     	movq	0x2b8(%rsp), %rax
180004283:     	movq	%rax, 0x88(%rsp)
18000428b:     	movq	0x2b0(%rsp), %rax
180004293:     	movq	%rax, 0x80(%rsp)
18000429b:     	movq	0x2a8(%rsp), %rax
1800042a3:     	movq	%rax, 0x78(%rsp)
1800042a8:     	movq	%r15, 0x70(%rsp)
1800042ad:     	movq	%r14, 0x68(%rsp)
1800042b2:     	movq	0x290(%rsp), %rax
1800042ba:     	movq	%rax, 0x60(%rsp)
1800042bf:     	movq	0x288(%rsp), %rax
1800042c7:     	movq	%rax, 0x58(%rsp)
1800042cc:     	movq	0x280(%rsp), %rax
1800042d4:     	movq	%rax, 0x50(%rsp)
1800042d9:     	movq	0x278(%rsp), %rax
1800042e1:     	movq	%rax, 0x48(%rsp)
1800042e6:     	movq	0x270(%rsp), %rax
1800042ee:     	movq	%rax, 0x40(%rsp)
1800042f3:     	movq	0x268(%rsp), %rax
1800042fb:     	movq	%rax, 0x38(%rsp)
180004300:     	movq	%rbx, 0x30(%rsp)
180004305:     	movq	0x258(%rsp), %rax
18000430d:     	movq	%rax, 0x28(%rsp)
180004312:     	movq	0x250(%rsp), %rax
18000431a:     	movq	%rax, 0x20(%rsp)
18000431f:     	leaq	0x170(%rsp), %rcx
180004327:     	movq	%r8, 0x128(%rsp)
18000432f:     	movq	%r9, 0x120(%rsp)
180004337:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
18000433c:     	cmpb	$0x0, (%rdi)
18000433f:     	je	0x1800043e2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x822>
180004345:     	movq	$0x0, 0x18(%rbp)
18000434d:     	movq	$0x0, 0x10(%rbp)
180004355:     	movq	$0x0, 0x8(%rbp)
18000435d:     	movq	$0x0, (%rbp)
180004365:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
18000436a:     	movb	$0x1, (%rdi)
18000436d:     	movq	$0x3d0921, 0x18(%rsi)   # imm = 0x3D0921
180004375:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000437a:     	movb	$0x1, (%rdi)
18000437d:     	movq	$0x3d0926, 0x18(%rsi)   # imm = 0x3D0926
180004385:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000438a:     	xorpd	%xmm8, %xmm8
18000438f:     	addsd	%xmm8, %xmm7
180004394:     	testb	%al, %al
180004396:     	addsd	%xmm0, %xmm8
18000439b:     	je	0x1800044a0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x8e0>
1800043a1:     	andpd	0x9017(%rip), %xmm0     # 0x18000d3c0
1800043a9:     	ucomisd	0x901f(%rip), %xmm0     # 0x18000d3d0
1800043b1:     	movq	0x120(%rsp), %r9
1800043b9:     	movq	0x128(%rsp), %r8
1800043c1:     	movb	$0x1, %bpl
1800043c4:     	movq	0x318(%rsp), %rdx
1800043cc:     	jb	0x18000417c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5bc>
1800043d2:     	movb	$0x1, (%rdi)
1800043d5:     	movq	$0x3d0923, 0x18(%rsi)   # imm = 0x3D0923
1800043dd:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800043e2:     	movsd	0x180(%rsp), %xmm0
1800043eb:     	movzbl	0x188(%rsp), %eax
1800043f3:     	cmpb	$0x0, 0x178(%rsp)
1800043fb:     	setne	%cl
1800043fe:     	addsd	0x170(%rsp), %xmm7
180004407:     	decq	0x8(%rsi)
18000440b:     	movzbl	0x117(%rsp), %r11d
180004414:     	andb	%cl, %r11b
180004417:     	cmpb	$0x1, %r11b
18000441b:     	movq	%rbp, %rcx
18000441e:     	jne	0x180004446 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x886>
180004420:     	movapd	0x8f98(%rip), %xmm1     # 0x18000d3c0
180004428:     	andpd	%xmm7, %xmm1
18000442c:     	ucomisd	0x8f9c(%rip), %xmm1     # 0x18000d3d0
180004434:     	jb	0x180004446 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x886>
180004436:     	movb	$0x1, (%rdi)
180004439:     	movq	$0x3d0927, 0x18(%rsi)   # imm = 0x3D0927
180004441:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
180004446:     	addsd	%xmm0, %xmm8
18000444b:     	testb	%al, %al
18000444d:     	setne	%al
180004450:     	movl	0x118(%rsp), %edx
180004457:     	andb	%al, %dl
180004459:     	cmpb	$0x1, %dl
18000445c:     	jne	0x1800044bf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x8ff>
18000445e:     	movapd	0x8f5a(%rip), %xmm0     # 0x18000d3c0
180004466:     	andpd	%xmm8, %xmm0
18000446b:     	movb	$0x1, %bpl
18000446e:     	ucomisd	0x8f5a(%rip), %xmm0     # 0x18000d3d0
180004476:     	movq	0x120(%rsp), %r9
18000447e:     	movq	0x128(%rsp), %r8
180004486:     	movq	0x318(%rsp), %rdx
18000448e:     	jb	0x1800044d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x919>
180004490:     	movb	$0x1, (%rdi)
180004493:     	movq	$0x3d0928, 0x18(%rsi)   # imm = 0x3D0928
18000449b:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800044a0:     	xorl	%ebp, %ebp
1800044a2:     	movq	0x120(%rsp), %r9
1800044aa:     	movq	0x128(%rsp), %r8
1800044b2:     	movq	0x318(%rsp), %rdx
1800044ba:     	jmp	0x18000417c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5bc>
1800044bf:     	xorl	%ebp, %ebp
1800044c1:     	movq	0x120(%rsp), %r9
1800044c9:     	movq	0x128(%rsp), %r8
1800044d1:     	movq	0x318(%rsp), %rdx
1800044d9:     	movq	0x38(%r14,%r13,8), %rax
1800044de:     	testq	%rax, %rax
1800044e1:     	js	0x180004793 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbd3>
1800044e7:     	movq	0x8(%rsi), %rdx
1800044eb:     	leaq	0x1(%rdx), %r10
1800044ef:     	movq	%r10, 0x8(%rsi)
1800044f3:     	cmpq	0x10(%rsi), %rdx
1800044f7:     	jge	0x1800046c8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb08>
1800044fd:     	movb	%r11b, 0x117(%rsp)
180004505:     	movq	%rcx, 0x118(%rsp)
18000450d:     	movsd	%xmm6, 0x100(%rsp)
180004516:     	movq	%r12, 0xf8(%rsp)
18000451e:     	movq	%rax, 0xf0(%rsp)
180004526:     	movq	0x318(%rsp), %rax
18000452e:     	movq	%rax, 0xe8(%rsp)
180004536:     	movq	0x310(%rsp), %rax
18000453e:     	movq	%rax, 0xe0(%rsp)
180004546:     	movq	%rdi, 0xd8(%rsp)
18000454e:     	movq	0x300(%rsp), %rax
180004556:     	movq	%rax, 0xd0(%rsp)
18000455e:     	movq	0x2f8(%rsp), %rax
180004566:     	movq	%rax, 0xc8(%rsp)
18000456e:     	movq	0x2f0(%rsp), %rax
180004576:     	movq	%rax, 0xc0(%rsp)
18000457e:     	movq	0x2e8(%rsp), %rax
180004586:     	movq	%rax, 0xb8(%rsp)
18000458e:     	movq	0x2e0(%rsp), %rax
180004596:     	movq	%rax, 0xb0(%rsp)
18000459e:     	movq	0x2d8(%rsp), %rax
1800045a6:     	movq	%rax, 0xa8(%rsp)
1800045ae:     	movq	%rsi, 0xa0(%rsp)
1800045b6:     	movq	0x2c8(%rsp), %rax
1800045be:     	movq	%rax, 0x98(%rsp)
1800045c6:     	movq	0x2c0(%rsp), %rax
1800045ce:     	movq	%rax, 0x90(%rsp)
1800045d6:     	movq	0x2b8(%rsp), %rax
1800045de:     	movq	%rax, 0x88(%rsp)
1800045e6:     	movq	0x2b0(%rsp), %rax
1800045ee:     	movq	%rax, 0x80(%rsp)
1800045f6:     	movq	0x2a8(%rsp), %rax
1800045fe:     	movq	%rax, 0x78(%rsp)
180004603:     	movq	%r15, 0x70(%rsp)
180004608:     	movq	%r14, 0x68(%rsp)
18000460d:     	movq	0x290(%rsp), %rax
180004615:     	movq	%rax, 0x60(%rsp)
18000461a:     	movq	0x288(%rsp), %rax
180004622:     	movq	%rax, 0x58(%rsp)
180004627:     	movq	0x280(%rsp), %rax
18000462f:     	movq	%rax, 0x50(%rsp)
180004634:     	movq	0x278(%rsp), %rax
18000463c:     	movq	%rax, 0x48(%rsp)
180004641:     	movq	0x270(%rsp), %rax
180004649:     	movq	%rax, 0x40(%rsp)
18000464e:     	movq	0x268(%rsp), %rax
180004656:     	movq	%rax, 0x38(%rsp)
18000465b:     	movq	%rbx, 0x30(%rsp)
180004660:     	movq	0x258(%rsp), %rax
180004668:     	movq	%rax, 0x28(%rsp)
18000466d:     	movq	0x250(%rsp), %rax
180004675:     	movq	%rax, 0x20(%rsp)
18000467a:     	leaq	0x150(%rsp), %rcx
180004682:     	movq	%r8, 0x128(%rsp)
18000468a:     	movq	%r9, 0x120(%rsp)
180004692:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
180004697:     	cmpb	$0x0, (%rdi)
18000469a:     	je	0x1800046d8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb18>
18000469c:     	movq	0x118(%rsp), %rax
1800046a4:     	movq	$0x0, 0x18(%rax)
1800046ac:     	movq	$0x0, 0x10(%rax)
1800046b4:     	movq	$0x0, 0x8(%rax)
1800046bc:     	movq	$0x0, (%rax)
1800046c3:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
1800046c8:     	movb	$0x1, (%rdi)
1800046cb:     	movq	$0x3d092b, 0x18(%rsi)   # imm = 0x3D092B
1800046d3:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
1800046d8:     	movsd	0x160(%rsp), %xmm0
1800046e1:     	movzbl	0x168(%rsp), %eax
1800046e9:     	cmpb	$0x0, 0x158(%rsp)
1800046f1:     	setne	%cl
1800046f4:     	addsd	0x150(%rsp), %xmm7
1800046fd:     	decq	0x8(%rsi)
180004701:     	movzbl	0x117(%rsp), %r11d
18000470a:     	andb	%cl, %r11b
18000470d:     	cmpb	$0x1, %r11b
180004711:     	jne	0x180004735 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xb75>
180004713:     	movapd	0x8ca5(%rip), %xmm1     # 0x18000d3c0
18000471b:     	andpd	%xmm7, %xmm1
18000471f:     	ucomisd	0x8ca9(%rip), %xmm1     # 0x18000d3d0
180004727:     	jae	0x180004a16 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe56>
18000472d:     	xorpd	%xmm1, %xmm1
180004731:     	addsd	%xmm1, %xmm7
180004735:     	addsd	%xmm0, %xmm8
18000473a:     	testb	%al, %al
18000473c:     	setne	%al
18000473f:     	andb	%al, %bpl
180004742:     	cmpb	$0x1, %bpl
180004746:     	jne	0x180004771 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbb1>
180004748:     	movapd	0x8c70(%rip), %xmm0     # 0x18000d3c0
180004750:     	andpd	%xmm8, %xmm0
180004755:     	ucomisd	0x8c73(%rip), %xmm0     # 0x18000d3d0
18000475d:     	jae	0x180004a26 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe66>
180004763:     	xorpd	%xmm0, %xmm0
180004767:     	addsd	%xmm0, %xmm8
18000476c:     	movb	$0x1, %bpl
18000476f:     	jmp	0x180004773 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xbb3>
180004771:     	xorl	%ebp, %ebp
180004773:     	movq	0x118(%rsp), %rcx
18000477b:     	movq	0x120(%rsp), %r9
180004783:     	movq	0x128(%rsp), %r8
18000478b:     	movq	0x318(%rsp), %rdx
180004793:     	movq	0x40(%r14,%r13,8), %rax
180004798:     	testq	%rax, %rax
18000479b:     	js	0x180004a40 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe80>
1800047a1:     	movq	%rdx, %r13
1800047a4:     	movq	0x8(%rsi), %rdx
1800047a8:     	leaq	0x1(%rdx), %r10
1800047ac:     	movq	%r10, 0x8(%rsi)
1800047b0:     	cmpq	0x10(%rsi), %rdx
1800047b4:     	jge	0x18000496e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xdae>
1800047ba:     	movb	%r11b, 0x117(%rsp)
1800047c2:     	movq	%rcx, 0x118(%rsp)
1800047ca:     	movq	%r12, 0xf8(%rsp)
1800047d2:     	movq	%rax, 0xf0(%rsp)
1800047da:     	movq	%r13, 0xe8(%rsp)
1800047e2:     	movq	0x310(%rsp), %rax
1800047ea:     	movq	%rax, 0xe0(%rsp)
1800047f2:     	movq	0x300(%rsp), %rax
1800047fa:     	movq	%rax, 0xd0(%rsp)
180004802:     	movq	0x2f8(%rsp), %rax
18000480a:     	movq	%rax, 0xc8(%rsp)
180004812:     	movq	0x2f0(%rsp), %rax
18000481a:     	movq	%rax, 0xc0(%rsp)
180004822:     	movq	0x2e8(%rsp), %rax
18000482a:     	movq	%rax, 0xb8(%rsp)
180004832:     	movq	0x2e0(%rsp), %rax
18000483a:     	movq	%rax, 0xb0(%rsp)
180004842:     	movq	0x2d8(%rsp), %rax
18000484a:     	movq	%rax, 0xa8(%rsp)
180004852:     	movq	0x2c8(%rsp), %rax
18000485a:     	movq	%rax, 0x98(%rsp)
180004862:     	movq	0x2c0(%rsp), %rax
18000486a:     	movq	%rax, 0x90(%rsp)
180004872:     	movq	0x2b8(%rsp), %rax
18000487a:     	movq	%rax, 0x88(%rsp)
180004882:     	movq	0x2b0(%rsp), %rax
18000488a:     	movq	%rax, 0x80(%rsp)
180004892:     	movq	0x2a8(%rsp), %rax
18000489a:     	movq	%rax, 0x78(%rsp)
18000489f:     	movq	%r15, 0x70(%rsp)
1800048a4:     	movq	%r14, 0x68(%rsp)
1800048a9:     	movq	0x290(%rsp), %rax
1800048b1:     	movq	%rax, 0x60(%rsp)
1800048b6:     	movq	0x288(%rsp), %rax
1800048be:     	movq	%rax, 0x58(%rsp)
1800048c3:     	movq	0x280(%rsp), %rax
1800048cb:     	movq	%rax, 0x50(%rsp)
1800048d0:     	movq	0x278(%rsp), %rax
1800048d8:     	movq	%rax, 0x48(%rsp)
1800048dd:     	movq	0x270(%rsp), %rax
1800048e5:     	movq	%rax, 0x40(%rsp)
1800048ea:     	movq	0x268(%rsp), %rax
1800048f2:     	movq	%rax, 0x38(%rsp)
1800048f7:     	movq	%rbx, 0x30(%rsp)
1800048fc:     	movq	0x258(%rsp), %rax
180004904:     	movq	%rax, 0x28(%rsp)
180004909:     	movsd	%xmm6, 0x100(%rsp)
180004912:     	movq	%rdi, 0xd8(%rsp)
18000491a:     	movq	%rsi, 0xa0(%rsp)
180004922:     	movq	0x250(%rsp), %rax
18000492a:     	movq	%rax, 0x20(%rsp)
18000492f:     	leaq	0x130(%rsp), %rcx
180004937:     	callq	0x180003c20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x60>
18000493c:     	cmpb	$0x0, (%rdi)
18000493f:     	je	0x18000497e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xdbe>
180004941:     	movq	0x118(%rsp), %r13
180004949:     	movq	$0x0, 0x18(%r13)
180004951:     	movq	$0x0, 0x10(%r13)
180004959:     	movq	$0x0, 0x8(%r13)
180004961:     	movq	$0x0, (%r13)
180004969:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
18000496e:     	movb	$0x1, (%rdi)
180004971:     	movq	$0x3d0930, 0x18(%rsi)   # imm = 0x3D0930
180004979:     	jmp	0x180003ec2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x302>
18000497e:     	movsd	0x140(%rsp), %xmm0
180004987:     	movzbl	0x148(%rsp), %eax
18000498f:     	cmpb	$0x0, 0x138(%rsp)
180004997:     	setne	%cl
18000499a:     	addsd	0x130(%rsp), %xmm7
1800049a3:     	decq	0x8(%rsi)
1800049a7:     	movzbl	0x117(%rsp), %r13d
1800049b0:     	andb	%cl, %r13b
1800049b3:     	movl	%r13d, %r11d
1800049b6:     	cmpb	$0x1, %r13b
1800049ba:     	jne	0x1800049de <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe1e>
1800049bc:     	movapd	0x89fc(%rip), %xmm1     # 0x18000d3c0
1800049c4:     	andpd	%xmm7, %xmm1
1800049c8:     	ucomisd	0x8a00(%rip), %xmm1     # 0x18000d3d0
1800049d0:     	jae	0x180004a57 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe97>
1800049d6:     	xorpd	%xmm1, %xmm1
1800049da:     	addsd	%xmm1, %xmm7
1800049de:     	testb	%al, %al
1800049e0:     	setne	%al
1800049e3:     	addsd	%xmm0, %xmm8
1800049e8:     	andb	%al, %bpl
1800049eb:     	cmpb	$0x1, %bpl
1800049ef:     	jne	0x180004a36 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe76>
1800049f1:     	movapd	0x89c7(%rip), %xmm0     # 0x18000d3c0
1800049f9:     	andpd	%xmm8, %xmm0
1800049fe:     	ucomisd	0x89ca(%rip), %xmm0     # 0x18000d3d0
180004a06:     	jae	0x180004a67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xea7>
180004a08:     	xorpd	%xmm0, %xmm0
180004a0c:     	addsd	%xmm0, %xmm8
180004a11:     	movb	$0x1, %bpl
180004a14:     	jmp	0x180004a38 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xe78>
180004a16:     	movb	$0x1, (%rdi)
180004a19:     	movq	$0x3d092c, 0x18(%rsi)   # imm = 0x3D092C
180004a21:     	jmp	0x18000469c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xadc>
180004a26:     	movb	$0x1, (%rdi)
180004a29:     	movq	$0x3d092d, 0x18(%rsi)   # imm = 0x3D092D
180004a31:     	jmp	0x18000469c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xadc>
180004a36:     	xorl	%ebp, %ebp
180004a38:     	movq	0x118(%rsp), %rcx
180004a40:     	movb	%bpl, 0x18(%rcx)
180004a44:     	movsd	%xmm8, 0x10(%rcx)
180004a4a:     	movb	%r11b, 0x8(%rcx)
180004a4e:     	movsd	%xmm7, (%rcx)
180004a52:     	jmp	0x180003ee1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x321>
180004a57:     	movb	$0x1, (%rdi)
180004a5a:     	movq	$0x3d0931, 0x18(%rsi)   # imm = 0x3D0931
180004a62:     	jmp	0x180004941 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xd81>
180004a67:     	movb	$0x1, (%rdi)
180004a6a:     	movq	$0x3d0932, 0x18(%rsi)   # imm = 0x3D0932
180004a72:     	jmp	0x180004941 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xd81>
180004a77:     	nopw	(%rax,%rax)
180004a80:     	pushq	%r15
180004a82:     	pushq	%r14
180004a84:     	pushq	%r13
180004a86:     	pushq	%r12
180004a88:     	pushq	%rsi
180004a89:     	pushq	%rdi
180004a8a:     	pushq	%rbp
180004a8b:     	pushq	%rbx
180004a8c:     	subq	$0x178, %rsp            # imm = 0x178
180004a93:     	movq	0x2b0(%rsp), %rax
180004a9b:     	movq	0x298(%rsp), %r13
180004aa3:     	movq	0x260(%rsp), %rbp
180004aab:     	movq	0x258(%rsp), %rdi
180004ab3:     	movb	$0x0, 0x137(%rsp)
180004abb:     	movb	$0x0, 0x127(%rsp)
180004ac3:     	movb	$0x0, 0x126(%rsp)
180004acb:     	movb	$0x0, 0x125(%rsp)
180004ad3:     	movb	$0x0, 0x124(%rsp)
180004adb:     	movb	$0x0, 0x136(%rsp)
180004ae3:     	movb	$0x0, 0x135(%rsp)
180004aeb:     	movb	$0x0, 0x134(%rsp)
180004af3:     	movb	$0x0, 0x133(%rsp)
180004afb:     	cmpq	$0x1, %rax
180004aff:     	movq	0x230(%rsp), %r15
180004b07:     	movq	0x228(%rsp), %rbx
180004b0f:     	movq	0x1f0(%rsp), %r14
180004b17:     	je	0x180004cb2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x10f2>
180004b1d:     	testq	%rax, %rax
180004b20:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004b26:     	movq	0x2c0(%rsp), %rsi
180004b2e:     	movq	0x2b8(%rsp), %rdi
180004b36:     	movq	(%rbx,%rdi,8), %rax
180004b3a:     	movq	0x10(%rbx,%rsi,8), %rdx
180004b3f:     	movsd	(%r14,%rdx,8), %xmm0
180004b45:     	movsd	0x8(%r14,%rax,8), %xmm2
180004b4c:     	movsd	0x10(%r14,%rax,8), %xmm1
180004b53:     	movapd	%xmm1, %xmm3
180004b57:     	subsd	%xmm2, %xmm3
180004b5b:     	xorl	%r12d, %r12d
180004b5e:     	ucomisd	%xmm3, %xmm0
180004b62:     	jb	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180004b68:     	addsd	%xmm2, %xmm1
180004b6c:     	ucomisd	%xmm0, %xmm1
180004b70:     	jbe	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180004b76:     	movsd	0x10(%r14,%rdx,8), %xmm0
180004b7d:     	movsd	(%r14,%rax,8), %xmm2
180004b83:     	movsd	0x18(%r14,%rax,8), %xmm1
180004b8a:     	movapd	%xmm1, %xmm3
180004b8e:     	subsd	%xmm2, %xmm3
180004b92:     	ucomisd	%xmm3, %xmm0
180004b96:     	jb	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004b9c:     	addsd	%xmm2, %xmm1
180004ba0:     	xorl	%r12d, %r12d
180004ba3:     	ucomisd	%xmm0, %xmm1
180004ba7:     	jbe	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180004bad:     	cmpb	$0x0, (%r13)
180004bb2:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180004bb8:     	movq	0x18(%rbx,%rdi,8), %r12
180004bbd:     	movq	0x30(%rbx,%rdi,8), %rdx
180004bc2:     	movq	%rdx, %r11
180004bc5:     	sarq	$0x3f, %r11
180004bc9:     	andq	%r15, %r11
180004bcc:     	leaq	(%rbx,%rdx,8), %rax
180004bd0:     	movq	(%rax,%r11,8), %r10
180004bd4:     	cmpq	0x8(%rbx,%rdi,8), %r10
180004bd9:     	jge	0x180004ed0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1310>
180004bdf:     	testq	%r12, %r12
180004be2:     	jne	0x180004ed9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1319>
180004be8:     	xorl	%r9d, %r9d
180004beb:     	cmpq	$-0x1, %rdx
180004bef:     	cmovlq	%r15, %r9
180004bf3:     	cmpq	0x8(%rax,%r9,8), %r10
180004bf8:     	jne	0x18000576d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1bad>
180004bfe:     	leaq	(%r10,%r10), %r8
180004c02:     	testq	%r10, %r10
180004c05:     	movl	$0x4, %eax
180004c0a:     	cmovneq	%r8, %rax
180004c0e:     	movq	(%rbp), %r12
180004c12:     	leaq	(%r12,%rax), %r8
180004c16:     	cmpq	%r15, %r8
180004c19:     	jg	0x180004cbf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x10ff>
180004c1f:     	movq	%r8, (%rbp)
180004c23:     	cmpb	$0x0, (%r13)
180004c28:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004c2e:     	movq	%r12, 0x128(%rsp)
180004c36:     	movq	%rax, 0x168(%rsp)
180004c3e:     	movq	%r9, 0x170(%rsp)
180004c46:     	xorl	%eax, %eax
180004c48:     	movq	%rdx, 0x158(%rsp)
180004c50:     	cmpq	$-0x2, %rdx
180004c54:     	cmovlq	%r15, %rax
180004c58:     	movq	%rax, 0x140(%rsp)
180004c60:     	movq	%r10, 0x148(%rsp)
180004c68:     	testq	%r10, %r10
180004c6b:     	jle	0x18000572f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1b6f>
180004c71:     	movq	0x158(%rsp), %rax
180004c79:     	leaq	(%rbx,%rax,8), %rax
180004c7d:     	movq	0x140(%rsp), %r8
180004c85:     	movq	0x10(%rax,%r8,8), %r9
180004c8a:     	movq	0x148(%rsp), %rax
180004c92:     	movl	%eax, %r10d
180004c95:     	andl	$0x7, %r10d
180004c99:     	cmpq	$0x7, %rax
180004c9d:     	ja	0x1800054fe <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x193e>
180004ca3:     	leaq	(,%r15,8), %r12
180004cab:     	xorl	%edx, %edx
180004cad:     	jmp	0x1800056ed <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1b2d>
180004cb2:     	movq	(%rbp), %rdx
180004cb6:     	leaq	0x4(%rdx), %rax
180004cba:     	cmpq	%r15, %rax
180004cbd:     	jle	0x180004cc9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1109>
180004cbf:     	movb	$0x2, (%r13)
180004cc4:     	jmp	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004cc9:     	movq	0x2c8(%rsp), %rsi
180004cd1:     	movq	(%rbx,%rsi,8), %r10
180004cd5:     	movsd	0x10(%r14,%r10,8), %xmm1
180004cdc:     	movsd	0x18(%r14,%r10,8), %xmm2
180004ce3:     	movsd	0x86c5(%rip), %xmm0     # 0x18000d3b0
180004ceb:     	movsd	0x8(%r14,%r10,8), %xmm3
180004cf2:     	mulsd	%xmm0, %xmm3
180004cf6:     	mulsd	(%r14,%r10,8), %xmm0
180004cfc:     	movq	%rax, (%rbp)
180004d00:     	cmpb	$0x0, (%r13)
180004d05:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004d0b:     	movapd	%xmm1, %xmm4
180004d0f:     	addsd	%xmm3, %xmm4
180004d13:     	movapd	%xmm2, %xmm5
180004d17:     	subsd	%xmm0, %xmm5
180004d1b:     	movsd	%xmm4, 0x10(%r14,%rdx,8)
180004d22:     	movsd	%xmm5, 0x18(%r14,%rdx,8)
180004d29:     	movsd	%xmm3, 0x8(%r14,%rdx,8)
180004d30:     	movsd	%xmm0, (%r14,%rdx,8)
180004d36:     	cmpb	$0x0, (%r13)
180004d3b:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004d41:     	movq	(%rbp), %rax
180004d45:     	leaq	0xb(%rax), %r11
180004d49:     	cmpq	%r15, %r11
180004d4c:     	jg	0x180004cbf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x10ff>
180004d52:     	movq	0x8(%rbx,%rsi,8), %r10
180004d57:     	movq	%r11, (%rbp)
180004d5b:     	cmpb	$0x0, (%r13)
180004d60:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004d66:     	movq	%rdx, (%rbx,%rax,8)
180004d6a:     	movq	%r10, 0x8(%rbx,%rax,8)
180004d6f:     	movq	(%rbp), %rdx
180004d73:     	cmpq	%r15, %rdx
180004d76:     	movq	%rdx, %r10
180004d79:     	jle	0x180004d87 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x11c7>
180004d7b:     	movb	$0x2, (%r13)
180004d80:     	movq	(%rbp), %rdx
180004d84:     	xorl	%r10d, %r10d
180004d87:     	leaq	0x3(%rdx), %r11
180004d8b:     	cmpq	%r15, %r11
180004d8e:     	jg	0x180004cbf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x10ff>
180004d94:     	movq	%r11, (%rbp)
180004d98:     	cmpb	$0x0, (%r13)
180004d9d:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004da3:     	movq	%rdx, %r11
180004da6:     	sarq	$0x3f, %r11
180004daa:     	andq	%r15, %r11
180004dad:     	leaq	(%rbx,%rdx,8), %rsi
180004db1:     	movq	$0x0, (%rsi,%r11,8)
180004db9:     	xorl	%r12d, %r12d
180004dbc:     	cmpq	$-0x1, %rdx
180004dc0:     	movl	$0x0, %r11d
180004dc6:     	cmovlq	%r15, %r11
180004dca:     	movq	$0x0, 0x8(%rsi,%r11,8)
180004dd3:     	cmpq	$-0x2, %rdx
180004dd7:     	movl	$0x0, %r11d
180004ddd:     	cmovlq	%r15, %r11
180004de1:     	movq	%r10, 0x10(%rsi,%r11,8)
180004de6:     	cmpb	$0x0, (%r13)
180004deb:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180004df1:     	leaq	(%rbx,%rax,8), %r10
180004df5:     	movq	%rdx, 0x30(%r10)
180004df9:     	movq	$0x0, 0x18(%r10)
180004e01:     	movq	(%rbp), %rdx
180004e05:     	leaq	0x4(%rdx), %r11
180004e09:     	cmpq	%r15, %r11
180004e0c:     	jg	0x180004cbf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x10ff>
180004e12:     	movq	%r11, (%rbp)
180004e16:     	cmpb	$0x0, (%r13)
180004e1b:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180004e21:     	movq	%r8, 0x128(%rsp)
180004e29:     	movq	%r9, 0x138(%rsp)
180004e31:     	movq	%rcx, 0x118(%rsp)
180004e39:     	movq	$0x0, (%r14,%rdx,8)
180004e41:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180004e4a:     	movq	$0x0, 0x10(%r14,%rdx,8)
180004e53:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180004e5c:     	cmpb	$0x0, (%r13)
180004e61:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180004e67:     	movq	%r13, %rsi
180004e6a:     	movq	%rdx, 0x10(%r10)
180004e6e:     	movq	$0x0, 0x48(%r14,%rax,8)
180004e77:     	movq	$0x1, 0x50(%r10)
180004e7f:     	movq	$-0x1, 0x20(%r10)
180004e87:     	movq	$-0x1, 0x28(%r10)
180004e8f:     	movq	$-0x1, 0x38(%r10)
180004e97:     	movq	$-0x1, 0x40(%r10)
180004e9f:     	cmpb	$0x0, (%r13)
180004ea4:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180004eaa:     	movq	0x2c8(%rsp), %rcx
180004eb2:     	movq	%rax, 0x20(%rbx,%rcx,8)
180004eb7:     	movq	(%rbp), %rcx
180004ebb:     	leaq	0x4(%rcx), %rax
180004ebf:     	cmpq	%r15, %rax
180004ec2:     	jle	0x180005b13 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1f53>
180004ec8:     	movb	$0x2, (%rsi)
180004ecb:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180004ed0:     	testq	%r12, %r12
180004ed3:     	je	0x180005100 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1540>
180004ed9:     	movq	0x20(%rbx,%rdi,8), %rax
180004ede:     	testq	%rax, %rax
180004ee1:     	js	0x1800052fe <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x173e>
180004ee7:     	movq	0x8(%rbp), %rdx
180004eeb:     	leaq	0x1(%rdx), %r10
180004eef:     	movq	%r10, 0x8(%rbp)
180004ef3:     	cmpq	0x10(%rbp), %rdx
180004ef7:     	jge	0x1800052fe <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x173e>
180004efd:     	movq	%rcx, 0x118(%rsp)
180004f05:     	movb	$0x0, 0x127(%rsp)
180004f0d:     	movq	%rsi, 0x100(%rsp)
180004f15:     	movq	%rax, 0xf8(%rsp)
180004f1d:     	movq	0x2a8(%rsp), %rax
180004f25:     	movq	%rax, 0xe8(%rsp)
180004f2d:     	movq	0x2a0(%rsp), %rax
180004f35:     	movq	%rax, 0xe0(%rsp)
180004f3d:     	movq	%r13, 0xd8(%rsp)
180004f45:     	movq	0x290(%rsp), %rax
180004f4d:     	movq	%rax, 0xd0(%rsp)
180004f55:     	movq	0x288(%rsp), %rax
180004f5d:     	movq	%rax, 0xc8(%rsp)
180004f65:     	movq	0x280(%rsp), %rax
180004f6d:     	movq	%rax, 0xc0(%rsp)
180004f75:     	movq	0x278(%rsp), %rax
180004f7d:     	movq	%rax, 0xb8(%rsp)
180004f85:     	movq	0x270(%rsp), %rax
180004f8d:     	movq	%rax, 0xb0(%rsp)
180004f95:     	movq	0x268(%rsp), %rax
180004f9d:     	movq	%rax, 0xa8(%rsp)
180004fa5:     	movq	%rbp, 0xa0(%rsp)
180004fad:     	movq	0x258(%rsp), %rax
180004fb5:     	movq	%rax, 0x98(%rsp)
180004fbd:     	movq	0x250(%rsp), %rax
180004fc5:     	movq	%rax, 0x90(%rsp)
180004fcd:     	movq	0x248(%rsp), %rax
180004fd5:     	movq	%rax, 0x88(%rsp)
180004fdd:     	movq	0x240(%rsp), %rax
180004fe5:     	movq	%rax, 0x80(%rsp)
180004fed:     	movq	0x238(%rsp), %rax
180004ff5:     	movq	%rax, 0x78(%rsp)
180004ffa:     	movq	%r15, 0x70(%rsp)
180004fff:     	movq	%rbx, 0x68(%rsp)
180005004:     	movq	0x220(%rsp), %rax
18000500c:     	movq	%rax, 0x60(%rsp)
180005011:     	movq	0x218(%rsp), %rax
180005019:     	movq	%rax, 0x58(%rsp)
18000501e:     	movq	0x210(%rsp), %rax
180005026:     	movq	%rax, 0x50(%rsp)
18000502b:     	movq	0x208(%rsp), %rax
180005033:     	movq	%rax, 0x48(%rsp)
180005038:     	movq	0x200(%rsp), %rax
180005040:     	movq	%rax, 0x40(%rsp)
180005045:     	movq	0x1f8(%rsp), %rax
18000504d:     	movq	%rax, 0x38(%rsp)
180005052:     	movq	%r14, 0x30(%rsp)
180005057:     	movq	0x1e8(%rsp), %rax
18000505f:     	movq	%rax, 0x28(%rsp)
180005064:     	movq	0x1e0(%rsp), %rax
18000506c:     	movq	%rax, 0x20(%rsp)
180005071:     	movq	$-0x1, 0x108(%rsp)
18000507d:     	movq	$0x0, 0xf0(%rsp)
180005089:     	leaq	0x127(%rsp), %rcx
180005091:     	movq	%r8, 0x128(%rsp)
180005099:     	movq	%r9, 0x138(%rsp)
1800050a1:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800050a6:     	cmpb	$0x0, (%r13)
1800050ab:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800050b1:     	movq	0x8(%rbp), %rdx
1800050b5:     	leaq	-0x1(%rdx), %rax
1800050b9:     	cmpb	$0x0, 0x127(%rsp)
1800050c1:     	movq	%rax, 0x8(%rbp)
1800050c5:     	movb	$0x1, %r12b
1800050c8:     	movq	0x118(%rsp), %rcx
1800050d0:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
1800050d6:     	movq	0x28(%rbx,%rdi,8), %rax
1800050db:     	testq	%rax, %rax
1800050de:     	js	0x1800050ee <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x152e>
1800050e0:     	movq	%rdx, 0x8(%rbp)
1800050e4:     	cmpq	0x10(%rbp), %rdx
1800050e8:     	jle	0x18000532b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x176b>
1800050ee:     	movb	$0x1, (%r13)
1800050f3:     	movq	$0x2dc6ce, 0x18(%rbp)   # imm = 0x2DC6CE
1800050fb:     	jmp	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180005100:     	movq	0x8(%rbp), %rax
180005104:     	leaq	0x1(%rax), %rdx
180005108:     	movq	%rdx, 0x8(%rbp)
18000510c:     	cmpq	0x10(%rbp), %rax
180005110:     	jge	0x1800052ca <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x170a>
180005116:     	movq	%rcx, 0x118(%rsp)
18000511e:     	movq	%rdi, 0x108(%rsp)
180005126:     	movq	0x2a8(%rsp), %rax
18000512e:     	movq	%rax, 0xe8(%rsp)
180005136:     	movq	0x2a0(%rsp), %rax
18000513e:     	movq	%rax, 0xe0(%rsp)
180005146:     	movq	%r13, 0xd8(%rsp)
18000514e:     	movq	0x290(%rsp), %rax
180005156:     	movq	%rax, 0xd0(%rsp)
18000515e:     	movq	0x288(%rsp), %rax
180005166:     	movq	%rax, 0xc8(%rsp)
18000516e:     	movq	0x280(%rsp), %rax
180005176:     	movq	%rax, 0xc0(%rsp)
18000517e:     	movq	0x278(%rsp), %rax
180005186:     	movq	%rax, 0xb8(%rsp)
18000518e:     	movq	0x270(%rsp), %rax
180005196:     	movq	%rax, 0xb0(%rsp)
18000519e:     	movq	0x268(%rsp), %rax
1800051a6:     	movq	%rax, 0xa8(%rsp)
1800051ae:     	movq	%rbp, 0xa0(%rsp)
1800051b6:     	movq	0x258(%rsp), %rax
1800051be:     	movq	%rax, 0x98(%rsp)
1800051c6:     	movq	0x250(%rsp), %rax
1800051ce:     	movq	%rax, 0x90(%rsp)
1800051d6:     	movq	0x248(%rsp), %rax
1800051de:     	movq	%rax, 0x88(%rsp)
1800051e6:     	movq	0x240(%rsp), %rax
1800051ee:     	movq	%rax, 0x80(%rsp)
1800051f6:     	movq	0x238(%rsp), %rax
1800051fe:     	movq	%rax, 0x78(%rsp)
180005203:     	movq	%r15, 0x70(%rsp)
180005208:     	movq	%rbx, 0x68(%rsp)
18000520d:     	movq	0x220(%rsp), %rax
180005215:     	movq	%rax, 0x60(%rsp)
18000521a:     	movq	0x218(%rsp), %rax
180005222:     	movq	%rax, 0x58(%rsp)
180005227:     	movq	0x210(%rsp), %rax
18000522f:     	movq	%rax, 0x50(%rsp)
180005234:     	movq	0x208(%rsp), %rax
18000523c:     	movq	%rax, 0x48(%rsp)
180005241:     	movq	0x200(%rsp), %rax
180005249:     	movq	%rax, 0x40(%rsp)
18000524e:     	movq	0x1f8(%rsp), %rax
180005256:     	movq	%rax, 0x38(%rsp)
18000525b:     	movq	%r14, 0x30(%rsp)
180005260:     	movq	0x1e8(%rsp), %rax
180005268:     	movq	%rax, 0x28(%rsp)
18000526d:     	movq	0x1e0(%rsp), %rax
180005275:     	movq	%rax, 0x20(%rsp)
18000527a:     	movq	$-0x1, 0x100(%rsp)
180005286:     	movq	$-0x1, 0xf8(%rsp)
180005292:     	movq	$0x1, 0xf0(%rsp)
18000529e:     	leaq	0x137(%rsp), %rcx
1800052a6:     	movq	%r8, 0x128(%rsp)
1800052ae:     	movq	%r9, %r12
1800052b1:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800052b6:     	cmpb	$0x0, (%r13)
1800052bb:     	je	0x1800052d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1719>
1800052bd:     	xorl	%r12d, %r12d
1800052c0:     	movq	0x118(%rsp), %rcx
1800052c8:     	jmp	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
1800052ca:     	movb	$0x1, (%r13)
1800052cf:     	movq	$0x2dc6cb, 0x18(%rbp)   # imm = 0x2DC6CB
1800052d7:     	jmp	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
1800052d9:     	decq	0x8(%rbp)
1800052dd:     	movq	0x118(%rsp), %rcx
1800052e5:     	movq	%r12, %r9
1800052e8:     	movq	0x128(%rsp), %r8
1800052f0:     	movq	0x20(%rbx,%rdi,8), %rax
1800052f5:     	testq	%rax, %rax
1800052f8:     	jns	0x180004ee7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1327>
1800052fe:     	movb	$0x1, (%r13)
180005303:     	movq	$0x2dc6cd, 0x18(%rbp)   # imm = 0x2DC6CD
18000530b:     	xorl	%r12d, %r12d
18000530e:     	andb	$0x1, %r12b
180005312:     	movb	%r12b, (%rcx)
180005315:     	xorl	%eax, %eax
180005317:     	addq	$0x178, %rsp            # imm = 0x178
18000531e:     	popq	%rbx
18000531f:     	popq	%rbp
180005320:     	popq	%rdi
180005321:     	popq	%rsi
180005322:     	popq	%r12
180005324:     	popq	%r13
180005326:     	popq	%r14
180005328:     	popq	%r15
18000532a:     	retq
18000532b:     	movb	$0x0, 0x126(%rsp)
180005333:     	movq	%rsi, 0x100(%rsp)
18000533b:     	movq	%rax, 0xf8(%rsp)
180005343:     	movq	0x2a8(%rsp), %rax
18000534b:     	movq	%rax, 0xe8(%rsp)
180005353:     	movq	0x2a0(%rsp), %rax
18000535b:     	movq	%rax, 0xe0(%rsp)
180005363:     	movq	%r13, 0xd8(%rsp)
18000536b:     	movq	0x290(%rsp), %rax
180005373:     	movq	%rax, 0xd0(%rsp)
18000537b:     	movq	0x288(%rsp), %rax
180005383:     	movq	%rax, 0xc8(%rsp)
18000538b:     	movq	0x280(%rsp), %rax
180005393:     	movq	%rax, 0xc0(%rsp)
18000539b:     	movq	0x278(%rsp), %rax
1800053a3:     	movq	%rax, 0xb8(%rsp)
1800053ab:     	movq	0x270(%rsp), %rax
1800053b3:     	movq	%rax, 0xb0(%rsp)
1800053bb:     	movq	0x268(%rsp), %rax
1800053c3:     	movq	%rax, 0xa8(%rsp)
1800053cb:     	movq	%rbp, 0xa0(%rsp)
1800053d3:     	movq	0x258(%rsp), %rax
1800053db:     	movq	%rax, 0x98(%rsp)
1800053e3:     	movq	0x250(%rsp), %rax
1800053eb:     	movq	%rax, 0x90(%rsp)
1800053f3:     	movq	0x248(%rsp), %rax
1800053fb:     	movq	%rax, 0x88(%rsp)
180005403:     	movq	0x240(%rsp), %rax
18000540b:     	movq	%rax, 0x80(%rsp)
180005413:     	movq	0x238(%rsp), %rax
18000541b:     	movq	%rax, 0x78(%rsp)
180005420:     	movq	%r15, 0x70(%rsp)
180005425:     	movq	%rbx, 0x68(%rsp)
18000542a:     	movq	0x220(%rsp), %rax
180005432:     	movq	%rax, 0x60(%rsp)
180005437:     	movq	0x218(%rsp), %rax
18000543f:     	movq	%rax, 0x58(%rsp)
180005444:     	movq	0x210(%rsp), %rax
18000544c:     	movq	%rax, 0x50(%rsp)
180005451:     	movq	0x208(%rsp), %rax
180005459:     	movq	%rax, 0x48(%rsp)
18000545e:     	movq	0x200(%rsp), %rax
180005466:     	movq	%rax, 0x40(%rsp)
18000546b:     	movq	0x1f8(%rsp), %rax
180005473:     	movq	%rax, 0x38(%rsp)
180005478:     	movq	%r14, 0x30(%rsp)
18000547d:     	movq	0x1e8(%rsp), %rax
180005485:     	movq	%rax, 0x28(%rsp)
18000548a:     	movq	0x1e0(%rsp), %rax
180005492:     	movq	%rax, 0x20(%rsp)
180005497:     	movq	$-0x1, 0x108(%rsp)
1800054a3:     	movq	$0x0, 0xf0(%rsp)
1800054af:     	leaq	0x126(%rsp), %rcx
1800054b7:     	movq	0x128(%rsp), %r8
1800054bf:     	movq	0x138(%rsp), %r9
1800054c7:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800054cc:     	cmpb	$0x0, (%r13)
1800054d1:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800054d7:     	movq	0x8(%rbp), %rcx
1800054db:     	leaq	-0x1(%rcx), %rax
1800054df:     	cmpb	$0x0, 0x126(%rsp)
1800054e7:     	movq	%rax, 0x8(%rbp)
1800054eb:     	je	0x1800058cf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1d0f>
1800054f1:     	movq	0x118(%rsp), %rcx
1800054f9:     	jmp	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
1800054fe:     	movq	%r10, 0x160(%rsp)
180005506:     	movabsq	$0x7ffffffffffffff8, %rdx # imm = 0x7FFFFFFFFFFFFFF8
180005510:     	andq	%rax, %rdx
180005513:     	movq	0x128(%rsp), %rax
18000551b:     	leaq	(%rbx,%rax,8), %rax
18000551f:     	movq	%rax, 0x150(%rsp)
180005527:     	leaq	(,%r15,8), %r12
18000552f:     	xorl	%r8d, %r8d
180005532:     	movq	%rdx, 0x138(%rsp)
18000553a:     	leaq	(%r9,%r8), %r10
18000553e:     	sarq	$0x3f, %r10
180005542:     	andq	%r12, %r10
180005545:     	leaq	(%rbx,%r9,8), %rsi
180005549:     	addq	%rsi, %r10
18000554c:     	movq	(%r10,%r8,8), %r10
180005550:     	movq	0x128(%rsp), %rax
180005558:     	addq	%r8, %rax
18000555b:     	sarq	$0x3f, %rax
18000555f:     	andq	%r12, %rax
180005562:     	movq	0x150(%rsp), %r13
18000556a:     	addq	%r13, %rax
18000556d:     	movq	%r10, (%rax,%r8,8)
180005571:     	leaq	0x1(%r9,%r8), %rax
180005576:     	sarq	$0x3f, %rax
18000557a:     	andq	%r12, %rax
18000557d:     	addq	%rsi, %rax
180005580:     	movq	0x8(%rax,%r8,8), %rax
180005585:     	movq	0x128(%rsp), %rdx
18000558d:     	leaq	0x1(%rdx,%r8), %r10
180005592:     	sarq	$0x3f, %r10
180005596:     	andq	%r12, %r10
180005599:     	addq	%r13, %r10
18000559c:     	movq	%rax, 0x8(%r10,%r8,8)
1800055a1:     	leaq	0x2(%r9,%r8), %rax
1800055a6:     	sarq	$0x3f, %rax
1800055aa:     	andq	%r12, %rax
1800055ad:     	movq	%rsi, 0x118(%rsp)
1800055b5:     	addq	%rsi, %rax
1800055b8:     	movq	0x10(%rax,%r8,8), %rax
1800055bd:     	leaq	0x2(%rdx,%r8), %r10
1800055c2:     	movq	%rdx, %rsi
1800055c5:     	sarq	$0x3f, %r10
1800055c9:     	andq	%r12, %r10
1800055cc:     	addq	%r13, %r10
1800055cf:     	movq	%rax, 0x10(%r10,%r8,8)
1800055d4:     	leaq	0x3(%r9,%r8), %rax
1800055d9:     	sarq	$0x3f, %rax
1800055dd:     	andq	%r12, %rax
1800055e0:     	addq	0x118(%rsp), %rax
1800055e8:     	movq	0x18(%rax,%r8,8), %rax
1800055ed:     	leaq	0x3(%rdx,%r8), %r10
1800055f2:     	sarq	$0x3f, %r10
1800055f6:     	andq	%r12, %r10
1800055f9:     	addq	%r13, %r10
1800055fc:     	movq	%rax, 0x18(%r10,%r8,8)
180005601:     	leaq	0x4(%r9,%r8), %rax
180005606:     	sarq	$0x3f, %rax
18000560a:     	andq	%r12, %rax
18000560d:     	addq	0x118(%rsp), %rax
180005615:     	movq	0x20(%rax,%r8,8), %rax
18000561a:     	leaq	0x4(%rsi,%r8), %r10
18000561f:     	sarq	$0x3f, %r10
180005623:     	andq	%r12, %r10
180005626:     	addq	%r13, %r10
180005629:     	movq	%r13, %rsi
18000562c:     	movq	%rax, 0x20(%r10,%r8,8)
180005631:     	leaq	0x5(%r9,%r8), %rax
180005636:     	sarq	$0x3f, %rax
18000563a:     	andq	%r12, %rax
18000563d:     	addq	0x118(%rsp), %rax
180005645:     	movq	0x28(%rax,%r8,8), %rax
18000564a:     	leaq	0x5(%rdx,%r8), %r10
18000564f:     	movq	%rdx, %r13
180005652:     	sarq	$0x3f, %r10
180005656:     	andq	%r12, %r10
180005659:     	addq	%rsi, %r10
18000565c:     	movq	%rax, 0x28(%r10,%r8,8)
180005661:     	leaq	0x6(%r9,%r8), %rax
180005666:     	sarq	$0x3f, %rax
18000566a:     	andq	%r12, %rax
18000566d:     	addq	0x118(%rsp), %rax
180005675:     	movq	0x30(%rax,%r8,8), %rax
18000567a:     	leaq	0x6(%rdx,%r8), %r10
18000567f:     	sarq	$0x3f, %r10
180005683:     	andq	%r12, %r10
180005686:     	addq	%rsi, %r10
180005689:     	movq	%rax, 0x30(%r10,%r8,8)
18000568e:     	leaq	0x7(%r9,%r8), %rax
180005693:     	sarq	$0x3f, %rax
180005697:     	andq	%r12, %rax
18000569a:     	addq	0x118(%rsp), %rax
1800056a2:     	movq	0x138(%rsp), %rdx
1800056aa:     	movq	0x38(%rax,%r8,8), %rax
1800056af:     	leaq	0x7(%r13,%r8), %r10
1800056b4:     	sarq	$0x3f, %r10
1800056b8:     	andq	%r12, %r10
1800056bb:     	addq	%rsi, %r10
1800056be:     	movq	%rax, 0x38(%r10,%r8,8)
1800056c3:     	addq	$0x8, %r8
1800056c7:     	cmpq	%r8, %rdx
1800056ca:     	jne	0x18000553a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x197a>
1800056d0:     	movq	0x160(%rsp), %r10
1800056d8:     	testq	%r10, %r10
1800056db:     	movq	0x298(%rsp), %r13
1800056e3:     	movq	0x2c0(%rsp), %rsi
1800056eb:     	je	0x18000572f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1b6f>
1800056ed:     	movq	0x128(%rsp), %rax
1800056f5:     	leaq	(%rdx,%rax), %r8
1800056f9:     	addq	%rdx, %r9
1800056fc:     	movq	%r9, %rax
1800056ff:     	sarq	$0x3f, %rax
180005703:     	andq	%r12, %rax
180005706:     	addq	%rbx, %rax
180005709:     	movq	(%rax,%r9,8), %rax
18000570d:     	movq	%r10, %rdx
180005710:     	movq	%r8, %r10
180005713:     	sarq	$0x3f, %r10
180005717:     	andq	%r12, %r10
18000571a:     	addq	%rbx, %r10
18000571d:     	movq	%rax, (%r10,%r8,8)
180005721:     	movq	%rdx, %r10
180005724:     	incq	%r8
180005727:     	incq	%r9
18000572a:     	decq	%r10
18000572d:     	jne	0x1800056fc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1b3c>
18000572f:     	movq	0x158(%rsp), %rdx
180005737:     	leaq	(%rbx,%rdx,8), %rax
18000573b:     	movq	0x170(%rsp), %r8
180005743:     	movq	0x168(%rsp), %r9
18000574b:     	movq	%r9, 0x8(%rax,%r8,8)
180005750:     	movq	0x128(%rsp), %r8
180005758:     	movq	0x140(%rsp), %r9
180005760:     	movq	%r8, 0x10(%rax,%r9,8)
180005765:     	movq	0x148(%rsp), %r10
18000576d:     	movq	%rax, %r8
180005770:     	leaq	0x1(%r10), %rax
180005774:     	movq	%rax, (%r8,%r11,8)
180005778:     	cmpb	$0x0, (%r13)
18000577d:     	jne	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180005783:     	xorl	%eax, %eax
180005785:     	cmpq	$-0x2, %rdx
180005789:     	cmovlq	%r15, %rax
18000578d:     	addq	0x10(%r8,%rax,8), %r10
180005792:     	movq	%r10, %rax
180005795:     	sarq	$0x3f, %rax
180005799:     	andq	%r15, %rax
18000579c:     	leaq	(%rbx,%r10,8), %rdx
1800057a0:     	movq	%rsi, (%rdx,%rax,8)
1800057a4:     	movsd	0x48(%r14,%rdi,8), %xmm2
1800057ab:     	movsd	0x8(%r14,%rsi,8), %xmm1
1800057b2:     	movapd	%xmm2, %xmm0
1800057b6:     	addsd	%xmm1, %xmm0
1800057ba:     	xorpd	%xmm3, %xmm3
1800057be:     	ucomisd	%xmm3, %xmm0
1800057c2:     	jbe	0x180005893 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1cd3>
1800057c8:     	movq	0x10(%rbx,%rdi,8), %rax
1800057cd:     	cmpq	$0x0, 0x8(%rbx,%rax,8)
1800057d3:     	mulsd	(%r14,%rax,8), %xmm2
1800057d9:     	je	0x180005805 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1c45>
1800057db:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
1800057e1:     	je	0x180005805 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1c45>
1800057e3:     	movapd	0x7bd5(%rip), %xmm3     # 0x18000d3c0
1800057eb:     	andpd	%xmm2, %xmm3
1800057ef:     	ucomisd	0x7bd9(%rip), %xmm3     # 0x18000d3d0
1800057f7:     	jae	0x1800058b1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1cf1>
1800057fd:     	xorpd	%xmm3, %xmm3
180005801:     	addsd	%xmm3, %xmm2
180005805:     	movq	0x10(%rbx,%rsi,8), %rdx
18000580a:     	mulsd	(%r14,%rdx,8), %xmm1
180005810:     	addsd	%xmm2, %xmm1
180005814:     	divsd	%xmm0, %xmm1
180005818:     	movsd	%xmm1, (%r14,%rax,8)
18000581e:     	movq	$0x0, 0x8(%rbx,%rax,8)
180005827:     	movq	0x10(%rbx,%rdi,8), %rax
18000582c:     	movsd	0x10(%r14,%rax,8), %xmm1
180005833:     	cmpq	$0x0, 0x18(%rbx,%rax,8)
180005839:     	mulsd	0x48(%r14,%rdi,8), %xmm1
180005840:     	je	0x180005868 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1ca8>
180005842:     	cmpq	$0x0, 0x50(%rbx,%rdi,8)
180005848:     	je	0x180005868 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1ca8>
18000584a:     	movapd	0x7b6e(%rip), %xmm2     # 0x18000d3c0
180005852:     	andpd	%xmm1, %xmm2
180005856:     	ucomisd	0x7b72(%rip), %xmm2     # 0x18000d3d0
18000585e:     	jae	0x1800058c0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1d00>
180005860:     	xorpd	%xmm2, %xmm2
180005864:     	addsd	%xmm2, %xmm1
180005868:     	movq	0x10(%rbx,%rsi,8), %rdx
18000586d:     	movsd	0x10(%r14,%rdx,8), %xmm2
180005874:     	mulsd	0x8(%r14,%rsi,8), %xmm2
18000587b:     	addsd	%xmm1, %xmm2
18000587f:     	divsd	%xmm0, %xmm2
180005883:     	movsd	%xmm2, 0x10(%r14,%rax,8)
18000588a:     	movq	$0x0, 0x18(%rbx,%rax,8)
180005893:     	movsd	%xmm0, 0x48(%r14,%rdi,8)
18000589a:     	movq	$0x0, 0x50(%rbx,%rdi,8)
1800058a3:     	cmpb	$0x0, (%r13)
1800058a8:     	sete	%r12b
1800058ac:     	jmp	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
1800058b1:     	movb	$0x1, (%r13)
1800058b6:     	movq	$0x895447, 0x18(%rbp)   # imm = 0x895447
1800058be:     	jmp	0x1800058a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1ce3>
1800058c0:     	movb	$0x1, (%r13)
1800058c5:     	movq	$0x895449, 0x18(%rbp)   # imm = 0x895449
1800058cd:     	jmp	0x1800058a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1ce3>
1800058cf:     	movq	0x38(%rbx,%rdi,8), %rax
1800058d4:     	testq	%rax, %rax
1800058d7:     	js	0x1800058fb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1d3b>
1800058d9:     	movq	%rcx, 0x8(%rbp)
1800058dd:     	cmpq	0x10(%rbp), %rcx
1800058e1:     	jle	0x18000590d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1d4d>
1800058e3:     	movq	0x298(%rsp), %rax
1800058eb:     	movb	$0x1, (%rax)
1800058ee:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
1800058f6:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800058fb:     	movb	$0x1, (%r13)
180005900:     	movq	$0x2dc6cf, 0x18(%rbp)   # imm = 0x2DC6CF
180005908:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
18000590d:     	movb	$0x0, 0x125(%rsp)
180005915:     	movq	%rsi, 0x100(%rsp)
18000591d:     	movq	%rax, 0xf8(%rsp)
180005925:     	movq	0x2a8(%rsp), %rax
18000592d:     	movq	%rax, 0xe8(%rsp)
180005935:     	movq	0x2a0(%rsp), %rax
18000593d:     	movq	%rax, 0xe0(%rsp)
180005945:     	movq	0x298(%rsp), %r13
18000594d:     	movq	%r13, 0xd8(%rsp)
180005955:     	movq	0x290(%rsp), %rax
18000595d:     	movq	%rax, 0xd0(%rsp)
180005965:     	movq	0x288(%rsp), %rax
18000596d:     	movq	%rax, 0xc8(%rsp)
180005975:     	movq	0x280(%rsp), %rax
18000597d:     	movq	%rax, 0xc0(%rsp)
180005985:     	movq	0x278(%rsp), %rax
18000598d:     	movq	%rax, 0xb8(%rsp)
180005995:     	movq	0x270(%rsp), %rax
18000599d:     	movq	%rax, 0xb0(%rsp)
1800059a5:     	movq	0x268(%rsp), %rax
1800059ad:     	movq	%rax, 0xa8(%rsp)
1800059b5:     	movq	%rbp, 0xa0(%rsp)
1800059bd:     	movq	0x258(%rsp), %rax
1800059c5:     	movq	%rax, 0x98(%rsp)
1800059cd:     	movq	0x250(%rsp), %rax
1800059d5:     	movq	%rax, 0x90(%rsp)
1800059dd:     	movq	0x248(%rsp), %rax
1800059e5:     	movq	%rax, 0x88(%rsp)
1800059ed:     	movq	0x240(%rsp), %rax
1800059f5:     	movq	%rax, 0x80(%rsp)
1800059fd:     	movq	0x238(%rsp), %rax
180005a05:     	movq	%rax, 0x78(%rsp)
180005a0a:     	movq	%r15, 0x70(%rsp)
180005a0f:     	movq	%rbx, 0x68(%rsp)
180005a14:     	movq	0x220(%rsp), %rax
180005a1c:     	movq	%rax, 0x60(%rsp)
180005a21:     	movq	0x218(%rsp), %rax
180005a29:     	movq	%rax, 0x58(%rsp)
180005a2e:     	movq	0x210(%rsp), %rax
180005a36:     	movq	%rax, 0x50(%rsp)
180005a3b:     	movq	0x208(%rsp), %rax
180005a43:     	movq	%rax, 0x48(%rsp)
180005a48:     	movq	0x200(%rsp), %rax
180005a50:     	movq	%rax, 0x40(%rsp)
180005a55:     	movq	0x1f8(%rsp), %rax
180005a5d:     	movq	%rax, 0x38(%rsp)
180005a62:     	movq	%r14, 0x30(%rsp)
180005a67:     	movq	0x1e8(%rsp), %rax
180005a6f:     	movq	%rax, 0x28(%rsp)
180005a74:     	movq	0x1e0(%rsp), %rax
180005a7c:     	movq	%rax, 0x20(%rsp)
180005a81:     	movq	$-0x1, 0x108(%rsp)
180005a8d:     	movq	$0x0, 0xf0(%rsp)
180005a99:     	leaq	0x125(%rsp), %rcx
180005aa1:     	movq	0x128(%rsp), %r8
180005aa9:     	movq	0x138(%rsp), %r9
180005ab1:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
180005ab6:     	cmpb	$0x0, (%r13)
180005abb:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005ac1:     	movq	0x8(%rbp), %rax
180005ac5:     	leaq	-0x1(%rax), %rcx
180005ac9:     	cmpb	$0x0, 0x125(%rsp)
180005ad1:     	movq	%rcx, 0x8(%rbp)
180005ad5:     	movq	0x118(%rsp), %rcx
180005add:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180005ae3:     	movq	0x40(%rbx,%rdi,8), %rcx
180005ae8:     	testq	%rcx, %rcx
180005aeb:     	js	0x180005afb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1f3b>
180005aed:     	movq	%rax, 0x8(%rbp)
180005af1:     	cmpq	0x10(%rbp), %rax
180005af5:     	jle	0x180006848 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2c88>
180005afb:     	movq	0x298(%rsp), %rax
180005b03:     	movb	$0x1, (%rax)
180005b06:     	movq	$0x2dc6d0, 0x18(%rbp)   # imm = 0x2DC6D0
180005b0e:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005b13:     	movq	%rax, (%rbp)
180005b17:     	cmpb	$0x0, (%rsi)
180005b1a:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005b20:     	subsd	%xmm3, %xmm1
180005b24:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
180005b2b:     	movsd	%xmm5, 0x18(%r14,%rcx,8)
180005b32:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005b39:     	movsd	%xmm0, (%r14,%rcx,8)
180005b3f:     	cmpb	$0x0, (%rsi)
180005b42:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005b48:     	movq	(%rbp), %rax
180005b4c:     	leaq	0xb(%rax), %r8
180005b50:     	cmpq	%r15, %r8
180005b53:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005b59:     	movq	0x2c8(%rsp), %rdx
180005b61:     	movq	0x8(%rbx,%rdx,8), %rdx
180005b66:     	movq	%r8, (%rbp)
180005b6a:     	cmpb	$0x0, (%rsi)
180005b6d:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005b73:     	movq	%rcx, (%rbx,%rax,8)
180005b77:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005b7c:     	movq	(%rbp), %rdx
180005b80:     	cmpq	%r15, %rdx
180005b83:     	movq	%rdx, %rcx
180005b86:     	jle	0x180005b91 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1fd1>
180005b88:     	movb	$0x2, (%rsi)
180005b8b:     	movq	(%rbp), %rdx
180005b8f:     	xorl	%ecx, %ecx
180005b91:     	leaq	0x3(%rdx), %r8
180005b95:     	cmpq	%r15, %r8
180005b98:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005b9e:     	movq	%r8, (%rbp)
180005ba2:     	cmpb	$0x0, (%rsi)
180005ba5:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005bab:     	movq	%rdx, %r8
180005bae:     	sarq	$0x3f, %r8
180005bb2:     	andq	%r15, %r8
180005bb5:     	leaq	(%rbx,%rdx,8), %r9
180005bb9:     	movq	$0x0, (%r9,%r8,8)
180005bc1:     	xorl	%r12d, %r12d
180005bc4:     	cmpq	$-0x1, %rdx
180005bc8:     	movl	$0x0, %r8d
180005bce:     	cmovlq	%r15, %r8
180005bd2:     	movq	$0x0, 0x8(%r9,%r8,8)
180005bdb:     	cmpq	$-0x2, %rdx
180005bdf:     	movl	$0x0, %r8d
180005be5:     	cmovlq	%r15, %r8
180005be9:     	movq	%rcx, 0x10(%r9,%r8,8)
180005bee:     	cmpb	$0x0, (%rsi)
180005bf1:     	movq	0x118(%rsp), %rcx
180005bf9:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180005bff:     	leaq	(%rbx,%rax,8), %rcx
180005c03:     	movq	%rdx, 0x30(%rcx)
180005c07:     	movq	$0x0, 0x18(%rcx)
180005c0f:     	movq	(%rbp), %rdx
180005c13:     	leaq	0x4(%rdx), %r8
180005c17:     	cmpq	%r15, %r8
180005c1a:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005c20:     	movq	%r8, (%rbp)
180005c24:     	cmpb	$0x0, (%rsi)
180005c27:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005c2d:     	movq	$0x0, (%r14,%rdx,8)
180005c35:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005c3e:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005c47:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005c50:     	cmpb	$0x0, (%rsi)
180005c53:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005c59:     	movq	%rdx, 0x10(%rcx)
180005c5d:     	movq	$0x0, 0x48(%r14,%rax,8)
180005c66:     	movq	$0x1, 0x50(%rcx)
180005c6e:     	movq	$-0x1, 0x20(%rcx)
180005c76:     	movq	$-0x1, 0x28(%rcx)
180005c7e:     	movq	$-0x1, 0x38(%rcx)
180005c86:     	movq	$-0x1, 0x40(%rcx)
180005c8e:     	cmpb	$0x0, (%rsi)
180005c91:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005c97:     	movq	0x2c8(%rsp), %rcx
180005c9f:     	movq	%rax, 0x28(%rbx,%rcx,8)
180005ca4:     	movq	(%rbp), %rcx
180005ca8:     	leaq	0x4(%rcx), %rax
180005cac:     	cmpq	%r15, %rax
180005caf:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005cb5:     	movq	%rax, (%rbp)
180005cb9:     	cmpb	$0x0, (%rsi)
180005cbc:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005cc2:     	addsd	%xmm0, %xmm2
180005cc6:     	movsd	%xmm4, 0x10(%r14,%rcx,8)
180005ccd:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005cd4:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005cdb:     	movsd	%xmm0, (%r14,%rcx,8)
180005ce1:     	cmpb	$0x0, (%rsi)
180005ce4:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005cea:     	movq	(%rbp), %rax
180005cee:     	leaq	0xb(%rax), %r8
180005cf2:     	cmpq	%r15, %r8
180005cf5:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005cfb:     	movq	0x2c8(%rsp), %rdx
180005d03:     	movq	0x8(%rbx,%rdx,8), %rdx
180005d08:     	movq	%r8, (%rbp)
180005d0c:     	cmpb	$0x0, (%rsi)
180005d0f:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005d15:     	movq	%rcx, (%rbx,%rax,8)
180005d19:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005d1e:     	movq	(%rbp), %rdx
180005d22:     	cmpq	%r15, %rdx
180005d25:     	movq	%rdx, %rcx
180005d28:     	jle	0x180005d33 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2173>
180005d2a:     	movb	$0x2, (%rsi)
180005d2d:     	movq	(%rbp), %rdx
180005d31:     	xorl	%ecx, %ecx
180005d33:     	leaq	0x3(%rdx), %r8
180005d37:     	cmpq	%r15, %r8
180005d3a:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005d40:     	movq	%r8, (%rbp)
180005d44:     	cmpb	$0x0, (%rsi)
180005d47:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005d4d:     	movq	%rdx, %r8
180005d50:     	sarq	$0x3f, %r8
180005d54:     	andq	%r15, %r8
180005d57:     	leaq	(%rbx,%rdx,8), %r9
180005d5b:     	movq	$0x0, (%r9,%r8,8)
180005d63:     	xorl	%r12d, %r12d
180005d66:     	cmpq	$-0x1, %rdx
180005d6a:     	movl	$0x0, %r8d
180005d70:     	cmovlq	%r15, %r8
180005d74:     	movq	$0x0, 0x8(%r9,%r8,8)
180005d7d:     	cmpq	$-0x2, %rdx
180005d81:     	movl	$0x0, %r8d
180005d87:     	cmovlq	%r15, %r8
180005d8b:     	movq	%rcx, 0x10(%r9,%r8,8)
180005d90:     	cmpb	$0x0, (%rsi)
180005d93:     	movq	0x118(%rsp), %rcx
180005d9b:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180005da1:     	leaq	(%rbx,%rax,8), %rcx
180005da5:     	movq	%rdx, 0x30(%rcx)
180005da9:     	movq	$0x0, 0x18(%rcx)
180005db1:     	movq	(%rbp), %rdx
180005db5:     	leaq	0x4(%rdx), %r8
180005db9:     	cmpq	%r15, %r8
180005dbc:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005dc2:     	movq	%r8, (%rbp)
180005dc6:     	cmpb	$0x0, (%rsi)
180005dc9:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005dcf:     	movq	$0x0, (%r14,%rdx,8)
180005dd7:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005de0:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005de9:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005df2:     	cmpb	$0x0, (%rsi)
180005df5:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005dfb:     	movq	%rdx, 0x10(%rcx)
180005dff:     	movq	$0x0, 0x48(%r14,%rax,8)
180005e08:     	movq	$0x1, 0x50(%rcx)
180005e10:     	movq	$-0x1, 0x20(%rcx)
180005e18:     	movq	$-0x1, 0x28(%rcx)
180005e20:     	movq	$-0x1, 0x38(%rcx)
180005e28:     	movq	$-0x1, 0x40(%rcx)
180005e30:     	cmpb	$0x0, (%rsi)
180005e33:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005e39:     	movq	0x2c8(%rsp), %rcx
180005e41:     	movq	%rax, 0x38(%rbx,%rcx,8)
180005e46:     	movq	(%rbp), %rcx
180005e4a:     	leaq	0x4(%rcx), %rax
180005e4e:     	cmpq	%r15, %rax
180005e51:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005e57:     	movq	%rax, (%rbp)
180005e5b:     	cmpb	$0x0, (%rsi)
180005e5e:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005e64:     	movsd	%xmm1, 0x10(%r14,%rcx,8)
180005e6b:     	movsd	%xmm2, 0x18(%r14,%rcx,8)
180005e72:     	movsd	%xmm3, 0x8(%r14,%rcx,8)
180005e79:     	movsd	%xmm0, (%r14,%rcx,8)
180005e7f:     	cmpb	$0x0, (%rsi)
180005e82:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005e88:     	movq	(%rbp), %rax
180005e8c:     	leaq	0xb(%rax), %r8
180005e90:     	cmpq	%r15, %r8
180005e93:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005e99:     	movq	0x2c8(%rsp), %rdx
180005ea1:     	movq	0x8(%rbx,%rdx,8), %rdx
180005ea6:     	movq	%r8, (%rbp)
180005eaa:     	cmpb	$0x0, (%rsi)
180005ead:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005eb3:     	movq	%rcx, (%rbx,%rax,8)
180005eb7:     	movq	%rdx, 0x8(%rbx,%rax,8)
180005ebc:     	movq	(%rbp), %rdx
180005ec0:     	cmpq	%r15, %rdx
180005ec3:     	movq	%rdx, %rcx
180005ec6:     	jle	0x180005ed1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2311>
180005ec8:     	movb	$0x2, (%rsi)
180005ecb:     	movq	(%rbp), %rdx
180005ecf:     	xorl	%ecx, %ecx
180005ed1:     	leaq	0x3(%rdx), %r8
180005ed5:     	cmpq	%r15, %r8
180005ed8:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005ede:     	movq	%r8, (%rbp)
180005ee2:     	cmpb	$0x0, (%rsi)
180005ee5:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005eeb:     	movq	%rdx, %r8
180005eee:     	sarq	$0x3f, %r8
180005ef2:     	andq	%r15, %r8
180005ef5:     	leaq	(%rbx,%rdx,8), %r9
180005ef9:     	movq	$0x0, (%r9,%r8,8)
180005f01:     	xorl	%r12d, %r12d
180005f04:     	cmpq	$-0x1, %rdx
180005f08:     	movl	$0x0, %r8d
180005f0e:     	cmovlq	%r15, %r8
180005f12:     	movq	$0x0, 0x8(%r9,%r8,8)
180005f1b:     	cmpq	$-0x2, %rdx
180005f1f:     	movl	$0x0, %r8d
180005f25:     	cmovlq	%r15, %r8
180005f29:     	movq	%rcx, 0x10(%r9,%r8,8)
180005f2e:     	cmpb	$0x0, (%rsi)
180005f31:     	movq	0x118(%rsp), %rcx
180005f39:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180005f3f:     	leaq	(%rbx,%rax,8), %rcx
180005f43:     	movq	%rdx, 0x30(%rcx)
180005f47:     	movq	$0x0, 0x18(%rcx)
180005f4f:     	movq	(%rbp), %rdx
180005f53:     	leaq	0x4(%rdx), %r8
180005f57:     	cmpq	%r15, %r8
180005f5a:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
180005f60:     	movq	%r8, (%rbp)
180005f64:     	cmpb	$0x0, (%rsi)
180005f67:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005f6d:     	movq	$0x0, (%r14,%rdx,8)
180005f75:     	movq	$0x1, 0x8(%rbx,%rdx,8)
180005f7e:     	movq	$0x0, 0x10(%r14,%rdx,8)
180005f87:     	movq	$0x1, 0x18(%rbx,%rdx,8)
180005f90:     	cmpb	$0x0, (%rsi)
180005f93:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005f99:     	movq	%rdx, 0x10(%rcx)
180005f9d:     	movq	$0x0, 0x48(%r14,%rax,8)
180005fa6:     	movq	$0x1, 0x50(%rcx)
180005fae:     	movq	$-0x1, 0x20(%rcx)
180005fb6:     	movq	$-0x1, 0x28(%rcx)
180005fbe:     	movq	$-0x1, 0x38(%rcx)
180005fc6:     	movq	$-0x1, 0x40(%rcx)
180005fce:     	cmpb	$0x0, (%rsi)
180005fd1:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180005fd7:     	movq	0x2c8(%rsp), %rcx
180005fdf:     	movq	%rax, 0x40(%rbx,%rcx,8)
180005fe4:     	movq	$0x1, 0x18(%rbx,%rcx,8)
180005fed:     	movq	0x30(%rbx,%rcx,8), %rax
180005ff2:     	movq	%rax, %rcx
180005ff5:     	sarq	$0x3f, %rcx
180005ff9:     	andq	%r15, %rcx
180005ffc:     	leaq	(%rbx,%rax,8), %rdx
180006000:     	movq	%rcx, 0x148(%rsp)
180006008:     	movq	%rdx, 0x150(%rsp)
180006010:     	cmpq	$0x0, (%rdx,%rcx,8)
180006015:     	jle	0x1800067ba <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2bfa>
18000601b:     	leaq	(,%r15,8), %rcx
180006023:     	xorl	%r13d, %r13d
180006026:     	cmpq	$-0x2, %rax
18000602a:     	cmovgeq	%r13, %rcx
18000602e:     	movq	%rcx, 0x140(%rsp)
180006036:     	movq	0x2c8(%rsp), %rax
18000603e:     	movq	0x20(%rbx,%rax,8), %rax
180006043:     	testq	%rax, %rax
180006046:     	js	0x180006a0c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e4c>
18000604c:     	movq	0x150(%rsp), %rcx
180006054:     	movq	0x140(%rsp), %rdx
18000605c:     	movq	0x10(%rcx,%rdx), %rcx
180006061:     	addq	%r13, %rcx
180006064:     	leaq	(%rbx,%rcx,8), %rdx
180006068:     	sarq	$0x3f, %rcx
18000606c:     	andq	%r15, %rcx
18000606f:     	movq	(%rdx,%rcx,8), %r12
180006073:     	movq	0x8(%rbp), %rcx
180006077:     	leaq	0x1(%rcx), %rdx
18000607b:     	movq	%rdx, 0x8(%rbp)
18000607f:     	cmpq	0x10(%rbp), %rcx
180006083:     	jge	0x180006a0c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e4c>
180006089:     	movq	%r12, 0x100(%rsp)
180006091:     	movq	%rax, 0xf8(%rsp)
180006099:     	movq	0x2a8(%rsp), %rax
1800060a1:     	movq	%rax, 0xe8(%rsp)
1800060a9:     	movq	0x2a0(%rsp), %rax
1800060b1:     	movq	%rax, 0xe0(%rsp)
1800060b9:     	movq	%rsi, 0xd8(%rsp)
1800060c1:     	movq	0x290(%rsp), %rax
1800060c9:     	movq	%rax, 0xd0(%rsp)
1800060d1:     	movq	0x288(%rsp), %rax
1800060d9:     	movq	%rax, 0xc8(%rsp)
1800060e1:     	movq	0x280(%rsp), %rax
1800060e9:     	movq	%rax, 0xc0(%rsp)
1800060f1:     	movq	0x278(%rsp), %rax
1800060f9:     	movq	%rax, 0xb8(%rsp)
180006101:     	movq	0x270(%rsp), %rax
180006109:     	movq	%rax, 0xb0(%rsp)
180006111:     	movq	0x268(%rsp), %rax
180006119:     	movq	%rax, 0xa8(%rsp)
180006121:     	movq	%rbp, 0xa0(%rsp)
180006129:     	movq	%rdi, 0x98(%rsp)
180006131:     	movq	0x250(%rsp), %rax
180006139:     	movq	%rax, 0x90(%rsp)
180006141:     	movq	0x248(%rsp), %rax
180006149:     	movq	%rax, 0x88(%rsp)
180006151:     	movq	0x240(%rsp), %rax
180006159:     	movq	%rax, 0x80(%rsp)
180006161:     	movq	0x238(%rsp), %rax
180006169:     	movq	%rax, 0x78(%rsp)
18000616e:     	movq	%r15, 0x70(%rsp)
180006173:     	movq	%rbx, 0x68(%rsp)
180006178:     	movq	0x220(%rsp), %rax
180006180:     	movq	%rax, 0x60(%rsp)
180006185:     	movq	0x218(%rsp), %rax
18000618d:     	movq	%rax, 0x58(%rsp)
180006192:     	movq	0x210(%rsp), %rax
18000619a:     	movq	%rax, 0x50(%rsp)
18000619f:     	movq	0x208(%rsp), %rax
1800061a7:     	movq	%rax, 0x48(%rsp)
1800061ac:     	movq	0x200(%rsp), %rax
1800061b4:     	movq	%rax, 0x40(%rsp)
1800061b9:     	movq	0x1f8(%rsp), %rax
1800061c1:     	movq	%rax, 0x38(%rsp)
1800061c6:     	movq	%r14, 0x30(%rsp)
1800061cb:     	movq	0x1e8(%rsp), %rax
1800061d3:     	movq	%rax, 0x28(%rsp)
1800061d8:     	movq	0x1e0(%rsp), %rax
1800061e0:     	movq	%rax, 0x20(%rsp)
1800061e5:     	movq	$-0x1, 0x108(%rsp)
1800061f1:     	movq	$0x0, 0xf0(%rsp)
1800061fd:     	leaq	0x136(%rsp), %rcx
180006205:     	movq	0x128(%rsp), %r8
18000620d:     	movq	0x138(%rsp), %r9
180006215:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
18000621a:     	movq	0x298(%rsp), %rax
180006222:     	cmpb	$0x0, (%rax)
180006225:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
18000622b:     	movq	0x8(%rbp), %rcx
18000622f:     	leaq	-0x1(%rcx), %rax
180006233:     	movq	%rax, 0x8(%rbp)
180006237:     	movq	0x2c8(%rsp), %rax
18000623f:     	movq	0x28(%rbx,%rax,8), %rax
180006244:     	testq	%rax, %rax
180006247:     	js	0x180006a1c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e5c>
18000624d:     	movq	%rcx, 0x8(%rbp)
180006251:     	cmpq	0x10(%rbp), %rcx
180006255:     	jg	0x180006a1c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e5c>
18000625b:     	movq	%r12, 0x100(%rsp)
180006263:     	movq	%rax, 0xf8(%rsp)
18000626b:     	movq	0x2a8(%rsp), %rax
180006273:     	movq	%rax, 0xe8(%rsp)
18000627b:     	movq	0x2a0(%rsp), %rax
180006283:     	movq	%rax, 0xe0(%rsp)
18000628b:     	movq	%rsi, 0xd8(%rsp)
180006293:     	movq	0x290(%rsp), %rax
18000629b:     	movq	%rax, 0xd0(%rsp)
1800062a3:     	movq	0x288(%rsp), %rax
1800062ab:     	movq	%rax, 0xc8(%rsp)
1800062b3:     	movq	0x280(%rsp), %rax
1800062bb:     	movq	%rax, 0xc0(%rsp)
1800062c3:     	movq	0x278(%rsp), %rax
1800062cb:     	movq	%rax, 0xb8(%rsp)
1800062d3:     	movq	0x270(%rsp), %rax
1800062db:     	movq	%rax, 0xb0(%rsp)
1800062e3:     	movq	0x268(%rsp), %rax
1800062eb:     	movq	%rax, 0xa8(%rsp)
1800062f3:     	movq	%rbp, 0xa0(%rsp)
1800062fb:     	movq	%rdi, 0x98(%rsp)
180006303:     	movq	0x250(%rsp), %rax
18000630b:     	movq	%rax, 0x90(%rsp)
180006313:     	movq	0x248(%rsp), %rax
18000631b:     	movq	%rax, 0x88(%rsp)
180006323:     	movq	0x240(%rsp), %rax
18000632b:     	movq	%rax, 0x80(%rsp)
180006333:     	movq	0x238(%rsp), %rax
18000633b:     	movq	%rax, 0x78(%rsp)
180006340:     	movq	%r15, 0x70(%rsp)
180006345:     	movq	%rbx, 0x68(%rsp)
18000634a:     	movq	0x220(%rsp), %rax
180006352:     	movq	%rax, 0x60(%rsp)
180006357:     	movq	0x218(%rsp), %rax
18000635f:     	movq	%rax, 0x58(%rsp)
180006364:     	movq	0x210(%rsp), %rax
18000636c:     	movq	%rax, 0x50(%rsp)
180006371:     	movq	0x208(%rsp), %rax
180006379:     	movq	%rax, 0x48(%rsp)
18000637e:     	movq	0x200(%rsp), %rax
180006386:     	movq	%rax, 0x40(%rsp)
18000638b:     	movq	0x1f8(%rsp), %rax
180006393:     	movq	%rax, 0x38(%rsp)
180006398:     	movq	%r14, 0x30(%rsp)
18000639d:     	movq	0x1e8(%rsp), %rax
1800063a5:     	movq	%rax, 0x28(%rsp)
1800063aa:     	movq	0x1e0(%rsp), %rax
1800063b2:     	movq	%rax, 0x20(%rsp)
1800063b7:     	movq	$-0x1, 0x108(%rsp)
1800063c3:     	movq	$0x0, 0xf0(%rsp)
1800063cf:     	leaq	0x135(%rsp), %rcx
1800063d7:     	movq	0x128(%rsp), %r8
1800063df:     	movq	0x138(%rsp), %r9
1800063e7:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800063ec:     	movq	0x298(%rsp), %rax
1800063f4:     	cmpb	$0x0, (%rax)
1800063f7:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800063fd:     	movq	0x8(%rbp), %rcx
180006401:     	leaq	-0x1(%rcx), %rax
180006405:     	movq	%rax, 0x8(%rbp)
180006409:     	movq	0x2c8(%rsp), %rax
180006411:     	movq	0x38(%rbx,%rax,8), %rax
180006416:     	testq	%rax, %rax
180006419:     	js	0x180006a2c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e6c>
18000641f:     	movq	%rcx, 0x8(%rbp)
180006423:     	cmpq	0x10(%rbp), %rcx
180006427:     	jg	0x180006a2c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e6c>
18000642d:     	movq	%r12, 0x100(%rsp)
180006435:     	movq	%rax, 0xf8(%rsp)
18000643d:     	movq	0x2a8(%rsp), %rax
180006445:     	movq	%rax, 0xe8(%rsp)
18000644d:     	movq	0x2a0(%rsp), %rax
180006455:     	movq	%rax, 0xe0(%rsp)
18000645d:     	movq	%rsi, 0xd8(%rsp)
180006465:     	movq	0x290(%rsp), %rax
18000646d:     	movq	%rax, 0xd0(%rsp)
180006475:     	movq	0x288(%rsp), %rax
18000647d:     	movq	%rax, 0xc8(%rsp)
180006485:     	movq	0x280(%rsp), %rax
18000648d:     	movq	%rax, 0xc0(%rsp)
180006495:     	movq	0x278(%rsp), %rax
18000649d:     	movq	%rax, 0xb8(%rsp)
1800064a5:     	movq	0x270(%rsp), %rax
1800064ad:     	movq	%rax, 0xb0(%rsp)
1800064b5:     	movq	0x268(%rsp), %rax
1800064bd:     	movq	%rax, 0xa8(%rsp)
1800064c5:     	movq	%rbp, 0xa0(%rsp)
1800064cd:     	movq	%rdi, 0x98(%rsp)
1800064d5:     	movq	0x250(%rsp), %rax
1800064dd:     	movq	%rax, 0x90(%rsp)
1800064e5:     	movq	0x248(%rsp), %rax
1800064ed:     	movq	%rax, 0x88(%rsp)
1800064f5:     	movq	0x240(%rsp), %rax
1800064fd:     	movq	%rax, 0x80(%rsp)
180006505:     	movq	0x238(%rsp), %rax
18000650d:     	movq	%rax, 0x78(%rsp)
180006512:     	movq	%r15, 0x70(%rsp)
180006517:     	movq	%rbx, 0x68(%rsp)
18000651c:     	movq	0x220(%rsp), %rax
180006524:     	movq	%rax, 0x60(%rsp)
180006529:     	movq	0x218(%rsp), %rax
180006531:     	movq	%rax, 0x58(%rsp)
180006536:     	movq	0x210(%rsp), %rax
18000653e:     	movq	%rax, 0x50(%rsp)
180006543:     	movq	0x208(%rsp), %rax
18000654b:     	movq	%rax, 0x48(%rsp)
180006550:     	movq	0x200(%rsp), %rax
180006558:     	movq	%rax, 0x40(%rsp)
18000655d:     	movq	0x1f8(%rsp), %rax
180006565:     	movq	%rax, 0x38(%rsp)
18000656a:     	movq	%r14, 0x30(%rsp)
18000656f:     	movq	0x1e8(%rsp), %rax
180006577:     	movq	%rax, 0x28(%rsp)
18000657c:     	movq	0x1e0(%rsp), %rax
180006584:     	movq	%rax, 0x20(%rsp)
180006589:     	movq	$-0x1, 0x108(%rsp)
180006595:     	movq	$0x0, 0xf0(%rsp)
1800065a1:     	leaq	0x134(%rsp), %rcx
1800065a9:     	movq	0x128(%rsp), %r8
1800065b1:     	movq	0x138(%rsp), %r9
1800065b9:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800065be:     	movq	0x298(%rsp), %rax
1800065c6:     	cmpb	$0x0, (%rax)
1800065c9:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800065cf:     	movq	0x8(%rbp), %rcx
1800065d3:     	leaq	-0x1(%rcx), %rax
1800065d7:     	movq	%rax, 0x8(%rbp)
1800065db:     	movq	0x2c8(%rsp), %rax
1800065e3:     	movq	0x40(%rbx,%rax,8), %rax
1800065e8:     	testq	%rax, %rax
1800065eb:     	js	0x180006a3c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e7c>
1800065f1:     	movq	%rcx, 0x8(%rbp)
1800065f5:     	cmpq	0x10(%rbp), %rcx
1800065f9:     	jg	0x180006a3c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e7c>
1800065ff:     	movq	%r12, 0x100(%rsp)
180006607:     	movq	%rax, 0xf8(%rsp)
18000660f:     	movq	0x2a8(%rsp), %rax
180006617:     	movq	%rax, 0xe8(%rsp)
18000661f:     	movq	0x2a0(%rsp), %rax
180006627:     	movq	%rax, 0xe0(%rsp)
18000662f:     	movq	%rsi, 0xd8(%rsp)
180006637:     	movq	0x290(%rsp), %rax
18000663f:     	movq	%rax, 0xd0(%rsp)
180006647:     	movq	0x288(%rsp), %rax
18000664f:     	movq	%rax, 0xc8(%rsp)
180006657:     	movq	0x280(%rsp), %rax
18000665f:     	movq	%rax, 0xc0(%rsp)
180006667:     	movq	0x278(%rsp), %rax
18000666f:     	movq	%rax, 0xb8(%rsp)
180006677:     	movq	0x270(%rsp), %rax
18000667f:     	movq	%rax, 0xb0(%rsp)
180006687:     	movq	0x268(%rsp), %rax
18000668f:     	movq	%rax, 0xa8(%rsp)
180006697:     	movq	%rbp, 0xa0(%rsp)
18000669f:     	movq	%rdi, 0x98(%rsp)
1800066a7:     	movq	0x250(%rsp), %rax
1800066af:     	movq	%rax, 0x90(%rsp)
1800066b7:     	movq	0x248(%rsp), %rax
1800066bf:     	movq	%rax, 0x88(%rsp)
1800066c7:     	movq	0x240(%rsp), %rax
1800066cf:     	movq	%rax, 0x80(%rsp)
1800066d7:     	movq	0x238(%rsp), %rax
1800066df:     	movq	%rax, 0x78(%rsp)
1800066e4:     	movq	%r15, 0x70(%rsp)
1800066e9:     	movq	%rbx, 0x68(%rsp)
1800066ee:     	movq	0x220(%rsp), %rax
1800066f6:     	movq	%rax, 0x60(%rsp)
1800066fb:     	movq	0x218(%rsp), %rax
180006703:     	movq	%rax, 0x58(%rsp)
180006708:     	movq	0x210(%rsp), %rax
180006710:     	movq	%rax, 0x50(%rsp)
180006715:     	movq	0x208(%rsp), %rax
18000671d:     	movq	%rax, 0x48(%rsp)
180006722:     	movq	0x200(%rsp), %rax
18000672a:     	movq	%rax, 0x40(%rsp)
18000672f:     	movq	0x1f8(%rsp), %rax
180006737:     	movq	%rax, 0x38(%rsp)
18000673c:     	movq	%r14, 0x30(%rsp)
180006741:     	movq	0x1e8(%rsp), %rax
180006749:     	movq	%rax, 0x28(%rsp)
18000674e:     	movq	0x1e0(%rsp), %rax
180006756:     	movq	%rax, 0x20(%rsp)
18000675b:     	movq	$-0x1, 0x108(%rsp)
180006767:     	movq	$0x0, 0xf0(%rsp)
180006773:     	leaq	0x133(%rsp), %rcx
18000677b:     	movq	0x128(%rsp), %r8
180006783:     	movq	0x138(%rsp), %r9
18000678b:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
180006790:     	cmpb	$0x0, (%rsi)
180006793:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180006799:     	incq	%r13
18000679c:     	decq	0x8(%rbp)
1800067a0:     	movq	0x148(%rsp), %rax
1800067a8:     	movq	0x150(%rsp), %rcx
1800067b0:     	cmpq	(%rcx,%rax,8), %r13
1800067b4:     	jl	0x180006036 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2476>
1800067ba:     	movq	(%rbp), %rax
1800067be:     	cmpq	%r15, %rax
1800067c1:     	movq	%rax, %rcx
1800067c4:     	jle	0x1800067cf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2c0f>
1800067c6:     	movb	$0x2, (%rsi)
1800067c9:     	movq	(%rbp), %rax
1800067cd:     	xorl	%ecx, %ecx
1800067cf:     	leaq	0x3(%rax), %rdx
1800067d3:     	cmpq	%r15, %rdx
1800067d6:     	jg	0x180004ec8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1308>
1800067dc:     	movq	%rdx, (%rbp)
1800067e0:     	cmpb	$0x0, (%rsi)
1800067e3:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800067e9:     	movq	%rax, %rdx
1800067ec:     	sarq	$0x3f, %rdx
1800067f0:     	andq	%r15, %rdx
1800067f3:     	leaq	(%rbx,%rax,8), %r8
1800067f7:     	movq	$0x0, (%r8,%rdx,8)
1800067ff:     	xorl	%r12d, %r12d
180006802:     	cmpq	$-0x1, %rax
180006806:     	movl	$0x0, %edx
18000680b:     	cmovlq	%r15, %rdx
18000680f:     	movq	$0x0, 0x8(%r8,%rdx,8)
180006818:     	cmpq	$-0x2, %rax
18000681c:     	cmovgeq	%r12, %r15
180006820:     	movq	%rcx, 0x10(%r8,%r15,8)
180006825:     	cmpb	$0x0, (%rsi)
180006828:     	movq	0x118(%rsp), %rcx
180006830:     	jne	0x18000530e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174e>
180006836:     	movq	0x2c8(%rsp), %rdx
18000683e:     	movq	%rax, 0x30(%rbx,%rdx,8)
180006843:     	jmp	0x18000530b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x174b>
180006848:     	movb	$0x0, 0x124(%rsp)
180006850:     	movq	%rsi, 0x100(%rsp)
180006858:     	movq	%rcx, 0xf8(%rsp)
180006860:     	movq	0x2a8(%rsp), %rax
180006868:     	movq	%rax, 0xe8(%rsp)
180006870:     	movq	0x2a0(%rsp), %rax
180006878:     	movq	%rax, 0xe0(%rsp)
180006880:     	movq	0x290(%rsp), %rax
180006888:     	movq	%rax, 0xd0(%rsp)
180006890:     	movq	0x288(%rsp), %rax
180006898:     	movq	%rax, 0xc8(%rsp)
1800068a0:     	movq	0x280(%rsp), %rax
1800068a8:     	movq	%rax, 0xc0(%rsp)
1800068b0:     	movq	0x278(%rsp), %rax
1800068b8:     	movq	%rax, 0xb8(%rsp)
1800068c0:     	movq	0x270(%rsp), %rax
1800068c8:     	movq	%rax, 0xb0(%rsp)
1800068d0:     	movq	0x268(%rsp), %rax
1800068d8:     	movq	%rax, 0xa8(%rsp)
1800068e0:     	movq	0x258(%rsp), %rax
1800068e8:     	movq	%rax, 0x98(%rsp)
1800068f0:     	movq	0x250(%rsp), %rax
1800068f8:     	movq	%rax, 0x90(%rsp)
180006900:     	movq	0x248(%rsp), %rax
180006908:     	movq	%rax, 0x88(%rsp)
180006910:     	movq	0x240(%rsp), %rax
180006918:     	movq	%rax, 0x80(%rsp)
180006920:     	movq	0x238(%rsp), %rax
180006928:     	movq	%rax, 0x78(%rsp)
18000692d:     	movq	%r15, 0x70(%rsp)
180006932:     	movq	%rbx, 0x68(%rsp)
180006937:     	movq	0x220(%rsp), %rax
18000693f:     	movq	%rax, 0x60(%rsp)
180006944:     	movq	0x218(%rsp), %rax
18000694c:     	movq	%rax, 0x58(%rsp)
180006951:     	movq	0x210(%rsp), %rax
180006959:     	movq	%rax, 0x50(%rsp)
18000695e:     	movq	0x208(%rsp), %rax
180006966:     	movq	%rax, 0x48(%rsp)
18000696b:     	movq	0x200(%rsp), %rax
180006973:     	movq	%rax, 0x40(%rsp)
180006978:     	movq	0x1f8(%rsp), %rax
180006980:     	movq	%rax, 0x38(%rsp)
180006985:     	movq	%r14, 0x30(%rsp)
18000698a:     	movq	0x1e8(%rsp), %rax
180006992:     	movq	%rax, 0x28(%rsp)
180006997:     	movq	0x298(%rsp), %rsi
18000699f:     	movq	%rsi, 0xd8(%rsp)
1800069a7:     	movq	%rbp, 0xa0(%rsp)
1800069af:     	movq	0x1e0(%rsp), %rax
1800069b7:     	movq	%rax, 0x20(%rsp)
1800069bc:     	movq	$-0x1, 0x108(%rsp)
1800069c8:     	movq	$0x0, 0xf0(%rsp)
1800069d4:     	leaq	0x124(%rsp), %rcx
1800069dc:     	movq	0x128(%rsp), %r8
1800069e4:     	movq	0x138(%rsp), %r9
1800069ec:     	callq	0x180004a80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0xec0>
1800069f1:     	cmpb	$0x0, (%rsi)
1800069f4:     	jne	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
1800069fa:     	movzbl	0x124(%rsp), %r12d
180006a03:     	decq	0x8(%rbp)
180006a07:     	jmp	0x1800054f1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x1931>
180006a0c:     	movb	$0x1, (%rsi)
180006a0f:     	movq	$0x989697, 0x18(%rbp)   # imm = 0x989697
180006a17:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180006a1c:     	movb	$0x1, (%rsi)
180006a1f:     	movq	$0x989698, 0x18(%rbp)   # imm = 0x989698
180006a27:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180006a2c:     	movb	$0x1, (%rsi)
180006a2f:     	movq	$0x989699, 0x18(%rbp)   # imm = 0x989699
180006a37:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180006a3c:     	movb	$0x1, (%rsi)
180006a3f:     	movq	$0x98969a, 0x18(%rbp)   # imm = 0x98969A
180006a47:     	jmp	0x1800052bd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x16fd>
180006a4c:     	nopl	(%rax)
180006a50:     	pushq	%r15
180006a52:     	pushq	%r14
180006a54:     	pushq	%r13
180006a56:     	pushq	%r12
180006a58:     	pushq	%rsi
180006a59:     	pushq	%rdi
180006a5a:     	pushq	%rbp
180006a5b:     	pushq	%rbx
180006a5c:     	subq	$0x1e8, %rsp            # imm = 0x1E8
180006a63:     	movapd	%xmm8, 0x1d0(%rsp)
180006a6d:     	movapd	%xmm7, 0x1c0(%rsp)
180006a76:     	movapd	%xmm6, 0x1b0(%rsp)
180006a7f:     	movq	0x320(%rsp), %rsi
180006a87:     	movq	0x260(%rsp), %r15
180006a8f:     	movq	$0x0, 0x190(%rsp)
180006a9b:     	movb	$0x0, 0x198(%rsp)
180006aa3:     	movq	$0x0, 0x1a0(%rsp)
180006aaf:     	movq	$0x0, 0x170(%rsp)
180006abb:     	movb	$0x0, 0x178(%rsp)
180006ac3:     	movq	$0x0, 0x180(%rsp)
180006acf:     	movq	$0x0, 0x150(%rsp)
180006adb:     	movb	$0x0, 0x158(%rsp)
180006ae3:     	movq	$0x0, 0x160(%rsp)
180006aef:     	movq	$0x0, 0x130(%rsp)
180006afb:     	movb	$0x0, 0x138(%rsp)
180006b03:     	movq	$0x0, 0x140(%rsp)
180006b0f:     	movsd	0x48(%r15,%rsi,8), %xmm0
180006b16:     	xorpd	%xmm1, %xmm1
180006b1a:     	ucomisd	%xmm1, %xmm0
180006b1e:     	jne	0x180006b37 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2f77>
180006b20:     	jp	0x180006b37 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2f77>
180006b22:     	movb	$0x1, 0x18(%rcx)
180006b26:     	movq	$0x0, 0x10(%rcx)
180006b2e:     	movb	$0x1, 0x8(%rcx)
180006b32:     	jmp	0x180006cbc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30fc>
180006b37:     	movq	0x328(%rsp), %rbp
180006b3f:     	movq	0x2a0(%rsp), %r13
180006b47:     	movq	0x298(%rsp), %r12
180006b4f:     	movq	0x30(%r12,%rsi,8), %rax
180006b54:     	movq	%rax, %r10
180006b57:     	sarq	$0x3f, %r10
180006b5b:     	andq	%r13, %r10
180006b5e:     	leaq	(%r12,%rax,8), %rdx
180006b62:     	cmpq	$0x1, (%rdx,%r10,8)
180006b67:     	jne	0x180006b8a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2fca>
180006b69:     	xorl	%r10d, %r10d
180006b6c:     	cmpq	$-0x2, %rax
180006b70:     	cmovlq	%r13, %r10
180006b74:     	movq	0x10(%rdx,%r10,8), %rax
180006b79:     	leaq	(%r12,%rax,8), %rdx
180006b7d:     	sarq	$0x3f, %rax
180006b81:     	andq	%r13, %rax
180006b84:     	cmpq	%rbp, (%rdx,%rax,8)
180006b88:     	je	0x180006b22 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2f62>
180006b8a:     	movq	0x308(%rsp), %r14
180006b92:     	movq	0x2d0(%rsp), %rbx
180006b9a:     	movq	0x10(%r12,%rsi,8), %rdx
180006b9f:     	testq	%rdx, %rdx
180006ba2:     	js	0x180006c98 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30d8>
180006ba8:     	testq	%rbp, %rbp
180006bab:     	js	0x180006c98 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30d8>
180006bb1:     	movq	0x10(%r12,%rbp,8), %r10
180006bb6:     	testq	%r10, %r10
180006bb9:     	js	0x180006c98 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30d8>
180006bbf:     	movsd	(%r15,%rdx,8), %xmm1
180006bc5:     	cmpq	$0x0, 0x8(%r12,%rdx,8)
180006bcb:     	setne	%r11b
180006bcf:     	cmpq	$0x0, 0x8(%r12,%r10,8)
180006bd5:     	setne	%al
180006bd8:     	subsd	(%r15,%r10,8), %xmm1
180006bde:     	andb	%r11b, %al
180006be1:     	cmpb	$0x1, %al
180006be3:     	jne	0x180006c07 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3047>
180006be5:     	movapd	0x67d3(%rip), %xmm2     # 0x18000d3c0
180006bed:     	andpd	%xmm1, %xmm2
180006bf1:     	ucomisd	0x67d7(%rip), %xmm2     # 0x18000d3d0
180006bf9:     	jae	0x180006c98 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30d8>
180006bff:     	xorpd	%xmm2, %xmm2
180006c03:     	addsd	%xmm2, %xmm1
180006c07:     	movsd	0x10(%r15,%rdx,8), %xmm2
180006c0e:     	cmpq	$0x0, 0x18(%r12,%rdx,8)
180006c14:     	subsd	0x10(%r15,%r10,8), %xmm2
180006c1b:     	je	0x180006cf2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3132>
180006c21:     	cmpq	$0x0, 0x18(%r12,%r10,8)
180006c27:     	je	0x180006cf2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3132>
180006c2d:     	movapd	0x678b(%rip), %xmm3     # 0x18000d3c0
180006c35:     	andpd	%xmm2, %xmm3
180006c39:     	ucomisd	0x678f(%rip), %xmm3     # 0x18000d3d0
180006c41:     	jae	0x180006d5a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x319a>
180006c47:     	movapd	%xmm1, %xmm3
180006c4b:     	mulsd	%xmm1, %xmm3
180006c4f:     	ucomisd	0x6779(%rip), %xmm3     # 0x18000d3d0
180006c57:     	setae	%dl
180006c5a:     	testb	%dl, %al
180006c5c:     	jne	0x180006d0b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x314b>
180006c62:     	xorpd	%xmm4, %xmm4
180006c66:     	addsd	%xmm4, %xmm2
180006c6a:     	movapd	%xmm2, %xmm4
180006c6e:     	mulsd	%xmm2, %xmm4
180006c72:     	ucomisd	0x6756(%rip), %xmm4     # 0x18000d3d0
180006c7a:     	jae	0x180006d0b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x314b>
180006c80:     	addsd	%xmm4, %xmm3
180006c84:     	ucomisd	0x6744(%rip), %xmm3     # 0x18000d3d0
180006c8c:     	setae	%dl
180006c8f:     	testb	%dl, %al
180006c91:     	jne	0x180006d0b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x314b>
180006c93:     	jmp	0x180006d25 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3165>
180006c98:     	movb	$0x1, (%r14)
180006c9c:     	movq	$0x3d090a, 0x18(%rbx)   # imm = 0x3D090A
180006ca4:     	movq	$0x0, 0x18(%rcx)
180006cac:     	movq	$0x0, 0x10(%rcx)
180006cb4:     	movq	$0x0, 0x8(%rcx)
180006cbc:     	movq	$0x0, (%rcx)
180006cc3:     	xorl	%eax, %eax
180006cc5:     	movaps	0x1b0(%rsp), %xmm6
180006ccd:     	movaps	0x1c0(%rsp), %xmm7
180006cd5:     	movaps	0x1d0(%rsp), %xmm8
180006cde:     	addq	$0x1e8, %rsp            # imm = 0x1E8
180006ce5:     	popq	%rbx
180006ce6:     	popq	%rbp
180006ce7:     	popq	%rdi
180006ce8:     	popq	%rsi
180006ce9:     	popq	%r12
180006ceb:     	popq	%r13
180006ced:     	popq	%r14
180006cef:     	popq	%r15
180006cf1:     	retq
180006cf2:     	movapd	%xmm1, %xmm3
180006cf6:     	mulsd	%xmm1, %xmm3
180006cfa:     	ucomisd	0x66ce(%rip), %xmm3     # 0x18000d3d0
180006d02:     	setae	%dl
180006d05:     	andb	%dl, %al
180006d07:     	cmpb	$0x1, %al
180006d09:     	jne	0x180006d19 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3159>
180006d0b:     	movb	$0x1, (%r14)
180006d0f:     	movq	$0x3d090c, 0x18(%rbx)   # imm = 0x3D090C
180006d17:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
180006d19:     	movapd	%xmm2, %xmm4
180006d1d:     	mulsd	%xmm2, %xmm4
180006d21:     	addsd	%xmm4, %xmm3
180006d25:     	xorps	%xmm4, %xmm4
180006d28:     	sqrtsd	%xmm3, %xmm4
180006d2c:     	cmpq	$0x0, 0x18(%r12,%rsi,8)
180006d32:     	je	0x180006d89 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31c9>
180006d34:     	movq	(%r12,%rsi,8), %rax
180006d38:     	testq	%rax, %rax
180006d3b:     	js	0x180006d49 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3189>
180006d3d:     	xorpd	%xmm5, %xmm5
180006d41:     	ucomisd	%xmm5, %xmm3
180006d45:     	jne	0x180006d6b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31ab>
180006d47:     	jp	0x180006d6b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31ab>
180006d49:     	movb	$0x1, (%r14)
180006d4d:     	movq	$0x3d090f, 0x18(%rbx)   # imm = 0x3D090F
180006d55:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
180006d5a:     	movb	$0x1, (%r14)
180006d5e:     	movq	$0x3d090b, 0x18(%rbx)   # imm = 0x3D090B
180006d66:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
180006d6b:     	movsd	0x330(%rsp), %xmm6
180006d74:     	movsd	0x8(%r15,%rax,8), %xmm3
180006d7b:     	addsd	%xmm3, %xmm3
180006d7f:     	divsd	%xmm4, %xmm3
180006d83:     	ucomisd	%xmm3, %xmm6
180006d87:     	jbe	0x180006df7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3237>
180006d89:     	movsd	0x6647(%rip), %xmm3     # 0x18000d3d8
180006d91:     	maxsd	%xmm4, %xmm3
180006d95:     	movapd	%xmm3, %xmm4
180006d99:     	mulsd	%xmm3, %xmm4
180006d9d:     	xorpd	%xmm5, %xmm5
180006da1:     	ucomisd	%xmm5, %xmm4
180006da5:     	jne	0x180006dba <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31fa>
180006da7:     	jp	0x180006dba <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x31fa>
180006da9:     	movb	$0x1, (%r14)
180006dad:     	movq	$0x3d0915, 0x18(%rbx)   # imm = 0x3D0915
180006db5:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
180006dba:     	movsd	0x8(%r15,%rbp,8), %xmm5
180006dc1:     	mulsd	0x6617(%rip), %xmm5     # 0x18000d3e0
180006dc9:     	mulsd	%xmm5, %xmm0
180006dcd:     	divsd	%xmm4, %xmm0
180006dd1:     	mulsd	%xmm0, %xmm1
180006dd5:     	divsd	%xmm3, %xmm1
180006dd9:     	mulsd	%xmm0, %xmm2
180006ddd:     	divsd	%xmm3, %xmm2
180006de1:     	movsd	%xmm2, 0x10(%rcx)
180006de6:     	movsd	%xmm1, (%rcx)
180006dea:     	movb	$0x0, 0x18(%rcx)
180006dee:     	movb	$0x0, 0x8(%rcx)
180006df2:     	jmp	0x180006cc3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3103>
180006df7:     	movq	0x290(%rsp), %rdi
180006dff:     	movq	0x20(%r12,%rsi,8), %rax
180006e04:     	testq	%rax, %rax
180006e07:     	movb	$0x1, %r11b
180006e0a:     	js	0x180007031 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3471>
180006e10:     	movq	0x8(%rbx), %rdx
180006e14:     	leaq	0x1(%rdx), %r10
180006e18:     	movq	%r10, 0x8(%rbx)
180006e1c:     	cmpq	0x10(%rbx), %rdx
180006e20:     	jge	0x18000726b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x36ab>
180006e26:     	movq	%rdi, %rdx
180006e29:     	movq	%rcx, %rdi
180006e2c:     	movsd	%xmm6, 0x100(%rsp)
180006e35:     	movq	%rbp, 0xf8(%rsp)
180006e3d:     	movq	%rax, 0xf0(%rsp)
180006e45:     	movq	0x318(%rsp), %rax
180006e4d:     	movq	%rax, 0xe8(%rsp)
180006e55:     	movq	0x310(%rsp), %rax
180006e5d:     	movq	%rax, 0xe0(%rsp)
180006e65:     	movq	%r14, 0xd8(%rsp)
180006e6d:     	movq	0x300(%rsp), %rax
180006e75:     	movq	%rax, 0xd0(%rsp)
180006e7d:     	movq	0x2f8(%rsp), %rax
180006e85:     	movq	%rax, 0xc8(%rsp)
180006e8d:     	movq	0x2f0(%rsp), %rax
180006e95:     	movq	%rax, 0xc0(%rsp)
180006e9d:     	movq	0x2e8(%rsp), %rax
180006ea5:     	movq	%rax, 0xb8(%rsp)
180006ead:     	movq	0x2e0(%rsp), %rax
180006eb5:     	movq	%rax, 0xb0(%rsp)
180006ebd:     	movq	0x2d8(%rsp), %rax
180006ec5:     	movq	%rax, 0xa8(%rsp)
180006ecd:     	movq	%rbx, 0xa0(%rsp)
180006ed5:     	movq	0x2c8(%rsp), %rax
180006edd:     	movq	%rax, 0x98(%rsp)
180006ee5:     	movq	0x2c0(%rsp), %rax
180006eed:     	movq	%rax, 0x90(%rsp)
180006ef5:     	movq	0x2b8(%rsp), %rax
180006efd:     	movq	%rax, 0x88(%rsp)
180006f05:     	movq	0x2b0(%rsp), %rax
180006f0d:     	movq	%rax, 0x80(%rsp)
180006f15:     	movq	0x2a8(%rsp), %rax
180006f1d:     	movq	%rax, 0x78(%rsp)
180006f22:     	movq	%r13, 0x70(%rsp)
180006f27:     	movq	%r12, 0x68(%rsp)
180006f2c:     	movq	%rdx, 0x60(%rsp)
180006f31:     	movq	0x288(%rsp), %rax
180006f39:     	movq	%rax, 0x58(%rsp)
180006f3e:     	movq	0x280(%rsp), %rax
180006f46:     	movq	%rax, 0x50(%rsp)
180006f4b:     	movq	0x278(%rsp), %rax
180006f53:     	movq	%rax, 0x48(%rsp)
180006f58:     	movq	0x270(%rsp), %rax
180006f60:     	movq	%rax, 0x40(%rsp)
180006f65:     	movq	0x268(%rsp), %rax
180006f6d:     	movq	%rax, 0x38(%rsp)
180006f72:     	movq	%r15, 0x30(%rsp)
180006f77:     	movq	0x258(%rsp), %rax
180006f7f:     	movq	%rax, 0x28(%rsp)
180006f84:     	movq	0x250(%rsp), %rax
180006f8c:     	movq	%rax, 0x20(%rsp)
180006f91:     	leaq	0x190(%rsp), %rcx
180006f99:     	movq	%r8, 0x120(%rsp)
180006fa1:     	movq	%r9, 0x128(%rsp)
180006fa9:     	callq	0x180006a50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e90>
180006fae:     	movzbl	0x198(%rsp), %ecx
180006fb6:     	testb	%cl, %cl
180006fb8:     	setne	%dl
180006fbb:     	cmpb	$0x0, (%r14)
180006fbf:     	jne	0x18000700d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x344d>
180006fc1:     	movsd	0x1a0(%rsp), %xmm0
180006fca:     	movzbl	0x1a8(%rsp), %eax
180006fd2:     	movsd	0x190(%rsp), %xmm7
180006fdb:     	decq	0x8(%rbx)
180006fdf:     	testb	%cl, %cl
180006fe1:     	je	0x18000728d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x36cd>
180006fe7:     	movapd	0x63d1(%rip), %xmm1     # 0x18000d3c0
180006fef:     	andpd	%xmm7, %xmm1
180006ff3:     	ucomisd	0x63d5(%rip), %xmm1     # 0x18000d3d0
180006ffb:     	jb	0x18000728d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x36cd>
180007001:     	movb	$0x1, (%r14)
180007005:     	movq	$0x3d0922, 0x18(%rbx)   # imm = 0x3D0922
18000700d:     	movq	$0x0, 0x18(%rdi)
180007015:     	movq	$0x0, 0x10(%rdi)
18000701d:     	movq	$0x0, 0x8(%rdi)
180007025:     	movq	$0x0, (%rdi)
18000702c:     	jmp	0x180006cc3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3103>
180007031:     	xorpd	%xmm7, %xmm7
180007035:     	movb	$0x1, 0x117(%rsp)
18000703d:     	xorpd	%xmm8, %xmm8
180007042:     	movq	0x28(%r12,%rsi,8), %rax
180007047:     	testq	%rax, %rax
18000704a:     	js	0x18000737f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x37bf>
180007050:     	movq	0x8(%rbx), %rdx
180007054:     	leaq	0x1(%rdx), %r10
180007058:     	movq	%r10, 0x8(%rbx)
18000705c:     	cmpq	0x10(%rbx), %rdx
180007060:     	jge	0x18000727c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x36bc>
180007066:     	movl	%r11d, 0x128(%rsp)
18000706e:     	movq	%rcx, 0x118(%rsp)
180007076:     	movsd	%xmm6, 0x100(%rsp)
18000707f:     	movq	%rbp, 0xf8(%rsp)
180007087:     	movq	%rax, 0xf0(%rsp)
18000708f:     	movq	0x318(%rsp), %rax
180007097:     	movq	%rax, 0xe8(%rsp)
18000709f:     	movq	0x310(%rsp), %rax
1800070a7:     	movq	%rax, 0xe0(%rsp)
1800070af:     	movq	%r14, 0xd8(%rsp)
1800070b7:     	movq	0x300(%rsp), %rax
1800070bf:     	movq	%rax, 0xd0(%rsp)
1800070c7:     	movq	0x2f8(%rsp), %rax
1800070cf:     	movq	%rax, 0xc8(%rsp)
1800070d7:     	movq	0x2f0(%rsp), %rax
1800070df:     	movq	%rax, 0xc0(%rsp)
1800070e7:     	movq	0x2e8(%rsp), %rax
1800070ef:     	movq	%rax, 0xb8(%rsp)
1800070f7:     	movq	0x2e0(%rsp), %rax
1800070ff:     	movq	%rax, 0xb0(%rsp)
180007107:     	movq	0x2d8(%rsp), %rax
18000710f:     	movq	%rax, 0xa8(%rsp)
180007117:     	movq	%rbx, 0xa0(%rsp)
18000711f:     	movq	0x2c8(%rsp), %rax
180007127:     	movq	%rax, 0x98(%rsp)
18000712f:     	movq	0x2c0(%rsp), %rax
180007137:     	movq	%rax, 0x90(%rsp)
18000713f:     	movq	0x2b8(%rsp), %rax
180007147:     	movq	%rax, 0x88(%rsp)
18000714f:     	movq	0x2b0(%rsp), %rax
180007157:     	movq	%rax, 0x80(%rsp)
18000715f:     	movq	0x2a8(%rsp), %rax
180007167:     	movq	%rax, 0x78(%rsp)
18000716c:     	movq	%r13, 0x70(%rsp)
180007171:     	movq	%r12, 0x68(%rsp)
180007176:     	movq	%rdi, 0x60(%rsp)
18000717b:     	movq	0x288(%rsp), %rax
180007183:     	movq	%rax, 0x58(%rsp)
180007188:     	movq	0x280(%rsp), %rax
180007190:     	movq	%rax, 0x50(%rsp)
180007195:     	movq	0x278(%rsp), %rax
18000719d:     	movq	%rax, 0x48(%rsp)
1800071a2:     	movq	0x270(%rsp), %rax
1800071aa:     	movq	%rax, 0x40(%rsp)
1800071af:     	movq	0x268(%rsp), %rax
1800071b7:     	movq	%rax, 0x38(%rsp)
1800071bc:     	movq	%r15, 0x30(%rsp)
1800071c1:     	movq	0x258(%rsp), %rax
1800071c9:     	movq	%rax, 0x28(%rsp)
1800071ce:     	movq	0x250(%rsp), %rax
1800071d6:     	movq	%rax, 0x20(%rsp)
1800071db:     	leaq	0x170(%rsp), %rcx
1800071e3:     	movq	%r8, 0x120(%rsp)
1800071eb:     	movq	%r9, %rdi
1800071ee:     	callq	0x180006a50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e90>
1800071f3:     	cmpb	$0x0, (%r14)
1800071f7:     	jne	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
1800071fd:     	movsd	0x180(%rsp), %xmm0
180007206:     	movzbl	0x188(%rsp), %eax
18000720e:     	cmpb	$0x0, 0x178(%rsp)
180007216:     	setne	%cl
180007219:     	addsd	0x170(%rsp), %xmm7
180007222:     	decq	0x8(%rbx)
180007226:     	movzbl	0x117(%rsp), %edx
18000722e:     	andb	%cl, %dl
180007230:     	movb	%dl, 0x117(%rsp)
180007237:     	cmpb	$0x1, %dl
18000723a:     	jne	0x1800072f0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3730>
180007240:     	movapd	0x6178(%rip), %xmm1     # 0x18000d3c0
180007248:     	andpd	%xmm7, %xmm1
18000724c:     	ucomisd	0x617c(%rip), %xmm1     # 0x18000d3d0
180007254:     	jb	0x1800072f0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3730>
18000725a:     	movb	$0x1, (%r14)
18000725e:     	movq	$0x3d0927, 0x18(%rbx)   # imm = 0x3D0927
180007266:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
18000726b:     	movb	$0x1, (%r14)
18000726f:     	movq	$0x3d0921, 0x18(%rbx)   # imm = 0x3D0921
180007277:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
18000727c:     	movb	$0x1, (%r14)
180007280:     	movq	$0x3d0926, 0x18(%rbx)   # imm = 0x3D0926
180007288:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
18000728d:     	movb	%dl, 0x117(%rsp)
180007294:     	xorpd	%xmm8, %xmm8
180007299:     	addsd	%xmm8, %xmm7
18000729e:     	testb	%al, %al
1800072a0:     	addsd	%xmm0, %xmm8
1800072a5:     	je	0x180007346 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3786>
1800072ab:     	andpd	0x610d(%rip), %xmm0     # 0x18000d3c0
1800072b3:     	ucomisd	0x6115(%rip), %xmm0     # 0x18000d3d0
1800072bb:     	movq	%rdi, %rcx
1800072be:     	movq	0x128(%rsp), %r9
1800072c6:     	movq	0x120(%rsp), %r8
1800072ce:     	movb	$0x1, %r11b
1800072d1:     	movq	0x290(%rsp), %rdi
1800072d9:     	jb	0x180007042 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3482>
1800072df:     	movb	$0x1, (%r14)
1800072e3:     	movq	$0x3d0923, 0x18(%rbx)   # imm = 0x3D0923
1800072eb:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
1800072f0:     	addsd	%xmm0, %xmm8
1800072f5:     	testb	%al, %al
1800072f7:     	setne	%al
1800072fa:     	movl	0x128(%rsp), %ecx
180007301:     	andb	%al, %cl
180007303:     	cmpb	$0x1, %cl
180007306:     	jne	0x180007369 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x37a9>
180007308:     	movapd	0x60b0(%rip), %xmm0     # 0x18000d3c0
180007310:     	andpd	%xmm8, %xmm0
180007315:     	movb	$0x1, %r11b
180007318:     	ucomisd	0x60b0(%rip), %xmm0     # 0x18000d3d0
180007320:     	movq	0x118(%rsp), %rcx
180007328:     	movq	%rdi, %r9
18000732b:     	movq	0x120(%rsp), %r8
180007333:     	jb	0x18000737f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x37bf>
180007335:     	movb	$0x1, (%r14)
180007339:     	movq	$0x3d0928, 0x18(%rbx)   # imm = 0x3D0928
180007341:     	jmp	0x180006ca4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x30e4>
180007346:     	xorl	%r11d, %r11d
180007349:     	movq	%rdi, %rcx
18000734c:     	movq	0x128(%rsp), %r9
180007354:     	movq	0x120(%rsp), %r8
18000735c:     	movq	0x290(%rsp), %rdi
180007364:     	jmp	0x180007042 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3482>
180007369:     	xorl	%r11d, %r11d
18000736c:     	movq	0x118(%rsp), %rcx
180007374:     	movq	%rdi, %r9
180007377:     	movq	0x120(%rsp), %r8
18000737f:     	movq	0x38(%r12,%rsi,8), %rax
180007384:     	testq	%rax, %rax
180007387:     	movq	%rcx, 0x118(%rsp)
18000738f:     	js	0x1800075f0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3a30>
180007395:     	movq	0x8(%rbx), %rcx
180007399:     	leaq	0x1(%rcx), %rdx
18000739d:     	movq	%rdx, 0x8(%rbx)
1800073a1:     	cmpq	0x10(%rbx), %rcx
1800073a5:     	jge	0x18000785c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3c9c>
1800073ab:     	movl	%r11d, %edi
1800073ae:     	movsd	%xmm6, 0x100(%rsp)
1800073b7:     	movq	%rbp, 0xf8(%rsp)
1800073bf:     	movq	%rax, 0xf0(%rsp)
1800073c7:     	movq	0x318(%rsp), %rax
1800073cf:     	movq	%rax, 0xe8(%rsp)
1800073d7:     	movq	0x310(%rsp), %rax
1800073df:     	movq	%rax, 0xe0(%rsp)
1800073e7:     	movq	%r14, 0xd8(%rsp)
1800073ef:     	movq	0x300(%rsp), %rax
1800073f7:     	movq	%rax, 0xd0(%rsp)
1800073ff:     	movq	0x2f8(%rsp), %rax
180007407:     	movq	%rax, 0xc8(%rsp)
18000740f:     	movq	0x2f0(%rsp), %rax
180007417:     	movq	%rax, 0xc0(%rsp)
18000741f:     	movq	0x2e8(%rsp), %rax
180007427:     	movq	%rax, 0xb8(%rsp)
18000742f:     	movq	0x2e0(%rsp), %rax
180007437:     	movq	%rax, 0xb0(%rsp)
18000743f:     	movq	0x2d8(%rsp), %rax
180007447:     	movq	%rax, 0xa8(%rsp)
18000744f:     	movq	%rbx, 0xa0(%rsp)
180007457:     	movq	0x2c8(%rsp), %rax
18000745f:     	movq	%rax, 0x98(%rsp)
180007467:     	movq	0x2c0(%rsp), %rax
18000746f:     	movq	%rax, 0x90(%rsp)
180007477:     	movq	0x2b8(%rsp), %rax
18000747f:     	movq	%rax, 0x88(%rsp)
180007487:     	movq	0x2b0(%rsp), %rax
18000748f:     	movq	%rax, 0x80(%rsp)
180007497:     	movq	0x2a8(%rsp), %rax
18000749f:     	movq	%rax, 0x78(%rsp)
1800074a4:     	movq	%r13, 0x70(%rsp)
1800074a9:     	movq	%r12, 0x68(%rsp)
1800074ae:     	movq	0x290(%rsp), %rax
1800074b6:     	movq	%rax, 0x60(%rsp)
1800074bb:     	movq	0x288(%rsp), %rax
1800074c3:     	movq	%rax, 0x58(%rsp)
1800074c8:     	movq	0x280(%rsp), %rax
1800074d0:     	movq	%rax, 0x50(%rsp)
1800074d5:     	movq	0x278(%rsp), %rax
1800074dd:     	movq	%rax, 0x48(%rsp)
1800074e2:     	movq	0x270(%rsp), %rax
1800074ea:     	movq	%rax, 0x40(%rsp)
1800074ef:     	movq	0x268(%rsp), %rax
1800074f7:     	movq	%rax, 0x38(%rsp)
1800074fc:     	movq	%r15, 0x30(%rsp)
180007501:     	movq	0x258(%rsp), %rax
180007509:     	movq	%rax, 0x28(%rsp)
18000750e:     	movq	0x250(%rsp), %rax
180007516:     	movq	%rax, 0x20(%rsp)
18000751b:     	leaq	0x150(%rsp), %rcx
180007523:     	movq	%r8, 0x120(%rsp)
18000752b:     	movq	%r9, 0x128(%rsp)
180007533:     	callq	0x180006a50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e90>
180007538:     	cmpb	$0x0, (%r14)
18000753c:     	jne	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
180007542:     	movsd	0x160(%rsp), %xmm0
18000754b:     	movzbl	0x168(%rsp), %eax
180007553:     	cmpb	$0x0, 0x158(%rsp)
18000755b:     	setne	%cl
18000755e:     	addsd	0x150(%rsp), %xmm7
180007567:     	decq	0x8(%rbx)
18000756b:     	movzbl	0x117(%rsp), %edx
180007573:     	andb	%cl, %dl
180007575:     	movb	%dl, 0x117(%rsp)
18000757c:     	cmpb	$0x1, %dl
18000757f:     	jne	0x1800075a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x39e3>
180007581:     	movapd	0x5e37(%rip), %xmm1     # 0x18000d3c0
180007589:     	andpd	%xmm7, %xmm1
18000758d:     	ucomisd	0x5e3b(%rip), %xmm1     # 0x18000d3d0
180007595:     	jae	0x1800078b4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cf4>
18000759b:     	xorpd	%xmm1, %xmm1
18000759f:     	addsd	%xmm1, %xmm7
1800075a3:     	addsd	%xmm0, %xmm8
1800075a8:     	testb	%al, %al
1800075aa:     	setne	%al
1800075ad:     	andb	%al, %dil
1800075b0:     	cmpb	$0x1, %dil
1800075b4:     	jne	0x1800078a2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3ce2>
1800075ba:     	movapd	0x5dfe(%rip), %xmm0     # 0x18000d3c0
1800075c2:     	andpd	%xmm8, %xmm0
1800075c7:     	ucomisd	0x5e01(%rip), %xmm0     # 0x18000d3d0
1800075cf:     	jae	0x1800078c2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d02>
1800075d5:     	xorpd	%xmm0, %xmm0
1800075d9:     	addsd	%xmm0, %xmm8
1800075de:     	movb	$0x1, %dil
1800075e1:     	movq	0x40(%r12,%rsi,8), %rax
1800075e6:     	testq	%rax, %rax
1800075e9:     	jns	0x180007611 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3a51>
1800075eb:     	jmp	0x1800078d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d12>
1800075f0:     	movl	%r11d, %edi
1800075f3:     	movq	%r8, 0x120(%rsp)
1800075fb:     	movq	%r9, 0x128(%rsp)
180007603:     	movq	0x40(%r12,%rsi,8), %rax
180007608:     	testq	%rax, %rax
18000760b:     	js	0x1800078d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d12>
180007611:     	movq	0x8(%rbx), %rcx
180007615:     	leaq	0x1(%rcx), %rdx
180007619:     	movq	%rdx, 0x8(%rbx)
18000761d:     	cmpq	0x10(%rbx), %rcx
180007621:     	jge	0x18000786a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3caa>
180007627:     	movq	%rbp, 0xf8(%rsp)
18000762f:     	movq	%rax, 0xf0(%rsp)
180007637:     	movq	0x318(%rsp), %rax
18000763f:     	movq	%rax, 0xe8(%rsp)
180007647:     	movq	0x310(%rsp), %rax
18000764f:     	movq	%rax, 0xe0(%rsp)
180007657:     	movq	0x300(%rsp), %rax
18000765f:     	movq	%rax, 0xd0(%rsp)
180007667:     	movq	0x2f8(%rsp), %rax
18000766f:     	movq	%rax, 0xc8(%rsp)
180007677:     	movq	0x2f0(%rsp), %rax
18000767f:     	movq	%rax, 0xc0(%rsp)
180007687:     	movq	0x2e8(%rsp), %rax
18000768f:     	movq	%rax, 0xb8(%rsp)
180007697:     	movq	0x2e0(%rsp), %rax
18000769f:     	movq	%rax, 0xb0(%rsp)
1800076a7:     	movq	0x2d8(%rsp), %rax
1800076af:     	movq	%rax, 0xa8(%rsp)
1800076b7:     	movq	0x2c8(%rsp), %rax
1800076bf:     	movq	%rax, 0x98(%rsp)
1800076c7:     	movq	0x2c0(%rsp), %rax
1800076cf:     	movq	%rax, 0x90(%rsp)
1800076d7:     	movq	0x2b8(%rsp), %rax
1800076df:     	movq	%rax, 0x88(%rsp)
1800076e7:     	movq	0x2b0(%rsp), %rax
1800076ef:     	movq	%rax, 0x80(%rsp)
1800076f7:     	movq	0x2a8(%rsp), %rax
1800076ff:     	movq	%rax, 0x78(%rsp)
180007704:     	movq	%r13, 0x70(%rsp)
180007709:     	movq	%r12, 0x68(%rsp)
18000770e:     	movq	0x290(%rsp), %rax
180007716:     	movq	%rax, 0x60(%rsp)
18000771b:     	movq	0x288(%rsp), %rax
180007723:     	movq	%rax, 0x58(%rsp)
180007728:     	movq	0x280(%rsp), %rax
180007730:     	movq	%rax, 0x50(%rsp)
180007735:     	movq	0x278(%rsp), %rax
18000773d:     	movq	%rax, 0x48(%rsp)
180007742:     	movq	0x270(%rsp), %rax
18000774a:     	movq	%rax, 0x40(%rsp)
18000774f:     	movq	0x268(%rsp), %rax
180007757:     	movq	%rax, 0x38(%rsp)
18000775c:     	movq	%r15, 0x30(%rsp)
180007761:     	movq	0x258(%rsp), %rax
180007769:     	movq	%rax, 0x28(%rsp)
18000776e:     	movsd	%xmm6, 0x100(%rsp)
180007777:     	movq	%r14, 0xd8(%rsp)
18000777f:     	movq	%rbx, 0xa0(%rsp)
180007787:     	movq	0x250(%rsp), %rax
18000778f:     	movq	%rax, 0x20(%rsp)
180007794:     	leaq	0x130(%rsp), %rcx
18000779c:     	movq	0x120(%rsp), %r8
1800077a4:     	movq	0x128(%rsp), %r9
1800077ac:     	callq	0x180006a50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x2e90>
1800077b1:     	cmpb	$0x0, (%r14)
1800077b5:     	jne	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
1800077bb:     	movsd	0x140(%rsp), %xmm0
1800077c4:     	movzbl	0x148(%rsp), %eax
1800077cc:     	cmpb	$0x0, 0x138(%rsp)
1800077d4:     	setne	%cl
1800077d7:     	addsd	0x130(%rsp), %xmm7
1800077e0:     	decq	0x8(%rbx)
1800077e4:     	movzbl	0x117(%rsp), %edx
1800077ec:     	andb	%cl, %dl
1800077ee:     	movb	%dl, 0x117(%rsp)
1800077f5:     	cmpb	$0x1, %dl
1800077f8:     	jne	0x18000781c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3c5c>
1800077fa:     	movapd	0x5bbe(%rip), %xmm1     # 0x18000d3c0
180007802:     	andpd	%xmm7, %xmm1
180007806:     	ucomisd	0x5bc2(%rip), %xmm1     # 0x18000d3d0
18000780e:     	jae	0x1800078f8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d38>
180007814:     	xorpd	%xmm1, %xmm1
180007818:     	addsd	%xmm1, %xmm7
18000781c:     	testb	%al, %al
18000781e:     	setne	%al
180007821:     	addsd	%xmm0, %xmm8
180007826:     	andb	%al, %dil
180007829:     	cmpb	$0x1, %dil
18000782d:     	jne	0x1800078d0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d10>
180007833:     	movapd	0x5b85(%rip), %xmm0     # 0x18000d3c0
18000783b:     	andpd	%xmm8, %xmm0
180007840:     	ucomisd	0x5b88(%rip), %xmm0     # 0x18000d3d0
180007848:     	jae	0x180007909 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d49>
18000784e:     	xorpd	%xmm0, %xmm0
180007852:     	addsd	%xmm0, %xmm8
180007857:     	movb	$0x1, %dil
18000785a:     	jmp	0x1800078d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d12>
18000785c:     	movb	$0x1, (%r14)
180007860:     	movq	$0x3d092b, 0x18(%rbx)   # imm = 0x3D092B
180007868:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
18000786a:     	movb	$0x1, (%r14)
18000786e:     	movq	$0x3d0930, 0x18(%rbx)   # imm = 0x3D0930
180007876:     	movq	0x118(%rsp), %rax
18000787e:     	movq	$0x0, 0x18(%rax)
180007886:     	movq	$0x0, 0x10(%rax)
18000788e:     	movq	$0x0, 0x8(%rax)
180007896:     	movq	$0x0, (%rax)
18000789d:     	jmp	0x180006cc3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3103>
1800078a2:     	xorl	%edi, %edi
1800078a4:     	movq	0x40(%r12,%rsi,8), %rax
1800078a9:     	testq	%rax, %rax
1800078ac:     	jns	0x180007611 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3a51>
1800078b2:     	jmp	0x1800078d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d12>
1800078b4:     	movb	$0x1, (%r14)
1800078b8:     	movq	$0x3d092c, 0x18(%rbx)   # imm = 0x3D092C
1800078c0:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
1800078c2:     	movb	$0x1, (%r14)
1800078c6:     	movq	$0x3d092d, 0x18(%rbx)   # imm = 0x3D092D
1800078ce:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
1800078d0:     	xorl	%edi, %edi
1800078d2:     	movq	0x118(%rsp), %rax
1800078da:     	movb	%dil, 0x18(%rax)
1800078de:     	movsd	%xmm8, 0x10(%rax)
1800078e4:     	movzbl	0x117(%rsp), %ecx
1800078ec:     	movb	%cl, 0x8(%rax)
1800078ef:     	movsd	%xmm7, (%rax)
1800078f3:     	jmp	0x180006cc3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3103>
1800078f8:     	movb	$0x1, (%r14)
1800078fc:     	movq	$0x3d0931, 0x18(%rbx)   # imm = 0x3D0931
180007904:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
180007909:     	movb	$0x1, (%r14)
18000790d:     	movq	$0x3d0932, 0x18(%rbx)   # imm = 0x3D0932
180007915:     	jmp	0x180007876 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3cb6>
18000791a:     	nopw	(%rax,%rax)
180007920:     	pushq	%r15
180007922:     	pushq	%r14
180007924:     	pushq	%r13
180007926:     	pushq	%r12
180007928:     	pushq	%rsi
180007929:     	pushq	%rdi
18000792a:     	pushq	%rbp
18000792b:     	pushq	%rbx
18000792c:     	subq	$0x1c8, %rsp            # imm = 0x1C8
180007933:     	movq	0x300(%rsp), %rax
18000793b:     	movq	0x2e8(%rsp), %r15
180007943:     	movq	0x2b0(%rsp), %r12
18000794b:     	movb	$0x0, 0x12f(%rsp)
180007953:     	movq	$0x0, 0x1a8(%rsp)
18000795f:     	movb	$0x0, 0x11f(%rsp)
180007967:     	movq	$0x0, 0x1a0(%rsp)
180007973:     	movb	$0x0, 0x11e(%rsp)
18000797b:     	movq	$0x0, 0x198(%rsp)
180007987:     	movb	$0x0, 0x11d(%rsp)
18000798f:     	movq	$0x0, 0x190(%rsp)
18000799b:     	movb	$0x0, 0x11c(%rsp)
1800079a3:     	movq	$0x0, 0x188(%rsp)
1800079af:     	movb	$0x0, 0x12e(%rsp)
1800079b7:     	movq	$0x0, 0x180(%rsp)
1800079c3:     	movb	$0x0, 0x12d(%rsp)
1800079cb:     	movq	$0x0, 0x178(%rsp)
1800079d7:     	movb	$0x0, 0x12c(%rsp)
1800079df:     	movq	$0x0, 0x170(%rsp)
1800079eb:     	movb	$0x0, 0x12b(%rsp)
1800079f3:     	movq	$0x0, 0x168(%rsp)
1800079ff:     	cmpq	$0x1, %rax
180007a03:     	movq	0x280(%rsp), %rbx
180007a0b:     	movq	0x278(%rsp), %r13
180007a13:     	movq	0x258(%rsp), %rdi
180007a1b:     	movq	0x248(%rsp), %r14
180007a23:     	movq	0x240(%rsp), %rbp
180007a2b:     	je	0x180007ad2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f12>
180007a31:     	testq	%rax, %rax
180007a34:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007a3a:     	movq	0x308(%rsp), %rsi
180007a42:     	movq	(%r13,%rsi,8), %rax
180007a47:     	testq	%rax, %rax
180007a4a:     	js	0x180007aff <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f3f>
180007a50:     	movq	0x310(%rsp), %r10
180007a58:     	testq	%r10, %r10
180007a5b:     	js	0x180007aff <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f3f>
180007a61:     	movq	0x10(%r13,%r10,8), %r11
180007a66:     	testq	%r11, %r11
180007a69:     	js	0x180007b8f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3fcf>
180007a6f:     	movsd	(%rbp,%r11,8), %xmm0
180007a76:     	movsd	0x8(%rbp,%rax,8), %xmm2
180007a7c:     	movsd	0x10(%rbp,%rax,8), %xmm1
180007a82:     	movapd	%xmm1, %xmm3
180007a86:     	subsd	%xmm2, %xmm3
180007a8a:     	xorl	%r10d, %r10d
180007a8d:     	ucomisd	%xmm3, %xmm0
180007a91:     	jb	0x180007bb1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3ff1>
180007a97:     	addsd	%xmm2, %xmm1
180007a9b:     	ucomisd	%xmm0, %xmm1
180007a9f:     	jbe	0x180007bb1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3ff1>
180007aa5:     	movsd	0x10(%rbp,%r11,8), %xmm0
180007aac:     	movsd	(%rbp,%rax,8), %xmm1
180007ab2:     	movsd	0x18(%rbp,%rax,8), %xmm2
180007ab8:     	movapd	%xmm2, %xmm3
180007abc:     	subsd	%xmm1, %xmm3
180007ac0:     	ucomisd	%xmm3, %xmm0
180007ac4:     	jae	0x180007ba5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3fe5>
180007aca:     	xorl	%r10d, %r10d
180007acd:     	jmp	0x180007bb1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3ff1>
180007ad2:     	movq	0x318(%rsp), %rsi
180007ada:     	testq	%rsi, %rsi
180007add:     	js	0x180007b11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f51>
180007adf:     	movq	(%r13,%rsi,8), %rax
180007ae4:     	testq	%rax, %rax
180007ae7:     	js	0x180007b11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f51>
180007ae9:     	movq	(%r12), %r10
180007aed:     	leaq	0x4(%r10), %r11
180007af1:     	cmpq	%rbx, %r11
180007af4:     	jle	0x180007b23 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f63>
180007af6:     	movb	$0x2, (%r15)
180007afa:     	jmp	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007aff:     	movb	$0x1, (%r15)
180007b03:     	movq	$0x2dc6c2, 0x18(%r12)   # imm = 0x2DC6C2
180007b0c:     	jmp	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007b11:     	movb	$0x1, (%r15)
180007b15:     	movq	$0x989682, 0x18(%r12)   # imm = 0x989682
180007b1e:     	jmp	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007b23:     	movsd	0x10(%rbp,%rax,8), %xmm1
180007b29:     	movsd	0x18(%rbp,%rax,8), %xmm2
180007b2f:     	movsd	0x5879(%rip), %xmm0     # 0x18000d3b0
180007b37:     	movsd	0x8(%rbp,%rax,8), %xmm3
180007b3d:     	mulsd	%xmm0, %xmm3
180007b41:     	mulsd	(%rbp,%rax,8), %xmm0
180007b47:     	movq	%r11, (%r12)
180007b4b:     	cmpb	$0x0, (%r15)
180007b4f:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007b55:     	movapd	%xmm1, %xmm4
180007b59:     	addsd	%xmm3, %xmm4
180007b5d:     	movapd	%xmm2, %xmm5
180007b61:     	subsd	%xmm0, %xmm5
180007b65:     	testq	%r10, %r10
180007b68:     	js	0x180007ccb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x410b>
180007b6e:     	movsd	%xmm4, 0x10(%rbp,%r10,8)
180007b75:     	movsd	%xmm5, 0x18(%rbp,%r10,8)
180007b7c:     	movsd	%xmm3, 0x8(%rbp,%r10,8)
180007b83:     	movsd	%xmm0, (%rbp,%r10,8)
180007b8a:     	jmp	0x180007cd8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4118>
180007b8f:     	movb	$0x1, (%r15)
180007b93:     	movq	$0x7a1202, 0x18(%r12)   # imm = 0x7A1202
180007b9c:     	cmpb	$0x0, (%r15)
180007ba0:     	jmp	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007ba5:     	addsd	%xmm1, %xmm2
180007ba9:     	ucomisd	%xmm0, %xmm2
180007bad:     	seta	%r10b
180007bb1:     	cmpb	$0x0, (%r15)
180007bb5:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007bbb:     	testb	%r10b, %r10b
180007bbe:     	je	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007bc4:     	movq	0x18(%r13,%rsi,8), %rax
180007bc9:     	movq	0x30(%r13,%rsi,8), %rdi
180007bce:     	movq	%rdi, %r11
180007bd1:     	sarq	$0x3f, %r11
180007bd5:     	andq	%rbx, %r11
180007bd8:     	movq	%rdi, %r10
180007bdb:     	leaq	(%r13,%rdi,8), %rdi
180007be0:     	movq	%r11, 0x140(%rsp)
180007be8:     	movq	(%rdi,%r11,8), %r11
180007bec:     	movq	%r11, 0x110(%rsp)
180007bf4:     	cmpq	0x8(%r13,%rsi,8), %r11
180007bf9:     	jge	0x180007e6f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x42af>
180007bff:     	testq	%rax, %rax
180007c02:     	jne	0x180007e78 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x42b8>
180007c08:     	movq	%rdi, %r14
180007c0b:     	xorl	%r8d, %r8d
180007c0e:     	cmpq	$-0x1, %r10
180007c12:     	cmovlq	%rbx, %r8
180007c16:     	movq	0x110(%rsp), %rdx
180007c1e:     	cmpq	0x8(%rdi,%r8,8), %rdx
180007c23:     	jne	0x180008720 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4b60>
180007c29:     	leaq	(%rdx,%rdx), %rax
180007c2d:     	testq	%rdx, %rdx
180007c30:     	movl	$0x4, %r9d
180007c36:     	cmovneq	%rax, %r9
180007c3a:     	movq	(%r12), %r11
180007c3e:     	leaq	(%r11,%r9), %rax
180007c42:     	cmpq	%rbx, %rax
180007c45:     	jg	0x180007af6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f36>
180007c4b:     	movq	%rax, (%r12)
180007c4f:     	cmpb	$0x0, (%r15)
180007c53:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007c59:     	movq	%r14, 0x150(%rsp)
180007c61:     	movq	%r11, 0x148(%rsp)
180007c69:     	movq	%r9, 0x158(%rsp)
180007c71:     	movq	%r8, 0x160(%rsp)
180007c79:     	xorl	%r11d, %r11d
180007c7c:     	movq	%r10, 0x1c0(%rsp)
180007c84:     	cmpq	$-0x2, %r10
180007c88:     	cmovlq	%rbx, %r11
180007c8c:     	testq	%rdx, %rdx
180007c8f:     	jle	0x1800086e6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4b26>
180007c95:     	movq	0x150(%rsp), %rax
180007c9d:     	movq	0x10(%rax,%r11,8), %r14
180007ca2:     	movq	0x110(%rsp), %rax
180007caa:     	movl	%eax, %r10d
180007cad:     	andl	$0x7, %r10d
180007cb1:     	cmpq	$0x7, %rax
180007cb5:     	ja	0x1800084ce <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x490e>
180007cbb:     	leaq	(,%rbx,8), %r8
180007cc3:     	xorl	%r9d, %r9d
180007cc6:     	jmp	0x1800086aa <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4aea>
180007ccb:     	movb	$0x1, (%r15)
180007ccf:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180007cd8:     	cmpb	$0x0, (%r15)
180007cdc:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007ce2:     	movq	(%r12), %r11
180007ce6:     	leaq	0xb(%r11), %rax
180007cea:     	cmpq	%rbx, %rax
180007ced:     	jg	0x180007af6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f36>
180007cf3:     	movq	%r11, 0x140(%rsp)
180007cfb:     	movq	0x8(%r13,%rsi,8), %r11
180007d00:     	movq	%rax, (%r12)
180007d04:     	cmpb	$0x0, (%r15)
180007d08:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007d0e:     	movq	0x140(%rsp), %rax
180007d16:     	movq	%r10, (%r13,%rax,8)
180007d1b:     	movq	%r11, 0x8(%r13,%rax,8)
180007d20:     	movq	(%r12), %r11
180007d24:     	cmpq	%rbx, %r11
180007d27:     	movq	%r11, %r10
180007d2a:     	jle	0x180007d37 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4177>
180007d2c:     	movb	$0x2, (%r15)
180007d30:     	movq	(%r12), %r11
180007d34:     	xorl	%r10d, %r10d
180007d37:     	leaq	0x3(%r11), %rax
180007d3b:     	cmpq	%rbx, %rax
180007d3e:     	jg	0x180007af6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f36>
180007d44:     	movq	%rax, (%r12)
180007d48:     	cmpb	$0x0, (%r15)
180007d4c:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007d52:     	movq	%r11, %rax
180007d55:     	sarq	$0x3f, %rax
180007d59:     	andq	%rbx, %rax
180007d5c:     	movq	%r10, 0x120(%rsp)
180007d64:     	leaq	(%r13,%r11,8), %r10
180007d69:     	movq	$0x0, (%r10,%rax,8)
180007d71:     	movq	$0x0, 0x110(%rsp)
180007d7d:     	cmpq	$-0x1, %r11
180007d81:     	movl	$0x0, %eax
180007d86:     	cmovlq	%rbx, %rax
180007d8a:     	leaq	(%r13,%r11,8), %r10
180007d8f:     	movq	$0x0, 0x8(%r10,%rax,8)
180007d98:     	cmpq	$-0x2, %r11
180007d9c:     	movq	0x110(%rsp), %rax
180007da4:     	cmovlq	%rbx, %rax
180007da8:     	movq	%rax, 0x110(%rsp)
180007db0:     	leaq	(%r13,%r11,8), %rax
180007db5:     	movq	0x120(%rsp), %r10
180007dbd:     	movq	%r11, 0x130(%rsp)
180007dc5:     	movq	0x110(%rsp), %r11
180007dcd:     	movq	%r10, 0x10(%rax,%r11,8)
180007dd2:     	movq	0x130(%rsp), %r11
180007dda:     	cmpb	$0x0, (%r15)
180007dde:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007de4:     	movq	0x140(%rsp), %rax
180007dec:     	leaq	(%r13,%rax,8), %r10
180007df1:     	movq	%r11, 0x30(%r10)
180007df5:     	movq	$0x0, 0x18(%r10)
180007dfd:     	movq	(%r12), %r11
180007e01:     	leaq	0x4(%r11), %rax
180007e05:     	cmpq	%rbx, %rax
180007e08:     	jg	0x180007af6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3f36>
180007e0e:     	movq	%rax, (%r12)
180007e12:     	cmpb	$0x0, (%r15)
180007e16:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180007e1c:     	movq	%r8, 0x130(%rsp)
180007e24:     	movq	%r9, 0x138(%rsp)
180007e2c:     	movq	%rdx, 0x120(%rsp)
180007e34:     	movq	%rcx, 0x110(%rsp)
180007e3c:     	testq	%r11, %r11
180007e3f:     	js	0x180008b3e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4f7e>
180007e45:     	movq	$0x0, (%rbp,%r11,8)
180007e4e:     	leaq	(%r13,%r11,8), %rcx
180007e53:     	movq	$0x1, 0x8(%r13,%r11,8)
180007e5c:     	movq	$0x0, 0x10(%rbp,%r11,8)
180007e65:     	movl	$0x1, %edx
180007e6a:     	jmp	0x180008b4a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4f8a>
180007e6f:     	testq	%rax, %rax
180007e72:     	je	0x180008082 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x44c2>
180007e78:     	movq	0x20(%r13,%rsi,8), %rax
180007e7d:     	testq	%rax, %rax
180007e80:     	js	0x180008291 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46d1>
180007e86:     	movq	0x8(%r12), %r10
180007e8b:     	leaq	0x1(%r10), %r11
180007e8f:     	movq	%r11, 0x8(%r12)
180007e94:     	cmpq	0x10(%r12), %r10
180007e99:     	jge	0x180008291 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46d1>
180007e9f:     	movq	%rdx, 0x120(%rsp)
180007ea7:     	movq	%rcx, 0x110(%rsp)
180007eaf:     	movb	$0x0, 0x11f(%rsp)
180007eb7:     	movq	0x310(%rsp), %rcx
180007ebf:     	movq	%rcx, 0x100(%rsp)
180007ec7:     	movq	%rax, 0xf8(%rsp)
180007ecf:     	movq	0x2f8(%rsp), %rax
180007ed7:     	movq	%rax, 0xe8(%rsp)
180007edf:     	movq	0x2f0(%rsp), %rax
180007ee7:     	movq	%rax, 0xe0(%rsp)
180007eef:     	movq	%r15, 0xd8(%rsp)
180007ef7:     	movq	0x2e0(%rsp), %rax
180007eff:     	movq	%rax, 0xd0(%rsp)
180007f07:     	movq	0x2d8(%rsp), %rax
180007f0f:     	movq	%rax, 0xc8(%rsp)
180007f17:     	movq	0x2d0(%rsp), %rax
180007f1f:     	movq	%rax, 0xc0(%rsp)
180007f27:     	movq	0x2c8(%rsp), %rax
180007f2f:     	movq	%rax, 0xb8(%rsp)
180007f37:     	movq	0x2c0(%rsp), %rax
180007f3f:     	movq	%rax, 0xb0(%rsp)
180007f47:     	movq	0x2b8(%rsp), %rax
180007f4f:     	movq	%rax, 0xa8(%rsp)
180007f57:     	movq	%r12, 0xa0(%rsp)
180007f5f:     	movq	0x2a8(%rsp), %rax
180007f67:     	movq	%rax, 0x98(%rsp)
180007f6f:     	movq	0x2a0(%rsp), %rax
180007f77:     	movq	%rax, 0x90(%rsp)
180007f7f:     	movq	0x298(%rsp), %rax
180007f87:     	movq	%rax, 0x88(%rsp)
180007f8f:     	movq	0x290(%rsp), %rax
180007f97:     	movq	%rax, 0x80(%rsp)
180007f9f:     	movq	0x288(%rsp), %rax
180007fa7:     	movq	%rax, 0x78(%rsp)
180007fac:     	movq	%rbx, 0x70(%rsp)
180007fb1:     	movq	%r13, 0x68(%rsp)
180007fb6:     	movq	0x270(%rsp), %rax
180007fbe:     	movq	%rax, 0x60(%rsp)
180007fc3:     	movq	0x268(%rsp), %rax
180007fcb:     	movq	%rax, 0x58(%rsp)
180007fd0:     	movq	0x260(%rsp), %rax
180007fd8:     	movq	%rax, 0x50(%rsp)
180007fdd:     	movq	0x258(%rsp), %rdi
180007fe5:     	movq	%rdi, 0x48(%rsp)
180007fea:     	movq	0x250(%rsp), %rax
180007ff2:     	movq	%rax, 0x40(%rsp)
180007ff7:     	movq	0x248(%rsp), %r14
180007fff:     	movq	%r14, 0x38(%rsp)
180008004:     	movq	%rbp, 0x30(%rsp)
180008009:     	movq	0x238(%rsp), %rax
180008011:     	movq	%rax, 0x28(%rsp)
180008016:     	movq	0x230(%rsp), %rax
18000801e:     	movq	%rax, 0x20(%rsp)
180008023:     	movq	$-0x1, 0x108(%rsp)
18000802f:     	movq	$0x0, 0xf0(%rsp)
18000803b:     	leaq	0x11f(%rsp), %rcx
180008043:     	leaq	0x1a0(%rsp), %rdx
18000804b:     	movq	%r8, 0x130(%rsp)
180008053:     	movq	%r9, 0x138(%rsp)
18000805b:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180008060:     	testl	%eax, %eax
180008062:     	jne	0x18000890f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d4f>
180008068:     	cmpb	$0x0, (%r15)
18000806c:     	movq	0x110(%rsp), %rax
180008074:     	je	0x1800082c6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4706>
18000807a:     	movb	$0x0, (%rax)
18000807d:     	jmp	0x1800082a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46e1>
180008082:     	movq	0x8(%r12), %rax
180008087:     	leaq	0x1(%rax), %r10
18000808b:     	movq	%r10, 0x8(%r12)
180008090:     	cmpq	0x10(%r12), %rax
180008095:     	jge	0x1800082b7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46f7>
18000809b:     	movq	%rdx, 0x120(%rsp)
1800080a3:     	movq	%rcx, 0x110(%rsp)
1800080ab:     	movq	%rsi, 0x108(%rsp)
1800080b3:     	movq	0x2f8(%rsp), %rax
1800080bb:     	movq	%rax, 0xe8(%rsp)
1800080c3:     	movq	0x2f0(%rsp), %rax
1800080cb:     	movq	%rax, 0xe0(%rsp)
1800080d3:     	movq	%r15, 0xd8(%rsp)
1800080db:     	movq	0x2e0(%rsp), %rax
1800080e3:     	movq	%rax, 0xd0(%rsp)
1800080eb:     	movq	0x2d8(%rsp), %rax
1800080f3:     	movq	%rax, 0xc8(%rsp)
1800080fb:     	movq	0x2d0(%rsp), %rax
180008103:     	movq	%rax, 0xc0(%rsp)
18000810b:     	movq	0x2c8(%rsp), %rax
180008113:     	movq	%rax, 0xb8(%rsp)
18000811b:     	movq	0x2c0(%rsp), %rax
180008123:     	movq	%rax, 0xb0(%rsp)
18000812b:     	movq	0x2b8(%rsp), %rax
180008133:     	movq	%rax, 0xa8(%rsp)
18000813b:     	movq	%r12, 0xa0(%rsp)
180008143:     	movq	0x2a8(%rsp), %rax
18000814b:     	movq	%rax, 0x98(%rsp)
180008153:     	movq	0x2a0(%rsp), %rax
18000815b:     	movq	%rax, 0x90(%rsp)
180008163:     	movq	0x298(%rsp), %rax
18000816b:     	movq	%rax, 0x88(%rsp)
180008173:     	movq	0x290(%rsp), %rax
18000817b:     	movq	%rax, 0x80(%rsp)
180008183:     	movq	0x288(%rsp), %rax
18000818b:     	movq	%rax, 0x78(%rsp)
180008190:     	movq	%rbx, 0x70(%rsp)
180008195:     	movq	%r13, 0x68(%rsp)
18000819a:     	movq	0x270(%rsp), %rax
1800081a2:     	movq	%rax, 0x60(%rsp)
1800081a7:     	movq	0x268(%rsp), %rax
1800081af:     	movq	%rax, 0x58(%rsp)
1800081b4:     	movq	0x260(%rsp), %rax
1800081bc:     	movq	%rax, 0x50(%rsp)
1800081c1:     	movq	0x258(%rsp), %rax
1800081c9:     	movq	%rax, 0x48(%rsp)
1800081ce:     	movq	0x250(%rsp), %rax
1800081d6:     	movq	%rax, 0x40(%rsp)
1800081db:     	movq	0x248(%rsp), %rax
1800081e3:     	movq	%rax, 0x38(%rsp)
1800081e8:     	movq	%rbp, 0x30(%rsp)
1800081ed:     	movq	0x238(%rsp), %rax
1800081f5:     	movq	%rax, 0x28(%rsp)
1800081fa:     	movq	0x230(%rsp), %rax
180008202:     	movq	%rax, 0x20(%rsp)
180008207:     	movq	$-0x1, 0x100(%rsp)
180008213:     	movq	$-0x1, 0xf8(%rsp)
18000821f:     	movq	$0x1, 0xf0(%rsp)
18000822b:     	leaq	0x12f(%rsp), %rcx
180008233:     	leaq	0x1a8(%rsp), %rdx
18000823b:     	movq	%r8, 0x130(%rsp)
180008243:     	movq	%r9, 0x138(%rsp)
18000824b:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180008250:     	testl	%eax, %eax
180008252:     	jne	0x180008919 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d59>
180008258:     	cmpb	$0x0, (%r15)
18000825c:     	movq	0x110(%rsp), %rcx
180008264:     	movq	0x120(%rsp), %rdx
18000826c:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
18000826e:     	decq	0x8(%r12)
180008273:     	movq	0x138(%rsp), %r9
18000827b:     	movq	0x130(%rsp), %r8
180008283:     	movq	0x20(%r13,%rsi,8), %rax
180008288:     	testq	%rax, %rax
18000828b:     	jns	0x180007e86 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x42c6>
180008291:     	movb	$0x1, (%r15)
180008295:     	movq	$0x2dc6cd, 0x18(%r12)   # imm = 0x2DC6CD
18000829e:     	movb	$0x0, (%rcx)
1800082a1:     	xorl	%eax, %eax
1800082a3:     	addq	$0x1c8, %rsp            # imm = 0x1C8
1800082aa:     	popq	%rbx
1800082ab:     	popq	%rbp
1800082ac:     	popq	%rdi
1800082ad:     	popq	%rsi
1800082ae:     	popq	%r12
1800082b0:     	popq	%r13
1800082b2:     	popq	%r14
1800082b4:     	popq	%r15
1800082b6:     	retq
1800082b7:     	movb	$0x1, (%r15)
1800082bb:     	movq	$0x2dc6cb, 0x18(%r12)   # imm = 0x2DC6CB
1800082c4:     	jmp	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
1800082c6:     	movzbl	0x11f(%rsp), %ecx
1800082ce:     	movq	0x8(%r12), %rdx
1800082d3:     	leaq	-0x1(%rdx), %r8
1800082d7:     	movq	%r8, 0x8(%r12)
1800082dc:     	testb	$0x1, %cl
1800082df:     	je	0x1800082e6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4726>
1800082e1:     	movb	$0x1, (%rax)
1800082e4:     	jmp	0x1800082a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46e1>
1800082e6:     	movq	0x28(%r13,%rsi,8), %rcx
1800082eb:     	testq	%rcx, %rcx
1800082ee:     	js	0x1800082fc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x473c>
1800082f0:     	movq	%rdx, 0x8(%r12)
1800082f5:     	cmpq	0x10(%r12), %rdx
1800082fa:     	jle	0x18000830e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x474e>
1800082fc:     	movb	$0x1, (%r15)
180008300:     	movq	$0x2dc6ce, 0x18(%r12)   # imm = 0x2DC6CE
180008309:     	jmp	0x18000807a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x44ba>
18000830e:     	movb	$0x0, 0x11e(%rsp)
180008316:     	movq	0x310(%rsp), %rax
18000831e:     	movq	%rax, 0x100(%rsp)
180008326:     	movq	%rcx, 0xf8(%rsp)
18000832e:     	movq	0x2f8(%rsp), %rax
180008336:     	movq	%rax, 0xe8(%rsp)
18000833e:     	movq	0x2f0(%rsp), %rax
180008346:     	movq	%rax, 0xe0(%rsp)
18000834e:     	movq	%r15, 0xd8(%rsp)
180008356:     	movq	0x2e0(%rsp), %rax
18000835e:     	movq	%rax, 0xd0(%rsp)
180008366:     	movq	0x2d8(%rsp), %rax
18000836e:     	movq	%rax, 0xc8(%rsp)
180008376:     	movq	0x2d0(%rsp), %rax
18000837e:     	movq	%rax, 0xc0(%rsp)
180008386:     	movq	0x2c8(%rsp), %rax
18000838e:     	movq	%rax, 0xb8(%rsp)
180008396:     	movq	0x2c0(%rsp), %rax
18000839e:     	movq	%rax, 0xb0(%rsp)
1800083a6:     	movq	0x2b8(%rsp), %rax
1800083ae:     	movq	%rax, 0xa8(%rsp)
1800083b6:     	movq	%r12, 0xa0(%rsp)
1800083be:     	movq	0x2a8(%rsp), %rax
1800083c6:     	movq	%rax, 0x98(%rsp)
1800083ce:     	movq	0x2a0(%rsp), %rax
1800083d6:     	movq	%rax, 0x90(%rsp)
1800083de:     	movq	0x298(%rsp), %rax
1800083e6:     	movq	%rax, 0x88(%rsp)
1800083ee:     	movq	0x290(%rsp), %rax
1800083f6:     	movq	%rax, 0x80(%rsp)
1800083fe:     	movq	0x288(%rsp), %rax
180008406:     	movq	%rax, 0x78(%rsp)
18000840b:     	movq	%rbx, 0x70(%rsp)
180008410:     	movq	%r13, 0x68(%rsp)
180008415:     	movq	0x270(%rsp), %rax
18000841d:     	movq	%rax, 0x60(%rsp)
180008422:     	movq	0x268(%rsp), %rax
18000842a:     	movq	%rax, 0x58(%rsp)
18000842f:     	movq	0x260(%rsp), %rax
180008437:     	movq	%rax, 0x50(%rsp)
18000843c:     	movq	%rdi, 0x48(%rsp)
180008441:     	movq	0x250(%rsp), %rax
180008449:     	movq	%rax, 0x40(%rsp)
18000844e:     	movq	%r14, 0x38(%rsp)
180008453:     	movq	%rbp, 0x30(%rsp)
180008458:     	movq	0x238(%rsp), %rax
180008460:     	movq	%rax, 0x28(%rsp)
180008465:     	movq	0x230(%rsp), %rax
18000846d:     	movq	%rax, 0x20(%rsp)
180008472:     	movq	$-0x1, 0x108(%rsp)
18000847e:     	movq	$0x0, 0xf0(%rsp)
18000848a:     	leaq	0x11e(%rsp), %rcx
180008492:     	leaq	0x198(%rsp), %rdx
18000849a:     	movq	0x130(%rsp), %r8
1800084a2:     	movq	0x138(%rsp), %r9
1800084aa:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
1800084af:     	testl	%eax, %eax
1800084b1:     	jne	0x180008bca <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x500a>
1800084b7:     	cmpb	$0x0, (%r15)
1800084bb:     	je	0x1800088a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4ce1>
1800084c1:     	movq	0x110(%rsp), %rax
1800084c9:     	jmp	0x18000807a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x44ba>
1800084ce:     	movq	%r10, 0x1b0(%rsp)
1800084d6:     	movq	%r11, 0x1b8(%rsp)
1800084de:     	movabsq	$0x7ffffffffffffff8, %r9 # imm = 0x7FFFFFFFFFFFFFF8
1800084e8:     	andq	%rax, %r9
1800084eb:     	movq	0x148(%rsp), %r11
1800084f3:     	leaq	(,%rbx,8), %r8
1800084fb:     	xorl	%edx, %edx
1800084fd:     	movq	%r9, 0x138(%rsp)
180008505:     	leaq	(%r14,%rdx), %rax
180008509:     	sarq	$0x3f, %rax
18000850d:     	andq	%r8, %rax
180008510:     	leaq	(%r13,%r14,8), %rdi
180008515:     	addq	%rdi, %rax
180008518:     	movq	(%rax,%rdx,8), %rax
18000851c:     	leaq	(%r11,%rdx), %r9
180008520:     	sarq	$0x3f, %r9
180008524:     	andq	%r8, %r9
180008527:     	leaq	(%r13,%r11,8), %r10
18000852c:     	movq	%r10, 0x120(%rsp)
180008534:     	addq	%r10, %r9
180008537:     	movq	%rax, (%r9,%rdx,8)
18000853b:     	leaq	0x1(%r14,%rdx), %rax
180008540:     	sarq	$0x3f, %rax
180008544:     	andq	%r8, %rax
180008547:     	movq	%rdi, %r10
18000854a:     	addq	%rdi, %rax
18000854d:     	movq	0x8(%rax,%rdx,8), %rax
180008552:     	leaq	0x1(%r11,%rdx), %r9
180008557:     	sarq	$0x3f, %r9
18000855b:     	andq	%r8, %r9
18000855e:     	movq	0x120(%rsp), %rdi
180008566:     	addq	%rdi, %r9
180008569:     	movq	%rax, 0x8(%r9,%rdx,8)
18000856e:     	leaq	0x2(%r14,%rdx), %rax
180008573:     	sarq	$0x3f, %rax
180008577:     	andq	%r8, %rax
18000857a:     	addq	%r10, %rax
18000857d:     	movq	%r10, 0x130(%rsp)
180008585:     	movq	0x10(%rax,%rdx,8), %rax
18000858a:     	leaq	0x2(%r11,%rdx), %r9
18000858f:     	sarq	$0x3f, %r9
180008593:     	andq	%r8, %r9
180008596:     	addq	%rdi, %r9
180008599:     	movq	%rax, 0x10(%r9,%rdx,8)
18000859e:     	leaq	0x3(%r14,%rdx), %rax
1800085a3:     	sarq	$0x3f, %rax
1800085a7:     	andq	%r8, %rax
1800085aa:     	addq	%r10, %rax
1800085ad:     	movq	0x18(%rax,%rdx,8), %rax
1800085b2:     	leaq	0x3(%r11,%rdx), %r9
1800085b7:     	sarq	$0x3f, %r9
1800085bb:     	andq	%r8, %r9
1800085be:     	addq	%rdi, %r9
1800085c1:     	movq	%rdi, %r10
1800085c4:     	movq	%rax, 0x18(%r9,%rdx,8)
1800085c9:     	leaq	0x4(%r14,%rdx), %rax
1800085ce:     	sarq	$0x3f, %rax
1800085d2:     	andq	%r8, %rax
1800085d5:     	movq	0x130(%rsp), %rdi
1800085dd:     	addq	%rdi, %rax
1800085e0:     	movq	0x20(%rax,%rdx,8), %rax
1800085e5:     	leaq	0x4(%r11,%rdx), %r9
1800085ea:     	sarq	$0x3f, %r9
1800085ee:     	andq	%r8, %r9
1800085f1:     	addq	%r10, %r9
1800085f4:     	movq	%rax, 0x20(%r9,%rdx,8)
1800085f9:     	leaq	0x5(%r14,%rdx), %rax
1800085fe:     	sarq	$0x3f, %rax
180008602:     	andq	%r8, %rax
180008605:     	addq	%rdi, %rax
180008608:     	movq	0x28(%rax,%rdx,8), %rax
18000860d:     	leaq	0x5(%r11,%rdx), %r9
180008612:     	sarq	$0x3f, %r9
180008616:     	andq	%r8, %r9
180008619:     	addq	0x120(%rsp), %r9
180008621:     	movq	%rax, 0x28(%r9,%rdx,8)
180008626:     	leaq	0x6(%r14,%rdx), %rax
18000862b:     	sarq	$0x3f, %rax
18000862f:     	andq	%r8, %rax
180008632:     	addq	%rdi, %rax
180008635:     	movq	0x30(%rax,%rdx,8), %rax
18000863a:     	leaq	0x6(%r11,%rdx), %r9
18000863f:     	sarq	$0x3f, %r9
180008643:     	andq	%r8, %r9
180008646:     	addq	0x120(%rsp), %r9
18000864e:     	movq	%rax, 0x30(%r9,%rdx,8)
180008653:     	leaq	0x7(%r14,%rdx), %rax
180008658:     	sarq	$0x3f, %rax
18000865c:     	andq	%r8, %rax
18000865f:     	addq	%rdi, %rax
180008662:     	movq	0x38(%rax,%rdx,8), %rax
180008667:     	leaq	0x7(%r11,%rdx), %r9
18000866c:     	sarq	$0x3f, %r9
180008670:     	andq	%r8, %r9
180008673:     	addq	0x120(%rsp), %r9
18000867b:     	movq	%rax, 0x38(%r9,%rdx,8)
180008680:     	movq	0x138(%rsp), %r9
180008688:     	addq	$0x8, %rdx
18000868c:     	cmpq	%rdx, %r9
18000868f:     	jne	0x180008505 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4945>
180008695:     	movq	0x1b0(%rsp), %r10
18000869d:     	testq	%r10, %r10
1800086a0:     	movq	0x1b8(%rsp), %r11
1800086a8:     	je	0x1800086e6 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4b26>
1800086aa:     	movq	0x148(%rsp), %rax
1800086b2:     	leaq	(%r9,%rax), %rdx
1800086b6:     	addq	%r9, %r14
1800086b9:     	movq	%r14, %rax
1800086bc:     	sarq	$0x3f, %rax
1800086c0:     	andq	%r8, %rax
1800086c3:     	addq	%r13, %rax
1800086c6:     	movq	(%rax,%r14,8), %rax
1800086ca:     	movq	%rdx, %r9
1800086cd:     	sarq	$0x3f, %r9
1800086d1:     	andq	%r8, %r9
1800086d4:     	addq	%r13, %r9
1800086d7:     	movq	%rax, (%r9,%rdx,8)
1800086db:     	incq	%rdx
1800086de:     	incq	%r14
1800086e1:     	decq	%r10
1800086e4:     	jne	0x1800086b9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4af9>
1800086e6:     	movq	0x160(%rsp), %rax
1800086ee:     	movq	0x158(%rsp), %rdx
1800086f6:     	movq	0x150(%rsp), %r14
1800086fe:     	movq	%rdx, 0x8(%r14,%rax,8)
180008703:     	movq	0x148(%rsp), %rax
18000870b:     	movq	%rax, 0x10(%r14,%r11,8)
180008710:     	movq	0x110(%rsp), %rdx
180008718:     	movq	0x1c0(%rsp), %r10
180008720:     	leaq	0x1(%rdx), %rax
180008724:     	movq	0x140(%rsp), %r8
18000872c:     	movq	%rax, (%r14,%r8,8)
180008730:     	cmpb	$0x0, (%r15)
180008734:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
18000873a:     	xorl	%eax, %eax
18000873c:     	cmpq	$-0x2, %r10
180008740:     	cmovlq	%rbx, %rax
180008744:     	addq	0x10(%r14,%rax,8), %rdx
180008749:     	movq	%rdx, %rax
18000874c:     	sarq	$0x3f, %rax
180008750:     	andq	%rbx, %rax
180008753:     	leaq	(%r13,%rdx,8), %rdx
180008758:     	movq	0x310(%rsp), %r8
180008760:     	movq	%r8, (%rdx,%rax,8)
180008764:     	movsd	0x48(%rbp,%rsi,8), %xmm1
18000876a:     	movsd	0x8(%rbp,%r8,8), %xmm2
180008771:     	movapd	%xmm1, %xmm0
180008775:     	addsd	%xmm2, %xmm0
180008779:     	xorpd	%xmm3, %xmm3
18000877d:     	ucomisd	%xmm3, %xmm0
180008781:     	jbe	0x180008881 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cc1>
180008787:     	movq	0x10(%r13,%rsi,8), %rax
18000878c:     	testq	%rax, %rax
18000878f:     	js	0x180008892 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cd2>
180008795:     	cmpq	$0x0, 0x8(%r13,%rax,8)
18000879b:     	mulsd	(%rbp,%rax,8), %xmm1
1800087a1:     	je	0x1800087cd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4c0d>
1800087a3:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
1800087a9:     	je	0x1800087cd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4c0d>
1800087ab:     	movapd	0x4c0d(%rip), %xmm3     # 0x18000d3c0
1800087b3:     	andpd	%xmm1, %xmm3
1800087b7:     	ucomisd	0x4c11(%rip), %xmm3     # 0x18000d3d0
1800087bf:     	jae	0x180008892 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cd2>
1800087c5:     	xorpd	%xmm3, %xmm3
1800087c9:     	addsd	%xmm3, %xmm1
1800087cd:     	movq	0x10(%r13,%r8,8), %rdx
1800087d2:     	testq	%rdx, %rdx
1800087d5:     	js	0x180008892 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cd2>
1800087db:     	mulsd	(%rbp,%rdx,8), %xmm2
1800087e1:     	addsd	%xmm2, %xmm1
1800087e5:     	divsd	%xmm0, %xmm1
1800087e9:     	movsd	%xmm1, (%rbp,%rax,8)
1800087ef:     	movq	$0x0, 0x8(%r13,%rax,8)
1800087f8:     	movq	0x10(%r13,%rsi,8), %rax
1800087fd:     	testq	%rax, %rax
180008800:     	js	0x1800088c8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d08>
180008806:     	movsd	0x10(%rbp,%rax,8), %xmm1
18000880c:     	cmpq	$0x0, 0x18(%r13,%rax,8)
180008812:     	mulsd	0x48(%rbp,%rsi,8), %xmm1
180008818:     	je	0x180008844 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4c84>
18000881a:     	cmpq	$0x0, 0x50(%r13,%rsi,8)
180008820:     	je	0x180008844 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4c84>
180008822:     	movapd	0x4b96(%rip), %xmm2     # 0x18000d3c0
18000882a:     	andpd	%xmm1, %xmm2
18000882e:     	ucomisd	0x4b9a(%rip), %xmm2     # 0x18000d3d0
180008836:     	jae	0x1800088c8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d08>
18000883c:     	xorpd	%xmm2, %xmm2
180008840:     	addsd	%xmm2, %xmm1
180008844:     	movq	0x310(%rsp), %rdx
18000884c:     	movq	0x10(%r13,%rdx,8), %rdx
180008851:     	testq	%rdx, %rdx
180008854:     	js	0x1800088c8 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d08>
180008856:     	movsd	0x10(%rbp,%rdx,8), %xmm2
18000885c:     	movq	0x310(%rsp), %rdx
180008864:     	mulsd	0x8(%rbp,%rdx,8), %xmm2
18000886a:     	addsd	%xmm2, %xmm1
18000886e:     	divsd	%xmm0, %xmm1
180008872:     	movsd	%xmm1, 0x10(%rbp,%rax,8)
180008878:     	movq	$0x0, 0x18(%r13,%rax,8)
180008881:     	movsd	%xmm0, 0x48(%rbp,%rsi,8)
180008887:     	movq	$0x0, 0x50(%r13,%rsi,8)
180008890:     	jmp	0x1800088d5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d15>
180008892:     	movb	$0x1, (%r15)
180008896:     	movq	$0x895447, 0x18(%r12)   # imm = 0x895447
18000889f:     	jmp	0x1800088d5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d15>
1800088a1:     	movzbl	0x11e(%rsp), %eax
1800088a9:     	movq	0x8(%r12), %rcx
1800088ae:     	leaq	-0x1(%rcx), %rdx
1800088b2:     	movq	%rdx, 0x8(%r12)
1800088b7:     	testb	$0x1, %al
1800088b9:     	je	0x1800088e7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d27>
1800088bb:     	movq	0x110(%rsp), %rax
1800088c3:     	jmp	0x1800082e1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4721>
1800088c8:     	movb	$0x1, (%r15)
1800088cc:     	movq	$0x895449, 0x18(%r12)   # imm = 0x895449
1800088d5:     	cmpb	$0x0, (%r15)
1800088d9:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
1800088df:     	movb	$0x1, (%rcx)
1800088e2:     	jmp	0x1800082a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46e1>
1800088e7:     	movq	0x38(%r13,%rsi,8), %rax
1800088ec:     	testq	%rax, %rax
1800088ef:     	js	0x1800088fd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d3d>
1800088f1:     	movq	%rcx, 0x8(%r12)
1800088f6:     	cmpq	0x10(%r12), %rcx
1800088fb:     	jle	0x180008931 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d71>
1800088fd:     	movb	$0x1, (%r15)
180008901:     	movq	$0x2dc6cf, 0x18(%r12)   # imm = 0x2DC6CF
18000890a:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
18000890f:     	movq	0x1a0(%rsp), %rdx
180008917:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180008919:     	movq	0x1a8(%rsp), %rdx
180008921:     	movq	0x120(%rsp), %rcx
180008929:     	movq	%rdx, (%rcx)
18000892c:     	jmp	0x1800082a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46e3>
180008931:     	movb	$0x0, 0x11d(%rsp)
180008939:     	movq	0x310(%rsp), %rcx
180008941:     	movq	%rcx, 0x100(%rsp)
180008949:     	movq	%rax, 0xf8(%rsp)
180008951:     	movq	0x2f8(%rsp), %rax
180008959:     	movq	%rax, 0xe8(%rsp)
180008961:     	movq	0x2f0(%rsp), %rax
180008969:     	movq	%rax, 0xe0(%rsp)
180008971:     	movq	%r15, 0xd8(%rsp)
180008979:     	movq	0x2e0(%rsp), %rax
180008981:     	movq	%rax, 0xd0(%rsp)
180008989:     	movq	0x2d8(%rsp), %rax
180008991:     	movq	%rax, 0xc8(%rsp)
180008999:     	movq	0x2d0(%rsp), %rax
1800089a1:     	movq	%rax, 0xc0(%rsp)
1800089a9:     	movq	0x2c8(%rsp), %rax
1800089b1:     	movq	%rax, 0xb8(%rsp)
1800089b9:     	movq	0x2c0(%rsp), %rax
1800089c1:     	movq	%rax, 0xb0(%rsp)
1800089c9:     	movq	0x2b8(%rsp), %rax
1800089d1:     	movq	%rax, 0xa8(%rsp)
1800089d9:     	movq	%r12, 0xa0(%rsp)
1800089e1:     	movq	0x2a8(%rsp), %rax
1800089e9:     	movq	%rax, 0x98(%rsp)
1800089f1:     	movq	0x2a0(%rsp), %rax
1800089f9:     	movq	%rax, 0x90(%rsp)
180008a01:     	movq	0x298(%rsp), %rax
180008a09:     	movq	%rax, 0x88(%rsp)
180008a11:     	movq	0x290(%rsp), %rax
180008a19:     	movq	%rax, 0x80(%rsp)
180008a21:     	movq	0x288(%rsp), %rax
180008a29:     	movq	%rax, 0x78(%rsp)
180008a2e:     	movq	%rbx, 0x70(%rsp)
180008a33:     	movq	%r13, 0x68(%rsp)
180008a38:     	movq	0x270(%rsp), %rax
180008a40:     	movq	%rax, 0x60(%rsp)
180008a45:     	movq	0x268(%rsp), %rax
180008a4d:     	movq	%rax, 0x58(%rsp)
180008a52:     	movq	0x260(%rsp), %rax
180008a5a:     	movq	%rax, 0x50(%rsp)
180008a5f:     	movq	0x258(%rsp), %rax
180008a67:     	movq	%rax, 0x48(%rsp)
180008a6c:     	movq	0x250(%rsp), %rax
180008a74:     	movq	%rax, 0x40(%rsp)
180008a79:     	movq	0x248(%rsp), %rax
180008a81:     	movq	%rax, 0x38(%rsp)
180008a86:     	movq	%rbp, 0x30(%rsp)
180008a8b:     	movq	0x238(%rsp), %rax
180008a93:     	movq	%rax, 0x28(%rsp)
180008a98:     	movq	0x230(%rsp), %rax
180008aa0:     	movq	%rax, 0x20(%rsp)
180008aa5:     	movq	$-0x1, 0x108(%rsp)
180008ab1:     	movq	$0x0, 0xf0(%rsp)
180008abd:     	leaq	0x11d(%rsp), %rcx
180008ac5:     	leaq	0x190(%rsp), %rdx
180008acd:     	movq	0x130(%rsp), %r8
180008ad5:     	movq	0x138(%rsp), %r9
180008add:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180008ae2:     	testl	%eax, %eax
180008ae4:     	jne	0x180008f07 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5347>
180008aea:     	cmpb	$0x0, (%r15)
180008aee:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008af4:     	movzbl	0x11d(%rsp), %eax
180008afc:     	movq	0x8(%r12), %rcx
180008b01:     	leaq	-0x1(%rcx), %rdx
180008b05:     	movq	%rdx, 0x8(%r12)
180008b0a:     	testb	$0x1, %al
180008b0c:     	jne	0x1800088bb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cfb>
180008b12:     	movq	0x40(%r13,%rsi,8), %rax
180008b17:     	testq	%rax, %rax
180008b1a:     	js	0x180008b2c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4f6c>
180008b1c:     	movq	%rcx, 0x8(%r12)
180008b21:     	cmpq	0x10(%r12), %rcx
180008b26:     	jle	0x180008c0f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x504f>
180008b2c:     	movb	$0x1, (%r15)
180008b30:     	movq	$0x2dc6d0, 0x18(%r12)   # imm = 0x2DC6D0
180008b39:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008b3e:     	movb	$0x1, (%r15)
180008b42:     	movl	$0x6acfc2, %edx         # imm = 0x6ACFC2
180008b47:     	movq	%r12, %rcx
180008b4a:     	movq	%rdx, 0x18(%rcx)
180008b4e:     	cmpb	$0x0, (%r15)
180008b52:     	movq	0x110(%rsp), %rcx
180008b5a:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180008b60:     	movq	%r11, 0x10(%r10)
180008b64:     	movq	0x140(%rsp), %rax
180008b6c:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008b75:     	movq	$0x1, 0x50(%r10)
180008b7d:     	movq	$-0x1, 0x20(%r10)
180008b85:     	movq	$-0x1, 0x28(%r10)
180008b8d:     	movq	$-0x1, 0x38(%r10)
180008b95:     	movq	$-0x1, 0x40(%r10)
180008b9d:     	cmpb	$0x0, (%r15)
180008ba1:     	jne	0x18000829e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46de>
180008ba7:     	movq	0x140(%rsp), %rax
180008baf:     	movq	%rax, 0x20(%r13,%rsi,8)
180008bb4:     	movq	(%r12), %rcx
180008bb8:     	leaq	0x4(%rcx), %rax
180008bbc:     	cmpq	%rbx, %rax
180008bbf:     	jle	0x180008bd7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5017>
180008bc1:     	movb	$0x2, (%r15)
180008bc5:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008bca:     	movq	0x198(%rsp), %rdx
180008bd2:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180008bd7:     	movq	%rax, (%r12)
180008bdb:     	cmpb	$0x0, (%r15)
180008bdf:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008be5:     	subsd	%xmm3, %xmm1
180008be9:     	testq	%rcx, %rcx
180008bec:     	js	0x180008dec <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x522c>
180008bf2:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
180008bf8:     	movsd	%xmm5, 0x18(%rbp,%rcx,8)
180008bfe:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008c04:     	movsd	%xmm0, (%rbp,%rcx,8)
180008c0a:     	jmp	0x180008df9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5239>
180008c0f:     	movb	$0x0, 0x11c(%rsp)
180008c17:     	movq	0x310(%rsp), %rcx
180008c1f:     	movq	%rcx, 0x100(%rsp)
180008c27:     	movq	%rax, 0xf8(%rsp)
180008c2f:     	movq	0x2f8(%rsp), %rax
180008c37:     	movq	%rax, 0xe8(%rsp)
180008c3f:     	movq	0x2f0(%rsp), %rax
180008c47:     	movq	%rax, 0xe0(%rsp)
180008c4f:     	movq	0x2e0(%rsp), %rax
180008c57:     	movq	%rax, 0xd0(%rsp)
180008c5f:     	movq	0x2d8(%rsp), %rax
180008c67:     	movq	%rax, 0xc8(%rsp)
180008c6f:     	movq	0x2d0(%rsp), %rax
180008c77:     	movq	%rax, 0xc0(%rsp)
180008c7f:     	movq	0x2c8(%rsp), %rax
180008c87:     	movq	%rax, 0xb8(%rsp)
180008c8f:     	movq	0x2c0(%rsp), %rax
180008c97:     	movq	%rax, 0xb0(%rsp)
180008c9f:     	movq	0x2b8(%rsp), %rax
180008ca7:     	movq	%rax, 0xa8(%rsp)
180008caf:     	movq	0x2a8(%rsp), %rax
180008cb7:     	movq	%rax, 0x98(%rsp)
180008cbf:     	movq	0x2a0(%rsp), %rax
180008cc7:     	movq	%rax, 0x90(%rsp)
180008ccf:     	movq	0x298(%rsp), %rax
180008cd7:     	movq	%rax, 0x88(%rsp)
180008cdf:     	movq	0x290(%rsp), %rax
180008ce7:     	movq	%rax, 0x80(%rsp)
180008cef:     	movq	0x288(%rsp), %rax
180008cf7:     	movq	%rax, 0x78(%rsp)
180008cfc:     	movq	%rbx, 0x70(%rsp)
180008d01:     	movq	%r13, 0x68(%rsp)
180008d06:     	movq	0x270(%rsp), %rax
180008d0e:     	movq	%rax, 0x60(%rsp)
180008d13:     	movq	0x268(%rsp), %rax
180008d1b:     	movq	%rax, 0x58(%rsp)
180008d20:     	movq	0x260(%rsp), %rax
180008d28:     	movq	%rax, 0x50(%rsp)
180008d2d:     	movq	0x258(%rsp), %rax
180008d35:     	movq	%rax, 0x48(%rsp)
180008d3a:     	movq	0x250(%rsp), %rax
180008d42:     	movq	%rax, 0x40(%rsp)
180008d47:     	movq	0x248(%rsp), %rax
180008d4f:     	movq	%rax, 0x38(%rsp)
180008d54:     	movq	%rbp, 0x30(%rsp)
180008d59:     	movq	%r15, 0xd8(%rsp)
180008d61:     	movq	%r12, 0xa0(%rsp)
180008d69:     	movq	0x238(%rsp), %rax
180008d71:     	movq	%rax, 0x28(%rsp)
180008d76:     	movq	0x230(%rsp), %rax
180008d7e:     	movq	%rax, 0x20(%rsp)
180008d83:     	movq	$-0x1, 0x108(%rsp)
180008d8f:     	movq	$0x0, 0xf0(%rsp)
180008d9b:     	leaq	0x11c(%rsp), %rcx
180008da3:     	leaq	0x188(%rsp), %rdx
180008dab:     	movq	0x130(%rsp), %r8
180008db3:     	movq	0x138(%rsp), %r9
180008dbb:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180008dc0:     	testl	%eax, %eax
180008dc2:     	jne	0x180008f14 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5354>
180008dc8:     	cmpb	$0x0, (%r15)
180008dcc:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008dd2:     	movzbl	0x11c(%rsp), %eax
180008dda:     	decq	0x8(%r12)
180008ddf:     	testb	$0x1, %al
180008de1:     	je	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008de7:     	jmp	0x1800088bb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4cfb>
180008dec:     	movb	$0x1, (%r15)
180008df0:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008df9:     	cmpb	$0x0, (%r15)
180008dfd:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008e03:     	movq	(%r12), %rax
180008e07:     	leaq	0xb(%rax), %r8
180008e0b:     	cmpq	%rbx, %r8
180008e0e:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180008e14:     	movq	0x8(%r13,%rsi,8), %rdx
180008e19:     	movq	%r8, (%r12)
180008e1d:     	cmpb	$0x0, (%r15)
180008e21:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008e27:     	movq	%rcx, (%r13,%rax,8)
180008e2c:     	movq	%rdx, 0x8(%r13,%rax,8)
180008e31:     	movq	(%r12), %rdx
180008e35:     	cmpq	%rbx, %rdx
180008e38:     	movq	%rdx, %rcx
180008e3b:     	jle	0x180008e47 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5287>
180008e3d:     	movb	$0x2, (%r15)
180008e41:     	movq	(%r12), %rdx
180008e45:     	xorl	%ecx, %ecx
180008e47:     	leaq	0x3(%rdx), %r8
180008e4b:     	cmpq	%rbx, %r8
180008e4e:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180008e54:     	movq	%r8, (%r12)
180008e58:     	cmpb	$0x0, (%r15)
180008e5c:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008e62:     	movq	%rdx, %r8
180008e65:     	sarq	$0x3f, %r8
180008e69:     	andq	%rbx, %r8
180008e6c:     	leaq	(%r13,%rdx,8), %r9
180008e71:     	movq	$0x0, (%r9,%r8,8)
180008e79:     	xorl	%r8d, %r8d
180008e7c:     	cmpq	$-0x1, %rdx
180008e80:     	movl	$0x0, %r10d
180008e86:     	cmovlq	%rbx, %r10
180008e8a:     	movq	$0x0, 0x8(%r9,%r10,8)
180008e93:     	cmpq	$-0x2, %rdx
180008e97:     	cmovlq	%rbx, %r8
180008e9b:     	movq	%rcx, 0x10(%r9,%r8,8)
180008ea0:     	cmpb	$0x0, (%r15)
180008ea4:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008eaa:     	leaq	(%r13,%rax,8), %rcx
180008eaf:     	movq	%rdx, 0x30(%rcx)
180008eb3:     	movq	$0x0, 0x18(%rcx)
180008ebb:     	movq	(%r12), %rdx
180008ebf:     	leaq	0x4(%rdx), %r8
180008ec3:     	cmpq	%rbx, %r8
180008ec6:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180008ecc:     	movq	%r8, (%r12)
180008ed0:     	cmpb	$0x0, (%r15)
180008ed4:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008eda:     	testq	%rdx, %rdx
180008edd:     	js	0x180008f21 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5361>
180008edf:     	movq	$0x0, (%rbp,%rdx,8)
180008ee8:     	leaq	(%r13,%rdx,8), %r8
180008eed:     	movq	$0x1, 0x8(%r13,%rdx,8)
180008ef6:     	movq	$0x0, 0x10(%rbp,%rdx,8)
180008eff:     	movl	$0x1, %r9d
180008f05:     	jmp	0x180008f2e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x536e>
180008f07:     	movq	0x190(%rsp), %rdx
180008f0f:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180008f14:     	movq	0x188(%rsp), %rdx
180008f1c:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180008f21:     	movb	$0x1, (%r15)
180008f25:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
180008f2b:     	movq	%r12, %r8
180008f2e:     	movq	%r9, 0x18(%r8)
180008f32:     	cmpb	$0x0, (%r15)
180008f36:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008f3c:     	movq	%rdx, 0x10(%rcx)
180008f40:     	movq	$0x0, 0x48(%rbp,%rax,8)
180008f49:     	movq	$0x1, 0x50(%rcx)
180008f51:     	movq	$-0x1, 0x20(%rcx)
180008f59:     	movq	$-0x1, 0x28(%rcx)
180008f61:     	movq	$-0x1, 0x38(%rcx)
180008f69:     	movq	$-0x1, 0x40(%rcx)
180008f71:     	cmpb	$0x0, (%r15)
180008f75:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008f7b:     	movq	%rax, 0x28(%r13,%rsi,8)
180008f80:     	movq	(%r12), %rcx
180008f84:     	leaq	0x4(%rcx), %rax
180008f88:     	cmpq	%rbx, %rax
180008f8b:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180008f91:     	movq	%rax, (%r12)
180008f95:     	cmpb	$0x0, (%r15)
180008f99:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008f9f:     	addsd	%xmm0, %xmm2
180008fa3:     	testq	%rcx, %rcx
180008fa6:     	js	0x180008fc2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5402>
180008fa8:     	movsd	%xmm4, 0x10(%rbp,%rcx,8)
180008fae:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
180008fb4:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180008fba:     	movsd	%xmm0, (%rbp,%rcx,8)
180008fc0:     	jmp	0x180008fcf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x540f>
180008fc2:     	movb	$0x1, (%r15)
180008fc6:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180008fcf:     	cmpb	$0x0, (%r15)
180008fd3:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008fd9:     	movq	(%r12), %rax
180008fdd:     	leaq	0xb(%rax), %r8
180008fe1:     	cmpq	%rbx, %r8
180008fe4:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180008fea:     	movq	0x8(%r13,%rsi,8), %rdx
180008fef:     	movq	%r8, (%r12)
180008ff3:     	cmpb	$0x0, (%r15)
180008ff7:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180008ffd:     	movq	%rcx, (%r13,%rax,8)
180009002:     	movq	%rdx, 0x8(%r13,%rax,8)
180009007:     	movq	(%r12), %rdx
18000900b:     	cmpq	%rbx, %rdx
18000900e:     	movq	%rdx, %rcx
180009011:     	jle	0x18000901d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x545d>
180009013:     	movb	$0x2, (%r15)
180009017:     	movq	(%r12), %rdx
18000901b:     	xorl	%ecx, %ecx
18000901d:     	leaq	0x3(%rdx), %r8
180009021:     	cmpq	%rbx, %r8
180009024:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
18000902a:     	movq	%r8, (%r12)
18000902e:     	cmpb	$0x0, (%r15)
180009032:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009038:     	movq	%rdx, %r8
18000903b:     	sarq	$0x3f, %r8
18000903f:     	andq	%rbx, %r8
180009042:     	leaq	(%r13,%rdx,8), %r9
180009047:     	movq	$0x0, (%r9,%r8,8)
18000904f:     	xorl	%r8d, %r8d
180009052:     	cmpq	$-0x1, %rdx
180009056:     	movl	$0x0, %r10d
18000905c:     	cmovlq	%rbx, %r10
180009060:     	movq	$0x0, 0x8(%r9,%r10,8)
180009069:     	cmpq	$-0x2, %rdx
18000906d:     	cmovlq	%rbx, %r8
180009071:     	movq	%rcx, 0x10(%r9,%r8,8)
180009076:     	cmpb	$0x0, (%r15)
18000907a:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009080:     	leaq	(%r13,%rax,8), %rcx
180009085:     	movq	%rdx, 0x30(%rcx)
180009089:     	movq	$0x0, 0x18(%rcx)
180009091:     	movq	(%r12), %rdx
180009095:     	leaq	0x4(%rdx), %r8
180009099:     	cmpq	%rbx, %r8
18000909c:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
1800090a2:     	movq	%r8, (%r12)
1800090a6:     	cmpb	$0x0, (%r15)
1800090aa:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800090b0:     	testq	%rdx, %rdx
1800090b3:     	js	0x1800090dd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x551d>
1800090b5:     	movq	$0x0, (%rbp,%rdx,8)
1800090be:     	leaq	(%r13,%rdx,8), %r8
1800090c3:     	movq	$0x1, 0x8(%r13,%rdx,8)
1800090cc:     	movq	$0x0, 0x10(%rbp,%rdx,8)
1800090d5:     	movl	$0x1, %r9d
1800090db:     	jmp	0x1800090ea <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x552a>
1800090dd:     	movb	$0x1, (%r15)
1800090e1:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
1800090e7:     	movq	%r12, %r8
1800090ea:     	movq	%r9, 0x18(%r8)
1800090ee:     	cmpb	$0x0, (%r15)
1800090f2:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800090f8:     	movq	%rdx, 0x10(%rcx)
1800090fc:     	movq	$0x0, 0x48(%rbp,%rax,8)
180009105:     	movq	$0x1, 0x50(%rcx)
18000910d:     	movq	$-0x1, 0x20(%rcx)
180009115:     	movq	$-0x1, 0x28(%rcx)
18000911d:     	movq	$-0x1, 0x38(%rcx)
180009125:     	movq	$-0x1, 0x40(%rcx)
18000912d:     	cmpb	$0x0, (%r15)
180009131:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009137:     	movq	%rax, 0x38(%r13,%rsi,8)
18000913c:     	movq	(%r12), %rcx
180009140:     	leaq	0x4(%rcx), %rax
180009144:     	cmpq	%rbx, %rax
180009147:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
18000914d:     	movq	%rax, (%r12)
180009151:     	cmpb	$0x0, (%r15)
180009155:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
18000915b:     	testq	%rcx, %rcx
18000915e:     	js	0x18000917a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x55ba>
180009160:     	movsd	%xmm1, 0x10(%rbp,%rcx,8)
180009166:     	movsd	%xmm2, 0x18(%rbp,%rcx,8)
18000916c:     	movsd	%xmm3, 0x8(%rbp,%rcx,8)
180009172:     	movsd	%xmm0, (%rbp,%rcx,8)
180009178:     	jmp	0x180009187 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x55c7>
18000917a:     	movb	$0x1, (%r15)
18000917e:     	movq	$0xf4242, 0x18(%r12)    # imm = 0xF4242
180009187:     	cmpb	$0x0, (%r15)
18000918b:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009191:     	movq	(%r12), %rax
180009195:     	leaq	0xb(%rax), %r8
180009199:     	cmpq	%rbx, %r8
18000919c:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
1800091a2:     	movq	0x8(%r13,%rsi,8), %rdx
1800091a7:     	movq	%r8, (%r12)
1800091ab:     	cmpb	$0x0, (%r15)
1800091af:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800091b5:     	movq	%rcx, (%r13,%rax,8)
1800091ba:     	movq	%rdx, 0x8(%r13,%rax,8)
1800091bf:     	movq	(%r12), %rdx
1800091c3:     	cmpq	%rbx, %rdx
1800091c6:     	movq	%rdx, %rcx
1800091c9:     	jle	0x1800091d5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5615>
1800091cb:     	movb	$0x2, (%r15)
1800091cf:     	movq	(%r12), %rdx
1800091d3:     	xorl	%ecx, %ecx
1800091d5:     	leaq	0x3(%rdx), %r8
1800091d9:     	cmpq	%rbx, %r8
1800091dc:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
1800091e2:     	movq	%r8, (%r12)
1800091e6:     	cmpb	$0x0, (%r15)
1800091ea:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800091f0:     	movq	%rdx, %r8
1800091f3:     	sarq	$0x3f, %r8
1800091f7:     	andq	%rbx, %r8
1800091fa:     	leaq	(%r13,%rdx,8), %r9
1800091ff:     	movq	$0x0, (%r9,%r8,8)
180009207:     	xorl	%r8d, %r8d
18000920a:     	cmpq	$-0x1, %rdx
18000920e:     	movl	$0x0, %r10d
180009214:     	cmovlq	%rbx, %r10
180009218:     	movq	$0x0, 0x8(%r9,%r10,8)
180009221:     	cmpq	$-0x2, %rdx
180009225:     	cmovlq	%rbx, %r8
180009229:     	movq	%rcx, 0x10(%r9,%r8,8)
18000922e:     	cmpb	$0x0, (%r15)
180009232:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009238:     	leaq	(%r13,%rax,8), %rcx
18000923d:     	movq	%rdx, 0x30(%rcx)
180009241:     	movq	$0x0, 0x18(%rcx)
180009249:     	movq	(%r12), %rdx
18000924d:     	leaq	0x4(%rdx), %r8
180009251:     	cmpq	%rbx, %r8
180009254:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
18000925a:     	movq	%r8, (%r12)
18000925e:     	cmpb	$0x0, (%r15)
180009262:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009268:     	testq	%rdx, %rdx
18000926b:     	js	0x180009295 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x56d5>
18000926d:     	movq	$0x0, (%rbp,%rdx,8)
180009276:     	leaq	(%r13,%rdx,8), %r8
18000927b:     	movq	$0x1, 0x8(%r13,%rdx,8)
180009284:     	movq	$0x0, 0x10(%rbp,%rdx,8)
18000928d:     	movl	$0x1, %r9d
180009293:     	jmp	0x1800092a2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x56e2>
180009295:     	movb	$0x1, (%r15)
180009299:     	movl	$0x6acfc2, %r9d         # imm = 0x6ACFC2
18000929f:     	movq	%r12, %r8
1800092a2:     	movq	%r9, 0x18(%r8)
1800092a6:     	cmpb	$0x0, (%r15)
1800092aa:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800092b0:     	movq	%rdx, 0x10(%rcx)
1800092b4:     	movq	$0x0, 0x48(%rbp,%rax,8)
1800092bd:     	movq	$0x1, 0x50(%rcx)
1800092c5:     	movq	$-0x1, 0x20(%rcx)
1800092cd:     	movq	$-0x1, 0x28(%rcx)
1800092d5:     	movq	$-0x1, 0x38(%rcx)
1800092dd:     	movq	$-0x1, 0x40(%rcx)
1800092e5:     	cmpb	$0x0, (%r15)
1800092e9:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
1800092ef:     	movq	%rax, 0x40(%r13,%rsi,8)
1800092f4:     	movq	$0x1, 0x18(%r13,%rsi,8)
1800092fd:     	movq	0x30(%r13,%rsi,8), %rax
180009302:     	movq	%rax, %rcx
180009305:     	sarq	$0x3f, %rcx
180009309:     	andq	%rbx, %rcx
18000930c:     	leaq	(%r13,%rax,8), %rdx
180009311:     	movq	%rcx, 0x160(%rsp)
180009319:     	movq	%rdx, 0x150(%rsp)
180009321:     	cmpq	$0x0, (%rdx,%rcx,8)
180009326:     	jle	0x180009b11 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5f51>
18000932c:     	leaq	(,%rbx,8), %rcx
180009334:     	xorl	%edx, %edx
180009336:     	cmpq	$-0x2, %rax
18000933a:     	movl	$0x0, %eax
18000933f:     	movq	%rax, 0x148(%rsp)
180009347:     	cmovgeq	%rdx, %rcx
18000934b:     	movq	%rcx, 0x158(%rsp)
180009353:     	movq	0x20(%r13,%rsi,8), %rax
180009358:     	testq	%rax, %rax
18000935b:     	js	0x180009b9e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5fde>
180009361:     	movq	0x150(%rsp), %rcx
180009369:     	movq	0x158(%rsp), %rdx
180009371:     	movq	0x10(%rcx,%rdx), %rcx
180009376:     	addq	0x148(%rsp), %rcx
18000937e:     	leaq	(%r13,%rcx,8), %rdx
180009383:     	sarq	$0x3f, %rcx
180009387:     	andq	%rbx, %rcx
18000938a:     	movq	(%rdx,%rcx,8), %rcx
18000938e:     	movq	%rcx, 0x140(%rsp)
180009396:     	movq	0x8(%r12), %rcx
18000939b:     	leaq	0x1(%rcx), %rdx
18000939f:     	movq	%rdx, 0x8(%r12)
1800093a4:     	cmpq	0x10(%r12), %rcx
1800093a9:     	jge	0x180009b9e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5fde>
1800093af:     	movq	0x140(%rsp), %rcx
1800093b7:     	movq	%rcx, 0x100(%rsp)
1800093bf:     	movq	%rax, 0xf8(%rsp)
1800093c7:     	movq	0x2f8(%rsp), %rax
1800093cf:     	movq	%rax, 0xe8(%rsp)
1800093d7:     	movq	0x2f0(%rsp), %rax
1800093df:     	movq	%rax, 0xe0(%rsp)
1800093e7:     	movq	%r15, 0xd8(%rsp)
1800093ef:     	movq	0x2e0(%rsp), %rax
1800093f7:     	movq	%rax, 0xd0(%rsp)
1800093ff:     	movq	0x2d8(%rsp), %rax
180009407:     	movq	%rax, 0xc8(%rsp)
18000940f:     	movq	0x2d0(%rsp), %rax
180009417:     	movq	%rax, 0xc0(%rsp)
18000941f:     	movq	0x2c8(%rsp), %rax
180009427:     	movq	%rax, 0xb8(%rsp)
18000942f:     	movq	0x2c0(%rsp), %rax
180009437:     	movq	%rax, 0xb0(%rsp)
18000943f:     	movq	0x2b8(%rsp), %rax
180009447:     	movq	%rax, 0xa8(%rsp)
18000944f:     	movq	%r12, 0xa0(%rsp)
180009457:     	movq	0x2a8(%rsp), %rax
18000945f:     	movq	%rax, 0x98(%rsp)
180009467:     	movq	0x2a0(%rsp), %rax
18000946f:     	movq	%rax, 0x90(%rsp)
180009477:     	movq	0x298(%rsp), %rax
18000947f:     	movq	%rax, 0x88(%rsp)
180009487:     	movq	0x290(%rsp), %rax
18000948f:     	movq	%rax, 0x80(%rsp)
180009497:     	movq	0x288(%rsp), %rax
18000949f:     	movq	%rax, 0x78(%rsp)
1800094a4:     	movq	%rbx, 0x70(%rsp)
1800094a9:     	movq	%r13, 0x68(%rsp)
1800094ae:     	movq	0x270(%rsp), %rax
1800094b6:     	movq	%rax, 0x60(%rsp)
1800094bb:     	movq	0x268(%rsp), %rax
1800094c3:     	movq	%rax, 0x58(%rsp)
1800094c8:     	movq	0x260(%rsp), %rax
1800094d0:     	movq	%rax, 0x50(%rsp)
1800094d5:     	movq	%rdi, 0x48(%rsp)
1800094da:     	movq	0x250(%rsp), %rax
1800094e2:     	movq	%rax, 0x40(%rsp)
1800094e7:     	movq	%r14, 0x38(%rsp)
1800094ec:     	movq	%rbp, 0x30(%rsp)
1800094f1:     	movq	0x238(%rsp), %rax
1800094f9:     	movq	%rax, 0x28(%rsp)
1800094fe:     	movq	0x230(%rsp), %rax
180009506:     	movq	%rax, 0x20(%rsp)
18000950b:     	movq	$-0x1, 0x108(%rsp)
180009517:     	movq	$0x0, 0xf0(%rsp)
180009523:     	leaq	0x12e(%rsp), %rcx
18000952b:     	leaq	0x180(%rsp), %rdx
180009533:     	movq	0x130(%rsp), %r8
18000953b:     	movq	0x138(%rsp), %r9
180009543:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180009548:     	testl	%eax, %eax
18000954a:     	jne	0x180009bb0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5ff0>
180009550:     	cmpb	$0x0, (%r15)
180009554:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
18000955a:     	movq	0x8(%r12), %rcx
18000955f:     	leaq	-0x1(%rcx), %rax
180009563:     	movq	%rax, 0x8(%r12)
180009568:     	movq	0x28(%r13,%rsi,8), %rax
18000956d:     	testq	%rax, %rax
180009570:     	js	0x180009bbd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5ffd>
180009576:     	movq	%rcx, 0x8(%r12)
18000957b:     	cmpq	0x10(%r12), %rcx
180009580:     	jg	0x180009bbd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5ffd>
180009586:     	movq	0x140(%rsp), %rcx
18000958e:     	movq	%rcx, 0x100(%rsp)
180009596:     	movq	%rax, 0xf8(%rsp)
18000959e:     	movq	0x2f8(%rsp), %rax
1800095a6:     	movq	%rax, 0xe8(%rsp)
1800095ae:     	movq	0x2f0(%rsp), %rax
1800095b6:     	movq	%rax, 0xe0(%rsp)
1800095be:     	movq	%r15, 0xd8(%rsp)
1800095c6:     	movq	0x2e0(%rsp), %rax
1800095ce:     	movq	%rax, 0xd0(%rsp)
1800095d6:     	movq	0x2d8(%rsp), %rax
1800095de:     	movq	%rax, 0xc8(%rsp)
1800095e6:     	movq	0x2d0(%rsp), %rax
1800095ee:     	movq	%rax, 0xc0(%rsp)
1800095f6:     	movq	0x2c8(%rsp), %rax
1800095fe:     	movq	%rax, 0xb8(%rsp)
180009606:     	movq	0x2c0(%rsp), %rax
18000960e:     	movq	%rax, 0xb0(%rsp)
180009616:     	movq	0x2b8(%rsp), %rax
18000961e:     	movq	%rax, 0xa8(%rsp)
180009626:     	movq	%r12, 0xa0(%rsp)
18000962e:     	movq	0x2a8(%rsp), %rax
180009636:     	movq	%rax, 0x98(%rsp)
18000963e:     	movq	0x2a0(%rsp), %rax
180009646:     	movq	%rax, 0x90(%rsp)
18000964e:     	movq	0x298(%rsp), %rax
180009656:     	movq	%rax, 0x88(%rsp)
18000965e:     	movq	0x290(%rsp), %rax
180009666:     	movq	%rax, 0x80(%rsp)
18000966e:     	movq	0x288(%rsp), %rax
180009676:     	movq	%rax, 0x78(%rsp)
18000967b:     	movq	%rbx, 0x70(%rsp)
180009680:     	movq	%r13, 0x68(%rsp)
180009685:     	movq	0x270(%rsp), %rax
18000968d:     	movq	%rax, 0x60(%rsp)
180009692:     	movq	0x268(%rsp), %rax
18000969a:     	movq	%rax, 0x58(%rsp)
18000969f:     	movq	0x260(%rsp), %rax
1800096a7:     	movq	%rax, 0x50(%rsp)
1800096ac:     	movq	%rdi, 0x48(%rsp)
1800096b1:     	movq	0x250(%rsp), %rax
1800096b9:     	movq	%rax, 0x40(%rsp)
1800096be:     	movq	%r14, 0x38(%rsp)
1800096c3:     	movq	%rbp, 0x30(%rsp)
1800096c8:     	movq	0x238(%rsp), %rax
1800096d0:     	movq	%rax, 0x28(%rsp)
1800096d5:     	movq	0x230(%rsp), %rax
1800096dd:     	movq	%rax, 0x20(%rsp)
1800096e2:     	movq	$-0x1, 0x108(%rsp)
1800096ee:     	movq	$0x0, 0xf0(%rsp)
1800096fa:     	leaq	0x12d(%rsp), %rcx
180009702:     	leaq	0x178(%rsp), %rdx
18000970a:     	movq	0x130(%rsp), %r8
180009712:     	movq	0x138(%rsp), %r9
18000971a:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
18000971f:     	testl	%eax, %eax
180009721:     	jne	0x180009bcf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x600f>
180009727:     	cmpb	$0x0, (%r15)
18000972b:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009731:     	movq	0x8(%r12), %rcx
180009736:     	leaq	-0x1(%rcx), %rax
18000973a:     	movq	%rax, 0x8(%r12)
18000973f:     	movq	0x38(%r13,%rsi,8), %rax
180009744:     	testq	%rax, %rax
180009747:     	js	0x180009bdc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x601c>
18000974d:     	movq	%rcx, 0x8(%r12)
180009752:     	cmpq	0x10(%r12), %rcx
180009757:     	jg	0x180009bdc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x601c>
18000975d:     	movq	0x140(%rsp), %rcx
180009765:     	movq	%rcx, 0x100(%rsp)
18000976d:     	movq	%rax, 0xf8(%rsp)
180009775:     	movq	0x2f8(%rsp), %rax
18000977d:     	movq	%rax, 0xe8(%rsp)
180009785:     	movq	0x2f0(%rsp), %rax
18000978d:     	movq	%rax, 0xe0(%rsp)
180009795:     	movq	%r15, 0xd8(%rsp)
18000979d:     	movq	0x2e0(%rsp), %rax
1800097a5:     	movq	%rax, 0xd0(%rsp)
1800097ad:     	movq	0x2d8(%rsp), %rax
1800097b5:     	movq	%rax, 0xc8(%rsp)
1800097bd:     	movq	0x2d0(%rsp), %rax
1800097c5:     	movq	%rax, 0xc0(%rsp)
1800097cd:     	movq	0x2c8(%rsp), %rax
1800097d5:     	movq	%rax, 0xb8(%rsp)
1800097dd:     	movq	0x2c0(%rsp), %rax
1800097e5:     	movq	%rax, 0xb0(%rsp)
1800097ed:     	movq	0x2b8(%rsp), %rax
1800097f5:     	movq	%rax, 0xa8(%rsp)
1800097fd:     	movq	%r12, 0xa0(%rsp)
180009805:     	movq	0x2a8(%rsp), %rax
18000980d:     	movq	%rax, 0x98(%rsp)
180009815:     	movq	0x2a0(%rsp), %rax
18000981d:     	movq	%rax, 0x90(%rsp)
180009825:     	movq	0x298(%rsp), %rax
18000982d:     	movq	%rax, 0x88(%rsp)
180009835:     	movq	0x290(%rsp), %rax
18000983d:     	movq	%rax, 0x80(%rsp)
180009845:     	movq	0x288(%rsp), %rax
18000984d:     	movq	%rax, 0x78(%rsp)
180009852:     	movq	%rbx, 0x70(%rsp)
180009857:     	movq	%r13, 0x68(%rsp)
18000985c:     	movq	0x270(%rsp), %rax
180009864:     	movq	%rax, 0x60(%rsp)
180009869:     	movq	0x268(%rsp), %rax
180009871:     	movq	%rax, 0x58(%rsp)
180009876:     	movq	0x260(%rsp), %rax
18000987e:     	movq	%rax, 0x50(%rsp)
180009883:     	movq	%rdi, 0x48(%rsp)
180009888:     	movq	0x250(%rsp), %rax
180009890:     	movq	%rax, 0x40(%rsp)
180009895:     	movq	%r14, 0x38(%rsp)
18000989a:     	movq	%rbp, 0x30(%rsp)
18000989f:     	movq	0x238(%rsp), %rax
1800098a7:     	movq	%rax, 0x28(%rsp)
1800098ac:     	movq	0x230(%rsp), %rax
1800098b4:     	movq	%rax, 0x20(%rsp)
1800098b9:     	movq	$-0x1, 0x108(%rsp)
1800098c5:     	movq	$0x0, 0xf0(%rsp)
1800098d1:     	leaq	0x12c(%rsp), %rcx
1800098d9:     	leaq	0x170(%rsp), %rdx
1800098e1:     	movq	0x130(%rsp), %r8
1800098e9:     	movq	0x138(%rsp), %r9
1800098f1:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
1800098f6:     	testl	%eax, %eax
1800098f8:     	jne	0x180009bee <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x602e>
1800098fe:     	cmpb	$0x0, (%r15)
180009902:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009908:     	movq	0x8(%r12), %rcx
18000990d:     	leaq	-0x1(%rcx), %rax
180009911:     	movq	%rax, 0x8(%r12)
180009916:     	movq	0x40(%r13,%rsi,8), %rax
18000991b:     	testq	%rax, %rax
18000991e:     	js	0x180009bfb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x603b>
180009924:     	movq	%rcx, 0x8(%r12)
180009929:     	cmpq	0x10(%r12), %rcx
18000992e:     	jg	0x180009bfb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x603b>
180009934:     	movq	0x140(%rsp), %rcx
18000993c:     	movq	%rcx, 0x100(%rsp)
180009944:     	movq	%rax, 0xf8(%rsp)
18000994c:     	movq	0x2f8(%rsp), %rax
180009954:     	movq	%rax, 0xe8(%rsp)
18000995c:     	movq	0x2f0(%rsp), %rax
180009964:     	movq	%rax, 0xe0(%rsp)
18000996c:     	movq	%r15, 0xd8(%rsp)
180009974:     	movq	0x2e0(%rsp), %rax
18000997c:     	movq	%rax, 0xd0(%rsp)
180009984:     	movq	0x2d8(%rsp), %rax
18000998c:     	movq	%rax, 0xc8(%rsp)
180009994:     	movq	0x2d0(%rsp), %rax
18000999c:     	movq	%rax, 0xc0(%rsp)
1800099a4:     	movq	0x2c8(%rsp), %rax
1800099ac:     	movq	%rax, 0xb8(%rsp)
1800099b4:     	movq	0x2c0(%rsp), %rax
1800099bc:     	movq	%rax, 0xb0(%rsp)
1800099c4:     	movq	0x2b8(%rsp), %rax
1800099cc:     	movq	%rax, 0xa8(%rsp)
1800099d4:     	movq	%r12, 0xa0(%rsp)
1800099dc:     	movq	0x2a8(%rsp), %rax
1800099e4:     	movq	%rax, 0x98(%rsp)
1800099ec:     	movq	0x2a0(%rsp), %rax
1800099f4:     	movq	%rax, 0x90(%rsp)
1800099fc:     	movq	0x298(%rsp), %rax
180009a04:     	movq	%rax, 0x88(%rsp)
180009a0c:     	movq	0x290(%rsp), %rax
180009a14:     	movq	%rax, 0x80(%rsp)
180009a1c:     	movq	0x288(%rsp), %rax
180009a24:     	movq	%rax, 0x78(%rsp)
180009a29:     	movq	%rbx, 0x70(%rsp)
180009a2e:     	movq	%r13, 0x68(%rsp)
180009a33:     	movq	0x270(%rsp), %rax
180009a3b:     	movq	%rax, 0x60(%rsp)
180009a40:     	movq	0x268(%rsp), %rax
180009a48:     	movq	%rax, 0x58(%rsp)
180009a4d:     	movq	0x260(%rsp), %rax
180009a55:     	movq	%rax, 0x50(%rsp)
180009a5a:     	movq	%rdi, 0x48(%rsp)
180009a5f:     	movq	0x250(%rsp), %rax
180009a67:     	movq	%rax, 0x40(%rsp)
180009a6c:     	movq	%r14, 0x38(%rsp)
180009a71:     	movq	%rbp, 0x30(%rsp)
180009a76:     	movq	0x238(%rsp), %rax
180009a7e:     	movq	%rax, 0x28(%rsp)
180009a83:     	movq	0x230(%rsp), %rax
180009a8b:     	movq	%rax, 0x20(%rsp)
180009a90:     	movq	$-0x1, 0x108(%rsp)
180009a9c:     	movq	$0x0, 0xf0(%rsp)
180009aa8:     	leaq	0x12b(%rsp), %rcx
180009ab0:     	leaq	0x168(%rsp), %rdx
180009ab8:     	movq	0x130(%rsp), %r8
180009ac0:     	movq	0x138(%rsp), %r9
180009ac8:     	callq	0x180007920 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x3d60>
180009acd:     	testl	%eax, %eax
180009acf:     	jne	0x180009c0d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x604d>
180009ad5:     	cmpb	$0x0, (%r15)
180009ad9:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009adf:     	movq	0x148(%rsp), %r8
180009ae7:     	incq	%r8
180009aea:     	decq	0x8(%r12)
180009aef:     	movq	0x160(%rsp), %rax
180009af7:     	movq	0x150(%rsp), %rcx
180009aff:     	movq	%r8, 0x148(%rsp)
180009b07:     	cmpq	(%rcx,%rax,8), %r8
180009b0b:     	jl	0x180009353 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5793>
180009b11:     	movq	(%r12), %rcx
180009b15:     	cmpq	%rbx, %rcx
180009b18:     	movq	%rcx, %rdx
180009b1b:     	jle	0x180009b27 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5f67>
180009b1d:     	movb	$0x2, (%r15)
180009b21:     	movq	(%r12), %rcx
180009b25:     	xorl	%edx, %edx
180009b27:     	leaq	0x3(%rcx), %rax
180009b2b:     	cmpq	%rbx, %rax
180009b2e:     	jg	0x180008bc1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x5001>
180009b34:     	movq	%rax, (%r12)
180009b38:     	cmpb	$0x0, (%r15)
180009b3c:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009b42:     	movq	%rcx, %rax
180009b45:     	sarq	$0x3f, %rax
180009b49:     	andq	%rbx, %rax
180009b4c:     	leaq	(%r13,%rcx,8), %r8
180009b51:     	movq	$0x0, (%r8,%rax,8)
180009b59:     	xorl	%eax, %eax
180009b5b:     	cmpq	$-0x1, %rcx
180009b5f:     	movl	$0x0, %r9d
180009b65:     	cmovlq	%rbx, %r9
180009b69:     	movq	$0x0, 0x8(%r8,%r9,8)
180009b72:     	cmpq	$-0x2, %rcx
180009b76:     	cmovgeq	%rax, %rbx
180009b7a:     	movq	%rdx, 0x10(%r8,%rbx,8)
180009b7f:     	cmpb	$0x0, (%r15)
180009b83:     	jne	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009b89:     	movq	%rcx, 0x30(%r13,%rsi,8)
180009b8e:     	movq	0x110(%rsp), %rcx
180009b96:     	movb	$0x0, (%rcx)
180009b99:     	jmp	0x1800082a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x46e3>
180009b9e:     	movb	$0x1, (%r15)
180009ba2:     	movq	$0x989697, 0x18(%r12)   # imm = 0x989697
180009bab:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009bb0:     	movq	0x180(%rsp), %rdx
180009bb8:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180009bbd:     	movb	$0x1, (%r15)
180009bc1:     	movq	$0x989698, 0x18(%r12)   # imm = 0x989698
180009bca:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009bcf:     	movq	0x178(%rsp), %rdx
180009bd7:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180009bdc:     	movb	$0x1, (%r15)
180009be0:     	movq	$0x989699, 0x18(%r12)   # imm = 0x989699
180009be9:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009bee:     	movq	0x170(%rsp), %rdx
180009bf6:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180009bfb:     	movb	$0x1, (%r15)
180009bff:     	movq	$0x98969a, 0x18(%r12)   # imm = 0x98969A
180009c08:     	jmp	0x1800084c1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4901>
180009c0d:     	movq	0x168(%rsp), %rdx
180009c15:     	jmp	0x180008921 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x4d61>
180009c1a:     	int3
180009c1b:     	int3
180009c1c:     	int3
180009c1d:     	int3
180009c1e:     	int3
180009c1f:     	int3
180009c20:     	pushq	%rbx
180009c22:     	subq	$0x20, %rsp
180009c26:     	movq	%rcx, %rbx
180009c29:     	callq	*0x34c1(%rip)           # 0x18000d0f0
180009c2f:     	movl	%eax, (%rbx)
180009c31:     	addq	$0x20, %rsp
180009c35:     	popq	%rbx
180009c36:     	retq
180009c37:     	int3
180009c38:     	int3
180009c39:     	int3
180009c3a:     	int3
180009c3b:     	int3
180009c3c:     	int3
180009c3d:     	int3
180009c3e:     	int3
180009c3f:     	int3
180009c40:     	movl	(%rcx), %ecx
180009c42:     	jmpq	*0x35c7(%rip)           # 0x18000d210
180009c49:     	int3
180009c4a:     	int3
180009c4b:     	int3
180009c4c:     	int3
180009c4d:     	int3
180009c4e:     	int3
180009c4f:     	int3
180009c50:     	pushq	%rbp
180009c52:     	pushq	%rbx
180009c53:     	pushq	%rsi
180009c54:     	pushq	%rdi
180009c55:     	pushq	%r14
180009c57:     	pushq	%r15
180009c59:     	movq	%rsp, %rbp
180009c5c:     	subq	$0x48, %rsp
180009c60:     	movq	0x3579(%rip), %rax      # 0x18000d1e0
180009c67:     	xorl	%r15d, %r15d
180009c6a:     	movq	%rcx, %rsi
180009c6d:     	movq	%r15, 0x38(%rbp)
180009c71:     	movl	%r15d, %r14d
180009c74:     	movq	%r15, 0x50(%rbp)
180009c78:     	movq	%r15, 0x48(%rbp)
180009c7c:     	cmpq	%rax, 0x8(%rcx)
180009c80:     	jne	0x180009dee <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x622e>
180009c86:     	leaq	0x48(%rbp), %rax
180009c8a:     	leaq	0x50(%rbp), %r9
180009c8e:     	movq	%rax, 0x20(%rsp)
180009c93:     	leaq	0x38(%rbp), %r8
180009c97:     	leaq	0x41e6(%rip), %rdx      # 0x18000de84
180009c9e:     	callq	*0x348c(%rip)           # 0x18000d130
180009ca4:     	testl	%eax, %eax
180009ca6:     	jne	0x180009de4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6224>
180009cac:     	movq	0x48(%rbp), %rbx
180009cb0:     	testq	%rbx, %rbx
180009cb3:     	je	0x180009dd5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6215>
180009cb9:     	cmpq	0x3610(%rip), %rbx      # 0x18000d2d0
180009cc0:     	je	0x180009dd5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6215>
180009cc6:     	movq	0x8(%rbx), %rax
180009cca:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009cd4:     	je	0x180009dd5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6215>
180009cda:     	movq	0x20(%rbx), %rcx
180009cde:     	callq	*0x349c(%rip)           # 0x18000d180
180009ce4:     	movq	0x28(%rbx), %rcx
180009ce8:     	movq	%rax, %rdi
180009ceb:     	callq	*0x348f(%rip)           # 0x18000d180
180009cf1:     	movq	0x30(%rbx), %rcx
180009cf5:     	movq	%rax, %r14
180009cf8:     	callq	*0x3492(%rip)           # 0x18000d190
180009cfe:     	leaq	-0x10(%rbp), %r8
180009d02:     	movl	%eax, %ebx
180009d04:     	leaq	-0x18(%rbp), %rdx
180009d08:     	leaq	0x40(%rbp), %rcx
180009d0c:     	callq	*0x348e(%rip)           # 0x18000d1a0
180009d12:     	callq	*0x3448(%rip)           # 0x18000d160
180009d18:     	movq	%rax, %rsi
180009d1b:     	testq	%rax, %rax
180009d1e:     	je	0x180009dcb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x620b>
180009d24:     	movl	%ebx, %r8d
180009d27:     	movq	%rdi, %rdx
180009d2a:     	movq	%r14, %rcx
180009d2d:     	callq	*0x3525(%rip)           # 0x18000d258
180009d33:     	movq	%rax, %rdi
180009d36:     	testq	%rax, %rax
180009d39:     	je	0x180009dcb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x620b>
180009d3f:     	callq	*0x3523(%rip)           # 0x18000d268
180009d45:     	xorl	%r9d, %r9d
180009d48:     	movq	%rsi, %r8
180009d4b:     	movq	%rax, %rcx
180009d4e:     	movq	%rdi, %rdx
180009d51:     	callq	*0x34e9(%rip)           # 0x18000d240
180009d57:     	movl	(%rsi), %ecx
180009d59:     	movq	%rax, %rbx
180009d5c:     	testl	%ecx, %ecx
180009d5e:     	js	0x180009d70 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x61b0>
180009d60:     	subl	$0x1, %ecx
180009d63:     	movl	%ecx, (%rsi)
180009d65:     	jne	0x180009d70 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x61b0>
180009d67:     	movq	%rsi, %rcx
180009d6a:     	callq	*0x3458(%rip)           # 0x18000d1c8
180009d70:     	movl	(%rdi), %eax
180009d72:     	testl	%eax, %eax
180009d74:     	js	0x180009d86 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x61c6>
180009d76:     	subl	$0x1, %eax
180009d79:     	movl	%eax, (%rdi)
180009d7b:     	jne	0x180009d86 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x61c6>
180009d7d:     	movq	%rdi, %rcx
180009d80:     	callq	*0x3442(%rip)           # 0x18000d1c8
180009d86:     	testq	%rbx, %rbx
180009d89:     	je	0x180009dcb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x620b>
180009d8b:     	movq	-0x10(%rbp), %r8
180009d8f:     	movq	-0x18(%rbp), %rdx
180009d93:     	movq	0x40(%rbp), %rcx
180009d97:     	callq	*0x3433(%rip)           # 0x18000d1d0
180009d9d:     	movq	%rbx, %rcx
180009da0:     	callq	*0x3482(%rip)           # 0x18000d228
180009da6:     	movl	(%rbx), %eax
180009da8:     	testl	%eax, %eax
180009daa:     	js	0x180009dd5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6215>
180009dac:     	subl	$0x1, %eax
180009daf:     	movl	%eax, (%rbx)
180009db1:     	jne	0x180009dd5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6215>
180009db3:     	movq	%rbx, %rcx
180009db6:     	callq	*0x340c(%rip)           # 0x18000d1c8
180009dbc:     	xorl	%eax, %eax
180009dbe:     	addq	$0x48, %rsp
180009dc2:     	popq	%r15
180009dc4:     	popq	%r14
180009dc6:     	popq	%rdi
180009dc7:     	popq	%rsi
180009dc8:     	popq	%rbx
180009dc9:     	popq	%rbp
180009dca:     	retq
180009dcb:     	movq	0x40(%rbp), %rcx
180009dcf:     	callq	*0x342b(%rip)           # 0x18000d200
180009dd5:     	xorl	%eax, %eax
180009dd7:     	addq	$0x48, %rsp
180009ddb:     	popq	%r15
180009ddd:     	popq	%r14
180009ddf:     	popq	%rdi
180009de0:     	popq	%rsi
180009de1:     	popq	%rbx
180009de2:     	popq	%rbp
180009de3:     	retq
180009de4:     	movq	0x38(%rbp), %rbx
180009de8:     	movq	0x50(%rbp), %r14
180009dec:     	jmp	0x180009df5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6235>
180009dee:     	movq	%rsi, %rbx
180009df1:     	movq	%rbx, 0x38(%rbp)
180009df5:     	cmpq	0x34d4(%rip), %rbx      # 0x18000d2d0
180009dfc:     	jne	0x180009e94 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x62d4>
180009e02:     	leaq	-0x18(%rbp), %r8
180009e06:     	leaq	-0x10(%rbp), %rdx
180009e0a:     	leaq	0x40(%rbp), %rcx
180009e0e:     	callq	*0x330c(%rip)           # 0x18000d120
180009e14:     	movq	0x34b5(%rip), %rax      # 0x18000d2d0
180009e1b:     	cmpq	%rax, 0x40(%rbp)
180009e1f:     	jne	0x180009e34 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6274>
180009e21:     	movq	0x3488(%rip), %rcx      # 0x18000d2b0
180009e28:     	leaq	0x4009(%rip), %rdx      # 0x18000de38
180009e2f:     	jmp	0x180009f55 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6395>
180009e34:     	movq	0x40(%rbp), %rcx
180009e38:     	testq	%rcx, %rcx
180009e3b:     	je	0x180009e4a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x628a>
180009e3d:     	movl	(%rcx), %eax
180009e3f:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009e44:     	jae	0x180009e4a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x628a>
180009e46:     	incl	%eax
180009e48:     	movl	%eax, (%rcx)
180009e4a:     	movq	-0x10(%rbp), %rcx
180009e4e:     	testq	%rcx, %rcx
180009e51:     	je	0x180009e60 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x62a0>
180009e53:     	movl	(%rcx), %eax
180009e55:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009e5a:     	jae	0x180009e60 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x62a0>
180009e5c:     	incl	%eax
180009e5e:     	movl	%eax, (%rcx)
180009e60:     	movq	-0x18(%rbp), %r8
180009e64:     	testq	%r8, %r8
180009e67:     	je	0x180009e7c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x62bc>
180009e69:     	movl	(%r8), %eax
180009e6c:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
180009e71:     	jae	0x180009e7c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x62bc>
180009e73:     	incl	%eax
180009e75:     	movl	%eax, (%r8)
180009e78:     	movq	-0x18(%rbp), %r8
180009e7c:     	movq	-0x10(%rbp), %rdx
180009e80:     	movq	0x40(%rbp), %rcx
180009e84:     	callq	*0x3346(%rip)           # 0x18000d1d0
180009e8a:     	movl	$0x1, %ebx
180009e8f:     	jmp	0x180009f61 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x63a1>
180009e94:     	movq	0x8(%rbx), %rcx
180009e98:     	movl	0xa8(%rcx), %eax
180009e9e:     	testl	%eax, %eax
180009ea0:     	jns	0x180009f36 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6376>
180009ea6:     	testl	$0x40000000, 0xa8(%rbx) # imm = 0x40000000
180009eb0:     	je	0x180009f36 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6376>
180009eb6:     	movq	%r14, %rdx
180009eb9:     	movq	%rbx, %rcx
180009ebc:     	callq	*0x3226(%rip)           # 0x18000d0e8
180009ec2:     	movq	%rax, %rdi
180009ec5:     	testq	%rax, %rax
180009ec8:     	je	0x180009f5e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x639e>
180009ece:     	movq	0x8(%rax), %rax
180009ed2:     	testl	$0x40000000, 0xa8(%rax) # imm = 0x40000000
180009edc:     	jne	0x180009f0d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x634d>
180009ede:     	movq	0x33bb(%rip), %rcx      # 0x18000d2a0
180009ee5:     	leaq	0x3f6c(%rip), %rdx      # 0x18000de58
180009eec:     	movq	(%rcx), %rcx
180009eef:     	callq	*0x33b3(%rip)           # 0x18000d2a8
180009ef5:     	movl	(%rdi), %eax
180009ef7:     	testl	%eax, %eax
180009ef9:     	js	0x180009f5e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x639e>
180009efb:     	subl	$0x1, %eax
180009efe:     	movl	%eax, (%rdi)
180009f00:     	jne	0x180009f5e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x639e>
180009f02:     	movq	%rdi, %rcx
180009f05:     	callq	*0x32bd(%rip)           # 0x18000d1c8
180009f0b:     	jmp	0x180009f5e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x639e>
180009f0d:     	movl	(%rdi), %eax
180009f0f:     	testl	%eax, %eax
180009f11:     	js	0x180009f23 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6363>
180009f13:     	subl	$0x1, %eax
180009f16:     	movl	%eax, (%rdi)
180009f18:     	jne	0x180009f23 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6363>
180009f1a:     	movq	%rdi, %rcx
180009f1d:     	callq	*0x32a5(%rip)           # 0x18000d1c8
180009f23:     	movq	%r14, %rdx
180009f26:     	movq	%rbx, %rcx
180009f29:     	callq	*0x3331(%rip)           # 0x18000d260
180009f2f:     	movl	$0x1, %ebx
180009f34:     	jmp	0x180009f61 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x63a1>
180009f36:     	btl	$0x1e, %eax
180009f3a:     	jae	0x180009f47 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6387>
180009f3c:     	movq	%rbx, %rdx
180009f3f:     	callq	*0x331b(%rip)           # 0x18000d260
180009f45:     	jmp	0x180009f5e <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x639e>
180009f47:     	movq	0x3352(%rip), %rcx      # 0x18000d2a0
180009f4e:     	leaq	0x3f03(%rip), %rdx      # 0x18000de58
180009f55:     	movq	(%rcx), %rcx
180009f58:     	callq	*0x334a(%rip)           # 0x18000d2a8
180009f5e:     	movl	%r15d, %ebx
180009f61:     	movq	0x48(%rbp), %rdi
180009f65:     	testq	%rdi, %rdi
180009f68:     	je	0x18000a08b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64cb>
180009f6e:     	cmpq	0x335b(%rip), %rdi      # 0x18000d2d0
180009f75:     	je	0x18000a08b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64cb>
180009f7b:     	movq	0x8(%rdi), %rax
180009f7f:     	testl	$0x4000000, 0xa8(%rax)  # imm = 0x4000000
180009f89:     	je	0x18000a08b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64cb>
180009f8f:     	movq	0x20(%rdi), %rcx
180009f93:     	movq	%r12, 0x40(%rsp)
180009f98:     	callq	*0x31e2(%rip)           # 0x18000d180
180009f9e:     	movq	0x28(%rdi), %rcx
180009fa2:     	movq	%rax, %r14
180009fa5:     	callq	*0x31d5(%rip)           # 0x18000d180
180009fab:     	movq	0x30(%rdi), %rcx
180009faf:     	movq	%rax, %r12
180009fb2:     	callq	*0x31d8(%rip)           # 0x18000d190
180009fb8:     	leaq	-0x10(%rbp), %r8
180009fbc:     	movl	%eax, %edi
180009fbe:     	leaq	-0x18(%rbp), %rdx
180009fc2:     	leaq	0x40(%rbp), %rcx
180009fc6:     	callq	*0x31d4(%rip)           # 0x18000d1a0
180009fcc:     	callq	*0x318e(%rip)           # 0x18000d160
180009fd2:     	movq	%rax, %r15
180009fd5:     	testq	%rax, %rax
180009fd8:     	je	0x18000a07c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64bc>
180009fde:     	movl	%edi, %r8d
180009fe1:     	movq	%r14, %rdx
180009fe4:     	movq	%r12, %rcx
180009fe7:     	callq	*0x326b(%rip)           # 0x18000d258
180009fed:     	movq	%rax, %r14
180009ff0:     	testq	%rax, %rax
180009ff3:     	je	0x18000a07c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64bc>
180009ff9:     	callq	*0x3269(%rip)           # 0x18000d268
180009fff:     	xorl	%r9d, %r9d
18000a002:     	movq	%r15, %r8
18000a005:     	movq	%rax, %rcx
18000a008:     	movq	%r14, %rdx
18000a00b:     	callq	*0x322f(%rip)           # 0x18000d240
18000a011:     	movl	(%r15), %ecx
18000a014:     	movq	%rax, %rdi
18000a017:     	testl	%ecx, %ecx
18000a019:     	js	0x18000a02c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x646c>
18000a01b:     	subl	$0x1, %ecx
18000a01e:     	movl	%ecx, (%r15)
18000a021:     	jne	0x18000a02c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x646c>
18000a023:     	movq	%r15, %rcx
18000a026:     	callq	*0x319c(%rip)           # 0x18000d1c8
18000a02c:     	movl	(%r14), %eax
18000a02f:     	testl	%eax, %eax
18000a031:     	js	0x18000a044 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6484>
18000a033:     	subl	$0x1, %eax
18000a036:     	movl	%eax, (%r14)
18000a039:     	jne	0x18000a044 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6484>
18000a03b:     	movq	%r14, %rcx
18000a03e:     	callq	*0x3184(%rip)           # 0x18000d1c8
18000a044:     	testq	%rdi, %rdi
18000a047:     	je	0x18000a07c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64bc>
18000a049:     	movq	-0x10(%rbp), %r8
18000a04d:     	movq	-0x18(%rbp), %rdx
18000a051:     	movq	0x40(%rbp), %rcx
18000a055:     	callq	*0x3175(%rip)           # 0x18000d1d0
18000a05b:     	movq	%rdi, %rcx
18000a05e:     	callq	*0x31c4(%rip)           # 0x18000d228
18000a064:     	movl	(%rdi), %eax
18000a066:     	testl	%eax, %eax
18000a068:     	js	0x18000a086 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64c6>
18000a06a:     	subl	$0x1, %eax
18000a06d:     	movl	%eax, (%rdi)
18000a06f:     	jne	0x18000a086 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64c6>
18000a071:     	movq	%rdi, %rcx
18000a074:     	callq	*0x314e(%rip)           # 0x18000d1c8
18000a07a:     	jmp	0x18000a086 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64c6>
18000a07c:     	movq	0x40(%rbp), %rcx
18000a080:     	callq	*0x317a(%rip)           # 0x18000d200
18000a086:     	movq	0x40(%rsp), %r12
18000a08b:     	movl	(%rsi), %ecx
18000a08d:     	testl	%ecx, %ecx
18000a08f:     	js	0x18000a0a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64e1>
18000a091:     	subl	$0x1, %ecx
18000a094:     	movl	%ecx, (%rsi)
18000a096:     	jne	0x18000a0a1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x64e1>
18000a098:     	movq	%rsi, %rcx
18000a09b:     	callq	*0x3127(%rip)           # 0x18000d1c8
18000a0a1:     	movl	%ebx, %eax
18000a0a3:     	addq	$0x48, %rsp
18000a0a7:     	popq	%r15
18000a0a9:     	popq	%r14
18000a0ab:     	popq	%rdi
18000a0ac:     	popq	%rsi
18000a0ad:     	popq	%rbx
18000a0ae:     	popq	%rbp
18000a0af:     	retq
18000a0b0:     	movq	%rbx, 0x8(%rsp)
18000a0b5:     	movq	%rsi, 0x10(%rsp)
18000a0ba:     	pushq	%rdi
18000a0bb:     	subq	$0x20, %rsp
18000a0bf:     	cmpq	$0x0, 0xabd1(%rip)      # 0x180014c98
18000a0c7:     	movq	%rcx, %rsi
18000a0ca:     	movslq	%edx, %rdi
18000a0cd:     	jne	0x18000a11d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x655d>
18000a0cf:     	leaq	0x3db2(%rip), %rcx      # 0x18000de88
18000a0d6:     	callq	*0x315c(%rip)           # 0x18000d238
18000a0dc:     	movq	%rax, %rbx
18000a0df:     	testq	%rax, %rax
18000a0e2:     	je	0x18000a131 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6571>
18000a0e4:     	leaq	0x3da5(%rip), %rdx      # 0x18000de90
18000a0eb:     	movq	%rax, %rcx
18000a0ee:     	callq	*0x3074(%rip)           # 0x18000d168
18000a0f4:     	movl	(%rbx), %ecx
18000a0f6:     	movq	%rax, 0xab9b(%rip)      # 0x180014c98
18000a0fd:     	testl	%ecx, %ecx
18000a0ff:     	js	0x18000a118 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6558>
18000a101:     	subl	$0x1, %ecx
18000a104:     	movl	%ecx, (%rbx)
18000a106:     	jne	0x18000a118 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6558>
18000a108:     	movq	%rbx, %rcx
18000a10b:     	callq	*0x30b7(%rip)           # 0x18000d1c8
18000a111:     	movq	0xab80(%rip), %rax      # 0x180014c98
18000a118:     	testq	%rax, %rax
18000a11b:     	je	0x18000a131 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6571>
18000a11d:     	movq	%rdi, %rdx
18000a120:     	movq	%rsi, %rcx
18000a123:     	callq	*0x318f(%rip)           # 0x18000d2b8
18000a129:     	movq	%rax, %rbx
18000a12c:     	testq	%rax, %rax
18000a12f:     	jne	0x18000a143 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6583>
18000a131:     	xorl	%eax, %eax
18000a133:     	movq	0x30(%rsp), %rbx
18000a138:     	movq	0x38(%rsp), %rsi
18000a13d:     	addq	$0x20, %rsp
18000a141:     	popq	%rdi
18000a142:     	retq
18000a143:     	movq	0xab4e(%rip), %rcx      # 0x180014c98
18000a14a:     	xorl	%r8d, %r8d
18000a14d:     	movq	%rbx, %rdx
18000a150:     	callq	*0x3042(%rip)           # 0x18000d198
18000a156:     	movl	(%rbx), %ecx
18000a158:     	movq	%rax, %rdi
18000a15b:     	testl	%ecx, %ecx
18000a15d:     	js	0x18000a16f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65af>
18000a15f:     	subl	$0x1, %ecx
18000a162:     	movl	%ecx, (%rbx)
18000a164:     	jne	0x18000a16f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x65af>
18000a166:     	movq	%rbx, %rcx
18000a169:     	callq	*0x3059(%rip)           # 0x18000d1c8
18000a16f:     	movq	0x30(%rsp), %rbx
18000a174:     	movq	%rdi, %rax
18000a177:     	movq	0x38(%rsp), %rsi
18000a17c:     	addq	$0x20, %rsp
18000a180:     	popq	%rdi
18000a181:     	retq
18000a182:     	int3
18000a183:     	int3
18000a184:     	int3
18000a185:     	int3
18000a186:     	int3
18000a187:     	int3
18000a188:     	int3
18000a189:     	int3
18000a18a:     	int3
18000a18b:     	int3
18000a18c:     	int3
18000a18d:     	int3
18000a18e:     	int3
18000a18f:     	int3
18000a190:     	movq	%rbx, 0x8(%rsp)
18000a195:     	movq	%rsi, 0x10(%rsp)
18000a19a:     	pushq	%rdi
18000a19b:     	subq	$0x20, %rsp
18000a19f:     	movq	0xaaea(%rip), %rax      # 0x180014c90
18000a1a6:     	movq	%rdx, %rdi
18000a1a9:     	movq	%rcx, %rsi
18000a1ac:     	testq	%rax, %rax
18000a1af:     	jne	0x18000a211 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6651>
18000a1b1:     	leaq	0x3ce0(%rip), %rcx      # 0x18000de98
18000a1b8:     	callq	*0x307a(%rip)           # 0x18000d238
18000a1be:     	movq	%rax, %rbx
18000a1c1:     	testq	%rax, %rax
18000a1c4:     	je	0x18000a1ff <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x663f>
18000a1c6:     	leaq	0x3ce3(%rip), %rdx      # 0x18000deb0
18000a1cd:     	movq	%rax, %rcx
18000a1d0:     	callq	*0x2f92(%rip)           # 0x18000d168
18000a1d6:     	movl	(%rbx), %ecx
18000a1d8:     	movq	%rax, 0xaab1(%rip)      # 0x180014c90
18000a1df:     	testl	%ecx, %ecx
18000a1e1:     	js	0x18000a1fa <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x663a>
18000a1e3:     	subl	$0x1, %ecx
18000a1e6:     	movl	%ecx, (%rbx)
18000a1e8:     	jne	0x18000a1fa <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x663a>
18000a1ea:     	movq	%rbx, %rcx
18000a1ed:     	callq	*0x2fd5(%rip)           # 0x18000d1c8
18000a1f3:     	movq	0xaa96(%rip), %rax      # 0x180014c90
18000a1fa:     	testq	%rax, %rax
18000a1fd:     	jne	0x18000a211 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6651>
18000a1ff:     	xorl	%eax, %eax
18000a201:     	movq	0x30(%rsp), %rbx
18000a206:     	movq	0x38(%rsp), %rsi
18000a20b:     	addq	$0x20, %rsp
18000a20f:     	popq	%rdi
18000a210:     	retq
18000a211:     	xorl	%r9d, %r9d
18000a214:     	movq	%rdi, %r8
18000a217:     	movq	%rsi, %rdx
18000a21a:     	movq	%rax, %rcx
18000a21d:     	movq	0x30(%rsp), %rbx
18000a222:     	movq	0x38(%rsp), %rsi
18000a227:     	addq	$0x20, %rsp
18000a22b:     	popq	%rdi
18000a22c:     	jmpq	*0x2f65(%rip)           # 0x18000d198
18000a233:     	int3
18000a234:     	int3
18000a235:     	int3
18000a236:     	int3
18000a237:     	int3
18000a238:     	int3
18000a239:     	int3
18000a23a:     	int3
18000a23b:     	int3
18000a23c:     	int3
18000a23d:     	int3
18000a23e:     	int3
18000a23f:     	int3
18000a240:     	movq	%rbx, 0x8(%rsp)
18000a245:     	movq	%rsi, 0x10(%rsp)
18000a24a:     	pushq	%rdi
18000a24b:     	subq	$0x20, %rsp
18000a24f:     	movq	%rcx, %rbx
18000a252:     	movq	%r8, %rdi
18000a255:     	movq	0x10(%rcx), %rcx
18000a259:     	movq	%rdx, %rsi
18000a25c:     	testq	%rcx, %rcx
18000a25f:     	je	0x18000a26a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x66aa>
18000a261:     	movq	%r8, %rdx
18000a264:     	callq	*%rsi
18000a266:     	testl	%eax, %eax
18000a268:     	jne	0x18000a28d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x66cd>
18000a26a:     	movq	0x18(%rbx), %rcx
18000a26e:     	testq	%rcx, %rcx
18000a271:     	je	0x18000a28b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x66cb>
18000a273:     	movq	%rdi, %rdx
18000a276:     	movq	%rsi, %rax
18000a279:     	movq	0x30(%rsp), %rbx
18000a27e:     	movq	0x38(%rsp), %rsi
18000a283:     	addq	$0x20, %rsp
18000a287:     	popq	%rdi
18000a288:     	jmpq	*%rax
18000a28b:     	xorl	%eax, %eax
18000a28d:     	movq	0x30(%rsp), %rbx
18000a292:     	movq	0x38(%rsp), %rsi
18000a297:     	addq	$0x20, %rsp
18000a29b:     	popq	%rdi
18000a29c:     	retq
18000a29d:     	int3
18000a29e:     	int3
18000a29f:     	int3
18000a2a0:     	pushq	%rbx
18000a2a2:     	subq	$0x20, %rsp
18000a2a6:     	movq	%rcx, %rbx
18000a2a9:     	movq	0x10(%rcx), %rcx
18000a2ad:     	testq	%rcx, %rcx
18000a2b0:     	je	0x18000a2cd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x670d>
18000a2b2:     	movq	$0x0, 0x10(%rbx)
18000a2ba:     	movl	(%rcx), %eax
18000a2bc:     	testl	%eax, %eax
18000a2be:     	js	0x18000a2cd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x670d>
18000a2c0:     	subl	$0x1, %eax
18000a2c3:     	movl	%eax, (%rcx)
18000a2c5:     	jne	0x18000a2cd <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x670d>
18000a2c7:     	callq	*0x2efb(%rip)           # 0x18000d1c8
18000a2cd:     	movq	0x18(%rbx), %rcx
18000a2d1:     	testq	%rcx, %rcx
18000a2d4:     	je	0x18000a2f1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6731>
18000a2d6:     	movq	$0x0, 0x18(%rbx)
18000a2de:     	movl	(%rcx), %eax
18000a2e0:     	testl	%eax, %eax
18000a2e2:     	js	0x18000a2f1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6731>
18000a2e4:     	subl	$0x1, %eax
18000a2e7:     	movl	%eax, (%rcx)
18000a2e9:     	jne	0x18000a2f1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6731>
18000a2eb:     	callq	*0x2ed7(%rip)           # 0x18000d1c8
18000a2f1:     	xorl	%eax, %eax
18000a2f3:     	addq	$0x20, %rsp
18000a2f7:     	popq	%rbx
18000a2f8:     	retq
18000a2f9:     	int3
18000a2fa:     	int3
18000a2fb:     	int3
18000a2fc:     	int3
18000a2fd:     	int3
18000a2fe:     	int3
18000a2ff:     	int3
18000a300:     	pushq	%rbx
18000a302:     	subq	$0x20, %rsp
18000a306:     	movq	%rcx, %rbx
18000a309:     	callq	*0x2f09(%rip)           # 0x18000d218
18000a30f:     	movq	0x10(%rbx), %rcx
18000a313:     	testq	%rcx, %rcx
18000a316:     	je	0x18000a333 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6773>
18000a318:     	movq	$0x0, 0x10(%rbx)
18000a320:     	movl	(%rcx), %eax
18000a322:     	testl	%eax, %eax
18000a324:     	js	0x18000a333 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6773>
18000a326:     	subl	$0x1, %eax
18000a329:     	movl	%eax, (%rcx)
18000a32b:     	jne	0x18000a333 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6773>
18000a32d:     	callq	*0x2e95(%rip)           # 0x18000d1c8
18000a333:     	movq	0x18(%rbx), %rcx
18000a337:     	testq	%rcx, %rcx
18000a33a:     	je	0x18000a357 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6797>
18000a33c:     	movq	$0x0, 0x18(%rbx)
18000a344:     	movl	(%rcx), %eax
18000a346:     	testl	%eax, %eax
18000a348:     	js	0x18000a357 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6797>
18000a34a:     	subl	$0x1, %eax
18000a34d:     	movl	%eax, (%rcx)
18000a34f:     	jne	0x18000a357 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6797>
18000a351:     	callq	*0x2e71(%rip)           # 0x18000d1c8
18000a357:     	movq	0x8(%rbx), %rax
18000a35b:     	movq	%rbx, %rcx
18000a35e:     	addq	$0x20, %rsp
18000a362:     	popq	%rbx
18000a363:     	jmpq	*0x140(%rax)
18000a36a:     	int3
18000a36b:     	int3
18000a36c:     	int3
18000a36d:     	int3
18000a36e:     	int3
18000a36f:     	int3
18000a370:     	pushq	%rbx
18000a372:     	subq	$0x30, %rsp
18000a376:     	movq	%r8, %r10
18000a379:     	leaq	0x58(%rsp), %rax
18000a37e:     	movq	%rax, 0x28(%rsp)
18000a383:     	leaq	0xa646(%rip), %r9       # 0x1800149d0
18000a38a:     	movq	0x2e57(%rip), %rax      # 0x18000d1e8
18000a391:     	leaq	0x3b48(%rip), %r8       # 0x18000dee0
18000a398:     	movq	%rdx, %r11
18000a39b:     	movq	%rax, 0x20(%rsp)
18000a3a0:     	movq	%rcx, %rbx
18000a3a3:     	movq	%r10, %rdx
18000a3a6:     	movq	%r11, %rcx
18000a3a9:     	callq	*0x2d49(%rip)           # 0x18000d0f8
18000a3af:     	testl	%eax, %eax
18000a3b1:     	je	0x18000a40c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x684c>
18000a3b3:     	xorl	%r8d, %r8d
18000a3b6:     	xorl	%edx, %edx
18000a3b8:     	movq	%rbx, %rcx
18000a3bb:     	callq	*0x2e87(%rip)           # 0x18000d248
18000a3c1:     	movq	%rax, %rbx
18000a3c4:     	testq	%rax, %rax
18000a3c7:     	je	0x18000a40c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x684c>
18000a3c9:     	movq	0x58(%rsp), %rax
18000a3ce:     	movl	(%rax), %ecx
18000a3d0:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000a3d6:     	jae	0x18000a3e1 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6821>
18000a3d8:     	incl	%ecx
18000a3da:     	movl	%ecx, (%rax)
18000a3dc:     	movq	0x58(%rsp), %rax
18000a3e1:     	xorl	%ecx, %ecx
18000a3e3:     	movq	%rax, 0x10(%rbx)
18000a3e7:     	callq	*0x2d8b(%rip)           # 0x18000d178
18000a3ed:     	movq	%rax, 0x18(%rbx)
18000a3f1:     	testq	%rax, %rax
18000a3f4:     	jne	0x18000a414 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6854>
18000a3f6:     	movl	(%rbx), %eax
18000a3f8:     	testl	%eax, %eax
18000a3fa:     	js	0x18000a40c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x684c>
18000a3fc:     	subl	$0x1, %eax
18000a3ff:     	movl	%eax, (%rbx)
18000a401:     	jne	0x18000a40c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x684c>
18000a403:     	movq	%rbx, %rcx
18000a406:     	callq	*0x2dbc(%rip)           # 0x18000d1c8
18000a40c:     	xorl	%eax, %eax
18000a40e:     	addq	$0x30, %rsp
18000a412:     	popq	%rbx
18000a413:     	retq
18000a414:     	movq	%rbx, %rax
18000a417:     	addq	$0x30, %rsp
18000a41b:     	popq	%rbx
18000a41c:     	retq
18000a41d:     	int3
18000a41e:     	int3
18000a41f:     	int3
18000a420:     	movq	%rbx, 0x8(%rsp)
18000a425:     	movq	%rsi, 0x10(%rsp)
18000a42a:     	pushq	%rdi
18000a42b:     	subq	$0x20, %rsp
18000a42f:     	movq	%rcx, %rbx
18000a432:     	movq	%r8, %rdi
18000a435:     	movq	0x18(%rcx), %rcx
18000a439:     	movq	%rdx, %rsi
18000a43c:     	testq	%rcx, %rcx
18000a43f:     	je	0x18000a44a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x688a>
18000a441:     	movq	%r8, %rdx
18000a444:     	callq	*%rsi
18000a446:     	testl	%eax, %eax
18000a448:     	jne	0x18000a46d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x68ad>
18000a44a:     	movq	0x40(%rbx), %rcx
18000a44e:     	testq	%rcx, %rcx
18000a451:     	je	0x18000a46b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x68ab>
18000a453:     	movq	%rdi, %rdx
18000a456:     	movq	%rsi, %rax
18000a459:     	movq	0x30(%rsp), %rbx
18000a45e:     	movq	0x38(%rsp), %rsi
18000a463:     	addq	$0x20, %rsp
18000a467:     	popq	%rdi
18000a468:     	jmpq	*%rax
18000a46b:     	xorl	%eax, %eax
18000a46d:     	movq	0x30(%rsp), %rbx
18000a472:     	movq	0x38(%rsp), %rsi
18000a477:     	addq	$0x20, %rsp
18000a47b:     	popq	%rdi
18000a47c:     	retq
18000a47d:     	int3
18000a47e:     	int3
18000a47f:     	int3
18000a480:     	pushq	%rbx
18000a482:     	subq	$0x20, %rsp
18000a486:     	movq	%rcx, %rbx
18000a489:     	callq	*0x2d89(%rip)           # 0x18000d218
18000a48f:     	cmpq	$0x0, 0x48(%rbx)
18000a494:     	je	0x18000a49f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x68df>
18000a496:     	movq	%rbx, %rcx
18000a499:     	callq	*0x2ce9(%rip)           # 0x18000d188
18000a49f:     	movq	0x20(%rbx), %rcx
18000a4a3:     	callq	*0x2d0f(%rip)           # 0x18000d1b8
18000a4a9:     	movq	0x38(%rbx), %rcx
18000a4ad:     	callq	*0x2d05(%rip)           # 0x18000d1b8
18000a4b3:     	movq	0x18(%rbx), %rcx
18000a4b7:     	testq	%rcx, %rcx
18000a4ba:     	je	0x18000a4cf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x690f>
18000a4bc:     	movl	(%rcx), %eax
18000a4be:     	testl	%eax, %eax
18000a4c0:     	js	0x18000a4cf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x690f>
18000a4c2:     	subl	$0x1, %eax
18000a4c5:     	movl	%eax, (%rcx)
18000a4c7:     	jne	0x18000a4cf <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x690f>
18000a4c9:     	callq	*0x2cf9(%rip)           # 0x18000d1c8
18000a4cf:     	movq	0x40(%rbx), %rcx
18000a4d3:     	testq	%rcx, %rcx
18000a4d6:     	je	0x18000a4eb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x692b>
18000a4d8:     	movl	(%rcx), %eax
18000a4da:     	testl	%eax, %eax
18000a4dc:     	js	0x18000a4eb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x692b>
18000a4de:     	subl	$0x1, %eax
18000a4e1:     	movl	%eax, (%rcx)
18000a4e3:     	jne	0x18000a4eb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x692b>
18000a4e5:     	callq	*0x2cdd(%rip)           # 0x18000d1c8
18000a4eb:     	movq	0x8(%rbx), %rax
18000a4ef:     	movq	%rbx, %rcx
18000a4f2:     	addq	$0x20, %rsp
18000a4f6:     	popq	%rbx
18000a4f7:     	jmpq	*0x140(%rax)
18000a4fe:     	int3
18000a4ff:     	int3
18000a500:     	pushq	%rbx
18000a502:     	subq	$0x20, %rsp
18000a506:     	callq	*0x2c74(%rip)           # 0x18000d180
18000a50c:     	movq	%rax, %rbx
18000a50f:     	testq	%rax, %rax
18000a512:     	jne	0x18000a51a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x695a>
18000a514:     	addq	$0x20, %rsp
18000a518:     	popq	%rbx
18000a519:     	retq
18000a51a:     	movq	%rbx, %rcx
18000a51d:     	movq	%rdi, 0x30(%rsp)
18000a522:     	callq	0x18000c885 <numba_list_iter_next+0xed5>
18000a527:     	leaq	0x1(%rax), %rcx
18000a52b:     	callq	*0x2d1f(%rip)           # 0x18000d250
18000a531:     	movq	%rax, %rdi
18000a534:     	testq	%rax, %rax
18000a537:     	jne	0x18000a54c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x698c>
18000a539:     	callq	*0x2c01(%rip)           # 0x18000d140
18000a53f:     	movq	0x30(%rsp), %rdi
18000a544:     	xorl	%eax, %eax
18000a546:     	addq	$0x20, %rsp
18000a54a:     	popq	%rbx
18000a54b:     	retq
18000a54c:     	movq	%rbx, %rdx
18000a54f:     	movq	%rdi, %rcx
18000a552:     	callq	0x18000c87f <numba_list_iter_next+0xecf>
18000a557:     	movq	%rdi, %rax
18000a55a:     	movq	0x30(%rsp), %rdi
18000a55f:     	addq	$0x20, %rsp
18000a563:     	popq	%rbx
18000a564:     	retq
18000a565:     	int3
18000a566:     	int3
18000a567:     	int3
18000a568:     	int3
18000a569:     	int3
18000a56a:     	int3
18000a56b:     	int3
18000a56c:     	int3
18000a56d:     	int3
18000a56e:     	int3
18000a56f:     	int3
18000a570:     	movq	0x18(%rcx), %rcx
18000a574:     	movq	%rdx, %rax
18000a577:     	testq	%rcx, %rcx
18000a57a:     	je	0x18000a582 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x69c2>
18000a57c:     	movq	%r8, %rdx
18000a57f:     	jmpq	*%rax
18000a582:     	xorl	%eax, %eax
18000a584:     	retq
18000a585:     	int3
18000a586:     	int3
18000a587:     	int3
18000a588:     	int3
18000a589:     	int3
18000a58a:     	int3
18000a58b:     	int3
18000a58c:     	int3
18000a58d:     	int3
18000a58e:     	int3
18000a58f:     	int3
18000a590:     	movq	%rbx, 0x8(%rsp)
18000a595:     	pushq	%rdi
18000a596:     	subq	$0x20, %rsp
18000a59a:     	movq	0x28(%rcx), %rax
18000a59e:     	xorl	%edi, %edi
18000a5a0:     	movq	%rcx, %rbx
18000a5a3:     	testq	%rax, %rax
18000a5a6:     	je	0x18000a5b2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x69f2>
18000a5a8:     	addq	$0x38, %rcx
18000a5ac:     	callq	*%rax
18000a5ae:     	movq	%rdi, 0x28(%rbx)
18000a5b2:     	movq	0x18(%rbx), %rcx
18000a5b6:     	testq	%rcx, %rcx
18000a5b9:     	je	0x18000a5d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a12>
18000a5bb:     	movq	%rdi, 0x18(%rbx)
18000a5bf:     	movl	(%rcx), %eax
18000a5c1:     	testl	%eax, %eax
18000a5c3:     	js	0x18000a5d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a12>
18000a5c5:     	subl	$0x1, %eax
18000a5c8:     	movl	%eax, (%rcx)
18000a5ca:     	jne	0x18000a5d2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a12>
18000a5cc:     	callq	*0x2bf6(%rip)           # 0x18000d1c8
18000a5d2:     	movq	%rdi, 0x20(%rbx)
18000a5d6:     	xorl	%eax, %eax
18000a5d8:     	movq	0x30(%rsp), %rbx
18000a5dd:     	addq	$0x20, %rsp
18000a5e1:     	popq	%rdi
18000a5e2:     	retq
18000a5e3:     	int3
18000a5e4:     	int3
18000a5e5:     	int3
18000a5e6:     	int3
18000a5e7:     	int3
18000a5e8:     	int3
18000a5e9:     	int3
18000a5ea:     	int3
18000a5eb:     	int3
18000a5ec:     	int3
18000a5ed:     	int3
18000a5ee:     	int3
18000a5ef:     	int3
18000a5f0:     	pushq	%rbx
18000a5f2:     	subq	$0x20, %rsp
18000a5f6:     	movq	%rcx, %rbx
18000a5f9:     	callq	*0x2c19(%rip)           # 0x18000d218
18000a5ff:     	cmpq	$0x0, 0x30(%rbx)
18000a604:     	je	0x18000a60f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a4f>
18000a606:     	movq	%rbx, %rcx
18000a609:     	callq	*0x2b79(%rip)           # 0x18000d188
18000a60f:     	callq	*0x2af3(%rip)           # 0x18000d108
18000a615:     	testl	%eax, %eax
18000a617:     	jne	0x18000a628 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a68>
18000a619:     	movq	0x28(%rbx), %rax
18000a61d:     	testq	%rax, %rax
18000a620:     	je	0x18000a628 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a68>
18000a622:     	leaq	0x38(%rbx), %rcx
18000a626:     	callq	*%rax
18000a628:     	movq	0x18(%rbx), %rcx
18000a62c:     	testq	%rcx, %rcx
18000a62f:     	je	0x18000a644 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a84>
18000a631:     	movl	(%rcx), %eax
18000a633:     	testl	%eax, %eax
18000a635:     	js	0x18000a644 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a84>
18000a637:     	subl	$0x1, %eax
18000a63a:     	movl	%eax, (%rcx)
18000a63c:     	jne	0x18000a644 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6a84>
18000a63e:     	callq	*0x2b84(%rip)           # 0x18000d1c8
18000a644:     	movq	0x8(%rbx), %rax
18000a648:     	movq	%rbx, %rcx
18000a64b:     	addq	$0x20, %rsp
18000a64f:     	popq	%rbx
18000a650:     	jmpq	*0x140(%rax)
18000a657:     	int3
18000a658:     	int3
18000a659:     	int3
18000a65a:     	int3
18000a65b:     	int3
18000a65c:     	int3
18000a65d:     	int3
18000a65e:     	int3
18000a65f:     	int3
18000a660:     	pushq	%rdi
18000a662:     	subq	$0x20, %rsp
18000a666:     	cmpq	$0x0, 0x20(%rcx)
18000a66b:     	movq	%rcx, %rdi
18000a66e:     	jne	0x18000a68f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6acf>
18000a670:     	movq	0x2c39(%rip), %rcx      # 0x18000d2b0
18000a677:     	leaq	0x38b2(%rip), %rdx      # 0x18000df30
18000a67e:     	movq	(%rcx), %rcx
18000a681:     	callq	*0x2c21(%rip)           # 0x18000d2a8
18000a687:     	xorl	%eax, %eax
18000a689:     	addq	$0x20, %rsp
18000a68d:     	popq	%rdi
18000a68e:     	retq
18000a68f:     	movq	%rdi, %rdx
18000a692:     	movq	%rbx, 0x30(%rsp)
18000a697:     	movl	$0x1, %ecx
18000a69c:     	callq	*0x2c66(%rip)           # 0x18000d308
18000a6a2:     	movq	%rax, %rbx
18000a6a5:     	testq	%rax, %rax
18000a6a8:     	jne	0x18000a6b5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6af5>
18000a6aa:     	movq	0x30(%rsp), %rbx
18000a6af:     	addq	$0x20, %rsp
18000a6b3:     	popq	%rdi
18000a6b4:     	retq
18000a6b5:     	xorl	%r8d, %r8d
18000a6b8:     	movq	%rbx, %rdx
18000a6bb:     	movq	%rdi, %rcx
18000a6be:     	callq	*0x20(%rdi)
18000a6c1:     	movl	(%rbx), %ecx
18000a6c3:     	movq	%rax, %rdi
18000a6c6:     	testl	%ecx, %ecx
18000a6c8:     	js	0x18000a6da <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b1a>
18000a6ca:     	subl	$0x1, %ecx
18000a6cd:     	movl	%ecx, (%rbx)
18000a6cf:     	jne	0x18000a6da <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b1a>
18000a6d1:     	movq	%rbx, %rcx
18000a6d4:     	callq	*0x2aee(%rip)           # 0x18000d1c8
18000a6da:     	movq	0x30(%rsp), %rbx
18000a6df:     	movq	%rdi, %rax
18000a6e2:     	addq	$0x20, %rsp
18000a6e6:     	popq	%rdi
18000a6e7:     	retq
18000a6e8:     	int3
18000a6e9:     	int3
18000a6ea:     	int3
18000a6eb:     	int3
18000a6ec:     	int3
18000a6ed:     	int3
18000a6ee:     	int3
18000a6ef:     	int3
18000a6f0:     	movq	%rbx, 0x8(%rsp)
18000a6f5:     	pushq	%rdi
18000a6f6:     	subq	$0x20, %rsp
18000a6fa:     	movq	%r8, %rbx
18000a6fd:     	callq	*0x29ed(%rip)           # 0x18000d0f0
18000a703:     	movl	(%rbx), %ecx
18000a705:     	movl	%eax, %edi
18000a707:     	testl	%ecx, %ecx
18000a709:     	js	0x18000a71b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b5b>
18000a70b:     	subl	$0x1, %ecx
18000a70e:     	movl	%ecx, (%rbx)
18000a710:     	jne	0x18000a71b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b5b>
18000a712:     	movq	%rbx, %rcx
18000a715:     	callq	*0x2aad(%rip)           # 0x18000d1c8
18000a71b:     	movl	%edi, %ecx
18000a71d:     	movq	0x30(%rsp), %rbx
18000a722:     	addq	$0x20, %rsp
18000a726:     	popq	%rdi
18000a727:     	jmpq	*0x2ae2(%rip)           # 0x18000d210
18000a72e:     	int3
18000a72f:     	int3
18000a730:     	movq	%rbx, 0x8(%rsp)
18000a735:     	pushq	%rdi
18000a736:     	subq	$0x20, %rsp
18000a73a:     	movl	(%rdx), %eax
18000a73c:     	movq	%rdx, %rbx
18000a73f:     	movq	%rcx, %rdi
18000a742:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a747:     	jae	0x18000a74d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b8d>
18000a749:     	incl	%eax
18000a74b:     	movl	%eax, (%rdx)
18000a74d:     	movl	$0x30, %ecx
18000a752:     	callq	*0xa510(%rip)           # 0x180014c68
18000a758:     	cmpb	$0x0, 0xa4e1(%rip)      # 0x180014c40
18000a75f:     	je	0x18000a769 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6ba9>
18000a761:     	lock
18000a762:     	incq	0xa4df(%rip)            # 0x180014c48
18000a769:     	testq	%rax, %rax
18000a76c:     	je	0x18000a7a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6be3>
18000a76e:     	movl	$0x1, %ecx
18000a773:     	leaq	-0x8a(%rip), %rdx       # 0x18000a6f0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b30>
18000a77a:     	xchgq	%rcx, (%rax)
18000a77d:     	xorl	%ecx, %ecx
18000a77f:     	movq	%rdx, 0x8(%rax)
18000a783:     	movq	%rcx, 0x20(%rax)
18000a787:     	movq	%rcx, 0x28(%rax)
18000a78b:     	movq	%rbx, 0x10(%rax)
18000a78f:     	movq	%rdi, 0x18(%rax)
18000a793:     	cmpb	%cl, 0xa4a7(%rip)       # 0x180014c40
18000a799:     	je	0x18000a7a3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6be3>
18000a79b:     	lock
18000a79c:     	incq	0xa4b5(%rip)            # 0x180014c58
18000a7a3:     	movq	0x30(%rsp), %rbx
18000a7a8:     	addq	$0x20, %rsp
18000a7ac:     	popq	%rdi
18000a7ad:     	retq
18000a7ae:     	int3
18000a7af:     	int3
18000a7b0:     	movq	%rbx, 0x8(%rsp)
18000a7b5:     	pushq	%rdi
18000a7b6:     	subq	$0x30, %rsp
18000a7ba:     	movq	%rcx, %rdi
18000a7bd:     	leaq	0xa1fc(%rip), %r9       # 0x1800149c0
18000a7c4:     	movq	%r8, %rax
18000a7c7:     	leaq	0x58(%rsp), %rcx
18000a7cc:     	movq	%rdx, %r10
18000a7cf:     	movq	%rcx, 0x20(%rsp)
18000a7d4:     	movq	%r10, %rcx
18000a7d7:     	leaq	0x379a(%rip), %r8       # 0x18000df78
18000a7de:     	movq	%rax, %rdx
18000a7e1:     	callq	*0x2911(%rip)           # 0x18000d0f8
18000a7e7:     	testl	%eax, %eax
18000a7e9:     	je	0x18000a813 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6c53>
18000a7eb:     	movq	0x58(%rsp), %rcx
18000a7f0:     	callq	*0x28ea(%rip)           # 0x18000d0e0
18000a7f6:     	movq	%rax, %rbx
18000a7f9:     	callq	*0x2ae9(%rip)           # 0x18000d2e8
18000a7ff:     	testq	%rax, %rax
18000a802:     	jne	0x18000a813 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6c53>
18000a804:     	movq	%rbx, 0x10(%rdi)
18000a808:     	movq	0x40(%rsp), %rbx
18000a80d:     	addq	$0x30, %rsp
18000a811:     	popq	%rdi
18000a812:     	retq
18000a813:     	movq	0x40(%rsp), %rbx
18000a818:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a81d:     	addq	$0x30, %rsp
18000a821:     	popq	%rdi
18000a822:     	retq
18000a823:     	int3
18000a824:     	int3
18000a825:     	int3
18000a826:     	int3
18000a827:     	int3
18000a828:     	int3
18000a829:     	int3
18000a82a:     	int3
18000a82b:     	int3
18000a82c:     	int3
18000a82d:     	int3
18000a82e:     	int3
18000a82f:     	int3
18000a830:     	subq	$0x38, %rsp
18000a834:     	movl	%r8d, %eax
18000a837:     	movq	%rdx, %r10
18000a83a:     	movq	0x10(%rcx), %r8
18000a83e:     	movq	%rcx, %rdx
18000a841:     	movl	%eax, 0x28(%rsp)
18000a845:     	movq	%r10, %rcx
18000a848:     	movl	$0x0, 0x20(%rsp)
18000a850:     	movq	0x20(%r8), %r9
18000a854:     	movq	0x18(%r8), %r8
18000a858:     	callq	*0x29aa(%rip)           # 0x18000d208
18000a85e:     	addq	$0x38, %rsp
18000a862:     	retq
18000a863:     	int3
18000a864:     	int3
18000a865:     	int3
18000a866:     	int3
18000a867:     	int3
18000a868:     	int3
18000a869:     	int3
18000a86a:     	int3
18000a86b:     	int3
18000a86c:     	int3
18000a86d:     	int3
18000a86e:     	int3
18000a86f:     	int3
18000a870:     	movq	0x10(%rcx), %rax
18000a874:     	lock
18000a875:     	incq	(%rax)
18000a878:     	movq	0x2a51(%rip), %rax      # 0x18000d2d0
18000a87f:     	retq
18000a880:     	subq	$0x28, %rsp
18000a884:     	movq	0x10(%rcx), %rcx
18000a888:     	callq	0x18000bb80 <numba_list_iter_next+0x1d0>
18000a88d:     	movq	0x2a3c(%rip), %rax      # 0x18000d2d0
18000a894:     	addq	$0x28, %rsp
18000a898:     	retq
18000a899:     	int3
18000a89a:     	int3
18000a89b:     	int3
18000a89c:     	int3
18000a89d:     	int3
18000a89e:     	int3
18000a89f:     	int3
18000a8a0:     	movq	0x10(%rcx), %rcx
18000a8a4:     	movq	0x18(%rcx), %rcx
18000a8a8:     	jmpq	*0x28a9(%rip)           # 0x18000d158
18000a8af:     	int3
18000a8b0:     	subq	$0x28, %rsp
18000a8b4:     	movq	0x10(%rcx), %rax
18000a8b8:     	testq	%rax, %rax
18000a8bb:     	je	0x18000a8d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d19>
18000a8bd:     	cmpq	$0x0, 0x18(%rax)
18000a8c2:     	je	0x18000a8d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d19>
18000a8c4:     	movq	(%rax), %rcx
18000a8c7:     	nop
18000a8c8:     	cmpq	$-0x1, %rcx
18000a8cc:     	je	0x18000a8d9 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d19>
18000a8ce:     	addq	$0x28, %rsp
18000a8d2:     	jmpq	*0x284f(%rip)           # 0x18000d128
18000a8d9:     	movq	0x2918(%rip), %rcx      # 0x18000d1f8
18000a8e0:     	leaq	0x3699(%rip), %rdx      # 0x18000df80
18000a8e7:     	movq	(%rcx), %rcx
18000a8ea:     	callq	*0x29b8(%rip)           # 0x18000d2a8
18000a8f0:     	xorl	%eax, %eax
18000a8f2:     	addq	$0x28, %rsp
18000a8f6:     	retq
18000a8f7:     	int3
18000a8f8:     	int3
18000a8f9:     	int3
18000a8fa:     	int3
18000a8fb:     	int3
18000a8fc:     	int3
18000a8fd:     	int3
18000a8fe:     	int3
18000a8ff:     	int3
18000a900:     	movq	0x10(%rcx), %rcx
18000a904:     	movq	0x28(%rcx), %rcx
18000a908:     	jmpq	*0x2849(%rip)           # 0x18000d158
18000a90f:     	int3
18000a910:     	movq	0x10(%rcx), %rax
18000a914:     	movq	0x10(%rax), %rax
18000a918:     	testq	%rax, %rax
18000a91b:     	je	0x18000a92c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d6c>
18000a91d:     	movl	(%rax), %ecx
18000a91f:     	cmpl	$0xc0000000, %ecx       # imm = 0xC0000000
18000a925:     	jae	0x18000a94a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d8a>
18000a927:     	incl	%ecx
18000a929:     	movl	%ecx, (%rax)
18000a92b:     	retq
18000a92c:     	movq	0x299d(%rip), %rcx      # 0x18000d2d0
18000a933:     	movl	(%rcx), %eax
18000a935:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000a93a:     	jae	0x18000a947 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6d87>
18000a93c:     	incl	%eax
18000a93e:     	movl	%eax, (%rcx)
18000a940:     	movq	0x2989(%rip), %rcx      # 0x18000d2d0
18000a947:     	movq	%rcx, %rax
18000a94a:     	retq
18000a94b:     	int3
18000a94c:     	int3
18000a94d:     	int3
18000a94e:     	int3
18000a94f:     	int3
18000a950:     	pushq	%rbx
18000a952:     	subq	$0x20, %rsp
18000a956:     	movq	%rcx, %rbx
18000a959:     	movq	0x10(%rcx), %rcx
18000a95d:     	callq	0x18000bb80 <numba_list_iter_next+0x1d0>
18000a962:     	movq	0x8(%rbx), %rax
18000a966:     	movq	%rbx, %rcx
18000a969:     	addq	$0x20, %rsp
18000a96d:     	popq	%rbx
18000a96e:     	jmpq	*0x140(%rax)
18000a975:     	int3
18000a976:     	int3
18000a977:     	int3
18000a978:     	int3
18000a979:     	int3
18000a97a:     	int3
18000a97b:     	int3
18000a97c:     	int3
18000a97d:     	int3
18000a97e:     	int3
18000a97f:     	int3
18000a980:     	movq	%rdi, 0x18(%rsp)
18000a985:     	pushq	%r14
18000a987:     	subq	$0x20, %rsp
18000a98b:     	movq	0xa2ee(%rip), %rax      # 0x180014c80
18000a992:     	movq	%rdx, %r14
18000a995:     	movq	%rcx, %rdi
18000a998:     	movq	0x8(%rcx), %rcx
18000a99c:     	movq	0x10(%rax), %rdx
18000a9a0:     	cmpq	%rdx, %rcx
18000a9a3:     	je	0x18000a9c0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e00>
18000a9a5:     	callq	*0x282d(%rip)           # 0x18000d1d8
18000a9ab:     	testl	%eax, %eax
18000a9ad:     	jne	0x18000a9c0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e00>
18000a9af:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000a9b4:     	movq	0x40(%rsp), %rdi
18000a9b9:     	addq	$0x20, %rsp
18000a9bd:     	popq	%r14
18000a9bf:     	retq
18000a9c0:     	movq	%rbx, 0x30(%rsp)
18000a9c5:     	movq	%rdi, %rdx
18000a9c8:     	movq	0x10(%rdi), %rbx
18000a9cc:     	movq	%rbx, %rcx
18000a9cf:     	movq	%rsi, 0x38(%rsp)
18000a9d4:     	movl	0x18(%rdi), %esi
18000a9d7:     	callq	0x18000a730 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6b70>
18000a9dc:     	movq	%rax, (%r14)
18000a9df:     	movq	0xa29a(%rip), %rax      # 0x180014c80
18000a9e6:     	movq	%rbx, 0x20(%r14)
18000a9ea:     	movl	0x18(%rdi), %edx
18000a9ed:     	movq	0x20(%rdi), %rcx
18000a9f1:     	callq	*0x4f0(%rax)
18000a9f7:     	cmpl	$0x12, 0xa28e(%rip)     # 0x180014c8c
18000a9fe:     	movq	0x30(%rsp), %rbx
18000aa03:     	movq	%rax, 0x10(%r14)
18000aa07:     	movq	0x38(%rdi), %rax
18000aa0b:     	jl	0x18000aa13 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e53>
18000aa0d:     	movq	0x28(%rax), %rax
18000aa11:     	jmp	0x18000aa17 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e57>
18000aa13:     	movslq	0x20(%rax), %rax
18000aa17:     	xorl	%r8d, %r8d
18000aa1a:     	movq	%rax, 0x18(%r14)
18000aa1e:     	movq	%rdi, 0x8(%r14)
18000aa22:     	leaq	0x28(%r14), %rax
18000aa26:     	testl	%esi, %esi
18000aa28:     	jle	0x18000aa6b <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6eab>
18000aa2a:     	nopw	(%rax,%rax)
18000aa30:     	movq	0x20(%rdi), %rcx
18000aa34:     	movq	(%rcx,%r8,8), %rdx
18000aa38:     	incl	%r8d
18000aa3b:     	movq	%rdx, (%rax)
18000aa3e:     	addq	$0x8, %rax
18000aa42:     	cmpl	%esi, %r8d
18000aa45:     	jl	0x18000aa30 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e70>
18000aa47:     	xorl	%r8d, %r8d
18000aa4a:     	nopw	(%rax,%rax)
18000aa50:     	movq	0x28(%rdi), %rcx
18000aa54:     	leaq	0x8(%rax), %rax
18000aa58:     	movslq	%r8d, %rdx
18000aa5b:     	incl	%r8d
18000aa5e:     	movq	(%rcx,%rdx,8), %rdx
18000aa62:     	movq	%rdx, -0x8(%rax)
18000aa66:     	cmpl	%esi, %r8d
18000aa69:     	jl	0x18000aa50 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6e90>
18000aa6b:     	movq	0x38(%rsp), %rsi
18000aa70:     	xorl	%eax, %eax
18000aa72:     	movq	0x40(%rsp), %rdi
18000aa77:     	addq	$0x20, %rsp
18000aa7b:     	popq	%r14
18000aa7d:     	retq
18000aa7e:     	int3
18000aa7f:     	int3
18000aa80:     	pushq	%rbx
18000aa82:     	pushq	%rbp
18000aa83:     	pushq	%rsi
18000aa84:     	pushq	%rdi
18000aa85:     	subq	$0x28, %rsp
18000aa89:     	cmpq	$0x0, 0xa207(%rip)      # 0x180014c98
18000aa91:     	movq	%rcx, %rbp
18000aa94:     	movslq	0x8(%rdx), %rdi
18000aa98:     	movq	(%rdx), %rsi
18000aa9b:     	jne	0x18000aaf3 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6f33>
18000aa9d:     	leaq	0x33e4(%rip), %rcx      # 0x18000de88
18000aaa4:     	callq	*0x278e(%rip)           # 0x18000d238
18000aaaa:     	movq	%rax, %rbx
18000aaad:     	testq	%rax, %rax
18000aab0:     	je	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000aab6:     	leaq	0x33d3(%rip), %rdx      # 0x18000de90
18000aabd:     	movq	%rax, %rcx
18000aac0:     	callq	*0x26a2(%rip)           # 0x18000d168
18000aac6:     	movl	(%rbx), %edx
18000aac8:     	movq	%rax, 0xa1c9(%rip)      # 0x180014c98
18000aacf:     	testl	%edx, %edx
18000aad1:     	js	0x18000aaea <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6f2a>
18000aad3:     	subl	$0x1, %edx
18000aad6:     	movl	%edx, (%rbx)
18000aad8:     	jne	0x18000aaea <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6f2a>
18000aada:     	movq	%rbx, %rcx
18000aadd:     	callq	*0x26e5(%rip)           # 0x18000d1c8
18000aae3:     	movq	0xa1ae(%rip), %rax      # 0x180014c98
18000aaea:     	testq	%rax, %rax
18000aaed:     	je	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000aaf3:     	movq	%rdi, %rdx
18000aaf6:     	movq	%rsi, %rcx
18000aaf9:     	callq	*0x27b9(%rip)           # 0x18000d2b8
18000aaff:     	movq	%rax, %rdi
18000ab02:     	testq	%rax, %rax
18000ab05:     	je	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000ab07:     	movq	0xa18a(%rip), %rcx      # 0x180014c98
18000ab0e:     	xorl	%r8d, %r8d
18000ab11:     	movq	%rax, %rdx
18000ab14:     	callq	*0x267e(%rip)           # 0x18000d198
18000ab1a:     	movl	(%rdi), %ecx
18000ab1c:     	movq	%rax, %rbx
18000ab1f:     	testl	%ecx, %ecx
18000ab21:     	js	0x18000ab33 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6f73>
18000ab23:     	subl	$0x1, %ecx
18000ab26:     	movl	%ecx, (%rdi)
18000ab28:     	jne	0x18000ab33 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6f73>
18000ab2a:     	movq	%rdi, %rcx
18000ab2d:     	callq	*0x2695(%rip)           # 0x18000d1c8
18000ab33:     	testq	%rbx, %rbx
18000ab36:     	je	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000ab38:     	movq	0x8(%rbx), %r8
18000ab3c:     	testl	$0x2000000, 0xa8(%r8)   # imm = 0x2000000
18000ab47:     	jne	0x18000ab85 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fc5>
18000ab49:     	movq	0x2750(%rip), %rcx      # 0x18000d2a0
18000ab50:     	leaq	0x3531(%rip), %rdx      # 0x18000e088
18000ab57:     	movq	0x18(%r8), %r8
18000ab5b:     	movq	(%rcx), %rcx
18000ab5e:     	callq	*0x268c(%rip)           # 0x18000d1f0
18000ab64:     	movl	(%rbx), %eax
18000ab66:     	testl	%eax, %eax
18000ab68:     	js	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000ab6a:     	subl	$0x1, %eax
18000ab6d:     	movl	%eax, (%rbx)
18000ab6f:     	jne	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000ab71:     	movq	%rbx, %rcx
18000ab74:     	callq	*0x264e(%rip)           # 0x18000d1c8
18000ab7a:     	xorl	%eax, %eax
18000ab7c:     	addq	$0x28, %rsp
18000ab80:     	popq	%rdi
18000ab81:     	popq	%rsi
18000ab82:     	popq	%rbp
18000ab83:     	popq	%rbx
18000ab84:     	retq
18000ab85:     	xorl	%r8d, %r8d
18000ab88:     	leaq	0x97b1(%rip), %rcx      # 0x180014340
18000ab8f:     	xorl	%edx, %edx
18000ab91:     	callq	*0x26b1(%rip)           # 0x18000d248
18000ab97:     	movq	%rax, %rdi
18000ab9a:     	testq	%rax, %rax
18000ab9d:     	je	0x18000ab64 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fa4>
18000ab9f:     	movq	%rbp, %rcx
18000aba2:     	movq	%rbx, 0x18(%rax)
18000aba6:     	callq	*0x2614(%rip)           # 0x18000d1c0
18000abac:     	movq	%rax, 0x10(%rdi)
18000abb0:     	movq	%rax, %rcx
18000abb3:     	testq	%rax, %rax
18000abb6:     	jne	0x18000abca <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x700a>
18000abb8:     	movl	(%rdi), %eax
18000abba:     	testl	%eax, %eax
18000abbc:     	js	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000abbe:     	subl	$0x1, %eax
18000abc1:     	movl	%eax, (%rdi)
18000abc3:     	jne	0x18000ab7a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fba>
18000abc5:     	movq	%rdi, %rcx
18000abc8:     	jmp	0x18000ab74 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6fb4>
18000abca:     	movl	(%rax), %eax
18000abcc:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000abd1:     	jae	0x18000abd7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7017>
18000abd3:     	incl	%eax
18000abd5:     	movl	%eax, (%rcx)
18000abd7:     	movq	%rdi, %rax
18000abda:     	addq	$0x28, %rsp
18000abde:     	popq	%rdi
18000abdf:     	popq	%rsi
18000abe0:     	popq	%rbp
18000abe1:     	popq	%rbx
18000abe2:     	retq
18000abe3:     	int3
18000abe4:     	int3
18000abe5:     	int3
18000abe6:     	int3
18000abe7:     	int3
18000abe8:     	int3
18000abe9:     	int3
18000abea:     	int3
18000abeb:     	int3
18000abec:     	int3
18000abed:     	int3
18000abee:     	int3
18000abef:     	int3
18000abf0:     	movq	%r9, 0x20(%rsp)
18000abf5:     	movq	%r8, 0x18(%rsp)
18000abfa:     	movq	%rdx, 0x10(%rsp)
18000abff:     	movq	%rcx, 0x8(%rsp)
18000ac04:     	pushq	%rbx
18000ac05:     	pushq	%rbp
18000ac06:     	pushq	%rsi
18000ac07:     	pushq	%rdi
18000ac08:     	pushq	%r12
18000ac0a:     	pushq	%r13
18000ac0c:     	pushq	%r14
18000ac0e:     	pushq	%r15
18000ac10:     	subq	$0x68, %rsp
18000ac14:     	movq	%rcx, %r14
18000ac17:     	movq	%r9, %r15
18000ac1a:     	leaq	0x2f1f(%rip), %rcx      # 0x18000db40
18000ac21:     	movq	%r8, %r13
18000ac24:     	movq	%rdx, %rsi
18000ac27:     	callq	*0x260b(%rip)           # 0x18000d238
18000ac2d:     	movq	%rax, %rdi
18000ac30:     	testq	%rax, %rax
18000ac33:     	jne	0x18000ac6c <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x70ac>
18000ac35:     	movq	0x24fc(%rip), %rcx      # 0x18000d138
18000ac3c:     	movq	(%rcx), %rcx
18000ac3f:     	callq	*0x256b(%rip)           # 0x18000d1b0
18000ac45:     	testl	%eax, %eax
18000ac47:     	je	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000ac4d:     	callq	*0x266d(%rip)           # 0x18000d2c0
18000ac53:     	leaq	0x2f06(%rip), %rcx      # 0x18000db60
18000ac5a:     	callq	*0x25d8(%rip)           # 0x18000d238
18000ac60:     	movq	%rax, %rdi
18000ac63:     	testq	%rax, %rax
18000ac66:     	je	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000ac6c:     	leaq	0x2f0d(%rip), %rdx      # 0x18000db80
18000ac73:     	movq	%rdi, %rcx
18000ac76:     	callq	*0x24ec(%rip)           # 0x18000d168
18000ac7c:     	movl	(%rdi), %ecx
18000ac7e:     	movq	%rax, %rbx
18000ac81:     	testl	%ecx, %ecx
18000ac83:     	js	0x18000ac95 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x70d5>
18000ac85:     	subl	$0x1, %ecx
18000ac88:     	movl	%ecx, (%rdi)
18000ac8a:     	jne	0x18000ac95 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x70d5>
18000ac8c:     	movq	%rdi, %rcx
18000ac8f:     	callq	*0x2533(%rip)           # 0x18000d1c8
18000ac95:     	testq	%rbx, %rbx
18000ac98:     	je	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000ac9e:     	movq	0x245b(%rip), %rax      # 0x18000d100
18000aca5:     	cmpq	%rax, 0x8(%rbx)
18000aca9:     	je	0x18000ace5 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7125>
18000acab:     	movq	0x25fe(%rip), %rcx      # 0x18000d2b0
18000acb2:     	leaq	0x2ed7(%rip), %rdx      # 0x18000db90
18000acb9:     	movq	(%rcx), %rcx
18000acbc:     	callq	*0x25e6(%rip)           # 0x18000d2a8
18000acc2:     	movl	(%rbx), %eax
18000acc4:     	testl	%eax, %eax
18000acc6:     	js	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000accc:     	subl	$0x1, %eax
18000accf:     	movl	%eax, (%rbx)
18000acd1:     	jne	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000acd7:     	movq	%rbx, %rcx
18000acda:     	callq	*0x24e8(%rip)           # 0x18000d1c8
18000ace0:     	jmp	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000ace5:     	xorl	%edx, %edx
18000ace7:     	movq	%rbx, %rcx
18000acea:     	callq	*0x24b8(%rip)           # 0x18000d1a8
18000acf0:     	movl	(%rbx), %ecx
18000acf2:     	movq	%rax, 0x9f87(%rip)      # 0x180014c80
18000acf9:     	testl	%ecx, %ecx
18000acfb:     	js	0x18000ad14 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7154>
18000acfd:     	subl	$0x1, %ecx
18000ad00:     	movl	%ecx, (%rbx)
18000ad02:     	jne	0x18000ad14 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7154>
18000ad04:     	movq	%rbx, %rcx
18000ad07:     	callq	*0x24bb(%rip)           # 0x18000d1c8
18000ad0d:     	movq	0x9f6c(%rip), %rax      # 0x180014c80
18000ad14:     	testq	%rax, %rax
18000ad17:     	jne	0x18000ad32 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7172>
18000ad19:     	leaq	0x2e98(%rip), %rdx      # 0x18000dbb8
18000ad20:     	movq	0x2589(%rip), %rcx      # 0x18000d2b0
18000ad27:     	movq	(%rcx), %rcx
18000ad2a:     	callq	*0x2578(%rip)           # 0x18000d2a8
18000ad30:     	jmp	0x18000ad67 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a7>
18000ad32:     	callq	*(%rax)
18000ad34:     	cmpl	$0x2000000, %eax        # imm = 0x2000000
18000ad39:     	jbe	0x18000ad9a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71da>
18000ad3b:     	movq	0x256e(%rip), %rax      # 0x18000d2b0
18000ad42:     	movq	(%rax), %rbx
18000ad45:     	movq	0x9f34(%rip), %rax      # 0x180014c80
18000ad4c:     	callq	*(%rax)
18000ad4e:     	movl	$0x2000000, %r8d        # imm = 0x2000000
18000ad54:     	leaq	0x2e85(%rip), %rdx      # 0x18000dbe0
18000ad5b:     	movl	%eax, %r9d
18000ad5e:     	movq	%rbx, %rcx
18000ad61:     	callq	*0x2489(%rip)           # 0x18000d1f0
18000ad67:     	callq	*0x23ab(%rip)           # 0x18000d118
18000ad6d:     	movq	0x239c(%rip), %rcx      # 0x18000d110
18000ad74:     	leaq	0x308d(%rip), %rdx      # 0x18000de08
18000ad7b:     	movq	(%rcx), %rcx
18000ad7e:     	callq	*0x2524(%rip)           # 0x18000d2a8
18000ad84:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000ad89:     	addq	$0x68, %rsp
18000ad8d:     	popq	%r15
18000ad8f:     	popq	%r14
18000ad91:     	popq	%r13
18000ad93:     	popq	%r12
18000ad95:     	popq	%rdi
18000ad96:     	popq	%rsi
18000ad97:     	popq	%rbp
18000ad98:     	popq	%rbx
18000ad99:     	retq
18000ad9a:     	movq	0x9edf(%rip), %rax      # 0x180014c80
18000ada1:     	callq	*0x698(%rax)
18000ada7:     	movl	%eax, 0x9edf(%rip)      # 0x180014c8c
18000adad:     	cmpl	$0x10, %eax
18000adb0:     	jge	0x18000adce <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x720e>
18000adb2:     	movq	0x24f7(%rip), %rcx      # 0x18000d2b0
18000adb9:     	leaq	0x2e70(%rip), %rdx      # 0x18000dc30
18000adc0:     	movl	%eax, %r9d
18000adc3:     	movl	$0x10, %r8d
18000adc9:     	movq	(%rcx), %rcx
18000adcc:     	jmp	0x18000ad61 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71a1>
18000adce:     	movq	0x9eab(%rip), %rax      # 0x180014c80
18000add5:     	callq	*0x690(%rax)
18000addb:     	testl	%eax, %eax
18000addd:     	jne	0x18000adeb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x722b>
18000addf:     	leaq	0x2f9a(%rip), %rdx      # 0x18000dd80
18000ade6:     	jmp	0x18000ad20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7160>
18000adeb:     	cmpl	$0x1, %eax
18000adee:     	je	0x18000adfc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x723c>
18000adf0:     	leaq	0x2fb9(%rip), %rdx      # 0x18000ddb0
18000adf7:     	jmp	0x18000ad20 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7160>
18000adfc:     	leaq	0x9a1d(%rip), %rcx      # 0x180014820
18000ae03:     	callq	*0x2367(%rip)           # 0x18000d170
18000ae09:     	testl	%eax, %eax
18000ae0b:     	jne	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000ae11:     	leaq	0x9528(%rip), %rcx      # 0x180014340
18000ae18:     	callq	*0x2352(%rip)           # 0x18000d170
18000ae1e:     	testl	%eax, %eax
18000ae20:     	jne	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000ae26:     	leaq	0x9853(%rip), %rcx      # 0x180014680
18000ae2d:     	callq	*0x233d(%rip)           # 0x18000d170
18000ae33:     	testl	%eax, %eax
18000ae35:     	jne	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000ae3b:     	xorl	%ebx, %ebx
18000ae3d:     	cmpl	%ebx, 0x9e45(%rip)      # 0x180014c88
18000ae43:     	jne	0x18000ae86 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x72c6>
18000ae45:     	movq	%gs:0x58, %rax
18000ae4e:     	movl	0x9e4c(%rip), %ecx      # 0x180014ca0
18000ae54:     	movl	$0x1, 0x9e2a(%rip)      # 0x180014c88
18000ae5e:     	movq	(%rax,%rcx,8), %rdx
18000ae62:     	movl	$0x10, %eax
18000ae67:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000ae6e:     	movl	$0x9f0, %eax            # imm = 0x9F0
18000ae73:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000ae7a:     	movl	$0x13d0, %eax           # imm = 0x13D0
18000ae7f:     	movl	%ebx, 0x9d0(%rax,%rdx)
18000ae86:     	movl	%ebx, 0x9dac(%rip)      # 0x180014c38
18000ae8c:     	movq	%rbx, %rax
18000ae8f:     	movb	%bl, 0x9dab(%rip)       # 0x180014c40
18000ae95:     	movq	%rbx, %rcx
18000ae98:     	xchgq	%rax, 0x9da9(%rip)      # 0x180014c48
18000ae9f:     	xchgq	%rcx, 0x9daa(%rip)      # 0x180014c50
18000aea6:     	movq	%rbx, %rax
18000aea9:     	movq	%rbx, %rcx
18000aeac:     	xchgq	%rax, 0x9da5(%rip)      # 0x180014c58
18000aeb3:     	xchgq	%rcx, 0x9da6(%rip)      # 0x180014c60
18000aeba:     	movq	0x219f(%rip), %rax      # 0x18000d060
18000aec1:     	leaq	0x9618(%rip), %rcx      # 0x1800144e0
18000aec8:     	movq	%rax, 0x9d99(%rip)      # 0x180014c68
18000aecf:     	movq	0x219a(%rip), %rax      # 0x18000d070
18000aed6:     	movq	%rax, 0x9d93(%rip)      # 0x180014c70
18000aedd:     	movq	0x2184(%rip), %rax      # 0x18000d068
18000aee4:     	movq	%rax, 0x9d8d(%rip)      # 0x180014c78
18000aeeb:     	movq	0x2356(%rip), %rax      # 0x18000d248
18000aef2:     	movq	%rax, 0x971f(%rip)      # 0x180014618
18000aef9:     	callq	*0x2271(%rip)           # 0x18000d170
18000aeff:     	testl	%eax, %eax
18000af01:     	jne	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000af07:     	leaq	0x3012(%rip), %rdx      # 0x18000df20
18000af0e:     	movq	%r14, %rcx
18000af11:     	callq	*0x2251(%rip)           # 0x18000d168
18000af17:     	movq	%rax, 0x28(%rsp)
18000af1c:     	movq	%rax, %rdi
18000af1f:     	testq	%rax, %rax
18000af22:     	je	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000af28:     	leaq	0x318a(%rip), %rcx      # 0x18000e0b9
18000af2f:     	callq	*0x234b(%rip)           # 0x18000d280
18000af35:     	movq	%rax, 0x20(%rsp)
18000af3a:     	movq	%rax, %r12
18000af3d:     	testq	%rax, %rax
18000af40:     	je	0x18000b284 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76c4>
18000af46:     	movl	%ebx, %ebp
18000af48:     	cmpq	%rbx, (%rsi)
18000af4b:     	je	0x18000b0f4 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7534>
18000af51:     	movslq	%ebp, %rbx
18000af54:     	leaq	0x30(%rsp), %rdx
18000af59:     	movq	%r14, %rcx
18000af5c:     	leaq	(%rbx,%rbx,4), %rax
18000af60:     	movups	(%r13,%rax,8), %xmm0
18000af66:     	movups	0x10(%r13,%rax,8), %xmm1
18000af6c:     	movaps	%xmm0, 0x30(%rsp)
18000af71:     	movsd	0x20(%r13,%rax,8), %xmm0
18000af78:     	movsd	%xmm0, 0x50(%rsp)
18000af7e:     	movaps	%xmm1, 0x40(%rsp)
18000af83:     	callq	0x18000aa80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6ec0>
18000af88:     	movq	%rax, %r14
18000af8b:     	testq	%rax, %rax
18000af8e:     	je	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000af94:     	movq	(%rsi), %rcx
18000af97:     	callq	*0x22e3(%rip)           # 0x18000d280
18000af9d:     	movq	%rax, %r13
18000afa0:     	testq	%rax, %rax
18000afa3:     	je	0x18000b2a7 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76e7>
18000afa9:     	movq	(%r15,%rbx,8), %rcx
18000afad:     	xorl	%edx, %edx
18000afaf:     	movq	%r14, (%rcx)
18000afb2:     	leaq	0x9867(%rip), %rcx      # 0x180014820
18000afb9:     	movq	0x8(%rsi), %r12
18000afbd:     	callq	*0x218d(%rip)           # 0x18000d150
18000afc3:     	movq	%rax, %rbx
18000afc6:     	testq	%rax, %rax
18000afc9:     	je	0x18000b046 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7486>
18000afcb:     	movq	%r13, %rcx
18000afce:     	callq	*0x21ac(%rip)           # 0x18000d180
18000afd4:     	movq	%rax, %rdi
18000afd7:     	testq	%rax, %rax
18000afda:     	je	0x18000affc <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x743c>
18000afdc:     	movq	%rax, %rcx
18000afdf:     	callq	0x18000c885 <numba_list_iter_next+0xed5>
18000afe4:     	leaq	0x1(%rax), %rcx
18000afe8:     	callq	*0x2262(%rip)           # 0x18000d250
18000afee:     	movq	%rax, %rsi
18000aff1:     	testq	%rax, %rax
18000aff4:     	jne	0x18000b004 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7444>
18000aff6:     	callq	*0x2144(%rip)           # 0x18000d140
18000affc:     	xorl	%eax, %eax
18000affe:     	movq	%rax, 0x20(%rbx)
18000b002:     	jmp	0x18000b035 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7475>
18000b004:     	movq	%rdi, %rdx
18000b007:     	movq	%rsi, %rcx
18000b00a:     	callq	0x18000c87f <numba_list_iter_next+0xecf>
18000b00f:     	movq	0x20(%rsp), %rcx
18000b014:     	movq	%rsi, 0x20(%rbx)
18000b018:     	movq	%r12, 0x28(%rbx)
18000b01c:     	movl	$0x3, 0x30(%rbx)
18000b023:     	callq	0x18000a500 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6940>
18000b028:     	movq	%rax, 0x38(%rbx)
18000b02c:     	testq	%rax, %rax
18000b02f:     	jne	0x18000b1a0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75e0>
18000b035:     	movl	(%rbx), %eax
18000b037:     	testl	%eax, %eax
18000b039:     	js	0x18000b046 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7486>
18000b03b:     	subl	$0x1, %eax
18000b03e:     	movl	%eax, (%rbx)
18000b040:     	je	0x18000b1ed <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x762d>
18000b046:     	xorl	%edi, %edi
18000b048:     	movl	(%r14), %eax
18000b04b:     	testl	%eax, %eax
18000b04d:     	js	0x18000b060 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x74a0>
18000b04f:     	subl	$0x1, %eax
18000b052:     	movl	%eax, (%r14)
18000b055:     	jne	0x18000b060 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x74a0>
18000b057:     	movq	%r14, %rcx
18000b05a:     	callq	*0x2168(%rip)           # 0x18000d1c8
18000b060:     	movl	(%r13), %eax
18000b064:     	testl	%eax, %eax
18000b066:     	js	0x18000b07a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x74ba>
18000b068:     	subl	$0x1, %eax
18000b06b:     	movl	%eax, (%r13)
18000b06f:     	jne	0x18000b07a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x74ba>
18000b071:     	movq	%r13, %rcx
18000b074:     	callq	*0x214e(%rip)           # 0x18000d1c8
18000b07a:     	testq	%rdi, %rdi
18000b07d:     	je	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000b083:     	movq	0xb8(%rsp), %rsi
18000b08b:     	movq	%rdi, %r8
18000b08e:     	movq	0xb0(%rsp), %r14
18000b096:     	movq	%r14, %rcx
18000b099:     	movq	(%rsi), %rdx
18000b09c:     	callq	*0x217e(%rip)           # 0x18000d220
18000b0a2:     	movl	(%rdi), %ecx
18000b0a4:     	testl	%eax, %eax
18000b0a6:     	jne	0x18000b24a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x768a>
18000b0ac:     	testl	%ecx, %ecx
18000b0ae:     	js	0x18000b0c2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7502>
18000b0b0:     	leal	-0x1(%rcx), %eax
18000b0b3:     	movl	%eax, (%rdi)
18000b0b5:     	testl	%eax, %eax
18000b0b7:     	jne	0x18000b0c2 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7502>
18000b0b9:     	movq	%rdi, %rcx
18000b0bc:     	callq	*0x2106(%rip)           # 0x18000d1c8
18000b0c2:     	movq	0xc8(%rsp), %r15
18000b0ca:     	addq	$0x20, %rsi
18000b0ce:     	movq	0xc0(%rsp), %r13
18000b0d6:     	incl	%ebp
18000b0d8:     	movq	%rsi, 0xb8(%rsp)
18000b0e0:     	cmpq	$0x0, (%rsi)
18000b0e4:     	jne	0x18000af51 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7391>
18000b0ea:     	movq	0x20(%rsp), %r12
18000b0ef:     	movq	0x28(%rsp), %rdi
18000b0f4:     	movslq	%ebp, %rax
18000b0f7:     	cmpq	$0x0, (%r15,%rax,8)
18000b0fc:     	je	0x18000b169 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75a9>
18000b0fe:     	nop
18000b100:     	movslq	%ebp, %rbx
18000b103:     	leaq	0x30(%rsp), %rdx
18000b108:     	movq	%r14, %rcx
18000b10b:     	leaq	(%rbx,%rbx,4), %rax
18000b10f:     	movups	(%r13,%rax,8), %xmm0
18000b115:     	movups	0x10(%r13,%rax,8), %xmm1
18000b11b:     	movaps	%xmm0, 0x30(%rsp)
18000b120:     	movsd	0x20(%r13,%rax,8), %xmm0
18000b127:     	movsd	%xmm0, 0x50(%rsp)
18000b12d:     	movaps	%xmm1, 0x40(%rsp)
18000b132:     	callq	0x18000aa80 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x6ec0>
18000b137:     	testq	%rax, %rax
18000b13a:     	je	0x18000b265 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a5>
18000b140:     	movq	(%r15,%rbx,8), %rcx
18000b144:     	movq	%rax, (%rcx)
18000b147:     	movl	(%rax), %ecx
18000b149:     	testl	%ecx, %ecx
18000b14b:     	js	0x18000b15d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x759d>
18000b14d:     	subl	$0x1, %ecx
18000b150:     	movl	%ecx, (%rax)
18000b152:     	jne	0x18000b15d <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x759d>
18000b154:     	movq	%rax, %rcx
18000b157:     	callq	*0x206b(%rip)           # 0x18000d1c8
18000b15d:     	incl	%ebp
18000b15f:     	movslq	%ebp, %rax
18000b162:     	cmpq	$0x0, (%r15,%rax,8)
18000b167:     	jne	0x18000b100 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7540>
18000b169:     	movl	(%r12), %eax
18000b16d:     	testl	%eax, %eax
18000b16f:     	js	0x18000b183 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75c3>
18000b171:     	subl	$0x1, %eax
18000b174:     	movl	%eax, (%r12)
18000b178:     	jne	0x18000b183 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75c3>
18000b17a:     	movq	%r12, %rcx
18000b17d:     	callq	*0x2045(%rip)           # 0x18000d1c8
18000b183:     	movl	(%rdi), %eax
18000b185:     	testl	%eax, %eax
18000b187:     	js	0x18000b199 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75d9>
18000b189:     	subl	$0x1, %eax
18000b18c:     	movl	%eax, (%rdi)
18000b18e:     	jne	0x18000b199 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75d9>
18000b190:     	movq	%rdi, %rcx
18000b193:     	callq	*0x202f(%rip)           # 0x18000d1c8
18000b199:     	xorl	%eax, %eax
18000b19b:     	jmp	0x18000ad89 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c9>
18000b1a0:     	movl	(%r14), %eax
18000b1a3:     	cmpl	$0xc0000000, %eax       # imm = 0xC0000000
18000b1a8:     	jae	0x18000b1af <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x75ef>
18000b1aa:     	incl	%eax
18000b1ac:     	movl	%eax, (%r14)
18000b1af:     	movq	0xb0(%rsp), %rcx
18000b1b7:     	leaq	0x2d62(%rip), %rdx      # 0x18000df20
18000b1be:     	movq	%r14, 0x18(%rbx)
18000b1c2:     	movq	$0x0, 0x40(%rbx)
18000b1ca:     	callq	*0x1f98(%rip)           # 0x18000d168
18000b1d0:     	movq	%rax, %rsi
18000b1d3:     	testq	%rax, %rax
18000b1d6:     	jne	0x18000b1fb <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x763b>
18000b1d8:     	movl	(%rbx), %eax
18000b1da:     	testl	%eax, %eax
18000b1dc:     	js	0x18000b046 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7486>
18000b1e2:     	subl	$0x1, %eax
18000b1e5:     	movl	%eax, (%rbx)
18000b1e7:     	jne	0x18000b046 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7486>
18000b1ed:     	movq	%rbx, %rcx
18000b1f0:     	callq	*0x1fd2(%rip)           # 0x18000d1c8
18000b1f6:     	jmp	0x18000b046 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7486>
18000b1fb:     	xorl	%r9d, %r9d
18000b1fe:     	leaq	0x20(%rbx), %rcx
18000b202:     	movq	%rsi, %r8
18000b205:     	movq	%rbx, %rdx
18000b208:     	callq	*0x1f3a(%rip)           # 0x18000d148
18000b20e:     	movq	%rax, %rdi
18000b211:     	movl	(%rbx), %eax
18000b213:     	testl	%eax, %eax
18000b215:     	js	0x18000b227 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7667>
18000b217:     	subl	$0x1, %eax
18000b21a:     	movl	%eax, (%rbx)
18000b21c:     	jne	0x18000b227 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7667>
18000b21e:     	movq	%rbx, %rcx
18000b221:     	callq	*0x1fa1(%rip)           # 0x18000d1c8
18000b227:     	movl	(%rsi), %eax
18000b229:     	testl	%eax, %eax
18000b22b:     	js	0x18000b048 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7488>
18000b231:     	subl	$0x1, %eax
18000b234:     	movl	%eax, (%rsi)
18000b236:     	jne	0x18000b048 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7488>
18000b23c:     	movq	%rsi, %rcx
18000b23f:     	callq	*0x1f83(%rip)           # 0x18000d1c8
18000b245:     	jmp	0x18000b048 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7488>
18000b24a:     	testl	%ecx, %ecx
18000b24c:     	js	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000b24e:     	leal	-0x1(%rcx), %eax
18000b251:     	movl	%eax, (%rdi)
18000b253:     	testl	%eax, %eax
18000b255:     	jne	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000b257:     	movq	%rdi, %rcx
18000b25a:     	callq	*0x1f68(%rip)           # 0x18000d1c8
18000b260:     	movq	0x20(%rsp), %r12
18000b265:     	movl	(%r12), %eax
18000b269:     	testl	%eax, %eax
18000b26b:     	js	0x18000b27f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76bf>
18000b26d:     	subl	$0x1, %eax
18000b270:     	movl	%eax, (%r12)
18000b274:     	jne	0x18000b27f <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76bf>
18000b276:     	movq	%r12, %rcx
18000b279:     	callq	*0x1f49(%rip)           # 0x18000d1c8
18000b27f:     	movq	0x28(%rsp), %rdi
18000b284:     	movl	(%rdi), %eax
18000b286:     	testl	%eax, %eax
18000b288:     	js	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000b28e:     	subl	$0x1, %eax
18000b291:     	movl	%eax, (%rdi)
18000b293:     	jne	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000b299:     	movq	%rdi, %rcx
18000b29c:     	callq	*0x1f26(%rip)           # 0x18000d1c8
18000b2a2:     	jmp	0x18000ad84 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x71c4>
18000b2a7:     	movl	(%r14), %eax
18000b2aa:     	testl	%eax, %eax
18000b2ac:     	js	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000b2ae:     	subl	$0x1, %eax
18000b2b1:     	movl	%eax, (%r14)
18000b2b4:     	jne	0x18000b260 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x76a0>
18000b2b6:     	movq	%r14, %rcx
18000b2b9:     	jmp	0x18000b25a <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x769a>
18000b2bb:     	int3
18000b2bc:     	int3
18000b2bd:     	int3
18000b2be:     	int3
18000b2bf:     	int3
18000b2c0:     	leaq	0x9a19(%rip), %rax      # 0x180014ce0
18000b2c7:     	retq
18000b2c8:     	int3
18000b2c9:     	int3
18000b2ca:     	int3
18000b2cb:     	int3
18000b2cc:     	int3
18000b2cd:     	int3
18000b2ce:     	int3
18000b2cf:     	int3

000000018000b2d0 <numba_list_set_method_table>:
18000b2d0:     	movups	(%rdx), %xmm0
18000b2d3:     	movups	%xmm0, 0x20(%rcx)
18000b2d7:     	retq
18000b2d8:     	int3
18000b2d9:     	int3
18000b2da:     	int3
18000b2db:     	int3
18000b2dc:     	int3
18000b2dd:     	int3
18000b2de:     	int3
18000b2df:     	int3

000000018000b2e0 <numba_list_new>:
18000b2e0:     	pushq	%rbx
18000b2e2:     	pushq	%rbp
18000b2e3:     	pushq	%rsi
18000b2e4:     	pushq	%rdi
18000b2e5:     	subq	$0x28, %rsp
18000b2e9:     	movq	%rcx, %rsi
18000b2ec:     	movq	%r8, %rdi
18000b2ef:     	movl	$0x38, %ecx
18000b2f4:     	movq	%rdx, %rbp
18000b2f7:     	callq	*0x1d63(%rip)           # 0x18000d060
18000b2fd:     	movq	%rax, %rbx
18000b300:     	testq	%rax, %rax
18000b303:     	je	0x18000b36d <numba_list_new+0x8d>
18000b305:     	movq	$0x0, (%rax)
18000b30c:     	xorps	%xmm0, %xmm0
18000b30f:     	movq	%rbp, 0x8(%rax)
18000b313:     	movq	%rdi, 0x10(%rax)
18000b317:     	movl	$0x1, 0x18(%rax)
18000b31e:     	movups	%xmm0, 0x20(%rax)
18000b322:     	testq	%rdi, %rdi
18000b325:     	je	0x18000b37b <numba_list_new+0x9b>
18000b327:     	imulq	%rbp, %rdi
18000b32b:     	movl	$0x8, %ecx
18000b330:     	movq	%rdi, %rax
18000b333:     	cqto
18000b335:     	andl	$0x7, %edx
18000b338:     	addq	%rdx, %rax
18000b33b:     	andl	$0x7, %eax
18000b33e:     	subq	%rdx, %rax
18000b341:     	subq	%rax, %rcx
18000b344:     	movq	%rcx, %rax
18000b347:     	cqto
18000b349:     	andl	$0x7, %edx
18000b34c:     	leaq	(%rdx,%rax), %rcx
18000b350:     	andl	$0x7, %ecx
18000b353:     	subq	%rdx, %rcx
18000b356:     	addq	%rdi, %rcx
18000b359:     	callq	*0x1d01(%rip)           # 0x18000d060
18000b35f:     	testq	%rax, %rax
18000b362:     	jne	0x18000b37d <numba_list_new+0x9d>
18000b364:     	movq	%rbx, %rcx
18000b367:     	callq	*0x1cfb(%rip)           # 0x18000d068
18000b36d:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000b372:     	addq	$0x28, %rsp
18000b376:     	popq	%rdi
18000b377:     	popq	%rsi
18000b378:     	popq	%rbp
18000b379:     	popq	%rbx
18000b37a:     	retq
18000b37b:     	xorl	%eax, %eax
18000b37d:     	movq	%rax, 0x30(%rbx)
18000b381:     	xorl	%eax, %eax
18000b383:     	movq	%rbx, (%rsi)
18000b386:     	addq	$0x28, %rsp
18000b38a:     	popq	%rdi
18000b38b:     	popq	%rsi
18000b38c:     	popq	%rbp
18000b38d:     	popq	%rbx
18000b38e:     	retq
18000b38f:     	int3

000000018000b390 <numba_list_free>:
18000b390:     	pushq	%rbx
18000b392:     	subq	$0x20, %rsp
18000b396:     	cmpq	$0x0, 0x28(%rcx)
18000b39b:     	movq	%rcx, %rbx
18000b39e:     	je	0x18000b3d4 <numba_list_free+0x44>
18000b3a0:     	movq	%rdi, 0x30(%rsp)
18000b3a5:     	xorl	%edi, %edi
18000b3a7:     	cmpq	%rdi, (%rcx)
18000b3aa:     	jle	0x18000b3cf <numba_list_free+0x3f>
18000b3ac:     	nopl	(%rax)
18000b3b0:     	movq	0x28(%rbx), %rax
18000b3b4:     	testq	%rax, %rax
18000b3b7:     	je	0x18000b3c7 <numba_list_free+0x37>
18000b3b9:     	movq	%rdi, %rcx
18000b3bc:     	imulq	0x8(%rbx), %rcx
18000b3c1:     	addq	0x30(%rbx), %rcx
18000b3c5:     	callq	*%rax
18000b3c7:     	incq	%rdi
18000b3ca:     	cmpq	(%rbx), %rdi
18000b3cd:     	jl	0x18000b3b0 <numba_list_free+0x20>
18000b3cf:     	movq	0x30(%rsp), %rdi
18000b3d4:     	movq	0x30(%rbx), %rcx
18000b3d8:     	testq	%rcx, %rcx
18000b3db:     	je	0x18000b3e3 <numba_list_free+0x53>
18000b3dd:     	callq	*0x1c85(%rip)           # 0x18000d068
18000b3e3:     	movq	%rbx, %rcx
18000b3e6:     	addq	$0x20, %rsp
18000b3ea:     	popq	%rbx
18000b3eb:     	jmpq	*0x1c76(%rip)           # 0x18000d068
18000b3f2:     	int3
18000b3f3:     	int3
18000b3f4:     	int3
18000b3f5:     	int3
18000b3f6:     	int3
18000b3f7:     	int3
18000b3f8:     	int3
18000b3f9:     	int3
18000b3fa:     	int3
18000b3fb:     	int3
18000b3fc:     	int3
18000b3fd:     	int3
18000b3fe:     	int3
18000b3ff:     	int3

000000018000b400 <numba_list_base_ptr>:
18000b400:     	movq	0x30(%rcx), %rax
18000b404:     	retq
18000b405:     	int3
18000b406:     	int3
18000b407:     	int3
18000b408:     	int3
18000b409:     	int3
18000b40a:     	int3
18000b40b:     	int3
18000b40c:     	int3
18000b40d:     	int3
18000b40e:     	int3
18000b40f:     	int3

000000018000b410 <numba_list_size_address>:
18000b410:     	movq	%rcx, %rax
18000b413:     	retq
18000b414:     	int3
18000b415:     	int3
18000b416:     	int3
18000b417:     	int3
18000b418:     	int3
18000b419:     	int3
18000b41a:     	int3
18000b41b:     	int3
18000b41c:     	int3
18000b41d:     	int3
18000b41e:     	int3
18000b41f:     	int3

000000018000b420 <numba_list_length>:
18000b420:     	movq	(%rcx), %rax
18000b423:     	retq
18000b424:     	int3
18000b425:     	int3
18000b426:     	int3
18000b427:     	int3
18000b428:     	int3
18000b429:     	int3
18000b42a:     	int3
18000b42b:     	int3
18000b42c:     	int3
18000b42d:     	int3
18000b42e:     	int3
18000b42f:     	int3

000000018000b430 <numba_list_allocated>:
18000b430:     	movq	0x10(%rcx), %rax
18000b434:     	retq
18000b435:     	int3
18000b436:     	int3
18000b437:     	int3
18000b438:     	int3
18000b439:     	int3
18000b43a:     	int3
18000b43b:     	int3
18000b43c:     	int3
18000b43d:     	int3
18000b43e:     	int3
18000b43f:     	int3

000000018000b440 <numba_list_is_mutable>:
18000b440:     	movl	0x18(%rcx), %eax
18000b443:     	retq
18000b444:     	int3
18000b445:     	int3
18000b446:     	int3
18000b447:     	int3
18000b448:     	int3
18000b449:     	int3
18000b44a:     	int3
18000b44b:     	int3
18000b44c:     	int3
18000b44d:     	int3
18000b44e:     	int3
18000b44f:     	int3

000000018000b450 <numba_list_set_is_mutable>:
18000b450:     	movl	%edx, 0x18(%rcx)
18000b453:     	retq
18000b454:     	int3
18000b455:     	int3
18000b456:     	int3
18000b457:     	int3
18000b458:     	int3
18000b459:     	int3
18000b45a:     	int3
18000b45b:     	int3
18000b45c:     	int3
18000b45d:     	int3
18000b45e:     	int3
18000b45f:     	int3

000000018000b460 <numba_list_setitem>:
18000b460:     	movq	%rbx, 0x10(%rsp)
18000b465:     	pushq	%rsi
18000b466:     	subq	$0x20, %rsp
18000b46a:     	cmpl	$0x0, 0x18(%rcx)
18000b46e:     	movq	%r8, %rsi
18000b471:     	movq	%rcx, %rbx
18000b474:     	jne	0x18000b486 <numba_list_setitem+0x26>
18000b476:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b47b:     	movq	0x38(%rsp), %rbx
18000b480:     	addq	$0x20, %rsp
18000b484:     	popq	%rsi
18000b485:     	retq
18000b486:     	cmpq	(%rcx), %rdx
18000b489:     	jb	0x18000b49b <numba_list_setitem+0x3b>
18000b48b:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b490:     	movq	0x38(%rsp), %rbx
18000b495:     	addq	$0x20, %rsp
18000b499:     	popq	%rsi
18000b49a:     	retq
18000b49b:     	imulq	0x8(%rcx), %rdx
18000b4a0:     	movq	0x28(%rcx), %rax
18000b4a4:     	movq	%rdi, 0x30(%rsp)
18000b4a9:     	movq	0x30(%rcx), %rdi
18000b4ad:     	addq	%rdx, %rdi
18000b4b0:     	testq	%rax, %rax
18000b4b3:     	je	0x18000b4ba <numba_list_setitem+0x5a>
18000b4b5:     	movq	%rdi, %rcx
18000b4b8:     	callq	*%rax
18000b4ba:     	movq	0x8(%rbx), %r8
18000b4be:     	movq	%rsi, %rdx
18000b4c1:     	movq	%rdi, %rcx
18000b4c4:     	callq	0x18000c873 <numba_list_iter_next+0xec3>
18000b4c9:     	movq	0x20(%rbx), %rax
18000b4cd:     	testq	%rax, %rax
18000b4d0:     	je	0x18000b4d7 <numba_list_setitem+0x77>
18000b4d2:     	movq	%rdi, %rcx
18000b4d5:     	callq	*%rax
18000b4d7:     	movq	0x30(%rsp), %rdi
18000b4dc:     	xorl	%eax, %eax
18000b4de:     	movq	0x38(%rsp), %rbx
18000b4e3:     	addq	$0x20, %rsp
18000b4e7:     	popq	%rsi
18000b4e8:     	retq
18000b4e9:     	int3
18000b4ea:     	int3
18000b4eb:     	int3
18000b4ec:     	int3
18000b4ed:     	int3
18000b4ee:     	int3
18000b4ef:     	int3

000000018000b4f0 <numba_list_getitem>:
18000b4f0:     	subq	$0x28, %rsp
18000b4f4:     	movq	%r8, %r9
18000b4f7:     	movq	%rdx, %rax
18000b4fa:     	cmpq	(%rcx), %rdx
18000b4fd:     	jb	0x18000b509 <numba_list_getitem+0x19>
18000b4ff:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b504:     	addq	$0x28, %rsp
18000b508:     	retq
18000b509:     	movq	0x8(%rcx), %r8
18000b50d:     	movq	%r8, %rdx
18000b510:     	imulq	%rax, %rdx
18000b514:     	addq	0x30(%rcx), %rdx
18000b518:     	movq	%r9, %rcx
18000b51b:     	callq	0x18000c873 <numba_list_iter_next+0xec3>
18000b520:     	xorl	%eax, %eax
18000b522:     	addq	$0x28, %rsp
18000b526:     	retq
18000b527:     	int3
18000b528:     	int3
18000b529:     	int3
18000b52a:     	int3
18000b52b:     	int3
18000b52c:     	int3
18000b52d:     	int3
18000b52e:     	int3
18000b52f:     	int3

000000018000b530 <numba_list_append>:
18000b530:     	movq	%rbx, 0x10(%rsp)
18000b535:     	pushq	%rsi
18000b536:     	subq	$0x20, %rsp
18000b53a:     	cmpl	$0x0, 0x18(%rcx)
18000b53e:     	movq	%rdx, %rsi
18000b541:     	movq	%rcx, %rbx
18000b544:     	jne	0x18000b556 <numba_list_append+0x26>
18000b546:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b54b:     	movq	0x38(%rsp), %rbx
18000b550:     	addq	$0x20, %rsp
18000b554:     	popq	%rsi
18000b555:     	retq
18000b556:     	movq	(%rcx), %rdx
18000b559:     	incq	%rdx
18000b55c:     	callq	0x18000b5b0 <numba_list_resize>
18000b561:     	testl	%eax, %eax
18000b563:     	js	0x18000b59c <numba_list_append+0x6c>
18000b565:     	movq	0x8(%rbx), %r8
18000b569:     	movq	%rsi, %rdx
18000b56c:     	movq	%rdi, 0x30(%rsp)
18000b571:     	movq	(%rbx), %rdi
18000b574:     	decq	%rdi
18000b577:     	imulq	%r8, %rdi
18000b57b:     	addq	0x30(%rbx), %rdi
18000b57f:     	movq	%rdi, %rcx
18000b582:     	callq	0x18000c873 <numba_list_iter_next+0xec3>
18000b587:     	movq	0x20(%rbx), %rax
18000b58b:     	testq	%rax, %rax
18000b58e:     	je	0x18000b595 <numba_list_append+0x65>
18000b590:     	movq	%rdi, %rcx
18000b593:     	callq	*%rax
18000b595:     	movq	0x30(%rsp), %rdi
18000b59a:     	xorl	%eax, %eax
18000b59c:     	movq	0x38(%rsp), %rbx
18000b5a1:     	addq	$0x20, %rsp
18000b5a5:     	popq	%rsi
18000b5a6:     	retq
18000b5a7:     	int3
18000b5a8:     	int3
18000b5a9:     	int3
18000b5aa:     	int3
18000b5ab:     	int3
18000b5ac:     	int3
18000b5ad:     	int3
18000b5ae:     	int3
18000b5af:     	int3

000000018000b5b0 <numba_list_resize>:
18000b5b0:     	movq	%rsi, 0x18(%rsp)
18000b5b5:     	pushq	%rdi
18000b5b6:     	subq	$0x20, %rsp
18000b5ba:     	cmpl	$0x0, 0x18(%rcx)
18000b5be:     	movq	%rdx, %rsi
18000b5c1:     	movq	%rcx, %rdi
18000b5c4:     	jne	0x18000b5d6 <numba_list_resize+0x26>
18000b5c6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b5cb:     	movq	0x40(%rsp), %rsi
18000b5d0:     	addq	$0x20, %rsp
18000b5d4:     	popq	%rdi
18000b5d5:     	retq
18000b5d6:     	movq	0x10(%rcx), %rax
18000b5da:     	cmpq	%rsi, %rax
18000b5dd:     	jl	0x18000b5f7 <numba_list_resize+0x47>
18000b5df:     	sarq	%rax
18000b5e2:     	cmpq	%rax, %rsi
18000b5e5:     	jl	0x18000b5f7 <numba_list_resize+0x47>
18000b5e7:     	movq	%rsi, (%rcx)
18000b5ea:     	xorl	%eax, %eax
18000b5ec:     	movq	0x40(%rsp), %rsi
18000b5f1:     	addq	$0x20, %rsp
18000b5f5:     	popq	%rdi
18000b5f6:     	retq
18000b5f7:     	cmpq	$0x9, %rsi
18000b5fb:     	movq	%rbp, 0x38(%rsp)
18000b600:     	movl	$0x3, %ecx
18000b605:     	movl	$0x6, %eax
18000b60a:     	cmovll	%ecx, %eax
18000b60d:     	movq	%rsi, %r8
18000b610:     	movq	0x8(%rdi), %rcx
18000b614:     	addq	%rsi, %rax
18000b617:     	sarq	$0x3, %r8
18000b61b:     	xorl	%edx, %edx
18000b61d:     	addq	%rax, %r8
18000b620:     	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
18000b62a:     	divq	%rcx
18000b62d:     	cmpq	%rax, %r8
18000b630:     	ja	0x18000b6ab <numba_list_resize+0xfb>
18000b632:     	xorl	%ebp, %ebp
18000b634:     	movq	%rbx, 0x30(%rsp)
18000b639:     	testq	%rsi, %rsi
18000b63c:     	cmovneq	%r8, %rbp
18000b640:     	movq	%rbp, %rbx
18000b643:     	imulq	%rcx, %rbx
18000b647:     	movl	$0x8, %ecx
18000b64c:     	movq	%rbx, %rax
18000b64f:     	cqto
18000b651:     	andl	$0x7, %edx
18000b654:     	addq	%rdx, %rax
18000b657:     	andl	$0x7, %eax
18000b65a:     	subq	%rdx, %rax
18000b65d:     	subq	%rax, %rcx
18000b660:     	movq	%rcx, %rax
18000b663:     	movq	0x30(%rdi), %rcx
18000b667:     	cqto
18000b669:     	andl	$0x7, %edx
18000b66c:     	addq	%rdx, %rax
18000b66f:     	andl	$0x7, %eax
18000b672:     	subq	%rdx, %rax
18000b675:     	leaq	(%rbx,%rax), %rdx
18000b679:     	callq	*0x19f1(%rip)           # 0x18000d070
18000b67f:     	testq	%rbx, %rbx
18000b682:     	movq	0x30(%rsp), %rbx
18000b687:     	je	0x18000b68e <numba_list_resize+0xde>
18000b689:     	testq	%rax, %rax
18000b68c:     	je	0x18000b6ab <numba_list_resize+0xfb>
18000b68e:     	movq	%rax, 0x30(%rdi)
18000b692:     	xorl	%eax, %eax
18000b694:     	movq	%rbp, 0x10(%rdi)
18000b698:     	movq	0x38(%rsp), %rbp
18000b69d:     	movq	%rsi, (%rdi)
18000b6a0:     	movq	0x40(%rsp), %rsi
18000b6a5:     	addq	$0x20, %rsp
18000b6a9:     	popq	%rdi
18000b6aa:     	retq
18000b6ab:     	movq	0x38(%rsp), %rbp
18000b6b0:     	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
18000b6b5:     	movq	0x40(%rsp), %rsi
18000b6ba:     	addq	$0x20, %rsp
18000b6be:     	popq	%rdi
18000b6bf:     	retq

000000018000b6c0 <numba_list_delitem>:
18000b6c0:     	movq	%rbx, 0x10(%rsp)
18000b6c5:     	pushq	%rdi
18000b6c6:     	subq	$0x20, %rsp
18000b6ca:     	cmpl	$0x0, 0x18(%rcx)
18000b6ce:     	movq	%rdx, %rdi
18000b6d1:     	movq	%rcx, %rbx
18000b6d4:     	jne	0x18000b6e6 <numba_list_delitem+0x26>
18000b6d6:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b6db:     	movq	0x38(%rsp), %rbx
18000b6e0:     	addq	$0x20, %rsp
18000b6e4:     	popq	%rdi
18000b6e5:     	retq
18000b6e6:     	cmpq	(%rcx), %rdi
18000b6e9:     	jb	0x18000b6fb <numba_list_delitem+0x3b>
18000b6eb:     	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
18000b6f0:     	movq	0x38(%rsp), %rbx
18000b6f5:     	addq	$0x20, %rsp
18000b6f9:     	popq	%rdi
18000b6fa:     	retq
18000b6fb:     	movq	0x28(%rcx), %rax
18000b6ff:     	movq	%rsi, 0x30(%rsp)
18000b704:     	movq	%rdi, %rsi
18000b707:     	imulq	0x8(%rcx), %rsi
18000b70c:     	addq	0x30(%rcx), %rsi
18000b710:     	testq	%rax, %rax
18000b713:     	je	0x18000b71a <numba_list_delitem+0x5a>
18000b715:     	movq	%rsi, %rcx
18000b718:     	callq	*%rax
18000b71a:     	movq	(%rbx), %r8
18000b71d:     	leaq	-0x1(%r8), %rax
18000b721:     	cmpq	%rax, %rdi
18000b724:     	je	0x18000b746 <numba_list_delitem+0x86>
18000b726:     	subq	%rdi, %r8
18000b729:     	leaq	0x1(%rdi), %rdx
18000b72d:     	imulq	0x8(%rbx), %rdx
18000b732:     	decq	%r8
18000b735:     	movq	%rsi, %rcx
18000b738:     	imulq	0x8(%rbx), %r8
18000b73d:     	addq	0x30(%rbx), %rdx
18000b741:     	callq	0x18000c879 <numba_list_iter_next+0xec9>
18000b746:     	movq	(%rbx), %rdx
18000b749:     	movq	%rbx, %rcx
18000b74c:     	decq	%rdx
18000b74f:     	callq	0x18000b5b0 <numba_list_resize>
18000b754:     	movq	0x30(%rsp), %rsi
18000b759:     	xorl	%ecx, %ecx
18000b75b:     	movq	0x38(%rsp), %rbx
18000b760:     	testl	%eax, %eax
18000b762:     	cmovsl	%eax, %ecx
18000b765:     	movl	%ecx, %eax
18000b767:     	addq	$0x20, %rsp
18000b76b:     	popq	%rdi
18000b76c:     	retq
18000b76d:     	int3
18000b76e:     	int3
18000b76f:     	int3

000000018000b770 <numba_list_delete_slice>:
18000b770:     	pushq	%rbx
18000b772:     	pushq	%rbp
18000b773:     	pushq	%rdi
18000b774:     	pushq	%r15
18000b776:     	subq	$0x38, %rsp
18000b77a:     	cmpl	$0x0, 0x18(%rcx)
18000b77e:     	movq	%r9, %rdi
18000b781:     	movq	%r8, %rbp
18000b784:     	movq	%rdx, %r15
18000b787:     	movq	%rcx, %rbx
18000b78a:     	jne	0x18000b79b <numba_list_delete_slice+0x2b>
18000b78c:     	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
18000b791:     	addq	$0x38, %rsp
18000b795:     	popq	%r15
18000b797:     	popq	%rdi
18000b798:     	popq	%rbp
18000b799:     	popq	%rbx
18000b79a:     	retq
18000b79b:     	movq	%r13, 0x78(%rsp)
18000b7a0:     	testq	%rdi, %rdi
18000b7a3:     	jle	0x18000b7c2 <numba_list_delete_slice+0x52>
18000b7a5:     	cmpq	%r8, %r15
18000b7a8:     	jge	0x18000b961 <numba_list_delete_slice+0x1f1>
18000b7ae:     	movq	%r8, %rax
18000b7b1:     	subq	%r15, %rax
18000b7b4:     	decq	%rax
18000b7b7:     	cqto
18000b7b9:     	idivq	%rdi
18000b7bc:     	leal	0x1(%rax), %r13d
18000b7c0:     	jmp	0x18000b7e2 <numba_list_delete_slice+0x72>
18000b7c2:     	cmpq	%r15, %r8
18000b7c5:     	jge	0x18000b961 <numba_list_delete_slice+0x1f1>
18000b7cb:     	movq	%r15, %rax
18000b7ce:     	movl	$0x1, %r13d
18000b7d4:     	subq	%r8, %rax
18000b7d7:     	decq	%rax
18000b7da:     	cqto
18000b7dc:     	idivq	%rdi
18000b7df:     	subl	%eax, %r13d
18000b7e2:     	testl	%r13d, %r13d
18000b7e5:     	jle	0x18000b961 <numba_list_delete_slice+0x1f1>
18000b7eb:     	movq	%rsi, 0x68(%rsp)
18000b7f0:     	movl	(%rcx), %esi
18000b7f2:     	subl	%r13d, %esi
18000b7f5:     	movl	%esi, 0x20(%rsp)
18000b7f9:     	testq	%rdi, %rdi
18000b7fc:     	jns	0x18000b817 <numba_list_delete_slice+0xa7>
18000b7fe:     	leaq	0x1(%r15), %rbp
18000b802:     	leal	-0x1(%r13), %eax
18000b806:     	movslq	%eax, %rcx
18000b809:     	leaq	-0x1(%rbp), %r15
18000b80d:     	imulq	%rdi, %rcx
18000b811:     	addq	%rcx, %r15
18000b814:     	negq	%rdi
18000b817:     	cmpq	$0x1, %rdi
18000b81b:     	jne	0x18000b867 <numba_list_delete_slice+0xf7>
18000b81d:     	cmpq	$0x0, 0x28(%rbx)
18000b822:     	je	0x18000b849 <numba_list_delete_slice+0xd9>
18000b824:     	movslq	%r15d, %rdi
18000b827:     	cmpq	%rbp, %rdi
18000b82a:     	jge	0x18000b849 <numba_list_delete_slice+0xd9>
18000b82c:     	nopl	(%rax)
18000b830:     	movslq	%edi, %rcx
18000b833:     	imulq	0x8(%rbx), %rcx
18000b838:     	addq	0x30(%rbx), %rcx
18000b83c:     	callq	*0x28(%rbx)
18000b83f:     	incl	%edi
18000b841:     	movslq	%edi, %rax
18000b844:     	cmpq	%rbp, %rax
18000b847:     	jl	0x18000b830 <numba_list_delete_slice+0xc0>
18000b849:     	movq	0x8(%rbx), %rcx
18000b84d:     	movq	(%rbx), %r8
18000b850:     	movq	%rcx, %rdx
18000b853:     	subq	%rbp, %r8
18000b856:     	imulq	%rcx, %r8
18000b85a:     	imulq	%rbp, %rdx
18000b85e:     	imulq	%r15, %rcx
18000b862:     	jmp	0x18000b92c <numba_list_delete_slice+0x1bc>
18000b867:     	movq	%r14, 0x30(%rsp)
18000b86c:     	movq	%r15, %r14
18000b86f:     	movl	$0x0, 0x60(%rsp)
18000b877:     	cmpq	%rbp, %r15
18000b87a:     	jge	0x18000b8f9 <numba_list_delete_slice+0x189>
18000b87c:     	movq	%r12, 0x70(%rsp)
18000b881:     	movq	(%rbx), %rax
18000b884:     	leaq	(%r14,%rdi), %r12
18000b888:     	cmpq	%rax, %r12
18000b88b:     	jl	0x18000b898 <numba_list_delete_slice+0x128>
18000b88d:     	movq	%r14, %rsi
18000b890:     	notq	%rsi
18000b893:     	addq	%rax, %rsi
18000b896:     	jmp	0x18000b89c <numba_list_delete_slice+0x12c>
18000b898:     	leaq	-0x1(%rdi), %rsi
18000b89c:     	movq	0x28(%rbx), %rax
18000b8a0:     	testq	%rax, %rax
18000b8a3:     	je	0x18000b8b3 <numba_list_delete_slice+0x143>
18000b8a5:     	movq	%r14, %rcx
18000b8a8:     	imulq	0x8(%rbx), %rcx
18000b8ad:     	addq	0x30(%rbx), %rcx
18000b8b1:     	callq	*%rax
18000b8b3:     	movq	0x8(%rbx), %r9
18000b8b7:     	leaq	0x1(%r14), %rdx
18000b8bb:     	movq	0x30(%rbx), %r10
18000b8bf:     	movq	%r9, %r8
18000b8c2:     	imulq	%rsi, %r8
18000b8c6:     	imulq	%r9, %rdx
18000b8ca:     	movslq	0x60(%rsp), %rsi
18000b8cf:     	subq	%rsi, %r14
18000b8d2:     	imulq	%r9, %r14
18000b8d6:     	addq	%r10, %rdx
18000b8d9:     	leaq	(%r10,%r14), %rcx
18000b8dd:     	callq	0x18000c879 <numba_list_iter_next+0xec9>
18000b8e2:     	incl	%esi
18000b8e4:     	movq	%r12, %r14
18000b8e7:     	movl	%esi, 0x60(%rsp)
18000b8eb:     	cmpq	%rbp, %r12
18000b8ee:     	jl	0x18000b881 <numba_list_delete_slice+0x111>
18000b8f0:     	movq	0x70(%rsp), %r12
18000b8f5:     	movl	0x20(%rsp), %esi
18000b8f9:     	movq	(%rbx), %r8
18000b8fc:     	movq	0x30(%rsp), %r14
18000b901:     	movslq	%r13d, %r10
18000b904:     	movq	%r10, %rcx
18000b907:     	imulq	%rdi, %rcx
18000b90b:     	addq	%r15, %rcx
18000b90e:     	cmpq	%r8, %rcx
18000b911:     	jge	0x18000b939 <numba_list_delete_slice+0x1c9>
18000b913:     	movq	0x8(%rbx), %rax
18000b917:     	subq	%rcx, %r8
18000b91a:     	movq	%rax, %rdx
18000b91d:     	imulq	%rcx, %rdx
18000b921:     	imulq	%rax, %r8
18000b925:     	subq	%r10, %rcx
18000b928:     	imulq	%rax, %rcx
18000b92c:     	addq	0x30(%rbx), %rdx
18000b930:     	addq	0x30(%rbx), %rcx
18000b934:     	callq	0x18000c879 <numba_list_iter_next+0xec9>
18000b939:     	movslq	%esi, %rdx
18000b93c:     	movq	%rbx, %rcx
18000b93f:     	callq	0x18000b5b0 <numba_list_resize>
18000b944:     	movq	0x68(%rsp), %rsi
18000b949:     	xorl	%ecx, %ecx
18000b94b:     	movq	0x78(%rsp), %r13
18000b950:     	testl	%eax, %eax
18000b952:     	cmovsl	%eax, %ecx
18000b955:     	movl	%ecx, %eax
18000b957:     	addq	$0x38, %rsp
18000b95b:     	popq	%r15
18000b95d:     	popq	%rdi
18000b95e:     	popq	%rbp
18000b95f:     	popq	%rbx
18000b960:     	retq
18000b961:     	movq	0x78(%rsp), %r13
18000b966:     	xorl	%eax, %eax
18000b968:     	addq	$0x38, %rsp
18000b96c:     	popq	%r15
18000b96e:     	popq	%rdi
18000b96f:     	popq	%rbp
18000b970:     	popq	%rbx
18000b971:     	retq
18000b972:     	int3
18000b973:     	int3
18000b974:     	int3
18000b975:     	int3
18000b976:     	int3
18000b977:     	int3
18000b978:     	int3
18000b979:     	int3
18000b97a:     	int3
18000b97b:     	int3
18000b97c:     	int3
18000b97d:     	int3
18000b97e:     	int3
18000b97f:     	int3

000000018000b980 <numba_list_iter_sizeof>:
18000b980:     	movl	$0x18, %eax
18000b985:     	retq
18000b986:     	int3
18000b987:     	int3
18000b988:     	int3
18000b989:     	int3
18000b98a:     	int3
18000b98b:     	int3
18000b98c:     	int3
18000b98d:     	int3
18000b98e:     	int3
18000b98f:     	int3

000000018000b990 <numba_list_iter>:
18000b990:     	movq	%rdx, (%rcx)
18000b993:     	movq	(%rdx), %rax
18000b996:     	movq	%rax, 0x8(%rcx)
18000b99a:     	movq	$0x0, 0x10(%rcx)
18000b9a2:     	retq
18000b9a3:     	int3
18000b9a4:     	int3
18000b9a5:     	int3
18000b9a6:     	int3
18000b9a7:     	int3
18000b9a8:     	int3
18000b9a9:     	int3
18000b9aa:     	int3
18000b9ab:     	int3
18000b9ac:     	int3
18000b9ad:     	int3
18000b9ae:     	int3
18000b9af:     	int3

000000018000b9b0 <numba_list_iter_next>:
18000b9b0:     	movq	(%rcx), %r8
18000b9b3:     	movq	(%r8), %r9
18000b9b6:     	cmpq	0x8(%rcx), %r9
18000b9ba:     	je	0x18000b9c2 <numba_list_iter_next+0x12>
18000b9bc:     	movl	$0xfffffffd, %eax       # imm = 0xFFFFFFFD
18000b9c1:     	retq
18000b9c2:     	movq	0x10(%rcx), %rax
18000b9c6:     	cmpq	%r9, %rax
18000b9c9:     	jge	0x18000b9de <numba_list_iter_next+0x2e>
18000b9cb:     	imulq	0x8(%r8), %rax
18000b9d0:     	addq	0x30(%r8), %rax
18000b9d4:     	movq	%rax, (%rdx)
18000b9d7:     	incq	0x10(%rcx)
18000b9db:     	xorl	%eax, %eax
18000b9dd:     	retq
18000b9de:     	movl	$0xfffffffc, %eax       # imm = 0xFFFFFFFC
18000b9e3:     	retq
18000b9e4:     	int3
18000b9e5:     	int3
18000b9e6:     	int3
18000b9e7:     	int3
18000b9e8:     	int3
18000b9e9:     	int3
18000b9ea:     	int3
18000b9eb:     	int3
18000b9ec:     	int3
18000b9ed:     	int3
18000b9ee:     	int3
18000b9ef:     	int3
18000b9f0:     	pushq	%rbx
18000b9f2:     	subq	$0x20, %rsp
18000b9f6:     	movq	%rcx, %rbx
18000b9f9:     	addq	$0x30, %rcx
18000b9fd:     	callq	*0x9265(%rip)           # 0x180014c68
18000ba03:     	cmpb	$0x0, 0x9236(%rip)      # 0x180014c40
18000ba0a:     	je	0x18000ba14 <numba_list_iter_next+0x64>
18000ba0c:     	lock
18000ba0d:     	incq	0x9234(%rip)            # 0x180014c48
18000ba14:     	testq	%rax, %rax
18000ba17:     	je	0x18000ba58 <numba_list_iter_next+0xa8>
18000ba19:     	leaq	0x30(%rax), %rdx
18000ba1d:     	testq	%rdx, %rdx
18000ba20:     	je	0x18000ba58 <numba_list_iter_next+0xa8>
18000ba22:     	xorl	%r8d, %r8d
18000ba25:     	movl	$0x1, %ecx
18000ba2a:     	xchgq	%rcx, (%rax)
18000ba2d:     	movq	%r8, 0x8(%rax)
18000ba31:     	movq	%r8, 0x10(%rax)
18000ba35:     	movq	%rdx, 0x18(%rax)
18000ba39:     	movq	%rbx, 0x20(%rax)
18000ba3d:     	movq	%r8, 0x28(%rax)
18000ba41:     	cmpb	%r8b, 0x91f8(%rip)      # 0x180014c40
18000ba48:     	je	0x18000ba5a <numba_list_iter_next+0xaa>
18000ba4a:     	lock
18000ba4b:     	incq	0x9206(%rip)            # 0x180014c58
18000ba52:     	addq	$0x20, %rsp
18000ba56:     	popq	%rbx
18000ba57:     	retq
18000ba58:     	xorl	%eax, %eax
18000ba5a:     	addq	$0x20, %rsp
18000ba5e:     	popq	%rbx
18000ba5f:     	retq
18000ba60:     	movq	%rbx, 0x8(%rsp)
18000ba65:     	pushq	%rdi
18000ba66:     	subq	$0x20, %rsp
18000ba6a:     	movq	%rcx, %rdi
18000ba6d:     	movq	%rdx, %rbx
18000ba70:     	addq	$0x30, %rcx
18000ba74:     	testq	%rdx, %rdx
18000ba77:     	je	0x18000ba81 <numba_list_iter_next+0xd1>
18000ba79:     	movq	0x18(%rdx), %rdx
18000ba7d:     	callq	*(%rbx)
18000ba7f:     	jmp	0x18000ba87 <numba_list_iter_next+0xd7>
18000ba81:     	callq	*0x91e1(%rip)           # 0x180014c68
18000ba87:     	cmpb	$0x0, 0x91b2(%rip)      # 0x180014c40
18000ba8e:     	movq	%rax, %r8
18000ba91:     	je	0x18000ba9b <numba_list_iter_next+0xeb>
18000ba93:     	lock
18000ba94:     	incq	0x91ad(%rip)            # 0x180014c48
18000ba9b:     	xorl	%edx, %edx
18000ba9d:     	leaq	0x30(%r8), %rax
18000baa1:     	testq	%r8, %r8
18000baa4:     	movl	%edx, %ecx
18000baa6:     	cmovneq	%rax, %rcx
18000baaa:     	testq	%rcx, %rcx
18000baad:     	jne	0x18000babc <numba_list_iter_next+0x10c>
18000baaf:     	xorl	%eax, %eax
18000bab1:     	movq	0x30(%rsp), %rbx
18000bab6:     	addq	$0x20, %rsp
18000baba:     	popq	%rdi
18000babb:     	retq
18000babc:     	movl	$0x1, %eax
18000bac1:     	xchgq	%rax, (%r8)
18000bac4:     	movq	%rdx, 0x8(%r8)
18000bac8:     	movq	%rdx, 0x10(%r8)
18000bacc:     	movq	%rcx, 0x18(%r8)
18000bad0:     	movq	%rdi, 0x20(%r8)
18000bad4:     	movq	%rbx, 0x28(%r8)
18000bad8:     	cmpb	%dl, 0x9162(%rip)       # 0x180014c40
18000bade:     	je	0x18000bae8 <numba_list_iter_next+0x138>
18000bae0:     	lock
18000bae1:     	incq	0x9170(%rip)            # 0x180014c58
18000bae8:     	movq	0x30(%rsp), %rbx
18000baed:     	movq	%r8, %rax
18000baf0:     	addq	$0x20, %rsp
18000baf4:     	popq	%rdi
18000baf5:     	retq
18000baf6:     	int3
18000baf7:     	int3
18000baf8:     	int3
18000baf9:     	int3
18000bafa:     	int3
18000bafb:     	int3
18000bafc:     	int3
18000bafd:     	int3
18000bafe:     	int3
18000baff:     	int3
18000bb00:     	lock
18000bb01:     	incq	(%rcx)
18000bb04:     	retq
18000bb05:     	int3
18000bb06:     	int3
18000bb07:     	int3
18000bb08:     	int3
18000bb09:     	int3
18000bb0a:     	int3
18000bb0b:     	int3
18000bb0c:     	int3
18000bb0d:     	int3
18000bb0e:     	int3
18000bb0f:     	int3
18000bb10:     	pushq	%rbx
18000bb12:     	subq	$0x20, %rsp
18000bb16:     	movq	0x8(%rcx), %rax
18000bb1a:     	movq	%rcx, %rbx
18000bb1d:     	testq	%rax, %rax
18000bb20:     	je	0x18000bb39 <numba_list_iter_next+0x189>
18000bb22:     	cmpl	$0x0, 0x910f(%rip)      # 0x180014c38
18000bb29:     	jne	0x18000bb39 <numba_list_iter_next+0x189>
18000bb2b:     	movq	0x10(%rcx), %r8
18000bb2f:     	movq	0x20(%rcx), %rdx
18000bb33:     	movq	0x18(%rcx), %rcx
18000bb37:     	callq	*%rax
18000bb39:     	movq	0x28(%rbx), %rax
18000bb3d:     	movq	%rbx, %rcx
18000bb40:     	testq	%rax, %rax
18000bb43:     	je	0x18000bb4e <numba_list_iter_next+0x19e>
18000bb45:     	movq	0x18(%rax), %rdx
18000bb49:     	callq	*0x10(%rax)
18000bb4c:     	jmp	0x18000bb54 <numba_list_iter_next+0x1a4>
18000bb4e:     	callq	*0x9124(%rip)           # 0x180014c78
18000bb54:     	cmpb	$0x0, 0x90e5(%rip)      # 0x180014c40
18000bb5b:     	je	0x18000bb79 <numba_list_iter_next+0x1c9>
18000bb5d:     	leaq	0x90ec(%rip), %rax      # 0x180014c50
18000bb64:     	lock
18000bb65:     	incq	(%rax)
18000bb68:     	cmpb	$0x0, 0x90d1(%rip)      # 0x180014c40
18000bb6f:     	je	0x18000bb79 <numba_list_iter_next+0x1c9>
18000bb71:     	lock
18000bb72:     	incq	0x90e7(%rip)            # 0x180014c60
18000bb79:     	addq	$0x20, %rsp
18000bb7d:     	popq	%rbx
18000bb7e:     	retq
18000bb7f:     	int3
18000bb80:     	pushq	%rbx
18000bb82:     	subq	$0x20, %rsp
18000bb86:     	movq	%rcx, %rbx
18000bb89:     	movq	$-0x1, %rax
18000bb90:     	lock
18000bb91:     	xaddq	%rax, (%rcx)
18000bb95:     	cmpq	$0x1, %rax
18000bb99:     	jne	0x18000bbfb <numba_list_iter_next+0x24b>
18000bb9b:     	movq	0x8(%rcx), %rax
18000bb9f:     	testq	%rax, %rax
18000bba2:     	je	0x18000bbbb <numba_list_iter_next+0x20b>
18000bba4:     	cmpl	$0x0, 0x908d(%rip)      # 0x180014c38
18000bbab:     	jne	0x18000bbbb <numba_list_iter_next+0x20b>
18000bbad:     	movq	0x10(%rcx), %r8
18000bbb1:     	movq	0x20(%rcx), %rdx
18000bbb5:     	movq	0x18(%rcx), %rcx
18000bbb9:     	callq	*%rax
18000bbbb:     	movq	0x28(%rbx), %rax
18000bbbf:     	movq	%rbx, %rcx
18000bbc2:     	testq	%rax, %rax
18000bbc5:     	je	0x18000bbd0 <numba_list_iter_next+0x220>
18000bbc7:     	movq	0x18(%rax), %rdx
18000bbcb:     	callq	*0x10(%rax)
18000bbce:     	jmp	0x18000bbd6 <numba_list_iter_next+0x226>
18000bbd0:     	callq	*0x90a2(%rip)           # 0x180014c78
18000bbd6:     	cmpb	$0x0, 0x9063(%rip)      # 0x180014c40
18000bbdd:     	je	0x18000bbfb <numba_list_iter_next+0x24b>
18000bbdf:     	leaq	0x906a(%rip), %rax      # 0x180014c50
18000bbe6:     	lock
18000bbe7:     	incq	(%rax)
18000bbea:     	cmpb	$0x0, 0x904f(%rip)      # 0x180014c40
18000bbf1:     	je	0x18000bbfb <numba_list_iter_next+0x24b>
18000bbf3:     	lock
18000bbf4:     	incq	0x9065(%rip)            # 0x180014c60
18000bbfb:     	addq	$0x20, %rsp
18000bbff:     	popq	%rbx
18000bc00:     	retq
18000bc01:     	int3
18000bc02:     	int3
18000bc03:     	int3
18000bc04:     	int3
18000bc05:     	int3
18000bc06:     	int3
18000bc07:     	int3
18000bc08:     	int3
18000bc09:     	int3
18000bc0a:     	int3
18000bc0b:     	int3
18000bc0c:     	int3
18000bc0d:     	int3
18000bc0e:     	int3
18000bc0f:     	int3
18000bc10:     	movq	0x18(%rcx), %rax
18000bc14:     	retq
18000bc15:     	int3
18000bc16:     	int3
18000bc17:     	int3
18000bc18:     	int3
18000bc19:     	int3
18000bc1a:     	int3
18000bc1b:     	int3
18000bc1c:     	int3
18000bc1d:     	int3
18000bc1e:     	int3
18000bc1f:     	int3
18000bc20:     	subq	$0x28, %rsp
18000bc24:     	callq	*0x904e(%rip)           # 0x180014c78
18000bc2a:     	cmpb	$0x0, 0x900f(%rip)      # 0x180014c40
18000bc31:     	je	0x18000bc3b <numba_list_iter_next+0x28b>
18000bc33:     	lock
18000bc34:     	incq	0x9015(%rip)            # 0x180014c50
18000bc3b:     	addq	$0x28, %rsp
18000bc3f:     	retq
18000bc40:     	jmpq	*%r8
18000bc43:     	int3
18000bc44:     	int3
18000bc45:     	int3
18000bc46:     	int3
18000bc47:     	int3
18000bc48:     	int3
18000bc49:     	int3
18000bc4a:     	int3
18000bc4b:     	int3
18000bc4c:     	int3
18000bc4d:     	int3
18000bc4e:     	int3
18000bc4f:     	int3
18000bc50:     	movq	%rbx, 0x8(%rsp)
18000bc55:     	pushq	%rdi
18000bc56:     	subq	$0x20, %rsp
18000bc5a:     	movq	%rcx, %rdi
18000bc5d:     	movq	%rdx, %rbx
18000bc60:     	movl	$0x30, %ecx
18000bc65:     	callq	*0x8ffd(%rip)           # 0x180014c68
18000bc6b:     	cmpb	$0x0, 0x8fce(%rip)      # 0x180014c40
18000bc72:     	je	0x18000bc7c <numba_list_iter_next+0x2cc>
18000bc74:     	lock
18000bc75:     	incq	0x8fcc(%rip)            # 0x180014c48
18000bc7c:     	testq	%rax, %rax
18000bc7f:     	je	0x18000bcb6 <numba_list_iter_next+0x306>
18000bc81:     	leaq	-0x48(%rip), %rcx       # 0x18000bc40 <numba_list_iter_next+0x290>
18000bc88:     	movl	$0x1, %edx
18000bc8d:     	xchgq	%rdx, (%rax)
18000bc90:     	movq	%rcx, 0x8(%rax)
18000bc94:     	xorl	%ecx, %ecx
18000bc96:     	movq	%rcx, 0x20(%rax)
18000bc9a:     	movq	%rcx, 0x28(%rax)
18000bc9e:     	movq	%rbx, 0x10(%rax)
18000bca2:     	movq	%rdi, 0x18(%rax)
18000bca6:     	cmpb	%cl, 0x8f94(%rip)       # 0x180014c40
18000bcac:     	je	0x18000bcb6 <numba_list_iter_next+0x306>
18000bcae:     	lock
18000bcaf:     	incq	0x8fa2(%rip)            # 0x180014c58
18000bcb6:     	movq	0x30(%rsp), %rbx
18000bcbb:     	addq	$0x20, %rsp
18000bcbf:     	popq	%rdi
18000bcc0:     	retq
18000bcc1:     	jmpq	*0x1649(%rip)           # 0x18000d310
18000bcc7:     	jmpq	*0x1633(%rip)           # 0x18000d300
18000bccd:     	jmpq	*0x1625(%rip)           # 0x18000d2f8
18000bcd3:     	jmpq	*0x1617(%rip)           # 0x18000d2f0
18000bcd9:     	jmpq	*0x1609(%rip)           # 0x18000d2e8
18000bcdf:     	jmpq	*0x15fb(%rip)           # 0x18000d2e0
18000bce5:     	jmpq	*0x15ed(%rip)           # 0x18000d2d8
18000bceb:     	jmpq	*0x15d7(%rip)           # 0x18000d2c8
18000bcf1:     	jmpq	*0x15c9(%rip)           # 0x18000d2c0
18000bcf7:     	jmpq	*0x15bb(%rip)           # 0x18000d2b8
18000bcfd:     	jmpq	*0x15a5(%rip)           # 0x18000d2a8
18000bd03:     	jmpq	*0x157f(%rip)           # 0x18000d288
18000bd09:     	jmpq	*0x1571(%rip)           # 0x18000d280
18000bd0f:     	jmpq	*0x1563(%rip)           # 0x18000d278
18000bd15:     	jmpq	*0x1555(%rip)           # 0x18000d270
18000bd1b:     	jmpq	*0x150f(%rip)           # 0x18000d230
18000bd21:     	int3
18000bd22:     	int3
18000bd23:     	int3
18000bd24:     	int3
18000bd25:     	int3
18000bd26:     	int3
18000bd27:     	int3
18000bd28:     	int3
18000bd29:     	int3
18000bd2a:     	int3
18000bd2b:     	int3
18000bd2c:     	int3
18000bd2d:     	int3
18000bd2e:     	int3
18000bd2f:     	int3
18000bd30:     	int3
18000bd31:     	int3
18000bd32:     	int3
18000bd33:     	int3
18000bd34:     	int3
18000bd35:     	int3
18000bd36:     	nopw	(%rax,%rax)
18000bd40:     	cmpq	0x83b9(%rip), %rcx      # 0x180014100
18000bd47:     	jne	0x18000bd59 <numba_list_iter_next+0x3a9>
18000bd49:     	rolq	$0x10, %rcx
18000bd4d:     	testw	$0xffff, %cx            # imm = 0xFFFF
18000bd52:     	jne	0x18000bd55 <numba_list_iter_next+0x3a5>
18000bd54:     	retq
18000bd55:     	rorq	$0x10, %rcx
18000bd59:     	jmp	0x18000c0b4 <numba_list_iter_next+0x704>
18000bd5e:     	int3
18000bd5f:     	int3
18000bd60:     	subq	$0x28, %rsp
18000bd64:     	testl	%edx, %edx
18000bd66:     	je	0x18000bda1 <numba_list_iter_next+0x3f1>
18000bd68:     	subl	$0x1, %edx
18000bd6b:     	je	0x18000bd95 <numba_list_iter_next+0x3e5>
18000bd6d:     	subl	$0x1, %edx
18000bd70:     	je	0x18000bd88 <numba_list_iter_next+0x3d8>
18000bd72:     	cmpl	$0x1, %edx
18000bd75:     	je	0x18000bd81 <numba_list_iter_next+0x3d1>
18000bd77:     	movl	$0x1, %eax
18000bd7c:     	addq	$0x28, %rsp
18000bd80:     	retq
18000bd81:     	callq	0x18000c280 <numba_list_iter_next+0x8d0>
18000bd86:     	jmp	0x18000bd8d <numba_list_iter_next+0x3dd>
18000bd88:     	callq	0x18000c258 <numba_list_iter_next+0x8a8>
18000bd8d:     	movzbl	%al, %eax
18000bd90:     	addq	$0x28, %rsp
18000bd94:     	retq
18000bd95:     	movq	%r8, %rdx
18000bd98:     	addq	$0x28, %rsp
18000bd9c:     	jmp	0x18000bdb0 <numba_list_iter_next+0x400>
18000bda1:     	testq	%r8, %r8
18000bda4:     	setne	%cl
18000bda7:     	addq	$0x28, %rsp
18000bdab:     	jmp	0x18000bec8 <numba_list_iter_next+0x518>
18000bdb0:     	movq	%rbx, 0x8(%rsp)
18000bdb5:     	movq	%rsi, 0x10(%rsp)
18000bdba:     	movq	%rdi, 0x20(%rsp)
18000bdbf:     	pushq	%r14
18000bdc1:     	subq	$0x20, %rsp
18000bdc5:     	movq	%rdx, %rsi
18000bdc8:     	movq	%rcx, %r14
18000bdcb:     	xorl	%ecx, %ecx
18000bdcd:     	callq	0x18000c33c <numba_list_iter_next+0x98c>
18000bdd2:     	testb	%al, %al
18000bdd4:     	je	0x18000bea2 <numba_list_iter_next+0x4f2>
18000bdda:     	callq	0x18000c1d0 <numba_list_iter_next+0x820>
18000bddf:     	movb	%al, %bl
18000bde1:     	movb	%al, 0x40(%rsp)
18000bde5:     	movb	$0x1, %dil
18000bde8:     	cmpl	$0x0, 0x8c19(%rip)      # 0x180014a08
18000bdef:     	jne	0x18000beba <numba_list_iter_next+0x50a>
18000bdf5:     	movl	$0x1, 0x8c09(%rip)      # 0x180014a08
18000bdff:     	callq	0x18000c240 <numba_list_iter_next+0x890>
18000be04:     	testb	%al, %al
18000be06:     	je	0x18000be57 <numba_list_iter_next+0x4a7>
18000be08:     	callq	0x18000c4fc <numba_list_iter_next+0xb4c>
18000be0d:     	callq	0x18000c190 <numba_list_iter_next+0x7e0>
18000be12:     	callq	0x18000c1b4 <numba_list_iter_next+0x804>
18000be17:     	leaq	0x1552(%rip), %rdx      # 0x18000d370
18000be1e:     	leaq	0x1543(%rip), %rcx      # 0x18000d368
18000be25:     	callq	0x18000c842 <numba_list_iter_next+0xe92>
18000be2a:     	testl	%eax, %eax
18000be2c:     	jne	0x18000be57 <numba_list_iter_next+0x4a7>
18000be2e:     	callq	0x18000c20c <numba_list_iter_next+0x85c>
18000be33:     	testb	%al, %al
18000be35:     	je	0x18000be57 <numba_list_iter_next+0x4a7>
18000be37:     	leaq	0x1522(%rip), %rdx      # 0x18000d360
18000be3e:     	leaq	0x1513(%rip), %rcx      # 0x18000d358
18000be45:     	callq	0x18000c83c <numba_list_iter_next+0xe8c>
18000be4a:     	movl	$0x2, 0x8bb4(%rip)      # 0x180014a08
18000be54:     	xorb	%dil, %dil
18000be57:     	movb	%bl, %cl
18000be59:     	callq	0x18000c49c <numba_list_iter_next+0xaec>
18000be5e:     	testb	%dil, %dil
18000be61:     	jne	0x18000bea2 <numba_list_iter_next+0x4f2>
18000be63:     	callq	0x18000c4ec <numba_list_iter_next+0xb3c>
18000be68:     	movq	%rax, %rbx
18000be6b:     	cmpq	$0x0, (%rax)
18000be6f:     	je	0x18000be95 <numba_list_iter_next+0x4e5>
18000be71:     	movq	%rax, %rcx
18000be74:     	callq	0x18000c404 <numba_list_iter_next+0xa54>
18000be79:     	testb	%al, %al
18000be7b:     	je	0x18000be95 <numba_list_iter_next+0x4e5>
18000be7d:     	movq	%rsi, %r8
18000be80:     	movl	$0x2, %edx
18000be85:     	movq	%r14, %rcx
18000be88:     	movq	(%rbx), %rax
18000be8b:     	movq	0x149e(%rip), %r9       # 0x18000d330
18000be92:     	callq	*%r9
18000be95:     	incl	0x8b45(%rip)            # 0x1800149e0
18000be9b:     	movl	$0x1, %eax
18000bea0:     	jmp	0x18000bea4 <numba_list_iter_next+0x4f4>
18000bea2:     	xorl	%eax, %eax
18000bea4:     	movq	0x30(%rsp), %rbx
18000bea9:     	movq	0x38(%rsp), %rsi
18000beae:     	movq	0x48(%rsp), %rdi
18000beb3:     	addq	$0x20, %rsp
18000beb7:     	popq	%r14
18000beb9:     	retq
18000beba:     	movl	$0x7, %ecx
18000bebf:     	callq	0x18000c4f4 <numba_list_iter_next+0xb44>
18000bec4:     	nop
18000bec5:     	int3
18000bec6:     	int3
18000bec7:     	int3
18000bec8:     	movq	%rbx, 0x8(%rsp)
18000becd:     	pushq	%rdi
18000bece:     	subq	$0x30, %rsp
18000bed2:     	movb	%cl, %dil
18000bed5:     	movl	0x8b05(%rip), %eax      # 0x1800149e0
18000bedb:     	testl	%eax, %eax
18000bedd:     	jg	0x18000beec <numba_list_iter_next+0x53c>
18000bedf:     	xorl	%eax, %eax
18000bee1:     	movq	0x40(%rsp), %rbx
18000bee6:     	addq	$0x30, %rsp
18000beea:     	popq	%rdi
18000beeb:     	retq
18000beec:     	decl	%eax
18000beee:     	movl	%eax, 0x8aec(%rip)      # 0x1800149e0
18000bef4:     	callq	0x18000c1d0 <numba_list_iter_next+0x820>
18000bef9:     	movb	%al, %bl
18000befb:     	movb	%al, 0x20(%rsp)
18000beff:     	cmpl	$0x2, 0x8b02(%rip)      # 0x180014a08
18000bf06:     	jne	0x18000bf3e <numba_list_iter_next+0x58e>
18000bf08:     	callq	0x18000c2f8 <numba_list_iter_next+0x948>
18000bf0d:     	callq	0x18000c1a0 <numba_list_iter_next+0x7f0>
18000bf12:     	callq	0x18000c538 <numba_list_iter_next+0xb88>
18000bf17:     	movl	$0x0, 0x8ae7(%rip)      # 0x180014a08
18000bf21:     	movb	%bl, %cl
18000bf23:     	callq	0x18000c49c <numba_list_iter_next+0xaec>
18000bf28:     	xorl	%edx, %edx
18000bf2a:     	movb	%dil, %cl
18000bf2d:     	callq	0x18000c4c0 <numba_list_iter_next+0xb10>
18000bf32:     	movzbl	%al, %ebx
18000bf35:     	callq	0x18000c328 <numba_list_iter_next+0x978>
18000bf3a:     	movl	%ebx, %eax
18000bf3c:     	jmp	0x18000bee1 <numba_list_iter_next+0x531>
18000bf3e:     	movl	$0x7, %ecx
18000bf43:     	callq	0x18000c4f4 <numba_list_iter_next+0xb44>
18000bf48:     	nop
18000bf49:     	nop
18000bf4a:     	int3
18000bf4b:     	int3
18000bf4c:     	movq	%rsp, %rax
18000bf4f:     	movq	%rbx, 0x20(%rax)
18000bf53:     	movq	%r8, 0x18(%rax)
18000bf57:     	movl	%edx, 0x10(%rax)
18000bf5a:     	movq	%rcx, 0x8(%rax)
18000bf5e:     	pushq	%rsi
18000bf5f:     	pushq	%rdi
18000bf60:     	pushq	%r14
18000bf62:     	subq	$0x40, %rsp
18000bf66:     	movq	%r8, %rsi
18000bf69:     	movl	%edx, %edi
18000bf6b:     	movq	%rcx, %r14
18000bf6e:     	testl	%edx, %edx
18000bf70:     	jne	0x18000bf81 <numba_list_iter_next+0x5d1>
18000bf72:     	cmpl	%edx, 0x8a68(%rip)      # 0x1800149e0
18000bf78:     	jg	0x18000bf81 <numba_list_iter_next+0x5d1>
18000bf7a:     	xorl	%eax, %eax
18000bf7c:     	jmp	0x18000c066 <numba_list_iter_next+0x6b6>
18000bf81:     	leal	-0x1(%rdx), %eax
18000bf84:     	cmpl	$0x1, %eax
18000bf87:     	ja	0x18000bfc9 <numba_list_iter_next+0x619>
18000bf89:     	movq	0x1b98(%rip), %rax      # 0x18000db28
18000bf90:     	testq	%rax, %rax
18000bf93:     	jne	0x18000bf9a <numba_list_iter_next+0x5ea>
18000bf95:     	leal	0x1(%rax), %ebx
18000bf98:     	jmp	0x18000bfa2 <numba_list_iter_next+0x5f2>
18000bf9a:     	callq	*0x1390(%rip)           # 0x18000d330
18000bfa0:     	movl	%eax, %ebx
18000bfa2:     	movl	%ebx, 0x30(%rsp)
18000bfa6:     	testl	%ebx, %ebx
18000bfa8:     	je	0x18000c05c <numba_list_iter_next+0x6ac>
18000bfae:     	movq	%rsi, %r8
18000bfb1:     	movl	%edi, %edx
18000bfb3:     	movq	%r14, %rcx
18000bfb6:     	callq	0x18000bd60 <numba_list_iter_next+0x3b0>
18000bfbb:     	movl	%eax, %ebx
18000bfbd:     	movl	%eax, 0x30(%rsp)
18000bfc1:     	testl	%eax, %eax
18000bfc3:     	je	0x18000c05c <numba_list_iter_next+0x6ac>
18000bfc9:     	movq	%rsi, %r8
18000bfcc:     	movl	%edi, %edx
18000bfce:     	movq	%r14, %rcx
18000bfd1:     	callq	0x18000c16c <numba_list_iter_next+0x7bc>
18000bfd6:     	movl	%eax, %ebx
18000bfd8:     	movl	%eax, 0x30(%rsp)
18000bfdc:     	cmpl	$0x1, %edi
18000bfdf:     	jne	0x18000c017 <numba_list_iter_next+0x667>
18000bfe1:     	testl	%eax, %eax
18000bfe3:     	jne	0x18000c017 <numba_list_iter_next+0x667>
18000bfe5:     	movq	%rsi, %r8
18000bfe8:     	xorl	%edx, %edx
18000bfea:     	movq	%r14, %rcx
18000bfed:     	callq	0x18000c16c <numba_list_iter_next+0x7bc>
18000bff2:     	testq	%rsi, %rsi
18000bff5:     	setne	%cl
18000bff8:     	callq	0x18000bec8 <numba_list_iter_next+0x518>
18000bffd:     	movq	0x1b24(%rip), %rax      # 0x18000db28
18000c004:     	testq	%rax, %rax
18000c007:     	je	0x18000c017 <numba_list_iter_next+0x667>
18000c009:     	movq	%rsi, %r8
18000c00c:     	xorl	%edx, %edx
18000c00e:     	movq	%r14, %rcx
18000c011:     	callq	*0x1319(%rip)           # 0x18000d330
18000c017:     	testl	%edi, %edi
18000c019:     	je	0x18000c020 <numba_list_iter_next+0x670>
18000c01b:     	cmpl	$0x3, %edi
18000c01e:     	jne	0x18000c05c <numba_list_iter_next+0x6ac>
18000c020:     	movq	%rsi, %r8
18000c023:     	movl	%edi, %edx
18000c025:     	movq	%r14, %rcx
18000c028:     	callq	0x18000bd60 <numba_list_iter_next+0x3b0>
18000c02d:     	movl	%eax, %ebx
18000c02f:     	movl	%eax, 0x30(%rsp)
18000c033:     	testl	%eax, %eax
18000c035:     	je	0x18000c05c <numba_list_iter_next+0x6ac>
18000c037:     	movq	0x1aea(%rip), %rax      # 0x18000db28
18000c03e:     	testq	%rax, %rax
18000c041:     	jne	0x18000c048 <numba_list_iter_next+0x698>
18000c043:     	leal	0x1(%rax), %ebx
18000c046:     	jmp	0x18000c058 <numba_list_iter_next+0x6a8>
18000c048:     	movq	%rsi, %r8
18000c04b:     	movl	%edi, %edx
18000c04d:     	movq	%r14, %rcx
18000c050:     	callq	*0x12da(%rip)           # 0x18000d330
18000c056:     	movl	%eax, %ebx
18000c058:     	movl	%ebx, 0x30(%rsp)
18000c05c:     	jmp	0x18000c064 <numba_list_iter_next+0x6b4>
18000c05e:     	xorl	%ebx, %ebx
18000c060:     	movl	%ebx, 0x30(%rsp)
18000c064:     	movl	%ebx, %eax
18000c066:     	movq	0x78(%rsp), %rbx
18000c06b:     	addq	$0x40, %rsp
18000c06f:     	popq	%r14
18000c071:     	popq	%rdi
18000c072:     	popq	%rsi
18000c073:     	retq
18000c074:     	movq	%rbx, 0x8(%rsp)
18000c079:     	movq	%rsi, 0x10(%rsp)
18000c07e:     	pushq	%rdi
18000c07f:     	subq	$0x20, %rsp
18000c083:     	movq	%r8, %rdi
18000c086:     	movl	%edx, %ebx
18000c088:     	movq	%rcx, %rsi
18000c08b:     	cmpl	$0x1, %edx
18000c08e:     	jne	0x18000c095 <numba_list_iter_next+0x6e5>
18000c090:     	callq	0x18000c0bc <numba_list_iter_next+0x70c>
18000c095:     	movq	%rdi, %r8
18000c098:     	movl	%ebx, %edx
18000c09a:     	movq	%rsi, %rcx
18000c09d:     	movq	0x30(%rsp), %rbx
18000c0a2:     	movq	0x38(%rsp), %rsi
18000c0a7:     	addq	$0x20, %rsp
18000c0ab:     	popq	%rdi
18000c0ac:     	jmp	0x18000bf4c <numba_list_iter_next+0x59c>
18000c0b1:     	int3
18000c0b2:     	int3
18000c0b3:     	int3
18000c0b4:     	movl	$0x2, %ecx
18000c0b9:     	int	$0x29
18000c0bb:     	retq
18000c0bc:     	movq	%rbx, 0x18(%rsp)
18000c0c1:     	pushq	%rbp
18000c0c2:     	movq	%rsp, %rbp
18000c0c5:     	subq	$0x30, %rsp
18000c0c9:     	movq	0x8030(%rip), %rax      # 0x180014100
18000c0d0:     	movabsq	$0x2b992ddfa232, %rbx   # imm = 0x2B992DDFA232
18000c0da:     	cmpq	%rbx, %rax
18000c0dd:     	jne	0x18000c156 <numba_list_iter_next+0x7a6>
18000c0df:     	leaq	0x10(%rbp), %rcx
18000c0e3:     	movq	$0x0, 0x10(%rbp)
18000c0eb:     	callq	*0xf2f(%rip)            # 0x18000d020
18000c0f1:     	movq	0x10(%rbp), %rax
18000c0f5:     	movq	%rax, -0x10(%rbp)
18000c0f9:     	callq	*0xf19(%rip)            # 0x18000d018
18000c0ff:     	movl	%eax, %eax
18000c101:     	xorq	%rax, -0x10(%rbp)
18000c105:     	callq	*0xf05(%rip)            # 0x18000d010
18000c10b:     	movl	%eax, %eax
18000c10d:     	leaq	0x18(%rbp), %rcx
18000c111:     	xorq	%rax, -0x10(%rbp)
18000c115:     	callq	*0xee5(%rip)            # 0x18000d000
18000c11b:     	movl	0x18(%rbp), %eax
18000c11e:     	leaq	-0x10(%rbp), %rcx
18000c122:     	shlq	$0x20, %rax
18000c126:     	xorq	0x18(%rbp), %rax
18000c12a:     	xorq	-0x10(%rbp), %rax
18000c12e:     	xorq	%rcx, %rax
18000c131:     	movabsq	$0xffffffffffff, %rcx   # imm = 0xFFFFFFFFFFFF
18000c13b:     	andq	%rcx, %rax
18000c13e:     	movabsq	$0x2b992ddfa233, %rcx   # imm = 0x2B992DDFA233
18000c148:     	cmpq	%rbx, %rax
18000c14b:     	cmoveq	%rcx, %rax
18000c14f:     	movq	%rax, 0x7faa(%rip)      # 0x180014100
18000c156:     	movq	0x50(%rsp), %rbx
18000c15b:     	notq	%rax
18000c15e:     	movq	%rax, 0x7fdb(%rip)      # 0x180014140
18000c165:     	addq	$0x30, %rsp
18000c169:     	popq	%rbp
18000c16a:     	retq
18000c16b:     	int3
18000c16c:     	subq	$0x28, %rsp
18000c170:     	cmpl	$0x1, %edx
18000c173:     	jne	0x18000c185 <numba_list_iter_next+0x7d5>
18000c175:     	cmpq	$0x0, 0x19ab(%rip)      # 0x18000db28
18000c17d:     	jne	0x18000c185 <numba_list_iter_next+0x7d5>
18000c17f:     	callq	*0xea3(%rip)            # 0x18000d028
18000c185:     	movl	$0x1, %eax
18000c18a:     	addq	$0x28, %rsp
18000c18e:     	retq
18000c18f:     	int3
18000c190:     	leaq	0x8859(%rip), %rcx      # 0x1800149f0
18000c197:     	jmpq	*0xe6a(%rip)            # 0x18000d008
18000c19e:     	int3
18000c19f:     	int3
18000c1a0:     	leaq	0x8849(%rip), %rcx      # 0x1800149f0
18000c1a7:     	jmp	0x18000c836 <numba_list_iter_next+0xe86>
18000c1ac:     	leaq	0x884d(%rip), %rax      # 0x180014a00
18000c1b3:     	retq
18000c1b4:     	subq	$0x28, %rsp
18000c1b8:     	callq	0x18000b2c0 <PyInit_rcaotr_2fe5e05e91a653421cd9997e+0x7700>
18000c1bd:     	orq	$0x24, (%rax)
18000c1c1:     	callq	0x18000c1ac <numba_list_iter_next+0x7fc>
18000c1c6:     	orq	$0x2, (%rax)
18000c1ca:     	addq	$0x28, %rsp
18000c1ce:     	retq
18000c1cf:     	int3
18000c1d0:     	subq	$0x28, %rsp
18000c1d4:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c1d9:     	testl	%eax, %eax
18000c1db:     	je	0x18000c1fe <numba_list_iter_next+0x84e>
18000c1dd:     	movq	%gs:0x30, %rax
18000c1e6:     	movq	0x8(%rax), %rcx
18000c1ea:     	jmp	0x18000c1f1 <numba_list_iter_next+0x841>
18000c1ec:     	cmpq	%rax, %rcx
18000c1ef:     	je	0x18000c205 <numba_list_iter_next+0x855>
18000c1f1:     	xorl	%eax, %eax
18000c1f3:     	lock
18000c1f4:     	cmpxchgq	%rcx, 0x8814(%rip)      # 0x180014a10
18000c1fc:     	jne	0x18000c1ec <numba_list_iter_next+0x83c>
18000c1fe:     	xorb	%al, %al
18000c200:     	addq	$0x28, %rsp
18000c204:     	retq
18000c205:     	movb	$0x1, %al
18000c207:     	jmp	0x18000c200 <numba_list_iter_next+0x850>
18000c209:     	int3
18000c20a:     	int3
18000c20b:     	int3
18000c20c:     	subq	$0x28, %rsp
18000c210:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c215:     	testl	%eax, %eax
18000c217:     	je	0x18000c220 <numba_list_iter_next+0x870>
18000c219:     	callq	0x18000c578 <numba_list_iter_next+0xbc8>
18000c21e:     	jmp	0x18000c239 <numba_list_iter_next+0x889>
18000c220:     	callq	0x18000c814 <numba_list_iter_next+0xe64>
18000c225:     	movl	%eax, %ecx
18000c227:     	callq	0x18000c84e <numba_list_iter_next+0xe9e>
18000c22c:     	testl	%eax, %eax
18000c22e:     	je	0x18000c234 <numba_list_iter_next+0x884>
18000c230:     	xorb	%al, %al
18000c232:     	jmp	0x18000c23b <numba_list_iter_next+0x88b>
18000c234:     	callq	0x18000c854 <numba_list_iter_next+0xea4>
18000c239:     	movb	$0x1, %al
18000c23b:     	addq	$0x28, %rsp
18000c23f:     	retq
18000c240:     	subq	$0x28, %rsp
18000c244:     	xorl	%ecx, %ecx
18000c246:     	callq	0x18000c378 <numba_list_iter_next+0x9c8>
18000c24b:     	testb	%al, %al
18000c24d:     	setne	%al
18000c250:     	addq	$0x28, %rsp
18000c254:     	retq
18000c255:     	int3
18000c256:     	int3
18000c257:     	int3
18000c258:     	subq	$0x28, %rsp
18000c25c:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c261:     	testb	%al, %al
18000c263:     	jne	0x18000c269 <numba_list_iter_next+0x8b9>
18000c265:     	xorb	%al, %al
18000c267:     	jmp	0x18000c27b <numba_list_iter_next+0x8cb>
18000c269:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c26e:     	testb	%al, %al
18000c270:     	jne	0x18000c279 <numba_list_iter_next+0x8c9>
18000c272:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c277:     	jmp	0x18000c265 <numba_list_iter_next+0x8b5>
18000c279:     	movb	$0x1, %al
18000c27b:     	addq	$0x28, %rsp
18000c27f:     	retq
18000c280:     	subq	$0x28, %rsp
18000c284:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c289:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c28e:     	movb	$0x1, %al
18000c290:     	addq	$0x28, %rsp
18000c294:     	retq
18000c295:     	int3
18000c296:     	int3
18000c297:     	int3
18000c298:     	movq	%rbx, 0x8(%rsp)
18000c29d:     	movq	%rbp, 0x10(%rsp)
18000c2a2:     	movq	%rsi, 0x18(%rsp)
18000c2a7:     	pushq	%rdi
18000c2a8:     	subq	$0x20, %rsp
18000c2ac:     	movq	%r9, %rdi
18000c2af:     	movq	%r8, %rsi
18000c2b2:     	movl	%edx, %ebx
18000c2b4:     	movq	%rcx, %rbp
18000c2b7:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c2bc:     	testl	%eax, %eax
18000c2be:     	jne	0x18000c2d6 <numba_list_iter_next+0x926>
18000c2c0:     	cmpl	$0x1, %ebx
18000c2c3:     	jne	0x18000c2d6 <numba_list_iter_next+0x926>
18000c2c5:     	movq	%rsi, %r8
18000c2c8:     	xorl	%edx, %edx
18000c2ca:     	movq	%rbp, %rcx
18000c2cd:     	movq	%rdi, %rax
18000c2d0:     	callq	*0x105a(%rip)           # 0x18000d330
18000c2d6:     	movq	0x58(%rsp), %rdx
18000c2db:     	movl	0x50(%rsp), %ecx
18000c2df:     	movq	0x30(%rsp), %rbx
18000c2e4:     	movq	0x38(%rsp), %rbp
18000c2e9:     	movq	0x40(%rsp), %rsi
18000c2ee:     	addq	$0x20, %rsp
18000c2f2:     	popq	%rdi
18000c2f3:     	jmp	0x18000c848 <numba_list_iter_next+0xe98>
18000c2f8:     	subq	$0x28, %rsp
18000c2fc:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c301:     	testl	%eax, %eax
18000c303:     	je	0x18000c315 <numba_list_iter_next+0x965>
18000c305:     	leaq	0x8714(%rip), %rcx      # 0x180014a20
18000c30c:     	addq	$0x28, %rsp
18000c310:     	jmp	0x18000c860 <numba_list_iter_next+0xeb0>
18000c315:     	callq	0x18000c870 <numba_list_iter_next+0xec0>
18000c31a:     	testl	%eax, %eax
18000c31c:     	jne	0x18000c323 <numba_list_iter_next+0x973>
18000c31e:     	callq	0x18000c866 <numba_list_iter_next+0xeb6>
18000c323:     	addq	$0x28, %rsp
18000c327:     	retq
18000c328:     	subq	$0x28, %rsp
18000c32c:     	xorl	%ecx, %ecx
18000c32e:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c333:     	addq	$0x28, %rsp
18000c337:     	jmp	0x18000c86c <numba_list_iter_next+0xebc>
18000c33c:     	subq	$0x28, %rsp
18000c340:     	testl	%ecx, %ecx
18000c342:     	jne	0x18000c34b <numba_list_iter_next+0x99b>
18000c344:     	movb	$0x1, 0x86cd(%rip)      # 0x180014a18
18000c34b:     	callq	0x18000c578 <numba_list_iter_next+0xbc8>
18000c350:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c355:     	testb	%al, %al
18000c357:     	jne	0x18000c35d <numba_list_iter_next+0x9ad>
18000c359:     	xorb	%al, %al
18000c35b:     	jmp	0x18000c371 <numba_list_iter_next+0x9c1>
18000c35d:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c362:     	testb	%al, %al
18000c364:     	jne	0x18000c36f <numba_list_iter_next+0x9bf>
18000c366:     	xorl	%ecx, %ecx
18000c368:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c36d:     	jmp	0x18000c359 <numba_list_iter_next+0x9a9>
18000c36f:     	movb	$0x1, %al
18000c371:     	addq	$0x28, %rsp
18000c375:     	retq
18000c376:     	int3
18000c377:     	int3
18000c378:     	pushq	%rbx
18000c37a:     	subq	$0x20, %rsp
18000c37e:     	cmpb	$0x0, 0x8694(%rip)      # 0x180014a19
18000c385:     	movl	%ecx, %ebx
18000c387:     	jne	0x18000c3f0 <numba_list_iter_next+0xa40>
18000c389:     	cmpl	$0x1, %ecx
18000c38c:     	ja	0x18000c3f8 <numba_list_iter_next+0xa48>
18000c38e:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c393:     	testl	%eax, %eax
18000c395:     	je	0x18000c3bf <numba_list_iter_next+0xa0f>
18000c397:     	testl	%ebx, %ebx
18000c399:     	jne	0x18000c3bf <numba_list_iter_next+0xa0f>
18000c39b:     	leaq	0x867e(%rip), %rcx      # 0x180014a20
18000c3a2:     	callq	0x18000c85a <numba_list_iter_next+0xeaa>
18000c3a7:     	testl	%eax, %eax
18000c3a9:     	jne	0x18000c3bb <numba_list_iter_next+0xa0b>
18000c3ab:     	leaq	0x8686(%rip), %rcx      # 0x180014a38
18000c3b2:     	callq	0x18000c85a <numba_list_iter_next+0xeaa>
18000c3b7:     	testl	%eax, %eax
18000c3b9:     	je	0x18000c3e9 <numba_list_iter_next+0xa39>
18000c3bb:     	xorb	%al, %al
18000c3bd:     	jmp	0x18000c3f2 <numba_list_iter_next+0xa42>
18000c3bf:     	movdqa	0x1769(%rip), %xmm0     # 0x18000db30
18000c3c7:     	orq	$-0x1, %rax
18000c3cb:     	movdqu	%xmm0, 0x864d(%rip)     # 0x180014a20
18000c3d3:     	movq	%rax, 0x8656(%rip)      # 0x180014a30
18000c3da:     	movdqu	%xmm0, 0x8656(%rip)     # 0x180014a38
18000c3e2:     	movq	%rax, 0x865f(%rip)      # 0x180014a48
18000c3e9:     	movb	$0x1, 0x8629(%rip)      # 0x180014a19
18000c3f0:     	movb	$0x1, %al
18000c3f2:     	addq	$0x20, %rsp
18000c3f6:     	popq	%rbx
18000c3f7:     	retq
18000c3f8:     	movl	$0x5, %ecx
18000c3fd:     	callq	0x18000c4f4 <numba_list_iter_next+0xb44>
18000c402:     	int3
18000c403:     	int3
18000c404:     	subq	$0x18, %rsp
18000c408:     	movq	%rcx, %r8
18000c40b:     	movl	$0x5a4d, %eax           # imm = 0x5A4D
18000c410:     	cmpw	%ax, -0xc417(%rip)      # 0x180000000
18000c417:     	jne	0x18000c491 <numba_list_iter_next+0xae1>
18000c419:     	movslq	-0xc3e4(%rip), %rcx     # 0x18000003c
18000c420:     	leaq	-0xc427(%rip), %rdx     # 0x180000000
18000c427:     	addq	%rdx, %rcx
18000c42a:     	cmpl	$0x4550, (%rcx)         # imm = 0x4550
18000c430:     	jne	0x18000c491 <numba_list_iter_next+0xae1>
18000c432:     	movl	$0x20b, %eax            # imm = 0x20B
18000c437:     	cmpw	%ax, 0x18(%rcx)
18000c43b:     	jne	0x18000c491 <numba_list_iter_next+0xae1>
18000c43d:     	subq	%rdx, %r8
18000c440:     	movzwl	0x14(%rcx), %edx
18000c444:     	addq	$0x18, %rdx
18000c448:     	addq	%rcx, %rdx
18000c44b:     	movzwl	0x6(%rcx), %eax
18000c44f:     	leaq	(%rax,%rax,4), %rcx
18000c453:     	leaq	(%rdx,%rcx,8), %r9
18000c457:     	movq	%rdx, (%rsp)
18000c45b:     	cmpq	%r9, %rdx
18000c45e:     	je	0x18000c478 <numba_list_iter_next+0xac8>
18000c460:     	movl	0xc(%rdx), %ecx
18000c463:     	cmpq	%rcx, %r8
18000c466:     	jb	0x18000c472 <numba_list_iter_next+0xac2>
18000c468:     	movl	0x8(%rdx), %eax
18000c46b:     	addl	%ecx, %eax
18000c46d:     	cmpq	%rax, %r8
18000c470:     	jb	0x18000c47a <numba_list_iter_next+0xaca>
18000c472:     	addq	$0x28, %rdx
18000c476:     	jmp	0x18000c457 <numba_list_iter_next+0xaa7>
18000c478:     	xorl	%edx, %edx
18000c47a:     	testq	%rdx, %rdx
18000c47d:     	jne	0x18000c483 <numba_list_iter_next+0xad3>
18000c47f:     	xorb	%al, %al
18000c481:     	jmp	0x18000c497 <numba_list_iter_next+0xae7>
18000c483:     	cmpl	$0x0, 0x24(%rdx)
18000c487:     	jge	0x18000c48d <numba_list_iter_next+0xadd>
18000c489:     	xorb	%al, %al
18000c48b:     	jmp	0x18000c497 <numba_list_iter_next+0xae7>
18000c48d:     	movb	$0x1, %al
18000c48f:     	jmp	0x18000c497 <numba_list_iter_next+0xae7>
18000c491:     	xorb	%al, %al
18000c493:     	jmp	0x18000c497 <numba_list_iter_next+0xae7>
18000c495:     	xorb	%al, %al
18000c497:     	addq	$0x18, %rsp
18000c49b:     	retq
18000c49c:     	pushq	%rbx
18000c49e:     	subq	$0x20, %rsp
18000c4a2:     	movb	%cl, %bl
18000c4a4:     	callq	0x18000c81c <numba_list_iter_next+0xe6c>
18000c4a9:     	xorl	%edx, %edx
18000c4ab:     	testl	%eax, %eax
18000c4ad:     	je	0x18000c4ba <numba_list_iter_next+0xb0a>
18000c4af:     	testb	%bl, %bl
18000c4b1:     	jne	0x18000c4ba <numba_list_iter_next+0xb0a>
18000c4b3:     	xchgq	%rdx, 0x8556(%rip)      # 0x180014a10
18000c4ba:     	addq	$0x20, %rsp
18000c4be:     	popq	%rbx
18000c4bf:     	retq
18000c4c0:     	pushq	%rbx
18000c4c2:     	subq	$0x20, %rsp
18000c4c6:     	cmpb	$0x0, 0x854b(%rip)      # 0x180014a18
18000c4cd:     	movb	%cl, %bl
18000c4cf:     	je	0x18000c4d5 <numba_list_iter_next+0xb25>
18000c4d1:     	testb	%dl, %dl
18000c4d3:     	jne	0x18000c4e1 <numba_list_iter_next+0xb31>
18000c4d5:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c4da:     	movb	%bl, %cl
18000c4dc:     	callq	0x18000c86c <numba_list_iter_next+0xebc>
18000c4e1:     	movb	$0x1, %al
18000c4e3:     	addq	$0x20, %rsp
18000c4e7:     	popq	%rbx
18000c4e8:     	retq
18000c4e9:     	int3
18000c4ea:     	int3
18000c4eb:     	int3
18000c4ec:     	leaq	0x87e5(%rip), %rax      # 0x180014cd8
18000c4f3:     	retq
18000c4f4:     	movl	%ecx, %ecx
18000c4f6:     	int	$0x29
18000c4f8:     	retq
18000c4f9:     	int3
18000c4fa:     	int3
18000c4fb:     	int3
18000c4fc:     	movq	%rbx, 0x8(%rsp)
18000c501:     	pushq	%rdi
18000c502:     	subq	$0x20, %rsp
18000c506:     	leaq	0x403b(%rip), %rbx      # 0x180010548
18000c50d:     	leaq	0x4034(%rip), %rdi      # 0x180010548
18000c514:     	jmp	0x18000c528 <numba_list_iter_next+0xb78>
18000c516:     	movq	(%rbx), %rax
18000c519:     	testq	%rax, %rax
18000c51c:     	je	0x18000c524 <numba_list_iter_next+0xb74>
18000c51e:     	callq	*0xe0c(%rip)            # 0x18000d330
18000c524:     	addq	$0x8, %rbx
18000c528:     	cmpq	%rdi, %rbx
18000c52b:     	jb	0x18000c516 <numba_list_iter_next+0xb66>
18000c52d:     	movq	0x30(%rsp), %rbx
18000c532:     	addq	$0x20, %rsp
18000c536:     	popq	%rdi
18000c537:     	retq
18000c538:     	movq	%rbx, 0x8(%rsp)
18000c53d:     	pushq	%rdi
18000c53e:     	subq	$0x20, %rsp
18000c542:     	leaq	0x400f(%rip), %rbx      # 0x180010558
18000c549:     	leaq	0x4008(%rip), %rdi      # 0x180010558
18000c550:     	jmp	0x18000c564 <numba_list_iter_next+0xbb4>
18000c552:     	movq	(%rbx), %rax
18000c555:     	testq	%rax, %rax
18000c558:     	je	0x18000c560 <numba_list_iter_next+0xbb0>
18000c55a:     	callq	*0xdd0(%rip)            # 0x18000d330
18000c560:     	addq	$0x8, %rbx
18000c564:     	cmpq	%rdi, %rbx
18000c567:     	jb	0x18000c552 <numba_list_iter_next+0xba2>
18000c569:     	movq	0x30(%rsp), %rbx
18000c56e:     	addq	$0x20, %rsp
18000c572:     	popq	%rdi
18000c573:     	retq
18000c574:     	retq	$0x0
18000c577:     	int3
18000c578:     	movq	%rbx, 0x10(%rsp)
18000c57d:     	movq	%rbp, 0x18(%rsp)
18000c582:     	movq	%rsi, 0x20(%rsp)
18000c587:     	pushq	%rdi
18000c588:     	subq	$0x10, %rsp
18000c58c:     	xorl	%eax, %eax
18000c58e:     	xorl	%ecx, %ecx
18000c590:     	cpuid
18000c592:     	xorl	$0x6c65746e, %ecx       # imm = 0x6C65746E
18000c598:     	xorl	$0x49656e69, %edx       # imm = 0x49656E69
18000c59e:     	orl	%ecx, %edx
18000c5a0:     	movl	%eax, %ebp
18000c5a2:     	movl	$0x1, %eax
18000c5a7:     	xorl	$0x756e6547, %ebx       # imm = 0x756E6547
18000c5ad:     	orl	%ebx, %edx
18000c5af:     	leal	-0x1(%rax), %ecx
18000c5b2:     	cpuid
18000c5b4:     	movl	%ecx, %edi
18000c5b6:     	jne	0x18000c616 <numba_list_iter_next+0xc66>
18000c5b8:     	andl	$0xfff3ff0, %eax        # imm = 0xFFF3FF0
18000c5bd:     	movq	$0x8000, 0x7b90(%rip)   # imm = 0x8000
                                                # 0x180014158
18000c5c8:     	movq	$-0x1, 0x7b8d(%rip)     # 0x180014160
18000c5d3:     	cmpl	$0x106c0, %eax          # imm = 0x106C0
18000c5d8:     	je	0x18000c602 <numba_list_iter_next+0xc52>
18000c5da:     	cmpl	$0x20660, %eax          # imm = 0x20660
18000c5df:     	je	0x18000c602 <numba_list_iter_next+0xc52>
18000c5e1:     	cmpl	$0x20670, %eax          # imm = 0x20670
18000c5e6:     	je	0x18000c602 <numba_list_iter_next+0xc52>
18000c5e8:     	addl	$0xfffcf9b0, %eax       # imm = 0xFFFCF9B0
18000c5ed:     	cmpl	$0x20, %eax
18000c5f0:     	ja	0x18000c616 <numba_list_iter_next+0xc66>
18000c5f2:     	movabsq	$0x100010001, %rcx      # imm = 0x100010001
18000c5fc:     	btq	%rax, %rcx
18000c600:     	jae	0x18000c616 <numba_list_iter_next+0xc66>
18000c602:     	movl	0x844b(%rip), %r8d      # 0x180014a54
18000c609:     	orl	$0x1, %r8d
18000c60d:     	movl	%r8d, 0x8440(%rip)      # 0x180014a54
18000c614:     	jmp	0x18000c61d <numba_list_iter_next+0xc6d>
18000c616:     	movl	0x8437(%rip), %r8d      # 0x180014a54
18000c61d:     	xorl	%r9d, %r9d
18000c620:     	movl	%r9d, %r11d
18000c623:     	cmpl	$0x7, %ebp
18000c626:     	jl	0x18000c66a <numba_list_iter_next+0xcba>
18000c628:     	xorl	%ecx, %ecx
18000c62a:     	leal	0x7(%r9), %eax
18000c62e:     	cpuid
18000c630:     	movl	%edx, %esi
18000c632:     	movl	%ebx, %r10d
18000c635:     	btl	$0x9, %ebx
18000c639:     	jae	0x18000c646 <numba_list_iter_next+0xc96>
18000c63b:     	orl	$0x2, %r8d
18000c63f:     	movl	%r8d, 0x840e(%rip)      # 0x180014a54
18000c646:     	cmpl	$0x1, %eax
18000c649:     	jl	0x18000c658 <numba_list_iter_next+0xca8>
18000c64b:     	movl	$0x7, %eax
18000c650:     	leal	-0x6(%rax), %ecx
18000c653:     	cpuid
18000c655:     	movl	%edx, %r9d
18000c658:     	movl	$0x24, %eax
18000c65d:     	cmpl	%eax, %ebp
18000c65f:     	jl	0x18000c670 <numba_list_iter_next+0xcc0>
18000c661:     	xorl	%ecx, %ecx
18000c663:     	cpuid
18000c665:     	movl	%ebx, %r11d
18000c668:     	jmp	0x18000c670 <numba_list_iter_next+0xcc0>
18000c66a:     	movl	%r9d, %r10d
18000c66d:     	movl	%r9d, %esi
18000c670:     	movq	0x7af1(%rip), %rax      # 0x180014168
18000c677:     	andq	$-0x2, %rax
18000c67b:     	movl	$0x1, 0x7acb(%rip)      # 0x180014150
18000c685:     	movl	$0x2, 0x7ac5(%rip)      # 0x180014154
18000c68f:     	movq	%rax, 0x7ad2(%rip)      # 0x180014168
18000c696:     	btl	$0x14, %edi
18000c69a:     	jae	0x18000c6bb <numba_list_iter_next+0xd0b>
18000c69c:     	andq	$-0x11, %rax
18000c6a0:     	movl	$0x2, 0x7aa6(%rip)      # 0x180014150
18000c6aa:     	movq	%rax, 0x7ab7(%rip)      # 0x180014168
18000c6b1:     	movl	$0x6, 0x7a99(%rip)      # 0x180014154
18000c6bb:     	btl	$0x1b, %edi
18000c6bf:     	jae	0x18000c7fc <numba_list_iter_next+0xe4c>
18000c6c5:     	xorl	%ecx, %ecx
18000c6c7:     	xgetbv
18000c6ca:     	shlq	$0x20, %rdx
18000c6ce:     	orq	%rax, %rdx
18000c6d1:     	movq	%rdx, 0x20(%rsp)
18000c6d6:     	btl	$0x1c, %edi
18000c6da:     	jae	0x18000c7e0 <numba_list_iter_next+0xe30>
18000c6e0:     	movq	0x20(%rsp), %rax
18000c6e5:     	andb	$0x6, %al
18000c6e7:     	cmpb	$0x6, %al
18000c6e9:     	jne	0x18000c7e0 <numba_list_iter_next+0xe30>
18000c6ef:     	movl	0x7a5f(%rip), %eax      # 0x180014154
18000c6f5:     	movb	$-0x20, %dl
18000c6f7:     	orl	$0x8, %eax
18000c6fa:     	movl	$0x3, 0x7a4c(%rip)      # 0x180014150
18000c704:     	movl	%eax, 0x7a4a(%rip)      # 0x180014154
18000c70a:     	testb	$0x20, %r10b
18000c70e:     	je	0x18000c772 <numba_list_iter_next+0xdc2>
18000c710:     	orl	$0x20, %eax
18000c713:     	movl	$0x5, 0x7a33(%rip)      # 0x180014150
18000c71d:     	movl	%eax, 0x7a31(%rip)      # 0x180014154
18000c723:     	movl	$0xd0030000, %ecx       # imm = 0xD0030000
18000c728:     	movq	0x7a39(%rip), %rax      # 0x180014168
18000c72f:     	andl	%ecx, %r10d
18000c732:     	andq	$-0x3, %rax
18000c736:     	movq	%rax, 0x7a2b(%rip)      # 0x180014168
18000c73d:     	cmpl	%ecx, %r10d
18000c740:     	jne	0x18000c779 <numba_list_iter_next+0xdc9>
18000c742:     	movq	0x20(%rsp), %rax
18000c747:     	andb	%dl, %al
18000c749:     	cmpb	%dl, %al
18000c74b:     	jne	0x18000c772 <numba_list_iter_next+0xdc2>
18000c74d:     	movq	0x7a14(%rip), %rax      # 0x180014168
18000c754:     	orl	$0x40, 0x79f9(%rip)     # 0x180014154
18000c75b:     	andq	$-0x25, %rax
18000c75f:     	movl	$0x6, 0x79e7(%rip)      # 0x180014150
18000c769:     	movq	%rax, 0x79f8(%rip)      # 0x180014168
18000c770:     	jmp	0x18000c779 <numba_list_iter_next+0xdc9>
18000c772:     	movq	0x79ef(%rip), %rax      # 0x180014168
18000c779:     	btl	$0x17, %esi
18000c77d:     	jae	0x18000c78b <numba_list_iter_next+0xddb>
18000c77f:     	btrq	$0x18, %rax
18000c784:     	movq	%rax, 0x79dd(%rip)      # 0x180014168
18000c78b:     	btl	$0x13, %r9d
18000c790:     	jae	0x18000c7e0 <numba_list_iter_next+0xe30>
18000c792:     	movq	0x20(%rsp), %rax
18000c797:     	andb	%dl, %al
18000c799:     	cmpb	%dl, %al
18000c79b:     	jne	0x18000c7e0 <numba_list_iter_next+0xe30>
18000c79d:     	movq	0x79c4(%rip), %rdx      # 0x180014168
18000c7a4:     	movl	%r11d, %eax
18000c7a7:     	shrq	$0x10, %rax
18000c7ab:     	movl	%r11d, %ecx
18000c7ae:     	andl	$0x6, %eax
18000c7b1:     	andl	$0x400ff, %ecx          # imm = 0x400FF
18000c7b7:     	orq	$0x1000029, %rax        # imm = 0x1000029
18000c7bd:     	movl	%ecx, 0x8295(%rip)      # 0x180014a58
18000c7c3:     	notq	%rax
18000c7c6:     	andq	%rax, %rdx
18000c7c9:     	movq	%rdx, 0x7998(%rip)      # 0x180014168
18000c7d0:     	cmpb	$0x1, %cl
18000c7d3:     	jbe	0x18000c7e0 <numba_list_iter_next+0xe30>
18000c7d5:     	andq	$-0x41, %rdx
18000c7d9:     	movq	%rdx, 0x7988(%rip)      # 0x180014168
18000c7e0:     	btl	$0x15, %r9d
18000c7e5:     	jae	0x18000c7fc <numba_list_iter_next+0xe4c>
18000c7e7:     	movq	0x20(%rsp), %rax
18000c7ec:     	btq	$0x13, %rax
18000c7f1:     	jae	0x18000c7fc <numba_list_iter_next+0xe4c>
18000c7f3:     	btrq	$0x7, 0x796c(%rip)      # 0x180014168
18000c7fc:     	movq	0x28(%rsp), %rbx
18000c801:     	xorl	%eax, %eax
18000c803:     	movq	0x30(%rsp), %rbp
18000c808:     	movq	0x38(%rsp), %rsi
18000c80d:     	addq	$0x10, %rsp
18000c811:     	popq	%rdi
18000c812:     	retq
18000c813:     	int3
18000c814:     	movl	$0x1, %eax
18000c819:     	retq
18000c81a:     	int3
18000c81b:     	int3
18000c81c:     	xorl	%eax, %eax
18000c81e:     	cmpl	%eax, 0x794c(%rip)      # 0x180014170
18000c824:     	setne	%al
18000c827:     	retq
18000c828:     	int3
18000c829:     	int3
18000c82a:     	int3
18000c82b:     	int3
18000c82c:     	int3
18000c82d:     	int3
18000c82e:     	int3
18000c82f:     	int3
18000c830:     	jmpq	*0x812(%rip)            # 0x18000d048
18000c836:     	jmpq	*0x814(%rip)            # 0x18000d050
18000c83c:     	jmpq	*0x84e(%rip)            # 0x18000d090
18000c842:     	jmpq	*0x850(%rip)            # 0x18000d098
18000c848:     	jmpq	*0x852(%rip)            # 0x18000d0a0
18000c84e:     	jmpq	*0x854(%rip)            # 0x18000d0a8
18000c854:     	jmpq	*0x856(%rip)            # 0x18000d0b0
18000c85a:     	jmpq	*0x820(%rip)            # 0x18000d080
18000c860:     	jmpq	*0x852(%rip)            # 0x18000d0b8
18000c866:     	jmpq	*0x81c(%rip)            # 0x18000d088
18000c86c:     	movb	$0x1, %al
18000c86e:     	retq
18000c86f:     	int3
18000c870:     	xorl	%eax, %eax
18000c872:     	retq
18000c873:     	jmpq	*0x7bf(%rip)            # 0x18000d038
18000c879:     	jmpq	*0x7c1(%rip)            # 0x18000d040
18000c87f:     	jmpq	*0x843(%rip)            # 0x18000d0c8
18000c885:     	jmpq	*0x845(%rip)            # 0x18000d0d0
18000c88b:     	int3
18000c88c:     	int3
18000c88d:     	int3
18000c88e:     	int3
18000c88f:     	int3
18000c890:     	int3
18000c891:     	int3
18000c892:     	int3
18000c893:     	int3
18000c894:     	int3
18000c895:     	int3
18000c896:     	nopw	(%rax,%rax)
18000c8a0:     	jmpq	*%rax
18000c8a2:     	int3
18000c8a3:     	int3
18000c8a4:     	int3
18000c8a5:     	int3
18000c8a6:     	int3
18000c8a7:     	int3
18000c8a8:     	int3
18000c8a9:     	int3
18000c8aa:     	int3
18000c8ab:     	int3
18000c8ac:     	int3
18000c8ad:     	int3
18000c8ae:     	int3
18000c8af:     	int3
18000c8b0:     	int3
18000c8b1:     	int3
18000c8b2:     	int3
18000c8b3:     	int3
18000c8b4:     	int3
18000c8b5:     	int3
18000c8b6:     	nopw	(%rax,%rax)
18000c8c0:     	jmpq	*0xa6a(%rip)            # 0x18000d330
18000c8c6:     	pushq	%rbp
18000c8c8:     	subq	$0x20, %rsp
18000c8cc:     	movq	%rdx, %rbp
18000c8cf:     	movb	0x40(%rbp), %cl
18000c8d2:     	addq	$0x20, %rsp
18000c8d6:     	popq	%rbp
18000c8d7:     	jmp	0x18000c49c <numba_list_iter_next+0xaec>
18000c8dc:     	int3
18000c8dd:     	pushq	%rbp
18000c8df:     	subq	$0x20, %rsp
18000c8e3:     	movq	%rdx, %rbp
18000c8e6:     	movb	0x20(%rbp), %cl
18000c8e9:     	callq	0x18000c49c <numba_list_iter_next+0xaec>
18000c8ee:     	nop
18000c8ef:     	addq	$0x20, %rsp
18000c8f3:     	popq	%rbp
18000c8f4:     	retq
18000c8f5:     	int3
18000c8f6:     	pushq	%rbp
18000c8f8:     	subq	$0x20, %rsp
18000c8fc:     	movq	%rdx, %rbp
18000c8ff:     	addq	$0x20, %rsp
18000c903:     	popq	%rbp
18000c904:     	jmp	0x18000c328 <numba_list_iter_next+0x978>
18000c909:     	int3
18000c90a:     	pushq	%rbp
18000c90c:     	subq	$0x30, %rsp
18000c910:     	movq	%rdx, %rbp
18000c913:     	movq	(%rcx), %rax
18000c916:     	movl	(%rax), %edx
18000c918:     	movq	%rcx, 0x28(%rsp)
18000c91d:     	movl	%edx, 0x20(%rsp)
18000c921:     	leaq	-0xbc8(%rip), %r9       # 0x18000bd60 <numba_list_iter_next+0x3b0>
18000c928:     	movq	0x70(%rbp), %r8
18000c92c:     	movl	0x68(%rbp), %edx
18000c92f:     	movq	0x60(%rbp), %rcx
18000c933:     	callq	0x18000c298 <numba_list_iter_next+0x8e8>
18000c938:     	nop
18000c939:     	addq	$0x30, %rsp
18000c93d:     	popq	%rbp
18000c93e:     	retq
18000c93f:     	int3
18000c940:     	pushq	%rbp
18000c942:     	movq	%rdx, %rbp
18000c945:     	movq	(%rcx), %rax
18000c948:     	xorl	%ecx, %ecx
18000c94a:     	cmpl	$0xc0000005, (%rax)     # imm = 0xC0000005
18000c950:     	sete	%cl
18000c953:     	movl	%ecx, %eax
18000c955:     	popq	%rbp
18000c956:     	retq
18000c957:     	int3
